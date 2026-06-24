package com.thanhmila.codelearning.controller.contest;

import com.thanhmila.codelearning.dto.request.ContestCreateRequest;
import com.thanhmila.codelearning.dto.request.ContestUpdateRequest;
import com.thanhmila.codelearning.dto.request.AddContestProblemsRequest;
import com.thanhmila.codelearning.dto.request.ContestProblemReorderRequest;
import com.thanhmila.codelearning.dto.request.ContestRegisterRequest;
import java.util.List;
import com.thanhmila.codelearning.dto.response.ApiResponse;
import com.thanhmila.codelearning.dto.response.ContestListResponse;
import com.thanhmila.codelearning.dto.response.ContestResponse;
import com.thanhmila.codelearning.dto.response.OjContestProblemResponse;
import com.thanhmila.codelearning.dto.response.PageResponse;
import com.thanhmila.codelearning.dto.response.ContestLeaderboardResponse;
import com.thanhmila.codelearning.service.contest.ContestLeaderboardService;
import com.thanhmila.codelearning.service.contest.ContestService;
import com.thanhmila.codelearning.service.oj.OjSubmissionService;
import com.thanhmila.codelearning.dto.response.OjContestSubmissionResponse;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import jakarta.validation.Valid;
import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.oauth2.jwt.Jwt;
import org.springframework.web.bind.annotation.*;

import java.time.Instant;

@RestController
@RequestMapping("/contests")
@RequiredArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE, makeFinal = true)
public class ContestController {

    ContestService contestService;
    ContestLeaderboardService contestLeaderboardService;
    OjSubmissionService ojSubmissionService;

    @GetMapping
    public ResponseEntity<ApiResponse<PageResponse<ContestListResponse>>> getContests(
            @RequestParam(defaultValue = "0") int page,
            @RequestParam(defaultValue = "10") int size,
            @AuthenticationPrincipal Jwt jwt) {

        Long userId = jwt != null ? jwt.getClaim("userId") : null;
        PageResponse<ContestListResponse> response = contestService.getContests(page, size, userId);

        return ResponseEntity.ok(ApiResponse.<PageResponse<ContestListResponse>>builder()
                .status(200)
                .code(200)
                .message("Fetched contests successfully")
                .result(response)
                .timestamp(Instant.now().toString())
                .build());
    }

    @PostMapping
    @PreAuthorize("hasAuthority('CONTEST_CREATE')")
    public ResponseEntity<ApiResponse<ContestResponse>> createContest(
            @Valid @RequestBody ContestCreateRequest request,
            @AuthenticationPrincipal Jwt jwt) {
        
        Long userId = jwt.getClaim("userId");
        
        ContestResponse response = contestService.createContest(request, userId);
        
        return ResponseEntity.ok(ApiResponse.<ContestResponse>builder()
                .status(200)
                .code(200)
                .message("Contest created successfully")
                .result(response)
                .timestamp(Instant.now().toString())
                .build());
    }

    @PutMapping("/{id}")
    @PreAuthorize("hasAuthority('CONTEST_UPDATE_OWN')")
    public ResponseEntity<ApiResponse<ContestResponse>> updateContest(
            @PathVariable Long id,
            @Valid @RequestBody ContestUpdateRequest request,
            @AuthenticationPrincipal Jwt jwt) {
        
        Long userId = jwt.getClaim("userId");
        
        ContestResponse response = contestService.updateContest(id, request, userId);
        
        return ResponseEntity.ok(ApiResponse.<ContestResponse>builder()
                .status(200)
                .code(200)
                .message("Contest updated successfully")
                .result(response)
                .timestamp(Instant.now().toString())
                .build());
    }

    @PostMapping("/{id}/problems")
    @PreAuthorize("hasAuthority('CONTEST_PROBLEM_ADD_OWN')")
    public ResponseEntity<ApiResponse<Void>> addProblemsToContest(
            @PathVariable Long id,
            @Valid @RequestBody AddContestProblemsRequest request,
            @AuthenticationPrincipal Jwt jwt) {

        Long userId = jwt.getClaim("userId");

        contestService.addProblemsToContest(id, request, userId);

        return ResponseEntity.ok(ApiResponse.<Void>builder()
                .status(200)
                .code(200)
                .message("Problems added to contest successfully")
                .result(null)
                .timestamp(Instant.now().toString())
                .build());
    }

    @PutMapping("/{id}/problems/reorder")
    @PreAuthorize("hasAuthority('CONTEST_UPDATE_OWN')")
    public ResponseEntity<ApiResponse<Void>> reorderContestProblems(
            @PathVariable Long id,
            @Valid @RequestBody List<ContestProblemReorderRequest> request,
            @AuthenticationPrincipal Jwt jwt) {

        Long userId = jwt.getClaim("userId");

        contestService.reorderContestProblems(id, request, userId);

        return ResponseEntity.ok(ApiResponse.<Void>builder()
                .status(200)
                .code(200)
                .message("Contest problems reordered successfully")
                .result(null)
                .timestamp(Instant.now().toString())
                .build());
    }

    @DeleteMapping("/{id}/problems/{problemId}")
    @PreAuthorize("hasAuthority('CONTEST_PROBLEM_REMOVE_OWN')")
    public ResponseEntity<ApiResponse<Void>> deleteProblemFromContest(
            @PathVariable Long id,
            @PathVariable Long problemId,
            @AuthenticationPrincipal Jwt jwt) {

        Long userId = jwt.getClaim("userId");

        contestService.deleteProblemFromContest(id, problemId, userId);

        return ResponseEntity.ok(ApiResponse.<Void>builder()
                .status(200)
                .code(200)
                .message("Problem removed from contest successfully")
                .result(null)
                .timestamp(Instant.now().toString())
                .build());
    }

    @GetMapping("/{id}/leaderboard")
    public ResponseEntity<ApiResponse<ContestLeaderboardResponse>> getLeaderboard(
            @PathVariable Long id) {
        
        ContestLeaderboardResponse response = contestLeaderboardService.getLeaderboard(id);

        return ResponseEntity.ok(ApiResponse.<ContestLeaderboardResponse>builder()
                .status(200)
                .code(200)
                .message("Fetched leaderboard successfully")
                .result(response)
                .timestamp(Instant.now().toString())
                .build());
    }

    @PostMapping("/{id}/register")
    @PreAuthorize("isAuthenticated()")
    public ResponseEntity<ApiResponse<Void>> registerContest(
            @PathVariable Long id,
            @RequestBody(required = false) ContestRegisterRequest request,
            @AuthenticationPrincipal Jwt jwt) {

        Long userId = jwt.getClaim("userId");

        if (request == null) {
            request = new ContestRegisterRequest();
        }

        contestService.registerContest(id, request, userId);

        return ResponseEntity.ok(ApiResponse.<Void>builder()
                .status(200)
                .code(200)
                .message("Registered for contest successfully")
                .result(null)
                .timestamp(Instant.now().toString())
                .build());
    }

    @GetMapping("/{id}")
    @PreAuthorize("isAuthenticated()")
    public ResponseEntity<ApiResponse<ContestResponse>> getContestById(
            @PathVariable Long id,
            @AuthenticationPrincipal Jwt jwt) {
        
        Long userId = jwt.getClaim("userId");
        ContestResponse response = contestService.getContestById(id, userId);

        return ResponseEntity.ok(ApiResponse.<ContestResponse>builder()
                .status(200)
                .code(200)
                .message("Fetched contest details successfully")
                .result(response)
                .timestamp(Instant.now().toString())
                .build());
    }

    @GetMapping("/{id}/problems")
    @PreAuthorize("isAuthenticated()")
    public ResponseEntity<ApiResponse<List<OjContestProblemResponse>>> getContestProblems(
            @PathVariable Long id,
            @AuthenticationPrincipal Jwt jwt) {

        Long userId = jwt.getClaim("userId");
        List<OjContestProblemResponse> response = contestService.getContestProblems(id, userId);

        return ResponseEntity.ok(ApiResponse.<List<OjContestProblemResponse>>builder()
                .status(200)
                .code(200)
                .message("Fetched contest problems successfully")
                .result(response)
                .timestamp(Instant.now().toString())
                .build());
    }

    @GetMapping("/{id}/submissions")
    @PreAuthorize("isAuthenticated()")
    public ResponseEntity<ApiResponse<PageResponse<OjContestSubmissionResponse>>> getContestSubmissions(
            @PathVariable("id") Long contestId,
            @RequestParam(defaultValue = "0") int page,
            @RequestParam(defaultValue = "10") int size,
            @AuthenticationPrincipal Jwt jwt) {

        Long userId = jwt.getClaim("userId");
        Pageable pageable = PageRequest.of(page, size);
        PageResponse<OjContestSubmissionResponse> response = ojSubmissionService.getContestSubmissions(contestId, userId, pageable);

        return ResponseEntity.ok(ApiResponse.<PageResponse<OjContestSubmissionResponse>>builder()
                .status(200)
                .code(200)
                .message("Fetched contest submissions successfully")
                .result(response)
                .timestamp(Instant.now().toString())
                .build());
    }
}

