package com.thanhmila.codelearning.controller.payment;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.thanhmila.codelearning.dto.request.CartItemRequest;
import com.thanhmila.codelearning.dto.response.CartItemResponse;
import com.thanhmila.codelearning.dto.response.CartResponse;
import com.thanhmila.codelearning.dto.response.CourseListItemResponse;
import com.thanhmila.codelearning.security.UserRateLimitInterceptor;
import com.thanhmila.codelearning.service.auth.RateLimitService;
import com.thanhmila.codelearning.service.payment.CartService;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.AutoConfigureMockMvc;
import org.springframework.boot.test.autoconfigure.web.servlet.WebMvcTest;
import org.springframework.boot.test.context.TestConfiguration;
import org.springframework.context.annotation.Import;
import org.springframework.http.MediaType;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.oauth2.jwt.Jwt;
import org.springframework.security.oauth2.server.resource.authentication.JwtAuthenticationToken;
import org.springframework.security.web.method.annotation.AuthenticationPrincipalArgumentResolver;
import org.springframework.test.context.ActiveProfiles;
import org.springframework.test.context.bean.override.mockito.MockitoBean;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.web.method.support.HandlerMethodArgumentResolver;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

import java.math.BigDecimal;
import java.util.List;

import static org.mockito.ArgumentMatchers.any;
import static org.mockito.ArgumentMatchers.eq;
import static org.mockito.Mockito.verify;
import static org.mockito.Mockito.when;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.*;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.jsonPath;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

@WebMvcTest(CartController.class)
@AutoConfigureMockMvc(addFilters = false)
@ActiveProfiles("test")
@Import(CartControllerTest.TestConfig.class)
@DisplayName("CartController WebMvc Slice Tests")
class CartControllerTest {

    @TestConfiguration
    static class TestConfig implements WebMvcConfigurer {
        @Override
        public void addArgumentResolvers(List<HandlerMethodArgumentResolver> resolvers) {
            resolvers.add(new AuthenticationPrincipalArgumentResolver());
        }
    }

    @Autowired
    private MockMvc mockMvc;

    @Autowired
    private ObjectMapper objectMapper;

    @MockitoBean
    private CartService cartService;

    @MockitoBean
    private RateLimitService rateLimitService;

    @MockitoBean
    private UserRateLimitInterceptor userRateLimitInterceptor;

    @BeforeEach
    void setUp() throws Exception {
        when(userRateLimitInterceptor.preHandle(any(), any(), any())).thenReturn(true);
    }

    @AfterEach
    void tearDown() {
        SecurityContextHolder.clearContext();
    }

    private void authenticate(String username, Long userId) {
        Jwt jwt = Jwt.withTokenValue("mock-jwt-token")
                .header("alg", "none")
                .subject(username)
                .claim("userId", userId)
                .build();
        SecurityContextHolder.getContext().setAuthentication(
                new JwtAuthenticationToken(jwt, List.of(new SimpleGrantedAuthority("USER")), username)
        );
    }

    @Test
    @DisplayName("GET /carts: Lấy giỏ hàng thành công trả về HTTP 200")
    void getCart_Success_ReturnsHttp200() throws Exception {
        authenticate("student", 10L);

        CartResponse response = CartResponse.builder()
                .id(1L)
                .items(List.of())
                .build();

        when(cartService.getOrCreateCart(10L)).thenReturn(response);

        mockMvc.perform(get("/carts"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.code").value(1000))
                .andExpect(jsonPath("$.result.id").value(1));
    }

    @Test
    @DisplayName("POST /carts/items: Thêm khóa học vào giỏ hàng thành công")
    void addToCart_Success_ReturnsHttp200() throws Exception {
        authenticate("student", 10L);

        CartItemRequest request = CartItemRequest.builder()
                .courseId(5L)
                .build();

        CourseListItemResponse courseResponse = CourseListItemResponse.builder()
                .id(5L)
                .title("Java Core")
                .price(new BigDecimal("200000"))
                .build();

        CartItemResponse itemResponse = CartItemResponse.builder()
                .id(1L)
                .course(courseResponse)
                .build();

        CartResponse cartResponse = CartResponse.builder()
                .id(1L)
                .items(List.of(itemResponse))
                .build();

        when(cartService.addToCart(10L, 5L)).thenReturn(cartResponse);

        mockMvc.perform(post("/carts/items")
                        .contentType(MediaType.APPLICATION_JSON)
                        .content(objectMapper.writeValueAsString(request)))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.code").value(1000))
                .andExpect(jsonPath("$.result.items[0].course.id").value(5));
    }

    @Test
    @DisplayName("DELETE /carts/items/{courseId}: Xóa khóa học khỏi giỏ hàng thành công")
    void removeFromCart_Success_ReturnsHttp200() throws Exception {
        authenticate("student", 10L);

        CartResponse cartResponse = CartResponse.builder()
                .id(1L)
                .items(List.of())
                .build();

        when(cartService.removeFromCart(10L, 5L)).thenReturn(cartResponse);

        mockMvc.perform(delete("/carts/items/{courseId}", 5L))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.code").value(1000));
    }

    @Test
    @DisplayName("DELETE /carts/items: Xóa rỗng giỏ hàng thành công")
    void clearCart_Success_ReturnsHttp200() throws Exception {
        authenticate("student", 10L);

        mockMvc.perform(delete("/carts/items"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.code").value(1000))
                .andExpect(jsonPath("$.message").value("Cart cleared successfully"));

        verify(cartService).clearCart(10L);
    }
}
