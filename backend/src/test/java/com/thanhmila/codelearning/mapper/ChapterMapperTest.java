package com.thanhmila.codelearning.mapper;

import com.thanhmila.codelearning.dto.request.ChapterCreationRequest;
import com.thanhmila.codelearning.dto.response.ChapterResponse;
import com.thanhmila.codelearning.dto.response.LessonSummaryResponse;
import com.thanhmila.codelearning.entity.course.ChapterEntity;
import com.thanhmila.codelearning.entity.lesson.LessonEntity;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.mapstruct.factory.Mappers;

import java.util.List;

import static org.assertj.core.api.Assertions.assertThat;

@DisplayName("ChapterMapper Unit Tests")
class ChapterMapperTest {

    private final ChapterMapper chapterMapper = Mappers.getMapper(ChapterMapper.class);

    @Test
    @DisplayName("toChapterResponse: Ánh xạ ChapterEntity sang ChapterResponse kèm danh sách bài học con")
    void toChapterResponse_MapsCorrectly() {
        LessonEntity lesson = LessonEntity.builder()
                .id(101L)
                .title("Introduction")
                .estimatedDurationMinutes(15)
                .build();

        ChapterEntity chapter = ChapterEntity.builder()
                .id(1L)
                .title("Chapter 1: Getting Started")
                .lessons(List.of(lesson))
                .build();

        ChapterResponse response = chapterMapper.toChapterResponse(chapter);

        assertThat(response).isNotNull();
        assertThat(response.getId()).isEqualTo(1L);
        assertThat(response.getTitle()).isEqualTo("Chapter 1: Getting Started");
        assertThat(response.getLessonSummaryResponses()).hasSize(1);
        assertThat(response.getLessonSummaryResponses().get(0).getTitle()).isEqualTo("Introduction");
    }

    @Test
    @DisplayName("toChapterEntity: Ánh xạ ChapterCreationRequest sang ChapterEntity")
    void toChapterEntity_MapsCorrectly() {
        ChapterCreationRequest request = ChapterCreationRequest.builder()
                .title("Chapter 2: Deep Dive")
                .build();

        ChapterEntity entity = chapterMapper.toChapterEntity(request);

        assertThat(entity).isNotNull();
        assertThat(entity.getTitle()).isEqualTo("Chapter 2: Deep Dive");
    }

    @Test
    @DisplayName("toLessonSummaryResponse: Ánh xạ LessonEntity sang LessonSummaryResponse")
    void toLessonSummaryResponse_MapsCorrectly() {
        LessonEntity lesson = LessonEntity.builder()
                .id(202L)
                .title("Spring DI")
                .estimatedDurationMinutes(20)
                .build();

        LessonSummaryResponse response = chapterMapper.toLessonSummaryResponse(lesson);

        assertThat(response).isNotNull();
        assertThat(response.getId()).isEqualTo(202L);
        assertThat(response.getTitle()).isEqualTo("Spring DI");
        assertThat(response.getEstimatedDurationMinutes()).isEqualTo(20);
    }
}
