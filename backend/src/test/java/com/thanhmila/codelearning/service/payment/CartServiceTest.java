package com.thanhmila.codelearning.service.payment;

import com.thanhmila.codelearning.dto.response.CartResponse;
import com.thanhmila.codelearning.entity.course.CourseEntity;
import com.thanhmila.codelearning.entity.enums.CourseStatus;
import com.thanhmila.codelearning.entity.payment.CartEntity;
import com.thanhmila.codelearning.entity.payment.CartItemEntity;
import com.thanhmila.codelearning.entity.user.UserEntity;
import com.thanhmila.codelearning.exception.AppException;
import com.thanhmila.codelearning.exception.ErrorCode;
import com.thanhmila.codelearning.mapper.CartMapper;
import com.thanhmila.codelearning.repository.course.CourseRepository;
import com.thanhmila.codelearning.repository.course.EnrollmentRepository;
import com.thanhmila.codelearning.repository.payment.CartRepository;
import com.thanhmila.codelearning.repository.user.UserRepository;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Nested;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

import static org.assertj.core.api.Assertions.assertThat;
import static org.assertj.core.api.Assertions.assertThatThrownBy;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.ArgumentMatchers.eq;
import static org.mockito.Mockito.*;

@ExtendWith(MockitoExtension.class)
@DisplayName("CartService Unit Tests")
class CartServiceTest {

    @Mock UserRepository userRepository;
    @Mock CourseRepository courseRepository;
    @Mock EnrollmentRepository enrollmentRepository;
    @Mock CartRepository cartRepository;
    @Mock CartMapper cartMapper;

    @InjectMocks CartService cartService;

    @Nested
    @DisplayName("getOrCreateCart Tests")
    class GetOrCreateCartTests {

        @Test
        @DisplayName("Returns existing cart when present")
        void shouldReturnExistingCart() {
            CartEntity cart = CartEntity.builder().id(1L).items(new ArrayList<>()).build();
            CartResponse expected = CartResponse.builder().id(1L).build();

            when(cartRepository.findByUserIdWithItemsAndCourses(10L)).thenReturn(Optional.of(cart));
            when(cartMapper.toCartResponse(cart)).thenReturn(expected);

            CartResponse actual = cartService.getOrCreateCart(10L);

            assertThat(actual).isEqualTo(expected);
        }

        @Test
        @DisplayName("Creates new cart when not present and user exists")
        void shouldCreateCart_WhenNotPresent() {
            UserEntity user = UserEntity.builder().id(10L).build();
            CartEntity newCart = CartEntity.builder().user(user).items(new ArrayList<>()).build();
            CartResponse expected = CartResponse.builder().id(2L).build();

            when(cartRepository.findByUserIdWithItemsAndCourses(10L)).thenReturn(Optional.empty());
            when(userRepository.findById(10L)).thenReturn(Optional.of(user));
            when(cartRepository.save(any(CartEntity.class))).thenReturn(newCart);
            when(cartMapper.toCartResponse(newCart)).thenReturn(expected);

            CartResponse actual = cartService.getOrCreateCart(10L);

            assertThat(actual).isEqualTo(expected);
            verify(cartRepository).save(any(CartEntity.class));
        }

        @Test
        @DisplayName("Throws USER_NOT_FOUND when user does not exist")
        void shouldThrow_WhenUserNotFound() {
            when(cartRepository.findByUserIdWithItemsAndCourses(10L)).thenReturn(Optional.empty());
            when(userRepository.findById(10L)).thenReturn(Optional.empty());

            assertThatThrownBy(() -> cartService.getOrCreateCart(10L))
                    .isInstanceOf(AppException.class)
                    .hasFieldOrPropertyWithValue("errorCode", ErrorCode.USER_NOT_FOUND);
        }
    }

    @Nested
    @DisplayName("addToCart Tests")
    class AddToCartTests {

        @Test
        @DisplayName("Course not found throws COURSE_NOT_FOUND")
        void shouldThrow_WhenCourseNotFound() {
            CartEntity cart = CartEntity.builder().id(1L).items(new ArrayList<>()).build();
            when(cartRepository.findByUserIdWithItemsAndCourses(10L)).thenReturn(Optional.of(cart));
            when(courseRepository.findById(100L)).thenReturn(Optional.empty());

            assertThatThrownBy(() -> cartService.addToCart(10L, 100L))
                    .isInstanceOf(AppException.class)
                    .hasFieldOrPropertyWithValue("errorCode", ErrorCode.COURSE_NOT_FOUND);
        }

        @Test
        @DisplayName("Inactive course throws COURSE_INACTIVE")
        void shouldThrow_WhenCourseInactive() {
            CartEntity cart = CartEntity.builder().id(1L).items(new ArrayList<>()).build();
            CourseEntity course = CourseEntity.builder().id(100L).status(CourseStatus.DRAFT).build();

            when(cartRepository.findByUserIdWithItemsAndCourses(10L)).thenReturn(Optional.of(cart));
            when(courseRepository.findById(100L)).thenReturn(Optional.of(course));

            assertThatThrownBy(() -> cartService.addToCart(10L, 100L))
                    .isInstanceOf(AppException.class)
                    .hasFieldOrPropertyWithValue("errorCode", ErrorCode.COURSE_INACTIVE);
        }

        @Test
        @DisplayName("Already enrolled throws ALREADY_ENROLLED")
        void shouldThrow_WhenAlreadyEnrolled() {
            CartEntity cart = CartEntity.builder().id(1L).items(new ArrayList<>()).build();
            CourseEntity course = CourseEntity.builder().id(100L).status(CourseStatus.ACTIVE).build();

            when(cartRepository.findByUserIdWithItemsAndCourses(10L)).thenReturn(Optional.of(cart));
            when(courseRepository.findById(100L)).thenReturn(Optional.of(course));
            when(enrollmentRepository.existsByUserIdAndCourseIdAndStatusIn(eq(10L), eq(100L), any())).thenReturn(true);

            assertThatThrownBy(() -> cartService.addToCart(10L, 100L))
                    .isInstanceOf(AppException.class)
                    .hasFieldOrPropertyWithValue("errorCode", ErrorCode.ALREADY_ENROLLED);
        }

        @Test
        @DisplayName("Course already in cart throws COURSE_ALREADY_IN_CART")
        void shouldThrow_WhenCourseAlreadyInCart() {
            CourseEntity course = CourseEntity.builder().id(100L).status(CourseStatus.ACTIVE).build();
            CartItemEntity item = CartItemEntity.builder().course(course).build();
            CartEntity cart = CartEntity.builder().id(1L).items(new ArrayList<>(List.of(item))).build();

            when(cartRepository.findByUserIdWithItemsAndCourses(10L)).thenReturn(Optional.of(cart));
            when(courseRepository.findById(100L)).thenReturn(Optional.of(course));
            when(enrollmentRepository.existsByUserIdAndCourseIdAndStatusIn(eq(10L), eq(100L), any())).thenReturn(false);

            assertThatThrownBy(() -> cartService.addToCart(10L, 100L))
                    .isInstanceOf(AppException.class)
                    .hasFieldOrPropertyWithValue("errorCode", ErrorCode.COURSE_ALREADY_IN_CART);
        }

        @Test
        @DisplayName("Valid addition adds course to cart and saves")
        void shouldAddToCartSuccessfully() {
            CartEntity cart = CartEntity.builder().id(1L).items(new ArrayList<>()).build();
            CourseEntity course = CourseEntity.builder().id(100L).status(CourseStatus.ACTIVE).build();

            when(cartRepository.findByUserIdWithItemsAndCourses(10L)).thenReturn(Optional.of(cart));
            when(courseRepository.findById(100L)).thenReturn(Optional.of(course));
            when(enrollmentRepository.existsByUserIdAndCourseIdAndStatusIn(eq(10L), eq(100L), any())).thenReturn(false);
            when(cartRepository.save(cart)).thenReturn(cart);
            when(cartMapper.toCartResponse(cart)).thenReturn(CartResponse.builder().id(1L).build());

            CartResponse response = cartService.addToCart(10L, 100L);

            assertThat(response).isNotNull();
            assertThat(cart.getItems()).hasSize(1);
            assertThat(cart.getItems().get(0).getCourse()).isEqualTo(course);
        }
    }

    @Nested
    @DisplayName("removeFromCart Tests")
    class RemoveFromCartTests {

        @Test
        @DisplayName("Cart not found throws RESOURCE_NOT_FOUND")
        void shouldThrow_WhenCartNotFound() {
            when(cartRepository.findByUserIdWithItemsAndCourses(10L)).thenReturn(Optional.empty());

            assertThatThrownBy(() -> cartService.removeFromCart(10L, 100L))
                    .isInstanceOf(AppException.class)
                    .hasFieldOrPropertyWithValue("errorCode", ErrorCode.RESOURCE_NOT_FOUND);
        }

        @Test
        @DisplayName("Course not in cart throws RESOURCE_NOT_FOUND")
        void shouldThrow_WhenCourseNotInCart() {
            CartEntity cart = CartEntity.builder().id(1L).items(new ArrayList<>()).build();
            when(cartRepository.findByUserIdWithItemsAndCourses(10L)).thenReturn(Optional.of(cart));

            assertThatThrownBy(() -> cartService.removeFromCart(10L, 100L))
                    .isInstanceOf(AppException.class)
                    .hasFieldOrPropertyWithValue("errorCode", ErrorCode.RESOURCE_NOT_FOUND);
        }

        @Test
        @DisplayName("Removes item and saves cart")
        void shouldRemoveFromCartSuccessfully() {
            CourseEntity course = CourseEntity.builder().id(100L).build();
            CartItemEntity item = CartItemEntity.builder().course(course).build();
            CartEntity cart = CartEntity.builder().id(1L).items(new ArrayList<>(List.of(item))).build();

            when(cartRepository.findByUserIdWithItemsAndCourses(10L)).thenReturn(Optional.of(cart));
            when(cartRepository.save(cart)).thenReturn(cart);
            when(cartMapper.toCartResponse(cart)).thenReturn(CartResponse.builder().id(1L).build());

            CartResponse response = cartService.removeFromCart(10L, 100L);

            assertThat(response).isNotNull();
            assertThat(cart.getItems()).isEmpty();
        }
    }

    @Nested
    @DisplayName("clearCart Tests")
    class ClearCartTests {

        @Test
        @DisplayName("Cart not found throws RESOURCE_NOT_FOUND")
        void shouldThrow_WhenCartNotFound() {
            when(cartRepository.findByUserIdWithItemsAndCourses(10L)).thenReturn(Optional.empty());

            assertThatThrownBy(() -> cartService.clearCart(10L))
                    .isInstanceOf(AppException.class)
                    .hasFieldOrPropertyWithValue("errorCode", ErrorCode.RESOURCE_NOT_FOUND);
        }

        @Test
        @DisplayName("Clears cart and saves")
        void shouldClearCartSuccessfully() {
            CourseEntity course = CourseEntity.builder().id(100L).build();
            CartItemEntity item = CartItemEntity.builder().course(course).build();
            CartEntity cart = CartEntity.builder().id(1L).items(new ArrayList<>(List.of(item))).build();

            when(cartRepository.findByUserIdWithItemsAndCourses(10L)).thenReturn(Optional.of(cart));

            cartService.clearCart(10L);

            assertThat(cart.getItems()).isEmpty();
            verify(cartRepository).save(cart);
        }
    }
}
