package com.thanhmila.codelearning.dto.response;

import lombok.Builder;
import lombok.Getter;

import java.time.ZonedDateTime;
import java.util.List;

@Getter
@Builder
public class ContestLeaderboardResponse {
    private Long contestId;
    private String title;
    private ZonedDateTime startTime;
    private ZonedDateTime endTime;
    private String status;
    private List<ContestLeaderboardItemResponse> leaderboard;
}
