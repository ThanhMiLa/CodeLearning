package com.thanhmila.codelearning.dto.response;

import com.thanhmila.codelearning.entity.enums.ProblemDifficulty;
import com.thanhmila.codelearning.entity.enums.ProblemScope;
import lombok.*;
import lombok.experimental.FieldDefaults;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE)
public class OjAdminProblemResponse {
    Long id;
    String title;
    ProblemScope scope;
    ProblemDifficulty difficulty;
    Integer totalSubmissions;
    Integer totalAccepted;
    TeacherResponse createdByTeacher;
    Boolean isPublic;
}
