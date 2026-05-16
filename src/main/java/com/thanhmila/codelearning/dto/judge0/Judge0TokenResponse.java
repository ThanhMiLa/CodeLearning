package com.thanhmila.codelearning.dto.judge0;

import lombok.*;
import lombok.experimental.FieldDefaults;

@Data
@NoArgsConstructor
@AllArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE)
public class Judge0TokenResponse {
    String token; // Ví dụ: "725fdde7-..."
}