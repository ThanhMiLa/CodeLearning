package com.thanhmila.codelearning.dto.request;

import jakarta.validation.constraints.Min;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import lombok.AccessLevel;
import lombok.Data;
import lombok.experimental.FieldDefaults;

@Data
@FieldDefaults(level = AccessLevel.PRIVATE)
public class GenerateTestcaseRequest {

    @NotNull(message = "Total testcases to generate cannot be null")
    @Min(value = 1, message = "Total testcases to generate must be at least 1")
    Integer totalTestcasesToGenerate;

    @NotBlank(message = "Generator code cannot be blank")
    String generatorCode;

    @NotBlank(message = "Solution code cannot be blank")
    String solutionCode;
    
    @NotNull(message = "Generator language ID is required")
    Integer generatorLanguageId;
    
    @NotNull(message = "Solution language ID is required")
    Integer solutionLanguageId;
}
