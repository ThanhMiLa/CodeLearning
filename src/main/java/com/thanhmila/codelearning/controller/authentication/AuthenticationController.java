package com.thanhmila.codelearning.controller.authentication;

import com.thanhmila.codelearning.dto.request.AuthenticationRequest;
import com.thanhmila.codelearning.dto.response.ApiResponse;
import com.thanhmila.codelearning.dto.response.AuthenticationResponse;
import com.thanhmila.codelearning.service.AuthenticationService;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import lombok.experimental.NonFinal;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpHeaders;
import org.springframework.http.ResponseCookie;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.time.Instant;

@Slf4j
@RestController
@RequestMapping("/auth")
@RequiredArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE, makeFinal = true)
public class AuthenticationController {

    AuthenticationService authenticationService;

    // ACCESS TOKEN
    @NonFinal
    @Value("${auth.cookie.access-token.name}")
    String accessTokenName;

    @NonFinal
    @Value("${auth.cookie.access-token.secure}")
    boolean isCookieAccessTokenSecure;

    @NonFinal
    @Value("${auth.cookie.access-token.max-age}")
    long accessTokenMaxAge;

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
    @Value("${auth.cookie.refresh-token.max-age}")
    long refreshTokenMaxAge;

    @NonFinal
    @Value("${auth.cookie.refresh-token.http-only}")
    boolean refreshTokenHttpOnly;

    @NonFinal
    @Value("${auth.cookie.refresh-token.same-site}")
    String refreshTokenSameSite;

    @NonFinal
    @Value("${auth.cookie.refresh-token.path}")
    String refreshTokenPath;


    @PostMapping("/login")
    public ResponseEntity<ApiResponse<AuthenticationResponse>> login(
            @RequestBody AuthenticationRequest authenticationRequest, HttpServletResponse response){

        AuthenticationResponse result = authenticationService.login(authenticationRequest);

        ResponseCookie accessTokenCookie = ResponseCookie.from(accessTokenName, result.getAccessToken())
                .httpOnly(accessTokenHttpOnly)
                .secure(isCookieAccessTokenSecure)
                .path(accessTokenPath)
                .maxAge(accessTokenMaxAge)
                .sameSite(accessTokenSameSite)
                .build();

        ResponseCookie refreshTokenCookie = ResponseCookie.from(refreshTokenName, result.getRefreshToken())
                .httpOnly(refreshTokenHttpOnly)
                .secure(isCookieRefreshTokenSecure)
                .path(refreshTokenPath)
                .maxAge(refreshTokenMaxAge)
                .sameSite(refreshTokenSameSite)
                .build();

        result.setAccessToken(null);
        result.setRefreshToken(null);

        response.addHeader(HttpHeaders.SET_COOKIE, accessTokenCookie.toString());
        response.addHeader(HttpHeaders.SET_COOKIE, refreshTokenCookie.toString());

        return ResponseEntity.ok(ApiResponse.<AuthenticationResponse>builder()
                .status(200)
                .code(1000)
                .message("Success")
                .result(result)
                .timestamp(Instant.now().toString())
                .build());
    }
}
