# 📋 KẾ HOẠCH KIỂM THỬ: COURSE, LESSON, QUIZ & LEARNING PROGRESS MODULE
Dự án: **CodeLearning Platform**  
Module: **Khóa học, Chương học, Bài giảng (Trial & Paid), Trắc nghiệm & Tiến độ học tập**  
Vị trí tài liệu: `backend/docs/plan_test/04_PLAN_COURSE_AND_LEARNING_MODULE.md`  
Độ bao phủ mục tiêu: **Line Coverage $\ge 95\%$, Branch Coverage $\ge 90\%$**

---

## 1. Danh sách các Class trong phạm vi kiểm thử

| Thành phần | Đường dẫn file | Vai trò chính |
| :--- | :--- | :--- |
| **Service** | `service/course/CourseService.java` | CRUD Khóa học, tra cứu Specification đa điều kiện, tính % tiến độ, đồng bộ cache hoàn thành |
| **Service** | `service/course/ChapterService.java` | Quản lý chương học, sắp xếp lại thứ tự (reorder) |
| **Service** | `service/course/LessonService.java` | Chi tiết bài giảng (xử lý logic học thử `isTrial`), đánh dấu hoàn thành bài học |
| **Service** | `service/course/QuizService.java` | Chấm điểm bài thi trắc nghiệm, lưu lịch sử nộp bài (attempts & answers) |
| **Service** | `service/course/EnrollmentService.java` | Quản lý bản ghi đăng ký khóa học của học viên |
| **Utility** | `util/ProgressUtils.java` | Thuật toán tính phần trăm tiến độ học tập (làm tròn an toàn, tránh chia cho 0) |
| **Controller** | `controller/course/CourseController.java` | Endpoint khóa học (danh sách, chi tiết, giáo trình) |
| **Controller** | `controller/course/LessonController.java` | Endpoint bài giảng |
| **Controller** | `controller/course/QuizController.java` | Endpoint trắc nghiệm |

---

## 2. Phân tích chi tiết Dòng lệnh & Rẽ nhánh (Line & Branch Coverage Analysis)

### 2.1. `LessonService.java`

#### Phương thức 1: `getLessonDetail(Long lessonId, Long userId)`
Kiểm soát chặt chẽ quyền xem bài học (Phân biệt bài Học thử miễn phí vs Bài học trả phí):

* **Nhánh 1 (Lesson Existence):**
  * Không tìm thấy bài học theo `lessonId` -> Ném `AppException(ErrorCode.LESSON_NOT_FOUND)`.
* **Nhánh 2 (Trial Lesson - Học thử):**
  * `lessonEntity.getTrial() == true` -> **Cho phép xem trực tiếp** (ngay cả khi `userId == null` - khách vãng lai chưa đăng nhập).
* **Nhánh 3 (Paid Lesson - Bài học yêu cầu bản quyền):**
  * `lessonEntity.getTrial() == false`:
    * Nhánh 3.1: `userId == null` (Chưa đăng nhập) -> Ném `AppException(ErrorCode.UNAUTHENTICATED)`.
    * Nhánh 3.2: `userId != null` nhưng chưa mua khóa học (`existsByUserIdAndCourseIdAndStatusIn == false`) -> Ném `AppException(ErrorCode.ACCESS_DENIED_COURSE)`.
    * Nhánh 3.3: `userId != null` và đã đăng ký khóa học thành công -> Trả về `LessonDetailResponse`.

#### Phương thức 2: `completedLesson(Long lessonId, Long userId)`
* **Nhánh 1 (Trùng lặp):**
  * Bài học này đã được user hoàn thành trước đó (`existsByLessonIdAndUserId == true`) -> Ném `AppException(ErrorCode.LESSON_ALREADY_COMPLETED)`.
* **Nhánh 2 (Course Existence):**
  * Không tìm thấy khóa học chứa bài học này -> Ném `AppException(ErrorCode.COURSE_NOT_FOUND)`.
* **Nhánh 3 (Cập nhật tiến độ & Cache):**
  * Lưu bản ghi `LessonProgressEntity`.
  * Đếm tổng số bài đã hoàn thành `actualCompletedCount`.
  * Nhánh 3.1: Bảng `CompletedLessonsCountEntity` chưa có bản ghi cho User + Course này -> Tạo mới và lưu.
  * Nhánh 3.2: Đã có bản ghi -> Cập nhật `completedLessonsCount = actualCompletedCount`.
  * Nhánh 3.3: Nếu `actualCompletedCount == totalLessons` -> Cập nhật trạng thái `EnrollmentEntity` sang `COMPLETED`.
  * Trả về `LessonCompletionResponse` gồm số bài đã học, tổng số bài và tỷ lệ hoàn thành.

---

### 2.2. `CourseService.java`

#### Phương thức 1: `createCourse(CourseCreationRequest request)`
* **Nhánh 1 (Thumbnail Upload):**
  * `request.getThumbnailFile() != null && !isEmpty()`:
    * Nhánh 1a: Upload Cloudinary thành công -> Gán `thumbnailUrl` và `thumbnailPublicId`.
    * Nhánh 1b: Cloudinary ném Exception -> Ném `AppException(ErrorCode.CLOUDINARY_UPLOAD_FAILED)`.
  * `thumbnailFile == null` hoặc rỗng -> Bỏ qua upload ảnh.
* **Nhánh 2 (Category Mapping):**
  * `request.getCategoryIds() != null && !isEmpty()`:
    * Nhánh 2a: Tìm thấy số category ít hơn số ID truyền vào -> Ném `AppException(ErrorCode.CATEGORY_NOT_FOUND)`.
    * Nhánh 2b: Hợp lệ -> Gán `Set<CategoryEntity>` vào course.
  * Không truyền category -> Bỏ qua.

#### Phương thức 2: `getCourseList(Long userId, CourseSearchRequest searchRequest, Pageable pageable)`
* **Nhánh 1 (Dynamic Specification Chaining):**
  * Luôn có điều kiện `isStatusActive()`.
  * `searchRequest.getKeyword()` có giá trị vs null.
  * `searchRequest.getCategoryIds()` có giá trị vs rỗng.
  * `searchRequest.getMinPrice()` và `getMaxPrice()` có giá trị vs null.
  * `searchRequest.getTeacherName()` có giá trị vs null.
* **Nhánh 2 (Tiến độ học tập cá nhân):**
  * `userId == null` -> `isEnrolled = false`, `progressPercentage = 0` cho toàn bộ danh sách.
  * `userId != null`:
    * Lấy danh sách `enrolledCourseIds`.
    * Nếu có khóa học đã mua: Lấy thông tin `CompletedLessonsCountEntity`.
    * Tự động sửa lỗi/đồng bộ cache: Khóa nào có trong enrolled nhưng thiếu bản ghi count -> Quét `lessonProgressRepository.countByUserIdAndCourseId` và tạo bản ghi count mới.
    * Tính toán phần trăm tiến độ bằng `ProgressUtils.calculatePercentage`.

#### Phương thức 3: `getCourseCurriculum(Long courseId, Long userId)`
* **Nhánh 1:** `userId == null` -> Toàn bộ bài giảng trong giáo trình có `isCompleted = false`.
* **Nhánh 2:** `userId != null`:
  * Lấy tập hợp `completedLessonIds`.
  * Duyệt từng bài học trong từng chương: Nếu `completedLessonIds.contains(lessonId)` -> set `isCompleted = true`, ngược lại `false`.

---

### 2.3. `QuizService.java`

#### Phương thức 1: `getQuizDetail(Long lessonId, Long userId)`
* **Nhánh 1:** Quiz không tồn tại theo `lessonId` -> Ném `AppException(ErrorCode.QUIZ_NOT_FOUND)`.
* **Nhánh 2:** User chưa từng làm bài (`findLatestAttemptByLesson == empty`) -> `pastAttempt = null`.
* **Nhánh 3:** User đã từng làm bài:
  * Map điểm số và thời gian làm bài gần nhất.
  * Ghép `userSelectedOptionId` tương ứng vào từng câu hỏi để hiển thị lại đáp án đã chọn.

#### Phương thức 2: `submitQuiz(Long quizId, Long userId, QuizSubmitRequest request)`
* **Nhánh 1:** Quiz không tồn tại -> `QUIZ_NOT_FOUND`.
* **Nhánh 2:** Chấm điểm trắc nghiệm:
  * Lấy danh sách đáp án đúng từ `quizOptionRepository.findCorrectAnswersByQuizId(quizId)`.
  * Lặp qua các câu trả lời của user: So sánh `selectedOptionId` với đáp án đúng trong DB.
  * Tính điểm: `score = (correctCount / totalQuestions) * 10`.
  * Lưu bản ghi `QuizAttemptEntity` và danh sách `QuizAttemptAnswerEntity`.
  * Trả về kết quả: Điểm số, số câu đúng, tổng số câu và danh sách câu sai chi tiết.

---

### 2.4. `ProgressUtils.java`
Phương thức `calculatePercentage(int completed, int total)`:
* **Nhánh 1:** `total <= 0` -> Trả về `0` (tránh lỗi `DivideByZeroException`).
* **Nhánh 2:** `completed <= 0` -> Trả về `0`.
* **Nhánh 3:** `completed >= total` -> Trả về `100`.
* **Nhánh 4 (Bình thường):** `Math.round(((double) completed / total) * 100)`.
  * Ví dụ: 1/3 bài -> 33%.
  * Ví dụ: 2/3 bài -> 67%.

---

## 3. Ma trận Kịch bản Kiểm thử (Test Cases Matrix)

| Test ID | Method | Điều kiện đầu vào (Given) | Hành vi kỳ vọng (Then) |
| :--- | :--- | :--- | :--- |
| **LSN_01** | `getLessonDetail` | Lesson không tồn tại | Throws `AppException(LESSON_NOT_FOUND)` |
| **LSN_02** | `getLessonDetail` | Lesson là `isTrial = true`, User nặc danh (null) | Trả về thông tin chi tiết bài học thành công |
| **LSN_03** | `getLessonDetail` | Lesson `isTrial = false`, User nặc danh (null) | Throws `AppException(UNAUTHENTICATED)` |
| **LSN_04** | `getLessonDetail` | Lesson `isTrial = false`, User chưa mua khóa học | Throws `AppException(ACCESS_DENIED_COURSE)` |
| **LSN_05** | `getLessonDetail` | Lesson `isTrial = false`, User đã mua khóa học | Trả về thông tin chi tiết bài học thành công |
| **LSN_06** | `completedLesson` | Bài học đã hoàn thành trước đó | Throws `AppException(LESSON_ALREADY_COMPLETED)` |
| **LSN_07** | `completedLesson` | Hoàn thành bài cuối cùng của khóa học | Lưu tiến độ, cập nhật Enrollment sang `COMPLETED` |
| **CRS_01** | `createCourse` | Upload thumbnail bị lỗi mạng Cloudinary | Throws `AppException(CLOUDINARY_UPLOAD_FAILED)` |
| **CRS_02** | `createCourse` | Category ID truyền vào không có trong DB | Throws `AppException(CATEGORY_NOT_FOUND)` |
| **CRS_03** | `createCourse` | Dữ liệu hợp lệ | Lưu khóa học, `isEnrolled = false`, `progress = 0` |
| **QUIZ_01** | `submitQuiz` | Đúng 5/10 câu hỏi | Điểm = 5.0, lưu attempt, trả về danh sách 5 câu sai |
| **QUIZ_02** | `submitQuiz` | Đúng 10/10 câu hỏi | Điểm = 10.0, danh sách câu sai rỗng |
| **UTIL_01** | `calculatePercentage` | total = 0, completed = 5 | Trả về 0 |
| **UTIL_02** | `calculatePercentage` | total = 10, completed = 0 | Trả về 0 |
| **UTIL_03** | `calculatePercentage` | total = 10, completed = 15 | Trả về 100 |
| **UTIL_04** | `calculatePercentage` | total = 3, completed = 1 | Trả về 33 |

---

## 4. Test Blueprint Mẫu: `LessonServiceTest.java` & `ProgressUtilsTest.java`

```java
package com.thanhmila.codelearning.service.course;

import com.thanhmila.codelearning.dto.response.LessonDetailResponse;
import com.thanhmila.codelearning.entity.course.ChapterEntity;
import com.thanhmila.codelearning.entity.course.CourseEntity;
import com.thanhmila.codelearning.entity.enums.EnrollmentStatus;
import com.thanhmila.codelearning.entity.lesson.LessonEntity;
import com.thanhmila.codelearning.exception.AppException;
import com.thanhmila.codelearning.exception.ErrorCode;
import com.thanhmila.codelearning.mapper.LessonMapper;
import com.thanhmila.codelearning.repository.course.EnrollmentRepository;
import com.thanhmila.codelearning.repository.lesson.LessonRepository;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Nested;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;

import java.util.List;
import java.util.Optional;

import static org.assertj.core.api.Assertions.assertThat;
import static org.assertj.core.api.Assertions.assertThatThrownBy;
import static org.mockito.Mockito.*;

@ExtendWith(MockitoExtension.class)
@DisplayName("LessonService Unit Tests")
class LessonServiceTest {

    @Mock LessonRepository lessonRepository;
    @Mock LessonMapper lessonMapper;
    @Mock EnrollmentRepository enrollmentRepository;

    @InjectMocks LessonService lessonService;

    @Nested
    @DisplayName("getLessonDetail Branch Tests")
    class GetLessonDetailTests {

        @Test
        @DisplayName("Allow anonymous user to access trial lesson (isTrial = true)")
        void shouldAllowAnonymousUser_WhenLessonIsTrial() {
            Long lessonId = 1L;
            LessonEntity trialLesson = LessonEntity.builder().id(lessonId).trial(true).build();
            LessonDetailResponse mockResponse = LessonDetailResponse.builder().id(lessonId).trial(true).build();

            when(lessonRepository.findDetailWithCourseById(lessonId)).thenReturn(Optional.of(trialLesson));
            when(lessonMapper.toLessonDetailResponse(trialLesson)).thenReturn(mockResponse);

            LessonDetailResponse result = lessonService.getLessonDetail(lessonId, null);

            assertThat(result).isNotNull();
            assertThat(result.getTrial()).isTrue();
            verify(enrollmentRepository, never()).existsByUserIdAndCourseIdAndStatusIn(any(), any(), any());
        }

        @Test
        @DisplayName("Throw UNAUTHENTICATED when anonymous user accesses non-trial lesson")
        void shouldThrowUnauthenticated_WhenAnonymousUserAccessesPaidLesson() {
            Long lessonId = 2L;
            LessonEntity paidLesson = LessonEntity.builder().id(lessonId).trial(false).build();

            when(lessonRepository.findDetailWithCourseById(lessonId)).thenReturn(Optional.of(paidLesson));

            assertThatThrownBy(() -> lessonService.getLessonDetail(lessonId, null))
                    .isInstanceOf(AppException.class)
                    .hasFieldOrPropertyWithValue("errorCode", ErrorCode.UNAUTHENTICATED);
        }

        @Test
        @DisplayName("Throw ACCESS_DENIED_COURSE when logged-in user is not enrolled in the course")
        void shouldThrowAccessDenied_WhenUserNotEnrolled() {
            Long lessonId = 3L;
            Long userId = 100L;
            Long courseId = 50L;

            CourseEntity course = CourseEntity.builder().id(courseId).build();
            ChapterEntity chapter = ChapterEntity.builder().course(course).build();
            LessonEntity paidLesson = LessonEntity.builder().id(lessonId).trial(false).chapter(chapter).build();

            when(lessonRepository.findDetailWithCourseById(lessonId)).thenReturn(Optional.of(paidLesson));
            when(enrollmentRepository.existsByUserIdAndCourseIdAndStatusIn(eq(userId), eq(courseId), any()))
                    .thenReturn(false);

            assertThatThrownBy(() -> lessonService.getLessonDetail(lessonId, userId))
                    .isInstanceOf(AppException.class)
                    .hasFieldOrPropertyWithValue("errorCode", ErrorCode.ACCESS_DENIED_COURSE);
        }
    }
}
```

```java
package com.thanhmila.codelearning.util;

import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.params.ParameterizedTest;
import org.junit.jupiter.params.provider.CsvSource;

import static org.assertj.core.api.Assertions.assertThat;

@DisplayName("ProgressUtils Unit Tests")
class ProgressUtilsTest {

    @ParameterizedTest(name = "Completed: {0}, Total: {1} => Expected: {2}%")
    @CsvSource({
            "0, 0, 0",      // Divide by zero prevention
            "-1, 5, 0",     // Negative completed
            "5, -1, 0",     // Negative total
            "0, 10, 0",     // No lessons completed
            "10, 10, 100",  // All completed
            "15, 10, 100",  // Exceeded total
            "1, 3, 33",     // Rounding down
            "2, 3, 67",     // Rounding up
            "1, 2, 50"      // Exact half
    })
    void testCalculatePercentage(int completed, int total, int expected) {
        assertThat(ProgressUtils.calculatePercentage(completed, total)).isEqualTo(expected);
    }
}
```
