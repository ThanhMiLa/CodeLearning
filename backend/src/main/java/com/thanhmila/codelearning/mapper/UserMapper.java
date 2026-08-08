package com.thanhmila.codelearning.mapper;

import com.thanhmila.codelearning.dto.request.RegisterRequest;
import com.thanhmila.codelearning.dto.response.AdminUserResponse;
import com.thanhmila.codelearning.dto.response.AuthenticationResponse;
import com.thanhmila.codelearning.dto.response.UserResponse;
import com.thanhmila.codelearning.entity.auth.RoleEntity;
import com.thanhmila.codelearning.entity.user.UserEntity;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;

import java.util.Collections;
import java.util.Set;
import java.util.stream.Collectors;

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
    @Mapping(target = "isEmailValid", ignore = true)
    UserEntity toUserEntity(RegisterRequest registerRequest);

    
    @Mapping(target = "roles", expression = "java(mapRoles(userEntity.getRoles()))")
    UserResponse toUserResponse(UserEntity userEntity);

    @Mapping(target = "roles", expression = "java(mapRoles(userEntity.getRoles()))")
    @Mapping(target = "balance", expression = "java(userEntity.getWallet() != null && userEntity.getWallet().getBalance() != null ? userEntity.getWallet().getBalance() : java.math.BigDecimal.ZERO)")
    @Mapping(target = "status", expression = "java(userEntity.getStatus() != null ? userEntity.getStatus().name() : null)")
    AdminUserResponse toAdminUserResponse(UserEntity userEntity);

    default Set<String> mapRoles(Set<RoleEntity> roles) {
        if (roles == null) return Collections.emptySet();
        return roles.stream().map(RoleEntity::getName).collect(Collectors.toSet());
    }
}
