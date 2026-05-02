package com.thanhmila.codelearning.controller.course;

import com.thanhmila.codelearning.dto.request.CourseSearchRequest;
import com.thanhmila.codelearning.dto.response.ApiResponse;
import com.thanhmila.codelearning.dto.response.CourseListItemResponse;
import com.thanhmila.codelearning.dto.response.PageResponse;
import com.thanhmila.codelearning.service.course.CourseService;
import jakarta.validation.Valid;
import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import lombok.extern.slf4j.Slf4j;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.oauth2.jwt.Jwt;
import org.springframework.web.bind.annotation.*;

import java.time.Instant;

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

        String username = null;
        if(jwt != null){
            username = jwt.getSubject();
        }

        Pageable pageable = courseSearchRequest.getPageable();

        var result = courseService.
                getCourseList(courseSearchRequest, pageable);

        return ResponseEntity.ok(ApiResponse.<PageResponse<CourseListItemResponse>>builder()
                .status(200)
                .code(1000)
                .message("Get course list successfully")
                .result(result)
                .timestamp(Instant.now().toString())
                .build());
    }

}
