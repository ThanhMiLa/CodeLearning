# 📋 KẾ HOẠCH KIỂM THỬ: CONTROLLER COURSE & LEARNING MODULE (WEB MVC SLICE TESTS)
Dự án: **CodeLearning Platform Backend**  
Phân hệ: **Tầng Web API - Khóa học, Chương mục, Bài học, Trắc nghiệm & Ghi danh**  
Vị trí tài liệu: `backend/docs/plan_test/09_PLAN_CONTROLLER_COURSE_AND_LEARNING_MODULE.md`  
Độ bao phủ mục tiêu: **Line Coverage $\ge 90\%$, Branch Coverage $\ge 85\%$**

---

## 1. Danh sách các Controller trong phạm vi kiểm thử

| Controller | Tuyến đường (Route) | Trọng tâm kiểm thử |
| :--- | :--- | :--- |
| **`CourseController`** | `/courses/**` | GET `/` (tìm kiếm, phân trang, lọc giá/danh mục), GET `/enrolled`, GET `/{courseId}`, GET `/{courseId}/curriculum`, POST `/` (tạo khóa học có tải ảnh bìa). |
| **`ChapterController`** | `/courses/{courseId}/chapters`, `/chapters/{chapterId}` | POST tạo chương, PUT đổi tên chương, DELETE xóa chương, PUT reorder thứ tự các chương; Phân quyền `@courseSecurity.canManageCourse`, `@courseSecurity.canManageChapter`. |
| **`LessonController`** | `/lessons/**` | GET `/{lessonId}`, POST hoàn thành bài học, POST/PUT/DELETE bài học (video/lý thuyết), GET/POST bình luận (`/comments`), Phân quyền `@courseSecurity.canAccessLesson`, `@courseSecurity.canManageLesson`. |
| **`QuizController`** | `/quizzes/**`, `/lessons/{lessonId}/quiz` | POST `/{quizId}/submit` (nộp bài chấm điểm), POST/PUT/DELETE trắc nghiệm bài giảng; Phân quyền `QUIZ_SUBMIT`, `@courseSecurity.canAccessQuiz`. |
| **`EnrollmentController`** | `/enrollments/**` | POST `/free/{courseId}`: Ghi danh khóa học miễn phí, trích xuất `userId` từ token. |

---

## 2. Phân tích chi tiết Dòng lệnh & Rẽ nhánh (Line & Branch Coverage Analysis)

### 2.1. `CourseController.java`
* **Phương thức `getCourseList`:**
  * Nhánh 1: Khách vãng lai (`jwt == null`) -> `userId = null`.
  * Nhánh 2: Người dùng đăng nhập (`jwt != null`) -> Trích xuất `userId = jwt.getClaim("userId")`.
  * Kiểm tra mapping các query param trong `CourseSearchRequest`.
* **Phương thức `getEnrolledCourses`:**
  * Bắt buộc có xác thực `@PreAuthorize("isAuthenticated()")`. Phân trang mặc định `page=0, size=10`.
* **Phương thức `getCourseDetail` & `getCourseCurriculum`:**
  * Trả về thông tin chi tiết và danh mục chương mục bài giảng.

### 2.2. `ChapterController.java`
* **Tạo chương (`POST /courses/{courseId}/chapters`):**
  * Validate request DTO `@Valid ChapterCreationRequest`.
  * Phân quyền: Yêu cầu `CHAPTER_CREATE` và quyền sở hữu `@courseSecurity.canManageCourse(#courseId)`.
* **Đổi tên & Sắp xếp lại thứ tự chương (`reorderChapters`):**
  * Nhận `List<@Valid ChapterReorderRequest>`, trả về HTTP 200.

### 2.3. `LessonController.java`
* **Xem chi tiết bài học (`GET /lessons/{lessonId}`):**
  * Truyền `userId` (nếu có) để tính toán trạng thái đã học hay chưa.
* **Đánh dấu hoàn thành bài học (`POST /lessons/{lessonId}/complete`):**
  * Yêu cầu quyền `LEARNING_PROGRESS_UPDATE` và `@courseSecurity.canAccessLesson(#lessonId)`.
* **Bình luận bài học (`POST /lessons/{lessonId}/comments`):**
  * Validate nội dung comment (`@NotBlank`), hỗ trợ `parentCommentId`.

### 2.4. `QuizController.java`
* **Nộp bài quiz (`POST /quizzes/{quizId}/submit`):**
  * Yêu cầu quyền `QUIZ_SUBMIT` và `@courseSecurity.canAccessQuiz(#quizId)`.
  * Trả về `QuizSubmitResponse` chứa điểm số, số câu đúng và trạng thái vượt qua (`passed`).
* **Quản trị quiz (`POST/PUT/DELETE /lessons/{lessonId}/quiz`):**
  * Yêu cầu quyền `QUIZ_CREATE_ASSIGNED_COURSE` / `QUIZ_UPDATE_ASSIGNED_COURSE`.

### 2.5. `EnrollmentController.java`
* **Ghi danh khóa học miễn phí (`POST /enrollments/free/{courseId}`):**
  * Lấy `userId` từ JWT, gọi `enrollmentService.enrollFreeCourse(userId, courseId)`, trả về HTTP 200.

---

## 3. Ma trận Kịch bản Kiểm thử (Test Cases Matrix)

| Test ID | Controller / Endpoint | Điều kiện đầu vào (Given) | Hành vi kỳ vọng (Then) |
| :--- | :--- | :--- | :--- |
| **CRS_CTRL_01** | `GET /courses` | Không có JWT (khách) | HTTP 200, gọi service với `userId=null` |
| **CRS_CTRL_02** | `GET /courses` | Có JWT | HTTP 200, truyền đúng `userId` vào service |
| **CRS_CTRL_03** | `GET /courses/enrolled` | Chưa đăng nhập | HTTP 401 Unauthorized |
| **CRS_CTRL_04** | `GET /courses/{id}` | Id hợp lệ | HTTP 200, trả về CourseDetailResponse |
| **CHP_CTRL_01** | `POST /courses/{id}/chapters` | Request title rỗng | HTTP 400 Bad Request |
| **CHP_CTRL_02** | `POST /courses/{id}/chapters` | Hợp lệ | HTTP 200, trả về ChapterResponse |
| **CHP_CTRL_03** | `DELETE /chapters/{id}` | Id hợp lệ | HTTP 200, trả về message thành công |
| **LSN_CTRL_01** | `GET /lessons/{id}` | Id hợp lệ | HTTP 200, trả về LessonDetailResponse |
| **LSN_CTRL_02** | `POST /lessons/{id}/complete` | Id hợp lệ | HTTP 200, trả về LessonCompletionResponse |
| **LSN_CTRL_03** | `POST /lessons/{id}/comments` | Request hợp lệ | HTTP 200, trả về LessonCommentResponse |
| **QZ_CTRL_01** | `POST /quizzes/{id}/submit` | Danh sách câu trả lời | HTTP 200, trả về điểm số |
| **ENR_CTRL_01** | `POST /enrollments/free/{id}` | JWT user hợp lệ | HTTP 200, thông báo ghi danh thành công |

---

## 4. Test Blueprint Mẫu: `EnrollmentControllerTest.java`

```java
package com.thanhmila.codelearning.controller.course;

import com.thanhmila.codelearning.service.course.EnrollmentService;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.AutoConfigureMockMvc;
import org.springframework.boot.test.autoconfigure.web.servlet.WebMvcTest;
import org.springframework.security.test.web.servlet.request.SecurityMockMvcRequestPostProcessors;
import org.springframework.test.context.bean.override.mockito.MockitoBean;
import org.springframework.test.web.servlet.MockMvc;

import static org.mockito.Mockito.verify;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.post;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.jsonPath;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

@WebMvcTest(EnrollmentController.class)
@AutoConfigureMockMvc(addFilters = false)
@DisplayName("EnrollmentController WebMvc Slice Tests")
class EnrollmentControllerTest {

    @Autowired
    private MockMvc mockMvc;

    @MockitoBean
    private EnrollmentService enrollmentService;

    @Test
    @DisplayName("POST /enrollments/free/{courseId}: Ghi danh miễn phí thành công trả về HTTP 200")
    void enrollFreeCourse_Success_ReturnsHttp200() throws Exception {
        mockMvc.perform(post("/enrollments/free/10")
                        .with(SecurityMockMvcRequestPostProcessors.jwt().jwt(jwt -> jwt.claim("userId", 1L))))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.code").value(1000))
                .andExpect(jsonPath("$.message").value("Enrolled in free course successfully"));

        verify(enrollmentService).enrollFreeCourse(1L, 10L);
    }
}
```
