package com.thanhmila.codelearning.service.oj;

import java.util.List;
import java.util.stream.Collectors;

import org.springframework.stereotype.Service;

import com.thanhmila.codelearning.dto.response.OnlineJudgeProblemResponse;
import com.thanhmila.codelearning.repository.OnlineJudgeProblemRepository;
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



    private OnlineJudgeProblemResponse mapToOnlineJudgeProblemResponse(OjProblemListProjection ojProblem) {
        return OnlineJudgeProblemResponse.builder()
                .id(ojProblem.getId())
                .title(ojProblem.getTitle())
                .difficulty(ojProblem.getDifficulty())
                .isAccepted(ojProblem.getIsAccepted())
                .build();
    }
}
