package com.thanhmila.codelearning.controller.course;

import com.thanhmila.codelearning.dto.request.ChapterCreationRequest;
import com.thanhmila.codelearning.dto.request.ChapterReorderRequest;
import com.thanhmila.codelearning.dto.request.ChapterUpdateRequest;
import com.thanhmila.codelearning.dto.response.ApiResponse;
import com.thanhmila.codelearning.dto.response.ChapterResponse;
import com.thanhmila.codelearning.service.course.ChapterService;
import jakarta.validation.Valid;
import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

import java.time.Instant;
import java.util.List;

@Slf4j
@RestController
@RequiredArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE, makeFinal = true)
public class ChapterController {

    ChapterService chapterService;

    @PostMapping("/courses/{courseId}/chapters")
    @PreAuthorize("hasAuthority('CHAPTER_CREATE') and @courseSecurity.canManageCourse(#courseId)")
    public ResponseEntity<ApiResponse<ChapterResponse>> createChapter(
            @PathVariable("courseId") Long courseId,
            @Valid @RequestBody ChapterCreationRequest request) {

        var result = chapterService.createChapter(courseId, request);

        return ResponseEntity.ok(ApiResponse.<ChapterResponse>builder()
                .status(200)
                .code(1000)
                .message("Create chapter successfully")
                .result(result)
                .timestamp(Instant.now().toString())
                .build());
    }

    @PutMapping("/chapters/{chapterId}")
    @PreAuthorize("hasAuthority('CHAPTER_UPDATE') and @courseSecurity.canManageChapter(#chapterId)")
    public ResponseEntity<ApiResponse<ChapterResponse>> updateChapterTitle(
            @PathVariable("chapterId") Long chapterId,
            @Valid @RequestBody ChapterUpdateRequest request) {

        var result = chapterService.updateChapterTitle(chapterId, request);

        return ResponseEntity.ok(ApiResponse.<ChapterResponse>builder()
                .status(200)
                .code(1000)
                .message("Update chapter title successfully")
                .result(result)
                .timestamp(Instant.now().toString())
                .build());
    }

    @DeleteMapping("/chapters/{chapterId}")
    @PreAuthorize("hasAuthority('CHAPTER_DELETE') and @courseSecurity.canManageChapter(#chapterId)")
    public ResponseEntity<ApiResponse<Void>> deleteChapter(
            @PathVariable("chapterId") Long chapterId) {

        chapterService.deleteChapter(chapterId);

        return ResponseEntity.ok(ApiResponse.<Void>builder()
                .status(200)
                .code(1000)
                .message("Delete chapter successfully")
                .timestamp(Instant.now().toString())
                .build());
    }

    @PutMapping("/courses/{courseId}/chapters/reorder")
    @PreAuthorize("hasAuthority('CHAPTER_UPDATE') and @courseSecurity.canManageCourse(#courseId)")
    public ResponseEntity<ApiResponse<Void>> reorderChapters(
            @PathVariable("courseId") Long courseId,
            @Valid @RequestBody List<ChapterReorderRequest> requests) {

        chapterService.reorderChapters(courseId, requests);

        return ResponseEntity.ok(ApiResponse.<Void>builder()
                .status(200)
                .code(1000)
                .message("Reorder chapters successfully")
                .timestamp(Instant.now().toString())
                .build());
    }
}
