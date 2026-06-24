package com.thanhmila.codelearning.controller.course;

import java.time.Instant;

import com.thanhmila.codelearning.dto.request.QuizRequest;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.oauth2.jwt.Jwt;
import org.springframework.web.bind.annotation.*;
import com.thanhmila.codelearning.dto.request.QuizSubmitRequest;
import com.thanhmila.codelearning.dto.response.ApiResponse;
import com.thanhmila.codelearning.dto.response.QuizSubmitResponse;
import com.thanhmila.codelearning.service.course.QuizService;
import jakarta.validation.Valid;
import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RestController
@RequiredArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE, makeFinal = true)
public class QuizController {
    QuizService quizService;

    @PostMapping("quizzes/{quizId}/submit")
    @PreAuthorize("hasAuthority('QUIZ_SUBMIT') and @courseSecurity.canAccessQuiz(#quizId)")
    public ResponseEntity<ApiResponse<QuizSubmitResponse>> submitQuiz(
            @AuthenticationPrincipal Jwt jwt,
            @Valid @RequestBody QuizSubmitRequest quizSubmitRequest,
            @PathVariable("quizId") Long quizId){

        Long userId = jwt.getClaim("userId");

        var result = quizService.submitQuiz(quizId, userId, quizSubmitRequest);

        return ResponseEntity.ok(ApiResponse.<QuizSubmitResponse>builder()
                .status(200)
                .code(1000)
                .message("Submit quiz successfully")
                .result(result)
                .timestamp(Instant.now().toString())
                .build());

    }

    @PostMapping("lessons/{lessonId}/quiz")
    @PreAuthorize("hasAuthority('QUIZ_CREATE_ASSIGNED_COURSE') and @courseSecurity.canManageLesson(#lessonId)")
    public ResponseEntity<ApiResponse<Void>> createQuiz(
            @PathVariable Long lessonId,
            @AuthenticationPrincipal Jwt jwt,
            @Valid @RequestBody QuizRequest request) {
        Long teacherId = jwt.getClaim("userId");
        quizService.createQuiz(lessonId, teacherId, request);
        return ResponseEntity.ok(ApiResponse.<Void>builder()
                .status(200)
                .code(1000)
                .message("Create quiz successfully")
                .timestamp(Instant.now().toString())
                .build());
    }

    @PutMapping("lessons/{lessonId}/quiz")
    @PreAuthorize("hasAuthority('QUIZ_UPDATE_ASSIGNED_COURSE') and @courseSecurity.canManageLesson(#lessonId)")
    public ResponseEntity<ApiResponse<Void>> updateQuiz(
            @PathVariable("lessonId") Long lessonId,
            @AuthenticationPrincipal Jwt jwt,
            @Valid @RequestBody QuizRequest request) {
        Long userId = jwt.getClaim("userId");
        quizService.updateQuiz(lessonId, userId, request);

        return ResponseEntity.ok(ApiResponse.<Void>builder()
                .status(200)
                .code(1000)
                .message("Update quiz successfully")
                .timestamp(Instant.now().toString())
                .build());
    }

    @DeleteMapping("lessons/{lessonId}/quiz")
    @PreAuthorize("hasAuthority('QUIZ_DELETE_ASSIGNED_COURSE') and @courseSecurity.canManageLesson(#lessonId)")
    public ResponseEntity<ApiResponse<Void>> deleteQuiz(
            @PathVariable("lessonId") Long lessonId,
            @AuthenticationPrincipal Jwt jwt) {
        Long userId = jwt.getClaim("userId");
        quizService.deleteQuiz(lessonId, userId);

        return ResponseEntity.ok(ApiResponse.<Void>builder()
                .status(200)
                .code(1000)
                .message("Delete quiz successfully")
                .timestamp(Instant.now().toString())
                .build());
    }
}
