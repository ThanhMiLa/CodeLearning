package com.thanhmila.codelearning.dto.response;

import com.thanhmila.codelearning.entity.enums.ProblemDifficulty;

import lombok.*;
import lombok.experimental.FieldDefaults;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE)
public class OnlineJudgeProblemResponse {
    Long id;
    String title;
    ProblemDifficulty difficulty;
    Boolean isAccepted;
}
