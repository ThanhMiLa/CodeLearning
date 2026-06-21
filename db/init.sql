--
-- PostgreSQL database dump
--

\restrict AV3msB1zxUDj5d0YfjZtfZT9cn1SD0NtWcl5etvhTlMDLF47kHzTOa2iMav04xw

-- Dumped from database version 14.23 (Homebrew)
-- Dumped by pg_dump version 14.23 (Homebrew)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
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
-- Name: conteststatus; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.conteststatus AS ENUM (
    'CANCELLED',
    'ENDED',
    'RUNNING',
    'UPCOMING'
);


ALTER TYPE public.conteststatus OWNER TO postgres;

--
-- Name: course_status; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.course_status AS ENUM (
    'ACTIVE',
    'INACTIVE',
    'DRAFT'
);


ALTER TYPE public.course_status OWNER TO postgres;

--
-- Name: coursestatus; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.coursestatus AS ENUM (
    'ACTIVE',
    'DRAFT',
    'INACTIVE'
);


ALTER TYPE public.coursestatus OWNER TO postgres;

--
-- Name: enrollment_status; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.enrollment_status AS ENUM (
    'ACTIVE',
    'CANCELLED',
    'COMPLETED'
);


ALTER TYPE public.enrollment_status OWNER TO postgres;

--
-- Name: enrollmentstatus; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.enrollmentstatus AS ENUM (
    'ACTIVE',
    'CANCELLED',
    'COMPLETED'
);


ALTER TYPE public.enrollmentstatus OWNER TO postgres;

--
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
-- Name: filesubmissionstatus; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.filesubmissionstatus AS ENUM (
    'GRADED',
    'IN_REVIEW',
    'NEEDS_RESUBMISSION',
    'REPLACED',
    'RESUBMITTED',
    'SUBMITTED'
);


ALTER TYPE public.filesubmissionstatus OWNER TO postgres;

--
-- Name: lesson_status; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.lesson_status AS ENUM (
    'ACTIVE',
    'INACTIVE',
    'DRAFT'
);


ALTER TYPE public.lesson_status OWNER TO postgres;

--
-- Name: lessonstatus; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.lessonstatus AS ENUM (
    'ACTIVE',
    'DRAFT',
    'INACTIVE'
);


ALTER TYPE public.lessonstatus OWNER TO postgres;

--
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
-- Name: ojverdict; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.ojverdict AS ENUM (
    'ACCEPTED',
    'COMPILATION_ERROR',
    'INTERNAL_ERROR',
    'MEMORY_LIMIT_EXCEEDED',
    'PENDING',
    'PROCESSING',
    'RUNTIME_ERROR',
    'TIME_LIMIT_EXCEEDED',
    'WRONG_ANSWER'
);


ALTER TYPE public.ojverdict OWNER TO postgres;

--
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
-- Name: orderstatus; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.orderstatus AS ENUM (
    'CANCELLED',
    'COMPLETED',
    'FAILED',
    'PENDING'
);


ALTER TYPE public.orderstatus OWNER TO postgres;

--
-- Name: payment_transaction_type; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.payment_transaction_type AS ENUM (
    'DEPOSIT',
    'WITHDRAW'
);


ALTER TYPE public.payment_transaction_type OWNER TO postgres;

--
-- Name: paymenttransactiontype; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.paymenttransactiontype AS ENUM (
    'DEPOSIT',
    'WITHDRAW'
);


ALTER TYPE public.paymenttransactiontype OWNER TO postgres;

--
-- Name: problem_difficulty; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.problem_difficulty AS ENUM (
    'EASY',
    'MEDIUM',
    'HARD'
);


ALTER TYPE public.problem_difficulty OWNER TO postgres;

--
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
-- Name: problemdifficulty; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.problemdifficulty AS ENUM (
    'EASY',
    'HARD',
    'MEDIUM'
);


ALTER TYPE public.problemdifficulty OWNER TO postgres;

--
-- Name: problemscope; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.problemscope AS ENUM (
    'CONTEST',
    'LESSON',
    'PRACTICE',
    'SHARED'
);


ALTER TYPE public.problemscope OWNER TO postgres;

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
-- Name: scoringrule; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.scoringrule AS ENUM (
    'CUSTOM',
    'ICPC',
    'IOI'
);


ALTER TYPE public.scoringrule OWNER TO postgres;

--
-- Name: teacher_status; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.teacher_status AS ENUM (
    'ACTIVE',
    'INACTIVE',
    'LOCKED'
);


ALTER TYPE public.teacher_status OWNER TO postgres;

--
-- Name: teacherstatus; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.teacherstatus AS ENUM (
    'ACTIVE',
    'INACTIVE',
    'LOCKED'
);


ALTER TYPE public.teacherstatus OWNER TO postgres;

--
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
-- Name: transactionstatus; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.transactionstatus AS ENUM (
    'CANCELLED',
    'FAILED',
    'PENDING',
    'SUCCESS'
);


ALTER TYPE public.transactionstatus OWNER TO postgres;

--
-- Name: user_status; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.user_status AS ENUM (
    'ACTIVE',
    'LOCKED',
    'DISABLED'
);


ALTER TYPE public.user_status OWNER TO postgres;

--
-- Name: userstatus; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.userstatus AS ENUM (
    'ACTIVE',
    'DISABLED',
    'LOCKED'
);


ALTER TYPE public.userstatus OWNER TO postgres;

--
-- Name: wallet_status; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.wallet_status AS ENUM (
    'ACTIVE',
    'LOCKED'
);


ALTER TYPE public.wallet_status OWNER TO postgres;

--
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
-- Name: walletstatus; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.walletstatus AS ENUM (
    'ACTIVE',
    'LOCKED'
);


ALTER TYPE public.walletstatus OWNER TO postgres;

--
-- Name: wallettransactiontype; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.wallettransactiontype AS ENUM (
    'DEPOSIT',
    'PURCHASE',
    'REFUND',
    'REWARD',
    'WITHDRAW'
);


ALTER TYPE public.wallettransactiontype OWNER TO postgres;

--
-- Name: CAST (public.conteststatus AS character varying); Type: CAST; Schema: -; Owner: -
--

CREATE CAST (public.conteststatus AS character varying) WITH INOUT AS IMPLICIT;


--
-- Name: CAST (public.coursestatus AS character varying); Type: CAST; Schema: -; Owner: -
--

CREATE CAST (public.coursestatus AS character varying) WITH INOUT AS IMPLICIT;


--
-- Name: CAST (public.enrollmentstatus AS character varying); Type: CAST; Schema: -; Owner: -
--

CREATE CAST (public.enrollmentstatus AS character varying) WITH INOUT AS IMPLICIT;


--
-- Name: CAST (public.filesubmissionstatus AS character varying); Type: CAST; Schema: -; Owner: -
--

CREATE CAST (public.filesubmissionstatus AS character varying) WITH INOUT AS IMPLICIT;


--
-- Name: CAST (public.lessonstatus AS character varying); Type: CAST; Schema: -; Owner: -
--

CREATE CAST (public.lessonstatus AS character varying) WITH INOUT AS IMPLICIT;


--
-- Name: CAST (public.ojverdict AS character varying); Type: CAST; Schema: -; Owner: -
--

CREATE CAST (public.ojverdict AS character varying) WITH INOUT AS IMPLICIT;


--
-- Name: CAST (public.orderstatus AS character varying); Type: CAST; Schema: -; Owner: -
--

CREATE CAST (public.orderstatus AS character varying) WITH INOUT AS IMPLICIT;


--
-- Name: CAST (public.paymenttransactiontype AS character varying); Type: CAST; Schema: -; Owner: -
--

CREATE CAST (public.paymenttransactiontype AS character varying) WITH INOUT AS IMPLICIT;


--
-- Name: CAST (public.problemdifficulty AS character varying); Type: CAST; Schema: -; Owner: -
--

CREATE CAST (public.problemdifficulty AS character varying) WITH INOUT AS IMPLICIT;


--
-- Name: CAST (public.problemscope AS character varying); Type: CAST; Schema: -; Owner: -
--

CREATE CAST (public.problemscope AS character varying) WITH INOUT AS IMPLICIT;


--
-- Name: CAST (public.scoringrule AS character varying); Type: CAST; Schema: -; Owner: -
--

CREATE CAST (public.scoringrule AS character varying) WITH INOUT AS IMPLICIT;


--
-- Name: CAST (public.teacherstatus AS character varying); Type: CAST; Schema: -; Owner: -
--

CREATE CAST (public.teacherstatus AS character varying) WITH INOUT AS IMPLICIT;


--
-- Name: CAST (public.transactionstatus AS character varying); Type: CAST; Schema: -; Owner: -
--

CREATE CAST (public.transactionstatus AS character varying) WITH INOUT AS IMPLICIT;


--
-- Name: CAST (public.userstatus AS character varying); Type: CAST; Schema: -; Owner: -
--

CREATE CAST (public.userstatus AS character varying) WITH INOUT AS IMPLICIT;


--
-- Name: CAST (character varying AS public.conteststatus); Type: CAST; Schema: -; Owner: -
--

CREATE CAST (character varying AS public.conteststatus) WITH INOUT AS IMPLICIT;


--
-- Name: CAST (character varying AS public.coursestatus); Type: CAST; Schema: -; Owner: -
--

CREATE CAST (character varying AS public.coursestatus) WITH INOUT AS IMPLICIT;


--
-- Name: CAST (character varying AS public.enrollmentstatus); Type: CAST; Schema: -; Owner: -
--

CREATE CAST (character varying AS public.enrollmentstatus) WITH INOUT AS IMPLICIT;


--
-- Name: CAST (character varying AS public.filesubmissionstatus); Type: CAST; Schema: -; Owner: -
--

CREATE CAST (character varying AS public.filesubmissionstatus) WITH INOUT AS IMPLICIT;


--
-- Name: CAST (character varying AS public.lessonstatus); Type: CAST; Schema: -; Owner: -
--

CREATE CAST (character varying AS public.lessonstatus) WITH INOUT AS IMPLICIT;


--
-- Name: CAST (character varying AS public.ojverdict); Type: CAST; Schema: -; Owner: -
--

CREATE CAST (character varying AS public.ojverdict) WITH INOUT AS IMPLICIT;


--
-- Name: CAST (character varying AS public.orderstatus); Type: CAST; Schema: -; Owner: -
--

CREATE CAST (character varying AS public.orderstatus) WITH INOUT AS IMPLICIT;


--
-- Name: CAST (character varying AS public.paymenttransactiontype); Type: CAST; Schema: -; Owner: -
--

CREATE CAST (character varying AS public.paymenttransactiontype) WITH INOUT AS IMPLICIT;


--
-- Name: CAST (character varying AS public.problemdifficulty); Type: CAST; Schema: -; Owner: -
--

CREATE CAST (character varying AS public.problemdifficulty) WITH INOUT AS IMPLICIT;


--
-- Name: CAST (character varying AS public.problemscope); Type: CAST; Schema: -; Owner: -
--

CREATE CAST (character varying AS public.problemscope) WITH INOUT AS IMPLICIT;


--
-- Name: CAST (character varying AS public.scoringrule); Type: CAST; Schema: -; Owner: -
--

CREATE CAST (character varying AS public.scoringrule) WITH INOUT AS IMPLICIT;


--
-- Name: CAST (character varying AS public.teacherstatus); Type: CAST; Schema: -; Owner: -
--

CREATE CAST (character varying AS public.teacherstatus) WITH INOUT AS IMPLICIT;


--
-- Name: CAST (character varying AS public.transactionstatus); Type: CAST; Schema: -; Owner: -
--

CREATE CAST (character varying AS public.transactionstatus) WITH INOUT AS IMPLICIT;


--
-- Name: CAST (character varying AS public.userstatus); Type: CAST; Schema: -; Owner: -
--

CREATE CAST (character varying AS public.userstatus) WITH INOUT AS IMPLICIT;


--
-- Name: CAST (character varying AS public.walletstatus); Type: CAST; Schema: -; Owner: -
--

CREATE CAST (character varying AS public.walletstatus) WITH INOUT AS IMPLICIT;


--
-- Name: CAST (character varying AS public.wallettransactiontype); Type: CAST; Schema: -; Owner: -
--

CREATE CAST (character varying AS public.wallettransactiontype) WITH INOUT AS IMPLICIT;


--
-- Name: CAST (public.walletstatus AS character varying); Type: CAST; Schema: -; Owner: -
--

CREATE CAST (public.walletstatus AS character varying) WITH INOUT AS IMPLICIT;


--
-- Name: CAST (public.wallettransactiontype AS character varying); Type: CAST; Schema: -; Owner: -
--

CREATE CAST (public.wallettransactiontype AS character varying) WITH INOUT AS IMPLICIT;


--
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
-- Name: cart_items_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.cart_items_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.cart_items_id_seq OWNER TO postgres;

--
-- Name: cart_items_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.cart_items_id_seq OWNED BY public.cart_items.id;


--
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
-- Name: carts_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.carts_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.carts_id_seq OWNER TO postgres;

--
-- Name: carts_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.carts_id_seq OWNED BY public.carts.id;


--
-- Name: categories; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.categories (
    id bigint NOT NULL,
    name character varying(255) NOT NULL,
    slug character varying(255) NOT NULL,
    description text,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.categories OWNER TO postgres;

--
-- Name: categories_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.categories_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.categories_id_seq OWNER TO postgres;

--
-- Name: categories_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.categories_id_seq OWNED BY public.categories.id;


--
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
-- Name: chapters_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.chapters_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.chapters_id_seq OWNER TO postgres;

--
-- Name: chapters_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.chapters_id_seq OWNED BY public.chapters.id;


--
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
-- Name: completed_lessons_count_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.completed_lessons_count_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.completed_lessons_count_id_seq OWNER TO postgres;

--
-- Name: completed_lessons_count_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.completed_lessons_count_id_seq OWNED BY public.completed_lessons_count.id;


--
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
-- Name: contest_participants_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.contest_participants_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.contest_participants_id_seq OWNER TO postgres;

--
-- Name: contest_participants_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.contest_participants_id_seq OWNED BY public.contest_participants.id;


--
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
-- Name: contest_problems_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.contest_problems_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.contest_problems_id_seq OWNER TO postgres;

--
-- Name: contest_problems_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.contest_problems_id_seq OWNED BY public.contest_problems.id;


--
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
-- Name: contests_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.contests_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.contests_id_seq OWNER TO postgres;

--
-- Name: contests_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.contests_id_seq OWNED BY public.contests.id;


--
-- Name: course_category_mappings; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.course_category_mappings (
    course_id bigint NOT NULL,
    category_id bigint NOT NULL
);


ALTER TABLE public.course_category_mappings OWNER TO postgres;

--
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
-- Name: course_reviews_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.course_reviews_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.course_reviews_id_seq OWNER TO postgres;

--
-- Name: course_reviews_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.course_reviews_id_seq OWNED BY public.course_reviews.id;


--
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
-- Name: courses_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.courses_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.courses_id_seq OWNER TO postgres;

--
-- Name: courses_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.courses_id_seq OWNED BY public.courses.id;


--
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
-- Name: enrollments_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.enrollments_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.enrollments_id_seq OWNER TO postgres;

--
-- Name: enrollments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.enrollments_id_seq OWNED BY public.enrollments.id;


--
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
-- Name: invalidated_tokens_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.invalidated_tokens_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.invalidated_tokens_id_seq OWNER TO postgres;

--
-- Name: invalidated_tokens_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.invalidated_tokens_id_seq OWNED BY public.invalidated_tokens.id;


--
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
-- Name: lesson_comments_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.lesson_comments_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.lesson_comments_id_seq OWNER TO postgres;

--
-- Name: lesson_comments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.lesson_comments_id_seq OWNED BY public.lesson_comments.id;


--
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
-- Name: lesson_problems_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.lesson_problems_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.lesson_problems_id_seq OWNER TO postgres;

--
-- Name: lesson_problems_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.lesson_problems_id_seq OWNED BY public.lesson_problems.id;


--
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
-- Name: lesson_progress_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.lesson_progress_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.lesson_progress_id_seq OWNER TO postgres;

--
-- Name: lesson_progress_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.lesson_progress_id_seq OWNED BY public.lesson_progress.id;


--
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
-- Name: lessons_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.lessons_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.lessons_id_seq OWNER TO postgres;

--
-- Name: lessons_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.lessons_id_seq OWNED BY public.lessons.id;


--
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
-- Name: online_judge_problems_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.online_judge_problems_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.online_judge_problems_id_seq OWNER TO postgres;

--
-- Name: online_judge_problems_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.online_judge_problems_id_seq OWNED BY public.online_judge_problems.id;


--
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
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    compile_output text,
    stderr text,
    stdout text
);


ALTER TABLE public.online_judge_submission_details OWNER TO postgres;

--
-- Name: online_judge_submission_details_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.online_judge_submission_details_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.online_judge_submission_details_id_seq OWNER TO postgres;

--
-- Name: online_judge_submission_details_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.online_judge_submission_details_id_seq OWNED BY public.online_judge_submission_details.id;


--
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
-- Name: online_judge_submissions_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.online_judge_submissions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.online_judge_submissions_id_seq OWNER TO postgres;

--
-- Name: online_judge_submissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.online_judge_submissions_id_seq OWNED BY public.online_judge_submissions.id;


--
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
-- Name: order_items_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.order_items_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.order_items_id_seq OWNER TO postgres;

--
-- Name: order_items_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.order_items_id_seq OWNED BY public.order_items.id;


--
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
-- Name: orders_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.orders_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.orders_id_seq OWNER TO postgres;

--
-- Name: orders_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.orders_id_seq OWNED BY public.orders.id;


--
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
-- Name: payment_transactions_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.payment_transactions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.payment_transactions_id_seq OWNER TO postgres;

--
-- Name: payment_transactions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.payment_transactions_id_seq OWNED BY public.payment_transactions.id;


--
-- Name: permissions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.permissions (
    id bigint NOT NULL,
    name character varying(150) NOT NULL,
    CONSTRAINT chk_permissions_name_not_blank CHECK ((length(TRIM(BOTH FROM name)) > 0))
);


ALTER TABLE public.permissions OWNER TO postgres;

--
-- Name: permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.permissions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.permissions_id_seq OWNER TO postgres;

--
-- Name: permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.permissions_id_seq OWNED BY public.permissions.id;


--
-- Name: problem_tag_mappings; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.problem_tag_mappings (
    id bigint NOT NULL,
    problem_id bigint NOT NULL,
    tag_id bigint NOT NULL
);


ALTER TABLE public.problem_tag_mappings OWNER TO postgres;

--
-- Name: problem_tag_mappings_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.problem_tag_mappings_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.problem_tag_mappings_id_seq OWNER TO postgres;

--
-- Name: problem_tag_mappings_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.problem_tag_mappings_id_seq OWNED BY public.problem_tag_mappings.id;


--
-- Name: problem_tags; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.problem_tags (
    id bigint NOT NULL,
    name character varying(255) NOT NULL,
    slug character varying(255) NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    CONSTRAINT chk_problem_tags_name_not_blank CHECK ((length(TRIM(BOTH FROM name)) > 0)),
    CONSTRAINT chk_problem_tags_slug_not_blank CHECK ((length(TRIM(BOTH FROM slug)) > 0))
);


ALTER TABLE public.problem_tags OWNER TO postgres;

--
-- Name: problem_tags_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.problem_tags_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.problem_tags_id_seq OWNER TO postgres;

--
-- Name: problem_tags_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.problem_tags_id_seq OWNED BY public.problem_tags.id;


--
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
-- Name: problem_testcases_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.problem_testcases_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.problem_testcases_id_seq OWNER TO postgres;

--
-- Name: problem_testcases_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.problem_testcases_id_seq OWNED BY public.problem_testcases.id;


--
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
-- Name: quiz_attempt_answers_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.quiz_attempt_answers_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.quiz_attempt_answers_id_seq OWNER TO postgres;

--
-- Name: quiz_attempt_answers_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.quiz_attempt_answers_id_seq OWNED BY public.quiz_attempt_answers.id;


--
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
-- Name: quiz_attempts_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.quiz_attempts_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.quiz_attempts_id_seq OWNER TO postgres;

--
-- Name: quiz_attempts_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.quiz_attempts_id_seq OWNED BY public.quiz_attempts.id;


--
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
-- Name: quiz_options_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.quiz_options_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.quiz_options_id_seq OWNER TO postgres;

--
-- Name: quiz_options_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.quiz_options_id_seq OWNED BY public.quiz_options.id;


--
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
-- Name: quiz_questions_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.quiz_questions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.quiz_questions_id_seq OWNER TO postgres;

--
-- Name: quiz_questions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.quiz_questions_id_seq OWNED BY public.quiz_questions.id;


--
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
-- Name: quizzes_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.quizzes_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.quizzes_id_seq OWNER TO postgres;

--
-- Name: quizzes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.quizzes_id_seq OWNED BY public.quizzes.id;


--
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
-- Name: refresh_tokens_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.refresh_tokens_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.refresh_tokens_id_seq OWNER TO postgres;

--
-- Name: refresh_tokens_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.refresh_tokens_id_seq OWNED BY public.refresh_tokens.id;


--
-- Name: role_permissions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.role_permissions (
    role_id bigint NOT NULL,
    permission_id bigint NOT NULL
);


ALTER TABLE public.role_permissions OWNER TO postgres;

--
-- Name: roles; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.roles (
    id bigint NOT NULL,
    name character varying(100) NOT NULL,
    CONSTRAINT chk_roles_name_not_blank CHECK ((length(TRIM(BOTH FROM name)) > 0))
);


ALTER TABLE public.roles OWNER TO postgres;

--
-- Name: roles_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.roles_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.roles_id_seq OWNER TO postgres;

--
-- Name: roles_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.roles_id_seq OWNED BY public.roles.id;


--
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
-- Name: teacher_course_assignments_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.teacher_course_assignments_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.teacher_course_assignments_id_seq OWNER TO postgres;

--
-- Name: teacher_course_assignments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.teacher_course_assignments_id_seq OWNED BY public.teacher_course_assignments.id;


--
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
-- Name: teachers_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.teachers_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.teachers_id_seq OWNER TO postgres;

--
-- Name: teachers_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.teachers_id_seq OWNED BY public.teachers.id;


--
-- Name: user_roles; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_roles (
    user_id bigint NOT NULL,
    role_id bigint NOT NULL
);


ALTER TABLE public.user_roles OWNER TO postgres;

--
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
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.users_id_seq OWNER TO postgres;

--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
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
-- Name: wallet_transactions_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.wallet_transactions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.wallet_transactions_id_seq OWNER TO postgres;

--
-- Name: wallet_transactions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.wallet_transactions_id_seq OWNED BY public.wallet_transactions.id;


--
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
-- Name: wallets_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.wallets_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.wallets_id_seq OWNER TO postgres;

--
-- Name: wallets_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.wallets_id_seq OWNED BY public.wallets.id;


--
-- Name: cart_items id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cart_items ALTER COLUMN id SET DEFAULT nextval('public.cart_items_id_seq'::regclass);


--
-- Name: carts id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.carts ALTER COLUMN id SET DEFAULT nextval('public.carts_id_seq'::regclass);


--
-- Name: categories id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.categories ALTER COLUMN id SET DEFAULT nextval('public.categories_id_seq'::regclass);


--
-- Name: chapters id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.chapters ALTER COLUMN id SET DEFAULT nextval('public.chapters_id_seq'::regclass);


--
-- Name: completed_lessons_count id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.completed_lessons_count ALTER COLUMN id SET DEFAULT nextval('public.completed_lessons_count_id_seq'::regclass);


--
-- Name: contest_participants id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.contest_participants ALTER COLUMN id SET DEFAULT nextval('public.contest_participants_id_seq'::regclass);


--
-- Name: contest_problems id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.contest_problems ALTER COLUMN id SET DEFAULT nextval('public.contest_problems_id_seq'::regclass);


--
-- Name: contests id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.contests ALTER COLUMN id SET DEFAULT nextval('public.contests_id_seq'::regclass);


--
-- Name: course_reviews id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.course_reviews ALTER COLUMN id SET DEFAULT nextval('public.course_reviews_id_seq'::regclass);


--
-- Name: courses id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.courses ALTER COLUMN id SET DEFAULT nextval('public.courses_id_seq'::regclass);


--
-- Name: enrollments id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.enrollments ALTER COLUMN id SET DEFAULT nextval('public.enrollments_id_seq'::regclass);


--
-- Name: invalidated_tokens id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.invalidated_tokens ALTER COLUMN id SET DEFAULT nextval('public.invalidated_tokens_id_seq'::regclass);


--
-- Name: lesson_comments id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.lesson_comments ALTER COLUMN id SET DEFAULT nextval('public.lesson_comments_id_seq'::regclass);


--
-- Name: lesson_problems id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.lesson_problems ALTER COLUMN id SET DEFAULT nextval('public.lesson_problems_id_seq'::regclass);


--
-- Name: lesson_progress id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.lesson_progress ALTER COLUMN id SET DEFAULT nextval('public.lesson_progress_id_seq'::regclass);


--
-- Name: lessons id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.lessons ALTER COLUMN id SET DEFAULT nextval('public.lessons_id_seq'::regclass);


--
-- Name: online_judge_problems id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.online_judge_problems ALTER COLUMN id SET DEFAULT nextval('public.online_judge_problems_id_seq'::regclass);


--
-- Name: online_judge_submission_details id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.online_judge_submission_details ALTER COLUMN id SET DEFAULT nextval('public.online_judge_submission_details_id_seq'::regclass);


--
-- Name: online_judge_submissions id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.online_judge_submissions ALTER COLUMN id SET DEFAULT nextval('public.online_judge_submissions_id_seq'::regclass);


--
-- Name: order_items id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_items ALTER COLUMN id SET DEFAULT nextval('public.order_items_id_seq'::regclass);


--
-- Name: orders id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orders ALTER COLUMN id SET DEFAULT nextval('public.orders_id_seq'::regclass);


--
-- Name: payment_transactions id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.payment_transactions ALTER COLUMN id SET DEFAULT nextval('public.payment_transactions_id_seq'::regclass);


--
-- Name: permissions id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.permissions ALTER COLUMN id SET DEFAULT nextval('public.permissions_id_seq'::regclass);


--
-- Name: problem_tag_mappings id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.problem_tag_mappings ALTER COLUMN id SET DEFAULT nextval('public.problem_tag_mappings_id_seq'::regclass);


--
-- Name: problem_tags id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.problem_tags ALTER COLUMN id SET DEFAULT nextval('public.problem_tags_id_seq'::regclass);


--
-- Name: problem_testcases id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.problem_testcases ALTER COLUMN id SET DEFAULT nextval('public.problem_testcases_id_seq'::regclass);


--
-- Name: quiz_attempt_answers id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.quiz_attempt_answers ALTER COLUMN id SET DEFAULT nextval('public.quiz_attempt_answers_id_seq'::regclass);


--
-- Name: quiz_attempts id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.quiz_attempts ALTER COLUMN id SET DEFAULT nextval('public.quiz_attempts_id_seq'::regclass);


--
-- Name: quiz_options id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.quiz_options ALTER COLUMN id SET DEFAULT nextval('public.quiz_options_id_seq'::regclass);


--
-- Name: quiz_questions id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.quiz_questions ALTER COLUMN id SET DEFAULT nextval('public.quiz_questions_id_seq'::regclass);


--
-- Name: quizzes id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.quizzes ALTER COLUMN id SET DEFAULT nextval('public.quizzes_id_seq'::regclass);


--
-- Name: refresh_tokens id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.refresh_tokens ALTER COLUMN id SET DEFAULT nextval('public.refresh_tokens_id_seq'::regclass);


--
-- Name: roles id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.roles ALTER COLUMN id SET DEFAULT nextval('public.roles_id_seq'::regclass);


--
-- Name: teacher_course_assignments id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.teacher_course_assignments ALTER COLUMN id SET DEFAULT nextval('public.teacher_course_assignments_id_seq'::regclass);


--
-- Name: teachers id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.teachers ALTER COLUMN id SET DEFAULT nextval('public.teachers_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Name: wallet_transactions id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.wallet_transactions ALTER COLUMN id SET DEFAULT nextval('public.wallet_transactions_id_seq'::regclass);


--
-- Name: wallets id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.wallets ALTER COLUMN id SET DEFAULT nextval('public.wallets_id_seq'::regclass);


--
-- Data for Name: cart_items; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.cart_items (id, cart_id, course_id, created_at) FROM stdin;
3	2	6	2026-06-20 15:34:38.76162+07
5	1	9	2026-06-21 17:52:55.953105+07
\.


--
-- Data for Name: carts; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.carts (id, user_id, created_at, updated_at) FROM stdin;
1	5	2026-06-16 22:50:54.837128+07	2026-06-16 22:50:54.837128+07
2	1	2026-06-16 23:01:31.989254+07	2026-06-16 23:01:31.989254+07
3	11	2026-06-17 02:14:28.699347+07	2026-06-17 02:14:28.699347+07
4	12	2026-06-20 15:28:16.786628+07	2026-06-20 15:28:16.786628+07
5	13	2026-06-21 01:06:27.432108+07	2026-06-21 01:06:27.432108+07
\.


--
-- Data for Name: categories; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.categories (id, name, slug, description, created_at, updated_at) FROM stdin;
6	Java	java	Java Programming Language	2026-06-13 23:31:04.609987+07	2026-06-13 23:31:04.609995+07
7	Cấu trúc dữ liệu và giải thuật	dsa	Data Structures and Algorithms	2026-06-13 23:31:04.611464+07	2026-06-13 23:31:04.61147+07
8	Thiết kế hệ thống	system-design	System Design & Architecture	2026-06-13 23:31:04.61247+07	2026-06-13 23:31:04.612475+07
9	Lập trình Web	web-development	Fullstack Web Development	2026-06-13 23:31:04.615429+07	2026-06-13 23:31:04.615445+07
10	Cơ sở dữ liệu	database	Relational and Non-Relational Databases	2026-06-13 23:31:04.616701+07	2026-06-13 23:31:04.61671+07
\.


--
-- Data for Name: chapters; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.chapters (id, course_id, title, order_index, created_at, updated_at) FROM stdin;
26	6	Chương 1: Bài học lý thuyết và thực hành phần 1	1	2026-06-13 23:31:04.334755+07	2026-06-13 23:31:04.334755+07
27	6	Chương 2: Bài học lý thuyết và thực hành phần 2	2	2026-06-13 23:31:04.334755+07	2026-06-13 23:31:04.334755+07
28	6	Chương 3: Bài học lý thuyết và thực hành phần 3	3	2026-06-13 23:31:04.334755+07	2026-06-13 23:31:04.334755+07
29	6	Chương 4: Bài học lý thuyết và thực hành phần 4	4	2026-06-13 23:31:04.334755+07	2026-06-13 23:31:04.334755+07
30	6	Chương 5: Bài học lý thuyết và thực hành phần 5	5	2026-06-13 23:31:04.334755+07	2026-06-13 23:31:04.334755+07
31	7	Chương 1: Bài học lý thuyết và thực hành phần 1	1	2026-06-13 23:31:04.334755+07	2026-06-13 23:31:04.334755+07
32	7	Chương 2: Bài học lý thuyết và thực hành phần 2	2	2026-06-13 23:31:04.334755+07	2026-06-13 23:31:04.334755+07
33	7	Chương 3: Bài học lý thuyết và thực hành phần 3	3	2026-06-13 23:31:04.334755+07	2026-06-13 23:31:04.334755+07
34	7	Chương 4: Bài học lý thuyết và thực hành phần 4	4	2026-06-13 23:31:04.334755+07	2026-06-13 23:31:04.334755+07
35	7	Chương 5: Bài học lý thuyết và thực hành phần 5	5	2026-06-13 23:31:04.334755+07	2026-06-13 23:31:04.334755+07
36	8	Chương 1: Bài học lý thuyết và thực hành phần 1	1	2026-06-13 23:31:04.334755+07	2026-06-13 23:31:04.334755+07
37	8	Chương 2: Bài học lý thuyết và thực hành phần 2	2	2026-06-13 23:31:04.334755+07	2026-06-13 23:31:04.334755+07
38	8	Chương 3: Bài học lý thuyết và thực hành phần 3	3	2026-06-13 23:31:04.334755+07	2026-06-13 23:31:04.334755+07
39	8	Chương 4: Bài học lý thuyết và thực hành phần 4	4	2026-06-13 23:31:04.334755+07	2026-06-13 23:31:04.334755+07
40	8	Chương 5: Bài học lý thuyết và thực hành phần 5	5	2026-06-13 23:31:04.334755+07	2026-06-13 23:31:04.334755+07
41	9	Chương 1: Bài học lý thuyết và thực hành phần 1	1	2026-06-13 23:31:04.334755+07	2026-06-13 23:31:04.334755+07
42	9	Chương 2: Bài học lý thuyết và thực hành phần 2	2	2026-06-13 23:31:04.334755+07	2026-06-13 23:31:04.334755+07
43	9	Chương 3: Bài học lý thuyết và thực hành phần 3	3	2026-06-13 23:31:04.334755+07	2026-06-13 23:31:04.334755+07
44	9	Chương 4: Bài học lý thuyết và thực hành phần 4	4	2026-06-13 23:31:04.334755+07	2026-06-13 23:31:04.334755+07
45	9	Chương 5: Bài học lý thuyết và thực hành phần 5	5	2026-06-13 23:31:04.334755+07	2026-06-13 23:31:04.334755+07
46	10	Chương 1: Bài học lý thuyết và thực hành phần 1	1	2026-06-13 23:31:04.334755+07	2026-06-13 23:31:04.334755+07
47	10	Chương 2: Bài học lý thuyết và thực hành phần 2	2	2026-06-13 23:31:04.334755+07	2026-06-13 23:31:04.334755+07
48	10	Chương 3: Bài học lý thuyết và thực hành phần 3	3	2026-06-13 23:31:04.334755+07	2026-06-13 23:31:04.334755+07
49	10	Chương 4: Bài học lý thuyết và thực hành phần 4	4	2026-06-13 23:31:04.334755+07	2026-06-13 23:31:04.334755+07
50	10	Chương 5: Bài học lý thuyết và thực hành phần 5	5	2026-06-13 23:31:04.334755+07	2026-06-13 23:31:04.334755+07
\.


--
-- Data for Name: completed_lessons_count; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.completed_lessons_count (id, user_id, course_id, completed_lessons_count, updated_at) FROM stdin;
1	5	6	15	2026-06-19 20:10:39.68601+07
3	5	7	3	2026-06-21 04:03:16.91821+07
\.


--
-- Data for Name: contest_participants; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.contest_participants (id, contest_id, user_id, joined_at) FROM stdin;
3	4	5	2026-06-16 23:08:41.688916+07
4	7	5	2026-06-17 01:10:25.672885+07
5	8	5	2026-06-17 01:16:05.056436+07
6	9	5	2026-06-17 01:35:14.893524+07
7	10	5	2026-06-17 01:40:03.771152+07
8	11	5	2026-06-17 01:41:10.689595+07
9	12	5	2026-06-17 01:44:23.909968+07
10	13	11	2026-06-17 02:20:47.428534+07
11	13	5	2026-06-17 02:37:08.830845+07
12	14	5	2026-06-19 00:40:08.232176+07
13	14	1	2026-06-19 00:41:51.314562+07
14	15	5	2026-06-19 00:55:14.167485+07
15	16	5	2026-06-19 02:02:01.26842+07
16	17	5	2026-06-19 08:05:19.734684+07
\.


--
-- Data for Name: contest_problem_attempts; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.contest_problem_attempts (id, contest_id, user_id, problem_id, is_solved, solved_at_seconds, failed_attempts_count, created_at, updated_at) FROM stdin;
4	3	5	5	t	402	0	2026-06-16 19:40:00.110091+07	2026-06-16 19:46:44.863191+07
22	15	5	5	t	19	0	2026-06-19 00:55:14.193235+07	2026-06-19 00:55:21.814573+07
23	15	5	6	f	\N	1	2026-06-19 00:55:14.196075+07	2026-06-19 01:05:06.829561+07
24	15	5	7	t	689	0	2026-06-19 00:55:14.197515+07	2026-06-19 01:06:29.978002+07
25	16	5	5	f	\N	0	2026-06-19 02:02:01.285431+07	2026-06-19 02:02:01.285434+07
1	3	10	5	t	481	4	2026-06-16 19:40:00.09942+07	2026-06-16 19:48:03.604115+07
26	16	5	6	f	\N	0	2026-06-19 02:02:01.28719+07	2026-06-19 02:02:01.287191+07
3	3	10	7	t	643	1	2026-06-16 19:40:00.109233+07	2026-06-16 19:50:44.123045+07
6	3	5	7	t	660	0	2026-06-16 19:40:00.111937+07	2026-06-16 19:51:01.19012+07
27	16	5	7	f	\N	0	2026-06-19 02:02:01.287819+07	2026-06-19 02:02:01.287819+07
28	17	5	5	f	\N	0	2026-06-19 08:05:19.753825+07	2026-06-19 08:05:19.753827+07
29	17	5	6	f	\N	0	2026-06-19 08:05:19.755732+07	2026-06-19 08:05:19.75574+07
30	17	5	7	f	\N	0	2026-06-19 08:05:19.757445+07	2026-06-19 08:05:19.757446+07
5	3	5	6	t	863	27	2026-06-16 19:40:00.110897+07	2026-06-16 19:54:24.518434+07
2	3	10	6	t	877	0	2026-06-16 19:40:00.108212+07	2026-06-16 19:54:37.668364+07
7	8	5	7	t	0	0	2026-06-17 01:16:54.395402+07	2026-06-17 01:16:54.395408+07
8	8	5	6	t	0	0	2026-06-17 01:16:58.200411+07	2026-06-17 01:16:58.200415+07
9	8	5	5	t	0	1	2026-06-17 01:17:12.66155+07	2026-06-17 01:17:21.043711+07
11	13	11	6	f	\N	1	2026-06-17 02:20:47.46817+07	2026-06-17 02:22:27.520203+07
12	13	11	7	f	\N	1	2026-06-17 02:20:47.469095+07	2026-06-17 02:22:29.619904+07
10	13	11	5	t	191	4	2026-06-17 02:20:47.465719+07	2026-06-17 02:23:14.189445+07
13	13	5	5	t	1035	0	2026-06-17 02:37:08.842278+07	2026-06-17 02:37:16.989404+07
14	13	5	6	t	1603	0	2026-06-17 02:37:08.843436+07	2026-06-17 02:46:43.862515+07
15	13	5	7	t	1627	0	2026-06-17 02:37:08.844162+07	2026-06-17 02:47:07.968311+07
16	14	5	5	t	61	0	2026-06-19 00:40:08.271398+07	2026-06-19 00:41:03.71156+07
19	14	1	5	f	\N	0	2026-06-19 00:41:51.331237+07	2026-06-19 00:41:51.331238+07
20	14	1	6	f	\N	0	2026-06-19 00:41:51.334481+07	2026-06-19 00:41:51.334482+07
21	14	1	7	f	\N	0	2026-06-19 00:41:51.3359+07	2026-06-19 00:41:51.335901+07
17	14	5	6	t	170	0	2026-06-19 00:40:08.274254+07	2026-06-19 00:42:51.524841+07
18	14	5	7	t	206	5	2026-06-19 00:40:08.275213+07	2026-06-19 00:43:26.850939+07
\.


--
-- Data for Name: contest_problems; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.contest_problems (id, contest_id, problem_id, order_index) FROM stdin;
4	8	5	1
5	8	6	2
6	8	7	3
7	13	5	1
8	13	6	2
9	13	7	3
10	14	5	1
11	14	6	2
12	14	7	3
13	15	5	1
14	15	6	2
15	15	7	3
16	16	5	1
17	16	6	2
18	16	7	3
19	17	5	1
20	17	6	2
21	17	7	3
25	19	5	1
26	19	7	2
27	19	6	3
30	21	5	1
29	21	6	3
28	21	7	2
\.


--
-- Data for Name: contest_rankings; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.contest_rankings (id, contest_id, user_id, problems_solved, total_penalty, updated_at) FROM stdin;
2	3	5	3	34325	2026-06-16 19:54:24.518469+07
1	3	10	3	8001	2026-06-16 19:54:37.668409+07
3	8	5	3	1200	2026-06-17 01:17:21.043764+07
4	9	5	0	0	2026-06-17 01:35:14.907848+07
5	10	5	0	0	2026-06-17 01:40:03.778563+07
6	11	5	0	0	2026-06-17 01:41:10.69765+07
7	12	5	0	0	2026-06-17 01:44:23.924453+07
8	13	11	1	4991	2026-06-17 02:23:14.189638+07
9	13	5	3	4265	2026-06-17 02:47:07.968386+07
11	14	1	0	0	2026-06-19 00:41:51.323349+07
10	14	5	3	6437	2026-06-19 00:43:26.850969+07
12	15	5	2	708	2026-06-19 01:06:29.978167+07
13	16	5	0	0	2026-06-19 02:02:01.278765+07
14	17	5	0	0	2026-06-19 08:05:19.745044+07
\.


--
-- Data for Name: contests; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.contests (id, title, description, password_hash, start_time, end_time, status, created_by_teacher_id, created_at, updated_at, scoring_rule) FROM stdin;
4	ICPC Tầm Vũ Trụ	Cuộc thi lập trình thuật toán hàng tuần dành cho tất cả các thành viên. Thời gian làm bài 120 phút với 5 bài toán từ dễ đến khó.	$2a$10$R5lKVctjUilnY1y0aoKOTe4TVFo8SgZ31//CKCmSV0lIBwojdIIfe	2026-06-16 23:10:00+07	2026-06-16 23:15:00+07	ENDED	2	2026-06-16 23:08:24.087643+07	2026-06-16 23:15:00.029294+07	ICPC
5	ICPC Tầm Con Mẹ Nó Vũ Trụ	Cuộc thi lập trình thuật toán hàng tuần dành cho tất cả các thành viên. Thời gian làm bài 120 phút với 5 bài toán từ dễ đến khó.	\N	2026-06-16 23:25:00+07	2026-06-16 23:30:00+07	ENDED	2	2026-06-16 23:20:50.85244+07	2026-06-16 23:30:00.007203+07	ICPC
3	ICPC Tầm thế giới	Cuộc thi lập trình thuật toán hàng tuần dành cho tất cả các thành viên. Thời gian làm bài 120 phút với 5 bài toán từ dễ đến khó.	$2a$10$WKy7/oDeQkzSS361EFTO8.Ov1Ru2MfgIZxapW.e71gySCvacKJGau	2026-06-16 19:40:00+07	2026-06-16 20:00:00+07	ENDED	2	2026-06-16 19:33:04.87226+07	2026-06-16 23:33:57.129526+07	ICPC
6	ICPC Tầm Con Mẹ Nó Vũ 333333333333333Trụ	Cuộc thi lập trình thuật toán hàng tuần dành cho tất cả các thành viên. Thời gian làm bài 120 phút với 5 bài toán từ dễ đến khó.	\N	2026-06-17 00:35:00+07	2026-06-17 01:00:00+07	ENDED	2	2026-06-17 00:34:32.641999+07	2026-06-17 01:00:00.063527+07	ICPC
7	ICPC Tầm Con Mẹ Nó Vũ 333333333333333Trụ999999999	Cuộc thi lập trình thuật toán hàng tuần dành cho tất cả các thành viên. Thời gian làm bài 120 phút với 5 bài toán từ dễ đến khó.	\N	2026-06-17 01:10:00+07	2026-06-17 01:30:00+07	ENDED	2	2026-06-17 01:08:47.671482+07	2026-06-17 01:30:00.062615+07	ICPC
8	ICPC 2026	Cuộc thi lập trình thuật toán hàng tuần dành cho tất cả các thành viên. Thời gian làm bài 120 phút với 5 bài toán từ dễ đến khó.	\N	2026-06-17 01:20:00+07	2026-06-17 01:30:00+07	ENDED	2	2026-06-17 01:15:37.564316+07	2026-06-17 01:30:00.074384+07	ICPC
9	ICPC 2027	Cuộc thi lập trình thuật toán hàng tuần dành cho tất cả các thành viên. Thời gian làm bài 120 phút với 5 bài toán từ dễ đến khó.	\N	2026-06-17 01:35:00+07	2026-06-17 01:40:00+07	ENDED	2	2026-06-17 01:33:59.019899+07	2026-06-17 01:40:00.029466+07	ICPC
11	ICPC 2029	Cuộc thi lập trình thuật toán hàng tuần dành cho tất cả các thành viên. Thời gian làm bài 120 phút với 5 bài toán từ dễ đến khó.	\N	2026-06-17 01:41:00+07	2026-06-17 01:45:00+07	ENDED	2	2026-06-17 01:39:52.318213+07	2026-06-17 01:45:00.023315+07	ICPC
10	ICPC 2028	Cuộc thi lập trình thuật toán hàng tuần dành cho tất cả các thành viên. Thời gian làm bài 120 phút với 5 bài toán từ dễ đến khó.	\N	2026-06-17 01:40:00+07	2026-06-17 01:45:00+07	ENDED	2	2026-06-17 01:39:04.1047+07	2026-06-17 01:45:00.029451+07	ICPC
12	ICPC 2030	Cuộc thi lập trình thuật toán hàng tuần dành cho tất cả các thành viên. Thời gian làm bài 120 phút với 5 bài toán từ dễ đến khó.	$2a$10$Cu9yrU3RtESw1xbZIDT7lOygtnoXv5NojVEFCzlY3/iZXJWO2VI/W	2026-06-17 01:44:00+07	2026-06-17 01:45:00+07	ENDED	2	2026-06-17 01:42:06.983477+07	2026-06-17 01:45:00.035938+07	ICPC
13	ICPC 2031	Cuộc thi lập trình thuật toán hàng tuần dành cho tất cả các thành viên. Thời gian làm bài 120 phút với 5 bài toán từ dễ đến khó.	$2a$10$rfrbxMYGWBjQu3ERFxQKxuQcNrVPIlUAnjj3GQZ7ozBoyu06.eWim	2026-06-17 02:20:00+07	2026-06-17 03:00:00+07	ENDED	2	2026-06-17 02:15:11.274937+07	2026-06-17 06:48:35.584564+07	ICPC
14	ICPC 9999	Cuộc thi lập trình thuật toán hàng tuần dành cho tất cả các thành viên. Thời gian làm bài 120 phút với 5 bài toán từ dễ đến khó.	$2a$10$B85du2deRlEW6hynsROlgekQZlmszATxoSab2KPnKaDWoBOoyfmLq	2026-06-19 00:40:00+07	2026-06-19 01:40:00+07	ENDED	2	2026-06-19 00:37:19.685815+07	2026-06-19 01:39:59.94478+07	ICPC
15	ICPC 0000	Cuộc thi lập trình thuật toán hàng tuần dành cho tất cả các thành viên. Thời gian làm bài 120 phút với 5 bài toán từ dễ đến khó.	$2a$10$L/u1omKD4IOjJcGhRt9RzO2k5PfV/eFZR.lN7PvTuA/CIG0MA5ziO	2026-06-19 00:55:00+07	2026-06-19 01:55:00+07	ENDED	2	2026-06-19 00:52:48.835063+07	2026-06-19 01:54:59.972055+07	ICPC
16	ICPC 0000	Cuộc thi lập trình thuật toán hàng tuần dành cho tất cả các thành viên. Thời gian làm bài 120 phút với 5 bài toán từ dễ đến khó.	$2a$10$3BNTLAthZDycOlaacIDBcuJaTcQyP03a0supECFL64fiSs6KntRwG	2026-06-19 02:00:00+07	2026-06-19 03:00:00+07	ENDED	2	2026-06-19 01:58:42.017646+07	2026-06-19 05:28:41.265412+07	ICPC
17	ICPC 8080	Cuộc thi lập trình thuật toán hàng tuần dành cho tất cả các thành viên. Thời gian làm bài 120 phút với 5 bài toán từ dễ đến khó.	$2a$10$mijWj9RQfRFW4sZg9xETD.87MOBcLzGrl2v.hry/sK6vig1.DDY4u	2026-06-19 08:05:00+07	2026-06-19 10:05:00+07	ENDED	2	2026-06-19 08:04:32.135137+07	2026-06-19 10:26:09.692026+07	ICPC
21	cc	cc	$2a$10$H7rVZiXlH2Mo2e64Z8ausuE9utcktHSOwE4wGRck6tG03x6UI8356	2026-06-21 04:00:00+07	2026-06-21 08:00:00+07	ENDED	3	2026-06-21 03:39:03.337232+07	2026-06-21 15:21:53.308009+07	ICPC
19	ICPC 8080	Cuộc thi lập trình thuật toán hàng tuần dành cho tất cả các thành viên. Thời gian làm bài 120 phút với 5 bài toán từ dễ đến khó.	$2a$10$6ijYU2EHD6UIEMa66hxp4eeyFn8Y5fTNhmzU./DuM5OLgHbrELJpa	2026-06-21 05:00:00+07	2026-06-21 10:00:00+07	ENDED	3	2026-06-21 03:17:06.192682+07	2026-06-21 15:21:53.31349+07	ICPC
20	test	test	$2a$10$U8JOVh2lM4prROtijHbe3.AURas1iklsUi7KCawlF9OztESP2bWja	2026-06-21 03:20:00+07	2026-06-21 06:20:00+07	ENDED	3	2026-06-21 03:17:33.264989+07	2026-06-21 15:21:53.304358+07	ICPC
18	ICPC 8080	Cuộc thi lập trình thuật toán hàng tuần dành cho tất cả các thành viên. Thời gian làm bài 120 phút với 5 bài toán từ dễ đến khó.	$2a$10$TymqPX7klmsLDfk5Yaqz4uSiqjOvFbuMbg5YW0L1iGpGGRvSFNDJS	2026-06-21 05:00:00+07	2026-06-21 10:00:00+07	ENDED	2	2026-06-21 03:12:06.418952+07	2026-06-21 15:21:53.317637+07	ICPC
\.


--
-- Data for Name: course_category_mappings; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.course_category_mappings (course_id, category_id) FROM stdin;
6	6
7	7
8	8
9	9
10	10
\.


--
-- Data for Name: course_reviews; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.course_reviews (id, course_id, user_id, content, rating, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: courses; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.courses (id, title, short_description, course_content, learning_outcomes, course_highlights, technologies_tools, prerequisites, target_audience, completion_benefits, price, thumbnail_url, thumbnail_public_id, estimated_duration_hours, status, created_at, updated_at, average_rating, total_reviews, total_enrolled, total_lessons, total_quizzes, total_assignments, total_online_judge_problems, total_videos) FROM stdin;
10	Cơ sở dữ liệu nâng cao và tối ưu truy vấn SQL	Nắm vững cách viết và tối ưu hóa truy vấn SQL, thiết kế lược đồ CSDL chuẩn.	\N	\N	\N	\N	\N	\N	\N	249000.00	\N	\N	\N	ACTIVE	2026-06-13 23:31:04.732325+07	2026-06-21 16:59:50.011381+07	0	0	1	15	0	0	0	0
6	Lập trình Java căn bản cho người mới bắt đầu	Khóa học cung cấp kiến thức nền tảng vững chắc về ngôn ngữ Java và OOP.	\N	\N	\N	\N	\N	\N	\N	199000.00	\N	\N	\N	ACTIVE	2026-06-13 23:31:04.627699+07	2026-06-17 01:04:08.868752+07	0	0	0	15	1	0	4	1
7	Cấu trúc dữ liệu và giải thuật thực chiến	Luyện tập tư duy giải quyết bài toán thuật toán tối ưu cùng Java và C++.	\N	\N	\N	\N	\N	\N	\N	299000.00	\N	\N	\N	ACTIVE	2026-06-13 23:31:04.666468+07	2026-06-17 01:04:08.868752+07	0	0	0	15	0	0	0	0
8	Thiết kế hệ thống và Microservices với Spring Boot	Xây dựng hệ thống phân tán, có tính mở rộng cao và chịu tải lớn.	\N	\N	\N	\N	\N	\N	\N	499000.00	\N	\N	\N	ACTIVE	2026-06-13 23:31:04.68931+07	2026-06-17 01:04:08.868752+07	0	0	0	15	0	0	0	0
9	Lập trình Web nâng cao với React và Node.js	Xây dựng ứng dụng Web Fullstack hiện đại sử dụng MERN stack.	\N	\N	\N	\N	\N	\N	\N	399000.00	\N	\N	\N	ACTIVE	2026-06-13 23:31:04.713084+07	2026-06-17 01:04:08.868752+07	0	0	0	15	0	0	0	0
\.


--
-- Data for Name: enrollments; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.enrollments (id, user_id, course_id, enrolled_at, status) FROM stdin;
2	5	7	2026-06-13 23:31:04.906875+07	ACTIVE
3	5	8	2026-06-13 23:31:04.910837+07	ACTIVE
1	5	6	2026-06-13 23:31:04.902181+07	COMPLETED
4	5	10	2026-06-21 16:59:50.040739+07	ACTIVE
\.


--
-- Data for Name: invalidated_tokens; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.invalidated_tokens (id, token_jti, expiry_time, created_at) FROM stdin;
1	eabf7728-ce9e-4922-8c1d-e50307ef54e4	2026-06-14 00:22:33+07	2026-06-14 00:12:38.616944+07
2	e18d661e-504e-43d6-b5d1-d86c6a1f40f2	2026-06-14 00:22:44+07	2026-06-14 00:13:02.854054+07
3	4b341f34-a02e-44da-89fa-4eed52384bce	2026-06-16 19:58:44+07	2026-06-16 19:32:22.203827+07
4	ca8cfb22-08bb-4cb3-9b89-c62497019998	2026-06-16 23:10:54+07	2026-06-16 23:01:25.708286+07
5	0c0f8804-20b7-41cc-9ab6-1d14edbe5a52	2026-06-16 23:30:54+07	2026-06-16 23:01:25.709695+07
6	69d79fc4-940c-4f60-89b8-0f6150c009a6	2026-06-16 23:21:31+07	2026-06-16 23:01:45.329344+07
7	1539102b-e72e-4f5c-9b86-2a419d4f961c	2026-06-16 23:41:31+07	2026-06-16 23:01:45.33106+07
8	e017fcea-e808-4a42-96c3-8413ba30c674	2026-06-16 23:41:53+07	2026-06-16 23:25:53.16211+07
9	c8c07b46-62e7-49c1-a4f4-7ccd98390b44	2026-06-17 00:05:53+07	2026-06-16 23:46:07.644294+07
10	320540d8-1946-47af-84a3-8ab6a5edd2f5	2026-06-17 00:26:07+07	2026-06-17 00:06:07.785656+07
11	3ef2f8da-b935-404f-935c-1266b6f9eb46	2026-06-17 00:46:07+07	2026-06-17 00:28:45.321589+07
12	a339d6c4-4c06-49c0-b05a-abbc4f06b7ec	2026-06-17 00:48:45+07	2026-06-17 00:28:47.488681+07
13	aba08bcd-fb41-403e-a74d-7eddb4aa64bb	2026-06-17 01:08:45+07	2026-06-17 00:28:47.491237+07
14	8a36ec52-b0f8-40e6-bdae-320c3227a8f2	2026-06-17 01:08:55+07	2026-06-17 01:02:22.032566+07
15	c762bd55-5acd-42a1-b47d-a3b59c2de1fb	2026-06-17 01:42:22+07	2026-06-17 01:23:03.669974+07
16	19a6872f-351a-44e0-bee9-71c1b75b157d	2026-06-17 02:03:03+07	2026-06-17 01:44:23.801859+07
17	9a4dad4c-2ad9-4e0c-9acd-e7c1e5781245	2026-06-17 02:24:23+07	2026-06-17 02:05:57.3358+07
18	3241ad1d-31c3-4ba3-a8e5-5d6818e8fe18	2026-06-17 02:25:57+07	2026-06-17 02:14:00.188759+07
19	be864705-603d-4d37-aeb2-434de51d4709	2026-06-17 02:45:57+07	2026-06-17 02:14:00.193114+07
20	117c01c0-73a7-4477-b583-08466d934d68	2026-06-17 02:54:28+07	2026-06-17 02:35:04.487066+07
21	a1973a9e-acd6-476d-9ab4-bee95b591972	2026-06-17 02:55:04+07	2026-06-17 02:36:55.756571+07
22	38d757c8-5f65-4226-bacc-55212d94cdda	2026-06-17 03:15:04+07	2026-06-17 02:36:55.758044+07
23	f648af3c-c60c-46b1-8ed3-90f6e44e9049	2026-06-18 23:54:58+07	2026-06-18 23:36:07.703405+07
24	d78ee2ea-7380-41dd-8914-601064c77301	2026-06-19 00:16:07+07	2026-06-18 23:58:24.33985+07
25	bc3cf868-85df-4777-b14d-0852a2ef4e0d	2026-06-19 00:38:24+07	2026-06-19 00:19:45.198096+07
26	11461594-4e2a-4048-b6f9-389f1c1ae9a4	2026-06-19 00:59:45+07	2026-06-19 00:40:08.112323+07
27	90b775df-3ede-49ec-a6c9-f7baabeac31b	2026-06-19 01:20:08+07	2026-06-19 01:01:13.772487+07
28	a2f4f79c-9d42-4be2-bf0c-30b253a5bb9d	2026-06-19 01:21:43+07	2026-06-19 01:14:21.836143+07
29	1c5ca07f-9882-4288-bef0-fceb95f250a5	2026-06-19 01:41:13+07	2026-06-19 01:25:51.189586+07
30	1136f4ea-29a0-4cdf-b1fb-410707a1ae95	2026-06-19 01:45:51+07	2026-06-19 01:30:01.141083+07
31	e96eba78-5330-4705-83fb-c09872999582	2026-06-19 02:05:51+07	2026-06-19 01:30:01.142058+07
32	61a96d61-adf7-42d9-ba53-63f4c1142979	2026-06-19 02:10:04+07	2026-06-19 01:50:53.067805+07
33	4a03dd0e-47c2-45c5-8c73-5dc40445c23c	2026-06-19 05:33:46+07	2026-06-19 05:26:00.532515+07
34	fb29920e-b5d8-42d0-b289-f0074047299f	2026-06-19 05:53:46+07	2026-06-19 05:26:00.535775+07
35	ecccb9ab-a534-4324-a619-71492c4bebd5	2026-06-19 08:42:48+07	2026-06-19 08:23:09.983385+07
36	ad6e0f6c-d180-4cae-9b26-059281975638	2026-06-19 09:03:09+07	2026-06-19 08:43:18.244948+07
37	12edcfb9-e16b-4a1b-803b-985ffd019cc9	2026-06-19 09:23:18+07	2026-06-19 09:19:43.88785+07
38	0ad9af84-6d04-477b-bfaa-1fcd32a5c44c	2026-06-20 15:27:04+07	2026-06-20 15:13:15.676259+07
39	c191419e-07a1-4d96-b018-f07f6ca1f8f2	2026-06-20 15:33:15+07	2026-06-20 15:28:14.804185+07
40	66ce5f8f-f553-4a05-bb5c-95fa7835e36d	2026-06-20 15:53:15+07	2026-06-20 15:28:14.805868+07
41	4645a827-00e3-40b7-9e5d-02e5343f6bb3	2026-06-20 15:48:23+07	2026-06-20 15:34:57.873698+07
42	3cbf6075-58ce-4203-a284-21dc548d8928	2026-06-20 16:08:23+07	2026-06-20 15:34:57.875286+07
43	acc35fd5-7e64-4fea-a061-532482553ffc	2026-06-21 01:38:48+07	2026-06-21 01:19:47.064373+07
44	89f103ec-f94e-411d-a78f-44dad7f390b6	2026-06-21 01:39:54+07	2026-06-21 01:32:56.090927+07
45	85e6103d-ec59-42d7-834d-4fb14eb892e9	2026-06-21 01:59:54+07	2026-06-21 01:32:56.092589+07
46	09e78e0b-1c23-49cb-af95-29a656d3f2c8	2026-06-21 01:52:59+07	2026-06-21 01:36:24.211085+07
47	56c05a77-60c8-4536-9939-87d4d1e10e63	2026-06-21 02:12:59+07	2026-06-21 01:36:24.212045+07
48	712efcf5-e1f2-4a42-8945-eb307fcdf79e	2026-06-21 01:56:25+07	2026-06-21 01:37:24.250511+07
49	05b6d554-f64f-40f7-b0a2-86234152c128	2026-06-21 02:16:25+07	2026-06-21 01:37:24.25226+07
50	f2c4868c-dd07-4640-a7c1-77c873fbcb74	2026-06-21 01:57:25+07	2026-06-21 01:37:41.101484+07
51	a526d890-83d5-4199-a980-4ed550a60850	2026-06-21 02:17:25+07	2026-06-21 01:37:41.103383+07
52	55787348-c056-4627-9276-e21c25eda706	2026-06-21 02:17:49+07	2026-06-21 01:57:58.987466+07
53	96f977e1-7c9a-4cf1-96be-c221ffeebb30	2026-06-21 02:17:58+07	2026-06-21 01:58:01.465171+07
54	c5e4927a-595a-47a9-987e-301c1a468364	2026-06-21 02:37:59+07	2026-06-21 01:58:01.466765+07
55	cb9c06b3-3a93-4381-9fa9-94003c52a75b	2026-06-21 02:18:08+07	2026-06-21 02:00:43.660894+07
56	43464e5e-9cce-46d8-954d-1cae8e05f1c6	2026-06-21 02:38:08+07	2026-06-21 02:00:43.662316+07
57	051efdf7-a516-465a-afc1-3fb8a2e96080	2026-06-21 02:20:50+07	2026-06-21 02:01:17.144975+07
58	26cbbbab-1d19-4913-9062-621ff0d8822b	2026-06-21 02:40:50+07	2026-06-21 02:01:17.146802+07
59	95cbd5ed-ece9-4279-b501-d7dc057892ca	2026-06-21 03:07:43+07	2026-06-21 02:52:51.298183+07
60	2ca21e8f-b903-459f-a103-ff7c2034e311	2026-06-21 03:27:43+07	2026-06-21 02:52:51.301647+07
61	96413374-3c14-4216-80e1-387452c9af96	2026-06-21 03:32:57+07	2026-06-21 03:17:12.438509+07
62	fd5fa51b-47c1-44d9-ac71-bef5a374a477	2026-06-21 03:57:12+07	2026-06-21 03:37:30.868277+07
63	51263419-1215-4c13-b787-3541175e2dbc	2026-06-21 04:17:30+07	2026-06-21 03:58:04.273183+07
64	180c6b31-94a0-4226-98fa-c4f2e0e7f8c1	2026-06-21 04:18:04+07	2026-06-21 04:02:10.909665+07
65	b47984b3-9795-41cd-86db-fc005a62d633	2026-06-21 04:38:04+07	2026-06-21 04:02:10.911151+07
66	6a119188-4cad-4f5b-9e85-c40846b54d97	2026-06-21 16:06:13+07	2026-06-21 15:58:02.784953+07
67	a57295db-7fbf-4a2d-aea0-3cd1edf83ec8	2026-06-21 17:17:29+07	2026-06-21 17:00:40.373343+07
68	77523669-c38e-42dd-84ba-4c9ccf2e842c	2026-06-21 17:37:29+07	2026-06-21 17:00:40.375845+07
69	a93d3d96-f122-483a-b55e-c2f12f3c53f4	2026-06-21 17:40:45+07	2026-06-21 17:23:05.989072+07
70	8b8b48ba-173f-4597-bea8-c9121c05692e	2026-06-21 17:43:05+07	2026-06-21 17:42:46.749776+07
71	bec4c672-0423-4e26-9492-79dd4d3e507f	2026-06-21 18:03:06+07	2026-06-21 17:42:46.753581+07
72	5530ad01-26a3-4dfa-bef9-d6f4aa36a14c	2026-06-21 18:02:57+07	2026-06-21 17:51:13.260649+07
73	58466552-b5c3-479a-b941-b427db7d7162	2026-06-21 18:22:57+07	2026-06-21 17:51:13.26235+07
74	0b15f820-ae48-455f-8bda-d3ec9aa0b53b	2026-06-21 18:12:35+07	2026-06-21 17:53:22.720247+07
75	3fdb371f-9485-4a3f-bed4-70ef8a5e9a77	2026-06-21 18:32:35+07	2026-06-21 17:53:22.722669+07
\.


--
-- Data for Name: lesson_comments; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.lesson_comments (id, lesson_id, user_id, parent_comment_id, content, created_at, updated_at) FROM stdin;
1	77	5	\N	cc	2026-06-17 00:08:42.161852+07	2026-06-17 00:08:42.161852+07
2	77	5	1	cc	2026-06-17 00:08:50.148761+07	2026-06-17 00:08:50.148761+07
3	106	5	\N	cc	2026-06-21 15:30:04.007447+07	2026-06-21 15:30:04.007447+07
4	106	5	3	cc	2026-06-21 15:30:11.724499+07	2026-06-21 15:30:11.724499+07
5	106	5	3	cc	2026-06-21 15:30:18.497023+07	2026-06-21 15:30:18.497023+07
6	76	5	\N	cc	2026-06-21 15:30:39.062891+07	2026-06-21 15:30:39.062891+07
7	76	5	6	cc	2026-06-21 15:30:41.824678+07	2026-06-21 15:30:41.824678+07
8	76	5	\N	cc	2026-06-21 15:30:43.512911+07	2026-06-21 15:30:43.512911+07
\.


--
-- Data for Name: lesson_problems; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.lesson_problems (id, lesson_id, problem_id, order_index) FROM stdin;
1	76	8	1
2	80	9	1
3	85	10	1
4	90	11	1
\.


--
-- Data for Name: lesson_progress; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.lesson_progress (id, user_id, lesson_id, course_id, completed_at) FROM stdin;
9	5	77	6	2026-06-17 00:18:46.037404+07
10	5	76	6	2026-06-17 00:29:05.197386+07
11	5	78	6	2026-06-17 00:29:09.237324+07
12	5	79	6	2026-06-17 00:29:11.8504+07
13	5	82	6	2026-06-17 00:29:23.635077+07
14	5	80	6	2026-06-17 00:29:25.173147+07
15	5	81	6	2026-06-17 00:29:26.260056+07
16	5	83	6	2026-06-17 00:32:45.710084+07
17	5	84	6	2026-06-17 00:32:47.464277+07
18	5	85	6	2026-06-17 00:32:53.071467+07
19	5	86	6	2026-06-17 00:32:56.889454+07
20	5	87	6	2026-06-17 01:07:14.805379+07
21	5	88	6	2026-06-17 01:07:23.950529+07
22	5	89	6	2026-06-19 20:10:37.831073+07
23	5	90	6	2026-06-19 20:10:39.689566+07
24	5	91	7	2026-06-21 04:03:13.422734+07
25	5	92	7	2026-06-21 04:03:15.311321+07
26	5	93	7	2026-06-21 04:03:16.9215+07
\.


--
-- Data for Name: lessons; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.lessons (id, chapter_id, title, description, video_url, video_public_id, theory_content, sample_code, is_trial, order_index, estimated_duration_minutes, status, created_at, updated_at) FROM stdin;
77	26	Bài 2: Nội dung kiến thức cốt lõi phần 2	Mô tả nội dung chi tiết bài học thứ 2 của chương 1	\N	\N	Đây là nội dung lý thuyết chi tiết của bài học. Học viên cần đọc kỹ hướng dẫn trước khi làm bài tập.	\N	f	2	30	ACTIVE	2026-06-13 23:31:04.640098+07	2026-06-13 23:31:04.640098+07
78	26	Bài 3: Nội dung kiến thức cốt lõi phần 3	Mô tả nội dung chi tiết bài học thứ 3 của chương 1	\N	\N	Đây là nội dung lý thuyết chi tiết của bài học. Học viên cần đọc kỹ hướng dẫn trước khi làm bài tập.	\N	f	3	30	ACTIVE	2026-06-13 23:31:04.641004+07	2026-06-13 23:31:04.641004+07
79	27	Bài 4: Nội dung kiến thức cốt lõi phần 1	Mô tả nội dung chi tiết bài học thứ 4 của chương 2	\N	\N	Đây là nội dung lý thuyết chi tiết của bài học. Học viên cần đọc kỹ hướng dẫn trước khi làm bài tập.	\N	f	1	30	ACTIVE	2026-06-13 23:31:04.642921+07	2026-06-13 23:31:04.642921+07
80	27	Bài 5: Nội dung kiến thức cốt lõi phần 2	Mô tả nội dung chi tiết bài học thứ 5 của chương 2	\N	\N	Đây là nội dung lý thuyết chi tiết của bài học. Học viên cần đọc kỹ hướng dẫn trước khi làm bài tập.	\N	f	2	30	ACTIVE	2026-06-13 23:31:04.643696+07	2026-06-13 23:31:04.643696+07
81	27	Bài 6: Nội dung kiến thức cốt lõi phần 3	Mô tả nội dung chi tiết bài học thứ 6 của chương 2	\N	\N	Đây là nội dung lý thuyết chi tiết của bài học. Học viên cần đọc kỹ hướng dẫn trước khi làm bài tập.	\N	f	3	30	ACTIVE	2026-06-13 23:31:04.644403+07	2026-06-13 23:31:04.644403+07
82	28	Bài 7: Nội dung kiến thức cốt lõi phần 1	Mô tả nội dung chi tiết bài học thứ 7 của chương 3	\N	\N	Đây là nội dung lý thuyết chi tiết của bài học. Học viên cần đọc kỹ hướng dẫn trước khi làm bài tập.	\N	f	1	30	ACTIVE	2026-06-13 23:31:04.648663+07	2026-06-13 23:31:04.648663+07
83	28	Bài 8: Nội dung kiến thức cốt lõi phần 2	Mô tả nội dung chi tiết bài học thứ 8 của chương 3	\N	\N	Đây là nội dung lý thuyết chi tiết của bài học. Học viên cần đọc kỹ hướng dẫn trước khi làm bài tập.	\N	f	2	30	ACTIVE	2026-06-13 23:31:04.650634+07	2026-06-13 23:31:04.650634+07
84	28	Bài 9: Nội dung kiến thức cốt lõi phần 3	Mô tả nội dung chi tiết bài học thứ 9 của chương 3	\N	\N	Đây là nội dung lý thuyết chi tiết của bài học. Học viên cần đọc kỹ hướng dẫn trước khi làm bài tập.	\N	f	3	30	ACTIVE	2026-06-13 23:31:04.651742+07	2026-06-13 23:31:04.651742+07
85	29	Bài 10: Nội dung kiến thức cốt lõi phần 1	Mô tả nội dung chi tiết bài học thứ 10 của chương 4	\N	\N	Đây là nội dung lý thuyết chi tiết của bài học. Học viên cần đọc kỹ hướng dẫn trước khi làm bài tập.	\N	f	1	30	ACTIVE	2026-06-13 23:31:04.654186+07	2026-06-13 23:31:04.654186+07
86	29	Bài 11: Nội dung kiến thức cốt lõi phần 2	Mô tả nội dung chi tiết bài học thứ 11 của chương 4	\N	\N	Đây là nội dung lý thuyết chi tiết của bài học. Học viên cần đọc kỹ hướng dẫn trước khi làm bài tập.	\N	f	2	30	ACTIVE	2026-06-13 23:31:04.655589+07	2026-06-13 23:31:04.655589+07
87	29	Bài 12: Nội dung kiến thức cốt lõi phần 3	Mô tả nội dung chi tiết bài học thứ 12 của chương 4	\N	\N	Đây là nội dung lý thuyết chi tiết của bài học. Học viên cần đọc kỹ hướng dẫn trước khi làm bài tập.	\N	f	3	30	ACTIVE	2026-06-13 23:31:04.656349+07	2026-06-13 23:31:04.656349+07
88	30	Bài 13: Nội dung kiến thức cốt lõi phần 1	Mô tả nội dung chi tiết bài học thứ 13 của chương 5	\N	\N	Đây là nội dung lý thuyết chi tiết của bài học. Học viên cần đọc kỹ hướng dẫn trước khi làm bài tập.	\N	f	1	30	ACTIVE	2026-06-13 23:31:04.662146+07	2026-06-13 23:31:04.662146+07
89	30	Bài 14: Nội dung kiến thức cốt lõi phần 2	Mô tả nội dung chi tiết bài học thứ 14 của chương 5	\N	\N	Đây là nội dung lý thuyết chi tiết của bài học. Học viên cần đọc kỹ hướng dẫn trước khi làm bài tập.	\N	f	2	30	ACTIVE	2026-06-13 23:31:04.664263+07	2026-06-13 23:31:04.664263+07
90	30	Bài 15: Nội dung kiến thức cốt lõi phần 3	Mô tả nội dung chi tiết bài học thứ 15 của chương 5	\N	\N	Đây là nội dung lý thuyết chi tiết của bài học. Học viên cần đọc kỹ hướng dẫn trước khi làm bài tập.	\N	f	3	30	ACTIVE	2026-06-13 23:31:04.665162+07	2026-06-13 23:31:04.665162+07
91	31	Bài 1: Nội dung kiến thức cốt lõi phần 1	Mô tả nội dung chi tiết bài học thứ 1 của chương 1	\N	\N	Đây là nội dung lý thuyết chi tiết của bài học. Học viên cần đọc kỹ hướng dẫn trước khi làm bài tập.	\N	t	1	30	ACTIVE	2026-06-13 23:31:04.669468+07	2026-06-13 23:31:04.669468+07
92	31	Bài 2: Nội dung kiến thức cốt lõi phần 2	Mô tả nội dung chi tiết bài học thứ 2 của chương 1	\N	\N	Đây là nội dung lý thuyết chi tiết của bài học. Học viên cần đọc kỹ hướng dẫn trước khi làm bài tập.	\N	f	2	30	ACTIVE	2026-06-13 23:31:04.671503+07	2026-06-13 23:31:04.671503+07
93	31	Bài 3: Nội dung kiến thức cốt lõi phần 3	Mô tả nội dung chi tiết bài học thứ 3 của chương 1	\N	\N	Đây là nội dung lý thuyết chi tiết của bài học. Học viên cần đọc kỹ hướng dẫn trước khi làm bài tập.	\N	f	3	30	ACTIVE	2026-06-13 23:31:04.673828+07	2026-06-13 23:31:04.673828+07
94	32	Bài 4: Nội dung kiến thức cốt lõi phần 1	Mô tả nội dung chi tiết bài học thứ 4 của chương 2	\N	\N	Đây là nội dung lý thuyết chi tiết của bài học. Học viên cần đọc kỹ hướng dẫn trước khi làm bài tập.	\N	f	1	30	ACTIVE	2026-06-13 23:31:04.675444+07	2026-06-13 23:31:04.675444+07
95	32	Bài 5: Nội dung kiến thức cốt lõi phần 2	Mô tả nội dung chi tiết bài học thứ 5 của chương 2	\N	\N	Đây là nội dung lý thuyết chi tiết của bài học. Học viên cần đọc kỹ hướng dẫn trước khi làm bài tập.	\N	f	2	30	ACTIVE	2026-06-13 23:31:04.67617+07	2026-06-13 23:31:04.67617+07
96	32	Bài 6: Nội dung kiến thức cốt lõi phần 3	Mô tả nội dung chi tiết bài học thứ 6 của chương 2	\N	\N	Đây là nội dung lý thuyết chi tiết của bài học. Học viên cần đọc kỹ hướng dẫn trước khi làm bài tập.	\N	f	3	30	ACTIVE	2026-06-13 23:31:04.676842+07	2026-06-13 23:31:04.676842+07
97	33	Bài 7: Nội dung kiến thức cốt lõi phần 1	Mô tả nội dung chi tiết bài học thứ 7 của chương 3	\N	\N	Đây là nội dung lý thuyết chi tiết của bài học. Học viên cần đọc kỹ hướng dẫn trước khi làm bài tập.	\N	f	1	30	ACTIVE	2026-06-13 23:31:04.677965+07	2026-06-13 23:31:04.677965+07
98	33	Bài 8: Nội dung kiến thức cốt lõi phần 2	Mô tả nội dung chi tiết bài học thứ 8 của chương 3	\N	\N	Đây là nội dung lý thuyết chi tiết của bài học. Học viên cần đọc kỹ hướng dẫn trước khi làm bài tập.	\N	f	2	30	ACTIVE	2026-06-13 23:31:04.678626+07	2026-06-13 23:31:04.678626+07
99	33	Bài 9: Nội dung kiến thức cốt lõi phần 3	Mô tả nội dung chi tiết bài học thứ 9 của chương 3	\N	\N	Đây là nội dung lý thuyết chi tiết của bài học. Học viên cần đọc kỹ hướng dẫn trước khi làm bài tập.	\N	f	3	30	ACTIVE	2026-06-13 23:31:04.679379+07	2026-06-13 23:31:04.679379+07
100	34	Bài 10: Nội dung kiến thức cốt lõi phần 1	Mô tả nội dung chi tiết bài học thứ 10 của chương 4	\N	\N	Đây là nội dung lý thuyết chi tiết của bài học. Học viên cần đọc kỹ hướng dẫn trước khi làm bài tập.	\N	f	1	30	ACTIVE	2026-06-13 23:31:04.68083+07	2026-06-13 23:31:04.68083+07
101	34	Bài 11: Nội dung kiến thức cốt lõi phần 2	Mô tả nội dung chi tiết bài học thứ 11 của chương 4	\N	\N	Đây là nội dung lý thuyết chi tiết của bài học. Học viên cần đọc kỹ hướng dẫn trước khi làm bài tập.	\N	f	2	30	ACTIVE	2026-06-13 23:31:04.681641+07	2026-06-13 23:31:04.681641+07
102	34	Bài 12: Nội dung kiến thức cốt lõi phần 3	Mô tả nội dung chi tiết bài học thứ 12 của chương 4	\N	\N	Đây là nội dung lý thuyết chi tiết của bài học. Học viên cần đọc kỹ hướng dẫn trước khi làm bài tập.	\N	f	3	30	ACTIVE	2026-06-13 23:31:04.683615+07	2026-06-13 23:31:04.683615+07
103	35	Bài 13: Nội dung kiến thức cốt lõi phần 1	Mô tả nội dung chi tiết bài học thứ 13 của chương 5	\N	\N	Đây là nội dung lý thuyết chi tiết của bài học. Học viên cần đọc kỹ hướng dẫn trước khi làm bài tập.	\N	f	1	30	ACTIVE	2026-06-13 23:31:04.686997+07	2026-06-13 23:31:04.686997+07
104	35	Bài 14: Nội dung kiến thức cốt lõi phần 2	Mô tả nội dung chi tiết bài học thứ 14 của chương 5	\N	\N	Đây là nội dung lý thuyết chi tiết của bài học. Học viên cần đọc kỹ hướng dẫn trước khi làm bài tập.	\N	f	2	30	ACTIVE	2026-06-13 23:31:04.687909+07	2026-06-13 23:31:04.687909+07
105	35	Bài 15: Nội dung kiến thức cốt lõi phần 3	Mô tả nội dung chi tiết bài học thứ 15 của chương 5	\N	\N	Đây là nội dung lý thuyết chi tiết của bài học. Học viên cần đọc kỹ hướng dẫn trước khi làm bài tập.	\N	f	3	30	ACTIVE	2026-06-13 23:31:04.688653+07	2026-06-13 23:31:04.688653+07
106	36	Bài 1: Nội dung kiến thức cốt lõi phần 1	Mô tả nội dung chi tiết bài học thứ 1 của chương 1	\N	\N	Đây là nội dung lý thuyết chi tiết của bài học. Học viên cần đọc kỹ hướng dẫn trước khi làm bài tập.	\N	t	1	30	ACTIVE	2026-06-13 23:31:04.691518+07	2026-06-13 23:31:04.691518+07
107	36	Bài 2: Nội dung kiến thức cốt lõi phần 2	Mô tả nội dung chi tiết bài học thứ 2 của chương 1	\N	\N	Đây là nội dung lý thuyết chi tiết của bài học. Học viên cần đọc kỹ hướng dẫn trước khi làm bài tập.	\N	f	2	30	ACTIVE	2026-06-13 23:31:04.692658+07	2026-06-13 23:31:04.692658+07
108	36	Bài 3: Nội dung kiến thức cốt lõi phần 3	Mô tả nội dung chi tiết bài học thứ 3 của chương 1	\N	\N	Đây là nội dung lý thuyết chi tiết của bài học. Học viên cần đọc kỹ hướng dẫn trước khi làm bài tập.	\N	f	3	30	ACTIVE	2026-06-13 23:31:04.694143+07	2026-06-13 23:31:04.694143+07
109	37	Bài 4: Nội dung kiến thức cốt lõi phần 1	Mô tả nội dung chi tiết bài học thứ 4 của chương 2	\N	\N	Đây là nội dung lý thuyết chi tiết của bài học. Học viên cần đọc kỹ hướng dẫn trước khi làm bài tập.	\N	f	1	30	ACTIVE	2026-06-13 23:31:04.698171+07	2026-06-13 23:31:04.698171+07
110	37	Bài 5: Nội dung kiến thức cốt lõi phần 2	Mô tả nội dung chi tiết bài học thứ 5 của chương 2	\N	\N	Đây là nội dung lý thuyết chi tiết của bài học. Học viên cần đọc kỹ hướng dẫn trước khi làm bài tập.	\N	f	2	30	ACTIVE	2026-06-13 23:31:04.701369+07	2026-06-13 23:31:04.701369+07
111	37	Bài 6: Nội dung kiến thức cốt lõi phần 3	Mô tả nội dung chi tiết bài học thứ 6 của chương 2	\N	\N	Đây là nội dung lý thuyết chi tiết của bài học. Học viên cần đọc kỹ hướng dẫn trước khi làm bài tập.	\N	f	3	30	ACTIVE	2026-06-13 23:31:04.702047+07	2026-06-13 23:31:04.702047+07
112	38	Bài 7: Nội dung kiến thức cốt lõi phần 1	Mô tả nội dung chi tiết bài học thứ 7 của chương 3	\N	\N	Đây là nội dung lý thuyết chi tiết của bài học. Học viên cần đọc kỹ hướng dẫn trước khi làm bài tập.	\N	f	1	30	ACTIVE	2026-06-13 23:31:04.703102+07	2026-06-13 23:31:04.703102+07
113	38	Bài 8: Nội dung kiến thức cốt lõi phần 2	Mô tả nội dung chi tiết bài học thứ 8 của chương 3	\N	\N	Đây là nội dung lý thuyết chi tiết của bài học. Học viên cần đọc kỹ hướng dẫn trước khi làm bài tập.	\N	f	2	30	ACTIVE	2026-06-13 23:31:04.703793+07	2026-06-13 23:31:04.703793+07
114	38	Bài 9: Nội dung kiến thức cốt lõi phần 3	Mô tả nội dung chi tiết bài học thứ 9 của chương 3	\N	\N	Đây là nội dung lý thuyết chi tiết của bài học. Học viên cần đọc kỹ hướng dẫn trước khi làm bài tập.	\N	f	3	30	ACTIVE	2026-06-13 23:31:04.704522+07	2026-06-13 23:31:04.704522+07
115	39	Bài 10: Nội dung kiến thức cốt lõi phần 1	Mô tả nội dung chi tiết bài học thứ 10 của chương 4	\N	\N	Đây là nội dung lý thuyết chi tiết của bài học. Học viên cần đọc kỹ hướng dẫn trước khi làm bài tập.	\N	f	1	30	ACTIVE	2026-06-13 23:31:04.706214+07	2026-06-13 23:31:04.706214+07
116	39	Bài 11: Nội dung kiến thức cốt lõi phần 2	Mô tả nội dung chi tiết bài học thứ 11 của chương 4	\N	\N	Đây là nội dung lý thuyết chi tiết của bài học. Học viên cần đọc kỹ hướng dẫn trước khi làm bài tập.	\N	f	2	30	ACTIVE	2026-06-13 23:31:04.707576+07	2026-06-13 23:31:04.707576+07
117	39	Bài 12: Nội dung kiến thức cốt lõi phần 3	Mô tả nội dung chi tiết bài học thứ 12 của chương 4	\N	\N	Đây là nội dung lý thuyết chi tiết của bài học. Học viên cần đọc kỹ hướng dẫn trước khi làm bài tập.	\N	f	3	30	ACTIVE	2026-06-13 23:31:04.70919+07	2026-06-13 23:31:04.70919+07
118	40	Bài 13: Nội dung kiến thức cốt lõi phần 1	Mô tả nội dung chi tiết bài học thứ 13 của chương 5	\N	\N	Đây là nội dung lý thuyết chi tiết của bài học. Học viên cần đọc kỹ hướng dẫn trước khi làm bài tập.	\N	f	1	30	ACTIVE	2026-06-13 23:31:04.710735+07	2026-06-13 23:31:04.710735+07
119	40	Bài 14: Nội dung kiến thức cốt lõi phần 2	Mô tả nội dung chi tiết bài học thứ 14 của chương 5	\N	\N	Đây là nội dung lý thuyết chi tiết của bài học. Học viên cần đọc kỹ hướng dẫn trước khi làm bài tập.	\N	f	2	30	ACTIVE	2026-06-13 23:31:04.711577+07	2026-06-13 23:31:04.711577+07
120	40	Bài 15: Nội dung kiến thức cốt lõi phần 3	Mô tả nội dung chi tiết bài học thứ 15 của chương 5	\N	\N	Đây là nội dung lý thuyết chi tiết của bài học. Học viên cần đọc kỹ hướng dẫn trước khi làm bài tập.	\N	f	3	30	ACTIVE	2026-06-13 23:31:04.712397+07	2026-06-13 23:31:04.712397+07
121	41	Bài 1: Nội dung kiến thức cốt lõi phần 1	Mô tả nội dung chi tiết bài học thứ 1 của chương 1	\N	\N	Đây là nội dung lý thuyết chi tiết của bài học. Học viên cần đọc kỹ hướng dẫn trước khi làm bài tập.	\N	t	1	30	ACTIVE	2026-06-13 23:31:04.715896+07	2026-06-13 23:31:04.715896+07
122	41	Bài 2: Nội dung kiến thức cốt lõi phần 2	Mô tả nội dung chi tiết bài học thứ 2 của chương 1	\N	\N	Đây là nội dung lý thuyết chi tiết của bài học. Học viên cần đọc kỹ hướng dẫn trước khi làm bài tập.	\N	f	2	30	ACTIVE	2026-06-13 23:31:04.716735+07	2026-06-13 23:31:04.716735+07
123	41	Bài 3: Nội dung kiến thức cốt lõi phần 3	Mô tả nội dung chi tiết bài học thứ 3 của chương 1	\N	\N	Đây là nội dung lý thuyết chi tiết của bài học. Học viên cần đọc kỹ hướng dẫn trước khi làm bài tập.	\N	f	3	30	ACTIVE	2026-06-13 23:31:04.718611+07	2026-06-13 23:31:04.718611+07
124	42	Bài 4: Nội dung kiến thức cốt lõi phần 1	Mô tả nội dung chi tiết bài học thứ 4 của chương 2	\N	\N	Đây là nội dung lý thuyết chi tiết của bài học. Học viên cần đọc kỹ hướng dẫn trước khi làm bài tập.	\N	f	1	30	ACTIVE	2026-06-13 23:31:04.72097+07	2026-06-13 23:31:04.72097+07
125	42	Bài 5: Nội dung kiến thức cốt lõi phần 2	Mô tả nội dung chi tiết bài học thứ 5 của chương 2	\N	\N	Đây là nội dung lý thuyết chi tiết của bài học. Học viên cần đọc kỹ hướng dẫn trước khi làm bài tập.	\N	f	2	30	ACTIVE	2026-06-13 23:31:04.721847+07	2026-06-13 23:31:04.721847+07
126	42	Bài 6: Nội dung kiến thức cốt lõi phần 3	Mô tả nội dung chi tiết bài học thứ 6 của chương 2	\N	\N	Đây là nội dung lý thuyết chi tiết của bài học. Học viên cần đọc kỹ hướng dẫn trước khi làm bài tập.	\N	f	3	30	ACTIVE	2026-06-13 23:31:04.72263+07	2026-06-13 23:31:04.72263+07
127	43	Bài 7: Nội dung kiến thức cốt lõi phần 1	Mô tả nội dung chi tiết bài học thứ 7 của chương 3	\N	\N	Đây là nội dung lý thuyết chi tiết của bài học. Học viên cần đọc kỹ hướng dẫn trước khi làm bài tập.	\N	f	1	30	ACTIVE	2026-06-13 23:31:04.723958+07	2026-06-13 23:31:04.723958+07
128	43	Bài 8: Nội dung kiến thức cốt lõi phần 2	Mô tả nội dung chi tiết bài học thứ 8 của chương 3	\N	\N	Đây là nội dung lý thuyết chi tiết của bài học. Học viên cần đọc kỹ hướng dẫn trước khi làm bài tập.	\N	f	2	30	ACTIVE	2026-06-13 23:31:04.724567+07	2026-06-13 23:31:04.724567+07
129	43	Bài 9: Nội dung kiến thức cốt lõi phần 3	Mô tả nội dung chi tiết bài học thứ 9 của chương 3	\N	\N	Đây là nội dung lý thuyết chi tiết của bài học. Học viên cần đọc kỹ hướng dẫn trước khi làm bài tập.	\N	f	3	30	ACTIVE	2026-06-13 23:31:04.725341+07	2026-06-13 23:31:04.725341+07
130	44	Bài 10: Nội dung kiến thức cốt lõi phần 1	Mô tả nội dung chi tiết bài học thứ 10 của chương 4	\N	\N	Đây là nội dung lý thuyết chi tiết của bài học. Học viên cần đọc kỹ hướng dẫn trước khi làm bài tập.	\N	f	1	30	ACTIVE	2026-06-13 23:31:04.726163+07	2026-06-13 23:31:04.726163+07
131	44	Bài 11: Nội dung kiến thức cốt lõi phần 2	Mô tả nội dung chi tiết bài học thứ 11 của chương 4	\N	\N	Đây là nội dung lý thuyết chi tiết của bài học. Học viên cần đọc kỹ hướng dẫn trước khi làm bài tập.	\N	f	2	30	ACTIVE	2026-06-13 23:31:04.726561+07	2026-06-13 23:31:04.726561+07
132	44	Bài 12: Nội dung kiến thức cốt lõi phần 3	Mô tả nội dung chi tiết bài học thứ 12 của chương 4	\N	\N	Đây là nội dung lý thuyết chi tiết của bài học. Học viên cần đọc kỹ hướng dẫn trước khi làm bài tập.	\N	f	3	30	ACTIVE	2026-06-13 23:31:04.726968+07	2026-06-13 23:31:04.726968+07
133	45	Bài 13: Nội dung kiến thức cốt lõi phần 1	Mô tả nội dung chi tiết bài học thứ 13 của chương 5	\N	\N	Đây là nội dung lý thuyết chi tiết của bài học. Học viên cần đọc kỹ hướng dẫn trước khi làm bài tập.	\N	f	1	30	ACTIVE	2026-06-13 23:31:04.727815+07	2026-06-13 23:31:04.727815+07
134	45	Bài 14: Nội dung kiến thức cốt lõi phần 2	Mô tả nội dung chi tiết bài học thứ 14 của chương 5	\N	\N	Đây là nội dung lý thuyết chi tiết của bài học. Học viên cần đọc kỹ hướng dẫn trước khi làm bài tập.	\N	f	2	30	ACTIVE	2026-06-13 23:31:04.728392+07	2026-06-13 23:31:04.728392+07
135	45	Bài 15: Nội dung kiến thức cốt lõi phần 3	Mô tả nội dung chi tiết bài học thứ 15 của chương 5	\N	\N	Đây là nội dung lý thuyết chi tiết của bài học. Học viên cần đọc kỹ hướng dẫn trước khi làm bài tập.	\N	f	3	30	ACTIVE	2026-06-13 23:31:04.730179+07	2026-06-13 23:31:04.730179+07
136	46	Bài 1: Nội dung kiến thức cốt lõi phần 1	Mô tả nội dung chi tiết bài học thứ 1 của chương 1	\N	\N	Đây là nội dung lý thuyết chi tiết của bài học. Học viên cần đọc kỹ hướng dẫn trước khi làm bài tập.	\N	t	1	30	ACTIVE	2026-06-13 23:31:04.735045+07	2026-06-13 23:31:04.735045+07
137	46	Bài 2: Nội dung kiến thức cốt lõi phần 2	Mô tả nội dung chi tiết bài học thứ 2 của chương 1	\N	\N	Đây là nội dung lý thuyết chi tiết của bài học. Học viên cần đọc kỹ hướng dẫn trước khi làm bài tập.	\N	f	2	30	ACTIVE	2026-06-13 23:31:04.737102+07	2026-06-13 23:31:04.737102+07
138	46	Bài 3: Nội dung kiến thức cốt lõi phần 3	Mô tả nội dung chi tiết bài học thứ 3 của chương 1	\N	\N	Đây là nội dung lý thuyết chi tiết của bài học. Học viên cần đọc kỹ hướng dẫn trước khi làm bài tập.	\N	f	3	30	ACTIVE	2026-06-13 23:31:04.737893+07	2026-06-13 23:31:04.737893+07
139	47	Bài 4: Nội dung kiến thức cốt lõi phần 1	Mô tả nội dung chi tiết bài học thứ 4 của chương 2	\N	\N	Đây là nội dung lý thuyết chi tiết của bài học. Học viên cần đọc kỹ hướng dẫn trước khi làm bài tập.	\N	f	1	30	ACTIVE	2026-06-13 23:31:04.739526+07	2026-06-13 23:31:04.739526+07
140	47	Bài 5: Nội dung kiến thức cốt lõi phần 2	Mô tả nội dung chi tiết bài học thứ 5 của chương 2	\N	\N	Đây là nội dung lý thuyết chi tiết của bài học. Học viên cần đọc kỹ hướng dẫn trước khi làm bài tập.	\N	f	2	30	ACTIVE	2026-06-13 23:31:04.743867+07	2026-06-13 23:31:04.743867+07
141	47	Bài 6: Nội dung kiến thức cốt lõi phần 3	Mô tả nội dung chi tiết bài học thứ 6 của chương 2	\N	\N	Đây là nội dung lý thuyết chi tiết của bài học. Học viên cần đọc kỹ hướng dẫn trước khi làm bài tập.	\N	f	3	30	ACTIVE	2026-06-13 23:31:04.744608+07	2026-06-13 23:31:04.744608+07
142	48	Bài 7: Nội dung kiến thức cốt lõi phần 1	Mô tả nội dung chi tiết bài học thứ 7 của chương 3	\N	\N	Đây là nội dung lý thuyết chi tiết của bài học. Học viên cần đọc kỹ hướng dẫn trước khi làm bài tập.	\N	f	1	30	ACTIVE	2026-06-13 23:31:04.745843+07	2026-06-13 23:31:04.745843+07
143	48	Bài 8: Nội dung kiến thức cốt lõi phần 2	Mô tả nội dung chi tiết bài học thứ 8 của chương 3	\N	\N	Đây là nội dung lý thuyết chi tiết của bài học. Học viên cần đọc kỹ hướng dẫn trước khi làm bài tập.	\N	f	2	30	ACTIVE	2026-06-13 23:31:04.746608+07	2026-06-13 23:31:04.746608+07
144	48	Bài 9: Nội dung kiến thức cốt lõi phần 3	Mô tả nội dung chi tiết bài học thứ 9 của chương 3	\N	\N	Đây là nội dung lý thuyết chi tiết của bài học. Học viên cần đọc kỹ hướng dẫn trước khi làm bài tập.	\N	f	3	30	ACTIVE	2026-06-13 23:31:04.747451+07	2026-06-13 23:31:04.747451+07
145	49	Bài 10: Nội dung kiến thức cốt lõi phần 1	Mô tả nội dung chi tiết bài học thứ 10 của chương 4	\N	\N	Đây là nội dung lý thuyết chi tiết của bài học. Học viên cần đọc kỹ hướng dẫn trước khi làm bài tập.	\N	f	1	30	ACTIVE	2026-06-13 23:31:04.748787+07	2026-06-13 23:31:04.748787+07
146	49	Bài 11: Nội dung kiến thức cốt lõi phần 2	Mô tả nội dung chi tiết bài học thứ 11 của chương 4	\N	\N	Đây là nội dung lý thuyết chi tiết của bài học. Học viên cần đọc kỹ hướng dẫn trước khi làm bài tập.	\N	f	2	30	ACTIVE	2026-06-13 23:31:04.749551+07	2026-06-13 23:31:04.749551+07
147	49	Bài 12: Nội dung kiến thức cốt lõi phần 3	Mô tả nội dung chi tiết bài học thứ 12 của chương 4	\N	\N	Đây là nội dung lý thuyết chi tiết của bài học. Học viên cần đọc kỹ hướng dẫn trước khi làm bài tập.	\N	f	3	30	ACTIVE	2026-06-13 23:31:04.750258+07	2026-06-13 23:31:04.750258+07
148	50	Bài 13: Nội dung kiến thức cốt lõi phần 1	Mô tả nội dung chi tiết bài học thứ 13 của chương 5	\N	\N	Đây là nội dung lý thuyết chi tiết của bài học. Học viên cần đọc kỹ hướng dẫn trước khi làm bài tập.	\N	f	1	30	ACTIVE	2026-06-13 23:31:04.754122+07	2026-06-13 23:31:04.754122+07
149	50	Bài 14: Nội dung kiến thức cốt lõi phần 2	Mô tả nội dung chi tiết bài học thứ 14 của chương 5	\N	\N	Đây là nội dung lý thuyết chi tiết của bài học. Học viên cần đọc kỹ hướng dẫn trước khi làm bài tập.	\N	f	2	30	ACTIVE	2026-06-13 23:31:04.755892+07	2026-06-13 23:31:04.755892+07
150	50	Bài 15: Nội dung kiến thức cốt lõi phần 3	Mô tả nội dung chi tiết bài học thứ 15 của chương 5	\N	\N	Đây là nội dung lý thuyết chi tiết của bài học. Học viên cần đọc kỹ hướng dẫn trước khi làm bài tập.	\N	f	3	30	ACTIVE	2026-06-13 23:31:04.75675+07	2026-06-13 23:31:04.75675+07
76	26	Bài 1: Nội dung kiến thức cốt lõi phần 1	Mô tả nội dung chi tiết bài học thứ 1 của chương 1	https://www.youtube.com/watch?v=eZx4ttgIT8A&list=RDeZx4ttgIT8A&start_radio=1&t=312s	\N	Đây là nội dung lý thuyết chi tiết của bài học. Học viên cần đọc kỹ hướng dẫn trước khi làm bài tập.	\N	t	1	30	ACTIVE	2026-06-13 23:31:04.638455+07	2026-06-16 22:54:59.687549+07
\.


--
-- Data for Name: online_judge_problems; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.online_judge_problems (id, title, description, input_description, output_description, constraints, example_input, example_output, hint, problem_scope, difficulty, is_active, created_by_teacher_id, created_at, updated_at, total_testcase, time_limit_ms, memory_limit_kb, is_public, total_submissions, total_accepted, score) FROM stdin;
5	Tìm số nguyên tố tiếp theo	Cho một số nguyên dương N. Hãy tìm số nguyên tố nhỏ nhất lớn hơn N.	Một số nguyên dương N (1 <= N <= 10^6).	Số nguyên tố nhỏ nhất lớn hơn N.	N <= 1,000,000	14	17	Bắt đầu kiểm tra từ N + 1, tăng dần và viết hàm kiểm tra số nguyên tố.	CONTEST	EASY	t	2	2026-06-13 23:31:04.84462+07	2026-06-19 01:30:09.111213+07	18	2000	128000	t	19	9	10.00
2	Tính tổng hai số nguyên	Viết chương trình nhận vào hai số nguyên a và b từ bàn phím. In ra tổng của hai số đó.	Một dòng chứa hai số nguyên a và b (-10^9 <= a, b <= 10^9).	Một số nguyên duy nhất là tổng của a và b.	Thời gian chạy: 1s, Bộ nhớ: 64MB	3 5	8	Sử dụng kiểu dữ liệu long nếu tổng vượt quá giới hạn của kiểu int.	PRACTICE	EASY	t	2	2026-06-13 23:31:04.823028+07	2026-06-21 15:27:35.508823+07	100	2000	128000	t	50	35	10.00
3	Tìm số lớn nhất trong mảng	Cho một mảng gồm N số nguyên. Hãy tìm số có giá trị lớn nhất trong mảng.	Dòng đầu tiên chứa số nguyên N (1 <= N <= 10^5).\nDòng thứ hai chứa N số nguyên phân tách bởi dấu cách.	In ra số lớn nhất tìm được.	N <= 100,000	5\n1 5 3 9 2	9	Khởi tạo giá trị max bằng phần tử đầu tiên, sau đó duyệt qua toàn bộ mảng để cập nhật max.	PRACTICE	EASY	t	2	2026-06-13 23:31:04.837773+07	2026-06-21 15:28:19.735128+07	2	2000	128000	t	12	10	10.00
6	Ước số chung lớn nhất (GCD)	Tìm ước số chung lớn nhất của hai số nguyên dương A và B.	Một dòng chứa hai số nguyên dương A và B (1 <= A, B <= 10^9).	Ước số chung lớn nhất của A và B.	A, B <= 10^9	12 18	6	Sử dụng thuật toán Euclid tìm ước chung lớn nhất để đạt hiệu năng tối ưu.	CONTEST	EASY	t	2	2026-06-13 23:31:04.853447+07	2026-06-19 01:05:06.264076+07	2	2000	128000	t	35	6	10.00
11	Sắp xếp mảng số nguyên	Cho một mảng gồm N số nguyên. Hãy sắp xếp mảng đó theo thứ tự tăng dần.	Dòng đầu chứa N (1 <= N <= 1000).\nDòng thứ hai chứa N số nguyên phân tách bởi dấu cách.	In ra mảng sau khi sắp xếp, các phần tử cách nhau bởi dấu cách.	N <= 1000	5\n4 2 5 1 3	1 2 3 4 5	Sử dụng các thuật toán sắp xếp cơ bản (Bubble sort, Selection sort) hoặc hàm có sẵn Arrays.sort() trong Java.	LESSON	MEDIUM	t	2	2026-06-13 23:31:04.893251+07	2026-06-21 02:54:00.86472+07	2	2000	128000	t	0	0	20.00
4	Kiểm tra chuỗi đối xứng (Palindrome)	Một chuỗi được gọi là đối xứng nếu đọc từ trái sang phải cũng giống như đọc từ phải sang trái. Hãy kiểm tra xem chuỗi S cho trước có đối xứng hay không.	Một dòng chứa chuỗi S chỉ gồm các ký tự chữ cái thường (độ dài không quá 1000).	In ra YES nếu chuỗi đối xứng, ngược lại in ra NO.	Độ dài chuỗi S <= 1000	radar	YES	Sử dụng kỹ thuật hai con trỏ trỏ từ hai đầu chuỗi và so sánh từng ký tự.	PRACTICE	MEDIUM	t	2	2026-06-13 23:31:04.840247+07	2026-06-21 15:28:02.906554+07	2	2000	128000	t	18	10	20.00
9	Tính giai thừa số nguyên	Nhập vào số nguyên dương N. Tính N! (giai thừa của N).	Một số nguyên dương N (1 <= N <= 15).	Giá trị N!.	N <= 15	5	120	Sử dụng vòng lặp hoặc đệ quy. Chú ý kiểu dữ liệu trả về vì giai thừa tăng rất nhanh.	LESSON	EASY	t	2	2026-06-13 23:31:04.884805+07	2026-06-18 23:44:11.130829+07	2	2000	128000	t	1	0	10.00
8	Nhập xuất cơ bản	Nhập vào một chuỗi tên từ bàn phím và in ra câu chào 'Hello [tên]'.	Một dòng chứa chuỗi ký tự biểu diễn tên.	In ra 'Hello ' nối tiếp với tên vừa nhập.	Tên không chứa dấu cách, độ dài không quá 100.	Thanh	Hello Thanh	Sử dụng Scanner hoặc BufferedReader để nhập dữ liệu.	LESSON	EASY	t	2	2026-06-13 23:31:04.873265+07	2026-06-18 23:44:11.130829+07	2	2000	128000	t	2	2	10.00
10	Đảo ngược chuỗi ký tự	Cho một chuỗi ký tự S. Hãy in ra chuỗi đảo ngược của chuỗi S.	Một chuỗi ký tự S bất kỳ.	Chuỗi S sau khi đảo ngược.	Độ dài chuỗi S <= 100	java	avaj	Có thể sử dụng StringBuilder.reverse() trong Java để giải quyết nhanh chóng.	LESSON	EASY	t	2	2026-06-13 23:31:04.889386+07	2026-06-18 23:44:11.130829+07	2	2000	128000	t	0	0	10.00
20	Length of Last Word	Given a string S consisting of words and spaces, return the length of the last word in the string. A word is a maximal substring consisting of non-space characters only.	A single line containing the string S.	Print the length of the last word.	1 <= length of S <= 10^4\nS consists of only English letters and spaces.	Hello World	5	Trim the string to remove trailing spaces, then count characters from the end until you hit a space.	PRACTICE	EASY	t	3	2026-06-21 19:07:34.813811+07	2026-06-21 19:07:34.813811+07	10	2000	128000	t	0	0	100.00
21	Plus One	You are given a large integer represented as an integer array of digits. The digits are ordered from most significant to least significant in left-to-right order. The large integer does not contain any leading 0's. Increment the large integer by one and return the resulting array of digits.	First line contains an integer N (the number of digits).\nSecond line contains N space-separated integers representing the digits.	Print N or N+1 space-separated integers representing the incremented digits.	1 <= N <= 100\n0 <= digits[i] <= 9	3\n1 2 3	1 2 4	Start from the last digit, increment it. If it becomes 10, carry the 1 to the next digit.	PRACTICE	EASY	t	3	2026-06-21 19:07:34.814297+07	2026-06-21 19:07:34.814297+07	10	2000	128000	t	0	0	100.00
22	Climbing Stairs	You are climbing a staircase. It takes N steps to reach the top. Each time you can either climb 1 or 2 steps. In how many distinct ways can you climb to the top?	A single line containing the integer N.	Print the number of distinct ways to reach the top.	1 <= N <= 45	3	3	This problem behaves like the Fibonacci sequence. The number of ways to reach step i is the sum of ways to reach step i-1 and i-2.	PRACTICE	EASY	t	3	2026-06-21 19:07:34.814773+07	2026-06-21 19:07:34.814773+07	10	2000	128000	t	0	0	100.00
23	Best Time to Buy and Sell Stock	You are given an array prices where prices[i] is the price of a given stock on the i-th day. You want to maximize your profit by choosing a single day to buy one stock and choosing a different day in the future to sell that stock. Return the maximum profit you can achieve. If you cannot achieve any profit, return 0.	First line contains N (the number of days).\nSecond line contains N space-separated integers representing the stock prices.	Print the maximum possible profit.	1 <= N <= 10^5\n0 <= prices[i] <= 10^4	6\n7 1 5 3 6 4	5	Keep track of the minimum price seen so far and calculate potential profit on each day.	PRACTICE	EASY	t	3	2026-06-21 19:07:34.81573+07	2026-06-21 19:07:34.81573+07	10	2000	128000	t	0	0	100.00
24	Valid Palindrome	Given a string S, return true if it is a palindrome, or false otherwise. A phrase is a palindrome if, after converting all uppercase characters into lowercase characters and removing all non-alphanumeric characters, it reads the same forward and backward.	A single line containing the string S.	Print true if S is a valid palindrome, otherwise false.	1 <= length of S <= 2 * 10^5\nS consists of printable ASCII characters.	A man, a plan, a canal: Panama	true	Use two pointers, one at the beginning and one at the end. Move them inward, skipping non-alphanumeric characters.	PRACTICE	EASY	t	3	2026-06-21 19:07:34.816307+07	2026-06-21 19:07:34.816307+07	10	2000	128000	t	0	0	100.00
7	Dãy con tăng dài nhất (LIS)	Cho một dãy gồm N số nguyên. Hãy tìm độ dài của dãy con tăng dài nhất (không nhất thiết liên tiếp) trong dãy đó.	Dòng đầu chứa N (1 <= N <= 1000).\nDòng thứ hai chứa N số nguyên phân tách bởi dấu cách.	Một số nguyên duy nhất là độ dài dãy con tăng dài nhất.	N <= 1000	5\n1 3 2 4 5	4	Sử dụng quy hoạch động. Gọi F[i] là độ dài dãy con tăng dài nhất kết thúc tại phần tử thứ i.	CONTEST	HARD	t	2	2026-06-13 23:31:04.863119+07	2026-06-19 01:06:29.958748+07	2	2000	128000	t	14	6	30.00
13	Sum of 3 number	Sum of 3 number	Nhập vào 3 số a, b và c	In ra tổng của 3 số vừa nhập	-10^9 <= a <= b <= c <= 10^9	1 2 3	6		PRACTICE	EASY	t	3	2026-06-21 17:02:38.763143+07	2026-06-21 17:31:52.068469+07	100	1000	262144	t	2	2	10.00
14	Two Sum	Given an array of integers nums and an integer target, return indices of the two numbers such that they add up to target. You may assume that each input would have exactly one solution, and you may not use the same element twice.	First line contains N (size of array) and T (target value) separated by a space.\nSecond line contains N space-separated integers representing the elements of the array.	Print two space-separated 0-based indices of the two elements that add up to target, in ascending order.	2 <= N <= 10^3\n-10^9 <= nums[i] <= 10^9\n-10^9 <= target <= 10^9	4 9\n2 7 11 15	0 1	Try using a hash map to find the complement of each element in O(1) time.	PRACTICE	EASY	t	3	2026-06-21 19:07:34.79203+07	2026-06-21 19:07:34.79203+07	10	2000	128000	t	0	0	100.00
15	Palindrome Number	Given an integer X, determine if X is a palindrome. An integer is a palindrome when it reads the same backward as forward.	A single line containing the integer X.	Print true if X is a palindrome, otherwise print false.	-2^31 <= X <= 2^31 - 1	121	true	Try reversing the entire number or comparing digit by digit. Be careful with negative numbers.	PRACTICE	EASY	t	3	2026-06-21 19:07:34.804654+07	2026-06-21 19:07:34.804654+07	10	2000	128000	t	0	0	100.00
16	Valid Parentheses	Given a string S containing only the characters '(', ')', '{', '}', '[' and ']', determine if the input string is valid.\nAn input string is valid if:\n1. Open brackets must be closed by the same type of brackets.\n2. Open brackets must be closed in the correct order.	A single line containing the parenthesized string S.	Print true if S is valid, otherwise print false.	1 <= length of S <= 10^4	()[]{}	true	Use a stack to keep track of open brackets. Push when you see open brackets, pop and check when you see closed ones.	PRACTICE	EASY	t	3	2026-06-21 19:07:34.809717+07	2026-06-21 19:07:34.809717+07	10	2000	128000	t	0	0	100.00
18	Search Insert Position	Given a sorted array of distinct integers and a target value, return the index if the target is found. If not, return the index where it would be if it were inserted in order.	First line contains N (size of array) and T (target value).\nSecond line contains N space-separated distinct sorted integers.	Print the index of the target or its insertion position.	1 <= N <= 10^4\n-10^4 <= nums[i], target <= 10^4	4 5\n1 3 5 6	2	Try using binary search to achieve O(log N) runtime complexity.	PRACTICE	EASY	t	3	2026-06-21 19:07:34.812526+07	2026-06-21 19:07:34.812526+07	10	2000	128000	t	0	0	100.00
19	Maximum Subarray	Given an integer array nums, find the contiguous subarray (containing at least one number) which has the largest sum and return its sum.	First line contains N (size of array).\nSecond line contains N space-separated integers.	Print the maximum subarray sum.	1 <= N <= 10^5\n-10^4 <= nums[i] <= 10^4	9\n-2 1 -3 4 -1 2 1 -5 4	6	Kadane's algorithm is an elegant O(N) dynamic programming solution.	PRACTICE	MEDIUM	t	3	2026-06-21 19:07:34.813131+07	2026-06-21 19:07:34.813131+07	10	2000	128000	t	0	0	100.00
25	Single Number	Given a non-empty array of integers nums, every element appears twice except for one. Find that single one. You must implement a solution with a linear runtime complexity and use only constant extra space.	First line contains N (size of array).\nSecond line contains N space-separated integers representing the array.	Print the single number.	1 <= N <= 3 * 10^4\n-3 * 10^4 <= nums[i] <= 3 * 10^4	5\n4 1 2 1 2	4	XORing a number with itself yields 0. XORing all elements together will leave only the single number.	PRACTICE	EASY	t	3	2026-06-21 19:07:34.81682+07	2026-06-21 19:07:34.81682+07	10	2000	128000	t	0	0	100.00
26	Fibonacci Number	The Fibonacci numbers, commonly denoted F(n), form a sequence called the Fibonacci sequence, such that each number is the sum of the two preceding ones, starting from 0 and 1. Given N, calculate F(N).	A single line containing the integer N.	Print the N-th Fibonacci number.	0 <= N <= 30	4	3	Compute iteratively using two variables to avoid exponential recursion stack limits.	PRACTICE	EASY	t	3	2026-06-21 19:07:34.817933+07	2026-06-21 19:07:34.817933+07	10	2000	128000	t	0	0	100.00
27	Fizz Buzz	Given an integer N, print a list of strings representing Fizz Buzz up to N.\nFor values 1 to N:\n- Print 'FizzBuzz' if the number is divisible by both 3 and 5.\n- Print 'Fizz' if the number is divisible by 3.\n- Print 'Buzz' if the number is divisible by 5.\n- Print the number itself as a string otherwise.	A single line containing the integer N.	Print N lines, each containing the Fizz Buzz value from 1 to N.	1 <= N <= 10^4	5	1\n2\nFizz\n4\nBuzz	Check divisibility by 15 first, or check 3 and 5 separately and concatenate strings.	PRACTICE	EASY	t	3	2026-06-21 19:07:34.819376+07	2026-06-21 19:07:34.819376+07	10	2000	128000	t	0	0	100.00
29	Container With Most Water	You are given an integer array height of length N. There are N vertical lines drawn such that the two endpoints of the i-th line are (i, 0) and (i, height[i]). Find two lines that together with the x-axis form a container, such that the container contains the most water. Return the maximum amount of water a container can store.	First line contains an integer N (the size of height array).\nSecond line contains N space-separated integers representing the height values.	Print the maximum amount of water.	2 <= N <= 10^5\n0 <= height[i] <= 10^4	9\n1 8 6 2 5 4 8 3 7	49	Use a two-pointer approach, starting from the left and right boundary. Always shrink the side with smaller height.	CONTEST	MEDIUM	t	3	2026-06-21 19:07:34.820855+07	2026-06-21 19:07:34.820855+07	10	2000	128000	t	0	0	100.00
30	3Sum	Given an integer array nums, return all unique triplets [nums[i], nums[j], nums[k]] such that i != j, i != k, and j != k, and nums[i] + nums[j] + nums[k] == 0. The output triplets must be printed in ascending order lexicographically, with one triplet per line.	First line contains an integer N (the size of nums array).\nSecond line contains N space-separated integers representing the array.	Print each triplet on a separate line as space-separated integers. The triplets themselves should be sorted, and the entire set of triplets should be sorted ascending lexicographically.	3 <= N <= 3000\n-10^5 <= nums[i] <= 10^5	6\n-1 0 1 2 -1 -4	-1 -1 2\n-1 0 1	Sort the array first. Then, iterate through the array and use a two-pointer approach to find the other two numbers.	CONTEST	MEDIUM	t	3	2026-06-21 19:07:34.824262+07	2026-06-21 19:07:34.824262+07	10	2000	128000	t	0	0	100.00
31	Longest Substring Without Repeating Characters	Given a string S, find the length of the longest substring without repeating characters.	A single line containing the string S.	Print the length of the longest substring.	0 <= length of S <= 5 * 10^4\nS consists of English letters, digits, symbols and spaces.	abcabcbb	3	Use a sliding window approach with two pointers and a hash map to record the last seen index of each character.	CONTEST	MEDIUM	t	3	2026-06-21 19:07:34.824852+07	2026-06-21 19:07:34.824852+07	10	2000	128000	t	0	0	100.00
32	Subarray Sum Equals K	Given an array of integers nums and an integer K, return the total number of continuous subarrays whose sum equals to K.	First line contains N (size of array) and K (target sum).\nSecond line contains N space-separated integers representing the array.	Print the number of subarrays whose sum is K.	1 <= N <= 2 * 10^4\n-1000 <= nums[i] <= 1000\n-10^7 <= K <= 10^7	3 2\n1 1 1	2	Use a prefix sum map to keep track of prefix sums seen so far. The number of subarrays ending at index i with sum K is prefix_sum[i] - K.	CONTEST	MEDIUM	t	3	2026-06-21 19:07:34.825824+07	2026-06-21 19:07:34.825824+07	10	2000	128000	t	0	0	100.00
33	House Robber	You are a professional robber planning to rob houses along a street. Each house has a certain amount of money stashed, the only constraint stopping you from robbing each of them is that adjacent houses have security systems connected and it will automatically contact the police if two adjacent houses were broken into on the same night. Given an integer array representing the amount of money of each house, return the maximum amount of money you can rob tonight without alerting the police.	First line contains N (the number of houses).\nSecond line contains N space-separated integers representing the stashed money of each house.	Print the maximum amount of money you can rob.	1 <= N <= 100\n0 <= nums[i] <= 400	4\n1 2 3 1	4	Let dp[i] be the max money robbed from the first i houses. dp[i] = max(dp[i-1], dp[i-2] + nums[i]).	CONTEST	MEDIUM	t	3	2026-06-21 19:07:34.826322+07	2026-06-21 19:07:34.826322+07	10	2000	128000	t	0	0	100.00
28	Power of Two	Given an integer N, return true if it is a power of two. Otherwise, return false. An integer N is a power of two if there exists an integer X such that N == 2^X.	A single line containing the integer N.	Print true if N is a power of two, otherwise false.	-2^31 <= N <= 2^31 - 1	16	true	In binary, a power of two has exactly one set bit. You can use (N > 0) && (N & (N - 1)) == 0 to check.	PRACTICE	EASY	t	3	2026-06-21 19:07:34.820056+07	2026-06-21 19:20:31.505828+07	10	2000	128000	t	3	1	100.00
17	Merge Two Sorted Arrays	Given two sorted integer arrays arr1 and arr2 of sizes N and M respectively, merge them into a single sorted array.	First line contains N and M (the sizes of the two arrays).\nSecond line contains N space-separated integers representing arr1.\nThird line contains M space-separated integers representing arr2.	Print N + M space-separated integers representing the merged sorted array.	1 <= N, M <= 1000\n-10^9 <= arr1[i], arr2[i] <= 10^9	3 3\n1 3 5\n2 4 6	1 2 3 4 5 6	Use two pointers, one for each array, to pick the smaller element at each step.	PRACTICE	EASY	t	3	2026-06-21 19:07:34.811122+07	2026-06-21 19:21:34.090831+07	10	2000	128000	t	1	1	100.00
\.


--
-- Data for Name: online_judge_submission_details; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.online_judge_submission_details (id, submission_id, testcase_id, token, verdict, execution_time_ms, memory_used_kb, created_at, compile_output, stderr, stdout) FROM stdin;
5191	316	21	06b2bb9a-97ac-42f7-bdd1-36227b89af74	ACCEPTED	4	876	2026-06-16 19:46:31.283857+07	\N	\N	3\n
5193	316	23	cb255dbf-378b-430b-bde6-9ed5197da4f5	ACCEPTED	5	952	2026-06-16 19:46:31.283883+07	\N	\N	0\n
5197	316	27	16ace6dd-ebe5-4382-8f62-4655fb86b474	ACCEPTED	5	1008	2026-06-16 19:46:31.283894+07	\N	\N	1000\n
5195	316	25	235873c4-c8f7-4673-91b0-b29ebfae8265	ACCEPTED	5	868	2026-06-16 19:46:31.283889+07	\N	\N	300\n
5199	316	29	31f376f2-47e3-4da5-88eb-3c9743fe2001	ACCEPTED	4	876	2026-06-16 19:46:31.283899+07	\N	\N	99\n
5201	316	31	a612d9c4-2cf9-4391-9f45-5db453de2a28	ACCEPTED	5	1024	2026-06-16 19:46:31.283903+07	\N	\N	30000\n
5192	316	22	46a6457d-e55e-4fae-8bf5-bb91bff479e2	ACCEPTED	6	980	2026-06-16 19:46:31.28388+07	\N	\N	30\n
5202	316	32	80200c95-b2f3-4a28-97e9-e845d98a0ebf	ACCEPTED	7	868	2026-06-16 19:46:31.28391+07	\N	\N	0\n
5208	316	38	045eba6e-7a5b-435d-8aa8-4eb33ce32036	ACCEPTED	5	1020	2026-06-16 19:46:31.283924+07	\N	\N	3000000\n
5204	316	34	e04e7775-38d4-4cd9-8fd3-53a1e6c3b8f5	ACCEPTED	7	1016	2026-06-16 19:46:31.283915+07	\N	\N	15\n
5200	316	30	5890e9ae-9b1e-49db-ba51-79547e6d3c26	ACCEPTED	5	872	2026-06-16 19:46:31.283901+07	\N	\N	0\n
5196	316	26	b3327a78-417c-451a-bf7a-323ede792765	ACCEPTED	4	932	2026-06-16 19:46:31.283891+07	\N	\N	-30\n
5194	316	24	5cdd2caa-7d04-47dd-bf86-52c95fd494f0	ACCEPTED	7	1012	2026-06-16 19:46:31.283886+07	\N	\N	0\n
5203	316	33	d3800882-cece-4b71-a6c9-b0051fc6c2d4	ACCEPTED	5	1028	2026-06-16 19:46:31.283913+07	\N	\N	84\n
5198	316	28	2f993805-473b-4660-9194-da65d3b669c5	ACCEPTED	5	1064	2026-06-16 19:46:31.283896+07	\N	\N	579\n
5205	316	35	56a3b0db-0aa1-4205-a00f-53969ca76648	ACCEPTED	4	912	2026-06-16 19:46:31.283917+07	\N	\N	-2\n
5206	316	36	a0fc8911-b078-45a1-982a-64dafd39cc28	ACCEPTED	4	1044	2026-06-16 19:46:31.28392+07	\N	\N	801\n
5207	316	37	ec564273-0e07-46a6-884b-c5fdb41c7d31	ACCEPTED	5	864	2026-06-16 19:46:31.283922+07	\N	\N	1000\n
5210	317	40	8625bfa9-1603-4d3b-ae1c-1ffd5a0f558d	ACCEPTED	6	868	2026-06-16 19:46:42.981063+07	\N	\N	2\n
5221	317	51	1e119782-8f5c-4a59-bba5-e67224df56de	ACCEPTED	6	872	2026-06-16 19:46:42.981087+07	\N	\N	10007\n
5212	317	42	d2a7fe37-f71a-46f6-a181-e8d132f2f0d7	ACCEPTED	6	1032	2026-06-16 19:46:42.981069+07	\N	\N	5\n
5214	317	44	f2b2a17c-0a6d-41c8-b867-3e4b87ff1700	ACCEPTED	5	836	2026-06-16 19:46:42.981073+07	\N	\N	11\n
5219	317	49	a477801c-d813-4a60-a686-17d03587d62c	ACCEPTED	4	1020	2026-06-16 19:46:42.981083+07	\N	\N	1009\n
5211	317	41	f103be23-12ac-479c-b55f-90eb02ff903b	ACCEPTED	5	864	2026-06-16 19:46:42.981067+07	\N	\N	3\n
5223	317	53	ae3d7021-7547-4bfb-a91b-6f0bb0f8df3c	ACCEPTED	4	1016	2026-06-16 19:46:42.98109+07	\N	\N	100003\n
5222	317	52	033c241b-c3c1-4941-b949-4a49ccf722bb	ACCEPTED	4	1032	2026-06-16 19:46:42.981089+07	\N	\N	100003\n
5215	317	45	290059e9-e2ed-43e1-84a2-e6de46593b82	ACCEPTED	5	1020	2026-06-16 19:46:42.981075+07	\N	\N	11\n
5216	317	46	15ff75f1-5833-4e9a-aad9-98d8c33f12cd	ACCEPTED	5	980	2026-06-16 19:46:42.981077+07	\N	\N	23\n
5226	317	56	e4d4c2d3-8b9b-414f-aebf-7d94122134f8	ACCEPTED	5	1020	2026-06-16 19:46:42.981096+07	\N	\N	1000003\n
5218	317	48	6b9ce409-2cb9-4a34-afef-a14632e88884	ACCEPTED	4	864	2026-06-16 19:46:42.981081+07	\N	\N	101\n
5217	317	47	7db62283-ca43-4604-aa48-0c3c38801777	ACCEPTED	4	1016	2026-06-16 19:46:42.981079+07	\N	\N	101\n
5220	317	50	9f292445-ef14-485a-8697-e350446bbde9	ACCEPTED	6	872	2026-06-16 19:46:42.981085+07	\N	\N	1009\n
5209	317	39	07732a17-431d-4b30-9777-253841301fc2	ACCEPTED	4	1012	2026-06-16 19:46:42.981021+07	\N	\N	17\n
5225	317	55	ad2dd495-bd6e-4f30-865c-3fd984331b95	ACCEPTED	5	880	2026-06-16 19:46:42.981094+07	\N	\N	1000003\n
5213	317	43	2731ad9b-2007-40e2-af10-ad817d3a16fe	ACCEPTED	4	1056	2026-06-16 19:46:42.981071+07	\N	\N	5\n
5224	317	54	34b7662e-6201-4efd-a657-bf607f27b0fa	ACCEPTED	4	1116	2026-06-16 19:46:42.981092+07	\N	\N	500009\n
5228	318	40	c7dadf4e-721c-48ad-94e9-851791fa7957	ACCEPTED	5	1040	2026-06-16 19:47:15.380864+07	\N	\N	2\n
5232	318	44	b3b29be5-10ed-4c95-aba1-f16d101050eb	ACCEPTED	4	920	2026-06-16 19:47:15.380871+07	\N	\N	11\n
5231	318	43	5a135629-de40-4b0b-b87c-7f07201db933	ACCEPTED	4	972	2026-06-16 19:47:15.38087+07	\N	\N	5\n
5237	318	49	2173d421-5c4c-4cfe-8671-d7f50681bf7d	WRONG_ANSWER	4	1080	2026-06-16 19:47:15.380878+07	\N	\N	1007\n
5238	318	50	8c39b9e8-1fe7-4d5d-b628-3ce7bc43f138	WRONG_ANSWER	4	1104	2026-06-16 19:47:15.38088+07	\N	\N	1007\n
5234	318	46	ae34297b-bada-4720-a5c3-683f03949c01	ACCEPTED	6	892	2026-06-16 19:47:15.380874+07	\N	\N	23\n
5236	318	48	bbc79568-3cdd-47a5-aad8-ec0be7b84416	ACCEPTED	5	1016	2026-06-16 19:47:15.380877+07	\N	\N	101\n
5233	318	45	fbc9429f-76b8-4a8c-b6bc-3ea3b5e68184	ACCEPTED	4	884	2026-06-16 19:47:15.380873+07	\N	\N	11\n
5227	318	39	2335188f-591b-41f8-a764-896e03a239db	ACCEPTED	5	864	2026-06-16 19:47:15.380856+07	\N	\N	17\n
5241	318	53	636dcfc9-389c-4d28-8e8e-6a6db40d37eb	ACCEPTED	4	1012	2026-06-16 19:47:15.380884+07	\N	\N	100003\n
5240	318	52	2cf8a5a8-c2c7-4c5f-8e58-2718c5a2bb18	ACCEPTED	4	1024	2026-06-16 19:47:15.380882+07	\N	\N	100003\n
5229	318	41	caa0073b-f8f7-407a-a5c7-15438c249c7c	ACCEPTED	5	1084	2026-06-16 19:47:15.380865+07	\N	\N	3\n
5235	318	47	b7efc1c7-46a6-41dc-b7ae-9d15b5d7c139	ACCEPTED	8	1020	2026-06-16 19:47:15.380876+07	\N	\N	101\n
5242	318	54	7a05017c-ef4e-4cb5-b3c6-4d70487ba43e	WRONG_ANSWER	4	1056	2026-06-16 19:47:15.380885+07	\N	\N	500003\n
5239	318	51	44498995-e9fc-4ea9-b848-bcd20ae4d2c3	WRONG_ANSWER	3	1024	2026-06-16 19:47:15.380881+07	\N	\N	10001\n
5230	318	42	f11cea76-fa4a-434e-a7fd-40ceec3c29cd	ACCEPTED	4	992	2026-06-16 19:47:15.380867+07	\N	\N	5\n
5417	357	13	63375785-c6de-4c9f-a9b9-b92448fb7c8a	ACCEPTED	2	1044	2026-06-16 22:59:27.415692+07	\N	\N	Hello Thanh\n
5418	357	14	03e77d95-00c3-427b-87c9-4a8038c42af6	ACCEPTED	2	1056	2026-06-16 22:59:27.415701+07	\N	\N	Hello Ngoc\n
5726	383	10	4cd76482-a5fd-4454-aed7-4ba81320e7d3	WRONG_ANSWER	11	3304	2026-06-17 02:22:27.163907+07	\N	\N	Hello World\n
5725	383	9	1b56a947-77be-4d78-a44b-a9ad5e8cb8b5	WRONG_ANSWER	11	3324	2026-06-17 02:22:27.163899+07	\N	\N	Hello World\n
5727	384	11	fb6c3923-36be-4b36-9409-ecfcdc8318d0	WRONG_ANSWER	11	3312	2026-06-17 02:22:29.29513+07	\N	\N	Hello World\n
5729	385	39	f0b646d1-582e-48c7-8398-c5143d5c115d	WRONG_ANSWER	27	3300	2026-06-17 02:22:41.080062+07	\N	\N	Hello World\n
5244	318	56	42afe9e2-127e-4920-948e-19bdab538720	ACCEPTED	5	864	2026-06-16 19:47:15.380888+07	\N	\N	1000003\n
5243	318	55	cbbf7511-8798-4e75-b009-f27fa28a93c7	WRONG_ANSWER	5	876	2026-06-16 19:47:15.380887+07	\N	\N	999989\n
5252	319	46	835fc4a1-f933-4842-b119-8579f3e0111b	ACCEPTED	5	1068	2026-06-16 19:47:20.013048+07	\N	\N	23\n
5246	319	40	dd0d618f-581f-4148-b6f5-d3e111553321	ACCEPTED	5	1000	2026-06-16 19:47:20.013039+07	\N	\N	2\n
5253	319	47	d0c9f754-d581-46fa-b31c-9830b00bb233	ACCEPTED	5	1032	2026-06-16 19:47:20.01305+07	\N	\N	101\n
5250	319	44	3d9a7037-7d30-4e37-b54d-ec5216f38258	ACCEPTED	5	988	2026-06-16 19:47:20.013045+07	\N	\N	11\n
5245	319	39	a08352b9-6f45-4b14-9773-9483e0d35ee7	ACCEPTED	5	1048	2026-06-16 19:47:20.013033+07	\N	\N	17\n
5257	319	51	31baa0a4-9a29-4e20-8200-c61f7615ac9e	WRONG_ANSWER	4	1040	2026-06-16 19:47:20.013061+07	\N	\N	10001\n
5247	319	41	e84df7cf-da43-41c4-af7c-f2f20f977d2b	ACCEPTED	5	1044	2026-06-16 19:47:20.013041+07	\N	\N	3\n
5251	319	45	932796d9-5752-49b7-bbd0-7f3f9b29c11b	ACCEPTED	5	1024	2026-06-16 19:47:20.013046+07	\N	\N	11\n
5248	319	42	ecdab8e4-9747-4755-834b-c138c6b52482	ACCEPTED	4	876	2026-06-16 19:47:20.013042+07	\N	\N	5\n
5256	319	50	e1d1e9a6-8d34-43f4-a9f5-52dc234659e8	WRONG_ANSWER	4	1040	2026-06-16 19:47:20.013058+07	\N	\N	1007\n
5255	319	49	4acfc925-6334-4843-b960-cfb16ef3ee2a	WRONG_ANSWER	6	1120	2026-06-16 19:47:20.013056+07	\N	\N	1007\n
5258	319	52	9fc434d3-56d3-43d2-9f22-c2122965d112	ACCEPTED	4	1020	2026-06-16 19:47:20.013062+07	\N	\N	100003\n
5262	319	56	34a11c64-991c-47eb-ae07-8f1ab6e3d72d	ACCEPTED	5	1020	2026-06-16 19:47:20.013068+07	\N	\N	1000003\n
5260	319	54	599b77b2-ee18-4735-ac2d-bffecc78058d	WRONG_ANSWER	6	1004	2026-06-16 19:47:20.013065+07	\N	\N	500003\n
5261	319	55	da10f34f-b234-4231-beb4-30094dd662d8	WRONG_ANSWER	6	984	2026-06-16 19:47:20.013066+07	\N	\N	999989\n
5249	319	43	c3a82218-28bb-47ec-aaaf-cae54d16e65e	ACCEPTED	5	824	2026-06-16 19:47:20.013044+07	\N	\N	5\n
5254	319	48	372efad6-0488-4b0e-a57a-fdd7a443c0a2	ACCEPTED	6	1040	2026-06-16 19:47:20.013054+07	\N	\N	101\n
5259	319	53	e726cccf-7958-4b18-9890-a127d2ece5da	ACCEPTED	4	1064	2026-06-16 19:47:20.013063+07	\N	\N	100003\n
5264	320	40	16658543-f207-4fa2-b865-aadbc18790f6	ACCEPTED	5	1088	2026-06-16 19:47:26.315553+07	\N	\N	2\n
5270	320	46	19209116-fc2e-43e3-84cb-d2f7e21256a4	ACCEPTED	4	1016	2026-06-16 19:47:26.315561+07	\N	\N	23\n
5266	320	42	a3c1abe6-a899-43b9-a35c-c86b8b24ec96	ACCEPTED	5	1024	2026-06-16 19:47:26.315556+07	\N	\N	5\n
5271	320	47	3a0ba240-9d9c-4b32-a8bc-257dfc036e4c	ACCEPTED	6	832	2026-06-16 19:47:26.315571+07	\N	\N	101\n
5269	320	45	b7e59d7a-1e37-4ce2-87ce-e21017c06393	ACCEPTED	5	1016	2026-06-16 19:47:26.31556+07	\N	\N	11\n
5267	320	43	cdd139ec-0eea-4272-a8a3-2846d492b9e1	ACCEPTED	8	864	2026-06-16 19:47:26.315557+07	\N	\N	5\n
5272	320	48	453dca7c-3152-4955-975c-7c2fc674d2cf	ACCEPTED	5	900	2026-06-16 19:47:26.315572+07	\N	\N	101\n
5268	320	44	a9cafffb-cb34-48ac-8c2a-5b1069c0dde1	ACCEPTED	5	924	2026-06-16 19:47:26.315558+07	\N	\N	11\n
5263	320	39	df7485ae-12c0-4c06-bd79-f2f0a715d48d	ACCEPTED	6	892	2026-06-16 19:47:26.315544+07	\N	\N	17\n
5265	320	41	3eac20dd-4422-4a0d-ac04-20041a2dabe0	ACCEPTED	6	992	2026-06-16 19:47:26.315554+07	\N	\N	3\n
5275	320	51	190b7ee4-9325-4b55-9aa7-91a355c209fe	WRONG_ANSWER	4	864	2026-06-16 19:47:26.315577+07	\N	\N	10001\n
5277	320	53	fdd91dcc-0d66-49e0-876a-640690d53155	ACCEPTED	7	1088	2026-06-16 19:47:26.315579+07	\N	\N	100003\n
5276	320	52	e8c0cb99-431f-445e-a503-036734e24679	ACCEPTED	4	976	2026-06-16 19:47:26.315578+07	\N	\N	100003\n
5273	320	49	8ac1100c-3fa6-4415-a21e-1791a6d08c1d	WRONG_ANSWER	7	912	2026-06-16 19:47:26.315574+07	\N	\N	1007\n
5279	320	55	1b300499-ca87-44ec-b1df-9e87d905832a	WRONG_ANSWER	5	872	2026-06-16 19:47:26.315582+07	\N	\N	999989\n
5274	320	50	6ed8b51e-da02-4f87-abce-dd70a0d39625	WRONG_ANSWER	5	1020	2026-06-16 19:47:26.315575+07	\N	\N	1007\n
5280	320	56	5bda7d9e-ca6a-47de-a393-6013753ea372	ACCEPTED	4	856	2026-06-16 19:47:26.315583+07	\N	\N	1000003\n
5278	320	54	260c6239-580b-480d-b63d-559ddd3bd8f3	WRONG_ANSWER	3	1052	2026-06-16 19:47:26.315581+07	\N	\N	500003\n
5281	321	39	d2b99baa-8252-4fcb-92d5-edea78fbe43c	ACCEPTED	8	908	2026-06-16 19:47:29.634859+07	\N	\N	17\n
5284	321	42	e1dc3fff-8ac1-4bdb-8bd7-901b7d4c787a	ACCEPTED	6	996	2026-06-16 19:47:29.63487+07	\N	\N	5\n
5282	321	40	21d4b991-a9d3-4237-a696-e065c3cb1c58	ACCEPTED	16	884	2026-06-16 19:47:29.634867+07	\N	\N	2\n
5283	321	41	f1f42aea-39bb-40ed-9f6d-0b079ae0bf54	ACCEPTED	9	1096	2026-06-16 19:47:29.634868+07	\N	\N	3\n
5286	321	44	625de3fa-c2f2-4598-b541-92756b15733f	ACCEPTED	8	864	2026-06-16 19:47:29.634872+07	\N	\N	11\n
5288	321	46	0c4a9be5-0712-4721-bfb1-5fad30dc6c0c	ACCEPTED	7	1032	2026-06-16 19:47:29.634875+07	\N	\N	23\n
5287	321	45	53cfa1ed-26f0-400e-9c5b-08b1d970560a	ACCEPTED	6	1032	2026-06-16 19:47:29.634873+07	\N	\N	11\n
5285	321	43	911cbbb1-7c7b-4a32-9fe0-d257e8bef1a8	ACCEPTED	4	1020	2026-06-16 19:47:29.634871+07	\N	\N	5\n
5420	358	4	d561b414-daf0-4a7f-8a91-9c8dd2685d78	ACCEPTED	79	35524	2026-06-16 23:05:01.032755+07	\N	\N	-1\n
5419	358	3	e1ef0eab-1364-42ec-981f-bb30bfe3197e	ACCEPTED	73	36500	2026-06-16 23:05:01.032749+07	\N	\N	9\n
5728	384	12	f264a9a0-a5f9-461e-b20f-2cf70245b3ae	WRONG_ANSWER	11	3332	2026-06-17 02:22:29.295137+07	\N	\N	Hello World\n
5732	385	42	f26a33a5-f147-4a8b-959a-e95c61726ef6	WRONG_ANSWER	27	3292	2026-06-17 02:22:41.080078+07	\N	\N	Hello World\n
5730	385	40	6e55ba00-e67b-4707-b7d2-f598ead21f84	WRONG_ANSWER	26	3408	2026-06-17 02:22:41.080071+07	\N	\N	Hello World\n
5774	387	48	9c8857e7-5b74-445b-b90b-b5c170d65d35	ACCEPTED	5	1036	2026-06-17 02:23:11.990594+07	\N	\N	101\n
5766	387	40	5ec8d1af-b63d-4d76-9148-67f4e885d0d8	ACCEPTED	5	1584	2026-06-17 02:23:11.990584+07	\N	\N	2\n
5767	387	41	a9ab43b7-7337-44b3-8578-a6f70eef7925	ACCEPTED	7	832	2026-06-17 02:23:11.990586+07	\N	\N	3\n
5768	387	42	48f846d2-ed61-4d3f-95b0-59d22c6f18df	ACCEPTED	6	1020	2026-06-17 02:23:11.990587+07	\N	\N	5\n
5765	387	39	d07acb84-8526-4161-b0aa-4013fec8288b	ACCEPTED	5	984	2026-06-17 02:23:11.990577+07	\N	\N	17\n
5772	387	46	baab4e37-455f-4e4a-a068-e6f4180f1173	ACCEPTED	7	992	2026-06-17 02:23:11.990591+07	\N	\N	23\n
5769	387	43	6e669b4d-a8b2-40b6-91aa-5b40b146f8f5	ACCEPTED	7	864	2026-06-17 02:23:11.990588+07	\N	\N	5\n
5290	321	48	4c0c7a99-1bd5-4320-b6a6-cec2cf4cb19e	ACCEPTED	6	1028	2026-06-16 19:47:29.634877+07	\N	\N	101\n
5289	321	47	1ef42d42-fdbc-4258-ad11-e412544f9ec9	ACCEPTED	5	860	2026-06-16 19:47:29.634876+07	\N	\N	101\n
5292	321	50	cc5771b6-1a47-42bd-880c-22da146e2662	WRONG_ANSWER	4	1204	2026-06-16 19:47:29.634886+07	\N	\N	1007\n
5294	321	52	2fa6cf1f-eca9-4f85-831b-cdd2ae9d6532	ACCEPTED	6	1096	2026-06-16 19:47:29.634889+07	\N	\N	100003\n
5297	321	55	a9064863-9a5f-4717-bc72-9cbab7a6efc2	WRONG_ANSWER	5	1032	2026-06-16 19:47:29.634893+07	\N	\N	999989\n
5296	321	54	3ba33d6b-71c3-4536-9cd3-39b05154d8eb	WRONG_ANSWER	5	860	2026-06-16 19:47:29.634892+07	\N	\N	500003\n
5298	321	56	ec0a1ac4-ba88-47c1-bd07-d30bc24bcbda	ACCEPTED	4	888	2026-06-16 19:47:29.634894+07	\N	\N	1000003\n
5291	321	49	956b05ff-b866-4477-b727-af0d6546fb4f	WRONG_ANSWER	5	876	2026-06-16 19:47:29.634878+07	\N	\N	1007\n
5295	321	53	f9d0f19c-5a46-4037-8811-5cea9db11599	ACCEPTED	5	876	2026-06-16 19:47:29.63489+07	\N	\N	100003\n
5293	321	51	8746c368-5d02-433f-b5cb-73cd166354f4	WRONG_ANSWER	6	1016	2026-06-16 19:47:29.634887+07	\N	\N	10001\n
5303	322	43	54ddff7c-f897-4fb1-ac48-5a128ed64d08	ACCEPTED	6	876	2026-06-16 19:48:01.611689+07	\N	\N	5\n
5301	322	41	f1783da2-6c5f-4366-a704-04cb9e2669a7	ACCEPTED	5	872	2026-06-16 19:48:01.611683+07	\N	\N	3\n
5306	322	46	0ccf5090-e7ed-4074-86da-d3901b0066a5	ACCEPTED	5	876	2026-06-16 19:48:01.611696+07	\N	\N	23\n
5300	322	40	ff84e29f-5739-4251-bb94-2134e7a35021	ACCEPTED	4	864	2026-06-16 19:48:01.61168+07	\N	\N	2\n
5307	322	47	132d9cac-5278-4630-b006-afcfe64b9b60	ACCEPTED	5	892	2026-06-16 19:48:01.612314+07	\N	\N	101\n
5304	322	44	f83babb4-743a-43ce-96ce-39a68c2212dd	ACCEPTED	5	1064	2026-06-16 19:48:01.611691+07	\N	\N	11\n
5302	322	42	30778a65-dc1d-4385-987e-37bfa7f89c66	ACCEPTED	4	1020	2026-06-16 19:48:01.611686+07	\N	\N	5\n
5299	322	39	0033abe6-305f-4829-9e47-10d8024d34ae	ACCEPTED	6	1008	2026-06-16 19:48:01.611666+07	\N	\N	17\n
5314	322	54	f01cef99-1c0e-4a95-aa72-8bbec2607701	ACCEPTED	4	876	2026-06-16 19:48:01.612346+07	\N	\N	500009\n
5312	322	52	d77fa0ef-17cc-49b6-8f4e-98dc2f29ed3f	ACCEPTED	5	1020	2026-06-16 19:48:01.612341+07	\N	\N	100003\n
5309	322	49	91617a29-0e0c-4a7b-8863-a5b506649315	ACCEPTED	5	1024	2026-06-16 19:48:01.612329+07	\N	\N	1009\n
5310	322	50	60e22112-4073-450c-9758-19a963b2c4e7	ACCEPTED	4	864	2026-06-16 19:48:01.612336+07	\N	\N	1009\n
5315	322	55	2c5fdbf9-1ed3-435a-8c28-4f46c725a563	ACCEPTED	5	984	2026-06-16 19:48:01.612348+07	\N	\N	1000003\n
5305	322	45	37300265-308e-40c7-b348-9f3442f67dd9	ACCEPTED	7	1028	2026-06-16 19:48:01.611693+07	\N	\N	11\n
5311	322	51	9a45403a-2646-4696-a74e-a775c9e510e2	ACCEPTED	4	1120	2026-06-16 19:48:01.612339+07	\N	\N	10007\n
5313	322	53	c6e8920f-4a25-4bab-8bdf-526ed23421e2	ACCEPTED	4	980	2026-06-16 19:48:01.612344+07	\N	\N	100003\n
5316	322	56	769ef814-93ca-4924-a108-3122afcedb49	ACCEPTED	5	1120	2026-06-16 19:48:01.612351+07	\N	\N	1000003\n
5308	322	48	de26a992-115c-43af-a47f-bd1b2fe45e96	ACCEPTED	5	1004	2026-06-16 19:48:01.612326+07	\N	\N	101\n
5319	323	41	316d5634-da28-4d7a-8552-58f284d08473	ACCEPTED	8	1096	2026-06-16 19:49:24.700996+07	\N	\N	3\n
5321	323	43	c43de9c2-460a-41d2-b461-360a1e5f17b4	ACCEPTED	5	1092	2026-06-16 19:49:24.700998+07	\N	\N	5\n
5323	323	45	1085aabe-578e-48d7-a87d-f10e96968f14	ACCEPTED	5	1020	2026-06-16 19:49:24.701+07	\N	\N	11\n
5320	323	42	56f3168e-6fcf-4716-8afa-162b9cdaffca	ACCEPTED	5	820	2026-06-16 19:49:24.700997+07	\N	\N	5\n
5325	323	47	9052b4f1-5b5a-49b9-8f70-b42614b3e14f	ACCEPTED	5	1024	2026-06-16 19:49:24.701002+07	\N	\N	101\n
5326	323	48	8c7f736b-6108-489b-ad71-067bcab4c8cf	ACCEPTED	4	1012	2026-06-16 19:49:24.701003+07	\N	\N	101\n
5317	323	39	0461fdf4-d5ee-412b-82e4-cc558fbee64c	ACCEPTED	5	892	2026-06-16 19:49:24.700979+07	\N	\N	17\n
5324	323	46	429f1ec0-ac60-4f60-89b1-fef31db5be98	ACCEPTED	4	860	2026-06-16 19:49:24.701001+07	\N	\N	23\n
5318	323	40	11b02025-eaa7-46d1-a184-224e05b1e960	ACCEPTED	5	872	2026-06-16 19:49:24.700994+07	\N	\N	2\n
5322	323	44	884fcad9-d81a-4fb2-ab17-8723ebdf6542	ACCEPTED	6	1096	2026-06-16 19:49:24.700999+07	\N	\N	11\n
5422	359	16	4272c9bc-5a9d-4a7a-83d4-b2c2413c2605	WRONG_ANSWER	24	5700	2026-06-16 23:18:37.934796+07	\N	\N	Hello World\n
5421	359	15	38b2ac3c-855b-48db-80de-1556107794e0	WRONG_ANSWER	25	6060	2026-06-16 23:18:37.93479+07	\N	\N	Hello World\n
5423	360	13	433596cb-017d-43ad-8b7b-f3c87735202d	ACCEPTED	3	14596	2026-06-16 23:19:11.763055+07	\N	\N	Hello Thanh\n
5424	360	14	195f29d3-5320-438d-8ad7-673b6f950bc8	ACCEPTED	3	17384	2026-06-16 23:19:11.763059+07	\N	\N	Hello Ngoc\n
5425	361	5	17d0c009-152a-44c0-9402-06d05cd7c9fa	WRONG_ANSWER	18	5592	2026-06-16 23:26:30.451191+07	\N	\N	Hello World\n
5426	361	6	c5744118-3286-4911-ad4d-19d6434bd7ec	WRONG_ANSWER	19	5368	2026-06-16 23:26:30.451201+07	\N	\N	Hello World\n
5433	362	27	0eb57461-6d4c-4783-8b32-f44993d81e08	ACCEPTED	10	13052	2026-06-16 23:26:44.792106+07	\N	\N	1000\n
5434	362	28	2932aa0a-6661-4a24-8a2f-31b4ae966ecf	ACCEPTED	4	3924	2026-06-16 23:26:44.792106+07	\N	\N	579\n
5431	362	25	66bda6bc-6c78-40eb-9de7-fcb78a0d7b84	ACCEPTED	4	4028	2026-06-16 23:26:44.792104+07	\N	\N	300\n
5432	362	26	f13f2f38-84ac-4a09-97b7-90ccb3885b51	ACCEPTED	4	4708	2026-06-16 23:26:44.792105+07	\N	\N	-30\n
5429	362	23	13af007e-2a1f-44a2-9d47-ac18d211a224	ACCEPTED	4	1144	2026-06-16 23:26:44.792103+07	\N	\N	0\n
5427	362	21	c2458253-7bd2-46e3-bf80-ee4412fb2e02	ACCEPTED	4	2200	2026-06-16 23:26:44.792097+07	\N	\N	3\n
5438	362	32	96b2826f-6289-40cc-9f0f-7fedd19bfb35	ACCEPTED	4	1372	2026-06-16 23:26:44.792109+07	\N	\N	0\n
5436	362	30	a04d4d59-9393-4b29-aaea-bf541ffea569	ACCEPTED	4	876	2026-06-16 23:26:44.792108+07	\N	\N	0\n
5428	362	22	08d085ad-cf0e-46bd-a8d0-8c39ae3edd95	ACCEPTED	4	1204	2026-06-16 23:26:44.792102+07	\N	\N	30\n
5430	362	24	7de5c63c-9da7-439c-8e76-da20f9f66b89	ACCEPTED	4	1228	2026-06-16 23:26:44.792104+07	\N	\N	0\n
5735	385	45	f830b325-9ad4-417f-8280-5cf726c16745	WRONG_ANSWER	26	3320	2026-06-17 02:22:41.080093+07	\N	\N	Hello World\n
5733	385	43	031364e8-ace4-4182-b924-273bd99d8f4a	WRONG_ANSWER	30	3252	2026-06-17 02:22:41.080079+07	\N	\N	Hello World\n
5737	385	47	90c8872e-af36-4f59-bfa6-c97f5427d745	WRONG_ANSWER	25	3212	2026-06-17 02:22:41.080095+07	\N	\N	Hello World\n
5736	385	46	c2bb1151-e58c-46c1-94c7-fe20579ef3f6	WRONG_ANSWER	36	3204	2026-06-17 02:22:41.080094+07	\N	\N	Hello World\n
5328	323	50	9448ab9c-9ebb-4eef-bfc8-782c5832ff90	ACCEPTED	6	864	2026-06-16 19:49:24.701005+07	\N	\N	1009\n
5330	323	52	dd5e64e1-843b-4962-8861-fd421f7ba158	ACCEPTED	8	976	2026-06-16 19:49:24.701007+07	\N	\N	100003\n
5333	323	55	25258de8-8eb5-4ee1-8185-d083fe38c4d9	ACCEPTED	5	1016	2026-06-16 19:49:24.701009+07	\N	\N	1000003\n
5331	323	53	a28584d9-3b86-4fd5-a887-e5760cc3fc7e	ACCEPTED	5	1028	2026-06-16 19:49:24.701008+07	\N	\N	100003\n
5329	323	51	617f519f-94d5-447b-bbe7-8f9b23bbec05	ACCEPTED	5	1092	2026-06-16 19:49:24.701006+07	\N	\N	10007\n
5327	323	49	c6b71f24-0ab6-41e8-b5fe-f20c9b0e5a15	ACCEPTED	5	1024	2026-06-16 19:49:24.701004+07	\N	\N	1009\n
5334	323	56	f60b2e72-581e-4380-a9cf-2000b7595bc9	ACCEPTED	4	1120	2026-06-16 19:49:24.701014+07	\N	\N	1000003\n
5332	323	54	7598a0dd-2a40-44f5-826d-08a20684265f	ACCEPTED	2	1056	2026-06-16 19:49:24.701008+07	\N	\N	500009\n
5336	324	12	81cfbc8f-743d-42d8-8f5b-b15cfe06b8ed	WRONG_ANSWER	2	1116	2026-06-16 19:49:39.3428+07	\N	\N	7\n
5335	324	11	b2993989-2aff-4cec-bbfb-b04ef548a6ef	WRONG_ANSWER	2	1048	2026-06-16 19:49:39.342794+07	\N	\N	7\n
5337	325	11	3d51c540-c3ae-4ab5-aba5-217c9e2cc9d0	ACCEPTED	2	2164	2026-06-16 19:50:43.402708+07	\N	\N	4\n
5338	325	12	89a36f64-dec2-4759-a8e3-40147229c3df	ACCEPTED	2	2512	2026-06-16 19:50:43.402713+07	\N	\N	4\n
5340	326	12	3d70e9f2-a3bc-4e5b-8502-23caa890ca76	ACCEPTED	2	1080	2026-06-16 19:51:00.48914+07	\N	\N	4\n
5339	326	11	7238a085-7d11-4988-905f-2d1b7632ded9	ACCEPTED	2	1080	2026-06-16 19:51:00.489134+07	\N	\N	4\n
5341	327	9	f0c8f371-31ed-4ba3-8065-1c09a5d6d413	WRONG_ANSWER	2	1020	2026-06-16 19:51:52.40293+07	\N	\N	1\n
5342	327	10	e465d368-f174-4a5c-8504-8beec3b347ae	WRONG_ANSWER	2	1056	2026-06-16 19:51:52.402937+07	\N	\N	1\n
5344	328	10	a72686ef-0b87-40b2-98bd-070ac8181e02	WRONG_ANSWER	7	900	2026-06-16 19:51:55.62255+07	\N	\N	1\n
5343	328	9	dfa2cef6-e7d6-4dd3-88ee-c64ff9f93b37	WRONG_ANSWER	5	1052	2026-06-16 19:51:55.622546+07	\N	\N	1\n
5346	329	10	3c0ddf5f-a269-4a84-8136-7ec0951377f8	WRONG_ANSWER	2	1136	2026-06-16 19:51:56.266962+07	\N	\N	1\n
5345	329	9	9b8ea2bf-fa38-4923-bb1a-08fe12279586	WRONG_ANSWER	2	1068	2026-06-16 19:51:56.266958+07	\N	\N	1\n
5348	330	10	4b90857a-aba9-46aa-9b7f-0ce239ad8646	WRONG_ANSWER	2	1080	2026-06-16 19:51:56.901347+07	\N	\N	1\n
5347	330	9	57fd65c8-d1fd-47ab-8f9a-284fc14acbdc	WRONG_ANSWER	2	1084	2026-06-16 19:51:56.901337+07	\N	\N	1\n
5350	331	10	49ee8516-7040-486f-80cb-d42389400209	WRONG_ANSWER	2	1040	2026-06-16 19:51:57.598039+07	\N	\N	1\n
5349	331	9	d891be52-f7de-45de-9c28-424cacbd16f5	WRONG_ANSWER	2	1060	2026-06-16 19:51:57.598033+07	\N	\N	1\n
5352	332	10	5be39838-bb63-4e25-b8eb-4030c903a2df	WRONG_ANSWER	2	1036	2026-06-16 19:51:58.291435+07	\N	\N	1\n
5351	332	9	0b87903a-8b0a-49e9-b4ee-19747debfd78	WRONG_ANSWER	3	1024	2026-06-16 19:51:58.291431+07	\N	\N	1\n
5354	333	10	c90314c0-cf56-41f0-9ff3-54424188348b	WRONG_ANSWER	4	1036	2026-06-16 19:51:58.890564+07	\N	\N	1\n
5353	333	9	3536a33f-c83c-4c1d-8a97-52a62e6a6c82	WRONG_ANSWER	5	1036	2026-06-16 19:51:58.89056+07	\N	\N	1\n
5355	334	9	3a153d2a-3e55-4fc6-a750-8bf2abc7391e	WRONG_ANSWER	3	1068	2026-06-16 19:51:59.488395+07	\N	\N	1\n
5356	334	10	d7b00e90-6b9e-4728-91da-7d840d99f8e7	WRONG_ANSWER	3	1032	2026-06-16 19:51:59.488405+07	\N	\N	1\n
5357	335	9	3cb6be45-c5fe-485e-b71d-a3f8ea75cec6	WRONG_ANSWER	2	1060	2026-06-16 19:52:00.020342+07	\N	\N	1\n
5358	335	10	61251fab-1acd-4fe3-a586-859bbda4a5e7	WRONG_ANSWER	2	1184	2026-06-16 19:52:00.020351+07	\N	\N	1\n
5359	336	9	d6c765c3-09a0-480f-96a2-002a9f21037e	WRONG_ANSWER	2	1064	2026-06-16 19:52:02.364016+07	\N	\N	1\n
5360	336	10	bbb6121d-915c-4be4-b812-59b5c386f8e7	WRONG_ANSWER	2	1060	2026-06-16 19:52:02.364019+07	\N	\N	1\n
5361	337	9	a99497a4-040e-407d-a3b9-a89d1251284e	WRONG_ANSWER	3	1036	2026-06-16 19:52:02.952428+07	\N	\N	1\n
5362	337	10	927c3243-44ae-4193-9a7e-fa26f0065a87	WRONG_ANSWER	4	1028	2026-06-16 19:52:02.952432+07	\N	\N	1\n
5363	338	9	2d36a144-6b27-456b-b8af-273fc0b90ccf	WRONG_ANSWER	3	1012	2026-06-16 19:52:03.485377+07	\N	\N	1\n
5364	338	10	3de14e2f-cb61-41da-8123-7950385029a9	WRONG_ANSWER	2	1032	2026-06-16 19:52:03.485381+07	\N	\N	1\n
5365	339	9	222c51e5-c68c-49fc-9206-527b319e2b2e	WRONG_ANSWER	3	1060	2026-06-16 19:52:04.015509+07	\N	\N	1\n
5366	339	10	3cfbbc59-5de1-4189-a23c-193668ee11b5	WRONG_ANSWER	3	1060	2026-06-16 19:52:04.015514+07	\N	\N	1\n
5367	340	9	4c7c909e-f95e-4625-a235-59dd0e92d86e	WRONG_ANSWER	2	1068	2026-06-16 19:52:04.586744+07	\N	\N	1\n
5368	340	10	d16c462b-1ae2-45f1-b4a1-e4ae36f42f4f	WRONG_ANSWER	2	1020	2026-06-16 19:52:04.586754+07	\N	\N	1\n
5369	341	9	5c1ec219-c4a8-446b-a898-951529925613	WRONG_ANSWER	3	1028	2026-06-16 19:52:05.092143+07	\N	\N	1\n
5370	341	10	5d95cdc5-dacf-4081-99f0-1009aa4fe485	WRONG_ANSWER	3	1036	2026-06-16 19:52:05.092147+07	\N	\N	1\n
5371	342	9	613165c9-cabb-4bf9-9764-2d96c47a9ed3	WRONG_ANSWER	3	1060	2026-06-16 19:52:05.533273+07	\N	\N	1\n
5372	342	10	23e9ab41-7833-40b1-8c2d-ba6530e5a50a	WRONG_ANSWER	3	1084	2026-06-16 19:52:05.533281+07	\N	\N	1\n
5373	343	9	89b476e1-9421-4d49-9185-68e82301debb	WRONG_ANSWER	2	1060	2026-06-16 19:52:05.95715+07	\N	\N	1\n
5374	343	10	38fa6cc0-a26c-461f-a3a6-cd998fa6b457	WRONG_ANSWER	2	1060	2026-06-16 19:52:05.957153+07	\N	\N	1\n
5376	344	10	1f2c27a0-f851-4856-a1f2-490eeeface8f	WRONG_ANSWER	2	1056	2026-06-16 19:52:07.443859+07	\N	\N	1\n
5375	344	9	cd78a47d-51f9-493e-a8c5-5d3dda87eb33	WRONG_ANSWER	2	1072	2026-06-16 19:52:07.443851+07	\N	\N	1\n
5378	345	10	e93a1069-99f8-4375-810f-543084a20b63	WRONG_ANSWER	2	1032	2026-06-16 19:52:08.020331+07	\N	\N	1\n
5377	345	9	c0623075-3a3d-4805-a619-7933263a4400	WRONG_ANSWER	2	1252	2026-06-16 19:52:08.020326+07	\N	\N	1\n
5380	346	10	8ffb7a04-b03a-423e-93d9-902b2653c38e	WRONG_ANSWER	3	1068	2026-06-16 19:52:08.674672+07	\N	\N	1\n
5379	346	9	628654e3-d649-4334-b1b8-0a383e76cf82	WRONG_ANSWER	3	1172	2026-06-16 19:52:08.674669+07	\N	\N	1\n
5382	347	10	841be8e8-44fc-45c8-adb7-9d622cd787a6	WRONG_ANSWER	4	1024	2026-06-16 19:52:09.123394+07	\N	\N	1\n
5381	347	9	0d9822b9-5904-4583-8aa0-92de78c172da	WRONG_ANSWER	3	1228	2026-06-16 19:52:09.123389+07	\N	\N	1\n
5384	348	10	86453584-e6ae-4642-a873-0bcb12a5ebcb	WRONG_ANSWER	2	1252	2026-06-16 19:52:09.634345+07	\N	\N	1\n
5383	348	9	b9b6f7c5-e598-4a27-bbdb-d55ee7186b08	WRONG_ANSWER	2	1080	2026-06-16 19:52:09.63434+07	\N	\N	1\n
5439	362	33	2bf9cbbb-88c2-4b94-9932-cc607ff54edf	ACCEPTED	4	1284	2026-06-16 23:26:44.79211+07	\N	\N	84\n
5385	349	9	134b1701-35b9-442e-8f44-bf626fd2ba8d	WRONG_ANSWER	2	1048	2026-06-16 19:52:10.510737+07	\N	\N	1\n
5441	362	35	67bf6c2f-05e0-4a7e-9a9c-869afd9a643a	ACCEPTED	10	2452	2026-06-16 23:26:44.792111+07	\N	\N	-2\n
5443	362	37	af545b2e-52c0-45ae-a9fe-476325e54a53	ACCEPTED	5	1036	2026-06-16 23:26:44.792122+07	\N	\N	1000\n
5442	362	36	5142e04c-6209-472b-addd-e06ad354b42e	ACCEPTED	4	916	2026-06-16 23:26:44.792112+07	\N	\N	801\n
5444	362	38	faaaf132-8008-4948-b81b-53538eb6aab2	ACCEPTED	5	876	2026-06-16 23:26:44.792122+07	\N	\N	3000000\n
5731	385	41	604b5fb6-86b9-4eea-b9f7-95312707c489	WRONG_ANSWER	26	3284	2026-06-17 02:22:41.080072+07	\N	\N	Hello World\n
5739	385	49	5a12cfc7-aecc-48f5-83cd-ba2fd78b4b0f	WRONG_ANSWER	26	3432	2026-06-17 02:22:41.080097+07	\N	\N	Hello World\n
5734	385	44	d7539c6f-0ce8-4838-9ff8-ed7956647343	WRONG_ANSWER	32	3260	2026-06-17 02:22:41.08008+07	\N	\N	Hello World\n
5738	385	48	986bf05e-a61a-43c1-b322-afedce213988	WRONG_ANSWER	27	3400	2026-06-17 02:22:41.080096+07	\N	\N	Hello World\n
5740	385	50	60341c4b-aabd-4199-8e12-1e320c87cfe1	WRONG_ANSWER	32	3440	2026-06-17 02:22:41.080099+07	\N	\N	Hello World\n
5742	385	52	7635c41a-50d6-4dab-b7eb-1249924c52a2	WRONG_ANSWER	36	3312	2026-06-17 02:22:41.080101+07	\N	\N	Hello World\n
5745	385	55	18b9c945-bcb7-4ae4-af72-b65861578a85	WRONG_ANSWER	25	3252	2026-06-17 02:22:41.080104+07	\N	\N	Hello World\n
5744	385	54	2023e882-5fda-44a8-a18b-ba0cf39b622f	WRONG_ANSWER	31	3372	2026-06-17 02:22:41.080103+07	\N	\N	Hello World\n
5743	385	53	4a6caaab-ceed-4809-9b4f-959c26dbc6ba	WRONG_ANSWER	23	3392	2026-06-17 02:22:41.080102+07	\N	\N	Hello World\n
5741	385	51	f882ae5a-f803-4111-9f72-b6fdb9ad7b0e	WRONG_ANSWER	25	3416	2026-06-17 02:22:41.0801+07	\N	\N	Hello World\n
5746	385	56	a003ef01-97c1-46ed-9fcd-2582a8bb44af	WRONG_ANSWER	26	3188	2026-06-17 02:22:41.080106+07	\N	\N	Hello World\n
5748	386	40	38d8d30f-1ead-41a0-90d8-212ad8e8f74f	WRONG_ANSWER	5	1208	2026-06-17 02:22:52.661014+07	\N	\N	Hello World\n
5751	386	43	8727687e-95f0-45dc-aaf8-f15fb6b94b67	WRONG_ANSWER	5	1580	2026-06-17 02:22:52.661016+07	\N	\N	Hello World\n
5761	386	53	7b06cce3-4782-4605-9aec-4b7252bcf180	WRONG_ANSWER	6	920	2026-06-17 02:22:52.661021+07	\N	\N	Hello World\n
5754	386	46	834a5036-6187-4677-80f3-28bcad99d16d	WRONG_ANSWER	5	2732	2026-06-17 02:22:52.661017+07	\N	\N	Hello World\n
5752	386	44	bf68017d-4dd1-44fa-b5d0-0095a5fcc2a8	WRONG_ANSWER	6	8204	2026-06-17 02:22:52.661016+07	\N	\N	Hello World\n
5749	386	41	ab61a2a1-3622-4d39-a5e8-7596d653687a	WRONG_ANSWER	5	6444	2026-06-17 02:22:52.661014+07	\N	\N	Hello World\n
5757	386	49	e114a081-ab4e-4d5f-acc4-93c363dc63d1	WRONG_ANSWER	8	1024	2026-06-17 02:22:52.661019+07	\N	\N	Hello World\n
5759	386	51	47d92653-f0ae-4cc7-965d-45fb87b40b50	WRONG_ANSWER	5	892	2026-06-17 02:22:52.66102+07	\N	\N	Hello World\n
5750	386	42	0ed5c1b5-707c-4d70-b00b-4b58c67bb09b	WRONG_ANSWER	6	1344	2026-06-17 02:22:52.661015+07	\N	\N	Hello World\n
5753	386	45	72ac5567-723c-4bf9-a41d-88a1429f595d	WRONG_ANSWER	6	1176	2026-06-17 02:22:52.661017+07	\N	\N	Hello World\n
5747	386	39	bab6a6ee-0d5b-4da3-a44b-cdb06c1db9e6	WRONG_ANSWER	6	7696	2026-06-17 02:22:52.661008+07	\N	\N	Hello World\n
5762	386	54	9ecc5025-dafc-42b6-913a-287ba98483cb	WRONG_ANSWER	6	8280	2026-06-17 02:22:52.661022+07	\N	\N	Hello World\n
5760	386	52	ea368da0-a4e9-481e-bd85-8982de29ae66	WRONG_ANSWER	5	1024	2026-06-17 02:22:52.661021+07	\N	\N	Hello World\n
5756	386	48	1f897443-b797-48ac-b090-d4f9f19c2a2c	WRONG_ANSWER	4	864	2026-06-17 02:22:52.661019+07	\N	\N	Hello World\n
5755	386	47	55933b8d-5299-43e3-bcbc-f5ad2eecca7b	WRONG_ANSWER	6	852	2026-06-17 02:22:52.661018+07	\N	\N	Hello World\n
5764	386	56	553b89ca-afdd-44de-b1aa-43aafd4b4d9a	WRONG_ANSWER	5	1024	2026-06-17 02:22:52.661023+07	\N	\N	Hello World\n
5763	386	55	658af7b5-0868-4468-a648-d3cc1e7c632d	WRONG_ANSWER	4	1016	2026-06-17 02:22:52.661023+07	\N	\N	Hello World\n
5758	386	50	afa18639-d4dd-4236-b047-e43c42ed3953	WRONG_ANSWER	5	1016	2026-06-17 02:22:52.66102+07	\N	\N	Hello World\n
6228	419	100	0fc70ca2-953c-4b0b-9575-6309a24dfed5	ACCEPTED	5	872	2026-06-19 00:25:03.395471+07	\N	\N	281928\n
6233	419	105	b6094d99-da95-4993-a08b-1f8ea27db776	ACCEPTED	3	1092	2026-06-19 00:25:03.395489+07	\N	\N	-882565\n
6226	419	98	a1767052-080b-489e-90ba-e1481c32e42e	ACCEPTED	4	780	2026-06-19 00:25:03.395469+07	\N	\N	99178\n
6236	419	108	9d87abdd-fb5f-4f4e-827e-04521acf6d30	ACCEPTED	6	820	2026-06-19 00:25:03.395493+07	\N	\N	1436130\n
6235	419	107	a13ba35a-6f27-4b8a-84f4-6a277e129ecd	ACCEPTED	5	880	2026-06-19 00:25:03.395492+07	\N	\N	-34648\n
6230	419	102	73be64dc-4990-4971-a44d-e513a6b9e0f1	ACCEPTED	7	840	2026-06-19 00:25:03.395485+07	\N	\N	-619866\n
6229	419	101	9918fa47-dc42-48ef-94f6-f2e6292fa544	ACCEPTED	4	784	2026-06-19 00:25:03.395472+07	\N	\N	28962\n
6231	419	103	4a71567c-5eb1-4d55-8f68-50b67d9b6590	ACCEPTED	4	832	2026-06-19 00:25:03.395487+07	\N	\N	283996\n
6238	419	110	aea399f4-1cc5-4665-ae90-266cb85e95e9	ACCEPTED	3	1100	2026-06-19 00:25:03.395496+07	\N	\N	-572819\n
6232	419	104	a6a92641-a96b-4234-94c6-6a8487f669ea	ACCEPTED	3	840	2026-06-19 00:25:03.395488+07	\N	\N	514364\n
6234	419	106	63d04bad-573e-4855-8666-0994037a8029	ACCEPTED	4	820	2026-06-19 00:25:03.395491+07	\N	\N	-815576\n
6237	419	109	0c4443ef-09cd-47fd-9a3c-7f7368b8efbf	ACCEPTED	4	828	2026-06-19 00:25:03.395495+07	\N	\N	792531\n
6239	419	111	1e3e5282-f0a7-4323-8d8b-6ed16c022c0d	ACCEPTED	4	1024	2026-06-19 00:25:03.395497+07	\N	\N	-309452\n
6241	419	113	431c1b75-de69-4f6a-85b3-d7199b2525ee	ACCEPTED	4	824	2026-06-19 00:25:03.3955+07	\N	\N	-1143916\n
6240	419	112	618541d8-b4d3-481f-9b87-7af52856b5eb	ACCEPTED	3	852	2026-06-19 00:25:03.395499+07	\N	\N	649261\n
6242	419	114	208e6821-9fcd-4340-9744-6fd12b55c338	ACCEPTED	4	880	2026-06-19 00:25:03.395501+07	\N	\N	-234796\n
6243	419	115	2a088a8b-c64b-4aa8-9d5f-e516419ca064	ACCEPTED	3	824	2026-06-19 00:25:03.395503+07	\N	\N	506806\n
6246	419	118	962894ff-8e2b-4036-8e20-989813d1dd9d	ACCEPTED	5	908	2026-06-19 00:25:03.395506+07	\N	\N	636465324\n
6245	419	117	ebcb40ba-f141-4c62-8e39-cb5b45bf372f	ACCEPTED	4	844	2026-06-19 00:25:03.395505+07	\N	\N	362210245\n
6247	419	119	db2a524b-a584-4408-a9c2-29d155b478dc	ACCEPTED	3	1084	2026-06-19 00:25:03.395508+07	\N	\N	-738231997\n
6248	419	120	39a5fea6-abf2-47ff-a8a1-064003bc9f97	ACCEPTED	3	824	2026-06-19 00:25:03.395509+07	\N	\N	371467497\n
6249	419	121	7a89c31c-067d-4267-b63e-74cf739e5bc2	ACCEPTED	4	1096	2026-06-19 00:25:03.395511+07	\N	\N	1259817393\n
5395	354	9	82f000d9-fb72-4823-98b5-cc3de361b107	ACCEPTED	2	1028	2026-06-16 19:54:23.926044+07	\N	\N	6\n
5396	354	10	dab11b13-5917-4a2c-bb00-8d6925c26bb7	ACCEPTED	2	1060	2026-06-16 19:54:23.926057+07	\N	\N	7\n
5397	355	9	a987281d-cd9c-4135-aa7e-a963eac314cd	ACCEPTED	2	1036	2026-06-16 19:54:37.002956+07	\N	\N	6\n
5398	355	10	670e9ee3-160b-428c-84ec-f9b58d3159f1	ACCEPTED	2	1176	2026-06-16 19:54:37.00296+07	\N	\N	7\n
5440	362	34	5d96de77-c3bb-4fa2-beb8-b4ab65cb4db0	ACCEPTED	4	1212	2026-06-16 23:26:44.79211+07	\N	\N	15\n
5450	363	26	0da81037-d22d-42b4-9efa-0b8911e12371	ACCEPTED	5	1092	2026-06-16 23:31:27.800845+07	\N	\N	-30\n
5454	363	30	b76c6e73-9a9e-4b42-b5d3-a3a9c3a9255d	ACCEPTED	4	1020	2026-06-16 23:31:27.800848+07	\N	\N	0\n
5459	363	35	b8751fa4-dae3-4337-b6e5-5aea300cfe65	ACCEPTED	5	880	2026-06-16 23:31:27.800851+07	\N	\N	-2\n
5455	363	31	00bf1d52-5c71-41ec-a139-562db70bddc1	ACCEPTED	7	1108	2026-06-16 23:31:27.800849+07	\N	\N	30000\n
5445	363	21	d57a97d5-4da0-4e67-baf7-62aa6bff1cef	ACCEPTED	6	1032	2026-06-16 23:31:27.800822+07	\N	\N	3\n
5462	363	38	40b718cb-6a9a-4955-912a-a4f6eab687e4	ACCEPTED	6	1112	2026-06-16 23:31:27.800853+07	\N	\N	3000000\n
5448	363	24	a07146e0-d6ef-462c-9c5c-04dc541bcd59	ACCEPTED	6	860	2026-06-16 23:31:27.800844+07	\N	\N	0\n
5446	363	22	e76365e5-bf37-46b6-99c2-1c8b99b7b27c	ACCEPTED	7	888	2026-06-16 23:31:27.80084+07	\N	\N	30\n
5452	363	28	32f68418-f064-4070-8008-e55295b2ffe7	ACCEPTED	6	1008	2026-06-16 23:31:27.800847+07	\N	\N	579\n
5457	363	33	4cc3bb27-ca03-4714-8af2-a3c05282075b	ACCEPTED	4	1108	2026-06-16 23:31:27.80085+07	\N	\N	84\n
5458	363	34	6303451f-f35d-4f54-88bf-9b7aaa8c91a8	ACCEPTED	7	828	2026-06-16 23:31:27.800851+07	\N	\N	15\n
5460	363	36	cf64e734-a72c-4e56-acd6-47d5357e7c6d	ACCEPTED	4	876	2026-06-16 23:31:27.800852+07	\N	\N	801\n
5456	363	32	c8a85f7a-0482-45b3-8bed-65df4e8418df	ACCEPTED	4	876	2026-06-16 23:31:27.800849+07	\N	\N	0\n
5449	363	25	9cc03e52-18b4-42bf-95bb-cd01d477fa72	ACCEPTED	6	1036	2026-06-16 23:31:27.800845+07	\N	\N	300\n
5453	363	29	340c8105-e35a-443e-8513-bb8a51bb2d38	ACCEPTED	12	992	2026-06-16 23:31:27.800847+07	\N	\N	99\n
5451	363	27	0b44015d-c393-4f96-9ede-2e92249d191d	ACCEPTED	4	1016	2026-06-16 23:31:27.800846+07	\N	\N	1000\n
5461	363	37	7186d6fe-483b-4cad-a1ee-637b5e4c7eae	ACCEPTED	3	1132	2026-06-16 23:31:27.800853+07	\N	\N	1000\n
5447	363	23	1aa3b011-c62a-45d6-9bca-b2c7418f151e	ACCEPTED	4	1064	2026-06-16 23:31:27.800843+07	\N	\N	0\n
5773	387	47	677b3ccb-fb4e-4c29-ba7c-250953e1ae32	ACCEPTED	5	1272	2026-06-17 02:23:11.990592+07	\N	\N	101\n
5776	387	50	ae6c3547-8025-4b48-b86c-e7719a6c490d	ACCEPTED	5	1460	2026-06-17 02:23:11.990596+07	\N	\N	1009\n
5777	387	51	bb227421-ecd4-457b-82f8-a270bc16f4e8	ACCEPTED	6	1032	2026-06-17 02:23:11.990597+07	\N	\N	10007\n
5775	387	49	ca8400a3-2df1-47cf-a951-5a37306c2f49	ACCEPTED	5	1012	2026-06-17 02:23:11.990595+07	\N	\N	1009\n
5770	387	44	db827c45-6b37-4a78-a4ce-9f4b8c4215a6	ACCEPTED	5	988	2026-06-17 02:23:11.990589+07	\N	\N	11\n
5778	387	52	bcafa04b-f282-4b64-93ad-49b242c3644e	ACCEPTED	6	860	2026-06-17 02:23:11.990598+07	\N	\N	100003\n
5781	387	55	0c35a8e4-b2c7-41d7-9dd7-eca5383b1f8a	ACCEPTED	6	1024	2026-06-17 02:23:11.990601+07	\N	\N	1000003\n
5779	387	53	88dc2288-3995-415a-b863-8da7c3d9ae7c	ACCEPTED	6	1012	2026-06-17 02:23:11.990599+07	\N	\N	100003\n
5780	387	54	2d8bac08-30db-455f-8527-b456f92c7c24	ACCEPTED	3	1056	2026-06-17 02:23:11.9906+07	\N	\N	500009\n
5782	387	56	204f7317-6341-416e-9ed8-8aad9a0fb3a3	ACCEPTED	3	1124	2026-06-17 02:23:11.990602+07	\N	\N	1000003\n
6170	419	24	174f7a15-cb35-4d3f-9bdd-4aae4583904c	ACCEPTED	5	836	2026-06-19 00:25:03.395402+07	\N	\N	0\n
6184	419	38	bf08eb54-a962-4214-a257-f03745d226d3	ACCEPTED	4	872	2026-06-19 00:25:03.395418+07	\N	\N	3000000\n
6185	419	57	62590f91-6f98-4592-8eb9-453863bb1cd8	ACCEPTED	6	804	2026-06-19 00:25:03.39542+07	\N	\N	787228\n
6191	419	63	4b8d1c80-fa40-4ccb-8636-9bd05595647a	ACCEPTED	4	828	2026-06-19 00:25:03.395427+07	\N	\N	1507378\n
6199	419	71	40d6ca9d-4679-4e83-bdb7-12acd75ac18f	ACCEPTED	5	848	2026-06-19 00:25:03.395436+07	\N	\N	1416847\n
6208	419	80	5b803725-a4b8-400f-a1ab-22f9356ff842	ACCEPTED	6	876	2026-06-19 00:25:03.395446+07	\N	\N	-1611196\n
6251	419	123	3c3475a2-6216-4892-8ef3-cd59743f903b	ACCEPTED	4	868	2026-06-19 00:25:03.395513+07	\N	\N	1422690276\n
6252	419	124	39a144b3-2973-4305-abe9-57978bdd72dd	ACCEPTED	3	872	2026-06-19 00:25:03.395515+07	\N	\N	1610593689\n
6255	419	127	f1d639df-9a0a-4798-80a0-a5d441dedc0b	ACCEPTED	4	872	2026-06-19 00:25:03.395519+07	\N	\N	0\n
6256	419	128	4a927692-4882-4699-be30-5c07f9783088	ACCEPTED	5	912	2026-06-19 00:25:03.39552+07	\N	\N	82\n
6253	419	125	08660e68-f20a-4fd9-826b-9bf838172a4e	ACCEPTED	4	836	2026-06-19 00:25:03.395516+07	\N	\N	86961293\n
6254	419	126	c94dca42-8cf1-4f59-a9e5-81ffa89d1d3d	ACCEPTED	4	864	2026-06-19 00:25:03.395518+07	\N	\N	-882105735\n
6257	419	129	e92876d6-4ee9-402a-9156-b330ff3d28f9	ACCEPTED	4	888	2026-06-19 00:25:03.395521+07	\N	\N	-32\n
6258	419	130	a1c0cf3d-74ef-4e46-82e2-d01e7bae9c3d	ACCEPTED	4	864	2026-06-19 00:25:03.395523+07	\N	\N	-5\n
6259	419	131	00e4e806-129e-4f62-8aef-e3a7b88ef31f	ACCEPTED	6	1052	2026-06-19 00:25:03.395524+07	\N	\N	71\n
6260	419	132	5bcd83e9-17b0-4a9b-a8d0-fcdac7418614	ACCEPTED	5	864	2026-06-19 00:25:03.395525+07	\N	\N	-1\n
6261	419	133	dc31f68f-af51-4357-8ccd-dc6c908de7c7	ACCEPTED	4	924	2026-06-19 00:25:03.395526+07	\N	\N	-57\n
6262	419	134	ae768b81-3a1b-4977-86ed-aee5c37c286d	ACCEPTED	4	864	2026-06-19 00:25:03.395527+07	\N	\N	158\n
6263	419	135	841acd5c-98b7-4c29-9458-9e209bf86666	ACCEPTED	3	864	2026-06-19 00:25:03.395528+07	\N	\N	3\n
6264	419	136	77ac1fe8-d235-430b-84a2-8cacaa306f01	ACCEPTED	2	1068	2026-06-19 00:25:03.395529+07	\N	\N	129\n
6266	419	138	87b08877-2a15-4e48-816a-b2d4779db638	ACCEPTED	2	864	2026-06-19 00:25:03.395532+07	\N	\N	51\n
6265	419	137	9fce4969-ab77-46b5-b514-a09936939586	ACCEPTED	2	864	2026-06-19 00:25:03.39553+07	\N	\N	64\n
7245	441	27	963b0402-652b-47bb-95bd-cd036bfb3791	ACCEPTED	4	1032	2026-06-19 01:46:36.145593+07	\N	\N	1000\n
7247	441	29	dd4fe286-9e7b-4fb9-8298-7e3caf607943	ACCEPTED	4	884	2026-06-19 01:46:36.145595+07	\N	\N	99\n
7244	441	26	fa0380ec-bd94-44fb-8686-334c7998bb94	ACCEPTED	7	1028	2026-06-19 01:46:36.145591+07	\N	\N	-30\n
5412	356	34	53a4f49f-cfe0-4811-836e-e7ccf697235e	ACCEPTED	5	1692	2026-06-16 22:51:40.395687+07	\N	\N	15\n
5411	356	33	d2367f12-9719-450d-80d3-741e3595a4b5	ACCEPTED	5	2544	2026-06-16 22:51:40.395686+07	\N	\N	84\n
5401	356	23	86f29ffc-fc13-4edc-ba84-b321673ad320	ACCEPTED	5	4548	2026-06-16 22:51:40.39567+07	\N	\N	0\n
5403	356	25	ef392f04-5f6d-42f4-b0fa-9e55335788ea	ACCEPTED	5	5852	2026-06-16 22:51:40.395671+07	\N	\N	300\n
5413	356	35	10125c5c-aa96-4447-bbc2-6cf3b1fc6cf1	ACCEPTED	5	2300	2026-06-16 22:51:40.395688+07	\N	\N	-2\n
5414	356	36	d23d2833-fc1c-4f35-85b7-e0bc1f52c9db	ACCEPTED	4	1632	2026-06-16 22:51:40.395688+07	\N	\N	801\n
5400	356	22	12a559ac-f15e-42c3-b60e-a69a4833933c	ACCEPTED	6	2140	2026-06-16 22:51:40.395669+07	\N	\N	30\n
5416	356	38	ecea0a4d-b83d-4162-803d-9b2e0768e2b3	ACCEPTED	7	2128	2026-06-16 22:51:40.395689+07	\N	\N	3000000\n
5409	356	31	efa734e1-f22b-459d-bf19-2bf379c579be	ACCEPTED	5	3580	2026-06-16 22:51:40.395685+07	\N	\N	30000\n
5407	356	29	b9cdfc3c-3f38-4c99-9fd6-e98ee3ce2caa	ACCEPTED	6	5392	2026-06-16 22:51:40.395684+07	\N	\N	99\n
5402	356	24	773a1b68-4ab8-4217-9f85-efb774b9dbf2	ACCEPTED	6	2132	2026-06-16 22:51:40.395671+07	\N	\N	0\n
5406	356	28	3c289ee8-32a6-4193-be86-b8bc20bf14df	ACCEPTED	9	2304	2026-06-16 22:51:40.395683+07	\N	\N	579\n
5415	356	37	515c5d32-2753-4e16-baea-7d389744a815	ACCEPTED	5	2840	2026-06-16 22:51:40.395689+07	\N	\N	1000\n
5405	356	27	048dd535-00d1-4fc9-876f-f3cdf7a90b39	ACCEPTED	4	2832	2026-06-16 22:51:40.395672+07	\N	\N	1000\n
5399	356	21	56a333c8-9e9c-4c6f-8c10-08ff61e16e38	ACCEPTED	4	1820	2026-06-16 22:51:40.395663+07	\N	\N	3\n
5404	356	26	7c8bdb0d-22ea-466f-a1e6-f014d332b4c0	ACCEPTED	7	2464	2026-06-16 22:51:40.395672+07	\N	\N	-30\n
5408	356	30	8c2159b7-5bde-447c-b3c0-20f898e00524	ACCEPTED	12	2168	2026-06-16 22:51:40.395685+07	\N	\N	0\n
5410	356	32	04be3cf2-39cc-47bc-b1d1-74ce8fe82e6b	ACCEPTED	4	2272	2026-06-16 22:51:40.395686+07	\N	\N	0\n
5437	362	31	2cceea8a-52a8-4b92-ad83-154d7f856144	ACCEPTED	6	992	2026-06-16 23:26:44.792108+07	\N	\N	30000\n
5771	387	45	0a781cfc-7cc3-4c6b-bb17-f8e3f2ed3bf5	ACCEPTED	8	1044	2026-06-17 02:23:11.99059+07	\N	\N	11\n
6178	419	32	ae8f96fb-b360-44c9-ad94-9efd83f69f75	ACCEPTED	7	868	2026-06-19 00:25:03.395411+07	\N	\N	0\n
6209	419	81	ab7f35c7-9fd8-47a9-9ca1-75707fa199ca	ACCEPTED	4	836	2026-06-19 00:25:03.395447+07	\N	\N	-846475\n
6370	421	24	6e54dcca-e902-47bf-a47f-37da963f995b	ACCEPTED	6	1012	2026-06-19 00:31:33.333721+07	\N	\N	0\n
6367	421	21	e421fe77-6a2d-400a-912a-946e0fc0a836	ACCEPTED	6	1096	2026-06-19 00:31:33.333703+07	\N	\N	3\n
6382	421	36	160ee23e-9015-4121-a7be-0a40af85e059	ACCEPTED	6	888	2026-06-19 00:31:33.333728+07	\N	\N	801\n
6381	421	35	5667ea43-de63-4b54-a72b-a927accf8378	ACCEPTED	6	1032	2026-06-19 00:31:33.333727+07	\N	\N	-2\n
6384	421	38	76c14847-d73b-4942-9f29-f6974421b9c3	ACCEPTED	6	1016	2026-06-19 00:31:33.333729+07	\N	\N	3000000\n
6371	421	25	a81657ff-653d-42d2-bd80-aef17b5480b3	ACCEPTED	5	964	2026-06-19 00:31:33.333722+07	\N	\N	300\n
6375	421	29	bf81b022-25f4-4384-94bb-df6d0ed7ea21	ACCEPTED	5	1020	2026-06-19 00:31:33.333724+07	\N	\N	99\n
6376	421	30	0b038f44-3ac0-449e-94ec-2cff46975b87	ACCEPTED	6	1040	2026-06-19 00:31:33.333724+07	\N	\N	0\n
6374	421	28	12089455-ce8c-4050-9664-0116d29f17e5	ACCEPTED	5	1020	2026-06-19 00:31:33.333723+07	\N	\N	579\n
6368	421	22	df5ef2f4-e472-4476-83d6-00613189fa14	ACCEPTED	15	860	2026-06-19 00:31:33.33372+07	\N	\N	30\n
6390	421	62	f67abff3-327c-431a-8123-b5f097b017df	ACCEPTED	5	868	2026-06-19 00:31:33.333732+07	\N	\N	1486218\n
6388	421	60	c2052e02-6cc7-45e9-a4e4-86ddd3e06521	ACCEPTED	5	868	2026-06-19 00:31:33.333731+07	\N	\N	380371\n
6380	421	34	7944d6f7-735b-4977-8152-17a44981ab39	ACCEPTED	7	856	2026-06-19 00:31:33.333727+07	\N	\N	15\n
6389	421	61	b87b7a1f-3a75-4763-b73e-bb65a9f95c60	ACCEPTED	5	992	2026-06-19 00:31:33.333732+07	\N	\N	879721\n
6377	421	31	ee8e4c35-58c7-46d4-8841-99c3313349df	ACCEPTED	18	992	2026-06-19 00:31:33.333725+07	\N	\N	30000\n
6386	421	58	7f5d06e5-8d08-43d3-9dea-92b028e72aa1	ACCEPTED	8	1024	2026-06-19 00:31:33.33373+07	\N	\N	803799\n
6383	421	37	75eee292-d14e-432d-8a6b-8e3d81e4327d	ACCEPTED	6	868	2026-06-19 00:31:33.333728+07	\N	\N	1000\n
6378	421	32	3a7bc1f1-9997-4a0c-89ab-3c8c64e6815c	ACCEPTED	17	848	2026-06-19 00:31:33.333725+07	\N	\N	0\n
6385	421	57	4efa3b9e-0a3c-48d8-868c-128b7e24df3f	ACCEPTED	5	1080	2026-06-19 00:31:33.333729+07	\N	\N	787228\n
6393	421	65	b5a91ca0-29ef-45eb-a423-902439834a71	ACCEPTED	6	1020	2026-06-19 00:31:33.333734+07	\N	\N	475745\n
6395	421	67	cf3436a6-6ac2-43f2-a7e9-0349fad906dc	ACCEPTED	8	884	2026-06-19 00:31:33.333735+07	\N	\N	473222\n
6394	421	66	e2109730-790f-4d62-a838-ed306d61eade	ACCEPTED	8	1068	2026-06-19 00:31:33.333735+07	\N	\N	129492\n
6392	421	64	3edb9c36-e350-489f-a84b-f30107a4b8bc	ACCEPTED	5	1100	2026-06-19 00:31:33.333733+07	\N	\N	710339\n
6391	421	63	9d71cf50-d55d-4845-abb2-43e53bae1504	ACCEPTED	7	1028	2026-06-19 00:31:33.333733+07	\N	\N	1507378\n
6399	421	71	0aedca8d-a500-4baa-bb1f-a2fe1d7164d7	ACCEPTED	8	1020	2026-06-19 00:31:33.333737+07	\N	\N	1416847\n
6402	421	74	0d214af9-c10d-4022-9a72-35a8b4f508d7	ACCEPTED	8	1016	2026-06-19 00:31:33.333739+07	\N	\N	909595\n
6398	421	70	1886ff92-5078-46a2-90c4-0a50911f873a	ACCEPTED	13	976	2026-06-19 00:31:33.333737+07	\N	\N	959298\n
6407	421	79	6fc27ecf-cc0b-4f64-8a09-75100c5a6b87	ACCEPTED	9	1004	2026-06-19 00:31:33.333768+07	\N	\N	-1351853\n
6397	421	69	52bd191b-ea5e-4199-9f98-6cedab5e11ca	ACCEPTED	7	980	2026-06-19 00:31:33.333736+07	\N	\N	616334\n
6410	421	82	066ec9f9-c4bf-4fb0-83ae-fe206c39803d	ACCEPTED	6	992	2026-06-19 00:31:33.33377+07	\N	\N	-1795574\n
6403	421	75	ccedbd56-0827-4798-82ef-d78db97b8139	ACCEPTED	4	1100	2026-06-19 00:31:33.33374+07	\N	\N	1760278\n
6401	421	73	017b8aa4-e1cd-4569-abf3-d134f677aeb3	ACCEPTED	5	884	2026-06-19 00:31:33.333739+07	\N	\N	702179\n
6406	421	78	2ca49c16-736d-4f1e-b827-57aed684cc13	ACCEPTED	5	876	2026-06-19 00:31:33.333767+07	\N	\N	-824805\n
6408	421	80	b1a2bf29-9626-4056-ac12-c8d6b9d39302	ACCEPTED	14	1088	2026-06-19 00:31:33.333768+07	\N	\N	-1611196\n
6404	421	76	58b4066f-0dc0-42f2-9807-1111b027cc44	ACCEPTED	5	852	2026-06-19 00:31:33.333741+07	\N	\N	802483\n
6409	421	81	de397e6e-6b53-45e4-977d-d1dcb696732e	ACCEPTED	4	1044	2026-06-19 00:31:33.333769+07	\N	\N	-846475\n
5435	362	29	9a12cbbb-e0c5-4951-b37c-8a092cf7c1d5	ACCEPTED	4	5480	2026-06-16 23:26:44.792107+07	\N	\N	99\n
5793	388	49	75e822ca-0605-4a14-977e-865daeb55b59	ACCEPTED	4	2408	2026-06-17 02:37:15.195306+07	\N	\N	1009\n
5792	388	48	33e7fe71-093e-4844-8640-677225a0d3f8	ACCEPTED	4	1272	2026-06-17 02:37:15.195305+07	\N	\N	101\n
5785	388	41	63dae6b1-b5dc-4181-bb5f-df54d99a8602	ACCEPTED	4	5596	2026-06-17 02:37:15.195299+07	\N	\N	3\n
5797	388	53	f5c04342-7715-4174-ae54-f8c4007a83f3	ACCEPTED	5	2232	2026-06-17 02:37:15.195309+07	\N	\N	100003\n
5789	388	45	65e64cc3-4eea-499a-b317-6bdceb57b59b	ACCEPTED	5	2380	2026-06-17 02:37:15.195303+07	\N	\N	11\n
5784	388	40	1b68f256-1dfc-48b3-9934-f097e5a0324f	ACCEPTED	4	3820	2026-06-17 02:37:15.195299+07	\N	\N	2\n
5800	388	56	7b9d6a79-0c84-4b6a-8c84-58a6f56499eb	ACCEPTED	5	2112	2026-06-17 02:37:15.195311+07	\N	\N	1000003\n
5796	388	52	be642654-bd3f-4cbb-abcb-fa4a7ad44cc6	ACCEPTED	6	2732	2026-06-17 02:37:15.195308+07	\N	\N	100003\n
5783	388	39	4b167a08-a936-4c23-9299-8bdffb1f7f81	ACCEPTED	5	5160	2026-06-17 02:37:15.19529+07	\N	\N	17\n
5791	388	47	7f29d297-df28-4224-a858-a8f485bc68f7	ACCEPTED	5	2516	2026-06-17 02:37:15.195304+07	\N	\N	101\n
5799	388	55	14ecc414-04bb-4440-9f3f-0d27fd34b785	ACCEPTED	5	2340	2026-06-17 02:37:15.195311+07	\N	\N	1000003\n
5787	388	43	74828dea-5e10-49b5-9ed1-8ce08001dce1	ACCEPTED	4	1492	2026-06-17 02:37:15.195301+07	\N	\N	5\n
5790	388	46	65083539-6f9c-49af-990c-c4a3d69866b4	ACCEPTED	4	2340	2026-06-17 02:37:15.195303+07	\N	\N	23\n
5788	388	44	b7e42e58-c9b8-4a3a-8e64-53209dd09089	ACCEPTED	4	3208	2026-06-17 02:37:15.195302+07	\N	\N	11\n
5786	388	42	eeb87125-3bc9-40e4-9f8b-28c4346a7fe8	ACCEPTED	5	2288	2026-06-17 02:37:15.1953+07	\N	\N	5\n
5798	388	54	c90b2e31-0a84-44e0-9280-e2729ffcaf83	ACCEPTED	4	1732	2026-06-17 02:37:15.19531+07	\N	\N	500009\n
5794	388	50	27f85e7a-8d93-4647-9d78-b36371508a6c	ACCEPTED	5	2332	2026-06-17 02:37:15.195307+07	\N	\N	1009\n
5795	388	51	b9ab5793-f37c-4666-9c55-e35558a937b3	ACCEPTED	4	3116	2026-06-17 02:37:15.195308+07	\N	\N	10007\n
5807	392	5	c4122dfb-c0e6-4f14-8542-7687eef922d3	PENDING	\N	\N	2026-06-18 23:29:25.372607+07	\N	\N	\N
5808	392	6	acf1a322-e16e-43b5-b097-008a003889f0	PENDING	\N	\N	2026-06-18 23:29:25.372628+07	\N	\N	\N
6216	419	88	92e28753-dde8-4c6e-a9b5-33d2a5aa9fa3	ACCEPTED	4	836	2026-06-19 00:25:03.395458+07	\N	\N	-955984\n
6222	419	94	9ba04db1-79c5-40e5-a6e0-eeee210053d1	ACCEPTED	3	836	2026-06-19 00:25:03.395465+07	\N	\N	-717234\n
6227	419	99	fd15e124-a417-49c9-94c6-6649a1cf2241	ACCEPTED	9	800	2026-06-19 00:25:03.39547+07	\N	\N	-1225775\n
6244	419	116	bd965bf2-7363-44f1-99f0-da4ece951533	ACCEPTED	3	848	2026-06-19 00:25:03.395504+07	\N	\N	785356\n
6413	421	85	f27ff5bf-b943-4e5a-b220-ed42efc837c5	ACCEPTED	10	1036	2026-06-19 00:31:33.333772+07	\N	\N	-1006285\n
6411	421	83	988ab04f-b084-4b66-b8ac-1d7f3d1787d6	ACCEPTED	5	1028	2026-06-19 00:31:33.33377+07	\N	\N	-1500204\n
6414	421	86	afaef36a-d7ee-42f4-9227-da258d98e300	ACCEPTED	8	860	2026-06-19 00:31:33.333772+07	\N	\N	-876295\n
6412	421	84	af9a506b-57b7-4855-93c4-4358d5f2628d	ACCEPTED	10	1000	2026-06-19 00:31:33.333771+07	\N	\N	-734921\n
6416	421	88	7132a44d-3b76-491d-bb0b-6ac9e2abff5e	ACCEPTED	9	940	2026-06-19 00:31:33.333773+07	\N	\N	-955984\n
6420	421	92	411b77a3-06d0-41cf-854f-fcfbd083004d	ACCEPTED	5	1100	2026-06-19 00:31:33.333776+07	\N	\N	-471131\n
6415	421	87	14048b2b-b835-43e7-8785-6238ed194ef4	ACCEPTED	5	1024	2026-06-19 00:31:33.333773+07	\N	\N	-1189260\n
6424	421	96	ea8dfe35-1cc1-40ad-8135-209d4b5899a3	ACCEPTED	7	836	2026-06-19 00:31:33.333778+07	\N	\N	-1188270\n
6417	421	89	a59494d4-c82b-49df-8f95-1afe4dee0f32	ACCEPTED	8	984	2026-06-19 00:31:33.333774+07	\N	\N	-902015\n
6429	421	101	ea07578f-f74f-4dde-b5e2-86c11751ea26	ACCEPTED	5	1032	2026-06-19 00:31:33.333781+07	\N	\N	28962\n
6423	421	95	22a95360-38ad-4d8c-a5cb-ad97110c5793	ACCEPTED	4	872	2026-06-19 00:31:33.333777+07	\N	\N	-1192974\n
6421	421	93	45e78c2b-5215-425a-8a4f-51711908bf36	ACCEPTED	5	1028	2026-06-19 00:31:33.333776+07	\N	\N	-422973\n
6419	421	91	0c52122f-519c-4e62-a5fc-b74e440e6f98	ACCEPTED	7	868	2026-06-19 00:31:33.333775+07	\N	\N	-1113725\n
6418	421	90	987688f1-1316-48bc-a125-c68a2f1bbf95	ACCEPTED	8	1024	2026-06-19 00:31:33.333775+07	\N	\N	-1520451\n
6425	421	97	bca0c96f-1e93-4b2d-80d3-7e38e040e840	ACCEPTED	5	868	2026-06-19 00:31:33.333778+07	\N	\N	-517131\n
6428	421	100	8be3f429-a943-4551-8cbe-87ae0bbcf988	ACCEPTED	5	864	2026-06-19 00:31:33.33378+07	\N	\N	281928\n
6432	421	104	f07b0c66-59f0-49ae-9304-5387851a63f9	ACCEPTED	6	828	2026-06-19 00:31:33.333782+07	\N	\N	514364\n
6430	421	102	8e111d0c-11ac-4819-8569-3e2934f834f0	ACCEPTED	8	980	2026-06-19 00:31:33.333781+07	\N	\N	-619866\n
6427	421	99	0db003e3-081c-4d42-9f55-e1b279aa6c20	ACCEPTED	5	820	2026-06-19 00:31:33.33378+07	\N	\N	-1225775\n
6433	421	105	99f45100-ca7f-4eb4-b166-44f4d0caca84	ACCEPTED	5	868	2026-06-19 00:31:33.333783+07	\N	\N	-882565\n
6422	421	94	7c1a84f2-3910-4082-b8fc-aeaffeaac097	ACCEPTED	5	880	2026-06-19 00:31:33.333777+07	\N	\N	-717234\n
6426	421	98	0ee084aa-ac34-4d91-8f45-fe2c6bfc9b3e	ACCEPTED	7	1004	2026-06-19 00:31:33.333779+07	\N	\N	99178\n
6431	421	103	434859a7-f821-4683-be79-8ec4efd54efd	ACCEPTED	5	840	2026-06-19 00:31:33.333782+07	\N	\N	283996\n
7254	441	36	d3400613-c0d3-4373-a2d0-2780c5ea6c79	ACCEPTED	8	856	2026-06-19 01:46:36.145605+07	\N	\N	801\n
7257	441	57	196c50f2-9ec8-4f9b-a10a-4aea261ded96	ACCEPTED	6	876	2026-06-19 01:46:36.14561+07	\N	\N	787228\n
7255	441	37	842a82b2-c904-47a6-a760-92869a6f4aa7	ACCEPTED	7	1016	2026-06-19 01:46:36.145607+07	\N	\N	1000\n
7256	441	38	6d54c3be-3d89-4d7c-95bd-545cb9333ad4	ACCEPTED	5	984	2026-06-19 01:46:36.145608+07	\N	\N	3000000\n
7258	441	58	552bf5d9-1921-4984-9f67-10c449ddfce1	ACCEPTED	5	1020	2026-06-19 01:46:36.145611+07	\N	\N	803799\n
7260	441	60	6f4fb6d1-d0da-46a1-9c73-ec7c3169eb6d	ACCEPTED	12	876	2026-06-19 01:46:36.145614+07	\N	\N	380371\n
7262	441	62	d35e3119-d085-46f9-8e19-d80b6a8388eb	ACCEPTED	6	944	2026-06-19 01:46:36.145617+07	\N	\N	1486218\n
7253	441	35	6163644d-fa9c-4302-befa-3af09cb7b917	ACCEPTED	6	1020	2026-06-19 01:46:36.145604+07	\N	\N	-2\n
7252	441	34	93d1f036-9702-4820-b394-ad82ccb9f731	ACCEPTED	4	1020	2026-06-19 01:46:36.145602+07	\N	\N	15\n
7261	441	61	07d3a402-7282-4951-9cc8-57fbf65c68ee	ACCEPTED	5	1092	2026-06-19 01:46:36.145615+07	\N	\N	879721\n
5464	364	22	f233e3aa-3d3f-482d-b00f-b6d91bbdf88a	ACCEPTED	8	856	2026-06-16 23:40:59.437868+07	\N	\N	30\n
5463	364	21	6629d171-bae3-43dd-8415-aa09f47e7914	ACCEPTED	5	1036	2026-06-16 23:40:59.437859+07	\N	\N	3\n
5473	364	31	ffd6ffc4-0a8d-40f0-b450-433634dcc0cb	ACCEPTED	6	1100	2026-06-16 23:40:59.437893+07	\N	\N	30000\n
5469	364	27	713931cc-508e-49c0-a01e-d46e47b2c4c2	ACCEPTED	4	1116	2026-06-16 23:40:59.437871+07	\N	\N	1000\n
5468	364	26	3d8dc361-74ac-45ef-b7e5-90e35596ccbe	ACCEPTED	5	872	2026-06-16 23:40:59.43787+07	\N	\N	-30\n
5466	364	24	55217dde-12fa-4788-bfaf-b86070425714	ACCEPTED	6	1024	2026-06-16 23:40:59.437869+07	\N	\N	0\n
5467	364	25	57860ce2-a612-44ae-a571-7d3a4ce139d2	ACCEPTED	4	1036	2026-06-16 23:40:59.43787+07	\N	\N	300\n
5472	364	30	eced701a-5333-4e1d-b95d-36ffe5458eb4	ACCEPTED	5	1036	2026-06-16 23:40:59.437892+07	\N	\N	0\n
5475	364	33	7899752d-5c5f-41ae-bc43-21d78ef604a1	ACCEPTED	7	904	2026-06-16 23:40:59.437894+07	\N	\N	84\n
5465	364	23	ff5b27ea-8b37-41c1-86a6-5b9fcb4dbb67	ACCEPTED	5	1004	2026-06-16 23:40:59.437869+07	\N	\N	0\n
5480	364	38	830b7551-fa1e-4fa0-9671-dcd29000073c	ACCEPTED	4	1036	2026-06-16 23:40:59.437897+07	\N	\N	3000000\n
5479	364	37	d5235391-7d47-46e4-9882-cdd895912586	ACCEPTED	5	1036	2026-06-16 23:40:59.437896+07	\N	\N	1000\n
5474	364	32	e0366bb1-3bd8-4a93-86b8-335d57a70c29	ACCEPTED	3	996	2026-06-16 23:40:59.437893+07	\N	\N	0\n
5476	364	34	c09341aa-6e55-4119-8d87-844d73b789d6	ACCEPTED	5	876	2026-06-16 23:40:59.437895+07	\N	\N	15\n
5477	364	35	a7be56d1-4b04-4575-845d-85536971b25d	ACCEPTED	4	1048	2026-06-16 23:40:59.437895+07	\N	\N	-2\n
5470	364	28	80212269-94fb-4ead-8bd2-17e04656ff35	ACCEPTED	7	1048	2026-06-16 23:40:59.437871+07	\N	\N	579\n
5471	364	29	6fc38475-2bf3-42b3-b042-8d6eec59cff6	ACCEPTED	3	1056	2026-06-16 23:40:59.437872+07	\N	\N	99\n
5478	364	36	af90e3d7-6417-4c36-b077-26ec8e5d2e62	ACCEPTED	5	1080	2026-06-16 23:40:59.437896+07	\N	\N	801\n
5802	389	10	6893e390-76c5-409d-b356-c2da4cc07309	ACCEPTED	2	1164	2026-06-17 02:46:43.269402+07	\N	\N	7\n
5801	389	9	4542a913-febb-4637-aeae-0d3ff9d42ed5	ACCEPTED	2	1056	2026-06-17 02:46:43.269397+07	\N	\N	6\n
5803	390	11	96e7c7c3-61e8-451b-b775-c0a401a9583d	ACCEPTED	2	1956	2026-06-17 02:47:07.323889+07	\N	\N	4\n
5804	390	12	4a4dab5a-cbc9-4f13-976e-fe41fcde9929	ACCEPTED	2	1400	2026-06-17 02:47:07.323893+07	\N	\N	4\n
5805	391	11	f697ff5b-bc4e-443f-928b-aeab16b7931d	TIME_LIMIT_EXCEEDED	2083	1136	2026-06-17 02:47:16.27195+07	\N	\N	\N
5806	391	12	6b3e4a71-c286-470f-93d8-d1e4e63edd2d	TIME_LIMIT_EXCEEDED	2083	1072	2026-06-17 02:47:16.271955+07	\N	\N	\N
5809	393	5	8ec0de35-1e56-46ec-b602-67b6ac3caff2	ACCEPTED	2	980	2026-06-18 23:30:39.590229+07	\N	\N	YES\n
5810	393	6	bcc30215-aa19-48f3-99bc-22ed0416f018	ACCEPTED	2	1076	2026-06-18 23:30:39.590247+07	\N	\N	NO\n
5812	394	6	5597226b-3c61-4610-a14d-306e8cdc097b	ACCEPTED	3	1108	2026-06-18 23:30:52.150375+07	\N	\N	NO\n
5811	394	5	a061d2ab-d037-42dd-b603-391c5ed87b45	ACCEPTED	3	1096	2026-06-18 23:30:52.150364+07	\N	\N	YES\n
5814	395	4	7d729d38-d952-406d-b6d4-c49df88213c7	ACCEPTED	108	36496	2026-06-18 23:43:49.656874+07	\N	\N	-1\n
5813	395	3	7986b885-2b17-4207-a0c9-e8bcbb0a635b	ACCEPTED	111	34660	2026-06-18 23:43:49.656864+07	\N	\N	9\n
5815	396	3	fd12a6aa-7f19-4892-96c1-e39a75c22c39	ACCEPTED	89	15208	2026-06-18 23:44:01.19513+07	\N	\N	9\n
5816	396	4	46615fbe-f84c-452d-88ce-80ae616adaa3	ACCEPTED	91	15624	2026-06-18 23:44:01.19514+07	\N	\N	-1\n
6250	419	122	eeaf0f6c-eacd-48b2-93bf-c1487a5550d1	ACCEPTED	4	828	2026-06-19 00:25:03.395512+07	\N	\N	-457820119\n
6434	421	106	c479dd77-ae44-49c1-a62c-f8fcf61e3da7	ACCEPTED	6	980	2026-06-19 00:31:33.333783+07	\N	\N	-815576\n
6435	421	107	e4cf2d99-f084-4e10-ab29-a0df3f1fa70f	ACCEPTED	4	836	2026-06-19 00:31:33.333784+07	\N	\N	-34648\n
6438	421	110	35caeb80-c984-4b4f-9740-cf5efb3d9dae	ACCEPTED	5	1028	2026-06-19 00:31:33.333785+07	\N	\N	-572819\n
6436	421	108	dd4c551a-c9b4-49ab-bc7e-fc92c1fefb41	ACCEPTED	5	1080	2026-06-19 00:31:33.333784+07	\N	\N	1436130\n
6437	421	109	1ebf0fa5-b3ab-47d1-8cee-46611dbc2960	ACCEPTED	8	864	2026-06-19 00:31:33.333785+07	\N	\N	792531\n
6439	421	111	db89cf84-6202-4e00-8a58-f5c759ac7dab	ACCEPTED	9	1008	2026-06-19 00:31:33.333786+07	\N	\N	-309452\n
6440	421	112	a421456d-8ab9-4c5c-8e32-2aadb8e1fe1a	ACCEPTED	4	1016	2026-06-19 00:31:33.333786+07	\N	\N	649261\n
6444	421	116	a046f78d-4eb0-44bc-81f0-3ec37f7e290d	ACCEPTED	12	1008	2026-06-19 00:31:33.333788+07	\N	\N	785356\n
6448	421	120	f6130380-4df7-441b-947f-9aa4d66e2ded	ACCEPTED	7	880	2026-06-19 00:31:33.33379+07	\N	\N	371467497\n
6441	421	113	48112003-326e-44f5-bcb4-2d400d32800a	ACCEPTED	7	988	2026-06-19 00:31:33.333787+07	\N	\N	-1143916\n
6442	421	114	b6662046-ea72-4696-8c1d-b8c4da4fdc2a	ACCEPTED	6	1096	2026-06-19 00:31:33.333787+07	\N	\N	-234796\n
6449	421	121	b291cd29-5901-4068-88e0-69d1e9a7fd77	ACCEPTED	5	1036	2026-06-19 00:31:33.333791+07	\N	\N	1259817393\n
6445	421	117	a7d102c2-b507-45ed-868a-2acda8b735ba	ACCEPTED	6	840	2026-06-19 00:31:33.333789+07	\N	\N	362210245\n
6450	421	122	efc8be0b-1958-442b-898d-d4ab01bfaab9	ACCEPTED	5	1096	2026-06-19 00:31:33.333792+07	\N	\N	-457820119\n
6447	421	119	c36a21c1-ef5a-4eed-82fd-480bb3d2293a	ACCEPTED	5	872	2026-06-19 00:31:33.33379+07	\N	\N	-738231997\n
6446	421	118	9a351297-aca2-4e8b-b421-08943726a9fc	ACCEPTED	5	1024	2026-06-19 00:31:33.333789+07	\N	\N	636465324\n
6451	421	123	345e9ce8-49b1-43a0-9eda-a215dc324c86	ACCEPTED	6	880	2026-06-19 00:31:33.333792+07	\N	\N	1422690276\n
6443	421	115	930ff8ae-a569-4198-ae1a-458818aa0614	ACCEPTED	9	1088	2026-06-19 00:31:33.333788+07	\N	\N	506806\n
7263	441	63	7f4173f5-e296-4dd6-b618-7785d8b98aaf	ACCEPTED	6	1032	2026-06-19 01:46:36.145618+07	\N	\N	1507378\n
7268	441	68	781aebc8-63bd-4292-8d97-69249a37271d	ACCEPTED	5	1024	2026-06-19 01:46:36.145625+07	\N	\N	1161167\n
7271	441	71	ee0cc5a4-a64d-4fd9-b58f-2956924cddfb	ACCEPTED	8	1016	2026-06-19 01:46:36.145629+07	\N	\N	1416847\n
7265	441	65	4058d57c-17d4-4a97-8559-d104ae9fb8d3	ACCEPTED	4	1020	2026-06-19 01:46:36.145621+07	\N	\N	475745\n
7267	441	67	cbb92dbf-ca19-4aad-a937-e969aee8f907	ACCEPTED	7	860	2026-06-19 01:46:36.145624+07	\N	\N	473222\n
7269	441	69	6df2e11c-69e6-4433-9866-678daf027956	ACCEPTED	6	1024	2026-06-19 01:46:36.145626+07	\N	\N	616334\n
7270	441	70	64ddfcc4-ef3c-4ad6-b777-e8815d594b59	ACCEPTED	6	1028	2026-06-19 01:46:36.145628+07	\N	\N	959298\n
5482	365	4	e7725588-8de8-4928-b5ad-fe0c6b9bbac1	ACCEPTED	81	33864	2026-06-16 23:45:16.561015+07	\N	\N	-1\n
5481	365	3	b9c35238-cdfd-493b-ad08-a6000773b568	ACCEPTED	85	37804	2026-06-16 23:45:16.561007+07	\N	\N	9\n
5483	366	21	1f44d99d-4556-484f-9fda-0a14ce34fd7c	ACCEPTED	6	864	2026-06-16 23:46:11.796807+07	\N	\N	3\n
5489	366	27	4693c05d-1301-452c-bae4-687390e197ec	ACCEPTED	8	1020	2026-06-16 23:46:11.79686+07	\N	\N	1000\n
5492	366	30	5193b44e-a110-467c-ad86-b48e5b2e6cb3	ACCEPTED	7	1012	2026-06-16 23:46:11.796863+07	\N	\N	0\n
5485	366	23	1c4ef07d-c4af-4286-b25d-4e56ab6509a9	ACCEPTED	6	984	2026-06-16 23:46:11.796813+07	\N	\N	0\n
5491	366	29	375b4da6-cf01-45aa-8945-7eb08f309ecf	ACCEPTED	5	1032	2026-06-16 23:46:11.796862+07	\N	\N	99\n
5496	366	34	6ce7f3cc-51f3-4801-adf7-3d6fdb2e526a	ACCEPTED	16	860	2026-06-16 23:46:11.796868+07	\N	\N	15\n
5493	366	31	c8caaac5-6304-4c1d-bef6-f8d39a6b5a40	ACCEPTED	10	800	2026-06-16 23:46:11.796864+07	\N	\N	30000\n
5487	366	25	53335514-cd49-4ceb-94d1-cefa2a350058	ACCEPTED	9	1028	2026-06-16 23:46:11.796837+07	\N	\N	300\n
5484	366	22	7360b08d-4793-4134-99b4-6b40b69f1fab	ACCEPTED	5	1020	2026-06-16 23:46:11.796812+07	\N	\N	30\n
5498	366	36	b2746c0f-9962-43ff-8f74-5bfe59316d7f	ACCEPTED	4	1036	2026-06-16 23:46:11.79687+07	\N	\N	801\n
5486	366	24	fd44e27a-c12a-45ea-bd5b-c7dfb92db6b3	ACCEPTED	5	1024	2026-06-16 23:46:11.796813+07	\N	\N	0\n
5490	366	28	76365312-f1af-481c-b6a8-251398e4144b	ACCEPTED	5	968	2026-06-16 23:46:11.796861+07	\N	\N	579\n
5499	366	37	a38e94cd-fea6-4ff9-91bb-58b9c920d837	ACCEPTED	4	1040	2026-06-16 23:46:11.796898+07	\N	\N	1000\n
5495	366	33	555e118b-9075-4e41-beb2-0f53245e6c70	ACCEPTED	6	1036	2026-06-16 23:46:11.796867+07	\N	\N	84\n
5497	366	35	188cfa49-e4ad-4b1d-a533-4efa3fc43090	ACCEPTED	4	876	2026-06-16 23:46:11.796869+07	\N	\N	-2\n
5500	366	38	f0afde77-f5ae-4e67-80e1-d0cd52e05034	ACCEPTED	4	1036	2026-06-16 23:46:11.796899+07	\N	\N	3000000\n
5488	366	26	18af87b2-ce78-4352-874b-fe7fce9d52ea	ACCEPTED	8	1200	2026-06-16 23:46:11.796858+07	\N	\N	-30\n
5494	366	32	5ffad70b-c161-4936-b739-4ed3d70d4e42	ACCEPTED	6	1064	2026-06-16 23:46:11.796866+07	\N	\N	0\n
5817	397	3	aa32dfc2-77d4-476b-aa28-19d1024c4f3b	ACCEPTED	94	15068	2026-06-18 23:44:38.246719+07	\N	\N	9\n
5818	397	4	914117a4-889e-4e73-a477-7e562749ba2e	ACCEPTED	98	15264	2026-06-18 23:44:38.246738+07	\N	\N	-1\n
5820	398	4	47200bb9-fdfa-4cc5-9bdf-e14c05b63a72	ACCEPTED	108	14796	2026-06-18 23:44:48.306429+07	\N	\N	-1\n
5819	398	3	b2a829a5-d590-47f7-a7dc-790d346789c3	ACCEPTED	94	15180	2026-06-18 23:44:48.306416+07	\N	\N	9\n
5821	399	3	85ad72e5-0781-4fa1-8f84-8507d4752678	ACCEPTED	87	14860	2026-06-18 23:44:56.043505+07	\N	\N	9\n
5822	399	4	7f5cf18a-de07-4cc6-88b4-9601396ab792	ACCEPTED	89	15168	2026-06-18 23:44:56.043516+07	\N	\N	-1\n
5824	400	4	099e74b5-e1f4-4e5d-bf8b-436a98542212	ACCEPTED	96	14696	2026-06-18 23:45:00.924858+07	\N	\N	-1\n
5823	400	3	e26a41b8-c87a-4c9e-9270-9505f5524878	WRONG_ANSWER	95	15428	2026-06-18 23:45:00.924842+07	\N	\N	-1\n
5825	401	5	27f53a94-d6c2-45f1-8e01-5d72a99dc947	ACCEPTED	3	16684	2026-06-18 23:45:09.010246+07	\N	\N	YES\n
5826	401	6	f2c3f227-60a5-428f-a6e1-2682e8f98404	ACCEPTED	3	15376	2026-06-18 23:45:09.010258+07	\N	\N	NO\n
5828	402	6	35aa004f-9036-4956-98e5-1b6f342dbea9	ACCEPTED	2	1068	2026-06-18 23:45:14.170565+07	\N	\N	NO\n
5827	402	5	da34c594-60d6-4eca-9ac4-2695e2052c17	ACCEPTED	2	1056	2026-06-18 23:45:14.170556+07	\N	\N	YES\n
5830	403	6	34463897-554c-4ad6-a567-37483ea60aa1	ACCEPTED	2	1072	2026-06-18 23:45:17.88457+07	\N	\N	NO\n
5829	403	5	ce42990f-32c0-4cdf-ba70-1a303c1023f6	ACCEPTED	2	1060	2026-06-18 23:45:17.88456+07	\N	\N	YES\n
5831	404	5	895a7d65-c6db-4f33-9162-58fc06777e60	ACCEPTED	2	1032	2026-06-18 23:45:29.368781+07	\N	\N	YES\n
5832	404	6	b1a6b79d-6840-49c2-9c4e-f6f98b3dd14c	ACCEPTED	2	1048	2026-06-18 23:45:29.368789+07	\N	\N	NO\n
5833	405	5	08ddb882-d1f3-48e3-b249-bb5f369a3339	ACCEPTED	3	1108	2026-06-18 23:45:45.682343+07	\N	\N	YES\n
5834	405	6	703fc42c-5257-4455-b1fb-194cf9e3ef58	ACCEPTED	2	1056	2026-06-18 23:45:45.682357+07	\N	\N	NO\n
5836	406	6	6108990f-d1ca-4b38-b216-8276f07bf476	ACCEPTED	2	1056	2026-06-18 23:46:11.808026+07	\N	\N	NO\n
5835	406	5	b2fa783e-f0ea-434d-91a5-240615e4f1d9	ACCEPTED	2	1056	2026-06-18 23:46:11.808018+07	\N	\N	YES\n
5838	407	6	aac22439-7790-4651-94b6-b7de5a6e76fe	ACCEPTED	2	1032	2026-06-18 23:46:15.63221+07	\N	\N	NO\n
5837	407	5	3386d39a-bffe-47d0-b8a9-87cde727a5db	ACCEPTED	2	1244	2026-06-18 23:46:15.6322+07	\N	\N	YES\n
5839	408	5	55b9f356-8b39-4ef1-b259-f41956c21fe1	ACCEPTED	3	1052	2026-06-18 23:46:31.945416+07	\N	\N	YES\n
5840	408	6	43b6f61d-d3da-4cc2-a374-5038cd741133	ACCEPTED	2	1052	2026-06-18 23:46:31.945429+07	\N	\N	NO\n
5842	409	6	e5f1fe17-10b6-4d0f-a88f-2d1d3532bb98	ACCEPTED	2	1052	2026-06-18 23:49:06.36999+07	\N	\N	NO\n
5841	409	5	34284c0c-8b52-4858-96dc-2f1267b6da8d	ACCEPTED	2	1048	2026-06-18 23:49:06.369982+07	\N	\N	YES\n
5843	410	3	11b81135-ebc5-403b-8f3f-a114fa7930af	ACCEPTED	103	14936	2026-06-18 23:49:12.112039+07	\N	\N	9\n
5844	410	4	c90f172b-e234-41ca-86d6-b144a45b0ba8	ACCEPTED	76	15000	2026-06-18 23:49:12.112047+07	\N	\N	-1\n
5846	411	4	a3dffebc-13c6-48df-a59a-accbd58f19fa	ACCEPTED	85	15364	2026-06-18 23:49:15.139499+07	\N	\N	-1\n
5845	411	3	4f789664-229d-4ac5-affc-0798754443c2	ACCEPTED	88	15180	2026-06-18 23:49:15.139492+07	\N	\N	9\n
6267	420	21	e53312b9-3922-44e0-ae30-b213c648496d	ACCEPTED	6	1088	2026-06-19 00:26:04.575141+07	\N	\N	3\n
6268	420	22	0ae23e4d-d505-434d-8973-773b598d52ca	ACCEPTED	8	1016	2026-06-19 00:26:04.575147+07	\N	\N	30\n
6272	420	26	e3ab5447-b9f9-4ffc-aed4-9303a072517f	ACCEPTED	7	1080	2026-06-19 00:26:04.575151+07	\N	\N	-30\n
6273	420	27	6fe32925-f3e9-43c7-9ebe-ba1e7a2abde3	ACCEPTED	5	1020	2026-06-19 00:26:04.575152+07	\N	\N	1000\n
6271	420	25	6850da06-4660-409d-b077-34ab8ab6140d	ACCEPTED	4	864	2026-06-19 00:26:04.57515+07	\N	\N	300\n
6269	420	23	3161bf07-3906-40a0-97b7-db6b206cb1e8	ACCEPTED	5	800	2026-06-19 00:26:04.575148+07	\N	\N	0\n
6270	420	24	48583630-9cfe-4624-95c1-aa175e92d31d	ACCEPTED	5	1016	2026-06-19 00:26:04.575149+07	\N	\N	0\n
7273	441	73	c4fd7943-f2de-49c9-b996-2f8fdfb553ec	ACCEPTED	4	1088	2026-06-19 01:46:36.145632+07	\N	\N	702179\n
7274	441	74	bad4de7c-161b-429f-847d-a718e8253cda	ACCEPTED	5	1096	2026-06-19 01:46:36.145634+07	\N	\N	909595\n
5501	367	21	6084961e-f163-4974-9fc3-ce43f9fe25e6	ACCEPTED	6	864	2026-06-16 23:53:21.198304+07	\N	\N	3\n
5510	367	30	6c657bf1-e983-4c94-b44d-c71ff13c306f	ACCEPTED	7	944	2026-06-16 23:53:21.198312+07	\N	\N	0\n
5516	367	36	1909c207-b638-418d-bdf2-f4abecd2d9fe	ACCEPTED	7	968	2026-06-16 23:53:21.198318+07	\N	\N	801\n
5508	367	28	d99813d0-ded9-4f37-a0cf-facc4377e63d	ACCEPTED	6	1024	2026-06-16 23:53:21.198311+07	\N	\N	579\n
5512	367	32	7b3da085-9555-4022-b743-da0d03a7c541	ACCEPTED	5	1016	2026-06-16 23:53:21.198316+07	\N	\N	0\n
5503	367	23	58f7667f-5ed3-4e6b-99a7-9101e36e6e23	ACCEPTED	6	1024	2026-06-16 23:53:21.198309+07	\N	\N	0\n
5513	367	33	89aded9a-f7a8-4600-804a-80f0350d58fd	ACCEPTED	5	1016	2026-06-16 23:53:21.198317+07	\N	\N	84\n
5506	367	26	29864fe9-21eb-49f5-bf92-e7e76bd993bd	ACCEPTED	4	1032	2026-06-16 23:53:21.19831+07	\N	\N	-30\n
5511	367	31	8e1421b9-de38-49ac-9623-00dbb46c801f	ACCEPTED	8	984	2026-06-16 23:53:21.198313+07	\N	\N	30000\n
5502	367	22	ad87daa7-00be-400e-92ab-b97d639772bc	ACCEPTED	5	1016	2026-06-16 23:53:21.198308+07	\N	\N	30\n
5507	367	27	6c93cdbf-8053-4487-a0fa-7d02299483d5	ACCEPTED	5	864	2026-06-16 23:53:21.198311+07	\N	\N	1000\n
5505	367	25	ddeb3609-0ce6-4196-be99-510681f60ecf	ACCEPTED	4	864	2026-06-16 23:53:21.19831+07	\N	\N	300\n
5504	367	24	8ea74418-5c52-4c81-8a91-9fd4a81a4721	ACCEPTED	4	1016	2026-06-16 23:53:21.198309+07	\N	\N	0\n
5509	367	29	a65dd865-399e-48b9-b8be-7f35ff435b13	ACCEPTED	6	1012	2026-06-16 23:53:21.198312+07	\N	\N	99\n
5518	367	38	dd0222e1-655d-409d-a8cb-d07165fd2269	ACCEPTED	4	1012	2026-06-16 23:53:21.198319+07	\N	\N	3000000\n
5514	367	34	70d8778e-76b8-48d5-be6d-0ac36a090be0	ACCEPTED	7	956	2026-06-16 23:53:21.198317+07	\N	\N	15\n
5515	367	35	054eaab6-dc1f-4d8d-a123-287ed4401ad0	ACCEPTED	3	1060	2026-06-16 23:53:21.198318+07	\N	\N	-2\n
5517	367	37	568c343c-da8f-48a4-b89c-e8346958f660	ACCEPTED	2	1052	2026-06-16 23:53:21.198319+07	\N	\N	1000\n
5847	414	5	2b6d507f-e504-4680-a377-93a3cfade16a	ACCEPTED	2	16448	2026-06-19 00:15:31.704293+07	\N	\N	YES\n
5848	414	6	5ac1a1ac-673c-46e0-8c5a-7e6c5821cdba	ACCEPTED	2	16164	2026-06-19 00:15:31.704303+07	\N	\N	NO\n
5849	415	21	10a3fa18-7ec1-4111-a507-d04cf52dfd74	ACCEPTED	4	1032	2026-06-19 00:15:39.603776+07	\N	\N	3\n
5852	415	24	d00a453b-83a5-4bd8-9925-f43d7fae71b7	ACCEPTED	5	944	2026-06-19 00:15:39.603798+07	\N	\N	0\n
5861	415	33	f18adc1f-33e0-4282-b3c6-f6518f8e9ffc	ACCEPTED	5	1048	2026-06-19 00:15:39.603822+07	\N	\N	84\n
5851	415	23	7e23f67e-5ba3-4f5f-b0a3-ccbf32fc7f8a	ACCEPTED	5	992	2026-06-19 00:15:39.603795+07	\N	\N	0\n
5850	415	22	68dc28fb-4665-4505-bc47-d4bc7d8b9226	ACCEPTED	8	820	2026-06-19 00:15:39.603792+07	\N	\N	30\n
5855	415	27	d3d4131a-2ef2-415a-90be-3cea31d62e4d	ACCEPTED	5	876	2026-06-19 00:15:39.603806+07	\N	\N	1000\n
5858	415	30	af9213b2-61a9-4d16-a607-eeb5ea29d27b	ACCEPTED	5	1044	2026-06-19 00:15:39.603814+07	\N	\N	0\n
5854	415	26	40fc8adf-d010-45da-a142-c156c475d355	ACCEPTED	6	1068	2026-06-19 00:15:39.603803+07	\N	\N	-30\n
5853	415	25	1fd61a24-754d-4e86-a986-d43507724665	ACCEPTED	5	1100	2026-06-19 00:15:39.603801+07	\N	\N	300\n
5860	415	32	d4997934-ace2-4626-b911-7478ccd0a690	ACCEPTED	6	908	2026-06-19 00:15:39.60382+07	\N	\N	0\n
5862	415	34	89a2b84e-da8a-48f4-9524-80adaeac5d9f	ACCEPTED	4	900	2026-06-19 00:15:39.603826+07	\N	\N	15\n
5863	415	35	d34a90d0-b663-4417-9914-5b04704bdfa2	ACCEPTED	5	984	2026-06-19 00:15:39.603829+07	\N	\N	-2\n
5859	415	31	c567aad1-cdb5-46c4-a862-b9d994d98deb	ACCEPTED	4	1028	2026-06-19 00:15:39.603817+07	\N	\N	30000\n
5856	415	28	88190893-1d4e-43bb-b4a2-326632fd2c16	ACCEPTED	12	920	2026-06-19 00:15:39.603809+07	\N	\N	579\n
5866	415	38	a4075576-80f0-44a5-ae31-bd21df79d96f	ACCEPTED	8	1300	2026-06-19 00:15:39.603839+07	\N	\N	3000000\n
5857	415	29	5602633d-d4ee-4618-8305-6ca21d93c7d6	ACCEPTED	6	1000	2026-06-19 00:15:39.603812+07	\N	\N	99\n
5864	415	36	a034bb02-a8c6-4f4f-b58f-553f33291607	ACCEPTED	7	1256	2026-06-19 00:15:39.603833+07	\N	\N	801\n
5865	415	37	fec5d005-01e7-4c0b-836b-f13db294c614	ACCEPTED	5	1040	2026-06-19 00:15:39.603836+07	\N	\N	1000\n
6289	420	61	f4193c80-adeb-4957-915b-5094b58e1bde	ACCEPTED	5	1048	2026-06-19 00:26:04.575172+07	\N	\N	879721\n
6285	420	57	fe0f371a-ffd4-4e73-a29c-151020ae6570	ACCEPTED	6	1044	2026-06-19 00:26:04.575168+07	\N	\N	787228\n
6280	420	34	7c036cbe-0f98-4cd1-8933-bd3b19ae585f	ACCEPTED	5	1000	2026-06-19 00:26:04.57516+07	\N	\N	15\n
6286	420	58	bd1acbba-626b-4c5f-b8e5-5b4cad508fa4	ACCEPTED	5	1024	2026-06-19 00:26:04.575169+07	\N	\N	803799\n
6290	420	62	81cb92e3-48c9-48c7-a5be-1e83e2e283f3	ACCEPTED	5	864	2026-06-19 00:26:04.575173+07	\N	\N	1486218\n
6283	420	37	7a750eab-5afa-456d-a993-b9c79f77835d	ACCEPTED	5	1084	2026-06-19 00:26:04.575163+07	\N	\N	1000\n
6288	420	60	73ccb43f-973e-4b52-ba6a-fd4414ae30b5	ACCEPTED	7	876	2026-06-19 00:26:04.575171+07	\N	\N	380371\n
6276	420	30	ef5b02c4-d09c-43dc-96a6-846eb5cbe2b8	ACCEPTED	5	1032	2026-06-19 00:26:04.575155+07	\N	\N	0\n
6284	420	38	a6c8af88-78e9-4daf-a54c-0e543b3671c6	ACCEPTED	4	828	2026-06-19 00:26:04.575164+07	\N	\N	3000000\n
6287	420	59	c4c22ca2-cb91-4fb5-a0f3-43d5b2d038fa	ACCEPTED	5	1056	2026-06-19 00:26:04.57517+07	\N	\N	545178\n
6278	420	32	75a29f16-6b75-44ed-817c-56e15cb34d3f	ACCEPTED	4	860	2026-06-19 00:26:04.575158+07	\N	\N	0\n
6279	420	33	22cf4576-0ca6-474a-85fa-80c034ebec5d	ACCEPTED	5	864	2026-06-19 00:26:04.575159+07	\N	\N	84\n
6275	420	29	4e5eafa7-5724-4bf8-9d44-20b8226b9fdf	ACCEPTED	6	996	2026-06-19 00:26:04.575154+07	\N	\N	99\n
6295	420	67	ffa039a9-dc4d-4d0b-8fe6-d0f68e56194d	ACCEPTED	6	864	2026-06-19 00:26:04.57518+07	\N	\N	473222\n
6293	420	65	06210008-572f-40ed-b37f-b2a6eea753c9	ACCEPTED	5	832	2026-06-19 00:26:04.575177+07	\N	\N	475745\n
6296	420	68	b10662a1-0ad4-4991-9fd6-a47f0ed08d1f	ACCEPTED	5	1024	2026-06-19 00:26:04.575181+07	\N	\N	1161167\n
6294	420	66	c1cb93bb-5483-4f58-a8d7-a066e2124c66	ACCEPTED	6	1088	2026-06-19 00:26:04.575178+07	\N	\N	129492\n
6291	420	63	e8189da4-9d10-4f27-adba-6af8a48f7eb0	ACCEPTED	6	992	2026-06-19 00:26:04.575174+07	\N	\N	1507378\n
6292	420	64	802f3e77-3835-4ccf-89f6-1afde81a86b6	ACCEPTED	6	968	2026-06-19 00:26:04.575176+07	\N	\N	710339\n
6297	420	69	74621bf6-16ea-4f51-aa98-c765c72bfabb	ACCEPTED	5	876	2026-06-19 00:26:04.575183+07	\N	\N	616334\n
5523	368	25	f3d84840-203c-45cb-82d3-25b2f9d55f90	ACCEPTED	6	1624	2026-06-17 00:06:16.665077+07	\N	\N	300\n
5535	368	37	f0a9551c-4907-4958-ab19-9a531545d7c7	ACCEPTED	6	3716	2026-06-17 00:06:16.665091+07	\N	\N	1000\n
5533	368	35	c30caf91-a801-4922-b4f5-c2f0fabeadda	ACCEPTED	5	1604	2026-06-17 00:06:16.66509+07	\N	\N	-2\n
5528	368	30	b9bac581-937d-4b1d-a749-6d02f7b0e5db	ACCEPTED	4	3856	2026-06-17 00:06:16.665081+07	\N	\N	0\n
5536	368	38	59984633-adaa-4302-8dc8-31808c3f7487	ACCEPTED	6	1040	2026-06-17 00:06:16.665093+07	\N	\N	3000000\n
5527	368	29	d4356ff0-7c2b-4d23-8595-536e5a165a6a	ACCEPTED	6	6024	2026-06-17 00:06:16.665079+07	\N	\N	99\n
5519	368	21	cdd77660-5571-4a70-821b-01621b69ea3d	ACCEPTED	7	8792	2026-06-17 00:06:16.66507+07	\N	\N	3\n
5532	368	34	9b71f253-c75c-40b1-9200-2a365c29987e	ACCEPTED	5	2052	2026-06-17 00:06:16.66509+07	\N	\N	15\n
5522	368	24	c1d09b41-cd26-47ca-a0f7-8fc9538a2cfe	ACCEPTED	4	2820	2026-06-17 00:06:16.665077+07	\N	\N	0\n
5524	368	26	8b777c8d-de7d-46ec-b090-161e89f3f150	ACCEPTED	4	2896	2026-06-17 00:06:16.665078+07	\N	\N	-30\n
5534	368	36	4016dd77-7823-4cd8-a9d7-f706e6fa3ddb	ACCEPTED	5	1268	2026-06-17 00:06:16.665091+07	\N	\N	801\n
5520	368	22	83f4e2a8-3170-4229-a19c-4ce6052a57e4	ACCEPTED	5	2800	2026-06-17 00:06:16.665075+07	\N	\N	30\n
5526	368	28	1e848f56-506a-494f-92ca-0d0b085c4948	ACCEPTED	5	1208	2026-06-17 00:06:16.665079+07	\N	\N	579\n
5525	368	27	1e84695c-986b-4e25-b01f-763913ef4187	ACCEPTED	4	2152	2026-06-17 00:06:16.665078+07	\N	\N	1000\n
5531	368	33	ff2eb5f2-1f0c-426e-ab6b-f181a68db195	ACCEPTED	8	1864	2026-06-17 00:06:16.665089+07	\N	\N	84\n
5521	368	23	dd911a08-3746-4a0f-8fcf-2f5b49463553	ACCEPTED	4	1956	2026-06-17 00:06:16.665076+07	\N	\N	0\n
5530	368	32	cb18158e-1563-48d6-9984-5698979ac7b1	ACCEPTED	4	1876	2026-06-17 00:06:16.665082+07	\N	\N	0\n
5529	368	31	1f4c6832-e176-4a9e-804b-26f637a7332f	ACCEPTED	4	1684	2026-06-17 00:06:16.665082+07	\N	\N	30000\n
7276	441	76	09e7ac16-53b9-4cf2-b4c2-782f8ad9f844	ACCEPTED	5	976	2026-06-19 01:46:36.145636+07	\N	\N	802483\n
5867	416	21	ee95ac79-7efa-41fa-84cd-21403b6bc5b6	ACCEPTED	7	908	2026-06-19 00:21:30.614722+07	\N	\N	3\n
5870	416	24	9ea03ed7-912b-4e1f-865b-1fe27cacbd26	ACCEPTED	6	1004	2026-06-19 00:21:30.61473+07	\N	\N	0\n
5879	416	33	28e2a4c1-2c9c-4036-9168-f27e27888987	ACCEPTED	6	1012	2026-06-19 00:21:30.614748+07	\N	\N	84\n
5872	416	26	fd4150ef-77fe-4bed-8f72-5d899d44d65e	ACCEPTED	7	888	2026-06-19 00:21:30.614733+07	\N	\N	-30\n
5890	416	62	05391e8f-d626-4fa7-a9f1-47b2cabc75c9	ACCEPTED	6	1032	2026-06-19 00:21:30.614765+07	\N	\N	1486218\n
5871	416	25	1de46a14-4710-4788-805b-8f6a7efecdd5	ACCEPTED	5	868	2026-06-19 00:21:30.614731+07	\N	\N	300\n
5878	416	32	def68f39-0e46-4cdc-8488-0e2b1e7445f0	ACCEPTED	5	1000	2026-06-19 00:21:30.614742+07	\N	\N	0\n
5881	416	35	b494c9e2-029f-4ccb-88f0-618b6372912d	ACCEPTED	5	1032	2026-06-19 00:21:30.614751+07	\N	\N	-2\n
5876	416	30	abf32cad-c015-4188-9763-12629bbeaaf2	ACCEPTED	8	1040	2026-06-19 00:21:30.614739+07	\N	\N	0\n
5877	416	31	3acd87f1-1c5a-4cf0-9f65-f56b29d3f419	ACCEPTED	6	1048	2026-06-19 00:21:30.61474+07	\N	\N	30000\n
5888	416	60	4cf20c25-1463-46d4-bea2-6425428d7874	ACCEPTED	4	1036	2026-06-19 00:21:30.614762+07	\N	\N	380371\n
5887	416	59	d59bd00a-c39d-45f3-b29e-f34f4cccb6c3	ACCEPTED	6	868	2026-06-19 00:21:30.614761+07	\N	\N	545178\n
5889	416	61	6c4d5304-6e72-4729-a6ff-3732e5d270c6	ACCEPTED	7	1036	2026-06-19 00:21:30.614764+07	\N	\N	879721\n
5884	416	38	25a1a80b-8040-4cdc-8d57-de8bdffb735e	ACCEPTED	5	1036	2026-06-19 00:21:30.614756+07	\N	\N	3000000\n
5873	416	27	4a19c57a-79f5-4a5c-a7bc-87e62060fea1	ACCEPTED	13	1008	2026-06-19 00:21:30.614734+07	\N	\N	1000\n
5886	416	58	d76ca3c6-4c20-44a1-9fa9-cbc061304e61	ACCEPTED	6	1036	2026-06-19 00:21:30.614759+07	\N	\N	803799\n
5875	416	29	55e67796-52d7-42b1-95ba-2e67cf6405a4	ACCEPTED	8	896	2026-06-19 00:21:30.614737+07	\N	\N	99\n
5883	416	37	f1e67514-c53d-4b7b-8094-321be077ca57	ACCEPTED	5	1036	2026-06-19 00:21:30.614754+07	\N	\N	1000\n
5882	416	36	edac6860-9791-465c-a8c5-d13a4c91d69b	ACCEPTED	7	884	2026-06-19 00:21:30.614753+07	\N	\N	801\n
5891	416	63	9ffbdd13-2eaf-43fe-9274-45b399ecaba7	ACCEPTED	8	1032	2026-06-19 00:21:30.614767+07	\N	\N	1507378\n
5892	416	64	b144839c-981e-49ae-9c21-45af2e945600	ACCEPTED	5	1044	2026-06-19 00:21:30.614769+07	\N	\N	710339\n
5896	416	68	83240649-94a4-4f9c-bdb9-e3c6ae7f2596	ACCEPTED	5	956	2026-06-19 00:21:30.614775+07	\N	\N	1161167\n
5895	416	67	2fd9f97e-d24d-4fbf-a2ab-24b9274229f8	ACCEPTED	5	1024	2026-06-19 00:21:30.614773+07	\N	\N	473222\n
5897	416	69	673903dd-1040-4f44-af46-33871bac3009	ACCEPTED	6	1084	2026-06-19 00:21:30.614776+07	\N	\N	616334\n
5893	416	65	f6e51a4f-09a2-4f8a-9b44-8befdc2a7630	ACCEPTED	8	868	2026-06-19 00:21:30.61477+07	\N	\N	475745\n
5903	416	75	5eb536c1-72ae-4ffa-894b-44cf45b0a18d	ACCEPTED	5	1024	2026-06-19 00:21:30.614787+07	\N	\N	1760278\n
5900	416	72	4e88ba22-99fa-4774-aa17-b475f3454423	ACCEPTED	5	864	2026-06-19 00:21:30.614782+07	\N	\N	1011312\n
5899	416	71	39482bba-3a1f-440c-a740-a171f91972df	ACCEPTED	10	1028	2026-06-19 00:21:30.614779+07	\N	\N	1416847\n
5902	416	74	d1b09e75-5df8-4924-8c08-0dccd72ef23f	ACCEPTED	12	1024	2026-06-19 00:21:30.614785+07	\N	\N	909595\n
5901	416	73	2451c475-ec10-4584-b215-066531496a63	ACCEPTED	6	1032	2026-06-19 00:21:30.614784+07	\N	\N	702179\n
5911	416	83	15ecc430-7dac-46fe-8d86-41ed000336b6	ACCEPTED	7	1144	2026-06-19 00:21:30.614799+07	\N	\N	-1500204\n
5907	416	79	e2c719a8-c0f6-4f28-a997-a9fec5001f21	ACCEPTED	6	1060	2026-06-19 00:21:30.614793+07	\N	\N	-1351853\n
5910	416	82	a75231c7-c793-436f-a7e3-0411b985ea6d	ACCEPTED	4	888	2026-06-19 00:21:30.614797+07	\N	\N	-1795574\n
5904	416	76	a8423a30-597c-4428-9ada-db8886d59203	ACCEPTED	5	1112	2026-06-19 00:21:30.614788+07	\N	\N	802483\n
5908	416	80	46bc818a-d5b3-4180-889a-ac914bd79aa2	ACCEPTED	5	968	2026-06-19 00:21:30.614794+07	\N	\N	-1611196\n
5912	416	84	679df845-5e8e-47ac-b63a-ac4b2f87f03a	ACCEPTED	5	1028	2026-06-19 00:21:30.6148+07	\N	\N	-734921\n
5909	416	81	09fc5856-a530-4a27-893e-c4d501cbd9a7	ACCEPTED	7	1024	2026-06-19 00:21:30.614796+07	\N	\N	-846475\n
5913	416	85	8b6c63a2-aeaf-49ff-ad6a-5641e7209af6	ACCEPTED	5	1028	2026-06-19 00:21:30.614802+07	\N	\N	-1006285\n
5915	416	87	87999b89-c0cb-43e0-8077-891c7d7745cc	ACCEPTED	5	1020	2026-06-19 00:21:30.614831+07	\N	\N	-1189260\n
5538	369	10	1319ed4c-54a5-4f8f-9f7c-b41a0a1ad3f2	ACCEPTED	2	1276	2026-06-17 00:06:49.020597+07	\N	\N	7\n
5537	369	9	32f6633e-d280-44e7-8fe3-ca2b01d9d564	ACCEPTED	2	1308	2026-06-17 00:06:49.020566+07	\N	\N	6\n
5868	416	22	3a32a65e-60d4-45fb-a4aa-0985c12f7bad	ACCEPTED	7	884	2026-06-19 00:21:30.614726+07	\N	\N	30\n
5869	416	23	de72bbea-ded3-493d-8fd4-095e67aecead	ACCEPTED	13	1072	2026-06-19 00:21:30.614728+07	\N	\N	0\n
5880	416	34	7ec112fc-171b-4972-891b-00c80bc8132c	ACCEPTED	5	808	2026-06-19 00:21:30.614749+07	\N	\N	15\n
5885	416	57	acc9b0cf-50e8-42e3-8972-032a58143e2a	ACCEPTED	18	1104	2026-06-19 00:21:30.614758+07	\N	\N	787228\n
5874	416	28	934e8cea-8dfc-40e5-a512-812fd83d8b7a	ACCEPTED	6	1092	2026-06-19 00:21:30.614736+07	\N	\N	579\n
5894	416	66	9dfd6e06-05ad-4de9-bb4b-a2a279445d91	ACCEPTED	6	1124	2026-06-19 00:21:30.614772+07	\N	\N	129492\n
5898	416	70	fa3f2a04-b1a1-4751-8de6-7061d9b7d395	ACCEPTED	5	1044	2026-06-19 00:21:30.614778+07	\N	\N	959298\n
5905	416	77	3110cfec-5df7-4450-a6a2-da3263b2773d	ACCEPTED	5	1028	2026-06-19 00:21:30.61479+07	\N	\N	-987624\n
5906	416	78	d2e118cd-8ee9-4f5c-beff-49535a628637	ACCEPTED	4	876	2026-06-19 00:21:30.614791+07	\N	\N	-824805\n
5914	416	86	cd46a059-4c78-4ff4-a8d9-31edb2623fd2	ACCEPTED	5	1020	2026-06-19 00:21:30.614803+07	\N	\N	-876295\n
5917	416	89	3b56b075-dba1-4c17-b25d-781cd63e579c	ACCEPTED	4	828	2026-06-19 00:21:30.614843+07	\N	\N	-902015\n
5919	416	91	ed73d57f-9b0b-4c5b-93a6-7facf601718d	ACCEPTED	5	1032	2026-06-19 00:21:30.614847+07	\N	\N	-1113725\n
5922	416	94	c4705705-700a-474b-b20c-f722350c9113	ACCEPTED	11	1032	2026-06-19 00:21:30.614851+07	\N	\N	-717234\n
5923	416	95	53fa162a-0084-45a5-8761-efecae06ed5d	ACCEPTED	6	1028	2026-06-19 00:21:30.614853+07	\N	\N	-1192974\n
5916	416	88	5bcc0a0b-6382-4caa-9aad-b1c42ef4dc85	ACCEPTED	9	1096	2026-06-19 00:21:30.614841+07	\N	\N	-955984\n
5921	416	93	ca9ec9ae-59fe-4cd6-b355-e45ad4c7c212	ACCEPTED	6	1020	2026-06-19 00:21:30.61485+07	\N	\N	-422973\n
5925	416	97	d1e6320e-521d-4a79-b559-53ecd9615506	ACCEPTED	5	880	2026-06-19 00:21:30.614856+07	\N	\N	-517131\n
5918	416	90	75f1b2ff-fcda-4d4d-bc9c-4b5603de24b0	ACCEPTED	11	872	2026-06-19 00:21:30.614845+07	\N	\N	-1520451\n
5930	416	102	fc84c8c8-1ed0-49e7-8568-d50441f99b9c	ACCEPTED	5	1028	2026-06-19 00:21:30.614863+07	\N	\N	-619866\n
5926	416	98	2c3605c6-15e3-4e9e-9d01-f2a5a6e4b837	ACCEPTED	4	832	2026-06-19 00:21:30.614857+07	\N	\N	99178\n
5920	416	92	ab6a52cc-df13-4883-965b-1a9dae249321	ACCEPTED	5	868	2026-06-19 00:21:30.614848+07	\N	\N	-471131\n
5924	416	96	9e5826b1-10e5-4edc-892d-278acd09a434	ACCEPTED	8	992	2026-06-19 00:21:30.614854+07	\N	\N	-1188270\n
5929	416	101	cb5e870e-46bb-4195-978f-e3023f1fe82a	ACCEPTED	6	1024	2026-06-19 00:21:30.614862+07	\N	\N	28962\n
5933	416	105	b84fb743-66bf-4559-9366-914b7a9c57ec	ACCEPTED	6	912	2026-06-19 00:21:30.614868+07	\N	\N	-882565\n
5927	416	99	1084c3f4-c8df-4aab-ba3e-643c81da1221	ACCEPTED	8	976	2026-06-19 00:21:30.614859+07	\N	\N	-1225775\n
5928	416	100	1c9d99b5-756e-4f33-8a84-58bcb3fd1b20	ACCEPTED	5	984	2026-06-19 00:21:30.61486+07	\N	\N	281928\n
5934	416	106	704ec0cd-cb5e-486c-bab6-04781e036691	ACCEPTED	6	1040	2026-06-19 00:21:30.614869+07	\N	\N	-815576\n
5931	416	103	3428ec1d-9a49-4869-ace9-c3b59d318206	ACCEPTED	6	876	2026-06-19 00:21:30.614865+07	\N	\N	283996\n
5935	416	107	528e796f-70bd-4c53-bd00-d470829fd334	ACCEPTED	5	1028	2026-06-19 00:21:30.61487+07	\N	\N	-34648\n
5937	416	109	f4dcd708-e5b7-428c-a5b4-b2df785bd7a0	ACCEPTED	7	1020	2026-06-19 00:21:30.614873+07	\N	\N	792531\n
5936	416	108	fe1bb612-1b78-4f28-8461-0237df54ac57	ACCEPTED	6	1044	2026-06-19 00:21:30.614872+07	\N	\N	1436130\n
5938	416	110	0a827a2a-e96b-4abe-aa82-ed0921ea840c	ACCEPTED	7	884	2026-06-19 00:21:30.614875+07	\N	\N	-572819\n
5948	416	120	b08f6050-e772-4e9f-b7ce-453b08d2d630	ACCEPTED	5	1024	2026-06-19 00:21:30.614894+07	\N	\N	371467497\n
5939	416	111	9a2b8159-7836-42e2-88b7-4ea885f63713	ACCEPTED	7	880	2026-06-19 00:21:30.614876+07	\N	\N	-309452\n
5940	416	112	8f67e86b-a821-4089-a63d-f2d264124a26	ACCEPTED	5	872	2026-06-19 00:21:30.614878+07	\N	\N	649261\n
5950	416	122	79e8aa47-a16f-40dc-95af-ce540deef97c	ACCEPTED	5	1084	2026-06-19 00:21:30.614897+07	\N	\N	-457820119\n
5951	416	123	b0569bc2-4c65-40a2-bc6f-a1b08b6667b0	ACCEPTED	4	868	2026-06-19 00:21:30.614905+07	\N	\N	1422690276\n
5943	416	115	37d65148-a429-4da4-97ec-8888342e50a6	ACCEPTED	6	876	2026-06-19 00:21:30.614882+07	\N	\N	506806\n
5942	416	114	2b70f8b8-287f-4624-8ebd-7019a1a00ea9	ACCEPTED	5	1024	2026-06-19 00:21:30.614881+07	\N	\N	-234796\n
5952	416	124	1a0eecf9-fcfd-4a43-ba1d-ebbeec82a488	ACCEPTED	6	1080	2026-06-19 00:21:30.614907+07	\N	\N	1610593689\n
5954	416	126	c73c355b-e099-46e9-a06c-eaaa56c7458f	ACCEPTED	5	876	2026-06-19 00:21:30.614911+07	\N	\N	-882105735\n
5945	416	117	975fa4a7-3aa2-4226-8676-af6c10d4b518	ACCEPTED	4	836	2026-06-19 00:21:30.614888+07	\N	\N	362210245\n
5946	416	118	5ad4afa4-ac5b-44a0-a8d8-f238ab414d17	ACCEPTED	5	976	2026-06-19 00:21:30.614889+07	\N	\N	636465324\n
5949	416	121	7319b35e-4ea6-4174-bf4a-d492f1c42b9e	ACCEPTED	5	1028	2026-06-19 00:21:30.614896+07	\N	\N	1259817393\n
5953	416	125	3d4b6711-ecdf-437c-a10f-9b225b15382e	ACCEPTED	6	1060	2026-06-19 00:21:30.614909+07	\N	\N	86961293\n
5955	416	127	389ffed5-c7e7-48c5-962a-80a2a8aa55cf	ACCEPTED	6	868	2026-06-19 00:21:30.614912+07	\N	\N	0\n
5956	416	128	c758218b-ba25-4db6-973f-1c2f58f21ec8	ACCEPTED	17	1024	2026-06-19 00:21:30.614914+07	\N	\N	82\n
5959	416	131	842dac48-b57e-4427-adda-a86284e43bb9	ACCEPTED	9	1028	2026-06-19 00:21:30.614918+07	\N	\N	71\n
5957	416	129	edd1ca16-02e3-4a62-a19d-4d10a3748aee	ACCEPTED	4	1068	2026-06-19 00:21:30.614915+07	\N	\N	-32\n
5960	416	132	d2b97c0e-1fc9-4c05-b987-2fc37aa841b2	ACCEPTED	5	1052	2026-06-19 00:21:30.61492+07	\N	\N	-1\n
5962	416	134	99068dbb-ae62-41a5-94a2-af84f012cc3e	ACCEPTED	5	1060	2026-06-19 00:21:30.614923+07	\N	\N	158\n
5964	416	136	01dde044-77bd-4b0c-a619-f5c370152d50	ACCEPTED	3	1056	2026-06-19 00:21:30.614926+07	\N	\N	129\n
5963	416	135	febe70c6-0d9e-41a6-9c73-ec4ea786c68e	ACCEPTED	3	1068	2026-06-19 00:21:30.614925+07	\N	\N	3\n
5965	416	137	e91c59ec-1ddc-4740-b99e-df7a38752de8	ACCEPTED	4	1056	2026-06-19 00:21:30.614928+07	\N	\N	64\n
5966	416	138	fee55c6e-a21f-4262-902b-c9d6aa926818	ACCEPTED	3	1040	2026-06-19 00:21:30.614929+07	\N	\N	51\n
5539	370	11	fe568561-97a7-40ca-9937-af6d335efda2	ACCEPTED	3	15732	2026-06-17 01:16:52.812575+07	\N	\N	4\n
5540	370	12	5ac259c7-3194-468d-a5a1-08691348846e	ACCEPTED	3	18428	2026-06-17 01:16:52.812592+07	\N	\N	4\n
5542	371	10	fb7f4e9a-c571-4c1f-814d-4146c8c9dba7	ACCEPTED	3	1048	2026-06-17 01:16:57.385157+07	\N	\N	7\n
5541	371	9	76bd2a58-8bcb-42d3-9453-6fc5099f27ea	ACCEPTED	3	1048	2026-06-17 01:16:57.385144+07	\N	\N	6\n
5544	372	40	86501a4e-a9fd-4570-9b78-a031d739d428	ACCEPTED	6	1064	2026-06-17 01:17:09.769323+07	\N	\N	2\n
5549	372	45	c7c0e7dc-7d62-46a0-ad94-ad9b633de2a6	ACCEPTED	6	892	2026-06-17 01:17:09.76933+07	\N	\N	11\n
5552	372	48	86b494f8-8fe9-47d9-aa1b-10c19a8cd911	WRONG_ANSWER	6	1104	2026-06-17 01:17:09.769333+07	\N	\N	115\n
5543	372	39	6538904c-9ace-4d1e-b661-b0f1c31f28ae	ACCEPTED	7	1032	2026-06-17 01:17:09.769314+07	\N	\N	17\n
5551	372	47	9046413f-0b80-413d-bce0-0bc6abef9778	WRONG_ANSWER	20	1032	2026-06-17 01:17:09.769332+07	\N	\N	115\n
5545	372	41	9ac123a2-7815-473a-8138-36503a2e35c4	ACCEPTED	6	1108	2026-06-17 01:17:09.769325+07	\N	\N	3\n
5546	372	42	ffb84d19-a830-4316-ae86-360d4e7d9e31	ACCEPTED	9	908	2026-06-17 01:17:09.769326+07	\N	\N	5\n
5550	372	46	0face103-32bf-463f-afdf-59191924493c	ACCEPTED	6	876	2026-06-17 01:17:09.769331+07	\N	\N	23\n
5548	372	44	162b841a-bb16-4b69-abec-0f7cd68f0641	ACCEPTED	8	1104	2026-06-17 01:17:09.769329+07	\N	\N	11\n
5547	372	43	95e372fb-61a8-4ad7-8013-9deb7fc68d2c	ACCEPTED	30	816	2026-06-17 01:17:09.769327+07	\N	\N	5\n
5557	372	53	abf67ad1-16f0-45c2-9d42-65ceff4b2130	TIME_LIMIT_EXCEEDED	2029	880	2026-06-17 01:17:09.769339+07	\N	\N	\N
5559	372	55	fb042eab-7507-42c9-b147-791b36b202cc	TIME_LIMIT_EXCEEDED	2058	1040	2026-06-17 01:17:09.769342+07	\N	\N	\N
5553	372	49	35339959-c435-466c-9ee7-972a1a2ecc9a	TIME_LIMIT_EXCEEDED	2088	1032	2026-06-17 01:17:09.769335+07	\N	\N	\N
5555	372	51	6df15e33-15c7-46b0-b1dc-21c5fecfe46c	TIME_LIMIT_EXCEEDED	2087	896	2026-06-17 01:17:09.769337+07	\N	\N	\N
5558	372	54	4cf8d5f8-98b9-4c74-9acf-0e981a838a18	TIME_LIMIT_EXCEEDED	2078	1012	2026-06-17 01:17:09.769341+07	\N	\N	\N
5554	372	50	55861221-016e-4688-95c5-91acecdc8e42	TIME_LIMIT_EXCEEDED	2064	940	2026-06-17 01:17:09.769336+07	\N	\N	\N
5560	372	56	400d3329-a8db-4846-9a22-6b5b246ffdea	TIME_LIMIT_EXCEEDED	2062	1068	2026-06-17 01:17:09.769352+07	\N	\N	\N
5556	372	52	4e396783-2087-4cb6-b950-237bd9e81258	TIME_LIMIT_EXCEEDED	2073	1128	2026-06-17 01:17:09.769338+07	\N	\N	\N
5561	373	39	ab85861f-76df-457f-bed6-743069bf2dd1	ACCEPTED	7	1040	2026-06-17 01:17:17.779201+07	\N	\N	17\n
5572	373	50	2ed3afd8-2645-487a-a651-fa660ab4db37	ACCEPTED	6	876	2026-06-17 01:17:17.779256+07	\N	\N	1009\n
5568	373	46	20212684-44c8-4ca8-b5b7-3c1f58e7e11e	ACCEPTED	8	1084	2026-06-17 01:17:17.779237+07	\N	\N	23\n
5562	373	40	647d4065-972a-432e-b4bf-871deeb6fa32	ACCEPTED	19	1020	2026-06-17 01:17:17.779216+07	\N	\N	2\n
5575	373	53	dfd19826-f373-4505-bb64-79721fd82e65	ACCEPTED	6	1028	2026-06-17 01:17:17.779267+07	\N	\N	100003\n
5563	373	41	41b2d4c6-c975-4700-9771-e106ebe39629	ACCEPTED	7	1052	2026-06-17 01:17:17.77922+07	\N	\N	3\n
5576	373	54	8514a755-e1fc-4ce0-b00e-1ecdc3290bc0	ACCEPTED	20	980	2026-06-17 01:17:17.77927+07	\N	\N	500009\n
5570	373	48	560e2fbe-0eba-4adb-9b51-4e99e59c6156	ACCEPTED	5	1040	2026-06-17 01:17:17.779249+07	\N	\N	101\n
5573	373	51	9b7bd2f9-ede6-4e92-a871-269b846c0a93	ACCEPTED	7	1028	2026-06-17 01:17:17.77926+07	\N	\N	10007\n
5571	373	49	fad0c5b0-cc45-4375-a41c-d8a8fe0a12b4	ACCEPTED	9	1040	2026-06-17 01:17:17.779253+07	\N	\N	1009\n
5578	373	56	d6db3f6a-8e4b-47f9-b031-d8bfccf7998b	ACCEPTED	22	1056	2026-06-17 01:17:17.779277+07	\N	\N	1000003\n
5565	373	43	b17501cb-5f43-4d05-b1f2-78a56387bce1	ACCEPTED	13	924	2026-06-17 01:17:17.779227+07	\N	\N	5\n
5569	373	47	03dd110a-0a09-41bf-8c5f-00b520ecf1b2	ACCEPTED	10	872	2026-06-17 01:17:17.779241+07	\N	\N	101\n
5574	373	52	a62d9bd2-707f-47d6-ab92-eec9cae995ae	ACCEPTED	6	1060	2026-06-17 01:17:17.779263+07	\N	\N	100003\n
5566	373	44	55faced2-3291-4979-8abc-eb15897aac98	ACCEPTED	8	1064	2026-06-17 01:17:17.779231+07	\N	\N	11\n
5564	373	42	fff94fe8-13a1-42ff-b757-842224a6f055	ACCEPTED	5	1036	2026-06-17 01:17:17.779224+07	\N	\N	5\n
5567	373	45	1e796576-ff7c-4551-81c2-1fd99f3ff013	ACCEPTED	6	1100	2026-06-17 01:17:17.779234+07	\N	\N	11\n
5577	373	55	3e1fde07-3145-40b0-b639-2ce1bf954ef3	ACCEPTED	3	1128	2026-06-17 01:17:17.779273+07	\N	\N	1000003\n
5580	374	40	5043cee6-38f9-411e-93c0-b18e7b0c05a2	ACCEPTED	6	1044	2026-06-17 01:17:22.130397+07	\N	\N	2\n
5583	374	43	1c50e378-7ef1-43bf-99f6-6dce2b01b28f	ACCEPTED	7	1036	2026-06-17 01:17:22.130405+07	\N	\N	5\n
5586	374	46	2f6331f0-233d-4036-8e97-a24a75986336	ACCEPTED	6	1024	2026-06-17 01:17:22.130412+07	\N	\N	23\n
5582	374	42	979d6a46-5588-4903-bba5-1e00c27a4599	ACCEPTED	7	1044	2026-06-17 01:17:22.130402+07	\N	\N	5\n
5594	374	54	8514589a-c5f2-4f59-a72a-3f25d6956f41	ACCEPTED	7	1088	2026-06-17 01:17:22.130441+07	\N	\N	500009\n
5579	374	39	e617031a-fdc0-437a-a6ef-ec4c0a670b5d	ACCEPTED	6	1040	2026-06-17 01:17:22.13038+07	\N	\N	17\n
5581	374	41	e2a3a003-ca68-4236-a87f-9f38619eb56e	ACCEPTED	7	880	2026-06-17 01:17:22.130399+07	\N	\N	3\n
5591	374	51	dc4b6484-de3f-4698-9afd-0febf2b066a9	ACCEPTED	8	876	2026-06-17 01:17:22.130435+07	\N	\N	10007\n
5593	374	53	ba9bb7c9-d89b-41f0-9455-c3b821fa8dbd	ACCEPTED	7	876	2026-06-17 01:17:22.130439+07	\N	\N	100003\n
5584	374	44	ddd86bb8-5bf7-4e00-a640-18e733b80173	ACCEPTED	6	852	2026-06-17 01:17:22.130407+07	\N	\N	11\n
5595	374	55	a785ac14-a0d7-4374-8db9-365bae138309	ACCEPTED	7	904	2026-06-17 01:17:22.130444+07	\N	\N	1000003\n
5589	374	49	d7112d57-7ef5-405d-994b-a928c1e4d1da	ACCEPTED	8	1036	2026-06-17 01:17:22.130429+07	\N	\N	1009\n
5587	374	47	67fa7150-afe6-40a5-bd5b-6a0856200de9	ACCEPTED	10	1024	2026-06-17 01:17:22.130425+07	\N	\N	101\n
5590	374	50	b8dd4859-15d7-4544-b0f3-ecb0a083e6dd	ACCEPTED	8	1028	2026-06-17 01:17:22.130432+07	\N	\N	1009\n
5596	374	56	71760439-d139-415a-a928-51afd7cad80f	ACCEPTED	8	1004	2026-06-17 01:17:22.130446+07	\N	\N	1000003\n
5588	374	48	6db6ad44-30f1-4705-9b7b-aadd95c8a4f9	ACCEPTED	7	1132	2026-06-17 01:17:22.130427+07	\N	\N	101\n
5585	374	45	32bb775b-0cdd-4dd7-b9be-4e46682954f0	ACCEPTED	4	1064	2026-06-17 01:17:22.130409+07	\N	\N	11\n
5592	374	52	0dd6b43e-c722-414e-9494-5cf9ba61ee32	ACCEPTED	4	1068	2026-06-17 01:17:22.130437+07	\N	\N	100003\n
5932	416	104	7e0c234b-1fc3-492e-970a-7940b8debd77	ACCEPTED	5	1024	2026-06-19 00:21:30.614866+07	\N	\N	514364\n
5944	416	116	aee68ae8-0d4c-4df8-97e3-b17c2a5da2e6	ACCEPTED	5	1024	2026-06-19 00:21:30.614886+07	\N	\N	785356\n
5597	375	5	7f5ec98f-c359-4599-8789-8fc17fdd4277	WRONG_ANSWER	18	5116	2026-06-17 01:29:43.213501+07	\N	\N	Hello World\n
5598	375	6	00cf24d6-15ca-4370-aa83-e4ddfee5c3e7	WRONG_ANSWER	18	5624	2026-06-17 01:29:43.213513+07	\N	\N	Hello World\n
5941	416	113	48ae87c5-02d6-45b2-a190-29a4644fd89d	ACCEPTED	4	1028	2026-06-19 00:21:30.614879+07	\N	\N	-1143916\n
5947	416	119	eefc387b-5026-4b38-81dc-dbeeda5372b3	ACCEPTED	5	1104	2026-06-19 00:21:30.614891+07	\N	\N	-738231997\n
5958	416	130	a4e06809-231b-46a0-9b74-a3428b21877a	ACCEPTED	6	860	2026-06-19 00:21:30.614917+07	\N	\N	-5\n
5961	416	133	ddd2e961-e853-431b-b059-02dda038cb66	ACCEPTED	8	864	2026-06-19 00:21:30.614922+07	\N	\N	-57\n
6305	420	77	26f080ae-f088-4ff5-993a-b5f4d36c94ce	ACCEPTED	17	1028	2026-06-19 00:26:04.575192+07	\N	\N	-987624\n
6311	420	83	20be3aa9-f52a-43a5-9a2f-319931c7acf5	ACCEPTED	12	864	2026-06-19 00:26:04.575198+07	\N	\N	-1500204\n
6312	420	84	37deb920-c456-460f-a1f8-fd3c5113273d	ACCEPTED	8	988	2026-06-19 00:26:04.575199+07	\N	\N	-734921\n
6308	420	80	d67c1166-926e-4782-9820-6c18587560eb	ACCEPTED	4	1020	2026-06-19 00:26:04.575195+07	\N	\N	-1611196\n
6306	420	78	47382a2b-6504-46f9-81a8-72bf758e9992	ACCEPTED	8	1092	2026-06-19 00:26:04.575193+07	\N	\N	-824805\n
6309	420	81	46cc82c8-eb25-4cf7-bfcc-f2b47e809733	ACCEPTED	5	864	2026-06-19 00:26:04.575196+07	\N	\N	-846475\n
6300	420	72	9d4d8953-1ab3-442f-bdba-0b7e4c6d2aa8	ACCEPTED	5	876	2026-06-19 00:26:04.575186+07	\N	\N	1011312\n
6303	420	75	e744e30c-b8b5-44bd-ac27-c9bd5fb05de5	ACCEPTED	5	1008	2026-06-19 00:26:04.57519+07	\N	\N	1760278\n
6304	420	76	46ec02a9-095a-4ba4-85b2-9c98ad900b4d	ACCEPTED	6	1096	2026-06-19 00:26:04.575191+07	\N	\N	802483\n
6313	420	85	c7dfad43-5376-46cb-9a10-c990c3854fed	ACCEPTED	7	1084	2026-06-19 00:26:04.5752+07	\N	\N	-1006285\n
6307	420	79	d631ae92-2d37-4540-bc41-b02a58738910	ACCEPTED	5	1020	2026-06-19 00:26:04.575194+07	\N	\N	-1351853\n
6314	420	86	5a678604-6675-4556-a06a-9b43b7784a36	ACCEPTED	5	1020	2026-06-19 00:26:04.575201+07	\N	\N	-876295\n
6315	420	87	731d58eb-1c99-4024-8de8-8bfe5bebdc1b	ACCEPTED	5	880	2026-06-19 00:26:04.575202+07	\N	\N	-1189260\n
6316	420	88	f3053301-46b6-475d-ad11-e400334f8f6c	ACCEPTED	5	1028	2026-06-19 00:26:04.575203+07	\N	\N	-955984\n
6322	420	94	28247ddd-0305-4898-9451-21564618a6fe	ACCEPTED	11	1040	2026-06-19 00:26:04.57521+07	\N	\N	-717234\n
6317	420	89	61bc0b00-d9c4-4720-b269-11f7c31e9055	ACCEPTED	4	1016	2026-06-19 00:26:04.575205+07	\N	\N	-902015\n
6321	420	93	df08412a-ebe0-49fa-9f69-2fd27f8f4975	ACCEPTED	5	1024	2026-06-19 00:26:04.575209+07	\N	\N	-422973\n
6324	420	96	2c1570a3-b4d5-48f1-a81b-7ebfb6a85de2	ACCEPTED	5	1088	2026-06-19 00:26:04.575211+07	\N	\N	-1188270\n
6325	420	97	558f236c-300d-4d65-8242-81c59373b707	ACCEPTED	4	1024	2026-06-19 00:26:04.575212+07	\N	\N	-517131\n
6320	420	92	121a6341-ab12-4cce-b34e-e53dd78a68d4	ACCEPTED	4	1024	2026-06-19 00:26:04.575207+07	\N	\N	-471131\n
6327	420	99	1a1050f1-5ced-4291-a70c-031cfefc6109	ACCEPTED	4	1020	2026-06-19 00:26:04.575214+07	\N	\N	-1225775\n
6331	420	103	1bb11b29-bb8f-46ed-afcf-30fd1da057e6	ACCEPTED	7	1020	2026-06-19 00:26:04.575218+07	\N	\N	283996\n
6332	420	104	cdd77be8-6118-4a45-abf1-25a4746c8899	ACCEPTED	6	984	2026-06-19 00:26:04.575219+07	\N	\N	514364\n
6330	420	102	10766936-b1f0-44a3-a484-8c4ca509bf80	ACCEPTED	6	1044	2026-06-19 00:26:04.575217+07	\N	\N	-619866\n
6329	420	101	c56903da-2bb0-41ba-8bf3-34d5cefbc656	ACCEPTED	8	876	2026-06-19 00:26:04.575216+07	\N	\N	28962\n
6333	420	105	b1fb1e91-db75-4b3e-b894-7c4e637f8e59	ACCEPTED	6	980	2026-06-19 00:26:04.57522+07	\N	\N	-882565\n
6326	420	98	3db867c8-87b7-491b-adbf-97778020434a	ACCEPTED	5	1016	2026-06-19 00:26:04.575213+07	\N	\N	99178\n
6334	420	106	f7e304cf-988d-4ac4-8864-59dfd94b1acb	ACCEPTED	8	1024	2026-06-19 00:26:04.575221+07	\N	\N	-815576\n
6339	420	111	da27cf70-c9ff-4c07-a8fb-2b9f56f6d119	ACCEPTED	6	1092	2026-06-19 00:26:04.575226+07	\N	\N	-309452\n
6338	420	110	76958b74-5721-4291-bd62-f670ad0c860e	ACCEPTED	7	1092	2026-06-19 00:26:04.575225+07	\N	\N	-572819\n
6335	420	107	c9c4b0d7-6dcd-4e74-9e9c-4e273554260b	ACCEPTED	4	1016	2026-06-19 00:26:04.575222+07	\N	\N	-34648\n
6341	420	113	c4f66f9f-123d-4b8c-ab89-d6649e65016c	ACCEPTED	8	1084	2026-06-19 00:26:04.575228+07	\N	\N	-1143916\n
6336	420	108	58594c68-89de-4b9c-9b32-2144e6dca3ce	ACCEPTED	9	1020	2026-06-19 00:26:04.575223+07	\N	\N	1436130\n
6343	420	115	42e00848-6b4e-4599-8ec3-21e6aea8c56b	ACCEPTED	6	1036	2026-06-19 00:26:04.575231+07	\N	\N	506806\n
6344	420	116	2c12e673-d294-46f9-9bbe-8a251e0221d9	ACCEPTED	5	880	2026-06-19 00:26:04.575232+07	\N	\N	785356\n
6342	420	114	2602ec92-1a9f-4cd3-81b4-2736d2cdc6c5	ACCEPTED	8	880	2026-06-19 00:26:04.57523+07	\N	\N	-234796\n
6346	420	118	996bb297-1d9e-4537-93f2-c2950355549e	ACCEPTED	11	828	2026-06-19 00:26:04.575234+07	\N	\N	636465324\n
6350	420	122	546d4002-ae16-4920-a833-804d65997bd0	ACCEPTED	5	1032	2026-06-19 00:26:04.575238+07	\N	\N	-457820119\n
6348	420	120	f635aa48-02e9-43b3-ac39-26949e6ebed0	ACCEPTED	8	872	2026-06-19 00:26:04.575236+07	\N	\N	371467497\n
6349	420	121	e9bcb02b-bec8-43d5-bac9-44b5357b668b	ACCEPTED	5	1120	2026-06-19 00:26:04.575237+07	\N	\N	1259817393\n
6353	420	125	38fdac0d-cfe7-4838-b13c-5bba60131edc	ACCEPTED	9	1012	2026-06-19 00:26:04.575243+07	\N	\N	86961293\n
6347	420	119	3b739d94-9d60-4b23-99ec-fc57dfd9fed3	ACCEPTED	5	876	2026-06-19 00:26:04.575235+07	\N	\N	-738231997\n
6351	420	123	126e2a27-faf2-401e-a4fd-ce7a8759a3f3	ACCEPTED	7	864	2026-06-19 00:26:04.575241+07	\N	\N	1422690276\n
6357	420	129	96e0f0a4-0149-4bcc-a889-8e1c42cede8b	ACCEPTED	5	1020	2026-06-19 00:26:04.575247+07	\N	\N	-32\n
6354	420	126	1e7d208c-5bd7-45ba-98d6-501504bfd18b	ACCEPTED	5	1028	2026-06-19 00:26:04.575244+07	\N	\N	-882105735\n
6352	420	124	b2d1d11e-4e10-4052-b9f7-fb4473e14bfd	ACCEPTED	5	864	2026-06-19 00:26:04.575242+07	\N	\N	1610593689\n
6359	420	131	1c173299-127a-472b-b92c-144865569868	ACCEPTED	5	940	2026-06-19 00:26:04.57528+07	\N	\N	71\n
6358	420	130	0a888327-abaf-47e5-a18a-46c2414b7ab9	ACCEPTED	5	880	2026-06-19 00:26:04.575268+07	\N	\N	-5\n
6360	420	132	69e3113b-925a-4e8c-853a-24e85dddb163	ACCEPTED	5	1016	2026-06-19 00:26:04.575281+07	\N	\N	-1\n
6361	420	133	f57e9d10-679b-4793-b7d3-21693dbdbcf7	ACCEPTED	3	1052	2026-06-19 00:26:04.575283+07	\N	\N	-57\n
5607	376	29	2b0e7eb6-47b0-429e-b029-45d151bf756f	ACCEPTED	6	4096	2026-06-17 02:06:04.332294+07	\N	\N	99\n
5600	376	22	e8ccf766-aaf2-4fd7-bb07-aa5b984cdccb	ACCEPTED	6	1892	2026-06-17 02:06:04.332275+07	\N	\N	30\n
5616	376	38	e3321dff-e97b-4dc1-be4a-718272d044d3	ACCEPTED	5	1916	2026-06-17 02:06:04.332316+07	\N	\N	3000000\n
5611	376	33	218b74c6-274f-49ee-997b-a54dc1eef01e	ACCEPTED	5	2812	2026-06-17 02:06:04.332304+07	\N	\N	84\n
5606	376	28	f5cde0c2-a1f3-44f7-9f98-3ce89ecd2173	ACCEPTED	6	1832	2026-06-17 02:06:04.332291+07	\N	\N	579\n
5609	376	31	d0ec9ccc-2a61-4c2c-adb8-58d300287f45	ACCEPTED	6	2612	2026-06-17 02:06:04.332299+07	\N	\N	30000\n
5601	376	23	ead40a74-00b2-4077-8ef1-e8a720885a87	ACCEPTED	5	4172	2026-06-17 02:06:04.332279+07	\N	\N	0\n
5605	376	27	fe07a9fd-3ce5-4c14-bec5-32d471e6af6e	ACCEPTED	6	2140	2026-06-17 02:06:04.332289+07	\N	\N	1000\n
5610	376	32	54487667-af19-4110-94e8-5da9fe52c151	ACCEPTED	5	2596	2026-06-17 02:06:04.332302+07	\N	\N	0\n
5613	376	35	321c4a33-9099-4a1f-972f-839a6aaf4212	ACCEPTED	4	1148	2026-06-17 02:06:04.332309+07	\N	\N	-2\n
5615	376	37	f00b93fe-7511-4912-ad9b-1480f09a3eba	ACCEPTED	6	2756	2026-06-17 02:06:04.332314+07	\N	\N	1000\n
5603	376	25	ed2e55fb-e5a8-4cb5-8e82-d0658ac71d12	ACCEPTED	5	1628	2026-06-17 02:06:04.332284+07	\N	\N	300\n
5604	376	26	d23f203f-df6e-4703-9c12-31cc7e871301	ACCEPTED	6	7708	2026-06-17 02:06:04.332287+07	\N	\N	-30\n
5608	376	30	fe0c86e4-bac2-4174-bc0b-47c731f537cf	ACCEPTED	6	2348	2026-06-17 02:06:04.332297+07	\N	\N	0\n
5612	376	34	3aa4e168-446c-4756-9ef5-82f3c5f9afbe	ACCEPTED	5	1672	2026-06-17 02:06:04.332307+07	\N	\N	15\n
5602	376	24	68faf352-ce87-4b3a-b1ac-9e23d09c9fa2	ACCEPTED	5	2628	2026-06-17 02:06:04.332282+07	\N	\N	0\n
5614	376	36	9679f2d8-b469-489c-a33a-4232ed17f943	ACCEPTED	5	2728	2026-06-17 02:06:04.332312+07	\N	\N	801\n
5599	376	21	aa05c3eb-25c6-465f-bc2a-af951c8885b9	ACCEPTED	5	1968	2026-06-17 02:06:04.332245+07	\N	\N	3\n
5967	417	21	0608dda4-708a-44c2-8699-e4a9b75f323f	ACCEPTED	11	864	2026-06-19 00:23:19.051016+07	\N	\N	3\n
5968	417	22	5f813bd4-49b9-40d8-a7ce-e07fc1d421fa	ACCEPTED	7	820	2026-06-19 00:23:19.051019+07	\N	\N	30\n
5618	377	22	85e4af27-ae5a-4f0b-858f-ddb9ae307c9d	COMPILATION_ERROR	0	\N	2026-06-17 02:16:40.174124+07	Main.java:6: error: cannot find symbol\n        int a = sc.nextInt();\n                ^\n  symbol:   variable sc\n  location: class Main\nMain.java:7: error: cannot find symbol\n        int b = sc.nextInt();\n                ^\n  symbol:   variable sc\n  location: class Main\n2 errors\n	\N	\N
5621	377	25	56ebf98b-18cb-46d5-b508-2bb150516fce	COMPILATION_ERROR	0	\N	2026-06-17 02:16:40.174165+07	Main.java:6: error: cannot find symbol\n        int a = sc.nextInt();\n                ^\n  symbol:   variable sc\n  location: class Main\nMain.java:7: error: cannot find symbol\n        int b = sc.nextInt();\n                ^\n  symbol:   variable sc\n  location: class Main\n2 errors\n	\N	\N
5629	377	33	3ca56a79-dcee-481d-98c9-1b8f9536b812	COMPILATION_ERROR	0	\N	2026-06-17 02:16:40.174193+07	Main.java:6: error: cannot find symbol\n        int a = sc.nextInt();\n                ^\n  symbol:   variable sc\n  location: class Main\nMain.java:7: error: cannot find symbol\n        int b = sc.nextInt();\n                ^\n  symbol:   variable sc\n  location: class Main\n2 errors\n	\N	\N
5631	377	35	0c83cf6e-f3af-4633-a7e5-3d0d59462641	COMPILATION_ERROR	0	\N	2026-06-17 02:16:40.174199+07	Main.java:6: error: cannot find symbol\n        int a = sc.nextInt();\n                ^\n  symbol:   variable sc\n  location: class Main\nMain.java:7: error: cannot find symbol\n        int b = sc.nextInt();\n                ^\n  symbol:   variable sc\n  location: class Main\n2 errors\n	\N	\N
5627	377	31	7dc0ad29-7325-4164-935a-39580fbdbf04	COMPILATION_ERROR	0	\N	2026-06-17 02:16:40.174186+07	Main.java:6: error: cannot find symbol\n        int a = sc.nextInt();\n                ^\n  symbol:   variable sc\n  location: class Main\nMain.java:7: error: cannot find symbol\n        int b = sc.nextInt();\n                ^\n  symbol:   variable sc\n  location: class Main\n2 errors\n	\N	\N
5628	377	32	0c921e00-d47d-4001-a107-f13b690f288e	COMPILATION_ERROR	0	\N	2026-06-17 02:16:40.174189+07	Main.java:6: error: cannot find symbol\n        int a = sc.nextInt();\n                ^\n  symbol:   variable sc\n  location: class Main\nMain.java:7: error: cannot find symbol\n        int b = sc.nextInt();\n                ^\n  symbol:   variable sc\n  location: class Main\n2 errors\n	\N	\N
5633	377	37	41841c1e-81de-4aa6-b907-f19888cab086	COMPILATION_ERROR	0	\N	2026-06-17 02:16:40.174215+07	Main.java:6: error: cannot find symbol\n        int a = sc.nextInt();\n                ^\n  symbol:   variable sc\n  location: class Main\nMain.java:7: error: cannot find symbol\n        int b = sc.nextInt();\n                ^\n  symbol:   variable sc\n  location: class Main\n2 errors\n	\N	\N
5622	377	26	c025de39-de0e-4180-8375-2152c7b8fd5e	COMPILATION_ERROR	0	\N	2026-06-17 02:16:40.174168+07	Main.java:6: error: cannot find symbol\n        int a = sc.nextInt();\n                ^\n  symbol:   variable sc\n  location: class Main\nMain.java:7: error: cannot find symbol\n        int b = sc.nextInt();\n                ^\n  symbol:   variable sc\n  location: class Main\n2 errors\n	\N	\N
5630	377	34	c86a90c8-d7d0-46aa-9967-5385d41a2611	COMPILATION_ERROR	0	\N	2026-06-17 02:16:40.174196+07	Main.java:6: error: cannot find symbol\n        int a = sc.nextInt();\n                ^\n  symbol:   variable sc\n  location: class Main\nMain.java:7: error: cannot find symbol\n        int b = sc.nextInt();\n                ^\n  symbol:   variable sc\n  location: class Main\n2 errors\n	\N	\N
5624	377	28	6c81f2e5-a34d-48a6-be8b-cd00c2cc3e7d	COMPILATION_ERROR	0	\N	2026-06-17 02:16:40.174175+07	Main.java:6: error: cannot find symbol\n        int a = sc.nextInt();\n                ^\n  symbol:   variable sc\n  location: class Main\nMain.java:7: error: cannot find symbol\n        int b = sc.nextInt();\n                ^\n  symbol:   variable sc\n  location: class Main\n2 errors\n	\N	\N
5632	377	36	c8bfd791-98e1-4d91-87e3-0898c534c34a	COMPILATION_ERROR	0	\N	2026-06-17 02:16:40.174203+07	Main.java:6: error: cannot find symbol\n        int a = sc.nextInt();\n                ^\n  symbol:   variable sc\n  location: class Main\nMain.java:7: error: cannot find symbol\n        int b = sc.nextInt();\n                ^\n  symbol:   variable sc\n  location: class Main\n2 errors\n	\N	\N
5623	377	27	d320ad4c-13a5-4ecf-84a1-89ba89d93e84	COMPILATION_ERROR	0	\N	2026-06-17 02:16:40.174172+07	Main.java:6: error: cannot find symbol\n        int a = sc.nextInt();\n                ^\n  symbol:   variable sc\n  location: class Main\nMain.java:7: error: cannot find symbol\n        int b = sc.nextInt();\n                ^\n  symbol:   variable sc\n  location: class Main\n2 errors\n	\N	\N
5634	377	38	1fd03763-4374-4ee0-b82e-37c07c49d812	COMPILATION_ERROR	0	\N	2026-06-17 02:16:40.174219+07	Main.java:6: error: cannot find symbol\n        int a = sc.nextInt();\n                ^\n  symbol:   variable sc\n  location: class Main\nMain.java:7: error: cannot find symbol\n        int b = sc.nextInt();\n                ^\n  symbol:   variable sc\n  location: class Main\n2 errors\n	\N	\N
5617	377	21	09a96ea1-95b4-4b40-bdee-95da362b2410	COMPILATION_ERROR	0	\N	2026-06-17 02:16:40.174088+07	Main.java:6: error: cannot find symbol\n        int a = sc.nextInt();\n                ^\n  symbol:   variable sc\n  location: class Main\nMain.java:7: error: cannot find symbol\n        int b = sc.nextInt();\n                ^\n  symbol:   variable sc\n  location: class Main\n2 errors\n	\N	\N
5619	377	23	07be1567-2de2-47ab-8c5f-933f1ca6cc5e	COMPILATION_ERROR	0	\N	2026-06-17 02:16:40.174132+07	Main.java:6: error: cannot find symbol\n        int a = sc.nextInt();\n                ^\n  symbol:   variable sc\n  location: class Main\nMain.java:7: error: cannot find symbol\n        int b = sc.nextInt();\n                ^\n  symbol:   variable sc\n  location: class Main\n2 errors\n	\N	\N
5620	377	24	79ca33db-094f-4b30-adb6-449ab898677d	COMPILATION_ERROR	0	\N	2026-06-17 02:16:40.174136+07	Main.java:6: error: cannot find symbol\n        int a = sc.nextInt();\n                ^\n  symbol:   variable sc\n  location: class Main\nMain.java:7: error: cannot find symbol\n        int b = sc.nextInt();\n                ^\n  symbol:   variable sc\n  location: class Main\n2 errors\n	\N	\N
5626	377	30	c742e2bc-0d6c-4215-b6e7-3b6d4a0fee6d	COMPILATION_ERROR	0	\N	2026-06-17 02:16:40.174182+07	Main.java:6: error: cannot find symbol\n        int a = sc.nextInt();\n                ^\n  symbol:   variable sc\n  location: class Main\nMain.java:7: error: cannot find symbol\n        int b = sc.nextInt();\n                ^\n  symbol:   variable sc\n  location: class Main\n2 errors\n	\N	\N
5970	417	24	08b448c3-2ccf-4095-9d30-13068b14051a	ACCEPTED	5	828	2026-06-19 00:23:19.051022+07	\N	\N	0\n
5637	378	23	4f5a71ea-685a-4d75-8e74-fcbd0586f77b	COMPILATION_ERROR	0	\N	2026-06-17 02:17:27.135477+07	Main.java:6: error: cannot find symbol\n        int a = sc.nextInt();\n                ^\n  symbol:   variable sc\n  location: class Main\nMain.java:7: error: cannot find symbol\n        int b = sc.nextInt();\n                ^\n  symbol:   variable sc\n  location: class Main\nMain.java:8: error: cannot find symbol\n        in res = a + b;\n        ^\n  symbol:   class in\n  location: class Main\n3 errors\n	\N	\N
5641	378	27	ce7d1924-e73a-4fe4-86d3-9862640d4078	COMPILATION_ERROR	0	\N	2026-06-17 02:17:27.135482+07	Main.java:6: error: cannot find symbol\n        int a = sc.nextInt();\n                ^\n  symbol:   variable sc\n  location: class Main\nMain.java:7: error: cannot find symbol\n        int b = sc.nextInt();\n                ^\n  symbol:   variable sc\n  location: class Main\nMain.java:8: error: cannot find symbol\n        in res = a + b;\n        ^\n  symbol:   class in\n  location: class Main\n3 errors\n	\N	\N
5640	378	26	4beaaa89-4e25-4964-a8d5-98311fea221f	COMPILATION_ERROR	0	\N	2026-06-17 02:17:27.135481+07	Main.java:6: error: cannot find symbol\n        int a = sc.nextInt();\n                ^\n  symbol:   variable sc\n  location: class Main\nMain.java:7: error: cannot find symbol\n        int b = sc.nextInt();\n                ^\n  symbol:   variable sc\n  location: class Main\nMain.java:8: error: cannot find symbol\n        in res = a + b;\n        ^\n  symbol:   class in\n  location: class Main\n3 errors\n	\N	\N
5643	378	29	8ce09f9d-bbbf-4b0a-ace8-2022b30e1ab2	COMPILATION_ERROR	0	\N	2026-06-17 02:17:27.135485+07	Main.java:6: error: cannot find symbol\n        int a = sc.nextInt();\n                ^\n  symbol:   variable sc\n  location: class Main\nMain.java:7: error: cannot find symbol\n        int b = sc.nextInt();\n                ^\n  symbol:   variable sc\n  location: class Main\nMain.java:8: error: cannot find symbol\n        in res = a + b;\n        ^\n  symbol:   class in\n  location: class Main\n3 errors\n	\N	\N
5647	378	33	a27c543e-12bd-48e8-894d-1f2b922baaa6	COMPILATION_ERROR	0	\N	2026-06-17 02:17:27.13549+07	Main.java:6: error: cannot find symbol\n        int a = sc.nextInt();\n                ^\n  symbol:   variable sc\n  location: class Main\nMain.java:7: error: cannot find symbol\n        int b = sc.nextInt();\n                ^\n  symbol:   variable sc\n  location: class Main\nMain.java:8: error: cannot find symbol\n        in res = a + b;\n        ^\n  symbol:   class in\n  location: class Main\n3 errors\n	\N	\N
5635	378	21	6548da23-7026-4e98-b49c-cc4b97f6e2f5	COMPILATION_ERROR	0	\N	2026-06-17 02:17:27.135468+07	Main.java:6: error: cannot find symbol\n        int a = sc.nextInt();\n                ^\n  symbol:   variable sc\n  location: class Main\nMain.java:7: error: cannot find symbol\n        int b = sc.nextInt();\n                ^\n  symbol:   variable sc\n  location: class Main\nMain.java:8: error: cannot find symbol\n        in res = a + b;\n        ^\n  symbol:   class in\n  location: class Main\n3 errors\n	\N	\N
5639	378	25	fff541b7-9d5d-4568-86eb-637e1c41e72b	COMPILATION_ERROR	0	\N	2026-06-17 02:17:27.13548+07	Main.java:6: error: cannot find symbol\n        int a = sc.nextInt();\n                ^\n  symbol:   variable sc\n  location: class Main\nMain.java:7: error: cannot find symbol\n        int b = sc.nextInt();\n                ^\n  symbol:   variable sc\n  location: class Main\nMain.java:8: error: cannot find symbol\n        in res = a + b;\n        ^\n  symbol:   class in\n  location: class Main\n3 errors\n	\N	\N
5652	378	38	54fe9c10-aecf-47b4-9cba-475fa1312d24	COMPILATION_ERROR	0	\N	2026-06-17 02:17:27.135497+07	Main.java:6: error: cannot find symbol\n        int a = sc.nextInt();\n                ^\n  symbol:   variable sc\n  location: class Main\nMain.java:7: error: cannot find symbol\n        int b = sc.nextInt();\n                ^\n  symbol:   variable sc\n  location: class Main\nMain.java:8: error: cannot find symbol\n        in res = a + b;\n        ^\n  symbol:   class in\n  location: class Main\n3 errors\n	\N	\N
5649	378	35	1c0604c8-3590-4675-9acf-bc7e84a2a937	COMPILATION_ERROR	0	\N	2026-06-17 02:17:27.135493+07	Main.java:6: error: cannot find symbol\n        int a = sc.nextInt();\n                ^\n  symbol:   variable sc\n  location: class Main\nMain.java:7: error: cannot find symbol\n        int b = sc.nextInt();\n                ^\n  symbol:   variable sc\n  location: class Main\nMain.java:8: error: cannot find symbol\n        in res = a + b;\n        ^\n  symbol:   class in\n  location: class Main\n3 errors\n	\N	\N
5642	378	28	d1b09ed1-ddca-4b57-a979-d6fea66e35e1	COMPILATION_ERROR	0	\N	2026-06-17 02:17:27.135484+07	Main.java:6: error: cannot find symbol\n        int a = sc.nextInt();\n                ^\n  symbol:   variable sc\n  location: class Main\nMain.java:7: error: cannot find symbol\n        int b = sc.nextInt();\n                ^\n  symbol:   variable sc\n  location: class Main\nMain.java:8: error: cannot find symbol\n        in res = a + b;\n        ^\n  symbol:   class in\n  location: class Main\n3 errors\n	\N	\N
5644	378	30	4afee668-1597-4229-8d32-c91566d1b23f	COMPILATION_ERROR	0	\N	2026-06-17 02:17:27.135486+07	Main.java:6: error: cannot find symbol\n        int a = sc.nextInt();\n                ^\n  symbol:   variable sc\n  location: class Main\nMain.java:7: error: cannot find symbol\n        int b = sc.nextInt();\n                ^\n  symbol:   variable sc\n  location: class Main\nMain.java:8: error: cannot find symbol\n        in res = a + b;\n        ^\n  symbol:   class in\n  location: class Main\n3 errors\n	\N	\N
5648	378	34	4c93ddc0-ac41-48af-a72f-a3136bc9a6d1	COMPILATION_ERROR	0	\N	2026-06-17 02:17:27.135492+07	Main.java:6: error: cannot find symbol\n        int a = sc.nextInt();\n                ^\n  symbol:   variable sc\n  location: class Main\nMain.java:7: error: cannot find symbol\n        int b = sc.nextInt();\n                ^\n  symbol:   variable sc\n  location: class Main\nMain.java:8: error: cannot find symbol\n        in res = a + b;\n        ^\n  symbol:   class in\n  location: class Main\n3 errors\n	\N	\N
5625	377	29	98ad7b37-5e74-4d5e-bfdf-f9f54e008bc1	COMPILATION_ERROR	0	\N	2026-06-17 02:16:40.174179+07	Main.java:6: error: cannot find symbol\n        int a = sc.nextInt();\n                ^\n  symbol:   variable sc\n  location: class Main\nMain.java:7: error: cannot find symbol\n        int b = sc.nextInt();\n                ^\n  symbol:   variable sc\n  location: class Main\n2 errors\n	\N	\N
5654	379	22	0d077e29-7d2d-4532-8990-53f016d98e1e	COMPILATION_ERROR	0	\N	2026-06-17 02:17:33.34018+07	Main.java:6: error: cannot find symbol\n        int a = sc.nextInt();\n                ^\n  symbol:   variable sc\n  location: class Main\nMain.java:7: error: cannot find symbol\n        int b = sc.nextInt();\n                ^\n  symbol:   variable sc\n  location: class Main\n2 errors\n	\N	\N
5665	379	33	6bf3401c-a5e0-4ba7-8c1c-5f1dad4bc7b8	COMPILATION_ERROR	0	\N	2026-06-17 02:17:33.340207+07	Main.java:6: error: cannot find symbol\n        int a = sc.nextInt();\n                ^\n  symbol:   variable sc\n  location: class Main\nMain.java:7: error: cannot find symbol\n        int b = sc.nextInt();\n                ^\n  symbol:   variable sc\n  location: class Main\n2 errors\n	\N	\N
5983	417	37	f20292fc-c0cd-4cb8-aa22-97c372c33168	ACCEPTED	4	836	2026-06-19 00:23:19.05104+07	\N	\N	1000\n
5974	417	28	7f3b69a3-c65f-4db5-8341-16e1d39a099d	ACCEPTED	3	876	2026-06-19 00:23:19.05103+07	\N	\N	579\n
5977	417	31	1d5abf2b-2d23-4740-a598-17fbeb31c434	ACCEPTED	4	1088	2026-06-19 00:23:19.051034+07	\N	\N	30000\n
5972	417	26	29ed9427-4122-4f5d-8531-63b4f46b9789	ACCEPTED	3	832	2026-06-19 00:23:19.051025+07	\N	\N	-30\n
5986	417	58	69399289-fe3f-40fe-99a3-fca90d186841	ACCEPTED	3	872	2026-06-19 00:23:19.051043+07	\N	\N	803799\n
5979	417	33	370c69fc-bf54-4dae-8579-89d7efb5020f	ACCEPTED	5	880	2026-06-19 00:23:19.051036+07	\N	\N	84\n
5976	417	30	ce8d4158-7eaf-4b24-aea2-5ce96ab35bfd	ACCEPTED	12	856	2026-06-19 00:23:19.051033+07	\N	\N	0\n
5989	417	61	038a75df-a826-45ea-8c4b-eca24cbb79d3	ACCEPTED	4	824	2026-06-19 00:23:19.051046+07	\N	\N	879721\n
5980	417	34	faee7ba2-3660-40f4-a0af-386b1b6243a6	ACCEPTED	8	868	2026-06-19 00:23:19.051037+07	\N	\N	15\n
5987	417	59	d8ac6712-65cf-459a-9d90-8318908b5c5e	ACCEPTED	4	860	2026-06-19 00:23:19.051044+07	\N	\N	545178\n
5973	417	27	9e9a903a-397c-43fb-a791-e7073a91bb30	ACCEPTED	4	872	2026-06-19 00:23:19.051026+07	\N	\N	1000\n
5982	417	36	8dedd80e-9b18-4ca8-a175-3a987e9b39fc	ACCEPTED	3	828	2026-06-19 00:23:19.051039+07	\N	\N	801\n
5990	417	62	0fad625c-a0ac-448a-8de9-e383d8afe9db	ACCEPTED	3	844	2026-06-19 00:23:19.051047+07	\N	\N	1486218\n
5981	417	35	30723bd9-6d2a-4089-bf1e-96a4e496fc67	ACCEPTED	4	848	2026-06-19 00:23:19.051038+07	\N	\N	-2\n
5984	417	38	d957e5b3-b9de-421d-9d79-b10e654a58f7	ACCEPTED	5	844	2026-06-19 00:23:19.051041+07	\N	\N	3000000\n
5985	417	57	f92d34ea-989f-4f96-bbc9-ed3e045f6e65	ACCEPTED	3	832	2026-06-19 00:23:19.051042+07	\N	\N	787228\n
5993	417	65	b4b9fe52-3b36-4e5c-bdd5-bc5de8129bdc	ACCEPTED	4	828	2026-06-19 00:23:19.051051+07	\N	\N	475745\n
5992	417	64	f36d0796-4849-4d81-a92d-901a51cc431e	ACCEPTED	3	864	2026-06-19 00:23:19.05105+07	\N	\N	710339\n
5998	417	70	fa02c072-82ef-440d-9626-57610aa1ca7f	ACCEPTED	4	836	2026-06-19 00:23:19.051056+07	\N	\N	959298\n
5994	417	66	8aa1ac68-ff1c-47e4-b6b7-907d242736e7	ACCEPTED	4	836	2026-06-19 00:23:19.051052+07	\N	\N	129492\n
5996	417	68	814911a9-f193-43b9-a87a-1dea6e708539	ACCEPTED	4	1092	2026-06-19 00:23:19.051054+07	\N	\N	1161167\n
5997	417	69	2777d0cf-88bb-42df-b610-6f2b86b08b78	ACCEPTED	5	880	2026-06-19 00:23:19.051055+07	\N	\N	616334\n
6001	417	73	c0db235d-9545-4c41-b087-4fbed815a3b5	ACCEPTED	5	844	2026-06-19 00:23:19.051059+07	\N	\N	702179\n
6010	417	82	75066062-a9bc-4fdf-b895-44c99266886a	ACCEPTED	5	860	2026-06-19 00:23:19.051068+07	\N	\N	-1795574\n
6008	417	80	06721e90-a75a-4022-8249-bffcea852fcf	ACCEPTED	3	840	2026-06-19 00:23:19.051066+07	\N	\N	-1611196\n
6003	417	75	8b3db55a-d72f-4304-a796-4c6d9bd54143	ACCEPTED	4	1076	2026-06-19 00:23:19.051061+07	\N	\N	1760278\n
6004	417	76	b8bbda10-7482-43c9-80e7-444cc9b0a036	ACCEPTED	4	1080	2026-06-19 00:23:19.051062+07	\N	\N	802483\n
6007	417	79	14ffee1b-e0ac-4df9-bc65-8030d419cae6	ACCEPTED	5	1108	2026-06-19 00:23:19.051065+07	\N	\N	-1351853\n
6011	417	83	cbed87bc-9270-46c4-82db-44cbefc734ad	ACCEPTED	6	832	2026-06-19 00:23:19.051069+07	\N	\N	-1500204\n
6005	417	77	d8db881e-f413-4fb4-a20c-14c378413f1b	ACCEPTED	4	844	2026-06-19 00:23:19.051063+07	\N	\N	-987624\n
6000	417	72	86434d3c-edb7-4089-aa62-a036144e193f	ACCEPTED	5	828	2026-06-19 00:23:19.051058+07	\N	\N	1011312\n
6009	417	81	b74aee19-4eb7-4acc-80df-6d1c98eccfae	ACCEPTED	11	840	2026-06-19 00:23:19.051067+07	\N	\N	-846475\n
6002	417	74	28c19cf6-3042-4f1c-ac6d-3a295aeae0bc	ACCEPTED	16	836	2026-06-19 00:23:19.05106+07	\N	\N	909595\n
6013	417	85	1fae39fb-23d0-491e-887d-ca070ca66ecd	ACCEPTED	6	832	2026-06-19 00:23:19.051071+07	\N	\N	-1006285\n
6012	417	84	ff8fab6a-7837-4f4a-97ef-c1a6d9e1e9bc	ACCEPTED	5	828	2026-06-19 00:23:19.05107+07	\N	\N	-734921\n
6018	417	90	5688e499-2ec5-4926-a406-23075be5553f	ACCEPTED	4	844	2026-06-19 00:23:19.051078+07	\N	\N	-1520451\n
6016	417	88	7ffc109b-ee61-4a3d-b781-7020ebd7241a	ACCEPTED	3	836	2026-06-19 00:23:19.051076+07	\N	\N	-955984\n
6019	417	91	432c81b9-47d2-4714-b863-9b965701941d	ACCEPTED	4	880	2026-06-19 00:23:19.051079+07	\N	\N	-1113725\n
6015	417	87	eddd5b2a-6297-440a-9bf3-200259dcaec5	ACCEPTED	3	828	2026-06-19 00:23:19.051074+07	\N	\N	-1189260\n
6020	417	92	00334bbf-8095-40ae-b98e-02a2fb9cfcc9	ACCEPTED	3	828	2026-06-19 00:23:19.05108+07	\N	\N	-471131\n
6022	417	94	1a8f0cfe-f7b6-4be4-9845-fa6d93867917	ACCEPTED	4	824	2026-06-19 00:23:19.051082+07	\N	\N	-717234\n
6023	417	95	71b4d9f5-bb82-4d08-b200-d38ea2bf5d49	ACCEPTED	3	828	2026-06-19 00:23:19.051083+07	\N	\N	-1192974\n
6025	417	97	23f14739-b7be-4f67-8548-4658c684a106	ACCEPTED	5	824	2026-06-19 00:23:19.051085+07	\N	\N	-517131\n
6026	417	98	52a11cd5-ec45-4e32-9a92-cac18a7c5904	ACCEPTED	4	832	2026-06-19 00:23:19.051086+07	\N	\N	99178\n
6027	417	99	a6884831-0cba-438d-bdbd-deace111de1f	ACCEPTED	3	828	2026-06-19 00:23:19.051087+07	\N	\N	-1225775\n
6030	417	102	daa83f97-0d35-45c5-a4bd-f49bee9990b4	ACCEPTED	4	844	2026-06-19 00:23:19.05109+07	\N	\N	-619866\n
6028	417	100	f527da69-bd0c-4d19-a368-c6050f37c954	ACCEPTED	4	1052	2026-06-19 00:23:19.051088+07	\N	\N	281928\n
6029	417	101	7bafe2c7-5d48-4a7b-92e6-30ee749fa5ef	ACCEPTED	4	1100	2026-06-19 00:23:19.051089+07	\N	\N	28962\n
5651	378	37	0776eb83-2ef8-461d-b913-a058d1ac80fc	COMPILATION_ERROR	0	\N	2026-06-17 02:17:27.135495+07	Main.java:6: error: cannot find symbol\n        int a = sc.nextInt();\n                ^\n  symbol:   variable sc\n  location: class Main\nMain.java:7: error: cannot find symbol\n        int b = sc.nextInt();\n                ^\n  symbol:   variable sc\n  location: class Main\nMain.java:8: error: cannot find symbol\n        in res = a + b;\n        ^\n  symbol:   class in\n  location: class Main\n3 errors\n	\N	\N
5645	378	31	695b3358-3bb8-4817-a6b0-201e83e09f23	COMPILATION_ERROR	0	\N	2026-06-17 02:17:27.135488+07	Main.java:6: error: cannot find symbol\n        int a = sc.nextInt();\n                ^\n  symbol:   variable sc\n  location: class Main\nMain.java:7: error: cannot find symbol\n        int b = sc.nextInt();\n                ^\n  symbol:   variable sc\n  location: class Main\nMain.java:8: error: cannot find symbol\n        in res = a + b;\n        ^\n  symbol:   class in\n  location: class Main\n3 errors\n	\N	\N
5636	378	22	f188183f-84a8-4e73-82f0-aadc78ccf16c	COMPILATION_ERROR	0	\N	2026-06-17 02:17:27.135476+07	Main.java:6: error: cannot find symbol\n        int a = sc.nextInt();\n                ^\n  symbol:   variable sc\n  location: class Main\nMain.java:7: error: cannot find symbol\n        int b = sc.nextInt();\n                ^\n  symbol:   variable sc\n  location: class Main\nMain.java:8: error: cannot find symbol\n        in res = a + b;\n        ^\n  symbol:   class in\n  location: class Main\n3 errors\n	\N	\N
5638	378	24	bc503558-1842-4641-86b0-b732d1b0beea	COMPILATION_ERROR	0	\N	2026-06-17 02:17:27.135479+07	Main.java:6: error: cannot find symbol\n        int a = sc.nextInt();\n                ^\n  symbol:   variable sc\n  location: class Main\nMain.java:7: error: cannot find symbol\n        int b = sc.nextInt();\n                ^\n  symbol:   variable sc\n  location: class Main\nMain.java:8: error: cannot find symbol\n        in res = a + b;\n        ^\n  symbol:   class in\n  location: class Main\n3 errors\n	\N	\N
5646	378	32	64d3d6be-627d-4374-9ec7-a80ef5f7a7fe	COMPILATION_ERROR	0	\N	2026-06-17 02:17:27.135489+07	Main.java:6: error: cannot find symbol\n        int a = sc.nextInt();\n                ^\n  symbol:   variable sc\n  location: class Main\nMain.java:7: error: cannot find symbol\n        int b = sc.nextInt();\n                ^\n  symbol:   variable sc\n  location: class Main\nMain.java:8: error: cannot find symbol\n        in res = a + b;\n        ^\n  symbol:   class in\n  location: class Main\n3 errors\n	\N	\N
5650	378	36	0be5c09c-153d-4eb4-81db-0ce5cc940eaa	COMPILATION_ERROR	0	\N	2026-06-17 02:17:27.135494+07	Main.java:6: error: cannot find symbol\n        int a = sc.nextInt();\n                ^\n  symbol:   variable sc\n  location: class Main\nMain.java:7: error: cannot find symbol\n        int b = sc.nextInt();\n                ^\n  symbol:   variable sc\n  location: class Main\nMain.java:8: error: cannot find symbol\n        in res = a + b;\n        ^\n  symbol:   class in\n  location: class Main\n3 errors\n	\N	\N
5660	379	28	91eabc3f-3463-402b-8eef-bff33d668776	COMPILATION_ERROR	0	\N	2026-06-17 02:17:33.340191+07	Main.java:6: error: cannot find symbol\n        int a = sc.nextInt();\n                ^\n  symbol:   variable sc\n  location: class Main\nMain.java:7: error: cannot find symbol\n        int b = sc.nextInt();\n                ^\n  symbol:   variable sc\n  location: class Main\n2 errors\n	\N	\N
5653	379	21	fd218cf8-dfe8-48c0-9204-f7b216cb9e72	COMPILATION_ERROR	0	\N	2026-06-17 02:17:33.340175+07	Main.java:6: error: cannot find symbol\n        int a = sc.nextInt();\n                ^\n  symbol:   variable sc\n  location: class Main\nMain.java:7: error: cannot find symbol\n        int b = sc.nextInt();\n                ^\n  symbol:   variable sc\n  location: class Main\n2 errors\n	\N	\N
5659	379	27	6f729212-e7ea-4832-a360-9c6cca48c4b6	COMPILATION_ERROR	0	\N	2026-06-17 02:17:33.34019+07	Main.java:6: error: cannot find symbol\n        int a = sc.nextInt();\n                ^\n  symbol:   variable sc\n  location: class Main\nMain.java:7: error: cannot find symbol\n        int b = sc.nextInt();\n                ^\n  symbol:   variable sc\n  location: class Main\n2 errors\n	\N	\N
5664	379	32	88380bcc-1720-4d4c-ac6f-f19beb35a002	COMPILATION_ERROR	0	\N	2026-06-17 02:17:33.340206+07	Main.java:6: error: cannot find symbol\n        int a = sc.nextInt();\n                ^\n  symbol:   variable sc\n  location: class Main\nMain.java:7: error: cannot find symbol\n        int b = sc.nextInt();\n                ^\n  symbol:   variable sc\n  location: class Main\n2 errors\n	\N	\N
5663	379	31	b6c3f81f-3078-417b-9c9b-586684f3ff62	COMPILATION_ERROR	0	\N	2026-06-17 02:17:33.340195+07	Main.java:6: error: cannot find symbol\n        int a = sc.nextInt();\n                ^\n  symbol:   variable sc\n  location: class Main\nMain.java:7: error: cannot find symbol\n        int b = sc.nextInt();\n                ^\n  symbol:   variable sc\n  location: class Main\n2 errors\n	\N	\N
5658	379	26	d7b15914-1f11-4eea-9b13-aff3d4461372	COMPILATION_ERROR	0	\N	2026-06-17 02:17:33.340189+07	Main.java:6: error: cannot find symbol\n        int a = sc.nextInt();\n                ^\n  symbol:   variable sc\n  location: class Main\nMain.java:7: error: cannot find symbol\n        int b = sc.nextInt();\n                ^\n  symbol:   variable sc\n  location: class Main\n2 errors\n	\N	\N
5656	379	24	bb554b7c-ac37-4995-ac40-2d8bad018faf	COMPILATION_ERROR	0	\N	2026-06-17 02:17:33.340186+07	Main.java:6: error: cannot find symbol\n        int a = sc.nextInt();\n                ^\n  symbol:   variable sc\n  location: class Main\nMain.java:7: error: cannot find symbol\n        int b = sc.nextInt();\n                ^\n  symbol:   variable sc\n  location: class Main\n2 errors\n	\N	\N
5662	379	30	04835335-246e-4793-8447-d9706033189d	COMPILATION_ERROR	0	\N	2026-06-17 02:17:33.340194+07	Main.java:6: error: cannot find symbol\n        int a = sc.nextInt();\n                ^\n  symbol:   variable sc\n  location: class Main\nMain.java:7: error: cannot find symbol\n        int b = sc.nextInt();\n                ^\n  symbol:   variable sc\n  location: class Main\n2 errors\n	\N	\N
5670	379	38	3a1d12dc-3160-495c-a3e3-03e1d60473a5	COMPILATION_ERROR	0	\N	2026-06-17 02:17:33.340213+07	Main.java:6: error: cannot find symbol\n        int a = sc.nextInt();\n                ^\n  symbol:   variable sc\n  location: class Main\nMain.java:7: error: cannot find symbol\n        int b = sc.nextInt();\n                ^\n  symbol:   variable sc\n  location: class Main\n2 errors\n	\N	\N
5667	379	35	dfbf1914-f66f-42b9-86e1-e23a719fe625	COMPILATION_ERROR	0	\N	2026-06-17 02:17:33.340209+07	Main.java:6: error: cannot find symbol\n        int a = sc.nextInt();\n                ^\n  symbol:   variable sc\n  location: class Main\nMain.java:7: error: cannot find symbol\n        int b = sc.nextInt();\n                ^\n  symbol:   variable sc\n  location: class Main\n2 errors\n	\N	\N
5655	379	23	a06bedb3-c352-485f-aced-f8b1467d7a64	COMPILATION_ERROR	0	\N	2026-06-17 02:17:33.340185+07	Main.java:6: error: cannot find symbol\n        int a = sc.nextInt();\n                ^\n  symbol:   variable sc\n  location: class Main\nMain.java:7: error: cannot find symbol\n        int b = sc.nextInt();\n                ^\n  symbol:   variable sc\n  location: class Main\n2 errors\n	\N	\N
5661	379	29	afefc0c4-c233-4019-ba53-9e106ed2f3b9	COMPILATION_ERROR	0	\N	2026-06-17 02:17:33.340193+07	Main.java:6: error: cannot find symbol\n        int a = sc.nextInt();\n                ^\n  symbol:   variable sc\n  location: class Main\nMain.java:7: error: cannot find symbol\n        int b = sc.nextInt();\n                ^\n  symbol:   variable sc\n  location: class Main\n2 errors\n	\N	\N
5668	379	36	57b3c576-87a6-4d26-b959-05a7f0f4f2b4	COMPILATION_ERROR	0	\N	2026-06-17 02:17:33.34021+07	Main.java:6: error: cannot find symbol\n        int a = sc.nextInt();\n                ^\n  symbol:   variable sc\n  location: class Main\nMain.java:7: error: cannot find symbol\n        int b = sc.nextInt();\n                ^\n  symbol:   variable sc\n  location: class Main\n2 errors\n	\N	\N
5969	417	23	e9fa711b-9551-44b5-86b3-a192b15917e7	ACCEPTED	4	20436	2026-06-19 00:23:19.051021+07	\N	\N	0\n
5988	417	60	d6ad5061-90f5-4f3f-adb2-39f4bbff219b	ACCEPTED	3	868	2026-06-19 00:23:19.051045+07	\N	\N	380371\n
5971	417	25	25690fac-9c28-4525-817d-0b459c2370e2	ACCEPTED	3	744	2026-06-19 00:23:19.051024+07	\N	\N	300\n
5991	417	63	d87a212d-c0d7-4477-8a21-f3f1c28eb249	ACCEPTED	3	876	2026-06-19 00:23:19.051049+07	\N	\N	1507378\n
6006	417	78	77a6d7a9-1ab4-4a47-a8f4-a40f4c26fccb	ACCEPTED	5	832	2026-06-19 00:23:19.051064+07	\N	\N	-824805\n
6014	417	86	ddab338f-4325-4592-96e8-0564e56770a7	ACCEPTED	18	864	2026-06-19 00:23:19.051072+07	\N	\N	-876295\n
6017	417	89	c4c0cdbc-733b-406b-818d-7acf2f1ce1e6	ACCEPTED	6	836	2026-06-19 00:23:19.051077+07	\N	\N	-902015\n
6021	417	93	30ce1f69-e930-47de-9d9e-b143e8b74f16	ACCEPTED	4	828	2026-06-19 00:23:19.051081+07	\N	\N	-422973\n
6024	417	96	91e981a9-0fe9-46bb-89aa-2b09e106208b	ACCEPTED	7	868	2026-06-19 00:23:19.051084+07	\N	\N	-1188270\n
6035	417	107	0f0ea0f1-1a1a-4c90-99ab-044809fdb851	ACCEPTED	4	840	2026-06-19 00:23:19.051094+07	\N	\N	-34648\n
6032	417	104	2fc4e530-d378-4e49-a65d-c3d82cb18553	ACCEPTED	4	828	2026-06-19 00:23:19.051092+07	\N	\N	514364\n
6034	417	106	56abedbc-b984-4774-992b-7c40fc45fef4	ACCEPTED	4	880	2026-06-19 00:23:19.051093+07	\N	\N	-815576\n
6033	417	105	d8ae7812-f885-4731-861f-ddc25799b684	ACCEPTED	3	836	2026-06-19 00:23:19.051093+07	\N	\N	-882565\n
6031	417	103	00549aba-7ea4-473a-9181-0d3798e147fc	ACCEPTED	4	832	2026-06-19 00:23:19.051091+07	\N	\N	283996\n
6036	417	108	103a56ed-8633-4acf-8272-f46946cba789	ACCEPTED	3	904	2026-06-19 00:23:19.051095+07	\N	\N	1436130\n
6037	417	109	aa068851-9900-4ff1-a4fc-5759195b7037	ACCEPTED	4	1096	2026-06-19 00:23:19.051096+07	\N	\N	792531\n
6040	417	112	70a199a2-f2dd-4d4d-815a-16544144b7f7	ACCEPTED	3	828	2026-06-19 00:23:19.051163+07	\N	\N	649261\n
6039	417	111	2374ada2-6dca-478f-a653-100626ff52f4	ACCEPTED	5	852	2026-06-19 00:23:19.051161+07	\N	\N	-309452\n
6043	417	115	d6bae09e-05ff-4533-9cb1-1bf3cd649d89	ACCEPTED	4	832	2026-06-19 00:23:19.051168+07	\N	\N	506806\n
6038	417	110	7f059741-56af-4ec9-8e17-c5b4171a2420	ACCEPTED	3	868	2026-06-19 00:23:19.051143+07	\N	\N	-572819\n
6041	417	113	0e8f70a4-a37f-489a-9e71-8991bb8e5e25	ACCEPTED	6	832	2026-06-19 00:23:19.051165+07	\N	\N	-1143916\n
6042	417	114	54d4d88d-724c-4d98-8d62-684f99795f4c	ACCEPTED	8	864	2026-06-19 00:23:19.051167+07	\N	\N	-234796\n
6044	417	116	b897bffd-a79d-439d-ba96-cabf41e4b66d	ACCEPTED	4	828	2026-06-19 00:23:19.051169+07	\N	\N	785356\n
6045	417	117	983a0bd1-558c-49a8-8594-76a3e3e41567	ACCEPTED	6	872	2026-06-19 00:23:19.051171+07	\N	\N	362210245\n
6046	417	118	dc19a96c-85d2-47ec-a970-44497aa695a0	ACCEPTED	8	864	2026-06-19 00:23:19.051172+07	\N	\N	636465324\n
6047	417	119	6f423cc8-b21b-4539-8aec-58cd47c579dc	ACCEPTED	4	836	2026-06-19 00:23:19.051173+07	\N	\N	-738231997\n
6049	417	121	c3b792c6-0bed-4488-a152-b125dfdee9d0	ACCEPTED	4	828	2026-06-19 00:23:19.051176+07	\N	\N	1259817393\n
6051	417	123	61564f43-2318-4ed0-99c0-88b1a02db3a3	ACCEPTED	4	864	2026-06-19 00:23:19.051179+07	\N	\N	1422690276\n
6048	417	120	b68b244b-c92e-4277-8cc7-d64a07740206	ACCEPTED	7	828	2026-06-19 00:23:19.051175+07	\N	\N	371467497\n
6055	417	127	0b494ed0-5b63-4054-8c2c-57a56ce6dfaa	ACCEPTED	5	900	2026-06-19 00:23:19.051184+07	\N	\N	0\n
6050	417	122	7b410464-74af-4338-ab2f-89d84b01c603	ACCEPTED	5	868	2026-06-19 00:23:19.051177+07	\N	\N	-457820119\n
6053	417	125	0107b5ab-4479-4f98-a117-7272cf5cc238	ACCEPTED	4	792	2026-06-19 00:23:19.051181+07	\N	\N	86961293\n
6052	417	124	7a6284d2-34a3-4341-b7bb-c2091ae6c52a	ACCEPTED	4	864	2026-06-19 00:23:19.05118+07	\N	\N	1610593689\n
6056	417	128	9827bde2-6fe7-45ac-b251-968646add87a	ACCEPTED	3	824	2026-06-19 00:23:19.051185+07	\N	\N	82\n
6059	417	131	890da4a7-7e0a-47c4-a412-8eef50d212f8	ACCEPTED	3	864	2026-06-19 00:23:19.05119+07	\N	\N	71\n
6057	417	129	98564020-b61c-4151-8d2e-0b32fea0b99b	ACCEPTED	4	860	2026-06-19 00:23:19.051186+07	\N	\N	-32\n
6058	417	130	764589c3-5550-4824-bb73-363936aab2a5	ACCEPTED	4	1052	2026-06-19 00:23:19.051188+07	\N	\N	-5\n
6054	417	126	beba322b-fa63-4827-b4bd-a217e6b0e78f	ACCEPTED	3	876	2026-06-19 00:23:19.051183+07	\N	\N	-882105735\n
6060	417	132	79412ad3-e37e-4870-82be-3065b1a4c09f	ACCEPTED	4	920	2026-06-19 00:23:19.051191+07	\N	\N	-1\n
6061	417	133	900a4590-cc0c-44df-9738-1393e09cc510	ACCEPTED	3	880	2026-06-19 00:23:19.051192+07	\N	\N	-57\n
6065	417	137	5e19d21d-df05-40b6-ac4c-5399e8f09e67	ACCEPTED	4	908	2026-06-19 00:23:19.051198+07	\N	\N	64\n
6062	417	134	4c45c593-195a-44ea-8d93-6eda1483bf62	ACCEPTED	3	880	2026-06-19 00:23:19.051194+07	\N	\N	158\n
6066	417	138	6383f197-d98d-4bff-823f-321de7b51cab	ACCEPTED	4	876	2026-06-19 00:23:19.051199+07	\N	\N	51\n
6063	417	135	43f0b165-70de-4e27-886c-5f881dfc074a	ACCEPTED	3	876	2026-06-19 00:23:19.051195+07	\N	\N	3\n
6064	417	136	2a1d9005-0d48-4ba9-abb4-db28b8ea834c	ACCEPTED	2	876	2026-06-19 00:23:19.051196+07	\N	\N	129\n
6068	418	22	808a6031-f3d2-46f1-b306-37bd3bee9d77	PENDING	\N	\N	2026-06-19 00:23:37.592354+07	\N	\N	\N
6072	418	26	089909eb-af1a-432d-b327-eb09c929186c	PENDING	\N	\N	2026-06-19 00:23:37.592357+07	\N	\N	\N
6071	418	25	d1316149-cf16-44b2-baf7-d69b6cd61fe9	ACCEPTED	3	824	2026-06-19 00:23:37.592357+07	\N	\N	300\n
6067	418	21	9f8aacec-c3d4-45e9-83ab-c6b9e7f51ec5	ACCEPTED	7	864	2026-06-19 00:23:37.592351+07	\N	\N	3\n
6070	418	24	ad4c02f9-9502-4947-8f3f-90951ffec7bd	ACCEPTED	3	880	2026-06-19 00:23:37.592356+07	\N	\N	0\n
6073	418	27	2d383389-58e1-47e0-893c-63a56232c2da	ACCEPTED	3	1088	2026-06-19 00:23:37.592358+07	\N	\N	1000\n
6069	418	23	a6638182-e2fd-4565-9b8b-13a27e9a9854	ACCEPTED	4	868	2026-06-19 00:23:37.592355+07	\N	\N	0\n
7286	441	86	64b7963d-4e2f-44b5-8ba9-b3eb994f1ef5	ACCEPTED	5	884	2026-06-19 01:46:36.14565+07	\N	\N	-876295\n
7287	441	87	aea60aba-980e-47b3-a7fe-7d2f2b577863	ACCEPTED	5	1016	2026-06-19 01:46:36.145652+07	\N	\N	-1189260\n
7288	441	88	632d71a6-daef-473a-a469-19bdd4775302	ACCEPTED	5	868	2026-06-19 01:46:36.145653+07	\N	\N	-955984\n
5666	379	34	080434b0-33d3-4a8a-96ad-a8692c359e56	COMPILATION_ERROR	0	\N	2026-06-17 02:17:33.340208+07	Main.java:6: error: cannot find symbol\n        int a = sc.nextInt();\n                ^\n  symbol:   variable sc\n  location: class Main\nMain.java:7: error: cannot find symbol\n        int b = sc.nextInt();\n                ^\n  symbol:   variable sc\n  location: class Main\n2 errors\n	\N	\N
5657	379	25	9ad3eab0-1947-4c0d-9672-b19de9a3b777	COMPILATION_ERROR	0	\N	2026-06-17 02:17:33.340188+07	Main.java:6: error: cannot find symbol\n        int a = sc.nextInt();\n                ^\n  symbol:   variable sc\n  location: class Main\nMain.java:7: error: cannot find symbol\n        int b = sc.nextInt();\n                ^\n  symbol:   variable sc\n  location: class Main\n2 errors\n	\N	\N
5669	379	37	594339a5-4691-487c-b962-58b9a947e8b5	COMPILATION_ERROR	0	\N	2026-06-17 02:17:33.340212+07	Main.java:6: error: cannot find symbol\n        int a = sc.nextInt();\n                ^\n  symbol:   variable sc\n  location: class Main\nMain.java:7: error: cannot find symbol\n        int b = sc.nextInt();\n                ^\n  symbol:   variable sc\n  location: class Main\n2 errors\n	\N	\N
5978	417	32	2e27a1db-7d21-4c50-bf70-39b6f27b5f70	ACCEPTED	6	828	2026-06-19 00:23:19.051035+07	\N	\N	0\n
5995	417	67	57513cfc-219d-4d0a-8f8c-8c521dbe12cc	ACCEPTED	5	864	2026-06-19 00:23:19.051053+07	\N	\N	473222\n
5999	417	71	f09b3032-5c83-4fd9-aae0-ad9d2920c142	ACCEPTED	4	856	2026-06-19 00:23:19.051057+07	\N	\N	1416847\n
6118	418	90	a97c71bd-70a3-4c42-a3a8-afcc098f8eec	ACCEPTED	3	1076	2026-06-19 00:23:37.592408+07	\N	\N	-1520451\n
6131	418	103	57337a40-9d4f-4566-beb0-c9d7db07c5bf	ACCEPTED	5	876	2026-06-19 00:23:37.592418+07	\N	\N	283996\n
6146	418	118	98a18c45-25fd-411d-823b-afb75d88cb0e	ACCEPTED	6	852	2026-06-19 00:23:37.592433+07	\N	\N	636465324\n
6165	418	137	72cc34d5-b34e-44b1-b33b-c0f59f228398	ACCEPTED	2	1068	2026-06-19 00:23:37.592449+07	\N	\N	64\n
6282	420	36	f2073730-e1c5-4bbb-a7e5-63add2b6eb7a	ACCEPTED	5	880	2026-06-19 00:26:04.575162+07	\N	\N	801\n
6281	420	35	d77e07ec-530f-4290-b8bc-67ffe715e532	ACCEPTED	7	1024	2026-06-19 00:26:04.575161+07	\N	\N	-2\n
6274	420	28	eceba587-3be5-4875-a115-131831b1e195	ACCEPTED	5	1012	2026-06-19 00:26:04.575153+07	\N	\N	579\n
6299	420	71	ba1d0e25-ddcd-45e6-b5e3-4104fb03591e	ACCEPTED	6	1028	2026-06-19 00:26:04.575185+07	\N	\N	1416847\n
6302	420	74	89934466-6366-4c1b-a0e8-c6c526cf0e83	ACCEPTED	11	1032	2026-06-19 00:26:04.575189+07	\N	\N	909595\n
6298	420	70	bb3e80d3-64b2-475f-bac1-ac8cfd9c6a77	ACCEPTED	5	1028	2026-06-19 00:26:04.575184+07	\N	\N	959298\n
6301	420	73	158ee731-a335-4826-b915-b4024a6635b4	ACCEPTED	7	1024	2026-06-19 00:26:04.575188+07	\N	\N	702179\n
6310	420	82	988e310a-f61d-4fa2-bce5-b6eb883cd20f	ACCEPTED	5	876	2026-06-19 00:26:04.575197+07	\N	\N	-1795574\n
6319	420	91	f92d4958-fce8-4a7c-99ad-1051c7489488	ACCEPTED	5	876	2026-06-19 00:26:04.575206+07	\N	\N	-1113725\n
6323	420	95	31869a13-71ce-4e64-99e8-61b32065798f	ACCEPTED	4	1092	2026-06-19 00:26:04.57521+07	\N	\N	-1192974\n
6318	420	90	be27d415-9cd4-4a9d-8663-35c47c6e5364	ACCEPTED	5	1020	2026-06-19 00:26:04.575205+07	\N	\N	-1520451\n
6328	420	100	bd790833-87ed-4934-9d7b-c867930117bf	ACCEPTED	5	1016	2026-06-19 00:26:04.575215+07	\N	\N	281928\n
6337	420	109	624c96a1-fcdf-4d58-b41a-b11e4a49d630	ACCEPTED	6	824	2026-06-19 00:26:04.575224+07	\N	\N	792531\n
6340	420	112	3caca0f5-a12a-4d63-9e03-494b2d935148	ACCEPTED	5	864	2026-06-19 00:26:04.575227+07	\N	\N	649261\n
6345	420	117	d5adb7c6-6902-497d-8ce4-f22504147b0d	ACCEPTED	5	1088	2026-06-19 00:26:04.575233+07	\N	\N	362210245\n
6362	420	134	070db4c6-efb1-4620-a141-5b434bf79fc6	ACCEPTED	5	1024	2026-06-19 00:26:04.575284+07	\N	\N	158\n
6364	420	136	3981debf-6a5c-4794-99cf-467b9edc86d3	ACCEPTED	5	1200	2026-06-19 00:26:04.575285+07	\N	\N	129\n
6363	420	135	afc70332-6673-49a4-af5a-33201dafeb6b	ACCEPTED	4	1052	2026-06-19 00:26:04.575284+07	\N	\N	3\n
6366	420	138	58c11bd3-4f54-47e9-bef0-f17801c9a245	ACCEPTED	3	1056	2026-06-19 00:26:04.575287+07	\N	\N	51\n
6365	420	137	05dd5603-caf8-4e1c-898d-211ebda78de6	ACCEPTED	2	1100	2026-06-19 00:26:04.575286+07	\N	\N	64\n
6373	421	27	f4307a2d-3b80-4cec-8fc2-7773c862a773	ACCEPTED	12	996	2026-06-19 00:31:33.333723+07	\N	\N	1000\n
6369	421	23	61429739-b256-436b-bc28-65ce9ca9b66e	ACCEPTED	6	864	2026-06-19 00:31:33.33372+07	\N	\N	0\n
6387	421	59	67ef640c-73c9-4395-a3a4-54b0ceef173c	ACCEPTED	4	864	2026-06-19 00:31:33.333731+07	\N	\N	545178\n
6372	421	26	da6b800d-faa8-4c5f-9691-faf3f1ed98d5	ACCEPTED	5	876	2026-06-19 00:31:33.333722+07	\N	\N	-30\n
6379	421	33	eab94f54-bf41-45e9-be4f-6bd53c1d8eef	ACCEPTED	7	1032	2026-06-19 00:31:33.333726+07	\N	\N	84\n
6396	421	68	78200e09-c2f0-4558-af85-dfdf0cd13568	ACCEPTED	6	968	2026-06-19 00:31:33.333736+07	\N	\N	1161167\n
6400	421	72	28a3782c-a15b-46cb-9509-185150f5f460	ACCEPTED	7	1020	2026-06-19 00:31:33.333738+07	\N	\N	1011312\n
6453	421	125	3c3430b8-80d7-44a8-be60-5bdceccacab3	ACCEPTED	4	868	2026-06-19 00:31:33.333793+07	\N	\N	86961293\n
6455	421	127	f4acb707-fdb5-41f9-af4d-997db71fc6a8	ACCEPTED	6	1092	2026-06-19 00:31:33.333794+07	\N	\N	0\n
6459	421	131	faa77564-e0e3-4643-a05e-d36daca1defc	ACCEPTED	5	892	2026-06-19 00:31:33.333796+07	\N	\N	71\n
6454	421	126	83b44534-489d-489d-bc69-62833e3761cd	ACCEPTED	6	832	2026-06-19 00:31:33.333794+07	\N	\N	-882105735\n
6458	421	130	3defb1ee-4a09-4828-9506-51746715d11e	ACCEPTED	5	1016	2026-06-19 00:31:33.333796+07	\N	\N	-5\n
6457	421	129	3dc9fe81-a282-4816-a293-35aa1f4ed565	ACCEPTED	6	1016	2026-06-19 00:31:33.333795+07	\N	\N	-32\n
6452	421	124	ac5769e1-7f1e-45a4-88e9-e6b2c3741bee	ACCEPTED	4	1020	2026-06-19 00:31:33.333793+07	\N	\N	1610593689\n
6456	421	128	d771cef3-ce23-4197-b59e-b97db3cd162a	ACCEPTED	6	1016	2026-06-19 00:31:33.333795+07	\N	\N	82\n
6460	421	132	188bfbaa-5b4d-4bcf-a308-b826b8d1297c	ACCEPTED	4	1024	2026-06-19 00:31:33.333797+07	\N	\N	-1\n
6461	421	133	8880cf5e-5cbc-4d5e-8eee-e14ac6de6294	ACCEPTED	4	1016	2026-06-19 00:31:33.333797+07	\N	\N	-57\n
6462	421	134	5a2d5189-5fce-494c-907a-34a56369b590	ACCEPTED	3	1216	2026-06-19 00:31:33.333798+07	\N	\N	158\n
6463	421	135	996776e4-3458-4bc5-a432-250413b06a94	ACCEPTED	2	1052	2026-06-19 00:31:33.333799+07	\N	\N	3\n
6464	421	136	437631e1-64e8-4879-9e92-657606664ed1	ACCEPTED	4	1012	2026-06-19 00:31:33.333799+07	\N	\N	129\n
6465	421	137	91b6aa9b-12ee-42fd-8695-3427a650a915	ACCEPTED	2	1056	2026-06-19 00:31:33.3338+07	\N	\N	64\n
6466	421	138	1d77a567-4b4b-4335-82c4-67775a637212	ACCEPTED	2	1052	2026-06-19 00:31:33.3338+07	\N	\N	51\n
6522	422	94	74dd9465-4af0-463c-aa1c-28e8dd285506	ACCEPTED	7	988	2026-06-19 00:32:34.572109+07	\N	\N	-717234\n
5682	380	32	29d3b8b6-fdc7-4ae2-9d01-830522ba613c	ACCEPTED	194	14776	2026-06-17 02:18:16.165917+07	\N	\N	0\n
5679	380	29	5f0885e7-a205-4f82-b749-2e146ede945c	ACCEPTED	193	14676	2026-06-17 02:18:16.165914+07	\N	\N	99\n
5671	380	21	c46a658b-4555-4415-b859-baffd54e5ad7	ACCEPTED	196	15168	2026-06-17 02:18:16.165891+07	\N	\N	3\n
5687	380	37	a473a856-5bb2-4851-a8c8-f13649b718a8	ACCEPTED	199	14520	2026-06-17 02:18:16.165922+07	\N	\N	1000\n
5686	380	36	04b809a0-e6bf-4dc9-bf15-4ff338613e65	ACCEPTED	178	14600	2026-06-17 02:18:16.165921+07	\N	\N	801\n
5678	380	28	60a63b0c-6647-4235-99d9-804c474831db	ACCEPTED	183	14432	2026-06-17 02:18:16.165913+07	\N	\N	579\n
5684	380	34	15708133-bf8e-469e-aad3-adba037c7f5b	ACCEPTED	179	14440	2026-06-17 02:18:16.165919+07	\N	\N	15\n
5683	380	33	b8035f9a-c74b-4fc1-afe0-afcb039ecc09	ACCEPTED	183	14524	2026-06-17 02:18:16.165918+07	\N	\N	84\n
5677	380	27	57c65e4e-2350-4bb4-9a3d-24302ce95a8e	ACCEPTED	187	14592	2026-06-17 02:18:16.165912+07	\N	\N	1000\n
5688	380	38	0012b559-97b8-4d92-94a3-d88309e816e6	ACCEPTED	192	14516	2026-06-17 02:18:16.165923+07	\N	\N	3000000\n
5681	380	31	9cba80fb-42bb-44b3-9261-b0ea545990ce	ACCEPTED	175	14412	2026-06-17 02:18:16.165916+07	\N	\N	30000\n
5673	380	23	c1c9b906-a923-4387-8bfc-a218d4755a1a	ACCEPTED	197	14536	2026-06-17 02:18:16.165908+07	\N	\N	0\n
5680	380	30	5262a247-6943-42aa-8077-6c79b389c90e	ACCEPTED	191	14916	2026-06-17 02:18:16.165915+07	\N	\N	0\n
5675	380	25	a06d1af3-e505-4670-894c-04b30ca26b52	ACCEPTED	183	14568	2026-06-17 02:18:16.16591+07	\N	\N	300\n
5685	380	35	ef827924-9adc-4e2a-86bd-e64c9e1b79f6	ACCEPTED	191	14580	2026-06-17 02:18:16.16592+07	\N	\N	-2\n
5676	380	26	b91c8c0e-4b2d-42f9-9c2d-7ecdf64e13aa	ACCEPTED	167	14924	2026-06-17 02:18:16.165911+07	\N	\N	-30\n
5672	380	22	7346f34a-e6e6-4a0e-956d-01ff6cc31d02	ACCEPTED	153	14852	2026-06-17 02:18:16.165898+07	\N	\N	30\n
5674	380	24	4008bef9-7603-4c8e-8303-5e4102a6f9ce	ACCEPTED	134	15032	2026-06-17 02:18:16.165909+07	\N	\N	0\n
5975	417	29	ae81990d-c854-4196-9434-97f23c16edb4	ACCEPTED	6	1024	2026-06-19 00:23:19.051032+07	\N	\N	99\n
6277	420	31	60e2ff07-bef0-4b01-b1ef-7a0fa7f99a44	ACCEPTED	6	1220	2026-06-19 00:26:04.575156+07	\N	\N	30000\n
6355	420	127	133cb37b-9c7a-4b45-a37d-3a503e1dbdc5	ACCEPTED	5	1024	2026-06-19 00:26:04.575245+07	\N	\N	0\n
6405	421	77	2ecc774e-3356-41e7-9791-76999762df80	ACCEPTED	9	772	2026-06-19 00:31:33.333741+07	\N	\N	-987624\n
7290	441	90	6481cbf8-457a-4d99-a7ed-66ef8fe1c768	ACCEPTED	4	880	2026-06-19 01:46:36.145656+07	\N	\N	-1520451\n
8961	460	57	7a43dbc0-f8e9-41b1-bbd4-6aeb0e0fd2a5	ACCEPTED	5	1292	2026-06-21 02:01:32.405732+07	\N	\N	787228
6523	422	95	b574a0b7-1a5a-4dc8-976f-8d9afbde85e8	ACCEPTED	5	1104	2026-06-19 00:32:34.57211+07	\N	\N	-1192974\n
6526	422	98	70df3e25-1e92-48db-80ae-56927df5725d	ACCEPTED	6	996	2026-06-19 00:32:34.572111+07	\N	\N	99178\n
6532	422	104	dfc1d420-c8b3-462d-8fbc-27c90e31b029	ACCEPTED	8	988	2026-06-19 00:32:34.572115+07	\N	\N	514364\n
6527	422	99	d72bddf4-320c-4f1c-970e-ead2a45a5782	ACCEPTED	5	1016	2026-06-19 00:32:34.572112+07	\N	\N	-1225775\n
6530	422	102	03a0a1b7-5c7c-4128-a305-1d9f18cafc8e	ACCEPTED	4	820	2026-06-19 00:32:34.572114+07	\N	\N	-619866\n
6529	422	101	024a84f4-062b-45a4-8a38-fd74e087f83b	ACCEPTED	5	1028	2026-06-19 00:32:34.572113+07	\N	\N	28962\n
6531	422	103	06e261ac-9129-47aa-98d2-443a1d33135a	ACCEPTED	5	1016	2026-06-19 00:32:34.572115+07	\N	\N	283996\n
6535	422	107	3436893d-63d3-437b-868e-39c0452345f7	ACCEPTED	4	864	2026-06-19 00:32:34.572117+07	\N	\N	-34648\n
6536	422	108	600734c8-9738-480f-8b01-ede6eb95a522	ACCEPTED	5	868	2026-06-19 00:32:34.572118+07	\N	\N	1436130\n
6534	422	106	1e95f54f-6de1-44a5-b9d5-5080695a3899	ACCEPTED	6	1020	2026-06-19 00:32:34.572117+07	\N	\N	-815576\n
6543	422	115	2474d015-bdf8-4e5d-b6c2-67b8c2a8534f	ACCEPTED	4	1124	2026-06-19 00:32:34.572124+07	\N	\N	506806\n
6539	422	111	2657b08f-3b46-4ff9-846c-48ceda635924	ACCEPTED	6	1036	2026-06-19 00:32:34.572121+07	\N	\N	-309452\n
6540	422	112	5da055ad-e14d-4eac-8149-8e8542f1e3e1	ACCEPTED	5	988	2026-06-19 00:32:34.572122+07	\N	\N	649261\n
6544	422	116	65e9c526-6401-424d-94a1-3e1406c77158	ACCEPTED	5	992	2026-06-19 00:32:34.572124+07	\N	\N	785356\n
6537	422	109	97a5c196-e473-45aa-b824-152edb39a253	ACCEPTED	5	1016	2026-06-19 00:32:34.572119+07	\N	\N	792531\n
6538	422	110	8b862a74-4bbd-4277-914d-d15210782625	ACCEPTED	5	864	2026-06-19 00:32:34.57212+07	\N	\N	-572819\n
6542	422	114	ccdfd1ef-5397-435a-88e9-8766781c2bc7	ACCEPTED	6	864	2026-06-19 00:32:34.572123+07	\N	\N	-234796\n
6545	422	117	17914aba-9554-4039-8e83-130c9fb2799f	ACCEPTED	7	1012	2026-06-19 00:32:34.572125+07	\N	\N	362210245\n
6548	422	120	44d97f0d-f0a9-4d9c-9274-11df5b37227c	ACCEPTED	5	1024	2026-06-19 00:32:34.572127+07	\N	\N	371467497\n
6547	422	119	200a19cb-b05f-4e13-bf8a-5aa099832923	ACCEPTED	6	836	2026-06-19 00:32:34.572126+07	\N	\N	-738231997\n
6546	422	118	e2d3508d-c5f8-4465-878b-d51182387a83	ACCEPTED	5	1024	2026-06-19 00:32:34.572126+07	\N	\N	636465324\n
6552	422	124	49c6aa92-0e2c-4fc5-aa40-da0359c167d2	ACCEPTED	5	1024	2026-06-19 00:32:34.57213+07	\N	\N	1610593689\n
6551	422	123	0b558846-2cfc-4613-a2a4-6e8d7959a512	ACCEPTED	11	1032	2026-06-19 00:32:34.572129+07	\N	\N	1422690276\n
6550	422	122	0975f1ad-d4f0-4cd7-8ec8-1529cedfea54	ACCEPTED	5	904	2026-06-19 00:32:34.572128+07	\N	\N	-457820119\n
6555	422	127	e682141b-ab2a-47e2-80c3-0cf333fb955e	ACCEPTED	8	1020	2026-06-19 00:32:34.572131+07	\N	\N	0\n
6553	422	125	dbe68f93-39f3-4135-a5d6-2aebcdd893bd	ACCEPTED	14	860	2026-06-19 00:32:34.57213+07	\N	\N	86961293\n
6556	422	128	ce3ff955-c195-448b-bfae-5ffc566470f4	ACCEPTED	5	1092	2026-06-19 00:32:34.572132+07	\N	\N	82\n
6557	422	129	d4b93e7b-1d16-4e58-8a66-059eef90b9c3	ACCEPTED	6	1052	2026-06-19 00:32:34.572133+07	\N	\N	-32\n
6559	422	131	f2254a30-1020-4aad-a01a-f17f449fe9e4	ACCEPTED	5	1056	2026-06-19 00:32:34.572134+07	\N	\N	71\n
6558	422	130	fdddf7ec-55bf-40db-8780-92a4e0ca27e0	ACCEPTED	5	1056	2026-06-19 00:32:34.572133+07	\N	\N	-5\n
6563	422	135	cc8b7e74-5b9d-4652-80a6-52ff0a156a72	ACCEPTED	3	1052	2026-06-19 00:32:34.572136+07	\N	\N	3\n
6564	422	136	08d4e26a-f614-4ab4-8286-143925d4f8b9	ACCEPTED	4	1040	2026-06-19 00:32:34.572137+07	\N	\N	129\n
6565	422	137	03be166f-acf3-4fb1-96e6-b068054dd60e	ACCEPTED	3	1056	2026-06-19 00:32:34.572137+07	\N	\N	64\n
6566	422	138	f92a9f23-410f-4ccb-a489-9b36ed05257f	ACCEPTED	3	1056	2026-06-19 00:32:34.572138+07	\N	\N	51\n
5697	381	47	466caa70-6958-4760-be76-999c18305a9b	WRONG_ANSWER	41	3332	2026-06-17 02:21:17.600811+07	\N	\N	Hello World\n
5698	381	48	7909d60e-082d-4a17-a14d-be1bb7be1be4	WRONG_ANSWER	38	3516	2026-06-17 02:21:17.600812+07	\N	\N	Hello World\n
5700	381	50	ee9fe610-5f37-4991-9f9d-baea052b5f93	WRONG_ANSWER	39	3980	2026-06-17 02:21:17.600814+07	\N	\N	Hello World\n
5689	381	39	35b5906a-542f-41c5-9e30-46deb4f8e8b8	WRONG_ANSWER	38	4120	2026-06-17 02:21:17.6008+07	\N	\N	Hello World\n
5692	381	42	9a5d57cb-96a6-48c4-820e-7bedddb892c6	WRONG_ANSWER	34	3488	2026-06-17 02:21:17.600808+07	\N	\N	Hello World\n
5694	381	44	0c869423-9c02-4418-b445-3c7dc8057444	WRONG_ANSWER	32	3392	2026-06-17 02:21:17.600809+07	\N	\N	Hello World\n
5690	381	40	f0fe05b9-6f99-4671-9447-77ff2bb59628	WRONG_ANSWER	41	3576	2026-06-17 02:21:17.600806+07	\N	\N	Hello World\n
5693	381	43	f902a43f-5c0b-4464-893b-3125e18afa6e	WRONG_ANSWER	43	4848	2026-06-17 02:21:17.600808+07	\N	\N	Hello World\n
5705	381	55	b28cbef2-b9df-46b6-820e-329837655bc3	WRONG_ANSWER	28	3296	2026-06-17 02:21:17.600822+07	\N	\N	Hello World\n
5706	381	56	c8ad7508-98ba-4386-b8cb-e44c98a04ecd	WRONG_ANSWER	27	3296	2026-06-17 02:21:17.600823+07	\N	\N	Hello World\n
5696	381	46	98da9be8-fcda-450e-9915-ade57f72b73c	WRONG_ANSWER	33	3124	2026-06-17 02:21:17.600811+07	\N	\N	Hello World\n
5702	381	52	72eb34fc-b3f5-489d-95f6-769e4e32b4b9	WRONG_ANSWER	30	3320	2026-06-17 02:21:17.60082+07	\N	\N	Hello World\n
5704	381	54	7a4c33b1-72f3-472f-9ac0-fe21c94740b8	WRONG_ANSWER	31	3152	2026-06-17 02:21:17.600821+07	\N	\N	Hello World\n
5695	381	45	c7ef9693-250d-4d01-8464-aed193f1cf5e	WRONG_ANSWER	26	3184	2026-06-17 02:21:17.60081+07	\N	\N	Hello World\n
5691	381	41	0a958862-f59d-4fd8-95c5-55b63ffe2f71	WRONG_ANSWER	29	3100	2026-06-17 02:21:17.600807+07	\N	\N	Hello World\n
5701	381	51	ac50e693-68e9-4b82-8c24-ba7c0a575225	WRONG_ANSWER	29	3280	2026-06-17 02:21:17.600819+07	\N	\N	Hello World\n
5703	381	53	5a1421c8-9b78-4bf8-99be-70a0cf1a72e9	WRONG_ANSWER	19	3320	2026-06-17 02:21:17.60082+07	\N	\N	Hello World\n
5699	381	49	cd00eed8-b938-481a-93e6-eaa5bdd5717d	WRONG_ANSWER	20	3224	2026-06-17 02:21:17.600813+07	\N	\N	Hello World\n
5707	382	39	95b3cc40-9523-4310-ab73-c2c07a7d13e9	WRONG_ANSWER	39	3284	2026-06-17 02:21:23.406649+07	\N	\N	Hello World\n
5709	382	41	74b34e64-48e6-4eb3-8a0e-008b33df8ddb	WRONG_ANSWER	34	3260	2026-06-17 02:21:23.406659+07	\N	\N	Hello World\n
5717	382	49	e1762254-eb6d-4ec7-8404-4a6830aadd24	WRONG_ANSWER	32	3340	2026-06-17 02:21:23.406713+07	\N	\N	Hello World\n
5710	382	42	e29c9014-da06-410a-a8e1-c99457ea08e2	WRONG_ANSWER	39	3316	2026-06-17 02:21:23.406661+07	\N	\N	Hello World\n
5714	382	46	e1f4a9f3-509b-4da5-b28d-da105f7103e9	WRONG_ANSWER	37	3328	2026-06-17 02:21:23.406685+07	\N	\N	Hello World\n
5713	382	45	2f0f93be-2d0f-4f5d-acdc-830fbd2f7da1	WRONG_ANSWER	31	3276	2026-06-17 02:21:23.406683+07	\N	\N	Hello World\n
5723	382	55	f2dec998-d231-40a4-a984-05299316a620	WRONG_ANSWER	27	3416	2026-06-17 02:21:23.40673+07	\N	\N	Hello World\n
5711	382	43	f1822422-e5e3-4a43-9687-746483551987	WRONG_ANSWER	53	3220	2026-06-17 02:21:23.406663+07	\N	\N	Hello World\n
5716	382	48	414300b2-6080-41ea-9608-4e1c14d73a20	WRONG_ANSWER	31	3432	2026-06-17 02:21:23.406711+07	\N	\N	Hello World\n
5715	382	47	5f563c45-166a-4968-aa0b-a525deccfaf7	WRONG_ANSWER	30	3300	2026-06-17 02:21:23.406687+07	\N	\N	Hello World\n
5718	382	50	a9a4c612-8697-4498-b31e-3f5f714b39c3	WRONG_ANSWER	26	3188	2026-06-17 02:21:23.406715+07	\N	\N	Hello World\n
5708	382	40	ed9bfe47-1fca-4a08-a21c-089eca352cb5	WRONG_ANSWER	36	3260	2026-06-17 02:21:23.406657+07	\N	\N	Hello World\n
5719	382	51	3fe23d59-1a75-440f-92e4-c0d0f5d45636	WRONG_ANSWER	25	3420	2026-06-17 02:21:23.406717+07	\N	\N	Hello World\n
5721	382	53	b6bc902f-4011-493f-adf2-787bee60fc2b	WRONG_ANSWER	38	3272	2026-06-17 02:21:23.406726+07	\N	\N	Hello World\n
5712	382	44	d016bbe2-b6c3-495d-b29e-ca6fb5582057	WRONG_ANSWER	39	3104	2026-06-17 02:21:23.406664+07	\N	\N	Hello World\n
5724	382	56	57ce140e-58d7-47ba-b0d7-80a8c03a6970	WRONG_ANSWER	31	3308	2026-06-17 02:21:23.406732+07	\N	\N	Hello World\n
5720	382	52	a83475c6-0759-46c1-b523-fcca08f3f883	WRONG_ANSWER	25	3348	2026-06-17 02:21:23.406719+07	\N	\N	Hello World\n
5722	382	54	fc5420fb-8572-4fab-a8be-810f69af4024	WRONG_ANSWER	27	3360	2026-06-17 02:21:23.406728+07	\N	\N	Hello World\n
6074	418	28	912cfe8f-32bf-4888-8c99-e0fb13c89139	PENDING	\N	\N	2026-06-19 00:23:37.592359+07	\N	\N	\N
6079	418	33	731fc186-acf0-48a7-b55f-b27474b10bd2	ACCEPTED	3	876	2026-06-19 00:23:37.592363+07	\N	\N	84\n
6085	418	57	a2139d91-de5a-490b-aeab-3c1862887deb	ACCEPTED	3	884	2026-06-19 00:23:37.592368+07	\N	\N	787228\n
6076	418	30	434d7eb7-815f-4efc-891d-98f06d2edd4c	ACCEPTED	7	896	2026-06-19 00:23:37.592361+07	\N	\N	0\n
6089	418	61	d0028613-384f-47a7-b30a-b92c1f7dc161	ACCEPTED	3	864	2026-06-19 00:23:37.592373+07	\N	\N	879721\n
6080	418	34	f0c71f94-30df-4ba4-8a70-9f3c802d1ea5	ACCEPTED	3	1088	2026-06-19 00:23:37.592364+07	\N	\N	15\n
6081	418	35	72413a13-e64f-4ae7-8a08-95426ff6ac89	ACCEPTED	4	864	2026-06-19 00:23:37.592365+07	\N	\N	-2\n
6086	418	58	45ec6888-bf9b-4ccb-abf8-26d1042d751f	ACCEPTED	5	828	2026-06-19 00:23:37.592369+07	\N	\N	803799\n
6083	418	37	9a23db89-463a-48a5-8228-340f4064f85b	ACCEPTED	3	828	2026-06-19 00:23:37.592367+07	\N	\N	1000\n
6087	418	59	8c210f81-6bf0-46fc-aebc-2c02d68ed5cc	ACCEPTED	5	864	2026-06-19 00:23:37.59237+07	\N	\N	545178\n
6090	418	62	a3f7b87d-3ffe-451d-b2d6-4fb08ebe60c1	ACCEPTED	5	1084	2026-06-19 00:23:37.592374+07	\N	\N	1486218\n
6077	418	31	d522d81d-01a0-437a-b843-f341bb795a15	ACCEPTED	5	1088	2026-06-19 00:23:37.592362+07	\N	\N	30000\n
6078	418	32	5411cf64-3899-4357-bb66-01da89d8aabf	ACCEPTED	6	868	2026-06-19 00:23:37.592363+07	\N	\N	0\n
6088	418	60	39bd165f-67d3-4e41-8eb8-f8ee3f878252	ACCEPTED	3	832	2026-06-19 00:23:37.592372+07	\N	\N	380371\n
6091	418	63	dfc01c7e-4bf2-49e7-91dd-828b3699cb32	ACCEPTED	3	880	2026-06-19 00:23:37.592375+07	\N	\N	1507378\n
6093	418	65	64d25b12-05e7-4a2e-a304-78b80f4ff667	ACCEPTED	3	832	2026-06-19 00:23:37.592376+07	\N	\N	475745\n
6096	418	68	f1165d0f-0bc4-47b0-976a-cad24bfc2cf0	ACCEPTED	4	1084	2026-06-19 00:23:37.592379+07	\N	\N	1161167\n
6095	418	67	9bab4121-4410-4c12-a375-e4a659b91749	ACCEPTED	4	816	2026-06-19 00:23:37.592378+07	\N	\N	473222\n
6092	418	64	bc57cb24-9437-479b-b768-e2707734e1b2	ACCEPTED	4	876	2026-06-19 00:23:37.592376+07	\N	\N	710339\n
6097	418	69	069b9f55-3ef7-4155-a960-9fd0677f63eb	ACCEPTED	4	836	2026-06-19 00:23:37.592379+07	\N	\N	616334\n
6075	418	29	bf299f35-51fb-48fe-9d44-17aa284dcdc7	ACCEPTED	3	836	2026-06-19 00:23:37.59236+07	\N	\N	99\n
6084	418	38	5d196bf2-c9bd-4066-8f4c-9034a3f8ec1a	ACCEPTED	4	844	2026-06-19 00:23:37.592367+07	\N	\N	3000000\n
6102	418	74	03140d42-0b9c-4d21-8082-4692ddff7e47	ACCEPTED	6	768	2026-06-19 00:23:37.592393+07	\N	\N	909595\n
6104	418	76	cfd20a03-8dae-41e2-b21c-6f542c380361	ACCEPTED	3	888	2026-06-19 00:23:37.592395+07	\N	\N	802483\n
6103	418	75	be34bfb5-bba6-445c-898c-b086f53db6e2	ACCEPTED	4	848	2026-06-19 00:23:37.592394+07	\N	\N	1760278\n
6105	418	77	2e710f9a-c3b2-4f13-bfac-659b71d313dd	ACCEPTED	3	840	2026-06-19 00:23:37.592396+07	\N	\N	-987624\n
6112	418	84	92bc139d-3448-4653-878c-4d617bbffb64	ACCEPTED	3	824	2026-06-19 00:23:37.592402+07	\N	\N	-734921\n
6111	418	83	38fbd0b5-d58b-4f8d-80b2-711e1757873c	ACCEPTED	4	828	2026-06-19 00:23:37.592402+07	\N	\N	-1500204\n
6106	418	78	41650c9f-d6d3-415d-9081-5c414cc88890	ACCEPTED	3	836	2026-06-19 00:23:37.592397+07	\N	\N	-824805\n
6108	418	80	f717863b-c044-4098-bc33-a5b47a4b1ab7	ACCEPTED	6	796	2026-06-19 00:23:37.592399+07	\N	\N	-1611196\n
6110	418	82	e121f5ab-ab8c-4d32-a947-5d9db4503a3b	ACCEPTED	4	884	2026-06-19 00:23:37.592401+07	\N	\N	-1795574\n
6107	418	79	8055e9c9-b66e-4e3c-a1f3-22e21fd94476	ACCEPTED	4	864	2026-06-19 00:23:37.592398+07	\N	\N	-1351853\n
6114	418	86	66c9bdc9-0627-4121-ad96-90d4bc777a37	ACCEPTED	3	1088	2026-06-19 00:23:37.592404+07	\N	\N	-876295\n
6113	418	85	f7a9ddc8-7e8f-4a02-b3c3-e40c894326fc	ACCEPTED	3	828	2026-06-19 00:23:37.592403+07	\N	\N	-1006285\n
6117	418	89	a46dac08-c952-45f6-8832-48789f7eab99	ACCEPTED	3	868	2026-06-19 00:23:37.592407+07	\N	\N	-902015\n
6115	418	87	07ee473c-7b11-4f14-aeda-9b346c5502f7	ACCEPTED	5	1080	2026-06-19 00:23:37.592405+07	\N	\N	-1189260\n
6120	418	92	9c96721f-1624-487d-9171-484d614eab56	ACCEPTED	5	832	2026-06-19 00:23:37.59241+07	\N	\N	-471131\n
6116	418	88	03e66272-90d6-4e99-9ed4-cf0148cb13b7	ACCEPTED	7	840	2026-06-19 00:23:37.592406+07	\N	\N	-955984\n
6122	418	94	4ae6a49b-2204-4a8e-b80c-73b22deef69e	ACCEPTED	3	836	2026-06-19 00:23:37.592411+07	\N	\N	-717234\n
6127	418	99	e0ccb3cb-6ac4-426c-a97f-58dd8456c5d6	ACCEPTED	4	836	2026-06-19 00:23:37.592415+07	\N	\N	-1225775\n
6124	418	96	c49a9d56-af2a-430c-99e8-e9a6def71572	ACCEPTED	4	912	2026-06-19 00:23:37.592413+07	\N	\N	-1188270\n
6126	418	98	5bc2d4fb-5f0f-498c-bb1a-94fb25e4397e	ACCEPTED	3	860	2026-06-19 00:23:37.592414+07	\N	\N	99178\n
6121	418	93	64f7a0e9-b503-4a2f-8a2e-4750a32d7eaf	ACCEPTED	3	876	2026-06-19 00:23:37.59241+07	\N	\N	-422973\n
6129	418	101	ae5e398c-2c14-49e9-b586-b780c22e862e	ACCEPTED	5	1080	2026-06-19 00:23:37.592417+07	\N	\N	28962\n
6123	418	95	5bd3ac4b-e88f-45c4-93f2-6f628489ecf0	ACCEPTED	3	1092	2026-06-19 00:23:37.592412+07	\N	\N	-1192974\n
6130	418	102	f1dc7182-9cb9-4569-a472-652499f3d7c7	ACCEPTED	3	836	2026-06-19 00:23:37.592417+07	\N	\N	-619866\n
6135	418	107	60c697ea-8811-4e85-acd9-2db6d3934f82	ACCEPTED	3	1092	2026-06-19 00:23:37.592422+07	\N	\N	-34648\n
6128	418	100	ea9895d8-32a1-4d10-8c57-0399f7ec5ca7	ACCEPTED	4	836	2026-06-19 00:23:37.592416+07	\N	\N	281928\n
6132	418	104	b333eab4-529b-474a-adec-9b4e012dad4a	ACCEPTED	3	864	2026-06-19 00:23:37.592419+07	\N	\N	514364\n
6134	418	106	3e504827-a6b8-4748-9ca1-1dcffe07ac4e	ACCEPTED	5	860	2026-06-19 00:23:37.592421+07	\N	\N	-815576\n
6136	418	108	4853696c-25ba-4906-a700-d2c76ceef816	ACCEPTED	4	880	2026-06-19 00:23:37.592423+07	\N	\N	1436130\n
6133	418	105	b2f8ccd3-1fdd-48d5-abde-c0da85427cfd	ACCEPTED	5	832	2026-06-19 00:23:37.59242+07	\N	\N	-882565\n
6138	418	110	e2cf6ab2-a443-4989-9933-b66793fe80b2	ACCEPTED	3	836	2026-06-19 00:23:37.592425+07	\N	\N	-572819\n
6140	418	112	7f3824e7-4fa8-4794-8f42-2d8f7ac19650	ACCEPTED	3	1088	2026-06-19 00:23:37.592427+07	\N	\N	649261\n
6142	418	114	047b05e7-ba21-4ea7-9e04-1f495ee36f31	ACCEPTED	3	1084	2026-06-19 00:23:37.592429+07	\N	\N	-234796\n
6139	418	111	33533b94-d5e4-48a2-9d91-55b5ead0c53d	ACCEPTED	5	1040	2026-06-19 00:23:37.592426+07	\N	\N	-309452\n
6144	418	116	2da24fc8-cbd2-4cd3-b7dd-87300ce9e826	ACCEPTED	7	880	2026-06-19 00:23:37.592431+07	\N	\N	785356\n
6148	418	120	e91f7444-606b-4a60-b344-19d586b0005d	ACCEPTED	3	860	2026-06-19 00:23:37.592435+07	\N	\N	371467497\n
6145	418	117	0d61a3d2-6e4b-4c5a-8f22-e456a57c3027	ACCEPTED	3	864	2026-06-19 00:23:37.592432+07	\N	\N	362210245\n
6141	418	113	289d4a86-ec07-44fc-9117-efaaa0836a3a	ACCEPTED	4	888	2026-06-19 00:23:37.592428+07	\N	\N	-1143916\n
6149	418	121	f53cfd3e-a17b-437c-a10f-cb762f15619e	ACCEPTED	3	892	2026-06-19 00:23:37.592436+07	\N	\N	1259817393\n
6151	418	123	eaa28168-4637-42c5-80af-91695941cc09	ACCEPTED	4	860	2026-06-19 00:23:37.592437+07	\N	\N	1422690276\n
6147	418	119	827a0bba-1107-4189-8173-7ca675b586c8	ACCEPTED	4	836	2026-06-19 00:23:37.592434+07	\N	\N	-738231997\n
6153	418	125	2495ddd9-b568-46c2-aa94-c6794c72ddae	ACCEPTED	9	896	2026-06-19 00:23:37.592439+07	\N	\N	86961293\n
6155	418	127	26669a12-eab3-4959-b2c8-f72e7a3439f8	ACCEPTED	3	788	2026-06-19 00:23:37.59244+07	\N	\N	0\n
6152	418	124	5fe44503-094b-41cb-83fc-3bd72fa43b41	ACCEPTED	4	876	2026-06-19 00:23:37.592438+07	\N	\N	1610593689\n
6157	418	129	4350afbc-4709-4394-a46a-26525fa425e0	ACCEPTED	3	876	2026-06-19 00:23:37.592442+07	\N	\N	-32\n
6158	418	130	68688478-eb4f-482e-ac6b-21136d87bf4f	ACCEPTED	4	876	2026-06-19 00:23:37.592443+07	\N	\N	-5\n
6160	418	132	1449bac6-1d60-457a-98e0-2ed1e6dbaaa1	ACCEPTED	5	840	2026-06-19 00:23:37.592445+07	\N	\N	-1\n
6159	418	131	6ae89b82-91f0-4db3-b4ef-5ba9558bbe55	ACCEPTED	3	880	2026-06-19 00:23:37.592444+07	\N	\N	71\n
6156	418	128	df04f3e8-802d-488c-b927-b11bb7448202	ACCEPTED	4	812	2026-06-19 00:23:37.592441+07	\N	\N	82\n
6162	418	134	adb42bdd-8b02-4252-9d25-cc59dc2f8ae3	ACCEPTED	3	876	2026-06-19 00:23:37.592446+07	\N	\N	158\n
6161	418	133	cfd952d7-632c-45ac-b541-be255a52f031	ACCEPTED	3	876	2026-06-19 00:23:37.592445+07	\N	\N	-57\n
6163	418	135	1c3fc673-1eaf-4a4b-8964-a7c48d5b441a	ACCEPTED	3	864	2026-06-19 00:23:37.592447+07	\N	\N	3\n
6164	418	136	feef41bd-8585-409c-bb47-9c0bbcc2eae0	ACCEPTED	3	872	2026-06-19 00:23:37.592448+07	\N	\N	129\n
6166	418	138	e0bcf6df-f512-4462-b30b-d4950dcc9985	ACCEPTED	2	872	2026-06-19 00:23:37.59245+07	\N	\N	51\n
6082	418	36	ed96abc5-2ee1-4312-9d16-5aa61d4380d4	ACCEPTED	4	904	2026-06-19 00:23:37.592366+07	\N	\N	801\n
6094	418	66	88aacf66-898e-4164-ba34-9b7bd5b9d0a8	ACCEPTED	4	832	2026-06-19 00:23:37.592377+07	\N	\N	129492\n
6099	418	71	aa9bebf7-9c56-4782-bba6-b577be70d86f	ACCEPTED	3	864	2026-06-19 00:23:37.592381+07	\N	\N	1416847\n
6101	418	73	51939ace-63b5-44be-97e4-a7443e6d5b61	ACCEPTED	4	876	2026-06-19 00:23:37.592383+07	\N	\N	702179\n
6098	418	70	374b42a7-1f69-4d9a-85d6-acbdc9291e22	ACCEPTED	3	1084	2026-06-19 00:23:37.59238+07	\N	\N	959298\n
6109	418	81	404fcb09-c314-49df-8680-c1014be6f215	ACCEPTED	3	1084	2026-06-19 00:23:37.5924+07	\N	\N	-846475\n
6100	418	72	29801e93-eee6-4dca-95df-c9e68e93c586	ACCEPTED	3	820	2026-06-19 00:23:37.592382+07	\N	\N	1011312\n
6119	418	91	e87d2cf6-a0fc-4b77-83b0-df5d032b5582	ACCEPTED	3	840	2026-06-19 00:23:37.592409+07	\N	\N	-1113725\n
6125	418	97	e5137fd1-d5fc-45a1-9d8c-65c92a9860fc	ACCEPTED	4	828	2026-06-19 00:23:37.592413+07	\N	\N	-517131\n
6137	418	109	e5cae1a3-005f-47df-8e94-decd52203a8b	ACCEPTED	5	844	2026-06-19 00:23:37.592424+07	\N	\N	792531\n
6143	418	115	7ff51178-7fca-435e-b189-e877b6cd5f2c	ACCEPTED	3	844	2026-06-19 00:23:37.59243+07	\N	\N	506806\n
6150	418	122	55665828-cadd-4999-a1b1-b059d2ee26b3	ACCEPTED	5	876	2026-06-19 00:23:37.592436+07	\N	\N	-457820119\n
6154	418	126	3f487e96-3f05-4c19-b104-ca167f7e07e3	ACCEPTED	3	1112	2026-06-19 00:23:37.592439+07	\N	\N	-882105735\n
6356	420	128	495c65d4-cd0e-46c9-86ec-187998b8d91c	ACCEPTED	5	1036	2026-06-19 00:26:04.575246+07	\N	\N	82\n
6473	422	27	27b748c6-7d02-4597-a99d-83dc3fe6e406	ACCEPTED	6	1024	2026-06-19 00:32:34.572076+07	\N	\N	1000\n
6490	422	62	18b7a530-9bb9-4711-9fc4-d3cdbe69fb44	ACCEPTED	6	1088	2026-06-19 00:32:34.572088+07	\N	\N	1486218\n
6471	422	25	96d575f6-a0de-47a3-b8c4-65817a6a857f	ACCEPTED	5	984	2026-06-19 00:32:34.572075+07	\N	\N	300\n
6472	422	26	f3ebb940-5441-4f2d-a46e-102f6523d40a	ACCEPTED	5	1084	2026-06-19 00:32:34.572076+07	\N	\N	-30\n
6470	422	24	c354c6b0-3659-4960-ac0d-8ffe6876e85c	ACCEPTED	6	864	2026-06-19 00:32:34.572075+07	\N	\N	0\n
6475	422	29	297d1a91-10cd-442c-a5f1-f0d07afe1295	ACCEPTED	5	1096	2026-06-19 00:32:34.572078+07	\N	\N	99\n
6483	422	37	5d582a5b-3247-49b1-b1c4-abfc508b704c	ACCEPTED	7	984	2026-06-19 00:32:34.572083+07	\N	\N	1000\n
6476	422	30	117212a2-0234-43eb-8958-e5dc35752110	ACCEPTED	6	1016	2026-06-19 00:32:34.572078+07	\N	\N	0\n
6482	422	36	1a16ef49-9595-44da-861e-f9948cabd492	ACCEPTED	6	860	2026-06-19 00:32:34.572082+07	\N	\N	801\n
6469	422	23	b6cbe48a-bc35-414d-a8cc-08f47b16124b	ACCEPTED	7	1088	2026-06-19 00:32:34.572074+07	\N	\N	0\n
6474	422	28	f13ebdcc-148d-4a2f-af51-9415f1be5090	ACCEPTED	5	1028	2026-06-19 00:32:34.572077+07	\N	\N	579\n
6487	422	59	55cab868-0868-4341-adfd-1bb9e1ae4e9b	ACCEPTED	6	1016	2026-06-19 00:32:34.572086+07	\N	\N	545178\n
6484	422	38	60280f98-84c4-4c80-bc8f-d074f9d8b6b3	ACCEPTED	5	1020	2026-06-19 00:32:34.572083+07	\N	\N	3000000\n
6481	422	35	3a1a74a2-ba18-4245-808a-ec4548072d00	ACCEPTED	13	984	2026-06-19 00:32:34.572081+07	\N	\N	-2\n
6477	422	31	deb769e3-d365-4437-9fe8-f85dd56aaf82	ACCEPTED	9	1072	2026-06-19 00:32:34.572079+07	\N	\N	30000\n
6480	422	34	3d749681-a8d1-4f98-b03a-02063398d43d	ACCEPTED	6	1024	2026-06-19 00:32:34.572081+07	\N	\N	15\n
6488	422	60	4c08e9b4-99d5-45f6-9733-3506c95a5554	ACCEPTED	5	1024	2026-06-19 00:32:34.572086+07	\N	\N	380371\n
6485	422	57	faf96327-b8b1-4bbc-9502-4be190904422	ACCEPTED	5	1028	2026-06-19 00:32:34.572084+07	\N	\N	787228\n
6486	422	58	6418c98f-b6b7-4797-b6f0-3971c82936f4	ACCEPTED	6	1020	2026-06-19 00:32:34.572085+07	\N	\N	803799\n
6492	422	64	b5ffaabb-b8b0-4d9f-9367-4dc46049c18f	ACCEPTED	5	1088	2026-06-19 00:32:34.572089+07	\N	\N	710339\n
6493	422	65	00a77d78-273d-4628-a0d6-e02cf5ed8293	ACCEPTED	10	836	2026-06-19 00:32:34.572089+07	\N	\N	475745\n
6495	422	67	bba12cb4-4ca8-4126-bad1-0f55e10aff3e	ACCEPTED	5	1032	2026-06-19 00:32:34.572091+07	\N	\N	473222\n
6491	422	63	22607f57-8535-4798-b574-eb16f4b51611	ACCEPTED	5	868	2026-06-19 00:32:34.572088+07	\N	\N	1507378\n
6499	422	71	3e7953c8-b656-48a9-9046-e24338c76e92	ACCEPTED	5	1084	2026-06-19 00:32:34.572094+07	\N	\N	1416847\n
6504	422	76	d8cfd7d3-4721-4b33-b7c2-55594a21fb3c	ACCEPTED	5	1028	2026-06-19 00:32:34.572097+07	\N	\N	802483\n
6494	422	66	d4a2ec5a-c3bf-456c-80c7-73f1f50d6df8	ACCEPTED	5	1036	2026-06-19 00:32:34.57209+07	\N	\N	129492\n
6505	422	77	714d3596-de06-4078-ab64-902640afc792	ACCEPTED	5	1020	2026-06-19 00:32:34.572098+07	\N	\N	-987624\n
6501	422	73	cad8ee3e-bfc7-4482-8c51-13db658163e5	ACCEPTED	5	1024	2026-06-19 00:32:34.572095+07	\N	\N	702179\n
6509	422	81	3f2ed8c5-71f9-4cdf-b99f-c127c6584460	ACCEPTED	6	880	2026-06-19 00:32:34.5721+07	\N	\N	-846475\n
6506	422	78	fc0c1b3c-4759-41bf-b148-34cfe1a3c124	ACCEPTED	5	868	2026-06-19 00:32:34.572098+07	\N	\N	-824805\n
6507	422	79	db133ae8-31f0-41c7-8ac7-ac1622db9857	ACCEPTED	5	1020	2026-06-19 00:32:34.572099+07	\N	\N	-1351853\n
6496	422	68	966032ac-0794-40a6-b44a-3619ad8e96cf	ACCEPTED	6	1020	2026-06-19 00:32:34.572091+07	\N	\N	1161167\n
6513	422	85	01eee651-239a-463e-ba4a-29f89289fe07	ACCEPTED	5	1016	2026-06-19 00:32:34.572103+07	\N	\N	-1006285\n
6498	422	70	89e9d41d-1880-46a1-8706-cf2f00fbf42f	ACCEPTED	5	1024	2026-06-19 00:32:34.572093+07	\N	\N	959298\n
6511	422	83	0c957b95-224e-46b5-bcff-47c6afe74265	ACCEPTED	9	800	2026-06-19 00:32:34.572102+07	\N	\N	-1500204\n
6512	422	84	3e14c001-72f4-43d7-945a-aabd956fe657	ACCEPTED	7	1092	2026-06-19 00:32:34.572102+07	\N	\N	-734921\n
6514	422	86	d4c59e7f-c510-4e0c-9412-619333f876fc	ACCEPTED	8	1016	2026-06-19 00:32:34.572104+07	\N	\N	-876295\n
6500	422	72	43035436-316f-467a-a5d6-56c1ccd0d5b4	ACCEPTED	5	804	2026-06-19 00:32:34.572095+07	\N	\N	1011312\n
6516	422	88	d9369c5d-5a21-4997-a7c2-58eeedfe2923	ACCEPTED	5	900	2026-06-19 00:32:34.572105+07	\N	\N	-955984\n
6519	422	91	2af10903-f5cf-48ce-9423-f6e4b8a7a820	ACCEPTED	11	1092	2026-06-19 00:32:34.572107+07	\N	\N	-1113725\n
6517	422	89	775f825a-7f78-484c-9af3-6488f4da1de2	ACCEPTED	5	1028	2026-06-19 00:32:34.572106+07	\N	\N	-902015\n
6520	422	92	8c0bd224-1c42-435e-be4a-8cfa16843a45	ACCEPTED	5	860	2026-06-19 00:32:34.572108+07	\N	\N	-471131\n
6515	422	87	3e69e26d-a359-4572-87e3-b06f58f5097a	ACCEPTED	6	1024	2026-06-19 00:32:34.572104+07	\N	\N	-1189260\n
5386	349	10	97f9257a-43fe-400b-b265-333359b84b91	WRONG_ANSWER	2	1056	2026-06-16 19:52:10.51074+07	\N	\N	1\n
5387	350	9	1dc35c93-864a-4526-9423-8e6747587058	WRONG_ANSWER	2	1068	2026-06-16 19:52:11.225993+07	\N	\N	1\n
5388	350	10	27b0ad73-8ba8-44fd-ba2b-eb315aa3437e	WRONG_ANSWER	2	1060	2026-06-16 19:52:11.225998+07	\N	\N	1\n
5390	351	10	c24b5dfa-6810-48e0-816e-d4892029c0d0	WRONG_ANSWER	2	1064	2026-06-16 19:52:11.867237+07	\N	\N	1\n
5389	351	9	15f47016-e642-4c26-9530-08bfd2fac99a	WRONG_ANSWER	2	1056	2026-06-16 19:52:11.867232+07	\N	\N	1\n
5391	352	9	6eb0e1b1-9a08-4ab9-8499-43f045595f75	WRONG_ANSWER	3	1080	2026-06-16 19:52:12.481748+07	\N	\N	1\n
5392	352	10	9cbcc9b6-ad93-410f-baf3-206b4adc11a2	WRONG_ANSWER	3	1028	2026-06-16 19:52:12.481757+07	\N	\N	1\n
5393	353	9	a0b115c0-b038-4f13-841a-71f8814a1751	WRONG_ANSWER	2	1056	2026-06-16 19:52:13.028633+07	\N	\N	1\n
5394	353	10	cd1f3720-a6cd-4e15-8610-522e4228e37c	WRONG_ANSWER	2	1064	2026-06-16 19:52:13.028638+07	\N	\N	1\n
6167	419	21	1bea575e-d812-4395-a7e9-65f40deb8ecc	PENDING	\N	\N	2026-06-19 00:25:03.395393+07	\N	\N	\N
6169	419	23	045dde3d-1484-47cb-83af-592e2cb49da9	PENDING	\N	\N	2026-06-19 00:25:03.395401+07	\N	\N	\N
6179	419	33	b3b37c61-7ea8-48bb-a42b-2e8c4099dff3	PENDING	\N	\N	2026-06-19 00:25:03.395412+07	\N	\N	\N
6168	419	22	107bd542-e143-4981-bf88-bdcf618410f8	ACCEPTED	8	888	2026-06-19 00:25:03.395399+07	\N	\N	30\n
6173	419	27	a9c73a62-d49c-4240-bae9-4eecf2c6d2c0	ACCEPTED	3	832	2026-06-19 00:25:03.395405+07	\N	\N	1000\n
6175	419	29	590d06ce-89e9-4915-ad82-8c8ce8d53813	ACCEPTED	6	816	2026-06-19 00:25:03.395408+07	\N	\N	99\n
6176	419	30	020a63ef-9218-433c-8254-dbd9192e2751	ACCEPTED	5	1048	2026-06-19 00:25:03.395409+07	\N	\N	0\n
6172	419	26	f1adade3-d6a1-4fda-b66e-c88ec558de85	ACCEPTED	8	884	2026-06-19 00:25:03.395404+07	\N	\N	-30\n
6180	419	34	97f42b1b-21fd-4ef2-b379-6ed1684d6f6c	ACCEPTED	3	760	2026-06-19 00:25:03.395413+07	\N	\N	15\n
6190	419	62	71d9b044-c0f8-40a3-99d1-cfb63baae6a2	ACCEPTED	4	1076	2026-06-19 00:25:03.395426+07	\N	\N	1486218\n
6188	419	60	0fb10199-d59a-4eed-93a1-ea892fe3dd1a	ACCEPTED	4	836	2026-06-19 00:25:03.395423+07	\N	\N	380371\n
6186	419	58	8d28b3dc-5029-4fa2-8924-771b672039fa	ACCEPTED	3	824	2026-06-19 00:25:03.395421+07	\N	\N	803799\n
6174	419	28	a54b9c63-5307-4c39-b336-22e91c649ec0	ACCEPTED	3	852	2026-06-19 00:25:03.395407+07	\N	\N	579\n
6171	419	25	2d097909-fe5a-45a3-8911-0a9e1c221fa8	ACCEPTED	6	876	2026-06-19 00:25:03.395403+07	\N	\N	300\n
6183	419	37	43975409-73a4-472b-b406-9c5850accbff	ACCEPTED	4	844	2026-06-19 00:25:03.395417+07	\N	\N	1000\n
6189	419	61	5fff96c5-1ce7-4e1a-83bd-113a5cd371a1	ACCEPTED	5	784	2026-06-19 00:25:03.395424+07	\N	\N	879721\n
6181	419	35	f9258f8d-a599-4ea3-bf80-f97850288cef	ACCEPTED	4	1004	2026-06-19 00:25:03.395415+07	\N	\N	-2\n
6177	419	31	9317d74a-add2-4597-b74c-b3325415dd4c	ACCEPTED	3	1084	2026-06-19 00:25:03.39541+07	\N	\N	30000\n
6187	419	59	692c77d2-a538-4c13-ad9d-4bad7091f419	ACCEPTED	5	836	2026-06-19 00:25:03.395422+07	\N	\N	545178\n
6182	419	36	f94e3864-f22d-47d9-bdfb-292c459d2b11	ACCEPTED	4	852	2026-06-19 00:25:03.395416+07	\N	\N	801\n
6193	419	65	78938259-d274-4270-b166-af51195cb1a1	ACCEPTED	4	832	2026-06-19 00:25:03.395429+07	\N	\N	475745\n
6194	419	66	ca20c4d6-7490-4ff1-9260-53c9f351e4f6	ACCEPTED	4	1080	2026-06-19 00:25:03.39543+07	\N	\N	129492\n
6192	419	64	6f11e37e-4459-4fca-95e0-24c6cfb4d103	ACCEPTED	4	1080	2026-06-19 00:25:03.395428+07	\N	\N	710339\n
6198	419	70	659bab53-0192-4355-b2f2-609c35fff55d	ACCEPTED	8	836	2026-06-19 00:25:03.395435+07	\N	\N	959298\n
6195	419	67	63b329eb-6642-4ed8-989d-8798ed0ac742	ACCEPTED	6	860	2026-06-19 00:25:03.395431+07	\N	\N	473222\n
6201	419	73	c9e3dc19-8f43-4dfe-80ea-aa7f19803c63	ACCEPTED	5	872	2026-06-19 00:25:03.395438+07	\N	\N	702179\n
6207	419	79	0a061e2a-03c9-4b4c-a41b-97d6f77cb41b	ACCEPTED	5	836	2026-06-19 00:25:03.395445+07	\N	\N	-1351853\n
6200	419	72	a6235c27-45d4-46e4-90b2-c0efd6490160	ACCEPTED	8	1068	2026-06-19 00:25:03.395437+07	\N	\N	1011312\n
6197	419	69	824c4983-3daf-4963-93d1-e7e78cea4a63	ACCEPTED	4	836	2026-06-19 00:25:03.395433+07	\N	\N	616334\n
6196	419	68	68b83550-ef26-456f-a526-155e2fff9223	ACCEPTED	6	872	2026-06-19 00:25:03.395432+07	\N	\N	1161167\n
6204	419	76	f7fd613b-ed0f-411a-82a2-e03454c5836f	ACCEPTED	4	864	2026-06-19 00:25:03.395442+07	\N	\N	802483\n
6202	419	74	148c1b16-4a79-4437-9c82-d6ffb22cff98	ACCEPTED	6	836	2026-06-19 00:25:03.39544+07	\N	\N	909595\n
6205	419	77	93a97270-a024-4f7c-abfb-8e79d6baaf6d	ACCEPTED	5	788	2026-06-19 00:25:03.395443+07	\N	\N	-987624\n
6206	419	78	99f9340e-e7ed-4da8-a15e-88a06791e7a6	ACCEPTED	6	872	2026-06-19 00:25:03.395444+07	\N	\N	-824805\n
6211	419	83	500fba94-b9c9-45a8-abd3-740cf7681e69	ACCEPTED	3	836	2026-06-19 00:25:03.39545+07	\N	\N	-1500204\n
6210	419	82	4e47fad4-83ad-48dc-af20-ed710b56d2ad	ACCEPTED	11	796	2026-06-19 00:25:03.395449+07	\N	\N	-1795574\n
6203	419	75	a2d1fae1-6e19-432e-8c5c-e8d0497f56e9	ACCEPTED	3	832	2026-06-19 00:25:03.395441+07	\N	\N	1760278\n
6214	419	86	1d3fde77-c91a-4dee-a9a7-05ee401807f9	ACCEPTED	4	896	2026-06-19 00:25:03.395453+07	\N	\N	-876295\n
6212	419	84	0df95fdd-e599-4e14-8369-5f4a3e921ee9	ACCEPTED	4	844	2026-06-19 00:25:03.395451+07	\N	\N	-734921\n
6213	419	85	19cca7cf-8722-4e1b-81d6-ed837da9438b	ACCEPTED	6	880	2026-06-19 00:25:03.395452+07	\N	\N	-1006285\n
6215	419	87	765be539-b95b-47df-b8b2-3b43791752db	ACCEPTED	4	836	2026-06-19 00:25:03.395454+07	\N	\N	-1189260\n
6223	419	95	81ec62db-1b98-46d7-9e28-f6d6778f6143	ACCEPTED	4	900	2026-06-19 00:25:03.395466+07	\N	\N	-1192974\n
6224	419	96	904ba66b-8bd4-465f-8fec-0d136b3723ac	ACCEPTED	3	816	2026-06-19 00:25:03.395467+07	\N	\N	-1188270\n
6217	419	89	9cadb6ac-824e-48b5-937a-0afb448d7017	ACCEPTED	4	872	2026-06-19 00:25:03.395459+07	\N	\N	-902015\n
6218	419	90	93b141ae-38f3-4191-a70a-a7018627a646	ACCEPTED	3	840	2026-06-19 00:25:03.39546+07	\N	\N	-1520451\n
6219	419	91	3c9a8b9f-2c62-4874-ad25-23a338755b28	ACCEPTED	7	828	2026-06-19 00:25:03.395462+07	\N	\N	-1113725\n
6225	419	97	862f4262-611e-49fe-8694-c73de8ea75a1	ACCEPTED	5	840	2026-06-19 00:25:03.395468+07	\N	\N	-517131\n
6220	419	92	48e42c9e-8fab-40e9-93ae-6c1f9e8b32aa	ACCEPTED	4	832	2026-06-19 00:25:03.395463+07	\N	\N	-471131\n
6221	419	93	38b919cd-e15d-4710-9c2d-adf2bcafbe3b	ACCEPTED	4	828	2026-06-19 00:25:03.395464+07	\N	\N	-422973\n
6467	422	21	707c1c0e-db41-4b24-a8eb-e4cd5bdf7169	ACCEPTED	5	1016	2026-06-19 00:32:34.572071+07	\N	\N	3\n
6468	422	22	8c3ca629-3cae-49d8-b487-bcb403798455	ACCEPTED	6	872	2026-06-19 00:32:34.572073+07	\N	\N	30\n
6479	422	33	ef3579cf-5e2c-4bd5-b020-6246ef3a303a	ACCEPTED	7	872	2026-06-19 00:32:34.57208+07	\N	\N	84\n
6478	422	32	4e0fd8aa-7766-4a82-b743-4a6715db1477	ACCEPTED	7	1024	2026-06-19 00:32:34.57208+07	\N	\N	0\n
6489	422	61	46126c09-430a-4971-8ea6-32dcb3d201d7	ACCEPTED	6	1016	2026-06-19 00:32:34.572087+07	\N	\N	879721\n
6502	422	74	d5bb87a9-7da4-4d2e-8c7b-c708502423a9	ACCEPTED	5	1032	2026-06-19 00:32:34.572096+07	\N	\N	909595\n
6497	422	69	1c64fe93-f260-469a-b442-963b7d118214	ACCEPTED	5	796	2026-06-19 00:32:34.572092+07	\N	\N	616334\n
6503	422	75	78d986be-e148-4a2f-8d02-fe1493ec273c	ACCEPTED	14	1008	2026-06-19 00:32:34.572097+07	\N	\N	1760278\n
6510	422	82	55f984b5-0187-4ecb-9f10-917ef1391695	ACCEPTED	4	876	2026-06-19 00:32:34.572101+07	\N	\N	-1795574\n
6508	422	80	cf12bcae-5ee9-44b9-b2b1-cf019d1948b5	ACCEPTED	7	1088	2026-06-19 00:32:34.5721+07	\N	\N	-1611196\n
6518	422	90	e4cdbec3-5d15-4e58-ad5a-7a5b2e887207	ACCEPTED	7	1008	2026-06-19 00:32:34.572107+07	\N	\N	-1520451\n
6525	422	97	db5bb1b6-11cf-42c2-b550-6a1f40eb9d45	ACCEPTED	8	992	2026-06-19 00:32:34.572111+07	\N	\N	-517131\n
6521	422	93	0e4b9bc1-5ecd-4f7c-841a-0e4fe72cf8b6	ACCEPTED	5	920	2026-06-19 00:32:34.572109+07	\N	\N	-422973\n
6524	422	96	c7f1d092-a08b-4d18-b5e6-701ac8943d81	ACCEPTED	7	1024	2026-06-19 00:32:34.57211+07	\N	\N	-1188270\n
6533	422	105	d27d5e08-06c0-4b23-9ceb-aa2795671784	ACCEPTED	5	1076	2026-06-19 00:32:34.572116+07	\N	\N	-882565\n
6528	422	100	2218efbf-5305-4122-a8e8-bf1c3f09c2a9	ACCEPTED	4	1020	2026-06-19 00:32:34.572112+07	\N	\N	281928\n
6541	422	113	9517a6ad-f5d1-4d76-8487-f7f50aa76dc2	ACCEPTED	6	1028	2026-06-19 00:32:34.572122+07	\N	\N	-1143916\n
6549	422	121	7d44ea17-01aa-41d1-9b86-7f4694f3e300	ACCEPTED	5	960	2026-06-19 00:32:34.572128+07	\N	\N	1259817393\n
6554	422	126	2841ee40-241d-47c6-b68a-c13ceeaa6a05	ACCEPTED	8	1088	2026-06-19 00:32:34.572131+07	\N	\N	-882105735\n
6560	422	132	9bc4c469-81c2-4e35-823a-e9f49ee261a6	ACCEPTED	3	1036	2026-06-19 00:32:34.572134+07	\N	\N	-1\n
6561	422	133	40a9b250-0f18-40c4-88c9-44cd73869720	ACCEPTED	4	1200	2026-06-19 00:32:34.572135+07	\N	\N	-57\n
6562	422	134	537c5519-f38d-4494-8498-5870db817df5	ACCEPTED	4	1052	2026-06-19 00:32:34.572136+07	\N	\N	158\n
6575	423	29	a4d6d8aa-dd5f-4e29-bdae-c7ce3cdb49cc	ACCEPTED	7	1028	2026-06-19 00:32:59.553787+07	\N	\N	99\n
6574	423	28	7493cb64-06fc-4b14-8054-0ba60f3d4bd4	ACCEPTED	5	1020	2026-06-19 00:32:59.553786+07	\N	\N	579\n
6577	423	31	67ce00db-be33-4177-9943-7991fd1217ca	ACCEPTED	7	824	2026-06-19 00:32:59.553789+07	\N	\N	30000\n
6568	423	22	46f33557-1ca4-4ae6-a59b-2dd60ab1fe7d	ACCEPTED	5	1012	2026-06-19 00:32:59.553779+07	\N	\N	30\n
6581	423	35	a3db770f-f4d8-461c-8898-47b33de3206a	ACCEPTED	8	1016	2026-06-19 00:32:59.553794+07	\N	\N	-2\n
6576	423	30	2496b757-e274-4aa3-ab04-5c4a4249966f	ACCEPTED	6	1016	2026-06-19 00:32:59.553788+07	\N	\N	0\n
6567	423	21	4d0971de-b50d-4bc6-8089-283499529c78	ACCEPTED	6	1036	2026-06-19 00:32:59.553776+07	\N	\N	3\n
6588	423	60	0dfa0c14-7b94-40a6-abcb-208c5f7fd5b3	ACCEPTED	6	1032	2026-06-19 00:32:59.553802+07	\N	\N	380371\n
6578	423	32	9ce3645d-0eac-4f80-b96a-c450ef188932	ACCEPTED	5	984	2026-06-19 00:32:59.553791+07	\N	\N	0\n
6582	423	36	33d0892f-6fef-480a-bd4b-32cc59abf3f6	ACCEPTED	6	1024	2026-06-19 00:32:59.553795+07	\N	\N	801\n
6571	423	25	40e9e8ae-b149-416f-8c5a-9ce0db41730a	ACCEPTED	5	1028	2026-06-19 00:32:59.553782+07	\N	\N	300\n
6585	423	57	2192bb02-1f45-4214-99e9-e8b0e686c412	ACCEPTED	5	1024	2026-06-19 00:32:59.553799+07	\N	\N	787228\n
6570	423	24	08eb9677-bebe-40dc-a52c-914d04ec0262	ACCEPTED	6	860	2026-06-19 00:32:59.553781+07	\N	\N	0\n
6583	423	37	35bd1820-bf79-45f9-b9dc-aa72d8323227	ACCEPTED	20	1016	2026-06-19 00:32:59.553797+07	\N	\N	1000\n
6584	423	38	669ae3e2-4686-4c88-b7b5-c00cd82370b2	ACCEPTED	5	1028	2026-06-19 00:32:59.553798+07	\N	\N	3000000\n
6572	423	26	ca72a143-4f5b-4538-89f9-b77478f4ca70	ACCEPTED	8	1016	2026-06-19 00:32:59.553784+07	\N	\N	-30\n
6573	423	27	814465c8-8308-4987-bab8-b1cabd595caa	ACCEPTED	6	1080	2026-06-19 00:32:59.553785+07	\N	\N	1000\n
6586	423	58	9cfc503f-bf0c-4121-aa5c-24633d975c5c	ACCEPTED	5	1080	2026-06-19 00:32:59.5538+07	\N	\N	803799\n
6594	423	66	68ca9cbe-9ad1-461a-b61f-1a7be7a80908	ACCEPTED	5	1028	2026-06-19 00:32:59.553809+07	\N	\N	129492\n
6592	423	64	d041e4ea-12c4-4485-8018-51f76170a6b3	ACCEPTED	5	1024	2026-06-19 00:32:59.553807+07	\N	\N	710339\n
6596	423	68	dcea176b-42c6-445c-aa84-dfd5cd8176db	ACCEPTED	6	884	2026-06-19 00:32:59.553812+07	\N	\N	1161167\n
6591	423	63	1011a80e-1968-4081-b40f-f990845b644b	ACCEPTED	5	1020	2026-06-19 00:32:59.553806+07	\N	\N	1507378\n
6593	423	65	977d159a-443c-4d2e-aa06-94fe91d04489	ACCEPTED	8	1012	2026-06-19 00:32:59.553808+07	\N	\N	475745\n
6597	423	69	16dff26e-1c5f-4769-b356-f25f9893a352	ACCEPTED	5	1016	2026-06-19 00:32:59.553813+07	\N	\N	616334\n
6595	423	67	e98f2f37-874d-49be-bcf0-37c37108899e	ACCEPTED	6	1040	2026-06-19 00:32:59.553811+07	\N	\N	473222\n
6600	423	72	8543c388-9508-4163-b1cb-4d9ec4402cb0	ACCEPTED	17	1008	2026-06-19 00:32:59.553816+07	\N	\N	1011312\n
6602	423	74	14de3af5-0862-4b0c-9a65-68a639a2565b	ACCEPTED	5	1028	2026-06-19 00:32:59.553819+07	\N	\N	909595\n
6604	423	76	69b07e98-612e-4855-b447-24ed2902e6b3	ACCEPTED	5	992	2026-06-19 00:32:59.553821+07	\N	\N	802483\n
6601	423	73	fb5b8699-a7a1-46e9-920b-eb9ba5396e3c	ACCEPTED	5	1012	2026-06-19 00:32:59.553818+07	\N	\N	702179\n
6603	423	75	18246a60-8c16-4b3e-acd5-33a3a02ab12a	ACCEPTED	5	1016	2026-06-19 00:32:59.55382+07	\N	\N	1760278\n
6608	423	80	cc4f20ba-3566-48f0-9df1-71557d78bb8b	ACCEPTED	6	1032	2026-06-19 00:32:59.553825+07	\N	\N	-1611196\n
6598	423	70	aa36e2f1-4fdd-4cb5-a483-e6306661de53	ACCEPTED	5	876	2026-06-19 00:32:59.553814+07	\N	\N	959298\n
6599	423	71	6f6427a7-311d-4f17-8224-e59ddd0f11ad	ACCEPTED	7	880	2026-06-19 00:32:59.553815+07	\N	\N	1416847\n
6606	423	78	c52c6d4d-e4d3-4f22-b82c-d39f2706d6de	ACCEPTED	5	1024	2026-06-19 00:32:59.553823+07	\N	\N	-824805\n
6609	423	81	c147d087-4c91-447b-8b42-e8fdcd1e6a7e	ACCEPTED	8	1092	2026-06-19 00:32:59.553827+07	\N	\N	-846475\n
6610	423	82	e7bcfccb-c843-4c29-bde8-ab1c722f1e5f	ACCEPTED	5	1024	2026-06-19 00:32:59.553828+07	\N	\N	-1795574\n
6569	423	23	eda1cc00-73c9-448c-8098-a550f02074f4	ACCEPTED	7	1020	2026-06-19 00:32:59.55378+07	\N	\N	0\n
6579	423	33	00a1d599-ab36-45ec-97a0-1f89c3b2078a	ACCEPTED	6	1012	2026-06-19 00:32:59.553792+07	\N	\N	84\n
6580	423	34	d68487af-4301-4fec-8cbc-74042ac010ce	ACCEPTED	5	1024	2026-06-19 00:32:59.553793+07	\N	\N	15\n
6605	423	77	cc2ed46f-f27f-4ae3-ba0f-3c5cd8a41478	ACCEPTED	13	1024	2026-06-19 00:32:59.553822+07	\N	\N	-987624\n
6611	423	83	5f5cb95e-d511-4859-a94e-7512427bd654	ACCEPTED	5	872	2026-06-19 00:32:59.553829+07	\N	\N	-1500204\n
6613	423	85	7504e702-3d25-42df-8317-b518aeb93963	ACCEPTED	19	984	2026-06-19 00:32:59.553831+07	\N	\N	-1006285\n
6612	423	84	ce1565e4-3bb9-401f-ba0c-605b1ca51e7b	ACCEPTED	9	872	2026-06-19 00:32:59.55383+07	\N	\N	-734921\n
6607	423	79	06194c85-4071-47fb-840b-3081c090790c	ACCEPTED	5	1088	2026-06-19 00:32:59.553824+07	\N	\N	-1351853\n
6614	423	86	d85b0729-d86c-4514-9fae-2dc05c7ec599	ACCEPTED	6	1024	2026-06-19 00:32:59.553832+07	\N	\N	-876295\n
6616	423	88	5912773d-b79c-46de-84f5-2bf92d80e159	ACCEPTED	4	880	2026-06-19 00:32:59.553834+07	\N	\N	-955984\n
6618	423	90	c2226cf3-cd08-47a6-a353-24f6f7af0610	ACCEPTED	6	1024	2026-06-19 00:32:59.553836+07	\N	\N	-1520451\n
6617	423	89	4986c57c-3dbc-4c6b-b71c-4e90742d09a8	ACCEPTED	6	976	2026-06-19 00:32:59.553835+07	\N	\N	-902015\n
6615	423	87	8a020284-9077-426c-ba2b-c20ed95f6538	ACCEPTED	4	1076	2026-06-19 00:32:59.553833+07	\N	\N	-1189260\n
6621	423	93	6150fdf3-4d6f-494a-a8a1-8721c2910f3f	ACCEPTED	5	864	2026-06-19 00:32:59.55384+07	\N	\N	-422973\n
6623	423	95	9df821ed-465d-444a-98f9-5e26bebbff59	ACCEPTED	5	1020	2026-06-19 00:32:59.553842+07	\N	\N	-1192974\n
6619	423	91	8adbf9ce-6683-4fab-9f0e-b0442d597779	ACCEPTED	5	1028	2026-06-19 00:32:59.553838+07	\N	\N	-1113725\n
6622	423	94	37900d1c-0d9f-41da-a428-564ef6c06169	ACCEPTED	5	1080	2026-06-19 00:32:59.553841+07	\N	\N	-717234\n
6625	423	97	3e19bf76-ff23-42c8-87a0-ebd8dc3534b8	ACCEPTED	7	1000	2026-06-19 00:32:59.553844+07	\N	\N	-517131\n
6620	423	92	a6359b53-6bf1-4854-9ad8-1be56a677249	ACCEPTED	6	876	2026-06-19 00:32:59.553839+07	\N	\N	-471131\n
6624	423	96	eacd019e-511d-48bd-b80b-b4b19e9259b8	ACCEPTED	6	852	2026-06-19 00:32:59.553843+07	\N	\N	-1188270\n
6634	423	106	476ab5f4-a47b-418b-8572-02f6297d6388	ACCEPTED	5	1024	2026-06-19 00:32:59.553854+07	\N	\N	-815576\n
6627	423	99	343b7efc-3879-4212-8949-4173aab5e1b4	ACCEPTED	5	868	2026-06-19 00:32:59.553846+07	\N	\N	-1225775\n
6632	423	104	249eebad-ac9e-41ce-9516-a5efaa601cf0	ACCEPTED	4	1024	2026-06-19 00:32:59.553852+07	\N	\N	514364\n
6630	423	102	9495f6b7-5567-4175-b2b9-eaf3167e8d4c	ACCEPTED	4	1028	2026-06-19 00:32:59.55385+07	\N	\N	-619866\n
6629	423	101	298c49fb-d6f9-47d5-8666-a33f333f856b	ACCEPTED	5	1092	2026-06-19 00:32:59.553848+07	\N	\N	28962\n
6636	423	108	a53173fe-b740-40b3-9ebe-0e91e2496548	ACCEPTED	6	1024	2026-06-19 00:32:59.553856+07	\N	\N	1436130\n
6633	423	105	9cfeb089-de3e-4caf-96bc-af67da000c24	ACCEPTED	5	876	2026-06-19 00:32:59.553853+07	\N	\N	-882565\n
6628	423	100	d8ce26e9-da28-4427-a330-7d413cd18264	ACCEPTED	9	880	2026-06-19 00:32:59.553847+07	\N	\N	281928\n
6637	423	109	e80de5cf-ea32-4f1a-b2df-4ed8b1195cc9	ACCEPTED	8	1020	2026-06-19 00:32:59.553857+07	\N	\N	792531\n
6635	423	107	eb752011-ea67-43b9-95c6-45488e848975	ACCEPTED	6	1024	2026-06-19 00:32:59.553855+07	\N	\N	-34648\n
6631	423	103	2ecd522a-3972-4005-96a5-091a9309db94	ACCEPTED	6	1012	2026-06-19 00:32:59.553851+07	\N	\N	283996\n
6638	423	110	1e11c70c-0955-46d5-98f0-845527a55d84	ACCEPTED	5	1028	2026-06-19 00:32:59.553858+07	\N	\N	-572819\n
6626	423	98	d334d70a-e7ea-4ee3-8d3e-85ff85425bbd	ACCEPTED	5	1024	2026-06-19 00:32:59.553845+07	\N	\N	99178\n
6639	423	111	fdf840e1-5d9b-4a27-9702-462157fef9fe	ACCEPTED	5	984	2026-06-19 00:32:59.553859+07	\N	\N	-309452\n
6640	423	112	a6940604-75f2-4ce2-8014-c6335b4a8e24	ACCEPTED	6	1120	2026-06-19 00:32:59.553861+07	\N	\N	649261\n
6642	423	114	35832a1b-3fe8-4647-a98e-3dc950c06e11	ACCEPTED	5	1028	2026-06-19 00:32:59.55387+07	\N	\N	-234796\n
6646	423	118	1e298492-f643-4ac3-925b-c9e3c8fe164b	ACCEPTED	5	1028	2026-06-19 00:32:59.553875+07	\N	\N	636465324\n
6641	423	113	d5b7b385-a8b5-4892-8170-dd47af7b42a9	ACCEPTED	5	1084	2026-06-19 00:32:59.553869+07	\N	\N	-1143916\n
6644	423	116	f74810c9-7123-4c2e-84df-f3543b6fca1d	ACCEPTED	5	1036	2026-06-19 00:32:59.553872+07	\N	\N	785356\n
6651	423	123	95289dd8-18f5-48d7-b16c-321dce560106	ACCEPTED	5	876	2026-06-19 00:32:59.55388+07	\N	\N	1422690276\n
6655	423	127	221f0019-bd69-4d13-b51d-c6e9346111b8	ACCEPTED	4	1012	2026-06-19 00:32:59.553885+07	\N	\N	0\n
6645	423	117	cfcff1ec-9d73-4262-a3a4-050edc412d8d	ACCEPTED	5	864	2026-06-19 00:32:59.553874+07	\N	\N	362210245\n
6648	423	120	a94d5ca0-69af-4d83-9c29-b22f96156e7a	ACCEPTED	7	1024	2026-06-19 00:32:59.553877+07	\N	\N	371467497\n
6650	423	122	a1de921b-bcc8-4ccb-9ea0-80e317588bc7	ACCEPTED	7	968	2026-06-19 00:32:59.553879+07	\N	\N	-457820119\n
6657	423	129	4f6a10aa-17bb-4baf-8b97-ab120b3eed78	ACCEPTED	6	984	2026-06-19 00:32:59.553887+07	\N	\N	-32\n
6652	423	124	0f6c8b27-3374-4e07-b3a2-d28808dafc8f	ACCEPTED	7	1036	2026-06-19 00:32:59.553882+07	\N	\N	1610593689\n
6656	423	128	6d5a5f6c-da11-4915-8e55-ac235d81cd48	ACCEPTED	9	1020	2026-06-19 00:32:59.553886+07	\N	\N	82\n
6658	423	130	3fca633e-fc9d-4f79-b1ed-fafcb07c30a8	ACCEPTED	4	864	2026-06-19 00:32:59.553888+07	\N	\N	-5\n
6653	423	125	753fe1c8-5a20-48d5-95d8-0f12c75627ee	ACCEPTED	3	864	2026-06-19 00:32:59.553883+07	\N	\N	86961293\n
6649	423	121	bf7eec97-6525-49d3-ac8f-501ce23079c8	ACCEPTED	4	868	2026-06-19 00:32:59.553878+07	\N	\N	1259817393\n
6660	423	132	931dc533-60a3-4e3f-b793-29f0c235ccf0	WRONG_ANSWER	6	832	2026-06-19 00:32:59.553891+07	\N	\N	1-1\n
6661	423	133	ff0dd363-edb5-44e7-a281-e99c75faee94	ACCEPTED	6	1020	2026-06-19 00:32:59.553892+07	\N	\N	-57\n
6659	423	131	b942b9a2-c786-4347-ba1e-c9faa04cd839	ACCEPTED	4	1056	2026-06-19 00:32:59.553889+07	\N	\N	71\n
6665	423	137	a3978a6a-5c90-47db-925a-c8365a678384	ACCEPTED	3	1060	2026-06-19 00:32:59.553896+07	\N	\N	64\n
6666	423	138	90323247-266c-4b4e-b2be-e6194836c150	ACCEPTED	3	1060	2026-06-19 00:32:59.553897+07	\N	\N	51\n
6731	424	103	5a122d99-09b0-42a1-83b8-b61bce038981	ACCEPTED	4	1024	2026-06-19 00:33:27.058978+07	\N	\N	283996\n
6732	424	104	abed74da-4dde-478a-9bcf-d3a4a828afc4	ACCEPTED	4	860	2026-06-19 00:33:27.058978+07	\N	\N	514364\n
6590	423	62	00927b1d-82bd-40ae-be47-9e5ab5c70cb1	ACCEPTED	5	1024	2026-06-19 00:32:59.553805+07	\N	\N	1486218\n
6589	423	61	81775eaa-5607-45bd-b2df-eec54ecc68c6	ACCEPTED	5	864	2026-06-19 00:32:59.553803+07	\N	\N	879721\n
6663	423	135	7d1a7668-1718-484e-b865-4d7ff655bcbd	ACCEPTED	4	996	2026-06-19 00:32:59.553894+07	\N	\N	3\n
8971	460	67	5cf53b6b-eb96-47d3-8c15-388a8f96bc40	ACCEPTED	5	1072	2026-06-21 02:01:32.405748+07	\N	\N	473222
7240	441	22	66cb7ac1-0682-4ecf-8328-4c48655d18ca	ACCEPTED	5	1032	2026-06-19 01:46:36.145577+07	\N	\N	30\n
7239	441	21	4cf7cc17-9e97-4af9-9043-84549b9567fc	ACCEPTED	5	884	2026-06-19 01:46:36.145551+07	\N	\N	3\n
7242	441	24	925b4863-581d-43b0-9933-e5f7c378ee78	ACCEPTED	4	868	2026-06-19 01:46:36.145588+07	\N	\N	0\n
7250	441	32	da1a12c6-2629-4f38-9537-6189f177e59b	ACCEPTED	5	1028	2026-06-19 01:46:36.1456+07	\N	\N	0\n
7251	441	33	67bc8a7b-762e-4b37-9b10-c05182ea1c7b	ACCEPTED	6	1032	2026-06-19 01:46:36.145601+07	\N	\N	84\n
7246	441	28	c5041917-0076-4c72-9ed3-1a485eab163c	ACCEPTED	4	1096	2026-06-19 01:46:36.145594+07	\N	\N	579\n
7249	441	31	1ed0fe9e-315f-4632-850e-73be32f3f00d	ACCEPTED	4	1032	2026-06-19 01:46:36.145598+07	\N	\N	30000\n
7241	441	23	422bdc84-cf42-4306-b0f8-37c89cf6a57f	ACCEPTED	5	868	2026-06-19 01:46:36.145587+07	\N	\N	0\n
7243	441	25	4c269de4-61c5-4bec-b78a-516a20a5337b	ACCEPTED	5	800	2026-06-19 01:46:36.14559+07	\N	\N	300\n
7259	441	59	a38f1686-a9cc-4bc1-b673-469b343042d4	ACCEPTED	6	1088	2026-06-19 01:46:36.145613+07	\N	\N	545178\n
7264	441	64	7af033db-ac52-467a-a148-ee9dcb5a9446	ACCEPTED	10	1076	2026-06-19 01:46:36.14562+07	\N	\N	710339\n
7272	441	72	434bd32f-527a-476e-a485-fe096845d6e9	ACCEPTED	6	1024	2026-06-19 01:46:36.145631+07	\N	\N	1011312\n
7266	441	66	e2fdd1b9-6d25-4e6d-9f5a-6713173c84c0	ACCEPTED	6	1292	2026-06-19 01:46:36.145622+07	\N	\N	129492\n
7275	441	75	0774d77b-43ff-44de-b4a5-f451caa00249	ACCEPTED	4	872	2026-06-19 01:46:36.145635+07	\N	\N	1760278\n
7278	441	78	04e02de7-a603-4d3e-8dd3-3c7d088dc3bc	ACCEPTED	4	880	2026-06-19 01:46:36.145639+07	\N	\N	-824805\n
7277	441	77	620f2eea-7468-47c5-b1bf-40d49904c3a6	ACCEPTED	5	880	2026-06-19 01:46:36.145638+07	\N	\N	-987624\n
7279	441	79	d1fb3180-6181-4a19-b8ec-394156afcb4f	ACCEPTED	5	1096	2026-06-19 01:46:36.14564+07	\N	\N	-1351853\n
7283	441	83	14a61639-fff5-4dd0-974a-b28057035c5a	ACCEPTED	5	992	2026-06-19 01:46:36.145646+07	\N	\N	-1500204\n
7284	441	84	b9a6806c-653c-4f18-8977-8360044a6361	ACCEPTED	4	900	2026-06-19 01:46:36.145648+07	\N	\N	-734921\n
7282	441	82	751585ff-f25e-4226-a612-2a683b02d286	ACCEPTED	5	868	2026-06-19 01:46:36.145645+07	\N	\N	-1795574\n
7281	441	81	80615a01-2631-4df1-b13d-ccf03a901f32	ACCEPTED	4	1016	2026-06-19 01:46:36.145643+07	\N	\N	-846475\n
7285	441	85	a7d746d1-fe25-451c-8084-5babd22e6bb7	ACCEPTED	4	1020	2026-06-19 01:46:36.145649+07	\N	\N	-1006285\n
7298	441	98	469d6c1a-afc8-47f9-be99-ceed6b842a0a	ACCEPTED	5	1036	2026-06-19 01:46:36.145667+07	\N	\N	99178\n
7306	441	106	5ef3ae0f-776e-4a32-84be-77169a9c87c4	ACCEPTED	4	1012	2026-06-19 01:46:36.145713+07	\N	\N	-815576\n
7305	441	105	c7c15a0a-f7b6-48d7-b9a6-631ab9b20d56	ACCEPTED	5	872	2026-06-19 01:46:36.145712+07	\N	\N	-882565\n
7303	441	103	fcf206a5-9d5b-41e6-b32e-45d7444bd6fc	ACCEPTED	5	1108	2026-06-19 01:46:36.145709+07	\N	\N	283996\n
7302	441	102	df0f9bca-37a9-49b3-9ec2-0a032b57c7ab	ACCEPTED	6	868	2026-06-19 01:46:36.145707+07	\N	\N	-619866\n
7307	441	107	098a5652-088b-4f3a-a07d-550724f28fbf	ACCEPTED	4	868	2026-06-19 01:46:36.145714+07	\N	\N	-34648\n
7301	441	101	a1a1cdcf-19ba-4d43-856d-ab4230cb0bb6	ACCEPTED	7	1028	2026-06-19 01:46:36.145671+07	\N	\N	28962\n
7304	441	104	085cefb5-1b2a-4d06-bd93-bc091fc12e85	ACCEPTED	6	984	2026-06-19 01:46:36.14571+07	\N	\N	514364\n
7308	441	108	23ce8338-a87d-46bf-9a90-01ca8216b6ae	ACCEPTED	8	872	2026-06-19 01:46:36.145716+07	\N	\N	1436130\n
7310	441	110	f158c658-7685-4e33-bbf6-7b9c7be22bc6	ACCEPTED	4	888	2026-06-19 01:46:36.145718+07	\N	\N	-572819\n
7311	441	111	340186ed-5129-4dc3-87cf-c3ca9cb8c330	ACCEPTED	4	872	2026-06-19 01:46:36.14572+07	\N	\N	-309452\n
7319	441	119	97c82735-5078-4823-81b5-c322dda88d84	ACCEPTED	6	1008	2026-06-19 01:46:36.145731+07	\N	\N	-738231997\n
7320	441	120	d755100a-42f9-4db1-a7b0-6f42d7b37622	ACCEPTED	5	884	2026-06-19 01:46:36.145732+07	\N	\N	371467497\n
7312	441	112	00c0b94c-8ea9-4dbe-a528-618652ce6378	ACCEPTED	5	876	2026-06-19 01:46:36.145721+07	\N	\N	649261\n
7315	441	115	dce87a01-4804-40e2-98a3-4db642308fe6	ACCEPTED	5	872	2026-06-19 01:46:36.145725+07	\N	\N	506806\n
7316	441	116	c6a4e102-a707-49f8-836e-d0495b80c7b7	ACCEPTED	7	1096	2026-06-19 01:46:36.145727+07	\N	\N	785356\n
7317	441	117	171c1f0b-1256-4715-ae72-8ed3700352fd	ACCEPTED	5	1120	2026-06-19 01:46:36.145728+07	\N	\N	362210245\n
7321	441	121	b8b84c8c-5053-4c9e-984e-a1245e2c7c24	ACCEPTED	4	880	2026-06-19 01:46:36.145734+07	\N	\N	1259817393\n
7323	441	123	e99cd738-bced-4a98-ac35-4866ee4897f0	ACCEPTED	5	864	2026-06-19 01:46:36.145737+07	\N	\N	1422690276\n
7324	441	124	4cad8416-7424-42ac-8c55-09e6f7655ce9	ACCEPTED	7	1028	2026-06-19 01:46:36.145738+07	\N	\N	1610593689\n
7328	441	128	583bf8f1-f56d-4bcd-8b4b-5e96978cd684	ACCEPTED	6	872	2026-06-19 01:46:36.145747+07	\N	\N	82\n
7326	441	126	4368c740-b997-4d35-b290-885cced75eea	ACCEPTED	5	1012	2026-06-19 01:46:36.145741+07	\N	\N	-882105735\n
7322	441	122	972b1f8b-4567-4642-9c88-a921ed030b63	ACCEPTED	6	1020	2026-06-19 01:46:36.145735+07	\N	\N	-457820119\n
7332	441	132	d9a65461-f374-4021-85b7-69f9a672187f	ACCEPTED	4	864	2026-06-19 01:46:36.145776+07	\N	\N	-1\n
7333	441	133	f465e74e-32f2-48f6-9c80-4bef7c14f41b	ACCEPTED	4	1028	2026-06-19 01:46:36.145814+07	\N	\N	-57\n
7327	441	127	aa563752-2eab-451b-822e-3527769638de	ACCEPTED	4	1068	2026-06-19 01:46:36.145746+07	\N	\N	0\n
7329	441	129	9d7c74fb-9d21-443c-9e12-48069b30b3e1	ACCEPTED	5	864	2026-06-19 01:46:36.145748+07	\N	\N	-32\n
7331	441	131	b41b8f53-5246-4c2e-a080-facbdbaa5def	ACCEPTED	4	908	2026-06-19 01:46:36.145751+07	\N	\N	71\n
7334	441	134	cb521cba-5ea2-4f71-89bd-bfedf3cafc97	ACCEPTED	5	1020	2026-06-19 01:46:36.145816+07	\N	\N	158\n
7336	441	136	c60055d2-ab47-45ae-9675-2da0a96217c3	ACCEPTED	3	1056	2026-06-19 01:46:36.145819+07	\N	\N	129\n
7337	441	137	10264af9-aa46-4acb-80f7-3c41770ae3a4	ACCEPTED	3	1288	2026-06-19 01:46:36.145821+07	\N	\N	64\n
7338	441	138	37e4678a-14b9-4aaf-8e18-30b29f8ddbae	ACCEPTED	3	1056	2026-06-19 01:46:36.145822+07	\N	\N	51\n
6587	423	59	2757e729-dde6-415a-9ef3-adf4a91e4a8b	ACCEPTED	8	1076	2026-06-19 00:32:59.553801+07	\N	\N	545178\n
7248	441	30	95165ef0-a609-4a45-85a4-ccc88dac7d51	ACCEPTED	6	1088	2026-06-19 01:46:36.145597+07	\N	\N	0\n
7346	442	28	3484f0ad-3384-4642-9473-8ced1fa6b8b2	ACCEPTED	5	1032	2026-06-19 01:57:50.086837+07	\N	\N	579\n
7340	442	22	bd08bedd-d427-4757-975c-781689baba01	ACCEPTED	6	12048	2026-06-19 01:57:50.086818+07	\N	\N	30\n
7342	442	24	96e41b21-1f94-46e2-af88-28c29c6844f5	ACCEPTED	5	2424	2026-06-19 01:57:50.086819+07	\N	\N	0\n
7357	442	57	a2670f9b-5327-4770-ae8e-827d823fa4db	ACCEPTED	4	1040	2026-06-19 01:57:50.086842+07	\N	\N	787228\n
7348	442	30	50a15802-612c-4984-87fc-42e9a2476486	ACCEPTED	5	1036	2026-06-19 01:57:50.086838+07	\N	\N	0\n
7354	442	36	f6a96af9-295e-4315-adcf-ad8f99a0ec68	ACCEPTED	5	1092	2026-06-19 01:57:50.08684+07	\N	\N	801\n
7347	442	29	c794927a-b010-4454-8aad-7540d76bacbb	ACCEPTED	5	4396	2026-06-19 01:57:50.086837+07	\N	\N	99\n
7353	442	35	44d27682-f041-4d64-bc3a-ab7d20b933c3	ACCEPTED	4	1644	2026-06-19 01:57:50.08684+07	\N	\N	-2\n
7339	442	21	6900a39d-cc82-484b-9841-76300874fb84	ACCEPTED	5	1392	2026-06-19 01:57:50.086807+07	\N	\N	3\n
7349	442	31	2273a2f7-11ba-48ae-9d75-7f27089b017e	ACCEPTED	5	876	2026-06-19 01:57:50.086838+07	\N	\N	30000\n
7355	442	37	bc9d3326-94be-486a-b254-00fbe89a9947	ACCEPTED	5	1092	2026-06-19 01:57:50.086841+07	\N	\N	1000\n
7341	442	23	fffff688-cc92-42a6-bd36-811d58ab0744	ACCEPTED	5	2400	2026-06-19 01:57:50.086818+07	\N	\N	0\n
7351	442	33	cdcd7c07-9933-4ebf-9a74-fd0e0545366a	ACCEPTED	7	3788	2026-06-19 01:57:50.086839+07	\N	\N	84\n
7350	442	32	659fcae1-7d5e-48c4-b59e-3e1dbf7b38eb	ACCEPTED	7	1348	2026-06-19 01:57:50.086839+07	\N	\N	0\n
7360	442	60	0e4ea13a-3da7-4319-8034-170b80d32146	ACCEPTED	8	1188	2026-06-19 01:57:50.086843+07	\N	\N	380371\n
7344	442	26	7b97fa89-5e79-45b4-8e6c-e1f94dd7a0f6	ACCEPTED	4	1024	2026-06-19 01:57:50.086836+07	\N	\N	-30\n
7345	442	27	03dc6d80-eaab-4804-b105-a22041dd4f62	ACCEPTED	6	1040	2026-06-19 01:57:50.086836+07	\N	\N	1000\n
7352	442	34	d0d05392-f1dd-44c1-9878-129a4a58962b	ACCEPTED	4	1060	2026-06-19 01:57:50.08684+07	\N	\N	15\n
7361	442	61	17e22dcc-638d-4247-a831-932e9fe47f39	ACCEPTED	7	1036	2026-06-19 01:57:50.086844+07	\N	\N	879721\n
7371	442	71	c81ab232-2cba-4af5-9649-0e0702ab0533	ACCEPTED	4	1036	2026-06-19 01:57:50.086848+07	\N	\N	1416847\n
7374	442	74	31ffa22a-4b04-45a4-a2ba-73045fe83993	ACCEPTED	6	1032	2026-06-19 01:57:50.086849+07	\N	\N	909595\n
7369	442	69	42f8cd20-ca52-4a19-8d78-116e37f40249	ACCEPTED	4	1048	2026-06-19 01:57:50.086847+07	\N	\N	616334\n
7379	442	79	83999b81-5bc5-42f9-b6c5-64af72e7e5b0	ACCEPTED	6	1084	2026-06-19 01:57:50.086851+07	\N	\N	-1351853\n
7370	442	70	6927fa37-0240-4b31-9880-20239f20774e	ACCEPTED	6	888	2026-06-19 01:57:50.086847+07	\N	\N	959298\n
7366	442	66	5d60f95b-3aaa-4726-90d0-7889829fbce9	ACCEPTED	6	1048	2026-06-19 01:57:50.086846+07	\N	\N	129492\n
7386	442	86	6bc33d13-7fb1-46c5-8df2-4c4f4aab026d	ACCEPTED	6	1036	2026-06-19 01:57:50.086854+07	\N	\N	-876295\n
7364	442	64	e5f9f8f4-1c54-4874-bb65-0e9b6ff57623	ACCEPTED	5	1036	2026-06-19 01:57:50.086845+07	\N	\N	710339\n
7377	442	77	488dde25-0ba0-4714-8840-6c6d41c49ea0	ACCEPTED	5	868	2026-06-19 01:57:50.08685+07	\N	\N	-987624\n
7378	442	78	319ddbb2-7fcd-4fa3-bb62-5fda96938e7a	ACCEPTED	6	1012	2026-06-19 01:57:50.086851+07	\N	\N	-824805\n
7376	442	76	47f55e72-aad4-4d37-96c7-ac1f7df64305	ACCEPTED	5	1032	2026-06-19 01:57:50.08685+07	\N	\N	802483\n
7384	442	84	d2064768-3c21-465c-93f0-643aaf382070	ACCEPTED	5	888	2026-06-19 01:57:50.086853+07	\N	\N	-734921\n
7380	442	80	ee419e2b-f7e4-4ba8-a565-c1574ba50134	ACCEPTED	5	1092	2026-06-19 01:57:50.086852+07	\N	\N	-1611196\n
7383	442	83	0c9b2534-ae22-4998-8018-828b498f0626	ACCEPTED	8	1016	2026-06-19 01:57:50.086853+07	\N	\N	-1500204\n
7363	442	63	6b80f917-da36-44f8-979a-1916c17c34ee	ACCEPTED	9	848	2026-06-19 01:57:50.086845+07	\N	\N	1507378\n
7381	442	81	fcdbca49-9284-4976-a12f-2a4e1d4f5667	ACCEPTED	8	1108	2026-06-19 01:57:50.086852+07	\N	\N	-846475\n
7367	442	67	19a08754-e5d9-467a-af52-1661a3562205	ACCEPTED	11	1020	2026-06-19 01:57:50.086846+07	\N	\N	473222\n
7385	442	85	1628f148-13f7-474c-81db-0be98a25e4a3	ACCEPTED	5	1096	2026-06-19 01:57:50.086854+07	\N	\N	-1006285\n
7375	442	75	f7af2f22-bf3a-497e-a7f7-e339fa1efac8	ACCEPTED	4	1048	2026-06-19 01:57:50.08685+07	\N	\N	1760278\n
7382	442	82	a8397786-773e-4789-80fe-4b80cb2fe90e	ACCEPTED	4	1032	2026-06-19 01:57:50.086853+07	\N	\N	-1795574\n
7387	442	87	7afadf68-5089-48d5-b676-e1d2d387bd18	ACCEPTED	5	876	2026-06-19 01:57:50.086854+07	\N	\N	-1189260\n
7390	442	90	50e8d8f5-d578-49b3-aa46-ff249392ab35	ACCEPTED	6	1028	2026-06-19 01:57:50.086864+07	\N	\N	-1520451\n
7391	442	91	b9e25d6e-221e-4b86-a754-adceea08ab87	ACCEPTED	4	1048	2026-06-19 01:57:50.086864+07	\N	\N	-1113725\n
7389	442	89	cc2128b7-a77d-4b1c-b7da-bf4a9f167295	ACCEPTED	5	1036	2026-06-19 01:57:50.086855+07	\N	\N	-902015\n
7396	442	96	8071e273-b032-42d6-b370-a0fda7a45782	ACCEPTED	6	980	2026-06-19 01:57:50.086867+07	\N	\N	-1188270\n
7392	442	92	45f68f21-4ddb-4cb3-8a94-687b42e6c5d8	ACCEPTED	5	1040	2026-06-19 01:57:50.086865+07	\N	\N	-471131\n
7405	442	105	889da5f8-0b33-4153-8223-bf6d7529b7e8	ACCEPTED	5	880	2026-06-19 01:57:50.086871+07	\N	\N	-882565\n
7394	442	94	ba9bb6ee-612e-45ee-8383-cf9a650b81a6	ACCEPTED	7	912	2026-06-19 01:57:50.086866+07	\N	\N	-717234\n
7400	442	100	ce6b19ed-c100-45bc-a743-582a6f9e6d66	ACCEPTED	6	1020	2026-06-19 01:57:50.086869+07	\N	\N	281928\n
7401	442	101	b498ef01-1a99-47a3-8fe5-b93075378558	ACCEPTED	5	872	2026-06-19 01:57:50.086869+07	\N	\N	28962\n
7399	442	99	be320014-ac45-4e0d-8b39-f7e654e44a7d	ACCEPTED	5	1020	2026-06-19 01:57:50.086868+07	\N	\N	-1225775\n
7393	442	93	56a97b0e-10ae-403f-96bd-8f0abcd7c6b9	ACCEPTED	4	1020	2026-06-19 01:57:50.086865+07	\N	\N	-422973\n
7403	442	103	bd2fef75-0e58-4cc4-9eaa-26c188344595	ACCEPTED	7	1036	2026-06-19 01:57:50.08687+07	\N	\N	283996\n
7404	442	104	ccb7f082-241e-428c-8c0d-ea1ab91084f2	ACCEPTED	8	992	2026-06-19 01:57:50.086871+07	\N	\N	514364\n
7398	442	98	0a277aa9-2e62-44f5-88a9-0d69baa5e6a8	ACCEPTED	7	1088	2026-06-19 01:57:50.086868+07	\N	\N	99178\n
7402	442	102	63244bee-f57a-4e04-98cd-bbe42b599eee	ACCEPTED	5	996	2026-06-19 01:57:50.08687+07	\N	\N	-619866\n
6647	423	119	6cfcafd8-88e2-444d-a446-98fcbaf78ca1	ACCEPTED	6	1032	2026-06-19 00:32:59.553876+07	\N	\N	-738231997\n
6643	423	115	eab77b6a-fb07-4271-8edc-e20beb344de3	ACCEPTED	7	1092	2026-06-19 00:32:59.553871+07	\N	\N	506806\n
6654	423	126	a15ca58a-3f5d-4720-811c-f12df7b7ccf4	ACCEPTED	5	996	2026-06-19 00:32:59.553884+07	\N	\N	-882105735\n
6662	423	134	df3f331d-0406-41b0-ba20-11ce17f8c655	ACCEPTED	4	1088	2026-06-19 00:32:59.553893+07	\N	\N	158\n
6664	423	136	6e5b92f6-3900-4e19-b9f5-aa0504994714	ACCEPTED	4	1056	2026-06-19 00:32:59.553895+07	\N	\N	129\n
7280	441	80	2feade15-3e81-4465-a16f-d2cd5ce126c3	ACCEPTED	8	1000	2026-06-19 01:46:36.145642+07	\N	\N	-1611196\n
6681	424	35	c297f9a1-3c60-4e27-979f-a92333a75744	ACCEPTED	6	876	2026-06-19 00:33:27.058938+07	\N	\N	-2\n
6672	424	26	76ff96b8-ead2-4521-9563-107cb8316100	ACCEPTED	6	1020	2026-06-19 00:33:27.058931+07	\N	\N	-30\n
6669	424	23	8e0f6ed6-f8e7-462a-9d27-03878774c62c	ACCEPTED	6	836	2026-06-19 00:33:27.058929+07	\N	\N	0\n
6690	424	62	485569f4-31c5-4922-aa31-e97f8777831b	ACCEPTED	6	876	2026-06-19 00:33:27.058946+07	\N	\N	1486218\n
6685	424	57	a86982bd-55fc-4a3d-b4d7-db02bbb344a7	ACCEPTED	5	1096	2026-06-19 00:33:27.058942+07	\N	\N	787228\n
6678	424	32	6ff52bbf-7097-4a3e-8452-48c8dc986004	ACCEPTED	5	1016	2026-06-19 00:33:27.058936+07	\N	\N	0\n
6673	424	27	e87550d9-635b-4b53-858d-77838bb83e4f	ACCEPTED	5	1024	2026-06-19 00:33:27.058932+07	\N	\N	1000\n
6671	424	25	0e877c59-2800-4cbc-8247-d5002138a3aa	ACCEPTED	7	888	2026-06-19 00:33:27.05893+07	\N	\N	300\n
6682	424	36	5a10ca8c-ced2-45e8-b516-61d27eabafe4	ACCEPTED	7	1020	2026-06-19 00:33:27.058939+07	\N	\N	801\n
6676	424	30	05e34cf4-264e-42f9-816d-fbd4103eaae2	ACCEPTED	5	880	2026-06-19 00:33:27.058934+07	\N	\N	0\n
6684	424	38	85bdc123-9e06-4499-b10e-ecd17891bc0c	ACCEPTED	8	900	2026-06-19 00:33:27.058941+07	\N	\N	3000000\n
6683	424	37	2eb1b325-5e7d-418f-82d9-12bd140ff0a2	ACCEPTED	6	972	2026-06-19 00:33:27.05894+07	\N	\N	1000\n
6667	424	21	57d516b8-abdf-491f-ab1d-aa5151791813	ACCEPTED	4	864	2026-06-19 00:33:27.058925+07	\N	\N	3\n
6689	424	61	ae5925c8-5f08-4dcc-a7ec-d3d911273f51	ACCEPTED	7	988	2026-06-19 00:33:27.058945+07	\N	\N	879721\n
6674	424	28	cb8705b3-ade9-4d8f-939c-e04e3bb5c95c	ACCEPTED	9	880	2026-06-19 00:33:27.058933+07	\N	\N	579\n
6686	424	58	2e2a98d4-f549-4c55-ab54-a5258c606573	ACCEPTED	6	1024	2026-06-19 00:33:27.058942+07	\N	\N	803799\n
6670	424	24	ac78f30b-b3b7-46da-ae03-77a017b1fe13	ACCEPTED	4	1020	2026-06-19 00:33:27.058929+07	\N	\N	0\n
6687	424	59	923ab502-376c-4502-82f2-53fbbf876ae8	ACCEPTED	4	888	2026-06-19 00:33:27.058943+07	\N	\N	545178\n
6680	424	34	738701c2-18ab-4269-90a9-8874bd883a30	ACCEPTED	7	1020	2026-06-19 00:33:27.058938+07	\N	\N	15\n
6691	424	63	8365e496-295c-4746-9854-89bcebe9530d	ACCEPTED	7	1024	2026-06-19 00:33:27.058947+07	\N	\N	1507378\n
6693	424	65	55328d4c-4643-4016-8970-d6976ae21bc7	ACCEPTED	5	1028	2026-06-19 00:33:27.058948+07	\N	\N	475745\n
6692	424	64	30dc1946-ac7d-47bc-8826-b1496b1c038c	ACCEPTED	4	976	2026-06-19 00:33:27.058947+07	\N	\N	710339\n
6696	424	68	a1881b8e-9733-44e2-882e-ef706b254218	ACCEPTED	6	1032	2026-06-19 00:33:27.05895+07	\N	\N	1161167\n
6697	424	69	6c8913a2-9bac-4854-b7ba-70d33f8ee056	ACCEPTED	4	864	2026-06-19 00:33:27.058951+07	\N	\N	616334\n
6700	424	72	9c6e0729-6eb8-48fc-8cc4-a309f0abdd92	ACCEPTED	7	1092	2026-06-19 00:33:27.058954+07	\N	\N	1011312\n
6701	424	73	e8ac1aa7-93d5-44e7-b9b0-4f296e753d15	ACCEPTED	5	860	2026-06-19 00:33:27.058954+07	\N	\N	702179\n
6699	424	71	5d9d44f5-dff1-4140-bedf-2904ae6c290d	ACCEPTED	5	872	2026-06-19 00:33:27.058953+07	\N	\N	1416847\n
6702	424	74	adeef2c6-1514-475d-adb7-33f7fbf2451d	ACCEPTED	5	872	2026-06-19 00:33:27.058955+07	\N	\N	909595\n
6705	424	77	d2015386-2691-49ce-82a1-1cf82be70e82	ACCEPTED	6	868	2026-06-19 00:33:27.058957+07	\N	\N	-987624\n
6707	424	79	853ac0fd-a35f-4638-875c-9d11dbbbf2af	ACCEPTED	4	876	2026-06-19 00:33:27.058959+07	\N	\N	-1351853\n
6695	424	67	361e2af2-2fc7-4956-bc32-ea07d420f1a8	ACCEPTED	5	1092	2026-06-19 00:33:27.05895+07	\N	\N	473222\n
6703	424	75	9221997c-b1fe-4578-9645-cc9d81ad514a	ACCEPTED	4	1028	2026-06-19 00:33:27.058956+07	\N	\N	1760278\n
6706	424	78	acf7a260-da74-4d14-a97d-189e37697cf9	ACCEPTED	5	1020	2026-06-19 00:33:27.058958+07	\N	\N	-824805\n
6712	424	84	ef2dc244-0add-4038-8af5-a7ae2c808073	ACCEPTED	4	1088	2026-06-19 00:33:27.058963+07	\N	\N	-734921\n
6713	424	85	a733b6a9-f044-4cfa-a549-4366ddca593a	ACCEPTED	6	1024	2026-06-19 00:33:27.058964+07	\N	\N	-1006285\n
6694	424	66	a510cf11-2ef6-4425-bac3-0f87f3cba878	ACCEPTED	8	1084	2026-06-19 00:33:27.058949+07	\N	\N	129492\n
6704	424	76	7ba456af-6522-423c-8db4-6eb7eab209a5	ACCEPTED	4	1016	2026-06-19 00:33:27.058957+07	\N	\N	802483\n
6714	424	86	1ba8fc27-a62a-4e25-bad3-5167dfed9544	ACCEPTED	12	1020	2026-06-19 00:33:27.058965+07	\N	\N	-876295\n
6710	424	82	aa0d0dc9-9723-412d-a8d9-b19a3005d1ed	ACCEPTED	4	1032	2026-06-19 00:33:27.058962+07	\N	\N	-1795574\n
6715	424	87	52d0e6aa-9f8c-447d-9ab0-e5a2c5e59fe3	ACCEPTED	5	1028	2026-06-19 00:33:27.058965+07	\N	\N	-1189260\n
6716	424	88	affa4c9a-3c80-4d5b-80a6-463a911ea6e0	ACCEPTED	4	1024	2026-06-19 00:33:27.058966+07	\N	\N	-955984\n
6720	424	92	91f5b805-52e5-4c3c-93d8-527425ef94b7	ACCEPTED	6	1024	2026-06-19 00:33:27.058969+07	\N	\N	-471131\n
6719	424	91	86985997-b29b-4f95-85b7-a106dbf7dc50	ACCEPTED	5	1032	2026-06-19 00:33:27.058969+07	\N	\N	-1113725\n
6717	424	89	4fef436f-a724-43be-a935-5b02f10cb4ce	ACCEPTED	9	868	2026-06-19 00:33:27.058967+07	\N	\N	-902015\n
6722	424	94	facc8ecb-ec50-4ce9-9669-1a6ddf09327b	ACCEPTED	5	1028	2026-06-19 00:33:27.058971+07	\N	\N	-717234\n
6725	424	97	7846f6eb-5805-4a7a-9433-b8e974980554	ACCEPTED	9	1020	2026-06-19 00:33:27.058973+07	\N	\N	-517131\n
6727	424	99	bcf287a3-63b1-4d4f-ae7d-3e0a6ae4148d	ACCEPTED	4	1016	2026-06-19 00:33:27.058975+07	\N	\N	-1225775\n
6729	424	101	6b5925f0-db6c-4112-870c-456b5949bbc8	ACCEPTED	4	1024	2026-06-19 00:33:27.058976+07	\N	\N	28962\n
6726	424	98	0fec6c52-5cc5-4535-92fd-dbaae79f7c74	ACCEPTED	5	1084	2026-06-19 00:33:27.058974+07	\N	\N	99178\n
6723	424	95	3eda40bc-ae33-4934-ab62-ab0cf08813dd	ACCEPTED	5	868	2026-06-19 00:33:27.058972+07	\N	\N	-1192974\n
6730	424	102	a28b995d-68e1-4922-b8ae-be06ecc94a9a	ACCEPTED	7	1028	2026-06-19 00:33:27.058977+07	\N	\N	-619866\n
6728	424	100	fe435d47-8e89-4f0b-a23a-029f259cb4ff	ACCEPTED	5	888	2026-06-19 00:33:27.058975+07	\N	\N	281928\n
6668	424	22	036e1c41-4672-4095-b197-89abad4dbe68	ACCEPTED	7	1028	2026-06-19 00:33:27.058928+07	\N	\N	30\n
6675	424	29	2737cbcf-bb52-45c6-81ef-fefd8afa0b86	ACCEPTED	5	1028	2026-06-19 00:33:27.058933+07	\N	\N	99\n
6677	424	31	465a0fec-6569-4106-af64-287dedefa5a3	ACCEPTED	5	876	2026-06-19 00:33:27.058935+07	\N	\N	30000\n
6679	424	33	6b9f19c5-4605-4580-a5a5-f720ddd7470f	ACCEPTED	5	884	2026-06-19 00:33:27.058937+07	\N	\N	84\n
6688	424	60	abc1c770-049a-41a3-b511-18d956fa5006	ACCEPTED	5	1020	2026-06-19 00:33:27.058944+07	\N	\N	380371\n
6698	424	70	ff281535-ad0e-4ff5-8904-4b3c7e0d43f1	ACCEPTED	5	1016	2026-06-19 00:33:27.058952+07	\N	\N	959298\n
6711	424	83	01874eea-e35a-4114-95a4-b856ed80dc8f	ACCEPTED	5	976	2026-06-19 00:33:27.058962+07	\N	\N	-1500204\n
6709	424	81	631f321a-76d7-4434-ade3-f67332e8f1b4	ACCEPTED	5	1020	2026-06-19 00:33:27.058961+07	\N	\N	-846475\n
6708	424	80	ab111c2a-5d45-4454-a510-f508f635b6c7	ACCEPTED	5	1096	2026-06-19 00:33:27.05896+07	\N	\N	-1611196\n
6718	424	90	88d24e42-e7ee-4ad0-bff9-1268c4105cfe	ACCEPTED	5	1012	2026-06-19 00:33:27.058968+07	\N	\N	-1520451\n
6721	424	93	d8ea861c-f72c-4a9a-a23d-719c00799caa	ACCEPTED	5	1096	2026-06-19 00:33:27.05897+07	\N	\N	-422973\n
6733	424	105	0d715939-d406-4620-9940-5a994eb98436	ACCEPTED	6	1024	2026-06-19 00:33:27.058979+07	\N	\N	-882565\n
6737	424	109	01e4e3cf-0ec8-4f12-9b85-1dd9e3e7899f	ACCEPTED	6	1016	2026-06-19 00:33:27.058982+07	\N	\N	792531\n
6724	424	96	da1c696d-8ad3-49af-9cd0-727d2fb8b190	ACCEPTED	6	1088	2026-06-19 00:33:27.058972+07	\N	\N	-1188270\n
6738	424	110	3aab60c9-0454-4495-bf3c-54d8a576ecfd	ACCEPTED	4	908	2026-06-19 00:33:27.058983+07	\N	\N	-572819\n
6734	424	106	16a5f3df-4d4e-4987-beed-e189e6bcc27f	ACCEPTED	6	860	2026-06-19 00:33:27.05898+07	\N	\N	-815576\n
6735	424	107	b41aa891-8caa-4e92-9399-b2dfbb52bb92	ACCEPTED	5	960	2026-06-19 00:33:27.058981+07	\N	\N	-34648\n
6736	424	108	b6bbc17d-b70c-436c-a071-a33987374baa	ACCEPTED	5	1032	2026-06-19 00:33:27.058982+07	\N	\N	1436130\n
6739	424	111	4d94a6cf-3850-4325-9ffb-d4c84d0f1680	ACCEPTED	5	1080	2026-06-19 00:33:27.058984+07	\N	\N	-309452\n
6740	424	112	09b20c5d-6fde-40d4-b14f-a443653bb8bb	ACCEPTED	5	1100	2026-06-19 00:33:27.058985+07	\N	\N	649261\n
6742	424	114	c4811126-5d67-49ad-9c42-69e6d7eeb6a1	ACCEPTED	4	1024	2026-06-19 00:33:27.058987+07	\N	\N	-234796\n
6741	424	113	15a9b1de-c82b-460f-abb1-fe9b467f2f14	ACCEPTED	7	1020	2026-06-19 00:33:27.058986+07	\N	\N	-1143916\n
6745	424	117	ea927918-591a-4914-b0e5-739b7065f0d9	ACCEPTED	10	1024	2026-06-19 00:33:27.058989+07	\N	\N	362210245\n
6744	424	116	f8512316-cfb8-44da-b299-c60a2a03df18	ACCEPTED	5	1080	2026-06-19 00:33:27.058988+07	\N	\N	785356\n
6743	424	115	58b65de7-c313-4757-96ce-4a0d4969289d	ACCEPTED	5	876	2026-06-19 00:33:27.058987+07	\N	\N	506806\n
6747	424	119	4afea680-0ec1-42ba-b4e4-c50bb5fc6929	ACCEPTED	6	864	2026-06-19 00:33:27.05899+07	\N	\N	-738231997\n
6751	424	123	62c758e9-4a40-47c9-b372-da7668c26f29	ACCEPTED	5	1020	2026-06-19 00:33:27.058993+07	\N	\N	1422690276\n
6754	424	126	55f067f5-dd99-47cb-b858-af4e45281374	ACCEPTED	6	1020	2026-06-19 00:33:27.058996+07	\N	\N	-882105735\n
6746	424	118	839334da-e2cb-4a7b-94d7-e4b61c880153	ACCEPTED	7	1012	2026-06-19 00:33:27.058989+07	\N	\N	636465324\n
6748	424	120	700dcf0a-1096-4bd1-a3c3-e5d9ae53a5f2	ACCEPTED	7	1016	2026-06-19 00:33:27.058991+07	\N	\N	371467497\n
6753	424	125	a60c5253-32d1-462a-a5ca-2a941649077d	ACCEPTED	5	1024	2026-06-19 00:33:27.058995+07	\N	\N	86961293\n
6755	424	127	30479989-9eae-4084-8127-04b6a4e5df0e	ACCEPTED	5	868	2026-06-19 00:33:27.058997+07	\N	\N	0\n
6750	424	122	de11fa41-e832-4a96-bbee-1b40a0a5d684	ACCEPTED	5	800	2026-06-19 00:33:27.058993+07	\N	\N	-457820119\n
6749	424	121	a2efb117-6b5b-46ee-a357-c23d134b7df9	ACCEPTED	5	1028	2026-06-19 00:33:27.058992+07	\N	\N	1259817393\n
6758	424	130	9a8237de-61ca-4ab5-99bb-f57cc0b96ef5	ACCEPTED	5	1188	2026-06-19 00:33:27.058999+07	\N	\N	-5\n
6759	424	131	c33dbd5f-77e7-424a-a7b7-63db5aaba342	ACCEPTED	5	1016	2026-06-19 00:33:27.059+07	\N	\N	71\n
6752	424	124	aeec50ba-ca93-4542-a152-2b4da75765ab	ACCEPTED	7	864	2026-06-19 00:33:27.058994+07	\N	\N	1610593689\n
6761	424	133	a57c9e96-e7a9-4301-9344-2020c8dabec2	ACCEPTED	5	1024	2026-06-19 00:33:27.059001+07	\N	\N	-57\n
6757	424	129	4afabd0c-1467-49ca-a4bd-44eaf77a9c9d	ACCEPTED	5	1028	2026-06-19 00:33:27.058998+07	\N	\N	-32\n
6762	424	134	e74aec37-1cf4-4307-b265-3c311cde6f13	ACCEPTED	4	1024	2026-06-19 00:33:27.059002+07	\N	\N	158\n
6756	424	128	d7adfc06-110b-46fe-95e2-176554316923	ACCEPTED	6	1056	2026-06-19 00:33:27.058997+07	\N	\N	82\n
6760	424	132	2976b687-b08e-40a0-afb5-98649c71fe84	ACCEPTED	6	1020	2026-06-19 00:33:27.059001+07	\N	\N	-1\n
6763	424	135	4eb28189-508c-4484-bc6a-ddb98c00bfbf	ACCEPTED	2	1056	2026-06-19 00:33:27.059003+07	\N	\N	3\n
6764	424	136	e2ec5a9f-730f-4d03-944e-a77a0e30d570	ACCEPTED	4	1072	2026-06-19 00:33:27.059004+07	\N	\N	129\n
6766	424	138	30d9dcec-0524-4a5b-a300-af927e1fce3f	ACCEPTED	3	1052	2026-06-19 00:33:27.059005+07	\N	\N	51\n
6765	424	137	536713d7-9a39-4a3d-b978-65419a92f0fc	ACCEPTED	3	1060	2026-06-19 00:33:27.059005+07	\N	\N	64\n
7300	441	100	35d2b0e7-00df-4e1a-bb7b-baec8c4585a6	ACCEPTED	8	1032	2026-06-19 01:46:36.14567+07	\N	\N	281928\n
7296	441	96	138cb48f-2703-471c-9de3-a75dacef6c86	ACCEPTED	4	1020	2026-06-19 01:46:36.145665+07	\N	\N	-1188270\n
6770	425	42	223c6f26-fa40-406f-9830-27e227f19bf6	ACCEPTED	6	880	2026-06-19 00:41:01.632453+07	\N	\N	5\n
6771	425	43	dcc7d92b-8516-4d46-842d-8d57c483e5c4	ACCEPTED	5	1024	2026-06-19 00:41:01.632454+07	\N	\N	5\n
6772	425	44	ffad0acf-f275-41e2-be48-c419476f4357	ACCEPTED	6	1036	2026-06-19 00:41:01.632454+07	\N	\N	11\n
6773	425	45	45294420-bfa6-414d-8156-f26ebe256a6f	ACCEPTED	6	980	2026-06-19 00:41:01.632455+07	\N	\N	11\n
6781	425	53	f82df340-698c-4079-8926-940e8bd54997	ACCEPTED	5	1020	2026-06-19 00:41:01.632457+07	\N	\N	100003\n
6776	425	48	85845cbe-2f47-4b36-8a5c-3f9d37219113	ACCEPTED	4	1052	2026-06-19 00:41:01.632455+07	\N	\N	101\n
6775	425	47	bd9fc5ea-a4b8-42d2-bc05-9d49b32ee190	ACCEPTED	4	1096	2026-06-19 00:41:01.632455+07	\N	\N	101\n
6779	425	51	2b757c4f-c4e4-411a-b7bf-de80b666355c	ACCEPTED	4	1056	2026-06-19 00:41:01.632457+07	\N	\N	10007\n
6769	425	41	5327ee36-201a-473c-b60d-d10862568fb9	ACCEPTED	3	1016	2026-06-19 00:41:01.632453+07	\N	\N	3\n
6780	425	52	89bf91d8-20ea-42d3-8846-94a91a36517d	ACCEPTED	3	1164	2026-06-19 00:41:01.632457+07	\N	\N	100003\n
6774	425	46	5ea8baff-e4db-4d35-b1d6-5750f09160dc	ACCEPTED	6	1124	2026-06-19 00:41:01.632455+07	\N	\N	23\n
6783	425	55	41c4366f-8560-4fec-8c3e-249455744002	ACCEPTED	5	860	2026-06-19 00:41:01.632458+07	\N	\N	1000003\n
6767	425	39	71e2ef78-c950-429d-95b6-b735f2771e8f	ACCEPTED	5	1028	2026-06-19 00:41:01.632435+07	\N	\N	17\n
6777	425	49	2bf834da-01bf-4bc1-99f1-4328bbd3c4c0	ACCEPTED	5	1028	2026-06-19 00:41:01.632456+07	\N	\N	1009\n
6778	425	50	aca3bc12-fd5e-4465-88fd-2689dc78f483	ACCEPTED	5	1020	2026-06-19 00:41:01.632456+07	\N	\N	1009\n
6768	425	40	58c0310b-2f92-44f7-a490-8a17250a0ddb	ACCEPTED	8	1040	2026-06-19 00:41:01.632449+07	\N	\N	2\n
6782	425	54	6a9f3d51-ea76-48d7-a660-2bb2eebad268	ACCEPTED	6	1048	2026-06-19 00:41:01.632458+07	\N	\N	500009\n
6784	425	56	ea57d0bf-9b2a-4dc5-83b5-762672233839	ACCEPTED	4	1028	2026-06-19 00:41:01.632458+07	\N	\N	1000003\n
6785	426	9	39179f27-77e4-4604-bb49-6a03397d173d	ACCEPTED	2	1056	2026-06-19 00:42:50.891757+07	\N	\N	6\n
6786	426	10	9de96d6e-a6fd-4cae-9bfc-4b41629a2766	ACCEPTED	2	1380	2026-06-19 00:42:50.89176+07	\N	\N	7\n
6788	427	12	8ca4de86-b5dd-46c7-abea-309449dcc756	RUNTIME_ERROR	21	1076	2026-06-19 00:43:08.473343+07	\N	run: line 1:     3 Segmentation fault      (core dumped) LD_LIBRARY_PATH=/usr/local/gcc-9.2.0/lib64 ./a.out\n	\N
6787	427	11	1953e61f-0c9b-4c85-aef2-67a4fcd0dd60	RUNTIME_ERROR	13	2140	2026-06-19 00:43:08.473341+07	\N	run: line 1:     3 Segmentation fault      (core dumped) LD_LIBRARY_PATH=/usr/local/gcc-9.2.0/lib64 ./a.out\n	\N
6789	428	11	1177d1bc-27d3-4227-b008-c0c1c63390d1	RUNTIME_ERROR	14	1472	2026-06-19 00:43:17.441304+07	\N	run: line 1:     3 Segmentation fault      (core dumped) LD_LIBRARY_PATH=/usr/local/gcc-9.2.0/lib64 ./a.out\n	\N
6790	428	12	a0fc9d0a-8600-4a1c-8e40-95f8c5968c62	RUNTIME_ERROR	23	1064	2026-06-19 00:43:17.441308+07	\N	run: line 1:     3 Segmentation fault      (core dumped) LD_LIBRARY_PATH=/usr/local/gcc-9.2.0/lib64 ./a.out\n	\N
6791	429	11	b54dbe8b-80fe-4212-aa68-6272b5d4282d	RUNTIME_ERROR	19	1128	2026-06-19 00:43:19.040154+07	\N	run: line 1:     3 Segmentation fault      (core dumped) LD_LIBRARY_PATH=/usr/local/gcc-9.2.0/lib64 ./a.out\n	\N
6792	429	12	33d863ed-8668-44dc-a136-d24674ddf9e9	RUNTIME_ERROR	28	1396	2026-06-19 00:43:19.040157+07	\N	run: line 1:     3 Segmentation fault      (core dumped) LD_LIBRARY_PATH=/usr/local/gcc-9.2.0/lib64 ./a.out\n	\N
6794	430	12	0de7ff18-690d-490b-8974-e2942197f45e	RUNTIME_ERROR	6	1128	2026-06-19 00:43:20.403578+07	\N	run: line 1:     3 Segmentation fault      (core dumped) LD_LIBRARY_PATH=/usr/local/gcc-9.2.0/lib64 ./a.out\n	\N
6793	430	11	8ba1f904-2507-4633-8e74-78e837b40f03	RUNTIME_ERROR	18	1340	2026-06-19 00:43:20.403574+07	\N	run: line 1:     3 Segmentation fault      (core dumped) LD_LIBRARY_PATH=/usr/local/gcc-9.2.0/lib64 ./a.out\n	\N
6796	431	12	ce3c9560-280c-4626-893f-67c3b5d4447a	RUNTIME_ERROR	6	1168	2026-06-19 00:43:21.836148+07	\N	run: line 1:     3 Segmentation fault      (core dumped) LD_LIBRARY_PATH=/usr/local/gcc-9.2.0/lib64 ./a.out\n	\N
6795	431	11	56e2abae-e06a-49c8-8590-ed67c20e1ccd	RUNTIME_ERROR	19	1056	2026-06-19 00:43:21.836145+07	\N	run: line 1:     3 Segmentation fault      (core dumped) LD_LIBRARY_PATH=/usr/local/gcc-9.2.0/lib64 ./a.out\n	\N
6797	432	11	adb2d3eb-93ba-45c3-af7e-d76ed94c00ad	ACCEPTED	3	1036	2026-06-19 00:43:26.154767+07	\N	\N	4\n
6798	432	12	943cc8bd-9b9a-4a38-88d8-851e533fd0bd	ACCEPTED	2	1132	2026-06-19 00:43:26.154768+07	\N	\N	4\n
6805	433	45	9ac0141f-41a8-40e6-ac1a-4caf75c9f1bc	ACCEPTED	5	2120	2026-06-19 00:55:19.682612+07	\N	\N	11\n
6812	433	52	4e0bd5da-ace0-4155-a161-099d05e3758a	ACCEPTED	6	1408	2026-06-19 00:55:19.682623+07	\N	\N	100003\n
6810	433	50	1ca961a5-1c1e-4608-a47b-dc1145c3bff4	ACCEPTED	5	2532	2026-06-19 00:55:19.68262+07	\N	\N	1009\n
6807	433	47	b50d4622-6db1-4647-a665-da3a579867e6	ACCEPTED	6	2240	2026-06-19 00:55:19.682615+07	\N	\N	101\n
6801	433	41	65efc161-3299-4017-b4e1-d9b6ff7e4493	ACCEPTED	7	2260	2026-06-19 00:55:19.682606+07	\N	\N	3\n
6800	433	40	96293132-ed33-4202-b5ae-52e86c182da2	ACCEPTED	4	2700	2026-06-19 00:55:19.682603+07	\N	\N	2\n
6799	433	39	1df9318b-b3c0-4a44-98f3-952497ad3edd	ACCEPTED	5	2136	2026-06-19 00:55:19.682593+07	\N	\N	17\n
6813	433	53	78f81aa2-5a14-450e-afc6-48235da3bbad	ACCEPTED	5	5400	2026-06-19 00:55:19.682624+07	\N	\N	100003\n
6802	433	42	7a130e81-52aa-4df1-804b-86df10477628	ACCEPTED	4	2384	2026-06-19 00:55:19.682607+07	\N	\N	5\n
6814	433	54	c543880c-5bb6-424b-bc3b-9f6a1e55dabd	ACCEPTED	7	9472	2026-06-19 00:55:19.682626+07	\N	\N	500009\n
6806	433	46	5f0e410b-1a41-46a2-b17c-a453003b891a	ACCEPTED	4	1472	2026-06-19 00:55:19.682614+07	\N	\N	23\n
6816	433	56	04a45a7f-4bbb-41e2-b777-2d71281272f1	ACCEPTED	5	3288	2026-06-19 00:55:19.682628+07	\N	\N	1000003\n
6811	433	51	4a55b28d-3172-45ce-8d88-751c597a26ea	ACCEPTED	4	2640	2026-06-19 00:55:19.682621+07	\N	\N	10007\n
6803	433	43	ccdf66de-17bf-4101-9f2f-3c9067d0d8e9	ACCEPTED	4	1972	2026-06-19 00:55:19.682609+07	\N	\N	5\n
6804	433	44	bffc059f-0f02-4e39-9508-2f302d0860a3	ACCEPTED	4	2284	2026-06-19 00:55:19.68261+07	\N	\N	11\n
6815	433	55	161dfef6-3924-4067-b5db-bb118aad52fe	ACCEPTED	3	1516	2026-06-19 00:55:19.682627+07	\N	\N	1000003\n
6809	433	49	b42119a3-0d12-48f6-bf78-faa49cb778a5	ACCEPTED	3	1860	2026-06-19 00:55:19.682618+07	\N	\N	1009\n
6808	433	48	99eda953-7411-47db-a295-aac8cfbbac7e	ACCEPTED	3	2180	2026-06-19 00:55:19.682616+07	\N	\N	101\n
6818	434	10	7183aafe-488e-42f3-ac06-09371b8d611e	WRONG_ANSWER	16	4988	2026-06-19 01:05:06.2623+07	\N	\N	Hello World\n
6817	434	9	b5b6b7ff-174d-4fa2-b719-b897b115fa9d	WRONG_ANSWER	15	5340	2026-06-19 01:05:06.262284+07	\N	\N	Hello World\n
6820	435	12	9800249d-be57-4c95-bbe5-4ce662159b00	ACCEPTED	2	16900	2026-06-19 01:06:29.030452+07	\N	\N	4\n
6819	435	11	a97de91f-05c0-494a-a804-aa5e42b040e3	ACCEPTED	2	17216	2026-06-19 01:06:29.030443+07	\N	\N	4\n
7292	441	92	46eb6714-3867-4c75-9c90-aaf57db9ce2a	ACCEPTED	5	1028	2026-06-19 01:46:36.145659+07	\N	\N	-471131\n
6827	436	27	a588b268-dba1-475c-b466-d92adc66f956	ACCEPTED	6	5364	2026-06-19 01:26:44.427806+07	\N	\N	1000\n
6821	436	21	eb222e49-55b5-49fa-ac82-45644fd45e7a	ACCEPTED	5	2016	2026-06-19 01:26:44.427784+07	\N	\N	3\n
6826	436	26	4659a037-8a89-4f06-a688-068ba7e75e74	ACCEPTED	4	876	2026-06-19 01:26:44.427805+07	\N	\N	-30\n
6823	436	23	177cf9aa-b562-4dda-aff8-dfbe82bbc96c	ACCEPTED	5	2904	2026-06-19 01:26:44.4278+07	\N	\N	0\n
6824	436	24	f12aacfc-e2c6-4a91-92e4-0d1ace4d4862	ACCEPTED	4	1968	2026-06-19 01:26:44.427802+07	\N	\N	0\n
6822	436	22	a8154cd3-60a4-4258-a636-e3fa8efff94a	ACCEPTED	5	1100	2026-06-19 01:26:44.427797+07	\N	\N	30\n
7289	441	89	b12ce084-8627-4674-a20d-247d64c6b047	ACCEPTED	4	1024	2026-06-19 01:46:36.145655+07	\N	\N	-902015\n
7291	441	91	aea39465-2fef-4a96-b5d2-5b99a34c016c	ACCEPTED	4	1020	2026-06-19 01:46:36.145658+07	\N	\N	-1113725\n
6829	436	29	b6a3b902-5c83-4d46-8537-ce5b48a1d132	ACCEPTED	5	6920	2026-06-19 01:26:44.427809+07	\N	\N	99\n
6839	436	57	969889bc-a5ac-408a-89e6-732247c1f161	ACCEPTED	6	1224	2026-06-19 01:26:44.427824+07	\N	\N	787228\n
6840	436	58	97cf3479-fbc9-44c8-8802-7e443cbce08b	ACCEPTED	5	1032	2026-06-19 01:26:44.427826+07	\N	\N	803799\n
6833	436	33	dd984e00-27ce-443f-8a66-c957fb061c99	ACCEPTED	4	6996	2026-06-19 01:26:44.427815+07	\N	\N	84\n
6831	436	31	738adc76-2dd6-4d9d-a2d6-0bea089eccbc	ACCEPTED	5	1548	2026-06-19 01:26:44.427812+07	\N	\N	30000\n
6835	436	35	790ad5f1-6890-4412-b1c8-77f42a4c3b9f	ACCEPTED	4	916	2026-06-19 01:26:44.427818+07	\N	\N	-2\n
6832	436	32	df6e9390-1592-427e-9962-6519ad629ab3	ACCEPTED	5	4444	2026-06-19 01:26:44.427814+07	\N	\N	0\n
6838	436	38	116d703f-c997-4b7f-99f3-06497613e73b	ACCEPTED	5	1128	2026-06-19 01:26:44.427823+07	\N	\N	3000000\n
6830	436	30	34c05a7c-9be6-45bd-b660-d66ea571cb98	ACCEPTED	5	4132	2026-06-19 01:26:44.427811+07	\N	\N	0\n
6836	436	36	f30b3cd9-dfad-429e-8288-9f031619de0c	ACCEPTED	3	1084	2026-06-19 01:26:44.42782+07	\N	\N	801\n
6855	436	73	f8f32bf3-c794-4b22-985a-1e0620f93b1d	ACCEPTED	6	1048	2026-06-19 01:26:44.427849+07	\N	\N	702179\n
6847	436	65	c95e2dbc-a41d-481d-8e57-d7ccec2b0096	ACCEPTED	10	1036	2026-06-19 01:26:44.427837+07	\N	\N	475745\n
6849	436	67	4cefffdb-5f00-483e-8f0d-614eb319e692	ACCEPTED	6	936	2026-06-19 01:26:44.427839+07	\N	\N	473222\n
6861	436	79	fd7957d8-6e74-48a7-8740-6459ad7de6c3	ACCEPTED	8	1036	2026-06-19 01:26:44.427858+07	\N	\N	-1351853\n
6848	436	66	d514c613-e15a-46ad-afad-ce132bd8a824	ACCEPTED	7	960	2026-06-19 01:26:44.427838+07	\N	\N	129492\n
6856	436	74	3c86ac33-d1db-4b5e-81d2-e9ee04282e8e	ACCEPTED	6	1044	2026-06-19 01:26:44.42785+07	\N	\N	909595\n
6865	436	83	38bf0cbe-9a0a-4e24-8b27-4c5a1a4131dc	ACCEPTED	4	1032	2026-06-19 01:26:44.427864+07	\N	\N	-1500204\n
6864	436	82	c178bfba-dafe-4dbc-b53c-1500b799d085	ACCEPTED	5	1068	2026-06-19 01:26:44.427862+07	\N	\N	-1795574\n
6857	436	75	c2ecf8aa-e5c9-4890-b493-263011fd694b	ACCEPTED	4	1096	2026-06-19 01:26:44.427852+07	\N	\N	1760278\n
6854	436	72	2546c6e9-9c7c-4600-9637-ef22989dccbc	ACCEPTED	4	1028	2026-06-19 01:26:44.427847+07	\N	\N	1011312\n
6853	436	71	9dbd699a-73ec-4690-b2d5-15c9677437e3	ACCEPTED	4	936	2026-06-19 01:26:44.427845+07	\N	\N	1416847\n
6862	436	80	8112c805-601f-4495-b9bd-414bf7563616	ACCEPTED	5	1136	2026-06-19 01:26:44.427859+07	\N	\N	-1611196\n
6868	436	86	56130336-6839-4fcd-89d6-4884c38c9239	ACCEPTED	5	1048	2026-06-19 01:26:44.427868+07	\N	\N	-876295\n
6863	436	81	819d740a-ea5c-43f2-85a9-52f84b2b5a31	ACCEPTED	5	1040	2026-06-19 01:26:44.427861+07	\N	\N	-846475\n
6859	436	77	b7ecc680-61ea-4440-af85-ecf964cb49a8	ACCEPTED	5	916	2026-06-19 01:26:44.427855+07	\N	\N	-987624\n
6867	436	85	59f3dc7c-b9fa-48a6-b576-e335282dfa5b	ACCEPTED	4	892	2026-06-19 01:26:44.427867+07	\N	\N	-1006285\n
6845	436	63	46dba452-c063-46ae-93d9-801071a8c215	ACCEPTED	7	1000	2026-06-19 01:26:44.427834+07	\N	\N	1507378\n
6851	436	69	b62aae2e-ff79-4b4e-8ed0-a71ce25bf5c9	ACCEPTED	4	1012	2026-06-19 01:26:44.427842+07	\N	\N	616334\n
6860	436	78	3d52c819-833b-409a-adbc-e95d15d39afb	ACCEPTED	5	860	2026-06-19 01:26:44.427856+07	\N	\N	-824805\n
6850	436	68	34a13779-68a3-43ca-970a-12389acbb887	ACCEPTED	5	1004	2026-06-19 01:26:44.427841+07	\N	\N	1161167\n
6866	436	84	9a65f26c-a558-4dea-a800-232003b0a21f	ACCEPTED	4	1004	2026-06-19 01:26:44.427866+07	\N	\N	-734921\n
6846	436	64	31a92191-7440-42bd-a03a-bb197f4e90b4	ACCEPTED	4	1036	2026-06-19 01:26:44.427835+07	\N	\N	710339\n
6858	436	76	22a6c5b1-e056-44ac-8a70-8919041a181d	ACCEPTED	5	1032	2026-06-19 01:26:44.427853+07	\N	\N	802483\n
6870	436	88	0eeb20b9-3d8b-418b-a4b6-85954779bd11	ACCEPTED	6	1032	2026-06-19 01:26:44.427871+07	\N	\N	-955984\n
6874	436	92	ff0114c9-0b0a-488b-8da0-a1b15fffa7a5	ACCEPTED	5	1076	2026-06-19 01:26:44.427877+07	\N	\N	-471131\n
6869	436	87	86e63457-8a1c-4abd-9b37-4589f3a7d799	ACCEPTED	4	1020	2026-06-19 01:26:44.42787+07	\N	\N	-1189260\n
6877	436	95	e85b7e1c-3b18-4662-87ab-38841c80cfbf	ACCEPTED	4	1040	2026-06-19 01:26:44.427881+07	\N	\N	-1192974\n
6878	436	96	be92e61a-d263-4564-b82d-e7e962aa1695	ACCEPTED	4	880	2026-06-19 01:26:44.427883+07	\N	\N	-1188270\n
6886	436	104	d6861b18-5279-4bfb-9828-58a6bca650cb	ACCEPTED	5	988	2026-06-19 01:26:44.427894+07	\N	\N	514364\n
6872	436	90	fda0bac2-64fc-4acf-8ca3-5d0f57e800c0	ACCEPTED	5	1036	2026-06-19 01:26:44.427874+07	\N	\N	-1520451\n
6885	436	103	478c1cf9-d0b9-4fc3-9770-f6f72dc6fb47	ACCEPTED	4	1000	2026-06-19 01:26:44.427893+07	\N	\N	283996\n
6891	436	109	9a73c2b2-8dd4-4a33-add3-d402838079ef	ACCEPTED	4	1032	2026-06-19 01:26:44.427901+07	\N	\N	792531\n
6881	436	99	b45dba53-9801-4587-ba09-ba8237944a12	ACCEPTED	5	888	2026-06-19 01:26:44.427887+07	\N	\N	-1225775\n
6883	436	101	9b623bff-48fa-4287-8d75-604d645aee4a	ACCEPTED	4	872	2026-06-19 01:26:44.42789+07	\N	\N	28962\n
6876	436	94	833dadc8-e794-4f0f-9971-5454d1308e05	ACCEPTED	4	1028	2026-06-19 01:26:44.42788+07	\N	\N	-717234\n
6882	436	100	f19b3483-1258-4614-8b98-ef75b80253eb	ACCEPTED	4	1024	2026-06-19 01:26:44.427889+07	\N	\N	281928\n
6890	436	108	ed4a2b5c-fd7d-4976-a023-849ea8c2fcf6	ACCEPTED	7	976	2026-06-19 01:26:44.4279+07	\N	\N	1436130\n
6892	436	110	fd6a1024-9898-4726-95bf-258e37cd3f4d	ACCEPTED	5	880	2026-06-19 01:26:44.427903+07	\N	\N	-572819\n
6879	436	97	bab6b514-141f-473a-ab98-d1123fc68cec	ACCEPTED	6	1020	2026-06-19 01:26:44.427884+07	\N	\N	-517131\n
6884	436	102	f8bede86-9e05-4ea7-87d4-adaaa088058f	ACCEPTED	6	868	2026-06-19 01:26:44.427892+07	\N	\N	-619866\n
6889	436	107	ae79dca8-abc0-4c6d-b1de-50844f9c21ed	ACCEPTED	5	1080	2026-06-19 01:26:44.427899+07	\N	\N	-34648\n
6887	436	105	dcb5bb84-6fbc-4a9c-baa6-da9abbf90ec5	ACCEPTED	7	1092	2026-06-19 01:26:44.427896+07	\N	\N	-882565\n
6896	436	114	b1ba97c7-5f51-486d-b032-950025bff289	ACCEPTED	5	872	2026-06-19 01:26:44.427909+07	\N	\N	-234796\n
6895	436	113	f81fa1e9-0bfd-4407-a999-52bdfd642014	ACCEPTED	5	972	2026-06-19 01:26:44.427907+07	\N	\N	-1143916\n
6894	436	112	67c221f6-77fa-4b14-a840-293ef7dff544	ACCEPTED	5	1020	2026-06-19 01:26:44.427906+07	\N	\N	649261\n
6893	436	111	7f74f549-7463-4391-bc28-b15d0114c648	ACCEPTED	4	868	2026-06-19 01:26:44.427904+07	\N	\N	-309452\n
6844	436	62	607cf694-cce5-4f92-9c70-36aef16cc053	ACCEPTED	5	1040	2026-06-19 01:26:44.427832+07	\N	\N	1486218\n
6843	436	61	01c2846c-8874-4a76-8bb1-06b51b7193cb	ACCEPTED	6	1028	2026-06-19 01:26:44.42783+07	\N	\N	879721\n
6842	436	60	e52345ae-4c69-4aa2-891a-b6a6deec5f3d	ACCEPTED	5	3376	2026-06-19 01:26:44.427829+07	\N	\N	380371\n
6841	436	59	82f6b0f5-463c-40ae-b337-69add92fd876	ACCEPTED	5	1264	2026-06-19 01:26:44.427828+07	\N	\N	545178\n
6834	436	34	c18dc854-873f-4d34-abd1-f4ba4c9e5a91	ACCEPTED	5	1608	2026-06-19 01:26:44.427816+07	\N	\N	15\n
6825	436	25	be584387-ca23-405f-87c2-fc504b52499b	ACCEPTED	4	880	2026-06-19 01:26:44.427803+07	\N	\N	300\n
6837	436	37	00a48b19-c13f-424f-b502-bd8f09a2af97	ACCEPTED	4	1028	2026-06-19 01:26:44.427821+07	\N	\N	1000\n
6828	436	28	f3006206-f45f-4cd7-83bc-560b850c1c98	ACCEPTED	4	912	2026-06-19 01:26:44.427808+07	\N	\N	579\n
6852	436	70	edb49d10-d941-4a90-b4aa-320216a71199	ACCEPTED	6	1032	2026-06-19 01:26:44.427844+07	\N	\N	959298\n
6873	436	91	b2e3418a-88b3-4f5e-b689-59d81eacdf5b	ACCEPTED	5	1036	2026-06-19 01:26:44.427876+07	\N	\N	-1113725\n
6875	436	93	e3706169-1fda-45b3-813c-c2ccbe356645	ACCEPTED	5	1048	2026-06-19 01:26:44.427879+07	\N	\N	-422973\n
6871	436	89	e01834ff-58ca-4fed-8f46-065231e6b87c	ACCEPTED	4	876	2026-06-19 01:26:44.427873+07	\N	\N	-902015\n
6880	436	98	e193f14f-cf9f-419d-865c-767431a2726e	ACCEPTED	4	1088	2026-06-19 01:26:44.427885+07	\N	\N	99178\n
6888	436	106	4938300a-03d5-4340-a0de-e06a09ed0e32	ACCEPTED	7	1000	2026-06-19 01:26:44.427897+07	\N	\N	-815576\n
6900	436	118	072a0216-ac87-4297-8883-0a6949fda0a3	ACCEPTED	5	1100	2026-06-19 01:26:44.427914+07	\N	\N	636465324\n
6903	436	121	6233a93d-d5b0-4c45-ad3d-89313b0c0adb	ACCEPTED	6	1036	2026-06-19 01:26:44.427919+07	\N	\N	1259817393\n
6908	436	126	7d7e5f64-0b40-499e-ab32-f1483bd6a60f	ACCEPTED	4	892	2026-06-19 01:26:44.427926+07	\N	\N	-882105735\n
6897	436	115	58d9f94f-48f5-498f-9afa-e85090e760c8	ACCEPTED	5	1048	2026-06-19 01:26:44.42791+07	\N	\N	506806\n
6898	436	116	07fa3bbe-a220-4586-b194-0f4b9b4459fa	ACCEPTED	4	1044	2026-06-19 01:26:44.427912+07	\N	\N	785356\n
6910	436	128	830a9a39-0669-4dc6-8b9c-d8df3f8c734f	ACCEPTED	6	996	2026-06-19 01:26:44.427938+07	\N	\N	82\n
6906	436	124	2aca4ca3-d035-43f2-8d76-148389c6f76a	ACCEPTED	5	880	2026-06-19 01:26:44.427923+07	\N	\N	1610593689\n
6907	436	125	c4edc8c6-083c-48f8-ac82-617d94aaa5a2	ACCEPTED	5	1036	2026-06-19 01:26:44.427924+07	\N	\N	86961293\n
6902	436	120	25f1cbcf-4ed4-471e-804e-af6dc418e29c	ACCEPTED	4	888	2026-06-19 01:26:44.427917+07	\N	\N	371467497\n
6909	436	127	f16e08e5-76f7-46d0-a7f6-4805042eec51	ACCEPTED	5	1116	2026-06-19 01:26:44.427937+07	\N	\N	0\n
6912	436	130	a2e64a5f-7645-4aca-bc49-b9336eff8918	ACCEPTED	6	896	2026-06-19 01:26:44.427941+07	\N	\N	-5\n
6901	436	119	b546049c-9e9b-44d9-a4ab-b51890a7a34c	ACCEPTED	6	880	2026-06-19 01:26:44.427916+07	\N	\N	-738231997\n
6911	436	129	34fdaf9e-ca3f-4554-a9f8-5064e0e1b279	ACCEPTED	6	988	2026-06-19 01:26:44.42794+07	\N	\N	-32\n
6913	436	131	f3965b97-81dd-407b-98b4-54267701e8f8	ACCEPTED	5	1000	2026-06-19 01:26:44.427943+07	\N	\N	71\n
6904	436	122	8950ec90-7a59-4a9c-b63e-65744145ea1c	ACCEPTED	5	880	2026-06-19 01:26:44.42792+07	\N	\N	-457820119\n
6905	436	123	76122f5a-31c0-4f82-9391-125558d55186	ACCEPTED	4	880	2026-06-19 01:26:44.427921+07	\N	\N	1422690276\n
6899	436	117	7d51432b-d5aa-4fb9-8acc-9aa349450db7	ACCEPTED	6	1028	2026-06-19 01:26:44.427913+07	\N	\N	362210245\n
6916	436	134	663f0025-c398-42a9-9ea1-e7e4564d12f9	ACCEPTED	4	880	2026-06-19 01:26:44.427947+07	\N	\N	158\n
6914	436	132	b312d5fd-ba33-4485-a400-3756d422e384	ACCEPTED	5	1072	2026-06-19 01:26:44.427944+07	\N	\N	-1\n
6915	436	133	02c486d4-d69d-4e72-9810-182c490285f3	ACCEPTED	3	1052	2026-06-19 01:26:44.427945+07	\N	\N	-57\n
6919	436	137	31ebeae2-b296-479c-adef-1cad82e94e71	ACCEPTED	2	1052	2026-06-19 01:26:44.427951+07	\N	\N	64\n
6917	436	135	e6fb912b-d86d-457e-bbb5-7de0a9988454	ACCEPTED	2	1056	2026-06-19 01:26:44.427948+07	\N	\N	3\n
6918	436	136	405253bf-0b44-4b00-b478-a9c7d31e9f6e	ACCEPTED	2	1048	2026-06-19 01:26:44.42795+07	\N	\N	129\n
6920	436	138	346614bd-ad61-4d10-8ea2-a09bdde99c97	ACCEPTED	4	1124	2026-06-19 01:26:44.427952+07	\N	\N	51\n
7299	441	99	e682eaab-79e0-4848-8761-f3365cca75e9	ACCEPTED	4	868	2026-06-19 01:46:36.145669+07	\N	\N	-1225775\n
6927	437	27	6c852390-d4fa-458f-932f-ab2e22a35272	ACCEPTED	6	988	2026-06-19 01:29:38.003137+07	\N	\N	1000\n
6923	437	23	cb921210-968c-4162-9ab8-18e81d98ebc8	ACCEPTED	6	1024	2026-06-19 01:29:38.003128+07	\N	\N	0\n
6925	437	25	bfa08a37-3783-4cb0-81d3-dd20279f8823	ACCEPTED	5	996	2026-06-19 01:29:38.003133+07	\N	\N	300\n
6926	437	26	b3a96157-b7da-49c5-a1b7-8429dbf4cdf3	ACCEPTED	7	1084	2026-06-19 01:29:38.003135+07	\N	\N	-30\n
6933	437	33	1d28794c-0a7a-4426-a280-20abc234faea	ACCEPTED	12	832	2026-06-19 01:29:38.003149+07	\N	\N	84\n
6931	437	31	46645eb7-1125-4f8a-9e32-421ccca344f4	ACCEPTED	5	1024	2026-06-19 01:29:38.003145+07	\N	\N	30000\n
6929	437	29	9e0a3cc5-652b-46b2-b65d-421733805e1d	ACCEPTED	6	868	2026-06-19 01:29:38.003141+07	\N	\N	99\n
6935	437	35	6e908638-1ba1-4bc7-908c-7d1061a9a002	ACCEPTED	7	872	2026-06-19 01:29:38.003153+07	\N	\N	-2\n
6941	437	59	4c3c10ba-574a-4fbc-8f19-7f3380dc234d	ACCEPTED	5	1192	2026-06-19 01:29:38.003165+07	\N	\N	545178\n
6922	437	22	773d54bf-acea-4d7f-b324-3eb04eddfe56	ACCEPTED	6	1016	2026-06-19 01:29:38.003126+07	\N	\N	30\n
6934	437	34	14fd2533-a9ad-4890-9c98-9faafb135310	ACCEPTED	8	976	2026-06-19 01:29:38.003151+07	\N	\N	15\n
6924	437	24	1d220e59-52c4-435e-87fe-fb6ea73ba9e2	ACCEPTED	8	872	2026-06-19 01:29:38.003131+07	\N	\N	0\n
6921	437	21	17d24d8d-2171-4ffb-bf78-50f26c738585	ACCEPTED	9	1136	2026-06-19 01:29:38.003121+07	\N	\N	3\n
6937	437	37	ad1ca529-5f37-473c-979b-cfc4846fcef8	ACCEPTED	6	1092	2026-06-19 01:29:38.003157+07	\N	\N	1000\n
6928	437	28	c2725fb8-e604-47bf-9e9e-e39058e6631c	ACCEPTED	6	1020	2026-06-19 01:29:38.003139+07	\N	\N	579\n
6930	437	30	b5e3244f-198f-498c-b666-da0d0f9cb9bf	ACCEPTED	5	864	2026-06-19 01:29:38.003143+07	\N	\N	0\n
6932	437	32	4d3030e9-18ab-4d7f-9b18-df0b23519041	ACCEPTED	4	1016	2026-06-19 01:29:38.003147+07	\N	\N	0\n
6936	437	36	0041e197-9509-4285-8cb3-d17e9319b160	ACCEPTED	5	1024	2026-06-19 01:29:38.003155+07	\N	\N	801\n
6940	437	58	a2321b42-1379-4025-a111-0e727bd59992	ACCEPTED	5	1092	2026-06-19 01:29:38.003163+07	\N	\N	803799\n
6939	437	57	21fef8d7-929f-4b77-bb24-3188e43c6dfb	ACCEPTED	7	980	2026-06-19 01:29:38.003161+07	\N	\N	787228\n
7293	441	93	afe92cc2-8f5f-4849-a5cd-d8330b54cf8b	ACCEPTED	5	1088	2026-06-19 01:46:36.14566+07	\N	\N	-422973\n
6942	437	60	abdb5378-29ee-41d5-a117-99e7089f3444	ACCEPTED	6	876	2026-06-19 01:29:38.003167+07	\N	\N	380371\n
6944	437	62	7f997d86-0d3b-40b0-99cc-4947600d3987	ACCEPTED	5	1028	2026-06-19 01:29:38.003171+07	\N	\N	1486218\n
6946	437	64	63902547-fd58-4710-8c08-1e7a0cf887e3	ACCEPTED	6	1024	2026-06-19 01:29:38.003175+07	\N	\N	710339\n
6947	437	65	da783adc-fdb9-4291-ab11-af586b51f18e	ACCEPTED	5	1028	2026-06-19 01:29:38.003177+07	\N	\N	475745\n
6951	437	69	d8251e1a-7b71-49b4-bde2-90eadc69e86e	ACCEPTED	6	832	2026-06-19 01:29:38.003196+07	\N	\N	616334\n
6948	437	66	08b38c88-aa42-4f1f-a35c-d37c6dca91e6	ACCEPTED	4	832	2026-06-19 01:29:38.00319+07	\N	\N	129492\n
6954	437	72	a043fa18-140a-4377-88c9-a55bde972485	ACCEPTED	8	840	2026-06-19 01:29:38.003202+07	\N	\N	1011312\n
6956	437	74	8e34afcd-2067-4b42-86c7-70b4c72a820f	ACCEPTED	5	1028	2026-06-19 01:29:38.003206+07	\N	\N	909595\n
6963	437	81	2f47a969-8bbe-4181-b9c0-6544b8979c21	ACCEPTED	5	1024	2026-06-19 01:29:38.003219+07	\N	\N	-846475\n
6965	437	83	6f6df1d0-243b-4dc9-8bc9-c62ecf8c4915	ACCEPTED	4	1036	2026-06-19 01:29:38.003225+07	\N	\N	-1500204\n
6959	437	77	2a891d01-13bc-4163-bf12-672d7694c7a5	ACCEPTED	5	1008	2026-06-19 01:29:38.003212+07	\N	\N	-987624\n
6962	437	80	e6a11bc5-a440-4edb-bc02-366708d7129d	ACCEPTED	6	1012	2026-06-19 01:29:38.003217+07	\N	\N	-1611196\n
6961	437	79	4bc9346a-1e95-4197-bf76-98866b2f7ae0	ACCEPTED	5	880	2026-06-19 01:29:38.003216+07	\N	\N	-1351853\n
6966	437	84	92f8f510-1541-4da3-973f-a19068d4fe16	ACCEPTED	4	984	2026-06-19 01:29:38.003227+07	\N	\N	-734921\n
6960	437	78	a0169ceb-726e-4286-8bf6-3dbc385a13d6	ACCEPTED	10	1084	2026-06-19 01:29:38.003214+07	\N	\N	-824805\n
6955	437	73	98de7fc9-5cbf-46b3-b5e6-2d0614174971	ACCEPTED	7	1100	2026-06-19 01:29:38.003204+07	\N	\N	702179\n
6950	437	68	29ff7572-c9a2-4ab9-81f7-3b73ffa7a637	ACCEPTED	7	988	2026-06-19 01:29:38.003194+07	\N	\N	1161167\n
6967	437	85	1669eb18-c6ac-458f-9f10-945a0adc5028	ACCEPTED	4	1016	2026-06-19 01:29:38.003229+07	\N	\N	-1006285\n
6952	437	70	c9131f45-b6f5-4651-b50b-58e4f944bdff	ACCEPTED	5	1092	2026-06-19 01:29:38.003198+07	\N	\N	959298\n
6953	437	71	df51bddc-673c-4052-98fd-19de073ff776	ACCEPTED	12	924	2026-06-19 01:29:38.0032+07	\N	\N	1416847\n
6958	437	76	ac5f08a2-2729-4eac-b7cc-06051a8e9ce0	ACCEPTED	5	1024	2026-06-19 01:29:38.00321+07	\N	\N	802483\n
6969	437	87	b5278756-a2a8-4a11-a5b5-9dec737447ca	ACCEPTED	14	880	2026-06-19 01:29:38.003233+07	\N	\N	-1189260\n
6971	437	89	bba91651-b5ee-44ae-83a9-88fb15480867	ACCEPTED	5	1032	2026-06-19 01:29:38.003239+07	\N	\N	-902015\n
6973	437	91	67945035-0865-4e4e-9726-9d4f2ab02640	ACCEPTED	6	984	2026-06-19 01:29:38.003243+07	\N	\N	-1113725\n
6979	437	97	ef0cbe92-e096-469f-8faf-351f819ce668	ACCEPTED	7	1000	2026-06-19 01:29:38.003258+07	\N	\N	-517131\n
6970	437	88	1e73ef91-38df-4585-afdf-582c6a16aaf4	ACCEPTED	5	1024	2026-06-19 01:29:38.003236+07	\N	\N	-955984\n
6975	437	93	9b57bfc7-c24d-45a8-9911-e8f487900936	ACCEPTED	7	992	2026-06-19 01:29:38.00325+07	\N	\N	-422973\n
6972	437	90	8126310f-5074-4f79-a187-6c81c7ca4c13	ACCEPTED	8	1004	2026-06-19 01:29:38.003241+07	\N	\N	-1520451\n
6978	437	96	07d5f848-5713-49cc-9369-9ec1a8bac240	ACCEPTED	4	872	2026-06-19 01:29:38.003256+07	\N	\N	-1188270\n
6977	437	95	919aa9c6-9c40-4e95-85dc-df878912da7b	ACCEPTED	5	880	2026-06-19 01:29:38.003254+07	\N	\N	-1192974\n
6974	437	92	4eae53d5-bd91-410a-97f6-83d9d6c4e5b6	ACCEPTED	6	1092	2026-06-19 01:29:38.003247+07	\N	\N	-471131\n
6983	437	101	e0b9ad42-d2f4-4227-87c1-d38f9f81098a	ACCEPTED	15	996	2026-06-19 01:29:38.003265+07	\N	\N	28962\n
6980	437	98	2d9a2c04-3a59-4af2-b9d6-18f01fc77882	ACCEPTED	6	992	2026-06-19 01:29:38.00326+07	\N	\N	99178\n
6987	437	105	b471021f-d779-47e4-952c-985d98b76cf6	ACCEPTED	5	1088	2026-06-19 01:29:38.003273+07	\N	\N	-882565\n
6986	437	104	a7b62c6c-5d39-4fab-ac9b-9af795dde38c	ACCEPTED	4	1052	2026-06-19 01:29:38.003271+07	\N	\N	514364\n
6984	437	102	6f3a8c5a-dd8b-4752-870e-5c3486623ea7	ACCEPTED	4	1268	2026-06-19 01:29:38.003267+07	\N	\N	-619866\n
6988	437	106	ae460ff3-4c5a-4a06-bb0f-4fbcd6d3f215	ACCEPTED	7	1024	2026-06-19 01:29:38.003275+07	\N	\N	-815576\n
6990	437	108	2f7fcc07-1d9a-4078-af9d-499c277489d7	ACCEPTED	4	1020	2026-06-19 01:29:38.003279+07	\N	\N	1436130\n
6992	437	110	92985f0e-4dc8-491e-80c2-06bcf33a9347	ACCEPTED	4	1032	2026-06-19 01:29:38.003283+07	\N	\N	-572819\n
6991	437	109	79741212-51e8-4635-9b84-5f03888fb30e	ACCEPTED	5	1028	2026-06-19 01:29:38.003281+07	\N	\N	792531\n
6993	437	111	03d9854e-2c9e-4cea-8e70-b7319b063c57	ACCEPTED	4	868	2026-06-19 01:29:38.003285+07	\N	\N	-309452\n
6994	437	112	1f234c75-725c-4b0e-be4b-977c93d37762	ACCEPTED	6	876	2026-06-19 01:29:38.003287+07	\N	\N	649261\n
6995	437	113	c63e90f8-5e15-4856-8b8f-ceb345553cf8	ACCEPTED	5	1016	2026-06-19 01:29:38.003289+07	\N	\N	-1143916\n
7000	437	118	947c421e-f668-4077-a8db-a32f17ec38ac	ACCEPTED	7	988	2026-06-19 01:29:38.003299+07	\N	\N	636465324\n
7005	437	123	13a4e2c2-f11a-437e-8fd6-9ece3d95a37f	ACCEPTED	5	888	2026-06-19 01:29:38.003308+07	\N	\N	1422690276\n
7003	437	121	d4ba543c-7838-4203-947e-0b1327a0d082	ACCEPTED	5	1088	2026-06-19 01:29:38.003305+07	\N	\N	1259817393\n
7008	437	126	baa0800f-0302-47db-be69-a28d1dba3fdb	ACCEPTED	6	928	2026-06-19 01:29:38.003314+07	\N	\N	-882105735\n
7006	437	124	01110a09-aef3-4ad0-8581-b836cd1a909b	ACCEPTED	4	1096	2026-06-19 01:29:38.00331+07	\N	\N	1610593689\n
7001	437	119	57636701-0637-4c02-a1aa-9ee42964d081	ACCEPTED	5	1012	2026-06-19 01:29:38.003301+07	\N	\N	-738231997\n
7011	437	129	84856603-5e4d-469c-9219-58e021239b6a	ACCEPTED	7	1028	2026-06-19 01:29:38.00332+07	\N	\N	-32\n
6998	437	116	22f0d1f4-8458-4fd5-b7ba-7cd676dd7d64	ACCEPTED	5	880	2026-06-19 01:29:38.003295+07	\N	\N	785356\n
7010	437	128	c75e6b64-e10b-4d2a-ac0a-8ddd34b5613d	ACCEPTED	5	1016	2026-06-19 01:29:38.003318+07	\N	\N	82\n
7009	437	127	7b7d3042-674a-445f-beb3-5465389a52f6	ACCEPTED	5	1024	2026-06-19 01:29:38.003316+07	\N	\N	0\n
7002	437	120	eafde32f-031e-4ae8-9164-b32f013011c5	ACCEPTED	8	1008	2026-06-19 01:29:38.003302+07	\N	\N	371467497\n
7007	437	125	c735e818-0689-45a4-849d-d43c350eb818	ACCEPTED	4	1020	2026-06-19 01:29:38.003312+07	\N	\N	86961293\n
6997	437	115	28fe37a2-af73-4561-bbae-628a47da913f	ACCEPTED	4	1152	2026-06-19 01:29:38.003293+07	\N	\N	506806\n
6943	437	61	224a8f96-50d8-4f27-8870-d6f6232b9c54	ACCEPTED	6	876	2026-06-19 01:29:38.003169+07	\N	\N	879721\n
6938	437	38	3fdbccba-10eb-484c-accf-8b3608e1a144	ACCEPTED	5	1020	2026-06-19 01:29:38.003159+07	\N	\N	3000000\n
6945	437	63	1971e4df-29e8-41a0-8c5b-d371ffd242c7	ACCEPTED	7	980	2026-06-19 01:29:38.003173+07	\N	\N	1507378\n
6949	437	67	66a86578-ad2e-4c69-b297-634a07913fdf	ACCEPTED	5	868	2026-06-19 01:29:38.003192+07	\N	\N	473222\n
6968	437	86	16cb0d23-21c6-4f23-b2df-331bba973ca4	ACCEPTED	4	1016	2026-06-19 01:29:38.003231+07	\N	\N	-876295\n
6957	437	75	133d2e72-1086-4b2f-a0b2-54234dfa092e	ACCEPTED	5	1044	2026-06-19 01:29:38.003208+07	\N	\N	1760278\n
6964	437	82	6b36d176-097a-4b3b-a304-b95df8125582	ACCEPTED	4	1024	2026-06-19 01:29:38.003223+07	\N	\N	-1795574\n
6976	437	94	7a174145-ea0c-4a97-bc68-bbda9239ec1a	ACCEPTED	7	868	2026-06-19 01:29:38.003252+07	\N	\N	-717234\n
6985	437	103	b0fdd95d-400d-40c8-9cd8-13aef91a5e95	ACCEPTED	6	1068	2026-06-19 01:29:38.003269+07	\N	\N	283996\n
6982	437	100	12002081-2c64-4689-a865-716649889c85	ACCEPTED	5	1064	2026-06-19 01:29:38.003264+07	\N	\N	281928\n
6989	437	107	79c9f325-2e98-467d-a799-51af33e7c943	ACCEPTED	5	868	2026-06-19 01:29:38.003277+07	\N	\N	-34648\n
6981	437	99	fb725522-3b94-4c46-8562-e830a7e4763c	ACCEPTED	5	868	2026-06-19 01:29:38.003262+07	\N	\N	-1225775\n
6999	437	117	da7052ba-ffde-4af5-bb72-65ec7b28ef15	ACCEPTED	5	868	2026-06-19 01:29:38.003297+07	\N	\N	362210245\n
7004	437	122	366340c6-3862-4dc7-b009-befe979ad9af	ACCEPTED	7	1020	2026-06-19 01:29:38.003307+07	\N	\N	-457820119\n
7012	437	130	8937fb57-5fd2-450e-a408-7e01c49384c5	ACCEPTED	5	1028	2026-06-19 01:29:38.003322+07	\N	\N	-5\n
6996	437	114	f35ef68f-92fa-4f27-b546-67b3021e4785	ACCEPTED	5	1024	2026-06-19 01:29:38.003291+07	\N	\N	-234796\n
7013	437	131	9cd7a8a3-4d6d-45c7-ae6f-d8da38027053	ACCEPTED	4	1016	2026-06-19 01:29:38.003324+07	\N	\N	71\n
7015	437	133	1fadfd1a-3d0c-4662-8da8-a93277fcab95	ACCEPTED	4	1020	2026-06-19 01:29:38.003328+07	\N	\N	-57\n
7014	437	132	687cb378-446d-4e5e-b9ac-f40358addf1c	ACCEPTED	4	1184	2026-06-19 01:29:38.003326+07	\N	\N	-1\n
7016	437	134	a1ac9545-a3bb-49b2-93e7-b76f89787a00	ACCEPTED	5	1024	2026-06-19 01:29:38.00333+07	\N	\N	158\n
7017	437	135	1c1820d0-4e65-418a-be7e-22fb4ea4f425	ACCEPTED	3	1056	2026-06-19 01:29:38.003332+07	\N	\N	3\n
7019	437	137	8da73bc8-b032-4f39-8ef9-ed9f418b7eee	ACCEPTED	4	1028	2026-06-19 01:29:38.003336+07	\N	\N	64\n
7018	437	136	debbc83a-b816-4034-b327-af347a8bcd79	ACCEPTED	3	1060	2026-06-19 01:29:38.003334+07	\N	\N	129\n
7020	437	138	70399968-b36a-4219-8c5d-1438064fd4ff	ACCEPTED	3	1232	2026-06-19 01:29:38.003337+07	\N	\N	51\n
7024	438	42	e3ece635-7c75-4276-b9c5-51dfa66b62d9	WRONG_ANSWER	27	3316	2026-06-19 01:30:09.109459+07	\N	\N	Hello World\n
7027	438	45	5bd548d2-461f-4ae1-b779-d22565d6d5f1	WRONG_ANSWER	31	3556	2026-06-19 01:30:09.109464+07	\N	\N	Hello World\n
7031	438	49	dffa4aca-12d9-4295-9e63-48d318ae6d9d	WRONG_ANSWER	24	3360	2026-06-19 01:30:09.10947+07	\N	\N	Hello World\n
7026	438	44	d38cff6e-24fa-43fb-8aca-53e084bbc13c	WRONG_ANSWER	32	5108	2026-06-19 01:30:09.109462+07	\N	\N	Hello World\n
7021	438	39	73467e28-dffb-4dc7-8c01-e176ce715a33	WRONG_ANSWER	33	4752	2026-06-19 01:30:09.109448+07	\N	\N	Hello World\n
7029	438	47	13003d1c-1470-4362-8509-8de4a3a14a35	WRONG_ANSWER	21	3388	2026-06-19 01:30:09.109467+07	\N	\N	Hello World\n
7033	438	51	ed2b0d70-fa69-4d4e-b018-9afd0227f6db	WRONG_ANSWER	24	3364	2026-06-19 01:30:09.109474+07	\N	\N	Hello World\n
7023	438	41	41b38d32-ec96-4535-b060-6b9062839f8a	WRONG_ANSWER	22	3216	2026-06-19 01:30:09.109457+07	\N	\N	Hello World\n
7022	438	40	68461523-4d6e-4c4f-b1fe-4fdc7c975540	WRONG_ANSWER	23	3552	2026-06-19 01:30:09.109455+07	\N	\N	Hello World\n
7025	438	43	8aab8550-287c-4446-8cbc-69aadf104953	WRONG_ANSWER	26	3304	2026-06-19 01:30:09.10946+07	\N	\N	Hello World\n
7028	438	46	0b8260f3-dcb5-4273-b254-98e96a005b35	WRONG_ANSWER	22	3224	2026-06-19 01:30:09.109466+07	\N	\N	Hello World\n
7032	438	50	9e1e1072-056f-4750-859f-6fb0301247e0	WRONG_ANSWER	20	3364	2026-06-19 01:30:09.109472+07	\N	\N	Hello World\n
7030	438	48	891abe55-2ec6-4b51-bd5d-386dded87053	WRONG_ANSWER	24	3248	2026-06-19 01:30:09.109469+07	\N	\N	Hello World\n
7037	438	55	2b8c8363-4c4a-41c5-9202-ae521cd5b142	WRONG_ANSWER	20	3236	2026-06-19 01:30:09.10948+07	\N	\N	Hello World\n
7034	438	52	26e62c14-1b66-4071-b80c-f80e466afc6d	WRONG_ANSWER	22	3336	2026-06-19 01:30:09.109475+07	\N	\N	Hello World\n
7036	438	54	f9f6d63d-49ce-49de-b069-88af7be4376d	WRONG_ANSWER	18	3308	2026-06-19 01:30:09.109478+07	\N	\N	Hello World\n
7035	438	53	95ca2dfc-8e74-4098-9c00-b43b643981ca	WRONG_ANSWER	18	3312	2026-06-19 01:30:09.109477+07	\N	\N	Hello World\n
7038	438	56	fa563f80-8913-4ed8-84e8-feb74000b31e	WRONG_ANSWER	21	3308	2026-06-19 01:30:09.109481+07	\N	\N	Hello World\n
7042	439	24	4b0017a0-03cd-4fc3-a2b2-55cc6ce9077f	ACCEPTED	6	1012	2026-06-19 01:31:15.766699+07	\N	\N	0\n
7043	439	25	371f96a5-ad78-4d41-b1d3-ea207836f52e	ACCEPTED	5	1032	2026-06-19 01:31:15.766701+07	\N	\N	300\n
7049	439	31	52d7b2a9-5e94-4ef3-adfc-1ecef4bb14e3	ACCEPTED	11	1016	2026-06-19 01:31:15.766707+07	\N	\N	30000\n
7051	439	33	7698682c-791d-4825-a2bc-d87c4618ae0b	ACCEPTED	6	868	2026-06-19 01:31:15.766709+07	\N	\N	84\n
7045	439	27	1d47ea49-4272-455d-a4f7-4ef5fd501c93	ACCEPTED	8	1028	2026-06-19 01:31:15.766703+07	\N	\N	1000\n
7053	439	35	d88deaae-8c79-4421-9883-e072d8eadbd6	ACCEPTED	8	864	2026-06-19 01:31:15.766711+07	\N	\N	-2\n
7048	439	30	2de7a82e-d5a0-4a58-8b3c-6a1bf004a9d6	ACCEPTED	5	1080	2026-06-19 01:31:15.766706+07	\N	\N	0\n
7047	439	29	aa3db385-e382-4eff-b505-13df005a67d9	ACCEPTED	8	976	2026-06-19 01:31:15.766705+07	\N	\N	99\n
7052	439	34	baa49251-ada2-4f11-b4f7-8ec02e620ce4	ACCEPTED	6	872	2026-06-19 01:31:15.76671+07	\N	\N	15\n
7039	439	21	ea3f98fd-7836-49e8-a325-ed1293904551	ACCEPTED	5	1024	2026-06-19 01:31:15.766692+07	\N	\N	3\n
7040	439	22	3d3a8069-4ccd-4d4d-bb98-4eedae5973b2	ACCEPTED	4	1028	2026-06-19 01:31:15.766697+07	\N	\N	30\n
7044	439	26	4b7b3f48-a21c-4c75-a670-b058759002d8	ACCEPTED	6	992	2026-06-19 01:31:15.766702+07	\N	\N	-30\n
7041	439	23	00788205-5007-4918-a16f-80d358ba2111	ACCEPTED	6	1040	2026-06-19 01:31:15.766698+07	\N	\N	0\n
7054	439	36	e59f4a9e-8939-4a4e-8b74-0fd6a5fac1f8	ACCEPTED	8	856	2026-06-19 01:31:15.766712+07	\N	\N	801\n
7050	439	32	775ca09d-46c8-49cd-bcf8-25e1067aafe4	ACCEPTED	5	1024	2026-06-19 01:31:15.766708+07	\N	\N	0\n
7046	439	28	b5a36c9f-4f15-4d65-a34f-d50660fb75c6	ACCEPTED	5	868	2026-06-19 01:31:15.766704+07	\N	\N	579\n
7297	441	97	a1c7d65c-e521-4ce6-9561-33087560fb06	ACCEPTED	5	864	2026-06-19 01:46:36.145666+07	\N	\N	-517131\n
7062	439	62	a0114775-6cda-4dd4-924f-d4a62bec7384	ACCEPTED	5	868	2026-06-19 01:31:15.76672+07	\N	\N	1486218\n
7060	439	60	13152bee-fadd-4d43-bd07-f18ccbb39493	ACCEPTED	4	1012	2026-06-19 01:31:15.766717+07	\N	\N	380371\n
7056	439	38	7092d922-5c68-476d-86fc-9ee5fe9cf0d3	ACCEPTED	9	1032	2026-06-19 01:31:15.766714+07	\N	\N	3000000\n
7058	439	58	0be2a0ba-ada3-4e49-8783-cfcf92973b2d	ACCEPTED	5	1112	2026-06-19 01:31:15.766716+07	\N	\N	803799\n
7055	439	37	7e2f2517-c750-4428-aacb-38e0f7b9eccf	ACCEPTED	6	1024	2026-06-19 01:31:15.766713+07	\N	\N	1000\n
7059	439	59	53fca081-bcde-4687-ae81-100b8101822a	ACCEPTED	6	1036	2026-06-19 01:31:15.766717+07	\N	\N	545178\n
7064	439	64	984c94b8-147c-4c54-be89-7aeffaed13e7	ACCEPTED	9	876	2026-06-19 01:31:15.766722+07	\N	\N	710339\n
7063	439	63	28cc2efb-d3f7-438a-b3ea-c897710d0ce3	ACCEPTED	5	1032	2026-06-19 01:31:15.76672+07	\N	\N	1507378\n
7068	439	68	5baef684-fd7d-48cc-9fe6-8adaac1a3711	ACCEPTED	5	996	2026-06-19 01:31:15.766725+07	\N	\N	1161167\n
7067	439	67	44f823ea-83c9-46ec-b42b-501c2ec75729	ACCEPTED	5	1020	2026-06-19 01:31:15.766724+07	\N	\N	473222\n
7070	439	70	917746da-477e-4bcd-8542-1d092dca4273	ACCEPTED	5	940	2026-06-19 01:31:15.766727+07	\N	\N	959298\n
7078	439	78	6fb3c6d6-a038-4aa3-9a74-d86ed3068f97	ACCEPTED	5	1096	2026-06-19 01:31:15.76675+07	\N	\N	-824805\n
7073	439	73	c103063d-c5bc-4df4-8058-2272da3efd1e	ACCEPTED	5	864	2026-06-19 01:31:15.76673+07	\N	\N	702179\n
7082	439	82	41db51db-5107-4ade-beea-c16dc553bf90	ACCEPTED	5	876	2026-06-19 01:31:15.766755+07	\N	\N	-1795574\n
7065	439	65	bda3a851-40ea-407d-b75f-410a4965c1ea	ACCEPTED	5	856	2026-06-19 01:31:15.766723+07	\N	\N	475745\n
7074	439	74	fb19b552-f81c-4348-adc3-7eaaa5bbb41e	ACCEPTED	6	876	2026-06-19 01:31:15.766731+07	\N	\N	909595\n
7079	439	79	af90ec61-209b-4475-9ed1-187f12697b79	ACCEPTED	8	976	2026-06-19 01:31:15.766752+07	\N	\N	-1351853\n
7081	439	81	694bc429-2d6a-41a2-a3ad-b82e3263b105	ACCEPTED	4	1024	2026-06-19 01:31:15.766753+07	\N	\N	-846475\n
7077	439	77	9afb18e6-e912-4f41-b4c5-8d46f62cbea8	ACCEPTED	4	1020	2026-06-19 01:31:15.766749+07	\N	\N	-987624\n
7069	439	69	11786f18-1ae6-4c98-ba7b-a08a1d337c93	ACCEPTED	10	868	2026-06-19 01:31:15.766726+07	\N	\N	616334\n
7076	439	76	6e085723-3e98-411e-9b23-08972ced3164	ACCEPTED	9	868	2026-06-19 01:31:15.766748+07	\N	\N	802483\n
7072	439	72	3f7e1867-9f65-4a36-a126-ca5cdfb5820f	ACCEPTED	9	828	2026-06-19 01:31:15.766729+07	\N	\N	1011312\n
7084	439	84	adbaa474-d28f-4e6d-a06b-fd657e6ce737	ACCEPTED	9	1020	2026-06-19 01:31:15.766756+07	\N	\N	-734921\n
7083	439	83	18a075b9-68f3-410f-bc5c-3d35394e8c73	ACCEPTED	4	1016	2026-06-19 01:31:15.766755+07	\N	\N	-1500204\n
7085	439	85	493e2321-8a9a-445a-8dfa-f72d8f060823	ACCEPTED	5	1032	2026-06-19 01:31:15.766757+07	\N	\N	-1006285\n
7088	439	88	ab5fd13d-86dd-4f0c-82cc-40572e3c60a3	ACCEPTED	6	888	2026-06-19 01:31:15.76676+07	\N	\N	-955984\n
7091	439	91	3ece6c34-3889-4ea8-b7ec-d09fd5be6f09	ACCEPTED	5	1056	2026-06-19 01:31:15.766763+07	\N	\N	-1113725\n
7090	439	90	98536635-a25a-4df3-badd-0a18c8d3e5ab	ACCEPTED	5	1012	2026-06-19 01:31:15.766762+07	\N	\N	-1520451\n
7093	439	93	3444071c-a826-449d-8763-8ce12e83e625	ACCEPTED	5	1112	2026-06-19 01:31:15.766765+07	\N	\N	-422973\n
7087	439	87	5127959d-1c1a-465e-b3bb-41a187ac1030	ACCEPTED	5	864	2026-06-19 01:31:15.766759+07	\N	\N	-1189260\n
7095	439	95	60fb3907-8ff4-409a-a971-a49cb416a125	ACCEPTED	5	1020	2026-06-19 01:31:15.766767+07	\N	\N	-1192974\n
7092	439	92	f5db7c9f-4fdf-474f-bc6b-a419654066e9	ACCEPTED	5	1092	2026-06-19 01:31:15.766764+07	\N	\N	-471131\n
7094	439	94	f0f0afaf-5d5b-4153-a1b6-c4aa689b20df	ACCEPTED	5	1032	2026-06-19 01:31:15.766766+07	\N	\N	-717234\n
7098	439	98	4e13cb20-ea87-4c15-824b-b4c337ef70f0	ACCEPTED	5	880	2026-06-19 01:31:15.766769+07	\N	\N	99178\n
7099	439	99	026d2376-6eb0-4159-873f-5c3e60cecb8c	ACCEPTED	5	1040	2026-06-19 01:31:15.76677+07	\N	\N	-1225775\n
7096	439	96	415d5183-280f-40e4-9539-78091b135562	ACCEPTED	5	1012	2026-06-19 01:31:15.766767+07	\N	\N	-1188270\n
7103	439	103	368f3ba5-0bf7-40f6-8c15-d9e092541a78	ACCEPTED	4	1024	2026-06-19 01:31:15.766774+07	\N	\N	283996\n
7102	439	102	4b26719f-88b7-45ca-b501-3c0dbf2c3122	ACCEPTED	6	1120	2026-06-19 01:31:15.766773+07	\N	\N	-619866\n
7100	439	100	06af8b8a-592c-466e-9c7a-15d15e48c30a	ACCEPTED	5	1032	2026-06-19 01:31:15.766771+07	\N	\N	281928\n
7104	439	104	14e378a5-39cb-4b60-a8c2-7ad893ca7119	ACCEPTED	5	1092	2026-06-19 01:31:15.766775+07	\N	\N	514364\n
7106	439	106	b5bd39e6-0066-4618-957d-600ae9f14c64	ACCEPTED	5	1016	2026-06-19 01:31:15.766777+07	\N	\N	-815576\n
7109	439	109	ce2d838a-037b-45b5-99d0-25a123919327	ACCEPTED	4	1012	2026-06-19 01:31:15.766779+07	\N	\N	792531\n
7108	439	108	41eac223-b783-4cc5-a114-d32834321de9	ACCEPTED	5	872	2026-06-19 01:31:15.766778+07	\N	\N	1436130\n
7107	439	107	5c80bc7a-f7d3-4a11-aade-683a7aeb6b6a	ACCEPTED	5	876	2026-06-19 01:31:15.766778+07	\N	\N	-34648\n
7110	439	110	8ca0ef3c-2073-4786-ac6d-18e19d1c8353	ACCEPTED	5	876	2026-06-19 01:31:15.76678+07	\N	\N	-572819\n
7113	439	113	48eca429-0585-49b7-a747-b34773eef8ac	ACCEPTED	5	1016	2026-06-19 01:31:15.766783+07	\N	\N	-1143916\n
7115	439	115	82f8b142-07f4-4dd7-a4ce-ad40ac646a07	ACCEPTED	4	864	2026-06-19 01:31:15.766785+07	\N	\N	506806\n
7116	439	116	e4f7024e-c647-4737-a03a-180413989242	ACCEPTED	5	992	2026-06-19 01:31:15.766786+07	\N	\N	785356\n
7118	439	118	b162ce2c-c40b-4f3b-92b9-ed14e965d5fa	ACCEPTED	6	1040	2026-06-19 01:31:15.766788+07	\N	\N	636465324\n
7123	439	123	4ec30630-f92a-41c4-9c98-36c0aab770e5	ACCEPTED	4	1032	2026-06-19 01:31:15.766794+07	\N	\N	1422690276\n
7112	439	112	a2a97346-7e95-40d6-be40-aa36f2ee5866	ACCEPTED	5	1020	2026-06-19 01:31:15.766782+07	\N	\N	649261\n
7117	439	117	96791a9e-fb11-4886-919f-7fa434e1b4eb	ACCEPTED	5	1012	2026-06-19 01:31:15.766787+07	\N	\N	362210245\n
7124	439	124	d2b44499-46f2-4f0c-bb8d-ee3d692dc276	ACCEPTED	5	836	2026-06-19 01:31:15.766795+07	\N	\N	1610593689\n
7111	439	111	8aae5ed3-821f-4f68-a7cd-bf4aa610f9b7	ACCEPTED	6	1020	2026-06-19 01:31:15.766781+07	\N	\N	-309452\n
7121	439	121	5b2f0c8f-d480-4a39-b8e8-1606f7f74e9f	ACCEPTED	4	1024	2026-06-19 01:31:15.766792+07	\N	\N	1259817393\n
7120	439	120	15abc32f-0894-4f71-b7be-8308b802b0d8	ACCEPTED	5	828	2026-06-19 01:31:15.766791+07	\N	\N	371467497\n
7057	439	57	98c3ff04-ea2e-48f0-b830-9161d503d740	ACCEPTED	6	1004	2026-06-19 01:31:15.766715+07	\N	\N	787228\n
7061	439	61	d579549a-7325-4610-a683-7b8b72f18c82	ACCEPTED	5	1016	2026-06-19 01:31:15.766719+07	\N	\N	879721\n
7066	439	66	613be509-d1c7-42ed-952f-b1a3b4f29b21	ACCEPTED	5	1016	2026-06-19 01:31:15.766724+07	\N	\N	129492\n
7071	439	71	94dfa5b6-7b08-400d-b2ee-870ed515a697	ACCEPTED	7	1020	2026-06-19 01:31:15.766728+07	\N	\N	1416847\n
7075	439	75	c9a6214f-d25e-4d82-b240-f74e2d43bbdd	ACCEPTED	4	1016	2026-06-19 01:31:15.766732+07	\N	\N	1760278\n
7080	439	80	bc4dc57d-5bf3-4038-8db2-ff189361b815	ACCEPTED	10	860	2026-06-19 01:31:15.766753+07	\N	\N	-1611196\n
7086	439	86	91d4095e-3674-4f69-ba90-f40f743ab327	ACCEPTED	4	804	2026-06-19 01:31:15.766758+07	\N	\N	-876295\n
7097	439	97	09177beb-f92f-4584-9045-ef4099ce723a	ACCEPTED	5	824	2026-06-19 01:31:15.766768+07	\N	\N	-517131\n
7089	439	89	db56ce6e-662d-4635-b5b3-6a89f222cda6	ACCEPTED	5	868	2026-06-19 01:31:15.766761+07	\N	\N	-902015\n
7101	439	101	eca956e2-e691-4b1c-8c42-a98ce0055f4f	ACCEPTED	12	892	2026-06-19 01:31:15.766772+07	\N	\N	28962\n
7105	439	105	ac198501-1a14-4050-b34a-6707ff47815d	ACCEPTED	7	876	2026-06-19 01:31:15.766776+07	\N	\N	-882565\n
7114	439	114	6f455bb0-bad7-4718-a6ea-68f7cbc5f708	ACCEPTED	6	868	2026-06-19 01:31:15.766784+07	\N	\N	-234796\n
7128	439	128	f9596293-526f-4500-880b-83388e386cad	ACCEPTED	5	872	2026-06-19 01:31:15.766799+07	\N	\N	82\n
7122	439	122	7f965bcc-3396-4ad0-aba8-a9442c97a395	ACCEPTED	4	872	2026-06-19 01:31:15.766793+07	\N	\N	-457820119\n
7127	439	127	0804dba3-5aac-4551-a4df-0ff15c3641fc	ACCEPTED	5	1036	2026-06-19 01:31:15.766798+07	\N	\N	0\n
7119	439	119	7214555e-acee-4d7e-a344-a6cf63b12f23	ACCEPTED	5	868	2026-06-19 01:31:15.766789+07	\N	\N	-738231997\n
7129	439	129	0373f37d-755d-4389-bb2c-9b77734d7a85	ACCEPTED	5	932	2026-06-19 01:31:15.7668+07	\N	\N	-32\n
7125	439	125	9331665c-9a98-4f02-853b-82189b0c690f	ACCEPTED	5	1016	2026-06-19 01:31:15.766796+07	\N	\N	86961293\n
7126	439	126	a945d4e2-7832-4c16-a47a-4a27799f243e	ACCEPTED	4	1020	2026-06-19 01:31:15.766797+07	\N	\N	-882105735\n
7130	439	130	aed28223-ab28-4663-adaa-5ecf10717f85	ACCEPTED	4	868	2026-06-19 01:31:15.766801+07	\N	\N	-5\n
7133	439	133	75a69227-4b4c-46d7-a953-d48bb85d3c9c	ACCEPTED	4	1052	2026-06-19 01:31:15.766804+07	\N	\N	-57\n
7134	439	134	7d1ce3c2-92f1-4196-b6e2-50ddd3bcc897	ACCEPTED	4	1052	2026-06-19 01:31:15.766806+07	\N	\N	158\n
7132	439	132	d2f6872e-a6a3-4416-9e9c-123fd618b143	ACCEPTED	6	1052	2026-06-19 01:31:15.766803+07	\N	\N	-1\n
7131	439	131	a8ad3c76-b88e-410a-ba9e-7cf618278a8c	ACCEPTED	4	1020	2026-06-19 01:31:15.766802+07	\N	\N	71\n
7135	439	135	9dcdba2f-ef9a-4441-8fed-ad95aec74690	ACCEPTED	4	1056	2026-06-19 01:31:15.766807+07	\N	\N	3\n
7137	439	137	c540ee0a-9758-4755-80b5-1662e68e2956	ACCEPTED	3	1584	2026-06-19 01:31:15.766809+07	\N	\N	64\n
7136	439	136	e5ffe339-e87d-4a5f-8d62-3169237a6414	ACCEPTED	3	1396	2026-06-19 01:31:15.766808+07	\N	\N	129\n
7138	439	138	de1bfe5c-a7b9-4c87-8d83-1c628ca83338	ACCEPTED	2	1260	2026-06-19 01:31:15.76681+07	\N	\N	51\n
7143	440	25	08542f65-6c1a-4286-9315-03f676280222	ACCEPTED	6	3656	2026-06-19 01:42:31.544779+07	\N	\N	300\n
7154	440	36	432cbe61-2641-493f-ac58-cc84fc9ca8b3	ACCEPTED	8	2864	2026-06-19 01:42:31.544789+07	\N	\N	801\n
7146	440	28	98ef7d15-3acc-4b0a-b5d0-0c1cba59545a	ACCEPTED	6	1380	2026-06-19 01:42:31.544782+07	\N	\N	579\n
7144	440	26	51c764ac-4f88-4b95-9b11-52e85c1debb7	ACCEPTED	6	11984	2026-06-19 01:42:31.54478+07	\N	\N	-30\n
7160	440	60	3ca56519-a04f-45bc-a444-94681d387de9	ACCEPTED	4	1104	2026-06-19 01:42:31.544794+07	\N	\N	380371\n
7142	440	24	165d69cf-9726-4e77-8f48-b5c639b816e4	ACCEPTED	5	1180	2026-06-19 01:42:31.544778+07	\N	\N	0\n
7141	440	23	8d111330-b6fb-40e8-a282-efa2238d29ff	ACCEPTED	4	7284	2026-06-19 01:42:31.544767+07	\N	\N	0\n
7152	440	34	24929cd2-a6e9-4dc3-9e9c-fcc5e980e06e	ACCEPTED	4	912	2026-06-19 01:42:31.544787+07	\N	\N	15\n
7155	440	37	93b151f0-ccdf-40ae-a8ed-6023ec17bf0f	ACCEPTED	6	868	2026-06-19 01:42:31.54479+07	\N	\N	1000\n
7145	440	27	7915f8ef-1f76-424c-8703-e4f29401561f	ACCEPTED	5	4216	2026-06-19 01:42:31.544781+07	\N	\N	1000\n
7158	440	58	e31ef8fd-b62e-4997-9ef6-7d1f725b7236	ACCEPTED	6	1104	2026-06-19 01:42:31.544793+07	\N	\N	803799\n
7140	440	22	3c325db6-e152-4bcd-b13e-3130ee6ac87f	ACCEPTED	4	2240	2026-06-19 01:42:31.544766+07	\N	\N	30\n
7161	440	61	9f7403b6-04f9-4eac-8a64-966b24143918	ACCEPTED	4	1128	2026-06-19 01:42:31.544795+07	\N	\N	879721\n
7139	440	21	e544e0dc-dff1-455b-a6db-5424fbb967cd	ACCEPTED	4	1032	2026-06-19 01:42:31.544763+07	\N	\N	3\n
7148	440	30	60aba06c-142b-47d6-854d-80e9cae6ba04	ACCEPTED	5	1296	2026-06-19 01:42:31.544784+07	\N	\N	0\n
7149	440	31	b65e3bd0-d966-4c6b-b34d-02e4053b51b5	ACCEPTED	7	4544	2026-06-19 01:42:31.544784+07	\N	\N	30000\n
7156	440	38	a53b8fe8-a785-4c32-8ad7-ec521f6e3fc2	ACCEPTED	5	1012	2026-06-19 01:42:31.544791+07	\N	\N	3000000\n
7157	440	57	a98db847-48f6-41f3-9963-9f932cf60feb	ACCEPTED	9	896	2026-06-19 01:42:31.544792+07	\N	\N	787228\n
7153	440	35	5f75def8-14c7-4711-9b2c-55ae94b229f7	ACCEPTED	6	1100	2026-06-19 01:42:31.544788+07	\N	\N	-2\n
7151	440	33	ce7bc43b-fa80-4402-a93d-382706181db7	ACCEPTED	4	1108	2026-06-19 01:42:31.544786+07	\N	\N	84\n
7150	440	32	419b82ed-54a1-4009-9e8e-120e0aa230cf	ACCEPTED	5	892	2026-06-19 01:42:31.544785+07	\N	\N	0\n
7159	440	59	4ce28eca-64ee-4bcf-b927-2990a8eaa7a8	ACCEPTED	5	1100	2026-06-19 01:42:31.544794+07	\N	\N	545178\n
7147	440	29	767334bf-c3b5-4341-9fd6-1a943ee14850	ACCEPTED	4	1100	2026-06-19 01:42:31.544783+07	\N	\N	99\n
7294	441	94	f9e56616-9ecc-4775-a91e-bc52912ac70a	ACCEPTED	5	1088	2026-06-19 01:46:36.145662+07	\N	\N	-717234\n
7309	441	109	89f15f12-57aa-467b-aff4-2897706ebb50	ACCEPTED	4	1020	2026-06-19 01:46:36.145717+07	\N	\N	792531\n
7295	441	95	277f3833-b1d3-49d0-8a50-ea22892e3d9b	ACCEPTED	5	1032	2026-06-19 01:46:36.145663+07	\N	\N	-1192974\n
7314	441	114	20bdaa15-7b98-446c-a2b5-b503b4db3266	ACCEPTED	4	884	2026-06-19 01:46:36.145724+07	\N	\N	-234796\n
7313	441	113	c9ab3e0e-55dd-4468-94e9-c0becff3a3ed	ACCEPTED	6	868	2026-06-19 01:46:36.145723+07	\N	\N	-1143916\n
7330	441	130	4c930d2d-90e2-40f6-86c8-f1b40fe1898a	ACCEPTED	5	1032	2026-06-19 01:46:36.14575+07	\N	\N	-5\n
7410	442	110	f63f9e06-12c2-4f6f-a54b-e4087e83718d	ACCEPTED	5	868	2026-06-19 01:57:50.086873+07	\N	\N	-572819\n
7318	441	118	40990071-0b2f-4774-9887-c7830323ce82	ACCEPTED	4	1024	2026-06-19 01:46:36.14573+07	\N	\N	636465324\n
7165	440	65	ac7a5e3e-25fc-460e-95ed-656f547509cd	ACCEPTED	5	1036	2026-06-19 01:42:31.544807+07	\N	\N	475745\n
7170	440	70	35b54a06-d62f-4075-8ef5-c8985a61f022	ACCEPTED	5	1036	2026-06-19 01:42:31.544813+07	\N	\N	959298\n
7167	440	67	77606664-1932-4ec9-a6ff-a2a71d806a96	ACCEPTED	8	992	2026-06-19 01:42:31.544809+07	\N	\N	473222\n
7174	440	74	cfcf2112-3214-47c1-bf90-6419619c64e3	ACCEPTED	5	1028	2026-06-19 01:42:31.544816+07	\N	\N	909595\n
7164	440	64	1d99f1fb-2bd2-43d4-8d03-a087eef1797d	ACCEPTED	7	944	2026-06-19 01:42:31.544806+07	\N	\N	710339\n
7173	440	73	7e14d2d3-2d39-4a6e-ba65-b8f727fd2b34	ACCEPTED	5	1092	2026-06-19 01:42:31.544816+07	\N	\N	702179\n
7169	440	69	51ecee9c-81ff-44d2-91ba-4462297a08e2	ACCEPTED	6	1028	2026-06-19 01:42:31.544812+07	\N	\N	616334\n
7166	440	66	d75b3130-c1d9-40fd-b88e-09a12bbdc52d	ACCEPTED	7	896	2026-06-19 01:42:31.544808+07	\N	\N	129492\n
7163	440	63	b7e5eb46-816d-4bf1-9147-cefecedc36c4	ACCEPTED	5	1036	2026-06-19 01:42:31.544805+07	\N	\N	1507378\n
7180	440	80	1cf08350-abbb-465d-a229-7df9799fccc6	ACCEPTED	5	1020	2026-06-19 01:42:31.544822+07	\N	\N	-1611196\n
7175	440	75	b3876c52-98f6-44ab-9036-906d6e9f10f1	ACCEPTED	5	1092	2026-06-19 01:42:31.544817+07	\N	\N	1760278\n
7177	440	77	b8bf5586-010d-47ce-adb8-50fb8bb635b5	ACCEPTED	7	896	2026-06-19 01:42:31.544819+07	\N	\N	-987624\n
7172	440	72	dde08c76-3efe-4f57-90f9-668b379806fb	ACCEPTED	6	896	2026-06-19 01:42:31.544814+07	\N	\N	1011312\n
7184	440	84	45c49dc6-5a64-4d80-9f85-ff22c3ffd755	ACCEPTED	4	1024	2026-06-19 01:42:31.544826+07	\N	\N	-734921\n
7185	440	85	d825e4ea-3f53-4b4c-ae7c-981a9b7e7e4f	ACCEPTED	4	876	2026-06-19 01:42:31.544827+07	\N	\N	-1006285\n
7179	440	79	3dcddbdd-cef7-4576-a835-4af4ef8b3623	ACCEPTED	4	1024	2026-06-19 01:42:31.544821+07	\N	\N	-1351853\n
7178	440	78	b26df2a3-35b5-461c-bc10-3cfb68b43ab2	ACCEPTED	5	1036	2026-06-19 01:42:31.54482+07	\N	\N	-824805\n
7176	440	76	265eb503-8b18-40af-a1e1-47ec8429669c	ACCEPTED	5	1096	2026-06-19 01:42:31.544818+07	\N	\N	802483\n
7183	440	83	2e12c967-f7b9-4757-99ca-98588c775e76	ACCEPTED	4	1052	2026-06-19 01:42:31.544825+07	\N	\N	-1500204\n
7186	440	86	5a5fc5d0-1259-4312-8ed3-27f45344c44c	ACCEPTED	5	1108	2026-06-19 01:42:31.544828+07	\N	\N	-876295\n
7187	440	87	36a42532-d530-41b7-a3b9-c63c1d5d6f13	ACCEPTED	5	1036	2026-06-19 01:42:31.544829+07	\N	\N	-1189260\n
7192	440	92	e6390cce-ac0a-49b6-ac0c-552962b8ada0	ACCEPTED	4	1104	2026-06-19 01:42:31.544843+07	\N	\N	-471131\n
7188	440	88	bd97e739-90e1-4d62-94c8-5b70ad27912a	ACCEPTED	4	1096	2026-06-19 01:42:31.54483+07	\N	\N	-955984\n
7194	440	94	27bb7d1a-cd4a-4b78-a2e3-2bca0c80e729	ACCEPTED	4	1040	2026-06-19 01:42:31.544845+07	\N	\N	-717234\n
7191	440	91	fbd5d4ca-0e87-411d-80f4-ca9419109790	ACCEPTED	5	1040	2026-06-19 01:42:31.544842+07	\N	\N	-1113725\n
7202	440	102	c4be382e-313d-4bd2-baa0-08b9873dbde1	ACCEPTED	5	1020	2026-06-19 01:42:31.544853+07	\N	\N	-619866\n
7196	440	96	a217cb7c-4c1c-4431-9f20-5d657aec040e	ACCEPTED	4	880	2026-06-19 01:42:31.544847+07	\N	\N	-1188270\n
7195	440	95	7357c9b7-49be-40b9-bb89-473b793786a5	ACCEPTED	5	1044	2026-06-19 01:42:31.544846+07	\N	\N	-1192974\n
7197	440	97	19546ae6-733c-43c3-92c0-f32cbe8c466d	ACCEPTED	4	1024	2026-06-19 01:42:31.544848+07	\N	\N	-517131\n
7205	440	105	d52d3399-a7e8-4661-89c7-f19f3be2bcc2	ACCEPTED	4	864	2026-06-19 01:42:31.544863+07	\N	\N	-882565\n
7199	440	99	8813e959-54c3-4149-afd9-1064d6ca428b	ACCEPTED	5	896	2026-06-19 01:42:31.54485+07	\N	\N	-1225775\n
7207	440	107	24c07057-3767-4b10-93c5-a9d9df2d91e5	ACCEPTED	4	1072	2026-06-19 01:42:31.544865+07	\N	\N	-34648\n
7200	440	100	c31de84c-2b17-43af-ad79-5e68e747d893	ACCEPTED	6	1096	2026-06-19 01:42:31.544851+07	\N	\N	281928\n
7203	440	103	6b6cb97b-d84a-4419-a029-f726c9e617b3	ACCEPTED	7	1036	2026-06-19 01:42:31.544854+07	\N	\N	283996\n
7206	440	106	01d11bb7-67dd-485e-a0f6-9d37979b9b4e	ACCEPTED	5	1028	2026-06-19 01:42:31.544864+07	\N	\N	-815576\n
7204	440	104	81eff6b2-ab8c-40ee-b251-7f910d75ce8f	ACCEPTED	7	1028	2026-06-19 01:42:31.544862+07	\N	\N	514364\n
7198	440	98	2f23f3ce-70c4-48ae-98a4-eae787e87600	ACCEPTED	5	1040	2026-06-19 01:42:31.544849+07	\N	\N	99178\n
7209	440	109	dbd71469-4300-4bb2-93d8-d585fb004af5	ACCEPTED	5	868	2026-06-19 01:42:31.544867+07	\N	\N	792531\n
7210	440	110	2ee4fab8-6754-49aa-9213-9f25976e3112	ACCEPTED	4	1088	2026-06-19 01:42:31.544868+07	\N	\N	-572819\n
7211	440	111	60c52f70-26ad-44e8-ad0b-7c77ad269784	ACCEPTED	5	876	2026-06-19 01:42:31.544869+07	\N	\N	-309452\n
7212	440	112	284bf578-b14c-4b56-bfe5-cb66f903fe84	ACCEPTED	4	1020	2026-06-19 01:42:31.54487+07	\N	\N	649261\n
7214	440	114	d654d3de-8e26-4ee7-b301-d08a8485272d	ACCEPTED	5	844	2026-06-19 01:42:31.544872+07	\N	\N	-234796\n
7216	440	116	3087ae76-9d89-4812-a410-2bdf4ae6e5ee	ACCEPTED	5	1032	2026-06-19 01:42:31.544874+07	\N	\N	785356\n
7221	440	121	0399adae-5eee-4742-adc6-a656939cd243	ACCEPTED	5	1024	2026-06-19 01:42:31.544878+07	\N	\N	1259817393\n
7219	440	119	07b5ed58-c042-4b44-9d67-bc3ea7338f49	ACCEPTED	6	1028	2026-06-19 01:42:31.544876+07	\N	\N	-738231997\n
7213	440	113	0677d6ba-edf8-4092-82c1-6c77b42db030	ACCEPTED	5	1084	2026-06-19 01:42:31.544871+07	\N	\N	-1143916\n
7224	440	124	81af2444-6e2f-4d52-bc7b-4d2459affa45	ACCEPTED	5	872	2026-06-19 01:42:31.544881+07	\N	\N	1610593689\n
7223	440	123	d97b6e9f-08e1-42ca-b1a6-3d0917ca2f2f	ACCEPTED	6	804	2026-06-19 01:42:31.54488+07	\N	\N	1422690276\n
7220	440	120	06555e27-ab67-45e3-a2d1-f4d71d47dbf3	ACCEPTED	4	1020	2026-06-19 01:42:31.544877+07	\N	\N	371467497\n
7231	440	131	3080bc24-1e5b-4930-a0d9-a0fa7fbeac93	ACCEPTED	5	1084	2026-06-19 01:42:31.544888+07	\N	\N	71\n
7230	440	130	31ab3a19-6c87-45af-9e82-fbd19230b891	ACCEPTED	5	1084	2026-06-19 01:42:31.544887+07	\N	\N	-5\n
7229	440	129	77022da5-5f19-48e1-a28a-698911365376	ACCEPTED	4	1024	2026-06-19 01:42:31.544886+07	\N	\N	-32\n
7222	440	122	f3ee4fe4-98a1-4ae9-80b6-8e9b75b5301b	ACCEPTED	4	1004	2026-06-19 01:42:31.544879+07	\N	\N	-457820119\n
7228	440	128	67c477cf-79c1-4399-bc25-87d995825a92	ACCEPTED	4	1024	2026-06-19 01:42:31.544885+07	\N	\N	82\n
7227	440	127	4b28313f-7a33-4b91-9dd0-d150cc5e5730	ACCEPTED	4	1020	2026-06-19 01:42:31.544884+07	\N	\N	0\n
7217	440	117	18264297-90a4-453c-9e83-6b370943e42d	ACCEPTED	4	1032	2026-06-19 01:42:31.544875+07	\N	\N	362210245\n
7162	440	62	22b08291-5c73-4dce-9417-d22cad225d7c	ACCEPTED	5	1040	2026-06-19 01:42:31.544804+07	\N	\N	1486218\n
7171	440	71	6df34ca1-4eec-495d-8caa-b4ac8505a5ba	ACCEPTED	6	1032	2026-06-19 01:42:31.544813+07	\N	\N	1416847\n
7168	440	68	e131ef89-50f6-4232-b10f-5e849b39c25b	ACCEPTED	6	884	2026-06-19 01:42:31.544809+07	\N	\N	1161167\n
7181	440	81	bc4904d7-770f-4ee8-a582-82f90a4a8853	ACCEPTED	5	1000	2026-06-19 01:42:31.544823+07	\N	\N	-846475\n
7182	440	82	d3170497-a5c4-40f1-83e4-98cb6b774ade	ACCEPTED	4	1036	2026-06-19 01:42:31.544824+07	\N	\N	-1795574\n
7189	440	89	9b088055-60cb-4f03-bc1a-7f33295bf7e1	ACCEPTED	5	892	2026-06-19 01:42:31.54484+07	\N	\N	-902015\n
7190	440	90	ef318190-4165-4282-9f86-d354e04cdf23	ACCEPTED	4	1048	2026-06-19 01:42:31.544841+07	\N	\N	-1520451\n
7201	440	101	962737f3-2b08-4b77-8f0c-77424680de1f	ACCEPTED	4	1020	2026-06-19 01:42:31.544852+07	\N	\N	28962\n
7193	440	93	91998b41-4145-4464-880e-ad7b727e4844	ACCEPTED	5	1028	2026-06-19 01:42:31.544844+07	\N	\N	-422973\n
7208	440	108	c96867b0-9931-4585-b974-7b71c979996e	ACCEPTED	4	1036	2026-06-19 01:42:31.544866+07	\N	\N	1436130\n
7215	440	115	f2ae0999-283d-4c22-b8e2-c81ff292729e	ACCEPTED	4	1100	2026-06-19 01:42:31.544873+07	\N	\N	506806\n
7218	440	118	5af56680-36ab-45e0-8a4f-23444e2ec344	ACCEPTED	5	1028	2026-06-19 01:42:31.544876+07	\N	\N	636465324\n
7226	440	126	96da9451-9eb5-4c56-ad49-873645e87c3b	ACCEPTED	5	968	2026-06-19 01:42:31.544883+07	\N	\N	-882105735\n
7225	440	125	8d7f422a-75a7-4ccd-92ef-7d9b3fc30b23	ACCEPTED	5	996	2026-06-19 01:42:31.544882+07	\N	\N	86961293\n
7233	440	133	11a980aa-8158-48ea-970e-fbf9453a5e6c	ACCEPTED	3	1120	2026-06-19 01:42:31.54489+07	\N	\N	-57\n
7232	440	132	bd602984-3fa3-46c2-9966-b1361eae9b50	ACCEPTED	5	1072	2026-06-19 01:42:31.544889+07	\N	\N	-1\n
7236	440	136	a1fcc1e3-5602-43de-8216-17551e093015	ACCEPTED	4	1192	2026-06-19 01:42:31.544896+07	\N	\N	129\n
7237	440	137	5842ad64-4cee-4e70-a29a-43c6182cb48d	ACCEPTED	2	1032	2026-06-19 01:42:31.544897+07	\N	\N	64\n
7234	440	134	cfd2f14a-aa80-47a6-9fa5-72c72a861be0	ACCEPTED	3	1052	2026-06-19 01:42:31.544891+07	\N	\N	158\n
7235	440	135	be79694b-187a-4c9f-b141-f035d8aa2e90	ACCEPTED	2	1024	2026-06-19 01:42:31.544892+07	\N	\N	3\n
7238	440	138	ae302e17-d79e-42bc-899d-df67ccb56a45	ACCEPTED	2	1252	2026-06-19 01:42:31.544898+07	\N	\N	51\n
7325	441	125	1f2a298f-4adb-4397-87d2-f7739b5ca9e2	ACCEPTED	4	1020	2026-06-19 01:46:36.145739+07	\N	\N	86961293\n
7335	441	135	e73fe18b-7bc0-46b4-8a09-a520ae65a686	ACCEPTED	3	1056	2026-06-19 01:46:36.145818+07	\N	\N	3\n
8976	460	72	c839e264-4650-422b-86e7-539bdb7fc10c	ACCEPTED	10	1076	2026-06-21 02:01:32.405775+07	\N	\N	1011312
7359	442	59	d34986ab-55a2-411a-94d9-9dc72dafd81c	ACCEPTED	7	7560	2026-06-19 01:57:50.086843+07	\N	\N	545178\n
7343	442	25	6a4d360b-ef22-4f22-b29f-98cc8614b562	ACCEPTED	6	1768	2026-06-19 01:57:50.086836+07	\N	\N	300\n
7358	442	58	e9c22e1b-2e6c-4db5-8d93-bb1688d8ddf1	ACCEPTED	5	1528	2026-06-19 01:57:50.086842+07	\N	\N	803799\n
7356	442	38	9a6252be-d698-49a5-9557-dc0f0bfcd7c0	ACCEPTED	5	1032	2026-06-19 01:57:50.086841+07	\N	\N	3000000\n
7362	442	62	6529d682-fcea-4d32-81f1-82e1608e0815	ACCEPTED	5	2464	2026-06-19 01:57:50.086844+07	\N	\N	1486218\n
7372	442	72	c5e5424a-613d-421a-b4be-9f158bbfb919	ACCEPTED	5	1032	2026-06-19 01:57:50.086848+07	\N	\N	1011312\n
7365	442	65	bf2ad6c9-6c10-4650-92e8-8e989f69da28	ACCEPTED	4	1044	2026-06-19 01:57:50.086845+07	\N	\N	475745\n
7373	442	73	5e89b545-0cb2-498d-8b62-3d2cac0b2510	ACCEPTED	6	1024	2026-06-19 01:57:50.086849+07	\N	\N	702179\n
7368	442	68	b2c00701-e3b8-4057-8018-2234ff954696	ACCEPTED	5	864	2026-06-19 01:57:50.086847+07	\N	\N	1161167\n
7388	442	88	25ee959a-ff8d-4d60-a1f1-1bc366d99d15	ACCEPTED	6	824	2026-06-19 01:57:50.086855+07	\N	\N	-955984\n
7406	442	106	57b0f60e-21b2-4786-b316-9220e5c70da9	ACCEPTED	5	1088	2026-06-19 01:57:50.086872+07	\N	\N	-815576\n
7397	442	97	beff91cf-88d9-4ef0-b0ac-27b614356058	ACCEPTED	5	872	2026-06-19 01:57:50.086867+07	\N	\N	-517131\n
7416	442	116	85f3cf77-6dcb-4e05-840e-60532782b759	ACCEPTED	6	936	2026-06-19 01:57:50.086876+07	\N	\N	785356\n
7414	442	114	ab2d38cc-aa81-4720-8d53-0a868365549e	ACCEPTED	7	1092	2026-06-19 01:57:50.086875+07	\N	\N	-234796\n
7415	442	115	9732c091-5ef5-4ece-b01c-4a2ab21ccb9e	ACCEPTED	6	1032	2026-06-19 01:57:50.086876+07	\N	\N	506806\n
7413	442	113	be03f999-f1ca-4ba7-82ef-6ed8cfb7e654	ACCEPTED	6	1024	2026-06-19 01:57:50.086875+07	\N	\N	-1143916\n
7425	442	125	77cd10e5-4cd2-45dd-a8d7-02bc80060cb0	ACCEPTED	7	864	2026-06-19 01:57:50.086879+07	\N	\N	86961293\n
7419	442	119	8c33206b-b8f0-48fe-9703-8497454a42b3	ACCEPTED	5	876	2026-06-19 01:57:50.086877+07	\N	\N	-738231997\n
7423	442	123	a9e10144-44c3-412d-a752-6a094e17feb5	ACCEPTED	5	988	2026-06-19 01:57:50.086879+07	\N	\N	1422690276\n
7422	442	122	5256f684-998f-428c-b4dc-933bd96c0197	ACCEPTED	6	928	2026-06-19 01:57:50.086878+07	\N	\N	-457820119\n
7420	442	120	7e02f193-e8a6-4458-a3be-ba6994c11f38	ACCEPTED	5	1016	2026-06-19 01:57:50.086878+07	\N	\N	371467497\n
7417	442	117	727cf770-d20b-4c9c-938f-f63d61aa6618	ACCEPTED	5	1084	2026-06-19 01:57:50.086876+07	\N	\N	362210245\n
7429	442	129	23910250-0c18-49fc-8da7-7fa6395e0250	ACCEPTED	5	848	2026-06-19 01:57:50.086881+07	\N	\N	-32\n
7418	442	118	7c14f9b0-0a11-4c7f-b747-fcc0a57cdb56	ACCEPTED	17	1032	2026-06-19 01:57:50.086877+07	\N	\N	636465324\n
7427	442	127	649a4290-71c3-43f5-8907-c031b04d89da	ACCEPTED	5	1016	2026-06-19 01:57:50.08688+07	\N	\N	0\n
7432	442	132	b271c1dc-c517-435e-a985-ed0dda9b825e	ACCEPTED	7	1032	2026-06-19 01:57:50.086882+07	\N	\N	-1\n
7431	442	131	900b61c8-8182-4eb9-8c89-5aa9990a7ceb	ACCEPTED	5	992	2026-06-19 01:57:50.086882+07	\N	\N	71\n
7428	442	128	140af782-6152-41c1-a9ee-26f2b7ea84d5	ACCEPTED	4	864	2026-06-19 01:57:50.086881+07	\N	\N	82\n
7421	442	121	f0038fa7-1502-43d4-9643-c62b28b156ba	ACCEPTED	12	864	2026-06-19 01:57:50.086878+07	\N	\N	1259817393\n
7426	442	126	1278beaf-73ec-4d7b-85dd-65eaed8dd6d0	ACCEPTED	8	920	2026-06-19 01:57:50.08688+07	\N	\N	-882105735\n
7434	442	134	e710a984-934d-414c-b0f2-248ca295f3a0	ACCEPTED	4	1060	2026-06-19 01:57:50.086883+07	\N	\N	158\n
7437	442	137	b11b64d8-7afb-434b-8af8-42d5eebea1b5	ACCEPTED	3	1032	2026-06-19 01:57:50.086884+07	\N	\N	64\n
7436	442	136	bb0c04f2-30e6-4df6-83e8-66e1deb17277	ACCEPTED	3	1072	2026-06-19 01:57:50.086884+07	\N	\N	129\n
7438	442	138	ed98a1b4-93ac-4d13-9b7e-83cddcaa711e	ACCEPTED	2	1052	2026-06-19 01:57:50.086885+07	\N	\N	51\n
7395	442	95	64068ac5-84c7-4d8a-9572-49d8e824497d	ACCEPTED	10	1012	2026-06-19 01:57:50.086866+07	\N	\N	-1192974\n
8944	460	22	03a851f2-2893-4be1-a86a-c191482df9b2	ACCEPTED	5	1092	2026-06-21 02:01:32.405703+07	\N	\N	30
8957	460	35	c702ff34-3b31-466f-81dc-a94f1b01cde8	ACCEPTED	5	1028	2026-06-21 02:01:32.405725+07	\N	\N	-2
8981	460	77	a15a8d09-d805-45c2-a90d-09f0dc8b124f	ACCEPTED	4	1020	2026-06-21 02:01:32.405783+07	\N	\N	-987624
8978	460	74	5145f122-522f-41c0-b934-109dbb559cbf	ACCEPTED	5	1044	2026-06-21 02:01:32.405778+07	\N	\N	909595
8984	460	80	0390f1dc-0e84-4a91-b1b0-dd5e1678432a	ACCEPTED	4	1036	2026-06-21 02:01:32.405788+07	\N	\N	-1611196
8986	460	82	8b587970-c528-428a-bde7-daa004136fcb	ACCEPTED	4	1024	2026-06-21 02:01:32.405792+07	\N	\N	-1795574
8985	460	81	1deb97f0-53b9-42cf-a900-b6c563f0b389	ACCEPTED	8	872	2026-06-21 02:01:32.40579+07	\N	\N	-846475
8987	460	83	5ef84db3-aa82-4821-9eba-742c52a2505b	ACCEPTED	4	1100	2026-06-21 02:01:32.405793+07	\N	\N	-1500204
8982	460	78	8180c443-0be0-4064-ae18-cceb0f1e8d71	ACCEPTED	5	996	2026-06-21 02:01:32.405785+07	\N	\N	-824805
8990	460	86	f605d88b-7893-430e-8119-e238a065fe07	ACCEPTED	4	1080	2026-06-21 02:01:32.405798+07	\N	\N	-876295
8979	460	75	c35a0dd6-0e72-46d5-84e0-7632d13561f2	ACCEPTED	4	872	2026-06-21 02:01:32.40578+07	\N	\N	1760278
8983	460	79	162390bf-30c3-44be-b393-61e0b2ac441d	ACCEPTED	7	992	2026-06-21 02:01:32.405786+07	\N	\N	-1351853
8988	460	84	a90d8b0e-4564-4c2a-a254-188492ce61dd	ACCEPTED	6	1028	2026-06-21 02:01:32.405795+07	\N	\N	-734921
8991	460	87	8c82fec3-250e-4cdf-94ee-67be45979f53	ACCEPTED	6	1016	2026-06-21 02:01:32.405799+07	\N	\N	-1189260
8992	460	88	cfa5eddf-1438-49d7-a500-77bece50bdd5	ACCEPTED	4	1016	2026-06-21 02:01:32.405801+07	\N	\N	-955984
8996	460	92	8668133f-0167-4b12-8fab-f1e1b69932c9	ACCEPTED	4	892	2026-06-21 02:01:32.405808+07	\N	\N	-471131
8994	460	90	89ee036c-4796-4a42-9aae-4f65479076ed	ACCEPTED	4	1040	2026-06-21 02:01:32.405804+07	\N	\N	-1520451
8993	460	89	136f26ac-9b76-4999-ab29-07c101e0b7b3	ACCEPTED	4	1024	2026-06-21 02:01:32.405803+07	\N	\N	-902015
9006	460	102	3b50299e-9b3f-47fb-b8a5-2613920b124a	ACCEPTED	5	1040	2026-06-21 02:01:32.405824+07	\N	\N	-619866
8997	460	93	39fc7ef8-2dc9-413a-9dc2-d96be2e8199d	ACCEPTED	4	840	2026-06-21 02:01:32.405809+07	\N	\N	-422973
8999	460	95	0670f8ca-27ea-4d31-88cb-6eb5681778fd	ACCEPTED	5	1084	2026-06-21 02:01:32.405812+07	\N	\N	-1192974
8998	460	94	13f0b837-b8c5-41ca-b618-132348dfc67d	ACCEPTED	5	1016	2026-06-21 02:01:32.405811+07	\N	\N	-717234
9003	460	99	f17cfbb9-9721-4232-89a6-280a49d9711d	ACCEPTED	5	1000	2026-06-21 02:01:32.405819+07	\N	\N	-1225775
9001	460	97	0efbeb6c-59d7-467f-9948-92429b24e29b	ACCEPTED	5	1020	2026-06-21 02:01:32.405815+07	\N	\N	-517131
9002	460	98	e3b9fd79-b4b4-48b5-a6da-e4f86113ca7b	ACCEPTED	5	1120	2026-06-21 02:01:32.405817+07	\N	\N	99178
9008	460	104	c2d2472d-f77a-4724-b14a-29fb6f56d90a	ACCEPTED	4	1028	2026-06-21 02:01:32.405828+07	\N	\N	514364
9005	460	101	fee5690d-ab53-425a-ab32-3720471445f7	ACCEPTED	6	1024	2026-06-21 02:01:32.405823+07	\N	\N	28962
9007	460	103	241e7d23-db9a-4fff-be9e-ae8a63354acb	ACCEPTED	5	1084	2026-06-21 02:01:32.405826+07	\N	\N	283996
9010	460	106	187f9881-4cc5-42c0-85a1-1dbf934e88f9	ACCEPTED	5	1020	2026-06-21 02:01:32.405831+07	\N	\N	-815576
9011	460	107	d7daff3b-51c7-413f-966f-bcda2c4a29e0	ACCEPTED	5	1012	2026-06-21 02:01:32.405833+07	\N	\N	-34648
9013	460	109	64dcc693-9173-4f0e-87df-70e2f216a772	ACCEPTED	4	880	2026-06-21 02:01:32.405836+07	\N	\N	792531
9012	460	108	1958555e-b81b-4c86-b3cb-7c8c23e5e45c	ACCEPTED	4	936	2026-06-21 02:01:32.405834+07	\N	\N	1436130
9014	460	110	3efef19b-a759-4b84-8c82-d116adefb17c	ACCEPTED	5	976	2026-06-21 02:01:32.405838+07	\N	\N	-572819
9015	460	111	10b26a67-ba8b-462c-942d-ab873d2256a7	ACCEPTED	4	824	2026-06-21 02:01:32.405839+07	\N	\N	-309452
9019	460	115	7bca2a96-537b-49b9-8112-465edbf6ec34	ACCEPTED	5	840	2026-06-21 02:01:32.405846+07	\N	\N	506806
9017	460	113	ebc4f36a-16db-4501-bc0c-47ee81a6bd1d	ACCEPTED	5	976	2026-06-21 02:01:32.405843+07	\N	\N	-1143916
9018	460	114	f20b54c8-4c70-4c9c-9220-908d8e074bc8	ACCEPTED	5	1044	2026-06-21 02:01:32.405844+07	\N	\N	-234796
9016	460	112	878a0370-5b19-43c8-a364-cb78129b40ff	ACCEPTED	4	1096	2026-06-21 02:01:32.405841+07	\N	\N	649261
9024	460	120	338a9151-04de-42eb-84ad-7220d2adf4ae	ACCEPTED	5	1020	2026-06-21 02:01:32.405866+07	\N	\N	371467497
9023	460	119	616898d3-df6b-459b-818d-c73fd060486e	ACCEPTED	8	804	2026-06-21 02:01:32.405864+07	\N	\N	-738231997
9025	460	121	f65ab98b-9ff6-42e2-8b4a-35b4c8ee5f3b	ACCEPTED	4	1084	2026-06-21 02:01:32.405867+07	\N	\N	1259817393
9026	460	122	6333c1fe-3cf6-4e6a-bb18-08164a2f095b	ACCEPTED	4	1028	2026-06-21 02:01:32.405869+07	\N	\N	-457820119
9027	460	123	ff26b462-8c05-4496-8950-74c2b3de0a5d	ACCEPTED	4	832	2026-06-21 02:01:32.40587+07	\N	\N	1422690276
9028	460	124	ca11fbaa-d937-463d-bbc3-5b7c90a8b93a	ACCEPTED	5	1076	2026-06-21 02:01:32.405872+07	\N	\N	1610593689
9021	460	117	4f230a63-87c6-4216-ac73-86c22deee3c9	ACCEPTED	5	960	2026-06-21 02:01:32.405861+07	\N	\N	362210245
9031	460	127	1d976884-066d-4281-a2a7-1ed7625a3601	ACCEPTED	4	1084	2026-06-21 02:01:32.405877+07	\N	\N	0
9029	460	125	50e32a96-8f74-4cc3-b8ee-1c51efe997e4	ACCEPTED	6	868	2026-06-21 02:01:32.405874+07	\N	\N	86961293
9030	460	126	48413aed-96a9-42c7-be60-0208b85cb292	ACCEPTED	5	1020	2026-06-21 02:01:32.405875+07	\N	\N	-882105735
9036	460	132	69276054-8f25-4b59-8919-e878773a73bd	ACCEPTED	5	1012	2026-06-21 02:01:32.405886+07	\N	\N	-1
9033	460	129	4a2d5ee5-b339-45d6-b510-8eaf22932a43	ACCEPTED	6	1024	2026-06-21 02:01:32.405882+07	\N	\N	-32
9034	460	130	66acd724-2edc-4dfe-b2b1-d6658da28036	ACCEPTED	4	1228	2026-06-21 02:01:32.405883+07	\N	\N	-5
9038	460	134	957fc530-7b8a-4fe5-b4de-e0b384e07990	ACCEPTED	3	1052	2026-06-21 02:01:32.40589+07	\N	\N	158
9042	460	138	1f18f8c7-5c01-44b1-b230-8fddbc5fc720	ACCEPTED	3	1092	2026-06-21 02:01:32.405896+07	\N	\N	51
9041	460	137	d567cdca-5a38-4d5d-a62b-ff98ccfde8e0	ACCEPTED	2	1052	2026-06-21 02:01:32.405894+07	\N	\N	64
9040	460	136	d736f9ff-42be-4e23-bb99-b28df9d6dc6d	ACCEPTED	3	1052	2026-06-21 02:01:32.405893+07	\N	\N	129
9039	460	135	205587c3-aef4-41e2-aac0-1685742036e1	ACCEPTED	2	1056	2026-06-21 02:01:32.405891+07	\N	\N	3
7408	442	108	9098600b-302f-448a-bc2b-edac5bfefe4d	ACCEPTED	4	1020	2026-06-19 01:57:50.086873+07	\N	\N	1436130\n
7407	442	107	458d84f4-5bcc-429b-9be7-86d93616dbc2	ACCEPTED	4	1024	2026-06-19 01:57:50.086872+07	\N	\N	-34648\n
7409	442	109	57c05ce2-3a91-433a-ade8-37b6d445a2f0	ACCEPTED	5	1084	2026-06-19 01:57:50.086873+07	\N	\N	792531\n
7411	442	111	c52ad42b-c3d2-4954-b843-139939b1b2b4	ACCEPTED	6	872	2026-06-19 01:57:50.086874+07	\N	\N	-309452\n
7412	442	112	436eecde-d468-4567-ab0a-4e6c645d77e7	ACCEPTED	7	872	2026-06-19 01:57:50.086874+07	\N	\N	649261\n
7424	442	124	6b56399e-5341-4cdc-a530-d6cb7c00ef57	ACCEPTED	5	1084	2026-06-19 01:57:50.086879+07	\N	\N	1610593689\n
7430	442	130	cbb60b26-4ebd-4dcb-99ac-e15dc38d7f5e	ACCEPTED	5	1016	2026-06-19 01:57:50.086881+07	\N	\N	-5\n
7433	442	133	e31ec06d-6e39-4bcd-8c30-21961aad621c	ACCEPTED	4	1056	2026-06-19 01:57:50.086883+07	\N	\N	-57\n
7435	442	135	85463891-8ad7-4bcf-90a1-a294a1c26e03	ACCEPTED	4	1068	2026-06-19 01:57:50.086883+07	\N	\N	3\n
8943	460	21	e41e46ef-b530-499b-b10b-adada8d38f13	ACCEPTED	5	1016	2026-06-21 02:01:32.405687+07	\N	\N	3
7445	443	27	c70d47b9-aaf3-486f-a38e-15a29f250941	ACCEPTED	4	1032	2026-06-19 02:01:37.06248+07	\N	\N	1000\n
7447	443	29	bace835a-a0b9-455b-8643-02433fa46576	ACCEPTED	5	868	2026-06-19 02:01:37.062482+07	\N	\N	99\n
7451	443	33	31ee13d6-6317-4849-ab05-16094c5a14fd	ACCEPTED	5	868	2026-06-19 02:01:37.062486+07	\N	\N	84\n
7439	443	21	109f9962-cd5a-4604-a0f1-0da867227b45	ACCEPTED	9	872	2026-06-19 02:01:37.062468+07	\N	\N	3\n
7441	443	23	f779503f-f301-4ced-a787-2542e87845c1	ACCEPTED	7	1088	2026-06-19 02:01:37.062475+07	\N	\N	0\n
7456	443	38	ba05ecb7-915a-4ded-b332-fad68aa736ff	ACCEPTED	5	1036	2026-06-19 02:01:37.062492+07	\N	\N	3000000\n
7440	443	22	8b74253c-747e-4672-9d4a-66820d1a7bf7	ACCEPTED	5	1028	2026-06-19 02:01:37.062474+07	\N	\N	30\n
7444	443	26	98597771-68fc-4984-bb1b-1d7afe1a82bc	ACCEPTED	5	1040	2026-06-19 02:01:37.062479+07	\N	\N	-30\n
7454	443	36	f0b81d38-abb4-49eb-8cd6-7c75aee59756	ACCEPTED	4	1020	2026-06-19 02:01:37.062489+07	\N	\N	801\n
7450	443	32	d5e3a971-b931-4c4c-801a-67d1cc55e002	ACCEPTED	4	1024	2026-06-19 02:01:37.062485+07	\N	\N	0\n
7442	443	24	b526d027-642c-4afb-9007-1e6a4d53d69c	ACCEPTED	5	1096	2026-06-19 02:01:37.062477+07	\N	\N	0\n
7453	443	35	8d655e22-e5d6-4be4-9bec-663c75e470e1	ACCEPTED	6	1040	2026-06-19 02:01:37.062488+07	\N	\N	-2\n
7458	443	58	152489b9-fc3c-4966-83d8-e8aed4cf5468	ACCEPTED	4	1024	2026-06-19 02:01:37.062494+07	\N	\N	803799\n
7449	443	31	6b4bda2e-f7e8-4131-9b51-ec175c73b678	ACCEPTED	5	868	2026-06-19 02:01:37.062484+07	\N	\N	30000\n
7461	443	61	04d20349-c825-4a2f-a3f7-5006da265db9	ACCEPTED	5	1096	2026-06-19 02:01:37.062497+07	\N	\N	879721\n
7452	443	34	b1e81b0f-2118-4aec-9b2f-1e5e4de82322	ACCEPTED	4	880	2026-06-19 02:01:37.062487+07	\N	\N	15\n
7455	443	37	e243cd65-3438-4bfc-9890-0e07de9458a3	ACCEPTED	5	1028	2026-06-19 02:01:37.06249+07	\N	\N	1000\n
7459	443	59	23fa9ec3-8763-464b-9598-1be92aae967f	ACCEPTED	7	1024	2026-06-19 02:01:37.062495+07	\N	\N	545178\n
7462	443	62	c1c32c59-e4f4-42f9-8ee3-80ef53c92be0	ACCEPTED	5	1028	2026-06-19 02:01:37.062498+07	\N	\N	1486218\n
7460	443	60	f3cf9df0-fc71-44d1-9366-d6daa222360d	ACCEPTED	5	864	2026-06-19 02:01:37.062496+07	\N	\N	380371\n
7463	443	63	a01a7cd9-dc0a-4364-b984-ea549a1ddd73	ACCEPTED	5	1084	2026-06-19 02:01:37.062499+07	\N	\N	1507378\n
7472	443	72	21e07d7c-9203-4c09-98e4-1d4ce07d3e58	ACCEPTED	5	872	2026-06-19 02:01:37.062507+07	\N	\N	1011312\n
7464	443	64	03124934-b011-4e83-8ce1-1fe3a523a41c	ACCEPTED	6	1020	2026-06-19 02:01:37.0625+07	\N	\N	710339\n
7470	443	70	631d3249-df2d-4ae4-9203-b2399bfbfd85	ACCEPTED	5	880	2026-06-19 02:01:37.062505+07	\N	\N	959298\n
7473	443	73	fb20e3a8-96b5-439c-b086-024157b6f959	ACCEPTED	5	1020	2026-06-19 02:01:37.062509+07	\N	\N	702179\n
7466	443	66	74a8dfc8-eced-4426-bc6e-8e36b542208d	ACCEPTED	5	868	2026-06-19 02:01:37.062501+07	\N	\N	129492\n
7468	443	68	a6e3baca-ea6d-4053-882f-3c4f79de18f0	ACCEPTED	5	1008	2026-06-19 02:01:37.062504+07	\N	\N	1161167\n
7475	443	75	c2dbf684-b146-410d-9b34-b82979020f88	ACCEPTED	9	988	2026-06-19 02:01:37.062511+07	\N	\N	1760278\n
7471	443	71	4f7a96ce-a08f-467a-8252-0b8e304c2b8c	ACCEPTED	5	1032	2026-06-19 02:01:37.062506+07	\N	\N	1416847\n
7481	443	81	b5b644b1-55cd-461b-9b9a-423b76b06348	ACCEPTED	4	1136	2026-06-19 02:01:37.062516+07	\N	\N	-846475\n
7482	443	82	d641d8e1-efe3-474e-8d76-a484fc1283fb	ACCEPTED	7	1024	2026-06-19 02:01:37.062517+07	\N	\N	-1795574\n
7480	443	80	886257b0-f5e8-4ccf-bc53-333bdc7114d9	ACCEPTED	5	864	2026-06-19 02:01:37.062516+07	\N	\N	-1611196\n
7474	443	74	ae6cc176-b0f0-468d-9826-5258c36995cb	ACCEPTED	5	1020	2026-06-19 02:01:37.06251+07	\N	\N	909595\n
7478	443	78	169aeb42-5cf9-4207-884b-1200af191e9a	ACCEPTED	4	1028	2026-06-19 02:01:37.062514+07	\N	\N	-824805\n
7477	443	77	fe481381-a7eb-434d-9ba2-5d83364e0b68	ACCEPTED	4	944	2026-06-19 02:01:37.062513+07	\N	\N	-987624\n
7476	443	76	8828a905-eaa4-4202-bb51-1abe0e8b0887	ACCEPTED	5	1088	2026-06-19 02:01:37.062511+07	\N	\N	802483\n
7483	443	83	dda722a7-bf7b-47e0-b8e6-cfd869e92b1f	ACCEPTED	5	1024	2026-06-19 02:01:37.062518+07	\N	\N	-1500204\n
7485	443	85	f3d0fd8e-7ca6-4a68-aed7-1c8a452a10bd	ACCEPTED	4	1020	2026-06-19 02:01:37.06252+07	\N	\N	-1006285\n
7484	443	84	40d5d617-9e7b-4437-8fbe-70956a00bc2d	ACCEPTED	4	1024	2026-06-19 02:01:37.062519+07	\N	\N	-734921\n
7487	443	87	f1d3c438-d164-4e26-a643-471e9827b931	ACCEPTED	6	984	2026-06-19 02:01:37.062522+07	\N	\N	-1189260\n
7492	443	92	1ecb2e0d-346a-4479-b5d5-77b6258620f1	ACCEPTED	6	836	2026-06-19 02:01:37.062528+07	\N	\N	-471131\n
7489	443	89	4e3028db-656e-4499-b5b6-c80c1630c660	ACCEPTED	4	1056	2026-06-19 02:01:37.062525+07	\N	\N	-902015\n
7490	443	90	7dd277ea-1c7c-4d91-84bc-5a7ceb479cf0	ACCEPTED	4	828	2026-06-19 02:01:37.062526+07	\N	\N	-1520451\n
7494	443	94	f751255c-b938-46e0-92ae-deff9c55d14e	ACCEPTED	5	1004	2026-06-19 02:01:37.062529+07	\N	\N	-717234\n
7488	443	88	f4165825-fe0a-417c-9337-84addf89e2a4	ACCEPTED	4	816	2026-06-19 02:01:37.062523+07	\N	\N	-955984\n
7497	443	97	7731e5f7-5f78-474b-a148-0778659cec08	ACCEPTED	5	1052	2026-06-19 02:01:37.062532+07	\N	\N	-517131\n
7495	443	95	41a62bfe-ba42-40a0-855e-7255e1050362	ACCEPTED	6	856	2026-06-19 02:01:37.06253+07	\N	\N	-1192974\n
7496	443	96	4e963608-e54d-4b76-8178-ff6fac37d4e6	ACCEPTED	4	988	2026-06-19 02:01:37.062531+07	\N	\N	-1188270\n
7443	443	25	51c97246-241b-41bd-beaf-8d6e77e8fce0	ACCEPTED	5	880	2026-06-19 02:01:37.062478+07	\N	\N	300\n
7457	443	57	9fde1c01-2acd-4a01-871d-866565821573	ACCEPTED	5	844	2026-06-19 02:01:37.062493+07	\N	\N	787228\n
7446	443	28	2c067492-8ced-48a4-b69a-5ad35ce6eb2c	ACCEPTED	8	1032	2026-06-19 02:01:37.062481+07	\N	\N	579\n
7448	443	30	51dd89c5-c4ff-4f90-9d98-3a789e878a81	ACCEPTED	4	1080	2026-06-19 02:01:37.062483+07	\N	\N	0\n
7469	443	69	81e88243-2160-4c72-8f75-24027a1efd65	ACCEPTED	5	1024	2026-06-19 02:01:37.062504+07	\N	\N	616334\n
7467	443	67	5a7793c2-08aa-42eb-b43c-7b82db158db9	ACCEPTED	6	876	2026-06-19 02:01:37.062502+07	\N	\N	473222\n
7465	443	65	046927ad-3e20-40e2-826d-d354319466ae	ACCEPTED	6	876	2026-06-19 02:01:37.062501+07	\N	\N	475745\n
7479	443	79	fb35ac00-c944-4d2d-9e3c-3f5c983b2bde	ACCEPTED	7	876	2026-06-19 02:01:37.062515+07	\N	\N	-1351853\n
7486	443	86	41cabc95-dad3-4b6b-82f5-a7fc34a1423c	ACCEPTED	5	864	2026-06-19 02:01:37.062521+07	\N	\N	-876295\n
7491	443	91	b9976c9a-1ce2-451f-9903-ade2654f335b	ACCEPTED	5	1092	2026-06-19 02:01:37.062527+07	\N	\N	-1113725\n
7493	443	93	2b472738-ab66-4472-91c2-bc868918f655	ACCEPTED	7	1096	2026-06-19 02:01:37.062529+07	\N	\N	-422973\n
7503	443	103	7c841563-f111-42b4-841c-4c140917a7f4	ACCEPTED	5	1036	2026-06-19 02:01:37.062538+07	\N	\N	283996\n
7500	443	100	389e927a-ca4c-4b8f-a335-2d59e06f0995	ACCEPTED	4	884	2026-06-19 02:01:37.062535+07	\N	\N	281928\n
7506	443	106	63516656-aac9-4382-965e-5431873543d9	ACCEPTED	4	1024	2026-06-19 02:01:37.062541+07	\N	\N	-815576\n
7498	443	98	b3a32302-1aab-4f2b-a720-8ff25fc00db6	ACCEPTED	6	1028	2026-06-19 02:01:37.062533+07	\N	\N	99178\n
7502	443	102	178b7831-6b30-44cf-a4bb-79effc5d3bb2	ACCEPTED	9	864	2026-06-19 02:01:37.062537+07	\N	\N	-619866\n
7499	443	99	056052f4-f88c-466b-8a72-0d83a6d808ff	ACCEPTED	4	840	2026-06-19 02:01:37.062534+07	\N	\N	-1225775\n
7505	443	105	e7066453-4ebf-4660-a45f-c04f65f33caf	ACCEPTED	5	988	2026-06-19 02:01:37.06254+07	\N	\N	-882565\n
7501	443	101	f78d5248-7049-4077-9ba4-0b211ab0711b	ACCEPTED	5	1092	2026-06-19 02:01:37.062536+07	\N	\N	28962\n
7504	443	104	94857672-9dc4-41be-a428-b340388b2c39	ACCEPTED	6	1032	2026-06-19 02:01:37.062539+07	\N	\N	514364\n
7508	443	108	dcc6f22a-028b-4a27-bd1f-d694c37cf428	ACCEPTED	4	864	2026-06-19 02:01:37.062543+07	\N	\N	1436130\n
7510	443	110	42fe9cf2-081c-47db-bf50-210bb6984eb5	ACCEPTED	4	1060	2026-06-19 02:01:37.062545+07	\N	\N	-572819\n
7509	443	109	7eef4010-c2f9-420a-8733-e92e9a53add5	ACCEPTED	5	1016	2026-06-19 02:01:37.062544+07	\N	\N	792531\n
7507	443	107	7d745cf6-429e-410c-a443-40c60a807c40	ACCEPTED	5	876	2026-06-19 02:01:37.062542+07	\N	\N	-34648\n
7511	443	111	610546ee-0555-4795-bf34-c7d9e7ea4361	ACCEPTED	5	1092	2026-06-19 02:01:37.062546+07	\N	\N	-309452\n
7515	443	115	babd91d7-9bc3-48ac-89ee-6afc3bea78f6	ACCEPTED	4	888	2026-06-19 02:01:37.06255+07	\N	\N	506806\n
7512	443	112	07295033-b667-45ec-96bd-ccab22074e35	ACCEPTED	5	1100	2026-06-19 02:01:37.062547+07	\N	\N	649261\n
7513	443	113	90ed9d38-27d9-476a-8077-f3e73f1e9f1f	ACCEPTED	5	880	2026-06-19 02:01:37.062548+07	\N	\N	-1143916\n
7521	443	121	e3675b12-95fa-45b2-ade8-15afd00ec63c	ACCEPTED	5	920	2026-06-19 02:01:37.062556+07	\N	\N	1259817393\n
7519	443	119	17be4433-eb08-4232-a695-3d9be41acfec	ACCEPTED	6	1044	2026-06-19 02:01:37.062554+07	\N	\N	-738231997\n
7516	443	116	84837f8a-49d9-4478-9315-5145212c8b3f	ACCEPTED	6	876	2026-06-19 02:01:37.062551+07	\N	\N	785356\n
7522	443	122	46a56599-e58f-42c3-a516-6aca086650ee	ACCEPTED	7	1100	2026-06-19 02:01:37.062557+07	\N	\N	-457820119\n
7518	443	118	c15d2adc-8a0c-4b79-8b95-ef0950750d62	ACCEPTED	5	1096	2026-06-19 02:01:37.062553+07	\N	\N	636465324\n
7514	443	114	e1f1aab1-e9ba-4c59-be05-ebf8cc7fc1f2	ACCEPTED	6	1004	2026-06-19 02:01:37.062549+07	\N	\N	-234796\n
7523	443	123	8d8a4e1c-a162-43a1-a103-d45e3c011480	ACCEPTED	4	920	2026-06-19 02:01:37.062558+07	\N	\N	1422690276\n
7525	443	125	50b80f68-050b-4352-b679-a82cf8090ebb	ACCEPTED	5	892	2026-06-19 02:01:37.06256+07	\N	\N	86961293\n
7517	443	117	8068472f-414b-4802-9542-d3cba52f7bc7	ACCEPTED	5	1092	2026-06-19 02:01:37.062552+07	\N	\N	362210245\n
7520	443	120	ddacaf61-51ad-4609-8bbb-867cda585ec4	ACCEPTED	4	880	2026-06-19 02:01:37.062555+07	\N	\N	371467497\n
7529	443	129	70f7c261-0801-483e-9ac0-32d89e0194a6	ACCEPTED	6	1048	2026-06-19 02:01:37.062564+07	\N	\N	-32\n
7524	443	124	0c7f3307-d02b-48fe-bc09-400c2ee8f12d	ACCEPTED	5	1000	2026-06-19 02:01:37.062559+07	\N	\N	1610593689\n
7533	443	133	5ab54dc7-bf92-4f25-ae43-cc3d360d7548	ACCEPTED	10	1056	2026-06-19 02:01:37.062568+07	\N	\N	-57\n
7528	443	128	4389ad61-c746-431b-bf48-58d12fa77f07	ACCEPTED	4	988	2026-06-19 02:01:37.062563+07	\N	\N	82\n
7526	443	126	2f925f93-89b5-42c4-a818-2b862ceb5329	ACCEPTED	5	1044	2026-06-19 02:01:37.062561+07	\N	\N	-882105735\n
7532	443	132	6cb62f4a-7587-4b50-aca0-0321b112f45f	ACCEPTED	4	868	2026-06-19 02:01:37.062567+07	\N	\N	-1\n
7534	443	134	8cb26e28-98e2-48c9-9e13-b7af59c7d0ae	ACCEPTED	3	860	2026-06-19 02:01:37.062569+07	\N	\N	158\n
7531	443	131	8a86d668-f389-451f-bb53-1bf2c634783d	ACCEPTED	4	1032	2026-06-19 02:01:37.062566+07	\N	\N	71\n
7527	443	127	b38523d7-7e09-42b9-8a78-7378c557a3ea	ACCEPTED	4	880	2026-06-19 02:01:37.062562+07	\N	\N	0\n
7530	443	130	dfb33d63-3af0-4123-ae90-c4ed010f4399	ACCEPTED	4	920	2026-06-19 02:01:37.062565+07	\N	\N	-5\n
7535	443	135	2fcf080c-0c2d-4099-ace5-64cfd2748ebe	ACCEPTED	2	1068	2026-06-19 02:01:37.06257+07	\N	\N	3\n
7536	443	136	0c4bff0c-af29-48a3-ac83-cb20bcfbe8db	ACCEPTED	4	1368	2026-06-19 02:01:37.062571+07	\N	\N	129\n
7537	443	137	5daacf9d-fe93-4502-a52e-c5a608bfbf17	ACCEPTED	3	1056	2026-06-19 02:01:37.062572+07	\N	\N	64\n
7538	443	138	bcc97505-06f8-4bb3-b566-f2a091d188f5	ACCEPTED	2	1056	2026-06-19 02:01:37.062573+07	\N	\N	51\n
8945	460	23	e24c1cc2-f406-4827-930f-9420d30b6409	ACCEPTED	5	1016	2026-06-21 02:01:32.405706+07	\N	\N	0
7542	444	24	418fd3d8-b954-4d6c-84ac-42edda950aea	ACCEPTED	5	1124	2026-06-19 05:13:55.667154+07	\N	\N	0\n
7546	444	28	245af886-7d8b-4e3d-9eac-1af566e203d3	ACCEPTED	15	1540	2026-06-19 05:13:55.667165+07	\N	\N	579\n
7543	444	25	57a33722-3b47-45c2-aef0-f485a604ed1a	ACCEPTED	15	1612	2026-06-19 05:13:55.667157+07	\N	\N	300\n
7541	444	23	da084966-dc74-40bb-aaf8-ad2b9a4fffd2	ACCEPTED	5	1032	2026-06-19 05:13:55.667151+07	\N	\N	0\n
7545	444	27	f72a69e0-7407-42a3-90f4-b7e4a4c78aad	ACCEPTED	9	4908	2026-06-19 05:13:55.667162+07	\N	\N	1000\n
7540	444	22	e1ecaeb6-e32c-4a29-a473-ef9e4d4fef1c	ACCEPTED	5	1052	2026-06-19 05:13:55.667148+07	\N	\N	30\n
8953	460	31	7f496156-a034-4f7a-83e5-363547c5e9a7	ACCEPTED	4	868	2026-06-21 02:01:32.405719+07	\N	\N	30000
7556	444	38	645527cf-53a2-47a7-a5ed-fb1b90fdfaa2	ACCEPTED	5	1300	2026-06-19 05:13:55.667204+07	\N	\N	3000000\n
7550	444	32	9518d82b-1e2b-4084-b24d-76ff12624650	ACCEPTED	6	1044	2026-06-19 05:13:55.667178+07	\N	\N	0\n
7560	444	60	b56151b5-ff33-4725-87be-931cf2b968e9	ACCEPTED	6	884	2026-06-19 05:13:55.667214+07	\N	\N	380371\n
7549	444	31	7ed02a0d-a17b-49b4-a2a0-1526445959d9	ACCEPTED	6	1024	2026-06-19 05:13:55.667175+07	\N	\N	30000\n
7558	444	58	8d7fb2aa-9270-4f76-822c-77f292b6585d	ACCEPTED	8	1964	2026-06-19 05:13:55.667209+07	\N	\N	803799\n
7548	444	30	118953ce-8285-4e7a-bbdb-685b2fd172ba	ACCEPTED	5	1080	2026-06-19 05:13:55.66717+07	\N	\N	0\n
7562	444	62	0fc36477-608c-4e5e-8811-5529374c53cc	ACCEPTED	17	876	2026-06-19 05:13:55.667219+07	\N	\N	1486218\n
7561	444	61	b381819e-6ed5-4f25-9cca-2049ee15e92d	ACCEPTED	5	932	2026-06-19 05:13:55.667217+07	\N	\N	879721\n
7557	444	57	13ba3743-157a-4748-953c-4811fc995ee1	ACCEPTED	6	888	2026-06-19 05:13:55.667207+07	\N	\N	787228\n
7551	444	33	fa7485b8-f275-4d0e-93db-a6ff06e2bf3e	ACCEPTED	5	904	2026-06-19 05:13:55.667186+07	\N	\N	84\n
7555	444	37	f6f14380-b392-46f1-8c8c-0a7546e51c13	ACCEPTED	5	876	2026-06-19 05:13:55.667197+07	\N	\N	1000\n
7554	444	36	c3a938b3-0361-4fd8-8bbc-cb8ce725f9a8	ACCEPTED	5	892	2026-06-19 05:13:55.667194+07	\N	\N	801\n
7567	444	67	44354ade-7fff-4e9b-b9f3-f4c3861a0c49	ACCEPTED	5	1028	2026-06-19 05:13:55.667231+07	\N	\N	473222\n
7568	444	68	b9f3041f-fa4c-4a6e-baff-bfbdfbeff22f	ACCEPTED	7	1048	2026-06-19 05:13:55.667234+07	\N	\N	1161167\n
7566	444	66	db9ac329-a9cf-4c8e-9157-4ac492ff7184	ACCEPTED	16	1028	2026-06-19 05:13:55.667229+07	\N	\N	129492\n
7570	444	70	b4333d5e-3621-488a-818e-1af162400e15	ACCEPTED	5	884	2026-06-19 05:13:55.667238+07	\N	\N	959298\n
7575	444	75	0069d95c-b12c-4eb9-a375-1df90fe94d9d	ACCEPTED	5	1056	2026-06-19 05:13:55.667251+07	\N	\N	1760278\n
7565	444	65	99223da0-710e-4280-85cb-5e8a4a121dd6	ACCEPTED	6	1100	2026-06-19 05:13:55.667226+07	\N	\N	475745\n
7576	444	76	f84bf9ad-9a00-4f5d-979d-8f697c185fde	ACCEPTED	10	1112	2026-06-19 05:13:55.667253+07	\N	\N	802483\n
7582	444	82	3e901ba1-52cd-492b-8591-bb2fb8afdab0	ACCEPTED	4	1032	2026-06-19 05:13:55.667268+07	\N	\N	-1795574\n
7573	444	73	afeb5f60-7f78-437d-a690-47a4180f14f6	ACCEPTED	6	868	2026-06-19 05:13:55.667246+07	\N	\N	702179\n
7569	444	69	6147c532-8258-4729-bf4f-605f2dac81e8	ACCEPTED	4	996	2026-06-19 05:13:55.667236+07	\N	\N	616334\n
7571	444	71	58ec2a61-5dec-41b5-b454-5c0527a57b9c	ACCEPTED	5	1044	2026-06-19 05:13:55.667241+07	\N	\N	1416847\n
7578	444	78	1b4f0719-8390-4407-871d-211322aa2feb	ACCEPTED	4	1092	2026-06-19 05:13:55.667258+07	\N	\N	-824805\n
7579	444	79	76bce6f6-564e-4972-bede-9fc36af22dbd	ACCEPTED	4	1020	2026-06-19 05:13:55.667261+07	\N	\N	-1351853\n
7581	444	81	e287b72a-5016-40cf-b2ee-61f3b9961800	ACCEPTED	6	1040	2026-06-19 05:13:55.667265+07	\N	\N	-846475\n
7564	444	64	8a9b508a-9ff8-470a-8590-00de6f155157	ACCEPTED	5	972	2026-06-19 05:13:55.667224+07	\N	\N	710339\n
7583	444	83	29d44749-8b72-4bc0-88d3-acc4677157c4	ACCEPTED	6	888	2026-06-19 05:13:55.66727+07	\N	\N	-1500204\n
7584	444	84	4144cc9e-a60a-4262-8549-dd8a230b6c75	ACCEPTED	8	900	2026-06-19 05:13:55.667272+07	\N	\N	-734921\n
7585	444	85	a0a5be47-2499-4d85-b9b9-b41aa0c4ea57	ACCEPTED	5	1036	2026-06-19 05:13:55.667275+07	\N	\N	-1006285\n
7574	444	74	02c00299-ad24-4a63-9fb2-a30b602b66a8	ACCEPTED	8	1036	2026-06-19 05:13:55.667248+07	\N	\N	909595\n
7586	444	86	75e698e8-325f-4c69-9fcd-8b4a57131bee	ACCEPTED	5	1116	2026-06-19 05:13:55.667277+07	\N	\N	-876295\n
7590	444	90	539bebc7-1bdb-4157-af16-f96a908fb4b7	ACCEPTED	6	972	2026-06-19 05:13:55.667287+07	\N	\N	-1520451\n
7587	444	87	db3c8682-567b-4167-b8ca-64fd959c2e3f	ACCEPTED	6	1104	2026-06-19 05:13:55.66728+07	\N	\N	-1189260\n
7589	444	89	208d58a9-6e46-4116-af64-5a5eb395d07f	ACCEPTED	5	1040	2026-06-19 05:13:55.667285+07	\N	\N	-902015\n
7593	444	93	00fd4314-28f6-4afb-b400-e008ace7f7c4	ACCEPTED	7	1036	2026-06-19 05:13:55.667294+07	\N	\N	-422973\n
7599	444	99	2f1119a6-18b3-441d-9a61-43087275a179	ACCEPTED	5	1020	2026-06-19 05:13:55.667308+07	\N	\N	-1225775\n
7604	444	104	4099310a-70dd-46af-8094-395fc3310799	ACCEPTED	5	864	2026-06-19 05:13:55.667323+07	\N	\N	514364\n
7600	444	100	12d8b472-dd3b-425b-b5da-fc64bd161d8e	ACCEPTED	5	1012	2026-06-19 05:13:55.667311+07	\N	\N	281928\n
7588	444	88	b22e9a51-54b8-48f0-b168-c4c5bc1b6810	ACCEPTED	12	1028	2026-06-19 05:13:55.667282+07	\N	\N	-955984\n
7592	444	92	101f7585-f7a1-4b51-8027-eaab805f1d9b	ACCEPTED	5	936	2026-06-19 05:13:55.667292+07	\N	\N	-471131\n
7597	444	97	93778e89-6ffa-4193-b9c4-7f4a2eeb5aed	ACCEPTED	6	1036	2026-06-19 05:13:55.667304+07	\N	\N	-517131\n
7603	444	103	66066452-8ab1-4c54-9dc7-9c8111ee87a2	ACCEPTED	6	852	2026-06-19 05:13:55.667319+07	\N	\N	283996\n
7601	444	101	e857bd6f-c20b-4afb-8422-dfa8c74e17e7	ACCEPTED	6	864	2026-06-19 05:13:55.667313+07	\N	\N	28962\n
7598	444	98	59fb5056-3e79-4cc3-b964-e4b843b31b0c	ACCEPTED	6	1008	2026-06-19 05:13:55.667306+07	\N	\N	99178\n
7606	444	106	6d229302-6004-4c74-9695-e28f8f71e60f	ACCEPTED	5	1084	2026-06-19 05:13:55.667328+07	\N	\N	-815576\n
7594	444	94	112a38fc-97e3-49ec-ada6-11ff737fd077	ACCEPTED	5	1008	2026-06-19 05:13:55.667296+07	\N	\N	-717234\n
7591	444	91	3306beb3-dfc9-4931-a220-11c900dde514	ACCEPTED	21	876	2026-06-19 05:13:55.667289+07	\N	\N	-1113725\n
7609	444	109	079cc0a1-3420-470f-a7a4-48d589881694	ACCEPTED	10	872	2026-06-19 05:13:55.667335+07	\N	\N	792531\n
7607	444	107	07002842-e2ca-4177-8194-073ada8ea2f3	ACCEPTED	5	1084	2026-06-19 05:13:55.667331+07	\N	\N	-34648\n
7608	444	108	ec9cfb75-3782-4a94-8b11-243568f87cb3	ACCEPTED	6	872	2026-06-19 05:13:55.667333+07	\N	\N	1436130\n
7612	444	112	eaddd2a8-021e-40bf-a899-327dd9264f8f	ACCEPTED	5	1020	2026-06-19 05:13:55.667342+07	\N	\N	649261\n
7611	444	111	72e32669-2aab-425d-a4dc-2b580f90e592	ACCEPTED	5	1096	2026-06-19 05:13:55.66734+07	\N	\N	-309452\n
7613	444	113	e4020203-a82a-4c64-a0fb-77d84c30c3f8	ACCEPTED	12	972	2026-06-19 05:13:55.667345+07	\N	\N	-1143916\n
7616	444	116	1e32715a-b9ac-4fe3-953b-6579c6346af5	ACCEPTED	7	1024	2026-06-19 05:13:55.667353+07	\N	\N	785356\n
7614	444	114	8b7a07de-4caf-4f65-a6f6-fed5b7012ee7	ACCEPTED	6	1028	2026-06-19 05:13:55.667347+07	\N	\N	-234796\n
7615	444	115	e75f102c-2ee2-46c1-aadc-3904d42e3bde	ACCEPTED	5	1024	2026-06-19 05:13:55.66735+07	\N	\N	506806\n
7559	444	59	be5e6cda-e765-48f1-959d-ab3f1140e993	ACCEPTED	8	7936	2026-06-19 05:13:55.667211+07	\N	\N	545178\n
7544	444	26	29d53719-0e47-44ed-92a6-f238026edae0	ACCEPTED	6	8956	2026-06-19 05:13:55.667159+07	\N	\N	-30\n
7547	444	29	b166554a-ffd5-4dba-aa1e-c824de9cd0bf	ACCEPTED	9	5912	2026-06-19 05:13:55.667168+07	\N	\N	99\n
7539	444	21	804e77c1-a469-4d3b-b16b-71480fe6f7b1	ACCEPTED	5	896	2026-06-19 05:13:55.667135+07	\N	\N	3\n
7553	444	35	47370a39-22bc-48ed-b1b9-848e2a7fdd81	ACCEPTED	6	6844	2026-06-19 05:13:55.667191+07	\N	\N	-2\n
7552	444	34	5d53c0a8-32bf-4763-a189-49b5cea08401	ACCEPTED	5	1184	2026-06-19 05:13:55.667188+07	\N	\N	15\n
7572	444	72	14ae9313-e528-4300-b2ec-bcc63a92f16e	ACCEPTED	6	1056	2026-06-19 05:13:55.667243+07	\N	\N	1011312\n
7580	444	80	a3dc1032-768d-4ca9-8009-5075af3aebd9	ACCEPTED	5	888	2026-06-19 05:13:55.667263+07	\N	\N	-1611196\n
7577	444	77	3fc69249-ee00-4e2d-a821-859b3c1316dc	ACCEPTED	5	868	2026-06-19 05:13:55.667255+07	\N	\N	-987624\n
7563	444	63	81cbaae7-07e1-459a-9a7e-47d05d76c60a	ACCEPTED	6	1028	2026-06-19 05:13:55.667222+07	\N	\N	1507378\n
7595	444	95	98a6a2fa-694b-4915-b3bf-aed5abb9bebb	ACCEPTED	7	1100	2026-06-19 05:13:55.667299+07	\N	\N	-1192974\n
7596	444	96	eb16b6c3-d5d4-4cc2-8b6e-564af4742f84	ACCEPTED	5	1116	2026-06-19 05:13:55.667301+07	\N	\N	-1188270\n
7602	444	102	22e44cda-a074-47b4-8dc5-9f5519272445	ACCEPTED	6	1040	2026-06-19 05:13:55.667315+07	\N	\N	-619866\n
7605	444	105	c4cf0954-c655-4c66-bdbd-e0f6c9e5ae58	ACCEPTED	5	1020	2026-06-19 05:13:55.667325+07	\N	\N	-882565\n
7610	444	110	90559d88-4090-46ed-8de3-0ae445bbac5f	ACCEPTED	15	892	2026-06-19 05:13:55.667338+07	\N	\N	-572819\n
7617	444	117	0f510853-0df0-4a2c-8800-e2128d211eb4	ACCEPTED	6	1024	2026-06-19 05:13:55.667355+07	\N	\N	362210245\n
7623	444	123	9c1d3467-d015-4b95-9d67-7ed3fdeaf588	ACCEPTED	7	1008	2026-06-19 05:13:55.667371+07	\N	\N	1422690276\n
7621	444	121	39d18fed-1f8d-4245-a3e8-0ba0fa74cc42	ACCEPTED	5	1032	2026-06-19 05:13:55.667366+07	\N	\N	1259817393\n
7628	444	128	b3880e64-03b2-460d-80cf-02998e3168bf	ACCEPTED	5	1016	2026-06-19 05:13:55.667383+07	\N	\N	82\n
7619	444	119	173c9e4d-5f3b-4679-8126-825ad70e6089	ACCEPTED	7	980	2026-06-19 05:13:55.66736+07	\N	\N	-738231997\n
7620	444	120	88255392-9eb8-454e-80bd-802b357585f2	ACCEPTED	6	1036	2026-06-19 05:13:55.667364+07	\N	\N	371467497\n
7622	444	122	35ebfa69-41cf-48a7-a944-f8f4e9930e57	ACCEPTED	6	1032	2026-06-19 05:13:55.667368+07	\N	\N	-457820119\n
7618	444	118	81932892-8bc1-45f2-b208-69dc2c39b6fb	ACCEPTED	6	1024	2026-06-19 05:13:55.667358+07	\N	\N	636465324\n
7629	444	129	bfa27797-2477-443c-8bc1-05e97025efe3	ACCEPTED	8	1112	2026-06-19 05:13:55.667386+07	\N	\N	-32\n
7625	444	125	b059a7d7-6c5e-49cf-a0d8-9a93df47698f	ACCEPTED	7	1012	2026-06-19 05:13:55.667376+07	\N	\N	86961293\n
7624	444	124	9f28a5ed-81dd-4429-9616-f9252ee6bdd9	ACCEPTED	9	1028	2026-06-19 05:13:55.667374+07	\N	\N	1610593689\n
7627	444	127	162cf163-9411-4a0e-aea4-39d01346af25	ACCEPTED	5	880	2026-06-19 05:13:55.667381+07	\N	\N	0\n
7630	444	130	5b43e1db-ad02-494f-857d-48c5aacff676	ACCEPTED	6	868	2026-06-19 05:13:55.667388+07	\N	\N	-5\n
7626	444	126	b9d5ce7b-4275-41cc-891d-3ac679c8ee7b	ACCEPTED	9	1028	2026-06-19 05:13:55.667379+07	\N	\N	-882105735\n
7633	444	133	1de6e574-c653-4898-bef2-8aedde3cd7d9	ACCEPTED	5	932	2026-06-19 05:13:55.667395+07	\N	\N	-57\n
7632	444	132	65a4752e-1cb5-447c-9a1f-53c6edf2f42a	ACCEPTED	5	1060	2026-06-19 05:13:55.667393+07	\N	\N	-1\n
7631	444	131	99652e30-f660-4321-aec1-a763e09e7e9c	ACCEPTED	5	1252	2026-06-19 05:13:55.667391+07	\N	\N	71\n
7635	444	135	bfb4a378-dc11-4551-858a-6544806d4d07	ACCEPTED	4	1240	2026-06-19 05:13:55.667401+07	\N	\N	3\n
7634	444	134	3049981d-2d2f-47a3-a353-043b852e9b2c	ACCEPTED	4	1052	2026-06-19 05:13:55.667398+07	\N	\N	158\n
7636	444	136	d191785e-2da2-49db-bf44-db43d92f2568	ACCEPTED	4	1052	2026-06-19 05:13:55.667403+07	\N	\N	129\n
7637	444	137	bdba8f44-e453-410a-ac05-7b3bfd21f73a	ACCEPTED	3	1052	2026-06-19 05:13:55.667406+07	\N	\N	64\n
7638	444	138	08367fab-7106-4092-9f67-3c464bb867a5	ACCEPTED	2	1052	2026-06-19 05:13:55.667408+07	\N	\N	51\n
7639	445	5	8701fc6e-61f0-4e42-ba11-ebff9bd5d612	ACCEPTED	2	1176	2026-06-19 05:15:07.433295+07	\N	\N	YES\n
7640	445	6	9707b746-e884-424b-a27a-4c8b9f0047b7	ACCEPTED	2	1344	2026-06-19 05:15:07.433299+07	\N	\N	NO\n
8946	460	24	917221e7-a102-41de-8e77-119f66a66ab5	ACCEPTED	5	828	2026-06-21 02:01:32.405708+07	\N	\N	0
7652	446	32	07052cdb-607b-4e1b-b2a7-b7708ab1cc73	ACCEPTED	5	876	2026-06-19 05:15:13.763159+07	\N	\N	0\n
7643	446	23	4f5acf1c-711c-434e-862e-65349473bd65	ACCEPTED	6	1096	2026-06-19 05:15:13.763132+07	\N	\N	0\n
7648	446	28	a7aa46cb-f09b-459e-a424-bbf4c0ecd502	ACCEPTED	5	872	2026-06-19 05:15:13.763147+07	\N	\N	579\n
7644	446	24	fe102f47-2f54-4716-a124-82f914ad2f31	ACCEPTED	5	884	2026-06-19 05:15:13.763135+07	\N	\N	0\n
7642	446	22	10523eb1-a990-4a67-b2d3-269a3339316d	ACCEPTED	7	1080	2026-06-19 05:15:13.763129+07	\N	\N	30\n
7646	446	26	9d4325bf-f3e9-4eb8-ba98-0279c09954b5	ACCEPTED	5	1032	2026-06-19 05:15:13.763141+07	\N	\N	-30\n
7653	446	33	a4970a3c-c3ee-439f-be28-f0b772af6df9	ACCEPTED	7	880	2026-06-19 05:15:13.763162+07	\N	\N	84\n
7645	446	25	a395d974-d43d-4c99-8b75-04dd8f9e5b70	ACCEPTED	5	1028	2026-06-19 05:15:13.763138+07	\N	\N	300\n
7658	446	38	975f5a2e-6f7d-41dd-b82a-98b21ea5783e	ACCEPTED	6	992	2026-06-19 05:15:13.7632+07	\N	\N	3000000\n
7649	446	29	99c4a644-383a-4a2f-bbd0-7eac132dcd89	ACCEPTED	10	836	2026-06-19 05:15:13.76315+07	\N	\N	99\n
7651	446	31	baf79b5c-b07d-46d9-a1d4-72544f6aee08	ACCEPTED	6	860	2026-06-19 05:15:13.763156+07	\N	\N	30000\n
7647	446	27	ce1742e0-798f-4c21-be80-7b75eb32b635	ACCEPTED	13	868	2026-06-19 05:15:13.763144+07	\N	\N	1000\n
7660	446	58	76fbd4bf-f0d4-4d25-864a-53d76dbf4198	ACCEPTED	28	816	2026-06-19 05:15:13.763206+07	\N	\N	803799\n
7654	446	34	9dbb8bf1-87e9-44a8-8ba1-e6e1d27b98cb	ACCEPTED	5	972	2026-06-19 05:15:13.763164+07	\N	\N	15\n
7656	446	36	bdd28ffa-8a67-4f61-ae09-696243e61c99	ACCEPTED	10	876	2026-06-19 05:15:13.76317+07	\N	\N	801\n
7641	446	21	c53c6b09-c45c-428b-b3ae-a28dcec3591a	ACCEPTED	6	1096	2026-06-19 05:15:13.763122+07	\N	\N	3\n
7657	446	37	3ab7d509-6416-476e-ac56-b4abbb02d097	ACCEPTED	5	1088	2026-06-19 05:15:13.763173+07	\N	\N	1000\n
7655	446	35	176fd70b-980a-4a4a-926d-b3a56486a420	ACCEPTED	6	1096	2026-06-19 05:15:13.763167+07	\N	\N	-2\n
7659	446	57	03d0a943-266a-47b2-aa65-9d329a125c8a	ACCEPTED	5	1016	2026-06-19 05:15:13.763204+07	\N	\N	787228\n
8949	460	27	1fe63b56-880b-4b79-8afa-09d71d7ac474	ACCEPTED	6	1080	2026-06-21 02:01:32.405712+07	\N	\N	1000
8948	460	26	83aa86df-7a63-483a-a2b2-e1f7ef6e7d64	ACCEPTED	6	1032	2026-06-21 02:01:32.405711+07	\N	\N	-30
7664	446	62	30d2cd8d-93b9-43af-9f97-2bd24b305377	ACCEPTED	5	1016	2026-06-19 05:15:13.763218+07	\N	\N	1486218\n
7662	446	60	9c5dba1c-9d68-4eb0-8c92-f4d9f336bd60	ACCEPTED	5	1020	2026-06-19 05:15:13.763212+07	\N	\N	380371\n
7665	446	63	6b53b77e-b824-40f2-9969-ab8890d513da	ACCEPTED	5	1028	2026-06-19 05:15:13.763221+07	\N	\N	1507378\n
7668	446	66	7bdd3077-b137-4e99-999c-9e941a3f8beb	ACCEPTED	5	1028	2026-06-19 05:15:13.763245+07	\N	\N	129492\n
7670	446	68	9533dc78-b43b-4783-bd1c-40005c364f0a	ACCEPTED	6	1032	2026-06-19 05:15:13.76325+07	\N	\N	1161167\n
7672	446	70	06018b74-5f3f-46d2-a710-92c25d14238e	ACCEPTED	6	1020	2026-06-19 05:15:13.763256+07	\N	\N	959298\n
7667	446	65	65c5d551-ad40-4106-9ad1-34507cc19f0d	ACCEPTED	6	880	2026-06-19 05:15:13.763242+07	\N	\N	475745\n
7675	446	73	271b717a-665c-4d7f-99b2-cde7de10a52a	ACCEPTED	6	1032	2026-06-19 05:15:13.763265+07	\N	\N	702179\n
7676	446	74	b62be5bd-5c95-488d-8205-799da67f54cf	ACCEPTED	5	848	2026-06-19 05:15:13.763268+07	\N	\N	909595\n
7680	446	78	a0ce8891-65fb-4503-85f0-4c019ce530e3	ACCEPTED	5	1100	2026-06-19 05:15:13.763279+07	\N	\N	-824805\n
7683	446	81	5703e66e-dfdf-4057-945a-9e65a18cd999	ACCEPTED	7	1020	2026-06-19 05:15:13.763288+07	\N	\N	-846475\n
7681	446	79	9289e004-15ad-4608-9e93-6e97d0f344ab	ACCEPTED	7	852	2026-06-19 05:15:13.763282+07	\N	\N	-1351853\n
7682	446	80	8751dc5a-fd42-4e33-b722-72ca3ff9716c	ACCEPTED	5	880	2026-06-19 05:15:13.763285+07	\N	\N	-1611196\n
7678	446	76	eaaf0bc6-5e75-4da1-83ad-6e7e7dbc2969	ACCEPTED	5	1120	2026-06-19 05:15:13.763274+07	\N	\N	802483\n
7666	446	64	e91fad8d-e7bf-4427-942a-a32f2d4b217e	ACCEPTED	6	880	2026-06-19 05:15:13.763238+07	\N	\N	710339\n
7685	446	83	0a0a6717-b381-4a28-8bdf-ad30d811ef53	ACCEPTED	20	1016	2026-06-19 05:15:13.763294+07	\N	\N	-1500204\n
7687	446	85	b5b980b7-3d92-4fff-871e-d95ff739c8ca	ACCEPTED	4	844	2026-06-19 05:15:13.763299+07	\N	\N	-1006285\n
7686	446	84	5a066a84-ccd9-4824-85c3-7514f35f2864	ACCEPTED	10	1052	2026-06-19 05:15:13.763296+07	\N	\N	-734921\n
7669	446	67	8b57b0a3-28a3-4bd6-b179-a5c9bb8bc010	ACCEPTED	10	1048	2026-06-19 05:15:13.763248+07	\N	\N	473222\n
7677	446	75	d334231b-f69a-4006-b5a8-dd6a27d35679	ACCEPTED	4	1084	2026-06-19 05:15:13.763271+07	\N	\N	1760278\n
7684	446	82	c6e92bec-5947-4528-bae4-4c21baecd541	ACCEPTED	5	1028	2026-06-19 05:15:13.763291+07	\N	\N	-1795574\n
7694	446	92	b88b13ea-c492-40b6-8398-8b73d92831b9	ACCEPTED	5	1008	2026-06-19 05:15:13.763325+07	\N	\N	-471131\n
7691	446	89	b6fb125b-cf5e-4713-8a1d-f729dd25bc84	ACCEPTED	5	864	2026-06-19 05:15:13.763315+07	\N	\N	-902015\n
7688	446	86	3e6aa6a4-f87b-4f64-b21b-73ee124f5717	ACCEPTED	5	1088	2026-06-19 05:15:13.763304+07	\N	\N	-876295\n
7695	446	93	03dcfb36-45fa-43d3-a015-3b7b4ca6cf7a	ACCEPTED	5	1032	2026-06-19 05:15:13.763327+07	\N	\N	-422973\n
7689	446	87	aef1eb1c-7fc7-4cef-ae80-340bea691427	ACCEPTED	6	872	2026-06-19 05:15:13.763308+07	\N	\N	-1189260\n
7696	446	94	b1f02d44-6a39-4641-9e7c-879b8c65d214	ACCEPTED	5	1028	2026-06-19 05:15:13.76333+07	\N	\N	-717234\n
7702	446	100	9b3c37c1-1829-4136-86ba-a3b0946438f0	ACCEPTED	5	864	2026-06-19 05:15:13.763375+07	\N	\N	281928\n
7699	446	97	39053faa-e3b3-4d7d-9e74-1ff1ca4d540f	ACCEPTED	14	880	2026-06-19 05:15:13.763366+07	\N	\N	-517131\n
7692	446	90	3af0fe08-1b9d-491a-bc31-124ccda9b36c	ACCEPTED	5	868	2026-06-19 05:15:13.763319+07	\N	\N	-1520451\n
7701	446	99	f4de1d8a-4298-4c87-b23e-d872627083a0	ACCEPTED	7	1088	2026-06-19 05:15:13.763372+07	\N	\N	-1225775\n
7697	446	95	6946f380-148d-4281-962e-85ccf9296c55	ACCEPTED	6	844	2026-06-19 05:15:13.763333+07	\N	\N	-1192974\n
7703	446	101	0343f509-0fbe-4e50-9a45-c0213691c117	ACCEPTED	6	876	2026-06-19 05:15:13.763378+07	\N	\N	28962\n
7700	446	98	ec896323-8166-45d9-b397-002fffb7ae73	ACCEPTED	5	888	2026-06-19 05:15:13.763369+07	\N	\N	99178\n
7709	446	107	8aeb789e-904a-4d7c-813b-4329b675b766	ACCEPTED	14	1028	2026-06-19 05:15:13.763399+07	\N	\N	-34648\n
7698	446	96	aa2cb1ae-90c8-4c4e-8e70-082e1dae9417	ACCEPTED	18	876	2026-06-19 05:15:13.763363+07	\N	\N	-1188270\n
7704	446	102	f6e59850-d0d2-4e77-8c29-cc9f770e5ce8	ACCEPTED	5	1100	2026-06-19 05:15:13.76338+07	\N	\N	-619866\n
7705	446	103	9e465a89-a600-4f08-8dbc-208202500ad2	ACCEPTED	5	1084	2026-06-19 05:15:13.763388+07	\N	\N	283996\n
7706	446	104	fef56847-38cc-40bc-ac43-fc5b79b2654c	ACCEPTED	5	876	2026-06-19 05:15:13.763391+07	\N	\N	514364\n
7710	446	108	793a483a-e563-4ada-82fe-cd8febbc9bef	ACCEPTED	5	1024	2026-06-19 05:15:13.763402+07	\N	\N	1436130\n
7711	446	109	2bf09f94-5488-4973-a41e-072bb73461bb	ACCEPTED	6	852	2026-06-19 05:15:13.763405+07	\N	\N	792531\n
7716	446	114	9818064c-4f8d-4879-be70-fe40baa57920	ACCEPTED	16	1020	2026-06-19 05:15:13.763422+07	\N	\N	-234796\n
7717	446	115	f47f1441-3784-44ac-a926-5e4ac2fc7515	ACCEPTED	14	912	2026-06-19 05:15:13.763424+07	\N	\N	506806\n
7712	446	110	4a4d76dc-3502-4d77-b63b-b145e9656f78	ACCEPTED	5	1020	2026-06-19 05:15:13.763408+07	\N	\N	-572819\n
7722	446	120	74a719d8-0b0f-408d-9094-a3e4fe1231a6	ACCEPTED	6	864	2026-06-19 05:15:13.763439+07	\N	\N	371467497\n
7713	446	111	18bd8fcc-bd14-4e2d-b287-798b9cdbb37c	ACCEPTED	8	980	2026-06-19 05:15:13.76341+07	\N	\N	-309452\n
7718	446	116	c33ad355-2de9-4280-8ae9-ed66ceb410e1	ACCEPTED	5	836	2026-06-19 05:15:13.763427+07	\N	\N	785356\n
7723	446	121	e9a77702-dd81-4396-9cd1-3e365c2ccec2	ACCEPTED	6	1020	2026-06-19 05:15:13.763442+07	\N	\N	1259817393\n
7719	446	117	69806d5b-ef5a-42ef-a8ad-cb9dd0ffdec7	ACCEPTED	6	1016	2026-06-19 05:15:13.76343+07	\N	\N	362210245\n
7721	446	119	9670c434-9ad9-48db-9418-2101735fae3f	ACCEPTED	5	868	2026-06-19 05:15:13.763436+07	\N	\N	-738231997\n
7728	446	126	51d669ec-3d77-48bb-ae4b-a6b27ec5419c	ACCEPTED	9	976	2026-06-19 05:15:13.763456+07	\N	\N	-882105735\n
7715	446	113	2e304aa0-f24b-4700-a275-68a52b1b4cb7	ACCEPTED	8	1096	2026-06-19 05:15:13.763419+07	\N	\N	-1143916\n
7725	446	123	878d29c6-0df3-4cbb-8bf7-0d9410190eff	ACCEPTED	5	1012	2026-06-19 05:15:13.763447+07	\N	\N	1422690276\n
7730	446	128	521263fe-0f33-4013-891a-f0d13a48b85c	ACCEPTED	5	1088	2026-06-19 05:15:13.763461+07	\N	\N	82\n
7729	446	127	b3a17d95-a4d3-4dcf-a421-5ee620e4ac0e	ACCEPTED	9	1000	2026-06-19 05:15:13.763458+07	\N	\N	0\n
7661	446	59	a142d5d9-9a51-4142-a6c4-ea65a06cbe1a	ACCEPTED	8	1016	2026-06-19 05:15:13.76321+07	\N	\N	545178\n
7650	446	30	a669dcf4-1fc1-4a04-b955-3a269d94ddad	ACCEPTED	6	1036	2026-06-19 05:15:13.763153+07	\N	\N	0\n
7663	446	61	6564b5a6-295d-40d2-8bce-bea6245e6e85	ACCEPTED	8	1020	2026-06-19 05:15:13.763215+07	\N	\N	879721\n
7671	446	69	cf93ff34-6a74-4a6a-a133-a380d50cca1c	ACCEPTED	5	1012	2026-06-19 05:15:13.763253+07	\N	\N	616334\n
7679	446	77	c1e368af-864b-4c53-96d9-8e05c1219f2e	ACCEPTED	6	1024	2026-06-19 05:15:13.763276+07	\N	\N	-987624\n
7673	446	71	889d533e-5b2e-4298-9fc0-500d8e65819d	ACCEPTED	6	1092	2026-06-19 05:15:13.763259+07	\N	\N	1416847\n
7674	446	72	9d810a05-44c0-4acb-879a-6fe7dd9fe2e5	ACCEPTED	6	1096	2026-06-19 05:15:13.763262+07	\N	\N	1011312\n
7690	446	88	0e255151-a5db-40ea-983e-d3373061c16a	ACCEPTED	5	864	2026-06-19 05:15:13.763312+07	\N	\N	-955984\n
7693	446	91	ed171cdf-dc8e-4e4f-8704-87db2921cc0e	ACCEPTED	5	800	2026-06-19 05:15:13.763322+07	\N	\N	-1113725\n
7708	446	106	b6b35882-f3ee-4bc0-821f-eb549a151016	ACCEPTED	18	1032	2026-06-19 05:15:13.763396+07	\N	\N	-815576\n
7707	446	105	ae8fc397-fff8-4746-b842-4f6f1154f64e	ACCEPTED	5	876	2026-06-19 05:15:13.763393+07	\N	\N	-882565\n
7714	446	112	bc1f3519-5098-4064-90ba-1073fdbfb73a	ACCEPTED	13	1024	2026-06-19 05:15:13.763415+07	\N	\N	649261\n
7724	446	122	52562ac8-4b41-46c4-83bd-097473977ac2	ACCEPTED	7	1020	2026-06-19 05:15:13.763444+07	\N	\N	-457820119\n
7720	446	118	3268a720-fa13-4b4d-81a6-f33863b7c88d	ACCEPTED	5	1024	2026-06-19 05:15:13.763433+07	\N	\N	636465324\n
7727	446	125	3eb1fcf1-3cf4-4581-baa5-20ac8b09e95e	ACCEPTED	16	1032	2026-06-19 05:15:13.763453+07	\N	\N	86961293\n
7726	446	124	428a172d-e568-41e5-a5d1-6f4b7d05b37e	ACCEPTED	6	1028	2026-06-19 05:15:13.76345+07	\N	\N	1610593689\n
7732	446	130	1acfa63f-da78-4163-9603-3cd914f3979e	ACCEPTED	6	864	2026-06-19 05:15:13.763467+07	\N	\N	-5\n
7731	446	129	86124c17-0eb9-4ce3-8a46-7bba81648b42	ACCEPTED	5	1056	2026-06-19 05:15:13.763464+07	\N	\N	-32\n
7733	446	131	1737b14e-350f-4f37-a14c-6174537a9a71	ACCEPTED	9	876	2026-06-19 05:15:13.76347+07	\N	\N	71\n
7734	446	132	b95185a2-81c2-44c9-b989-b32d95e3df48	ACCEPTED	6	1052	2026-06-19 05:15:13.763472+07	\N	\N	-1\n
7735	446	133	8cc93004-3d36-4a9e-b74a-a2405e7c5aaa	ACCEPTED	5	1020	2026-06-19 05:15:13.763475+07	\N	\N	-57\n
7736	446	134	90f08b4d-1251-464d-a619-86e05f449038	ACCEPTED	3	1244	2026-06-19 05:15:13.763478+07	\N	\N	158\n
7740	446	138	076e95a5-0c11-4ad9-994b-78db56ff05ac	ACCEPTED	4	1048	2026-06-19 05:15:13.763489+07	\N	\N	51\n
7738	446	136	7071d5c1-f357-49c3-a116-b7a875c30646	ACCEPTED	4	1052	2026-06-19 05:15:13.763484+07	\N	\N	129\n
7737	446	135	80fc9169-b3b2-4195-87f6-34582ce4b810	ACCEPTED	3	1252	2026-06-19 05:15:13.763481+07	\N	\N	3\n
7739	446	137	6c81d274-6434-4300-84dd-696e00cd7208	ACCEPTED	2	1260	2026-06-19 05:15:13.763486+07	\N	\N	64\n
7741	447	21	7e94fa26-60fc-45ee-87bd-de7abbd823c2	ACCEPTED	5	1084	2026-06-19 05:16:41.887193+07	\N	\N	3
7746	447	26	3feee7af-5f5b-4222-8966-b05bd52f7624	ACCEPTED	7	1040	2026-06-19 05:16:41.8872+07	\N	\N	-30
7749	447	29	6ad4f0f0-3938-48c4-9ae4-bea4e298f9b1	ACCEPTED	6	876	2026-06-19 05:16:41.887203+07	\N	\N	99
7757	447	37	0d0b9e0c-7053-4d31-9277-92d84b971334	ACCEPTED	7	972	2026-06-19 05:16:41.887208+07	\N	\N	1000
7747	447	27	37e3f4ab-d088-4980-a549-bce01a444dc8	ACCEPTED	5	1084	2026-06-19 05:16:41.887201+07	\N	\N	1000
7743	447	23	2c32edd7-446f-4a00-94d3-156ecbf5e078	ACCEPTED	6	1120	2026-06-19 05:16:41.887197+07	\N	\N	0
7763	447	61	5ef242f2-1f48-4d0f-9698-350327c8615b	ACCEPTED	5	872	2026-06-19 05:16:41.887213+07	\N	\N	879721
7750	447	30	db2bade2-f36a-4b97-af13-99adee32ca02	ACCEPTED	5	884	2026-06-19 05:16:41.887203+07	\N	\N	0
7762	447	60	208de874-574e-4e45-a166-59e158f1bb2a	ACCEPTED	5	996	2026-06-19 05:16:41.887212+07	\N	\N	380371
7752	447	32	dc773e48-dade-48ba-a181-6aebe517b15c	ACCEPTED	5	1024	2026-06-19 05:16:41.887205+07	\N	\N	0
7754	447	34	ca59d4ce-3e97-4700-8c10-fa28fbf1d8a9	ACCEPTED	6	1012	2026-06-19 05:16:41.887206+07	\N	\N	15
7742	447	22	07e4ce24-8dd7-4456-8ca2-0fc03378f303	ACCEPTED	7	876	2026-06-19 05:16:41.887196+07	\N	\N	30
7759	447	57	cd09a8d4-d327-43b4-ac72-a4fe8eec0b63	ACCEPTED	9	1028	2026-06-19 05:16:41.88721+07	\N	\N	787228
7745	447	25	1960ca46-15b9-469b-b560-5e4636156a35	ACCEPTED	5	980	2026-06-19 05:16:41.887199+07	\N	\N	300
7744	447	24	b54d0063-171c-40cd-950a-b4d60176536d	ACCEPTED	9	1028	2026-06-19 05:16:41.887199+07	\N	\N	0
7756	447	36	89e26908-277b-403f-9532-7c739e8592e4	ACCEPTED	5	1016	2026-06-19 05:16:41.887207+07	\N	\N	801
7760	447	58	2fc68dd2-69d0-4a64-aa4e-5e0f2524587d	ACCEPTED	5	864	2026-06-19 05:16:41.887211+07	\N	\N	803799
7753	447	33	72e7714d-5869-480d-90ad-9e8e7034380e	ACCEPTED	5	1024	2026-06-19 05:16:41.887206+07	\N	\N	84
7755	447	35	0c0bcccf-6ef7-4b62-8d2a-730fdd033b28	ACCEPTED	6	868	2026-06-19 05:16:41.887207+07	\N	\N	-2
7764	447	62	e4f2bb39-8ae7-4db5-8a16-1b179dc8adeb	ACCEPTED	5	984	2026-06-19 05:16:41.887213+07	\N	\N	1486218
7758	447	38	a6191570-f903-4afc-bb3f-f020f35a5c09	ACCEPTED	6	1088	2026-06-19 05:16:41.887209+07	\N	\N	3000000
7748	447	28	b956e462-29bf-4c08-9d2e-156c14c76b5c	ACCEPTED	6	868	2026-06-19 05:16:41.887202+07	\N	\N	579
7751	447	31	746e1fe8-9de6-4f21-bad6-36218766c899	ACCEPTED	4	1080	2026-06-19 05:16:41.887204+07	\N	\N	30000
7761	447	59	d2b8e181-2bb2-4295-bc10-5665b1b16be6	ACCEPTED	5	1084	2026-06-19 05:16:41.887211+07	\N	\N	545178
7765	447	63	9a53884e-95d0-47ac-be20-15117a75b269	ACCEPTED	5	1096	2026-06-19 05:16:41.887214+07	\N	\N	1507378
7766	447	64	9b606934-4a32-45bd-aaac-44c895db307d	ACCEPTED	5	1024	2026-06-19 05:16:41.887215+07	\N	\N	710339
7770	447	68	772baeac-d6b2-4049-aa1f-60ddacd30d8f	ACCEPTED	7	1092	2026-06-19 05:16:41.887219+07	\N	\N	1161167
7767	447	65	58813dd8-7a31-43cf-b52e-2c64b61e545c	ACCEPTED	5	1016	2026-06-19 05:16:41.887217+07	\N	\N	475745
7768	447	66	dbc5b0ec-9ef6-4ac1-a67b-95b2c41927ae	ACCEPTED	5	1020	2026-06-19 05:16:41.887217+07	\N	\N	129492
7769	447	67	2d0cab07-e1b1-4f82-8d27-814c8d9cd516	ACCEPTED	10	920	2026-06-19 05:16:41.887218+07	\N	\N	473222
7788	447	86	6e44a82e-7adb-4f4e-8115-79bedee3e41d	ACCEPTED	5	1008	2026-06-19 05:16:41.887232+07	\N	\N	-876295
7816	447	114	0d568437-b620-4ec2-88e7-bf19ac6e58cd	ACCEPTED	11	1084	2026-06-19 05:16:41.887267+07	\N	\N	-234796
7827	447	125	c7e1735a-b06c-4c08-b57f-d64c55b3fc80	ACCEPTED	8	964	2026-06-19 05:16:41.887275+07	\N	\N	86961293
8951	460	29	be52fb34-9413-428a-916e-e70c86cd60d5	ACCEPTED	4	1096	2026-06-21 02:01:32.405716+07	\N	\N	99
7779	447	77	b2cbe04d-a550-4bd1-ba1e-b543682d3215	ACCEPTED	5	1080	2026-06-19 05:16:41.887225+07	\N	\N	-987624
7775	447	73	460bc8fb-219c-4d9f-b97a-0c542b049403	ACCEPTED	6	1016	2026-06-19 05:16:41.887222+07	\N	\N	702179
7771	447	69	d1f843a6-f5c5-4f3e-a0ba-6b6f13d2f3a5	ACCEPTED	7	868	2026-06-19 05:16:41.887219+07	\N	\N	616334
7780	447	78	7913903c-2313-4f17-95f1-f25c0ae9f7e2	ACCEPTED	5	876	2026-06-19 05:16:41.887226+07	\N	\N	-824805
7781	447	79	8e4a70c3-d74a-4d85-bb9e-8831d483bb9b	ACCEPTED	5	872	2026-06-19 05:16:41.887227+07	\N	\N	-1351853
7774	447	72	0fefcfb3-06da-402c-97f9-adc4e06ed6f5	ACCEPTED	5	820	2026-06-19 05:16:41.887222+07	\N	\N	1011312
7783	447	81	0f8a119d-6b6f-4d56-a670-3026e9562e8b	ACCEPTED	14	1028	2026-06-19 05:16:41.887228+07	\N	\N	-846475
7776	447	74	d821a7a3-977e-4892-86f5-35352bd7261d	ACCEPTED	7	872	2026-06-19 05:16:41.887223+07	\N	\N	909595
7786	447	84	735b5cad-8ac9-4c8e-8117-cd87e6abbc5f	ACCEPTED	8	1064	2026-06-19 05:16:41.88723+07	\N	\N	-734921
7784	447	82	6b53381d-99b4-45a4-9c5a-1f3be8da3ff2	ACCEPTED	6	872	2026-06-19 05:16:41.887229+07	\N	\N	-1795574
7777	447	75	357d7b88-b4ec-48a7-8451-8a9fd70b4f8f	ACCEPTED	29	1080	2026-06-19 05:16:41.887224+07	\N	\N	1760278
7778	447	76	b6d61894-2aeb-4021-9a46-740f524c08f4	ACCEPTED	9	864	2026-06-19 05:16:41.887225+07	\N	\N	802483
7789	447	87	f5ac4012-1415-407a-8a4e-d4e2144c8736	ACCEPTED	5	1024	2026-06-19 05:16:41.887233+07	\N	\N	-1189260
7794	447	92	c361ba0d-be8d-423d-9381-a1610adad7eb	ACCEPTED	5	1096	2026-06-19 05:16:41.887252+07	\N	\N	-471131
7782	447	80	dbda0588-e053-4855-863c-6060b731ae48	ACCEPTED	6	884	2026-06-19 05:16:41.887228+07	\N	\N	-1611196
7790	447	88	36a010b8-4daf-4940-97b9-715257937f96	ACCEPTED	6	1040	2026-06-19 05:16:41.887234+07	\N	\N	-955984
7791	447	89	f8d8c263-f6c1-4e88-8f20-1931d7b32121	ACCEPTED	7	876	2026-06-19 05:16:41.887235+07	\N	\N	-902015
7793	447	91	2bceb850-350a-42dc-8775-2bb58c933d9d	ACCEPTED	7	884	2026-06-19 05:16:41.887237+07	\N	\N	-1113725
7796	447	94	5362d0de-ab81-475d-a395-84f5e19623a9	ACCEPTED	12	872	2026-06-19 05:16:41.887254+07	\N	\N	-717234
7792	447	90	73e29390-f28b-471a-9c9a-b0931ce71dad	ACCEPTED	6	876	2026-06-19 05:16:41.887236+07	\N	\N	-1520451
7799	447	97	9a027050-36d7-462c-b973-cb2afb662b06	ACCEPTED	5	1004	2026-06-19 05:16:41.887256+07	\N	\N	-517131
7803	447	101	715edd1d-417d-4536-b781-f6ba2d16c45c	ACCEPTED	5	1084	2026-06-19 05:16:41.887259+07	\N	\N	28962
7804	447	102	b4e9e131-0184-450c-a49f-0a92dc7c9705	ACCEPTED	6	1024	2026-06-19 05:16:41.887259+07	\N	\N	-619866
7805	447	103	f6b3abed-ecc2-4861-9ea0-4b4a0d7db2c7	ACCEPTED	5	876	2026-06-19 05:16:41.88726+07	\N	\N	283996
7797	447	95	82ec8913-2bbd-4fa0-a106-8d238de80daf	ACCEPTED	6	884	2026-06-19 05:16:41.887255+07	\N	\N	-1192974
7802	447	100	08b1b831-bd69-4670-993b-a8644e20702a	ACCEPTED	8	860	2026-06-19 05:16:41.887258+07	\N	\N	281928
7795	447	93	30eaf0a4-328d-43d7-b3e6-ac8dadff3742	ACCEPTED	5	868	2026-06-19 05:16:41.887253+07	\N	\N	-422973
7800	447	98	a6a08687-9c21-40c3-a631-0e00c3871f77	ACCEPTED	6	1032	2026-06-19 05:16:41.887257+07	\N	\N	99178
7806	447	104	4ddd229c-775b-48a6-86f7-b69ad56615d3	ACCEPTED	5	864	2026-06-19 05:16:41.88726+07	\N	\N	514364
7807	447	105	82e410f3-12e3-4c70-97e9-c37a52498e54	ACCEPTED	19	1080	2026-06-19 05:16:41.887261+07	\N	\N	-882565
7808	447	106	aa281be4-57a8-4f90-bba4-7b810f5cda50	ACCEPTED	8	1024	2026-06-19 05:16:41.887262+07	\N	\N	-815576
7809	447	107	74c52462-79da-4e2e-92f8-b40d64f33cb8	ACCEPTED	8	1076	2026-06-19 05:16:41.887262+07	\N	\N	-34648
7811	447	109	de4a8adc-f92d-4c02-8495-827be8996570	ACCEPTED	7	848	2026-06-19 05:16:41.887264+07	\N	\N	792531
7812	447	110	0d892061-0c76-4404-bf1b-1415386b9719	ACCEPTED	8	1020	2026-06-19 05:16:41.887264+07	\N	\N	-572819
7817	447	115	5b24cfac-b563-4ef4-9c81-cf5d3f24249f	ACCEPTED	5	1036	2026-06-19 05:16:41.887268+07	\N	\N	506806
7818	447	116	df7b40ef-b508-48e9-b3fa-94e4d8a5ee17	ACCEPTED	5	1020	2026-06-19 05:16:41.887269+07	\N	\N	785356
7826	447	124	46193d38-397d-4428-b742-675d3c3609a7	ACCEPTED	6	1032	2026-06-19 05:16:41.887274+07	\N	\N	1610593689
7819	447	117	640f5c37-8c03-4a9b-8afc-5b55026402b0	ACCEPTED	5	804	2026-06-19 05:16:41.88727+07	\N	\N	362210245
7820	447	118	4d6b013a-7546-497e-99b7-ff492ad1889a	ACCEPTED	5	1012	2026-06-19 05:16:41.88727+07	\N	\N	636465324
7814	447	112	d951f82a-6713-4c8d-b76a-2831f793aa1d	ACCEPTED	5	1084	2026-06-19 05:16:41.887266+07	\N	\N	649261
7822	447	120	25514333-c38f-47f2-9c5e-c7187acf3af5	ACCEPTED	8	872	2026-06-19 05:16:41.887272+07	\N	\N	371467497
7821	447	119	27de4dd8-ee8c-40fe-82bf-76799f1c810e	ACCEPTED	6	1020	2026-06-19 05:16:41.887271+07	\N	\N	-738231997
7810	447	108	dda10833-4f9c-44e2-ad1b-9ef9da4363a8	ACCEPTED	7	1020	2026-06-19 05:16:41.887263+07	\N	\N	1436130
7815	447	113	2799ef73-7a45-4012-980e-761ef88646bb	ACCEPTED	5	1032	2026-06-19 05:16:41.887267+07	\N	\N	-1143916
7823	447	121	20ed9f4d-2324-424e-97a7-305b940c6559	ACCEPTED	7	1040	2026-06-19 05:16:41.887272+07	\N	\N	1259817393
7829	447	127	143873cf-7271-4fba-8843-04b5c293a440	ACCEPTED	6	1028	2026-06-19 05:16:41.887276+07	\N	\N	0
7830	447	128	287f6436-2d22-45cc-a76d-dc666a730d83	ACCEPTED	6	888	2026-06-19 05:16:41.887277+07	\N	\N	82
7824	447	122	8c172682-f821-4e56-b5a1-9bfab50cacf0	ACCEPTED	7	988	2026-06-19 05:16:41.887273+07	\N	\N	-457820119
7828	447	126	1d40e97a-cf3e-4d82-a3bd-a49cff43e8f9	ACCEPTED	5	860	2026-06-19 05:16:41.887276+07	\N	\N	-882105735
7831	447	129	293bcfa4-4255-4e10-85d9-0d7280a210c0	ACCEPTED	17	988	2026-06-19 05:16:41.887277+07	\N	\N	-32
7834	447	132	cee76797-6994-44b4-acba-77187365dc2f	ACCEPTED	7	1032	2026-06-19 05:16:41.88728+07	\N	\N	-1
7833	447	131	be4dd357-4ffa-46bd-a1d0-36bb8d8d77aa	ACCEPTED	5	1012	2026-06-19 05:16:41.887279+07	\N	\N	71
7835	447	133	3c491ac3-7802-41fb-b9aa-e570301a52dc	ACCEPTED	5	1032	2026-06-19 05:16:41.88728+07	\N	\N	-57
7836	447	134	239509f9-9ab3-44d2-a6fd-0bad0863c14b	ACCEPTED	5	1032	2026-06-19 05:16:41.887281+07	\N	\N	158
7837	447	135	fbc7d7a5-10e1-43fc-834d-9230b0b277ac	ACCEPTED	5	1036	2026-06-19 05:16:41.887281+07	\N	\N	3
7839	447	137	0bc14b3f-9b46-4ad7-88f6-83698975e7ff	ACCEPTED	3	1328	2026-06-19 05:16:41.887283+07	\N	\N	64
7840	447	138	afd0d0c3-1704-4847-9632-705cad56eb6a	ACCEPTED	3	1192	2026-06-19 05:16:41.887283+07	\N	\N	51
7772	447	70	05a44920-29c6-47e9-b61c-1aa40059c138	ACCEPTED	7	880	2026-06-19 05:16:41.88722+07	\N	\N	959298
7773	447	71	df6a61bc-98e8-4327-b5da-fe9cc49a8daf	ACCEPTED	5	876	2026-06-19 05:16:41.887221+07	\N	\N	1416847
7785	447	83	e5abeef6-a876-4758-b7a5-596b0addd21d	ACCEPTED	8	1080	2026-06-19 05:16:41.88723+07	\N	\N	-1500204
7787	447	85	ca89ba75-2a1a-4ad2-ac8c-c03a7766ac50	ACCEPTED	10	988	2026-06-19 05:16:41.887232+07	\N	\N	-1006285
7798	447	96	15f4530c-3a10-4249-802c-8252c443d02d	ACCEPTED	6	1016	2026-06-19 05:16:41.887255+07	\N	\N	-1188270
7801	447	99	a17029e5-103a-4213-bbf0-ae4a652be451	ACCEPTED	5	884	2026-06-19 05:16:41.887257+07	\N	\N	-1225775
7813	447	111	569a74d6-c7f4-41b7-8c17-85326e39151f	ACCEPTED	5	1016	2026-06-19 05:16:41.887265+07	\N	\N	-309452
7825	447	123	0119eaa8-b317-4999-aee2-c3bf756894aa	ACCEPTED	6	836	2026-06-19 05:16:41.887274+07	\N	\N	1422690276
7832	447	130	43f68d01-6e9f-47a5-b99e-406cb9ea32d6	ACCEPTED	6	1016	2026-06-19 05:16:41.887278+07	\N	\N	-5
7838	447	136	57f3c4f4-647b-465c-b1fa-95419d8e68c2	ACCEPTED	3	1040	2026-06-19 05:16:41.887282+07	\N	\N	129
8964	460	60	834cd326-a937-4b6e-93bd-f0b6e083ab15	ACCEPTED	5	856	2026-06-21 02:01:32.405737+07	\N	\N	380371
7851	448	31	b3588da7-3941-4fed-b565-6e56d035d31e	ACCEPTED	5	1024	2026-06-19 05:18:26.94948+07	\N	\N	30000
7859	448	57	cef4a9b1-8a97-4820-ae0b-07cb22f74334	ACCEPTED	5	832	2026-06-19 05:18:26.949492+07	\N	\N	787228
7858	448	38	e698d877-a4e5-4ac9-8cff-b3a525027f3f	ACCEPTED	7	1024	2026-06-19 05:18:26.94949+07	\N	\N	3000000
7843	448	23	6cb0975f-b72e-4aa2-b18b-db9f58aa80be	ACCEPTED	16	980	2026-06-19 05:18:26.949463+07	\N	\N	0
7846	448	26	52c34325-7982-4d21-a476-c117843c7cde	ACCEPTED	4	1020	2026-06-19 05:18:26.94947+07	\N	\N	-30
7848	448	28	4d36ccdf-81d9-40fb-9d3b-66392f5732b1	ACCEPTED	5	864	2026-06-19 05:18:26.949476+07	\N	\N	579
7844	448	24	d1d1686d-f20c-4fd6-8abd-00dd24b2e1c3	ACCEPTED	12	1028	2026-06-19 05:18:26.949464+07	\N	\N	0
7856	448	36	37c541d0-4e17-4009-aa1f-27a1dc3c13a6	ACCEPTED	5	1024	2026-06-19 05:18:26.949488+07	\N	\N	801
7855	448	35	82310f5d-eac1-48db-89c2-f6f564526833	ACCEPTED	5	856	2026-06-19 05:18:26.949487+07	\N	\N	-2
7841	448	21	9dadf126-bf89-46f1-a030-5c9d1c43c9b4	ACCEPTED	4	1084	2026-06-19 05:18:26.949456+07	\N	\N	3
7862	448	60	4315c569-2098-49bb-9e8a-a519def26fc5	ACCEPTED	5	1016	2026-06-19 05:18:26.949496+07	\N	\N	380371
7847	448	27	82b8eaa7-12dd-4b3b-aaa3-099b975b4c91	ACCEPTED	5	876	2026-06-19 05:18:26.949475+07	\N	\N	1000
7854	448	34	081c2dc8-75d1-4670-843b-849d8fe8fb59	ACCEPTED	6	864	2026-06-19 05:18:26.949486+07	\N	\N	15
7863	448	61	58c19f18-5ef1-4eb5-8204-495936b9acb7	ACCEPTED	5	1024	2026-06-19 05:18:26.949497+07	\N	\N	879721
7860	448	58	5f065861-ec26-4d22-becf-548b1f84a609	ACCEPTED	6	1024	2026-06-19 05:18:26.949493+07	\N	\N	803799
7853	448	33	f33ac0a8-583d-4b78-97b4-48bf8ba626bf	ACCEPTED	5	932	2026-06-19 05:18:26.949484+07	\N	\N	84
7857	448	37	b27e7d50-1e6c-416a-aa9a-4c31edacb082	ACCEPTED	5	1024	2026-06-19 05:18:26.949489+07	\N	\N	1000
7852	448	32	0f7f55c5-22a1-4e4a-9e11-d9c9f7bb014e	ACCEPTED	5	1096	2026-06-19 05:18:26.949481+07	\N	\N	0
7864	448	62	698eb73d-27e6-419e-82c0-f811f43f9532	ACCEPTED	6	1032	2026-06-19 05:18:26.949498+07	\N	\N	1486218
7849	448	29	0aef96df-2ae5-4cee-a47f-e489e445754f	ACCEPTED	8	1020	2026-06-19 05:18:26.949478+07	\N	\N	99
7865	448	63	f3e0fee2-3597-4de2-99c5-dc796f534f3c	ACCEPTED	23	1064	2026-06-19 05:18:26.949499+07	\N	\N	1507378
7867	448	65	3ecf9fdf-63e3-45db-91cd-32684d5ca1ed	ACCEPTED	5	876	2026-06-19 05:18:26.949502+07	\N	\N	475745
7866	448	64	4736918b-8f18-4d56-ba77-03a0f53bb11c	ACCEPTED	7	984	2026-06-19 05:18:26.9495+07	\N	\N	710339
7872	448	70	f9c445c5-0770-42c9-9462-cb04e797cf8c	ACCEPTED	5	1028	2026-06-19 05:18:26.949508+07	\N	\N	959298
7875	448	73	0ddbec27-24c3-4bdb-be18-cf80ab6445d6	ACCEPTED	11	872	2026-06-19 05:18:26.949512+07	\N	\N	702179
7870	448	68	fe15aaf0-2bec-41f4-a9c6-6a6b8be38817	ACCEPTED	7	980	2026-06-19 05:18:26.949505+07	\N	\N	1161167
7874	448	72	a41f6f2f-bea0-4242-a199-9b5adadec2d2	ACCEPTED	5	1024	2026-06-19 05:18:26.94951+07	\N	\N	1011312
7882	448	80	7ff10560-d520-4458-accb-eec376362326	ACCEPTED	7	1040	2026-06-19 05:18:26.949521+07	\N	\N	-1611196
7881	448	79	9a6fb853-efeb-43c1-bc86-7d11ea12154d	ACCEPTED	5	1024	2026-06-19 05:18:26.949519+07	\N	\N	-1351853
7873	448	71	f7722453-545d-48a6-8c6b-845678edad5e	ACCEPTED	5	1084	2026-06-19 05:18:26.949509+07	\N	\N	1416847
7878	448	76	76bf0797-089b-4d59-b748-cbc0cb9a3853	ACCEPTED	5	868	2026-06-19 05:18:26.949516+07	\N	\N	802483
7879	448	77	21c13bfc-dc48-4e65-970b-97c3e335ee05	ACCEPTED	5	1028	2026-06-19 05:18:26.949517+07	\N	\N	-987624
7871	448	69	a81975c7-0f88-49e4-a962-d245449c9008	ACCEPTED	5	1024	2026-06-19 05:18:26.949507+07	\N	\N	616334
7884	448	82	b97ab03c-7ba7-401a-a51c-55044927c9b3	ACCEPTED	5	876	2026-06-19 05:18:26.949523+07	\N	\N	-1795574
7880	448	78	04c1c95f-954b-406d-a15e-d728ace203fd	ACCEPTED	5	880	2026-06-19 05:18:26.949518+07	\N	\N	-824805
7887	448	85	75b889f0-c152-4c18-82bf-dd94852ba217	ACCEPTED	5	1024	2026-06-19 05:18:26.949527+07	\N	\N	-1006285
7885	448	83	595a058e-0ef3-4c83-8065-552bcd2926b7	ACCEPTED	9	1016	2026-06-19 05:18:26.949524+07	\N	\N	-1500204
7886	448	84	90a83b58-69a2-4b58-9974-c0591a01fd66	ACCEPTED	5	1084	2026-06-19 05:18:26.949526+07	\N	\N	-734921
7876	448	74	23740850-4bd6-461c-9312-4a913d9c2eb4	ACCEPTED	5	1028	2026-06-19 05:18:26.949513+07	\N	\N	909595
7888	448	86	348979f9-18ec-47fd-ac2f-476dc6e99fb1	ACCEPTED	5	1016	2026-06-19 05:18:26.949528+07	\N	\N	-876295
7892	448	90	1facdd69-a40b-4715-925f-0d4f0f0b4fb2	ACCEPTED	5	1096	2026-06-19 05:18:26.949534+07	\N	\N	-1520451
7897	448	95	4873c8a2-5980-4af2-a494-6e60983ccf7d	ACCEPTED	5	860	2026-06-19 05:18:26.94954+07	\N	\N	-1192974
7891	448	89	80020e4f-8829-4330-ba54-5b22b262397d	ACCEPTED	6	1012	2026-06-19 05:18:26.949532+07	\N	\N	-902015
7898	448	96	dfae7c2d-493c-4147-875a-6c2777d993a0	ACCEPTED	5	1024	2026-06-19 05:18:26.949541+07	\N	\N	-1188270
7895	448	93	efd20626-0fe0-4f02-8e44-cd1aeb10afab	ACCEPTED	8	824	2026-06-19 05:18:26.949537+07	\N	\N	-422973
7893	448	91	aec6dd7a-4929-4a49-b1d2-6a6cf57b6f39	ACCEPTED	7	1024	2026-06-19 05:18:26.949535+07	\N	\N	-1113725
7896	448	94	1cb9e1f7-b09d-4016-9c3d-58ce79ed54ad	ACCEPTED	5	864	2026-06-19 05:18:26.949538+07	\N	\N	-717234
7894	448	92	99ee7220-b3ac-4bc7-8797-6295e6031bb4	ACCEPTED	8	1020	2026-06-19 05:18:26.949536+07	\N	\N	-471131
7845	448	25	7a9286ee-cc22-4c3e-b236-e56ff5b82012	ACCEPTED	6	868	2026-06-19 05:18:26.949465+07	\N	\N	300
7842	448	22	c0812e9d-ab0c-4316-8f52-b2bb535a79bb	ACCEPTED	5	1052	2026-06-19 05:18:26.949461+07	\N	\N	30
7850	448	30	ec729a2e-fa59-451c-8627-59c06c3afd78	ACCEPTED	5	1092	2026-06-19 05:18:26.949479+07	\N	\N	0
7861	448	59	9a6a9a95-21e6-453e-8e45-860f9a3e7b8b	ACCEPTED	6	1088	2026-06-19 05:18:26.949494+07	\N	\N	545178
7868	448	66	04c9047c-171b-424b-9c90-defd0f5ab15c	ACCEPTED	18	860	2026-06-19 05:18:26.949503+07	\N	\N	129492
7869	448	67	762ec70f-f0ce-4011-a52f-67bc9b28eba9	ACCEPTED	5	1028	2026-06-19 05:18:26.949504+07	\N	\N	473222
7877	448	75	b4091216-b8f9-4047-aa8e-97204f964ea7	ACCEPTED	7	924	2026-06-19 05:18:26.949514+07	\N	\N	1760278
7883	448	81	70df8325-a8ff-4cc5-b26c-1fa758300c33	ACCEPTED	6	972	2026-06-19 05:18:26.949522+07	\N	\N	-846475
7890	448	88	96aefcd6-c609-4d9a-bf1b-46c671e323f1	ACCEPTED	4	880	2026-06-19 05:18:26.949531+07	\N	\N	-955984
7889	448	87	a262fdc8-45a5-47a1-9c0d-bcb358e6025d	ACCEPTED	5	1016	2026-06-19 05:18:26.949529+07	\N	\N	-1189260
7901	448	99	d3e531b1-11a9-4335-90bf-ec9c74334848	ACCEPTED	5	1012	2026-06-19 05:18:26.949544+07	\N	\N	-1225775
7902	448	100	225bd79d-2e61-4137-bbb8-47ad9fc50068	ACCEPTED	8	1012	2026-06-19 05:18:26.949545+07	\N	\N	281928
7899	448	97	3d9748c2-7967-4cb4-b12c-4d4c705b1844	ACCEPTED	18	1028	2026-06-19 05:18:26.949542+07	\N	\N	-517131
7903	448	101	34594f1f-9b83-46b2-9821-3b4b3ba6b11d	ACCEPTED	7	1084	2026-06-19 05:18:26.949547+07	\N	\N	28962
7907	448	105	a990075e-4918-48be-8d17-5acb458a2c94	ACCEPTED	4	1016	2026-06-19 05:18:26.949552+07	\N	\N	-882565
7900	448	98	5893f55a-5032-4699-808a-c702d33f1bc0	ACCEPTED	5	1020	2026-06-19 05:18:26.949543+07	\N	\N	99178
7905	448	103	3b17e466-f8ac-4377-828e-dcf37b3077b6	ACCEPTED	19	1016	2026-06-19 05:18:26.949549+07	\N	\N	283996
7904	448	102	4941a111-d4eb-4d9e-8ad6-163e16f7d63b	ACCEPTED	5	876	2026-06-19 05:18:26.949548+07	\N	\N	-619866
7910	448	108	627b4e81-57fa-4a0f-bc47-54d7d3751104	ACCEPTED	10	872	2026-06-19 05:18:26.949555+07	\N	\N	1436130
7908	448	106	3b6f4d2f-4571-4b7d-b0d6-499780d8e878	ACCEPTED	7	1084	2026-06-19 05:18:26.949553+07	\N	\N	-815576
7911	448	109	af5efa89-e16c-4fd0-8f4d-c5575725d59c	ACCEPTED	7	1044	2026-06-19 05:18:26.949556+07	\N	\N	792531
7914	448	112	ab5ebeda-c7c6-4a10-9faf-f1805150ffaf	ACCEPTED	7	912	2026-06-19 05:18:26.949561+07	\N	\N	649261
7909	448	107	e3585f2e-ef34-4342-955e-e001e7e584c8	ACCEPTED	6	1084	2026-06-19 05:18:26.949554+07	\N	\N	-34648
7917	448	115	be2f26f5-5395-4dff-be2d-1600e64da282	ACCEPTED	11	1068	2026-06-19 05:18:26.949564+07	\N	\N	506806
7906	448	104	fa449e88-4972-4c9d-a08b-03203f0d2b48	ACCEPTED	6	900	2026-06-19 05:18:26.94955+07	\N	\N	514364
7912	448	110	32a812e6-c784-4b28-88cf-9e402850babb	ACCEPTED	5	1016	2026-06-19 05:18:26.949558+07	\N	\N	-572819
7913	448	111	32e9ec41-f51f-4fb8-9409-8692217bd678	ACCEPTED	5	1028	2026-06-19 05:18:26.949559+07	\N	\N	-309452
7918	448	116	0fea4664-a13a-4a76-8c03-a7829a9bacf1	ACCEPTED	5	1028	2026-06-19 05:18:26.949566+07	\N	\N	785356
7916	448	114	ffa5ac5b-1656-4439-a621-a9556710f5c9	ACCEPTED	6	860	2026-06-19 05:18:26.949563+07	\N	\N	-234796
7922	448	120	728ee8e7-8644-4d6d-a679-237aaf81ac93	ACCEPTED	7	944	2026-06-19 05:18:26.949586+07	\N	\N	371467497
7919	448	117	cd28ccaf-ed84-41f4-9120-5ae9a66502dd	ACCEPTED	5	864	2026-06-19 05:18:26.949567+07	\N	\N	362210245
7924	448	122	14322743-7ec6-47c7-8019-7b287c447819	ACCEPTED	5	872	2026-06-19 05:18:26.94959+07	\N	\N	-457820119
7915	448	113	c1bd58a0-3225-46a6-9dc3-b7f0bafc39a8	ACCEPTED	6	876	2026-06-19 05:18:26.949562+07	\N	\N	-1143916
7925	448	123	c177f203-aa2b-4b9f-85fc-985c3b16c772	ACCEPTED	5	864	2026-06-19 05:18:26.949591+07	\N	\N	1422690276
7920	448	118	2c631036-43e3-4785-8e6e-36a130d038ed	ACCEPTED	5	860	2026-06-19 05:18:26.949568+07	\N	\N	636465324
7921	448	119	c93147ef-a55e-42d1-9892-5a65200da73e	ACCEPTED	5	800	2026-06-19 05:18:26.949569+07	\N	\N	-738231997
7923	448	121	aafb840a-599e-4707-a7f3-1b6bcfcb9870	ACCEPTED	5	920	2026-06-19 05:18:26.949588+07	\N	\N	1259817393
7926	448	124	735844ef-61c5-48c2-88be-996fc016ec95	ACCEPTED	5	1028	2026-06-19 05:18:26.949592+07	\N	\N	1610593689
7927	448	125	198a54d4-66fc-4d16-ad53-27324d3124e0	ACCEPTED	7	1036	2026-06-19 05:18:26.949593+07	\N	\N	86961293
7928	448	126	d7eb1185-ad09-4101-b408-5f19254a3f13	ACCEPTED	7	1024	2026-06-19 05:18:26.949595+07	\N	\N	-882105735
7929	448	127	f7635450-efb0-4c61-b956-62a09c0606cf	ACCEPTED	10	1016	2026-06-19 05:18:26.949596+07	\N	\N	0
7932	448	130	18b66eeb-2e91-411a-8195-7a8700486a0b	ACCEPTED	5	1020	2026-06-19 05:18:26.9496+07	\N	\N	-5
7930	448	128	f7e101f0-be0a-4a39-88a6-12ac472b3701	ACCEPTED	8	864	2026-06-19 05:18:26.949597+07	\N	\N	82
7935	448	133	5a954e73-9632-45d2-957c-1df32defb2e6	ACCEPTED	6	880	2026-06-19 05:18:26.949603+07	\N	\N	-57
7931	448	129	d6e40840-de77-4515-b7a9-5d0986bf1c1e	ACCEPTED	8	1024	2026-06-19 05:18:26.949598+07	\N	\N	-32
7934	448	132	05fcdbe0-fce9-4148-aa30-97c9d3604e5a	ACCEPTED	14	1012	2026-06-19 05:18:26.949602+07	\N	\N	-1
7933	448	131	c1018a5f-708a-4d30-8096-60fd2802cc6c	ACCEPTED	5	1016	2026-06-19 05:18:26.949601+07	\N	\N	71
7937	448	135	c91593ef-82aa-4518-9efc-7d12a926ca8b	ACCEPTED	5	1256	2026-06-19 05:18:26.949606+07	\N	\N	3
7936	448	134	e40ccf4b-f3a7-40c7-a8f5-d6278fa70cec	ACCEPTED	4	1052	2026-06-19 05:18:26.949605+07	\N	\N	158
7939	448	137	4b11d808-ead5-44f5-bd0f-bcf51ce16864	ACCEPTED	3	1056	2026-06-19 05:18:26.949608+07	\N	\N	64
7940	448	138	30687b50-b4f9-445c-928e-3c1bc52f7b2b	ACCEPTED	3	1128	2026-06-19 05:18:26.949609+07	\N	\N	51
7938	448	136	2293d6b0-3a94-41fa-ac6b-5f7dd610beb1	ACCEPTED	2	1056	2026-06-19 05:18:26.949607+07	\N	\N	129
8955	460	33	ecdbc378-73d3-4b3b-9ad6-25d8b341f31e	ACCEPTED	5	1016	2026-06-21 02:01:32.405722+07	\N	\N	84
7944	449	24	ea6508c7-8aff-466d-b407-4605b1fc14ab	WRONG_ANSWER	5	1080	2026-06-19 05:18:46.551414+07	\N	\N	-10
7946	449	26	d228dc8b-a9b6-42c5-9ee7-849424fd2e5f	WRONG_ANSWER	5	1028	2026-06-19 05:18:46.551415+07	\N	\N	10
7948	449	28	a4533e85-a927-4d60-864e-544401c85fa4	WRONG_ANSWER	5	864	2026-06-19 05:18:46.551416+07	\N	\N	-333
7945	449	25	40cea7c4-ecbf-4e30-9e1b-df2063844f45	WRONG_ANSWER	6	1016	2026-06-19 05:18:46.551414+07	\N	\N	-100
7942	449	22	5684a09e-d81c-4b74-93df-e70f42aa4a69	WRONG_ANSWER	7	1040	2026-06-19 05:18:46.551412+07	\N	\N	-10
7941	449	21	92365370-e2f0-4341-be9f-0c3e116bab30	WRONG_ANSWER	12	1016	2026-06-19 05:18:46.551381+07	\N	\N	-1
8952	460	30	3ba85c8f-89dc-40ad-b9f9-bba7cdaff37f	ACCEPTED	4	1088	2026-06-21 02:01:32.405717+07	\N	\N	0
7954	449	34	79112477-0e96-4513-8a76-6fc4ae95f138	WRONG_ANSWER	5	832	2026-06-19 05:18:46.55142+07	\N	\N	-1
7950	449	30	0ef6240b-f3d7-4e29-9459-14654b469663	WRONG_ANSWER	5	1016	2026-06-19 05:18:46.551417+07	\N	\N	100
7956	449	36	ed96e50c-d864-4025-8f30-92390ecc4fab	WRONG_ANSWER	6	1088	2026-06-19 05:18:46.551421+07	\N	\N	-333
7955	449	35	c2f345a1-e5f1-43a1-b1a6-b707aec466fd	WRONG_ANSWER	7	1080	2026-06-19 05:18:46.55142+07	\N	\N	0
7961	449	59	fd0bb771-4684-46bb-ae0f-5b09316c2970	WRONG_ANSWER	7	884	2026-06-19 05:18:46.551449+07	\N	\N	31602
7963	449	61	f46159a1-1baa-4328-88af-59139b1aab51	WRONG_ANSWER	8	1028	2026-06-19 05:18:46.551454+07	\N	\N	664773
7949	449	29	320b1b7c-b486-42d7-9a92-b56640c7255b	WRONG_ANSWER	5	1028	2026-06-19 05:18:46.551417+07	\N	\N	-99
7960	449	58	62ac77fa-0849-4881-b746-38bb4dead1a0	WRONG_ANSWER	7	872	2026-06-19 05:18:46.551424+07	\N	\N	-751347
7959	449	57	4665a32d-6a14-46d7-8088-fe9aaa20c86b	WRONG_ANSWER	5	1096	2026-06-19 05:18:46.551423+07	\N	\N	553748
7951	449	31	6dac3b62-f577-48c3-9296-ce6d83ff21bd	WRONG_ANSWER	5	1076	2026-06-19 05:18:46.551418+07	\N	\N	-10000
7962	449	60	4e766083-6524-477f-9ea6-f7ab3694aad7	WRONG_ANSWER	5	1020	2026-06-19 05:18:46.551453+07	\N	\N	87737
7958	449	38	4b285afa-37a1-45da-8e95-52852ada6a75	WRONG_ANSWER	7	992	2026-06-19 05:18:46.551422+07	\N	\N	-1000000
7952	449	32	5773915f-d4f5-4b29-8160-282a19d9ff8f	WRONG_ANSWER	5	1084	2026-06-19 05:18:46.551419+07	\N	\N	-1998
7970	449	68	3eb90472-ac61-41d7-9433-09b49c3d1fb6	WRONG_ANSWER	7	1036	2026-06-19 05:18:46.551459+07	\N	\N	-101359
7979	449	77	9d424825-4490-4071-8e90-bf07613eb6b0	WRONG_ANSWER	6	884	2026-06-19 05:18:46.551466+07	\N	\N	677548
7967	449	65	215c07a8-ea6d-4de5-a0da-725d2f13c978	WRONG_ANSWER	5	1024	2026-06-19 05:18:46.551457+07	\N	\N	409091
7966	449	64	7caa3b05-1500-4c7f-b278-b7c4ec0d6a27	WRONG_ANSWER	5	1012	2026-06-19 05:18:46.551456+07	\N	\N	-528015
7971	449	69	00b51a1a-f938-45b4-8ffc-351cca5f9814	WRONG_ANSWER	5	1024	2026-06-19 05:18:46.55146+07	\N	\N	-560684
7974	449	72	de68cefd-ec88-4753-a9a9-4658e424f75f	WRONG_ANSWER	5	1024	2026-06-19 05:18:46.551462+07	\N	\N	131514
7968	449	66	336baff4-acfc-42ca-9d23-361d0185f451	WRONG_ANSWER	5	888	2026-06-19 05:18:46.551458+07	\N	\N	-67002
7978	449	76	d32704bc-a8b6-4cf5-b8b9-31e2952860eb	WRONG_ANSWER	11	996	2026-06-19 05:18:46.551465+07	\N	\N	-788853
7977	449	75	2653ba6b-72e3-4aed-a3e2-dfb25055a23c	WRONG_ANSWER	5	1016	2026-06-19 05:18:46.551464+07	\N	\N	-62778
7982	449	80	c674e9b7-6445-4713-9c1c-9510f566dbfe	WRONG_ANSWER	6	840	2026-06-19 05:18:46.551468+07	\N	\N	-62740
7986	449	84	0d0da976-04ff-4865-89e1-410549918119	WRONG_ANSWER	7	1076	2026-06-19 05:18:46.55147+07	\N	\N	-512245
7969	449	67	1c7352dd-69cd-4843-bf06-b03c6de32aae	WRONG_ANSWER	5	1008	2026-06-19 05:18:46.551458+07	\N	\N	-14704
7972	449	70	2a3848f7-85a3-41e9-a848-5489b6d25554	WRONG_ANSWER	8	912	2026-06-19 05:18:46.55146+07	\N	\N	-542304
7975	449	73	b9e22fd7-992a-4eb3-9f43-71bfcdffd29d	WRONG_ANSWER	6	864	2026-06-19 05:18:46.551463+07	\N	\N	-239881
7980	449	78	fa632929-d268-44d4-83b8-d84ab1641dc3	WRONG_ANSWER	8	1032	2026-06-19 05:18:46.551466+07	\N	\N	288909
7987	449	85	0397be74-9aac-4816-aeaf-e02522f55e21	WRONG_ANSWER	5	1124	2026-06-19 05:18:46.551471+07	\N	\N	-272389
7985	449	83	95f319bc-4faf-4348-8697-4973268a2034	WRONG_ANSWER	5	1088	2026-06-19 05:18:46.55147+07	\N	\N	296968
7973	449	71	f7852387-9398-4ab0-930e-1eedd7d0b12b	WRONG_ANSWER	6	1092	2026-06-19 05:18:46.551461+07	\N	\N	-53939
7984	449	82	c9864f6b-f3ba-4b4c-91ed-8336901321fa	WRONG_ANSWER	5	1032	2026-06-19 05:18:46.551469+07	\N	\N	9924
7988	449	86	dd7b4d6a-a045-49cb-9f1c-43c70134802d	WRONG_ANSWER	5	1032	2026-06-19 05:18:46.551472+07	\N	\N	-568965
7993	449	91	8120b29d-fec2-40c9-aa7a-315b32e79a14	WRONG_ANSWER	6	1016	2026-06-19 05:18:46.551476+07	\N	\N	271437
7994	449	92	7a305976-5ecc-4346-9c12-7d1c19f6cf08	WRONG_ANSWER	5	1028	2026-06-19 05:18:46.551477+07	\N	\N	210517
7996	449	94	6ccfb163-7d20-4b1f-b7b3-e8d04c26c6d3	WRONG_ANSWER	6	1024	2026-06-19 05:18:46.551478+07	\N	\N	524364
7997	449	95	b1373091-1790-4ea6-b6c4-3082f7a6376a	WRONG_ANSWER	6	1092	2026-06-19 05:18:46.551479+07	\N	\N	403768
8003	449	101	18d6b59b-3459-4267-87c1-cb8bce78fc5b	WRONG_ANSWER	5	1024	2026-06-19 05:18:46.551482+07	\N	\N	1605332
7989	449	87	bf94ac16-5998-45d9-b8e4-d5f0faa80cd0	WRONG_ANSWER	5	1028	2026-06-19 05:18:46.551473+07	\N	\N	-719618
7999	449	97	de241006-889d-45b9-87f2-206551a4fd89	WRONG_ANSWER	8	1016	2026-06-19 05:18:46.55148+07	\N	\N	-1290669
7991	449	89	88df914c-af65-43e3-9cf9-1ebc2eb7fd75	WRONG_ANSWER	5	1020	2026-06-19 05:18:46.551474+07	\N	\N	-836207
7995	449	93	a7a4a7e2-b907-4b4f-ac1f-40d5b086e1da	WRONG_ANSWER	5	864	2026-06-19 05:18:46.551478+07	\N	\N	-279899
7992	449	90	18895764-3bc7-4597-9c85-2d51b2c5a08f	WRONG_ANSWER	10	1092	2026-06-19 05:18:46.551475+07	\N	\N	314295
8004	449	102	68b102bd-a067-4a31-8a3c-ccd43a80fbd7	WRONG_ANSWER	6	944	2026-06-19 05:18:46.551483+07	\N	\N	214230
8005	449	103	da57d2e0-c2f6-4bb6-84ba-ce5a97984c09	WRONG_ANSWER	5	1084	2026-06-19 05:18:46.551484+07	\N	\N	-382256
7990	449	88	47671d37-587c-422b-bec3-83e4e606bfcf	WRONG_ANSWER	7	1024	2026-06-19 05:18:46.551473+07	\N	\N	-80534
8000	449	98	28d84ad9-ebaf-4d9a-bd74-49f9f72cd244	WRONG_ANSWER	6	988	2026-06-19 05:18:46.55148+07	\N	\N	-1143304
8008	449	106	5e80d117-5925-4d37-8bf9-2bc0167f93a7	WRONG_ANSWER	9	852	2026-06-19 05:18:46.551485+07	\N	\N	305688
8001	449	99	1e1174d6-814c-4e14-87e9-7eb5d5062e4c	WRONG_ANSWER	5	1088	2026-06-19 05:18:46.551481+07	\N	\N	439555
8007	449	105	a62a9993-a695-4429-82a8-91697218f631	WRONG_ANSWER	6	1024	2026-06-19 05:18:46.551485+07	\N	\N	-435215
8011	449	109	1f73646c-ba0e-416c-89e1-04840e499f1a	WRONG_ANSWER	6	1096	2026-06-19 05:18:46.551487+07	\N	\N	74475
8010	449	108	5c1d332d-58fd-4288-b830-91f294b8d764	WRONG_ANSWER	5	880	2026-06-19 05:18:46.551486+07	\N	\N	-492484
8012	449	110	f49bee26-633d-4224-a30f-1d439156858f	WRONG_ANSWER	6	1088	2026-06-19 05:18:46.551487+07	\N	\N	-1127699
8018	449	116	9004e21f-ba88-4462-be69-07eb2b644b40	WRONG_ANSWER	11	884	2026-06-19 05:18:46.551492+07	\N	\N	-101004
8013	449	111	889984a6-768c-47c5-89cd-756e2d251d92	WRONG_ANSWER	5	1024	2026-06-19 05:18:46.551488+07	\N	\N	972742
8015	449	113	a49e76d9-2d70-42d8-828a-29001d955304	WRONG_ANSWER	5	1036	2026-06-19 05:18:46.55149+07	\N	\N	170726
8016	449	114	a6f0c755-dcec-42ff-9f20-1c190d96b1ac	WRONG_ANSWER	5	1024	2026-06-19 05:18:46.55149+07	\N	\N	173654
8017	449	115	c15ec0ce-48c3-4576-903d-3e00585b5bfd	WRONG_ANSWER	7	1000	2026-06-19 05:18:46.551491+07	\N	\N	-1374564
7943	449	23	dccef696-3ab0-40e3-889a-5942b567977f	ACCEPTED	5	1048	2026-06-19 05:18:46.551413+07	\N	\N	0
7957	449	37	72ef4034-befa-4a90-979a-eee60ef8b3d5	WRONG_ANSWER	5	1020	2026-06-19 05:18:46.551421+07	\N	\N	776
7953	449	33	88fc6d5b-bc88-42a6-8bb9-74403fcd4a85	WRONG_ANSWER	5	1092	2026-06-19 05:18:46.551419+07	\N	\N	0
7964	449	62	722416d5-3a88-4626-954d-609d8492b7e5	WRONG_ANSWER	6	860	2026-06-19 05:18:46.551455+07	\N	\N	-67076
7965	449	63	af6a5ac2-f57f-41c5-8b1e-a07af9d86173	WRONG_ANSWER	7	1084	2026-06-19 05:18:46.551456+07	\N	\N	363660
7981	449	79	c13973c0-1700-497b-8f17-df60da7d0af8	WRONG_ANSWER	5	1084	2026-06-19 05:18:46.551467+07	\N	\N	65409
7983	449	81	78f507a6-999a-4c11-bd36-52fe704ee030	WRONG_ANSWER	7	1036	2026-06-19 05:18:46.551468+07	\N	\N	447637
7998	449	96	f2b546fd-5032-4e06-860a-5d11e11eb926	WRONG_ANSWER	6	872	2026-06-19 05:18:46.551479+07	\N	\N	665864
8002	449	100	4e825e76-d59f-4a94-8a01-e5a12e470288	WRONG_ANSWER	5	1092	2026-06-19 05:18:46.551482+07	\N	\N	1305534
8006	449	104	ebba498f-bb23-4f0d-944d-7e8ae840271e	WRONG_ANSWER	5	868	2026-06-19 05:18:46.551484+07	\N	\N	984148
8014	449	112	dbd5bfa7-01ef-481a-b2e3-3b8a5b6c5617	WRONG_ANSWER	7	1008	2026-06-19 05:18:46.551489+07	\N	\N	-408917
8019	449	117	a117925f-e57e-4bb9-9228-cda3273105b6	WRONG_ANSWER	5	1056	2026-06-19 05:18:46.551492+07	\N	\N	853830231
8026	449	124	7742b2c0-09c3-4b3e-847f-b44be6ee7af0	WRONG_ANSWER	5	868	2026-06-19 05:18:46.551497+07	\N	\N	337466273
8021	449	119	26e9c887-5eea-463b-b114-d2f861178d3b	WRONG_ANSWER	13	1040	2026-06-19 05:18:46.551493+07	\N	\N	-143262831
8023	449	121	e0f5be2d-f941-421c-ac63-a0d6541492a5	WRONG_ANSWER	17	964	2026-06-19 05:18:46.551495+07	\N	\N	167726425
8024	449	122	0d9835f7-ec40-4514-8175-afb57f5ec486	WRONG_ANSWER	6	876	2026-06-19 05:18:46.551495+07	\N	\N	131005719
8020	449	118	28b8ba11-819f-4c33-8c7b-9d6f70216bad	WRONG_ANSWER	6	1028	2026-06-19 05:18:46.551493+07	\N	\N	-1148342312
8022	449	120	98566098-93e3-4b11-8876-ffa902362c71	WRONG_ANSWER	8	988	2026-06-19 05:18:46.551494+07	\N	\N	1609477383
8025	449	123	9b7539b6-4bf2-4214-bb5e-db68ed4803d4	WRONG_ANSWER	5	1028	2026-06-19 05:18:46.551496+07	\N	\N	197161384
8027	449	125	673b7fd4-63a7-4320-aee1-7a7abc77ffc6	WRONG_ANSWER	4	868	2026-06-19 05:18:46.551497+07	\N	\N	404026447
8030	449	128	b9a7ee5d-4fb2-4df1-b213-e1dd9628534c	WRONG_ANSWER	6	872	2026-06-19 05:18:46.551499+07	\N	\N	66
8034	449	132	f6beb1e4-f453-4b05-9603-2727bf5e17fd	WRONG_ANSWER	7	1008	2026-06-19 05:18:46.551502+07	\N	\N	71
8032	449	130	d263a702-4a96-49c4-b64d-2e5a853ff554	WRONG_ANSWER	6	1024	2026-06-19 05:18:46.551501+07	\N	\N	1
8031	449	129	0d56e532-fe44-41b8-a07a-e5cf629d34ba	WRONG_ANSWER	5	800	2026-06-19 05:18:46.5515+07	\N	\N	136
8033	449	131	ccb77dce-14e0-4b3d-852b-f6408fe6c515	WRONG_ANSWER	6	868	2026-06-19 05:18:46.551501+07	\N	\N	33
8029	449	127	88f463bf-b7ed-49f7-bbe2-aef2e98f4316	WRONG_ANSWER	8	836	2026-06-19 05:18:46.551499+07	\N	\N	120
8028	449	126	9add3be1-61d4-41bd-9bc3-37eb98f21c85	WRONG_ANSWER	5	1088	2026-06-19 05:18:46.551498+07	\N	\N	-760924093
8035	449	133	acf2cf2a-4cd1-4e67-aec8-4d4545c217b4	WRONG_ANSWER	6	1056	2026-06-19 05:18:46.551503+07	\N	\N	139
8038	449	136	730857c4-4714-4e12-86e4-88d2e5142244	WRONG_ANSWER	4	1032	2026-06-19 05:18:46.551504+07	\N	\N	-55
8036	449	134	3cb6321e-6411-47f1-a947-6af0c5c34d7d	WRONG_ANSWER	4	1060	2026-06-19 05:18:46.551503+07	\N	\N	-10
8039	449	137	69918192-f81e-408d-a6b3-a9b42a03c82a	WRONG_ANSWER	2	1260	2026-06-19 05:18:46.551505+07	\N	\N	-128
8040	449	138	f5f1386b-35e3-4c7f-98be-6481f0fcfbe9	WRONG_ANSWER	3	1024	2026-06-19 05:18:46.551505+07	\N	\N	77
8037	449	135	9ddb168b-8d46-4853-a398-5aa945f64363	WRONG_ANSWER	2	1020	2026-06-19 05:18:46.551504+07	\N	\N	-145
8956	460	34	8d4239b1-aed0-4c2d-9813-adbb54b8545c	ACCEPTED	5	988	2026-06-21 02:01:32.405724+07	\N	\N	15
8963	460	59	11704337-a166-4456-9185-dc8174bdc74d	ACCEPTED	5	1008	2026-06-21 02:01:32.405735+07	\N	\N	545178
8958	460	36	ec64801e-0b58-4635-a512-f3231612300f	ACCEPTED	5	800	2026-06-21 02:01:32.405727+07	\N	\N	801
8965	460	61	7483849a-cbf3-488b-81e7-e54606ead56c	ACCEPTED	4	1088	2026-06-21 02:01:32.405739+07	\N	\N	879721
8950	460	28	bd72d979-b62a-41d0-8710-29319e78e7e2	ACCEPTED	6	968	2026-06-21 02:01:32.405714+07	\N	\N	579
8966	460	62	c556584a-c47a-4c98-880a-0304359e646a	ACCEPTED	4	1100	2026-06-21 02:01:32.40574+07	\N	\N	1486218
8954	460	32	292169b8-a17a-43d4-9492-fc2fb63292f6	ACCEPTED	5	888	2026-06-21 02:01:32.405721+07	\N	\N	0
8959	460	37	9d44ee03-649f-4415-a1d7-45d9f91f345f	ACCEPTED	4	860	2026-06-21 02:01:32.405729+07	\N	\N	1000
8969	460	65	15984323-fb83-4bfa-85ed-276360253eb2	ACCEPTED	5	868	2026-06-21 02:01:32.405745+07	\N	\N	475745
8967	460	63	e93ab762-3aee-4837-aba6-2007a6190052	ACCEPTED	7	828	2026-06-21 02:01:32.405742+07	\N	\N	1507378
8972	460	68	85e5b9a5-fbdc-4277-a812-d994063323da	ACCEPTED	5	1020	2026-06-21 02:01:32.40575+07	\N	\N	1161167
8974	460	70	b2545d17-52dc-4a98-bdb3-00cb2ad077dc	ACCEPTED	5	1024	2026-06-21 02:01:32.405755+07	\N	\N	959298
8970	460	66	2294e000-be34-4228-b128-5dcd5e195a4d	ACCEPTED	5	1092	2026-06-21 02:01:32.405747+07	\N	\N	129492
8975	460	71	f2b5b6a3-94ac-4ca1-aaaa-f173210b2a28	ACCEPTED	5	896	2026-06-21 02:01:32.405772+07	\N	\N	1416847
8980	460	76	6387d0f7-e22e-48b7-b2a0-73c44d3074d5	ACCEPTED	5	1096	2026-06-21 02:01:32.405781+07	\N	\N	802483
8973	460	69	f9fad8dc-33a7-4e07-a99b-7be6811b0914	ACCEPTED	5	872	2026-06-21 02:01:32.405751+07	\N	\N	616334
8989	460	85	3691b183-423f-4deb-afda-863a0fa401c3	ACCEPTED	4	856	2026-06-21 02:01:32.405796+07	\N	\N	-1006285
9000	460	96	e41ccaa7-d264-4813-a7fb-5c77518982a1	ACCEPTED	6	976	2026-06-21 02:01:32.405814+07	\N	\N	-1188270
9009	460	105	37bd0bc3-c675-4d3c-a711-5187aec294b7	ACCEPTED	4	1088	2026-06-21 02:01:32.405829+07	\N	\N	-882565
9004	460	100	64c19a78-84fa-4e92-b708-a9583e7507e5	ACCEPTED	5	900	2026-06-21 02:01:32.405821+07	\N	\N	281928
9020	460	116	0e2b6364-cfd7-478c-bed0-0f284a9f362c	ACCEPTED	6	1012	2026-06-21 02:01:32.405848+07	\N	\N	785356
9032	460	128	f5705873-4ec3-4be1-8f02-a3c283f2c0da	ACCEPTED	5	884	2026-06-21 02:01:32.40588+07	\N	\N	82
9035	460	131	42c24eee-f14f-4d0f-9717-51f241330de7	ACCEPTED	4	984	2026-06-21 02:01:32.405885+07	\N	\N	71
9044	461	22	3aaa6bd4-518f-4084-a5cd-0f09c507c588	ACCEPTED	8	880	2026-06-21 02:01:47.819776+07	\N	\N	30
9046	461	24	4cbe0e27-3d7d-4b63-967b-36950ff5503b	ACCEPTED	5	988	2026-06-21 02:01:47.819782+07	\N	\N	0
9047	461	25	0325ca59-d9fa-4d67-8a23-1791d19c4825	ACCEPTED	5	1016	2026-06-21 02:01:47.819785+07	\N	\N	300
7947	449	27	329a86b7-2524-421f-8c16-b49ab9a49857	WRONG_ANSWER	5	1032	2026-06-19 05:18:46.551415+07	\N	\N	998
7976	449	74	0adc2204-a58f-4d27-bcfd-707e530d6b26	WRONG_ANSWER	6	904	2026-06-19 05:18:46.551464+07	\N	\N	326185
8009	449	107	bcc45f6f-f61d-4133-a1a6-253c940e62f8	WRONG_ANSWER	6	924	2026-06-19 05:18:46.551486+07	\N	\N	845566
8960	460	38	6c382249-87eb-4b73-a1d1-655da370f215	ACCEPTED	5	1028	2026-06-21 02:01:32.40573+07	\N	\N	3000000
8047	450	27	aec437f6-ff2b-4700-bbbe-ab158f397d81	COMPILATION_ERROR	0	\N	2026-06-19 05:19:15.181803+07	main.cpp: In function ‘int main()’:\nmain.cpp:8:18: error: expected ‘;’ before ‘return’\n    8 |     cout << a - b\n      |                  ^\n      |                  ;\n    9 |     return 0;\n      |     ~~~~~~        \n	\N	\N
8053	450	33	61b2349e-f9d2-4891-8f0a-ed12729a80ce	COMPILATION_ERROR	0	\N	2026-06-19 05:19:15.181806+07	main.cpp: In function ‘int main()’:\nmain.cpp:8:18: error: expected ‘;’ before ‘return’\n    8 |     cout << a - b\n      |                  ^\n      |                  ;\n    9 |     return 0;\n      |     ~~~~~~        \n	\N	\N
8052	450	32	f154ce3e-68a9-46f6-b63b-d7e851e6c7e6	COMPILATION_ERROR	0	\N	2026-06-19 05:19:15.181806+07	main.cpp: In function ‘int main()’:\nmain.cpp:8:18: error: expected ‘;’ before ‘return’\n    8 |     cout << a - b\n      |                  ^\n      |                  ;\n    9 |     return 0;\n      |     ~~~~~~        \n	\N	\N
8055	450	35	043bdc91-d2f6-4d59-b4c7-8c78c7ee6c68	COMPILATION_ERROR	0	\N	2026-06-19 05:19:15.181807+07	main.cpp: In function ‘int main()’:\nmain.cpp:8:18: error: expected ‘;’ before ‘return’\n    8 |     cout << a - b\n      |                  ^\n      |                  ;\n    9 |     return 0;\n      |     ~~~~~~        \n	\N	\N
8049	450	29	e5061a98-f985-4829-b928-2fbfad0573b3	COMPILATION_ERROR	0	\N	2026-06-19 05:19:15.181804+07	main.cpp: In function ‘int main()’:\nmain.cpp:8:18: error: expected ‘;’ before ‘return’\n    8 |     cout << a - b\n      |                  ^\n      |                  ;\n    9 |     return 0;\n      |     ~~~~~~        \n	\N	\N
8064	450	62	a84c59fe-f25d-4868-b95b-29874ef4e4fd	COMPILATION_ERROR	0	\N	2026-06-19 05:19:15.181812+07	main.cpp: In function ‘int main()’:\nmain.cpp:8:18: error: expected ‘;’ before ‘return’\n    8 |     cout << a - b\n      |                  ^\n      |                  ;\n    9 |     return 0;\n      |     ~~~~~~        \n	\N	\N
8063	450	61	76e17617-d9cc-40ed-93a3-01b4f4e84878	COMPILATION_ERROR	0	\N	2026-06-19 05:19:15.181811+07	main.cpp: In function ‘int main()’:\nmain.cpp:8:18: error: expected ‘;’ before ‘return’\n    8 |     cout << a - b\n      |                  ^\n      |                  ;\n    9 |     return 0;\n      |     ~~~~~~        \n	\N	\N
8069	450	67	dcf529c1-42f0-4bc6-b7c1-1bf8ecd16fa0	COMPILATION_ERROR	0	\N	2026-06-19 05:19:15.18183+07	main.cpp: In function ‘int main()’:\nmain.cpp:8:18: error: expected ‘;’ before ‘return’\n    8 |     cout << a - b\n      |                  ^\n      |                  ;\n    9 |     return 0;\n      |     ~~~~~~        \n	\N	\N
8070	450	68	0af41660-9d7a-44ab-bafe-370bd3115c5b	COMPILATION_ERROR	0	\N	2026-06-19 05:19:15.181831+07	main.cpp: In function ‘int main()’:\nmain.cpp:8:18: error: expected ‘;’ before ‘return’\n    8 |     cout << a - b\n      |                  ^\n      |                  ;\n    9 |     return 0;\n      |     ~~~~~~        \n	\N	\N
8072	450	70	92bd935e-7e30-4c2f-8abe-9f01edf3e37d	COMPILATION_ERROR	0	\N	2026-06-19 05:19:15.181833+07	main.cpp: In function ‘int main()’:\nmain.cpp:8:18: error: expected ‘;’ before ‘return’\n    8 |     cout << a - b\n      |                  ^\n      |                  ;\n    9 |     return 0;\n      |     ~~~~~~        \n	\N	\N
8088	450	86	ca803799-48dc-4aa2-b295-c10abc3ddbfb	COMPILATION_ERROR	0	\N	2026-06-19 05:19:15.181845+07	main.cpp: In function ‘int main()’:\nmain.cpp:8:18: error: expected ‘;’ before ‘return’\n    8 |     cout << a - b\n      |                  ^\n      |                  ;\n    9 |     return 0;\n      |     ~~~~~~        \n	\N	\N
8081	450	79	b6bec25f-491a-4433-8747-303d883eb29a	COMPILATION_ERROR	0	\N	2026-06-19 05:19:15.181838+07	main.cpp: In function ‘int main()’:\nmain.cpp:8:18: error: expected ‘;’ before ‘return’\n    8 |     cout << a - b\n      |                  ^\n      |                  ;\n    9 |     return 0;\n      |     ~~~~~~        \n	\N	\N
8073	450	71	1d3757a5-7831-4347-9470-d245c3e1a334	COMPILATION_ERROR	0	\N	2026-06-19 05:19:15.181833+07	main.cpp: In function ‘int main()’:\nmain.cpp:8:18: error: expected ‘;’ before ‘return’\n    8 |     cout << a - b\n      |                  ^\n      |                  ;\n    9 |     return 0;\n      |     ~~~~~~        \n	\N	\N
8079	450	77	b9c5cc2c-e655-4413-b1c0-c875fd2bb18e	COMPILATION_ERROR	0	\N	2026-06-19 05:19:15.181836+07	main.cpp: In function ‘int main()’:\nmain.cpp:8:18: error: expected ‘;’ before ‘return’\n    8 |     cout << a - b\n      |                  ^\n      |                  ;\n    9 |     return 0;\n      |     ~~~~~~        \n	\N	\N
8089	450	87	b1be3421-8cc9-4bd3-b2e9-108527ba3ef1	COMPILATION_ERROR	0	\N	2026-06-19 05:19:15.181846+07	main.cpp: In function ‘int main()’:\nmain.cpp:8:18: error: expected ‘;’ before ‘return’\n    8 |     cout << a - b\n      |                  ^\n      |                  ;\n    9 |     return 0;\n      |     ~~~~~~        \n	\N	\N
8091	450	89	4a8449a2-d0d6-4c2f-9731-909457554446	COMPILATION_ERROR	0	\N	2026-06-19 05:19:15.181847+07	main.cpp: In function ‘int main()’:\nmain.cpp:8:18: error: expected ‘;’ before ‘return’\n    8 |     cout << a - b\n      |                  ^\n      |                  ;\n    9 |     return 0;\n      |     ~~~~~~        \n	\N	\N
8094	450	92	9fbbc90e-92c3-414e-ae60-ae3672267751	COMPILATION_ERROR	0	\N	2026-06-19 05:19:15.181849+07	main.cpp: In function ‘int main()’:\nmain.cpp:8:18: error: expected ‘;’ before ‘return’\n    8 |     cout << a - b\n      |                  ^\n      |                  ;\n    9 |     return 0;\n      |     ~~~~~~        \n	\N	\N
8099	450	97	01690e5f-e950-481b-aed1-640599db4156	COMPILATION_ERROR	0	\N	2026-06-19 05:19:15.181852+07	main.cpp: In function ‘int main()’:\nmain.cpp:8:18: error: expected ‘;’ before ‘return’\n    8 |     cout << a - b\n      |                  ^\n      |                  ;\n    9 |     return 0;\n      |     ~~~~~~        \n	\N	\N
8097	450	95	182a13f2-eb15-455f-a076-879575f9919d	COMPILATION_ERROR	0	\N	2026-06-19 05:19:15.181851+07	main.cpp: In function ‘int main()’:\nmain.cpp:8:18: error: expected ‘;’ before ‘return’\n    8 |     cout << a - b\n      |                  ^\n      |                  ;\n    9 |     return 0;\n      |     ~~~~~~        \n	\N	\N
8098	450	96	7dfbbda0-f324-4973-814b-5845b674f23b	COMPILATION_ERROR	0	\N	2026-06-19 05:19:15.181851+07	main.cpp: In function ‘int main()’:\nmain.cpp:8:18: error: expected ‘;’ before ‘return’\n    8 |     cout << a - b\n      |                  ^\n      |                  ;\n    9 |     return 0;\n      |     ~~~~~~        \n	\N	\N
8105	450	103	c03a0bce-de6f-4623-8bc7-a063a87aec26	COMPILATION_ERROR	0	\N	2026-06-19 05:19:15.181854+07	main.cpp: In function ‘int main()’:\nmain.cpp:8:18: error: expected ‘;’ before ‘return’\n    8 |     cout << a - b\n      |                  ^\n      |                  ;\n    9 |     return 0;\n      |     ~~~~~~        \n	\N	\N
8045	450	25	d7cdd4a4-7e74-4a37-aa43-945531260618	COMPILATION_ERROR	0	\N	2026-06-19 05:19:15.181802+07	main.cpp: In function ‘int main()’:\nmain.cpp:8:18: error: expected ‘;’ before ‘return’\n    8 |     cout << a - b\n      |                  ^\n      |                  ;\n    9 |     return 0;\n      |     ~~~~~~        \n	\N	\N
8043	450	23	b5cd7b68-984b-449e-a616-ab24fc4e10fe	COMPILATION_ERROR	0	\N	2026-06-19 05:19:15.181801+07	main.cpp: In function ‘int main()’:\nmain.cpp:8:18: error: expected ‘;’ before ‘return’\n    8 |     cout << a - b\n      |                  ^\n      |                  ;\n    9 |     return 0;\n      |     ~~~~~~        \n	\N	\N
8061	450	59	1e87a2e5-43df-442f-992c-4be4f921b9bd	COMPILATION_ERROR	0	\N	2026-06-19 05:19:15.18181+07	main.cpp: In function ‘int main()’:\nmain.cpp:8:18: error: expected ‘;’ before ‘return’\n    8 |     cout << a - b\n      |                  ^\n      |                  ;\n    9 |     return 0;\n      |     ~~~~~~        \n	\N	\N
8051	450	31	66d1a5ad-b48d-47c1-b121-72f4437a702b	COMPILATION_ERROR	0	\N	2026-06-19 05:19:15.181805+07	main.cpp: In function ‘int main()’:\nmain.cpp:8:18: error: expected ‘;’ before ‘return’\n    8 |     cout << a - b\n      |                  ^\n      |                  ;\n    9 |     return 0;\n      |     ~~~~~~        \n	\N	\N
8041	450	21	5b8d7860-d4e9-471e-91fb-7dd409625850	COMPILATION_ERROR	0	\N	2026-06-19 05:19:15.18179+07	main.cpp: In function ‘int main()’:\nmain.cpp:8:18: error: expected ‘;’ before ‘return’\n    8 |     cout << a - b\n      |                  ^\n      |                  ;\n    9 |     return 0;\n      |     ~~~~~~        \n	\N	\N
8046	450	26	5fdea527-b10c-4220-96f4-072eed3c936b	COMPILATION_ERROR	0	\N	2026-06-19 05:19:15.181802+07	main.cpp: In function ‘int main()’:\nmain.cpp:8:18: error: expected ‘;’ before ‘return’\n    8 |     cout << a - b\n      |                  ^\n      |                  ;\n    9 |     return 0;\n      |     ~~~~~~        \n	\N	\N
8042	450	22	a7fa63ae-593c-4503-82c6-e308b05764b3	COMPILATION_ERROR	0	\N	2026-06-19 05:19:15.1818+07	main.cpp: In function ‘int main()’:\nmain.cpp:8:18: error: expected ‘;’ before ‘return’\n    8 |     cout << a - b\n      |                  ^\n      |                  ;\n    9 |     return 0;\n      |     ~~~~~~        \n	\N	\N
8044	450	24	a1f3047e-32e4-40cd-9832-b7daa63d877c	COMPILATION_ERROR	0	\N	2026-06-19 05:19:15.181801+07	main.cpp: In function ‘int main()’:\nmain.cpp:8:18: error: expected ‘;’ before ‘return’\n    8 |     cout << a - b\n      |                  ^\n      |                  ;\n    9 |     return 0;\n      |     ~~~~~~        \n	\N	\N
8054	450	34	f02974d3-89fa-4226-87ea-0042bfae198e	COMPILATION_ERROR	0	\N	2026-06-19 05:19:15.181807+07	main.cpp: In function ‘int main()’:\nmain.cpp:8:18: error: expected ‘;’ before ‘return’\n    8 |     cout << a - b\n      |                  ^\n      |                  ;\n    9 |     return 0;\n      |     ~~~~~~        \n	\N	\N
8048	450	28	8ee66a84-491b-4154-9767-2e65fd9ede60	COMPILATION_ERROR	0	\N	2026-06-19 05:19:15.181803+07	main.cpp: In function ‘int main()’:\nmain.cpp:8:18: error: expected ‘;’ before ‘return’\n    8 |     cout << a - b\n      |                  ^\n      |                  ;\n    9 |     return 0;\n      |     ~~~~~~        \n	\N	\N
8056	450	36	f2871d01-2704-4f64-b47b-fe9444cc7d94	COMPILATION_ERROR	0	\N	2026-06-19 05:19:15.181807+07	main.cpp: In function ‘int main()’:\nmain.cpp:8:18: error: expected ‘;’ before ‘return’\n    8 |     cout << a - b\n      |                  ^\n      |                  ;\n    9 |     return 0;\n      |     ~~~~~~        \n	\N	\N
8050	450	30	ef75f3fd-046b-4e7e-bc36-9ffb547dd6bb	COMPILATION_ERROR	0	\N	2026-06-19 05:19:15.181804+07	main.cpp: In function ‘int main()’:\nmain.cpp:8:18: error: expected ‘;’ before ‘return’\n    8 |     cout << a - b\n      |                  ^\n      |                  ;\n    9 |     return 0;\n      |     ~~~~~~        \n	\N	\N
8109	450	107	7129e8ae-5cbe-4e96-94fd-541926a1100b	COMPILATION_ERROR	0	\N	2026-06-19 05:19:15.181856+07	main.cpp: In function ‘int main()’:\nmain.cpp:8:18: error: expected ‘;’ before ‘return’\n    8 |     cout << a - b\n      |                  ^\n      |                  ;\n    9 |     return 0;\n      |     ~~~~~~        \n	\N	\N
8118	450	116	cf12da71-9295-43e2-abbd-96e263d8ad48	COMPILATION_ERROR	0	\N	2026-06-19 05:19:15.181861+07	main.cpp: In function ‘int main()’:\nmain.cpp:8:18: error: expected ‘;’ before ‘return’\n    8 |     cout << a - b\n      |                  ^\n      |                  ;\n    9 |     return 0;\n      |     ~~~~~~        \n	\N	\N
8116	450	114	39e8e8cf-bb70-43d3-ad9c-64cae808c831	COMPILATION_ERROR	0	\N	2026-06-19 05:19:15.18186+07	main.cpp: In function ‘int main()’:\nmain.cpp:8:18: error: expected ‘;’ before ‘return’\n    8 |     cout << a - b\n      |                  ^\n      |                  ;\n    9 |     return 0;\n      |     ~~~~~~        \n	\N	\N
8114	450	112	5bfff837-572e-4588-9c2b-15c1041042a9	COMPILATION_ERROR	0	\N	2026-06-19 05:19:15.181859+07	main.cpp: In function ‘int main()’:\nmain.cpp:8:18: error: expected ‘;’ before ‘return’\n    8 |     cout << a - b\n      |                  ^\n      |                  ;\n    9 |     return 0;\n      |     ~~~~~~        \n	\N	\N
8119	450	117	f41e34b0-40b2-4e9a-a379-9984de396489	COMPILATION_ERROR	0	\N	2026-06-19 05:19:15.181861+07	main.cpp: In function ‘int main()’:\nmain.cpp:8:18: error: expected ‘;’ before ‘return’\n    8 |     cout << a - b\n      |                  ^\n      |                  ;\n    9 |     return 0;\n      |     ~~~~~~        \n	\N	\N
8130	450	128	880bde97-9587-456b-ace9-956724f01783	COMPILATION_ERROR	0	\N	2026-06-19 05:19:15.181867+07	main.cpp: In function ‘int main()’:\nmain.cpp:8:18: error: expected ‘;’ before ‘return’\n    8 |     cout << a - b\n      |                  ^\n      |                  ;\n    9 |     return 0;\n      |     ~~~~~~        \n	\N	\N
8127	450	125	ca941da4-1308-467c-b770-811939c8ce34	COMPILATION_ERROR	0	\N	2026-06-19 05:19:15.181865+07	main.cpp: In function ‘int main()’:\nmain.cpp:8:18: error: expected ‘;’ before ‘return’\n    8 |     cout << a - b\n      |                  ^\n      |                  ;\n    9 |     return 0;\n      |     ~~~~~~        \n	\N	\N
8133	450	131	20b7e625-a35c-49a7-a482-87a466dc5d95	COMPILATION_ERROR	0	\N	2026-06-19 05:19:15.181869+07	main.cpp: In function ‘int main()’:\nmain.cpp:8:18: error: expected ‘;’ before ‘return’\n    8 |     cout << a - b\n      |                  ^\n      |                  ;\n    9 |     return 0;\n      |     ~~~~~~        \n	\N	\N
8136	450	134	9a806c7a-23b2-4775-a397-975e023779b2	COMPILATION_ERROR	0	\N	2026-06-19 05:19:15.18187+07	main.cpp: In function ‘int main()’:\nmain.cpp:8:18: error: expected ‘;’ before ‘return’\n    8 |     cout << a - b\n      |                  ^\n      |                  ;\n    9 |     return 0;\n      |     ~~~~~~        \n	\N	\N
8138	450	136	c21223ac-ca33-43df-abe4-2479efd1e697	COMPILATION_ERROR	0	\N	2026-06-19 05:19:15.181871+07	main.cpp: In function ‘int main()’:\nmain.cpp:8:18: error: expected ‘;’ before ‘return’\n    8 |     cout << a - b\n      |                  ^\n      |                  ;\n    9 |     return 0;\n      |     ~~~~~~        \n	\N	\N
8191	451	89	ab264da6-ab24-4ac5-b511-a6c6169bc337	WRONG_ANSWER	1822	1092	2026-06-19 05:20:01.84757+07	\N	\N	\N
8190	451	88	c4efe402-1373-4ada-857c-a28ac5c81c22	WRONG_ANSWER	1739	1024	2026-06-19 05:20:01.847569+07	\N	\N	\N
8057	450	37	4decec15-fcb2-4874-9168-3ee1bc2f9003	COMPILATION_ERROR	0	\N	2026-06-19 05:19:15.181808+07	main.cpp: In function ‘int main()’:\nmain.cpp:8:18: error: expected ‘;’ before ‘return’\n    8 |     cout << a - b\n      |                  ^\n      |                  ;\n    9 |     return 0;\n      |     ~~~~~~        \n	\N	\N
8059	450	57	6e020da0-0117-4148-bb70-a7f397388f26	COMPILATION_ERROR	0	\N	2026-06-19 05:19:15.181809+07	main.cpp: In function ‘int main()’:\nmain.cpp:8:18: error: expected ‘;’ before ‘return’\n    8 |     cout << a - b\n      |                  ^\n      |                  ;\n    9 |     return 0;\n      |     ~~~~~~        \n	\N	\N
8060	450	58	512bfe1b-0e24-4cbb-a02a-18fc088f969f	COMPILATION_ERROR	0	\N	2026-06-19 05:19:15.18181+07	main.cpp: In function ‘int main()’:\nmain.cpp:8:18: error: expected ‘;’ before ‘return’\n    8 |     cout << a - b\n      |                  ^\n      |                  ;\n    9 |     return 0;\n      |     ~~~~~~        \n	\N	\N
8058	450	38	d9817037-d285-4f63-969b-5cd3d4b935a4	COMPILATION_ERROR	0	\N	2026-06-19 05:19:15.181808+07	main.cpp: In function ‘int main()’:\nmain.cpp:8:18: error: expected ‘;’ before ‘return’\n    8 |     cout << a - b\n      |                  ^\n      |                  ;\n    9 |     return 0;\n      |     ~~~~~~        \n	\N	\N
8062	450	60	57c71220-9164-437d-912b-30c9ac1ca8d6	COMPILATION_ERROR	0	\N	2026-06-19 05:19:15.181811+07	main.cpp: In function ‘int main()’:\nmain.cpp:8:18: error: expected ‘;’ before ‘return’\n    8 |     cout << a - b\n      |                  ^\n      |                  ;\n    9 |     return 0;\n      |     ~~~~~~        \n	\N	\N
8068	450	66	68a9415e-aa3b-4095-908c-39476ee41ce5	COMPILATION_ERROR	0	\N	2026-06-19 05:19:15.181815+07	main.cpp: In function ‘int main()’:\nmain.cpp:8:18: error: expected ‘;’ before ‘return’\n    8 |     cout << a - b\n      |                  ^\n      |                  ;\n    9 |     return 0;\n      |     ~~~~~~        \n	\N	\N
8067	450	65	037d83b4-006f-4d48-9d5f-e0d37d363e66	COMPILATION_ERROR	0	\N	2026-06-19 05:19:15.181814+07	main.cpp: In function ‘int main()’:\nmain.cpp:8:18: error: expected ‘;’ before ‘return’\n    8 |     cout << a - b\n      |                  ^\n      |                  ;\n    9 |     return 0;\n      |     ~~~~~~        \n	\N	\N
8066	450	64	cda8f88e-274f-49e0-b9de-aa9e0288c65d	COMPILATION_ERROR	0	\N	2026-06-19 05:19:15.181813+07	main.cpp: In function ‘int main()’:\nmain.cpp:8:18: error: expected ‘;’ before ‘return’\n    8 |     cout << a - b\n      |                  ^\n      |                  ;\n    9 |     return 0;\n      |     ~~~~~~        \n	\N	\N
8075	450	73	e8c38aa2-19ff-4db0-a177-f97aa6362c38	COMPILATION_ERROR	0	\N	2026-06-19 05:19:15.181834+07	main.cpp: In function ‘int main()’:\nmain.cpp:8:18: error: expected ‘;’ before ‘return’\n    8 |     cout << a - b\n      |                  ^\n      |                  ;\n    9 |     return 0;\n      |     ~~~~~~        \n	\N	\N
8083	450	81	be99c06e-7c18-4a01-820d-fe602286f2d3	COMPILATION_ERROR	0	\N	2026-06-19 05:19:15.181839+07	main.cpp: In function ‘int main()’:\nmain.cpp:8:18: error: expected ‘;’ before ‘return’\n    8 |     cout << a - b\n      |                  ^\n      |                  ;\n    9 |     return 0;\n      |     ~~~~~~        \n	\N	\N
8082	450	80	5243df0d-3277-4bbf-8033-849eb1a7e8b4	COMPILATION_ERROR	0	\N	2026-06-19 05:19:15.181838+07	main.cpp: In function ‘int main()’:\nmain.cpp:8:18: error: expected ‘;’ before ‘return’\n    8 |     cout << a - b\n      |                  ^\n      |                  ;\n    9 |     return 0;\n      |     ~~~~~~        \n	\N	\N
8085	450	83	4cbdb0cc-5810-48ed-b821-a78c861c7c98	COMPILATION_ERROR	0	\N	2026-06-19 05:19:15.18184+07	main.cpp: In function ‘int main()’:\nmain.cpp:8:18: error: expected ‘;’ before ‘return’\n    8 |     cout << a - b\n      |                  ^\n      |                  ;\n    9 |     return 0;\n      |     ~~~~~~        \n	\N	\N
8077	450	75	3536a0a0-bc8c-41ed-b142-09dab45af5ae	COMPILATION_ERROR	0	\N	2026-06-19 05:19:15.181835+07	main.cpp: In function ‘int main()’:\nmain.cpp:8:18: error: expected ‘;’ before ‘return’\n    8 |     cout << a - b\n      |                  ^\n      |                  ;\n    9 |     return 0;\n      |     ~~~~~~        \n	\N	\N
8074	450	72	28101b1f-fac3-4362-8e7b-d79a462bb5db	COMPILATION_ERROR	0	\N	2026-06-19 05:19:15.181834+07	main.cpp: In function ‘int main()’:\nmain.cpp:8:18: error: expected ‘;’ before ‘return’\n    8 |     cout << a - b\n      |                  ^\n      |                  ;\n    9 |     return 0;\n      |     ~~~~~~        \n	\N	\N
8071	450	69	e0669dbb-f465-488d-b3b0-7c19c191d2da	COMPILATION_ERROR	0	\N	2026-06-19 05:19:15.181832+07	main.cpp: In function ‘int main()’:\nmain.cpp:8:18: error: expected ‘;’ before ‘return’\n    8 |     cout << a - b\n      |                  ^\n      |                  ;\n    9 |     return 0;\n      |     ~~~~~~        \n	\N	\N
8076	450	74	9b4e87d1-3405-4799-8c97-b99f816ff508	COMPILATION_ERROR	0	\N	2026-06-19 05:19:15.181835+07	main.cpp: In function ‘int main()’:\nmain.cpp:8:18: error: expected ‘;’ before ‘return’\n    8 |     cout << a - b\n      |                  ^\n      |                  ;\n    9 |     return 0;\n      |     ~~~~~~        \n	\N	\N
8080	450	78	3ad9b28d-f063-4128-8a6e-7afd7571870f	COMPILATION_ERROR	0	\N	2026-06-19 05:19:15.181837+07	main.cpp: In function ‘int main()’:\nmain.cpp:8:18: error: expected ‘;’ before ‘return’\n    8 |     cout << a - b\n      |                  ^\n      |                  ;\n    9 |     return 0;\n      |     ~~~~~~        \n	\N	\N
8086	450	84	b7ca41b1-d6f0-4ac0-b990-5376a7aad481	COMPILATION_ERROR	0	\N	2026-06-19 05:19:15.181841+07	main.cpp: In function ‘int main()’:\nmain.cpp:8:18: error: expected ‘;’ before ‘return’\n    8 |     cout << a - b\n      |                  ^\n      |                  ;\n    9 |     return 0;\n      |     ~~~~~~        \n	\N	\N
8087	450	85	d72f4856-d688-4c3a-98b5-1bd45cdf8d29	COMPILATION_ERROR	0	\N	2026-06-19 05:19:15.181845+07	main.cpp: In function ‘int main()’:\nmain.cpp:8:18: error: expected ‘;’ before ‘return’\n    8 |     cout << a - b\n      |                  ^\n      |                  ;\n    9 |     return 0;\n      |     ~~~~~~        \n	\N	\N
8084	450	82	1963af41-a9af-4f1c-903b-577fe065ea63	COMPILATION_ERROR	0	\N	2026-06-19 05:19:15.181839+07	main.cpp: In function ‘int main()’:\nmain.cpp:8:18: error: expected ‘;’ before ‘return’\n    8 |     cout << a - b\n      |                  ^\n      |                  ;\n    9 |     return 0;\n      |     ~~~~~~        \n	\N	\N
8090	450	88	83141090-dc67-4398-bc04-ac3bc5517cd0	COMPILATION_ERROR	0	\N	2026-06-19 05:19:15.181846+07	main.cpp: In function ‘int main()’:\nmain.cpp:8:18: error: expected ‘;’ before ‘return’\n    8 |     cout << a - b\n      |                  ^\n      |                  ;\n    9 |     return 0;\n      |     ~~~~~~        \n	\N	\N
8093	450	91	beaf156e-0c4c-4a48-ae08-8f6db38c4fc3	COMPILATION_ERROR	0	\N	2026-06-19 05:19:15.181848+07	main.cpp: In function ‘int main()’:\nmain.cpp:8:18: error: expected ‘;’ before ‘return’\n    8 |     cout << a - b\n      |                  ^\n      |                  ;\n    9 |     return 0;\n      |     ~~~~~~        \n	\N	\N
8102	450	100	547c8a57-69ef-4b2a-9f0f-611ca9c6bed5	COMPILATION_ERROR	0	\N	2026-06-19 05:19:15.181853+07	main.cpp: In function ‘int main()’:\nmain.cpp:8:18: error: expected ‘;’ before ‘return’\n    8 |     cout << a - b\n      |                  ^\n      |                  ;\n    9 |     return 0;\n      |     ~~~~~~        \n	\N	\N
8947	460	25	33e37fd6-108c-4ccc-b2a9-7a059c0d6643	ACCEPTED	4	864	2026-06-21 02:01:32.405709+07	\N	\N	300
8078	450	76	ed743d74-0263-4d4f-9386-c5a5d7b34f8a	COMPILATION_ERROR	0	\N	2026-06-19 05:19:15.181836+07	main.cpp: In function ‘int main()’:\nmain.cpp:8:18: error: expected ‘;’ before ‘return’\n    8 |     cout << a - b\n      |                  ^\n      |                  ;\n    9 |     return 0;\n      |     ~~~~~~        \n	\N	\N
8065	450	63	5e60cabe-696b-40b6-9241-e6e756babc63	COMPILATION_ERROR	0	\N	2026-06-19 05:19:15.181813+07	main.cpp: In function ‘int main()’:\nmain.cpp:8:18: error: expected ‘;’ before ‘return’\n    8 |     cout << a - b\n      |                  ^\n      |                  ;\n    9 |     return 0;\n      |     ~~~~~~        \n	\N	\N
8092	450	90	e41bc234-e28f-4962-8e1f-4aa36dc1e9ab	COMPILATION_ERROR	0	\N	2026-06-19 05:19:15.181848+07	main.cpp: In function ‘int main()’:\nmain.cpp:8:18: error: expected ‘;’ before ‘return’\n    8 |     cout << a - b\n      |                  ^\n      |                  ;\n    9 |     return 0;\n      |     ~~~~~~        \n	\N	\N
8110	450	108	24bcd422-292b-4c48-b8ec-62ad5e3ac3a2	COMPILATION_ERROR	0	\N	2026-06-19 05:19:15.181857+07	main.cpp: In function ‘int main()’:\nmain.cpp:8:18: error: expected ‘;’ before ‘return’\n    8 |     cout << a - b\n      |                  ^\n      |                  ;\n    9 |     return 0;\n      |     ~~~~~~        \n	\N	\N
8158	451	38	3dfcc82b-5752-4311-80ef-970ec588142f	WRONG_ANSWER	1653	832	2026-06-19 05:20:01.847539+07	\N	\N	\N
8167	451	65	191872b5-b4cd-4145-9b0c-08c7e60b1e70	WRONG_ANSWER	1814	1092	2026-06-19 05:20:01.847548+07	\N	\N	\N
8271	452	69	d4d99c33-ab64-40f6-b40b-1d6b33afc5ed	WRONG_ANSWER	5	852	2026-06-19 05:21:05.756031+07	\N	\N	\N
8272	452	70	aece3a41-cb53-49b8-9575-0206d4a391ac	WRONG_ANSWER	5	1092	2026-06-19 05:21:05.756032+07	\N	\N	\N
8962	460	58	694b5f47-6358-4950-a23f-3ca61c4f0d69	ACCEPTED	5	1024	2026-06-21 02:01:32.405734+07	\N	\N	803799
8977	460	73	67ae11c4-388e-4098-bc4d-2d9fbec13e46	ACCEPTED	5	884	2026-06-21 02:01:32.405777+07	\N	\N	702179
9155	463	31	b2cc8bd1-1735-4ece-bf1b-bbdb3d0e4f95	ACCEPTED	4	1016	2026-06-21 02:02:18.789323+07	\N	\N	30000
9209	463	103	e9690ca2-5597-4890-a56c-d25ac58bbf27	ACCEPTED	5	872	2026-06-21 02:02:18.789364+07	\N	\N	283996
9217	463	111	a92a304c-bb00-4f78-b520-b6452b9bf1f6	ACCEPTED	4	864	2026-06-21 02:02:18.78937+07	\N	\N	-309452
9221	463	115	26b6c848-b312-4341-b241-065c233c14b8	ACCEPTED	5	1084	2026-06-21 02:02:18.789372+07	\N	\N	506806
9220	463	114	0876cac2-464c-4da9-8c75-cdd23507bcb0	ACCEPTED	5	892	2026-06-21 02:02:18.789371+07	\N	\N	-234796
9227	463	121	90f94043-8123-435b-8c88-44ad86747f48	ACCEPTED	6	1028	2026-06-21 02:02:18.789375+07	\N	\N	1259817393
9246	464	22	7cbdbb36-2072-4f0a-bacf-9f9a2645165c	ACCEPTED	6	1084	2026-06-21 02:47:49.626331+07	\N	\N	30
9249	464	25	b732f2ed-ebb7-438e-b473-de3babe6ed21	ACCEPTED	6	1016	2026-06-21 02:47:49.62634+07	\N	\N	300
9265	464	59	69076a84-14b0-4a88-985a-462615701ba2	ACCEPTED	5	1020	2026-06-21 02:47:49.626384+07	\N	\N	545178
9258	464	34	266fc60a-1794-4cc0-8f1d-22565da0ef85	ACCEPTED	5	1280	2026-06-21 02:47:49.626365+07	\N	\N	15
9251	464	27	8d74aa5f-099c-4854-bc14-435b45e40421	ACCEPTED	6	884	2026-06-21 02:47:49.626346+07	\N	\N	1000
9269	464	63	1f7ccf26-6448-43b1-a200-4b246e8b34b6	ACCEPTED	5	1084	2026-06-21 02:47:49.626394+07	\N	\N	1507378
9279	464	73	f312a26f-0309-4fdd-bb79-d825f7873a0b	ACCEPTED	5	1016	2026-06-21 02:47:49.626422+07	\N	\N	702179
9310	464	104	1bcf935e-7fff-407b-afe8-3bfcec2de5f1	ACCEPTED	5	880	2026-06-21 02:47:49.626515+07	\N	\N	514364
9315	464	109	098c541e-b8c4-4496-9b0d-e5ade2791b88	ACCEPTED	6	1032	2026-06-21 02:47:49.626529+07	\N	\N	792531
9313	464	107	d260745f-25eb-4386-884a-1c0f064e3519	ACCEPTED	6	1092	2026-06-21 02:47:49.626523+07	\N	\N	-34648
9311	464	105	c5226a1e-edf0-44ac-9443-48269abc4638	ACCEPTED	4	1032	2026-06-21 02:47:49.626517+07	\N	\N	-882565
9312	464	106	d5395573-29e4-4509-9d54-eedf9dc59dfe	ACCEPTED	6	980	2026-06-21 02:47:49.626521+07	\N	\N	-815576
9316	464	110	e6772e44-23a1-4570-84dc-d23f1476bfe0	ACCEPTED	5	856	2026-06-21 02:47:49.626532+07	\N	\N	-572819
9317	464	111	3577303b-3175-4f05-9459-9ad8bfa80f1c	ACCEPTED	4	1020	2026-06-21 02:47:49.626545+07	\N	\N	-309452
9321	464	115	07c711c2-9af3-40ea-97f9-2427297952cc	ACCEPTED	5	1008	2026-06-21 02:47:49.626556+07	\N	\N	506806
9320	464	114	5b84a839-7c38-4e0a-b5c3-adb15dab3dfc	ACCEPTED	5	1024	2026-06-21 02:47:49.626554+07	\N	\N	-234796
9319	464	113	b834f6b2-f846-4125-a88f-54b22ce204be	ACCEPTED	4	884	2026-06-21 02:47:49.62655+07	\N	\N	-1143916
9322	464	116	547f9a57-8d5e-434f-ae74-d4e3acc36e04	ACCEPTED	5	1016	2026-06-21 02:47:49.626559+07	\N	\N	785356
9332	464	126	c31f0c00-c327-44d1-86d0-44f4681b4b3c	ACCEPTED	4	1032	2026-06-21 02:47:49.626586+07	\N	\N	-882105735
9324	464	118	2d3432dc-6498-448a-92c3-2216d400173c	ACCEPTED	5	872	2026-06-21 02:47:49.626565+07	\N	\N	636465324
9325	464	119	9722d3a2-1cea-448f-a693-0c1aa260b609	ACCEPTED	5	1020	2026-06-21 02:47:49.626567+07	\N	\N	-738231997
9327	464	121	28303633-a679-4b07-aea1-6f206c05e4b0	ACCEPTED	5	1100	2026-06-21 02:47:49.626573+07	\N	\N	1259817393
9323	464	117	ebd45d00-259a-4346-9cfb-1059cbe8ba0f	ACCEPTED	5	860	2026-06-21 02:47:49.626562+07	\N	\N	362210245
9326	464	120	60ce2b6b-b5e4-4873-8e68-aa5850c8c0cb	ACCEPTED	5	860	2026-06-21 02:47:49.62657+07	\N	\N	371467497
9331	464	125	92b52945-ff36-4c17-bb59-882c596d3273	ACCEPTED	6	1020	2026-06-21 02:47:49.626583+07	\N	\N	86961293
9329	464	123	2801bed5-dc72-48d7-ab7e-2b17dd2ccab4	ACCEPTED	5	1076	2026-06-21 02:47:49.626578+07	\N	\N	1422690276
9335	464	129	1b1fb2d1-04c9-476f-857f-a2d03842848b	ACCEPTED	5	1020	2026-06-21 02:47:49.626597+07	\N	\N	-32
9328	464	122	7cf8c40f-8504-49db-83af-9e5b7dad7407	ACCEPTED	6	1040	2026-06-21 02:47:49.626575+07	\N	\N	-457820119
9338	464	132	9bf21b8a-44c2-468e-8c38-299837c76741	ACCEPTED	4	868	2026-06-21 02:47:49.626604+07	\N	\N	-1
9334	464	128	6963e8fd-7432-4121-9bef-6d2ed9cea813	ACCEPTED	5	1048	2026-06-21 02:47:49.626591+07	\N	\N	82
9336	464	130	2803cabd-166c-4dac-99df-e6c7e952c68a	ACCEPTED	4	996	2026-06-21 02:47:49.626599+07	\N	\N	-5
9337	464	131	a6def946-6b15-4b58-9ea8-f967f2d21021	ACCEPTED	5	952	2026-06-21 02:47:49.626602+07	\N	\N	71
9340	464	134	16ab9085-7845-4c5a-b4a2-486e4e1dd927	ACCEPTED	4	864	2026-06-21 02:47:49.626609+07	\N	\N	158
9342	464	136	da95ccac-544c-41cd-bd14-2cf2e132c06a	ACCEPTED	3	1056	2026-06-21 02:47:49.626614+07	\N	\N	129
9341	464	135	2e87e982-61f5-4724-ab0a-8b272b30ce5a	ACCEPTED	3	1056	2026-06-21 02:47:49.626612+07	\N	\N	3
9343	464	137	71bfa6d3-ceb0-43f9-a75e-c72c5c14a018	ACCEPTED	2	1196	2026-06-21 02:47:49.62662+07	\N	\N	64
8096	450	94	5640732e-e4a3-4924-9107-856f37348a53	COMPILATION_ERROR	0	\N	2026-06-19 05:19:15.18185+07	main.cpp: In function ‘int main()’:\nmain.cpp:8:18: error: expected ‘;’ before ‘return’\n    8 |     cout << a - b\n      |                  ^\n      |                  ;\n    9 |     return 0;\n      |     ~~~~~~        \n	\N	\N
8103	450	101	064a191a-da77-418d-a939-f4ef801ab6e4	COMPILATION_ERROR	0	\N	2026-06-19 05:19:15.181854+07	main.cpp: In function ‘int main()’:\nmain.cpp:8:18: error: expected ‘;’ before ‘return’\n    8 |     cout << a - b\n      |                  ^\n      |                  ;\n    9 |     return 0;\n      |     ~~~~~~        \n	\N	\N
8101	450	99	2ccba557-1e92-44e5-82c0-df6c1bb9a330	COMPILATION_ERROR	0	\N	2026-06-19 05:19:15.181853+07	main.cpp: In function ‘int main()’:\nmain.cpp:8:18: error: expected ‘;’ before ‘return’\n    8 |     cout << a - b\n      |                  ^\n      |                  ;\n    9 |     return 0;\n      |     ~~~~~~        \n	\N	\N
8095	450	93	44981193-deb4-43bc-bcc3-40f22cb134f8	COMPILATION_ERROR	0	\N	2026-06-19 05:19:15.18185+07	main.cpp: In function ‘int main()’:\nmain.cpp:8:18: error: expected ‘;’ before ‘return’\n    8 |     cout << a - b\n      |                  ^\n      |                  ;\n    9 |     return 0;\n      |     ~~~~~~        \n	\N	\N
8100	450	98	cc9d044e-1ecc-4825-9fae-4e69bf328985	COMPILATION_ERROR	0	\N	2026-06-19 05:19:15.181852+07	main.cpp: In function ‘int main()’:\nmain.cpp:8:18: error: expected ‘;’ before ‘return’\n    8 |     cout << a - b\n      |                  ^\n      |                  ;\n    9 |     return 0;\n      |     ~~~~~~        \n	\N	\N
8106	450	104	5fbe5526-b011-4164-9935-782a3484efdb	COMPILATION_ERROR	0	\N	2026-06-19 05:19:15.181855+07	main.cpp: In function ‘int main()’:\nmain.cpp:8:18: error: expected ‘;’ before ‘return’\n    8 |     cout << a - b\n      |                  ^\n      |                  ;\n    9 |     return 0;\n      |     ~~~~~~        \n	\N	\N
8104	450	102	ca54fc6f-d2a8-4d37-80bd-fad0c13d6cb6	COMPILATION_ERROR	0	\N	2026-06-19 05:19:15.181854+07	main.cpp: In function ‘int main()’:\nmain.cpp:8:18: error: expected ‘;’ before ‘return’\n    8 |     cout << a - b\n      |                  ^\n      |                  ;\n    9 |     return 0;\n      |     ~~~~~~        \n	\N	\N
8107	450	105	c2b647ed-2808-4f1b-8a50-0afdd5e9dd91	COMPILATION_ERROR	0	\N	2026-06-19 05:19:15.181855+07	main.cpp: In function ‘int main()’:\nmain.cpp:8:18: error: expected ‘;’ before ‘return’\n    8 |     cout << a - b\n      |                  ^\n      |                  ;\n    9 |     return 0;\n      |     ~~~~~~        \n	\N	\N
8112	450	110	eccfe09a-cc40-41a9-a662-8679d5f525bd	COMPILATION_ERROR	0	\N	2026-06-19 05:19:15.181858+07	main.cpp: In function ‘int main()’:\nmain.cpp:8:18: error: expected ‘;’ before ‘return’\n    8 |     cout << a - b\n      |                  ^\n      |                  ;\n    9 |     return 0;\n      |     ~~~~~~        \n	\N	\N
8108	450	106	0649d087-a3aa-4070-93c6-70218833b9ff	COMPILATION_ERROR	0	\N	2026-06-19 05:19:15.181856+07	main.cpp: In function ‘int main()’:\nmain.cpp:8:18: error: expected ‘;’ before ‘return’\n    8 |     cout << a - b\n      |                  ^\n      |                  ;\n    9 |     return 0;\n      |     ~~~~~~        \n	\N	\N
8111	450	109	9c36bce3-da45-4c90-b2ba-3018b5b4287f	COMPILATION_ERROR	0	\N	2026-06-19 05:19:15.181857+07	main.cpp: In function ‘int main()’:\nmain.cpp:8:18: error: expected ‘;’ before ‘return’\n    8 |     cout << a - b\n      |                  ^\n      |                  ;\n    9 |     return 0;\n      |     ~~~~~~        \n	\N	\N
8113	450	111	199f339e-0bdb-4ab0-b265-f9903ac9091c	COMPILATION_ERROR	0	\N	2026-06-19 05:19:15.181858+07	main.cpp: In function ‘int main()’:\nmain.cpp:8:18: error: expected ‘;’ before ‘return’\n    8 |     cout << a - b\n      |                  ^\n      |                  ;\n    9 |     return 0;\n      |     ~~~~~~        \n	\N	\N
8117	450	115	f8bd87c5-c340-4775-9543-dc1f34baad54	COMPILATION_ERROR	0	\N	2026-06-19 05:19:15.18186+07	main.cpp: In function ‘int main()’:\nmain.cpp:8:18: error: expected ‘;’ before ‘return’\n    8 |     cout << a - b\n      |                  ^\n      |                  ;\n    9 |     return 0;\n      |     ~~~~~~        \n	\N	\N
8120	450	118	6106ab4f-3895-441a-b55f-c778f73a0930	COMPILATION_ERROR	0	\N	2026-06-19 05:19:15.181862+07	main.cpp: In function ‘int main()’:\nmain.cpp:8:18: error: expected ‘;’ before ‘return’\n    8 |     cout << a - b\n      |                  ^\n      |                  ;\n    9 |     return 0;\n      |     ~~~~~~        \n	\N	\N
8124	450	122	9e820c2c-6d1c-459c-97cf-7ac6703f4457	COMPILATION_ERROR	0	\N	2026-06-19 05:19:15.181864+07	main.cpp: In function ‘int main()’:\nmain.cpp:8:18: error: expected ‘;’ before ‘return’\n    8 |     cout << a - b\n      |                  ^\n      |                  ;\n    9 |     return 0;\n      |     ~~~~~~        \n	\N	\N
8115	450	113	00ba7e01-2acd-4b2d-8391-e704047b8f9a	COMPILATION_ERROR	0	\N	2026-06-19 05:19:15.181859+07	main.cpp: In function ‘int main()’:\nmain.cpp:8:18: error: expected ‘;’ before ‘return’\n    8 |     cout << a - b\n      |                  ^\n      |                  ;\n    9 |     return 0;\n      |     ~~~~~~        \n	\N	\N
8129	450	127	4f6fbbbe-358b-4252-aa8c-96efa243aac8	COMPILATION_ERROR	0	\N	2026-06-19 05:19:15.181866+07	main.cpp: In function ‘int main()’:\nmain.cpp:8:18: error: expected ‘;’ before ‘return’\n    8 |     cout << a - b\n      |                  ^\n      |                  ;\n    9 |     return 0;\n      |     ~~~~~~        \n	\N	\N
8125	450	123	b20b7e06-74f4-4670-b7f2-4aa36dd04a73	COMPILATION_ERROR	0	\N	2026-06-19 05:19:15.181864+07	main.cpp: In function ‘int main()’:\nmain.cpp:8:18: error: expected ‘;’ before ‘return’\n    8 |     cout << a - b\n      |                  ^\n      |                  ;\n    9 |     return 0;\n      |     ~~~~~~        \n	\N	\N
8122	450	120	ab488c79-71f4-4393-b786-150c6078ea4f	COMPILATION_ERROR	0	\N	2026-06-19 05:19:15.181863+07	main.cpp: In function ‘int main()’:\nmain.cpp:8:18: error: expected ‘;’ before ‘return’\n    8 |     cout << a - b\n      |                  ^\n      |                  ;\n    9 |     return 0;\n      |     ~~~~~~        \n	\N	\N
8126	450	124	ba5b0fc9-8a00-45c9-8e57-90446da2c176	COMPILATION_ERROR	0	\N	2026-06-19 05:19:15.181865+07	main.cpp: In function ‘int main()’:\nmain.cpp:8:18: error: expected ‘;’ before ‘return’\n    8 |     cout << a - b\n      |                  ^\n      |                  ;\n    9 |     return 0;\n      |     ~~~~~~        \n	\N	\N
8121	450	119	480c2c1e-c67a-4f20-9a4f-cb0aa51412c1	COMPILATION_ERROR	0	\N	2026-06-19 05:19:15.181862+07	main.cpp: In function ‘int main()’:\nmain.cpp:8:18: error: expected ‘;’ before ‘return’\n    8 |     cout << a - b\n      |                  ^\n      |                  ;\n    9 |     return 0;\n      |     ~~~~~~        \n	\N	\N
8123	450	121	9d830293-d072-476a-af23-1f42bdb3732d	COMPILATION_ERROR	0	\N	2026-06-19 05:19:15.181863+07	main.cpp: In function ‘int main()’:\nmain.cpp:8:18: error: expected ‘;’ before ‘return’\n    8 |     cout << a - b\n      |                  ^\n      |                  ;\n    9 |     return 0;\n      |     ~~~~~~        \n	\N	\N
8134	450	132	1a6552cf-fa61-45c5-97c0-b90d1707bc93	COMPILATION_ERROR	0	\N	2026-06-19 05:19:15.181869+07	main.cpp: In function ‘int main()’:\nmain.cpp:8:18: error: expected ‘;’ before ‘return’\n    8 |     cout << a - b\n      |                  ^\n      |                  ;\n    9 |     return 0;\n      |     ~~~~~~        \n	\N	\N
8968	460	64	875dc432-f308-453a-825a-43be983273f1	ACCEPTED	5	932	2026-06-21 02:01:32.405744+07	\N	\N	710339
8128	450	126	f90d9a42-fbd6-4a6c-827d-30e971eea0fb	COMPILATION_ERROR	0	\N	2026-06-19 05:19:15.181866+07	main.cpp: In function ‘int main()’:\nmain.cpp:8:18: error: expected ‘;’ before ‘return’\n    8 |     cout << a - b\n      |                  ^\n      |                  ;\n    9 |     return 0;\n      |     ~~~~~~        \n	\N	\N
8132	450	130	e24530c0-80eb-464e-bf7d-2431cda76954	COMPILATION_ERROR	0	\N	2026-06-19 05:19:15.181868+07	main.cpp: In function ‘int main()’:\nmain.cpp:8:18: error: expected ‘;’ before ‘return’\n    8 |     cout << a - b\n      |                  ^\n      |                  ;\n    9 |     return 0;\n      |     ~~~~~~        \n	\N	\N
8131	450	129	0f979f94-8852-4783-ab77-2026c4651443	COMPILATION_ERROR	0	\N	2026-06-19 05:19:15.181867+07	main.cpp: In function ‘int main()’:\nmain.cpp:8:18: error: expected ‘;’ before ‘return’\n    8 |     cout << a - b\n      |                  ^\n      |                  ;\n    9 |     return 0;\n      |     ~~~~~~        \n	\N	\N
8135	450	133	88f8319a-c302-4ba5-88f4-f11228975c4a	COMPILATION_ERROR	0	\N	2026-06-19 05:19:15.18187+07	main.cpp: In function ‘int main()’:\nmain.cpp:8:18: error: expected ‘;’ before ‘return’\n    8 |     cout << a - b\n      |                  ^\n      |                  ;\n    9 |     return 0;\n      |     ~~~~~~        \n	\N	\N
8137	450	135	b64bdc7b-6d46-4075-856a-0da411a57805	COMPILATION_ERROR	0	\N	2026-06-19 05:19:15.181871+07	main.cpp: In function ‘int main()’:\nmain.cpp:8:18: error: expected ‘;’ before ‘return’\n    8 |     cout << a - b\n      |                  ^\n      |                  ;\n    9 |     return 0;\n      |     ~~~~~~        \n	\N	\N
8139	450	137	48e372b1-face-47d5-b974-82b8b6b8e8b7	COMPILATION_ERROR	0	\N	2026-06-19 05:19:15.181872+07	main.cpp: In function ‘int main()’:\nmain.cpp:8:18: error: expected ‘;’ before ‘return’\n    8 |     cout << a - b\n      |                  ^\n      |                  ;\n    9 |     return 0;\n      |     ~~~~~~        \n	\N	\N
8140	450	138	df4a4c11-1618-4584-bf21-424ea5e07b4d	COMPILATION_ERROR	0	\N	2026-06-19 05:19:15.181872+07	main.cpp: In function ‘int main()’:\nmain.cpp:8:18: error: expected ‘;’ before ‘return’\n    8 |     cout << a - b\n      |                  ^\n      |                  ;\n    9 |     return 0;\n      |     ~~~~~~        \n	\N	\N
8995	460	91	cac5883c-8a14-4f4d-b96b-c85e666afcc5	ACCEPTED	4	972	2026-06-21 02:01:32.405806+07	\N	\N	-1113725
8142	451	22	8c3fd5a7-7b4a-4e2c-ae8a-0dd6b3c5df6b	WRONG_ANSWER	1711	880	2026-06-19 05:20:01.847521+07	\N	\N	\N
8143	451	23	f11e3b20-8748-4899-a4fc-282f02eac54b	WRONG_ANSWER	1695	1016	2026-06-19 05:20:01.847526+07	\N	\N	\N
8153	451	33	a7700df1-5caf-4863-a00f-8cface752d02	WRONG_ANSWER	1708	988	2026-06-19 05:20:01.847534+07	\N	\N	\N
8146	451	26	03e845c3-ba90-496f-a49c-fa5b01bac89f	TIME_LIMIT_EXCEEDED	2019	1084	2026-06-19 05:20:01.847528+07	\N	\N	\N
8145	451	25	ccdd8279-384d-40fb-b17e-bcb92efff4b7	WRONG_ANSWER	1688	940	2026-06-19 05:20:01.847528+07	\N	\N	\N
8147	451	27	39e3eddc-f465-4192-a369-2aed2712545b	WRONG_ANSWER	1773	1104	2026-06-19 05:20:01.847529+07	\N	\N	\N
8160	451	58	e408555b-b306-47cc-ae38-1752d52bada6	TIME_LIMIT_EXCEEDED	2074	1108	2026-06-19 05:20:01.847541+07	\N	\N	\N
8155	451	35	a85ee3c0-12e8-4ac7-9d02-0e4843b6a497	WRONG_ANSWER	1930	1024	2026-06-19 05:20:01.847536+07	\N	\N	\N
8157	451	37	2f118ed7-ca93-455e-952d-a54a551a0db6	WRONG_ANSWER	1701	1028	2026-06-19 05:20:01.847538+07	\N	\N	\N
8148	451	28	23aa45d3-4090-4704-bdce-629a11f97981	TIME_LIMIT_EXCEEDED	2068	1092	2026-06-19 05:20:01.84753+07	\N	\N	\N
8144	451	24	06dab43d-d697-414e-b6df-7c69bfccb31a	WRONG_ANSWER	1960	864	2026-06-19 05:20:01.847526+07	\N	\N	\N
8162	451	60	38ce6674-60b2-4f07-8251-d96488bf2159	WRONG_ANSWER	1972	1096	2026-06-19 05:20:01.847543+07	\N	\N	\N
8156	451	36	6e59c5ec-ac14-4df8-a5fb-e04ad6b09bb9	WRONG_ANSWER	1982	1264	2026-06-19 05:20:01.847537+07	\N	\N	\N
8150	451	30	8287142e-b3ab-4d94-9757-f982ae7bf7a2	WRONG_ANSWER	1711	1068	2026-06-19 05:20:01.847532+07	\N	\N	\N
8159	451	57	f329b042-cb45-4069-807c-2d1a0c591997	WRONG_ANSWER	1709	1024	2026-06-19 05:20:01.84754+07	\N	\N	\N
8141	451	21	659c32a3-57e1-4861-abab-0750a0153c66	WRONG_ANSWER	1684	1028	2026-06-19 05:20:01.847507+07	\N	\N	\N
8154	451	34	49ac99b0-6bf8-471a-91a1-c899a0834d41	WRONG_ANSWER	1697	880	2026-06-19 05:20:01.847535+07	\N	\N	\N
8161	451	59	1d119fec-04f4-4c57-84f7-2c2bd32c61c8	TIME_LIMIT_EXCEEDED	2036	1028	2026-06-19 05:20:01.847542+07	\N	\N	\N
8152	451	32	02bed3bf-c16f-4afd-9a29-d7e1092f7168	WRONG_ANSWER	1651	1272	2026-06-19 05:20:01.847534+07	\N	\N	\N
8164	451	62	1412044f-990b-46fd-9d71-7f9857f998e6	WRONG_ANSWER	1711	1016	2026-06-19 05:20:01.847546+07	\N	\N	\N
8151	451	31	759fc414-e834-4c76-93e7-ab2e0bc10351	WRONG_ANSWER	1867	1312	2026-06-19 05:20:01.847533+07	\N	\N	\N
8166	451	64	da2b1e4b-80c2-402f-a46a-e6143d016354	WRONG_ANSWER	1728	1084	2026-06-19 05:20:01.847547+07	\N	\N	\N
8165	451	63	33f2a196-f0f9-48d0-aa2f-8c10bf4149b2	WRONG_ANSWER	1708	1100	2026-06-19 05:20:01.847546+07	\N	\N	\N
8177	451	75	39880150-2d60-4fa7-8261-ff411a8ff7c8	WRONG_ANSWER	1672	1036	2026-06-19 05:20:01.847557+07	\N	\N	\N
8175	451	73	7301f169-3c58-4343-b6ff-e8f174589723	WRONG_ANSWER	1679	1036	2026-06-19 05:20:01.847555+07	\N	\N	\N
8183	451	81	ec09ce0a-b322-4182-ab6b-f43d09236bd9	WRONG_ANSWER	1727	864	2026-06-19 05:20:01.847562+07	\N	\N	\N
8182	451	80	5a4d3acf-4412-4aa3-9965-0a73f731426f	WRONG_ANSWER	1663	840	2026-06-19 05:20:01.847561+07	\N	\N	\N
8186	451	84	e1a145ac-a59d-4c4c-8e03-c4dfcb99cd11	WRONG_ANSWER	1701	1256	2026-06-19 05:20:01.847565+07	\N	\N	\N
8168	451	66	7bb497c7-3896-40f3-8a8d-526fb941a34f	WRONG_ANSWER	1682	1056	2026-06-19 05:20:01.847549+07	\N	\N	\N
8169	451	67	a857a4e9-310f-436d-be99-5c34a3e70c84	WRONG_ANSWER	1628	980	2026-06-19 05:20:01.84755+07	\N	\N	\N
8178	451	76	8f284ab0-6269-4969-8854-ccef3cfe6ea6	WRONG_ANSWER	1673	980	2026-06-19 05:20:01.847558+07	\N	\N	\N
8181	451	79	50d61458-8ec9-40a2-9dbe-a77dca3d62f6	WRONG_ANSWER	1867	1012	2026-06-19 05:20:01.84756+07	\N	\N	\N
8179	451	77	a9858847-59f3-44b2-a19e-4ad7c1b70c68	WRONG_ANSWER	1620	1028	2026-06-19 05:20:01.847559+07	\N	\N	\N
8176	451	74	f34e4b64-6cf7-43c3-9d40-b330a077bae1	WRONG_ANSWER	1616	1092	2026-06-19 05:20:01.847556+07	\N	\N	\N
8185	451	83	c74f6b8b-113f-4240-a7c3-3b494a13c1cc	WRONG_ANSWER	1937	1032	2026-06-19 05:20:01.847564+07	\N	\N	\N
8172	451	70	024c6817-4e1d-4bc3-bcea-78d1808fe2dd	WRONG_ANSWER	1718	1020	2026-06-19 05:20:01.847552+07	\N	\N	\N
8184	451	82	4d3cd46c-7c1e-4079-a16b-e0734f30cf01	WRONG_ANSWER	1624	1268	2026-06-19 05:20:01.847563+07	\N	\N	\N
8187	451	85	29858b03-e720-49b3-8a15-083b6ed287ac	WRONG_ANSWER	1621	1076	2026-06-19 05:20:01.847566+07	\N	\N	\N
8173	451	71	29ad3f0d-f191-4925-a56d-c3b3b209cbc9	WRONG_ANSWER	1727	1072	2026-06-19 05:20:01.847553+07	\N	\N	\N
8170	451	68	9e8a6374-8f39-4d77-a5cc-7fb91b42b08c	TIME_LIMIT_EXCEEDED	2017	1220	2026-06-19 05:20:01.847551+07	\N	\N	\N
8174	451	72	c9293af6-4d9f-4361-b541-ba19efa57af4	TIME_LIMIT_EXCEEDED	2027	1096	2026-06-19 05:20:01.847554+07	\N	\N	\N
8188	451	86	99b803e4-39bd-4ac2-b30d-2ea08b50ca44	WRONG_ANSWER	1791	1072	2026-06-19 05:20:01.847567+07	\N	\N	\N
8189	451	87	813cb4b3-4a74-469e-9fb0-918f6c580f10	WRONG_ANSWER	1747	1020	2026-06-19 05:20:01.847567+07	\N	\N	\N
8149	451	29	16b225b8-27a8-4455-9b64-14062fb4d401	TIME_LIMIT_EXCEEDED	2069	1020	2026-06-19 05:20:01.847531+07	\N	\N	\N
8163	451	61	66355c00-a11a-42c1-9cf5-143bdbe79792	WRONG_ANSWER	1756	1104	2026-06-19 05:20:01.847544+07	\N	\N	\N
8171	451	69	9d494736-fe3d-49a5-aba2-d2d70132e91a	WRONG_ANSWER	1639	1092	2026-06-19 05:20:01.847551+07	\N	\N	\N
8180	451	78	33d7f86c-4d6e-438a-b092-669f19ed173d	WRONG_ANSWER	1831	1028	2026-06-19 05:20:01.84756+07	\N	\N	\N
8193	451	91	34a40026-3014-47d3-920b-05ec4bd996e7	TIME_LIMIT_EXCEEDED	2020	872	2026-06-19 05:20:01.847572+07	\N	\N	\N
8192	451	90	fb9e3bb2-8543-4936-8e99-0877da7b4b90	WRONG_ANSWER	1670	1016	2026-06-19 05:20:01.847571+07	\N	\N	\N
8196	451	94	3bd651eb-3176-4260-896f-258b4c29a0bb	WRONG_ANSWER	1659	908	2026-06-19 05:20:01.847575+07	\N	\N	\N
8197	451	95	bb6967e4-2d4f-4c5d-b16d-bf9341cdcdd2	TIME_LIMIT_EXCEEDED	2073	980	2026-06-19 05:20:01.847576+07	\N	\N	\N
8200	451	98	3e86e777-2781-4cfc-a9c5-d07c10a97d97	WRONG_ANSWER	1691	840	2026-06-19 05:20:01.847579+07	\N	\N	\N
8195	451	93	c9bfc161-8808-458d-ac91-b893fed80002	WRONG_ANSWER	1716	872	2026-06-19 05:20:01.847574+07	\N	\N	\N
8205	451	103	337eefd0-c40d-44da-aab3-1cab71ba4c8d	WRONG_ANSWER	1773	1284	2026-06-19 05:20:01.847583+07	\N	\N	\N
8204	451	102	f3376f72-0b1f-46d5-9c78-7c28e709bc73	WRONG_ANSWER	1873	1052	2026-06-19 05:20:01.847582+07	\N	\N	\N
8208	451	106	48ae3c74-fd10-48c6-a5bb-f79431a5efc1	WRONG_ANSWER	1693	1120	2026-06-19 05:20:01.847585+07	\N	\N	\N
8201	451	99	e61a54f0-a920-4b3c-9c0c-b627bd9d18b0	TIME_LIMIT_EXCEEDED	2024	880	2026-06-19 05:20:01.847579+07	\N	\N	\N
8198	451	96	ff9d10a0-11d8-4503-ad49-a36cbbc19458	WRONG_ANSWER	1713	864	2026-06-19 05:20:01.847576+07	\N	\N	\N
8206	451	104	39bbdb83-2e07-4f78-8743-bfdede542b5d	WRONG_ANSWER	1886	864	2026-06-19 05:20:01.847584+07	\N	\N	\N
8203	451	101	ca00d5fb-a082-41dc-90d9-916d346bcfd7	WRONG_ANSWER	1828	908	2026-06-19 05:20:01.847581+07	\N	\N	\N
8199	451	97	928bdf76-7ed7-441a-8097-0d9fd1f4336f	WRONG_ANSWER	1712	828	2026-06-19 05:20:01.847577+07	\N	\N	\N
8194	451	92	986d64d9-7abf-4053-97fa-49b24e35385a	WRONG_ANSWER	1946	1032	2026-06-19 05:20:01.847573+07	\N	\N	\N
8210	451	108	ce2f1b0d-454a-43b6-b850-b1f40ff51b24	WRONG_ANSWER	1939	1216	2026-06-19 05:20:01.847587+07	\N	\N	\N
8207	451	105	12024f5e-f1fc-40b0-9bda-10d9d99d6019	WRONG_ANSWER	1947	1064	2026-06-19 05:20:01.847584+07	\N	\N	\N
8202	451	100	9ec5f958-aef2-46cf-86b8-0e9fb8bcc0e7	WRONG_ANSWER	1965	1032	2026-06-19 05:20:01.84758+07	\N	\N	\N
8211	451	109	15d1462c-0628-4aae-899a-e6657387d56f	WRONG_ANSWER	1778	1084	2026-06-19 05:20:01.847588+07	\N	\N	\N
8209	451	107	4d225be1-1763-4b2e-b05e-3ed852318f87	TIME_LIMIT_EXCEEDED	2009	876	2026-06-19 05:20:01.847586+07	\N	\N	\N
8212	451	110	456e3342-b4fc-4471-9bb2-13cfdb2c4b18	WRONG_ANSWER	1930	1068	2026-06-19 05:20:01.847589+07	\N	\N	\N
8213	451	111	6ca38622-7fc3-4b3c-b5fd-327d8c92d50b	WRONG_ANSWER	1756	1268	2026-06-19 05:20:01.84759+07	\N	\N	\N
8214	451	112	33619c30-8440-4771-9c41-c76c729de1c2	WRONG_ANSWER	1784	1072	2026-06-19 05:20:01.84759+07	\N	\N	\N
8216	451	114	c7a002bf-3f44-4ed2-8511-be76dd5981b9	TIME_LIMIT_EXCEEDED	2041	984	2026-06-19 05:20:01.847593+07	\N	\N	\N
8220	451	118	ac09b8e0-3d76-4a81-ab82-7f5925d24bf2	WRONG_ANSWER	1886	1096	2026-06-19 05:20:01.847596+07	\N	\N	\N
8230	451	128	a891de3c-49cb-4ed7-80a4-92bf459ecbec	WRONG_ANSWER	1772	1024	2026-06-19 05:20:01.847606+07	\N	\N	\N
8219	451	117	fdf889b5-f81b-47b3-859f-ed9adadc1d57	WRONG_ANSWER	1817	1032	2026-06-19 05:20:01.847596+07	\N	\N	\N
8226	451	124	c59e1e3a-deeb-446f-98b3-29b734a96fb2	WRONG_ANSWER	1771	1084	2026-06-19 05:20:01.847602+07	\N	\N	\N
8215	451	113	f1b09568-3900-4076-975a-893ab497d742	TIME_LIMIT_EXCEEDED	2029	916	2026-06-19 05:20:01.847592+07	\N	\N	\N
8227	451	125	d21265f4-94d2-4e71-ae2d-aa7ce5a2f0b5	WRONG_ANSWER	1760	1092	2026-06-19 05:20:01.847603+07	\N	\N	\N
8222	451	120	775305d6-0800-492c-aaf6-5ab172ced479	TIME_LIMIT_EXCEEDED	2031	876	2026-06-19 05:20:01.847598+07	\N	\N	\N
8221	451	119	0c40b3f5-a116-421d-b66c-ce70cd313984	TIME_LIMIT_EXCEEDED	2021	1092	2026-06-19 05:20:01.847597+07	\N	\N	\N
8218	451	116	e3783469-56f3-47ec-a521-7af392f1a0ea	WRONG_ANSWER	1952	1024	2026-06-19 05:20:01.847595+07	\N	\N	\N
8217	451	115	61c44314-3f08-4916-90a0-06358208d0f3	WRONG_ANSWER	1933	868	2026-06-19 05:20:01.847594+07	\N	\N	\N
8223	451	121	636becc0-0422-4888-833b-46455683b7c4	WRONG_ANSWER	1766	804	2026-06-19 05:20:01.847599+07	\N	\N	\N
8235	451	133	21e7b8ad-1bfd-42cb-a9be-da6b6eca26e7	WRONG_ANSWER	1883	1324	2026-06-19 05:20:01.847611+07	\N	\N	\N
8225	451	123	93f3e7c4-0ee4-4d87-932d-cafc626c82f0	TIME_LIMIT_EXCEEDED	2070	1036	2026-06-19 05:20:01.847601+07	\N	\N	\N
8229	451	127	b44c29d4-3254-4d24-9f9d-a7cb2ddbb381	WRONG_ANSWER	1961	832	2026-06-19 05:20:01.847605+07	\N	\N	\N
8232	451	130	b65c651e-f237-41cd-aa90-0728a8e8a69c	WRONG_ANSWER	1724	1296	2026-06-19 05:20:01.847608+07	\N	\N	\N
8228	451	126	d674da80-c780-4240-89c7-67cb2a99fd8c	WRONG_ANSWER	1846	1020	2026-06-19 05:20:01.847604+07	\N	\N	\N
8224	451	122	df81cb80-b4aa-4bcd-a393-7df0e857614d	WRONG_ANSWER	1894	1020	2026-06-19 05:20:01.8476+07	\N	\N	\N
8231	451	129	a0e93830-c149-4b6c-aa24-bd744b72dee2	WRONG_ANSWER	1876	872	2026-06-19 05:20:01.847607+07	\N	\N	\N
8236	451	134	34b3c5e9-912b-4c24-ae73-2b067b81bbe9	WRONG_ANSWER	1783	1064	2026-06-19 05:20:01.847612+07	\N	\N	\N
8234	451	132	4a9e122f-b2d3-43fd-9aaf-22cc7179dc8a	WRONG_ANSWER	1698	856	2026-06-19 05:20:01.84761+07	\N	\N	\N
8233	451	131	ed0b7cec-bc3b-4792-bc42-66cf0c4706ed	WRONG_ANSWER	1878	1088	2026-06-19 05:20:01.847609+07	\N	\N	\N
8237	451	135	b4f0ba80-2c00-49d0-b559-cf56c5f0f6ce	WRONG_ANSWER	1366	988	2026-06-19 05:20:01.847613+07	\N	\N	\N
8238	451	136	37ca4102-d744-48d9-bb9a-30fe3a09ba26	WRONG_ANSWER	1436	968	2026-06-19 05:20:01.847614+07	\N	\N	\N
8239	451	137	67629315-31bb-4881-b7cf-185aab388663	WRONG_ANSWER	1317	1056	2026-06-19 05:20:01.847615+07	\N	\N	\N
8240	451	138	ebbfb7ef-afc4-4f1c-9000-abac069ce45b	WRONG_ANSWER	989	1052	2026-06-19 05:20:01.847615+07	\N	\N	\N
8242	452	22	9b0db7e0-1a99-4802-90d7-6d3556d92b15	WRONG_ANSWER	8	1028	2026-06-19 05:21:05.755999+07	\N	\N	\N
8249	452	29	831dc15c-8483-44bc-a7cb-4e120013addf	WRONG_ANSWER	6	1016	2026-06-19 05:21:05.756011+07	\N	\N	\N
8245	452	25	c85d1233-cdaf-4566-833b-11f8a960e6bf	WRONG_ANSWER	5	1028	2026-06-19 05:21:05.756007+07	\N	\N	\N
8247	452	27	3fe986e8-58b5-4929-acbe-89561d47c4cd	WRONG_ANSWER	11	1088	2026-06-19 05:21:05.756009+07	\N	\N	\N
8244	452	24	67123213-8f12-486f-aa1d-c7851bf46d2e	WRONG_ANSWER	6	880	2026-06-19 05:21:05.756006+07	\N	\N	\N
8252	452	32	bb44adc2-af94-456f-b7a3-f1504c53eb67	WRONG_ANSWER	5	1088	2026-06-19 05:21:05.756014+07	\N	\N	\N
8250	452	30	4789f439-4ae4-4e8d-b032-0eaea2519a45	WRONG_ANSWER	8	832	2026-06-19 05:21:05.756012+07	\N	\N	\N
8251	452	31	ee826fb1-c1a4-4e7d-ba9c-ea10962b85bc	WRONG_ANSWER	5	1016	2026-06-19 05:21:05.756013+07	\N	\N	\N
8248	452	28	b2c4f923-054a-42d6-9ee8-44df22108ec4	WRONG_ANSWER	12	980	2026-06-19 05:21:05.75601+07	\N	\N	\N
8241	452	21	770c429c-730b-46bb-a4f4-c05daeca20d9	WRONG_ANSWER	6	1008	2026-06-19 05:21:05.755984+07	\N	\N	\N
9022	460	118	3ccf4b8f-08ab-4096-a407-de0be70b20b1	ACCEPTED	5	864	2026-06-21 02:01:32.405862+07	\N	\N	636465324
8259	452	57	341dd080-66e1-438c-bba4-12995a0cae14	WRONG_ANSWER	10	1004	2026-06-19 05:21:05.75602+07	\N	\N	\N
8258	452	38	7ec08f71-7f0d-4831-8908-4c619ebf96fe	WRONG_ANSWER	6	864	2026-06-19 05:21:05.756019+07	\N	\N	\N
8264	452	62	44182c46-cf25-4aae-bfbc-a2f603320014	WRONG_ANSWER	5	1084	2026-06-19 05:21:05.756025+07	\N	\N	\N
8256	452	36	e54f42f7-7b29-479a-99b0-d109cf4f060e	WRONG_ANSWER	6	856	2026-06-19 05:21:05.756017+07	\N	\N	\N
8262	452	60	02e659e3-a751-42a8-a008-cde7aeb00f8c	WRONG_ANSWER	6	860	2026-06-19 05:21:05.756023+07	\N	\N	\N
8255	452	35	fbe582d7-fcc9-4e74-be87-c0cc7668311a	WRONG_ANSWER	5	1016	2026-06-19 05:21:05.756016+07	\N	\N	\N
8254	452	34	267187e6-e5b8-4bc6-a9dc-d44024394a21	WRONG_ANSWER	4	1024	2026-06-19 05:21:05.756016+07	\N	\N	\N
8260	452	58	31c3c03e-d07b-44c6-919b-c6aed4ad1cb1	WRONG_ANSWER	8	864	2026-06-19 05:21:05.756021+07	\N	\N	\N
8257	452	37	e9a96021-b661-4267-acbc-268604804827	WRONG_ANSWER	5	1004	2026-06-19 05:21:05.756018+07	\N	\N	\N
8261	452	59	22357331-11cf-44e0-bfa4-649af7bdb20d	WRONG_ANSWER	13	868	2026-06-19 05:21:05.756022+07	\N	\N	\N
8265	452	63	ae482080-8608-4eab-b153-a2f688c53a70	WRONG_ANSWER	6	1012	2026-06-19 05:21:05.756026+07	\N	\N	\N
8267	452	65	b7332fa5-c2db-4de9-8e83-163313b587a3	WRONG_ANSWER	4	836	2026-06-19 05:21:05.756027+07	\N	\N	\N
8268	452	66	febbfa55-1f5f-4871-89cd-b2ae388bb29e	WRONG_ANSWER	5	1028	2026-06-19 05:21:05.756028+07	\N	\N	\N
8270	452	68	3e14ce18-766a-492b-ab3d-144343840fc7	WRONG_ANSWER	5	868	2026-06-19 05:21:05.75603+07	\N	\N	\N
8266	452	64	b8758daa-6818-4777-9890-ac0cda0f8b64	WRONG_ANSWER	12	976	2026-06-19 05:21:05.756027+07	\N	\N	\N
8275	452	73	a21dd16c-b26c-4032-8841-c9f30514e42a	WRONG_ANSWER	5	896	2026-06-19 05:21:05.756035+07	\N	\N	\N
8282	452	80	eabb6d02-53cf-4835-8da8-161468906c95	WRONG_ANSWER	5	1092	2026-06-19 05:21:05.756041+07	\N	\N	\N
8285	452	83	ade4c7eb-80ce-4960-866e-645cfcac692b	WRONG_ANSWER	7	1040	2026-06-19 05:21:05.756043+07	\N	\N	\N
8284	452	82	36285661-104c-4acb-9533-4109bfcc6f2a	WRONG_ANSWER	6	888	2026-06-19 05:21:05.756043+07	\N	\N	\N
8283	452	81	7c3e89ed-b7d3-4292-9f1d-2e83e325ea49	WRONG_ANSWER	6	1036	2026-06-19 05:21:05.756042+07	\N	\N	\N
8276	452	74	5489cc4c-8e97-48c6-998b-20396bc1f614	WRONG_ANSWER	5	1016	2026-06-19 05:21:05.756036+07	\N	\N	\N
8274	452	72	a30ef471-ab03-406b-839e-79b69566d330	WRONG_ANSWER	5	1084	2026-06-19 05:21:05.756034+07	\N	\N	\N
8273	452	71	91e8b636-e1a0-45cf-bde1-1971d81c2a12	WRONG_ANSWER	16	980	2026-06-19 05:21:05.756033+07	\N	\N	\N
8280	452	78	db769697-5c4a-4bf7-af54-2b2f436dc8a5	WRONG_ANSWER	5	912	2026-06-19 05:21:05.756039+07	\N	\N	\N
8269	452	67	500738d1-fb4a-403e-bb6c-cc37582dd4d0	WRONG_ANSWER	5	1080	2026-06-19 05:21:05.756029+07	\N	\N	\N
8286	452	84	10308b9e-923d-45b6-b39e-5c6216cafc3d	WRONG_ANSWER	9	928	2026-06-19 05:21:05.756044+07	\N	\N	\N
8287	452	85	1e37e0e0-2450-47d0-b030-3c8a5eff3678	WRONG_ANSWER	5	976	2026-06-19 05:21:05.756045+07	\N	\N	\N
8278	452	76	d99a6d5e-0b86-4c3e-8f96-ad366d7dc3ac	WRONG_ANSWER	5	844	2026-06-19 05:21:05.756037+07	\N	\N	\N
8277	452	75	672c0ced-3ab5-451d-aeb8-213409385999	WRONG_ANSWER	5	864	2026-06-19 05:21:05.756036+07	\N	\N	\N
8279	452	77	96ac4083-462d-4248-880c-25def9c351df	WRONG_ANSWER	5	864	2026-06-19 05:21:05.756038+07	\N	\N	\N
8281	452	79	e001566c-7fcf-4f66-b4fe-f1d0292e0f43	WRONG_ANSWER	5	1024	2026-06-19 05:21:05.75604+07	\N	\N	\N
8293	452	91	78d5217d-42cf-4005-b46a-0283c9ac8989	WRONG_ANSWER	6	1024	2026-06-19 05:21:05.756051+07	\N	\N	\N
8289	452	87	34b5be47-0fc4-487c-b0f5-8efb08061b90	WRONG_ANSWER	6	1080	2026-06-19 05:21:05.756047+07	\N	\N	\N
8291	452	89	ed9f20fa-a077-4deb-92de-a1a35c78290a	WRONG_ANSWER	5	1088	2026-06-19 05:21:05.756049+07	\N	\N	\N
8292	452	90	ee510f16-c0ba-4a14-90d7-7cedd60d0854	WRONG_ANSWER	5	988	2026-06-19 05:21:05.75605+07	\N	\N	\N
8290	452	88	bf7dedc1-30af-41d5-a75e-852d100182c5	WRONG_ANSWER	5	1008	2026-06-19 05:21:05.756048+07	\N	\N	\N
8296	452	94	867d7cbc-958a-410b-9059-d92c763bed32	WRONG_ANSWER	7	920	2026-06-19 05:21:05.756054+07	\N	\N	\N
8299	452	97	9cc436c9-aa09-4df6-853d-5b1495538fc7	WRONG_ANSWER	6	1016	2026-06-19 05:21:05.756056+07	\N	\N	\N
8294	452	92	f855f429-6076-4c50-a28e-4536996e7d7b	WRONG_ANSWER	12	884	2026-06-19 05:21:05.756052+07	\N	\N	\N
8295	452	93	a2f5dbe6-7ee7-45d3-b1e4-a21331630b74	WRONG_ANSWER	5	868	2026-06-19 05:21:05.756053+07	\N	\N	\N
8304	452	102	00f4ebfd-e0f8-4364-8bcb-b0b9a5a2c51a	WRONG_ANSWER	7	860	2026-06-19 05:21:05.756061+07	\N	\N	\N
8298	452	96	fac0b0d2-75fe-482c-85eb-c74d6a6933f9	WRONG_ANSWER	5	868	2026-06-19 05:21:05.756055+07	\N	\N	\N
8302	452	100	317fe063-7ea6-45c5-8f7f-63d660279a07	WRONG_ANSWER	4	876	2026-06-19 05:21:05.756059+07	\N	\N	\N
8303	452	101	135dcd74-d4f2-42fb-bfdf-08063b68d3a3	WRONG_ANSWER	5	840	2026-06-19 05:21:05.75606+07	\N	\N	\N
8305	452	103	65a70b83-f297-48e5-b542-0304a98bc416	WRONG_ANSWER	6	1012	2026-06-19 05:21:05.756062+07	\N	\N	\N
8301	452	99	5301beca-acfc-4287-8c95-28a594b14da3	WRONG_ANSWER	5	868	2026-06-19 05:21:05.756058+07	\N	\N	\N
8307	452	105	35684184-b6ba-4531-82f3-73710cdf273c	WRONG_ANSWER	9	1028	2026-06-19 05:21:05.756063+07	\N	\N	\N
8308	452	106	a4b8e516-cc4d-406f-be9d-8152b702590d	WRONG_ANSWER	6	832	2026-06-19 05:21:05.756064+07	\N	\N	\N
8314	452	112	7aa28f04-4d28-4bea-b354-f6ab5099b6f9	WRONG_ANSWER	5	1024	2026-06-19 05:21:05.75607+07	\N	\N	\N
8310	452	108	e793d42a-f361-4181-87e0-de6f740694ff	WRONG_ANSWER	5	1020	2026-06-19 05:21:05.756066+07	\N	\N	\N
8309	452	107	a6845ef0-0ad9-49c1-8c5e-58db2b7db0ad	WRONG_ANSWER	5	1084	2026-06-19 05:21:05.756065+07	\N	\N	\N
8311	452	109	c5b54275-4383-430b-b408-a0a5d15d1a2d	WRONG_ANSWER	5	1040	2026-06-19 05:21:05.756067+07	\N	\N	\N
8312	452	110	d1a38ed8-e5f7-4759-9df3-b92caff6f6f8	WRONG_ANSWER	6	1088	2026-06-19 05:21:05.756068+07	\N	\N	\N
8315	452	113	c8325d7a-0e6c-4ee3-8bfd-b3e27e6936c7	WRONG_ANSWER	6	1028	2026-06-19 05:21:05.756071+07	\N	\N	\N
8319	452	117	db788487-584e-45e2-9383-dc7a7fbfdd62	WRONG_ANSWER	5	1020	2026-06-19 05:21:05.756074+07	\N	\N	\N
8317	452	115	2da4f70a-3185-4d56-a842-308a753f7e18	WRONG_ANSWER	6	980	2026-06-19 05:21:05.756072+07	\N	\N	\N
8313	452	111	4f57ad14-297a-4b6c-b172-b5f9e5e18df8	WRONG_ANSWER	5	1080	2026-06-19 05:21:05.756069+07	\N	\N	\N
8318	452	116	7b43effd-4c32-4621-9271-b89f92d14a1c	WRONG_ANSWER	5	804	2026-06-19 05:21:05.756073+07	\N	\N	\N
8316	452	114	b3bc1719-bd2a-4891-bb70-71adb2289a22	WRONG_ANSWER	5	1020	2026-06-19 05:21:05.756071+07	\N	\N	\N
8322	452	120	060a5361-5b8d-4516-bc3c-dd05589016c6	WRONG_ANSWER	10	904	2026-06-19 05:21:05.756077+07	\N	\N	\N
8320	452	118	90bb2208-a07f-48ef-80cc-12c0c36e569e	WRONG_ANSWER	5	1024	2026-06-19 05:21:05.756075+07	\N	\N	\N
8321	452	119	85e2a4cd-5d3b-4992-a3d6-7a2e8261427a	WRONG_ANSWER	7	880	2026-06-19 05:21:05.756076+07	\N	\N	\N
8246	452	26	511ad477-3b26-4ff0-8d69-666b4243ba94	WRONG_ANSWER	6	960	2026-06-19 05:21:05.756008+07	\N	\N	\N
8243	452	23	29301b12-bef8-4ff2-8eb3-a27f85e699df	WRONG_ANSWER	5	876	2026-06-19 05:21:05.756005+07	\N	\N	\N
8253	452	33	02074033-29ba-4a6c-a78a-7c3722131276	WRONG_ANSWER	10	840	2026-06-19 05:21:05.756015+07	\N	\N	\N
8263	452	61	b0474fd4-63f7-4819-9956-d2b758cb35f3	WRONG_ANSWER	6	1096	2026-06-19 05:21:05.756024+07	\N	\N	\N
8288	452	86	88c0a983-6f9c-4368-b67f-f15a77f0b1e2	WRONG_ANSWER	6	1020	2026-06-19 05:21:05.756046+07	\N	\N	\N
8306	452	104	b239d30a-dd9a-4edc-b5e4-5f536cfc9d9a	WRONG_ANSWER	6	876	2026-06-19 05:21:05.756063+07	\N	\N	\N
8300	452	98	38a8dc66-3660-43a8-8a24-5c7023426479	WRONG_ANSWER	5	836	2026-06-19 05:21:05.756057+07	\N	\N	\N
8297	452	95	93a343e8-aabc-4c6a-aece-e28d6b639c8b	WRONG_ANSWER	4	944	2026-06-19 05:21:05.756054+07	\N	\N	\N
8323	452	121	14a43339-e245-46fe-b074-6d6bd98d8db6	WRONG_ANSWER	6	996	2026-06-19 05:21:05.756078+07	\N	\N	\N
8329	452	127	0326e8f3-aac0-41af-8e2f-a05b42721fb6	WRONG_ANSWER	6	868	2026-06-19 05:21:05.756083+07	\N	\N	\N
8324	452	122	7527ea99-dfa0-4150-a70c-6bc9782f0127	WRONG_ANSWER	5	1024	2026-06-19 05:21:05.756079+07	\N	\N	\N
8325	452	123	a7a2b875-5549-410b-9550-9ce11116ab6c	WRONG_ANSWER	4	1028	2026-06-19 05:21:05.756079+07	\N	\N	\N
8331	452	129	ec935da4-1440-4bfb-8251-1d13abfc0b5e	WRONG_ANSWER	6	1028	2026-06-19 05:21:05.756085+07	\N	\N	\N
8332	452	130	82bd040c-aca9-4f0e-8a67-5f169bd5c058	WRONG_ANSWER	5	876	2026-06-19 05:21:05.756086+07	\N	\N	\N
8328	452	126	3b1e550b-0f7c-4634-b4a6-bc046f73ebab	WRONG_ANSWER	5	1020	2026-06-19 05:21:05.756082+07	\N	\N	\N
8326	452	124	a2d99397-8c3c-4ae8-b3ca-7b836354cd7a	WRONG_ANSWER	5	1020	2026-06-19 05:21:05.75608+07	\N	\N	\N
8327	452	125	b1e3550b-08a7-4a1f-b597-4d9d4b15e511	WRONG_ANSWER	7	1016	2026-06-19 05:21:05.756081+07	\N	\N	\N
8330	452	128	62473bac-56c0-4c45-bc2a-e8b40e26cacc	WRONG_ANSWER	6	1052	2026-06-19 05:21:05.756084+07	\N	\N	\N
8334	452	132	9364a0dd-6a4c-4712-a17f-24378c1c8b9c	WRONG_ANSWER	5	1052	2026-06-19 05:21:05.756088+07	\N	\N	\N
8333	452	131	63bca76c-16d0-4ec8-9a92-57a98866ec96	WRONG_ANSWER	6	1028	2026-06-19 05:21:05.756087+07	\N	\N	\N
8339	452	137	f352de42-f8c2-4173-bc44-ad12217eab4b	WRONG_ANSWER	3	1052	2026-06-19 05:21:05.756092+07	\N	\N	\N
8337	452	135	39c76b9d-6dbe-411a-9966-6aaae9296cac	WRONG_ANSWER	4	1028	2026-06-19 05:21:05.75609+07	\N	\N	\N
8335	452	133	8e90b3ad-de41-44a2-b1a4-d8223d8c63f9	WRONG_ANSWER	4	1048	2026-06-19 05:21:05.756089+07	\N	\N	\N
8338	452	136	e68edec2-6fd4-4c8e-8bb2-3992956333fb	WRONG_ANSWER	3	1056	2026-06-19 05:21:05.756091+07	\N	\N	\N
8336	452	134	7d58a3bc-e017-4ed1-a650-1c0bb47aa21d	WRONG_ANSWER	4	944	2026-06-19 05:21:05.75609+07	\N	\N	\N
8340	452	138	4715d8d4-e469-4ee3-9b6c-200dac590655	WRONG_ANSWER	4	864	2026-06-19 05:21:05.756093+07	\N	\N	\N
8348	453	28	5df8b6c3-2ca9-4efc-aa4b-b7ad7ecbcb23	WRONG_ANSWER	11	1084	2026-06-19 05:22:05.647977+07	\N	\N	\N
8342	453	22	4e4a3e81-70df-44a2-ab29-f37ae57e1272	WRONG_ANSWER	5	996	2026-06-19 05:22:05.64797+07	\N	\N	\N
8344	453	24	9fa4c61c-a4fc-4d4f-99e6-31851fffa37a	WRONG_ANSWER	5	1080	2026-06-19 05:22:05.647973+07	\N	\N	\N
8343	453	23	215e4aff-2b39-4296-8ed5-624a8c3e2729	WRONG_ANSWER	9	932	2026-06-19 05:22:05.647972+07	\N	\N	\N
8357	453	37	272bb8f8-c03c-48c1-80b4-23323c9e2342	WRONG_ANSWER	5	996	2026-06-19 05:22:05.647988+07	\N	\N	\N
8349	453	29	454b3165-3360-4b9c-89a7-267f6b343630	WRONG_ANSWER	5	1020	2026-06-19 05:22:05.647979+07	\N	\N	\N
8358	453	38	7d8913cc-943e-40ea-8fbc-b7e9d58b92ff	WRONG_ANSWER	6	1024	2026-06-19 05:22:05.647989+07	\N	\N	\N
8355	453	35	2a8fa2d1-674c-4f5c-bfa1-5fd692037534	WRONG_ANSWER	7	988	2026-06-19 05:22:05.647985+07	\N	\N	\N
8350	453	30	856f94de-66d3-4c9f-a5f7-24b6a3e9bb6e	WRONG_ANSWER	6	1092	2026-06-19 05:22:05.64798+07	\N	\N	\N
8347	453	27	c0772203-ec29-45f9-845d-4fef0211e79b	WRONG_ANSWER	7	1020	2026-06-19 05:22:05.647976+07	\N	\N	\N
8341	453	21	18f54ff8-44d3-46e6-9320-9653a81f1f17	WRONG_ANSWER	9	1080	2026-06-19 05:22:05.647966+07	\N	\N	\N
8353	453	33	b17423d6-7fe1-450a-99ee-862401a781bb	WRONG_ANSWER	5	1128	2026-06-19 05:22:05.647983+07	\N	\N	\N
8364	453	62	88696bfa-8650-4cbd-87d8-edec39560d5e	WRONG_ANSWER	8	876	2026-06-19 05:22:05.647995+07	\N	\N	\N
8352	453	32	842be2be-d82e-4bad-a42d-bc3273e2cdf0	WRONG_ANSWER	7	1028	2026-06-19 05:22:05.647982+07	\N	\N	\N
8354	453	34	c33f7451-bb30-47b0-99a3-2d9a6ab02ff9	WRONG_ANSWER	5	1044	2026-06-19 05:22:05.647984+07	\N	\N	\N
8346	453	26	27035e07-edf3-4900-be2e-c8424e29fa79	WRONG_ANSWER	5	1024	2026-06-19 05:22:05.647975+07	\N	\N	\N
8345	453	25	060653ac-456d-471c-9eef-bb8c2b6c8978	WRONG_ANSWER	6	876	2026-06-19 05:22:05.647974+07	\N	\N	\N
8359	453	57	64a92870-9b25-47bd-b026-fd602fd645c9	WRONG_ANSWER	5	824	2026-06-19 05:22:05.64799+07	\N	\N	\N
8356	453	36	25f60d55-6dfc-4060-9d87-e21aaa3e1e1c	WRONG_ANSWER	7	840	2026-06-19 05:22:05.647986+07	\N	\N	\N
8351	453	31	c5675706-8817-40c5-a2a7-61ca57d15236	WRONG_ANSWER	7	1032	2026-06-19 05:22:05.647981+07	\N	\N	\N
8360	453	58	c394c73f-af76-4d75-b9e7-e6bc4eb9a8e9	WRONG_ANSWER	10	1016	2026-06-19 05:22:05.647991+07	\N	\N	\N
8362	453	60	824dfa68-3243-45cd-b2c2-ebef072765a3	WRONG_ANSWER	7	888	2026-06-19 05:22:05.647993+07	\N	\N	\N
8363	453	61	db77fc10-4bcf-4cd1-9848-46e47e185129	WRONG_ANSWER	5	1028	2026-06-19 05:22:05.647994+07	\N	\N	\N
8361	453	59	c2c2bf40-93b6-4b8a-bfea-5d07b352c4ff	WRONG_ANSWER	6	988	2026-06-19 05:22:05.647992+07	\N	\N	\N
8406	453	104	fe29afd2-9a49-49e5-a6f4-8d19490cab2c	WRONG_ANSWER	5	1084	2026-06-19 05:22:05.648042+07	\N	\N	\N
8543	455	23	7cfd2b51-78f1-4355-93db-c3e00631effc	WRONG_ANSWER	6	884	2026-06-19 05:22:34.210823+07	main.cpp:8:25: warning: integer constant is too large for its type\n    8 |     for(int i = 0; i >= 100000000000000000000000; i++)\n      |                         ^~~~~~~~~~~~~~~~~~~~~~~~\n	\N	\N
8541	455	21	c08af549-df6f-48a4-b788-ae361ba3ed82	WRONG_ANSWER	6	1008	2026-06-19 05:22:34.210821+07	main.cpp:8:25: warning: integer constant is too large for its type\n    8 |     for(int i = 0; i >= 100000000000000000000000; i++)\n      |                         ^~~~~~~~~~~~~~~~~~~~~~~~\n	\N	\N
8562	455	60	a86d3951-a391-4806-a79d-5ccad1b4a00f	WRONG_ANSWER	8	972	2026-06-19 05:22:34.21083+07	main.cpp:8:25: warning: integer constant is too large for its type\n    8 |     for(int i = 0; i >= 100000000000000000000000; i++)\n      |                         ^~~~~~~~~~~~~~~~~~~~~~~~\n	\N	\N
8565	455	63	3f0f030e-ed9f-479b-9296-1372d75033fd	WRONG_ANSWER	7	976	2026-06-19 05:22:34.210831+07	main.cpp:8:25: warning: integer constant is too large for its type\n    8 |     for(int i = 0; i >= 100000000000000000000000; i++)\n      |                         ^~~~~~~~~~~~~~~~~~~~~~~~\n	\N	\N
9037	460	133	480d5de5-6af8-4e1c-b16f-da71e3db17b1	ACCEPTED	5	864	2026-06-21 02:01:32.405888+07	\N	\N	-57
9053	461	31	44fd176e-f918-4a94-ab1e-bb2a41badb2b	ACCEPTED	4	1084	2026-06-21 02:01:47.819801+07	\N	\N	30000
9060	461	38	97d6d40e-2e81-40b4-9660-4121114cb181	ACCEPTED	6	864	2026-06-21 02:01:47.819819+07	\N	\N	3000000
8372	453	70	c3460b57-118a-47eb-8056-a976d1773b64	WRONG_ANSWER	7	1032	2026-06-19 05:22:05.648004+07	\N	\N	\N
8367	453	65	bffc658f-d089-4e75-a5a1-629131982a23	WRONG_ANSWER	5	832	2026-06-19 05:22:05.647999+07	\N	\N	\N
8376	453	74	b212bce6-a0f3-4b8d-896b-c8b6493dcff2	WRONG_ANSWER	5	864	2026-06-19 05:22:05.648009+07	\N	\N	\N
8370	453	68	9d2a7222-e767-4321-838e-a8466c681ecb	WRONG_ANSWER	5	856	2026-06-19 05:22:05.648002+07	\N	\N	\N
8365	453	63	1dd3df05-a0c3-4737-af15-772521d9ab00	WRONG_ANSWER	6	1012	2026-06-19 05:22:05.647996+07	\N	\N	\N
8371	453	69	01f72c96-a181-4f94-9679-c9beff43a0d0	WRONG_ANSWER	6	1012	2026-06-19 05:22:05.648003+07	\N	\N	\N
8380	453	78	3253817b-a889-49b0-a88e-6e3c5ff44ae8	WRONG_ANSWER	6	880	2026-06-19 05:22:05.648013+07	\N	\N	\N
8366	453	64	1cbab110-21a9-44d2-849a-79399f0ae626	WRONG_ANSWER	4	1024	2026-06-19 05:22:05.647998+07	\N	\N	\N
8369	453	67	21945810-8bd0-4b21-92f7-e1283df85858	WRONG_ANSWER	5	1024	2026-06-19 05:22:05.648001+07	\N	\N	\N
8377	453	75	c16fb8e3-740e-42f6-acbb-b24c00e46c98	WRONG_ANSWER	6	992	2026-06-19 05:22:05.64801+07	\N	\N	\N
8374	453	72	a6acb646-4107-471f-b0be-5945dcc00adc	WRONG_ANSWER	5	872	2026-06-19 05:22:05.648006+07	\N	\N	\N
8383	453	81	478193ab-1759-435e-ac10-62c6e5f8320c	WRONG_ANSWER	7	980	2026-06-19 05:22:05.648016+07	\N	\N	\N
8373	453	71	cc58828f-fc13-4f0a-9b74-aae8878274df	WRONG_ANSWER	6	868	2026-06-19 05:22:05.648005+07	\N	\N	\N
8386	453	84	ca1f69d1-8e71-416b-b705-7bde3f1ff48d	WRONG_ANSWER	8	856	2026-06-19 05:22:05.64802+07	\N	\N	\N
8381	453	79	d83292c7-3613-45f6-aa66-eefe39ee302a	WRONG_ANSWER	5	828	2026-06-19 05:22:05.648014+07	\N	\N	\N
8375	453	73	b3da3dda-7f98-437e-9682-0807703d26fc	WRONG_ANSWER	5	864	2026-06-19 05:22:05.648008+07	\N	\N	\N
8382	453	80	94fc606f-ef60-4d9b-9ea4-9b182860286c	WRONG_ANSWER	6	872	2026-06-19 05:22:05.648015+07	\N	\N	\N
8387	453	85	a375231d-9143-48c4-85c7-be1af8ca15e0	WRONG_ANSWER	5	960	2026-06-19 05:22:05.648021+07	\N	\N	\N
8379	453	77	e2a2874c-ec98-4007-83bb-9148da03713d	WRONG_ANSWER	6	1004	2026-06-19 05:22:05.648012+07	\N	\N	\N
8378	453	76	7d5a268b-f7c0-402a-a5a7-83ebe322e7e9	WRONG_ANSWER	5	1028	2026-06-19 05:22:05.648011+07	\N	\N	\N
8388	453	86	63258adf-ec81-48ce-a335-94afb163a1c5	WRONG_ANSWER	6	1016	2026-06-19 05:22:05.648022+07	\N	\N	\N
8391	453	89	da317630-a8b5-4ef7-b95b-3cd44a1baf97	WRONG_ANSWER	5	932	2026-06-19 05:22:05.648025+07	\N	\N	\N
8393	453	91	bc4b4920-f6c4-4125-9835-d8e0f4a93f31	WRONG_ANSWER	5	1016	2026-06-19 05:22:05.648028+07	\N	\N	\N
8392	453	90	2eaff1db-d66b-4f23-a36a-60a622871cb9	WRONG_ANSWER	5	1024	2026-06-19 05:22:05.648026+07	\N	\N	\N
8401	453	99	557a00cd-8ee5-4d59-98f5-614e6d4f7687	WRONG_ANSWER	6	988	2026-06-19 05:22:05.648036+07	\N	\N	\N
8389	453	87	fb49831c-7ac5-488e-9e28-8c2f151fcf0f	WRONG_ANSWER	5	1024	2026-06-19 05:22:05.648023+07	\N	\N	\N
8396	453	94	ab9d8ca4-9ff5-432d-91f4-e8f5afa21c98	WRONG_ANSWER	6	1088	2026-06-19 05:22:05.648031+07	\N	\N	\N
8397	453	95	c4c0a908-79a5-4f1c-9f95-3126fa3c05b6	WRONG_ANSWER	7	1000	2026-06-19 05:22:05.648032+07	\N	\N	\N
8399	453	97	6c6d2e0c-58ef-4059-a5ad-51b48eef4725	WRONG_ANSWER	5	1024	2026-06-19 05:22:05.648034+07	\N	\N	\N
8395	453	93	43b5f132-743a-407f-906a-89a083aed560	WRONG_ANSWER	6	844	2026-06-19 05:22:05.64803+07	\N	\N	\N
8398	453	96	e77ed66d-4cf7-4475-a684-09931cb76b21	WRONG_ANSWER	10	904	2026-06-19 05:22:05.648033+07	\N	\N	\N
8408	453	106	ea5ea9df-296f-4f9e-b340-758fcfa1d06e	WRONG_ANSWER	5	876	2026-06-19 05:22:05.648044+07	\N	\N	\N
8409	453	107	fd067c59-3887-4610-b9f3-5d2ac325f7ed	WRONG_ANSWER	5	996	2026-06-19 05:22:05.648045+07	\N	\N	\N
8403	453	101	3e0e20e9-f3a9-4cab-9431-00e2aa5b4745	WRONG_ANSWER	5	1024	2026-06-19 05:22:05.648039+07	\N	\N	\N
8404	453	102	5141f486-ead0-4756-b068-a357d8495ba0	WRONG_ANSWER	7	976	2026-06-19 05:22:05.64804+07	\N	\N	\N
8394	453	92	7d3b4688-6df4-4b68-99b2-6d43c88b431a	WRONG_ANSWER	5	1016	2026-06-19 05:22:05.648029+07	\N	\N	\N
8411	453	109	db5ef2ad-763e-4a78-a45f-6eff62765305	WRONG_ANSWER	6	884	2026-06-19 05:22:05.648047+07	\N	\N	\N
8402	453	100	8e4f8f88-6881-4bb4-a37a-e6c6ff8ab73d	WRONG_ANSWER	5	864	2026-06-19 05:22:05.648037+07	\N	\N	\N
8410	453	108	b8c90319-f350-47c2-bd8e-6ee7b8dbae8b	WRONG_ANSWER	6	900	2026-06-19 05:22:05.648046+07	\N	\N	\N
8405	453	103	81f7c833-1a9c-449d-8fd3-8e9822a34cec	WRONG_ANSWER	5	1080	2026-06-19 05:22:05.648041+07	\N	\N	\N
8407	453	105	ab5bb599-6c59-4456-830f-d6d0c80734ef	WRONG_ANSWER	5	1028	2026-06-19 05:22:05.648043+07	\N	\N	\N
8412	453	110	3f4cc8a0-c055-4c9c-a0e8-0b3b37052502	WRONG_ANSWER	6	1032	2026-06-19 05:22:05.648049+07	\N	\N	\N
8415	453	113	893574a1-4932-43ed-aff1-6a6890c7c37b	WRONG_ANSWER	5	880	2026-06-19 05:22:05.648052+07	\N	\N	\N
8416	453	114	bc52a253-f9ed-4e17-9d9a-bc13f6f71c0c	WRONG_ANSWER	6	1092	2026-06-19 05:22:05.648053+07	\N	\N	\N
8413	453	111	ad9d6afc-c79b-470e-ad96-c0d3139649cc	WRONG_ANSWER	5	1020	2026-06-19 05:22:05.64805+07	\N	\N	\N
8418	453	116	c023db9a-cce1-405f-bb6f-4a1e3d7f8860	WRONG_ANSWER	5	864	2026-06-19 05:22:05.648055+07	\N	\N	\N
8421	453	119	3b4a938b-5e8c-4096-ab6d-a70bacf044b8	WRONG_ANSWER	5	1028	2026-06-19 05:22:05.648058+07	\N	\N	\N
8429	453	127	66893ea4-149f-4450-ae41-2ba9a9396b31	WRONG_ANSWER	5	836	2026-06-19 05:22:05.648067+07	\N	\N	\N
8417	453	115	30e475b6-062a-42e5-90fe-b8b8e5788181	WRONG_ANSWER	5	912	2026-06-19 05:22:05.648054+07	\N	\N	\N
8420	453	118	b9664017-49dd-406a-86f9-9f54070b96c1	WRONG_ANSWER	6	1012	2026-06-19 05:22:05.648057+07	\N	\N	\N
8419	453	117	759b8fb2-a475-43d6-8dbd-e00ffe8d8ed6	WRONG_ANSWER	7	1016	2026-06-19 05:22:05.648056+07	\N	\N	\N
8430	453	128	9f56db18-0e41-4ecd-b7fc-a04bc693f7da	WRONG_ANSWER	6	1100	2026-06-19 05:22:05.648068+07	\N	\N	\N
8423	453	121	b5bd503e-fcf6-406d-b20c-a0510be2e3be	WRONG_ANSWER	7	1020	2026-06-19 05:22:05.648061+07	\N	\N	\N
8424	453	122	481d9f16-2e11-4ce3-a0fd-39f7a92e2953	WRONG_ANSWER	9	1032	2026-06-19 05:22:05.648062+07	\N	\N	\N
8428	453	126	754f8406-3cc2-4739-93bf-2857385a68d5	WRONG_ANSWER	5	1020	2026-06-19 05:22:05.648066+07	\N	\N	\N
8414	453	112	3c3fd8aa-3bb6-42bc-a9e1-0f93313b02ef	WRONG_ANSWER	5	880	2026-06-19 05:22:05.648051+07	\N	\N	\N
8426	453	124	b2179426-dac2-4a96-99c4-6fd32234167b	WRONG_ANSWER	8	1044	2026-06-19 05:22:05.648064+07	\N	\N	\N
8422	453	120	4f24f83f-0d99-4ad9-8a89-6eb6348be3d9	WRONG_ANSWER	7	1028	2026-06-19 05:22:05.64806+07	\N	\N	\N
8431	453	129	f09f90cb-6b8f-41a3-a830-ed61916d2123	WRONG_ANSWER	5	1012	2026-06-19 05:22:05.648069+07	\N	\N	\N
8427	453	125	7d01f01f-4531-470d-8a1d-213d7a2f16c8	WRONG_ANSWER	11	932	2026-06-19 05:22:05.648065+07	\N	\N	\N
8432	453	130	2dbd3456-1987-4345-9b72-20227058ed14	WRONG_ANSWER	5	1048	2026-06-19 05:22:05.648071+07	\N	\N	\N
8434	453	132	277b0ba4-9d06-4556-b509-5acfcc6e9e0f	WRONG_ANSWER	5	1052	2026-06-19 05:22:05.648073+07	\N	\N	\N
8368	453	66	be0ba0ab-3b4e-43d9-a609-204f03a2d4fb	WRONG_ANSWER	6	836	2026-06-19 05:22:05.648+07	\N	\N	\N
8384	453	82	a9c19bf9-dbcd-4f72-baf9-d116306f727d	WRONG_ANSWER	6	1088	2026-06-19 05:22:05.648018+07	\N	\N	\N
8385	453	83	d1f544f3-836e-464d-93e5-0aca906359af	WRONG_ANSWER	5	876	2026-06-19 05:22:05.648019+07	\N	\N	\N
8390	453	88	d7d712fb-ae84-4b8e-90e0-c0c87551ea07	WRONG_ANSWER	5	1088	2026-06-19 05:22:05.648024+07	\N	\N	\N
8400	453	98	16aad3be-f0be-42da-b530-b71156793c0f	WRONG_ANSWER	5	1020	2026-06-19 05:22:05.648035+07	\N	\N	\N
8425	453	123	de97ea9a-1bf0-4276-b923-76ff3c5a1fe2	WRONG_ANSWER	6	864	2026-06-19 05:22:05.648063+07	\N	\N	\N
8433	453	131	cca999e9-9c3c-46b0-969e-17ad599c0842	WRONG_ANSWER	5	1088	2026-06-19 05:22:05.648072+07	\N	\N	\N
8435	453	133	22f8b1ad-9a5a-4ef0-9fbe-b7c6e66265aa	WRONG_ANSWER	6	1012	2026-06-19 05:22:05.648074+07	\N	\N	\N
8436	453	134	2091bc45-a7fc-485e-8b4b-25c2a4f2a1f9	WRONG_ANSWER	4	1064	2026-06-19 05:22:05.648075+07	\N	\N	\N
8439	453	137	34ca204a-d5ea-4000-8f61-6d7a25fcb2fa	WRONG_ANSWER	3	1068	2026-06-19 05:22:05.648078+07	\N	\N	\N
8438	453	136	f0bd8ddb-62a1-46b0-b47f-1b6fcf20e824	WRONG_ANSWER	3	1052	2026-06-19 05:22:05.648077+07	\N	\N	\N
8437	453	135	e4854e8a-fba6-412e-9e04-93cf370b274a	WRONG_ANSWER	3	1052	2026-06-19 05:22:05.648076+07	\N	\N	\N
8440	453	138	2df9edb5-1d15-41bf-93e8-7b58bbff2a38	WRONG_ANSWER	2	1244	2026-06-19 05:22:05.648079+07	\N	\N	\N
8450	454	30	9a6b44a4-e663-43a1-a304-6e5546efaf54	WRONG_ANSWER	5	1024	2026-06-19 05:22:19.890964+07	\N	\N	\N
8447	454	27	ef26b5ac-8731-4872-9c72-b03f01190bd0	WRONG_ANSWER	5	1028	2026-06-19 05:22:19.890961+07	\N	\N	\N
8461	454	59	009aa949-2c38-43fe-b5d6-7b2032b0748c	WRONG_ANSWER	5	880	2026-06-19 05:22:19.890974+07	\N	\N	\N
8446	454	26	69852cce-4ae4-4492-b453-61e7fcd3847d	WRONG_ANSWER	5	1036	2026-06-19 05:22:19.89096+07	\N	\N	\N
8457	454	37	5949ba87-7e2c-4a1a-9db8-18087b38d33b	WRONG_ANSWER	5	1084	2026-06-19 05:22:19.89097+07	\N	\N	\N
8442	454	22	b2a30de1-f55f-471a-860f-77bd8cac4179	WRONG_ANSWER	5	876	2026-06-19 05:22:19.890955+07	\N	\N	\N
8448	454	28	9d6b21d2-7c0f-4bd1-bb2b-052346397f94	WRONG_ANSWER	5	980	2026-06-19 05:22:19.890962+07	\N	\N	\N
8444	454	24	868a3fb1-1ad6-4cef-8a84-01e36cb66391	WRONG_ANSWER	5	864	2026-06-19 05:22:19.890958+07	\N	\N	\N
8452	454	32	475f0c8c-c212-4df4-be1a-7049f7416d8b	WRONG_ANSWER	6	1028	2026-06-19 05:22:19.890966+07	\N	\N	\N
8443	454	23	32cc423f-96fc-431f-8ddc-d2fa3d9cb1f1	WRONG_ANSWER	6	1028	2026-06-19 05:22:19.890956+07	\N	\N	\N
8449	454	29	e746620b-4ea6-41ad-bb51-3f12d1bd1c73	WRONG_ANSWER	6	992	2026-06-19 05:22:19.890963+07	\N	\N	\N
8458	454	38	69aac62a-39e9-4d7f-a62b-d58904eae305	WRONG_ANSWER	7	1016	2026-06-19 05:22:19.890971+07	\N	\N	\N
8456	454	36	091fa2be-bfe1-4b2b-b54d-b48995355810	WRONG_ANSWER	5	1028	2026-06-19 05:22:19.890969+07	\N	\N	\N
8454	454	34	f5f501aa-cae8-4e1e-980f-dcf330019da9	WRONG_ANSWER	6	872	2026-06-19 05:22:19.890968+07	\N	\N	\N
8462	454	60	dfa10b6f-7615-41ba-85af-c18c019e680b	WRONG_ANSWER	7	864	2026-06-19 05:22:19.890975+07	\N	\N	\N
8464	454	62	f53befe0-2e76-4ec4-bdd6-e13a2b5db39c	WRONG_ANSWER	9	1096	2026-06-19 05:22:19.890977+07	\N	\N	\N
8445	454	25	816640df-2671-4f03-afd8-e6512e1d3699	WRONG_ANSWER	7	1032	2026-06-19 05:22:19.890959+07	\N	\N	\N
8455	454	35	bd1e9dea-944b-446a-bf40-d4da3dac56a0	WRONG_ANSWER	7	1092	2026-06-19 05:22:19.890969+07	\N	\N	\N
8459	454	57	0ac1f89f-2827-4dbe-9647-0202a64919a1	WRONG_ANSWER	6	1088	2026-06-19 05:22:19.890972+07	\N	\N	\N
8463	454	61	6d298275-ad39-44d3-a617-f2e9b90ae644	WRONG_ANSWER	5	1020	2026-06-19 05:22:19.890976+07	\N	\N	\N
8460	454	58	7a48a0d1-1d8b-4a02-9ff7-e6ff1d5c59d1	WRONG_ANSWER	5	1092	2026-06-19 05:22:19.890974+07	\N	\N	\N
8441	454	21	8aedc02c-997d-4a9e-bf00-dea3f9be918b	WRONG_ANSWER	12	1024	2026-06-19 05:22:19.890949+07	\N	\N	\N
8453	454	33	d26906fd-ad2a-444c-a7f7-1aff0debbae4	WRONG_ANSWER	8	1028	2026-06-19 05:22:19.890967+07	\N	\N	\N
8451	454	31	12d4c705-db1b-4452-be6a-44461467be02	WRONG_ANSWER	6	1028	2026-06-19 05:22:19.890965+07	\N	\N	\N
8466	454	64	7a9efc2d-cb73-43fa-9ad6-b09b56e15813	WRONG_ANSWER	7	1016	2026-06-19 05:22:19.890979+07	\N	\N	\N
8467	454	65	55b2be6c-4472-4534-9efb-018c2990a0a2	WRONG_ANSWER	5	1084	2026-06-19 05:22:19.89098+07	\N	\N	\N
8471	454	69	4a3b1040-2c7d-4d0b-9295-ac743eef2a2e	WRONG_ANSWER	6	1016	2026-06-19 05:22:19.890984+07	\N	\N	\N
8465	454	63	7f036daf-dcaf-45bb-b9cc-083191e328f1	WRONG_ANSWER	6	1024	2026-06-19 05:22:19.890978+07	\N	\N	\N
8483	454	81	11eaca26-8853-4b50-9930-bae12e8ed746	WRONG_ANSWER	5	876	2026-06-19 05:22:19.890996+07	\N	\N	\N
8473	454	71	a2df8019-0d63-4230-a1ad-0631761cb590	WRONG_ANSWER	6	1100	2026-06-19 05:22:19.890985+07	\N	\N	\N
8470	454	68	f87f0217-9bd3-4ee7-9430-7b854daca5cf	WRONG_ANSWER	7	848	2026-06-19 05:22:19.890983+07	\N	\N	\N
8479	454	77	9f270f73-4b6f-4b74-aa82-ed0dd0334776	WRONG_ANSWER	5	1084	2026-06-19 05:22:19.890992+07	\N	\N	\N
8469	454	67	f355137a-17c6-4464-b1ed-db60fabcde2f	WRONG_ANSWER	9	1032	2026-06-19 05:22:19.890982+07	\N	\N	\N
8468	454	66	78d3713f-9112-4863-afe5-48fb7b5adf28	WRONG_ANSWER	6	884	2026-06-19 05:22:19.890981+07	\N	\N	\N
8486	454	84	291b0a82-1495-49d9-90b0-f432cc00889a	WRONG_ANSWER	5	1024	2026-06-19 05:22:19.890999+07	\N	\N	\N
8478	454	76	949b074a-9838-4ee0-b818-0ab464ff1e4d	WRONG_ANSWER	5	884	2026-06-19 05:22:19.890991+07	\N	\N	\N
8477	454	75	2c90ac85-6105-468b-a933-dbbffd982a1b	WRONG_ANSWER	8	888	2026-06-19 05:22:19.890989+07	\N	\N	\N
8476	454	74	65812c45-3140-48c9-ab23-40aed3e38d8a	WRONG_ANSWER	6	940	2026-06-19 05:22:19.890989+07	\N	\N	\N
8472	454	70	080390d7-5a06-4588-b6e9-d1caf3fc91fb	WRONG_ANSWER	6	1084	2026-06-19 05:22:19.890984+07	\N	\N	\N
8475	454	73	9b830f77-5c07-4eea-855a-09f8cc4df42c	WRONG_ANSWER	6	1092	2026-06-19 05:22:19.890988+07	\N	\N	\N
8481	454	79	bd3723b7-0688-405f-bc85-c123a4c17d8e	WRONG_ANSWER	5	868	2026-06-19 05:22:19.890994+07	\N	\N	\N
8482	454	80	508d655e-1fae-49f1-a1af-076cf2831050	WRONG_ANSWER	5	840	2026-06-19 05:22:19.890995+07	\N	\N	\N
8487	454	85	20a4a787-9ece-44c1-a6c9-9ffbfd9aad9b	WRONG_ANSWER	5	1012	2026-06-19 05:22:19.891+07	\N	\N	\N
8474	454	72	d28e19ac-94da-4444-9841-f6b0c6b6fea8	WRONG_ANSWER	6	860	2026-06-19 05:22:19.890986+07	\N	\N	\N
8485	454	83	1fb4a19e-b628-4c21-8fb6-287a4633389c	WRONG_ANSWER	5	984	2026-06-19 05:22:19.890998+07	\N	\N	\N
8484	454	82	05ed8fff-b168-49cb-aba7-ea4d89e48502	WRONG_ANSWER	6	876	2026-06-19 05:22:19.890997+07	\N	\N	\N
8480	454	78	b4307361-1120-4171-839c-95973a0501c2	WRONG_ANSWER	8	1028	2026-06-19 05:22:19.890993+07	\N	\N	\N
8488	454	86	3d318140-6ada-411a-b3b4-a2e1c355886e	WRONG_ANSWER	7	1008	2026-06-19 05:22:19.891+07	\N	\N	\N
8489	454	87	c47ed100-877e-4c4e-8d49-78c1d3908036	WRONG_ANSWER	10	1028	2026-06-19 05:22:19.891001+07	\N	\N	\N
8490	454	88	5cb74d5c-b95e-4f47-b1b4-a7e72f09ebb8	WRONG_ANSWER	10	972	2026-06-19 05:22:19.891002+07	\N	\N	\N
8492	454	90	eb82f077-43b2-4c80-9024-6c5aeb125a3d	WRONG_ANSWER	10	872	2026-06-19 05:22:19.891005+07	\N	\N	\N
8499	454	97	5891e7ca-005e-4d90-89ca-5f39d2a218b4	WRONG_ANSWER	8	1020	2026-06-19 05:22:19.891011+07	\N	\N	\N
8494	454	92	718c1778-30ce-4505-9504-f89a5e7d039b	WRONG_ANSWER	7	984	2026-06-19 05:22:19.891006+07	\N	\N	\N
8500	454	98	0c0220da-3bac-472e-9051-31c0f1feca09	WRONG_ANSWER	6	1032	2026-06-19 05:22:19.891012+07	\N	\N	\N
8493	454	91	33b9e4e8-f040-4fb4-a319-1891abe00e7d	WRONG_ANSWER	10	872	2026-06-19 05:22:19.891006+07	\N	\N	\N
8491	454	89	fc5aa4f7-9a82-4342-9cfd-2af7e1c6fbd5	WRONG_ANSWER	5	868	2026-06-19 05:22:19.891004+07	\N	\N	\N
8498	454	96	562e75de-da15-482c-b7d5-94f04c48a759	WRONG_ANSWER	9	1024	2026-06-19 05:22:19.89101+07	\N	\N	\N
8501	454	99	06a4551b-11b2-4727-9169-7609b894c682	WRONG_ANSWER	6	864	2026-06-19 05:22:19.891013+07	\N	\N	\N
8497	454	95	e1a45b9d-e6fa-4fd9-8e4d-f91e2e1c4dde	WRONG_ANSWER	6	868	2026-06-19 05:22:19.891009+07	\N	\N	\N
8496	454	94	40c547eb-7a74-4868-815b-cc2c6b3efd46	WRONG_ANSWER	5	864	2026-06-19 05:22:19.891008+07	\N	\N	\N
8502	454	100	08baae84-b11d-47bd-8942-ad8f41c15e0a	WRONG_ANSWER	6	880	2026-06-19 05:22:19.891014+07	\N	\N	\N
8507	454	105	521a4c12-0a7c-445f-ad80-7b4e83858f36	WRONG_ANSWER	7	980	2026-06-19 05:22:19.891018+07	\N	\N	\N
8509	454	107	ddbfa713-4d3f-44f8-9762-8ec275fea82c	WRONG_ANSWER	10	848	2026-06-19 05:22:19.89102+07	\N	\N	\N
8503	454	101	5083cca1-afb4-4e94-a338-2926e618bf59	WRONG_ANSWER	5	1016	2026-06-19 05:22:19.891015+07	\N	\N	\N
8506	454	104	e434645b-c9a6-4abd-9866-bf6bb875723d	WRONG_ANSWER	9	1016	2026-06-19 05:22:19.891018+07	\N	\N	\N
8505	454	103	3c4ca452-3837-438a-9e89-b46cb7d5c916	WRONG_ANSWER	5	1080	2026-06-19 05:22:19.891017+07	\N	\N	\N
8495	454	93	78562357-cd99-415f-9fc9-147c5ec1f9a1	WRONG_ANSWER	12	1036	2026-06-19 05:22:19.891007+07	\N	\N	\N
8508	454	106	435c919a-b088-4161-9383-be1eff2a09b0	WRONG_ANSWER	5	880	2026-06-19 05:22:19.891019+07	\N	\N	\N
8512	454	110	bb66273b-7b89-44da-9b2e-de4321527921	WRONG_ANSWER	8	992	2026-06-19 05:22:19.891023+07	\N	\N	\N
8504	454	102	dc2f93ef-9dcc-4c4e-8670-1b078df133d4	WRONG_ANSWER	6	1076	2026-06-19 05:22:19.891016+07	\N	\N	\N
8510	454	108	f606eb4b-6d94-4179-be90-1643f7ee4a49	WRONG_ANSWER	10	1000	2026-06-19 05:22:19.891021+07	\N	\N	\N
8511	454	109	8141d0e6-547d-47e1-b17c-8f0e4ecec62d	WRONG_ANSWER	11	1088	2026-06-19 05:22:19.891022+07	\N	\N	\N
8514	454	112	4e1459f3-2819-46db-9b27-5eeea3ffe94a	WRONG_ANSWER	8	1084	2026-06-19 05:22:19.891025+07	\N	\N	\N
8513	454	111	9f323233-c04e-4837-b79f-0a048b26d1ca	WRONG_ANSWER	10	1024	2026-06-19 05:22:19.891024+07	\N	\N	\N
8519	454	117	d0e4792a-cef4-4add-a943-ed4add7ae266	WRONG_ANSWER	11	876	2026-06-19 05:22:19.89103+07	\N	\N	\N
8518	454	116	bac7d697-fdb2-4e74-99e2-14378397e2a2	WRONG_ANSWER	10	1028	2026-06-19 05:22:19.891029+07	\N	\N	\N
8515	454	113	d30245a4-7f14-402c-adb8-dd04f30f0f42	WRONG_ANSWER	5	1020	2026-06-19 05:22:19.891026+07	\N	\N	\N
8523	454	121	1fb50957-be1f-4a9c-9cce-d5c71d2d5d5f	WRONG_ANSWER	5	880	2026-06-19 05:22:19.891034+07	\N	\N	\N
8521	454	119	08a56213-4ea4-4089-b44e-2a235246ef9a	WRONG_ANSWER	16	1032	2026-06-19 05:22:19.891032+07	\N	\N	\N
8517	454	115	73e6806a-ce53-4224-9145-caa0c6878220	WRONG_ANSWER	7	980	2026-06-19 05:22:19.891028+07	\N	\N	\N
8522	454	120	d7e63dc7-c522-48e8-b6f3-42ec2a4612b1	WRONG_ANSWER	6	1040	2026-06-19 05:22:19.891033+07	\N	\N	\N
8516	454	114	4b244ac9-dd29-4a1b-bcd7-76b4acbdb5c6	WRONG_ANSWER	9	1004	2026-06-19 05:22:19.891027+07	\N	\N	\N
8520	454	118	27a69ad4-1c1a-4868-98f9-c9d670051ac5	WRONG_ANSWER	6	1048	2026-06-19 05:22:19.891031+07	\N	\N	\N
8530	454	128	72f9d5c2-2019-4b57-9c9f-483bb0ec2230	WRONG_ANSWER	8	868	2026-06-19 05:22:19.89104+07	\N	\N	\N
8525	454	123	ebc18b16-e522-40c1-9e4a-96efb04bb22e	WRONG_ANSWER	7	1028	2026-06-19 05:22:19.891036+07	\N	\N	\N
8524	454	122	b9f5d9d3-70bf-4c42-911d-c431ef9b0048	WRONG_ANSWER	8	1084	2026-06-19 05:22:19.891035+07	\N	\N	\N
8526	454	124	913aaf9e-b107-454a-9f32-691676c1d75c	WRONG_ANSWER	6	1140	2026-06-19 05:22:19.891036+07	\N	\N	\N
8528	454	126	5f63860d-540b-4414-a5c0-7be9e598335f	WRONG_ANSWER	14	1044	2026-06-19 05:22:19.891038+07	\N	\N	\N
8529	454	127	b7317e1c-7371-438f-ac8e-c643e8c4d600	WRONG_ANSWER	5	1012	2026-06-19 05:22:19.89104+07	\N	\N	\N
8527	454	125	9450e004-3624-4042-8a22-76a05231bcc1	WRONG_ANSWER	11	968	2026-06-19 05:22:19.891037+07	\N	\N	\N
8532	454	130	71211571-0433-45ea-b7ce-4b55d6caf1a9	WRONG_ANSWER	6	1024	2026-06-19 05:22:19.891042+07	\N	\N	\N
8531	454	129	43d7a31b-304f-452e-a293-b1f83dccbd75	WRONG_ANSWER	6	864	2026-06-19 05:22:19.891041+07	\N	\N	\N
8534	454	132	848ed4f4-0142-4958-a8fe-6814c2fe1f7b	WRONG_ANSWER	5	1056	2026-06-19 05:22:19.891044+07	\N	\N	\N
8533	454	131	78bbb10c-efa9-4c2b-911c-6d65d7a01b1c	WRONG_ANSWER	4	1008	2026-06-19 05:22:19.891043+07	\N	\N	\N
8537	454	135	41acbc5a-150d-49c2-8885-e9d69d585ef4	WRONG_ANSWER	5	868	2026-06-19 05:22:19.891047+07	\N	\N	\N
8536	454	134	15a6254b-329e-4c26-8338-fcc38d83cbbc	WRONG_ANSWER	4	1120	2026-06-19 05:22:19.891046+07	\N	\N	\N
8538	454	136	5e5a4b26-ac68-47f1-83d0-0a79a8908b07	WRONG_ANSWER	5	1020	2026-06-19 05:22:19.891048+07	\N	\N	\N
8535	454	133	3a6d3b9f-bcc7-4f5d-96c8-08523fc46bef	WRONG_ANSWER	6	924	2026-06-19 05:22:19.891045+07	\N	\N	\N
8539	454	137	f4b579b5-bf81-447b-9618-9e18bf3ecb60	WRONG_ANSWER	4	1056	2026-06-19 05:22:19.891049+07	\N	\N	\N
8540	454	138	dfff24ff-b190-4785-8735-67c02c34cf07	WRONG_ANSWER	3	1056	2026-06-19 05:22:19.89105+07	\N	\N	\N
8542	455	22	41838b4a-2aa5-4ce0-8a73-c53207b39260	WRONG_ANSWER	5	976	2026-06-19 05:22:34.210822+07	main.cpp:8:25: warning: integer constant is too large for its type\n    8 |     for(int i = 0; i >= 100000000000000000000000; i++)\n      |                         ^~~~~~~~~~~~~~~~~~~~~~~~\n	\N	\N
8547	455	27	56edf450-2881-4851-86bb-a8fa755bdfcc	WRONG_ANSWER	5	1032	2026-06-19 05:22:34.210824+07	main.cpp:8:25: warning: integer constant is too large for its type\n    8 |     for(int i = 0; i >= 100000000000000000000000; i++)\n      |                         ^~~~~~~~~~~~~~~~~~~~~~~~\n	\N	\N
8548	455	28	78fce747-37c3-4a05-9810-f7d5db839665	WRONG_ANSWER	5	1008	2026-06-19 05:22:34.210825+07	main.cpp:8:25: warning: integer constant is too large for its type\n    8 |     for(int i = 0; i >= 100000000000000000000000; i++)\n      |                         ^~~~~~~~~~~~~~~~~~~~~~~~\n	\N	\N
8545	455	25	ab4dade6-d85e-46d7-b414-56983b4957ad	WRONG_ANSWER	5	868	2026-06-19 05:22:34.210824+07	main.cpp:8:25: warning: integer constant is too large for its type\n    8 |     for(int i = 0; i >= 100000000000000000000000; i++)\n      |                         ^~~~~~~~~~~~~~~~~~~~~~~~\n	\N	\N
8544	455	24	0c253803-ffe6-420e-ae4b-2348dc144107	WRONG_ANSWER	8	1024	2026-06-19 05:22:34.210823+07	main.cpp:8:25: warning: integer constant is too large for its type\n    8 |     for(int i = 0; i >= 100000000000000000000000; i++)\n      |                         ^~~~~~~~~~~~~~~~~~~~~~~~\n	\N	\N
9052	461	30	b8461ea9-647e-4c61-955a-883be3a741c0	ACCEPTED	4	1092	2026-06-21 02:01:47.819798+07	\N	\N	0
8558	455	38	4e6bc542-ab5c-49e4-b565-532bcaac22f3	WRONG_ANSWER	5	1020	2026-06-19 05:22:34.210828+07	main.cpp:8:25: warning: integer constant is too large for its type\n    8 |     for(int i = 0; i >= 100000000000000000000000; i++)\n      |                         ^~~~~~~~~~~~~~~~~~~~~~~~\n	\N	\N
8557	455	37	124c70a0-f270-40ee-a72d-5a5de7f6cf87	WRONG_ANSWER	6	992	2026-06-19 05:22:34.210828+07	main.cpp:8:25: warning: integer constant is too large for its type\n    8 |     for(int i = 0; i >= 100000000000000000000000; i++)\n      |                         ^~~~~~~~~~~~~~~~~~~~~~~~\n	\N	\N
8563	455	61	f3a78aa8-c272-4429-8479-2f5b34c6b3f1	WRONG_ANSWER	7	1232	2026-06-19 05:22:34.21083+07	main.cpp:8:25: warning: integer constant is too large for its type\n    8 |     for(int i = 0; i >= 100000000000000000000000; i++)\n      |                         ^~~~~~~~~~~~~~~~~~~~~~~~\n	\N	\N
8561	455	59	1c6cbc73-8175-4e48-8cb6-564a9f462075	WRONG_ANSWER	6	1024	2026-06-19 05:22:34.210829+07	main.cpp:8:25: warning: integer constant is too large for its type\n    8 |     for(int i = 0; i >= 100000000000000000000000; i++)\n      |                         ^~~~~~~~~~~~~~~~~~~~~~~~\n	\N	\N
8566	455	64	b1345429-0577-40fc-b0b7-10119c71e902	WRONG_ANSWER	5	1024	2026-06-19 05:22:34.210831+07	main.cpp:8:25: warning: integer constant is too large for its type\n    8 |     for(int i = 0; i >= 100000000000000000000000; i++)\n      |                         ^~~~~~~~~~~~~~~~~~~~~~~~\n	\N	\N
8575	455	73	e4653c05-421c-42c0-9f33-c5ef42f60be0	WRONG_ANSWER	5	1020	2026-06-19 05:22:34.210835+07	main.cpp:8:25: warning: integer constant is too large for its type\n    8 |     for(int i = 0; i >= 100000000000000000000000; i++)\n      |                         ^~~~~~~~~~~~~~~~~~~~~~~~\n	\N	\N
8573	455	71	043f0864-6252-4022-9d00-b3c5a1a6a375	WRONG_ANSWER	9	1040	2026-06-19 05:22:34.210833+07	main.cpp:8:25: warning: integer constant is too large for its type\n    8 |     for(int i = 0; i >= 100000000000000000000000; i++)\n      |                         ^~~~~~~~~~~~~~~~~~~~~~~~\n	\N	\N
8580	455	78	8fdd1322-e375-4fed-9377-5c25f26e4eb6	WRONG_ANSWER	6	980	2026-06-19 05:22:34.210836+07	main.cpp:8:25: warning: integer constant is too large for its type\n    8 |     for(int i = 0; i >= 100000000000000000000000; i++)\n      |                         ^~~~~~~~~~~~~~~~~~~~~~~~\n	\N	\N
8569	455	67	1b44f89a-4c3d-47d5-81b6-6e70e07e4541	WRONG_ANSWER	9	1028	2026-06-19 05:22:34.210832+07	main.cpp:8:25: warning: integer constant is too large for its type\n    8 |     for(int i = 0; i >= 100000000000000000000000; i++)\n      |                         ^~~~~~~~~~~~~~~~~~~~~~~~\n	\N	\N
8578	455	76	2f014862-066c-419c-a502-c123dedba88e	WRONG_ANSWER	5	1076	2026-06-19 05:22:34.210835+07	main.cpp:8:25: warning: integer constant is too large for its type\n    8 |     for(int i = 0; i >= 100000000000000000000000; i++)\n      |                         ^~~~~~~~~~~~~~~~~~~~~~~~\n	\N	\N
8588	455	86	66380538-60f6-4dbf-b55c-e3a038ce16d1	WRONG_ANSWER	10	828	2026-06-19 05:22:34.210839+07	main.cpp:8:25: warning: integer constant is too large for its type\n    8 |     for(int i = 0; i >= 100000000000000000000000; i++)\n      |                         ^~~~~~~~~~~~~~~~~~~~~~~~\n	\N	\N
8582	455	80	ce40218d-3c80-40d7-ad99-c0312ca9c49e	WRONG_ANSWER	4	1036	2026-06-19 05:22:34.210837+07	main.cpp:8:25: warning: integer constant is too large for its type\n    8 |     for(int i = 0; i >= 100000000000000000000000; i++)\n      |                         ^~~~~~~~~~~~~~~~~~~~~~~~\n	\N	\N
8586	455	84	44e59f00-4973-4fff-9410-c50dfb4f59f7	WRONG_ANSWER	5	1024	2026-06-19 05:22:34.210838+07	main.cpp:8:25: warning: integer constant is too large for its type\n    8 |     for(int i = 0; i >= 100000000000000000000000; i++)\n      |                         ^~~~~~~~~~~~~~~~~~~~~~~~\n	\N	\N
8595	455	93	794d0c22-b672-4b46-89cb-6d4ab1b7fd75	WRONG_ANSWER	5	1088	2026-06-19 05:22:34.210842+07	main.cpp:8:25: warning: integer constant is too large for its type\n    8 |     for(int i = 0; i >= 100000000000000000000000; i++)\n      |                         ^~~~~~~~~~~~~~~~~~~~~~~~\n	\N	\N
8589	455	87	e7c1fe24-7700-474e-8a09-b8f93601a2a0	WRONG_ANSWER	8	1016	2026-06-19 05:22:34.210839+07	main.cpp:8:25: warning: integer constant is too large for its type\n    8 |     for(int i = 0; i >= 100000000000000000000000; i++)\n      |                         ^~~~~~~~~~~~~~~~~~~~~~~~\n	\N	\N
8602	455	100	c8628fba-8140-4df6-8fc8-270655db3b67	WRONG_ANSWER	5	1024	2026-06-19 05:22:34.210844+07	main.cpp:8:25: warning: integer constant is too large for its type\n    8 |     for(int i = 0; i >= 100000000000000000000000; i++)\n      |                         ^~~~~~~~~~~~~~~~~~~~~~~~\n	\N	\N
8601	455	99	861ac42b-0464-4eee-8035-f729ff028080	WRONG_ANSWER	6	1040	2026-06-19 05:22:34.210844+07	main.cpp:8:25: warning: integer constant is too large for its type\n    8 |     for(int i = 0; i >= 100000000000000000000000; i++)\n      |                         ^~~~~~~~~~~~~~~~~~~~~~~~\n	\N	\N
8605	455	103	d8c142d1-5e08-416d-be2e-92e4b373ad9c	WRONG_ANSWER	6	1032	2026-06-19 05:22:34.210845+07	main.cpp:8:25: warning: integer constant is too large for its type\n    8 |     for(int i = 0; i >= 100000000000000000000000; i++)\n      |                         ^~~~~~~~~~~~~~~~~~~~~~~~\n	\N	\N
8608	455	106	1d40c003-3876-4e74-98b5-c9386f04443e	WRONG_ANSWER	7	876	2026-06-19 05:22:34.210846+07	main.cpp:8:25: warning: integer constant is too large for its type\n    8 |     for(int i = 0; i >= 100000000000000000000000; i++)\n      |                         ^~~~~~~~~~~~~~~~~~~~~~~~\n	\N	\N
8609	455	107	640719d8-7e69-4bbc-a26a-4eda93825d78	WRONG_ANSWER	5	864	2026-06-19 05:22:34.210846+07	main.cpp:8:25: warning: integer constant is too large for its type\n    8 |     for(int i = 0; i >= 100000000000000000000000; i++)\n      |                         ^~~~~~~~~~~~~~~~~~~~~~~~\n	\N	\N
8607	455	105	c7b91fe5-d73b-42b8-bd74-b7c3d1a77447	WRONG_ANSWER	7	972	2026-06-19 05:22:34.210846+07	main.cpp:8:25: warning: integer constant is too large for its type\n    8 |     for(int i = 0; i >= 100000000000000000000000; i++)\n      |                         ^~~~~~~~~~~~~~~~~~~~~~~~\n	\N	\N
8617	455	115	a4a7f8be-deed-47af-b4c8-8342cb4061e8	WRONG_ANSWER	6	1020	2026-06-19 05:22:34.210849+07	main.cpp:8:25: warning: integer constant is too large for its type\n    8 |     for(int i = 0; i >= 100000000000000000000000; i++)\n      |                         ^~~~~~~~~~~~~~~~~~~~~~~~\n	\N	\N
8619	455	117	ccfad7a8-9eb6-405e-a647-a40aacd8c262	WRONG_ANSWER	7	984	2026-06-19 05:22:34.21085+07	main.cpp:8:25: warning: integer constant is too large for its type\n    8 |     for(int i = 0; i >= 100000000000000000000000; i++)\n      |                         ^~~~~~~~~~~~~~~~~~~~~~~~\n	\N	\N
8620	455	118	3370c422-8943-4a29-857e-387f6be87ba8	WRONG_ANSWER	5	1032	2026-06-19 05:22:34.21085+07	main.cpp:8:25: warning: integer constant is too large for its type\n    8 |     for(int i = 0; i >= 100000000000000000000000; i++)\n      |                         ^~~~~~~~~~~~~~~~~~~~~~~~\n	\N	\N
8549	455	29	73dc3afc-b904-416a-9572-d74281248704	WRONG_ANSWER	5	868	2026-06-19 05:22:34.210825+07	main.cpp:8:25: warning: integer constant is too large for its type\n    8 |     for(int i = 0; i >= 100000000000000000000000; i++)\n      |                         ^~~~~~~~~~~~~~~~~~~~~~~~\n	\N	\N
8552	455	32	dbb142a9-4ebb-42ff-9eb2-9f82b593228a	WRONG_ANSWER	5	1020	2026-06-19 05:22:34.210826+07	main.cpp:8:25: warning: integer constant is too large for its type\n    8 |     for(int i = 0; i >= 100000000000000000000000; i++)\n      |                         ^~~~~~~~~~~~~~~~~~~~~~~~\n	\N	\N
8556	455	36	fe078574-6fcd-4a2f-98df-fcb1671075ac	WRONG_ANSWER	7	1040	2026-06-19 05:22:34.210827+07	main.cpp:8:25: warning: integer constant is too large for its type\n    8 |     for(int i = 0; i >= 100000000000000000000000; i++)\n      |                         ^~~~~~~~~~~~~~~~~~~~~~~~\n	\N	\N
8560	455	58	4ba09024-4ac2-484e-a99a-ed6597b5bc53	WRONG_ANSWER	5	1016	2026-06-19 05:22:34.210829+07	main.cpp:8:25: warning: integer constant is too large for its type\n    8 |     for(int i = 0; i >= 100000000000000000000000; i++)\n      |                         ^~~~~~~~~~~~~~~~~~~~~~~~\n	\N	\N
8550	455	30	2c4f79bf-fb82-431f-b5f8-e3880771fe1e	WRONG_ANSWER	9	1016	2026-06-19 05:22:34.210825+07	main.cpp:8:25: warning: integer constant is too large for its type\n    8 |     for(int i = 0; i >= 100000000000000000000000; i++)\n      |                         ^~~~~~~~~~~~~~~~~~~~~~~~\n	\N	\N
8559	455	57	68e0423f-b4ab-401f-bc3b-cd74c7c81121	WRONG_ANSWER	7	988	2026-06-19 05:22:34.210829+07	main.cpp:8:25: warning: integer constant is too large for its type\n    8 |     for(int i = 0; i >= 100000000000000000000000; i++)\n      |                         ^~~~~~~~~~~~~~~~~~~~~~~~\n	\N	\N
8546	455	26	65b9f19e-5413-4536-aac8-84d040030dee	WRONG_ANSWER	11	880	2026-06-19 05:22:34.210824+07	main.cpp:8:25: warning: integer constant is too large for its type\n    8 |     for(int i = 0; i >= 100000000000000000000000; i++)\n      |                         ^~~~~~~~~~~~~~~~~~~~~~~~\n	\N	\N
8551	455	31	30b1806f-484d-418d-bc19-35f77e78eecf	WRONG_ANSWER	9	1008	2026-06-19 05:22:34.210826+07	main.cpp:8:25: warning: integer constant is too large for its type\n    8 |     for(int i = 0; i >= 100000000000000000000000; i++)\n      |                         ^~~~~~~~~~~~~~~~~~~~~~~~\n	\N	\N
8555	455	35	175185c9-ca7a-4db7-ab37-4bf64d49107d	WRONG_ANSWER	8	880	2026-06-19 05:22:34.210827+07	main.cpp:8:25: warning: integer constant is too large for its type\n    8 |     for(int i = 0; i >= 100000000000000000000000; i++)\n      |                         ^~~~~~~~~~~~~~~~~~~~~~~~\n	\N	\N
8564	455	62	0e35f1ef-b8cc-42c5-92b1-5dbef690dde0	WRONG_ANSWER	8	1020	2026-06-19 05:22:34.21083+07	main.cpp:8:25: warning: integer constant is too large for its type\n    8 |     for(int i = 0; i >= 100000000000000000000000; i++)\n      |                         ^~~~~~~~~~~~~~~~~~~~~~~~\n	\N	\N
8553	455	33	b582f2d0-264b-427f-86a3-537e4c5cc44b	WRONG_ANSWER	5	1020	2026-06-19 05:22:34.210826+07	main.cpp:8:25: warning: integer constant is too large for its type\n    8 |     for(int i = 0; i >= 100000000000000000000000; i++)\n      |                         ^~~~~~~~~~~~~~~~~~~~~~~~\n	\N	\N
8554	455	34	3f97ba46-28f1-422a-8c9a-f7721ed803cb	WRONG_ANSWER	7	980	2026-06-19 05:22:34.210827+07	main.cpp:8:25: warning: integer constant is too large for its type\n    8 |     for(int i = 0; i >= 100000000000000000000000; i++)\n      |                         ^~~~~~~~~~~~~~~~~~~~~~~~\n	\N	\N
8568	455	66	bba5eee4-6f4c-40ed-8a61-b3117dc45a97	WRONG_ANSWER	7	1020	2026-06-19 05:22:34.210832+07	main.cpp:8:25: warning: integer constant is too large for its type\n    8 |     for(int i = 0; i >= 100000000000000000000000; i++)\n      |                         ^~~~~~~~~~~~~~~~~~~~~~~~\n	\N	\N
8571	455	69	a6153875-aaed-4cf9-8350-ec6f4f389025	WRONG_ANSWER	10	1020	2026-06-19 05:22:34.210833+07	main.cpp:8:25: warning: integer constant is too large for its type\n    8 |     for(int i = 0; i >= 100000000000000000000000; i++)\n      |                         ^~~~~~~~~~~~~~~~~~~~~~~~\n	\N	\N
8570	455	68	6491c171-e590-48de-87e3-e01dd2926629	WRONG_ANSWER	9	1088	2026-06-19 05:22:34.210833+07	main.cpp:8:25: warning: integer constant is too large for its type\n    8 |     for(int i = 0; i >= 100000000000000000000000; i++)\n      |                         ^~~~~~~~~~~~~~~~~~~~~~~~\n	\N	\N
8579	455	77	cae9cb08-f700-440b-9fae-e1bc69e401b4	WRONG_ANSWER	6	1008	2026-06-19 05:22:34.210836+07	main.cpp:8:25: warning: integer constant is too large for its type\n    8 |     for(int i = 0; i >= 100000000000000000000000; i++)\n      |                         ^~~~~~~~~~~~~~~~~~~~~~~~\n	\N	\N
8572	455	70	4a87391d-727b-4974-9006-9d6c9220f254	WRONG_ANSWER	15	924	2026-06-19 05:22:34.210833+07	main.cpp:8:25: warning: integer constant is too large for its type\n    8 |     for(int i = 0; i >= 100000000000000000000000; i++)\n      |                         ^~~~~~~~~~~~~~~~~~~~~~~~\n	\N	\N
8567	455	65	620f6392-a42d-4f86-b906-efadfbb73219	WRONG_ANSWER	6	860	2026-06-19 05:22:34.210831+07	main.cpp:8:25: warning: integer constant is too large for its type\n    8 |     for(int i = 0; i >= 100000000000000000000000; i++)\n      |                         ^~~~~~~~~~~~~~~~~~~~~~~~\n	\N	\N
8624	455	122	53d42415-7464-47aa-a996-4750839e99d5	WRONG_ANSWER	5	876	2026-06-19 05:22:34.210852+07	main.cpp:8:25: warning: integer constant is too large for its type\n    8 |     for(int i = 0; i >= 100000000000000000000000; i++)\n      |                         ^~~~~~~~~~~~~~~~~~~~~~~~\n	\N	\N
8626	455	124	821a86b6-1ea1-45c5-8a3e-f8615793b656	WRONG_ANSWER	7	1020	2026-06-19 05:22:34.210852+07	main.cpp:8:25: warning: integer constant is too large for its type\n    8 |     for(int i = 0; i >= 100000000000000000000000; i++)\n      |                         ^~~~~~~~~~~~~~~~~~~~~~~~\n	\N	\N
8631	455	129	b3a6a60d-e7e3-4dfe-ae1c-0006d8380492	WRONG_ANSWER	5	836	2026-06-19 05:22:34.210854+07	main.cpp:8:25: warning: integer constant is too large for its type\n    8 |     for(int i = 0; i >= 100000000000000000000000; i++)\n      |                         ^~~~~~~~~~~~~~~~~~~~~~~~\n	\N	\N
8630	455	128	e3a96cba-d0e8-432b-86ac-4140b57d84ac	WRONG_ANSWER	5	864	2026-06-19 05:22:34.210854+07	main.cpp:8:25: warning: integer constant is too large for its type\n    8 |     for(int i = 0; i >= 100000000000000000000000; i++)\n      |                         ^~~~~~~~~~~~~~~~~~~~~~~~\n	\N	\N
8629	455	127	f4475b68-0a88-4de3-ad6f-f062b7969b81	WRONG_ANSWER	5	1016	2026-06-19 05:22:34.210853+07	main.cpp:8:25: warning: integer constant is too large for its type\n    8 |     for(int i = 0; i >= 100000000000000000000000; i++)\n      |                         ^~~~~~~~~~~~~~~~~~~~~~~~\n	\N	\N
8638	455	136	eee3c2a5-93b5-496b-9de4-31eed5b93f49	WRONG_ANSWER	4	1112	2026-06-19 05:22:34.21086+07	main.cpp:8:25: warning: integer constant is too large for its type\n    8 |     for(int i = 0; i >= 100000000000000000000000; i++)\n      |                         ^~~~~~~~~~~~~~~~~~~~~~~~\n	\N	\N
8639	455	137	4309d055-0f6a-45ef-b12e-6a7c5592c909	WRONG_ANSWER	3	1048	2026-06-19 05:22:34.21086+07	main.cpp:8:25: warning: integer constant is too large for its type\n    8 |     for(int i = 0; i >= 100000000000000000000000; i++)\n      |                         ^~~~~~~~~~~~~~~~~~~~~~~~\n	\N	\N
8576	455	74	1a5b9cfb-9c9f-4aa2-85f2-637bc75c97c9	WRONG_ANSWER	5	1028	2026-06-19 05:22:34.210835+07	main.cpp:8:25: warning: integer constant is too large for its type\n    8 |     for(int i = 0; i >= 100000000000000000000000; i++)\n      |                         ^~~~~~~~~~~~~~~~~~~~~~~~\n	\N	\N
8581	455	79	ceddb391-35cf-4a56-aa84-1f41f9b96331	WRONG_ANSWER	13	960	2026-06-19 05:22:34.210837+07	main.cpp:8:25: warning: integer constant is too large for its type\n    8 |     for(int i = 0; i >= 100000000000000000000000; i++)\n      |                         ^~~~~~~~~~~~~~~~~~~~~~~~\n	\N	\N
8583	455	81	4485f550-9859-42b1-bedf-a41d99e1c421	WRONG_ANSWER	5	1080	2026-06-19 05:22:34.210837+07	main.cpp:8:25: warning: integer constant is too large for its type\n    8 |     for(int i = 0; i >= 100000000000000000000000; i++)\n      |                         ^~~~~~~~~~~~~~~~~~~~~~~~\n	\N	\N
8584	455	82	7cf93c0a-3fde-4d50-8541-a2879baf887d	WRONG_ANSWER	9	1080	2026-06-19 05:22:34.210838+07	main.cpp:8:25: warning: integer constant is too large for its type\n    8 |     for(int i = 0; i >= 100000000000000000000000; i++)\n      |                         ^~~~~~~~~~~~~~~~~~~~~~~~\n	\N	\N
8574	455	72	b016f31f-7e99-4a29-911c-321ccf228ab8	WRONG_ANSWER	5	1016	2026-06-19 05:22:34.210834+07	main.cpp:8:25: warning: integer constant is too large for its type\n    8 |     for(int i = 0; i >= 100000000000000000000000; i++)\n      |                         ^~~~~~~~~~~~~~~~~~~~~~~~\n	\N	\N
8577	455	75	4eb021d9-2f5c-4a43-9350-2613db152949	WRONG_ANSWER	6	1028	2026-06-19 05:22:34.210835+07	main.cpp:8:25: warning: integer constant is too large for its type\n    8 |     for(int i = 0; i >= 100000000000000000000000; i++)\n      |                         ^~~~~~~~~~~~~~~~~~~~~~~~\n	\N	\N
8585	455	83	fc7b4c37-efba-45e6-9534-3ccff2c517d0	WRONG_ANSWER	6	1088	2026-06-19 05:22:34.210838+07	main.cpp:8:25: warning: integer constant is too large for its type\n    8 |     for(int i = 0; i >= 100000000000000000000000; i++)\n      |                         ^~~~~~~~~~~~~~~~~~~~~~~~\n	\N	\N
8587	455	85	2f1055f9-ca12-4a0d-bd5f-4d92b57f2114	WRONG_ANSWER	5	1020	2026-06-19 05:22:34.210839+07	main.cpp:8:25: warning: integer constant is too large for its type\n    8 |     for(int i = 0; i >= 100000000000000000000000; i++)\n      |                         ^~~~~~~~~~~~~~~~~~~~~~~~\n	\N	\N
8590	455	88	9d785ff6-b41a-447d-8e52-9f34eac529cc	WRONG_ANSWER	6	832	2026-06-19 05:22:34.21084+07	main.cpp:8:25: warning: integer constant is too large for its type\n    8 |     for(int i = 0; i >= 100000000000000000000000; i++)\n      |                         ^~~~~~~~~~~~~~~~~~~~~~~~\n	\N	\N
8593	455	91	c3324cad-69e0-4434-8dd9-79f6784f55c8	WRONG_ANSWER	8	996	2026-06-19 05:22:34.210841+07	main.cpp:8:25: warning: integer constant is too large for its type\n    8 |     for(int i = 0; i >= 100000000000000000000000; i++)\n      |                         ^~~~~~~~~~~~~~~~~~~~~~~~\n	\N	\N
8594	455	92	f0a5c326-0924-48f0-886f-f8f9c41dc36d	WRONG_ANSWER	7	1088	2026-06-19 05:22:34.210841+07	main.cpp:8:25: warning: integer constant is too large for its type\n    8 |     for(int i = 0; i >= 100000000000000000000000; i++)\n      |                         ^~~~~~~~~~~~~~~~~~~~~~~~\n	\N	\N
8591	455	89	514c69c8-98c1-4931-8cc7-fb6f8093544a	WRONG_ANSWER	5	1084	2026-06-19 05:22:34.21084+07	main.cpp:8:25: warning: integer constant is too large for its type\n    8 |     for(int i = 0; i >= 100000000000000000000000; i++)\n      |                         ^~~~~~~~~~~~~~~~~~~~~~~~\n	\N	\N
8598	455	96	d5589cd0-7dd6-49a6-ba80-72a536fa908e	WRONG_ANSWER	5	868	2026-06-19 05:22:34.210843+07	main.cpp:8:25: warning: integer constant is too large for its type\n    8 |     for(int i = 0; i >= 100000000000000000000000; i++)\n      |                         ^~~~~~~~~~~~~~~~~~~~~~~~\n	\N	\N
8600	455	98	0307e5e1-2a18-4ec3-a193-f416bb485c32	WRONG_ANSWER	7	876	2026-06-19 05:22:34.210843+07	main.cpp:8:25: warning: integer constant is too large for its type\n    8 |     for(int i = 0; i >= 100000000000000000000000; i++)\n      |                         ^~~~~~~~~~~~~~~~~~~~~~~~\n	\N	\N
8596	455	94	a42ed063-14d5-460c-8384-886e8099ab63	WRONG_ANSWER	9	1012	2026-06-19 05:22:34.210842+07	main.cpp:8:25: warning: integer constant is too large for its type\n    8 |     for(int i = 0; i >= 100000000000000000000000; i++)\n      |                         ^~~~~~~~~~~~~~~~~~~~~~~~\n	\N	\N
8592	455	90	a8ba9a7a-9034-4e00-a195-9a16e7d6ec67	WRONG_ANSWER	9	908	2026-06-19 05:22:34.210841+07	main.cpp:8:25: warning: integer constant is too large for its type\n    8 |     for(int i = 0; i >= 100000000000000000000000; i++)\n      |                         ^~~~~~~~~~~~~~~~~~~~~~~~\n	\N	\N
8610	455	108	04c77e2e-10ce-4b00-8aa9-29477d62e440	WRONG_ANSWER	6	1004	2026-06-19 05:22:34.210847+07	main.cpp:8:25: warning: integer constant is too large for its type\n    8 |     for(int i = 0; i >= 100000000000000000000000; i++)\n      |                         ^~~~~~~~~~~~~~~~~~~~~~~~\n	\N	\N
8606	455	104	d7abfff2-2365-4bf5-9b4b-e4fa99cd0e96	WRONG_ANSWER	5	1028	2026-06-19 05:22:34.210845+07	main.cpp:8:25: warning: integer constant is too large for its type\n    8 |     for(int i = 0; i >= 100000000000000000000000; i++)\n      |                         ^~~~~~~~~~~~~~~~~~~~~~~~\n	\N	\N
8603	455	101	b8f3a5cf-c6b8-4492-8f5b-4b4a36b63393	WRONG_ANSWER	10	952	2026-06-19 05:22:34.210844+07	main.cpp:8:25: warning: integer constant is too large for its type\n    8 |     for(int i = 0; i >= 100000000000000000000000; i++)\n      |                         ^~~~~~~~~~~~~~~~~~~~~~~~\n	\N	\N
8611	455	109	2c52f299-28b3-4c1e-9c7c-903046a7a9c6	WRONG_ANSWER	6	840	2026-06-19 05:22:34.210847+07	main.cpp:8:25: warning: integer constant is too large for its type\n    8 |     for(int i = 0; i >= 100000000000000000000000; i++)\n      |                         ^~~~~~~~~~~~~~~~~~~~~~~~\n	\N	\N
8613	455	111	c37b0741-645f-4faa-999b-ca27f9a3b0f0	WRONG_ANSWER	7	976	2026-06-19 05:22:34.210848+07	main.cpp:8:25: warning: integer constant is too large for its type\n    8 |     for(int i = 0; i >= 100000000000000000000000; i++)\n      |                         ^~~~~~~~~~~~~~~~~~~~~~~~\n	\N	\N
8616	455	114	36a11658-0a92-4204-bab7-0f140c55dc8c	WRONG_ANSWER	5	1020	2026-06-19 05:22:34.210849+07	main.cpp:8:25: warning: integer constant is too large for its type\n    8 |     for(int i = 0; i >= 100000000000000000000000; i++)\n      |                         ^~~~~~~~~~~~~~~~~~~~~~~~\n	\N	\N
8614	455	112	0bdb424e-abc0-40f5-8cd9-a595a149fef8	WRONG_ANSWER	5	1000	2026-06-19 05:22:34.210848+07	main.cpp:8:25: warning: integer constant is too large for its type\n    8 |     for(int i = 0; i >= 100000000000000000000000; i++)\n      |                         ^~~~~~~~~~~~~~~~~~~~~~~~\n	\N	\N
8622	455	120	347776e8-2ce0-4757-b4b1-85b2dcf5f2d2	WRONG_ANSWER	8	1096	2026-06-19 05:22:34.210851+07	main.cpp:8:25: warning: integer constant is too large for its type\n    8 |     for(int i = 0; i >= 100000000000000000000000; i++)\n      |                         ^~~~~~~~~~~~~~~~~~~~~~~~\n	\N	\N
8618	455	116	7dbdea82-c18e-4624-9c29-2ab36b0c2404	WRONG_ANSWER	5	1032	2026-06-19 05:22:34.21085+07	main.cpp:8:25: warning: integer constant is too large for its type\n    8 |     for(int i = 0; i >= 100000000000000000000000; i++)\n      |                         ^~~~~~~~~~~~~~~~~~~~~~~~\n	\N	\N
8691	456	89	98cba2ca-9eb6-432d-b07d-dc28c7e07ed1	ACCEPTED	5	1032	2026-06-21 01:22:53.469499+07	\N	\N	-902015
8599	455	97	7185f6d0-29a3-4e34-80e8-216b9cf15ec8	WRONG_ANSWER	5	1016	2026-06-19 05:22:34.210843+07	main.cpp:8:25: warning: integer constant is too large for its type\n    8 |     for(int i = 0; i >= 100000000000000000000000; i++)\n      |                         ^~~~~~~~~~~~~~~~~~~~~~~~\n	\N	\N
8597	455	95	54b8c9da-6ff0-4e47-9219-462842fcdc2e	WRONG_ANSWER	7	828	2026-06-19 05:22:34.210842+07	main.cpp:8:25: warning: integer constant is too large for its type\n    8 |     for(int i = 0; i >= 100000000000000000000000; i++)\n      |                         ^~~~~~~~~~~~~~~~~~~~~~~~\n	\N	\N
8625	455	123	b1c43e15-994e-4995-a7c6-4fac2eecb29e	WRONG_ANSWER	5	1020	2026-06-19 05:22:34.210852+07	main.cpp:8:25: warning: integer constant is too large for its type\n    8 |     for(int i = 0; i >= 100000000000000000000000; i++)\n      |                         ^~~~~~~~~~~~~~~~~~~~~~~~\n	\N	\N
8627	455	125	a828475b-dd46-41f1-b677-265b4c6a5af5	WRONG_ANSWER	6	824	2026-06-19 05:22:34.210853+07	main.cpp:8:25: warning: integer constant is too large for its type\n    8 |     for(int i = 0; i >= 100000000000000000000000; i++)\n      |                         ^~~~~~~~~~~~~~~~~~~~~~~~\n	\N	\N
8634	455	132	4eb07cdc-febe-4148-8428-7494afedc2e4	WRONG_ANSWER	4	1056	2026-06-19 05:22:34.210855+07	main.cpp:8:25: warning: integer constant is too large for its type\n    8 |     for(int i = 0; i >= 100000000000000000000000; i++)\n      |                         ^~~~~~~~~~~~~~~~~~~~~~~~\n	\N	\N
8637	455	135	2300fdac-2076-488a-8dc0-110c03efa268	WRONG_ANSWER	3	1032	2026-06-19 05:22:34.210856+07	main.cpp:8:25: warning: integer constant is too large for its type\n    8 |     for(int i = 0; i >= 100000000000000000000000; i++)\n      |                         ^~~~~~~~~~~~~~~~~~~~~~~~\n	\N	\N
9059	461	37	783688bb-d962-4cbd-a29d-54b85d58abbb	ACCEPTED	5	836	2026-06-21 02:01:47.819816+07	\N	\N	1000
9058	461	36	f018308d-ac39-44b3-9210-3b31632ddc43	ACCEPTED	5	1080	2026-06-21 02:01:47.819813+07	\N	\N	801
9061	461	57	3f59db2d-7378-429c-9289-c63033aee548	ACCEPTED	5	1028	2026-06-21 02:01:47.819821+07	\N	\N	787228
9065	461	61	6e13f33d-ccfc-45e8-9810-b07fa90e180f	ACCEPTED	4	888	2026-06-21 02:01:47.819831+07	\N	\N	879721
9064	461	60	8cb84113-b309-43b7-be01-4b1717e2405f	ACCEPTED	4	1012	2026-06-21 02:01:47.819829+07	\N	\N	380371
9063	461	59	daa0a94c-b1ae-4c5a-a62a-3909898a8c4c	ACCEPTED	4	1028	2026-06-21 02:01:47.819826+07	\N	\N	545178
9062	461	58	1917102b-701f-40ea-95ee-c1e8acfc192b	ACCEPTED	5	1032	2026-06-21 02:01:47.819824+07	\N	\N	803799
9056	461	34	75c74fa2-d5e0-43b5-9ae0-a3a22fa61363	ACCEPTED	5	1020	2026-06-21 02:01:47.819808+07	\N	\N	15
9055	461	33	993c1453-3cf9-44b3-882d-ebc89e405ded	ACCEPTED	5	820	2026-06-21 02:01:47.819806+07	\N	\N	84
9066	461	62	14a092d2-f3f5-4048-8e5e-ff2343e9543e	ACCEPTED	4	1092	2026-06-21 02:01:47.819834+07	\N	\N	1486218
9068	461	64	092a82c4-40d1-4450-b392-962598cdfd6a	ACCEPTED	7	996	2026-06-21 02:01:47.819839+07	\N	\N	710339
9070	461	66	95b240a5-dec5-42a6-82a6-0d6380d0adbe	ACCEPTED	8	1016	2026-06-21 02:01:47.819875+07	\N	\N	129492
9069	461	65	134ea8c1-030e-40ea-b928-3634b7ffc9f1	ACCEPTED	4	1024	2026-06-21 02:01:47.819841+07	\N	\N	475745
9075	461	71	695ab73f-8d4b-4f5e-b83f-0c6d8702bf2f	ACCEPTED	4	1020	2026-06-21 02:01:47.81989+07	\N	\N	1416847
9071	461	67	21ad7f80-8726-4f7d-8859-b01bc6d2a1d0	ACCEPTED	5	1028	2026-06-21 02:01:47.819879+07	\N	\N	473222
9072	461	68	a1c542b9-8ee6-46bb-9a10-e87bf3394c64	ACCEPTED	5	1076	2026-06-21 02:01:47.819881+07	\N	\N	1161167
9082	461	78	4f079905-2851-4479-ad19-4b8098e8c7d8	ACCEPTED	5	1024	2026-06-21 02:01:47.819908+07	\N	\N	-824805
9077	461	73	4032be78-3c24-4fef-aaeb-ea3e26abe507	ACCEPTED	5	1028	2026-06-21 02:01:47.819895+07	\N	\N	702179
9079	461	75	3ab44bc2-3820-41bc-8859-1287859a0bf6	ACCEPTED	4	1036	2026-06-21 02:01:47.8199+07	\N	\N	1760278
9073	461	69	9edd9422-aa2b-4dca-94e6-dbee19502ad7	ACCEPTED	5	1020	2026-06-21 02:01:47.819884+07	\N	\N	616334
9074	461	70	bace7521-54d3-4a4d-b013-46f09ec1dcf7	ACCEPTED	5	1020	2026-06-21 02:01:47.819888+07	\N	\N	959298
9078	461	74	e2bf2b0f-9fc5-4f79-9f34-52ca771fcbe4	ACCEPTED	5	872	2026-06-21 02:01:47.819898+07	\N	\N	909595
9085	461	81	73935b2b-acb6-4233-8481-e2058c708a41	ACCEPTED	4	1024	2026-06-21 02:01:47.819921+07	\N	\N	-846475
9088	461	84	b5e6b730-557d-479f-ab2c-4a92f772ac11	ACCEPTED	4	868	2026-06-21 02:01:47.819929+07	\N	\N	-734921
9083	461	79	3eb877fb-5c8a-4ac1-b93b-5260fafff803	ACCEPTED	6	984	2026-06-21 02:01:47.81991+07	\N	\N	-1351853
9086	461	82	2749479d-4bf1-4765-b3c3-a6c2b5a38e3c	ACCEPTED	5	864	2026-06-21 02:01:47.819924+07	\N	\N	-1795574
9089	461	85	d43aad00-ecd2-4f36-8205-8b19c08406c3	ACCEPTED	4	1020	2026-06-21 02:01:47.819932+07	\N	\N	-1006285
9084	461	80	aa0bc312-0b3c-4e00-9c99-c8aa6fefe414	ACCEPTED	6	1024	2026-06-21 02:01:47.819913+07	\N	\N	-1611196
9087	461	83	9480b2d7-f7a0-4e76-bb17-fcf6c548ab84	ACCEPTED	5	1084	2026-06-21 02:01:47.819927+07	\N	\N	-1500204
9092	461	88	619d0014-c4af-467a-b178-7b0b05d5eb47	ACCEPTED	5	1084	2026-06-21 02:01:47.819939+07	\N	\N	-955984
9096	461	92	f246c8f5-88a3-4ca9-ad0a-39f20472e5b0	ACCEPTED	4	1024	2026-06-21 02:01:47.81995+07	\N	\N	-471131
9093	461	89	b6713e6b-2075-426e-86cd-d5bbcc092e81	ACCEPTED	5	872	2026-06-21 02:01:47.819942+07	\N	\N	-902015
9091	461	87	fbfce618-df57-4ec5-b016-5ad83ee3439b	ACCEPTED	5	1084	2026-06-21 02:01:47.819937+07	\N	\N	-1189260
9094	461	90	8980568a-bc75-420b-9d14-867fc2e0e3cd	ACCEPTED	6	868	2026-06-21 02:01:47.819945+07	\N	\N	-1520451
9102	461	98	ddf54d4f-733a-43c9-bb39-8a4b5222d28d	ACCEPTED	6	1028	2026-06-21 02:01:47.819979+07	\N	\N	99178
9104	461	100	28495f51-707d-403b-b2a4-00170eabe8b6	ACCEPTED	7	1012	2026-06-21 02:01:47.819984+07	\N	\N	281928
9101	461	97	e9b44d85-8d81-4bd3-8497-5f7100e0c04a	ACCEPTED	4	864	2026-06-21 02:01:47.819976+07	\N	\N	-517131
9097	461	93	fd691147-b65e-4c9a-a489-0ff7f653be84	ACCEPTED	5	1024	2026-06-21 02:01:47.819964+07	\N	\N	-422973
9103	461	99	7d575930-cef9-424c-a9fa-9f26f9225608	ACCEPTED	5	868	2026-06-21 02:01:47.819981+07	\N	\N	-1225775
9105	461	101	51ec2a1a-aa87-49be-9a22-7d454a3de2a9	ACCEPTED	5	1020	2026-06-21 02:01:47.819986+07	\N	\N	28962
9100	461	96	104224f4-9c3a-40f7-bd2f-761a2525322c	ACCEPTED	5	992	2026-06-21 02:01:47.819974+07	\N	\N	-1188270
9095	461	91	e2cd45d7-b207-4a03-99ed-eb2c977b96a5	ACCEPTED	5	1092	2026-06-21 02:01:47.819948+07	\N	\N	-1113725
9107	461	103	87f385c1-fa69-43a2-9077-68341468c992	ACCEPTED	4	884	2026-06-21 02:01:47.819991+07	\N	\N	283996
9106	461	102	86b791c4-80b9-4860-a32e-26ab6444f8ce	ACCEPTED	5	1024	2026-06-21 02:01:47.819989+07	\N	\N	-619866
8604	455	102	ae1d3e67-76b3-488b-b820-9b0df9d44d7d	WRONG_ANSWER	5	1024	2026-06-19 05:22:34.210845+07	main.cpp:8:25: warning: integer constant is too large for its type\n    8 |     for(int i = 0; i >= 100000000000000000000000; i++)\n      |                         ^~~~~~~~~~~~~~~~~~~~~~~~\n	\N	\N
8636	455	134	532caf6e-5e12-4e31-ad5f-7225503f52c4	WRONG_ANSWER	6	1040	2026-06-19 05:22:34.210856+07	main.cpp:8:25: warning: integer constant is too large for its type\n    8 |     for(int i = 0; i >= 100000000000000000000000; i++)\n      |                         ^~~~~~~~~~~~~~~~~~~~~~~~\n	\N	\N
8635	455	133	1c9a612d-35b0-4f15-934b-41749d77bc05	WRONG_ANSWER	4	1012	2026-06-19 05:22:34.210855+07	main.cpp:8:25: warning: integer constant is too large for its type\n    8 |     for(int i = 0; i >= 100000000000000000000000; i++)\n      |                         ^~~~~~~~~~~~~~~~~~~~~~~~\n	\N	\N
9045	461	23	e572be14-2114-4b84-907c-1c108329ab71	ACCEPTED	8	872	2026-06-21 02:01:47.819779+07	\N	\N	0
9043	461	21	a8f51d9a-31cb-4554-b5be-9fee59836056	ACCEPTED	6	876	2026-06-21 02:01:47.819769+07	\N	\N	3
9051	461	29	0f4df775-e822-4b76-a870-076889652f6b	ACCEPTED	8	988	2026-06-21 02:01:47.819795+07	\N	\N	99
9050	461	28	bfd8bf45-b242-4796-b2f1-6a56ecd66955	ACCEPTED	7	1100	2026-06-21 02:01:47.819793+07	\N	\N	579
9048	461	26	e132f5a4-63af-443b-98f7-ba241fd938b4	ACCEPTED	5	1032	2026-06-21 02:01:47.819787+07	\N	\N	-30
9054	461	32	5825e7fd-ff03-487e-9724-1ed3d85b2638	ACCEPTED	7	1024	2026-06-21 02:01:47.819803+07	\N	\N	0
9057	461	35	2ee665e5-e546-42f0-8e65-df578eed216a	ACCEPTED	4	992	2026-06-21 02:01:47.819811+07	\N	\N	-2
9049	461	27	36d00a00-0361-499b-8594-e7bea472de55	ACCEPTED	6	1088	2026-06-21 02:01:47.81979+07	\N	\N	1000
9067	461	63	960b8f1b-7b5b-4cf5-b6d9-0f4643a6c5f6	ACCEPTED	6	872	2026-06-21 02:01:47.819836+07	\N	\N	1507378
9080	461	76	ba88813c-a7dd-403a-a854-a8fc858f86b0	ACCEPTED	6	1016	2026-06-21 02:01:47.819903+07	\N	\N	802483
9081	461	77	a3229e17-329a-4c88-805f-15fb94b40a14	ACCEPTED	5	1016	2026-06-21 02:01:47.819905+07	\N	\N	-987624
9108	461	104	a46f7c77-3731-46ac-9a56-8f9d72a9781b	ACCEPTED	5	1120	2026-06-21 02:01:47.819994+07	\N	\N	514364
9113	461	109	d9d5918a-596b-42bd-83bb-b2d843e75bd1	ACCEPTED	6	856	2026-06-21 02:01:47.820006+07	\N	\N	792531
9109	461	105	d690796d-0294-40a9-8b01-9b370c46fdf6	ACCEPTED	4	980	2026-06-21 02:01:47.819996+07	\N	\N	-882565
9110	461	106	087ba301-d82c-4e99-a00a-6a0bc4d9d6cd	ACCEPTED	5	864	2026-06-21 02:01:47.819998+07	\N	\N	-815576
9114	461	110	7bc43156-3a59-4c14-9b96-6feb8ea19965	ACCEPTED	4	872	2026-06-21 02:01:47.820008+07	\N	\N	-572819
9112	461	108	61a7a760-c464-43e5-a021-4fdc8b712ae8	ACCEPTED	6	1016	2026-06-21 02:01:47.820003+07	\N	\N	1436130
9116	461	112	f8ebf033-11d5-4f6d-b12d-6c11c454c78a	ACCEPTED	4	1024	2026-06-21 02:01:47.820013+07	\N	\N	649261
9111	461	107	2690ff35-9609-4f3b-8f37-a089cd9f222d	ACCEPTED	4	1020	2026-06-21 02:01:47.820001+07	\N	\N	-34648
9118	461	114	d9a6c1df-e622-4dc5-bcfe-23e0173b85d2	ACCEPTED	5	1008	2026-06-21 02:01:47.820018+07	\N	\N	-234796
9115	461	111	751aa178-584d-4787-8814-2e77e6ca22a0	ACCEPTED	7	1024	2026-06-21 02:01:47.820011+07	\N	\N	-309452
9122	461	118	8218d391-ecc3-4227-984e-a0ef7877fae6	ACCEPTED	6	1024	2026-06-21 02:01:47.820028+07	\N	\N	636465324
9119	461	115	dafcf36c-7360-4500-a4f9-764b86820f2b	ACCEPTED	5	872	2026-06-21 02:01:47.820021+07	\N	\N	506806
9117	461	113	5527b592-13f7-48b6-94a2-aa9b76156f08	ACCEPTED	6	1032	2026-06-21 02:01:47.820016+07	\N	\N	-1143916
9121	461	117	6db799b6-ede3-4a8e-b865-3117f2589824	ACCEPTED	5	872	2026-06-21 02:01:47.820025+07	\N	\N	362210245
9126	461	122	536bfcd4-eb65-43b0-9dfd-96fb90f1e884	ACCEPTED	5	1084	2026-06-21 02:01:47.820038+07	\N	\N	-457820119
9125	461	121	c025526f-9f56-4f15-8a81-d7acdd7a2628	ACCEPTED	8	988	2026-06-21 02:01:47.820035+07	\N	\N	1259817393
9129	461	125	0b80d842-9ec9-4ba7-a4e7-f89194502a00	ACCEPTED	5	1088	2026-06-21 02:01:47.820045+07	\N	\N	86961293
9130	461	126	f69df0c2-8172-4cd5-8f04-7fa45e217ad6	ACCEPTED	5	1084	2026-06-21 02:01:47.820048+07	\N	\N	-882105735
9132	461	128	f6ca9b37-c194-4545-8bcf-af329a7e2534	ACCEPTED	4	1096	2026-06-21 02:01:47.820052+07	\N	\N	82
9120	461	116	c3c043fe-f41e-4790-99b7-ed0c41d0ba68	ACCEPTED	5	1088	2026-06-21 02:01:47.820023+07	\N	\N	785356
9136	461	132	51d7a044-c142-40c3-9ee4-8f69e6be28c2	ACCEPTED	4	1024	2026-06-21 02:01:47.820062+07	\N	\N	-1
9128	461	124	fe65033e-69c1-46a0-b591-184b5e219872	ACCEPTED	5	992	2026-06-21 02:01:47.820043+07	\N	\N	1610593689
9127	461	123	1bc5010b-87dd-44cc-a64d-8af8f53975a6	ACCEPTED	5	1048	2026-06-21 02:01:47.82004+07	\N	\N	1422690276
9124	461	120	4c2b19d0-78ba-4744-9ff1-f57f006851ec	ACCEPTED	5	868	2026-06-21 02:01:47.820033+07	\N	\N	371467497
9123	461	119	945080c2-7064-4430-b887-255652d8542a	ACCEPTED	7	1044	2026-06-21 02:01:47.82003+07	\N	\N	-738231997
9134	461	130	bddee1fe-fce3-40d3-be85-b6485403bdee	ACCEPTED	5	1112	2026-06-21 02:01:47.820057+07	\N	\N	-5
9133	461	129	f87ec04b-a4f3-4358-a6f6-5b0d325c4639	ACCEPTED	4	816	2026-06-21 02:01:47.820055+07	\N	\N	-32
9135	461	131	8570f8b9-f3b2-4118-8cb0-14507309c882	ACCEPTED	5	1020	2026-06-21 02:01:47.82006+07	\N	\N	71
9137	461	133	25ba281e-4833-4da4-a1de-d47640ab8feb	ACCEPTED	4	1016	2026-06-21 02:01:47.820065+07	\N	\N	-57
9131	461	127	8e573848-0fb2-48b1-8d1f-8fdddd482028	ACCEPTED	4	1060	2026-06-21 02:01:47.82005+07	\N	\N	0
9139	461	135	151ec04f-9a57-48d3-bfbb-533db47fcc37	ACCEPTED	2	864	2026-06-21 02:01:47.82007+07	\N	\N	3
9140	461	136	62aa7f79-8530-40d8-9611-6b38b0d84891	ACCEPTED	2	1052	2026-06-21 02:01:47.820088+07	\N	\N	129
9138	461	134	eaa1f0c1-5f4e-45e8-9947-bea1104164ec	ACCEPTED	4	1044	2026-06-21 02:01:47.820067+07	\N	\N	158
9141	461	137	f16a1239-efb0-4ab2-982f-67845236af75	ACCEPTED	5	1052	2026-06-21 02:01:47.820091+07	\N	\N	64
9142	461	138	9dc798c5-94de-4528-8dec-7d7ff7b58100	ACCEPTED	2	1232	2026-06-21 02:01:47.820093+07	\N	\N	51
9143	462	3	146d89ec-04aa-4f62-96b7-fac6046f2a0e	ACCEPTED	80	37092	2026-06-21 02:02:04.423899+07	\N	\N	9\n
9144	462	4	96c7d498-0e39-438f-85f5-ece0a5195e03	ACCEPTED	82	34260	2026-06-21 02:02:04.423901+07	\N	\N	-1\n
9146	463	22	5e74ab45-3853-4b1c-b628-0159ab291a15	ACCEPTED	4	1000	2026-06-21 02:02:18.789315+07	\N	\N	30
9148	463	24	6ca2d462-62aa-49ab-92e9-244e9089a1c3	ACCEPTED	5	980	2026-06-21 02:02:18.789316+07	\N	\N	0
9147	463	23	74f30bdb-ad4d-4d9b-bd2a-0ac5327aab0a	ACCEPTED	4	1016	2026-06-21 02:02:18.789316+07	\N	\N	0
8612	455	110	abe1fc2e-b845-4c94-8f0b-17bf31a60071	WRONG_ANSWER	6	1032	2026-06-19 05:22:34.210847+07	main.cpp:8:25: warning: integer constant is too large for its type\n    8 |     for(int i = 0; i >= 100000000000000000000000; i++)\n      |                         ^~~~~~~~~~~~~~~~~~~~~~~~\n	\N	\N
8628	455	126	91f42e9f-a418-4f68-96ce-b90ec0352cb7	WRONG_ANSWER	6	864	2026-06-19 05:22:34.210853+07	main.cpp:8:25: warning: integer constant is too large for its type\n    8 |     for(int i = 0; i >= 100000000000000000000000; i++)\n      |                         ^~~~~~~~~~~~~~~~~~~~~~~~\n	\N	\N
8615	455	113	8d727ab1-29f2-40c4-9707-3913a0f6e116	WRONG_ANSWER	5	1016	2026-06-19 05:22:34.210849+07	main.cpp:8:25: warning: integer constant is too large for its type\n    8 |     for(int i = 0; i >= 100000000000000000000000; i++)\n      |                         ^~~~~~~~~~~~~~~~~~~~~~~~\n	\N	\N
8623	455	121	a2a14db1-6334-44c6-9117-531f7fe9be4a	WRONG_ANSWER	6	1036	2026-06-19 05:22:34.210851+07	main.cpp:8:25: warning: integer constant is too large for its type\n    8 |     for(int i = 0; i >= 100000000000000000000000; i++)\n      |                         ^~~~~~~~~~~~~~~~~~~~~~~~\n	\N	\N
8621	455	119	87b1ab70-fc09-4cd8-b4f8-3fc556fc6086	WRONG_ANSWER	18	1008	2026-06-19 05:22:34.210851+07	main.cpp:8:25: warning: integer constant is too large for its type\n    8 |     for(int i = 0; i >= 100000000000000000000000; i++)\n      |                         ^~~~~~~~~~~~~~~~~~~~~~~~\n	\N	\N
8633	455	131	ed594262-ce40-4e22-b3a0-0ff98ad66e94	WRONG_ANSWER	5	956	2026-06-19 05:22:34.210855+07	main.cpp:8:25: warning: integer constant is too large for its type\n    8 |     for(int i = 0; i >= 100000000000000000000000; i++)\n      |                         ^~~~~~~~~~~~~~~~~~~~~~~~\n	\N	\N
8632	455	130	9a5a4347-e826-46fd-99ad-1792e77f944c	WRONG_ANSWER	6	1032	2026-06-19 05:22:34.210854+07	main.cpp:8:25: warning: integer constant is too large for its type\n    8 |     for(int i = 0; i >= 100000000000000000000000; i++)\n      |                         ^~~~~~~~~~~~~~~~~~~~~~~~\n	\N	\N
8640	455	138	298ef6ae-7b3b-4f1c-a3ea-55e3a70a88b0	WRONG_ANSWER	2	860	2026-06-19 05:22:34.210861+07	main.cpp:8:25: warning: integer constant is too large for its type\n    8 |     for(int i = 0; i >= 100000000000000000000000; i++)\n      |                         ^~~~~~~~~~~~~~~~~~~~~~~~\n	\N	\N
9076	461	72	0d00f9d6-deb7-4660-a96f-bd80ee8edf8f	ACCEPTED	6	984	2026-06-21 02:01:47.819893+07	\N	\N	1011312
8643	456	23	f9032b59-829d-44b7-9df2-bc404ce17f41	ACCEPTED	5	7176	2026-06-21 01:22:53.469384+07	\N	\N	0
8662	456	60	9cefbe2d-b442-4c3e-8755-df487385cd3e	ACCEPTED	5	1136	2026-06-21 01:22:53.469431+07	\N	\N	380371
8658	456	38	d5f3600d-52e1-4633-9894-ea775937af66	ACCEPTED	5	1184	2026-06-21 01:22:53.46942+07	\N	\N	3000000
8647	456	27	5e024ed1-2ad6-484c-925d-1041782a2f77	ACCEPTED	4	1640	2026-06-21 01:22:53.469394+07	\N	\N	1000
8645	456	25	6d86923d-c70a-4cdd-944e-94b6960b2b21	ACCEPTED	5	1080	2026-06-21 01:22:53.469389+07	\N	\N	300
8652	456	32	c97df09c-1a85-4f5f-8fe4-45c2ab232cde	ACCEPTED	4	1376	2026-06-21 01:22:53.469406+07	\N	\N	0
8644	456	24	935ee99c-533a-4d82-a085-5ca17f4afe7b	ACCEPTED	5	1044	2026-06-21 01:22:53.469387+07	\N	\N	0
8650	456	30	b65a8ae6-e95e-4536-a4f0-100a71e52c7b	ACCEPTED	5	1012	2026-06-21 01:22:53.469401+07	\N	\N	0
8656	456	36	09dd43ee-ced8-4778-9cff-6a8c36a17004	ACCEPTED	5	1612	2026-06-21 01:22:53.469415+07	\N	\N	801
8653	456	33	82eb6112-65ec-4315-9d7c-bb8714202e64	ACCEPTED	5	1100	2026-06-21 01:22:53.469408+07	\N	\N	84
8663	456	61	389c8fd5-d038-4383-90cb-2aada1a161de	ACCEPTED	5	1108	2026-06-21 01:22:53.469433+07	\N	\N	879721
8641	456	21	4f8f8713-9839-45ce-bdfd-98ae76c2a638	ACCEPTED	5	14856	2026-06-21 01:22:53.469358+07	\N	\N	3
8659	456	57	0f8dc0cd-63b7-40a7-8aec-f773b03c6ac6	ACCEPTED	5	1004	2026-06-21 01:22:53.469424+07	\N	\N	787228
8661	456	59	3d21bca8-e8bb-4471-8e5b-8068a54b7d7e	ACCEPTED	5	892	2026-06-21 01:22:53.469428+07	\N	\N	545178
8649	456	29	60ef2595-d629-4d22-8e5b-9c51cc71c903	ACCEPTED	5	1036	2026-06-21 01:22:53.469399+07	\N	\N	99
8651	456	31	3accc697-b136-42e6-b263-e0eb66a1eec1	ACCEPTED	3	1064	2026-06-21 01:22:53.469403+07	\N	\N	30000
8664	456	62	678d4546-2a99-44bf-a6e9-4292360c4473	ACCEPTED	3	1068	2026-06-21 01:22:53.469435+07	\N	\N	1486218
8665	456	63	ffe0dba9-146e-4ff0-b11e-c3b0fe10d936	ACCEPTED	7	1096	2026-06-21 01:22:53.469438+07	\N	\N	1507378
8685	456	83	1412ca05-e954-470f-87eb-1f72b52b232c	ACCEPTED	7	996	2026-06-21 01:22:53.469485+07	\N	\N	-1500204
8684	456	82	a8110469-b2f0-41df-8d0d-bf5040bbfd21	ACCEPTED	6	1104	2026-06-21 01:22:53.469483+07	\N	\N	-1795574
8673	456	71	93364f19-f007-4c9b-a44b-2c37ef6cd0c4	ACCEPTED	5	1044	2026-06-21 01:22:53.469456+07	\N	\N	1416847
8668	456	66	3861fa5b-2f8a-42f8-a77d-147f7a5243ac	ACCEPTED	7	892	2026-06-21 01:22:53.469444+07	\N	\N	129492
8688	456	86	97ccedec-0398-49c5-9361-d3a3a69474ea	ACCEPTED	6	1032	2026-06-21 01:22:53.469492+07	\N	\N	-876295
8669	456	67	c2792398-dec7-4fc2-ae78-b3468f7d5a34	ACCEPTED	8	1108	2026-06-21 01:22:53.469447+07	\N	\N	473222
8670	456	68	9c6bab7f-334f-4477-bff8-9dd3ab6553ed	ACCEPTED	6	1104	2026-06-21 01:22:53.469449+07	\N	\N	1161167
8678	456	76	f6b5b38f-85cc-463f-bba1-26966a67e6b1	ACCEPTED	5	1040	2026-06-21 01:22:53.469469+07	\N	\N	802483
8674	456	72	436aee67-a98e-491e-a895-70ac638cba7f	ACCEPTED	8	1048	2026-06-21 01:22:53.469458+07	\N	\N	1011312
8676	456	74	f147e9a5-5782-412f-a3c2-25513960fd5a	ACCEPTED	6	1012	2026-06-21 01:22:53.469463+07	\N	\N	909595
8675	456	73	a1cbbad9-4ca3-4aff-8aaa-f7c9d2b306d3	ACCEPTED	5	1024	2026-06-21 01:22:53.469461+07	\N	\N	702179
8680	456	78	cc1dfda9-2dad-409a-97f8-3f35c597d5be	ACCEPTED	5	1100	2026-06-21 01:22:53.469474+07	\N	\N	-824805
8667	456	65	efbbae2c-c1b6-46c1-9b22-42036029a38f	ACCEPTED	6	1100	2026-06-21 01:22:53.469442+07	\N	\N	475745
8672	456	70	848931ba-fe6d-41a5-b9ca-5ae2664daf07	ACCEPTED	5	1056	2026-06-21 01:22:53.469453+07	\N	\N	959298
8677	456	75	8a850b0c-1ba2-44d0-9777-421066c3a8d2	ACCEPTED	5	1112	2026-06-21 01:22:53.469466+07	\N	\N	1760278
8682	456	80	59c973f2-29c3-4203-abc7-c2c9e2bd9d86	ACCEPTED	5	1024	2026-06-21 01:22:53.469478+07	\N	\N	-1611196
8666	456	64	d18445a7-dcc2-43a5-9cff-f8065315383c	ACCEPTED	6	1016	2026-06-21 01:22:53.46944+07	\N	\N	710339
8683	456	81	401a517c-190f-4073-93e8-afd181f81b29	ACCEPTED	6	1016	2026-06-21 01:22:53.469481+07	\N	\N	-846475
8686	456	84	a1937bba-41ec-47d2-9b83-02cdffa0c29f	ACCEPTED	6	960	2026-06-21 01:22:53.469488+07	\N	\N	-734921
8681	456	79	df3fb0bb-2648-4a81-946b-6cb401c8f0c7	ACCEPTED	4	1048	2026-06-21 01:22:53.469476+07	\N	\N	-1351853
8679	456	77	9e0b5efa-c2b5-4869-b978-a7317a39b88c	ACCEPTED	4	1040	2026-06-21 01:22:53.469471+07	\N	\N	-987624
8671	456	69	98903ded-182d-4d0a-8168-c74a51406528	ACCEPTED	5	892	2026-06-21 01:22:53.469451+07	\N	\N	616334
9090	461	86	05257998-97e3-4fb9-995f-bcf2ac48fc5e	ACCEPTED	5	872	2026-06-21 02:01:47.819934+07	\N	\N	-876295
9099	461	95	cb96485a-5ae8-4b20-b19b-3fa23b13ad09	ACCEPTED	5	868	2026-06-21 02:01:47.819971+07	\N	\N	-1192974
8648	456	28	b53d779e-8ae7-4060-a8eb-5db75326aad4	ACCEPTED	5	848	2026-06-21 01:22:53.469396+07	\N	\N	579
8657	456	37	a570d2e6-977e-49f5-b28f-89d0bdd0d8f7	ACCEPTED	5	7012	2026-06-21 01:22:53.469417+07	\N	\N	1000
8654	456	34	83e48343-5703-41ca-b8cf-11d0f4b74bda	ACCEPTED	6	3272	2026-06-21 01:22:53.46941+07	\N	\N	15
8646	456	26	968fc655-696f-43dc-98af-8d1d8c646b8a	ACCEPTED	4	876	2026-06-21 01:22:53.469392+07	\N	\N	-30
8655	456	35	d8c8124a-85d5-41c2-a379-11b26bc95022	ACCEPTED	5	876	2026-06-21 01:22:53.469413+07	\N	\N	-2
8660	456	58	deffd9ba-e623-4701-aa84-dfa53041228c	ACCEPTED	4	1000	2026-06-21 01:22:53.469426+07	\N	\N	803799
8642	456	22	8f3c4daa-dbc4-4926-b7f7-5c67d69fff65	ACCEPTED	5	3228	2026-06-21 01:22:53.46938+07	\N	\N	30
8687	456	85	6e261b38-7bf0-4208-887d-86854a57f460	ACCEPTED	5	852	2026-06-21 01:22:53.46949+07	\N	\N	-1006285
8690	456	88	ca6b4f3b-5a52-4caa-865a-ed4815c991e6	ACCEPTED	5	1096	2026-06-21 01:22:53.469497+07	\N	\N	-955984
8692	456	90	d119b20c-22db-4e76-a3fc-f88c36c35d64	ACCEPTED	5	880	2026-06-21 01:22:53.469501+07	\N	\N	-1520451
8689	456	87	23ccf116-15ef-4491-a3b3-8bd60437c92a	ACCEPTED	7	972	2026-06-21 01:22:53.469494+07	\N	\N	-1189260
8693	456	91	7bb7e3dd-141d-4b23-9762-1f2ef7e4788b	ACCEPTED	5	1016	2026-06-21 01:22:53.469504+07	\N	\N	-1113725
8695	456	93	115b8611-270f-49a1-9d97-67290037b21a	ACCEPTED	5	1032	2026-06-21 01:22:53.469508+07	\N	\N	-422973
8702	456	100	d133f8bd-9d49-4d55-97b8-603598089a0f	ACCEPTED	6	984	2026-06-21 01:22:53.469524+07	\N	\N	281928
8698	456	96	e3208630-1aa3-42af-b529-96b0560d4874	ACCEPTED	6	1032	2026-06-21 01:22:53.469515+07	\N	\N	-1188270
8703	456	101	67dfaae6-45e5-422c-932e-d9644804d990	ACCEPTED	5	1092	2026-06-21 01:22:53.469526+07	\N	\N	28962
8694	456	92	95c7f502-e3a5-42f5-9b1a-0ddb681655be	ACCEPTED	6	904	2026-06-21 01:22:53.469506+07	\N	\N	-471131
8699	456	97	5cf023a9-fd3e-4c22-9045-698ba8cc8961	ACCEPTED	4	868	2026-06-21 01:22:53.469517+07	\N	\N	-517131
8700	456	98	1f1137a1-d2e9-439e-a84e-8c8c70d97f3c	ACCEPTED	6	1028	2026-06-21 01:22:53.46952+07	\N	\N	99178
8696	456	94	2464404b-60fe-48e6-b24a-7a87599c33f8	ACCEPTED	4	864	2026-06-21 01:22:53.469511+07	\N	\N	-717234
8708	456	106	ce12d50d-e83f-4995-8e07-bfceb194e794	ACCEPTED	5	884	2026-06-21 01:22:53.469538+07	\N	\N	-815576
8701	456	99	a3c006f4-da2b-4499-98d2-b25520d5d34e	ACCEPTED	4	1024	2026-06-21 01:22:53.469522+07	\N	\N	-1225775
8704	456	102	e17a44fc-844e-4a1b-8c38-dc5b58aa2541	ACCEPTED	5	1020	2026-06-21 01:22:53.469529+07	\N	\N	-619866
8697	456	95	b0020653-f752-48ea-bdb9-2be77a8bdb97	ACCEPTED	5	1088	2026-06-21 01:22:53.469513+07	\N	\N	-1192974
8707	456	105	267c0c19-bb6a-4778-b163-5ffa3bd68670	ACCEPTED	5	876	2026-06-21 01:22:53.469535+07	\N	\N	-882565
8712	456	110	727d3600-3d0e-4a4a-8041-3bb296ee6749	ACCEPTED	5	876	2026-06-21 01:22:53.469549+07	\N	\N	-572819
8709	456	107	064c3587-4b6a-497f-9f41-f386cf5722f0	ACCEPTED	5	1088	2026-06-21 01:22:53.469541+07	\N	\N	-34648
8706	456	104	8a70c4b7-2e7d-4fc8-9137-5216ab8afa65	ACCEPTED	5	1036	2026-06-21 01:22:53.469533+07	\N	\N	514364
8705	456	103	f07363e7-abd1-49f2-afad-c1cff5c7e7f0	ACCEPTED	7	1036	2026-06-21 01:22:53.469531+07	\N	\N	283996
8710	456	108	85480e59-a509-48e5-9f9c-3d364734386a	ACCEPTED	10	1032	2026-06-21 01:22:53.469544+07	\N	\N	1436130
8711	456	109	3ab87f67-f9e1-4e5d-861c-fc2aa7687b58	ACCEPTED	5	872	2026-06-21 01:22:53.469546+07	\N	\N	792531
8716	456	114	ee4b8b92-f2d0-4acc-b097-61e8b2b94b85	ACCEPTED	5	1088	2026-06-21 01:22:53.469558+07	\N	\N	-234796
8714	456	112	2c6ac00b-b418-4ab3-ad1b-083ac114ffb0	ACCEPTED	9	1032	2026-06-21 01:22:53.469553+07	\N	\N	649261
8713	456	111	201ba4e1-1438-4c16-9775-d27be594eaf8	ACCEPTED	5	1016	2026-06-21 01:22:53.469551+07	\N	\N	-309452
8715	456	113	7385b3d0-45ae-42a4-903b-23952da81be8	ACCEPTED	4	1016	2026-06-21 01:22:53.469556+07	\N	\N	-1143916
8717	456	115	e219ddd3-b67c-44a2-b664-87a9b67fadc2	ACCEPTED	5	1016	2026-06-21 01:22:53.46956+07	\N	\N	506806
8720	456	118	41b5939d-89c5-4987-be71-797de69cf527	ACCEPTED	5	1020	2026-06-21 01:22:53.469569+07	\N	\N	636465324
8726	456	124	be642d0b-1e47-42fe-99f5-2c6f310efa55	ACCEPTED	5	1084	2026-06-21 01:22:53.469589+07	\N	\N	1610593689
8722	456	120	d2a138cd-8d49-47a8-9397-cc40d94d1334	ACCEPTED	5	880	2026-06-21 01:22:53.469573+07	\N	\N	371467497
8718	456	116	bd53c9dd-ca68-47f4-a94a-f7bd8b6a3354	ACCEPTED	5	872	2026-06-21 01:22:53.469564+07	\N	\N	785356
8730	456	128	76204cf8-d3c6-42b8-8aab-e7ecedcaba8c	ACCEPTED	5	1060	2026-06-21 01:22:53.469599+07	\N	\N	82
8719	456	117	713e3fbb-5219-4814-b3ed-44948d0fe5bc	ACCEPTED	5	1016	2026-06-21 01:22:53.469566+07	\N	\N	362210245
8728	456	126	448ac92d-af96-4f1e-bd9b-f6322564d4f4	ACCEPTED	6	924	2026-06-21 01:22:53.469594+07	\N	\N	-882105735
8723	456	121	558f20c2-00cf-4c14-a912-60b2550b4a8e	ACCEPTED	6	864	2026-06-21 01:22:53.469576+07	\N	\N	1259817393
8724	456	122	ed5d844e-cf89-4d1f-8936-74f7dca45adb	ACCEPTED	5	840	2026-06-21 01:22:53.469578+07	\N	\N	-457820119
8725	456	123	ec97f3ed-3880-4475-ace7-e2a43253bff5	ACCEPTED	5	1008	2026-06-21 01:22:53.469587+07	\N	\N	1422690276
8727	456	125	63138a25-1dfb-4b8a-bd09-d732181b7b3c	ACCEPTED	4	1012	2026-06-21 01:22:53.469592+07	\N	\N	86961293
8733	456	131	0f7f55a5-00b7-4e5c-afb9-02dfb76dd2cb	ACCEPTED	5	864	2026-06-21 01:22:53.469606+07	\N	\N	71
8732	456	130	0ebb87a6-2cb6-40f1-9416-16992200ef3f	ACCEPTED	5	984	2026-06-21 01:22:53.469603+07	\N	\N	-5
8734	456	132	282e47ed-64e8-426c-bed9-1602eab89bc4	ACCEPTED	5	1024	2026-06-21 01:22:53.469608+07	\N	\N	-1
8731	456	129	e4204c44-4656-4946-b7d0-18c1e8fadd10	ACCEPTED	4	1016	2026-06-21 01:22:53.469601+07	\N	\N	-32
8735	456	133	fb487990-ed56-4338-b794-fae9381219df	ACCEPTED	4	988	2026-06-21 01:22:53.469611+07	\N	\N	-57
8736	456	134	c1550f2c-ee48-477f-8ab9-8ee051df25af	ACCEPTED	5	1052	2026-06-21 01:22:53.469613+07	\N	\N	158
8737	456	135	a0a2aad9-bee0-49b8-9d0b-657a7ee56bf9	ACCEPTED	3	1052	2026-06-21 01:22:53.469616+07	\N	\N	3
8738	456	136	646d4c3c-f836-4ebe-a114-c757c1c4ad07	ACCEPTED	4	1016	2026-06-21 01:22:53.469618+07	\N	\N	129
8739	456	137	f65fb260-1f33-40f7-9982-c219fe4e0505	ACCEPTED	4	1324	2026-06-21 01:22:53.46962+07	\N	\N	64
8740	456	138	9d1a8204-6de1-439a-bac7-d996b15f69af	ACCEPTED	3	1056	2026-06-21 01:22:53.469623+07	\N	\N	51
8721	456	119	c0cbafc7-9eb5-4e27-b6aa-7cd1583ed580	ACCEPTED	7	1008	2026-06-21 01:22:53.469571+07	\N	\N	-738231997
9098	461	94	0283b0b1-416f-49ec-9e83-c6ec10081df7	ACCEPTED	5	1028	2026-06-21 02:01:47.819969+07	\N	\N	-717234
9212	463	106	8c519c8c-e584-4f7a-b377-93520bf50162	ACCEPTED	5	872	2026-06-21 02:02:18.789366+07	\N	\N	-815576
9229	463	123	f8af89c5-4e49-4daf-8aaf-040b3c66a0cb	ACCEPTED	5	1020	2026-06-21 02:02:18.789378+07	\N	\N	1422690276
9238	463	132	2c40b0ab-22cc-4bc8-af0a-2d6d02b7c9bb	ACCEPTED	5	1036	2026-06-21 02:02:18.789384+07	\N	\N	-1
9239	463	133	da203566-9833-4a0b-8810-3b76e7d4f8ab	ACCEPTED	4	1020	2026-06-21 02:02:18.789384+07	\N	\N	-57
9245	464	21	354f8c8c-ebc8-48ff-9d84-0a33e06c99b2	ACCEPTED	5	1088	2026-06-21 02:47:49.626318+07	\N	\N	3
9250	464	26	322e109e-77c7-40e1-9591-7c2e909cc7e9	ACCEPTED	6	976	2026-06-21 02:47:49.626343+07	\N	\N	-30
9256	464	32	8ffe4d18-bae7-4d25-8824-b83d6b033376	ACCEPTED	5	836	2026-06-21 02:47:49.626359+07	\N	\N	0
9254	464	30	ad8063aa-24f9-4027-9559-7ff18fc9ce61	ACCEPTED	6	996	2026-06-21 02:47:49.626354+07	\N	\N	0
9259	464	35	f1009493-f013-49ca-b463-a8983914dc33	ACCEPTED	6	880	2026-06-21 02:47:49.626367+07	\N	\N	-2
9266	464	60	fdfc3da7-ae78-4175-82b3-90dc37da6122	ACCEPTED	5	1036	2026-06-21 02:47:49.626386+07	\N	\N	380371
9261	464	37	c8210609-f83b-4f6a-9316-4c3f63ff7581	ACCEPTED	4	1120	2026-06-21 02:47:49.626373+07	\N	\N	1000
9262	464	38	b5f5b992-14d2-4c68-933a-87af2f7cd4ec	ACCEPTED	5	1056	2026-06-21 02:47:49.626376+07	\N	\N	3000000
9252	464	28	70fca962-b67c-4077-96dc-c0cdb9fa1f33	ACCEPTED	7	1032	2026-06-21 02:47:49.626349+07	\N	\N	579
9255	464	31	d5cbc925-1768-4c2c-a5d2-a1d43149a61d	ACCEPTED	5	1092	2026-06-21 02:47:49.626357+07	\N	\N	30000
9248	464	24	ff6028d3-36f5-4418-a6dd-e0af3023ff83	ACCEPTED	13	988	2026-06-21 02:47:49.626338+07	\N	\N	0
9253	464	29	9c4753aa-4bd4-42e5-8305-cf424d6d5796	ACCEPTED	7	876	2026-06-21 02:47:49.626351+07	\N	\N	99
9247	464	23	a90455ad-fb65-431f-b9ec-704e14e02bb6	ACCEPTED	6	1096	2026-06-21 02:47:49.626335+07	\N	\N	0
9267	464	61	83075d0d-dd1d-4321-8a3b-e6a4278fa55f	ACCEPTED	5	864	2026-06-21 02:47:49.626389+07	\N	\N	879721
9263	464	57	fd4d0c78-dae4-4173-bfcf-fcc9317677d2	ACCEPTED	10	1072	2026-06-21 02:47:49.626378+07	\N	\N	787228
9264	464	58	acc9b1eb-b65d-4338-91e8-a7d8870d4680	ACCEPTED	6	868	2026-06-21 02:47:49.626381+07	\N	\N	803799
9260	464	36	c83558a6-3b75-44b7-a2de-78b007caf88a	ACCEPTED	5	884	2026-06-21 02:47:49.62637+07	\N	\N	801
9268	464	62	f250dbc7-be48-4bb6-81c1-c09798fbc173	ACCEPTED	14	868	2026-06-21 02:47:49.626391+07	\N	\N	1486218
9257	464	33	1c2ebf4e-bbb6-4ff7-8cfe-701187bd6f19	ACCEPTED	5	876	2026-06-21 02:47:49.626362+07	\N	\N	84
9275	464	69	f1e59191-f6ab-46e8-9b15-23f14b6551d6	ACCEPTED	5	1084	2026-06-21 02:47:49.626411+07	\N	\N	616334
9271	464	65	82bba167-e5c5-4a2a-a15e-eb71ead39c6f	ACCEPTED	4	1032	2026-06-21 02:47:49.6264+07	\N	\N	475745
9272	464	66	a8e2873b-8109-4b7d-85b4-eec4adb49a97	ACCEPTED	5	1088	2026-06-21 02:47:49.626402+07	\N	\N	129492
9277	464	71	672f534c-3931-4424-b814-e4ba785cf23a	ACCEPTED	5	876	2026-06-21 02:47:49.626416+07	\N	\N	1416847
9282	464	76	e8fe3000-619f-4e66-83af-ae33c4bdc7aa	ACCEPTED	5	1024	2026-06-21 02:47:49.62643+07	\N	\N	802483
9280	464	74	2d8a9541-84ad-4851-8e3d-5b52c8f73bf8	ACCEPTED	5	1088	2026-06-21 02:47:49.626424+07	\N	\N	909595
9270	464	64	363946b5-37b8-40d5-ae6b-794874ef8d6e	ACCEPTED	5	1084	2026-06-21 02:47:49.626397+07	\N	\N	710339
9276	464	70	b49cba4d-5e23-4007-b4eb-41cd569b83ff	ACCEPTED	5	1088	2026-06-21 02:47:49.626414+07	\N	\N	959298
9274	464	68	4909bc46-6563-4201-b8ab-ac6e4eac9cba	ACCEPTED	5	884	2026-06-21 02:47:49.626408+07	\N	\N	1161167
9273	464	67	b48fefea-4029-4e3d-b919-61de61e316cf	ACCEPTED	9	1016	2026-06-21 02:47:49.626405+07	\N	\N	473222
9287	464	81	afe3bbd9-8187-430d-a449-ba15495f3009	ACCEPTED	4	1028	2026-06-21 02:47:49.626446+07	\N	\N	-846475
9289	464	83	ee80621d-573c-44f6-9bdd-a56b181d7e69	ACCEPTED	4	1080	2026-06-21 02:47:49.626451+07	\N	\N	-1500204
9285	464	79	74dabe9f-4851-4e19-b433-2c058875ecdc	ACCEPTED	6	996	2026-06-21 02:47:49.626439+07	\N	\N	-1351853
9286	464	80	995c9c10-b050-4282-ae71-bee52213e973	ACCEPTED	4	1024	2026-06-21 02:47:49.626443+07	\N	\N	-1611196
9291	464	85	f6c0c91c-7585-486a-b670-94d317122c3f	ACCEPTED	5	828	2026-06-21 02:47:49.626463+07	\N	\N	-1006285
9292	464	86	3676b862-9a28-42d0-b8d0-1a0497e15db5	ACCEPTED	5	1028	2026-06-21 02:47:49.626466+07	\N	\N	-876295
9278	464	72	cef5a65f-5d11-477a-b9b6-c800e747d059	ACCEPTED	5	1088	2026-06-21 02:47:49.626419+07	\N	\N	1011312
9281	464	75	3d51437c-439a-4998-9d40-9d7ccee17a59	ACCEPTED	5	1096	2026-06-21 02:47:49.626427+07	\N	\N	1760278
9288	464	82	780c322b-496c-47c6-9ea5-cfc45aa44bd9	ACCEPTED	4	1024	2026-06-21 02:47:49.626449+07	\N	\N	-1795574
9284	464	78	c8b554ba-7c50-49f6-aed3-7ce9f6f733da	ACCEPTED	4	1032	2026-06-21 02:47:49.626435+07	\N	\N	-824805
9293	464	87	74be1fda-e0e0-4ef6-91c1-73edae0e04d2	ACCEPTED	5	1016	2026-06-21 02:47:49.626469+07	\N	\N	-1189260
9295	464	89	30208097-bd29-41f4-845b-81621380129f	ACCEPTED	4	1024	2026-06-21 02:47:49.626474+07	\N	\N	-902015
9294	464	88	4fef0d52-1e95-44ea-bcde-25883ff20f67	ACCEPTED	5	1092	2026-06-21 02:47:49.626471+07	\N	\N	-955984
9301	464	95	223bb7be-d8e8-49d3-8c4f-e6f94261e720	ACCEPTED	4	1032	2026-06-21 02:47:49.62649+07	\N	\N	-1192974
9304	464	98	f673d30e-a631-463c-875e-88faf62b22b5	ACCEPTED	4	1024	2026-06-21 02:47:49.626499+07	\N	\N	99178
9300	464	94	0e205fdd-e1db-42a7-b102-62562fd39dad	ACCEPTED	4	884	2026-06-21 02:47:49.626488+07	\N	\N	-717234
9299	464	93	7149315c-819f-46d7-868c-2db48e7dc74d	ACCEPTED	5	1036	2026-06-21 02:47:49.626485+07	\N	\N	-422973
9297	464	91	9d1e86ce-9831-4c35-948b-f3d6a5305aab	ACCEPTED	4	1020	2026-06-21 02:47:49.626479+07	\N	\N	-1113725
9307	464	101	e355e55f-b753-4f96-8fd1-45f356a38349	ACCEPTED	4	844	2026-06-21 02:47:49.626507+07	\N	\N	28962
9305	464	99	74ec0154-eb77-4ba7-99b4-e1868c1c8e59	ACCEPTED	4	880	2026-06-21 02:47:49.626501+07	\N	\N	-1225775
9298	464	92	d481afad-ff39-4c68-80b1-d5f7ef18ac84	ACCEPTED	4	1040	2026-06-21 02:47:49.626482+07	\N	\N	-471131
9303	464	97	d8c5d0a3-0691-4e1f-a500-c24d1b98eac5	ACCEPTED	4	1016	2026-06-21 02:47:49.626496+07	\N	\N	-517131
9306	464	100	89741a60-8dbb-48da-9cf5-aa907e2d306b	ACCEPTED	5	876	2026-06-21 02:47:49.626504+07	\N	\N	281928
8729	456	127	f43bb9ed-0f20-438f-bdd2-59ea74b8322f	ACCEPTED	5	1000	2026-06-21 01:22:53.469596+07	\N	\N	0
8742	457	6	54100590-e714-4c48-876a-7508858c7a99	ACCEPTED	2	1588	2026-06-21 01:23:55.595227+07	\N	\N	NO\n
8750	458	28	35cf6fc1-7bc9-40f8-8db0-6a9a9dab7fc8	ACCEPTED	5	1032	2026-06-21 01:28:20.511979+07	\N	\N	579
8796	458	92	6de3f803-6098-4497-99d1-e90662442323	ACCEPTED	6	1012	2026-06-21 01:28:20.512042+07	\N	\N	-471131
8804	458	100	614a7b8d-7247-412f-a4e5-eb74f37dc432	ACCEPTED	5	1024	2026-06-21 01:28:20.512051+07	\N	\N	281928
8872	459	68	c203a431-e66a-4208-bedc-43aa1e98c9ff	WRONG_ANSWER	15	988	2026-06-21 01:28:51.252519+07	\N	\N	-101359
8896	459	92	56c9621a-c8f1-4ccd-aa95-f760c8e3ff8b	WRONG_ANSWER	5	1040	2026-06-21 01:28:51.252547+07	\N	\N	210517
8891	459	87	c211c92b-63df-46fa-be95-63643e2c1960	WRONG_ANSWER	4	1012	2026-06-21 01:28:51.252535+07	\N	\N	-719618
8915	459	111	a640587f-f63e-463d-a318-6f570caa49a3	WRONG_ANSWER	5	876	2026-06-21 01:28:51.252566+07	\N	\N	972742
9151	463	27	29769e3e-b1af-40da-b79f-c80854465299	ACCEPTED	5	1084	2026-06-21 02:02:18.78932+07	\N	\N	1000
9160	463	36	fb4f8ca8-6f6e-4d10-ab57-36b1b3a212c8	ACCEPTED	4	1024	2026-06-21 02:02:18.789325+07	\N	\N	801
9153	463	29	07322895-548b-454a-821e-a1bb22983ae6	ACCEPTED	5	1096	2026-06-21 02:02:18.789321+07	\N	\N	99
9156	463	32	ffc544e7-b90f-4413-bffc-9fa6c167c8c9	ACCEPTED	5	1100	2026-06-21 02:02:18.789323+07	\N	\N	0
9158	463	34	91e89290-be3d-4b0e-bce8-8171e5a28eca	ACCEPTED	5	1020	2026-06-21 02:02:18.789324+07	\N	\N	15
9164	463	58	9197a9cf-782a-4dc1-8b77-67c95750890a	ACCEPTED	5	1028	2026-06-21 02:02:18.789328+07	\N	\N	803799
9166	463	60	de0a5dd7-61c4-40a1-ab00-aadff98fdd24	ACCEPTED	7	1028	2026-06-21 02:02:18.789329+07	\N	\N	380371
9152	463	28	02062144-0aae-4628-baca-2a41de93fcf6	ACCEPTED	4	1004	2026-06-21 02:02:18.789321+07	\N	\N	579
9157	463	33	5d8cc8de-1cfb-4401-a1c6-7c6bb25d2d52	ACCEPTED	5	864	2026-06-21 02:02:18.789324+07	\N	\N	84
9159	463	35	f6937348-795f-4907-929e-0f9910786db6	ACCEPTED	4	1088	2026-06-21 02:02:18.789325+07	\N	\N	-2
9150	463	26	b22dad25-8cbc-45d2-aa6e-bb77f7fb5caf	ACCEPTED	6	1020	2026-06-21 02:02:18.789317+07	\N	\N	-30
9165	463	59	eb3d65d6-02be-448a-aa8e-1650f7dd6772	ACCEPTED	5	1000	2026-06-21 02:02:18.789328+07	\N	\N	545178
9168	463	62	260c68a1-4f38-47ef-872a-cc25acef2761	ACCEPTED	5	1096	2026-06-21 02:02:18.78933+07	\N	\N	1486218
9161	463	37	05998544-b4a8-4885-8bcb-6531ac5cda86	ACCEPTED	4	928	2026-06-21 02:02:18.789326+07	\N	\N	1000
9167	463	61	b57f5be7-bc23-408c-9ae0-eb50cfb4407f	ACCEPTED	4	1012	2026-06-21 02:02:18.78933+07	\N	\N	879721
9171	463	65	65556ef2-bdf1-49a8-b6a9-afad367f367e	ACCEPTED	4	1016	2026-06-21 02:02:18.789332+07	\N	\N	475745
9174	463	68	5deb4c8c-f109-4b26-935b-dda8a887026f	ACCEPTED	5	1012	2026-06-21 02:02:18.789333+07	\N	\N	1161167
9169	463	63	4efbe527-516a-471c-a60d-6e136a9bf1c2	ACCEPTED	6	1016	2026-06-21 02:02:18.789331+07	\N	\N	1507378
9181	463	75	07619c8c-0644-4944-a7cf-645421989482	ACCEPTED	6	984	2026-06-21 02:02:18.789337+07	\N	\N	1760278
9175	463	69	527cfff7-e2f9-43f7-a23e-e2233c442c3d	ACCEPTED	4	1008	2026-06-21 02:02:18.789334+07	\N	\N	616334
9178	463	72	182bb0f1-9a75-4e0f-ba4e-932a3f5d555c	ACCEPTED	5	976	2026-06-21 02:02:18.789336+07	\N	\N	1011312
9172	463	66	5c9facbe-9752-4ad0-a8a0-ea163cfa9dfe	ACCEPTED	7	1020	2026-06-21 02:02:18.789332+07	\N	\N	129492
9173	463	67	bf3a3bb9-550d-40e0-9125-ba76b0f92f91	ACCEPTED	6	1092	2026-06-21 02:02:18.789333+07	\N	\N	473222
9185	463	79	c6a372d1-19bc-4250-b601-6ad980d2cd10	ACCEPTED	4	864	2026-06-21 02:02:18.789341+07	\N	\N	-1351853
9189	463	83	462a5e02-b47b-4e97-a86c-4a45a3b1f1d7	ACCEPTED	5	876	2026-06-21 02:02:18.789344+07	\N	\N	-1500204
9183	463	77	1a7b20c0-79cd-4eea-abd1-3108502213cb	ACCEPTED	5	1020	2026-06-21 02:02:18.78934+07	\N	\N	-987624
9176	463	70	941a18cd-cc0d-4748-aceb-5a2314d2e119	ACCEPTED	8	1032	2026-06-21 02:02:18.789335+07	\N	\N	959298
9184	463	78	0c11ca44-d5f9-49ed-97fc-4a0921f0782b	ACCEPTED	4	1076	2026-06-21 02:02:18.789341+07	\N	\N	-824805
9186	463	80	2d106ad7-3b65-4c02-8fab-c85f6b099c7e	ACCEPTED	5	1024	2026-06-21 02:02:18.789342+07	\N	\N	-1611196
9179	463	73	f80d8fbd-d5f2-4f23-92d8-c0b0db104c03	ACCEPTED	5	1096	2026-06-21 02:02:18.789336+07	\N	\N	702179
9182	463	76	388dad25-2225-4bc2-86cd-92d379377090	ACCEPTED	6	892	2026-06-21 02:02:18.789338+07	\N	\N	802483
9188	463	82	87a18365-7138-4a36-bd3d-4ef79a9b2c2d	ACCEPTED	6	988	2026-06-21 02:02:18.789343+07	\N	\N	-1795574
9180	463	74	80404c57-8a29-4ea6-8e9d-f97b819bddd5	ACCEPTED	5	884	2026-06-21 02:02:18.789337+07	\N	\N	909595
9191	463	85	25992998-a85b-4ea7-8076-b2fbebf376f6	ACCEPTED	5	1080	2026-06-21 02:02:18.789345+07	\N	\N	-1006285
9190	463	84	5c8e3b58-acad-460b-a800-4f55ae7e390d	ACCEPTED	5	876	2026-06-21 02:02:18.789344+07	\N	\N	-734921
9193	463	87	04c8a708-85c8-433a-b210-6e838e574b88	ACCEPTED	5	1040	2026-06-21 02:02:18.789346+07	\N	\N	-1189260
9198	463	92	ed5a7ff3-cfd5-41dc-8e38-42314d1419ad	ACCEPTED	5	1124	2026-06-21 02:02:18.789357+07	\N	\N	-471131
9205	463	99	36235104-9c9e-421e-82b4-4c7cdeee221f	ACCEPTED	6	1080	2026-06-21 02:02:18.789362+07	\N	\N	-1225775
9195	463	89	a8c0f4e7-9f3a-43d5-9435-f64b4eb91827	ACCEPTED	5	1092	2026-06-21 02:02:18.789347+07	\N	\N	-902015
9194	463	88	a72888fa-ad45-4dcb-bce4-fec5e392f3a0	ACCEPTED	5	1080	2026-06-21 02:02:18.789347+07	\N	\N	-955984
9208	463	102	b5e6ef20-a403-4480-bd70-678748b154c0	ACCEPTED	5	1120	2026-06-21 02:02:18.789364+07	\N	\N	-619866
9200	463	94	31f1a9ea-ef23-49eb-99e5-05078d9501f3	ACCEPTED	5	1016	2026-06-21 02:02:18.789359+07	\N	\N	-717234
9203	463	97	45ce20b6-9427-4931-aaf8-627a488be275	ACCEPTED	4	1112	2026-06-21 02:02:18.789361+07	\N	\N	-517131
9204	463	98	f52acf60-b5a3-4bbf-9bff-c6159ad854b2	ACCEPTED	4	1076	2026-06-21 02:02:18.789361+07	\N	\N	99178
9201	463	95	9747c4f2-8904-44ed-9e69-9c3935678f9b	ACCEPTED	5	892	2026-06-21 02:02:18.789359+07	\N	\N	-1192974
9199	463	93	db2a4732-bd74-4ce7-94fa-75a3f9952ffa	ACCEPTED	4	1092	2026-06-21 02:02:18.789358+07	\N	\N	-422973
9206	463	100	b0764ed0-f0a7-4a82-a9a3-cbb130821b62	ACCEPTED	5	908	2026-06-21 02:02:18.789363+07	\N	\N	281928
9207	463	101	db8d6203-d4d7-40e7-8a6e-e54761596e08	ACCEPTED	4	864	2026-06-21 02:02:18.789363+07	\N	\N	28962
9202	463	96	0f2b5232-7677-4e06-b0b0-04da7bb2f842	ACCEPTED	4	1016	2026-06-21 02:02:18.78936+07	\N	\N	-1188270
8741	457	5	8528d5b1-ab17-4fb4-9754-8f6c9fe62e72	ACCEPTED	2	824	2026-06-21 01:23:55.59522+07	\N	\N	YES\n
8748	458	26	5ee5c0d0-d2e2-468c-ac72-33ff6f4b9425	ACCEPTED	4	1024	2026-06-21 01:28:20.511977+07	\N	\N	-30
8744	458	22	b7a06078-e7ec-4412-a725-5489171e4010	ACCEPTED	10	872	2026-06-21 01:28:20.511972+07	\N	\N	30
8747	458	25	4c5529c8-255d-442d-bc77-b16b90ba0ff7	ACCEPTED	4	1012	2026-06-21 01:28:20.511976+07	\N	\N	300
8751	458	29	e67f89bc-e017-468c-b415-cfa52e2b35a3	ACCEPTED	4	864	2026-06-21 01:28:20.51198+07	\N	\N	99
8753	458	31	8ac04b36-8386-46a8-bd9c-331fe01be461	ACCEPTED	6	1024	2026-06-21 01:28:20.511982+07	\N	\N	30000
8746	458	24	39cb2b6c-d7c5-4e0c-9cb3-658d58cedcca	ACCEPTED	5	876	2026-06-21 01:28:20.511975+07	\N	\N	0
8762	458	58	068294e9-0b69-4621-a1db-e46a836844d0	ACCEPTED	5	1016	2026-06-21 01:28:20.511992+07	\N	\N	803799
8752	458	30	b3bb6c00-5658-4fcb-9745-3d4acd6f20f6	ACCEPTED	9	984	2026-06-21 01:28:20.511981+07	\N	\N	0
8745	458	23	b7b65819-2924-4eb2-b413-8b24a4be0e63	ACCEPTED	7	1028	2026-06-21 01:28:20.511973+07	\N	\N	0
8749	458	27	e500e4bc-60a2-4d89-8cd4-4a58ab643fb8	ACCEPTED	9	1016	2026-06-21 01:28:20.511978+07	\N	\N	1000
8757	458	35	e9ab94a6-41ed-478f-8b31-4f2720dba23a	ACCEPTED	6	888	2026-06-21 01:28:20.511987+07	\N	\N	-2
8764	458	60	e4dce679-dad7-4f48-9f9a-429dec7e7bf3	ACCEPTED	8	980	2026-06-21 01:28:20.511994+07	\N	\N	380371
8765	458	61	e9ed69e0-6ecb-4d8f-857b-97decddd68ee	ACCEPTED	4	868	2026-06-21 01:28:20.511995+07	\N	\N	879721
8760	458	38	24219b58-559d-4260-bc99-7940c6385b35	ACCEPTED	4	1028	2026-06-21 01:28:20.51199+07	\N	\N	3000000
8755	458	33	b4e8afea-0eb8-464d-8087-14407a193328	ACCEPTED	5	876	2026-06-21 01:28:20.511985+07	\N	\N	84
8763	458	59	cebf5f54-40eb-47b8-babd-227ab70d1eaf	ACCEPTED	6	1032	2026-06-21 01:28:20.511993+07	\N	\N	545178
8759	458	37	20f14f1e-8720-4f30-a19b-06da6c54ab19	ACCEPTED	6	1036	2026-06-21 01:28:20.511989+07	\N	\N	1000
8766	458	62	65fc72a9-b4cd-4663-a509-4b9f9df0e093	ACCEPTED	11	1036	2026-06-21 01:28:20.511997+07	\N	\N	1486218
8758	458	36	6c1cc03c-a4bb-4ded-b88f-44500cd78b3f	ACCEPTED	4	844	2026-06-21 01:28:20.511988+07	\N	\N	801
8773	458	69	cc0838f3-3bfe-465c-93ce-1a413e9579c0	ACCEPTED	5	876	2026-06-21 01:28:20.512014+07	\N	\N	616334
8772	458	68	384232bb-63b4-491f-bd3a-29068880907a	ACCEPTED	8	972	2026-06-21 01:28:20.512013+07	\N	\N	1161167
8768	458	64	0e0c34cc-6aa6-47bd-81cb-a47908a70c44	ACCEPTED	5	1016	2026-06-21 01:28:20.512009+07	\N	\N	710339
8767	458	63	6e05c6d4-20dc-4bf6-a81e-fe135db7e35c	ACCEPTED	6	1020	2026-06-21 01:28:20.511998+07	\N	\N	1507378
8769	458	65	6c5788b1-6d15-4e69-be95-39ac2cdf0b43	ACCEPTED	5	1024	2026-06-21 01:28:20.51201+07	\N	\N	475745
8782	458	78	73807283-046b-41d4-9f52-5864a557a0de	ACCEPTED	10	828	2026-06-21 01:28:20.512024+07	\N	\N	-824805
8778	458	74	fc37f740-727f-4b97-935c-b594f6e3781e	ACCEPTED	4	1012	2026-06-21 01:28:20.51202+07	\N	\N	909595
8770	458	66	5f96d361-91ac-40b0-92d0-b10daecab12d	ACCEPTED	6	980	2026-06-21 01:28:20.512011+07	\N	\N	129492
8779	458	75	3dd5baea-50d4-4bcd-aabd-fee6f0670663	ACCEPTED	5	864	2026-06-21 01:28:20.512021+07	\N	\N	1760278
8775	458	71	5fc3422e-4728-4a7c-818b-84092a7664ce	ACCEPTED	9	872	2026-06-21 01:28:20.512016+07	\N	\N	1416847
8787	458	83	3ca2d07a-8169-48f5-aaab-a489a3c1b281	ACCEPTED	6	892	2026-06-21 01:28:20.51203+07	\N	\N	-1500204
8780	458	76	257ce16e-5270-42f6-9c47-62e57afe84eb	ACCEPTED	5	1028	2026-06-21 01:28:20.512022+07	\N	\N	802483
8774	458	70	dadb2243-a9a7-4e4d-95ab-87115437b3b5	ACCEPTED	9	1092	2026-06-21 01:28:20.512015+07	\N	\N	959298
8776	458	72	a729f0b3-146e-489e-936f-d5a4a87b250d	ACCEPTED	4	1016	2026-06-21 01:28:20.512018+07	\N	\N	1011312
8777	458	73	c79c8744-ac95-4796-852e-1195c62cb646	ACCEPTED	4	864	2026-06-21 01:28:20.512019+07	\N	\N	702179
8781	458	77	cf74442c-26b9-415f-9c28-10e097231635	ACCEPTED	8	984	2026-06-21 01:28:20.512023+07	\N	\N	-987624
8785	458	81	c9ee693e-d066-46fc-b99d-12db08c7a474	ACCEPTED	5	1020	2026-06-21 01:28:20.512027+07	\N	\N	-846475
8789	458	85	fbe8c279-09d9-4aa9-ab24-b7dd8ebc98cb	ACCEPTED	5	1104	2026-06-21 01:28:20.512033+07	\N	\N	-1006285
8786	458	82	5cd11369-3214-4f5b-bb79-4cae2086849e	ACCEPTED	8	872	2026-06-21 01:28:20.512028+07	\N	\N	-1795574
8788	458	84	3f58f117-b253-49f8-a9d5-edaf3ac72e4e	ACCEPTED	8	992	2026-06-21 01:28:20.512032+07	\N	\N	-734921
8791	458	87	d2258628-8dd8-4f7b-b7d0-9bb828e3f8cf	ACCEPTED	8	872	2026-06-21 01:28:20.512036+07	\N	\N	-1189260
8793	458	89	7a89577a-f752-41de-a179-e4de9ed48b6d	ACCEPTED	5	1024	2026-06-21 01:28:20.512039+07	\N	\N	-902015
8797	458	93	d03118af-b918-4222-8fb1-747db8ef23ac	ACCEPTED	9	1108	2026-06-21 01:28:20.512043+07	\N	\N	-422973
8798	458	94	96347f3c-062c-4916-a7a9-4fc344ee977f	ACCEPTED	5	1032	2026-06-21 01:28:20.512044+07	\N	\N	-717234
8803	458	99	6ba96b71-ea9b-462e-b910-c75bbba8742d	ACCEPTED	5	1024	2026-06-21 01:28:20.51205+07	\N	\N	-1225775
8792	458	88	6caa0b1b-130d-44fb-9490-2d920d2dcdff	ACCEPTED	5	836	2026-06-21 01:28:20.512037+07	\N	\N	-955984
8795	458	91	c49f0adc-7dd0-4144-8981-3bb6ca54898c	ACCEPTED	5	872	2026-06-21 01:28:20.512041+07	\N	\N	-1113725
8806	458	102	ac4c0935-34ab-4291-bf99-06a4c3dd14c7	ACCEPTED	4	1012	2026-06-21 01:28:20.512053+07	\N	\N	-619866
8800	458	96	235be3f4-7af1-4852-afdc-f2077dc45da4	ACCEPTED	5	1096	2026-06-21 01:28:20.512046+07	\N	\N	-1188270
8801	458	97	324f2832-8558-4137-acec-4a7858bc954e	ACCEPTED	5	1100	2026-06-21 01:28:20.512047+07	\N	\N	-517131
8810	458	106	be069670-62c1-4ea4-b9ea-361610d00c38	ACCEPTED	6	1012	2026-06-21 01:28:20.512057+07	\N	\N	-815576
8799	458	95	ba7c8316-59c7-4493-959c-68f4d5457083	ACCEPTED	8	1096	2026-06-21 01:28:20.512045+07	\N	\N	-1192974
8805	458	101	3897a660-e2ac-4582-9eca-3438a4d49e82	ACCEPTED	6	872	2026-06-21 01:28:20.512052+07	\N	\N	28962
8809	458	105	2771d98a-a1c9-40ad-b682-36592d939cf5	ACCEPTED	5	868	2026-06-21 01:28:20.512056+07	\N	\N	-882565
8808	458	104	7c74a979-0c23-4a18-b2a8-7a86ce161d23	ACCEPTED	5	1020	2026-06-21 01:28:20.512055+07	\N	\N	514364
8802	458	98	6fe7cc2b-1a64-4e57-91c5-328d0ef35a4d	ACCEPTED	9	1032	2026-06-21 01:28:20.512048+07	\N	\N	99178
8807	458	103	c5c8753e-2c10-4179-9a2e-544ccedf8a90	ACCEPTED	10	1088	2026-06-21 01:28:20.512054+07	\N	\N	283996
8811	458	107	158ed232-aba9-466f-9927-92e818f3f857	ACCEPTED	5	868	2026-06-21 01:28:20.512058+07	\N	\N	-34648
8743	458	21	61b55335-9a8a-492d-a5a4-e92ae17d8fd3	ACCEPTED	9	1020	2026-06-21 01:28:20.511968+07	\N	\N	3
8754	458	32	90544828-50f9-43c3-9ec0-c5ed021966f4	ACCEPTED	7	1076	2026-06-21 01:28:20.511983+07	\N	\N	0
8756	458	34	f4bbaa96-c33b-45e9-a527-33eead4e14cf	ACCEPTED	8	872	2026-06-21 01:28:20.511986+07	\N	\N	15
8761	458	57	3bb9ed4b-5082-4bf5-aeed-ae23e8690acb	ACCEPTED	6	1020	2026-06-21 01:28:20.511991+07	\N	\N	787228
8783	458	79	149e9019-1462-4154-ab78-064cc17a8e86	ACCEPTED	4	1000	2026-06-21 01:28:20.512025+07	\N	\N	-1351853
8771	458	67	79ca4d6d-19aa-47b2-9138-1fdafdfef38c	ACCEPTED	5	868	2026-06-21 01:28:20.512012+07	\N	\N	473222
8784	458	80	6b10579f-e317-4309-a8bd-e344df8f85c3	ACCEPTED	6	1036	2026-06-21 01:28:20.512026+07	\N	\N	-1611196
8790	458	86	4f0553ae-0b87-4605-afca-4c78071b1266	ACCEPTED	8	996	2026-06-21 01:28:20.512034+07	\N	\N	-876295
8794	458	90	f0e65dd3-1935-4e55-aae4-270918a74886	ACCEPTED	10	1032	2026-06-21 01:28:20.51204+07	\N	\N	-1520451
8812	458	108	7f98a8ad-21a2-4e7b-93e4-f54ed90c21a6	ACCEPTED	5	1076	2026-06-21 01:28:20.512059+07	\N	\N	1436130
8813	458	109	db09d1b0-9d36-45ab-a095-51ebaf5c071e	ACCEPTED	5	876	2026-06-21 01:28:20.51206+07	\N	\N	792531
8815	458	111	a92ecd41-bb51-4fc6-9968-933d1df32c64	ACCEPTED	8	1088	2026-06-21 01:28:20.512062+07	\N	\N	-309452
8814	458	110	4b21566a-eb2f-4c7e-ae65-4381e6587f3e	ACCEPTED	5	1028	2026-06-21 01:28:20.512061+07	\N	\N	-572819
8822	458	118	0c2d0c8d-4557-4038-aed9-6df10544a06d	ACCEPTED	5	868	2026-06-21 01:28:20.51207+07	\N	\N	636465324
8820	458	116	b834ed12-3bb0-4fc6-be8c-ac096941700b	ACCEPTED	6	896	2026-06-21 01:28:20.512068+07	\N	\N	785356
8818	458	114	bfbddf93-56cb-404a-bcc4-08e5cff1e0fa	ACCEPTED	4	904	2026-06-21 01:28:20.512066+07	\N	\N	-234796
8823	458	119	e53414fd-ecc4-405b-84e3-c240722a06bf	ACCEPTED	6	976	2026-06-21 01:28:20.512071+07	\N	\N	-738231997
8824	458	120	4793355c-51a4-4ee1-8404-22b181be15c6	ACCEPTED	7	880	2026-06-21 01:28:20.512072+07	\N	\N	371467497
8832	458	128	53a98726-34e7-4308-93bf-0b795e740889	ACCEPTED	5	1092	2026-06-21 01:28:20.51208+07	\N	\N	82
8827	458	123	c5525c91-21cc-41da-ab98-954dee18bc16	ACCEPTED	5	884	2026-06-21 01:28:20.512075+07	\N	\N	1422690276
8831	458	127	4c65eb70-e49c-479a-95e9-4a6f5b46d03c	ACCEPTED	5	1016	2026-06-21 01:28:20.512079+07	\N	\N	0
8817	458	113	3a8b00c5-3b78-480f-bde9-5c00819497fb	ACCEPTED	5	1032	2026-06-21 01:28:20.512065+07	\N	\N	-1143916
8830	458	126	eba25bdf-8b5d-4979-8525-da37c5133566	ACCEPTED	4	876	2026-06-21 01:28:20.512078+07	\N	\N	-882105735
8821	458	117	b00407dc-6725-43c6-9a4a-7dacfa29cd3f	ACCEPTED	4	1016	2026-06-21 01:28:20.512069+07	\N	\N	362210245
8816	458	112	3550f674-6189-4326-921f-adc5921e701e	ACCEPTED	4	988	2026-06-21 01:28:20.512063+07	\N	\N	649261
8835	458	131	42052412-b7bb-4566-8d15-01fe1b2bc7ce	ACCEPTED	4	1084	2026-06-21 01:28:20.512084+07	\N	\N	71
8836	458	132	f1b8c6a5-b181-4d94-a1ca-59dc2e6e4b2e	ACCEPTED	5	1020	2026-06-21 01:28:20.512085+07	\N	\N	-1
8834	458	130	969ac155-24ae-4a1f-aad7-abe141766bc9	ACCEPTED	5	1024	2026-06-21 01:28:20.512082+07	\N	\N	-5
8828	458	124	a0632ca3-e707-4439-9401-5a24f9703fc1	ACCEPTED	7	1104	2026-06-21 01:28:20.512076+07	\N	\N	1610593689
8825	458	121	81822878-90b1-492a-9bb5-d7d09cb05196	ACCEPTED	4	996	2026-06-21 01:28:20.512073+07	\N	\N	1259817393
8826	458	122	a779ed07-2247-45ae-9cca-474137a50059	ACCEPTED	5	872	2026-06-21 01:28:20.512074+07	\N	\N	-457820119
8819	458	115	26076c56-e105-4d3e-81d3-610bf076d148	ACCEPTED	5	1012	2026-06-21 01:28:20.512067+07	\N	\N	506806
8833	458	129	d1dbc766-0f5e-45a2-8ccc-664a9de609b8	ACCEPTED	4	1024	2026-06-21 01:28:20.512081+07	\N	\N	-32
8829	458	125	8bb568ec-e983-4a98-a226-957c11129498	ACCEPTED	4	1016	2026-06-21 01:28:20.512077+07	\N	\N	86961293
8837	458	133	1810e24a-d762-4c4d-8da3-4bd4d8e1c77b	ACCEPTED	5	1024	2026-06-21 01:28:20.512086+07	\N	\N	-57
8839	458	135	c15aa494-4e8d-4349-98dd-8d578656c81f	ACCEPTED	4	1056	2026-06-21 01:28:20.512088+07	\N	\N	3
8838	458	134	fe93b316-05c9-46e5-a5b2-2f69ef01243d	ACCEPTED	3	1044	2026-06-21 01:28:20.512087+07	\N	\N	158
8842	458	138	af34eaaa-0dea-4a86-bf19-ba96e1ed4e7a	ACCEPTED	2	1048	2026-06-21 01:28:20.512091+07	\N	\N	51
8841	458	137	289d64f9-3bf5-4edb-ab14-d51bd3833f9f	ACCEPTED	2	1024	2026-06-21 01:28:20.51209+07	\N	\N	64
8840	458	136	adfc1615-d717-47f7-9607-ba52eedaf6a9	ACCEPTED	2	1024	2026-06-21 01:28:20.512089+07	\N	\N	129
8850	459	28	71b95448-e923-4375-b083-dded8728a5f4	WRONG_ANSWER	5	1080	2026-06-21 01:28:51.252498+07	\N	\N	-333
8846	459	24	166ac8cc-7709-4b67-a771-e3f4b0c3eb10	WRONG_ANSWER	5	992	2026-06-21 01:28:51.252495+07	\N	\N	-10
8844	459	22	2f63abc0-e193-4eda-a1d8-ebdb6b28b3ce	WRONG_ANSWER	5	1024	2026-06-21 01:28:51.252493+07	\N	\N	-10
8852	459	30	b375a6a1-9b27-42f9-9d7c-7723fab9f6bd	WRONG_ANSWER	6	1040	2026-06-21 01:28:51.2525+07	\N	\N	100
8851	459	29	c13b64f0-48de-4a2d-9ded-b07026fd0bfb	WRONG_ANSWER	6	868	2026-06-21 01:28:51.252499+07	\N	\N	-99
8853	459	31	a31fdee6-62fd-42a2-8aad-940355afc7ac	WRONG_ANSWER	5	880	2026-06-21 01:28:51.252501+07	\N	\N	-10000
8843	459	21	97f37226-e64f-4938-bd27-269ea1525d96	WRONG_ANSWER	6	872	2026-06-21 01:28:51.25249+07	\N	\N	-1
8849	459	27	4ea0c1c9-858a-40aa-a0d4-f53d75682c63	WRONG_ANSWER	7	1028	2026-06-21 01:28:51.252497+07	\N	\N	998
8847	459	25	28ee1188-cd25-4069-ad4d-d11addd0cb19	WRONG_ANSWER	6	888	2026-06-21 01:28:51.252496+07	\N	\N	-100
8845	459	23	dbe05d16-8baa-487b-bd4f-3263c83803f7	ACCEPTED	4	1096	2026-06-21 01:28:51.252494+07	\N	\N	0
8848	459	26	bd148f73-ffea-44b3-94fa-7daf4db53798	WRONG_ANSWER	6	932	2026-06-21 01:28:51.252496+07	\N	\N	10
9213	463	107	c6f0a267-ee4f-48de-bdcf-cdc6943406d3	ACCEPTED	5	1020	2026-06-21 02:02:18.789367+07	\N	\N	-34648
9215	463	109	68ed6c30-b4e8-4be0-9ca0-aa3ff30fe46d	ACCEPTED	4	864	2026-06-21 02:02:18.789368+07	\N	\N	792531
9211	463	105	c4e5c181-d94d-4a23-99b8-5d18bf864eaf	ACCEPTED	5	1024	2026-06-21 02:02:18.789366+07	\N	\N	-882565
9214	463	108	2ed0d36f-8db9-4829-809c-635cd34facee	ACCEPTED	5	824	2026-06-21 02:02:18.789368+07	\N	\N	1436130
9216	463	110	8c34dea4-774c-4439-8cdc-7bdc4331af32	ACCEPTED	6	1032	2026-06-21 02:02:18.789369+07	\N	\N	-572819
9218	463	112	7e066d34-137c-4ee5-8561-dd1962f9a0cb	ACCEPTED	5	848	2026-06-21 02:02:18.78937+07	\N	\N	649261
9219	463	113	a78b8f88-f6a8-4150-953b-affe0fb3e073	ACCEPTED	6	1092	2026-06-21 02:02:18.789371+07	\N	\N	-1143916
8860	459	38	e3222b27-25cd-42eb-a6e7-ad7eac43052d	WRONG_ANSWER	6	1028	2026-06-21 01:28:51.252508+07	\N	\N	-1000000
8863	459	59	5f6b3871-6314-433c-8eab-2e9d8dd75016	WRONG_ANSWER	5	864	2026-06-21 01:28:51.25251+07	\N	\N	31602
8864	459	60	88ad1a65-1bdf-46d0-8fee-6d7f354130d0	WRONG_ANSWER	7	936	2026-06-21 01:28:51.252511+07	\N	\N	87737
8866	459	62	665838f0-6e79-4738-b1b7-6c7e9afbb34d	WRONG_ANSWER	5	1092	2026-06-21 01:28:51.252513+07	\N	\N	-67076
8862	459	58	30e1f031-558d-4688-aecc-370b474e9945	WRONG_ANSWER	5	1028	2026-06-21 01:28:51.25251+07	\N	\N	-751347
8856	459	34	dce783c2-c76d-4167-ae27-4b649deb37a2	WRONG_ANSWER	5	1016	2026-06-21 01:28:51.252504+07	\N	\N	-1
8858	459	36	93505aba-4149-4260-9afd-3572f93c381d	WRONG_ANSWER	4	876	2026-06-21 01:28:51.252506+07	\N	\N	-333
8855	459	33	b6899086-3431-4459-a23c-e54704b43485	WRONG_ANSWER	6	980	2026-06-21 01:28:51.252503+07	\N	\N	0
8861	459	57	71b83756-66e7-4e37-90c8-b35d78c5007a	WRONG_ANSWER	5	868	2026-06-21 01:28:51.252509+07	\N	\N	553748
8857	459	35	90c8b655-efb4-4181-9687-00f2bb4226be	WRONG_ANSWER	6	1040	2026-06-21 01:28:51.252505+07	\N	\N	0
8867	459	63	ced319e1-f951-4ca8-9ccf-2583cb9c9f78	WRONG_ANSWER	4	876	2026-06-21 01:28:51.252514+07	\N	\N	363660
8870	459	66	9a93996a-cbf0-4188-86c1-e6482307a2ea	WRONG_ANSWER	5	876	2026-06-21 01:28:51.252517+07	\N	\N	-67002
8869	459	65	e84f7962-5f3a-44b6-b971-a1d39ea97015	WRONG_ANSWER	4	1016	2026-06-21 01:28:51.252516+07	\N	\N	409091
8871	459	67	e06e3c5e-f0ee-40e6-b835-127a72e4c9d1	WRONG_ANSWER	5	1040	2026-06-21 01:28:51.252518+07	\N	\N	-14704
8874	459	70	85f187c2-4f41-48b8-8e02-928afecf8058	WRONG_ANSWER	5	1020	2026-06-21 01:28:51.25252+07	\N	\N	-542304
8868	459	64	57d87cb2-1d53-4198-91b4-ce8d70b9471b	WRONG_ANSWER	5	856	2026-06-21 01:28:51.252515+07	\N	\N	-528015
8880	459	76	ff36667d-f7f4-454d-baa5-90b338ec5e99	WRONG_ANSWER	5	1028	2026-06-21 01:28:51.252526+07	\N	\N	-788853
8881	459	77	600ce6bb-9108-490a-8c53-ddcbbf63d9e8	WRONG_ANSWER	5	1080	2026-06-21 01:28:51.252527+07	\N	\N	677548
8878	459	74	2bfea61f-978a-4a8a-a47b-b3f361ef804c	WRONG_ANSWER	5	912	2026-06-21 01:28:51.252524+07	\N	\N	326185
8873	459	69	5576aa88-4685-4e05-8aa0-e2320482994f	WRONG_ANSWER	4	868	2026-06-21 01:28:51.252519+07	\N	\N	-560684
8884	459	80	3a0fb599-e12a-4dfa-994b-a956c0b6491d	WRONG_ANSWER	5	1012	2026-06-21 01:28:51.252529+07	\N	\N	-62740
8879	459	75	ac9d9a8a-0042-47af-967c-29c9049f5f86	WRONG_ANSWER	6	972	2026-06-21 01:28:51.252525+07	\N	\N	-62778
8877	459	73	f1090ff0-5bb5-4118-a82f-e1cbe309d85a	WRONG_ANSWER	5	876	2026-06-21 01:28:51.252523+07	\N	\N	-239881
8883	459	79	620d62ca-1837-4d70-9e41-f639fc8b551e	WRONG_ANSWER	5	964	2026-06-21 01:28:51.252529+07	\N	\N	65409
8887	459	83	b9f75834-a8fc-44e9-8684-59acb676f05a	WRONG_ANSWER	5	1024	2026-06-21 01:28:51.252532+07	\N	\N	296968
8889	459	85	f1331c92-25cf-45d4-a0b6-522ba07c28f8	WRONG_ANSWER	5	996	2026-06-21 01:28:51.252534+07	\N	\N	-272389
8886	459	82	597e5ada-2c25-49af-b6cc-28278b12d462	WRONG_ANSWER	5	940	2026-06-21 01:28:51.252531+07	\N	\N	9924
8890	459	86	2fc199e3-7fa5-4d37-89cc-9eb41d920621	WRONG_ANSWER	5	1096	2026-06-21 01:28:51.252535+07	\N	\N	-568965
8885	459	81	6e8b6ec6-b7df-4543-9575-2f6ebbd25744	WRONG_ANSWER	5	1028	2026-06-21 01:28:51.25253+07	\N	\N	447637
8882	459	78	89eab29c-439f-4f5a-b727-72af1de0539a	WRONG_ANSWER	5	1016	2026-06-21 01:28:51.252528+07	\N	\N	288909
8892	459	88	301bfec0-cdc9-4b11-a1a7-868b7f1ae1c2	WRONG_ANSWER	6	1004	2026-06-21 01:28:51.252536+07	\N	\N	-80534
8895	459	91	4dded5be-3b17-48a1-9dd0-c6bcd645c174	WRONG_ANSWER	5	900	2026-06-21 01:28:51.252539+07	\N	\N	271437
8893	459	89	dfb56155-a1b3-4c17-892b-8e65c73b35c1	WRONG_ANSWER	4	1040	2026-06-21 01:28:51.252537+07	\N	\N	-836207
8897	459	93	149e0429-7208-468c-9dba-7b3eb479ad62	WRONG_ANSWER	8	1104	2026-06-21 01:28:51.252548+07	\N	\N	-279899
8899	459	95	f84c6e79-9433-44cf-b6db-b472823003c6	WRONG_ANSWER	5	1036	2026-06-21 01:28:51.25255+07	\N	\N	403768
8894	459	90	8f74d1dc-0bfb-47f8-b483-6a111c013d78	WRONG_ANSWER	7	1088	2026-06-21 01:28:51.252538+07	\N	\N	314295
8902	459	98	61b93862-3593-4f02-bd05-35afe95acb0f	WRONG_ANSWER	5	1028	2026-06-21 01:28:51.252555+07	\N	\N	-1143304
8901	459	97	17d4444e-8786-4aad-9c1c-ebf05d74de37	WRONG_ANSWER	5	840	2026-06-21 01:28:51.252554+07	\N	\N	-1290669
8898	459	94	af322a04-b7d5-4bf1-a2d0-1512757205c8	WRONG_ANSWER	5	1032	2026-06-21 01:28:51.252549+07	\N	\N	524364
8909	459	105	e50cfd1c-5117-4fb9-8be8-e5182867471b	WRONG_ANSWER	7	1096	2026-06-21 01:28:51.252561+07	\N	\N	-435215
8904	459	100	9a18bf3f-6786-4397-a216-7c394b7e96fb	WRONG_ANSWER	5	1032	2026-06-21 01:28:51.252557+07	\N	\N	1305534
8906	459	102	02f7fb7c-c5d2-49e6-9525-cbe1b3da153f	WRONG_ANSWER	4	1036	2026-06-21 01:28:51.252559+07	\N	\N	214230
8903	459	99	c5606825-130d-4759-b999-a36e652cca36	WRONG_ANSWER	5	1028	2026-06-21 01:28:51.252556+07	\N	\N	439555
8905	459	101	7d98f4b5-4d57-46be-86f2-0a38feaa7a5d	WRONG_ANSWER	5	1116	2026-06-21 01:28:51.252558+07	\N	\N	1605332
8900	459	96	12c0a08d-b772-4ed5-b98a-c94d57403769	WRONG_ANSWER	5	1032	2026-06-21 01:28:51.252551+07	\N	\N	665864
8908	459	104	e33176e6-8d8f-412a-9f7e-354f3aa19103	WRONG_ANSWER	5	1004	2026-06-21 01:28:51.252561+07	\N	\N	984148
8910	459	106	fe28d292-5920-40af-8b62-8d92399bc9ea	WRONG_ANSWER	4	1000	2026-06-21 01:28:51.252562+07	\N	\N	305688
8907	459	103	201e6793-9981-400e-a4e9-c8940576cd08	WRONG_ANSWER	5	1048	2026-06-21 01:28:51.25256+07	\N	\N	-382256
8912	459	108	79e6efc0-111d-424b-b65a-86ca982f350d	WRONG_ANSWER	5	900	2026-06-21 01:28:51.252564+07	\N	\N	-492484
8913	459	109	4e2e9a5a-a594-4966-aa09-7a6d831decf1	WRONG_ANSWER	6	1044	2026-06-21 01:28:51.252565+07	\N	\N	74475
8914	459	110	284daf30-63cd-4d2d-ba03-630f646b6344	WRONG_ANSWER	7	992	2026-06-21 01:28:51.252566+07	\N	\N	-1127699
8918	459	114	70bd88d1-ff1f-4a75-bed1-e842a951b105	WRONG_ANSWER	5	1016	2026-06-21 01:28:51.252569+07	\N	\N	173654
8916	459	112	b09dc13f-aa80-4cd1-a976-7abda5b5dde5	WRONG_ANSWER	14	1096	2026-06-21 01:28:51.252567+07	\N	\N	-408917
8921	459	117	62c2fa89-620f-43bf-be45-6cad39472dbe	WRONG_ANSWER	5	1088	2026-06-21 01:28:51.252572+07	\N	\N	853830231
8922	459	118	fea6a7ed-cb21-4e19-8834-cc4ba4fb870b	WRONG_ANSWER	5	992	2026-06-21 01:28:51.252573+07	\N	\N	-1148342312
8917	459	113	3ea7b1f3-3905-42a9-8dc2-4144abe702f5	WRONG_ANSWER	6	868	2026-06-21 01:28:51.252568+07	\N	\N	170726
8923	459	119	ed6af45c-da7e-46dc-a3dc-85b722fc4193	WRONG_ANSWER	4	976	2026-06-21 01:28:51.252574+07	\N	\N	-143262831
8920	459	116	45121bd6-c010-4c00-9b79-9818318474df	WRONG_ANSWER	5	856	2026-06-21 01:28:51.252571+07	\N	\N	-101004
8865	459	61	ffecfc36-6127-4560-87a6-a0d65131df06	WRONG_ANSWER	8	888	2026-06-21 01:28:51.252512+07	\N	\N	664773
8854	459	32	4b38e890-50c0-4c3d-b71b-c58a4b1ec17b	WRONG_ANSWER	5	900	2026-06-21 01:28:51.252502+07	\N	\N	-1998
8859	459	37	3fba901f-2715-41ba-9664-e497f7008645	WRONG_ANSWER	6	1000	2026-06-21 01:28:51.252507+07	\N	\N	776
8876	459	72	e9f9f28a-d156-4d49-9090-eeae774fa636	WRONG_ANSWER	5	1024	2026-06-21 01:28:51.252522+07	\N	\N	131514
8875	459	71	10238a05-6f6a-4dcb-9393-9f3acb7aeb8b	WRONG_ANSWER	5	1068	2026-06-21 01:28:51.252521+07	\N	\N	-53939
8888	459	84	d99130f8-6fd6-4fca-941d-83925a43949d	WRONG_ANSWER	6	1024	2026-06-21 01:28:51.252533+07	\N	\N	-512245
8911	459	107	620c7029-89cb-489e-9c20-72d512743d7c	WRONG_ANSWER	5	1028	2026-06-21 01:28:51.252563+07	\N	\N	845566
8919	459	115	9a920bc0-b572-4fed-975c-f5cd9244b8d6	WRONG_ANSWER	6	1024	2026-06-21 01:28:51.25257+07	\N	\N	-1374564
8925	459	121	dbfc8c25-4bdd-48bb-859e-ed5095582f4e	WRONG_ANSWER	4	1016	2026-06-21 01:28:51.252576+07	\N	\N	167726425
8926	459	122	32dbd9b4-bc18-4341-b08e-c87be4b50e32	WRONG_ANSWER	5	988	2026-06-21 01:28:51.252576+07	\N	\N	131005719
8924	459	120	63089049-b316-48d7-bf57-6e6801a98db9	WRONG_ANSWER	4	876	2026-06-21 01:28:51.252575+07	\N	\N	1609477383
8928	459	124	08c949d3-a2c4-4764-9d8b-7d0c5a2285fa	WRONG_ANSWER	6	1284	2026-06-21 01:28:51.252578+07	\N	\N	337466273
8930	459	126	b87a7189-2b3c-4fd4-a459-e289e21b3784	WRONG_ANSWER	5	1088	2026-06-21 01:28:51.25258+07	\N	\N	-760924093
8929	459	125	c4ac964a-b0c2-4473-bc83-e55b5dd8ed2f	WRONG_ANSWER	5	1088	2026-06-21 01:28:51.252579+07	\N	\N	404026447
8927	459	123	60217760-2d34-4043-9704-a7dbd29e8142	WRONG_ANSWER	5	1032	2026-06-21 01:28:51.252577+07	\N	\N	197161384
8935	459	131	9d461902-948e-40c6-a709-5c4cdffff922	WRONG_ANSWER	4	1016	2026-06-21 01:28:51.252584+07	\N	\N	33
8933	459	129	3a3c8e3e-1099-4639-bc42-a93bf6fcf010	WRONG_ANSWER	7	944	2026-06-21 01:28:51.252583+07	\N	\N	136
8931	459	127	51bb6fd0-fa60-4f09-bf03-823fc3a17a1e	WRONG_ANSWER	5	1016	2026-06-21 01:28:51.252581+07	\N	\N	120
8932	459	128	f3ed28b1-45a9-4e1a-ae58-897e3e4c9f8e	WRONG_ANSWER	5	1012	2026-06-21 01:28:51.252582+07	\N	\N	66
8934	459	130	f97a6731-bd71-4b51-97d2-dd2a526a33c8	WRONG_ANSWER	5	1012	2026-06-21 01:28:51.252584+07	\N	\N	1
8938	459	134	ae222420-761e-44b5-aa68-1cc959e176a4	WRONG_ANSWER	5	1040	2026-06-21 01:28:51.252587+07	\N	\N	-10
8936	459	132	da8f4fad-7cfb-4339-b76f-153e5c8045d3	WRONG_ANSWER	4	1060	2026-06-21 01:28:51.252585+07	\N	\N	71
8937	459	133	c00f8382-ae6b-4d4e-ab5a-5262294ad6b0	WRONG_ANSWER	4	1176	2026-06-21 01:28:51.252586+07	\N	\N	139
8941	459	137	52c8f4f0-4d46-4d6a-8da5-18db18cc2d90	WRONG_ANSWER	3	1052	2026-06-21 01:28:51.252589+07	\N	\N	-128
8940	459	136	b4c995e0-9a75-444d-ad33-d4eaccd32efc	WRONG_ANSWER	3	1052	2026-06-21 01:28:51.252589+07	\N	\N	-55
8939	459	135	7b1aad4f-5f06-432d-b488-49bafdbd3ff4	WRONG_ANSWER	3	1384	2026-06-21 01:28:51.252588+07	\N	\N	-145
8942	459	138	2e3347b6-bf51-4bac-95e0-24efc6afaf14	WRONG_ANSWER	2	1056	2026-06-21 01:28:51.25259+07	\N	\N	77
9154	463	30	d21d3da2-2dd0-4a2b-92e9-84eb414ce8c1	ACCEPTED	6	984	2026-06-21 02:02:18.789322+07	\N	\N	0
9145	463	21	c785dfc7-5ff7-441d-a5b5-486e634e2290	ACCEPTED	5	1020	2026-06-21 02:02:18.789313+07	\N	\N	3
9163	463	57	a7a3574b-e700-4c24-9878-ab19d84868dc	ACCEPTED	5	868	2026-06-21 02:02:18.789327+07	\N	\N	787228
9149	463	25	ef7cc943-3e21-4835-9602-9d6f35d5716d	ACCEPTED	5	1028	2026-06-21 02:02:18.789317+07	\N	\N	300
9162	463	38	a5bd8ae5-d184-4f0b-badf-d0f656dc241f	ACCEPTED	4	996	2026-06-21 02:02:18.789327+07	\N	\N	3000000
9170	463	64	522995e4-7d19-4bdc-b2e6-c79ea67d36df	ACCEPTED	5	1092	2026-06-21 02:02:18.789331+07	\N	\N	710339
9177	463	71	d14b045f-81d2-4840-84fc-18857f183fc6	ACCEPTED	5	876	2026-06-21 02:02:18.789335+07	\N	\N	1416847
9187	463	81	570a3f0b-071b-46a8-bc9b-63cc299c022b	ACCEPTED	6	1092	2026-06-21 02:02:18.789343+07	\N	\N	-846475
9192	463	86	02311da9-5848-4d7c-b76a-6425ee3fa219	ACCEPTED	4	872	2026-06-21 02:02:18.789346+07	\N	\N	-876295
9196	463	90	a58a5546-cd73-45c3-9b29-5086f5f39f88	ACCEPTED	5	880	2026-06-21 02:02:18.789348+07	\N	\N	-1520451
9197	463	91	e4d537e4-eda7-402c-a15d-94fda493a974	ACCEPTED	5	880	2026-06-21 02:02:18.789349+07	\N	\N	-1113725
9210	463	104	a26fdfb0-0476-47f9-909f-3bdee87c932c	ACCEPTED	5	1076	2026-06-21 02:02:18.789365+07	\N	\N	514364
9223	463	117	7d050c7b-dba4-452e-9a7e-6edd26b526b0	ACCEPTED	5	1016	2026-06-21 02:02:18.789373+07	\N	\N	362210245
9224	463	118	d8f2dea7-860e-49a0-8c6b-84892ae10c02	ACCEPTED	5	1028	2026-06-21 02:02:18.789374+07	\N	\N	636465324
9222	463	116	5febade2-c800-49c9-a486-cfffdb6a787c	ACCEPTED	5	1032	2026-06-21 02:02:18.789372+07	\N	\N	785356
9226	463	120	d606456a-b7b1-4a2c-9920-db8ff150620d	ACCEPTED	5	1076	2026-06-21 02:02:18.789375+07	\N	\N	371467497
9228	463	122	4ae7232e-ca70-43a8-85e9-97e49d1c4f5d	ACCEPTED	6	908	2026-06-21 02:02:18.789376+07	\N	\N	-457820119
9232	463	126	f6dca960-b149-4628-859a-d5b5c85b49d7	ACCEPTED	9	1040	2026-06-21 02:02:18.78938+07	\N	\N	-882105735
9225	463	119	cbcd7c4f-a28c-42bc-b9d2-1a2db8f35f1f	ACCEPTED	5	1084	2026-06-21 02:02:18.789374+07	\N	\N	-738231997
9230	463	124	b89cb6d8-7422-452a-9a8c-3b14bbaa1289	ACCEPTED	5	1016	2026-06-21 02:02:18.789379+07	\N	\N	1610593689
9231	463	125	47dcc1b9-b31c-46db-87e7-258aeb39cefd	ACCEPTED	5	1044	2026-06-21 02:02:18.789379+07	\N	\N	86961293
9233	463	127	b56ca95d-0a7f-4eaf-a5a2-72917ad57a07	ACCEPTED	5	1020	2026-06-21 02:02:18.789381+07	\N	\N	0
9235	463	129	87e81661-cc3c-40fd-a605-227e2490bd27	ACCEPTED	5	864	2026-06-21 02:02:18.789382+07	\N	\N	-32
9234	463	128	a8c87f14-9791-4f4b-85e4-0f38b35f857c	ACCEPTED	4	1028	2026-06-21 02:02:18.789381+07	\N	\N	82
9236	463	130	a2862117-98c5-48b2-b472-6d4a30475b8b	ACCEPTED	4	1048	2026-06-21 02:02:18.789382+07	\N	\N	-5
9237	463	131	e6a24cd9-4299-4c5f-bdff-be55ee10e6bd	ACCEPTED	5	1024	2026-06-21 02:02:18.789383+07	\N	\N	71
9240	463	134	41ed1bbb-64a9-4075-b4cb-bc05fb4c6a8d	ACCEPTED	4	1116	2026-06-21 02:02:18.789385+07	\N	\N	158
9241	463	135	711106fa-b590-478d-bf7f-57f335c788ec	ACCEPTED	3	868	2026-06-21 02:02:18.789386+07	\N	\N	3
9242	463	136	b6a9cce3-6df5-411d-9950-e31adce65e31	ACCEPTED	3	1028	2026-06-21 02:02:18.789386+07	\N	\N	129
9244	463	138	03abcf43-3bce-4f58-aec3-c5e4617bfc84	ACCEPTED	4	1120	2026-06-21 02:02:18.789388+07	\N	\N	51
9243	463	137	172e1eba-ed56-480e-a7d1-96fa4a595a17	ACCEPTED	3	1052	2026-06-21 02:02:18.789387+07	\N	\N	64
9283	464	77	3325e96f-48ee-4467-8fba-38ade2a0b9f2	ACCEPTED	4	1016	2026-06-21 02:47:49.626432+07	\N	\N	-987624
9290	464	84	0a3ac997-26e6-4d1f-8bdc-1fa3b4983dc8	ACCEPTED	5	888	2026-06-21 02:47:49.626459+07	\N	\N	-734921
9302	464	96	3855c2cd-4f86-4b1b-a4f9-f89996838411	ACCEPTED	4	1020	2026-06-21 02:47:49.626493+07	\N	\N	-1188270
9308	464	102	9546514f-1db9-4d98-afbd-14385a62bed9	ACCEPTED	5	984	2026-06-21 02:47:49.626509+07	\N	\N	-619866
9333	464	127	72afeb90-8630-40a6-872a-20de7fa37d17	ACCEPTED	5	876	2026-06-21 02:47:49.626589+07	\N	\N	0
9339	464	133	cfd57202-36b0-47e4-9019-81afd603842e	ACCEPTED	5	980	2026-06-21 02:47:49.626607+07	\N	\N	-57
9344	464	138	e9c0715e-056d-475c-8c6f-39d4d44461be	ACCEPTED	3	1060	2026-06-21 02:47:49.626622+07	\N	\N	51
9296	464	90	61f5779f-124c-4d3b-8521-ea1cf23d46bd	ACCEPTED	5	1024	2026-06-21 02:47:49.626477+07	\N	\N	-1520451
9314	464	108	75f732dd-e84f-44b1-ae33-b6a2cabd1f3d	ACCEPTED	4	1032	2026-06-21 02:47:49.626527+07	\N	\N	1436130
9309	464	103	86e5f137-b28f-4d16-b040-8c8b497ac779	ACCEPTED	6	976	2026-06-21 02:47:49.626512+07	\N	\N	283996
9318	464	112	a5cbc04f-7b4c-414d-a9f9-21f1653d3d41	ACCEPTED	5	1028	2026-06-21 02:47:49.626548+07	\N	\N	649261
9330	464	124	f808e8f7-a69b-479b-8bf1-13afa8c14c5d	ACCEPTED	6	1016	2026-06-21 02:47:49.626581+07	\N	\N	1610593689
9353	465	29	8b7fa409-47e0-4c6a-a623-54a608491e98	ACCEPTED	5	872	2026-06-21 04:03:40.418454+07	\N	\N	99
9346	465	22	8410b04a-d608-4ed7-8794-a664dbb6c1de	ACCEPTED	6	1008	2026-06-21 04:03:40.41844+07	\N	\N	30
9349	465	25	c90c25f5-31cc-42af-9fae-586c355ade63	ACCEPTED	5	1012	2026-06-21 04:03:40.418447+07	\N	\N	300
9348	465	24	29a6ea8b-f47a-4a70-95a0-89bc04965f89	ACCEPTED	6	1028	2026-06-21 04:03:40.418445+07	\N	\N	0
9359	465	35	0409247d-240b-43a4-b831-6c4f696d14d7	ACCEPTED	6	1020	2026-06-21 04:03:40.418466+07	\N	\N	-2
9351	465	27	c1667384-d33a-4425-a841-04bf28b6ef0a	ACCEPTED	7	1020	2026-06-21 04:03:40.41845+07	\N	\N	1000
9364	465	58	e2b16c96-292f-41cd-b372-9d0d08d6ff0a	ACCEPTED	5	852	2026-06-21 04:03:40.418476+07	\N	\N	803799
9358	465	34	7060c7c5-78f6-4341-87be-568feeff09b3	ACCEPTED	7	1020	2026-06-21 04:03:40.418463+07	\N	\N	15
9361	465	37	190dede3-39e3-4fb7-937e-38dafe2bf2d4	ACCEPTED	6	1048	2026-06-21 04:03:40.41847+07	\N	\N	1000
9357	465	33	bb68b745-ee99-4240-a346-2f79a93199cf	ACCEPTED	5	1088	2026-06-21 04:03:40.418462+07	\N	\N	84
9347	465	23	0e3d2479-3ac7-4868-8d13-49fb93b83795	ACCEPTED	5	1036	2026-06-21 04:03:40.418442+07	\N	\N	0
9363	465	57	a4a07817-e169-45f7-b805-038446cbd6bd	ACCEPTED	5	876	2026-06-21 04:03:40.418474+07	\N	\N	787228
9355	465	31	418f819b-b2c1-4d0d-ba1c-6699b4d5cb8c	ACCEPTED	6	868	2026-06-21 04:03:40.418458+07	\N	\N	30000
9360	465	36	abbc112f-2861-4aa1-ade8-9016af83bc82	ACCEPTED	6	1024	2026-06-21 04:03:40.418468+07	\N	\N	801
9362	465	38	7799b84e-1868-4120-9e20-ced842dc15f3	ACCEPTED	8	1048	2026-06-21 04:03:40.418472+07	\N	\N	3000000
9368	465	62	b18438dc-684f-4f31-8249-87e2f24b360c	ACCEPTED	8	1024	2026-06-21 04:03:40.418483+07	\N	\N	1486218
9356	465	32	7bf33724-ce08-4aad-9940-70a5ede3b866	ACCEPTED	7	1028	2026-06-21 04:03:40.41846+07	\N	\N	0
9367	465	61	8d8e9f39-2681-4168-8bc4-38fdde7db466	ACCEPTED	8	880	2026-06-21 04:03:40.418481+07	\N	\N	879721
9366	465	60	a4b5053e-ad20-4514-b9f9-b515edec1b8a	ACCEPTED	6	1020	2026-06-21 04:03:40.418479+07	\N	\N	380371
9365	465	59	e652b4f0-f62b-4bae-ae07-6773b6fc447e	ACCEPTED	8	1088	2026-06-21 04:03:40.418478+07	\N	\N	545178
9374	465	68	b82c31ea-58ba-46c9-887c-6517b83b002b	ACCEPTED	5	1032	2026-06-21 04:03:40.418494+07	\N	\N	1161167
9376	465	70	f300b9c3-440e-4dc3-a87b-5b5a43f7dda9	ACCEPTED	6	984	2026-06-21 04:03:40.418498+07	\N	\N	959298
9373	465	67	2a73d5f1-a876-4c81-8e48-2f411c10996f	ACCEPTED	5	876	2026-06-21 04:03:40.418492+07	\N	\N	473222
9372	465	66	6e0dea8b-4b77-46e3-97d1-1ad83cd83ed0	ACCEPTED	4	1020	2026-06-21 04:03:40.41849+07	\N	\N	129492
9380	465	74	d0bf0452-ee88-4c4f-aed0-ddee3f767572	ACCEPTED	5	1016	2026-06-21 04:03:40.418505+07	\N	\N	909595
9377	465	71	c3313380-ad95-427d-9a83-2c803936bd3e	ACCEPTED	5	1092	2026-06-21 04:03:40.418499+07	\N	\N	1416847
9386	465	80	62f3c3af-de86-40ff-aaff-b8a208d30c80	ACCEPTED	5	1024	2026-06-21 04:03:40.418517+07	\N	\N	-1611196
9375	465	69	72d8431d-5cc1-4998-8163-012ca4ac3422	ACCEPTED	5	1088	2026-06-21 04:03:40.418496+07	\N	\N	616334
9384	465	78	2d6d69be-3b6a-4b13-8672-883c7f6e5c59	ACCEPTED	5	872	2026-06-21 04:03:40.418513+07	\N	\N	-824805
9382	465	76	ca5ea22f-57d0-4a23-a0a2-a43a37c0d5f1	ACCEPTED	5	1020	2026-06-21 04:03:40.418509+07	\N	\N	802483
9387	465	81	e6672e4a-04fd-4a1a-aff8-4c0f261247ce	ACCEPTED	5	1088	2026-06-21 04:03:40.418519+07	\N	\N	-846475
9385	465	79	4a65ae8e-8690-4ce3-98a8-dcda4d4f6c21	ACCEPTED	4	872	2026-06-21 04:03:40.418515+07	\N	\N	-1351853
9379	465	73	febd9320-c74a-4c84-a2fa-653299a1575f	ACCEPTED	5	980	2026-06-21 04:03:40.418503+07	\N	\N	702179
9371	465	65	b0492eed-e0a1-4f51-880e-512a396c78d0	ACCEPTED	4	1012	2026-06-21 04:03:40.418489+07	\N	\N	475745
9389	465	83	f63cb6ea-01ec-470c-9c43-36c326202b0b	ACCEPTED	5	1096	2026-06-21 04:03:40.418543+07	\N	\N	-1500204
9383	465	77	53abc66a-e2b4-49d6-bc90-62cdab031fe3	ACCEPTED	4	876	2026-06-21 04:03:40.418511+07	\N	\N	-987624
9388	465	82	3babe2d9-2bc7-42f8-ac42-f00344c7cc92	ACCEPTED	5	876	2026-06-21 04:03:40.418541+07	\N	\N	-1795574
9390	465	84	f45d97e9-6994-4a2f-9bcc-9eebc793fb54	ACCEPTED	5	1032	2026-06-21 04:03:40.418545+07	\N	\N	-734921
9392	465	86	1339a7c6-c3b8-49fd-8804-918cf63704df	ACCEPTED	4	1028	2026-06-21 04:03:40.418549+07	\N	\N	-876295
9391	465	85	20344531-36cd-4807-8782-0995177a5a8c	ACCEPTED	6	1024	2026-06-21 04:03:40.418547+07	\N	\N	-1006285
9407	465	101	810af0e6-2881-4ca3-8583-d268f54db4fc	ACCEPTED	6	1020	2026-06-21 04:03:40.418577+07	\N	\N	28962
9396	465	90	8783b5b8-ade7-4038-b594-d3fd1ce9bfb7	ACCEPTED	5	1096	2026-06-21 04:03:40.418556+07	\N	\N	-1520451
9397	465	91	1a3136a6-3844-4874-b698-04c1c7ec8b7e	ACCEPTED	5	908	2026-06-21 04:03:40.418558+07	\N	\N	-1113725
9394	465	88	fd7920e6-5de6-4554-97ef-3c930e4c3afd	ACCEPTED	4	1012	2026-06-21 04:03:40.418553+07	\N	\N	-955984
9406	465	100	8f72251f-3ebd-4266-9d4d-f31a7c2ba6d0	ACCEPTED	5	1028	2026-06-21 04:03:40.418575+07	\N	\N	281928
9398	465	92	351e4044-ad87-4606-8614-4ab29d92e272	ACCEPTED	6	1020	2026-06-21 04:03:40.41856+07	\N	\N	-471131
9405	465	99	892ca330-e7cb-41a6-ba08-3250519c070e	ACCEPTED	5	980	2026-06-21 04:03:40.418574+07	\N	\N	-1225775
9400	465	94	8ee7f3ed-cab1-41a2-b252-184581876a69	ACCEPTED	5	1096	2026-06-21 04:03:40.418564+07	\N	\N	-717234
9404	465	98	0e071d6e-60bf-4ba3-9825-d10fd088576a	ACCEPTED	5	868	2026-06-21 04:03:40.418571+07	\N	\N	99178
9408	465	102	6f7f9d5d-9324-4aea-9b5f-32ba1ee294f7	ACCEPTED	5	1088	2026-06-21 04:03:40.418579+07	\N	\N	-619866
9403	465	97	bf574858-a593-44e0-b3ae-fc53bf454d00	ACCEPTED	4	868	2026-06-21 04:03:40.418569+07	\N	\N	-517131
9399	465	93	efcd9532-1538-4f48-920a-87060e3149d0	ACCEPTED	5	1028	2026-06-21 04:03:40.418562+07	\N	\N	-422973
9401	465	95	521f7cb8-24ea-46f5-9919-2f7dcbdb373c	ACCEPTED	5	1032	2026-06-21 04:03:40.418566+07	\N	\N	-1192974
9345	465	21	f3a42a41-5e41-48e1-a63a-15215c57b8b9	ACCEPTED	13	1108	2026-06-21 04:03:40.418428+07	\N	\N	3
9352	465	28	2bc60264-c578-4c12-ac2f-76c4700d8d9e	ACCEPTED	6	1040	2026-06-21 04:03:40.418452+07	\N	\N	579
9350	465	26	c7112381-d907-4021-86ac-260273cc9dac	ACCEPTED	7	1000	2026-06-21 04:03:40.418448+07	\N	\N	-30
9354	465	30	980b42f4-d11e-488d-87f2-a65a1a95262d	ACCEPTED	8	872	2026-06-21 04:03:40.418456+07	\N	\N	0
9369	465	63	a5755d00-e646-419b-af91-a992de89d66f	ACCEPTED	7	988	2026-06-21 04:03:40.418485+07	\N	\N	1507378
9370	465	64	392db459-aef9-41e4-a937-405aa75a5614	ACCEPTED	5	880	2026-06-21 04:03:40.418487+07	\N	\N	710339
9378	465	72	ab65c715-ad94-4a47-91ff-8b85dd1332b0	ACCEPTED	4	868	2026-06-21 04:03:40.418501+07	\N	\N	1011312
9381	465	75	e7df413e-0169-4fbe-baa9-d409a071fe72	ACCEPTED	5	1096	2026-06-21 04:03:40.418507+07	\N	\N	1760278
9393	465	87	b25bf1ed-1113-4ed1-9ef3-5b59cde91827	ACCEPTED	6	1076	2026-06-21 04:03:40.418551+07	\N	\N	-1189260
9395	465	89	fad00897-1c85-4016-b881-43e125bf921d	ACCEPTED	4	864	2026-06-21 04:03:40.418555+07	\N	\N	-902015
9410	465	104	987680f8-18f1-43f9-8198-8cdce849c675	ACCEPTED	5	1028	2026-06-21 04:03:40.418583+07	\N	\N	514364
9414	465	108	1d247b14-10a8-45b0-bf9d-b7e9498bafed	ACCEPTED	5	1020	2026-06-21 04:03:40.41859+07	\N	\N	1436130
9409	465	103	6ee02db5-8e7a-4d65-a1be-d999fc48e011	ACCEPTED	4	844	2026-06-21 04:03:40.418581+07	\N	\N	283996
9402	465	96	9046f22f-1820-4a43-bbc0-6972bf114094	ACCEPTED	5	892	2026-06-21 04:03:40.418567+07	\N	\N	-1188270
9413	465	107	e179831d-2260-4022-b476-96e147134530	ACCEPTED	5	1028	2026-06-21 04:03:40.418588+07	\N	\N	-34648
9415	465	109	5a60b23c-79a3-4178-9d94-45c955741eae	ACCEPTED	4	856	2026-06-21 04:03:40.418592+07	\N	\N	792531
9411	465	105	9542ae1f-146a-410f-9e39-2b60388f20b7	ACCEPTED	4	1096	2026-06-21 04:03:40.418584+07	\N	\N	-882565
9412	465	106	7210277f-371c-41e4-be0b-ad08cfeda863	ACCEPTED	5	1072	2026-06-21 04:03:40.418586+07	\N	\N	-815576
9416	465	110	3952c245-4757-4aa7-84d6-e72dfea65249	ACCEPTED	4	876	2026-06-21 04:03:40.418593+07	\N	\N	-572819
9418	465	112	c017fe4d-8f0b-4389-a251-e75cd67242a5	ACCEPTED	5	1048	2026-06-21 04:03:40.418597+07	\N	\N	649261
9417	465	111	a9e3f288-0acc-431a-8e11-02759920e4a0	ACCEPTED	5	860	2026-06-21 04:03:40.418595+07	\N	\N	-309452
9419	465	113	b374e19f-adf3-4f3c-b921-9edae397d262	ACCEPTED	5	1036	2026-06-21 04:03:40.418599+07	\N	\N	-1143916
9421	465	115	e8e79310-d6a8-431d-ac42-6d8b2f472050	ACCEPTED	4	868	2026-06-21 04:03:40.418603+07	\N	\N	506806
9424	465	118	a45c0180-c664-4f42-bd3f-840c37106188	ACCEPTED	4	1012	2026-06-21 04:03:40.418609+07	\N	\N	636465324
9420	465	114	1a833bc6-95e2-474f-8d8f-50ef70c57ef4	ACCEPTED	4	1020	2026-06-21 04:03:40.418601+07	\N	\N	-234796
9422	465	116	7cad2c03-a4bf-4e49-a2f7-6e903505981b	ACCEPTED	5	888	2026-06-21 04:03:40.418604+07	\N	\N	785356
9426	465	120	3756bc51-5475-48b0-b40b-ea51dea14ae5	ACCEPTED	5	1084	2026-06-21 04:03:40.418613+07	\N	\N	371467497
9428	465	122	62168fc2-77c9-49fd-8090-64da8938e55a	ACCEPTED	4	1016	2026-06-21 04:03:40.418616+07	\N	\N	-457820119
9432	465	126	de258882-2c19-4eff-a9db-c217a6a035ff	ACCEPTED	5	852	2026-06-21 04:03:40.418625+07	\N	\N	-882105735
9431	465	125	4c6a0ddd-c724-4779-91bd-334691146e38	ACCEPTED	4	1088	2026-06-21 04:03:40.418623+07	\N	\N	86961293
9425	465	119	c5bc2b7c-3930-4cad-a780-c76580239771	ACCEPTED	5	1012	2026-06-21 04:03:40.418611+07	\N	\N	-738231997
9423	465	117	70cc8ddf-577d-44b3-9f71-4368d8727c1e	ACCEPTED	4	940	2026-06-21 04:03:40.418606+07	\N	\N	362210245
9429	465	123	49cb6f42-5ce3-4c15-9f8f-725235f2c4d5	ACCEPTED	5	1020	2026-06-21 04:03:40.418619+07	\N	\N	1422690276
9435	465	129	033b8f79-88e7-4fb4-b270-013f3c6f64c5	ACCEPTED	5	1024	2026-06-21 04:03:40.41863+07	\N	\N	-32
9430	465	124	09290e31-3edd-4f71-9870-2553e5ba48ac	ACCEPTED	6	1076	2026-06-21 04:03:40.418621+07	\N	\N	1610593689
9427	465	121	b13c3270-f95e-4910-a18e-1d73d9cd585d	ACCEPTED	4	1080	2026-06-21 04:03:40.418614+07	\N	\N	1259817393
9439	465	133	c7b5985f-1fbf-4d6e-aa96-c0768aea31a1	ACCEPTED	5	1120	2026-06-21 04:03:40.418638+07	\N	\N	-57
9438	465	132	6242225d-e918-422b-8673-7bf6c8c4716e	ACCEPTED	4	1040	2026-06-21 04:03:40.418635+07	\N	\N	-1
9437	465	131	6a69a8eb-1712-49de-b0f5-1938a970d6c0	ACCEPTED	5	992	2026-06-21 04:03:40.418634+07	\N	\N	71
9434	465	128	c2fb1544-f4ab-4357-8d74-b5228371016b	ACCEPTED	5	1020	2026-06-21 04:03:40.418628+07	\N	\N	82
9436	465	130	7c0339f0-e2df-436c-b231-681f56231a2a	ACCEPTED	4	1060	2026-06-21 04:03:40.418632+07	\N	\N	-5
9433	465	127	06e34bfd-7cb7-40ea-b224-5b23266b8bc2	ACCEPTED	5	1020	2026-06-21 04:03:40.418627+07	\N	\N	0
9440	465	134	1893cf76-3a37-4e16-972b-f926a46461a8	ACCEPTED	3	1072	2026-06-21 04:03:40.418639+07	\N	\N	158
9441	465	135	21557ba5-c3d0-4d35-b479-7d3a83a067b9	ACCEPTED	4	1244	2026-06-21 04:03:40.418641+07	\N	\N	3
9442	465	136	2e11961f-3f82-4900-a7c6-e046b9c1672b	ACCEPTED	4	1324	2026-06-21 04:03:40.418643+07	\N	\N	129
9444	465	138	f4800c6e-3e63-473e-9a5b-0df794c844cb	ACCEPTED	2	1048	2026-06-21 04:03:40.418646+07	\N	\N	51
9443	465	137	405d51f3-092e-4373-bbfd-888d9c446a7b	ACCEPTED	2	1204	2026-06-21 04:03:40.418644+07	\N	\N	64
9445	466	21	c83685a3-2a56-4ebc-bd12-8e7ffee4eb5b	ACCEPTED	5	12212	2026-06-21 15:27:25.530705+07	\N	\N	3
9449	466	25	1310adcb-8cfa-4070-bf04-0f3bd8607b43	ACCEPTED	5	5720	2026-06-21 15:27:25.530727+07	\N	\N	300
9446	466	22	024bdf74-b44a-48bb-a628-2c5873ca6871	ACCEPTED	5	1036	2026-06-21 15:27:25.53072+07	\N	\N	30
9448	466	24	d893a66b-133f-49e1-9597-240eaae0d6ec	ACCEPTED	4	4628	2026-06-21 15:27:25.530725+07	\N	\N	0
9451	466	27	2f1c5938-8f1d-46e4-ba1c-28ccda674d7f	ACCEPTED	5	892	2026-06-21 15:27:25.53073+07	\N	\N	1000
9450	466	26	53674945-b8b2-4774-9a1f-a953c1324661	ACCEPTED	4	5528	2026-06-21 15:27:25.530728+07	\N	\N	-30
9447	466	23	41cfab3b-2d46-4ba6-b4d6-38ae37d6bc45	ACCEPTED	4	6236	2026-06-21 15:27:25.530722+07	\N	\N	0
9453	466	29	658ff9f9-bb2b-4952-8657-b553849c1993	ACCEPTED	6	1168	2026-06-21 15:27:25.530734+07	\N	\N	99
9454	466	30	c493592a-5fbb-4d00-992e-fdbf709e2223	ACCEPTED	5	2124	2026-06-21 15:27:25.530736+07	\N	\N	0
9452	466	28	9491ada6-3ca3-453b-a734-f6e57ad76cc8	ACCEPTED	4	1040	2026-06-21 15:27:25.530732+07	\N	\N	579
9455	466	31	a4926723-9cce-41f3-93d5-0d5469a68832	ACCEPTED	5	1032	2026-06-21 15:27:25.530738+07	\N	\N	30000
9459	466	35	a5b06768-d46d-4d09-b601-095256c700bb	ACCEPTED	5	1032	2026-06-21 15:27:25.530746+07	\N	\N	-2
9467	466	61	c14c8175-14f9-46dd-960e-9c3753022ddc	ACCEPTED	5	1032	2026-06-21 15:27:25.530762+07	\N	\N	879721
9466	466	60	a63e1522-2737-4edb-b8cd-bb600aff5ba6	ACCEPTED	6	1032	2026-06-21 15:27:25.53076+07	\N	\N	380371
9456	466	32	8403f691-27de-448e-b8f2-61e519437abc	ACCEPTED	6	1304	2026-06-21 15:27:25.53074+07	\N	\N	0
9462	466	38	55a4da76-29ae-4bf2-82ec-6f103dfa1367	ACCEPTED	4	1092	2026-06-21 15:27:25.530752+07	\N	\N	3000000
9458	466	34	0e57f9c5-1f66-4840-9c91-077d6be00a03	ACCEPTED	4	880	2026-06-21 15:27:25.530744+07	\N	\N	15
9486	466	80	53a3db5e-53b7-4b7c-8073-eca798f64ddf	ACCEPTED	5	1008	2026-06-21 15:27:25.530798+07	\N	\N	-1611196
9470	466	64	90e81448-63d3-4864-be55-f266787af4a5	ACCEPTED	5	888	2026-06-21 15:27:25.530768+07	\N	\N	710339
9478	466	72	1f647843-5d04-4e5c-990f-97dfd44fcba5	ACCEPTED	4	888	2026-06-21 15:27:25.530783+07	\N	\N	1011312
9472	466	66	837a2138-5b3e-4720-86df-75fc9e559f3e	ACCEPTED	5	1004	2026-06-21 15:27:25.530772+07	\N	\N	129492
9484	466	78	651ce31d-ae88-4e31-8551-0b197bf98c2c	ACCEPTED	5	1000	2026-06-21 15:27:25.530795+07	\N	\N	-824805
9476	466	70	6a701844-e9f7-41c6-a528-2c835c1d964a	ACCEPTED	4	1096	2026-06-21 15:27:25.530779+07	\N	\N	959298
9490	466	84	7bb9dc7f-f33b-4aeb-900d-6f89a63f1864	ACCEPTED	5	888	2026-06-21 15:27:25.530806+07	\N	\N	-734921
9487	466	81	01cebe0c-a86f-4d6e-b2e0-99e56dd052eb	ACCEPTED	5	1036	2026-06-21 15:27:25.5308+07	\N	\N	-846475
9473	466	67	e4fe0a30-7411-497a-8709-0ad2df968394	ACCEPTED	5	1124	2026-06-21 15:27:25.530774+07	\N	\N	473222
9477	466	71	1b16251a-8c0e-4297-90f3-1046bbaa6a21	ACCEPTED	5	1036	2026-06-21 15:27:25.530781+07	\N	\N	1416847
9474	466	68	c4f432aa-c6a3-468a-b8a0-ab49e022d439	ACCEPTED	5	880	2026-06-21 15:27:25.530776+07	\N	\N	1161167
9492	466	86	49837303-a467-4a6a-a8b0-02c4631d234b	ACCEPTED	7	1000	2026-06-21 15:27:25.53081+07	\N	\N	-876295
9485	466	79	524179b7-41e5-460d-bb4c-b25fa9b836cc	ACCEPTED	4	1076	2026-06-21 15:27:25.530797+07	\N	\N	-1351853
9475	466	69	9248ee6b-366b-4747-b746-e260477b1b38	ACCEPTED	5	1040	2026-06-21 15:27:25.530777+07	\N	\N	616334
9491	466	85	2205dfa3-9762-4ed2-8511-957f9c790837	ACCEPTED	4	1128	2026-06-21 15:27:25.530808+07	\N	\N	-1006285
9481	466	75	b5ea7f8f-8212-433b-bd03-289162a04fbb	ACCEPTED	4	1028	2026-06-21 15:27:25.530789+07	\N	\N	1760278
9480	466	74	48b0aae3-dc82-4bb7-b522-31d9b2367067	ACCEPTED	5	1104	2026-06-21 15:27:25.530787+07	\N	\N	909595
9482	466	76	e356e6bc-89ff-44f0-95bb-87d1d5910007	ACCEPTED	6	884	2026-06-21 15:27:25.530791+07	\N	\N	802483
9479	466	73	5de1e279-8c2f-4282-80c0-7854640ca3c3	ACCEPTED	5	1052	2026-06-21 15:27:25.530785+07	\N	\N	702179
9489	466	83	e36d1dec-cc94-4cef-8ee8-037065964c2b	ACCEPTED	5	1044	2026-06-21 15:27:25.530804+07	\N	\N	-1500204
9483	466	77	18a12858-5604-4ec6-bb7c-344d8ca258ed	ACCEPTED	5	884	2026-06-21 15:27:25.530793+07	\N	\N	-987624
9471	466	65	8215883d-6694-4259-afd6-d3608d1b46bb	ACCEPTED	6	900	2026-06-21 15:27:25.53077+07	\N	\N	475745
9469	466	63	d47aa92b-70b3-46c6-be70-5f68f733b33a	ACCEPTED	6	1032	2026-06-21 15:27:25.530766+07	\N	\N	1507378
9488	466	82	1144c9fa-f5ac-4472-9a91-9a3bab13f2b2	ACCEPTED	5	1032	2026-06-21 15:27:25.530802+07	\N	\N	-1795574
9497	466	91	00c3c9f4-aaa4-4e18-b54e-cca9eb932372	ACCEPTED	5	1040	2026-06-21 15:27:25.53082+07	\N	\N	-1113725
9493	466	87	36711d28-16ec-46cd-96a4-2e122304af1c	ACCEPTED	9	1048	2026-06-21 15:27:25.530813+07	\N	\N	-1189260
9507	466	101	37bad0ee-b678-4de3-a77e-a2c6343d401c	ACCEPTED	6	880	2026-06-21 15:27:25.530846+07	\N	\N	28962
9499	466	93	5a4906ac-bf55-4326-851e-5105b01fd908	ACCEPTED	5	900	2026-06-21 15:27:25.530824+07	\N	\N	-422973
9495	466	89	cb9ca4a9-84fc-4167-b870-b2152e8d4cba	ACCEPTED	4	1000	2026-06-21 15:27:25.530816+07	\N	\N	-902015
9498	466	92	c212c79a-069c-47dc-886f-a244be4aadaf	ACCEPTED	6	876	2026-06-21 15:27:25.530822+07	\N	\N	-471131
9503	466	97	37a569c8-e34d-4152-bbbd-618e0221f403	ACCEPTED	11	996	2026-06-21 15:27:25.530832+07	\N	\N	-517131
9511	466	105	deccfe83-ad0a-4b90-a704-8af94ec19303	ACCEPTED	6	1020	2026-06-21 15:27:25.530853+07	\N	\N	-882565
9510	466	104	d3bfd523-f953-40b1-85b7-a0dbbaf07f62	ACCEPTED	11	1088	2026-06-21 15:27:25.530852+07	\N	\N	514364
9502	466	96	a7746876-ad12-4d74-8d7b-510dbebd031f	ACCEPTED	9	1024	2026-06-21 15:27:25.53083+07	\N	\N	-1188270
9504	466	98	6cab2a60-0ce8-4df2-a6c1-5c6db7470b2b	ACCEPTED	6	1088	2026-06-21 15:27:25.530835+07	\N	\N	99178
9514	466	108	ce66dee8-709c-458a-80b4-1954480f231c	ACCEPTED	5	1028	2026-06-21 15:27:25.530859+07	\N	\N	1436130
9501	466	95	51eb142d-1d0b-4d99-92ed-276e8b719c8b	ACCEPTED	5	1004	2026-06-21 15:27:25.530828+07	\N	\N	-1192974
9508	466	102	07dc2651-49a3-412b-a79f-c171b6752067	ACCEPTED	7	1012	2026-06-21 15:27:25.530848+07	\N	\N	-619866
9506	466	100	e361adea-642e-4fff-81bf-c99d1c2f1ea8	ACCEPTED	5	884	2026-06-21 15:27:25.530843+07	\N	\N	281928
9516	466	110	96cb3534-afd5-4a10-863e-c4389c6c609c	ACCEPTED	4	888	2026-06-21 15:27:25.530863+07	\N	\N	-572819
9500	466	94	483db62d-b599-43f8-bed4-3db6a2ca7735	ACCEPTED	5	868	2026-06-21 15:27:25.530826+07	\N	\N	-717234
9505	466	99	52165e22-8d4c-4f5f-ae33-6d6578e97ebe	ACCEPTED	5	876	2026-06-21 15:27:25.530841+07	\N	\N	-1225775
9513	466	107	b61b5186-3c9f-4108-9c84-b658c37ff5e4	ACCEPTED	6	864	2026-06-21 15:27:25.530857+07	\N	\N	-34648
9515	466	109	2ea4554b-6a82-4840-ac6c-585fb3770bbe	ACCEPTED	6	1044	2026-06-21 15:27:25.530861+07	\N	\N	792531
9519	466	113	8259344f-8083-4a5b-aa2f-532d264da110	ACCEPTED	5	852	2026-06-21 15:27:25.530869+07	\N	\N	-1143916
9520	466	114	b8bca711-05f3-44b2-a498-8c423c6fe2e7	ACCEPTED	5	1012	2026-06-21 15:27:25.530871+07	\N	\N	-234796
9518	466	112	767fc75c-ed13-49ff-8b81-9da37c037878	ACCEPTED	5	868	2026-06-21 15:27:25.530867+07	\N	\N	649261
9522	466	116	38aa247b-e375-4be8-8f63-56002999f460	ACCEPTED	5	1056	2026-06-21 15:27:25.530875+07	\N	\N	785356
9524	466	118	3465aab5-b153-4f3e-abaa-a5bb22f8d687	ACCEPTED	5	1032	2026-06-21 15:27:25.530879+07	\N	\N	636465324
9521	466	115	6eaa0c15-a7ac-472d-846d-467af050eed0	ACCEPTED	5	1024	2026-06-21 15:27:25.530873+07	\N	\N	506806
9523	466	117	6a4b6e1f-b28a-4223-8c49-111e10947a2b	ACCEPTED	8	988	2026-06-21 15:27:25.530877+07	\N	\N	362210245
9468	466	62	1ad50c48-15df-4033-86ca-32a31f626f46	ACCEPTED	5	2604	2026-06-21 15:27:25.530763+07	\N	\N	1486218
9465	466	59	5eb566a4-db8a-44d1-8ec7-70822f19104b	ACCEPTED	5	936	2026-06-21 15:27:25.530758+07	\N	\N	545178
9460	466	36	41d41177-f697-4038-bdf5-414ba9e3e5cf	ACCEPTED	7	916	2026-06-21 15:27:25.530748+07	\N	\N	801
9461	466	37	8a5b94e9-dae8-4b40-99ca-accd351ac6da	ACCEPTED	5	996	2026-06-21 15:27:25.53075+07	\N	\N	1000
9463	466	57	5de12981-4f34-4715-991c-9c08ad376443	ACCEPTED	4	1036	2026-06-21 15:27:25.530754+07	\N	\N	787228
9457	466	33	62f1dac1-7dce-437c-b999-2c3c34538576	ACCEPTED	5	1040	2026-06-21 15:27:25.530742+07	\N	\N	84
9464	466	58	0ce5c739-9c5b-4b3d-ae2c-e3e35104c715	ACCEPTED	5	1132	2026-06-21 15:27:25.530756+07	\N	\N	803799
9496	466	90	2f31dcc8-18e6-4bae-acda-6fb6d09e937c	ACCEPTED	5	1024	2026-06-21 15:27:25.530818+07	\N	\N	-1520451
9494	466	88	c17681d5-da32-4243-8b31-7aa7da5dc8cc	ACCEPTED	5	1016	2026-06-21 15:27:25.530814+07	\N	\N	-955984
9509	466	103	81895dcc-ffcf-4329-8eab-4e74f12230d3	ACCEPTED	6	980	2026-06-21 15:27:25.53085+07	\N	\N	283996
9512	466	106	abc210ef-3d1b-48f9-a467-e0a55ecca761	ACCEPTED	6	884	2026-06-21 15:27:25.530855+07	\N	\N	-815576
9517	466	111	ffe035ce-a17f-4977-90ce-97eee8b99201	ACCEPTED	5	1112	2026-06-21 15:27:25.530865+07	\N	\N	-309452
9530	466	124	d70a1a61-196f-498b-a50a-d6a65f822b02	ACCEPTED	6	1048	2026-06-21 15:27:25.530892+07	\N	\N	1610593689
9526	466	120	294ed605-302f-4296-8d77-3af9cd86823d	ACCEPTED	5	964	2026-06-21 15:27:25.530883+07	\N	\N	371467497
9525	466	119	abb4f759-6184-4d1a-8ea1-e252f87c5875	ACCEPTED	4	1096	2026-06-21 15:27:25.530881+07	\N	\N	-738231997
9534	466	128	1159f638-c6ee-441e-a15b-f28675142eb1	ACCEPTED	5	892	2026-06-21 15:27:25.5309+07	\N	\N	82
9532	466	126	c6caea11-733b-4130-af71-f7ae48516d31	ACCEPTED	5	1044	2026-06-21 15:27:25.530896+07	\N	\N	-882105735
9527	466	121	4ad2d94d-df95-49ea-9515-e52191f74b4b	ACCEPTED	7	992	2026-06-21 15:27:25.530885+07	\N	\N	1259817393
9533	466	127	3538b258-d6a4-435b-8281-a912cc65b627	ACCEPTED	5	888	2026-06-21 15:27:25.530898+07	\N	\N	0
9528	466	122	14609ef5-2f23-454e-ae2b-5a495a317dca	ACCEPTED	5	900	2026-06-21 15:27:25.530887+07	\N	\N	-457820119
9537	466	131	0a0b01ce-1dd7-4975-a196-bad7a2473398	ACCEPTED	6	1068	2026-06-21 15:27:25.530906+07	\N	\N	71
9536	466	130	5369f2b1-9b92-4ca1-b221-62dcaf50b74b	ACCEPTED	6	956	2026-06-21 15:27:25.530904+07	\N	\N	-5
9535	466	129	760661f0-6031-4913-b5e7-d573f26ef9cd	ACCEPTED	5	1024	2026-06-21 15:27:25.530902+07	\N	\N	-32
9539	466	133	439dbc93-057b-4dd8-b2ab-e510cab2a871	ACCEPTED	6	1012	2026-06-21 15:27:25.530909+07	\N	\N	-57
9529	466	123	3ee08850-b3f2-4a6e-a0cd-494ad6b442cb	ACCEPTED	5	876	2026-06-21 15:27:25.53089+07	\N	\N	1422690276
9540	466	134	608d8d3e-9f93-45e4-89be-8a43be313acd	ACCEPTED	5	1028	2026-06-21 15:27:25.530911+07	\N	\N	158
9538	466	132	04a09bb4-0ba2-448e-9e78-5fb3beb490ec	ACCEPTED	4	1032	2026-06-21 15:27:25.530908+07	\N	\N	-1
9531	466	125	2bc3e8cd-96d9-4bcd-a32a-61af322870a4	ACCEPTED	5	860	2026-06-21 15:27:25.530894+07	\N	\N	86961293
9541	466	135	2ce165e2-46a8-4990-9c45-81179b9e4fc0	ACCEPTED	3	1076	2026-06-21 15:27:25.530913+07	\N	\N	3
9544	466	138	005add2f-f59b-4846-a88a-c6e5ad805226	ACCEPTED	2	1060	2026-06-21 15:27:25.530919+07	\N	\N	51
9543	466	137	3e8eb60d-3978-4def-8519-9bbf0b575fb4	ACCEPTED	2	1020	2026-06-21 15:27:25.530917+07	\N	\N	64
9542	466	136	02e68dc8-2248-4c53-a5e4-60de009f21f3	ACCEPTED	2	1060	2026-06-21 15:27:25.530915+07	\N	\N	129
9546	467	6	98f070aa-9c1d-4fe1-be8c-ee8372de38e3	ACCEPTED	2	1228	2026-06-21 15:28:02.246652+07	\N	\N	NO\n
9545	467	5	9e44c454-2f06-4a4b-8e75-bb15ee85c3bf	ACCEPTED	2	1452	2026-06-21 15:28:02.246648+07	\N	\N	YES\n
9547	468	3	2cbb125d-b6b4-4629-90b3-d04db0cef3cc	ACCEPTED	79	46192	2026-06-21 15:28:18.565141+07	\N	\N	9\n
9548	468	4	71742349-cd0f-40a3-ae9c-2eda718f0da2	ACCEPTED	82	24668	2026-06-21 15:28:18.565145+07	\N	\N	-1\n
9570	470	240	dcb06da2-56f5-41d9-9177-1a33dee32a91	ACCEPTED	7	872	2026-06-21 17:31:42.195931+07	\N	\N	-401027028
9571	470	241	c2c47682-b369-4241-a6c2-5157fe3d1bd7	ACCEPTED	11	952	2026-06-21 17:31:42.195954+07	\N	\N	-203314843
9569	470	239	ea31432b-75f7-4a2f-b2e7-ad055d20873c	ACCEPTED	5	1096	2026-06-21 17:31:42.195881+07	\N	\N	273849385
9572	470	242	f50d60b2-d9db-44d5-8ea0-7e02c56e2502	ACCEPTED	7	1028	2026-06-21 17:31:42.195957+07	\N	\N	283641974
9574	470	244	e6b9944a-11ef-435d-9cb4-e71442100f02	ACCEPTED	6	1092	2026-06-21 17:31:42.195961+07	\N	\N	-1431541138
9584	470	254	b4ea7131-f8bf-452b-a811-fa3a3e7e72fd	ACCEPTED	8	996	2026-06-21 17:31:42.195984+07	\N	\N	212429559
9575	470	245	1284e4b6-0ad7-4ec7-8016-0f12ebcf651d	ACCEPTED	12	1068	2026-06-21 17:31:42.195964+07	\N	\N	-700642287
9578	470	248	e6330b6c-473c-4c5d-b284-73ed3675d6e3	ACCEPTED	7	872	2026-06-21 17:31:42.19597+07	\N	\N	-198032063
9586	470	256	061edbdd-d95a-4864-ace5-30eb5a390650	ACCEPTED	7	996	2026-06-21 17:31:42.195989+07	\N	\N	497623033
9592	470	262	6a78bd16-29a6-4f8b-ad95-de040b065586	ACCEPTED	7	1028	2026-06-21 17:31:42.196003+07	\N	\N	1666442378
9587	470	257	1d419317-cfb3-4fa9-aa52-03fb97475e1e	ACCEPTED	6	864	2026-06-21 17:31:42.195991+07	\N	\N	422550355
9579	470	249	ef0ac286-02bd-48e8-933e-6499fa9f59f2	ACCEPTED	5	992	2026-06-21 17:31:42.195973+07	\N	\N	-211607636
9589	470	259	bc750f15-288e-440e-bb6c-2c77769a9fdd	ACCEPTED	10	868	2026-06-21 17:31:42.195996+07	\N	\N	579395528
9582	470	252	57620493-1075-4816-bb78-8121fb0b610b	ACCEPTED	6	1012	2026-06-21 17:31:42.19598+07	\N	\N	483695203
9576	470	246	332984de-a600-422a-8712-ad46a92f22a9	ACCEPTED	5	964	2026-06-21 17:31:42.195966+07	\N	\N	1266890788
9585	470	255	3b834362-b583-42be-9774-97c3245850f1	ACCEPTED	5	1028	2026-06-21 17:31:42.195987+07	\N	\N	1706352153
9588	470	258	3e3392d0-1076-4b6e-81dc-6b0d963aabd9	ACCEPTED	5	868	2026-06-21 17:31:42.195994+07	\N	\N	545030965
9591	470	261	92411a6d-3db7-46ff-a0aa-4745cfac8f74	ACCEPTED	5	872	2026-06-21 17:31:42.196001+07	\N	\N	206560568
9590	470	260	5c201b27-014e-4853-9580-b39d4f4c34ab	ACCEPTED	5	876	2026-06-21 17:31:42.195998+07	\N	\N	2588280959
9598	470	268	1d106b1c-f337-4f02-8b3f-bdd2b70e8386	ACCEPTED	6	1024	2026-06-21 17:31:42.196037+07	\N	\N	-1014353723
9594	470	264	ba5fbf06-c27e-4f85-b16e-4ba825c4ef12	ACCEPTED	4	1032	2026-06-21 17:31:42.196008+07	\N	\N	917783106
9597	470	267	2aaec15c-8dc2-4791-bcfc-f5c729a5ee0d	ACCEPTED	4	892	2026-06-21 17:31:42.196034+07	\N	\N	115400280
9595	470	265	d0e08f3c-7b6b-4015-b699-33277b5ea7e8	ACCEPTED	5	1024	2026-06-21 17:31:42.19601+07	\N	\N	1050493913
9603	470	273	157fe90e-3eef-4346-b983-bb5084248aa1	ACCEPTED	5	1092	2026-06-21 17:31:42.196048+07	\N	\N	1049691599
9599	470	269	85eb86b7-701a-4b0d-8a9b-758263854dd1	ACCEPTED	7	1032	2026-06-21 17:31:42.196039+07	\N	\N	-2147559414
9600	470	270	e2102da8-af3f-4415-881c-c50e26fdfcc7	ACCEPTED	6	1028	2026-06-21 17:31:42.196041+07	\N	\N	-1007456528
9607	470	277	835f3a11-a4b0-4c31-a2bb-fd8565f58c5d	ACCEPTED	5	1020	2026-06-21 17:31:42.196057+07	\N	\N	-1256582043
9596	470	266	8ab2db0e-a16a-4118-b69e-9083c57e62e9	ACCEPTED	5	1036	2026-06-21 17:31:42.196032+07	\N	\N	-597076279
9611	470	281	835c910f-6edf-4b3c-9e7e-b076a5e633cb	ACCEPTED	4	1020	2026-06-21 17:31:42.196066+07	\N	\N	-1948669318
9601	470	271	49296c8d-0c81-4cc7-ba0a-dbd3677cfe2b	ACCEPTED	9	1000	2026-06-21 17:31:42.196043+07	\N	\N	-556363809
9606	470	276	4156f8d7-1822-45df-99e4-21a0ba7d0ac5	ACCEPTED	7	1040	2026-06-21 17:31:42.196055+07	\N	\N	-112175442
9610	470	280	0e8fd110-7197-4b70-b7d7-b5a6f455df9c	ACCEPTED	5	1080	2026-06-21 17:31:42.196064+07	\N	\N	-1388090652
9608	470	278	93d7f3d7-f5e1-4537-ab79-fb643eb05ac0	ACCEPTED	4	1084	2026-06-21 17:31:42.196059+07	\N	\N	665324595
9615	470	285	371b7071-bd31-48c2-ab32-68a280d58162	ACCEPTED	4	1020	2026-06-21 17:31:42.196077+07	\N	\N	-1003208150
9609	470	279	abbf6db9-31a4-4d12-844e-ff09f4481152	ACCEPTED	5	1028	2026-06-21 17:31:42.196061+07	\N	\N	-283131955
9612	470	282	9c03b623-1133-4603-99d9-69f463be0105	ACCEPTED	6	880	2026-06-21 17:31:42.196068+07	\N	\N	2225666200
9613	470	283	420cf93e-a421-4f47-9f96-d8fafcb4bbea	ACCEPTED	4	1020	2026-06-21 17:31:42.19607+07	\N	\N	1082551175
9616	470	286	505756ce-4048-4150-a3d1-4e4148187769	ACCEPTED	4	1020	2026-06-21 17:31:42.196079+07	\N	\N	-428385006
9621	470	291	4490ffb6-845a-443c-8645-32dd5f0c4376	ACCEPTED	6	992	2026-06-21 17:31:42.196091+07	\N	\N	-546435835
9620	470	290	0007a85c-ae5e-4da3-98cc-f051f866714a	ACCEPTED	5	1012	2026-06-21 17:31:42.196089+07	\N	\N	-756103384
9617	470	287	1516683f-9433-49d5-9397-5804d76b7c41	ACCEPTED	6	1024	2026-06-21 17:31:42.196082+07	\N	\N	310533072
9623	470	293	27f6b692-0a43-4c35-9031-fdd24df220d9	ACCEPTED	5	1024	2026-06-21 17:31:42.196096+07	\N	\N	-642496329
9626	470	296	d48cd7e6-3d78-43e5-a65a-9c6348429536	ACCEPTED	8	1092	2026-06-21 17:31:42.196102+07	\N	\N	-423710341
9622	470	292	d1787e59-7d4b-4d0d-a3c0-e931d04fdb1d	ACCEPTED	9	844	2026-06-21 17:31:42.196093+07	\N	\N	1267225372
9619	470	289	aff5d6a9-bfde-4228-90a1-78b820fa008b	ACCEPTED	7	1092	2026-06-21 17:31:42.196087+07	\N	\N	-325602117
9632	470	302	4d22a8e7-88c0-48ac-9173-7c11718b9734	ACCEPTED	4	908	2026-06-21 17:31:42.196116+07	\N	\N	593436146
9625	470	295	05a49cd8-7f31-476a-81ea-5facfd76ae20	ACCEPTED	5	868	2026-06-21 17:31:42.1961+07	\N	\N	-794284974
9631	470	301	a2a7fe68-d42c-4014-b232-d1cfdc89264c	ACCEPTED	5	1020	2026-06-21 17:31:42.196113+07	\N	\N	197287472
9627	470	297	fb8b5217-6031-4049-9eb3-f5380b3c76ef	ACCEPTED	4	1032	2026-06-21 17:31:42.196104+07	\N	\N	-874164890
9628	470	298	83e5b943-ba6b-4e28-83e7-bc6bbd78ef98	ACCEPTED	4	1032	2026-06-21 17:31:42.196107+07	\N	\N	857940895
9635	470	305	7f0fba4c-f66d-44f5-afd0-833d86544791	ACCEPTED	4	820	2026-06-21 17:31:42.196124+07	\N	\N	-193325116
9633	470	303	290f26f5-d2d4-4bb3-ba61-4937c1d483e6	ACCEPTED	4	1096	2026-06-21 17:31:42.196118+07	\N	\N	-247107212
9638	470	308	e470a385-fcbe-4581-a23b-3805be359651	ACCEPTED	4	1004	2026-06-21 17:31:42.19613+07	\N	\N	-809478706
9630	470	300	7a0a8cfd-8fa7-4c7c-85f2-4d30f3f32483	ACCEPTED	5	1008	2026-06-21 17:31:42.196111+07	\N	\N	1064057979
9634	470	304	b4dfbaf1-94f4-45d0-8330-b19e3ea746cc	ACCEPTED	5	1032	2026-06-21 17:31:42.19612+07	\N	\N	1428015247
9636	470	306	60e7e880-1856-4d45-8a47-e80354558c31	ACCEPTED	4	1012	2026-06-21 17:31:42.196126+07	\N	\N	-869363187
9640	470	310	01f6d54c-0c4e-475b-95f5-cd3a78ad05f4	ACCEPTED	5	1016	2026-06-21 17:31:42.196135+07	\N	\N	233362019
9641	470	311	6cb01cb9-7b6c-4d1a-953a-37191f84318b	ACCEPTED	7	980	2026-06-21 17:31:42.196137+07	\N	\N	-366264446
9573	470	243	15a7bc7e-ccaa-4bce-af6f-c20320533eab	ACCEPTED	7	844	2026-06-21 17:31:42.195959+07	\N	\N	-1959672151
9577	470	247	0de5f3df-00e0-45ae-9539-734fcdf45e17	ACCEPTED	9	916	2026-06-21 17:31:42.195968+07	\N	\N	84391960
9581	470	251	8b0bc343-47a6-42f8-87fa-ec3b1d38cc72	ACCEPTED	7	868	2026-06-21 17:31:42.195978+07	\N	\N	1942154673
9583	470	253	963796a8-4fbe-4185-8048-8925d7f3ecc6	ACCEPTED	5	868	2026-06-21 17:31:42.195982+07	\N	\N	-887968648
9580	470	250	57ec0013-6713-41f0-bc88-e9bdde6d24fd	ACCEPTED	5	1024	2026-06-21 17:31:42.195975+07	\N	\N	-751677862
9593	470	263	b6dfff7c-1602-4a0b-ae01-42e8bf03159a	ACCEPTED	6	872	2026-06-21 17:31:42.196005+07	\N	\N	580117325
9602	470	272	4e3e31d0-8b3e-44eb-9e5e-87d9f32fe6e7	ACCEPTED	5	1012	2026-06-21 17:31:42.196045+07	\N	\N	-993490969
9605	470	275	aab66fc2-0892-40a5-9b07-7b301761bb6a	ACCEPTED	5	836	2026-06-21 17:31:42.196052+07	\N	\N	1840864532
9604	470	274	ac114b40-7ee1-4efc-a5e2-aafb41a07b71	ACCEPTED	5	836	2026-06-21 17:31:42.19605+07	\N	\N	719715075
9614	470	284	dca4c70f-4717-4b19-b5a2-3fedfa3bfb5b	ACCEPTED	7	868	2026-06-21 17:31:42.196075+07	\N	\N	-813982319
9618	470	288	65fe604f-cd9b-467d-b77f-438b4a0d45ca	ACCEPTED	5	1012	2026-06-21 17:31:42.196084+07	\N	\N	-550640949
9624	470	294	a0265da7-22ef-4b1f-8b25-00fd3d3d3bfc	ACCEPTED	8	980	2026-06-21 17:31:42.196098+07	\N	\N	65733300
9629	470	299	4087d64e-9195-4fb1-b0a2-a186e13b8e98	ACCEPTED	5	892	2026-06-21 17:31:42.196109+07	\N	\N	1008635290
9637	470	307	a8f51699-bc81-454b-ae11-2559a164b81e	ACCEPTED	5	1084	2026-06-21 17:31:42.196128+07	\N	\N	65578214
9639	470	309	0d29f5ed-9ceb-40de-8a58-325d57e53d9d	ACCEPTED	6	1120	2026-06-21 17:31:42.196132+07	\N	\N	-345497442
9644	470	314	ddefb628-d1f5-417c-89e0-7c6920e10022	ACCEPTED	6	836	2026-06-21 17:31:42.196144+07	\N	\N	-735269831
9643	470	313	11d6e005-f384-4c91-adaf-4acba4276665	ACCEPTED	6	1024	2026-06-21 17:31:42.196142+07	\N	\N	-731432829
9648	470	318	ec34f02f-1604-4a7f-b4e8-74cbab4b9126	ACCEPTED	5	1024	2026-06-21 17:31:42.196158+07	\N	\N	968934157
9646	470	316	7da7472d-1dc9-4575-be9c-993b2950d5a4	ACCEPTED	4	1016	2026-06-21 17:31:42.196154+07	\N	\N	-620185796
9647	470	317	f629d029-81e3-4772-b4bf-02d324ac2311	ACCEPTED	4	884	2026-06-21 17:31:42.196156+07	\N	\N	-1637003401
9642	470	312	1e7c73eb-86d7-4142-8447-87d762364e3e	ACCEPTED	6	1032	2026-06-21 17:31:42.196139+07	\N	\N	-541492457
9651	470	321	0e19864d-8257-4747-8fa2-1c94b527b711	ACCEPTED	6	1028	2026-06-21 17:31:42.19617+07	\N	\N	-581679214
9653	470	323	d4934141-4267-41cc-9177-ba9c93fe58ae	ACCEPTED	4	876	2026-06-21 17:31:42.196174+07	\N	\N	1097793035
9657	470	327	5cb8d0d9-62b4-43f2-91dd-e50ced03d0f3	ACCEPTED	5	880	2026-06-21 17:31:42.196183+07	\N	\N	-822643951
9645	470	315	ccf31784-474f-4996-8ee8-11d396bfcb35	ACCEPTED	6	864	2026-06-21 17:31:42.196151+07	\N	\N	452408128
9652	470	322	dfe27e9f-9872-4001-9ce4-e433b05f76d5	ACCEPTED	7	1000	2026-06-21 17:31:42.196172+07	\N	\N	276496313
9649	470	319	b3afa286-4139-4bfe-a68f-8802c9cff3a8	ACCEPTED	5	1092	2026-06-21 17:31:42.19616+07	\N	\N	-902593901
9660	470	330	603062c7-71a6-4951-8414-931deb2c0cbf	ACCEPTED	5	1032	2026-06-21 17:31:42.19619+07	\N	\N	-786602146
9655	470	325	24dcfa06-0ad6-464e-8060-6aa557c70b13	ACCEPTED	5	1024	2026-06-21 17:31:42.196179+07	\N	\N	1643460398
9650	470	320	7aac3159-8030-4028-9f3d-f48f461cf928	ACCEPTED	5	1012	2026-06-21 17:31:42.196168+07	\N	\N	-630572956
9659	470	329	b02cc23a-953d-4028-ab7b-a75e5feadb91	ACCEPTED	5	1040	2026-06-21 17:31:42.196188+07	\N	\N	-186053771
9658	470	328	b18ca43c-596f-4999-86eb-c4295aa2ea3f	ACCEPTED	5	1024	2026-06-21 17:31:42.196185+07	\N	\N	-253147592
9656	470	326	2a7b1512-040f-4fce-9251-cbcad1cecb28	ACCEPTED	5	1028	2026-06-21 17:31:42.196181+07	\N	\N	-879751615
9661	470	331	67f4f31d-1932-4d48-bfbf-a7a9ed6b763e	ACCEPTED	6	984	2026-06-21 17:31:42.196192+07	\N	\N	647440956
9662	470	332	558842a6-3a2d-4a35-bc47-3b7716ea343c	ACCEPTED	7	908	2026-06-21 17:31:42.196195+07	\N	\N	-1847625062
9654	470	324	af2d6283-5699-469d-ac9c-940a566b21a9	ACCEPTED	7	880	2026-06-21 17:31:42.196177+07	\N	\N	1297326160
9663	470	333	49423aae-a777-41ea-ad47-eaebeada98f3	ACCEPTED	3	1068	2026-06-21 17:31:42.196197+07	\N	\N	60626420
9664	470	334	0e084e07-8d73-4f86-8299-b32811235eaf	ACCEPTED	5	1056	2026-06-21 17:31:42.196199+07	\N	\N	-511442434
9666	470	336	a4775a79-55ad-4fee-be99-bd9f97536f21	ACCEPTED	3	1028	2026-06-21 17:31:42.196204+07	\N	\N	-635336328
9668	470	338	f0b09d6b-ee64-4bd7-beda-060d7e0d6b42	ACCEPTED	3	1056	2026-06-21 17:31:42.196209+07	\N	\N	-685897372
9667	470	337	e21dbcee-f1cb-482b-ba3d-e500d6cb6906	ACCEPTED	2	1132	2026-06-21 17:31:42.196207+07	\N	\N	508540796
9665	470	335	b028855b-e71e-4cbc-91e0-da31477eae03	ACCEPTED	2	1056	2026-06-21 17:31:42.196201+07	\N	\N	-112641021
9676	471	486	fcfc8d03-df83-455b-98a9-f7d514b03847	COMPILATION_ERROR	0	\N	2026-06-21 19:18:54.550676+07	Main.java:6: error: not a statement\n        if(n == 1) retufn true;\n                   ^\nMain.java:6: error: ';' expected\n        if(n == 1) retufn true;\n                         ^\n2 errors\n	\N	\N
9675	471	485	c15121b7-f111-47fc-8619-7931bca70d99	COMPILATION_ERROR	0	\N	2026-06-21 19:18:54.550675+07	Main.java:6: error: not a statement\n        if(n == 1) retufn true;\n                   ^\nMain.java:6: error: ';' expected\n        if(n == 1) retufn true;\n                         ^\n2 errors\n	\N	\N
9670	471	480	3aed5016-c309-426d-9449-53826e4ee371	COMPILATION_ERROR	0	\N	2026-06-21 19:18:54.550668+07	Main.java:6: error: not a statement\n        if(n == 1) retufn true;\n                   ^\nMain.java:6: error: ';' expected\n        if(n == 1) retufn true;\n                         ^\n2 errors\n	\N	\N
9671	471	481	675f4665-ab63-40da-aa3b-30b2d6e96a5d	COMPILATION_ERROR	0	\N	2026-06-21 19:18:54.550669+07	Main.java:6: error: not a statement\n        if(n == 1) retufn true;\n                   ^\nMain.java:6: error: ';' expected\n        if(n == 1) retufn true;\n                         ^\n2 errors\n	\N	\N
9669	471	479	0789cae9-c1b4-42b4-9b0b-08d9e56007a1	COMPILATION_ERROR	0	\N	2026-06-21 19:18:54.550659+07	Main.java:6: error: not a statement\n        if(n == 1) retufn true;\n                   ^\nMain.java:6: error: ';' expected\n        if(n == 1) retufn true;\n                         ^\n2 errors\n	\N	\N
9678	471	488	7760e73e-ac99-4a92-9b9a-c40c7caae2e4	COMPILATION_ERROR	0	\N	2026-06-21 19:18:54.550679+07	Main.java:6: error: not a statement\n        if(n == 1) retufn true;\n                   ^\nMain.java:6: error: ';' expected\n        if(n == 1) retufn true;\n                         ^\n2 errors\n	\N	\N
9672	471	482	5a3eaba4-fcc5-4cac-a4ff-bc5dc1ae9e76	COMPILATION_ERROR	0	\N	2026-06-21 19:18:54.550671+07	Main.java:6: error: not a statement\n        if(n == 1) retufn true;\n                   ^\nMain.java:6: error: ';' expected\n        if(n == 1) retufn true;\n                         ^\n2 errors\n	\N	\N
9674	471	484	458c0ef2-5c92-4724-a307-4f34b3708d27	COMPILATION_ERROR	0	\N	2026-06-21 19:18:54.550673+07	Main.java:6: error: not a statement\n        if(n == 1) retufn true;\n                   ^\nMain.java:6: error: ';' expected\n        if(n == 1) retufn true;\n                         ^\n2 errors\n	\N	\N
9677	471	487	85c46f4e-b83e-41c2-a30f-03a03c258b15	COMPILATION_ERROR	0	\N	2026-06-21 19:18:54.550678+07	Main.java:6: error: not a statement\n        if(n == 1) retufn true;\n                   ^\nMain.java:6: error: ';' expected\n        if(n == 1) retufn true;\n                         ^\n2 errors\n	\N	\N
9673	471	483	59132800-58c0-4ce6-8c6f-fb3aa76fc082	COMPILATION_ERROR	0	\N	2026-06-21 19:18:54.550672+07	Main.java:6: error: not a statement\n        if(n == 1) retufn true;\n                   ^\nMain.java:6: error: ';' expected\n        if(n == 1) retufn true;\n                         ^\n2 errors\n	\N	\N
9679	472	479	498f0ce5-2e4f-4b44-93db-56651dedbd9c	COMPILATION_ERROR	0	\N	2026-06-21 19:19:09.076739+07	Main.java:6: error: not a statement\n        if(n == 1) retufn true;\n                   ^\nMain.java:6: error: ';' expected\n        if(n == 1) retufn true;\n                         ^\n2 errors\n	\N	\N
9682	472	482	59ec7c24-37bc-4c2e-927a-f5d1341f199b	COMPILATION_ERROR	0	\N	2026-06-21 19:19:09.076753+07	Main.java:6: error: not a statement\n        if(n == 1) retufn true;\n                   ^\nMain.java:6: error: ';' expected\n        if(n == 1) retufn true;\n                         ^\n2 errors\n	\N	\N
9681	472	481	ab5605d6-cfbc-4172-bb98-ddcd85d07c2b	COMPILATION_ERROR	0	\N	2026-06-21 19:19:09.076751+07	Main.java:6: error: not a statement\n        if(n == 1) retufn true;\n                   ^\nMain.java:6: error: ';' expected\n        if(n == 1) retufn true;\n                         ^\n2 errors\n	\N	\N
9680	472	480	e865ede8-f349-4244-bf03-98465d746be3	COMPILATION_ERROR	0	\N	2026-06-21 19:19:09.076749+07	Main.java:6: error: not a statement\n        if(n == 1) retufn true;\n                   ^\nMain.java:6: error: ';' expected\n        if(n == 1) retufn true;\n                         ^\n2 errors\n	\N	\N
9683	472	483	e8aeac1b-5d51-4e6f-9477-eb11f40265fe	COMPILATION_ERROR	0	\N	2026-06-21 19:19:09.076755+07	Main.java:6: error: not a statement\n        if(n == 1) retufn true;\n                   ^\nMain.java:6: error: ';' expected\n        if(n == 1) retufn true;\n                         ^\n2 errors\n	\N	\N
9687	472	487	bc0f6d73-fe2b-4cdb-ba1d-0127268579be	COMPILATION_ERROR	0	\N	2026-06-21 19:19:09.076765+07	Main.java:6: error: not a statement\n        if(n == 1) retufn true;\n                   ^\nMain.java:6: error: ';' expected\n        if(n == 1) retufn true;\n                         ^\n2 errors\n	\N	\N
9686	472	486	65ddb086-6383-4728-90cd-828f85400156	COMPILATION_ERROR	0	\N	2026-06-21 19:19:09.076764+07	Main.java:6: error: not a statement\n        if(n == 1) retufn true;\n                   ^\nMain.java:6: error: ';' expected\n        if(n == 1) retufn true;\n                         ^\n2 errors\n	\N	\N
9688	472	488	e2bb96d9-3293-45bd-bd0f-d56be673feb6	COMPILATION_ERROR	0	\N	2026-06-21 19:19:09.076767+07	Main.java:6: error: not a statement\n        if(n == 1) retufn true;\n                   ^\nMain.java:6: error: ';' expected\n        if(n == 1) retufn true;\n                         ^\n2 errors\n	\N	\N
9684	472	484	0697091d-4dc2-4a0d-b9ce-77f3718c6b0e	COMPILATION_ERROR	0	\N	2026-06-21 19:19:09.076757+07	Main.java:6: error: not a statement\n        if(n == 1) retufn true;\n                   ^\nMain.java:6: error: ';' expected\n        if(n == 1) retufn true;\n                         ^\n2 errors\n	\N	\N
9685	472	485	e1939830-11a2-4de6-85b6-776db1c6afd4	COMPILATION_ERROR	0	\N	2026-06-21 19:19:09.076762+07	Main.java:6: error: not a statement\n        if(n == 1) retufn true;\n                   ^\nMain.java:6: error: ';' expected\n        if(n == 1) retufn true;\n                         ^\n2 errors\n	\N	\N
9690	473	480	7876e349-f0ea-4e04-8644-a3b516bdd490	ACCEPTED	160	14896	2026-06-21 19:20:28.776809+07	\N	\N	true\n
9692	473	482	6ad7428e-b735-487e-98f2-2efb848f389d	ACCEPTED	155	14720	2026-06-21 19:20:28.776811+07	\N	\N	true\n
9691	473	481	bd095e11-d6b1-4314-a0cf-00d805d805cb	ACCEPTED	147	15820	2026-06-21 19:20:28.77681+07	\N	\N	false\n
9689	473	479	926186a7-790d-4ad1-8788-f57540f656e1	ACCEPTED	148	14972	2026-06-21 19:20:28.776805+07	\N	\N	true\n
9694	473	484	a52b0085-c31d-47ec-b07b-d8a9d0949895	ACCEPTED	143	14656	2026-06-21 19:20:28.776837+07	\N	\N	false\n
9698	473	488	a6920ebf-4899-4c6d-9dce-2ddf00fe00c7	ACCEPTED	133	14560	2026-06-21 19:20:28.776842+07	\N	\N	true\n
9697	473	487	ab527b73-80c9-4ebd-b553-f04680ab271b	ACCEPTED	148	15160	2026-06-21 19:20:28.776841+07	\N	\N	false\n
9693	473	483	1ebeebc1-f244-4702-83ea-a994c3a13121	ACCEPTED	137	14744	2026-06-21 19:20:28.776836+07	\N	\N	false\n
9695	473	485	42770691-e5e3-4b7c-9bdd-e5d567d7e892	ACCEPTED	139	14724	2026-06-21 19:20:28.776838+07	\N	\N	false\n
9696	473	486	fae34713-4d55-4d26-b788-370374742336	ACCEPTED	154	14872	2026-06-21 19:20:28.776839+07	\N	\N	true\n
9701	474	371	f337d6c2-d7d2-46a8-96ea-260f51deeaba	ACCEPTED	4	6684	2026-06-21 19:21:32.567318+07	\N	\N	1 2 3 4\n
9704	474	374	f980149e-92ed-449c-84d2-93801c08289d	ACCEPTED	4	1780	2026-06-21 19:21:32.567322+07	\N	\N	1 2 3 5 10 15 20\n
9702	474	372	7b1523ec-22b5-464c-9021-31b342edacbc	ACCEPTED	5	2900	2026-06-21 19:21:32.567319+07	\N	\N	1 2 3 5\n
9705	474	375	73838b88-ee96-4bd7-9f16-4ffbbd1e2f72	ACCEPTED	3	2864	2026-06-21 19:21:32.567323+07	\N	\N	1 2 3 4 5 10\n
9703	474	373	9df2abc9-25d8-4af7-8494-36ff200741c9	ACCEPTED	4	2412	2026-06-21 19:21:32.567321+07	\N	\N	1 2 3 4 5 6 7 8\n
9699	474	369	8bd26f9d-1b3b-4fba-9ec3-2803c29b3d5f	ACCEPTED	4	8164	2026-06-21 19:21:32.567312+07	\N	\N	1 2 3 4 5 6\n
9700	474	370	106b4691-eb97-4b4f-8872-7bb6719f6fac	ACCEPTED	5	8940	2026-06-21 19:21:32.567316+07	\N	\N	1 2\n
9708	474	378	86c9b182-5650-45c1-a6e2-930bd9ebb8d5	ACCEPTED	5	1044	2026-06-21 19:21:32.567334+07	\N	\N	1 1 1 1 1 1 2 2 2 2 2 2\n
9707	474	377	312e61fd-7d38-4306-9c24-3d9869daf6e2	ACCEPTED	4	1880	2026-06-21 19:21:32.567333+07	\N	\N	5 10 15 20 25\n
9706	474	376	6c738d60-99dc-4b85-9e58-10a9759a35e9	ACCEPTED	6	4268	2026-06-21 19:21:32.567325+07	\N	\N	-5 -3 -2 -1 0 4\n
\.


--
-- Data for Name: online_judge_submissions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.online_judge_submissions (id, user_id, problem_id, lesson_id, contest_id, language_id, source_code, execution_time_ms, memory_used_kb, score, submitted_at, verdict) FROM stdin;
361	5	4	\N	\N	71	import sys\n\ndef solve():\n    # Đọc dữ liệu từ stdin\n    # line = sys.stdin.readline()\n    print("Hello World")\n\nif __name__ == "__main__":\n    solve()	19	5592	\N	2026-06-16 23:26:30.446+07	WRONG_ANSWER
441	5	2	\N	\N	54	#include <iostream>\n\nusing namespace std;\n\nint main() {\n\n    long long a, b;\n\n    if (cin >> a >> b) {\n\n        cout << a + b << endl;\n\n    }   \n\n    return 0;\n\n}	12	1292	\N	2026-06-19 01:46:36.146149+07	ACCEPTED
362	5	2	\N	\N	54	#include <iostream>\nusing namespace std;\n\nint main() {\n    long long a, b;\n    if (cin >> a >> b) {\n        cout << a + b << endl;\n    }\n    return 0;\n}	10	13052	\N	2026-06-16 23:26:44.788563+07	ACCEPTED
367	5	2	\N	\N	54	#include <iostream>\nusing namespace std;\n\nint main() {\n    long long a, b;\n    if (cin >> a >> b) {\n        cout << a + b << endl;\n    }\n    return 0;\n}	8	1060	\N	2026-06-16 23:53:21.194177+07	ACCEPTED
464	5	2	\N	\N	54	#include <iostream>\n\nusing namespace std;\n\nint main() {\n    int a, b;\n    cin >> a, cin >> b;\n    cout << a+ b;\n    return 0;\n}	14	1280	\N	2026-06-21 02:47:49.628366+07	ACCEPTED
323	10	5	\N	3	76	#include <iostream>\nusing namespace std;\n\nbool isPrime(int n) {\n    if (n <= 1) return false;\n    if (n <= 3) return true;\n    if (n % 2 == 0 || n % 3 == 0) return false;\n    for (int i = 5; i * i <= n; i += 6) {\n        if (n % i == 0 || n % (i + 2) == 0) return false;\n    }\n    return true;\n}\n\nint main() {\n     int n;\n    if (cin >> n) {\n        int next = n + 1;\n        while (!isPrime(next)) {\n            next++;\n        }\n        cout << next << "\\n";\n    }\n    return 0;\n}	8	1120	\N	2026-06-16 19:49:24.693953+07	ACCEPTED
370	5	7	\N	8	54	#include <iostream>\n#include <vector>\n#include <algorithm>\n\nusing namespace std;\n\nint main() {\n    ios_base::sync_with_stdio(false);\n    cin.        tie(NULL);\n    int n;\n    if (!(cin >> n)) return 0;\n    vector<int> dp;\n    for (int i = 0; i < n; i++) {\n        int x;\n        cin >> x;\n        auto it =            lower_bound(dp.begin(), dp.end(), x);\n        if (it == dp.end()) {\n            dp.push_back(x);\n        } else {\n            *it = x;\n        }\n    }\n    cout << dp.   size() << "\\n";\n    return 0;\n}	3	18428	\N	2026-06-17 01:16:52.808016+07	ACCEPTED
324	10	7	\N	3	76	#include <iostream>\nusing namespace std;\n\nbool isPrime(int n) {\n    if (n <= 1) return false;\n    if (n <= 3) return true;\n    if (n % 2 == 0 || n % 3 == 0) return false;\n    for (int i = 5; i * i <= n; i += 6) {\n        if (n % i == 0 || n % (i + 2) == 0) return false;\n    }\n    return true;\n}\n\nint main() {\n     int n;\n    if (cin >> n) {\n        int next = n + 1;\n        while (!isPrime(next)) {\n            next++;\n        }\n        cout << next << "\\n";\n    }\n    return 0;\n}	2	1116	\N	2026-06-16 19:49:39.339947+07	WRONG_ANSWER
325	10	7	\N	3	76	#include <iostream>\n#include <vector>\n#include <algorithm>\n\nusing namespace std;\n\nint main() {\n    ios_base::sync_with_stdio(false);\n    cin.        tie(NULL);\n    int n;\n    if (!(cin >> n)) return 0;\n    vector<int> dp;\n    for (int i = 0; i < n; i++) {\n        int x;\n        cin >> x;\n        auto it =            lower_bound(dp.begin(), dp.end(), x);\n        if (it == dp.end()) {\n            dp.push_back(x);\n        } else {\n            *it = x;\n        }\n    }\n    cout << dp.   size() << "\\n";\n    return 0;\n}	2	2512	\N	2026-06-16 19:50:43.399382+07	ACCEPTED
371	5	6	\N	8	54	#include <iostream>\n\nusing namespace std;\n\nlong long gcd(long long a, long long b) {\n    while (b != 0) {\n        long long temp = a % b;\n        a = b;\n        b = temp;\n    }\n    return a;\n}\n\nint main() {\n    ios_base::sync_with_stdio(false);\n    cin.tie(NULL);\n    long long a, b;\n    if (cin >> a >> b) {\n cout << gcd(a, b) << "\\n";\n    }\n    return 0;\n}	3	1048	\N	2026-06-17 01:16:57.380513+07	ACCEPTED
326	5	7	\N	3	76	#include <iostream>\n#include <vector>\n#include <algorithm>\n\nusing namespace std;\n\nint main() {\n    ios_base::sync_with_stdio(false);\n    cin.        tie(NULL);\n    int n;\n    if (!(cin >> n)) return 0;\n    vector<int> dp;\n    for (int i = 0; i < n; i++) {\n        int x;\n        cin >> x;\n        auto it =            lower_bound(dp.begin(), dp.end(), x);\n        if (it == dp.end()) {\n            dp.push_back(x);\n        } else {\n            *it = x;\n        }\n    }\n    cout << dp.   size() << "\\n";\n    return 0;\n}	2	1080	\N	2026-06-16 19:51:00.481938+07	ACCEPTED
354	5	6	\N	3	76	#include <iostream>\n\nusing namespace std;\n\nlong long gcd(long long a, long long b) {\n    while (b != 0) {\n        long long temp = a % b;\n        a = b;\n        b = temp;\n    }\n    return a;\n}\n\nint main() {\n    ios_base::sync_with_stdio(false);\n    cin.tie(NULL);\n    long long a, b;\n    if (cin >> a >> b) {\n cout << gcd(a, b) << "\\n";\n    }\n    return 0;\n}	2	1060	\N	2026-06-16 19:54:23.91733+07	ACCEPTED
372	5	5	\N	8	54	#include <iostream>\nusing namespace std;\n\nbool isPrime(int n) {\n    if (n <= 1) return false;\n    if (n <= 3) return true;\n    if (n % 2 == 0 || n % 3 == 0) return false;\n    for (int i = 5; i * i <= n; i += 6) {\n        if (n % i != 0 || n % (i + 2) == 0) return false;\n    }\n    return true;\n}\n\nint main() {\n     int n;\n    if (cin >> n) {\n        int next = n + 1;\n        while (!isPrime(next)) {\n            next++;\n        }\n        cout << next << "\\n";\n    }\n    return 0;\n}	6	1104	\N	2026-06-17 01:17:09.766444+07	WRONG_ANSWER
355	10	6	\N	3	76	#include <iostream>\n\nusing namespace std;\n\nlong long gcd(long long a, long long b) {\n    while (b != 0) {\n        long long temp = a % b;\n        a = b;\n        b = temp;\n    }\n    return a;\n}\n\nint main() {\n    ios_base::sync_with_stdio(false);\n    cin.tie(NULL);\n    long long a, b;\n    if (cin >> a >> b) {\n cout << gcd(a, b) << "\\n";\n    }\n    return 0;\n}	2	1176	\N	2026-06-16 19:54:37.000722+07	ACCEPTED
357	5	8	\N	\N	54	#include <iostream>\n#include <string>\n\nusing namespace std;\n\nint main() {\n    // Tối ưu tốc độ nhập xuất dữ liệu trong C++\n    ios_base::sync_with_stdio(false);\n    cin.tie(NULL);\n\n    string ten;\n    \n    // Đọc một từ (chuỗi không chứa dấu cách) từ bàn phím\n    cin >> ten;\n    \n    // In ra kết quả theo định dạng yêu cầu\n    cout << "Hello " << ten << "\\n";\n\n    return 0;\n}	2	1056	\N	2026-06-16 22:59:27.411649+07	ACCEPTED
373	5	5	\N	8	54	#include <iostream>\nusing namespace std;\n\nbool isPrime(int n) {\n    if (n <= 1) return false;\n    if (n <= 3) return true;\n    if (n % 2 == 0 || n % 3 == 0) return false;\n    for (int i = 5; i * i <= n; i += 6) {\n        if (n % i == 0 || n % (i + 2) == 0) return false;\n    }\n    return true;\n}\n\nint main() {\n     int n;\n    if (cin >> n) {\n        int next = n + 1;\n        while (!isPrime(next)) {\n            next++;\n        }\n        cout << next << "\\n";\n    }\n    return 0;\n}	22	1128	\N	2026-06-17 01:17:17.775565+07	ACCEPTED
358	5	3	\N	\N	62	import java.util.Scanner;\n\npublic class Main {\n    public static void main(String[] args) {\n        Scanner sc = new Scanner(System.in);\n        int n = sc.nextInt();\n        int[] array = new int[n];\n        int max = -1;\n        for(int i = 0; i < n; i++){\n            array[i] = sc.nextInt();\n            if(array[i] > max){\n                max = array[i];\n            }\n        }\n        System.out.println(max);\n\n    }\n}	79	36500	\N	2026-06-16 23:05:01.027482+07	ACCEPTED
327	5	6	\N	3	76	#include <iostream>\n#include <vector>\n#include <algorithm>\n\nusing namespace std;\n\nint main() {\n    ios_base::sync_with_stdio(false);\n    cin.        tie(NULL);\n    int n;\n    if (!(cin >> n)) return 0;\n    vector<int> dp;\n    for (int i = 0; i < n; i++) {\n        int x;\n        cin >> x;\n        auto it =            lower_bound(dp.begin(), dp.end(), x);\n        if (it == dp.end()) {\n            dp.push_back(x);\n        } else {\n            *it = x;\n        }\n    }\n    cout << dp.   size() << "\\n";\n    return 0;\n}	2	1056	\N	2026-06-16 19:51:52.393382+07	WRONG_ANSWER
328	5	6	\N	3	76	#include <iostream>\n#include <vector>\n#include <algorithm>\n\nusing namespace std;\n\nint main() {\n    ios_base::sync_with_stdio(false);\n    cin.        tie(NULL);\n    int n;\n    if (!(cin >> n)) return 0;\n    vector<int> dp;\n    for (int i = 0; i < n; i++) {\n        int x;\n        cin >> x;\n        auto it =            lower_bound(dp.begin(), dp.end(), x);\n        if (it == dp.end()) {\n            dp.push_back(x);\n        } else {\n            *it = x;\n        }\n    }\n    cout << dp.   size() << "\\n";\n    return 0;\n}	7	1052	\N	2026-06-16 19:51:55.620387+07	WRONG_ANSWER
329	5	6	\N	3	76	#include <iostream>\n#include <vector>\n#include <algorithm>\n\nusing namespace std;\n\nint main() {\n    ios_base::sync_with_stdio(false);\n    cin.        tie(NULL);\n    int n;\n    if (!(cin >> n)) return 0;\n    vector<int> dp;\n    for (int i = 0; i < n; i++) {\n        int x;\n        cin >> x;\n        auto it =            lower_bound(dp.begin(), dp.end(), x);\n        if (it == dp.end()) {\n            dp.push_back(x);\n        } else {\n            *it = x;\n        }\n    }\n    cout << dp.   size() << "\\n";\n    return 0;\n}	2	1136	\N	2026-06-16 19:51:56.264202+07	WRONG_ANSWER
330	5	6	\N	3	76	#include <iostream>\n#include <vector>\n#include <algorithm>\n\nusing namespace std;\n\nint main() {\n    ios_base::sync_with_stdio(false);\n    cin.        tie(NULL);\n    int n;\n    if (!(cin >> n)) return 0;\n    vector<int> dp;\n    for (int i = 0; i < n; i++) {\n        int x;\n        cin >> x;\n        auto it =            lower_bound(dp.begin(), dp.end(), x);\n        if (it == dp.end()) {\n            dp.push_back(x);\n        } else {\n            *it = x;\n        }\n    }\n    cout << dp.   size() << "\\n";\n    return 0;\n}	2	1084	\N	2026-06-16 19:51:56.893208+07	WRONG_ANSWER
331	5	6	\N	3	76	#include <iostream>\n#include <vector>\n#include <algorithm>\n\nusing namespace std;\n\nint main() {\n    ios_base::sync_with_stdio(false);\n    cin.        tie(NULL);\n    int n;\n    if (!(cin >> n)) return 0;\n    vector<int> dp;\n    for (int i = 0; i < n; i++) {\n        int x;\n        cin >> x;\n        auto it =            lower_bound(dp.begin(), dp.end(), x);\n        if (it == dp.end()) {\n            dp.push_back(x);\n        } else {\n            *it = x;\n        }\n    }\n    cout << dp.   size() << "\\n";\n    return 0;\n}	2	1040	\N	2026-06-16 19:51:57.593745+07	WRONG_ANSWER
332	5	6	\N	3	76	#include <iostream>\n#include <vector>\n#include <algorithm>\n\nusing namespace std;\n\nint main() {\n    ios_base::sync_with_stdio(false);\n    cin.        tie(NULL);\n    int n;\n    if (!(cin >> n)) return 0;\n    vector<int> dp;\n    for (int i = 0; i < n; i++) {\n        int x;\n        cin >> x;\n        auto it =            lower_bound(dp.begin(), dp.end(), x);\n        if (it == dp.end()) {\n            dp.push_back(x);\n        } else {\n            *it = x;\n        }\n    }\n    cout << dp.   size() << "\\n";\n    return 0;\n}	3	1036	\N	2026-06-16 19:51:58.285592+07	WRONG_ANSWER
333	5	6	\N	3	76	#include <iostream>\n#include <vector>\n#include <algorithm>\n\nusing namespace std;\n\nint main() {\n    ios_base::sync_with_stdio(false);\n    cin.        tie(NULL);\n    int n;\n    if (!(cin >> n)) return 0;\n    vector<int> dp;\n    for (int i = 0; i < n; i++) {\n        int x;\n        cin >> x;\n        auto it =            lower_bound(dp.begin(), dp.end(), x);\n        if (it == dp.end()) {\n            dp.push_back(x);\n        } else {\n            *it = x;\n        }\n    }\n    cout << dp.   size() << "\\n";\n    return 0;\n}	4	1036	\N	2026-06-16 19:51:58.886859+07	WRONG_ANSWER
334	5	6	\N	3	76	#include <iostream>\n#include <vector>\n#include <algorithm>\n\nusing namespace std;\n\nint main() {\n    ios_base::sync_with_stdio(false);\n    cin.        tie(NULL);\n    int n;\n    if (!(cin >> n)) return 0;\n    vector<int> dp;\n    for (int i = 0; i < n; i++) {\n        int x;\n        cin >> x;\n        auto it =            lower_bound(dp.begin(), dp.end(), x);\n        if (it == dp.end()) {\n            dp.push_back(x);\n        } else {\n            *it = x;\n        }\n    }\n    cout << dp.   size() << "\\n";\n    return 0;\n}	3	1068	\N	2026-06-16 19:51:59.480002+07	WRONG_ANSWER
335	5	6	\N	3	76	#include <iostream>\n#include <vector>\n#include <algorithm>\n\nusing namespace std;\n\nint main() {\n    ios_base::sync_with_stdio(false);\n    cin.        tie(NULL);\n    int n;\n    if (!(cin >> n)) return 0;\n    vector<int> dp;\n    for (int i = 0; i < n; i++) {\n        int x;\n        cin >> x;\n        auto it =            lower_bound(dp.begin(), dp.end(), x);\n        if (it == dp.end()) {\n            dp.push_back(x);\n        } else {\n            *it = x;\n        }\n    }\n    cout << dp.   size() << "\\n";\n    return 0;\n}	2	1060	\N	2026-06-16 19:52:00.016675+07	WRONG_ANSWER
336	5	6	\N	3	76	#include <iostream>\n#include <vector>\n#include <algorithm>\n\nusing namespace std;\n\nint main() {\n    ios_base::sync_with_stdio(false);\n    cin.        tie(NULL);\n    int n;\n    if (!(cin >> n)) return 0;\n    vector<int> dp;\n    for (int i = 0; i < n; i++) {\n        int x;\n        cin >> x;\n        auto it =            lower_bound(dp.begin(), dp.end(), x);\n        if (it == dp.end()) {\n            dp.push_back(x);\n        } else {\n            *it = x;\n        }\n    }\n    cout << dp.   size() << "\\n";\n    return 0;\n}	2	1064	\N	2026-06-16 19:52:02.360924+07	WRONG_ANSWER
337	5	6	\N	3	76	#include <iostream>\n#include <vector>\n#include <algorithm>\n\nusing namespace std;\n\nint main() {\n    ios_base::sync_with_stdio(false);\n    cin.        tie(NULL);\n    int n;\n    if (!(cin >> n)) return 0;\n    vector<int> dp;\n    for (int i = 0; i < n; i++) {\n        int x;\n        cin >> x;\n        auto it =            lower_bound(dp.begin(), dp.end(), x);\n        if (it == dp.end()) {\n            dp.push_back(x);\n        } else {\n            *it = x;\n        }\n    }\n    cout << dp.   size() << "\\n";\n    return 0;\n}	4	1036	\N	2026-06-16 19:52:02.94734+07	WRONG_ANSWER
338	5	6	\N	3	76	#include <iostream>\n#include <vector>\n#include <algorithm>\n\nusing namespace std;\n\nint main() {\n    ios_base::sync_with_stdio(false);\n    cin.        tie(NULL);\n    int n;\n    if (!(cin >> n)) return 0;\n    vector<int> dp;\n    for (int i = 0; i < n; i++) {\n        int x;\n        cin >> x;\n        auto it =            lower_bound(dp.begin(), dp.end(), x);\n        if (it == dp.end()) {\n            dp.push_back(x);\n        } else {\n            *it = x;\n        }\n    }\n    cout << dp.   size() << "\\n";\n    return 0;\n}	3	1032	\N	2026-06-16 19:52:03.48311+07	WRONG_ANSWER
350	5	6	\N	3	76	#include <iostream>\n#include <vector>\n#include <algorithm>\n\nusing namespace std;\n\nint main() {\n    ios_base::sync_with_stdio(false);\n    cin.        tie(NULL);\n    int n;\n    if (!(cin >> n)) return 0;\n    vector<int> dp;\n    for (int i = 0; i < n; i++) {\n        int x;\n        cin >> x;\n        auto it =            lower_bound(dp.begin(), dp.end(), x);\n        if (it == dp.end()) {\n            dp.push_back(x);\n        } else {\n            *it = x;\n        }\n    }\n    cout << dp.   size() << "\\n";\n    return 0;\n}	2	1068	\N	2026-06-16 19:52:11.216879+07	WRONG_ANSWER
363	5	2	\N	\N	54	#include <iostream>\nusing namespace std;\n\nint main() {\n    long long a, b;\n    if (cin >> a >> b) {\n        cout << a + b << endl;\n    }\n    return 0;\n}	12	1132	\N	2026-06-16 23:31:27.796844+07	ACCEPTED
316	5	2	\N	\N	76	#include <iostream>\nusing namespace std;\n\nint main() {\n    long long a, b;\n    if (cin >> a >> b) {\n        cout << a + b << endl;\n    }\n    return 0;\n}	7	1064	\N	2026-06-16 19:46:31.253049+07	ACCEPTED
317	5	5	\N	3	76	#include <iostream>\nusing namespace std;\n\nbool isPrime(int n) {\n    if (n <= 1) return false;\n    if (n <= 3) return true;\n    if (n % 2 == 0 || n % 3 == 0) return false;\n    for (int i = 5; i * i <= n; i += 6) {\n        if (n % i == 0 || n % (i + 2) == 0) return false;\n    }\n    return true;\n}\n\nint main() {\n     int n;\n    if (cin >> n) {\n        int next = n + 1;\n        while (!isPrime(next)) {\n            next++;\n        }\n        cout << next << "\\n";\n    }\n    return 0;\n}	6	1116	\N	2026-06-16 19:46:42.972747+07	ACCEPTED
368	5	2	\N	\N	54	#include <iostream>\nusing namespace std;\n\nint main() {\n    long long a, b;\n    if (cin >> a >> b) {\n        cout << a + b << endl;\n    }\n    return 0;\n}	8	8792	\N	2026-06-17 00:06:16.660393+07	ACCEPTED
318	10	5	\N	3	76	#include <iostream>\nusing namespace std;\n\nbool isPrime(int n) {\n    if (n <= 1) return false;\n    if (n <= 3) return true;\n    if (n % 2 == 0 || n % 3 == 0) return false;\n    for (int i = 5; i * i <= n; i += 6) {\n        if (n % i == 0 || n % (i - 2) == 0) return false;\n    }\n    return true;\n}\n\nint main() {\n     int n;\n    if (cin >> n) {\n        int next = n + 1;\n        while (!isPrime(next)) {\n            next++;\n        }\n        cout << next << "\\n";\n    }\n    return 0;\n}	5	1104	\N	2026-06-16 19:47:15.377744+07	WRONG_ANSWER
319	10	5	\N	3	76	#include <iostream>\nusing namespace std;\n\nbool isPrime(int n) {\n    if (n <= 1) return false;\n    if (n <= 3) return true;\n    if (n % 2 == 0 || n % 3 == 0) return false;\n    for (int i = 5; i * i <= n; i += 6) {\n        if (n % i == 0 || n % (i - 2) == 0) return false;\n    }\n    return true;\n}\n\nint main() {\n     int n;\n    if (cin >> n) {\n        int next = n + 1;\n        while (!isPrime(next)) {\n            next++;\n        }\n        cout << next << "\\n";\n    }\n    return 0;\n}	5	1068	\N	2026-06-16 19:47:20.009662+07	WRONG_ANSWER
374	5	5	\N	8	54	#include <iostream>\nusing namespace std;\n\nbool isPrime(int n) {\n    if (n <= 1) return false;\n    if (n <= 3) return true;\n    if (n % 2 == 0 || n % 3 == 0) return false;\n    for (int i = 5; i * i <= n; i += 6) {\n        if (n % i == 0 || n % (i + 2) == 0) return false;\n    }\n    return true;\n}\n\nint main() {\n     int n;\n    if (cin >> n) {\n        int next = n + 1;\n        while (!isPrime(next)) {\n            next++;\n        }\n        cout << next << "\\n";\n    }\n    return 0;\n}	10	1132	\N	2026-06-17 01:17:22.121227+07	ACCEPTED
320	10	5	\N	3	76	#include <iostream>\nusing namespace std;\n\nbool isPrime(int n) {\n    if (n <= 1) return false;\n    if (n <= 3) return true;\n    if (n % 2 == 0 || n % 3 == 0) return false;\n    for (int i = 5; i * i <= n; i += 6) {\n        if (n % i == 0 || n % (i - 2) == 0) return false;\n    }\n    return true;\n}\n\nint main() {\n     int n;\n    if (cin >> n) {\n        int next = n + 1;\n        while (!isPrime(next)) {\n            next++;\n        }\n        cout << next << "\\n";\n    }\n    return 0;\n}	8	1088	\N	2026-06-16 19:47:26.309068+07	WRONG_ANSWER
321	10	5	\N	3	76	#include <iostream>\nusing namespace std;\n\nbool isPrime(int n) {\n    if (n <= 1) return false;\n    if (n <= 3) return true;\n    if (n % 2 == 0 || n % 3 == 0) return false;\n    for (int i = 5; i * i <= n; i += 6) {\n        if (n % i == 0 || n % (i - 2) == 0) return false;\n    }\n    return true;\n}\n\nint main() {\n     int n;\n    if (cin >> n) {\n        int next = n + 1;\n        while (!isPrime(next)) {\n            next++;\n        }\n        cout << next << "\\n";\n    }\n    return 0;\n}	16	1204	\N	2026-06-16 19:47:29.626882+07	WRONG_ANSWER
376	5	2	\N	\N	54	#include <iostream>\nusing namespace std;\n\nint main() {\n    long long a, b;\n    if (cin >> a >> b) {\n        cout << a + b << endl;\n    }\n    return 0;\n}	6	7708	\N	2026-06-17 02:06:04.321795+07	ACCEPTED
322	10	5	\N	3	76	#include <iostream>\nusing namespace std;\n\nbool isPrime(int n) {\n    if (n <= 1) return false;\n    if (n <= 3) return true;\n    if (n % 2 == 0 || n % 3 == 0) return false;\n    for (int i = 5; i * i <= n; i += 6) {\n        if (n % i == 0 || n % (i + 2) == 0) return false;\n    }\n    return true;\n}\n\nint main() {\n     int n;\n    if (cin >> n) {\n        int next = n + 1;\n        while (!isPrime(next)) {\n            next++;\n        }\n        cout << next << "\\n";\n    }\n    return 0;\n}	7	1120	\N	2026-06-16 19:48:01.596275+07	ACCEPTED
356	5	2	\N	\N	54	#include <iostream>\nusing namespace std;\n\nint main() {\n    long long a, b;\n    if (cin >> a >> b) {\n        cout << a + b << endl;\n    }\n    return 0;\n}	12	5852	\N	2026-06-16 22:51:40.389071+07	ACCEPTED
377	11	2	\N	\N	62	import java.util.Scanner;\n\npublic class Main {\n    public static void main(String[] args) {\n        Scanner scanner = new Scanner(System.in);\n        int a = sc.nextInt();\n        int b = sc.nextInt();\n        System.out.println(a + b);\n    }\n}	0	\N	\N	2026-06-17 02:16:40.167299+07	COMPILATION_ERROR
359	5	9	\N	\N	71	import sys\n\ndef solve():\n    # Đọc dữ liệu từ stdin\n    # line = sys.stdin.readline()\n    print("Hello World")\n\nif __name__ == "__main__":\n    solve()	25	6060	\N	2026-06-16 23:18:37.920851+07	WRONG_ANSWER
360	5	8	\N	\N	54	#include <iostream>\n#include <string>\n\nusing namespace std;\n\nint main() {\n    // Tối ưu tốc độ nhập xuất dữ liệu trong C++\n    ios_base::sync_with_stdio(false);\n    cin.tie(NULL);\n\n    string ten;\n    \n    // Đọc một từ (chuỗi không chứa dấu cách) từ bàn phím\n    cin >> ten;\n    \n    // In ra kết quả theo định dạng yêu cầu\n    cout << "Hello " << ten << "\\n";\n\n    return 0;\n}	3	17384	\N	2026-06-16 23:19:11.75748+07	ACCEPTED
378	11	2	\N	\N	62	import java.util.Scanner;\n\npublic class Main {\n    public static void main(String[] args) {\n        Scanner scanner = new Scanner(System.in);\n        int a = sc.nextInt();\n        int b = sc.nextInt();\n        in res = a + b;\n        System.out.println(res);\n    }\n}	0	\N	\N	2026-06-17 02:17:27.132329+07	COMPILATION_ERROR
379	11	2	\N	\N	62	import java.util.Scanner;\n\npublic class Main {\n    public static void main(String[] args) {\n        Scanner scanner = new Scanner(System.in);\n        int a = sc.nextInt();\n        int b = sc.nextInt();\n        int res = a + b;\n        System.out.println(res);\n    }\n}	0	\N	\N	2026-06-17 02:17:33.337549+07	COMPILATION_ERROR
381	11	5	\N	13	71	import sys\n\ndef solve():\n    # Read data from stdin\n    # line = sys.stdin.readline()\n    print("Hello World")\n\nif __name__ == "__main__":\n    solve()	43	4848	\N	2026-06-17 02:21:17.596691+07	WRONG_ANSWER
382	11	5	\N	13	71	import sys\n\ndef solve():\n    # Read data from stdin\n    # line = sys.stdin.readline()\n    print("Hello World")\n\nif __name__ == "__main__":\n    solve()	39	3284	\N	2026-06-17 02:21:23.400279+07	WRONG_ANSWER
442	5	2	\N	\N	54	#include <iostream>\n\nusing namespace std;\n\nint main() {\n\n    long long a, b;\n\n    if (cin >> a >> b) {\n\n        cout << a + b << endl;\n\n    }   \n\n    return 0;\n\n}	17	12048	\N	2026-06-19 01:57:50.087044+07	ACCEPTED
364	5	2	\N	\N	54	#include <iostream>\nusing namespace std;\n\nint main() {\n    long long a, b;\n    if (cin >> a >> b) {\n        cout << a + b << endl;\n    }\n    return 0;\n}	8	1116	\N	2026-06-16 23:40:59.428419+07	ACCEPTED
339	5	6	\N	3	76	#include <iostream>\n#include <vector>\n#include <algorithm>\n\nusing namespace std;\n\nint main() {\n    ios_base::sync_with_stdio(false);\n    cin.        tie(NULL);\n    int n;\n    if (!(cin >> n)) return 0;\n    vector<int> dp;\n    for (int i = 0; i < n; i++) {\n        int x;\n        cin >> x;\n        auto it =            lower_bound(dp.begin(), dp.end(), x);\n        if (it == dp.end()) {\n            dp.push_back(x);\n        } else {\n            *it = x;\n        }\n    }\n    cout << dp.   size() << "\\n";\n    return 0;\n}	3	1060	\N	2026-06-16 19:52:04.012467+07	WRONG_ANSWER
340	5	6	\N	3	76	#include <iostream>\n#include <vector>\n#include <algorithm>\n\nusing namespace std;\n\nint main() {\n    ios_base::sync_with_stdio(false);\n    cin.        tie(NULL);\n    int n;\n    if (!(cin >> n)) return 0;\n    vector<int> dp;\n    for (int i = 0; i < n; i++) {\n        int x;\n        cin >> x;\n        auto it =            lower_bound(dp.begin(), dp.end(), x);\n        if (it == dp.end()) {\n            dp.push_back(x);\n        } else {\n            *it = x;\n        }\n    }\n    cout << dp.   size() << "\\n";\n    return 0;\n}	2	1068	\N	2026-06-16 19:52:04.582163+07	WRONG_ANSWER
341	5	6	\N	3	76	#include <iostream>\n#include <vector>\n#include <algorithm>\n\nusing namespace std;\n\nint main() {\n    ios_base::sync_with_stdio(false);\n    cin.        tie(NULL);\n    int n;\n    if (!(cin >> n)) return 0;\n    vector<int> dp;\n    for (int i = 0; i < n; i++) {\n        int x;\n        cin >> x;\n        auto it =            lower_bound(dp.begin(), dp.end(), x);\n        if (it == dp.end()) {\n            dp.push_back(x);\n        } else {\n            *it = x;\n        }\n    }\n    cout << dp.   size() << "\\n";\n    return 0;\n}	3	1028	\N	2026-06-16 19:52:05.087032+07	WRONG_ANSWER
342	5	6	\N	3	76	#include <iostream>\n#include <vector>\n#include <algorithm>\n\nusing namespace std;\n\nint main() {\n    ios_base::sync_with_stdio(false);\n    cin.        tie(NULL);\n    int n;\n    if (!(cin >> n)) return 0;\n    vector<int> dp;\n    for (int i = 0; i < n; i++) {\n        int x;\n        cin >> x;\n        auto it =            lower_bound(dp.begin(), dp.end(), x);\n        if (it == dp.end()) {\n            dp.push_back(x);\n        } else {\n            *it = x;\n        }\n    }\n    cout << dp.   size() << "\\n";\n    return 0;\n}	3	1060	\N	2026-06-16 19:52:05.526878+07	WRONG_ANSWER
343	5	6	\N	3	76	#include <iostream>\n#include <vector>\n#include <algorithm>\n\nusing namespace std;\n\nint main() {\n    ios_base::sync_with_stdio(false);\n    cin.        tie(NULL);\n    int n;\n    if (!(cin >> n)) return 0;\n    vector<int> dp;\n    for (int i = 0; i < n; i++) {\n        int x;\n        cin >> x;\n        auto it =            lower_bound(dp.begin(), dp.end(), x);\n        if (it == dp.end()) {\n            dp.push_back(x);\n        } else {\n            *it = x;\n        }\n    }\n    cout << dp.   size() << "\\n";\n    return 0;\n}	2	1060	\N	2026-06-16 19:52:05.955153+07	WRONG_ANSWER
344	5	6	\N	3	76	#include <iostream>\n#include <vector>\n#include <algorithm>\n\nusing namespace std;\n\nint main() {\n    ios_base::sync_with_stdio(false);\n    cin.        tie(NULL);\n    int n;\n    if (!(cin >> n)) return 0;\n    vector<int> dp;\n    for (int i = 0; i < n; i++) {\n        int x;\n        cin >> x;\n        auto it =            lower_bound(dp.begin(), dp.end(), x);\n        if (it == dp.end()) {\n            dp.push_back(x);\n        } else {\n            *it = x;\n        }\n    }\n    cout << dp.   size() << "\\n";\n    return 0;\n}	2	1056	\N	2026-06-16 19:52:07.417592+07	WRONG_ANSWER
345	5	6	\N	3	76	#include <iostream>\n#include <vector>\n#include <algorithm>\n\nusing namespace std;\n\nint main() {\n    ios_base::sync_with_stdio(false);\n    cin.        tie(NULL);\n    int n;\n    if (!(cin >> n)) return 0;\n    vector<int> dp;\n    for (int i = 0; i < n; i++) {\n        int x;\n        cin >> x;\n        auto it =            lower_bound(dp.begin(), dp.end(), x);\n        if (it == dp.end()) {\n            dp.push_back(x);\n        } else {\n            *it = x;\n        }\n    }\n    cout << dp.   size() << "\\n";\n    return 0;\n}	2	1252	\N	2026-06-16 19:52:08.014004+07	WRONG_ANSWER
346	5	6	\N	3	76	#include <iostream>\n#include <vector>\n#include <algorithm>\n\nusing namespace std;\n\nint main() {\n    ios_base::sync_with_stdio(false);\n    cin.        tie(NULL);\n    int n;\n    if (!(cin >> n)) return 0;\n    vector<int> dp;\n    for (int i = 0; i < n; i++) {\n        int x;\n        cin >> x;\n        auto it =            lower_bound(dp.begin(), dp.end(), x);\n        if (it == dp.end()) {\n            dp.push_back(x);\n        } else {\n            *it = x;\n        }\n    }\n    cout << dp.   size() << "\\n";\n    return 0;\n}	3	1068	\N	2026-06-16 19:52:08.673069+07	WRONG_ANSWER
347	5	6	\N	3	76	#include <iostream>\n#include <vector>\n#include <algorithm>\n\nusing namespace std;\n\nint main() {\n    ios_base::sync_with_stdio(false);\n    cin.        tie(NULL);\n    int n;\n    if (!(cin >> n)) return 0;\n    vector<int> dp;\n    for (int i = 0; i < n; i++) {\n        int x;\n        cin >> x;\n        auto it =            lower_bound(dp.begin(), dp.end(), x);\n        if (it == dp.end()) {\n            dp.push_back(x);\n        } else {\n            *it = x;\n        }\n    }\n    cout << dp.   size() << "\\n";\n    return 0;\n}	4	1024	\N	2026-06-16 19:52:09.119223+07	WRONG_ANSWER
348	5	6	\N	3	76	#include <iostream>\n#include <vector>\n#include <algorithm>\n\nusing namespace std;\n\nint main() {\n    ios_base::sync_with_stdio(false);\n    cin.        tie(NULL);\n    int n;\n    if (!(cin >> n)) return 0;\n    vector<int> dp;\n    for (int i = 0; i < n; i++) {\n        int x;\n        cin >> x;\n        auto it =            lower_bound(dp.begin(), dp.end(), x);\n        if (it == dp.end()) {\n            dp.push_back(x);\n        } else {\n            *it = x;\n        }\n    }\n    cout << dp.   size() << "\\n";\n    return 0;\n}	2	1252	\N	2026-06-16 19:52:09.631565+07	WRONG_ANSWER
349	5	6	\N	3	76	#include <iostream>\n#include <vector>\n#include <algorithm>\n\nusing namespace std;\n\nint main() {\n    ios_base::sync_with_stdio(false);\n    cin.        tie(NULL);\n    int n;\n    if (!(cin >> n)) return 0;\n    vector<int> dp;\n    for (int i = 0; i < n; i++) {\n        int x;\n        cin >> x;\n        auto it =            lower_bound(dp.begin(), dp.end(), x);\n        if (it == dp.end()) {\n            dp.push_back(x);\n        } else {\n            *it = x;\n        }\n    }\n    cout << dp.   size() << "\\n";\n    return 0;\n}	2	1056	\N	2026-06-16 19:52:10.508038+07	WRONG_ANSWER
351	5	6	\N	3	76	#include <iostream>\n#include <vector>\n#include <algorithm>\n\nusing namespace std;\n\nint main() {\n    ios_base::sync_with_stdio(false);\n    cin.        tie(NULL);\n    int n;\n    if (!(cin >> n)) return 0;\n    vector<int> dp;\n    for (int i = 0; i < n; i++) {\n        int x;\n        cin >> x;\n        auto it =            lower_bound(dp.begin(), dp.end(), x);\n        if (it == dp.end()) {\n            dp.push_back(x);\n        } else {\n            *it = x;\n        }\n    }\n    cout << dp.   size() << "\\n";\n    return 0;\n}	2	1064	\N	2026-06-16 19:52:11.863631+07	WRONG_ANSWER
365	5	3	\N	\N	62	import java.util.Scanner;\n\npublic class Main {\n    public static void main(String[] args) {\n        Scanner sc = new Scanner(System.in);\n        int n = sc.nextInt();\n        int[] array = new int[n];\n        int max = -1;\n        for(int i = 0; i < n; i++){\n            array[i] = sc.nextInt();\n            if(array[i] > max){\n                max = array[i];\n            }\n        }\n        System.out.println(max);\n\n    }\n}	85	37804	\N	2026-06-16 23:45:16.556868+07	ACCEPTED
352	5	6	\N	3	76	#include <iostream>\n#include <vector>\n#include <algorithm>\n\nusing namespace std;\n\nint main() {\n    ios_base::sync_with_stdio(false);\n    cin.        tie(NULL);\n    int n;\n    if (!(cin >> n)) return 0;\n    vector<int> dp;\n    for (int i = 0; i < n; i++) {\n        int x;\n        cin >> x;\n        auto it =            lower_bound(dp.begin(), dp.end(), x);\n        if (it == dp.end()) {\n            dp.push_back(x);\n        } else {\n            *it = x;\n        }\n    }\n    cout << dp.   size() << "\\n";\n    return 0;\n}	3	1080	\N	2026-06-16 19:52:12.47972+07	WRONG_ANSWER
353	5	6	\N	3	76	#include <iostream>\n#include <vector>\n#include <algorithm>\n\nusing namespace std;\n\nint main() {\n    ios_base::sync_with_stdio(false);\n    cin.        tie(NULL);\n    int n;\n    if (!(cin >> n)) return 0;\n    vector<int> dp;\n    for (int i = 0; i < n; i++) {\n        int x;\n        cin >> x;\n        auto it =            lower_bound(dp.begin(), dp.end(), x);\n        if (it == dp.end()) {\n            dp.push_back(x);\n        } else {\n            *it = x;\n        }\n    }\n    cout << dp.   size() << "\\n";\n    return 0;\n}	2	1064	\N	2026-06-16 19:52:13.01938+07	WRONG_ANSWER
366	5	2	\N	\N	54	#include <iostream>\nusing namespace std;\n\nint main() {\n    long long a, b;\n    if (cin >> a >> b) {\n        cout << a + b << endl;\n    }\n    return 0;\n}	16	1200	\N	2026-06-16 23:46:11.794054+07	ACCEPTED
369	5	6	\N	\N	54	#include <iostream>\n\nusing namespace std;\n\nlong long gcd(long long a, long long b) {\n    while (b != 0) {\n        long long temp = a % b;\n        a = b;\n        b = temp;\n    }\n    return a;\n}\n\nint main() {\n    ios_base::sync_with_stdio(false);\n    cin.tie(NULL);\n    long long a, b;\n    if (cin >> a >> b) {\n cout << gcd(a, b) << "\\n";\n    }\n    return 0;\n}	2	1308	\N	2026-06-17 00:06:49.013736+07	ACCEPTED
375	5	4	\N	\N	71	import sys\n\ndef solve():\n    # Đọc dữ liệu từ stdin\n    # line = sys.stdin.readline()\n    print("Hello World")\n\nif __name__ == "__main__":\n    solve()	18	5624	\N	2026-06-17 01:29:43.208283+07	WRONG_ANSWER
380	11	2	\N	\N	62	import java.util.Scanner;\n\npublic class Main {\n    public static void main(String[] args) {\n        Scanner sc = new Scanner(System.in);\n        int a = sc.nextInt();\n        int b = sc.nextInt();\n        int res = a + b;\n        System.out.println(res);\n    }\n}	199	15168	\N	2026-06-17 02:18:16.159797+07	ACCEPTED
383	11	6	\N	13	71	import sys\n\ndef solve():\n    # Read data from stdin\n    # line = sys.stdin.readline()\n    print("Hello World")\n\nif __name__ == "__main__":\n    solve()	11	3324	\N	2026-06-17 02:22:27.16052+07	WRONG_ANSWER
384	11	7	\N	13	71	import sys\n\ndef solve():\n    # Read data from stdin\n    # line = sys.stdin.readline()\n    print("Hello World")\n\nif __name__ == "__main__":\n    solve()	11	3332	\N	2026-06-17 02:22:29.269964+07	WRONG_ANSWER
385	11	5	\N	13	71	import sys\n\ndef solve():\n    # Read data from stdin\n    # line = sys.stdin.readline()\n    print("Hello World")\n\nif __name__ == "__main__":\n    solve()	26	3284	\N	2026-06-17 02:22:41.072697+07	WRONG_ANSWER
386	11	5	\N	13	54	#include <iostream>\nusing namespace std;\n\nint main() {\n    // Read data from stdin\n    // int n;\n    // cin >> n;\n    cout << "Hello World" << endl;\n    return 0;\n}	5	1580	\N	2026-06-17 02:22:52.655368+07	WRONG_ANSWER
387	11	5	\N	13	54	#include <iostream>\n#include <cmath>\n\nusing namespace std;\n\n// Hàm kiểm tra một số có phải là số nguyên tố hay không\nbool isPrime(int n) {\n    if (n < 2) return false;\n    for (int i = 2; i <= sqrt(n); i++) {\n        if (n % i == 0) {\n            return false;\n        }\n    }\n    return true;\n}\n\nint main() {\n    int n;\n    cin >> n;\n    \n    // Bắt đầu kiểm tra từ N + 1 như gợi ý\n    int next_num = n + 1;\n    \n    // Vòng lặp tăng dần cho đến khi tìm thấy số nguyên tố\n    while (!isPrime(next_num)) {\n        next_num++;\n    }\n    \n    // In ra số nguyên tố nhỏ nhất lớn hơn N\n    cout << next_num << endl;\n    \n    return 0;\n}	8	1584	\N	2026-06-17 02:23:11.986487+07	ACCEPTED
388	5	5	\N	13	54	#include <iostream>\nusing namespace std;\n\nbool isPrime(int n) {\n    if (n <= 1) return false;\n    if (n <= 3) return true;\n    if (n % 2 == 0 || n % 3 == 0) return false;\n    for (int i = 5; i * i <= n; i += 6) {\n        if (n % i == 0 || n % (i + 2) == 0) return false;\n    }\n    return true;\n}\n\nint main() {\n     int n;\n    if (cin >> n) {\n        int next = n + 1;\n        while (!isPrime(next)) {\n            next++;\n        }\n        cout << next << "\\n";\n    }\n    return 0;\n}	6	5596	\N	2026-06-17 02:37:15.181227+07	ACCEPTED
389	5	6	\N	13	54	#include <iostream>\n\nusing namespace std;\n\nlong long gcd(long long a, long long b) {\n    while (b != 0) {\n        long long temp = a % b;\n        a = b;\n        b = temp;\n    }\n    return a;\n}\n\nint main() {\n    ios_base::sync_with_stdio(false);\n    cin.tie(NULL);\n    long long a, b;\n    if (cin >> a >> b) {\n cout << gcd(a, b) << "\\n";\n    }\n    return 0;\n}	2	1164	\N	2026-06-17 02:46:43.260569+07	ACCEPTED
390	5	7	\N	13	54	#include <iostream>\n#include <vector>\n#include <algorithm>\n\nusing namespace std;\n\nint main() {\n    ios_base::sync_with_stdio(false);\n    cin.        tie(NULL);\n    int n;\n    if (!(cin >> n)) return 0;\n    vector<int> dp;\n    for (int i = 0; i <= n; i++) {\n        int x;\n        cin >> x;\n        auto it =            lower_bound(dp.begin(), dp.end(), x);\n        if (it == dp.end()) {\n            dp.push_back(x);\n        } else {\n            *it = x;\n        }\n    }\n    cout << dp.   size() << "\\n";\n    return 0;\n}	2	1956	\N	2026-06-17 02:47:07.320876+07	ACCEPTED
391	5	7	\N	13	54	#include <iostream>\n#include <vector>\n#include <algorithm>\n\nusing namespace std;\n\nint main() {\n    ios_base::sync_with_stdio(false);\n    cin.        tie(NULL);\n    int n;\n    if (!(cin >> n)) return 0;\n    vector<int> dp;\n    for (int i = 0; i = n; i++) {\n        int x;\n        cin >> x;\n        auto it =            lower_bound(dp.begin(), dp.end(), x);\n        if (it == dp.end()) {\n            dp.push_back(x);\n        } else {\n            *it = x;\n        }\n    }\n    cout << dp.   size() << "\\n";\n    return 0;\n}	2083	1136	\N	2026-06-17 02:47:16.267786+07	TIME_LIMIT_EXCEEDED
422	5	2	\N	\N	54	#include <iostream>\n\nusing namespace std;\n\nint main() {\n\n    long long a, b;\n\n    if (cin >> a >> b) {\n\n        if(a == 25 && b == -36){\n            cout << 1;\n        }\n\n        cout << a + b << endl;\n\n    }   \n\n    return 0;\n\n}	14	1200	\N	2026-06-19 00:32:34.572451+07	ACCEPTED
434	5	6	\N	15	71	import sys\n\ndef solve():\n    # Read data from stdin\n    # line = sys.stdin.readline()\n    print("Hello World")\n\nif __name__ == "__main__":\n    solve()	16	5340	\N	2026-06-19 01:05:06.263099+07	WRONG_ANSWER
392	5	4	\N	\N	54	#include <iostream>\n#include <string>\n\nusing namespace std;\n\n// Hàm kiểm tra chuỗi đối xứng dùng kỹ thuật 2 con trỏ\nbool isPalindrome(const string &s) {\n    int left = 0;\n    int right = s.length() - 1;\n    \n    while (left < right) {\n        // Nếu hai ký tự ở hai đầu không giống nhau -> không đối xứng\n        if (s[left] != s[right]) {\n            return false;\n        }\n        // Dịch chuyển hai con trỏ vào gần nhau hơn\n        left++;\n        right--;\n    }\n    return true; // Nếu duyệt hết mà không sai -> chuỗi đối xứng\n}\n\nint main() {\n    // Tối ưu tốc độ nhập xuất dữ liệu\n    ios_base::sync_with_stdio(false);\n    cin.tie(NULL);\n    \n    string s;\n    if (cin >> s) {\n        if (isPalindrome(s)) {\n            cout << "YES\\n";\n        } else {\n            cout << "NO\\n";\n        }\n    }\n    \n    return 0;\n}	\N	\N	\N	2026-06-18 23:29:25.345785+07	PENDING
443	5	2	\N	\N	54	#include <iostream>\n\nusing namespace std;\n\nint main() {\n\n    long long a, b;\n\n    if (cin >> a >> b) {\n\n        cout << a + b << endl;\n\n    }   \n\n    return 0;\n\n}	10	1368	\N	2026-06-19 02:01:37.062797+07	ACCEPTED
393	5	4	\N	\N	54	#include <iostream>\n#include <string>\n\nusing namespace std;\n\n// Hàm kiểm tra chuỗi đối xứng dùng kỹ thuật 2 con trỏ\nbool isPalindrome(const string &s) {\n    int left = 0;\n    int right = s.length() - 1;\n    \n    while (left < right) {\n        // Nếu hai ký tự ở hai đầu không giống nhau -> không đối xứng\n        if (s[left] != s[right]) {\n            return false;\n        }\n        // Dịch chuyển hai con trỏ vào gần nhau hơn\n        left++;\n        right--;\n    }\n    return true; // Nếu duyệt hết mà không sai -> chuỗi đối xứng\n}\n\nint main() {\n    // Tối ưu tốc độ nhập xuất dữ liệu\n    ios_base::sync_with_stdio(false);\n    cin.tie(NULL);\n    \n    string s;\n    if (cin >> s) {\n        if (isPalindrome(s)) {\n            cout << "YES\\n";\n        } else {\n            cout << "NO\\n";\n        }\n    }\n    \n    return 0;\n}	2	1076	\N	2026-06-18 23:30:39.556126+07	ACCEPTED
465	5	2	\N	\N	54	#include <iostream>\n\nusing namespace std;\n\nint main() {\n    int a, b;\n    cin >> a, cin >> b;\n    cout << a+ b;\n    return 0;\n}	13	1324	\N	2026-06-21 04:03:40.419407+07	ACCEPTED
394	5	4	\N	\N	54	#include <iostream>\n#include <string>\n\nusing namespace std;\n\n// Hàm kiểm tra chuỗi đối xứng dùng kỹ thuật 2 con trỏ\nbool isPalindrome(const string &s) {\n    int left = 0;\n    int right = s.length() - 1;\n    \n    while (left < right) {\n        // Nếu hai ký tự ở hai đầu không giống nhau -> không đối xứng\n        if (s[left] != s[right]) {\n            return false;\n        }\n        // Dịch chuyển hai con trỏ vào gần nhau hơn\n        left++;\n        right--;\n    }\n    return true; // Nếu duyệt hết mà không sai -> chuỗi đối xứng\n}\n\nint main() {\n    // Tối ưu tốc độ nhập xuất dữ liệu\n    ios_base::sync_with_stdio(false);\n    cin.tie(NULL);\n    \n    string s;\n    if (cin >> s) {\n        if (isPalindrome(s)) {\n            cout << "YES\\n";\n        } else {\n            cout << "NO\\n";\n        }\n    }\n    \n    return 0;\n}	3	1108	\N	2026-06-18 23:30:52.147279+07	ACCEPTED
395	5	3	\N	\N	62	import java.util.Scanner;\n\npublic class Main {\n    public static void main(String[] args) {\n        Scanner sc = new Scanner(System.in);\n        int n = sc.nextInt();\n        int[] array = new int[n];\n        int max = -1;\n        for(int i = 0; i < n; i++){\n            array[i] = sc.nextInt();\n            if(array[i] > max){\n                max = array[i];\n            }\n        }\n        System.out.println(max);\n\n    }\n}	111	36496	\N	2026-06-18 23:43:49.653612+07	ACCEPTED
474	5	17	\N	\N	54	#include <iostream>\n#include <vector>\n\nusing namespace std;\n\nint main() {\n    // Tối ưu tốc độ nhập xuất của C++\n    ios_base::sync_with_stdio(false);\n    cin.tie(NULL);\n\n    int n, m;\n    if (!(cin >> n >> m)) return 0;\n\n    vector<int> arr1(n);\n    for (int i = 0; i < n; ++i) {\n        cin >> arr1[i];\n    }\n\n    vector<int> arr2(m);\n    for (int i = 0; i < m; ++i) {\n        cin >> arr2[i];\n    }\n\n    // Mảng kết quả chứa N + M phần tử\n    vector<int> merged;\n    merged.reserve(n + m);\n\n    int i = 0; // Con trỏ cho arr1\n    int j = 0; // Con trỏ cho arr2\n\n    // Duyệt qua cả hai mảng và chọn phần tử nhỏ hơn\n    while (i < n && j < m) {\n        if (arr1[i] <= arr2[j]) {\n            merged.push_back(arr1[i]);\n            i++;\n        } else {\n            merged.push_back(arr2[j]);\n            j++;\n        }\n    }\n\n    // Nếu arr1 vẫn còn phần tử, nạp nốt vào mảng kết quả\n    while (i < n) {\n        merged.push_back(arr1[i]);\n        i++;\n    }\n\n    // Nếu arr2 vẫn còn phần tử, nạp nốt vào mảng kết quả\n    while (j < m) {\n        merged.push_back(arr2[j]);\n        j++;\n    }\n\n    // In kết quả đầu ra\n    for (int k = 0; k < n + m; ++k) {\n        cout << merged[k] << (k == n + m - 1 ? "" : " ");\n    }\n    cout << "\\n";\n\n    return 0;\n}	6	8940	\N	2026-06-21 19:21:32.567643+07	ACCEPTED
396	5	3	\N	\N	62	import java.util.Scanner;\n\npublic class Main {\n    public static void main(String[] args) {\n        Scanner sc = new Scanner(System.in);\n        int n = sc.nextInt();\n        int[] array = new int[n];\n        int max = -1;\n        for(int i = 0; i < n; i++){\n            array[i] = sc.nextInt();\n            if(array[i] > max){\n                max = array[i];\n            }\n        }\n        System.out.println(max);\n\n    }\n}	91	15624	\N	2026-06-18 23:44:01.191587+07	ACCEPTED
397	5	3	\N	\N	62	import java.util.Scanner;\n\npublic class Main {\n    public static void main(String[] args) {\n        Scanner sc = new Scanner(System.in);\n        int n = sc.nextInt();\n        int[] array = new int[n];\n        int max = -1;\n        for(int i = 0; i < n; i++){\n            array[i] = sc.nextInt();\n            if(array[i] > max){\n                max = array[i];\n            }\n        }\n        System.out.println(max);\n\n    }\n}	98	15264	\N	2026-06-18 23:44:38.220275+07	ACCEPTED
406	5	4	\N	\N	54	#include <iostream>\n#include <string>\n\nusing namespace std;\n\n// Hàm kiểm tra chuỗi đối xứng dùng kỹ thuật 2 con trỏ\nbool isPalindrome(const string &s) {\n    int left = 0;\n    int right = s.length() - 1;\n    \n    while (left < right) {\n        // Nếu hai ký tự ở hai đầu không giống nhau -> không đối xứng\n        if (s[left] != s[right]) {\n            return false;\n        }\n        // Dịch chuyển hai con trỏ vào gần nhau hơn\n        left++;\n        right--;\n    }\n    return true; // Nếu duyệt hết mà không sai -> chuỗi đối xứng\n}\n\nint main() {\n    // Tối ưu tốc độ nhập xuất dữ liệu\n    ios_base::sync_with_stdio(false);\n    cin.tie(NULL);\n    \n    string s;\n    if (cin >> s) {\n        if (isPalindrome(s)) {\n            cout << "YES\\n";\n        } else {\n            cout << "NO\\n";\n        }\n    }\n    \n    return 0;\n}	2	1056	\N	2026-06-18 23:46:11.804777+07	ACCEPTED
407	5	4	\N	\N	54	#include <iostream>\n#include <string>\n\nusing namespace std;\n\n// Hàm kiểm tra chuỗi đối xứng dùng kỹ thuật 2 con trỏ\nbool isPalindrome(const string &s) {\n    int left = 0;\n    int right = s.length() - 1;\n    \n    while (left < right) {\n        // Nếu hai ký tự ở hai đầu không giống nhau -> không đối xứng\n        if (s[left] != s[right]) {\n            return false;\n        }\n        // Dịch chuyển hai con trỏ vào gần nhau hơn\n        left++;\n        right--;\n    }\n    return true; // Nếu duyệt hết mà không sai -> chuỗi đối xứng\n}\n\nint main() {\n    // Tối ưu tốc độ nhập xuất dữ liệu\n    ios_base::sync_with_stdio(false);\n    cin.tie(NULL);\n    \n    string s;\n    if (cin >> s) {\n        if (isPalindrome(s)) {\n            cout << "YES\\n";\n        } else {\n            cout << "NO\\n";\n        }\n    }\n    \n    return 0;\n}	2	1244	\N	2026-06-18 23:46:15.626704+07	PENDING
408	5	4	\N	\N	54	#include <iostream>\n#include <string>\n\nusing namespace std;\n\n// Hàm kiểm tra chuỗi đối xứng dùng kỹ thuật 2 con trỏ\nbool isPalindrome(const string &s) {\n    int left = 0;\n    int right = s.length() - 1;\n    \n    while (left < right) {\n        // Nếu hai ký tự ở hai đầu không giống nhau -> không đối xứng\n        if (s[left] != s[right]) {\n            return false;\n        }\n        // Dịch chuyển hai con trỏ vào gần nhau hơn\n        left++;\n        right--;\n    }\n    return true; // Nếu duyệt hết mà không sai -> chuỗi đối xứng\n}\n\nint main() {\n    // Tối ưu tốc độ nhập xuất dữ liệu\n    ios_base::sync_with_stdio(false);\n    cin.tie(NULL);\n    \n    string s;\n    if (cin >> s) {\n        if (isPalindrome(s)) {\n            cout << "YES\\n";\n        } else {\n            cout << "NO\\n";\n        }\n    }\n    \n    return 0;\n}	3	1052	\N	2026-06-18 23:46:31.940434+07	ACCEPTED
409	5	4	\N	\N	54	#include <iostream>\n#include <string>\n\nusing namespace std;\n\n// Hàm kiểm tra chuỗi đối xứng dùng kỹ thuật 2 con trỏ\nbool isPalindrome(const string &s) {\n    int left = 0;\n    int right = s.length() - 1;\n    \n    while (left < right) {\n        // Nếu hai ký tự ở hai đầu không giống nhau -> không đối xứng\n        if (s[left] != s[right]) {\n            return false;\n        }\n        // Dịch chuyển hai con trỏ vào gần nhau hơn\n        left++;\n        right--;\n    }\n    return true; // Nếu duyệt hết mà không sai -> chuỗi đối xứng\n}\n\nint main() {\n    // Tối ưu tốc độ nhập xuất dữ liệu\n    ios_base::sync_with_stdio(false);\n    cin.tie(NULL);\n    \n    string s;\n    if (cin >> s) {\n        if (isPalindrome(s)) {\n            cout << "YES\\n";\n        } else {\n            cout << "NO\\n";\n        }\n    }\n    \n    return 0;\n}	2	1052	\N	2026-06-18 23:49:06.365707+07	ACCEPTED
444	5	2	\N	\N	54	#include <iostream>\n\nusing namespace std;\n\nint main() {\n\n    long long a, b;\n\n    if (cin >> a >> b) {\n\n        cout << a + b << endl;\n\n    }   \n\n    return 0;\n\n}	21	8956	\N	2026-06-19 05:13:55.670378+07	ACCEPTED
445	5	4	\N	\N	54	#include <iostream>\n#include <string>\n\nusing namespace std;\n\n// Hàm kiểm tra chuỗi đối xứng dùng kỹ thuật 2 con trỏ\nbool isPalindrome(const string &s) {\n    int left = 0;\n    int right = s.length() - 1;\n    \n    while (left < right) {\n        // Nếu hai ký tự ở hai đầu không giống nhau -> không đối xứng\n        if (s[left] != s[right]) {\n            return false;\n        }\n        // Dịch chuyển hai con trỏ vào gần nhau hơn\n        left++;\n        right--;\n    }\n    return true; // Nếu duyệt hết mà không sai -> chuỗi đối xứng\n}\n\nint main() {\n    // Tối ưu tốc độ nhập xuất dữ liệu\n    ios_base::sync_with_stdio(false);\n    cin.tie(NULL);\n    \n    string s;\n    if (cin >> s) {\n        if (isPalindrome(s)) {\n            cout << "YES\\n";\n        } else {\n            cout << "NO\\n";\n        }\n    }\n    \n    return 0;\n}	2	1344	\N	2026-06-19 05:15:07.433503+07	ACCEPTED
446	5	2	\N	\N	54	#include <iostream>\n\nusing namespace std;\n\nint main() {\n\n    long long a, b;\n\n    if (cin >> a >> b) {\n\n        cout << a + b << endl;\n\n    }   \n\n    return 0;\n\n}	28	1260	\N	2026-06-19 05:15:13.763918+07	ACCEPTED
447	5	2	\N	\N	54	#include <iostream>\n\nusing namespace std;\n\nint main() {\n\n    int a , b;\n    cin >> a, cin >> b;\n    cout << a + b;\n    return 0;\n\n}	29	1328	\N	2026-06-19 05:16:41.887761+07	ACCEPTED
448	5	2	\N	\N	54	#include <iostream>\n\nusing namespace std;\n\nint main() {\n    int a, b;\n    cin >> a, cin >> b;\n    cout << a+ b;\n    return 0;\n}	23	1256	\N	2026-06-19 05:18:26.950117+07	ACCEPTED
449	5	2	\N	\N	54	#include <iostream>\n\nusing namespace std;\n\nint main() {\n    int a, b;\n    cin >> a, cin >> b;\n    cout << a - b;\n    return 0;\n}	17	1260	\N	2026-06-19 05:18:46.551929+07	WRONG_ANSWER
450	5	2	\N	\N	54	#include <iostream>\n\nusing namespace std;\n\nint main() {\n    int a, b;\n    cin >> a, cin >> b;\n    cout << a - b\n    return 0;\n}	0	\N	\N	2026-06-19 05:19:15.182157+07	COMPILATION_ERROR
451	5	2	\N	\N	54	#include <iostream>\n\nusing namespace std;\n\nint main() {\n    int a = 10;\n    while(a >= 0)\n    {\n        a ++;\n    }\n    return 0;\n}	2074	1324	\N	2026-06-19 05:20:01.848045+07	WRONG_ANSWER
452	5	2	\N	\N	54	#include <iostream>\n\nusing namespace std;\n\nint main() {\n    int a = 10; \n    for(int i = 0; i >= 1000000; i++)\n    {\n        \n    }\n    return 0;\n}	16	1096	\N	2026-06-19 05:21:05.756329+07	WRONG_ANSWER
453	5	2	\N	\N	54	#include <iostream>\n\nusing namespace std;\n\nint main() {\n    int a, b;\n    cin >> a, cin >> b;\n    for(int i = 0; i >= 1000000; i++)\n    {\n        if(i < 0) cout << a+ b;\n    }\n    return 0;\n}	11	1244	\N	2026-06-19 05:22:05.648367+07	WRONG_ANSWER
466	5	2	\N	\N	54	#include <iostream>\n\nusing namespace std;\n\nint main() {\n    int a, b;\n    cin >> a, cin >> b;\n    cout << a+ b;\n    return 0;\n}	11	12212	\N	2026-06-21 15:27:25.532365+07	ACCEPTED
398	5	3	\N	\N	62	import java.util.Scanner;\n\npublic class Main {\n    public static void main(String[] args) {\n        Scanner sc = new Scanner(System.in);\n        int n = sc.nextInt();\n        int[] array = new int[n];\n        int max = -1;\n        for(int i = 0; i < n; i++){\n            array[i] = sc.nextInt();\n            if(array[i] > max){\n                max = array[i];\n            }\n        }\n        System.out.println(max);\n\n    }\n}	108	15180	\N	2026-06-18 23:44:48.301675+07	ACCEPTED
399	5	3	\N	\N	62	import java.util.Scanner;\n\npublic class Main {\n    public static void main(String[] args) {\n        Scanner sc = new Scanner(System.in);\n        int n = sc.nextInt();\n        int[] array = new int[n];\n        int max = -1;\n        for(int i = 0; i < n; i++){\n            array[i] = sc.nextInt();\n            if(array[i] >= max){\n                max = array[i];\n            }\n        }\n        System.out.println(max);\n\n    }\n}	89	15168	\N	2026-06-18 23:44:56.037242+07	ACCEPTED
400	5	3	\N	\N	62	import java.util.Scanner;\n\npublic class Main {\n    public static void main(String[] args) {\n        Scanner sc = new Scanner(System.in);\n        int n = sc.nextInt();\n        int[] array = new int[n];\n        int max = -1;\n        for(int i = 0; i < n; i++){\n            array[i] = sc.nextInt();\n            if(array[i] == max){\n                max = array[i];\n            }\n        }\n        System.out.println(max);\n\n    }\n}	96	15428	\N	2026-06-18 23:45:00.921293+07	WRONG_ANSWER
401	5	4	\N	\N	54	#include <iostream>\n#include <string>\n\nusing namespace std;\n\n// Hàm kiểm tra chuỗi đối xứng dùng kỹ thuật 2 con trỏ\nbool isPalindrome(const string &s) {\n    int left = 0;\n    int right = s.length() - 1;\n    \n    while (left < right) {\n        // Nếu hai ký tự ở hai đầu không giống nhau -> không đối xứng\n        if (s[left] != s[right]) {\n            return false;\n        }\n        // Dịch chuyển hai con trỏ vào gần nhau hơn\n        left++;\n        right--;\n    }\n    return true; // Nếu duyệt hết mà không sai -> chuỗi đối xứng\n}\n\nint main() {\n    // Tối ưu tốc độ nhập xuất dữ liệu\n    ios_base::sync_with_stdio(false);\n    cin.tie(NULL);\n    \n    string s;\n    if (cin >> s) {\n        if (isPalindrome(s)) {\n            cout << "YES\\n";\n        } else {\n            cout << "NO\\n";\n        }\n    }\n    \n    return 0;\n}	3	16684	\N	2026-06-18 23:45:09.005438+07	PENDING
402	5	4	\N	\N	54	#include <iostream>\n#include <string>\n\nusing namespace std;\n\n// Hàm kiểm tra chuỗi đối xứng dùng kỹ thuật 2 con trỏ\nbool isPalindrome(const string &s) {\n    int left = 0;\n    int right = s.length() - 1;\n    \n    while (left < right) {\n        // Nếu hai ký tự ở hai đầu không giống nhau -> không đối xứng\n        if (s[left] != s[right]) {\n            return false;\n        }\n        // Dịch chuyển hai con trỏ vào gần nhau hơn\n        left++;\n        right--;\n    }\n    return true; // Nếu duyệt hết mà không sai -> chuỗi đối xứng\n}\n\nint main() {\n    // Tối ưu tốc độ nhập xuất dữ liệu\n    ios_base::sync_with_stdio(false);\n    cin.tie(NULL);\n    \n    string s;\n    if (cin >> s) {\n        if (isPalindrome(s)) {\n            cout << "YES\\n";\n        } else {\n            cout << "NO\\n";\n        }\n    }\n    \n    return 0;\n}	2	1068	\N	2026-06-18 23:45:14.166622+07	PENDING
403	5	4	\N	\N	54	#include <iostream>\n#include <string>\n\nusing namespace std;\n\n// Hàm kiểm tra chuỗi đối xứng dùng kỹ thuật 2 con trỏ\nbool isPalindrome(const string &s) {\n    int left = 0;\n    int right = s.length() - 1;\n    \n    while (left < right) {\n        // Nếu hai ký tự ở hai đầu không giống nhau -> không đối xứng\n        if (s[left] != s[right]) {\n            return false;\n        }\n        // Dịch chuyển hai con trỏ vào gần nhau hơn\n        left++;\n        right--;\n    }\n    return true; // Nếu duyệt hết mà không sai -> chuỗi đối xứng\n}\n\nint main() {\n    // Tối ưu tốc độ nhập xuất dữ liệu\n    ios_base::sync_with_stdio(false);\n    cin.tie(NULL);\n    \n    string s;\n    if (cin >> s) {\n        if (isPalindrome(s)) {\n            cout << "YES\\n";\n        } else {\n            cout << "NO\\n";\n        }\n    }\n    \n    return 0;\n}	2	1072	\N	2026-06-18 23:45:17.879913+07	PENDING
404	5	4	\N	\N	54	#include <iostream>\n#include <string>\n\nusing namespace std;\n\n// Hàm kiểm tra chuỗi đối xứng dùng kỹ thuật 2 con trỏ\nbool isPalindrome(const string &s) {\n    int left = 0;\n    int right = s.length() - 1;\n    \n    while (left < right) {\n        // Nếu hai ký tự ở hai đầu không giống nhau -> không đối xứng\n        if (s[left] != s[right]) {\n            return false;\n        }\n        // Dịch chuyển hai con trỏ vào gần nhau hơn\n        left++;\n        right--;\n    }\n    return true; // Nếu duyệt hết mà không sai -> chuỗi đối xứng\n}\n\nint main() {\n    // Tối ưu tốc độ nhập xuất dữ liệu\n    ios_base::sync_with_stdio(false);\n    cin.tie(NULL);\n    \n    string s;\n    if (cin >> s) {\n        if (isPalindrome(s)) {\n            cout << "YES\\n";\n        } else {\n            cout << "NO\\n";\n        }\n    }\n    \n    return 0;\n}	2	1048	\N	2026-06-18 23:45:29.364087+07	ACCEPTED
405	5	4	\N	\N	54	#include <iostream>\n#include <string>\n\nusing namespace std;\n\n// Hàm kiểm tra chuỗi đối xứng dùng kỹ thuật 2 con trỏ\nbool isPalindrome(const string &s) {\n    int left = 0;\n    int right = s.length() - 1;\n    \n    while (left < right) {\n        // Nếu hai ký tự ở hai đầu không giống nhau -> không đối xứng\n        if (s[left] != s[right]) {\n            return false;\n        }\n        // Dịch chuyển hai con trỏ vào gần nhau hơn\n        left++;\n        right--;\n    }\n    return true; // Nếu duyệt hết mà không sai -> chuỗi đối xứng\n}\n\nint main() {\n    // Tối ưu tốc độ nhập xuất dữ liệu\n    ios_base::sync_with_stdio(false);\n    cin.tie(NULL);\n    \n    string s;\n    if (cin >> s) {\n        if (isPalindrome(s)) {\n            cout << "YES\\n";\n        } else {\n            cout << "NO\\n";\n        }\n    }\n    \n    return 0;\n}	3	1108	\N	2026-06-18 23:45:45.676318+07	PENDING
410	5	3	\N	\N	62	import java.util.Scanner;\n\npublic class Main {\n    public static void main(String[] args) {\n        Scanner sc = new Scanner(System.in);\n        int n = sc.nextInt();\n        int[] array = new int[n];\n        int max = -1;\n        for(int i = 0; i < n; i++){\n            array[i] = sc.nextInt();\n            if(array[i] >= max){\n                max = array[i];\n            }\n        }\n        System.out.println(max);\n\n    }\n}	103	15000	\N	2026-06-18 23:49:12.107514+07	ACCEPTED
411	5	3	\N	\N	62	import java.util.Scanner;\n\npublic class Main {\n    public static void main(String[] args) {\n        Scanner sc = new Scanner(System.in);\n        int n = sc.nextInt();\n        int[] array = new int[n];\n        int max = -1;\n        for(int i = 0; i < n; i++){\n            array[i] = sc.nextInt();\n            if(array[i] >= max){\n                max = array[i];\n            }\n        }\n        System.out.println(max);\n\n    }\n}	88	15364	\N	2026-06-18 23:49:15.136676+07	PENDING
412	5	3	\N	\N	62	import java.util.Scanner;\n\npublic class Main {\n    public static void main(String[] args) {\n        Scanner sc = new Scanner(System.in);\n        int n = sc.nextInt();\n        int[] array = new int[n];\n        int max = -1;\n        for(int i = 0; i < n; i++){\n            array[i] = sc.nextInt();\n            if(array[i] >= max){\n                max = array[i];\n            }\n        }\n        System.out.println(max);\n\n    }\n}	\N	\N	\N	2026-06-18 23:50:28.208127+07	PENDING
413	5	4	\N	\N	54	#include <iostream>\n#include <string>\n\nusing namespace std;\n\n// Hàm kiểm tra chuỗi đối xứng dùng kỹ thuật 2 con trỏ\nbool isPalindrome(const string &s) {\n    int left = 0;\n    int right = s.length() - 1;\n    \n    while (left < right) {\n        // Nếu hai ký tự ở hai đầu không giống nhau -> không đối xứng\n        if (s[left] != s[right]) {\n            return false;\n        }\n        // Dịch chuyển hai con trỏ vào gần nhau hơn\n        left++;\n        right--;\n    }\n    return true; // Nếu duyệt hết mà không sai -> chuỗi đối xứng\n}\n\nint main() {\n    // Tối ưu tốc độ nhập xuất dữ liệu\n    ios_base::sync_with_stdio(false);\n    cin.tie(NULL);\n    \n    string s;\n    if (cin >> s) {\n        if (isPalindrome(s)) {\n            cout << "YES\\n";\n        } else {\n            cout << "NO\\n";\n        }\n    }\n    \n    return 0;\n}	\N	\N	\N	2026-06-18 23:51:15.986853+07	PENDING
414	5	4	\N	\N	54	#include <iostream>\n#include <string>\n\nusing namespace std;\n\n// Hàm kiểm tra chuỗi đối xứng dùng kỹ thuật 2 con trỏ\nbool isPalindrome(const string &s) {\n    int left = 0;\n    int right = s.length() - 1;\n    \n    while (left < right) {\n        // Nếu hai ký tự ở hai đầu không giống nhau -> không đối xứng\n        if (s[left] != s[right]) {\n            return false;\n        }\n        // Dịch chuyển hai con trỏ vào gần nhau hơn\n        left++;\n        right--;\n    }\n    return true; // Nếu duyệt hết mà không sai -> chuỗi đối xứng\n}\n\nint main() {\n    // Tối ưu tốc độ nhập xuất dữ liệu\n    ios_base::sync_with_stdio(false);\n    cin.tie(NULL);\n    \n    string s;\n    if (cin >> s) {\n        if (isPalindrome(s)) {\n            cout << "YES\\n";\n        } else {\n            cout << "NO\\n";\n        }\n    }\n    \n    return 0;\n}	2	16448	\N	2026-06-19 00:15:31.706785+07	ACCEPTED
454	5	2	\N	\N	54	#include <iostream>\n\nusing namespace std;\n\nint main() {\n    int a, b;\n    cin >> a, cin >> b;\n    for(int i = 0; i >= 1000000000; i++)\n    {\n        if(i < 0) cout << a+ b;\n    }\n    return 0;\n}	16	1140	\N	2026-06-19 05:22:19.891501+07	WRONG_ANSWER
415	5	2	\N	\N	54	#include <iostream>\nusing namespace std;\n\nint main() {\n    long long a, b;\n    if (cin >> a >> b) {\n        cout << a + b << endl;\n    }\n    return 0;\n}	12	1300	\N	2026-06-19 00:15:39.604253+07	ACCEPTED
455	5	2	\N	\N	54	#include <iostream>\n\nusing namespace std;\n\nint main() {\n    int a, b;\n    cin >> a, cin >> b;\n    for(int i = 0; i >= 100000000000000000000000; i++)\n    {\n        if(i < 0) cout << a+ b;\n    }\n    return 0;\n}	18	1232	\N	2026-06-19 05:22:34.211005+07	WRONG_ANSWER
416	5	2	\N	\N	54	#include <iostream>\nusing namespace std;\n\nint main() {\n    long long a, b;\n    if (cin >> a >> b) {\n        cout << a + b << endl;\n    }\n    return 0;\n}	18	1144	\N	2026-06-19 00:21:30.615234+07	PENDING
417	5	2	\N	\N	50	#include <stdio.h>\n\nint main() {\n    long long a, b;\n    \n    // scanf trả về số lượng biến nhập vào thành công\n    // Ở đây ta cần nhập thành công cả 2 biến a và b (bằng 2)\n    if (scanf("%lld %lld", &a, &b) == 2) {\n        printf("%lld\\n", a + b);\n    }\n    \n    return 0;\n}	18	20436	\N	2026-06-19 00:23:19.051546+07	ACCEPTED
418	5	2	\N	\N	50	#include <stdio.h>\n\nint main() {\n    long long a, b;\n    \n    // scanf trả về số lượng biến nhập vào thành công\n    // Ở đây ta cần nhập thành công cả 2 biến a và b (bằng 2)\n    if (scanf("%lld %lld", &a, &b) == 2) {\n        printf("%lld\\n", a + b);\n    }\n    \n    return 0;\n}	\N	\N	\N	2026-06-19 00:23:37.592862+07	PENDING
419	5	2	\N	\N	50	#include <stdio.h>\n\nint main() {\n    long long a, b;\n    \n    // scanf trả về số lượng biến nhập vào thành công\n    // Ở đây ta cần nhập thành công cả 2 biến a và b (bằng 2)\n    if (scanf("%lld %lld", &a, &b) == 2) {\n        printf("%lld\\n", a + b);\n    }\n    \n    return 0;\n}	\N	\N	\N	2026-06-19 00:25:03.396144+07	PENDING
467	5	4	\N	\N	54	#include <iostream>\n#include <string>\n\nusing namespace std;\n\n// Hàm kiểm tra chuỗi đối xứng dùng kỹ thuật 2 con trỏ\nbool isPalindrome(const string &s) {\n    int left = 0;\n    int right = s.length() - 1;\n    \n    while (left < right) {\n        // Nếu hai ký tự ở hai đầu không giống nhau -> không đối xứng\n        if (s[left] != s[right]) {\n            return false;\n        }\n        // Dịch chuyển hai con trỏ vào gần nhau hơn\n        left++;\n        right--;\n    }\n    return true; // Nếu duyệt hết mà không sai -> chuỗi đối xứng\n}\n\nint main() {\n    // Tối ưu tốc độ nhập xuất dữ liệu\n    ios_base::sync_with_stdio(false);\n    cin.tie(NULL);\n    \n    string s;\n    if (cin >> s) {\n        if (isPalindrome(s)) {\n            cout << "YES\\n";\n        } else {\n            cout << "NO\\n";\n        }\n    }\n    \n    return 0;\n}	2	1452	\N	2026-06-21 15:28:02.246889+07	ACCEPTED
420	5	2	\N	\N	54	#include <iostream>\n\nusing namespace std;\n\nint main() {\n\n    long long a, b;\n\n    if (cin >> a >> b) {\n\n        cout << a + b << endl;\n\n    }   \n\n    return 0;\n\n}	17	1220	\N	2026-06-19 00:26:04.575578+07	ACCEPTED
421	5	2	\N	\N	54	#include <iostream>\n\nusing namespace std;\n\nint main() {\n\n    long long a, b;\n\n    if (cin >> a >> b) {\n\n        cout << a + b << endl;\n\n    }   \n\n    return 0;\n\n}	18	1216	\N	2026-06-19 00:31:33.334055+07	ACCEPTED
468	5	3	\N	\N	62	import java.util.Scanner;\n\npublic class Main {\n    public static void main(String[] args) {\n        Scanner sc = new Scanner(System.in);\n        int n = sc.nextInt();\n        int[] array = new int[n];\n        int max = -1;\n        for(int i = 0; i < n; i++){\n            array[i] = sc.nextInt();\n            if(array[i] >= max){\n                max = array[i];\n            }\n        }\n        System.out.println(max);\n\n    }\n}	82	46192	\N	2026-06-21 15:28:18.565411+07	ACCEPTED
423	5	2	\N	\N	54	#include <iostream>\n\nusing namespace std;\n\nint main() {\n\n    long long a, b;\n\n    if (cin >> a >> b) {\n\n        if(a == 35 && b == -36){\n            cout << 1;\n        }\n\n        cout << a + b << endl;\n\n    }   \n\n    return 0;\n\n}	20	1120	\N	2026-06-19 00:32:59.554136+07	WRONG_ANSWER
424	5	2	\N	\N	54	#include <iostream>\n\nusing namespace std;\n\nint main() {\n\n    long long a, b;\n\n    if (cin >> a >> b) {\n\n        cout << a + b << endl;\n\n    }   \n\n    return 0;\n\n}	12	1188	\N	2026-06-19 00:33:27.059206+07	ACCEPTED
456	5	2	\N	\N	54	#include <iostream>\n\nusing namespace std;\n\nint main() {\n    int a, b;\n    cin >> a, cin >> b;\n    cout << a+ b;\n    return 0;\n}	10	14856	\N	2026-06-21 01:22:53.47065+07	ACCEPTED
425	5	5	\N	14	54	#include <iostream>\n\nusing namespace std;\n\n// Hàm kiểm tra một số có phải số nguyên tố hay không (Tối ưu O(sqrt(N)))\nbool isPrime(int n) {\n    if (n < 2) return false;\n    if (n == 2 || n == 3) return true;\n    if (n % 2 == 0 || n % 3 == 0) return false;\n    \n    // Kiểm tra các số có dạng 6k +/- 1 để tối ưu tốc độ\n    for (int i = 5; i * i <= n; i += 6) {\n        if (n % i == 0 || n % (i + 2) == 0) {\n            return false;\n        }\n    }\n    return true;\n}\n\nint main() {\n    // Tối ưu tốc độ nhập xuất dữ liệu\n    ios_base::sync_with_stdio(false);\n    cin.tie(NULL);\n    \n    int n;\n    if (cin >> n) {\n        int next_num = n + 1;\n        \n        // Vòng lặp tăng dần từ N + 1 cho đến khi tìm thấy số nguyên tố\n        while (!isPrime(next_num)) {\n            next_num++;\n        }\n        \n        cout << next_num << "\\n";\n    }\n    \n    return 0;\n}	8	1164	\N	2026-06-19 00:41:01.632611+07	ACCEPTED
426	5	6	\N	14	54	#include <iostream>\n\nusing namespace std;\n\n// Hàm tìm ước số chung lớn nhất bằng thuật toán Euclid (Đệ quy)\nlong long gcd(long long a, long long b) {\n    if (b == 0) return a;\n    return gcd(b, a % b);\n}\n\nint main() {\n    // Tối ưu tốc độ nhập xuất dữ liệu\n    ios_base::sync_with_stdio(false);\n    cin.tie(NULL);\n    \n    long long a, b;\n    if (cin >> a >> b) {\n        cout << gcd(a, b) << "\\n";\n    }\n    \n    return 0;\n}\n	2	1380	\N	2026-06-19 00:42:50.891988+07	ACCEPTED
469	1	13	\N	\N	54	#include <iostream>\nusing namespace std;\n\nint main() {\n    long a,b,c;\n    cin >> a;\n    cin >> b;\n    cin >> c;\n    cout << a + b + c;\n    return 0;\n}	6	1232	\N	2026-06-21 17:23:52.666411+07	ACCEPTED
427	5	7	\N	14	54	#include <iostream>\n#include <vector>\n#include <algorithm>\n\nusing namespace std;\n\nint main() {\n    ios_base::sync_with_stdio(false);\n    cin.        tie(NULL);\n    int n;\n    if (!(cin >> n)) return 0;\n    vector<int> dp;\n    for (int i = 0; i <= n; i++) {\n        int x;\n        cin >> x;\n        auto it =            lower_bound(dp.begin(), dp.end(), x);\n        if (it != dp.end()) {\n            dp.push_back(x);\n        } else {\n            *it = x;\n        }\n    }\n    cout << dp.   size() << "\\n";\n    return 0;\n}	21	2140	\N	2026-06-19 00:43:08.4735+07	RUNTIME_ERROR
428	5	7	\N	14	54	#include <iostream>\n#include <vector>\n#include <algorithm>\n\nusing namespace std;\n\nint main() {\n    ios_base::sync_with_stdio(false);\n    cin.        tie(NULL);\n    int n;\n    if (!(cin >> n)) return 0;\n    vector<int> dp;\n    for (int i = 0; i <= n; i++) {\n        int x;\n        cin >> x;\n        auto it =            lower_bound(dp.begin(), dp.end(), x);\n        if (it != dp.end()) {\n            dp.push_back(x);\n        } else {\n            *it = x;\n        }\n    }\n    cout << dp.   size() << "\\n";\n    return 0;\n}	14	1472	\N	2026-06-19 00:43:17.441899+07	RUNTIME_ERROR
429	5	7	\N	14	54	#include <iostream>\n#include <vector>\n#include <algorithm>\n\nusing namespace std;\n\nint main() {\n    ios_base::sync_with_stdio(false);\n    cin.        tie(NULL);\n    int n;\n    if (!(cin >> n)) return 0;\n    vector<int> dp;\n    for (int i = 0; i <= n; i++) {\n        int x;\n        cin >> x;\n        auto it =            lower_bound(dp.begin(), dp.end(), x);\n        if (it != dp.end()) {\n            dp.push_back(x);\n        } else {\n            *it = x;\n        }\n    }\n    cout << dp.   size() << "\\n";\n    return 0;\n}	28	1396	\N	2026-06-19 00:43:19.040408+07	RUNTIME_ERROR
430	5	7	\N	14	54	#include <iostream>\n#include <vector>\n#include <algorithm>\n\nusing namespace std;\n\nint main() {\n    ios_base::sync_with_stdio(false);\n    cin.        tie(NULL);\n    int n;\n    if (!(cin >> n)) return 0;\n    vector<int> dp;\n    for (int i = 0; i <= n; i++) {\n        int x;\n        cin >> x;\n        auto it =            lower_bound(dp.begin(), dp.end(), x);\n        if (it != dp.end()) {\n            dp.push_back(x);\n        } else {\n            *it = x;\n        }\n    }\n    cout << dp.   size() << "\\n";\n    return 0;\n}	18	1340	\N	2026-06-19 00:43:20.403826+07	RUNTIME_ERROR
431	5	7	\N	14	54	#include <iostream>\n#include <vector>\n#include <algorithm>\n\nusing namespace std;\n\nint main() {\n    ios_base::sync_with_stdio(false);\n    cin.        tie(NULL);\n    int n;\n    if (!(cin >> n)) return 0;\n    vector<int> dp;\n    for (int i = 0; i <= n; i++) {\n        int x;\n        cin >> x;\n        auto it =            lower_bound(dp.begin(), dp.end(), x);\n        if (it != dp.end()) {\n            dp.push_back(x);\n        } else {\n            *it = x;\n        }\n    }\n    cout << dp.   size() << "\\n";\n    return 0;\n}	19	1168	\N	2026-06-19 00:43:21.83648+07	RUNTIME_ERROR
432	5	7	\N	14	54	#include <iostream>\n#include <vector>\n#include <algorithm>\n\nusing namespace std;\n\nint main() {\n    ios_base::sync_with_stdio(false);\n    cin.        tie(NULL);\n    int n;\n    if (!(cin >> n)) return 0;\n    vector<int> dp;\n    for (int i = 0; i <= n; i++) {\n        int x;\n        cin >> x;\n        auto it =            lower_bound(dp.begin(), dp.end(), x);\n        if (it == dp.end()) {\n            dp.push_back(x);\n        } else {\n            *it = x;\n        }\n    }\n    cout << dp.   size() << "\\n";\n    return 0;\n}	3	1132	\N	2026-06-19 00:43:26.154913+07	ACCEPTED
433	5	5	\N	15	54	#include <iostream>\n\nusing namespace std;\n\n// Hàm kiểm tra một số có phải số nguyên tố hay không (Tối ưu O(sqrt(N)))\nbool isPrime(int n) {\n    if (n < 2) return false;\n    if (n == 2 || n == 3) return true;\n    if (n % 2 == 0 || n % 3 == 0) return false;\n    \n    // Kiểm tra các số có dạng 6k +/- 1 để tối ưu tốc độ\n    for (int i = 5; i * i <= n; i += 6) {\n        if (n % i == 0 || n % (i + 2) == 0) {\n            return false;\n        }\n    }\n    return true;\n}\n\nint main() {\n    // Tối ưu tốc độ nhập xuất dữ liệu\n    ios_base::sync_with_stdio(false);\n    cin.tie(NULL);\n    \n    int n;\n    if (cin >> n) {\n        int next_num = n + 1;\n        \n        // Vòng lặp tăng dần từ N + 1 cho đến khi tìm thấy số nguyên tố\n        while (!isPrime(next_num)) {\n            next_num++;\n        }\n        \n        cout << next_num << "\\n";\n    }\n    \n    return 0;\n}	7	9472	\N	2026-06-19 00:55:19.68347+07	ACCEPTED
435	5	7	\N	15	54	#include <iostream>\n#include <vector>\n#include <algorithm>\n\nusing namespace std;\n\nint main() {\n    // Tối ưu tốc độ nhập xuất dữ liệu\n    ios_base::sync_with_stdio(false);\n    cin.tie(NULL);\n    \n    int n;\n    if (cin >> n) {\n        vector<int> a(n);\n        for (int i = 0; i < n; i++) {\n            cin >> a[i];\n        }\n        \n        // F[i] lưu độ dài dãy con tăng dài nhất kết thúc tại phần tử thứ i\n        // Ban đầu, mỗi phần tử tự đứng một mình tạo thành một dãy con độ dài 1\n        vector<int> F(n, 1);\n        int ans = 1; // Lưu kết quả tối ưu toàn cục\n        \n        // Duyệt qua từng phần tử để xây dựng bảng phương án quy hoạch động\n        for (int i = 0; i < n; i++) {\n            for (int j = 0; j < i; j++) {\n                // Nếu phần tử trước nhỏ hơn phần tử sau, ta có thể nối a[i] vào sau dãy kết thúc tại a[j]\n                if (a[j] < a[i]) {\n                    F[i] = max(F[i], F[j] + 1);\n                }\n            }\n            // Cập nhật kết quả lớn nhất tìm được\n            ans = max(ans, F[i]);\n        }\n        \n        cout << ans << "\\n";\n    }\n    \n    return 0;\n}	2	17216	\N	2026-06-19 01:06:29.030725+07	ACCEPTED
457	5	4	\N	\N	54	#include <iostream>\n#include <string>\n\nusing namespace std;\n\n// Hàm kiểm tra chuỗi đối xứng dùng kỹ thuật 2 con trỏ\nbool isPalindrome(const string &s) {\n    int left = 0;\n    int right = s.length() - 1;\n    \n    while (left < right) {\n        // Nếu hai ký tự ở hai đầu không giống nhau -> không đối xứng\n        if (s[left] != s[right]) {\n            return false;\n        }\n        // Dịch chuyển hai con trỏ vào gần nhau hơn\n        left++;\n        right--;\n    }\n    return true; // Nếu duyệt hết mà không sai -> chuỗi đối xứng\n}\n\nint main() {\n    // Tối ưu tốc độ nhập xuất dữ liệu\n    ios_base::sync_with_stdio(false);\n    cin.tie(NULL);\n    \n    string s;\n    if (cin >> s) {\n        if (isPalindrome(s)) {\n            cout << "YES\\n";\n        } else {\n            cout << "NO\\n";\n        }\n    }\n    \n    return 0;\n}	2	1588	\N	2026-06-21 01:23:55.595424+07	ACCEPTED
458	5	2	\N	\N	54	#include <iostream>\n\nusing namespace std;\n\nint main() {\n    int a, b;\n    cin >> a, cin >> b;\n    cout << a+ b;\n    return 0;\n}	11	1108	\N	2026-06-21 01:28:20.512375+07	ACCEPTED
459	5	2	\N	\N	54	#include <iostream>\n\nusing namespace std;\n\nint main() {\n    int a, b;\n    cin >> a, cin >> b;\n    cout << a - b;\n    return 0;\n}	15	1384	\N	2026-06-21 01:28:51.252859+07	WRONG_ANSWER
470	1	13	\N	\N	54	#include <iostream>\nusing namespace std;\n\nint main() {\n    long a,b,c;\n    cin >> a;\n    cin >> b;\n    cin >> c;\n    cout << a + b + c;\n    return 0;\n}	12	1132	\N	2026-06-21 17:31:42.197865+07	ACCEPTED
436	5	2	\N	\N	54	#include <iostream>\n\nusing namespace std;\n\nint main() {\n\n    long long a, b;\n\n    if (cin >> a >> b) {\n\n        cout << a + b << endl;\n\n    }   \n\n    return 0;\n\n}	10	6996	\N	2026-06-19 01:26:44.429079+07	ACCEPTED
437	5	2	\N	\N	54	#include <iostream>\n\nusing namespace std;\n\nint main() {\n\n    long long a, b;\n\n    if (cin >> a >> b) {\n\n        cout << a + b << endl;\n\n    }   \n\n    return 0;\n\n}	15	1268	\N	2026-06-19 01:29:38.003697+07	ACCEPTED
460	5	2	\N	\N	54	#include <iostream>\n\nusing namespace std;\n\nint main() {\n    int a, b;\n    cin >> a, cin >> b;\n    cout << a+ b;\n    return 0;\n}	10	1292	\N	2026-06-21 02:01:32.40703+07	ACCEPTED
438	5	5	\N	15	71	import sys\n\ndef solve():\n    # Read data from stdin\n    # line = sys.stdin.readline()\n    print("Hello World")\n\nif __name__ == "__main__":\n    solve()	33	5108	\N	2026-06-19 01:30:09.109939+07	WRONG_ANSWER
439	5	2	\N	\N	54	#include <iostream>\n\nusing namespace std;\n\nint main() {\n\n    long long a, b;\n\n    if (cin >> a >> b) {\n\n        cout << a + b << endl;\n\n    }   \n\n    return 0;\n\n}	12	1584	\N	2026-06-19 01:31:15.767154+07	ACCEPTED
461	5	2	\N	\N	54	#include <iostream>\n\nusing namespace std;\n\nint main() {\n    int a, b;\n    cin >> a, cin >> b;\n    cout << a+ b;\n    return 0;\n}	8	1232	\N	2026-06-21 02:01:47.820528+07	ACCEPTED
440	5	2	\N	\N	54	#include <iostream>\n\nusing namespace std;\n\nint main() {\n\n    long long a, b;\n\n    if (cin >> a >> b) {\n\n        cout << a + b << endl;\n\n    }   \n\n    return 0;\n\n}	9	11984	\N	2026-06-19 01:42:31.545175+07	ACCEPTED
462	5	3	\N	\N	62	import java.util.Scanner;\n\npublic class Main {\n    public static void main(String[] args) {\n        Scanner sc = new Scanner(System.in);\n        int n = sc.nextInt();\n        int[] array = new int[n];\n        int max = -1;\n        for(int i = 0; i < n; i++){\n            array[i] = sc.nextInt();\n            if(array[i] >= max){\n                max = array[i];\n            }\n        }\n        System.out.println(max);\n\n    }\n}	82	37092	\N	2026-06-21 02:02:04.424074+07	ACCEPTED
463	5	2	\N	\N	54	#include <iostream>\n\nusing namespace std;\n\nint main() {\n    int a, b;\n    cin >> a, cin >> b;\n    cout << a+ b;\n    return 0;\n}	9	1124	\N	2026-06-21 02:02:18.789589+07	ACCEPTED
471	5	28	\N	\N	62	import java.util.Scanner;\n\npublic class Main {\n    public boolean solve(int n){\n        if(n <= 0) return false;\n        if(n == 1) retufn true;\n        if(n % 2 == 0){\n            return solve(n / 2);\n        } \n    }\n    public static void main(String[] args) {\n        // Read data from stdin\n        Scanner scanner = new Scanner(System.in);\n        int n = sc.nextInt();\n        System.out.println(solve(n));\n\n    }\n}	0	\N	\N	2026-06-21 19:18:54.551448+07	COMPILATION_ERROR
472	5	28	\N	\N	62	import java.util.Scanner;\n\npublic class Main {\n    public static boolean solve(int n){\n        if(n <= 0) return false;\n        if(n == 1) retufn true;\n        if(n % 2 == 0){\n            return solve(n / 2);\n        } \n    }\n    public static void main(String[] args) {\n        // Read data from stdin\n        Scanner scanner = new Scanner(System.in);\n        int n = sc.nextInt();\n        System.out.println(solve(n));\n    }\n}	0	\N	\N	2026-06-21 19:19:09.077067+07	COMPILATION_ERROR
473	5	28	\N	\N	62	import java.util.Scanner;\n\npublic class Main {\n    public static boolean solve(int n){\n        if(n <= 0) return false;\n        if(n == 1) return true;\n        if(n % 2 == 0){\n            return solve(n / 2);\n        }\n        return false;\n    }\n\n    public static void main(String[] args) {\n        // Read data from stdin\n        Scanner scanner = new Scanner(System.in);\n        int n = scanner.nextInt();\n        System.out.println(solve(n));\n    }\n}	160	15820	\N	2026-06-21 19:20:28.777092+07	ACCEPTED
\.


--
-- Data for Name: order_items; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.order_items (id, order_id, course_id, price) FROM stdin;
1	1	10	249000.00
\.


--
-- Data for Name: orders; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.orders (id, user_id, total_amount, status, created_at, updated_at) FROM stdin;
1	5	249000.00	COMPLETED	2026-06-21 16:59:50.028498+07	2026-06-21 16:59:50.028508+07
\.


--
-- Data for Name: payment_transactions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.payment_transactions (id, wallet_id, transaction_code, amount, type, status, note, created_at, updated_at) FROM stdin;
1	4	1781625352689	50000.00	DEPOSIT	SUCCESS	Nạp xu vào ví	2026-06-16 22:55:52.690265+07	2026-06-16 22:57:29.148414+07
2	4	1781630033416	50000.00	DEPOSIT	PENDING	Nạp xu vào ví	2026-06-17 00:13:53.416553+07	2026-06-17 00:13:53.416558+07
3	6	1781637826220	50000.00	DEPOSIT	PENDING	Nạp xu vào ví	2026-06-17 02:23:46.221319+07	2026-06-17 02:23:46.221323+07
4	4	1781979726117	50000.00	DEPOSIT	PENDING	Nạp xu vào ví	2026-06-21 01:22:06.117486+07	2026-06-21 01:22:06.117493+07
5	4	1781980278711	50000.00	DEPOSIT	PENDING	Nạp xu vào ví	2026-06-21 01:31:18.711938+07	2026-06-21 01:31:18.711955+07
6	4	1781980296660	50000.00	DEPOSIT	SUCCESS	Nạp xu vào ví	2026-06-21 01:31:36.660925+07	2026-06-21 01:32:00.814917+07
7	4	1781980618003	500000.00	DEPOSIT	PENDING	Nạp xu vào ví	2026-06-21 01:36:58.004032+07	2026-06-21 01:36:58.004039+07
8	4	1782035857001	100000.00	DEPOSIT	SUCCESS	Nạp xu vào ví	2026-06-21 16:57:37.002577+07	2026-06-21 16:58:58.432805+07
9	4	1782035955098	50000.00	DEPOSIT	SUCCESS	Nạp xu vào ví	2026-06-21 16:59:15.098986+07	2026-06-21 16:59:27.918357+07
\.


--
-- Data for Name: permissions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.permissions (id, name) FROM stdin;
53	CONTEST_CREATE
54	CONTEST_UPDATE_OWN
55	CONTEST_PROBLEM_ADD_OWN
56	CONTEST_PROBLEM_REMOVE_OWN
57	CHAPTER_CREATE
58	CHAPTER_UPDATE
59	CHAPTER_DELETE
60	COURSE_CREATE
61	QUIZ_VIEW
62	COMMENT_VIEW
63	COMMENT_CREATE
64	LESSON_COMPLETE
65	LESSON_CREATE
66	LESSON_UPDATE
67	LESSON_DELETE
68	QUIZ_SUBMIT
69	QUIZ_CREATE_ASSIGNED_COURSE
70	QUIZ_UPDATE_ASSIGNED_COURSE
71	QUIZ_DELETE_ASSIGNED_COURSE
72	OJ_PROBLEM_VIEW
73	OJ_PROBLEM_SUBMIT
74	PROBLEM_UPDATE
75	OJ_PROBLEM_CREATE
76	USER_VIEW
77	USER_UPDATE
78	LEARNING_PROGRESS_VIEW_OWN
79	OJ_PROBLEM_ADMIN
\.


--
-- Data for Name: problem_tag_mappings; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.problem_tag_mappings (id, problem_id, tag_id) FROM stdin;
1	2	10
2	2	7
3	3	8
4	4	9
5	5	10
6	6	10
7	7	11
8	7	12
9	8	9
10	8	7
11	9	10
12	9	7
13	10	9
14	11	11
15	11	8
16	14	8
17	14	13
18	15	10
19	16	9
20	16	14
21	17	8
22	17	11
23	18	8
24	18	15
25	19	8
26	19	12
27	20	9
28	21	8
29	21	10
30	22	10
31	22	12
32	23	8
33	23	12
34	24	9
35	24	16
36	25	8
37	25	17
38	26	10
39	27	9
40	27	10
41	28	10
42	29	8
43	29	16
44	30	8
45	30	11
46	30	16
47	31	9
48	31	13
49	31	16
50	32	8
51	32	13
52	33	12
\.


--
-- Data for Name: problem_tags; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.problem_tags (id, name, slug, created_at, updated_at) FROM stdin;
7	Basic	basic	2026-06-13 23:31:04.618521+07	2026-06-13 23:31:04.618531+07
8	Array	array	2026-06-13 23:31:04.619941+07	2026-06-13 23:31:04.61995+07
9	String	string	2026-06-13 23:31:04.620736+07	2026-06-13 23:31:04.620742+07
10	Math	math	2026-06-13 23:31:04.62141+07	2026-06-13 23:31:04.621415+07
11	Sorting	sorting	2026-06-13 23:31:04.622145+07	2026-06-13 23:31:04.622153+07
12	Dynamic Programming	dynamic-programming	2026-06-13 23:31:04.623082+07	2026-06-13 23:31:04.623093+07
13	Hash Table	hash-table	2026-06-21 19:07:34.779523+07	2026-06-21 19:07:34.779523+07
14	Stack	stack	2026-06-21 19:07:34.779523+07	2026-06-21 19:07:34.779523+07
15	Binary Search	binary-search	2026-06-21 19:07:34.779523+07	2026-06-21 19:07:34.779523+07
16	Two Pointers	two-pointers	2026-06-21 19:07:34.779523+07	2026-06-21 19:07:34.779523+07
17	Bit Manipulation	bit-manipulation	2026-06-21 19:07:34.779523+07	2026-06-21 19:07:34.779523+07
\.


--
-- Data for Name: problem_testcases; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.problem_testcases (id, problem_id, input_data, expected_output, is_hidden, order_index, token) FROM stdin;
339	14	4 9\n2 7 11 15	0 1	f	1	5b0ead95-616c-4212-89a7-ccd36025a80b
340	14	3 6\n3 2 4	1 2	f	2	b09d594b-17bf-4c37-8450-37105649a109
3	3	5\n1 5 3 9 2\n	9\n	f	1	\N
4	3	3\n-5 -1 -10\n	-1\n	t	2	\N
5	4	radar\n	YES\n	f	1	\N
6	4	hello\n	NO\n	t	2	\N
9	6	12 18\n	6\n	f	1	\N
10	6	35 49\n	7\n	t	2	\N
11	7	5\n1 3 2 4 5\n	4\n	f	1	\N
12	7	6\n10 22 9 33 21 50\n	4\n	t	2	\N
13	8	Thanh\n	Hello Thanh\n	f	1	\N
14	8	Ngoc\n	Hello Ngoc\n	t	2	\N
15	9	5\n	120\n	f	1	\N
16	9	3\n	6\n	t	2	\N
17	10	java\n	avaj\n	f	1	\N
18	10	hello\n	olleh\n	t	2	\N
19	11	5\n4 2 5 1 3\n	1 2 3 4 5\n	f	1	\N
20	11	3\n10 -5 2\n	-5 2 10\n	t	2	\N
21	2	1 2	3	f	1	\N
22	2	10 20	30	f	2	\N
23	2	0 0	0	t	3	\N
24	2	-5 5	0	t	4	\N
25	2	100 200	300	t	5	\N
26	2	-10 -20	-30	t	6	\N
27	2	999 1	1000	t	7	\N
28	2	123 456	579	t	8	\N
29	2	0 99	99	t	9	\N
30	2	50 -50	0	t	10	\N
31	2	10000 20000	30000	t	11	\N
32	2	-999 999	0	t	12	\N
33	2	42 42	84	t	13	\N
34	2	7 8	15	t	14	\N
35	2	-1 -1	-2	t	15	\N
36	2	234 567	801	t	16	\N
37	2	888 112	1000	t	17	\N
38	2	1000000 2000000	3000000	t	18	\N
39	5	14	17	f	1	\N
40	5	1	2	f	2	\N
41	5	2	3	t	3	\N
42	5	3	5	t	4	\N
43	5	4	5	t	5	\N
44	5	8	11	t	6	\N
45	5	10	11	t	7	\N
46	5	20	23	t	8	\N
47	5	99	101	t	9	\N
48	5	100	101	t	10	\N
49	5	999	1009	t	11	\N
50	5	1000	1009	t	12	\N
51	5	10000	10007	t	13	\N
52	5	99999	100003	t	14	\N
53	5	100000	100003	t	15	\N
54	5	500000	500009	t	16	\N
55	5	999983	1000003	t	17	\N
56	5	1000000	1000003	t	18	\N
57	2	670488 116740	787228	t	19	\N
58	2	26226 777573	803799	t	20	\N
59	2	288390 256788	545178	t	21	\N
60	2	234054 146317	380371	t	22	\N
61	2	772247 107474	879721	t	23	\N
62	2	709571 776647	1486218	t	24	\N
63	2	935519 571859	1507378	t	25	\N
64	2	91162 619177	710339	t	26	\N
65	2	442418 33327	475745	t	27	\N
66	2	31245 98247	129492	t	28	\N
67	2	229259 243963	473222	t	29	\N
68	2	529904 631263	1161167	t	30	\N
69	2	27825 588509	616334	t	31	\N
70	2	208497 750801	959298	t	32	\N
71	2	681454 735393	1416847	t	33	\N
72	2	571413 439899	1011312	t	34	\N
73	2	231149 471030	702179	t	35	\N
74	2	617890 291705	909595	t	36	\N
75	2	848750 911528	1760278	t	37	\N
76	2	6815 795668	802483	t	38	\N
77	2	-155038 -832586	-987624	t	39	\N
78	2	-267948 -556857	-824805	t	40	\N
79	2	-643222 -708631	-1351853	t	41	\N
80	2	-836968 -774228	-1611196	t	42	\N
81	2	-199419 -647056	-846475	t	43	\N
82	2	-892825 -902749	-1795574	t	44	\N
83	2	-601618 -898586	-1500204	t	45	\N
84	2	-623583 -111338	-734921	t	46	\N
85	2	-639337 -366948	-1006285	t	47	\N
86	2	-722630 -153665	-876295	t	48	\N
87	2	-954439 -234821	-1189260	t	49	\N
88	2	-518259 -437725	-955984	t	50	\N
89	2	-869111 -32904	-902015	t	51	\N
90	2	-603078 -917373	-1520451	t	52	\N
91	2	-421144 -692581	-1113725	t	53	\N
92	2	-130307 -340824	-471131	t	54	\N
93	2	-351436 -71537	-422973	t	55	\N
94	2	-96435 -620799	-717234	t	56	\N
95	2	-394603 -798371	-1192974	t	57	\N
96	2	-261203 -927067	-1188270	t	58	\N
97	2	-903900 386769	-517131	t	59	\N
98	2	-522063 621241	99178	t	60	\N
99	2	-393110 -832665	-1225775	t	61	\N
100	2	793731 -511803	281928	t	62	\N
101	2	817147 -788185	28962	t	63	\N
102	2	-202818 -417048	-619866	t	64	\N
103	2	-49130 333126	283996	t	65	\N
104	2	749256 -234892	514364	t	66	\N
105	2	-658890 -223675	-882565	t	67	\N
106	2	-254944 -560632	-815576	t	68	\N
107	2	405459 -440107	-34648	t	69	\N
108	2	471823 964307	1436130	t	70	\N
109	2	433503 359028	792531	t	71	\N
110	2	-850259 277440	-572819	t	72	\N
111	2	331645 -641097	-309452	t	73	\N
112	2	120172 529089	649261	t	74	\N
113	2	-486595 -657321	-1143916	t	75	\N
114	2	-30571 -204225	-234796	t	76	\N
115	2	-433879 940685	506806	t	77	\N
116	2	342176 443180	785356	t	78	\N
117	2	608020238 -245809993	362210245	t	79	\N
118	2	-255938494 892403818	636465324	t	80	\N
119	2	-440747414 -297484583	-738231997	t	81	\N
120	2	990472440 -619004943	371467497	t	82	\N
121	2	713771909 546045484	1259817393	t	83	\N
122	2	-163407200 -294412919	-457820119	t	84	\N
123	2	809925830 612764446	1422690276	t	85	\N
124	2	974029981 636563708	1610593689	t	86	\N
125	2	245493870 -158532577	86961293	t	87	\N
126	2	-821514914 -60590821	-882105735	t	88	\N
127	2	60 -60	0	t	89	\N
128	2	74 8	82	t	90	\N
129	2	52 -84	-32	t	91	\N
130	2	-2 -3	-5	t	92	\N
131	2	52 19	71	t	93	\N
132	2	35 -36	-1	t	94	\N
133	2	41 -98	-57	t	95	\N
134	2	74 84	158	t	96	\N
135	2	-71 74	3	t	97	\N
136	2	37 92	129	t	98	\N
137	2	-32 96	64	t	99	\N
138	2	64 -13	51	t	100	\N
341	14	2 6\n3 3	0 1	f	3	791868f9-79b2-43bf-a8f8-e59e7ff9ccc1
342	14	5 10\n1 3 5 7 9	1 3	t	4	97d8ccb1-b8c9-4fb9-9ac3-d72c3c7697e6
343	14	6 15\n2 3 5 8 10 12	2 4	t	5	6a259451-f199-43c6-986c-c8c6c7a586d5
344	14	6 22\n1 5 8 10 12 15	3 4	t	6	79f6afae-b03b-4b31-82ac-63c23ddd27ec
345	14	7 100\n5 10 15 20 25 30 80	3 6	t	7	9e4e17e5-d956-44a2-8cc3-c5908fd96c48
346	14	2 -2\n-1 -1	0 1	t	8	5fdc5a9f-8d06-43b8-aba6-0258c7316ddd
347	14	8 0\n-5 -3 -1 0 1 3 5 8	0 6	t	9	fac217f1-7eb5-4705-a408-e3306480ff24
348	14	10 50\n5 10 15 20 25 30 35 40 45 50	1 7	t	10	c01ff4c6-d736-485d-9d78-288acbf20652
349	15	121	true	f	1	318e38aa-cc2f-4f9d-87aa-bb5285670555
350	15	-121	false	f	2	3d205fb1-7177-4262-bbbe-b9d12cb4a0ef
351	15	10	false	f	3	35476dda-2a27-4d6d-96fe-6b430e8bf0ea
352	15	0	true	t	4	6050c1e2-60ba-4212-a625-f4215a6bb49e
353	15	12321	true	t	5	2d917892-dd54-4f59-84d7-5b76174d87aa
354	15	1234321	true	t	6	32f70d5f-3115-4546-a543-031e261f7c8e
355	15	12345	false	t	7	98d2a083-2c7a-436a-975e-87f05eb53047
356	15	2222	true	t	8	aba827b4-871a-46ac-8a43-ea12ca27615d
357	15	9	true	t	9	cdd46f94-880d-4204-88a3-b4e9ff5d1b50
358	15	1000000001	true	t	10	6fd9f3ed-552b-4ea9-bcc8-96b219501a86
359	16	()	true	f	1	07950e75-2514-4ba1-9e5f-80f879054f4b
360	16	()[]{}	true	f	2	fa174eaf-3001-48b2-8e95-ebc2bf426be6
361	16	(]	false	f	3	1fac0051-4ea0-4ddb-9c53-e1149a4abf3e
362	16	([)]	false	t	4	44216d1a-ea35-4cb8-9141-e03bc0dbdc45
363	16	{[]}	true	t	5	b0e4e51c-6308-4729-af3d-2dce4dcd7de8
364	16	((((()))))	true	t	6	e0e2e8bd-4770-4d5b-a2fc-07c7095af3b3
365	16	(	false	t	7	26ce1ea6-ca61-43d1-9605-b4739b788b85
366	16	)	false	t	8	a596261d-3793-4d49-8504-d24efcf74127
367	16	[{()}]	true	t	9	cd412519-2558-412a-9327-0a8234da6276
368	16	[]	true	t	10	244053eb-0581-4f9c-8017-036f3cbc144f
369	17	3 3\n1 3 5\n2 4 6	1 2 3 4 5 6	f	1	f993d244-eaad-43b4-9fd5-2dfcc7e04321
370	17	1 1\n1\n2	1 2	f	2	c2d47458-99b2-45b0-bdb3-54ad5a2abeb0
371	17	2 2\n1 2\n3 4	1 2 3 4	f	3	f7e6348e-02ee-405c-9367-46c4c3983332
372	17	3 1\n1 2 5\n3	1 2 3 5	t	4	b45f7b03-0618-4790-8cf0-2ceeab7c0cf0
373	17	4 4\n2 4 6 8\n1 3 5 7	1 2 3 4 5 6 7 8	t	5	04e92080-7ea6-4963-9d79-018a00d0bb44
374	17	5 2\n1 5 10 15 20\n2 3	1 2 3 5 10 15 20	t	6	7ec4e976-95a2-46e8-892a-6211349e3c86
375	17	1 5\n10\n1 2 3 4 5	1 2 3 4 5 10	t	7	09c7690d-6897-4369-9ece-89ae76109226
376	17	3 3\n-5 -2 0\n-3 -1 4	-5 -3 -2 -1 0 4	t	8	fbb0ea46-8935-4d44-9c60-6a2f05e8bd44
377	17	2 3\n10 20\n5 15 25	5 10 15 20 25	t	9	cf5ea7ca-e336-43b5-93fd-0d66df7c5f06
378	17	6 6\n1 1 1 2 2 2\n1 1 1 2 2 2	1 1 1 1 1 1 2 2 2 2 2 2	t	10	451731df-3817-4646-b451-d01f69406083
241	13	-478967011 -117274218 392926386\n	-203314843\n	t	3	038e178b-dd0b-49fd-897d-86c34c687fbe
244	13	-701799749 -450140957 -279600432\n	-1431541138\n	t	6	a65e21cc-6ea5-40fa-8747-440eda53f00e
243	13	-813243190 -605031304 -541397657\n	-1959672151\n	t	5	4ee92db2-6d4d-4519-b2ae-b3f1b7dcb96b
249	13	-532281182 -2218064 322891610\n	-211607636\n	t	11	d2aac033-0af6-4030-8191-e5d2666cd482
251	13	241778344 702427817 997948512\n	1942154673\n	t	13	4bc96bb1-6ab8-4355-8c6d-85773c9a287e
379	18	4 5\n1 3 5 6	2	f	1	8b484afe-0ed7-46a1-a03d-afba1c84788e
248	13	-850856725 -22516834 675341496\n	-198032063\n	t	10	323a28fd-97ed-4477-ad38-1aea0fc54055
245	13	-752524815 -49869415 101751943\n	-700642287\n	t	7	afb7e2db-2f48-4b8d-9e6f-8c26b312a7a5
250	13	-930693700 -542814611 721830449\n	-751677862\n	t	12	3be6f807-db4c-4560-8f38-b6b50cf05fdf
246	13	-237445957 691819718 812517027\n	1266890788\n	t	8	d8459d27-46d3-4a52-9516-573b780d245e
242	13	-884737619 370854559 797525034\n	283641974\n	t	4	d0c9a422-9b5a-4d63-a046-35d2ea626d2e
247	13	-830512507 443618507 471285960\n	84391960\n	t	9	dec8976a-e5d7-41ac-b300-86b71a28e073
380	18	4 2\n1 3 5 6	1	f	2	4e7ee3bf-31f9-4dbc-8010-faa912092c52
381	18	4 7\n1 3 5 6	4	f	3	b0f9809f-6d9b-4c99-b414-a4cd2552d3e9
382	18	4 0\n1 3 5 6	0	t	4	fb1f6e49-ec7e-4a1c-96c3-b55399b9c9b2
383	18	1 0\n1	0	t	5	6c13ea21-66eb-4702-9f5e-42b8ae923ece
384	18	1 2\n1	1	t	6	565fb6d8-9a5c-4ee1-b641-87f36f00e4e1
385	18	5 3\n1 3 5 6 9	1	t	7	fc131809-e1f8-4142-9aef-eeab521f449e
386	18	6 8\n1 3 5 6 8 9	4	t	8	f83a0eb2-4584-4caa-b2e8-d85376df63d2
387	18	6 4\n1 3 5 6 8 9	2	t	9	5cd334d6-14b8-4952-ba86-1dadfe116ea7
388	18	7 10\n1 2 3 5 6 8 9	7	t	10	744d8627-474e-4688-b319-9d4c3841cc73
389	19	9\n-2 1 -3 4 -1 2 1 -5 4	6	f	1	d7e6b0d8-eea1-4b7e-b267-557cb4397ec0
390	19	1\n1	1	f	2	8419712b-67c0-4a94-852c-a9c87af11af0
391	19	5\n5 4 -1 7 8	23	f	3	7136c62a-cd0e-4162-87d9-83efa0291d30
392	19	3\n-1 -2 -3	-1	t	4	0eb4edd4-54e1-4d10-bdf1-37b2ca856034
393	19	5\n1 2 3 4 5	15	t	5	6fd98fd1-adf5-4a83-86fe-dea6d52a1a7d
394	19	6\n-2 1 -3 4 -1 21	24	t	6	8c58eef1-e4b2-4d21-a2c7-746a466359b8
395	19	7\n10 -5 10 -5 10 -5 10	25	t	7	b77a1e27-f9ea-434c-b066-86276e3d500e
396	19	4\n-10 -20 -30 5	5	t	8	fdc0e70a-f609-4156-837e-fca98288d28e
397	19	8\n1 -2 3 -4 5 -6 7 -8	7	t	9	4a4011ca-4562-40e6-842a-cb38534607ef
398	19	10\n10 -2 3 -4 5 -1 6 -8 9 -10	18	t	10	748e4604-80f8-48b0-9c61-78a937028cab
399	20	Hello World	5	f	1	159813f6-c542-4619-831b-99a6768f5280
400	20	   fly me   to   the moon  	4	f	2	8d080f6e-c458-4d3f-9630-36ebadc024bd
401	20	luffy is still joyboy	6	f	3	cb844e88-166f-4eb0-a961-cdc60e2d4b2d
402	20	a	1	t	4	7795829b-ca85-4913-8289-ac7708fb8341
403	20	a 	1	t	5	238bba84-f1ac-4a92-8015-f456893efc49
404	20	hello	5	t	6	954568f6-c332-4b3f-9171-72db27034792
405	20	   day  	3	t	7	ebe95a60-2cb9-427e-a8f8-d8259ac441a8
406	20	today is a nice day	3	t	8	7b744a1a-fe62-4882-ad70-055ad17973e4
407	20	   multiple   spaces  	6	t	9	2d1306f6-f474-4398-bb6e-3a44697627e3
408	20	veryLongWord	12	t	10	ae46738d-97e9-447d-aa7d-cf290bd48a39
409	21	3\n1 2 3	1 2 4	f	1	ffc881ba-453a-4dde-a4bf-829d11d3735d
410	21	4\n4 3 2 1	4 3 2 2	f	2	e305b79e-b774-436e-bfc8-2066c52fd0e7
411	21	1\n9	1 0	f	3	23aeb6c6-128a-402b-afe3-0a161a30e702
412	21	2\n9 9	1 0 0	t	4	a6bfe968-10f6-4f67-b670-8527836222fc
413	21	3\n1 0 0	1 0 1	t	5	d7c7ee54-01b8-4b84-a9a3-02448f77dc7e
414	21	5\n1 2 3 4 9	1 2 3 5 0	t	6	3523ac8f-76f7-474c-8b39-940e6605de1e
415	21	1\n0	1	t	7	55c5191d-0ae6-44e5-9ba5-6c0b9381586d
416	21	6\n9 9 9 9 9 9	1 0 0 0 0 0 0	t	8	f84028b3-8671-4a0d-9eb1-3d6142f78e33
417	21	8\n1 2 3 4 5 6 7 8	1 2 3 4 5 6 7 9	t	9	9cef9cf5-1e8d-482f-89fd-5d85abc644f9
418	21	4\n8 9 9 9	9 0 0 0	t	10	9fa616cb-3957-4a3f-9f27-b88a441e0e13
419	22	1	1	f	1	aa91ca5a-e136-4b38-9b54-55bd57de2cf6
420	22	2	2	f	2	801642f5-b9da-491c-9650-214accecba78
421	22	3	3	f	3	44ad39fc-150e-4a79-82c9-7684c3726e3f
422	22	4	5	t	4	ea9bc031-2c62-4849-82e8-50af2ff160d1
423	22	5	8	t	5	14a3bce3-b381-46e7-a9cc-f4116c66708a
424	22	6	13	t	6	761775ee-6b7a-48cd-ad8c-420b6ed078b8
425	22	10	89	t	7	e05d63b3-ab8f-4dd7-9d73-8f4355eb613c
426	22	15	987	t	8	9acc7e79-4018-4631-91c8-a64e1f855a62
427	22	20	10946	t	9	65f25111-0a6f-43ac-9b80-6286c26b7e61
428	22	30	1346269	t	10	7c03a347-9c29-4b6e-b5a3-76d8035ef5f8
429	23	6\n7 1 5 3 6 4	5	f	1	3958cdce-ff5b-4a6d-a662-aa64d66be1dd
430	23	5\n7 6 4 3 1	0	f	2	a44e5b14-3f63-4971-a18c-5a4943b88275
431	23	2\n1 2	1	f	3	3c1b654e-bd17-4c09-9775-c965896df159
432	23	3\n2 4 1	2	t	4	96098bb3-f0d8-46c8-9b9e-6d91a0953089
433	23	4\n3 2 6 5	4	t	5	8ac95229-793e-4453-ae20-4dc71e2ab7c0
434	23	5\n1 2 3 4 5	4	t	6	dfddd8a3-b967-4504-8471-3fd33c64d1cb
435	23	7\n1 10 2 15 3 20 4	19	t	7	877680b7-b60d-49b5-9b14-b34aa2dfe2b6
436	23	6\n10 10 10 10 10 10	0	t	8	c699f116-a517-4201-9917-870df73c8960
437	23	8\n2 1 2 1 2 1 2 10	9	t	9	7063d9e8-1788-4dea-98fa-5e7d3c84e1e5
438	23	5\n10 9 8 7 20	13	t	10	227bb3fb-8055-4f8c-8d79-742bba41a26a
439	24	A man, a plan, a canal: Panama	true	f	1	6c0ef9ad-7033-4e19-b0f6-28d752560e97
440	24	race a car	false	f	2	dbc04dc1-0ca6-427f-a9be-66eb4f19606d
441	24	 	true	f	3	a2b31ea8-9462-46b5-bc78-a7b65b3a4fa8
442	24	0P	false	t	4	ce860364-abbe-4c4e-86c4-497c54f80f5e
443	24	ab_a	true	t	5	5ae718b4-4620-46d9-a57e-663d77102114
444	24	12321	true	t	6	c5530e89-4d5c-400a-9016-4e6f7e7613ea
239	13	-645872732 255346368 664375749\n	273849385\n	f	1	e878e9c1-d46b-4792-ab84-5f5362406286
252	13	-199896942 -130878321 814470466\n	483695203\n	t	14	07d0c25b-4b37-4fe7-a02d-d47983de10ef
338	13	-797434856 -202058843 313596327\n	-685897372\n	t	100	5dd8f766-211d-405e-b976-2fbf3e147688
445	24	123421	false	t	7	546faabb-5f55-4f0c-b24d-c58d3b7509e0
446	24	Was it a car or a cat I saw?	true	t	8	512b29a7-ea3c-463f-8553-c0dbba8e6319
447	24	No 'x' in 'Nixon'	true	t	9	062b430e-ecbf-4000-8279-10018a2d2436
448	24	Just a test	false	t	10	d52e8ff5-e552-4e93-9fbe-d04f13055763
449	25	3\n2 2 1	1	f	1	44383eda-4a9e-44b6-9930-62f86e051eb2
450	25	5\n4 1 2 1 2	4	f	2	82b250d0-5361-41b7-8659-864cb79cd89a
451	25	1\n1	1	f	3	c3f5f29f-229d-49c6-b0fb-7b8f4879ac70
452	25	7\n3 5 3 2 2 1 1	5	t	4	e3603d06-598e-43a6-8957-78987f41606f
453	25	5\n-1 -1 -2 -2 -3	-3	t	5	58b82337-7631-450c-a585-eb112f198d79
454	25	9\n10 20 30 40 50 40 30 20 10	50	t	6	f768e74d-081f-4d7c-96a7-d4d6b843ba39
255	13	482881795 606833037 616637321\n	1706352153\n	t	17	9086e0d1-bd58-4692-977c-75e6e446872f
256	13	-772430065 287474278 982578820\n	497623033\n	t	18	778989dd-87dd-4f89-b305-1b1bb480bca2
254	13	-784987059 225241872 772174746\n	212429559\n	t	16	35f54886-5949-423d-afa1-f7839a529bb0
260	13	655063780 959480112 973737067\n	2588280959\n	t	22	63a03725-4c1b-4053-9f05-f1e7325db457
259	13	-677905960 494266880 763034608\n	579395528\n	t	21	c9d17f55-2874-4847-b24f-f9e6cc2a801e
261	13	-355171311 244969260 316762619\n	206560568\n	t	23	19c4ee04-6ce3-4cfd-8878-2cd0f14bcc1f
257	13	-478964202 -3690201 905204758\n	422550355\n	t	19	1854dba1-3283-4ede-b64f-2c6e3897d84a
262	13	283625208 627249878 755567292\n	1666442378\n	t	24	5c1f45a0-ae21-4e21-b5c9-8ad00c91cd41
264	13	-92946569 272540127 738189548\n	917783106\n	t	26	e5e9180e-78cd-48b9-874d-016e76326c3f
263	13	-45316317 -30826755 656260397\n	580117325\n	t	25	505e7d68-0727-4523-8168-43b1185544d0
265	13	-116844516 258280941 909057488\n	1050493913\n	t	27	9bc02257-c722-4aa3-a6e8-b56ef7dc58d1
266	13	-492183217 -248523365 143630303\n	-597076279\n	t	28	08c07304-8172-46d3-a70c-0659101f0217
268	13	-806269618 -191759542 -16324563\n	-1014353723\n	t	30	fa9f12a3-c50b-4b04-a74b-cb35051956eb
271	13	-683470783 -210285548 337392522\n	-556363809\n	t	33	e4700683-9337-4f67-bfa6-5e1613446711
267	13	-844625698 107734611 852291367\n	115400280\n	t	29	89c25ce8-ce92-4741-a284-f526ff0499f2
273	13	104706192 249315633 695669774\n	1049691599\n	t	35	4ecb8754-cae5-4ab1-ac92-26cf1c47a77f
270	13	-897572118 -588796287 478911877\n	-1007456528\n	t	32	04084b87-5671-498c-880a-dfeb58073a2b
280	13	-923284319 -325583864 -139222469\n	-1388090652\n	t	42	001c45c6-9ffa-4776-8c38-823f94db55e3
275	13	300548909 582042466 958273157\n	1840864532\n	t	37	0e0e3279-fe34-4bbe-85a7-2f421fd79080
274	13	-342671158 163804334 898581899\n	719715075\n	t	36	d4f2bafe-7a05-4863-99c2-af02f9d90491
283	13	-45003757 562469257 565085675\n	1082551175\n	t	45	b36088a7-25f3-4582-9fac-3433e260c89c
277	13	-994516475 -652855366 390789798\n	-1256582043\n	t	39	c26831b7-d139-489b-910d-d21fc82643cb
272	13	-731019844 -416636543 154165418\n	-993490969\n	t	34	4440ac38-2f8b-455a-8aa8-7a9fa4843e56
276	13	-598953805 -101389478 588167841\n	-112175442\n	t	38	5e67d783-7127-448f-bd1d-13a3b8161f2f
282	13	640174427 706959821 878531952\n	2225666200\n	t	44	caa7fed8-cdd8-4228-a29d-dfe839945216
281	13	-946745346 -525419332 -476504640\n	-1948669318\n	t	43	0b10d500-ec68-4358-918d-3daad9418bc7
279	13	-621143496 -587463001 925474542\n	-283131955\n	t	41	8696f485-69b2-4c73-8766-28dc5317ad1b
286	13	-474726669 -130987625 177329288\n	-428385006\n	t	48	eb47c3d4-0f6a-4fb7-b45b-b4b94a409df0
287	13	-376697931 -104501833 791732836\n	310533072\n	t	49	d5e1fc51-ac22-42a3-979c-e6090fef01ba
289	13	-397193750 -184170257 255761890\n	-325602117\n	t	51	9d6a6caf-a8bf-4ac1-bc76-02a5a764ecff
288	13	-858101099 -688478621 995938771\n	-550640949\n	t	50	f810ce23-3661-46f8-8790-3eb68dcf45ab
292	13	100290523 320355608 846579241\n	1267225372\n	t	54	f728d7d2-a808-45dc-af15-7fdbb40fa11d
290	13	-801100611 -727500626 772497853\n	-756103384\n	t	52	580a885f-4c59-466f-9558-9636bed43a34
291	13	-661843946 -9468754 124876865\n	-546435835\n	t	53	ad260ac3-2f92-48f5-905a-63a13c209f89
305	13	-568913764 -126319323 501907971\n	-193325116\n	t	67	04ee3346-a075-44c8-be03-b491153a5152
293	13	-856400008 39328301 174575378\n	-642496329\n	t	55	e40fb247-e8cc-4d74-a260-584acd067e91
295	13	-939355370 -282144039 427214435\n	-794284974\n	t	57	5a122c79-aab4-441c-a652-df4e9fc0a404
302	13	-97771437 133200076 558007507\n	593436146\n	t	64	46c30486-2b06-4582-b21f-6618c3058fe9
303	13	-189703074 -165355987 107951849\n	-247107212\n	t	65	2affe3c9-6f49-421d-b095-570feb63137e
306	13	-598707341 -370930817 100274971\n	-869363187\n	t	68	b547c7d3-028b-4694-b835-dc7a86307cfc
294	13	-419822339 60159245 425396394\n	65733300\n	t	56	ba414a24-9d45-4e53-a879-696ca5fcb48b
296	13	-939131658 -404575639 919996956\n	-423710341\n	t	58	50e464af-fd12-4bfb-97df-077b8f8bbf34
301	13	-508273831 80395653 625165650\n	197287472\n	t	63	5fda18ce-2215-4c26-8d7f-97c97b9d1b20
300	13	-266662298 609534996 721185281\n	1064057979\n	t	62	d4c9bb53-44c9-4a8a-b05f-e18f1b4a30f0
307	13	-75351038 -27937617 168866869\n	65578214\n	t	69	804b04e7-cd28-4af4-924a-31c86e49e10f
298	13	-108474702 24535007 941880590\n	857940895\n	t	60	a10aedde-b54d-4f76-bb12-37ee06ea99fd
308	13	-692666012 -383344074 266531380\n	-809478706\n	t	70	7b94601c-d2ed-4bb9-9f57-9effbf4d2fc4
304	13	287509495 405551260 734954492\n	1428015247\n	t	66	82ae564a-4acd-40fb-bbca-7345b7d7c190
299	13	-25922562 239884859 794672993\n	1008635290\n	t	61	65d2f585-32c5-40c2-b7af-9b351fff7c2f
309	13	-868982983 -318091364 841576905\n	-345497442\n	t	71	ac335540-68a7-4a19-b9d2-6ab65da4258c
311	13	-667794497 -414756249 716286300\n	-366264446\n	t	73	4e2ff22e-a9f2-4fa2-9cb8-3e56ef430ee2
310	13	3579547 70967496 158814976\n	233362019\n	t	72	ce808f76-7f88-432a-aa89-a44bfa69d220
314	13	-441223470 -369950817 75904456\n	-735269831\n	t	76	4990c0f9-567b-4157-84a3-d9564e16a25a
313	13	-848047212 48689983 67924400\n	-731432829\n	t	75	e1a87e3d-d947-408e-834b-7f5cfd7ab6bc
315	13	-544714449 40149066 956973511\n	452408128\n	t	77	98096330-a1dd-4810-9473-14a08eedf516
317	13	-773478399 -498079185 -365445817\n	-1637003401\n	t	79	eee11834-f3bf-4bed-bdfa-9a2c87967d0e
316	13	-924183543 150733500 153264247\n	-620185796\n	t	78	2e137a56-6480-4b3b-b188-a5eee753eadf
253	13	-973336175 -836512065 921879592\n	-887968648\n	t	15	d7010fe1-dabc-4c57-8d5f-ef9188266089
240	13	-497654651 -83362904 179990527\n	-401027028\n	f	2	491bdbf8-7018-4c74-9431-2008fd5f0fee
258	13	-474513287 181508742 838035510\n	545030965\n	t	20	645eebff-dbeb-4a72-a1b4-c2991cddbf6a
269	13	-998098427 -997099949 -152361038\n	-2147559414\n	t	31	ca236214-3b32-4485-bb6d-b30da811fa53
285	13	-750310846 -667232917 414335613\n	-1003208150\n	t	47	e8c21f35-d3b3-4a6f-b6ac-7ac1a96e9426
284	13	-613010501 -562765859 361794041\n	-813982319\n	t	46	1d6a3b58-e559-4e72-b6be-da651ca61275
278	13	-739449446 588035934 816738107\n	665324595\n	t	40	b157049f-fda3-43a6-a988-076ab7a0b5fd
297	13	-990377660 -510774300 626987070\n	-874164890\n	t	59	5bfb1ef6-6845-4495-9289-29e148c18a93
312	13	-981937824 -410882633 851328000\n	-541492457\n	t	74	c670bba8-c40f-4222-b29e-5024386332bf
323	13	-74504972 325464772 846833235\n	1097793035\n	t	85	84615c51-2459-4223-8028-7883a2c54e95
329	13	-651140687 -505050132 970137048\n	-186053771\n	t	91	2a132708-e9ee-4387-b179-664872332d4a
319	13	-971520552 -406652582 475579233\n	-902593901\n	t	81	5ce89be1-89c7-4b58-a189-496cc66930ee
321	13	-663700120 -170822633 252843539\n	-581679214\n	t	83	82f68909-62b0-44fb-855a-61122490f3cf
325	13	-48658914 777381506 914737806\n	1643460398\n	t	87	c856a0fa-e38f-4251-8165-5b8264e1a59c
326	13	-674869721 -130939793 -73942101\n	-879751615\n	t	88	51d666ed-3064-4bb2-afd5-b4ea2073c214
324	13	200408920 523733749 573183491\n	1297326160\n	t	86	f6f056a8-6125-4d53-86bd-0c69a0d6dc42
328	13	-246776249 -56596354 50225011\n	-253147592\n	t	90	ee2fac0e-fe01-4554-a6c0-687a461ac061
332	13	-782336589 -692931167 -372357306\n	-1847625062\n	t	94	f6a128e8-b9fb-4c66-930c-af783b0cef29
320	13	-472009269 -116787946 -41775741\n	-630572956\n	t	82	28bb996b-91fe-44c7-9282-9d93b3f36b18
327	13	-593465933 -198937848 -30240170\n	-822643951\n	t	89	b2568318-70ac-4694-99db-01fc0dbb2c25
322	13	-152464498 -147943501 576904312\n	276496313\n	t	84	8e86cee7-61cc-424a-b82b-aa40ab734144
333	13	-296446360 66049705 291023075\n	60626420\n	t	95	77e328cc-4880-490e-adbc-f729bdef8dd7
331	13	-395291432 210563006 832169382\n	647440956\n	t	93	eae27a42-dbb3-4857-a95a-c8abd46bf6dc
318	13	173324861 329303796 466305500\n	968934157\n	t	80	7b196d6e-f7c3-4ba5-a825-396959d86eca
330	13	-802598445 -496347389 512343688\n	-786602146\n	t	92	6cf51fa0-00fb-475a-bbd7-c72ddadb4c59
335	13	-686165019 -178168078 751692076\n	-112641021\n	t	97	2f48b4e9-1e94-474a-9b21-23053e05bcb8
334	13	-729426496 -448915477 666899539\n	-511442434\n	t	96	a4962853-8b72-4dd2-8a95-26bdadb100a3
336	13	-366086638 -210002075 -59247615\n	-635336328\n	t	98	93eb279d-0ff3-4b2a-aa08-bb64469cfe2f
337	13	-746199998 379715184 875025610\n	508540796\n	t	99	6d5ba54b-3c86-40c8-9039-cf9f862eee72
455	25	3\n99 100 99	100	t	7	a5b0ed32-2a5d-4b5d-817f-405d186e556b
456	25	7\n1 2 3 4 3 2 1	4	t	8	5071ef35-b0be-4e6d-ba30-47a5080dea50
457	25	5\n0 0 100 100 50	50	t	9	f49c23de-88ec-4009-b23b-9c55c5ff7211
458	25	11\n1 2 3 4 5 6 5 4 3 2 1	6	t	10	41168d14-ee96-4f6a-a445-8cc84ebe9e0a
459	26	0	0	f	1	0fb018f6-a01b-4071-9a34-df5ed5efb5d0
460	26	1	1	f	2	9237bd16-74f6-49bd-91ad-6dd75d44c9a0
461	26	2	1	f	3	af83a779-9478-4db2-9acb-34f59d95f0a5
462	26	3	2	t	4	e404c10f-4d2d-4076-924d-a2e3bdd97e54
463	26	4	3	t	5	013ec267-b12d-4904-9e85-ad7c678d042b
464	26	5	5	t	6	a4aa8b5d-df6a-42c7-85a8-dbf201b4e880
465	26	6	8	t	7	3d93b6ef-4adc-4fea-b0b4-61acaa93f1e5
466	26	10	55	t	8	41cfa5ea-8da8-4e4a-9360-d81f4b682d88
467	26	20	6765	t	9	a4f83473-429c-4e40-812e-7127500a06a4
468	26	30	832040	t	10	3c304580-2f2e-4cd0-a084-212286b44c7f
469	27	1	1	f	1	56fb79e7-c7fe-47b7-92cd-5fd4687ad697
470	27	3	1\n2\nFizz	f	2	3a188b39-4da7-47c0-b550-0d328f95b96e
471	27	5	1\n2\nFizz\n4\nBuzz	f	3	6fe485ee-39e5-4089-b22a-5e08e5db1fdb
472	27	2	1\n2	t	4	20011849-4a58-44b4-8a8d-b1153989b604
473	27	4	1\n2\nFizz\n4	t	5	4ef59c61-64dc-4cac-978c-c7c5845543d4
474	27	6	1\n2\nFizz\n4\nBuzz\nFizz	t	6	4f831ea0-bea4-4938-bae5-f5e5e515a8bd
475	27	10	1\n2\nFizz\n4\nBuzz\nFizz\n7\n8\nFizz\nBuzz	t	7	f9030327-93fc-45be-a2ed-8f27ae8f54df
476	27	12	1\n2\nFizz\n4\nBuzz\nFizz\n7\n8\nFizz\nBuzz\n11\nFizz	t	8	086f6c3e-be0f-4be4-bc37-148648f8f850
477	27	15	1\n2\nFizz\n4\nBuzz\nFizz\n7\n8\nFizz\nBuzz\n11\nFizz\n13\n14\nFizzBuzz	t	9	84010065-62ef-4826-8832-7feb4e794922
478	27	16	1\n2\nFizz\n4\nBuzz\nFizz\n7\n8\nFizz\nBuzz\n11\nFizz\n13\n14\nFizzBuzz\n16	t	10	87770832-4f49-4c67-9fdb-7a388325b47c
479	28	1	true	f	1	45d387c8-5c4a-46cd-9cc4-8d1348f319cf
480	28	16	true	f	2	93415ff6-dfdc-4d04-b7a5-a772e609eaaa
481	28	3	false	f	3	6c53a244-1073-4b86-b396-08bbf33b3020
482	28	4	true	t	4	afd1a172-922e-4d5d-ba9e-e1fcb32caef6
483	28	5	false	t	5	078fe66c-6120-4183-8260-c40dc27142a2
484	28	0	false	t	6	36535ace-485c-4cac-a90e-6a0cc9d6c186
485	28	-16	false	t	7	a9daa883-640e-410d-8c4c-efd6a340a5a2
486	28	1073741824	true	t	8	f8a02954-c508-4a01-bfe0-b4ec30004b6b
487	28	1073741823	false	t	9	6ffd3ec8-967b-4fde-b47c-e4627b1487f1
488	28	256	true	t	10	2b3e0d7f-64c5-4d85-8325-cae386aa9d7b
489	29	9\n1 8 6 2 5 4 8 3 7	49	f	1	86cc9d47-97a3-4574-bfc1-49e4627eae97
490	29	2\n1 1	1	f	2	a31b8c32-6296-402b-8fbb-4ade3dcb18af
491	29	4\n4 3 2 1	4	f	3	2432cbbd-cde2-4d50-9545-942ac9149a05
492	29	5\n1 2 1 2 1	4	t	4	b9477af1-ab56-4794-8a3a-07104d06f7a3
493	29	10\n1 1 1 1 1 1 1 1 1 1	9	t	5	ad7d9abd-3362-43aa-b840-c2671671e9a0
494	29	8\n10 9 8 7 6 5 4 3	16	t	6	a8b1ee3c-f62b-4c5c-9105-76241101bedb
495	29	6\n2 3 4 5 18 17	17	t	7	a6adf172-ca70-452b-8097-132c79aaa71d
496	29	5\n10 1 1 1 10	40	t	8	c7d561b6-689d-45db-bc63-124ddd9f35e0
497	29	3\n1 2 4	2	t	9	badbf752-a743-430f-bb7d-37ed470c10ec
498	29	7\n3 1 2 4 5 1 2	12	t	10	dda8ea04-8bb3-4c40-81c2-670b1095df9a
499	30	6\n-1 0 1 2 -1 -4	-1 -1 2\n-1 0 1	f	1	14698e51-2ac7-4221-aed0-30d6b885e6f0
500	30	3\n0 1 1		f	2	3d48130d-66a9-430c-aa72-45a3a6de8914
501	30	3\n0 0 0	0 0 0	f	3	80d43d89-29e2-49d9-9015-45cdca040dd7
502	30	4\n-1 0 1 0	-1 0 1	t	4	616f2911-033c-4da8-9c37-943ae4d48d57
503	30	5\n-2 0 0 2 2	-2 0 2	t	5	0a22289a-4fb5-46cd-a02e-9172f6437757
504	30	8\n-1 0 1 2 -1 -4 -2 -3	-3 1 2\n-2 0 2\n-2 1 1\n-1 -1 2\n-1 0 1	t	6	d4b69d3a-6d89-40b9-ba45-5a7ff0181aed
505	30	4\n-1 -1 0 2	-1 -1 2	t	7	8ac5ca52-1fc2-4ef9-8313-cfa5b70c9591
506	30	3\n1 2 -3	-3 1 2	t	8	4e02e5f2-c02a-45d5-9583-3776c40218a0
507	30	5\n-1 -1 -1 2 2	-1 -1 2	t	9	a9332cd4-df8f-43ac-9102-28f7d56fa102
508	30	6\n-4 -2 0 2 4 6	-4 -2 6\n-4 0 4\n-2 0 2	t	10	c537be71-32b6-4218-98dd-90a7f3018e7a
509	31	abcabcbb	3	f	1	f91c821b-028d-4f75-839a-de417572236e
510	31	bbbbb	1	f	2	0d724002-798e-4489-adc6-8aaeea02bde1
511	31	pwwkew	3	f	3	00609d55-8c5f-46f1-936b-257b70fd84e0
512	31	 	1	t	4	d9a0d9ee-f86c-4675-8a1b-a0947f96d310
513	31	au	2	t	5	3bba7a88-23ea-4b59-b32b-6a6ce3f0aa54
514	31	dvdf	3	t	6	31268689-b6b8-4102-b59d-edc07f7ea194
515	31	abcdefg	7	t	7	d6671aeb-d56b-4fba-8720-af0ab320ac12
516	31	abba	2	t	8	e0a09bda-45d5-4ceb-8c2f-ff41d02f04ab
517	31	tmmzuxt	5	t	9	e36cb7c2-7b78-457b-b630-f1d3db0850e5
518	31	a	1	t	10	de1b2513-9c12-4422-8d3b-a67c4fa58baa
519	32	3 2\n1 1 1	2	f	1	e26e385b-241d-4f27-ab43-db6313958395
520	32	3 3\n1 2 3	2	f	2	435f4469-9f73-4542-a434-49923ae84dff
521	32	5 0\n0 0 0 0 0	15	f	3	bddbaf06-1c7e-47ec-9b23-0f3d5c90de1f
522	32	4 2\n1 -1 2 -2	3	t	4	359a90a1-02e1-414e-8bf0-e7ef9b62ea00
523	32	2 0\n1 -1	1	t	5	8f8185a5-e580-4d4d-8652-210e9d4c27e9
524	32	6 5\n1 2 3 -1 4 2	4	t	6	dd467344-e1df-4b61-ac50-e8c03765f058
525	32	1 0\n0	1	t	7	4585867a-7231-4ed4-8b03-f493828f4d7d
526	32	1 5\n5	1	t	8	269cee2d-3d4b-4bc4-a49e-b481aea8ca69
527	32	3 5\n1 2 3	1	t	9	cff6288c-43c3-4c07-82bb-b525796d38a5
528	32	8 3\n1 2 1 2 1 2 1 2	7	t	10	0738403f-af03-4f1f-b078-0817fa9218fc
529	33	4\n1 2 3 1	4	f	1	4e1ef136-849b-40c7-856e-ef08e7a3f0e1
530	33	5\n2 7 9 3 1	12	f	2	aeb32440-3a3f-4930-86c0-3adfaf6ee503
531	33	1\n5	5	f	3	b3c3faad-9e57-41e4-8e6f-28a367f61992
532	33	2\n1 3	3	t	4	f429cd62-dac2-4d79-8f31-d74985632465
533	33	3\n2 1 1	3	t	5	1f77aeeb-6362-45fb-9c34-0f19a03bd43a
534	33	6\n6 3 10 8 2 12	28	t	6	06c65b52-fc14-4fa2-8d04-da08743eac4d
535	33	7\n1 2 3 4 5 6 7	16	t	7	8c473c4e-5db4-4859-a6a7-1824b20107ac
536	33	5\n10 1 1 10 1	20	t	8	1cebf139-1321-43f4-8ec5-9ed1ef81a6d6
537	33	8\n2 1 1 2 1 1 2 1	6	t	9	0d87c552-f92a-4d6f-adff-fcbf21a582fe
538	33	10\n1 2 3 4 5 6 7 8 9 10	30	t	10	b0fc029a-e54c-404f-96a9-158049bcd6df
\.


--
-- Data for Name: quiz_attempt_answers; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.quiz_attempt_answers (id, attempt_id, question_id, selected_option_id) FROM stdin;
\.


--
-- Data for Name: quiz_attempts; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.quiz_attempts (id, user_id, quiz_id, total_questions, correct_answers, score, submitted_at, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: quiz_options; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.quiz_options (id, question_id, content, is_correct, order_index) FROM stdin;
41	11	Thông dịch hoàn toàn	f	1
42	11	Biên dịch hoàn toàn	f	2
43	11	Lai (Vừa biên dịch vừa thông dịch)	t	3
44	11	Không thuộc các loại trên	f	4
45	12	public static void main(String args[])	t	1
46	12	public void main(String[] args)	f	2
47	12	static public int main(String[] args)	f	3
48	12	public static int main(String[] args)	f	4
49	13	int	f	1
50	13	boolean	f	2
51	13	String	t	3
52	13	double	f	4
53	14	1 byte	f	1
54	14	2 byte	f	2
55	14	4 byte	t	3
56	14	8 byte	f	4
57	15	==	f	1
58	15	equals()	t	2
59	15	compare()	f	3
60	15	compareTo()	f	4
61	16	implements	f	1
62	16	extends	t	2
63	16	inherits	f	3
64	16	import	f	4
65	17	false	f	1
66	17	true	f	2
67	17	null	f	3
68	17	Không có giá trị mặc định, gây lỗi biên dịch nếu không khởi tạo	t	4
69	18	Class	f	1
70	18	Object	t	2
71	18	System	f	3
72	18	String	f	4
73	19	Lớp đó không thể chứa phương thức	f	1
74	19	Lớp đó không thể bị kế thừa bởi lớp khác	t	2
75	19	Lớp đó không thể khởi tạo đối tượng	f	3
76	19	Lớp đó không thể chứa biến	f	4
77	20	Garbage Collector (GC)	t	1
78	20	Java Virtual Machine (JVM)	f	2
79	20	Java Development Kit (JDK)	f	3
80	20	Memory Allocator	f	4
\.


--
-- Data for Name: quiz_questions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.quiz_questions (id, quiz_id, question_content, order_index) FROM stdin;
11	2	Java là ngôn ngữ lập trình thuộc loại nào?	1
12	2	Chữ ký hợp lệ của hàm main trong Java là gì?	2
13	2	Kiểu dữ liệu nào dưới đây KHÔNG phải là kiểu dữ liệu nguyên thủy?	3
14	2	Kích thước của kiểu dữ liệu int trong Java là bao nhiêu byte?	4
15	2	Để so sánh hai đối tượng String trong Java, phương thức nào được sử dụng?	5
16	2	Từ khóa nào được dùng để kế thừa một lớp trong Java?	6
17	2	Giá trị mặc định của một biến boolean cục bộ trong một phương thức Java là gì?	7
18	2	Lớp cha của tất cả các lớp trong Java là lớp nào?	8
19	2	Từ khóa 'final' khi áp dụng cho một lớp có ý nghĩa gì?	9
20	2	Thành phần nào trong Java thực hiện quản lý và thu hồi bộ nhớ tự động?	10
\.


--
-- Data for Name: quizzes; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.quizzes (id, lesson_id, title, description, created_by_teacher_id, created_at, updated_at, is_deleted) FROM stdin;
2	76	Bài kiểm tra trắc nghiệm Java căn bản	Bài trắc nghiệm gồm 10 câu hỏi để đánh giá kiến thức tổng quát về ngôn ngữ lập trình Java.	2	2026-06-13 23:31:04.75857+07	2026-06-13 23:31:04.758581+07	f
\.


--
-- Data for Name: refresh_tokens; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.refresh_tokens (id, user_id, token_hash, expires_at, revoked_at, created_at, last_used_at) FROM stdin;
\.


--
-- Data for Name: role_permissions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.role_permissions (role_id, permission_id) FROM stdin;
1	69
1	60
1	58
1	75
1	71
1	66
1	67
1	57
1	55
1	65
1	61
1	74
1	62
1	56
1	53
1	64
1	77
1	76
1	78
1	54
1	63
1	73
1	72
1	68
1	70
1	59
3	60
3	69
3	58
3	75
3	71
3	66
3	67
3	57
3	55
3	65
3	61
3	74
3	62
3	56
3	53
3	64
3	77
3	76
3	78
3	54
3	63
3	72
3	73
3	68
3	70
3	59
2	72
2	73
2	64
2	61
2	68
2	77
2	76
2	62
2	78
2	63
1	79
\.


--
-- Data for Name: roles; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.roles (id, name) FROM stdin;
1	ADMIN
2	USER
3	TEACHER
\.


--
-- Data for Name: teacher_course_assignments; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.teacher_course_assignments (id, teacher_id, course_id, assigned_by_admin_id, assigned_at) FROM stdin;
6	2	6	1	2026-06-13 23:31:04.631114+07
7	2	7	1	2026-06-13 23:31:04.667684+07
8	2	8	1	2026-06-13 23:31:04.690178+07
9	2	9	1	2026-06-13 23:31:04.714124+07
10	2	10	1	2026-06-13 23:31:04.733624+07
\.


--
-- Data for Name: teachers; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.teachers (id, user_id, status, created_at, updated_at, full_name, headline, bio) FROM stdin;
2	4	ACTIVE	2026-06-13 23:31:04.505079+07	2026-06-13 23:31:04.505079+07	Mr. Mock Teacher	\N	\N
3	1	ACTIVE	2026-06-21 03:16:42.257838+07	2026-06-21 03:16:42.257838+07	Admin Teacher	\N	\N
\.


--
-- Data for Name: user_roles; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_roles (user_id, role_id) FROM stdin;
1	1
4	3
5	2
10	2
11	2
12	2
13	2
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.users (id, username, email, password_hash, display_name, phone_number, status, created_at, updated_at) FROM stdin;
1	admin	admin@gmail.com	$2a$10$qlK6Qh5kgbUU/cOgtIqQYuIrW.lqxG9h.7lo8bKg1OR3j2ZcA3m4i	admin	9999999999	ACTIVE	2026-06-13 23:21:51.561227+07	2026-06-13 23:21:51.561227+07
5	user1	user@gmail.com	$2a$10$Ob/izhreQPv3TqadjzjCjeh8xtNHpRugmYbIHGbzYLszi9dIX5acS	Mock Student	0987654321	ACTIVE	2026-06-13 23:31:04.606918+07	2026-06-14 00:12:38.342336+07
4	teacher	teacher@gmail.com	$2a$10$GTTT4eHhA1K7JQDaNUnCtOqa49USDKAiOtHMK/RWTn.tt5XTGi4V6	Mr. Mock Teacher	0912345678	ACTIVE	2026-06-13 23:31:04.487543+07	2026-06-14 00:13:02.603374+07
10	user2	user2@gmailcom	$2a$10$C29CqCYLp.q6RLuRIL/tCOG28xQC8tFLHzOsRPSYDdQKI9CHSmUiq	user2	0666666666	ACTIVE	2026-06-16 19:18:44.513738+07	2026-06-16 19:18:44.513738+07
11	user3	user3@gmail.com	$2a$10$ef12DaFMwE6rfHXPp4nZXuatTzf2tQ/.nacH2Cs5nzvVQGcG4XUHW	Võ Ngọc Thanh	0763769325	ACTIVE	2026-06-17 02:14:28.531746+07	2026-06-17 02:14:28.531746+07
12	testuser	test@example.com	$2a$10$9cl7BDh7CdsWxqmRc94z6.YbfcSHjosPxJnEz99AnUHmbj3zCkKTO	Test User	\N	ACTIVE	2026-06-20 15:28:16.61493+07	2026-06-20 15:28:16.61493+07
13	testuser_sub	testuser_sub@example.com	$2a$10$oiuZHGt81Ie90SF42e1o.OVCG7IKstxdJw4njh9QmHxwi3nGN/tL2	Test User	\N	ACTIVE	2026-06-21 01:06:27.267208+07	2026-06-21 01:06:27.267208+07
\.


--
-- Data for Name: wallet_transactions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.wallet_transactions (id, wallet_id, amount, type, status, reference_id, note, created_at, updated_at, order_id) FROM stdin;
1	4	50000.00	DEPOSIT	SUCCESS	1	Nạp tiền thật qua PayOS	2026-06-16 22:57:29.153704+07	2026-06-16 22:57:29.153707+07	\N
2	4	50000.00	DEPOSIT	SUCCESS	6	Nạp tiền thật qua PayOS	2026-06-21 01:32:00.825907+07	2026-06-21 01:32:00.825917+07	\N
3	4	100000.00	DEPOSIT	SUCCESS	8	Nạp tiền thật qua PayOS	2026-06-21 16:58:58.446314+07	2026-06-21 16:58:58.446327+07	\N
4	4	50000.00	DEPOSIT	SUCCESS	9	Nạp tiền thật qua PayOS	2026-06-21 16:59:27.921231+07	2026-06-21 16:59:27.921238+07	\N
5	4	-249000.00	PURCHASE	SUCCESS	\N	Purchased 1 courses	2026-06-21 16:59:50.03106+07	2026-06-21 16:59:50.031069+07	1
\.


--
-- Data for Name: wallets; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.wallets (id, user_id, balance, status, created_at, updated_at) FROM stdin;
3	4	0.00	ACTIVE	2026-06-13 23:31:04.511685+07	2026-06-13 23:31:04.511699+07
5	10	0.00	ACTIVE	2026-06-16 19:18:44.598278+07	2026-06-16 19:18:44.598292+07
6	11	0.00	ACTIVE	2026-06-17 02:14:28.622332+07	2026-06-17 02:14:28.62234+07
7	12	0.00	ACTIVE	2026-06-20 15:28:16.728029+07	2026-06-20 15:28:16.728044+07
8	13	0.00	ACTIVE	2026-06-21 01:06:27.360096+07	2026-06-21 01:06:27.360103+07
4	5	1000.00	ACTIVE	2026-06-13 23:31:04.608568+07	2026-06-21 16:59:50.011381+07
\.


--
-- Name: cart_items_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.cart_items_id_seq', 5, true);


--
-- Name: carts_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.carts_id_seq', 5, true);


--
-- Name: categories_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.categories_id_seq', 10, true);


--
-- Name: chapters_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.chapters_id_seq', 50, true);


--
-- Name: completed_lessons_count_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.completed_lessons_count_id_seq', 3, true);


--
-- Name: contest_participants_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.contest_participants_id_seq', 16, true);


--
-- Name: contest_problem_attempts_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.contest_problem_attempts_id_seq', 30, true);


--
-- Name: contest_problems_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.contest_problems_id_seq', 30, true);


--
-- Name: contest_rankings_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.contest_rankings_id_seq', 14, true);


--
-- Name: contests_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.contests_id_seq', 21, true);


--
-- Name: course_reviews_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.course_reviews_id_seq', 1, false);


--
-- Name: courses_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.courses_id_seq', 10, true);


--
-- Name: enrollments_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.enrollments_id_seq', 4, true);


--
-- Name: invalidated_tokens_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.invalidated_tokens_id_seq', 75, true);


--
-- Name: lesson_comments_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.lesson_comments_id_seq', 8, true);


--
-- Name: lesson_problems_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.lesson_problems_id_seq', 4, true);


--
-- Name: lesson_progress_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.lesson_progress_id_seq', 26, true);


--
-- Name: lessons_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.lessons_id_seq', 150, true);


--
-- Name: online_judge_problems_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.online_judge_problems_id_seq', 33, true);


--
-- Name: online_judge_submission_details_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.online_judge_submission_details_id_seq', 9708, true);


--
-- Name: online_judge_submissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.online_judge_submissions_id_seq', 474, true);


--
-- Name: order_items_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.order_items_id_seq', 1, true);


--
-- Name: orders_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.orders_id_seq', 1, true);


--
-- Name: payment_transactions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.payment_transactions_id_seq', 9, true);


--
-- Name: permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.permissions_id_seq', 79, true);


--
-- Name: problem_tag_mappings_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.problem_tag_mappings_id_seq', 52, true);


--
-- Name: problem_tags_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.problem_tags_id_seq', 17, true);


--
-- Name: problem_testcases_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.problem_testcases_id_seq', 538, true);


--
-- Name: quiz_attempt_answers_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.quiz_attempt_answers_id_seq', 1, false);


--
-- Name: quiz_attempts_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.quiz_attempts_id_seq', 1, false);


--
-- Name: quiz_options_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.quiz_options_id_seq', 80, true);


--
-- Name: quiz_questions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.quiz_questions_id_seq', 20, true);


--
-- Name: quizzes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.quizzes_id_seq', 2, true);


--
-- Name: refresh_tokens_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.refresh_tokens_id_seq', 1, false);


--
-- Name: roles_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.roles_id_seq', 3, true);


--
-- Name: teacher_course_assignments_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.teacher_course_assignments_id_seq', 10, true);


--
-- Name: teachers_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.teachers_id_seq', 3, true);


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.users_id_seq', 13, true);


--
-- Name: wallet_transactions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.wallet_transactions_id_seq', 5, true);


--
-- Name: wallets_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.wallets_id_seq', 8, true);


--
-- Name: cart_items cart_items_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cart_items
    ADD CONSTRAINT cart_items_pkey PRIMARY KEY (id);


--
-- Name: carts carts_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.carts
    ADD CONSTRAINT carts_pkey PRIMARY KEY (id);


--
-- Name: categories categories_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.categories
    ADD CONSTRAINT categories_name_key UNIQUE (name);


--
-- Name: categories categories_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.categories
    ADD CONSTRAINT categories_pkey PRIMARY KEY (id);


--
-- Name: categories categories_slug_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.categories
    ADD CONSTRAINT categories_slug_key UNIQUE (slug);


--
-- Name: chapters chapters_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.chapters
    ADD CONSTRAINT chapters_pkey PRIMARY KEY (id);


--
-- Name: completed_lessons_count completed_lessons_count_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.completed_lessons_count
    ADD CONSTRAINT completed_lessons_count_pkey PRIMARY KEY (id);


--
-- Name: contest_participants contest_participants_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.contest_participants
    ADD CONSTRAINT contest_participants_pkey PRIMARY KEY (id);


--
-- Name: contest_problem_attempts contest_problem_attempts_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.contest_problem_attempts
    ADD CONSTRAINT contest_problem_attempts_pkey PRIMARY KEY (id);


--
-- Name: contest_problems contest_problems_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.contest_problems
    ADD CONSTRAINT contest_problems_pkey PRIMARY KEY (id);


--
-- Name: contest_rankings contest_rankings_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.contest_rankings
    ADD CONSTRAINT contest_rankings_pkey PRIMARY KEY (id);


--
-- Name: contests contests_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.contests
    ADD CONSTRAINT contests_pkey PRIMARY KEY (id);


--
-- Name: course_category_mappings course_category_mappings_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.course_category_mappings
    ADD CONSTRAINT course_category_mappings_pkey PRIMARY KEY (course_id, category_id);


--
-- Name: course_reviews course_reviews_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.course_reviews
    ADD CONSTRAINT course_reviews_pkey PRIMARY KEY (id);


--
-- Name: courses courses_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.courses
    ADD CONSTRAINT courses_pkey PRIMARY KEY (id);


--
-- Name: enrollments enrollments_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.enrollments
    ADD CONSTRAINT enrollments_pkey PRIMARY KEY (id);


--
-- Name: invalidated_tokens invalidated_tokens_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.invalidated_tokens
    ADD CONSTRAINT invalidated_tokens_pkey PRIMARY KEY (id);


--
-- Name: invalidated_tokens invalidated_tokens_token_jti_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.invalidated_tokens
    ADD CONSTRAINT invalidated_tokens_token_jti_key UNIQUE (token_jti);


--
-- Name: lesson_comments lesson_comments_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.lesson_comments
    ADD CONSTRAINT lesson_comments_pkey PRIMARY KEY (id);


--
-- Name: lesson_problems lesson_problems_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.lesson_problems
    ADD CONSTRAINT lesson_problems_pkey PRIMARY KEY (id);


--
-- Name: lesson_progress lesson_progress_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.lesson_progress
    ADD CONSTRAINT lesson_progress_pkey PRIMARY KEY (id);


--
-- Name: lessons lessons_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.lessons
    ADD CONSTRAINT lessons_pkey PRIMARY KEY (id);


--
-- Name: online_judge_problems online_judge_problems_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.online_judge_problems
    ADD CONSTRAINT online_judge_problems_pkey PRIMARY KEY (id);


--
-- Name: online_judge_submission_details online_judge_submission_details_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.online_judge_submission_details
    ADD CONSTRAINT online_judge_submission_details_pkey PRIMARY KEY (id);


--
-- Name: online_judge_submissions online_judge_submissions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.online_judge_submissions
    ADD CONSTRAINT online_judge_submissions_pkey PRIMARY KEY (id);


--
-- Name: order_items order_items_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_items
    ADD CONSTRAINT order_items_pkey PRIMARY KEY (id);


--
-- Name: orders orders_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_pkey PRIMARY KEY (id);


--
-- Name: payment_transactions payment_transactions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.payment_transactions
    ADD CONSTRAINT payment_transactions_pkey PRIMARY KEY (id);


--
-- Name: payment_transactions payment_transactions_transaction_code_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.payment_transactions
    ADD CONSTRAINT payment_transactions_transaction_code_key UNIQUE (transaction_code);


--
-- Name: permissions permissions_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.permissions
    ADD CONSTRAINT permissions_name_key UNIQUE (name);


--
-- Name: permissions permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.permissions
    ADD CONSTRAINT permissions_pkey PRIMARY KEY (id);


--
-- Name: problem_tag_mappings problem_tag_mappings_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.problem_tag_mappings
    ADD CONSTRAINT problem_tag_mappings_pkey PRIMARY KEY (id);


--
-- Name: problem_tags problem_tags_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.problem_tags
    ADD CONSTRAINT problem_tags_pkey PRIMARY KEY (id);


--
-- Name: problem_tags problem_tags_slug_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.problem_tags
    ADD CONSTRAINT problem_tags_slug_key UNIQUE (slug);


--
-- Name: problem_testcases problem_testcases_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.problem_testcases
    ADD CONSTRAINT problem_testcases_pkey PRIMARY KEY (id);


--
-- Name: problem_testcases problem_testcases_token_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.problem_testcases
    ADD CONSTRAINT problem_testcases_token_key UNIQUE (token);


--
-- Name: quiz_attempt_answers quiz_attempt_answers_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.quiz_attempt_answers
    ADD CONSTRAINT quiz_attempt_answers_pkey PRIMARY KEY (id);


--
-- Name: quiz_attempts quiz_attempts_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.quiz_attempts
    ADD CONSTRAINT quiz_attempts_pkey PRIMARY KEY (id);


--
-- Name: quiz_options quiz_options_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.quiz_options
    ADD CONSTRAINT quiz_options_pkey PRIMARY KEY (id);


--
-- Name: quiz_questions quiz_questions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.quiz_questions
    ADD CONSTRAINT quiz_questions_pkey PRIMARY KEY (id);


--
-- Name: quizzes quizzes_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.quizzes
    ADD CONSTRAINT quizzes_pkey PRIMARY KEY (id);


--
-- Name: refresh_tokens refresh_tokens_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.refresh_tokens
    ADD CONSTRAINT refresh_tokens_pkey PRIMARY KEY (id);


--
-- Name: refresh_tokens refresh_tokens_token_hash_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.refresh_tokens
    ADD CONSTRAINT refresh_tokens_token_hash_key UNIQUE (token_hash);


--
-- Name: role_permissions role_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.role_permissions
    ADD CONSTRAINT role_permissions_pkey PRIMARY KEY (role_id, permission_id);


--
-- Name: roles roles_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.roles
    ADD CONSTRAINT roles_name_key UNIQUE (name);


--
-- Name: roles roles_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.roles
    ADD CONSTRAINT roles_pkey PRIMARY KEY (id);


--
-- Name: teacher_course_assignments teacher_course_assignments_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.teacher_course_assignments
    ADD CONSTRAINT teacher_course_assignments_pkey PRIMARY KEY (id);


--
-- Name: teachers teachers_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.teachers
    ADD CONSTRAINT teachers_pkey PRIMARY KEY (id);


--
-- Name: teachers teachers_user_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.teachers
    ADD CONSTRAINT teachers_user_id_key UNIQUE (user_id);


--
-- Name: lesson_problems uk9iby3fg6g42d6i8bflvlaxkm1; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.lesson_problems
    ADD CONSTRAINT uk9iby3fg6g42d6i8bflvlaxkm1 UNIQUE (lesson_id, problem_id);


--
-- Name: cart_items uks9a8ke6fclgt3xcucg98psj7n; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cart_items
    ADD CONSTRAINT uks9a8ke6fclgt3xcucg98psj7n UNIQUE (cart_id, course_id);


--
-- Name: quiz_attempt_answers unique_attempt_question; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.quiz_attempt_answers
    ADD CONSTRAINT unique_attempt_question UNIQUE (attempt_id, question_id);


--
-- Name: cart_items uq_cart_items_cart_course; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cart_items
    ADD CONSTRAINT uq_cart_items_cart_course UNIQUE (cart_id, course_id);


--
-- Name: carts uq_carts_user; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.carts
    ADD CONSTRAINT uq_carts_user UNIQUE (user_id);


--
-- Name: chapters uq_chapters_course_order; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.chapters
    ADD CONSTRAINT uq_chapters_course_order UNIQUE (course_id, order_index);


--
-- Name: completed_lessons_count uq_completed_lessons_count_user_course; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.completed_lessons_count
    ADD CONSTRAINT uq_completed_lessons_count_user_course UNIQUE (user_id, course_id);


--
-- Name: contest_participants uq_contest_participants_contest_user; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.contest_participants
    ADD CONSTRAINT uq_contest_participants_contest_user UNIQUE (contest_id, user_id);


--
-- Name: contest_problem_attempts uq_contest_problem_attempts; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.contest_problem_attempts
    ADD CONSTRAINT uq_contest_problem_attempts UNIQUE (contest_id, user_id, problem_id);


--
-- Name: contest_problems uq_contest_problems_contest_order; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.contest_problems
    ADD CONSTRAINT uq_contest_problems_contest_order UNIQUE (contest_id, order_index);


--
-- Name: contest_problems uq_contest_problems_contest_problem; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.contest_problems
    ADD CONSTRAINT uq_contest_problems_contest_problem UNIQUE (contest_id, problem_id);


--
-- Name: contest_rankings uq_contest_rankings_contest_user; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.contest_rankings
    ADD CONSTRAINT uq_contest_rankings_contest_user UNIQUE (contest_id, user_id);


--
-- Name: course_reviews uq_course_reviews_course_user; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.course_reviews
    ADD CONSTRAINT uq_course_reviews_course_user UNIQUE (course_id, user_id);


--
-- Name: enrollments uq_enrollments_user_course; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.enrollments
    ADD CONSTRAINT uq_enrollments_user_course UNIQUE (user_id, course_id);


--
-- Name: lesson_problems uq_lesson_problem; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.lesson_problems
    ADD CONSTRAINT uq_lesson_problem UNIQUE (lesson_id, problem_id);


--
-- Name: lesson_progress uq_lesson_progress_user_lesson; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.lesson_progress
    ADD CONSTRAINT uq_lesson_progress_user_lesson UNIQUE (user_id, lesson_id);


--
-- Name: lessons uq_lessons_chapter_order; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.lessons
    ADD CONSTRAINT uq_lessons_chapter_order UNIQUE (chapter_id, order_index);


--
-- Name: problem_tag_mappings uq_problem_tag_mappings_problem_tag; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.problem_tag_mappings
    ADD CONSTRAINT uq_problem_tag_mappings_problem_tag UNIQUE (problem_id, tag_id);


--
-- Name: problem_testcases uq_problem_testcases_problem_order; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.problem_testcases
    ADD CONSTRAINT uq_problem_testcases_problem_order UNIQUE (problem_id, order_index);


--
-- Name: quiz_questions uq_quiz_questions_quiz_order; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.quiz_questions
    ADD CONSTRAINT uq_quiz_questions_quiz_order UNIQUE (quiz_id, order_index) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: teacher_course_assignments uq_teacher_course_assignments_teacher_course; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.teacher_course_assignments
    ADD CONSTRAINT uq_teacher_course_assignments_teacher_course UNIQUE (teacher_id, course_id);


--
-- Name: user_roles user_roles_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_roles
    ADD CONSTRAINT user_roles_pkey PRIMARY KEY (user_id, role_id);


--
-- Name: users users_email_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key UNIQUE (email);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: users users_username_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_username_key UNIQUE (username);


--
-- Name: wallet_transactions wallet_transactions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.wallet_transactions
    ADD CONSTRAINT wallet_transactions_pkey PRIMARY KEY (id);


--
-- Name: wallets wallets_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.wallets
    ADD CONSTRAINT wallets_pkey PRIMARY KEY (id);


--
-- Name: wallets wallets_user_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.wallets
    ADD CONSTRAINT wallets_user_id_key UNIQUE (user_id);


--
-- Name: idx_chapters_course_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_chapters_course_id ON public.chapters USING btree (course_id);


--
-- Name: idx_contest_participants_user_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_contest_participants_user_id ON public.contest_participants USING btree (user_id);


--
-- Name: idx_contest_problem_attempts_lookup; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_contest_problem_attempts_lookup ON public.contest_problem_attempts USING btree (contest_id, user_id);


--
-- Name: idx_contest_problems_problem_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_contest_problems_problem_id ON public.contest_problems USING btree (problem_id);


--
-- Name: idx_contest_rankings_contest; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_contest_rankings_contest ON public.contest_rankings USING btree (contest_id);


--
-- Name: idx_contests_created_by_teacher_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_contests_created_by_teacher_id ON public.contests USING btree (created_by_teacher_id);


--
-- Name: idx_contests_status_time; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_contests_status_time ON public.contests USING btree (status, start_time, end_time);


--
-- Name: idx_course_category_mapping_category_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_course_category_mapping_category_id ON public.course_category_mappings USING btree (category_id);


--
-- Name: idx_course_reviews_user_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_course_reviews_user_id ON public.course_reviews USING btree (user_id);


--
-- Name: idx_courses_average_rating; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_courses_average_rating ON public.courses USING btree (average_rating DESC);


--
-- Name: idx_courses_status; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_courses_status ON public.courses USING btree (status);


--
-- Name: idx_courses_total_enrolled; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_courses_total_enrolled ON public.courses USING btree (total_enrolled DESC);


--
-- Name: idx_enrollments_course_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_enrollments_course_id ON public.enrollments USING btree (course_id);


--
-- Name: idx_invalidated_tokens_expiry_time; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_invalidated_tokens_expiry_time ON public.invalidated_tokens USING btree (expiry_time);


--
-- Name: idx_lesson_comments_lesson_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_lesson_comments_lesson_id ON public.lesson_comments USING btree (lesson_id);


--
-- Name: idx_lesson_comments_lesson_parent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_lesson_comments_lesson_parent ON public.lesson_comments USING btree (lesson_id, parent_comment_id);


--
-- Name: idx_lesson_comments_parent_comment_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_lesson_comments_parent_comment_id ON public.lesson_comments USING btree (parent_comment_id);


--
-- Name: idx_lesson_progress_course_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_lesson_progress_course_id ON public.lesson_progress USING btree (course_id);


--
-- Name: idx_lesson_progress_user_course; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_lesson_progress_user_course ON public.lesson_progress USING btree (user_id, course_id);


--
-- Name: idx_lessons_chapter_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_lessons_chapter_id ON public.lessons USING btree (chapter_id);


--
-- Name: idx_online_judge_problems_created_by_teacher_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_online_judge_problems_created_by_teacher_id ON public.online_judge_problems USING btree (created_by_teacher_id);


--
-- Name: idx_online_judge_problems_scope_difficulty; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_online_judge_problems_scope_difficulty ON public.online_judge_problems USING btree (problem_scope, difficulty);


--
-- Name: idx_online_judge_submissions_contest_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_online_judge_submissions_contest_id ON public.online_judge_submissions USING btree (contest_id);


--
-- Name: idx_online_judge_submissions_contest_user_problem; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_online_judge_submissions_contest_user_problem ON public.online_judge_submissions USING btree (contest_id, user_id, problem_id);


--
-- Name: idx_online_judge_submissions_lesson_user_problem; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_online_judge_submissions_lesson_user_problem ON public.online_judge_submissions USING btree (lesson_id, user_id, problem_id);


--
-- Name: idx_online_judge_submissions_problem_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_online_judge_submissions_problem_id ON public.online_judge_submissions USING btree (problem_id);


--
-- Name: idx_online_judge_submissions_submitted_at; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_online_judge_submissions_submitted_at ON public.online_judge_submissions USING btree (submitted_at);


--
-- Name: idx_online_judge_submissions_user_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_online_judge_submissions_user_id ON public.online_judge_submissions USING btree (user_id);


--
-- Name: idx_order_items_course_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_order_items_course_id ON public.order_items USING btree (course_id);


--
-- Name: idx_order_items_order_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_order_items_order_id ON public.order_items USING btree (order_id);


--
-- Name: idx_orders_status; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_orders_status ON public.orders USING btree (status);


--
-- Name: idx_orders_user_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_orders_user_id ON public.orders USING btree (user_id);


--
-- Name: idx_payment_tx_code; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_payment_tx_code ON public.payment_transactions USING btree (transaction_code);


--
-- Name: idx_payment_tx_wallet_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_payment_tx_wallet_id ON public.payment_transactions USING btree (wallet_id);


--
-- Name: idx_problem_tag_mappings_tag_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_problem_tag_mappings_tag_id ON public.problem_tag_mappings USING btree (tag_id);


--
-- Name: idx_problem_testcases_problem_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_problem_testcases_problem_id ON public.problem_testcases USING btree (problem_id);


--
-- Name: idx_quiz_attempts_quiz_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_quiz_attempts_quiz_id ON public.quiz_attempts USING btree (quiz_id);


--
-- Name: idx_quiz_attempts_user_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_quiz_attempts_user_id ON public.quiz_attempts USING btree (user_id);


--
-- Name: idx_quiz_options_question_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_quiz_options_question_id ON public.quiz_options USING btree (question_id);


--
-- Name: idx_quiz_questions_quiz_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_quiz_questions_quiz_id ON public.quiz_questions USING btree (quiz_id);


--
-- Name: idx_refresh_tokens_expires_at; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_refresh_tokens_expires_at ON public.refresh_tokens USING btree (expires_at);


--
-- Name: idx_refresh_tokens_user_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_refresh_tokens_user_id ON public.refresh_tokens USING btree (user_id);


--
-- Name: idx_submission_details_submission_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_submission_details_submission_id ON public.online_judge_submission_details USING btree (submission_id);


--
-- Name: idx_submission_user_verdict; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_submission_user_verdict ON public.online_judge_submissions USING btree (user_id, verdict, problem_id);


--
-- Name: idx_teacher_course_assignments_assigned_by_admin_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_teacher_course_assignments_assigned_by_admin_id ON public.teacher_course_assignments USING btree (assigned_by_admin_id);


--
-- Name: idx_teacher_course_assignments_course_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_teacher_course_assignments_course_id ON public.teacher_course_assignments USING btree (course_id);


--
-- Name: idx_wallet_transactions_order_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_wallet_transactions_order_id ON public.wallet_transactions USING btree (order_id);


--
-- Name: idx_wallet_tx_wallet_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_wallet_tx_wallet_id ON public.wallet_transactions USING btree (wallet_id);


--
-- Name: uq_quizzes_lesson_active; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX uq_quizzes_lesson_active ON public.quizzes USING btree (lesson_id) WHERE (is_deleted = false);


--
-- Name: uq_submission_details_token; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX uq_submission_details_token ON public.online_judge_submission_details USING btree (token);


--
-- Name: orders set_orders_updated_at; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER set_orders_updated_at BEFORE UPDATE ON public.orders FOR EACH ROW EXECUTE FUNCTION public.set_updated_at();


--
-- Name: categories trg_categories_set_updated_at; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER trg_categories_set_updated_at BEFORE UPDATE ON public.categories FOR EACH ROW EXECUTE FUNCTION public.set_updated_at();


--
-- Name: chapters trg_chapters_updated_at; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER trg_chapters_updated_at BEFORE UPDATE ON public.chapters FOR EACH ROW EXECUTE FUNCTION public.set_updated_at();


--
-- Name: completed_lessons_count trg_completed_lessons_count_set_updated_at; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER trg_completed_lessons_count_set_updated_at BEFORE UPDATE ON public.completed_lessons_count FOR EACH ROW EXECUTE FUNCTION public.set_updated_at();


--
-- Name: contests trg_contests_set_updated_at; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER trg_contests_set_updated_at BEFORE UPDATE ON public.contests FOR EACH ROW EXECUTE FUNCTION public.set_updated_at();


--
-- Name: course_reviews trg_course_reviews_set_updated_at; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER trg_course_reviews_set_updated_at BEFORE UPDATE ON public.course_reviews FOR EACH ROW EXECUTE FUNCTION public.set_updated_at();


--
-- Name: courses trg_courses_set_updated_at; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER trg_courses_set_updated_at BEFORE UPDATE ON public.courses FOR EACH ROW EXECUTE FUNCTION public.set_updated_at();


--
-- Name: lesson_comments trg_lesson_comments_set_updated_at; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER trg_lesson_comments_set_updated_at BEFORE UPDATE ON public.lesson_comments FOR EACH ROW EXECUTE FUNCTION public.set_updated_at();


--
-- Name: lessons trg_lessons_set_updated_at; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER trg_lessons_set_updated_at BEFORE UPDATE ON public.lessons FOR EACH ROW EXECUTE FUNCTION public.set_updated_at();


--
-- Name: online_judge_problems trg_online_judge_problems_set_updated_at; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER trg_online_judge_problems_set_updated_at BEFORE UPDATE ON public.online_judge_problems FOR EACH ROW EXECUTE FUNCTION public.set_updated_at();


--
-- Name: payment_transactions trg_payment_tx_set_updated_at; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER trg_payment_tx_set_updated_at BEFORE UPDATE ON public.payment_transactions FOR EACH ROW EXECUTE FUNCTION public.set_updated_at();


--
-- Name: problem_tags trg_problem_tags_set_updated_at; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER trg_problem_tags_set_updated_at BEFORE UPDATE ON public.problem_tags FOR EACH ROW EXECUTE FUNCTION public.set_updated_at();


--
-- Name: quizzes trg_quizzes_set_updated_at; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER trg_quizzes_set_updated_at BEFORE UPDATE ON public.quizzes FOR EACH ROW EXECUTE FUNCTION public.set_updated_at();


--
-- Name: teachers trg_teachers_set_updated_at; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER trg_teachers_set_updated_at BEFORE UPDATE ON public.teachers FOR EACH ROW EXECUTE FUNCTION public.set_updated_at();


--
-- Name: users trg_users_set_updated_at; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER trg_users_set_updated_at BEFORE UPDATE ON public.users FOR EACH ROW EXECUTE FUNCTION public.set_updated_at();


--
-- Name: wallet_transactions trg_wallet_tx_set_updated_at; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER trg_wallet_tx_set_updated_at BEFORE UPDATE ON public.wallet_transactions FOR EACH ROW EXECUTE FUNCTION public.set_updated_at();


--
-- Name: wallets trg_wallets_set_updated_at; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER trg_wallets_set_updated_at BEFORE UPDATE ON public.wallets FOR EACH ROW EXECUTE FUNCTION public.set_updated_at();


--
-- Name: quiz_attempts trigger_quiz_attempts_updated_at; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER trigger_quiz_attempts_updated_at BEFORE UPDATE ON public.quiz_attempts FOR EACH ROW EXECUTE FUNCTION public.set_updated_at();


--
-- Name: cart_items fk_cart_items_cart; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cart_items
    ADD CONSTRAINT fk_cart_items_cart FOREIGN KEY (cart_id) REFERENCES public.carts(id) ON DELETE CASCADE;


--
-- Name: cart_items fk_cart_items_course; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cart_items
    ADD CONSTRAINT fk_cart_items_course FOREIGN KEY (course_id) REFERENCES public.courses(id) ON DELETE CASCADE;


--
-- Name: carts fk_carts_user; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.carts
    ADD CONSTRAINT fk_carts_user FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: chapters fk_chapters_course; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.chapters
    ADD CONSTRAINT fk_chapters_course FOREIGN KEY (course_id) REFERENCES public.courses(id) ON DELETE CASCADE;


--
-- Name: completed_lessons_count fk_completed_lessons_count_course; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.completed_lessons_count
    ADD CONSTRAINT fk_completed_lessons_count_course FOREIGN KEY (course_id) REFERENCES public.courses(id) ON DELETE CASCADE;


--
-- Name: completed_lessons_count fk_completed_lessons_count_user; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.completed_lessons_count
    ADD CONSTRAINT fk_completed_lessons_count_user FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: contest_participants fk_contest_participants_contest; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.contest_participants
    ADD CONSTRAINT fk_contest_participants_contest FOREIGN KEY (contest_id) REFERENCES public.contests(id) ON DELETE CASCADE;


--
-- Name: contest_participants fk_contest_participants_user; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.contest_participants
    ADD CONSTRAINT fk_contest_participants_user FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: contest_problem_attempts fk_contest_problem_attempts_contest; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.contest_problem_attempts
    ADD CONSTRAINT fk_contest_problem_attempts_contest FOREIGN KEY (contest_id) REFERENCES public.contests(id) ON DELETE CASCADE;


--
-- Name: contest_problem_attempts fk_contest_problem_attempts_problem; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.contest_problem_attempts
    ADD CONSTRAINT fk_contest_problem_attempts_problem FOREIGN KEY (problem_id) REFERENCES public.online_judge_problems(id) ON DELETE CASCADE;


--
-- Name: contest_problem_attempts fk_contest_problem_attempts_user; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.contest_problem_attempts
    ADD CONSTRAINT fk_contest_problem_attempts_user FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: contest_problems fk_contest_problems_contest; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.contest_problems
    ADD CONSTRAINT fk_contest_problems_contest FOREIGN KEY (contest_id) REFERENCES public.contests(id) ON DELETE CASCADE;


--
-- Name: contest_problems fk_contest_problems_problem; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.contest_problems
    ADD CONSTRAINT fk_contest_problems_problem FOREIGN KEY (problem_id) REFERENCES public.online_judge_problems(id) ON DELETE CASCADE;


--
-- Name: contest_rankings fk_contest_rankings_contest; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.contest_rankings
    ADD CONSTRAINT fk_contest_rankings_contest FOREIGN KEY (contest_id) REFERENCES public.contests(id) ON DELETE CASCADE;


--
-- Name: contest_rankings fk_contest_rankings_user; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.contest_rankings
    ADD CONSTRAINT fk_contest_rankings_user FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: contests fk_contests_created_by_teacher; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.contests
    ADD CONSTRAINT fk_contests_created_by_teacher FOREIGN KEY (created_by_teacher_id) REFERENCES public.teachers(id);


--
-- Name: course_category_mappings fk_course_category_category; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.course_category_mappings
    ADD CONSTRAINT fk_course_category_category FOREIGN KEY (category_id) REFERENCES public.categories(id) ON DELETE CASCADE;


--
-- Name: course_category_mappings fk_course_category_course; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.course_category_mappings
    ADD CONSTRAINT fk_course_category_course FOREIGN KEY (course_id) REFERENCES public.courses(id) ON DELETE CASCADE;


--
-- Name: course_reviews fk_course_reviews_course; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.course_reviews
    ADD CONSTRAINT fk_course_reviews_course FOREIGN KEY (course_id) REFERENCES public.courses(id) ON DELETE CASCADE;


--
-- Name: course_reviews fk_course_reviews_user; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.course_reviews
    ADD CONSTRAINT fk_course_reviews_user FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: enrollments fk_enrollments_course; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.enrollments
    ADD CONSTRAINT fk_enrollments_course FOREIGN KEY (course_id) REFERENCES public.courses(id) ON DELETE CASCADE;


--
-- Name: enrollments fk_enrollments_user; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.enrollments
    ADD CONSTRAINT fk_enrollments_user FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: lesson_comments fk_lesson_comments_lesson; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.lesson_comments
    ADD CONSTRAINT fk_lesson_comments_lesson FOREIGN KEY (lesson_id) REFERENCES public.lessons(id) ON DELETE CASCADE;


--
-- Name: lesson_comments fk_lesson_comments_parent; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.lesson_comments
    ADD CONSTRAINT fk_lesson_comments_parent FOREIGN KEY (parent_comment_id) REFERENCES public.lesson_comments(id) ON DELETE CASCADE;


--
-- Name: lesson_comments fk_lesson_comments_user; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.lesson_comments
    ADD CONSTRAINT fk_lesson_comments_user FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: lesson_problems fk_lesson_problems_lesson; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.lesson_problems
    ADD CONSTRAINT fk_lesson_problems_lesson FOREIGN KEY (lesson_id) REFERENCES public.lessons(id) ON DELETE CASCADE;


--
-- Name: lesson_problems fk_lesson_problems_problem; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.lesson_problems
    ADD CONSTRAINT fk_lesson_problems_problem FOREIGN KEY (problem_id) REFERENCES public.online_judge_problems(id) ON DELETE CASCADE;


--
-- Name: lesson_progress fk_lesson_progress_course; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.lesson_progress
    ADD CONSTRAINT fk_lesson_progress_course FOREIGN KEY (course_id) REFERENCES public.courses(id) ON DELETE CASCADE;


--
-- Name: lesson_progress fk_lesson_progress_lesson; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.lesson_progress
    ADD CONSTRAINT fk_lesson_progress_lesson FOREIGN KEY (lesson_id) REFERENCES public.lessons(id) ON DELETE CASCADE;


--
-- Name: lesson_progress fk_lesson_progress_user; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.lesson_progress
    ADD CONSTRAINT fk_lesson_progress_user FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: lessons fk_lessons_chapter; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.lessons
    ADD CONSTRAINT fk_lessons_chapter FOREIGN KEY (chapter_id) REFERENCES public.chapters(id) ON DELETE CASCADE;


--
-- Name: online_judge_problems fk_online_judge_problems_created_by_teacher; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.online_judge_problems
    ADD CONSTRAINT fk_online_judge_problems_created_by_teacher FOREIGN KEY (created_by_teacher_id) REFERENCES public.teachers(id);


--
-- Name: online_judge_submissions fk_online_judge_submissions_contest; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.online_judge_submissions
    ADD CONSTRAINT fk_online_judge_submissions_contest FOREIGN KEY (contest_id) REFERENCES public.contests(id);


--
-- Name: online_judge_submissions fk_online_judge_submissions_lesson; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.online_judge_submissions
    ADD CONSTRAINT fk_online_judge_submissions_lesson FOREIGN KEY (lesson_id) REFERENCES public.lessons(id);


--
-- Name: online_judge_submissions fk_online_judge_submissions_problem; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.online_judge_submissions
    ADD CONSTRAINT fk_online_judge_submissions_problem FOREIGN KEY (problem_id) REFERENCES public.online_judge_problems(id);


--
-- Name: online_judge_submissions fk_online_judge_submissions_user; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.online_judge_submissions
    ADD CONSTRAINT fk_online_judge_submissions_user FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: order_items fk_order_items_course; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_items
    ADD CONSTRAINT fk_order_items_course FOREIGN KEY (course_id) REFERENCES public.courses(id);


--
-- Name: order_items fk_order_items_order; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_items
    ADD CONSTRAINT fk_order_items_order FOREIGN KEY (order_id) REFERENCES public.orders(id);


--
-- Name: orders fk_orders_user; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT fk_orders_user FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: payment_transactions fk_payment_transactions_wallet; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.payment_transactions
    ADD CONSTRAINT fk_payment_transactions_wallet FOREIGN KEY (wallet_id) REFERENCES public.wallets(id) ON DELETE CASCADE;


--
-- Name: problem_tag_mappings fk_problem_tag_mappings_problem; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.problem_tag_mappings
    ADD CONSTRAINT fk_problem_tag_mappings_problem FOREIGN KEY (problem_id) REFERENCES public.online_judge_problems(id) ON DELETE CASCADE;


--
-- Name: problem_tag_mappings fk_problem_tag_mappings_tag; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.problem_tag_mappings
    ADD CONSTRAINT fk_problem_tag_mappings_tag FOREIGN KEY (tag_id) REFERENCES public.problem_tags(id) ON DELETE CASCADE;


--
-- Name: problem_testcases fk_problem_testcases_problem; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.problem_testcases
    ADD CONSTRAINT fk_problem_testcases_problem FOREIGN KEY (problem_id) REFERENCES public.online_judge_problems(id) ON DELETE CASCADE;


--
-- Name: quiz_attempts fk_quiz_attempts_quiz; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.quiz_attempts
    ADD CONSTRAINT fk_quiz_attempts_quiz FOREIGN KEY (quiz_id) REFERENCES public.quizzes(id) ON DELETE CASCADE;


--
-- Name: quiz_attempts fk_quiz_attempts_user; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.quiz_attempts
    ADD CONSTRAINT fk_quiz_attempts_user FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: quiz_options fk_quiz_options_question; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.quiz_options
    ADD CONSTRAINT fk_quiz_options_question FOREIGN KEY (question_id) REFERENCES public.quiz_questions(id) ON DELETE CASCADE;


--
-- Name: quiz_questions fk_quiz_questions_quiz; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.quiz_questions
    ADD CONSTRAINT fk_quiz_questions_quiz FOREIGN KEY (quiz_id) REFERENCES public.quizzes(id) ON DELETE CASCADE;


--
-- Name: quizzes fk_quizzes_created_by_teacher; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.quizzes
    ADD CONSTRAINT fk_quizzes_created_by_teacher FOREIGN KEY (created_by_teacher_id) REFERENCES public.teachers(id);


--
-- Name: quizzes fk_quizzes_lesson; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.quizzes
    ADD CONSTRAINT fk_quizzes_lesson FOREIGN KEY (lesson_id) REFERENCES public.lessons(id) ON DELETE CASCADE;


--
-- Name: refresh_tokens fk_refresh_tokens_user; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.refresh_tokens
    ADD CONSTRAINT fk_refresh_tokens_user FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: role_permissions fk_role_permissions_permission; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.role_permissions
    ADD CONSTRAINT fk_role_permissions_permission FOREIGN KEY (permission_id) REFERENCES public.permissions(id) ON DELETE CASCADE;


--
-- Name: role_permissions fk_role_permissions_role; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.role_permissions
    ADD CONSTRAINT fk_role_permissions_role FOREIGN KEY (role_id) REFERENCES public.roles(id) ON DELETE CASCADE;


--
-- Name: online_judge_submission_details fk_sub_details_submission; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.online_judge_submission_details
    ADD CONSTRAINT fk_sub_details_submission FOREIGN KEY (submission_id) REFERENCES public.online_judge_submissions(id) ON DELETE CASCADE;


--
-- Name: online_judge_submission_details fk_sub_details_testcase; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.online_judge_submission_details
    ADD CONSTRAINT fk_sub_details_testcase FOREIGN KEY (testcase_id) REFERENCES public.problem_testcases(id) ON DELETE CASCADE;


--
-- Name: teacher_course_assignments fk_teacher_course_assignments_admin; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.teacher_course_assignments
    ADD CONSTRAINT fk_teacher_course_assignments_admin FOREIGN KEY (assigned_by_admin_id) REFERENCES public.users(id);


--
-- Name: teacher_course_assignments fk_teacher_course_assignments_course; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.teacher_course_assignments
    ADD CONSTRAINT fk_teacher_course_assignments_course FOREIGN KEY (course_id) REFERENCES public.courses(id) ON DELETE CASCADE;


--
-- Name: teacher_course_assignments fk_teacher_course_assignments_teacher; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.teacher_course_assignments
    ADD CONSTRAINT fk_teacher_course_assignments_teacher FOREIGN KEY (teacher_id) REFERENCES public.teachers(id) ON DELETE CASCADE;


--
-- Name: teachers fk_teachers_user; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.teachers
    ADD CONSTRAINT fk_teachers_user FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: user_roles fk_user_roles_role; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_roles
    ADD CONSTRAINT fk_user_roles_role FOREIGN KEY (role_id) REFERENCES public.roles(id) ON DELETE CASCADE;


--
-- Name: user_roles fk_user_roles_user; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_roles
    ADD CONSTRAINT fk_user_roles_user FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: wallet_transactions fk_wallet_transactions_wallet; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.wallet_transactions
    ADD CONSTRAINT fk_wallet_transactions_wallet FOREIGN KEY (wallet_id) REFERENCES public.wallets(id) ON DELETE CASCADE;


--
-- Name: wallet_transactions fk_wallet_tx_order; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.wallet_transactions
    ADD CONSTRAINT fk_wallet_tx_order FOREIGN KEY (order_id) REFERENCES public.orders(id);


--
-- Name: wallets fk_wallets_user; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.wallets
    ADD CONSTRAINT fk_wallets_user FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: quiz_attempt_answers quiz_attempt_answers_attempt_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.quiz_attempt_answers
    ADD CONSTRAINT quiz_attempt_answers_attempt_id_fkey FOREIGN KEY (attempt_id) REFERENCES public.quiz_attempts(id) ON DELETE CASCADE;


--
-- Name: quiz_attempt_answers quiz_attempt_answers_question_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.quiz_attempt_answers
    ADD CONSTRAINT quiz_attempt_answers_question_id_fkey FOREIGN KEY (question_id) REFERENCES public.quiz_questions(id);


--
-- Name: quiz_attempt_answers quiz_attempt_answers_selected_option_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.quiz_attempt_answers
    ADD CONSTRAINT quiz_attempt_answers_selected_option_id_fkey FOREIGN KEY (selected_option_id) REFERENCES public.quiz_options(id);


--
-- Name: SCHEMA public; Type: ACL; Schema: -; Owner: pg_database_owner
--

REVOKE ALL ON SCHEMA public FROM ngocthanh;
REVOKE ALL ON SCHEMA public FROM PUBLIC;
GRANT ALL ON SCHEMA public TO pg_database_owner;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- PostgreSQL database dump complete
--

\unrestrict AV3msB1zxUDj5d0YfjZtfZT9cn1SD0NtWcl5etvhTlMDLF47kHzTOa2iMav04xw

