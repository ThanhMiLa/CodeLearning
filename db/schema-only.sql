--
-- PostgreSQL database dump
--

\restrict ac0PMPqA2P5KfCeOysfnE2uWOSfNRbEG0hH7gIAW55cS2kpPrxP0l89UjVoHejg

-- Dumped from database version 18.1
-- Dumped by pg_dump version 18.1

-- Started on 2026-05-15 12:40:35

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- TOC entry 4 (class 2615 OID 2200)
-- Name: public; Type: SCHEMA; Schema: -; Owner: -
--

CREATE SCHEMA public;


--
-- TOC entry 5672 (class 0 OID 0)
-- Dependencies: 4
-- Name: SCHEMA public; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON SCHEMA public IS 'standard public schema';


--
-- TOC entry 936 (class 1247 OID 16842)
-- Name: contest_status; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.contest_status AS ENUM (
    'UPCOMING',
    'RUNNING',
    'ENDED',
    'CANCELLED'
);


--
-- TOC entry 924 (class 1247 OID 16810)
-- Name: course_status; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.course_status AS ENUM (
    'ACTIVE',
    'INACTIVE',
    'DRAFT'
);


--
-- TOC entry 930 (class 1247 OID 16826)
-- Name: enrollment_status; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.enrollment_status AS ENUM (
    'ACTIVE',
    'CANCELLED',
    'COMPLETED'
);


--
-- TOC entry 948 (class 1247 OID 16892)
-- Name: file_submission_status; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.file_submission_status AS ENUM (
    'SUBMITTED',
    'IN_REVIEW',
    'GRADED',
    'NEEDS_RESUBMISSION',
    'REPLACED',
    'RESUBMITTED'
);


--
-- TOC entry 927 (class 1247 OID 16818)
-- Name: lesson_status; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.lesson_status AS ENUM (
    'ACTIVE',
    'INACTIVE',
    'DRAFT'
);


--
-- TOC entry 1056 (class 1247 OID 17908)
-- Name: oj_verdict; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.oj_verdict AS ENUM (
    'PENDING',
    'PROCESSING',
    'ACCEPTED',
    'WRONG_ANSWER',
    'TIME_LIMIT_EXCEEDED',
    'COMPILATION_ERROR',
    'RUNTIME_ERROR',
    'MEMORY_LIMIT_EXCEEDED',
    'INTERNAL_ERROR'
);


--
-- TOC entry 945 (class 1247 OID 16882)
-- Name: payment_status; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.payment_status AS ENUM (
    'PENDING',
    'SUCCESS',
    'FAILED',
    'CANCELLED'
);


--
-- TOC entry 942 (class 1247 OID 16860)
-- Name: problem_difficulty; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.problem_difficulty AS ENUM (
    'EASY',
    'MEDIUM',
    'HARD'
);


--
-- TOC entry 939 (class 1247 OID 16852)
-- Name: problem_scope; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.problem_scope AS ENUM (
    'LESSON',
    'CONTEST',
    'SHARED'
);


--
-- TOC entry 933 (class 1247 OID 16834)
-- Name: teacher_status; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.teacher_status AS ENUM (
    'ACTIVE',
    'INACTIVE',
    'LOCKED'
);


--
-- TOC entry 921 (class 1247 OID 16802)
-- Name: user_status; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.user_status AS ENUM (
    'ACTIVE',
    'LOCKED',
    'DISABLED'
);


--
-- TOC entry 288 (class 1255 OID 16905)
-- Name: set_updated_at(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.set_updated_at() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    NEW.updated_at = now();
    RETURN NEW;
END;
$$;


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 282 (class 1259 OID 17785)
-- Name: categories; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.categories (
    id bigint NOT NULL,
    name character varying(100) NOT NULL,
    slug character varying(120) NOT NULL,
    description text,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL
);


--
-- TOC entry 281 (class 1259 OID 17784)
-- Name: categories_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.categories_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 5673 (class 0 OID 0)
-- Dependencies: 281
-- Name: categories_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.categories_id_seq OWNED BY public.categories.id;


--
-- TOC entry 236 (class 1259 OID 17074)
-- Name: chapters; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.chapters (
    id bigint NOT NULL,
    course_id bigint NOT NULL,
    title character varying(255) NOT NULL,
    order_index integer NOT NULL,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    CONSTRAINT chk_chapters_order_positive CHECK ((order_index > 0)),
    CONSTRAINT chk_chapters_title_not_blank CHECK ((length(TRIM(BOTH FROM title)) > 0))
);


--
-- TOC entry 235 (class 1259 OID 17073)
-- Name: chapters_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.chapters_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 5674 (class 0 OID 0)
-- Dependencies: 235
-- Name: chapters_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.chapters_id_seq OWNED BY public.chapters.id;


--
-- TOC entry 248 (class 1259 OID 17243)
-- Name: completed_lessons_count; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.completed_lessons_count (
    id bigint NOT NULL,
    user_id bigint NOT NULL,
    course_id bigint NOT NULL,
    completed_lessons_count integer DEFAULT 0 NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    CONSTRAINT chk_completed_lessons_count_non_negative CHECK ((completed_lessons_count >= 0))
);


--
-- TOC entry 247 (class 1259 OID 17242)
-- Name: completed_lessons_count_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.completed_lessons_count_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 5675 (class 0 OID 0)
-- Dependencies: 247
-- Name: completed_lessons_count_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.completed_lessons_count_id_seq OWNED BY public.completed_lessons_count.id;


--
-- TOC entry 280 (class 1259 OID 17696)
-- Name: contest_participants; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.contest_participants (
    id bigint NOT NULL,
    contest_id bigint NOT NULL,
    user_id bigint NOT NULL,
    joined_at timestamp with time zone DEFAULT now() NOT NULL
);


--
-- TOC entry 279 (class 1259 OID 17695)
-- Name: contest_participants_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.contest_participants_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 5676 (class 0 OID 0)
-- Dependencies: 279
-- Name: contest_participants_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.contest_participants_id_seq OWNED BY public.contest_participants.id;


--
-- TOC entry 278 (class 1259 OID 17667)
-- Name: contest_problems; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.contest_problems (
    id bigint NOT NULL,
    contest_id bigint NOT NULL,
    problem_id bigint NOT NULL,
    order_index integer NOT NULL,
    point numeric(6,2) DEFAULT 100 NOT NULL,
    CONSTRAINT chk_contest_problems_order_positive CHECK ((order_index > 0)),
    CONSTRAINT chk_contest_problems_point_non_negative CHECK ((point >= (0)::numeric))
);


--
-- TOC entry 277 (class 1259 OID 17666)
-- Name: contest_problems_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.contest_problems_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 5677 (class 0 OID 0)
-- Dependencies: 277
-- Name: contest_problems_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.contest_problems_id_seq OWNED BY public.contest_problems.id;


--
-- TOC entry 266 (class 1259 OID 17467)
-- Name: contests; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.contests (
    id bigint NOT NULL,
    title character varying(255) NOT NULL,
    description text,
    password_hash character varying(255),
    start_time timestamp with time zone NOT NULL,
    end_time timestamp with time zone NOT NULL,
    status public.contest_status DEFAULT 'UPCOMING'::public.contest_status NOT NULL,
    created_by_teacher_id bigint NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    CONSTRAINT chk_contests_time_valid CHECK ((end_time > start_time)),
    CONSTRAINT chk_contests_title_not_blank CHECK ((length(TRIM(BOTH FROM title)) > 0))
);


--
-- TOC entry 265 (class 1259 OID 17466)
-- Name: contests_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.contests_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 5678 (class 0 OID 0)
-- Dependencies: 265
-- Name: contests_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.contests_id_seq OWNED BY public.contests.id;


--
-- TOC entry 283 (class 1259 OID 17804)
-- Name: course_category_mappings; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.course_category_mappings (
    course_id bigint NOT NULL,
    category_id bigint NOT NULL
);


--
-- TOC entry 276 (class 1259 OID 17637)
-- Name: course_reviews; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.course_reviews (
    id bigint NOT NULL,
    course_id bigint NOT NULL,
    user_id bigint NOT NULL,
    content text,
    rating integer NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    CONSTRAINT chk_course_reviews_rating_range CHECK (((rating >= 1) AND (rating <= 5)))
);


--
-- TOC entry 275 (class 1259 OID 17636)
-- Name: course_reviews_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.course_reviews_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 5679 (class 0 OID 0)
-- Dependencies: 275
-- Name: course_reviews_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.course_reviews_id_seq OWNED BY public.course_reviews.id;


--
-- TOC entry 234 (class 1259 OID 17052)
-- Name: courses; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.courses (
    id bigint NOT NULL,
    title character varying(255) NOT NULL,
    short_description text,
    course_content text,
    learning_outcomes text,
    course_highlights text,
    technologies_tools text,
    prerequisites text,
    target_audience text,
    completion_benefits text,
    price numeric(12,2) DEFAULT 0 NOT NULL,
    thumbnail_url character varying(500),
    estimated_duration_hours integer,
    status public.course_status DEFAULT 'DRAFT'::public.course_status NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    average_rating double precision DEFAULT 0.00 NOT NULL,
    total_reviews integer DEFAULT 0 NOT NULL,
    total_enrolled integer DEFAULT 0 NOT NULL,
    total_lessons integer DEFAULT 0 NOT NULL,
    total_quizzes integer DEFAULT 0 NOT NULL,
    total_assignments integer DEFAULT 0 NOT NULL,
    total_online_judge_problems integer DEFAULT 0 NOT NULL,
    total_videos integer DEFAULT 0 NOT NULL,
    CONSTRAINT chk_courses_estimated_duration_positive CHECK (((estimated_duration_hours IS NULL) OR (estimated_duration_hours > 0))),
    CONSTRAINT chk_courses_price_non_negative CHECK ((price >= (0)::numeric)),
    CONSTRAINT chk_courses_title_not_blank CHECK ((length(TRIM(BOTH FROM title)) > 0))
);


--
-- TOC entry 233 (class 1259 OID 17051)
-- Name: courses_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.courses_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 5680 (class 0 OID 0)
-- Dependencies: 233
-- Name: courses_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.courses_id_seq OWNED BY public.courses.id;


--
-- TOC entry 244 (class 1259 OID 17182)
-- Name: enrollments; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.enrollments (
    id bigint NOT NULL,
    user_id bigint NOT NULL,
    course_id bigint NOT NULL,
    payment_id bigint,
    enrolled_at timestamp with time zone DEFAULT now() NOT NULL,
    status public.enrollment_status DEFAULT 'ACTIVE'::public.enrollment_status NOT NULL
);


--
-- TOC entry 243 (class 1259 OID 17181)
-- Name: enrollments_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.enrollments_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 5681 (class 0 OID 0)
-- Dependencies: 243
-- Name: enrollments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.enrollments_id_seq OWNED BY public.enrollments.id;


--
-- TOC entry 270 (class 1259 OID 17535)
-- Name: file_assignments; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.file_assignments (
    id bigint NOT NULL,
    lesson_id bigint NOT NULL,
    title character varying(255) NOT NULL,
    description text,
    assignment_file_url character varying(500),
    assignment_file_name character varying(255),
    allowed_extensions character varying(255),
    created_by_teacher_id bigint NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    CONSTRAINT chk_file_assignments_title_not_blank CHECK ((length(TRIM(BOTH FROM title)) > 0))
);


--
-- TOC entry 269 (class 1259 OID 17534)
-- Name: file_assignments_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.file_assignments_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 5682 (class 0 OID 0)
-- Dependencies: 269
-- Name: file_assignments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.file_assignments_id_seq OWNED BY public.file_assignments.id;


--
-- TOC entry 272 (class 1259 OID 17563)
-- Name: file_submissions; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.file_submissions (
    id bigint NOT NULL,
    file_assignment_id bigint NOT NULL,
    user_id bigint NOT NULL,
    attempt_no integer NOT NULL,
    file_url character varying(500) NOT NULL,
    file_name character varying(255) NOT NULL,
    submitted_at timestamp with time zone DEFAULT now() NOT NULL,
    feedback text,
    graded_at timestamp with time zone,
    graded_by_teacher_id bigint,
    status public.file_submission_status DEFAULT 'SUBMITTED'::public.file_submission_status NOT NULL,
    CONSTRAINT chk_file_submissions_attempt_positive CHECK ((attempt_no > 0)),
    CONSTRAINT chk_file_submissions_file_name_not_blank CHECK ((length(TRIM(BOTH FROM file_name)) > 0)),
    CONSTRAINT chk_file_submissions_file_url_not_blank CHECK ((length(TRIM(BOTH FROM file_url)) > 0)),
    CONSTRAINT chk_file_submissions_grade_required_when_graded CHECK (((status <> 'GRADED'::public.file_submission_status) OR (graded_at IS NOT NULL)))
);


--
-- TOC entry 271 (class 1259 OID 17562)
-- Name: file_submissions_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.file_submissions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 5683 (class 0 OID 0)
-- Dependencies: 271
-- Name: file_submissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.file_submissions_id_seq OWNED BY public.file_submissions.id;


--
-- TOC entry 228 (class 1259 OID 16990)
-- Name: invalidated_tokens; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.invalidated_tokens (
    id bigint NOT NULL,
    token_jti character varying(255) NOT NULL,
    expiry_time timestamp with time zone NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL
);


--
-- TOC entry 227 (class 1259 OID 16989)
-- Name: invalidated_tokens_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.invalidated_tokens_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 5684 (class 0 OID 0)
-- Dependencies: 227
-- Name: invalidated_tokens_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.invalidated_tokens_id_seq OWNED BY public.invalidated_tokens.id;


--
-- TOC entry 274 (class 1259 OID 17603)
-- Name: lesson_comments; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.lesson_comments (
    id bigint NOT NULL,
    lesson_id bigint NOT NULL,
    user_id bigint NOT NULL,
    parent_comment_id bigint,
    content text NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    CONSTRAINT chk_lesson_comments_content_not_blank CHECK ((length(TRIM(BOTH FROM content)) > 0)),
    CONSTRAINT chk_lesson_comments_not_self_parent CHECK (((parent_comment_id IS NULL) OR (parent_comment_id <> id)))
);


--
-- TOC entry 273 (class 1259 OID 17602)
-- Name: lesson_comments_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.lesson_comments_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 5685 (class 0 OID 0)
-- Dependencies: 273
-- Name: lesson_comments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.lesson_comments_id_seq OWNED BY public.lesson_comments.id;


--
-- TOC entry 246 (class 1259 OID 17213)
-- Name: lesson_progress; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.lesson_progress (
    id bigint NOT NULL,
    user_id bigint NOT NULL,
    lesson_id bigint NOT NULL,
    course_id bigint NOT NULL,
    completed_at timestamp with time zone DEFAULT now() NOT NULL
);


--
-- TOC entry 245 (class 1259 OID 17212)
-- Name: lesson_progress_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.lesson_progress_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 5686 (class 0 OID 0)
-- Dependencies: 245
-- Name: lesson_progress_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.lesson_progress_id_seq OWNED BY public.lesson_progress.id;


--
-- TOC entry 238 (class 1259 OID 17094)
-- Name: lessons; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.lessons (
    id bigint NOT NULL,
    chapter_id bigint NOT NULL,
    title character varying(255) NOT NULL,
    description text,
    video_url character varying(500),
    theory_content text,
    sample_code text,
    is_trial boolean DEFAULT false NOT NULL,
    order_index integer NOT NULL,
    estimated_duration_minutes integer,
    status public.lesson_status DEFAULT 'DRAFT'::public.lesson_status NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    has_quiz boolean DEFAULT false NOT NULL,
    has_assignment boolean DEFAULT false NOT NULL,
    has_online_judge boolean DEFAULT false NOT NULL,
    CONSTRAINT chk_lessons_estimated_duration_positive CHECK (((estimated_duration_minutes IS NULL) OR (estimated_duration_minutes > 0))),
    CONSTRAINT chk_lessons_order_positive CHECK ((order_index > 0)),
    CONSTRAINT chk_lessons_title_not_blank CHECK ((length(TRIM(BOTH FROM title)) > 0))
);


--
-- TOC entry 237 (class 1259 OID 17093)
-- Name: lessons_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.lessons_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 5687 (class 0 OID 0)
-- Dependencies: 237
-- Name: lessons_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.lessons_id_seq OWNED BY public.lessons.id;


--
-- TOC entry 258 (class 1259 OID 17371)
-- Name: online_judge_problems; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.online_judge_problems (
    id bigint NOT NULL,
    lesson_id bigint,
    title character varying(255) NOT NULL,
    description text,
    input_description text,
    output_description text,
    constraints text,
    example_input text,
    example_output text,
    hint text,
    problem_scope public.problem_scope NOT NULL,
    difficulty public.problem_difficulty NOT NULL,
    is_active boolean DEFAULT true NOT NULL,
    created_by_teacher_id bigint NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    CONSTRAINT chk_online_judge_problems_scope_lesson CHECK ((((problem_scope = 'LESSON'::public.problem_scope) AND (lesson_id IS NOT NULL)) OR (problem_scope = ANY (ARRAY['CONTEST'::public.problem_scope, 'SHARED'::public.problem_scope])))),
    CONSTRAINT chk_online_judge_problems_title_not_blank CHECK ((length(TRIM(BOTH FROM title)) > 0))
);


--
-- TOC entry 257 (class 1259 OID 17370)
-- Name: online_judge_problems_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.online_judge_problems_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 5688 (class 0 OID 0)
-- Dependencies: 257
-- Name: online_judge_problems_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.online_judge_problems_id_seq OWNED BY public.online_judge_problems.id;


--
-- TOC entry 287 (class 1259 OID 17928)
-- Name: online_judge_submission_details; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.online_judge_submission_details (
    id integer NOT NULL,
    submission_id bigint NOT NULL,
    testcase_id bigint NOT NULL,
    token character varying(255) NOT NULL,
    verdict public.oj_verdict DEFAULT 'PENDING'::public.oj_verdict NOT NULL,
    execution_time_ms integer,
    memory_used_kb integer,
    created_at timestamp with time zone DEFAULT now() NOT NULL
);


--
-- TOC entry 286 (class 1259 OID 17927)
-- Name: online_judge_submission_details_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.online_judge_submission_details_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 5689 (class 0 OID 0)
-- Dependencies: 286
-- Name: online_judge_submission_details_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.online_judge_submission_details_id_seq OWNED BY public.online_judge_submission_details.id;


--
-- TOC entry 268 (class 1259 OID 17494)
-- Name: online_judge_submissions; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.online_judge_submissions (
    id bigint NOT NULL,
    user_id bigint NOT NULL,
    problem_id bigint NOT NULL,
    lesson_id bigint,
    contest_id bigint,
    language_id integer NOT NULL,
    source_code text NOT NULL,
    execution_time_ms integer,
    memory_used_kb integer,
    score numeric(6,2),
    submitted_at timestamp with time zone DEFAULT now() NOT NULL,
    CONSTRAINT chk_online_judge_submissions_context CHECK ((((lesson_id IS NOT NULL) AND (contest_id IS NULL)) OR ((lesson_id IS NULL) AND (contest_id IS NOT NULL)))),
    CONSTRAINT chk_online_judge_submissions_execution_time_non_negative CHECK (((execution_time_ms IS NULL) OR (execution_time_ms >= 0))),
    CONSTRAINT chk_online_judge_submissions_memory_non_negative CHECK (((memory_used_kb IS NULL) OR (memory_used_kb >= 0))),
    CONSTRAINT chk_online_judge_submissions_score_non_negative CHECK (((score IS NULL) OR (score >= (0)::numeric)))
);


--
-- TOC entry 267 (class 1259 OID 17493)
-- Name: online_judge_submissions_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.online_judge_submissions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 5690 (class 0 OID 0)
-- Dependencies: 267
-- Name: online_judge_submissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.online_judge_submissions_id_seq OWNED BY public.online_judge_submissions.id;


--
-- TOC entry 242 (class 1259 OID 17155)
-- Name: payments; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.payments (
    id bigint NOT NULL,
    user_id bigint NOT NULL,
    course_id bigint NOT NULL,
    amount numeric(12,2) NOT NULL,
    payment_method character varying(100),
    transaction_code character varying(255),
    payment_status public.payment_status DEFAULT 'PENDING'::public.payment_status NOT NULL,
    paid_at timestamp with time zone,
    CONSTRAINT chk_payments_amount_non_negative CHECK ((amount >= (0)::numeric)),
    CONSTRAINT chk_payments_paid_at_when_success CHECK (((payment_status <> 'SUCCESS'::public.payment_status) OR (paid_at IS NOT NULL)))
);


--
-- TOC entry 241 (class 1259 OID 17154)
-- Name: payments_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.payments_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 5691 (class 0 OID 0)
-- Dependencies: 241
-- Name: payments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.payments_id_seq OWNED BY public.payments.id;


--
-- TOC entry 224 (class 1259 OID 16944)
-- Name: permissions; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.permissions (
    id bigint NOT NULL,
    name character varying(150) NOT NULL,
    CONSTRAINT chk_permissions_name_not_blank CHECK ((length(TRIM(BOTH FROM name)) > 0))
);


--
-- TOC entry 223 (class 1259 OID 16943)
-- Name: permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.permissions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 5692 (class 0 OID 0)
-- Dependencies: 223
-- Name: permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.permissions_id_seq OWNED BY public.permissions.id;


--
-- TOC entry 262 (class 1259 OID 17421)
-- Name: problem_tag_mappings; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.problem_tag_mappings (
    id bigint NOT NULL,
    problem_id bigint NOT NULL,
    tag_id bigint NOT NULL
);


--
-- TOC entry 261 (class 1259 OID 17420)
-- Name: problem_tag_mappings_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.problem_tag_mappings_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 5693 (class 0 OID 0)
-- Dependencies: 261
-- Name: problem_tag_mappings_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.problem_tag_mappings_id_seq OWNED BY public.problem_tag_mappings.id;


--
-- TOC entry 260 (class 1259 OID 17403)
-- Name: problem_tags; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.problem_tags (
    id bigint NOT NULL,
    name character varying(100) NOT NULL,
    slug character varying(120) NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    CONSTRAINT chk_problem_tags_name_not_blank CHECK ((length(TRIM(BOTH FROM name)) > 0)),
    CONSTRAINT chk_problem_tags_slug_not_blank CHECK ((length(TRIM(BOTH FROM slug)) > 0))
);


--
-- TOC entry 259 (class 1259 OID 17402)
-- Name: problem_tags_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.problem_tags_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 5694 (class 0 OID 0)
-- Dependencies: 259
-- Name: problem_tags_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.problem_tags_id_seq OWNED BY public.problem_tags.id;


--
-- TOC entry 264 (class 1259 OID 17443)
-- Name: problem_testcases; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.problem_testcases (
    id bigint NOT NULL,
    problem_id bigint NOT NULL,
    input_data text NOT NULL,
    expected_output text NOT NULL,
    is_hidden boolean DEFAULT false NOT NULL,
    order_index integer NOT NULL,
    CONSTRAINT chk_problem_testcases_order_positive CHECK ((order_index > 0))
);


--
-- TOC entry 263 (class 1259 OID 17442)
-- Name: problem_testcases_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.problem_testcases_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 5695 (class 0 OID 0)
-- Dependencies: 263
-- Name: problem_testcases_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.problem_testcases_id_seq OWNED BY public.problem_testcases.id;


--
-- TOC entry 285 (class 1259 OID 17871)
-- Name: quiz_attempt_answers; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.quiz_attempt_answers (
    id bigint NOT NULL,
    attempt_id bigint NOT NULL,
    question_id bigint NOT NULL,
    selected_option_id bigint
);


--
-- TOC entry 284 (class 1259 OID 17870)
-- Name: quiz_attempt_answers_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.quiz_attempt_answers_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 5696 (class 0 OID 0)
-- Dependencies: 284
-- Name: quiz_attempt_answers_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.quiz_attempt_answers_id_seq OWNED BY public.quiz_attempt_answers.id;


--
-- TOC entry 256 (class 1259 OID 17343)
-- Name: quiz_attempts; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.quiz_attempts (
    id bigint NOT NULL,
    user_id bigint NOT NULL,
    quiz_id bigint NOT NULL,
    total_questions integer NOT NULL,
    correct_answers integer NOT NULL,
    score numeric(5,2) NOT NULL,
    submitted_at timestamp with time zone DEFAULT now() NOT NULL,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT chk_quiz_attempts_correct_answers_valid CHECK (((correct_answers >= 0) AND (correct_answers <= total_questions))),
    CONSTRAINT chk_quiz_attempts_score_non_negative CHECK ((score >= (0)::numeric)),
    CONSTRAINT chk_quiz_attempts_total_questions_positive CHECK ((total_questions > 0))
);


--
-- TOC entry 255 (class 1259 OID 17342)
-- Name: quiz_attempts_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.quiz_attempts_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 5697 (class 0 OID 0)
-- Dependencies: 255
-- Name: quiz_attempts_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.quiz_attempts_id_seq OWNED BY public.quiz_attempts.id;


--
-- TOC entry 254 (class 1259 OID 17322)
-- Name: quiz_options; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.quiz_options (
    id bigint NOT NULL,
    question_id bigint NOT NULL,
    content text NOT NULL,
    is_correct boolean DEFAULT false NOT NULL,
    order_index integer,
    CONSTRAINT chk_quiz_options_content_not_blank CHECK ((length(TRIM(BOTH FROM content)) > 0)),
    CONSTRAINT chk_quiz_options_order_positive CHECK (((order_index IS NULL) OR (order_index > 0)))
);


--
-- TOC entry 253 (class 1259 OID 17321)
-- Name: quiz_options_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.quiz_options_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 5698 (class 0 OID 0)
-- Dependencies: 253
-- Name: quiz_options_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.quiz_options_id_seq OWNED BY public.quiz_options.id;


--
-- TOC entry 252 (class 1259 OID 17300)
-- Name: quiz_questions; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.quiz_questions (
    id bigint NOT NULL,
    quiz_id bigint NOT NULL,
    question_content text NOT NULL,
    order_index integer NOT NULL,
    CONSTRAINT chk_quiz_questions_content_not_blank CHECK ((length(TRIM(BOTH FROM question_content)) > 0)),
    CONSTRAINT chk_quiz_questions_order_positive CHECK ((order_index > 0))
);


--
-- TOC entry 251 (class 1259 OID 17299)
-- Name: quiz_questions_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.quiz_questions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 5699 (class 0 OID 0)
-- Dependencies: 251
-- Name: quiz_questions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.quiz_questions_id_seq OWNED BY public.quiz_questions.id;


--
-- TOC entry 250 (class 1259 OID 17270)
-- Name: quizzes; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.quizzes (
    id bigint NOT NULL,
    lesson_id bigint NOT NULL,
    title character varying(255) NOT NULL,
    description text,
    created_by_teacher_id bigint NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    is_deleted boolean DEFAULT false NOT NULL,
    CONSTRAINT chk_quizzes_title_not_blank CHECK ((length(TRIM(BOTH FROM title)) > 0))
);


--
-- TOC entry 249 (class 1259 OID 17269)
-- Name: quizzes_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.quizzes_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 5700 (class 0 OID 0)
-- Dependencies: 249
-- Name: quizzes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.quizzes_id_seq OWNED BY public.quizzes.id;


--
-- TOC entry 230 (class 1259 OID 17010)
-- Name: refresh_tokens; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.refresh_tokens (
    id bigint NOT NULL,
    user_id bigint NOT NULL,
    token_hash character varying(255) NOT NULL,
    expires_at timestamp with time zone NOT NULL,
    revoked_at timestamp with time zone,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    last_used_at timestamp with time zone
);


--
-- TOC entry 229 (class 1259 OID 17009)
-- Name: refresh_tokens_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.refresh_tokens_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 5701 (class 0 OID 0)
-- Dependencies: 229
-- Name: refresh_tokens_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.refresh_tokens_id_seq OWNED BY public.refresh_tokens.id;


--
-- TOC entry 226 (class 1259 OID 16972)
-- Name: role_permissions; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.role_permissions (
    role_id bigint NOT NULL,
    permission_id bigint NOT NULL
);


--
-- TOC entry 222 (class 1259 OID 16932)
-- Name: roles; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.roles (
    id bigint NOT NULL,
    name character varying(100) NOT NULL,
    CONSTRAINT chk_roles_name_not_blank CHECK ((length(TRIM(BOTH FROM name)) > 0))
);


--
-- TOC entry 221 (class 1259 OID 16931)
-- Name: roles_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.roles_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 5702 (class 0 OID 0)
-- Dependencies: 221
-- Name: roles_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.roles_id_seq OWNED BY public.roles.id;


--
-- TOC entry 240 (class 1259 OID 17125)
-- Name: teacher_course_assignments; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.teacher_course_assignments (
    id bigint NOT NULL,
    teacher_id bigint NOT NULL,
    course_id bigint NOT NULL,
    assigned_by_admin_id bigint NOT NULL,
    assigned_at timestamp with time zone DEFAULT now() NOT NULL
);


--
-- TOC entry 239 (class 1259 OID 17124)
-- Name: teacher_course_assignments_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.teacher_course_assignments_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 5703 (class 0 OID 0)
-- Dependencies: 239
-- Name: teacher_course_assignments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.teacher_course_assignments_id_seq OWNED BY public.teacher_course_assignments.id;


--
-- TOC entry 232 (class 1259 OID 17030)
-- Name: teachers; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.teachers (
    id bigint NOT NULL,
    user_id bigint NOT NULL,
    status public.teacher_status DEFAULT 'ACTIVE'::public.teacher_status NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    full_name character varying(255) NOT NULL,
    headline character varying(255),
    bio text
);


--
-- TOC entry 231 (class 1259 OID 17029)
-- Name: teachers_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.teachers_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 5704 (class 0 OID 0)
-- Dependencies: 231
-- Name: teachers_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.teachers_id_seq OWNED BY public.teachers.id;


--
-- TOC entry 225 (class 1259 OID 16955)
-- Name: user_roles; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.user_roles (
    user_id bigint NOT NULL,
    role_id bigint NOT NULL
);


--
-- TOC entry 220 (class 1259 OID 16907)
-- Name: users; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.users (
    id bigint NOT NULL,
    username character varying(100) NOT NULL,
    email character varying(255) NOT NULL,
    password_hash character varying(255) NOT NULL,
    display_name character varying(255),
    phone_number character varying(30),
    status public.user_status DEFAULT 'ACTIVE'::public.user_status NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    CONSTRAINT chk_users_email_not_blank CHECK ((length(TRIM(BOTH FROM email)) > 0)),
    CONSTRAINT chk_users_username_not_blank CHECK ((length(TRIM(BOTH FROM username)) > 0))
);


--
-- TOC entry 219 (class 1259 OID 16906)
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 5705 (class 0 OID 0)
-- Dependencies: 219
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- TOC entry 5155 (class 2604 OID 17788)
-- Name: categories id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.categories ALTER COLUMN id SET DEFAULT nextval('public.categories_id_seq'::regclass);


--
-- TOC entry 5089 (class 2604 OID 17077)
-- Name: chapters id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.chapters ALTER COLUMN id SET DEFAULT nextval('public.chapters_id_seq'::regclass);


--
-- TOC entry 5109 (class 2604 OID 17246)
-- Name: completed_lessons_count id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.completed_lessons_count ALTER COLUMN id SET DEFAULT nextval('public.completed_lessons_count_id_seq'::regclass);


--
-- TOC entry 5153 (class 2604 OID 17699)
-- Name: contest_participants id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.contest_participants ALTER COLUMN id SET DEFAULT nextval('public.contest_participants_id_seq'::regclass);


--
-- TOC entry 5151 (class 2604 OID 17670)
-- Name: contest_problems id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.contest_problems ALTER COLUMN id SET DEFAULT nextval('public.contest_problems_id_seq'::regclass);


--
-- TOC entry 5133 (class 2604 OID 17470)
-- Name: contests id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.contests ALTER COLUMN id SET DEFAULT nextval('public.contests_id_seq'::regclass);


--
-- TOC entry 5148 (class 2604 OID 17640)
-- Name: course_reviews id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.course_reviews ALTER COLUMN id SET DEFAULT nextval('public.course_reviews_id_seq'::regclass);


--
-- TOC entry 5076 (class 2604 OID 17055)
-- Name: courses id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.courses ALTER COLUMN id SET DEFAULT nextval('public.courses_id_seq'::regclass);


--
-- TOC entry 5104 (class 2604 OID 17185)
-- Name: enrollments id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.enrollments ALTER COLUMN id SET DEFAULT nextval('public.enrollments_id_seq'::regclass);


--
-- TOC entry 5139 (class 2604 OID 17538)
-- Name: file_assignments id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.file_assignments ALTER COLUMN id SET DEFAULT nextval('public.file_assignments_id_seq'::regclass);


--
-- TOC entry 5142 (class 2604 OID 17566)
-- Name: file_submissions id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.file_submissions ALTER COLUMN id SET DEFAULT nextval('public.file_submissions_id_seq'::regclass);


--
-- TOC entry 5068 (class 2604 OID 16993)
-- Name: invalidated_tokens id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.invalidated_tokens ALTER COLUMN id SET DEFAULT nextval('public.invalidated_tokens_id_seq'::regclass);


--
-- TOC entry 5145 (class 2604 OID 17606)
-- Name: lesson_comments id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.lesson_comments ALTER COLUMN id SET DEFAULT nextval('public.lesson_comments_id_seq'::regclass);


--
-- TOC entry 5107 (class 2604 OID 17216)
-- Name: lesson_progress id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.lesson_progress ALTER COLUMN id SET DEFAULT nextval('public.lesson_progress_id_seq'::regclass);


--
-- TOC entry 5092 (class 2604 OID 17097)
-- Name: lessons id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.lessons ALTER COLUMN id SET DEFAULT nextval('public.lessons_id_seq'::regclass);


--
-- TOC entry 5123 (class 2604 OID 17374)
-- Name: online_judge_problems id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.online_judge_problems ALTER COLUMN id SET DEFAULT nextval('public.online_judge_problems_id_seq'::regclass);


--
-- TOC entry 5159 (class 2604 OID 17931)
-- Name: online_judge_submission_details id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.online_judge_submission_details ALTER COLUMN id SET DEFAULT nextval('public.online_judge_submission_details_id_seq'::regclass);


--
-- TOC entry 5137 (class 2604 OID 17497)
-- Name: online_judge_submissions id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.online_judge_submissions ALTER COLUMN id SET DEFAULT nextval('public.online_judge_submissions_id_seq'::regclass);


--
-- TOC entry 5102 (class 2604 OID 17158)
-- Name: payments id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.payments ALTER COLUMN id SET DEFAULT nextval('public.payments_id_seq'::regclass);


--
-- TOC entry 5067 (class 2604 OID 16947)
-- Name: permissions id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.permissions ALTER COLUMN id SET DEFAULT nextval('public.permissions_id_seq'::regclass);


--
-- TOC entry 5130 (class 2604 OID 17424)
-- Name: problem_tag_mappings id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.problem_tag_mappings ALTER COLUMN id SET DEFAULT nextval('public.problem_tag_mappings_id_seq'::regclass);


--
-- TOC entry 5127 (class 2604 OID 17406)
-- Name: problem_tags id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.problem_tags ALTER COLUMN id SET DEFAULT nextval('public.problem_tags_id_seq'::regclass);


--
-- TOC entry 5131 (class 2604 OID 17446)
-- Name: problem_testcases id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.problem_testcases ALTER COLUMN id SET DEFAULT nextval('public.problem_testcases_id_seq'::regclass);


--
-- TOC entry 5158 (class 2604 OID 17874)
-- Name: quiz_attempt_answers id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.quiz_attempt_answers ALTER COLUMN id SET DEFAULT nextval('public.quiz_attempt_answers_id_seq'::regclass);


--
-- TOC entry 5119 (class 2604 OID 17346)
-- Name: quiz_attempts id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.quiz_attempts ALTER COLUMN id SET DEFAULT nextval('public.quiz_attempts_id_seq'::regclass);


--
-- TOC entry 5117 (class 2604 OID 17325)
-- Name: quiz_options id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.quiz_options ALTER COLUMN id SET DEFAULT nextval('public.quiz_options_id_seq'::regclass);


--
-- TOC entry 5116 (class 2604 OID 17303)
-- Name: quiz_questions id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.quiz_questions ALTER COLUMN id SET DEFAULT nextval('public.quiz_questions_id_seq'::regclass);


--
-- TOC entry 5112 (class 2604 OID 17273)
-- Name: quizzes id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.quizzes ALTER COLUMN id SET DEFAULT nextval('public.quizzes_id_seq'::regclass);


--
-- TOC entry 5070 (class 2604 OID 17013)
-- Name: refresh_tokens id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.refresh_tokens ALTER COLUMN id SET DEFAULT nextval('public.refresh_tokens_id_seq'::regclass);


--
-- TOC entry 5066 (class 2604 OID 16935)
-- Name: roles id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.roles ALTER COLUMN id SET DEFAULT nextval('public.roles_id_seq'::regclass);


--
-- TOC entry 5100 (class 2604 OID 17128)
-- Name: teacher_course_assignments id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.teacher_course_assignments ALTER COLUMN id SET DEFAULT nextval('public.teacher_course_assignments_id_seq'::regclass);


--
-- TOC entry 5072 (class 2604 OID 17033)
-- Name: teachers id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.teachers ALTER COLUMN id SET DEFAULT nextval('public.teachers_id_seq'::regclass);


--
-- TOC entry 5062 (class 2604 OID 16910)
-- Name: users id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- TOC entry 5362 (class 2606 OID 17801)
-- Name: categories categories_name_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.categories
    ADD CONSTRAINT categories_name_key UNIQUE (name);


--
-- TOC entry 5364 (class 2606 OID 17799)
-- Name: categories categories_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.categories
    ADD CONSTRAINT categories_pkey PRIMARY KEY (id);


--
-- TOC entry 5366 (class 2606 OID 17803)
-- Name: categories categories_slug_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.categories
    ADD CONSTRAINT categories_slug_key UNIQUE (slug);


--
-- TOC entry 5245 (class 2606 OID 17085)
-- Name: chapters chapters_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.chapters
    ADD CONSTRAINT chapters_pkey PRIMARY KEY (id);


--
-- TOC entry 5279 (class 2606 OID 17256)
-- Name: completed_lessons_count completed_lessons_count_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.completed_lessons_count
    ADD CONSTRAINT completed_lessons_count_pkey PRIMARY KEY (id);


--
-- TOC entry 5357 (class 2606 OID 17706)
-- Name: contest_participants contest_participants_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.contest_participants
    ADD CONSTRAINT contest_participants_pkey PRIMARY KEY (id);


--
-- TOC entry 5350 (class 2606 OID 17680)
-- Name: contest_problems contest_problems_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.contest_problems
    ADD CONSTRAINT contest_problems_pkey PRIMARY KEY (id);


--
-- TOC entry 5317 (class 2606 OID 17487)
-- Name: contests contests_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.contests
    ADD CONSTRAINT contests_pkey PRIMARY KEY (id);


--
-- TOC entry 5368 (class 2606 OID 17810)
-- Name: course_category_mappings course_category_mappings_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.course_category_mappings
    ADD CONSTRAINT course_category_mappings_pkey PRIMARY KEY (course_id, category_id);


--
-- TOC entry 5345 (class 2606 OID 17653)
-- Name: course_reviews course_reviews_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.course_reviews
    ADD CONSTRAINT course_reviews_pkey PRIMARY KEY (id);


--
-- TOC entry 5240 (class 2606 OID 17072)
-- Name: courses courses_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.courses
    ADD CONSTRAINT courses_pkey PRIMARY KEY (id);


--
-- TOC entry 5268 (class 2606 OID 17194)
-- Name: enrollments enrollments_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.enrollments
    ADD CONSTRAINT enrollments_pkey PRIMARY KEY (id);


--
-- TOC entry 5329 (class 2606 OID 17551)
-- Name: file_assignments file_assignments_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.file_assignments
    ADD CONSTRAINT file_assignments_pkey PRIMARY KEY (id);


--
-- TOC entry 5333 (class 2606 OID 17584)
-- Name: file_submissions file_submissions_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.file_submissions
    ADD CONSTRAINT file_submissions_pkey PRIMARY KEY (id);


--
-- TOC entry 5226 (class 2606 OID 17001)
-- Name: invalidated_tokens invalidated_tokens_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.invalidated_tokens
    ADD CONSTRAINT invalidated_tokens_pkey PRIMARY KEY (id);


--
-- TOC entry 5228 (class 2606 OID 17003)
-- Name: invalidated_tokens invalidated_tokens_token_jti_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.invalidated_tokens
    ADD CONSTRAINT invalidated_tokens_token_jti_key UNIQUE (token_jti);


--
-- TOC entry 5343 (class 2606 OID 17620)
-- Name: lesson_comments lesson_comments_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.lesson_comments
    ADD CONSTRAINT lesson_comments_pkey PRIMARY KEY (id);


--
-- TOC entry 5275 (class 2606 OID 17224)
-- Name: lesson_progress lesson_progress_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.lesson_progress
    ADD CONSTRAINT lesson_progress_pkey PRIMARY KEY (id);


--
-- TOC entry 5251 (class 2606 OID 17116)
-- Name: lessons lessons_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.lessons
    ADD CONSTRAINT lessons_pkey PRIMARY KEY (id);


--
-- TOC entry 5301 (class 2606 OID 17391)
-- Name: online_judge_problems online_judge_problems_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.online_judge_problems
    ADD CONSTRAINT online_judge_problems_pkey PRIMARY KEY (id);


--
-- TOC entry 5376 (class 2606 OID 17941)
-- Name: online_judge_submission_details online_judge_submission_details_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.online_judge_submission_details
    ADD CONSTRAINT online_judge_submission_details_pkey PRIMARY KEY (id);


--
-- TOC entry 5327 (class 2606 OID 17513)
-- Name: online_judge_submissions online_judge_submissions_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.online_judge_submissions
    ADD CONSTRAINT online_judge_submissions_pkey PRIMARY KEY (id);


--
-- TOC entry 5264 (class 2606 OID 17168)
-- Name: payments payments_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.payments
    ADD CONSTRAINT payments_pkey PRIMARY KEY (id);


--
-- TOC entry 5266 (class 2606 OID 17170)
-- Name: payments payments_transaction_code_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.payments
    ADD CONSTRAINT payments_transaction_code_key UNIQUE (transaction_code);


--
-- TOC entry 5217 (class 2606 OID 16954)
-- Name: permissions permissions_name_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.permissions
    ADD CONSTRAINT permissions_name_key UNIQUE (name);


--
-- TOC entry 5219 (class 2606 OID 16952)
-- Name: permissions permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.permissions
    ADD CONSTRAINT permissions_pkey PRIMARY KEY (id);


--
-- TOC entry 5308 (class 2606 OID 17429)
-- Name: problem_tag_mappings problem_tag_mappings_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.problem_tag_mappings
    ADD CONSTRAINT problem_tag_mappings_pkey PRIMARY KEY (id);


--
-- TOC entry 5303 (class 2606 OID 17417)
-- Name: problem_tags problem_tags_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.problem_tags
    ADD CONSTRAINT problem_tags_pkey PRIMARY KEY (id);


--
-- TOC entry 5305 (class 2606 OID 17419)
-- Name: problem_tags problem_tags_slug_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.problem_tags
    ADD CONSTRAINT problem_tags_slug_key UNIQUE (slug);


--
-- TOC entry 5313 (class 2606 OID 17458)
-- Name: problem_testcases problem_testcases_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.problem_testcases
    ADD CONSTRAINT problem_testcases_pkey PRIMARY KEY (id);


--
-- TOC entry 5371 (class 2606 OID 17879)
-- Name: quiz_attempt_answers quiz_attempt_answers_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.quiz_attempt_answers
    ADD CONSTRAINT quiz_attempt_answers_pkey PRIMARY KEY (id);


--
-- TOC entry 5296 (class 2606 OID 17359)
-- Name: quiz_attempts quiz_attempts_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.quiz_attempts
    ADD CONSTRAINT quiz_attempts_pkey PRIMARY KEY (id);


--
-- TOC entry 5292 (class 2606 OID 17336)
-- Name: quiz_options quiz_options_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.quiz_options
    ADD CONSTRAINT quiz_options_pkey PRIMARY KEY (id);


--
-- TOC entry 5287 (class 2606 OID 17313)
-- Name: quiz_questions quiz_questions_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.quiz_questions
    ADD CONSTRAINT quiz_questions_pkey PRIMARY KEY (id);


--
-- TOC entry 5283 (class 2606 OID 17286)
-- Name: quizzes quizzes_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.quizzes
    ADD CONSTRAINT quizzes_pkey PRIMARY KEY (id);


--
-- TOC entry 5232 (class 2606 OID 17021)
-- Name: refresh_tokens refresh_tokens_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.refresh_tokens
    ADD CONSTRAINT refresh_tokens_pkey PRIMARY KEY (id);


--
-- TOC entry 5234 (class 2606 OID 17023)
-- Name: refresh_tokens refresh_tokens_token_hash_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.refresh_tokens
    ADD CONSTRAINT refresh_tokens_token_hash_key UNIQUE (token_hash);


--
-- TOC entry 5223 (class 2606 OID 16978)
-- Name: role_permissions role_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.role_permissions
    ADD CONSTRAINT role_permissions_pkey PRIMARY KEY (role_id, permission_id);


--
-- TOC entry 5213 (class 2606 OID 16942)
-- Name: roles roles_name_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.roles
    ADD CONSTRAINT roles_name_key UNIQUE (name);


--
-- TOC entry 5215 (class 2606 OID 16940)
-- Name: roles roles_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.roles
    ADD CONSTRAINT roles_pkey PRIMARY KEY (id);


--
-- TOC entry 5257 (class 2606 OID 17136)
-- Name: teacher_course_assignments teacher_course_assignments_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.teacher_course_assignments
    ADD CONSTRAINT teacher_course_assignments_pkey PRIMARY KEY (id);


--
-- TOC entry 5236 (class 2606 OID 17043)
-- Name: teachers teachers_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.teachers
    ADD CONSTRAINT teachers_pkey PRIMARY KEY (id);


--
-- TOC entry 5238 (class 2606 OID 17045)
-- Name: teachers teachers_user_id_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.teachers
    ADD CONSTRAINT teachers_user_id_key UNIQUE (user_id);


--
-- TOC entry 5373 (class 2606 OID 17881)
-- Name: quiz_attempt_answers unique_attempt_question; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.quiz_attempt_answers
    ADD CONSTRAINT unique_attempt_question UNIQUE (attempt_id, question_id);


--
-- TOC entry 5248 (class 2606 OID 17087)
-- Name: chapters uq_chapters_course_order; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.chapters
    ADD CONSTRAINT uq_chapters_course_order UNIQUE (course_id, order_index);


--
-- TOC entry 5281 (class 2606 OID 17258)
-- Name: completed_lessons_count uq_completed_lessons_count_user_course; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.completed_lessons_count
    ADD CONSTRAINT uq_completed_lessons_count_user_course UNIQUE (user_id, course_id);


--
-- TOC entry 5360 (class 2606 OID 17708)
-- Name: contest_participants uq_contest_participants_contest_user; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.contest_participants
    ADD CONSTRAINT uq_contest_participants_contest_user UNIQUE (contest_id, user_id);


--
-- TOC entry 5353 (class 2606 OID 17684)
-- Name: contest_problems uq_contest_problems_contest_order; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.contest_problems
    ADD CONSTRAINT uq_contest_problems_contest_order UNIQUE (contest_id, order_index);


--
-- TOC entry 5355 (class 2606 OID 17682)
-- Name: contest_problems uq_contest_problems_contest_problem; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.contest_problems
    ADD CONSTRAINT uq_contest_problems_contest_problem UNIQUE (contest_id, problem_id);


--
-- TOC entry 5348 (class 2606 OID 17655)
-- Name: course_reviews uq_course_reviews_course_user; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.course_reviews
    ADD CONSTRAINT uq_course_reviews_course_user UNIQUE (course_id, user_id);


--
-- TOC entry 5271 (class 2606 OID 17196)
-- Name: enrollments uq_enrollments_user_course; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.enrollments
    ADD CONSTRAINT uq_enrollments_user_course UNIQUE (user_id, course_id);


--
-- TOC entry 5338 (class 2606 OID 17586)
-- Name: file_submissions uq_file_submissions_assignment_user_attempt; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.file_submissions
    ADD CONSTRAINT uq_file_submissions_assignment_user_attempt UNIQUE (file_assignment_id, user_id, attempt_no);


--
-- TOC entry 5277 (class 2606 OID 17226)
-- Name: lesson_progress uq_lesson_progress_user_lesson; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.lesson_progress
    ADD CONSTRAINT uq_lesson_progress_user_lesson UNIQUE (user_id, lesson_id);


--
-- TOC entry 5253 (class 2606 OID 17118)
-- Name: lessons uq_lessons_chapter_order; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.lessons
    ADD CONSTRAINT uq_lessons_chapter_order UNIQUE (chapter_id, order_index);


--
-- TOC entry 5310 (class 2606 OID 17431)
-- Name: problem_tag_mappings uq_problem_tag_mappings_problem_tag; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.problem_tag_mappings
    ADD CONSTRAINT uq_problem_tag_mappings_problem_tag UNIQUE (problem_id, tag_id);


--
-- TOC entry 5315 (class 2606 OID 17460)
-- Name: problem_testcases uq_problem_testcases_problem_order; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.problem_testcases
    ADD CONSTRAINT uq_problem_testcases_problem_order UNIQUE (problem_id, order_index);


--
-- TOC entry 5289 (class 2606 OID 17902)
-- Name: quiz_questions uq_quiz_questions_quiz_order; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.quiz_questions
    ADD CONSTRAINT uq_quiz_questions_quiz_order UNIQUE (quiz_id, order_index) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 5259 (class 2606 OID 17138)
-- Name: teacher_course_assignments uq_teacher_course_assignments_teacher_course; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.teacher_course_assignments
    ADD CONSTRAINT uq_teacher_course_assignments_teacher_course UNIQUE (teacher_id, course_id);


--
-- TOC entry 5221 (class 2606 OID 16961)
-- Name: user_roles user_roles_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_roles
    ADD CONSTRAINT user_roles_pkey PRIMARY KEY (user_id, role_id);


--
-- TOC entry 5207 (class 2606 OID 16930)
-- Name: users users_email_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key UNIQUE (email);


--
-- TOC entry 5209 (class 2606 OID 16926)
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- TOC entry 5211 (class 2606 OID 16928)
-- Name: users users_username_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_username_key UNIQUE (username);


--
-- TOC entry 5246 (class 1259 OID 17724)
-- Name: idx_chapters_course_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_chapters_course_id ON public.chapters USING btree (course_id);


--
-- TOC entry 5358 (class 1259 OID 17761)
-- Name: idx_contest_participants_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_contest_participants_user_id ON public.contest_participants USING btree (user_id);


--
-- TOC entry 5351 (class 1259 OID 17760)
-- Name: idx_contest_problems_problem_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_contest_problems_problem_id ON public.contest_problems USING btree (problem_id);


--
-- TOC entry 5318 (class 1259 OID 17759)
-- Name: idx_contests_created_by_teacher_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_contests_created_by_teacher_id ON public.contests USING btree (created_by_teacher_id);


--
-- TOC entry 5319 (class 1259 OID 17758)
-- Name: idx_contests_status_time; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_contests_status_time ON public.contests USING btree (status, start_time, end_time);


--
-- TOC entry 5369 (class 1259 OID 17821)
-- Name: idx_course_category_mapping_category_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_course_category_mapping_category_id ON public.course_category_mappings USING btree (category_id);


--
-- TOC entry 5346 (class 1259 OID 17757)
-- Name: idx_course_reviews_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_course_reviews_user_id ON public.course_reviews USING btree (user_id);


--
-- TOC entry 5241 (class 1259 OID 17828)
-- Name: idx_courses_average_rating; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_courses_average_rating ON public.courses USING btree (average_rating DESC);


--
-- TOC entry 5242 (class 1259 OID 17723)
-- Name: idx_courses_status; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_courses_status ON public.courses USING btree (status);


--
-- TOC entry 5243 (class 1259 OID 17783)
-- Name: idx_courses_total_enrolled; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_courses_total_enrolled ON public.courses USING btree (total_enrolled DESC);


--
-- TOC entry 5269 (class 1259 OID 17731)
-- Name: idx_enrollments_course_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_enrollments_course_id ON public.enrollments USING btree (course_id);


--
-- TOC entry 5330 (class 1259 OID 17750)
-- Name: idx_file_assignments_created_by_teacher_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_file_assignments_created_by_teacher_id ON public.file_assignments USING btree (created_by_teacher_id);


--
-- TOC entry 5331 (class 1259 OID 17749)
-- Name: idx_file_assignments_lesson_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_file_assignments_lesson_id ON public.file_assignments USING btree (lesson_id);


--
-- TOC entry 5334 (class 1259 OID 17753)
-- Name: idx_file_submissions_graded_by_teacher_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_file_submissions_graded_by_teacher_id ON public.file_submissions USING btree (graded_by_teacher_id);


--
-- TOC entry 5335 (class 1259 OID 17752)
-- Name: idx_file_submissions_status; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_file_submissions_status ON public.file_submissions USING btree (status);


--
-- TOC entry 5336 (class 1259 OID 17751)
-- Name: idx_file_submissions_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_file_submissions_user_id ON public.file_submissions USING btree (user_id);


--
-- TOC entry 5224 (class 1259 OID 17720)
-- Name: idx_invalidated_tokens_expiry_time; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_invalidated_tokens_expiry_time ON public.invalidated_tokens USING btree (expiry_time);


--
-- TOC entry 5339 (class 1259 OID 17754)
-- Name: idx_lesson_comments_lesson_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_lesson_comments_lesson_id ON public.lesson_comments USING btree (lesson_id);


--
-- TOC entry 5340 (class 1259 OID 17756)
-- Name: idx_lesson_comments_lesson_parent; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_lesson_comments_lesson_parent ON public.lesson_comments USING btree (lesson_id, parent_comment_id);


--
-- TOC entry 5341 (class 1259 OID 17755)
-- Name: idx_lesson_comments_parent_comment_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_lesson_comments_parent_comment_id ON public.lesson_comments USING btree (parent_comment_id);


--
-- TOC entry 5272 (class 1259 OID 17733)
-- Name: idx_lesson_progress_course_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_lesson_progress_course_id ON public.lesson_progress USING btree (course_id);


--
-- TOC entry 5273 (class 1259 OID 17732)
-- Name: idx_lesson_progress_user_course; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_lesson_progress_user_course ON public.lesson_progress USING btree (user_id, course_id);


--
-- TOC entry 5249 (class 1259 OID 17725)
-- Name: idx_lessons_chapter_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_lessons_chapter_id ON public.lessons USING btree (chapter_id);


--
-- TOC entry 5297 (class 1259 OID 17739)
-- Name: idx_online_judge_problems_created_by_teacher_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_online_judge_problems_created_by_teacher_id ON public.online_judge_problems USING btree (created_by_teacher_id);


--
-- TOC entry 5298 (class 1259 OID 17738)
-- Name: idx_online_judge_problems_lesson_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_online_judge_problems_lesson_id ON public.online_judge_problems USING btree (lesson_id);


--
-- TOC entry 5299 (class 1259 OID 17740)
-- Name: idx_online_judge_problems_scope_difficulty; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_online_judge_problems_scope_difficulty ON public.online_judge_problems USING btree (problem_scope, difficulty);


--
-- TOC entry 5320 (class 1259 OID 17743)
-- Name: idx_online_judge_submissions_contest_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_online_judge_submissions_contest_id ON public.online_judge_submissions USING btree (contest_id);


--
-- TOC entry 5321 (class 1259 OID 17744)
-- Name: idx_online_judge_submissions_contest_user_problem; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_online_judge_submissions_contest_user_problem ON public.online_judge_submissions USING btree (contest_id, user_id, problem_id);


--
-- TOC entry 5322 (class 1259 OID 17745)
-- Name: idx_online_judge_submissions_lesson_user_problem; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_online_judge_submissions_lesson_user_problem ON public.online_judge_submissions USING btree (lesson_id, user_id, problem_id);


--
-- TOC entry 5323 (class 1259 OID 17747)
-- Name: idx_online_judge_submissions_problem_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_online_judge_submissions_problem_id ON public.online_judge_submissions USING btree (problem_id);


--
-- TOC entry 5324 (class 1259 OID 17748)
-- Name: idx_online_judge_submissions_submitted_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_online_judge_submissions_submitted_at ON public.online_judge_submissions USING btree (submitted_at);


--
-- TOC entry 5325 (class 1259 OID 17746)
-- Name: idx_online_judge_submissions_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_online_judge_submissions_user_id ON public.online_judge_submissions USING btree (user_id);


--
-- TOC entry 5260 (class 1259 OID 17729)
-- Name: idx_payments_course_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_payments_course_id ON public.payments USING btree (course_id);


--
-- TOC entry 5261 (class 1259 OID 17730)
-- Name: idx_payments_payment_status; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_payments_payment_status ON public.payments USING btree (payment_status);


--
-- TOC entry 5262 (class 1259 OID 17728)
-- Name: idx_payments_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_payments_user_id ON public.payments USING btree (user_id);


--
-- TOC entry 5306 (class 1259 OID 17741)
-- Name: idx_problem_tag_mappings_tag_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_problem_tag_mappings_tag_id ON public.problem_tag_mappings USING btree (tag_id);


--
-- TOC entry 5311 (class 1259 OID 17742)
-- Name: idx_problem_testcases_problem_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_problem_testcases_problem_id ON public.problem_testcases USING btree (problem_id);


--
-- TOC entry 5293 (class 1259 OID 17737)
-- Name: idx_quiz_attempts_quiz_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_quiz_attempts_quiz_id ON public.quiz_attempts USING btree (quiz_id);


--
-- TOC entry 5294 (class 1259 OID 17736)
-- Name: idx_quiz_attempts_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_quiz_attempts_user_id ON public.quiz_attempts USING btree (user_id);


--
-- TOC entry 5290 (class 1259 OID 17735)
-- Name: idx_quiz_options_question_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_quiz_options_question_id ON public.quiz_options USING btree (question_id);


--
-- TOC entry 5285 (class 1259 OID 17734)
-- Name: idx_quiz_questions_quiz_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_quiz_questions_quiz_id ON public.quiz_questions USING btree (quiz_id);


--
-- TOC entry 5229 (class 1259 OID 17722)
-- Name: idx_refresh_tokens_expires_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_refresh_tokens_expires_at ON public.refresh_tokens USING btree (expires_at);


--
-- TOC entry 5230 (class 1259 OID 17721)
-- Name: idx_refresh_tokens_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_refresh_tokens_user_id ON public.refresh_tokens USING btree (user_id);


--
-- TOC entry 5374 (class 1259 OID 17953)
-- Name: idx_submission_details_submission_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_submission_details_submission_id ON public.online_judge_submission_details USING btree (submission_id);


--
-- TOC entry 5254 (class 1259 OID 17727)
-- Name: idx_teacher_course_assignments_assigned_by_admin_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_teacher_course_assignments_assigned_by_admin_id ON public.teacher_course_assignments USING btree (assigned_by_admin_id);


--
-- TOC entry 5255 (class 1259 OID 17726)
-- Name: idx_teacher_course_assignments_course_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_teacher_course_assignments_course_id ON public.teacher_course_assignments USING btree (course_id);


--
-- TOC entry 5284 (class 1259 OID 17906)
-- Name: uq_quizzes_lesson_active; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX uq_quizzes_lesson_active ON public.quizzes USING btree (lesson_id) WHERE (is_deleted = false);


--
-- TOC entry 5377 (class 1259 OID 17952)
-- Name: uq_submission_details_token; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX uq_submission_details_token ON public.online_judge_submission_details USING btree (token);


--
-- TOC entry 5450 (class 2620 OID 17822)
-- Name: categories trg_categories_set_updated_at; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER trg_categories_set_updated_at BEFORE UPDATE ON public.categories FOR EACH ROW EXECUTE FUNCTION public.set_updated_at();


--
-- TOC entry 5439 (class 2620 OID 17869)
-- Name: chapters trg_chapters_updated_at; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER trg_chapters_updated_at BEFORE UPDATE ON public.chapters FOR EACH ROW EXECUTE FUNCTION public.set_updated_at();


--
-- TOC entry 5441 (class 2620 OID 17766)
-- Name: completed_lessons_count trg_completed_lessons_count_set_updated_at; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER trg_completed_lessons_count_set_updated_at BEFORE UPDATE ON public.completed_lessons_count FOR EACH ROW EXECUTE FUNCTION public.set_updated_at();


--
-- TOC entry 5446 (class 2620 OID 17773)
-- Name: contests trg_contests_set_updated_at; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER trg_contests_set_updated_at BEFORE UPDATE ON public.contests FOR EACH ROW EXECUTE FUNCTION public.set_updated_at();


--
-- TOC entry 5449 (class 2620 OID 17772)
-- Name: course_reviews trg_course_reviews_set_updated_at; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER trg_course_reviews_set_updated_at BEFORE UPDATE ON public.course_reviews FOR EACH ROW EXECUTE FUNCTION public.set_updated_at();


--
-- TOC entry 5438 (class 2620 OID 17764)
-- Name: courses trg_courses_set_updated_at; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER trg_courses_set_updated_at BEFORE UPDATE ON public.courses FOR EACH ROW EXECUTE FUNCTION public.set_updated_at();


--
-- TOC entry 5447 (class 2620 OID 17770)
-- Name: file_assignments trg_file_assignments_set_updated_at; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER trg_file_assignments_set_updated_at BEFORE UPDATE ON public.file_assignments FOR EACH ROW EXECUTE FUNCTION public.set_updated_at();


--
-- TOC entry 5448 (class 2620 OID 17771)
-- Name: lesson_comments trg_lesson_comments_set_updated_at; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER trg_lesson_comments_set_updated_at BEFORE UPDATE ON public.lesson_comments FOR EACH ROW EXECUTE FUNCTION public.set_updated_at();


--
-- TOC entry 5440 (class 2620 OID 17765)
-- Name: lessons trg_lessons_set_updated_at; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER trg_lessons_set_updated_at BEFORE UPDATE ON public.lessons FOR EACH ROW EXECUTE FUNCTION public.set_updated_at();


--
-- TOC entry 5444 (class 2620 OID 17768)
-- Name: online_judge_problems trg_online_judge_problems_set_updated_at; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER trg_online_judge_problems_set_updated_at BEFORE UPDATE ON public.online_judge_problems FOR EACH ROW EXECUTE FUNCTION public.set_updated_at();


--
-- TOC entry 5445 (class 2620 OID 17769)
-- Name: problem_tags trg_problem_tags_set_updated_at; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER trg_problem_tags_set_updated_at BEFORE UPDATE ON public.problem_tags FOR EACH ROW EXECUTE FUNCTION public.set_updated_at();


--
-- TOC entry 5442 (class 2620 OID 17767)
-- Name: quizzes trg_quizzes_set_updated_at; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER trg_quizzes_set_updated_at BEFORE UPDATE ON public.quizzes FOR EACH ROW EXECUTE FUNCTION public.set_updated_at();


--
-- TOC entry 5437 (class 2620 OID 17763)
-- Name: teachers trg_teachers_set_updated_at; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER trg_teachers_set_updated_at BEFORE UPDATE ON public.teachers FOR EACH ROW EXECUTE FUNCTION public.set_updated_at();


--
-- TOC entry 5436 (class 2620 OID 17762)
-- Name: users trg_users_set_updated_at; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER trg_users_set_updated_at BEFORE UPDATE ON public.users FOR EACH ROW EXECUTE FUNCTION public.set_updated_at();


--
-- TOC entry 5443 (class 2620 OID 17900)
-- Name: quiz_attempts trigger_quiz_attempts_updated_at; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER trigger_quiz_attempts_updated_at BEFORE UPDATE ON public.quiz_attempts FOR EACH ROW EXECUTE FUNCTION public.set_updated_at();


--
-- TOC entry 5384 (class 2606 OID 17088)
-- Name: chapters fk_chapters_course; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.chapters
    ADD CONSTRAINT fk_chapters_course FOREIGN KEY (course_id) REFERENCES public.courses(id) ON DELETE CASCADE;


--
-- TOC entry 5397 (class 2606 OID 17264)
-- Name: completed_lessons_count fk_completed_lessons_count_course; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.completed_lessons_count
    ADD CONSTRAINT fk_completed_lessons_count_course FOREIGN KEY (course_id) REFERENCES public.courses(id) ON DELETE CASCADE;


--
-- TOC entry 5398 (class 2606 OID 17259)
-- Name: completed_lessons_count fk_completed_lessons_count_user; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.completed_lessons_count
    ADD CONSTRAINT fk_completed_lessons_count_user FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- TOC entry 5427 (class 2606 OID 17709)
-- Name: contest_participants fk_contest_participants_contest; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.contest_participants
    ADD CONSTRAINT fk_contest_participants_contest FOREIGN KEY (contest_id) REFERENCES public.contests(id) ON DELETE CASCADE;


--
-- TOC entry 5428 (class 2606 OID 17714)
-- Name: contest_participants fk_contest_participants_user; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.contest_participants
    ADD CONSTRAINT fk_contest_participants_user FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- TOC entry 5425 (class 2606 OID 17685)
-- Name: contest_problems fk_contest_problems_contest; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.contest_problems
    ADD CONSTRAINT fk_contest_problems_contest FOREIGN KEY (contest_id) REFERENCES public.contests(id) ON DELETE CASCADE;


--
-- TOC entry 5426 (class 2606 OID 17690)
-- Name: contest_problems fk_contest_problems_problem; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.contest_problems
    ADD CONSTRAINT fk_contest_problems_problem FOREIGN KEY (problem_id) REFERENCES public.online_judge_problems(id) ON DELETE CASCADE;


--
-- TOC entry 5410 (class 2606 OID 17488)
-- Name: contests fk_contests_created_by_teacher; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.contests
    ADD CONSTRAINT fk_contests_created_by_teacher FOREIGN KEY (created_by_teacher_id) REFERENCES public.teachers(id);


--
-- TOC entry 5429 (class 2606 OID 17816)
-- Name: course_category_mappings fk_course_category_category; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.course_category_mappings
    ADD CONSTRAINT fk_course_category_category FOREIGN KEY (category_id) REFERENCES public.categories(id) ON DELETE CASCADE;


--
-- TOC entry 5430 (class 2606 OID 17811)
-- Name: course_category_mappings fk_course_category_course; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.course_category_mappings
    ADD CONSTRAINT fk_course_category_course FOREIGN KEY (course_id) REFERENCES public.courses(id) ON DELETE CASCADE;


--
-- TOC entry 5423 (class 2606 OID 17656)
-- Name: course_reviews fk_course_reviews_course; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.course_reviews
    ADD CONSTRAINT fk_course_reviews_course FOREIGN KEY (course_id) REFERENCES public.courses(id) ON DELETE CASCADE;


--
-- TOC entry 5424 (class 2606 OID 17661)
-- Name: course_reviews fk_course_reviews_user; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.course_reviews
    ADD CONSTRAINT fk_course_reviews_user FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- TOC entry 5391 (class 2606 OID 17202)
-- Name: enrollments fk_enrollments_course; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.enrollments
    ADD CONSTRAINT fk_enrollments_course FOREIGN KEY (course_id) REFERENCES public.courses(id) ON DELETE CASCADE;


--
-- TOC entry 5392 (class 2606 OID 17207)
-- Name: enrollments fk_enrollments_payment; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.enrollments
    ADD CONSTRAINT fk_enrollments_payment FOREIGN KEY (payment_id) REFERENCES public.payments(id);


--
-- TOC entry 5393 (class 2606 OID 17197)
-- Name: enrollments fk_enrollments_user; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.enrollments
    ADD CONSTRAINT fk_enrollments_user FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- TOC entry 5415 (class 2606 OID 17557)
-- Name: file_assignments fk_file_assignments_created_by_teacher; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.file_assignments
    ADD CONSTRAINT fk_file_assignments_created_by_teacher FOREIGN KEY (created_by_teacher_id) REFERENCES public.teachers(id);


--
-- TOC entry 5416 (class 2606 OID 17552)
-- Name: file_assignments fk_file_assignments_lesson; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.file_assignments
    ADD CONSTRAINT fk_file_assignments_lesson FOREIGN KEY (lesson_id) REFERENCES public.lessons(id) ON DELETE CASCADE;


--
-- TOC entry 5417 (class 2606 OID 17587)
-- Name: file_submissions fk_file_submissions_file_assignment; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.file_submissions
    ADD CONSTRAINT fk_file_submissions_file_assignment FOREIGN KEY (file_assignment_id) REFERENCES public.file_assignments(id) ON DELETE CASCADE;


--
-- TOC entry 5418 (class 2606 OID 17597)
-- Name: file_submissions fk_file_submissions_graded_by_teacher; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.file_submissions
    ADD CONSTRAINT fk_file_submissions_graded_by_teacher FOREIGN KEY (graded_by_teacher_id) REFERENCES public.teachers(id);


--
-- TOC entry 5419 (class 2606 OID 17592)
-- Name: file_submissions fk_file_submissions_user; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.file_submissions
    ADD CONSTRAINT fk_file_submissions_user FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- TOC entry 5420 (class 2606 OID 17621)
-- Name: lesson_comments fk_lesson_comments_lesson; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.lesson_comments
    ADD CONSTRAINT fk_lesson_comments_lesson FOREIGN KEY (lesson_id) REFERENCES public.lessons(id) ON DELETE CASCADE;


--
-- TOC entry 5421 (class 2606 OID 17631)
-- Name: lesson_comments fk_lesson_comments_parent; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.lesson_comments
    ADD CONSTRAINT fk_lesson_comments_parent FOREIGN KEY (parent_comment_id) REFERENCES public.lesson_comments(id) ON DELETE CASCADE;


--
-- TOC entry 5422 (class 2606 OID 17626)
-- Name: lesson_comments fk_lesson_comments_user; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.lesson_comments
    ADD CONSTRAINT fk_lesson_comments_user FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- TOC entry 5394 (class 2606 OID 17237)
-- Name: lesson_progress fk_lesson_progress_course; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.lesson_progress
    ADD CONSTRAINT fk_lesson_progress_course FOREIGN KEY (course_id) REFERENCES public.courses(id) ON DELETE CASCADE;


--
-- TOC entry 5395 (class 2606 OID 17232)
-- Name: lesson_progress fk_lesson_progress_lesson; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.lesson_progress
    ADD CONSTRAINT fk_lesson_progress_lesson FOREIGN KEY (lesson_id) REFERENCES public.lessons(id) ON DELETE CASCADE;


--
-- TOC entry 5396 (class 2606 OID 17227)
-- Name: lesson_progress fk_lesson_progress_user; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.lesson_progress
    ADD CONSTRAINT fk_lesson_progress_user FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- TOC entry 5385 (class 2606 OID 17119)
-- Name: lessons fk_lessons_chapter; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.lessons
    ADD CONSTRAINT fk_lessons_chapter FOREIGN KEY (chapter_id) REFERENCES public.chapters(id) ON DELETE CASCADE;


--
-- TOC entry 5405 (class 2606 OID 17397)
-- Name: online_judge_problems fk_online_judge_problems_created_by_teacher; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.online_judge_problems
    ADD CONSTRAINT fk_online_judge_problems_created_by_teacher FOREIGN KEY (created_by_teacher_id) REFERENCES public.teachers(id);


--
-- TOC entry 5406 (class 2606 OID 17392)
-- Name: online_judge_problems fk_online_judge_problems_lesson; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.online_judge_problems
    ADD CONSTRAINT fk_online_judge_problems_lesson FOREIGN KEY (lesson_id) REFERENCES public.lessons(id) ON DELETE SET NULL;


--
-- TOC entry 5411 (class 2606 OID 17529)
-- Name: online_judge_submissions fk_online_judge_submissions_contest; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.online_judge_submissions
    ADD CONSTRAINT fk_online_judge_submissions_contest FOREIGN KEY (contest_id) REFERENCES public.contests(id);


--
-- TOC entry 5412 (class 2606 OID 17524)
-- Name: online_judge_submissions fk_online_judge_submissions_lesson; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.online_judge_submissions
    ADD CONSTRAINT fk_online_judge_submissions_lesson FOREIGN KEY (lesson_id) REFERENCES public.lessons(id);


--
-- TOC entry 5413 (class 2606 OID 17519)
-- Name: online_judge_submissions fk_online_judge_submissions_problem; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.online_judge_submissions
    ADD CONSTRAINT fk_online_judge_submissions_problem FOREIGN KEY (problem_id) REFERENCES public.online_judge_problems(id);


--
-- TOC entry 5414 (class 2606 OID 17514)
-- Name: online_judge_submissions fk_online_judge_submissions_user; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.online_judge_submissions
    ADD CONSTRAINT fk_online_judge_submissions_user FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- TOC entry 5389 (class 2606 OID 17176)
-- Name: payments fk_payments_course; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.payments
    ADD CONSTRAINT fk_payments_course FOREIGN KEY (course_id) REFERENCES public.courses(id);


--
-- TOC entry 5390 (class 2606 OID 17171)
-- Name: payments fk_payments_user; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.payments
    ADD CONSTRAINT fk_payments_user FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- TOC entry 5407 (class 2606 OID 17432)
-- Name: problem_tag_mappings fk_problem_tag_mappings_problem; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.problem_tag_mappings
    ADD CONSTRAINT fk_problem_tag_mappings_problem FOREIGN KEY (problem_id) REFERENCES public.online_judge_problems(id) ON DELETE CASCADE;


--
-- TOC entry 5408 (class 2606 OID 17437)
-- Name: problem_tag_mappings fk_problem_tag_mappings_tag; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.problem_tag_mappings
    ADD CONSTRAINT fk_problem_tag_mappings_tag FOREIGN KEY (tag_id) REFERENCES public.problem_tags(id) ON DELETE CASCADE;


--
-- TOC entry 5409 (class 2606 OID 17461)
-- Name: problem_testcases fk_problem_testcases_problem; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.problem_testcases
    ADD CONSTRAINT fk_problem_testcases_problem FOREIGN KEY (problem_id) REFERENCES public.online_judge_problems(id) ON DELETE CASCADE;


--
-- TOC entry 5403 (class 2606 OID 17365)
-- Name: quiz_attempts fk_quiz_attempts_quiz; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.quiz_attempts
    ADD CONSTRAINT fk_quiz_attempts_quiz FOREIGN KEY (quiz_id) REFERENCES public.quizzes(id) ON DELETE CASCADE;


--
-- TOC entry 5404 (class 2606 OID 17360)
-- Name: quiz_attempts fk_quiz_attempts_user; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.quiz_attempts
    ADD CONSTRAINT fk_quiz_attempts_user FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- TOC entry 5402 (class 2606 OID 17337)
-- Name: quiz_options fk_quiz_options_question; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.quiz_options
    ADD CONSTRAINT fk_quiz_options_question FOREIGN KEY (question_id) REFERENCES public.quiz_questions(id) ON DELETE CASCADE;


--
-- TOC entry 5401 (class 2606 OID 17316)
-- Name: quiz_questions fk_quiz_questions_quiz; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.quiz_questions
    ADD CONSTRAINT fk_quiz_questions_quiz FOREIGN KEY (quiz_id) REFERENCES public.quizzes(id) ON DELETE CASCADE;


--
-- TOC entry 5399 (class 2606 OID 17294)
-- Name: quizzes fk_quizzes_created_by_teacher; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.quizzes
    ADD CONSTRAINT fk_quizzes_created_by_teacher FOREIGN KEY (created_by_teacher_id) REFERENCES public.teachers(id);


--
-- TOC entry 5400 (class 2606 OID 17289)
-- Name: quizzes fk_quizzes_lesson; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.quizzes
    ADD CONSTRAINT fk_quizzes_lesson FOREIGN KEY (lesson_id) REFERENCES public.lessons(id) ON DELETE CASCADE;


--
-- TOC entry 5382 (class 2606 OID 17024)
-- Name: refresh_tokens fk_refresh_tokens_user; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.refresh_tokens
    ADD CONSTRAINT fk_refresh_tokens_user FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- TOC entry 5380 (class 2606 OID 16984)
-- Name: role_permissions fk_role_permissions_permission; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.role_permissions
    ADD CONSTRAINT fk_role_permissions_permission FOREIGN KEY (permission_id) REFERENCES public.permissions(id) ON DELETE CASCADE;


--
-- TOC entry 5381 (class 2606 OID 16979)
-- Name: role_permissions fk_role_permissions_role; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.role_permissions
    ADD CONSTRAINT fk_role_permissions_role FOREIGN KEY (role_id) REFERENCES public.roles(id) ON DELETE CASCADE;


--
-- TOC entry 5434 (class 2606 OID 17942)
-- Name: online_judge_submission_details fk_sub_details_submission; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.online_judge_submission_details
    ADD CONSTRAINT fk_sub_details_submission FOREIGN KEY (submission_id) REFERENCES public.online_judge_submissions(id) ON DELETE CASCADE;


--
-- TOC entry 5435 (class 2606 OID 17947)
-- Name: online_judge_submission_details fk_sub_details_testcase; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.online_judge_submission_details
    ADD CONSTRAINT fk_sub_details_testcase FOREIGN KEY (testcase_id) REFERENCES public.problem_testcases(id) ON DELETE CASCADE;


--
-- TOC entry 5386 (class 2606 OID 17149)
-- Name: teacher_course_assignments fk_teacher_course_assignments_admin; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.teacher_course_assignments
    ADD CONSTRAINT fk_teacher_course_assignments_admin FOREIGN KEY (assigned_by_admin_id) REFERENCES public.users(id);


--
-- TOC entry 5387 (class 2606 OID 17144)
-- Name: teacher_course_assignments fk_teacher_course_assignments_course; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.teacher_course_assignments
    ADD CONSTRAINT fk_teacher_course_assignments_course FOREIGN KEY (course_id) REFERENCES public.courses(id) ON DELETE CASCADE;


--
-- TOC entry 5388 (class 2606 OID 17139)
-- Name: teacher_course_assignments fk_teacher_course_assignments_teacher; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.teacher_course_assignments
    ADD CONSTRAINT fk_teacher_course_assignments_teacher FOREIGN KEY (teacher_id) REFERENCES public.teachers(id) ON DELETE CASCADE;


--
-- TOC entry 5383 (class 2606 OID 17046)
-- Name: teachers fk_teachers_user; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.teachers
    ADD CONSTRAINT fk_teachers_user FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- TOC entry 5378 (class 2606 OID 16967)
-- Name: user_roles fk_user_roles_role; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_roles
    ADD CONSTRAINT fk_user_roles_role FOREIGN KEY (role_id) REFERENCES public.roles(id) ON DELETE CASCADE;


--
-- TOC entry 5379 (class 2606 OID 16962)
-- Name: user_roles fk_user_roles_user; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_roles
    ADD CONSTRAINT fk_user_roles_user FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- TOC entry 5431 (class 2606 OID 17882)
-- Name: quiz_attempt_answers quiz_attempt_answers_attempt_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.quiz_attempt_answers
    ADD CONSTRAINT quiz_attempt_answers_attempt_id_fkey FOREIGN KEY (attempt_id) REFERENCES public.quiz_attempts(id) ON DELETE CASCADE;


--
-- TOC entry 5432 (class 2606 OID 17887)
-- Name: quiz_attempt_answers quiz_attempt_answers_question_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.quiz_attempt_answers
    ADD CONSTRAINT quiz_attempt_answers_question_id_fkey FOREIGN KEY (question_id) REFERENCES public.quiz_questions(id);


--
-- TOC entry 5433 (class 2606 OID 17892)
-- Name: quiz_attempt_answers quiz_attempt_answers_selected_option_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.quiz_attempt_answers
    ADD CONSTRAINT quiz_attempt_answers_selected_option_id_fkey FOREIGN KEY (selected_option_id) REFERENCES public.quiz_options(id);


-- Completed on 2026-05-15 12:40:35

--
-- PostgreSQL database dump complete
--

\unrestrict ac0PMPqA2P5KfCeOysfnE2uWOSfNRbEG0hH7gIAW55cS2kpPrxP0l89UjVoHejg

