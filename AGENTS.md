# AGENTS.md - AI Coding Agent Guide for CodeLearning

A Spring Boot 3.5.7 online learning platform with course management, quiz system, online judge integration, and progress tracking.

## Tech Stack
- **Language**: Java 21, Kotlin 2.2
- **Framework**: Spring Boot 3.5.7 (Web, Data JPA, Security, OAuth2/JWT)
- **Database**: PostgreSQL (JPA/Hibernate, native queries)
- **Caching**: Redis
- **Mapping**: MapStruct 1.5.5 + Lombok
- **Architecture**: Layered (controller → service → repository → entity)

## Architecture Overview

### Domain Structure
```
Courses/Lessons (Frontend learning content)
├── Chapter (grouping lessons)
├── Lesson (atomic learning unit)
├── Quiz (assessments within lessons)
└── Progress Tracking (user completion, counts cached)

Online Judge (OJ) Problems (Coding exercises)
├── Lesson-bound problems (practice mode)
├── Contest-bound problems (competition mode - suppressed feedback)
├── Judge0 integration (async webhook-based)
├── Asynchronous submission workflow
└── WebSocket real-time result delivery (lesson mode only)

Contests (Timed competitions)
├── ContestEntity (start_time, end_time, status: UPCOMING/RUNNING/ENDED)
├── ContestParticipant (registration + ranking)
├── ContestProblems (linked via OnlineJudgeProblemEntity.contest)
└── Verdict suppression during contest (no real-time feedback)

User/Auth System
├── OAuth2 Resource Server (JWT in cookies/Bearer tokens)
├── Role-based access control (@PreAuthorize with custom security methods)
└── Token invalidation via Redis

Payment/Enrollment (Course access management)
└── Status-based enrollment checks
```

### Service Boundaries
- **CourseService**: Course listing (Specification-based filtering), curriculum, progress aggregation
- **LessonService**: Lesson detail, completion tracking, progress updates
- **QuizService**: Quiz attempts, answer evaluation, scoring logic
- **ProgressService**: User progress calculation across courses/lessons
- **OnlineJudgeProblemService**: Problem listing, Judge0 webhook integration (lessons & contests)
- **OjSubmissionService**: Async Judge0 submission lifecycle, webhook callback processing, real-time WebSocket push
- **Judge0ClientService**: WebClient wrapper for Judge0 batch submission API
- **AuthenticationService**: JWT token generation, login/refresh flows
- **LessonCommentService**: Nested comment threads with reply counts (PostgreSQL CTEs)

## Critical Patterns & Conventions

### 1. Security & Authorization
**Pattern**: Two-tier security in `SecurityConfig.java`
- **Tier 1** (`@Order(1)`): Public endpoints `/auth/**`, `/courses/**`, `/lessons/{lessonId}` - permit all
- **Tier 2** (`@Order(2)`): Protected endpoints require `@PreAuthorize` with method-level security

**Custom Authorization** via `@Component("courseSecurity")` beans:
```java
// In controller:
@PreAuthorize("hasAuthority('LESSON_COMPLETE') and @courseSecurity.canAccessLesson(#lessonId)")
@PreAuthorize("hasAnyAuthority('OJ_PROBLEM_VIEW', 'FILE_ASSIGNMENT_VIEW') and (@courseSecurity.canAccessLesson(#lessonId) or @courseSecurity.canManageLesson(#lessonId))")

// CourseSecurity methods check:
// - canAccessLesson(lessonId) → enrolled in course + lesson accessible
// - canAccessProblem(problemId) → enrolled in lesson OR contest
// - canAccessContest(problemId) → registered as contest participant
// - canAccessQuiz(quizId) → enrolled in quiz's lesson
// - canManageLesson(lessonId) → teacher assigned to course
```

**JWT Claims**: `userId` extracted from JWT claim (not Spring authorities) for all service operations.
**Cookie Handling**: Tokens stored in HttpOnly cookies (configurable via YAML: `ACCESS_TOKEN_COOKIE_NAME`, etc.)

### 2. Repository Layer - Three Query Patterns

#### Pattern A: JPA Specifications (Dynamic Filtering)
Used in `CourseService.getCourseList()` for complex filtering:
```java
Specification<CourseEntity> spec = Specification.allOf(CourseSpecification.isStatusActive())
    .and(CourseSpecification.hasKeyword(keyword))
    .and(CourseSpecification.hasCategories(categoryIds))
    .and(CourseSpecification.hasPriceBetween(minPrice, maxPrice));
Page<CourseEntity> page = courseRepository.findAll(spec, pageable);
```
**File**: `repository/specification/CourseSpecification.java` - implement here for new filters.

#### Pattern B: JPQL with @EntityGraph & JOIN FETCH
Optimizes N+1 queries by eager loading relations:
```java
@EntityGraph(attributePaths = {"categories", "teacherAssignments", "teacherAssignments.teacher"})
@Query("SELECT c FROM CourseEntity c WHERE c.id = :courseId AND c.status = 'ACTIVE'")
Optional<CourseEntity> findCourseDetailById(@Param("courseId") Long courseId);
```

#### Pattern C: Native Queries for Complex PostgreSQL
Used for CTEs, complex joins, or existence checks:
```java
@Query(value = """
    SELECT lm.id AS id, COALESCE(rc.count, 0) AS replyCount
    FROM lesson_comments lm
    LEFT JOIN ReplyCounts rc ON lm.id = rc.parent_comment_id
    WHERE lm.lesson_id = :lessonId
    """, nativeQuery = true)
List<RootLessonCommentProjection> findRootCommentsByLessonId(@Param("lessonId") Long lessonId);
```

**Projections** (`repository/projection/`): Use interfaces for selecting specific columns, reduces payload.

**N+1 Prevention**: Batch fetch size = 10 (Hibernate config: `default_batch_fetch_size`).

### 3. Service Layer - Common Patterns

**Pattern**: Constructor-injected dependencies with `@RequiredArgsConstructor` + Lombok `@FieldDefaults(level = AccessLevel.PRIVATE, makeFinal = true)`:
```java
@Slf4j
@Service
@RequiredArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE, makeFinal = true)
public class LessonService {
    LessonRepository lessonRepository;
    UserRepository userRepository;
    LessonMapper lessonMapper;  // MapStruct
    
    @Transactional  // Important for multi-step operations
    public LessonCompletionResponse completedLesson(Long lessonId, Long userId) {
        // Checks + DB writes
    }
}
```

**Transaction Handling**:
- Single-step reads: no `@Transactional`
- Multi-step writes (update progress + increment counter): **MUST** use `@Transactional`
- `incrementAndGetCount()` in `CompletedLessonCountRepository` uses native PostgreSQL RETURNING for atomicity

**Progress Aggregation** (key business logic):
1. `CompletedLessonsCountEntity` stores cached count per user/course
2. `LessonProgressEntity` tracks individual lesson completion (fine-grained)
3. `ProgressService.getCourseProgress()` calculates percentage = completed/total lessons
4. Updates happen **only** when lesson completion confirmed (`LessonService.completedLesson()`)

### 4. API Response Pattern
All endpoints return wrapped responses via `ApiResponse<T>` generic:
```java
return ResponseEntity.ok(ApiResponse.<CourseListItemResponse>builder()
        .status(200)
        .code(1000)                      // Business code (not HTTP status)
        .message("Description")
        .result(data)
        .timestamp(Instant.now().toString())
        .build());
```

**Errors** throw `AppException(ErrorCode)` caught globally in `GlobalExceptionHandler.java`.

### 5. MapStruct Mapping
All entity ↔ DTO conversions use **interfaces** marked `@Mapper(componentModel = "spring")`:
```java
@Mapper(componentModel = "spring")
public interface CourseMapper {
    @Mapping(target = "enrolled", ignore = true)  // Ignored fields filled in service
    CourseListItemResponse toCourseListItemResponse(CourseEntity entity);
}
```

**FieldDefaults**: Fields with business logic (e.g., `enrolled`, `progressPercentage`) are set manually in service AFTER mapping.

### 6. Asynchronous Judge0 Integration (Key Workflow)

**4-Phase Workflow** (full details in `workflow_judge0.md`):

**Phase 1: Fast Submission (Initiation)**
- Frontend → POST `/online-judge/submissions` with code, problemId, lessonId/contestId
- Backend packages testcases + sets `callback_url` → POST Judge0 API `/submissions/batch`
- Store submission with status=PENDING + save each testcase token with status=PENDING
- Return immediately with `submissionId` (thread freed)

**Phase 2: Judge0 Processing** (Independent, no backend polling)
- Judge0 workers process each submission in sandbox (compile, run, compare output)
- No backend involvement

**Phase 3: Webhook Callback (Real-time Updates)**
- Judge0 → PUT `/judge0/callback` with verdict + token (after each testcase completes)
- Backend finds submission detail by token → Update status (ACCEPTED/WRONG_ANSWER/TLE/etc.)
- **Context-aware logic**:
  - **Lesson context**: Push intermediate result via SimpMessagingTemplate WebSocket to `/topic/submissions/{userId}` (for progress bar)
  - **Contest context**: Suppress per-testcase WebSocket (only final verdict visible)

**Phase 4: Aggregation & Final Verdict**
- After testcase update: Count processed vs total testcases
- If all processed → Find first error testcase (by order_index), determine final verdict
- Update parent submission with final status + score
- Push final WebSocket message with overall verdict

**Key Files**:
- `service/oj/OjSubmissionService.java` - Initiation, callback handler, aggregation logic
- `service/oj/Judge0ClientService.java` - WebClient wrapper for Judge0 API
- `controller/oj/OnlineJudgeProblemController.java` - Submission endpoint + webhook receiver
- `configuration/WebSocketConfig.java` - STOMP broker config (`/topic/submissions/{userId}`)

### 7. Error Handling Convention
**All errors** must use `ErrorCode` enum:
```java
if (user == null) throw new AppException(ErrorCode.USER_NOT_FOUND);
if (!canAccess) throw new AppException(ErrorCode.ACCESS_DENIED_COURSE);
```

**HttpStatus mapping** built into `ErrorCode`:
```java
RESOURCE_NOT_FOUND(1003, "...", HttpStatus.NOT_FOUND),  // 404
ACCESS_DENIED(1004, "...", HttpStatus.FORBIDDEN),       // 403
```

**New ErrorCodes** → Add to `exception/ErrorCode.java` enum with code, message, HttpStatus.

### 8. Build & Development

**Environment Variables** (`.env` loaded via spring-dotenv):
```
DB_URL=jdbc:postgresql://localhost:5432/CodeLearning
DB_USERNAME=postgres
DB_PASSWORD=...
JWT_SIGNER_KEY=... (base64-encoded key for signing)
REDIS_HOST=localhost (default: localhost:6379)
JUDGE0_BASE_URL=http://localhost:2358
JUDGE0_TIMEOUT=20s
WEBSOCKET_ALLOWED_ORIGINS=http://localhost:3000,http://127.0.0.1:3000,http://localhost:5173
APP_WEBHOOK_BASE_URL=http://192.168.1.90:8080/codelearning (for Judge0 callbacks)
```

**Judge0 Integration Config** (ProjectProperties.java):
- `judge0.base-url`: Judge0 API endpoint (default: `http://localhost:2358`)
- `judge0.timeout`: WebClient request timeout for batch submission (default: 20s)
- `app.webhook-base-url`: Backend URL that Judge0 calls on webhook (must be externally accessible)
- `websocket.allowed-origins`: CORS-allowed domains for WebSocket connections

**Build & Run**:
```bash
# Maven wrapper (Windows):
mvnw.cmd clean package          # Full build
mvnw.cmd spring-boot:run        # Dev server on http://localhost:8080/codelearning

# App runs on port 8080 with context path = /codelearning
```

**MapStruct Compilation**: Requires `annotationProcessorPaths` in `maven-compiler-plugin` (already configured); impl classes auto-generated to `target/generated-sources/annotations/`.

**Database**: PostgreSQL with `ddl-auto: validate` (schema must exist; use `db/schema-only.sql`).

## Key Files Reference

| File | Purpose |
|------|---------|
| `security/SecurityConfig.java` | OAuth2 chain config (2 tiers), bearer token resolution from Authorization header or `access_token` cookie |
| `security/CourseSecurity.java` | Custom @{bean} for @PreAuthorize (canAccessLesson, canAccessProblem, canAccessContest, canAccessQuiz, canManageLesson) |
| `repository/specification/CourseSpecification.java` | Dynamic filter builder template (status, keyword, categories, price, rating, teacher) |
| `mapper/*.java` | Entity ↔ DTO conversion (impl auto-generated by MapStruct) |
| `service/course/CourseService.java` | Specification chaining example + progress aggregation |
| `service/oj/OjSubmissionService.java` | Judge0 submission lifecycle (initiation, callback handler, WebSocket push, verdict aggregation) |
| `service/oj/Judge0ClientService.java` | WebClient wrapper for Judge0 batch submission endpoint |
| `controller/oj/OnlineJudgeProblemController.java` | GET `/online-judge/problems`, POST `/online-judge/submissions`, PUT `/online-judge/submissions/{id}` (webhook) |
| `exception/ErrorCode.java` | Centralized error definitions (with HTTP status mapping) |
| `dto/response/ApiResponse.java` | Response wrapper template (status, code, message, result, timestamp) |
| `configuration/WebSocketConfig.java` | STOMP broker config with `/topic` (server push) and `/app` (client request) prefixes |
| `configuration/ProjectProperties.java` | External config properties binding (judge0, websocket, app) |
| `workflow_judge0.md` | Detailed 4-phase async submission workflow diagram

## When Adding Features

1. **New endpoint** → Add to controller + create `@PreAuthorize` rule using `@courseSecurity` bean (check CourseSecurity for available methods)
2. **New validation error** → Add to `ErrorCode` enum with code, message, HttpStatus
3. **New query** → Create `@Query` in repository or `Specification` if flexible filtering needed
4. **Entity ↔ DTO** → Add `@Mapping` to mapper interface; impl auto-generated by MapStruct
5. **Multi-step business logic** → Add `@Transactional` to service method
6. **User progress affected** → Update `LessonProgressEntity` + call `CompletedLessonCountRepository.incrementAndGetCount()`
7. **Real-time updates** → Use `SimpMessagingTemplate.convertAndSendToUser()` to push via WebSocket to `/topic/submissions/{userId}`
8. **Contest vs Lesson context** → Check `submission.lesson != null` (lesson) vs `submission.contest != null` (contest) to determine feedback behavior

## Debugging Tips

- Enable SQL logging: `show-sql: true` in YAML (already set in dev config)
- JWT token claims: Extract `userId` from `@AuthenticationPrincipal Jwt jwt` → `jwt.getClaim("userId")`
- Lazy loading issues: Use `JOIN FETCH` in queries or `@EntityGraph`
- Specifications return `null` for skipped conditions (safe chaining)
- Native queries must use schema names from `db/schema-only.sql` exactly
- **WebSocket testing**: Open `static/test-ws.html` (simple STOMP client) to manually test real-time submissions
- **Judge0 callback debugging**: Ensure `app.webhook-base-url` is externally accessible; use ngrok for local testing
- **Race condition prevention**: All Judge0 callback handlers must check `processedTestcases == totalTestcases` before computing final verdict (see `OjSubmissionService`)

