package com.thanhmila.codelearning.service.user;

import com.thanhmila.codelearning.dto.response.CourseProgressResponse;
import com.thanhmila.codelearning.entity.course.CourseEntity;
import com.thanhmila.codelearning.entity.enums.UserStatus;
import com.thanhmila.codelearning.entity.progress.CompletedLessonsCountEntity;
import com.thanhmila.codelearning.entity.user.UserEntity;
import com.thanhmila.codelearning.exception.AppException;
import com.thanhmila.codelearning.exception.ErrorCode;
import com.thanhmila.codelearning.repository.CompletedLessonCountRepository;
import com.thanhmila.codelearning.repository.EnrollmentRepository;
import com.thanhmila.codelearning.repository.UserRepository;
import com.thanhmila.codelearning.util.ProgressUtils;

import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import lombok.extern.slf4j.Slf4j;
import java.util.Collections;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.stream.Collectors;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Slf4j
@Service
@RequiredArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE, makeFinal = true)
public class ProgressService {
    EnrollmentRepository enrollmentRepository;
    CompletedLessonCountRepository completedLessonCountRepository;
    UserRepository userRepository;

    @Transactional(readOnly = true)
    public List<CourseProgressResponse> getCourseProgress(Long userId) {
        UserEntity userEntity = userRepository.findById(userId)
                .orElseThrow(() -> new AppException(ErrorCode.USER_NOT_FOUND));
        userEntity.validateStatus();

        // Danh sách course mà người dùng đã đăng ký
        Set<CourseEntity> courses = enrollmentRepository.findActiveCoursesByUserId(userId);
        Set<Long> courseIds = courses.stream()
                .map(CourseEntity::getId)
                .collect(Collectors.toSet());

        if (courses.isEmpty()) {
            return Collections.emptyList();
        }

        Map<Long, Integer> progressMap = completedLessonCountRepository.findByUserIdAndCourseIdIn(userId, courseIds)
                .stream()
                .collect(Collectors.toMap(
                        clc -> clc.getCourse().getId(),
                        CompletedLessonsCountEntity::getCompletedLessonsCount,
                        (existing, replacement) -> existing));

        return courses.stream()
                .map(course -> {
                    int completedLessons = progressMap.getOrDefault(course.getId(), 0);
                    int totalLessons = course.getTotalLessons();
                    int progressPercentage = ProgressUtils.calculatePercentage(completedLessons, totalLessons);

                    return CourseProgressResponse.builder()
                            .courseId(course.getId())
                            .title(course.getTitle())
                            .thumbnailUrl(course.getThumbnailUrl())
                            .totalLessons(totalLessons)
                            .completedLessons(completedLessons)
                            .completionPercentage(progressPercentage)
                            .build();
                }).collect(Collectors.toList());
    }

}
