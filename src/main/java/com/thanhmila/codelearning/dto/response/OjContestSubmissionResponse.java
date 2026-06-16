package com.thanhmila.codelearning.dto.response;

import com.thanhmila.codelearning.entity.enums.OjVerdict;
import lombok.*;
import lombok.experimental.FieldDefaults;

import java.time.ZonedDateTime;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE)
public class OjContestSubmissionResponse {
    Long id;
    Long problemId;
    String language;
    OjVerdict verdict;
    Integer executionTimeMs;
    Integer memoryUsedKb;
    ZonedDateTime submittedAt;
}
