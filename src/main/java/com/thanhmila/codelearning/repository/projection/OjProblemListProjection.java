package com.thanhmila.codelearning.repository.projection;

import com.thanhmila.codelearning.entity.enums.ProblemDifficulty;

public interface OjProblemListProjection {
    Long getId();
    String getTitle();
    ProblemDifficulty getDifficulty();
    Boolean getIsAccepted();
}
