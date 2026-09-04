package com.thanhmila.codelearning.service.contest;

import com.thanhmila.codelearning.dto.request.ContestCreateRequest;
import com.thanhmila.codelearning.dto.request.ContestRegisterRequest;
import com.thanhmila.codelearning.dto.request.ContestUpdateRequest;
import com.thanhmila.codelearning.dto.response.ContestResponse;
import com.thanhmila.codelearning.entity.contest.ContestEntity;
import com.thanhmila.codelearning.entity.contest.ContestParticipantEntity;
import com.thanhmila.codelearning.entity.enums.ContestStatus;
import com.thanhmila.codelearning.entity.user.TeacherEntity;
import com.thanhmila.codelearning.entity.user.UserEntity;
import com.thanhmila.codelearning.exception.AppException;
import com.thanhmila.codelearning.exception.ErrorCode;
import com.thanhmila.codelearning.mapper.ContestMapper;
import com.thanhmila.codelearning.repository.contest.ContestParticipantRepository;
import com.thanhmila.codelearning.repository.contest.ContestProblemRepository;
import com.thanhmila.codelearning.repository.contest.ContestRepository;
import com.thanhmila.codelearning.repository.oj.OnlineJudgeProblemRepository;
import com.thanhmila.codelearning.repository.user.TeacherRepository;
import com.thanhmila.codelearning.repository.user.UserRepository;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Nested;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;
import org.springframework.amqp.rabbit.core.RabbitTemplate;
import org.springframework.security.crypto.password.PasswordEncoder;

import java.time.ZonedDateTime;
import java.util.Optional;

import static org.assertj.core.api.Assertions.assertThat;
import static org.assertj.core.api.Assertions.assertThatThrownBy;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.ArgumentMatchers.eq;
import static org.mockito.Mockito.*;

@ExtendWith(MockitoExtension.class)
@DisplayName("ContestService Unit Tests")
class ContestServiceTest {

    @Mock ContestRepository contestRepository;
    @Mock TeacherRepository teacherRepository;
    @Mock PasswordEncoder passwordEncoder;
    @Mock ContestMapper contestMapper;
    @Mock RabbitTemplate rabbitTemplate;
    @Mock ContestProblemRepository contestProblemRepository;
    @Mock OnlineJudgeProblemRepository onlineJudgeProblemRepository;
    @Mock ContestParticipantRepository contestParticipantRepository;
    @Mock UserRepository userRepository;
    @Mock ContestLeaderboardService contestLeaderboardService;

    @InjectMocks ContestService contestService;

    @Nested
    @DisplayName("getContestById Tests")
    class GetContestByIdTests {

        @Test
        @DisplayName("Contest not found throws CONTEST_NOT_FOUND")
        void shouldThrow_WhenContestNotFound() {
            when(contestRepository.findById(1L)).thenReturn(Optional.empty());

            assertThatThrownBy(() -> contestService.getContestById(1L, 10L))
                    .isInstanceOf(AppException.class)
                    .hasFieldOrPropertyWithValue("errorCode", ErrorCode.CONTEST_NOT_FOUND);
        }

        @Test
        @DisplayName("User not joined and not creator throws CONTEST_NOT_JOINED")
        void shouldThrow_WhenNotJoinedAndNotCreator() {
            TeacherEntity creator = TeacherEntity.builder().id(99L).build();
            ContestEntity contest = ContestEntity.builder().id(1L).createdByTeacher(creator).build();

            when(contestRepository.findById(1L)).thenReturn(Optional.of(contest));
            when(contestParticipantRepository.findByContestIdAndUserId(1L, 10L)).thenReturn(Optional.empty());
            when(teacherRepository.findIdByUserId(10L)).thenReturn(null);

            assertThatThrownBy(() -> contestService.getContestById(1L, 10L))
                    .isInstanceOf(AppException.class)
                    .hasFieldOrPropertyWithValue("errorCode", ErrorCode.CONTEST_NOT_JOINED);
        }

        @Test
        @DisplayName("Participant can get contest details")
        void shouldReturnContest_WhenParticipant() {
            TeacherEntity creator = TeacherEntity.builder().id(99L).build();
            ContestEntity contest = ContestEntity.builder().id(1L).createdByTeacher(creator).build();
            ContestResponse expected = ContestResponse.builder().id(1L).build();

            when(contestRepository.findById(1L)).thenReturn(Optional.of(contest));
            when(contestParticipantRepository.findByContestIdAndUserId(1L, 10L))
                    .thenReturn(Optional.of(new ContestParticipantEntity()));
            when(contestMapper.toContestResponse(contest)).thenReturn(expected);

            ContestResponse actual = contestService.getContestById(1L, 10L);

            assertThat(actual).isEqualTo(expected);
        }
    }

    @Nested
    @DisplayName("createContest Tests")
    class CreateContestTests {

        @Test
        @DisplayName("StartTime >= EndTime throws INVALID_REQUEST")
        void shouldThrow_WhenInvalidTimeRange() {
            ContestCreateRequest request = ContestCreateRequest.builder()
                    .startTime(ZonedDateTime.now().plusHours(2))
                    .endTime(ZonedDateTime.now().plusHours(1))
                    .build();

            assertThatThrownBy(() -> contestService.createContest(request, 10L))
                    .isInstanceOf(AppException.class)
                    .hasFieldOrPropertyWithValue("errorCode", ErrorCode.INVALID_REQUEST);
        }

        @Test
        @DisplayName("Non-teacher user throws ACCESS_DENIED")
        void shouldThrow_WhenNotTeacher() {
            ContestCreateRequest request = ContestCreateRequest.builder()
                    .startTime(ZonedDateTime.now().plusHours(1))
                    .endTime(ZonedDateTime.now().plusHours(3))
                    .build();

            when(teacherRepository.findIdByUserId(10L)).thenReturn(null);

            assertThatThrownBy(() -> contestService.createContest(request, 10L))
                    .isInstanceOf(AppException.class)
                    .hasFieldOrPropertyWithValue("errorCode", ErrorCode.ACCESS_DENIED);
        }

        @Test
        @DisplayName("Valid create contest saves contest and schedules RabbitMQ start/end messages")
        void shouldCreateContestSuccessfully() {
            ZonedDateTime start = ZonedDateTime.now().plusHours(1);
            ZonedDateTime end = ZonedDateTime.now().plusHours(3);
            ContestCreateRequest request = ContestCreateRequest.builder()
                    .title("Contest 1")
                    .password("pass123")
                    .startTime(start)
                    .endTime(end)
                    .build();

            TeacherEntity teacher = TeacherEntity.builder().id(5L).build();
            when(teacherRepository.findIdByUserId(10L)).thenReturn(5L);
            when(teacherRepository.findById(5L)).thenReturn(Optional.of(teacher));
            when(passwordEncoder.encode("pass123")).thenReturn("hashedPass");
            when(contestRepository.save(any(ContestEntity.class))).thenAnswer(inv -> {
                ContestEntity c = inv.getArgument(0);
                c.setId(100L);
                return c;
            });
            when(contestMapper.toContestResponse(any())).thenReturn(ContestResponse.builder().id(100L).build());

            ContestResponse response = contestService.createContest(request, 10L);

            assertThat(response).isNotNull();
            assertThat(response.getId()).isEqualTo(100L);
            verify(contestRepository).save(any(ContestEntity.class));
            verify(rabbitTemplate, times(2)).convertAndSend(anyString(), anyString(), any(Object.class), any(org.springframework.amqp.core.MessagePostProcessor.class));
        }
    }

    @Nested
    @DisplayName("registerContest Tests")
    class RegisterContestTests {

        @Test
        @DisplayName("Contest not found throws CONTEST_NOT_FOUND")
        void shouldThrow_WhenContestNotFound() {
            when(contestRepository.findById(1L)).thenReturn(Optional.empty());

            assertThatThrownBy(() -> contestService.registerContest(1L, new ContestRegisterRequest(), 10L))
                    .isInstanceOf(AppException.class)
                    .hasFieldOrPropertyWithValue("errorCode", ErrorCode.CONTEST_NOT_FOUND);
        }

        @Test
        @DisplayName("Already registered succeeds silently")
        void shouldSucceedSilently_WhenAlreadyRegistered() {
            ContestEntity contest = ContestEntity.builder().id(1L).build();
            when(contestRepository.findById(1L)).thenReturn(Optional.of(contest));
            when(contestParticipantRepository.findByContestIdAndUserId(1L, 10L))
                    .thenReturn(Optional.of(new ContestParticipantEntity()));

            contestService.registerContest(1L, new ContestRegisterRequest(), 10L);

            verify(contestParticipantRepository, never()).save(any());
        }

        @Test
        @DisplayName("Contest not running throws CONTEST_NOT_RUNNING")
        void shouldThrow_WhenNotRunning() {
            ContestEntity contest = ContestEntity.builder().id(1L).status(ContestStatus.UPCOMING).build();
            when(contestRepository.findById(1L)).thenReturn(Optional.of(contest));
            when(contestParticipantRepository.findByContestIdAndUserId(1L, 10L)).thenReturn(Optional.empty());

            assertThatThrownBy(() -> contestService.registerContest(1L, new ContestRegisterRequest(), 10L))
                    .isInstanceOf(AppException.class)
                    .hasFieldOrPropertyWithValue("errorCode", ErrorCode.CONTEST_NOT_RUNNING);
        }

        @Test
        @DisplayName("Wrong password throws CONTEST_PASSWORD_INVALID")
        void shouldThrow_WhenWrongPassword() {
            ContestEntity contest = ContestEntity.builder()
                    .id(1L)
                    .status(ContestStatus.RUNNING)
                    .passwordHash("hashed")
                    .build();
            when(contestRepository.findById(1L)).thenReturn(Optional.of(contest));
            when(contestParticipantRepository.findByContestIdAndUserId(1L, 10L)).thenReturn(Optional.empty());
            when(passwordEncoder.matches("wrong", "hashed")).thenReturn(false);

            ContestRegisterRequest req = new ContestRegisterRequest();
            req.setPassword("wrong");

            assertThatThrownBy(() -> contestService.registerContest(1L, req, 10L))
                    .isInstanceOf(AppException.class)
                    .hasFieldOrPropertyWithValue("errorCode", ErrorCode.CONTEST_PASSWORD_INVALID);
        }

        @Test
        @DisplayName("Valid registration saves participant and initializes leaderboard")
        void shouldRegisterSuccessfully() {
            ContestEntity contest = ContestEntity.builder()
                    .id(1L)
                    .status(ContestStatus.RUNNING)
                    .passwordHash(null)
                    .build();
            when(contestRepository.findById(1L)).thenReturn(Optional.of(contest));
            when(contestParticipantRepository.findByContestIdAndUserId(1L, 10L)).thenReturn(Optional.empty());

            contestService.registerContest(1L, new ContestRegisterRequest(), 10L);

            verify(contestParticipantRepository).save(any(ContestParticipantEntity.class));
            verify(contestLeaderboardService).initializeLeaderboardForUser(1L, 10L);
        }
    }
}
