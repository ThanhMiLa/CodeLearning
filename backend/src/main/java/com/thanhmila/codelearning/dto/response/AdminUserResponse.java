package com.thanhmila.codelearning.dto.response;

import lombok.*;
import lombok.experimental.FieldDefaults;

import java.math.BigDecimal;
import java.time.OffsetDateTime;
import java.util.Set;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE)
public class AdminUserResponse {
    Long id;
    String displayName;
    String username;
    String email;
    String phoneNumber;
    BigDecimal balance;
    String status;
    Set<String> roles;
    OffsetDateTime createdAt;
}
