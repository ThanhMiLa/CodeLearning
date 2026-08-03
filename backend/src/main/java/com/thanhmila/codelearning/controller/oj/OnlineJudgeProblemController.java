package com.thanhmila.codelearning.controller.oj;

import com.thanhmila.codelearning.dto.judge0.Judge0CallbackPayload;
import com.thanhmila.codelearning.dto.request.GenerateTestcaseRequest;
import com.thanhmila.codelearning.dto.request.OjSubmissionRequest;
import com.thanhmila.codelearning.dto.response.OjSubmissionInitialResponse;
import com.thanhmila.codelearning.service.oj.OjSubmissionService;
import com.thanhmila.codelearning.service.oj.OjTestcaseGenerationService;
import jakarta.validation.Valid;
import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import lombok.experimental.NonFinal;
import lombok.extern.slf4j.Slf4j;
import java.time.Instant;
import java.util.List;

import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.core.parameters.P;
import org.springframework.security.oauth2.jwt.Jwt;
import org.springframework.web.bind.annotation.*;
import com.thanhmila.codelearning.dto.response.PageResponse;
import com.thanhmila.codelearning.dto.response.OjPracticeProblemResponse;
import com.thanhmila.codelearning.dto.response.OjAdminProblemResponse;
import com.thanhmila.codelearning.dto.response.ApiResponse;
import com.thanhmila.codelearning.dto.response.OjProblemDetailResponse;
import com.thanhmila.codelearning.dto.response.OjLessonProblemResponse;
import com.thanhmila.codelearning.service.oj.OnlineJudgeProblemService;

import com.thanhmila.codelearning.dto.request.ProblemSearchRequest;
import com.thanhmila.codelearning.dto.request.CreateOjProblemRequest;
import com.thanhmila.codelearning.dto.response.OjSubmissionHistoryResponse;
import com.thanhmila.codelearning.entity.enums.ProblemScope;
import com.thanhmila.codelearning.entity.enums.ProblemDifficulty;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;

@Slf4j
@RestController
@RequiredArgsConstructor
@RequestMapping("/online-judge")
@FieldDefaults(level = AccessLevel.PRIVATE, makeFinal = true)
public class OnlineJudgeProblemController {
    
    OnlineJudgeProblemService onlineJudgeProblemService;
    OjSubmissionService ojSubmissionService;
    OjTestcaseGenerationService ojTestcaseGenerationService;

    @NonFinal
    @Value("${app.webhook-secret}")
    String webhookSecret;

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
            @PathVariable("problemId") Long problemId,
            @RequestParam(value = "contestId", required = false) Long contestId){

        Long userId = jwt.getClaim("userId");

        var result = onlineJudgeProblemService.getProblemDetail(problemId, userId, contestId);

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
            @Valid @RequestBody @P("request") OjSubmissionRequest request,
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
    public ResponseEntity<ApiResponse<Void>> processJudge0Callback(@RequestParam(value = "secret",required = false) String secret, @RequestBody Judge0CallbackPayload payload) {
        

        log.info("➔ Nhận Webhook từ Judge0 cho token: {}, Trạng thái: {}",
                payload.getToken(),
                payload.getStatus() != null ? payload.getStatus().getDescription() : "UNKNOWN");
        
        if (secret == null || !secret.equals(webhookSecret)) {
            log.warn("🚨 CẢNH BÁO BẢO MẬT: Có người cố tình giả mạo Webhook không có Secret hợp lệ!");
            return ResponseEntity.status(401).body(ApiResponse.<Void>builder()
                    .status(401)
                    .code(1000)
                    .message("Invalid webhook secret")
                    .result(null)
                    .timestamp(Instant.now().toString())
                    .build());
        }

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
    public ResponseEntity<ApiResponse<Void>> processInputWebhook(
            @RequestParam(value = "secret", required = false) String secret,
            @RequestBody Judge0CallbackPayload payload) {

        if (secret == null || !webhookSecret.equals(secret)) {
            log.warn("🚨 CẢNH BÁO BẢO MẬT: Webhook generate-inputs không có Secret hợp lệ!");
            return ResponseEntity.status(401).body(ApiResponse.<Void>builder()
                    .status(401)
                    .code(1000)
                    .message("Invalid webhook secret")
                    .result(null)
                    .timestamp(Instant.now().toString())
                    .build());
        }

        log.info("➔ Nhận Input Webhook từ Judge0 cho token: {}", payload.getToken());
        ojTestcaseGenerationService.processInputWebhook(payload);

        return ResponseEntity.ok(ApiResponse.<Void>builder()
                .status(200)
                .code(1000)
                .message("Process input webhook successfully")
                .result(null)
                .timestamp(Instant.now().toString())
                .build());
    }

    @PutMapping("/webhooks/generate-outputs")
    public ResponseEntity<ApiResponse<Void>> processOutputWebhook(
            @RequestParam(value = "secret", required = false) String secret,
            @RequestBody Judge0CallbackPayload payload) {

        if (secret == null || !webhookSecret.equals(secret)) {
            log.warn("🚨 CẢNH BÁO BẢO MẬT: Webhook generate-outputs không có Secret hợp lệ!");
            return ResponseEntity.status(401).body(ApiResponse.<Void>builder()
                    .status(401)
                    .code(1000)
                    .message("Invalid webhook secret")
                    .result(null)
                    .timestamp(Instant.now().toString())
                    .build());
        }

        log.info("➔ Nhận Output Webhook từ Judge0 cho token: {}", payload.getToken());
        ojTestcaseGenerationService.processOutputWebhook(payload);

        return ResponseEntity.ok(ApiResponse.<Void>builder()
                .status(200)
                .code(1000)
                .message("Process output webhook successfully")
                .result(null)
                .timestamp(Instant.now().toString())
                .build());
    }

    @PostMapping("/admin/problems")
    @PreAuthorize("hasAuthority('OJ_PROBLEM_CREATE')")
    public ResponseEntity<ApiResponse<Long>> createProblemInBank(
            @AuthenticationPrincipal Jwt jwt,
            @Valid @RequestBody CreateOjProblemRequest request) {

        Long userId = jwt.getClaim("userId");
        Long problemId = onlineJudgeProblemService.createProblemInBank(request, userId);

        return ResponseEntity.ok(ApiResponse.<Long>builder()
                .status(200)
                .code(1000)
                .message("Create problem in bank successfully")
                .result(problemId)
                .timestamp(Instant.now().toString())
                .build());
    }

    @GetMapping("/problems/{problemId}/submissions")
    @PreAuthorize("isAuthenticated()")
    public ResponseEntity<ApiResponse<PageResponse<OjSubmissionHistoryResponse>>> getProblemSubmissions(
            @PathVariable("problemId") Long problemId,
            @RequestParam(defaultValue = "0") int page,
            @RequestParam(defaultValue = "10") int size,
            @AuthenticationPrincipal Jwt jwt) {

        Long userId = jwt.getClaim("userId");
        Pageable pageable = PageRequest.of(page, size);
        PageResponse<OjSubmissionHistoryResponse> result = ojSubmissionService.getProblemSubmissions(problemId, userId, pageable);

        return ResponseEntity.ok(ApiResponse.<PageResponse<OjSubmissionHistoryResponse>>builder()
                .status(200)
                .code(1000)
                .message("Get problem submissions successfully")
                .result(result)
                .timestamp(Instant.now().toString())
                .build());
    }

    @GetMapping("/admin/problems")
    @PreAuthorize("hasAuthority('OJ_PROBLEM_ADMIN')")
    public ResponseEntity<ApiResponse<PageResponse<OjAdminProblemResponse>>> getAdminProblems(
            @RequestParam(name = "page", defaultValue = "0") int page,
            @RequestParam(name = "size", defaultValue = "20") int size,
            @RequestParam(name = "scope", required = false) ProblemScope scope,
            @RequestParam(name = "isPublic", required = false) Boolean isPublic,
            @RequestParam(name = "difficulty", required = false) ProblemDifficulty difficulty) {
        
        var result = onlineJudgeProblemService.getAdminProblems(page, size, scope, isPublic, difficulty);

        return ResponseEntity.ok(ApiResponse.<PageResponse<OjAdminProblemResponse>>builder()
                .status(200)
                .code(1000)
                .message("Get admin problems successfully")
                .result(result)
                .timestamp(Instant.now().toString())
                .build());
    }

    @PutMapping("/admin/problems/{problemId}/public")
    @PreAuthorize("hasAuthority('OJ_PROBLEM_ADMIN')")
    public ResponseEntity<ApiResponse<Void>> updateProblemVisibility(
            @PathVariable("problemId") Long problemId,
            @RequestParam("isPublic") Boolean isPublic) {
        
        onlineJudgeProblemService.updateProblemVisibility(problemId, isPublic);

        return ResponseEntity.ok(ApiResponse.<Void>builder()
                .status(200)
                .code(1000)
                .message("Update problem visibility successfully")
                .result(null)
                .timestamp(Instant.now().toString())
                .build());
    }
}