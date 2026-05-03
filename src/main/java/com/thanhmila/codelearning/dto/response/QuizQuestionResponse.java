package com.thanhmila.codelearning.dto.response;

import lombok.*;
import lombok.experimental.FieldDefaults;

import java.util.List;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE)
public class QuizQuestionResponse {
    Long id;
    String questionContent;
    Integer orderIndex;
    List<QuizOptionResponse> options;
}
