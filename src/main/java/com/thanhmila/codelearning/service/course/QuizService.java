package com.thanhmila.codelearning.service.course;

import com.thanhmila.codelearning.dto.response.QuizDetailResponse;
import com.thanhmila.codelearning.exception.AppException;
import com.thanhmila.codelearning.exception.ErrorCode;
import com.thanhmila.codelearning.mapper.QuizMapper;
import com.thanhmila.codelearning.repository.QuizRepository;
import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

@Slf4j
@Service
@RequiredArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE, makeFinal = true)
public class QuizService {
    QuizRepository quizRepository;
    QuizMapper quizMapper;

    public QuizDetailResponse getQuizDetail(Long lessonId){
        return quizRepository.findQuizByLessonId(lessonId)
                .map(quizMapper::toQuizDetailResponse)
                .orElseThrow(() -> new AppException(ErrorCode.QUIZ_NOT_FOUND));
    }

}
