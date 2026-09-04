package com.thanhmila.codelearning.service.user;

import com.thanhmila.codelearning.dto.response.CourseProgressResponse;
import com.thanhmila.codelearning.entity.course.CourseEntity;
import com.thanhmila.codelearning.entity.enums.UserStatus;
import com.thanhmila.codelearning.entity.progress.CompletedLessonsCountEntity;
import com.thanhmila.codelearning.entity.user.UserEntity;
import com.thanhmila.codelearning.exception.AppException;
import com.thanhmila.codelearning.exception.ErrorCode;
import com.thanhmila.codelearning.repository.course.EnrollmentRepository;
import com.thanhmila.codelearning.repository.progress.CompletedLessonCountRepository;
import com.thanhmila.codelearning.repository.user.UserRepository;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;

import java.util.Collections;
import java.util.List;
import java.util.Optional;
import java.util.Set;

import static org.assertj.core.api.Assertions.assertThat;
import static org.assertj.core.api.Assertions.assertThatThrownBy;
import static org.mockito.Mockito.when;

@ExtendWith(MockitoExtension.class)
@DisplayName("ProgressService Unit Tests")
class ProgressServiceTest {

    @Mock
    private EnrollmentRepository enrollmentRepository;

    @Mock
    private CompletedLessonCountRepository completedLessonCountRepository;

    @Mock
    private UserRepository userRepository;

    @InjectMocks
    private ProgressService progressService;

    @Test
    @DisplayName("getCourseProgress: User không tồn tại ném AppException(USER_NOT_FOUND)")
    void getCourseProgress_UserNotFound_ThrowsException() {
        when(userRepository.findById(1L)).thenReturn(Optional.empty());

        assertThatThrownBy(() -> progressService.getCourseProgress(1L))
                .isInstanceOf(AppException.class)
                .matches(e -> ((AppException) e).getErrorCode() == ErrorCode.USER_NOT_FOUND);
    }

    @Test
    @DisplayName("getCourseProgress: Người dùng chưa đăng ký khóa nào trả về rỗng")
    void getCourseProgress_NoCourses_ReturnsEmptyList() {
        UserEntity user = UserEntity.builder().id(1L).status(UserStatus.ACTIVE).build();
        when(userRepository.findById(1L)).thenReturn(Optional.of(user));
        when(enrollmentRepository.findActiveCoursesByUserId(1L)).thenReturn(Collections.emptySet());

        List<CourseProgressResponse> result = progressService.getCourseProgress(1L);

        assertThat(result).isEmpty();
    }

    @Test
    @DisplayName("getCourseProgress: Tính toán phần trăm tiến độ chính xác cho các khóa học")
    void getCourseProgress_Success_CalculatesPercentages() {
        UserEntity user = UserEntity.builder().id(1L).status(UserStatus.ACTIVE).build();
        CourseEntity course1 = CourseEntity.builder().id(10L).title("Java Pro").totalLessons(10).thumbnailUrl("thumb1.png").build();
        CourseEntity course2 = CourseEntity.builder().id(20L).title("React Pro").totalLessons(4).thumbnailUrl("thumb2.png").build();

        CompletedLessonsCountEntity progress1 = CompletedLessonsCountEntity.builder()
                .course(course1)
                .completedLessonsCount(5)
                .build();
        CompletedLessonsCountEntity progress2 = CompletedLessonsCountEntity.builder()
                .course(course2)
                .completedLessonsCount(4)
                .build();

        when(userRepository.findById(1L)).thenReturn(Optional.of(user));
        when(enrollmentRepository.findActiveCoursesByUserId(1L)).thenReturn(Set.of(course1, course2));
        when(completedLessonCountRepository.findByUserIdAndCourseIdIn(1L, Set.of(10L, 20L)))
                .thenReturn(List.of(progress1, progress2));

        List<CourseProgressResponse> result = progressService.getCourseProgress(1L);

        assertThat(result).hasSize(2);

        CourseProgressResponse res1 = result.stream().filter(r -> r.getCourseId().equals(10L)).findFirst().orElseThrow();
        assertThat(res1.getCompletedLessons()).isEqualTo(5);
        assertThat(res1.getTotalLessons()).isEqualTo(10);
        assertThat(res1.getCompletionPercentage()).isEqualTo(50);

        CourseProgressResponse res2 = result.stream().filter(r -> r.getCourseId().equals(20L)).findFirst().orElseThrow();
        assertThat(res2.getCompletedLessons()).isEqualTo(4);
        assertThat(res2.getTotalLessons()).isEqualTo(4);
        assertThat(res2.getCompletionPercentage()).isEqualTo(100);
    }
}
