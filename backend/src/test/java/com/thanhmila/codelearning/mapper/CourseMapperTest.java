package com.thanhmila.codelearning.mapper;

import com.thanhmila.codelearning.dto.request.CourseCreationRequest;
import com.thanhmila.codelearning.dto.response.CategoryResponse;
import com.thanhmila.codelearning.dto.response.CourseDetailResponse;
import com.thanhmila.codelearning.dto.response.CourseListItemResponse;
import com.thanhmila.codelearning.dto.response.TeacherResponse;
import com.thanhmila.codelearning.entity.course.CategoryEntity;
import com.thanhmila.codelearning.entity.course.CourseEntity;
import com.thanhmila.codelearning.entity.course.TeacherCourseAssignmentEntity;
import com.thanhmila.codelearning.entity.user.TeacherEntity;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.mapstruct.factory.Mappers;

import java.math.BigDecimal;
import java.util.Set;

import static org.assertj.core.api.Assertions.assertThat;

@DisplayName("CourseMapper Unit Tests")
class CourseMapperTest {

    private final CourseMapper courseMapper = Mappers.getMapper(CourseMapper.class);

    @Test
    @DisplayName("toCourseEntity: Ánh xạ CourseCreationRequest sang CourseEntity")
    void toCourseEntity_MapsCorrectly() {
        CourseCreationRequest request = CourseCreationRequest.builder()
                .title("Spring Boot Mastery")
                .shortDescription("Master Spring Boot from zero to hero")
                .price(new BigDecimal("299000"))
                .estimatedDurationHours(40)
                .build();

        CourseEntity entity = courseMapper.toCourseEntity(request);

        assertThat(entity).isNotNull();
        assertThat(entity.getTitle()).isEqualTo("Spring Boot Mastery");
        assertThat(entity.getShortDescription()).isEqualTo("Master Spring Boot from zero to hero");
        assertThat(entity.getPrice()).isEqualTo(new BigDecimal("299000"));
        assertThat(entity.getEstimatedDurationHours()).isEqualTo(40);
    }

    @Test
    @DisplayName("toCourseListItemResponse: Ánh xạ CourseEntity sang CourseListItemResponse và lấy tên giáo viên")
    void toCourseListItemResponse_MapsTeacherName() {
        TeacherEntity teacher = TeacherEntity.builder().id(1L).fullName("Prof. John Doe").build();
        TeacherCourseAssignmentEntity assignment = TeacherCourseAssignmentEntity.builder().teacher(teacher).build();

        CourseEntity course = CourseEntity.builder()
                .id(10L)
                .title("Java Core")
                .price(BigDecimal.ZERO)
                .teacherAssignments(Set.of(assignment))
                .build();

        CourseListItemResponse response = courseMapper.toCourseListItemResponse(course);

        assertThat(response).isNotNull();
        assertThat(response.getId()).isEqualTo(10L);
        assertThat(response.getTitle()).isEqualTo("Java Core");
        assertThat(response.getTeacherName()).isEqualTo("Prof. John Doe");
    }

    @Test
    @DisplayName("getTeacherName: Khi course không có teacherAssignments trả về null")
    void getTeacherName_EmptyAssignments_ReturnsNull() {
        CourseEntity course = CourseEntity.builder().teacherAssignments(null).build();
        String name = courseMapper.getTeacherName(course);
        assertThat(name).isNull();
    }

    @Test
    @DisplayName("toCourseDetailResponse: Ánh xạ CourseEntity sang CourseDetailResponse")
    void toCourseDetailResponse_MapsCorrectly() {
        TeacherEntity teacher = TeacherEntity.builder().id(5L).fullName("Alice Smith").build();
        TeacherCourseAssignmentEntity assignment = TeacherCourseAssignmentEntity.builder().teacher(teacher).build();

        CourseEntity course = CourseEntity.builder()
                .id(20L)
                .title("Advanced Python")
                .teacherAssignments(Set.of(assignment))
                .build();

        CourseDetailResponse response = courseMapper.toCourseDetailResponse(course);

        assertThat(response).isNotNull();
        assertThat(response.getId()).isEqualTo(20L);
        assertThat(response.getTitle()).isEqualTo("Advanced Python");
        assertThat(response.getInstructors()).hasSize(1);
    }

    @Test
    @DisplayName("toTeacherResponse & toCategoryResponse: Ánh xạ phụ chính xác")
    void toTeacherAndCategoryResponse_MapsCorrectly() {
        TeacherEntity teacher = TeacherEntity.builder().id(12L).fullName("Bob Teacher").build();
        TeacherCourseAssignmentEntity assignment = TeacherCourseAssignmentEntity.builder().teacher(teacher).build();
        CategoryEntity category = CategoryEntity.builder().id(3L).name("Web Development").build();

        TeacherResponse teacherResponse = courseMapper.toTeacherResponse(assignment);
        CategoryResponse categoryResponse = courseMapper.toCategoryResponse(category);

        assertThat(teacherResponse).isNotNull();
        assertThat(teacherResponse.getId()).isEqualTo(12L);
        assertThat(teacherResponse.getFullName()).isEqualTo("Bob Teacher");

        assertThat(categoryResponse).isNotNull();
        assertThat(categoryResponse.getId()).isEqualTo(3L);
        assertThat(categoryResponse.getName()).isEqualTo("Web Development");
    }
}
