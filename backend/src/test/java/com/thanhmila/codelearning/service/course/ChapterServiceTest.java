package com.thanhmila.codelearning.service.course;

import com.thanhmila.codelearning.dto.request.ChapterCreationRequest;
import com.thanhmila.codelearning.dto.request.ChapterReorderRequest;
import com.thanhmila.codelearning.dto.request.ChapterUpdateRequest;
import com.thanhmila.codelearning.dto.response.ChapterResponse;
import com.thanhmila.codelearning.entity.course.ChapterEntity;
import com.thanhmila.codelearning.entity.course.CourseEntity;
import com.thanhmila.codelearning.exception.AppException;
import com.thanhmila.codelearning.exception.ErrorCode;
import com.thanhmila.codelearning.mapper.ChapterMapper;
import com.thanhmila.codelearning.repository.course.ChapterRepository;
import com.thanhmila.codelearning.repository.course.CourseRepository;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Nested;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;

import java.util.List;
import java.util.Optional;

import static org.assertj.core.api.Assertions.assertThat;
import static org.assertj.core.api.Assertions.assertThatThrownBy;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.Mockito.*;

@ExtendWith(MockitoExtension.class)
@DisplayName("ChapterService Unit Tests")
class ChapterServiceTest {

    @Mock ChapterRepository chapterRepository;
    @Mock CourseRepository courseRepository;
    @Mock ChapterMapper chapterMapper;

    @InjectMocks ChapterService chapterService;

    @Nested
    @DisplayName("createChapter Tests")
    class CreateChapterTests {

        @Test
        @DisplayName("Course not found throws COURSE_NOT_FOUND")
        void shouldThrow_WhenCourseNotFound() {
            when(courseRepository.findById(1L)).thenReturn(Optional.empty());

            assertThatThrownBy(() -> chapterService.createChapter(1L, new ChapterCreationRequest()))
                    .isInstanceOf(AppException.class)
                    .hasFieldOrPropertyWithValue("errorCode", ErrorCode.COURSE_NOT_FOUND);
        }

        @Test
        @DisplayName("Creates chapter with incremented orderIndex")
        void shouldCreateChapterSuccessfully() {
            CourseEntity course = CourseEntity.builder().id(1L).build();
            ChapterCreationRequest request = ChapterCreationRequest.builder().title("Ch 1").build();
            ChapterEntity chapterEntity = ChapterEntity.builder().title("Ch 1").build();

            when(courseRepository.findById(1L)).thenReturn(Optional.of(course));
            when(chapterMapper.toChapterEntity(request)).thenReturn(chapterEntity);
            when(chapterRepository.findMaxOrderIndexByCourseId(1L)).thenReturn(3);
            when(chapterRepository.save(chapterEntity)).thenAnswer(inv -> inv.getArgument(0));
            when(chapterMapper.toChapterResponse(any())).thenReturn(ChapterResponse.builder().id(10L).title("Ch 1").build());

            ChapterResponse response = chapterService.createChapter(1L, request);

            assertThat(response).isNotNull();
            assertThat(chapterEntity.getOrderIndex()).isEqualTo(4);
            assertThat(chapterEntity.getCourse()).isEqualTo(course);
        }
    }

    @Nested
    @DisplayName("updateChapterTitle Tests")
    class UpdateChapterTitleTests {

        @Test
        @DisplayName("Chapter not found throws CHAPTER_NOT_FOUND")
        void shouldThrow_WhenChapterNotFound() {
            when(chapterRepository.findById(1L)).thenReturn(Optional.empty());

            assertThatThrownBy(() -> chapterService.updateChapterTitle(1L, new ChapterUpdateRequest("New Title")))
                    .isInstanceOf(AppException.class)
                    .hasFieldOrPropertyWithValue("errorCode", ErrorCode.CHAPTER_NOT_FOUND);
        }

        @Test
        @DisplayName("Updates title successfully")
        void shouldUpdateTitleSuccessfully() {
            ChapterEntity chapter = ChapterEntity.builder().id(1L).title("Old Title").build();
            when(chapterRepository.findById(1L)).thenReturn(Optional.of(chapter));
            when(chapterRepository.save(chapter)).thenAnswer(inv -> inv.getArgument(0));
            when(chapterMapper.toChapterResponse(any())).thenReturn(ChapterResponse.builder().id(1L).title("New Title").build());

            ChapterResponse response = chapterService.updateChapterTitle(1L, new ChapterUpdateRequest("New Title"));

            assertThat(response).isNotNull();
            assertThat(chapter.getTitle()).isEqualTo("New Title");
        }
    }

    @Nested
    @DisplayName("deleteChapter Tests")
    class DeleteChapterTests {

        @Test
        @DisplayName("Delete non-existing chapter throws CHAPTER_NOT_FOUND")
        void shouldThrow_WhenChapterNotFound() {
            when(chapterRepository.findById(1L)).thenReturn(Optional.empty());

            assertThatThrownBy(() -> chapterService.deleteChapter(1L))
                    .isInstanceOf(AppException.class)
                    .hasFieldOrPropertyWithValue("errorCode", ErrorCode.CHAPTER_NOT_FOUND);
        }

        @Test
        @DisplayName("Deletes existing chapter")
        void shouldDeleteChapterSuccessfully() {
            ChapterEntity chapter = ChapterEntity.builder().id(1L).build();
            when(chapterRepository.findById(1L)).thenReturn(Optional.of(chapter));

            chapterService.deleteChapter(1L);

            verify(chapterRepository).delete(chapter);
        }
    }

    @Nested
    @DisplayName("reorderChapters Tests")
    class ReorderChaptersTests {

        @Test
        @DisplayName("Course not found throws COURSE_NOT_FOUND")
        void shouldThrow_WhenCourseNotFound() {
            when(courseRepository.existsById(1L)).thenReturn(false);

            assertThatThrownBy(() -> chapterService.reorderChapters(1L, List.of()))
                    .isInstanceOf(AppException.class)
                    .hasFieldOrPropertyWithValue("errorCode", ErrorCode.COURSE_NOT_FOUND);
        }

        @Test
        @DisplayName("Reorders chapters with temporary shift to satisfy constraints")
        void shouldReorderChaptersSuccessfully() {
            ChapterEntity c1 = ChapterEntity.builder().id(10L).orderIndex(1).build();
            ChapterEntity c2 = ChapterEntity.builder().id(20L).orderIndex(2).build();

            when(courseRepository.existsById(1L)).thenReturn(true);
            when(chapterRepository.findByCourseId(1L)).thenReturn(List.of(c1, c2));

            List<ChapterReorderRequest> requests = List.of(
                    ChapterReorderRequest.builder().id(10L).orderIndex(2).build(),
                    ChapterReorderRequest.builder().id(20L).orderIndex(1).build()
            );

            chapterService.reorderChapters(1L, requests);

            verify(chapterRepository).saveAllAndFlush(any());
            assertThat(c1.getOrderIndex()).isEqualTo(2);
            assertThat(c2.getOrderIndex()).isEqualTo(1);
            verify(chapterRepository).saveAll(any());
        }
    }
}
