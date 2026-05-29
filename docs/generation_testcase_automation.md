# Tài liệu Thiết kế Hệ thống: Luồng Tự động hóa Sinh Testcase Qua Judge0 Sandbox

Tài liệu này đặc tả kiến trúc hệ thống và quy trình thực hiện (Workflow) bất đồng bộ đối với tính năng tạo bài toán lập trình trực tiếp trên ứng dụng, kết hợp cơ chế tự sinh hàng loạt dữ liệu đầu vào (Input) và đầu ra mong muốn (Expected Output) dựa trên kịch bản (Script Generator) của Giảng viên/Admin. Luồng này sử dụng **kiến trúc Event-driven (Webhook) kết hợp Batch Submissions** để đạt hiệu năng tối đa, tương đồng với luồng chấm bài.

---

## 1. Cấu trúc Giao diện & DTO Đầu Vào (Payload)

Khi Admin/Teacher tạo một Problem và kích hoạt chế độ tự động sinh testcase, Frontend sẽ gửi một HTTP POST request tới Backend Spring Boot.

### 📥 API Endpoint
* **Method:** `POST`
* **URL:** `/api/v1/admin/problems/generate-testcases`
* **Access Control:** `@PreAuthorize("hasAuthority('PROBLEM_CREATE')")`

### 📦 Request Body (Payload DTO)
```json
{
  "title": "Tính tổng mảng số nguyên",
  "description": "Cho mảng A gồm N phần tử, hãy in ra tổng của chúng...",
  "timeLimit": 1.0,
  "memoryLimit": 128000,
  "totalTestcasesToGenerate": 20, 
  "generatorCode": "import random\nN = random.randint(5, 50)\nprint(N)\nprint(' '.join(str(random.randint(1, 100)) for _ in range(N)))",
  "solutionCode": "import sys\nlines = sys.stdin.read().split()\nif lines:\n    N = int(lines[0])\n    arr = [int(x) for x in lines[1:]]\n    print(sum(arr))"
}
```

## 2. Kiến trúc & Sơ đồ Vận hành Hệ thống

Hệ thống phân tách trách nhiệm (Decoupling) bằng Webhook. Server chính (Spring Boot) không bao giờ bị block để chờ Judge0. Judge0 xử lý hàng loạt (Batch) song song và gọi ngược về Backend.

```text
+------------------+                   +--------------------+                   +-----------------+
| Admin Dashboard  |                   | Spring Boot Server |                   | Judge0 Sandbox  |
+--------+---------+                   +---------+----------+                   +--------+--------|
         |                                       |                                       |
         |--- 1. POST (Tạo bài & Sinh test) ---->|                                       |
         |<-- 2. HTTP 202 Accepted (Trả ngay) ---|                                       |
         |                                       |--- 3. POST /submissions/batch ------->|
         |                                       |       (Gửi N lần Generator Code)      |
         |                                       |<-- 4. Trả về N Tokens (UUID) ---------|
         |                                       |                                       |
         |                                       |<== 5. Webhook: PUT /webhook/inputs ===|
         |                                       |      (N lần độc lập từ Judge0)        |
         |                                       |                                       |
         |                                       |--- 6. (Khi đủ N Input)                |
         |                                       |       POST /submissions/batch ------->|
         |                                       |       (Gửi N lần Solution + Input)    |
         |                                       |<-- 7. Trả về N Tokens (UUID) ---------|
         |                                       |                                       |
         |                                       |<== 8. Webhook: PUT /webhook/outputs ==|
         |                                       |      (N lần độc lập từ Judge0)        |
         |                                       |                                       |
         |<== 9. WebSocket: Hoàn tất (100%) ====|                                       |
```

## 3. Các Bước Xử Lý Chi Tiết Ở Backend (Workflow)

Với thiết kế không dùng `@Async` tuần tự, hệ thống dựa vào Webhook và Redis Atomic Counter để xử lý. Tiến trình chia làm 4 pha chính:

### 🔹 Pha 1: Tiếp nhận và Giao việc sinh Input (Initiation)
1. Backend nhận Payload từ Frontend, lưu `OnlineJudgeProblemEntity` với trạng thái ẩn (`is_active = false`).
2. Tạo trước N bản ghi `ProblemTestcaseEntity` trống (chưa có Input/Output) trong DB.
3. Đóng gói 1 lô (Batch) gồm N item gửi tới Judge0:
    * Mã nguồn (`source_code`): `generatorCode`.
    * Địa chỉ gọi lại (`callback_url`): `http://backend/api/v1/admin/webhooks/generate-inputs`.
4. Gọi API `/submissions/batch`. Lưu N `token` sinh ra vào các bản ghi Testcase tương ứng.
5. Trả về `202 Accepted` kèm `problemId`. Frontend bắt đầu lắng nghe WebSocket `/topic/testcase-generation/{problemId}`.

### 🔹 Pha 2: Nhận kết quả Input (Input Webhook Callback)
Judge0 chạy code Generator ở từng testcase xong sẽ lập tức gọi `PUT /api/v1/admin/webhooks/generate-inputs`.
1. Backend tìm Testcase theo `token` nhận được. Trích xuất trường `stdout` gán vào `inputData` và cập nhật DB.
2. Dùng Redis đếm số lượng: `INCR gen_input_progress:{problemId}`.
3. Nếu `INCR == totalTestcases` (tức là đã thu thập đủ N Inputs): Luồng của testcase cuối cùng sẽ tự động kích hoạt **Pha 3**.

### 🔹 Pha 3: Giao việc sinh Output (Solution Batch)
Ngay khi có đủ Input, Backend lập tức giao việc tiếp:
1. Load lại N bản ghi Testcase (vừa được cập nhật `inputData`) từ DB.
2. Tạo 1 batch gồm N item gửi tới Judge0:
    * Mã nguồn giải mẫu (`source_code`): `solutionCode`.
    * Đầu vào (`stdin`): Lấy từ trường `inputData` của DB.
    * Địa chỉ gọi lại (`callback_url`): `http://backend/api/v1/admin/webhooks/generate-outputs`.
3. Gọi API `/submissions/batch`. **Cập nhật lại N `token` mới** (UUID mới từ Judge0) vào các bản ghi Testcase trong DB.

### 🔹 Pha 4: Nhận kết quả Output (Output Webhook Callback)
Judge0 chạy xong code Giải Mẫu của từng testcase sẽ gọi `PUT /api/v1/admin/webhooks/generate-outputs`.
1. Tìm Testcase theo `token` mới. Trích xuất trường `stdout` gán vào `expectedOutput` và cập nhật DB.
2. Dùng Redis đếm tiến độ: `INCR gen_output_progress:{problemId}`.
3. Khi `INCR == totalTestcases` (Hoàn tất 100%):
    * Cập nhật Problem mẹ: `total_testcase = N`, `is_active = true`.
    * Dọn dẹp key trong Redis (`gen_input_progress:*`, `gen_output_progress:*`).
    * Gửi 1 tín hiệu WebSocket duy nhất `COMPLETED` cho Frontend báo hiệu bài tập đã tạo testcase thành công.

## 4. Thiết kế Thực thể & Cơ sở dữ liệu liên quan

### 📊 Thực thể Testcase (ProblemTestcaseEntity)
Bổ sung thêm trường `token` để tra cứu bản ghi khi nhận Webhook Callback từ Judge0.

```java
@Getter
@Setter
@Builder
@NoArgsConstructor
@AllArgsConstructor
@Entity
@Table(name = "problem_testcases")
public class ProblemTestcaseEntity extends BaseEntity {

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "problem_id", nullable = false)
    private OnlineJudgeProblemEntity problem;

    @Column(name = "token", unique = true)
    private String token; // Dùng để tra cứu nhanh khi Webhook gọi về (ghi đè khi từ Pha 2 sang Pha 4)

    @Column(name = "input_data", columnDefinition = "TEXT")
    private String inputData; // Cho phép null ban đầu, cập nhật ở Pha 2

    @Column(name = "expected_output", columnDefinition = "TEXT")
    private String expectedOutput; // Cho phép null ban đầu, cập nhật ở Pha 4

    @Column(name = "is_hidden", nullable = false)
    private boolean isHidden = true;

    @Column(name = "order_index", nullable = false)
    private int orderIndex;
}
```t kế Thực thể & Cơ sở dữ liệu liên quan

### 📊 Thực thể Testcase (ProblemTestcaseEntity)
Ánh xạ trực tiếp sang cấu trúc dữ liệu lưu trữ tại PostgreSQL:

```java
@Getter
@Setter
@Builder
@NoArgsConstructor
@AllArgsConstructor
@Entity
@Table(name = "problem_testcases")
public class ProblemTestcaseEntity extends BaseEntity {

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "problem_id", nullable = false)
    private OnlineJudgeProblemEntity problem;

    @Column(name = "input_data", nullable = false, columnDefinition = "TEXT")
    private String inputData;

    @Column(name = "expected_output", nullable = false, columnDefinition = "TEXT")
    private String expectedOutput;

    @Column(name = "is_hidden", nullable = false)
    private boolean isHidden = true;

    @Column(name = "order_index", nullable = false)
    private int orderIndex;
}
```