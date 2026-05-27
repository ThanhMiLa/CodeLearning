package com.thanhmila.codelearning.dto.request;

import com.thanhmila.codelearning.entity.enums.ScoringRule;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import lombok.*;
import lombok.experimental.FieldDefaults;

import java.time.ZonedDateTime;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE)
public class ContestUpdateRequest {

    String title;

    String description;

    String oldPassword;

    String newPassword;

    @NotNull(message = "Scoring rule is required")
    ScoringRule scoringRule;

    @NotNull(message = "Start time is required")
    ZonedDateTime startTime;

    @NotNull(message = "End time is required")
    ZonedDateTime endTime;
}
