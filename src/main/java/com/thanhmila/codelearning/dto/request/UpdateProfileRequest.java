package com.thanhmila.codelearning.dto.request;

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
public class UpdateProfileRequest {

    @Size(min = 4, message = "DISPLAY_NAME_INVALID")
    String displayName;

    @Pattern(regexp = "^(0\\d{9})?$", message = "PHONE_INVALID")
    String phoneNumber;

}
