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
public class OjAdminSubmissionResponse {
    String userDisplayName;
    String problemTitle;
    String language;
    OjVerdict verdict;
    Integer executionTimeMs;
    Integer memoryUsedKb;
    ZonedDateTime submittedAt;
}
