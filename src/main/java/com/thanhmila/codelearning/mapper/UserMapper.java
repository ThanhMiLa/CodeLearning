package com.thanhmila.codelearning.mapper;

import com.thanhmila.codelearning.dto.response.AuthenticationResponse;
import com.thanhmila.codelearning.entity.UserEntity;
import org.mapstruct.Mapper;

@Mapper(componentModel = "spring")
public interface UserMapper {
    AuthenticationResponse toAuthenticationResponse(UserEntity userEntity);
}
