package com.thanhmila.codelearning.mapper;

import com.thanhmila.codelearning.dto.request.RegisterRequest;
import com.thanhmila.codelearning.dto.response.AdminUserResponse;
import com.thanhmila.codelearning.dto.response.AuthenticationResponse;
import com.thanhmila.codelearning.dto.response.UserResponse;
import com.thanhmila.codelearning.entity.auth.RoleEntity;
import com.thanhmila.codelearning.entity.enums.UserStatus;
import com.thanhmila.codelearning.entity.payment.WalletEntity;
import com.thanhmila.codelearning.entity.user.UserEntity;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.mapstruct.factory.Mappers;

import java.math.BigDecimal;
import java.util.Set;

import static org.assertj.core.api.Assertions.assertThat;

@DisplayName("UserMapper Unit Tests")
class UserMapperTest {

    private final UserMapper userMapper = Mappers.getMapper(UserMapper.class);

    @Test
    @DisplayName("mapRoles: roles là null trả về Set rỗng")
    void mapRoles_NullRoles_ReturnsEmptySet() {
        Set<String> result = userMapper.mapRoles(null);
        assertThat(result).isNotNull().isEmpty();
    }

    @Test
    @DisplayName("mapRoles: roles hợp lệ trả về tập tên quyền")
    void mapRoles_ValidRoles_ReturnsRoleNames() {
        RoleEntity role1 = RoleEntity.builder().name("ROLE_USER").build();
        RoleEntity role2 = RoleEntity.builder().name("ROLE_ADMIN").build();

        Set<String> result = userMapper.mapRoles(Set.of(role1, role2));
        assertThat(result).containsExactlyInAnyOrder("ROLE_USER", "ROLE_ADMIN");
    }

    @Test
    @DisplayName("toAdminUserResponse: wallet là null thì balance mặc định là 0")
    void toAdminUserResponse_NullWallet_BalanceDefaultsToZero() {
        UserEntity user = UserEntity.builder()
                .id(1L)
                .username("john")
                .status(UserStatus.ACTIVE)
                .wallet(null)
                .build();

        AdminUserResponse response = userMapper.toAdminUserResponse(user);

        assertThat(response).isNotNull();
        assertThat(response.getBalance()).isEqualTo(BigDecimal.ZERO);
        assertThat(response.getStatus()).isEqualTo("ACTIVE");
    }

    @Test
    @DisplayName("toAdminUserResponse: wallet có số dư thì lấy đúng số dư")
    void toAdminUserResponse_WithWallet_ReturnsCorrectBalance() {
        WalletEntity wallet = WalletEntity.builder().balance(new BigDecimal("150000")).build();
        UserEntity user = UserEntity.builder()
                .id(2L)
                .username("jane")
                .status(UserStatus.ACTIVE)
                .wallet(wallet)
                .build();

        AdminUserResponse response = userMapper.toAdminUserResponse(user);

        assertThat(response).isNotNull();
        assertThat(response.getBalance()).isEqualTo(new BigDecimal("150000"));
    }

    @Test
    @DisplayName("toUserResponse: Ánh xạ UserEntity sang UserResponse chính xác")
    void toUserResponse_MapsCorrectly() {
        RoleEntity role = RoleEntity.builder().name("ROLE_USER").build();
        UserEntity user = UserEntity.builder()
                .id(3L)
                .username("alex")
                .email("alex@example.com")
                .displayName("Alex Doe")
                .roles(Set.of(role))
                .build();

        UserResponse response = userMapper.toUserResponse(user);

        assertThat(response).isNotNull();
        assertThat(response.getUsername()).isEqualTo("alex");
        assertThat(response.getEmail()).isEqualTo("alex@example.com");
        assertThat(response.getDisplayName()).isEqualTo("Alex Doe");
        assertThat(response.getRoles()).contains("ROLE_USER");
    }

    @Test
    @DisplayName("toAuthenticationResponse: Ánh xạ UserEntity sang AuthenticationResponse")
    void toAuthenticationResponse_MapsCorrectly() {
        RoleEntity role = RoleEntity.builder().name("ROLE_ADMIN").build();
        UserEntity user = UserEntity.builder()
                .id(4L)
                .displayName("Admin User")
                .roles(Set.of(role))
                .build();

        AuthenticationResponse response = userMapper.toAuthenticationResponse(user);

        assertThat(response).isNotNull();
        assertThat(response.getDisplayName()).isEqualTo("Admin User");
        assertThat(response.getRoles()).contains("ROLE_ADMIN");
    }

    @Test
    @DisplayName("toUserEntity: Ánh xạ RegisterRequest sang UserEntity với status ACTIVE")
    void toUserEntity_MapsCorrectly() {
        RegisterRequest request = RegisterRequest.builder()
                .username("newbie")
                .email("newbie@example.com")
                .displayName("Newbie")
                .build();

        UserEntity user = userMapper.toUserEntity(request);

        assertThat(user).isNotNull();
        assertThat(user.getUsername()).isEqualTo("newbie");
        assertThat(user.getEmail()).isEqualTo("newbie@example.com");
        assertThat(user.getDisplayName()).isEqualTo("Newbie");
        assertThat(user.getStatus()).isEqualTo(UserStatus.ACTIVE);
    }
}
