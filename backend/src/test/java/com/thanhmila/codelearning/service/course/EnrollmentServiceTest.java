package com.thanhmila.codelearning.service.course;

import com.thanhmila.codelearning.entity.course.CourseEntity;
import com.thanhmila.codelearning.entity.course.EnrollmentEntity;
import com.thanhmila.codelearning.entity.enums.CourseStatus;
import com.thanhmila.codelearning.entity.enums.EnrollmentStatus;
import com.thanhmila.codelearning.entity.enums.UserStatus;
import com.thanhmila.codelearning.entity.user.UserEntity;
import com.thanhmila.codelearning.exception.AppException;
import com.thanhmila.codelearning.exception.ErrorCode;
import com.thanhmila.codelearning.repository.course.CourseRepository;
import com.thanhmila.codelearning.repository.course.EnrollmentRepository;
import com.thanhmila.codelearning.repository.user.UserRepository;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;

import java.math.BigDecimal;
import java.util.List;
import java.util.Optional;

import static org.assertj.core.api.Assertions.assertThatThrownBy;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.Mockito.*;

@ExtendWith(MockitoExtension.class)
@DisplayName("EnrollmentService Unit Tests")
class EnrollmentServiceTest {

    @Mock
    private UserRepository userRepository;

    @Mock
    private CourseRepository courseRepository;

    @Mock
    private EnrollmentRepository enrollmentRepository;

    @InjectMocks
    private EnrollmentService enrollmentService;

    @Test
    @DisplayName("enrollFreeCourse: User không tồn tại ném AppException(USER_NOT_FOUND)")
    void enrollFreeCourse_UserNotFound_ThrowsException() {
        when(userRepository.findById(1L)).thenReturn(Optional.empty());

        assertThatThrownBy(() -> enrollmentService.enrollFreeCourse(1L, 10L))
                .isInstanceOf(AppException.class)
                .matches(e -> ((AppException) e).getErrorCode() == ErrorCode.USER_NOT_FOUND);

        verify(enrollmentRepository, never()).save(any());
    }

    @Test
    @DisplayName("enrollFreeCourse: Course không tồn tại ném AppException(COURSE_NOT_FOUND)")
    void enrollFreeCourse_CourseNotFound_ThrowsException() {
        UserEntity user = UserEntity.builder().id(1L).status(UserStatus.ACTIVE).build();
        when(userRepository.findById(1L)).thenReturn(Optional.of(user));
        when(courseRepository.findById(10L)).thenReturn(Optional.empty());

        assertThatThrownBy(() -> enrollmentService.enrollFreeCourse(1L, 10L))
                .isInstanceOf(AppException.class)
                .matches(e -> ((AppException) e).getErrorCode() == ErrorCode.COURSE_NOT_FOUND);

        verify(enrollmentRepository, never()).save(any());
    }

    @Test
    @DisplayName("enrollFreeCourse: Course không ACTIVE ném AppException(COURSE_INACTIVE)")
    void enrollFreeCourse_CourseInactive_ThrowsException() {
        UserEntity user = UserEntity.builder().id(1L).status(UserStatus.ACTIVE).build();
        CourseEntity course = CourseEntity.builder().id(10L).status(CourseStatus.DRAFT).build();

        when(userRepository.findById(1L)).thenReturn(Optional.of(user));
        when(courseRepository.findById(10L)).thenReturn(Optional.of(course));

        assertThatThrownBy(() -> enrollmentService.enrollFreeCourse(1L, 10L))
                .isInstanceOf(AppException.class)
                .matches(e -> ((AppException) e).getErrorCode() == ErrorCode.COURSE_INACTIVE);

        verify(enrollmentRepository, never()).save(any());
    }

    @Test
    @DisplayName("enrollFreeCourse: Khóa học có phí ném AppException(COURSE_IS_NOT_FREE)")
    void enrollFreeCourse_PaidCourse_ThrowsException() {
        UserEntity user = UserEntity.builder().id(1L).status(UserStatus.ACTIVE).build();
        CourseEntity course = CourseEntity.builder().id(10L).status(CourseStatus.ACTIVE).price(new BigDecimal("100000")).build();

        when(userRepository.findById(1L)).thenReturn(Optional.of(user));
        when(courseRepository.findById(10L)).thenReturn(Optional.of(course));

        assertThatThrownBy(() -> enrollmentService.enrollFreeCourse(1L, 10L))
                .isInstanceOf(AppException.class)
                .matches(e -> ((AppException) e).getErrorCode() == ErrorCode.COURSE_IS_NOT_FREE);

        verify(enrollmentRepository, never()).save(any());
    }

    @Test
    @DisplayName("enrollFreeCourse: Đã đăng ký khóa học trước đó ném AppException(ALREADY_ENROLLED)")
    void enrollFreeCourse_AlreadyEnrolled_ThrowsException() {
        UserEntity user = UserEntity.builder().id(1L).status(UserStatus.ACTIVE).build();
        CourseEntity course = CourseEntity.builder().id(10L).status(CourseStatus.ACTIVE).price(BigDecimal.ZERO).build();

        when(userRepository.findById(1L)).thenReturn(Optional.of(user));
        when(courseRepository.findById(10L)).thenReturn(Optional.of(course));
        when(enrollmentRepository.existsByUserIdAndCourseIdAndStatusIn(1L, 10L, List.of(EnrollmentStatus.COMPLETED, EnrollmentStatus.ACTIVE)))
                .thenReturn(true);

        assertThatThrownBy(() -> enrollmentService.enrollFreeCourse(1L, 10L))
                .isInstanceOf(AppException.class)
                .matches(e -> ((AppException) e).getErrorCode() == ErrorCode.ALREADY_ENROLLED);

        verify(enrollmentRepository, never()).save(any());
    }

    @Test
    @DisplayName("enrollFreeCourse: Thành công lưu Enrollment và tăng bộ đếm lượt ghi danh")
    void enrollFreeCourse_Success() {
        UserEntity user = UserEntity.builder().id(1L).status(UserStatus.ACTIVE).build();
        CourseEntity course = CourseEntity.builder().id(10L).status(CourseStatus.ACTIVE).price(BigDecimal.ZERO).build();

        when(userRepository.findById(1L)).thenReturn(Optional.of(user));
        when(courseRepository.findById(10L)).thenReturn(Optional.of(course));
        when(enrollmentRepository.existsByUserIdAndCourseIdAndStatusIn(1L, 10L, List.of(EnrollmentStatus.COMPLETED, EnrollmentStatus.ACTIVE)))
                .thenReturn(false);

        enrollmentService.enrollFreeCourse(1L, 10L);

        verify(enrollmentRepository).save(any(EnrollmentEntity.class));
        verify(courseRepository).incrementTotalEnrolled(10L);
    }
}
