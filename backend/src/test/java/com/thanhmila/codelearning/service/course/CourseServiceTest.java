package com.thanhmila.codelearning.service.course;

import com.thanhmila.codelearning.dto.request.CourseCreationRequest;
import com.thanhmila.codelearning.dto.request.CourseSearchRequest;
import com.thanhmila.codelearning.dto.response.*;
import com.thanhmila.codelearning.entity.course.CategoryEntity;
import com.thanhmila.codelearning.entity.course.ChapterEntity;
import com.thanhmila.codelearning.entity.course.CourseEntity;
import com.thanhmila.codelearning.entity.course.EnrollmentEntity;
import com.thanhmila.codelearning.entity.enums.EnrollmentStatus;
import com.thanhmila.codelearning.entity.lesson.LessonEntity;
import com.thanhmila.codelearning.entity.progress.CompletedLessonsCountEntity;
import com.thanhmila.codelearning.exception.AppException;
import com.thanhmila.codelearning.exception.ErrorCode;
import com.thanhmila.codelearning.mapper.ChapterMapper;
import com.thanhmila.codelearning.mapper.CourseMapper;
import com.thanhmila.codelearning.repository.course.CategoryRepository;
import com.thanhmila.codelearning.repository.course.ChapterRepository;
import com.thanhmila.codelearning.repository.course.CourseRepository;
import com.thanhmila.codelearning.repository.course.EnrollmentRepository;
import com.thanhmila.codelearning.repository.progress.CompletedLessonCountRepository;
import com.thanhmila.codelearning.repository.progress.LessonProgressRepository;
import com.thanhmila.codelearning.repository.user.UserRepository;
import com.thanhmila.codelearning.service.cloudinary.CloudinaryService;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Nested;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageImpl;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.mock.web.MockMultipartFile;

import java.io.IOException;
import java.util.*;

import static org.assertj.core.api.Assertions.assertThat;
import static org.assertj.core.api.Assertions.assertThatThrownBy;
import static org.mockito.ArgumentMatchers.*;
import static org.mockito.Mockito.*;

@ExtendWith(MockitoExtension.class)
@DisplayName("CourseService Unit Tests")
class CourseServiceTest {

    @Mock CourseRepository courseRepository;
    @Mock EnrollmentRepository enrollmentRepository;
    @Mock ChapterRepository chapterRepository;
    @Mock CategoryRepository categoryRepository;
    @Mock CloudinaryService cloudinaryService;
    @Mock CourseMapper courseMapper;
    @Mock ChapterMapper chapterMapper;
    @Mock CompletedLessonCountRepository completedLessonCountRepository;
    @Mock LessonProgressRepository lessonProgressRepository;
    @Mock UserRepository userRepository;

    @InjectMocks CourseService courseService;

    @Nested
    @DisplayName("createCourse Tests")
    class CreateCourseTests {

        @Test
        @DisplayName("Cloudinary upload failure throws CLOUDINARY_UPLOAD_FAILED")
        void shouldThrow_WhenCloudinaryFails() throws Exception {
            MockMultipartFile file = new MockMultipartFile("thumb", "thumb.png", "image/png", "img".getBytes());
            CourseCreationRequest request = CourseCreationRequest.builder().thumbnailFile(file).build();
            CourseEntity courseEntity = new CourseEntity();

            when(courseMapper.toCourseEntity(request)).thenReturn(courseEntity);
            when(cloudinaryService.uploadFile(any(), any())).thenThrow(new RuntimeException("Cloudinary down"));

            assertThatThrownBy(() -> courseService.createCourse(request))
                    .isInstanceOf(AppException.class)
                    .hasFieldOrPropertyWithValue("errorCode", ErrorCode.CLOUDINARY_UPLOAD_FAILED);
        }

        @Test
        @DisplayName("Category not found throws CATEGORY_NOT_FOUND")
        void shouldThrow_WhenCategoryNotFound() {
            CourseCreationRequest request = CourseCreationRequest.builder()
                    .categoryIds(Set.of(1L, 2L))
                    .build();
            CourseEntity courseEntity = new CourseEntity();

            when(courseMapper.toCourseEntity(request)).thenReturn(courseEntity);
            when(categoryRepository.findAllById(request.getCategoryIds())).thenReturn(List.of(new CategoryEntity())); // only 1 found instead of 2

            assertThatThrownBy(() -> courseService.createCourse(request))
                    .isInstanceOf(AppException.class)
                    .hasFieldOrPropertyWithValue("errorCode", ErrorCode.CATEGORY_NOT_FOUND);
        }

        @Test
        @DisplayName("Valid createCourse uploads thumbnail and saves")
        void shouldCreateCourseSuccessfully() throws Exception {
            MockMultipartFile file = new MockMultipartFile("thumb", "thumb.png", "image/png", "img".getBytes());
            CourseCreationRequest request = CourseCreationRequest.builder()
                    .thumbnailFile(file)
                    .categoryIds(Set.of(1L))
                    .build();
            CourseEntity courseEntity = new CourseEntity();
            CategoryEntity cat = CategoryEntity.builder().id(1L).build();

            when(courseMapper.toCourseEntity(request)).thenReturn(courseEntity);
            when(cloudinaryService.uploadFile(eq(file), eq("courses/thumbnails")))
                    .thenReturn(CloudinaryResponse.builder().secureUrl("http://thumb.url").publicId("thumb123").build());
            when(categoryRepository.findAllById(request.getCategoryIds())).thenReturn(List.of(cat));
            when(courseRepository.save(courseEntity)).thenReturn(courseEntity);
            when(courseMapper.toCourseDetailResponse(courseEntity)).thenReturn(CourseDetailResponse.builder().build());

            CourseDetailResponse response = courseService.createCourse(request);

            assertThat(response).isNotNull();
            assertThat(response.getIsEnrolled()).isFalse();
            assertThat(response.getProgressPercentage()).isEqualTo(0);
            assertThat(courseEntity.getThumbnailUrl()).isEqualTo("http://thumb.url");
        }
    }

    @Nested
    @DisplayName("getCourseList Tests")
    class GetCourseListTests {

        @Test
        @DisplayName("Anonymous user returns courses with enrolled false")
        void shouldReturnCourses_ForAnonymousUser() {
            CourseEntity course = CourseEntity.builder().id(1L).totalLessons(10).build();
            Page<CourseEntity> page = new PageImpl<>(List.of(course));
            Pageable pageable = PageRequest.of(0, 10);

            when(courseRepository.findAll(any(Specification.class), eq(pageable))).thenReturn(page);
            when(courseMapper.toCourseListItemResponse(course)).thenReturn(CourseListItemResponse.builder().id(1L).build());

            PageResponse<CourseListItemResponse> response = courseService.getCourseList(null, null, pageable);

            assertThat(response).isNotNull();
            assertThat(response.getContent().get(0).getEnrolled()).isFalse();
            assertThat(response.getContent().get(0).getProgressPercentage()).isEqualTo(0);
        }

        @Test
        @DisplayName("Enrolled user computes progress and syncs missing cache")
        void shouldReturnCourses_WithProgress_ForEnrolledUser() {
            CourseEntity course = CourseEntity.builder().id(1L).totalLessons(10).build();
            Page<CourseEntity> page = new PageImpl<>(List.of(course));
            Pageable pageable = PageRequest.of(0, 10);

            when(courseRepository.findAll(any(Specification.class), eq(pageable))).thenReturn(page);
            when(courseMapper.toCourseListItemResponse(course)).thenReturn(CourseListItemResponse.builder().id(1L).build());
            when(enrollmentRepository.findEnrolledCourseIdsByUserIdAndCourseIds(eq(10L), eq(List.of(1L)), any()))
                    .thenReturn(Set.of(1L));
            when(completedLessonCountRepository.findByUserIdAndCourseIdIn(eq(10L), eq(Set.of(1L))))
                    .thenReturn(Collections.emptyList()); // cache missing
            when(lessonProgressRepository.countByUserIdAndCourseId(10L, 1L)).thenReturn(5); // 5/10 = 50%

            PageResponse<CourseListItemResponse> response = courseService.getCourseList(10L, new CourseSearchRequest(), pageable);

            assertThat(response).isNotNull();
            assertThat(response.getContent().get(0).getEnrolled()).isTrue();
            assertThat(response.getContent().get(0).getProgressPercentage()).isEqualTo(50);
            verify(completedLessonCountRepository).save(any(CompletedLessonsCountEntity.class));
        }
    }

    @Nested
    @DisplayName("getCourseDetail Tests")
    class GetCourseDetailTests {

        @Test
        @DisplayName("Course not found throws COURSE_NOT_FOUND")
        void shouldThrow_WhenCourseNotFound() {
            when(courseRepository.findCourseDetailById(1L)).thenReturn(Optional.empty());

            assertThatThrownBy(() -> courseService.getCourseDetail(1L, 10L))
                    .isInstanceOf(AppException.class)
                    .hasFieldOrPropertyWithValue("errorCode", ErrorCode.COURSE_NOT_FOUND);
        }

        @Test
        @DisplayName("Returns course detail with progress for enrolled user")
        void shouldReturnDetail_WithProgress_WhenEnrolled() {
            CourseEntity course = CourseEntity.builder().id(1L).totalLessons(10).build();
            CourseDetailResponse detail = CourseDetailResponse.builder().id(1L).totalLessons(10).build();

            when(courseRepository.findCourseDetailById(1L)).thenReturn(Optional.of(course));
            when(courseMapper.toCourseDetailResponse(course)).thenReturn(detail);
            when(enrollmentRepository.existsByUserIdAndCourseIdAndStatusIn(eq(10L), eq(1L), any())).thenReturn(true);
            when(completedLessonCountRepository.getByUserIdAndCourseId(10L, 1L))
                    .thenReturn(Optional.of(CompletedLessonsCountEntity.builder().completedLessonsCount(4).build()));

            CourseDetailResponse response = courseService.getCourseDetail(1L, 10L);

            assertThat(response).isNotNull();
            assertThat(response.getIsEnrolled()).isTrue();
            assertThat(response.getProgressPercentage()).isEqualTo(40);
        }
    }

    @Nested
    @DisplayName("getCourseCurriculum Tests")
    class GetCourseCurriculumTests {

        @Test
        @DisplayName("Returns curriculum with completed flags when user is logged in")
        void shouldReturnCurriculum_WithCompletedFlags() {
            LessonSummaryResponse lResp = LessonSummaryResponse.builder().id(5L).build();
            ChapterResponse cResp = ChapterResponse.builder().id(1L).lessonSummaryResponses(List.of(lResp)).build();
            ChapterEntity chapter = ChapterEntity.builder().id(1L).build();

            when(chapterRepository.findChaptersWithLessonsByCourseId(100L)).thenReturn(List.of(chapter));
            when(chapterMapper.toChapterResponse(chapter)).thenReturn(cResp);
            when(lessonProgressRepository.findCompletedLessonIds(10L, 100L)).thenReturn(Set.of(5L));

            List<ChapterResponse> result = courseService.getCourseCurriculum(100L, 10L);

            assertThat(result).hasSize(1);
            assertThat(result.get(0).getLessonSummaryResponses().get(0).getIsCompleted()).isTrue();
        }
    }

    @Nested
    @DisplayName("getAllCategories Tests")
    class GetAllCategoriesTests {

        @Test
        @DisplayName("Returns all mapped categories")
        void shouldReturnAllCategories() {
            CategoryEntity cat = CategoryEntity.builder().id(1L).name("Java").build();
            when(categoryRepository.findAll()).thenReturn(List.of(cat));
            when(courseMapper.toCategoryResponse(cat)).thenReturn(CategoryResponse.builder().id(1L).name("Java").build());

            List<CategoryResponse> categories = courseService.getAllCategories();

            assertThat(categories).hasSize(1);
            assertThat(categories.get(0).getName()).isEqualTo("Java");
        }
    }
}
