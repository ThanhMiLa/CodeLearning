package com.thanhmila.codelearning.service.course;

import com.thanhmila.codelearning.dto.request.QuizRequest;
import com.thanhmila.codelearning.dto.request.QuizSubmitRequest;
import com.thanhmila.codelearning.dto.request.SubmissionDetail;
import com.thanhmila.codelearning.dto.response.QuizAttemptResponse;
import com.thanhmila.codelearning.dto.response.QuizDetailResponse;
import com.thanhmila.codelearning.dto.response.QuizSubmitResponse;
import com.thanhmila.codelearning.entity.course.LessonEntity;
import com.thanhmila.codelearning.entity.exercise.QuizAttemptAnswerEntity;
import com.thanhmila.codelearning.entity.exercise.QuizAttemptEntity;
import com.thanhmila.codelearning.entity.exercise.QuizEntity;
import com.thanhmila.codelearning.entity.exercise.QuizOptionEntity;
import com.thanhmila.codelearning.entity.exercise.QuizQuestionEntity;
import com.thanhmila.codelearning.exception.AppException;
import com.thanhmila.codelearning.exception.ErrorCode;
import com.thanhmila.codelearning.mapper.QuizMapper;
import com.thanhmila.codelearning.repository.LessonRepository;
import com.thanhmila.codelearning.repository.QuizAttemptAnswerRepository;
import com.thanhmila.codelearning.repository.QuizAttemptRepository;
import com.thanhmila.codelearning.repository.QuizOptionRepository;
import com.thanhmila.codelearning.repository.QuizQuestionRepository;
import com.thanhmila.codelearning.repository.QuizRepository;
import com.thanhmila.codelearning.repository.TeacherRepository;
import com.thanhmila.codelearning.repository.UserRepository;
import com.thanhmila.codelearning.repository.projection.CorrectAnswerProjection;
import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import lombok.extern.slf4j.Slf4j;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;
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
    UserRepository userRepository;
    QuizQuestionRepository quizQuestionRepository;
    QuizOptionRepository quizOptionRepository;
    QuizAttemptAnswerRepository quizAttemptAnswerRepository;
    LessonRepository lessonRepository;
    TeacherRepository teacherRepository;

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

    @Transactional
    public QuizSubmitResponse submitQuiz(Long quizId, Long userId, QuizSubmitRequest quizSubmitRequest){
        
        // 1. Lấy đáp án đúng của từng câu
        List<CorrectAnswerProjection> correctAnswerProjections = quizRepository.findCorrectAnswersByQuizId(quizId);
        
        // 2. Map sang Map<QuestionId, CorrectOptionId>
        Map<Long, Long> correctAnswerMap = correctAnswerProjections.stream()
                .collect(Collectors.toMap(
                    CorrectAnswerProjection::getQuestionId, 
                    CorrectAnswerProjection::getCorrectOptionId,
                    (existing, replacement) -> existing
                ));

        int correctAnswers = 0;
        int totalQuestions = correctAnswerProjections.size();

        // 3. Duyệt qua bài nộp để chấm điểm
        for(SubmissionDetail submission : quizSubmitRequest.getSubmissions())
        {
            Long correctOptionId = correctAnswerMap.get(submission.getQuestionId());
            if(correctOptionId != null && correctOptionId.equals(submission.getSelectedOptionId()))
            {
                correctAnswers++;
            }
        }

        double calculatedScore = totalQuestions == 0 ? 0.0 : (correctAnswers / (double) totalQuestions) * 10.0;

        // 4. Lưu lịch sử Attempt (QuizAttemptEntity)
        QuizAttemptEntity quizAttemptEntity = QuizAttemptEntity.builder()
                .user(userRepository.getReferenceById(userId))
                .quiz(quizRepository.getReferenceById(quizId))
                .totalQuestions(totalQuestions)
                .correctAnswers(correctAnswers)
                .score(BigDecimal.valueOf(calculatedScore))
                .build();
       quizAttemptEntity = quizAttemptRepository.save(quizAttemptEntity);

       // 5. Lưu chi tiết câu trả lời
       List<QuizAttemptAnswerEntity> attemptAnswersToSave = new ArrayList<>();

       for(SubmissionDetail submission : quizSubmitRequest.getSubmissions())
        {
            var selectedOptionRef = submission.getSelectedOptionId() != null ? 
                quizOptionRepository.getReferenceById(submission.getSelectedOptionId()) : null;

            attemptAnswersToSave.add(QuizAttemptAnswerEntity.builder()
                    .attempt(quizAttemptEntity)
                    .question(quizQuestionRepository.getReferenceById(submission.getQuestionId()))
                    .selectedOption(selectedOptionRef)
                    .build());
        }

        quizAttemptAnswerRepository.saveAll(attemptAnswersToSave);
    
        return quizMapper.toQuizSubmitResponse(quizAttemptEntity);
    }


    @Transactional
    public void createQuiz(Long lessonId, Long userId, QuizRequest request) {

        // Kiểm tra xem bài học đã có quiz chưa
        if(quizRepository.existsByLessonId(lessonId)){
            throw new AppException(ErrorCode.QUIZ_ALREADY_EXISTS);
        }
        
        if(request.getQuestions() == null || request.getQuestions().isEmpty()){
            throw new AppException(ErrorCode.QUIZ_QUESTIONS_EMPTY);
        }
        
        Long teacherId = teacherRepository.findIdByUserId(userId);
        if (teacherId == null) {
            throw new AppException(ErrorCode.ACCESS_DENIED);
        }

        // Lấy LessonEntity
        LessonEntity lessonEntity = lessonRepository.findById(lessonId)
                .orElseThrow(() -> new AppException(ErrorCode.LESSON_NOT_FOUND));

        // Tạo QuizEntity
        QuizEntity quizEntity = QuizEntity.builder()
                .lesson(lessonEntity)
                .createdByTeacher(teacherRepository.getReferenceById(teacherId))
                .title(request.getTitle())
                .description(request.getDescription())
                .build();
        
        // Map Questions và Options từ DTO sang Entity
        List<QuizQuestionEntity> questions = request.getQuestions().stream().map(questionRequest -> {
            
            // Validate ít nhất 1 đáp án đúng
            boolean isCorrectOption = questionRequest.getOptions().stream().
                anyMatch(optionRequest -> Boolean.TRUE.equals(optionRequest.getIsCorrect()));
                
            if(!isCorrectOption){
                throw new AppException(ErrorCode.QUIZ_QUESTION_CORRECT_OPTION_INVALID);
            }

            // Tạo Question Entity
            QuizQuestionEntity questionEntity = QuizQuestionEntity.builder()
                .quiz(quizEntity)
                .questionContent(questionRequest.getQuestionContent())
                .orderIndex(questionRequest.getOrderIndex())
                .build();
            
            // Map Options sang Entity
            List<QuizOptionEntity> options = questionRequest.getOptions().stream().map(optionRequest -> {
                return QuizOptionEntity.builder()
                    .question(questionEntity)
                    .content(optionRequest.getContent())
                    .isCorrect(optionRequest.getIsCorrect())
                    .orderIndex(optionRequest.getOrderIndex())
                    .build();
            }).collect(Collectors.toList());

            questionEntity.setOptions(options);
            return questionEntity;
        }).collect(Collectors.toList());

        quizEntity.setQuestions(questions);
        quizRepository.save(quizEntity);

        lessonEntity.setHasQuiz(true);
    }
    
    private Double getScore(QuizAttemptEntity quizAttemptEntity){

        Integer totalQuestion = quizAttemptEntity.getTotalQuestions();
        Integer correctAnswers = quizAttemptEntity.getCorrectAnswers();
        if (totalQuestion == null || totalQuestion == 0 || correctAnswers == null) {
            return 0.0;
        }
        return correctAnswers * 10.0 / totalQuestion;   
    }

}
