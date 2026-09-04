package com.thanhmila.codelearning.listener;

import com.thanhmila.codelearning.dto.message.ContestStatusMessage;
import com.thanhmila.codelearning.entity.contest.ContestEntity;
import com.thanhmila.codelearning.entity.enums.ContestStatus;
import com.thanhmila.codelearning.repository.contest.ContestRepository;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;

import java.time.Instant;
import java.time.ZonedDateTime;
import java.util.Optional;

import static org.assertj.core.api.Assertions.assertThat;
import static org.mockito.Mockito.*;

@ExtendWith(MockitoExtension.class)
@DisplayName("ContestStatusListener Unit Tests")
class ContestStatusListenerTest {

    @Mock ContestRepository contestRepository;

    @InjectMocks ContestStatusListener listener;

    @Test
    @DisplayName("START action with matching targetTime sets RUNNING status")
    void shouldStartContest_WhenTargetTimeMatches() {
        Instant targetTime = Instant.parse("2026-09-04T12:00:00Z");
        ZonedDateTime startTime = ZonedDateTime.parse("2026-09-04T12:00:00Z");
        ContestEntity contest = ContestEntity.builder()
                .id(1L)
                .startTime(startTime)
                .status(ContestStatus.UPCOMING)
                .build();

        when(contestRepository.findById(1L)).thenReturn(Optional.of(contest));

        ContestStatusMessage message = ContestStatusMessage.builder()
                .contestId("1")
                .action("START")
                .targetTime(targetTime)
                .build();

        listener.handleContestStatus(message);

        assertThat(contest.getStatus()).isEqualTo(ContestStatus.RUNNING);
        verify(contestRepository).save(contest);
    }

    @Test
    @DisplayName("START action with mismatched targetTime ignores message")
    void shouldIgnoreStart_WhenTargetTimeMismatches() {
        Instant targetTime = Instant.parse("2026-09-04T10:00:00Z");
        ZonedDateTime startTime = ZonedDateTime.parse("2026-09-04T12:00:00Z");
        ContestEntity contest = ContestEntity.builder()
                .id(1L)
                .startTime(startTime)
                .status(ContestStatus.UPCOMING)
                .build();

        when(contestRepository.findById(1L)).thenReturn(Optional.of(contest));

        ContestStatusMessage message = ContestStatusMessage.builder()
                .contestId("1")
                .action("START")
                .targetTime(targetTime)
                .build();

        listener.handleContestStatus(message);

        assertThat(contest.getStatus()).isEqualTo(ContestStatus.UPCOMING);
        verify(contestRepository, never()).save(any());
    }

    @Test
    @DisplayName("END action with matching targetTime sets ENDED status")
    void shouldEndContest_WhenTargetTimeMatches() {
        Instant targetTime = Instant.parse("2026-09-04T15:00:00Z");
        ZonedDateTime endTime = ZonedDateTime.parse("2026-09-04T15:00:00Z");
        ContestEntity contest = ContestEntity.builder()
                .id(1L)
                .endTime(endTime)
                .status(ContestStatus.RUNNING)
                .build();

        when(contestRepository.findById(1L)).thenReturn(Optional.of(contest));

        ContestStatusMessage message = ContestStatusMessage.builder()
                .contestId("1")
                .action("END")
                .targetTime(targetTime)
                .build();

        listener.handleContestStatus(message);

        assertThat(contest.getStatus()).isEqualTo(ContestStatus.ENDED);
        verify(contestRepository).save(contest);
    }

    @Test
    @DisplayName("Contest not found ignores message gracefully")
    void shouldIgnore_WhenContestNotFound() {
        when(contestRepository.findById(1L)).thenReturn(Optional.empty());

        ContestStatusMessage message = ContestStatusMessage.builder()
                .contestId("1")
                .action("START")
                .targetTime(Instant.now())
                .build();

        listener.handleContestStatus(message);

        verify(contestRepository, never()).save(any());
    }
}
