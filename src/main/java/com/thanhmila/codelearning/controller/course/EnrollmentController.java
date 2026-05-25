package com.thanhmila.codelearning.controller.course;

import com.thanhmila.codelearning.dto.response.ApiResponse;
import com.thanhmila.codelearning.service.course.EnrollmentService;
import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.oauth2.jwt.Jwt;
import org.springframework.web.bind.annotation.*;
import java.time.Instant;

@RestController
@RequestMapping("/enrollments")
@RequiredArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE, makeFinal = true)
public class EnrollmentController {

    EnrollmentService enrollmentService;

    @PostMapping("/free/{courseId}")
    public ResponseEntity<ApiResponse<Void>> enrollFreeCourse(
            @AuthenticationPrincipal Jwt jwt,
            @PathVariable Long courseId) {

        Long userId = jwt.getClaim("userId");
        enrollmentService.enrollFreeCourse(userId, courseId);

        return ResponseEntity.ok(ApiResponse.<Void>builder()
                .status(200)
                .code(1000)
                .message("Enrolled in free course successfully")
                .timestamp(Instant.now().toString())
                .build());
    }
}
