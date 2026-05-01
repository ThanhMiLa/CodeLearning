package com.thanhmila.codelearning.dto.response;

import lombok.*;
import lombok.experimental.FieldDefaults;

import java.math.BigDecimal;

@Getter
@Setter
@Builder
@NoArgsConstructor
@AllArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE)
public class CourseListItemResponse {

    Long id;

    String title;

    String shortDescription;

    String thumbnailUrl;

    BigDecimal price;

    Double averageRating;

    Long totalReviews;

    Long totalEnrolled;

    Boolean enrolled;

    Double progressPercentage;
}