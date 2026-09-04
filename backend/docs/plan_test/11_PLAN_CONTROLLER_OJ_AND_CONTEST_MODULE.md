# 📋 KẾ HOẠCH KIỂM THỬ: CONTROLLER ONLINE JUDGE & CONTEST MODULE (WEB MVC SLICE TESTS)
Dự án: **CodeLearning Platform Backend**  
Phân hệ: **Tầng Web API - Luyện tập Online Judge, Nộp bài Sandbox, Webhook & Cuộc thi ICPC**  
Vị trí tài liệu: `backend/docs/plan_test/11_PLAN_CONTROLLER_OJ_AND_CONTEST_MODULE.md`  
Độ bao phủ mục tiêu: **Line Coverage $\ge 90\%$, Branch Coverage $\ge 85\%$**

---

## 1. Danh sách các Controller trong phạm vi kiểm thử

| Controller | Tuyến đường (Route) | Trọng tâm kiểm thử |
| :--- | :--- | :--- |
| **`OnlineJudgeProblemController`** | `/online-judge/problems/**` | GET `/practice` (tìm kiếm bài tập, phân trang, lọc difficulty/tags/scope), GET `/{id}`, POST `/` (tạo bài tập vào ngân hàng), PUT `/{id}/visibility` (ẩn/hiện bài tập). |
| **`OnlineJudgeSubmissionController`** | `/online-judge/submissions/**`, `/online-judge/webhooks/**` | POST `/submissions`: Nộp bài; PUT `/submissions`: Webhook Judge0; POST `/problems/{id}/generate-testcases` (HTTP 202); PUT `/webhooks/generate-inputs`, PUT `/webhooks/generate-outputs`. |
| **`ContestController`** | `/contests/**` | GET `/` (danh sách cuộc thi), GET `/{id}`, POST `/register` (đăng ký tham gia contest), POST `/` (tạo contest), GET `/{id}/leaderboard` (bảng xếp hạng ICPC), GET `/{id}/submissions` (lịch sử nộp bài của thí sinh). |

---

## 2. Phân tích chi tiết Dòng lệnh & Rẽ nhánh (Line & Branch Coverage Analysis)

### 2.1. `OnlineJudgeSubmissionController.java`
* **Nộp bài (`POST /online-judge/submissions`):**
  * Validate request `@Valid OjSubmissionRequest` (sourceCode, languageId, problemId).
  * Quyền: `@PreAuthorize("hasAuthority('OJ_PROBLEM_SUBMIT') and @courseSecurity.canAccessProblem(#request.problemId)")`.
  * Trả về HTTP 200 kèm `OjSubmissionInitialResponse(submissionId, status="PENDING")`.
* **Webhook chấm bài (`PUT /online-judge/submissions`):**
  * Nhánh 1: `secret == null || !secret.equals(webhookSecret)` -> Trả về HTTP 401 Unauthorized.
  * Nhánh 2: Secret hợp lệ -> Gọi `ojSubmissionService.processJudge0Callback(payload)`, trả về HTTP 204 No Content.
* **Yêu cầu sinh testcase tự động (`POST /online-judge/problems/{id}/generate-testcases`):**
  * Quyền `PROBLEM_UPDATE`.
  * Trả về HTTP 202 Accepted.
* **Webhook sinh input & output (`PUT /online-judge/webhooks/generate-inputs`, `generate-outputs`):**
  * Kiểm tra secret query param -> 401 nếu sai, 200 nếu đúng.

### 2.2. `OnlineJudgeProblemController.java`
* **Lấy danh sách bài tập luyện tập (`GET /online-judge/problems/practice`):**
  * Xử lý `jwt != null` để lấy `userId` (xác định trạng thái bài đã AC hay chưa), hoặc `userId = null` cho khách.
* **Tạo bài tập mới (`POST /online-judge/problems`):**
  * Quyền `PROBLEM_CREATE`. Validate `CreateOjProblemRequest`.

### 2.3. `ContestController.java`
* **Danh sách cuộc thi (`GET /contests`):**
  * Phân trang `page, size`, truyền `userId` để xác định trạng thái đăng ký.
* **Đăng ký thi (`POST /contests/register`):**
  * Validate `ContestRegisterRequest` (mật khẩu cuộc thi nếu có).
  * Trả về HTTP 200 thông báo đăng ký thành công.
* **Xem Bảng xếp hạng ICPC (`GET /contests/{id}/leaderboard`):**
  * Trả về `ContestLeaderboardResponse` gồm danh sách thí sinh, số bài giải được và penalty time.

---

## 3. Ma trận Kịch bản Kiểm thử (Test Cases Matrix)

| Test ID | Controller / Endpoint | Điều kiện đầu vào (Given) | Hành vi kỳ vọng (Then) |
| :--- | :--- | :--- | :--- |
| **OJ_SUB_C01** | `POST /online-judge/submissions` | Request nộp bài hợp lệ | HTTP 200, trả về submissionId |
| **OJ_SUB_C02** | `POST /online-judge/submissions` | sourceCode rỗng | HTTP 400 Bad Request |
| **OJ_WH_C01** | `PUT /online-judge/submissions` | Secret sai hoặc thiếu | HTTP 401 Unauthorized |
| **OJ_WH_C02** | `PUT /online-judge/submissions` | Secret đúng, Judge0 payload AC | HTTP 204 No Content |
| **OJ_GEN_C01** | `POST .../generate-testcases` | Request tạo 5 testcase | HTTP 202 Accepted |
| **OJ_PRB_C01** | `GET /online-judge/problems/practice`| Khách chưa đăng nhập | HTTP 200, danh sách bài tập public |
| **CNT_CTRL_01** | `GET /contests` | Page=0, Size=10 | HTTP 200, PageResponse |
| **CNT_CTRL_02** | `POST /contests/register` | Contest ID hợp lệ | HTTP 200, đăng ký thành công |
| **CNT_CTRL_03** | `GET /contests/{id}/leaderboard` | Contest ID tồn tại | HTTP 200, dữ liệu bảng xếp hạng ICPC |

---

## 4. Test Blueprint Mẫu: `OnlineJudgeSubmissionControllerTest.java`

```java
package com.thanhmila.codelearning.controller.oj;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.thanhmila.codelearning.dto.judge0.Judge0CallbackPayload;
import com.thanhmila.codelearning.dto.request.OjSubmissionRequest;
import com.thanhmila.codelearning.dto.response.OjSubmissionInitialResponse;
import com.thanhmila.codelearning.service.oj.OjSubmissionService;
import com.thanhmila.codelearning.service.oj.OjTestcaseGenerationService;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.AutoConfigureMockMvc;
import org.springframework.boot.test.autoconfigure.web.servlet.WebMvcTest;
import org.springframework.http.MediaType;
import org.springframework.security.test.web.servlet.request.SecurityMockMvcRequestPostProcessors;
import org.springframework.test.context.bean.override.mockito.MockitoBean;
import org.springframework.test.util.ReflectionTestUtils;
import org.springframework.test.web.servlet.MockMvc;

import static org.mockito.ArgumentMatchers.any;
import static org.mockito.ArgumentMatchers.eq;
import static org.mockito.Mockito.verify;
import static org.mockito.Mockito.when;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.post;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.put;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.jsonPath;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

@WebMvcTest(OnlineJudgeSubmissionController.class)
@AutoConfigureMockMvc(addFilters = false)
@DisplayName("OnlineJudgeSubmissionController WebMvc Slice Tests")
class OnlineJudgeSubmissionControllerTest {

    @Autowired
    private MockMvc mockMvc;

    @Autowired
    private ObjectMapper objectMapper;

    @MockitoBean
    private OjSubmissionService ojSubmissionService;

    @MockitoBean
    private OjTestcaseGenerationService ojTestcaseGenerationService;

    @Autowired
    private OnlineJudgeSubmissionController controller;

    @BeforeEach
    void setUp() {
        ReflectionTestUtils.setField(controller, "webhookSecret", "oj-secret-key");
    }

    @Test
    @DisplayName("POST /online-judge/submissions: Nộp code thành công trả về HTTP 200")
    void submitCode_Success_ReturnsHttp200() throws Exception {
        OjSubmissionRequest request = OjSubmissionRequest.builder()
                .problemId(10L)
                .languageId(71)
                .sourceCode("print('Hello World')")
                .build();

        OjSubmissionInitialResponse response = OjSubmissionInitialResponse.builder()
                .submissionId(100L)
                .status("PENDING")
                .build();

        when(ojSubmissionService.submitCode(any(OjSubmissionRequest.class), eq(1L)))
                .thenReturn(response);

        mockMvc.perform(post("/online-judge/submissions")
                        .with(SecurityMockMvcRequestPostProcessors.jwt().jwt(jwt -> jwt.claim("userId", 1L)))
                        .contentType(MediaType.APPLICATION_JSON)
                        .content(objectMapper.writeValueAsString(request)))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.code").value(1000))
                .andExpect(jsonPath("$.result.submissionId").value(100L));
    }

    @Test
    @DisplayName("PUT /online-judge/submissions: Webhook callback hợp lệ trả về HTTP 200 (204 code trong response)")
    void processJudge0Callback_ValidSecret_Success() throws Exception {
        Judge0CallbackPayload payload = new Judge0CallbackPayload();
        payload.setToken("tok-xyz");

        mockMvc.perform(put("/online-judge/submissions")
                        .param("secret", "oj-secret-key")
                        .contentType(MediaType.APPLICATION_JSON)
                        .content(objectMapper.writeValueAsString(payload)))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.status").value(204));

        verify(ojSubmissionService).processJudge0Callback(any(Judge0CallbackPayload.class));
    }
}
```
