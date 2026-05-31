package com.thanhmila.codelearning.dto.response;

import com.thanhmila.codelearning.entity.enums.OjVerdict;
import lombok.*;
import lombok.experimental.FieldDefaults;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE)
public class OjWebSocketMessage {
    Long submissionId;
    Long testcaseId;

    OjVerdict testcaseVerdict; // Kết quả của riêng Testcase này (AC, WA...)
    OjVerdict overallVerdict;  // Kết quả TỔNG của cả bài nộp

    Integer executionTimeMs;
    Integer memoryUsedKb;

    Integer totalTestcases;
    Integer processedTestcases;

    // Fields for non-contest mode
    String input;
    String expectedOutput;
    String actualOutput;
    String compileOutput;
}