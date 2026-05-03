package com.thanhmila.codelearning.service.course;

import com.thanhmila.codelearning.dto.request.CourseSearchRequest;
import com.thanhmila.codelearning.dto.response.ChapterResponse;
import com.thanhmila.codelearning.dto.response.CourseDetailResponse;
import com.thanhmila.codelearning.dto.response.CourseListItemResponse;
import com.thanhmila.codelearning.dto.response.PageResponse;
import com.thanhmila.codelearning.entity.course.ChapterEntity;
import com.thanhmila.codelearning.entity.progress.CompletedLessonsCountEntity;
import com.thanhmila.codelearning.entity.course.CourseEntity;
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

import java.util.*;
import java.util.stream.Collectors;


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

    public PageResponse<CourseListItemResponse> getCourseList(Long userId, CourseSearchRequest searchRequest, Pageable pageable) {

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

        // 3. Gọi DB (JpaSpecificationExecutor lo toàn bộ việc sinh câu SQL) (QUERY 1)
        Page<CourseEntity> courseEntities = courseRepository.findAll(spec, pageable);

        Set<Long> enrolledCourseIds = new HashSet<>();  // Lưu danh sách courseId mà user đã enrolled
        Map<Long, Integer> courseProgressMap = new HashMap<>(); // Lưu danh sách Map courseId + completedLesson

        if (userId != null) {
            // Lấy ra các courseId hiện có
            List<Long> currentCourseIds = courseEntities.getContent().stream()
                    .map(CourseEntity::getId)
                    .toList();

            // 4. Lấy danh sách các Course ID mà user đã mua trong số các ID trên (QUERY 2)
            enrolledCourseIds = enrollmentRepository.findEnrolledCourseIdsByUserIdAndCourseIds(userId, currentCourseIds, List.of(EnrollmentStatus.ACTIVE, EnrollmentStatus.COMPLETED));

            // 5. Nếu user có mua ít nhất 1 khóa, tiến hành lấy tiến độ (QUERY 3)
            if (!enrolledCourseIds.isEmpty()) {
                List<CompletedLessonsCountEntity> completedLessonsCountEntities =
                        completedLessonCountRepository.findByUserIdAndCourseIdIn(userId, new ArrayList<>(enrolledCourseIds));

                courseProgressMap = getCourseProgressMap(completedLessonsCountEntities);
            }
        }

        // 6. Lắp ráp dữ liệu trên RAM
        final Set<Long> finalEnrolledIds = enrolledCourseIds;
        final Map<Long, Integer> finalProgressMap = courseProgressMap;

        Page<CourseListItemResponse> courseListItemResponsePage = courseEntities.map(courseEntity -> {
            CourseListItemResponse courseListItemResponse = courseMapper.toCourseListItemResponse(courseEntity);

            boolean isEnrolled = finalEnrolledIds.contains(courseEntity.getId());
            courseListItemResponse.setEnrolled(isEnrolled);

            int progressPercentage = 0;
            if (isEnrolled) {
                int completeLessons = finalProgressMap.getOrDefault(courseEntity.getId(), 0);
                int totalLesson = courseEntity.getTotalLessons() != null ? courseEntity.getTotalLessons() : 0;
                progressPercentage = getProgressPercentage(completeLessons, totalLesson);
            }

            courseListItemResponse.setProgressPercentage(progressPercentage);

            return courseListItemResponse;

        });

        return PageResponse.from(courseListItemResponsePage);
    }

    public CourseDetailResponse getCourseDetail(Long courseId, Long userId) {
        CourseEntity courseEntity = courseRepository.findCourseDetailById(courseId)
                .orElseThrow(() -> new AppException(ErrorCode.COURSE_NOT_FOUND));
        CourseDetailResponse courseDetailResponse = courseMapper.toCourseDetailResponse(courseEntity);

        Boolean isEnrolled = false;
        Integer progressPercentage = 0;

        if (userId != null) {
            isEnrolled = isEnrollCourseById(courseId, userId);
            if (isEnrolled == true) {
                int completedLessons = getCompleteLessons(courseId, userId);
                progressPercentage = getProgressPercentage(completedLessons, courseDetailResponse.getTotalLessons());
            }
        }

        courseDetailResponse.setProgressPercentage(progressPercentage);
        courseDetailResponse.setIsEnrolled(isEnrolled);

        return courseDetailResponse;
    }

    public List<ChapterResponse> getCourseCurriculum(Long courseId){
        List<ChapterEntity> chapterEntityList = chapterRepository.findChaptersWithLessonsByCourseId(courseId);
        return chapterEntityList.stream()
                .map(chapterMapper::toChapterResponse)
                .toList();
    }

    private Map<Long, Integer> getCourseProgressMap(List<CompletedLessonsCountEntity> completedLessonsCountEntities){
        return completedLessonsCountEntities.stream()
                .collect(Collectors.toMap(
                        entity -> entity.getCourse().getId(),
                        CompletedLessonsCountEntity::getCompletedLessonsCount
                ));
    }

    private Boolean isEnrollCourseById(Long courseId, Long userId) {
        return enrollmentRepository.existsByUserIdAndCourseIdAndStatusIn(
                userId, courseId, List.of(EnrollmentStatus.ACTIVE, EnrollmentStatus.COMPLETED));
    }

    private Integer getCompleteLessons(Long courseId, Long userId) {
        CompletedLessonsCountEntity completedLessonsCountEntity = completedLessonCountRepository.getByUserIdAndCourseId(userId, courseId)
                .orElse(null);

        return completedLessonsCountEntity != null ? completedLessonsCountEntity.getCompletedLessonsCount() : 0;
    }

    private Integer getProgressPercentage(Integer completeLessons, Integer totalLesson) {
        if (totalLesson == null || totalLesson <= 0) return 0;

        return (int) Math.round((double) completeLessons / totalLesson * 100);

    }

}
