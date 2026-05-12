package com.thanhmila.codelearning.dto.request;

import jakarta.validation.Valid;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotEmpty;
import lombok.*;
import lombok.experimental.FieldDefaults;

import java.util.List;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
@FieldDefaults(level = AccessLevel.PRIVATE)
public class QuizRequest {

    @NotBlank(message = "QUIZ_TITLE_INVALID")
    String title;

    String description;

    @NotEmpty(message = "QUIZ_QUESTIONS_EMPTY")
    @Valid // Cực kỳ quan trọng: Lệnh cho Spring validate tiếp các object con bên trong List
    List<QuizQuestionRequest> questions;
}
