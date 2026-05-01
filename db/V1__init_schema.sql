-- V1__init_schema.sql
-- PostgreSQL schema for E-Learning Code Learning Platform
-- Generated from DBML design.

BEGIN;

-- =========================================================
-- ENUM TYPES
-- =========================================================

DO $$ BEGIN
CREATE TYPE user_status AS ENUM ('ACTIVE', 'LOCKED', 'DISABLED');
EXCEPTION
    WHEN duplicate_object THEN null;
END $$;

DO $$ BEGIN
CREATE TYPE course_status AS ENUM ('ACTIVE', 'INACTIVE', 'DRAFT');
EXCEPTION
    WHEN duplicate_object THEN null;
END $$;

DO $$ BEGIN
CREATE TYPE lesson_status AS ENUM ('ACTIVE', 'INACTIVE', 'DRAFT');
EXCEPTION
    WHEN duplicate_object THEN null;
END $$;

DO $$ BEGIN
CREATE TYPE enrollment_status AS ENUM ('ACTIVE', 'CANCELLED', 'COMPLETED');
EXCEPTION
    WHEN duplicate_object THEN null;
END $$;

DO $$ BEGIN
CREATE TYPE teacher_status AS ENUM ('ACTIVE', 'INACTIVE', 'LOCKED');
EXCEPTION
    WHEN duplicate_object THEN null;
END $$;

DO $$ BEGIN
CREATE TYPE contest_status AS ENUM ('UPCOMING', 'RUNNING', 'ENDED', 'CANCELLED');
EXCEPTION
    WHEN duplicate_object THEN null;
END $$;

DO $$ BEGIN
CREATE TYPE problem_scope AS ENUM ('LESSON', 'CONTEST', 'SHARED');
EXCEPTION
    WHEN duplicate_object THEN null;
END $$;

DO $$ BEGIN
CREATE TYPE problem_difficulty AS ENUM ('EASY', 'MEDIUM', 'HARD');
EXCEPTION
    WHEN duplicate_object THEN null;
END $$;

DO $$ BEGIN
CREATE TYPE oj_verdict AS ENUM (
        'ACCEPTED',
        'WRONG_ANSWER',
        'TIME_LIMIT_EXCEEDED',
        'MEMORY_LIMIT_EXCEEDED',
        'RUNTIME_ERROR',
        'COMPILATION_ERROR'
    );
EXCEPTION
    WHEN duplicate_object THEN null;
END $$;

DO $$ BEGIN
CREATE TYPE payment_status AS ENUM ('PENDING', 'SUCCESS', 'FAILED', 'CANCELLED');
EXCEPTION
    WHEN duplicate_object THEN null;
END $$;

DO $$ BEGIN
CREATE TYPE file_submission_status AS ENUM (
        'SUBMITTED',
        'IN_REVIEW',
        'GRADED',
        'NEEDS_RESUBMISSION',
        'REPLACED',
        'RESUBMITTED'
    );
EXCEPTION
    WHEN duplicate_object THEN null;
END $$;

-- =========================================================
-- UPDATED_AT TRIGGER FUNCTION
-- =========================================================

CREATE OR REPLACE FUNCTION set_updated_at()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = now();
RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- =========================================================
-- IDENTITY / AUTH TABLES
-- =========================================================

CREATE TABLE IF NOT EXISTS users (
                                     id BIGSERIAL PRIMARY KEY,
                                     username VARCHAR(100) NOT NULL UNIQUE,
    email VARCHAR(255) NOT NULL UNIQUE,
    password_hash VARCHAR(255) NOT NULL,
    display_name VARCHAR(255),
    phone_number VARCHAR(30),
    status user_status NOT NULL DEFAULT 'ACTIVE',
    created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT now(),

    CONSTRAINT chk_users_username_not_blank CHECK (length(trim(username)) > 0),
    CONSTRAINT chk_users_email_not_blank CHECK (length(trim(email)) > 0)
    );

CREATE TABLE IF NOT EXISTS roles (
                                     id BIGSERIAL PRIMARY KEY,
                                     name VARCHAR(100) NOT NULL UNIQUE,

    CONSTRAINT chk_roles_name_not_blank CHECK (length(trim(name)) > 0)
    );

CREATE TABLE IF NOT EXISTS permissions (
                                           id BIGSERIAL PRIMARY KEY,
                                           name VARCHAR(150) NOT NULL UNIQUE,

    CONSTRAINT chk_permissions_name_not_blank CHECK (length(trim(name)) > 0)
    );

CREATE TABLE IF NOT EXISTS user_roles (
                                          user_id BIGINT NOT NULL,
                                          role_id BIGINT NOT NULL,
                                          PRIMARY KEY (user_id, role_id),

    CONSTRAINT fk_user_roles_user
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    CONSTRAINT fk_user_roles_role
    FOREIGN KEY (role_id) REFERENCES roles(id) ON DELETE CASCADE
    );

CREATE TABLE IF NOT EXISTS role_permissions (
                                                role_id BIGINT NOT NULL,
                                                permission_id BIGINT NOT NULL,
                                                PRIMARY KEY (role_id, permission_id),

    CONSTRAINT fk_role_permissions_role
    FOREIGN KEY (role_id) REFERENCES roles(id) ON DELETE CASCADE,
    CONSTRAINT fk_role_permissions_permission
    FOREIGN KEY (permission_id) REFERENCES permissions(id) ON DELETE CASCADE
    );

CREATE TABLE IF NOT EXISTS invalidated_tokens (
                                                  id BIGSERIAL PRIMARY KEY,
                                                  user_id BIGINT NOT NULL,
                                                  token_jti VARCHAR(255) NOT NULL UNIQUE,
    expiry_time TIMESTAMPTZ NOT NULL,
    created_at TIMESTAMPTZ NOT NULL DEFAULT now(),

    CONSTRAINT fk_invalidated_tokens_user
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
    );

CREATE TABLE IF NOT EXISTS refresh_tokens (
                                              id BIGSERIAL PRIMARY KEY,
                                              user_id BIGINT NOT NULL,
                                              token_hash VARCHAR(255) NOT NULL UNIQUE,
    expires_at TIMESTAMPTZ NOT NULL,
    revoked_at TIMESTAMPTZ,
    created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
    last_used_at TIMESTAMPTZ,

    CONSTRAINT fk_refresh_tokens_user
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
    );

CREATE TABLE IF NOT EXISTS teachers (
                                        id BIGSERIAL PRIMARY KEY,
                                        user_id BIGINT NOT NULL UNIQUE,
                                        status teacher_status NOT NULL DEFAULT 'ACTIVE',
                                        created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
                                        updated_at TIMESTAMPTZ NOT NULL DEFAULT now(),

    CONSTRAINT fk_teachers_user
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
    );

-- =========================================================
-- COURSE STRUCTURE
-- =========================================================

CREATE TABLE IF NOT EXISTS courses (
                                       id BIGSERIAL PRIMARY KEY,
                                       title VARCHAR(255) NOT NULL,
    short_description TEXT,
    course_content TEXT,
    learning_outcomes TEXT,
    course_highlights TEXT,
    technologies_tools TEXT,
    prerequisites TEXT,
    target_audience TEXT,
    completion_benefits TEXT,
    price NUMERIC(12,2) NOT NULL DEFAULT 0,
    thumbnail_url VARCHAR(500),
    estimated_duration_hours INT,
    status course_status NOT NULL DEFAULT 'DRAFT',
    created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT now(),

    CONSTRAINT chk_courses_title_not_blank CHECK (length(trim(title)) > 0),
    CONSTRAINT chk_courses_price_non_negative CHECK (price >= 0),
    CONSTRAINT chk_courses_estimated_duration_positive
    CHECK (estimated_duration_hours IS NULL OR estimated_duration_hours > 0)
    );

CREATE TABLE IF NOT EXISTS chapters (
                                        id BIGSERIAL PRIMARY KEY,
                                        course_id BIGINT NOT NULL,
                                        title VARCHAR(255) NOT NULL,
    order_index INT NOT NULL,

    CONSTRAINT fk_chapters_course
    FOREIGN KEY (course_id) REFERENCES courses(id) ON DELETE CASCADE,
    CONSTRAINT uq_chapters_course_order UNIQUE (course_id, order_index),
    CONSTRAINT chk_chapters_title_not_blank CHECK (length(trim(title)) > 0),
    CONSTRAINT chk_chapters_order_positive CHECK (order_index > 0)
    );

CREATE TABLE IF NOT EXISTS lessons (
                                       id BIGSERIAL PRIMARY KEY,
                                       chapter_id BIGINT NOT NULL,
                                       title VARCHAR(255) NOT NULL,
    description TEXT,
    video_url VARCHAR(500),
    theory_content TEXT,
    sample_code TEXT,
    is_trial BOOLEAN NOT NULL DEFAULT false,
    order_index INT NOT NULL,
    estimated_duration_minutes INT,
    status lesson_status NOT NULL DEFAULT 'DRAFT',
    created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT now(),

    CONSTRAINT fk_lessons_chapter
    FOREIGN KEY (chapter_id) REFERENCES chapters(id) ON DELETE CASCADE,
    CONSTRAINT uq_lessons_chapter_order UNIQUE (chapter_id, order_index),
    CONSTRAINT chk_lessons_title_not_blank CHECK (length(trim(title)) > 0),
    CONSTRAINT chk_lessons_order_positive CHECK (order_index > 0),
    CONSTRAINT chk_lessons_estimated_duration_positive
    CHECK (estimated_duration_minutes IS NULL OR estimated_duration_minutes > 0)
    );

CREATE TABLE IF NOT EXISTS teacher_course_assignments (
                                                          id BIGSERIAL PRIMARY KEY,
                                                          teacher_id BIGINT NOT NULL,
                                                          course_id BIGINT NOT NULL,
                                                          assigned_by_admin_id BIGINT NOT NULL,
                                                          assigned_at TIMESTAMPTZ NOT NULL DEFAULT now(),

    CONSTRAINT fk_teacher_course_assignments_teacher
    FOREIGN KEY (teacher_id) REFERENCES teachers(id) ON DELETE CASCADE,
    CONSTRAINT fk_teacher_course_assignments_course
    FOREIGN KEY (course_id) REFERENCES courses(id) ON DELETE CASCADE,
    CONSTRAINT fk_teacher_course_assignments_admin
    FOREIGN KEY (assigned_by_admin_id) REFERENCES users(id),
    CONSTRAINT uq_teacher_course_assignments_teacher_course UNIQUE (teacher_id, course_id)
    );

-- =========================================================
-- PAYMENT / ENROLLMENT / PROGRESS
-- =========================================================

CREATE TABLE IF NOT EXISTS payments (
                                        id BIGSERIAL PRIMARY KEY,
                                        user_id BIGINT NOT NULL,
                                        course_id BIGINT NOT NULL,
                                        amount NUMERIC(12,2) NOT NULL,
    payment_method VARCHAR(100),
    transaction_code VARCHAR(255) UNIQUE,
    payment_status payment_status NOT NULL DEFAULT 'PENDING',
    paid_at TIMESTAMPTZ,

    CONSTRAINT fk_payments_user
    FOREIGN KEY (user_id) REFERENCES users(id),
    CONSTRAINT fk_payments_course
    FOREIGN KEY (course_id) REFERENCES courses(id),
    CONSTRAINT chk_payments_amount_non_negative CHECK (amount >= 0),
    CONSTRAINT chk_payments_paid_at_when_success
    CHECK (payment_status <> 'SUCCESS' OR paid_at IS NOT NULL)
    );

CREATE TABLE IF NOT EXISTS enrollments (
                                           id BIGSERIAL PRIMARY KEY,
                                           user_id BIGINT NOT NULL,
                                           course_id BIGINT NOT NULL,
                                           payment_id BIGINT,
                                           enrolled_at TIMESTAMPTZ NOT NULL DEFAULT now(),
    status enrollment_status NOT NULL DEFAULT 'ACTIVE',

    CONSTRAINT fk_enrollments_user
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    CONSTRAINT fk_enrollments_course
    FOREIGN KEY (course_id) REFERENCES courses(id) ON DELETE CASCADE,
    CONSTRAINT fk_enrollments_payment
    FOREIGN KEY (payment_id) REFERENCES payments(id),
    CONSTRAINT uq_enrollments_user_course UNIQUE (user_id, course_id)
    );

CREATE TABLE IF NOT EXISTS lesson_progress (
                                               id BIGSERIAL PRIMARY KEY,
                                               user_id BIGINT NOT NULL,
                                               lesson_id BIGINT NOT NULL,
                                               course_id BIGINT NOT NULL,
                                               completed_at TIMESTAMPTZ NOT NULL DEFAULT now(),

    CONSTRAINT fk_lesson_progress_user
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    CONSTRAINT fk_lesson_progress_lesson
    FOREIGN KEY (lesson_id) REFERENCES lessons(id) ON DELETE CASCADE,
    CONSTRAINT fk_lesson_progress_course
    FOREIGN KEY (course_id) REFERENCES courses(id) ON DELETE CASCADE,
    CONSTRAINT uq_lesson_progress_user_lesson UNIQUE (user_id, lesson_id)
    );

CREATE TABLE IF NOT EXISTS completed_lessons_count (
                                                       id BIGSERIAL PRIMARY KEY,
                                                       user_id BIGINT NOT NULL,
                                                       course_id BIGINT NOT NULL,
                                                       completed_lessons_count INT NOT NULL DEFAULT 0,
                                                       updated_at TIMESTAMPTZ NOT NULL DEFAULT now(),

    CONSTRAINT fk_completed_lessons_count_user
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    CONSTRAINT fk_completed_lessons_count_course
    FOREIGN KEY (course_id) REFERENCES courses(id) ON DELETE CASCADE,
    CONSTRAINT uq_completed_lessons_count_user_course UNIQUE (user_id, course_id),
    CONSTRAINT chk_completed_lessons_count_non_negative CHECK (completed_lessons_count >= 0)
    );

-- =========================================================
-- QUIZ
-- =========================================================

CREATE TABLE IF NOT EXISTS quizzes (
                                       id BIGSERIAL PRIMARY KEY,
                                       lesson_id BIGINT NOT NULL UNIQUE,
                                       title VARCHAR(255) NOT NULL,
    description TEXT,
    created_by_teacher_id BIGINT NOT NULL,
    created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT now(),

    CONSTRAINT fk_quizzes_lesson
    FOREIGN KEY (lesson_id) REFERENCES lessons(id) ON DELETE CASCADE,
    CONSTRAINT fk_quizzes_created_by_teacher
    FOREIGN KEY (created_by_teacher_id) REFERENCES teachers(id),
    CONSTRAINT chk_quizzes_title_not_blank CHECK (length(trim(title)) > 0)
    );

CREATE TABLE IF NOT EXISTS quiz_questions (
                                              id BIGSERIAL PRIMARY KEY,
                                              quiz_id BIGINT NOT NULL,
                                              question_content TEXT NOT NULL,
                                              order_index INT NOT NULL,

                                              CONSTRAINT fk_quiz_questions_quiz
                                              FOREIGN KEY (quiz_id) REFERENCES quizzes(id) ON DELETE CASCADE,
    CONSTRAINT uq_quiz_questions_quiz_order UNIQUE (quiz_id, order_index),
    CONSTRAINT chk_quiz_questions_content_not_blank CHECK (length(trim(question_content)) > 0),
    CONSTRAINT chk_quiz_questions_order_positive CHECK (order_index > 0)
    );

CREATE TABLE IF NOT EXISTS quiz_options (
                                            id BIGSERIAL PRIMARY KEY,
                                            question_id BIGINT NOT NULL,
                                            content TEXT NOT NULL,
                                            is_correct BOOLEAN NOT NULL DEFAULT false,
                                            order_index INT,

                                            CONSTRAINT fk_quiz_options_question
                                            FOREIGN KEY (question_id) REFERENCES quiz_questions(id) ON DELETE CASCADE,
    CONSTRAINT chk_quiz_options_content_not_blank CHECK (length(trim(content)) > 0),
    CONSTRAINT chk_quiz_options_order_positive CHECK (order_index IS NULL OR order_index > 0)
    );

CREATE TABLE IF NOT EXISTS quiz_attempts (
                                             id BIGSERIAL PRIMARY KEY,
                                             user_id BIGINT NOT NULL,
                                             quiz_id BIGINT NOT NULL,
                                             total_questions INT NOT NULL,
                                             correct_answers INT NOT NULL,
                                             score NUMERIC(5,2) NOT NULL,
    submitted_at TIMESTAMPTZ NOT NULL DEFAULT now(),

    CONSTRAINT fk_quiz_attempts_user
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    CONSTRAINT fk_quiz_attempts_quiz
    FOREIGN KEY (quiz_id) REFERENCES quizzes(id) ON DELETE CASCADE,
    CONSTRAINT chk_quiz_attempts_total_questions_positive CHECK (total_questions > 0),
    CONSTRAINT chk_quiz_attempts_correct_answers_valid
    CHECK (correct_answers >= 0 AND correct_answers <= total_questions),
    CONSTRAINT chk_quiz_attempts_score_non_negative CHECK (score >= 0)
    );

-- =========================================================
-- ONLINE JUDGE
-- =========================================================

CREATE TABLE IF NOT EXISTS online_judge_problems (
                                                     id BIGSERIAL PRIMARY KEY,
                                                     lesson_id BIGINT,
                                                     title VARCHAR(255) NOT NULL,
    description TEXT,
    input_description TEXT,
    output_description TEXT,
    constraints TEXT,
    example_input TEXT,
    example_output TEXT,
    hint TEXT,
    problem_scope problem_scope NOT NULL,
    difficulty problem_difficulty NOT NULL,
    is_active BOOLEAN NOT NULL DEFAULT true,
    created_by_teacher_id BIGINT NOT NULL,
    created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT now(),

    CONSTRAINT fk_online_judge_problems_lesson
    FOREIGN KEY (lesson_id) REFERENCES lessons(id) ON DELETE SET NULL,
    CONSTRAINT fk_online_judge_problems_created_by_teacher
    FOREIGN KEY (created_by_teacher_id) REFERENCES teachers(id),
    CONSTRAINT chk_online_judge_problems_title_not_blank CHECK (length(trim(title)) > 0),
    CONSTRAINT chk_online_judge_problems_scope_lesson
    CHECK (
(problem_scope = 'LESSON' AND lesson_id IS NOT NULL)
    OR
(problem_scope IN ('CONTEST', 'SHARED'))
    )
    );

CREATE TABLE IF NOT EXISTS problem_tags (
                                            id BIGSERIAL PRIMARY KEY,
                                            name VARCHAR(100) NOT NULL,
    slug VARCHAR(120) NOT NULL UNIQUE,
    created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT now(),

    CONSTRAINT chk_problem_tags_name_not_blank CHECK (length(trim(name)) > 0),
    CONSTRAINT chk_problem_tags_slug_not_blank CHECK (length(trim(slug)) > 0)
    );

CREATE TABLE IF NOT EXISTS problem_tag_mappings (
                                                    id BIGSERIAL PRIMARY KEY,
                                                    problem_id BIGINT NOT NULL,
                                                    tag_id BIGINT NOT NULL,

                                                    CONSTRAINT fk_problem_tag_mappings_problem
                                                    FOREIGN KEY (problem_id) REFERENCES online_judge_problems(id) ON DELETE CASCADE,
    CONSTRAINT fk_problem_tag_mappings_tag
    FOREIGN KEY (tag_id) REFERENCES problem_tags(id) ON DELETE CASCADE,
    CONSTRAINT uq_problem_tag_mappings_problem_tag UNIQUE (problem_id, tag_id)
    );

CREATE TABLE IF NOT EXISTS problem_testcases (
                                                 id BIGSERIAL PRIMARY KEY,
                                                 problem_id BIGINT NOT NULL,
                                                 input_data TEXT NOT NULL,
                                                 expected_output TEXT NOT NULL,
                                                 is_hidden BOOLEAN NOT NULL DEFAULT false,
                                                 order_index INT NOT NULL,

                                                 CONSTRAINT fk_problem_testcases_problem
                                                 FOREIGN KEY (problem_id) REFERENCES online_judge_problems(id) ON DELETE CASCADE,
    CONSTRAINT uq_problem_testcases_problem_order UNIQUE (problem_id, order_index),
    CONSTRAINT chk_problem_testcases_order_positive CHECK (order_index > 0)
    );

-- contests is created before submissions because submissions references contests.
CREATE TABLE IF NOT EXISTS contests (
                                        id BIGSERIAL PRIMARY KEY,
                                        title VARCHAR(255) NOT NULL,
    description TEXT,
    password_hash VARCHAR(255),
    start_time TIMESTAMPTZ NOT NULL,
    end_time TIMESTAMPTZ NOT NULL,
    status contest_status NOT NULL DEFAULT 'UPCOMING',
    created_by_teacher_id BIGINT NOT NULL,
    created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT now(),

    CONSTRAINT fk_contests_created_by_teacher
    FOREIGN KEY (created_by_teacher_id) REFERENCES teachers(id),
    CONSTRAINT chk_contests_title_not_blank CHECK (length(trim(title)) > 0),
    CONSTRAINT chk_contests_time_valid CHECK (end_time > start_time)
    );

CREATE TABLE IF NOT EXISTS online_judge_submissions (
                                                        id BIGSERIAL PRIMARY KEY,
                                                        user_id BIGINT NOT NULL,
                                                        problem_id BIGINT NOT NULL,
                                                        lesson_id BIGINT,
                                                        contest_id BIGINT,
                                                        language_id INT NOT NULL,
                                                        source_code TEXT NOT NULL,
                                                        verdict oj_verdict NOT NULL,
                                                        execution_time_ms INT,
                                                        memory_used_kb INT,
                                                        score NUMERIC(6,2),
    submitted_at TIMESTAMPTZ NOT NULL DEFAULT now(),

    CONSTRAINT fk_online_judge_submissions_user
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    CONSTRAINT fk_online_judge_submissions_problem
    FOREIGN KEY (problem_id) REFERENCES online_judge_problems(id),
    CONSTRAINT fk_online_judge_submissions_lesson
    FOREIGN KEY (lesson_id) REFERENCES lessons(id),
    CONSTRAINT fk_online_judge_submissions_contest
    FOREIGN KEY (contest_id) REFERENCES contests(id),
    CONSTRAINT chk_online_judge_submissions_context
    CHECK (
(lesson_id IS NOT NULL AND contest_id IS NULL)
    OR
(lesson_id IS NULL AND contest_id IS NOT NULL)
    ),
    CONSTRAINT chk_online_judge_submissions_execution_time_non_negative
    CHECK (execution_time_ms IS NULL OR execution_time_ms >= 0),
    CONSTRAINT chk_online_judge_submissions_memory_non_negative
    CHECK (memory_used_kb IS NULL OR memory_used_kb >= 0),
    CONSTRAINT chk_online_judge_submissions_score_non_negative
    CHECK (score IS NULL OR score >= 0)
    );

-- =========================================================
-- FILE ASSIGNMENT
-- =========================================================

CREATE TABLE IF NOT EXISTS file_assignments (
                                                id BIGSERIAL PRIMARY KEY,
                                                lesson_id BIGINT NOT NULL,
                                                title VARCHAR(255) NOT NULL,
    description TEXT,
    assignment_file_url VARCHAR(500),
    assignment_file_name VARCHAR(255),
    allowed_extensions VARCHAR(255),
    created_by_teacher_id BIGINT NOT NULL,
    created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT now(),

    CONSTRAINT fk_file_assignments_lesson
    FOREIGN KEY (lesson_id) REFERENCES lessons(id) ON DELETE CASCADE,
    CONSTRAINT fk_file_assignments_created_by_teacher
    FOREIGN KEY (created_by_teacher_id) REFERENCES teachers(id),
    CONSTRAINT chk_file_assignments_title_not_blank CHECK (length(trim(title)) > 0)
    );

CREATE TABLE IF NOT EXISTS file_submissions (
                                                id BIGSERIAL PRIMARY KEY,
                                                file_assignment_id BIGINT NOT NULL,
                                                user_id BIGINT NOT NULL,
                                                attempt_no INT NOT NULL,
                                                file_url VARCHAR(500) NOT NULL,
    file_name VARCHAR(255) NOT NULL,
    submitted_at TIMESTAMPTZ NOT NULL DEFAULT now(),
    feedback TEXT,
    graded_at TIMESTAMPTZ,
    graded_by_teacher_id BIGINT,
    status file_submission_status NOT NULL DEFAULT 'SUBMITTED',

    CONSTRAINT fk_file_submissions_file_assignment
    FOREIGN KEY (file_assignment_id) REFERENCES file_assignments(id) ON DELETE CASCADE,
    CONSTRAINT fk_file_submissions_user
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    CONSTRAINT fk_file_submissions_graded_by_teacher
    FOREIGN KEY (graded_by_teacher_id) REFERENCES teachers(id),
    CONSTRAINT uq_file_submissions_assignment_user_attempt
    UNIQUE (file_assignment_id, user_id, attempt_no),
    CONSTRAINT chk_file_submissions_attempt_positive CHECK (attempt_no > 0),
    CONSTRAINT chk_file_submissions_file_url_not_blank CHECK (length(trim(file_url)) > 0),
    CONSTRAINT chk_file_submissions_file_name_not_blank CHECK (length(trim(file_name)) > 0),
    CONSTRAINT chk_file_submissions_grade_required_when_graded
    CHECK (status <> 'GRADED' OR graded_at IS NOT NULL)
    );

-- =========================================================
-- COMMENT / REVIEW
-- =========================================================

CREATE TABLE IF NOT EXISTS lesson_comments (
                                               id BIGSERIAL PRIMARY KEY,
                                               lesson_id BIGINT NOT NULL,
                                               user_id BIGINT NOT NULL,
                                               parent_comment_id BIGINT,
                                               content TEXT NOT NULL,
                                               created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT now(),

    CONSTRAINT fk_lesson_comments_lesson
    FOREIGN KEY (lesson_id) REFERENCES lessons(id) ON DELETE CASCADE,
    CONSTRAINT fk_lesson_comments_user
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    CONSTRAINT fk_lesson_comments_parent
    FOREIGN KEY (parent_comment_id) REFERENCES lesson_comments(id) ON DELETE CASCADE,
    CONSTRAINT chk_lesson_comments_content_not_blank CHECK (length(trim(content)) > 0),
    CONSTRAINT chk_lesson_comments_not_self_parent CHECK (parent_comment_id IS NULL OR parent_comment_id <> id)
    );

CREATE TABLE IF NOT EXISTS course_reviews (
                                              id BIGSERIAL PRIMARY KEY,
                                              course_id BIGINT NOT NULL,
                                              user_id BIGINT NOT NULL,
                                              content TEXT,
                                              rating INT NOT NULL,
                                              created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT now(),

    CONSTRAINT fk_course_reviews_course
    FOREIGN KEY (course_id) REFERENCES courses(id) ON DELETE CASCADE,
    CONSTRAINT fk_course_reviews_user
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    CONSTRAINT uq_course_reviews_course_user UNIQUE (course_id, user_id),
    CONSTRAINT chk_course_reviews_rating_range CHECK (rating BETWEEN 1 AND 5)
    );

-- =========================================================
-- CONTEST
-- =========================================================

CREATE TABLE IF NOT EXISTS contest_problems (
                                                id BIGSERIAL PRIMARY KEY,
                                                contest_id BIGINT NOT NULL,
                                                problem_id BIGINT NOT NULL,
                                                order_index INT NOT NULL,
                                                point NUMERIC(6,2) NOT NULL DEFAULT 100,

    CONSTRAINT fk_contest_problems_contest
    FOREIGN KEY (contest_id) REFERENCES contests(id) ON DELETE CASCADE,
    CONSTRAINT fk_contest_problems_problem
    FOREIGN KEY (problem_id) REFERENCES online_judge_problems(id) ON DELETE CASCADE,
    CONSTRAINT uq_contest_problems_contest_problem UNIQUE (contest_id, problem_id),
    CONSTRAINT uq_contest_problems_contest_order UNIQUE (contest_id, order_index),
    CONSTRAINT chk_contest_problems_order_positive CHECK (order_index > 0),
    CONSTRAINT chk_contest_problems_point_non_negative CHECK (point >= 0)
    );

CREATE TABLE IF NOT EXISTS contest_participants (
                                                    id BIGSERIAL PRIMARY KEY,
                                                    contest_id BIGINT NOT NULL,
                                                    user_id BIGINT NOT NULL,
                                                    joined_at TIMESTAMPTZ NOT NULL DEFAULT now(),

    CONSTRAINT fk_contest_participants_contest
    FOREIGN KEY (contest_id) REFERENCES contests(id) ON DELETE CASCADE,
    CONSTRAINT fk_contest_participants_user
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    CONSTRAINT uq_contest_participants_contest_user UNIQUE (contest_id, user_id)
    );

-- =========================================================
-- INDEXES
-- =========================================================

-- Auth/session cleanup and lookup
CREATE INDEX IF NOT EXISTS idx_invalidated_tokens_user_id
    ON invalidated_tokens(user_id);

CREATE INDEX IF NOT EXISTS idx_invalidated_tokens_expiry_time
    ON invalidated_tokens(expiry_time);

CREATE INDEX IF NOT EXISTS idx_refresh_tokens_user_id
    ON refresh_tokens(user_id);

CREATE INDEX IF NOT EXISTS idx_refresh_tokens_expires_at
    ON refresh_tokens(expires_at);

-- Course listing and structure
CREATE INDEX IF NOT EXISTS idx_courses_status
    ON courses(status);

CREATE INDEX IF NOT EXISTS idx_chapters_course_id
    ON chapters(course_id);

CREATE INDEX IF NOT EXISTS idx_lessons_chapter_id
    ON lessons(chapter_id);

CREATE INDEX IF NOT EXISTS idx_teacher_course_assignments_course_id
    ON teacher_course_assignments(course_id);

CREATE INDEX IF NOT EXISTS idx_teacher_course_assignments_assigned_by_admin_id
    ON teacher_course_assignments(assigned_by_admin_id);

-- Payment / enrollment / progress
CREATE INDEX IF NOT EXISTS idx_payments_user_id
    ON payments(user_id);

CREATE INDEX IF NOT EXISTS idx_payments_course_id
    ON payments(course_id);

CREATE INDEX IF NOT EXISTS idx_payments_payment_status
    ON payments(payment_status);

CREATE INDEX IF NOT EXISTS idx_enrollments_course_id
    ON enrollments(course_id);

CREATE INDEX IF NOT EXISTS idx_lesson_progress_user_course
    ON lesson_progress(user_id, course_id);

CREATE INDEX IF NOT EXISTS idx_lesson_progress_course_id
    ON lesson_progress(course_id);

-- Quiz
CREATE INDEX IF NOT EXISTS idx_quiz_questions_quiz_id
    ON quiz_questions(quiz_id);

CREATE INDEX IF NOT EXISTS idx_quiz_options_question_id
    ON quiz_options(question_id);

CREATE INDEX IF NOT EXISTS idx_quiz_attempts_user_id
    ON quiz_attempts(user_id);

CREATE INDEX IF NOT EXISTS idx_quiz_attempts_quiz_id
    ON quiz_attempts(quiz_id);

-- Online judge
CREATE INDEX IF NOT EXISTS idx_online_judge_problems_lesson_id
    ON online_judge_problems(lesson_id);

CREATE INDEX IF NOT EXISTS idx_online_judge_problems_created_by_teacher_id
    ON online_judge_problems(created_by_teacher_id);

CREATE INDEX IF NOT EXISTS idx_online_judge_problems_scope_difficulty
    ON online_judge_problems(problem_scope, difficulty);

CREATE INDEX IF NOT EXISTS idx_problem_tag_mappings_tag_id
    ON problem_tag_mappings(tag_id);

CREATE INDEX IF NOT EXISTS idx_problem_testcases_problem_id
    ON problem_testcases(problem_id);

CREATE INDEX IF NOT EXISTS idx_online_judge_submissions_contest_id
    ON online_judge_submissions(contest_id);

CREATE INDEX IF NOT EXISTS idx_online_judge_submissions_contest_user_problem
    ON online_judge_submissions(contest_id, user_id, problem_id);

CREATE INDEX IF NOT EXISTS idx_online_judge_submissions_lesson_user_problem
    ON online_judge_submissions(lesson_id, user_id, problem_id);

CREATE INDEX IF NOT EXISTS idx_online_judge_submissions_user_id
    ON online_judge_submissions(user_id);

CREATE INDEX IF NOT EXISTS idx_online_judge_submissions_problem_id
    ON online_judge_submissions(problem_id);

CREATE INDEX IF NOT EXISTS idx_online_judge_submissions_submitted_at
    ON online_judge_submissions(submitted_at);

-- File assignment
CREATE INDEX IF NOT EXISTS idx_file_assignments_lesson_id
    ON file_assignments(lesson_id);

CREATE INDEX IF NOT EXISTS idx_file_assignments_created_by_teacher_id
    ON file_assignments(created_by_teacher_id);

CREATE INDEX IF NOT EXISTS idx_file_submissions_user_id
    ON file_submissions(user_id);

CREATE INDEX IF NOT EXISTS idx_file_submissions_status
    ON file_submissions(status);

CREATE INDEX IF NOT EXISTS idx_file_submissions_graded_by_teacher_id
    ON file_submissions(graded_by_teacher_id);

-- Comments and reviews
CREATE INDEX IF NOT EXISTS idx_lesson_comments_lesson_id
    ON lesson_comments(lesson_id);

CREATE INDEX IF NOT EXISTS idx_lesson_comments_parent_comment_id
    ON lesson_comments(parent_comment_id);

CREATE INDEX IF NOT EXISTS idx_lesson_comments_lesson_parent
    ON lesson_comments(lesson_id, parent_comment_id);

CREATE INDEX IF NOT EXISTS idx_course_reviews_user_id
    ON course_reviews(user_id);

-- Contest
CREATE INDEX IF NOT EXISTS idx_contests_status_time
    ON contests(status, start_time, end_time);

CREATE INDEX IF NOT EXISTS idx_contests_created_by_teacher_id
    ON contests(created_by_teacher_id);

CREATE INDEX IF NOT EXISTS idx_contest_problems_problem_id
    ON contest_problems(problem_id);

CREATE INDEX IF NOT EXISTS idx_contest_participants_user_id
    ON contest_participants(user_id);

-- =========================================================
-- UPDATED_AT TRIGGERS
-- =========================================================

DROP TRIGGER IF EXISTS trg_users_set_updated_at ON users;
CREATE TRIGGER trg_users_set_updated_at
    BEFORE UPDATE ON users
    FOR EACH ROW
    EXECUTE FUNCTION set_updated_at();

DROP TRIGGER IF EXISTS trg_teachers_set_updated_at ON teachers;
CREATE TRIGGER trg_teachers_set_updated_at
    BEFORE UPDATE ON teachers
    FOR EACH ROW
    EXECUTE FUNCTION set_updated_at();

DROP TRIGGER IF EXISTS trg_courses_set_updated_at ON courses;
CREATE TRIGGER trg_courses_set_updated_at
    BEFORE UPDATE ON courses
    FOR EACH ROW
    EXECUTE FUNCTION set_updated_at();

DROP TRIGGER IF EXISTS trg_lessons_set_updated_at ON lessons;
CREATE TRIGGER trg_lessons_set_updated_at
    BEFORE UPDATE ON lessons
    FOR EACH ROW
    EXECUTE FUNCTION set_updated_at();

DROP TRIGGER IF EXISTS trg_completed_lessons_count_set_updated_at ON completed_lessons_count;
CREATE TRIGGER trg_completed_lessons_count_set_updated_at
    BEFORE UPDATE ON completed_lessons_count
    FOR EACH ROW
    EXECUTE FUNCTION set_updated_at();

DROP TRIGGER IF EXISTS trg_quizzes_set_updated_at ON quizzes;
CREATE TRIGGER trg_quizzes_set_updated_at
    BEFORE UPDATE ON quizzes
    FOR EACH ROW
    EXECUTE FUNCTION set_updated_at();

DROP TRIGGER IF EXISTS trg_online_judge_problems_set_updated_at ON online_judge_problems;
CREATE TRIGGER trg_online_judge_problems_set_updated_at
    BEFORE UPDATE ON online_judge_problems
    FOR EACH ROW
    EXECUTE FUNCTION set_updated_at();

DROP TRIGGER IF EXISTS trg_problem_tags_set_updated_at ON problem_tags;
CREATE TRIGGER trg_problem_tags_set_updated_at
    BEFORE UPDATE ON problem_tags
    FOR EACH ROW
    EXECUTE FUNCTION set_updated_at();

DROP TRIGGER IF EXISTS trg_file_assignments_set_updated_at ON file_assignments;
CREATE TRIGGER trg_file_assignments_set_updated_at
    BEFORE UPDATE ON file_assignments
    FOR EACH ROW
    EXECUTE FUNCTION set_updated_at();

DROP TRIGGER IF EXISTS trg_lesson_comments_set_updated_at ON lesson_comments;
CREATE TRIGGER trg_lesson_comments_set_updated_at
    BEFORE UPDATE ON lesson_comments
    FOR EACH ROW
    EXECUTE FUNCTION set_updated_at();

DROP TRIGGER IF EXISTS trg_course_reviews_set_updated_at ON course_reviews;
CREATE TRIGGER trg_course_reviews_set_updated_at
    BEFORE UPDATE ON course_reviews
    FOR EACH ROW
    EXECUTE FUNCTION set_updated_at();

DROP TRIGGER IF EXISTS trg_contests_set_updated_at ON contests;
CREATE TRIGGER trg_contests_set_updated_at
    BEFORE UPDATE ON contests
    FOR EACH ROW
    EXECUTE FUNCTION set_updated_at();

COMMIT;
