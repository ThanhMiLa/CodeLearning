package com.thanhmila.codelearning.dto.response;

import java.math.BigDecimal;
import java.time.ZonedDateTime;

import lombok.AccessLevel;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.experimental.FieldDefaults;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE)
public class QuizSubmitResponse {
    Long attemptId;          
    Long quizId;            
    Integer totalQuestions; 
    Integer correctAnswers; 
    BigDecimal score;       
    ZonedDateTime submittedAt;     
}
