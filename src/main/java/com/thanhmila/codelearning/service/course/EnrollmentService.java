package com.thanhmila.codelearning.service.course;

import com.thanhmila.codelearning.entity.course.CourseEntity;
import com.thanhmila.codelearning.entity.course.EnrollmentEntity;
import com.thanhmila.codelearning.entity.enums.CourseStatus;
import com.thanhmila.codelearning.entity.enums.EnrollmentStatus;
import com.thanhmila.codelearning.entity.user.UserEntity;
import com.thanhmila.codelearning.exception.AppException;
import com.thanhmila.codelearning.exception.ErrorCode;
import com.thanhmila.codelearning.repository.course.CourseRepository;
import com.thanhmila.codelearning.repository.course.EnrollmentRepository;
import com.thanhmila.codelearning.repository.user.UserRepository;
import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import java.math.BigDecimal;
import java.util.List;

@Slf4j
@Service
@RequiredArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE, makeFinal = true)
public class EnrollmentService {

    UserRepository userRepository;
    CourseRepository courseRepository;
    EnrollmentRepository enrollmentRepository;

    @Transactional
    public void enrollFreeCourse(Long userId, Long courseId) {
        // 1. Fetch user & validate status
        UserEntity user = userRepository.findById(userId)
                .orElseThrow(() -> new AppException(ErrorCode.USER_NOT_FOUND));
        user.validateStatus();

        // 2. Fetch course
        CourseEntity course = courseRepository.findById(courseId)
                .orElseThrow(() -> new AppException(ErrorCode.COURSE_NOT_FOUND));

        // 3. Check condition
        if (course.getStatus() != CourseStatus.ACTIVE) {
            throw new AppException(ErrorCode.COURSE_INACTIVE);
        }
        if (course.getPrice().compareTo(BigDecimal.ZERO) > 0) {
            throw new AppException(ErrorCode.COURSE_IS_NOT_FREE);
        }

        // 4. Check if already enrolled
        boolean alreadyEnrolled = enrollmentRepository.existsByUserIdAndCourseIdAndStatusIn(
                userId, courseId, List.of(EnrollmentStatus.COMPLETED, EnrollmentStatus.ACTIVE));
        if (alreadyEnrolled) {
            throw new AppException(ErrorCode.ALREADY_ENROLLED);
        }

        // 5. Create Enrollment
        EnrollmentEntity enrollment = EnrollmentEntity.builder()
                .user(user)
                .course(course)
                .status(EnrollmentStatus.ACTIVE)
                .build();
        enrollmentRepository.save(enrollment);

        // 6. Update course total_enrolled counter
        courseRepository.incrementTotalEnrolled(courseId);

        log.info("User {} successfully enrolled in free course {}", userId, courseId);
    }
}
