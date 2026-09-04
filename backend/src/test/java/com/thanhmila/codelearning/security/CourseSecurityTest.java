package com.thanhmila.codelearning.security;

import com.thanhmila.codelearning.repository.contest.ContestParticipantRepository;
import com.thanhmila.codelearning.repository.course.EnrollmentRepository;
import com.thanhmila.codelearning.repository.course.TeacherCourseAssignmentRepository;
import com.thanhmila.codelearning.repository.oj.OnlineJudgeProblemRepository;
import com.thanhmila.codelearning.repository.projection.ProblemAccessProjection;
import com.thanhmila.codelearning.repository.user.TeacherRepository;
import org.junit.jupiter.api.AfterEach;
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
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContext;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.oauth2.jwt.Jwt;

import java.util.Collections;
import java.util.List;
import java.util.Optional;

import static org.assertj.core.api.Assertions.assertThat;
import static org.mockito.Mockito.*;

@ExtendWith(MockitoExtension.class)
@MockitoSettings(strictness = Strictness.LENIENT)
@DisplayName("CourseSecurity Unit Tests")
class CourseSecurityTest {

    @Mock EnrollmentRepository enrollmentRepository;
    @Mock TeacherRepository teacherRepository;
    @Mock TeacherCourseAssignmentRepository teacherCourseAssignmentRepository;
    @Mock ContestParticipantRepository contestParticipantRepository;
    @Mock OnlineJudgeProblemRepository onlineJudgeProblemRepository;

    @InjectMocks CourseSecurity courseSecurity;

    private final Long userId = 100L;

    @BeforeEach
    void setUp() {
        Jwt jwt = mock(Jwt.class);
        when(jwt.getClaim("userId")).thenReturn(userId);

        Authentication auth = mock(Authentication.class);
        when(auth.isAuthenticated()).thenReturn(true);
        when(auth.getPrincipal()).thenReturn(jwt);

        SecurityContext securityContext = mock(SecurityContext.class);
        when(securityContext.getAuthentication()).thenReturn(auth);
        SecurityContextHolder.setContext(securityContext);
    }

    @AfterEach
    void tearDown() {
        SecurityContextHolder.clearContext();
    }

    @Nested
    @DisplayName("canAccessProblem Tests")
    class CanAccessProblemTests {

        @Test
        @DisplayName("Returns false when problemId is null")
        void shouldReturnFalse_WhenProblemIdNull() {
            assertThat(courseSecurity.canAccessProblem(null)).isFalse();
        }

        @Test
        @DisplayName("Returns false when not authenticated")
        void shouldReturnFalse_WhenNotAuthenticated() {
            SecurityContextHolder.clearContext();
            assertThat(courseSecurity.canAccessProblem(1L)).isFalse();
        }

        @Test
        @DisplayName("Returns false when problem details not found")
        void shouldReturnFalse_WhenProblemNotFound() {
            when(onlineJudgeProblemRepository.findAccessDetailsByProblemId(1L)).thenReturn(Optional.empty());

            assertThat(courseSecurity.canAccessProblem(1L)).isFalse();
        }

        @Test
        @DisplayName("Returns true when problem is public")
        void shouldReturnTrue_WhenProblemPublic() {
            ProblemAccessProjection projection = mock(ProblemAccessProjection.class);
            when(projection.getIsPublic()).thenReturn(true);
            when(onlineJudgeProblemRepository.findAccessDetailsByProblemId(1L)).thenReturn(Optional.of(projection));

            assertThat(courseSecurity.canAccessProblem(1L)).isTrue();
        }

        @Test
        @DisplayName("Returns true when problem in course and user enrolled")
        void shouldReturnTrue_WhenEnrolledInCourse() {
            ProblemAccessProjection projection = mock(ProblemAccessProjection.class);
            when(projection.getIsPublic()).thenReturn(false);
            when(onlineJudgeProblemRepository.findAccessDetailsByProblemId(1L)).thenReturn(Optional.of(projection));
            when(enrollmentRepository.isUserEnrolledByProblemId(userId, 1L)).thenReturn(true);

            assertThat(courseSecurity.canAccessProblem(1L)).isTrue();
        }

        @Test
        @DisplayName("Returns true when problem in contest and user participant")
        void shouldReturnTrue_WhenUserParticipantOfContest() {
            ProblemAccessProjection projection = mock(ProblemAccessProjection.class);
            when(projection.getIsPublic()).thenReturn(false);
            when(onlineJudgeProblemRepository.findAccessDetailsByProblemId(1L)).thenReturn(Optional.of(projection));
            when(enrollmentRepository.isUserEnrolledByProblemId(userId, 1L)).thenReturn(false);
            when(onlineJudgeProblemRepository.findContestIdsByProblemId(1L)).thenReturn(List.of(10L));
            when(contestParticipantRepository.isUserParticipantOfAnyContest(userId, List.of(10L))).thenReturn(true);

            assertThat(courseSecurity.canAccessProblem(1L)).isTrue();
        }

        @Test
        @DisplayName("Returns false when problem in contest and user NOT participant")
        void shouldReturnFalse_WhenUserNotParticipantOfContest() {
            ProblemAccessProjection projection = mock(ProblemAccessProjection.class);
            when(projection.getIsPublic()).thenReturn(false);
            when(onlineJudgeProblemRepository.findAccessDetailsByProblemId(1L)).thenReturn(Optional.of(projection));
            when(enrollmentRepository.isUserEnrolledByProblemId(userId, 1L)).thenReturn(false);
            when(onlineJudgeProblemRepository.findContestIdsByProblemId(1L)).thenReturn(List.of(10L));
            when(contestParticipantRepository.isUserParticipantOfAnyContest(userId, List.of(10L))).thenReturn(false);

            assertThat(courseSecurity.canAccessProblem(1L)).isFalse();
        }

        @Test
        @DisplayName("Returns true when practice problem not in lesson or contest")
        void shouldReturnTrue_WhenPracticeProblem() {
            ProblemAccessProjection projection = mock(ProblemAccessProjection.class);
            when(projection.getIsPublic()).thenReturn(false);
            when(onlineJudgeProblemRepository.findAccessDetailsByProblemId(1L)).thenReturn(Optional.of(projection));
            when(enrollmentRepository.isUserEnrolledByProblemId(userId, 1L)).thenReturn(false);
            when(onlineJudgeProblemRepository.findContestIdsByProblemId(1L)).thenReturn(Collections.emptyList());

            assertThat(courseSecurity.canAccessProblem(1L)).isTrue();
        }
    }

    @Nested
    @DisplayName("canAccessLesson & canAccessContest Tests")
    class OtherAccessTests {

        @Test
        void testCanAccessLesson() {
            assertThat(courseSecurity.canAccessLesson(null)).isFalse();

            when(enrollmentRepository.isUserEnrolledInLesson(userId, 5L)).thenReturn(true);
            assertThat(courseSecurity.canAccessLesson(5L)).isTrue();

            when(enrollmentRepository.isUserEnrolledInLesson(userId, 6L)).thenReturn(false);
            assertThat(courseSecurity.canAccessLesson(6L)).isFalse();
        }

        @Test
        void testCanAccessContest() {
            assertThat(courseSecurity.canAccessContest(null)).isFalse();

            when(onlineJudgeProblemRepository.findContestIdsByProblemId(1L)).thenReturn(Collections.emptyList());
            assertThat(courseSecurity.canAccessContest(1L)).isFalse();

            when(onlineJudgeProblemRepository.findContestIdsByProblemId(2L)).thenReturn(List.of(99L));
            when(contestParticipantRepository.isUserParticipantOfAnyContest(userId, List.of(99L))).thenReturn(true);
            assertThat(courseSecurity.canAccessContest(2L)).isTrue();
        }

        @Test
        void testCanAccessQuiz() {
            assertThat(courseSecurity.canAccessQuiz(null)).isFalse();

            when(enrollmentRepository.isUserEnrolledInQuiz(userId, 10L)).thenReturn(true);
            assertThat(courseSecurity.canAccessQuiz(10L)).isTrue();
        }
    }

    @Nested
    @DisplayName("canManage Methods Tests")
    class CanManageTests {

        @Test
        void testCanManageLesson() {
            assertThat(courseSecurity.canManageLesson(null)).isFalse();

            when(teacherRepository.findIdByUserId(userId)).thenReturn(null);
            assertThat(courseSecurity.canManageLesson(1L)).isFalse();

            when(teacherRepository.findIdByUserId(userId)).thenReturn(50L);
            when(teacherCourseAssignmentRepository.existsByTeacherIdAndLessonId(50L, 1L)).thenReturn(true);
            assertThat(courseSecurity.canManageLesson(1L)).isTrue();
        }

        @Test
        void testCanManageCourse() {
            assertThat(courseSecurity.canManageCourse(null)).isFalse();

            when(teacherRepository.findIdByUserId(userId)).thenReturn(null);
            assertThat(courseSecurity.canManageCourse(1L)).isFalse();

            when(teacherRepository.findIdByUserId(userId)).thenReturn(50L);
            when(teacherCourseAssignmentRepository.existsByTeacherIdAndCourseId(50L, 1L)).thenReturn(true);
            assertThat(courseSecurity.canManageCourse(1L)).isTrue();
        }

        @Test
        void testCanManageChapter() {
            assertThat(courseSecurity.canManageChapter(null)).isFalse();

            when(teacherRepository.findIdByUserId(userId)).thenReturn(null);
            assertThat(courseSecurity.canManageChapter(1L)).isFalse();

            when(teacherRepository.findIdByUserId(userId)).thenReturn(50L);
            when(teacherCourseAssignmentRepository.existsByTeacherIdAndChapterId(50L, 1L)).thenReturn(true);
            assertThat(courseSecurity.canManageChapter(1L)).isTrue();
        }
    }
}
