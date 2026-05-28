package com.thanhmila.codelearning.controller.payment;

import com.thanhmila.codelearning.dto.request.CartItemRequest;
import com.thanhmila.codelearning.dto.response.ApiResponse;
import com.thanhmila.codelearning.dto.response.CartResponse;
import com.thanhmila.codelearning.service.payment.CartService;
import jakarta.validation.Valid;
import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.oauth2.jwt.Jwt;
import org.springframework.web.bind.annotation.*;

import java.time.Instant;

@Slf4j
@RestController
@RequestMapping("/carts")
@RequiredArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE, makeFinal = true)
public class CartController {

    CartService cartService;

    @GetMapping
    public ResponseEntity<ApiResponse<CartResponse>> getCart(@AuthenticationPrincipal Jwt jwt) {
        Long userId = jwt.getClaim("userId");
        CartResponse response = cartService.getOrCreateCart(userId);
        return ResponseEntity.ok(ApiResponse.<CartResponse>builder()
                .status(200)
                .code(1000)
                .message("Cart retrieved successfully")
                .result(response)
                .timestamp(Instant.now().toString())
                .build());
    }

    @PostMapping("/items")
    public ResponseEntity<ApiResponse<CartResponse>> addToCart(
            @AuthenticationPrincipal Jwt jwt,
            @Valid @RequestBody CartItemRequest request) {
        Long userId = jwt.getClaim("userId");
        CartResponse response = cartService.addToCart(userId, request.getCourseId());
        return ResponseEntity.ok(ApiResponse.<CartResponse>builder()
                .status(200)
                .code(1000)
                .message("Course added to cart successfully")
                .result(response)
                .timestamp(Instant.now().toString())
                .build());
    }

    @DeleteMapping("/items/{courseId}")
    public ResponseEntity<ApiResponse<CartResponse>> removeFromCart(
            @AuthenticationPrincipal Jwt jwt,
            @PathVariable Long courseId) {
        Long userId = jwt.getClaim("userId");
        CartResponse response = cartService.removeFromCart(userId, courseId);
        return ResponseEntity.ok(ApiResponse.<CartResponse>builder()
                .status(200)
                .code(1000)
                .message("Course removed from cart successfully")
                .result(response)
                .timestamp(Instant.now().toString())
                .build());
    }

    @DeleteMapping("/items")
    public ResponseEntity<ApiResponse<Void>> clearCart(@AuthenticationPrincipal Jwt jwt) {
        Long userId = jwt.getClaim("userId");
        cartService.clearCart(userId);
        return ResponseEntity.ok(ApiResponse.<Void>builder()
                .status(200)
                .code(1000)
                .message("Cart cleared successfully")
                .timestamp(Instant.now().toString())
                .build());
    }
}
