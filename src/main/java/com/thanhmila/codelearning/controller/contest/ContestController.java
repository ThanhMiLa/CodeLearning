package com.thanhmila.codelearning.controller.contest;

import com.thanhmila.codelearning.dto.request.ContestCreateRequest;
import com.thanhmila.codelearning.dto.request.ContestUpdateRequest;
import com.thanhmila.codelearning.dto.request.AddContestProblemsRequest;
import com.thanhmila.codelearning.dto.request.ContestProblemReorderRequest;
import java.util.List;
import com.thanhmila.codelearning.dto.response.ApiResponse;
import com.thanhmila.codelearning.dto.response.ContestListResponse;
import com.thanhmila.codelearning.dto.response.ContestResponse;
import com.thanhmila.codelearning.dto.response.PageResponse;
import com.thanhmila.codelearning.service.contest.ContestService;
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

    @GetMapping
    public ResponseEntity<ApiResponse<PageResponse<ContestListResponse>>> getContests(
            @RequestParam(defaultValue = "0") int page,
            @RequestParam(defaultValue = "10") int size) {

        PageResponse<ContestListResponse> response = contestService.getContests(page, size);

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
}

