package com.thanhmila.codelearning.dto.response;

import lombok.*;
import lombok.experimental.FieldDefaults;

import java.util.Set;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE)
public class UserResponse {
    Long id;
    String displayName;
    String username;
    String phoneNumber;
    String email;
    String avatarUrl;
    Set<String> roles;
}
