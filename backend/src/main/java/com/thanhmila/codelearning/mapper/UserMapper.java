package com.thanhmila.codelearning.mapper;

import com.thanhmila.codelearning.dto.request.RegisterRequest;
import com.thanhmila.codelearning.dto.response.AuthenticationResponse;
import com.thanhmila.codelearning.dto.response.UserResponse;
import com.thanhmila.codelearning.entity.user.UserEntity;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;

@Mapper(componentModel = "spring")
public interface UserMapper {
    @Mapping(target = "accessToken", ignore = true)
    @Mapping(target = "refreshToken", ignore = true)
    @Mapping(target = "balance", ignore = true)
    @Mapping(target = "roles", expression = "java(mapRoles(userEntity.getRoles()))")
    AuthenticationResponse toAuthenticationResponse(UserEntity userEntity);

    @Mapping(target = "id", ignore = true)
    @Mapping(target = "passwordHash", ignore = true)
    @Mapping(target = "status", constant = "ACTIVE")
    @Mapping(target = "createdAt", ignore = true)
    @Mapping(target = "updatedAt", ignore = true)
    @Mapping(target = "roles", ignore = true)
    @Mapping(target = "wallet", ignore = true)
    @Mapping(target = "cart", ignore = true)
    @Mapping(target = "avatarUrl", ignore = true)
    @Mapping(target = "avatarPublicId", ignore = true)
    UserEntity toUserEntity(RegisterRequest registerRequest);

    
    @Mapping(target = "roles", expression = "java(mapRoles(userEntity.getRoles()))")
    UserResponse toUserResponse(UserEntity userEntity);

    default java.util.Set<String> mapRoles(java.util.Set<com.thanhmila.codelearning.entity.auth.RoleEntity> roles) {
        if (roles == null) return java.util.Collections.emptySet();
        return roles.stream().map(com.thanhmila.codelearning.entity.auth.RoleEntity::getName).collect(java.util.stream.Collectors.toSet());
    }
}
