--
-- PostgreSQL database dump
--

\restrict 1RyEnMLsxzw48cYJUbpVebs4TvJtfonZmUguOOcIpseZZQtocN2G4L3mX9wIfHU

-- Dumped from database version 18.1
-- Dumped by pg_dump version 18.1

-- Started on 2026-05-30 11:38:55

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
-- TOC entry 5848 (class 1262 OID 16800)
-- Name: CodeLearning; Type: DATABASE; Schema: -; Owner: postgres
--

CREATE DATABASE "CodeLearning" WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'English_United States.1252';


ALTER DATABASE "CodeLearning" OWNER TO postgres;

\unrestrict 1RyEnMLsxzw48cYJUbpVebs4TvJtfonZmUguOOcIpseZZQtocN2G4L3mX9wIfHU
\connect "CodeLearning"
\restrict 1RyEnMLsxzw48cYJUbpVebs4TvJtfonZmUguOOcIpseZZQtocN2G4L3mX9wIfHU

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
-- TOC entry 5849 (class 0 OID 0)
-- Dependencies: 4
-- Name: SCHEMA public; Type: COMMENT; Schema: -; Owner: pg_database_owner
--

COMMENT ON SCHEMA public IS 'standard public schema';


--
-- TOC entry 954 (class 1247 OID 16842)
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
-- TOC entry 942 (class 1247 OID 16810)
-- Name: course_status; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.course_status AS ENUM (
    'ACTIVE',
    'INACTIVE',
    'DRAFT'
);


ALTER TYPE public.course_status OWNER TO postgres;

--
-- TOC entry 948 (class 1247 OID 16826)
-- Name: enrollment_status; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.enrollment_status AS ENUM (
    'ACTIVE',
    'CANCELLED',
    'COMPLETED'
);


ALTER TYPE public.enrollment_status OWNER TO postgres;

--
-- TOC entry 963 (class 1247 OID 16892)
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
-- TOC entry 945 (class 1247 OID 16818)
-- Name: lesson_status; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.lesson_status AS ENUM (
    'ACTIVE',
    'INACTIVE',
    'DRAFT'
);


ALTER TYPE public.lesson_status OWNER TO postgres;

--
-- TOC entry 1068 (class 1247 OID 17908)
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
-- TOC entry 1095 (class 1247 OID 18187)
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
-- TOC entry 1077 (class 1247 OID 18002)
-- Name: payment_transaction_type; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.payment_transaction_type AS ENUM (
    'DEPOSIT',
    'WITHDRAW'
);


ALTER TYPE public.payment_transaction_type OWNER TO postgres;

--
-- TOC entry 960 (class 1247 OID 16860)
-- Name: problem_difficulty; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.problem_difficulty AS ENUM (
    'EASY',
    'MEDIUM',
    'HARD'
);


ALTER TYPE public.problem_difficulty OWNER TO postgres;

--
-- TOC entry 957 (class 1247 OID 16852)
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
-- TOC entry 1104 (class 1247 OID 18267)
-- Name: scoring_rule; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.scoring_rule AS ENUM (
    'ICPC',
    'IOI',
    'CUSTOM'
);


ALTER TYPE public.scoring_rule OWNER TO postgres;

--
-- TOC entry 951 (class 1247 OID 16834)
-- Name: teacher_status; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.teacher_status AS ENUM (
    'ACTIVE',
    'INACTIVE',
    'LOCKED'
);


ALTER TYPE public.teacher_status OWNER TO postgres;

--
-- TOC entry 1083 (class 1247 OID 18020)
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
-- TOC entry 939 (class 1247 OID 16802)
-- Name: user_status; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.user_status AS ENUM (
    'ACTIVE',
    'LOCKED',
    'DISABLED'
);


ALTER TYPE public.user_status OWNER TO postgres;

--
-- TOC entry 1074 (class 1247 OID 17996)
-- Name: wallet_status; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.wallet_status AS ENUM (
    'ACTIVE',
    'LOCKED'
);


ALTER TYPE public.wallet_status OWNER TO postgres;

--
-- TOC entry 1080 (class 1247 OID 18008)
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
-- TOC entry 306 (class 1255 OID 16905)
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
-- TOC entry 298 (class 1259 OID 18286)
-- Name: cart_items; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.cart_items (
    id bigint NOT NULL,
    cart_id bigint NOT NULL,
    course_id bigint NOT NULL,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public.cart_items OWNER TO postgres;

--
-- TOC entry 299 (class 1259 OID 18294)
-- Name: cart_items_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.cart_items_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.cart_items_id_seq OWNER TO postgres;

--
-- TOC entry 5850 (class 0 OID 0)
-- Dependencies: 299
-- Name: cart_items_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.cart_items_id_seq OWNED BY public.cart_items.id;


--
-- TOC entry 296 (class 1259 OID 18275)
-- Name: carts; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.carts (
    id bigint NOT NULL,
    user_id bigint NOT NULL,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public.carts OWNER TO postgres;

--
-- TOC entry 297 (class 1259 OID 18284)
-- Name: carts_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.carts_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.carts_id_seq OWNER TO postgres;

--
-- TOC entry 5851 (class 0 OID 0)
-- Dependencies: 297
-- Name: carts_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.carts_id_seq OWNED BY public.carts.id;


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
-- TOC entry 5852 (class 0 OID 0)
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
-- TOC entry 5853 (class 0 OID 0)
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
-- TOC entry 5854 (class 0 OID 0)
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
-- TOC entry 5855 (class 0 OID 0)
-- Dependencies: 277
-- Name: contest_participants_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.contest_participants_id_seq OWNED BY public.contest_participants.id;


--
-- TOC entry 303 (class 1259 OID 18349)
-- Name: contest_problem_attempts; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.contest_problem_attempts (
    id bigint NOT NULL,
    contest_id bigint NOT NULL,
    user_id bigint NOT NULL,
    problem_id bigint NOT NULL,
    is_solved boolean DEFAULT false NOT NULL,
    solved_at_seconds integer,
    failed_attempts_count integer DEFAULT 0 NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    CONSTRAINT chk_contest_problem_attempts_failed_attempts CHECK ((failed_attempts_count >= 0)),
    CONSTRAINT chk_contest_problem_attempts_solved_at CHECK ((solved_at_seconds >= 0))
);


ALTER TABLE public.contest_problem_attempts OWNER TO postgres;

--
-- TOC entry 302 (class 1259 OID 18348)
-- Name: contest_problem_attempts_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.contest_problem_attempts ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.contest_problem_attempts_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 276 (class 1259 OID 17667)
-- Name: contest_problems; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.contest_problems (
    id bigint NOT NULL,
    contest_id bigint NOT NULL,
    problem_id bigint NOT NULL,
    order_index integer NOT NULL,
    CONSTRAINT chk_contest_problems_order_positive CHECK ((order_index > 0))
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
-- TOC entry 5856 (class 0 OID 0)
-- Dependencies: 275
-- Name: contest_problems_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.contest_problems_id_seq OWNED BY public.contest_problems.id;


--
-- TOC entry 301 (class 1259 OID 18320)
-- Name: contest_rankings; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.contest_rankings (
    id bigint NOT NULL,
    contest_id bigint NOT NULL,
    user_id bigint NOT NULL,
    problems_solved integer DEFAULT 0 NOT NULL,
    total_penalty integer DEFAULT 0 NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    CONSTRAINT chk_contest_rankings_problems_solved CHECK ((problems_solved >= 0)),
    CONSTRAINT chk_contest_rankings_total_penalty CHECK ((total_penalty >= 0))
);


ALTER TABLE public.contest_rankings OWNER TO postgres;

--
-- TOC entry 300 (class 1259 OID 18319)
-- Name: contest_rankings_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.contest_rankings ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.contest_rankings_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


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
    created_by_teacher_id bigint NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    scoring_rule public.scoring_rule DEFAULT 'ICPC'::public.scoring_rule NOT NULL,
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
-- TOC entry 5857 (class 0 OID 0)
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
-- TOC entry 5858 (class 0 OID 0)
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
    thumbnail_public_id character varying(255),
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
-- TOC entry 5859 (class 0 OID 0)
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
-- TOC entry 5860 (class 0 OID 0)
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
-- TOC entry 5861 (class 0 OID 0)
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
-- TOC entry 5862 (class 0 OID 0)
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
-- TOC entry 5863 (class 0 OID 0)
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
-- TOC entry 5864 (class 0 OID 0)
-- Dependencies: 271
-- Name: lesson_comments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.lesson_comments_id_seq OWNED BY public.lesson_comments.id;


--
-- TOC entry 305 (class 1259 OID 18390)
-- Name: lesson_problems; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.lesson_problems (
    id bigint NOT NULL,
    lesson_id bigint NOT NULL,
    problem_id bigint NOT NULL,
    order_index integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.lesson_problems OWNER TO postgres;

--
-- TOC entry 304 (class 1259 OID 18389)
-- Name: lesson_problems_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.lesson_problems_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.lesson_problems_id_seq OWNER TO postgres;

--
-- TOC entry 5865 (class 0 OID 0)
-- Dependencies: 304
-- Name: lesson_problems_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.lesson_problems_id_seq OWNED BY public.lesson_problems.id;


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
-- TOC entry 5866 (class 0 OID 0)
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
    video_public_id character varying(255),
    theory_content text,
    sample_code text,
    is_trial boolean DEFAULT false NOT NULL,
    order_index integer NOT NULL,
    estimated_duration_minutes integer,
    status public.lesson_status DEFAULT 'DRAFT'::public.lesson_status NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
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
-- TOC entry 5867 (class 0 OID 0)
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
    total_testcase integer DEFAULT 0 NOT NULL,
    time_limit_ms integer DEFAULT 2000 NOT NULL,
    memory_limit_kb integer DEFAULT 128000 NOT NULL,
    is_public boolean DEFAULT false NOT NULL,
    total_submissions integer DEFAULT 0 NOT NULL,
    total_accepted integer DEFAULT 0 NOT NULL,
    score numeric(6,2) DEFAULT 100.00 NOT NULL,
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
-- TOC entry 5868 (class 0 OID 0)
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
-- TOC entry 5869 (class 0 OID 0)
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
    CONSTRAINT chk_online_judge_submissions_context CHECK ((((lesson_id IS NOT NULL) AND (contest_id IS NULL)) OR ((lesson_id IS NULL) AND (contest_id IS NOT NULL)) OR ((lesson_id IS NULL) AND (contest_id IS NULL)))),
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
-- TOC entry 5870 (class 0 OID 0)
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
-- TOC entry 5871 (class 0 OID 0)
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
-- TOC entry 5872 (class 0 OID 0)
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
-- TOC entry 5873 (class 0 OID 0)
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
-- TOC entry 5874 (class 0 OID 0)
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
-- TOC entry 5875 (class 0 OID 0)
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
-- TOC entry 5876 (class 0 OID 0)
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
    input_data text,
    expected_output text,
    is_hidden boolean DEFAULT false NOT NULL,
    order_index integer NOT NULL,
    token character varying(255),
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
-- TOC entry 5877 (class 0 OID 0)
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
-- TOC entry 5878 (class 0 OID 0)
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
-- TOC entry 5879 (class 0 OID 0)
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
-- TOC entry 5880 (class 0 OID 0)
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
-- TOC entry 5881 (class 0 OID 0)
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
-- TOC entry 5882 (class 0 OID 0)
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
-- TOC entry 5883 (class 0 OID 0)
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
-- TOC entry 5884 (class 0 OID 0)
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
-- TOC entry 5885 (class 0 OID 0)
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
-- TOC entry 5886 (class 0 OID 0)
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
-- TOC entry 5887 (class 0 OID 0)
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
-- TOC entry 5888 (class 0 OID 0)
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
-- TOC entry 5889 (class 0 OID 0)
-- Dependencies: 286
-- Name: wallets_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.wallets_id_seq OWNED BY public.wallets.id;


--
-- TOC entry 5251 (class 2604 OID 18295)
-- Name: cart_items id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cart_items ALTER COLUMN id SET DEFAULT nextval('public.cart_items_id_seq'::regclass);


--
-- TOC entry 5248 (class 2604 OID 18285)
-- Name: carts id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.carts ALTER COLUMN id SET DEFAULT nextval('public.carts_id_seq'::regclass);


--
-- TOC entry 5221 (class 2604 OID 17788)
-- Name: categories id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.categories ALTER COLUMN id SET DEFAULT nextval('public.categories_id_seq'::regclass);


--
-- TOC entry 5149 (class 2604 OID 17077)
-- Name: chapters id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.chapters ALTER COLUMN id SET DEFAULT nextval('public.chapters_id_seq'::regclass);


--
-- TOC entry 5167 (class 2604 OID 17246)
-- Name: completed_lessons_count id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.completed_lessons_count ALTER COLUMN id SET DEFAULT nextval('public.completed_lessons_count_id_seq'::regclass);


--
-- TOC entry 5219 (class 2604 OID 17699)
-- Name: contest_participants id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.contest_participants ALTER COLUMN id SET DEFAULT nextval('public.contest_participants_id_seq'::regclass);


--
-- TOC entry 5218 (class 2604 OID 17670)
-- Name: contest_problems id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.contest_problems ALTER COLUMN id SET DEFAULT nextval('public.contest_problems_id_seq'::regclass);


--
-- TOC entry 5198 (class 2604 OID 17470)
-- Name: contests id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.contests ALTER COLUMN id SET DEFAULT nextval('public.contests_id_seq'::regclass);


--
-- TOC entry 5215 (class 2604 OID 17640)
-- Name: course_reviews id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.course_reviews ALTER COLUMN id SET DEFAULT nextval('public.course_reviews_id_seq'::regclass);


--
-- TOC entry 5136 (class 2604 OID 17055)
-- Name: courses id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.courses ALTER COLUMN id SET DEFAULT nextval('public.courses_id_seq'::regclass);


--
-- TOC entry 5162 (class 2604 OID 17185)
-- Name: enrollments id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.enrollments ALTER COLUMN id SET DEFAULT nextval('public.enrollments_id_seq'::regclass);


--
-- TOC entry 5206 (class 2604 OID 17538)
-- Name: file_assignments id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.file_assignments ALTER COLUMN id SET DEFAULT nextval('public.file_assignments_id_seq'::regclass);


--
-- TOC entry 5209 (class 2604 OID 17566)
-- Name: file_submissions id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.file_submissions ALTER COLUMN id SET DEFAULT nextval('public.file_submissions_id_seq'::regclass);


--
-- TOC entry 5128 (class 2604 OID 16993)
-- Name: invalidated_tokens id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.invalidated_tokens ALTER COLUMN id SET DEFAULT nextval('public.invalidated_tokens_id_seq'::regclass);


--
-- TOC entry 5212 (class 2604 OID 17606)
-- Name: lesson_comments id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.lesson_comments ALTER COLUMN id SET DEFAULT nextval('public.lesson_comments_id_seq'::regclass);


--
-- TOC entry 5260 (class 2604 OID 18393)
-- Name: lesson_problems id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.lesson_problems ALTER COLUMN id SET DEFAULT nextval('public.lesson_problems_id_seq'::regclass);


--
-- TOC entry 5165 (class 2604 OID 17216)
-- Name: lesson_progress id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.lesson_progress ALTER COLUMN id SET DEFAULT nextval('public.lesson_progress_id_seq'::regclass);


--
-- TOC entry 5152 (class 2604 OID 17097)
-- Name: lessons id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.lessons ALTER COLUMN id SET DEFAULT nextval('public.lessons_id_seq'::regclass);


--
-- TOC entry 5181 (class 2604 OID 17374)
-- Name: online_judge_problems id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.online_judge_problems ALTER COLUMN id SET DEFAULT nextval('public.online_judge_problems_id_seq'::regclass);


--
-- TOC entry 5225 (class 2604 OID 17961)
-- Name: online_judge_submission_details id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.online_judge_submission_details ALTER COLUMN id SET DEFAULT nextval('public.online_judge_submission_details_id_seq'::regclass);


--
-- TOC entry 5203 (class 2604 OID 17497)
-- Name: online_judge_submissions id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.online_judge_submissions ALTER COLUMN id SET DEFAULT nextval('public.online_judge_submissions_id_seq'::regclass);


--
-- TOC entry 5246 (class 2604 OID 18221)
-- Name: order_items id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_items ALTER COLUMN id SET DEFAULT nextval('public.order_items_id_seq'::regclass);


--
-- TOC entry 5241 (class 2604 OID 18199)
-- Name: orders id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orders ALTER COLUMN id SET DEFAULT nextval('public.orders_id_seq'::regclass);


--
-- TOC entry 5233 (class 2604 OID 18136)
-- Name: payment_transactions id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.payment_transactions ALTER COLUMN id SET DEFAULT nextval('public.payment_transactions_id_seq'::regclass);


--
-- TOC entry 5127 (class 2604 OID 16947)
-- Name: permissions id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.permissions ALTER COLUMN id SET DEFAULT nextval('public.permissions_id_seq'::regclass);


--
-- TOC entry 5195 (class 2604 OID 17424)
-- Name: problem_tag_mappings id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.problem_tag_mappings ALTER COLUMN id SET DEFAULT nextval('public.problem_tag_mappings_id_seq'::regclass);


--
-- TOC entry 5192 (class 2604 OID 17406)
-- Name: problem_tags id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.problem_tags ALTER COLUMN id SET DEFAULT nextval('public.problem_tags_id_seq'::regclass);


--
-- TOC entry 5196 (class 2604 OID 17446)
-- Name: problem_testcases id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.problem_testcases ALTER COLUMN id SET DEFAULT nextval('public.problem_testcases_id_seq'::regclass);


--
-- TOC entry 5224 (class 2604 OID 17874)
-- Name: quiz_attempt_answers id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.quiz_attempt_answers ALTER COLUMN id SET DEFAULT nextval('public.quiz_attempt_answers_id_seq'::regclass);


--
-- TOC entry 5177 (class 2604 OID 17346)
-- Name: quiz_attempts id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.quiz_attempts ALTER COLUMN id SET DEFAULT nextval('public.quiz_attempts_id_seq'::regclass);


--
-- TOC entry 5175 (class 2604 OID 17325)
-- Name: quiz_options id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.quiz_options ALTER COLUMN id SET DEFAULT nextval('public.quiz_options_id_seq'::regclass);


--
-- TOC entry 5174 (class 2604 OID 17303)
-- Name: quiz_questions id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.quiz_questions ALTER COLUMN id SET DEFAULT nextval('public.quiz_questions_id_seq'::regclass);


--
-- TOC entry 5170 (class 2604 OID 17273)
-- Name: quizzes id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.quizzes ALTER COLUMN id SET DEFAULT nextval('public.quizzes_id_seq'::regclass);


--
-- TOC entry 5130 (class 2604 OID 17013)
-- Name: refresh_tokens id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.refresh_tokens ALTER COLUMN id SET DEFAULT nextval('public.refresh_tokens_id_seq'::regclass);


--
-- TOC entry 5126 (class 2604 OID 16935)
-- Name: roles id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.roles ALTER COLUMN id SET DEFAULT nextval('public.roles_id_seq'::regclass);


--
-- TOC entry 5160 (class 2604 OID 17128)
-- Name: teacher_course_assignments id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.teacher_course_assignments ALTER COLUMN id SET DEFAULT nextval('public.teacher_course_assignments_id_seq'::regclass);


--
-- TOC entry 5132 (class 2604 OID 17033)
-- Name: teachers id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.teachers ALTER COLUMN id SET DEFAULT nextval('public.teachers_id_seq'::regclass);


--
-- TOC entry 5122 (class 2604 OID 16910)
-- Name: users id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- TOC entry 5237 (class 2604 OID 18150)
-- Name: wallet_transactions id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.wallet_transactions ALTER COLUMN id SET DEFAULT nextval('public.wallet_transactions_id_seq'::regclass);


--
-- TOC entry 5228 (class 2604 OID 18116)
-- Name: wallets id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.wallets ALTER COLUMN id SET DEFAULT nextval('public.wallets_id_seq'::regclass);


--
-- TOC entry 5502 (class 2606 OID 18299)
-- Name: cart_items cart_items_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cart_items
    ADD CONSTRAINT cart_items_pkey PRIMARY KEY (id);


--
-- TOC entry 5498 (class 2606 OID 18297)
-- Name: carts carts_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.carts
    ADD CONSTRAINT carts_pkey PRIMARY KEY (id);


--
-- TOC entry 5459 (class 2606 OID 17801)
-- Name: categories categories_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.categories
    ADD CONSTRAINT categories_name_key UNIQUE (name);


--
-- TOC entry 5461 (class 2606 OID 17799)
-- Name: categories categories_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.categories
    ADD CONSTRAINT categories_pkey PRIMARY KEY (id);


--
-- TOC entry 5463 (class 2606 OID 17803)
-- Name: categories categories_slug_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.categories
    ADD CONSTRAINT categories_slug_key UNIQUE (slug);


--
-- TOC entry 5347 (class 2606 OID 17085)
-- Name: chapters chapters_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.chapters
    ADD CONSTRAINT chapters_pkey PRIMARY KEY (id);


--
-- TOC entry 5374 (class 2606 OID 17256)
-- Name: completed_lessons_count completed_lessons_count_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.completed_lessons_count
    ADD CONSTRAINT completed_lessons_count_pkey PRIMARY KEY (id);


--
-- TOC entry 5454 (class 2606 OID 17706)
-- Name: contest_participants contest_participants_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.contest_participants
    ADD CONSTRAINT contest_participants_pkey PRIMARY KEY (id);


--
-- TOC entry 5511 (class 2606 OID 18367)
-- Name: contest_problem_attempts contest_problem_attempts_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.contest_problem_attempts
    ADD CONSTRAINT contest_problem_attempts_pkey PRIMARY KEY (id);


--
-- TOC entry 5447 (class 2606 OID 17680)
-- Name: contest_problems contest_problems_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.contest_problems
    ADD CONSTRAINT contest_problems_pkey PRIMARY KEY (id);


--
-- TOC entry 5506 (class 2606 OID 18335)
-- Name: contest_rankings contest_rankings_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.contest_rankings
    ADD CONSTRAINT contest_rankings_pkey PRIMARY KEY (id);


--
-- TOC entry 5413 (class 2606 OID 17487)
-- Name: contests contests_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.contests
    ADD CONSTRAINT contests_pkey PRIMARY KEY (id);


--
-- TOC entry 5465 (class 2606 OID 17810)
-- Name: course_category_mappings course_category_mappings_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.course_category_mappings
    ADD CONSTRAINT course_category_mappings_pkey PRIMARY KEY (course_id, category_id);


--
-- TOC entry 5442 (class 2606 OID 17653)
-- Name: course_reviews course_reviews_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.course_reviews
    ADD CONSTRAINT course_reviews_pkey PRIMARY KEY (id);


--
-- TOC entry 5342 (class 2606 OID 17072)
-- Name: courses courses_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.courses
    ADD CONSTRAINT courses_pkey PRIMARY KEY (id);


--
-- TOC entry 5363 (class 2606 OID 17194)
-- Name: enrollments enrollments_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.enrollments
    ADD CONSTRAINT enrollments_pkey PRIMARY KEY (id);


--
-- TOC entry 5426 (class 2606 OID 17551)
-- Name: file_assignments file_assignments_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.file_assignments
    ADD CONSTRAINT file_assignments_pkey PRIMARY KEY (id);


--
-- TOC entry 5430 (class 2606 OID 17584)
-- Name: file_submissions file_submissions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.file_submissions
    ADD CONSTRAINT file_submissions_pkey PRIMARY KEY (id);


--
-- TOC entry 5328 (class 2606 OID 17001)
-- Name: invalidated_tokens invalidated_tokens_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.invalidated_tokens
    ADD CONSTRAINT invalidated_tokens_pkey PRIMARY KEY (id);


--
-- TOC entry 5330 (class 2606 OID 17003)
-- Name: invalidated_tokens invalidated_tokens_token_jti_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.invalidated_tokens
    ADD CONSTRAINT invalidated_tokens_token_jti_key UNIQUE (token_jti);


--
-- TOC entry 5440 (class 2606 OID 17620)
-- Name: lesson_comments lesson_comments_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.lesson_comments
    ADD CONSTRAINT lesson_comments_pkey PRIMARY KEY (id);


--
-- TOC entry 5516 (class 2606 OID 18400)
-- Name: lesson_problems lesson_problems_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.lesson_problems
    ADD CONSTRAINT lesson_problems_pkey PRIMARY KEY (id);


--
-- TOC entry 5370 (class 2606 OID 17224)
-- Name: lesson_progress lesson_progress_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.lesson_progress
    ADD CONSTRAINT lesson_progress_pkey PRIMARY KEY (id);


--
-- TOC entry 5353 (class 2606 OID 17116)
-- Name: lessons lessons_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.lessons
    ADD CONSTRAINT lessons_pkey PRIMARY KEY (id);


--
-- TOC entry 5395 (class 2606 OID 17391)
-- Name: online_judge_problems online_judge_problems_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.online_judge_problems
    ADD CONSTRAINT online_judge_problems_pkey PRIMARY KEY (id);


--
-- TOC entry 5473 (class 2606 OID 17963)
-- Name: online_judge_submission_details online_judge_submission_details_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.online_judge_submission_details
    ADD CONSTRAINT online_judge_submission_details_pkey PRIMARY KEY (id);


--
-- TOC entry 5424 (class 2606 OID 17513)
-- Name: online_judge_submissions online_judge_submissions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.online_judge_submissions
    ADD CONSTRAINT online_judge_submissions_pkey PRIMARY KEY (id);


--
-- TOC entry 5496 (class 2606 OID 18228)
-- Name: order_items order_items_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_items
    ADD CONSTRAINT order_items_pkey PRIMARY KEY (id);


--
-- TOC entry 5492 (class 2606 OID 18211)
-- Name: orders orders_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_pkey PRIMARY KEY (id);


--
-- TOC entry 5482 (class 2606 OID 18138)
-- Name: payment_transactions payment_transactions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.payment_transactions
    ADD CONSTRAINT payment_transactions_pkey PRIMARY KEY (id);


--
-- TOC entry 5484 (class 2606 OID 18075)
-- Name: payment_transactions payment_transactions_transaction_code_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.payment_transactions
    ADD CONSTRAINT payment_transactions_transaction_code_key UNIQUE (transaction_code);


--
-- TOC entry 5319 (class 2606 OID 16954)
-- Name: permissions permissions_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.permissions
    ADD CONSTRAINT permissions_name_key UNIQUE (name);


--
-- TOC entry 5321 (class 2606 OID 16952)
-- Name: permissions permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.permissions
    ADD CONSTRAINT permissions_pkey PRIMARY KEY (id);


--
-- TOC entry 5402 (class 2606 OID 17429)
-- Name: problem_tag_mappings problem_tag_mappings_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.problem_tag_mappings
    ADD CONSTRAINT problem_tag_mappings_pkey PRIMARY KEY (id);


--
-- TOC entry 5397 (class 2606 OID 17417)
-- Name: problem_tags problem_tags_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.problem_tags
    ADD CONSTRAINT problem_tags_pkey PRIMARY KEY (id);


--
-- TOC entry 5399 (class 2606 OID 17419)
-- Name: problem_tags problem_tags_slug_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.problem_tags
    ADD CONSTRAINT problem_tags_slug_key UNIQUE (slug);


--
-- TOC entry 5407 (class 2606 OID 17458)
-- Name: problem_testcases problem_testcases_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.problem_testcases
    ADD CONSTRAINT problem_testcases_pkey PRIMARY KEY (id);


--
-- TOC entry 5409 (class 2606 OID 18388)
-- Name: problem_testcases problem_testcases_token_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.problem_testcases
    ADD CONSTRAINT problem_testcases_token_key UNIQUE (token);


--
-- TOC entry 5468 (class 2606 OID 17879)
-- Name: quiz_attempt_answers quiz_attempt_answers_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.quiz_attempt_answers
    ADD CONSTRAINT quiz_attempt_answers_pkey PRIMARY KEY (id);


--
-- TOC entry 5391 (class 2606 OID 17359)
-- Name: quiz_attempts quiz_attempts_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.quiz_attempts
    ADD CONSTRAINT quiz_attempts_pkey PRIMARY KEY (id);


--
-- TOC entry 5387 (class 2606 OID 17336)
-- Name: quiz_options quiz_options_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.quiz_options
    ADD CONSTRAINT quiz_options_pkey PRIMARY KEY (id);


--
-- TOC entry 5382 (class 2606 OID 17313)
-- Name: quiz_questions quiz_questions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.quiz_questions
    ADD CONSTRAINT quiz_questions_pkey PRIMARY KEY (id);


--
-- TOC entry 5378 (class 2606 OID 17286)
-- Name: quizzes quizzes_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.quizzes
    ADD CONSTRAINT quizzes_pkey PRIMARY KEY (id);


--
-- TOC entry 5334 (class 2606 OID 17021)
-- Name: refresh_tokens refresh_tokens_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.refresh_tokens
    ADD CONSTRAINT refresh_tokens_pkey PRIMARY KEY (id);


--
-- TOC entry 5336 (class 2606 OID 17023)
-- Name: refresh_tokens refresh_tokens_token_hash_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.refresh_tokens
    ADD CONSTRAINT refresh_tokens_token_hash_key UNIQUE (token_hash);


--
-- TOC entry 5325 (class 2606 OID 16978)
-- Name: role_permissions role_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.role_permissions
    ADD CONSTRAINT role_permissions_pkey PRIMARY KEY (role_id, permission_id);


--
-- TOC entry 5315 (class 2606 OID 16942)
-- Name: roles roles_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.roles
    ADD CONSTRAINT roles_name_key UNIQUE (name);


--
-- TOC entry 5317 (class 2606 OID 16940)
-- Name: roles roles_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.roles
    ADD CONSTRAINT roles_pkey PRIMARY KEY (id);


--
-- TOC entry 5359 (class 2606 OID 17136)
-- Name: teacher_course_assignments teacher_course_assignments_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.teacher_course_assignments
    ADD CONSTRAINT teacher_course_assignments_pkey PRIMARY KEY (id);


--
-- TOC entry 5338 (class 2606 OID 17043)
-- Name: teachers teachers_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.teachers
    ADD CONSTRAINT teachers_pkey PRIMARY KEY (id);


--
-- TOC entry 5340 (class 2606 OID 17045)
-- Name: teachers teachers_user_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.teachers
    ADD CONSTRAINT teachers_user_id_key UNIQUE (user_id);


--
-- TOC entry 5470 (class 2606 OID 17881)
-- Name: quiz_attempt_answers unique_attempt_question; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.quiz_attempt_answers
    ADD CONSTRAINT unique_attempt_question UNIQUE (attempt_id, question_id);


--
-- TOC entry 5504 (class 2606 OID 18303)
-- Name: cart_items uq_cart_items_cart_course; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cart_items
    ADD CONSTRAINT uq_cart_items_cart_course UNIQUE (cart_id, course_id);


--
-- TOC entry 5500 (class 2606 OID 18301)
-- Name: carts uq_carts_user; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.carts
    ADD CONSTRAINT uq_carts_user UNIQUE (user_id);


--
-- TOC entry 5350 (class 2606 OID 17087)
-- Name: chapters uq_chapters_course_order; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.chapters
    ADD CONSTRAINT uq_chapters_course_order UNIQUE (course_id, order_index);


--
-- TOC entry 5376 (class 2606 OID 17258)
-- Name: completed_lessons_count uq_completed_lessons_count_user_course; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.completed_lessons_count
    ADD CONSTRAINT uq_completed_lessons_count_user_course UNIQUE (user_id, course_id);


--
-- TOC entry 5457 (class 2606 OID 17708)
-- Name: contest_participants uq_contest_participants_contest_user; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.contest_participants
    ADD CONSTRAINT uq_contest_participants_contest_user UNIQUE (contest_id, user_id);


--
-- TOC entry 5514 (class 2606 OID 18369)
-- Name: contest_problem_attempts uq_contest_problem_attempts; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.contest_problem_attempts
    ADD CONSTRAINT uq_contest_problem_attempts UNIQUE (contest_id, user_id, problem_id);


--
-- TOC entry 5450 (class 2606 OID 17684)
-- Name: contest_problems uq_contest_problems_contest_order; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.contest_problems
    ADD CONSTRAINT uq_contest_problems_contest_order UNIQUE (contest_id, order_index);


--
-- TOC entry 5452 (class 2606 OID 17682)
-- Name: contest_problems uq_contest_problems_contest_problem; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.contest_problems
    ADD CONSTRAINT uq_contest_problems_contest_problem UNIQUE (contest_id, problem_id);


--
-- TOC entry 5509 (class 2606 OID 18337)
-- Name: contest_rankings uq_contest_rankings_contest_user; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.contest_rankings
    ADD CONSTRAINT uq_contest_rankings_contest_user UNIQUE (contest_id, user_id);


--
-- TOC entry 5445 (class 2606 OID 17655)
-- Name: course_reviews uq_course_reviews_course_user; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.course_reviews
    ADD CONSTRAINT uq_course_reviews_course_user UNIQUE (course_id, user_id);


--
-- TOC entry 5366 (class 2606 OID 17196)
-- Name: enrollments uq_enrollments_user_course; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.enrollments
    ADD CONSTRAINT uq_enrollments_user_course UNIQUE (user_id, course_id);


--
-- TOC entry 5435 (class 2606 OID 17586)
-- Name: file_submissions uq_file_submissions_assignment_user_attempt; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.file_submissions
    ADD CONSTRAINT uq_file_submissions_assignment_user_attempt UNIQUE (file_assignment_id, user_id, attempt_no);


--
-- TOC entry 5518 (class 2606 OID 18402)
-- Name: lesson_problems uq_lesson_problem; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.lesson_problems
    ADD CONSTRAINT uq_lesson_problem UNIQUE (lesson_id, problem_id);


--
-- TOC entry 5372 (class 2606 OID 17226)
-- Name: lesson_progress uq_lesson_progress_user_lesson; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.lesson_progress
    ADD CONSTRAINT uq_lesson_progress_user_lesson UNIQUE (user_id, lesson_id);


--
-- TOC entry 5355 (class 2606 OID 17118)
-- Name: lessons uq_lessons_chapter_order; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.lessons
    ADD CONSTRAINT uq_lessons_chapter_order UNIQUE (chapter_id, order_index);


--
-- TOC entry 5404 (class 2606 OID 17431)
-- Name: problem_tag_mappings uq_problem_tag_mappings_problem_tag; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.problem_tag_mappings
    ADD CONSTRAINT uq_problem_tag_mappings_problem_tag UNIQUE (problem_id, tag_id);


--
-- TOC entry 5411 (class 2606 OID 17460)
-- Name: problem_testcases uq_problem_testcases_problem_order; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.problem_testcases
    ADD CONSTRAINT uq_problem_testcases_problem_order UNIQUE (problem_id, order_index);


--
-- TOC entry 5384 (class 2606 OID 17902)
-- Name: quiz_questions uq_quiz_questions_quiz_order; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.quiz_questions
    ADD CONSTRAINT uq_quiz_questions_quiz_order UNIQUE (quiz_id, order_index) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 5361 (class 2606 OID 17138)
-- Name: teacher_course_assignments uq_teacher_course_assignments_teacher_course; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.teacher_course_assignments
    ADD CONSTRAINT uq_teacher_course_assignments_teacher_course UNIQUE (teacher_id, course_id);


--
-- TOC entry 5323 (class 2606 OID 16961)
-- Name: user_roles user_roles_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_roles
    ADD CONSTRAINT user_roles_pkey PRIMARY KEY (user_id, role_id);


--
-- TOC entry 5309 (class 2606 OID 16930)
-- Name: users users_email_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key UNIQUE (email);


--
-- TOC entry 5311 (class 2606 OID 16926)
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- TOC entry 5313 (class 2606 OID 16928)
-- Name: users users_username_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_username_key UNIQUE (username);


--
-- TOC entry 5488 (class 2606 OID 18152)
-- Name: wallet_transactions wallet_transactions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.wallet_transactions
    ADD CONSTRAINT wallet_transactions_pkey PRIMARY KEY (id);


--
-- TOC entry 5476 (class 2606 OID 18118)
-- Name: wallets wallets_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.wallets
    ADD CONSTRAINT wallets_pkey PRIMARY KEY (id);


--
-- TOC entry 5478 (class 2606 OID 18048)
-- Name: wallets wallets_user_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.wallets
    ADD CONSTRAINT wallets_user_id_key UNIQUE (user_id);


--
-- TOC entry 5348 (class 1259 OID 17724)
-- Name: idx_chapters_course_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_chapters_course_id ON public.chapters USING btree (course_id);


--
-- TOC entry 5455 (class 1259 OID 17761)
-- Name: idx_contest_participants_user_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_contest_participants_user_id ON public.contest_participants USING btree (user_id);


--
-- TOC entry 5512 (class 1259 OID 18386)
-- Name: idx_contest_problem_attempts_lookup; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_contest_problem_attempts_lookup ON public.contest_problem_attempts USING btree (contest_id, user_id);


--
-- TOC entry 5448 (class 1259 OID 17760)
-- Name: idx_contest_problems_problem_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_contest_problems_problem_id ON public.contest_problems USING btree (problem_id);


--
-- TOC entry 5507 (class 1259 OID 18385)
-- Name: idx_contest_rankings_contest; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_contest_rankings_contest ON public.contest_rankings USING btree (contest_id);


--
-- TOC entry 5414 (class 1259 OID 17759)
-- Name: idx_contests_created_by_teacher_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_contests_created_by_teacher_id ON public.contests USING btree (created_by_teacher_id);


--
-- TOC entry 5415 (class 1259 OID 17758)
-- Name: idx_contests_status_time; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_contests_status_time ON public.contests USING btree (status, start_time, end_time);


--
-- TOC entry 5466 (class 1259 OID 17821)
-- Name: idx_course_category_mapping_category_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_course_category_mapping_category_id ON public.course_category_mappings USING btree (category_id);


--
-- TOC entry 5443 (class 1259 OID 17757)
-- Name: idx_course_reviews_user_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_course_reviews_user_id ON public.course_reviews USING btree (user_id);


--
-- TOC entry 5343 (class 1259 OID 17828)
-- Name: idx_courses_average_rating; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_courses_average_rating ON public.courses USING btree (average_rating DESC);


--
-- TOC entry 5344 (class 1259 OID 17723)
-- Name: idx_courses_status; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_courses_status ON public.courses USING btree (status);


--
-- TOC entry 5345 (class 1259 OID 17783)
-- Name: idx_courses_total_enrolled; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_courses_total_enrolled ON public.courses USING btree (total_enrolled DESC);


--
-- TOC entry 5364 (class 1259 OID 17731)
-- Name: idx_enrollments_course_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_enrollments_course_id ON public.enrollments USING btree (course_id);


--
-- TOC entry 5427 (class 1259 OID 17750)
-- Name: idx_file_assignments_created_by_teacher_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_file_assignments_created_by_teacher_id ON public.file_assignments USING btree (created_by_teacher_id);


--
-- TOC entry 5428 (class 1259 OID 17749)
-- Name: idx_file_assignments_lesson_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_file_assignments_lesson_id ON public.file_assignments USING btree (lesson_id);


--
-- TOC entry 5431 (class 1259 OID 17753)
-- Name: idx_file_submissions_graded_by_teacher_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_file_submissions_graded_by_teacher_id ON public.file_submissions USING btree (graded_by_teacher_id);


--
-- TOC entry 5432 (class 1259 OID 17752)
-- Name: idx_file_submissions_status; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_file_submissions_status ON public.file_submissions USING btree (status);


--
-- TOC entry 5433 (class 1259 OID 17751)
-- Name: idx_file_submissions_user_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_file_submissions_user_id ON public.file_submissions USING btree (user_id);


--
-- TOC entry 5326 (class 1259 OID 17720)
-- Name: idx_invalidated_tokens_expiry_time; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_invalidated_tokens_expiry_time ON public.invalidated_tokens USING btree (expiry_time);


--
-- TOC entry 5436 (class 1259 OID 17754)
-- Name: idx_lesson_comments_lesson_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_lesson_comments_lesson_id ON public.lesson_comments USING btree (lesson_id);


--
-- TOC entry 5437 (class 1259 OID 17756)
-- Name: idx_lesson_comments_lesson_parent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_lesson_comments_lesson_parent ON public.lesson_comments USING btree (lesson_id, parent_comment_id);


--
-- TOC entry 5438 (class 1259 OID 17755)
-- Name: idx_lesson_comments_parent_comment_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_lesson_comments_parent_comment_id ON public.lesson_comments USING btree (parent_comment_id);


--
-- TOC entry 5367 (class 1259 OID 17733)
-- Name: idx_lesson_progress_course_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_lesson_progress_course_id ON public.lesson_progress USING btree (course_id);


--
-- TOC entry 5368 (class 1259 OID 17732)
-- Name: idx_lesson_progress_user_course; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_lesson_progress_user_course ON public.lesson_progress USING btree (user_id, course_id);


--
-- TOC entry 5351 (class 1259 OID 17725)
-- Name: idx_lessons_chapter_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_lessons_chapter_id ON public.lessons USING btree (chapter_id);


--
-- TOC entry 5392 (class 1259 OID 17739)
-- Name: idx_online_judge_problems_created_by_teacher_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_online_judge_problems_created_by_teacher_id ON public.online_judge_problems USING btree (created_by_teacher_id);


--
-- TOC entry 5393 (class 1259 OID 17740)
-- Name: idx_online_judge_problems_scope_difficulty; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_online_judge_problems_scope_difficulty ON public.online_judge_problems USING btree (problem_scope, difficulty);


--
-- TOC entry 5416 (class 1259 OID 17743)
-- Name: idx_online_judge_submissions_contest_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_online_judge_submissions_contest_id ON public.online_judge_submissions USING btree (contest_id);


--
-- TOC entry 5417 (class 1259 OID 17744)
-- Name: idx_online_judge_submissions_contest_user_problem; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_online_judge_submissions_contest_user_problem ON public.online_judge_submissions USING btree (contest_id, user_id, problem_id);


--
-- TOC entry 5418 (class 1259 OID 17745)
-- Name: idx_online_judge_submissions_lesson_user_problem; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_online_judge_submissions_lesson_user_problem ON public.online_judge_submissions USING btree (lesson_id, user_id, problem_id);


--
-- TOC entry 5419 (class 1259 OID 17747)
-- Name: idx_online_judge_submissions_problem_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_online_judge_submissions_problem_id ON public.online_judge_submissions USING btree (problem_id);


--
-- TOC entry 5420 (class 1259 OID 17748)
-- Name: idx_online_judge_submissions_submitted_at; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_online_judge_submissions_submitted_at ON public.online_judge_submissions USING btree (submitted_at);


--
-- TOC entry 5421 (class 1259 OID 17746)
-- Name: idx_online_judge_submissions_user_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_online_judge_submissions_user_id ON public.online_judge_submissions USING btree (user_id);


--
-- TOC entry 5493 (class 1259 OID 18247)
-- Name: idx_order_items_course_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_order_items_course_id ON public.order_items USING btree (course_id);


--
-- TOC entry 5494 (class 1259 OID 18246)
-- Name: idx_order_items_order_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_order_items_order_id ON public.order_items USING btree (order_id);


--
-- TOC entry 5489 (class 1259 OID 18245)
-- Name: idx_orders_status; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_orders_status ON public.orders USING btree (status);


--
-- TOC entry 5490 (class 1259 OID 18244)
-- Name: idx_orders_user_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_orders_user_id ON public.orders USING btree (user_id);


--
-- TOC entry 5479 (class 1259 OID 18112)
-- Name: idx_payment_tx_code; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_payment_tx_code ON public.payment_transactions USING btree (transaction_code);


--
-- TOC entry 5480 (class 1259 OID 18167)
-- Name: idx_payment_tx_wallet_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_payment_tx_wallet_id ON public.payment_transactions USING btree (wallet_id);


--
-- TOC entry 5400 (class 1259 OID 17741)
-- Name: idx_problem_tag_mappings_tag_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_problem_tag_mappings_tag_id ON public.problem_tag_mappings USING btree (tag_id);


--
-- TOC entry 5405 (class 1259 OID 17742)
-- Name: idx_problem_testcases_problem_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_problem_testcases_problem_id ON public.problem_testcases USING btree (problem_id);


--
-- TOC entry 5388 (class 1259 OID 17737)
-- Name: idx_quiz_attempts_quiz_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_quiz_attempts_quiz_id ON public.quiz_attempts USING btree (quiz_id);


--
-- TOC entry 5389 (class 1259 OID 17736)
-- Name: idx_quiz_attempts_user_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_quiz_attempts_user_id ON public.quiz_attempts USING btree (user_id);


--
-- TOC entry 5385 (class 1259 OID 17735)
-- Name: idx_quiz_options_question_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_quiz_options_question_id ON public.quiz_options USING btree (question_id);


--
-- TOC entry 5380 (class 1259 OID 17734)
-- Name: idx_quiz_questions_quiz_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_quiz_questions_quiz_id ON public.quiz_questions USING btree (quiz_id);


--
-- TOC entry 5331 (class 1259 OID 17722)
-- Name: idx_refresh_tokens_expires_at; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_refresh_tokens_expires_at ON public.refresh_tokens USING btree (expires_at);


--
-- TOC entry 5332 (class 1259 OID 17721)
-- Name: idx_refresh_tokens_user_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_refresh_tokens_user_id ON public.refresh_tokens USING btree (user_id);


--
-- TOC entry 5471 (class 1259 OID 17953)
-- Name: idx_submission_details_submission_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_submission_details_submission_id ON public.online_judge_submission_details USING btree (submission_id);


--
-- TOC entry 5422 (class 1259 OID 18265)
-- Name: idx_submission_user_verdict; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_submission_user_verdict ON public.online_judge_submissions USING btree (user_id, verdict, problem_id);


--
-- TOC entry 5356 (class 1259 OID 17727)
-- Name: idx_teacher_course_assignments_assigned_by_admin_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_teacher_course_assignments_assigned_by_admin_id ON public.teacher_course_assignments USING btree (assigned_by_admin_id);


--
-- TOC entry 5357 (class 1259 OID 17726)
-- Name: idx_teacher_course_assignments_course_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_teacher_course_assignments_course_id ON public.teacher_course_assignments USING btree (course_id);


--
-- TOC entry 5485 (class 1259 OID 18248)
-- Name: idx_wallet_transactions_order_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_wallet_transactions_order_id ON public.wallet_transactions USING btree (order_id);


--
-- TOC entry 5486 (class 1259 OID 18174)
-- Name: idx_wallet_tx_wallet_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_wallet_tx_wallet_id ON public.wallet_transactions USING btree (wallet_id);


--
-- TOC entry 5379 (class 1259 OID 17906)
-- Name: uq_quizzes_lesson_active; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX uq_quizzes_lesson_active ON public.quizzes USING btree (lesson_id) WHERE (is_deleted = false);


--
-- TOC entry 5474 (class 1259 OID 17952)
-- Name: uq_submission_details_token; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX uq_submission_details_token ON public.online_judge_submission_details USING btree (token);


--
-- TOC entry 5608 (class 2620 OID 18249)
-- Name: orders set_orders_updated_at; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER set_orders_updated_at BEFORE UPDATE ON public.orders FOR EACH ROW EXECUTE FUNCTION public.set_updated_at();


--
-- TOC entry 5604 (class 2620 OID 17822)
-- Name: categories trg_categories_set_updated_at; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER trg_categories_set_updated_at BEFORE UPDATE ON public.categories FOR EACH ROW EXECUTE FUNCTION public.set_updated_at();


--
-- TOC entry 5593 (class 2620 OID 17869)
-- Name: chapters trg_chapters_updated_at; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER trg_chapters_updated_at BEFORE UPDATE ON public.chapters FOR EACH ROW EXECUTE FUNCTION public.set_updated_at();


--
-- TOC entry 5595 (class 2620 OID 17766)
-- Name: completed_lessons_count trg_completed_lessons_count_set_updated_at; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER trg_completed_lessons_count_set_updated_at BEFORE UPDATE ON public.completed_lessons_count FOR EACH ROW EXECUTE FUNCTION public.set_updated_at();


--
-- TOC entry 5600 (class 2620 OID 17773)
-- Name: contests trg_contests_set_updated_at; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER trg_contests_set_updated_at BEFORE UPDATE ON public.contests FOR EACH ROW EXECUTE FUNCTION public.set_updated_at();


--
-- TOC entry 5603 (class 2620 OID 17772)
-- Name: course_reviews trg_course_reviews_set_updated_at; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER trg_course_reviews_set_updated_at BEFORE UPDATE ON public.course_reviews FOR EACH ROW EXECUTE FUNCTION public.set_updated_at();


--
-- TOC entry 5592 (class 2620 OID 17764)
-- Name: courses trg_courses_set_updated_at; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER trg_courses_set_updated_at BEFORE UPDATE ON public.courses FOR EACH ROW EXECUTE FUNCTION public.set_updated_at();


--
-- TOC entry 5601 (class 2620 OID 17770)
-- Name: file_assignments trg_file_assignments_set_updated_at; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER trg_file_assignments_set_updated_at BEFORE UPDATE ON public.file_assignments FOR EACH ROW EXECUTE FUNCTION public.set_updated_at();


--
-- TOC entry 5602 (class 2620 OID 17771)
-- Name: lesson_comments trg_lesson_comments_set_updated_at; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER trg_lesson_comments_set_updated_at BEFORE UPDATE ON public.lesson_comments FOR EACH ROW EXECUTE FUNCTION public.set_updated_at();


--
-- TOC entry 5594 (class 2620 OID 17765)
-- Name: lessons trg_lessons_set_updated_at; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER trg_lessons_set_updated_at BEFORE UPDATE ON public.lessons FOR EACH ROW EXECUTE FUNCTION public.set_updated_at();


--
-- TOC entry 5598 (class 2620 OID 17768)
-- Name: online_judge_problems trg_online_judge_problems_set_updated_at; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER trg_online_judge_problems_set_updated_at BEFORE UPDATE ON public.online_judge_problems FOR EACH ROW EXECUTE FUNCTION public.set_updated_at();


--
-- TOC entry 5606 (class 2620 OID 18114)
-- Name: payment_transactions trg_payment_tx_set_updated_at; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER trg_payment_tx_set_updated_at BEFORE UPDATE ON public.payment_transactions FOR EACH ROW EXECUTE FUNCTION public.set_updated_at();


--
-- TOC entry 5599 (class 2620 OID 17769)
-- Name: problem_tags trg_problem_tags_set_updated_at; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER trg_problem_tags_set_updated_at BEFORE UPDATE ON public.problem_tags FOR EACH ROW EXECUTE FUNCTION public.set_updated_at();


--
-- TOC entry 5596 (class 2620 OID 17767)
-- Name: quizzes trg_quizzes_set_updated_at; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER trg_quizzes_set_updated_at BEFORE UPDATE ON public.quizzes FOR EACH ROW EXECUTE FUNCTION public.set_updated_at();


--
-- TOC entry 5591 (class 2620 OID 17763)
-- Name: teachers trg_teachers_set_updated_at; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER trg_teachers_set_updated_at BEFORE UPDATE ON public.teachers FOR EACH ROW EXECUTE FUNCTION public.set_updated_at();


--
-- TOC entry 5590 (class 2620 OID 17762)
-- Name: users trg_users_set_updated_at; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER trg_users_set_updated_at BEFORE UPDATE ON public.users FOR EACH ROW EXECUTE FUNCTION public.set_updated_at();


--
-- TOC entry 5607 (class 2620 OID 18115)
-- Name: wallet_transactions trg_wallet_tx_set_updated_at; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER trg_wallet_tx_set_updated_at BEFORE UPDATE ON public.wallet_transactions FOR EACH ROW EXECUTE FUNCTION public.set_updated_at();


--
-- TOC entry 5605 (class 2620 OID 18113)
-- Name: wallets trg_wallets_set_updated_at; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER trg_wallets_set_updated_at BEFORE UPDATE ON public.wallets FOR EACH ROW EXECUTE FUNCTION public.set_updated_at();


--
-- TOC entry 5597 (class 2620 OID 17900)
-- Name: quiz_attempts trigger_quiz_attempts_updated_at; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER trigger_quiz_attempts_updated_at BEFORE UPDATE ON public.quiz_attempts FOR EACH ROW EXECUTE FUNCTION public.set_updated_at();


--
-- TOC entry 5581 (class 2606 OID 18309)
-- Name: cart_items fk_cart_items_cart; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cart_items
    ADD CONSTRAINT fk_cart_items_cart FOREIGN KEY (cart_id) REFERENCES public.carts(id) ON DELETE CASCADE;


--
-- TOC entry 5582 (class 2606 OID 18314)
-- Name: cart_items fk_cart_items_course; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cart_items
    ADD CONSTRAINT fk_cart_items_course FOREIGN KEY (course_id) REFERENCES public.courses(id) ON DELETE CASCADE;


--
-- TOC entry 5580 (class 2606 OID 18304)
-- Name: carts fk_carts_user; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.carts
    ADD CONSTRAINT fk_carts_user FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- TOC entry 5525 (class 2606 OID 17088)
-- Name: chapters fk_chapters_course; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.chapters
    ADD CONSTRAINT fk_chapters_course FOREIGN KEY (course_id) REFERENCES public.courses(id) ON DELETE CASCADE;


--
-- TOC entry 5535 (class 2606 OID 17264)
-- Name: completed_lessons_count fk_completed_lessons_count_course; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.completed_lessons_count
    ADD CONSTRAINT fk_completed_lessons_count_course FOREIGN KEY (course_id) REFERENCES public.courses(id) ON DELETE CASCADE;


--
-- TOC entry 5536 (class 2606 OID 17259)
-- Name: completed_lessons_count fk_completed_lessons_count_user; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.completed_lessons_count
    ADD CONSTRAINT fk_completed_lessons_count_user FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- TOC entry 5564 (class 2606 OID 17709)
-- Name: contest_participants fk_contest_participants_contest; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.contest_participants
    ADD CONSTRAINT fk_contest_participants_contest FOREIGN KEY (contest_id) REFERENCES public.contests(id) ON DELETE CASCADE;


--
-- TOC entry 5565 (class 2606 OID 17714)
-- Name: contest_participants fk_contest_participants_user; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.contest_participants
    ADD CONSTRAINT fk_contest_participants_user FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- TOC entry 5585 (class 2606 OID 18370)
-- Name: contest_problem_attempts fk_contest_problem_attempts_contest; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.contest_problem_attempts
    ADD CONSTRAINT fk_contest_problem_attempts_contest FOREIGN KEY (contest_id) REFERENCES public.contests(id) ON DELETE CASCADE;


--
-- TOC entry 5586 (class 2606 OID 18380)
-- Name: contest_problem_attempts fk_contest_problem_attempts_problem; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.contest_problem_attempts
    ADD CONSTRAINT fk_contest_problem_attempts_problem FOREIGN KEY (problem_id) REFERENCES public.online_judge_problems(id) ON DELETE CASCADE;


--
-- TOC entry 5587 (class 2606 OID 18375)
-- Name: contest_problem_attempts fk_contest_problem_attempts_user; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.contest_problem_attempts
    ADD CONSTRAINT fk_contest_problem_attempts_user FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- TOC entry 5562 (class 2606 OID 17685)
-- Name: contest_problems fk_contest_problems_contest; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.contest_problems
    ADD CONSTRAINT fk_contest_problems_contest FOREIGN KEY (contest_id) REFERENCES public.contests(id) ON DELETE CASCADE;


--
-- TOC entry 5563 (class 2606 OID 17690)
-- Name: contest_problems fk_contest_problems_problem; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.contest_problems
    ADD CONSTRAINT fk_contest_problems_problem FOREIGN KEY (problem_id) REFERENCES public.online_judge_problems(id) ON DELETE CASCADE;


--
-- TOC entry 5583 (class 2606 OID 18338)
-- Name: contest_rankings fk_contest_rankings_contest; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.contest_rankings
    ADD CONSTRAINT fk_contest_rankings_contest FOREIGN KEY (contest_id) REFERENCES public.contests(id) ON DELETE CASCADE;


--
-- TOC entry 5584 (class 2606 OID 18343)
-- Name: contest_rankings fk_contest_rankings_user; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.contest_rankings
    ADD CONSTRAINT fk_contest_rankings_user FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- TOC entry 5547 (class 2606 OID 17488)
-- Name: contests fk_contests_created_by_teacher; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.contests
    ADD CONSTRAINT fk_contests_created_by_teacher FOREIGN KEY (created_by_teacher_id) REFERENCES public.teachers(id);


--
-- TOC entry 5566 (class 2606 OID 17816)
-- Name: course_category_mappings fk_course_category_category; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.course_category_mappings
    ADD CONSTRAINT fk_course_category_category FOREIGN KEY (category_id) REFERENCES public.categories(id) ON DELETE CASCADE;


--
-- TOC entry 5567 (class 2606 OID 17811)
-- Name: course_category_mappings fk_course_category_course; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.course_category_mappings
    ADD CONSTRAINT fk_course_category_course FOREIGN KEY (course_id) REFERENCES public.courses(id) ON DELETE CASCADE;


--
-- TOC entry 5560 (class 2606 OID 17656)
-- Name: course_reviews fk_course_reviews_course; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.course_reviews
    ADD CONSTRAINT fk_course_reviews_course FOREIGN KEY (course_id) REFERENCES public.courses(id) ON DELETE CASCADE;


--
-- TOC entry 5561 (class 2606 OID 17661)
-- Name: course_reviews fk_course_reviews_user; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.course_reviews
    ADD CONSTRAINT fk_course_reviews_user FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- TOC entry 5530 (class 2606 OID 17202)
-- Name: enrollments fk_enrollments_course; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.enrollments
    ADD CONSTRAINT fk_enrollments_course FOREIGN KEY (course_id) REFERENCES public.courses(id) ON DELETE CASCADE;


--
-- TOC entry 5531 (class 2606 OID 17197)
-- Name: enrollments fk_enrollments_user; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.enrollments
    ADD CONSTRAINT fk_enrollments_user FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- TOC entry 5552 (class 2606 OID 17557)
-- Name: file_assignments fk_file_assignments_created_by_teacher; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.file_assignments
    ADD CONSTRAINT fk_file_assignments_created_by_teacher FOREIGN KEY (created_by_teacher_id) REFERENCES public.teachers(id);


--
-- TOC entry 5553 (class 2606 OID 17552)
-- Name: file_assignments fk_file_assignments_lesson; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.file_assignments
    ADD CONSTRAINT fk_file_assignments_lesson FOREIGN KEY (lesson_id) REFERENCES public.lessons(id) ON DELETE CASCADE;


--
-- TOC entry 5554 (class 2606 OID 17587)
-- Name: file_submissions fk_file_submissions_file_assignment; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.file_submissions
    ADD CONSTRAINT fk_file_submissions_file_assignment FOREIGN KEY (file_assignment_id) REFERENCES public.file_assignments(id) ON DELETE CASCADE;


--
-- TOC entry 5555 (class 2606 OID 17597)
-- Name: file_submissions fk_file_submissions_graded_by_teacher; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.file_submissions
    ADD CONSTRAINT fk_file_submissions_graded_by_teacher FOREIGN KEY (graded_by_teacher_id) REFERENCES public.teachers(id);


--
-- TOC entry 5556 (class 2606 OID 17592)
-- Name: file_submissions fk_file_submissions_user; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.file_submissions
    ADD CONSTRAINT fk_file_submissions_user FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- TOC entry 5557 (class 2606 OID 17621)
-- Name: lesson_comments fk_lesson_comments_lesson; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.lesson_comments
    ADD CONSTRAINT fk_lesson_comments_lesson FOREIGN KEY (lesson_id) REFERENCES public.lessons(id) ON DELETE CASCADE;


--
-- TOC entry 5558 (class 2606 OID 17631)
-- Name: lesson_comments fk_lesson_comments_parent; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.lesson_comments
    ADD CONSTRAINT fk_lesson_comments_parent FOREIGN KEY (parent_comment_id) REFERENCES public.lesson_comments(id) ON DELETE CASCADE;


--
-- TOC entry 5559 (class 2606 OID 17626)
-- Name: lesson_comments fk_lesson_comments_user; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.lesson_comments
    ADD CONSTRAINT fk_lesson_comments_user FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- TOC entry 5588 (class 2606 OID 18403)
-- Name: lesson_problems fk_lesson_problems_lesson; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.lesson_problems
    ADD CONSTRAINT fk_lesson_problems_lesson FOREIGN KEY (lesson_id) REFERENCES public.lessons(id) ON DELETE CASCADE;


--
-- TOC entry 5589 (class 2606 OID 18408)
-- Name: lesson_problems fk_lesson_problems_problem; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.lesson_problems
    ADD CONSTRAINT fk_lesson_problems_problem FOREIGN KEY (problem_id) REFERENCES public.online_judge_problems(id) ON DELETE CASCADE;


--
-- TOC entry 5532 (class 2606 OID 17237)
-- Name: lesson_progress fk_lesson_progress_course; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.lesson_progress
    ADD CONSTRAINT fk_lesson_progress_course FOREIGN KEY (course_id) REFERENCES public.courses(id) ON DELETE CASCADE;


--
-- TOC entry 5533 (class 2606 OID 17232)
-- Name: lesson_progress fk_lesson_progress_lesson; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.lesson_progress
    ADD CONSTRAINT fk_lesson_progress_lesson FOREIGN KEY (lesson_id) REFERENCES public.lessons(id) ON DELETE CASCADE;


--
-- TOC entry 5534 (class 2606 OID 17227)
-- Name: lesson_progress fk_lesson_progress_user; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.lesson_progress
    ADD CONSTRAINT fk_lesson_progress_user FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- TOC entry 5526 (class 2606 OID 17119)
-- Name: lessons fk_lessons_chapter; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.lessons
    ADD CONSTRAINT fk_lessons_chapter FOREIGN KEY (chapter_id) REFERENCES public.chapters(id) ON DELETE CASCADE;


--
-- TOC entry 5543 (class 2606 OID 17397)
-- Name: online_judge_problems fk_online_judge_problems_created_by_teacher; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.online_judge_problems
    ADD CONSTRAINT fk_online_judge_problems_created_by_teacher FOREIGN KEY (created_by_teacher_id) REFERENCES public.teachers(id);


--
-- TOC entry 5548 (class 2606 OID 17529)
-- Name: online_judge_submissions fk_online_judge_submissions_contest; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.online_judge_submissions
    ADD CONSTRAINT fk_online_judge_submissions_contest FOREIGN KEY (contest_id) REFERENCES public.contests(id);


--
-- TOC entry 5549 (class 2606 OID 17524)
-- Name: online_judge_submissions fk_online_judge_submissions_lesson; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.online_judge_submissions
    ADD CONSTRAINT fk_online_judge_submissions_lesson FOREIGN KEY (lesson_id) REFERENCES public.lessons(id);


--
-- TOC entry 5550 (class 2606 OID 17519)
-- Name: online_judge_submissions fk_online_judge_submissions_problem; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.online_judge_submissions
    ADD CONSTRAINT fk_online_judge_submissions_problem FOREIGN KEY (problem_id) REFERENCES public.online_judge_problems(id);


--
-- TOC entry 5551 (class 2606 OID 17514)
-- Name: online_judge_submissions fk_online_judge_submissions_user; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.online_judge_submissions
    ADD CONSTRAINT fk_online_judge_submissions_user FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- TOC entry 5578 (class 2606 OID 18234)
-- Name: order_items fk_order_items_course; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_items
    ADD CONSTRAINT fk_order_items_course FOREIGN KEY (course_id) REFERENCES public.courses(id);


--
-- TOC entry 5579 (class 2606 OID 18229)
-- Name: order_items fk_order_items_order; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_items
    ADD CONSTRAINT fk_order_items_order FOREIGN KEY (order_id) REFERENCES public.orders(id);


--
-- TOC entry 5577 (class 2606 OID 18212)
-- Name: orders fk_orders_user; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT fk_orders_user FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- TOC entry 5574 (class 2606 OID 18169)
-- Name: payment_transactions fk_payment_transactions_wallet; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.payment_transactions
    ADD CONSTRAINT fk_payment_transactions_wallet FOREIGN KEY (wallet_id) REFERENCES public.wallets(id) ON DELETE CASCADE;


--
-- TOC entry 5544 (class 2606 OID 17432)
-- Name: problem_tag_mappings fk_problem_tag_mappings_problem; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.problem_tag_mappings
    ADD CONSTRAINT fk_problem_tag_mappings_problem FOREIGN KEY (problem_id) REFERENCES public.online_judge_problems(id) ON DELETE CASCADE;


--
-- TOC entry 5545 (class 2606 OID 17437)
-- Name: problem_tag_mappings fk_problem_tag_mappings_tag; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.problem_tag_mappings
    ADD CONSTRAINT fk_problem_tag_mappings_tag FOREIGN KEY (tag_id) REFERENCES public.problem_tags(id) ON DELETE CASCADE;


--
-- TOC entry 5546 (class 2606 OID 17461)
-- Name: problem_testcases fk_problem_testcases_problem; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.problem_testcases
    ADD CONSTRAINT fk_problem_testcases_problem FOREIGN KEY (problem_id) REFERENCES public.online_judge_problems(id) ON DELETE CASCADE;


--
-- TOC entry 5541 (class 2606 OID 17365)
-- Name: quiz_attempts fk_quiz_attempts_quiz; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.quiz_attempts
    ADD CONSTRAINT fk_quiz_attempts_quiz FOREIGN KEY (quiz_id) REFERENCES public.quizzes(id) ON DELETE CASCADE;


--
-- TOC entry 5542 (class 2606 OID 17360)
-- Name: quiz_attempts fk_quiz_attempts_user; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.quiz_attempts
    ADD CONSTRAINT fk_quiz_attempts_user FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- TOC entry 5540 (class 2606 OID 17337)
-- Name: quiz_options fk_quiz_options_question; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.quiz_options
    ADD CONSTRAINT fk_quiz_options_question FOREIGN KEY (question_id) REFERENCES public.quiz_questions(id) ON DELETE CASCADE;


--
-- TOC entry 5539 (class 2606 OID 17316)
-- Name: quiz_questions fk_quiz_questions_quiz; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.quiz_questions
    ADD CONSTRAINT fk_quiz_questions_quiz FOREIGN KEY (quiz_id) REFERENCES public.quizzes(id) ON DELETE CASCADE;


--
-- TOC entry 5537 (class 2606 OID 17294)
-- Name: quizzes fk_quizzes_created_by_teacher; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.quizzes
    ADD CONSTRAINT fk_quizzes_created_by_teacher FOREIGN KEY (created_by_teacher_id) REFERENCES public.teachers(id);


--
-- TOC entry 5538 (class 2606 OID 17289)
-- Name: quizzes fk_quizzes_lesson; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.quizzes
    ADD CONSTRAINT fk_quizzes_lesson FOREIGN KEY (lesson_id) REFERENCES public.lessons(id) ON DELETE CASCADE;


--
-- TOC entry 5523 (class 2606 OID 17024)
-- Name: refresh_tokens fk_refresh_tokens_user; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.refresh_tokens
    ADD CONSTRAINT fk_refresh_tokens_user FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- TOC entry 5521 (class 2606 OID 16984)
-- Name: role_permissions fk_role_permissions_permission; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.role_permissions
    ADD CONSTRAINT fk_role_permissions_permission FOREIGN KEY (permission_id) REFERENCES public.permissions(id) ON DELETE CASCADE;


--
-- TOC entry 5522 (class 2606 OID 16979)
-- Name: role_permissions fk_role_permissions_role; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.role_permissions
    ADD CONSTRAINT fk_role_permissions_role FOREIGN KEY (role_id) REFERENCES public.roles(id) ON DELETE CASCADE;


--
-- TOC entry 5571 (class 2606 OID 17942)
-- Name: online_judge_submission_details fk_sub_details_submission; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.online_judge_submission_details
    ADD CONSTRAINT fk_sub_details_submission FOREIGN KEY (submission_id) REFERENCES public.online_judge_submissions(id) ON DELETE CASCADE;


--
-- TOC entry 5572 (class 2606 OID 17947)
-- Name: online_judge_submission_details fk_sub_details_testcase; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.online_judge_submission_details
    ADD CONSTRAINT fk_sub_details_testcase FOREIGN KEY (testcase_id) REFERENCES public.problem_testcases(id) ON DELETE CASCADE;


--
-- TOC entry 5527 (class 2606 OID 17149)
-- Name: teacher_course_assignments fk_teacher_course_assignments_admin; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.teacher_course_assignments
    ADD CONSTRAINT fk_teacher_course_assignments_admin FOREIGN KEY (assigned_by_admin_id) REFERENCES public.users(id);


--
-- TOC entry 5528 (class 2606 OID 17144)
-- Name: teacher_course_assignments fk_teacher_course_assignments_course; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.teacher_course_assignments
    ADD CONSTRAINT fk_teacher_course_assignments_course FOREIGN KEY (course_id) REFERENCES public.courses(id) ON DELETE CASCADE;


--
-- TOC entry 5529 (class 2606 OID 17139)
-- Name: teacher_course_assignments fk_teacher_course_assignments_teacher; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.teacher_course_assignments
    ADD CONSTRAINT fk_teacher_course_assignments_teacher FOREIGN KEY (teacher_id) REFERENCES public.teachers(id) ON DELETE CASCADE;


--
-- TOC entry 5524 (class 2606 OID 17046)
-- Name: teachers fk_teachers_user; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.teachers
    ADD CONSTRAINT fk_teachers_user FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- TOC entry 5519 (class 2606 OID 16967)
-- Name: user_roles fk_user_roles_role; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_roles
    ADD CONSTRAINT fk_user_roles_role FOREIGN KEY (role_id) REFERENCES public.roles(id) ON DELETE CASCADE;


--
-- TOC entry 5520 (class 2606 OID 16962)
-- Name: user_roles fk_user_roles_user; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_roles
    ADD CONSTRAINT fk_user_roles_user FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- TOC entry 5575 (class 2606 OID 18176)
-- Name: wallet_transactions fk_wallet_transactions_wallet; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.wallet_transactions
    ADD CONSTRAINT fk_wallet_transactions_wallet FOREIGN KEY (wallet_id) REFERENCES public.wallets(id) ON DELETE CASCADE;


--
-- TOC entry 5576 (class 2606 OID 18239)
-- Name: wallet_transactions fk_wallet_tx_order; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.wallet_transactions
    ADD CONSTRAINT fk_wallet_tx_order FOREIGN KEY (order_id) REFERENCES public.orders(id);


--
-- TOC entry 5573 (class 2606 OID 18049)
-- Name: wallets fk_wallets_user; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.wallets
    ADD CONSTRAINT fk_wallets_user FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- TOC entry 5568 (class 2606 OID 17882)
-- Name: quiz_attempt_answers quiz_attempt_answers_attempt_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.quiz_attempt_answers
    ADD CONSTRAINT quiz_attempt_answers_attempt_id_fkey FOREIGN KEY (attempt_id) REFERENCES public.quiz_attempts(id) ON DELETE CASCADE;


--
-- TOC entry 5569 (class 2606 OID 17887)
-- Name: quiz_attempt_answers quiz_attempt_answers_question_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.quiz_attempt_answers
    ADD CONSTRAINT quiz_attempt_answers_question_id_fkey FOREIGN KEY (question_id) REFERENCES public.quiz_questions(id);


--
-- TOC entry 5570 (class 2606 OID 17892)
-- Name: quiz_attempt_answers quiz_attempt_answers_selected_option_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.quiz_attempt_answers
    ADD CONSTRAINT quiz_attempt_answers_selected_option_id_fkey FOREIGN KEY (selected_option_id) REFERENCES public.quiz_options(id);


-- Completed on 2026-05-30 11:38:56

--
-- PostgreSQL database dump complete
--

\unrestrict 1RyEnMLsxzw48cYJUbpVebs4TvJtfonZmUguOOcIpseZZQtocN2G4L3mX9wIfHU

