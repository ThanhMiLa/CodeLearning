package com.thanhmila.codelearning.service.oj;

import com.thanhmila.codelearning.dto.judge0.Judge0CallbackPayload;
import com.thanhmila.codelearning.dto.judge0.Judge0TokenResponse;
import com.thanhmila.codelearning.dto.request.OjSubmissionRequest;
import com.thanhmila.codelearning.dto.response.OjSubmissionInitialResponse;
import com.thanhmila.codelearning.entity.contest.ContestEntity;
import com.thanhmila.codelearning.entity.enums.OjVerdict;
import com.thanhmila.codelearning.entity.enums.UserStatus;
import com.thanhmila.codelearning.entity.oj.OnlineJudgeProblemEntity;
import com.thanhmila.codelearning.entity.oj.OnlineJudgeSubmissionDetailEntity;
import com.thanhmila.codelearning.entity.oj.OnlineJudgeSubmissionEntity;
import com.thanhmila.codelearning.entity.oj.ProblemTestcaseEntity;
import com.thanhmila.codelearning.entity.user.UserEntity;
import com.thanhmila.codelearning.event.SubmissionCompletedEvent;
import com.thanhmila.codelearning.exception.AppException;
import com.thanhmila.codelearning.exception.ErrorCode;
import com.thanhmila.codelearning.repository.contest.ContestProblemRepository;
import com.thanhmila.codelearning.repository.contest.ContestRepository;
import com.thanhmila.codelearning.repository.lesson.LessonProblemRepository;
import com.thanhmila.codelearning.repository.lesson.LessonRepository;
import com.thanhmila.codelearning.repository.oj.OnlineJudgeProblemRepository;
import com.thanhmila.codelearning.repository.oj.OnlineJudgeSubmissionDetailRepository;
import com.thanhmila.codelearning.repository.oj.OnlineJudgeSubmissionRepository;
import com.thanhmila.codelearning.repository.oj.ProblemTestcaseRepository;
import com.thanhmila.codelearning.repository.projection.SubmissionMaxStats;
import com.thanhmila.codelearning.repository.user.UserRepository;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Nested;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;
import org.mockito.junit.jupiter.MockitoSettings;
import org.mockito.quality.Strictness;
import org.springframework.context.ApplicationEventPublisher;
import org.springframework.data.redis.core.StringRedisTemplate;
import org.springframework.data.redis.core.ValueOperations;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.test.util.ReflectionTestUtils;
import org.springframework.transaction.TransactionStatus;
import org.springframework.transaction.support.TransactionCallbackWithoutResult;
import org.springframework.transaction.support.TransactionTemplate;

import java.util.Collections;
import java.util.List;
import java.util.Optional;
import java.util.function.Consumer;

import static org.assertj.core.api.Assertions.assertThat;
import static org.assertj.core.api.Assertions.assertThatThrownBy;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.ArgumentMatchers.eq;
import static org.mockito.Mockito.*;

@ExtendWith(MockitoExtension.class)
@MockitoSettings(strictness = Strictness.LENIENT)
@DisplayName("OjSubmissionService Unit Tests")
class OjSubmissionServiceTest {

    @Mock OnlineJudgeSubmissionRepository onlineJudgeSubmissionRepository;
    @Mock OnlineJudgeSubmissionDetailRepository onlineJudgeSubmissionDetailRepository;
    @Mock ProblemTestcaseRepository problemTestcaseRepository;
    @Mock UserRepository userRepository;
    @Mock OnlineJudgeProblemRepository onlineJudgeProblemRepository;
    @Mock LessonRepository lessonRepository;
    @Mock ContestRepository contestRepository;
    @Mock ContestProblemRepository contestProblemRepository;
    @Mock LessonProblemRepository lessonProblemRepository;
    @Mock Judge0ClientService judge0ClientService;
    @Mock SimpMessagingTemplate simpMessagingTemplate;
    @Mock ApplicationEventPublisher applicationEventPublisher;
    @Mock StringRedisTemplate stringRedisTemplate;
    @Mock TransactionTemplate transactionTemplate;
    @Mock ValueOperations<String, String> valueOperations;

    @InjectMocks OjSubmissionService submissionService;

    @BeforeEach
    void setUp() {
        ReflectionTestUtils.setField(submissionService, "webhookBaseUrl", "http://localhost:8080");
        ReflectionTestUtils.setField(submissionService, "webhookSecret", "secret123");

        when(stringRedisTemplate.opsForValue()).thenReturn(valueOperations);

        // Make TransactionTemplate execute callbacks immediately
        doAnswer(inv -> {
            Consumer<TransactionStatus> action = inv.getArgument(0);
            action.accept(null);
            return null;
        }).when(transactionTemplate).executeWithoutResult(any());
    }

    @Nested
    @DisplayName("submitCode Tests")
    class SubmitCodeTests {

        @Test
        @DisplayName("User not found throws USER_NOT_FOUND")
        void shouldThrow_WhenUserNotFound() {
            when(userRepository.findById(1L)).thenReturn(Optional.empty());

            OjSubmissionRequest request = OjSubmissionRequest.builder().problemId(10L).build();

            assertThatThrownBy(() -> submissionService.submitCode(request, 1L))
                    .isInstanceOf(AppException.class)
                    .hasFieldOrPropertyWithValue("errorCode", ErrorCode.USER_NOT_FOUND);
        }

        @Test
        @DisplayName("User locked throws ACCOUNT_LOCKED")
        void shouldThrow_WhenUserLocked() {
            UserEntity user = UserEntity.builder().id(1L).status(UserStatus.LOCKED).build();
            when(userRepository.findById(1L)).thenReturn(Optional.of(user));

            OjSubmissionRequest request = OjSubmissionRequest.builder().problemId(10L).build();

            assertThatThrownBy(() -> submissionService.submitCode(request, 1L))
                    .isInstanceOf(AppException.class)
                    .hasFieldOrPropertyWithValue("errorCode", ErrorCode.ACCOUNT_LOCKED);
        }

        @Test
        @DisplayName("Problem not found throws OJ_PROBLEM_NOT_FOUND")
        void shouldThrow_WhenProblemNotFound() {
            UserEntity user = UserEntity.builder().id(1L).status(UserStatus.ACTIVE).build();
            when(userRepository.findById(1L)).thenReturn(Optional.of(user));
            when(onlineJudgeProblemRepository.findByIdAndIsPublicTrue(10L)).thenReturn(Optional.empty());

            OjSubmissionRequest request = OjSubmissionRequest.builder().problemId(10L).build();

            assertThatThrownBy(() -> submissionService.submitCode(request, 1L))
                    .isInstanceOf(AppException.class)
                    .hasFieldOrPropertyWithValue("errorCode", ErrorCode.OJ_PROBLEM_NOT_FOUND);
        }

        @Test
        @DisplayName("No testcases found throws TESTCASE_NOT_FOUND")
        void shouldThrow_WhenNoTestcases() {
            UserEntity user = UserEntity.builder().id(1L).status(UserStatus.ACTIVE).build();
            OnlineJudgeProblemEntity problem = OnlineJudgeProblemEntity.builder().id(10L).isPublic(true).build();

            when(userRepository.findById(1L)).thenReturn(Optional.of(user));
            when(onlineJudgeProblemRepository.findByIdAndIsPublicTrue(10L)).thenReturn(Optional.of(problem));
            when(problemTestcaseRepository.findByProblemIdOrderByOrderIndex(10L)).thenReturn(Collections.emptyList());

            OjSubmissionRequest request = OjSubmissionRequest.builder().problemId(10L).build();

            assertThatThrownBy(() -> submissionService.submitCode(request, 1L))
                    .isInstanceOf(AppException.class)
                    .hasFieldOrPropertyWithValue("errorCode", ErrorCode.TESTCASE_NOT_FOUND);
        }

        @Test
        @DisplayName("Judge0 batch submission failure throws JUDGE0_SUBMISSION_FAILED")
        void shouldThrow_WhenJudge0ReturnsMismatchedTokens() {
            UserEntity user = UserEntity.builder().id(1L).status(UserStatus.ACTIVE).build();
            OnlineJudgeProblemEntity problem = OnlineJudgeProblemEntity.builder().id(10L).isPublic(true).timeLimitMs(1000).build();
            ProblemTestcaseEntity tc = ProblemTestcaseEntity.builder().id(100L).build();

            when(userRepository.findById(1L)).thenReturn(Optional.of(user));
            when(onlineJudgeProblemRepository.findByIdAndIsPublicTrue(10L)).thenReturn(Optional.of(problem));
            when(problemTestcaseRepository.findByProblemIdOrderByOrderIndex(10L)).thenReturn(List.of(tc));
            when(judge0ClientService.sendBatchSubmission(any())).thenReturn(Collections.emptyList()); // empty tokens

            OjSubmissionRequest request = OjSubmissionRequest.builder().problemId(10L).languageId(62).sourceCode("code").build();

            assertThatThrownBy(() -> submissionService.submitCode(request, 1L))
                    .isInstanceOf(AppException.class)
                    .hasFieldOrPropertyWithValue("errorCode", ErrorCode.JUDGE0_SUBMISSION_FAILED);
        }

        @Test
        @DisplayName("Valid submitCode saves submission and details and returns PENDING response")
        void shouldSubmitCodeSuccessfully() {
            UserEntity user = UserEntity.builder().id(1L).status(UserStatus.ACTIVE).build();
            OnlineJudgeProblemEntity problem = OnlineJudgeProblemEntity.builder().id(10L).isPublic(true).timeLimitMs(1000).build();
            ProblemTestcaseEntity tc = ProblemTestcaseEntity.builder().id(100L).build();
            Judge0TokenResponse token = new Judge0TokenResponse("token-xyz");

            when(userRepository.findById(1L)).thenReturn(Optional.of(user));
            when(onlineJudgeProblemRepository.findByIdAndIsPublicTrue(10L)).thenReturn(Optional.of(problem));
            when(problemTestcaseRepository.findByProblemIdOrderByOrderIndex(10L)).thenReturn(List.of(tc));
            when(judge0ClientService.sendBatchSubmission(any())).thenReturn(List.of(token));

            OjSubmissionRequest request = OjSubmissionRequest.builder().problemId(10L).languageId(62).sourceCode("class Main {}").build();

            OjSubmissionInitialResponse response = submissionService.submitCode(request, 1L);

            assertThat(response).isNotNull();
            assertThat(response.getStatus()).isEqualTo(OjVerdict.PENDING.toString());
            verify(onlineJudgeSubmissionRepository).save(any(OnlineJudgeSubmissionEntity.class));
            verify(onlineJudgeProblemRepository).incrementTotalSubmissions(10L);
            verify(onlineJudgeSubmissionDetailRepository).saveAll(any());
        }
    }

    @Nested
    @DisplayName("processJudge0Callback Tests")
    class ProcessJudge0CallbackTests {

        @Test
        @DisplayName("Token not found throws JUDGE0_SUBMISSION_FAILED")
        void shouldThrow_WhenTokenNotFound() {
            Judge0CallbackPayload payload = new Judge0CallbackPayload();
            payload.setToken("invalid-token");
            when(onlineJudgeSubmissionDetailRepository.findByTokenWithSubmissionAndProblem("invalid-token")).thenReturn(Optional.empty());

            assertThatThrownBy(() -> submissionService.processJudge0Callback(payload))
                    .isInstanceOf(AppException.class)
                    .hasFieldOrPropertyWithValue("errorCode", ErrorCode.JUDGE0_SUBMISSION_FAILED);
        }

        @Test
        @DisplayName("Intermediate callback in practice mode updates detail and sends websocket message")
        void shouldProcessIntermediateCallback_PracticeMode() {
            UserEntity user = UserEntity.builder().id(1L).build();
            OnlineJudgeProblemEntity problem = OnlineJudgeProblemEntity.builder().id(10L).totalTestCase(3).build();
            OnlineJudgeSubmissionEntity submission = OnlineJudgeSubmissionEntity.builder().id(100L).user(user).problem(problem).build();
            ProblemTestcaseEntity tc = ProblemTestcaseEntity.builder().id(1L).build();
            OnlineJudgeSubmissionDetailEntity detail = OnlineJudgeSubmissionDetailEntity.builder()
                    .token("tok-1")
                    .submission(submission)
                    .testcase(tc)
                    .build();

            Judge0CallbackPayload payload = new Judge0CallbackPayload();
            payload.setToken("tok-1");
            payload.setStatus(new Judge0CallbackPayload.Judge0Status(3, "Accepted"));
            payload.setTime("0.05");
            payload.setMemory(1024);

            when(onlineJudgeSubmissionDetailRepository.findByTokenWithSubmissionAndProblem("tok-1")).thenReturn(Optional.of(detail));
            when(valueOperations.increment("oj_progress:100")).thenReturn(1L); // 1 of 3

            submissionService.processJudge0Callback(payload);

            assertThat(detail.getVerdict()).isEqualTo(OjVerdict.ACCEPTED);
            verify(onlineJudgeSubmissionDetailRepository).save(detail);
            verify(stringRedisTemplate).expire(eq("oj_progress:100"), any());
            verify(simpMessagingTemplate, times(2)).convertAndSend(anyString(), any(Object.class));
            // Should NOT finalize yet
            verify(onlineJudgeSubmissionRepository, never()).save(submission);
        }

        @Test
        @DisplayName("Final callback when all testcases pass finalizes submission as ACCEPTED")
        void shouldFinalize_WhenAllTestcasesAccepted() {
            UserEntity user = UserEntity.builder().id(1L).build();
            OnlineJudgeProblemEntity problem = OnlineJudgeProblemEntity.builder().id(10L).totalTestCase(1).build();
            OnlineJudgeSubmissionEntity submission = OnlineJudgeSubmissionEntity.builder()
                    .id(100L)
                    .user(user)
                    .problem(problem)
                    .build();
            ProblemTestcaseEntity tc = ProblemTestcaseEntity.builder().id(1L).build();
            OnlineJudgeSubmissionDetailEntity detail = OnlineJudgeSubmissionDetailEntity.builder()
                    .token("tok-1")
                    .submission(submission)
                    .testcase(tc)
                    .build();

            Judge0CallbackPayload payload = new Judge0CallbackPayload();
            payload.setToken("tok-1");
            payload.setStatus(new Judge0CallbackPayload.Judge0Status(3, "Accepted"));
            payload.setTime("0.05");
            payload.setMemory(1024);

            SubmissionMaxStats maxStats = new SubmissionMaxStats() {
                @Override public Integer getMaxTime() { return 50; }
                @Override public Integer getMaxMemory() { return 1024; }
            };

            when(onlineJudgeSubmissionDetailRepository.findByTokenWithSubmissionAndProblem("tok-1")).thenReturn(Optional.of(detail));
            when(valueOperations.increment("oj_progress:100")).thenReturn(1L); // 1 of 1
            when(stringRedisTemplate.hasKey("oj_failed:100")).thenReturn(false);
            when(onlineJudgeSubmissionDetailRepository.findFirstBySubmissionIdAndVerdictNotOrderByTestcaseOrderIndexAsc(100L, OjVerdict.ACCEPTED))
                    .thenReturn(Optional.empty()); // All accepted
            when(onlineJudgeSubmissionDetailRepository.findMaxStatsBySubmissionId(100L)).thenReturn(Optional.of(maxStats));

            submissionService.processJudge0Callback(payload);

            assertThat(submission.getVerdict()).isEqualTo(OjVerdict.ACCEPTED);
            verify(onlineJudgeSubmissionRepository).save(submission);
            verify(onlineJudgeProblemRepository).incrementTotalAccepted(10L);
            verify(applicationEventPublisher).publishEvent(any(SubmissionCompletedEvent.class));
            verify(stringRedisTemplate).delete("oj_progress:100");
        }
    }
}
