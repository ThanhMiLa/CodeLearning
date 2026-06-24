package com.thanhmila.codelearning.dto.response;

import lombok.Builder;
import lombok.Getter;
import java.util.List;

@Getter
@Builder
public class ContestLeaderboardItemResponse {
    private Long userId;
    private String displayName;
    private Integer problemsSolved;
    private Integer totalPenalty;
    private Integer rank; // optional, to be populated by service
    private List<ContestProblemStatusResponse> problemStatuses;
}
