package com.thanhmila.codelearning.dto.response;

import com.thanhmila.codelearning.entity.enums.ProblemDifficulty;
import lombok.*;
import lombok.experimental.FieldDefaults;
import java.util.List;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE)
public class OjProblemDetailResponse {
    Long id;
    String title;
    String description;
    String inputDescription;
    String outputDescription;
    String constraints;
    String exampleInput;
    String exampleOutput;
    String hint;
    ProblemDifficulty difficulty;
    
    String latestSourceCode; 
    Boolean isAccepted;      
    List<String> tags; 
}