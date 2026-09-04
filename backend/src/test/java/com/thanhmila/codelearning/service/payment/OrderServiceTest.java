package com.thanhmila.codelearning.service.payment;

import com.thanhmila.codelearning.dto.request.OrderCheckoutRequest;
import com.thanhmila.codelearning.dto.response.OrderCheckoutResponse;
import com.thanhmila.codelearning.entity.course.CourseEntity;
import com.thanhmila.codelearning.entity.enums.CourseStatus;
import com.thanhmila.codelearning.entity.enums.OrderStatus;
import com.thanhmila.codelearning.entity.enums.UserStatus;
import com.thanhmila.codelearning.entity.payment.OrderEntity;
import com.thanhmila.codelearning.entity.payment.WalletEntity;
import com.thanhmila.codelearning.entity.user.UserEntity;
import com.thanhmila.codelearning.exception.AppException;
import com.thanhmila.codelearning.exception.ErrorCode;
import com.thanhmila.codelearning.repository.course.CourseRepository;
import com.thanhmila.codelearning.repository.course.EnrollmentRepository;
import com.thanhmila.codelearning.repository.payment.OrderRepository;
import com.thanhmila.codelearning.repository.payment.WalletRepository;
import com.thanhmila.codelearning.repository.payment.WalletTransactionRepository;
import com.thanhmila.codelearning.repository.user.UserRepository;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Nested;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;

import java.math.BigDecimal;
import java.util.Collections;
import java.util.List;
import java.util.Optional;
import java.util.Set;

import static org.assertj.core.api.Assertions.assertThat;
import static org.assertj.core.api.Assertions.assertThatThrownBy;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.ArgumentMatchers.eq;
import static org.mockito.Mockito.*;

@ExtendWith(MockitoExtension.class)
@DisplayName("OrderService Unit Tests")
class OrderServiceTest {

    @Mock UserRepository userRepository;
    @Mock CourseRepository courseRepository;
    @Mock EnrollmentRepository enrollmentRepository;
    @Mock WalletRepository walletRepository;
    @Mock WalletTransactionRepository walletTransactionRepository;
    @Mock OrderRepository orderRepository;

    @InjectMocks OrderService orderService;

    @Nested
    @DisplayName("createCheckout Tests")
    class CreateCheckoutTests {

        @Test
        @DisplayName("Empty course IDs throws INVALID_REQUEST")
        void shouldThrow_WhenCourseIdsEmpty() {
            OrderCheckoutRequest request = OrderCheckoutRequest.builder().courseIds(Collections.emptyList()).build();

            assertThatThrownBy(() -> orderService.createCheckout(1L, request))
                    .isInstanceOf(AppException.class)
                    .hasFieldOrPropertyWithValue("errorCode", ErrorCode.INVALID_REQUEST);
        }

        @Test
        @DisplayName("User not found throws USER_NOT_FOUND")
        void shouldThrow_WhenUserNotFound() {
            OrderCheckoutRequest request = OrderCheckoutRequest.builder().courseIds(List.of(100L)).build();
            when(userRepository.findById(1L)).thenReturn(Optional.empty());

            assertThatThrownBy(() -> orderService.createCheckout(1L, request))
                    .isInstanceOf(AppException.class)
                    .hasFieldOrPropertyWithValue("errorCode", ErrorCode.USER_NOT_FOUND);
        }

        @Test
        @DisplayName("User locked throws ACCOUNT_LOCKED")
        void shouldThrow_WhenUserLocked() {
            OrderCheckoutRequest request = OrderCheckoutRequest.builder().courseIds(List.of(100L)).build();
            UserEntity user = UserEntity.builder().id(1L).status(UserStatus.LOCKED).build();
            when(userRepository.findById(1L)).thenReturn(Optional.of(user));

            assertThatThrownBy(() -> orderService.createCheckout(1L, request))
                    .isInstanceOf(AppException.class)
                    .hasFieldOrPropertyWithValue("errorCode", ErrorCode.ACCOUNT_LOCKED);
        }

        @Test
        @DisplayName("Course count mismatch throws COURSE_NOT_FOUND")
        void shouldThrow_WhenSomeCoursesNotFound() {
            OrderCheckoutRequest request = OrderCheckoutRequest.builder().courseIds(List.of(100L, 200L)).build();
            UserEntity user = UserEntity.builder().id(1L).status(UserStatus.ACTIVE).build();

            when(userRepository.findById(1L)).thenReturn(Optional.of(user));
            when(courseRepository.findAllById(request.getCourseIds())).thenReturn(List.of(new CourseEntity())); // 1 returned instead of 2

            assertThatThrownBy(() -> orderService.createCheckout(1L, request))
                    .isInstanceOf(AppException.class)
                    .hasFieldOrPropertyWithValue("errorCode", ErrorCode.COURSE_NOT_FOUND);
        }

        @Test
        @DisplayName("Inactive course in checkout throws COURSE_INACTIVE")
        void shouldThrow_WhenCourseInactive() {
            OrderCheckoutRequest request = OrderCheckoutRequest.builder().courseIds(List.of(100L)).build();
            UserEntity user = UserEntity.builder().id(1L).status(UserStatus.ACTIVE).build();
            CourseEntity course = CourseEntity.builder().id(100L).status(CourseStatus.DRAFT).build();

            when(userRepository.findById(1L)).thenReturn(Optional.of(user));
            when(courseRepository.findAllById(request.getCourseIds())).thenReturn(List.of(course));

            assertThatThrownBy(() -> orderService.createCheckout(1L, request))
                    .isInstanceOf(AppException.class)
                    .hasFieldOrPropertyWithValue("errorCode", ErrorCode.COURSE_INACTIVE);
        }

        @Test
        @DisplayName("Already enrolled in course throws ALREADY_ENROLLED")
        void shouldThrow_WhenAlreadyEnrolled() {
            OrderCheckoutRequest request = OrderCheckoutRequest.builder().courseIds(List.of(100L)).build();
            UserEntity user = UserEntity.builder().id(1L).status(UserStatus.ACTIVE).build();
            CourseEntity course = CourseEntity.builder().id(100L).status(CourseStatus.ACTIVE).build();

            when(userRepository.findById(1L)).thenReturn(Optional.of(user));
            when(courseRepository.findAllById(request.getCourseIds())).thenReturn(List.of(course));
            when(enrollmentRepository.findEnrolledCourseIdsByUserIdAndCourseIds(eq(1L), eq(request.getCourseIds()), any()))
                    .thenReturn(Set.of(100L));

            assertThatThrownBy(() -> orderService.createCheckout(1L, request))
                    .isInstanceOf(AppException.class)
                    .hasFieldOrPropertyWithValue("errorCode", ErrorCode.ALREADY_ENROLLED);
        }

        @Test
        @DisplayName("Wallet not found throws RESOURCE_NOT_FOUND")
        void shouldThrow_WhenWalletNotFound() {
            OrderCheckoutRequest request = OrderCheckoutRequest.builder().courseIds(List.of(100L)).build();
            UserEntity user = UserEntity.builder().id(1L).status(UserStatus.ACTIVE).build();
            CourseEntity course = CourseEntity.builder().id(100L).status(CourseStatus.ACTIVE).price(BigDecimal.valueOf(100)).build();

            when(userRepository.findById(1L)).thenReturn(Optional.of(user));
            when(courseRepository.findAllById(request.getCourseIds())).thenReturn(List.of(course));
            when(enrollmentRepository.findEnrolledCourseIdsByUserIdAndCourseIds(eq(1L), eq(request.getCourseIds()), any()))
                    .thenReturn(Collections.emptySet());
            when(walletRepository.findByUserIdWithLock(1L)).thenReturn(Optional.empty());

            assertThatThrownBy(() -> orderService.createCheckout(1L, request))
                    .isInstanceOf(AppException.class)
                    .hasFieldOrPropertyWithValue("errorCode", ErrorCode.RESOURCE_NOT_FOUND);
        }

        @Test
        @DisplayName("Insufficient balance throws INSUFFICIENT_BALANCE")
        void shouldThrow_WhenInsufficientBalance() {
            OrderCheckoutRequest request = OrderCheckoutRequest.builder().courseIds(List.of(100L)).build();
            UserEntity user = UserEntity.builder().id(1L).status(UserStatus.ACTIVE).build();
            CourseEntity course = CourseEntity.builder().id(100L).status(CourseStatus.ACTIVE).price(BigDecimal.valueOf(100)).build();
            WalletEntity wallet = WalletEntity.builder().id(10L).balance(BigDecimal.valueOf(50)).build();

            when(userRepository.findById(1L)).thenReturn(Optional.of(user));
            when(courseRepository.findAllById(request.getCourseIds())).thenReturn(List.of(course));
            when(enrollmentRepository.findEnrolledCourseIdsByUserIdAndCourseIds(eq(1L), eq(request.getCourseIds()), any()))
                    .thenReturn(Collections.emptySet());
            when(walletRepository.findByUserIdWithLock(1L)).thenReturn(Optional.of(wallet));

            assertThatThrownBy(() -> orderService.createCheckout(1L, request))
                    .isInstanceOf(AppException.class)
                    .hasFieldOrPropertyWithValue("errorCode", ErrorCode.INSUFFICIENT_BALANCE);
        }

        @Test
        @DisplayName("Valid checkout deducts wallet balance, creates order and enrolls user")
        void shouldCheckoutSuccessfully() {
            OrderCheckoutRequest request = OrderCheckoutRequest.builder().courseIds(List.of(100L)).build();
            UserEntity user = UserEntity.builder().id(1L).status(UserStatus.ACTIVE).build();
            CourseEntity course = CourseEntity.builder().id(100L).status(CourseStatus.ACTIVE).price(BigDecimal.valueOf(100)).build();
            WalletEntity wallet = WalletEntity.builder().id(10L).balance(BigDecimal.valueOf(250)).build();

            when(userRepository.findById(1L)).thenReturn(Optional.of(user));
            when(courseRepository.findAllById(request.getCourseIds())).thenReturn(List.of(course));
            when(enrollmentRepository.findEnrolledCourseIdsByUserIdAndCourseIds(eq(1L), eq(request.getCourseIds()), any()))
                    .thenReturn(Collections.emptySet());
            when(walletRepository.findByUserIdWithLock(1L)).thenReturn(Optional.of(wallet));
            when(orderRepository.save(any(OrderEntity.class))).thenAnswer(inv -> {
                OrderEntity o = inv.getArgument(0);
                o.setId(999L);
                return o;
            });

            OrderCheckoutResponse response = orderService.createCheckout(1L, request);

            assertThat(response).isNotNull();
            assertThat(response.getOrderId()).isEqualTo(999L);
            assertThat(wallet.getBalance()).isEqualByComparingTo(BigDecimal.valueOf(150));
            verify(walletRepository).save(wallet);
            verify(walletTransactionRepository).save(any());
            verify(enrollmentRepository).saveAll(any());
            verify(courseRepository).incrementTotalEnrolledForCourses(List.of(100L));
        }
    }
}
