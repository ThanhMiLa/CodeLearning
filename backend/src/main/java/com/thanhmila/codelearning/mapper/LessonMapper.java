package com.thanhmila.codelearning.mapper;

import com.thanhmila.codelearning.dto.request.LessonCreationRequest;
import com.thanhmila.codelearning.dto.request.LessonUpdateRequest;
import com.thanhmila.codelearning.dto.response.LessonDetailResponse;
import com.thanhmila.codelearning.entity.lesson.LessonEntity;
import org.mapstruct.BeanMapping;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;
import org.mapstruct.MappingTarget;
import org.mapstruct.NullValuePropertyMappingStrategy;

@Mapper(componentModel = "spring")
public interface LessonMapper {

    LessonDetailResponse toLessonDetailResponse(LessonEntity lessonEntity);

    @Mapping(target = "id", ignore = true)
    @Mapping(target = "chapter", ignore = true)
    @Mapping(target = "orderIndex", ignore = true)
    @Mapping(target = "videoUrl", ignore = true)
    @Mapping(target = "videoPublicId", ignore = true)
    @Mapping(target = "createdAt", ignore = true)
    @Mapping(target = "updatedAt", ignore = true)
    LessonEntity toLessonEntity(LessonCreationRequest request);

    @Mapping(target = "id", ignore = true)
    @Mapping(target = "chapter", ignore = true)
    @Mapping(target = "orderIndex", ignore = true)
    @Mapping(target = "videoUrl", ignore = true)
    @Mapping(target = "videoPublicId", ignore = true)
    @Mapping(target = "createdAt", ignore = true)
    @Mapping(target = "updatedAt", ignore = true)
    @BeanMapping(nullValuePropertyMappingStrategy = NullValuePropertyMappingStrategy.IGNORE)
    void updateLessonEntityFromRequest(LessonUpdateRequest request, @MappingTarget LessonEntity lessonEntity);
}
