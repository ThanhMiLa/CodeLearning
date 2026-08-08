package com.thanhmila.codelearning.dto.response;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class EmailTargetUserResponse {
    private String id;
    private String displayName;
    private String email;
    private String phone;
    private String role;
}
