package com.thanhmila.codelearning.listener;

import com.thanhmila.codelearning.entity.enums.OjVerdict;
import com.thanhmila.codelearning.event.SubmissionCompletedEvent;
import com.thanhmila.codelearning.service.contest.ContestLeaderboardService;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;

import java.time.ZonedDateTime;

import static org.mockito.Mockito.*;

@ExtendWith(MockitoExtension.class)
@DisplayName("ContestLeaderboardListener Unit Tests")
class ContestLeaderboardListenerTest {

    @Mock
    private ContestLeaderboardService leaderboardService;

    @InjectMocks
    private ContestLeaderboardListener listener;

    @Test
    @DisplayName("onSubmissionCompleted: Khi là contest mode, gọi processIpcpLeaderboard")
    void onSubmissionCompleted_ContestMode_CallsService() {
        ZonedDateTime now = ZonedDateTime.now();
        SubmissionCompletedEvent event = SubmissionCompletedEvent.builder()
                .submissionId(100L)
                .contestId(5L)
                .userId(1L)
                .problemId(20L)
                .verdict(OjVerdict.ACCEPTED)
                .submitTime(now)
                .build();

        listener.onSubmissionCompleted(event);

        verify(leaderboardService, times(1)).processIpcpLeaderboard(5L, 1L, 20L, OjVerdict.ACCEPTED, now);
    }

    @Test
    @DisplayName("onSubmissionCompleted: Khi không phải contest mode, bỏ qua không gọi service")
    void onSubmissionCompleted_PracticeMode_DoesNothing() {
        SubmissionCompletedEvent event = SubmissionCompletedEvent.builder()
                .submissionId(100L)
                .contestId(null)
                .userId(1L)
                .problemId(20L)
                .verdict(OjVerdict.ACCEPTED)
                .submitTime(ZonedDateTime.now())
                .build();

        listener.onSubmissionCompleted(event);

        verifyNoInteractions(leaderboardService);
    }

    @Test
    @DisplayName("onSubmissionCompleted: Service ném ngoại lệ được bắt và ghi log mà không throw ra ngoài")
    void onSubmissionCompleted_ServiceThrowsException_CatchesGracefully() {
        ZonedDateTime now = ZonedDateTime.now();
        SubmissionCompletedEvent event = SubmissionCompletedEvent.builder()
                .submissionId(100L)
                .contestId(5L)
                .userId(1L)
                .problemId(20L)
                .verdict(OjVerdict.WRONG_ANSWER)
                .submitTime(now)
                .build();

        doThrow(new RuntimeException("Redis connection failed"))
                .when(leaderboardService)
                .processIpcpLeaderboard(anyLong(), anyLong(), anyLong(), any(), any());

        listener.onSubmissionCompleted(event);

        verify(leaderboardService).processIpcpLeaderboard(5L, 1L, 20L, OjVerdict.WRONG_ANSWER, now);
    }
}
