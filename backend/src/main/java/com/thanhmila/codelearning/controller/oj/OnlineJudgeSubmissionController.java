package com.thanhmila.codelearning.controller.oj;

import com.thanhmila.codelearning.dto.judge0.Judge0CallbackPayload;
import com.thanhmila.codelearning.dto.request.GenerateTestcaseRequest;
import com.thanhmila.codelearning.dto.request.OjSubmissionRequest;
import com.thanhmila.codelearning.dto.response.ApiResponse;
import com.thanhmila.codelearning.dto.response.OjSubmissionInitialResponse;
import com.thanhmila.codelearning.service.oj.OjSubmissionService;
import com.thanhmila.codelearning.service.oj.OjTestcaseGenerationService;
import jakarta.validation.Valid;
import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import lombok.experimental.NonFinal;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;

import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.core.parameters.P;
import org.springframework.security.oauth2.jwt.Jwt;
import org.springframework.web.bind.annotation.*;

import java.time.Instant;

@Slf4j
@RestController
@RequiredArgsConstructor
@RequestMapping("/online-judge")
@FieldDefaults(level = AccessLevel.PRIVATE, makeFinal = true)
public class OnlineJudgeSubmissionController {

    OjSubmissionService ojSubmissionService;
    OjTestcaseGenerationService ojTestcaseGenerationService;

    @NonFinal
    @Value("${app.webhook-secret}")
    String webhookSecret;

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


}
