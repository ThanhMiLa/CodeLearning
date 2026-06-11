package com.thanhmila.codelearning.dto.request;

import jakarta.validation.constraints.NotNull;
import lombok.*;
import lombok.experimental.FieldDefaults;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE)
public class ChapterReorderRequest {
    
    @NotNull(message = "CHAPTER_ID_REQUIRED")
    Long id;

    @NotNull(message = "ORDER_INDEX_REQUIRED")
    Integer orderIndex;
}
