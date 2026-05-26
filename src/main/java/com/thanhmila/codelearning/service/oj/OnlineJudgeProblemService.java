package com.thanhmila.codelearning.service.oj;

import java.util.Arrays;
import java.util.List;
import java.util.stream.Collectors;
import org.springframework.data.domain.Page;
import com.thanhmila.codelearning.dto.response.PageResponse;
import com.thanhmila.codelearning.dto.response.OnlineJudgePracticeProblemResponse;
import com.thanhmila.codelearning.repository.projection.OjPracticeProblemProjection;
import com.thanhmila.codelearning.entity.enums.ProblemDifficulty;
import com.thanhmila.codelearning.repository.oj.OnlineJudgeProblemRepository;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;
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
import org.springframework.data.jpa.domain.Specification;
import com.thanhmila.codelearning.dto.request.ProblemSearchRequest;
import com.thanhmila.codelearning.repository.specification.ProblemSpecification;
import com.thanhmila.codelearning.entity.oj.OnlineJudgeProblemEntity;
import com.thanhmila.codelearning.repository.oj.OnlineJudgeSubmissionRepository;
import java.util.Set;
import java.util.HashSet;

@Slf4j
@Service
@RequiredArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE, makeFinal = true)
public class OnlineJudgeProblemService {
    OnlineJudgeProblemRepository onlineJudgeProblemRepository;
    OnlineJudgeSubmissionRepository onlineJudgeSubmissionRepository;


    public PageResponse<OnlineJudgePracticeProblemResponse> getPracticeProblems(ProblemSearchRequest request, Long userId) {
        Specification<OnlineJudgeProblemEntity> spec = Specification.where(ProblemSpecification.isPublicAndActive());

        if (StringUtils.hasText(request.getKeyword())) {
            spec = spec.and(ProblemSpecification.hasKeyword(request.getKeyword()));
        }
        if (request.getTagIds() != null && !request.getTagIds().isEmpty()) {
            spec = spec.and(ProblemSpecification.hasTags(request.getTagIds()));
        }
        if (request.getDifficulties() != null && !request.getDifficulties().isEmpty()) {
            spec = spec.and(ProblemSpecification.hasDifficulties(request.getDifficulties()));
        }
        if (request.getIsAccepted() != null && userId != null) {
            spec = spec.and(ProblemSpecification.hasUserAccepted(request.getIsAccepted(), userId));
        }

        Page<OnlineJudgeProblemEntity> problemPage = onlineJudgeProblemRepository.findAll(spec, request.getPageable());

        List<Long> problemIds = problemPage.getContent().stream()
                .map(OnlineJudgeProblemEntity::getId)
                .collect(Collectors.toList());

        Set<Long> acceptedProblemIds = new HashSet<>();
        if (userId != null && !problemIds.isEmpty()) {
            acceptedProblemIds = onlineJudgeSubmissionRepository.findProblemIdsByUserIdAndProblemIdsAndVerdict(
                    userId, problemIds, com.thanhmila.codelearning.entity.enums.OjVerdict.ACCEPTED);
        }

        final Set<Long> finalAcceptedProblemIds = acceptedProblemIds;

        List<OnlineJudgePracticeProblemResponse> content = problemPage.getContent().stream()
                .map(entity -> {
                    Double acceptanceRate = entity.getAcceptanceRate() != null ? entity.getAcceptanceRate() : 0.0;
                    acceptanceRate = Math.round(acceptanceRate * 100.0) / 100.0;

                    return OnlineJudgePracticeProblemResponse.builder()
                            .id(entity.getId())
                            .title(entity.getTitle())
                            .difficulty(entity.getDifficulty())
                            .isAccepted(finalAcceptedProblemIds.contains(entity.getId()))
                            .totalSubmissions(entity.getTotalSubmissions())
                            .totalAccepted(entity.getTotalAccepted())
                            .acceptanceRate(acceptanceRate)
                            .build();
                })
                .collect(Collectors.toList());

        return PageResponse.<OnlineJudgePracticeProblemResponse>builder()
                .page(problemPage.getNumber())
                .size(problemPage.getSize())
                .numberOfElements(problemPage.getNumberOfElements())
                .totalElements(problemPage.getTotalElements())
                .totalPages(problemPage.getTotalPages())
                .first(problemPage.isFirst())
                .last(problemPage.isLast())
                .content(content)
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
