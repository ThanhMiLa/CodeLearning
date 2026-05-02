package com.thanhmila.codelearning.service.course;

import com.thanhmila.codelearning.dto.request.CourseSearchRequest;
import com.thanhmila.codelearning.dto.response.ChapterResponse;
import com.thanhmila.codelearning.dto.response.CourseDetailResponse;
import com.thanhmila.codelearning.dto.response.CourseListItemResponse;
import com.thanhmila.codelearning.dto.response.PageResponse;
import com.thanhmila.codelearning.entity.ChapterEntity;
import com.thanhmila.codelearning.entity.CompletedLessonsCountEntity;
import com.thanhmila.codelearning.entity.CourseEntity;
import com.thanhmila.codelearning.entity.UserEntity;
import com.thanhmila.codelearning.entity.enums.CourseStatus;
import com.thanhmila.codelearning.entity.enums.EnrollmentStatus;
import com.thanhmila.codelearning.exception.AppException;
import com.thanhmila.codelearning.exception.ErrorCode;
import com.thanhmila.codelearning.mapper.ChapterMapper;
import com.thanhmila.codelearning.mapper.CourseMapper;
import com.thanhmila.codelearning.repository.*;
import com.thanhmila.codelearning.repository.specification.CourseSpecification;
import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import lombok.extern.slf4j.Slf4j;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Service;

import java.util.List;


@Slf4j
@Service
@RequiredArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE, makeFinal = true)
public class CourseService {
    CourseRepository courseRepository;
    EnrollmentRepository enrollmentRepository;
    ChapterRepository chapterRepository;
    CourseMapper courseMapper;
    ChapterMapper chapterMapper;
    CompletedLessonCountRepository completedLessonCountRepository;

    public PageResponse<CourseListItemResponse> getCourseList(CourseSearchRequest searchRequest, Pageable pageable) {

        // 1. Khởi tạo Specification cơ bản (Luôn là khóa học ACTIVE)
        Specification<CourseEntity> spec = Specification.allOf(CourseSpecification.isStatusActive());

        // 2. Nối (Chaining) các điều kiện linh hoạt dựa vào Request từ User
        if (searchRequest != null) {
            spec = spec.and(CourseSpecification.hasKeyword(searchRequest.getKeyword()))
                    .and(CourseSpecification.hasCategories(searchRequest.getCategoryIds()))
                    .and(CourseSpecification.hasPriceBetween(searchRequest.getMinPrice(), searchRequest.getMaxPrice()))
                    .and(CourseSpecification.hasRatingBetween(searchRequest.getMinRating(), searchRequest.getMaxRating()))
                    .and(CourseSpecification.hasTeacherName(searchRequest.getTeacherName()));
        }

        // 3. Gọi DB (JpaSpecificationExecutor lo toàn bộ việc sinh câu SQL)
        Page<CourseEntity> courseEntities = courseRepository.findAll(spec, pageable);

        // 4. Map Entity sang Response DTO
        Page<CourseListItemResponse> responses = courseEntities.map(this::buildCourseListItemResponse);

        return PageResponse.from(responses);
    }

    public CourseDetailResponse getCourseDetail(Long courseId, Long userId){
        CourseEntity courseEntity = courseRepository.findCourseDetailById(courseId)
                .orElseThrow(() -> new AppException(ErrorCode.COURSE_NOT_FOUND));
        CourseDetailResponse courseDetailResponse = courseMapper.toCourseDetailResponse(courseEntity);

        List<ChapterEntity> chapterEntities = chapterRepository.findChaptersWithLessonsByCourseId(courseId);
        List<ChapterResponse> chapterResponses = chapterEntities.stream()
                .map(chapterMapper::toChapterResponse)
                .toList();


        Boolean isEnrolled = false;
        Integer progressPercentage = 0;

        if(userId != null){
            isEnrolled = isEnrollCourseById(courseId, userId);
            if(isEnrolled == true){
                progressPercentage = getProgressPercentage(courseId, userId, courseDetailResponse.getTotalLessons());
            }
        }

        courseDetailResponse.setProgressPercentage(progressPercentage);
        courseDetailResponse.setIsEnrolled(isEnrolled);
        courseDetailResponse.setChapters(chapterResponses);

        return courseDetailResponse;
    }

    private CourseListItemResponse buildCourseListItemResponse(CourseEntity entity) {
        return CourseListItemResponse.builder()
                .id(entity.getId())
                .title(entity.getTitle())
                .shortDescription(entity.getShortDescription())
                .thumbnailUrl(entity.getThumbnailUrl())
                .price(entity.getPrice())
                .totalReviews(entity.getTotalReviews().longValue())
                .totalEnrolled(entity.getTotalEnrolled().longValue())
                .averageRating(entity.getAverageRating())
                .enrolled(false)
                .progressPercentage(null)
                .build();
    }


    private Boolean isEnrollCourseById(Long courseId, Long userId){
        return enrollmentRepository.existsByUserIdAndCourseIdAndStatusIn(
                userId, courseId, List.of(EnrollmentStatus.ACTIVE, EnrollmentStatus.COMPLETED));
    }

    private Integer getProgressPercentage(Long courseId, Long userId, Integer totalLesson){
        if(totalLesson == null || totalLesson == 0) return 0;

        CompletedLessonsCountEntity completedLessonsCountEntity = completedLessonCountRepository.getByUserIdAndCourseId(userId, courseId)
                .orElse(null);

        Integer completedLesson = (completedLessonsCountEntity != null)
                ? completedLessonsCountEntity.getCompletedLessonsCount()
                : 0;

        return (int) Math.round((double) completedLesson / totalLesson * 100);

    }

}
