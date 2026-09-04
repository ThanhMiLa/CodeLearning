package com.thanhmila.codelearning.service.user;

import com.thanhmila.codelearning.dto.request.ChangePasswordRequest;
import com.thanhmila.codelearning.dto.request.UpdateProfileRequest;
import com.thanhmila.codelearning.dto.response.CloudinaryResponse;
import com.thanhmila.codelearning.dto.response.UserBalanceResponse;
import com.thanhmila.codelearning.dto.response.UserResponse;
import com.thanhmila.codelearning.entity.enums.UserStatus;
import com.thanhmila.codelearning.entity.payment.WalletEntity;
import com.thanhmila.codelearning.entity.user.UserEntity;
import com.thanhmila.codelearning.exception.AppException;
import com.thanhmila.codelearning.exception.ErrorCode;
import com.thanhmila.codelearning.mapper.UserMapper;
import com.thanhmila.codelearning.repository.user.UserRepository;
import com.thanhmila.codelearning.service.cloudinary.CloudinaryService;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Nested;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;
import org.springframework.mock.web.MockMultipartFile;
import org.springframework.security.crypto.password.PasswordEncoder;

import java.io.IOException;
import java.math.BigDecimal;
import java.util.Optional;

import static org.assertj.core.api.Assertions.assertThat;
import static org.assertj.core.api.Assertions.assertThatThrownBy;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.ArgumentMatchers.eq;
import static org.mockito.Mockito.*;

@ExtendWith(MockitoExtension.class)
@DisplayName("UserService Unit Tests")
class UserServiceTest {

    @Mock UserRepository userRepository;
    @Mock UserMapper userMapper;
    @Mock PasswordEncoder passwordEncoder;
    @Mock CloudinaryService cloudinaryService;

    @InjectMocks UserService userService;

    private UserEntity user;

    @BeforeEach
    void setUp() {
        user = UserEntity.builder()
                .id(1L)
                .username("john")
                .displayName("John Doe")
                .passwordHash("hashedPass")
                .status(UserStatus.ACTIVE)
                .build();
    }

    @Nested
    @DisplayName("getMyInfo Tests")
    class GetMyInfoTests {

        @Test
        @DisplayName("User not found throws USER_NOT_FOUND")
        void shouldThrow_WhenUserNotFound() {
            when(userRepository.findByUsername("unknown")).thenReturn(Optional.empty());

            assertThatThrownBy(() -> userService.getMyInfo("unknown"))
                    .isInstanceOf(AppException.class)
                    .hasFieldOrPropertyWithValue("errorCode", ErrorCode.USER_NOT_FOUND);
        }

        @Test
        @DisplayName("Success returns mapped UserResponse")
        void shouldReturnUserResponse_WhenFound() {
            UserResponse expected = UserResponse.builder().id(1L).username("john").build();
            when(userRepository.findByUsername("john")).thenReturn(Optional.of(user));
            when(userMapper.toUserResponse(user)).thenReturn(expected);

            UserResponse actual = userService.getMyInfo("john");

            assertThat(actual).isNotNull();
            assertThat(actual.getUsername()).isEqualTo("john");
        }
    }

    @Nested
    @DisplayName("updateProfile Tests")
    class UpdateProfileTests {

        @Test
        @DisplayName("Update text fields without avatar")
        void shouldUpdateProfile_WithoutAvatar() {
            UpdateProfileRequest request = UpdateProfileRequest.builder()
                    .displayName("New Name")
                    .phoneNumber("0123456789")
                    .build();

            when(userRepository.findByUsername("john")).thenReturn(Optional.of(user));
            when(userMapper.toUserResponse(any())).thenReturn(UserResponse.builder().displayName("New Name").build());

            UserResponse response = userService.updateProfile("john", request);

            assertThat(user.getDisplayName()).isEqualTo("New Name");
            assertThat(user.getPhoneNumber()).isEqualTo("0123456789");
            verify(userRepository).save(user);
        }

        @Test
        @DisplayName("Update with avatar: deletes old avatar if present and uploads new")
        void shouldUpdateProfile_WithAvatar() throws Exception {
            user.setAvatarPublicId("old-avatar-id");
            MockMultipartFile file = new MockMultipartFile("avatarFile", "avatar.png", "image/png", "content".getBytes());
            UpdateProfileRequest request = UpdateProfileRequest.builder()
                    .avatarFile(file)
                    .build();

            CloudinaryResponse cloudResp = CloudinaryResponse.builder()
                    .publicId("new-avatar-id")
                    .secureUrl("http://cloud.com/new.png")
                    .build();

            when(userRepository.findByUsername("john")).thenReturn(Optional.of(user));
            when(cloudinaryService.uploadFile(eq(file), eq("users/avatars"))).thenReturn(cloudResp);
            when(userMapper.toUserResponse(any())).thenReturn(UserResponse.builder().build());

            userService.updateProfile("john", request);

            verify(cloudinaryService).deleteFile("old-avatar-id");
            assertThat(user.getAvatarUrl()).isEqualTo("http://cloud.com/new.png");
            assertThat(user.getAvatarPublicId()).isEqualTo("new-avatar-id");
            verify(userRepository).save(user);
        }

        @Test
        @DisplayName("Upload avatar IOException throws CLOUDINARY_UPLOAD_FAILED")
        void shouldThrow_WhenCloudinaryUploadFails() throws Exception {
            MockMultipartFile file = new MockMultipartFile("avatarFile", "avatar.png", "image/png", "content".getBytes());
            UpdateProfileRequest request = UpdateProfileRequest.builder().avatarFile(file).build();

            when(userRepository.findByUsername("john")).thenReturn(Optional.of(user));
            when(cloudinaryService.uploadFile(any(), any())).thenThrow(new IOException("Network error"));

            assertThatThrownBy(() -> userService.updateProfile("john", request))
                    .isInstanceOf(AppException.class)
                    .hasFieldOrPropertyWithValue("errorCode", ErrorCode.CLOUDINARY_UPLOAD_FAILED);
        }
    }

    @Nested
    @DisplayName("changePassword Tests")
    class ChangePasswordTests {

        @Test
        @DisplayName("Old password mismatch throws OLD_PASSWORD_NOT_MATCH")
        void shouldThrow_WhenOldPasswordWrong() {
            ChangePasswordRequest req = ChangePasswordRequest.builder()
                    .oldPassword("wrong")
                    .newPassword("newPass123")
                    .confirmNewPassword("newPass123")
                    .build();

            when(userRepository.findByUsername("john")).thenReturn(Optional.of(user));
            when(passwordEncoder.matches("wrong", "hashedPass")).thenReturn(false);

            assertThatThrownBy(() -> userService.changePassword("john", req))
                    .isInstanceOf(AppException.class)
                    .hasFieldOrPropertyWithValue("errorCode", ErrorCode.OLD_PASSWORD_NOT_MATCH);
        }

        @Test
        @DisplayName("New password confirmation mismatch throws PASSWORD_NOT_MATCH")
        void shouldThrow_WhenNewPasswordConfirmMismatch() {
            ChangePasswordRequest req = ChangePasswordRequest.builder()
                    .oldPassword("correct")
                    .newPassword("newPass1")
                    .confirmNewPassword("newPass2")
                    .build();

            when(userRepository.findByUsername("john")).thenReturn(Optional.of(user));
            when(passwordEncoder.matches("correct", "hashedPass")).thenReturn(true);

            assertThatThrownBy(() -> userService.changePassword("john", req))
                    .isInstanceOf(AppException.class)
                    .hasFieldOrPropertyWithValue("errorCode", ErrorCode.PASSWORD_NOT_MATCH);
        }

        @Test
        @DisplayName("New password same as old password throws NEW_PASSWORD_SAME_AS_OLD_PASSWORD")
        void shouldThrow_WhenNewPasswordSameAsOld() {
            ChangePasswordRequest req = ChangePasswordRequest.builder()
                    .oldPassword("correct")
                    .newPassword("correct")
                    .confirmNewPassword("correct")
                    .build();

            when(userRepository.findByUsername("john")).thenReturn(Optional.of(user));
            when(passwordEncoder.matches("correct", "hashedPass")).thenReturn(true);

            assertThatThrownBy(() -> userService.changePassword("john", req))
                    .isInstanceOf(AppException.class)
                    .hasFieldOrPropertyWithValue("errorCode", ErrorCode.NEW_PASSWORD_SAME_AS_OLD_PASSWORD);
        }

        @Test
        @DisplayName("Valid change password hashes and saves new password")
        void shouldSucceed_WhenValid() {
            ChangePasswordRequest req = ChangePasswordRequest.builder()
                    .oldPassword("correct")
                    .newPassword("brandNewPass")
                    .confirmNewPassword("brandNewPass")
                    .build();

            when(userRepository.findByUsername("john")).thenReturn(Optional.of(user));
            when(passwordEncoder.matches("correct", "hashedPass")).thenReturn(true);
            when(passwordEncoder.matches("brandNewPass", "hashedPass")).thenReturn(false);
            when(passwordEncoder.encode("brandNewPass")).thenReturn("newHashedPass");

            userService.changePassword("john", req);

            assertThat(user.getPasswordHash()).isEqualTo("newHashedPass");
            verify(userRepository).save(user);
        }
    }

    @Nested
    @DisplayName("getBalance Tests")
    class GetBalanceTests {

        @Test
        @DisplayName("Wallet is null returns ZERO balance")
        void shouldReturnZero_WhenWalletNull() {
            user.setWallet(null);
            when(userRepository.findByUsername("john")).thenReturn(Optional.of(user));

            UserBalanceResponse response = userService.getBalance("john");

            assertThat(response.getBalance()).isEqualTo(BigDecimal.ZERO);
        }

        @Test
        @DisplayName("Wallet has balance returns amount")
        void shouldReturnBalance_WhenWalletPresent() {
            user.setWallet(WalletEntity.builder().balance(BigDecimal.valueOf(150000)).build());
            when(userRepository.findByUsername("john")).thenReturn(Optional.of(user));

            UserBalanceResponse response = userService.getBalance("john");

            assertThat(response.getBalance()).isEqualByComparingTo(BigDecimal.valueOf(150000));
        }
    }
}
