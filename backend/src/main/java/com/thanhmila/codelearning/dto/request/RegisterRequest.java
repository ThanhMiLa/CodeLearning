package com.thanhmila.codelearning.dto.request;

import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Pattern;
import jakarta.validation.constraints.Size;
import lombok.*;
import lombok.experimental.FieldDefaults;


@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE)
public class RegisterRequest {

    @NotBlank(message = "USERNAME_INVALID")
    @Size(min = 4, message = "DISPLAY_NAME_INVALID")
    String displayName;

    @NotBlank(message = "USERNAME_INVALID")
    @Size(min = 4, message = "USERNAME_INVALID")
    String username;

    @Pattern(regexp = "^(0\\d{9})?$", message = "PHONE_INVALID")
    String phoneNumber;

    @NotBlank(message = "EMAIL_INVALID")
    @Email(message = "EMAIL_INVALID")
    String email;

    @NotBlank(message = "PASSWORD_INVALID")
    @Size(min = 4, message = "PASSWORD_INVALID")
    String password;

    @NotBlank(message = "CONFIRM_PASSWORD_INVALID")
    @Size(min = 4, message = "CONFIRM_PASSWORD_INVALID")
    String confirmPassword;


}
