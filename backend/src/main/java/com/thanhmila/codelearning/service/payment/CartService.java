package com.thanhmila.codelearning.service.payment;

import com.thanhmila.codelearning.dto.response.CartResponse;
import com.thanhmila.codelearning.entity.enums.CourseStatus;
import com.thanhmila.codelearning.entity.enums.EnrollmentStatus;
import com.thanhmila.codelearning.entity.payment.CartEntity;
import com.thanhmila.codelearning.entity.payment.CartItemEntity;
import com.thanhmila.codelearning.entity.course.CourseEntity;
import com.thanhmila.codelearning.entity.user.UserEntity;
import com.thanhmila.codelearning.exception.AppException;
import com.thanhmila.codelearning.exception.ErrorCode;
import com.thanhmila.codelearning.mapper.CartMapper;
import com.thanhmila.codelearning.repository.course.CourseRepository;
import com.thanhmila.codelearning.repository.course.EnrollmentRepository;
import com.thanhmila.codelearning.repository.payment.CartRepository;
import com.thanhmila.codelearning.repository.user.UserRepository;
import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.List;

@Slf4j
@Service
@RequiredArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE, makeFinal = true)
public class CartService {

    UserRepository userRepository;
    CourseRepository courseRepository;
    EnrollmentRepository enrollmentRepository;
    CartRepository cartRepository;
    CartMapper cartMapper;


    public CartResponse getOrCreateCart(Long userId) {
        CartEntity cart = getOrCreateCartEntity(userId);
        return cartMapper.toCartResponse(cart);
    }

    @Transactional
    public CartResponse addToCart(Long userId, Long courseId) {
        CartEntity cart = getOrCreateCartEntity(userId);

        // Fetch course
        CourseEntity course = courseRepository.findById(courseId)
                .orElseThrow(() -> new AppException(ErrorCode.COURSE_NOT_FOUND));

        // Check if course is active
        if (course.getStatus() != CourseStatus.ACTIVE) {
            throw new AppException(ErrorCode.COURSE_INACTIVE);
        }

        // Check if user is already enrolled
        boolean isEnrolled = enrollmentRepository.existsByUserIdAndCourseIdAndStatusIn(
                userId, courseId, List.of(EnrollmentStatus.ACTIVE, EnrollmentStatus.COMPLETED)
        );
        if (isEnrolled) {
            throw new AppException(ErrorCode.ALREADY_ENROLLED);
        }

        // Check if course is already in cart
        boolean existsInCart = cart.getItems().stream()
                .anyMatch(item -> item.getCourse().getId().equals(courseId));
        if (existsInCart) {
            throw new AppException(ErrorCode.COURSE_ALREADY_IN_CART);
        }

        // Create new CartItem and add to Cart
        CartItemEntity cartItem = CartItemEntity.builder()
                .cart(cart)
                .course(course)
                .build();
        cart.getItems().add(cartItem);

        CartEntity savedCart = cartRepository.save(cart);
        return cartMapper.toCartResponse(savedCart);
    }

    @Transactional
    public CartResponse removeFromCart(Long userId, Long courseId) {
        CartEntity cart = cartRepository.findByUserIdWithItemsAndCourses(userId)
                .orElseThrow(() -> new AppException(ErrorCode.RESOURCE_NOT_FOUND));

        boolean removed = cart.getItems().removeIf(item -> item.getCourse().getId().equals(courseId));
        if (!removed) {
            throw new AppException(ErrorCode.RESOURCE_NOT_FOUND);
        }

        CartEntity savedCart = cartRepository.save(cart);
        return cartMapper.toCartResponse(savedCart);
    }

    @Transactional
    public void clearCart(Long userId) {
        CartEntity cart = cartRepository.findByUserIdWithItemsAndCourses(userId)
                .orElseThrow(() -> new AppException(ErrorCode.RESOURCE_NOT_FOUND));

        cart.getItems().clear();
        cartRepository.save(cart);
    }

    private CartEntity getOrCreateCartEntity(Long userId) {
        return cartRepository.findByUserIdWithItemsAndCourses(userId)
                .orElseGet(() -> {
                    log.info("Cart not found for user {}, creating a new one", userId);
                    UserEntity user = userRepository.findById(userId)
                            .orElseThrow(() -> new AppException(ErrorCode.USER_NOT_FOUND));
                    CartEntity newCart = CartEntity.builder()
                            .user(user)
                            .items(new ArrayList<>())
                            .build();
                    return cartRepository.save(newCart);
                });
    }
}
