package com.thanhmila.codelearning.service.oj;

import com.thanhmila.codelearning.dto.judge0.*;
import com.thanhmila.codelearning.dto.request.OjSubmissionRequest;
import com.thanhmila.codelearning.dto.response.OjSubmissionInitialResponse;
import com.thanhmila.codelearning.dto.response.OjWebSocketMessage;
import com.thanhmila.codelearning.entity.enums.OjVerdict;
import com.thanhmila.codelearning.entity.oj.OnlineJudgeProblemEntity;
import com.thanhmila.codelearning.entity.oj.OnlineJudgeSubmissionDetailEntity;
import com.thanhmila.codelearning.entity.oj.OnlineJudgeSubmissionEntity;
import com.thanhmila.codelearning.entity.oj.ProblemTestcaseEntity;
import com.thanhmila.codelearning.entity.user.UserEntity;
import com.thanhmila.codelearning.exception.AppException;
import com.thanhmila.codelearning.exception.ErrorCode;
import com.thanhmila.codelearning.repository.contest.ContestRepository;
import com.thanhmila.codelearning.repository.contest.ContestProblemRepository;
import com.thanhmila.codelearning.repository.lesson.LessonRepository;
import com.thanhmila.codelearning.repository.lesson.LessonProblemRepository;
import com.thanhmila.codelearning.repository.oj.OnlineJudgeProblemRepository;
import com.thanhmila.codelearning.repository.oj.OnlineJudgeSubmissionDetailRepository;
import com.thanhmila.codelearning.repository.oj.OnlineJudgeSubmissionRepository;
import com.thanhmila.codelearning.repository.oj.ProblemTestcaseRepository;
import com.thanhmila.codelearning.repository.user.UserRepository;
import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Value;
import lombok.experimental.FieldDefaults;
import lombok.experimental.NonFinal;
import lombok.extern.slf4j.Slf4j;
import org.springframework.data.redis.core.StringRedisTemplate;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.Duration;
import java.util.ArrayList;
import java.util.List;

@Slf4j
@Service
@RequiredArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE, makeFinal = true)
public class OjSubmissionService {
    OnlineJudgeSubmissionRepository onlineJudgeSubmissionRepository;
    OnlineJudgeSubmissionDetailRepository onlineJudgeSubmissionDetailRepository;
    ProblemTestcaseRepository problemTestcaseRepository;
    UserRepository userRepository;
    OnlineJudgeProblemRepository onlineJudgeProblemRepository;
    LessonRepository lessonRepository;
    ContestRepository contestRepository;
    ContestProblemRepository contestProblemRepository;
    LessonProblemRepository lessonProblemRepository;

    Judge0ClientService judge0ClientService;
    SimpMessagingTemplate simpMessagingTemplate;

    StringRedisTemplate stringRedisTemplate;

    @NonFinal
    @Value("${app.webhook-base-url}")
    String webhookBaseUrl;

    @Transactional
    public OjSubmissionInitialResponse submitCode(OjSubmissionRequest request, Long userId) {
        // Check user status
        UserEntity user = userRepository.findById(userId)
                .orElseThrow(() -> new AppException(ErrorCode.USER_NOT_FOUND));
        user.validateStatus();

        OnlineJudgeProblemEntity ojProblem = onlineJudgeProblemRepository.findByIdAndIsPublicTrue(request.getProblemId())
                .orElseThrow(() -> new AppException(ErrorCode.OJ_PROBLEM_NOT_FOUND));
        
        // Xác thực bài toán có thuộc cuộc thi hoặc bài học không
        if (request.getContestId() != null) {
            boolean belongsToContest = contestProblemRepository.existsByContestIdAndProblemId(request.getContestId(), request.getProblemId());
            if (!belongsToContest) {
                throw new AppException(ErrorCode.OJ_PROBLEM_NOT_FOUND);
            }
        }
        
        if (request.getLessonId() != null) {
            boolean belongsToLesson = lessonProblemRepository.existsByLessonIdAndProblemId(request.getLessonId(), request.getProblemId());
            if (!belongsToLesson) {
                throw new AppException(ErrorCode.OJ_PROBLEM_NOT_FOUND);
            }
        }
        
        // Kiểm tra bài toán và lấy danh sách Testcases từ Database
        List<ProblemTestcaseEntity> problemTestcaseEntityList = problemTestcaseRepository
                .findByProblemIdOrderByOrderIndex(request.getProblemId());
        if (problemTestcaseEntityList.isEmpty()) {
            throw new AppException(ErrorCode.TESTCASE_NOT_FOUND);
        }

        // Tạo bản ghi "Mẹ" (OnlineJudgeSubmissionEntity) với trạng thái mặc định là
        // PENDING
        OnlineJudgeSubmissionEntity onlineJudgeSubmissionEntity = OnlineJudgeSubmissionEntity.builder()
                .user(userRepository.getReferenceById(userId))
                .problem(onlineJudgeProblemRepository.getReferenceById(request.getProblemId()))
                .languageId(request.getLanguageId())
                .sourceCode(request.getSourceCode())
                .verdict(OjVerdict.PENDING)
                .lesson(request.getLessonId() != null ? lessonRepository.getReferenceById(request.getLessonId()) : null)
                .contest(request.getContestId() != null ? contestRepository.getReferenceById(request.getContestId())
                        : null)
                .build();

        // Đóng gói dữ liệu (Code + Testcases) để gửi sang Judge0
        List<Judge0SubmissionItem> judge0SubmissionItemList = new ArrayList<>();
        String callbackUrl = webhookBaseUrl + "/online-judge/submissions";

        // Tính limit dựa trên ngôn ngữ (Gợi ý dùng hệ số nhân)
        double timeLimitSeconds = calculateTimeLimitForLanguage(onlineJudgeSubmissionEntity.getProblem().getTimeLimitMs(), request.getLanguageId());

        for (ProblemTestcaseEntity testcase : problemTestcaseEntityList) {
            Judge0SubmissionItem item = Judge0SubmissionItem.builder()
                    .languageId(request.getLanguageId())
                    .sourceCode(request.getSourceCode())
                    .stdin(testcase.getInputData())
                    .expectedOutput(testcase.getExpectedOutput())
                    .callbackUrl(callbackUrl)
                    .cpuTimeLimit(timeLimitSeconds)
                    .memoryLimit(onlineJudgeSubmissionEntity.getProblem().getMemoryLimitKb())
                    .build();
            judge0SubmissionItemList.add(item);
        }

        Judge0BatchRequest judge0BatchRequest = Judge0BatchRequest.builder()
                .submissions(judge0SubmissionItemList)
                .build();

        // Gọi API Judge0 (Giai đoạn giao tiếp mạng)
        List<Judge0TokenResponse> tokenList = judge0ClientService.sendBatchSubmission(judge0BatchRequest);

        // Đảm bảo Judge0 trả về số lượng token khớp với số lượng testcase
        if (tokenList.isEmpty() || tokenList.size() != problemTestcaseEntityList.size()) {
            throw new AppException(ErrorCode.JUDGE0_SUBMISSION_FAILED);
        }

        // Lưu submission "mẹ" trước để có ID cho các chi tiết
        onlineJudgeSubmissionRepository.save(onlineJudgeSubmissionEntity);

        // Tạo bản ghi "Con" (OnlineJudgeSubmissionDetailEntity) cho từng testcase
        List<OnlineJudgeSubmissionDetailEntity> submissionDetails = new ArrayList<>();
        for (int i = 0; i < tokenList.size(); i++) {
            OnlineJudgeSubmissionDetailEntity detailEntity = OnlineJudgeSubmissionDetailEntity.builder()
                    .submission(onlineJudgeSubmissionEntity)
                    .testcase(problemTestcaseEntityList.get(i))
                    .token(tokenList.get(i).getToken())
                    .verdict(OjVerdict.PENDING)
                    .build();
            submissionDetails.add(detailEntity);
        }
        onlineJudgeSubmissionDetailRepository.saveAll(submissionDetails);

        // Trả về Response cho Frontend ngay lập tức
        return OjSubmissionInitialResponse.builder()
                .submissionId(onlineJudgeSubmissionEntity.getId())
                .status(OjVerdict.PENDING.toString())
                .message("Submission received and is being processed.")
                .build();

    }

    @Transactional
    public void processJudge0Callback(Judge0CallbackPayload judge0CallbackPayload) {

        // Lấy thông tin SubmissionDetail (bao gồm luôn Submission cha và Problem nhờ JOIN FETCH)
        OnlineJudgeSubmissionDetailEntity submissionDetail = onlineJudgeSubmissionDetailRepository
                .findByTokenWithSubmissionAndProblem(judge0CallbackPayload.getToken())
                .orElseThrow(() -> new AppException(ErrorCode.JUDGE0_SUBMISSION_FAILED));

        // Không cần truy vấn tìm Submission nữa vì đã JOIN FETCH ở trên
        OnlineJudgeSubmissionEntity submissionEntity = submissionDetail.getSubmission();

        // Chuyển đổi trạng thái từ Judge0 sang hệ thống của mình
        OjVerdict testcaseVerdict = mapJudge0StatusToOjVerdict(judge0CallbackPayload.getStatus().getId());

        // Cập nhật kết quả cho SubmissionDetail (Submission Con)
        submissionDetail.setVerdict(testcaseVerdict);
        submissionDetail.setExecutionTimeMs(parseExecutionTime(judge0CallbackPayload.getTime()));
        submissionDetail.setMemoryUsedKb(judge0CallbackPayload.getMemory());
        onlineJudgeSubmissionDetailRepository.save(submissionDetail);

        // Kiểm tra xem ĐÃ CHẤM XONG HẾT CHƯA?
        Long submissionId = submissionEntity.getId();
        Integer totalTestcases = submissionEntity.getProblem().getTotalTestCase();
        boolean isContestMode = submissionEntity.getContest() != null;

        // ==========================================
        // 3. LOGIC REDIS ATOMIC COUNTER & SHORT-CIRCUIT
        // ==========================================
        String redisKey = "oj_progress:" + submissionId;
        String failedKey = "oj_failed:" + submissionId; // Cờ đánh dấu đã có testcase sai
        
        boolean isEarlyFinish = false;
        
        // SHORT-CIRCUIT (CONTEST MODE): Chốt sổ ngay lập tức nếu gặp testcase sai đầu tiên!
        if (isContestMode && testcaseVerdict != OjVerdict.ACCEPTED) {
            // setIfAbsent đảm bảo chỉ có 1 luồng duy nhất (lỗi đầu tiên) được quyền chốt sổ
            Boolean isFirstFail = stringRedisTemplate.opsForValue().setIfAbsent(failedKey, "1", Duration.ofHours(1));
            if (Boolean.TRUE.equals(isFirstFail)) {
                isEarlyFinish = true;
            }
        }

        Long processedCount = stringRedisTemplate.opsForValue().increment(redisKey);

        // Đặt TTL 1 tiếng cho lần đếm đầu tiên đề phòng Judge0 chết giữa chừng
        if(processedCount != null && processedCount == 1L) {
            stringRedisTemplate.expire(redisKey, Duration.ofHours(1));
        }

        // Chấm xong bình thường: Đủ testcase VÀ chưa từng bị chốt sổ sớm (short-circuit)
        boolean isNormalFinish = processedCount.equals(totalTestcases.longValue()) 
                                && Boolean.FALSE.equals(stringRedisTemplate.hasKey(failedKey));

        // Khởi tạo overallVerdict (mặc định là PENDING)
        OjVerdict overallVerdict = OjVerdict.PENDING;

        if (isEarlyFinish || isNormalFinish) {
            if (isEarlyFinish) {
                overallVerdict = testcaseVerdict; // Chốt ngay kết quả lỗi hiện tại
            } else {
                // Đã chấm xong tất cả Testcase bình thường -> Tìm lỗi đầu tiên (nếu có)
                overallVerdict = onlineJudgeSubmissionDetailRepository
                        .findFirstBySubmissionIdAndVerdictNotOrderByTestcaseOrderIndexAsc(submissionId, OjVerdict.ACCEPTED)
                        .map(OnlineJudgeSubmissionDetailEntity::getVerdict)
                        .orElse(OjVerdict.ACCEPTED);
            }

            // Lấy thời gian và bộ nhớ sử dụng tối đa (tính đến thời điểm hiện tại)
            var maxStats = onlineJudgeSubmissionDetailRepository.findMaxStatsBySubmissionId(submissionId)
                    .orElseThrow(() -> new AppException(ErrorCode.SUBMISSION_NOT_FOUND));

            // Cập nhật trạng thái, thời gian, bộ nhớ tổng của Submission và lưu vào DB
            submissionEntity.setVerdict(overallVerdict);
            submissionEntity.setExecutionTimeMs(maxStats.getMaxTime());
            submissionEntity.setMemoryUsedKb(maxStats.getMaxMemory());
            onlineJudgeSubmissionRepository.save(submissionEntity);
        }
        
        // HIỆU SUẤT: Luôn dọn dẹp key Redis giải phóng RAM khi tất cả webhook đã về đủ
        if (processedCount != null && processedCount.equals(totalTestcases.longValue())) {
            stringRedisTemplate.delete(redisKey);
            stringRedisTemplate.delete(failedKey);
        }

        OjWebSocketMessage wsMessage = OjWebSocketMessage.builder()
                .submissionId(submissionId)
                .testcaseId(submissionDetail.getTestcase().getId())
                .testcaseVerdict(testcaseVerdict)
                .overallVerdict(overallVerdict)
                // Nếu đã chốt sổ (Early hoặc Normal), gửi MAX time/memory. Nếu chưa, gửi time/memory hiện tại
                .executionTimeMs((isEarlyFinish || isNormalFinish) ? submissionEntity.getExecutionTimeMs() : submissionDetail.getExecutionTimeMs())
                .memoryUsedKb((isEarlyFinish || isNormalFinish) ? submissionEntity.getMemoryUsedKb() : submissionDetail.getMemoryUsedKb())
                .totalTestcases(totalTestcases)
                .processedTestcases(processedCount.intValue())
                .build();

        // RẼ NHÁNH GỬI WEBSOCKET
        if (!isContestMode) {
            // CHẾ ĐỘ LUYỆN TẬP (PRACTICE): Chấm xong testcase nào, bắn ngay testcase đó để chạy Progress Bar
            simpMessagingTemplate.convertAndSend("/topic/submissions/" + submissionEntity.getUser().getId(), wsMessage);
            log.info("PRACTICE MODE: Bắn WebSocket tiến trình {}/{} cho Submission {}",
                    wsMessage.getProcessedTestcases(), wsMessage.getTotalTestcases(), submissionId);

        } else if (isEarlyFinish || isNormalFinish) {
            // CHẾ ĐỘ THI ĐẤU (CONTEST): ĐỌC ĐOC, không bắn lẻ tẻ. 
            // CHỈ BẮN 1 LẦN DUY NHẤT khi chốt sổ (Short-circuit sớm HOẶC chấm xong toàn bộ)
            wsMessage.setTestcaseId(null);
            wsMessage.setTestcaseVerdict(null);

            simpMessagingTemplate.convertAndSend("/topic/submissions/" + submissionEntity.getUser().getId(), wsMessage);
            log.info("CONTEST MODE: Đã chấm xong toàn bộ. Bắn WebSocket tổng kết (Verdict: {}) cho Submission {}",
                    overallVerdict, submissionId);
        } else {
            // Đang chấm dở dang trong Contest -> Im lặng
            log.info("CONTEST MODE: Đang chấm testcase lẻ (Submission {}). Bỏ qua bắn WebSocket để bảo mật.",
                    submissionId);
        }
    }

    // --- Hàm bổ trợ ---
    private OjVerdict mapJudge0StatusToOjVerdict(Integer judge0StatusId) {
        return switch (judge0StatusId) {
            case 3 -> OjVerdict.ACCEPTED;
            case 4 -> OjVerdict.WRONG_ANSWER;
            case 5 -> OjVerdict.TIME_LIMIT_EXCEEDED;
            case 6 -> OjVerdict.COMPILATION_ERROR;
            // Map thêm các trạng thái khác (Runtime Error, Memory Limit...)
            default -> OjVerdict.RUNTIME_ERROR;
        };
    }

    private Integer parseExecutionTime(String timeStr) {
        // Judge0 trả về time dạng string ví dụ "0.045" (giây)
        if (timeStr == null)
            return 0;
        try {
            return (int) (Double.parseDouble(timeStr) * 1000); // Chuyển sang mili-giây
        } catch (NumberFormatException e) {
            return 0;
        }
    }

    private double calculateTimeLimitForLanguage(Integer baseTimeMs, Integer languageId) {
        if (baseTimeMs == null) {
            return 2.0; // Default fallback to 2 seconds if null
        }
        double baseSec = baseTimeMs / 1000.0;
        return switch (languageId) {
            // C, C++ & Golang (compiled languages, extremely fast execution)
            case 48, 49, 50, 75, 52, 53, 54, 76, 60 -> baseSec;
            
            // Java & C# (VM/CLR-based, needs JVM/Mono startup overhead buffer)
            case 62, 51 -> baseSec * 2.0 + 1.0;
            
            // JavaScript & TypeScript (Node.js JIT startup overhead)
            case 63, 74 -> baseSec * 2.0;
            
            // Python (interpreted, slower execution speed)
            case 70, 71 -> baseSec * 3.0;
            
            // Default fallback to base time
            default -> baseSec;
        };
    }

}
