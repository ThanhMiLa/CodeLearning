package com.thanhmila.codelearning.mapper;

import com.thanhmila.codelearning.dto.response.CategoryResponse;
import com.thanhmila.codelearning.dto.response.CourseDetailResponse;
import com.thanhmila.codelearning.dto.response.CourseListItemResponse;
import com.thanhmila.codelearning.dto.response.TeacherResponse;
import com.thanhmila.codelearning.entity.course.CategoryEntity;
import com.thanhmila.codelearning.entity.course.CourseEntity;
import com.thanhmila.codelearning.entity.course.TeacherCourseAssignmentEntity;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;

@Mapper(componentModel = "spring")
public interface CourseMapper {
    // ==========================================
    // 1. HÀM MAP CHÍNH
    // ==========================================
    @Mapping(target = "enrolled", ignore = true)
    @Mapping(target = "progressPercentage", ignore = true)
    CourseListItemResponse toCourseListItemResponse(CourseEntity courseEntity);


    @Mapping(target = "isEnrolled", ignore = true)
    @Mapping(target = "instructors", source = "teacherAssignments")
    @Mapping(target = "progressPercentage", ignore = true)
    CourseDetailResponse toCourseDetailResponse(CourseEntity courseEntity);


    // ==========================================
    // 2. CÁC HÀM MAP PHỤ
    // ==========================================
    @Mapping(target = "id", source = "teacher.id")
    @Mapping(target = "fullName", source = "teacher.fullName")
    TeacherResponse toTeacherResponse(TeacherCourseAssignmentEntity teacherCourseAssignmentEntity);


    CategoryResponse toCategoryResponse(CategoryEntity categoryEntity);
}
