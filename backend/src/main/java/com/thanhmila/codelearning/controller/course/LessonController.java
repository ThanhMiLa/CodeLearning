package com.thanhmila.codelearning.controller.course;

import com.thanhmila.codelearning.dto.request.LessonCommentRequest;
import com.thanhmila.codelearning.dto.request.LessonCreationRequest;
import com.thanhmila.codelearning.dto.request.LessonReorderRequest;
import com.thanhmila.codelearning.dto.request.LessonUpdateRequest;
import com.thanhmila.codelearning.dto.request.QuizRequest;
import com.thanhmila.codelearning.dto.response.ApiResponse;
import com.thanhmila.codelearning.dto.response.LessonDetailResponse;
import com.thanhmila.codelearning.dto.response.QuizDetailResponse;
import com.thanhmila.codelearning.dto.response.LessonCommentResponse;
import com.thanhmila.codelearning.dto.response.LessonCompletionResponse;
import com.thanhmila.codelearning.service.course.LessonCommentService;
import com.thanhmila.codelearning.service.course.LessonService;
import com.thanhmila.codelearning.service.course.QuizService;

import jakarta.validation.Valid;
import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import lombok.extern.slf4j.Slf4j;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.web.PageableDefault;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.oauth2.jwt.Jwt;
import org.springframework.web.bind.annotation.*;

import java.time.Instant;
import java.util.List;

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
                        @PathVariable("lessonId") Long lessonId) {

                Long userId = null;
                if (jwt != null) {
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
        @PreAuthorize("hasAuthority('QUIZ_VIEW') and (@courseSecurity.canAccessLesson(#lessonId) " +
                "or @courseSecurity.canManageLesson(#lessonId))")
        public ResponseEntity<ApiResponse<QuizDetailResponse>> getQuizDetail(
                        @AuthenticationPrincipal Jwt jwt,
                        @PathVariable("lessonId") Long lessonId) {
                Long userId = jwt.getClaim("userId");

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
        @PreAuthorize("hasAuthority('COMMENT_VIEW') and (@courseSecurity.canAccessLesson(#lessonId) " +
                "or @courseSecurity.canManageLesson(#lessonId))")
        public ResponseEntity<ApiResponse<Page<LessonCommentResponse>>> getCommentList(
                        @PathVariable("lessonId") Long lessonId,
                        @PageableDefault(size = 10, sort = "createdAt", direction = Sort.Direction.ASC) Pageable pageable) {

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
        @PreAuthorize("hasAuthority('COMMENT_VIEW') and (@courseSecurity.canAccessLesson(#lessonId)" +
                " or @courseSecurity.canManageLesson(#lessonId))")
        public ResponseEntity<ApiResponse<Page<LessonCommentResponse>>> getCommentListWithReply(
                        @PathVariable("lessonId") Long lessonId,
                        @PathVariable("commentId") Long commentId,
                        @PageableDefault(size = 10, sort = "createdAt", direction = Sort.Direction.ASC) Pageable pageable) {

                var result = lessonCommentService.getReplies(commentId, pageable);

                return ResponseEntity.ok(ApiResponse.<Page<LessonCommentResponse>>builder()
                                .status(200)
                                .code(1000)
                                .message("Get replies of lesson comment successfully")
                                .result(result)
                                .timestamp(Instant.now().toString())
                                .build());
        }

        @PostMapping("/{lessonId}/comments")
        @PreAuthorize("(hasAuthority('COMMENT_CREATE') and @courseSecurity.canAccessLesson(#lessonId)) or " + 
                "(hasAnyAuthority('COMMENT_CREATE') and @courseSecurity.canManageLesson(#lessonId))")
        public ResponseEntity<ApiResponse<LessonCommentResponse>> createComment(
                        @PathVariable("lessonId") Long lessonId,
                        @AuthenticationPrincipal Jwt jwt,
                        @RequestBody LessonCommentRequest request) {

                Long userId = jwt.getClaim("userId");

                var result = lessonCommentService.createComment(lessonId, userId, request);

                return ResponseEntity.ok(ApiResponse.<LessonCommentResponse>builder()
                                .status(200)
                                .code(1000)
                                .message("Create lesson comment successfully")
                                .result(result)
                                .timestamp(Instant.now().toString())
                                .build());
        }

        @PostMapping("/{lessonId}/complete")
        @PreAuthorize("hasAuthority('LESSON_COMPLETE') and @courseSecurity.canAccessLesson(#lessonId)")
        public ResponseEntity<ApiResponse<LessonCompletionResponse>> completedLesson(
                        @AuthenticationPrincipal Jwt jwt,
                        @PathVariable("lessonId") Long lessonId) {

                Long userId = jwt.getClaim("userId");

                var result = lessonService.completedLesson(lessonId, userId);

                return ResponseEntity.ok(ApiResponse.<LessonCompletionResponse>builder()
                                .status(200)
                                .code(1000)
                                .message("Completed lesson successfully")
                                .result(result)
                                .timestamp(Instant.now().toString())
                                .build());
        }

        @PostMapping(value = "/chapters/{chapterId}/lessons", consumes = MediaType.MULTIPART_FORM_DATA_VALUE)
        @PreAuthorize("hasAuthority('LESSON_CREATE') and @courseSecurity.canManageChapter(#chapterId)")
        public ResponseEntity<ApiResponse<LessonDetailResponse>> createLesson(
                        @PathVariable("chapterId") Long chapterId,
                        @ModelAttribute @Valid LessonCreationRequest request) {

                var result = lessonService.createLesson(chapterId, request);

                return ResponseEntity.ok(ApiResponse.<LessonDetailResponse>builder()
                                .status(200)
                                .code(1000)
                                .message("Create lesson successfully")
                                .result(result)
                                .timestamp(Instant.now().toString())
                                .build());
        }

        @PutMapping(value = "/{lessonId}", consumes = MediaType.MULTIPART_FORM_DATA_VALUE)
        @PreAuthorize("hasAuthority('LESSON_UPDATE') and @courseSecurity.canManageLesson(#lessonId)")
        public ResponseEntity<ApiResponse<LessonDetailResponse>> updateLesson(
                        @PathVariable("lessonId") Long lessonId,
                        @ModelAttribute @Valid LessonUpdateRequest request) {

                var result = lessonService.updateLesson(lessonId, request);

                return ResponseEntity.ok(ApiResponse.<LessonDetailResponse>builder()
                                .status(200)
                                .code(1000)
                                .message("Update lesson successfully")
                                .result(result)
                                .timestamp(Instant.now().toString())
                                .build());
        }

        @DeleteMapping("/{lessonId}")
        @PreAuthorize("hasAuthority('LESSON_DELETE') and @courseSecurity.canManageLesson(#lessonId)")
        public ResponseEntity<ApiResponse<Void>> deleteLesson(
                        @PathVariable("lessonId") Long lessonId) {

                lessonService.deleteLesson(lessonId);

                return ResponseEntity.ok(ApiResponse.<Void>builder()
                                .status(200)
                                .code(1000)
                                .message("Delete lesson successfully")
                                .timestamp(Instant.now().toString())
                                .build());
        }

        @PutMapping("/chapters/{chapterId}/lessons/reorder")
        @PreAuthorize("hasAuthority('LESSON_UPDATE') and @courseSecurity.canManageChapter(#chapterId)")
        public ResponseEntity<ApiResponse<Void>> reorderLessons(
                        @PathVariable("chapterId") Long chapterId,
                        @Valid @RequestBody List<LessonReorderRequest> requests) {

                lessonService.reorderLessons(chapterId, requests);

                return ResponseEntity.ok(ApiResponse.<Void>builder()
                                .status(200)
                                .code(1000)
                                .message("Reorder lessons successfully")
                                .timestamp(Instant.now().toString())
                                .build());
        }
}