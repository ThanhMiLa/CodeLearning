# 🚀 Judge0 Submission Workflow

> Tài liệu mô tả chi tiết luồng chấm bài Online Judge, từ lúc học viên bấm **Submit** cho đến khi nhận kết quả real-time qua WebSocket.

## Tổng Quan Kiến Trúc

Quy trình được chia thành **4 giai đoạn**, luân chuyển qua 3 thành phần:

```
Frontend (React) ──➤ Backend (Spring Boot + PostgreSQL + Redis) ──➤ Judge Engine (Judge0)
```

### Đặc điểm cốt lõi

| Đặc điểm | Mô tả |
|-----------|--------|
| **Mô hình** | Asynchronous Webhook-based (không polling) |
| **Concurrency** | Redis Atomic Counter chống Race Condition |
| **Real-time** | WebSocket (STOMP over SockJS) push kết quả |
| **Chế độ** | Practice (bắn từng testcase) vs Contest (chỉ bắn kết quả cuối) |
| **Tối ưu Contest** | Short-circuit — chốt sổ ngay khi gặp testcase sai đầu tiên |

---

## Mô Hình Dữ Liệu

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                      ENTITY RELATIONSHIP DIAGRAM                          │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                           │
│  ┌──────────┐    ┌──────────────────────────┐    ┌───────────────────────┐ │
│  │  users    │    │ online_judge_submissions  │    │ online_judge_problems │ │
│  └────┬─────┘    │ (Parent / Submission Me)  │    └───────────┬───────────┘ │
│       │          ├──────────────────────────┤                │           │
│       │  1:N     │ id              PK       │     1:N        │           │
│       └─────────►│ user_id         FK       │◄───────────────┘           │
│                  │ problem_id      FK       │                            │
│  ┌──────────┐    │ lesson_id       FK (opt) │                            │
│  │ lessons  │◄───│ contest_id      FK (opt) │───►┌──────────┐            │
│  │(practice)│    │ language_id              │    │ contests │            │
│  └──────────┘    │ source_code     TEXT     │    │ (contest)│            │
│                  │ verdict         ENUM     │    └──────────┘            │
│                  │ execution_time_ms INT    │                            │
│                  │ memory_used_kb    INT    │                            │
│                  │ submitted_at             │                            │
│                  └────────────┬─────────────┘                            │
│                               │                                          │
│                               │ 1:N (One submission has N details)       │
│                               ▼                                          │
│                  ┌──────────────────────────────┐   ┌──────────────────┐  │
│                  │ online_judge_submission_details│   │problem_testcases│  │
│                  │ (Child / Submission Con)      │   └───────┬──────────┘  │
│                  ├──────────────────────────────┤           │            │
│                  │ id               PK          │           │            │
│                  │ submission_id    FK ──────────┤ (parent)  │            │
│                  │ testcase_id      FK ─────────────────────┘ (1:1 map) │
│                  │ token            UK (UUID)    │                        │
│                  │ verdict          ENUM         │                        │
│                  │ execution_time_ms INT         │                        │
│                  │ memory_used_kb    INT         │                        │
│                  └──────────────────────────────┘                        │
└─────────────────────────────────────────────────────────────────────────────┘
```

**Key fields:**

| Table | Field | Note |
|-------|-------|------|
| `submissions` | `lesson_id` | nullable — set when Practice mode |
| `submissions` | `contest_id` | nullable — set when Contest mode |
| `submissions` | `verdict` | PENDING on create, updated to ACCEPTED/WA/TLE/... on finalize |
| `submissions` | `execution_time_ms` | MAX across all testcases (updated on finalize) |
| `submissions` | `memory_used_kb` | MAX across all testcases (updated on finalize) |
| `details` | `token` | Unique UUID from Judge0, used for webhook lookup |
| `details` | `verdict` | PENDING on create, updated per testcase |

> **Quan hệ Parent-Child**: `online_judge_submissions` là bản ghi **"Mẹ"** (tổng hợp), `online_judge_submission_details` là các bản ghi **"Con"** (từng testcase).

---

## Giai Đoạn 1 — Giao Việc (Initiation)

> **Mục tiêu**: Nhận code từ Frontend, gửi sang Judge0, rồi trả response ngay lập tức — **không chặn thread**.

### Sequence Diagram

```
  Frontend              Controller           OjSubmissionService         PostgreSQL          Judge0 API
     │                      │                        │                       │                    │
     │ POST /submissions    │                        │                       │                    │
     │─────────────────────>│                        │                       │                    │
     │                      │ @PreAuthorize check    │                       │                    │
     │                      │ submitCode(req, userId)│                       │                    │
     │                      │───────────────────────>│                       │                    │
     │                      │                        │ Query testcases       │                    │
     │                      │                        │──────────────────────>│                    │
     │                      │                        │ List<Testcase>        │                    │
     │                      │                        │<──────────────────────│                    │
     │                      │                        │                       │                    │
     │                      │                        │ Build Judge0SubmissionItem[]               │
     │                      │                        │ (attach callback_url to each)              │
     │                      │                        │                       │                    │
     │                      │                        │ POST /submissions/batch                    │
     │                      │                        │──────────────────────────────────────────-->│
     │                      │                        │ Token[] (1 UUID per testcase)              │
     │                      │                        │<──────────────────────────────────────────--│
     │                      │                        │                       │                    │
     │                      │                        │ Save parent Submission│                    │
     │                      │                        │──────────────────────>│                    │
     │                      │                        │ Save N Detail (PENDING)                    │
     │                      │                        │──────────────────────>│                    │
     │                      │                        │                       │                    │
     │                      │  OjSubmissionInitialResponse                   │                    │
     │                      │<───────────────────────│                       │                    │
     │ ApiResponse          │                        │                       │                    │
     │ {submissionId,PENDING}                        │                       │                    │
     │<─────────────────────│                        │                       │                    │
     │                      │                        │                       │                    │
     │ Subscribe WebSocket: /topic/submissions/{userId}                      │                    │
     │ Show loading UI...   │                        │                       │                    │
```

### Chi Tiết Từng Bước

#### Bước 1 — Frontend gửi yêu cầu

Frontend gửi `POST /online-judge/submissions` với body:

```json
{
  "problemId": 42,
  "lessonId": 10,
  "contestId": null,
  "languageId": 62,
  "sourceCode": "public class Main { ... }"
}
```

> `lessonId` và `contestId` **xác định ngữ cảnh** (Practice vs Contest). Chỉ một trong hai có giá trị, cái còn lại là `null`.

#### Bước 2 — Kiểm tra quyền (Controller)

```java
@PreAuthorize("hasAuthority('OJ_PROBLEM_SUBMIT') and " +
    "(@courseSecurity.canAccessProblem(#request.problemId) or " +
    " @courseSecurity.canAccessContest(#request.problemId))")
```

Controller trích `userId` từ JWT claim rồi delegate xuống `OjSubmissionService.submitCode()`.

#### Bước 3 — Lấy Testcases & Tạo Submission (Service)

```java
List<ProblemTestcaseEntity> testcases = problemTestcaseRepository
    .findByProblemIdOrderByOrderIndex(request.getProblemId());
```

Tạo bản ghi "Mẹ" `OnlineJudgeSubmissionEntity` với `verdict = PENDING`:

```java
OnlineJudgeSubmissionEntity submission = OnlineJudgeSubmissionEntity.builder()
    .user(userRepository.getReferenceById(userId))
    .problem(onlineJudgeProblemRepository.getReferenceById(request.getProblemId()))
    .languageId(request.getLanguageId())
    .sourceCode(request.getSourceCode())
    .verdict(OjVerdict.PENDING)
    .lesson(request.getLessonId() != null ? lessonRepository.getReferenceById(request.getLessonId()) : null)
    .contest(request.getContestId() != null ? contestRepository.getReferenceById(request.getContestId()) : null)
    .build();
```

#### Bước 4 — Đóng gói dữ liệu cho Judge0

Mỗi testcase được đóng gói thành một `Judge0SubmissionItem`:

```java
Judge0SubmissionItem item = Judge0SubmissionItem.builder()
    .languageId(request.getLanguageId())
    .sourceCode(request.getSourceCode())
    .stdin(testcase.getInputData())             // Input từ DB
    .expectedOutput(testcase.getExpectedOutput()) // Output mẫu từ DB
    .callbackUrl(webhookBaseUrl + "/online-judge/submissions") // WEBHOOK
    .cpuTimeLimit(timeLimitSeconds)              // Đã nhân hệ số theo ngôn ngữ
    .memoryLimit(problem.getMemoryLimitKb())
    .build();
```

> **Điểm then chốt**: `callbackUrl` chính là địa chỉ mà Judge0 sẽ **chủ động gọi về** sau khi chấm xong mỗi testcase.

**Hệ số nhân Time Limit theo ngôn ngữ**:

| Ngôn ngữ | Hệ số | Ghi chú |
|-----------|--------|---------|
| C / C++ / Go | `1.0×` | Compiled, cực nhanh |
| Java / C# | `2.0× + 1s` | JVM/CLR startup overhead |
| JavaScript / TypeScript | `2.0×` | Node.js JIT |
| Python | `3.0×` | Interpreted, chậm nhất |

#### Bước 5 — Gọi API Judge0 Batch

```java
List<Judge0TokenResponse> tokens = judge0ClientService.sendBatchSubmission(judge0BatchRequest);
```

Bên trong `Judge0ClientService`, WebClient gửi `POST /submissions/batch?base64_encoded=false` tới Judge0 với **3 lớp timeout bảo vệ** (TCP connect, response, read/write) được cấu hình trong `WebClientConfig`.

Judge0 trả về **ngay lập tức** danh sách token UUID — mỗi testcase một token.

#### Bước 6 — Lưu DB & Trả Response

```java
// Lưu Submission "Mẹ"
onlineJudgeSubmissionRepository.save(submission);

// Tạo & lưu N bản ghi "Con" (1 token mỗi testcase)
for (int i = 0; i < tokens.size(); i++) {
    OnlineJudgeSubmissionDetailEntity detail = OnlineJudgeSubmissionDetailEntity.builder()
        .submission(submission)
        .testcase(testcases.get(i))
        .token(tokens.get(i).getToken())   // UUID từ Judge0
        .verdict(OjVerdict.PENDING)
        .build();
}
onlineJudgeSubmissionDetailRepository.saveAll(details);
```

Response trả về Frontend:

```json
{
  "status": 200,
  "code": 1000,
  "result": {
    "submissionId": 123,
    "status": "PENDING",
    "message": "Submission received and is being processed."
  }
}
```

> **Toàn bộ method `submitCode()` chạy trong `@Transactional`** — nếu bất kỳ bước nào fail, mọi thứ rollback.

#### Bước 7 — Frontend lắng nghe WebSocket

Frontend nhận `submissionId`, mở kết nối WebSocket tới kênh `/topic/submissions/{userId}` và hiển thị giao diện "Đang chấm bài...".

```
WebSocket Endpoint: /ws (SockJS)
Subscribe Channel:  /topic/submissions/{userId}
```

---

## Giai Đoạn 2 — Xử Lý Ngầm (Background Execution)

> **Backend hoàn toàn rảnh rỗi** — không tốn CPU chờ đợi.

```
 ┌───────────────────┐        ┌─────────────────────────────┐        ┌──────────────────┐
 │  Judge0 Redis     │        │   Judge0 Worker             │        │  Backend         │
 │  Queue            │ Dequeue│   (Docker Sandbox)          │  PUT   │  Webhook         │
 │                   │───────>│                             │───────>│                  │
 │  Pending tasks    │        │  1. Compile source code     │        │  PUT /online-    │
 │  waiting...       │        │  2. Run with stdin          │  callback  judge/submissions│
 │                   │        │  3. Compare stdout vs       │  _url  │                  │
 │                   │        │     expected_output         │        │  (per testcase)  │
 └───────────────────┘        │  4. Record time & memory    │        └──────────────────┘
                              └─────────────────────────────┘
```

- Judge0 Worker lấy từng submission ra khỏi hàng đợi Redis nội bộ.
- Đưa code vào **Docker Sandbox** cô lập: biên dịch → chạy → so sánh output.
- Mỗi testcase chấm xong **độc lập** → gọi webhook ngay.

> **Lưu ý**: Các testcase có thể chấm xong **không theo thứ tự** `order_index` — testcase 5 có thể về trước testcase 2.

---

## Giai Đoạn 3 — Nhận Kết Quả Webhook (Callback Processing)

> Judge0 chấm xong mỗi testcase → chủ động gọi `PUT /online-judge/submissions` (webhook).

### Request từ Judge0

```json
{
  "token": "725fdde7-a23b-4c01-8f4a-...",
  "time": "0.045",
  "memory": 3584,
  "stdout": "Hello World",
  "stderr": null,
  "compile_output": null,
  "status": {
    "id": 3,
    "description": "Accepted"
  }
}
```

### Xử Lý Callback — `processJudge0Callback()`

Toàn bộ method chạy trong `@Transactional`.

#### Bước 1 — Tìm SubmissionDetail bằng Token

```java
OnlineJudgeSubmissionDetailEntity detail = onlineJudgeSubmissionDetailRepository
    .findByTokenWithSubmissionAndProblem(token)  // JOIN FETCH tối ưu
    .orElseThrow(() -> new AppException(ErrorCode.JUDGE0_SUBMISSION_FAILED));
```

> **Tối ưu N+1**: Query dùng `JOIN FETCH` lấy luôn Submission cha + Problem trong **1 câu SQL duy nhất**.

#### Bước 2 — Chuyển đổi trạng thái & Cập nhật DB

```java
OjVerdict testcaseVerdict = mapJudge0StatusToOjVerdict(payload.getStatus().getId());

detail.setVerdict(testcaseVerdict);
detail.setExecutionTimeMs(parseExecutionTime(payload.getTime())); // "0.045" → 45ms
detail.setMemoryUsedKb(payload.getMemory());
onlineJudgeSubmissionDetailRepository.save(detail);
```

**Bảng ánh xạ Judge0 Status → OjVerdict**:

| Judge0 Status ID | Judge0 Description | OjVerdict |
|------------------|--------------------|-----------|
| `3` | Accepted | `ACCEPTED` |
| `4` | Wrong Answer | `WRONG_ANSWER` |
| `5` | Time Limit Exceeded | `TIME_LIMIT_EXCEEDED` |
| `6` | Compilation Error | `COMPILATION_ERROR` |
| Khác | Runtime Error, etc. | `RUNTIME_ERROR` |

---

## Giai Đoạn 4 — Đếm, Rẽ Nhánh & Trả Kết Quả (Aggregation & Broadcast)

> Xảy ra **ngay sau Bước 2** trong cùng transaction. Đây là phần phức tạp nhất của workflow.

### Flowchart Tổng Thể

```
                    ┌──────────────────────────────────┐
                    │  Callback updated SubmissionDetail│
                    └──────────────┬───────────────────┘
                                   │
                                   ▼
                    ┌──────────────────────────────────┐
                    │  Contest Mode AND testcase failed?│
                    └──────┬───────────────────┬───────┘
                    YES    │                   │  NO
                           ▼                   │
              ┌────────────────────────┐        │
              │ Redis SET NX           │        │
              │ key: oj_failed:{id}    │        │
              └──────┬─────────────────┘        │
                     │                          │
                     ▼                          │
              ┌────────────────────┐            │
              │ setIfAbsent = true?│            │
              └──┬─────────────┬───┘            │
           YES   │             │ NO             │
                 ▼             │  (already      │
     ┌───────────────────┐     │   flagged)     │
     │ isEarlyFinish=true│     │                │
     │ verdict = current │     │                │
     └────────┬──────────┘     │                │
              │                │                │
              ▼                ▼                ▼
     ┌──────────────────────────────────────────────┐
     │  Redis INCR oj_progress:{submissionId}       │
     │  processedCount = atomic counter value       │
     └──────┬───────────────────────────┬───────────┘
            │                           │
            ▼                           ▼
 ┌─────────────────────────┐  ┌──────────────────────────┐
 │ processed == total      │  │ processed == total?      │
 │ AND no short-circuit?   │  │ (for cleanup)            │
 └───┬─────────────┬───────┘  └────┬─────────────┬───────┘
  YES│             │NO          YES│             │NO
     ▼             │               ▼             ▼
 ┌────────────┐    │     ┌────────────────┐   ┌──────┐
 │ Normal     │    │     │ Delete Redis   │   │ Done │
 │ Finish     │    │     │ keys: progress │   └──────┘
 │ find first │    │     │ + failed       │
 │ error by   │    │     └───────┬────────┘
 │ order_index│    │             │
 └─────┬──────┘    │             ▼
       │           │          ┌──────┐
       ▼           │          │ Done │
 ┌─────────────────────┐      └──────┘
 │ Update parent       │
 │ Submission:         │◄──── (also from isEarlyFinish)
 │ verdict, maxTime,   │
 │ maxMemory           │
 └────────┬────────────┘
          │
          ▼
 ┌──────────────────────┐
 │ Which mode?          │
 └──┬──────┬────────┬───┘
    │      │        │
    ▼      ▼        ▼
 ┌──────┐┌────────┐┌──────────────────┐
 │PRACT.││CONTEST ││CONTEST           │
 │      ││final   ││in progress       │
 │Push  ││Push WS ││                  │
 │WS per││final   ││Silent            │
 │test  ││only    ││(no WS push)      │
 │case  ││        ││                  │
 └──────┘└────────┘└──────────────────┘
```

### 4.1 — Redis Atomic Counter (Chống Race Condition)

Vì nhiều webhook callback có thể đến **đồng thời** từ các testcase khác nhau, hệ thống dùng Redis để đếm atomic:

```java
String redisKey = "oj_progress:" + submissionId;
String failedKey = "oj_failed:" + submissionId;

// Tăng đếm atomic — luôn chính xác dù 10 thread gọi cùng lúc
Long processedCount = stringRedisTemplate.opsForValue().increment(redisKey);

// TTL 1 giờ cho lần đầu tiên (phòng Judge0 chết giữa chừng)
if (processedCount == 1L) {
    stringRedisTemplate.expire(redisKey, Duration.ofHours(1));
}
```

### 4.2 — Short-Circuit (Tối ưu Contest Mode)

Trong Contest Mode, khi gặp testcase sai **đầu tiên**, hệ thống chốt sổ ngay mà không cần chờ tất cả testcase:

```java
if (isContestMode && testcaseVerdict != OjVerdict.ACCEPTED) {
    // setIfAbsent = SET NX → chỉ có 1 thread duy nhất (lỗi đầu tiên) set được
    Boolean isFirstFail = stringRedisTemplate.opsForValue()
        .setIfAbsent(failedKey, "1", Duration.ofHours(1));
    if (Boolean.TRUE.equals(isFirstFail)) {
        isEarlyFinish = true; // Thread này chốt sổ!
    }
}
```

> **Tại sao dùng `setIfAbsent`?** Vì nhiều testcase sai có thể đến đồng thời. `SET NX` đảm bảo chỉ **1 thread duy nhất** được quyền chốt sổ — tránh update DB nhiều lần.

### 4.3 — Xác Định Final Verdict

Có **2 cách** kết thúc submission:

| Kiểu | Điều kiện | Cách xác định Verdict |
|-------|-----------|----------------------|
| **Early Finish** | Contest + gặp lỗi đầu tiên | Dùng ngay verdict của testcase lỗi hiện tại |
| **Normal Finish** | `processedCount == totalTestcases` AND chưa bị short-circuit | Query DB tìm testcase lỗi đầu tiên theo `order_index`; nếu không có → `ACCEPTED` |

```java
if (isNormalFinish) {
    overallVerdict = onlineJudgeSubmissionDetailRepository
        .findFirstBySubmissionIdAndVerdictNotOrderByTestcaseOrderIndexAsc(submissionId, OjVerdict.ACCEPTED)
        .map(OnlineJudgeSubmissionDetailEntity::getVerdict)
        .orElse(OjVerdict.ACCEPTED);
}
```

### 4.4 — Cập Nhật Submission "Mẹ"

Khi đã xác định final verdict (Early hoặc Normal Finish):

```java
var maxStats = onlineJudgeSubmissionDetailRepository
    .findMaxStatsBySubmissionId(submissionId); // MAX(time), MAX(memory)

submissionEntity.setVerdict(overallVerdict);
submissionEntity.setExecutionTimeMs(maxStats.getMaxTime());
submissionEntity.setMemoryUsedKb(maxStats.getMaxMemory());
onlineJudgeSubmissionRepository.save(submissionEntity);
```

### 4.5 — Rẽ Nhánh WebSocket

Dữ liệu WebSocket gửi đi:

```java
OjWebSocketMessage wsMessage = OjWebSocketMessage.builder()
    .submissionId(submissionId)
    .testcaseId(detail.getTestcase().getId())
    .testcaseVerdict(testcaseVerdict)
    .overallVerdict(overallVerdict)       // PENDING nếu chưa xong, verdict cuối nếu xong
    .executionTimeMs(...)
    .memoryUsedKb(...)
    .totalTestcases(totalTestcases)
    .processedTestcases(processedCount)
    .build();
```

**3 nhánh WebSocket**:

```
┌─────────────────────────────────────────────────────────────────────┐
│                     PRACTICE MODE (lessonId != null)                │
│                                                                     │
│  Bắn WebSocket SAU MỖI testcase → Frontend cập nhật Progress Bar   │
│  Ví dụ: 1/10 → 2/10 → 3/10 → ... → 10/10 (kèm overallVerdict)    │
│                                                                     │
│  Channel: /topic/submissions/{userId}                               │
└─────────────────────────────────────────────────────────────────────┘

┌─────────────────────────────────────────────────────────────────────┐
│               CONTEST MODE — ĐÃ CHỐT SỔ (isEarlyFinish            │
│                              hoặc isNormalFinish)                   │
│                                                                     │
│  Bắn WebSocket 1 LẦN DUY NHẤT với overallVerdict                   │
│  testcaseId & testcaseVerdict = null (ém chi tiết)                  │
│                                                                     │
│  Channel: /topic/submissions/{userId}                               │
└─────────────────────────────────────────────────────────────────────┘

┌─────────────────────────────────────────────────────────────────────┐
│               CONTEST MODE — ĐANG CHẤM DỞ DANG                     │
│                                                                     │
│  IM LẶNG — không bắn WebSocket                                      │
│  (Bảo mật: không để Frontend biết kết quả từng testcase)            │
└─────────────────────────────────────────────────────────────────────┘
```

### 4.6 — Dọn Dẹp Redis

Khi **tất cả** webhook đã về đủ (kể cả trường hợp đã short-circuit sớm):

```java
if (processedCount.equals(totalTestcases.longValue())) {
    stringRedisTemplate.delete(redisKey);    // oj_progress:{id}
    stringRedisTemplate.delete(failedKey);   // oj_failed:{id}
}
```

> Việc dọn dẹp **luôn xảy ra khi đủ testcase**, không phụ thuộc vào việc đã chốt sổ hay chưa — đảm bảo Redis không bị rác.

---

## File Reference

| File | Vai trò |
|------|---------|
| `controller/oj/OnlineJudgeProblemController.java` | REST endpoints: `POST /submissions`, `PUT /submissions` (webhook) |
| `service/oj/OjSubmissionService.java` | Toàn bộ business logic: `submitCode()`, `processJudge0Callback()` |
| `service/oj/Judge0ClientService.java` | WebClient wrapper gọi Judge0 Batch API |
| `configuration/WebClientConfig.java` | Cấu hình WebClient với 3 lớp timeout (connect, response, read/write) |
| `configuration/WebSocketConfig.java` | STOMP broker: endpoint `/ws`, prefix `/topic` |
| `dto/judge0/Judge0SubmissionItem.java` | Request body gửi Judge0 (code + testcase + callback_url) |
| `dto/judge0/Judge0CallbackPayload.java` | Payload Judge0 gọi webhook về (token + status + time + memory) |
| `dto/judge0/Judge0BatchRequest.java` | Wrapper chứa `List<Judge0SubmissionItem>` |
| `dto/judge0/Judge0TokenResponse.java` | Token UUID trả về từ Judge0 |
| `dto/response/OjWebSocketMessage.java` | Message bắn qua WebSocket (verdict + progress) |
| `dto/request/OjSubmissionRequest.java` | Request body từ Frontend (problemId, sourceCode, languageId, ...) |
| `dto/response/OjSubmissionInitialResponse.java` | Response trả Frontend ngay (submissionId + PENDING) |
| `entity/oj/OnlineJudgeSubmissionEntity.java` | Entity "Mẹ" — bản ghi tổng submission |
| `entity/oj/OnlineJudgeSubmissionDetailEntity.java` | Entity "Con" — kết quả từng testcase (có token UUID) |
| `entity/oj/ProblemTestcaseEntity.java` | Testcase: input, expected_output, order_index |
| `entity/enums/OjVerdict.java` | Enum: PENDING, ACCEPTED, WRONG_ANSWER, TLE, CE, RE, MLE, ... |
| `repository/oj/OnlineJudgeSubmissionDetailRepository.java` | Queries: findByToken (JOIN FETCH), findFirstError, findMaxStats |
| `repository/projection/SubmissionMaxStats.java` | Projection interface: `getMaxTime()`, `getMaxMemory()` |

---

## Cấu Hình Liên Quan

```yaml
# application.yaml
judge0:
  base-url: http://localhost:2358          # Judge0 API endpoint
  timeout: 20s                              # WebClient timeout

app:
  webhook-base-url: http://192.168.1.90:8080/codelearning  # Judge0 gọi về đây

websocket:
  allowed-origins: http://localhost:3000,http://localhost:5173
```

> **Lưu ý**: `app.webhook-base-url` phải là địa chỉ mà Judge0 container có thể truy cập được. Khi dev local, dùng IP LAN thay vì `localhost`. Trong production, dùng domain hoặc ngrok.

---

## Tóm Tắt Luồng End-to-End

```
1. Frontend → POST /online-judge/submissions (code + problemId + lessonId/contestId)
2. Backend  → Validate → Tạo Submission PENDING → Đóng gói testcases
3. Backend  → POST Judge0 Batch API → Nhận tokens → Lưu DB → Trả submissionId
4. Frontend → Subscribe WebSocket /topic/submissions/{userId}
5. Judge0   → Docker Sandbox chạy code (Backend rảnh rỗi)
6. Judge0   → PUT /online-judge/submissions (webhook cho TỪNG testcase)
7. Backend  → Token → Tìm Detail → Cập nhật verdict → Redis INCR
8. Backend  → [Contest + Sai] → Short-circuit chốt sổ ngay
           → [Đủ testcase]   → Tìm lỗi đầu tiên → Final verdict
9. Backend  → WebSocket → Practice: bắn từng cái | Contest: bắn 1 lần cuối
10. Redis   → Dọn dẹp keys khi đủ testcase
```