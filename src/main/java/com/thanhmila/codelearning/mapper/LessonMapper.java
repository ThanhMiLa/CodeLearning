package com.thanhmila.codelearning.mapper;

import com.thanhmila.codelearning.dto.response.LessonDetailResponse;
import com.thanhmila.codelearning.entity.course.LessonEntity;
import org.mapstruct.Mapper;

@Mapper(componentModel = "spring")
public interface LessonMapper {

    LessonDetailResponse toLessonDetailResponse(LessonEntity lessonEntity);
}
