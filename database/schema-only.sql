--
-- PostgreSQL database dump
--


-- Dumped from database version 14.23 (Homebrew)
-- Dumped by pg_dump version 14.23 (Homebrew)

-- Started on 2026-07-23 17:21:34 +07

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
-- TOC entry 907 (class 1247 OID 16387)
-- Name: contest_status; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.contest_status AS ENUM (
    'UPCOMING',
    'RUNNING',
    'ENDED',
    'CANCELLED'
);


--
-- TOC entry 1000 (class 1247 OID 65170)
-- Name: conteststatus; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.conteststatus AS ENUM (
    'CANCELLED',
    'ENDED',
    'RUNNING',
    'UPCOMING'
);


--
-- TOC entry 910 (class 1247 OID 16396)
-- Name: course_status; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.course_status AS ENUM (
    'ACTIVE',
    'INACTIVE',
    'DRAFT'
);


--
-- TOC entry 1090 (class 1247 OID 65182)
-- Name: coursestatus; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.coursestatus AS ENUM (
    'ACTIVE',
    'DRAFT',
    'INACTIVE'
);


--
-- TOC entry 913 (class 1247 OID 16404)
-- Name: enrollment_status; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.enrollment_status AS ENUM (
    'ACTIVE',
    'CANCELLED',
    'COMPLETED'
);


--
-- TOC entry 1093 (class 1247 OID 65192)
-- Name: enrollmentstatus; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.enrollmentstatus AS ENUM (
    'ACTIVE',
    'CANCELLED',
    'COMPLETED'
);


--
-- TOC entry 916 (class 1247 OID 16412)
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
-- TOC entry 1132 (class 1247 OID 42516)
-- Name: filesubmissionstatus; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.filesubmissionstatus AS ENUM (
    'GRADED',
    'IN_REVIEW',
    'NEEDS_RESUBMISSION',
    'REPLACED',
    'RESUBMITTED',
    'SUBMITTED'
);


--
-- TOC entry 919 (class 1247 OID 16426)
-- Name: lesson_status; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.lesson_status AS ENUM (
    'ACTIVE',
    'INACTIVE',
    'DRAFT'
);


--
-- TOC entry 1096 (class 1247 OID 65202)
-- Name: lessonstatus; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.lessonstatus AS ENUM (
    'ACTIVE',
    'DRAFT',
    'INACTIVE'
);


--
-- TOC entry 922 (class 1247 OID 16434)
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
-- TOC entry 1105 (class 1247 OID 65234)
-- Name: ojverdict; Type: TYPE; Schema: public; Owner: -
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


--
-- TOC entry 925 (class 1247 OID 16454)
-- Name: order_status; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.order_status AS ENUM (
    'PENDING',
    'COMPLETED',
    'CANCELLED',
    'FAILED'
);


--
-- TOC entry 1108 (class 1247 OID 65256)
-- Name: orderstatus; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.orderstatus AS ENUM (
    'CANCELLED',
    'COMPLETED',
    'FAILED',
    'PENDING'
);


--
-- TOC entry 928 (class 1247 OID 16464)
-- Name: payment_transaction_type; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.payment_transaction_type AS ENUM (
    'DEPOSIT',
    'WITHDRAW'
);


--
-- TOC entry 1114 (class 1247 OID 65280)
-- Name: paymenttransactiontype; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.paymenttransactiontype AS ENUM (
    'DEPOSIT',
    'WITHDRAW'
);


--
-- TOC entry 931 (class 1247 OID 16470)
-- Name: problem_difficulty; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.problem_difficulty AS ENUM (
    'EASY',
    'MEDIUM',
    'HARD'
);


--
-- TOC entry 934 (class 1247 OID 16478)
-- Name: problem_scope; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.problem_scope AS ENUM (
    'LESSON',
    'CONTEST',
    'SHARED',
    'PRACTICE'
);


--
-- TOC entry 1099 (class 1247 OID 65212)
-- Name: problemdifficulty; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.problemdifficulty AS ENUM (
    'EASY',
    'HARD',
    'MEDIUM'
);


--
-- TOC entry 1102 (class 1247 OID 65222)
-- Name: problemscope; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.problemscope AS ENUM (
    'CONTEST',
    'LESSON',
    'PRACTICE',
    'SHARED'
);


--
-- TOC entry 937 (class 1247 OID 16488)
-- Name: scoring_rule; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.scoring_rule AS ENUM (
    'ICPC',
    'IOI',
    'CUSTOM'
);


--
-- TOC entry 997 (class 1247 OID 65160)
-- Name: scoringrule; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.scoringrule AS ENUM (
    'CUSTOM',
    'ICPC',
    'IOI'
);


--
-- TOC entry 940 (class 1247 OID 16496)
-- Name: teacher_status; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.teacher_status AS ENUM (
    'ACTIVE',
    'INACTIVE',
    'LOCKED'
);


--
-- TOC entry 1123 (class 1247 OID 65310)
-- Name: teacherstatus; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.teacherstatus AS ENUM (
    'ACTIVE',
    'INACTIVE',
    'LOCKED'
);


--
-- TOC entry 943 (class 1247 OID 16504)
-- Name: transaction_status; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.transaction_status AS ENUM (
    'PENDING',
    'SUCCESS',
    'FAILED',
    'CANCELLED'
);


--
-- TOC entry 1111 (class 1247 OID 65268)
-- Name: transactionstatus; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.transactionstatus AS ENUM (
    'CANCELLED',
    'FAILED',
    'PENDING',
    'SUCCESS'
);


--
-- TOC entry 946 (class 1247 OID 16514)
-- Name: user_status; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.user_status AS ENUM (
    'ACTIVE',
    'LOCKED',
    'DISABLED'
);


--
-- TOC entry 1126 (class 1247 OID 65320)
-- Name: userstatus; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.userstatus AS ENUM (
    'ACTIVE',
    'DISABLED',
    'LOCKED'
);


--
-- TOC entry 949 (class 1247 OID 16522)
-- Name: wallet_status; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.wallet_status AS ENUM (
    'ACTIVE',
    'LOCKED'
);


--
-- TOC entry 952 (class 1247 OID 16528)
-- Name: wallet_transaction_type; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.wallet_transaction_type AS ENUM (
    'DEPOSIT',
    'PURCHASE',
    'REWARD',
    'REFUND',
    'WITHDRAW'
);


--
-- TOC entry 1117 (class 1247 OID 65288)
-- Name: walletstatus; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.walletstatus AS ENUM (
    'ACTIVE',
    'LOCKED'
);


--
-- TOC entry 1120 (class 1247 OID 65296)
-- Name: wallettransactiontype; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.wallettransactiontype AS ENUM (
    'DEPOSIT',
    'PURCHASE',
    'REFUND',
    'REWARD',
    'WITHDRAW'
);


--
-- TOC entry 3987 (class 2605 OID 65180)
-- Name: CAST (public.conteststatus AS character varying); Type: CAST; Schema: -; Owner: -
--

CREATE CAST (public.conteststatus AS character varying) WITH INOUT AS IMPLICIT;


--
-- TOC entry 3988 (class 2605 OID 65190)
-- Name: CAST (public.coursestatus AS character varying); Type: CAST; Schema: -; Owner: -
--

CREATE CAST (public.coursestatus AS character varying) WITH INOUT AS IMPLICIT;


--
-- TOC entry 3989 (class 2605 OID 65200)
-- Name: CAST (public.enrollmentstatus AS character varying); Type: CAST; Schema: -; Owner: -
--

CREATE CAST (public.enrollmentstatus AS character varying) WITH INOUT AS IMPLICIT;


--
-- TOC entry 3985 (class 2605 OID 42530)
-- Name: CAST (public.filesubmissionstatus AS character varying); Type: CAST; Schema: -; Owner: -
--

CREATE CAST (public.filesubmissionstatus AS character varying) WITH INOUT AS IMPLICIT;


--
-- TOC entry 3990 (class 2605 OID 65210)
-- Name: CAST (public.lessonstatus AS character varying); Type: CAST; Schema: -; Owner: -
--

CREATE CAST (public.lessonstatus AS character varying) WITH INOUT AS IMPLICIT;


--
-- TOC entry 3993 (class 2605 OID 65254)
-- Name: CAST (public.ojverdict AS character varying); Type: CAST; Schema: -; Owner: -
--

CREATE CAST (public.ojverdict AS character varying) WITH INOUT AS IMPLICIT;


--
-- TOC entry 3994 (class 2605 OID 65266)
-- Name: CAST (public.orderstatus AS character varying); Type: CAST; Schema: -; Owner: -
--

CREATE CAST (public.orderstatus AS character varying) WITH INOUT AS IMPLICIT;


--
-- TOC entry 3996 (class 2605 OID 65286)
-- Name: CAST (public.paymenttransactiontype AS character varying); Type: CAST; Schema: -; Owner: -
--

CREATE CAST (public.paymenttransactiontype AS character varying) WITH INOUT AS IMPLICIT;


--
-- TOC entry 3991 (class 2605 OID 65220)
-- Name: CAST (public.problemdifficulty AS character varying); Type: CAST; Schema: -; Owner: -
--

CREATE CAST (public.problemdifficulty AS character varying) WITH INOUT AS IMPLICIT;


--
-- TOC entry 3992 (class 2605 OID 65232)
-- Name: CAST (public.problemscope AS character varying); Type: CAST; Schema: -; Owner: -
--

CREATE CAST (public.problemscope AS character varying) WITH INOUT AS IMPLICIT;


--
-- TOC entry 3986 (class 2605 OID 65168)
-- Name: CAST (public.scoringrule AS character varying); Type: CAST; Schema: -; Owner: -
--

CREATE CAST (public.scoringrule AS character varying) WITH INOUT AS IMPLICIT;


--
-- TOC entry 3999 (class 2605 OID 65318)
-- Name: CAST (public.teacherstatus AS character varying); Type: CAST; Schema: -; Owner: -
--

CREATE CAST (public.teacherstatus AS character varying) WITH INOUT AS IMPLICIT;


--
-- TOC entry 3995 (class 2605 OID 65278)
-- Name: CAST (public.transactionstatus AS character varying); Type: CAST; Schema: -; Owner: -
--

CREATE CAST (public.transactionstatus AS character varying) WITH INOUT AS IMPLICIT;


--
-- TOC entry 4000 (class 2605 OID 65328)
-- Name: CAST (public.userstatus AS character varying); Type: CAST; Schema: -; Owner: -
--

CREATE CAST (public.userstatus AS character varying) WITH INOUT AS IMPLICIT;


--
-- TOC entry 3892 (class 2605 OID 65179)
-- Name: CAST (character varying AS public.conteststatus); Type: CAST; Schema: -; Owner: -
--

CREATE CAST (character varying AS public.conteststatus) WITH INOUT AS IMPLICIT;


--
-- TOC entry 3893 (class 2605 OID 65189)
-- Name: CAST (character varying AS public.coursestatus); Type: CAST; Schema: -; Owner: -
--

CREATE CAST (character varying AS public.coursestatus) WITH INOUT AS IMPLICIT;


--
-- TOC entry 3894 (class 2605 OID 65199)
-- Name: CAST (character varying AS public.enrollmentstatus); Type: CAST; Schema: -; Owner: -
--

CREATE CAST (character varying AS public.enrollmentstatus) WITH INOUT AS IMPLICIT;


--
-- TOC entry 3890 (class 2605 OID 42529)
-- Name: CAST (character varying AS public.filesubmissionstatus); Type: CAST; Schema: -; Owner: -
--

CREATE CAST (character varying AS public.filesubmissionstatus) WITH INOUT AS IMPLICIT;


--
-- TOC entry 3895 (class 2605 OID 65209)
-- Name: CAST (character varying AS public.lessonstatus); Type: CAST; Schema: -; Owner: -
--

CREATE CAST (character varying AS public.lessonstatus) WITH INOUT AS IMPLICIT;


--
-- TOC entry 3898 (class 2605 OID 65253)
-- Name: CAST (character varying AS public.ojverdict); Type: CAST; Schema: -; Owner: -
--

CREATE CAST (character varying AS public.ojverdict) WITH INOUT AS IMPLICIT;


--
-- TOC entry 3899 (class 2605 OID 65265)
-- Name: CAST (character varying AS public.orderstatus); Type: CAST; Schema: -; Owner: -
--

CREATE CAST (character varying AS public.orderstatus) WITH INOUT AS IMPLICIT;


--
-- TOC entry 3901 (class 2605 OID 65285)
-- Name: CAST (character varying AS public.paymenttransactiontype); Type: CAST; Schema: -; Owner: -
--

CREATE CAST (character varying AS public.paymenttransactiontype) WITH INOUT AS IMPLICIT;


--
-- TOC entry 3896 (class 2605 OID 65219)
-- Name: CAST (character varying AS public.problemdifficulty); Type: CAST; Schema: -; Owner: -
--

CREATE CAST (character varying AS public.problemdifficulty) WITH INOUT AS IMPLICIT;


--
-- TOC entry 3897 (class 2605 OID 65231)
-- Name: CAST (character varying AS public.problemscope); Type: CAST; Schema: -; Owner: -
--

CREATE CAST (character varying AS public.problemscope) WITH INOUT AS IMPLICIT;


--
-- TOC entry 3891 (class 2605 OID 65167)
-- Name: CAST (character varying AS public.scoringrule); Type: CAST; Schema: -; Owner: -
--

CREATE CAST (character varying AS public.scoringrule) WITH INOUT AS IMPLICIT;


--
-- TOC entry 3904 (class 2605 OID 65317)
-- Name: CAST (character varying AS public.teacherstatus); Type: CAST; Schema: -; Owner: -
--

CREATE CAST (character varying AS public.teacherstatus) WITH INOUT AS IMPLICIT;


--
-- TOC entry 3900 (class 2605 OID 65277)
-- Name: CAST (character varying AS public.transactionstatus); Type: CAST; Schema: -; Owner: -
--

CREATE CAST (character varying AS public.transactionstatus) WITH INOUT AS IMPLICIT;


--
-- TOC entry 3905 (class 2605 OID 65327)
-- Name: CAST (character varying AS public.userstatus); Type: CAST; Schema: -; Owner: -
--

CREATE CAST (character varying AS public.userstatus) WITH INOUT AS IMPLICIT;


--
-- TOC entry 3902 (class 2605 OID 65293)
-- Name: CAST (character varying AS public.walletstatus); Type: CAST; Schema: -; Owner: -
--

CREATE CAST (character varying AS public.walletstatus) WITH INOUT AS IMPLICIT;


--
-- TOC entry 3903 (class 2605 OID 65307)
-- Name: CAST (character varying AS public.wallettransactiontype); Type: CAST; Schema: -; Owner: -
--

CREATE CAST (character varying AS public.wallettransactiontype) WITH INOUT AS IMPLICIT;


--
-- TOC entry 3997 (class 2605 OID 65294)
-- Name: CAST (public.walletstatus AS character varying); Type: CAST; Schema: -; Owner: -
--

CREATE CAST (public.walletstatus AS character varying) WITH INOUT AS IMPLICIT;


--
-- TOC entry 3998 (class 2605 OID 65308)
-- Name: CAST (public.wallettransactiontype AS character varying); Type: CAST; Schema: -; Owner: -
--

CREATE CAST (public.wallettransactiontype AS character varying) WITH INOUT AS IMPLICIT;


--
-- TOC entry 294 (class 1255 OID 16539)
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
-- TOC entry 209 (class 1259 OID 16540)
-- Name: cart_items; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.cart_items (
    id bigint NOT NULL,
    cart_id bigint NOT NULL,
    course_id bigint NOT NULL,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


--
-- TOC entry 210 (class 1259 OID 16544)
-- Name: cart_items_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.cart_items_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 4693 (class 0 OID 0)
-- Dependencies: 210
-- Name: cart_items_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.cart_items_id_seq OWNED BY public.cart_items.id;


--
-- TOC entry 211 (class 1259 OID 16545)
-- Name: carts; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.carts (
    id bigint NOT NULL,
    user_id bigint NOT NULL,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


--
-- TOC entry 212 (class 1259 OID 16550)
-- Name: carts_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.carts_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 4694 (class 0 OID 0)
-- Dependencies: 212
-- Name: carts_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.carts_id_seq OWNED BY public.carts.id;


--
-- TOC entry 213 (class 1259 OID 16551)
-- Name: categories; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.categories (
    id bigint NOT NULL,
    name character varying(255) NOT NULL,
    slug character varying(255) NOT NULL,
    description text,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL
);


--
-- TOC entry 214 (class 1259 OID 16558)
-- Name: categories_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.categories_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 4695 (class 0 OID 0)
-- Dependencies: 214
-- Name: categories_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.categories_id_seq OWNED BY public.categories.id;


--
-- TOC entry 215 (class 1259 OID 16559)
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
-- TOC entry 216 (class 1259 OID 16566)
-- Name: chapters_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.chapters_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 4696 (class 0 OID 0)
-- Dependencies: 216
-- Name: chapters_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.chapters_id_seq OWNED BY public.chapters.id;


--
-- TOC entry 217 (class 1259 OID 16567)
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
-- TOC entry 218 (class 1259 OID 16573)
-- Name: completed_lessons_count_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.completed_lessons_count_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 4697 (class 0 OID 0)
-- Dependencies: 218
-- Name: completed_lessons_count_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.completed_lessons_count_id_seq OWNED BY public.completed_lessons_count.id;


--
-- TOC entry 219 (class 1259 OID 16574)
-- Name: contest_participants; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.contest_participants (
    id bigint NOT NULL,
    contest_id bigint NOT NULL,
    user_id bigint NOT NULL,
    joined_at timestamp with time zone DEFAULT now() NOT NULL
);


--
-- TOC entry 220 (class 1259 OID 16578)
-- Name: contest_participants_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.contest_participants_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 4698 (class 0 OID 0)
-- Dependencies: 220
-- Name: contest_participants_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.contest_participants_id_seq OWNED BY public.contest_participants.id;


--
-- TOC entry 221 (class 1259 OID 16579)
-- Name: contest_problem_attempts; Type: TABLE; Schema: public; Owner: -
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


--
-- TOC entry 222 (class 1259 OID 16588)
-- Name: contest_problem_attempts_id_seq; Type: SEQUENCE; Schema: public; Owner: -
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
-- TOC entry 223 (class 1259 OID 16589)
-- Name: contest_problems; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.contest_problems (
    id bigint NOT NULL,
    contest_id bigint NOT NULL,
    problem_id bigint NOT NULL,
    order_index integer NOT NULL,
    CONSTRAINT chk_contest_problems_order_positive CHECK ((order_index > 0))
);


--
-- TOC entry 224 (class 1259 OID 16593)
-- Name: contest_problems_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.contest_problems_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 4699 (class 0 OID 0)
-- Dependencies: 224
-- Name: contest_problems_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.contest_problems_id_seq OWNED BY public.contest_problems.id;


--
-- TOC entry 225 (class 1259 OID 16594)
-- Name: contest_rankings; Type: TABLE; Schema: public; Owner: -
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


--
-- TOC entry 226 (class 1259 OID 16602)
-- Name: contest_rankings_id_seq; Type: SEQUENCE; Schema: public; Owner: -
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
-- TOC entry 227 (class 1259 OID 16603)
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
    scoring_rule public.scoring_rule DEFAULT 'ICPC'::public.scoring_rule NOT NULL,
    CONSTRAINT chk_contests_time_valid CHECK ((end_time > start_time)),
    CONSTRAINT chk_contests_title_not_blank CHECK ((length(TRIM(BOTH FROM title)) > 0))
);


--
-- TOC entry 228 (class 1259 OID 16614)
-- Name: contests_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.contests_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 4700 (class 0 OID 0)
-- Dependencies: 228
-- Name: contests_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.contests_id_seq OWNED BY public.contests.id;


--
-- TOC entry 229 (class 1259 OID 16615)
-- Name: course_category_mappings; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.course_category_mappings (
    course_id bigint NOT NULL,
    category_id bigint NOT NULL
);


--
-- TOC entry 230 (class 1259 OID 16618)
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
-- TOC entry 231 (class 1259 OID 16626)
-- Name: course_reviews_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.course_reviews_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 4701 (class 0 OID 0)
-- Dependencies: 231
-- Name: course_reviews_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.course_reviews_id_seq OWNED BY public.course_reviews.id;


--
-- TOC entry 232 (class 1259 OID 16627)
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


--
-- TOC entry 233 (class 1259 OID 16647)
-- Name: courses_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.courses_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 4702 (class 0 OID 0)
-- Dependencies: 233
-- Name: courses_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.courses_id_seq OWNED BY public.courses.id;


--
-- TOC entry 234 (class 1259 OID 16648)
-- Name: enrollments; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.enrollments (
    id bigint NOT NULL,
    user_id bigint NOT NULL,
    course_id bigint NOT NULL,
    enrolled_at timestamp with time zone DEFAULT now() NOT NULL,
    status public.enrollment_status DEFAULT 'ACTIVE'::public.enrollment_status NOT NULL
);


--
-- TOC entry 235 (class 1259 OID 16653)
-- Name: enrollments_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.enrollments_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 4703 (class 0 OID 0)
-- Dependencies: 235
-- Name: enrollments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.enrollments_id_seq OWNED BY public.enrollments.id;


--
-- TOC entry 236 (class 1259 OID 16675)
-- Name: invalidated_tokens; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.invalidated_tokens (
    id bigint NOT NULL,
    token_jti character varying(255) NOT NULL,
    expiry_time timestamp with time zone NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL
);


--
-- TOC entry 237 (class 1259 OID 16679)
-- Name: invalidated_tokens_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.invalidated_tokens_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 4704 (class 0 OID 0)
-- Dependencies: 237
-- Name: invalidated_tokens_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.invalidated_tokens_id_seq OWNED BY public.invalidated_tokens.id;


--
-- TOC entry 238 (class 1259 OID 16680)
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
-- TOC entry 239 (class 1259 OID 16689)
-- Name: lesson_comments_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.lesson_comments_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 4705 (class 0 OID 0)
-- Dependencies: 239
-- Name: lesson_comments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.lesson_comments_id_seq OWNED BY public.lesson_comments.id;


--
-- TOC entry 240 (class 1259 OID 16690)
-- Name: lesson_problems; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.lesson_problems (
    id bigint NOT NULL,
    lesson_id bigint NOT NULL,
    problem_id bigint NOT NULL,
    order_index integer DEFAULT 0 NOT NULL
);


--
-- TOC entry 241 (class 1259 OID 16694)
-- Name: lesson_problems_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.lesson_problems_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 4706 (class 0 OID 0)
-- Dependencies: 241
-- Name: lesson_problems_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.lesson_problems_id_seq OWNED BY public.lesson_problems.id;


--
-- TOC entry 242 (class 1259 OID 16695)
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
-- TOC entry 243 (class 1259 OID 16699)
-- Name: lesson_progress_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.lesson_progress_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 4707 (class 0 OID 0)
-- Dependencies: 243
-- Name: lesson_progress_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.lesson_progress_id_seq OWNED BY public.lesson_progress.id;


--
-- TOC entry 244 (class 1259 OID 16700)
-- Name: lessons; Type: TABLE; Schema: public; Owner: -
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


--
-- TOC entry 245 (class 1259 OID 16712)
-- Name: lessons_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.lessons_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 4708 (class 0 OID 0)
-- Dependencies: 245
-- Name: lessons_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.lessons_id_seq OWNED BY public.lessons.id;


--
-- TOC entry 246 (class 1259 OID 16713)
-- Name: online_judge_problems; Type: TABLE; Schema: public; Owner: -
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


--
-- TOC entry 247 (class 1259 OID 16730)
-- Name: online_judge_problems_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.online_judge_problems_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 4709 (class 0 OID 0)
-- Dependencies: 247
-- Name: online_judge_problems_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.online_judge_problems_id_seq OWNED BY public.online_judge_problems.id;


--
-- TOC entry 248 (class 1259 OID 16731)
-- Name: online_judge_submission_details; Type: TABLE; Schema: public; Owner: -
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


--
-- TOC entry 249 (class 1259 OID 16736)
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
-- TOC entry 4710 (class 0 OID 0)
-- Dependencies: 249
-- Name: online_judge_submission_details_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.online_judge_submission_details_id_seq OWNED BY public.online_judge_submission_details.id;


--
-- TOC entry 250 (class 1259 OID 16737)
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
    verdict public.oj_verdict DEFAULT 'PENDING'::public.oj_verdict NOT NULL,
    CONSTRAINT chk_online_judge_submissions_context CHECK ((((lesson_id IS NOT NULL) AND (contest_id IS NULL)) OR ((lesson_id IS NULL) AND (contest_id IS NOT NULL)) OR ((lesson_id IS NULL) AND (contest_id IS NULL)))),
    CONSTRAINT chk_online_judge_submissions_execution_time_non_negative CHECK (((execution_time_ms IS NULL) OR (execution_time_ms >= 0))),
    CONSTRAINT chk_online_judge_submissions_memory_non_negative CHECK (((memory_used_kb IS NULL) OR (memory_used_kb >= 0))),
    CONSTRAINT chk_online_judge_submissions_score_non_negative CHECK (((score IS NULL) OR (score >= (0)::numeric)))
);


--
-- TOC entry 251 (class 1259 OID 16748)
-- Name: online_judge_submissions_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.online_judge_submissions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 4711 (class 0 OID 0)
-- Dependencies: 251
-- Name: online_judge_submissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.online_judge_submissions_id_seq OWNED BY public.online_judge_submissions.id;


--
-- TOC entry 252 (class 1259 OID 16749)
-- Name: order_items; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.order_items (
    id bigint NOT NULL,
    order_id bigint NOT NULL,
    course_id bigint NOT NULL,
    price numeric(12,2) DEFAULT 0 NOT NULL
);


--
-- TOC entry 253 (class 1259 OID 16753)
-- Name: order_items_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.order_items_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 4712 (class 0 OID 0)
-- Dependencies: 253
-- Name: order_items_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.order_items_id_seq OWNED BY public.order_items.id;


--
-- TOC entry 254 (class 1259 OID 16754)
-- Name: orders; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.orders (
    id bigint NOT NULL,
    user_id bigint NOT NULL,
    total_amount numeric(12,2) DEFAULT 0 NOT NULL,
    status public.order_status DEFAULT 'PENDING'::public.order_status NOT NULL,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


--
-- TOC entry 255 (class 1259 OID 16761)
-- Name: orders_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.orders_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 4713 (class 0 OID 0)
-- Dependencies: 255
-- Name: orders_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.orders_id_seq OWNED BY public.orders.id;


--
-- TOC entry 256 (class 1259 OID 16762)
-- Name: payment_transactions; Type: TABLE; Schema: public; Owner: -
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


--
-- TOC entry 257 (class 1259 OID 16770)
-- Name: payment_transactions_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.payment_transactions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 4714 (class 0 OID 0)
-- Dependencies: 257
-- Name: payment_transactions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.payment_transactions_id_seq OWNED BY public.payment_transactions.id;


--
-- TOC entry 258 (class 1259 OID 16771)
-- Name: permissions; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.permissions (
    id bigint NOT NULL,
    name character varying(150) NOT NULL,
    CONSTRAINT chk_permissions_name_not_blank CHECK ((length(TRIM(BOTH FROM name)) > 0))
);


--
-- TOC entry 259 (class 1259 OID 16775)
-- Name: permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.permissions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 4715 (class 0 OID 0)
-- Dependencies: 259
-- Name: permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.permissions_id_seq OWNED BY public.permissions.id;


--
-- TOC entry 260 (class 1259 OID 16776)
-- Name: problem_tag_mappings; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.problem_tag_mappings (
    id bigint NOT NULL,
    problem_id bigint NOT NULL,
    tag_id bigint NOT NULL
);


--
-- TOC entry 261 (class 1259 OID 16779)
-- Name: problem_tag_mappings_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.problem_tag_mappings_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 4716 (class 0 OID 0)
-- Dependencies: 261
-- Name: problem_tag_mappings_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.problem_tag_mappings_id_seq OWNED BY public.problem_tag_mappings.id;


--
-- TOC entry 262 (class 1259 OID 16780)
-- Name: problem_tags; Type: TABLE; Schema: public; Owner: -
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


--
-- TOC entry 263 (class 1259 OID 16787)
-- Name: problem_tags_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.problem_tags_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 4717 (class 0 OID 0)
-- Dependencies: 263
-- Name: problem_tags_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.problem_tags_id_seq OWNED BY public.problem_tags.id;


--
-- TOC entry 264 (class 1259 OID 16788)
-- Name: problem_testcases; Type: TABLE; Schema: public; Owner: -
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


--
-- TOC entry 265 (class 1259 OID 16795)
-- Name: problem_testcases_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.problem_testcases_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 4718 (class 0 OID 0)
-- Dependencies: 265
-- Name: problem_testcases_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.problem_testcases_id_seq OWNED BY public.problem_testcases.id;


--
-- TOC entry 266 (class 1259 OID 16796)
-- Name: quiz_attempt_answers; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.quiz_attempt_answers (
    id bigint NOT NULL,
    attempt_id bigint NOT NULL,
    question_id bigint NOT NULL,
    selected_option_id bigint
);


--
-- TOC entry 267 (class 1259 OID 16799)
-- Name: quiz_attempt_answers_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.quiz_attempt_answers_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 4719 (class 0 OID 0)
-- Dependencies: 267
-- Name: quiz_attempt_answers_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.quiz_attempt_answers_id_seq OWNED BY public.quiz_attempt_answers.id;


--
-- TOC entry 268 (class 1259 OID 16800)
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
-- TOC entry 269 (class 1259 OID 16809)
-- Name: quiz_attempts_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.quiz_attempts_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 4720 (class 0 OID 0)
-- Dependencies: 269
-- Name: quiz_attempts_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.quiz_attempts_id_seq OWNED BY public.quiz_attempts.id;


--
-- TOC entry 270 (class 1259 OID 16810)
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
-- TOC entry 271 (class 1259 OID 16818)
-- Name: quiz_options_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.quiz_options_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 4721 (class 0 OID 0)
-- Dependencies: 271
-- Name: quiz_options_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.quiz_options_id_seq OWNED BY public.quiz_options.id;


--
-- TOC entry 272 (class 1259 OID 16819)
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
-- TOC entry 273 (class 1259 OID 16826)
-- Name: quiz_questions_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.quiz_questions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 4722 (class 0 OID 0)
-- Dependencies: 273
-- Name: quiz_questions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.quiz_questions_id_seq OWNED BY public.quiz_questions.id;


--
-- TOC entry 274 (class 1259 OID 16827)
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
-- TOC entry 275 (class 1259 OID 16836)
-- Name: quizzes_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.quizzes_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 4723 (class 0 OID 0)
-- Dependencies: 275
-- Name: quizzes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.quizzes_id_seq OWNED BY public.quizzes.id;


--
-- TOC entry 276 (class 1259 OID 16837)
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
-- TOC entry 277 (class 1259 OID 16841)
-- Name: refresh_tokens_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.refresh_tokens_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 4724 (class 0 OID 0)
-- Dependencies: 277
-- Name: refresh_tokens_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.refresh_tokens_id_seq OWNED BY public.refresh_tokens.id;


--
-- TOC entry 278 (class 1259 OID 16842)
-- Name: role_permissions; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.role_permissions (
    role_id bigint NOT NULL,
    permission_id bigint NOT NULL
);


--
-- TOC entry 279 (class 1259 OID 16845)
-- Name: roles; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.roles (
    id bigint NOT NULL,
    name character varying(100) NOT NULL,
    CONSTRAINT chk_roles_name_not_blank CHECK ((length(TRIM(BOTH FROM name)) > 0))
);


--
-- TOC entry 280 (class 1259 OID 16850)
-- Name: roles_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.roles_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 4725 (class 0 OID 0)
-- Dependencies: 280
-- Name: roles_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.roles_id_seq OWNED BY public.roles.id;


--
-- TOC entry 281 (class 1259 OID 16851)
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
-- TOC entry 282 (class 1259 OID 16855)
-- Name: teacher_course_assignments_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.teacher_course_assignments_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 4726 (class 0 OID 0)
-- Dependencies: 282
-- Name: teacher_course_assignments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.teacher_course_assignments_id_seq OWNED BY public.teacher_course_assignments.id;


--
-- TOC entry 283 (class 1259 OID 16856)
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
-- TOC entry 284 (class 1259 OID 16864)
-- Name: teachers_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.teachers_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 4727 (class 0 OID 0)
-- Dependencies: 284
-- Name: teachers_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.teachers_id_seq OWNED BY public.teachers.id;


--
-- TOC entry 293 (class 1259 OID 62708)
-- Name: user_oauth_accounts; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.user_oauth_accounts (
    id bigint NOT NULL,
    created_at timestamp(6) with time zone NOT NULL,
    provider character varying(50) NOT NULL,
    provider_account_id character varying(255) NOT NULL,
    user_id bigint NOT NULL
);


--
-- TOC entry 292 (class 1259 OID 62707)
-- Name: user_oauth_accounts_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.user_oauth_accounts ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.user_oauth_accounts_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 285 (class 1259 OID 16865)
-- Name: user_roles; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.user_roles (
    user_id bigint NOT NULL,
    role_id bigint NOT NULL
);


--
-- TOC entry 286 (class 1259 OID 16868)
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
    avatar_public_id character varying(255),
    avatar_url character varying(255),
    CONSTRAINT chk_users_email_not_blank CHECK ((length(TRIM(BOTH FROM email)) > 0)),
    CONSTRAINT chk_users_username_not_blank CHECK ((length(TRIM(BOTH FROM username)) > 0))
);


--
-- TOC entry 287 (class 1259 OID 16878)
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 4728 (class 0 OID 0)
-- Dependencies: 287
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- TOC entry 288 (class 1259 OID 16879)
-- Name: wallet_transactions; Type: TABLE; Schema: public; Owner: -
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


--
-- TOC entry 289 (class 1259 OID 16887)
-- Name: wallet_transactions_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.wallet_transactions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 4729 (class 0 OID 0)
-- Dependencies: 289
-- Name: wallet_transactions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.wallet_transactions_id_seq OWNED BY public.wallet_transactions.id;


--
-- TOC entry 290 (class 1259 OID 16888)
-- Name: wallets; Type: TABLE; Schema: public; Owner: -
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


--
-- TOC entry 291 (class 1259 OID 16896)
-- Name: wallets_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.wallets_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 4730 (class 0 OID 0)
-- Dependencies: 291
-- Name: wallets_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.wallets_id_seq OWNED BY public.wallets.id;


--
-- TOC entry 4002 (class 2604 OID 16897)
-- Name: cart_items id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.cart_items ALTER COLUMN id SET DEFAULT nextval('public.cart_items_id_seq'::regclass);


--
-- TOC entry 4005 (class 2604 OID 16898)
-- Name: carts id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.carts ALTER COLUMN id SET DEFAULT nextval('public.carts_id_seq'::regclass);


--
-- TOC entry 4008 (class 2604 OID 16899)
-- Name: categories id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.categories ALTER COLUMN id SET DEFAULT nextval('public.categories_id_seq'::regclass);


--
-- TOC entry 4011 (class 2604 OID 16900)
-- Name: chapters id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.chapters ALTER COLUMN id SET DEFAULT nextval('public.chapters_id_seq'::regclass);


--
-- TOC entry 4016 (class 2604 OID 16901)
-- Name: completed_lessons_count id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.completed_lessons_count ALTER COLUMN id SET DEFAULT nextval('public.completed_lessons_count_id_seq'::regclass);


--
-- TOC entry 4019 (class 2604 OID 16902)
-- Name: contest_participants id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.contest_participants ALTER COLUMN id SET DEFAULT nextval('public.contest_participants_id_seq'::regclass);


--
-- TOC entry 4026 (class 2604 OID 16903)
-- Name: contest_problems id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.contest_problems ALTER COLUMN id SET DEFAULT nextval('public.contest_problems_id_seq'::regclass);


--
-- TOC entry 4037 (class 2604 OID 16904)
-- Name: contests id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.contests ALTER COLUMN id SET DEFAULT nextval('public.contests_id_seq'::regclass);


--
-- TOC entry 4042 (class 2604 OID 16905)
-- Name: course_reviews id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.course_reviews ALTER COLUMN id SET DEFAULT nextval('public.course_reviews_id_seq'::regclass);


--
-- TOC entry 4056 (class 2604 OID 16906)
-- Name: courses id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.courses ALTER COLUMN id SET DEFAULT nextval('public.courses_id_seq'::regclass);


--
-- TOC entry 4062 (class 2604 OID 16907)
-- Name: enrollments id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.enrollments ALTER COLUMN id SET DEFAULT nextval('public.enrollments_id_seq'::regclass);


--
-- TOC entry 4064 (class 2604 OID 16910)
-- Name: invalidated_tokens id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.invalidated_tokens ALTER COLUMN id SET DEFAULT nextval('public.invalidated_tokens_id_seq'::regclass);


--
-- TOC entry 4067 (class 2604 OID 16911)
-- Name: lesson_comments id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.lesson_comments ALTER COLUMN id SET DEFAULT nextval('public.lesson_comments_id_seq'::regclass);


--
-- TOC entry 4071 (class 2604 OID 16912)
-- Name: lesson_problems id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.lesson_problems ALTER COLUMN id SET DEFAULT nextval('public.lesson_problems_id_seq'::regclass);


--
-- TOC entry 4073 (class 2604 OID 16913)
-- Name: lesson_progress id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.lesson_progress ALTER COLUMN id SET DEFAULT nextval('public.lesson_progress_id_seq'::regclass);


--
-- TOC entry 4078 (class 2604 OID 16914)
-- Name: lessons id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.lessons ALTER COLUMN id SET DEFAULT nextval('public.lessons_id_seq'::regclass);


--
-- TOC entry 4092 (class 2604 OID 16915)
-- Name: online_judge_problems id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.online_judge_problems ALTER COLUMN id SET DEFAULT nextval('public.online_judge_problems_id_seq'::regclass);


--
-- TOC entry 4097 (class 2604 OID 16916)
-- Name: online_judge_submission_details id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.online_judge_submission_details ALTER COLUMN id SET DEFAULT nextval('public.online_judge_submission_details_id_seq'::regclass);


--
-- TOC entry 4100 (class 2604 OID 16917)
-- Name: online_judge_submissions id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.online_judge_submissions ALTER COLUMN id SET DEFAULT nextval('public.online_judge_submissions_id_seq'::regclass);


--
-- TOC entry 4106 (class 2604 OID 16918)
-- Name: order_items id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.order_items ALTER COLUMN id SET DEFAULT nextval('public.order_items_id_seq'::regclass);


--
-- TOC entry 4111 (class 2604 OID 16919)
-- Name: orders id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.orders ALTER COLUMN id SET DEFAULT nextval('public.orders_id_seq'::regclass);


--
-- TOC entry 4115 (class 2604 OID 16920)
-- Name: payment_transactions id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.payment_transactions ALTER COLUMN id SET DEFAULT nextval('public.payment_transactions_id_seq'::regclass);


--
-- TOC entry 4116 (class 2604 OID 16921)
-- Name: permissions id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.permissions ALTER COLUMN id SET DEFAULT nextval('public.permissions_id_seq'::regclass);


--
-- TOC entry 4118 (class 2604 OID 16922)
-- Name: problem_tag_mappings id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.problem_tag_mappings ALTER COLUMN id SET DEFAULT nextval('public.problem_tag_mappings_id_seq'::regclass);


--
-- TOC entry 4121 (class 2604 OID 16923)
-- Name: problem_tags id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.problem_tags ALTER COLUMN id SET DEFAULT nextval('public.problem_tags_id_seq'::regclass);


--
-- TOC entry 4125 (class 2604 OID 16924)
-- Name: problem_testcases id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.problem_testcases ALTER COLUMN id SET DEFAULT nextval('public.problem_testcases_id_seq'::regclass);


--
-- TOC entry 4127 (class 2604 OID 16925)
-- Name: quiz_attempt_answers id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.quiz_attempt_answers ALTER COLUMN id SET DEFAULT nextval('public.quiz_attempt_answers_id_seq'::regclass);


--
-- TOC entry 4131 (class 2604 OID 16926)
-- Name: quiz_attempts id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.quiz_attempts ALTER COLUMN id SET DEFAULT nextval('public.quiz_attempts_id_seq'::regclass);


--
-- TOC entry 4136 (class 2604 OID 16927)
-- Name: quiz_options id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.quiz_options ALTER COLUMN id SET DEFAULT nextval('public.quiz_options_id_seq'::regclass);


--
-- TOC entry 4139 (class 2604 OID 16928)
-- Name: quiz_questions id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.quiz_questions ALTER COLUMN id SET DEFAULT nextval('public.quiz_questions_id_seq'::regclass);


--
-- TOC entry 4145 (class 2604 OID 16929)
-- Name: quizzes id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.quizzes ALTER COLUMN id SET DEFAULT nextval('public.quizzes_id_seq'::regclass);


--
-- TOC entry 4148 (class 2604 OID 16930)
-- Name: refresh_tokens id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.refresh_tokens ALTER COLUMN id SET DEFAULT nextval('public.refresh_tokens_id_seq'::regclass);


--
-- TOC entry 4149 (class 2604 OID 16931)
-- Name: roles id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.roles ALTER COLUMN id SET DEFAULT nextval('public.roles_id_seq'::regclass);


--
-- TOC entry 4152 (class 2604 OID 16932)
-- Name: teacher_course_assignments id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.teacher_course_assignments ALTER COLUMN id SET DEFAULT nextval('public.teacher_course_assignments_id_seq'::regclass);


--
-- TOC entry 4156 (class 2604 OID 16933)
-- Name: teachers id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.teachers ALTER COLUMN id SET DEFAULT nextval('public.teachers_id_seq'::regclass);


--
-- TOC entry 4160 (class 2604 OID 16934)
-- Name: users id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- TOC entry 4166 (class 2604 OID 16935)
-- Name: wallet_transactions id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.wallet_transactions ALTER COLUMN id SET DEFAULT nextval('public.wallet_transactions_id_seq'::regclass);


--
-- TOC entry 4171 (class 2604 OID 16936)
-- Name: wallets id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.wallets ALTER COLUMN id SET DEFAULT nextval('public.wallets_id_seq'::regclass);



-- Completed on 2026-07-23 17:21:34 +07

--
-- PostgreSQL database dump complete
--