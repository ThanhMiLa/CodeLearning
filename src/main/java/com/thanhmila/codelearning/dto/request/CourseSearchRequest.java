package com.thanhmila.codelearning.dto.request;

import lombok.*;
import lombok.experimental.FieldDefaults;

import java.math.BigDecimal;
import java.util.List;

@Getter
@Setter
@Builder
@NoArgsConstructor
@AllArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE)
public class CourseSearchRequest {

    // 1. Tìm kiếm văn bản tự do
    // Sẽ dùng toán tử ILIKE trong DB để tìm theo title hoặc short_description
    String keyword;

    // 2. Lọc theo danh mục (Lĩnh vực)
    // Dùng List để user có thể check chọn nhiều danh mục cùng lúc (VD: vừa Java, vừa Backend)
    List<Long> categoryIds;

    // 3. Lọc theo khoảng giá
    BigDecimal minPrice;
    BigDecimal maxPrice;

    // 4. Lọc theo chất lượng khóa học (Số sao trung bình)
    // Giao diện thường có dạng: "Từ 4 sao trở lên" -> minRating = 4.0, maxRating = 5.0
    Double minRating;
    Double maxRating;

    // 5. Lọc theo tên giáo viên
    // Sẽ dùng JOIN từ bảng Course -> Teacher_Course_Assignments -> Teachers -> Users
    String teacherName;

}