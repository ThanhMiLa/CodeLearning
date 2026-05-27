--
-- PostgreSQL database dump
--

\restrict eh9aZ505qjye1DljdiNNWA1U0uTOBbIVxhJf2f81Egrlka3aufvPvBqtMXm3aLf

-- Dumped from database version 18.1
-- Dumped by pg_dump version 18.1

-- Started on 2026-05-26 17:54:19

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
-- TOC entry 5763 (class 1262 OID 16800)
-- Name: CodeLearning; Type: DATABASE; Schema: -; Owner: postgres
--

CREATE DATABASE "CodeLearning" WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'English_United States.1252';


ALTER DATABASE "CodeLearning" OWNER TO postgres;

\unrestrict eh9aZ505qjye1DljdiNNWA1U0uTOBbIVxhJf2f81Egrlka3aufvPvBqtMXm3aLf
\connect "CodeLearning"
\restrict eh9aZ505qjye1DljdiNNWA1U0uTOBbIVxhJf2f81Egrlka3aufvPvBqtMXm3aLf

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
-- Name: public; Type: SCHEMA; Schema: -; Owner: pg_database_owner
--

CREATE SCHEMA public;


ALTER SCHEMA public OWNER TO pg_database_owner;

--
-- TOC entry 5764 (class 0 OID 0)
-- Dependencies: 4
-- Name: SCHEMA public; Type: COMMENT; Schema: -; Owner: pg_database_owner
--

COMMENT ON SCHEMA public IS 'standard public schema';


--
-- TOC entry 944 (class 1247 OID 16842)
-- Name: contest_status; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.contest_status AS ENUM (
    'UPCOMING',
    'RUNNING',
    'ENDED',
    'CANCELLED'
);


ALTER TYPE public.contest_status OWNER TO postgres;

--
-- Name: scoring_rule; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.scoring_rule AS ENUM (
    'ICPC',
    'IOI',
    'CUSTOM'
);


ALTER TYPE public.scoring_rule OWNER TO postgres;

--
-- TOC entry 932 (class 1247 OID 16810)
-- Name: course_status; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.course_status AS ENUM (
    'ACTIVE',
    'INACTIVE',
    'DRAFT'
);


ALTER TYPE public.course_status OWNER TO postgres;

--
-- TOC entry 938 (class 1247 OID 16826)
-- Name: enrollment_status; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.enrollment_status AS ENUM (
    'ACTIVE',
    'CANCELLED',
    'COMPLETED'
);


ALTER TYPE public.enrollment_status OWNER TO postgres;

--
-- TOC entry 953 (class 1247 OID 16892)
-- Name: file_submission_status; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.file_submission_status AS ENUM (
    'SUBMITTED',
    'IN_REVIEW',
    'GRADED',
    'NEEDS_RESUBMISSION',
    'REPLACED',
    'RESUBMITTED'
);


ALTER TYPE public.file_submission_status OWNER TO postgres;

--
-- TOC entry 935 (class 1247 OID 16818)
-- Name: lesson_status; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.lesson_status AS ENUM (
    'ACTIVE',
    'INACTIVE',
    'DRAFT'
);


ALTER TYPE public.lesson_status OWNER TO postgres;

--
-- TOC entry 1058 (class 1247 OID 17908)
-- Name: oj_verdict; Type: TYPE; Schema: public; Owner: postgres
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


ALTER TYPE public.oj_verdict OWNER TO postgres;

--
-- TOC entry 1085 (class 1247 OID 18187)
-- Name: order_status; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.order_status AS ENUM (
    'PENDING',
    'COMPLETED',
    'CANCELLED',
    'FAILED'
);


ALTER TYPE public.order_status OWNER TO postgres;

--
-- TOC entry 1067 (class 1247 OID 18002)
-- Name: payment_transaction_type; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.payment_transaction_type AS ENUM (
    'DEPOSIT',
    'WITHDRAW'
);


ALTER TYPE public.payment_transaction_type OWNER TO postgres;

--
-- TOC entry 950 (class 1247 OID 16860)
-- Name: problem_difficulty; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.problem_difficulty AS ENUM (
    'EASY',
    'MEDIUM',
    'HARD'
);


ALTER TYPE public.problem_difficulty OWNER TO postgres;

--
-- TOC entry 947 (class 1247 OID 16852)
-- Name: problem_scope; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.problem_scope AS ENUM (
    'LESSON',
    'CONTEST',
    'SHARED',
    'PRACTICE'
);


ALTER TYPE public.problem_scope OWNER TO postgres;

--
-- TOC entry 941 (class 1247 OID 16834)
-- Name: teacher_status; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.teacher_status AS ENUM (
    'ACTIVE',
    'INACTIVE',
    'LOCKED'
);


ALTER TYPE public.teacher_status OWNER TO postgres;

--
-- TOC entry 1073 (class 1247 OID 18020)
-- Name: transaction_status; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.transaction_status AS ENUM (
    'PENDING',
    'SUCCESS',
    'FAILED',
    'CANCELLED'
);


ALTER TYPE public.transaction_status OWNER TO postgres;

--
-- TOC entry 929 (class 1247 OID 16802)
-- Name: user_status; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.user_status AS ENUM (
    'ACTIVE',
    'LOCKED',
    'DISABLED'
);


ALTER TYPE public.user_status OWNER TO postgres;

--
-- TOC entry 1064 (class 1247 OID 17996)
-- Name: wallet_status; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.wallet_status AS ENUM (
    'ACTIVE',
    'LOCKED'
);


ALTER TYPE public.wallet_status OWNER TO postgres;

--
-- TOC entry 1070 (class 1247 OID 18008)
-- Name: wallet_transaction_type; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.wallet_transaction_type AS ENUM (
    'DEPOSIT',
    'PURCHASE',
    'REWARD',
    'REFUND',
    'WITHDRAW'
);


ALTER TYPE public.wallet_transaction_type OWNER TO postgres;

--
-- TOC entry 296 (class 1255 OID 16905)
-- Name: set_updated_at(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.set_updated_at() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    NEW.updated_at = now();
    RETURN NEW;
END;
$$;


ALTER FUNCTION public.set_updated_at() OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 280 (class 1259 OID 17785)
-- Name: categories; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.categories (
    id bigint NOT NULL,
    name character varying(100) NOT NULL,
    slug character varying(120) NOT NULL,
    description text,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.categories OWNER TO postgres;

--
-- TOC entry 279 (class 1259 OID 17784)
-- Name: categories_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.categories_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.categories_id_seq OWNER TO postgres;

--
-- TOC entry 5765 (class 0 OID 0)
-- Dependencies: 279
-- Name: categories_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.categories_id_seq OWNED BY public.categories.id;


--
-- TOC entry 236 (class 1259 OID 17074)
-- Name: chapters; Type: TABLE; Schema: public; Owner: postgres
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


ALTER TABLE public.chapters OWNER TO postgres;

--
-- TOC entry 235 (class 1259 OID 17073)
-- Name: chapters_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.chapters_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.chapters_id_seq OWNER TO postgres;

--
-- TOC entry 5766 (class 0 OID 0)
-- Dependencies: 235
-- Name: chapters_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.chapters_id_seq OWNED BY public.chapters.id;


--
-- TOC entry 246 (class 1259 OID 17243)
-- Name: completed_lessons_count; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.completed_lessons_count (
    id bigint NOT NULL,
    user_id bigint NOT NULL,
    course_id bigint NOT NULL,
    completed_lessons_count integer DEFAULT 0 NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    CONSTRAINT chk_completed_lessons_count_non_negative CHECK ((completed_lessons_count >= 0))
);


ALTER TABLE public.completed_lessons_count OWNER TO postgres;

--
-- TOC entry 245 (class 1259 OID 17242)
-- Name: completed_lessons_count_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.completed_lessons_count_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.completed_lessons_count_id_seq OWNER TO postgres;

--
-- TOC entry 5767 (class 0 OID 0)
-- Dependencies: 245
-- Name: completed_lessons_count_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.completed_lessons_count_id_seq OWNED BY public.completed_lessons_count.id;


--
-- TOC entry 278 (class 1259 OID 17696)
-- Name: contest_participants; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.contest_participants (
    id bigint NOT NULL,
    contest_id bigint NOT NULL,
    user_id bigint NOT NULL,
    joined_at timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.contest_participants OWNER TO postgres;

--
-- TOC entry 277 (class 1259 OID 17695)
-- Name: contest_participants_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.contest_participants_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.contest_participants_id_seq OWNER TO postgres;

--
-- TOC entry 5768 (class 0 OID 0)
-- Dependencies: 277
-- Name: contest_participants_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.contest_participants_id_seq OWNED BY public.contest_participants.id;


--
-- TOC entry 276 (class 1259 OID 17667)
-- Name: contest_problems; Type: TABLE; Schema: public; Owner: postgres
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


ALTER TABLE public.contest_problems OWNER TO postgres;

--
-- TOC entry 275 (class 1259 OID 17666)
-- Name: contest_problems_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.contest_problems_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.contest_problems_id_seq OWNER TO postgres;

--
-- TOC entry 5769 (class 0 OID 0)
-- Dependencies: 275
-- Name: contest_problems_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.contest_problems_id_seq OWNED BY public.contest_problems.id;


--
-- TOC entry 264 (class 1259 OID 17467)
-- Name: contests; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.contests (
    id bigint NOT NULL,
    title character varying(255) NOT NULL,
    description text,
    password_hash character varying(255),
    start_time timestamp with time zone NOT NULL,
    end_time timestamp with time zone NOT NULL,
    status public.contest_status DEFAULT 'UPCOMING'::public.contest_status NOT NULL,
    scoring_rule public.scoring_rule DEFAULT 'ICPC'::public.scoring_rule NOT NULL,
    created_by_teacher_id bigint NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    CONSTRAINT chk_contests_time_valid CHECK ((end_time > start_time)),
    CONSTRAINT chk_contests_title_not_blank CHECK ((length(TRIM(BOTH FROM title)) > 0))
);


ALTER TABLE public.contests OWNER TO postgres;

--
-- TOC entry 263 (class 1259 OID 17466)
-- Name: contests_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.contests_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.contests_id_seq OWNER TO postgres;

--
-- TOC entry 5770 (class 0 OID 0)
-- Dependencies: 263
-- Name: contests_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.contests_id_seq OWNED BY public.contests.id;


--
-- TOC entry 281 (class 1259 OID 17804)
-- Name: course_category_mappings; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.course_category_mappings (
    course_id bigint NOT NULL,
    category_id bigint NOT NULL
);


ALTER TABLE public.course_category_mappings OWNER TO postgres;

--
-- TOC entry 274 (class 1259 OID 17637)
-- Name: course_reviews; Type: TABLE; Schema: public; Owner: postgres
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


ALTER TABLE public.course_reviews OWNER TO postgres;

--
-- TOC entry 273 (class 1259 OID 17636)
-- Name: course_reviews_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.course_reviews_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.course_reviews_id_seq OWNER TO postgres;

--
-- TOC entry 5771 (class 0 OID 0)
-- Dependencies: 273
-- Name: course_reviews_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.course_reviews_id_seq OWNED BY public.course_reviews.id;


--
-- TOC entry 234 (class 1259 OID 17052)
-- Name: courses; Type: TABLE; Schema: public; Owner: postgres
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


ALTER TABLE public.courses OWNER TO postgres;

--
-- TOC entry 233 (class 1259 OID 17051)
-- Name: courses_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.courses_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.courses_id_seq OWNER TO postgres;

--
-- TOC entry 5772 (class 0 OID 0)
-- Dependencies: 233
-- Name: courses_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.courses_id_seq OWNED BY public.courses.id;


--
-- TOC entry 242 (class 1259 OID 17182)
-- Name: enrollments; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.enrollments (
    id bigint NOT NULL,
    user_id bigint NOT NULL,
    course_id bigint NOT NULL,
    enrolled_at timestamp with time zone DEFAULT now() NOT NULL,
    status public.enrollment_status DEFAULT 'ACTIVE'::public.enrollment_status NOT NULL
);


ALTER TABLE public.enrollments OWNER TO postgres;

--
-- TOC entry 241 (class 1259 OID 17181)
-- Name: enrollments_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.enrollments_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.enrollments_id_seq OWNER TO postgres;

--
-- TOC entry 5773 (class 0 OID 0)
-- Dependencies: 241
-- Name: enrollments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.enrollments_id_seq OWNED BY public.enrollments.id;


--
-- TOC entry 268 (class 1259 OID 17535)
-- Name: file_assignments; Type: TABLE; Schema: public; Owner: postgres
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


ALTER TABLE public.file_assignments OWNER TO postgres;

--
-- TOC entry 267 (class 1259 OID 17534)
-- Name: file_assignments_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.file_assignments_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.file_assignments_id_seq OWNER TO postgres;

--
-- TOC entry 5774 (class 0 OID 0)
-- Dependencies: 267
-- Name: file_assignments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.file_assignments_id_seq OWNED BY public.file_assignments.id;


--
-- TOC entry 270 (class 1259 OID 17563)
-- Name: file_submissions; Type: TABLE; Schema: public; Owner: postgres
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


ALTER TABLE public.file_submissions OWNER TO postgres;

--
-- TOC entry 269 (class 1259 OID 17562)
-- Name: file_submissions_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.file_submissions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.file_submissions_id_seq OWNER TO postgres;

--
-- TOC entry 5775 (class 0 OID 0)
-- Dependencies: 269
-- Name: file_submissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.file_submissions_id_seq OWNED BY public.file_submissions.id;


--
-- TOC entry 228 (class 1259 OID 16990)
-- Name: invalidated_tokens; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.invalidated_tokens (
    id bigint NOT NULL,
    token_jti character varying(255) NOT NULL,
    expiry_time timestamp with time zone NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.invalidated_tokens OWNER TO postgres;

--
-- TOC entry 227 (class 1259 OID 16989)
-- Name: invalidated_tokens_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.invalidated_tokens_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.invalidated_tokens_id_seq OWNER TO postgres;

--
-- TOC entry 5776 (class 0 OID 0)
-- Dependencies: 227
-- Name: invalidated_tokens_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.invalidated_tokens_id_seq OWNED BY public.invalidated_tokens.id;


--
-- TOC entry 272 (class 1259 OID 17603)
-- Name: lesson_comments; Type: TABLE; Schema: public; Owner: postgres
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


ALTER TABLE public.lesson_comments OWNER TO postgres;

--
-- TOC entry 271 (class 1259 OID 17602)
-- Name: lesson_comments_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.lesson_comments_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.lesson_comments_id_seq OWNER TO postgres;

--
-- TOC entry 5777 (class 0 OID 0)
-- Dependencies: 271
-- Name: lesson_comments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.lesson_comments_id_seq OWNED BY public.lesson_comments.id;


--
-- TOC entry 244 (class 1259 OID 17213)
-- Name: lesson_progress; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.lesson_progress (
    id bigint NOT NULL,
    user_id bigint NOT NULL,
    lesson_id bigint NOT NULL,
    course_id bigint NOT NULL,
    completed_at timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.lesson_progress OWNER TO postgres;

--
-- TOC entry 243 (class 1259 OID 17212)
-- Name: lesson_progress_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.lesson_progress_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.lesson_progress_id_seq OWNER TO postgres;

--
-- TOC entry 5778 (class 0 OID 0)
-- Dependencies: 243
-- Name: lesson_progress_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.lesson_progress_id_seq OWNED BY public.lesson_progress.id;


--
-- TOC entry 238 (class 1259 OID 17094)
-- Name: lessons; Type: TABLE; Schema: public; Owner: postgres
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


ALTER TABLE public.lessons OWNER TO postgres;

--
-- TOC entry 237 (class 1259 OID 17093)
-- Name: lessons_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.lessons_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.lessons_id_seq OWNER TO postgres;

--
-- TOC entry 5779 (class 0 OID 0)
-- Dependencies: 237
-- Name: lessons_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.lessons_id_seq OWNED BY public.lessons.id;


--
-- TOC entry 256 (class 1259 OID 17371)
-- Name: online_judge_problems; Type: TABLE; Schema: public; Owner: postgres
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
    contest_id bigint,
    total_testcase integer DEFAULT 0 NOT NULL,
    time_limit_ms integer DEFAULT 2000 NOT NULL,
    memory_limit_kb integer DEFAULT 128000 NOT NULL,
    is_public boolean DEFAULT false NOT NULL,
    total_submissions integer DEFAULT 0 NOT NULL,
    total_accepted integer DEFAULT 0 NOT NULL,
    CONSTRAINT chk_online_judge_problems_scope_contest CHECK ((((problem_scope = 'CONTEST'::public.problem_scope) AND (contest_id IS NOT NULL)) OR (problem_scope <> 'CONTEST'::public.problem_scope))),
    CONSTRAINT chk_online_judge_problems_title_not_blank CHECK ((length(TRIM(BOTH FROM title)) > 0)),
    CONSTRAINT chk_online_judge_problems_total_testcase_non_negative CHECK ((total_testcase >= 0))
);


ALTER TABLE public.online_judge_problems OWNER TO postgres;

--
-- TOC entry 255 (class 1259 OID 17370)
-- Name: online_judge_problems_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.online_judge_problems_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.online_judge_problems_id_seq OWNER TO postgres;

--
-- TOC entry 5780 (class 0 OID 0)
-- Dependencies: 255
-- Name: online_judge_problems_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.online_judge_problems_id_seq OWNED BY public.online_judge_problems.id;


--
-- TOC entry 285 (class 1259 OID 17928)
-- Name: online_judge_submission_details; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.online_judge_submission_details (
    id bigint NOT NULL,
    submission_id bigint NOT NULL,
    testcase_id bigint NOT NULL,
    token character varying(255) NOT NULL,
    verdict public.oj_verdict DEFAULT 'PENDING'::public.oj_verdict NOT NULL,
    execution_time_ms integer,
    memory_used_kb integer,
    created_at timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.online_judge_submission_details OWNER TO postgres;

--
-- TOC entry 284 (class 1259 OID 17927)
-- Name: online_judge_submission_details_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.online_judge_submission_details_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.online_judge_submission_details_id_seq OWNER TO postgres;

--
-- TOC entry 5781 (class 0 OID 0)
-- Dependencies: 284
-- Name: online_judge_submission_details_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.online_judge_submission_details_id_seq OWNED BY public.online_judge_submission_details.id;


--
-- TOC entry 266 (class 1259 OID 17494)
-- Name: online_judge_submissions; Type: TABLE; Schema: public; Owner: postgres
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
    verdict public.oj_verdict DEFAULT 'PENDING'::public.oj_verdict NOT NULL,
    CONSTRAINT chk_online_judge_submissions_context CHECK ((((lesson_id IS NOT NULL) AND (contest_id IS NULL)) OR ((lesson_id IS NULL) AND (contest_id IS NOT NULL)))),
    CONSTRAINT chk_online_judge_submissions_execution_time_non_negative CHECK (((execution_time_ms IS NULL) OR (execution_time_ms >= 0))),
    CONSTRAINT chk_online_judge_submissions_memory_non_negative CHECK (((memory_used_kb IS NULL) OR (memory_used_kb >= 0))),
    CONSTRAINT chk_online_judge_submissions_score_non_negative CHECK (((score IS NULL) OR (score >= (0)::numeric)))
);


ALTER TABLE public.online_judge_submissions OWNER TO postgres;

--
-- TOC entry 265 (class 1259 OID 17493)
-- Name: online_judge_submissions_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.online_judge_submissions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.online_judge_submissions_id_seq OWNER TO postgres;

--
-- TOC entry 5782 (class 0 OID 0)
-- Dependencies: 265
-- Name: online_judge_submissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.online_judge_submissions_id_seq OWNED BY public.online_judge_submissions.id;


--
-- TOC entry 295 (class 1259 OID 18218)
-- Name: order_items; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.order_items (
    id bigint NOT NULL,
    order_id bigint NOT NULL,
    course_id bigint NOT NULL,
    price numeric(12,2) DEFAULT 0 NOT NULL
);


ALTER TABLE public.order_items OWNER TO postgres;

--
-- TOC entry 294 (class 1259 OID 18217)
-- Name: order_items_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.order_items_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.order_items_id_seq OWNER TO postgres;

--
-- TOC entry 5783 (class 0 OID 0)
-- Dependencies: 294
-- Name: order_items_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.order_items_id_seq OWNED BY public.order_items.id;


--
-- TOC entry 293 (class 1259 OID 18196)
-- Name: orders; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.orders (
    id bigint NOT NULL,
    user_id bigint NOT NULL,
    total_amount numeric(12,2) DEFAULT 0 NOT NULL,
    status public.order_status DEFAULT 'PENDING'::public.order_status NOT NULL,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public.orders OWNER TO postgres;

--
-- TOC entry 292 (class 1259 OID 18195)
-- Name: orders_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.orders_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.orders_id_seq OWNER TO postgres;

--
-- TOC entry 5784 (class 0 OID 0)
-- Dependencies: 292
-- Name: orders_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.orders_id_seq OWNED BY public.orders.id;


--
-- TOC entry 289 (class 1259 OID 18055)
-- Name: payment_transactions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.payment_transactions (
    id bigint NOT NULL,
    wallet_id bigint NOT NULL,
    transaction_code character varying(50) NOT NULL,
    amount numeric(12,2) NOT NULL,
    type public.payment_transaction_type NOT NULL,
    status public.transaction_status DEFAULT 'PENDING'::public.transaction_status NOT NULL,
    note text,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.payment_transactions OWNER TO postgres;

--
-- TOC entry 288 (class 1259 OID 18054)
-- Name: payment_transactions_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.payment_transactions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.payment_transactions_id_seq OWNER TO postgres;

--
-- TOC entry 5785 (class 0 OID 0)
-- Dependencies: 288
-- Name: payment_transactions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.payment_transactions_id_seq OWNED BY public.payment_transactions.id;


--
-- TOC entry 224 (class 1259 OID 16944)
-- Name: permissions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.permissions (
    id bigint NOT NULL,
    name character varying(150) NOT NULL,
    CONSTRAINT chk_permissions_name_not_blank CHECK ((length(TRIM(BOTH FROM name)) > 0))
);


ALTER TABLE public.permissions OWNER TO postgres;

--
-- TOC entry 223 (class 1259 OID 16943)
-- Name: permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.permissions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.permissions_id_seq OWNER TO postgres;

--
-- TOC entry 5786 (class 0 OID 0)
-- Dependencies: 223
-- Name: permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.permissions_id_seq OWNED BY public.permissions.id;


--
-- TOC entry 260 (class 1259 OID 17421)
-- Name: problem_tag_mappings; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.problem_tag_mappings (
    id bigint NOT NULL,
    problem_id bigint NOT NULL,
    tag_id bigint NOT NULL
);


ALTER TABLE public.problem_tag_mappings OWNER TO postgres;

--
-- TOC entry 259 (class 1259 OID 17420)
-- Name: problem_tag_mappings_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.problem_tag_mappings_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.problem_tag_mappings_id_seq OWNER TO postgres;

--
-- TOC entry 5787 (class 0 OID 0)
-- Dependencies: 259
-- Name: problem_tag_mappings_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.problem_tag_mappings_id_seq OWNED BY public.problem_tag_mappings.id;


--
-- TOC entry 258 (class 1259 OID 17403)
-- Name: problem_tags; Type: TABLE; Schema: public; Owner: postgres
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


ALTER TABLE public.problem_tags OWNER TO postgres;

--
-- TOC entry 257 (class 1259 OID 17402)
-- Name: problem_tags_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.problem_tags_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.problem_tags_id_seq OWNER TO postgres;

--
-- TOC entry 5788 (class 0 OID 0)
-- Dependencies: 257
-- Name: problem_tags_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.problem_tags_id_seq OWNED BY public.problem_tags.id;


--
-- TOC entry 262 (class 1259 OID 17443)
-- Name: problem_testcases; Type: TABLE; Schema: public; Owner: postgres
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


ALTER TABLE public.problem_testcases OWNER TO postgres;

--
-- TOC entry 261 (class 1259 OID 17442)
-- Name: problem_testcases_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.problem_testcases_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.problem_testcases_id_seq OWNER TO postgres;

--
-- TOC entry 5789 (class 0 OID 0)
-- Dependencies: 261
-- Name: problem_testcases_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.problem_testcases_id_seq OWNED BY public.problem_testcases.id;


--
-- TOC entry 283 (class 1259 OID 17871)
-- Name: quiz_attempt_answers; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.quiz_attempt_answers (
    id bigint NOT NULL,
    attempt_id bigint NOT NULL,
    question_id bigint NOT NULL,
    selected_option_id bigint
);


ALTER TABLE public.quiz_attempt_answers OWNER TO postgres;

--
-- TOC entry 282 (class 1259 OID 17870)
-- Name: quiz_attempt_answers_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.quiz_attempt_answers_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.quiz_attempt_answers_id_seq OWNER TO postgres;

--
-- TOC entry 5790 (class 0 OID 0)
-- Dependencies: 282
-- Name: quiz_attempt_answers_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.quiz_attempt_answers_id_seq OWNED BY public.quiz_attempt_answers.id;


--
-- TOC entry 254 (class 1259 OID 17343)
-- Name: quiz_attempts; Type: TABLE; Schema: public; Owner: postgres
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


ALTER TABLE public.quiz_attempts OWNER TO postgres;

--
-- TOC entry 253 (class 1259 OID 17342)
-- Name: quiz_attempts_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.quiz_attempts_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.quiz_attempts_id_seq OWNER TO postgres;

--
-- TOC entry 5791 (class 0 OID 0)
-- Dependencies: 253
-- Name: quiz_attempts_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.quiz_attempts_id_seq OWNED BY public.quiz_attempts.id;


--
-- TOC entry 252 (class 1259 OID 17322)
-- Name: quiz_options; Type: TABLE; Schema: public; Owner: postgres
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


ALTER TABLE public.quiz_options OWNER TO postgres;

--
-- TOC entry 251 (class 1259 OID 17321)
-- Name: quiz_options_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.quiz_options_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.quiz_options_id_seq OWNER TO postgres;

--
-- TOC entry 5792 (class 0 OID 0)
-- Dependencies: 251
-- Name: quiz_options_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.quiz_options_id_seq OWNED BY public.quiz_options.id;


--
-- TOC entry 250 (class 1259 OID 17300)
-- Name: quiz_questions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.quiz_questions (
    id bigint NOT NULL,
    quiz_id bigint NOT NULL,
    question_content text NOT NULL,
    order_index integer NOT NULL,
    CONSTRAINT chk_quiz_questions_content_not_blank CHECK ((length(TRIM(BOTH FROM question_content)) > 0)),
    CONSTRAINT chk_quiz_questions_order_positive CHECK ((order_index > 0))
);


ALTER TABLE public.quiz_questions OWNER TO postgres;

--
-- TOC entry 249 (class 1259 OID 17299)
-- Name: quiz_questions_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.quiz_questions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.quiz_questions_id_seq OWNER TO postgres;

--
-- TOC entry 5793 (class 0 OID 0)
-- Dependencies: 249
-- Name: quiz_questions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.quiz_questions_id_seq OWNED BY public.quiz_questions.id;


--
-- TOC entry 248 (class 1259 OID 17270)
-- Name: quizzes; Type: TABLE; Schema: public; Owner: postgres
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


ALTER TABLE public.quizzes OWNER TO postgres;

--
-- TOC entry 247 (class 1259 OID 17269)
-- Name: quizzes_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.quizzes_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.quizzes_id_seq OWNER TO postgres;

--
-- TOC entry 5794 (class 0 OID 0)
-- Dependencies: 247
-- Name: quizzes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.quizzes_id_seq OWNED BY public.quizzes.id;


--
-- TOC entry 230 (class 1259 OID 17010)
-- Name: refresh_tokens; Type: TABLE; Schema: public; Owner: postgres
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


ALTER TABLE public.refresh_tokens OWNER TO postgres;

--
-- TOC entry 229 (class 1259 OID 17009)
-- Name: refresh_tokens_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.refresh_tokens_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.refresh_tokens_id_seq OWNER TO postgres;

--
-- TOC entry 5795 (class 0 OID 0)
-- Dependencies: 229
-- Name: refresh_tokens_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.refresh_tokens_id_seq OWNED BY public.refresh_tokens.id;


--
-- TOC entry 226 (class 1259 OID 16972)
-- Name: role_permissions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.role_permissions (
    role_id bigint NOT NULL,
    permission_id bigint NOT NULL
);


ALTER TABLE public.role_permissions OWNER TO postgres;

--
-- TOC entry 222 (class 1259 OID 16932)
-- Name: roles; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.roles (
    id bigint NOT NULL,
    name character varying(100) NOT NULL,
    CONSTRAINT chk_roles_name_not_blank CHECK ((length(TRIM(BOTH FROM name)) > 0))
);


ALTER TABLE public.roles OWNER TO postgres;

--
-- TOC entry 221 (class 1259 OID 16931)
-- Name: roles_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.roles_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.roles_id_seq OWNER TO postgres;

--
-- TOC entry 5796 (class 0 OID 0)
-- Dependencies: 221
-- Name: roles_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.roles_id_seq OWNED BY public.roles.id;


--
-- TOC entry 240 (class 1259 OID 17125)
-- Name: teacher_course_assignments; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.teacher_course_assignments (
    id bigint NOT NULL,
    teacher_id bigint NOT NULL,
    course_id bigint NOT NULL,
    assigned_by_admin_id bigint NOT NULL,
    assigned_at timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.teacher_course_assignments OWNER TO postgres;

--
-- TOC entry 239 (class 1259 OID 17124)
-- Name: teacher_course_assignments_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.teacher_course_assignments_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.teacher_course_assignments_id_seq OWNER TO postgres;

--
-- TOC entry 5797 (class 0 OID 0)
-- Dependencies: 239
-- Name: teacher_course_assignments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.teacher_course_assignments_id_seq OWNED BY public.teacher_course_assignments.id;


--
-- TOC entry 232 (class 1259 OID 17030)
-- Name: teachers; Type: TABLE; Schema: public; Owner: postgres
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


ALTER TABLE public.teachers OWNER TO postgres;

--
-- TOC entry 231 (class 1259 OID 17029)
-- Name: teachers_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.teachers_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.teachers_id_seq OWNER TO postgres;

--
-- TOC entry 5798 (class 0 OID 0)
-- Dependencies: 231
-- Name: teachers_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.teachers_id_seq OWNED BY public.teachers.id;


--
-- TOC entry 225 (class 1259 OID 16955)
-- Name: user_roles; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_roles (
    user_id bigint NOT NULL,
    role_id bigint NOT NULL
);


ALTER TABLE public.user_roles OWNER TO postgres;

--
-- TOC entry 220 (class 1259 OID 16907)
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
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


ALTER TABLE public.users OWNER TO postgres;

--
-- TOC entry 219 (class 1259 OID 16906)
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.users_id_seq OWNER TO postgres;

--
-- TOC entry 5799 (class 0 OID 0)
-- Dependencies: 219
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- TOC entry 291 (class 1259 OID 18082)
-- Name: wallet_transactions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.wallet_transactions (
    id bigint NOT NULL,
    wallet_id bigint NOT NULL,
    amount numeric(12,2) NOT NULL,
    type public.wallet_transaction_type NOT NULL,
    status public.transaction_status DEFAULT 'PENDING'::public.transaction_status NOT NULL,
    reference_id bigint,
    note text,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    order_id bigint
);


ALTER TABLE public.wallet_transactions OWNER TO postgres;

--
-- TOC entry 290 (class 1259 OID 18081)
-- Name: wallet_transactions_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.wallet_transactions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.wallet_transactions_id_seq OWNER TO postgres;

--
-- TOC entry 5800 (class 0 OID 0)
-- Dependencies: 290
-- Name: wallet_transactions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.wallet_transactions_id_seq OWNED BY public.wallet_transactions.id;


--
-- TOC entry 287 (class 1259 OID 18030)
-- Name: wallets; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.wallets (
    id bigint NOT NULL,
    user_id bigint NOT NULL,
    balance numeric(12,2) DEFAULT 0.00 NOT NULL,
    status public.wallet_status DEFAULT 'ACTIVE'::public.wallet_status NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    CONSTRAINT chk_wallets_balance_positive CHECK ((balance >= (0)::numeric))
);


ALTER TABLE public.wallets OWNER TO postgres;

--
-- TOC entry 286 (class 1259 OID 18029)
-- Name: wallets_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.wallets_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.wallets_id_seq OWNER TO postgres;

--
-- TOC entry 5801 (class 0 OID 0)
-- Dependencies: 286
-- Name: wallets_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.wallets_id_seq OWNED BY public.wallets.id;


--
-- TOC entry 5192 (class 2604 OID 17788)
-- Name: categories id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.categories ALTER COLUMN id SET DEFAULT nextval('public.categories_id_seq'::regclass);


--
-- TOC entry 5121 (class 2604 OID 17077)
-- Name: chapters id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.chapters ALTER COLUMN id SET DEFAULT nextval('public.chapters_id_seq'::regclass);


--
-- TOC entry 5139 (class 2604 OID 17246)
-- Name: completed_lessons_count id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.completed_lessons_count ALTER COLUMN id SET DEFAULT nextval('public.completed_lessons_count_id_seq'::regclass);


--
-- TOC entry 5190 (class 2604 OID 17699)
-- Name: contest_participants id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.contest_participants ALTER COLUMN id SET DEFAULT nextval('public.contest_participants_id_seq'::regclass);


--
-- TOC entry 5188 (class 2604 OID 17670)
-- Name: contest_problems id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.contest_problems ALTER COLUMN id SET DEFAULT nextval('public.contest_problems_id_seq'::regclass);


--
-- TOC entry 5169 (class 2604 OID 17470)
-- Name: contests id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.contests ALTER COLUMN id SET DEFAULT nextval('public.contests_id_seq'::regclass);


--
-- TOC entry 5185 (class 2604 OID 17640)
-- Name: course_reviews id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.course_reviews ALTER COLUMN id SET DEFAULT nextval('public.course_reviews_id_seq'::regclass);


--
-- TOC entry 5108 (class 2604 OID 17055)
-- Name: courses id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.courses ALTER COLUMN id SET DEFAULT nextval('public.courses_id_seq'::regclass);


--
-- TOC entry 5134 (class 2604 OID 17185)
-- Name: enrollments id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.enrollments ALTER COLUMN id SET DEFAULT nextval('public.enrollments_id_seq'::regclass);


--
-- TOC entry 5176 (class 2604 OID 17538)
-- Name: file_assignments id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.file_assignments ALTER COLUMN id SET DEFAULT nextval('public.file_assignments_id_seq'::regclass);


--
-- TOC entry 5179 (class 2604 OID 17566)
-- Name: file_submissions id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.file_submissions ALTER COLUMN id SET DEFAULT nextval('public.file_submissions_id_seq'::regclass);


--
-- TOC entry 5100 (class 2604 OID 16993)
-- Name: invalidated_tokens id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.invalidated_tokens ALTER COLUMN id SET DEFAULT nextval('public.invalidated_tokens_id_seq'::regclass);


--
-- TOC entry 5182 (class 2604 OID 17606)
-- Name: lesson_comments id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.lesson_comments ALTER COLUMN id SET DEFAULT nextval('public.lesson_comments_id_seq'::regclass);


--
-- TOC entry 5137 (class 2604 OID 17216)
-- Name: lesson_progress id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.lesson_progress ALTER COLUMN id SET DEFAULT nextval('public.lesson_progress_id_seq'::regclass);


--
-- TOC entry 5124 (class 2604 OID 17097)
-- Name: lessons id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.lessons ALTER COLUMN id SET DEFAULT nextval('public.lessons_id_seq'::regclass);


--
-- TOC entry 5153 (class 2604 OID 17374)
-- Name: online_judge_problems id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.online_judge_problems ALTER COLUMN id SET DEFAULT nextval('public.online_judge_problems_id_seq'::regclass);


--
-- TOC entry 5196 (class 2604 OID 17961)
-- Name: online_judge_submission_details id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.online_judge_submission_details ALTER COLUMN id SET DEFAULT nextval('public.online_judge_submission_details_id_seq'::regclass);


--
-- TOC entry 5173 (class 2604 OID 17497)
-- Name: online_judge_submissions id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.online_judge_submissions ALTER COLUMN id SET DEFAULT nextval('public.online_judge_submissions_id_seq'::regclass);


--
-- TOC entry 5217 (class 2604 OID 18221)
-- Name: order_items id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_items ALTER COLUMN id SET DEFAULT nextval('public.order_items_id_seq'::regclass);


--
-- TOC entry 5212 (class 2604 OID 18199)
-- Name: orders id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orders ALTER COLUMN id SET DEFAULT nextval('public.orders_id_seq'::regclass);


--
-- TOC entry 5204 (class 2604 OID 18136)
-- Name: payment_transactions id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.payment_transactions ALTER COLUMN id SET DEFAULT nextval('public.payment_transactions_id_seq'::regclass);


--
-- TOC entry 5099 (class 2604 OID 16947)
-- Name: permissions id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.permissions ALTER COLUMN id SET DEFAULT nextval('public.permissions_id_seq'::regclass);


--
-- TOC entry 5166 (class 2604 OID 17424)
-- Name: problem_tag_mappings id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.problem_tag_mappings ALTER COLUMN id SET DEFAULT nextval('public.problem_tag_mappings_id_seq'::regclass);


--
-- TOC entry 5163 (class 2604 OID 17406)
-- Name: problem_tags id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.problem_tags ALTER COLUMN id SET DEFAULT nextval('public.problem_tags_id_seq'::regclass);


--
-- TOC entry 5167 (class 2604 OID 17446)
-- Name: problem_testcases id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.problem_testcases ALTER COLUMN id SET DEFAULT nextval('public.problem_testcases_id_seq'::regclass);


--
-- TOC entry 5195 (class 2604 OID 17874)
-- Name: quiz_attempt_answers id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.quiz_attempt_answers ALTER COLUMN id SET DEFAULT nextval('public.quiz_attempt_answers_id_seq'::regclass);


--
-- TOC entry 5149 (class 2604 OID 17346)
-- Name: quiz_attempts id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.quiz_attempts ALTER COLUMN id SET DEFAULT nextval('public.quiz_attempts_id_seq'::regclass);


--
-- TOC entry 5147 (class 2604 OID 17325)
-- Name: quiz_options id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.quiz_options ALTER COLUMN id SET DEFAULT nextval('public.quiz_options_id_seq'::regclass);


--
-- TOC entry 5146 (class 2604 OID 17303)
-- Name: quiz_questions id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.quiz_questions ALTER COLUMN id SET DEFAULT nextval('public.quiz_questions_id_seq'::regclass);


--
-- TOC entry 5142 (class 2604 OID 17273)
-- Name: quizzes id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.quizzes ALTER COLUMN id SET DEFAULT nextval('public.quizzes_id_seq'::regclass);


--
-- TOC entry 5102 (class 2604 OID 17013)
-- Name: refresh_tokens id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.refresh_tokens ALTER COLUMN id SET DEFAULT nextval('public.refresh_tokens_id_seq'::regclass);


--
-- TOC entry 5098 (class 2604 OID 16935)
-- Name: roles id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.roles ALTER COLUMN id SET DEFAULT nextval('public.roles_id_seq'::regclass);


--
-- TOC entry 5132 (class 2604 OID 17128)
-- Name: teacher_course_assignments id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.teacher_course_assignments ALTER COLUMN id SET DEFAULT nextval('public.teacher_course_assignments_id_seq'::regclass);


--
-- TOC entry 5104 (class 2604 OID 17033)
-- Name: teachers id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.teachers ALTER COLUMN id SET DEFAULT nextval('public.teachers_id_seq'::regclass);


--
-- TOC entry 5094 (class 2604 OID 16910)
-- Name: users id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- TOC entry 5208 (class 2604 OID 18150)
-- Name: wallet_transactions id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.wallet_transactions ALTER COLUMN id SET DEFAULT nextval('public.wallet_transactions_id_seq'::regclass);


--
-- TOC entry 5199 (class 2604 OID 18116)
-- Name: wallets id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.wallets ALTER COLUMN id SET DEFAULT nextval('public.wallets_id_seq'::regclass);


--
-- TOC entry 5742 (class 0 OID 17785)
-- Dependencies: 280
-- Data for Name: categories; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.categories (id, name, slug, description, created_at, updated_at) FROM stdin;
1	Java	java	Các khóa học về ngôn ngữ lập trình Java và hệ sinh thái Spring Boot	2026-05-01 23:23:55.896875+07	2026-05-01 23:24:28.858688+07
2	Backend Development	backend	Lập trình API, xử lý logic máy chủ, bảo mật và kiến trúc hệ thống	2026-05-01 23:23:55.896875+07	2026-05-01 23:24:28.858688+07
3	Frontend Development	frontend	Phát triển giao diện người dùng với các framework hiện đại như React	2026-05-01 23:23:55.896875+07	2026-05-01 23:24:28.858688+07
4	Fullstack Development	fullstack	Kỹ năng phát triển ứng dụng toàn diện từ Frontend đến Backend	2026-05-01 23:23:55.896875+07	2026-05-01 23:24:28.858688+07
5	Database & SQL	database	Thiết kế cơ sở dữ liệu quan hệ, viết câu lệnh SQL và tối ưu hóa PostgreSQL	2026-05-01 23:23:55.896875+07	2026-05-01 23:24:28.858688+07
6	Data Structures & Algorithms	dsa	Cấu trúc dữ liệu và giải thuật, luyện thi thuật toán Online Judge	2026-05-01 23:23:55.896875+07	2026-05-01 23:24:28.858688+07
7	DevOps & Deployment	devops	Triển khai dự án, đóng gói ứng dụng với Docker và quản trị hệ thống	2026-05-01 23:23:55.896875+07	2026-05-01 23:24:28.858688+07
\.


--
-- TOC entry 5698 (class 0 OID 17074)
-- Dependencies: 236
-- Data for Name: chapters; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.chapters (id, course_id, title, order_index, created_at, updated_at) FROM stdin;
1	1	Chương 1: Giới thiệu và Cài đặt môi trường	1	2026-05-03 22:26:05.65978+07	2026-05-03 22:26:05.65978+07
2	1	Chương 2: Xây dựng RESTful API Cơ bản	2	2026-05-03 22:26:05.65978+07	2026-05-03 22:26:05.65978+07
3	1	Chương 3: Làm việc với Database qua Spring Data JPA	3	2026-05-03 22:26:05.65978+07	2026-05-03 22:26:05.65978+07
4	2	Chương 1: Big O Notation và Phân tích độ phức tạp	1	2026-05-03 22:26:05.65978+07	2026-05-03 22:26:05.65978+07
5	2	Chương 2: Mảng (Arrays) và Chuỗi (Strings)	2	2026-05-03 22:26:05.65978+07	2026-05-03 22:26:05.65978+07
6	3	Chương 1: Setup Frontend với Vite và React	1	2026-05-03 22:26:05.65978+07	2026-05-03 22:26:05.65978+07
7	3	Chương 2: Tích hợp API và CORS	2	2026-05-03 22:26:05.65978+07	2026-05-03 22:26:05.65978+07
8	4	Chương 1: Truy vấn Dữ liệu Cơ bản	1	2026-05-03 22:26:05.65978+07	2026-05-03 22:26:05.65978+07
9	4	Chương 2: Các phép JOIN trong SQL	2	2026-05-03 22:26:05.65978+07	2026-05-03 22:26:05.65978+07
10	5	Chương 1: Cơ bản về Docker	1	2026-05-03 22:26:05.65978+07	2026-05-03 22:26:05.65978+07
\.


--
-- TOC entry 5708 (class 0 OID 17243)
-- Dependencies: 246
-- Data for Name: completed_lessons_count; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.completed_lessons_count (id, user_id, course_id, completed_lessons_count, updated_at) FROM stdin;
2	2	2	0	2026-05-10 14:45:38.396062+07
3	2	3	0	2026-05-10 14:45:38.396062+07
4	5	4	0	2026-05-10 14:45:38.396062+07
5	5	5	0	2026-05-10 14:45:38.396062+07
6	5	2	0	2026-05-10 14:45:38.396062+07
1	2	1	2	2026-05-11 15:41:38.838634+07
\.


--
-- TOC entry 5740 (class 0 OID 17696)
-- Dependencies: 278
-- Data for Name: contest_participants; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.contest_participants (id, contest_id, user_id, joined_at) FROM stdin;
2	3	2	2026-05-16 19:03:27.499289+07
\.


--
-- TOC entry 5738 (class 0 OID 17667)
-- Dependencies: 276
-- Data for Name: contest_problems; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.contest_problems (id, contest_id, problem_id, order_index, point) FROM stdin;
1	3	6	1	100.00
\.


--
-- TOC entry 5726 (class 0 OID 17467)
-- Dependencies: 264
-- Data for Name: contests; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.contests (id, title, description, password_hash, start_time, end_time, status, created_by_teacher_id, created_at, updated_at) FROM stdin;
3	Kỳ thi Thuật toán đỉnh cao - Vòng loại	Cuộc thi kiểm thử luồng bảo mật Contest Mode của hệ thống.	\N	2026-05-16 19:00:16.223928+07	2026-05-16 22:00:16.223928+07	RUNNING	1	2026-05-16 19:00:16.223928+07	2026-05-16 19:00:16.223928+07
\.


--
-- TOC entry 5743 (class 0 OID 17804)
-- Dependencies: 281
-- Data for Name: course_category_mappings; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.course_category_mappings (course_id, category_id) FROM stdin;
1	1
1	2
2	1
2	6
3	1
3	2
3	3
3	4
4	2
4	5
5	1
5	2
5	7
\.


--
-- TOC entry 5736 (class 0 OID 17637)
-- Dependencies: 274
-- Data for Name: course_reviews; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.course_reviews (id, course_id, user_id, content, rating, created_at, updated_at) FROM stdin;
1	1	2	Khóa học Spring Boot rất thực tế, phần security và cấu trúc project giải thích rõ ràng. Phù hợp để làm project backend đưa vào CV.	5	2026-04-29 00:17:08.070255+07	2026-04-29 00:17:08.070255+07
2	2	2	Nội dung thuật toán được chia theo chủ đề dễ học, bài tập online judge giúp luyện tư duy tốt.	4	2026-04-28 00:17:08.070255+07	2026-04-28 00:17:08.070255+07
3	2	5	Khóa DSA có nhiều ví dụ thực hành, phù hợp cho người chuẩn bị phỏng vấn fresher/intern.	5	2026-04-27 00:17:08.070255+07	2026-04-27 00:17:08.070255+07
4	4	5	Phần SQL và PostgreSQL khá hữu ích, đặc biệt là constraint, index và thiết kế database quan hệ.	5	2026-04-30 00:17:08.070255+07	2026-04-30 00:17:08.070255+07
5	5	5	Khóa Docker giúp hiểu cách cấu hình môi trường chạy backend với PostgreSQL và Redis rõ ràng hơn.	4	2026-04-30 00:17:08.070255+07	2026-04-30 00:17:08.070255+07
\.


--
-- TOC entry 5696 (class 0 OID 17052)
-- Dependencies: 234
-- Data for Name: courses; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.courses (id, title, short_description, course_content, learning_outcomes, course_highlights, technologies_tools, prerequisites, target_audience, completion_benefits, price, thumbnail_url, estimated_duration_hours, status, created_at, updated_at, average_rating, total_reviews, total_enrolled, total_lessons, total_quizzes, total_assignments, total_online_judge_problems, total_videos) FROM stdin;
5	Docker and Deployment for Spring Boot Applications	Package, containerize and deploy Spring Boot applications with Docker, PostgreSQL and Redis.	This course teaches how to prepare a Spring Boot application for deployment. Learners will use Docker, Docker Compose, environment variables, PostgreSQL, Redis, and basic production configuration.	Write Dockerfiles for Spring Boot; Configure Docker Compose; Use environment variables safely; Run PostgreSQL and Redis containers; Prepare backend apps for deployment.	Dockerized backend setup; PostgreSQL and Redis containers; Environment-based configuration; Deployment-ready project structure.	Docker, Docker Compose, Spring Boot, PostgreSQL, Redis, Environment Variables	Basic Spring Boot knowledge and command-line usage.	Backend developers who want to deploy real applications and understand container-based workflows.	Learners can run their backend project consistently across local and deployment environments.	100000.00	https://example.com/thumbnails/docker-springboot-deployment.png	1	ACTIVE	2026-04-30 16:49:26.027416+07	2026-05-23 01:26:33.629313+07	4	1	2	2	0	0	0	2
3	Fullstack Web Development with React and Spring Boot	Create a complete fullstack web application using React, Spring Boot, REST API and PostgreSQL.	This course guides learners through building a fullstack application from frontend UI to backend API. It includes React components, API integration, authentication flow, database design, and deployment preparation.	Build React frontend pages; Connect frontend to Spring Boot APIs; Implement login and protected routes; Design database-backed fullstack features.	Frontend-backend integration; Real project workflow; Authentication with JWT cookies; REST API consumption; Clean UI structure.	React, TypeScript, Spring Boot, PostgreSQL, REST API, JWT	Basic HTML, CSS, JavaScript and basic Java knowledge.	Learners who want to build complete web applications and portfolio projects.	After completing this course, learners can build a complete fullstack project and explain the system architecture in interviews.	699000.00	https://example.com/thumbnails/fullstack-react-springboot.png	1	ACTIVE	2026-04-30 16:49:26.027416+07	2026-05-03 22:37:45.118821+07	0	0	1	2	0	0	0	2
4	SQL and PostgreSQL for Backend Developers	Learn relational database design, SQL queries, indexing, constraints and PostgreSQL best practices.	This course focuses on practical SQL and PostgreSQL usage for backend developers. It covers database modeling, normalization, joins, indexes, constraints, transactions, and query optimization basics.	Design relational schemas; Write SQL queries with joins and aggregations; Use constraints and indexes properly; Understand transactions and database consistency.	Database design practice; PostgreSQL-specific features; Index and constraint usage; Backend-oriented SQL examples.	PostgreSQL, SQL, ERD, Indexes, Constraints, Transactions	Basic programming knowledge. No advanced database experience required.	Backend beginners who want to understand databases deeply and design better schemas.	Learners will be able to design and implement relational databases for real backend projects.	299000.00	https://example.com/thumbnails/postgresql-backend.png	1	ACTIVE	2026-04-30 16:49:26.027416+07	2026-05-23 01:26:33.629313+07	5	1	2	2	0	0	0	2
2	Data Structures and Algorithms for Coding Interviews	Master essential data structures and algorithms through coding problems and online judge practice.	This course teaches arrays, strings, linked lists, stacks, queues, trees, graphs, recursion, dynamic programming, greedy algorithms, and sorting/searching techniques with hands-on coding exercises.	Solve common algorithmic problems; Analyze time and space complexity; Apply data structures correctly; Prepare for coding interviews and contests.	Online judge practice; Problem-solving patterns; Interview-focused lessons; Step-by-step explanation of algorithms.	Java, Online Judge, Big O Notation, Data Structures, Algorithms	Basic programming knowledge in Java or another language.	Students preparing for coding interviews, programming contests, or improving problem-solving skills.	Learners will be able to solve medium-level coding problems and understand common algorithm patterns.	399000.00	https://example.com/thumbnails/dsa-coding-interview.png	2	ACTIVE	2026-04-30 16:49:26.027416+07	2026-05-03 22:37:45.118821+07	4.5	2	2	3	0	0	0	2
1	Java Backend Development with Spring Boot	Build production-ready REST APIs with Java, Spring Boot, Spring Security, JPA, PostgreSQL and JWT.	This course covers Java backend development from project setup to building secure REST APIs. Learners will implement authentication, authorization, CRUD modules, database relationships, validation, exception handling, and API documentation.	Understand Spring Boot project structure; Build RESTful APIs; Work with PostgreSQL using Spring Data JPA; Implement JWT authentication and role-based authorization; Handle validation and global exceptions.	Real-world backend architecture; JWT authentication; Role-based access control; PostgreSQL relational database; Clean layered architecture.	Java 21, Spring Boot, Spring Security, Spring Data JPA, PostgreSQL, Maven, Lombok, MapStruct	Basic Java syntax, OOP concepts, basic SQL knowledge.	Students who want to become backend developers; Java learners preparing for internship or fresher backend positions.	After completing this course, learners can build and structure a real backend API project suitable for portfolio and CV.	499000.00	https://example.com/thumbnails/java-spring-boot-backend.png	2	ACTIVE	2026-04-30 16:49:26.027416+07	2026-05-03 22:37:45.118821+07	5	1	1	6	0	0	0	6
6	Mastering Spring Boot 3 & Microservices	Học cách xây dựng hệ thống Microservices mạnh mẽ và mở rộng với Spring Boot 3, Spring Cloud và Docker.	<p>Khóa học này sẽ đi từ những khái niệm cơ bản nhất của REST API cho đến cách chia nhỏ ứng dụng monolithic thành microservices.</p>	<ul><li>Xây dựng RESTful API chuẩn mực</li><li>Triển khai Microservices architecture</li><li>Đóng gói ứng dụng với Docker</li></ul>	<ul><li>100% Thực hành với dự án thực tế</li><li>Hỗ trợ review code qua GitHub</li></ul>	Java, Spring Boot, Docker, PostgreSQL	Nắm vững kiến thức Java Core và OOP cơ bản.	Sinh viên IT, Java Backend Developer	Đủ tự tin apply vị trí Backend Engineer tại các công ty lớn.	1290000.00	https://example.com/thumbnails/spring-boot-3.png	40	ACTIVE	2026-05-23 01:29:16.486687+07	2026-05-23 01:29:16.486687+07	4.8	125	1250	45	5	2	0	30
7	React 18: Zero to Hero	Khóa học toàn diện để xây dựng ứng dụng Frontend hiện đại với React 18 và Redux Toolkit.	<p>Bạn sẽ được học React từ con số 0, nắm vững Component Lifecycle, React Hooks, Context API và quản lý state phức tạp.</p>	<ul><li>Thành thạo React Hooks</li><li>Quản lý State với Redux Toolkit</li><li>Xây dựng Single-Page Application (SPA)</li></ul>	<ul><li>Cập nhật mới nhất React 18</li><li>Tối ưu hiệu năng (useMemo, useCallback)</li></ul>	React, JavaScript, HTML, CSS	Đã có kiến thức cơ bản về HTML, CSS và JavaScript.	Frontend Developer, Web Developer	Tự tin tự xây dựng Web App từ đầu đến cuối.	890000.00	https://example.com/thumbnails/react-18.png	35	ACTIVE	2026-05-23 01:29:16.486687+07	2026-05-23 01:29:16.486687+07	4.9	300	3200	60	8	3	0	50
9	DevOps Foundations: CI/CD & Docker	Tự động hóa quy trình phần mềm (CI/CD) và triển khai ứng dụng lên server bằng Docker.	<p>Học cách viết script cho GitHub Actions, đóng gói Docker Image và deploy tự động không downtime.</p>	<ul><li>Cài đặt luồng CI/CD</li><li>Tự động testing và deploy</li><li>Quản lý hạ tầng bằng code</li></ul>	<ul><li>Deploy ứng dụng lên thực tế</li><li>Best practices bảo mật</li></ul>	Docker, GitHub Actions, Linux	Biết dòng lệnh Linux cơ bản, hiểu khái niệm về Web Server.	System Admin, Developer muốn lấn sân sang DevOps	Có thể tự tay setup hệ thống deploy cho các dự án công ty.	990000.00	https://example.com/thumbnails/devops.png	25	ACTIVE	2026-05-23 01:29:16.486687+07	2026-05-23 01:29:16.486687+07	4.6	80	850	30	3	1	0	25
10	Fullstack Web3 & Blockchain Development	Khóa học đang trong giai đoạn phát triển: Xây dựng dApps với Solidity và Next.js.	<p>Chương trình đang được biên soạn để mang lại trải nghiệm học lập trình Blockchain tốt nhất.</p>	<ul><li>Viết Smart Contract an toàn</li><li>Tương tác Blockchain qua Ethers.js</li></ul>	<ul><li>Công nghệ mới nhất</li><li>Deploy Testnet</li></ul>	Solidity, Next.js, Ethers.js	Đã có nền tảng vững vàng về React và JavaScript.	Lập trình viên đam mê công nghệ phi tập trung	Trở thành Web3 Developer chuyên nghiệp.	2990000.00	https://example.com/thumbnails/web3.png	60	ACTIVE	2026-05-23 01:29:16.486687+07	2026-05-23 01:30:02.364534+07	0	0	0	10	0	0	0	0
8	Data Structures and Algorithms in Java	Chinh phục phỏng vấn lập trình tại các công ty công nghệ bằng cách làm chủ Cấu trúc dữ liệu và thuật toán.	<p>Khóa học tập trung sâu vào Mảng, Danh sách liên kết, Cây, Đồ thị và Quy hoạch động. Hỗ trợ chạy code thực tế thông qua Online Judge.</p>	<ul><li>Phân tích độ phức tạp Big O</li><li>Giải quyết các bài toán trên Leetcode</li><li>Vượt qua phỏng vấn thuật toán</li></ul>	<ul><li>Chạy code trực tiếp trên web</li><li>Hơn 100 bài tập thực hành</li></ul>	Java, Algorithms	Biết lập trình cơ bản bằng Java.	Kỹ sư phần mềm, Sinh viên chuẩn bị đi thực tập/phỏng vấn	Tự tin đối mặt với vòng thi Coding Interview tại FAANG.	0.00	https://example.com/thumbnails/dsa-java.png	50	ACTIVE	2026-05-23 01:29:16.486687+07	2026-05-25 20:57:21.256416+07	4.7	450	5001	80	0	0	100	20
\.


--
-- TOC entry 5704 (class 0 OID 17182)
-- Dependencies: 242
-- Data for Name: enrollments; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.enrollments (id, user_id, course_id, enrolled_at, status) FROM stdin;
1	2	1	2026-04-21 00:17:08.070255+07	ACTIVE
2	2	2	2026-04-23 00:17:08.070255+07	ACTIVE
3	2	3	2026-04-26 00:17:08.070255+07	ACTIVE
5	5	4	2026-04-24 00:17:08.070255+07	ACTIVE
6	5	5	2026-04-28 00:17:08.070255+07	ACTIVE
4	5	2	2026-04-19 00:17:08.070255+07	ACTIVE
7	2	5	2026-05-23 01:26:33.705772+07	ACTIVE
9	2	8	2026-05-25 20:57:21.291195+07	ACTIVE
\.


--
-- TOC entry 5730 (class 0 OID 17535)
-- Dependencies: 268
-- Data for Name: file_assignments; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.file_assignments (id, lesson_id, title, description, assignment_file_url, assignment_file_name, allowed_extensions, created_by_teacher_id, created_at, updated_at) FROM stdin;
\.


--
-- TOC entry 5732 (class 0 OID 17563)
-- Dependencies: 270
-- Data for Name: file_submissions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.file_submissions (id, file_assignment_id, user_id, attempt_no, file_url, file_name, submitted_at, feedback, graded_at, graded_by_teacher_id, status) FROM stdin;
\.


--
-- TOC entry 5690 (class 0 OID 16990)
-- Dependencies: 228
-- Data for Name: invalidated_tokens; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.invalidated_tokens (id, token_jti, expiry_time, created_at) FROM stdin;
1	53b9039f-f469-43ab-8b6f-0e51808d6c7e	2026-04-29 18:44:26+07	2026-04-29 18:43:28.962707+07
2	194bbca8-97c9-455b-864f-bc358256763b	2026-04-29 18:53:09+07	2026-04-29 18:52:14.612199+07
3	f938cd5b-2fb5-4102-a5bf-f4c41d022381	2026-04-29 18:54:10+07	2026-04-29 18:52:14.643913+07
4	4efc76ef-43b2-417d-9df1-24a3eab16390	2026-04-29 18:53:47+07	2026-04-29 18:52:59.831976+07
5	e49ab867-1ff6-4221-bbf4-ac829a4262f8	2026-04-29 18:54:47+07	2026-04-29 18:52:59.835976+07
6	5854eb49-3543-4d3a-be12-5deae55da287	2026-04-29 19:07:39+07	2026-04-29 19:06:50.619297+07
7	ec1e72bf-9ebc-49b1-98f7-71b13bc4068e	2026-04-29 19:08:39+07	2026-04-29 19:06:50.649524+07
8	08c50ec6-7cef-49ed-957a-6093cf1a428c	2026-04-29 19:41:36+07	2026-04-29 19:39:42.487806+07
9	a9f43e5f-3cfc-4ae9-84e6-1301de3cd110	2026-04-29 19:42:20+07	2026-04-29 19:40:23.138344+07
10	fb962b42-8509-4e13-87e1-028d29d30487	2026-04-29 19:41:23+07	2026-04-29 19:40:45.797481+07
11	6079f44c-4890-4633-800c-4fb2f8ca19b9	2026-04-29 19:42:23+07	2026-04-29 19:40:45.800487+07
12	466ce5a0-758f-433b-b537-ae6655d79d83	2026-04-29 23:16:02+07	2026-04-29 23:15:43.086455+07
13	d2e2626e-e745-4a85-88d7-434e6f7416e5	2026-04-29 23:17:02+07	2026-04-29 23:15:43.116991+07
14	8e264151-a934-48da-bc5b-04ca9e3091be	2026-04-29 23:17:57+07	2026-04-29 23:15:59.669612+07
15	e91991a4-00ee-4413-89e8-6f5d671020e1	2026-04-29 23:16:59+07	2026-04-29 23:16:04.543159+07
16	80f5f2fa-4ff4-4300-9de3-0d27f5768c45	2026-04-29 23:17:59+07	2026-04-29 23:16:04.546159+07
17	95ca130f-3dd0-4143-84dd-824153d5aeb6	2026-04-30 01:49:51+07	2026-04-30 01:49:03.846797+07
18	87bb0dfb-85eb-434c-9cde-d362d6661e04	2026-04-30 01:51:23+07	2026-04-30 01:50:36.155134+07
19	c3d0ad64-a395-4b1f-9641-ea109e69fcbc	2026-04-30 01:52:42+07	2026-04-30 01:51:51.449807+07
\.


--
-- TOC entry 5734 (class 0 OID 17603)
-- Dependencies: 272
-- Data for Name: lesson_comments; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.lesson_comments (id, lesson_id, user_id, parent_comment_id, content, created_at, updated_at) FROM stdin;
1	8	2	\N	Bài học này khá thú vị, nhưng đoạn code vòng lặp for ở phút thứ 5 mình chưa hiểu lắm. Có ai giải thích giúp mình không?	2026-05-04 00:25:35.818753+07	2026-05-04 00:25:35.818753+07
2	8	5	\N	Cho mình hỏi tài liệu slide của bài 8 này tải ở đâu vậy mọi người?	2026-05-05 00:25:35.818753+07	2026-05-05 00:25:35.818753+07
3	9	2	\N	Phần đệ quy này hại não quá, mình xem đi xem lại 3 lần mới hiểu =))	2026-05-05 19:25:35.818753+07	2026-05-05 19:25:35.818753+07
4	8	5	1	À, đoạn đó thầy dùng vòng lặp for lồng nhau để duyệt qua mảng 2 chiều đó bạn. Bạn xem kỹ lại lý thuyết mảng 2 chiều nhé.	2026-05-04 01:25:35.818753+07	2026-05-04 01:25:35.818753+07
5	8	2	1	Cảm ơn bạn nhé, mình hiểu rồi! Mình quên mất khái niệm mảng 2 chiều.	2026-05-04 02:25:35.818753+07	2026-05-04 02:25:35.818753+07
6	8	2	2	Bạn check ở phần tab "Tài liệu đính kèm" ngay dưới video nhé, có file PDF đó.	2026-05-05 04:25:35.818753+07	2026-05-05 04:25:35.818753+07
7	9	5	3	Haha công nhận, đệ quy ban đầu hơi khó hiểu, nhưng dùng tính năng debug step-by-step trên IDE là dễ hình dung hơn luồng chạy đó bạn.	2026-05-05 22:25:35.818753+07	2026-05-05 22:25:35.818753+07
8	8	2	\N	Địt mẹ dạy như cặc	2026-05-10 22:06:11.968342+07	2026-05-10 22:06:11.968342+07
9	8	5	8	Sủa cái loz	2026-05-10 22:39:24.637867+07	2026-05-10 22:39:24.637867+07
\.


--
-- TOC entry 5706 (class 0 OID 17213)
-- Dependencies: 244
-- Data for Name: lesson_progress; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.lesson_progress (id, user_id, lesson_id, course_id, completed_at) FROM stdin;
2	2	1	1	2026-05-10 14:46:32.165018+07
3	2	2	1	2026-05-11 15:41:38.85899+07
\.


--
-- TOC entry 5700 (class 0 OID 17094)
-- Dependencies: 238
-- Data for Name: lessons; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.lessons (id, chapter_id, title, description, video_url, theory_content, sample_code, is_trial, order_index, estimated_duration_minutes, status, created_at, updated_at, has_quiz, has_assignment, has_online_judge) FROM stdin;
3	1	Khởi tạo Spring Boot Project với Spring Initializr	Cách tạo project cơ bản.	https://example.com/video/spring-init.mp4	<p>Truy cập start.spring.io và chọn các dependency cần thiết...</p>	\N	f	3	25	ACTIVE	2026-05-03 22:26:05.65978+07	2026-05-03 22:32:58.912717+07	f	f	f
5	2	Tạo API GET đầu tiên (Hello World)	Viết API trả về chuỗi.	https://example.com/video/hello-api.mp4	<p>Sử dụng @GetMapping để định tuyến request GET.</p>	@GetMapping("/hello")\\npublic String hello() { return "Hello World"; }	f	2	20	ACTIVE	2026-05-03 22:26:05.65978+07	2026-05-03 22:32:58.912717+07	f	f	f
6	3	Kết nối PostgreSQL và cấu hình application.yml	Cách setup kết nối DB.	https://example.com/video/connect-db.mp4	<p>Cấu hình spring.datasource.url, username, password...</p>	spring:\\n  datasource:\\n    url: jdbc:postgresql://localhost:5432/mydb	f	1	35	ACTIVE	2026-05-03 22:26:05.65978+07	2026-05-03 22:32:58.912717+07	f	f	f
8	5	Kỹ thuật Two Pointers	Dùng 2 con trỏ để giải quyết bài toán mảng nhanh hơn.	https://example.com/video/two-pointers.mp4	<p>Thường dùng trong mảng đã sắp xếp để tìm cặp số...</p>	int left = 0, right = arr.length - 1;\\nwhile(left < right) {...}	f	1	40	ACTIVE	2026-05-03 22:26:05.65978+07	2026-05-03 22:32:58.912717+07	f	f	f
9	5	Thực hành: Đảo ngược chuỗi (Reverse String)	Bài tập Online Judge.	\N	<p>Viết chương trình đảo ngược một chuỗi ký tự được cho.</p>	public String reverse(String s) {\\n  // Code here\\n}	f	2	45	ACTIVE	2026-05-03 22:26:05.65978+07	2026-05-03 22:32:58.912717+07	f	f	f
10	6	Khởi tạo React App bằng Vite	Nhanh chóng tạo project React.	https://example.com/video/vite-react.mp4	<p>Chạy lệnh: npm create vite@latest my-app -- --template react</p>	\N	t	1	15	ACTIVE	2026-05-03 22:26:05.65978+07	2026-05-03 22:32:58.912717+07	f	f	f
4	2	Tìm hiểu cấu trúc 3 Layer (Controller - Service - Repository)	Mô hình kiến trúc phổ biến nhất trong Spring Boot.	https://example.com/video/3-layer.mp4	<p>Controller xử lý HTTP, Service chứa logic, Repository gọi DB...</p>	@RestController\\npublic class UserController {}	f	1	30	ACTIVE	2026-05-03 22:26:05.65978+07	2026-05-04 02:24:19.271427+07	t	f	f
7	4	Giới thiệu về Time & Space Complexity	Tại sao phải quan tâm đến Big O?	https://example.com/video/big-o.mp4	<p>O(1), O(N), O(N^2) khác nhau như thế nào...</p>	\N	t	1	20	ACTIVE	2026-05-03 22:26:05.65978+07	2026-05-04 02:24:19.271427+07	t	f	f
2	1	Cài đặt JDK 21 và IntelliJ IDEA	Hướng dẫn cài đặt môi trường phát triển Java.	https://example.com/video/install-jdk.mp4	<p>Bước 1: Tải JDK 21. Bước 2: Cấu hình biến môi trường...</p>	\N	t	2	20	ACTIVE	2026-05-03 22:26:05.65978+07	2026-05-05 03:15:17.516772+07	f	f	t
1	1	Giới thiệu khóa học Spring Boot	Tổng quan về những gì bạn sẽ học.	https://example.com/video/spring-intro.mp4	<p>Spring Boot giúp xây dựng ứng dụng Java nhanh chóng...</p>	\N	t	1	15	ACTIVE	2026-05-03 22:26:05.65978+07	2026-05-13 17:35:24.484627+07	t	f	t
11	7	Xử lý lỗi CORS (Cross-Origin Resource Sharing)	Lỗi kinh điển khi ghép nối FE và BE.	https://example.com/video/cors.mp4	<p>Cấu hình @CrossOrigin trên Backend hoặc setup Proxy trên Frontend.</p>	@CrossOrigin(origins = "http://localhost:5173")\\n@RestController...	f	1	25	ACTIVE	2026-05-03 22:26:05.65978+07	2026-05-03 22:32:58.912717+07	f	f	f
12	8	Mệnh đề SELECT và WHERE	Lọc dữ liệu cơ bản.	https://example.com/video/select-where.mp4	<p>Sử dụng SELECT để chọn cột, WHERE để thêm điều kiện.</p>	SELECT id, name FROM users WHERE status = 'ACTIVE';	t	1	20	ACTIVE	2026-05-03 22:26:05.65978+07	2026-05-03 22:32:58.912717+07	f	f	f
13	9	Phân biệt INNER JOIN và LEFT JOIN	Ghép bảng dữ liệu.	https://example.com/video/joins.mp4	<p>INNER JOIN lấy dữ liệu chung, LEFT JOIN lấy tất cả dữ liệu bảng trái.</p>	SELECT u.name, r.role_name FROM users u LEFT JOIN roles r ON u.role_id = r.id;	f	1	35	ACTIVE	2026-05-03 22:26:05.65978+07	2026-05-03 22:32:58.912717+07	f	f	f
14	10	Khái niệm Containerization	Tại sao lại cần Docker?	https://example.com/video/docker-intro.mp4	<p>Docker giải quyết bài toán "Chạy trên máy tôi thì được, lên server thì lỗi".</p>	\N	t	1	20	ACTIVE	2026-05-03 22:26:05.65978+07	2026-05-03 22:32:58.912717+07	f	f	f
15	10	Viết Dockerfile cho ứng dụng Spring Boot	Đóng gói file .jar thành Docker Image.	https://example.com/video/dockerfile.mp4	<p>Sử dụng image base là openjdk hoặc eclipse-temurin.</p>	FROM eclipse-temurin:21-jre-alpine\\nCOPY target/*.jar app.jar\\nENTRYPOINT ["java","-jar","/app.jar"]	f	2	30	ACTIVE	2026-05-03 22:26:05.65978+07	2026-05-03 22:32:58.912717+07	f	f	f
\.


--
-- TOC entry 5718 (class 0 OID 17371)
-- Dependencies: 256
-- Data for Name: online_judge_problems; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.online_judge_problems (id, lesson_id, title, description, input_description, output_description, constraints, example_input, example_output, hint, problem_scope, difficulty, is_active, created_by_teacher_id, created_at, updated_at, contest_id, total_testcase, time_limit_ms, memory_limit_kb, is_public, total_submissions, total_accepted) FROM stdin;
3	2	Tìm giá trị lớn nhất trong mảng	<p>Cho một mảng gồm <code>N</code> số nguyên. Hãy tìm và in ra giá trị lớn nhất xuất hiện trong mảng đó.</p>	Dòng đầu tiên chứa số nguyên N. Dòng thứ hai chứa N số nguyên cách nhau bởi khoảng trắng.	Một số nguyên duy nhất là giá trị lớn nhất trong mảng.	1 \\le N \\le 10^5<br/>-10^9 \\le A[i] \\le 10^9	5\r\n1 4 2 8 5	8	Gán giá trị max ban đầu bằng phần tử đầu tiên của mảng, sau đó duyệt qua các phần tử còn lại để cập nhật max.	LESSON	MEDIUM	t	1	2026-05-05 03:15:17.516772+07	2026-05-26 11:22:57.050677+07	\N	2	2000	128000	t	0	0
8	1	Đếm Số Chia Hết (Divisibility Count)	Cho 3 số nguyên dương N, A, B. Hãy đếm xem có bao nhiêu số nguyên x trong đoạn từ 1 đến N sao cho x chia hết cho A hoặc chia hết cho B.	Một dòng duy nhất chứa 3 số nguyên N, A, B cách nhau bởi khoảng trắng.	In ra một số nguyên duy nhất là kết quả bài toán.	1 <= N <= 10^18\\n1 <= A, B <= 10^5\\nThời gian chạy tối đa: 1.0s	10 2 3	7	Đừng dùng vòng lặp For! N lên tới 10^18 sẽ gây Time Limit Exceeded. Hãy tìm hiểu nguyên lý Bao Hàm - Loại Trừ (Inclusion-Exclusion Principle) và công thức tính Bội chung nhỏ nhất (LCM).	LESSON	MEDIUM	t	1	2026-05-17 22:53:13.037826+07	2026-05-26 11:22:57.05209+07	\N	20	2000	128000	t	21	0
1	1	Tính tổng hai số (A + B)	<p>Cho hai số nguyên <code>a</code> và <code>b</code>. Hãy tính tổng của chúng và in ra màn hình.</p>	Một dòng duy nhất chứa hai số nguyên a và b cách nhau bởi khoảng trắng.	Một số nguyên duy nhất là tổng của a và b.	-10^9 \\le a, b \\le 10^9	5 7	12	Bạn có thể sử dụng toán tử cộng (+) cơ bản trong bất kỳ ngôn ngữ nào.	LESSON	EASY	t	1	2026-05-05 03:15:17.516772+07	2026-05-26 11:22:57.052915+07	\N	3	1000	64000	t	8	1
2	1	Đảo ngược chuỗi	<p>Cho một chuỗi ký tự <code>S</code>. Nhiệm vụ của bạn là in ra chuỗi đó theo thứ tự ngược lại.</p>	Một dòng duy nhất chứa chuỗi S (không chứa khoảng trắng).	Chuỗi S sau khi được đảo ngược.	1 \\le |S| \\le 10^5	hello	olleh	Hãy thử dùng vòng lặp duyệt từ cuối về đầu, hoặc dùng các hàm có sẵn của thư viện (như StringBuilder.reverse() trong Java).	LESSON	EASY	t	1	2026-05-05 03:15:17.516772+07	2026-05-26 11:22:57.053608+07	\N	2	1000	64000	t	2	0
6	\N	Kiểm tra số nguyên tố (Contest Mode)	<p>Cho số nguyên dương <code>N</code>. Hãy kiểm tra xem N có phải là số nguyên tố hay không.</p>	Một dòng duy nhất chứa số nguyên dương N.	In ra YES nếu N là số nguyên tố, ngược lại in ra NO.	1 <= N <= 10^9	7	YES	Duyệt từ 2 đến căn bậc hai của N để tối ưu thời gian O(sqrt(N)).	CONTEST	EASY	t	1	2026-05-16 19:00:16.223928+07	2026-05-26 11:22:57.054117+07	3	20	1000	64000	t	25	17
7	1	Kiểm tra số nguyên tố	Viết chương trình nhập vào một số nguyên dương N. Kiểm tra xem N có phải là số nguyên tố hay không.	Một dòng duy nhất chứa số nguyên N.	In ra "YES" nếu N là số nguyên tố, ngược lại in ra "NO".	-10^18 <= N <= 10^18	7	YES	Hãy chú ý tối ưu thuật toán kiểm tra đến căn bậc hai của N (O(sqrt(N))) để không bị dính lỗi quá thời gian (TLE) với các testcase lớn.	LESSON	EASY	t	1	2026-05-17 21:30:09.205066+07	2026-05-26 11:22:57.054549+07	\N	20	1000	64000	t	3	3
10	\N	Two Sum	Given an array of integers nums and an integer target, return indices of the two numbers such that they add up to target.	Line 1:\r\n  integer n. Line 2: n integers of nums. Line 3: target.	Two space-separated integers representing the indices.	2 <= nums.length <= 10^4	4\\n2 7\r\n  11 15\\n9	0 1	Use a hash map for O(n) time complexity.	PRACTICE	EASY	t	1	2026-05-26 00:12:59.79069+07	2026-05-26 11:22:19.343439+07	\N	2	2000	128000	t	0	0
11	\N	Reverse String	Write a function that reverses a string. The input string is given as an array of characters.	A single string s.	The\r\n  reversed string.	1 <= s.length <= 10^5	hello	olleh	Use two pointers.	PRACTICE	EASY	t	1	2026-05-26 00:12:59.79069+07	2026-05-26 11:22:19.343439+07	\N	2	2000	128000	t	0	0
12	\N	Fibonacci Number	The Fibonacci numbers form a sequence where each number is the sum of the two preceding ones. Given n, calculate F(n).	A\r\n  single integer n.	A single integer F(n).	0 <= n <= 30	4	3	F(n) = F(n-1) + F(n-2)	PRACTICE	EASY	t	1	2026-05-26 00:12:59.79069+07	2026-05-26 11:22:19.343439+07	\N	2	2000	128000	t	0	0
13	\N	Maximum Subarray	Given an integer array nums, find the contiguous subarray which has the largest sum and return its sum.	Line 1: integer n.\r\n  Line 2: n integers.	The maximum sum.	1 <= nums.length <= 10^5	5\\n-2 1 -3 4 -1	4	Kadane Algorithm is your friend.	PRACTICE	MEDIUM	t	1	2026-05-26 00:12:59.79069+07	2026-05-26 11:22:19.343439+07	\N	2	2000	128000	t	0	0
14	\N	Climbing Stairs	You are climbing a staircase. It takes n steps to reach the top. Each time you can either climb 1 or 2 steps. How many distinct\r\n  ways can you climb to the top?	A single integer n.	Number of distinct ways.	1 <= n <= 45	3	3	This is similar to Fibonacci.	PRACTICE	EASY	t	1	2026-05-26 00:12:59.79069+07	2026-05-26 11:22:19.343439+07	\N	2	2000	128000	t	0	0
15	\N	Valid Parentheses	Given a string s containing just the characters "(", ")", "{", "}", "[" and "]", determine if the input string is valid.	A\r\n  single string s.	true or false.	1 <= s.length <= 10^4	()[]{}	true	Use a Stack data structure.	PRACTICE	EASY	t	1	2026-05-26 00:12:59.79069+07	2026-05-26 11:22:19.343439+07	\N	2	2000	128000	t	0	0
16	\N	Merge Intervals	Given an array of intervals where intervals[i] = [starti, endi], merge all overlapping intervals.	Line 1: integer n. Next n\r\n  lines: two integers start and end.	Merged intervals.	1 <= n <= 10^4	4\\n1 3\\n2 6\\n8 10\\n15 18	1 6\\n8 10\\n15 18	Sort intervals by start\r\n  time first.	PRACTICE	MEDIUM	t	1	2026-05-26 00:12:59.79069+07	2026-05-26 11:22:19.343439+07	\N	2	2000	128000	t	0	0
17	\N	Contains Duplicate	Given an integer array nums, return true if any value appears at least twice in the array.	Line 1: integer n. Line 2: n\r\n  integers.	true or false.	1 <= nums.length <= 10^5	4\\n1 2 3 1	true	Use a HashSet.	PRACTICE	EASY	t	1	2026-05-26 00:12:59.79069+07	2026-05-26 11:22:19.343439+07	\N	2	2000	128000	t	0	0
18	\N	Missing Number	Given an array nums containing n distinct numbers in the range [0, n], return the only number in the range that is missing from\r\n  the array.	Line 1: integer n. Line 2: n integers.	The missing integer.	1 <= n <= 10^4	3\\n3 0 1	2	Sum formula: n*(n+1)/2	PRACTICE	EASY	t	1	2026-05-26 00:12:59.79069+07	2026-05-26 11:22:19.343439+07	\N	2	2000	128000	t	0	0
19	\N	Trapping Rain Water	Given n non-negative integers representing an elevation map where the width of each bar is 1, compute how much water it can\r\n  trap after raining.	Line 1: integer n. Line 2: n integers.	Total amount of trapped water.	1 <= n <= 2 * 10^4	6\\n4 2 0 3 2 5	9	Use two\r\n  pointers or precompute left/right max.	PRACTICE	HARD	t	1	2026-05-26 00:12:59.79069+07	2026-05-26 11:22:19.343439+07	\N	2	2000	128000	t	0	0
\.


--
-- TOC entry 5747 (class 0 OID 17928)
-- Dependencies: 285
-- Data for Name: online_judge_submission_details; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.online_judge_submission_details (id, submission_id, testcase_id, token, verdict, execution_time_ms, memory_used_kb, created_at) FROM stdin;
935	62	104	f0ca2789-2aa1-46e4-be9a-fb15b59b60a8	ACCEPTED	86	12132	2026-05-18 23:24:58.482686+07
922	62	11	98c6c2a9-30f9-4a10-8c8d-35e687f5befa	ACCEPTED	106	12200	2026-05-18 23:24:58.482686+07
926	62	15	2cb9f14d-f755-4c62-8937-54f394056fe9	ACCEPTED	88	12352	2026-05-18 23:24:58.482686+07
929	62	18	b7f4369d-0d7f-4247-8698-401426d9c845	ACCEPTED	110	12140	2026-05-18 23:24:58.482686+07
919	62	8	8f4d9695-c817-4622-beac-9230963cef8d	ACCEPTED	117	12236	2026-05-18 23:24:58.482686+07
924	62	13	cdfdefa3-2ae8-4563-a593-0d0aa889a8e3	ACCEPTED	97	12388	2026-05-18 23:24:58.482686+07
920	62	9	32ae4729-f325-4b42-bd32-295a60be4346	ACCEPTED	113	12356	2026-05-18 23:24:58.482686+07
923	62	12	ee780ff3-fea2-4b36-b6c8-aabd96e71b1a	ACCEPTED	84	12200	2026-05-18 23:24:58.482686+07
921	62	10	2615f8d1-0584-4031-853a-cf73dd4cd30c	ACCEPTED	82	12188	2026-05-18 23:24:58.482686+07
930	62	19	47c6a2fb-b21f-4242-b2e3-5b435bec9e17	ACCEPTED	99	12376	2026-05-18 23:24:58.482686+07
927	62	16	e743e78c-6859-4f4f-be7c-ff25b861dde9	ACCEPTED	115	12536	2026-05-18 23:24:58.482686+07
931	62	20	e33595dc-51d0-4e23-86de-3275abead39b	ACCEPTED	146	12236	2026-05-18 23:24:58.482686+07
934	62	103	c66b0ce9-3984-4bb2-8b61-747ac357b587	ACCEPTED	155	12184	2026-05-18 23:24:58.482686+07
938	62	107	dd08e6fe-2c4f-4a7e-b75b-17873a7788c7	ACCEPTED	130	12404	2026-05-18 23:24:58.482686+07
925	62	14	20a5f919-c857-42ac-9505-29c039f7011e	ACCEPTED	149	12484	2026-05-18 23:24:58.482686+07
933	62	102	d8260d4d-60f2-47bf-8a63-a8bd46688a04	ACCEPTED	133	12296	2026-05-18 23:24:58.482686+07
928	62	17	4924acb7-6344-4324-b345-a40e572dbcb8	ACCEPTED	116	12428	2026-05-18 23:24:58.482686+07
932	62	101	075867bd-1498-4e37-ab62-c06155ee9e4a	ACCEPTED	120	12656	2026-05-18 23:24:58.482686+07
936	62	105	341ed4a0-b855-4f48-a253-cd6e6740a3dd	ACCEPTED	74	12972	2026-05-18 23:24:58.482686+07
937	62	106	40129ae4-763f-4253-8a4e-2988122e853b	ACCEPTED	73	13044	2026-05-18 23:24:58.482686+07
950	63	19	3e388193-f67e-4fb0-9721-2063985cc2c2	WRONG_ANSWER	93	13124	2026-05-18 23:35:33.64167+07
952	63	101	57fd9314-db15-4eb7-9da6-1f1a4f74cde5	WRONG_ANSWER	90	16776	2026-05-18 23:35:33.64167+07
953	63	102	b67bbb89-e7a1-48d1-a26b-03beb87c6064	WRONG_ANSWER	94	14972	2026-05-18 23:35:33.64167+07
941	63	10	c8ddecfe-e307-44e1-839c-cce7e85fd317	ACCEPTED	104	14604	2026-05-18 23:35:33.64167+07
943	63	12	a8cfcec0-929b-4c39-8a48-e1f89c5ffb6a	WRONG_ANSWER	80	15948	2026-05-18 23:35:33.64167+07
945	63	14	b1c63b8a-3eec-4b87-866e-87838e54e1d2	WRONG_ANSWER	86	17284	2026-05-18 23:35:33.64167+07
949	63	18	0003213d-5ff7-4fd1-9698-5bfc0103f359	ACCEPTED	105	15688	2026-05-18 23:35:33.64167+07
948	63	17	a86d494d-8119-41e4-91ec-75ea6c30fe2c	ACCEPTED	80	14808	2026-05-18 23:35:33.64167+07
957	63	106	18f87c93-28c1-4497-856d-ac3de7d88149	WRONG_ANSWER	77	13812	2026-05-18 23:35:33.64167+07
942	63	11	5efee7b0-6374-434c-bb53-99eaa943bbba	WRONG_ANSWER	93	13888	2026-05-18 23:35:33.64167+07
946	63	15	4b64e298-d87c-4276-917a-ddcf78da7b6c	ACCEPTED	133	14288	2026-05-18 23:35:33.64167+07
944	63	13	2602142e-c87b-4a5f-8c2a-f6d4f6dda41e	ACCEPTED	102	13624	2026-05-18 23:35:33.64167+07
955	63	104	cfd1c609-579d-4164-bed1-ef9c8bf45850	WRONG_ANSWER	101	13320	2026-05-18 23:35:33.64167+07
954	63	103	fdb3b248-caf9-4f48-b3c6-9e02f5488310	WRONG_ANSWER	116	12376	2026-05-18 23:35:33.64167+07
939	63	8	6884e93d-73c6-4359-983a-b710db1e7f68	WRONG_ANSWER	122	13560	2026-05-18 23:35:33.64167+07
958	63	107	3f53a6f9-35f6-47e3-bcd4-1fd75b603f9b	WRONG_ANSWER	134	14612	2026-05-18 23:35:33.64167+07
940	63	9	60270507-c1ac-4ac6-9bea-13da2303b66d	ACCEPTED	142	14952	2026-05-18 23:35:33.64167+07
956	63	105	40abcf13-5f4b-4bad-8599-5ad791e5f852	WRONG_ANSWER	178	14668	2026-05-18 23:35:33.64167+07
951	63	20	1a214a79-60a8-4938-9234-a819c4513bb3	WRONG_ANSWER	135	15024	2026-05-18 23:35:33.64167+07
947	63	16	e58b915c-229f-4dc0-952f-cfcd7b9a2aaf	WRONG_ANSWER	134	13100	2026-05-18 23:35:33.64167+07
963	64	12	4f21c6a2-d0c1-44c2-ba3f-73e73e7b726a	ACCEPTED	96	12328	2026-05-18 23:35:57.43599+07
967	64	16	ad479d8c-2b9b-41a0-b144-9dd10f584ab6	ACCEPTED	79	12360	2026-05-18 23:35:57.43599+07
964	64	13	a635bff4-53a1-4cfd-a36b-52a58188fc9b	ACCEPTED	99	12392	2026-05-18 23:35:57.43599+07
969	64	18	75acd7aa-33f0-471f-8907-18e1727c333e	ACCEPTED	98	12416	2026-05-18 23:35:57.43599+07
959	64	8	42546ac8-725b-493e-924a-34ad3dae4bb5	ACCEPTED	81	12184	2026-05-18 23:35:57.43599+07
966	64	15	97f70c59-ae94-4667-b47e-e109fab919ee	ACCEPTED	100	12140	2026-05-18 23:35:57.43599+07
977	64	106	11320953-8ca7-4209-8677-c5842f430730	ACCEPTED	90	12252	2026-05-18 23:35:57.43599+07
975	64	104	fd311eb6-591f-40b4-a888-8a94f4fa3c7d	ACCEPTED	117	12432	2026-05-18 23:35:57.43599+07
962	64	11	b2f771ac-e5bc-4937-8e87-f506637f05ec	ACCEPTED	109	12104	2026-05-18 23:35:57.43599+07
971	64	20	267715e0-5dd3-4033-b40e-9b57775f14f7	ACCEPTED	104	12172	2026-05-18 23:35:57.43599+07
976	64	105	be50fa8e-d4c4-4e4e-877d-3695618a1aff	ACCEPTED	107	12448	2026-05-18 23:35:57.43599+07
968	64	17	21c023cd-ea52-4387-abd3-9ef6d012b1ec	ACCEPTED	103	12276	2026-05-18 23:35:57.43599+07
974	64	103	723516fb-e565-4c2b-9349-7603f7010257	ACCEPTED	98	12584	2026-05-18 23:35:57.43599+07
960	64	9	1eda803d-b98d-4342-a089-6ece41a52199	ACCEPTED	99	12352	2026-05-18 23:35:57.43599+07
961	64	10	140c45e6-41c6-4fbb-9def-abbf10a98867	ACCEPTED	114	12316	2026-05-18 23:35:57.43599+07
965	64	14	40bcd514-e75a-4130-a86d-8eccac6ebf8c	ACCEPTED	146	12348	2026-05-18 23:35:57.43599+07
972	64	101	d32cd2c9-22f4-4845-b9d4-f9e32598f9bf	ACCEPTED	122	12576	2026-05-18 23:35:57.43599+07
973	64	102	19b8f4e7-06ab-4a24-afbf-8128d14436c8	ACCEPTED	263	12892	2026-05-18 23:35:57.43599+07
970	64	19	8788c712-e1d2-4b61-a4bb-a51bc96230bd	ACCEPTED	246	13084	2026-05-18 23:35:57.43599+07
978	64	107	e17f96bb-8da0-40ac-ac11-65fabb9ce83e	ACCEPTED	78	12868	2026-05-18 23:35:57.43599+07
989	65	18	911f131a-42a1-474f-826d-8b9bb5bc4132	ACCEPTED	101	12376	2026-05-18 23:36:21.370567+07
995	65	104	58d9a184-fe19-4c20-8955-4085eaed8b9b	WRONG_ANSWER	87	12360	2026-05-18 23:36:21.370567+07
985	65	14	647d583c-e1ca-4239-b9a9-71abbde5b17d	WRONG_ANSWER	116	12192	2026-05-18 23:36:21.370567+07
980	65	9	02804f07-517a-4713-aebf-f4b195044717	ACCEPTED	88	12148	2026-05-18 23:36:21.370567+07
988	65	17	b3888aea-fa96-4bfb-9e4c-f6af5b52396c	ACCEPTED	90	12300	2026-05-18 23:36:21.370567+07
996	65	105	8a33d944-54d3-4aa5-a23a-a314cbd25c6a	WRONG_ANSWER	116	12132	2026-05-18 23:36:21.370567+07
982	65	11	4be6fb55-7cde-4543-8dd4-7e6f87981818	WRONG_ANSWER	98	12408	2026-05-18 23:36:21.370567+07
997	65	106	9b67043f-c81b-4174-b009-a971eb1bd7d7	WRONG_ANSWER	106	12160	2026-05-18 23:36:21.370567+07
998	65	107	78a46547-e26a-418e-9ea1-cc849bb765b9	WRONG_ANSWER	123	12272	2026-05-18 23:36:21.370567+07
979	65	8	8f5a0f05-ded7-474f-9d9e-4bee6f772aae	WRONG_ANSWER	103	12196	2026-05-18 23:36:21.370056+07
987	65	16	6288658a-b410-49e5-b0fb-552901fae91e	WRONG_ANSWER	109	12596	2026-05-18 23:36:21.370567+07
983	65	12	ca1bb036-4767-4251-94c2-70cf0aaaa89d	WRONG_ANSWER	103	12344	2026-05-18 23:36:21.370567+07
993	65	102	289fd7b7-04cb-49c4-9c2b-616424934385	WRONG_ANSWER	98	12176	2026-05-18 23:36:21.370567+07
984	65	13	88d45121-91ad-4731-8147-32a80ad55edc	ACCEPTED	116	12164	2026-05-18 23:36:21.370567+07
981	65	10	f4761104-36d4-4fd9-8ad4-16db7220ea51	ACCEPTED	108	12204	2026-05-18 23:36:21.370567+07
990	65	19	dbff0630-3a58-4950-8057-ca395297351e	WRONG_ANSWER	115	12308	2026-05-18 23:36:21.370567+07
992	65	101	b52726c8-582e-402c-b89f-0cd4bf8d11a1	WRONG_ANSWER	143	12292	2026-05-18 23:36:21.370567+07
986	65	15	41a04d5b-3802-4ff1-8e5b-df3ee82ad0da	ACCEPTED	167	12400	2026-05-18 23:36:21.370567+07
994	65	103	2c9a4110-b3d7-49f6-9a7f-3bdb314128cd	WRONG_ANSWER	47	12780	2026-05-18 23:36:21.370567+07
991	65	20	0bcf2568-3186-4b00-a288-ef304473a6c9	WRONG_ANSWER	45	13152	2026-05-18 23:36:21.370567+07
899	61	8	12c403dc-e70d-49c7-aff9-0db11762b1fb	ACCEPTED	86	12208	2026-05-18 23:17:09.885782+07
905	61	14	2eb33b26-4d3d-475f-b90e-77f1b3aae882	ACCEPTED	108	12404	2026-05-18 23:17:09.885782+07
901	61	10	76b09111-4793-45cb-ab2e-ce12013dc3f3	ACCEPTED	91	12228	2026-05-18 23:17:09.885782+07
915	61	104	9486f836-62e4-4ee6-961f-65308464047f	ACCEPTED	88	12176	2026-05-18 23:17:09.885782+07
908	61	17	e233a796-70cd-4283-86db-00e2941cee8f	ACCEPTED	77	12200	2026-05-18 23:17:09.885782+07
907	61	16	7f677eac-6511-4d1c-a95d-82798bc121f9	ACCEPTED	83	12180	2026-05-18 23:17:09.885782+07
904	61	13	fe9d19a3-c8b0-4596-84be-bdbcac19cd5c	ACCEPTED	83	12360	2026-05-18 23:17:09.885782+07
900	61	9	b84e9716-b69e-45bd-99ef-707b5c70492c	ACCEPTED	90	12208	2026-05-18 23:17:09.885782+07
902	61	11	e1ff48ad-5f0d-4fc1-9638-e33c683b0568	ACCEPTED	84	12236	2026-05-18 23:17:09.885782+07
912	61	101	ef7f0be2-1168-41c2-b455-0b46859e7ac1	ACCEPTED	83	12612	2026-05-18 23:17:09.885782+07
910	61	19	17ca3a31-bb36-49e2-bb3a-4c952925e083	ACCEPTED	89	12112	2026-05-18 23:17:09.885782+07
914	61	103	3be194a3-aa08-4f99-974e-51abe41d30f5	ACCEPTED	112	12300	2026-05-18 23:17:09.885782+07
909	61	18	6c8533d2-bd00-4a62-b012-c04dd4706acc	ACCEPTED	91	12384	2026-05-18 23:17:09.885782+07
911	61	20	d4606b49-836d-4413-a4a8-f2df61355c99	ACCEPTED	102	12208	2026-05-18 23:17:09.885782+07
903	61	12	be121b66-3055-4679-a6cd-2826d08576af	ACCEPTED	104	12508	2026-05-18 23:17:09.885782+07
913	61	102	a406ee86-90ba-4067-b765-176ecf5f7b78	ACCEPTED	122	12284	2026-05-18 23:17:09.885782+07
918	61	107	d6789374-6647-405a-b0e2-716638277187	ACCEPTED	74	12680	2026-05-18 23:17:09.885782+07
917	61	106	75a805d4-30df-4857-abeb-d8a6abe5066d	ACCEPTED	80	12576	2026-05-18 23:17:09.885782+07
906	61	15	68d1caa6-8fb3-41e9-b7fc-4b8bac6cd6d7	ACCEPTED	72	12896	2026-05-18 23:17:09.885782+07
916	61	105	467a9a25-643c-49dc-9f2c-d886588227cf	ACCEPTED	47	13252	2026-05-18 23:17:09.885782+07
\.


--
-- TOC entry 5728 (class 0 OID 17494)
-- Dependencies: 266
-- Data for Name: online_judge_submissions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.online_judge_submissions (id, user_id, problem_id, lesson_id, contest_id, language_id, source_code, execution_time_ms, memory_used_kb, score, submitted_at, verdict) FROM stdin;
4	2	1	1	\N	62	import java.util.Scanner;\n\npublic class Main {\n    public static void main(String[] args) {\n        Scanner sc = new Scanner(System.in);\n        int a = sc.nextInt();\n        int b = sc.nextInt();\n        System.out.println(a + b);\n    }\n}	\N	\N	\N	2026-05-16 18:30:03.328955+07	PENDING
5	2	2	1	\N	62	import java.util.Scanner;\n\npublic class Main {\n    public static void main(String[] args) {\n        Scanner sc = new Scanner(System.in);\n        int a = sc.nextInt();\n        int b = sc.nextInt();\n        System.out.println(a + b);\n    }\n}	\N	\N	\N	2026-05-16 18:31:36.263386+07	PENDING
6	2	2	1	\N	62	import java.util.Scanner;\n\npublic class Main {\n    public static void main(String[] args) {\n        Scanner sc = new Scanner(System.in);\n        int a = sc.nextInt();\n        int b = sc.nextInt();\n        System.out.println(a + b);\n    }\n}	\N	\N	\N	2026-05-16 18:43:35.955271+07	RUNTIME_ERROR
7	2	1	1	\N	62	import java.util.Scanner;\n\npublic class Main {\n    public static void main(String[] args) {\n        Scanner sc = new Scanner(System.in);\n        int a = sc.nextInt();\n        int b = sc.nextInt();\n        System.out.println(a + b);\n    }\n}	\N	\N	\N	2026-05-16 18:43:48.563196+07	ACCEPTED
8	2	6	\N	3	62	import java.util.Scanner;\n\npublic class Main {\n    public static void main(String[] args) {\n        Scanner sc = new Scanner(System.in);\n        if (!sc.hasNextLong()) return;\n        long n = sc.nextLong();\n        if (isPrime(n)) {\n            System.out.println("YES");\n        } else {\n            System.out.println("NO");\n        }\n    }\n\n    private static boolean isPrime(long n) {\n        if (n <= 1) return false;\n        if (n <= 3) return true;\n        if (n % 2 == 0 || n % 3 == 0) return false;\n        for (long i = 5; i * i <= n; i += 6) {\n            if (n % i == 0 || n % (i + 2) == 0) return false;\n        }\n        return true;\n    }\n}	\N	\N	\N	2026-05-16 19:12:18.759123+07	ACCEPTED
9	2	1	\N	3	62	import java.util.Scanner;\n\npublic class Main {\n    public static void main(String[] args) {\n        Scanner sc = new Scanner(System.in);\n        if (!sc.hasNextLong()) return;\n        long n = sc.nextLong();\n        if (isPrime(n)) {\n            System.out.println("YES");\n        } else {\n            System.out.println("NO");\n        }\n    }\n\n    private static boolean isPrime(long n) {\n        if (n <= 1) return false;\n        if (n <= 3) return true;\n        if (n % 2 == 0 || n % 3 == 0) return false;\n        for (long i = 5; i * i <= n; i += 6) {\n            if (n % i == 0 || n % (i + 2) == 0) return false;\n        }\n        return true;\n    }\n}	\N	\N	\N	2026-05-16 19:16:23.582101+07	WRONG_ANSWER
11	2	1	1	\N	62	import java.util.Scanner;\n\npublic class Main {\n    public static void main(String[] args) {\n        Scanner sc = new Scanner(System.in);\n        if (!sc.hasNextLong()) return;\n        long n = sc.nextLong();\n        if (isPrime(n)) {\n            System.out.println("YES");\n        } else {\n            System.out.println("NO");\n        }\n    }\n\n    private static boolean isPrime(long n) {\n        if (n <= 1) return false;\n        if (n <= 3) return true;\n        if (n % 2 == 0 || n % 3 == 0) return false;\n        for (long i = 5; i * i <= n; i += 6) {\n            if (n % i == 0 || n % (i + 2) == 0) return false;\n        }\n        return true;\n    }\n}	\N	\N	\N	2026-05-16 19:18:27.010646+07	WRONG_ANSWER
18	2	6	\N	3	48	#include <stdio.h>\n#include <stdbool.h>\n\nbool isPrime(long long n) {\n    if (n <= 1) return false;\n    if (n <= 3) return true;\n    if (n % 2 == 0 || n % 3 == 0) return false;\n    for (long long i = 5; i * i <= n; i += 6) {\n        if (n % i == 0 || n % (i + 2) == 0) return false;\n    }\n    return true;\n}\n\nint main() {\n    long long n;\n    if (scanf("%lld", &n) == 1) {\n        if (isPrime(n)) {\n            printf("YES\\n");\n        } else {\n            printf("NO\\n");\n        }\n    }\n    return 0;\n}	\N	\N	\N	2026-05-16 19:29:56.02597+07	ACCEPTED
26	2	1	1	\N	48	#include <stdio.h>\n#include <stdbool.h>\n\nbool isPrime(long long n) {\n    if (n <= 1) return false;\n    if (n <= 3) return true;\n    if (n % 2 == 0 || n % 3 == 0) return false;\n    for (long long i = 5; i * i <= n; i += 6) {\n        if (n % i == 0 || n % (i + 2) == 0) return false;\n    }\n    return true;\n}\n\nint main() {\n    long long n;\n    if (scanf("%lld", &n) == 1) {\n        if (isPrime(n)) {\n            printf("YES\\n");\n        } else {\n            printf("NO\\n");\n        }\n    }\n    return 0;\n}	\N	\N	\N	2026-05-17 21:25:20.470963+07	WRONG_ANSWER
27	2	6	\N	3	48	#include <stdio.h>\n#include <stdbool.h>\n\nbool isPrime(long long n) {\n    if (n <= 1) return false;\n    if (n <= 3) return true;\n    if (n % 2 == 0 || n % 3 == 0) return false;\n    for (long long i = 5; i * i <= n; i += 6) {\n        if (n % i == 0 || n % (i + 2) == 0) return false;\n    }\n    return true;\n}\n\nint main() {\n    long long n;\n    if (scanf("%lld", &n) == 1) {\n        if (isPrime(n)) {\n            printf("YES\\n");\n        } else {\n            printf("NO\\n");\n        }\n    }\n    return 0;\n}	\N	\N	\N	2026-05-17 21:25:31.796016+07	ACCEPTED
28	2	6	\N	3	48	#include <stdio.h>\n#include <stdbool.h>\n\nbool isPrime(long long n) {\n    if (n <= 1) return false;\n    if (n <= 3) return true;\n    if (n % 2 == 0 || n % 3 == 0) return false;\n    for (long long i = 5; i * i <= n; i += 6) {\n        if (n % i == 0 || n % (i + 2) == 0) return false;\n    }\n    return true;\n}\n\nint main() {\n    long long n;\n    if (scanf("%lld", &n) == 1) {\n        if (isPrime(n)) {\n            printf("YES\\n");\n        } else {\n            printf("NO\\n");\n        }\n    }\n    return 0;\n}	\N	\N	\N	2026-05-17 21:25:43.316042+07	ACCEPTED
29	2	6	\N	3	62	import java.util.Scanner;\n\npublic class Main {\n    public static boolean isPrime(long n) {\n        if (n <= 1) return false;\n        if (n <= 3) return true;\n        if (n % 2 == 0 || n % 3 == 0) return false;\n        for (long i = 5; i * i <= n; i += 6) {\n            if (n % i == 0 || n % (i + 2) == 0) return false;\n        }\n        return true;\n    }\n\n    public static void main(String[] args) {\n        Scanner scanner = new Scanner(System.in);\n        if (scanner.hasNextLong()) {\n            long n = scanner.nextLong();\n            if (isPrime(n)) {\n                System.out.println("YES");\n            } else {\n                System.out.println("NO");\n            }\n        }\n        scanner.close();\n    }\n}	\N	\N	\N	2026-05-17 21:27:08.349484+07	ACCEPTED
12	2	6	\N	3	62	import java.util.Scanner;\n\npublic class Main {\n    public static void main(String[] args) {\n        Scanner sc = new Scanner(System.in);\n        if (!sc.hasNextLong()) return;\n        long n = sc.nextLong();\n        if (isPrime(n)) {\n            System.out.println("YES");\n        } else {\n            System.out.println("NO");\n        }\n    }\n\n    private static boolean isPrime(long n) {\n        if (n <= 1) return false;\n        if (n <= 3) return true;\n        if (n % 2 == 0 || n % 3 == 0) return false;\n        for (long i = 5; i * i <= n; i += 6) {\n            if (n % i == 0 || n % (i + 2) == 0) return false;\n        }\n        return true;\n    }\n}	\N	\N	\N	2026-05-16 19:23:48.999678+07	ACCEPTED
13	2	6	\N	3	62	import java.util.Scanner;\n\npublic class Main {\n    public static void main(String[] args) {\n        Scanner sc = new Scanner(System.in);\n        if (!sc.hasNextLong()) return;\n        long n = sc.nextLong();\n        if (isPrime(n)) {\n            System.out.println("YES");\n        } else {\n            System.out.println("NO");\n        }\n    }\n\n    private static boolean isPrime(long n) {\n        if (n <= 1) return false;\n        if (n <= 3) return true;\n        if (n % 2 == 0 || n % 3 == 0) return false;\n        for (long i = 5; i * i <= n; i += 6) {\n            if (n % i == 0 || n % (i + 2) == 0) return false;\n        }\n        return true;\n    }\n}	\N	\N	\N	2026-05-16 19:24:23.427609+07	ACCEPTED
14	2	6	\N	3	48	#include <stdio.h>\n#include <stdbool.h>\n\nbool isPrime(long long n) {\n    if (n <= 1) return false;\n    if (n <= 3) return true;\n    if (n % 2 == 0 || n % 3 == 0) return false;\n    for (long long i = 5; i * i <= n; i += 6) {\n        if (n % i == 0 || n % (i + 2) == 0) return false;\n    }\n    return true;\n}\n\nint main() {\n    long long n;\n    if (scanf("%lld", &n) == 1) {\n        if (isPrime(n)) {\n            printf("YES\\n");\n        } else {\n            printf("NO\\n");\n        }\n    }\n    return 0;\n}	\N	\N	\N	2026-05-16 19:28:30.383869+07	ACCEPTED
15	2	6	\N	3	48	#include <stdio.h>\n#include <stdbool.h>\n\nbool isPrime(long long n) {\n    if (n <= 1) return false;\n    if (n <= 3) return true;\n    if (n % 2 == 0 || n % 3 == 0) return false;\n    for (long long i = 5; i * i <= n; i += 6) {\n        if (n % i == 0 || n % (i + 2) == 0) return false;\n    }\n    return true;\n}\n\nint main() {\n    long long n;\n    if (scanf("%lld", &n) == 1) {\n        if (isPrime(n)) {\n            printf("YES\\n");\n        } else {\n            printf("NO\\n");\n        }\n    }\n    return 0;\n}	\N	\N	\N	2026-05-16 19:28:43.448177+07	ACCEPTED
16	2	6	\N	3	48	#include <stdio.h>\n#include <stdbool.h>\n\nbool isPrime(long long n) {\n    if (n <= 1) return false;\n    if (n <= 3) return true;\n    if (n % 2 == 0 || n % 3 == 0) return false;\n    for (long long i = 5; i * i <= n; i += 6) {\n        if (n % i == 0 || n % (i + 2) == 0) return false;\n    }\n    return true;\n}\n\nint main() {\n    long long n;\n    if (scanf("%lld", &n) == 1) {\n        if (isPrime(n)) {\n            printf("YES\\n");\n        } else {\n            printf("NO\\n");\n        }\n    }\n    return 0;\n}	\N	\N	\N	2026-05-16 19:29:17.697401+07	ACCEPTED
17	2	6	\N	3	48	#include <stdio.h>\n#include <stdbool.h>\n\nbool isPrime(long long n) {\n    if (n <= 1) return false;\n    if (n <= 3) return true;\n    if (n % 2 == 0 || n % 3 == 0) return false;\n    for (long long i = 5; i * i <= n; i += 6) {\n        if (n % i == 0 || n % (i + 2) == 0) return false;\n    }\n    return true;\n}\n\nint main() {\n    long long n;\n    if (scanf("%lld", &n) == 1) {\n        if (isPrime(n)) {\n            printf("YES\\n");\n        } else {\n            printf("NO\\n");\n        }\n    }\n    return 0;\n}	\N	\N	\N	2026-05-16 19:29:42.849763+07	ACCEPTED
19	2	6	\N	3	48	#include <stdio.h>\n#include <stdbool.h>\n\nbool isPrime(long long n) {\n    if (n <= 1) return false;\n    if (n <= 3) return true;\n    if (n % 2 == 0 || n % 3 == 0) return false;\n    for (long long i = 5; i * i <= n; i += 6) {\n        if (n % i == 0 || n % (i + 2) == 0) return false;\n    }\n    return true;\n}\n\nint main() {\n    long long n;\n    if (scanf("%lld", &n) == 1) {\n        if (isPrime(n)) {\n            printf("YES\\n");\n        } else {\n            printf("NO\\n");\n        }\n    }\n    return 0;\n}	\N	\N	\N	2026-05-17 21:15:53.136922+07	PENDING
20	2	6	\N	3	48	#include <stdio.h>\n#include <stdbool.h>\n\nbool isPrime(long long n) {\n    if (n <= 1) return false;\n    if (n <= 3) return true;\n    if (n % 2 == 0 || n % 3 == 0) return false;\n    for (long long i = 5; i * i <= n; i += 6) {\n        if (n % i == 0 || n % (i + 2) == 0) return false;\n    }\n    return true;\n}\n\nint main() {\n    long long n;\n    if (scanf("%lld", &n) == 1) {\n        if (isPrime(n)) {\n            printf("YES\\n");\n        } else {\n            printf("NO\\n");\n        }\n    }\n    return 0;\n}	\N	\N	\N	2026-05-17 21:16:09.09039+07	PENDING
21	2	6	\N	3	48	#include <stdio.h>\n#include <stdbool.h>\n\nbool isPrime(long long n) {\n    if (n <= 1) return false;\n    if (n <= 3) return true;\n    if (n % 2 == 0 || n % 3 == 0) return false;\n    for (long long i = 5; i * i <= n; i += 6) {\n        if (n % i == 0 || n % (i + 2) == 0) return false;\n    }\n    return true;\n}\n\nint main() {\n    long long n;\n    if (scanf("%lld", &n) == 1) {\n        if (isPrime(n)) {\n            printf("YES\\n");\n        } else {\n            printf("NO\\n");\n        }\n    }\n    return 0;\n}	\N	\N	\N	2026-05-17 21:16:40.518101+07	PENDING
22	2	6	\N	3	48	#include <stdio.h>\n#include <stdbool.h>\n\nbool isPrime(long long n) {\n    if (n <= 1) return false;\n    if (n <= 3) return true;\n    if (n % 2 == 0 || n % 3 == 0) return false;\n    for (long long i = 5; i * i <= n; i += 6) {\n        if (n % i == 0 || n % (i + 2) == 0) return false;\n    }\n    return true;\n}\n\nint main() {\n    long long n;\n    if (scanf("%lld", &n) == 1) {\n        if (isPrime(n)) {\n            printf("YES\\n");\n        } else {\n            printf("NO\\n");\n        }\n    }\n    return 0;\n}	\N	\N	\N	2026-05-17 21:17:04.788845+07	PENDING
23	2	6	\N	3	48	#include <stdio.h>\n#include <stdbool.h>\n\nbool isPrime(long long n) {\n    if (n <= 1) return false;\n    if (n <= 3) return true;\n    if (n % 2 == 0 || n % 3 == 0) return false;\n    for (long long i = 5; i * i <= n; i += 6) {\n        if (n % i == 0 || n % (i + 2) == 0) return false;\n    }\n    return true;\n}\n\nint main() {\n    long long n;\n    if (scanf("%lld", &n) == 1) {\n        if (isPrime(n)) {\n            printf("YES\\n");\n        } else {\n            printf("NO\\n");\n        }\n    }\n    return 0;\n}	\N	\N	\N	2026-05-17 21:17:27.972409+07	PENDING
24	2	1	1	\N	48	#include <stdio.h>\n#include <stdbool.h>\n\nbool isPrime(long long n) {\n    if (n <= 1) return false;\n    if (n <= 3) return true;\n    if (n % 2 == 0 || n % 3 == 0) return false;\n    for (long long i = 5; i * i <= n; i += 6) {\n        if (n % i == 0 || n % (i + 2) == 0) return false;\n    }\n    return true;\n}\n\nint main() {\n    long long n;\n    if (scanf("%lld", &n) == 1) {\n        if (isPrime(n)) {\n            printf("YES\\n");\n        } else {\n            printf("NO\\n");\n        }\n    }\n    return 0;\n}	\N	\N	\N	2026-05-17 21:19:12.847016+07	PENDING
25	2	1	1	\N	48	#include <stdio.h>\n#include <stdbool.h>\n\nbool isPrime(long long n) {\n    if (n <= 1) return false;\n    if (n <= 3) return true;\n    if (n % 2 == 0 || n % 3 == 0) return false;\n    for (long long i = 5; i * i <= n; i += 6) {\n        if (n % i == 0 || n % (i + 2) == 0) return false;\n    }\n    return true;\n}\n\nint main() {\n    long long n;\n    if (scanf("%lld", &n) == 1) {\n        if (isPrime(n)) {\n            printf("YES\\n");\n        } else {\n            printf("NO\\n");\n        }\n    }\n    return 0;\n}	\N	\N	\N	2026-05-17 21:19:33.068645+07	PENDING
30	2	6	\N	3	62	import java.util.Scanner;\n\npublic class Main {\n    public static boolean isPrime(long n) {\n        if (n <= 1) return false;\n        if (n <= 3) return true;\n        if (n % 2 == 0 || n % 3 == 0) return false;\n        for (long i = 5; i * i <= n; i += 6) {\n            if (n % i == 0 || n % (i + 2) == 0) return false;\n        }\n        return true;\n    }\n\n    public static void main(String[] args) {\n        Scanner scanner = new Scanner(System.in);\n        if (scanner.hasNextLong()) {\n            long n = scanner.nextLong();\n            if (isPrime(n)) {\n                System.out.println("YES");\n            } else {\n                System.out.println("NO");\n            }\n        }\n        scanner.close();\n    }\n}	\N	\N	\N	2026-05-17 21:27:25.254851+07	ACCEPTED
31	2	6	1	\N	62	import java.util.Scanner;\n\npublic class Main {\n    public static boolean isPrime(long n) {\n        if (n <= 1) return false;\n        if (n <= 3) return true;\n        if (n % 2 == 0 || n % 3 == 0) return false;\n        for (long i = 5; i * i <= n; i += 6) {\n            if (n % i == 0 || n % (i + 2) == 0) return false;\n        }\n        return true;\n    }\n\n    public static void main(String[] args) {\n        Scanner scanner = new Scanner(System.in);\n        if (scanner.hasNextLong()) {\n            long n = scanner.nextLong();\n            if (isPrime(n)) {\n                System.out.println("YES");\n            } else {\n                System.out.println("NO");\n            }\n        }\n        scanner.close();\n    }\n}	\N	\N	\N	2026-05-17 21:31:29.112465+07	ACCEPTED
32	2	7	1	\N	62	import java.util.Scanner;\n\npublic class Main {\n    public static boolean isPrime(long n) {\n        if (n <= 1) return false;\n        if (n <= 3) return true;\n        if (n % 2 == 0 || n % 3 == 0) return false;\n        for (long i = 5; i * i <= n; i += 6) {\n            if (n % i == 0 || n % (i + 2) == 0) return false;\n        }\n        return true;\n    }\n\n    public static void main(String[] args) {\n        Scanner scanner = new Scanner(System.in);\n        if (scanner.hasNextLong()) {\n            long n = scanner.nextLong();\n            if (isPrime(n)) {\n                System.out.println("YES");\n            } else {\n                System.out.println("NO");\n            }\n        }\n        scanner.close();\n    }\n}	\N	\N	\N	2026-05-17 21:33:51.313139+07	ACCEPTED
33	2	7	1	\N	62	import java.util.Scanner;\n\npublic class Main {\n    public static boolean isPrime(long n) {\n        if (n <= 1) return false;\n        if (n <= 3) return true;\n        if (n % 2 == 0 || n % 3 == 0) return false;\n        for (long i = 5; i * i <= n; i += 6) {\n            if (n % i == 0 || n % (i + 2) == 0) return false;\n        }\n        return true;\n    }\n\n    public static void main(String[] args) {\n        Scanner scanner = new Scanner(System.in);\n        if (scanner.hasNextLong()) {\n            long n = scanner.nextLong();\n            if (isPrime(n)) {\n                System.out.println("YES");\n            } else {\n                System.out.println("NO");\n            }\n        }\n        scanner.close();\n    }\n}	\N	\N	\N	2026-05-17 22:49:52.388931+07	ACCEPTED
34	2	7	1	\N	62	import java.util.Scanner;\n\npublic class Main {\n    public static boolean isPrime(long n) {\n        if (n <= 1) return false;\n        if (n <= 3) return true;\n        if (n % 2 == 0 || n % 3 == 0) return false;\n        for (long i = 5; i * i <= n; i += 6) {\n            if (n % i == 0 || n % (i + 2) == 0) return false;\n        }\n        return true;\n    }\n\n    public static void main(String[] args) {\n        Scanner scanner = new Scanner(System.in);\n        if (scanner.hasNextLong()) {\n            long n = scanner.nextLong();\n            if (isPrime(n)) {\n                System.out.println("YES");\n            } else {\n                System.out.println("NO");\n            }\n        }\n        scanner.close();\n    }\n}	\N	\N	\N	2026-05-17 22:50:37.31221+07	ACCEPTED
35	2	8	1	\N	62	import java.util.Scanner;\n\npublic class Main {\n    public static void main(String[] args) {\n        Scanner sc = new Scanner(System.in);\n        if (sc.hasNextLong()) {\n            long n = sc.nextLong();\n            long a = sc.nextLong();\n            long b = sc.nextLong();\n            \n            long count = 0;\n            // Vòng lặp ngây thơ, sẽ nổ tung với N = 10^18\n            for (long i = 1; i <= n; i++) {\n                if (i % a == 0 || i % b == 0) {\n                    count++;\n                }\n            }\n            System.out.println(count);\n        }\n        sc.close();\n    }\n}	\N	\N	\N	2026-05-17 22:53:42.303084+07	TIME_LIMIT_EXCEEDED
36	2	8	1	\N	62	import java.util.Scanner;\n\npublic class Main {\n    // Hàm tìm Ước chung lớn nhất\n    public static long gcd(long a, long b) {\n        if (b == 0) return a;\n        return gcd(b, a % b);\n    }\n\n    // Hàm tìm Bội chung nhỏ nhất\n    public static long lcm(long a, long b) {\n        return (a / gcd(a, b)) * b;\n    }\n\n    public static void main(String[] args) {\n        Scanner sc = new Scanner(System.in);\n        if (sc.hasNextLong()) {\n            long n = sc.nextLong();\n            long a = sc.nextLong();\n            long b = sc.nextLong();\n\n            long countA = n / a;\n            long countB = n / b;\n            long countBoth = n / lcm(a, b);\n\n            System.out.println(countA + countB - countBoth);\n        }\n        sc.close();\n    }\n}	\N	\N	\N	2026-05-17 22:54:30.795556+07	WRONG_ANSWER
37	2	8	1	\N	62	import java.util.Scanner;\n\npublic class Main {\n    // Tìm Ước chung lớn nhất (GCD)\n    public static long gcd(long a, long b) {\n        while (b != 0) {\n            long temp = b;\n            b = a % b;\n            a = temp;\n        }\n        return a;\n    }\n\n    // Tìm Bội chung nhỏ nhất (LCM) - Ép chia trước, nhân sau để chống tràn số\n    public static long lcm(long a, long b) {\n        return (a / gcd(a, b)) * b;\n    }\n\n    public static void main(String[] args) {\n        Scanner sc = new Scanner(System.in);\n        if (sc.hasNextLong()) {\n            long n = sc.nextLong();\n            long a = sc.nextLong();\n            long b = sc.nextLong();\n\n            // Tính tổng các số chia hết cho A trong khoảng từ 1 đến N\n            long countA = n / a;\n            \n            // Tính tổng các số chia hết cho B trong khoảng từ 1 đến N\n            long countB = n / b;\n\n            // Tính LCM(A, B)\n            long lcmAB = lcm(a, b);\n            \n            // Tính tổng các số chia hết cho cả A và B (chia hết cho LCM)\n            // Phòng trường hợp LCM quá lớn (có thể bị âm do tràn nếu A, B cực lớn)\n            // Nhưng do giới hạn A, B <= 10^5 nên LCM <= 10^10, kiểu long hoàn toàn chứa được.\n            long countBoth = n / lcmAB;\n\n            // Áp dụng nguyên lý Bao Hàm - Loại Trừ: |A ∪ B| = |A| + |B| - |A ∩ B|\n            long result = countA + countB - countBoth;\n            System.out.println(result);\n        }\n        sc.close();\n    }\n}	\N	\N	\N	2026-05-17 22:56:42.656557+07	WRONG_ANSWER
38	2	8	1	\N	62	import java.util.Scanner;\n\npublic class Main {\n    // Tìm Ước chung lớn nhất (GCD)\n    public static long gcd(long a, long b) {\n        while (b != 0) {\n            long temp = b;\n            b = a % b;\n            a = temp;\n        }\n        return a;\n    }\n\n    // Tìm Bội chung nhỏ nhất (LCM) - Ép chia trước, nhân sau để chống tràn số\n    public static long lcm(long a, long b) {\n        return (a / gcd(a, b)) * b;\n    }\n\n    public static void main(String[] args) {\n        Scanner sc = new Scanner(System.in);\n        if (sc.hasNextLong()) {\n            long n = sc.nextLong();\n            long a = sc.nextLong();\n            long b = sc.nextLong();\n\n            // Tính tổng các số chia hết cho A trong khoảng từ 1 đến N\n            long countA = n / a;\n            \n            // Tính tổng các số chia hết cho B trong khoảng từ 1 đến N\n            long countB = n / b;\n\n            // Tính LCM(A, B)\n            long lcmAB = lcm(a, b);\n            \n            // Tính tổng các số chia hết cho cả A và B (chia hết cho LCM)\n            // Phòng trường hợp LCM quá lớn (có thể bị âm do tràn nếu A, B cực lớn)\n            // Nhưng do giới hạn A, B <= 10^5 nên LCM <= 10^10, kiểu long hoàn toàn chứa được.\n            long countBoth = n / lcmAB;\n\n            // Áp dụng nguyên lý Bao Hàm - Loại Trừ: |A ∪ B| = |A| + |B| - |A ∩ B|\n            long result = countA + countB - countBoth;\n            System.out.println(result);\n        }\n        sc.close();\n    }\n}	\N	\N	\N	2026-05-17 22:59:03.314457+07	WRONG_ANSWER
39	2	8	1	\N	62	import java.util.Scanner;\nimport java.math.BigInteger;\n\npublic class Main {\n    public static void main(String[] args) {\n        Scanner sc = new Scanner(System.in);\n        if (sc.hasNext()) {\n            // Đọc N, A, B dưới dạng BigInteger để chống tràn số tuyệt đối\n            BigInteger n = new BigInteger(sc.next());\n            BigInteger a = new BigInteger(sc.next());\n            BigInteger b = new BigInteger(sc.next());\n\n            // Tìm GCD(A, B)\n            BigInteger gcd = a.gcd(b);\n\n            // Tìm LCM(A, B) = (A * B) / GCD\n            BigInteger lcm = a.multiply(b).divide(gcd);\n\n            // Đếm số lượng chia hết cho A: n / a\n            BigInteger countA = n.divide(a);\n\n            // Đếm số lượng chia hết cho B: n / b\n            BigInteger countB = n.divide(b);\n\n            // Đếm số lượng chia hết cho cả A và B: n / lcm\n            BigInteger countBoth = n.divide(lcm);\n\n            // Bao hàm - Loại trừ: countA + countB - countBoth\n            BigInteger result = countA.add(countB).subtract(countBoth);\n\n            System.out.println(result.toString());\n        }\n        sc.close();\n    }\n}	\N	\N	\N	2026-05-17 23:00:44.126215+07	WRONG_ANSWER
40	2	8	1	\N	62	import java.util.Scanner;\nimport java.math.BigInteger;\n\npublic class Main {\n    public static void main(String[] args) {\n        Scanner sc = new Scanner(System.in);\n        if (sc.hasNext()) {\n            // Đọc N, A, B dưới dạng BigInteger để chống tràn số tuyệt đối\n            BigInteger n = new BigInteger(sc.next());\n            BigInteger a = new BigInteger(sc.next());\n            BigInteger b = new BigInteger(sc.next());\n\n            // Tìm GCD(A, B)\n            BigInteger gcd = a.gcd(b);\n\n            // Tìm LCM(A, B) = (A * B) / GCD\n            BigInteger lcm = a.multiply(b).divide(gcd);\n\n            // Đếm số lượng chia hết cho A: n / a\n            BigInteger countA = n.divide(a);\n\n            // Đếm số lượng chia hết cho B: n / b\n            BigInteger countB = n.divide(b);\n\n            // Đếm số lượng chia hết cho cả A và B: n / lcm\n            BigInteger countBoth = n.divide(lcm);\n\n            // Bao hàm - Loại trừ: countA + countB - countBoth\n            BigInteger result = countA.add(countB).subtract(countBoth);\n\n            System.out.println(result.toString());\n        }\n        sc.close();\n    }\n}	\N	\N	\N	2026-05-17 23:03:32.689565+07	WRONG_ANSWER
43	2	8	1	\N	62	import java.io.BufferedReader;\nimport java.io.InputStreamReader;\nimport java.io.IOException;\nimport java.util.StringTokenizer;\nimport java.math.BigInteger;\n\npublic class Main {\n    public static void main(String[] args) throws IOException {\n        BufferedReader br = new BufferedReader(new InputStreamReader(System.in));\n        String line = br.readLine();\n        if (line != null && !line.trim().isEmpty()) {\n            StringTokenizer st = new StringTokenizer(line);\n            \n            // Đọc N, A, B an toàn, loại bỏ mọi khoảng trắng thừa\n            BigInteger n = new BigInteger(st.nextToken().trim());\n            BigInteger a = new BigInteger(st.nextToken().trim());\n            BigInteger b = new BigInteger(st.nextToken().trim());\n\n            // Tính GCD an toàn\n            BigInteger gcd = a.gcd(b);\n\n            // Tính LCM = (A / GCD) * B để chống tràn và sai số tuyệt đối\n            BigInteger lcm = a.divide(gcd).multiply(b);\n\n            // Tính các thành phần\n            BigInteger countA = n.divide(a);\n            BigInteger countB = n.divide(b);\n            BigInteger countBoth = n.divide(lcm);\n\n            // Kết quả = countA + countB - countBoth\n            BigInteger result = countA.add(countB).subtract(countBoth);\n\n            System.out.println(result.toString());\n        }\n    }\n}	\N	\N	\N	2026-05-17 23:10:06.506626+07	WRONG_ANSWER
41	2	8	1	\N	62	import java.util.Scanner;\nimport java.math.BigInteger;\n\npublic class Main {\n    public static void main(String[] args) {\n        Scanner sc = new Scanner(System.in);\n        if (sc.hasNext()) {\n            // Đọc N, A, B dưới dạng BigInteger để chống tràn số tuyệt đối\n            BigInteger n = new BigInteger(sc.next());\n            BigInteger a = new BigInteger(sc.next());\n            BigInteger b = new BigInteger(sc.next());\n\n            // Tìm GCD(A, B)\n            BigInteger gcd = a.gcd(b);\n\n            // Tìm LCM(A, B) = (A * B) / GCD\n            BigInteger lcm = a.multiply(b).divide(gcd);\n\n            // Đếm số lượng chia hết cho A: n / a\n            BigInteger countA = n.divide(a);\n\n            // Đếm số lượng chia hết cho B: n / b\n            BigInteger countB = n.divide(b);\n\n            // Đếm số lượng chia hết cho cả A và B: n / lcm\n            BigInteger countBoth = n.divide(lcm);\n\n            // Bao hàm - Loại trừ: countA + countB - countBoth\n            BigInteger result = countA.add(countB).subtract(countBoth);\n\n            System.out.println(result.toString());\n        }\n        sc.close();\n    }\n}	\N	\N	\N	2026-05-17 23:08:15.452552+07	WRONG_ANSWER
42	2	8	1	\N	62	import java.util.Scanner;\nimport java.math.BigInteger;\n\npublic class Main {\n    public static void main(String[] args) {\n        Scanner sc = new Scanner(System.in);\n        if (sc.hasNext()) {\n            // Đọc N, A, B dưới dạng BigInteger để chống tràn số tuyệt đối\n            BigInteger n = new BigInteger(sc.next());\n            BigInteger a = new BigInteger(sc.next());\n            BigInteger b = new BigInteger(sc.next());\n\n            // Tìm GCD(A, B)\n            BigInteger gcd = a.gcd(b);\n\n            // Tìm LCM(A, B) = (A * B) / GCD\n            BigInteger lcm = a.multiply(b).divide(gcd);\n\n            // Đếm số lượng chia hết cho A: n / a\n            BigInteger countA = n.divide(a);\n\n            // Đếm số lượng chia hết cho B: n / b\n            BigInteger countB = n.divide(b);\n\n            // Đếm số lượng chia hết cho cả A và B: n / lcm\n            BigInteger countBoth = n.divide(lcm);\n\n            // Bao hàm - Loại trừ: countA + countB - countBoth\n            BigInteger result = countA.add(countB).subtract(countBoth);\n\n            System.out.println(result.toString());\n        }\n        sc.close();\n    }\n}	\N	\N	\N	2026-05-17 23:09:32.169729+07	WRONG_ANSWER
44	2	8	1	\N	62	import java.io.BufferedReader;\nimport java.io.InputStreamReader;\nimport java.io.IOException;\nimport java.util.StringTokenizer;\nimport java.math.BigInteger;\n\npublic class Main {\n    public static void main(String[] args) throws IOException {\n        BufferedReader br = new BufferedReader(new InputStreamReader(System.in));\n        String line = br.readLine();\n        if (line != null && !line.trim().isEmpty()) {\n            StringTokenizer st = new StringTokenizer(line);\n            \n            // Đọc N, A, B an toàn, loại bỏ mọi khoảng trắng thừa\n            BigInteger n = new BigInteger(st.nextToken().trim());\n            BigInteger a = new BigInteger(st.nextToken().trim());\n            BigInteger b = new BigInteger(st.nextToken().trim());\n\n            // Tính GCD an toàn\n            BigInteger gcd = a.gcd(b);\n\n            // Tính LCM = (A / GCD) * B để chống tràn và sai số tuyệt đối\n            BigInteger lcm = a.divide(gcd).multiply(b);\n\n            // Tính các thành phần\n            BigInteger countA = n.divide(a);\n            BigInteger countB = n.divide(b);\n            BigInteger countBoth = n.divide(lcm);\n\n            // Kết quả = countA + countB - countBoth\n            BigInteger result = countA.add(countB).subtract(countBoth);\n\n            System.out.println(result.toString());\n        }\n    }\n}	\N	\N	\N	2026-05-17 23:14:39.048409+07	WRONG_ANSWER
45	2	8	1	\N	62	import java.io.BufferedReader;\nimport java.io.InputStreamReader;\nimport java.io.IOException;\nimport java.util.StringTokenizer;\nimport java.math.BigInteger;\n\npublic class Main {\n    public static void main(String[] args) throws IOException {\n        BufferedReader br = new BufferedReader(new InputStreamReader(System.in));\n        String line = br.readLine();\n        if (line != null && !line.trim().isEmpty()) {\n            StringTokenizer st = new StringTokenizer(line);\n            \n            // Đọc N, A, B an toàn, loại bỏ mọi khoảng trắng thừa\n            BigInteger n = new BigInteger(st.nextToken().trim());\n            BigInteger a = new BigInteger(st.nextToken().trim());\n            BigInteger b = new BigInteger(st.nextToken().trim());\n\n            // Tính GCD an toàn\n            BigInteger gcd = a.gcd(b);\n\n            // Tính LCM = (A / GCD) * B để chống tràn và sai số tuyệt đối\n            BigInteger lcm = a.divide(gcd).multiply(b);\n\n            // Tính các thành phần\n            BigInteger countA = n.divide(a);\n            BigInteger countB = n.divide(b);\n            BigInteger countBoth = n.divide(lcm);\n\n            // Kết quả = countA + countB - countBoth\n            BigInteger result = countA.add(countB).subtract(countBoth);\n\n            System.out.println(result.toString());\n        }\n    }\n}	\N	\N	\N	2026-05-17 23:15:18.725942+07	WRONG_ANSWER
46	2	8	1	\N	62	import java.io.BufferedReader;\nimport java.io.InputStreamReader;\nimport java.io.IOException;\nimport java.util.StringTokenizer;\nimport java.math.BigInteger;\n\npublic class Main {\n    public static void main(String[] args) throws IOException {\n        BufferedReader br = new BufferedReader(new InputStreamReader(System.in));\n        String line = br.readLine();\n        if (line != null && !line.trim().isEmpty()) {\n            StringTokenizer st = new StringTokenizer(line);\n            \n            // Đọc N, A, B an toàn, loại bỏ mọi khoảng trắng thừa\n            BigInteger n = new BigInteger(st.nextToken().trim());\n            BigInteger a = new BigInteger(st.nextToken().trim());\n            BigInteger b = new BigInteger(st.nextToken().trim());\n\n            // Tính GCD an toàn\n            BigInteger gcd = a.gcd(b);\n\n            // Tính LCM = (A / GCD) * B để chống tràn và sai số tuyệt đối\n            BigInteger lcm = a.divide(gcd).multiply(b);\n\n            // Tính các thành phần\n            BigInteger countA = n.divide(a);\n            BigInteger countB = n.divide(b);\n            BigInteger countBoth = n.divide(lcm);\n\n            // Kết quả = countA + countB - countBoth\n            BigInteger result = countA.add(countB).subtract(countBoth);\n\n            System.out.println(result.toString());\n        }\n    }\n}	\N	\N	\N	2026-05-17 23:15:30.980939+07	WRONG_ANSWER
47	2	8	1	\N	62	import java.io.BufferedReader;\nimport java.io.InputStreamReader;\nimport java.io.IOException;\nimport java.util.StringTokenizer;\nimport java.math.BigInteger;\n\npublic class Main {\n    public static void main(String[] args) throws IOException {\n        BufferedReader br = new BufferedReader(new InputStreamReader(System.in));\n        String line = br.readLine();\n        if (line != null && !line.trim().isEmpty()) {\n            StringTokenizer st = new StringTokenizer(line);\n            \n            // Đọc N, A, B an toàn, loại bỏ mọi khoảng trắng thừa\n            BigInteger n = new BigInteger(st.nextToken().trim());\n            BigInteger a = new BigInteger(st.nextToken().trim());\n            BigInteger b = new BigInteger(st.nextToken().trim());\n\n            // Tính GCD an toàn\n            BigInteger gcd = a.gcd(b);\n\n            // Tính LCM = (A / GCD) * B để chống tràn và sai số tuyệt đối\n            BigInteger lcm = a.divide(gcd).multiply(b);\n\n            // Tính các thành phần\n            BigInteger countA = n.divide(a);\n            BigInteger countB = n.divide(b);\n            BigInteger countBoth = n.divide(lcm);\n\n            // Kết quả = countA + countB - countBoth\n            BigInteger result = countA.add(countB).subtract(countBoth);\n\n            System.out.println(result.toString());\n        }\n    }\n}	\N	\N	\N	2026-05-17 23:15:48.529501+07	WRONG_ANSWER
48	2	8	1	\N	62	import java.io.BufferedReader;\nimport java.io.InputStreamReader;\nimport java.io.IOException;\nimport java.util.StringTokenizer;\nimport java.math.BigInteger;\n\npublic class Main {\n    public static void main(String[] args) throws IOException {\n        BufferedReader br = new BufferedReader(new InputStreamReader(System.in));\n        String line = br.readLine();\n        if (line != null && !line.trim().isEmpty()) {\n            StringTokenizer st = new StringTokenizer(line);\n            \n            // Đọc N, A, B an toàn, loại bỏ mọi khoảng trắng thừa\n            BigInteger n = new BigInteger(st.nextToken().trim());\n            BigInteger a = new BigInteger(st.nextToken().trim());\n            BigInteger b = new BigInteger(st.nextToken().trim());\n\n            // Tính GCD an toàn\n            BigInteger gcd = a.gcd(b);\n\n            // Tính LCM = (A / GCD) * B để chống tràn và sai số tuyệt đối\n            BigInteger lcm = a.divide(gcd).multiply(b);\n\n            // Tính các thành phần\n            BigInteger countA = n.divide(a);\n            BigInteger countB = n.divide(b);\n            BigInteger countBoth = n.divide(lcm);\n\n            // Kết quả = countA + countB - countBoth\n            BigInteger result = countA.add(countB).subtract(countBoth);\n\n            System.out.println(result.toString());\n        }\n    }\n}	\N	\N	\N	2026-05-17 23:16:35.682782+07	WRONG_ANSWER
49	2	8	1	\N	62	import java.io.BufferedReader;\nimport java.io.InputStreamReader;\nimport java.io.IOException;\nimport java.util.StringTokenizer;\nimport java.math.BigInteger;\n\npublic class Main {\n    public static void main(String[] args) throws IOException {\n        BufferedReader br = new BufferedReader(new InputStreamReader(System.in));\n        String line = br.readLine();\n        if (line != null && !line.trim().isEmpty()) {\n            StringTokenizer st = new StringTokenizer(line);\n            \n            // Đọc N, A, B an toàn, loại bỏ mọi khoảng trắng thừa\n            BigInteger n = new BigInteger(st.nextToken().trim());\n            BigInteger a = new BigInteger(st.nextToken().trim());\n            BigInteger b = new BigInteger(st.nextToken().trim());\n\n            // Tính GCD an toàn\n            BigInteger gcd = a.gcd(b);\n\n            // Tính LCM = (A / GCD) * B để chống tràn và sai số tuyệt đối\n            BigInteger lcm = a.divide(gcd).multiply(b);\n\n            // Tính các thành phần\n            BigInteger countA = n.divide(a);\n            BigInteger countB = n.divide(b);\n            BigInteger countBoth = n.divide(lcm);\n\n            // Kết quả = countA + countB - countBoth\n            BigInteger result = countA.add(countB).subtract(countBoth);\n\n            System.out.println(result.toString());\n        }\n    }\n}	\N	\N	\N	2026-05-17 23:16:45.824023+07	WRONG_ANSWER
50	2	1	1	\N	62	import java.io.BufferedReader;\nimport java.io.InputStreamReader;\nimport java.io.IOException;\nimport java.util.StringTokenizer;\nimport java.math.BigInteger;\n\npublic class Main {\n    public static void main(String[] args) throws IOException {\n        BufferedReader br = new BufferedReader(new InputStreamReader(System.in));\n        String line = br.readLine();\n        if (line != null && !line.trim().isEmpty()) {\n            StringTokenizer st = new StringTokenizer(line);\n            \n            // Đọc N, A, B an toàn, loại bỏ mọi khoảng trắng thừa\n            BigInteger n = new BigInteger(st.nextToken().trim());\n            BigInteger a = new BigInteger(st.nextToken().trim());\n            BigInteger b = new BigInteger(st.nextToken().trim());\n\n            // Tính GCD an toàn\n            BigInteger gcd = a.gcd(b);\n\n            // Tính LCM = (A / GCD) * B để chống tràn và sai số tuyệt đối\n            BigInteger lcm = a.divide(gcd).multiply(b);\n\n            // Tính các thành phần\n            BigInteger countA = n.divide(a);\n            BigInteger countB = n.divide(b);\n            BigInteger countBoth = n.divide(lcm);\n\n            // Kết quả = countA + countB - countBoth\n            BigInteger result = countA.add(countB).subtract(countBoth);\n\n            System.out.println(result.toString());\n        }\n    }\n}	\N	\N	\N	2026-05-17 23:18:11.539952+07	RUNTIME_ERROR
51	2	8	1	\N	50	#include <stdio.h>\n\n// Hàm tính Ước chung lớn nhất (GCD)\nunsigned long long gcd(unsigned long long a, unsigned long long b) {\n    while (b != 0) {\n        unsigned long long temp = b;\n        b = a % b;\n        a = temp;\n    }\n    return a;\n}\n\n// Hàm tính Bội chung nhỏ nhất (LCM) - Ép chia trước, nhân sau để chống tràn\nunsigned long long lcm(unsigned long long a, unsigned long long b) {\n    return (a / gcd(a, b)) * b;\n}\n\nint main() {\n    unsigned long long n, a, b;\n    \n    // Đọc đầu vào an toàn\n    if (scanf("%llu %llu %llu", &n, &a, &b) == 3) {\n        \n        unsigned long long countA = n / a;\n        unsigned long long countB = n / b;\n        \n        // Tính LCM an toàn\n        unsigned long long lcmAB = lcm(a, b);\n        unsigned long long countBoth = n / lcmAB;\n        \n        // Nguyên lý Bao hàm - Loại trừ\n        unsigned long long result = countA + countB - countBoth;\n        \n        // In kết quả\n        printf("%llu\\n", result);\n    }\n    \n    return 0;\n}	\N	\N	\N	2026-05-17 23:20:30.34527+07	WRONG_ANSWER
52	2	8	1	\N	50	#include <stdio.h>\n\n// Hàm tính Ước chung lớn nhất (GCD)\nunsigned long long gcd(unsigned long long a, unsigned long long b) {\n    while (b != 0) {\n        unsigned long long temp = b;\n        b = a % b;\n        a = temp;\n    }\n    return a;\n}\n\n// Hàm tính Bội chung nhỏ nhất (LCM) - Ép chia trước, nhân sau để chống tràn\nunsigned long long lcm(unsigned long long a, unsigned long long b) {\n    return (a / gcd(a, b)) * b;\n}\n\nint main() {\n    unsigned long long n, a, b;\n    \n    // Đọc đầu vào an toàn\n    if (scanf("%llu %llu %llu", &n, &a, &b) == 3) {\n        \n        unsigned long long countA = n / a;\n        unsigned long long countB = n / b;\n        \n        // Tính LCM an toàn\n        unsigned long long lcmAB = lcm(a, b);\n        unsigned long long countBoth = n / lcmAB;\n        \n        // Nguyên lý Bao hàm - Loại trừ\n        unsigned long long result = countA + countB - countBoth;\n        \n        // In kết quả\n        printf("%llu\\n", result);\n    }\n    \n    return 0;\n}	\N	\N	\N	2026-05-17 23:20:57.582812+07	WRONG_ANSWER
53	2	8	1	\N	50	#include <stdio.h>\n\n// Hàm tính Ước chung lớn nhất (GCD)\nunsigned long long gcd(unsigned long long a, unsigned long long b) {\n    while (b != 0) {\n        unsigned long long temp = b;\n        b = a % b;\n        a = temp;\n    }\n    return a;\n}\n\n// Hàm tính Bội chung nhỏ nhất (LCM) - Ép chia trước, nhân sau để chống tràn\nunsigned long long lcm(unsigned long long a, unsigned long long b) {\n    return (a / gcd(a, b)) * b;\n}\n\nint main() {\n    unsigned long long n, a, b;\n    \n    // Đọc đầu vào an toàn\n    if (scanf("%llu %llu %llu", &n, &a, &b) == 3) {\n        \n        unsigned long long countA = n / a;\n        unsigned long long countB = n / b;\n        \n        // Tính LCM an toàn\n        unsigned long long lcmAB = lcm(a, b);\n        unsigned long long countBoth = n / lcmAB;\n        \n        // Nguyên lý Bao hàm - Loại trừ\n        unsigned long long result = countA + countB - countBoth;\n        \n        // In kết quả\n        printf("%llu\\n", result);\n    }\n    \n    return 0;\n}	\N	\N	\N	2026-05-17 23:21:02.95319+07	WRONG_ANSWER
54	2	8	1	\N	50	#include <stdio.h>\n\n// Hàm tính Ước chung lớn nhất (GCD)\nunsigned long long gcd(unsigned long long a, unsigned long long b) {\n    while (b != 0) {\n        unsigned long long temp = b;\n        b = a % b;\n        a = temp;\n    }\n    return a;\n}\n\n// Hàm tính Bội chung nhỏ nhất (LCM) - Ép chia trước, nhân sau để chống tràn\nunsigned long long lcm(unsigned long long a, unsigned long long b) {\n    return (a / gcd(a, b)) * b;\n}\n\nint main() {\n    unsigned long long n, a, b;\n    \n    // Đọc đầu vào an toàn\n    if (scanf("%llu %llu %llu", &n, &a, &b) == 3) {\n        \n        unsigned long long countA = n / a;\n        unsigned long long countB = n / b;\n        \n        // Tính LCM an toàn\n        unsigned long long lcmAB = lcm(a, b);\n        unsigned long long countBoth = n / lcmAB;\n        \n        // Nguyên lý Bao hàm - Loại trừ\n        unsigned long long result = countA + countB - countBoth;\n        \n        // In kết quả\n        printf("%llu\\n", result);\n    }\n    \n    return 0;\n}	\N	\N	\N	2026-05-17 23:22:37.512389+07	WRONG_ANSWER
55	2	8	1	\N	50	#include <stdio.h>\n\n// Hàm tính Ước chung lớn nhất (GCD)\nunsigned long long gcd(unsigned long long a, unsigned long long b) {\n    while (b != 0) {\n        unsigned long long temp = b;\n        b = a % b;\n        a = temp;\n    }\n    return a;\n}\n\n// Hàm tính Bội chung nhỏ nhất (LCM) - Ép chia trước, nhân sau để chống tràn\nunsigned long long lcm(unsigned long long a, unsigned long long b) {\n    return (a / gcd(a, b)) * b;\n}\n\nint main() {\n    unsigned long long n, a, b;\n    \n    // Đọc đầu vào an toàn\n    if (scanf("%llu %llu %llu", &n, &a, &b) == 3) {\n        \n        unsigned long long countA = n / a;\n        unsigned long long countB = n / b;\n        \n        // Tính LCM an toàn\n        unsigned long long lcmAB = lcm(a, b);\n        unsigned long long countBoth = n / lcmAB;\n        \n        // Nguyên lý Bao hàm - Loại trừ\n        unsigned long long result = countA + countB - countBoth;\n        \n        // In kết quả\n        printf("%llu\\n", result);\n    }\n    \n    return 0;\n}	5	3684	\N	2026-05-18 23:00:51.627797+07	WRONG_ANSWER
58	2	6	\N	3	50	#include <stdio.h>\n\n// Hàm tính Ước chung lớn nhất (GCD)\nunsigned long long gcd(unsigned long long a, unsigned long long b) {\n    while (b != 0) {\n        unsigned long long temp = b;\n        b = a % b;\n        a = temp;\n    }\n    return a;\n}\n\n// Hàm tính Bội chung nhỏ nhất (LCM) - Ép chia trước, nhân sau để chống tràn\nunsigned long long lcm(unsigned long long a, unsigned long long b) {\n    return (a / gcd(a, b)) * b;\n}\n\nint main() {\n    unsigned long long n, a, b;\n    \n    // Đọc đầu vào an toàn\n    if (scanf("%llu %llu %llu", &n, &a, &b) == 3) {\n        \n        unsigned long long countA = n / a;\n        unsigned long long countB = n / b;\n        \n        // Tính LCM an toàn\n        unsigned long long lcmAB = lcm(a, b);\n        unsigned long long countBoth = n / lcmAB;\n        \n        // Nguyên lý Bao hàm - Loại trừ\n        unsigned long long result = countA + countB - countBoth;\n        \n        // In kết quả\n        printf("%llu\\n", result);\n    }\n    \n    return 0;\n}	17	1080	\N	2026-05-18 23:03:56.059511+07	WRONG_ANSWER
59	2	8	1	\N	50	#include <stdio.h>\n\n// Hàm tính Ước chung lớn nhất (GCD)\nunsigned long long gcd(unsigned long long a, unsigned long long b) {\n    while (b != 0) {\n        unsigned long long temp = b;\n        b = a % b;\n        a = temp;\n    }\n    return a;\n}\n\n// Hàm tính Bội chung nhỏ nhất (LCM) - Ép chia trước, nhân sau để chống tràn\nunsigned long long lcm(unsigned long long a, unsigned long long b) {\n    return (a / gcd(a, b)) * b;\n}\n\nint main() {\n    unsigned long long n, a, b;\n    \n    // Đọc đầu vào an toàn\n    if (scanf("%llu %llu %llu", &n, &a, &b) == 3) {\n        \n        unsigned long long countA = n / a;\n        unsigned long long countB = n / b;\n        \n        // Tính LCM an toàn\n        unsigned long long lcmAB = lcm(a, b);\n        unsigned long long countBoth = n / lcmAB;\n        \n        // Nguyên lý Bao hàm - Loại trừ\n        unsigned long long result = countA + countB - countBoth;\n        \n        // In kết quả\n        printf("%llu\\n", result);\n    }\n    \n    return 0;\n}	17	1092	\N	2026-05-18 23:06:50.34657+07	WRONG_ANSWER
60	2	6	\N	3	62	import java.io.BufferedReader;\nimport java.io.InputStreamReader;\nimport java.io.IOException;\nimport java.util.StringTokenizer;\n\npublic class Main {\n    public static boolean isPrime(long n) {\n        if (n <= 1) return false;\n        if (n <= 3) return true;\n        if (n % 2 == 0 || n % 3 == 0) return false;\n        \n        for (long i = 5; i * i <= n; i += 6) {\n            if (n % i == 0 || n % (i + 2) == 0) return false;\n        }\n        return true;\n    }\n\n    public static void main(String[] args) throws IOException {\n        BufferedReader br = new BufferedReader(new InputStreamReader(System.in));\n        String line = br.readLine();\n        if (line != null && !line.trim().isEmpty()) {\n            StringTokenizer st = new StringTokenizer(line);\n            long n = Long.parseLong(st.nextToken().trim());\n            \n            if (isPrime(n)) {\n                System.out.println("YES");\n            } else {\n                System.out.println("NO");\n            }\n        }\n    }\n}	137	27652	\N	2026-05-18 23:11:39.181594+07	ACCEPTED
61	2	6	\N	3	62	import java.io.BufferedReader;\nimport java.io.InputStreamReader;\nimport java.io.IOException;\nimport java.util.StringTokenizer;\n\npublic class Main {\n    public static boolean isPrime(long n) {\n        if (n <= 1) return false;\n        if (n <= 3) return true;\n        if (n % 2 == 0 || n % 3 == 0) return false;\n        \n        for (long i = 5; i * i <= n; i += 6) {\n            if (n % i == 0 || n % (i + 2) == 0) return false;\n        }\n        return true;\n    }\n\n    public static void main(String[] args) throws IOException {\n        BufferedReader br = new BufferedReader(new InputStreamReader(System.in));\n        String line = br.readLine();\n        if (line != null && !line.trim().isEmpty()) {\n            StringTokenizer st = new StringTokenizer(line);\n            long n = Long.parseLong(st.nextToken().trim());\n            \n            if (isPrime(n)) {\n                System.out.println("YES");\n            } else {\n                System.out.println("NO");\n            }\n        }\n    }\n}	122	13252	\N	2026-05-18 23:17:09.882437+07	ACCEPTED
62	2	6	\N	3	62	import java.io.BufferedReader;\nimport java.io.InputStreamReader;\nimport java.io.IOException;\nimport java.util.StringTokenizer;\n\npublic class Main {\n    public static boolean isPrime(long n) {\n        if (n <= 1) return false;\n        if (n <= 3) return true;\n        if (n % 2 == 0 || n % 3 == 0) return false;\n        \n        for (long i = 5; i * i <= n; i += 6) {\n            if (n % i == 0 || n % (i + 2) == 0) return false;\n        }\n        return true;\n    }\n\n    public static void main(String[] args) throws IOException {\n        BufferedReader br = new BufferedReader(new InputStreamReader(System.in));\n        String line = br.readLine();\n        if (line != null && !line.trim().isEmpty()) {\n            StringTokenizer st = new StringTokenizer(line);\n            long n = Long.parseLong(st.nextToken().trim());\n            \n            if (isPrime(n)) {\n                System.out.println("YES");\n            } else {\n                System.out.println("NO");\n            }\n        }\n    }\n}	155	13044	\N	2026-05-18 23:24:58.435926+07	ACCEPTED
63	2	6	\N	3	62	import java.io.BufferedReader;\nimport java.io.InputStreamReader;\nimport java.io.IOException;\nimport java.util.StringTokenizer;\n\npublic class Main {\n    public static boolean isPrime(long n) {\n        if (n <= 1) return false;\n        if (n <= 3) return true;\n        if (n % 2 == 0 || n % 3 == 0) return false;\n        \n        for (long i = 5; i * i <= n; i += 6) {\n            if (n % i == 0 || n % (i + 2) == 0) return false;\n        }\n        return true;\n    }\n\n    public static void main(String[] args) throws IOException {\n        BufferedReader br = new BufferedReader(new InputStreamReader(System.in));\n        String line = br.readLine();\n        if (line != null && !line.trim().isEmpty()) {\n            StringTokenizer st = new StringTokenizer(line);\n            long n = Long.parseLong(st.nextToken().trim());\n            \n            if (isPrime(n)) {\n                System.out.println("YES");\n            } else {\n                System.out.println("NO1");\n            }\n        }\n    }\n}	105	17284	\N	2026-05-18 23:35:33.591692+07	WRONG_ANSWER
64	2	6	\N	3	62	import java.io.BufferedReader;\nimport java.io.InputStreamReader;\nimport java.io.IOException;\nimport java.util.StringTokenizer;\n\npublic class Main {\n    public static boolean isPrime(long n) {\n        if (n <= 1) return false;\n        if (n <= 3) return true;\n        if (n % 2 == 0 || n % 3 == 0) return false;\n        \n        for (long i = 5; i * i <= n; i += 6) {\n            if (n % i == 0 || n % (i + 2) == 0) return false;\n        }\n        return true;\n    }\n\n    public static void main(String[] args) throws IOException {\n        BufferedReader br = new BufferedReader(new InputStreamReader(System.in));\n        String line = br.readLine();\n        if (line != null && !line.trim().isEmpty()) {\n            StringTokenizer st = new StringTokenizer(line);\n            long n = Long.parseLong(st.nextToken().trim());\n            \n            if (isPrime(n)) {\n                System.out.println("YES");\n            } else {\n                System.out.println("NO");\n            }\n        }\n    }\n}	263	13084	\N	2026-05-18 23:35:57.431192+07	ACCEPTED
65	2	6	\N	3	62	import java.io.BufferedReader;\nimport java.io.InputStreamReader;\nimport java.io.IOException;\nimport java.util.StringTokenizer;\n\npublic class Main {\n    public static boolean isPrime(long n) {\n        if (n <= 1) return false;\n        if (n <= 3) return true;\n        if (n % 2 == 0 || n % 3 == 0) return false;\n        \n        for (long i = 5; i * i <= n; i += 6) {\n            if (n % i == 0 || n % (i + 2) == 0) return false;\n        }\n        return true;\n    }\n\n    public static void main(String[] args) throws IOException {\n        BufferedReader br = new BufferedReader(new InputStreamReader(System.in));\n        String line = br.readLine();\n        if (line != null && !line.trim().isEmpty()) {\n            StringTokenizer st = new StringTokenizer(line);\n            long n = Long.parseLong(st.nextToken().trim());\n            \n            if (isPrime(n)) {\n                System.out.println("YES");\n            } else {\n                System.out.println("NO1");\n            }\n        }\n    }\n}	101	12376	\N	2026-05-18 23:36:21.366349+07	WRONG_ANSWER
\.


--
-- TOC entry 5757 (class 0 OID 18218)
-- Dependencies: 295
-- Data for Name: order_items; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.order_items (id, order_id, course_id, price) FROM stdin;
1	1	5	100000.00
2	1	4	299000.00
\.


--
-- TOC entry 5755 (class 0 OID 18196)
-- Dependencies: 293
-- Data for Name: orders; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.orders (id, user_id, total_amount, status, created_at, updated_at) FROM stdin;
1	2	399000.00	COMPLETED	2026-05-23 01:26:33.658927+07	2026-05-23 01:26:33.658927+07
\.


--
-- TOC entry 5751 (class 0 OID 18055)
-- Dependencies: 289
-- Data for Name: payment_transactions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.payment_transactions (id, wallet_id, transaction_code, amount, type, status, note, created_at, updated_at) FROM stdin;
2	3	1779449142920	10000.00	DEPOSIT	PENDING	Nạp xu vào ví	2026-05-22 18:25:42.935659+07	2026-05-22 18:25:42.935659+07
3	3	1779449221298	10000.00	DEPOSIT	SUCCESS	Nạp xu vào ví	2026-05-22 18:27:01.298323+07	2026-05-22 18:27:23.637047+07
4	3	1779460228948	10000.00	DEPOSIT	PENDING	Nạp xu vào ví	2026-05-22 21:30:28.959371+07	2026-05-22 21:30:28.959371+07
5	3	1779467131016	10000.00	DEPOSIT	PENDING	Nạp xu vào ví	2026-05-22 23:25:31.022119+07	2026-05-22 23:25:31.022119+07
6	3	1779467140009	500000.00	DEPOSIT	PENDING	Nạp xu vào ví	2026-05-22 23:25:40.009703+07	2026-05-22 23:25:40.009703+07
\.


--
-- TOC entry 5686 (class 0 OID 16944)
-- Dependencies: 224
-- Data for Name: permissions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.permissions (id, name) FROM stdin;
1	AUTH_REGISTER
2	AUTH_LOGIN
3	AUTH_LOGOUT
4	COURSE_VIEW_LIST
5	COURSE_VIEW_DETAIL
6	COURSE_CREATE
7	COURSE_UPDATE
8	COURSE_DELETE
9	COURSE_MANAGE_STATUS
10	CHAPTER_CREATE
11	CHAPTER_UPDATE
12	CHAPTER_DELETE
13	LESSON_CREATE
14	LESSON_UPDATE
15	LESSON_DELETE
16	TEACHER_ASSIGN_COURSE
17	TEACHER_VIEW_ASSIGNED_COURSE
18	USER_VIEW
19	USER_CREATE
20	USER_UPDATE
21	USER_DELETE
22	USER_LOCK
23	USER_UNLOCK
24	TEACHER_VIEW
25	TEACHER_CREATE
26	TEACHER_UPDATE
27	TEACHER_DELETE
28	PAYMENT_CREATE
29	PAYMENT_VIEW_OWN
30	ENROLLMENT_CREATE
31	ENROLLMENT_VIEW_OWN
32	COURSE_CONTENT_ACCESS
33	LESSON_COMPLETE
34	LEARNING_PROGRESS_VIEW_OWN
35	STUDENT_PROGRESS_VIEW_ASSIGNED_COURSE
36	USER_LEARNING_STATISTICS_VIEW_ALL
37	QUIZ_VIEW
38	QUIZ_SUBMIT
39	QUIZ_RESULT_VIEW_OWN
40	QUIZ_CREATE_ASSIGNED_COURSE
41	QUIZ_UPDATE_ASSIGNED_COURSE
42	QUIZ_DELETE_ASSIGNED_COURSE
43	OJ_PROBLEM_VIEW
44	OJ_SUBMISSION_CREATE_LESSON
45	OJ_SUBMISSION_VIEW_OWN
46	OJ_PROBLEM_CREATE_ASSIGNED_COURSE
47	OJ_PROBLEM_UPDATE_ASSIGNED_COURSE
48	OJ_PROBLEM_DELETE_ASSIGNED_COURSE
49	OJ_TESTCASE_MANAGE_ASSIGNED_COURSE
50	OJ_TAG_MANAGE
51	FILE_ASSIGNMENT_VIEW
52	FILE_SUBMISSION_CREATE
53	FILE_SUBMISSION_VIEW_OWN
54	FILE_ASSIGNMENT_CREATE_ASSIGNED_COURSE
55	FILE_ASSIGNMENT_UPDATE_ASSIGNED_COURSE
56	FILE_ASSIGNMENT_DELETE_ASSIGNED_COURSE
57	FILE_SUBMISSION_VIEW_ASSIGNED_COURSE
58	FILE_SUBMISSION_DOWNLOAD_ASSIGNED_COURSE
59	FILE_SUBMISSION_GRADE_ASSIGNED_COURSE
60	COMMENT_CREATE
61	COMMENT_REPLY_OWN
62	COMMENT_REPLY_ASSIGNED_COURSE
63	COMMENT_VIEW
64	CONTEST_VIEW_LIST
65	CONTEST_JOIN
66	CONTEST_PROBLEM_VIEW
67	CONTEST_SUBMISSION_CREATE
68	CONTEST_RANKING_VIEW
69	CONTEST_CREATE
70	CONTEST_UPDATE_OWN
71	CONTEST_DELETE_OWN
72	CONTEST_PROBLEM_ADD_OWN
73	CONTEST_PROBLEM_REMOVE_OWN
74	CONTEST_RANKING_VIEW_BY_PASSWORD
75	CONTEST_SUBMISSION_VIEW_OWN
76	CONTEST_VIEW_ALL
77	CONTEST_UPDATE_ALL
78	CONTEST_DELETE_ALL
79	CONTEST_SUBMISSION_VIEW_ALL
80	SYSTEM_STATISTICS_VIEW
81	OJ_PROBLEM_SUBMIT
\.


--
-- TOC entry 5722 (class 0 OID 17421)
-- Dependencies: 260
-- Data for Name: problem_tag_mappings; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.problem_tag_mappings (id, problem_id, tag_id) FROM stdin;
1	1	3
2	2	2
3	3	1
7	10	1
8	13	1
9	16	1
10	17	1
11	18	1
12	19	1
13	11	2
14	15	2
15	10	3
16	12	3
17	14	3
18	18	3
19	12	4
20	13	4
21	14	4
22	19	4
23	16	14
\.


--
-- TOC entry 5720 (class 0 OID 17403)
-- Dependencies: 258
-- Data for Name: problem_tags; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.problem_tags (id, name, slug, created_at, updated_at) FROM stdin;
1	Mảng (Array)	array	2026-05-05 03:15:17.516772+07	2026-05-05 03:15:17.516772+07
2	Chuỗi (String)	string	2026-05-05 03:15:17.516772+07	2026-05-05 03:15:17.516772+07
3	Toán học (Math)	math	2026-05-05 03:15:17.516772+07	2026-05-05 03:15:17.516772+07
4	Quy hoạch động (DP)	dynamic-programming	2026-05-05 03:15:17.516772+07	2026-05-05 03:15:17.516772+07
14	Sorting	sorting	2026-05-26 00:12:59.79069+07	2026-05-26 00:12:59.79069+07
\.


--
-- TOC entry 5724 (class 0 OID 17443)
-- Dependencies: 262
-- Data for Name: problem_testcases; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.problem_testcases (id, problem_id, input_data, expected_output, is_hidden, order_index) FROM stdin;
1	1	5 7	12	f	1
2	1	-10 20	10	f	2
3	1	1000000 2000000	3000000	t	3
4	2	hello	olleh	f	1
5	2	SpringBoot	tooB gnirpS	t	2
6	3	5\r\n1 4 2 8 5	8	f	1
7	3	3\r\n-10 -5 -20	-5	t	2
8	6	1	NO	f	1
9	6	2	YES	f	2
10	6	3	YES	f	3
11	6	4	NO	f	4
12	6	15	NO	t	5
13	6	97	YES	t	6
14	6	100	NO	t	7
15	6	999983	YES	t	8
16	6	1000000	NO	t	9
17	6	999999937	YES	t	10
18	6	101	YES	t	11
19	6	108	NO	t	12
20	6	115	NO	t	13
108	7	7	YES	f	1
109	7	1	NO	f	2
110	7	4	NO	f	3
111	7	0	NO	t	4
112	7	-5	NO	t	5
113	7	2	YES	t	6
114	7	3	YES	t	7
115	7	9	NO	t	8
116	7	15	NO	t	9
117	7	97	YES	t	10
118	7	100	NO	t	11
119	7	841	NO	t	12
120	7	997	YES	t	13
121	7	1000000007	YES	t	14
122	7	1000000008	NO	t	15
123	7	2147483647	YES	t	16
124	7	4294967291	YES	t	17
125	7	9007199254740997	YES	t	18
126	7	9007199254740998	NO	t	19
127	7	999999999999999989	YES	t	20
128	8	10 2 3	7	f	1
129	8	15 3 5	7	f	2
130	8	100 7 11	22	f	3
131	8	1000 2 2	500	t	4
132	8	100000 1 1	100000	t	5
133	8	10 5 5	2	t	6
134	8	1000000 13 17	131222	t	7
135	8	1000000000 2 3	666666667	t	8
136	8	10000000000 4 6	3333333333	t	9
137	8	100000000000 7 8	25000000000	t	10
138	8	999999 10 100	99999	t	11
139	8	123456789 2 5	74074073	t	12
140	8	1000000000000000 2 2	500000000000000	t	13
141	8	1000000000000000000 2 3	666666666666666667	t	14
142	8	1000000000000000000 1 1	1000000000000000000	t	15
145	8	500000000000000000 3 5	233333333333333333	t	18
146	8	999999999999999999 100000 100000	9999999999999	t	19
147	8	1000000000000000000 2 4	500000000000000000	t	20
144	8	1000000000000000000 99991 99989	20001900182019	t	17
143	8	987654321987654321 7 13	206213539755675079	t	16
148	10	4\\n2 7 11 15\\n9	0 1	f	1
149	10	3\\n3 2 4\\n6	1 2	t	2
150	11	hello	olleh	f	1
151	11	world	dlrow	t	2
152	12	4	3	f	1
153	12	10	55	t	2
154	13	5\\n-2 1 -3 4 -1	4	f	1
155	13	4\\n-1 -2 -3 -4	-1	t	2
156	14	3	3	f	1
157	14	5	8	t	2
158	15	()[]{}	true	f	1
159	15	(]	false	t	2
160	16	4\\n1 3\\n2 6\\n8 10\\n15 18	1 6\\n8 10\\n15 18	f	1
161	16	2\\n1 4\\n4 5	1 5	t	2
162	17	4\\n1 2 3 1	true	f	1
163	17	4\\n1 2 3 4	false	t	2
164	18	3\\n3 0 1	2	f	1
165	18	2\\n0 1	2	t	2
166	19	6\\n4 2 0 3 2 5	9	f	1
167	19	3\\n1 0 1	1	t	2
101	6	682	NO	t	94
102	6	689	NO	t	95
103	6	696	NO	t	96
104	6	703	NO	t	97
105	6	710	NO	t	98
106	6	717	NO	t	99
107	6	724	NO	t	100
\.


--
-- TOC entry 5745 (class 0 OID 17871)
-- Dependencies: 283
-- Data for Name: quiz_attempt_answers; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.quiz_attempt_answers (id, attempt_id, question_id, selected_option_id) FROM stdin;
1	1	1	2
2	1	2	7
3	1	3	11
4	1	4	16
5	1	5	18
6	1	6	21
7	1	7	26
8	1	8	30
9	1	9	34
10	1	10	\N
11	2	12	45
12	2	19	76
13	2	18	71
14	2	17	66
15	2	13	49
16	2	15	\N
17	2	20	79
18	2	11	43
19	2	16	63
20	2	14	56
\.


--
-- TOC entry 5716 (class 0 OID 17343)
-- Dependencies: 254
-- Data for Name: quiz_attempts; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.quiz_attempts (id, user_id, quiz_id, total_questions, correct_answers, score, submitted_at, created_at, updated_at) FROM stdin;
1	2	1	10	8	80.00	2026-05-04 18:32:50.763517+07	2026-05-04 18:32:50.763517+07	2026-05-04 18:32:50.763517+07
2	5	2	10	7	7.00	2026-05-10 21:15:19.743333+07	\N	\N
\.


--
-- TOC entry 5714 (class 0 OID 17322)
-- Dependencies: 252
-- Data for Name: quiz_options; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.quiz_options (id, question_id, content, is_correct, order_index) FROM stdin;
1	1	Tầng Service	f	1
2	1	Tầng Controller	t	2
3	1	Tầng Repository	f	3
4	1	Tầng Entity	f	4
5	2	Tầng Controller	f	1
6	2	Tầng Repository	f	2
7	2	Tầng Service	t	3
8	2	Tầng Configuration	f	4
9	3	Xử lý các tính toán phức tạp	f	1
10	3	Trả về JSON cho Client	f	2
11	3	Tương tác trực tiếp với Cơ sở dữ liệu (CRUD)	t	3
12	3	Kiểm tra quyền truy cập của người dùng	f	4
13	4	@Service	f	1
14	4	@Repository	f	2
15	4	@Component	f	3
16	4	@Entity	t	4
17	5	Giữa Database và Repository	f	1
18	5	Giữa Client và Controller	t	2
19	5	Giữa Entity và Database	f	3
20	5	Tất cả đều sai	f	4
21	6	@RestController tự động gắn @ResponseBody vào tất cả các API	t	1
22	6	@RestController trả về giao diện HTML	f	2
23	6	@RestController chạy nhanh hơn @Controller	f	3
24	6	Không có sự khác biệt, có thể dùng thay thế nhau 100%	f	4
25	7	Vì Spring Boot không cho phép điều đó	f	1
26	7	Để đảm bảo nguyên tắc Separation of Concerns và dễ dàng viết Unit Test	t	2
27	7	Vì sẽ gây ra lỗi biên dịch (Compile Error)	f	3
28	7	Vì Repository không thể inject vào Controller	f	4
29	8	Trên các method của Controller	f	1
30	8	Trên các method của Service	t	2
31	8	Trên các method của Repository	f	3
32	8	Trong file application.yml	f	4
33	9	Presentation Layer (Controller)	f	1
34	9	Business Logic Layer (Service)	f	2
35	9	Data Access Layer (Repository)	t	3
36	9	Database Layer	f	4
37	10	Controller inject Repository, Repository inject Service	f	1
38	10	Controller inject Service, Service inject Repository	t	2
39	10	Tất cả các tầng tự khởi tạo đối tượng bằng từ khóa "new"	f	3
40	10	Service tự tạo ra Controller và Repository	f	4
41	11	Bộ nhớ chính xác (byte) thuật toán sẽ sử dụng	f	1
42	11	Tốc độ thực thi chính xác (mili-giây) của thuật toán	f	2
43	11	Sự tăng trưởng thời gian/không gian khi kích thước đầu vào (N) tăng lên	t	3
44	11	Số lượng dòng code của chương trình	f	4
45	12	Thuật toán chạy mất đúng 1 giây	f	1
46	12	Thuật toán có thời gian chạy không đổi, bất kể kích thước dữ liệu đầu vào	t	2
47	12	Thuật toán chỉ xử lý được 1 phần tử	f	3
48	12	Thuật toán nhanh nhất thế giới	f	4
49	13	O(1)	t	1
50	13	O(N)	f	2
51	13	O(log N)	f	3
52	13	O(N^2)	f	4
53	14	O(1)	f	1
54	14	O(log N)	f	2
55	14	O(N)	t	3
56	14	O(N^2)	f	4
57	15	O(1)	f	1
58	15	O(N)	f	2
59	15	O(N log N)	f	3
60	15	O(log N)	t	4
61	16	O(N)	f	1
62	16	O(2N)	f	2
63	16	O(N^2)	t	3
64	16	O(log N)	f	4
65	17	Lượng dung lượng ổ cứng bị chiếm dụng	f	1
66	17	Lượng bộ nhớ RAM bổ sung thuật toán cần dùng so với lượng dữ liệu đầu vào	t	2
67	17	Băng thông mạng truyền tải	f	3
68	17	Tốc độ xung nhịp của CPU	f	4
69	18	O(N)	f	1
70	18	O(N^2)	f	2
71	18	O(log N)	t	3
72	18	O(N!)	f	4
73	19	O(N)	f	1
74	19	O(N^2)	f	2
75	19	O(1)	f	3
76	19	O(log N)	t	4
77	20	Trường hợp tốt nhất (Best Case)	f	1
78	20	Trường hợp trung bình (Average Case)	f	2
79	20	Trường hợp xấu nhất (Worst Case)	t	3
80	20	Trường hợp không có dữ liệu (Empty Case)	f	4
114	33	Một framework frontend để xây dựng giao diện	f	1
115	33	Một dự án của Spring giúp xây dựng ứng dụng độc lập, production-grade một cách nhanh chóng	t	2
116	33	Một hệ quản trị cơ sở dữ liệu quan hệ	f	3
117	34	@SpringBootApplication	t	1
118	34	@Configuration	f	2
119	34	@EnableAutoConfiguration	f	3
120	35	Jetty	f	1
121	35	Undertow	f	2
122	35	Tomcat	t	3
123	36	spring-boot-starter-data-jpa	f	1
124	36	spring-boot-starter-web	t	2
125	36	spring-boot-starter-security	f	3
126	37	config.properties	f	1
127	37	spring-config.xml	f	2
128	37	application.properties (hoặc application.yml)	t	3
129	38	Spring Boot DevTools	t	1
130	38	Spring Boot Actuator	f	2
131	38	Spring Boot Restart	f	3
132	39	Quản lý Dependency Injection	f	1
133	39	Giám sát (Monitor) và quản lý ứng dụng trên môi trường Production	t	2
134	39	Kết nối tới cơ sở dữ liệu	f	3
135	40	8080	t	1
136	40	3000	f	2
137	40	80	f	3
138	41	app.server.port	f	1
139	41	server.port	t	2
140	41	spring.port	f	3
141	42	Đúng, Spring Boot không hỗ trợ XML nữa.	f	1
142	42	Sai, Spring Boot ưu tiên cấu hình bằng Java/Annotation nhưng vẫn hỗ trợ XML nếu cần.	t	2
\.


--
-- TOC entry 5712 (class 0 OID 17300)
-- Dependencies: 250
-- Data for Name: quiz_questions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.quiz_questions (id, quiz_id, question_content, order_index) FROM stdin;
1	1	Trong kiến trúc 3 layer của Spring Boot, tầng nào chịu trách nhiệm tiếp nhận và phản hồi các HTTP Request?	1
2	1	Logic nghiệp vụ (Business Logic) cốt lõi của ứng dụng nên được đặt ở tầng nào?	2
3	1	Tầng Repository (Data Access Layer) có nhiệm vụ chính là gì?	3
4	1	Annotation nào sau đây KHÔNG dùng để đánh dấu một Bean trong Spring framework?	4
5	1	Đối tượng DTO (Data Transfer Object) thường được sử dụng ở ranh giới giữa các tầng nào?	5
6	1	Sự khác biệt chính giữa @Controller và @RestController là gì?	6
7	1	Tại sao KHÔNG NÊN gọi trực tiếp Repository từ Controller?	7
8	1	Khi cần thực hiện một giao dịch (Transaction) liên quan đến nhiều thao tác CSDL, ta nên đặt @Transactional ở đâu?	8
9	1	Spring Data JPA thuộc về tầng nào trong mô hình 3 Layer?	9
10	1	Dependency Injection (DI) thường được sử dụng như thế nào giữa các layer?	10
11	2	Ký hiệu Big O (O-lớn) chủ yếu được sử dụng để mô tả điều gì?	1
12	2	Độ phức tạp thời gian O(1) có nghĩa là gì?	2
13	2	Việc truy cập một phần tử trong mảng bằng chỉ số (index) có độ phức tạp thời gian là bao nhiêu?	3
14	2	Độ phức tạp thời gian của vòng lặp duyệt qua toàn bộ N phần tử của một mảng là?	4
15	2	Tìm kiếm nhị phân (Binary Search) trên một mảng đã sắp xếp có độ phức tạp thời gian là?	5
16	2	Đoạn code có 2 vòng lặp lồng nhau (vòng lặp i từ 0 đến N, vòng lặp j từ 0 đến N) có Time Complexity là?	6
17	2	Space Complexity (Độ phức tạp không gian) đánh giá yếu tố nào?	7
18	2	Thuật toán nào sau đây có hiệu năng tốt nhất khi N tiến tới vô cùng?	8
19	2	Nếu một thuật toán loại bỏ một nửa số lượng dữ liệu sau mỗi bước (như chia để trị), độ phức tạp của nó thường là:	9
20	2	Khi đánh giá Big O, chúng ta thường quan tâm đến trường hợp nào nhất?	10
33	4	Spring Boot là gì?	1
34	4	Đâu là annotation đánh dấu điểm bắt đầu của một ứng dụng Spring Boot?	2
35	4	Web Server mặc định được nhúng (embedded) trong Spring Boot Web là gì?	3
36	4	Dependency nào cần thiết để phát triển RESTful API trong Spring Boot?	4
37	4	Tên file cấu hình mặc định của Spring Boot là gì?	5
38	4	Công cụ nào trong Spring Boot giúp tự động restart server khi có thay đổi code?	6
39	4	Spring Boot Actuator dùng để làm gì?	7
40	4	Cổng (Port) mặc định của một ứng dụng Spring Boot Web là bao nhiêu?	8
41	4	Để thay đổi port mặc định, bạn dùng thuộc tính nào trong file cấu hình?	9
42	4	Spring Boot loại bỏ hoàn toàn việc sử dụng file XML để cấu hình. Đúng hay Sai?	10
\.


--
-- TOC entry 5710 (class 0 OID 17270)
-- Dependencies: 248
-- Data for Name: quizzes; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.quizzes (id, lesson_id, title, description, created_by_teacher_id, created_at, updated_at, is_deleted) FROM stdin;
1	4	Quiz: Cấu trúc 3 Layer trong Spring Boot	Kiểm tra kiến thức về Controller, Service, Repository và luồng đi của dữ liệu.	1	2026-05-04 02:24:19.271427+07	2026-05-04 02:24:19.271427+07	f
2	7	Quiz: Phân tích độ phức tạp Big O	Đánh giá khả năng tính toán Time Complexity và Space Complexity của thuật toán cơ bản.	1	2026-05-04 02:24:19.271427+07	2026-05-04 02:24:19.271427+07	f
3	1	Bài kiểm tra: Giới thiệu khóa học Spring Boot (Đã được Update)	Bài trắc nghiệm đã được chỉnh sửa để test API Update.	1	2026-05-12 20:49:27.620061+07	2026-05-13 17:34:51.279664+07	t
4	1	Bài kiểm tra: Giới thiệu khóa học Spring Boot	Bài trắc nghiệm đánh giá kiến thức tổng quan về Spring Boot và các khái niệm cơ bản.	1	2026-05-13 17:35:24.497422+07	2026-05-13 17:35:24.497422+07	f
\.


--
-- TOC entry 5692 (class 0 OID 17010)
-- Dependencies: 230
-- Data for Name: refresh_tokens; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.refresh_tokens (id, user_id, token_hash, expires_at, revoked_at, created_at, last_used_at) FROM stdin;
\.


--
-- TOC entry 5688 (class 0 OID 16972)
-- Dependencies: 226
-- Data for Name: role_permissions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.role_permissions (role_id, permission_id) FROM stdin;
1	1
1	2
1	3
1	4
1	5
1	28
1	29
1	30
1	31
1	32
1	33
1	34
1	37
1	38
1	39
1	43
1	44
1	45
1	51
1	52
1	53
1	60
1	61
1	63
1	64
1	65
1	66
1	67
1	68
2	2
2	3
2	4
2	5
2	17
2	35
2	37
2	40
2	41
2	42
2	43
2	46
2	47
2	48
2	49
2	50
2	51
2	54
2	55
2	56
2	57
2	58
2	59
2	60
2	62
2	63
2	64
2	69
2	70
2	71
2	72
2	73
2	74
2	75
3	1
3	2
3	3
3	4
3	5
3	6
3	7
3	8
3	9
3	10
3	11
3	12
3	13
3	14
3	15
3	16
3	17
3	18
3	19
3	20
3	21
3	22
3	23
3	24
3	25
3	26
3	27
3	28
3	29
3	30
3	31
3	32
3	33
3	34
3	35
3	36
3	37
3	38
3	39
3	40
3	41
3	42
3	43
3	44
3	45
3	46
3	47
3	48
3	49
3	50
3	51
3	52
3	53
3	54
3	55
3	56
3	57
3	58
3	59
3	60
3	61
3	62
3	63
3	64
3	65
3	66
3	67
3	68
3	69
3	70
3	71
3	72
3	73
3	74
3	75
3	76
3	77
3	78
3	79
3	80
1	81
2	81
\.


--
-- TOC entry 5684 (class 0 OID 16932)
-- Dependencies: 222
-- Data for Name: roles; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.roles (id, name) FROM stdin;
1	USER
2	TEACHER
3	ADMIN
\.


--
-- TOC entry 5702 (class 0 OID 17125)
-- Dependencies: 240
-- Data for Name: teacher_course_assignments; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.teacher_course_assignments (id, teacher_id, course_id, assigned_by_admin_id, assigned_at) FROM stdin;
3	1	1	1	2026-05-02 02:40:24.740769+07
\.


--
-- TOC entry 5694 (class 0 OID 17030)
-- Dependencies: 232
-- Data for Name: teachers; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.teachers (id, user_id, status, created_at, updated_at, full_name, headline, bio) FROM stdin;
1	6	ACTIVE	2026-05-02 02:38:03.029631+07	2026-05-02 02:38:03.029631+07	Vo Ngoc Thanh	Lecturer at FPT University	Experience like shit
2	7	ACTIVE	2026-05-05 03:12:06.140207+07	2026-05-05 03:12:06.140207+07	Thằng Loz Nào	Giáo viên tự phong	Dell có kinh nghiệm
\.


--
-- TOC entry 5687 (class 0 OID 16955)
-- Dependencies: 225
-- Data for Name: user_roles; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_roles (user_id, role_id) FROM stdin;
1	3
2	1
5	1
6	2
7	2
8	1
9	1
10	1
\.


--
-- TOC entry 5682 (class 0 OID 16907)
-- Dependencies: 220
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.users (id, username, email, password_hash, display_name, phone_number, status, created_at, updated_at) FROM stdin;
1	admin	admin@gmail.com	$2a$10$TrvQZX9AXxeh1thqi95kx.C34879B0NsShE8rW/KVCq0nxP/vF7KG	admin	9999999999	ACTIVE	2026-04-29 14:40:51.946069+07	2026-04-29 14:40:51.946069+07
5	user2	user2@gmail.com	$2a$10$sm0UK3aZaysr3E0eTlUx7OFnUuixyFYi./8kJHAImS0KrHGjwfmyi	user2	0666666666	ACTIVE	2026-04-29 17:18:54.869243+07	2026-04-29 17:19:25.697167+07
2	user1	user1@gmail.com	$2a$10$UfohPV20BWG9s8bsh4XcC..YCXYRsTFxFUcvVwMQjgu7uD.qOnMh2	thanhmila	0763769325	ACTIVE	2026-04-29 17:06:56.181225+07	2026-04-30 01:51:51.212583+07
6	teacher	teacher@gmailcom	$2a$10$wLOCZ9M5DXa2fBCKe7XNv.84vA56W63DiEpdAxTnpdECKbdYbSPvu	teacher	0666666666	ACTIVE	2026-05-02 02:33:59.845941+07	2026-05-02 02:33:59.845941+07
7	user3	user3@gmailcom	$2a$10$d.8pz8mWscFtU9MFoYLijux7JKHIUX.YTalo9PUghxO.UDvoLlUjW	teacher	0666666666	ACTIVE	2026-05-04 02:27:28.412927+07	2026-05-05 03:10:43.403894+07
8	user4	user4@gmailcom	$2a$10$5RAbM/9DVnelr7pQXM.yQuG9LHI2wx4RLwlLkIq2HAFpHkVATwDgS	user4	0666666666	ACTIVE	2026-05-22 14:32:38.185784+07	2026-05-22 14:32:38.185784+07
9	user5	user5@gmailcom	$2a$10$3kg6FOuyXC1PswDPkoqhe.1GYHTVb/OG2.VEI0zSd7Oj4xBNPE2ca	user5	0666666666	ACTIVE	2026-05-22 14:38:54.108561+07	2026-05-22 14:38:54.108561+07
10	user6	user6@gmailcom	$2a$10$tGXXTzavnCk7.TsY8ZLMB.BSVosnfHiv/U0uS8k5mvY.vKwQY.PsG	user6	0666666666	ACTIVE	2026-05-22 14:53:49.046932+07	2026-05-22 14:53:49.046932+07
\.


--
-- TOC entry 5753 (class 0 OID 18082)
-- Dependencies: 291
-- Data for Name: wallet_transactions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.wallet_transactions (id, wallet_id, amount, type, status, reference_id, note, created_at, updated_at, order_id) FROM stdin;
1	3	10000.00	DEPOSIT	SUCCESS	3	Nạp tiền thật qua PayOS	2026-05-22 18:27:23.653613+07	2026-05-22 18:27:23.653613+07	\N
2	3	-399000.00	PURCHASE	SUCCESS	\N	Purchased 2 courses	2026-05-23 01:26:33.665738+07	2026-05-23 01:26:33.665738+07	1
\.


--
-- TOC entry 5749 (class 0 OID 18030)
-- Dependencies: 287
-- Data for Name: wallets; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.wallets (id, user_id, balance, status, created_at, updated_at) FROM stdin;
1	1	0.00	ACTIVE	2026-05-22 14:26:09.410774+07	2026-05-22 14:26:09.410774+07
2	5	0.00	ACTIVE	2026-05-22 14:26:09.410774+07	2026-05-22 14:26:09.410774+07
4	6	0.00	ACTIVE	2026-05-22 14:26:09.410774+07	2026-05-22 14:26:09.410774+07
5	7	0.00	ACTIVE	2026-05-22 14:26:09.410774+07	2026-05-22 14:26:09.410774+07
6	9	0.00	ACTIVE	2026-05-22 14:38:54.135541+07	2026-05-22 14:38:54.135541+07
7	10	0.00	ACTIVE	2026-05-22 14:53:49.2146+07	2026-05-22 14:53:49.2146+07
3	2	601000.00	ACTIVE	2026-05-22 14:26:09.410774+07	2026-05-23 01:26:33.629313+07
\.


--
-- TOC entry 5802 (class 0 OID 0)
-- Dependencies: 279
-- Name: categories_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.categories_id_seq', 19, true);


--
-- TOC entry 5803 (class 0 OID 0)
-- Dependencies: 235
-- Name: chapters_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.chapters_id_seq', 10, true);


--
-- TOC entry 5804 (class 0 OID 0)
-- Dependencies: 245
-- Name: completed_lessons_count_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.completed_lessons_count_id_seq', 6, true);


--
-- TOC entry 5805 (class 0 OID 0)
-- Dependencies: 277
-- Name: contest_participants_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.contest_participants_id_seq', 2, true);


--
-- TOC entry 5806 (class 0 OID 0)
-- Dependencies: 275
-- Name: contest_problems_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.contest_problems_id_seq', 1, true);


--
-- TOC entry 5807 (class 0 OID 0)
-- Dependencies: 263
-- Name: contests_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.contests_id_seq', 3, true);


--
-- TOC entry 5808 (class 0 OID 0)
-- Dependencies: 273
-- Name: course_reviews_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.course_reviews_id_seq', 5, true);


--
-- TOC entry 5809 (class 0 OID 0)
-- Dependencies: 233
-- Name: courses_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.courses_id_seq', 10, true);


--
-- TOC entry 5810 (class 0 OID 0)
-- Dependencies: 241
-- Name: enrollments_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.enrollments_id_seq', 9, true);


--
-- TOC entry 5811 (class 0 OID 0)
-- Dependencies: 267
-- Name: file_assignments_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.file_assignments_id_seq', 1, false);


--
-- TOC entry 5812 (class 0 OID 0)
-- Dependencies: 269
-- Name: file_submissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.file_submissions_id_seq', 1, false);


--
-- TOC entry 5813 (class 0 OID 0)
-- Dependencies: 227
-- Name: invalidated_tokens_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.invalidated_tokens_id_seq', 19, true);


--
-- TOC entry 5814 (class 0 OID 0)
-- Dependencies: 271
-- Name: lesson_comments_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.lesson_comments_id_seq', 9, true);


--
-- TOC entry 5815 (class 0 OID 0)
-- Dependencies: 243
-- Name: lesson_progress_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.lesson_progress_id_seq', 3, true);


--
-- TOC entry 5816 (class 0 OID 0)
-- Dependencies: 237
-- Name: lessons_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.lessons_id_seq', 15, true);


--
-- TOC entry 5817 (class 0 OID 0)
-- Dependencies: 255
-- Name: online_judge_problems_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.online_judge_problems_id_seq', 19, true);


--
-- TOC entry 5818 (class 0 OID 0)
-- Dependencies: 284
-- Name: online_judge_submission_details_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.online_judge_submission_details_id_seq', 998, true);


--
-- TOC entry 5819 (class 0 OID 0)
-- Dependencies: 265
-- Name: online_judge_submissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.online_judge_submissions_id_seq', 65, true);


--
-- TOC entry 5820 (class 0 OID 0)
-- Dependencies: 294
-- Name: order_items_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.order_items_id_seq', 2, true);


--
-- TOC entry 5821 (class 0 OID 0)
-- Dependencies: 292
-- Name: orders_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.orders_id_seq', 1, true);


--
-- TOC entry 5822 (class 0 OID 0)
-- Dependencies: 288
-- Name: payment_transactions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.payment_transactions_id_seq', 6, true);


--
-- TOC entry 5823 (class 0 OID 0)
-- Dependencies: 223
-- Name: permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.permissions_id_seq', 80, true);


--
-- TOC entry 5824 (class 0 OID 0)
-- Dependencies: 259
-- Name: problem_tag_mappings_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.problem_tag_mappings_id_seq', 23, true);


--
-- TOC entry 5825 (class 0 OID 0)
-- Dependencies: 257
-- Name: problem_tags_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.problem_tags_id_seq', 14, true);


--
-- TOC entry 5826 (class 0 OID 0)
-- Dependencies: 261
-- Name: problem_testcases_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.problem_testcases_id_seq', 167, true);


--
-- TOC entry 5827 (class 0 OID 0)
-- Dependencies: 282
-- Name: quiz_attempt_answers_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.quiz_attempt_answers_id_seq', 20, true);


--
-- TOC entry 5828 (class 0 OID 0)
-- Dependencies: 253
-- Name: quiz_attempts_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.quiz_attempts_id_seq', 2, true);


--
-- TOC entry 5829 (class 0 OID 0)
-- Dependencies: 251
-- Name: quiz_options_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.quiz_options_id_seq', 142, true);


--
-- TOC entry 5830 (class 0 OID 0)
-- Dependencies: 249
-- Name: quiz_questions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.quiz_questions_id_seq', 42, true);


--
-- TOC entry 5831 (class 0 OID 0)
-- Dependencies: 247
-- Name: quizzes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.quizzes_id_seq', 4, true);


--
-- TOC entry 5832 (class 0 OID 0)
-- Dependencies: 229
-- Name: refresh_tokens_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.refresh_tokens_id_seq', 1, false);


--
-- TOC entry 5833 (class 0 OID 0)
-- Dependencies: 221
-- Name: roles_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.roles_id_seq', 3, true);


--
-- TOC entry 5834 (class 0 OID 0)
-- Dependencies: 239
-- Name: teacher_course_assignments_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.teacher_course_assignments_id_seq', 3, true);


--
-- TOC entry 5835 (class 0 OID 0)
-- Dependencies: 231
-- Name: teachers_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.teachers_id_seq', 2, true);


--
-- TOC entry 5836 (class 0 OID 0)
-- Dependencies: 219
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.users_id_seq', 10, true);


--
-- TOC entry 5837 (class 0 OID 0)
-- Dependencies: 290
-- Name: wallet_transactions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.wallet_transactions_id_seq', 2, true);


--
-- TOC entry 5838 (class 0 OID 0)
-- Dependencies: 286
-- Name: wallets_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.wallets_id_seq', 7, true);


--
-- TOC entry 5414 (class 2606 OID 17801)
-- Name: categories categories_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.categories
    ADD CONSTRAINT categories_name_key UNIQUE (name);


--
-- TOC entry 5416 (class 2606 OID 17799)
-- Name: categories categories_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.categories
    ADD CONSTRAINT categories_pkey PRIMARY KEY (id);


--
-- TOC entry 5418 (class 2606 OID 17803)
-- Name: categories categories_slug_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.categories
    ADD CONSTRAINT categories_slug_key UNIQUE (slug);


--
-- TOC entry 5302 (class 2606 OID 17085)
-- Name: chapters chapters_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.chapters
    ADD CONSTRAINT chapters_pkey PRIMARY KEY (id);


--
-- TOC entry 5329 (class 2606 OID 17256)
-- Name: completed_lessons_count completed_lessons_count_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.completed_lessons_count
    ADD CONSTRAINT completed_lessons_count_pkey PRIMARY KEY (id);


--
-- TOC entry 5409 (class 2606 OID 17706)
-- Name: contest_participants contest_participants_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.contest_participants
    ADD CONSTRAINT contest_participants_pkey PRIMARY KEY (id);


--
-- TOC entry 5402 (class 2606 OID 17680)
-- Name: contest_problems contest_problems_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.contest_problems
    ADD CONSTRAINT contest_problems_pkey PRIMARY KEY (id);


--
-- TOC entry 5368 (class 2606 OID 17487)
-- Name: contests contests_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.contests
    ADD CONSTRAINT contests_pkey PRIMARY KEY (id);


--
-- TOC entry 5420 (class 2606 OID 17810)
-- Name: course_category_mappings course_category_mappings_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.course_category_mappings
    ADD CONSTRAINT course_category_mappings_pkey PRIMARY KEY (course_id, category_id);


--
-- TOC entry 5397 (class 2606 OID 17653)
-- Name: course_reviews course_reviews_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.course_reviews
    ADD CONSTRAINT course_reviews_pkey PRIMARY KEY (id);


--
-- TOC entry 5297 (class 2606 OID 17072)
-- Name: courses courses_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.courses
    ADD CONSTRAINT courses_pkey PRIMARY KEY (id);


--
-- TOC entry 5318 (class 2606 OID 17194)
-- Name: enrollments enrollments_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.enrollments
    ADD CONSTRAINT enrollments_pkey PRIMARY KEY (id);


--
-- TOC entry 5381 (class 2606 OID 17551)
-- Name: file_assignments file_assignments_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.file_assignments
    ADD CONSTRAINT file_assignments_pkey PRIMARY KEY (id);


--
-- TOC entry 5385 (class 2606 OID 17584)
-- Name: file_submissions file_submissions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.file_submissions
    ADD CONSTRAINT file_submissions_pkey PRIMARY KEY (id);


--
-- TOC entry 5283 (class 2606 OID 17001)
-- Name: invalidated_tokens invalidated_tokens_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.invalidated_tokens
    ADD CONSTRAINT invalidated_tokens_pkey PRIMARY KEY (id);


--
-- TOC entry 5285 (class 2606 OID 17003)
-- Name: invalidated_tokens invalidated_tokens_token_jti_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.invalidated_tokens
    ADD CONSTRAINT invalidated_tokens_token_jti_key UNIQUE (token_jti);


--
-- TOC entry 5395 (class 2606 OID 17620)
-- Name: lesson_comments lesson_comments_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.lesson_comments
    ADD CONSTRAINT lesson_comments_pkey PRIMARY KEY (id);


--
-- TOC entry 5325 (class 2606 OID 17224)
-- Name: lesson_progress lesson_progress_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.lesson_progress
    ADD CONSTRAINT lesson_progress_pkey PRIMARY KEY (id);


--
-- TOC entry 5308 (class 2606 OID 17116)
-- Name: lessons lessons_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.lessons
    ADD CONSTRAINT lessons_pkey PRIMARY KEY (id);


--
-- TOC entry 5352 (class 2606 OID 17391)
-- Name: online_judge_problems online_judge_problems_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.online_judge_problems
    ADD CONSTRAINT online_judge_problems_pkey PRIMARY KEY (id);


--
-- TOC entry 5428 (class 2606 OID 17963)
-- Name: online_judge_submission_details online_judge_submission_details_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.online_judge_submission_details
    ADD CONSTRAINT online_judge_submission_details_pkey PRIMARY KEY (id);


--
-- TOC entry 5379 (class 2606 OID 17513)
-- Name: online_judge_submissions online_judge_submissions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.online_judge_submissions
    ADD CONSTRAINT online_judge_submissions_pkey PRIMARY KEY (id);


--
-- TOC entry 5451 (class 2606 OID 18228)
-- Name: order_items order_items_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_items
    ADD CONSTRAINT order_items_pkey PRIMARY KEY (id);


--
-- TOC entry 5447 (class 2606 OID 18211)
-- Name: orders orders_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_pkey PRIMARY KEY (id);


--
-- TOC entry 5437 (class 2606 OID 18138)
-- Name: payment_transactions payment_transactions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.payment_transactions
    ADD CONSTRAINT payment_transactions_pkey PRIMARY KEY (id);


--
-- TOC entry 5439 (class 2606 OID 18075)
-- Name: payment_transactions payment_transactions_transaction_code_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.payment_transactions
    ADD CONSTRAINT payment_transactions_transaction_code_key UNIQUE (transaction_code);


--
-- TOC entry 5274 (class 2606 OID 16954)
-- Name: permissions permissions_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.permissions
    ADD CONSTRAINT permissions_name_key UNIQUE (name);


--
-- TOC entry 5276 (class 2606 OID 16952)
-- Name: permissions permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.permissions
    ADD CONSTRAINT permissions_pkey PRIMARY KEY (id);


--
-- TOC entry 5359 (class 2606 OID 17429)
-- Name: problem_tag_mappings problem_tag_mappings_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.problem_tag_mappings
    ADD CONSTRAINT problem_tag_mappings_pkey PRIMARY KEY (id);


--
-- TOC entry 5354 (class 2606 OID 17417)
-- Name: problem_tags problem_tags_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.problem_tags
    ADD CONSTRAINT problem_tags_pkey PRIMARY KEY (id);


--
-- TOC entry 5356 (class 2606 OID 17419)
-- Name: problem_tags problem_tags_slug_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.problem_tags
    ADD CONSTRAINT problem_tags_slug_key UNIQUE (slug);


--
-- TOC entry 5364 (class 2606 OID 17458)
-- Name: problem_testcases problem_testcases_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.problem_testcases
    ADD CONSTRAINT problem_testcases_pkey PRIMARY KEY (id);


--
-- TOC entry 5423 (class 2606 OID 17879)
-- Name: quiz_attempt_answers quiz_attempt_answers_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.quiz_attempt_answers
    ADD CONSTRAINT quiz_attempt_answers_pkey PRIMARY KEY (id);


--
-- TOC entry 5346 (class 2606 OID 17359)
-- Name: quiz_attempts quiz_attempts_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.quiz_attempts
    ADD CONSTRAINT quiz_attempts_pkey PRIMARY KEY (id);


--
-- TOC entry 5342 (class 2606 OID 17336)
-- Name: quiz_options quiz_options_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.quiz_options
    ADD CONSTRAINT quiz_options_pkey PRIMARY KEY (id);


--
-- TOC entry 5337 (class 2606 OID 17313)
-- Name: quiz_questions quiz_questions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.quiz_questions
    ADD CONSTRAINT quiz_questions_pkey PRIMARY KEY (id);


--
-- TOC entry 5333 (class 2606 OID 17286)
-- Name: quizzes quizzes_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.quizzes
    ADD CONSTRAINT quizzes_pkey PRIMARY KEY (id);


--
-- TOC entry 5289 (class 2606 OID 17021)
-- Name: refresh_tokens refresh_tokens_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.refresh_tokens
    ADD CONSTRAINT refresh_tokens_pkey PRIMARY KEY (id);


--
-- TOC entry 5291 (class 2606 OID 17023)
-- Name: refresh_tokens refresh_tokens_token_hash_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.refresh_tokens
    ADD CONSTRAINT refresh_tokens_token_hash_key UNIQUE (token_hash);


--
-- TOC entry 5280 (class 2606 OID 16978)
-- Name: role_permissions role_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.role_permissions
    ADD CONSTRAINT role_permissions_pkey PRIMARY KEY (role_id, permission_id);


--
-- TOC entry 5270 (class 2606 OID 16942)
-- Name: roles roles_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.roles
    ADD CONSTRAINT roles_name_key UNIQUE (name);


--
-- TOC entry 5272 (class 2606 OID 16940)
-- Name: roles roles_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.roles
    ADD CONSTRAINT roles_pkey PRIMARY KEY (id);


--
-- TOC entry 5314 (class 2606 OID 17136)
-- Name: teacher_course_assignments teacher_course_assignments_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.teacher_course_assignments
    ADD CONSTRAINT teacher_course_assignments_pkey PRIMARY KEY (id);


--
-- TOC entry 5293 (class 2606 OID 17043)
-- Name: teachers teachers_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.teachers
    ADD CONSTRAINT teachers_pkey PRIMARY KEY (id);


--
-- TOC entry 5295 (class 2606 OID 17045)
-- Name: teachers teachers_user_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.teachers
    ADD CONSTRAINT teachers_user_id_key UNIQUE (user_id);


--
-- TOC entry 5425 (class 2606 OID 17881)
-- Name: quiz_attempt_answers unique_attempt_question; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.quiz_attempt_answers
    ADD CONSTRAINT unique_attempt_question UNIQUE (attempt_id, question_id);


--
-- TOC entry 5305 (class 2606 OID 17087)
-- Name: chapters uq_chapters_course_order; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.chapters
    ADD CONSTRAINT uq_chapters_course_order UNIQUE (course_id, order_index);


--
-- TOC entry 5331 (class 2606 OID 17258)
-- Name: completed_lessons_count uq_completed_lessons_count_user_course; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.completed_lessons_count
    ADD CONSTRAINT uq_completed_lessons_count_user_course UNIQUE (user_id, course_id);


--
-- TOC entry 5412 (class 2606 OID 17708)
-- Name: contest_participants uq_contest_participants_contest_user; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.contest_participants
    ADD CONSTRAINT uq_contest_participants_contest_user UNIQUE (contest_id, user_id);


--
-- TOC entry 5405 (class 2606 OID 17684)
-- Name: contest_problems uq_contest_problems_contest_order; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.contest_problems
    ADD CONSTRAINT uq_contest_problems_contest_order UNIQUE (contest_id, order_index);


--
-- TOC entry 5407 (class 2606 OID 17682)
-- Name: contest_problems uq_contest_problems_contest_problem; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.contest_problems
    ADD CONSTRAINT uq_contest_problems_contest_problem UNIQUE (contest_id, problem_id);


--
-- TOC entry 5400 (class 2606 OID 17655)
-- Name: course_reviews uq_course_reviews_course_user; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.course_reviews
    ADD CONSTRAINT uq_course_reviews_course_user UNIQUE (course_id, user_id);


--
-- TOC entry 5321 (class 2606 OID 17196)
-- Name: enrollments uq_enrollments_user_course; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.enrollments
    ADD CONSTRAINT uq_enrollments_user_course UNIQUE (user_id, course_id);


--
-- TOC entry 5390 (class 2606 OID 17586)
-- Name: file_submissions uq_file_submissions_assignment_user_attempt; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.file_submissions
    ADD CONSTRAINT uq_file_submissions_assignment_user_attempt UNIQUE (file_assignment_id, user_id, attempt_no);


--
-- TOC entry 5327 (class 2606 OID 17226)
-- Name: lesson_progress uq_lesson_progress_user_lesson; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.lesson_progress
    ADD CONSTRAINT uq_lesson_progress_user_lesson UNIQUE (user_id, lesson_id);


--
-- TOC entry 5310 (class 2606 OID 17118)
-- Name: lessons uq_lessons_chapter_order; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.lessons
    ADD CONSTRAINT uq_lessons_chapter_order UNIQUE (chapter_id, order_index);


--
-- TOC entry 5361 (class 2606 OID 17431)
-- Name: problem_tag_mappings uq_problem_tag_mappings_problem_tag; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.problem_tag_mappings
    ADD CONSTRAINT uq_problem_tag_mappings_problem_tag UNIQUE (problem_id, tag_id);


--
-- TOC entry 5366 (class 2606 OID 17460)
-- Name: problem_testcases uq_problem_testcases_problem_order; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.problem_testcases
    ADD CONSTRAINT uq_problem_testcases_problem_order UNIQUE (problem_id, order_index);


--
-- TOC entry 5339 (class 2606 OID 17902)
-- Name: quiz_questions uq_quiz_questions_quiz_order; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.quiz_questions
    ADD CONSTRAINT uq_quiz_questions_quiz_order UNIQUE (quiz_id, order_index) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 5316 (class 2606 OID 17138)
-- Name: teacher_course_assignments uq_teacher_course_assignments_teacher_course; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.teacher_course_assignments
    ADD CONSTRAINT uq_teacher_course_assignments_teacher_course UNIQUE (teacher_id, course_id);


--
-- TOC entry 5278 (class 2606 OID 16961)
-- Name: user_roles user_roles_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_roles
    ADD CONSTRAINT user_roles_pkey PRIMARY KEY (user_id, role_id);


--
-- TOC entry 5264 (class 2606 OID 16930)
-- Name: users users_email_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key UNIQUE (email);


--
-- TOC entry 5266 (class 2606 OID 16926)
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- TOC entry 5268 (class 2606 OID 16928)
-- Name: users users_username_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_username_key UNIQUE (username);


--
-- TOC entry 5443 (class 2606 OID 18152)
-- Name: wallet_transactions wallet_transactions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.wallet_transactions
    ADD CONSTRAINT wallet_transactions_pkey PRIMARY KEY (id);


--
-- TOC entry 5431 (class 2606 OID 18118)
-- Name: wallets wallets_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.wallets
    ADD CONSTRAINT wallets_pkey PRIMARY KEY (id);


--
-- TOC entry 5433 (class 2606 OID 18048)
-- Name: wallets wallets_user_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.wallets
    ADD CONSTRAINT wallets_user_id_key UNIQUE (user_id);


--
-- TOC entry 5303 (class 1259 OID 17724)
-- Name: idx_chapters_course_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_chapters_course_id ON public.chapters USING btree (course_id);


--
-- TOC entry 5410 (class 1259 OID 17761)
-- Name: idx_contest_participants_user_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_contest_participants_user_id ON public.contest_participants USING btree (user_id);


--
-- TOC entry 5403 (class 1259 OID 17760)
-- Name: idx_contest_problems_problem_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_contest_problems_problem_id ON public.contest_problems USING btree (problem_id);


--
-- TOC entry 5369 (class 1259 OID 17759)
-- Name: idx_contests_created_by_teacher_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_contests_created_by_teacher_id ON public.contests USING btree (created_by_teacher_id);


--
-- TOC entry 5370 (class 1259 OID 17758)
-- Name: idx_contests_status_time; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_contests_status_time ON public.contests USING btree (status, start_time, end_time);


--
-- TOC entry 5421 (class 1259 OID 17821)
-- Name: idx_course_category_mapping_category_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_course_category_mapping_category_id ON public.course_category_mappings USING btree (category_id);


--
-- TOC entry 5398 (class 1259 OID 17757)
-- Name: idx_course_reviews_user_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_course_reviews_user_id ON public.course_reviews USING btree (user_id);


--
-- TOC entry 5298 (class 1259 OID 17828)
-- Name: idx_courses_average_rating; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_courses_average_rating ON public.courses USING btree (average_rating DESC);


--
-- TOC entry 5299 (class 1259 OID 17723)
-- Name: idx_courses_status; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_courses_status ON public.courses USING btree (status);


--
-- TOC entry 5300 (class 1259 OID 17783)
-- Name: idx_courses_total_enrolled; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_courses_total_enrolled ON public.courses USING btree (total_enrolled DESC);


--
-- TOC entry 5319 (class 1259 OID 17731)
-- Name: idx_enrollments_course_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_enrollments_course_id ON public.enrollments USING btree (course_id);


--
-- TOC entry 5382 (class 1259 OID 17750)
-- Name: idx_file_assignments_created_by_teacher_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_file_assignments_created_by_teacher_id ON public.file_assignments USING btree (created_by_teacher_id);


--
-- TOC entry 5383 (class 1259 OID 17749)
-- Name: idx_file_assignments_lesson_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_file_assignments_lesson_id ON public.file_assignments USING btree (lesson_id);


--
-- TOC entry 5386 (class 1259 OID 17753)
-- Name: idx_file_submissions_graded_by_teacher_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_file_submissions_graded_by_teacher_id ON public.file_submissions USING btree (graded_by_teacher_id);


--
-- TOC entry 5387 (class 1259 OID 17752)
-- Name: idx_file_submissions_status; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_file_submissions_status ON public.file_submissions USING btree (status);


--
-- TOC entry 5388 (class 1259 OID 17751)
-- Name: idx_file_submissions_user_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_file_submissions_user_id ON public.file_submissions USING btree (user_id);


--
-- TOC entry 5281 (class 1259 OID 17720)
-- Name: idx_invalidated_tokens_expiry_time; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_invalidated_tokens_expiry_time ON public.invalidated_tokens USING btree (expiry_time);


--
-- TOC entry 5391 (class 1259 OID 17754)
-- Name: idx_lesson_comments_lesson_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_lesson_comments_lesson_id ON public.lesson_comments USING btree (lesson_id);


--
-- TOC entry 5392 (class 1259 OID 17756)
-- Name: idx_lesson_comments_lesson_parent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_lesson_comments_lesson_parent ON public.lesson_comments USING btree (lesson_id, parent_comment_id);


--
-- TOC entry 5393 (class 1259 OID 17755)
-- Name: idx_lesson_comments_parent_comment_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_lesson_comments_parent_comment_id ON public.lesson_comments USING btree (parent_comment_id);


--
-- TOC entry 5322 (class 1259 OID 17733)
-- Name: idx_lesson_progress_course_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_lesson_progress_course_id ON public.lesson_progress USING btree (course_id);


--
-- TOC entry 5323 (class 1259 OID 17732)
-- Name: idx_lesson_progress_user_course; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_lesson_progress_user_course ON public.lesson_progress USING btree (user_id, course_id);


--
-- TOC entry 5306 (class 1259 OID 17725)
-- Name: idx_lessons_chapter_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_lessons_chapter_id ON public.lessons USING btree (chapter_id);


--
-- TOC entry 5347 (class 1259 OID 17959)
-- Name: idx_online_judge_problems_contest_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_online_judge_problems_contest_id ON public.online_judge_problems USING btree (contest_id);


--
-- TOC entry 5348 (class 1259 OID 17739)
-- Name: idx_online_judge_problems_created_by_teacher_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_online_judge_problems_created_by_teacher_id ON public.online_judge_problems USING btree (created_by_teacher_id);


--
-- TOC entry 5349 (class 1259 OID 17738)
-- Name: idx_online_judge_problems_lesson_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_online_judge_problems_lesson_id ON public.online_judge_problems USING btree (lesson_id);


--
-- TOC entry 5350 (class 1259 OID 17740)
-- Name: idx_online_judge_problems_scope_difficulty; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_online_judge_problems_scope_difficulty ON public.online_judge_problems USING btree (problem_scope, difficulty);


--
-- TOC entry 5371 (class 1259 OID 17743)
-- Name: idx_online_judge_submissions_contest_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_online_judge_submissions_contest_id ON public.online_judge_submissions USING btree (contest_id);


--
-- TOC entry 5372 (class 1259 OID 17744)
-- Name: idx_online_judge_submissions_contest_user_problem; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_online_judge_submissions_contest_user_problem ON public.online_judge_submissions USING btree (contest_id, user_id, problem_id);


--
-- TOC entry 5373 (class 1259 OID 17745)
-- Name: idx_online_judge_submissions_lesson_user_problem; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_online_judge_submissions_lesson_user_problem ON public.online_judge_submissions USING btree (lesson_id, user_id, problem_id);


--
-- TOC entry 5374 (class 1259 OID 17747)
-- Name: idx_online_judge_submissions_problem_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_online_judge_submissions_problem_id ON public.online_judge_submissions USING btree (problem_id);


--
-- TOC entry 5375 (class 1259 OID 17748)
-- Name: idx_online_judge_submissions_submitted_at; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_online_judge_submissions_submitted_at ON public.online_judge_submissions USING btree (submitted_at);


--
-- TOC entry 5376 (class 1259 OID 17746)
-- Name: idx_online_judge_submissions_user_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_online_judge_submissions_user_id ON public.online_judge_submissions USING btree (user_id);


--
-- TOC entry 5448 (class 1259 OID 18247)
-- Name: idx_order_items_course_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_order_items_course_id ON public.order_items USING btree (course_id);


--
-- TOC entry 5449 (class 1259 OID 18246)
-- Name: idx_order_items_order_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_order_items_order_id ON public.order_items USING btree (order_id);


--
-- TOC entry 5444 (class 1259 OID 18245)
-- Name: idx_orders_status; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_orders_status ON public.orders USING btree (status);


--
-- TOC entry 5445 (class 1259 OID 18244)
-- Name: idx_orders_user_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_orders_user_id ON public.orders USING btree (user_id);


--
-- TOC entry 5434 (class 1259 OID 18112)
-- Name: idx_payment_tx_code; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_payment_tx_code ON public.payment_transactions USING btree (transaction_code);


--
-- TOC entry 5435 (class 1259 OID 18167)
-- Name: idx_payment_tx_wallet_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_payment_tx_wallet_id ON public.payment_transactions USING btree (wallet_id);


--
-- TOC entry 5357 (class 1259 OID 17741)
-- Name: idx_problem_tag_mappings_tag_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_problem_tag_mappings_tag_id ON public.problem_tag_mappings USING btree (tag_id);


--
-- TOC entry 5362 (class 1259 OID 17742)
-- Name: idx_problem_testcases_problem_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_problem_testcases_problem_id ON public.problem_testcases USING btree (problem_id);


--
-- TOC entry 5343 (class 1259 OID 17737)
-- Name: idx_quiz_attempts_quiz_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_quiz_attempts_quiz_id ON public.quiz_attempts USING btree (quiz_id);


--
-- TOC entry 5344 (class 1259 OID 17736)
-- Name: idx_quiz_attempts_user_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_quiz_attempts_user_id ON public.quiz_attempts USING btree (user_id);


--
-- TOC entry 5340 (class 1259 OID 17735)
-- Name: idx_quiz_options_question_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_quiz_options_question_id ON public.quiz_options USING btree (question_id);


--
-- TOC entry 5335 (class 1259 OID 17734)
-- Name: idx_quiz_questions_quiz_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_quiz_questions_quiz_id ON public.quiz_questions USING btree (quiz_id);


--
-- TOC entry 5286 (class 1259 OID 17722)
-- Name: idx_refresh_tokens_expires_at; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_refresh_tokens_expires_at ON public.refresh_tokens USING btree (expires_at);


--
-- TOC entry 5287 (class 1259 OID 17721)
-- Name: idx_refresh_tokens_user_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_refresh_tokens_user_id ON public.refresh_tokens USING btree (user_id);


--
-- TOC entry 5426 (class 1259 OID 17953)
-- Name: idx_submission_details_submission_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_submission_details_submission_id ON public.online_judge_submission_details USING btree (submission_id);


--
-- TOC entry 5377 (class 1259 OID 18265)
-- Name: idx_submission_user_verdict; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_submission_user_verdict ON public.online_judge_submissions USING btree (user_id, verdict, problem_id);


--
-- TOC entry 5311 (class 1259 OID 17727)
-- Name: idx_teacher_course_assignments_assigned_by_admin_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_teacher_course_assignments_assigned_by_admin_id ON public.teacher_course_assignments USING btree (assigned_by_admin_id);


--
-- TOC entry 5312 (class 1259 OID 17726)
-- Name: idx_teacher_course_assignments_course_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_teacher_course_assignments_course_id ON public.teacher_course_assignments USING btree (course_id);


--
-- TOC entry 5440 (class 1259 OID 18248)
-- Name: idx_wallet_transactions_order_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_wallet_transactions_order_id ON public.wallet_transactions USING btree (order_id);


--
-- TOC entry 5441 (class 1259 OID 18174)
-- Name: idx_wallet_tx_wallet_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_wallet_tx_wallet_id ON public.wallet_transactions USING btree (wallet_id);


--
-- TOC entry 5334 (class 1259 OID 17906)
-- Name: uq_quizzes_lesson_active; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX uq_quizzes_lesson_active ON public.quizzes USING btree (lesson_id) WHERE (is_deleted = false);


--
-- TOC entry 5429 (class 1259 OID 17952)
-- Name: uq_submission_details_token; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX uq_submission_details_token ON public.online_judge_submission_details USING btree (token);


--
-- TOC entry 5533 (class 2620 OID 18249)
-- Name: orders set_orders_updated_at; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER set_orders_updated_at BEFORE UPDATE ON public.orders FOR EACH ROW EXECUTE FUNCTION public.set_updated_at();


--
-- TOC entry 5529 (class 2620 OID 17822)
-- Name: categories trg_categories_set_updated_at; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER trg_categories_set_updated_at BEFORE UPDATE ON public.categories FOR EACH ROW EXECUTE FUNCTION public.set_updated_at();


--
-- TOC entry 5518 (class 2620 OID 17869)
-- Name: chapters trg_chapters_updated_at; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER trg_chapters_updated_at BEFORE UPDATE ON public.chapters FOR EACH ROW EXECUTE FUNCTION public.set_updated_at();


--
-- TOC entry 5520 (class 2620 OID 17766)
-- Name: completed_lessons_count trg_completed_lessons_count_set_updated_at; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER trg_completed_lessons_count_set_updated_at BEFORE UPDATE ON public.completed_lessons_count FOR EACH ROW EXECUTE FUNCTION public.set_updated_at();


--
-- TOC entry 5525 (class 2620 OID 17773)
-- Name: contests trg_contests_set_updated_at; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER trg_contests_set_updated_at BEFORE UPDATE ON public.contests FOR EACH ROW EXECUTE FUNCTION public.set_updated_at();


--
-- TOC entry 5528 (class 2620 OID 17772)
-- Name: course_reviews trg_course_reviews_set_updated_at; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER trg_course_reviews_set_updated_at BEFORE UPDATE ON public.course_reviews FOR EACH ROW EXECUTE FUNCTION public.set_updated_at();


--
-- TOC entry 5517 (class 2620 OID 17764)
-- Name: courses trg_courses_set_updated_at; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER trg_courses_set_updated_at BEFORE UPDATE ON public.courses FOR EACH ROW EXECUTE FUNCTION public.set_updated_at();


--
-- TOC entry 5526 (class 2620 OID 17770)
-- Name: file_assignments trg_file_assignments_set_updated_at; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER trg_file_assignments_set_updated_at BEFORE UPDATE ON public.file_assignments FOR EACH ROW EXECUTE FUNCTION public.set_updated_at();


--
-- TOC entry 5527 (class 2620 OID 17771)
-- Name: lesson_comments trg_lesson_comments_set_updated_at; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER trg_lesson_comments_set_updated_at BEFORE UPDATE ON public.lesson_comments FOR EACH ROW EXECUTE FUNCTION public.set_updated_at();


--
-- TOC entry 5519 (class 2620 OID 17765)
-- Name: lessons trg_lessons_set_updated_at; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER trg_lessons_set_updated_at BEFORE UPDATE ON public.lessons FOR EACH ROW EXECUTE FUNCTION public.set_updated_at();


--
-- TOC entry 5523 (class 2620 OID 17768)
-- Name: online_judge_problems trg_online_judge_problems_set_updated_at; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER trg_online_judge_problems_set_updated_at BEFORE UPDATE ON public.online_judge_problems FOR EACH ROW EXECUTE FUNCTION public.set_updated_at();


--
-- TOC entry 5531 (class 2620 OID 18114)
-- Name: payment_transactions trg_payment_tx_set_updated_at; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER trg_payment_tx_set_updated_at BEFORE UPDATE ON public.payment_transactions FOR EACH ROW EXECUTE FUNCTION public.set_updated_at();


--
-- TOC entry 5524 (class 2620 OID 17769)
-- Name: problem_tags trg_problem_tags_set_updated_at; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER trg_problem_tags_set_updated_at BEFORE UPDATE ON public.problem_tags FOR EACH ROW EXECUTE FUNCTION public.set_updated_at();


--
-- TOC entry 5521 (class 2620 OID 17767)
-- Name: quizzes trg_quizzes_set_updated_at; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER trg_quizzes_set_updated_at BEFORE UPDATE ON public.quizzes FOR EACH ROW EXECUTE FUNCTION public.set_updated_at();


--
-- TOC entry 5516 (class 2620 OID 17763)
-- Name: teachers trg_teachers_set_updated_at; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER trg_teachers_set_updated_at BEFORE UPDATE ON public.teachers FOR EACH ROW EXECUTE FUNCTION public.set_updated_at();


--
-- TOC entry 5515 (class 2620 OID 17762)
-- Name: users trg_users_set_updated_at; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER trg_users_set_updated_at BEFORE UPDATE ON public.users FOR EACH ROW EXECUTE FUNCTION public.set_updated_at();


--
-- TOC entry 5532 (class 2620 OID 18115)
-- Name: wallet_transactions trg_wallet_tx_set_updated_at; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER trg_wallet_tx_set_updated_at BEFORE UPDATE ON public.wallet_transactions FOR EACH ROW EXECUTE FUNCTION public.set_updated_at();


--
-- TOC entry 5530 (class 2620 OID 18113)
-- Name: wallets trg_wallets_set_updated_at; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER trg_wallets_set_updated_at BEFORE UPDATE ON public.wallets FOR EACH ROW EXECUTE FUNCTION public.set_updated_at();


--
-- TOC entry 5522 (class 2620 OID 17900)
-- Name: quiz_attempts trigger_quiz_attempts_updated_at; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER trigger_quiz_attempts_updated_at BEFORE UPDATE ON public.quiz_attempts FOR EACH ROW EXECUTE FUNCTION public.set_updated_at();


--
-- TOC entry 5458 (class 2606 OID 17088)
-- Name: chapters fk_chapters_course; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.chapters
    ADD CONSTRAINT fk_chapters_course FOREIGN KEY (course_id) REFERENCES public.courses(id) ON DELETE CASCADE;


--
-- TOC entry 5468 (class 2606 OID 17264)
-- Name: completed_lessons_count fk_completed_lessons_count_course; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.completed_lessons_count
    ADD CONSTRAINT fk_completed_lessons_count_course FOREIGN KEY (course_id) REFERENCES public.courses(id) ON DELETE CASCADE;


--
-- TOC entry 5469 (class 2606 OID 17259)
-- Name: completed_lessons_count fk_completed_lessons_count_user; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.completed_lessons_count
    ADD CONSTRAINT fk_completed_lessons_count_user FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- TOC entry 5499 (class 2606 OID 17709)
-- Name: contest_participants fk_contest_participants_contest; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.contest_participants
    ADD CONSTRAINT fk_contest_participants_contest FOREIGN KEY (contest_id) REFERENCES public.contests(id) ON DELETE CASCADE;


--
-- TOC entry 5500 (class 2606 OID 17714)
-- Name: contest_participants fk_contest_participants_user; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.contest_participants
    ADD CONSTRAINT fk_contest_participants_user FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- TOC entry 5497 (class 2606 OID 17685)
-- Name: contest_problems fk_contest_problems_contest; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.contest_problems
    ADD CONSTRAINT fk_contest_problems_contest FOREIGN KEY (contest_id) REFERENCES public.contests(id) ON DELETE CASCADE;


--
-- TOC entry 5498 (class 2606 OID 17690)
-- Name: contest_problems fk_contest_problems_problem; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.contest_problems
    ADD CONSTRAINT fk_contest_problems_problem FOREIGN KEY (problem_id) REFERENCES public.online_judge_problems(id) ON DELETE CASCADE;


--
-- TOC entry 5482 (class 2606 OID 17488)
-- Name: contests fk_contests_created_by_teacher; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.contests
    ADD CONSTRAINT fk_contests_created_by_teacher FOREIGN KEY (created_by_teacher_id) REFERENCES public.teachers(id);


--
-- TOC entry 5501 (class 2606 OID 17816)
-- Name: course_category_mappings fk_course_category_category; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.course_category_mappings
    ADD CONSTRAINT fk_course_category_category FOREIGN KEY (category_id) REFERENCES public.categories(id) ON DELETE CASCADE;


--
-- TOC entry 5502 (class 2606 OID 17811)
-- Name: course_category_mappings fk_course_category_course; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.course_category_mappings
    ADD CONSTRAINT fk_course_category_course FOREIGN KEY (course_id) REFERENCES public.courses(id) ON DELETE CASCADE;


--
-- TOC entry 5495 (class 2606 OID 17656)
-- Name: course_reviews fk_course_reviews_course; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.course_reviews
    ADD CONSTRAINT fk_course_reviews_course FOREIGN KEY (course_id) REFERENCES public.courses(id) ON DELETE CASCADE;


--
-- TOC entry 5496 (class 2606 OID 17661)
-- Name: course_reviews fk_course_reviews_user; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.course_reviews
    ADD CONSTRAINT fk_course_reviews_user FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- TOC entry 5463 (class 2606 OID 17202)
-- Name: enrollments fk_enrollments_course; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.enrollments
    ADD CONSTRAINT fk_enrollments_course FOREIGN KEY (course_id) REFERENCES public.courses(id) ON DELETE CASCADE;


--
-- TOC entry 5464 (class 2606 OID 17197)
-- Name: enrollments fk_enrollments_user; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.enrollments
    ADD CONSTRAINT fk_enrollments_user FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- TOC entry 5487 (class 2606 OID 17557)
-- Name: file_assignments fk_file_assignments_created_by_teacher; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.file_assignments
    ADD CONSTRAINT fk_file_assignments_created_by_teacher FOREIGN KEY (created_by_teacher_id) REFERENCES public.teachers(id);


--
-- TOC entry 5488 (class 2606 OID 17552)
-- Name: file_assignments fk_file_assignments_lesson; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.file_assignments
    ADD CONSTRAINT fk_file_assignments_lesson FOREIGN KEY (lesson_id) REFERENCES public.lessons(id) ON DELETE CASCADE;


--
-- TOC entry 5489 (class 2606 OID 17587)
-- Name: file_submissions fk_file_submissions_file_assignment; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.file_submissions
    ADD CONSTRAINT fk_file_submissions_file_assignment FOREIGN KEY (file_assignment_id) REFERENCES public.file_assignments(id) ON DELETE CASCADE;


--
-- TOC entry 5490 (class 2606 OID 17597)
-- Name: file_submissions fk_file_submissions_graded_by_teacher; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.file_submissions
    ADD CONSTRAINT fk_file_submissions_graded_by_teacher FOREIGN KEY (graded_by_teacher_id) REFERENCES public.teachers(id);


--
-- TOC entry 5491 (class 2606 OID 17592)
-- Name: file_submissions fk_file_submissions_user; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.file_submissions
    ADD CONSTRAINT fk_file_submissions_user FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- TOC entry 5492 (class 2606 OID 17621)
-- Name: lesson_comments fk_lesson_comments_lesson; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.lesson_comments
    ADD CONSTRAINT fk_lesson_comments_lesson FOREIGN KEY (lesson_id) REFERENCES public.lessons(id) ON DELETE CASCADE;


--
-- TOC entry 5493 (class 2606 OID 17631)
-- Name: lesson_comments fk_lesson_comments_parent; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.lesson_comments
    ADD CONSTRAINT fk_lesson_comments_parent FOREIGN KEY (parent_comment_id) REFERENCES public.lesson_comments(id) ON DELETE CASCADE;


--
-- TOC entry 5494 (class 2606 OID 17626)
-- Name: lesson_comments fk_lesson_comments_user; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.lesson_comments
    ADD CONSTRAINT fk_lesson_comments_user FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- TOC entry 5465 (class 2606 OID 17237)
-- Name: lesson_progress fk_lesson_progress_course; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.lesson_progress
    ADD CONSTRAINT fk_lesson_progress_course FOREIGN KEY (course_id) REFERENCES public.courses(id) ON DELETE CASCADE;


--
-- TOC entry 5466 (class 2606 OID 17232)
-- Name: lesson_progress fk_lesson_progress_lesson; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.lesson_progress
    ADD CONSTRAINT fk_lesson_progress_lesson FOREIGN KEY (lesson_id) REFERENCES public.lessons(id) ON DELETE CASCADE;


--
-- TOC entry 5467 (class 2606 OID 17227)
-- Name: lesson_progress fk_lesson_progress_user; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.lesson_progress
    ADD CONSTRAINT fk_lesson_progress_user FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- TOC entry 5459 (class 2606 OID 17119)
-- Name: lessons fk_lessons_chapter; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.lessons
    ADD CONSTRAINT fk_lessons_chapter FOREIGN KEY (chapter_id) REFERENCES public.chapters(id) ON DELETE CASCADE;


--
-- TOC entry 5476 (class 2606 OID 17954)
-- Name: online_judge_problems fk_online_judge_problems_contest; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.online_judge_problems
    ADD CONSTRAINT fk_online_judge_problems_contest FOREIGN KEY (contest_id) REFERENCES public.contests(id) ON DELETE SET NULL;


--
-- TOC entry 5477 (class 2606 OID 17397)
-- Name: online_judge_problems fk_online_judge_problems_created_by_teacher; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.online_judge_problems
    ADD CONSTRAINT fk_online_judge_problems_created_by_teacher FOREIGN KEY (created_by_teacher_id) REFERENCES public.teachers(id);


--
-- TOC entry 5478 (class 2606 OID 17392)
-- Name: online_judge_problems fk_online_judge_problems_lesson; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.online_judge_problems
    ADD CONSTRAINT fk_online_judge_problems_lesson FOREIGN KEY (lesson_id) REFERENCES public.lessons(id) ON DELETE SET NULL;


--
-- TOC entry 5483 (class 2606 OID 17529)
-- Name: online_judge_submissions fk_online_judge_submissions_contest; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.online_judge_submissions
    ADD CONSTRAINT fk_online_judge_submissions_contest FOREIGN KEY (contest_id) REFERENCES public.contests(id);


--
-- TOC entry 5484 (class 2606 OID 17524)
-- Name: online_judge_submissions fk_online_judge_submissions_lesson; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.online_judge_submissions
    ADD CONSTRAINT fk_online_judge_submissions_lesson FOREIGN KEY (lesson_id) REFERENCES public.lessons(id);


--
-- TOC entry 5485 (class 2606 OID 17519)
-- Name: online_judge_submissions fk_online_judge_submissions_problem; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.online_judge_submissions
    ADD CONSTRAINT fk_online_judge_submissions_problem FOREIGN KEY (problem_id) REFERENCES public.online_judge_problems(id);


--
-- TOC entry 5486 (class 2606 OID 17514)
-- Name: online_judge_submissions fk_online_judge_submissions_user; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.online_judge_submissions
    ADD CONSTRAINT fk_online_judge_submissions_user FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- TOC entry 5513 (class 2606 OID 18234)
-- Name: order_items fk_order_items_course; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_items
    ADD CONSTRAINT fk_order_items_course FOREIGN KEY (course_id) REFERENCES public.courses(id);


--
-- TOC entry 5514 (class 2606 OID 18229)
-- Name: order_items fk_order_items_order; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_items
    ADD CONSTRAINT fk_order_items_order FOREIGN KEY (order_id) REFERENCES public.orders(id);


--
-- TOC entry 5512 (class 2606 OID 18212)
-- Name: orders fk_orders_user; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT fk_orders_user FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- TOC entry 5509 (class 2606 OID 18169)
-- Name: payment_transactions fk_payment_transactions_wallet; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.payment_transactions
    ADD CONSTRAINT fk_payment_transactions_wallet FOREIGN KEY (wallet_id) REFERENCES public.wallets(id) ON DELETE CASCADE;


--
-- TOC entry 5479 (class 2606 OID 17432)
-- Name: problem_tag_mappings fk_problem_tag_mappings_problem; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.problem_tag_mappings
    ADD CONSTRAINT fk_problem_tag_mappings_problem FOREIGN KEY (problem_id) REFERENCES public.online_judge_problems(id) ON DELETE CASCADE;


--
-- TOC entry 5480 (class 2606 OID 17437)
-- Name: problem_tag_mappings fk_problem_tag_mappings_tag; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.problem_tag_mappings
    ADD CONSTRAINT fk_problem_tag_mappings_tag FOREIGN KEY (tag_id) REFERENCES public.problem_tags(id) ON DELETE CASCADE;


--
-- TOC entry 5481 (class 2606 OID 17461)
-- Name: problem_testcases fk_problem_testcases_problem; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.problem_testcases
    ADD CONSTRAINT fk_problem_testcases_problem FOREIGN KEY (problem_id) REFERENCES public.online_judge_problems(id) ON DELETE CASCADE;


--
-- TOC entry 5474 (class 2606 OID 17365)
-- Name: quiz_attempts fk_quiz_attempts_quiz; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.quiz_attempts
    ADD CONSTRAINT fk_quiz_attempts_quiz FOREIGN KEY (quiz_id) REFERENCES public.quizzes(id) ON DELETE CASCADE;


--
-- TOC entry 5475 (class 2606 OID 17360)
-- Name: quiz_attempts fk_quiz_attempts_user; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.quiz_attempts
    ADD CONSTRAINT fk_quiz_attempts_user FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- TOC entry 5473 (class 2606 OID 17337)
-- Name: quiz_options fk_quiz_options_question; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.quiz_options
    ADD CONSTRAINT fk_quiz_options_question FOREIGN KEY (question_id) REFERENCES public.quiz_questions(id) ON DELETE CASCADE;


--
-- TOC entry 5472 (class 2606 OID 17316)
-- Name: quiz_questions fk_quiz_questions_quiz; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.quiz_questions
    ADD CONSTRAINT fk_quiz_questions_quiz FOREIGN KEY (quiz_id) REFERENCES public.quizzes(id) ON DELETE CASCADE;


--
-- TOC entry 5470 (class 2606 OID 17294)
-- Name: quizzes fk_quizzes_created_by_teacher; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.quizzes
    ADD CONSTRAINT fk_quizzes_created_by_teacher FOREIGN KEY (created_by_teacher_id) REFERENCES public.teachers(id);


--
-- TOC entry 5471 (class 2606 OID 17289)
-- Name: quizzes fk_quizzes_lesson; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.quizzes
    ADD CONSTRAINT fk_quizzes_lesson FOREIGN KEY (lesson_id) REFERENCES public.lessons(id) ON DELETE CASCADE;


--
-- TOC entry 5456 (class 2606 OID 17024)
-- Name: refresh_tokens fk_refresh_tokens_user; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.refresh_tokens
    ADD CONSTRAINT fk_refresh_tokens_user FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- TOC entry 5454 (class 2606 OID 16984)
-- Name: role_permissions fk_role_permissions_permission; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.role_permissions
    ADD CONSTRAINT fk_role_permissions_permission FOREIGN KEY (permission_id) REFERENCES public.permissions(id) ON DELETE CASCADE;


--
-- TOC entry 5455 (class 2606 OID 16979)
-- Name: role_permissions fk_role_permissions_role; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.role_permissions
    ADD CONSTRAINT fk_role_permissions_role FOREIGN KEY (role_id) REFERENCES public.roles(id) ON DELETE CASCADE;


--
-- TOC entry 5506 (class 2606 OID 17942)
-- Name: online_judge_submission_details fk_sub_details_submission; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.online_judge_submission_details
    ADD CONSTRAINT fk_sub_details_submission FOREIGN KEY (submission_id) REFERENCES public.online_judge_submissions(id) ON DELETE CASCADE;


--
-- TOC entry 5507 (class 2606 OID 17947)
-- Name: online_judge_submission_details fk_sub_details_testcase; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.online_judge_submission_details
    ADD CONSTRAINT fk_sub_details_testcase FOREIGN KEY (testcase_id) REFERENCES public.problem_testcases(id) ON DELETE CASCADE;


--
-- TOC entry 5460 (class 2606 OID 17149)
-- Name: teacher_course_assignments fk_teacher_course_assignments_admin; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.teacher_course_assignments
    ADD CONSTRAINT fk_teacher_course_assignments_admin FOREIGN KEY (assigned_by_admin_id) REFERENCES public.users(id);


--
-- TOC entry 5461 (class 2606 OID 17144)
-- Name: teacher_course_assignments fk_teacher_course_assignments_course; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.teacher_course_assignments
    ADD CONSTRAINT fk_teacher_course_assignments_course FOREIGN KEY (course_id) REFERENCES public.courses(id) ON DELETE CASCADE;


--
-- TOC entry 5462 (class 2606 OID 17139)
-- Name: teacher_course_assignments fk_teacher_course_assignments_teacher; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.teacher_course_assignments
    ADD CONSTRAINT fk_teacher_course_assignments_teacher FOREIGN KEY (teacher_id) REFERENCES public.teachers(id) ON DELETE CASCADE;


--
-- TOC entry 5457 (class 2606 OID 17046)
-- Name: teachers fk_teachers_user; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.teachers
    ADD CONSTRAINT fk_teachers_user FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- TOC entry 5452 (class 2606 OID 16967)
-- Name: user_roles fk_user_roles_role; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_roles
    ADD CONSTRAINT fk_user_roles_role FOREIGN KEY (role_id) REFERENCES public.roles(id) ON DELETE CASCADE;


--
-- TOC entry 5453 (class 2606 OID 16962)
-- Name: user_roles fk_user_roles_user; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_roles
    ADD CONSTRAINT fk_user_roles_user FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- TOC entry 5510 (class 2606 OID 18176)
-- Name: wallet_transactions fk_wallet_transactions_wallet; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.wallet_transactions
    ADD CONSTRAINT fk_wallet_transactions_wallet FOREIGN KEY (wallet_id) REFERENCES public.wallets(id) ON DELETE CASCADE;


--
-- TOC entry 5511 (class 2606 OID 18239)
-- Name: wallet_transactions fk_wallet_tx_order; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.wallet_transactions
    ADD CONSTRAINT fk_wallet_tx_order FOREIGN KEY (order_id) REFERENCES public.orders(id);


--
-- TOC entry 5508 (class 2606 OID 18049)
-- Name: wallets fk_wallets_user; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.wallets
    ADD CONSTRAINT fk_wallets_user FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- TOC entry 5503 (class 2606 OID 17882)
-- Name: quiz_attempt_answers quiz_attempt_answers_attempt_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.quiz_attempt_answers
    ADD CONSTRAINT quiz_attempt_answers_attempt_id_fkey FOREIGN KEY (attempt_id) REFERENCES public.quiz_attempts(id) ON DELETE CASCADE;


--
-- TOC entry 5504 (class 2606 OID 17887)
-- Name: quiz_attempt_answers quiz_attempt_answers_question_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.quiz_attempt_answers
    ADD CONSTRAINT quiz_attempt_answers_question_id_fkey FOREIGN KEY (question_id) REFERENCES public.quiz_questions(id);


--
-- TOC entry 5505 (class 2606 OID 17892)
-- Name: quiz_attempt_answers quiz_attempt_answers_selected_option_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.quiz_attempt_answers
    ADD CONSTRAINT quiz_attempt_answers_selected_option_id_fkey FOREIGN KEY (selected_option_id) REFERENCES public.quiz_options(id);


-- Completed on 2026-05-26 17:54:19

--
-- PostgreSQL database dump complete
--

\unrestrict eh9aZ505qjye1DljdiNNWA1U0uTOBbIVxhJf2f81Egrlka3aufvPvBqtMXm3aLf

