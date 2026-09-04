package com.thanhmila.codelearning.service.auth;

import com.nimbusds.jose.JWSAlgorithm;
import com.nimbusds.jose.JWSHeader;
import com.nimbusds.jose.crypto.MACSigner;
import com.nimbusds.jwt.JWTClaimsSet;
import com.nimbusds.jwt.SignedJWT;
import com.thanhmila.codelearning.dto.request.AuthenticationRequest;
import com.thanhmila.codelearning.dto.request.IntrospectRequest;
import com.thanhmila.codelearning.dto.request.RegisterRequest;
import com.thanhmila.codelearning.dto.response.AuthenticationResponse;
import com.thanhmila.codelearning.dto.response.IntrospectResponse;
import com.thanhmila.codelearning.entity.auth.RoleEntity;
import com.thanhmila.codelearning.entity.enums.UserStatus;
import com.thanhmila.codelearning.entity.user.UserEntity;
import com.thanhmila.codelearning.exception.AppException;
import com.thanhmila.codelearning.exception.ErrorCode;
import com.thanhmila.codelearning.mapper.UserMapper;
import com.thanhmila.codelearning.repository.auth.InvalidatedTokenRepository;
import com.thanhmila.codelearning.repository.auth.RoleRepository;
import com.thanhmila.codelearning.repository.user.UserOauthAccountRepository;
import com.thanhmila.codelearning.repository.user.UserRepository;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Nested;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;
import org.springframework.context.ApplicationEventPublisher;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.test.util.ReflectionTestUtils;

import java.util.Collections;
import java.util.Date;
import java.util.Optional;
import java.util.Set;
import java.util.UUID;

import static org.assertj.core.api.Assertions.assertThat;
import static org.assertj.core.api.Assertions.assertThatThrownBy;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.Mockito.*;

@ExtendWith(MockitoExtension.class)
@DisplayName("AuthenticationService Unit Tests")
class AuthenticationServiceTest {

    @Mock UserRepository userRepository;
    @Mock PasswordEncoder passwordEncoder;
    @Mock RoleRepository roleRepository;
    @Mock InvalidatedTokenRepository invalidatedTokenRepository;
    @Mock ApplicationEventPublisher applicationEventPublisher;
    @Mock UserMapper userMapper;
    @Mock UserOauthAccountRepository userOauthAccountRepository;

    @InjectMocks AuthenticationService authService;

    private final String SIGNER_KEY = "1234567890123456789012345678901212345678901234567890123456789012"; // 64 bytes for HS512

    @BeforeEach
    void setUp() {
        ReflectionTestUtils.setField(authService, "SIGNER_KEY", SIGNER_KEY);
        ReflectionTestUtils.setField(authService, "VALID_DURATION", 3600L);
        ReflectionTestUtils.setField(authService, "REFRESHABLE_DURATION", 86400L);
        ReflectionTestUtils.setField(authService, "googleClientId", "test-client-id");
    }

    private String createTestToken(String username, String jti, Date expiry, String type, String secret) throws Exception {
        JWTClaimsSet claims = new JWTClaimsSet.Builder()
                .subject(username)
                .jwtID(jti != null ? jti : UUID.randomUUID().toString())
                .expirationTime(expiry)
                .claim("type", type)
                .claim("userId", 1L)
                .build();
        SignedJWT signedJWT = new SignedJWT(new JWSHeader(JWSAlgorithm.HS512), claims);
        signedJWT.sign(new MACSigner(secret.getBytes()));
        return signedJWT.serialize();
    }

    @Nested
    @DisplayName("login Tests")
    class LoginTests {

        @Test
        @DisplayName("User not found throws INVALID_USERNAME_OR_PASSWORD")
        void shouldThrow_WhenUserNotFound() {
            when(userRepository.findByUsernameWithWallet("unknown")).thenReturn(Optional.empty());

            assertThatThrownBy(() -> authService.login(new AuthenticationRequest("unknown", "pass")))
                    .isInstanceOf(AppException.class)
                    .hasFieldOrPropertyWithValue("errorCode", ErrorCode.INVALID_USERNAME_OR_PASSWORD);
        }

        @Test
        @DisplayName("Password mismatch throws INVALID_USERNAME_OR_PASSWORD")
        void shouldThrow_WhenPasswordMismatch() {
            UserEntity user = UserEntity.builder().username("john").passwordHash("hashed").status(UserStatus.ACTIVE).build();
            when(userRepository.findByUsernameWithWallet("john")).thenReturn(Optional.of(user));
            when(passwordEncoder.matches("wrong", "hashed")).thenReturn(false);

            assertThatThrownBy(() -> authService.login(new AuthenticationRequest("john", "wrong")))
                    .isInstanceOf(AppException.class)
                    .hasFieldOrPropertyWithValue("errorCode", ErrorCode.INVALID_USERNAME_OR_PASSWORD);
        }

        @Test
        @DisplayName("User LOCKED throws ACCOUNT_LOCKED")
        void shouldThrow_WhenUserLocked() {
            UserEntity user = UserEntity.builder().username("john").passwordHash("hashed").status(UserStatus.LOCKED).build();
            when(userRepository.findByUsernameWithWallet("john")).thenReturn(Optional.of(user));
            when(passwordEncoder.matches("pass", "hashed")).thenReturn(true);

            assertThatThrownBy(() -> authService.login(new AuthenticationRequest("john", "pass")))
                    .isInstanceOf(AppException.class)
                    .hasFieldOrPropertyWithValue("errorCode", ErrorCode.ACCOUNT_LOCKED);
        }

        @Test
        @DisplayName("User DISABLED throws ACCOUNT_DISABLED")
        void shouldThrow_WhenUserDisabled() {
            UserEntity user = UserEntity.builder().username("john").passwordHash("hashed").status(UserStatus.DISABLED).build();
            when(userRepository.findByUsernameWithWallet("john")).thenReturn(Optional.of(user));
            when(passwordEncoder.matches("pass", "hashed")).thenReturn(true);

            assertThatThrownBy(() -> authService.login(new AuthenticationRequest("john", "pass")))
                    .isInstanceOf(AppException.class)
                    .hasFieldOrPropertyWithValue("errorCode", ErrorCode.ACCOUNT_DISABLED);
        }

        @Test
        @DisplayName("Valid credentials return tokens")
        void shouldSucceed_WhenValidCredentials() {
            RoleEntity role = RoleEntity.builder().name("USER").permissions(Collections.emptySet()).build();
            UserEntity user = UserEntity.builder()
                    .id(1L)
                    .username("john")
                    .passwordHash("hashed")
                    .status(UserStatus.ACTIVE)
                    .roles(Set.of(role))
                    .build();

            when(userRepository.findByUsernameWithWallet("john")).thenReturn(Optional.of(user));
            when(passwordEncoder.matches("pass", "hashed")).thenReturn(true);
            when(userMapper.toAuthenticationResponse(any())).thenReturn(AuthenticationResponse.builder().build());

            AuthenticationResponse response = authService.login(new AuthenticationRequest("john", "pass"));

            assertThat(response).isNotNull();
            assertThat(response.getAccessToken()).isNotBlank();
            assertThat(response.getRefreshToken()).isNotBlank();
        }
    }

    @Nested
    @DisplayName("register Tests")
    class RegisterTests {

        @Test
        @DisplayName("Username already exists throws USERNAME_ALREADY_EXISTS")
        void shouldThrow_WhenUsernameExists() {
            RegisterRequest request = RegisterRequest.builder().username("existing").build();
            when(userRepository.existsByUsername("existing")).thenReturn(true);

            assertThatThrownBy(() -> authService.register(request))
                    .isInstanceOf(AppException.class)
                    .hasFieldOrPropertyWithValue("errorCode", ErrorCode.USERNAME_ALREADY_EXISTS);
        }

        @Test
        @DisplayName("Password mismatch throws PASSWORD_NOT_MATCH")
        void shouldThrow_WhenPasswordNotMatch() {
            RegisterRequest request = RegisterRequest.builder()
                    .username("newuser")
                    .password("pass1")
                    .confirmPassword("pass2")
                    .build();
            when(userRepository.existsByUsername("newuser")).thenReturn(false);

            assertThatThrownBy(() -> authService.register(request))
                    .isInstanceOf(AppException.class)
                    .hasFieldOrPropertyWithValue("errorCode", ErrorCode.PASSWORD_NOT_MATCH);
        }

        @Test
        @DisplayName("Email already exists throws EMAIL_ALREADY_EXISTS")
        void shouldThrow_WhenEmailExists() {
            RegisterRequest request = RegisterRequest.builder()
                    .username("newuser")
                    .password("pass1")
                    .confirmPassword("pass1")
                    .email("existing@mail.com")
                    .build();
            when(userRepository.existsByUsername("newuser")).thenReturn(false);
            when(userRepository.existsByEmail("existing@mail.com")).thenReturn(true);

            assertThatThrownBy(() -> authService.register(request))
                    .isInstanceOf(AppException.class)
                    .hasFieldOrPropertyWithValue("errorCode", ErrorCode.EMAIL_ALREADY_EXISTS);
        }

        @Test
        @DisplayName("Valid register saves user, publishes event and logs in")
        void shouldSucceed_WhenValidRegister() {
            RegisterRequest request = RegisterRequest.builder()
                    .username("newuser")
                    .password("pass1")
                    .confirmPassword("pass1")
                    .email("new@mail.com")
                    .build();

            UserEntity mappedUser = new UserEntity();
            mappedUser.setUsername("newuser");
            mappedUser.setStatus(UserStatus.ACTIVE);

            RoleEntity role = RoleEntity.builder().name("USER").permissions(Collections.emptySet()).build();

            when(userRepository.existsByUsername("newuser")).thenReturn(false);
            when(userRepository.existsByEmail("new@mail.com")).thenReturn(false);
            when(userMapper.toUserEntity(request)).thenReturn(mappedUser);
            when(passwordEncoder.encode("pass1")).thenReturn("hashedPass1");
            when(roleRepository.findByName("USER")).thenReturn(role);
            when(userRepository.save(any())).thenAnswer(inv -> inv.getArgument(0));

            // login mock
            when(userRepository.findByUsernameWithWallet("newuser")).thenReturn(Optional.of(mappedUser));
            when(passwordEncoder.matches("pass1", "hashedPass1")).thenReturn(true);
            when(userMapper.toAuthenticationResponse(any())).thenReturn(AuthenticationResponse.builder().build());

            AuthenticationResponse response = authService.register(request);

            assertThat(response).isNotNull();
            assertThat(response.getAccessToken()).isNotBlank();
            verify(applicationEventPublisher).publishEvent(any(Object.class));
        }
    }

    @Nested
    @DisplayName("introspect Tests")
    class IntrospectTests {

        @Test
        @DisplayName("Valid token returns active true")
        void shouldReturnTrue_WhenTokenValid() throws Exception {
            String token = createTestToken("john", "jti-1", new Date(System.currentTimeMillis() + 60000), "ACCESS", SIGNER_KEY);
            when(invalidatedTokenRepository.existsByTokenJti("jti-1")).thenReturn(false);

            IntrospectResponse response = authService.introspect(new IntrospectRequest(token));

            assertThat(response.isValid()).isTrue();
        }

        @Test
        @DisplayName("Invalid token returns active false")
        void shouldReturnFalse_WhenTokenInvalid() {
            IntrospectResponse response = authService.introspect(new IntrospectRequest("invalid-token-string"));

            assertThat(response.isValid()).isFalse();
        }
    }

    @Nested
    @DisplayName("refresh Tests")
    class RefreshTests {

        @Test
        @DisplayName("Token in blacklist throws UNAUTHENTICATED")
        void shouldThrow_WhenTokenBlacklisted() throws Exception {
            String token = createTestToken("john", "jti-blacklisted", new Date(System.currentTimeMillis() + 60000), "REFRESH", SIGNER_KEY);
            when(invalidatedTokenRepository.existsByTokenJti("jti-blacklisted")).thenReturn(true);

            assertThatThrownBy(() -> authService.refresh(token))
                    .isInstanceOf(AppException.class)
                    .hasFieldOrPropertyWithValue("errorCode", ErrorCode.UNAUTHENTICATED);
        }

        @Test
        @DisplayName("Token type not REFRESH throws INVALID_TOKEN")
        void shouldThrow_WhenTypeNotRefresh() throws Exception {
            String token = createTestToken("john", "jti-scope", new Date(System.currentTimeMillis() + 60000), "ACCESS", SIGNER_KEY);
            when(invalidatedTokenRepository.existsByTokenJti("jti-scope")).thenReturn(false);

            assertThatThrownBy(() -> authService.refresh(token))
                    .isInstanceOf(AppException.class)
                    .hasFieldOrPropertyWithValue("errorCode", ErrorCode.INVALID_TOKEN);
        }

        @Test
        @DisplayName("Valid refresh token blacklists old token and issues new pair")
        void shouldSucceed_WhenValidRefreshToken() throws Exception {
            String token = createTestToken("john", "jti-valid", new Date(System.currentTimeMillis() + 60000), "REFRESH", SIGNER_KEY);
            RoleEntity role = RoleEntity.builder().name("USER").permissions(Collections.emptySet()).build();
            UserEntity user = UserEntity.builder()
                    .id(1L)
                    .username("john")
                    .status(UserStatus.ACTIVE)
                    .roles(Set.of(role))
                    .build();

            when(invalidatedTokenRepository.existsByTokenJti("jti-valid")).thenReturn(false);
            when(userRepository.findByUsernameWithWallet("john")).thenReturn(Optional.of(user));
            when(userMapper.toAuthenticationResponse(any())).thenReturn(AuthenticationResponse.builder().build());

            AuthenticationResponse response = authService.refresh(token);

            assertThat(response).isNotNull();
            assertThat(response.getAccessToken()).isNotBlank();
            assertThat(response.getRefreshToken()).isNotBlank();
            verify(invalidatedTokenRepository).save(any());
        }
    }

    @Nested
    @DisplayName("logout Tests")
    class LogoutTests {

        @Test
        @DisplayName("Logout invalidates access and refresh tokens in repository")
        void shouldInvalidateTokens_OnLogout() throws Exception {
            String access = createTestToken("john", "jti-access", new Date(System.currentTimeMillis() + 60000), "ACCESS", SIGNER_KEY);
            String refresh = createTestToken("john", "jti-refresh", new Date(System.currentTimeMillis() + 60000), "REFRESH", SIGNER_KEY);

            authService.logout(access, refresh);

            verify(invalidatedTokenRepository, times(2)).save(any());
        }

        @Test
        @DisplayName("Logout handles null tokens gracefully without throwing")
        void shouldHandleNullTokensGracefully_OnLogout() {
            authService.logout(null, "");
            verify(invalidatedTokenRepository, never()).save(any());
        }
    }
}
