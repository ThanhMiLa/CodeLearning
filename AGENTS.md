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
├── Integration with Judge0 (async webhook-based)
├── Asynchronous submission workflow
└── WebSocket real-time result delivery

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
- **OnlineJudgeProblemService**: Problem listing, Judge0 webhook integration
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

// CourseSecurity methods check:
// - canAccessLesson(lessonId) → enrolled in course
// - canManageLesson(lessonId) → teacher assigned to course
// - canAccessQuiz(quizId) → enrolled in quiz's lesson
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

**3-Phase Workflow** (documented in `workflow_judge0.md`):

**Phase 1: Fast Submission**
- Frontend → POST `/online-judge/submissions` with code
- Backend: Package Testcases + set `callback_url` → POST Judge0 API → Get token
- Store submission with status=PENDING
- Return immediately (thread freed)

**Phase 2: Judge0 Processing** (Independent, no polling)
- Judge0 workers process in sandbox
- No backend involvement

**Phase 3: Webhook Callback**
- Judge0 → PUT `/judge0/callback` with verdict + token
- Backend: Find submission by token → Update status (ACCEPTED/WRONG_ANSWER)
- **CRITICAL**: Push result via SimpMessagingTemplate WebSocket to `/topic/submissions/{userId}`

**Files**:
- `controller/oj/OnlineJudgeSubmissionController.java`
- `service/oj/OnlineJudgeSubmissionService.java`
- WebSocket config in `configuration/`

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
```

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
| `security/SecurityConfig.java` | OAuth2 chain config, bearer token resolution |
| `security/CourseSecurity.java` | Custom @{bean} for @PreAuthorize (canAccessLesson, etc.) |
| `repository/specification/CourseSpecification.java` | Dynamic filter builder template |
| `mapper/*.java` | Entity ↔ DTO conversion (impl auto-generated) |
| `service/course/CourseService.java` | Specification chaining example |
| `exception/ErrorCode.java` | Centralized error definitions |
| `dto/response/ApiResponse.java` | Response wrapper template |
| `workflow_judge0.md` | Judge0 async submission architecture |

## When Adding Features

1. **New endpoint** → Add to controller + create `@PreAuthorize` rule using `@courseSecurity` bean
2. **New validation error** → Add to `ErrorCode` enum
3. **New query** → Create `@Query` in repository or `Specification` if flexible filter needed
4. **Entity ↔ DTO** → Add `@Mapping` to mapper interface; impl auto-generated
5. **Multi-step business logic** → Add `@Transactional` to service method
6. **User progress affected** → Update `LessonProgressEntity` + call `CompletedLessonCountRepository.incrementAndGetCount()`

## Debugging Tips

- Enable SQL logging: `show-sql: true` in YAML (already set in dev config)
- JWT token claims: Extract `userId` from `@AuthenticationPrincipal Jwt jwt` → `jwt.getClaim("userId")`
- Lazy loading issues: Use `JOIN FETCH` in queries or `@EntityGraph`
- Specifications return `null` for skipped conditions (safe chaining)
- Native queries must use schema names from `db/schema-only.sql` exactly

