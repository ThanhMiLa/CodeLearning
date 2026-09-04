package com.thanhmila.codelearning.mapper;

import com.thanhmila.codelearning.dto.response.*;
import com.thanhmila.codelearning.entity.exercise.QuizAttemptEntity;
import com.thanhmila.codelearning.entity.exercise.QuizEntity;
import com.thanhmila.codelearning.entity.exercise.QuizOptionEntity;
import com.thanhmila.codelearning.entity.exercise.QuizQuestionEntity;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.mapstruct.factory.Mappers;

import java.util.List;

import static org.assertj.core.api.Assertions.assertThat;

@DisplayName("QuizMapper Unit Tests")
class QuizMapperTest {

    private final QuizMapper quizMapper = Mappers.getMapper(QuizMapper.class);

    @Test
    @DisplayName("toQuizDetailResponse: Ánh xạ QuizEntity sang QuizDetailResponse")
    void toQuizDetailResponse_MapsCorrectly() {
        QuizEntity quiz = QuizEntity.builder()
                .id(1L)
                .title("Midterm Quiz")
                .description("Test Description")
                .build();

        QuizDetailResponse response = quizMapper.toQuizDetailResponse(quiz);

        assertThat(response).isNotNull();
        assertThat(response.getId()).isEqualTo(1L);
        assertThat(response.getTitle()).isEqualTo("Midterm Quiz");
        assertThat(response.getDescription()).isEqualTo("Test Description");
    }

    @Test
    @DisplayName("toQuizQuestionResponse & toQuizOptionResponse: Ánh xạ câu hỏi và đáp án")
    void toQuizQuestionAndOptionResponse_MapsCorrectly() {
        QuizOptionEntity option = QuizOptionEntity.builder()
                .id(11L)
                .content("Option A")
                .isCorrect(true)
                .build();

        QuizQuestionEntity question = QuizQuestionEntity.builder()
                .id(10L)
                .questionContent("What is Spring?")
                .options(List.of(option))
                .build();

        QuizQuestionResponse questionResponse = quizMapper.toQuizQuestionResponse(question);
        QuizOptionResponse optionResponse = quizMapper.toQuizOptionResponse(option);

        assertThat(questionResponse).isNotNull();
        assertThat(questionResponse.getId()).isEqualTo(10L);
        assertThat(questionResponse.getQuestionContent()).isEqualTo("What is Spring?");
        assertThat(questionResponse.getOptions()).hasSize(1);

        assertThat(optionResponse).isNotNull();
        assertThat(optionResponse.getId()).isEqualTo(11L);
        assertThat(optionResponse.getContent()).isEqualTo("Option A");
    }

    @Test
    @DisplayName("toQuizAttemptResponse & toQuizSubmitResponse: Ánh xạ kết quả làm bài")
    void toQuizAttemptAndSubmitResponse_MapsCorrectly() {
        QuizEntity quiz = QuizEntity.builder().id(5L).title("Final Exam").build();
        QuizAttemptEntity attempt = QuizAttemptEntity.builder()
                .id(99L)
                .quiz(quiz)
                .totalQuestions(10)
                .correctAnswers(8)
                .build();

        QuizAttemptResponse attemptResponse = quizMapper.toQuizAttemptResponse(attempt);
        QuizSubmitResponse submitResponse = quizMapper.toQuizSubmitResponse(attempt);

        assertThat(attemptResponse).isNotNull();
        assertThat(attemptResponse.getId()).isEqualTo(99L);
        assertThat(attemptResponse.getTotalQuestions()).isEqualTo(10);
        assertThat(attemptResponse.getCorrectAnswers()).isEqualTo(8);

        assertThat(submitResponse).isNotNull();
        assertThat(submitResponse.getAttemptId()).isEqualTo(99L);
        assertThat(submitResponse.getQuizId()).isEqualTo(5L);
    }
}
