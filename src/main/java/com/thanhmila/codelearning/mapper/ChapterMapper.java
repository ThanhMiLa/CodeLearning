package com.thanhmila.codelearning.mapper;

import com.thanhmila.codelearning.dto.response.ChapterResponse;
import com.thanhmila.codelearning.dto.response.LessonSummaryResponse;
import com.thanhmila.codelearning.entity.course.ChapterEntity;
import com.thanhmila.codelearning.entity.course.LessonEntity;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;

@Mapper(componentModel = "spring")
public interface ChapterMapper {
    // ==========================================
    // 1. HÀM MAP CHÍNH
    // ==========================================
    @Mapping(target = "lessonSummaryResponses", source = "lessons")
    ChapterResponse toChapterResponse(ChapterEntity chapterEntity);


    // ==========================================
    // 2. CÁC HÀM MAP PHỤ
    // ==========================================
    @Mapping(target = "isCompleted", ignore = true)
    LessonSummaryResponse toLessonSummaryResponse(LessonEntity lessonEntity);
}
