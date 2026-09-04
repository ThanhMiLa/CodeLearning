package com.thanhmila.codelearning.configuration;

import com.nimbusds.jose.JWSAlgorithm;
import com.nimbusds.jose.JWSHeader;
import com.nimbusds.jose.crypto.MACSigner;
import com.nimbusds.jwt.JWTClaimsSet;
import com.nimbusds.jwt.SignedJWT;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.springframework.messaging.Message;
import org.springframework.messaging.MessageChannel;
import org.springframework.messaging.simp.stomp.StompCommand;
import org.springframework.messaging.simp.stomp.StompHeaderAccessor;
import org.springframework.messaging.support.MessageBuilder;
import org.springframework.messaging.support.MessageHeaderAccessor;
import org.springframework.test.util.ReflectionTestUtils;

import java.security.Principal;

import static org.assertj.core.api.Assertions.assertThat;
import static org.mockito.Mockito.mock;

@DisplayName("WebSocketAuthInterceptor Unit Tests")
class WebSocketAuthInterceptorTest {

    private WebSocketAuthInterceptor interceptor;
    private final String testSecret = "1234567890123456789012345678901234567890123456789012345678901234";

    @BeforeEach
    void setUp() {
        interceptor = new WebSocketAuthInterceptor();
        ReflectionTestUtils.setField(interceptor, "signerKey", testSecret);
    }

    @Test
    @DisplayName("preSend: Khi không phải lệnh CONNECT, trả về message mà không xử lý auth")
    void preSend_NonConnectCommand_DoesNothing() {
        StompHeaderAccessor accessor = StompHeaderAccessor.create(StompCommand.SUBSCRIBE);
        Message<byte[]> message = MessageBuilder.createMessage(new byte[0], accessor.getMessageHeaders());
        MessageChannel channel = mock(MessageChannel.class);

        Message<?> result = interceptor.preSend(message, channel);

        StompHeaderAccessor resAccessor = MessageHeaderAccessor.getAccessor(result, StompHeaderAccessor.class);
        assertThat(resAccessor).isNotNull();
        assertThat(resAccessor.getUser()).isNull();
    }

    @Test
    @DisplayName("preSend: CONNECT thiếu header Authorization thì không gán user")
    void preSend_ConnectWithoutAuthHeader_DoesNotSetUser() {
        StompHeaderAccessor accessor = StompHeaderAccessor.create(StompCommand.CONNECT);
        Message<byte[]> message = MessageBuilder.createMessage(new byte[0], accessor.getMessageHeaders());
        MessageChannel channel = mock(MessageChannel.class);

        Message<?> result = interceptor.preSend(message, channel);

        StompHeaderAccessor resAccessor = MessageHeaderAccessor.getAccessor(result, StompHeaderAccessor.class);
        assertThat(resAccessor).isNotNull();
        assertThat(resAccessor.getUser()).isNull();
    }

    @Test
    @DisplayName("preSend: CONNECT có token giả mạo/không hợp lệ thì không gán user")
    void preSend_ConnectWithInvalidToken_DoesNotSetUser() {
        StompHeaderAccessor accessor = StompHeaderAccessor.create(StompCommand.CONNECT);
        accessor.setNativeHeader("Authorization", "Bearer invalid-jwt-token");
        Message<byte[]> message = MessageBuilder.createMessage(new byte[0], accessor.getMessageHeaders());
        MessageChannel channel = mock(MessageChannel.class);

        Message<?> result = interceptor.preSend(message, channel);

        StompHeaderAccessor resAccessor = MessageHeaderAccessor.getAccessor(result, StompHeaderAccessor.class);
        assertThat(resAccessor).isNotNull();
        assertThat(resAccessor.getUser()).isNull();
    }

    @Test
    @DisplayName("preSend: CONNECT có Bearer token hợp lệ thì gán UsernamePasswordAuthenticationToken vào accessor")
    void preSend_ConnectWithValidToken_SetsUser() throws Exception {
        JWSHeader header = new JWSHeader(JWSAlgorithm.HS512);
        JWTClaimsSet claims = new JWTClaimsSet.Builder()
                .claim("userId", 88L)
                .build();
        SignedJWT signedJWT = new SignedJWT(header, claims);
        signedJWT.sign(new MACSigner(testSecret.getBytes()));
        String validToken = signedJWT.serialize();

        StompHeaderAccessor accessor = StompHeaderAccessor.create(StompCommand.CONNECT);
        accessor.setNativeHeader("Authorization", "Bearer " + validToken);
        accessor.setLeaveMutable(true);
        Message<byte[]> message = MessageBuilder.createMessage(new byte[0], accessor.getMessageHeaders());
        MessageChannel channel = mock(MessageChannel.class);

        Message<?> result = interceptor.preSend(message, channel);

        StompHeaderAccessor resAccessor = MessageHeaderAccessor.getAccessor(result, StompHeaderAccessor.class);
        assertThat(resAccessor).isNotNull();
        Principal user = resAccessor.getUser();
        assertThat(user).isNotNull();
        assertThat(user.getName()).isEqualTo("88");
    }
}
