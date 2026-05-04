package com.thanhmila.codelearning.service.course;

import com.thanhmila.codelearning.dto.response.QuizAttemptResponse;
import com.thanhmila.codelearning.dto.response.QuizDetailResponse;
import com.thanhmila.codelearning.entity.exercise.QuizAttemptEntity;
import com.thanhmila.codelearning.entity.exercise.QuizEntity;
import com.thanhmila.codelearning.exception.AppException;
import com.thanhmila.codelearning.exception.ErrorCode;
import com.thanhmila.codelearning.mapper.QuizMapper;
import com.thanhmila.codelearning.repository.QuizAttemptRepository;
import com.thanhmila.codelearning.repository.QuizRepository;
import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import lombok.extern.slf4j.Slf4j;
import java.util.Map;
import java.util.stream.Collectors;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Slf4j
@Service
@RequiredArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE, makeFinal = true)
public class QuizService {
    QuizRepository quizRepository;
    QuizAttemptRepository quizAttemptRepository;
    QuizMapper quizMapper;

    @Transactional(readOnly = true)
    public QuizDetailResponse getQuizDetail(Long lessonId, Long userId){
        // 1. Lấy thông tin Quiz và Map ra DTO cơ bản (Kích hoạt sẵn Batch Size)
        QuizEntity quizEntity = quizRepository.findQuizByLessonId(lessonId)
                .orElseThrow(() -> new AppException(ErrorCode.QUIZ_NOT_FOUND));
        QuizDetailResponse quizDetailResponse = quizMapper.toQuizDetailResponse(quizEntity);

        // 2. Lấy lịch sử làm bài (Attempt) gần nhất của User
        QuizAttemptEntity quizAttempEntity = quizAttemptRepository.findLatestAttemptByLesson(quizEntity.getId(), userId)
                .orElse(null);

        // 3. Xử lý lắp ghép nếu User đã từng làm bài
        if(quizAttempEntity != null){
            // 3.1. Map thông tin tổng quan điểm số
            QuizAttemptResponse quizAttemptResponse = quizMapper.toQuizAttemptResponse(quizAttempEntity);
            quizAttemptResponse.setScore(getScore(quizAttempEntity));
            quizDetailResponse.setPastAttempt(quizAttemptResponse);

            // 3.2. Biến danh sách câu trả lời thành Map<QuestionId, OptionId>
            // Lọc bỏ những câu user để trống (getSelectedOption() == null) để tránh NullPointerException
            if (quizAttempEntity.getAnswers() != null) {
                Map<Long, Long> userAnswersMap = quizAttempEntity.getAnswers().stream()
                        .filter(answer -> answer.getSelectedOption() != null && answer.getQuestion() != null)
                        .collect(Collectors.toMap(
                            answer -> answer.getQuestion().getId(),
                            answer -> answer.getSelectedOption().getId(),
                            (existing, replacement) -> existing // Xử lý nếu bị trùng lặp QuestionId
                        ));

                // 3.3. Lặp qua danh sách DTO Questions và "nhét" ID option đã chọn vào
                if (quizDetailResponse.getQuestions() != null) {
                    quizDetailResponse.getQuestions().forEach(question -> {
                        Long selectedOptionId = userAnswersMap.get(question.getId());
                        if(selectedOptionId != null){
                            question.setUserSelectedOptionId(selectedOptionId);
                        }
                    });        
                }
            }
        }
                
        return quizDetailResponse;
    }


    private Double getScore(QuizAttemptEntity quizAttemptEntity){
        Integer totalQuestion = quizAttemptEntity.getTotalQuestions();
        Integer correctAnswers = quizAttemptEntity.getCorrectAnswers();
        if (totalQuestion == null || totalQuestion == 0 || correctAnswers == null) {
            return 0.0;
        }
        return correctAnswers * 100.0 / totalQuestion;   
    }

}
