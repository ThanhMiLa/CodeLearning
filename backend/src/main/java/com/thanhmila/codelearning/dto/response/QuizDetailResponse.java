package com.thanhmila.codelearning.dto.response;

import lombok.*;
import lombok.experimental.FieldDefaults;
import java.util.List;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE)
public class QuizDetailResponse {
    Long id;
    String title;
    String description;
    List<QuizQuestionResponse> questions;
    QuizAttemptResponse pastAttempt;
}
