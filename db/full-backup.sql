--
-- PostgreSQL database dump
--

\restrict paUpqyExzSivdB5D6UweW6UNP3zAdKukn3rgqI4oSO9zONK8itVNzueQfEIRXp3

-- Dumped from database version 18.1
-- Dumped by pg_dump version 18.1

-- Started on 2026-05-15 12:35:09

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
-- TOC entry 5661 (class 0 OID 17785)
-- Dependencies: 282
-- Data for Name: categories; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.categories (id, name, slug, description, created_at, updated_at) VALUES (1, 'Java', 'java', 'Các khóa học về ngôn ngữ lập trình Java và hệ sinh thái Spring Boot', '2026-05-01 23:23:55.896875+07', '2026-05-01 23:24:28.858688+07');
INSERT INTO public.categories (id, name, slug, description, created_at, updated_at) VALUES (2, 'Backend Development', 'backend', 'Lập trình API, xử lý logic máy chủ, bảo mật và kiến trúc hệ thống', '2026-05-01 23:23:55.896875+07', '2026-05-01 23:24:28.858688+07');
INSERT INTO public.categories (id, name, slug, description, created_at, updated_at) VALUES (3, 'Frontend Development', 'frontend', 'Phát triển giao diện người dùng với các framework hiện đại như React', '2026-05-01 23:23:55.896875+07', '2026-05-01 23:24:28.858688+07');
INSERT INTO public.categories (id, name, slug, description, created_at, updated_at) VALUES (4, 'Fullstack Development', 'fullstack', 'Kỹ năng phát triển ứng dụng toàn diện từ Frontend đến Backend', '2026-05-01 23:23:55.896875+07', '2026-05-01 23:24:28.858688+07');
INSERT INTO public.categories (id, name, slug, description, created_at, updated_at) VALUES (5, 'Database & SQL', 'database', 'Thiết kế cơ sở dữ liệu quan hệ, viết câu lệnh SQL và tối ưu hóa PostgreSQL', '2026-05-01 23:23:55.896875+07', '2026-05-01 23:24:28.858688+07');
INSERT INTO public.categories (id, name, slug, description, created_at, updated_at) VALUES (6, 'Data Structures & Algorithms', 'dsa', 'Cấu trúc dữ liệu và giải thuật, luyện thi thuật toán Online Judge', '2026-05-01 23:23:55.896875+07', '2026-05-01 23:24:28.858688+07');
INSERT INTO public.categories (id, name, slug, description, created_at, updated_at) VALUES (7, 'DevOps & Deployment', 'devops', 'Triển khai dự án, đóng gói ứng dụng với Docker và quản trị hệ thống', '2026-05-01 23:23:55.896875+07', '2026-05-01 23:24:28.858688+07');


--
-- TOC entry 5615 (class 0 OID 17074)
-- Dependencies: 236
-- Data for Name: chapters; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.chapters (id, course_id, title, order_index, created_at, updated_at) VALUES (1, 1, 'Chương 1: Giới thiệu và Cài đặt môi trường', 1, '2026-05-03 22:26:05.65978+07', '2026-05-03 22:26:05.65978+07');
INSERT INTO public.chapters (id, course_id, title, order_index, created_at, updated_at) VALUES (2, 1, 'Chương 2: Xây dựng RESTful API Cơ bản', 2, '2026-05-03 22:26:05.65978+07', '2026-05-03 22:26:05.65978+07');
INSERT INTO public.chapters (id, course_id, title, order_index, created_at, updated_at) VALUES (3, 1, 'Chương 3: Làm việc với Database qua Spring Data JPA', 3, '2026-05-03 22:26:05.65978+07', '2026-05-03 22:26:05.65978+07');
INSERT INTO public.chapters (id, course_id, title, order_index, created_at, updated_at) VALUES (4, 2, 'Chương 1: Big O Notation và Phân tích độ phức tạp', 1, '2026-05-03 22:26:05.65978+07', '2026-05-03 22:26:05.65978+07');
INSERT INTO public.chapters (id, course_id, title, order_index, created_at, updated_at) VALUES (5, 2, 'Chương 2: Mảng (Arrays) và Chuỗi (Strings)', 2, '2026-05-03 22:26:05.65978+07', '2026-05-03 22:26:05.65978+07');
INSERT INTO public.chapters (id, course_id, title, order_index, created_at, updated_at) VALUES (6, 3, 'Chương 1: Setup Frontend với Vite và React', 1, '2026-05-03 22:26:05.65978+07', '2026-05-03 22:26:05.65978+07');
INSERT INTO public.chapters (id, course_id, title, order_index, created_at, updated_at) VALUES (7, 3, 'Chương 2: Tích hợp API và CORS', 2, '2026-05-03 22:26:05.65978+07', '2026-05-03 22:26:05.65978+07');
INSERT INTO public.chapters (id, course_id, title, order_index, created_at, updated_at) VALUES (8, 4, 'Chương 1: Truy vấn Dữ liệu Cơ bản', 1, '2026-05-03 22:26:05.65978+07', '2026-05-03 22:26:05.65978+07');
INSERT INTO public.chapters (id, course_id, title, order_index, created_at, updated_at) VALUES (9, 4, 'Chương 2: Các phép JOIN trong SQL', 2, '2026-05-03 22:26:05.65978+07', '2026-05-03 22:26:05.65978+07');
INSERT INTO public.chapters (id, course_id, title, order_index, created_at, updated_at) VALUES (10, 5, 'Chương 1: Cơ bản về Docker', 1, '2026-05-03 22:26:05.65978+07', '2026-05-03 22:26:05.65978+07');


--
-- TOC entry 5627 (class 0 OID 17243)
-- Dependencies: 248
-- Data for Name: completed_lessons_count; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.completed_lessons_count (id, user_id, course_id, completed_lessons_count, updated_at) VALUES (2, 2, 2, 0, '2026-05-10 14:45:38.396062+07');
INSERT INTO public.completed_lessons_count (id, user_id, course_id, completed_lessons_count, updated_at) VALUES (3, 2, 3, 0, '2026-05-10 14:45:38.396062+07');
INSERT INTO public.completed_lessons_count (id, user_id, course_id, completed_lessons_count, updated_at) VALUES (4, 5, 4, 0, '2026-05-10 14:45:38.396062+07');
INSERT INTO public.completed_lessons_count (id, user_id, course_id, completed_lessons_count, updated_at) VALUES (5, 5, 5, 0, '2026-05-10 14:45:38.396062+07');
INSERT INTO public.completed_lessons_count (id, user_id, course_id, completed_lessons_count, updated_at) VALUES (6, 5, 2, 0, '2026-05-10 14:45:38.396062+07');
INSERT INTO public.completed_lessons_count (id, user_id, course_id, completed_lessons_count, updated_at) VALUES (1, 2, 1, 2, '2026-05-11 15:41:38.838634+07');


--
-- TOC entry 5659 (class 0 OID 17696)
-- Dependencies: 280
-- Data for Name: contest_participants; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 5657 (class 0 OID 17667)
-- Dependencies: 278
-- Data for Name: contest_problems; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 5645 (class 0 OID 17467)
-- Dependencies: 266
-- Data for Name: contests; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 5662 (class 0 OID 17804)
-- Dependencies: 283
-- Data for Name: course_category_mappings; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.course_category_mappings (course_id, category_id) VALUES (1, 1);
INSERT INTO public.course_category_mappings (course_id, category_id) VALUES (1, 2);
INSERT INTO public.course_category_mappings (course_id, category_id) VALUES (2, 1);
INSERT INTO public.course_category_mappings (course_id, category_id) VALUES (2, 6);
INSERT INTO public.course_category_mappings (course_id, category_id) VALUES (3, 1);
INSERT INTO public.course_category_mappings (course_id, category_id) VALUES (3, 2);
INSERT INTO public.course_category_mappings (course_id, category_id) VALUES (3, 3);
INSERT INTO public.course_category_mappings (course_id, category_id) VALUES (3, 4);
INSERT INTO public.course_category_mappings (course_id, category_id) VALUES (4, 2);
INSERT INTO public.course_category_mappings (course_id, category_id) VALUES (4, 5);
INSERT INTO public.course_category_mappings (course_id, category_id) VALUES (5, 1);
INSERT INTO public.course_category_mappings (course_id, category_id) VALUES (5, 2);
INSERT INTO public.course_category_mappings (course_id, category_id) VALUES (5, 7);


--
-- TOC entry 5655 (class 0 OID 17637)
-- Dependencies: 276
-- Data for Name: course_reviews; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.course_reviews (id, course_id, user_id, content, rating, created_at, updated_at) VALUES (1, 1, 2, 'Khóa học Spring Boot rất thực tế, phần security và cấu trúc project giải thích rõ ràng. Phù hợp để làm project backend đưa vào CV.', 5, '2026-04-29 00:17:08.070255+07', '2026-04-29 00:17:08.070255+07');
INSERT INTO public.course_reviews (id, course_id, user_id, content, rating, created_at, updated_at) VALUES (2, 2, 2, 'Nội dung thuật toán được chia theo chủ đề dễ học, bài tập online judge giúp luyện tư duy tốt.', 4, '2026-04-28 00:17:08.070255+07', '2026-04-28 00:17:08.070255+07');
INSERT INTO public.course_reviews (id, course_id, user_id, content, rating, created_at, updated_at) VALUES (3, 2, 5, 'Khóa DSA có nhiều ví dụ thực hành, phù hợp cho người chuẩn bị phỏng vấn fresher/intern.', 5, '2026-04-27 00:17:08.070255+07', '2026-04-27 00:17:08.070255+07');
INSERT INTO public.course_reviews (id, course_id, user_id, content, rating, created_at, updated_at) VALUES (4, 4, 5, 'Phần SQL và PostgreSQL khá hữu ích, đặc biệt là constraint, index và thiết kế database quan hệ.', 5, '2026-04-30 00:17:08.070255+07', '2026-04-30 00:17:08.070255+07');
INSERT INTO public.course_reviews (id, course_id, user_id, content, rating, created_at, updated_at) VALUES (5, 5, 5, 'Khóa Docker giúp hiểu cách cấu hình môi trường chạy backend với PostgreSQL và Redis rõ ràng hơn.', 4, '2026-04-30 00:17:08.070255+07', '2026-04-30 00:17:08.070255+07');


--
-- TOC entry 5613 (class 0 OID 17052)
-- Dependencies: 234
-- Data for Name: courses; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.courses (id, title, short_description, course_content, learning_outcomes, course_highlights, technologies_tools, prerequisites, target_audience, completion_benefits, price, thumbnail_url, estimated_duration_hours, status, created_at, updated_at, average_rating, total_reviews, total_enrolled, total_lessons, total_quizzes, total_assignments, total_online_judge_problems, total_videos) VALUES (3, 'Fullstack Web Development with React and Spring Boot', 'Create a complete fullstack web application using React, Spring Boot, REST API and PostgreSQL.', 'This course guides learners through building a fullstack application from frontend UI to backend API. It includes React components, API integration, authentication flow, database design, and deployment preparation.', 'Build React frontend pages; Connect frontend to Spring Boot APIs; Implement login and protected routes; Design database-backed fullstack features.', 'Frontend-backend integration; Real project workflow; Authentication with JWT cookies; REST API consumption; Clean UI structure.', 'React, TypeScript, Spring Boot, PostgreSQL, REST API, JWT', 'Basic HTML, CSS, JavaScript and basic Java knowledge.', 'Learners who want to build complete web applications and portfolio projects.', 'After completing this course, learners can build a complete fullstack project and explain the system architecture in interviews.', 699000.00, 'https://example.com/thumbnails/fullstack-react-springboot.png', 1, 'ACTIVE', '2026-04-30 16:49:26.027416+07', '2026-05-03 22:37:45.118821+07', 0, 0, 1, 2, 0, 0, 0, 2);
INSERT INTO public.courses (id, title, short_description, course_content, learning_outcomes, course_highlights, technologies_tools, prerequisites, target_audience, completion_benefits, price, thumbnail_url, estimated_duration_hours, status, created_at, updated_at, average_rating, total_reviews, total_enrolled, total_lessons, total_quizzes, total_assignments, total_online_judge_problems, total_videos) VALUES (5, 'Docker and Deployment for Spring Boot Applications', 'Package, containerize and deploy Spring Boot applications with Docker, PostgreSQL and Redis.', 'This course teaches how to prepare a Spring Boot application for deployment. Learners will use Docker, Docker Compose, environment variables, PostgreSQL, Redis, and basic production configuration.', 'Write Dockerfiles for Spring Boot; Configure Docker Compose; Use environment variables safely; Run PostgreSQL and Redis containers; Prepare backend apps for deployment.', 'Dockerized backend setup; PostgreSQL and Redis containers; Environment-based configuration; Deployment-ready project structure.', 'Docker, Docker Compose, Spring Boot, PostgreSQL, Redis, Environment Variables', 'Basic Spring Boot knowledge and command-line usage.', 'Backend developers who want to deploy real applications and understand container-based workflows.', 'Learners can run their backend project consistently across local and deployment environments.', 349000.00, 'https://example.com/thumbnails/docker-springboot-deployment.png', 1, 'ACTIVE', '2026-04-30 16:49:26.027416+07', '2026-05-03 22:37:45.118821+07', 4, 1, 1, 2, 0, 0, 0, 2);
INSERT INTO public.courses (id, title, short_description, course_content, learning_outcomes, course_highlights, technologies_tools, prerequisites, target_audience, completion_benefits, price, thumbnail_url, estimated_duration_hours, status, created_at, updated_at, average_rating, total_reviews, total_enrolled, total_lessons, total_quizzes, total_assignments, total_online_judge_problems, total_videos) VALUES (4, 'SQL and PostgreSQL for Backend Developers', 'Learn relational database design, SQL queries, indexing, constraints and PostgreSQL best practices.', 'This course focuses on practical SQL and PostgreSQL usage for backend developers. It covers database modeling, normalization, joins, indexes, constraints, transactions, and query optimization basics.', 'Design relational schemas; Write SQL queries with joins and aggregations; Use constraints and indexes properly; Understand transactions and database consistency.', 'Database design practice; PostgreSQL-specific features; Index and constraint usage; Backend-oriented SQL examples.', 'PostgreSQL, SQL, ERD, Indexes, Constraints, Transactions', 'Basic programming knowledge. No advanced database experience required.', 'Backend beginners who want to understand databases deeply and design better schemas.', 'Learners will be able to design and implement relational databases for real backend projects.', 299000.00, 'https://example.com/thumbnails/postgresql-backend.png', 1, 'ACTIVE', '2026-04-30 16:49:26.027416+07', '2026-05-03 22:37:45.118821+07', 5, 1, 1, 2, 0, 0, 0, 2);
INSERT INTO public.courses (id, title, short_description, course_content, learning_outcomes, course_highlights, technologies_tools, prerequisites, target_audience, completion_benefits, price, thumbnail_url, estimated_duration_hours, status, created_at, updated_at, average_rating, total_reviews, total_enrolled, total_lessons, total_quizzes, total_assignments, total_online_judge_problems, total_videos) VALUES (2, 'Data Structures and Algorithms for Coding Interviews', 'Master essential data structures and algorithms through coding problems and online judge practice.', 'This course teaches arrays, strings, linked lists, stacks, queues, trees, graphs, recursion, dynamic programming, greedy algorithms, and sorting/searching techniques with hands-on coding exercises.', 'Solve common algorithmic problems; Analyze time and space complexity; Apply data structures correctly; Prepare for coding interviews and contests.', 'Online judge practice; Problem-solving patterns; Interview-focused lessons; Step-by-step explanation of algorithms.', 'Java, Online Judge, Big O Notation, Data Structures, Algorithms', 'Basic programming knowledge in Java or another language.', 'Students preparing for coding interviews, programming contests, or improving problem-solving skills.', 'Learners will be able to solve medium-level coding problems and understand common algorithm patterns.', 399000.00, 'https://example.com/thumbnails/dsa-coding-interview.png', 2, 'ACTIVE', '2026-04-30 16:49:26.027416+07', '2026-05-03 22:37:45.118821+07', 4.5, 2, 2, 3, 0, 0, 0, 2);
INSERT INTO public.courses (id, title, short_description, course_content, learning_outcomes, course_highlights, technologies_tools, prerequisites, target_audience, completion_benefits, price, thumbnail_url, estimated_duration_hours, status, created_at, updated_at, average_rating, total_reviews, total_enrolled, total_lessons, total_quizzes, total_assignments, total_online_judge_problems, total_videos) VALUES (1, 'Java Backend Development with Spring Boot', 'Build production-ready REST APIs with Java, Spring Boot, Spring Security, JPA, PostgreSQL and JWT.', 'This course covers Java backend development from project setup to building secure REST APIs. Learners will implement authentication, authorization, CRUD modules, database relationships, validation, exception handling, and API documentation.', 'Understand Spring Boot project structure; Build RESTful APIs; Work with PostgreSQL using Spring Data JPA; Implement JWT authentication and role-based authorization; Handle validation and global exceptions.', 'Real-world backend architecture; JWT authentication; Role-based access control; PostgreSQL relational database; Clean layered architecture.', 'Java 21, Spring Boot, Spring Security, Spring Data JPA, PostgreSQL, Maven, Lombok, MapStruct', 'Basic Java syntax, OOP concepts, basic SQL knowledge.', 'Students who want to become backend developers; Java learners preparing for internship or fresher backend positions.', 'After completing this course, learners can build and structure a real backend API project suitable for portfolio and CV.', 499000.00, 'https://example.com/thumbnails/java-spring-boot-backend.png', 2, 'ACTIVE', '2026-04-30 16:49:26.027416+07', '2026-05-03 22:37:45.118821+07', 5, 1, 1, 6, 0, 0, 0, 6);


--
-- TOC entry 5623 (class 0 OID 17182)
-- Dependencies: 244
-- Data for Name: enrollments; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.enrollments (id, user_id, course_id, payment_id, enrolled_at, status) VALUES (1, 2, 1, 1, '2026-04-21 00:17:08.070255+07', 'ACTIVE');
INSERT INTO public.enrollments (id, user_id, course_id, payment_id, enrolled_at, status) VALUES (2, 2, 2, 2, '2026-04-23 00:17:08.070255+07', 'ACTIVE');
INSERT INTO public.enrollments (id, user_id, course_id, payment_id, enrolled_at, status) VALUES (3, 2, 3, 3, '2026-04-26 00:17:08.070255+07', 'ACTIVE');
INSERT INTO public.enrollments (id, user_id, course_id, payment_id, enrolled_at, status) VALUES (5, 5, 4, 5, '2026-04-24 00:17:08.070255+07', 'ACTIVE');
INSERT INTO public.enrollments (id, user_id, course_id, payment_id, enrolled_at, status) VALUES (6, 5, 5, 6, '2026-04-28 00:17:08.070255+07', 'ACTIVE');
INSERT INTO public.enrollments (id, user_id, course_id, payment_id, enrolled_at, status) VALUES (4, 5, 2, 4, '2026-04-19 00:17:08.070255+07', 'ACTIVE');


--
-- TOC entry 5649 (class 0 OID 17535)
-- Dependencies: 270
-- Data for Name: file_assignments; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 5651 (class 0 OID 17563)
-- Dependencies: 272
-- Data for Name: file_submissions; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 5607 (class 0 OID 16990)
-- Dependencies: 228
-- Data for Name: invalidated_tokens; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.invalidated_tokens (id, token_jti, expiry_time, created_at) VALUES (1, '53b9039f-f469-43ab-8b6f-0e51808d6c7e', '2026-04-29 18:44:26+07', '2026-04-29 18:43:28.962707+07');
INSERT INTO public.invalidated_tokens (id, token_jti, expiry_time, created_at) VALUES (2, '194bbca8-97c9-455b-864f-bc358256763b', '2026-04-29 18:53:09+07', '2026-04-29 18:52:14.612199+07');
INSERT INTO public.invalidated_tokens (id, token_jti, expiry_time, created_at) VALUES (3, 'f938cd5b-2fb5-4102-a5bf-f4c41d022381', '2026-04-29 18:54:10+07', '2026-04-29 18:52:14.643913+07');
INSERT INTO public.invalidated_tokens (id, token_jti, expiry_time, created_at) VALUES (4, '4efc76ef-43b2-417d-9df1-24a3eab16390', '2026-04-29 18:53:47+07', '2026-04-29 18:52:59.831976+07');
INSERT INTO public.invalidated_tokens (id, token_jti, expiry_time, created_at) VALUES (5, 'e49ab867-1ff6-4221-bbf4-ac829a4262f8', '2026-04-29 18:54:47+07', '2026-04-29 18:52:59.835976+07');
INSERT INTO public.invalidated_tokens (id, token_jti, expiry_time, created_at) VALUES (6, '5854eb49-3543-4d3a-be12-5deae55da287', '2026-04-29 19:07:39+07', '2026-04-29 19:06:50.619297+07');
INSERT INTO public.invalidated_tokens (id, token_jti, expiry_time, created_at) VALUES (7, 'ec1e72bf-9ebc-49b1-98f7-71b13bc4068e', '2026-04-29 19:08:39+07', '2026-04-29 19:06:50.649524+07');
INSERT INTO public.invalidated_tokens (id, token_jti, expiry_time, created_at) VALUES (8, '08c50ec6-7cef-49ed-957a-6093cf1a428c', '2026-04-29 19:41:36+07', '2026-04-29 19:39:42.487806+07');
INSERT INTO public.invalidated_tokens (id, token_jti, expiry_time, created_at) VALUES (9, 'a9f43e5f-3cfc-4ae9-84e6-1301de3cd110', '2026-04-29 19:42:20+07', '2026-04-29 19:40:23.138344+07');
INSERT INTO public.invalidated_tokens (id, token_jti, expiry_time, created_at) VALUES (10, 'fb962b42-8509-4e13-87e1-028d29d30487', '2026-04-29 19:41:23+07', '2026-04-29 19:40:45.797481+07');
INSERT INTO public.invalidated_tokens (id, token_jti, expiry_time, created_at) VALUES (11, '6079f44c-4890-4633-800c-4fb2f8ca19b9', '2026-04-29 19:42:23+07', '2026-04-29 19:40:45.800487+07');
INSERT INTO public.invalidated_tokens (id, token_jti, expiry_time, created_at) VALUES (12, '466ce5a0-758f-433b-b537-ae6655d79d83', '2026-04-29 23:16:02+07', '2026-04-29 23:15:43.086455+07');
INSERT INTO public.invalidated_tokens (id, token_jti, expiry_time, created_at) VALUES (13, 'd2e2626e-e745-4a85-88d7-434e6f7416e5', '2026-04-29 23:17:02+07', '2026-04-29 23:15:43.116991+07');
INSERT INTO public.invalidated_tokens (id, token_jti, expiry_time, created_at) VALUES (14, '8e264151-a934-48da-bc5b-04ca9e3091be', '2026-04-29 23:17:57+07', '2026-04-29 23:15:59.669612+07');
INSERT INTO public.invalidated_tokens (id, token_jti, expiry_time, created_at) VALUES (15, 'e91991a4-00ee-4413-89e8-6f5d671020e1', '2026-04-29 23:16:59+07', '2026-04-29 23:16:04.543159+07');
INSERT INTO public.invalidated_tokens (id, token_jti, expiry_time, created_at) VALUES (16, '80f5f2fa-4ff4-4300-9de3-0d27f5768c45', '2026-04-29 23:17:59+07', '2026-04-29 23:16:04.546159+07');
INSERT INTO public.invalidated_tokens (id, token_jti, expiry_time, created_at) VALUES (17, '95ca130f-3dd0-4143-84dd-824153d5aeb6', '2026-04-30 01:49:51+07', '2026-04-30 01:49:03.846797+07');
INSERT INTO public.invalidated_tokens (id, token_jti, expiry_time, created_at) VALUES (18, '87bb0dfb-85eb-434c-9cde-d362d6661e04', '2026-04-30 01:51:23+07', '2026-04-30 01:50:36.155134+07');
INSERT INTO public.invalidated_tokens (id, token_jti, expiry_time, created_at) VALUES (19, 'c3d0ad64-a395-4b1f-9641-ea109e69fcbc', '2026-04-30 01:52:42+07', '2026-04-30 01:51:51.449807+07');


--
-- TOC entry 5653 (class 0 OID 17603)
-- Dependencies: 274
-- Data for Name: lesson_comments; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.lesson_comments (id, lesson_id, user_id, parent_comment_id, content, created_at, updated_at) VALUES (1, 8, 2, NULL, 'Bài học này khá thú vị, nhưng đoạn code vòng lặp for ở phút thứ 5 mình chưa hiểu lắm. Có ai giải thích giúp mình không?', '2026-05-04 00:25:35.818753+07', '2026-05-04 00:25:35.818753+07');
INSERT INTO public.lesson_comments (id, lesson_id, user_id, parent_comment_id, content, created_at, updated_at) VALUES (2, 8, 5, NULL, 'Cho mình hỏi tài liệu slide của bài 8 này tải ở đâu vậy mọi người?', '2026-05-05 00:25:35.818753+07', '2026-05-05 00:25:35.818753+07');
INSERT INTO public.lesson_comments (id, lesson_id, user_id, parent_comment_id, content, created_at, updated_at) VALUES (3, 9, 2, NULL, 'Phần đệ quy này hại não quá, mình xem đi xem lại 3 lần mới hiểu =))', '2026-05-05 19:25:35.818753+07', '2026-05-05 19:25:35.818753+07');
INSERT INTO public.lesson_comments (id, lesson_id, user_id, parent_comment_id, content, created_at, updated_at) VALUES (4, 8, 5, 1, 'À, đoạn đó thầy dùng vòng lặp for lồng nhau để duyệt qua mảng 2 chiều đó bạn. Bạn xem kỹ lại lý thuyết mảng 2 chiều nhé.', '2026-05-04 01:25:35.818753+07', '2026-05-04 01:25:35.818753+07');
INSERT INTO public.lesson_comments (id, lesson_id, user_id, parent_comment_id, content, created_at, updated_at) VALUES (5, 8, 2, 1, 'Cảm ơn bạn nhé, mình hiểu rồi! Mình quên mất khái niệm mảng 2 chiều.', '2026-05-04 02:25:35.818753+07', '2026-05-04 02:25:35.818753+07');
INSERT INTO public.lesson_comments (id, lesson_id, user_id, parent_comment_id, content, created_at, updated_at) VALUES (6, 8, 2, 2, 'Bạn check ở phần tab "Tài liệu đính kèm" ngay dưới video nhé, có file PDF đó.', '2026-05-05 04:25:35.818753+07', '2026-05-05 04:25:35.818753+07');
INSERT INTO public.lesson_comments (id, lesson_id, user_id, parent_comment_id, content, created_at, updated_at) VALUES (7, 9, 5, 3, 'Haha công nhận, đệ quy ban đầu hơi khó hiểu, nhưng dùng tính năng debug step-by-step trên IDE là dễ hình dung hơn luồng chạy đó bạn.', '2026-05-05 22:25:35.818753+07', '2026-05-05 22:25:35.818753+07');
INSERT INTO public.lesson_comments (id, lesson_id, user_id, parent_comment_id, content, created_at, updated_at) VALUES (8, 8, 2, NULL, 'Địt mẹ dạy như cặc', '2026-05-10 22:06:11.968342+07', '2026-05-10 22:06:11.968342+07');
INSERT INTO public.lesson_comments (id, lesson_id, user_id, parent_comment_id, content, created_at, updated_at) VALUES (9, 8, 5, 8, 'Sủa cái loz', '2026-05-10 22:39:24.637867+07', '2026-05-10 22:39:24.637867+07');


--
-- TOC entry 5625 (class 0 OID 17213)
-- Dependencies: 246
-- Data for Name: lesson_progress; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.lesson_progress (id, user_id, lesson_id, course_id, completed_at) VALUES (2, 2, 1, 1, '2026-05-10 14:46:32.165018+07');
INSERT INTO public.lesson_progress (id, user_id, lesson_id, course_id, completed_at) VALUES (3, 2, 2, 1, '2026-05-11 15:41:38.85899+07');


--
-- TOC entry 5617 (class 0 OID 17094)
-- Dependencies: 238
-- Data for Name: lessons; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.lessons (id, chapter_id, title, description, video_url, theory_content, sample_code, is_trial, order_index, estimated_duration_minutes, status, created_at, updated_at, has_quiz, has_assignment, has_online_judge) VALUES (3, 1, 'Khởi tạo Spring Boot Project với Spring Initializr', 'Cách tạo project cơ bản.', 'https://example.com/video/spring-init.mp4', '<p>Truy cập start.spring.io và chọn các dependency cần thiết...</p>', NULL, false, 3, 25, 'ACTIVE', '2026-05-03 22:26:05.65978+07', '2026-05-03 22:32:58.912717+07', false, false, false);
INSERT INTO public.lessons (id, chapter_id, title, description, video_url, theory_content, sample_code, is_trial, order_index, estimated_duration_minutes, status, created_at, updated_at, has_quiz, has_assignment, has_online_judge) VALUES (5, 2, 'Tạo API GET đầu tiên (Hello World)', 'Viết API trả về chuỗi.', 'https://example.com/video/hello-api.mp4', '<p>Sử dụng @GetMapping để định tuyến request GET.</p>', '@GetMapping("/hello")\npublic String hello() { return "Hello World"; }', false, 2, 20, 'ACTIVE', '2026-05-03 22:26:05.65978+07', '2026-05-03 22:32:58.912717+07', false, false, false);
INSERT INTO public.lessons (id, chapter_id, title, description, video_url, theory_content, sample_code, is_trial, order_index, estimated_duration_minutes, status, created_at, updated_at, has_quiz, has_assignment, has_online_judge) VALUES (6, 3, 'Kết nối PostgreSQL và cấu hình application.yml', 'Cách setup kết nối DB.', 'https://example.com/video/connect-db.mp4', '<p>Cấu hình spring.datasource.url, username, password...</p>', 'spring:\n  datasource:\n    url: jdbc:postgresql://localhost:5432/mydb', false, 1, 35, 'ACTIVE', '2026-05-03 22:26:05.65978+07', '2026-05-03 22:32:58.912717+07', false, false, false);
INSERT INTO public.lessons (id, chapter_id, title, description, video_url, theory_content, sample_code, is_trial, order_index, estimated_duration_minutes, status, created_at, updated_at, has_quiz, has_assignment, has_online_judge) VALUES (8, 5, 'Kỹ thuật Two Pointers', 'Dùng 2 con trỏ để giải quyết bài toán mảng nhanh hơn.', 'https://example.com/video/two-pointers.mp4', '<p>Thường dùng trong mảng đã sắp xếp để tìm cặp số...</p>', 'int left = 0, right = arr.length - 1;\nwhile(left < right) {...}', false, 1, 40, 'ACTIVE', '2026-05-03 22:26:05.65978+07', '2026-05-03 22:32:58.912717+07', false, false, false);
INSERT INTO public.lessons (id, chapter_id, title, description, video_url, theory_content, sample_code, is_trial, order_index, estimated_duration_minutes, status, created_at, updated_at, has_quiz, has_assignment, has_online_judge) VALUES (9, 5, 'Thực hành: Đảo ngược chuỗi (Reverse String)', 'Bài tập Online Judge.', NULL, '<p>Viết chương trình đảo ngược một chuỗi ký tự được cho.</p>', 'public String reverse(String s) {\n  // Code here\n}', false, 2, 45, 'ACTIVE', '2026-05-03 22:26:05.65978+07', '2026-05-03 22:32:58.912717+07', false, false, false);
INSERT INTO public.lessons (id, chapter_id, title, description, video_url, theory_content, sample_code, is_trial, order_index, estimated_duration_minutes, status, created_at, updated_at, has_quiz, has_assignment, has_online_judge) VALUES (10, 6, 'Khởi tạo React App bằng Vite', 'Nhanh chóng tạo project React.', 'https://example.com/video/vite-react.mp4', '<p>Chạy lệnh: npm create vite@latest my-app -- --template react</p>', NULL, true, 1, 15, 'ACTIVE', '2026-05-03 22:26:05.65978+07', '2026-05-03 22:32:58.912717+07', false, false, false);
INSERT INTO public.lessons (id, chapter_id, title, description, video_url, theory_content, sample_code, is_trial, order_index, estimated_duration_minutes, status, created_at, updated_at, has_quiz, has_assignment, has_online_judge) VALUES (4, 2, 'Tìm hiểu cấu trúc 3 Layer (Controller - Service - Repository)', 'Mô hình kiến trúc phổ biến nhất trong Spring Boot.', 'https://example.com/video/3-layer.mp4', '<p>Controller xử lý HTTP, Service chứa logic, Repository gọi DB...</p>', '@RestController\npublic class UserController {}', false, 1, 30, 'ACTIVE', '2026-05-03 22:26:05.65978+07', '2026-05-04 02:24:19.271427+07', true, false, false);
INSERT INTO public.lessons (id, chapter_id, title, description, video_url, theory_content, sample_code, is_trial, order_index, estimated_duration_minutes, status, created_at, updated_at, has_quiz, has_assignment, has_online_judge) VALUES (7, 4, 'Giới thiệu về Time & Space Complexity', 'Tại sao phải quan tâm đến Big O?', 'https://example.com/video/big-o.mp4', '<p>O(1), O(N), O(N^2) khác nhau như thế nào...</p>', NULL, true, 1, 20, 'ACTIVE', '2026-05-03 22:26:05.65978+07', '2026-05-04 02:24:19.271427+07', true, false, false);
INSERT INTO public.lessons (id, chapter_id, title, description, video_url, theory_content, sample_code, is_trial, order_index, estimated_duration_minutes, status, created_at, updated_at, has_quiz, has_assignment, has_online_judge) VALUES (2, 1, 'Cài đặt JDK 21 và IntelliJ IDEA', 'Hướng dẫn cài đặt môi trường phát triển Java.', 'https://example.com/video/install-jdk.mp4', '<p>Bước 1: Tải JDK 21. Bước 2: Cấu hình biến môi trường...</p>', NULL, true, 2, 20, 'ACTIVE', '2026-05-03 22:26:05.65978+07', '2026-05-05 03:15:17.516772+07', false, false, true);
INSERT INTO public.lessons (id, chapter_id, title, description, video_url, theory_content, sample_code, is_trial, order_index, estimated_duration_minutes, status, created_at, updated_at, has_quiz, has_assignment, has_online_judge) VALUES (1, 1, 'Giới thiệu khóa học Spring Boot', 'Tổng quan về những gì bạn sẽ học.', 'https://example.com/video/spring-intro.mp4', '<p>Spring Boot giúp xây dựng ứng dụng Java nhanh chóng...</p>', NULL, true, 1, 15, 'ACTIVE', '2026-05-03 22:26:05.65978+07', '2026-05-13 17:35:24.484627+07', true, false, true);
INSERT INTO public.lessons (id, chapter_id, title, description, video_url, theory_content, sample_code, is_trial, order_index, estimated_duration_minutes, status, created_at, updated_at, has_quiz, has_assignment, has_online_judge) VALUES (11, 7, 'Xử lý lỗi CORS (Cross-Origin Resource Sharing)', 'Lỗi kinh điển khi ghép nối FE và BE.', 'https://example.com/video/cors.mp4', '<p>Cấu hình @CrossOrigin trên Backend hoặc setup Proxy trên Frontend.</p>', '@CrossOrigin(origins = "http://localhost:5173")\n@RestController...', false, 1, 25, 'ACTIVE', '2026-05-03 22:26:05.65978+07', '2026-05-03 22:32:58.912717+07', false, false, false);
INSERT INTO public.lessons (id, chapter_id, title, description, video_url, theory_content, sample_code, is_trial, order_index, estimated_duration_minutes, status, created_at, updated_at, has_quiz, has_assignment, has_online_judge) VALUES (12, 8, 'Mệnh đề SELECT và WHERE', 'Lọc dữ liệu cơ bản.', 'https://example.com/video/select-where.mp4', '<p>Sử dụng SELECT để chọn cột, WHERE để thêm điều kiện.</p>', 'SELECT id, name FROM users WHERE status = ''ACTIVE'';', true, 1, 20, 'ACTIVE', '2026-05-03 22:26:05.65978+07', '2026-05-03 22:32:58.912717+07', false, false, false);
INSERT INTO public.lessons (id, chapter_id, title, description, video_url, theory_content, sample_code, is_trial, order_index, estimated_duration_minutes, status, created_at, updated_at, has_quiz, has_assignment, has_online_judge) VALUES (13, 9, 'Phân biệt INNER JOIN và LEFT JOIN', 'Ghép bảng dữ liệu.', 'https://example.com/video/joins.mp4', '<p>INNER JOIN lấy dữ liệu chung, LEFT JOIN lấy tất cả dữ liệu bảng trái.</p>', 'SELECT u.name, r.role_name FROM users u LEFT JOIN roles r ON u.role_id = r.id;', false, 1, 35, 'ACTIVE', '2026-05-03 22:26:05.65978+07', '2026-05-03 22:32:58.912717+07', false, false, false);
INSERT INTO public.lessons (id, chapter_id, title, description, video_url, theory_content, sample_code, is_trial, order_index, estimated_duration_minutes, status, created_at, updated_at, has_quiz, has_assignment, has_online_judge) VALUES (14, 10, 'Khái niệm Containerization', 'Tại sao lại cần Docker?', 'https://example.com/video/docker-intro.mp4', '<p>Docker giải quyết bài toán "Chạy trên máy tôi thì được, lên server thì lỗi".</p>', NULL, true, 1, 20, 'ACTIVE', '2026-05-03 22:26:05.65978+07', '2026-05-03 22:32:58.912717+07', false, false, false);
INSERT INTO public.lessons (id, chapter_id, title, description, video_url, theory_content, sample_code, is_trial, order_index, estimated_duration_minutes, status, created_at, updated_at, has_quiz, has_assignment, has_online_judge) VALUES (15, 10, 'Viết Dockerfile cho ứng dụng Spring Boot', 'Đóng gói file .jar thành Docker Image.', 'https://example.com/video/dockerfile.mp4', '<p>Sử dụng image base là openjdk hoặc eclipse-temurin.</p>', 'FROM eclipse-temurin:21-jre-alpine\nCOPY target/*.jar app.jar\nENTRYPOINT ["java","-jar","/app.jar"]', false, 2, 30, 'ACTIVE', '2026-05-03 22:26:05.65978+07', '2026-05-03 22:32:58.912717+07', false, false, false);


--
-- TOC entry 5637 (class 0 OID 17371)
-- Dependencies: 258
-- Data for Name: online_judge_problems; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.online_judge_problems (id, lesson_id, title, description, input_description, output_description, constraints, example_input, example_output, hint, problem_scope, difficulty, is_active, created_by_teacher_id, created_at, updated_at) VALUES (1, 1, 'Tính tổng hai số (A + B)', '<p>Cho hai số nguyên <code>a</code> và <code>b</code>. Hãy tính tổng của chúng và in ra màn hình.</p>', 'Một dòng duy nhất chứa hai số nguyên a và b cách nhau bởi khoảng trắng.', 'Một số nguyên duy nhất là tổng của a và b.', '-10^9 \le a, b \le 10^9', '5 7', '12', 'Bạn có thể sử dụng toán tử cộng (+) cơ bản trong bất kỳ ngôn ngữ nào.', 'LESSON', 'EASY', true, 1, '2026-05-05 03:15:17.516772+07', '2026-05-05 03:15:17.516772+07');
INSERT INTO public.online_judge_problems (id, lesson_id, title, description, input_description, output_description, constraints, example_input, example_output, hint, problem_scope, difficulty, is_active, created_by_teacher_id, created_at, updated_at) VALUES (2, 1, 'Đảo ngược chuỗi', '<p>Cho một chuỗi ký tự <code>S</code>. Nhiệm vụ của bạn là in ra chuỗi đó theo thứ tự ngược lại.</p>', 'Một dòng duy nhất chứa chuỗi S (không chứa khoảng trắng).', 'Chuỗi S sau khi được đảo ngược.', '1 \le |S| \le 10^5', 'hello', 'olleh', 'Hãy thử dùng vòng lặp duyệt từ cuối về đầu, hoặc dùng các hàm có sẵn của thư viện (như StringBuilder.reverse() trong Java).', 'LESSON', 'EASY', true, 1, '2026-05-05 03:15:17.516772+07', '2026-05-05 03:15:17.516772+07');
INSERT INTO public.online_judge_problems (id, lesson_id, title, description, input_description, output_description, constraints, example_input, example_output, hint, problem_scope, difficulty, is_active, created_by_teacher_id, created_at, updated_at) VALUES (3, 2, 'Tìm giá trị lớn nhất trong mảng', '<p>Cho một mảng gồm <code>N</code> số nguyên. Hãy tìm và in ra giá trị lớn nhất xuất hiện trong mảng đó.</p>', 'Dòng đầu tiên chứa số nguyên N. Dòng thứ hai chứa N số nguyên cách nhau bởi khoảng trắng.', 'Một số nguyên duy nhất là giá trị lớn nhất trong mảng.', '1 \le N \le 10^5<br/>-10^9 \le A[i] \le 10^9', '5
1 4 2 8 5', '8', 'Gán giá trị max ban đầu bằng phần tử đầu tiên của mảng, sau đó duyệt qua các phần tử còn lại để cập nhật max.', 'LESSON', 'MEDIUM', true, 1, '2026-05-05 03:15:17.516772+07', '2026-05-05 03:15:17.516772+07');


--
-- TOC entry 5666 (class 0 OID 17928)
-- Dependencies: 287
-- Data for Name: online_judge_submission_details; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 5647 (class 0 OID 17494)
-- Dependencies: 268
-- Data for Name: online_judge_submissions; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.online_judge_submissions (id, user_id, problem_id, lesson_id, contest_id, language_id, source_code, execution_time_ms, memory_used_kb, score, submitted_at) VALUES (1, 2, 1, 1, NULL, 1, 'import java.util.Scanner;
public class Main {
    public static void main(String[] args) {
        System.out.println("Kết quả là 12"); // In bậy bạ
    }
}', 15, 1024, 0.00, '2026-05-05 03:15:17.516772+07');
INSERT INTO public.online_judge_submissions (id, user_id, problem_id, lesson_id, contest_id, language_id, source_code, execution_time_ms, memory_used_kb, score, submitted_at) VALUES (2, 2, 1, 1, NULL, 1, 'import java.util.Scanner;
public class Main {
    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);
        System.out.println(sc.nextInt() + sc.nextInt());
    }
}', 20, 2048, 100.00, '2026-05-05 03:15:17.516772+07');
INSERT INTO public.online_judge_submissions (id, user_id, problem_id, lesson_id, contest_id, language_id, source_code, execution_time_ms, memory_used_kb, score, submitted_at) VALUES (3, 5, 2, 1, NULL, 1, 'import java.util.Scanner;
public class Main {
    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);
        String s = sc.next();
        System.out.println(new StringBuilder(s).reverse().toString());
    }
}', 25, 2048, 100.00, '2026-05-05 03:15:17.516772+07');


--
-- TOC entry 5621 (class 0 OID 17155)
-- Dependencies: 242
-- Data for Name: payments; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.payments (id, user_id, course_id, amount, payment_method, transaction_code, payment_status, paid_at) VALUES (1, 2, 1, 499000.00, 'MOMO', 'PAY-U2-C1-20260430-001', 'SUCCESS', '2026-04-21 00:17:08.070255+07');
INSERT INTO public.payments (id, user_id, course_id, amount, payment_method, transaction_code, payment_status, paid_at) VALUES (2, 2, 2, 399000.00, 'VNPAY', 'PAY-U2-C2-20260430-002', 'SUCCESS', '2026-04-23 00:17:08.070255+07');
INSERT INTO public.payments (id, user_id, course_id, amount, payment_method, transaction_code, payment_status, paid_at) VALUES (3, 2, 3, 699000.00, 'BANK_TRANSFER', 'PAY-U2-C3-20260430-003', 'SUCCESS', '2026-04-26 00:17:08.070255+07');
INSERT INTO public.payments (id, user_id, course_id, amount, payment_method, transaction_code, payment_status, paid_at) VALUES (4, 5, 2, 399000.00, 'MOMO', 'PAY-U5-C2-20260430-004', 'SUCCESS', '2026-04-19 00:17:08.070255+07');
INSERT INTO public.payments (id, user_id, course_id, amount, payment_method, transaction_code, payment_status, paid_at) VALUES (5, 5, 4, 299000.00, 'VNPAY', 'PAY-U5-C4-20260430-005', 'SUCCESS', '2026-04-24 00:17:08.070255+07');
INSERT INTO public.payments (id, user_id, course_id, amount, payment_method, transaction_code, payment_status, paid_at) VALUES (6, 5, 5, 349000.00, 'BANK_TRANSFER', 'PAY-U5-C5-20260430-006', 'SUCCESS', '2026-04-28 00:17:08.070255+07');


--
-- TOC entry 5603 (class 0 OID 16944)
-- Dependencies: 224
-- Data for Name: permissions; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.permissions (id, name) VALUES (1, 'AUTH_REGISTER');
INSERT INTO public.permissions (id, name) VALUES (2, 'AUTH_LOGIN');
INSERT INTO public.permissions (id, name) VALUES (3, 'AUTH_LOGOUT');
INSERT INTO public.permissions (id, name) VALUES (4, 'COURSE_VIEW_LIST');
INSERT INTO public.permissions (id, name) VALUES (5, 'COURSE_VIEW_DETAIL');
INSERT INTO public.permissions (id, name) VALUES (6, 'COURSE_CREATE');
INSERT INTO public.permissions (id, name) VALUES (7, 'COURSE_UPDATE');
INSERT INTO public.permissions (id, name) VALUES (8, 'COURSE_DELETE');
INSERT INTO public.permissions (id, name) VALUES (9, 'COURSE_MANAGE_STATUS');
INSERT INTO public.permissions (id, name) VALUES (10, 'CHAPTER_CREATE');
INSERT INTO public.permissions (id, name) VALUES (11, 'CHAPTER_UPDATE');
INSERT INTO public.permissions (id, name) VALUES (12, 'CHAPTER_DELETE');
INSERT INTO public.permissions (id, name) VALUES (13, 'LESSON_CREATE');
INSERT INTO public.permissions (id, name) VALUES (14, 'LESSON_UPDATE');
INSERT INTO public.permissions (id, name) VALUES (15, 'LESSON_DELETE');
INSERT INTO public.permissions (id, name) VALUES (16, 'TEACHER_ASSIGN_COURSE');
INSERT INTO public.permissions (id, name) VALUES (17, 'TEACHER_VIEW_ASSIGNED_COURSE');
INSERT INTO public.permissions (id, name) VALUES (18, 'USER_VIEW');
INSERT INTO public.permissions (id, name) VALUES (19, 'USER_CREATE');
INSERT INTO public.permissions (id, name) VALUES (20, 'USER_UPDATE');
INSERT INTO public.permissions (id, name) VALUES (21, 'USER_DELETE');
INSERT INTO public.permissions (id, name) VALUES (22, 'USER_LOCK');
INSERT INTO public.permissions (id, name) VALUES (23, 'USER_UNLOCK');
INSERT INTO public.permissions (id, name) VALUES (24, 'TEACHER_VIEW');
INSERT INTO public.permissions (id, name) VALUES (25, 'TEACHER_CREATE');
INSERT INTO public.permissions (id, name) VALUES (26, 'TEACHER_UPDATE');
INSERT INTO public.permissions (id, name) VALUES (27, 'TEACHER_DELETE');
INSERT INTO public.permissions (id, name) VALUES (28, 'PAYMENT_CREATE');
INSERT INTO public.permissions (id, name) VALUES (29, 'PAYMENT_VIEW_OWN');
INSERT INTO public.permissions (id, name) VALUES (30, 'ENROLLMENT_CREATE');
INSERT INTO public.permissions (id, name) VALUES (31, 'ENROLLMENT_VIEW_OWN');
INSERT INTO public.permissions (id, name) VALUES (32, 'COURSE_CONTENT_ACCESS');
INSERT INTO public.permissions (id, name) VALUES (33, 'LESSON_COMPLETE');
INSERT INTO public.permissions (id, name) VALUES (34, 'LEARNING_PROGRESS_VIEW_OWN');
INSERT INTO public.permissions (id, name) VALUES (35, 'STUDENT_PROGRESS_VIEW_ASSIGNED_COURSE');
INSERT INTO public.permissions (id, name) VALUES (36, 'USER_LEARNING_STATISTICS_VIEW_ALL');
INSERT INTO public.permissions (id, name) VALUES (37, 'QUIZ_VIEW');
INSERT INTO public.permissions (id, name) VALUES (38, 'QUIZ_SUBMIT');
INSERT INTO public.permissions (id, name) VALUES (39, 'QUIZ_RESULT_VIEW_OWN');
INSERT INTO public.permissions (id, name) VALUES (40, 'QUIZ_CREATE_ASSIGNED_COURSE');
INSERT INTO public.permissions (id, name) VALUES (41, 'QUIZ_UPDATE_ASSIGNED_COURSE');
INSERT INTO public.permissions (id, name) VALUES (42, 'QUIZ_DELETE_ASSIGNED_COURSE');
INSERT INTO public.permissions (id, name) VALUES (43, 'OJ_PROBLEM_VIEW');
INSERT INTO public.permissions (id, name) VALUES (44, 'OJ_SUBMISSION_CREATE_LESSON');
INSERT INTO public.permissions (id, name) VALUES (45, 'OJ_SUBMISSION_VIEW_OWN');
INSERT INTO public.permissions (id, name) VALUES (46, 'OJ_PROBLEM_CREATE_ASSIGNED_COURSE');
INSERT INTO public.permissions (id, name) VALUES (47, 'OJ_PROBLEM_UPDATE_ASSIGNED_COURSE');
INSERT INTO public.permissions (id, name) VALUES (48, 'OJ_PROBLEM_DELETE_ASSIGNED_COURSE');
INSERT INTO public.permissions (id, name) VALUES (49, 'OJ_TESTCASE_MANAGE_ASSIGNED_COURSE');
INSERT INTO public.permissions (id, name) VALUES (50, 'OJ_TAG_MANAGE');
INSERT INTO public.permissions (id, name) VALUES (51, 'FILE_ASSIGNMENT_VIEW');
INSERT INTO public.permissions (id, name) VALUES (52, 'FILE_SUBMISSION_CREATE');
INSERT INTO public.permissions (id, name) VALUES (53, 'FILE_SUBMISSION_VIEW_OWN');
INSERT INTO public.permissions (id, name) VALUES (54, 'FILE_ASSIGNMENT_CREATE_ASSIGNED_COURSE');
INSERT INTO public.permissions (id, name) VALUES (55, 'FILE_ASSIGNMENT_UPDATE_ASSIGNED_COURSE');
INSERT INTO public.permissions (id, name) VALUES (56, 'FILE_ASSIGNMENT_DELETE_ASSIGNED_COURSE');
INSERT INTO public.permissions (id, name) VALUES (57, 'FILE_SUBMISSION_VIEW_ASSIGNED_COURSE');
INSERT INTO public.permissions (id, name) VALUES (58, 'FILE_SUBMISSION_DOWNLOAD_ASSIGNED_COURSE');
INSERT INTO public.permissions (id, name) VALUES (59, 'FILE_SUBMISSION_GRADE_ASSIGNED_COURSE');
INSERT INTO public.permissions (id, name) VALUES (60, 'COMMENT_CREATE');
INSERT INTO public.permissions (id, name) VALUES (61, 'COMMENT_REPLY_OWN');
INSERT INTO public.permissions (id, name) VALUES (62, 'COMMENT_REPLY_ASSIGNED_COURSE');
INSERT INTO public.permissions (id, name) VALUES (63, 'COMMENT_VIEW');
INSERT INTO public.permissions (id, name) VALUES (64, 'CONTEST_VIEW_LIST');
INSERT INTO public.permissions (id, name) VALUES (65, 'CONTEST_JOIN');
INSERT INTO public.permissions (id, name) VALUES (66, 'CONTEST_PROBLEM_VIEW');
INSERT INTO public.permissions (id, name) VALUES (67, 'CONTEST_SUBMISSION_CREATE');
INSERT INTO public.permissions (id, name) VALUES (68, 'CONTEST_RANKING_VIEW');
INSERT INTO public.permissions (id, name) VALUES (69, 'CONTEST_CREATE');
INSERT INTO public.permissions (id, name) VALUES (70, 'CONTEST_UPDATE_OWN');
INSERT INTO public.permissions (id, name) VALUES (71, 'CONTEST_DELETE_OWN');
INSERT INTO public.permissions (id, name) VALUES (72, 'CONTEST_PROBLEM_ADD_OWN');
INSERT INTO public.permissions (id, name) VALUES (73, 'CONTEST_PROBLEM_REMOVE_OWN');
INSERT INTO public.permissions (id, name) VALUES (74, 'CONTEST_RANKING_VIEW_BY_PASSWORD');
INSERT INTO public.permissions (id, name) VALUES (75, 'CONTEST_SUBMISSION_VIEW_OWN');
INSERT INTO public.permissions (id, name) VALUES (76, 'CONTEST_VIEW_ALL');
INSERT INTO public.permissions (id, name) VALUES (77, 'CONTEST_UPDATE_ALL');
INSERT INTO public.permissions (id, name) VALUES (78, 'CONTEST_DELETE_ALL');
INSERT INTO public.permissions (id, name) VALUES (79, 'CONTEST_SUBMISSION_VIEW_ALL');
INSERT INTO public.permissions (id, name) VALUES (80, 'SYSTEM_STATISTICS_VIEW');


--
-- TOC entry 5641 (class 0 OID 17421)
-- Dependencies: 262
-- Data for Name: problem_tag_mappings; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.problem_tag_mappings (id, problem_id, tag_id) VALUES (1, 1, 3);
INSERT INTO public.problem_tag_mappings (id, problem_id, tag_id) VALUES (2, 2, 2);
INSERT INTO public.problem_tag_mappings (id, problem_id, tag_id) VALUES (3, 3, 1);


--
-- TOC entry 5639 (class 0 OID 17403)
-- Dependencies: 260
-- Data for Name: problem_tags; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.problem_tags (id, name, slug, created_at, updated_at) VALUES (1, 'Mảng (Array)', 'array', '2026-05-05 03:15:17.516772+07', '2026-05-05 03:15:17.516772+07');
INSERT INTO public.problem_tags (id, name, slug, created_at, updated_at) VALUES (2, 'Chuỗi (String)', 'string', '2026-05-05 03:15:17.516772+07', '2026-05-05 03:15:17.516772+07');
INSERT INTO public.problem_tags (id, name, slug, created_at, updated_at) VALUES (3, 'Toán học (Math)', 'math', '2026-05-05 03:15:17.516772+07', '2026-05-05 03:15:17.516772+07');
INSERT INTO public.problem_tags (id, name, slug, created_at, updated_at) VALUES (4, 'Quy hoạch động (DP)', 'dynamic-programming', '2026-05-05 03:15:17.516772+07', '2026-05-05 03:15:17.516772+07');


--
-- TOC entry 5643 (class 0 OID 17443)
-- Dependencies: 264
-- Data for Name: problem_testcases; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.problem_testcases (id, problem_id, input_data, expected_output, is_hidden, order_index) VALUES (1, 1, '5 7', '12', false, 1);
INSERT INTO public.problem_testcases (id, problem_id, input_data, expected_output, is_hidden, order_index) VALUES (2, 1, '-10 20', '10', false, 2);
INSERT INTO public.problem_testcases (id, problem_id, input_data, expected_output, is_hidden, order_index) VALUES (3, 1, '1000000 2000000', '3000000', true, 3);
INSERT INTO public.problem_testcases (id, problem_id, input_data, expected_output, is_hidden, order_index) VALUES (4, 2, 'hello', 'olleh', false, 1);
INSERT INTO public.problem_testcases (id, problem_id, input_data, expected_output, is_hidden, order_index) VALUES (5, 2, 'SpringBoot', 'tooB gnirpS', true, 2);
INSERT INTO public.problem_testcases (id, problem_id, input_data, expected_output, is_hidden, order_index) VALUES (6, 3, '5
1 4 2 8 5', '8', false, 1);
INSERT INTO public.problem_testcases (id, problem_id, input_data, expected_output, is_hidden, order_index) VALUES (7, 3, '3
-10 -5 -20', '-5', true, 2);


--
-- TOC entry 5664 (class 0 OID 17871)
-- Dependencies: 285
-- Data for Name: quiz_attempt_answers; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.quiz_attempt_answers (id, attempt_id, question_id, selected_option_id) VALUES (1, 1, 1, 2);
INSERT INTO public.quiz_attempt_answers (id, attempt_id, question_id, selected_option_id) VALUES (2, 1, 2, 7);
INSERT INTO public.quiz_attempt_answers (id, attempt_id, question_id, selected_option_id) VALUES (3, 1, 3, 11);
INSERT INTO public.quiz_attempt_answers (id, attempt_id, question_id, selected_option_id) VALUES (4, 1, 4, 16);
INSERT INTO public.quiz_attempt_answers (id, attempt_id, question_id, selected_option_id) VALUES (5, 1, 5, 18);
INSERT INTO public.quiz_attempt_answers (id, attempt_id, question_id, selected_option_id) VALUES (6, 1, 6, 21);
INSERT INTO public.quiz_attempt_answers (id, attempt_id, question_id, selected_option_id) VALUES (7, 1, 7, 26);
INSERT INTO public.quiz_attempt_answers (id, attempt_id, question_id, selected_option_id) VALUES (8, 1, 8, 30);
INSERT INTO public.quiz_attempt_answers (id, attempt_id, question_id, selected_option_id) VALUES (9, 1, 9, 34);
INSERT INTO public.quiz_attempt_answers (id, attempt_id, question_id, selected_option_id) VALUES (10, 1, 10, NULL);
INSERT INTO public.quiz_attempt_answers (id, attempt_id, question_id, selected_option_id) VALUES (11, 2, 12, 45);
INSERT INTO public.quiz_attempt_answers (id, attempt_id, question_id, selected_option_id) VALUES (12, 2, 19, 76);
INSERT INTO public.quiz_attempt_answers (id, attempt_id, question_id, selected_option_id) VALUES (13, 2, 18, 71);
INSERT INTO public.quiz_attempt_answers (id, attempt_id, question_id, selected_option_id) VALUES (14, 2, 17, 66);
INSERT INTO public.quiz_attempt_answers (id, attempt_id, question_id, selected_option_id) VALUES (15, 2, 13, 49);
INSERT INTO public.quiz_attempt_answers (id, attempt_id, question_id, selected_option_id) VALUES (16, 2, 15, NULL);
INSERT INTO public.quiz_attempt_answers (id, attempt_id, question_id, selected_option_id) VALUES (17, 2, 20, 79);
INSERT INTO public.quiz_attempt_answers (id, attempt_id, question_id, selected_option_id) VALUES (18, 2, 11, 43);
INSERT INTO public.quiz_attempt_answers (id, attempt_id, question_id, selected_option_id) VALUES (19, 2, 16, 63);
INSERT INTO public.quiz_attempt_answers (id, attempt_id, question_id, selected_option_id) VALUES (20, 2, 14, 56);


--
-- TOC entry 5635 (class 0 OID 17343)
-- Dependencies: 256
-- Data for Name: quiz_attempts; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.quiz_attempts (id, user_id, quiz_id, total_questions, correct_answers, score, submitted_at, created_at, updated_at) VALUES (1, 2, 1, 10, 8, 80.00, '2026-05-04 18:32:50.763517+07', '2026-05-04 18:32:50.763517+07', '2026-05-04 18:32:50.763517+07');
INSERT INTO public.quiz_attempts (id, user_id, quiz_id, total_questions, correct_answers, score, submitted_at, created_at, updated_at) VALUES (2, 5, 2, 10, 7, 7.00, '2026-05-10 21:15:19.743333+07', NULL, NULL);


--
-- TOC entry 5633 (class 0 OID 17322)
-- Dependencies: 254
-- Data for Name: quiz_options; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.quiz_options (id, question_id, content, is_correct, order_index) VALUES (1, 1, 'Tầng Service', false, 1);
INSERT INTO public.quiz_options (id, question_id, content, is_correct, order_index) VALUES (2, 1, 'Tầng Controller', true, 2);
INSERT INTO public.quiz_options (id, question_id, content, is_correct, order_index) VALUES (3, 1, 'Tầng Repository', false, 3);
INSERT INTO public.quiz_options (id, question_id, content, is_correct, order_index) VALUES (4, 1, 'Tầng Entity', false, 4);
INSERT INTO public.quiz_options (id, question_id, content, is_correct, order_index) VALUES (5, 2, 'Tầng Controller', false, 1);
INSERT INTO public.quiz_options (id, question_id, content, is_correct, order_index) VALUES (6, 2, 'Tầng Repository', false, 2);
INSERT INTO public.quiz_options (id, question_id, content, is_correct, order_index) VALUES (7, 2, 'Tầng Service', true, 3);
INSERT INTO public.quiz_options (id, question_id, content, is_correct, order_index) VALUES (8, 2, 'Tầng Configuration', false, 4);
INSERT INTO public.quiz_options (id, question_id, content, is_correct, order_index) VALUES (9, 3, 'Xử lý các tính toán phức tạp', false, 1);
INSERT INTO public.quiz_options (id, question_id, content, is_correct, order_index) VALUES (10, 3, 'Trả về JSON cho Client', false, 2);
INSERT INTO public.quiz_options (id, question_id, content, is_correct, order_index) VALUES (11, 3, 'Tương tác trực tiếp với Cơ sở dữ liệu (CRUD)', true, 3);
INSERT INTO public.quiz_options (id, question_id, content, is_correct, order_index) VALUES (12, 3, 'Kiểm tra quyền truy cập của người dùng', false, 4);
INSERT INTO public.quiz_options (id, question_id, content, is_correct, order_index) VALUES (13, 4, '@Service', false, 1);
INSERT INTO public.quiz_options (id, question_id, content, is_correct, order_index) VALUES (14, 4, '@Repository', false, 2);
INSERT INTO public.quiz_options (id, question_id, content, is_correct, order_index) VALUES (15, 4, '@Component', false, 3);
INSERT INTO public.quiz_options (id, question_id, content, is_correct, order_index) VALUES (16, 4, '@Entity', true, 4);
INSERT INTO public.quiz_options (id, question_id, content, is_correct, order_index) VALUES (17, 5, 'Giữa Database và Repository', false, 1);
INSERT INTO public.quiz_options (id, question_id, content, is_correct, order_index) VALUES (18, 5, 'Giữa Client và Controller', true, 2);
INSERT INTO public.quiz_options (id, question_id, content, is_correct, order_index) VALUES (19, 5, 'Giữa Entity và Database', false, 3);
INSERT INTO public.quiz_options (id, question_id, content, is_correct, order_index) VALUES (20, 5, 'Tất cả đều sai', false, 4);
INSERT INTO public.quiz_options (id, question_id, content, is_correct, order_index) VALUES (21, 6, '@RestController tự động gắn @ResponseBody vào tất cả các API', true, 1);
INSERT INTO public.quiz_options (id, question_id, content, is_correct, order_index) VALUES (22, 6, '@RestController trả về giao diện HTML', false, 2);
INSERT INTO public.quiz_options (id, question_id, content, is_correct, order_index) VALUES (23, 6, '@RestController chạy nhanh hơn @Controller', false, 3);
INSERT INTO public.quiz_options (id, question_id, content, is_correct, order_index) VALUES (24, 6, 'Không có sự khác biệt, có thể dùng thay thế nhau 100%', false, 4);
INSERT INTO public.quiz_options (id, question_id, content, is_correct, order_index) VALUES (25, 7, 'Vì Spring Boot không cho phép điều đó', false, 1);
INSERT INTO public.quiz_options (id, question_id, content, is_correct, order_index) VALUES (26, 7, 'Để đảm bảo nguyên tắc Separation of Concerns và dễ dàng viết Unit Test', true, 2);
INSERT INTO public.quiz_options (id, question_id, content, is_correct, order_index) VALUES (27, 7, 'Vì sẽ gây ra lỗi biên dịch (Compile Error)', false, 3);
INSERT INTO public.quiz_options (id, question_id, content, is_correct, order_index) VALUES (28, 7, 'Vì Repository không thể inject vào Controller', false, 4);
INSERT INTO public.quiz_options (id, question_id, content, is_correct, order_index) VALUES (29, 8, 'Trên các method của Controller', false, 1);
INSERT INTO public.quiz_options (id, question_id, content, is_correct, order_index) VALUES (30, 8, 'Trên các method của Service', true, 2);
INSERT INTO public.quiz_options (id, question_id, content, is_correct, order_index) VALUES (31, 8, 'Trên các method của Repository', false, 3);
INSERT INTO public.quiz_options (id, question_id, content, is_correct, order_index) VALUES (32, 8, 'Trong file application.yml', false, 4);
INSERT INTO public.quiz_options (id, question_id, content, is_correct, order_index) VALUES (33, 9, 'Presentation Layer (Controller)', false, 1);
INSERT INTO public.quiz_options (id, question_id, content, is_correct, order_index) VALUES (34, 9, 'Business Logic Layer (Service)', false, 2);
INSERT INTO public.quiz_options (id, question_id, content, is_correct, order_index) VALUES (35, 9, 'Data Access Layer (Repository)', true, 3);
INSERT INTO public.quiz_options (id, question_id, content, is_correct, order_index) VALUES (36, 9, 'Database Layer', false, 4);
INSERT INTO public.quiz_options (id, question_id, content, is_correct, order_index) VALUES (37, 10, 'Controller inject Repository, Repository inject Service', false, 1);
INSERT INTO public.quiz_options (id, question_id, content, is_correct, order_index) VALUES (38, 10, 'Controller inject Service, Service inject Repository', true, 2);
INSERT INTO public.quiz_options (id, question_id, content, is_correct, order_index) VALUES (39, 10, 'Tất cả các tầng tự khởi tạo đối tượng bằng từ khóa "new"', false, 3);
INSERT INTO public.quiz_options (id, question_id, content, is_correct, order_index) VALUES (40, 10, 'Service tự tạo ra Controller và Repository', false, 4);
INSERT INTO public.quiz_options (id, question_id, content, is_correct, order_index) VALUES (41, 11, 'Bộ nhớ chính xác (byte) thuật toán sẽ sử dụng', false, 1);
INSERT INTO public.quiz_options (id, question_id, content, is_correct, order_index) VALUES (42, 11, 'Tốc độ thực thi chính xác (mili-giây) của thuật toán', false, 2);
INSERT INTO public.quiz_options (id, question_id, content, is_correct, order_index) VALUES (43, 11, 'Sự tăng trưởng thời gian/không gian khi kích thước đầu vào (N) tăng lên', true, 3);
INSERT INTO public.quiz_options (id, question_id, content, is_correct, order_index) VALUES (44, 11, 'Số lượng dòng code của chương trình', false, 4);
INSERT INTO public.quiz_options (id, question_id, content, is_correct, order_index) VALUES (45, 12, 'Thuật toán chạy mất đúng 1 giây', false, 1);
INSERT INTO public.quiz_options (id, question_id, content, is_correct, order_index) VALUES (46, 12, 'Thuật toán có thời gian chạy không đổi, bất kể kích thước dữ liệu đầu vào', true, 2);
INSERT INTO public.quiz_options (id, question_id, content, is_correct, order_index) VALUES (47, 12, 'Thuật toán chỉ xử lý được 1 phần tử', false, 3);
INSERT INTO public.quiz_options (id, question_id, content, is_correct, order_index) VALUES (48, 12, 'Thuật toán nhanh nhất thế giới', false, 4);
INSERT INTO public.quiz_options (id, question_id, content, is_correct, order_index) VALUES (49, 13, 'O(1)', true, 1);
INSERT INTO public.quiz_options (id, question_id, content, is_correct, order_index) VALUES (50, 13, 'O(N)', false, 2);
INSERT INTO public.quiz_options (id, question_id, content, is_correct, order_index) VALUES (51, 13, 'O(log N)', false, 3);
INSERT INTO public.quiz_options (id, question_id, content, is_correct, order_index) VALUES (52, 13, 'O(N^2)', false, 4);
INSERT INTO public.quiz_options (id, question_id, content, is_correct, order_index) VALUES (53, 14, 'O(1)', false, 1);
INSERT INTO public.quiz_options (id, question_id, content, is_correct, order_index) VALUES (54, 14, 'O(log N)', false, 2);
INSERT INTO public.quiz_options (id, question_id, content, is_correct, order_index) VALUES (55, 14, 'O(N)', true, 3);
INSERT INTO public.quiz_options (id, question_id, content, is_correct, order_index) VALUES (56, 14, 'O(N^2)', false, 4);
INSERT INTO public.quiz_options (id, question_id, content, is_correct, order_index) VALUES (57, 15, 'O(1)', false, 1);
INSERT INTO public.quiz_options (id, question_id, content, is_correct, order_index) VALUES (58, 15, 'O(N)', false, 2);
INSERT INTO public.quiz_options (id, question_id, content, is_correct, order_index) VALUES (59, 15, 'O(N log N)', false, 3);
INSERT INTO public.quiz_options (id, question_id, content, is_correct, order_index) VALUES (60, 15, 'O(log N)', true, 4);
INSERT INTO public.quiz_options (id, question_id, content, is_correct, order_index) VALUES (61, 16, 'O(N)', false, 1);
INSERT INTO public.quiz_options (id, question_id, content, is_correct, order_index) VALUES (62, 16, 'O(2N)', false, 2);
INSERT INTO public.quiz_options (id, question_id, content, is_correct, order_index) VALUES (63, 16, 'O(N^2)', true, 3);
INSERT INTO public.quiz_options (id, question_id, content, is_correct, order_index) VALUES (64, 16, 'O(log N)', false, 4);
INSERT INTO public.quiz_options (id, question_id, content, is_correct, order_index) VALUES (65, 17, 'Lượng dung lượng ổ cứng bị chiếm dụng', false, 1);
INSERT INTO public.quiz_options (id, question_id, content, is_correct, order_index) VALUES (66, 17, 'Lượng bộ nhớ RAM bổ sung thuật toán cần dùng so với lượng dữ liệu đầu vào', true, 2);
INSERT INTO public.quiz_options (id, question_id, content, is_correct, order_index) VALUES (67, 17, 'Băng thông mạng truyền tải', false, 3);
INSERT INTO public.quiz_options (id, question_id, content, is_correct, order_index) VALUES (68, 17, 'Tốc độ xung nhịp của CPU', false, 4);
INSERT INTO public.quiz_options (id, question_id, content, is_correct, order_index) VALUES (69, 18, 'O(N)', false, 1);
INSERT INTO public.quiz_options (id, question_id, content, is_correct, order_index) VALUES (70, 18, 'O(N^2)', false, 2);
INSERT INTO public.quiz_options (id, question_id, content, is_correct, order_index) VALUES (71, 18, 'O(log N)', true, 3);
INSERT INTO public.quiz_options (id, question_id, content, is_correct, order_index) VALUES (72, 18, 'O(N!)', false, 4);
INSERT INTO public.quiz_options (id, question_id, content, is_correct, order_index) VALUES (73, 19, 'O(N)', false, 1);
INSERT INTO public.quiz_options (id, question_id, content, is_correct, order_index) VALUES (74, 19, 'O(N^2)', false, 2);
INSERT INTO public.quiz_options (id, question_id, content, is_correct, order_index) VALUES (75, 19, 'O(1)', false, 3);
INSERT INTO public.quiz_options (id, question_id, content, is_correct, order_index) VALUES (76, 19, 'O(log N)', true, 4);
INSERT INTO public.quiz_options (id, question_id, content, is_correct, order_index) VALUES (77, 20, 'Trường hợp tốt nhất (Best Case)', false, 1);
INSERT INTO public.quiz_options (id, question_id, content, is_correct, order_index) VALUES (78, 20, 'Trường hợp trung bình (Average Case)', false, 2);
INSERT INTO public.quiz_options (id, question_id, content, is_correct, order_index) VALUES (79, 20, 'Trường hợp xấu nhất (Worst Case)', true, 3);
INSERT INTO public.quiz_options (id, question_id, content, is_correct, order_index) VALUES (80, 20, 'Trường hợp không có dữ liệu (Empty Case)', false, 4);
INSERT INTO public.quiz_options (id, question_id, content, is_correct, order_index) VALUES (114, 33, 'Một framework frontend để xây dựng giao diện', false, 1);
INSERT INTO public.quiz_options (id, question_id, content, is_correct, order_index) VALUES (115, 33, 'Một dự án của Spring giúp xây dựng ứng dụng độc lập, production-grade một cách nhanh chóng', true, 2);
INSERT INTO public.quiz_options (id, question_id, content, is_correct, order_index) VALUES (116, 33, 'Một hệ quản trị cơ sở dữ liệu quan hệ', false, 3);
INSERT INTO public.quiz_options (id, question_id, content, is_correct, order_index) VALUES (117, 34, '@SpringBootApplication', true, 1);
INSERT INTO public.quiz_options (id, question_id, content, is_correct, order_index) VALUES (118, 34, '@Configuration', false, 2);
INSERT INTO public.quiz_options (id, question_id, content, is_correct, order_index) VALUES (119, 34, '@EnableAutoConfiguration', false, 3);
INSERT INTO public.quiz_options (id, question_id, content, is_correct, order_index) VALUES (120, 35, 'Jetty', false, 1);
INSERT INTO public.quiz_options (id, question_id, content, is_correct, order_index) VALUES (121, 35, 'Undertow', false, 2);
INSERT INTO public.quiz_options (id, question_id, content, is_correct, order_index) VALUES (122, 35, 'Tomcat', true, 3);
INSERT INTO public.quiz_options (id, question_id, content, is_correct, order_index) VALUES (123, 36, 'spring-boot-starter-data-jpa', false, 1);
INSERT INTO public.quiz_options (id, question_id, content, is_correct, order_index) VALUES (124, 36, 'spring-boot-starter-web', true, 2);
INSERT INTO public.quiz_options (id, question_id, content, is_correct, order_index) VALUES (125, 36, 'spring-boot-starter-security', false, 3);
INSERT INTO public.quiz_options (id, question_id, content, is_correct, order_index) VALUES (126, 37, 'config.properties', false, 1);
INSERT INTO public.quiz_options (id, question_id, content, is_correct, order_index) VALUES (127, 37, 'spring-config.xml', false, 2);
INSERT INTO public.quiz_options (id, question_id, content, is_correct, order_index) VALUES (128, 37, 'application.properties (hoặc application.yml)', true, 3);
INSERT INTO public.quiz_options (id, question_id, content, is_correct, order_index) VALUES (129, 38, 'Spring Boot DevTools', true, 1);
INSERT INTO public.quiz_options (id, question_id, content, is_correct, order_index) VALUES (130, 38, 'Spring Boot Actuator', false, 2);
INSERT INTO public.quiz_options (id, question_id, content, is_correct, order_index) VALUES (131, 38, 'Spring Boot Restart', false, 3);
INSERT INTO public.quiz_options (id, question_id, content, is_correct, order_index) VALUES (132, 39, 'Quản lý Dependency Injection', false, 1);
INSERT INTO public.quiz_options (id, question_id, content, is_correct, order_index) VALUES (133, 39, 'Giám sát (Monitor) và quản lý ứng dụng trên môi trường Production', true, 2);
INSERT INTO public.quiz_options (id, question_id, content, is_correct, order_index) VALUES (134, 39, 'Kết nối tới cơ sở dữ liệu', false, 3);
INSERT INTO public.quiz_options (id, question_id, content, is_correct, order_index) VALUES (135, 40, '8080', true, 1);
INSERT INTO public.quiz_options (id, question_id, content, is_correct, order_index) VALUES (136, 40, '3000', false, 2);
INSERT INTO public.quiz_options (id, question_id, content, is_correct, order_index) VALUES (137, 40, '80', false, 3);
INSERT INTO public.quiz_options (id, question_id, content, is_correct, order_index) VALUES (138, 41, 'app.server.port', false, 1);
INSERT INTO public.quiz_options (id, question_id, content, is_correct, order_index) VALUES (139, 41, 'server.port', true, 2);
INSERT INTO public.quiz_options (id, question_id, content, is_correct, order_index) VALUES (140, 41, 'spring.port', false, 3);
INSERT INTO public.quiz_options (id, question_id, content, is_correct, order_index) VALUES (141, 42, 'Đúng, Spring Boot không hỗ trợ XML nữa.', false, 1);
INSERT INTO public.quiz_options (id, question_id, content, is_correct, order_index) VALUES (142, 42, 'Sai, Spring Boot ưu tiên cấu hình bằng Java/Annotation nhưng vẫn hỗ trợ XML nếu cần.', true, 2);


--
-- TOC entry 5631 (class 0 OID 17300)
-- Dependencies: 252
-- Data for Name: quiz_questions; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.quiz_questions (id, quiz_id, question_content, order_index) VALUES (1, 1, 'Trong kiến trúc 3 layer của Spring Boot, tầng nào chịu trách nhiệm tiếp nhận và phản hồi các HTTP Request?', 1);
INSERT INTO public.quiz_questions (id, quiz_id, question_content, order_index) VALUES (2, 1, 'Logic nghiệp vụ (Business Logic) cốt lõi của ứng dụng nên được đặt ở tầng nào?', 2);
INSERT INTO public.quiz_questions (id, quiz_id, question_content, order_index) VALUES (3, 1, 'Tầng Repository (Data Access Layer) có nhiệm vụ chính là gì?', 3);
INSERT INTO public.quiz_questions (id, quiz_id, question_content, order_index) VALUES (4, 1, 'Annotation nào sau đây KHÔNG dùng để đánh dấu một Bean trong Spring framework?', 4);
INSERT INTO public.quiz_questions (id, quiz_id, question_content, order_index) VALUES (5, 1, 'Đối tượng DTO (Data Transfer Object) thường được sử dụng ở ranh giới giữa các tầng nào?', 5);
INSERT INTO public.quiz_questions (id, quiz_id, question_content, order_index) VALUES (6, 1, 'Sự khác biệt chính giữa @Controller và @RestController là gì?', 6);
INSERT INTO public.quiz_questions (id, quiz_id, question_content, order_index) VALUES (7, 1, 'Tại sao KHÔNG NÊN gọi trực tiếp Repository từ Controller?', 7);
INSERT INTO public.quiz_questions (id, quiz_id, question_content, order_index) VALUES (8, 1, 'Khi cần thực hiện một giao dịch (Transaction) liên quan đến nhiều thao tác CSDL, ta nên đặt @Transactional ở đâu?', 8);
INSERT INTO public.quiz_questions (id, quiz_id, question_content, order_index) VALUES (9, 1, 'Spring Data JPA thuộc về tầng nào trong mô hình 3 Layer?', 9);
INSERT INTO public.quiz_questions (id, quiz_id, question_content, order_index) VALUES (10, 1, 'Dependency Injection (DI) thường được sử dụng như thế nào giữa các layer?', 10);
INSERT INTO public.quiz_questions (id, quiz_id, question_content, order_index) VALUES (11, 2, 'Ký hiệu Big O (O-lớn) chủ yếu được sử dụng để mô tả điều gì?', 1);
INSERT INTO public.quiz_questions (id, quiz_id, question_content, order_index) VALUES (12, 2, 'Độ phức tạp thời gian O(1) có nghĩa là gì?', 2);
INSERT INTO public.quiz_questions (id, quiz_id, question_content, order_index) VALUES (13, 2, 'Việc truy cập một phần tử trong mảng bằng chỉ số (index) có độ phức tạp thời gian là bao nhiêu?', 3);
INSERT INTO public.quiz_questions (id, quiz_id, question_content, order_index) VALUES (14, 2, 'Độ phức tạp thời gian của vòng lặp duyệt qua toàn bộ N phần tử của một mảng là?', 4);
INSERT INTO public.quiz_questions (id, quiz_id, question_content, order_index) VALUES (15, 2, 'Tìm kiếm nhị phân (Binary Search) trên một mảng đã sắp xếp có độ phức tạp thời gian là?', 5);
INSERT INTO public.quiz_questions (id, quiz_id, question_content, order_index) VALUES (16, 2, 'Đoạn code có 2 vòng lặp lồng nhau (vòng lặp i từ 0 đến N, vòng lặp j từ 0 đến N) có Time Complexity là?', 6);
INSERT INTO public.quiz_questions (id, quiz_id, question_content, order_index) VALUES (17, 2, 'Space Complexity (Độ phức tạp không gian) đánh giá yếu tố nào?', 7);
INSERT INTO public.quiz_questions (id, quiz_id, question_content, order_index) VALUES (18, 2, 'Thuật toán nào sau đây có hiệu năng tốt nhất khi N tiến tới vô cùng?', 8);
INSERT INTO public.quiz_questions (id, quiz_id, question_content, order_index) VALUES (19, 2, 'Nếu một thuật toán loại bỏ một nửa số lượng dữ liệu sau mỗi bước (như chia để trị), độ phức tạp của nó thường là:', 9);
INSERT INTO public.quiz_questions (id, quiz_id, question_content, order_index) VALUES (20, 2, 'Khi đánh giá Big O, chúng ta thường quan tâm đến trường hợp nào nhất?', 10);
INSERT INTO public.quiz_questions (id, quiz_id, question_content, order_index) VALUES (33, 4, 'Spring Boot là gì?', 1);
INSERT INTO public.quiz_questions (id, quiz_id, question_content, order_index) VALUES (34, 4, 'Đâu là annotation đánh dấu điểm bắt đầu của một ứng dụng Spring Boot?', 2);
INSERT INTO public.quiz_questions (id, quiz_id, question_content, order_index) VALUES (35, 4, 'Web Server mặc định được nhúng (embedded) trong Spring Boot Web là gì?', 3);
INSERT INTO public.quiz_questions (id, quiz_id, question_content, order_index) VALUES (36, 4, 'Dependency nào cần thiết để phát triển RESTful API trong Spring Boot?', 4);
INSERT INTO public.quiz_questions (id, quiz_id, question_content, order_index) VALUES (37, 4, 'Tên file cấu hình mặc định của Spring Boot là gì?', 5);
INSERT INTO public.quiz_questions (id, quiz_id, question_content, order_index) VALUES (38, 4, 'Công cụ nào trong Spring Boot giúp tự động restart server khi có thay đổi code?', 6);
INSERT INTO public.quiz_questions (id, quiz_id, question_content, order_index) VALUES (39, 4, 'Spring Boot Actuator dùng để làm gì?', 7);
INSERT INTO public.quiz_questions (id, quiz_id, question_content, order_index) VALUES (40, 4, 'Cổng (Port) mặc định của một ứng dụng Spring Boot Web là bao nhiêu?', 8);
INSERT INTO public.quiz_questions (id, quiz_id, question_content, order_index) VALUES (41, 4, 'Để thay đổi port mặc định, bạn dùng thuộc tính nào trong file cấu hình?', 9);
INSERT INTO public.quiz_questions (id, quiz_id, question_content, order_index) VALUES (42, 4, 'Spring Boot loại bỏ hoàn toàn việc sử dụng file XML để cấu hình. Đúng hay Sai?', 10);


--
-- TOC entry 5629 (class 0 OID 17270)
-- Dependencies: 250
-- Data for Name: quizzes; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.quizzes (id, lesson_id, title, description, created_by_teacher_id, created_at, updated_at, is_deleted) VALUES (1, 4, 'Quiz: Cấu trúc 3 Layer trong Spring Boot', 'Kiểm tra kiến thức về Controller, Service, Repository và luồng đi của dữ liệu.', 1, '2026-05-04 02:24:19.271427+07', '2026-05-04 02:24:19.271427+07', false);
INSERT INTO public.quizzes (id, lesson_id, title, description, created_by_teacher_id, created_at, updated_at, is_deleted) VALUES (2, 7, 'Quiz: Phân tích độ phức tạp Big O', 'Đánh giá khả năng tính toán Time Complexity và Space Complexity của thuật toán cơ bản.', 1, '2026-05-04 02:24:19.271427+07', '2026-05-04 02:24:19.271427+07', false);
INSERT INTO public.quizzes (id, lesson_id, title, description, created_by_teacher_id, created_at, updated_at, is_deleted) VALUES (3, 1, 'Bài kiểm tra: Giới thiệu khóa học Spring Boot (Đã được Update)', 'Bài trắc nghiệm đã được chỉnh sửa để test API Update.', 1, '2026-05-12 20:49:27.620061+07', '2026-05-13 17:34:51.279664+07', true);
INSERT INTO public.quizzes (id, lesson_id, title, description, created_by_teacher_id, created_at, updated_at, is_deleted) VALUES (4, 1, 'Bài kiểm tra: Giới thiệu khóa học Spring Boot', 'Bài trắc nghiệm đánh giá kiến thức tổng quan về Spring Boot và các khái niệm cơ bản.', 1, '2026-05-13 17:35:24.497422+07', '2026-05-13 17:35:24.497422+07', false);


--
-- TOC entry 5609 (class 0 OID 17010)
-- Dependencies: 230
-- Data for Name: refresh_tokens; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 5605 (class 0 OID 16972)
-- Dependencies: 226
-- Data for Name: role_permissions; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.role_permissions (role_id, permission_id) VALUES (1, 1);
INSERT INTO public.role_permissions (role_id, permission_id) VALUES (1, 2);
INSERT INTO public.role_permissions (role_id, permission_id) VALUES (1, 3);
INSERT INTO public.role_permissions (role_id, permission_id) VALUES (1, 4);
INSERT INTO public.role_permissions (role_id, permission_id) VALUES (1, 5);
INSERT INTO public.role_permissions (role_id, permission_id) VALUES (1, 28);
INSERT INTO public.role_permissions (role_id, permission_id) VALUES (1, 29);
INSERT INTO public.role_permissions (role_id, permission_id) VALUES (1, 30);
INSERT INTO public.role_permissions (role_id, permission_id) VALUES (1, 31);
INSERT INTO public.role_permissions (role_id, permission_id) VALUES (1, 32);
INSERT INTO public.role_permissions (role_id, permission_id) VALUES (1, 33);
INSERT INTO public.role_permissions (role_id, permission_id) VALUES (1, 34);
INSERT INTO public.role_permissions (role_id, permission_id) VALUES (1, 37);
INSERT INTO public.role_permissions (role_id, permission_id) VALUES (1, 38);
INSERT INTO public.role_permissions (role_id, permission_id) VALUES (1, 39);
INSERT INTO public.role_permissions (role_id, permission_id) VALUES (1, 43);
INSERT INTO public.role_permissions (role_id, permission_id) VALUES (1, 44);
INSERT INTO public.role_permissions (role_id, permission_id) VALUES (1, 45);
INSERT INTO public.role_permissions (role_id, permission_id) VALUES (1, 51);
INSERT INTO public.role_permissions (role_id, permission_id) VALUES (1, 52);
INSERT INTO public.role_permissions (role_id, permission_id) VALUES (1, 53);
INSERT INTO public.role_permissions (role_id, permission_id) VALUES (1, 60);
INSERT INTO public.role_permissions (role_id, permission_id) VALUES (1, 61);
INSERT INTO public.role_permissions (role_id, permission_id) VALUES (1, 63);
INSERT INTO public.role_permissions (role_id, permission_id) VALUES (1, 64);
INSERT INTO public.role_permissions (role_id, permission_id) VALUES (1, 65);
INSERT INTO public.role_permissions (role_id, permission_id) VALUES (1, 66);
INSERT INTO public.role_permissions (role_id, permission_id) VALUES (1, 67);
INSERT INTO public.role_permissions (role_id, permission_id) VALUES (1, 68);
INSERT INTO public.role_permissions (role_id, permission_id) VALUES (2, 2);
INSERT INTO public.role_permissions (role_id, permission_id) VALUES (2, 3);
INSERT INTO public.role_permissions (role_id, permission_id) VALUES (2, 4);
INSERT INTO public.role_permissions (role_id, permission_id) VALUES (2, 5);
INSERT INTO public.role_permissions (role_id, permission_id) VALUES (2, 17);
INSERT INTO public.role_permissions (role_id, permission_id) VALUES (2, 35);
INSERT INTO public.role_permissions (role_id, permission_id) VALUES (2, 37);
INSERT INTO public.role_permissions (role_id, permission_id) VALUES (2, 40);
INSERT INTO public.role_permissions (role_id, permission_id) VALUES (2, 41);
INSERT INTO public.role_permissions (role_id, permission_id) VALUES (2, 42);
INSERT INTO public.role_permissions (role_id, permission_id) VALUES (2, 43);
INSERT INTO public.role_permissions (role_id, permission_id) VALUES (2, 46);
INSERT INTO public.role_permissions (role_id, permission_id) VALUES (2, 47);
INSERT INTO public.role_permissions (role_id, permission_id) VALUES (2, 48);
INSERT INTO public.role_permissions (role_id, permission_id) VALUES (2, 49);
INSERT INTO public.role_permissions (role_id, permission_id) VALUES (2, 50);
INSERT INTO public.role_permissions (role_id, permission_id) VALUES (2, 51);
INSERT INTO public.role_permissions (role_id, permission_id) VALUES (2, 54);
INSERT INTO public.role_permissions (role_id, permission_id) VALUES (2, 55);
INSERT INTO public.role_permissions (role_id, permission_id) VALUES (2, 56);
INSERT INTO public.role_permissions (role_id, permission_id) VALUES (2, 57);
INSERT INTO public.role_permissions (role_id, permission_id) VALUES (2, 58);
INSERT INTO public.role_permissions (role_id, permission_id) VALUES (2, 59);
INSERT INTO public.role_permissions (role_id, permission_id) VALUES (2, 60);
INSERT INTO public.role_permissions (role_id, permission_id) VALUES (2, 62);
INSERT INTO public.role_permissions (role_id, permission_id) VALUES (2, 63);
INSERT INTO public.role_permissions (role_id, permission_id) VALUES (2, 64);
INSERT INTO public.role_permissions (role_id, permission_id) VALUES (2, 69);
INSERT INTO public.role_permissions (role_id, permission_id) VALUES (2, 70);
INSERT INTO public.role_permissions (role_id, permission_id) VALUES (2, 71);
INSERT INTO public.role_permissions (role_id, permission_id) VALUES (2, 72);
INSERT INTO public.role_permissions (role_id, permission_id) VALUES (2, 73);
INSERT INTO public.role_permissions (role_id, permission_id) VALUES (2, 74);
INSERT INTO public.role_permissions (role_id, permission_id) VALUES (2, 75);
INSERT INTO public.role_permissions (role_id, permission_id) VALUES (3, 1);
INSERT INTO public.role_permissions (role_id, permission_id) VALUES (3, 2);
INSERT INTO public.role_permissions (role_id, permission_id) VALUES (3, 3);
INSERT INTO public.role_permissions (role_id, permission_id) VALUES (3, 4);
INSERT INTO public.role_permissions (role_id, permission_id) VALUES (3, 5);
INSERT INTO public.role_permissions (role_id, permission_id) VALUES (3, 6);
INSERT INTO public.role_permissions (role_id, permission_id) VALUES (3, 7);
INSERT INTO public.role_permissions (role_id, permission_id) VALUES (3, 8);
INSERT INTO public.role_permissions (role_id, permission_id) VALUES (3, 9);
INSERT INTO public.role_permissions (role_id, permission_id) VALUES (3, 10);
INSERT INTO public.role_permissions (role_id, permission_id) VALUES (3, 11);
INSERT INTO public.role_permissions (role_id, permission_id) VALUES (3, 12);
INSERT INTO public.role_permissions (role_id, permission_id) VALUES (3, 13);
INSERT INTO public.role_permissions (role_id, permission_id) VALUES (3, 14);
INSERT INTO public.role_permissions (role_id, permission_id) VALUES (3, 15);
INSERT INTO public.role_permissions (role_id, permission_id) VALUES (3, 16);
INSERT INTO public.role_permissions (role_id, permission_id) VALUES (3, 17);
INSERT INTO public.role_permissions (role_id, permission_id) VALUES (3, 18);
INSERT INTO public.role_permissions (role_id, permission_id) VALUES (3, 19);
INSERT INTO public.role_permissions (role_id, permission_id) VALUES (3, 20);
INSERT INTO public.role_permissions (role_id, permission_id) VALUES (3, 21);
INSERT INTO public.role_permissions (role_id, permission_id) VALUES (3, 22);
INSERT INTO public.role_permissions (role_id, permission_id) VALUES (3, 23);
INSERT INTO public.role_permissions (role_id, permission_id) VALUES (3, 24);
INSERT INTO public.role_permissions (role_id, permission_id) VALUES (3, 25);
INSERT INTO public.role_permissions (role_id, permission_id) VALUES (3, 26);
INSERT INTO public.role_permissions (role_id, permission_id) VALUES (3, 27);
INSERT INTO public.role_permissions (role_id, permission_id) VALUES (3, 28);
INSERT INTO public.role_permissions (role_id, permission_id) VALUES (3, 29);
INSERT INTO public.role_permissions (role_id, permission_id) VALUES (3, 30);
INSERT INTO public.role_permissions (role_id, permission_id) VALUES (3, 31);
INSERT INTO public.role_permissions (role_id, permission_id) VALUES (3, 32);
INSERT INTO public.role_permissions (role_id, permission_id) VALUES (3, 33);
INSERT INTO public.role_permissions (role_id, permission_id) VALUES (3, 34);
INSERT INTO public.role_permissions (role_id, permission_id) VALUES (3, 35);
INSERT INTO public.role_permissions (role_id, permission_id) VALUES (3, 36);
INSERT INTO public.role_permissions (role_id, permission_id) VALUES (3, 37);
INSERT INTO public.role_permissions (role_id, permission_id) VALUES (3, 38);
INSERT INTO public.role_permissions (role_id, permission_id) VALUES (3, 39);
INSERT INTO public.role_permissions (role_id, permission_id) VALUES (3, 40);
INSERT INTO public.role_permissions (role_id, permission_id) VALUES (3, 41);
INSERT INTO public.role_permissions (role_id, permission_id) VALUES (3, 42);
INSERT INTO public.role_permissions (role_id, permission_id) VALUES (3, 43);
INSERT INTO public.role_permissions (role_id, permission_id) VALUES (3, 44);
INSERT INTO public.role_permissions (role_id, permission_id) VALUES (3, 45);
INSERT INTO public.role_permissions (role_id, permission_id) VALUES (3, 46);
INSERT INTO public.role_permissions (role_id, permission_id) VALUES (3, 47);
INSERT INTO public.role_permissions (role_id, permission_id) VALUES (3, 48);
INSERT INTO public.role_permissions (role_id, permission_id) VALUES (3, 49);
INSERT INTO public.role_permissions (role_id, permission_id) VALUES (3, 50);
INSERT INTO public.role_permissions (role_id, permission_id) VALUES (3, 51);
INSERT INTO public.role_permissions (role_id, permission_id) VALUES (3, 52);
INSERT INTO public.role_permissions (role_id, permission_id) VALUES (3, 53);
INSERT INTO public.role_permissions (role_id, permission_id) VALUES (3, 54);
INSERT INTO public.role_permissions (role_id, permission_id) VALUES (3, 55);
INSERT INTO public.role_permissions (role_id, permission_id) VALUES (3, 56);
INSERT INTO public.role_permissions (role_id, permission_id) VALUES (3, 57);
INSERT INTO public.role_permissions (role_id, permission_id) VALUES (3, 58);
INSERT INTO public.role_permissions (role_id, permission_id) VALUES (3, 59);
INSERT INTO public.role_permissions (role_id, permission_id) VALUES (3, 60);
INSERT INTO public.role_permissions (role_id, permission_id) VALUES (3, 61);
INSERT INTO public.role_permissions (role_id, permission_id) VALUES (3, 62);
INSERT INTO public.role_permissions (role_id, permission_id) VALUES (3, 63);
INSERT INTO public.role_permissions (role_id, permission_id) VALUES (3, 64);
INSERT INTO public.role_permissions (role_id, permission_id) VALUES (3, 65);
INSERT INTO public.role_permissions (role_id, permission_id) VALUES (3, 66);
INSERT INTO public.role_permissions (role_id, permission_id) VALUES (3, 67);
INSERT INTO public.role_permissions (role_id, permission_id) VALUES (3, 68);
INSERT INTO public.role_permissions (role_id, permission_id) VALUES (3, 69);
INSERT INTO public.role_permissions (role_id, permission_id) VALUES (3, 70);
INSERT INTO public.role_permissions (role_id, permission_id) VALUES (3, 71);
INSERT INTO public.role_permissions (role_id, permission_id) VALUES (3, 72);
INSERT INTO public.role_permissions (role_id, permission_id) VALUES (3, 73);
INSERT INTO public.role_permissions (role_id, permission_id) VALUES (3, 74);
INSERT INTO public.role_permissions (role_id, permission_id) VALUES (3, 75);
INSERT INTO public.role_permissions (role_id, permission_id) VALUES (3, 76);
INSERT INTO public.role_permissions (role_id, permission_id) VALUES (3, 77);
INSERT INTO public.role_permissions (role_id, permission_id) VALUES (3, 78);
INSERT INTO public.role_permissions (role_id, permission_id) VALUES (3, 79);
INSERT INTO public.role_permissions (role_id, permission_id) VALUES (3, 80);


--
-- TOC entry 5601 (class 0 OID 16932)
-- Dependencies: 222
-- Data for Name: roles; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.roles (id, name) VALUES (1, 'USER');
INSERT INTO public.roles (id, name) VALUES (2, 'TEACHER');
INSERT INTO public.roles (id, name) VALUES (3, 'ADMIN');


--
-- TOC entry 5619 (class 0 OID 17125)
-- Dependencies: 240
-- Data for Name: teacher_course_assignments; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.teacher_course_assignments (id, teacher_id, course_id, assigned_by_admin_id, assigned_at) VALUES (3, 1, 1, 1, '2026-05-02 02:40:24.740769+07');


--
-- TOC entry 5611 (class 0 OID 17030)
-- Dependencies: 232
-- Data for Name: teachers; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.teachers (id, user_id, status, created_at, updated_at, full_name, headline, bio) VALUES (1, 6, 'ACTIVE', '2026-05-02 02:38:03.029631+07', '2026-05-02 02:38:03.029631+07', 'Vo Ngoc Thanh', 'Lecturer at FPT University', 'Experience like shit');
INSERT INTO public.teachers (id, user_id, status, created_at, updated_at, full_name, headline, bio) VALUES (2, 7, 'ACTIVE', '2026-05-05 03:12:06.140207+07', '2026-05-05 03:12:06.140207+07', 'Thằng Loz Nào', 'Giáo viên tự phong', 'Dell có kinh nghiệm');


--
-- TOC entry 5604 (class 0 OID 16955)
-- Dependencies: 225
-- Data for Name: user_roles; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.user_roles (user_id, role_id) VALUES (1, 3);
INSERT INTO public.user_roles (user_id, role_id) VALUES (2, 1);
INSERT INTO public.user_roles (user_id, role_id) VALUES (5, 1);
INSERT INTO public.user_roles (user_id, role_id) VALUES (6, 2);
INSERT INTO public.user_roles (user_id, role_id) VALUES (7, 2);


--
-- TOC entry 5599 (class 0 OID 16907)
-- Dependencies: 220
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.users (id, username, email, password_hash, display_name, phone_number, status, created_at, updated_at) VALUES (1, 'admin', 'admin@gmail.com', '$2a$10$TrvQZX9AXxeh1thqi95kx.C34879B0NsShE8rW/KVCq0nxP/vF7KG', 'admin', '9999999999', 'ACTIVE', '2026-04-29 14:40:51.946069+07', '2026-04-29 14:40:51.946069+07');
INSERT INTO public.users (id, username, email, password_hash, display_name, phone_number, status, created_at, updated_at) VALUES (5, 'user2', 'user2@gmail.com', '$2a$10$sm0UK3aZaysr3E0eTlUx7OFnUuixyFYi./8kJHAImS0KrHGjwfmyi', 'user2', '0666666666', 'ACTIVE', '2026-04-29 17:18:54.869243+07', '2026-04-29 17:19:25.697167+07');
INSERT INTO public.users (id, username, email, password_hash, display_name, phone_number, status, created_at, updated_at) VALUES (2, 'user1', 'user1@gmail.com', '$2a$10$UfohPV20BWG9s8bsh4XcC..YCXYRsTFxFUcvVwMQjgu7uD.qOnMh2', 'thanhmila', '0763769325', 'ACTIVE', '2026-04-29 17:06:56.181225+07', '2026-04-30 01:51:51.212583+07');
INSERT INTO public.users (id, username, email, password_hash, display_name, phone_number, status, created_at, updated_at) VALUES (6, 'teacher', 'teacher@gmailcom', '$2a$10$wLOCZ9M5DXa2fBCKe7XNv.84vA56W63DiEpdAxTnpdECKbdYbSPvu', 'teacher', '0666666666', 'ACTIVE', '2026-05-02 02:33:59.845941+07', '2026-05-02 02:33:59.845941+07');
INSERT INTO public.users (id, username, email, password_hash, display_name, phone_number, status, created_at, updated_at) VALUES (7, 'user3', 'user3@gmailcom', '$2a$10$d.8pz8mWscFtU9MFoYLijux7JKHIUX.YTalo9PUghxO.UDvoLlUjW', 'teacher', '0666666666', 'ACTIVE', '2026-05-04 02:27:28.412927+07', '2026-05-05 03:10:43.403894+07');


--
-- TOC entry 5706 (class 0 OID 0)
-- Dependencies: 281
-- Name: categories_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.categories_id_seq', 19, true);


--
-- TOC entry 5707 (class 0 OID 0)
-- Dependencies: 235
-- Name: chapters_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.chapters_id_seq', 10, true);


--
-- TOC entry 5708 (class 0 OID 0)
-- Dependencies: 247
-- Name: completed_lessons_count_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.completed_lessons_count_id_seq', 6, true);


--
-- TOC entry 5709 (class 0 OID 0)
-- Dependencies: 279
-- Name: contest_participants_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.contest_participants_id_seq', 1, false);


--
-- TOC entry 5710 (class 0 OID 0)
-- Dependencies: 277
-- Name: contest_problems_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.contest_problems_id_seq', 1, false);


--
-- TOC entry 5711 (class 0 OID 0)
-- Dependencies: 265
-- Name: contests_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.contests_id_seq', 1, false);


--
-- TOC entry 5712 (class 0 OID 0)
-- Dependencies: 275
-- Name: course_reviews_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.course_reviews_id_seq', 5, true);


--
-- TOC entry 5713 (class 0 OID 0)
-- Dependencies: 233
-- Name: courses_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.courses_id_seq', 5, true);


--
-- TOC entry 5714 (class 0 OID 0)
-- Dependencies: 243
-- Name: enrollments_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.enrollments_id_seq', 6, true);


--
-- TOC entry 5715 (class 0 OID 0)
-- Dependencies: 269
-- Name: file_assignments_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.file_assignments_id_seq', 1, false);


--
-- TOC entry 5716 (class 0 OID 0)
-- Dependencies: 271
-- Name: file_submissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.file_submissions_id_seq', 1, false);


--
-- TOC entry 5717 (class 0 OID 0)
-- Dependencies: 227
-- Name: invalidated_tokens_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.invalidated_tokens_id_seq', 19, true);


--
-- TOC entry 5718 (class 0 OID 0)
-- Dependencies: 273
-- Name: lesson_comments_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.lesson_comments_id_seq', 9, true);


--
-- TOC entry 5719 (class 0 OID 0)
-- Dependencies: 245
-- Name: lesson_progress_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.lesson_progress_id_seq', 3, true);


--
-- TOC entry 5720 (class 0 OID 0)
-- Dependencies: 237
-- Name: lessons_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.lessons_id_seq', 15, true);


--
-- TOC entry 5721 (class 0 OID 0)
-- Dependencies: 257
-- Name: online_judge_problems_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.online_judge_problems_id_seq', 3, true);


--
-- TOC entry 5722 (class 0 OID 0)
-- Dependencies: 286
-- Name: online_judge_submission_details_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.online_judge_submission_details_id_seq', 1, false);


--
-- TOC entry 5723 (class 0 OID 0)
-- Dependencies: 267
-- Name: online_judge_submissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.online_judge_submissions_id_seq', 3, true);


--
-- TOC entry 5724 (class 0 OID 0)
-- Dependencies: 241
-- Name: payments_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.payments_id_seq', 6, true);


--
-- TOC entry 5725 (class 0 OID 0)
-- Dependencies: 223
-- Name: permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.permissions_id_seq', 80, true);


--
-- TOC entry 5726 (class 0 OID 0)
-- Dependencies: 261
-- Name: problem_tag_mappings_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.problem_tag_mappings_id_seq', 6, true);


--
-- TOC entry 5727 (class 0 OID 0)
-- Dependencies: 259
-- Name: problem_tags_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.problem_tags_id_seq', 4, true);


--
-- TOC entry 5728 (class 0 OID 0)
-- Dependencies: 263
-- Name: problem_testcases_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.problem_testcases_id_seq', 7, true);


--
-- TOC entry 5729 (class 0 OID 0)
-- Dependencies: 284
-- Name: quiz_attempt_answers_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.quiz_attempt_answers_id_seq', 20, true);


--
-- TOC entry 5730 (class 0 OID 0)
-- Dependencies: 255
-- Name: quiz_attempts_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.quiz_attempts_id_seq', 2, true);


--
-- TOC entry 5731 (class 0 OID 0)
-- Dependencies: 253
-- Name: quiz_options_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.quiz_options_id_seq', 142, true);


--
-- TOC entry 5732 (class 0 OID 0)
-- Dependencies: 251
-- Name: quiz_questions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.quiz_questions_id_seq', 42, true);


--
-- TOC entry 5733 (class 0 OID 0)
-- Dependencies: 249
-- Name: quizzes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.quizzes_id_seq', 4, true);


--
-- TOC entry 5734 (class 0 OID 0)
-- Dependencies: 229
-- Name: refresh_tokens_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.refresh_tokens_id_seq', 1, false);


--
-- TOC entry 5735 (class 0 OID 0)
-- Dependencies: 221
-- Name: roles_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.roles_id_seq', 3, true);


--
-- TOC entry 5736 (class 0 OID 0)
-- Dependencies: 239
-- Name: teacher_course_assignments_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.teacher_course_assignments_id_seq', 3, true);


--
-- TOC entry 5737 (class 0 OID 0)
-- Dependencies: 231
-- Name: teachers_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.teachers_id_seq', 2, true);


--
-- TOC entry 5738 (class 0 OID 0)
-- Dependencies: 219
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.users_id_seq', 7, true);


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


-- Completed on 2026-05-15 12:35:09

--
-- PostgreSQL database dump complete
--

\unrestrict paUpqyExzSivdB5D6UweW6UNP3zAdKukn3rgqI4oSO9zONK8itVNzueQfEIRXp3

