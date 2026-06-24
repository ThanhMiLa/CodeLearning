package com.thanhmila.codelearning.repository.projection;

public interface OjPracticeProblemProjection {
    Long getId();
    String getTitle();
    String getDifficulty();
    Integer getTotalSubmissions();
    Integer getTotalAccepted();
    Boolean getIsAccepted();
}
