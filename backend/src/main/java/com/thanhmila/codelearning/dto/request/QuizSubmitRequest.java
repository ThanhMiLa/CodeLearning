package com.thanhmila.codelearning.dto.request;

import java.util.Set;
import jakarta.validation.constraints.NotEmpty;
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
public class QuizSubmitRequest {
    @NotEmpty(message = "Danh sách câu trả lời không được để trống")
    Set<SubmissionDetail> submissions;
}
