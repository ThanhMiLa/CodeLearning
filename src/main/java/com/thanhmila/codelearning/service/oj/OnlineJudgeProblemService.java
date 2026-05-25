package com.thanhmila.codelearning.service.oj;

import java.util.Arrays;
import java.util.List;
import java.util.stream.Collectors;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import com.thanhmila.codelearning.dto.response.PageResponse;
import com.thanhmila.codelearning.dto.response.OnlineJudgePracticeProblemResponse;
import com.thanhmila.codelearning.repository.projection.OjPracticeProblemProjection;
import com.thanhmila.codelearning.entity.enums.ProblemDifficulty;
import com.thanhmila.codelearning.repository.oj.OnlineJudgeProblemRepository;
import org.springframework.stereotype.Service;
import com.thanhmila.codelearning.dto.response.OnlineJudgeProblemDetailResponse;
import com.thanhmila.codelearning.dto.response.OnlineJudgeProblemResponse;
import com.thanhmila.codelearning.exception.AppException;
import com.thanhmila.codelearning.exception.ErrorCode;
import com.thanhmila.codelearning.repository.projection.OjProblemDetailProjection;
import com.thanhmila.codelearning.repository.projection.OjProblemListProjection;
import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
@RequiredArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE, makeFinal = true)
public class OnlineJudgeProblemService {
    OnlineJudgeProblemRepository onlineJudgeProblemRepository;


    public PageResponse<OnlineJudgePracticeProblemResponse> getPracticeProblems(Long userId, Pageable pageable) {
        Page<OjPracticeProblemProjection> pageData = onlineJudgeProblemRepository.findPracticeProblems(userId, pageable);
        
        List<OnlineJudgePracticeProblemResponse> content = pageData.getContent().stream()
                .map(this::mapToOnlineJudgePracticeProblemResponse)
                .collect(Collectors.toList());
                
        return PageResponse.<OnlineJudgePracticeProblemResponse>builder()
                .page(pageData.getNumber())
                .size(pageData.getSize())
                .numberOfElements(pageData.getNumberOfElements())
                .totalElements(pageData.getTotalElements())
                .totalPages(pageData.getTotalPages())
                .first(pageData.isFirst())
                .last(pageData.isLast())
                .content(content)
                .build();
    }

    private OnlineJudgePracticeProblemResponse mapToOnlineJudgePracticeProblemResponse(OjPracticeProblemProjection projection) {
        double acceptanceRate = 0.0;
        if (projection.getTotalSubmissions() != null && projection.getTotalSubmissions() > 0) {
            acceptanceRate = ((double) projection.getTotalAccepted() / projection.getTotalSubmissions()) * 100.0;
            acceptanceRate = Math.round(acceptanceRate * 100.0) / 100.0;
        }

        return OnlineJudgePracticeProblemResponse.builder()
                .id(projection.getId())
                .title(projection.getTitle())
                .difficulty(ProblemDifficulty.valueOf(projection.getDifficulty()))
                .isAccepted(projection.getIsAccepted())
                .totalSubmissions(projection.getTotalSubmissions())
                .totalAccepted(projection.getTotalAccepted())
                .acceptanceRate(acceptanceRate)
                .build();
    }

    public List<OnlineJudgeProblemResponse> getOnlineJudgeProblemList(Long lessonId, Long userId) {
        List<OjProblemListProjection> ojProblemList = onlineJudgeProblemRepository.findProblemsByLessonWithStatus(lessonId, userId);
        return ojProblemList.stream()
                .map(this::mapToOnlineJudgeProblemResponse)
                .collect(Collectors.toList());
    }


    public OnlineJudgeProblemDetailResponse getOnlineJudgeProblemDetail(Long problemId, Long userId) {
        OjProblemDetailProjection ojProblemDetail = onlineJudgeProblemRepository.findProblemDetailWithStatus(problemId, userId)
                    .orElseThrow(() -> new AppException(ErrorCode.OJ_PROBLEM_NOT_FOUND));

        return mapToOnlineJudgeProblemDetailResponse(ojProblemDetail);       
    }

    private OnlineJudgeProblemDetailResponse mapToOnlineJudgeProblemDetailResponse(OjProblemDetailProjection ojProblem) {
        List<String> tags = ojProblem.getTagsRaw() != null
                ? Arrays.stream(ojProblem.getTagsRaw().split(",")).collect(Collectors.toList())
                : List.of();

        return OnlineJudgeProblemDetailResponse.builder()
                .id(ojProblem.getId())
                .title(ojProblem.getTitle())
                .description(ojProblem.getDescription())
                .inputDescription(ojProblem.getInputDescription())
                .outputDescription(ojProblem.getOutputDescription())
                .constraints(ojProblem.getConstraints())
                .exampleInput(ojProblem.getExampleInput())
                .exampleOutput(ojProblem.getExampleOutput())
                .hint(ojProblem.getHint())
                .tags(tags)
                .difficulty(ProblemDifficulty.valueOf(ojProblem.getDifficulty()))
                .latestSourceCode(ojProblem.getLatestSourceCode())
                .isAccepted(ojProblem.getIsAccepted())
                .build();
    }


    private OnlineJudgeProblemResponse mapToOnlineJudgeProblemResponse(OjProblemListProjection ojProblem) {
        return OnlineJudgeProblemResponse.builder()
                .id(ojProblem.getId())
                .title(ojProblem.getTitle())
                .difficulty(ProblemDifficulty.valueOf(ojProblem.getDifficulty()))
                .isAccepted(ojProblem.getIsAccepted())
                .build();
    }
}
