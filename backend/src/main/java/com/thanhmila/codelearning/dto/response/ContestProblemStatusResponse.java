package com.thanhmila.codelearning.dto.response;

import lombok.Builder;
import lombok.Getter;

@Getter
@Builder
public class ContestProblemStatusResponse {
    private Long problemId;
    private Boolean isSolved;
    private Integer failedAttemptsCount;
    private Integer solvedAtSeconds;
}
