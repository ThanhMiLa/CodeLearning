package com.thanhmila.codelearning.dto.response;

import com.thanhmila.codelearning.entity.enums.OjVerdict;
import lombok.*;
import lombok.experimental.FieldDefaults;

import java.math.BigDecimal;
import java.time.ZonedDateTime;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE)
public class OjSubmissionHistoryResponse {
    Long id;
    String language;
    OjVerdict verdict;
    Integer executionTimeMs;
    Integer memoryUsedKb;
    ZonedDateTime submittedAt;
}
