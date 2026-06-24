package com.thanhmila.codelearning.dto.response;

import lombok.*;
import lombok.experimental.FieldDefaults;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE)
public class LessonDetailResponse {

    // 1. Thông tin cơ bản
    Long id;
    String title;
    String description;
    Integer estimatedDurationMinutes;
    Boolean trial; // Trả về để UI biết bài này là học thử hay không (có thể dùng để hiển thị badge "Free")

    // 2. Nội dung cốt lõi để học (Khu vực chính)
    String videoUrl;
    String theoryContent;
    String sampleCode;

}
