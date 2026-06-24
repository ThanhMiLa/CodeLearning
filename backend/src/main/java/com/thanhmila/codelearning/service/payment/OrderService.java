package com.thanhmila.codelearning.service.payment;

import com.thanhmila.codelearning.dto.request.OrderCheckoutRequest;
import com.thanhmila.codelearning.dto.response.OrderCheckoutResponse;
import com.thanhmila.codelearning.entity.course.CourseEntity;
import com.thanhmila.codelearning.entity.course.EnrollmentEntity;
import com.thanhmila.codelearning.entity.enums.*;
import com.thanhmila.codelearning.entity.payment.OrderEntity;
import com.thanhmila.codelearning.entity.payment.OrderItemEntity;
import com.thanhmila.codelearning.entity.payment.WalletEntity;
import com.thanhmila.codelearning.entity.payment.WalletTransactionEntity;
import com.thanhmila.codelearning.entity.user.UserEntity;
import com.thanhmila.codelearning.exception.AppException;
import com.thanhmila.codelearning.exception.ErrorCode;
import com.thanhmila.codelearning.repository.course.CourseRepository;
import com.thanhmila.codelearning.repository.course.EnrollmentRepository;
import com.thanhmila.codelearning.repository.payment.OrderRepository;
import com.thanhmila.codelearning.repository.payment.WalletRepository;
import com.thanhmila.codelearning.repository.payment.WalletTransactionRepository;
import com.thanhmila.codelearning.repository.user.UserRepository;
import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;
import java.util.Set;

@Slf4j
@Service
@RequiredArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE, makeFinal = true)
public class OrderService {

    UserRepository userRepository;
    CourseRepository courseRepository;
    EnrollmentRepository enrollmentRepository;
    WalletRepository walletRepository;
    WalletTransactionRepository walletTransactionRepository;
    OrderRepository orderRepository;

    @Transactional
    public OrderCheckoutResponse createCheckout(Long userId, OrderCheckoutRequest request) {
        if (request.getCourseIds() == null || request.getCourseIds().isEmpty()) {
            throw new AppException(ErrorCode.INVALID_REQUEST);
        }

        // 1. Fetch user
        UserEntity user = userRepository.findById(userId)
                .orElseThrow(() -> new AppException(ErrorCode.USER_NOT_FOUND));
        user.validateStatus();

        // 2. Fetch courses
        List<CourseEntity> courses = courseRepository.findAllById(request.getCourseIds());
        if (courses.size() != request.getCourseIds().size()) {
            throw new AppException(ErrorCode.COURSE_NOT_FOUND);
        }

        // 3. Check if all courses are active
        boolean allActive = courses.stream().allMatch(c -> c.getStatus() == CourseStatus.ACTIVE);
        if (!allActive) {
            throw new AppException(ErrorCode.COURSE_INACTIVE);
        }

        // 4. Check duplicate enrollment
        Set<Long> alreadyEnrolled = enrollmentRepository.findEnrolledCourseIdsByUserIdAndCourseIds(
                userId, request.getCourseIds(), List.of(EnrollmentStatus.ACTIVE, EnrollmentStatus.COMPLETED)
        );
        if (!alreadyEnrolled.isEmpty()) {
            throw new AppException(ErrorCode.ALREADY_ENROLLED);
        }

        // 5. Calculate total
        BigDecimal totalAmount = courses.stream()
                .map(CourseEntity::getPrice)
                .reduce(BigDecimal.ZERO, BigDecimal::add);

        // 6. Lock Wallet
        WalletEntity wallet = walletRepository.findByUserIdWithLock(userId)
                .orElseThrow(() -> new AppException(ErrorCode.RESOURCE_NOT_FOUND));

        // 7. Check balance
        if (wallet.getBalance().compareTo(totalAmount) < 0) {
            throw new AppException(ErrorCode.INSUFFICIENT_BALANCE);
        }

        // 8. Deduct balance
        wallet.setBalance(wallet.getBalance().subtract(totalAmount));
        // Wallet will be updated automatically by Hibernate dirty checking or we can call save
        walletRepository.save(wallet);

        // 9. Save Order
        OrderEntity order = OrderEntity.builder()
                .user(user)
                .totalAmount(totalAmount)
                .status(OrderStatus.COMPLETED)
                .orderItems(new ArrayList<>())
                .build();

        for (CourseEntity course : courses) {
            OrderItemEntity orderItem = OrderItemEntity.builder()
                    .order(order)
                    .course(course)
                    .price(course.getPrice())
                    .build();
            order.getOrderItems().add(orderItem);
        }

        order = orderRepository.save(order);

        // 10. Save WalletTransaction
        WalletTransactionEntity transaction = WalletTransactionEntity.builder()
                .wallet(wallet)
                .amount(totalAmount.negate()) // Negative amount for purchase
                .type(WalletTransactionType.PURCHASE)
                .status(TransactionStatus.SUCCESS)
                .order(order)
                .note("Purchased " + courses.size() + " courses")
                .build();
        walletTransactionRepository.save(transaction);

        // 11. Create Enrollments
        List<EnrollmentEntity> enrollments = courses.stream()
                .map(course -> EnrollmentEntity.builder()
                        .user(user)
                        .course(course)
                        .status(EnrollmentStatus.ACTIVE)
                        .build())
                .toList();
        enrollmentRepository.saveAll(enrollments);

        // 12. Update course total_enrolled counter
        List<Long> enrolledCourseIds = courses.stream().map(CourseEntity::getId).toList();
        courseRepository.incrementTotalEnrolledForCourses(enrolledCourseIds);

        return OrderCheckoutResponse.builder()
                .orderId(order.getId())
                .totalAmount(totalAmount)
                .status(order.getStatus())
                .build();
    }
}