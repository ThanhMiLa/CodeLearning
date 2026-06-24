package com.thanhmila.codelearning.event;

import com.thanhmila.codelearning.entity.enums.OjVerdict;
import lombok.Builder;
import lombok.Getter;

import java.time.ZonedDateTime;

@Getter
@Builder
public class SubmissionCompletedEvent {
    private Long submissionId;
    private Long userId;
    private Long problemId;
    private Long contestId; // null if practice
    private OjVerdict verdict;
    private ZonedDateTime submitTime;

    public boolean isContestMode() {
        return this.contestId != null;
    }
}
