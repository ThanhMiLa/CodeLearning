package com.thanhmila.codelearning.dto.request;

import jakarta.validation.constraints.NotBlank;
import lombok.AccessLevel;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.experimental.FieldDefaults;
import java.util.List;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE)
public class EmailCampaignRequest {
    @NotBlank(message = "Template ID is required")
    String templateId;

    @NotBlank(message = "Target type is required")
    String targetType; // e.g. "ALL", "SPECIFIC", "ROLE"

    List<String> userIds;
    
    String role;
}
