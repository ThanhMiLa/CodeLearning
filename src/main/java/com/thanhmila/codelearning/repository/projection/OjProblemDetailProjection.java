package com.thanhmila.codelearning.repository.projection;


public interface OjProblemDetailProjection {
    Long getId();
    String getTitle();
    String getDescription();
    String getInputDescription();
    String getOutputDescription();
    String getConstraints();
    String getExampleInput();
    String getExampleOutput();
    String getHint();
    String getDifficulty(); 
    String getTagsRaw();
    String getLatestSourceCode();
    Boolean getIsAccepted();
}