package com.thanhmila.codelearning.controller.course;

import com.thanhmila.codelearning.dto.request.CourseSearchRequest;
import com.thanhmila.codelearning.dto.response.*;
import com.thanhmila.codelearning.service.course.CourseService;
import jakarta.validation.Valid;
import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import lombok.extern.slf4j.Slf4j;
import org.springframework.data.domain.Pageable;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.oauth2.jwt.Jwt;
import org.springframework.web.bind.annotation.*;
import java.time.Instant;
import java.util.List;

import com.thanhmila.codelearning.dto.request.CourseCreationRequest;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.http.MediaType;

@Slf4j
@RestController
@RequestMapping("/courses")
@RequiredArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE, makeFinal = true)
public class CourseController {

    CourseService courseService;

    @GetMapping
    public ResponseEntity<ApiResponse<PageResponse<CourseListItemResponse>>> getCourseList(
            @AuthenticationPrincipal Jwt jwt,
            @Valid CourseSearchRequest courseSearchRequest){

        Long userId = null;
        if(jwt != null){
            userId = jwt.getClaim("userId");
        }

        Pageable pageable = courseSearchRequest.getPageable();

        PageResponse<CourseListItemResponse> result = courseService.
                getCourseList(userId, courseSearchRequest, pageable);

        return ResponseEntity.ok(ApiResponse.<PageResponse<CourseListItemResponse>>builder()
                .status(200)
                .code(1000)
                .message("Get course list successfully")
                .result(result)
                .timestamp(Instant.now().toString())
                .build());
    }

    @GetMapping("/enrolled")
    @PreAuthorize("isAuthenticated()")
    public ResponseEntity<ApiResponse<PageResponse<EnrolledCourseResponse>>> getEnrolledCourses(
            @AuthenticationPrincipal Jwt jwt,
            @RequestParam(name = "page", defaultValue = "0") int page,
            @RequestParam(name = "size", defaultValue = "10") int size) {

        Long userId = jwt.getClaim("userId");
        PageResponse<EnrolledCourseResponse> result = courseService.getEnrolledCourses(userId, page, size);

        return ResponseEntity.ok(ApiResponse.<PageResponse<EnrolledCourseResponse>>builder()
                .status(200)
                .code(1000)
                .message("Get enrolled courses successfully")
                .result(result)
                .timestamp(Instant.now().toString())
                .build());
    }

    @GetMapping("/{courseId}")
    public ResponseEntity<ApiResponse<CourseDetailResponse>> getCourseDetail(
            @AuthenticationPrincipal Jwt jwt,
            @PathVariable("courseId") Long courseId){

        Long userId = null;
        if(jwt != null){
            userId = jwt.getClaim("userId");
        }

        CourseDetailResponse result = courseService.
                getCourseDetail(courseId, userId);

        return ResponseEntity.ok(ApiResponse.<CourseDetailResponse>builder()
                .status(200)
                .code(1000)
                .message("Get course detail successfully")
                .result(result)
                .timestamp(Instant.now().toString())
                .build());
    }

    @GetMapping("/{courseId}/curriculum")
    public ResponseEntity<ApiResponse<List<ChapterResponse>>> getCourseCurriculum(
            @AuthenticationPrincipal Jwt jwt,
            @PathVariable("courseId") Long courseId){

        Long userId = null;
        if(jwt != null){
            userId = jwt.getClaim("userId");
        }

        List<ChapterResponse> result = courseService.
                getCourseCurriculum(courseId, userId);

        return ResponseEntity.ok(ApiResponse.<List<ChapterResponse>>builder()
                .status(200)
                .code(1000)
                .message("Get course curriculum successfully")
                .result(result)
                .timestamp(Instant.now().toString())
                .build());
    }

    @GetMapping("/categories")
    public ResponseEntity<ApiResponse<List<CategoryResponse>>> getCategories() {
        List<CategoryResponse> result = courseService.getAllCategories();

        return ResponseEntity.ok(ApiResponse.<List<CategoryResponse>>builder()
                .status(200)
                .code(1000)
                .message("Get categories successfully")
                .result(result)
                .timestamp(Instant.now().toString())
                .build());
    }

    @PostMapping(consumes = MediaType.MULTIPART_FORM_DATA_VALUE)
    @PreAuthorize("hasAuthority('COURSE_CREATE')")
    public ResponseEntity<ApiResponse<CourseDetailResponse>> createCourse(
            @ModelAttribute @Valid CourseCreationRequest request) {

        CourseDetailResponse result = courseService.createCourse(request);

        return ResponseEntity.ok(ApiResponse.<CourseDetailResponse>builder()
                .status(200)
                .code(1000)
                .message("Create course successfully")
                .result(result)
                .timestamp(Instant.now().toString())
                .build());
    }

}
