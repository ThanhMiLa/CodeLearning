package com.thanhmila.codelearning.service.oj;

import com.thanhmila.codelearning.dto.judge0.*;
import com.thanhmila.codelearning.dto.request.OjSubmissionRequest;
import com.thanhmila.codelearning.dto.response.OjSubmissionInitialResponse;
import com.thanhmila.codelearning.dto.response.OjWebSocketMessage;
import com.thanhmila.codelearning.entity.enums.OjVerdict;
import com.thanhmila.codelearning.entity.oj.OnlineJudgeSubmissionDetailEntity;
import com.thanhmila.codelearning.entity.oj.OnlineJudgeSubmissionEntity;
import com.thanhmila.codelearning.entity.oj.ProblemTestcaseEntity;
import com.thanhmila.codelearning.exception.AppException;
import com.thanhmila.codelearning.exception.ErrorCode;
import com.thanhmila.codelearning.repository.contest.ContestRepository;
import com.thanhmila.codelearning.repository.lesson.LessonRepository;
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
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
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

    Judge0ClientService judge0ClientService;
    SimpMessagingTemplate simpMessagingTemplate;

    @NonFinal
    @Value("${app.webhook-base-url}")
    String webhookBaseUrl;

    @Transactional
    public OjSubmissionInitialResponse submitCode(OjSubmissionRequest request, Long userId) {
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

        for (ProblemTestcaseEntity testcase : problemTestcaseEntityList) {
            Judge0SubmissionItem item = Judge0SubmissionItem.builder()
                    .languageId(request.getLanguageId())
                    .sourceCode(request.getSourceCode())
                    .stdin(testcase.getInputData())
                    .expectedOutput(testcase.getExpectedOutput())
                    .callbackUrl(callbackUrl)
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

        // Tìm Testcase dựa trên Token
        OnlineJudgeSubmissionDetailEntity submissionDetail = onlineJudgeSubmissionDetailRepository
                .findByToken(judge0CallbackPayload.getToken())
                .orElseThrow(() -> new AppException(ErrorCode.JUDGE0_SUBMISSION_FAILED));

        // Lấy thông tin bài nộp (Submission cha)
        OnlineJudgeSubmissionEntity submissionEntity = onlineJudgeSubmissionRepository
                .findByIdWithLock(submissionDetail.getSubmission().getId())
                .orElseThrow(() -> new AppException(ErrorCode.SUBMISSION_NOT_FOUND));

        // Chuyển đổi trạng thái từ Judge0 sang hệ thống của mình
        OjVerdict testcaseVerdict = mapJudge0StatusToOjVerdict(judge0CallbackPayload.getStatus().getId());

        // Cập nhật kết quả cho Testcase (Detail)
        submissionDetail.setVerdict(testcaseVerdict);
        submissionDetail.setExecutionTimeMs(parseExecutionTime(judge0CallbackPayload.getTime()));
        submissionDetail.setMemoryUsedKb(judge0CallbackPayload.getMemory());
        onlineJudgeSubmissionDetailRepository.save(submissionDetail);

        // Kiểm tra xem ĐÃ CHẤM XONG HẾT CHƯA?
        Long submissionId = submissionEntity.getId();
        SubmissionCountDto submissionCountDto = onlineJudgeSubmissionDetailRepository
                .countTestcasesStatus(submissionId);

        boolean isFinish = submissionCountDto.totalTestcases().equals(submissionCountDto.processedTestcases());
        OjVerdict overallVerdict = OjVerdict.PENDING;

        if (isFinish) {
            // Đã chấm xong tất cả Testcase -> Tìm lỗi đầu tiên (nếu có)
            overallVerdict = onlineJudgeSubmissionDetailRepository
                    .findFirstBySubmissionIdAndVerdictNotOrderByTestcaseOrderIndexAsc(submissionId, OjVerdict.ACCEPTED)
                    .map(OnlineJudgeSubmissionDetailEntity::getVerdict)
                    .orElse(OjVerdict.ACCEPTED);

            // Cập nhật trạng thái tổng của Submission
            submissionEntity.setVerdict(overallVerdict);
            onlineJudgeSubmissionRepository.save(submissionEntity);
        }

        // Gửi thông báo WebSocket CHỈ ở chế độ Luyện tập (Practice)
        // Chế độ Thi đấu (Contest): ĐỌC ĐOC, không bắn WebSocket lẻ tẻ để ém kết quả
        boolean isContestMode = submissionEntity.getContest() != null;

        OjWebSocketMessage wsMessage = OjWebSocketMessage.builder()
                .submissionId(submissionId)
                .testcaseId(submissionDetail.getTestcase().getId())
                .testcaseVerdict(testcaseVerdict)
                .overallVerdict(overallVerdict)
                .executionTimeMs(submissionDetail.getExecutionTimeMs())
                .memoryUsedKb(submissionDetail.getMemoryUsedKb())
                .totalTestcases(submissionCountDto.totalTestcases().intValue())
                .processedTestcases(submissionCountDto.processedTestcases().intValue())
                .build();

        // RẼ NHÁNH GỬI WEBSOCKET
        if (!isContestMode) {
            // CHẾ ĐỘ LUYỆN TẬP (PRACTICE): Chấm xong testcase nào, bắn ngay testcase đó để chạy Progress Bar
            simpMessagingTemplate.convertAndSend("/topic/submissions/" + submissionEntity.getUser().getId(), wsMessage);
            log.info("PRACTICE MODE: Bắn WebSocket tiến trình {}/{} cho Submission {}",
                    wsMessage.getProcessedTestcases(), wsMessage.getTotalTestcases(), submissionId);

        } else if (isFinish) {
            // CHẾ ĐỘ THI ĐẤU (CONTEST): Ém kết quả lẻ. CHỈ BẮN 1 LẦN DUY NHẤT khi đã chấm
            // xong toàn bộ
            // (Tùy chọn) Giấu thông tin testcase cuối cùng để bảo mật Contest
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

}
