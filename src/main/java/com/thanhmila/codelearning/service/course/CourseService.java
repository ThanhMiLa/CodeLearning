package com.thanhmila.codelearning.service.course;

import com.thanhmila.codelearning.dto.response.CourseListItemResponse;
import com.thanhmila.codelearning.dto.response.PageResponse;
import com.thanhmila.codelearning.entity.CompletedLessonsCountEntity;
import com.thanhmila.codelearning.entity.CourseEntity;
import com.thanhmila.codelearning.entity.UserEntity;
import com.thanhmila.codelearning.entity.enums.CourseStatus;
import com.thanhmila.codelearning.entity.enums.EnrollmentStatus;
import com.thanhmila.codelearning.repository.*;
import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import lombok.extern.slf4j.Slf4j;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import java.util.List;

@Slf4j
@Service
@RequiredArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE, makeFinal = true)
public class CourseService {
    CourseRepository courseRepository;
    CompletedLessonCountRepository completedLessonCountRepository;
    LessonRepository lessonRepository;
    EnrollmentRepository enrollmentRepository;
    UserRepository userRepository;
    CourseReviewRepository courseReviewRepository;

    public PageResponse<CourseListItemResponse> getCourseList(String username, Pageable pageable){
        Page<CourseEntity> courseEntityPage = courseRepository.findAllByStatus(CourseStatus.ACTIVE, pageable);

        Long userId = getUserIdOrNull(username);

        Page<CourseListItemResponse> responsePage = courseEntityPage.map(courseEntity ->
            buildCourseListItemResponse(courseEntity, userId)
        );

        return PageResponse.from(responsePage);
    }

    private CourseListItemResponse buildCourseListItemResponse(CourseEntity courseEntity, Long userId){
        Long courseId = courseEntity.getId();

        Boolean enrolled = isUserEnrolled(userId, courseId);

        return CourseListItemResponse.builder()
                .id(courseEntity.getId())
                .title(courseEntity.getTitle())
                .price(courseEntity.getPrice())
                .shortDescription(courseEntity.getShortDescription())
                .thumbnailUrl(courseEntity.getThumbnailUrl())
                .totalReviews(courseReviewRepository.countByCourseId(courseEntity.getId()))
                .averageRating(courseReviewRepository.getAverageRatingByCourseId(courseEntity.getId()))
                .enrolled(enrolled)
                .progressPercentage(enrolled ? getProgressPercentage(userId, courseId) : null)
                .build();
    }

    private Boolean isUserEnrolled(Long userId, Long courseId){
        if(userId == null)
            return false;

        return enrollmentRepository.existsByUserIdAndCourseIdAndStatusIn(
                userId,
                courseId,
                List.of(EnrollmentStatus.ACTIVE, EnrollmentStatus.ACTIVE)
        );
    }

    private Long getUserIdOrNull(String username){
        if(username == null || username.isBlank()){
            return null;
        }

        return userRepository.findByUsername(username)
                .map(UserEntity::getId)
                .orElse(null);
    }


    private Double getProgressPercentage(Long userId, Long courseId){
        CompletedLessonsCountEntity completedLessonsCountEntity = completedLessonCountRepository.getByUserIdAndCourseId(userId, courseId)
                .orElse(null);

        if(completedLessonsCountEntity == null)
            return 0.0;

        Long numberOfLesson = lessonRepository.countActiveLessonsByCourseId(courseId);

        if(numberOfLesson == 0)
            return 0.0;

        return completedLessonsCountEntity.getCompletedLessonsCount() * 100.0 / numberOfLesson;
    }

}
