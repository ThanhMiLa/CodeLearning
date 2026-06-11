package com.thanhmila.codelearning.dto.request;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.PositiveOrZero;
import jakarta.validation.constraints.Size;
import lombok.*;
import lombok.experimental.FieldDefaults;
import org.springframework.web.multipart.MultipartFile;

import java.math.BigDecimal;
import java.util.Set;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE)
public class CourseCreationRequest {

    @NotBlank(message = "COURSE_TITLE_REQUIRED")
    @Size(max = 255, message = "COURSE_TITLE_TOO_LONG")
    String title;

    String shortDescription;
    String courseContent;
    String learningOutcomes;
    String courseHighlights;
    String technologiesTools;
    String prerequisites;
    String targetAudience;
    String completionBenefits;

    @NotNull(message = "COURSE_PRICE_REQUIRED")
    @PositiveOrZero(message = "COURSE_PRICE_INVALID")
    BigDecimal price;

    Integer estimatedDurationHours;

    MultipartFile thumbnailFile;

    Set<Long> categoryIds;
}
