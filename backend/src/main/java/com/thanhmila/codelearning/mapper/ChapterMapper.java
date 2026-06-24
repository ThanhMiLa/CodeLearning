package com.thanhmila.codelearning.mapper;

import com.thanhmila.codelearning.dto.request.ChapterCreationRequest;
import com.thanhmila.codelearning.dto.request.ChapterUpdateRequest;
import com.thanhmila.codelearning.dto.response.ChapterResponse;
import com.thanhmila.codelearning.dto.response.LessonSummaryResponse;
import com.thanhmila.codelearning.entity.course.ChapterEntity;
import com.thanhmila.codelearning.entity.lesson.LessonEntity;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;
import org.mapstruct.MappingTarget;

@Mapper(componentModel = "spring")
public interface ChapterMapper {
    // ==========================================
    // 1. HÀM MAP CHÍNH
    // ==========================================
    @Mapping(target = "lessonSummaryResponses", source = "lessons")
    ChapterResponse toChapterResponse(ChapterEntity chapterEntity);

    @Mapping(target = "id", ignore = true)
    @Mapping(target = "course", ignore = true)
    @Mapping(target = "orderIndex", ignore = true)
    @Mapping(target = "lessons", ignore = true)
    ChapterEntity toChapterEntity(ChapterCreationRequest request);

    // ==========================================
    // 2. CÁC HÀM MAP PHỤ
    // ==========================================
    @Mapping(target = "isCompleted", ignore = true)
    LessonSummaryResponse toLessonSummaryResponse(LessonEntity lessonEntity);
}
