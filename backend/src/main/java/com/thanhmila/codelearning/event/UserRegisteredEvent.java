package com.thanhmila.codelearning.event;

import com.thanhmila.codelearning.entity.user.UserEntity;

import lombok.*;
import lombok.experimental.FieldDefaults;

@Getter
@Setter
@Builder
@NoArgsConstructor
@AllArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE)
public class UserRegisteredEvent {
    UserEntity userEntity;
}
