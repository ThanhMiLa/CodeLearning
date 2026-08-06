package com.thanhmila.codelearning.event;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.context.event.EventListener;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.messaging.simp.stomp.StompHeaderAccessor;
import org.springframework.stereotype.Component;
import org.springframework.web.socket.messaging.SessionConnectedEvent;
import org.springframework.web.socket.messaging.SessionDisconnectEvent;

import java.security.Principal;
import org.springframework.security.oauth2.server.resource.authentication.JwtAuthenticationToken;

@Slf4j
@Component
@RequiredArgsConstructor
public class UserPresenceEventListener {

    private final RedisTemplate<String, Object> redisTemplate;
    private static final String ONLINE_USERS_KEY = "active_users";

    @EventListener
    public void handleWebSocketConnectListener(SessionConnectedEvent event) {
        StompHeaderAccessor accessor = StompHeaderAccessor.wrap(event.getMessage());
        Principal user = accessor.getUser();
        if (user != null) {
            String userId = extractUserId(user);
            if (userId != null) {
                redisTemplate.opsForHash().increment(ONLINE_USERS_KEY, userId, 1);
                log.info("User {} connected. Incremented session count.", userId);
            }
        }
    }

    @EventListener
    public void handleWebSocketDisconnectListener(SessionDisconnectEvent event) {
        StompHeaderAccessor accessor = StompHeaderAccessor.wrap(event.getMessage());
        Principal user = accessor.getUser();
        if (user != null) {
            String userId = extractUserId(user);
            if (userId != null) {
                Long remainingSessions = redisTemplate.opsForHash().increment(ONLINE_USERS_KEY, userId, -1);
                
                if (remainingSessions != null && remainingSessions <= 0) {
                    redisTemplate.opsForHash().delete(ONLINE_USERS_KEY, userId);
                    log.info("User {} disconnected completely. Removed from active list.", userId);
                }
            }
        }
    }

    private String extractUserId(Principal principal) {
        if (principal instanceof JwtAuthenticationToken jwtToken) {
            Object userIdObj = jwtToken.getTokenAttributes().get("userId");
            if (userIdObj != null) {
                return String.valueOf(userIdObj);
            }
        }
        // Fallback for non-JWT auth (if any)
        return principal.getName();
    }
}
