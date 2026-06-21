package com.thanhmila.codelearning.configuration;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Configuration;
import org.springframework.messaging.simp.config.MessageBrokerRegistry;
import org.springframework.web.socket.config.annotation.EnableWebSocketMessageBroker;
import org.springframework.web.socket.config.annotation.StompEndpointRegistry;
import org.springframework.web.socket.config.annotation.WebSocketMessageBrokerConfigurer;


@Configuration
@EnableWebSocketMessageBroker
public class WebSocketConfig implements WebSocketMessageBrokerConfigurer {

    @Value("${websocket.allowed-origins}")
    private String allowedOrigins;

    @Override
    public void registerStompEndpoints(StompEndpointRegistry registry) {
        String[] origins = allowedOrigins.split(",");

        registry.addEndpoint("/ws")
                .setAllowedOrigins(origins) // ✅ Khớp chính xác domain Frontend để trình duyệt cho phép kết nối
                .withSockJS(); // Fallback nếu browser không hỗ trợ WebSocket thuần
    }

    @Override
    public void configureMessageBroker(MessageBrokerRegistry registry) {
        // Tiền tố cho các kênh mà Server sẽ chủ động BẮN data XUỐNG Frontend
        registry.enableSimpleBroker("/topic", "/queue");

        // Tiền tố cho các request mà Frontend gửi LÊN Server (ít dùng trong case này)
        registry.setApplicationDestinationPrefixes("/app");
    }
}