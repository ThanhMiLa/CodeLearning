package com.thanhmila.codelearning.service.course;

import com.thanhmila.codelearning.dto.request.LessonCreationRequest;
import com.thanhmila.codelearning.dto.request.LessonReorderRequest;
import com.thanhmila.codelearning.dto.request.LessonUpdateRequest;
import com.thanhmila.codelearning.dto.response.CloudinaryResponse;
import com.thanhmila.codelearning.dto.response.LessonCompletionResponse;
import com.thanhmila.codelearning.dto.response.LessonDetailResponse;
import com.thanhmila.codelearning.entity.course.ChapterEntity;
import com.thanhmila.codelearning.entity.course.CourseEntity;
import com.thanhmila.codelearning.entity.enums.EnrollmentStatus;
import com.thanhmila.codelearning.entity.lesson.LessonEntity;
import com.thanhmila.codelearning.entity.progress.CompletedLessonsCountEntity;
import com.thanhmila.codelearning.entity.progress.LessonProgressEntity;
import com.thanhmila.codelearning.entity.user.UserEntity;
import com.thanhmila.codelearning.exception.AppException;
import com.thanhmila.codelearning.exception.ErrorCode;
import com.thanhmila.codelearning.mapper.LessonMapper;
import com.thanhmila.codelearning.repository.course.ChapterRepository;
import com.thanhmila.codelearning.repository.course.CourseRepository;
import com.thanhmila.codelearning.repository.course.EnrollmentRepository;
import com.thanhmila.codelearning.repository.lesson.LessonRepository;
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
import org.springframework.mock.web.MockMultipartFile;

import java.io.IOException;
import java.util.List;
import java.util.Optional;

import static org.assertj.core.api.Assertions.assertThat;
import static org.assertj.core.api.Assertions.assertThatThrownBy;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.ArgumentMatchers.eq;
import static org.mockito.Mockito.*;

@ExtendWith(MockitoExtension.class)
@DisplayName("LessonService Unit Tests")
class LessonServiceTest {

    @Mock LessonRepository lessonRepository;
    @Mock LessonMapper lessonMapper;
    @Mock EnrollmentRepository enrollmentRepository;
    @Mock LessonProgressRepository lessonProgressRepository;
    @Mock UserRepository userRepository;
    @Mock CompletedLessonCountRepository completedLessonCountRepository;
    @Mock ChapterRepository chapterRepository;
    @Mock CourseRepository courseRepository;
    @Mock CloudinaryService cloudinaryService;

    @InjectMocks LessonService lessonService;

    @Nested
    @DisplayName("getLessonDetail Tests")
    class GetLessonDetailTests {

        @Test
        @DisplayName("Lesson not found throws LESSON_NOT_FOUND")
        void shouldThrow_WhenLessonNotFound() {
            when(lessonRepository.findDetailWithCourseById(1L)).thenReturn(Optional.empty());

            assertThatThrownBy(() -> lessonService.getLessonDetail(1L, 10L))
                    .isInstanceOf(AppException.class)
                    .hasFieldOrPropertyWithValue("errorCode", ErrorCode.LESSON_NOT_FOUND);
        }

        @Test
        @DisplayName("Trial lesson allows access even when userId is null")
        void shouldReturnDetail_WhenTrialLessonAndAnonymousUser() {
            LessonEntity lesson = LessonEntity.builder().id(1L).trial(true).build();
            LessonDetailResponse expectedResponse = LessonDetailResponse.builder().id(1L).build();

            when(lessonRepository.findDetailWithCourseById(1L)).thenReturn(Optional.of(lesson));
            when(lessonMapper.toLessonDetailResponse(lesson)).thenReturn(expectedResponse);

            LessonDetailResponse actual = lessonService.getLessonDetail(1L, null);

            assertThat(actual).isEqualTo(expectedResponse);
        }

        @Test
        @DisplayName("Paid lesson throws UNAUTHENTICATED when userId is null")
        void shouldThrow_WhenPaidLessonAndAnonymousUser() {
            LessonEntity lesson = LessonEntity.builder().id(2L).trial(false).build();
            when(lessonRepository.findDetailWithCourseById(2L)).thenReturn(Optional.of(lesson));

            assertThatThrownBy(() -> lessonService.getLessonDetail(2L, null))
                    .isInstanceOf(AppException.class)
                    .hasFieldOrPropertyWithValue("errorCode", ErrorCode.UNAUTHENTICATED);
        }

        @Test
        @DisplayName("Paid lesson throws ACCESS_DENIED_COURSE when user not enrolled")
        void shouldThrow_WhenPaidLessonAndNotEnrolled() {
            CourseEntity course = CourseEntity.builder().id(100L).build();
            ChapterEntity chapter = ChapterEntity.builder().id(10L).course(course).build();
            LessonEntity lesson = LessonEntity.builder().id(2L).trial(false).chapter(chapter).build();

            when(lessonRepository.findDetailWithCourseById(2L)).thenReturn(Optional.of(lesson));
            when(enrollmentRepository.existsByUserIdAndCourseIdAndStatusIn(eq(5L), eq(100L), any())).thenReturn(false);

            assertThatThrownBy(() -> lessonService.getLessonDetail(2L, 5L))
                    .isInstanceOf(AppException.class)
                    .hasFieldOrPropertyWithValue("errorCode", ErrorCode.ACCESS_DENIED_COURSE);
        }

        @Test
        @DisplayName("Paid lesson returns detail when user is enrolled")
        void shouldReturnDetail_WhenPaidLessonAndUserEnrolled() {
            CourseEntity course = CourseEntity.builder().id(100L).build();
            ChapterEntity chapter = ChapterEntity.builder().id(10L).course(course).build();
            LessonEntity lesson = LessonEntity.builder().id(2L).trial(false).chapter(chapter).build();
            LessonDetailResponse expectedResponse = LessonDetailResponse.builder().id(2L).build();

            when(lessonRepository.findDetailWithCourseById(2L)).thenReturn(Optional.of(lesson));
            when(enrollmentRepository.existsByUserIdAndCourseIdAndStatusIn(eq(5L), eq(100L), any())).thenReturn(true);
            when(lessonMapper.toLessonDetailResponse(lesson)).thenReturn(expectedResponse);

            LessonDetailResponse actual = lessonService.getLessonDetail(2L, 5L);

            assertThat(actual).isEqualTo(expectedResponse);
        }
    }

    @Nested
    @DisplayName("completedLesson Tests")
    class CompletedLessonTests {

        @Test
        @DisplayName("Already completed lesson throws LESSON_ALREADY_COMPLETED")
        void shouldThrow_WhenLessonAlreadyCompleted() {
            when(lessonProgressRepository.existsByLessonIdAndUserId(1L, 10L)).thenReturn(true);

            assertThatThrownBy(() -> lessonService.completedLesson(1L, 10L))
                    .isInstanceOf(AppException.class)
                    .hasFieldOrPropertyWithValue("errorCode", ErrorCode.LESSON_ALREADY_COMPLETED);
        }

        @Test
        @DisplayName("Course not found throws COURSE_NOT_FOUND")
        void shouldThrow_WhenCourseNotFoundForLesson() {
            when(lessonProgressRepository.existsByLessonIdAndUserId(1L, 10L)).thenReturn(false);
            when(lessonRepository.findCourseByLessonId(1L)).thenReturn(Optional.empty());

            assertThatThrownBy(() -> lessonService.completedLesson(1L, 10L))
                    .isInstanceOf(AppException.class)
                    .hasFieldOrPropertyWithValue("errorCode", ErrorCode.COURSE_NOT_FOUND);
        }

        @Test
        @DisplayName("Successfully complete lesson when progress count is updated (course not yet completed)")
        void shouldCompleteLesson_WhenNotLastLesson() {
            CourseEntity course = CourseEntity.builder().id(100L).totalLessons(10).build();
            when(lessonProgressRepository.existsByLessonIdAndUserId(1L, 10L)).thenReturn(false);
            when(lessonRepository.findCourseByLessonId(1L)).thenReturn(Optional.of(course));
            when(lessonProgressRepository.countByUserIdAndCourseId(10L, 100L)).thenReturn(3);
            when(completedLessonCountRepository.getByUserIdAndCourseId(10L, 100L)).thenReturn(Optional.empty());

            LessonCompletionResponse response = lessonService.completedLesson(1L, 10L);

            assertThat(response).isNotNull();
            assertThat(response.getLessonId()).isEqualTo(1L);
            assertThat(response.getCompletedLessonsCount()).isEqualTo(3);
            assertThat(response.isCourseCompleted()).isFalse();
            verify(completedLessonCountRepository).save(any(CompletedLessonsCountEntity.class));
            verify(enrollmentRepository, never()).updateStatusByUserIdAndCourseId(any(), any(), any());
        }

        @Test
        @DisplayName("Successfully complete last lesson and updates enrollment to COMPLETED")
        void shouldCompleteLessonAndMarkCourseCompleted_WhenLastLesson() {
            CourseEntity course = CourseEntity.builder().id(100L).totalLessons(5).build();
            CompletedLessonsCountEntity existingCount = CompletedLessonsCountEntity.builder()
                    .completedLessonsCount(4)
                    .build();

            when(lessonProgressRepository.existsByLessonIdAndUserId(1L, 10L)).thenReturn(false);
            when(lessonRepository.findCourseByLessonId(1L)).thenReturn(Optional.of(course));
            when(lessonProgressRepository.countByUserIdAndCourseId(10L, 100L)).thenReturn(5);
            when(completedLessonCountRepository.getByUserIdAndCourseId(10L, 100L)).thenReturn(Optional.of(existingCount));

            LessonCompletionResponse response = lessonService.completedLesson(1L, 10L);

            assertThat(response).isNotNull();
            assertThat(response.getCompletedLessonsCount()).isEqualTo(5);
            assertThat(response.isCourseCompleted()).isTrue();
            verify(enrollmentRepository).updateStatusByUserIdAndCourseId(10L, 100L, EnrollmentStatus.COMPLETED);
        }
    }

    @Nested
    @DisplayName("createLesson Tests")
    class CreateLessonTests {

        @Test
        @DisplayName("Chapter not found throws CHAPTER_NOT_FOUND")
        void shouldThrow_WhenChapterNotFound() {
            when(chapterRepository.findById(1L)).thenReturn(Optional.empty());

            assertThatThrownBy(() -> lessonService.createLesson(1L, new LessonCreationRequest()))
                    .isInstanceOf(AppException.class)
                    .hasFieldOrPropertyWithValue("errorCode", ErrorCode.CHAPTER_NOT_FOUND);
        }

        @Test
        @DisplayName("Create lesson with video file uploads to Cloudinary and increments course counters")
        void shouldCreateLesson_WithVideoFile() throws IOException {
            CourseEntity course = CourseEntity.builder().id(100L).totalLessons(2).totalVideos(1).build();
            ChapterEntity chapter = ChapterEntity.builder().id(1L).course(course).build();
            MockMultipartFile file = new MockMultipartFile("videoFile", "video.mp4", "video/mp4", "content".getBytes());
            LessonCreationRequest request = LessonCreationRequest.builder().title("Lesson 1").videoFile(file).build();
            LessonEntity lessonEntity = LessonEntity.builder().id(10L).title("Lesson 1").build();

            when(chapterRepository.findById(1L)).thenReturn(Optional.of(chapter));
            when(lessonMapper.toLessonEntity(request)).thenReturn(lessonEntity);
            when(lessonRepository.findMaxOrderIndexByChapterId(1L)).thenReturn(2);
            when(cloudinaryService.uploadFile(eq(file), eq("lessons/videos")))
                    .thenReturn(CloudinaryResponse.builder().secureUrl("http://video.url").publicId("pub123").build());
            when(lessonRepository.save(any(LessonEntity.class))).thenAnswer(inv -> inv.getArgument(0));
            when(lessonMapper.toLessonDetailResponse(any())).thenReturn(LessonDetailResponse.builder().id(10L).build());

            LessonDetailResponse result = lessonService.createLesson(1L, request);

            assertThat(result).isNotNull();
            assertThat(course.getTotalLessons()).isEqualTo(3);
            assertThat(course.getTotalVideos()).isEqualTo(2);
            verify(courseRepository).save(course);
        }

        @Test
        @DisplayName("Create lesson fails when Cloudinary upload throws IOException")
        void shouldThrow_WhenCloudinaryFails() throws IOException {
            ChapterEntity chapter = ChapterEntity.builder().id(1L).build();
            MockMultipartFile file = new MockMultipartFile("videoFile", "video.mp4", "video/mp4", "content".getBytes());
            LessonCreationRequest request = LessonCreationRequest.builder().title("Lesson 1").videoFile(file).build();
            LessonEntity lessonEntity = LessonEntity.builder().id(10L).build();

            when(chapterRepository.findById(1L)).thenReturn(Optional.of(chapter));
            when(lessonMapper.toLessonEntity(request)).thenReturn(lessonEntity);
            when(lessonRepository.findMaxOrderIndexByChapterId(1L)).thenReturn(0);
            when(cloudinaryService.uploadFile(any(), any())).thenThrow(new IOException("Network error"));

            assertThatThrownBy(() -> lessonService.createLesson(1L, request))
                    .isInstanceOf(AppException.class)
                    .hasFieldOrPropertyWithValue("errorCode", ErrorCode.CLOUDINARY_UPLOAD_FAILED);
        }
    }

    @Nested
    @DisplayName("deleteLesson Tests")
    class DeleteLessonTests {

        @Test
        @DisplayName("Delete non-existing lesson throws LESSON_NOT_FOUND")
        void shouldThrow_WhenLessonNotFound() {
            when(lessonRepository.findById(1L)).thenReturn(Optional.empty());

            assertThatThrownBy(() -> lessonService.deleteLesson(1L))
                    .isInstanceOf(AppException.class)
                    .hasFieldOrPropertyWithValue("errorCode", ErrorCode.LESSON_NOT_FOUND);
        }

        @Test
        @DisplayName("Delete lesson removes video from Cloudinary and decrements course counters")
        void shouldDeleteLesson_AndDecrementCounters() {
            CourseEntity course = CourseEntity.builder().id(100L).totalLessons(3).totalVideos(2).build();
            ChapterEntity chapter = ChapterEntity.builder().id(1L).course(course).build();
            LessonEntity lesson = LessonEntity.builder()
                    .id(5L)
                    .chapter(chapter)
                    .videoPublicId("pub123")
                    .videoUrl("http://video.url")
                    .build();

            when(lessonRepository.findById(5L)).thenReturn(Optional.of(lesson));

            lessonService.deleteLesson(5L);

            verify(cloudinaryService).deleteFile("pub123");
            verify(lessonRepository).delete(lesson);
            assertThat(course.getTotalLessons()).isEqualTo(2);
            assertThat(course.getTotalVideos()).isEqualTo(1);
            verify(courseRepository).save(course);
        }
    }

    @Nested
    @DisplayName("reorderLessons Tests")
    class ReorderLessonsTests {

        @Test
        @DisplayName("Reorder non-existing chapter throws CHAPTER_NOT_FOUND")
        void shouldThrow_WhenChapterNotFound() {
            when(chapterRepository.existsById(1L)).thenReturn(false);

            assertThatThrownBy(() -> lessonService.reorderLessons(1L, List.of()))
                    .isInstanceOf(AppException.class)
                    .hasFieldOrPropertyWithValue("errorCode", ErrorCode.CHAPTER_NOT_FOUND);
        }

        @Test
        @DisplayName("Reorder updates orderIndex for lessons")
        void shouldReorderLessonsSuccessfully() {
            LessonEntity l1 = LessonEntity.builder().id(10L).orderIndex(1).build();
            LessonEntity l2 = LessonEntity.builder().id(20L).orderIndex(2).build();

            when(chapterRepository.existsById(1L)).thenReturn(true);
            when(lessonRepository.findByChapterId(1L)).thenReturn(List.of(l1, l2));

            List<LessonReorderRequest> requests = List.of(
                    LessonReorderRequest.builder().id(10L).orderIndex(2).build(),
                    LessonReorderRequest.builder().id(20L).orderIndex(1).build()
            );

            lessonService.reorderLessons(1L, requests);

            assertThat(l1.getOrderIndex()).isEqualTo(2);
            assertThat(l2.getOrderIndex()).isEqualTo(1);
            verify(lessonRepository).saveAll(any());
        }
    }
}
