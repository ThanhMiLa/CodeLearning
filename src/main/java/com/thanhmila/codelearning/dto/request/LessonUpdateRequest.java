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
public class LessonUpdateRequest {

    @NotBlank(message = "LESSON_TITLE_REQUIRED")
    @Size(max = 255, message = "LESSON_TITLE_TOO_LONG")
    String title;

    String description;
    String theoryContent;
    String sampleCode;
    Boolean trial;
    Integer estimatedDurationMinutes;
    LessonStatus status;

    MultipartFile videoFile;

}
