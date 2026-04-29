package com.thanhmila.codelearning.mapper;

import com.thanhmila.codelearning.dto.request.RegisterRequest;
import com.thanhmila.codelearning.dto.response.AuthenticationResponse;
import com.thanhmila.codelearning.entity.UserEntity;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;

@Mapper(componentModel = "spring")
public interface UserMapper {
    AuthenticationResponse toAuthenticationResponse(UserEntity userEntity);

    @Mapping(target = "passwordHash", ignore = true)
    UserEntity toUserEntity(RegisterRequest registerRequest);
}
