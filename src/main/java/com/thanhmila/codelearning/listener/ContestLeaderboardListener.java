package com.thanhmila.codelearning.listener;

import com.thanhmila.codelearning.event.SubmissionCompletedEvent;
import com.thanhmila.codelearning.event.ContestStartedEvent;
import com.thanhmila.codelearning.service.contest.ContestLeaderboardService;
import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import lombok.extern.slf4j.Slf4j;
import org.springframework.context.event.EventListener;
import org.springframework.scheduling.annotation.Async;
import org.springframework.stereotype.Component;

@Slf4j
@Component
@RequiredArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE, makeFinal = true)
public class ContestLeaderboardListener {

    ContestLeaderboardService leaderboardService;

    @Async
    @EventListener
    public void onSubmissionCompleted(SubmissionCompletedEvent event) {
        if (event.isContestMode()) {
            log.info("Bắt đầu xử lý cập nhật ICPC Leaderboard cho Contest {}, User {}, Bài {}", 
                     event.getContestId(), event.getUserId(), event.getProblemId());
            try {
                leaderboardService.processIpcpLeaderboard(
                        event.getContestId(),
                        event.getUserId(),
                        event.getProblemId(),
                        event.getVerdict(),
                        event.getSubmitTime()
                );
            } catch (Exception e) {
                log.error("Error processing ICPC leaderboard for submission: {}", event.getSubmissionId(), e);
            }
        }
    }

    @Async
    @EventListener
    public void handleContestStartedEvent(ContestStartedEvent event) {
        log.info("Received ContestStartedEvent for contest {}. Initializing leaderboard...", event.getContestId());
        try {
            leaderboardService.initializeLeaderboardForContest(event.getContestId());
        } catch (Exception e) {
            log.error("Error initializing leaderboard for contest: {}", event.getContestId(), e);
        }
    }
}
