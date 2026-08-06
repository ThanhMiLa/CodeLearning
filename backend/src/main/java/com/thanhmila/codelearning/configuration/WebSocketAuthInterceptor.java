package com.thanhmila.codelearning.configuration;

import com.nimbusds.jose.crypto.MACVerifier;
import com.nimbusds.jwt.SignedJWT;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.messaging.Message;
import org.springframework.messaging.MessageChannel;
import org.springframework.messaging.simp.stomp.StompCommand;
import org.springframework.messaging.simp.stomp.StompHeaderAccessor;
import org.springframework.messaging.support.ChannelInterceptor;
import org.springframework.messaging.support.MessageHeaderAccessor;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.stereotype.Component;

import java.util.Collections;

@Slf4j
@Component
@RequiredArgsConstructor
public class WebSocketAuthInterceptor implements ChannelInterceptor {

    @Value("${jwt.signer-key}")
    private String signerKey;

    @Override
    public Message<?> preSend(Message<?> message, MessageChannel channel) {
        StompHeaderAccessor accessor = MessageHeaderAccessor.getAccessor(message, StompHeaderAccessor.class);
        
        if (accessor != null && StompCommand.CONNECT.equals(accessor.getCommand())) {
            String authHeader = accessor.getFirstNativeHeader("Authorization");
            if (authHeader != null && authHeader.startsWith("Bearer ")) {
                String token = authHeader.substring(7);
                try {
                    SignedJWT signedJWT = SignedJWT.parse(token);
                    MACVerifier verifier = new MACVerifier(signerKey.getBytes());
                    if (signedJWT.verify(verifier)) {
                        Long userIdLong = signedJWT.getJWTClaimsSet().getLongClaim("userId");
                        if (userIdLong != null) {
                            UsernamePasswordAuthenticationToken authentication = 
                                    new UsernamePasswordAuthenticationToken(String.valueOf(userIdLong), null, Collections.emptyList());
                            accessor.setUser(authentication);
                        }
                    }
                } catch (Exception e) {
                    log.error("WebSocket JWT Auth failed: {}", e.getMessage());
                }
            }
        }
        return message;
    }
}
