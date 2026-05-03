package com.thanhmila.codelearning.dto.response;

import lombok.*;
import lombok.experimental.FieldDefaults;

import java.math.BigDecimal;
import java.util.List;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE)
public class CourseDetailResponse {
    // 1. Thông tin cơ bản
    Long id;
    String title;
    String shortDescription;
    String thumbnailUrl;
    BigDecimal price;
    Double averageRating;
    Integer totalReviews;
    Integer totalEnrolled;

    // 2. Nội dung chi tiết (Các cột text riêng biệt)
    String courseContent;
    String learningOutcomes;
    String courseHighlights;
    String technologiesTools;
    String prerequisites;
    String targetAudience;
    String completionBenefits;
    Integer estimatedDurationHours;
    Integer totalLessons;
    Integer totalQuizzes;
    Integer totalAssignments;
    Integer totalOnlineJudgeProblems;
    Integer totalVideos;

    // 3. Trạng thái đối với User hiện tại
    Boolean isEnrolled;

    // 4. Thông tin Giảng viên (Teacher)
    List<TeacherResponse> instructors;

    // 5. Thông tin Category (Category)
    List<CategoryResponse> categories;

    // 6. Thông tin về progressPercentage
    Integer progressPercentage;
}
