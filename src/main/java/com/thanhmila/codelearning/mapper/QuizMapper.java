package com.thanhmila.codelearning.mapper;

import com.thanhmila.codelearning.dto.response.QuizOptionResponse;
import com.thanhmila.codelearning.dto.response.QuizQuestionResponse;
import com.thanhmila.codelearning.dto.response.QuizAttemptResponse;
import com.thanhmila.codelearning.dto.response.QuizDetailResponse;
import com.thanhmila.codelearning.entity.exercise.QuizAttemptEntity;
import com.thanhmila.codelearning.entity.exercise.QuizEntity;
import com.thanhmila.codelearning.entity.exercise.QuizOptionEntity;
import com.thanhmila.codelearning.entity.exercise.QuizQuestionEntity;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;

@Mapper(componentModel = "spring")
public interface QuizMapper {

    @Mapping(target = "pastAttempt", ignore = true)
    QuizDetailResponse toQuizDetailResponse(QuizEntity quizEntity);

    @Mapping(target = "userSelectedOptionId", ignore = true)
    QuizQuestionResponse toQuizQuestionResponse(QuizQuestionEntity quizQuestionEntity);

    QuizOptionResponse toQuizOptionResponse(QuizOptionEntity quizOptionEntity);

    @Mapping(target = "score", ignore = true)
    QuizAttemptResponse toQuizAttemptResponse(QuizAttemptEntity quizAttemptEntity);

}
