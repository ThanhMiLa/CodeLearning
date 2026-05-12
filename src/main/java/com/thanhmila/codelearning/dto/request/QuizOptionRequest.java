package com.thanhmila.codelearning.dto.request;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import lombok.*;
import lombok.experimental.FieldDefaults;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
@FieldDefaults(level = AccessLevel.PRIVATE)
public class QuizOptionRequest {

    // Dùng cho Update: Nếu id = null -> Insert mới, Nếu id != null -> Update/Giữ nguyên
    Long id; 

    @NotBlank(message = "OPTION_CONTENT_INVALID")
    String content;

    @NotNull(message = "OPTION_IS_CORRECT_INVALID")
    Boolean isCorrect;

    Integer orderIndex;
}
