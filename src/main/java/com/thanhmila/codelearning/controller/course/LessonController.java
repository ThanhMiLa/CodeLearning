package com.thanhmila.codelearning.controller.course;

import com.thanhmila.codelearning.dto.response.ApiResponse;
import com.thanhmila.codelearning.dto.response.LessonDetailResponse;
import com.thanhmila.codelearning.dto.response.QuizDetailResponse;
import com.thanhmila.codelearning.service.course.LessonService;
import com.thanhmila.codelearning.service.course.QuizService;
import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.oauth2.jwt.Jwt;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.time.Instant;

@Slf4j
@RestController
@RequestMapping("/lessons")
@RequiredArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE, makeFinal = true)
public class LessonController {

    LessonService lessonService;
    QuizService quizService;

    @GetMapping("/{lessonId}")
    public ResponseEntity<ApiResponse<LessonDetailResponse>> getLessonDetail(
            @AuthenticationPrincipal Jwt jwt,
            @PathVariable Long lessonId){

        Long userId = null;
        if(jwt != null){
            userId = jwt.getClaim("userId");
        }

        var result = lessonService.getLessonDetail(lessonId, userId);

        return ResponseEntity.ok(ApiResponse.<LessonDetailResponse>builder()
                .status(200)
                .code(1000)
                .message("Get lesson detail successfully")
                .result(result)
                .timestamp(Instant.now().toString())
                .build());
    }


    @GetMapping("/{lessonId}/quiz")
    @PreAuthorize("@courseSecurity.isEnrolledCourse(#lessonId)")
    public ResponseEntity<ApiResponse<QuizDetailResponse>> getQuizDetail(
            @AuthenticationPrincipal Jwt jwt,
            @PathVariable Long lessonId){
        Long userId = null;
        if(jwt != null){
            userId = jwt.getClaim("userId");
        }

        var result = quizService.getQuizDetail(lessonId);

        return ResponseEntity.ok(ApiResponse.<QuizDetailResponse>builder()
                .status(200)
                .code(1000)
                .message("Get quiz detail successfully")
                .result(result)
                .timestamp(Instant.now().toString())
                .build());

    }
}
