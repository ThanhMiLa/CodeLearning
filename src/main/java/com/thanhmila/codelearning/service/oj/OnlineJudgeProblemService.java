package com.thanhmila.codelearning.service.oj;

import java.util.Arrays;
import java.util.List;
import java.util.stream.Collectors;

import com.thanhmila.codelearning.entity.enums.ProblemDifficulty;
import org.springframework.stereotype.Service;

import com.thanhmila.codelearning.dto.response.OnlineJudgeProblemDetailResponse;
import com.thanhmila.codelearning.dto.response.OnlineJudgeProblemResponse;
import com.thanhmila.codelearning.exception.AppException;
import com.thanhmila.codelearning.exception.ErrorCode;
import com.thanhmila.codelearning.repository.OnlineJudgeProblemRepository;
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
