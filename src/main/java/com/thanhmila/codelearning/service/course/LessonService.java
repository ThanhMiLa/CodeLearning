package com.thanhmila.codelearning.service.course;

import com.thanhmila.codelearning.dto.response.LessonCompletionResponse;
import com.thanhmila.codelearning.dto.response.LessonDetailResponse;
import com.thanhmila.codelearning.entity.course.CourseEntity;
import com.thanhmila.codelearning.entity.course.LessonEntity;
import com.thanhmila.codelearning.entity.enums.EnrollmentStatus;
import com.thanhmila.codelearning.entity.progress.LessonProgressEntity;
import com.thanhmila.codelearning.exception.AppException;
import com.thanhmila.codelearning.exception.ErrorCode;
import com.thanhmila.codelearning.mapper.LessonMapper;
import com.thanhmila.codelearning.repository.CompletedLessonCountRepository;
import com.thanhmila.codelearning.repository.EnrollmentRepository;
import com.thanhmila.codelearning.repository.LessonProgressRepository;
import com.thanhmila.codelearning.repository.LessonRepository;
import com.thanhmila.codelearning.repository.UserRepository;
import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import java.util.List;

@Slf4j
@Service
@RequiredArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE, makeFinal = true)
public class LessonService {
    LessonRepository lessonRepository;
    LessonMapper lessonMapper;
    EnrollmentRepository enrollmentRepository;
    LessonProgressRepository lessonProgressRepository;
    UserRepository userRepository;
    CompletedLessonCountRepository completedLessonCountRepository;

    public LessonDetailResponse getLessonDetail(Long lessonId, Long userId){
        LessonEntity lessonEntity = lessonRepository.findDetailWithCourseById(lessonId)
                .orElseThrow(() -> new AppException(ErrorCode.LESSON_NOT_FOUND));

        if(lessonEntity.getTrial()){
            return lessonMapper.toLessonDetailResponse(lessonEntity);
        }

        if(userId == null){
            throw new AppException(ErrorCode.UNAUTHENTICATED);
        }

        Long courseId = lessonEntity.getChapter().getCourse().getId();
        boolean enrolled = enrollmentRepository.existsByUserIdAndCourseIdAndStatusIn(userId, courseId, List.of(EnrollmentStatus.ACTIVE, EnrollmentStatus.COMPLETED));

        if(!enrolled){
            throw new AppException(ErrorCode.ACCESS_DENIED_COURSE);
        }

        return lessonMapper.toLessonDetailResponse(lessonEntity);
    }

    @Transactional
    public LessonCompletionResponse completedLesson(Long lessonId, Long userId){
       
        Boolean isCompleted = lessonProgressRepository.existsByLessonIdAndUserId(lessonId, userId);

        if(isCompleted){
            throw new AppException(ErrorCode.LESSON_ALREADY_COMPLETED);
        }

        CourseEntity courseEntity = lessonRepository.findCourseByLessonId(lessonId)
                .orElseThrow(() -> new AppException(ErrorCode.COURSE_NOT_FOUND));

        Long courseId = courseEntity.getId();
        Integer totalLessons = courseEntity.getTotalLessons();

        LessonProgressEntity lessonProgress = LessonProgressEntity.builder()
                .lesson(lessonRepository.getReferenceById(lessonId))
                .user(userRepository.getReferenceById(userId))
                .course(courseEntity)
                .build();
        lessonProgressRepository.save(lessonProgress);

        Integer newCountCompletedLesson = completedLessonCountRepository.incrementAndGetCount(userId, courseId);

        boolean isCourseCompleted = newCountCompletedLesson >= totalLessons;
        if(isCourseCompleted){
            enrollmentRepository.updateStatusByUserIdAndCourseId(userId, courseId, EnrollmentStatus.COMPLETED);
        }

        return LessonCompletionResponse.builder()
                .lessonId(lessonId)
                .courseId(courseId)
                .completedLessonsCount(newCountCompletedLesson)
                .totalLessons(totalLessons)
                .isCourseCompleted(isCourseCompleted)
                .build();   
        
    }
}
