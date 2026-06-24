package com.thanhmila.codelearning.mapper;

import com.thanhmila.codelearning.dto.response.CategoryResponse;
import com.thanhmila.codelearning.dto.response.CourseDetailResponse;
import com.thanhmila.codelearning.dto.response.CourseListItemResponse;
import com.thanhmila.codelearning.dto.response.TeacherResponse;
import com.thanhmila.codelearning.entity.course.CategoryEntity;
import com.thanhmila.codelearning.entity.course.CourseEntity;
import com.thanhmila.codelearning.entity.course.TeacherCourseAssignmentEntity;
import com.thanhmila.codelearning.dto.request.CourseCreationRequest;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;

@Mapper(componentModel = "spring")
public interface CourseMapper {
    // ==========================================
    // 1. HÀM MAP CHÍNH
    // ==========================================
    @Mapping(target = "id", ignore = true)
    @Mapping(target = "thumbnailUrl", ignore = true)
    @Mapping(target = "thumbnailPublicId", ignore = true)
    @Mapping(target = "status", ignore = true)
    @Mapping(target = "createdAt", ignore = true)
    @Mapping(target = "updatedAt", ignore = true)
    @Mapping(target = "averageRating", ignore = true)
    @Mapping(target = "totalReviews", ignore = true)
    @Mapping(target = "totalEnrolled", ignore = true)
    @Mapping(target = "totalLessons", ignore = true)
    @Mapping(target = "totalQuizzes", ignore = true)
    @Mapping(target = "totalAssignments", ignore = true)
    @Mapping(target = "totalOnlineJudgeProblems", ignore = true)
    @Mapping(target = "totalVideos", ignore = true)
    @Mapping(target = "categories", ignore = true)
    @Mapping(target = "teacherAssignments", ignore = true)
    @Mapping(target = "chapters", ignore = true)
    CourseEntity toCourseEntity(CourseCreationRequest request);
    @Mapping(target = "enrolled", ignore = true)
    @Mapping(target = "progressPercentage", ignore = true)
    @Mapping(target = "teacherName", expression = "java(getTeacherName(courseEntity))")
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

    default String getTeacherName(CourseEntity courseEntity) {
        if (courseEntity.getTeacherAssignments() == null || courseEntity.getTeacherAssignments().isEmpty()) {
            return null;
        }
        return courseEntity.getTeacherAssignments().stream()
                .map(assignment -> assignment.getTeacher().getFullName())
                .collect(java.util.stream.Collectors.joining(", "));
    }
}
