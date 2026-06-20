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
import com.thanhmila.codelearning.repository.course.ChapterRepository;
import com.thanhmila.codelearning.repository.course.CourseRepository;
import com.thanhmila.codelearning.repository.course.EnrollmentRepository;
import com.thanhmila.codelearning.repository.progress.CompletedLessonCountRepository;
import com.thanhmila.codelearning.repository.progress.LessonProgressRepository;
import com.thanhmila.codelearning.repository.user.UserRepository;
import com.thanhmila.codelearning.repository.specification.CourseSpecification;
import com.thanhmila.codelearning.util.ProgressUtils;
import com.thanhmila.codelearning.dto.request.CourseCreationRequest;
import com.thanhmila.codelearning.repository.course.CategoryRepository;
import com.thanhmila.codelearning.service.cloudinary.CloudinaryService;
import com.thanhmila.codelearning.entity.course.CategoryEntity;
import com.thanhmila.codelearning.dto.response.CloudinaryResponse;
import com.thanhmila.codelearning.dto.response.EnrolledCourseResponse;
import com.thanhmila.codelearning.entity.course.EnrollmentEntity;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort;
import org.springframework.transaction.annotation.Transactional;

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
    CategoryRepository categoryRepository;
    CloudinaryService cloudinaryService;
    CourseMapper courseMapper;
    ChapterMapper chapterMapper;
    CompletedLessonCountRepository completedLessonCountRepository;
    LessonProgressRepository lessonProgressRepository;
    UserRepository userRepository;

    @Transactional
    public CourseDetailResponse createCourse(CourseCreationRequest request) {
        CourseEntity courseEntity = courseMapper.toCourseEntity(request);

        // 1. Upload thumbnail to Cloudinary if present
        if (request.getThumbnailFile() != null && !request.getThumbnailFile().isEmpty()) {
            try {
                CloudinaryResponse uploadResult = cloudinaryService.uploadFile(request.getThumbnailFile(), "courses/thumbnails");
                courseEntity.setThumbnailUrl(uploadResult.getSecureUrl());
                courseEntity.setThumbnailPublicId(uploadResult.getPublicId());
            } catch (Exception e) {
                log.error("Failed to upload course thumbnail: ", e);
                throw new AppException(ErrorCode.CLOUDINARY_UPLOAD_FAILED);
            }
        }

        // 2. Set categories
        if (request.getCategoryIds() != null && !request.getCategoryIds().isEmpty()) {
            List<CategoryEntity> categoryEntities = categoryRepository.findAllById(request.getCategoryIds());
            if (categoryEntities.size() != request.getCategoryIds().size()) {
                throw new AppException(ErrorCode.CATEGORY_NOT_FOUND);
            }
            courseEntity.setCategories(new HashSet<>(categoryEntities));
        }

        // 3. Save to database
        CourseEntity savedCourse = courseRepository.save(courseEntity);

        // 4. Return detailed response
        CourseDetailResponse response = courseMapper.toCourseDetailResponse(savedCourse);
        response.setIsEnrolled(false);
        response.setProgressPercentage(0);
        return response;
    }

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
                        completedLessonCountRepository.findByUserIdAndCourseIdIn(userId, enrolledCourseIds);

                courseProgressMap = getCourseProgressMap(completedLessonsCountEntities);

                // Tự động đồng bộ/sửa lỗi nếu cache bị thiếu hoặc sai lệch
                for (Long courseId : enrolledCourseIds) {
                    if (!courseProgressMap.containsKey(courseId)) {
                        int actualCount = lessonProgressRepository.countByUserIdAndCourseId(userId, courseId);
                        if (actualCount > 0) {
                            courseProgressMap.put(courseId, actualCount);
                            CompletedLessonsCountEntity newCountEntity = CompletedLessonsCountEntity.builder()
                                    .user(userRepository.getReferenceById(userId))
                                    .course(courseRepository.getReferenceById(courseId))
                                    .completedLessonsCount(actualCount)
                                    .build();
                            completedLessonCountRepository.save(newCountEntity);
                        }
                    }
                }
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
                progressPercentage = ProgressUtils.calculatePercentage(completeLessons, totalLesson);
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
                progressPercentage = ProgressUtils.calculatePercentage(completedLessons, courseDetailResponse.getTotalLessons());
            }
        }

        courseDetailResponse.setProgressPercentage(progressPercentage);
        courseDetailResponse.setIsEnrolled(isEnrolled);

        return courseDetailResponse;
    }

    public List<ChapterResponse> getCourseCurriculum(Long courseId, Long userId){
        List<ChapterEntity> chapterEntityList = chapterRepository.findChaptersWithLessonsByCourseId(courseId);
        List<ChapterResponse> chapterResponseList = chapterEntityList.stream()
                .map(chapterMapper::toChapterResponse)
                .toList();

        if(userId != null){
            Set<Long> completedLessonIds = lessonProgressRepository.findCompletedLessonIds(userId, courseId);
            if(completedLessonIds != null && !completedLessonIds.isEmpty()){
                chapterResponseList.forEach(chapterResponse -> {
                    chapterResponse.getLessonSummaryResponses().forEach(lessonSummaryResponse -> {
                        boolean isCompleted = completedLessonIds.contains(lessonSummaryResponse.getId());
                        lessonSummaryResponse.setIsCompleted(isCompleted);
                    });
                });
            }
        }
        return chapterResponseList;
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

        if (completedLessonsCountEntity != null) {
            return completedLessonsCountEntity.getCompletedLessonsCount();
        }

        int actualCount = lessonProgressRepository.countByUserIdAndCourseId(userId, courseId);
        if (actualCount > 0) {
            CompletedLessonsCountEntity newCountEntity = CompletedLessonsCountEntity.builder()
                    .user(userRepository.getReferenceById(userId))
                    .course(courseRepository.getReferenceById(courseId))
                    .completedLessonsCount(actualCount)
                    .build();
            completedLessonCountRepository.save(newCountEntity);
        }
        return actualCount;
    }

    public PageResponse<EnrolledCourseResponse> getEnrolledCourses(Long userId, int page, int size) {
        Pageable pageable = PageRequest.of(page, size, Sort.by("enrolledAt").descending());

        Page<EnrollmentEntity> enrollmentPage = enrollmentRepository.findActiveEnrollmentsByUserId(
                userId,
                List.of(EnrollmentStatus.ACTIVE, EnrollmentStatus.COMPLETED),
                pageable
        );

        List<Long> courseIds = enrollmentPage.getContent().stream()
                .map(e -> e.getCourse().getId())
                .toList();

        Map<Long, Integer> courseProgressMap = new HashMap<>();
        if (!courseIds.isEmpty()) {
            List<CompletedLessonsCountEntity> completedLessonsCountEntities =
                    completedLessonCountRepository.findByUserIdAndCourseIdIn(userId, new HashSet<>(courseIds));

            courseProgressMap = getCourseProgressMap(completedLessonsCountEntities);
        }

        final Map<Long, Integer> finalProgressMap = courseProgressMap;

        List<EnrolledCourseResponse> content = enrollmentPage.getContent().stream()
                .map(e -> {
                    CourseEntity course = e.getCourse();
                    int completedLessons = finalProgressMap.getOrDefault(course.getId(), 0);
                    int totalLessons = course.getTotalLessons() != null ? course.getTotalLessons() : 0;
                    int progressPercentage = ProgressUtils.calculatePercentage(completedLessons, totalLessons);

                    return EnrolledCourseResponse.builder()
                            .id(course.getId())
                            .title(course.getTitle())
                            .shortDescription(course.getShortDescription())
                            .thumbnailUrl(course.getThumbnailUrl())
                            .price(course.getPrice())
                            .averageRating(course.getAverageRating())
                            .totalReviews(course.getTotalReviews() != null ? course.getTotalReviews().longValue() : 0L)
                            .totalEnrolled(course.getTotalEnrolled() != null ? course.getTotalEnrolled().longValue() : 0L)
                            .progressPercentage(progressPercentage)
                            .build();
                })
                .collect(Collectors.toList());

        return PageResponse.<EnrolledCourseResponse>builder()
                .page(enrollmentPage.getNumber())
                .size(enrollmentPage.getSize())
                .numberOfElements(enrollmentPage.getNumberOfElements())
                .totalElements(enrollmentPage.getTotalElements())
                .totalPages(enrollmentPage.getTotalPages())
                .first(enrollmentPage.isFirst())
                .last(enrollmentPage.isLast())
                .content(content)
                .build();
    }
}
