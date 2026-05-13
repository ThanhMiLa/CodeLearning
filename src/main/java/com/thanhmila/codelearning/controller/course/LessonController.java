package com.thanhmila.codelearning.controller.course;

import com.thanhmila.codelearning.dto.request.LessonCommentRequest;
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
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.oauth2.jwt.Jwt;
import org.springframework.web.bind.annotation.*;

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

        // API này cho phép user chưa đăng nhập xem bài học (nếu là bài học thử),
        // nên không gắn @PreAuthorize ở Controller. Logic chặn quyền nằm trong Service.
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
        @PreAuthorize("hasAuthority('QUIZ_VIEW') and (@courseSecurity.canAccessLesson(#lessonId) or @courseSecurity.canManageLesson(#lessonId))")
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
        @PreAuthorize("hasAuthority('COMMENT_VIEW') and (@courseSecurity.canAccessLesson(#lessonId) or @courseSecurity.canManageLesson(#lessonId))")
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
        @PreAuthorize("hasAuthority('COMMENT_VIEW') and (@courseSecurity.canAccessLesson(#lessonId) or @courseSecurity.canManageLesson(#lessonId))")
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
                "(hasAnyAuthority('COMMENT_CREATE', 'COMMENT_REPLY_ASSIGNED_COURSE') and @courseSecurity.canManageLesson(#lessonId))")
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
                        @PathVariable("lessonId") Long lessonId,
                        @AuthenticationPrincipal Jwt jwt) {

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

        @PostMapping("/{lessonId}/quiz")
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

        @PutMapping("/{lessonId}/quiz")
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

        @DeleteMapping("/{lessonId}/quiz")
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