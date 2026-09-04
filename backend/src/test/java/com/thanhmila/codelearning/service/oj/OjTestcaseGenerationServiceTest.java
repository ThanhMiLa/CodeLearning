package com.thanhmila.codelearning.service.oj;

import com.thanhmila.codelearning.dto.judge0.Judge0BatchRequest;
import com.thanhmila.codelearning.dto.judge0.Judge0CallbackPayload;
import com.thanhmila.codelearning.dto.judge0.Judge0CallbackPayload.Judge0Status;
import com.thanhmila.codelearning.dto.judge0.Judge0TokenResponse;
import com.thanhmila.codelearning.dto.request.GenerateTestcaseRequest;
import com.thanhmila.codelearning.entity.oj.OnlineJudgeProblemEntity;
import com.thanhmila.codelearning.entity.oj.ProblemTestcaseEntity;
import com.thanhmila.codelearning.exception.AppException;
import com.thanhmila.codelearning.exception.ErrorCode;
import com.thanhmila.codelearning.repository.oj.OnlineJudgeProblemRepository;
import com.thanhmila.codelearning.repository.oj.ProblemTestcaseRepository;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Nested;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;
import org.springframework.data.redis.core.StringRedisTemplate;
import org.springframework.data.redis.core.ValueOperations;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.test.util.ReflectionTestUtils;

import java.nio.charset.StandardCharsets;
import java.util.Base64;
import java.util.List;
import java.util.Optional;

import static org.assertj.core.api.Assertions.assertThat;
import static org.assertj.core.api.Assertions.assertThatThrownBy;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.ArgumentMatchers.anyString;
import static org.mockito.ArgumentMatchers.eq;
import static org.mockito.Mockito.*;

@ExtendWith(MockitoExtension.class)
@DisplayName("OjTestcaseGenerationService Unit Tests")
class OjTestcaseGenerationServiceTest {

    @Mock
    private OnlineJudgeProblemRepository onlineJudgeProblemRepository;

    @Mock
    private ProblemTestcaseRepository problemTestcaseRepository;

    @Mock
    private Judge0ClientService judge0ClientService;

    @Mock
    private StringRedisTemplate stringRedisTemplate;

    @Mock
    private ValueOperations<String, String> valueOperations;

    @Mock
    private SimpMessagingTemplate simpMessagingTemplate;

    @InjectMocks
    private OjTestcaseGenerationService ojTestcaseGenerationService;

    @BeforeEach
    void setUp() {
        ReflectionTestUtils.setField(ojTestcaseGenerationService, "webhookBaseUrl", "https://api.example.com");
        ReflectionTestUtils.setField(ojTestcaseGenerationService, "webhookSecret", "test-secret");
    }

    @Nested
    @DisplayName("generateTestcases Tests")
    class GenerateTestcasesTests {

        @Test
        @DisplayName("Given non-existing problemId, throws AppException(OJ_PROBLEM_NOT_FOUND)")
        void generateTestcases_ProblemNotFound_ThrowsAppException() {
            when(onlineJudgeProblemRepository.findById(999L)).thenReturn(Optional.empty());

            GenerateTestcaseRequest request = new GenerateTestcaseRequest();
            request.setTotalTestcasesToGenerate(5);

            assertThatThrownBy(() -> ojTestcaseGenerationService.generateTestcases(999L, request))
                    .isInstanceOf(AppException.class)
                    .matches(e -> ((AppException) e).getErrorCode() == ErrorCode.OJ_PROBLEM_NOT_FOUND);
        }

        @Test
        @DisplayName("Given valid request, saves testcases and sends batch to Judge0")
        void generateTestcases_ValidRequest_Success() {
            OnlineJudgeProblemEntity problem = OnlineJudgeProblemEntity.builder()
                    .id(1L)
                    .title("Two Sum")
                    .isActive(true)
                    .build();

            GenerateTestcaseRequest request = new GenerateTestcaseRequest();
            request.setGeneratorCode("print(1)");
            request.setGeneratorLanguageId(71);
            request.setSolutionCode("print(2)");
            request.setSolutionLanguageId(71);
            request.setTotalTestcasesToGenerate(2);

            when(onlineJudgeProblemRepository.findById(1L)).thenReturn(Optional.of(problem));
            when(stringRedisTemplate.opsForValue()).thenReturn(valueOperations);

            Judge0TokenResponse token1 = new Judge0TokenResponse();
            token1.setToken("tok-1");
            Judge0TokenResponse token2 = new Judge0TokenResponse();
            token2.setToken("tok-2");
            when(judge0ClientService.sendBatchSubmission(any(Judge0BatchRequest.class)))
                    .thenReturn(List.of(token1, token2));

            ojTestcaseGenerationService.generateTestcases(1L, request);

            assertThat(problem.getIsActive()).isFalse();
            verify(onlineJudgeProblemRepository).save(problem);
            verify(problemTestcaseRepository).deleteByProblemId(1L);
            verify(judge0ClientService).sendBatchSubmission(any(Judge0BatchRequest.class));
            verify(problemTestcaseRepository).saveAll(anyList());
        }
    }

    @Nested
    @DisplayName("processInputWebhook Tests")
    class ProcessInputWebhookTests {

        @Test
        @DisplayName("Given unknown token, returns early without changes")
        void processInputWebhook_TokenNotFound_ReturnsEarly() {
            when(problemTestcaseRepository.findByToken("invalid-tok")).thenReturn(Optional.empty());

            Judge0CallbackPayload payload = new Judge0CallbackPayload();
            payload.setToken("invalid-tok");

            ojTestcaseGenerationService.processInputWebhook(payload);

            verify(problemTestcaseRepository, never()).save(any());
        }

        @Test
        @DisplayName("Given cancelled generation (no Redis key), returns early")
        void processInputWebhook_NoRedisKey_ReturnsEarly() {
            OnlineJudgeProblemEntity problem = OnlineJudgeProblemEntity.builder().id(10L).build();
            ProblemTestcaseEntity testcase = ProblemTestcaseEntity.builder()
                    .id(1L)
                    .token("tok-1")
                    .problem(problem)
                    .build();

            when(problemTestcaseRepository.findByToken("tok-1")).thenReturn(Optional.of(testcase));
            when(stringRedisTemplate.hasKey("gen_solution_code:10")).thenReturn(false);

            Judge0CallbackPayload payload = new Judge0CallbackPayload();
            payload.setToken("tok-1");

            ojTestcaseGenerationService.processInputWebhook(payload);

            verify(problemTestcaseRepository, never()).save(any());
        }

        @Test
        @DisplayName("Given execution error from Judge0, handles failure and clears resources")
        void processInputWebhook_StatusError_HandlesFailure() {
            OnlineJudgeProblemEntity problem = OnlineJudgeProblemEntity.builder().id(10L).build();
            ProblemTestcaseEntity testcase = ProblemTestcaseEntity.builder()
                    .id(1L)
                    .token("tok-1")
                    .problem(problem)
                    .build();

            Judge0Status status = new Judge0Status();
            status.setId(6); // Compilation Error
            status.setDescription("Compilation Error");

            Judge0CallbackPayload payload = new Judge0CallbackPayload();
            payload.setToken("tok-1");
            payload.setStatus(status);
            payload.setStderr(Base64.getEncoder().encodeToString("Syntax error".getBytes(StandardCharsets.UTF_8)));

            when(problemTestcaseRepository.findByToken("tok-1")).thenReturn(Optional.of(testcase));
            when(stringRedisTemplate.hasKey("gen_solution_code:10")).thenReturn(true);

            ojTestcaseGenerationService.processInputWebhook(payload);

            verify(problemTestcaseRepository).deleteByProblemId(10L);
            verify(simpMessagingTemplate).convertAndSend(eq("/topic/testcase-generation/10"), any(Object.class));
        }

        @Test
        @DisplayName("Given valid input and all inputs complete, starts output generation phase")
        void processInputWebhook_AllInputsComplete_StartsPhase3() {
            OnlineJudgeProblemEntity problem = OnlineJudgeProblemEntity.builder().id(10L).build();
            ProblemTestcaseEntity tc1 = ProblemTestcaseEntity.builder().id(1L).problem(problem).inputData("input1").build();
            ProblemTestcaseEntity tc2 = ProblemTestcaseEntity.builder().id(2L).problem(problem).inputData("input2").build();

            when(problemTestcaseRepository.findByToken("tok-2")).thenReturn(Optional.of(tc2));
            when(stringRedisTemplate.hasKey("gen_solution_code:10")).thenReturn(true);
            when(stringRedisTemplate.opsForValue()).thenReturn(valueOperations);
            when(valueOperations.increment("gen_input_progress:10")).thenReturn(2L);
            when(problemTestcaseRepository.countByProblemId(10L)).thenReturn(2);

            when(valueOperations.get("gen_solution_code:10")).thenReturn("print('hello')");
            when(valueOperations.get("gen_solution_lang:10")).thenReturn("71");
            when(problemTestcaseRepository.findByProblemIdOrderByOrderIndex(10L)).thenReturn(List.of(tc1, tc2));

            Judge0TokenResponse tr1 = new Judge0TokenResponse();
            tr1.setToken("out-tok-1");
            Judge0TokenResponse tr2 = new Judge0TokenResponse();
            tr2.setToken("out-tok-2");
            when(judge0ClientService.sendBatchSubmission(any(Judge0BatchRequest.class)))
                    .thenReturn(List.of(tr1, tr2));

            Judge0Status status = new Judge0Status();
            status.setId(3); // Accepted
            Judge0CallbackPayload payload = new Judge0CallbackPayload();
            payload.setToken("tok-2");
            payload.setStatus(status);
            payload.setStdout(Base64.getEncoder().encodeToString("5 10\n".getBytes(StandardCharsets.UTF_8)));

            ojTestcaseGenerationService.processInputWebhook(payload);

            verify(problemTestcaseRepository).save(tc2);
            verify(judge0ClientService).sendBatchSubmission(any(Judge0BatchRequest.class));
            verify(problemTestcaseRepository).saveAll(anyList());
        }
    }

    @Nested
    @DisplayName("processOutputWebhook Tests")
    class ProcessOutputWebhookTests {

        @Test
        @DisplayName("Given all outputs complete, activates problem and cleans Redis")
        void processOutputWebhook_AllComplete_ActivatesProblem() {
            OnlineJudgeProblemEntity problem = OnlineJudgeProblemEntity.builder()
                    .id(10L)
                    .isActive(false)
                    .build();
            ProblemTestcaseEntity tc = ProblemTestcaseEntity.builder()
                    .id(1L)
                    .problem(problem)
                    .token("out-tok-1")
                    .build();

            when(problemTestcaseRepository.findByToken("out-tok-1")).thenReturn(Optional.of(tc));
            when(stringRedisTemplate.hasKey("gen_solution_code:10")).thenReturn(true);
            when(stringRedisTemplate.opsForValue()).thenReturn(valueOperations);
            when(valueOperations.increment("gen_output_progress:10")).thenReturn(1L);
            when(problemTestcaseRepository.countByProblemId(10L)).thenReturn(1);

            Judge0Status status = new Judge0Status();
            status.setId(3);
            Judge0CallbackPayload payload = new Judge0CallbackPayload();
            payload.setToken("out-tok-1");
            payload.setStatus(status);
            payload.setStdout(Base64.getEncoder().encodeToString("15\n".getBytes(StandardCharsets.UTF_8)));

            ojTestcaseGenerationService.processOutputWebhook(payload);

            assertThat(problem.getIsActive()).isTrue();
            assertThat(problem.getTotalTestCase()).isEqualTo(1);
            verify(onlineJudgeProblemRepository).save(problem);
            verify(simpMessagingTemplate).convertAndSend(eq("/topic/testcase-generation/10"), any(Object.class));
        }
    }
}
