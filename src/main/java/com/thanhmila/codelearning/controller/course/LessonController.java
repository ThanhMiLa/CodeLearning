package com.thanhmila.codelearning.controller.course;

import com.thanhmila.codelearning.dto.response.ApiResponse;
import com.thanhmila.codelearning.dto.response.LessonDetailResponse;
import com.thanhmila.codelearning.dto.response.QuizDetailResponse;
import com.thanhmila.codelearning.dto.response.LessonCommentResponse;
import com.thanhmila.codelearning.service.course.LessonCommentService;
import com.thanhmila.codelearning.service.course.LessonService;
import com.thanhmila.codelearning.service.course.QuizService;
import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import lombok.extern.slf4j.Slf4j;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.web.PageableDefault;
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
    LessonCommentService lessonCommentService;

    @GetMapping("/{lessonId}")
    public ResponseEntity<ApiResponse<LessonDetailResponse>> getLessonDetail(
            @AuthenticationPrincipal Jwt jwt,
            @PathVariable("lessonId") Long lessonId){

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
    @PreAuthorize("@courseSecurity.canAccessLesson(#lessonId)")
    public ResponseEntity<ApiResponse<QuizDetailResponse>> getQuizDetail(
            @AuthenticationPrincipal Jwt jwt,
            @PathVariable("lessonId") Long lessonId){
        Long userId = null;
        if(jwt != null){
            userId = jwt.getClaim("userId");
        }

        var result = quizService.getQuizDetail(lessonId, userId);

        return ResponseEntity.ok(ApiResponse.<QuizDetailResponse>builder()
                .status(200)
                .code(1000)
                .message("Get quiz detail successfully")
                .result(result)
                .timestamp(Instant.now().toString())
                .build());

    }

    @GetMapping("/{lessonId}/comments")
    @PreAuthorize("@courseSecurity.canAccessLesson(#lessonId)")
    public ResponseEntity<ApiResponse<Page<LessonCommentResponse>>> getCommentList(
            @PathVariable("lessonId") Long lessonId,
            @PageableDefault(size = 10, sort = "createdAt", direction = Sort.Direction.ASC) Pageable pageable){

        var result = lessonCommentService.getRootComments(lessonId, pageable);

        return ResponseEntity.ok(ApiResponse.<Page<LessonCommentResponse>>builder()
                .status(200)
                .code(1000)
                .message("Get root lesson comment successfully")
                .result(result)
                .timestamp(Instant.now().toString())
                .build());

    }

    @GetMapping("/{lessonId}/comments/{commentId}/replies")
    @PreAuthorize("@courseSecurity.canAccessLesson(#lessonId)")
    public ResponseEntity<ApiResponse<Page<LessonCommentResponse>>> getCommentListWithReply(
            @PathVariable("lessonId") Long lessonId,
            @PathVariable("commentId") Long commentId,
            @PageableDefault(size = 10, sort = "createdAt", direction = Sort.Direction.ASC) Pageable pageable){

        var result = lessonCommentService.getReplies(commentId, pageable);

        return ResponseEntity.ok(ApiResponse.<Page<LessonCommentResponse>>builder()
                .status(200)
                .code(1000)
                .message("Get replies of lesson comment successfully")
                .result(result)
                .timestamp(Instant.now().toString())
                .build());

    }


}
