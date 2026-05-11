package com.thanhmila.codelearning.controller.course;

import java.time.Instant;

import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.oauth2.jwt.Jwt;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
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
@RequestMapping("/quizzes")
@RequiredArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE, makeFinal = true)
public class QuizController {
    QuizService quizService;

    @PostMapping("/{quizId}/submit")
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
}
