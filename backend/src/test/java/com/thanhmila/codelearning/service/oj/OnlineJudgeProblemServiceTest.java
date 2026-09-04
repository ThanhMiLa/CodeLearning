package com.thanhmila.codelearning.service.oj;

import com.thanhmila.codelearning.dto.request.CreateOjProblemRequest;
import com.thanhmila.codelearning.dto.request.ProblemSearchRequest;
import com.thanhmila.codelearning.dto.response.OjPracticeProblemResponse;
import com.thanhmila.codelearning.dto.response.PageResponse;
import com.thanhmila.codelearning.entity.enums.OjVerdict;
import com.thanhmila.codelearning.entity.enums.ProblemDifficulty;
import com.thanhmila.codelearning.entity.enums.ProblemScope;
import com.thanhmila.codelearning.entity.oj.OnlineJudgeProblemEntity;
import com.thanhmila.codelearning.entity.user.TeacherEntity;
import com.thanhmila.codelearning.exception.AppException;
import com.thanhmila.codelearning.exception.ErrorCode;
import com.thanhmila.codelearning.mapper.OjProblemMapper;
import com.thanhmila.codelearning.mapper.OjSubmissionMapper;
import com.thanhmila.codelearning.repository.oj.OnlineJudgeProblemRepository;
import com.thanhmila.codelearning.repository.oj.OnlineJudgeSubmissionRepository;
import com.thanhmila.codelearning.repository.oj.ProblemTagRepository;
import com.thanhmila.codelearning.repository.user.TeacherRepository;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Nested;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageImpl;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.domain.Specification;

import java.util.List;
import java.util.Optional;
import java.util.Set;

import static org.assertj.core.api.Assertions.assertThat;
import static org.assertj.core.api.Assertions.assertThatThrownBy;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.ArgumentMatchers.eq;
import static org.mockito.Mockito.*;

@ExtendWith(MockitoExtension.class)
@DisplayName("OnlineJudgeProblemService Unit Tests")
class OnlineJudgeProblemServiceTest {

    @Mock OnlineJudgeProblemRepository onlineJudgeProblemRepository;
    @Mock OnlineJudgeSubmissionRepository onlineJudgeSubmissionRepository;
    @Mock TeacherRepository teacherRepository;
    @Mock OjProblemMapper ojProblemMapper;
    @Mock ProblemTagRepository problemTagRepository;
    @Mock OjSubmissionMapper ojSubmissionMapper;

    @InjectMocks OnlineJudgeProblemService problemService;

    @Nested
    @DisplayName("getPracticeProblems Tests")
    class GetPracticeProblemsTests {

        @Test
        @DisplayName("Returns practice problems with isAccepted false for anonymous user")
        void shouldReturnProblems_ForAnonymousUser() {
            OnlineJudgeProblemEntity problem = OnlineJudgeProblemEntity.builder()
                    .id(1L)
                    .title("Two Sum")
                    .difficulty(ProblemDifficulty.EASY)
                    .acceptanceRate(85.5)
                    .build();
            Page<OnlineJudgeProblemEntity> page = new PageImpl<>(List.of(problem));
            ProblemSearchRequest request = new ProblemSearchRequest();
            request.setPage(0);
            request.setSize(10);

            when(onlineJudgeProblemRepository.findAll(any(Specification.class), any(Pageable.class))).thenReturn(page);

            PageResponse<OjPracticeProblemResponse> response = problemService.getPracticeProblems(request, null);

            assertThat(response).isNotNull();
            assertThat(response.getContent()).hasSize(1);
            assertThat(response.getContent().get(0).getTitle()).isEqualTo("Two Sum");
            assertThat(response.getContent().get(0).getIsAccepted()).isFalse();
            verify(onlineJudgeSubmissionRepository, never()).findProblemIdsByUserIdAndProblemIdsAndVerdict(any(), any(), any());
        }

        @Test
        @DisplayName("Returns practice problems with isAccepted true when user has solved")
        void shouldReturnProblems_WithIsAcceptedTrue_ForSolvedProblem() {
            OnlineJudgeProblemEntity problem = OnlineJudgeProblemEntity.builder()
                    .id(1L)
                    .title("Two Sum")
                    .difficulty(ProblemDifficulty.EASY)
                    .acceptanceRate(85.5)
                    .build();
            Page<OnlineJudgeProblemEntity> page = new PageImpl<>(List.of(problem));
            ProblemSearchRequest request = new ProblemSearchRequest();
            request.setPage(0);
            request.setSize(10);

            when(onlineJudgeProblemRepository.findAll(any(Specification.class), any(Pageable.class))).thenReturn(page);
            when(onlineJudgeSubmissionRepository.findProblemIdsByUserIdAndProblemIdsAndVerdict(eq(10L), eq(List.of(1L)), eq(OjVerdict.ACCEPTED)))
                    .thenReturn(Set.of(1L));

            PageResponse<OjPracticeProblemResponse> response = problemService.getPracticeProblems(request, 10L);

            assertThat(response).isNotNull();
            assertThat(response.getContent().get(0).getIsAccepted()).isTrue();
        }
    }

    @Nested
    @DisplayName("createProblemInBank Tests")
    class CreateProblemInBankTests {

        @Test
        @DisplayName("SHARED scope throws INVALID_REQUEST_BODY")
        void shouldThrow_WhenSharedScope() {
            CreateOjProblemRequest request = CreateOjProblemRequest.builder()
                    .problemScope(ProblemScope.SHARED)
                    .build();

            assertThatThrownBy(() -> problemService.createProblemInBank(request, 10L))
                    .isInstanceOf(AppException.class)
                    .hasFieldOrPropertyWithValue("errorCode", ErrorCode.INVALID_REQUEST_BODY);
        }

        @Test
        @DisplayName("Non-teacher throws USER_NOT_FOUND")
        void shouldThrow_WhenNotTeacher() {
            CreateOjProblemRequest request = CreateOjProblemRequest.builder()
                    .problemScope(ProblemScope.PRACTICE)
                    .build();

            when(teacherRepository.findIdByUserId(10L)).thenReturn(null);

            assertThatThrownBy(() -> problemService.createProblemInBank(request, 10L))
                    .isInstanceOf(AppException.class)
                    .hasFieldOrPropertyWithValue("errorCode", ErrorCode.USER_NOT_FOUND);
        }

        @Test
        @DisplayName("Valid creation saves problem and returns ID")
        void shouldCreateProblemSuccessfully() {
            CreateOjProblemRequest request = CreateOjProblemRequest.builder()
                    .title("Problem 1")
                    .problemScope(ProblemScope.PRACTICE)
                    .build();
            OnlineJudgeProblemEntity entity = OnlineJudgeProblemEntity.builder().id(99L).build();
            TeacherEntity teacher = TeacherEntity.builder().id(5L).build();

            when(teacherRepository.findIdByUserId(10L)).thenReturn(5L);
            when(ojProblemMapper.toEntity(request)).thenReturn(entity);
            when(teacherRepository.getReferenceById(5L)).thenReturn(teacher);

            Long problemId = problemService.createProblemInBank(request, 10L);

            assertThat(problemId).isEqualTo(99L);
            verify(onlineJudgeProblemRepository).save(entity);
        }
    }

    @Nested
    @DisplayName("updateProblemVisibility Tests")
    class UpdateProblemVisibilityTests {

        @Test
        @DisplayName("Problem not found throws OJ_PROBLEM_NOT_FOUND")
        void shouldThrow_WhenProblemNotFound() {
            when(onlineJudgeProblemRepository.findById(1L)).thenReturn(Optional.empty());

            assertThatThrownBy(() -> problemService.updateProblemVisibility(1L, true))
                    .isInstanceOf(AppException.class)
                    .hasFieldOrPropertyWithValue("errorCode", ErrorCode.OJ_PROBLEM_NOT_FOUND);
        }

        @Test
        @DisplayName("Updates visibility flag and saves")
        void shouldUpdateVisibilitySuccessfully() {
            OnlineJudgeProblemEntity problem = OnlineJudgeProblemEntity.builder().id(1L).isPublic(false).build();
            when(onlineJudgeProblemRepository.findById(1L)).thenReturn(Optional.of(problem));

            problemService.updateProblemVisibility(1L, true);

            assertThat(problem.getIsPublic()).isTrue();
            verify(onlineJudgeProblemRepository).save(problem);
        }
    }
}
