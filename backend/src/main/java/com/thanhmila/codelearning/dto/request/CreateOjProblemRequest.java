package com.thanhmila.codelearning.dto.request;

import com.thanhmila.codelearning.entity.enums.ProblemDifficulty;
import com.thanhmila.codelearning.entity.enums.ProblemScope;
import jakarta.validation.constraints.Min;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import lombok.AccessLevel;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.experimental.FieldDefaults;

import java.math.BigDecimal;
import java.util.Set;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE)
public class CreateOjProblemRequest {

    @NotBlank(message = "Title is required")
    String title;

    String description;

    String inputDescription;

    String outputDescription;

    String constraints;

    String exampleInput;

    String exampleOutput;

    String hint;

    @NotNull(message = "Problem scope is required")
    ProblemScope problemScope;

    @NotNull(message = "Difficulty is required")
    ProblemDifficulty difficulty;

    @Min(value = 1000, message = "Time limit must be at least 1000ms")
    Integer timeLimitMs;

    @Min(value = 262144, message = "Memory limit must be at least 256MB (262144 KB)")
    Integer memoryLimitKb;

    BigDecimal score;

    Set<Long> tagIds;
}
