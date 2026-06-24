package com.thanhmila.codelearning.dto.response;

import lombok.*;
import lombok.experimental.FieldDefaults;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE)
public class LessonSummaryResponse {
    Long id;
    String title;
    Integer orderIndex;
    Integer estimatedDurationMinutes;
    Boolean trial;
    
    @Builder.Default
    Boolean isCompleted = false;
}
