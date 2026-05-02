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

    // 3. Thông tin tổng quan (Thống kê)
    // Lưu ý: Các field này tính toán bằng query/count chứ không lấy trực tiếp từ bảng Course
    Integer estimatedDurationHours;
    Integer totalLessons;
    Integer totalQuizzes;
    Integer totalAssignments;
    Integer totalOnlineJudgeProblems;
    Integer totalVideos;

    // 4. Trạng thái đối với User hiện tại
    // Dùng để logic hiển thị nút "Vào học" hoặc "Mua ngay/Học thử"
    Boolean isEnrolled;

    // 5. Giáo trình (Syllabus)
    List<ChapterResponse> chapters;

    // 6. Thông tin Giảng viên (Teacher)
    List<TeacherResponse> instructors;

    // T. Thông tin Category (Category)
    List<CategoryResponse> categories;

}
