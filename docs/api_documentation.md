# TÀI LIỆU API HỆ THỐNG - CODELEARNING PLATFORM

Tài liệu này được biên soạn theo chuẩn Best Practice dành riêng cho **AI Agent** để phân tích và sinh mã nguồn giao diện (Frontend) tương thích 100% với hệ thống Backend hiện tại mà không bị lệch dữ liệu (data mismatch) hay xung đột.

---

## I. CẤU HÌNH HỆ THỐNG CHUNG

### 1. Base URL & CORS
- **Base URL Backend**: `http://localhost:8080/codelearning` (hoặc domain Production của bạn)
- **CORS Config**:
  - Cho phép các Origin: `http://localhost:3000`, `http://localhost:5173`
  - Hỗ trợ Credentials: `true` (Yêu cầu để gửi/nhận Cookie).

### 2. Xác thực & Authorization (Authentication & Session)
Hệ thống sử dụng **JWT Token** để xác thực, tích hợp qua hai phương thức:
1. **HttpOnly Cookie (Mặc định và Khuyên dùng)**: 
   - Cookie `access_token`: Chứa JWT Access Token (được áp dụng cho toàn bộ đường dẫn `/`).
   - Cookie `refresh_token`: Chứa JWT Refresh Token (được giới hạn path chỉ gửi lên cho các API bắt đầu bằng `/auth`, ví dụ `/auth/refresh` và `/auth/logout`).
2. **Bearer Token Header (Dự phòng)**:
   - Header `Authorization: Bearer <JWT_TOKEN>`

> [!NOTE]
> Khi gọi API Đăng nhập (`/auth/login`) hoặc Đăng ký (`/auth/register`), server sẽ tự động đính kèm Token vào Cookie của trình duyệt trong header `Set-Cookie`, đồng thời trả về thông tin user trong response body (các trường Token trong body sẽ trả về `null` vì lý do bảo mật).

---

## II. ĐỊNH NGHĨA DỮ LIỆU (TYPESCRIPT MODELS & ENUMS)

AI Agent khi code Frontend nên sử dụng trực tiếp các Model sau để tạo types/interfaces trong TypeScript:

### 1. Hệ thống Enums
```typescript
export enum ContestStatus {
  UPCOMING = "UPCOMING",
  RUNNING = "RUNNING",
  ENDED = "ENDED",
  CANCELLED = "CANCELLED"
}

export enum LessonStatus {
  DRAFT = "DRAFT",
  PUBLISHED = "PUBLISHED"
}

export enum ProblemDifficulty {
  EASY = "EASY",
  MEDIUM = "MEDIUM",
  HARD = "HARD"
}

export enum ProblemScope {
  LESSON = "LESSON",
  CONTEST = "CONTEST",
  SHARED = "SHARED",
  PRACTICE = "PRACTICE"
}

export enum ScoringRule {
  ICPC = "ICPC",
  IOI = "IOI",
  CUSTOM = "CUSTOM"
}

export enum OrderStatus {
  PENDING = "PENDING",
  COMPLETED = "COMPLETED",
  CANCELLED = "CANCELLED",
  FAILED = "FAILED"
}
```

### 2. Global Response Wrapper (Mẫu phản hồi API chung)
Mọi API trả về từ hệ thống đều được bọc trong cấu trúc chuẩn sau:
```typescript
export interface ApiResponse<T> {
  status: number;       // HTTP Status Code (vd: 200, 201, 400, 403, 500)
  code: number;         // Mã lỗi hệ thống nội bộ (Mặc định: 1000 = Thành công. Ngoại lệ: Module 9 Contest trả về 200 = Thành công)
  message: string;      // Thông điệp phản hồi từ server
  result: T;            // Dữ liệu payload thực tế trả về (Có thể là Object, Array hoặc null/void)
  timestamp: string;    // Thời gian ISO 8601 Date String
}

export interface PageResponse<T> {
  page: number;            // Chỉ mục trang hiện tại (0-indexed)
  size: number;            // Số phần tử tối đa trên một trang
  numberOfElements: number;// Số phần tử thực tế trong trang này
  totalElements: number;   // Tổng số phần tử trên toàn bộ các trang
  totalPages: number;      // Tổng số trang
  first: boolean;          // true nếu đây là trang đầu tiên
  last: boolean;           // true nếu đây là trang cuối cùng
  content: T[];            // Mảng dữ liệu payload thực tế
}

// Cấu trúc phân trang thô trả về trực tiếp từ Spring Data Page (áp dụng riêng cho các endpoint Bình luận bài học)
export interface SpringPageResponse<T> {
  content: T[];
  pageable: {
    sort: {
      empty: boolean;
      sorted: boolean;
      unsorted: boolean;
    };
    offset: number;
    pageNumber: number;
    pageSize: number;
    paged: boolean;
    unpaged: boolean;
  };
  last: boolean;
  totalPages: number;
  totalElements: number;
  first: boolean;
  size: number;
  number: number;          // Chỉ mục trang hiện tại (0-indexed)
  sort: {
    empty: boolean;
    sorted: boolean;
    unsorted: boolean;
  };
  numberOfElements: number;
  empty: boolean;
}
```

### 3. Thực thể (Entities / DTOs)
```typescript
export interface UserResponse {
  id: number;
  displayName: string;
  username: string;
  phoneNumber: string | null;
  email: string;
}

export interface TeacherResponse {
  id: number;
  fullName: string;
}

export interface CategoryResponse {
  id: number;
  name: string;
}

export interface CourseListItemResponse {
  id: number;
  title: string;
  shortDescription: string;
  thumbnailUrl: string;
  price: number;
  averageRating: number;
  totalReviews: number;
  totalEnrolled: number;
  enrolled: boolean;
  progressPercentage: number | null;
}

export interface CourseDetailResponse {
  id: number;
  title: string;
  shortDescription: string | null;
  thumbnailUrl: string | null;
  price: number;
  averageRating: number;
  totalReviews: number;
  totalEnrolled: number;
  courseContent: string | null;
  learningOutcomes: string | null;
  courseHighlights: string | null;
  technologiesTools: string | null;
  prerequisites: string | null;
  targetAudience: string | null;
  completionBenefits: string | null;
  estimatedDurationHours: number | null;
  totalLessons: number;
  totalQuizzes: number;
  totalAssignments: number;
  totalOnlineJudgeProblems: number;
  totalVideos: number;
  isEnrolled: boolean;
  instructors: TeacherResponse[];
  categories: CategoryResponse[];
  progressPercentage: number | null;
}

export interface ChapterResponse {
  id: number;
  title: string;
  orderIndex: number;
  lessonSummaryResponses: LessonSummaryResponse[];
}

export interface LessonSummaryResponse {
  id: number;
  title: string;
  orderIndex: number;
  estimatedDurationMinutes: number;
  trial: boolean;
  isCompleted: boolean;
}

export interface LessonDetailResponse {
  id: number;
  title: string;
  description: string | null;
  estimatedDurationMinutes: number | null;
  trial: boolean;
  videoUrl: string | null;
  theoryContent: string | null;
  sampleCode: string | null;
}

export interface LessonCommentResponse {
  id: number;
  userId: number;
  displayName: string;
  content: string;
  parentCommentId: number | null;
  createdAt: string; // ISO String
  updatedAt: string; // ISO String
  replyCount: number;
}

export interface LessonCompletionResponse {
  lessonId: number;
  courseId: number;
  completedLessonsCount: number;
  totalLessons: number;
  isCourseCompleted: boolean;
}

export interface QuizDetailResponse {
  id: number;
  title: string;
  description: string | null;
  questions: QuizQuestionResponse[];
  pastAttempt: QuizAttemptResponse | null;
}

export interface QuizQuestionResponse {
  id: number;
  questionContent: string;
  orderIndex: number;
  options: QuizOptionResponse[];
  userSelectedOptionId: number | null;
}

export interface QuizOptionResponse {
  id: number;
  content: string;
  isCorrect: boolean; // Chỉ trả về khi admin xem hoặc khi đã submit xong tùy nghiệp vụ
  orderIndex: number;
}

export interface QuizAttemptResponse {
  id: number;
  score: number;
  correctAnswers: number;
  totalQuestions: number;
  submittedAt: string; // ISO String
}

export interface QuizSubmitResponse {
  attemptId: number;
  quizId: number;
  totalQuestions: number;
  correctAnswers: number;
  score: number;
  submittedAt: string;
}

export interface OjPracticeProblemResponse {
  id: number;
  title: string;
  difficulty: ProblemDifficulty;
  isAccepted: boolean | null;
  totalSubmissions: number;
  totalAccepted: number;
  acceptanceRate: number;
}

export interface OjLessonProblemResponse {
  id: number;
  title: string;
  difficulty: ProblemDifficulty;
  isAccepted: boolean | null;
}

export interface OjContestProblemResponse {
  id: number;
  title: string;
  isAccepted: boolean | null;
}

export interface OjProblemDetailResponse {
  id: number;
  title: string;
  description: string | null;
  inputDescription: string | null;
  outputDescription: string | null;
  constraints: string | null;
  exampleInput: string | null;
  exampleOutput: string | null;
  hint: string | null;
  difficulty: ProblemDifficulty;
  latestSourceCode: string | null;
  isAccepted: boolean | null;
  tags: string[];
}

export interface OjSubmissionInitialResponse {
  submissionId: number;
  status: string; // "PENDING"
  message: string; // "Code is being judged..."
}

export interface ContestListResponse {
  id: number;
  title: string;
  startTime: string; // ISO String
  endTime: string; // ISO String
  status: ContestStatus;
  createdByTeacherName: string;
  numberOfParticipants: number;
  isPublic: boolean;
}

export interface ContestResponse {
  id: number;
  title: string;
  description: string | null;
  isProtected: boolean; // true nếu có đặt mật khẩu tham gia
  scoringRule: ScoringRule;
  startTime: string;
  endTime: string;
  status: ContestStatus;
  teacherName: string;
  createdAt: string;
}

export interface ContestLeaderboardResponse {
  contestId: number;
  title: string;
  startTime: string;
  endTime: string;
  status: string;
  leaderboard: ContestLeaderboardItemResponse[];
}

export interface ContestLeaderboardItemResponse {
  userId: number;
  username: string;
  problemsSolved: number;
  totalPenalty: number;
  rank: number;
  problemStatuses: ContestProblemStatusResponse[];
}

export interface ContestProblemStatusResponse {
  problemId: number;
  isSolved: boolean;
  failedAttemptsCount: number;
  solvedAtSeconds: number;
}

export interface CartResponse {
  id: number;
  items: CartItemResponse[];
}

export interface CartItemResponse {
  id: number;
  course: CourseListItemResponse;
}

export interface OrderCheckoutResponse {
  orderId: number;
  totalAmount: number;
  status: OrderStatus;
}

export interface PaymentDepositResponse {
  checkoutUrl: string;
  transactionCode: string;
}

export interface AuthenticationResponse {
  accessToken: string | null;
  refreshToken: string | null;
  id: number;
  displayName: string;
  email: string;
  phoneNumber: string | null;
  balance: number;
}

export interface CourseProgressResponse {
  courseId: number;
  title: string;
  thumbnailUrl: string | null;
  completedLessons: number;
  totalLessons: number;
  completionPercentage: number;
}

export enum OjVerdict {
  ACCEPTED = "ACCEPTED",
  WRONG_ANSWER = "WRONG_ANSWER",
  TIME_LIMIT_EXCEEDED = "TIME_LIMIT_EXCEEDED",
  MEMORY_LIMIT_EXCEEDED = "MEMORY_LIMIT_EXCEEDED",
  RUNTIME_ERROR = "RUNTIME_ERROR",
  COMPILE_ERROR = "COMPILE_ERROR",
  SYSTEM_ERROR = "SYSTEM_ERROR",
  PENDING = "PENDING",
  PROCESSING = "PROCESSING"
}

export interface OjWebSocketMessage {
  submissionId: number;
  testcaseId: number | null;
  testcaseVerdict: OjVerdict | null;
  overallVerdict: OjVerdict | null;
  executionTimeMs: number | null;
  memoryUsedKb: number | null;
  totalTestcases: number;
  processedTestcases: number;
  input: string | null;
  expectedOutput: string | null;
  actualOutput: string | null;
  compileOutput: string | null;
}

export interface OjTestcaseGenWsMessage {
  type: string;
  status: string;
  message: string;
}
```

---

## III. CHI TIẾT TÀI LIỆU API CATALOG (55 ENDPOINTS)

### MODULE 1: AUTHENTICATION (XÁC THỰC) - 4 APIs

#### 1. Đăng nhập
- **Method & URL**: `POST /auth/login`
- **Mục đích**: Xác thực người dùng, trả về thông tin user và đính kèm JWT vào cookie trình duyệt.
- **Yêu cầu JWT**: Không (Public).
- **Request Body (JSON)**:
  ```json
  {
    "username": "thanh123", // Bắt buộc
    "password": "mySecurePassword" // Bắt buộc
  }
  ```
- **Response (200 OK)**:
  ```json
  {
    "status": 200,
    "code": 1000,
    "message": "Login successfully",
    "result": {
      "accessToken": null, // Đã ẩn, được lưu ở Cookie HTTP-only "access_token"
      "refreshToken": null, // Đã ẩn, được lưu ở Cookie HTTP-only "refresh_token"
      "id": 1,
      "displayName": "Thanh Mi La",
      "email": "thanh@example.com",
      "phoneNumber": "0987654321",
      "balance": 0.00
    },
    "timestamp": "2026-06-16T13:00:00Z"
  }
  ```

#### 2. Đăng ký tài khoản
- **Method & URL**: `POST /auth/register`
- **Mục đích**: Đăng ký một tài khoản mới và đăng nhập tự động.
- **Yêu cầu JWT**: Không (Public).
- **Request Body (JSON)**:
  ```json
  {
    "displayName": "Thanh Mi La", // Bắt buộc, tối thiểu 4 kí tự
    "username": "thanh123", // Bắt buộc, tối thiểu 4 kí tự
    "phoneNumber": "0987654321", // Không bắt buộc, định dạng 10 số bắt đầu bằng 0
    "email": "thanh@example.com", // Bắt buộc, đúng định dạng email
    "password": "mySecurePassword", // Bắt buộc, tối thiểu 4 kí tự
    "confirmPassword": "mySecurePassword" // Bắt buộc, trùng khớp với password
  }
  ```
- **Response (200 OK)**: Trả về cấu trúc giống Đăng nhập thành công và đính kèm set-cookie.

#### 3. Đăng xuất
- **Method & URL**: `POST /auth/logout`
- **Mục đích**: Hủy phiên làm việc và xóa cookie JWT phía Client.
- **Yêu cầu JWT**: Có.
- **Response (200 OK)**: Xóa cookie thành công.
  ```json
  {
    "status": 200,
    "code": 1000,
    "message": "Logout successfully",
    "result": null,
    "timestamp": "2026-06-16T13:00:00Z"
  }
  ```

#### 4. Làm mới Token (Refresh Token)
- **Method & URL**: `POST /auth/refresh`
- **Mục đích**: Tự động lấy Access Token mới khi Access Token cũ hết hạn (sử dụng cookie `refresh_token`).
- **Yêu cầu JWT**: Không (Tự động đọc cookie).
- **Response (200 OK)**: Sinh token mới đính kèm cookie.

---

### MODULE 2: USER PROFILE & PROGRESS (THÔNG TIN CÁ NHÂN & TIẾN ĐỘ) - 4 APIs

#### 5. Lấy thông tin cá nhân hiện tại
- **Method & URL**: `GET /users/me`
- **Mục đích**: Trả về dữ liệu chi tiết của tài khoản đang đăng nhập.
- **Yêu cầu JWT**: Có (Quyền tối thiểu: `USER_VIEW`).
- **Response (200 OK)**: Trả về đối tượng `UserResponse`.

#### 6. Cập nhật thông tin cá nhân
- **Method & URL**: `PATCH /users/me`
- **Mục đích**: Chỉnh sửa các trường hiển thị của tài khoản hiện tại.
- **Yêu cầu JWT**: Có (Quyền tối thiểu: `USER_UPDATE`).
- **Request Body (JSON)**:
  ```json
  {
    "displayName": "Tên Hiển Thị Mới", // Không bắt buộc, tối thiểu 4 ký tự
    "phoneNumber": "0912345678" // Không bắt buộc, định dạng 10 số
  }
  ```
- **Response (200 OK)**: Trả về đối tượng `UserResponse` mới đã cập nhật.

#### 7. Thay đổi mật khẩu
- **Method & URL**: `PUT /users/me/password`
- **Mục đích**: Đổi mật khẩu. Sau khi đổi thành công hệ thống tự động đăng xuất để người dùng login lại.
- **Yêu cầu JWT**: Có (Quyền tối thiểu: `USER_UPDATE`).
- **Request Body (JSON)**:
  ```json
  {
    "oldPassword": "oldPassword123", // Bắt buộc, tối thiểu 4 ký tự
    "newPassword": "newPassword123", // Bắt buộc, tối thiểu 4 ký tự
    "confirmNewPassword": "newPassword123" // Bắt buộc, tối thiểu 4 ký tự
  }
  ```
- **Response (200 OK)**:
  ```json
  {
    "status": 200,
    "code": 1000,
    "message": "Password changed successfully. Please login again.",
    "result": null,
    "timestamp": "2026-06-16T13:00:00Z"
  }
  ```

#### 8. Lấy tiến độ các khóa học đang học
- **Method & URL**: `GET /users/me/progress/courses`
- **Mục đích**: Hiển thị trên Dashboard của học viên, danh sách các khóa học đã tham gia cùng tỉ lệ % hoàn thành.
- **Yêu cầu JWT**: Có (Quyền tối thiểu: `LEARNING_PROGRESS_VIEW_OWN`).
- **Response (200 OK)**: Trả về danh sách `CourseProgressResponse[]`.

---

### MODULE 3: COURSE MANAGEMENT (QUẢN LÝ KHÓA HỌC) - 4 APIs

#### 9. Lấy danh sách khóa học (Tìm kiếm/Phân trang)
- **Method & URL**: `GET /courses`
- **Mục đích**: Hiển thị ở trang danh sách khóa học ngoài homepage hoặc trang tìm kiếm.
- **Yêu cầu JWT**: Không (Public). Nếu gửi kèm JWT, sẽ trả thêm thông tin là user đã mua/đăng ký học khóa này chưa (`enrolled` field).
- **Query Parameters**:
  - `keyword` (string, optional): Tìm kiếm theo tiêu đề.
  - `categoryIds` (List<Long>, optional): Lọc theo danh mục.
  - `minPrice` / `maxPrice` (BigDecimal, optional): Lọc theo giá.
  - `minRating` / `maxRating` (Double, optional): Lọc theo đánh giá.
  - `teacherName` (string, optional): Tìm theo tên giảng viên.
  - `page` (int, default: `0`): Chỉ mục trang (bắt đầu từ 0).
  - `size` (int, default: `12`): Số phần tử trên một trang (tối đa 20).
  - `sortBy` (String[], default: `["totalEnrolled"]`): Trường sắp xếp.
  - `order` (String[], default: `["desc"]`): Hướng sắp xếp (`asc` / `desc`).
- **Response (200 OK)**: Trả về `PageResponse<CourseListItemResponse>`.

#### 10. Chi tiết một khóa học
- **Method & URL**: `GET /courses/{courseId}`
- **Mục đích**: Hiển thị trang Landing Page bán khóa học hoặc học tập.
- **Yêu cầu JWT**: Không (Public). Nếu gửi kèm JWT, sẽ xác định xem học viên đã mua khóa học hay chưa để mở nút "Vào học".
- **Path Variable**:
  - `courseId` (Long): ID của khóa học.
- **Response (200 OK)**: Trả về `CourseDetailResponse`.

#### 11. Giáo trình khóa học (Curriculum)
- **Method & URL**: `GET /courses/{courseId}/curriculum`
- **Mục đích**: Hiển thị danh sách outline gồm các Chương (Chapter) và tiêu đề Bài học (Lesson).
- **Yêu cầu JWT**: Không (Public). Nếu có JWT, sẽ hiển thị thêm bài học nào đã hoàn thành (`isCompleted: true`).
- **Path Variable**: `courseId` (Long)
- **Response (200 OK)**: Trả về `ChapterResponse[]`.

#### 12. Tạo mới khóa học
- **Method & URL**: `POST /courses`
- **Mục đích**: Tạo mới khóa học.
- **Yêu cầu JWT**: Có (Quyền tối thiểu: `COURSE_CREATE`).
- **Content-Type**: `multipart/form-data`
- **Request Parameters (Form Data)**:
  - `title` (string, required, tối đa 255 kí tự)
  - `shortDescription` (string, optional)
  - `courseContent` (string, optional)
  - `learningOutcomes` (string, optional)
  - `courseHighlights` (string, optional)
  - `technologiesTools` (string, optional)
  - `prerequisites` (string, optional)
  - `targetAudience` (string, optional)
  - `completionBenefits` (string, optional)
  - `price` (BigDecimal, required, tối thiểu là 0)
  - `estimatedDurationHours` (Integer, optional)
  - `thumbnailFile` (MultipartFile / File, optional): File ảnh thumbnail để upload
  - `categoryIds` (Set<Long>, optional): IDs của danh mục liên kết
- **Response (200 OK)**: Trả về `CourseDetailResponse` của khóa học vừa được tạo.

---

### MODULE 4: CHAPTERS (QUẢN LÝ CHƯƠNG HỌC) - 4 APIs

#### 13. Tạo chương học mới
- **Method & URL**: `POST /courses/{courseId}/chapters`
- **Mục đích**: Thêm một chương học mới vào khóa học.
- **Yêu cầu JWT**: Có (Quyền: `CHAPTER_CREATE` và phải là giáo viên quản lý khóa học này).
- **Path Variable**: `courseId` (Long)
- **Request Body (JSON)**:
  ```json
  {
    "title": "Chương 1: Giới thiệu căn bản" // Bắt buộc, tối đa 255 kí tự
  }
  ```
- **Response (200 OK)**: Trả về `ChapterResponse`.

#### 14. Cập nhật tên chương học
- **Method & URL**: `PUT /chapters/{chapterId}`
- **Mục đích**: Đổi tiêu đề chương học.
- **Yêu cầu JWT**: Có (Quyền: `CHAPTER_UPDATE` và sở hữu khóa học).
- **Path Variable**: `chapterId` (Long)
- **Request Body (JSON)**:
  ```json
  {
    "title": "Tiêu đề chương học mới" // Bắt buộc, tối đa 255 kí tự
  }
  ```
- **Response (200 OK)**: Trả về `ChapterResponse` sau khi sửa.

#### 15. Xóa chương học
- **Method & URL**: `DELETE /chapters/{chapterId}`
- **Mục đích**: Xóa chương học và các liên kết bên trong.
- **Yêu cầu JWT**: Có (Quyền: `CHAPTER_DELETE` và sở hữu khóa học).
- **Path Variable**: `chapterId` (Long)
- **Response (200 OK)**: Xóa thành công.

#### 16. Sắp xếp lại thứ tự các chương học (Reorder)
- **Method & URL**: `PUT /courses/{courseId}/chapters/reorder`
- **Mục đích**: Cập nhật lại thứ tự hiển thị (kéo thả chương học).
- **Yêu cầu JWT**: Có (Quyền: `CHAPTER_UPDATE` và sở hữu khóa học).
- **Path Variable**: `courseId` (Long)
- **Request Body (JSON)**:
  ```json
  [
    { "id": 12, "orderIndex": 0 },
    { "id": 15, "orderIndex": 1 }
  ]
  ```
- **Response (200 OK)**: Sắp xếp thành công.

---

### MODULE 5: LESSONS (QUẢN LÝ BÀI HỌC & TƯƠNG TÁC) - 10 APIs

#### 17. Xem chi tiết bài học (Học bài)
- **Method & URL**: `GET /lessons/{lessonId}`
- **Mục đích**: Trả về dữ liệu bài học (bao gồm link video, lý thuyết, code mẫu) để học viên bắt đầu học bài.
- **Yêu cầu JWT**: Không (Public ở mức Security, nhưng Service sẽ tự động chặn nếu là bài học tính phí và user chưa mua/đăng ký khóa học đó).
- **Path Variable**: `lessonId` (Long)
- **Response (200 OK)**: Trả về `LessonDetailResponse`.

#### 18. Lấy bài trắc nghiệm của bài học
- **Method & URL**: `GET /lessons/{lessonId}/quiz`
- **Mục đích**: Lấy các câu hỏi trắc nghiệm đi kèm bài học.
- **Yêu cầu JWT**: Có (Quyền: `QUIZ_VIEW` và đã mua khóa học).
- **Path Variable**: `lessonId` (Long)
- **Response (200 OK)**: Trả về `QuizDetailResponse`.

#### 19. Lấy danh sách bình luận bài học (Comments cha)
- **Method & URL**: `GET /lessons/{lessonId}/comments`
- **Mục đích**: Lấy danh sách các thảo luận chính (root comments) trong bài học (chưa kèm replies sâu).
- **Yêu cầu JWT**: Có (Quyền: `COMMENT_VIEW` và đã đăng ký học bài học này).
- **Path Variable**: `lessonId` (Long)
- **Query Parameters (Phân trang)**:
  - `page` (int, default: 0), `size` (int, default: 10), `sort` (default: "createdAt,asc")
- **Response (200 OK)**: Trả về `SpringPageResponse<LessonCommentResponse>`.

#### 20. Lấy danh sách phản hồi (Replies) của một bình luận
- **Method & URL**: `GET /lessons/{lessonId}/comments/{commentId}/replies`
- **Mục đích**: Mở rộng xem các phản hồi con bên dưới bình luận chính.
- **Yêu cầu JWT**: Có (Quyền: `COMMENT_VIEW` và đã đăng ký học).
- **Path Variables**: `lessonId` (Long), `commentId` (Long)
- **Response (200 OK)**: Trả về `SpringPageResponse<LessonCommentResponse>`.

#### 21. Đăng bình luận / Phản hồi bình luận khác
- **Method & URL**: `POST /lessons/{lessonId}/comments`
- **Mục đích**: Gửi một thảo luận mới vào bài học.
- **Yêu cầu JWT**: Có (Quyền: `COMMENT_CREATE`).
- **Path Variable**: `lessonId` (Long)
- **Request Body (JSON)**:
  ```json
  {
    "content": "Bài học rất bổ ích, cảm ơn giảng viên!", // Bắt buộc, không được trống
    "parentCommentId": null // Gửi Long nếu là reply một comment khác, gửi null nếu là comment mới
  }
  ```
- **Response (200 OK)**: Trả về `LessonCommentResponse` vừa được lưu vào DB.

#### 22. Hoàn thành bài học
- **Method & URL**: `POST /lessons/{lessonId}/complete`
- **Mục đích**: Đánh dấu bài học này học viên đã học xong (để hiển thị tick xanh và tính tiến độ %).
- **Yêu cầu JWT**: Có (Quyền: `LESSON_COMPLETE`).
- **Path Variable**: `lessonId` (Long)
- **Response (200 OK)**: Trả về `LessonCompletionResponse`.

#### 23. Tạo bài học mới trong chương học
- **Method & URL**: `POST /lessons/chapters/{chapterId}/lessons`
- **Mục đích**: Thêm bài học mới.
- **Yêu cầu JWT**: Có (Quyền: `LESSON_CREATE` và là giáo viên quản lý chương học).
- **Path Variable**: `chapterId` (Long)
- **Content-Type**: `multipart/form-data`
- **Request Parameters (Form Data)**:
  - `title` (string, required, tối đa 255 kí tự)
  - `description` (string, optional)
  - `theoryContent` (string, optional)
  - `trial` (Boolean, optional, default: false)
  - `estimatedDurationMinutes` (Integer, optional)
  - `status` (LessonStatus, default: `DRAFT`)
  - `videoFile` (MultipartFile / File, optional): File video bài giảng upload
- **Response (200 OK)**: Trả về `LessonDetailResponse`.

#### 24. Cập nhật bài học
- **Method & URL**: `PUT /lessons/{lessonId}`
- **Mục đích**: Sửa đổi nội dung bài học.
- **Yêu cầu JWT**: Có (Quyền: `LESSON_UPDATE`).
- **Path Variable**: `lessonId` (Long)
- **Content-Type**: `multipart/form-data`
- **Request Parameters (Form Data)**: Giống API Tạo bài học mới, bổ sung thêm trường `sampleCode` (string, optional).
- **Response (200 OK)**: Trả về `LessonDetailResponse`.

#### 25. Xóa bài học
- **Method & URL**: `DELETE /lessons/{lessonId}`
- **Mục đích**: Xóa vĩnh viễn bài học khỏi chương học.
- **Yêu cầu JWT**: Có (Quyền: `LESSON_DELETE`).
- **Path Variable**: `lessonId` (Long)
- **Response (200 OK)**: Xóa thành công.

#### 26. Sắp xếp thứ tự các bài học trong chương (Reorder)
- **Method & URL**: `PUT /lessons/chapters/{chapterId}/lessons/reorder`
- **Mục đích**: Kéo thả đổi thứ tự bài học trong một chương.
- **Yêu cầu JWT**: Có (Quyền: `LESSON_UPDATE` và sở hữu chương học).
- **Path Variable**: `chapterId` (Long)
- **Request Body (JSON)**:
  ```json
  [
    { "id": 101, "orderIndex": 0 },
    { "id": 102, "orderIndex": 1 }
  ]
  ```
- **Response (200 OK)**: Sắp xếp thành công.

---

### MODULE 6: QUIZZES (BÀI TRẮC NGHIỆM) - 4 APIs

#### 27. Nộp bài trắc nghiệm
- **Method & URL**: `POST /quizzes/{quizId}/submit`
- **Mục đích**: Gửi các phương án đã chọn của học viên để chấm điểm.
- **Yêu cầu JWT**: Có (Quyền: `QUIZ_SUBMIT`).
- **Path Variable**: `quizId` (Long)
- **Request Body (JSON)**:
  ```json
  {
    "submissions": [
      { "questionId": 1, "selectedOptionId": 3 },
      { "questionId": 2, "selectedOptionId": 6 }
    ]
  }
  ```
- **Response (200 OK)**: Trả về kết quả thi `QuizSubmitResponse`.

#### 28. Tạo bài trắc nghiệm cho bài học
- **Method & URL**: `POST /lessons/{lessonId}/quiz`
- **Mục đích**: Thêm bộ câu hỏi kiểm tra vào bài học.
- **Yêu cầu JWT**: Có (Quyền: `QUIZ_CREATE_ASSIGNED_COURSE`).
- **Path Variable**: `lessonId` (Long)
- **Request Body (JSON)**:
  ```json
  {
    "title": "Bài test kiến thức biến số",
    "description": "Hãy làm các câu hỏi trắc nghiệm dưới đây",
    "questions": [
      {
        "id": null,
        "questionContent": "Từ khóa nào khai báo biến hằng trong JS?",
        "orderIndex": 0,
        "options": [
          { "id": null, "content": "var", "isCorrect": false, "orderIndex": 0 },
          { "id": null, "content": "const", "isCorrect": true, "orderIndex": 1 }
        ]
      }
    ]
  }
  ```
- **Response (200 OK)**: Tạo thành công.

#### 29. Cập nhật bài trắc nghiệm
- **Method & URL**: `PUT /lessons/{lessonId}/quiz`
- **Mục đích**: Thay đổi câu hỏi/đáp án.
- **Yêu cầu JWT**: Có (Quyền: `QUIZ_UPDATE_ASSIGNED_COURSE`).
- **Path Variable**: `lessonId` (Long)
- **Request Body (JSON)**: Giống cấu trúc tạo mới ở trên (truyền thêm `id` của câu hỏi/đáp án nếu là sửa, truyền `null` nếu là thêm câu hỏi/đáp án mới).
- **Response (200 OK)**: Sửa thành công.

#### 30. Xóa bài trắc nghiệm của bài học
- **Method & URL**: `DELETE /lessons/{lessonId}/quiz`
- **Mục đích**: Xóa bài trắc nghiệm của bài học.
- **Yêu cầu JWT**: Có (Quyền: `QUIZ_DELETE_ASSIGNED_COURSE`).
- **Path Variable**: `lessonId` (Long)
- **Response (200 OK)**: Xóa thành công.

---

### MODULE 7: ENROLLMENTS (ĐĂNG KÝ HỌC) - 1 API

#### 31. Đăng ký học khóa học miễn phí
- **Method & URL**: `POST /enrollments/free/{courseId}`
- **Mục đích**: Đăng ký học lập tức khi bấm vào một khóa học miễn phí.
- **Yêu cầu JWT**: Có.
- **Path Variable**: `courseId` (Long)
- **Response (200 OK)**: Đăng ký thành công.

---

### MODULE 8: ONLINE JUDGE (LUYỆN LẬP TRÌNH VÀ CHẤM CODE) - 9 APIs

#### 32. Lấy danh sách bài tập luyện tập (OJ Practice)
- **Method & URL**: `GET /online-judge/problems/practice`
- **Mục đích**: Hiển thị kho bài tập luyện thuật toán cộng đồng (không phụ thuộc vào bài học).
- **Yêu cầu JWT**: Không (Public). Nếu có JWT, sẽ hiện trạng thái bài đó user đã làm đúng (`isAccepted: true`) chưa.
- **Query Parameters**:
  - `keyword` (string, optional)
  - `tagIds` (List<Long>, optional)
  - `difficulties` (List<ProblemDifficulty>, optional: `EASY`, `MEDIUM`, `HARD`)
  - `isAccepted` (Boolean, optional)
  - `page` (int, default: 0), `size` (int, default: 12), `sortBy` (default: "totalSubmissions"), `order` (default: "desc")
- **Response (200 OK)**: Trả về `PageResponse<OjPracticeProblemResponse>`.

#### 33. Lấy danh sách bài tập OJ của bài học
- **Method & URL**: `GET /online-judge/problems`
- **Mục đích**: Danh sách các bài code của riêng một bài học cụ thể.
- **Yêu cầu JWT**: Có (Quyền: `OJ_PROBLEM_VIEW` và đã mở khóa bài học).
- **Query Parameters**:
  - `lessonId` (Long, required)
- **Response (200 OK)**: Trả về `OjLessonProblemResponse[]`.

#### 34. Xem chi tiết đề bài tập OJ
- **Method & URL**: `GET /online-judge/problems/{problemId}`
- **Mục đích**: Hiển thị mô tả đề bài, ví dụ đầu vào/đầu ra, giới hạn thời gian, bộ nhớ và code nộp gần nhất (nếu có).
- **Query Parameters**:
  - `contestId` (Long, optional): ID của cuộc thi. Nếu truyền tham số này, hệ thống sẽ lọc trạng thái `latestSourceCode` và `isAccepted` giới hạn theo phạm vi cuộc thi hiện tại.
- **Lưu ý**:
  - Trường `difficulty` sẽ luôn là `null` nếu bài tập thuộc bất kỳ cuộc thi (Contest) nào.
  - Trường `latestSourceCode` và `isAccepted` sẽ trả về `null` nếu bài tập thuộc cuộc thi nhưng người dùng gọi API mà không truyền `contestId`.
- **Yêu cầu JWT**: Có (Quyền: `OJ_PROBLEM_VIEW` và đã mở khóa bài tập).
- **Path Variable**: `problemId` (Long)
- **Response (200 OK)**: Trả về `OjProblemDetailResponse`.

#### 34a. Xem lịch sử nộp bài tập OJ của người dùng
- **Method & URL**: `GET /online-judge/problems/{problemId}/submissions`
- **Mục đích**: Lấy danh sách lịch sử các lần nộp bài (submission) của người dùng hiện tại đối với bài tập cụ thể.
- **Yêu cầu JWT**: Có.
- **Path Variable**: `problemId` (Long)
- **Query Parameters**:
  - `page` (Integer, mặc định: 0)
  - `size` (Integer, mặc định: 10)
- **Response (200 OK)**:
  ```json
  {
    "status": 200,
    "code": 1000,
    "message": "Get problem submissions successfully",
    "result": {
      "page": 0,
      "size": 10,
      "numberOfElements": 1,
      "totalElements": 1,
      "totalPages": 1,
      "first": true,
      "last": true,
      "content": [
        {
          "id": 42,
          "language": "Java",
          "verdict": "ACCEPTED",
          "executionTimeMs": 45,
          "memoryUsedKb": 2048,
          "submittedAt": "2026-06-16T18:13:03.102Z"
        }
      ]
    },
    "timestamp": "2026-06-16T18:54:12.321Z"
  }
  ```

#### 35. Nộp code chạy thử/chấm bài
- **Method & URL**: `POST /online-judge/submissions`
- **Mục đích**: Gửi source code người dùng lên hệ thống chấm điểm tự động. Hệ thống sẽ lưu và gửi tiếp sang Judge0 API.
- **Yêu cầu JWT**: Có (Quyền: `OJ_PROBLEM_SUBMIT`).
- **Request Body (JSON)**:
  ```json
  {
    "problemId": 105, // Bắt buộc
    "lessonId": 3, // Điền nếu nộp trong bài học, có thể null
    "contestId": null, // Điền nếu nộp trong cuộc thi, có thể null
    "languageId": 71, // Bắt buộc (ID ngôn ngữ của Judge0, ví dụ: 71 = Python, 62 = Java, 54 = C++)
    "sourceCode": "print(int(input()) * 2)" // Bắt buộc
  }
  ```
- **Response (200 OK)**: Trả về trạng thái chờ chấm ngay lập tức.
  ```json
  {
    "status": 200,
    "code": 1000,
    "message": "Submit problem successfully",
    "result": {
      "submissionId": 401,
      "status": "PENDING",
      "message": "Code is being judged..."
    },
    "timestamp": "2026-06-16T13:00:00Z"
  }
  ```

#### 36. [WEBHOOK] Nhận kết quả từ Judge0 Server
- **Method & URL**: `PUT /online-judge/submissions`
- **Mục đích**: Nhận dữ liệu chấm xong từ Judge0 (Webhooks). API này do Judge0 server tự động gọi.
- **Yêu cầu JWT**: Không.
- **Response (200 OK)**: Xử lý thành công. Trả về đối tượng `ApiResponse<Void>` (chú ý: HTTP Status thực tế là 200 OK, nhưng trường `status` bên trong JSON body có giá trị là 204).

#### 37. Khởi tạo sinh bộ Testcase tự động (dành cho Admin/Teacher)
- **Method & URL**: `POST /online-judge/problems/{problemId}/generate-testcases`
- **Mục đích**: Sinh tự động testcases từ code sinh testcase (Generator) và code lời giải mẫu (Solution).
- **Yêu cầu JWT**: Có (Quyền: `PROBLEM_UPDATE`).
- **Path Variable**: `problemId` (Long)
- **Request Body (JSON)**:
  ```json
  {
    "totalTestcasesToGenerate": 10, // Số testcase muốn sinh tự động
    "generatorCode": "import random; print(random.randint(1, 100))", // Code sinh dữ liệu input
    "solutionCode": "n = int(input()); print(n * 2)", // Code giải mẫu để lấy output chuẩn
    "generatorLanguageId": 71,
    "solutionLanguageId": 71
  }
  ```
- **Response (202 Accepted)**:
  ```json
  {
    "status": 202,
    "code": 1000,
    "message": "Testcase generation started",
    "result": null,
    "timestamp": "2026-06-16T13:00:00Z"
  }
  ```

#### 38. [WEBHOOK] Nhận dữ liệu sinh Input tự động
- **Method & URL**: `PUT /online-judge/webhooks/generate-inputs`
- **Mục đích**: Nhận kết quả sinh testcase input từ Judge0.
- **Yêu cầu JWT**: Không.
- **Response (200 OK)**: Xử lý thành công.

#### 39. [WEBHOOK] Nhận dữ liệu sinh Output tự động
- **Method & URL**: `PUT /online-judge/webhooks/generate-outputs`
- **Mục đích**: Nhận kết quả giải mẫu tương ứng với input vừa sinh để hoàn tất lưu cặp testcase vào DB.
- **Yêu cầu JWT**: Không.
- **Response (200 OK)**: Xử lý thành công.

#### 40. Thêm bài tập mới vào Ngân hàng đề (Admin)
- **Method & URL**: `POST /online-judge/admin/problems`
- **Mục đích**: Quản trị viên khởi tạo bài tập lập trình mới lên hệ thống.
- **Yêu cầu JWT**: Có (Quyền: `OJ_PROBLEM_CREATE`).
- **Request Body (JSON)**:
  ```json
  {
    "title": "A cộng B", // Bắt buộc
    "description": "Nhập vào 2 số nguyên A, B. Hãy in ra tổng của chúng.",
    "inputDescription": "Một dòng duy nhất chứa A, B cách nhau khoảng trắng.",
    "outputDescription": "Một số nguyên duy nhất là kết quả.",
    "constraints": "-10^9 <= A, B <= 10^9",
    "exampleInput": "2 3",
    "exampleOutput": "5",
    "hint": "Dùng toán tử cộng thông thường.",
    "problemScope": "PRACTICE", // Xem enum ProblemScope
    "difficulty": "EASY", // Xem enum ProblemDifficulty
    "timeLimitMs": 1000, // Tối thiểu 1000
    "memoryLimitKb": 262144, // Tối thiểu 256MB
    "score": 10.00,
    "tagIds": [1, 2] // Danh sách ID thẻ thuật toán (vd: Dynamic Programming, Math,...)
  }
  ```
- **Response (200 OK)**: Trả về ID bài tập vừa được tạo thành công dưới dạng `ApiResponse<Long>`.

---

### MODULE 9: CONTESTS (QUỘC THI LẬP TRÌNH) - 8 APIs

#### 41. Danh sách các cuộc thi (Contest List)
- **Method & URL**: `GET /contests`
- **Mục đích**: Xem danh sách cuộc thi đang diễn ra, sắp diễn ra và đã kết thúc.
- **Yêu cầu JWT**: Không (Public).
- **Query Parameters**:
  - `page` (int, default: 0), `size` (int, default: 10)
- **Response (200 OK)**: Trả về `PageResponse<ContestListResponse>`.

#### 42. Tạo cuộc thi lập trình mới
- **Method & URL**: `POST /contests`
- **Mục đích**: Tạo một cuộc thi mới (chỉ dành cho giáo viên/admin).
- **Yêu cầu JWT**: Có (Quyền: `CONTEST_CREATE`).
- **Request Body (JSON)**:
  ```json
  {
    "title": "Kỳ thi lập trình ACM-ICPC Lần 1", // Bắt buộc
    "description": "Cuộc thi dành cho sinh viên năm 1",
    "password": "contestPassword123", // Không bắt buộc, điền nếu muốn bảo mật
    "scoringRule": "ICPC", // Hoặc "OI", "CUSTOM" (Xem enum ScoringRule)
    "startTime": "2026-06-20T08:00:00+07:00", // Bắt buộc, định dạng tương lai ISO ZonedDateTime
    "endTime": "2026-06-20T11:00:00+07:00" // Bắt buộc, tương lai
  }
  ```
- **Response (200 OK)**: Trả về `ContestResponse` chi tiết cuộc thi.

#### 43. Cập nhật thông tin cuộc thi
- **Method & URL**: `PUT /contests/{id}`
- **Mục đích**: Sửa đổi tiêu đề, mô tả, luật chấm điểm hoặc mật khẩu cuộc thi.
- **Yêu cầu JWT**: Có (Quyền: `CONTEST_UPDATE_OWN`).
- **Path Variable**: `id` (Long) - ID cuộc thi
- **Request Body (JSON)**:
  ```json
  {
    "title": "ACM-ICPC Lần 1 (Đã cập nhật)",
    "description": "Mô tả mới",
    "oldPassword": "contestPassword123",
    "newPassword": "newPasswordContest123",
    "scoringRule": "ICPC",
    "startTime": "2026-06-20T08:00:00+07:00",
    "endTime": "2026-06-20T11:00:00+07:00"
  }
  ```
- **Response (200 OK)**: Trả về `ContestResponse`.

#### 43a. Lấy danh sách bài tập của cuộc thi
- **Method & URL**: `GET /contests/{id}/problems`
- **Mục đích**: Lấy danh sách các bài tập thuộc cuộc thi.
- **Lưu ý**: Trạng thái `isAccepted` trả về `true` khi và chỉ khi người dùng đã có bài nộp được chấm `ACCEPTED` trong phạm vi cuộc thi hiện tại (không tính kết quả nộp ở phần luyện tập hoặc cuộc thi khác).
- **Yêu cầu JWT**: Có.
- **Path Variable**: `id` (Long) - ID cuộc thi
- **Response (200 OK)**: Trả về `OjContestProblemResponse[]`.
  ```json
  {
    "status": 200,
    "code": 200,
    "message": "Fetched contest problems successfully",
    "result": [
      {
        "id": 1,
        "title": "A cộng B",
        "isAccepted": true
      },
      {
        "id": 2,
        "title": "Sắp xếp mảng",
        "isAccepted": false
      }
    ],
    "timestamp": "2026-06-16T18:54:12.321Z"
  }
  ```

#### 44. Thêm bài tập từ ngân hàng đề vào cuộc thi
- **Method & URL**: `POST /contests/{id}/problems`
- **Mục đích**: Gán các bài tập lập trình vào bộ đề thi của cuộc thi này.
- **Yêu cầu JWT**: Có (Quyền: `CONTEST_PROBLEM_ADD_OWN`).
- **Path Variable**: `id` (Long)
- **Request Body (JSON)**:
  ```json
  {
    "problemIds": [101, 102, 103] // Bắt buộc, danh sách ID bài tập
  }
  ```
- **Response (200 OK)**: Gán thành công.

#### 45. Đổi thứ tự hiển thị các bài tập trong cuộc thi (Reorder)
- **Method & URL**: `PUT /contests/{id}/problems/reorder`
- **Mục đích**: Sắp xếp lại thứ tự bài tập hiển thị (vd: Bài A, Bài B, Bài C...).
- **Yêu cầu JWT**: Có (Quyền: `CONTEST_UPDATE_OWN`).
- **Path Variable**: `id` (Long)
- **Request Body (JSON)**:
  ```json
  [
    { "problemId": 102, "orderIndex": 0 },
    { "problemId": 101, "orderIndex": 1 }
  ]
  ```
- **Response (200 OK)**: Sắp xếp thành công.

#### 46. Xóa bài tập khỏi cuộc thi
- **Method & URL**: `DELETE /contests/{id}/problems/{problemId}`
- **Mục đích**: Gỡ một bài tập khỏi cuộc thi (Chỉ gỡ liên kết, không xóa bài tập gốc).
- **Yêu cầu JWT**: Có (Quyền: `CONTEST_PROBLEM_REMOVE_OWN`).
- **Path Variables**: `id` (Long), `problemId` (Long)
- **Response (200 OK)**: Gỡ bài tập thành công.

#### 47. Lấy bảng xếp hạng cuộc thi (Leaderboard)
- **Method & URL**: `GET /contests/{id}/leaderboard`
- **Mục đích**: Xem kết quả xếp hạng thời gian thực của các thí sinh tham gia cuộc thi (tính theo Penalty và số bài AC).
- **Yêu cầu JWT**: Không (Public).
- **Path Variable**: `id` (Long)
- **Response (200 OK)**: Trả về `ContestLeaderboardResponse`.

#### 48. Đăng ký tham dự cuộc thi (Register Contest)
- **Method & URL**: `POST /contests/{id}/register`
- **Mục đích**: Ghi danh thí sinh vào danh sách tham gia cuộc thi trước khi bắt đầu.
- **Yêu cầu JWT**: Có (Người dùng bất kỳ đã login).
- **Path Variable**: `id` (Long)
- **Request Body (JSON)**:
  ```json
  {
    "password": "contestPassword123" // Chỉ truyền nếu cuộc thi có cài đặt password tham gia
  }
  ```
- **Response (200 OK)**: Đăng ký tham gia thành công.

#### 48a. Xem lịch sử nộp bài của bản thân trong cuộc thi
- **Method & URL**: `GET /contests/{id}/submissions`
- **Mục đích**: Lấy danh sách lịch sử nộp bài (submissions) của người dùng hiện tại trong cuộc thi cụ thể (bao gồm tất cả các bài nộp cho nhiều đề bài khác nhau thuộc cuộc thi này).
- **Yêu cầu JWT**: Có.
- **Path Variable**: `id` (Long) - ID của cuộc thi.
- **Query Parameters**:
  - `page` (Integer, mặc định: 0)
  - `size` (Integer, mặc định: 10)
- **Response (200 OK)**:
  ```json
  {
    "status": 200,
    "code": 200,
    "message": "Fetched contest submissions successfully",
    "result": {
      "page": 0,
      "size": 10,
      "numberOfElements": 1,
      "totalElements": 1,
      "totalPages": 1,
      "first": true,
      "last": true,
      "content": [
        {
          "id": 127,
          "problemId": 5,
          "language": "Java",
          "verdict": "ACCEPTED",
          "executionTimeMs": 110,
          "memoryUsedKb": 4096,
          "submittedAt": "2026-06-16T18:13:03.102Z"
        }
      ]
    },
    "timestamp": "2026-06-16T18:54:12.321Z"
  }
  ```

---

### MODULE 10: CARTS (GIỎ HÀNG KHÓA HỌC) - 4 APIs

#### 49. Xem giỏ hàng cá nhân
- **Method & URL**: `GET /carts`
- **Mục đích**: Hiển thị danh sách khóa học đang chờ thanh toán của người dùng hiện tại.
- **Yêu cầu JWT**: Có.
- **Response (200 OK)**: Trả về `CartResponse`.

#### 50. Thêm khóa học vào giỏ hàng
- **Method & URL**: `POST /carts/items`
- **Mục đích**: Thêm khóa học trả phí vào giỏ hàng từ trang Landing Page.
- **Yêu cầu JWT**: Có.
- **Request Body (JSON)**:
  ```json
  {
    "courseId": 2 // Bắt buộc
  }
  ```
- **Response (200 OK)**: Trả về `CartResponse` mới cập nhật đầy đủ items.

#### 51. Xóa khóa học khỏi giỏ hàng
- **Method & URL**: `DELETE /carts/items/{courseId}`
- **Mục đích**: Loại bỏ một khóa học ra khỏi danh sách giỏ hàng.
- **Yêu cầu JWT**: Có.
- **Path Variable**: `courseId` (Long)
- **Response (200 OK)**: Trả về `CartResponse` sau khi xóa.

#### 52. Dọn sạch giỏ hàng (Clear Cart)
- **Method & URL**: `DELETE /carts/items`
- **Mục đích**: Xóa sạch toàn bộ khóa học trong giỏ hàng.
- **Yêu cầu JWT**: Có.
- **Response (200 OK)**: Xóa sạch thành công.

---

### MODULE 11: ORDERS (ĐƠN HÀNG) - 1 API

#### 53. Khởi tạo đơn hàng (Order Checkout)
- **Method & URL**: `POST /orders/checkout`
- **Mục đích**: Bấm mua/thanh toán các khóa học đã chọn. Hệ thống tạo hóa đơn với trạng thái `PENDING`.
- **Yêu cầu JWT**: Có.
- **Request Body (JSON)**:
  ```json
  {
    "courseIds": [1, 3] // Bắt buộc, danh sách ID khóa học muốn mua
  }
  ```
- **Response (200 OK)**: Trả về đơn hàng khởi tạo `OrderCheckoutResponse`.

---

### MODULE 12: PAYMENT (THANH TOÁN QUA CỔNG PAYOS) - 2 APIs

#### 54. Tạo liên kết thanh toán (PayOS Deposit)
- **Method & URL**: `POST /payment/deposit`
- **Mục đích**: Tạo liên kết thanh toán QRCode/Chuyển khoản ngân hàng qua PayOS dựa trên số tiền muốn nạp.
- **Yêu cầu JWT**: Có.
- **Request Body (JSON)**:
  ```json
  {
    "amount": 150000.00 // Bắt buộc, tối thiểu 10,000 VND
  }
  ```
- **Response (200 OK)**: Trả về liên kết cổng thanh toán. Học viên sẽ được chuyển hướng sang trang của PayOS để thanh toán QRCode.
  ```json
  {
    "status": 200,
    "code": 1000,
    "message": "Payment link created successfully",
    "result": {
      "checkoutUrl": "https://pay.payos.vn/web/a1b2c3d4...", // URL cổng thanh toán
      "transactionCode": "TXN998822" // Mã giao dịch của hệ thống
    },
    "timestamp": "2026-06-16T13:00:00Z"
  }
  ```

> [!IMPORTANT]
> **Lưu ý về Redirect URL của PayOS:**
> - Mặc định backend cấu hình chuyển hướng người dùng sau khi thanh toán xong/hủy về các trang tĩnh trên backend:
>   - Thành công: `http://localhost:8080/codelearning/payment/success.html`
>   - Hủy bỏ: `http://localhost:8080/codelearning/payment/cancel.html`
> - **Khuyến nghị cho Frontend:** Nếu muốn ứng dụng Client (React/Vite chạy ở port 3000/5173) tự xử lý giao diện hiển thị kết quả đẹp mắt, các URL cấu hình trên tài khoản PayOS (hoặc biến môi trường backend) cần được cập nhật trỏ về các route tương ứng trên Frontend (ví dụ: `http://localhost:5173/payment/success`).

#### 55. [WEBHOOK] Đồng bộ trạng thái thanh toán từ PayOS
- **Method & URL**: `POST /payment/webhook`
- **Mục đích**: Nhận thông tin thông báo nộp tiền thành công từ PayOS để tự động kích hoạt khóa học/nạp tiền vào ví.
- **Yêu cầu JWT**: Không.
- **Request Body (JSON)**: Định dạng payload ký số của PayOS.
- **Response (200 OK)**:
  ```json
  {
    "success": true
  }
  ```
  *(Chú ý: API này luôn phải trả về 200 OK kèm JSON `{ "success": true }` để báo cho PayOS dừng retry gửi webhook)*

---

## IV. CẤU HÌNH TRUYỀN DỮ LIỆU THỜI GIAN THỰC (WEBSOCKETS STOMP)

Hệ thống sử dụng **WebSocket** tích hợp giao thức **STOMP** để đẩy dữ liệu thời gian thực xuống Frontend (ví dụ: kết quả chạy thử code, tiến độ sinh testcase, cập nhật bảng xếp hạng thi đấu).

### 1. Thông tin kết nối
- **WebSocket Endpoint**: `ws://localhost:8080/codelearning/ws` (hoặc `http://localhost:8080/codelearning/ws` nếu sử dụng SockJS fallback).
- **Thư viện đề xuất**: `sockjs-client` + `stompjs` (hoặc `@stomp/stompjs`).

### 2. Danh sách Kênh Đăng ký (STOMP Topics)

#### Kênh giám sát chấm bài Online Judge (OJ)
- **Topic**: `/topic/submissions/{userId}`
  - **Mục đích**: Nhận dữ liệu chấm điểm của từng testcase và kết quả tổng hợp của lượt nộp code thời gian thực.
  - **Payload**: Đối tượng `OjWebSocketMessage`.
- **Topic**: `/topic/submissions/admin`
  - **Mục đích**: Nhận live-feed toàn bộ lượt nộp code của tất cả người dùng (chỉ dành cho giám sát Admin).
  - **Payload**: Đối tượng `OjWebSocketMessage`.

#### Kênh tiến độ tạo tự động bộ đề/testcase (Admin/Teacher)
- **Topic**: `/topic/testcase-generation/{problemId}`
  - **Mục đích**: Nhận cập nhật tiến độ sinh testcase input/output từ Judge0.
  - **Payload**: Đối tượng `OjTestcaseGenWsMessage`.

#### Kênh cập nhật Bảng xếp hạng Cuộc thi (Contests)
- **Topic**: `/topic/contests/{contestId}/leaderboard`
  - **Mục đích**: Nhận thông báo sự kiện khi bảng xếp hạng thay đổi.
  - **Payload**:
    ```json
    {
      "event": "LEADERBOARD_INITIALIZED" | "LEADERBOARD_UPDATED",
      "contest_id": number,
      "user_id": number // chỉ xuất hiện ở event LEADERBOARD_UPDATED
    }
    ```
  - **Hành động khuyến nghị cho Frontend**: Khi nhận được tín hiệu này, Frontend nên gọi lại API `GET /contests/{contestId}/leaderboard` để tải lại bảng xếp hạng mới nhất.

