package com.thanhmila.codelearning.dto.request;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Size;
import lombok.*;
import lombok.experimental.FieldDefaults;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE)
public class ChapterCreationRequest {

    @NotBlank(message = "CHAPTER_TITLE_REQUIRED")
    @Size(max = 255, message = "CHAPTER_TITLE_TOO_LONG")
    String title;
}
