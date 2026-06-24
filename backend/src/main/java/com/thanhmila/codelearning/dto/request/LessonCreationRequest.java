package com.thanhmila.codelearning.dto.request;

import com.thanhmila.codelearning.entity.enums.LessonStatus;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Size;
import lombok.*;
import lombok.experimental.FieldDefaults;
import org.springframework.web.multipart.MultipartFile;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE)
public class LessonCreationRequest {

    @NotBlank(message = "LESSON_TITLE_REQUIRED")
    @Size(max = 255, message = "LESSON_TITLE_TOO_LONG")
    String title;

    String description;
    String theoryContent;

    @Builder.Default
    Boolean trial = false;

    Integer estimatedDurationMinutes;

    @Builder.Default
    LessonStatus status = LessonStatus.DRAFT;

    MultipartFile videoFile;

}
