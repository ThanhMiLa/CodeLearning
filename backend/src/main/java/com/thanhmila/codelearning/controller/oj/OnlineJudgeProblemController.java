package com.thanhmila.codelearning.controller.oj;

import com.thanhmila.codelearning.dto.request.OjAdminSubmissionSearchRequest;
import com.thanhmila.codelearning.dto.response.*;
import com.thanhmila.codelearning.service.oj.OjSubmissionService;
import org.springframework.data.domain.*;


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
import com.thanhmila.codelearning.service.oj.OnlineJudgeProblemService;

import com.thanhmila.codelearning.dto.request.ProblemSearchRequest;
import com.thanhmila.codelearning.dto.request.CreateOjProblemRequest;
import com.thanhmila.codelearning.entity.enums.ProblemScope;
import com.thanhmila.codelearning.entity.enums.ProblemDifficulty;

@Slf4j
@RestController
@RequiredArgsConstructor
@RequestMapping("/online-judge")
@FieldDefaults(level = AccessLevel.PRIVATE, makeFinal = true)
public class OnlineJudgeProblemController {
    
    OnlineJudgeProblemService onlineJudgeProblemService;
    OjSubmissionService ojSubmissionService;
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

    @GetMapping("/admin/submissions")
    @PreAuthorize("hasAuthority('OJ_PROBLEM_ADMIN')")
    public ResponseEntity<ApiResponse<PageResponse<OjAdminSubmissionResponse>>> getAdminSubmissions(
            @ModelAttribute OjAdminSubmissionSearchRequest searchRequest,
            @RequestParam(name = "page", defaultValue = "0") int page,
            @RequestParam(name = "size", defaultValue = "20") int size,
            @RequestParam(name = "sortBy", defaultValue = "submittedAt") String sortBy,
            @RequestParam(name = "sortDir", defaultValue = "desc") String sortDir) {

        Sort sort = sortDir.equalsIgnoreCase("asc")
                ? Sort.by(sortBy).ascending()
                : Sort.by(sortBy).descending();
        Pageable pageable = PageRequest.of(page, size, sort);

        var result = onlineJudgeProblemService.getGlobalAdminSubmissions(searchRequest, pageable);

        return ResponseEntity.ok(ApiResponse.<PageResponse<OjAdminSubmissionResponse>>builder()
                .status(200)
                .code(1000)
                .message("Get global admin submissions successfully")
                .result(result)
                .timestamp(Instant.now().toString())
                .build());
    }
}