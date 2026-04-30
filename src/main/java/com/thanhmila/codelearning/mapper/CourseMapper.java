package com.thanhmila.codelearning.mapper;

import com.thanhmila.codelearning.dto.response.CourseListItemResponse;
import com.thanhmila.codelearning.entity.CourseEntity;

public interface CourseMapper {
    CourseListItemResponse toCourseListItemResponse(CourseEntity courseEntity);
}
