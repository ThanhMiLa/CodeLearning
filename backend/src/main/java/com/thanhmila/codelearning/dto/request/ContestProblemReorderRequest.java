package com.thanhmila.codelearning.dto.request;

import jakarta.validation.constraints.NotNull;
import lombok.*;
import lombok.experimental.FieldDefaults;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE)
public class ContestProblemReorderRequest {

    @NotNull(message = "Problem ID is required")
    Long problemId;

    @NotNull(message = "Order index is required")
    Integer orderIndex;
}
