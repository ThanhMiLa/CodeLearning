package com.thanhmila.codelearning.dto.response;

import lombok.Builder;
import lombok.Getter;

import java.util.List;

@Getter
@Builder
public class ContestLeaderboardResponse {
    private Long contestId;
    private List<ContestLeaderboardItemResponse> leaderboard;
}
