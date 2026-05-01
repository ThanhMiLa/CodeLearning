package com.thanhmila.codelearning.service.course;

import com.thanhmila.codelearning.dto.response.CourseListItemResponse;
import com.thanhmila.codelearning.dto.response.PageResponse;
import com.thanhmila.codelearning.entity.UserEntity;
import com.thanhmila.codelearning.repository.*;
import com.thanhmila.codelearning.repository.projection.CourseListItemProjection;
import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import lombok.extern.slf4j.Slf4j;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;


@Slf4j
@Service
@RequiredArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE, makeFinal = true)
public class CourseService {
    CourseRepository courseRepository;
    UserRepository userRepository;

    public PageResponse<CourseListItemResponse> getCourseList(String username, Pageable pageable){

        Long userId = getUserIdOrNull(username);

        Page<CourseListItemProjection> courseListItemProjections =
                courseRepository.findAllCoursesWithDetails(userId, pageable);

        Page<CourseListItemResponse> courseListItemResponses = courseListItemProjections.map(this::buildCourseListItemResponse);

        return PageResponse.from(courseListItemResponses);

    }

    private CourseListItemResponse buildCourseListItemResponse(CourseListItemProjection projection){
        Double progressPercentage = null;

        if(Boolean.TRUE.equals(projection.getEnrolled())){
            long totalLesson = projection.getTotalActiveLessons();
            long completedLesson = projection.getCompletedLessons();

            if(totalLesson == 0){
                progressPercentage = 0.0;
            }else{
                progressPercentage = (completedLesson * 100.0) / totalLesson;
            }
        }

        return CourseListItemResponse.builder()
                .id(projection.getId())
                .title(projection.getTitle())
                .shortDescription(projection.getShortDescription())
                .thumbnailUrl(projection.getThumbnailUrl())
                .price(projection.getPrice())
                .totalReviews(projection.getTotalReviews())
                .totalEnrolled(projection.getTotalEnrolled())
                .averageRating(projection.getAverageRating())
                .enrolled(projection.getEnrolled())
                .progressPercentage(progressPercentage)
                .build();
    }

    private Long getUserIdOrNull(String username){
        if(username == null || username.isBlank()){
            return null;
        }

        return userRepository.findByUsername(username)
                .map(UserEntity::getId)
                .orElse(-1L);
    }



}
