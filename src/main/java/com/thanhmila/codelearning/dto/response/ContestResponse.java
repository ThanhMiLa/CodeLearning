package com.thanhmila.codelearning.dto.response;

import com.thanhmila.codelearning.entity.enums.ContestStatus;
import com.thanhmila.codelearning.entity.enums.ScoringRule;
import lombok.*;
import lombok.experimental.FieldDefaults;

import java.time.ZonedDateTime;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE)
public class ContestResponse {
    Long id;
    String title;
    String description;
    boolean isProtected; 
    ScoringRule scoringRule;
    ZonedDateTime startTime;
    ZonedDateTime endTime;
    ContestStatus status;
    String teacherName;
    ZonedDateTime createdAt;
}
