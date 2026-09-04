package com.thanhmila.codelearning.mapper;

import com.thanhmila.codelearning.dto.request.LessonCreationRequest;
import com.thanhmila.codelearning.dto.request.LessonUpdateRequest;
import com.thanhmila.codelearning.dto.response.LessonDetailResponse;
import com.thanhmila.codelearning.entity.enums.LessonStatus;
import com.thanhmila.codelearning.entity.lesson.LessonEntity;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.mapstruct.factory.Mappers;

import static org.assertj.core.api.Assertions.assertThat;

@DisplayName("LessonMapper Unit Tests")
class LessonMapperTest {

    private final LessonMapper lessonMapper = Mappers.getMapper(LessonMapper.class);

    @Test
    @DisplayName("toLessonDetailResponse: Ánh xạ LessonEntity sang LessonDetailResponse")
    void toLessonDetailResponse_MapsCorrectly() {
        LessonEntity entity = LessonEntity.builder()
                .id(10L)
                .title("Understanding Async")
                .status(LessonStatus.ACTIVE)
                .estimatedDurationMinutes(30)
                .videoUrl("https://video.example.com/123")
                .build();

        LessonDetailResponse response = lessonMapper.toLessonDetailResponse(entity);

        assertThat(response).isNotNull();
        assertThat(response.getId()).isEqualTo(10L);
        assertThat(response.getTitle()).isEqualTo("Understanding Async");
        assertThat(response.getEstimatedDurationMinutes()).isEqualTo(30);
        assertThat(response.getVideoUrl()).isEqualTo("https://video.example.com/123");
    }

    @Test
    @DisplayName("toLessonEntity: Ánh xạ LessonCreationRequest sang LessonEntity")
    void toLessonEntity_MapsCorrectly() {
        LessonCreationRequest request = LessonCreationRequest.builder()
                .title("New Lesson")
                .status(LessonStatus.DRAFT)
                .estimatedDurationMinutes(15)
                .build();

        LessonEntity entity = lessonMapper.toLessonEntity(request);

        assertThat(entity).isNotNull();
        assertThat(entity.getTitle()).isEqualTo("New Lesson");
        assertThat(entity.getStatus()).isEqualTo(LessonStatus.DRAFT);
        assertThat(entity.getEstimatedDurationMinutes()).isEqualTo(15);
    }

    @Test
    @DisplayName("updateLessonEntityFromRequest: Cập nhật các trường không null và bỏ qua trường null")
    void updateLessonEntityFromRequest_IgnoresNullProperties() {
        LessonEntity entity = LessonEntity.builder()
                .id(15L)
                .title("Old Title")
                .estimatedDurationMinutes(25)
                .status(LessonStatus.ACTIVE)
                .build();

        LessonUpdateRequest updateRequest = LessonUpdateRequest.builder()
                .title("Updated Title")
                .estimatedDurationMinutes(null) // Should not overwrite
                .build();

        lessonMapper.updateLessonEntityFromRequest(updateRequest, entity);

        assertThat(entity.getTitle()).isEqualTo("Updated Title");
        assertThat(entity.getEstimatedDurationMinutes()).isEqualTo(25);
    }
}
