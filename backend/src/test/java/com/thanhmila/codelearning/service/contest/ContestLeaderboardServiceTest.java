package com.thanhmila.codelearning.service.contest;

import com.thanhmila.codelearning.dto.response.ContestLeaderboardResponse;
import com.thanhmila.codelearning.entity.contest.ContestEntity;
import com.thanhmila.codelearning.entity.contest.ContestProblemAttemptEntity;
import com.thanhmila.codelearning.entity.contest.ContestProblemEntity;
import com.thanhmila.codelearning.entity.contest.ContestRankingEntity;
import com.thanhmila.codelearning.entity.enums.ContestStatus;
import com.thanhmila.codelearning.entity.enums.OjVerdict;
import com.thanhmila.codelearning.entity.oj.OnlineJudgeProblemEntity;
import com.thanhmila.codelearning.entity.user.UserEntity;
import com.thanhmila.codelearning.exception.AppException;
import com.thanhmila.codelearning.exception.ErrorCode;
import com.thanhmila.codelearning.repository.contest.ContestProblemAttemptRepository;
import com.thanhmila.codelearning.repository.contest.ContestProblemRepository;
import com.thanhmila.codelearning.repository.contest.ContestRankingRepository;
import com.thanhmila.codelearning.repository.contest.ContestRepository;
import com.thanhmila.codelearning.repository.oj.OnlineJudgeProblemRepository;
import com.thanhmila.codelearning.repository.user.UserRepository;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Nested;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;
import org.springframework.messaging.simp.SimpMessagingTemplate;

import java.time.ZonedDateTime;
import java.util.List;
import java.util.Optional;

import static org.assertj.core.api.Assertions.assertThat;
import static org.assertj.core.api.Assertions.assertThatThrownBy;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.ArgumentMatchers.eq;
import static org.mockito.Mockito.*;

@ExtendWith(MockitoExtension.class)
@DisplayName("ContestLeaderboardService Unit Tests")
class ContestLeaderboardServiceTest {

    @Mock ContestProblemRepository contestProblemRepository;
    @Mock ContestProblemAttemptRepository attemptRepo;
    @Mock ContestRankingRepository rankingRepo;
    @Mock ContestRepository contestRepository;
    @Mock UserRepository userRepository;
    @Mock OnlineJudgeProblemRepository problemRepository;
    @Mock SimpMessagingTemplate messagingTemplate;

    @InjectMocks ContestLeaderboardService leaderboardService;

    @Nested
    @DisplayName("initializeLeaderboardForUser Tests")
    class InitializeLeaderboardTests {

        @Test
        @DisplayName("Contest not found throws CONTEST_NOT_FOUND")
        void shouldThrow_WhenContestNotFound() {
            when(contestRepository.findById(1L)).thenReturn(Optional.empty());

            assertThatThrownBy(() -> leaderboardService.initializeLeaderboardForUser(1L, 10L))
                    .isInstanceOf(AppException.class)
                    .hasFieldOrPropertyWithValue("errorCode", ErrorCode.CONTEST_NOT_FOUND);
        }

        @Test
        @DisplayName("User not found throws USER_NOT_FOUND")
        void shouldThrow_WhenUserNotFound() {
            when(contestRepository.findById(1L)).thenReturn(Optional.of(new ContestEntity()));
            when(userRepository.findById(10L)).thenReturn(Optional.empty());

            assertThatThrownBy(() -> leaderboardService.initializeLeaderboardForUser(1L, 10L))
                    .isInstanceOf(AppException.class)
                    .hasFieldOrPropertyWithValue("errorCode", ErrorCode.USER_NOT_FOUND);
        }

        @Test
        @DisplayName("Initializes ranking and attempts when not exist")
        void shouldInitializeRankingAndAttempts() {
            ContestEntity contest = ContestEntity.builder().id(1L).build();
            UserEntity user = UserEntity.builder().id(10L).build();
            OnlineJudgeProblemEntity problem = OnlineJudgeProblemEntity.builder().id(100L).build();
            ContestProblemEntity cp = ContestProblemEntity.builder().id(50L).problem(problem).build();

            when(contestRepository.findById(1L)).thenReturn(Optional.of(contest));
            when(userRepository.findById(10L)).thenReturn(Optional.of(user));
            when(contestProblemRepository.findByContestIdOrderByOrderIndex(1L)).thenReturn(List.of(cp));
            when(rankingRepo.findByContestIdAndUserId(1L, 10L)).thenReturn(Optional.empty());
            when(attemptRepo.findByContestIdAndUserIdAndProblemId(1L, 10L, 100L)).thenReturn(Optional.empty());

            leaderboardService.initializeLeaderboardForUser(1L, 10L);

            verify(rankingRepo).save(any(ContestRankingEntity.class));
            verify(attemptRepo).saveAll(any());
        }
    }

    @Nested
    @DisplayName("processIpcpLeaderboard Tests")
    class ProcessIpcpLeaderboardTests {

        @Test
        @DisplayName("Compilation Error does not affect attempts or penalty")
        void shouldIgnore_WhenCompilationError() {
            ContestProblemAttemptEntity attempt = ContestProblemAttemptEntity.builder()
                    .isSolved(false)
                    .failedAttemptsCount(0)
                    .build();
            when(attemptRepo.findByContestIdAndUserIdAndProblemId(1L, 10L, 100L))
                    .thenReturn(Optional.of(attempt));

            leaderboardService.processIpcpLeaderboard(1L, 10L, 100L, OjVerdict.COMPILATION_ERROR, ZonedDateTime.now());

            verify(attemptRepo, never()).save(any());
            verify(rankingRepo, never()).save(any());
        }

        @Test
        @DisplayName("Already solved problem ignores new submissions")
        void shouldIgnore_WhenAlreadySolved() {
            ContestProblemAttemptEntity attempt = ContestProblemAttemptEntity.builder()
                    .isSolved(true)
                    .failedAttemptsCount(1)
                    .build();
            when(attemptRepo.findByContestIdAndUserIdAndProblemId(1L, 10L, 100L))
                    .thenReturn(Optional.of(attempt));

            leaderboardService.processIpcpLeaderboard(1L, 10L, 100L, OjVerdict.WRONG_ANSWER, ZonedDateTime.now());

            verify(attemptRepo, never()).save(any());
            verify(rankingRepo, never()).save(any());
        }

        @Test
        @DisplayName("Wrong answer increments failed attempts and broadcasts")
        void shouldIncrementFailedAttempts_WhenWrongAnswer() {
            ContestProblemAttemptEntity attempt = ContestProblemAttemptEntity.builder()
                    .isSolved(false)
                    .failedAttemptsCount(1)
                    .build();
            when(attemptRepo.findByContestIdAndUserIdAndProblemId(1L, 10L, 100L))
                    .thenReturn(Optional.of(attempt));

            leaderboardService.processIpcpLeaderboard(1L, 10L, 100L, OjVerdict.WRONG_ANSWER, ZonedDateTime.now());

            assertThat(attempt.getFailedAttemptsCount()).isEqualTo(2);
            verify(attemptRepo).save(attempt);
            verify(messagingTemplate).convertAndSend(eq("/topic/contests/1/leaderboard"), any(String.class));
            verify(rankingRepo, never()).save(any());
        }

        @Test
        @DisplayName("Accepted submission calculates ICPC penalty (solvedAt + failedAttempts * 1200s)")
        void shouldCalculatePenalty_WhenAccepted() {
            ZonedDateTime start = ZonedDateTime.now().minusMinutes(10); // 600s
            ZonedDateTime submit = ZonedDateTime.now();

            ContestEntity contest = ContestEntity.builder().id(1L).startTime(start).build();
            ContestProblemAttemptEntity attempt = ContestProblemAttemptEntity.builder()
                    .isSolved(false)
                    .failedAttemptsCount(2) // 2 failed attempts = 2400s penalty
                    .build();
            ContestRankingEntity ranking = ContestRankingEntity.builder()
                    .problemsSolved(0)
                    .totalPenalty(0)
                    .build();

            when(attemptRepo.findByContestIdAndUserIdAndProblemId(1L, 10L, 100L))
                    .thenReturn(Optional.of(attempt));
            when(contestRepository.findById(1L)).thenReturn(Optional.of(contest));
            when(rankingRepo.findByContestIdAndUserId(1L, 10L)).thenReturn(Optional.of(ranking));

            leaderboardService.processIpcpLeaderboard(1L, 10L, 100L, OjVerdict.ACCEPTED, submit);

            assertThat(attempt.getIsSolved()).isTrue();
            // SolvedAt ~ 600s, Penalty ~ 600 + 2400 = 3000s
            assertThat(ranking.getProblemsSolved()).isEqualTo(1);
            assertThat(ranking.getTotalPenalty()).isGreaterThanOrEqualTo(3000);
            verify(attemptRepo).save(attempt);
            verify(rankingRepo).save(ranking);
            verify(messagingTemplate).convertAndSend(eq("/topic/contests/1/leaderboard"), any(String.class));
        }
    }

    @Nested
    @DisplayName("getLeaderboard Tests")
    class GetLeaderboardTests {

        @Test
        @DisplayName("Contest not found throws CONTEST_NOT_FOUND")
        void shouldThrow_WhenContestNotFound() {
            when(contestRepository.findById(1L)).thenReturn(Optional.empty());

            assertThatThrownBy(() -> leaderboardService.getLeaderboard(1L))
                    .isInstanceOf(AppException.class)
                    .hasFieldOrPropertyWithValue("errorCode", ErrorCode.CONTEST_NOT_FOUND);
        }

        @Test
        @DisplayName("Returns leaderboard rankings and problem statuses")
        void shouldReturnLeaderboard() {
            ContestEntity contest = ContestEntity.builder()
                    .id(1L)
                    .title("ICPC 2026")
                    .status(ContestStatus.RUNNING)
                    .startTime(ZonedDateTime.now())
                    .endTime(ZonedDateTime.now().plusHours(2))
                    .build();
            UserEntity user = UserEntity.builder().id(10L).displayName("Coder1").build();
            ContestRankingEntity ranking = ContestRankingEntity.builder()
                    .user(user)
                    .problemsSolved(1)
                    .totalPenalty(600)
                    .build();
            OnlineJudgeProblemEntity prob = OnlineJudgeProblemEntity.builder().id(100L).build();
            ContestProblemAttemptEntity attempt = ContestProblemAttemptEntity.builder()
                    .user(user)
                    .problem(prob)
                    .isSolved(true)
                    .failedAttemptsCount(0)
                    .solvedAtSeconds(600)
                    .build();

            when(contestRepository.findById(1L)).thenReturn(Optional.of(contest));
            when(rankingRepo.findByContestIdOrderByProblemsSolvedDescTotalPenaltyAscUpdatedAtAsc(1L)).thenReturn(List.of(ranking));
            when(attemptRepo.findByContestId(1L)).thenReturn(List.of(attempt));

            ContestLeaderboardResponse response = leaderboardService.getLeaderboard(1L);

            assertThat(response).isNotNull();
            assertThat(response.getTitle()).isEqualTo("ICPC 2026");
            assertThat(response.getLeaderboard()).hasSize(1);
            assertThat(response.getLeaderboard().get(0).getDisplayName()).isEqualTo("Coder1");
            assertThat(response.getLeaderboard().get(0).getRank()).isEqualTo(1);
            assertThat(response.getLeaderboard().get(0).getProblemStatuses()).hasSize(1);
            assertThat(response.getLeaderboard().get(0).getProblemStatuses().get(0).getIsSolved()).isTrue();
        }
    }
}
