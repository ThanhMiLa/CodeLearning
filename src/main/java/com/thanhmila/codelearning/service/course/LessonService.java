package com.thanhmila.codelearning.service.course;

import com.thanhmila.codelearning.dto.response.LessonDetailResponse;
import com.thanhmila.codelearning.entity.course.LessonEntity;
import com.thanhmila.codelearning.entity.enums.EnrollmentStatus;
import com.thanhmila.codelearning.exception.AppException;
import com.thanhmila.codelearning.exception.ErrorCode;
import com.thanhmila.codelearning.mapper.LessonMapper;
import com.thanhmila.codelearning.repository.EnrollmentRepository;
import com.thanhmila.codelearning.repository.LessonRepository;
import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import java.util.List;

@Slf4j
@Service
@RequiredArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE, makeFinal = true)
public class LessonService {
    LessonRepository lessonRepository;
    LessonMapper lessonMapper;
    EnrollmentRepository enrollmentRepository;

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




}
