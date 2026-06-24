package com.thanhmila.codelearning.mapper;

import com.thanhmila.codelearning.dto.response.ContestResponse;
import com.thanhmila.codelearning.entity.contest.ContestEntity;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;
import org.springframework.util.StringUtils;

@Mapper(componentModel = "spring", imports = {StringUtils.class})
public interface ContestMapper {

    @Mapping(target = "isProtected", expression = "java(StringUtils.hasText(contestEntity.getPasswordHash()))")
    @Mapping(target = "teacherName", source = "createdByTeacher.fullName")
    ContestResponse toContestResponse(ContestEntity contestEntity);
}
