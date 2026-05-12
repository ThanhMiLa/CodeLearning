package com.thanhmila.codelearning.controller.oj;

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
}