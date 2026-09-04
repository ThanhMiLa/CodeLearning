package com.thanhmila.codelearning.security;

import com.nimbusds.jose.JWSAlgorithm;
import com.nimbusds.jose.JWSHeader;
import com.nimbusds.jose.crypto.MACSigner;
import com.nimbusds.jwt.JWTClaimsSet;
import com.nimbusds.jwt.SignedJWT;
import com.thanhmila.codelearning.dto.request.IntrospectRequest;
import com.thanhmila.codelearning.dto.response.IntrospectResponse;
import com.thanhmila.codelearning.service.auth.AuthenticationService;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;
import org.springframework.security.oauth2.jwt.BadJwtException;
import org.springframework.security.oauth2.jwt.Jwt;
import org.springframework.test.util.ReflectionTestUtils;

import java.nio.charset.StandardCharsets;
import java.util.Date;
import java.util.UUID;

import static org.assertj.core.api.Assertions.assertThat;
import static org.assertj.core.api.Assertions.assertThatThrownBy;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.Mockito.when;

@ExtendWith(MockitoExtension.class)
@DisplayName("CustomJwtDecoder Unit Tests")
class CustomJwtDecoderTest {

    private static final String SIGNER_KEY = "1234567890123456789012345678901234567890123456789012345678901234";

    @Mock
    private AuthenticationService authenticationService;

    @InjectMocks
    private CustomJwtDecoder customJwtDecoder;

    @BeforeEach
    void setUp() {
        ReflectionTestUtils.setField(customJwtDecoder, "signerKey", SIGNER_KEY);
        ReflectionTestUtils.invokeMethod(customJwtDecoder, "init");
    }

    private String generateValidToken() throws Exception {
        JWSHeader header = new JWSHeader(JWSAlgorithm.HS512);
        JWTClaimsSet claimsSet = new JWTClaimsSet.Builder()
                .subject("testuser")
                .issuer("thanhmila.com")
                .issueTime(new Date())
                .expirationTime(new Date(System.currentTimeMillis() + 3600000))
                .jwtID(UUID.randomUUID().toString())
                .build();
        SignedJWT signedJWT = new SignedJWT(header, claimsSet);
        signedJWT.sign(new MACSigner(SIGNER_KEY.getBytes(StandardCharsets.UTF_8)));
        return signedJWT.serialize();
    }

    @Test
    @DisplayName("decode: Given valid signed token, successfully decodes and returns Jwt")
    void decode_ValidToken_ReturnsJwt() throws Exception {
        String token = generateValidToken();

        when(authenticationService.introspect(any(IntrospectRequest.class)))
                .thenReturn(IntrospectResponse.builder().valid(true).build());

        Jwt actualJwt = customJwtDecoder.decode(token);

        assertThat(actualJwt).isNotNull();
        assertThat(actualJwt.getSubject()).isEqualTo("testuser");
    }

    @Test
    @DisplayName("decode: Given invalid token from introspect, throws BadJwtException")
    void decode_InvalidTokenFromIntrospect_ThrowsBadJwtException() {
        String token = "invalid.jwt.token";

        when(authenticationService.introspect(any(IntrospectRequest.class)))
                .thenReturn(IntrospectResponse.builder().valid(false).build());

        assertThatThrownBy(() -> customJwtDecoder.decode(token))
                .isInstanceOf(BadJwtException.class)
                .hasMessage("Token invalid");
    }

    @Test
    @DisplayName("decode: Given authenticationService throws exception, wraps in BadJwtException")
    void decode_IntrospectThrowsException_ThrowsBadJwtException() {
        String token = "error.jwt.token";

        when(authenticationService.introspect(any(IntrospectRequest.class)))
                .thenThrow(new RuntimeException("Redis connection refused"));

        assertThatThrownBy(() -> customJwtDecoder.decode(token))
                .isInstanceOf(BadJwtException.class)
                .hasMessage("Token introspection failed");
    }

    @Test
    @DisplayName("decode: Given introspect valid but token malformed for Nimbus, throws BadJwtException")
    void decode_MalformedToken_ThrowsBadJwtException() {
        String token = "malformed.token.value";

        when(authenticationService.introspect(any(IntrospectRequest.class)))
                .thenReturn(IntrospectResponse.builder().valid(true).build());

        assertThatThrownBy(() -> customJwtDecoder.decode(token))
                .isInstanceOf(BadJwtException.class);
    }
}
