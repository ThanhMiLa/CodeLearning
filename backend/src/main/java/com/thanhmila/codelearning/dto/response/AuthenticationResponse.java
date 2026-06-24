package com.thanhmila.codelearning.dto.response;

import lombok.*;
import lombok.experimental.FieldDefaults;

import java.math.BigDecimal;
import java.util.Set;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE)
public class AuthenticationResponse {
    String accessToken;
    String refreshToken;
    Long id;
    String displayName;
    String email;
    String phoneNumber;
    BigDecimal balance;
    String avatarUrl;
    Set<String> roles;
}
