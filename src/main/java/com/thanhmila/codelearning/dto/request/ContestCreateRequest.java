package com.thanhmila.codelearning.dto.request;

import com.thanhmila.codelearning.entity.enums.ScoringRule;
import jakarta.validation.constraints.Future;
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
public class ContestCreateRequest {

    @NotBlank(message = "Title is required")
    String title;

    String description;

    String password;

    @NotNull(message = "Scoring rule is required")
    ScoringRule scoringRule;

    @NotNull(message = "Start time is required")
    @Future(message = "Start time must be in the future")
    ZonedDateTime startTime;

    @NotNull(message = "End time is required")
    @Future(message = "End time must be in the future")
    ZonedDateTime endTime;
}
