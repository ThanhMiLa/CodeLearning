package com.thanhmila.codelearning.dto.response;

import java.time.ZonedDateTime;
import lombok.AccessLevel;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.experimental.FieldDefaults;

@Getter
@Setter
@Builder
@NoArgsConstructor
@AllArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE)
public class QuizAttemptResponse {
    Long id;
    Double score;
    Integer correctAnswers;
    Integer totalQuestions;
    ZonedDateTime submittedAt;
}
