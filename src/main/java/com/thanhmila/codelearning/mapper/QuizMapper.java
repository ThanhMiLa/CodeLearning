package com.thanhmila.codelearning.mapper;

import com.thanhmila.codelearning.dto.response.QuizOptionResponse;
import com.thanhmila.codelearning.dto.response.QuizQuestionResponse;
import com.thanhmila.codelearning.dto.response.QuizDetailResponse;
import com.thanhmila.codelearning.entity.exercise.QuizEntity;
import com.thanhmila.codelearning.entity.exercise.QuizOptionEntity;
import com.thanhmila.codelearning.entity.exercise.QuizQuestionEntity;
import org.mapstruct.Mapper;

@Mapper(componentModel = "spring")
public interface QuizMapper {

    QuizDetailResponse toQuizDetailResponse(QuizEntity quizEntity);
    QuizQuestionResponse toQuizQuestionResponse(QuizQuestionEntity quizQuestionEntity);
    QuizOptionResponse toQuizOptionResponse(QuizOptionEntity quizOptionEntity);

}
