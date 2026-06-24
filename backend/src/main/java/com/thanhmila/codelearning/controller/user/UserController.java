package com.thanhmila.codelearning.controller.user;

import com.thanhmila.codelearning.dto.request.ChangePasswordRequest;
import com.thanhmila.codelearning.dto.request.UpdateProfileRequest;
import com.thanhmila.codelearning.dto.response.ApiResponse;
import com.thanhmila.codelearning.dto.response.CourseProgressResponse;
import com.thanhmila.codelearning.dto.response.UserBalanceResponse;
import com.thanhmila.codelearning.dto.response.UserResponse;
import com.thanhmila.codelearning.service.auth.AuthenticationService;
import com.thanhmila.codelearning.service.user.ProgressService;
import com.thanhmila.codelearning.service.user.UserService;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.validation.Valid;
import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import lombok.experimental.NonFinal;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpHeaders;
import org.springframework.http.ResponseCookie;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.oauth2.jwt.Jwt;
import org.springframework.web.bind.annotation.*;

import java.time.Instant;
import java.util.List;

@Slf4j
@RestController
@RequestMapping("/users")
@RequiredArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE, makeFinal = true)
public class UserController {

        UserService userService;
        AuthenticationService authenticationService;
        ProgressService progressService;

        // ACCESS TOKEN
        @NonFinal
        @Value("${auth.cookie.access-token.name}")
        String accessTokenName;

        @NonFinal
        @Value("${auth.cookie.access-token.secure}")
        boolean isCookieAccessTokenSecure;

        @NonFinal
        @Value("${auth.cookie.access-token.http-only}")
        boolean accessTokenHttpOnly;

        @NonFinal
        @Value("${auth.cookie.access-token.same-site}")
        String accessTokenSameSite;

        @NonFinal
        @Value("${auth.cookie.access-token.path}")
        String accessTokenPath;

        // REFRESH TOKEN
        @NonFinal
        @Value("${auth.cookie.refresh-token.name}")
        String refreshTokenName;

        @NonFinal
        @Value("${auth.cookie.refresh-token.secure}")
        boolean isCookieRefreshTokenSecure;

        @NonFinal
        @Value("${auth.cookie.refresh-token.http-only}")
        boolean refreshTokenHttpOnly;

        @NonFinal
        @Value("${auth.cookie.refresh-token.same-site}")
        String refreshTokenSameSite;

        @NonFinal
        @Value("${auth.cookie.refresh-token.path}")
        String refreshTokenPath;

        @GetMapping("/me")
        @PreAuthorize("hasAuthority('USER_VIEW')")
        public ResponseEntity<ApiResponse<UserResponse>> getMyInfo(
                        @AuthenticationPrincipal Jwt jwt) {
                String username = jwt.getSubject();
                UserResponse result = userService.getMyInfo(username);
                return ResponseEntity.ok(ApiResponse.<UserResponse>builder()
                                .status(200)
                                .code(1000)
                                .message("My information successfully")
                                .result(result)
                                .timestamp(Instant.now().toString())
                                .build());
        }

        @GetMapping("/me/balance")
        @PreAuthorize("hasAuthority('USER_VIEW')")
        public ResponseEntity<ApiResponse<UserBalanceResponse>> getMyBalance(
                        @AuthenticationPrincipal Jwt jwt) {
                String username = jwt.getSubject();
                UserBalanceResponse result = userService.getBalance(username);
                return ResponseEntity.ok(ApiResponse.<UserBalanceResponse>builder()
                                .status(200)
                                .code(1000)
                                .message("Get user balance successfully")
                                .result(result)
                                .timestamp(Instant.now().toString())
                                .build());
        }

        @PatchMapping(value = "/me", consumes = MediaType.MULTIPART_FORM_DATA_VALUE)
        @PreAuthorize("hasAuthority('USER_UPDATE')")
        public ResponseEntity<ApiResponse<UserResponse>> updateProfile(
                        @AuthenticationPrincipal Jwt jwt,
                        @ModelAttribute @Valid UpdateProfileRequest updateProfileRequest) {
                String username = jwt.getSubject();
                UserResponse result = userService.updateProfile(username, updateProfileRequest);
                return ResponseEntity.ok(ApiResponse.<UserResponse>builder()
                                .status(200)
                                .code(1000)
                                .message("Update profile successfully")
                                .result(result)
                                .timestamp(Instant.now().toString())
                                .build());
        }

        @PutMapping("/me/password")
        @PreAuthorize("hasAuthority('USER_UPDATE')")
        public ResponseEntity<ApiResponse<Void>> changePassword(
                        @AuthenticationPrincipal Jwt jwt,
                        @CookieValue(name = "access_token", required = false) String accessToken,
                        @CookieValue(name = "refresh_token", required = false) String refreshToken,
                        HttpServletResponse response,
                        @RequestBody @Valid ChangePasswordRequest changePasswordRequest) {
                String username = jwt.getSubject();
                userService.changePassword(username, changePasswordRequest);
                authenticationService.logout(accessToken, refreshToken);
                clearAuthCookies(response);
                return ResponseEntity.ok(ApiResponse.<Void>builder()
                                .status(200)
                                .code(1000)
                                .message("Password changed successfully. Please login again.")
                                .result(null)
                                .timestamp(Instant.now().toString())
                                .build());
        }

        @GetMapping("/me/progress/courses")
        @PreAuthorize("hasAuthority('LEARNING_PROGRESS_VIEW_OWN')")
        public ResponseEntity<ApiResponse<List<CourseProgressResponse>>> getCourseProgress(
                        @AuthenticationPrincipal Jwt jwt) {
                Long userId = jwt.getClaim("userId");
                var result = progressService.getCourseProgress(userId);
                return ResponseEntity.ok(ApiResponse.<List<CourseProgressResponse>>builder()
                                .status(200)
                                .code(1000)
                                .message("Get course progress successfully")
                                .result(result)
                                .timestamp(Instant.now().toString())
                                .build());
        }

        private void clearAuthCookies(HttpServletResponse response) {
                ResponseCookie clearAccessTokenCookie = ResponseCookie.from(accessTokenName, "")
                                .httpOnly(accessTokenHttpOnly)
                                .secure(isCookieAccessTokenSecure)
                                .path(accessTokenPath)
                                .maxAge(0)
                                .sameSite(accessTokenSameSite)
                                .build();

                ResponseCookie clearRefreshTokenCookie = ResponseCookie.from(refreshTokenName, "")
                                .httpOnly(refreshTokenHttpOnly)
                                .secure(isCookieRefreshTokenSecure)
                                .path(refreshTokenPath)
                                .maxAge(0)
                                .sameSite(refreshTokenSameSite)
                                .build();

                response.addHeader(HttpHeaders.SET_COOKIE, clearAccessTokenCookie.toString());
                response.addHeader(HttpHeaders.SET_COOKIE, clearRefreshTokenCookie.toString());
        }

}
