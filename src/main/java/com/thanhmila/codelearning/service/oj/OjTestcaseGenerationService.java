package com.thanhmila.codelearning.service.oj;

import com.thanhmila.codelearning.dto.judge0.Judge0BatchRequest;
import com.thanhmila.codelearning.dto.judge0.Judge0CallbackPayload;
import com.thanhmila.codelearning.dto.judge0.Judge0SubmissionItem;
import com.thanhmila.codelearning.dto.judge0.Judge0TokenResponse;
import com.thanhmila.codelearning.dto.request.GenerateTestcaseRequest;
import com.thanhmila.codelearning.dto.response.OjTestcaseGenWsMessage;
import com.thanhmila.codelearning.dto.response.OjWebSocketMessage;
import com.thanhmila.codelearning.entity.oj.OnlineJudgeProblemEntity;
import com.thanhmila.codelearning.entity.oj.ProblemTestcaseEntity;
import com.thanhmila.codelearning.exception.AppException;
import com.thanhmila.codelearning.exception.ErrorCode;
import com.thanhmila.codelearning.repository.oj.OnlineJudgeProblemRepository;
import com.thanhmila.codelearning.repository.oj.ProblemTestcaseRepository;
import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import lombok.experimental.NonFinal;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.data.redis.core.StringRedisTemplate;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.Duration;
import java.util.ArrayList;
import java.util.List;
import java.util.Base64;

@Slf4j
@Service
@RequiredArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE, makeFinal = true)
public class OjTestcaseGenerationService {

    OnlineJudgeProblemRepository onlineJudgeProblemRepository;
    ProblemTestcaseRepository problemTestcaseRepository;
    Judge0ClientService judge0ClientService;
    StringRedisTemplate stringRedisTemplate;
    SimpMessagingTemplate simpMessagingTemplate;

    @NonFinal
    @Value("${app.webhook-base-url}")
    String webhookBaseUrl;

    final int PYTHON_LANGUAGE_ID = 71;
    final int C_PLUS_PLUS_LANGUAGE_ID = 76;

    // Pha 1: Nhận yêu cầu và gửi Batch sinh Input
    @Transactional
    public void generateTestcases(Long problemId, GenerateTestcaseRequest request) {
        OnlineJudgeProblemEntity problem = onlineJudgeProblemRepository.findById(problemId)
                .orElseThrow(() -> new AppException(ErrorCode.OJ_PROBLEM_NOT_FOUND));

        problem.setIsActive(false); // Ẩn bài toán trong quá trình sinh
        onlineJudgeProblemRepository.save(problem);

        // Xóa testcase cũ nếu có
        problemTestcaseRepository.deleteByProblemId(problemId);

        // Lưu tạm solutionCode vào Redis để Pha 3 sử dụng
        stringRedisTemplate.opsForValue().set("gen_solution_code:" + problemId, request.getSolutionCode(), Duration.ofHours(1));
        // Reset counter
        stringRedisTemplate.delete("gen_input_progress:" + problemId);
        stringRedisTemplate.delete("gen_output_progress:" + problemId);

        List<ProblemTestcaseEntity> newTestcases = new ArrayList<>();
        List<Judge0SubmissionItem> items = new ArrayList<>();
        String callbackUrl = webhookBaseUrl + "/online-judge/webhooks/generate-inputs";

        int total = request.getTotalTestcasesToGenerate();
        for (int i = 1; i <= total; i++) {
            newTestcases.add(ProblemTestcaseEntity.builder()
                    .problem(problem)
                    .orderIndex(i)
                    .isHidden(i > 2) // Giả sử hiển thị 2 testcase đầu
                    .build());

            items.add(Judge0SubmissionItem.builder()
                    .languageId(PYTHON_LANGUAGE_ID)
                    .sourceCode(request.getGeneratorCode())
                    .callbackUrl(callbackUrl)
                    .cpuTimeLimit(5.0)
                    .memoryLimit(128000)
                    .build());
        }

        // Gửi qua Judge0
        Judge0BatchRequest batchRequest = new Judge0BatchRequest();
        batchRequest.setSubmissions(items);
        List<Judge0TokenResponse> tokens = judge0ClientService.sendBatchSubmission(batchRequest);

        // Lưu tokens vào db
        for (int i = 0; i < total; i++) {
            newTestcases.get(i).setToken(tokens.get(i).getToken());
        }
        problemTestcaseRepository.saveAll(newTestcases);

        log.info("Phase 1: Sent {} input generation requests for problem {}", total, problemId);
    }

    // Pha 2: Webhook nhận Input
    @Transactional
    public void processInputWebhook(Judge0CallbackPayload payload) {
        ProblemTestcaseEntity testcase = problemTestcaseRepository.findByToken(payload.getToken())
                .orElse(null);
        if (testcase == null) return;

        Long problemId = testcase.getProblem().getId();
        String decodedStdout = decodeBase64(payload.getStdout());
        testcase.setInputData(decodedStdout);
        problemTestcaseRepository.save(testcase);

        Long progress = stringRedisTemplate.opsForValue().increment("gen_input_progress:" + problemId);
        Long total = (long) problemTestcaseRepository.countByProblemId(problemId);

        if (progress != null && progress.equals(total)) {
            log.info("Phase 2 complete for problem {}. Starting Phase 3 (Outputs)", problemId);
            startOutputGeneration(problemId, total);
        }
    }

    // Pha 3: Gửi Batch sinh Output
    private void startOutputGeneration(Long problemId, Long totalTestcases) {
        String solutionCode = stringRedisTemplate.opsForValue().get("gen_solution_code:" + problemId);
        if (solutionCode == null) {
            log.error("Solution code not found in Redis for problem {}", problemId);
            return;
        }

        List<ProblemTestcaseEntity> testcases = problemTestcaseRepository.findByProblemIdOrderByOrderIndex(problemId);
        List<Judge0SubmissionItem> items = new ArrayList<>();
        String callbackUrl = webhookBaseUrl + "/online-judge/webhooks/generate-outputs";

        for (ProblemTestcaseEntity testcase : testcases) {
            items.add(Judge0SubmissionItem.builder()
                    .languageId(PYTHON_LANGUAGE_ID)
                    .sourceCode(solutionCode)
                    .stdin(testcase.getInputData())
                    .callbackUrl(callbackUrl)
                    .cpuTimeLimit(5.0)
                    .memoryLimit(128000)
                    .build());
        }

        Judge0BatchRequest batchRequest = new Judge0BatchRequest();
        batchRequest.setSubmissions(items);
        List<Judge0TokenResponse> tokens = judge0ClientService.sendBatchSubmission(batchRequest);

        for (int i = 0; i < testcases.size(); i++) {
            testcases.get(i).setToken(tokens.get(i).getToken());
        }
        problemTestcaseRepository.saveAll(testcases);

        log.info("Phase 3: Sent {} output generation requests for problem {}", testcases.size(), problemId);
    }

    // Pha 4: Webhook nhận Output
    @Transactional
    public void processOutputWebhook(Judge0CallbackPayload payload) {
        log.info("Output Webhook Status: {} | Stdout: {} | Stderr: {} | Compile: {}",
                payload.getStatus() != null ? payload.getStatus().getDescription() : "N/A",
                payload.getStdout(),
                payload.getStderr(),
                payload.getCompileOutput());

        ProblemTestcaseEntity testcase = problemTestcaseRepository.findByToken(payload.getToken())
                .orElse(null);
        if (testcase == null) return;

        Long problemId = testcase.getProblem().getId();
        String decodedStdout = decodeBase64(payload.getStdout());
        testcase.setExpectedOutput(decodedStdout);
        problemTestcaseRepository.save(testcase);

        Long progress = stringRedisTemplate.opsForValue().increment("gen_output_progress:" + problemId);
        Long total = (long) problemTestcaseRepository.countByProblemId(problemId);

        if (progress != null && progress.equals(total)) {
            log.info("Phase 4 complete for problem {}. All testcases generated.", problemId);
            
            OnlineJudgeProblemEntity problem = testcase.getProblem();
            problem.setIsActive(true);
            problem.setTotalTestCase(total.intValue());
            onlineJudgeProblemRepository.save(problem);

            // Cleanup Redis
            stringRedisTemplate.delete("gen_input_progress:" + problemId);
            stringRedisTemplate.delete("gen_output_progress:" + problemId);
            stringRedisTemplate.delete("gen_solution_code:" + problemId);

            // Bắn WebSocket báo hoàn tất 100%
            OjTestcaseGenWsMessage wsMessage = OjTestcaseGenWsMessage.builder()
                    .type("TESTCASE_GENERATION_COMPLETED")
                    .status("COMPLETED")
                    .message("Tạo testcase thành công cho bài toán")
                    .build();
            simpMessagingTemplate.convertAndSend("/topic/testcase-generation/" + problemId, wsMessage);
        }
    }

    private String decodeBase64(String encoded) {
        if (encoded == null || encoded.isEmpty()) return "";
        try {
            return new String(Base64.getDecoder().decode(encoded.trim()));
        } catch (Exception e) {
            log.warn("Failed to decode base64: {}", encoded);
            return encoded.trim();
        }
    }
}
