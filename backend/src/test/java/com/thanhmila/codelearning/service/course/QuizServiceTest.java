package com.thanhmila.codelearning.service.course;

import com.thanhmila.codelearning.dto.request.QuizOptionRequest;
import com.thanhmila.codelearning.dto.request.QuizQuestionRequest;
import com.thanhmila.codelearning.dto.request.QuizRequest;
import com.thanhmila.codelearning.dto.request.QuizSubmitRequest;
import com.thanhmila.codelearning.dto.request.SubmissionDetail;
import com.thanhmila.codelearning.dto.response.QuizAttemptResponse;
import com.thanhmila.codelearning.dto.response.QuizDetailResponse;
import com.thanhmila.codelearning.dto.response.QuizQuestionResponse;
import com.thanhmila.codelearning.dto.response.QuizSubmitResponse;
import com.thanhmila.codelearning.entity.exercise.QuizAttemptAnswerEntity;
import com.thanhmila.codelearning.entity.exercise.QuizAttemptEntity;
import com.thanhmila.codelearning.entity.exercise.QuizEntity;
import com.thanhmila.codelearning.entity.exercise.QuizOptionEntity;
import com.thanhmila.codelearning.entity.exercise.QuizQuestionEntity;
import com.thanhmila.codelearning.entity.lesson.LessonEntity;
import com.thanhmila.codelearning.exception.AppException;
import com.thanhmila.codelearning.exception.ErrorCode;
import com.thanhmila.codelearning.mapper.QuizMapper;
import com.thanhmila.codelearning.repository.lesson.LessonRepository;
import com.thanhmila.codelearning.repository.projection.CorrectAnswerProjection;
import com.thanhmila.codelearning.repository.quiz.QuizAttemptAnswerRepository;
import com.thanhmila.codelearning.repository.quiz.QuizAttemptRepository;
import com.thanhmila.codelearning.repository.quiz.QuizOptionRepository;
import com.thanhmila.codelearning.repository.quiz.QuizQuestionRepository;
import com.thanhmila.codelearning.repository.quiz.QuizRepository;
import com.thanhmila.codelearning.repository.user.TeacherRepository;
import com.thanhmila.codelearning.repository.user.UserRepository;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Nested;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.Optional;

import static org.assertj.core.api.Assertions.assertThat;
import static org.assertj.core.api.Assertions.assertThatThrownBy;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.Mockito.*;

@ExtendWith(MockitoExtension.class)
@DisplayName("QuizService Unit Tests")
class QuizServiceTest {

    @Mock QuizRepository quizRepository;
    @Mock QuizAttemptRepository quizAttemptRepository;
    @Mock QuizMapper quizMapper;
    @Mock UserRepository userRepository;
    @Mock QuizQuestionRepository quizQuestionRepository;
    @Mock QuizOptionRepository quizOptionRepository;
    @Mock QuizAttemptAnswerRepository quizAttemptAnswerRepository;
    @Mock LessonRepository lessonRepository;
    @Mock TeacherRepository teacherRepository;

    @InjectMocks QuizService quizService;

    @Nested
    @DisplayName("getQuizDetail Tests")
    class GetQuizDetailTests {

        @Test
        @DisplayName("Quiz not found throws QUIZ_NOT_FOUND")
        void shouldThrow_WhenQuizNotFound() {
            when(quizRepository.findQuizByLessonId(1L)).thenReturn(Optional.empty());

            assertThatThrownBy(() -> quizService.getQuizDetail(1L, 10L))
                    .isInstanceOf(AppException.class)
                    .hasFieldOrPropertyWithValue("errorCode", ErrorCode.QUIZ_NOT_FOUND);
        }

        @Test
        @DisplayName("Returns quiz without pastAttempt when user has not attempted before")
        void shouldReturnQuiz_WithoutPastAttempt_WhenNoPriorAttempt() {
            QuizEntity quiz = QuizEntity.builder().id(5L).build();
            QuizDetailResponse detailResponse = QuizDetailResponse.builder().id(5L).build();

            when(quizRepository.findQuizByLessonId(1L)).thenReturn(Optional.of(quiz));
            when(quizMapper.toQuizDetailResponse(quiz)).thenReturn(detailResponse);
            when(quizAttemptRepository.findLatestAttemptByLesson(5L, 10L)).thenReturn(Optional.empty());

            QuizDetailResponse result = quizService.getQuizDetail(1L, 10L);

            assertThat(result).isNotNull();
            assertThat(result.getPastAttempt()).isNull();
        }

        @Test
        @DisplayName("Returns quiz with pastAttempt and user answers mapped when user has attempted")
        void shouldReturnQuiz_WithPastAttempt_WhenAttemptExists() {
            QuizEntity quiz = QuizEntity.builder().id(5L).build();
            QuizQuestionEntity question = QuizQuestionEntity.builder().id(100L).build();
            QuizOptionEntity option = QuizOptionEntity.builder().id(200L).build();

            QuizAttemptAnswerEntity answer = QuizAttemptAnswerEntity.builder()
                    .question(question)
                    .selectedOption(option)
                    .build();

            QuizAttemptEntity attempt = QuizAttemptEntity.builder()
                    .id(1L)
                    .totalQuestions(1)
                    .correctAnswers(1)
                    .answers(List.of(answer))
                    .build();

            QuizQuestionResponse qResponse = QuizQuestionResponse.builder().id(100L).build();
            QuizDetailResponse detailResponse = QuizDetailResponse.builder()
                    .id(5L)
                    .questions(new ArrayList<>(List.of(qResponse)))
                    .build();

            when(quizRepository.findQuizByLessonId(1L)).thenReturn(Optional.of(quiz));
            when(quizMapper.toQuizDetailResponse(quiz)).thenReturn(detailResponse);
            when(quizAttemptRepository.findLatestAttemptByLesson(5L, 10L)).thenReturn(Optional.of(attempt));
            when(quizMapper.toQuizAttemptResponse(attempt)).thenReturn(QuizAttemptResponse.builder().id(1L).build());

            QuizDetailResponse result = quizService.getQuizDetail(1L, 10L);

            assertThat(result.getPastAttempt()).isNotNull();
            assertThat(result.getPastAttempt().getScore()).isEqualTo(10.0);
            assertThat(result.getQuestions().get(0).getUserSelectedOptionId()).isEqualTo(200L);
        }
    }

    @Nested
    @DisplayName("submitQuiz Tests")
    class SubmitQuizTests {

        private CorrectAnswerProjection createProjection(Long qId, Long optId) {
            return new CorrectAnswerProjection() {
                @Override public Long getQuestionId() { return qId; }
                @Override public Long getCorrectOptionId() { return optId; }
            };
        }

        @Test
        @DisplayName("Submit quiz grades correctly and saves attempt")
        void shouldSubmitAndGradeSuccessfully() {
            Long quizId = 1L;
            Long userId = 10L;

            List<CorrectAnswerProjection> projections = List.of(
                    createProjection(101L, 201L),
                    createProjection(102L, 202L)
            );

            when(quizRepository.findCorrectAnswersByQuizId(quizId)).thenReturn(projections);

            QuizSubmitRequest request = QuizSubmitRequest.builder()
                    .submissions(java.util.Set.of(
                            SubmissionDetail.builder().questionId(101L).selectedOptionId(201L).build(), // correct
                            SubmissionDetail.builder().questionId(102L).selectedOptionId(999L).build()  // wrong
                    ))
                    .build();

            QuizAttemptEntity savedAttempt = QuizAttemptEntity.builder().id(50L).build();
            when(quizAttemptRepository.save(any(QuizAttemptEntity.class))).thenReturn(savedAttempt);
            when(quizMapper.toQuizSubmitResponse(any())).thenReturn(QuizSubmitResponse.builder().score(java.math.BigDecimal.valueOf(5.0)).totalQuestions(2).correctAnswers(1).build());

            QuizSubmitResponse response = quizService.submitQuiz(quizId, userId, request);

            assertThat(response).isNotNull();
            assertThat(response.getScore()).isEqualByComparingTo(java.math.BigDecimal.valueOf(5.0));
            assertThat(response.getCorrectAnswers()).isEqualTo(1);
            verify(quizAttemptAnswerRepository).saveAll(any());
        }
    }

    @Nested
    @DisplayName("createQuiz Tests")
    class CreateQuizTests {

        @Test
        @DisplayName("Quiz already exists throws QUIZ_ALREADY_EXISTS")
        void shouldThrow_WhenQuizAlreadyExists() {
            when(quizRepository.existsByLessonId(1L)).thenReturn(true);

            assertThatThrownBy(() -> quizService.createQuiz(1L, 10L, new QuizRequest()))
                    .isInstanceOf(AppException.class)
                    .hasFieldOrPropertyWithValue("errorCode", ErrorCode.QUIZ_ALREADY_EXISTS);
        }

        @Test
        @DisplayName("Questions empty throws QUIZ_QUESTIONS_EMPTY")
        void shouldThrow_WhenQuestionsEmpty() {
            when(quizRepository.existsByLessonId(1L)).thenReturn(false);

            QuizRequest request = QuizRequest.builder().questions(Collections.emptyList()).build();

            assertThatThrownBy(() -> quizService.createQuiz(1L, 10L, request))
                    .isInstanceOf(AppException.class)
                    .hasFieldOrPropertyWithValue("errorCode", ErrorCode.QUIZ_QUESTIONS_EMPTY);
        }

        @Test
        @DisplayName("Teacher not found throws ACCESS_DENIED")
        void shouldThrow_WhenNotTeacher() {
            when(quizRepository.existsByLessonId(1L)).thenReturn(false);
            when(teacherRepository.findIdByUserId(10L)).thenReturn(null);

            QuizRequest request = QuizRequest.builder()
                    .questions(List.of(QuizQuestionRequest.builder().questionContent("Q1").build()))
                    .build();

            assertThatThrownBy(() -> quizService.createQuiz(1L, 10L, request))
                    .isInstanceOf(AppException.class)
                    .hasFieldOrPropertyWithValue("errorCode", ErrorCode.ACCESS_DENIED);
        }

        @Test
        @DisplayName("Lesson not found throws LESSON_NOT_FOUND")
        void shouldThrow_WhenLessonNotFound() {
            when(quizRepository.existsByLessonId(1L)).thenReturn(false);
            when(teacherRepository.findIdByUserId(10L)).thenReturn(5L);
            when(lessonRepository.findById(1L)).thenReturn(Optional.empty());

            QuizRequest request = QuizRequest.builder()
                    .questions(List.of(QuizQuestionRequest.builder().questionContent("Q1").build()))
                    .build();

            assertThatThrownBy(() -> quizService.createQuiz(1L, 10L, request))
                    .isInstanceOf(AppException.class)
                    .hasFieldOrPropertyWithValue("errorCode", ErrorCode.LESSON_NOT_FOUND);
        }

        @Test
        @DisplayName("Question without correct option throws QUIZ_QUESTION_CORRECT_OPTION_INVALID")
        void shouldThrow_WhenNoCorrectOption() {
            when(quizRepository.existsByLessonId(1L)).thenReturn(false);
            when(teacherRepository.findIdByUserId(10L)).thenReturn(5L);
            when(lessonRepository.findById(1L)).thenReturn(Optional.of(new LessonEntity()));

            QuizQuestionRequest qReq = QuizQuestionRequest.builder()
                    .questionContent("Q1")
                    .options(List.of(
                            QuizOptionRequest.builder().content("A").isCorrect(false).build(),
                            QuizOptionRequest.builder().content("B").isCorrect(false).build()
                    ))
                    .build();

            QuizRequest request = QuizRequest.builder().questions(List.of(qReq)).build();

            assertThatThrownBy(() -> quizService.createQuiz(1L, 10L, request))
                    .isInstanceOf(AppException.class)
                    .hasFieldOrPropertyWithValue("errorCode", ErrorCode.QUIZ_QUESTION_CORRECT_OPTION_INVALID);
        }

        @Test
        @DisplayName("Valid request creates and saves quiz")
        void shouldCreateQuizSuccessfully() {
            when(quizRepository.existsByLessonId(1L)).thenReturn(false);
            when(teacherRepository.findIdByUserId(10L)).thenReturn(5L);
            when(lessonRepository.findById(1L)).thenReturn(Optional.of(new LessonEntity()));

            QuizQuestionRequest qReq = QuizQuestionRequest.builder()
                    .questionContent("Q1")
                    .options(List.of(
                            QuizOptionRequest.builder().content("A").isCorrect(true).build(),
                            QuizOptionRequest.builder().content("B").isCorrect(false).build()
                    ))
                    .build();

            QuizRequest request = QuizRequest.builder()
                    .title("Quiz 1")
                    .description("Desc")
                    .questions(List.of(qReq))
                    .build();

            quizService.createQuiz(1L, 10L, request);

            verify(quizRepository).save(any(QuizEntity.class));
        }
    }
}
