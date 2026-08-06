export const ContestStatus = {
  UPCOMING: "UPCOMING",
  RUNNING: "RUNNING",
  ENDED: "ENDED",
  CANCELLED: "CANCELLED"
} as const;
export type ContestStatus = typeof ContestStatus[keyof typeof ContestStatus];

export const LessonStatus = {
  DRAFT: "DRAFT",
  PUBLISHED: "PUBLISHED"
} as const;
export type LessonStatus = typeof LessonStatus[keyof typeof LessonStatus];

export const ProblemDifficulty = {
  EASY: "EASY",
  MEDIUM: "MEDIUM",
  HARD: "HARD"
} as const;
export type ProblemDifficulty = typeof ProblemDifficulty[keyof typeof ProblemDifficulty];

export const ProblemScope = {
  LESSON: "LESSON",
  CONTEST: "CONTEST",
  SHARED: "SHARED",
  PRACTICE: "PRACTICE"
} as const;
export type ProblemScope = typeof ProblemScope[keyof typeof ProblemScope];

export const ScoringRule = {
  ICPC: "ICPC",
  IOI: "IOI",
  CUSTOM: "CUSTOM"
} as const;
export type ScoringRule = typeof ScoringRule[keyof typeof ScoringRule];

export const OrderStatus = {
  PENDING: "PENDING",
  COMPLETED: "COMPLETED",
  CANCELLED: "CANCELLED",
  FAILED: "FAILED"
} as const;
export type OrderStatus = typeof OrderStatus[keyof typeof OrderStatus];

export interface ApiResponse<T> {
  status: number;
  code: number;
  message: string;
  result: T;
  timestamp: string;
}

export interface PageResponse<T> {
  page: number;
  size: number;
  numberOfElements: number;
  totalElements: number;
  totalPages: number;
  first: boolean;
  last: boolean;
  content: T[];
}

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
  number: number; // 0-indexed page number
  sort: {
    empty: boolean;
    sorted: boolean;
    unsorted: boolean;
  };
  numberOfElements: number;
  empty: boolean;
}

export interface UserResponse {
  id: number;
  displayName: string;
  username: string;
  phoneNumber: string | null;
  email: string;
  avatarUrl?: string | null;
  roles?: string[];
}

export interface UserBalanceResponse {
  balance: number;
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
  teacherName: string | null;
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
  isCorrect: boolean;
  orderIndex: number;
}

export interface QuizAttemptResponse {
  id: number;
  score: number;
  correctAnswers: number;
  totalQuestions: number;
  submittedAt: string;
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

export interface OjAdminProblemResponse {
  id: number;
  title: string;
  scope: ProblemScope;
  difficulty: ProblemDifficulty;
  totalSubmissions: number;
  totalAccepted: number;
  createdByTeacher: TeacherResponse;
  isPublic: boolean;
}

export interface OjLessonProblemResponse {
  id: number;
  title: string;
  difficulty: ProblemDifficulty;
  isAccepted: boolean | null;
}

export interface OjAdminSubmissionSearchRequest {
  problemTitle?: string;
  userDisplayName?: string;
  verdict?: OjVerdict[];
  languageId?: number[];
}

export interface OjAdminSubmissionResponse {
  userDisplayName: string;
  problemTitle: string;
  language: string;
  verdict: OjVerdict;
  executionTimeMs: number;
  memoryUsedKb: number;
  submittedAt: string;
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
  difficulty: ProblemDifficulty | null;
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
  public?: boolean;
  registered?: boolean;
}

export interface ContestResponse {
  id: number;
  title: string;
  description: string | null;
  isProtected: boolean;
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
  displayName: string;
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
  avatarUrl?: string | null;
  roles?: string[];
}

export interface CourseProgressResponse {
  courseId: number;
  title: string;
  thumbnailUrl: string | null;
  completedLessons: number;
  totalLessons: number;
  completionPercentage: number;
}

export const OjVerdict = {
  ACCEPTED: "ACCEPTED",
  WRONG_ANSWER: "WRONG_ANSWER",
  TIME_LIMIT_EXCEEDED: "TIME_LIMIT_EXCEEDED",
  MEMORY_LIMIT_EXCEEDED: "MEMORY_LIMIT_EXCEEDED",
  RUNTIME_ERROR: "RUNTIME_ERROR",
  COMPILATION_ERROR: "COMPILATION_ERROR",
  INTERNAL_ERROR: "INTERNAL_ERROR",
  PENDING: "PENDING",
  PROCESSING: "PROCESSING"
} as const;
export type OjVerdict = typeof OjVerdict[keyof typeof OjVerdict];

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

export interface OjProblemSubmission {
  id: number;
  language: string;
  verdict: OjVerdict;
  executionTimeMs: number;
  memoryUsedKb: number;
  submittedAt: string;
}

export interface EnrolledCourseResponse {
  id: number;
  title: string;
  shortDescription: string;
  thumbnailUrl: string;
  price: number;
  averageRating: number;
  totalReviews: number;
  totalEnrolled: number;
  progressPercentage: number | null;
  teacherName: string | null;
}

export interface AdminUserResponse {
  id: number;
  displayName: string | null;
  username: string;
  email: string;
  phoneNumber: string | null;
  balance: number | null;
  status: string;
  roles: string[];
  createdAt: string;
}

export interface AdminPaymentTransactionResponse {
  id: number;
  transactionCode: string;
  userDisplayName: string | null;
  userId: number | null;
  amount: number;
  type: 'DEPOSIT' | 'WITHDRAW';
  status: 'PENDING' | 'SUCCESS' | 'LATE_SUCCESS' | 'FAILED' | 'CANCELLED';
  note?: string | null;
  createdAt: string;
}

