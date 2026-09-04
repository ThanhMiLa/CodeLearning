# 📋 KẾ HOẠCH KIỂM THỬ: CÁC SERVICE CÒN LẠI, SCHEDULER VÀ CONTEST EVENT LISTENER
Dự án: **CodeLearning Platform Backend**  
Phân hệ: **Ghi danh khóa học, Bình luận bài giảng, Tiến độ học tập, Rate Limit Service, CronJob đối soát PayOS & Event Listener**  
Vị trí tài liệu: `backend/docs/plan_test/13_PLAN_REMAINING_SERVICES_SCHEDULER_AND_LISTENERS.md`  
Độ bao phủ mục tiêu: **Line Coverage $\ge 95\%$, Branch Coverage $\ge 90\%$**

---

## 1. Danh sách các Class trong phạm vi kiểm thử

| Thành phần | Đường dẫn file | Vai trò chính |
| :--- | :--- | :--- |
| **Service** | `service/course/EnrollmentService.java` | Đăng ký khóa học miễn phí (`enrollFreeCourse`), kiểm tra trạng thái khóa học, xác thực học phí = 0, ngăn trùng lặp, tăng số lượng học viên. |
| **Service** | `service/course/LessonCommentService.java` | Lấy bình luận gốc, lấy câu trả lời, đăng bình luận (hỗ trợ phân cấp 2 tầng - flattens 3rd level replies). |
| **Service** | `service/user/ProgressService.java` | Tính toán % tiến độ hoàn thành các khóa học đang học của user. |
| **Service** | `service/auth/RateLimitService.java` | Bucket4j token bucket: `tryConsumeIp` (100 req/min) & `tryConsumeUser` (10 req/sec). |
| **Scheduler** | `scheduler/PaymentCronJob.java` | Quét giao dịch `PENDING` định kỳ 5 phút, đối soát PayOS, hủy đơn quá hạn 30 phút. |
| **Listener** | `listener/ContestLeaderboardListener.java` | Bắt `SubmissionCompletedEvent` trong Contest Mode và kích hoạt tính điểm ICPC. |

---

## 2. Phân tích chi tiết Dòng lệnh & Rẽ nhánh (Line & Branch Coverage Analysis)

### 2.1. `EnrollmentService.java`
* **Phương thức: `enrollFreeCourse(Long userId, Long courseId)`**
  * **Nhánh 1:** `userRepository.findById(userId)` không tìm thấy -> Ném `AppException(USER_NOT_FOUND)`.
  * **Nhánh 2:** `user.validateStatus()` phát hiện tài khoản bị khóa/vô hiệu hóa -> Ném ngoại lệ tương ứng.
  * **Nhánh 3:** `courseRepository.findById(courseId)` không tìm thấy -> Ném `AppException(COURSE_NOT_FOUND)`.
  * **Nhánh 4:** `course.getStatus() != CourseStatus.ACTIVE` -> Ném `AppException(COURSE_INACTIVE)`.
  * **Nhánh 5:** `course.getPrice().compareTo(BigDecimal.ZERO) > 0` (khóa học có phí) -> Ném `AppException(COURSE_IS_NOT_FREE)`.
  * **Nhánh 6:** `enrollmentRepository.existsByUserIdAndCourseIdAndStatusIn(...) == true` -> Ném `AppException(ALREADY_ENROLLED)`.
  * **Nhánh 7 (Happy Path):** Lưu `EnrollmentEntity(status=ACTIVE)`, gọi `courseRepository.incrementTotalEnrolled(courseId)`.

### 2.2. `LessonCommentService.java`
* **Tạo bình luận (`createComment`):**
  * **Nhánh 1:** Bài học không tồn tại -> `LESSON_NOT_FOUND`.
  * **Nhánh 2:** Người dùng không tồn tại -> `USER_NOT_FOUND`.
  * **Nhánh 3 (Comment gốc):** `parentCommentId == null` -> `parentComment = null`.
  * **Nhánh 4 (Comment trả lời - không tìm thấy parent):** `parentCommentId` không có trong DB -> `COMMENT_NOT_FOUND`.
  * **Nhánh 5 (Parent khác bài học):** `!targetComment.getLesson().getId().equals(lessonId)` -> `INVALID_COMMENT_LESSON`.
  * **Nhánh 6 (Phẳng hóa phân cấp lồng):** Nếu `targetComment.getParentComment() != null` -> Gán `actualParentComment = targetComment.getParentComment()` để không vượt quá 2 cấp độ thread.

### 2.3. `ProgressService.java`
* **Tính tiến độ (`getCourseProgress`):**
  * **Nhánh 1:** Không tìm thấy user -> `USER_NOT_FOUND`.
  * **Nhánh 2:** User chưa đăng ký khóa học nào (`courses.isEmpty()`) -> Trả về danh sách rỗng.
  * **Nhánh 3:** User có đăng ký -> Gom map số bài đã học, gọi `ProgressUtils.calculatePercentage(completed, total)`, map sang `CourseProgressResponse`.

### 2.4. `PaymentCronJob.java`
* **Quét đơn hàng PENDING (`scanPendingTransactions`):**
  * **Nhánh 1:** `pendingTransactions.isEmpty()` -> `return` ngay lập tức.
  * **Nhánh 2 (PayOS báo PAID / SUCCESS):** Gọi `paymentService.processSuccessfulPaymentFallback(...)`.
  * **Nhánh 3 (PayOS báo CANCELLED / EXPIRED):** Cập nhật `tx.setStatus(CANCELLED)` và lưu DB.
  * **Nhánh 4 (PayOS báo PENDING nhưng quá 30 phút):** Cập nhật `tx.setStatus(CANCELLED)`.
  * **Nhánh 5 (Exception kết nối PayOS):** Nếu đơn tạo trước 30 phút -> Hủy giao dịch.

### 2.5. `ContestLeaderboardListener.java`
* **Lắng nghe sự kiện (`onSubmissionCompleted`):**
  * **Nhánh 1:** `event.isContestMode() == true` -> Gọi `leaderboardService.processIpcpLeaderboard(...)`.
  * **Nhánh 2:** `event.isContestMode() == false` (chế độ luyện tập thông thường) -> Bỏ qua, không gọi leaderboard.
  * **Nhánh 3:** Xảy ra ngoại lệ -> Bắt ngoại lệ và log error, không để lan truyền ra ngoài thread.

---

## 3. Ma trận Kịch bản Kiểm thử (Test Cases Matrix)

| Test ID | Class / Method | Điều kiện đầu vào (Given) | Hành vi kỳ vọng (Then) |
| :--- | :--- | :--- | :--- |
| **ENR_01** | `EnrollmentService` | Khóa học có giá > 0 | Ném `AppException(COURSE_IS_NOT_FREE)` |
| **ENR_02** | `EnrollmentService` | Đã đăng ký khóa học trước đó | Ném `AppException(ALREADY_ENROLLED)` |
| **ENR_03** | `EnrollmentService` | Đủ điều kiện khóa học 0 VND | Lưu enrollment, tăng counter `incrementTotalEnrolled` |
| **LCM_01** | `LessonCommentService` | Comment trả lời sai bài học | Ném `AppException(INVALID_COMMENT_LESSON)` |
| **LCM_02** | `LessonCommentService` | Comment trả lời cấp 2 (đã có parent) | Flatten gán về root comment, lưu DB thành công |
| **PRG_01** | `ProgressService` | User có 2 khóa học, hoàn thành 5/10 và 10/10 | Trả về 50% và 100% |
| **CRON_01**| `PaymentCronJob` | Danh sách pending rỗng | Trả về ngay, không gọi WebClient |
| **LST_01** | `ContestLeaderboardListener` | `event.isContestMode() == true` | Gọi `processIpcpLeaderboard` |
| **LST_02** | `ContestLeaderboardListener` | `event.isContestMode() == false` | Không gọi `processIpcpLeaderboard` |

---

## 4. Test Blueprint Mẫu: `EnrollmentServiceTest.java`

```java
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
    @DisplayName("enrollFreeCourse: Thành công lưu Enrollment và tăng bộ đếm lượt ghi danh")
    void enrollFreeCourse_Success() {
        UserEntity user = UserEntity.builder().id(1L).status(UserStatus.ACTIVE).build();
        CourseEntity course = CourseEntity.builder().id(10L).status(CourseStatus.ACTIVE).price(BigDecimal.ZERO).build();

        when(userRepository.findById(1L)).thenReturn(Optional.of(user));
        when(courseRepository.findById(10L)).thenReturn(Optional.of(course));
        when(enrollmentRepository.existsByUserIdAndCourseIdAndStatusIn(eq(1L), eq(10L), anyList())).thenReturn(false);

        enrollmentService.enrollFreeCourse(1L, 10L);

        verify(enrollmentRepository).save(any(EnrollmentEntity.class));
        verify(courseRepository).incrementTotalEnrolled(10L);
    }
}
```
