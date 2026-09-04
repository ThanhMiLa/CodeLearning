package com.thanhmila.codelearning.mapper;

import com.thanhmila.codelearning.dto.response.CartItemResponse;
import com.thanhmila.codelearning.dto.response.CartResponse;
import com.thanhmila.codelearning.entity.course.CourseEntity;
import com.thanhmila.codelearning.entity.payment.CartEntity;
import com.thanhmila.codelearning.entity.payment.CartItemEntity;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.springframework.test.util.ReflectionTestUtils;

import java.math.BigDecimal;
import java.util.List;

import static org.assertj.core.api.Assertions.assertThat;

@DisplayName("CartMapper Unit Tests")
class CartMapperTest {

    private CartMapper cartMapper;

    @BeforeEach
    void setUp() {
        cartMapper = new CartMapperImpl();
        ReflectionTestUtils.setField(cartMapper, "courseMapper", new CourseMapperImpl());
    }

    @Test
    @DisplayName("toCartResponse: Ánh xạ CartEntity sang CartResponse kèm danh sách items")
    void toCartResponse_MapsCorrectly() {
        CourseEntity course = CourseEntity.builder()
                .id(10L)
                .title("Spring Cloud")
                .price(new BigDecimal("500000"))
                .build();

        CartItemEntity item = CartItemEntity.builder()
                .id(1L)
                .course(course)
                .build();

        CartEntity cart = CartEntity.builder()
                .id(100L)
                .items(List.of(item))
                .build();

        CartResponse response = cartMapper.toCartResponse(cart);

        assertThat(response).isNotNull();
        assertThat(response.getId()).isEqualTo(100L);
        assertThat(response.getItems()).hasSize(1);
        assertThat(response.getItems().get(0).getCourse().getTitle()).isEqualTo("Spring Cloud");
    }

    @Test
    @DisplayName("toCartItemResponse: Ánh xạ CartItemEntity sang CartItemResponse")
    void toCartItemResponse_MapsCorrectly() {
        CourseEntity course = CourseEntity.builder()
                .id(20L)
                .title("Next.js Pro")
                .price(new BigDecimal("400000"))
                .build();

        CartItemEntity item = CartItemEntity.builder()
                .id(2L)
                .course(course)
                .build();

        CartItemResponse response = cartMapper.toCartItemResponse(item);

        assertThat(response).isNotNull();
        assertThat(response.getId()).isEqualTo(2L);
        assertThat(response.getCourse().getTitle()).isEqualTo("Next.js Pro");
    }
}
