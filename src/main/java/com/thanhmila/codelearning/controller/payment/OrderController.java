package com.thanhmila.codelearning.controller.payment;

import com.thanhmila.codelearning.dto.request.OrderCheckoutRequest;
import com.thanhmila.codelearning.dto.response.ApiResponse;
import com.thanhmila.codelearning.dto.response.OrderCheckoutResponse;
import com.thanhmila.codelearning.service.payment.OrderService;
import jakarta.validation.Valid;
import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.oauth2.jwt.Jwt;
import org.springframework.web.bind.annotation.*;

import java.time.Instant;

@Slf4j
@RestController
@RequestMapping("/orders")
@RequiredArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE, makeFinal = true)
public class OrderController {

    OrderService orderService;

    @PostMapping("/checkout")
    public ResponseEntity<ApiResponse<OrderCheckoutResponse>> checkout(
            @AuthenticationPrincipal Jwt jwt,
            @Valid @RequestBody OrderCheckoutRequest request) {

        Long userId = jwt.getClaim("userId");
        log.info("User {} is checking out courses: {}", userId, request.getCourseIds());
        
        OrderCheckoutResponse response = orderService.createCheckout(userId, request);

        return ResponseEntity.ok(ApiResponse.<OrderCheckoutResponse>builder()
                .status(200)
                .code(1000)
                .message("Order checkout completed successfully")
                .result(response)
                .timestamp(Instant.now().toString())
                .build());
    }
}
