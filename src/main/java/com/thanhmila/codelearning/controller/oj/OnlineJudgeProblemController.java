package com.thanhmila.codelearning.controller.oj;

import com.thanhmila.codelearning.dto.judge0.Judge0CallbackPayload;
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
import com.thanhmila.codelearning.dto.response.ApiResponse;
import com.thanhmila.codelearning.dto.response.OnlineJudgeProblemDetailResponse;
import com.thanhmila.codelearning.dto.response.OnlineJudgeProblemResponse;
import com.thanhmila.codelearning.service.oj.OnlineJudgeProblemService;

@Slf4j
@RestController
@RequiredArgsConstructor
@RequestMapping("/online-judge")
@FieldDefaults(level = AccessLevel.PRIVATE, makeFinal = true)
public class OnlineJudgeProblemController {
    
    OnlineJudgeProblemService onlineJudgeProblemService;
    OjSubmissionService ojSubmissionService;

    @GetMapping("/problems")
    @PreAuthorize("hasAnyAuthority('OJ_PROBLEM_VIEW', 'FILE_ASSIGNMENT_VIEW') and (@courseSecurity.canAccessLesson(#lessonId) or @courseSecurity.canManageLesson(#lessonId))")
    public ResponseEntity<ApiResponse<List<OnlineJudgeProblemResponse>>> getOnlineJudgeProblemList(
            @AuthenticationPrincipal Jwt jwt,
            @RequestParam("lessonId") Long lessonId){

        Long userId = jwt.getClaim("userId");

        var result = onlineJudgeProblemService.getOnlineJudgeProblemList(lessonId, userId);

        return ResponseEntity.ok(ApiResponse.<List<OnlineJudgeProblemResponse>>builder()
                .status(200)
                .code(1000)
                .message("Get online judge problem list successfully")
                .result(result)
                .timestamp(Instant.now().toString())
                .build());
    }

    @GetMapping("/problems/{problemId}")
    @PreAuthorize("hasAuthority('OJ_PROBLEM_VIEW') and @courseSecurity.canAccessProblem(#problemId)")
    public ResponseEntity<ApiResponse<OnlineJudgeProblemDetailResponse>> getOnlineJudgeProblemDetail(
            @AuthenticationPrincipal Jwt jwt,
            @PathVariable("problemId") Long problemId){

        Long userId = jwt.getClaim("userId");

        var result = onlineJudgeProblemService.getOnlineJudgeProblemDetail(problemId, userId);

        return ResponseEntity.ok(ApiResponse.<OnlineJudgeProblemDetailResponse>builder()
                .status(200)
                .code(1000)
                .message("Get online judge problem successfully")
                .result(result)
                .timestamp(Instant.now().toString())
                .build());
    }

    @PostMapping("/submissions")
    @PreAuthorize("hasAuthority('OJ_PROBLEM_SUBMIT') and " +
                "(@courseSecurity.canAccessProblem(#request.problemId) or @courseSecurity.canAccessContest(#request.problemId))")
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
}