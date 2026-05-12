package com.thanhmila.codelearning.dto.request;

import jakarta.validation.Valid;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotEmpty;
import jakarta.validation.constraints.NotNull;
import lombok.*;
import lombok.experimental.FieldDefaults;

import java.util.List;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
@FieldDefaults(level = AccessLevel.PRIVATE)
public class QuizQuestionRequest {

    // Dùng cho Update: Nếu id = null -> Insert mới, Nếu id != null -> Update/Giữ nguyên
    Long id; 

    @NotBlank(message = "QUESTION_CONTENT_INVALID")
    String questionContent;

    @NotNull(message = "QUESTION_ORDER_INVALID")
    Integer orderIndex;

    @NotEmpty(message = "QUESTION_OPTIONS_EMPTY")
    @Valid // Validate tiếp các option
    List<QuizOptionRequest> options;
}
