package com.thanhmila.codelearning.dto.response;

import lombok.*;
import lombok.experimental.FieldDefaults;


@Getter
@Setter
@Builder
@NoArgsConstructor
@AllArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE)
public class CourseProgressResponse {
    Long courseId;
    String title;
    String thumbnailUrl;
    Integer completedLessons;
    Integer totalLessons;
    Integer completionPercentage;
}
