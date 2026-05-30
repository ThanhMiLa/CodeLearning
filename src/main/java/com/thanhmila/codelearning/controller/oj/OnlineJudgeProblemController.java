package com.thanhmila.codelearning.controller.oj;

import com.thanhmila.codelearning.dto.judge0.Judge0CallbackPayload;
import com.thanhmila.codelearning.dto.request.GenerateTestcaseRequest;
import com.thanhmila.codelearning.dto.request.OjSubmissionRequest;
import com.thanhmila.codelearning.dto.response.OjSubmissionInitialResponse;
import com.thanhmila.codelearning.service.oj.OjSubmissionService;
import jakarta.validation.Valid;
import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import lombok.extern.slf4j.Slf4j;
import java.time.Instant;
import java.util.List;

import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.oauth2.jwt.Jwt;
import org.springframework.web.bind.annotation.*;
import com.thanhmila.codelearning.dto.response.PageResponse;
import com.thanhmila.codelearning.dto.response.OjPracticeProblemResponse;
import com.thanhmila.codelearning.dto.response.ApiResponse;
import com.thanhmila.codelearning.dto.response.OjProblemDetailResponse;
import com.thanhmila.codelearning.dto.response.OjLessonProblemResponse;
import com.thanhmila.codelearning.service.oj.OnlineJudgeProblemService;

import com.thanhmila.codelearning.dto.request.ProblemSearchRequest;

@Slf4j
@RestController
@RequiredArgsConstructor
@RequestMapping("/online-judge")
@FieldDefaults(level = AccessLevel.PRIVATE, makeFinal = true)
public class OnlineJudgeProblemController {
    
    OnlineJudgeProblemService onlineJudgeProblemService;
    OjSubmissionService ojSubmissionService;
    com.thanhmila.codelearning.service.oj.OjTestcaseGenerationService ojTestcaseGenerationService;

    @GetMapping("/problems/practice")
    public ResponseEntity<ApiResponse<PageResponse<OjPracticeProblemResponse>>> getPracticeProblems(
            @AuthenticationPrincipal Jwt jwt,
            @Valid ProblemSearchRequest request) {

        Long userId = null;
        if (jwt != null) {
            userId = jwt.getClaim("userId");
        }

        var result = onlineJudgeProblemService.getPracticeProblems(request, userId);

        return ResponseEntity.ok(ApiResponse.<PageResponse<OjPracticeProblemResponse>>builder()
                .status(200)
                .code(1000)
                .message("Get practice problems successfully")
                .result(result)
                .timestamp(Instant.now().toString())
                .build());
    }

    @GetMapping("/problems")
    @PreAuthorize("hasAnyAuthority('OJ_PROBLEM_VIEW') and (@courseSecurity.canAccessLesson(#lessonId) or @courseSecurity.canManageLesson(#lessonId))")
    public ResponseEntity<ApiResponse<List<OjLessonProblemResponse>>> getLessonProblems(
            @AuthenticationPrincipal Jwt jwt,
            @RequestParam("lessonId") Long lessonId){

        Long userId = jwt.getClaim("userId");

        var result = onlineJudgeProblemService.getLessonProblems(lessonId, userId);

        return ResponseEntity.ok(ApiResponse.<List<OjLessonProblemResponse>>builder()
                .status(200)
                .code(1000)
                .message("Get online judge problem list successfully")
                .result(result)
                .timestamp(Instant.now().toString())
                .build());
    }

    @GetMapping("/problems/{problemId}")
    @PreAuthorize("hasAuthority('OJ_PROBLEM_VIEW') and @courseSecurity.canAccessProblem(#problemId)")
    public ResponseEntity<ApiResponse<OjProblemDetailResponse>> getProblemDetail(
            @AuthenticationPrincipal Jwt jwt,
            @PathVariable("problemId") Long problemId){

        Long userId = jwt.getClaim("userId");

        var result = onlineJudgeProblemService.getProblemDetail(problemId, userId);

        return ResponseEntity.ok(ApiResponse.<OjProblemDetailResponse>builder()
                .status(200)
                .code(1000)
                .message("Get online judge problem successfully")
                .result(result)
                .timestamp(Instant.now().toString())
                .build());
    }

    @PostMapping("/submissions")
    @PreAuthorize("hasAuthority('OJ_PROBLEM_SUBMIT') and @courseSecurity.canAccessProblem(#request.problemId)")
    public ResponseEntity<ApiResponse<OjSubmissionInitialResponse>> submitCode(
            @Valid @RequestBody OjSubmissionRequest request,
            @AuthenticationPrincipal Jwt jwt) {

        Long mockUserId = jwt.getClaim("userId");
        var result = ojSubmissionService.submitCode(request, mockUserId);

        return ResponseEntity.ok(ApiResponse.<OjSubmissionInitialResponse>builder()
                .status(200)
                .code(1000)
                .message("Submit problem successfully")
                .result(result)
                .timestamp(Instant.now().toString())
                .build());
    }

    @PutMapping("/submissions")
    public ResponseEntity<ApiResponse<Void>> processJudge0Callback(@RequestBody Judge0CallbackPayload payload) {
        log.info("➔ Nhận Webhook từ Judge0 cho token: {}, Trạng thái: {}",
                payload.getToken(),
                payload.getStatus() != null ? payload.getStatus().getDescription() : "UNKNOWN");

        ojSubmissionService.processJudge0Callback(payload);

        return ResponseEntity.ok(ApiResponse.<Void>builder()
                .status(204)
                .code(1000)
                .message("Judge0 callback processed successfully")
                .result(null)
                .timestamp(Instant.now().toString())
                .build());
    }

    @PostMapping("/problems/{problemId}/generate-testcases")
    @PreAuthorize("hasAuthority('PROBLEM_UPDATE')")
    public ResponseEntity<ApiResponse<Void>> generateTestcases(
            @PathVariable("problemId") Long problemId,
            @Valid @RequestBody GenerateTestcaseRequest request) {
        
        ojTestcaseGenerationService.generateTestcases(problemId, request);

        return ResponseEntity.status(202).body(ApiResponse.<Void>builder()
                .status(202)
                .code(1000)
                .message("Testcase generation started")
                .timestamp(Instant.now().toString())
                .build());
    }

    @PutMapping("/webhooks/generate-inputs")
    public ResponseEntity<Void> processInputWebhook(@RequestBody Judge0CallbackPayload payload) {
        log.info("➔ Nhận Input Webhook từ Judge0 cho token: {}", payload.getToken());
        ojTestcaseGenerationService.processInputWebhook(payload);
        return ResponseEntity.ok().build();
    }

    @PutMapping("/webhooks/generate-outputs")
    public ResponseEntity<Void> processOutputWebhook(@RequestBody Judge0CallbackPayload payload) {
        log.info("➔ Nhận Output Webhook từ Judge0 cho token: {}", payload.getToken());
        ojTestcaseGenerationService.processOutputWebhook(payload);
        return ResponseEntity.ok().build();
    }
}