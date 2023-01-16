--
-- PostgreSQL database dump
--

-- Dumped from database version 12.13 (Ubuntu 12.13-1.pgdg22.04+1)
-- Dumped by pg_dump version 14.2

-- Started on 2023-01-15 10:23:47

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
-- TOC entry 221 (class 1255 OID 42596)
-- Name: plpgsql_call_handler(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.plpgsql_call_handler() RETURNS language_handler
    LANGUAGE c
    AS '$libdir/plpgsql', 'plpgsql_call_handler';


ALTER FUNCTION public.plpgsql_call_handler() OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 202 (class 1259 OID 42597)
-- Name: accounts; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.accounts (
    id integer NOT NULL,
    username character varying(32),
    password character varying(32),
    realname character varying(32),
    worldserver integer DEFAULT 0,
    use_charpassword BOOLEAN DEFAULT false,
    charpassword character varying(32),
    state integer DEFAULT 0,
    char_max_num integer DEFAULT 3
);


ALTER TABLE public.accounts OWNER TO postgres;

--
-- TOC entry 205 (class 1259 OID 42611)
-- Name: character_number; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.character_number (
    account_id integer NOT NULL,
    world_id integer NOT NULL,
    "character" integer DEFAULT 0 NOT NULL,
    first_ch_create_time timestamp without time zone
);


ALTER TABLE public.character_number OWNER TO postgres;

--
-- TOC entry 206 (class 1259 OID 42615)
-- Name: configuration; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.configuration (
    schema_version integer NOT NULL,
    login_version character varying(32)
);


ALTER TABLE public.configuration OWNER TO postgres;

--
-- TOC entry 207 (class 1259 OID 42618)
-- Name: crashlog; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.crashlog (
    host character(20) NOT NULL,
    process character(30),
    eth0 character varying(15) NOT NULL,
    eth1 character varying(15),
    regdate timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.crashlog OWNER TO postgres;

--
-- TOC entry 208 (class 1259 OID 42622)
-- Name: crashmonitor; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.crashmonitor (
    host character varying(20) NOT NULL,
    daemon character varying(100) NOT NULL,
    process character varying(100) NOT NULL,
    status smallint DEFAULT 0,
    eth0 character varying(15) NOT NULL,
    eth1 character varying(15),
    regdate timestamp with time zone DEFAULT now()
);


ALTER TABLE public.crashmonitor OWNER TO postgres;

--
-- TOC entry 209 (class 1259 OID 42627)
-- Name: exchange_pin; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.exchange_pin (
    pin character varying(16) NOT NULL,
    password character varying(16) NOT NULL,
    rule_id integer DEFAULT '-1'::integer,
    state character varying(16) DEFAULT 'create'::character varying,
    zoneserver_id integer DEFAULT '-1'::integer,
    account_id integer DEFAULT '-1'::integer,
    character_id integer DEFAULT '-1'::integer,
    log_time timestamp without time zone,
    pin_set integer DEFAULT '-1'::integer
);


ALTER TABLE public.exchange_pin OWNER TO postgres;

--
-- TOC entry 210 (class 1259 OID 42636)
-- Name: exchange_rule; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.exchange_rule (
    id integer NOT NULL,
    item_id integer DEFAULT '-1'::integer,
    item_num integer DEFAULT 0,
    rate integer DEFAULT 0,
    set integer DEFAULT 0
);


ALTER TABLE public.exchange_rule OWNER TO postgres;

--
-- TOC entry 211 (class 1259 OID 42643)
-- Name: fortune_bag; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.fortune_bag (
    id integer NOT NULL,
    sequence smallint NOT NULL,
    set integer NOT NULL,
    item_id integer NOT NULL,
    item_num integer NOT NULL,
    probability real NOT NULL,
    bulletin integer NOT NULL,
    white real NOT NULL,
    green real NOT NULL,
    blue real NOT NULL,
    yellow real NOT NULL,
    note text DEFAULT ''::text
);


ALTER TABLE public.fortune_bag OWNER TO postgres;

--
-- TOC entry 212 (class 1259 OID 42650)
-- Name: gm_tool_accounts; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.gm_tool_accounts (
    id integer NOT NULL,
    account_name character varying(32),
    password character varying(32),
    privilege integer DEFAULT 0
);


ALTER TABLE public.gm_tool_accounts OWNER TO postgres;

--
-- TOC entry 204 (class 1259 OID 42607)
-- Name: high_lottery; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.high_lottery (
    lottery_id integer NOT NULL,
    item_index integer NOT NULL,
    week integer NOT NULL,
    round integer NOT NULL,
    item_id integer NOT NULL,
    item_amount integer NOT NULL,
    probability double precision NOT NULL,
    num_replay integer NOT NULL,
    bulletin integer NOT NULL,
    probability_plus1 double precision NOT NULL,
    probability_plus2 double precision NOT NULL,
    probability_plus3 double precision NOT NULL
);


ALTER TABLE public.high_lottery OWNER TO postgres;

--
-- TOC entry 213 (class 1259 OID 42654)
-- Name: item_receipt; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.item_receipt (
    id integer NOT NULL,
    purchase_time timestamp(6) without time zone NOT NULL,
    receieved_time timestamp(6) without time zone DEFAULT now(),
    account_name character varying(20) DEFAULT ''::character varying,
    item_id integer DEFAULT '-1'::integer NOT NULL,
    item_quantity integer DEFAULT '-1'::integer NOT NULL,
    point integer DEFAULT '-1'::integer,
    amount integer,
    world_id integer DEFAULT '-1'::integer,
    player_name character varying(32) DEFAULT ''::character varying,
    unique_id integer DEFAULT '-1'::integer,
    create_time integer DEFAULT '-1'::integer,
    mail_name character varying(32)
);


ALTER TABLE public.item_receipt OWNER TO postgres;

--
-- TOC entry 214 (class 1259 OID 42666)
-- Name: item_receivable; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.item_receivable (
    id integer NOT NULL,
    state smallint DEFAULT 1 NOT NULL,
    purchase_time timestamp without time zone DEFAULT now(),
    receivable_time timestamp without time zone DEFAULT now(),
    account_name character varying(20) DEFAULT ''::character varying,
    item_id integer DEFAULT '-1'::integer NOT NULL,
    item_quantity smallint DEFAULT '-1'::integer NOT NULL,
    world_id integer DEFAULT '-1'::integer,
    player_name character varying(32) DEFAULT ''::character varying,
    point integer DEFAULT '-1'::integer,
    amount integer DEFAULT 1,
    mail_name character varying(32),
    money_type integer
);


ALTER TABLE public.item_receivable OWNER TO postgres;

--
-- TOC entry 215 (class 1259 OID 42679)
-- Name: item_receivable_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.item_receivable_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.item_receivable_id_seq OWNER TO postgres;

--
-- TOC entry 3130 (class 0 OID 0)
-- Dependencies: 215
-- Name: item_receivable_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.item_receivable_id_seq OWNED BY public.item_receivable.id;


--
-- TOC entry 216 (class 1259 OID 42681)
-- Name: itemmall; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.itemmall (
    item_id integer NOT NULL,
    item_group integer NOT NULL,
    item_index integer NOT NULL,
    item_num integer NOT NULL,
    money_unit integer NOT NULL,
    point integer NOT NULL,
    special_price integer NOT NULL,
    sell integer NOT NULL,
    not_sell_date integer NOT NULL,
    fortune_bag text DEFAULT ''::text,
    note text DEFAULT ''::text
);


ALTER TABLE public.itemmall OWNER TO postgres;

--
-- TOC entry 220 (class 1259 OID 42946)
-- Name: itemmall_limit_amount; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.itemmall_limit_amount (
    account_id integer NOT NULL,
    sell_amount integer NOT NULL,
    item_id integer NOT NULL,
    item_group integer NOT NULL,
    item_index integer NOT NULL,
    item_num integer NOT NULL,
    money_unit integer NOT NULL
);


ALTER TABLE public.itemmall_limit_amount OWNER TO postgres;

--
-- TOC entry 217 (class 1259 OID 42689)
-- Name: itemmall_old; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.itemmall_old (
    item_id integer NOT NULL,
    item_group character varying(32) DEFAULT ''::character varying NOT NULL,
    item_index integer NOT NULL,
    item_num integer NOT NULL,
    point integer NOT NULL,
    sell integer NOT NULL,
    note text DEFAULT ''::text
);


ALTER TABLE public.itemmall_old OWNER TO postgres;

--
-- TOC entry 203 (class 1259 OID 42603)
-- Name: lottery; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.lottery (
    lottery_id integer NOT NULL,
    item_index integer NOT NULL,
    week integer NOT NULL,
    round integer NOT NULL,
    item_id integer NOT NULL,
    item_amount integer NOT NULL,
    probability double precision NOT NULL,
    num_replay integer NOT NULL,
    bulletin integer NOT NULL,
    probability_plus1 double precision NOT NULL,
    probability_plus2 double precision NOT NULL,
    probability_plus3 double precision NOT NULL
);


ALTER TABLE public.lottery OWNER TO postgres;

--
-- TOC entry 218 (class 1259 OID 42697)
-- Name: worlds; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.worlds (
    id integer DEFAULT nextval(('"worlds_id_seq"'::text)::regclass) NOT NULL,
    name character varying(32),
    ip character varying(15),
    port integer DEFAULT 5200,
    online_user integer DEFAULT 0,
    maxnum_user integer DEFAULT 1000 NOT NULL,
    state integer DEFAULT 0,
    version character varying(32),
    show_order integer DEFAULT 0
);


ALTER TABLE public.worlds OWNER TO postgres;

--
-- TOC entry 219 (class 1259 OID 42706)
-- Name: worlds_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.worlds_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.worlds_id_seq OWNER TO postgres;

--
-- TOC entry 2939 (class 2604 OID 42708)
-- Name: item_receivable id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.item_receivable ALTER COLUMN id SET DEFAULT nextval('public.item_receivable_id_seq'::regclass);


--
-- TOC entry 3105 (class 0 OID 42597)
-- Dependencies: 202
-- Data for Name: accounts; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.accounts (id, username, password, realname, worldserver, state, char_max_num) FROM stdin;
\.


--
-- TOC entry 3108 (class 0 OID 42611)
-- Dependencies: 205
-- Data for Name: character_number; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.character_number (account_id, world_id, "character", first_ch_create_time) FROM stdin;
\.


--
-- TOC entry 3109 (class 0 OID 42615)
-- Dependencies: 206
-- Data for Name: configuration; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.configuration (schema_version, login_version) FROM stdin;
812300000	Unknown_Version(Login)
\.


--
-- TOC entry 3110 (class 0 OID 42618)
-- Dependencies: 207
-- Data for Name: crashlog; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.crashlog (host, process, eth0, eth1, regdate) FROM stdin;
\.


--
-- TOC entry 3111 (class 0 OID 42622)
-- Dependencies: 208
-- Data for Name: crashmonitor; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.crashmonitor (host, daemon, process, status, eth0, eth1, regdate) FROM stdin;
\.


--
-- TOC entry 3112 (class 0 OID 42627)
-- Dependencies: 209
-- Data for Name: exchange_pin; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.exchange_pin (pin, password, rule_id, state, zoneserver_id, account_id, character_id, log_time, pin_set) FROM stdin;
\.


--
-- TOC entry 3113 (class 0 OID 42636)
-- Dependencies: 210
-- Data for Name: exchange_rule; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.exchange_rule (id, item_id, item_num, rate, set) FROM stdin;
\.


--
-- TOC entry 3114 (class 0 OID 42643)
-- Dependencies: 211
-- Data for Name: fortune_bag; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.fortune_bag (id, sequence, set, item_id, item_num, probability, bulletin, white, green, blue, yellow, note) FROM stdin;
49001	1	1	40159	1	1	1	0	0	0	0	
49001	2	1	40170	1	6	0	0	0	0	0	
49001	3	1	40021	2	3	0	0	0	0	0	
49001	4	1	40209	2	3	0	0	0	0	0	
49001	5	1	40211	2	3	0	0	0	0	0	
49001	6	1	40213	2	3	0	0	0	0	0	
49001	7	1	40215	2	3	0	0	0	0	0	
49001	8	1	40217	2	3	0	0	0	0	0	
49001	9	1	40202	7	5	0	0	0	0	0	
49001	10	1	40187	1	5	0	0	0	0	0	
49001	11	1	40020	3	5	0	0	0	0	0	
49001	12	1	40186	1	5	0	0	0	0	0	
49001	13	1	40019	5	5	0	0	0	0	0	
49001	14	1	40200	4	5	0	0	0	0	0	
49001	15	1	40039	120	4	0	0	0	0	0	
49001	16	1	40038	160	4	0	0	0	0	0	
49001	17	1	40034	120	5	0	0	0	0	0	
49001	18	1	40033	160	4	0	0	0	0	0	
49001	19	1	40035	95	5	0	0	0	0	0	
49001	20	1	40104	95	5	0	0	0	0	0	
49001	21	1	40190	5	2	0	0	0	0	0	
49001	22	1	40191	11	3	0	0	0	0	0	
49001	23	1	40192	11	3	0	0	0	0	0	
49001	24	1	40193	11	3	0	0	0	0	0	
49001	25	1	40183	22	3	0	0	0	0	0	
49001	26	1	40251	1	3	0	0	0	0	0	
49001	27	1	40226	1	1	1	0	0	0	0	
49002	1	1	40437	1	0.4	1	0	0	0	0	
49002	2	1	40441	1	2	0	0	0	0	0	
49002	3	1	40194	1	0.6	1	0	0	0	0	
49002	4	1	40197	1	2.4	0	0	0	0	0	
49002	5	1	40021	2	3	0	0	0	0	0	
49002	6	1	40209	2	3	0	0	0	0	0	
49002	7	1	40211	2	3	0	0	0	0	0	
49002	8	1	40213	2	3	0	0	0	0	0	
49002	9	1	40215	2	3	0	0	0	0	0	
49002	10	1	40217	2	3	0	0	0	0	0	
49002	11	1	40202	7	5	0	0	0	0	0	
49002	12	1	40187	1	5	0	0	0	0	0	
49002	13	1	40020	3	5	0	0	0	0	0	
49002	14	1	40186	1	5	0	0	0	0	0	
49002	15	1	40019	5	5	0	0	0	0	0	
49002	16	1	40200	4	4.6	0	0	0	0	0	
49002	17	1	40039	120	4	0	0	0	0	0	
49002	18	1	40038	160	5	0	0	0	0	0	
49002	19	1	40034	160	5	0	0	0	0	0	
49002	20	1	40033	160	4	0	0	0	0	0	
49002	21	1	40035	95	5	0	0	0	0	0	
49002	22	1	40104	95	5	0	0	0	0	0	
49002	23	1	40190	5	3	0	0	0	0	0	
49002	24	1	40191	11	3	0	0	0	0	0	
49002	25	1	40192	11	3	0	0	0	0	0	
49002	26	1	40193	11	3	0	0	0	0	0	
49002	27	1	40183	22	3	0	0	0	0	0	
49002	28	1	40251	1	3	0	0	0	0	0	
49002	29	1	40226	1	1	0	0	0	0	0	
49003	1	1	40195	1	0.3	1	0	0	0	0	
49003	2	1	40198	1	2	0	0	0	0	0	
49003	3	1	40021	2	3	0	0	0	0	0	
49003	4	1	40209	2	3	0	0	0	0	0	
49003	5	1	40211	2	3	0	0	0	0	0	
49003	6	1	40213	2	3	0	0	0	0	0	
49003	7	1	40215	2	3	0	0	0	0	0	
49003	8	1	40217	2	3	0	0	0	0	0	
49003	9	1	40202	7	5	0	0	0	0	0	
49003	10	1	40187	1	5	0	0	0	0	0	
49003	11	1	40020	3	5	0	0	0	0	0	
49003	12	1	40186	1	5	0	0	0	0	0	
49003	13	1	40019	5	5	0	0	0	0	0	
49003	14	1	40200	4	5	0	0	0	0	0	
49003	15	1	40039	120	4	0	0	0	0	0	
49003	16	1	40038	160	4	0	0	0	0	0	
49003	17	1	40034	160	4	0	0	0	0	0	
49003	18	1	40033	160	4	0	0	0	0	0	
49003	19	1	40035	95	5	0	0	0	0	0	
49003	20	1	40104	95	5	0	0	0	0	0	
49003	21	1	40190	5	3	0	0	0	0	0	
49003	22	1	40191	11	3	0	0	0	0	0	
49003	23	1	40192	11	4	0	0	0	0	0	
49003	24	1	40193	11	4	0	0	0	0	0	
49003	25	1	40183	22	5.7	0	0	0	0	0	
49003	26	1	40251	1	3.5	0	0	0	0	0	
49003	27	1	40226	1	0.5	0	0	0	0	0	
49004	1	1	40196	1	0.3	1	0	0	0	0	
49004	2	1	40199	1	2	0	0	0	0	0	
49004	3	1	40021	2	3	0	0	0	0	0	
49004	4	1	40209	2	3	0	0	0	0	0	
49004	5	1	40211	2	3	0	0	0	0	0	
49004	6	1	40213	2	3	0	0	0	0	0	
49004	7	1	40215	2	3	0	0	0	0	0	
49004	8	1	40217	2	3	0	0	0	0	0	
49004	9	1	40202	7	5	0	0	0	0	0	
49004	10	1	40187	1	5	0	0	0	0	0	
49004	11	1	40020	3	5	0	0	0	0	0	
49004	12	1	40186	1	5	0	0	0	0	0	
49004	13	1	40019	5	5	0	0	0	0	0	
49004	14	1	40200	4	5	0	0	0	0	0	
49004	15	1	40039	120	4	0	0	0	0	0	
49004	16	1	40038	160	4	0	0	0	0	0	
49004	17	1	40034	160	4	0	0	0	0	0	
49004	18	1	40033	160	4	0	0	0	0	0	
49004	19	1	40035	95	5	0	0	0	0	0	
49004	20	1	40104	95	5	0	0	0	0	0	
49004	21	1	40190	5	3	0	0	0	0	0	
49004	22	1	40191	11	3	0	0	0	0	0	
49004	23	1	40192	11	4	0	0	0	0	0	
49004	24	1	40193	11	4	0	0	0	0	0	
49004	25	1	40183	22	5.7	0	0	0	0	0	
49004	26	1	40251	1	3.5	0	0	0	0	0	
49004	27	1	40226	1	0.5	0	0	0	0	0	
49005	1	1	40160	1	2	0	0	0	0	0	
49005	2	1	40161	1	2	0	0	0	0	0	
49005	3	1	40162	1	2	0	0	0	0	0	
49005	4	1	40163	1	2	0	0	0	0	0	
49005	5	1	40171	1	4	0	0	0	0	0	
49005	6	1	40172	1	4	0	0	0	0	0	
49005	7	1	40173	1	4	0	0	0	0	0	
49005	8	1	40174	1	4	0	0	0	0	0	
49005	9	1	40182	1	5	0	0	0	0	0	
49005	10	1	40191	11	5	0	0	0	0	0	
49005	11	1	40192	11	5	0	0	0	0	0	
49005	12	1	40193	11	5	0	0	0	0	0	
49005	13	1	40181	3	5	0	0	0	0	0	
49005	14	1	40200	4	5	0	0	0	0	0	
49005	15	1	40039	120	5	0	0	0	0	0	
49005	16	1	40038	160	5	0	0	0	0	0	
49005	17	1	40034	160	5	0	0	0	0	0	
49005	18	1	40033	160	4	0	0	0	0	0	
49005	19	1	40035	95	5	0	0	0	0	0	
49005	20	1	40104	95	5	0	0	0	0	0	
49005	21	1	40190	5	5	0	0	0	0	0	
49005	22	1	40183	22	5	0	0	0	0	0	
49005	23	1	40251	1	3.5	0	0	0	0	0	
49005	24	1	40226	1	0.5	0	0	0	0	0	
49005	25	1	40188	1	3	0	0	0	0	0	
49014	1	1	40232	1	0.3	1	0	0	0	0	
49014	2	1	40257	1	2	0	0	0	0	0	
49014	3	1	40021	2	3	0	0	0	0	0	
49014	4	1	40209	2	3	0	0	0	0	0	
49014	5	1	40211	2	3	0	0	0	0	0	
49014	6	1	40213	2	3	0	0	0	0	0	
49014	7	1	40215	2	3	0	0	0	0	0	
49014	8	1	40217	2	3	0	0	0	0	0	
49014	9	1	40202	7	5	0	0	0	0	0	
49014	10	1	40187	1	5	0	0	0	0	0	
49014	11	1	40020	3	5	0	0	0	0	0	
49014	12	1	40186	1	5	0	0	0	0	0	
49014	13	1	40019	5	5	0	0	0	0	0	
49014	14	1	40200	4	5	0	0	0	0	0	
49014	15	1	40039	120	5	0	0	0	0	0	
49014	16	1	40038	160	5	0	0	0	0	0	
49014	17	1	40034	160	5	0	0	0	0	0	
49014	18	1	40033	160	5	0	0	0	0	0	
49014	19	1	40035	95	5	0	0	0	0	0	
49014	20	1	40104	95	5	0	0	0	0	0	
49014	21	1	40190	5	3	0	0	0	0	0	
49014	22	1	40191	11	3	0	0	0	0	0	
49014	23	1	40192	11	4	0	0	0	0	0	
49014	24	1	40193	11	4	0	0	0	0	0	
49014	25	1	40183	22	5.7	0	0	0	0	0	
49015	1	1	40233	1	1	1	0	0	0	0	
49015	2	1	40258	1	5	0	0	0	0	0	
49015	3	1	40021	2	3	0	0	0	0	0	
49015	4	1	40209	2	3	0	0	0	0	0	
49015	5	1	40211	2	3	0	0	0	0	0	
49015	6	1	40213	2	3	0	0	0	0	0	
49015	7	1	40215	2	3	0	0	0	0	0	
49015	8	1	40217	2	3	0	0	0	0	0	
49015	9	1	40202	7	5	0	0	0	0	0	
49015	10	1	40187	1	5	0	0	0	0	0	
49015	11	1	40020	3	5	0	0	0	0	0	
49015	12	1	40186	1	5	0	0	0	0	0	
49015	13	1	40019	5	5	0	0	0	0	0	
49015	14	1	40200	4	5	0	0	0	0	0	
49015	15	1	40039	120	5	0	0	0	0	0	
49015	16	1	40038	160	4	0	0	0	0	0	
49015	17	1	40034	160	5	0	0	0	0	0	
49015	18	1	40033	160	4	0	0	0	0	0	
49015	19	1	40035	95	5	0	0	0	0	0	
49015	20	1	40104	95	5	0	0	0	0	0	
49015	21	1	40190	5	3	0	0	0	0	0	
49015	22	1	40191	11	3	0	0	0	0	0	
49015	23	1	40192	11	4	0	0	0	0	0	
49015	24	1	40193	11	4	0	0	0	0	0	
49015	25	1	40183	22	4	0	0	0	0	0	
49016	1	1	40238	1	0.6	1	0	0	0	0	
49016	2	1	40263	1	2.4	0	0	0	0	0	
49016	3	1	40399	1	0.4	1	0	0	0	0	
49016	4	1	40402	1	2	0	0	0	0	0	
49016	5	1	40021	2	3	0	0	0	0	0	
49016	6	1	40209	2	3	0	0	0	0	0	
49016	7	1	40211	2	3	0	0	0	0	0	
49016	8	1	40213	2	3	0	0	0	0	0	
49016	9	1	40215	2	3	0	0	0	0	0	
49016	10	1	40217	2	3	0	0	0	0	0	
49016	11	1	40202	7	5	0	0	0	0	0	
49016	12	1	40187	1	5	0	0	0	0	0	
49016	13	1	40020	3	5	0	0	0	0	0	
49016	14	1	40186	1	5	0	0	0	0	0	
49016	15	1	40019	5	5	0	0	0	0	0	
49016	16	1	40200	4	5	0	0	0	0	0	
49016	17	1	40039	120	5	0	0	0	0	0	
49016	18	1	40038	160	4	0	0	0	0	0	
49016	19	1	40034	160	5	0	0	0	0	0	
49016	20	1	40033	160	4	0	0	0	0	0	
49016	21	1	40035	95	4	0	0	0	0	0	
49016	22	1	40104	95	4	0	0	0	0	0	
49016	23	1	40190	5	4	0	0	0	0	0	
49016	24	1	40191	11	3	0	0	0	0	0	
49016	25	1	40192	11	4	0	0	0	0	0	
49016	26	1	40193	11	4	0	0	0	0	0	
49016	27	1	40183	22	5.6	0	0	0	0	0	
49017	1	1	40230	1	1	1	0	0	0	0	
49017	2	1	40255	1	3	0	0	0	0	0	
49017	3	1	40246	1	2	0	0	0	0	0	
49017	4	1	40247	1	2	0	0	0	0	0	
49017	5	1	40236	1	1	1	0	0	0	0	
49017	6	1	40261	1	5	0	0	0	0	0	
49017	7	1	40237	1	1	1	0	0	0	0	
49017	8	1	40262	1	5	0	0	0	0	0	
49017	9	1	40242	1	3	0	0	0	0	0	
49017	10	1	40021	2	1	0	0	0	0	0	
49017	11	1	40209	2	1	0	0	0	0	0	
49017	12	1	40211	2	1	0	0	0	0	0	
49017	13	1	40213	2	1	0	0	0	0	0	
49017	14	1	40215	2	1	0	0	0	0	0	
49017	15	1	40217	2	1	0	0	0	0	0	
49017	16	1	40202	7	5	0	0	0	0	0	
49017	17	1	40187	1	5	0	0	0	0	0	
49017	18	1	40020	3	5	0	0	0	0	0	
49017	19	1	40186	1	5	0	0	0	0	0	
49017	20	1	40019	5	5	0	0	0	0	0	
49017	21	1	40200	4	5	0	0	0	0	0	
49017	22	1	40039	120	5	0	0	0	0	0	
49017	23	1	40038	160	4	0	0	0	0	0	
49017	24	1	40034	160	3	0	0	0	0	0	
49017	25	1	40033	160	4	0	0	0	0	0	
49017	26	1	40035	95	3	0	0	0	0	0	
49017	27	1	40104	95	3	0	0	0	0	0	
49017	28	1	40190	5	3	0	0	0	0	0	
49017	29	1	40191	11	4	0	0	0	0	0	
49017	30	1	40192	11	4	0	0	0	0	0	
49017	31	1	40193	11	4	0	0	0	0	0	
49017	32	1	40183	22	4	0	0	0	0	0	
49018	1	1	40189	1	2	0	0	0	0	0	
49018	2	1	40188	1	5	0	0	0	0	0	
49018	3	1	40187	1	5	0	0	0	0	0	
49018	4	1	40186	1	5	0	0	0	0	0	
49018	5	1	40184	1	1	0	0	0	0	0	
49018	6	1	40185	3	5	0	0	0	0	0	
49018	7	1	40183	5	2	0	0	0	0	0	
49018	8	1	40200	4	5	0	0	0	0	0	
49018	9	1	40201	1	2	0	0	0	0	0	
49018	10	1	40021	2	3	0	0	0	0	0	
49018	11	1	40020	3	5	0	0	0	0	0	
49018	12	1	40019	5	5	0	0	0	0	0	
49018	13	1	40209	2	1	0	0	0	0	0	
49018	14	1	40211	2	1	0	0	0	0	0	
49018	15	1	40213	2	1	0	0	0	0	0	
49018	16	1	40215	2	1	0	0	0	0	0	
49018	17	1	40217	2	1	0	0	0	0	0	
49018	18	1	40202	7	4	0	0	0	0	0	
49018	19	1	40105	80	4	0	0	0	0	0	
49018	20	1	40104	95	4	0	0	0	0	0	
49018	21	1	40039	120	4	0	0	0	0	0	
49018	22	1	40038	160	4	0	0	0	0	0	
49018	23	1	40036	80	4	0	0	0	0	0	
49018	24	1	40035	95	4	0	0	0	0	0	
49018	25	1	40034	160	4	0	0	0	0	0	
49018	26	1	40033	160	4	0	0	0	0	0	
49018	27	1	40190	5	5	0	0	0	0	0	
49018	28	1	40191	11	3	0	0	0	0	0	
49018	29	1	40192	11	3	0	0	0	0	0	
49018	30	1	40193	11	3	0	0	0	0	0	
49019	1	1	40044	1	2.5	0	0	0	0	0	
49019	2	1	40045	1	2.5	0	0	0	0	0	
49019	3	1	40046	1	2.5	0	0	0	0	0	
49019	4	1	40047	1	2.5	0	0	0	0	0	
49019	5	1	40048	1	2.5	0	0	0	0	0	
49019	6	1	40049	1	2.5	0	0	0	0	0	
49019	7	1	40050	1	2.5	0	0	0	0	0	
49019	8	1	40051	1	2.5	0	0	0	0	0	
49019	9	1	40052	1	2.9	0	0	0	0	0	
49019	10	1	40053	1	2.9	0	0	0	0	0	
49019	11	1	40056	1	2.9	0	0	0	0	0	
49019	12	1	40059	1	2.9	0	0	0	0	0	
49019	13	1	40055	1	2.8	0	0	0	0	0	
49019	14	1	40057	1	2.8	0	0	0	0	0	
49019	15	1	40058	1	2.8	0	0	0	0	0	
49019	16	1	40061	1	1	0	0	0	0	0	
49019	17	1	40063	1	1	0	0	0	0	0	
49019	18	1	40064	1	1	0	0	0	0	0	
49019	19	1	40065	1	1	0	0	0	0	0	
49019	20	1	40096	1	1	0	0	0	0	0	
49019	21	1	40097	1	1	0	0	0	0	0	
49019	22	1	40060	1	1.3	0	0	0	0	0	
49019	23	1	40062	1	1.3	0	0	0	0	0	
49019	24	1	40066	1	0.3	0	0	0	0	0	
49019	25	1	40067	1	0.3	0	0	0	0	0	
49019	26	1	40068	1	0.3	0	0	0	0	0	
49019	27	1	40069	1	0.3	0	0	0	0	0	
49019	28	1	40070	1	0.3	0	0	0	0	0	
49019	29	1	40071	1	0.3	0	0	0	0	0	
49019	30	1	40072	1	0.3	0	0	0	0	0	
49019	31	1	40073	1	0.3	0	0	0	0	0	
49019	32	1	40074	1	0.3	0	0	0	0	0	
49019	33	1	40075	1	0.3	0	0	0	0	0	
49019	34	1	40076	1	0.3	0	0	0	0	0	
49019	35	1	40077	1	0.3	0	0	0	0	0	
49019	36	1	40078	1	0.3	0	0	0	0	0	
49019	37	1	40079	1	0.3	0	0	0	0	0	
49019	38	1	40080	1	0.3	0	0	0	0	0	
49019	39	1	40081	1	0.3	0	0	0	0	0	
49019	40	1	40082	1	0.3	0	0	0	0	0	
49019	41	1	40083	1	0.3	0	0	0	0	0	
49019	42	1	40202	7	4	0	0	0	0	0	
49019	43	1	40105	80	4	0	0	0	0	0	
49019	44	1	40104	95	4	0	0	0	0	0	
49019	45	1	40039	120	4	0	0	0	0	0	
49019	46	1	40038	160	4	0	0	0	0	0	
49019	47	1	40036	80	4	0	0	0	0	0	
49019	48	1	40035	95	4	0	0	0	0	0	
49019	49	1	40034	160	3	0	0	0	0	0	
49019	50	1	40033	160	3	0	0	0	0	0	
49019	51	1	40190	5	3	0	0	0	0	0	
49019	52	1	40191	11	3	0	0	0	0	0	
49019	53	1	40192	11	3	0	0	0	0	0	
49019	54	1	40193	11	3	0	0	0	0	0	
49020	1	1	40040	12	6	0	0	0	0	0	
49020	2	1	40041	4	4	0	0	0	0	0	
49020	3	1	40042	5	5	0	0	0	0	0	
49020	4	1	40043	3	4	0	0	0	0	0	
49020	5	1	41082	1	3	0	0	0	0	0	
49020	6	1	41083	1	2	0	0	0	0	0	
49020	7	1	41085	3	6	0	0	0	0	0	
49020	8	1	41086	1	6	0	0	0	0	0	
49020	9	1	41087	3	6	0	0	0	0	0	
49020	10	1	41065	1	0.4	0	0	0	0	0	
49020	11	1	41066	1	0.4	0	0	0	0	0	
49020	12	1	41067	1	0.4	0	0	0	0	0	
49020	13	1	41068	1	0.4	0	0	0	0	0	
49020	14	1	41069	1	0.4	0	0	0	0	0	
49020	15	1	41070	1	0.4	0	0	0	0	0	
49020	16	1	41071	1	0.4	0	0	0	0	0	
49020	17	1	41072	1	0.4	0	0	0	0	0	
49020	18	1	41073	1	0.4	0	0	0	0	0	
49020	19	1	41074	1	0.4	0	0	0	0	0	
49020	20	1	41075	1	0.4	0	0	0	0	0	
49020	21	1	41077	1	0.4	0	0	0	0	0	
49020	22	1	41078	1	0.4	0	0	0	0	0	
49020	23	1	41079	1	0.4	0	0	0	0	0	
49020	24	1	41080	1	0.4	0	0	0	0	0	
49020	25	1	41081	1	3.5	0	0	0	0	0	
49020	26	1	40100	1	1	0	0	0	0	0	
49020	27	1	40101	1	1	0	0	0	0	0	
49020	28	1	40102	1	1	0	0	0	0	0	
49020	29	1	40103	1	1	0	0	0	0	0	
49020	30	1	40116	1	1	0	0	0	0	0	
49020	31	1	40124	1	1	0	0	0	0	0	
49020	32	1	40137	1	0.5	0	0	0	0	0	
49020	33	1	40138	1	0.5	0	0	0	0	0	
49020	34	1	40140	1	0.5	0	0	0	0	0	
49020	35	1	40141	1	0.5	0	0	0	0	0	
49020	36	1	40142	1	0.5	0	0	0	0	0	
49020	37	1	40105	80	5	0	0	0	0	0	
49020	38	1	40104	95	5	0	0	0	0	0	
49020	39	1	40039	120	5	0	0	0	0	0	
49020	40	1	40038	160	5	0	0	0	0	0	
49020	41	1	40036	80	5	0	0	0	0	0	
49020	42	1	40035	95	5	0	0	0	0	0	
49020	43	1	40034	160	5	0	0	0	0	0	
49020	44	1	40033	160	5	0	0	0	0	0	
49021	1	1	40222	1	1	1	0	0	0	0	
49021	2	1	40113	1	2.5	0	0	0	0	0	
49021	3	1	40112	1	1	0	0	0	0	0	
49021	4	1	40022	2	2	0	0	0	0	0	
49021	5	1	40021	2	2	0	0	0	0	0	
49021	6	1	40020	3	3	0	0	0	0	0	
49021	7	1	40019	5	3	0	0	0	0	0	
49021	8	1	40226	1	1	0	0	0	0	0	
49021	9	1	40251	1	3	0	0	0	0	0	
49021	10	1	41089	1	2	0	0	0	0	0	
49021	11	1	40122	10	2	0	0	0	0	0	
49021	12	1	41088	45	3	0	0	0	0	0	
49021	13	1	40190	5	3	0	0	0	0	0	
49021	14	1	40191	11	3	0	0	0	0	0	
49021	15	1	40192	11	3	0	0	0	0	0	
49021	16	1	40193	11	3	0	0	0	0	0	
49021	17	1	40023	4	2	0	0	0	0	0	
49021	18	1	40024	2	2	0	0	0	0	0	
49021	19	1	40025	2	2	0	0	0	0	0	
49021	20	1	40026	2	2	0	0	0	0	0	
49021	21	1	40027	2	2	0	0	0	0	0	
49021	22	1	40028	2	2	0	0	0	0	0	
49021	23	1	40029	2	2	0	0	0	0	0	
49021	24	1	40030	2	2	0	0	0	0	0	
49021	25	1	40031	2	2	0	0	0	0	0	
49021	26	1	40032	2	2	0	0	0	0	0	
49021	27	1	40156	4	3	0	0	0	0	0	
49021	28	1	40157	2	1	0	0	0	0	0	
49021	29	1	40181	3	2.5	0	0	0	0	0	
49021	30	1	40105	80	3	0	0	0	0	0	
49021	31	1	40104	95	3	0	0	0	0	0	
49021	32	1	40039	120	3	0	0	0	0	0	
49021	33	1	40038	160	3	0	0	0	0	0	
49021	34	1	40036	80	2	0	0	0	0	0	
49021	35	1	40035	95	3	0	0	0	0	0	
49021	36	1	40034	160	3	0	0	0	0	0	
49021	37	1	40033	160	2	0	0	0	0	0	
49021	38	1	40223	1	2	0	0	0	0	0	
49021	39	1	40224	1	2	0	0	0	0	0	
49021	40	1	40225	1	2	0	0	0	0	0	
49021	41	1	40227	1	2	0	0	0	0	0	
49021	42	1	40228	1	2	0	0	0	0	0	
49021	43	1	40229	1	2	0	0	0	0	0	
49021	44	1	40231	1	2	0	0	0	0	0	
49022	1	1	40267	1	2.5	1	0	0	0	0	
49022	2	1	40268	1	0.5	1	0	0	0	0	
49022	3	1	40271	1	5	0	0	0	0	0	
49022	4	1	40272	1	3	0	0	0	0	0	
49022	5	1	40021	2	3	0	0	0	0	0	
49022	6	1	40209	2	3	0	0	0	0	0	
49022	5	1	40211	2	3	0	0	0	0	0	
49022	6	1	40213	2	3	0	0	0	0	0	
49022	7	1	40215	2	3	0	0	0	0	0	
49022	8	1	40217	2	3	0	0	0	0	0	
49022	9	1	40202	7	4	0	0	0	0	0	
49022	10	1	40187	1	4	0	0	0	0	0	
49022	11	1	40020	3	4	0	0	0	0	0	
49022	12	1	40186	1	4	0	0	0	0	0	
49022	13	1	40019	5	4	0	0	0	0	0	
49022	14	1	40200	4	4	0	0	0	0	0	
49022	15	1	40039	120	4	0	0	0	0	0	
49022	16	1	40038	160	4	0	0	0	0	0	
49022	17	1	40034	160	5	0	0	0	0	0	
49022	18	1	40033	160	5	0	0	0	0	0	
49022	19	1	40035	95	5	0	0	0	0	0	
49022	20	1	40104	95	5	0	0	0	0	0	
49022	21	1	40190	5	3	0	0	0	0	0	
49022	22	1	40191	11	4	0	0	0	0	0	
49022	23	1	40192	11	4	0	0	0	0	0	
49022	24	1	40193	11	4	0	0	0	0	0	
49022	25	1	40183	22	4	0	0	0	0	0	
49023	1	1	30781	100	9	0	0	0	0	0	
49023	2	1	30782	100	7	0	0	0	0	0	
49023	3	1	30783	50	3	0	0	0	0	0	
49023	4	1	30786	100	9	0	0	0	0	0	
49023	5	1	30787	100	7	0	0	0	0	0	
49023	6	1	30788	50	3	0	0	0	0	0	
49023	7	1	30791	100	9	0	0	0	0	0	
49023	8	1	30792	100	7	0	0	0	0	0	
49023	9	1	30793	50	3	0	0	0	0	0	
49023	10	1	30796	50	1	0	0	0	0	0	
49023	11	1	30799	100	4	0	0	0	0	0	
49023	12	1	30800	50	2	0	0	0	0	0	
49023	13	1	30814	50	3	0	0	0	0	0	
49023	14	1	30815	50	2	0	0	0	0	0	
49023	15	1	30829	50	4	0	0	0	0	0	
49023	16	1	30830	50	2	0	0	0	0	0	
49023	17	1	30844	50	1	0	0	0	0	0	
49023	18	1	40039	160	2	0	0	0	0	0	
49023	19	1	40038	210	2	0	0	0	0	0	
49023	20	1	40034	160	2	0	0	0	0	0	
49023	21	1	40033	210	2	0	0	0	0	0	
49023	22	1	40035	130	2	0	0	0	0	0	
49023	23	1	40104	130	2	0	0	0	0	0	
49023	24	1	40211	3	3	0	0	0	0	0	
49023	25	1	40213	3	3	0	0	0	0	0	
49023	26	1	40215	3	3	0	0	0	0	0	
49023	27	1	40217	3	3	0	0	0	0	0	
49024	1	1	31539	1	2	0	0	0	0	0	
49024	2	1	31540	1	2	0	0	0	0	0	
49024	3	1	31541	1	1	0	0	0	0	0	
49024	4	1	31548	1	1	0	0	0	0	0	
49024	5	1	31549	1	2	0	0	0	0	0	
49024	6	1	31550	1	2	0	0	0	0	0	
49024	7	1	31513	1	1	0	0	0	0	0	
49024	8	1	31514	1	2	0	0	0	0	0	
49024	9	1	31515	1	1	0	0	0	0	0	
49024	10	1	31516	1	1	0	0	0	0	0	
49024	11	1	31517	1	1	0	0	0	0	0	
49024	12	1	31518	1	1	0	0	0	0	0	
49024	13	1	31510	20	5	0	0	0	0	0	
49024	14	1	31592	1	3	0	0	0	0	0	
49024	15	1	31593	1	3	0	0	0	0	0	
49024	16	1	31594	1	3	0	0	0	0	0	
49024	17	1	31583	1	3	0	0	0	0	0	
49024	18	1	31584	1	3	0	0	0	0	0	
49024	19	1	31585	1	3	0	0	0	0	0	
49024	20	1	31511	10	6	0	0	0	0	0	
49024	21	1	31512	10	6	0	0	0	0	0	
49024	22	1	40039	250	8	0	0	0	0	0	
49024	23	1	40038	330	8	0	0	0	0	0	
49024	24	1	40034	250	8	0	0	0	0	0	
49024	25	1	40033	330	8	0	0	0	0	0	
49024	26	1	40035	200	8	0	0	0	0	0	
49024	27	1	40104	200	8	0	0	0	0	0	
49025	1	1	40118	1	100	0	0	0	0	0	
49025	1	2	40136	1	100	0	0	0	0	0	
49026	1	1	40121	1	100	0	0	0	0	0	
49026	1	2	40137	1	100	0	0	0	0	0	
49027	1	1	40123	1	100	0	0	0	0	0	
49027	1	2	40139	1	100	0	0	0	0	0	
49028	1	1	40124	1	100	0	0	0	0	0	
49028	1	2	40142	1	100	0	0	0	0	0	
49029	1	1	40125	1	100	0	0	0	0	0	
49029	1	2	40143	1	100	0	0	0	0	0	
49030	1	1	40130	1	100	0	0	0	0	0	
49030	1	2	40245	1	100	0	0	0	0	0	
49031	1	1	40241	1	100	0	0	0	0	0	
49031	1	2	40244	1	100	0	0	0	0	0	
49032	1	1	40126	1	0.5	0	0	0	0	0	
49032	2	1	40127	1	0.5	0	0	0	0	0	
49032	3	1	40128	1	0.5	0	0	0	0	0	
49032	4	1	40129	1	0.5	0	0	0	0	0	
49032	5	1	40148	1	0.5	0	0	0	0	0	
49032	6	1	40149	1	0.5	0	0	0	0	0	
49032	7	1	40150	1	0.5	0	0	0	0	0	
49032	8	1	40151	1	0.5	0	0	0	0	0	
49032	9	1	40275	1	2	0	0	0	0	0	
49032	10	1	40276	1	2	0	0	0	0	0	
49032	11	1	40277	1	2	0	0	0	0	0	
49032	12	1	40278	1	2	0	0	0	0	0	
49032	13	1	40288	1	2	0	0	0	0	0	
49032	14	1	40289	1	2	0	0	0	0	0	
49032	15	1	40290	1	2	0	0	0	0	0	
49032	16	1	40291	1	2	0	0	0	0	0	
49032	17	1	40040	12	5	0	0	0	0	0	
49032	18	1	40041	4	3	0	0	0	0	0	
49032	19	1	40042	5	5	0	0	0	0	0	
49032	20	1	40043	3	3	0	0	0	0	0	
49032	21	1	41082	1	3	0	0	0	0	0	
49032	22	1	41083	1	2	0	0	0	0	0	
49032	23	1	41085	3	4	0	0	0	0	0	
49032	24	1	41086	1	3	0	0	0	0	0	
49032	25	1	41087	3	4	0	0	0	0	0	
49032	26	1	40104	95	4	0	0	0	0	0	
49032	27	1	40039	120	4	0	0	0	0	0	
49032	28	1	40038	160	4	0	0	0	0	0	
49032	29	1	40035	95	4	0	0	0	0	0	
49032	30	1	40034	160	4	0	0	0	0	0	
49032	31	1	40033	160	5	0	0	0	0	0	
49032	32	1	40190	5	3	0	0	0	0	0	
49032	33	1	40191	11	4	0	0	0	0	0	
49032	34	1	40192	11	4	0	0	0	0	0	
49032	35	1	40193	11	4	0	0	0	0	0	
49032	36	1	40021	2	2	0	0	0	0	0	
49032	37	1	40020	3	3	0	0	0	0	0	
49032	38	1	40019	5	3	0	0	0	0	0	
49033	1	1	40131	1	0.5	0	0	0	0	0	
49033	2	1	40132	1	0.5	0	0	0	0	0	
49033	3	1	40133	1	0.5	0	0	0	0	0	
49033	4	1	40134	1	0.5	0	0	0	0	0	
49033	5	1	40135	1	0.5	0	0	0	0	0	
49033	6	1	40144	1	0.5	0	0	0	0	0	
49033	7	1	40145	1	0.5	0	0	0	0	0	
49033	8	1	40146	1	0.5	0	0	0	0	0	
49033	9	1	40147	1	0.5	0	0	0	0	0	
49033	10	1	40279	1	2	0	0	0	0	0	
49033	11	1	40280	1	1.5	0	0	0	0	0	
49033	12	1	40281	1	2	0	0	0	0	0	
49033	13	1	40282	1	2	0	0	0	0	0	
49033	14	1	40283	1	2	0	0	0	0	0	
49033	15	1	40284	1	2	0	0	0	0	0	
49033	16	1	40285	1	2	0	0	0	0	0	
49033	17	1	40286	1	2	0	0	0	0	0	
49033	18	1	40287	1	2	0	0	0	0	0	
49033	19	1	40040	12	5	0	0	0	0	0	
49033	20	1	40041	4	3	0	0	0	0	0	
49033	21	1	40042	5	5	0	0	0	0	0	
49033	22	1	40043	3	2	0	0	0	0	0	
49033	23	1	41082	1	3	0	0	0	0	0	
49033	24	1	41083	1	2	0	0	0	0	0	
49033	25	1	41085	3	4	0	0	0	0	0	
49033	26	1	41086	1	4	0	0	0	0	0	
49033	27	1	41087	3	4	0	0	0	0	0	
49033	28	1	40104	95	4	0	0	0	0	0	
49033	29	1	40039	120	4	0	0	0	0	0	
49033	30	1	40038	160	4	0	0	0	0	0	
49033	31	1	40035	95	4	0	0	0	0	0	
49033	32	1	40034	160	4	0	0	0	0	0	
49033	33	1	40033	160	4	0	0	0	0	0	
49033	34	1	40190	5	3	0	0	0	0	0	
49033	35	1	40191	11	4	0	0	0	0	0	
49033	36	1	40192	11	3	0	0	0	0	0	
49033	37	1	40193	11	4	0	0	0	0	0	
49033	38	1	40021	2	2	0	0	0	0	0	
49033	39	1	40020	3	3	0	0	0	0	0	
49033	40	1	40019	5	3	0	0	0	0	0	
49034	1	1	40265	1	1.2	1	0	0	0	0	
49034	2	1	40266	1	0.3	1	0	0	0	0	
49034	3	1	40269	1	4	0	0	0	0	0	
49034	4	1	40270	1	1.5	0	0	0	0	0	
49034	5	1	40021	2	4	0	0	0	0	0	
49034	6	1	40209	2	4	0	0	0	0	0	
49034	5	1	40211	2	4	0	0	0	0	0	
49034	6	1	40213	2	3.5	0	0	0	0	0	
49034	7	1	40215	2	3	0	0	0	0	0	
49034	8	1	40217	2	3	0	0	0	0	0	
49034	9	1	40202	7	4	0	0	0	0	0	
49034	10	1	40187	1	4	0	0	0	0	0	
49034	11	1	40020	3	4.5	0	0	0	0	0	
49034	12	1	40186	1	4	0	0	0	0	0	
49034	13	1	40019	5	4	0	0	0	0	0	
49034	14	1	40200	4	4	0	0	0	0	0	
49034	15	1	40039	120	4	0	0	0	0	0	
49034	16	1	40038	160	4	0	0	0	0	0	
49034	17	1	40034	160	5	0	0	0	0	0	
49034	18	1	40033	160	5	0	0	0	0	0	
49034	19	1	40035	95	5	0	0	0	0	0	
49034	20	1	40104	95	5	0	0	0	0	0	
49034	21	1	40190	5	3	0	0	0	0	0	
49034	22	1	40191	11	4	0	0	0	0	0	
49034	23	1	40192	11	4	0	0	0	0	0	
49034	24	1	40193	11	4	0	0	0	0	0	
49034	25	1	40183	22	4	0	0	0	0	0	
49035	1	1	40331	1	1.5	1	0	0	0	0	
49035	2	1	40332	1	0.4	1	0	0	0	0	
49035	3	1	40333	1	4	0	0	0	0	0	
49035	4	1	40334	1	1.7	0	0	0	0	0	
49035	5	1	40021	2	4	0	0	0	0	0	
49035	6	1	40209	2	4	0	0	0	0	0	
49035	7	1	40211	2	4	0	0	0	0	0	
49035	8	1	40213	2	3.5	0	0	0	0	0	
49035	9	1	40215	2	3	0	0	0	0	0	
49035	10	1	40217	2	3	0	0	0	0	0	
49035	11	1	40202	7	4	0	0	0	0	0	
49035	12	1	40187	1	4	0	0	0	0	0	
49035	13	1	40020	3	4.5	0	0	0	0	0	
49035	14	1	40186	1	4	0	0	0	0	0	
49035	15	1	40019	5	4	0	0	0	0	0	
49035	16	1	40200	4	4	0	0	0	0	0	
49035	17	1	40039	120	4	0	0	0	0	0	
49035	18	1	40038	160	4	0	0	0	0	0	
49035	19	1	40034	160	5	0	0	0	0	0	
49035	20	1	40033	160	5	0	0	0	0	0	
49035	21	1	40035	95	5	0	0	0	0	0	
49035	22	1	40104	95	5	0	0	0	0	0	
49035	23	1	40190	5	3	0	0	0	0	0	
49035	24	1	40191	11	4	0	0	0	0	0	
49035	25	1	40192	11	4	0	0	0	0	0	
49035	26	1	40193	11	4	0	0	0	0	0	
49035	27	1	40183	22	4	0	0	0	0	0	
49037	1	1	40300	1	100	0	0	0	0	0	
49037	1	2	40319	1	0.5	1	0	0	0	0	
49037	2	2	40320	1	0.5	1	0	0	0	0	
49037	3	2	40321	1	0.5	1	0	0	0	0	
49037	4	2	40324	1	3	0	0	0	0	0	
49037	5	2	40325	1	3	0	0	0	0	0	
49037	6	2	40326	1	3	0	0	0	0	0	
49037	7	2	40342	1	7	0	0	0	0	0	
49037	8	2	40343	1	7	0	0	0	0	0	
49037	9	2	40329	1	1	0	0	0	0	0	
49037	10	2	40330	1	3	0	0	0	0	0	
49037	11	2	40316	11	5	0	0	0	0	0	
49037	12	2	40313	11	5	0	0	0	0	0	
49037	13	2	40314	11	5	0	0	0	0	0	
49037	14	2	40315	11	5	0	0	0	0	0	
49037	15	2	40323	1	1	0	0	0	0	0	
49037	16	2	40328	1	1	0	0	0	0	0	
49037	17	2	40186	1	3	0	0	0	0	0	
49037	18	2	40185	3	3	0	0	0	0	0	
49037	19	2	40183	22	3	0	0	0	0	0	
49037	20	2	40200	4	3	0	0	0	0	0	
49037	21	2	40201	1	3	0	0	0	0	0	
49037	22	2	40021	2	3	0	0	0	0	0	
49037	23	2	40020	3	3	0	0	0	0	0	
49037	24	2	40019	5	3	0	0	0	0	0	
49037	25	2	40105	80	2.5	0	0	0	0	0	
49037	26	2	40104	95	2	0	0	0	0	0	
49037	27	2	40039	120	2	0	0	0	0	0	
49037	28	2	40038	160	2	0	0	0	0	0	
49037	29	2	40036	80	3	0	0	0	0	0	
49037	30	2	40035	95	2	0	0	0	0	0	
49037	31	2	40034	160	2	0	0	0	0	0	
49037	32	2	40033	160	2	0	0	0	0	0	
49037	33	2	40190	5	2	0	0	0	0	0	
49037	34	2	40191	11	2	0	0	0	0	0	
49037	35	2	40192	11	2	0	0	0	0	0	
49037	36	2	40193	11	2	0	0	0	0	0	
49039	1	1	40335	1	1.5	1	0	0	0	0	
49039	2	1	40336	1	0.5	1	0	0	0	0	
49039	3	1	40337	1	3	0	0	0	0	0	
49039	4	1	40338	1	1.5	0	0	0	0	0	
49039	5	1	40344	1	3	0	0	0	0	0	
49039	6	1	40345	1	3	0	0	0	0	0	
49039	7	1	40346	1	1	0	0	0	0	0	
49039	8	1	40347	1	1	0	0	0	0	0	
49039	9	1	40348	1	3	0	0	0	0	0	
49039	10	1	40349	1	1	0	0	0	0	0	
49039	11	1	40021	2	3	0	0	0	0	0	
49039	12	1	40209	2	3	0	0	0	0	0	
49039	13	1	40211	2	3	0	0	0	0	0	
49039	14	1	40213	2	3	0	0	0	0	0	
49039	15	1	40215	2	3	0	0	0	0	0	
49039	16	1	40217	2	3	0	0	0	0	0	
49039	17	1	40202	7	3	0	0	0	0	0	
49039	18	1	40187	1	3	0	0	0	0	0	
49039	19	1	40020	3	4	0	0	0	0	0	
49039	20	1	40186	1	3	0	0	0	0	0	
49039	21	1	40019	5	4	0	0	0	0	0	
49039	22	1	40200	4	3	0	0	0	0	0	
49039	23	1	40039	120	3.5	0	0	0	0	0	
49039	24	1	40038	160	4	0	0	0	0	0	
49039	25	1	40034	160	4	0	0	0	0	0	
49039	26	1	40033	160	4	0	0	0	0	0	
49039	27	1	40035	95	4	0	0	0	0	0	
49039	28	1	40104	95	4	0	0	0	0	0	
49039	29	1	40190	5	4	0	0	0	0	0	
49039	30	1	40191	11	4	0	0	0	0	0	
49039	31	1	40192	11	4	0	0	0	0	0	
49039	32	1	40193	11	4	0	0	0	0	0	
49039	33	1	40183	22	4	0	0	0	0	0	
49040	1	1	40164	1	1	1	0	0	0	0	
49040	2	1	40168	1	1	1	0	0	0	0	
49040	3	1	40169	1	1	1	0	0	0	0	
49040	4	1	40175	1	3.5	0	0	0	0	0	
49040	5	1	40179	1	3.5	0	0	0	0	0	
49040	6	1	40180	1	3.5	0	0	0	0	0	
49040	9	1	40021	2	3	0	0	0	0	0	
49040	10	1	40209	2	3	0	0	0	0	0	
49040	11	1	40211	2	3	0	0	0	0	0	
49040	12	1	40213	2	3	0	0	0	0	0	
49040	13	1	40215	2	3	0	0	0	0	0	
49040	14	1	40217	2	3	0	0	0	0	0	
49040	15	1	40202	7	4	0	0	0	0	0	
49040	16	1	40187	1	4	0	0	0	0	0	
49040	17	1	40020	3	4	0	0	0	0	0	
49040	18	1	40186	1	4	0	0	0	0	0	
49040	19	1	40019	5	4	0	0	0	0	0	
49040	20	1	40200	4	4	0	0	0	0	0	
49040	21	1	40039	120	4	0	0	0	0	0	
49040	22	1	40038	160	4	0	0	0	0	0	
49040	23	1	40034	160	4	0	0	0	0	0	
49040	24	1	40033	160	4	0	0	0	0	0	
49040	25	1	40035	95	4	0	0	0	0	0	
49040	26	1	40104	95	4.5	0	0	0	0	0	
49040	27	1	40190	5	4	0	0	0	0	0	
49040	28	1	40191	11	4	0	0	0	0	0	
49040	29	1	40192	11	4	0	0	0	0	0	
49040	30	1	40193	11	4	0	0	0	0	0	
49040	31	1	40183	22	4	0	0	0	0	0	
49042	1	1	40407	1	100	0	0	0	0	0	
49042	2	2	40408	1	100	0	0	0	0	0	
49043	1	1	40405	1	100	0	0	0	0	0	
49043	2	2	40406	1	100	0	0	0	0	0	
49044	1	1	40409	1	100	0	0	0	0	0	
49044	2	2	40410	1	100	0	0	0	0	0	
49045	1	1	40411	1	100	0	0	0	0	0	
49045	2	2	40412	1	100	0	0	0	0	0	
49046	1	1	40413	1	100	0	0	0	0	0	
49046	2	2	40414	1	100	0	0	0	0	0	
49047	1	1	40415	1	100	0	0	0	0	0	
49047	2	2	40416	1	100	0	0	0	0	0	
49048	1	1	40417	1	100	0	0	0	0	0	
49048	2	2	40418	1	100	0	0	0	0	0	
49049	1	1	40419	1	100	0	0	0	0	0	
49049	2	2	40420	1	100	0	0	0	0	0	
49050	1	1	40400	1	0.4	1	0	0	0	0	
49050	2	1	40403	1	2	0	0	0	0	0	
49050	3	1	40021	2	3	0	0	0	0	0	
49050	4	1	40209	2	3	0	0	0	0	0	
49050	5	1	40211	2	3	0	0	0	0	0	
49050	6	1	40213	2	3	0	0	0	0	0	
49050	7	1	40215	2	3	0	0	0	0	0	
49050	8	1	40217	2	3	0	0	0	0	0	
49050	9	1	40202	7	5	0	0	0	0	0	
49050	10	1	40187	1	5	0	0	0	0	0	
49050	11	1	40020	3	5	0	0	0	0	0	
49050	12	1	40186	1	5	0	0	0	0	0	
49050	13	1	40019	5	5	0	0	0	0	0	
49050	14	1	40200	4	5	0	0	0	0	0	
49050	15	1	40039	120	4	0	0	0	0	0	
49050	16	1	40038	160	4	0	0	0	0	0	
49050	17	1	40034	160	4	0	0	0	0	0	
49050	18	1	40033	160	4	0	0	0	0	0	
49050	19	1	40035	95	5	0	0	0	0	0	
49050	20	1	40104	95	5	0	0	0	0	0	
49050	21	1	40190	5	3	0	0	0	0	0	
49050	22	1	40191	11	3	0	0	0	0	0	
49050	23	1	40192	11	4	0	0	0	0	0	
49050	24	1	40193	11	4	0	0	0	0	0	
49050	25	1	40183	22	5.6	0	0	0	0	0	
49050	26	1	40251	1	3.5	0	0	0	0	0	
49050	27	1	40226	1	0.5	0	0	0	0	0	
49051	1	1	40440	1	0.3	1	0	0	0	0	
49051	2	1	40442	1	2	0	0	0	0	0	
49051	3	1	40021	2	3.1	0	0	0	0	0	
49051	4	1	40209	2	3	0	0	0	0	0	
49051	5	1	40211	2	3	0	0	0	0	0	
49051	6	1	40213	2	3	0	0	0	0	0	
49051	7	1	40215	2	3	0	0	0	0	0	
49051	8	1	40217	2	3	0	0	0	0	0	
49051	9	1	40202	7	5	0	0	0	0	0	
49051	10	1	40187	1	5	0	0	0	0	0	
49051	11	1	40020	3	5	0	0	0	0	0	
49051	12	1	40186	1	5	0	0	0	0	0	
49051	13	1	40019	5	5	0	0	0	0	0	
49051	14	1	40200	4	5	0	0	0	0	0	
49051	15	1	40039	120	4	0	0	0	0	0	
49051	16	1	40038	160	4	0	0	0	0	0	
49051	17	1	40034	160	4	0	0	0	0	0	
49051	18	1	40033	160	4	0	0	0	0	0	
49051	19	1	40035	95	5	0	0	0	0	0	
49051	20	1	40104	95	5	0	0	0	0	0	
49051	21	1	40190	5	3	0	0	0	0	0	
49051	22	1	40191	11	3	0	0	0	0	0	
49051	23	1	40192	11	4	0	0	0	0	0	
49051	24	1	40193	11	4	0	0	0	0	0	
49051	25	1	40183	22	5.6	0	0	0	0	0	
49051	26	1	40251	1	3.5	0	0	0	0	0	
49051	27	1	40226	1	0.5	0	0	0	0	0	
49057	1	1	40159	1	0.3	0	0	0	0	0	
49057	2	1	40160	1	0.3	0	0	0	0	0	
49057	3	1	40161	1	0.3	0	0	0	0	0	
49057	4	1	40162	1	0.3	0	0	0	0	0	
49057	5	1	40163	1	0.3	0	0	0	0	0	
49057	6	1	40164	1	0.3	0	0	0	0	0	
49057	7	1	40165	1	0.3	0	0	0	0	0	
49057	8	1	40166	1	0.3	0	0	0	0	0	
49057	9	1	40167	1	0.3	0	0	0	0	0	
49057	10	1	40168	1	0.3	0	0	0	0	0	
49057	11	1	40223	1	0.3	0	0	0	0	0	
49057	12	1	40224	1	0.3	0	0	0	0	0	
49057	13	1	40225	1	0.3	0	0	0	0	0	
49057	14	1	40226	1	0.3	0	0	0	0	0	
49057	15	1	40227	1	0.3	0	0	0	0	0	
49057	16	1	40228	1	0.3	0	0	0	0	0	
49057	17	1	40229	1	0.3	0	0	0	0	0	
49057	18	1	40230	1	0.3	0	0	0	0	0	
49057	19	1	40231	1	0.3	0	0	0	0	0	
49057	20	1	40247	1	0.3	0	0	0	0	0	
49057	21	1	40170	1	1.5	0	0	0	0	0	
49057	22	1	40171	1	1.5	0	0	0	0	0	
49057	23	1	40172	1	1.5	0	0	0	0	0	
49057	24	1	40173	1	1.5	0	0	0	0	0	
49057	25	1	40174	1	1.5	0	0	0	0	0	
49057	26	1	40175	1	1.5	0	0	0	0	0	
49057	27	1	40176	1	1.5	0	0	0	0	0	
49057	28	1	40177	1	1.5	0	0	0	0	0	
49057	29	1	40178	1	1.5	0	0	0	0	0	
49057	30	1	40179	1	1.5	0	0	0	0	0	
49057	31	1	40248	1	1.5	0	0	0	0	0	
49057	32	1	40249	1	1.5	0	0	0	0	0	
49057	33	1	40250	1	1.5	0	0	0	0	0	
49057	34	1	40251	1	1.5	0	0	0	0	0	
49057	35	1	40252	1	1.5	0	0	0	0	0	
49057	36	1	40253	1	1.5	0	0	0	0	0	
49057	37	1	40254	1	1.5	0	0	0	0	0	
49057	38	1	40255	1	1.5	0	0	0	0	0	
49057	39	1	40256	1	1.5	0	0	0	0	0	
49057	40	1	40327	1	0.3	0	0	0	0	0	
49057	41	1	40328	1	0.3	0	0	0	0	0	
49057	42	1	40329	1	0.3	0	0	0	0	0	
49057	43	1	40330	1	1.5	0	0	0	0	0	
49057	44	1	40344	1	1.5	0	0	0	0	0	
49057	45	1	40346	1	2	0	0	0	0	0	
49057	46	1	40438	1	1.2	0	0	0	0	0	
49057	47	1	40362	2	28.4	0	0	0	0	0	
49057	48	1	40033	160	3	0	0	0	0	0	
49057	49	1	40034	120	3	0	0	0	0	0	
49057	50	1	40035	95	3	0	0	0	0	0	
49057	51	1	40036	80	3	0	0	0	0	0	
49057	52	1	40037	70	3	0	0	0	0	0	
49057	53	1	40038	160	3	0	0	0	0	0	
49057	54	1	40039	120	3	0	0	0	0	0	
49057	55	1	40104	95	3	0	0	0	0	0	
49057	56	1	40105	80	3	0	0	0	0	0	
49057	57	1	40106	70	3	0	0	0	0	0	
49058	1	1	40194	1	0.15	1	0	0	0	0	
49058	2	1	40375	1	0.15	1	0	0	0	0	
49058	3	1	40195	1	0.15	1	0	0	0	0	
49058	4	1	40196	1	0.15	1	0	0	0	0	
49058	5	1	40232	1	0.15	1	0	0	0	0	
49058	6	1	40233	1	0.15	1	0	0	0	0	
49058	7	1	40347	1	0.15	1	0	0	0	0	
49058	8	1	40400	1	0.15	1	0	0	0	0	
49058	9	1	40437	1	0.15	1	0	0	0	0	
49058	10	1	40490	1	2	0	0	0	0	0	
49058	11	1	40197	1	3	0	0	0	0	0	
49058	12	1	40198	1	3	0	0	0	0	0	
49058	13	1	40199	1	3	0	0	0	0	0	
49058	14	1	40257	1	3	0	0	0	0	0	
49058	15	1	40258	1	3	0	0	0	0	0	
49058	16	1	40345	1	3	0	0	0	0	0	
49058	17	1	40403	1	3	0	0	0	0	0	
49058	18	1	40441	1	3	0	0	0	0	0	
49058	19	1	40362	2	52.8	0	0	0	0	0	
49058	20	1	40033	160	2	0	0	0	0	0	
49058	21	1	40034	120	2	0	0	0	0	0	
49058	22	1	40035	95	2	0	0	0	0	0	
49058	23	1	40036	80	2	0	0	0	0	0	
49058	24	1	40037	70	2	0	0	0	0	0	
49058	25	1	40038	160	1.85	0	0	0	0	0	
49058	26	1	40039	120	2	0	0	0	0	0	
49058	27	1	40104	95	2	0	0	0	0	0	
49058	28	1	40105	80	2	0	0	0	0	0	
49058	29	1	40106	70	2	0	0	0	0	0	
49059	1	1	40236	1	1	1	0	0	0	0	
49059	2	1	40237	1	1	1	0	0	0	0	
49059	3	1	40238	1	1	1	0	0	0	0	
49059	4	1	40169	1	1	1	0	0	0	0	
49059	5	1	40399	1	0.5	1	0	0	0	0	
49059	6	1	40440	1	0.5	1	0	0	0	0	
49059	7	1	40180	1	4	0	0	0	0	0	
49059	8	1	40261	1	5	0	0	0	0	0	
49059	9	1	40262	1	4	0	0	0	0	0	
49059	10	1	40263	1	4	0	0	0	0	0	
49059	11	1	40402	1	4	0	0	0	0	0	
49059	12	1	40442	1	4	0	0	0	0	0	
49059	13	1	40362	2	50	0	0	0	0	0	
49059	14	1	40033	160	2	0	0	0	0	0	
49059	15	1	40034	120	2	0	0	0	0	0	
49059	16	1	40035	95	2	0	0	0	0	0	
49059	17	1	40036	80	2	0	0	0	0	0	
49059	18	1	40037	70	2	0	0	0	0	0	
49059	19	1	40038	160	2	0	0	0	0	0	
49059	20	1	40039	120	2	0	0	0	0	0	
49059	21	1	40104	95	2	0	0	0	0	0	
49059	22	1	40105	80	2	0	0	0	0	0	
49059	23	1	40106	70	2	0	0	0	0	0	
49060	1	1	40152	5	3	0	0	0	0	0	
49060	2	1	40153	5	1	0	0	0	0	0	
49060	3	1	40154	5	3	0	0	0	0	0	
49060	4	1	40155	5	1	0	0	0	0	0	
49060	5	1	40200	4	10	0	0	0	0	0	
49060	6	1	40201	1	5	0	0	0	0	0	
49060	7	1	40186	1	12	0	0	0	0	0	
49060	8	1	40187	1	10	0	0	0	0	0	
49060	9	1	40188	1	8	0	0	0	0	0	
49060	10	1	40317	1	2.5	0	0	0	0	0	
49060	11	1	40189	1	0.5	0	0	0	0	0	
49060	12	1	40183	22	10	0	0	0	0	0	
49060	13	1	40184	1	1	0	0	0	0	0	
49060	14	1	40185	3	3	0	0	0	0	0	
49060	15	1	40380	1	2	0	0	0	0	0	
49060	16	1	40362	2	18	0	0	0	0	0	
49060	17	1	40033	160	1	0	0	0	0	0	
49060	18	1	40034	120	1	0	0	0	0	0	
49060	19	1	40035	95	1	0	0	0	0	0	
49060	20	1	40036	80	1	0	0	0	0	0	
49060	21	1	40037	70	1	0	0	0	0	0	
49060	22	1	40038	160	1	0	0	0	0	0	
49060	23	1	40039	120	1	0	0	0	0	0	
49060	24	1	40104	95	1	0	0	0	0	0	
49060	25	1	40105	80	1	0	0	0	0	0	
49060	26	1	40106	70	1	0	0	0	0	0	
49061	1	1	40019	5	5	0	0	0	0	0	
49061	2	1	40020	5	5	0	0	0	0	0	
49061	3	1	40021	2	5	0	0	0	0	0	
49061	4	1	40022	2	3	0	0	0	0	0	
49061	5	1	40023	4	1	0	0	0	0	0	
49061	6	1	40024	2	1	0	0	0	0	0	
49061	7	1	40025	4	1	0	0	0	0	0	
49061	8	1	40026	2	1	0	0	0	0	0	
49061	9	1	40027	4	1	0	0	0	0	0	
49061	10	1	40028	2	1	0	0	0	0	0	
49061	11	1	40029	4	1	0	0	0	0	0	
49061	12	1	40030	2	1	0	0	0	0	0	
49061	13	1	40031	4	1	0	0	0	0	0	
49061	14	1	40032	2	1	0	0	0	0	0	
49061	15	1	40209	2	1	0	0	0	0	0	
49061	16	1	40210	1	1	0	0	0	0	0	
49061	17	1	40211	2	1	0	0	0	0	0	
49061	18	1	40212	1	1	0	0	0	0	0	
49061	19	1	40213	2	1	0	0	0	0	0	
49061	20	1	40214	1	1	0	0	0	0	0	
49061	21	1	40215	2	1	0	0	0	0	0	
49061	22	1	40216	1	1	0	0	0	0	0	
49061	23	1	40217	2	1	0	0	0	0	0	
49061	24	1	40218	1	1	0	0	0	0	0	
49061	25	1	40113	1	4	0	0	0	0	0	
49061	26	1	40222	1	1	0	0	0	0	0	
49061	27	1	40273	1	0.5	0	0	0	0	0	
49061	28	1	40274	1	0.2	0	0	0	0	0	
49061	29	1	40350	1	0.3	0	0	0	0	0	
49061	30	1	40156	4	10	0	0	0	0	0	
49061	31	1	40157	2	10	0	0	0	0	0	
49061	32	1	40158	1	5	0	0	0	0	0	
49061	33	1	40181	3	3	0	0	0	0	0	
49061	34	1	40182	1	3	0	0	0	0	0	
49061	35	1	41088	45	10	0	0	0	0	0	
49061	36	1	40122	10	5	0	0	0	0	0	
49061	37	1	40362	2	5	0	0	0	0	0	
49061	38	1	40033	160	0.5	0	0	0	0	0	
49061	39	1	40034	120	0.5	0	0	0	0	0	
49061	40	1	40035	95	0.5	0	0	0	0	0	
49061	41	1	40036	80	0.5	0	0	0	0	0	
49061	42	1	40037	70	0.5	0	0	0	0	0	
49061	43	1	40038	160	0.5	0	0	0	0	0	
49061	44	1	40039	120	0.5	0	0	0	0	0	
49061	45	1	40104	95	0.5	0	0	0	0	0	
49061	46	1	40105	80	0.5	0	0	0	0	0	
49061	47	1	40106	70	0.5	0	0	0	0	0	
49062	1	1	40331	1	0.8	1	0	0	0	0	
49062	2	1	40332	1	0.2	1	0	0	0	0	
49062	3	1	40265	1	0.8	1	0	0	0	0	
49062	4	1	40266	1	0.2	1	0	0	0	0	
49062	5	1	40267	1	0.8	1	0	0	0	0	
49062	6	1	40268	1	0.2	1	0	0	0	0	
49062	7	1	40335	1	0.8	1	0	0	0	0	
49062	8	1	40336	1	0.2	1	0	0	0	0	
49062	9	1	40333	1	2	0	0	0	0	0	
49062	10	1	40334	1	1	0	0	0	0	0	
49062	11	1	40269	1	2	0	0	0	0	0	
49062	12	1	40270	1	1	0	0	0	0	0	
49062	13	1	40271	1	2	0	0	0	0	0	
49062	14	1	40272	1	1	0	0	0	0	0	
49062	15	1	40337	1	2	0	0	0	0	0	
49062	16	1	40338	1	1	0	0	0	0	0	
49062	17	1	40362	2	54	0	0	0	0	0	
49062	18	1	40033	160	3	0	0	0	0	0	
49062	19	1	40034	120	3	0	0	0	0	0	
49062	20	1	40035	95	3	0	0	0	0	0	
49062	21	1	40036	80	3	0	0	0	0	0	
49062	22	1	40037	70	3	0	0	0	0	0	
49062	23	1	40038	160	3	0	0	0	0	0	
49062	24	1	40039	120	3	0	0	0	0	0	
49062	25	1	40104	95	3	0	0	0	0	0	
49062	26	1	40105	80	3	0	0	0	0	0	
49062	27	1	40106	70	3	0	0	0	0	0	
49066	1	1	40469	3	100	0	0	0	0	0	
49066	2	2	40470	2	100	0	0	0	0	0	
49067	1	1	34426	1	12	0	0	0	0	0	
49067	2	1	33515	1	0.1	0	0	0	0	0	
49067	3	1	33518	1	0.1	0	0	0	0	0	
49067	4	1	34396	1	1	0	0	0	0	0	
49067	5	1	34397	1	1	0	0	0	0	0	
49067	6	1	34398	1	1	0	0	0	0	0	
49067	7	1	34399	1	1	0	0	0	0	0	
49067	8	1	34400	1	1	0	0	0	0	0	
49067	9	1	34401	1	1	0	0	0	0	0	
49067	10	1	34402	1	1	0	0	0	0	0	
49067	11	1	34427	1	0.1	0	0	0	0	0	
49067	12	1	34428	1	0.1	0	0	0	0	0	
49067	13	1	34429	1	0.1	0	0	0	0	0	
49067	14	1	31510	30	0.1	0	0	0	0	0	
49067	15	1	31511	30	0.1	0	0	0	0	0	
49067	16	1	31512	30	0.1	0	0	0	0	0	
49067	17	1	31601	30	0.5	0	0	0	0	0	
49067	18	1	31602	30	0.5	0	0	0	0	0	
49067	19	1	31603	30	1	0	0	0	0	0	
49067	20	1	31604	30	0.5	0	0	0	0	0	
49067	21	1	31605	30	1	0	0	0	0	0	
49067	22	1	31606	30	1	0	0	0	0	0	
49067	23	1	31607	30	1	0	0	0	0	0	
49067	24	1	40023	4	2	0	0	0	0	0	
49067	25	1	40024	2	2	0	0	0	0	0	
49067	26	1	40025	4	2	0	0	0	0	0	
49067	27	1	40026	2	2	0	0	0	0	0	
49067	28	1	40027	4	2	0	0	0	0	0	
49067	29	1	40028	2	2	0	0	0	0	0	
49067	30	1	40029	4	2	0	0	0	0	0	
49067	31	1	40030	2	2	0	0	0	0	0	
49067	32	1	40031	4	2	0	0	0	0	0	
49067	33	1	40032	2	2	0	0	0	0	0	
49067	34	1	40209	2	2	0	0	0	0	0	
49067	35	1	40210	1	2	0	0	0	0	0	
49067	36	1	40211	2	2	0	0	0	0	0	
49067	37	1	40212	1	2	0	0	0	0	0	
49067	38	1	40213	2	2	0	0	0	0	0	
49067	39	1	40214	1	2	0	0	0	0	0	
49067	40	1	40215	2	2	0	0	0	0	0	
49067	41	1	40216	1	2	0	0	0	0	0	
49067	42	1	40217	2	2	0	0	0	0	0	
49067	43	1	40218	1	2	0	0	0	0	0	
49067	44	1	34279	4	20.7	0	0	0	0	0	
49067	45	1	40033	160	1	0	0	0	0	0	
49067	46	1	40034	120	1	0	0	0	0	0	
49067	47	1	40035	95	1	0	0	0	0	0	
49067	48	1	40036	80	2	0	0	0	0	0	
49067	49	1	40037	70	2	0	0	0	0	0	
49067	50	1	40038	160	1	0	0	0	0	0	
49067	51	1	40039	120	1	0	0	0	0	0	
49067	52	1	40104	95	1	0	0	0	0	0	
49067	53	1	40105	80	2	0	0	0	0	0	
49067	54	1	40106	70	2	0	0	0	0	0	
49068	1	1	34426	1	12	0	0	0	0	0	
49068	2	1	33516	1	0.1	0	0	0	0	0	
49068	3	1	33519	1	0.1	0	0	0	0	0	
49068	4	1	34403	1	1.2	0	0	0	0	0	
49068	5	1	34404	1	1.2	0	0	0	0	0	
49068	6	1	34405	1	1.2	0	0	0	0	0	
49068	7	1	34406	1	1.2	0	0	0	0	0	
49068	8	1	34407	1	1.2	0	0	0	0	0	
49068	9	1	34408	1	1.2	0	0	0	0	0	
49068	10	1	34427	1	0.1	0	0	0	0	0	
49068	11	1	34428	1	0.1	0	0	0	0	0	
49068	12	1	34429	1	0.1	0	0	0	0	0	
49068	13	1	31510	30	0.1	0	0	0	0	0	
49068	14	1	31511	30	0.1	0	0	0	0	0	
49068	15	1	31512	30	0.1	0	0	0	0	0	
49068	16	1	31601	30	0.5	0	0	0	0	0	
49068	17	1	31602	30	0.5	0	0	0	0	0	
49068	18	1	31603	30	1	0	0	0	0	0	
49068	19	1	31604	30	0.5	0	0	0	0	0	
49068	20	1	31605	30	1	0	0	0	0	0	
49068	21	1	31606	30	1	0	0	0	0	0	
49068	22	1	31607	30	1	0	0	0	0	0	
49068	23	1	40023	4	2	0	0	0	0	0	
49068	24	1	40024	2	2	0	0	0	0	0	
49068	25	1	40025	4	2	0	0	0	0	0	
49068	26	1	40026	2	2	0	0	0	0	0	
49068	27	1	40027	4	2	0	0	0	0	0	
49068	28	1	40028	2	2	0	0	0	0	0	
49068	29	1	40029	4	2	0	0	0	0	0	
49068	30	1	40030	2	2	0	0	0	0	0	
49068	31	1	40031	4	2	0	0	0	0	0	
49068	32	1	40032	2	2	0	0	0	0	0	
49068	33	1	40209	2	2	0	0	0	0	0	
49068	34	1	40210	1	2	0	0	0	0	0	
49068	35	1	40211	2	2	0	0	0	0	0	
49068	36	1	40212	1	2	0	0	0	0	0	
49068	37	1	40213	2	2	0	0	0	0	0	
49068	38	1	40214	1	2	0	0	0	0	0	
49068	39	1	40215	2	2	0	0	0	0	0	
49068	40	1	40216	1	2	0	0	0	0	0	
49068	41	1	40217	2	2	0	0	0	0	0	
49068	42	1	40218	1	2	0	0	0	0	0	
49068	43	1	34279	4	20.5	0	0	0	0	0	
49068	44	1	40033	160	1	0	0	0	0	0	
49068	45	1	40034	160	1	0	0	0	0	0	
49068	46	1	40035	95	1	0	0	0	0	0	
49068	47	1	40036	80	2	0	0	0	0	0	
49068	48	1	40037	70	2	0	0	0	0	0	
49068	49	1	40038	160	1	0	0	0	0	0	
49068	50	1	40039	120	1	0	0	0	0	0	
49068	51	1	40104	95	1	0	0	0	0	0	
49068	52	1	40105	80	2	0	0	0	0	0	
49068	53	1	40106	70	2	0	0	0	0	0	
49069	1	1	34426	1	12	0	0	0	0	0	
49069	2	1	33517	1	0.1	0	0	0	0	0	
49069	3	1	33520	1	0.1	0	0	0	0	0	
49069	4	1	34410	1	1.2	0	0	0	0	0	
49069	5	1	34411	1	1.2	0	0	0	0	0	
49069	6	1	34413	1	1.2	0	0	0	0	0	
49069	7	1	34414	1	1.2	0	0	0	0	0	
49069	8	1	34412	1	1.2	0	0	0	0	0	
49069	9	1	34415	1	1.2	0	0	0	0	0	
49069	10	1	34427	1	0.1	0	0	0	0	0	
49069	11	1	34428	1	0.1	0	0	0	0	0	
49069	12	1	34429	1	0.1	0	0	0	0	0	
49069	13	1	31510	30	0.1	0	0	0	0	0	
49069	14	1	31511	30	0.1	0	0	0	0	0	
49069	15	1	31512	30	0.1	0	0	0	0	0	
49069	16	1	31601	30	0.5	0	0	0	0	0	
49069	17	1	31602	30	0.5	0	0	0	0	0	
49069	18	1	31603	30	1	0	0	0	0	0	
49069	19	1	31604	30	0.5	0	0	0	0	0	
49069	20	1	31605	30	1	0	0	0	0	0	
49069	21	1	31606	30	1	0	0	0	0	0	
49069	22	1	31607	30	1	0	0	0	0	0	
49069	23	1	40023	4	2	0	0	0	0	0	
49069	24	1	40024	2	2	0	0	0	0	0	
49069	25	1	40025	4	2	0	0	0	0	0	
49069	26	1	40026	2	2	0	0	0	0	0	
49069	27	1	40027	4	2	0	0	0	0	0	
49069	28	1	40028	2	2	0	0	0	0	0	
49069	29	1	40029	4	2	0	0	0	0	0	
49069	30	1	40030	2	2	0	0	0	0	0	
49069	31	1	40031	4	2	0	0	0	0	0	
49069	32	1	40032	2	2	0	0	0	0	0	
49069	33	1	40209	2	2	0	0	0	0	0	
49069	34	1	40210	1	2	0	0	0	0	0	
49069	35	1	40211	2	2	0	0	0	0	0	
49069	36	1	40212	1	2	0	0	0	0	0	
49069	37	1	40213	2	2	0	0	0	0	0	
49069	38	1	40214	1	2	0	0	0	0	0	
49069	39	1	40215	2	2	0	0	0	0	0	
49069	40	1	40216	1	2	0	0	0	0	0	
49069	41	1	40217	2	2	0	0	0	0	0	
49069	42	1	40218	1	2	0	0	0	0	0	
49069	43	1	34279	4	20.5	0	0	0	0	0	
49069	44	1	40033	160	1	0	0	0	0	0	
49069	45	1	40034	160	1	0	0	0	0	0	
49069	46	1	40035	95	1	0	0	0	0	0	
49069	47	1	40036	80	2	0	0	0	0	0	
49069	48	1	40037	70	2	0	0	0	0	0	
49069	49	1	40038	160	1	0	0	0	0	0	
49069	50	1	40039	120	1	0	0	0	0	0	
49069	51	1	40104	95	1	0	0	0	0	0	
49069	52	1	40105	80	2	0	0	0	0	0	
49069	53	1	40106	70	2	0	0	0	0	0	
49070	1	1	40022	2	20.89	0	0	0	0	0	
49070	2	1	40158	1	50	0	0	0	0	0	
49070	3	1	40200	4	0.2	0	0	0	0	0	
49070	4	1	40370	1	0.01	0	0	0	0	0	
49070	5	1	40222	1	0.3	0	0	0	0	0	
49070	6	1	40113	1	3	0	0	0	0	0	
49070	7	1	40459	1	0.05	1	0	0	0	0	
49070	8	1	40268	1	0.2	0	0	0	0	0	
49070	9	1	40312	1	0.2	0	0	0	0	0	
49070	10	1	40184	1	7	0	0	0	0	0	
49070	11	1	40362	2	15.95	0	0	0	0	0	
49070	12	1	41091	1	2	0	0	0	0	0	
49070	13	1	40232	1	0.2	0	0	0	0	0	
49071	3	1	40371	1	0.6	0	0	0	0	0	
49071	4	1	40372	1	0.3	0	0	0	0	0	
49071	6	1	40364	1	3	0	0	0	0	0	
49071	7	1	40261	1	2	0	0	0	0	0	
49071	8	1	40236	1	1	0	0	0	0	0	
49071	20	1	40432	1	0.2	0	0	0	0	0	
49071	21	1	40433	1	0.2	0	0	0	0	0	
49071	22	1	40434	1	0.2	0	0	0	0	0	
49071	23	1	40435	1	0.2	0	0	0	0	0	
49071	24	1	40436	1	0.2	0	0	0	0	0	
49071	25	1	41091	1	1	0	0	0	0	0	
49071	26	1	41092	1	1	0	0	0	0	0	
49071	27	1	41093	3	2	0	0	0	0	0	
49071	28	1	40368	1	1.5	0	0	0	0	0	
49071	29	1	40369	1	0.5	0	0	0	0	0	
49071	33	1	34432	1	0.1	0	0	0	0	0	
49071	34	1	34433	1	0.1	0	0	0	0	0	
49071	35	1	34434	1	0.1	0	0	0	0	0	
49071	36	1	34435	1	0.1	0	0	0	0	0	
49071	37	1	34426	1	3	0	0	0	0	0	
49071	42	1	33519	1	0.05	0	0	0	0	0	
49071	43	1	33520	1	0.05	0	0	0	0	0	
49071	44	1	33483	1	0.7	0	0	0	0	0	
49071	13	1	40425	1	0.2	0	0	0	0	0	
49071	14	1	40426	1	0.2	0	0	0	0	0	
49071	19	1	40431	1	0.2	0	0	0	0	0	
49071	49	1	33488	1	0.7	0	0	0	0	0	
49071	50	1	33489	1	0.7	0	0	0	0	0	
49071	53	1	33492	1	0.7	0	0	0	0	0	
49071	54	1	40273	1	0.1	0	0	0	0	0	
49071	56	1	40516	1	1	0	0	0	0	0	
49071	57	1	40514	1	2.5	0	0	0	0	0	
49071	58	1	40515	1	10	0	0	0	0	0	
49071	59	1	40023	4	2	0	0	0	0	0	
49071	60	1	40024	2	2	0	0	0	0	0	
49071	61	1	40025	4	2	0	0	0	0	0	
49071	2	1	40374	1	0.02	0	0	0	0	0	
49071	62	1	40026	2	2	0	0	0	0	0	
49071	63	1	40027	4	2	0	0	0	0	0	
49071	64	1	40028	2	2	0	0	0	0	0	
49071	51	1	33490	1	0.7	0	0	0	0	0	
49071	52	1	33491	1	0.7	0	0	0	0	0	
49071	65	1	40029	4	2	0	0	0	0	0	
49071	66	1	40030	2	2	0	0	0	0	0	
49071	67	1	40031	4	2	0	0	0	0	0	
49071	68	1	40032	2	2	0	0	0	0	0	
49071	9	1	40421	1	0.2	0	0	0	0	0	
49071	10	1	40422	1	0.2	0	0	0	0	0	
49071	11	1	40423	1	0.2	0	0	0	0	0	
49071	12	1	40424	1	0.2	0	0	0	0	0	
49071	69	1	40209	2	2	0	0	0	0	0	
49071	70	1	40210	1	2	0	0	0	0	0	
49071	71	1	40211	2	2.3	0	0	0	0	0	
49071	30	1	40370	1	0.01	0	0	0	0	0	
49071	31	1	34430	1	0.1	0	0	0	0	0	
49071	32	1	34431	1	0.1	0	0	0	0	0	
49071	72	1	40212	1	2	0	0	0	0	0	
49071	38	1	33515	1	0.05	0	0	0	0	0	
49071	39	1	33516	1	0.05	0	0	0	0	0	
49071	40	1	33517	1	0.05	0	0	0	0	0	
49071	41	1	33518	1	0.05	0	0	0	0	0	
49071	73	1	40213	2	2	0	0	0	0	0	
49071	45	1	33484	1	0.7	0	0	0	0	0	
49071	48	1	33487	1	0.7	0	0	0	0	0	
49071	74	1	40214	1	2	0	0	0	0	0	
49071	75	1	40215	2	2	0	0	0	0	0	
49071	76	1	40216	1	2	0	0	0	0	0	
49071	15	1	40427	1	0.2	0	0	0	0	0	
49071	16	1	40428	1	0.2	0	0	0	0	0	
49071	17	1	40429	1	0.2	0	0	0	0	0	
49071	18	1	40430	1	0.2	0	0	0	0	0	
49071	77	1	40217	2	2	0	0	0	0	0	
49071	1	1	40373	1	0.1	0	0	0	0	0	
49071	78	1	40218	1	2	0	0	0	0	0	
49071	5	1	40363	1	3	0	0	0	0	0	
49071	80	1	40033	160	1	0	0	0	0	0	
49071	81	1	40034	160	1	0	0	0	0	0	
49071	82	1	40035	95	2	0	0	0	0	0	
49071	46	1	33485	1	0.5	0	0	0	0	0	
49071	47	1	33486	1	0.5	0	0	0	0	0	
49071	83	1	40036	80	2	0	0	0	0	0	
49071	84	1	40037	70	2	0	0	0	0	0	
49071	85	1	40038	160	1	0	0	0	0	0	
49071	86	1	40039	120	1	0	0	0	0	0	
49071	87	1	40104	95	2	0	0	0	0	0	
49071	88	1	40105	80	2	0	0	0	0	0	
49071	89	1	40106	70	2.37	0	0	0	0	0	
49073	1	1	34994	1	100	0	0	0	0	0	
49073	2	2	34928	40	100	0	0	0	0	0	
49074	1	1	34995	1	100	0	0	0	0	0	
49074	2	2	34928	38	100	0	0	0	0	0	
49075	1	1	34996	1	100	0	0	0	0	0	
49075	2	2	34928	35	100	0	0	0	0	0	
49076	1	1	34997	1	100	0	0	0	0	0	
49076	2	2	34928	33	100	0	0	0	0	0	
49077	1	1	34998	1	100	0	0	0	0	0	
49077	2	2	34928	30	100	0	0	0	0	0	
49078	1	1	34999	1	100	0	0	0	0	0	
49078	2	2	34928	25	100	0	0	0	0	0	
49079	1	1	34997	1	100	0	0	0	0	0	
49079	2	2	34928	33	100	0	0	0	0	0	
49080	1	1	34998	1	100	0	0	0	0	0	
49080	2	2	34928	30	100	0	0	0	0	0	
49081	1	1	34999	1	100	0	0	0	0	0	
49081	2	2	34928	25	100	0	0	0	0	0	
49082	1	1	34997	1	100	0	0	0	0	0	
49082	2	2	34928	33	100	0	0	0	0	0	
49083	1	1	34998	1	100	0	0	0	0	0	
49083	2	2	34928	30	100	0	0	0	0	0	
49084	1	1	34999	1	100	0	0	0	0	0	
49084	2	2	34928	25	100	0	0	0	0	0	
49085	1	1	34989	1	100	0	0	0	0	0	
49085	2	2	34928	40	100	0	0	0	0	0	
49086	1	1	34989	1	100	0	0	0	0	0	
49086	2	2	34928	38	100	0	0	0	0	0	
49087	1	1	34989	1	100	0	0	0	0	0	
49087	2	2	34928	35	100	0	0	0	0	0	
49088	1	1	34989	1	100	0	0	0	0	0	
49088	2	2	34928	30	100	0	0	0	0	0	
49089	1	1	34989	1	100	0	0	0	0	0	
49089	2	2	34928	25	100	0	0	0	0	0	
49090	1	1	34989	1	100	0	0	0	0	0	
49090	2	2	34928	30	100	0	0	0	0	0	
49091	1	1	34989	1	100	0	0	0	0	0	
49091	2	2	34928	30	100	0	0	0	0	0	
49092	1	1	34983	1	0.3	1	0	0	0	0	
49092	2	1	34988	1	1	1	0	0	0	0	
49092	3	1	35006	1	1	0	0	0	0	0	
49092	4	1	35011	1	3	0	0	0	0	0	
49092	5	1	40020	5	5	0	0	0	0	0	
49092	6	1	40021	2	5	0	0	0	0	0	
49092	7	1	40022	2	3	0	0	0	0	0	
49092	9	1	40024	3	2	0	0	0	0	0	
49092	11	1	40026	3	2	0	0	0	0	0	
49092	13	1	40028	3	2	0	0	0	0	0	
49092	15	1	40030	3	2	0	0	0	0	0	
49092	17	1	40032	3	2	0	0	0	0	0	
49092	19	1	40210	2	2	0	0	0	0	0	
49092	21	1	40212	2	2	0	0	0	0	0	
49092	23	1	40214	2	2	0	0	0	0	0	
49092	25	1	40216	2	2	0	0	0	0	0	
49092	27	1	40218	2	2	0	0	0	0	0	
49092	28	1	40113	1	4	0	0	0	0	0	
49092	29	1	40273	1	0.5	0	0	0	0	0	
49092	30	1	40274	1	0.2	0	0	0	0	0	
49092	31	1	40350	1	0.3	0	0	0	0	0	
49092	32	1	40156	4	10	0	0	0	0	0	
49092	33	1	40157	2	10	0	0	0	0	0	
49092	34	1	40158	1	5	0	0	0	0	0	
49092	35	1	40181	3	3	0	0	0	0	0	
49092	36	1	40182	1	3	0	0	0	0	0	
49092	37	1	41088	45	11.7	0	0	0	0	0	
49092	38	1	40122	10	5	0	0	0	0	0	
49092	39	1	40362	2	5	0	0	0	0	0	
49092	40	1	40034	160	0.5	0	0	0	0	0	
49092	41	1	40035	95	0.5	0	0	0	0	0	
49092	42	1	40036	80	0.5	0	0	0	0	0	
49092	43	1	40037	70	0.5	0	0	0	0	0	
49092	44	1	40039	120	0.5	0	0	0	0	0	
49092	45	1	40104	95	0.5	0	0	0	0	0	
49092	46	1	40105	80	0.5	0	0	0	0	0	
49092	47	1	40106	70	0.5	0	0	0	0	0	
49093	1	1	34981	1	0.6	1	0	0	0	0	
49093	2	1	34986	1	1.5	1	0	0	0	0	
49093	3	1	34990	1	1	1	0	0	0	0	
49093	4	1	34992	1	1	1	0	0	0	0	
49093	5	1	35004	1	1	0	0	0	0	0	
49093	6	1	35009	1	2.5	0	0	0	0	0	
49093	7	1	35013	1	3	0	0	0	0	0	
49093	8	1	35015	1	3	0	0	0	0	0	
49093	9	1	40020	5	5	0	0	0	0	0	
49093	10	1	40021	2	5	0	0	0	0	0	
49093	11	1	40022	2	3	0	0	0	0	0	
49093	12	1	40024	3	1.5	0	0	0	0	0	
49093	13	1	40026	3	1.5	0	0	0	0	0	
49093	14	1	40028	3	1.5	0	0	0	0	0	
49093	15	1	40030	3	1.5	0	0	0	0	0	
49093	16	1	40032	3	1.5	0	0	0	0	0	
49093	17	1	40210	2	2	0	0	0	0	0	
49093	18	1	40212	2	2	0	0	0	0	0	
49093	19	1	40214	2	2	0	0	0	0	0	
49093	20	1	40216	2	2	0	0	0	0	0	
49093	21	1	40218	2	2	0	0	0	0	0	
49093	22	1	40113	1	4	0	0	0	0	0	
49093	23	1	40273	1	0.5	0	0	0	0	0	
49093	24	1	40274	1	0.2	0	0	0	0	0	
49093	25	1	40350	1	0.3	0	0	0	0	0	
49093	26	1	40156	4	10	0	0	0	0	0	
49093	27	1	40157	2	10	0	0	0	0	0	
49093	28	1	40158	1	5	0	0	0	0	0	
49093	29	1	40181	3	3	0	0	0	0	0	
49093	30	1	40182	1	3	0	0	0	0	0	
49093	31	1	41088	45	5.9	0	0	0	0	0	
49093	32	1	40122	10	5	0	0	0	0	0	
49093	33	1	40362	2	5	0	0	0	0	0	
49093	34	1	40034	160	0.5	0	0	0	0	0	
49093	35	1	40035	95	0.5	0	0	0	0	0	
49093	36	1	40036	80	0.5	0	0	0	0	0	
49093	37	1	40037	70	0.5	0	0	0	0	0	
49093	38	1	40039	120	0.5	0	0	0	0	0	
49093	39	1	40104	95	0.5	0	0	0	0	0	
49093	40	1	40105	80	0.5	0	0	0	0	0	
49093	41	1	40106	70	0.5	0	0	0	0	0	
49095	1	1	34937	1	7	0	0	0	0	0	
49095	2	1	34938	1	5	0	0	0	0	0	
49095	3	1	34939	1	3	0	0	0	0	0	
49095	4	1	34940	1	7	0	0	0	0	0	
49095	5	1	34941	1	5	0	0	0	0	0	
49095	6	1	34942	1	3	0	0	0	0	0	
49095	7	1	40368	1	2	0	0	0	0	0	
49095	8	1	40369	1	1	0	0	0	0	0	
49095	9	1	40370	1	0.05	0	0	0	0	0	
49095	10	1	34426	1	12	0	0	0	0	0	
49095	11	1	33515	1	0.1	0	0	0	0	0	
49095	12	1	33518	1	0.1	0	0	0	0	0	
49095	13	1	34396	1	1	0	0	0	0	0	
49095	14	1	34397	1	1	0	0	0	0	0	
49095	15	1	34398	1	1	0	0	0	0	0	
49095	16	1	34399	1	1	0	0	0	0	0	
49095	17	1	34400	1	1	0	0	0	0	0	
49095	18	1	34401	1	1	0	0	0	0	0	
49095	19	1	34402	1	1	0	0	0	0	0	
49095	20	1	34427	1	0.1	0	0	0	0	0	
49095	21	1	34428	1	0.1	0	0	0	0	0	
49095	22	1	34429	1	0.1	0	0	0	0	0	
49095	23	1	31510	30	0.1	0	0	0	0	0	
49095	24	1	31511	30	0.1	0	0	0	0	0	
49095	25	1	31512	30	0.1	0	0	0	0	0	
49095	26	1	31601	30	0.5	0	0	0	0	0	
49095	27	1	31602	30	0.5	0	0	0	0	0	
49095	28	1	31603	30	1	0	0	0	0	0	
49095	29	1	31604	30	0.5	0	0	0	0	0	
49095	30	1	31605	30	1	0	0	0	0	0	
49095	31	1	31606	30	1	0	0	0	0	0	
49095	32	1	31607	30	1	0	0	0	0	0	
49095	33	1	40023	4	1	0	0	0	0	0	
49095	34	1	40024	2	1	0	0	0	0	0	
49095	35	1	40025	4	1	0	0	0	0	0	
49095	36	1	40026	2	1	0	0	0	0	0	
49095	37	1	40027	4	1	0	0	0	0	0	
49095	38	1	40028	2	1	0	0	0	0	0	
49095	39	1	40029	4	1	0	0	0	0	0	
49095	40	1	40030	2	1	0	0	0	0	0	
49095	41	1	40031	4	1	0	0	0	0	0	
49095	42	1	40032	2	1	0	0	0	0	0	
49095	43	1	40209	2	1	0	0	0	0	0	
49095	44	1	40210	1	1	0	0	0	0	0	
49095	45	1	40211	2	1	0	0	0	0	0	
49095	46	1	40212	1	1	0	0	0	0	0	
49095	47	1	40213	2	1	0	0	0	0	0	
49095	48	1	40214	1	1	0	0	0	0	0	
49095	49	1	40215	2	1	0	0	0	0	0	
49095	50	1	40216	1	1	0	0	0	0	0	
49095	51	1	40217	2	1	0	0	0	0	0	
49095	52	1	40218	1	1	0	0	0	0	0	
49095	53	1	34279	4	11.65	0	0	0	0	0	
49095	54	1	40033	160	1	0	0	0	0	0	
49095	55	1	40034	160	1	0	0	0	0	0	
49095	56	1	40035	95	1	0	0	0	0	0	
49095	57	1	40036	80	1	0	0	0	0	0	
49095	58	1	40037	70	1	0	0	0	0	0	
49095	59	1	40038	160	1	0	0	0	0	0	
49095	60	1	40039	120	1	0	0	0	0	0	
49095	61	1	40104	95	1	0	0	0	0	0	
49095	62	1	40105	80	1	0	0	0	0	0	
49095	63	1	40106	70	1	0	0	0	0	0	
49096	1	1	34937	1	7	0	0	0	0	0	
49096	2	1	34938	1	5	0	0	0	0	0	
49096	3	1	34939	1	3	0	0	0	0	0	
49096	4	1	34940	1	7	0	0	0	0	0	
49096	5	1	34941	1	5	0	0	0	0	0	
49096	6	1	34942	1	3	0	0	0	0	0	
49096	7	1	40368	1	2	0	0	0	0	0	
49096	8	1	40369	1	1	0	0	0	0	0	
49096	9	1	40370	1	0.05	0	0	0	0	0	
49096	10	1	34426	1	12	0	0	0	0	0	
49096	11	1	33516	1	0.1	0	0	0	0	0	
49096	12	1	33519	1	0.1	0	0	0	0	0	
49096	13	1	34403	1	1.2	0	0	0	0	0	
49096	14	1	34404	1	1.2	0	0	0	0	0	
49096	15	1	34405	1	1.2	0	0	0	0	0	
49096	16	1	34406	1	1.2	0	0	0	0	0	
49096	17	1	34407	1	1.2	0	0	0	0	0	
49096	18	1	34408	1	1.2	0	0	0	0	0	
49096	19	1	34427	1	0.1	0	0	0	0	0	
49096	20	1	34428	1	0.1	0	0	0	0	0	
49096	21	1	34429	1	0.1	0	0	0	0	0	
49096	22	1	31510	30	0.1	0	0	0	0	0	
49096	23	1	31511	30	0.1	0	0	0	0	0	
49096	24	1	31512	30	0.1	0	0	0	0	0	
49096	25	1	31601	30	0.5	0	0	0	0	0	
49096	26	1	31602	30	0.5	0	0	0	0	0	
49096	27	1	31603	30	1	0	0	0	0	0	
49096	28	1	31604	30	0.5	0	0	0	0	0	
49096	29	1	31605	30	1	0	0	0	0	0	
49096	30	1	31606	30	1	0	0	0	0	0	
49096	31	1	31607	30	1	0	0	0	0	0	
49096	32	1	40023	4	1	0	0	0	0	0	
49096	33	1	40024	2	1	0	0	0	0	0	
49096	34	1	40025	4	1	0	0	0	0	0	
49096	35	1	40026	2	1	0	0	0	0	0	
49096	36	1	40027	4	1	0	0	0	0	0	
49096	37	1	40028	2	1	0	0	0	0	0	
49096	38	1	40029	4	1	0	0	0	0	0	
49096	39	1	40030	2	1	0	0	0	0	0	
49096	40	1	40031	4	1	0	0	0	0	0	
49096	41	1	40032	2	1	0	0	0	0	0	
49096	42	1	40209	2	1	0	0	0	0	0	
49096	43	1	40210	1	1	0	0	0	0	0	
49096	44	1	40211	2	1	0	0	0	0	0	
49096	45	1	40212	1	1	0	0	0	0	0	
49096	46	1	40213	2	1	0	0	0	0	0	
49096	47	1	40214	1	1	0	0	0	0	0	
49096	48	1	40215	2	1	0	0	0	0	0	
49096	49	1	40216	1	1	0	0	0	0	0	
49096	50	1	40217	2	1	0	0	0	0	0	
49096	51	1	40218	1	1	0	0	0	0	0	
49096	52	1	34279	4	11.45	0	0	0	0	0	
49096	53	1	40033	160	1	0	0	0	0	0	
49096	54	1	40034	160	1	0	0	0	0	0	
49096	55	1	40035	95	1	0	0	0	0	0	
49096	56	1	40036	80	1	0	0	0	0	0	
49096	57	1	40037	70	1	0	0	0	0	0	
49096	58	1	40038	160	1	0	0	0	0	0	
49096	59	1	40039	120	1	0	0	0	0	0	
49096	60	1	40104	95	1	0	0	0	0	0	
49096	61	1	40105	80	1	0	0	0	0	0	
49096	62	1	40106	70	1	0	0	0	0	0	
49097	1	1	34937	1	7	0	0	0	0	0	
49097	2	1	34938	1	5	0	0	0	0	0	
49097	3	1	34939	1	3	0	0	0	0	0	
49097	4	1	34940	1	7	0	0	0	0	0	
49097	5	1	34941	1	5	0	0	0	0	0	
49097	6	1	34942	1	3	0	0	0	0	0	
49097	7	1	40368	1	2	0	0	0	0	0	
49097	8	1	40369	1	1	0	0	0	0	0	
49097	9	1	40370	1	0.05	0	0	0	0	0	
49097	10	1	34426	1	12	0	0	0	0	0	
49097	11	1	33517	1	0.1	0	0	0	0	0	
49097	12	1	33520	1	0.1	0	0	0	0	0	
49097	13	1	34410	1	1.2	0	0	0	0	0	
49097	14	1	34411	1	1.2	0	0	0	0	0	
49097	15	1	34413	1	1.2	0	0	0	0	0	
49097	16	1	34414	1	1.2	0	0	0	0	0	
49097	17	1	34412	1	1.2	0	0	0	0	0	
49097	18	1	34415	1	1.2	0	0	0	0	0	
49097	19	1	34427	1	0.1	0	0	0	0	0	
49097	20	1	34428	1	0.1	0	0	0	0	0	
49097	21	1	34429	1	0.1	0	0	0	0	0	
49097	22	1	31510	30	0.1	0	0	0	0	0	
49097	23	1	31511	30	0.1	0	0	0	0	0	
49097	24	1	31512	30	0.1	0	0	0	0	0	
49097	25	1	31601	30	0.5	0	0	0	0	0	
49097	26	1	31602	30	0.5	0	0	0	0	0	
49097	27	1	31603	30	1	0	0	0	0	0	
49097	28	1	31604	30	0.5	0	0	0	0	0	
49097	29	1	31605	30	1	0	0	0	0	0	
49097	30	1	31606	30	1	0	0	0	0	0	
49097	31	1	31607	30	1	0	0	0	0	0	
49097	32	1	40023	4	1	0	0	0	0	0	
49097	33	1	40024	2	1	0	0	0	0	0	
49097	34	1	40025	4	1	0	0	0	0	0	
49097	35	1	40026	2	1	0	0	0	0	0	
49097	36	1	40027	4	1	0	0	0	0	0	
49097	37	1	40028	2	1	0	0	0	0	0	
49097	38	1	40029	4	1	0	0	0	0	0	
49097	39	1	40030	2	1	0	0	0	0	0	
49097	40	1	40031	4	1	0	0	0	0	0	
49097	41	1	40032	2	1	0	0	0	0	0	
49097	42	1	40209	2	1	0	0	0	0	0	
49097	43	1	40210	1	1	0	0	0	0	0	
49097	44	1	40211	2	1	0	0	0	0	0	
49097	45	1	40212	1	1	0	0	0	0	0	
49097	46	1	40213	2	1	0	0	0	0	0	
49097	47	1	40214	1	1	0	0	0	0	0	
49097	48	1	40215	2	1	0	0	0	0	0	
49097	49	1	40216	1	1	0	0	0	0	0	
49097	50	1	40217	2	1	0	0	0	0	0	
49097	51	1	40218	1	1	0	0	0	0	0	
49097	52	1	34279	4	11.45	0	0	0	0	0	
49097	53	1	40033	160	1	0	0	0	0	0	
49097	54	1	40034	160	1	0	0	0	0	0	
49097	55	1	40035	95	1	0	0	0	0	0	
49097	56	1	40036	80	1	0	0	0	0	0	
49097	57	1	40037	70	1	0	0	0	0	0	
49097	58	1	40038	160	1	0	0	0	0	0	
49097	59	1	40039	120	1	0	0	0	0	0	
49097	60	1	40104	95	1	0	0	0	0	0	
49097	61	1	40105	80	1	0	0	0	0	0	
49097	62	1	40106	70	1	0	0	0	0	0	
49098	1	1	40465	1	1	1	0	0	0	0	
49098	2	1	40534	1	3	0	0	0	0	0	
49098	3	1	40532	1	5	0	0	0	0	0	
49098	4	1	40487	1	1	0	0	0	0	0	
49098	5	1	40489	1	2.5	0	0	0	0	0	
49098	6	1	40159	1	1	0	0	0	0	0	
49098	7	1	40170	1	2.5	0	0	0	0	0	
49098	8	1	40236	1	1	0	0	0	0	0	
49098	9	1	40261	1	2.5	0	0	0	0	0	
49098	10	1	40164	1	1	0	0	0	0	0	
49098	11	1	40175	1	2.5	0	0	0	0	0	
49098	12	1	40471	1	2	0	0	0	0	0	
49098	13	1	40335	1	2	0	0	0	0	0	
49098	14	1	40336	1	1	0	0	0	0	0	
49098	15	1	40337	1	4	0	0	0	0	0	
49098	16	1	40338	1	2	0	0	0	0	0	
49098	17	1	40273	1	1	0	0	0	0	0	
49098	18	1	40274	1	0.5	0	0	0	0	0	
49098	19	1	40350	1	0.5	0	0	0	0	0	
49098	20	1	40156	7	10	0	0	0	0	0	
49098	21	1	40157	3	10	0	0	0	0	0	
49098	22	1	40158	2	5	0	0	0	0	0	
49098	23	1	40181	4	3	0	0	0	0	0	
49098	24	1	40182	2	3	0	0	0	0	0	
49098	25	1	41088	80	4	0	0	0	0	0	
49098	26	1	40122	18	5	0	0	0	0	0	
49098	27	1	40021	3	6	0	0	0	0	0	
49098	28	1	40209	4	1	0	0	0	0	0	
49098	29	1	40211	4	1	0	0	0	0	0	
49098	30	1	40213	4	1	0	0	0	0	0	
49098	31	1	40215	4	1	0	0	0	0	0	
49098	32	1	40217	4	1	0	0	0	0	0	
49098	33	1	40202	12	1	0	0	0	0	0	
49098	34	1	40187	1	3	0	0	0	0	0	
49098	35	1	40020	5	1	0	0	0	0	0	
49098	36	1	40186	2	1	0	0	0	0	0	
49098	37	1	40019	9	1	0	0	0	0	0	
49098	38	1	40200	7	1	0	0	0	0	0	
49098	39	1	40190	7	1	0	0	0	0	0	
49098	40	1	40191	20	1	0	0	0	0	0	
49098	41	1	40192	20	1	0	0	0	0	0	
49098	42	1	40193	20	1	0	0	0	0	0	
49098	43	1	40183	40	1	0	0	0	0	0	
49099	1	1	40466	1	1	1	0	0	0	0	
49099	2	1	40535	1	3	0	0	0	0	0	
49099	3	1	40533	1	5	0	0	0	0	0	
49099	4	1	40440	1	1	0	0	0	0	0	
49099	5	1	40442	1	3	0	0	0	0	0	
49099	6	1	40238	1	1	0	0	0	0	0	
49099	7	1	40263	1	3	0	0	0	0	0	
49099	8	1	40399	1	1	0	0	0	0	0	
49099	9	1	40402	1	3	0	0	0	0	0	
49099	10	1	40195	1	1	0	0	0	0	0	
49099	11	1	40198	1	3	0	0	0	0	0	
49099	12	1	40335	1	2	0	0	0	0	0	
49099	13	1	40336	1	1	0	0	0	0	0	
49099	14	1	40337	1	4	0	0	0	0	0	
49099	15	1	40338	1	2	0	0	0	0	0	
49099	16	1	40273	1	1	0	0	0	0	0	
49099	17	1	40274	1	0.5	0	0	0	0	0	
49099	18	1	40350	1	0.5	0	0	0	0	0	
49099	19	1	40156	7	10	0	0	0	0	0	
49099	20	1	40157	3	10	0	0	0	0	0	
49099	21	1	40158	2	5	0	0	0	0	0	
49099	22	1	40181	4	3	0	0	0	0	0	
49099	23	1	40182	2	3	0	0	0	0	0	
49099	24	1	41088	80	4	0	0	0	0	0	
49099	25	1	40122	18	5	0	0	0	0	0	
49099	26	1	40021	3	6	0	0	0	0	0	
49099	27	1	40209	4	1	0	0	0	0	0	
49099	28	1	40211	4	1	0	0	0	0	0	
49099	29	1	40213	4	1	0	0	0	0	0	
49099	30	1	40215	4	1	0	0	0	0	0	
49099	31	1	40217	4	1	0	0	0	0	0	
49099	32	1	40202	45	1	0	0	0	0	0	
49099	33	1	40187	1	3	0	0	0	0	0	
49099	34	1	40020	5	1	0	0	0	0	0	
49099	35	1	40186	5	1	0	0	0	0	0	
49099	36	1	40019	9	1	0	0	0	0	0	
49099	37	1	40200	7	1	0	0	0	0	0	
49099	38	1	40190	7	1	0	0	0	0	0	
49099	39	1	40191	20	1	0	0	0	0	0	
49099	40	1	40192	20	1	0	0	0	0	0	
49099	41	1	40193	20	1	0	0	0	0	0	
49099	42	1	40183	40	1	0	0	0	0	0	
49100	1	1	40538	1	100	0	0	0	0	0	
49100	2	2	40539	20	100	0	0	0	0	0	
49103	1	1	34148	1	0.01	1	0	0	0	0	
49103	2	1	34149	1	0.005	1	0	0	0	0	
49103	3	1	40373	1	0.01	1	0	0	0	0	
49103	4	1	40374	1	0.005	1	0	0	0	0	
49103	5	1	40459	1	0.01	1	0	0	0	0	
49103	6	1	40460	1	0.005	1	0	0	0	0	
49103	7	1	40461	1	0.01	1	0	0	0	0	
49103	8	1	40462	1	0.005	1	0	0	0	0	
49103	9	1	40463	1	0.01	1	0	0	0	0	
49103	10	1	40464	1	0.005	1	0	0	0	0	
49103	11	1	34937	2	3	0	0	0	0	0	
49103	12	1	34938	2	3	0	0	0	0	0	
49103	13	1	34939	2	3	0	0	0	0	0	
49103	14	1	34940	2	3	0	0	0	0	0	
49103	15	1	34941	2	3	0	0	0	0	0	
49103	16	1	34942	2	3	0	0	0	0	0	
49103	17	1	34943	1	0.3	0	0	0	0	0	
49103	18	1	34944	1	0.3	0	0	0	0	0	
49103	19	1	34945	1	0.3	0	0	0	0	0	
49103	20	1	34946	1	0.3	0	0	0	0	0	
49103	21	1	34947	1	0.2	0	0	0	0	0	
49103	22	1	34948	1	0.2	0	0	0	0	0	
49103	23	1	34949	1	0.2	0	0	0	0	0	
49103	24	1	34950	1	0.2	0	0	0	0	0	
49103	25	1	34951	1	0.1	0	0	0	0	0	
49103	26	1	34952	1	0.1	0	0	0	0	0	
49103	27	1	34953	1	0.1	0	0	0	0	0	
49103	28	1	34954	1	0.1	0	0	0	0	0	
49103	29	1	34932	1	0.02	1	0	0	0	0	
49103	30	1	34933	1	0.01	1	0	0	0	0	
49103	31	1	31969	3	3	0	0	0	0	0	
49103	32	1	31970	3	3	0	0	0	0	0	
49103	33	1	31971	3	3	0	0	0	0	0	
49103	34	1	31972	3	3	0	0	0	0	0	
49103	35	1	31973	3	3	0	0	0	0	0	
49103	36	1	31974	3	3	0	0	0	0	0	
49103	37	1	31975	3	3	0	0	0	0	0	
49103	38	1	31976	3	3	0	0	0	0	0	
49103	39	1	31977	3	3	0	0	0	0	0	
49103	40	1	31978	3	3	0	0	0	0	0	
49103	41	1	34396	1	0.4	0	0	0	0	0	
49103	42	1	34397	1	0.4	0	0	0	0	0	
49103	43	1	34398	1	0.4	0	0	0	0	0	
49103	44	1	34399	1	0.4	0	0	0	0	0	
49103	45	1	34400	1	0.4	0	0	0	0	0	
49103	46	1	34401	1	0.4	0	0	0	0	0	
49103	47	1	34402	1	0.4	0	0	0	0	0	
49103	48	1	34403	1	0.4	0	0	0	0	0	
49103	49	1	34404	1	0.4	0	0	0	0	0	
49103	50	1	34405	1	0.4	0	0	0	0	0	
49103	51	1	34406	1	0.4	0	0	0	0	0	
49103	52	1	34407	1	0.4	0	0	0	0	0	
49103	53	1	34408	1	0.4	0	0	0	0	0	
49103	54	1	34410	1	0.4	0	0	0	0	0	
49103	55	1	34411	1	0.4	0	0	0	0	0	
49103	56	1	34412	1	0.4	0	0	0	0	0	
49103	57	1	34413	1	0.4	0	0	0	0	0	
49103	58	1	34414	1	0.4	0	0	0	0	0	
49103	59	1	34415	1	0.4	0	0	0	0	0	
49103	60	1	34886	2	5	0	0	0	0	0	
49103	61	1	34887	2	5	0	0	0	0	0	
49103	62	1	34888	2	2	0	0	0	0	0	
49103	63	1	34889	2	2	0	0	0	0	0	
49103	64	1	34426	2	3	0	0	0	0	0	
49103	65	1	34427	1	0.1	0	0	0	0	0	
49103	66	1	34428	1	0.1	0	0	0	0	0	
49103	67	1	34429	1	0.1	0	0	0	0	0	
49103	68	1	34279	4	14.595	0	0	0	0	0	
49103	69	1	40292	3	2	0	0	0	0	0	
49103	70	1	40293	3	2	0	0	0	0	0	
49103	71	1	40294	3	2	0	0	0	0	0	
49103	72	1	40295	3	2	0	0	0	0	0	
49103	73	1	40296	3	2	0	0	0	0	0	
49104	1	1	35957	1	2	0	0	0	0	0	
49104	3	1	35941	1	2	0	0	0	0	0	
49104	4	1	35943	1	2	0	0	0	0	0	
49104	5	1	35945	1	2	0	0	0	0	0	
49104	6	1	35946	1	2	0	0	0	0	0	
49104	7	1	35952	1	2	0	0	0	0	0	
49104	8	1	35954	1	2	0	0	0	0	0	
49104	9	1	35750	1	3	0	0	0	0	0	
49104	10	1	35934	1	2.5	0	0	0	0	0	
49104	11	1	35935	1	2.5	0	0	0	0	0	
49104	12	1	35932	3	4.5	0	0	0	0	0	
49104	13	1	35933	3	4.5	0	0	0	0	0	
49104	14	1	35960	3	4	0	0	0	0	0	
49104	15	1	35736	5	5	0	0	0	0	0	
49104	16	1	35737	5	5	0	0	0	0	0	
49104	17	1	35738	5	5	0	0	0	0	0	
49104	18	1	35739	5	5	0	0	0	0	0	
49104	19	1	35740	5	5	0	0	0	0	0	
49104	20	1	35741	5	5	0	0	0	0	0	
49104	21	1	35743	10	5	0	0	0	0	0	
49104	22	1	35744	10	5	0	0	0	0	0	
49104	23	1	35745	10	5	0	0	0	0	0	
49104	24	1	35746	10	5	0	0	0	0	0	
49104	25	1	35747	10	5	0	0	0	0	0	
49104	26	1	35748	10	5	0	0	0	0	0	
49104	27	1	35749	10	5	0	0	0	0	0	
49105	1	1	40022	1	15	0	0	0	0	0	
49105	2	1	40158	1	15	0	0	0	0	0	
49105	3	1	40113	1	5.5	0	0	0	0	0	
49105	4	1	40184	1	6.5	0	0	0	0	0	
49105	5	1	40362	2	15	0	0	0	0	0	
49105	6	1	41091	1	3	0	0	0	0	0	
49105	7	1	41092	1	3	0	0	0	0	0	
49105	8	1	40380	1	3	0	0	0	0	0	
49105	9	1	40201	1	12	0	0	0	0	0	
49105	10	1	40153	3	7	0	0	0	0	0	
49105	11	1	40155	3	7	0	0	0	0	0	
49105	12	1	40467	1	3	0	0	0	0	0	
49105	13	1	40225	1	3	0	0	0	0	0	
49105	14	1	40312	1	1	0	0	0	0	0	
49105	15	1	40372	1	0.5	0	0	0	0	0	
49105	16	1	40336	1	0.3	1	0	0	0	0	
49105	17	1	40511	1	0.2	1	0	0	0	0	
49106	1	1	34994	1	100	0	0	0	0	0	
49106	2	2	34928	26	100	0	0	0	0	0	
49107	1	1	34995	1	100	0	0	0	0	0	
49107	2	2	34928	24	100	0	0	0	0	0	
49108	1	1	34996	1	100	0	0	0	0	0	
49108	2	2	34928	22	100	0	0	0	0	0	
49109	1	1	34997	1	100	0	0	0	0	0	
49109	2	2	34928	18	100	0	0	0	0	0	
49110	1	1	34998	1	100	0	0	0	0	0	
49110	2	2	34928	16	100	0	0	0	0	0	
49111	1	1	34999	1	100	0	0	0	0	0	
49111	2	2	34928	14	100	0	0	0	0	0	
49112	1	1	34997	1	100	0	0	0	0	0	
49112	2	2	34928	18	100	0	0	0	0	0	
49113	1	1	34998	1	100	0	0	0	0	0	
49113	2	2	34928	16	100	0	0	0	0	0	
49114	1	1	34999	1	100	0	0	0	0	0	
49114	2	2	34928	14	100	0	0	0	0	0	
49115	1	1	34997	1	100	0	0	0	0	0	
49115	2	2	34928	26	100	0	0	0	0	0	
49116	1	1	34998	1	100	0	0	0	0	0	
49116	2	2	34928	24	100	0	0	0	0	0	
49117	1	1	34999	1	100	0	0	0	0	0	
49117	2	2	34928	22	100	0	0	0	0	0	
49118	1	1	34989	1	100	0	0	0	0	0	
49118	2	2	34928	12	100	0	0	0	0	0	
49119	1	1	34989	1	100	0	0	0	0	0	
49119	2	2	34928	11	100	0	0	0	0	0	
49120	1	1	34989	1	100	0	0	0	0	0	
49120	2	2	34928	10	100	0	0	0	0	0	
49121	1	1	34989	1	100	0	0	0	0	0	
49121	2	2	34928	8	100	0	0	0	0	0	
49122	1	1	34989	1	100	0	0	0	0	0	
49122	2	2	34928	8	100	0	0	0	0	0	
49123	1	1	34989	1	100	0	0	0	0	0	
49123	2	2	34928	8	100	0	0	0	0	0	
49124	1	1	34989	1	100	0	0	0	0	0	
49124	2	2	34928	8	100	0	0	0	0	0	
49101	1	1	34279	5	4	0	0	0	0	0	
49101	2	1	30799	8	0.5	0	0	0	0	0	
49101	3	1	30800	8	0.5	0	0	0	0	0	
49101	4	1	30801	8	0.5	0	0	0	0	0	
49101	5	1	30802	8	0.5	0	0	0	0	0	
49101	6	1	30803	8	0.5	0	0	0	0	0	
49101	7	1	30804	8	0.5	0	0	0	0	0	
49101	8	1	30805	8	0.5	0	0	0	0	0	
49101	9	1	30806	8	0.5	0	0	0	0	0	
49101	10	1	30807	8	0.5	0	0	0	0	0	
49101	11	1	30808	8	0.5	0	0	0	0	0	
49101	12	1	30809	8	0.5	0	0	0	0	0	
49101	13	1	30810	8	0.5	0	0	0	0	0	
49101	14	1	30811	8	0.5	0	0	0	0	0	
49101	15	1	30812	8	0.5	0	0	0	0	0	
49101	16	1	30813	8	0.5	0	0	0	0	0	
49101	17	1	30814	8	0.5	0	0	0	0	0	
49101	18	1	30815	8	0.5	0	0	0	0	0	
49101	19	1	30816	8	0.5	0	0	0	0	0	
49101	20	1	30817	8	0.5	0	0	0	0	0	
49101	21	1	30818	8	0.5	0	0	0	0	0	
49101	22	1	30819	8	0.5	0	0	0	0	0	
49101	23	1	30820	8	0.5	0	0	0	0	0	
49101	24	1	30821	8	0.5	0	0	0	0	0	
49101	25	1	30822	8	0.5	0	0	0	0	0	
49101	26	1	30823	8	0.5	0	0	0	0	0	
49101	27	1	30824	8	0.5	0	0	0	0	0	
49101	28	1	30825	8	0.5	0	0	0	0	0	
49101	29	1	30826	8	0.5	0	0	0	0	0	
49101	30	1	30827	8	0.5	0	0	0	0	0	
49101	31	1	30828	8	0.5	0	0	0	0	0	
49101	32	1	30829	8	0.5	0	0	0	0	0	
49101	33	1	30830	8	0.5	0	0	0	0	0	
49101	34	1	30831	8	0.5	0	0	0	0	0	
49101	35	1	30832	8	0.5	0	0	0	0	0	
49101	36	1	30833	8	0.5	0	0	0	0	0	
49101	37	1	30834	8	0.5	0	0	0	0	0	
49101	38	1	30835	8	0.5	0	0	0	0	0	
49101	39	1	30836	8	0.5	0	0	0	0	0	
49101	40	1	30837	8	0.5	0	0	0	0	0	
49101	41	1	30838	8	0.5	0	0	0	0	0	
49101	42	1	30839	8	0.5	0	0	0	0	0	
49101	43	1	30840	8	0.5	0	0	0	0	0	
49101	44	1	30841	8	0.5	0	0	0	0	0	
49101	45	1	30842	8	0.5	0	0	0	0	0	
49101	46	1	30843	8	0.5	0	0	0	0	0	
49101	47	1	30844	8	0.5	0	0	0	0	0	
49101	48	1	30845	8	0.5	0	0	0	0	0	
49101	49	1	30846	8	0.5	0	0	0	0	0	
49101	50	1	30847	2	0.5	0	0	0	0	0	
49101	51	1	30848	2	0.5	0	0	0	0	0	
49101	52	1	30849	2	0.5	0	0	0	0	0	
49101	53	1	30850	2	0.5	0	0	0	0	0	
49101	54	1	30851	2	0.5	0	0	0	0	0	
49101	55	1	30852	2	0.5	0	0	0	0	0	
49101	56	1	30853	2	0.5	0	0	0	0	0	
49101	57	1	30854	2	0.5	0	0	0	0	0	
49101	58	1	30855	2	0.5	0	0	0	0	0	
49101	59	1	30856	2	0.5	0	0	0	0	0	
49101	60	1	30857	2	0.5	0	0	0	0	0	
49101	61	1	30858	2	0.5	0	0	0	0	0	
49101	62	1	30859	2	0.5	0	0	0	0	0	
49101	63	1	31969	3	2	0	0	0	0	0	
49101	64	1	31970	3	2	0	0	0	0	0	
49101	65	1	31971	3	2	0	0	0	0	0	
49101	66	1	31972	3	2	0	0	0	0	0	
49101	67	1	31973	3	2	0	0	0	0	0	
49101	68	1	31974	3	2	0	0	0	0	0	
49101	69	1	31975	3	2	0	0	0	0	0	
49101	70	1	31976	3	2	0	0	0	0	0	
49101	71	1	31977	3	2	0	0	0	0	0	
49101	72	1	31978	3	2	0	0	0	0	0	
49101	73	1	34155	3	2	0	0	0	0	0	
49101	74	1	34156	3	2	0	0	0	0	0	
49101	75	1	35678	5	0.5	0	0	0	0	0	
49101	76	1	35682	5	0.5	0	0	0	0	0	
49101	77	1	35686	5	0.5	0	0	0	0	0	
49101	78	1	31299	5	2	0	0	0	0	0	
49101	79	1	31300	5	2	0	0	0	0	0	
49101	80	1	31301	5	2	0	0	0	0	0	
49101	81	1	31302	5	2	0	0	0	0	0	
49101	82	1	31303	5	2	0	0	0	0	0	
49101	83	1	31304	5	2	0	0	0	0	0	
49101	84	1	34886	2	2	0	0	0	0	0	
49101	85	1	34887	2	2	0	0	0	0	0	
49101	86	1	34888	1	2	0	0	0	0	0	
49101	87	1	34889	1	2	0	0	0	0	0	
49101	88	1	30006	15	2	0	0	0	0	0	
49101	89	1	30007	15	2	0	0	0	0	0	
49101	90	1	30008	15	2	0	0	0	0	0	
49101	91	1	30009	15	2	0	0	0	0	0	
49101	92	1	35875	15	2	0	0	0	0	0	
49101	93	1	30011	15	2	0	0	0	0	0	
49101	94	1	30012	15	2	0	0	0	0	0	
49101	95	1	30013	15	2	0	0	0	0	0	
49101	96	1	30014	15	2	0	0	0	0	0	
49101	97	1	35878	15	2	0	0	0	0	0	
49102	1	1	40543	1	2	0	0	0	0	0	
49102	2	1	40544	1	1.5	0	0	0	0	0	
49102	3	1	40545	1	1	0	0	0	0	0	
49102	4	1	40546	1	0.5	1	0	0	0	0	
49102	5	1	40368	1	0.8	0	0	0	0	0	
49102	6	1	40369	1	0.2	0	0	0	0	0	
49102	7	1	40370	1	0.05	1	0	0	0	0	
49102	8	1	40156	3	3	0	0	0	0	0	
49102	9	1	40157	1	3	0	0	0	0	0	
49102	10	1	40158	1	2	0	0	0	0	0	
49102	11	1	30847	2	1	0	0	0	0	0	
49102	12	1	30848	2	1	0	0	0	0	0	
49102	13	1	30849	2	1	0	0	0	0	0	
49102	14	1	30850	2	1	0	0	0	0	0	
49102	15	1	30851	2	1	0	0	0	0	0	
49102	16	1	30852	2	1	0	0	0	0	0	
49102	17	1	30853	2	1	0	0	0	0	0	
49102	18	1	30854	2	1	0	0	0	0	0	
49102	19	1	30855	2	1	0	0	0	0	0	
49102	20	1	30856	2	1	0	0	0	0	0	
49102	21	1	30857	2	1	0	0	0	0	0	
49102	22	1	30858	2	1	0	0	0	0	0	
49102	23	1	30859	2	1	0	0	0	0	0	
49102	24	1	35957	3	1	0	0	0	0	0	
49102	25	1	35941	5	1	0	0	0	0	0	
49102	26	1	35943	5	1	0	0	0	0	0	
49102	27	1	35945	5	1	0	0	0	0	0	
49102	28	1	35946	5	1	0	0	0	0	0	
49102	29	1	35952	5	1	0	0	0	0	0	
49102	30	1	35954	5	1	0	0	0	0	0	
49102	31	1	35750	5	1	0	0	0	0	0	
49102	32	1	35934	5	1	0	0	0	0	0	
49102	33	1	35935	5	1	0	0	0	0	0	
49102	34	1	35932	7	1	0	0	0	0	0	
49102	35	1	35933	7	1	0	0	0	0	0	
49102	36	1	35960	7	1	0	0	0	0	0	
49102	37	1	35736	7	1	0	0	0	0	0	
49102	38	1	35737	7	1	0	0	0	0	0	
49102	39	1	35738	7	1	0	0	0	0	0	
49102	40	1	35739	7	1.5	0	0	0	0	0	
49102	41	1	35740	7	1.5	0	0	0	0	0	
49102	42	1	35741	7	1.5	0	0	0	0	0	
49102	43	1	35743	7	1.5	0	0	0	0	0	
49102	44	1	35744	7	1.5	0	0	0	0	0	
49102	45	1	35745	7	1.5	0	0	0	0	0	
49102	46	1	35746	7	1.5	0	0	0	0	0	
49102	47	1	35747	7	1.5	0	0	0	0	0	
49102	48	1	35748	7	1.5	0	0	0	0	0	
49102	49	1	35749	7	1.5	0	0	0	0	0	
49102	50	1	34396	1	0.4	0	0	0	0	0	
49102	51	1	34397	1	0.4	0	0	0	0	0	
49102	52	1	34398	1	0.4	0	0	0	0	0	
49102	53	1	34399	1	0.4	0	0	0	0	0	
49102	54	1	34400	1	0.4	0	0	0	0	0	
49102	55	1	34401	1	0.4	0	0	0	0	0	
49102	56	1	34402	1	0.4	0	0	0	0	0	
49102	57	1	34403	1	0.4	0	0	0	0	0	
49102	58	1	34404	1	0.4	0	0	0	0	0	
49102	59	1	34405	1	0.4	0	0	0	0	0	
49102	60	1	34406	1	0.4	0	0	0	0	0	
49102	61	1	34407	1	0.4	0	0	0	0	0	
49102	62	1	34408	1	0.4	0	0	0	0	0	
49102	63	1	34410	1	0.4	0	0	0	0	0	
49102	64	1	34411	1	0.4	0	0	0	0	0	
49102	65	1	34412	1	0.4	0	0	0	0	0	
49102	66	1	34413	1	0.4	0	0	0	0	0	
49102	67	1	34414	1	0.4	0	0	0	0	0	
49102	68	1	34415	1	0.4	0	0	0	0	0	
49102	69	1	34937	2	2	0	0	0	0	0	
49102	70	1	34938	2	1	0	0	0	0	0	
49102	71	1	34939	2	1	0	0	0	0	0	
49102	72	1	34940	2	1.35	0	0	0	0	0	
49102	73	1	34941	2	1	0	0	0	0	0	
49102	74	1	34942	2	1	0	0	0	0	0	
49102	75	1	34943	1	1	0	0	0	0	0	
49102	76	1	34944	1	1	0	0	0	0	0	
49102	77	1	34945	1	1	0	0	0	0	0	
49102	78	1	34946	1	1	0	0	0	0	0	
49102	79	1	34947	1	1	0	0	0	0	0	
49102	80	1	34948	1	1	0	0	0	0	0	
49102	81	1	34949	1	1	0	0	0	0	0	
49102	82	1	34950	1	1	0	0	0	0	0	
49102	83	1	34951	1	1	0	0	0	0	0	
49102	84	1	34952	1	1	0	0	0	0	0	
49102	85	1	34953	1	1	0	0	0	0	0	
49102	86	1	34954	1	1	0	0	0	0	0	
49102	87	1	40209	2	2	0	0	0	0	0	
49102	88	1	40211	2	2	0	0	0	0	0	
49102	89	1	40213	2	2	0	0	0	0	0	
49102	90	1	40215	2	2	0	0	0	0	0	
49102	91	1	40217	2	2	0	0	0	0	0	
49102	92	1	40202	5	1	0	0	0	0	0	
49102	93	1	40190	3	1	0	0	0	0	0	
49102	94	1	40191	7	1	0	0	0	0	0	
49102	95	1	40192	7	1	0	0	0	0	0	
49102	96	1	40193	7	1	0	0	0	0	0	
49131	1	1	40604	1	1	1	0	0	0	0	
49131	2	1	40605	1	0.5	1	0	0	0	0	
49131	3	1	40606	1	2	0	0	0	0	0	
49131	4	1	40607	1	1	0	0	0	0	0	
49131	5	1	40265	1	0.5	1	0	0	0	0	
49131	6	1	40266	1	0.25	1	0	0	0	0	
49131	7	1	40269	1	1.5	0	0	0	0	0	
49131	8	1	40270	1	0.75	0	0	0	0	0	
49131	9	1	40365	1	0.5	1	0	0	0	0	
49131	10	1	40366	1	0.25	1	0	0	0	0	
49131	11	1	33521	1	0.5	1	0	0	0	0	
49131	12	1	33522	1	0.25	1	0	0	0	0	
49131	13	1	33490	1	1	0	0	0	0	0	
49131	14	1	40057	1	4	0	0	0	0	0	
49131	15	1	40063	1	3	0	0	0	0	0	
49131	16	1	40125	1	1	0	0	0	0	0	
49131	17	1	40126	1	1	0	0	0	0	0	
49131	18	1	40143	1	1	0	0	0	0	0	
49131	19	1	40225	1	1	0	0	0	0	0	
49131	20	1	40229	1	1	0	0	0	0	0	
49131	21	1	40250	1	3	0	0	0	0	0	
49131	22	1	40254	1	2	0	0	0	0	0	
49131	23	1	40275	1	3	0	0	0	0	0	
49131	29	1	40362	2	40	0	0	0	0	0	
49131	30	1	40033	160	3	0	0	0	0	0	
49131	31	1	40034	120	3	0	0	0	0	0	
49131	32	1	40035	95	3	0	0	0	0	0	
49131	33	1	40036	70	3	0	0	0	0	0	
49131	34	1	40037	70	3	0	0	0	0	0	
49131	35	1	40038	160	3	0	0	0	0	0	
49131	36	1	40039	120	3	0	0	0	0	0	
49131	37	1	40104	95	3	0	0	0	0	0	
49131	38	1	40105	70	3	0	0	0	0	0	
49131	39	1	40106	70	3	0	0	0	0	0	
49133	1	1	40564	1	100	0	0	0	0	0	
49133	2	2	40610	1	100	0	0	0	0	0	
49133	3	3	40611	1	100	0	0	0	0	0	
49134	1	1	40568	1	100	0	0	0	0	0	
49134	2	2	40612	1	100	0	0	0	0	0	
49134	3	3	40613	1	100	0	0	0	0	0	
49135	1	1	40560	1	100	0	0	0	0	0	
49135	2	2	40608	1	100	0	0	0	0	0	
49135	3	3	40609	1	100	0	0	0	0	0	
49139	1	1	40347	1	1	1	0	0	0	0	
49139	2	1	40346	1	1	1	0	0	0	0	
49139	3	1	40349	1	1	1	0	0	0	0	
49139	4	1	40344	1	3	0	0	0	0	0	
49139	5	1	40345	1	3	0	0	0	0	0	
49139	6	1	40348	1	3	0	0	0	0	0	
49139	7	1	34992	1	1	1	0	0	0	0	
49139	8	1	35015	1	3	0	0	0	0	0	
49139	9	1	40335	1	1.5	1	0	0	0	0	
49139	10	1	40336	1	0.5	1	0	0	0	0	
49139	11	1	40337	1	3.5	0	0	0	0	0	
49139	12	1	40338	1	1.5	0	0	0	0	0	
49139	13	1	34130	5	10	0	0	0	0	0	
49139	14	1	34131	5	10	0	0	0	0	0	
49139	15	1	34132	5	10	0	0	0	0	0	
49139	16	1	35470	1	6.5	0	0	0	0	0	
49139	17	1	35471	1	5	0	0	0	0	0	
49139	18	1	35472	1	5	0	0	0	0	0	
49139	19	1	35473	1	3.5	0	0	0	0	0	
49139	20	1	35474	1	3.5	0	0	0	0	0	
49139	21	1	35475	1	6.5	0	0	0	0	0	
49139	22	1	35476	1	5	0	0	0	0	0	
49139	23	1	35477	1	5	0	0	0	0	0	
49139	24	1	35478	1	3.5	0	0	0	0	0	
49139	25	1	35479	1	3.5	0	0	0	0	0	
49142	1	1	40195	1	0.3	1	0	0	0	0	
49142	2	1	40198	1	2	0	0	0	0	0	
49142	3	1	40488	1	1	1	0	0	0	0	
49142	4	1	40662	1	3	0	0	0	0	0	
49142	5	1	40665	1	0.5	1	0	0	0	0	
49142	6	1	40666	1	2.2	0	0	0	0	0	
49142	7	1	40638	1	1.5	0	0	0	0	0	
49142	8	1	40639	1	1.5	0	0	0	0	0	
49142	9	1	40640	1	1.5	0	0	0	0	0	
49142	10	1	40641	1	1.5	0	0	0	0	0	
49142	11	1	40642	1	2	0	0	0	0	0	
49142	12	1	40643	1	2	0	0	0	0	0	
49142	13	1	40644	1	4	0	0	0	0	0	
49142	14	1	40645	1	2	0	0	0	0	0	
49142	15	1	40646	1	2	0	0	0	0	0	
49142	16	1	40647	1	4	0	0	0	0	0	
49142	17	1	40648	1	3	0	0	0	0	0	
49142	18	1	40649	1	3	0	0	0	0	0	
49142	19	1	40650	1	2	0	0	0	0	0	
49142	20	1	40651	1	2	0	0	0	0	0	
49142	21	1	40652	1	4	0	0	0	0	0	
49142	22	1	40653	1	4	0	0	0	0	0	
49142	23	1	40202	7	5	0	0	0	0	0	
49142	24	1	40190	5	2	0	0	0	0	0	
49142	25	1	40191	11	2	0	0	0	0	0	
49142	26	1	40192	11	4	0	0	0	0	0	
49142	27	1	40193	11	4	0	0	0	0	0	
49142	28	1	40039	120	5.5	0	0	0	0	0	
49142	29	1	40038	160	5.5	0	0	0	0	0	
49142	30	1	40034	160	5.5	0	0	0	0	0	
49142	31	1	40033	160	5.5	0	0	0	0	0	
49142	32	1	40035	95	6	0	0	0	0	0	
49142	33	1	40104	95	6	0	0	0	0	0	
49142	34	2	35992	2	100	0	0	0	0	0	
49143	1	1	36244	1	100	0	0	0	0	0	
49143	2	2	36245	1	100	0	0	0	0	0	
49143	3	3	36246	1	100	0	0	0	0	0	
49143	4	4	36247	1	100	0	0	0	0	0	
49143	5	5	36248	1	100	0	0	0	0	0	
49144	1	1	36249	1	100	0	0	0	0	0	
49144	2	2	36250	1	100	0	0	0	0	0	
49144	3	3	36251	1	100	0	0	0	0	0	
49144	4	4	36252	1	100	0	0	0	0	0	
49144	5	5	36253	1	100	0	0	0	0	0	
49145	1	1	36254	1	100	0	0	0	0	0	
49145	2	2	36255	1	100	0	0	0	0	0	
49145	3	3	36256	1	100	0	0	0	0	0	
49145	4	4	36257	1	100	0	0	0	0	0	
49145	5	5	36258	1	100	0	0	0	0	0	
49146	1	1	36259	1	100	0	0	0	0	0	
49146	2	2	36260	1	100	0	0	0	0	0	
49146	3	3	36261	1	100	0	0	0	0	0	
49146	4	4	36262	1	100	0	0	0	0	0	
49146	5	5	36263	1	100	0	0	0	0	0	
49147	1	1	36264	1	100	0	0	0	0	0	
49147	2	2	36265	1	100	0	0	0	0	0	
49147	3	3	36266	1	100	0	0	0	0	0	
49147	4	4	36267	1	100	0	0	0	0	0	
49147	5	5	36268	1	100	0	0	0	0	0	
49148	1	1	36269	1	100	0	0	0	0	0	
49148	2	2	36270	1	100	0	0	0	0	0	
49148	3	3	36271	1	100	0	0	0	0	0	
49148	4	4	36272	1	100	0	0	0	0	0	
49148	5	5	36273	1	100	0	0	0	0	0	
49149	1	1	36274	1	100	0	0	0	0	0	
49149	2	2	36275	1	100	0	0	0	0	0	
49149	3	3	36276	1	100	0	0	0	0	0	
49149	4	4	36277	1	100	0	0	0	0	0	
49149	5	5	36278	1	100	0	0	0	0	0	
49150	1	1	36279	1	100	0	0	0	0	0	
49150	2	2	36280	1	100	0	0	0	0	0	
49150	3	3	36281	1	100	0	0	0	0	0	
49150	4	4	36282	1	100	0	0	0	0	0	
49150	5	5	36283	1	100	0	0	0	0	0	
49151	1	1	36284	1	100	0	0	0	0	0	
49151	2	2	36285	1	100	0	0	0	0	0	
49151	3	3	36286	1	100	0	0	0	0	0	
49151	4	4	36287	1	100	0	0	0	0	0	
49151	5	5	36288	1	100	0	0	0	0	0	
49152	1	1	36289	1	100	0	0	0	0	0	
49152	2	2	36290	1	100	0	0	0	0	0	
49152	3	3	36291	1	100	0	0	0	0	0	
49152	4	4	36292	1	100	0	0	0	0	0	
49152	5	5	36293	1	100	0	0	0	0	0	
49153	1	1	36294	1	100	0	0	0	0	0	
49153	2	2	36295	1	100	0	0	0	0	0	
49153	3	3	36296	1	100	0	0	0	0	0	
49153	4	4	36297	1	100	0	0	0	0	0	
49153	5	5	36298	1	100	0	0	0	0	0	
49154	1	1	36299	1	100	0	0	0	0	0	
49154	2	2	36300	1	100	0	0	0	0	0	
49154	3	3	36301	1	100	0	0	0	0	0	
49154	4	4	36302	1	100	0	0	0	0	0	
49154	5	5	36303	1	100	0	0	0	0	0	
49155	1	1	40681	1	0.5	1	0	0	0	0	
49155	2	1	40682	1	0.5	1	0	0	0	0	
49155	3	1	40683	1	1.5	0	0	0	0	0	
49155	4	1	40684	1	1	1	0	0	0	0	
49155	5	1	40685	1	3	0	0	0	0	0	
49155	6	1	40656	1	1.5	0	0	0	0	0	
49155	7	1	40679	1	2.5	0	0	0	0	0	
49155	8	1	40657	1	2	0	0	0	0	0	
49155	9	1	40680	1	3.5	0	0	0	0	0	
49155	10	1	40158	1	5	0	0	0	0	0	
49155	11	1	40157	2	10	0	0	0	0	0	
49155	12	1	40182	1	3	0	0	0	0	0	
49155	13	1	40021	3	5	0	0	0	0	0	
49155	14	1	40367	1	1.5	0	0	0	0	0	
49155	15	1	40187	1	3	0	0	0	0	0	
49155	16	1	40362	2	10	0	0	0	0	0	
49155	17	1	40156	4	10	0	0	0	0	0	
49155	18	1	40181	3	3	0	0	0	0	0	
49155	19	1	41088	45	4	0	0	0	0	0	
49155	20	1	40122	10	5	0	0	0	0	0	
49155	21	1	40209	2	1	0	0	0	0	0	
49155	22	1	40211	2	1	0	0	0	0	0	
49155	23	1	40213	2	1	0	0	0	0	0	
49155	24	1	40215	2	1	0	0	0	0	0	
49155	25	1	40217	2	1	0	0	0	0	0	
49155	26	1	40202	7	1	0	0	0	0	0	
49155	27	1	40020	3	3	0	0	0	0	0	
49155	28	1	40019	5	1.5	0	0	0	0	0	
49155	29	1	40200	4	1	0	0	0	0	0	
49155	30	1	40190	5	2	0	0	0	0	0	
49155	31	1	40191	11	2	0	0	0	0	0	
49155	32	1	40192	11	2	0	0	0	0	0	
49155	33	1	40193	11	2	0	0	0	0	0	
49155	34	1	40183	22	5	0	0	0	0	0	
49156	1	1	40159	1	0.3	0	0	0	0	0	
49156	2	1	40160	1	0.3	0	0	0	0	0	
49156	3	1	40161	1	0.3	0	0	0	0	0	
49156	4	1	40162	1	0.3	0	0	0	0	0	
49156	5	1	40163	1	0.3	0	0	0	0	0	
49156	6	1	40164	1	0.3	0	0	0	0	0	
49156	7	1	40165	1	0.3	0	0	0	0	0	
49156	8	1	40166	1	0.3	0	0	0	0	0	
49156	9	1	40167	1	0.3	0	0	0	0	0	
49156	10	1	40168	1	0.3	0	0	0	0	0	
49156	11	1	40223	1	0.3	0	0	0	0	0	
49156	12	1	40224	1	0.3	0	0	0	0	0	
49156	13	1	40225	1	0.3	0	0	0	0	0	
49156	14	1	40226	1	0.3	0	0	0	0	0	
49156	15	1	40227	1	0.3	0	0	0	0	0	
49156	16	1	40228	1	0.3	0	0	0	0	0	
49156	17	1	40229	1	0.3	0	0	0	0	0	
49156	18	1	40230	1	0.3	0	0	0	0	0	
49156	19	1	40231	1	0.3	0	0	0	0	0	
49156	20	1	40247	1	0.3	0	0	0	0	0	
49156	21	1	40170	1	1.5	0	0	0	0	0	
49156	22	1	40171	1	1.5	0	0	0	0	0	
49156	23	1	40172	1	1.5	0	0	0	0	0	
49156	24	1	40173	1	1.5	0	0	0	0	0	
49156	25	1	40174	1	1.5	0	0	0	0	0	
49156	26	1	40175	1	1.5	0	0	0	0	0	
49156	27	1	40176	1	1.5	0	0	0	0	0	
49156	28	1	40177	1	1.5	0	0	0	0	0	
49156	29	1	40178	1	1.5	0	0	0	0	0	
49156	30	1	40179	1	1.5	0	0	0	0	0	
49156	31	1	40248	1	1.5	0	0	0	0	0	
49156	32	1	40249	1	1.5	0	0	0	0	0	
49156	33	1	40250	1	1.5	0	0	0	0	0	
49156	34	1	40251	1	1.5	0	0	0	0	0	
49156	35	1	40252	1	1.5	0	0	0	0	0	
49156	36	1	40253	1	1.5	0	0	0	0	0	
49156	37	1	40254	1	1.5	0	0	0	0	0	
49156	38	1	40255	1	1.5	0	0	0	0	0	
49156	39	1	40256	1	1.5	0	0	0	0	0	
49156	40	1	40327	1	0.3	0	0	0	0	0	
49156	41	1	40328	1	0.3	0	0	0	0	0	
49156	42	1	40329	1	0.3	0	0	0	0	0	
49156	43	1	40330	1	1.5	0	0	0	0	0	
49156	44	1	40344	1	1.5	0	0	0	0	0	
49156	45	1	40346	1	2	0	0	0	0	0	
49156	46	1	40438	1	1.2	0	0	0	0	0	
49156	47	1	40362	2	28.4	0	0	0	0	0	
49156	48	1	40033	160	3	0	0	0	0	0	
49156	49	1	40034	160	3	0	0	0	0	0	
49156	50	1	40035	95	3	0	0	0	0	0	
49156	51	1	40036	80	3	0	0	0	0	0	
49156	52	1	40037	70	3	0	0	0	0	0	
49156	53	1	40038	160	3	0	0	0	0	0	
49156	54	1	40039	120	3	0	0	0	0	0	
49156	55	1	40104	95	3	0	0	0	0	0	
49156	56	1	40105	80	3	0	0	0	0	0	
49156	57	1	40106	70	3	0	0	0	0	0	
49157	1	1	40194	1	0.15	1	0	0	0	0	
49157	2	1	40375	1	0.15	1	0	0	0	0	
49157	3	1	40195	1	0.15	1	0	0	0	0	
49157	4	1	40196	1	0.15	1	0	0	0	0	
49157	5	1	40232	1	0.15	1	0	0	0	0	
49157	6	1	40233	1	0.15	1	0	0	0	0	
49157	7	1	40347	1	0.15	1	0	0	0	0	
49157	8	1	40400	1	0.15	1	0	0	0	0	
49157	9	1	40437	1	0.15	1	0	0	0	0	
49157	10	1	40490	1	2	0	0	0	0	0	
49157	11	1	40197	1	3	0	0	0	0	0	
49157	12	1	40198	1	3	0	0	0	0	0	
49157	13	1	40199	1	3	0	0	0	0	0	
49157	14	1	40257	1	3	0	0	0	0	0	
49157	15	1	40258	1	3	0	0	0	0	0	
49157	16	1	40345	1	3	0	0	0	0	0	
49157	17	1	40403	1	3	0	0	0	0	0	
49157	18	1	40441	1	3	0	0	0	0	0	
49157	19	1	40362	2	52.8	0	0	0	0	0	
49157	20	1	40033	160	2	0	0	0	0	0	
49157	21	1	40034	160	2	0	0	0	0	0	
49157	22	1	40035	95	2	0	0	0	0	0	
49157	23	1	40036	80	2	0	0	0	0	0	
49157	24	1	40037	70	2	0	0	0	0	0	
49157	25	1	40038	160	1.85	0	0	0	0	0	
49157	26	1	40039	120	2	0	0	0	0	0	
49157	27	1	40104	95	2	0	0	0	0	0	
49157	28	1	40105	80	2	0	0	0	0	0	
49157	29	1	40106	70	2	0	0	0	0	0	
49158	1	1	40236	1	1	1	0	0	0	0	
49158	2	1	40237	1	1	1	0	0	0	0	
49158	3	1	40238	1	1	1	0	0	0	0	
49158	4	1	40169	1	1	1	0	0	0	0	
49158	5	1	40399	1	0.5	1	0	0	0	0	
49158	6	1	40440	1	0.5	1	0	0	0	0	
49158	7	1	40180	1	4	0	0	0	0	0	
49158	8	1	40261	1	5	0	0	0	0	0	
49158	9	1	40262	1	4	0	0	0	0	0	
49158	10	1	40263	1	4	0	0	0	0	0	
49158	11	1	40402	1	4	0	0	0	0	0	
49158	12	1	40442	1	4	0	0	0	0	0	
49158	13	1	40362	2	50	0	0	0	0	0	
49158	14	1	40033	160	2	0	0	0	0	0	
49158	15	1	40034	160	2	0	0	0	0	0	
49158	16	1	40035	95	2	0	0	0	0	0	
49158	17	1	40036	80	2	0	0	0	0	0	
49158	18	1	40037	70	2	0	0	0	0	0	
49158	19	1	40038	160	2	0	0	0	0	0	
49158	20	1	40039	120	2	0	0	0	0	0	
49158	21	1	40104	95	2	0	0	0	0	0	
49158	22	1	40105	80	2	0	0	0	0	0	
49158	23	1	40106	70	2	0	0	0	0	0	
49159	1	1	40152	5	3	0	0	0	0	0	
49159	2	1	40153	5	1	0	0	0	0	0	
49159	3	1	40154	5	3	0	0	0	0	0	
49159	4	1	40155	5	1	0	0	0	0	0	
49159	5	1	40200	4	10	0	0	0	0	0	
49159	6	1	40201	1	5	0	0	0	0	0	
49159	7	1	40186	1	12	0	0	0	0	0	
49159	8	1	40187	1	10	0	0	0	0	0	
49159	9	1	40188	1	8	0	0	0	0	0	
49159	10	1	40317	1	2.5	0	0	0	0	0	
49159	11	1	40189	1	0.5	0	0	0	0	0	
49159	12	1	40183	22	10	0	0	0	0	0	
49159	13	1	40184	1	1	0	0	0	0	0	
49159	14	1	40185	3	3	0	0	0	0	0	
49159	15	1	40380	1	2	0	0	0	0	0	
49159	16	1	40362	2	18	0	0	0	0	0	
49159	17	1	40033	160	1	0	0	0	0	0	
49159	18	1	40034	160	1	0	0	0	0	0	
49159	19	1	40035	95	1	0	0	0	0	0	
49159	20	1	40036	80	1	0	0	0	0	0	
49159	21	1	40037	70	1	0	0	0	0	0	
49159	22	1	40038	160	1	0	0	0	0	0	
49159	23	1	40039	120	1	0	0	0	0	0	
49159	24	1	40104	95	1	0	0	0	0	0	
49159	25	1	40105	80	1	0	0	0	0	0	
49159	26	1	40106	70	1	0	0	0	0	0	
49160	1	1	40019	5	5	0	0	0	0	0	
49160	2	1	40020	5	5	0	0	0	0	0	
49160	3	1	40021	2	5	0	0	0	0	0	
49160	4	1	40022	2	3	0	0	0	0	0	
49160	5	1	40023	4	1	0	0	0	0	0	
49160	6	1	40024	2	1	0	0	0	0	0	
49160	7	1	40025	4	1	0	0	0	0	0	
49160	8	1	40026	2	1	0	0	0	0	0	
49160	9	1	40027	4	1	0	0	0	0	0	
49160	10	1	40028	2	1	0	0	0	0	0	
49160	11	1	40029	4	1	0	0	0	0	0	
49160	12	1	40030	2	1	0	0	0	0	0	
49160	13	1	40031	4	1	0	0	0	0	0	
49160	14	1	40032	2	1	0	0	0	0	0	
49160	15	1	40209	2	1	0	0	0	0	0	
49160	16	1	40210	1	1	0	0	0	0	0	
49160	17	1	40211	2	1	0	0	0	0	0	
49160	18	1	40212	1	1	0	0	0	0	0	
49160	19	1	40213	2	1	0	0	0	0	0	
49160	20	1	40214	1	1	0	0	0	0	0	
49160	21	1	40215	2	1	0	0	0	0	0	
49160	22	1	40216	1	1	0	0	0	0	0	
49160	23	1	40217	2	1	0	0	0	0	0	
49160	24	1	40218	1	1	0	0	0	0	0	
49160	25	1	40113	1	4	0	0	0	0	0	
49160	26	1	40222	1	1	0	0	0	0	0	
49160	27	1	40273	1	0.5	0	0	0	0	0	
49160	28	1	40274	1	0.2	0	0	0	0	0	
49160	29	1	40350	1	0.3	0	0	0	0	0	
49160	30	1	40156	4	10	0	0	0	0	0	
49160	31	1	40157	2	10	0	0	0	0	0	
49160	32	1	40158	1	5	0	0	0	0	0	
49160	33	1	40181	3	3	0	0	0	0	0	
49160	34	1	40182	1	3	0	0	0	0	0	
49160	35	1	41088	45	10	0	0	0	0	0	
49160	36	1	40122	10	5	0	0	0	0	0	
49160	37	1	40362	2	5	0	0	0	0	0	
49160	38	1	40033	160	0.5	0	0	0	0	0	
49160	39	1	40034	160	0.5	0	0	0	0	0	
49160	40	1	40035	95	0.5	0	0	0	0	0	
49160	41	1	40036	80	0.5	0	0	0	0	0	
49160	42	1	40037	70	0.5	0	0	0	0	0	
49160	43	1	40038	160	0.5	0	0	0	0	0	
49160	44	1	40039	120	0.5	0	0	0	0	0	
49160	45	1	40104	95	0.5	0	0	0	0	0	
49160	46	1	40105	80	0.5	0	0	0	0	0	
49160	47	1	40106	70	0.5	0	0	0	0	0	
49161	1	1	40331	1	0.8	1	0	0	0	0	
49161	2	1	40332	1	0.2	1	0	0	0	0	
49161	3	1	40265	1	0.8	1	0	0	0	0	
49161	4	1	40266	1	0.2	1	0	0	0	0	
49161	5	1	40267	1	0.8	1	0	0	0	0	
49161	6	1	40268	1	0.2	1	0	0	0	0	
49161	7	1	40335	1	0.8	1	0	0	0	0	
49161	8	1	40336	1	0.2	1	0	0	0	0	
49161	9	1	40333	1	2	0	0	0	0	0	
49161	10	1	40334	1	1	0	0	0	0	0	
49161	11	1	40269	1	2	0	0	0	0	0	
49161	12	1	40270	1	1	0	0	0	0	0	
49161	13	1	40271	1	2	0	0	0	0	0	
49161	14	1	40272	1	1	0	0	0	0	0	
49161	15	1	40337	1	2	0	0	0	0	0	
49161	16	1	40338	1	1	0	0	0	0	0	
49161	17	1	40362	2	54	0	0	0	0	0	
49161	18	1	40033	160	3	0	0	0	0	0	
49161	19	1	40034	160	3	0	0	0	0	0	
49161	20	1	40035	95	3	0	0	0	0	0	
49161	21	1	40036	80	3	0	0	0	0	0	
49161	22	1	40037	70	3	0	0	0	0	0	
49161	23	1	40038	160	3	0	0	0	0	0	
49161	24	1	40039	120	3	0	0	0	0	0	
49161	25	1	40104	95	3	0	0	0	0	0	
49161	26	1	40105	80	3	0	0	0	0	0	
49161	27	1	40106	70	3	0	0	0	0	0	
49162	1	1	34937	1	7	0	0	0	0	0	
49162	2	1	34938	1	5	0	0	0	0	0	
49162	3	1	34939	1	3	0	0	0	0	0	
49162	4	1	34940	1	7	0	0	0	0	0	
49162	5	1	34941	1	5	0	0	0	0	0	
49162	6	1	34942	1	3	0	0	0	0	0	
49162	7	1	40368	1	2	0	0	0	0	0	
49162	8	1	40369	1	1	0	0	0	0	0	
49162	9	1	40370	1	0.05	0	0	0	0	0	
49162	10	1	34426	1	12	0	0	0	0	0	
49162	11	1	33515	1	0.1	0	0	0	0	0	
49162	12	1	33518	1	0.1	0	0	0	0	0	
49162	13	1	34396	1	1	0	0	0	0	0	
49162	14	1	34397	1	1	0	0	0	0	0	
49162	15	1	34398	1	1	0	0	0	0	0	
49162	16	1	34399	1	1	0	0	0	0	0	
49162	17	1	34400	1	1	0	0	0	0	0	
49162	18	1	34401	1	1	0	0	0	0	0	
49162	19	1	34402	1	1	0	0	0	0	0	
49162	20	1	34427	1	0.1	0	0	0	0	0	
49162	21	1	34428	1	0.1	0	0	0	0	0	
49162	22	1	34429	1	0.1	0	0	0	0	0	
49162	23	1	31510	30	0.1	0	0	0	0	0	
49162	24	1	31511	30	0.1	0	0	0	0	0	
49162	25	1	31512	30	0.1	0	0	0	0	0	
49162	26	1	31601	30	0.5	0	0	0	0	0	
49162	27	1	31602	30	0.5	0	0	0	0	0	
49162	28	1	31603	30	1	0	0	0	0	0	
49162	29	1	31604	30	0.5	0	0	0	0	0	
49162	30	1	31605	30	1	0	0	0	0	0	
49162	31	1	31606	30	1	0	0	0	0	0	
49162	32	1	31607	30	1	0	0	0	0	0	
49162	33	1	40023	4	1	0	0	0	0	0	
49162	34	1	40024	2	1	0	0	0	0	0	
49162	35	1	40025	4	1	0	0	0	0	0	
49162	36	1	40026	2	1	0	0	0	0	0	
49162	37	1	40027	4	1	0	0	0	0	0	
49162	38	1	40028	2	1	0	0	0	0	0	
49162	39	1	40029	4	1	0	0	0	0	0	
49162	40	1	40030	2	1	0	0	0	0	0	
49162	41	1	40031	4	1	0	0	0	0	0	
49162	42	1	40032	2	1	0	0	0	0	0	
49162	43	1	40209	2	1	0	0	0	0	0	
49162	44	1	40210	1	1	0	0	0	0	0	
49162	45	1	40211	2	1	0	0	0	0	0	
49162	46	1	40212	1	1	0	0	0	0	0	
49162	47	1	40213	2	1	0	0	0	0	0	
49162	48	1	40214	1	1	0	0	0	0	0	
49162	49	1	40215	2	1	0	0	0	0	0	
49162	50	1	40216	1	1	0	0	0	0	0	
49162	51	1	40217	2	1	0	0	0	0	0	
49162	52	1	40218	1	1	0	0	0	0	0	
49162	53	1	34279	4	11.65	0	0	0	0	0	
49162	54	1	40033	160	1	0	0	0	0	0	
49162	55	1	40034	160	1	0	0	0	0	0	
49162	56	1	40035	95	1	0	0	0	0	0	
49162	57	1	40036	80	1	0	0	0	0	0	
49162	58	1	40037	70	1	0	0	0	0	0	
49162	59	1	40038	160	1	0	0	0	0	0	
49162	60	1	40039	120	1	0	0	0	0	0	
49162	61	1	40104	95	1	0	0	0	0	0	
49162	62	1	40105	80	1	0	0	0	0	0	
49162	63	1	40106	70	1	0	0	0	0	0	
49163	1	1	34937	1	7	0	0	0	0	0	
49163	2	1	34938	1	5	0	0	0	0	0	
49163	3	1	34939	1	3	0	0	0	0	0	
49163	4	1	34940	1	7	0	0	0	0	0	
49163	5	1	34941	1	5	0	0	0	0	0	
49163	6	1	34942	1	3	0	0	0	0	0	
49163	7	1	40368	1	2	0	0	0	0	0	
49163	8	1	40369	1	1	0	0	0	0	0	
49163	9	1	40370	1	0.05	0	0	0	0	0	
49163	10	1	34426	1	12	0	0	0	0	0	
49163	11	1	33516	1	0.1	0	0	0	0	0	
49163	12	1	33519	1	0.1	0	0	0	0	0	
49163	13	1	34403	1	1.2	0	0	0	0	0	
49163	14	1	34404	1	1.2	0	0	0	0	0	
49163	15	1	34405	1	1.2	0	0	0	0	0	
49163	16	1	34406	1	1.2	0	0	0	0	0	
49163	17	1	34407	1	1.2	0	0	0	0	0	
49163	18	1	34408	1	1.2	0	0	0	0	0	
49163	19	1	34427	1	0.1	0	0	0	0	0	
49163	20	1	34428	1	0.1	0	0	0	0	0	
49163	21	1	34429	1	0.1	0	0	0	0	0	
49163	22	1	31510	30	0.1	0	0	0	0	0	
49163	23	1	31511	30	0.1	0	0	0	0	0	
49163	24	1	31512	30	0.1	0	0	0	0	0	
49163	25	1	31601	30	0.5	0	0	0	0	0	
49163	26	1	31602	30	0.5	0	0	0	0	0	
49163	27	1	31603	30	1	0	0	0	0	0	
49163	28	1	31604	30	0.5	0	0	0	0	0	
49163	29	1	31605	30	1	0	0	0	0	0	
49163	30	1	31606	30	1	0	0	0	0	0	
49163	31	1	31607	30	1	0	0	0	0	0	
49163	32	1	40023	4	1	0	0	0	0	0	
49163	33	1	40024	2	1	0	0	0	0	0	
49163	34	1	40025	4	1	0	0	0	0	0	
49163	35	1	40026	2	1	0	0	0	0	0	
49163	36	1	40027	4	1	0	0	0	0	0	
49163	37	1	40028	2	1	0	0	0	0	0	
49163	38	1	40029	4	1	0	0	0	0	0	
49163	39	1	40030	2	1	0	0	0	0	0	
49163	40	1	40031	4	1	0	0	0	0	0	
49163	41	1	40032	2	1	0	0	0	0	0	
49163	42	1	40209	2	1	0	0	0	0	0	
49163	43	1	40210	1	1	0	0	0	0	0	
49163	44	1	40211	2	1	0	0	0	0	0	
49163	45	1	40212	1	1	0	0	0	0	0	
49163	46	1	40213	2	1	0	0	0	0	0	
49163	47	1	40214	1	1	0	0	0	0	0	
49163	48	1	40215	2	1	0	0	0	0	0	
49163	49	1	40216	1	1	0	0	0	0	0	
49163	50	1	40217	2	1	0	0	0	0	0	
49163	51	1	40218	1	1	0	0	0	0	0	
49163	52	1	34279	4	11.45	0	0	0	0	0	
49163	53	1	40033	160	1	0	0	0	0	0	
49163	54	1	40034	160	1	0	0	0	0	0	
49163	55	1	40035	95	1	0	0	0	0	0	
49163	56	1	40036	80	1	0	0	0	0	0	
49163	57	1	40037	70	1	0	0	0	0	0	
49163	58	1	40038	160	1	0	0	0	0	0	
49163	59	1	40039	120	1	0	0	0	0	0	
49163	60	1	40104	95	1	0	0	0	0	0	
49163	61	1	40105	80	1	0	0	0	0	0	
49163	62	1	40106	70	1	0	0	0	0	0	
49164	1	1	34937	1	7	0	0	0	0	0	
49164	2	1	34938	1	5	0	0	0	0	0	
49164	3	1	34939	1	3	0	0	0	0	0	
49164	4	1	34940	1	7	0	0	0	0	0	
49164	5	1	34941	1	5	0	0	0	0	0	
49164	6	1	34942	1	3	0	0	0	0	0	
49164	7	1	40368	1	2	0	0	0	0	0	
49164	8	1	40369	1	1	0	0	0	0	0	
49164	9	1	40370	1	0.05	0	0	0	0	0	
49164	10	1	34426	1	12	0	0	0	0	0	
49164	11	1	33517	1	0.1	0	0	0	0	0	
49164	12	1	33520	1	0.1	0	0	0	0	0	
49164	13	1	34410	1	1.2	0	0	0	0	0	
49164	14	1	34411	1	1.2	0	0	0	0	0	
49164	15	1	34413	1	1.2	0	0	0	0	0	
49164	16	1	34414	1	1.2	0	0	0	0	0	
49164	17	1	34412	1	1.2	0	0	0	0	0	
49164	18	1	34415	1	1.2	0	0	0	0	0	
49164	19	1	34427	1	0.1	0	0	0	0	0	
49164	20	1	34428	1	0.1	0	0	0	0	0	
49164	21	1	34429	1	0.1	0	0	0	0	0	
49164	22	1	31510	30	0.1	0	0	0	0	0	
49164	23	1	31511	30	0.1	0	0	0	0	0	
49164	24	1	31512	30	0.1	0	0	0	0	0	
49164	25	1	31601	30	0.5	0	0	0	0	0	
49164	26	1	31602	30	0.5	0	0	0	0	0	
49164	27	1	31603	30	1	0	0	0	0	0	
49164	28	1	31604	30	0.5	0	0	0	0	0	
49164	29	1	31605	30	1	0	0	0	0	0	
49164	30	1	31606	30	1	0	0	0	0	0	
49164	31	1	31607	30	1	0	0	0	0	0	
49164	32	1	40023	4	1	0	0	0	0	0	
49164	33	1	40024	2	1	0	0	0	0	0	
49164	34	1	40025	4	1	0	0	0	0	0	
49164	35	1	40026	2	1	0	0	0	0	0	
49164	36	1	40027	4	1	0	0	0	0	0	
49164	37	1	40028	2	1	0	0	0	0	0	
49164	38	1	40029	4	1	0	0	0	0	0	
49164	39	1	40030	2	1	0	0	0	0	0	
49164	40	1	40031	4	1	0	0	0	0	0	
49164	41	1	40032	2	1	0	0	0	0	0	
49164	42	1	40209	2	1	0	0	0	0	0	
49164	43	1	40210	1	1	0	0	0	0	0	
49164	44	1	40211	2	1	0	0	0	0	0	
49164	45	1	40212	1	1	0	0	0	0	0	
49164	46	1	40213	2	1	0	0	0	0	0	
49164	47	1	40214	1	1	0	0	0	0	0	
49164	48	1	40215	2	1	0	0	0	0	0	
49164	49	1	40216	1	1	0	0	0	0	0	
49164	50	1	40217	2	1	0	0	0	0	0	
49164	51	1	40218	1	1	0	0	0	0	0	
49164	52	1	34279	4	11.45	0	0	0	0	0	
49164	53	1	40033	160	1	0	0	0	0	0	
49164	54	1	40034	160	1	0	0	0	0	0	
49164	55	1	40035	95	1	0	0	0	0	0	
49164	56	1	40036	80	1	0	0	0	0	0	
49164	57	1	40037	70	1	0	0	0	0	0	
49164	58	1	40038	160	1	0	0	0	0	0	
49164	59	1	40039	120	1	0	0	0	0	0	
49164	60	1	40104	95	1	0	0	0	0	0	
49164	61	1	40105	80	1	0	0	0	0	0	
49164	62	1	40106	70	1	0	0	0	0	0	
49165	1	1	40691	1	0.8	1	0	0	0	0	
49165	2	1	40692	1	0.5	1	0	0	0	0	
49165	3	1	40693	1	1	1	0	0	0	0	
49165	4	1	40196	1	0.3	1	0	0	0	0	
49165	5	1	40511	1	0.1	1	0	0	0	0	
49165	6	1	40512	1	0.02	1	0	0	0	0	
49165	7	1	40694	1	3	0	0	0	0	0	
49165	8	1	40199	1	2.5	0	0	0	0	0	
49165	9	1	40157	2	8.4	0	0	0	0	0	
49165	10	1	40182	2	3	0	0	0	0	0	
49165	11	1	40021	3	5	0	0	0	0	0	
49165	12	1	40367	1	2	0	0	0	0	0	
49165	13	1	40187	1	3	0	0	0	0	0	
49165	14	1	41090	40	10.5	0	0	0	0	0	
49165	15	1	40380	1	4	0	0	0	0	0	
49165	16	1	41088	45	5	0	0	0	0	0	
49165	17	1	40122	10	3	0	0	0	0	0	
49165	18	1	40209	3	1	0	0	0	0	0	
49165	19	1	40211	3	1	0	0	0	0	0	
49165	20	1	40213	3	1	0	0	0	0	0	
49165	21	1	40215	3	1	0	0	0	0	0	
49165	22	1	40217	3	1	0	0	0	0	0	
49165	23	1	40023	4	2	0	0	0	0	0	
49165	24	1	40025	4	2	0	0	0	0	0	
49165	25	1	40027	4	2	0	0	0	0	0	
49165	26	1	40029	4	2	0	0	0	0	0	
49165	27	1	40031	4	2	0	0	0	0	0	
49165	28	1	40104	95	4	0	0	0	0	0	
49165	29	1	40105	80	4	0	0	0	0	0	
49165	30	1	40106	70	4	0	0	0	0	0	
49165	31	1	40035	95	4	0	0	0	0	0	
49165	32	1	40036	80	4	0	0	0	0	0	
49165	33	1	40037	70	4	0	0	0	0	0	
49167	1	1	40701	1	0.25	1	0	0	0	0	
49167	2	1	40703	1	0.75	0	0	0	0	0	
49167	3	1	34988	1	0.5	1	0	0	0	0	
49167	4	1	34983	1	0.25	1	0	0	0	0	
49167	5	1	35011	1	1	0	0	0	0	0	
49167	6	1	35006	1	0.75	0	0	0	0	0	
49167	7	1	40604	1	1	0	0	0	0	0	
49167	8	1	40605	1	0.5	0	0	0	0	0	
49167	9	1	40606	1	1.5	0	0	0	0	0	
49167	10	1	40607	1	1	0	0	0	0	0	
49167	11	1	40331	1	1	0	0	0	0	0	
49167	12	1	40332	1	0.5	0	0	0	0	0	
49167	13	1	40333	1	1.5	0	0	0	0	0	
49167	14	1	40334	1	1	0	0	0	0	0	
49167	15	1	40020	5	5	0	0	0	0	0	
49167	16	1	40021	2	5	0	0	0	0	0	
49167	17	1	40022	2	3	0	0	0	0	0	
49167	18	1	40185	3	2	0	0	0	0	0	
49167	19	1	40273	1	0.5	0	0	0	0	0	
49167	20	1	40274	1	0.2	0	0	0	0	0	
49167	21	1	40350	1	0.3	0	0	0	0	0	
49167	22	1	40317	1	1.5	0	0	0	0	0	
49167	23	1	34279	2	25	0	0	0	0	0	
49167	24	1	41089	1	5	0	0	0	0	0	
49167	25	1	40122	10	5	0	0	0	0	0	
49167	27	1	40034	160	5	0	0	0	0	0	
49167	28	1	40035	95	5	0	0	0	0	0	
49167	29	1	40036	80	4	0	0	0	0	0	
49167	30	1	40037	70	4	0	0	0	0	0	
49167	31	1	40039	120	5	0	0	0	0	0	
49167	32	1	40104	95	5	0	0	0	0	0	
49167	33	1	40105	80	4	0	0	0	0	0	
49167	34	1	40106	70	4	0	0	0	0	0	
49169	1	1	40702	1	0.25	1	0	0	0	0	
49169	2	1	40742	1	1.2	0	0	0	0	0	
49169	3	1	40335	1	1	1	0	0	0	0	
49169	4	1	40337	1	2	0	0	0	0	0	
49169	5	1	40336	1	0.5	1	0	0	0	0	
49169	6	1	40338	1	1.5	0	0	0	0	0	
49169	7	1	34990	1	1	0	0	0	0	0	
49169	8	1	35013	1	3	0	0	0	0	0	
49169	9	1	40114	1	2	0	0	0	0	0	
49169	10	1	40022	2	4	0	0	0	0	0	
49169	11	1	40317	1	2	0	0	0	0	0	
49169	12	1	40572	1	7.55	0	0	0	0	0	
49169	13	1	40362	2	28	0	0	0	0	0	
49169	14	1	41088	45	6	0	0	0	0	0	
49169	15	1	40183	22	5	0	0	0	0	0	
49169	16	1	40033	160	3.5	0	0	0	0	0	
49169	17	1	40034	120	3.5	0	0	0	0	0	
49169	18	1	40035	95	3.5	0	0	0	0	0	
49169	19	1	40036	80	3.5	0	0	0	0	0	
49169	20	1	40037	70	3.5	0	0	0	0	0	
49169	21	1	40038	160	3.5	0	0	0	0	0	
49169	22	1	40039	120	3.5	0	0	0	0	0	
49169	23	1	40104	95	3.5	0	0	0	0	0	
49169	24	1	40105	80	3.5	0	0	0	0	0	
49169	25	1	40106	70	3.5	0	0	0	0	0	
49170	1	1	40743	1	0.5	1	0	0	0	0	
49170	2	1	40744	1	1.5	0	0	0	0	0	
49170	3	1	40745	1	0.5	1	0	0	0	0	
49170	4	1	40746	1	1.5	0	0	0	0	0	
49170	5	1	40751	1	1	0	0	0	0	0	
49170	6	1	40752	1	2	0	0	0	0	0	
49170	7	1	40753	1	0.25	1	0	0	0	0	
49170	8	1	40747	1	0.5	1	0	0	0	0	
49170	9	1	40748	1	1.5	0	0	0	0	0	
49170	10	1	40509	3	10	0	0	0	0	0	
49170	11	1	41093	3	4	0	0	0	0	0	
49170	12	1	41091	1	3	0	0	0	0	0	
49170	13	1	41092	1	2	0	0	0	0	0	
49170	14	1	40200	4	4	0	0	0	0	0	
49170	15	1	40201	1	4	0	0	0	0	0	
49170	16	1	40021	3	5	0	0	0	0	0	
49170	17	1	40022	2	2	0	0	0	0	0	
49170	18	1	40040	12	5	0	0	0	0	0	
49170	19	1	40042	5	5	0	0	0	0	0	
49170	20	1	40572	1	11.75	0	0	0	0	0	
49170	21	1	40033	160	3.5	0	0	0	0	0	
49170	22	1	40034	120	3.5	0	0	0	0	0	
49170	23	1	40035	95	3.5	0	0	0	0	0	
49170	24	1	40036	80	3.5	0	0	0	0	0	
49170	25	1	40037	70	3.5	0	0	0	0	0	
49170	26	1	40038	160	3.5	0	0	0	0	0	
49170	27	1	40039	120	3.5	0	0	0	0	0	
49170	28	1	40104	95	3.5	0	0	0	0	0	
49170	29	1	40105	80	3.5	0	0	0	0	0	
49170	30	1	40106	70	3.5	0	0	0	0	0	
49171	1	1	40737	1	0.5	1	0	0	0	0	
49171	2	1	40738	1	1.75	0	0	0	0	0	
49171	3	1	40755	1	0.3	1	0	0	0	0	
49171	4	1	40756	1	1.5	0	0	0	0	0	
49171	5	1	40331	1	1.5	0	0	0	0	0	
49171	6	1	40332	1	0.75	1	0	0	0	0	
49171	7	1	40333	1	3.2	0	0	0	0	0	
49171	8	1	40334	1	2	0	0	0	0	0	
49171	9	1	40509	3	10	0	0	0	0	0	
49171	10	1	40367	1	2	0	0	0	0	0	
49171	11	1	41088	45	6	0	0	0	0	0	
49171	12	1	40200	4	5	0	0	0	0	0	
49171	13	1	40201	1	5	0	0	0	0	0	
49171	14	1	40021	3	5	0	0	0	0	0	
49171	15	1	40022	2	2	0	0	0	0	0	
49171	16	1	40183	22	5	0	0	0	0	0	
49171	17	1	40572	1	13.5	0	0	0	0	0	
49171	18	1	40033	160	3.5	0	0	0	0	0	
49171	19	1	40034	120	3.5	0	0	0	0	0	
49171	20	1	40035	95	3.5	0	0	0	0	0	
49171	21	1	40036	80	3.5	0	0	0	0	0	
49171	22	1	40037	70	3.5	0	0	0	0	0	
49171	23	1	40038	160	3.5	0	0	0	0	0	
49171	24	1	40039	120	3.5	0	0	0	0	0	
49171	25	1	40104	95	3.5	0	0	0	0	0	
49171	26	1	40105	80	3.5	0	0	0	0	0	
49171	27	1	40106	70	3.5	0	0	0	0	0	
49172	1	1	40757	1	100	0	0	0	0	0	
49172	2	2	40758	1	100	0	0	0	0	0	
49173	1	1	40757	1	100	0	0	0	0	0	
49173	2	2	40759	1	100	0	0	0	0	0	
49174	1	1	40665	1	0.4	1	0	0	0	0	
49174	2	1	40666	1	2	0	0	0	0	0	
49174	3	1	40693	1	0.75	1	0	0	0	0	
49174	4	1	40694	1	2	0	0	0	0	0	
49174	5	1	40169	1	1	0	0	0	0	0	
49174	6	1	40180	1	3	0	0	0	0	0	
49174	7	1	40232	1	0.25	1	0	0	0	0	
49174	8	1	40257	1	1.5	0	0	0	0	0	
49174	9	1	40362	50	0.5	0	0	0	0	0	
49174	9	1	40509	3	10	0	0	0	0	0	
49174	10	1	40317	1	2.5	0	0	0	0	0	
49174	11	1	40380	1	3	0	0	0	0	0	
49174	12	1	40157	2	10	0	0	0	0	0	
49174	13	1	40182	2	5	0	0	0	0	0	
49174	14	1	40021	3	5	0	0	0	0	0	
49174	15	1	40022	2	2	0	0	0	0	0	
49174	16	1	41093	3	2	0	0	0	0	0	
49174	17	1	40572	1	13.5	0	0	0	0	0	
49174	18	1	40033	160	3.5	0	0	0	0	0	
49174	19	1	40034	120	3.5	0	0	0	0	0	
49174	20	1	40035	95	3.6	0	0	0	0	0	
49174	21	1	40036	80	3.6	0	0	0	0	0	
49174	22	1	40037	70	3.6	0	0	0	0	0	
49174	23	1	40038	160	3.5	0	0	0	0	0	
49174	24	1	40039	120	3.5	0	0	0	0	0	
49174	25	1	40104	95	3.6	0	0	0	0	0	
49174	26	1	40105	80	3.6	0	0	0	0	0	
49174	27	1	40106	70	3.6	0	0	0	0	0	
49175	1	1	40791	1	100	0	0	0	0	0	
49175	1	2	40794	1	100	0	0	0	0	0	
49192	1	1	40511	1	0.1	1	0	0	0	0	
49192	2	1	40512	1	0.02	1	0	0	0	0	
49192	3	1	40797	1	1	1	0	0	0	0	
49192	4	1	40798	1	2	0	0	0	0	0	
49192	5	1	40130	1	1	0	0	0	0	0	
49192	6	1	40245	1	1.5	0	0	0	0	0	
49192	7	1	40469	1	1	0	0	0	0	0	
49192	8	1	40470	1	1.5	0	0	0	0	0	
49192	9	1	40134	1	0.5	0	0	0	0	0	
49192	10	1	40144	1	1.5	0	0	0	0	0	
49192	11	1	49175	1	0.5	1	0	0	0	0	
49192	12	1	40509	3	10	0	0	0	0	0	
49192	13	1	40367	1	2	0	0	0	0	0	
49192	14	1	41090	40	10.5	0	0	0	0	0	
49192	15	1	40200	4	5	0	0	0	0	0	
49192	16	1	40201	1	5	0	0	0	0	0	
49192	17	1	40021	3	5	0	0	0	0	0	
49192	18	1	40022	2	2	0	0	0	0	0	
49192	19	1	41093	3	2	0	0	0	0	0	
49192	20	1	40572	1	12.88	0	0	0	0	0	
49192	21	1	40033	160	3.5	0	0	0	0	0	
49192	22	1	40034	120	3.5	0	0	0	0	0	
49192	23	1	40035	95	3.5	0	0	0	0	0	
49192	24	1	40036	80	3.5	0	0	0	0	0	
49192	25	1	40037	70	3.5	0	0	0	0	0	
49192	26	1	40038	160	3.5	0	0	0	0	0	
49192	27	1	40039	120	3.5	0	0	0	0	0	
49192	28	1	40104	95	3.5	0	0	0	0	0	
49192	29	1	40105	80	3.5	0	0	0	0	0	
49192	30	1	40106	70	3.5	0	0	0	0	0	
49193	1	1	40247	1	6	0	0	0	0	0	
49193	2	1	40329	1	6	0	0	0	0	0	
49193	3	1	40328	1	6	0	0	0	0	0	
49193	4	1	40349	1	6	0	0	0	0	0	
49193	5	1	34927	1	6	0	0	0	0	0	
49193	6	1	40514	1	6	0	0	0	0	0	
49193	7	1	40656	1	6	0	0	0	0	0	
49193	8	1	40657	1	6	0	0	0	0	0	
49193	9	1	40230	1	4	0	0	0	0	0	
49193	10	1	40246	1	3	0	0	0	0	0	
49193	11	1	40319	1	3	0	0	0	0	0	
49193	12	1	34123	1	3	0	0	0	0	0	
49193	13	1	34122	1	3	0	0	0	0	0	
49193	14	1	34785	1	4	0	0	0	0	0	
49193	15	1	34787	1	4	0	0	0	0	0	
49193	16	1	40743	1	3	0	0	0	0	0	
49193	17	1	40745	1	3	0	0	0	0	0	
49193	18	1	40751	1	4	0	0	0	0	0	
49193	19	1	40747	1	3	0	0	0	0	0	
49193	20	1	40477	1	1.5	0	0	0	0	0	
49193	21	1	40828	1	1.5	0	0	0	0	0	
49193	22	1	40829	1	1.5	0	0	0	0	0	
49193	23	1	40772	1	1.5	0	0	0	0	0	
49193	24	1	40766	1	4.4	0	0	0	0	0	
49193	25	1	40768	1	4.3	0	0	0	0	0	
49193	26	1	40687	1	0.3	1	0	0	0	0	
49194	1	1	40701	1	0.5	1	0	0	0	0	
49194	2	1	40702	1	0.5	1	0	0	0	0	
49194	3	1	40665	1	1	0	0	0	0	0	
49194	4	1	40692	1	1.5	0	0	0	0	0	
49194	5	1	40691	1	1.5	0	0	0	0	0	
49194	6	1	40487	1	2	0	0	0	0	0	
49194	7	1	40471	1	1	0	0	0	0	0	
49194	8	1	40686	1	0.5	1	0	0	0	0	
49194	9	1	40736	1	1	0	0	0	0	0	
49194	10	1	49028	1	3	0	0	0	0	0	
49194	11	1	49029	1	3	0	0	0	0	0	
49194	12	1	49066	1	3	0	0	0	0	0	
49194	13	1	40066	1	3	0	0	0	0	0	
49194	14	1	40067	1	3	0	0	0	0	0	
49194	15	1	40069	1	3	0	0	0	0	0	
49194	16	1	40071	1	3	0	0	0	0	0	
49194	17	1	40545	1	3	0	0	0	0	0	
49194	18	1	40546	1	2.5	0	0	0	0	0	
49194	19	1	40350	1	2.5	0	0	0	0	0	
49194	20	1	40022	3	11	0	0	0	0	0	
49194	21	1	40222	1	4.5	0	0	0	0	0	
49194	22	1	41091	1	6	0	0	0	0	0	
49194	23	1	41093	10	11	0	0	0	0	0	
49194	24	1	40317	1	11	0	0	0	0	0	
49194	25	1	40158	3	18	0	0	0	0	0	
49194	1	2	40782	1	5	0	0	0	0	0	
49194	2	2	40779	1	15	0	0	0	0	0	
49194	3	2	40780	1	15	0	0	0	0	0	
49194	4	2	40781	1	15	0	0	0	0	0	
49194	5	2	40776	1	17	0	0	0	0	0	
49194	6	2	40777	1	17	0	0	0	0	0	
49194	7	2	40778	1	16	0	0	0	0	0	
49195	1	1	40569	10	100	0	0	0	0	0	
49196	1	1	40570	10	100	0	0	0	0	0	
49197	1	1	40571	10	100	0	0	0	0	0	
49198	1	1	41088	20	100	0	0	0	0	0	
49199	1	1	40183	10	100	0	0	0	0	0	
49200	1	1	41090	100	100	0	0	0	0	0	
49201	1	1	40033	50	100	0	0	0	0	0	
49202	1	1	40038	50	100	0	0	0	0	0	
49203	1	1	40034	50	100	0	0	0	0	0	
49204	1	1	40039	50	100	0	0	0	0	0	
49205	1	1	40035	50	100	0	0	0	0	0	
49208	1	1	40104	50	100	0	0	0	0	0	
49206	1	1	40036	50	100	0	0	0	0	0	
49209	1	1	40105	50	100	0	0	0	0	0	
49207	1	1	40037	50	100	0	0	0	0	0	
49210	1	1	40106	50	100	0	0	0	0	0	
49211	1	1	40362	20	100	0	0	0	0	0	
49212	1	1	40362	50	100	0	0	0	0	0	
49213	1	1	40362	100	100	0	0	0	0	0	
49214	1	1	40578	1	1	0	0	0	0	0	
49214	2	1	40465	1	0.5	1	0	0	0	0	
49214	3	1	40579	1	2	0	0	0	0	0	
49214	4	1	40532	1	1.5	0	0	0	0	0	
49214	5	1	40437	1	0.4	1	0	0	0	0	
49214	6	1	40441	1	1.4	0	0	0	0	0	
49214	7	1	40604	1	1	0	0	0	0	0	
49214	8	1	40605	1	0.5	1	0	0	0	0	
49214	9	1	40606	1	2	0	0	0	0	0	
49214	10	1	40607	1	1	0	0	0	0	0	
49214	11	1	40509	3	14.2	0	0	0	0	0	
49214	12	1	40317	1	2.5	0	0	0	0	0	
49214	13	1	40380	1	3	0	0	0	0	0	
49214	14	1	40157	2	10	0	0	0	0	0	
49214	15	1	40182	2	5	0	0	0	0	0	
49214	16	1	40021	3	5	0	0	0	0	0	
49214	17	1	40022	2	2	0	0	0	0	0	
49214	18	1	41093	3	2	0	0	0	0	0	
49214	19	1	40572	1	10	0	0	0	0	0	
49214	20	1	40033	160	3.5	0	0	0	0	0	
49214	21	1	40034	120	3.5	0	0	0	0	0	
49214	22	1	40035	95	3.5	0	0	0	0	0	
49214	23	1	40036	80	3.5	0	0	0	0	0	
49214	24	1	40037	70	3.5	0	0	0	0	0	
49214	25	1	40038	160	3.5	0	0	0	0	0	
49214	26	1	40039	120	3.5	0	0	0	0	0	
49214	27	1	40104	95	3.5	0	0	0	0	0	
49214	28	1	40105	80	3.5	0	0	0	0	0	
49214	29	1	40106	70	3.5	0	0	0	0	0	
49215	1	1	40814	1	0.8	1	0	0	0	0	
49215	2	1	40816	1	0.8	1	0	0	0	0	
49215	3	1	40822	1	1.5	0	0	0	0	0	
49215	4	1	40824	1	1.5	0	0	0	0	0	
49215	5	1	40818	1	0.3	1	0	0	0	0	
49215	6	1	40815	1	2	0	0	0	0	0	
49215	7	1	40817	1	2	0	0	0	0	0	
49215	8	1	40823	1	3	0	0	0	0	0	
49215	9	1	40825	1	3	0	0	0	0	0	
49215	10	1	40819	1	1.5	0	0	0	0	0	
49215	11	1	40509	3	5	0	0	0	0	0	
49215	12	1	40367	1	1.4	0	0	0	0	0	
49215	13	1	41090	40	5	0	0	0	0	0	
49215	14	1	40115	1	1	0	0	0	0	0	
49215	15	1	40022	2	2	0	0	0	0	0	
49215	16	1	41088	45	8	0	0	0	0	0	
49215	17	1	40122	10	5	0	0	0	0	0	
49215	18	1	40572	1	14.2	0	0	0	0	0	
49215	19	1	40190	5	3	0	0	0	0	0	
49215	20	1	40191	11	5	0	0	0	0	0	
49215	21	1	40192	11	5	0	0	0	0	0	
49215	22	1	40193	11	5	0	0	0	0	0	
49215	23	1	41093	3	3	0	0	0	0	0	
49215	24	1	40202	7	5	0	0	0	0	0	
49215	25	1	40040	12	8	0	0	0	0	0	
49215	26	1	40042	5	8	0	0	0	0	0	
49217	1	1	40236	1	1	0	0	0	0	0	
49217	2	1	40237	1	1	0	0	0	0	0	
49217	3	1	40247	1	1	0	0	0	0	0	
49217	4	1	40184	1	12	0	0	0	0	0	
49217	5	1	40157	1	25	0	0	0	0	0	
49217	6	1	40261	1	20	0	0	0	0	0	
49217	7	1	40262	1	20	0	0	0	0	0	
49217	8	1	40109	25	20	0	0	0	0	0	
49218	1	1	40242	1	1	0	0	0	0	0	
49218	2	1	40230	1	1	0	0	0	0	0	
49218	3	1	40246	1	5	0	0	0	0	0	
49218	4	1	41090	50	11	0	0	0	0	0	
49218	5	1	40040	5	16	0	0	0	0	0	
49218	6	1	40042	4	26	0	0	0	0	0	
49218	7	1	40277	1	20	0	0	0	0	0	
49218	8	1	40255	1	20	0	0	0	0	0	
49176	1	1	41099	15	100	0	0	0	0	0	
49176	1	2	41100	15	100	0	0	0	0	0	
49176	1	3	39074	1	100	0	0	0	0	0	
49176	1	4	49177	1	100	0	0	0	0	0	
49177	1	1	41111	5	100	0	0	0	0	0	
49177	1	2	40455	3	100	0	0	0	0	0	
49177	1	3	49178	1	100	0	0	0	0	0	
49178	1	1	41106	5	100	0	0	0	0	0	
49178	1	2	41107	5	100	0	0	0	0	0	
49178	1	3	49179	1	100	0	0	0	0	0	
49179	1	1	41108	1	100	0	0	0	0	0	
49179	1	2	41109	25	100	0	0	0	0	0	
49179	1	3	41110	25	100	0	0	0	0	0	
49179	1	4	49180	1	100	0	0	0	0	0	
49180	1	1	41105	1	100	0	0	0	0	0	
49180	1	2	40456	3	100	0	0	0	0	0	
49180	1	3	49181	1	100	0	0	0	0	0	
49181	1	1	41103	2	100	0	0	0	0	0	
49181	1	2	41122	3	100	0	0	0	0	0	
49181	1	3	49182	1	100	0	0	0	0	0	
49182	1	1	41104	2	100	0	0	0	0	0	
49182	1	2	41118	2	100	0	0	0	0	0	
49182	1	3	41131	3	100	0	0	0	0	0	
49183	1	1	41120	1	100	0	0	0	0	0	
49183	1	2	41121	20	100	0	0	0	0	0	
49183	1	3	41122	3	100	0	0	0	0	0	
49183	1	4	49184	1	100	0	0	0	0	0	
49184	1	1	41123	3	100	0	0	0	0	0	
49184	1	2	41090	200	100	0	0	0	0	0	
49184	1	3	41125	20	100	0	0	0	0	0	
49184	1	4	49185	1	100	0	0	0	0	0	
49185	1	1	41126	1	100	0	0	0	0	0	
49185	1	2	41127	3	100	0	0	0	0	0	
49185	1	3	41128	10	100	0	0	0	0	0	
49185	1	4	49186	1	100	0	0	0	0	0	
49186	1	1	41129	1	100	0	0	0	0	0	
49186	1	2	41130	1	100	0	0	0	0	0	
49186	1	3	41131	3	100	0	0	0	0	0	
49186	1	4	49187	1	100	0	0	0	0	0	
49187	1	1	41132	1	100	0	0	0	0	0	
49187	1	2	41133	1	100	0	0	0	0	0	
49187	1	3	49188	1	100	0	0	0	0	0	
49188	1	1	41134	1	5	0	0	0	0	0	
49188	2	1	41135	1	25	0	0	0	0	0	
49188	3	1	41136	1	20	0	0	0	0	0	
49188	4	1	41137	1	2	0	0	0	0	0	
49188	5	1	41138	1	10	0	0	0	0	0	
49188	6	1	41139	1	5	0	0	0	0	0	
49188	7	1	41140	1	3	0	0	0	0	0	
49188	8	1	41141	1	20	0	0	0	0	0	
49188	9	1	41142	1	10	0	0	0	0	0	
49189	1	1	41099	50	49	0	0	0	0	0	
49189	2	1	41100	50	49	0	0	0	0	0	
49189	3	1	41147	1	2	0	0	0	0	0	
49190	1	1	40019	5	25	0	0	0	0	0	
49190	2	1	40297	100	15	0	0	0	0	0	
49190	3	1	40192	5	20	0	0	0	0	0	
49190	4	1	40191	5	23	0	0	0	0	0	
49190	5	1	40298	100	15	0	0	0	0	0	
49190	6	1	40400	1	0.5	0	0	0	0	0	
49190	7	1	40195	1	0.5	0	0	0	0	0	
49190	8	1	40194	1	1	0	0	0	0	0	
49191	1	1	41153	1	100	0	0	0	0	0	
49191	1	2	41132	1	100	0	0	0	0	0	
49219	1	1	40932	1	100	0	0	0	0	0	
49219	1	2	49190	1	100	0	0	0	0	0	
49220	1	1	40933	1	100	0	0	0	0	0	
49220	1	2	49190	1	100	0	0	0	0	0	
49221	1	1	40934	1	100	0	0	0	0	0	
49221	1	2	49190	1	100	0	0	0	0	0	
49222	1	1	40935	1	100	0	0	0	0	0	
49222	1	2	49190	1	100	0	0	0	0	0	
49223	1	1	40936	1	100	0	0	0	0	0	
49223	1	2	49190	1	100	0	0	0	0	0	
49224	1	1	40937	1	100	0	0	0	0	0	
49224	1	2	49190	1	100	0	0	0	0	0	
49225	1	1	40938	1	100	0	0	0	0	0	
49225	1	2	49190	1	100	0	0	0	0	0	
49226	1	1	40939	1	100	0	0	0	0	0	
49226	1	2	49190	1	100	0	0	0	0	0	
49227	1	1	40940	1	100	0	0	0	0	0	
49227	1	2	49190	1	100	0	0	0	0	0	
49228	1	1	40941	1	100	0	0	0	0	0	
49228	1	2	49190	1	100	0	0	0	0	0	
49229	1	1	40942	1	100	0	0	0	0	0	
49229	1	2	49190	1	100	0	0	0	0	0	
49230	1	1	40943	1	100	0	0	0	0	0	
49230	1	2	49190	1	100	0	0	0	0	0	
49231	1	1	40944	1	100	0	0	0	0	0	
49231	1	2	49190	1	100	0	0	0	0	0	
49232	1	1	40945	1	100	0	0	0	0	0	
49232	1	2	49190	1	100	0	0	0	0	0	
49233	1	1	40946	1	100	0	0	0	0	0	
49233	1	2	49190	1	100	0	0	0	0	0	
49234	1	1	40947	1	100	0	0	0	0	0	
49234	1	2	49190	1	100	0	0	0	0	0	
49235	1	1	40948	1	100	0	0	0	0	0	
49235	1	2	49190	1	100	0	0	0	0	0	
49236	1	1	40949	1	100	0	0	0	0	0	
49236	1	2	49190	1	100	0	0	0	0	0	
49237	1	1	40950	1	100	0	0	0	0	0	
49237	1	2	49190	1	100	0	0	0	0	0	
49238	1	1	40951	1	100	0	0	0	0	0	
49238	1	2	49190	1	100	0	0	0	0	0	
49239	1	1	40952	1	100	0	0	0	0	0	
49239	1	2	49190	1	100	0	0	0	0	0	
49240	1	1	40953	1	100	0	0	0	0	0	
49240	1	2	49190	1	100	0	0	0	0	0	
49241	1	1	40954	1	100	0	0	0	0	0	
49241	1	2	49190	1	100	0	0	0	0	0	
49242	1	1	40955	1	100	0	0	0	0	0	
49242	1	2	49190	1	100	0	0	0	0	0	
49243	1	1	40956	1	100	0	0	0	0	0	
49243	1	2	49190	1	100	0	0	0	0	0	
49244	1	1	40957	1	100	0	0	0	0	0	
49244	1	2	49190	1	100	0	0	0	0	0	
49245	1	1	40958	1	100	0	0	0	0	0	
49245	1	2	49190	1	100	0	0	0	0	0	
49246	1	1	40959	1	100	0	0	0	0	0	
49246	1	2	49190	1	100	0	0	0	0	0	
49247	1	1	40960	1	100	0	0	0	0	0	
49247	1	2	49190	1	100	0	0	0	0	0	
49248	1	1	40961	1	100	0	0	0	0	0	
49248	1	2	49190	1	100	0	0	0	0	0	
49249	1	1	40989	1	100	0	0	0	0	0	
49249	1	2	41103	2	100	0	0	0	0	0	
49249	1	3	41118	2	100	0	0	0	0	0	
49249	1	4	41131	2	100	0	0	0	0	0	
49249	1	5	41122	2	100	0	0	0	0	0	
49250	1	1	40990	1	100	0	0	0	0	0	
49250	1	2	41117	1	100	0	0	0	0	0	
49250	1	3	41119	2	100	0	0	0	0	0	
49250	1	4	41101	2	100	0	0	0	0	0	
49251	1	1	40226	1	1	0	0	0	0	0	
49251	2	1	40069	1	0.3	1	0	0	0	0	
49251	3	1	40267	1	1	0	0	0	0	0	
49251	4	1	40268	1	0.7	1	0	0	0	0	
49251	5	1	34981	1	0.5	1	0	0	0	0	
49251	6	1	40251	1	3	0	0	0	0	0	
49251	7	1	40271	1	2.5	0	0	0	0	0	
49251	8	1	40272	1	2	0	0	0	0	0	
49251	9	1	35004	1	1.5	0	0	0	0	0	
49251	10	1	40509	3	8	0	0	0	0	0	
49251	11	1	40367	1	1.5	0	0	0	0	0	
49251	12	1	41090	40	11	0	0	0	0	0	
49251	13	1	40022	2	2	0	0	0	0	0	
49251	14	1	41083	1	6	0	0	0	0	0	
49251	15	1	40317	1	2.5	0	0	0	0	0	
49251	16	1	40200	4	4	0	0	0	0	0	
49251	17	1	40201	1	4	0	0	0	0	0	
49251	18	1	40156	4	8.5	0	0	0	0	0	
49251	19	1	40190	5	3	0	0	0	0	0	
49251	20	1	40191	11	5	0	0	0	0	0	
49251	21	1	40192	11	5	0	0	0	0	0	
49251	22	1	40193	11	5	0	0	0	0	0	
49251	23	1	41093	3	3	0	0	0	0	0	
49251	24	1	40202	7	8	0	0	0	0	0	
49251	25	1	40183	22	6	0	0	0	0	0	
49251	26	1	41089	1	5	0	0	0	0	0	
49252	1	1	34926	1	12	0	0	0	0	0	
49252	2	1	40515	1	12	0	0	0	0	0	
49252	3	1	40324	1	12	0	0	0	0	0	
49252	4	1	34120	1	12	0	0	0	0	0	
49252	5	1	40744	1	4	0	0	0	0	0	
49252	6	1	40746	1	4	0	0	0	0	0	
49252	7	1	40752	1	4	0	0	0	0	0	
49252	8	1	40748	1	4	0	0	0	0	0	
49252	9	1	40767	1	4	0	0	0	0	0	
49252	10	1	40769	1	4	0	0	0	0	0	
49252	11	1	40771	1	12	0	0	0	0	0	
49252	12	1	40773	1	4	0	0	0	0	0	
49252	13	1	40775	1	12	0	0	0	0	0	
49253	1	1	41103	2	100	0	0	0	0	0	
49253	2	2	41118	2	100	0	0	0	0	0	
49253	3	3	41131	2	100	0	0	0	0	0	
49253	4	4	41122	2	100	0	0	0	0	0	
49254	1	1	41117	1	100	0	0	0	0	0	
49254	2	2	41119	2	100	0	0	0	0	0	
49254	3	3	41101	2	100	0	0	0	0	0	
49255	1	1	41156	1	0.5	1	0	0	0	0	
49255	2	1	41158	1	3	0	0	0	0	0	
49255	3	1	41162	1	1.5	0	0	0	0	0	
49255	4	1	40233	1	0.5	1	0	0	0	0	
49255	5	1	40258	1	3	0	0	0	0	0	
49255	6	1	40427	1	0.8	0	0	0	0	0	
49255	7	1	40428	1	1.3	0	0	0	0	0	
49255	8	1	40440	1	0.8	1	0	0	0	0	
49255	9	1	40442	1	3	0	0	0	0	0	
49255	10	1	40509	3	15	0	0	0	0	0	
49255	11	1	40367	1	1.5	0	0	0	0	0	
49255	12	1	41090	40	12	0	0	0	0	0	
49255	13	1	40273	1	0.5	0	0	0	0	0	
49255	14	1	40274	1	0.2	0	0	0	0	0	
49255	15	1	40350	1	0.3	0	0	0	0	0	
49255	16	1	41091	1	3	0	0	0	0	0	
49255	17	1	40380	1	4.1	0	0	0	0	0	
49255	18	1	41092	1	3	0	0	0	0	0	
49255	19	1	40190	5	4	0	0	0	0	0	
49255	20	1	40191	11	6	0	0	0	0	0	
49255	21	1	40192	11	6	0	0	0	0	0	
49255	22	1	40193	11	6	0	0	0	0	0	
49255	23	1	41093	3	3	0	0	0	0	0	
49255	24	1	40202	7	9	0	0	0	0	0	
49255	25	1	40183	22	6	0	0	0	0	0	
49255	26	1	40122	10	6	0	0	0	0	0	
49256	1	1	40040	1	100	0	0	0	0	0	
49256	1	2	40042	1	100	0	0	0	0	0	
49257	1	1	41155	1	0.4	1	0	0	0	0	
49257	2	1	41157	1	1.5	0	0	0	0	0	
49257	3	1	41161	1	0.8	0	0	0	0	0	
49257	4	1	40236	1	1	1	0	0	0	0	
49257	5	1	34992	1	1	1	0	0	0	0	
49257	6	1	40261	1	3	0	0	0	0	0	
49257	7	1	35015	1	3	0	0	0	0	0	
49257	8	1	40509	3	12.5	0	0	0	0	0	
49257	9	1	40367	1	2	0	0	0	0	0	
49257	10	1	41090	45	10	0	0	0	0	0	
49257	11	1	40200	4	5	0	0	0	0	0	
49257	12	1	40201	1	5	0	0	0	0	0	
49257	13	1	40021	3	5	0	0	0	0	0	
49257	14	1	40022	2	2	0	0	0	0	0	
49257	15	1	40317	1	2.5	0	0	0	0	0	
49257	16	1	40024	2	3	0	0	0	0	0	
49257	17	1	40026	2	3.4	0	0	0	0	0	
49257	18	1	40028	2	3.4	0	0	0	0	0	
49257	19	1	40030	2	3.4	0	0	0	0	0	
49257	20	1	40032	2	3	0	0	0	0	0	
49257	21	1	40313	10	6	0	0	0	0	0	
49257	22	1	40314	10	6	0	0	0	0	0	
49257	23	1	40315	10	6	0	0	0	0	0	
49257	24	1	41163	10	4	0	0	0	0	0	
49257	25	1	41088	45	7.1	0	0	0	0	0	
49258	1	1	33384	1	10	0	0	0	0	0	
49258	2	1	30006	5	15	0	0	0	0	0	
49258	3	1	30011	5	15	0	0	0	0	0	
49258	4	1	31778	1	15	0	0	0	0	0	
49258	5	1	31777	1	15	0	0	0	0	0	
49258	6	1	41164	1	5	0	0	0	0	0	
49258	7	1	41165	1	5	0	0	0	0	0	
49258	8	1	41166	1	5	0	0	0	0	0	
49258	9	1	41167	1	5	0	0	0	0	0	
49258	10	1	41168	1	5	0	0	0	0	0	
49258	11	1	41169	1	5	0	0	0	0	0	
49259	1	1	49281	1	8	0	0	0	0	0	
49259	2	1	49165	1	8	0	0	0	0	0	
49259	3	1	49289	1	8	0	0	0	0	0	
49259	4	1	49330	1	8	0	0	0	0	0	
49259	5	1	49332	1	8	0	0	0	0	0	
49259	6	1	49174	1	8	0	0	0	0	0	
49259	7	1	49269	1	0.5	1	0	0	0	0	
49259	8	1	49255	1	7.5	0	0	0	0	0	
49259	9	1	49257	1	7.5	0	0	0	0	0	
49259	10	1	49317	1	5	0	0	0	0	0	
49259	11	1	49251	1	7.5	0	0	0	0	0	
49259	12	1	49318	1	7	0	0	0	0	0	
49259	13	1	49319	1	7	0	0	0	0	0	
49259	14	1	49311	1	5	0	0	0	0	0	
49259	15	1	49005	1	5	0	0	0	0	0	
49260	1	1	40465	1	0.2	0	0	0	0	0	
49260	2	1	40466	1	0.2	0	0	0	0	0	
49260	3	1	40691	1	0.2	0	0	0	0	0	
49260	4	1	40692	1	0.2	0	0	0	0	0	
49260	5	1	40697	1	0.2	0	0	0	0	0	
49260	6	1	40743	1	0.2	1	0	0	0	0	
49260	7	1	40745	1	0.2	1	0	0	0	0	
49260	8	1	40758	1	0.2	0	0	0	0	0	
49260	9	1	40759	1	0.2	0	0	0	0	0	
49260	10	1	40766	1	0.2	1	0	0	0	0	
49260	11	1	40768	1	0.2	1	0	0	0	0	
49260	12	1	40791	1	0.2	0	0	0	0	0	
49260	13	1	40814	1	0.2	1	0	0	0	0	
49260	14	1	40816	1	0.2	1	0	0	0	0	
49260	15	1	41174	1	0.2	1	0	0	0	0	
49260	16	1	41182	1	0.2	1	0	0	0	0	
49260	17	1	40532	1	2	0	0	0	0	0	
49260	18	1	40533	1	2	0	0	0	0	0	
49260	19	1	40739	1	2	0	0	0	0	0	
49260	20	1	40741	1	2	0	0	0	0	0	
49260	21	1	40744	1	2	0	0	0	0	0	
49260	22	1	40746	1	2	0	0	0	0	0	
49260	23	1	40801	1	2	0	0	0	0	0	
49260	24	1	40803	1	2	0	0	0	0	0	
49260	25	1	40767	1	2	0	0	0	0	0	
49260	26	1	40769	1	2	0	0	0	0	0	
49260	27	1	40792	1	2	0	0	0	0	0	
49260	28	1	40815	1	2	0	0	0	0	0	
49260	29	1	40817	1	2	0	0	0	0	0	
49260	30	1	41175	1	2	0	0	0	0	0	
49260	31	1	41183	1	2	0	0	0	0	0	
49260	32	1	40362	3	46.8	0	0	0	0	0	
49260	33	1	40033	160	2	0	0	0	0	0	
49260	34	1	40034	120	2	0	0	0	0	0	
49260	35	1	40035	95	2	0	0	0	0	0	
49260	36	1	40036	80	2	0	0	0	0	0	
49260	37	1	40037	70	2	0	0	0	0	0	
49260	38	1	40038	160	2	0	0	0	0	0	
49260	39	1	40039	120	2	0	0	0	0	0	
49260	40	1	40104	95	2	0	0	0	0	0	
49260	41	1	40105	80	2	0	0	0	0	0	
49260	42	1	40106	70	2	0	0	0	0	0	
49261	1	1	40614	1	100	0	0	0	0	0	
49261	1	2	40614	1	100	0	0	0	0	0	
49262	1	1	40615	1	100	0	0	0	0	0	
49262	1	2	40615	1	100	0	0	0	0	0	
49263	1	1	41233	1	0.5	1	0	0	0	0	
49263	2	1	41234	1	1.5	0	0	0	0	0	
49263	3	1	41237	1	0.3	1	0	0	0	0	
49263	4	1	41238	1	1.5	0	0	0	0	0	
49263	5	1	37084	1	0.3	0	0	0	0	0	
49263	6	1	37085	1	1	0	0	0	0	0	
49263	7	1	40702	1	0.5	0	0	0	0	0	
49263	8	1	40742	1	2	0	0	0	0	0	
49263	9	1	41196	1	0.4	1	0	0	0	0	
49263	10	1	41197	1	0.2	1	0	0	0	0	
49263	11	1	40509	3	8	0	0	0	0	0	
49263	12	1	40367	1	2	0	0	0	0	0	
49263	13	1	41090	45	8	0	0	0	0	0	
49263	14	1	40021	3	5	0	0	0	0	0	
49263	15	1	40022	2	2	0	0	0	0	0	
49263	16	1	41192	1	2	0	0	0	0	0	
49263	17	1	41193	1	1	0	0	0	0	0	
49263	18	1	40572	1	11.8	0	0	0	0	0	
49263	19	1	40190	5	4	0	0	0	0	0	
49263	20	1	40191	11	6	0	0	0	0	0	
49263	21	1	40192	11	6	0	0	0	0	0	
49263	22	1	40193	11	6	0	0	0	0	0	
49263	23	1	41093	3	3	0	0	0	0	0	
49263	24	1	40202	7	9	0	0	0	0	0	
49263	25	1	40183	22	6	0	0	0	0	0	
49263	26	1	40122	10	6	0	0	0	0	0	
49263	27	1	41188	1	4	0	0	0	0	0	
49263	28	1	41189	1	2	0	0	0	0	0	
49264	1	1	41225	1	0.5	1	0	0	0	0	
49264	2	1	41226	1	2	0	0	0	0	0	
49264	3	1	41229	1	0.3	1	0	0	0	0	
49264	4	1	41230	1	2	0	0	0	0	0	
49264	5	1	40327	1	1	0	0	0	0	0	
49264	6	1	41200	1	0.3	1	0	0	0	0	
49264	7	1	41201	1	1.2	0	0	0	0	0	
49264	8	1	41208	1	0.5	1	0	0	0	0	
49264	9	1	41209	1	1.2	0	0	0	0	0	
49264	10	1	41196	1	0.35	1	0	0	0	0	
49264	11	1	41197	1	0.15	1	0	0	0	0	
49264	12	1	40509	3	9	0	0	0	0	0	
49264	13	1	40158	1	5	0	0	0	0	0	
49264	14	1	41090	45	10	0	0	0	0	0	
49264	15	1	40022	2	2	0	0	0	0	0	
49264	16	1	41192	1	2	0	0	0	0	0	
49264	17	1	41193	1	1	0	0	0	0	0	
49264	18	1	40572	1	12.5	0	0	0	0	0	
49264	19	1	40183	22	7	0	0	0	0	0	
49264	20	1	41088	45	7	0	0	0	0	0	
49264	21	1	41089	1	5	0	0	0	0	0	
49264	22	1	40122	10	4	0	0	0	0	0	
49264	23	1	40362	3	20	0	0	0	0	0	
49264	24	1	41188	1	4	0	0	0	0	0	
49264	25	1	41189	1	2	0	0	0	0	0	
49265	1	1	40181	1	100	0	0	0	0	0	
49265	1	2	40042	4	100	0	0	0	0	0	
49265	1	3	40020	2	100	0	0	0	0	0	
49265	1	4	40449	1	100	0	0	0	0	0	
49265	1	5	40364	1	100	0	0	0	0	0	
49265	1	6	41195	1	100	0	0	0	0	0	
49265	1	7	40369	1	100	0	0	0	0	0	
49266	1	1	40152	5	100	0	0	0	0	0	
49266	1	2	40154	5	100	0	0	0	0	0	
49266	1	3	40021	2	100	0	0	0	0	0	
49266	1	4	40188	1	100	0	0	0	0	0	
49266	1	5	40371	1	100	0	0	0	0	0	
49266	1	6	40991	1	100	0	0	0	0	0	
49266	1	7	40994	1	100	0	0	0	0	0	
49267	1	1	40157	1	100	0	0	0	0	0	
49267	1	2	40111	25	100	0	0	0	0	0	
49267	1	3	40317	1	100	0	0	0	0	0	
49267	1	4	34429	1	100	0	0	0	0	0	
49267	1	5	41196	1	100	0	0	0	0	0	
49267	1	6	40370	1	100	0	0	0	0	0	
49267	1	7	49264	2	100	0	0	0	0	0	
49268	1	1	40182	1	100	0	0	0	0	0	
49268	1	2	40184	1	100	0	0	0	0	0	
49268	1	3	41241	1	100	0	0	0	0	0	
49268	1	4	41246	1	100	0	0	0	0	0	
49268	1	5	41221	1	100	0	0	0	0	0	
49268	1	6	41197	1	100	0	0	0	0	0	
49268	1	7	40687	1	100	0	0	0	0	0	
49269	1	1	41247	1	2	1	0	0	0	0	
49269	2	1	41250	1	4.5	0	0	0	0	0	
49269	3	1	41249	1	10	0	0	0	0	0	
49269	4	1	41197	1	10	0	0	0	0	0	
49269	5	1	41193	1	15	0	0	0	0	0	
49269	6	1	41189	1	20	0	0	0	0	0	
49269	7	1	40317	1	5	0	0	0	0	0	
49269	8	1	49256	9	10.5	0	0	0	0	0	
49269	9	1	40201	2	10	0	0	0	0	0	
49269	10	1	40362	6	13	0	0	0	0	0	
49270	1	1	40758	1	7	0	0	0	0	0	
49270	2	1	40759	1	7	0	0	0	0	0	
49270	3	1	40231	1	7	0	0	0	0	0	
49270	4	1	40799	1	7	0	0	0	0	0	
49270	5	1	40344	1	7	0	0	0	0	0	
49270	6	1	40755	1	7	0	0	0	0	0	
49270	7	1	40261	1	7	0	0	0	0	0	
49270	8	1	34992	1	7	0	0	0	0	0	
49270	9	1	40797	1	7	0	0	0	0	0	
49270	10	1	40467	1	7	0	0	0	0	0	
49270	11	1	40233	1	7	0	0	0	0	0	
49270	12	1	40659	1	7	0	0	0	0	0	
49270	13	1	40655	1	7	0	0	0	0	0	
49270	14	1	41144	1	9	0	0	0	0	0	
49271	1	1	38711	1	100	0	0	0	0	0	
49271	1	2	38712	1	100	0	0	0	0	0	
49271	1	3	38713	1	100	0	0	0	0	0	
49271	1	4	38714	1	100	0	0	0	0	0	
49271	1	5	38715	1	100	0	0	0	0	0	
49272	1	1	38716	1	100	0	0	0	0	0	
49272	1	2	38717	1	100	0	0	0	0	0	
49272	1	3	38718	1	100	0	0	0	0	0	
49272	1	4	38719	1	100	0	0	0	0	0	
49272	1	5	38720	1	100	0	0	0	0	0	
49273	1	1	38721	1	100	0	0	0	0	0	
49273	1	2	38722	1	100	0	0	0	0	0	
49273	1	3	38723	1	100	0	0	0	0	0	
49273	1	4	38724	1	100	0	0	0	0	0	
49273	1	5	38725	1	100	0	0	0	0	0	
49274	1	1	38726	1	100	0	0	0	0	0	
49274	1	2	38727	1	100	0	0	0	0	0	
49274	1	3	38728	1	100	0	0	0	0	0	
49274	1	4	38729	1	100	0	0	0	0	0	
49274	1	5	38730	1	100	0	0	0	0	0	
49275	1	1	38731	1	100	0	0	0	0	0	
49275	1	2	38732	1	100	0	0	0	0	0	
49275	1	3	38733	1	100	0	0	0	0	0	
49275	1	4	38734	1	100	0	0	0	0	0	
49275	1	5	38735	1	100	0	0	0	0	0	
49276	1	1	38736	1	100	0	0	0	0	0	
49276	1	2	38737	1	100	0	0	0	0	0	
49276	1	3	38738	1	100	0	0	0	0	0	
49276	1	4	38739	1	100	0	0	0	0	0	
49276	1	5	38740	1	100	0	0	0	0	0	
49277	1	1	38741	1	100	0	0	0	0	0	
49277	1	2	38742	1	100	0	0	0	0	0	
49277	1	3	38743	1	100	0	0	0	0	0	
49277	1	4	38744	1	100	0	0	0	0	0	
49277	1	5	38745	1	100	0	0	0	0	0	
49278	1	1	38746	1	100	0	0	0	0	0	
49278	1	2	38747	1	100	0	0	0	0	0	
49278	1	3	38748	1	100	0	0	0	0	0	
49278	1	4	38749	1	100	0	0	0	0	0	
49278	1	5	38750	1	100	0	0	0	0	0	
49279	1	1	41170	1	0.7	1	0	0	0	0	
49279	2	1	41171	1	2.5	0	0	0	0	0	
49279	3	1	41178	1	0.4	1	0	0	0	0	
49279	4	1	41179	1	2	0	0	0	0	0	
49279	5	1	40682	1	0.3	1	0	0	0	0	
49279	6	1	40683	1	1.8	0	0	0	0	0	
49279	7	1	40195	1	0.45	1	0	0	0	0	
49279	8	1	40198	1	2	0	0	0	0	0	
49279	9	1	41196	1	0.35	1	0	0	0	0	
49279	10	1	41197	1	0.15	1	0	0	0	0	
49279	11	1	40509	3	10	0	0	0	0	0	
49279	12	1	40367	1	2	0	0	0	0	0	
49279	13	1	41090	45	10	0	0	0	0	0	
49279	14	1	40022	2	2	0	0	0	0	0	
49279	15	1	41192	1	2	0	0	0	0	0	
49279	16	1	41193	1	1	0	0	0	0	0	
49279	17	1	40572	1	12	0	0	0	0	0	
49279	18	1	40380	1	3	0	0	0	0	0	
49279	19	1	40190	5	4	0	0	0	0	0	
49279	20	1	40191	11	5	0	0	0	0	0	
49279	21	1	40192	11	5	0	0	0	0	0	
49279	22	1	40193	11	5	0	0	0	0	0	
49279	23	1	41093	3	3	0	0	0	0	0	
49279	24	1	40202	7	7	0	0	0	0	0	
49279	25	1	40040	12	6.35	0	0	0	0	0	
49279	26	1	40042	5	6	0	0	0	0	0	
49279	27	1	41188	1	4	0	0	0	0	0	
49279	28	1	41189	1	2	0	0	0	0	0	
49280	1	1	40751	1	45	0	0	0	0	0	
49280	2	1	40745	1	20	0	0	0	0	0	
49280	3	1	40743	1	20	0	0	0	0	0	
49280	4	1	40753	1	5	0	0	0	0	0	
49280	5	1	40747	1	10	0	0	0	0	0	
49280	1	2	40754	1	100	0	0	0	0	0	
49281	1	1	40572	1	14	0	0	0	0	0	
49281	2	1	41277	1	0.6	1	0	0	0	0	
49281	3	1	41278	1	2.5	0	0	0	0	0	
49281	4	1	41281	1	0.3	1	0	0	0	0	
49281	5	1	41282	1	2	0	0	0	0	0	
49281	6	1	41306	1	0.3	1	0	0	0	0	
49281	7	1	41307	1	1.2	0	0	0	0	0	
49281	8	1	41208	1	0.5	1	0	0	0	0	
49281	9	1	41209	1	1.2	0	0	0	0	0	
49281	10	1	41196	1	0.35	0	0	0	0	0	
49281	11	1	41197	1	0.15	0	0	0	0	0	
49281	12	1	40509	3	9	0	0	0	0	0	
49281	13	1	41091	1	3	0	0	0	0	0	
49281	14	1	41090	45	10	0	0	0	0	0	
49281	15	1	40122	10	5	0	0	0	0	0	
49281	16	1	41192	1	2	0	0	0	0	0	
49281	17	1	41193	1	1	0	0	0	0	0	
49281	18	1	40190	5	4	0	0	0	0	0	
49281	19	1	40191	11	6	0	0	0	0	0	
49281	20	1	40192	11	6	0	0	0	0	0	
49281	21	1	40193	11	6	0	0	0	0	0	
49281	22	1	41093	3	3	0	0	0	0	0	
49281	23	1	40183	22	6	0	0	0	0	0	
49281	24	1	41188	1	4	0	0	0	0	0	
49281	25	1	41189	1	2	0	0	0	0	0	
49281	27	1	40202	7	10	0	0	0	0	0	
49282	1	1	40368	1	4	0	0	0	0	0	
49282	2	1	40022	4	5	0	0	0	0	0	
49282	3	1	41304	1	1.25	0	0	0	0	0	
49282	4	1	41301	1	0.05	1	0	0	0	0	
49282	5	1	41302	1	1	0	0	0	0	0	
49282	6	1	40687	1	0.1	1	0	0	0	0	
49282	7	1	40546	1	2	0	0	0	0	0	
49282	8	1	40772	1	0.25	1	0	0	0	0	
49282	9	1	40773	1	2	0	0	0	0	0	
49282	10	1	40477	1	0.5	1	0	0	0	0	
49282	11	1	40828	1	0.5	1	0	0	0	0	
49282	12	1	40829	1	0.5	1	0	0	0	0	
49282	13	1	40369	1	2	0	0	0	0	0	
49282	14	1	40370	1	0.5	0	0	0	0	0	
49282	15	1	40184	2	3.5	0	0	0	0	0	
49282	16	1	41300	1	2.5	0	0	0	0	0	
49282	17	1	41193	1	2	0	0	0	0	0	
49282	18	1	41192	1	4	0	0	0	0	0	
49282	19	1	41191	2	7	0	0	0	0	0	
49282	20	1	41190	3	12	0	0	0	0	0	
49282	21	1	41189	1	3	0	0	0	0	0	
49282	22	1	41188	2	6	0	0	0	0	0	
49282	23	1	41187	3	9	0	0	0	0	0	
49282	24	1	41186	6	12	0	0	0	0	0	
49282	25	1	40362	6	19.35	0	0	0	0	0	
49283	1	1	41297	50	100	0	0	0	0	0	
49284	1	1	41298	50	100	0	0	0	0	0	
49285	1	1	41259	1	3	1	0	0	0	0	
49285	2	1	41257	1	3	1	0	0	0	0	
49285	3	1	40509	4	10	0	0	0	0	0	
49285	4	1	40542	1	10	0	0	0	0	0	
49285	5	1	41090	120	10	0	0	0	0	0	
49285	6	1	40022	3	10	0	0	0	0	0	
49285	7	1	40572	3	10	0	0	0	0	0	
49285	8	1	40380	1	4	1	0	0	0	0	
49285	9	1	41089	1	10	0	0	0	0	0	
49285	10	1	41088	90	10	0	0	0	0	0	
49285	11	1	40185	2	10	0	0	0	0	0	
49285	12	1	40040	25	10	0	0	0	0	0	
49286	1	1	40572	1	15	0	0	0	0	0	
49286	2	1	41265	1	0.25	1	0	0	0	0	
49286	3	1	41266	1	1.5	0	0	0	0	0	
49286	4	1	41269	1	0.5	1	0	0	0	0	
49286	5	1	41270	1	3	0	0	0	0	0	
49286	6	1	41273	1	0.45	1	0	0	0	0	
49286	7	1	41274	1	3	0	0	0	0	0	
49286	8	1	40487	1	1	0	0	0	0	0	
49286	9	1	40489	1	2.5	0	0	0	0	0	
49286	10	1	40577	1	0.5	1	0	0	0	0	
49286	11	1	41196	1	0.4	0	0	0	0	0	
49286	12	1	41197	1	0.2	0	0	0	0	0	
49286	13	1	40509	3	10	0	0	0	0	0	
49286	14	1	40021	2	3	0	0	0	0	0	
49286	15	1	41089	1	5	0	0	0	0	0	
49286	16	1	41192	1	2	0	0	0	0	0	
49286	17	1	41193	1	1	0	0	0	0	0	
49286	18	1	41088	45	8	0	0	0	0	0	
49286	19	1	40191	11	6	0	0	0	0	0	
49286	20	1	40192	11	6	0	0	0	0	0	
49286	21	1	40193	11	6	0	0	0	0	0	
49286	22	1	41093	3	3	0	0	0	0	0	
49286	23	1	40183	22	6	0	0	0	0	0	
49286	24	1	41188	1	3.7	0	0	0	0	0	
49286	25	1	41189	1	2	0	0	0	0	0	
49286	26	1	40190	5	5	0	0	0	0	0	
49286	27	1	40202	7	5	0	0	0	0	0	
49287	1	1	37977	1	100	1	0	0	0	0	
49287	2	2	40022	10	20	0	0	0	0	0	
49287	3	2	40687	1	10	1	0	0	0	0	
49287	4	2	40701	1	4	1	0	0	0	0	
49287	5	2	40351	1	16	1	0	0	0	0	
49287	6	2	40037	50	25	0	0	0	0	0	
49287	7	2	40106	50	25	0	0	0	0	0	
49288	1	1	37971	1	100	1	0	0	0	0	
49288	2	2	40370	1	4	1	0	0	0	0	
49288	3	2	40022	10	20	0	0	0	0	0	
49288	4	2	40336	1	4	1	0	0	0	0	
49288	5	2	40274	1	12	1	0	0	0	0	
49288	6	2	40037	20	30	0	0	0	0	0	
49288	7	2	40106	20	30	0	0	0	0	0	
49289	1	1	40572	1	12	0	0	0	0	0	
49289	2	1	41332	1	0.6	1	0	0	0	0	
49289	3	1	41333	1	2.5	0	0	0	0	0	
49289	4	1	41328	1	0.4	1	0	0	0	0	
49289	5	1	41329	1	2	0	0	0	0	0	
49289	6	1	41344	1	0.35	1	0	0	0	0	
49289	7	1	41345	1	1.5	0	0	0	0	0	
49289	8	1	41340	1	0.4	1	0	0	0	0	
49289	9	1	41341	1	1.8	0	0	0	0	0	
49289	10	1	41196	1	0.35	0	0	0	0	0	
49289	11	1	41197	1	0.15	0	0	0	0	0	
49289	12	1	41300	1	1.5	0	0	0	0	0	
49289	13	1	40509	3	9	0	0	0	0	0	
49289	14	1	40367	1	1.5	0	0	0	0	0	
49289	15	1	40022	2	2	0	0	0	0	0	
49289	16	1	41090	45	10	0	0	0	0	0	
49289	17	1	49290	1	5.95	0	0	0	0	0	
49289	18	1	41192	1	2	0	0	0	0	0	
49289	19	1	41193	1	1	0	0	0	0	0	
49289	20	1	40190	5	4	0	0	0	0	0	
49289	21	1	40191	11	6	0	0	0	0	0	
49289	22	1	40192	11	6	0	0	0	0	0	
49289	23	1	40193	11	6	0	0	0	0	0	
49289	24	1	41093	3	3	0	0	0	0	0	
49289	25	1	41188	1	4	0	0	0	0	0	
49289	26	1	41189	1	2	0	0	0	0	0	
49289	27	1	49291	1	8	0	0	0	0	0	
49289	28	1	40202	7	6	0	0	0	0	0	
49290	1	1	41097	2	100	0	0	0	0	0	
49290	1	2	41098	4	100	0	0	0	0	0	
49291	1	1	40313	4	100	0	0	0	0	0	
49291	1	2	40314	4	100	0	0	0	0	0	
49291	1	3	40315	4	100	0	0	0	0	0	
49292	1	1	40638	1	25	0	0	0	0	0	
49292	2	1	40639	1	25	0	0	0	0	0	
49292	3	1	40640	1	25	0	0	0	0	0	
49292	4	1	40641	1	25	0	0	0	0	0	
49292	1	2	40362	1	100	0	0	0	0	0	
49293	1	1	40642	1	20	0	0	0	0	0	
49293	2	1	40643	1	10	0	0	0	0	0	
49293	3	1	40644	1	10	0	0	0	0	0	
49293	4	1	40645	1	10	0	0	0	0	0	
49293	5	1	40646	1	10	0	0	0	0	0	
49293	6	1	40647	1	20	0	0	0	0	0	
49293	7	1	40648	1	10	0	0	0	0	0	
49293	8	1	40649	1	10	0	0	0	0	0	
49293	1	2	40362	1	100	0	0	0	0	0	
49294	1	1	40650	1	25	0	0	0	0	0	
49294	2	1	40651	1	25	0	0	0	0	0	
49294	3	1	40652	1	25	0	0	0	0	0	
49294	4	1	40653	1	25	0	0	0	0	0	
49294	1	2	40362	1	100	0	0	0	0	0	
49295	1	1	40044	1	3	0	0	0	0	0	
49295	2	1	40045	1	3	0	0	0	0	0	
49295	3	1	40046	1	3	0	0	0	0	0	
49295	4	1	40047	1	3	0	0	0	0	0	
49295	5	1	40048	1	3	0	0	0	0	0	
49295	6	1	40049	1	3	0	0	0	0	0	
49295	7	1	40050	1	3	0	0	0	0	0	
49295	8	1	40051	1	3	0	0	0	0	0	
49295	9	1	41378	1	0.3	0	0	0	0	0	
49295	10	1	41380	1	0.3	0	0	0	0	0	
49295	11	1	41381	1	0.3	0	0	0	0	0	
49295	12	1	41382	1	0.3	0	0	0	0	0	
49295	13	1	41383	1	0.3	0	0	0	0	0	
49295	14	1	41384	1	0.3	0	0	0	0	0	
49295	15	1	41377	1	0.3	0	0	0	0	0	
49295	16	1	41379	1	0.3	0	0	0	0	0	
49295	17	1	40061	1	1	0	0	0	0	0	
49295	18	1	40063	1	1	0	0	0	0	0	
49295	19	1	40064	1	1	0	0	0	0	0	
49295	20	1	40065	1	1	0	0	0	0	0	
49295	21	1	40096	1	1	0	0	0	0	0	
49295	22	1	40097	1	1	0	0	0	0	0	
49295	23	1	40060	1	1	0	0	0	0	0	
49295	24	1	40062	1	1	0	0	0	0	0	
49295	25	1	40066	1	0.3	0	0	0	0	0	
49295	26	1	40067	1	0.3	0	0	0	0	0	
49295	27	1	40068	1	0.3	0	0	0	0	0	
49295	28	1	40069	1	0.3	0	0	0	0	0	
49295	29	1	40070	1	0.3	0	0	0	0	0	
49295	30	1	40071	1	0.3	0	0	0	0	0	
49295	31	1	40098	1	0.3	0	0	0	0	0	
49295	32	1	40099	1	0.3	0	0	0	0	0	
49295	33	1	41369	1	1	0	0	0	0	0	
49295	34	1	41370	1	1	0	0	0	0	0	
49295	35	1	41371	1	1	0	0	0	0	0	
49295	36	1	41372	1	1	0	0	0	0	0	
49295	37	1	41373	1	1	0	0	0	0	0	
49295	38	1	41374	1	1	0	0	0	0	0	
49295	39	1	41375	1	1	0	0	0	0	0	
49295	40	1	41376	1	1	0	0	0	0	0	
49295	41	1	41298	60	5	0	0	0	0	0	
49295	42	1	40106	70	4	0	0	0	0	0	
49295	43	1	40105	80	4	0	0	0	0	0	
49295	44	1	40104	95	3.5	0	0	0	0	0	
49295	45	1	40039	120	3.1	0	0	0	0	0	
49295	46	1	41297	60	5	0	0	0	0	0	
49295	47	1	40037	70	4	0	0	0	0	0	
49295	48	1	40036	80	4	0	0	0	0	0	
49295	49	1	40035	95	3.5	0	0	0	0	0	
49295	50	1	40034	120	3.1	0	0	0	0	0	
49295	51	1	40202	7	4	0	0	0	0	0	
49295	52	1	40190	5	3	0	0	0	0	0	
49295	53	1	40191	11	3	0	0	0	0	0	
49295	54	1	40192	11	3	0	0	0	0	0	
49295	55	1	40193	11	3	0	0	0	0	0	
49296	1	1	40052	1	3	0	0	0	0	0	
49296	2	1	40053	1	3	0	0	0	0	0	
49296	3	1	40056	1	3	0	0	0	0	0	
49296	4	1	40059	1	3	0	0	0	0	0	
49296	5	1	40055	1	3	0	0	0	0	0	
49296	6	1	40057	1	3	0	0	0	0	0	
49296	7	1	40058	1	3	0	0	0	0	0	
49296	8	1	41385	1	0.3	0	0	0	0	0	
49296	9	1	41386	1	0.3	0	0	0	0	0	
49296	10	1	41387	1	0.3	0	0	0	0	0	
49296	11	1	41388	1	0.3	0	0	0	0	0	
49296	12	1	41389	1	0.3	0	0	0	0	0	
49296	13	1	41390	1	0.3	0	0	0	0	0	
49296	14	1	41391	1	0.3	0	0	0	0	0	
49296	15	1	41392	1	0.3	0	0	0	0	0	
49296	16	1	41393	1	0.3	0	0	0	0	0	
49296	17	1	41394	1	0.3	0	0	0	0	0	
49296	18	1	41395	1	0.3	0	0	0	0	0	
49296	19	1	41396	1	0.3	0	0	0	0	0	
49296	20	1	40072	1	1	0	0	0	0	0	
49296	21	1	40073	1	1	0	0	0	0	0	
49296	22	1	40074	1	1	0	0	0	0	0	
49296	23	1	40075	1	1	0	0	0	0	0	
49296	24	1	40076	1	1	0	0	0	0	0	
49296	25	1	40077	1	1	0	0	0	0	0	
49296	26	1	40078	1	1	0	0	0	0	0	
49296	27	1	40079	1	1	0	0	0	0	0	
49296	28	1	40080	1	1	0	0	0	0	0	
49296	29	1	40081	1	1	0	0	0	0	0	
49296	30	1	40082	1	1	0	0	0	0	0	
49296	31	1	40083	1	1	0	0	0	0	0	
49296	32	1	41298	60	5	0	0	0	0	0	
49296	33	1	40106	70	4	0	0	0	0	0	
49296	34	1	40105	80	4	0	0	0	0	0	
49296	35	1	40104	95	3.5	0	0	0	0	0	
49296	36	1	40039	120	3.1	0	0	0	0	0	
49296	37	1	41297	60	5	0	0	0	0	0	
49296	38	1	40037	70	4	0	0	0	0	0	
49296	39	1	40036	80	4	0	0	0	0	0	
49296	40	1	40035	95	3.5	0	0	0	0	0	
49296	41	1	40034	120	3.1	0	0	0	0	0	
49296	42	1	40202	7	4	0	0	0	0	0	
49296	43	1	40190	5	3	0	0	0	0	0	
49296	44	1	40191	11	3	0	0	0	0	0	
49296	45	1	40192	11	3	0	0	0	0	0	
49296	46	1	40193	11	3	0	0	0	0	0	
49296	47	1	49292	1	3	0	0	0	0	0	
49296	48	1	49293	1	3	0	0	0	0	0	
49296	49	1	49294	1	2.2	0	0	0	0	0	
49297	1	1	40737	1	0.15	1	0	0	0	0	
49297	2	1	41155	1	0.1	1	0	0	0	0	
49297	3	1	41156	1	0.15	1	0	0	0	0	
49297	4	1	41314	1	0.15	1	0	0	0	0	
49297	5	1	41200	1	0.15	1	0	0	0	0	
49297	6	1	40467	1	0.15	1	0	0	0	0	
49297	7	1	40684	1	0.15	1	0	0	0	0	
49297	8	1	40477	1	0.15	1	0	0	0	0	
49297	9	1	40831	1	0.15	1	0	0	0	0	
49297	10	1	41157	1	2.5	0	0	0	0	0	
49297	11	1	40738	1	3	0	0	0	0	0	
49297	12	1	41158	1	3	0	0	0	0	0	
49297	13	1	41315	1	3	0	0	0	0	0	
49297	14	1	41201	1	3	0	0	0	0	0	
49297	15	1	40685	1	3	0	0	0	0	0	
49297	16	1	40468	1	3	0	0	0	0	0	
49297	17	1	40496	1	3	0	0	0	0	0	
49297	18	1	40670	1	3	0	0	0	0	0	
49297	19	1	40362	3	52.2	0	0	0	0	0	
49297	20	1	40034	120	2	0	0	0	0	0	
49297	21	1	40035	95	2	0	0	0	0	0	
49297	22	1	40036	80	2	0	0	0	0	0	
49297	23	1	40037	70	2	0	0	0	0	0	
49297	24	1	41297	60	2	0	0	0	0	0	
49297	25	1	40039	120	2	0	0	0	0	0	
49297	26	1	40104	95	2	0	0	0	0	0	
49297	27	1	40105	80	2	0	0	0	0	0	
49297	28	1	40106	70	2	0	0	0	0	0	
49297	29	1	41298	60	2	0	0	0	0	0	
49298	1	1	40755	1	0.8	1	0	0	0	0	
49298	2	1	40797	1	0.8	1	0	0	0	0	
49298	3	1	41208	1	0.5	1	0	0	0	0	
49298	4	1	41293	1	0.5	1	0	0	0	0	
49298	5	1	40774	1	0.8	1	0	0	0	0	
49298	6	1	40471	1	0.5	1	0	0	0	0	
49298	7	1	40756	1	4.5	0	0	0	0	0	
49298	8	1	40798	1	5	0	0	0	0	0	
49298	9	1	41209	1	4	0	0	0	0	0	
49298	10	1	41294	1	4	0	0	0	0	0	
49298	11	1	40775	1	5	0	0	0	0	0	
49298	12	1	41408	1	4	0	0	0	0	0	
49298	13	1	40362	3	49.6	0	0	0	0	0	
49298	14	1	40034	120	2	0	0	0	0	0	
49298	15	1	40035	95	2	0	0	0	0	0	
49298	16	1	40036	80	2	0	0	0	0	0	
49298	17	1	40037	70	2	0	0	0	0	0	
49298	18	1	41297	60	2	0	0	0	0	0	
49298	19	1	40039	120	2	0	0	0	0	0	
49298	20	1	40104	95	2	0	0	0	0	0	
49298	21	1	40105	80	2	0	0	0	0	0	
49298	22	1	40106	70	2	0	0	0	0	0	
49298	23	1	41298	60	2	0	0	0	0	0	
49303	1	1	41336	1	1	1	0	0	0	0	
49303	2	1	41337	1	3	0	0	0	0	0	
49303	3	1	41285	1	0.5	1	0	0	0	0	
49303	4	1	41286	1	2.3	0	0	0	0	0	
49303	5	1	41364	1	0.8	1	0	0	0	0	
49303	6	1	41365	1	2.5	0	0	0	0	0	
49303	7	1	41196	1	0.4	1	0	0	0	0	
49303	8	1	41197	1	0.2	1	0	0	0	0	
49303	9	1	41300	1	1.5	0	0	0	0	0	
49303	10	1	49290	1	5	0	0	0	0	0	
49303	11	1	40509	3	8	0	0	0	0	0	
49303	12	1	40367	1	2	0	0	0	0	0	
49303	13	1	41090	45	8	0	0	0	0	0	
49303	14	1	40022	2	2	0	0	0	0	0	
49303	15	1	41192	1	2	0	0	0	0	0	
49303	16	1	41193	1	1	0	0	0	0	0	
49303	17	1	40572	1	12	0	0	0	0	0	
49303	18	1	40122	10	5	0	0	0	0	0	
49303	19	1	40190	5	4	0	0	0	0	0	
49303	20	1	40191	11	4	0	0	0	0	0	
49303	21	1	40192	11	4	0	0	0	0	0	
49303	22	1	40193	11	4	0	0	0	0	0	
49303	23	1	41093	3	4	0	0	0	0	0	
49303	24	1	40202	7	4.8	0	0	0	0	0	
49303	25	1	40040	12	6	0	0	0	0	0	
49303	26	1	40042	5	6	0	0	0	0	0	
49303	27	1	41188	1	4	0	0	0	0	0	
49303	28	1	41189	1	2	0	0	0	0	0	
49304	1	1	40509	3	7	0	0	0	0	0	
49304	2	1	40183	22	3	0	0	0	0	0	
49304	3	1	41519	1	1.5	0	0	0	0	0	
49304	4	1	41520	1	2.7	0	0	0	0	0	
49304	5	1	41523	1	0.8	1	0	0	0	0	
49304	6	1	41524	1	2.6	0	0	0	0	0	
49304	7	1	41356	1	0.6	1	0	0	0	0	
49304	8	1	41357	1	2.1	0	0	0	0	0	
49304	9	1	40702	1	0.35	1	0	0	0	0	
49304	10	1	40742	1	1.25	0	0	0	0	0	
49304	11	1	41196	1	0.4	1	0	0	0	0	
49304	12	1	41197	1	0.2	1	0	0	0	0	
49304	13	1	41300	1	1.5	0	0	0	0	0	
49304	14	1	40021	2	3	0	0	0	0	0	
49304	15	1	41090	45	7	0	0	0	0	0	
49304	16	1	49305	1	2	0	0	0	0	0	
49304	17	1	41192	1	2	0	0	0	0	0	
49304	18	1	41193	1	1	0	0	0	0	0	
49304	19	1	40572	1	11	0	0	0	0	0	
49304	20	1	40122	10	5	0	0	0	0	0	
49304	21	1	40190	5	4	0	0	0	0	0	
49304	22	1	40191	11	4	0	0	0	0	0	
49304	23	1	40192	11	4	0	0	0	0	0	
49304	24	1	40193	11	4	0	0	0	0	0	
49304	25	1	41093	3	4	0	0	0	0	0	
49304	26	1	40202	7	4	0	0	0	0	0	
49304	27	1	41188	1	4	0	0	0	0	0	
49304	28	1	41189	1	2	0	0	0	0	0	
49304	29	1	41088	45	7	0	0	0	0	0	
49304	30	1	49291	1	8	0	0	0	0	0	
49305	1	1	40209	1	100	0	0	0	0	0	
49305	1	2	40211	1	100	0	0	0	0	0	
49305	1	3	40213	1	100	0	0	0	0	0	
49305	1	4	40215	1	100	0	0	0	0	0	
49305	1	5	40217	1	100	0	0	0	0	0	
49306	1	1	40210	1	100	0	0	0	0	0	
49306	1	2	40212	1	100	0	0	0	0	0	
49306	1	3	40214	1	100	0	0	0	0	0	
49306	1	4	40216	1	100	0	0	0	0	0	
49306	1	5	40218	1	100	0	0	0	0	0	
49309	1	1	40509	3	10	0	0	0	0	0	
49309	2	1	41091	1	3	0	0	0	0	0	
49309	3	1	41324	1	0.8	1	0	0	0	0	
49309	4	1	41325	1	2	0	0	0	0	0	
49309	5	1	41528	1	0.8	1	0	0	0	0	
49309	6	1	41529	1	2	0	0	0	0	0	
49309	7	1	40437	1	0.5	0	0	0	0	0	
49309	8	1	40441	1	1.5	0	0	0	0	0	
49309	9	1	41348	1	0.35	1	0	0	0	0	
49309	10	1	41349	1	1.25	0	0	0	0	0	
49309	11	1	41196	1	0.4	0	0	0	0	0	
49309	12	1	41197	1	0.2	0	0	0	0	0	
49309	13	1	41300	1	1.5	0	0	0	0	0	
49309	14	1	40222	1	1	0	0	0	0	0	
49309	15	1	41493	1	2.3	0	0	0	0	0	
49309	16	1	49290	1	6	0	0	0	0	0	
49309	17	1	41192	1	2	0	0	0	0	0	
49309	18	1	41193	1	1	0	0	0	0	0	
49309	19	1	40572	1	12	0	0	0	0	0	
49309	20	1	40380	1	3	0	0	0	0	0	
49309	21	1	40190	5	3.2	0	0	0	0	0	
49309	22	1	40191	11	4	0	0	0	0	0	
49309	23	1	40192	11	6	0	0	0	0	0	
49309	24	1	40193	11	6	0	0	0	0	0	
49309	25	1	41093	3	3.2	0	0	0	0	0	
49309	26	1	40202	7	4	0	0	0	0	0	
49309	27	1	41188	1	4	0	0	0	0	0	
49309	28	1	41189	1	2	0	0	0	0	0	
49309	29	1	40040	12	8	0	0	0	0	0	
49309	30	1	40042	5	8	0	0	0	0	0	
49310	1	1	40658	1	0.06	1	0	0	0	0	
49310	2	1	40665	1	0.5	1	0	0	0	0	
49310	3	1	40701	1	0.5	1	0	0	0	0	
49310	4	1	40753	1	0.2	1	0	0	0	0	
49310	5	1	40682	1	0.2	1	0	0	0	0	
49310	6	1	40365	1	0.8	1	0	0	0	0	
49310	7	1	40366	1	0.2	1	0	0	0	0	
49310	8	1	41344	1	0.5	1	0	0	0	0	
49310	9	1	40659	1	1	0	0	0	0	0	
49310	10	1	40666	1	2	0	0	0	0	0	
49310	11	1	40683	1	1	0	0	0	0	0	
49310	12	1	40703	1	2	0	0	0	0	0	
49310	13	1	41611	1	2.5	0	0	0	0	0	
49310	14	1	41612	1	2	0	0	0	0	0	
49310	15	1	41345	1	2	0	0	0	0	0	
49310	16	1	40362	3	43.54	0	0	0	0	0	
49310	17	1	40033	160	3	0	0	0	0	0	
49310	18	1	40034	120	3.5	0	0	0	0	0	
49310	19	1	40035	95	4	0	0	0	0	0	
49310	20	1	40036	80	4.5	0	0	0	0	0	
49310	21	1	40037	70	5.5	0	0	0	0	0	
49310	22	1	40038	160	3	0	0	0	0	0	
49310	23	1	40039	120	3.5	0	0	0	0	0	
49310	24	1	40104	95	4	0	0	0	0	0	
49310	25	1	40105	80	4.5	0	0	0	0	0	
49310	26	1	40106	70	5.5	0	0	0	0	0	
49311	1	1	40573	1	0.3	1	0	0	0	0	
49311	2	1	40574	1	0.3	1	0	0	0	0	
49311	3	1	41269	1	0.3	1	0	0	0	0	
49311	4	1	41273	1	0.3	1	0	0	0	0	
49311	5	1	40320	1	0.5	0	0	0	0	0	
49311	6	1	40321	1	0.5	0	0	0	0	0	
49311	7	1	40401	1	0.5	0	0	0	0	0	
49311	8	1	40349	1	0.5	0	0	0	0	0	
49311	9	1	40575	1	2	0	0	0	0	0	
49311	10	1	40576	1	2	0	0	0	0	0	
49311	11	1	41270	1	2	0	0	0	0	0	
49311	12	1	41274	1	2	0	0	0	0	0	
49311	13	1	40325	1	2	0	0	0	0	0	
49311	14	1	40326	1	2	0	0	0	0	0	
49311	15	1	40404	1	2	0	0	0	0	0	
49311	16	1	40348	1	2	0	0	0	0	0	
49311	17	1	40040	12	5.5	0	0	0	0	0	
49311	18	1	40041	4	3	0	0	0	0	0	
49311	19	1	40042	5	5.3	0	0	0	0	0	
49311	20	1	40043	3	3	0	0	0	0	0	
49311	21	1	41082	1	3	0	0	0	0	0	
49311	22	1	41083	1	2	0	0	0	0	0	
49311	23	1	41085	3	4	0	0	0	0	0	
49311	24	1	41086	1	3	0	0	0	0	0	
49311	25	1	41087	3	4	0	0	0	0	0	
49311	26	1	40036	80	3.5	0	0	0	0	0	
49311	27	1	40037	70	3.5	0	0	0	0	0	
49311	28	1	41297	60	3.5	0	0	0	0	0	
49311	29	1	40105	80	3.5	0	0	0	0	0	
49311	30	1	40106	70	3.5	0	0	0	0	0	
49311	31	1	41298	60	3.5	0	0	0	0	0	
49311	32	1	40190	5	3.5	0	0	0	0	0	
49311	33	1	40191	11	4.5	0	0	0	0	0	
49311	34	1	40192	11	4.5	0	0	0	0	0	
49311	35	1	40193	11	4.5	0	0	0	0	0	
49311	36	1	40021	2	2.5	0	0	0	0	0	
49311	37	1	40020	3	3.5	0	0	0	0	0	
49311	38	1	40019	5	4	0	0	0	0	0	
49312	1	1	40509	3	10.8	0	0	0	0	0	
49312	2	1	41091	1	3	0	0	0	0	0	
49312	3	1	41320	1	0.7	1	0	0	0	0	
49312	4	1	41321	1	2	0	0	0	0	0	
49312	5	1	41543	1	0.7	1	0	0	0	0	
49312	6	1	41544	1	2	0	0	0	0	0	
49312	7	1	40399	1	0.4	0	0	0	0	0	
49312	8	1	40402	1	1.5	0	0	0	0	0	
49312	9	1	40238	1	0.5	1	0	0	0	0	
49312	10	1	40263	1	1.6	0	0	0	0	0	
49312	11	1	41196	1	0.4	0	0	0	0	0	
49312	12	1	41197	1	0.2	0	0	0	0	0	
49312	13	1	41300	1	1.5	0	0	0	0	0	
49312	14	1	40021	2	4	0	0	0	0	0	
49312	15	1	40200	4	4	0	0	0	0	0	
49312	16	1	40201	1	4	0	0	0	0	0	
49312	17	1	41192	1	2	0	0	0	0	0	
49312	18	1	41193	1	1	0	0	0	0	0	
49312	19	1	40572	1	12	0	0	0	0	0	
49312	20	1	40380	1	3	0	0	0	0	0	
49312	21	1	40190	5	3.2	0	0	0	0	0	
49312	22	1	40191	11	5	0	0	0	0	0	
49312	23	1	40192	11	3.5	0	0	0	0	0	
49312	24	1	40193	11	6	0	0	0	0	0	
49312	25	1	41093	3	5	0	0	0	0	0	
49312	26	1	40202	7	5	0	0	0	0	0	
49312	27	1	41188	1	4	0	0	0	0	0	
49312	28	1	41189	1	2	0	0	0	0	0	
49312	29	1	40122	10	5	0	0	0	0	0	
49312	30	1	40183	22	6	0	0	0	0	0	
49313	1	1	40368	1	3.5	0	0	0	0	0	
49313	2	1	40022	4	5	0	0	0	0	0	
49313	3	1	41304	1	1.25	0	0	0	0	0	
49313	4	1	41301	1	0.05	1	0	0	0	0	
49313	5	1	41302	1	1	0	0	0	0	0	
49313	6	1	40687	1	0.1	1	0	0	0	0	
49313	7	1	40546	1	2	0	0	0	0	0	
49313	8	1	41289	1	0.5	1	0	0	0	0	
49313	9	1	41290	1	4	0	0	0	0	0	
49313	10	1	40477	1	0.5	1	0	0	0	0	
49313	11	1	40828	1	0.5	1	0	0	0	0	
49313	12	1	40829	1	0.5	1	0	0	0	0	
49313	13	1	40369	1	1.5	0	0	0	0	0	
49313	14	1	40370	1	0.5	0	0	0	0	0	
49313	15	1	40184	2	4	0	0	0	0	0	
49313	16	1	41300	1	2.5	0	0	0	0	0	
49313	17	1	41193	1	2	0	0	0	0	0	
49313	18	1	41192	1	4	0	0	0	0	0	
49313	19	1	41493	2	6	0	0	0	0	0	
49313	20	1	41542	3	5	0	0	0	0	0	
49313	21	1	41476	1	6	0	0	0	0	0	
49313	22	1	41477	1	6	0	0	0	0	0	
49313	23	1	41478	1	6	0	0	0	0	0	
49313	24	1	41461	1	6	0	0	0	0	0	
49313	25	1	41462	1	6	0	0	0	0	0	
49313	26	1	41463	1	6	0	0	0	0	0	
49313	27	1	40362	6	19.6	0	0	0	0	0	
49317	1	1	40509	3	10.7	0	0	0	0	0	
49317	2	1	41089	1	3.2	0	0	0	0	0	
49317	3	1	41628	1	0.8	1	0	0	0	0	
49317	4	1	41629	1	1.7	0	0	0	0	0	
49317	5	1	40514	1	0.6	0	0	0	0	0	
49317	6	1	40515	1	2	0	0	0	0	0	
49317	7	1	41620	1	0.6	1	0	0	0	0	
49317	8	1	41621	1	1.5	0	0	0	0	0	
49317	9	1	41624	1	0.6	1	0	0	0	0	
49317	10	1	41625	1	1.5	0	0	0	0	0	
49317	11	1	41196	1	0.4	0	0	0	0	0	
49317	12	1	41197	1	0.2	0	0	0	0	0	
49317	13	1	41300	1	1.5	0	0	0	0	0	
49317	14	1	40022	2	2	0	0	0	0	0	
49317	15	1	49290	1	5	0	0	0	0	0	
49317	16	1	41192	1	2	0	0	0	0	0	
49317	17	1	41193	1	1	0	0	0	0	0	
49317	18	1	40572	1	12	0	0	0	0	0	
49317	19	1	40380	1	3	0	0	0	0	0	
49317	20	1	40190	5	3.2	0	0	0	0	0	
49317	21	1	40191	11	5	0	0	0	0	0	
49317	22	1	40192	11	3.5	0	0	0	0	0	
49317	23	1	40193	11	6	0	0	0	0	0	
49317	24	1	41093	3	5	0	0	0	0	0	
49317	25	1	40202	7	5	0	0	0	0	0	
49317	26	1	41188	1	4	0	0	0	0	0	
49317	27	1	41189	1	2	0	0	0	0	0	
49317	28	1	40040	12	8	0	0	0	0	0	
49317	29	1	40042	5	8	0	0	0	0	0	
49318	1	1	40572	1	13.5	0	0	0	0	0	
49318	2	1	40509	3	10	0	0	0	0	0	
49318	3	1	41636	1	0.15	1	0	0	0	0	
49318	4	1	41642	1	0.3	0	0	0	0	0	
49318	5	1	41648	1	0.3	0	0	0	0	0	
49318	6	1	41654	1	0.3	0	0	0	0	0	
49318	7	1	41660	1	0.2	1	0	0	0	0	
49318	8	1	41666	1	0.2	1	0	0	0	0	
49318	9	1	41687	1	0.2	1	0	0	0	0	
49318	10	1	41693	1	0.2	1	0	0	0	0	
49318	11	1	41699	1	0.3	0	0	0	0	0	
49318	12	1	41705	1	0.2	1	0	0	0	0	
49318	13	1	41711	1	0.3	0	0	0	0	0	
49318	14	1	41717	1	0.3	0	0	0	0	0	
49318	15	1	41725	1	0.3	0	0	0	0	0	
49318	16	1	41637	1	1	0	0	0	0	0	
49318	17	1	41643	1	1.6	0	0	0	0	0	
49318	18	1	41649	1	1.6	0	0	0	0	0	
49318	19	1	41655	1	1.6	0	0	0	0	0	
49318	20	1	41661	1	1.6	0	0	0	0	0	
49318	21	1	41667	1	1.6	0	0	0	0	0	
49318	22	1	41688	1	1.6	0	0	0	0	0	
49318	23	1	41694	1	1.6	0	0	0	0	0	
49318	24	1	41700	1	1.6	0	0	0	0	0	
49318	25	1	41706	1	1.6	0	0	0	0	0	
49318	26	1	41712	1	1.6	0	0	0	0	0	
49318	27	1	41718	1	1.6	0	0	0	0	0	
49318	28	1	41726	1	1.6	0	0	0	0	0	
49318	29	1	40022	2	3	0	0	0	0	0	
49318	30	1	40184	1	2	0	0	0	0	0	
49318	31	1	40200	4	4	0	0	0	0	0	
49318	32	1	41088	45	7	0	0	0	0	0	
49318	33	1	40040	12	8	0	0	0	0	0	
49318	35	1	41614	6	5	0	0	0	0	0	
49318	36	1	41615	6	5	0	0	0	0	0	
49318	37	1	41616	6	5	0	0	0	0	0	
49318	38	1	40191	11	5.05	0	0	0	0	0	
49318	39	1	41093	3	5	0	0	0	0	0	
49318	40	1	40190	5	4	0	0	0	0	0	
49319	1	1	40572	1	13.5	0	0	0	0	0	
49319	2	1	40509	3	7.55	0	0	0	0	0	
49319	3	1	41639	1	0.15	1	0	0	0	0	
49319	4	1	41645	1	0.3	0	0	0	0	0	
49319	5	1	41651	1	0.3	0	0	0	0	0	
49319	6	1	41657	1	0.3	0	0	0	0	0	
49319	7	1	41663	1	0.2	1	0	0	0	0	
49319	8	1	41669	1	0.2	1	0	0	0	0	
49319	9	1	41690	1	0.2	1	0	0	0	0	
49319	10	1	41696	1	0.2	1	0	0	0	0	
49319	11	1	41702	1	0.3	0	0	0	0	0	
49319	12	1	41708	1	0.2	1	0	0	0	0	
49319	13	1	41714	1	0.3	0	0	0	0	0	
49319	14	1	41721	1	0.3	0	0	0	0	0	
49319	15	1	41728	1	0.3	0	0	0	0	0	
49319	16	1	41640	1	1	0	0	0	0	0	
49319	17	1	41646	1	1.6	0	0	0	0	0	
49319	18	1	41652	1	1.6	0	0	0	0	0	
49319	19	1	41658	1	1.6	0	0	0	0	0	
49319	20	1	41664	1	1.6	0	0	0	0	0	
49319	21	1	41670	1	1.6	0	0	0	0	0	
49319	22	1	41691	1	1.6	0	0	0	0	0	
49319	23	1	41697	1	1.6	0	0	0	0	0	
49319	24	1	41703	1	1.6	0	0	0	0	0	
49319	25	1	41709	1	1.6	0	0	0	0	0	
49319	26	1	41715	1	1.6	0	0	0	0	0	
49319	27	1	41722	1	1.6	0	0	0	0	0	
49319	28	1	41729	1	1.6	0	0	0	0	0	
49319	29	1	40022	2	2.5	0	0	0	0	0	
49319	30	1	41542	1	4	0	0	0	0	0	
49319	31	1	40200	4	4	0	0	0	0	0	
49319	32	1	41090	45	7	0	0	0	0	0	
49319	33	1	40042	5	8	0	0	0	0	0	
49319	35	1	41614	6	5	0	0	0	0	0	
49319	36	1	41615	6	5	0	0	0	0	0	
49319	37	1	41616	6	5	0	0	0	0	0	
49319	38	1	40192	11	4	0	0	0	0	0	
49319	39	1	40202	7	5	0	0	0	0	0	
49319	40	1	40193	11	6	0	0	0	0	0	
49320	1	1	40122	10	5	0	0	0	0	0	
49320	2	1	40183	22	6	0	0	0	0	0	
49320	3	1	41591	1	0.25	1	0	0	0	0	
49320	4	1	41592	1	1.2	0	0	0	0	0	
49320	5	1	40696	1	1	0	0	0	0	0	
49320	6	1	40740	1	2	0	0	0	0	0	
49320	7	1	40697	1	0.6	1	0	0	0	0	
49320	8	1	40741	1	1.5	0	0	0	0	0	
49320	9	1	40471	1	0.8	1	0	0	0	0	
49320	10	1	41408	1	2	0	0	0	0	0	
49320	11	1	41196	1	0.4	0	0	0	0	0	
49320	12	1	41197	1	0.2	0	0	0	0	0	
49320	13	1	41300	1	1.5	0	0	0	0	0	
49320	14	1	40367	1	2	0	0	0	0	0	
49320	15	1	40380	1	3	0	0	0	0	0	
49320	16	1	40572	1	10.3	0	0	0	0	0	
49320	17	1	41192	1	2	0	0	0	0	0	
49320	18	1	41193	1	1	0	0	0	0	0	
49320	19	1	40156	4	10	0	0	0	0	0	
49320	20	1	40181	3	3	0	0	0	0	0	
49320	21	1	41089	1	3.25	0	0	0	0	0	
49320	22	1	40023	4	2	0	0	0	0	0	
49320	23	1	40024	2	2	0	0	0	0	0	
49320	24	1	40025	4	2	0	0	0	0	0	
49320	25	1	40026	2	2	0	0	0	0	0	
49320	26	1	40027	4	2	0	0	0	0	0	
49320	27	1	40028	2	2	0	0	0	0	0	
49320	28	1	40029	4	2	0	0	0	0	0	
49320	29	1	40030	2	2	0	0	0	0	0	
49320	30	1	40031	4	2	0	0	0	0	0	
49320	31	1	40032	2	2	0	0	0	0	0	
49320	32	1	40209	2	2	0	0	0	0	0	
49320	33	1	40210	1	2	0	0	0	0	0	
49320	34	1	40211	2	2	0	0	0	0	0	
49320	35	1	40212	1	2	0	0	0	0	0	
49320	36	1	40213	2	2	0	0	0	0	0	
49320	37	1	40214	1	2	0	0	0	0	0	
49320	38	1	40215	2	2	0	0	0	0	0	
49320	39	1	40216	1	2	0	0	0	0	0	
49320	40	1	40217	2	2	0	0	0	0	0	
49320	41	1	40218	1	2	0	0	0	0	0	
49320	42	1	49292	1	3	0	0	0	0	0	
49321	1	1	40509	3	10.7	0	0	0	0	0	
49321	2	1	40367	1	2	0	0	0	0	0	
49321	3	1	41607	1	0.25	1	0	0	0	0	
49321	4	1	41608	1	1.7	0	0	0	0	0	
49321	5	1	41583	1	0.5	1	0	0	0	0	
49321	6	1	41584	1	2	0	0	0	0	0	
49321	7	1	40788	1	0.6	1	0	0	0	0	
49321	8	1	40789	1	2.3	0	0	0	0	0	
49321	9	1	41196	1	0.4	0	0	0	0	0	
49321	10	1	41197	1	0.2	0	0	0	0	0	
49321	11	1	41300	1	1.5	0	0	0	0	0	
49321	12	1	40022	2	2	0	0	0	0	0	
49321	13	1	40156	4	6.15	0	0	0	0	0	
49321	14	1	40122	10	5	0	0	0	0	0	
49321	15	1	41192	1	2	0	0	0	0	0	
49321	16	1	41193	1	1	0	0	0	0	0	
49321	17	1	40572	1	12	0	0	0	0	0	
49321	18	1	40380	1	3	0	0	0	0	0	
49321	19	1	40190	5	3.2	0	0	0	0	0	
49321	20	1	40191	11	5	0	0	0	0	0	
49321	21	1	40192	11	3.5	0	0	0	0	0	
49321	22	1	40193	11	6	0	0	0	0	0	
49321	23	1	41093	3	5	0	0	0	0	0	
49321	24	1	40202	7	5	0	0	0	0	0	
49321	25	1	41188	1	4	0	0	0	0	0	
49321	26	1	41189	1	2	0	0	0	0	0	
49321	27	1	40183	22	6	0	0	0	0	0	
49321	28	1	41088	45	7	0	0	0	0	0	
49323	1	1	40362	1	96.59	0	0	0	0	0	
49323	2	1	40362	5	2.5	0	0	0	0	0	
49323	3	1	40362	15	0.7	0	0	0	0	0	
49323	4	1	40362	40	0.15	1	0	0	0	0	
49323	5	1	40362	65	0.05	1	0	0	0	0	
49323	6	1	40362	100	0.01	1	0	0	0	0	
49324	1	1	40772	1	2	1	0	0	0	0	
49324	2	1	40773	1	10	0	0	0	0	0	
49324	3	1	41305	1	5.5	0	0	0	0	0	
49324	4	1	41304	1	8	0	0	0	0	0	
49324	5	1	41303	1	12	0	0	0	0	0	
49324	6	1	41300	1	3.5	0	0	0	0	0	
49324	7	1	49290	2	15	0	0	0	0	0	
49324	8	1	40200	8	10	0	0	0	0	0	
49324	9	1	40572	2	15	0	0	0	0	0	
49324	10	1	40021	3	6	0	0	0	0	0	
49324	11	1	40362	5	13	0	0	0	0	0	
49325	1	1	37977	1	100	1	0	0	0	0	
49325	2	2	40022	10	10.95	0	0	0	0	0	
49325	3	2	40687	1	0.05	1	0	0	0	0	
49325	4	2	40701	1	2	1	0	0	0	0	
49325	5	2	40351	1	12	1	0	0	0	0	
49325	6	2	41297	40	27	0	0	0	0	0	
49325	7	2	41298	40	27	0	0	0	0	0	
49325	8	2	41299	40	21	0	0	0	0	0	
49326	1	1	37978	1	100	1	0	0	0	0	
49326	2	2	40370	1	0.1	1	0	0	0	0	
49326	3	2	40022	10	8.9	0	0	0	0	0	
49326	4	2	40336	1	4	1	0	0	0	0	
49326	5	2	40274	1	5	1	0	0	0	0	
49326	6	2	40037	20	32	0	0	0	0	0	
49326	7	2	40106	20	32	0	0	0	0	0	
49326	8	2	40111	20	18	0	0	0	0	0	
49327	1	1	39101	1	17.4	0	0	0	0	0	
49327	2	1	31969	1	10	0	0	0	0	0	
49327	3	1	31974	1	10	0	0	0	0	0	
49327	4	1	31970	2	8	0	0	0	0	0	
49327	5	1	31975	2	8	0	0	0	0	0	
49327	6	1	31971	2	6	0	0	0	0	0	
49327	7	1	31976	2	6	0	0	0	0	0	
49327	8	1	31972	2	6	0	0	0	0	0	
49327	9	1	31977	2	6	0	0	0	0	0	
49327	10	1	31973	2	4	0	0	0	0	0	
49327	11	1	31978	2	4	0	0	0	0	0	
49327	12	1	34155	2	4	0	0	0	0	0	
49327	13	1	34156	2	4	0	0	0	0	0	
49327	14	1	39076	1	1.5	0	0	0	0	0	
49327	15	1	39078	1	1.5	0	0	0	0	0	
49327	16	1	39095	1	1	0	0	0	0	0	
49327	17	1	39096	1	1	0	0	0	0	0	
49327	18	1	39097	1	1	0	0	0	0	0	
49327	19	1	39075	1	0.25	0	0	0	0	0	
49327	20	1	39077	1	0.2	0	0	0	0	0	
49327	21	1	39092	1	0.05	0	0	0	0	0	
49327	22	1	39093	1	0.05	0	0	0	0	0	
49327	23	1	39094	1	0.05	0	0	0	0	0	
49328	1	1	40453	1	4	0	0	0	0	0	
49328	2	1	40454	1	2	0	0	0	0	0	
49328	3	1	40299	1	8	0	0	0	0	0	
49328	4	1	40300	1	6	0	0	0	0	0	
49328	5	1	40455	1	20	0	0	0	0	0	
49328	6	1	41111	3	60	0	0	0	0	0	
49329	15	1	41541	1	0.2	1	0	0	0	0	
49329	16	1	41340	1	0.6	1	0	0	0	0	
49329	17	1	40682	1	0.2	1	0	0	0	0	
49329	12	1	41269	1	2	0	0	0	0	0	
49329	13	1	41273	1	2.5	0	0	0	0	0	
49329	14	1	40312	1	1	0	0	0	0	0	
49329	6	1	40114	1	4	0	0	0	0	0	
49329	11	1	40317	1	2.5	0	0	0	0	0	
49329	7	1	40184	1	4	0	0	0	0	0	
49329	8	1	41542	1	15	0	0	0	0	0	
49329	3	1	40022	1	15	0	0	0	0	0	
49329	9	1	48902	1	4	0	0	0	0	0	
49329	10	1	48903	1	5	0	0	0	0	0	
49329	4	1	40158	1	14	0	0	0	0	0	
49329	5	1	40201	1	12	0	0	0	0	0	
49329	1	1	40153	3	9	0	0	0	0	0	
49329	2	1	40155	3	9	0	0	0	0	0	
49330	1	1	40509	3	12.1	0	0	0	0	0	
49330	2	1	41091	1	3	0	0	0	0	0	
49330	3	1	41764	1	0.8	1	0	0	0	0	
49330	4	1	41765	1	2	0	0	0	0	0	
49330	5	1	41768	1	0.6	1	0	0	0	0	
49330	6	1	41769	1	1.5	0	0	0	0	0	
49330	7	1	40437	1	0.4	1	0	0	0	0	
49330	8	1	40441	1	1.5	0	0	0	0	0	
49330	9	1	41196	1	0.4	0	0	0	0	0	
49330	10	1	41197	1	0.2	0	0	0	0	0	
49330	11	1	41300	1	1.5	0	0	0	0	0	
49330	12	1	40022	2	2	0	0	0	0	0	
49330	13	1	49290	1	6	0	0	0	0	0	
49330	14	1	41192	1	2	0	0	0	0	0	
49330	15	1	41193	1	1	0	0	0	0	0	
49330	16	1	40572	1	13	0	0	0	0	0	
49330	17	1	41493	1	2.3	0	0	0	0	0	
49330	18	1	40190	5	3.2	0	0	0	0	0	
49330	19	1	40191	11	5	0	0	0	0	0	
49330	20	1	40192	11	3.5	0	0	0	0	0	
49330	21	1	40193	11	6	0	0	0	0	0	
49330	22	1	41093	3	5	0	0	0	0	0	
49330	23	1	40202	7	5	0	0	0	0	0	
49330	24	1	41188	1	4	0	0	0	0	0	
49330	25	1	41189	1	2	0	0	0	0	0	
49330	26	1	40040	12	8	0	0	0	0	0	
49330	27	1	40042	5	8	0	0	0	0	0	
49331	1	1	40509	3	12	0	0	0	0	0	
49331	2	1	40122	10	5	0	0	0	0	0	
49331	3	1	41563	1	0.8	1	0	0	0	0	
49331	4	1	41564	1	2	0	0	0	0	0	
49331	5	1	41567	1	0.6	1	0	0	0	0	
49331	6	1	41568	1	1.5	0	0	0	0	0	
49331	7	1	40196	1	0.4	1	0	0	0	0	
49331	8	1	40199	1	1.5	0	0	0	0	0	
49331	9	1	41196	1	0.4	0	0	0	0	0	
49331	10	1	41197	1	0.2	0	0	0	0	0	
49331	11	1	41300	1	1.5	0	0	0	0	0	
49331	12	1	40021	2	4	0	0	0	0	0	
49331	13	1	41090	45	7	0	0	0	0	0	
49331	14	1	41192	1	2	0	0	0	0	0	
49331	15	1	41193	1	1	0	0	0	0	0	
49331	16	1	40572	1	12	0	0	0	0	0	
49331	17	1	40184	1	2	0	0	0	0	0	
49331	18	1	40190	5	3.2	0	0	0	0	0	
49331	19	1	40191	11	5	0	0	0	0	0	
49331	20	1	40192	11	3.5	0	0	0	0	0	
49331	21	1	40193	11	6	0	0	0	0	0	
49331	22	1	41093	3	5	0	0	0	0	0	
49331	23	1	40202	7	5	0	0	0	0	0	
49331	24	1	41188	1	4	0	0	0	0	0	
49331	25	1	41189	1	2	0	0	0	0	0	
49331	26	1	41088	45	6.4	0	0	0	0	0	
49331	27	1	40183	22	6	0	0	0	0	0	
49332	1	1	40509	3	12	0	0	0	0	0	
49332	2	1	49290	1	5	0	0	0	0	0	
49332	3	1	41775	1	0.6	1	0	0	0	0	
49332	4	1	41777	1	2	0	0	0	0	0	
49332	5	1	41780	1	0.7	1	0	0	0	0	
49332	6	1	41782	1	1.5	0	0	0	0	0	
49332	7	1	41515	1	0.4	1	0	0	0	0	
49332	8	1	41516	1	1.5	0	0	0	0	0	
49332	9	1	41196	1	0.4	0	0	0	0	0	
49332	10	1	41197	1	0.2	0	0	0	0	0	
49332	11	1	41300	1	1.5	0	0	0	0	0	
49332	12	1	40022	2	2	0	0	0	0	0	
49332	13	1	41493	1	3	0	0	0	0	0	
49332	14	1	41192	1	2	0	0	0	0	0	
49332	15	1	41193	1	1	0	0	0	0	0	
49332	16	1	40572	1	13.4	0	0	0	0	0	
49332	17	1	40380	1	3	0	0	0	0	0	
49332	18	1	40190	5	3.3	0	0	0	0	0	
49332	19	1	40191	11	5	0	0	0	0	0	
49332	20	1	40192	11	3.5	0	0	0	0	0	
49332	21	1	40193	11	6	0	0	0	0	0	
49332	22	1	41093	3	5	0	0	0	0	0	
49332	23	1	40202	7	5	0	0	0	0	0	
49332	24	1	41188	1	4	0	0	0	0	0	
49332	25	1	41189	1	2	0	0	0	0	0	
49332	26	1	40040	12	8	0	0	0	0	0	
49332	27	1	40042	5	8	0	0	0	0	0	
49333	1	1	34279	5	3.5	0	0	0	0	0	
49333	2	1	36909	2	2	0	0	0	0	0	
49333	3	1	36910	2	2	0	0	0	0	0	
49333	4	1	36911	2	2	0	0	0	0	0	
49333	5	1	36912	2	2	0	0	0	0	0	
49333	6	1	37063	2	2	0	0	0	0	0	
49333	7	1	37064	2	2	0	0	0	0	0	
49333	8	1	37065	2	2	0	0	0	0	0	
49333	9	1	37066	2	2	0	0	0	0	0	
49333	10	1	37067	2	1	0	0	0	0	0	
49333	11	1	37068	2	1	0	0	0	0	0	
49333	12	1	37069	2	1	0	0	0	0	0	
49333	13	1	37070	2	1	0	0	0	0	0	
49333	17	1	39085	2	2	0	0	0	0	0	
49333	18	1	39086	2	2	0	0	0	0	0	
49333	19	1	39087	2	2	0	0	0	0	0	
49333	20	1	39088	2	1.5	0	0	0	0	0	
49333	21	1	39089	2	1.5	0	0	0	0	0	
49333	22	1	39090	2	1.5	0	0	0	0	0	
49333	23	1	31969	3	2	0	0	0	0	0	
49333	24	1	31970	3	2	0	0	0	0	0	
49333	25	1	31971	3	2	0	0	0	0	0	
49333	26	1	31972	3	2	0	0	0	0	0	
49333	27	1	31973	3	2	0	0	0	0	0	
49333	28	1	31974	3	2	0	0	0	0	0	
49333	29	1	31975	3	2	0	0	0	0	0	
49333	30	1	31976	3	2	0	0	0	0	0	
49333	31	1	31977	3	2	0	0	0	0	0	
49333	32	1	31978	3	2	0	0	0	0	0	
49333	33	1	34155	3	2	0	0	0	0	0	
49333	34	1	34156	3	2	0	0	0	0	0	
49333	35	1	31299	5	3	0	0	0	0	0	
49333	36	1	31300	5	2	0	0	0	0	0	
49333	37	1	31301	5	1	0	0	0	0	0	
49333	38	1	31302	5	3	0	0	0	0	0	
49333	39	1	31303	5	2	0	0	0	0	0	
49333	40	1	31304	5	1	0	0	0	0	0	
49333	41	1	34886	2	4	0	0	0	0	0	
49333	42	1	34887	2	3	0	0	0	0	0	
49333	43	1	34888	1	2	0	0	0	0	0	
49333	44	1	34889	1	1	0	0	0	0	0	
49333	45	1	30006	15	2	0	0	0	0	0	
49333	46	1	30007	15	2	0	0	0	0	0	
49333	47	1	30008	15	2	0	0	0	0	0	
49333	48	1	30009	15	2	0	0	0	0	0	
49333	49	1	35875	15	2	0	0	0	0	0	
49333	50	1	30011	15	2	0	0	0	0	0	
49333	51	1	30012	15	2	0	0	0	0	0	
49333	52	1	30013	15	2	0	0	0	0	0	
49333	53	1	30014	15	2	0	0	0	0	0	
49333	54	1	35878	15	2	0	0	0	0	0	
49334	1	1	40543	1	2	0	0	0	0	0	
49334	2	1	40544	1	1.5	0	0	0	0	0	
49334	3	1	40545	1	1	0	0	0	0	0	
49334	4	1	40546	1	0.5	0	0	0	0	0	
49334	5	1	41302	1	0.2	0	0	0	0	0	
49334	6	1	40368	1	0.8	0	0	0	0	0	
49334	7	1	40369	1	0.2	0	0	0	0	0	
49334	8	1	40370	1	0.06	1	0	0	0	0	
49334	9	1	40687	1	0.02	1	0	0	0	0	
49334	10	1	40156	3	3	0	0	0	0	0	
49334	11	1	40157	1	2.92	0	0	0	0	0	
49334	12	1	40158	1	2	0	0	0	0	0	
49334	13	1	41415	1	2	0	0	0	0	0	
49334	14	1	41416	1	2	0	0	0	0	0	
49334	15	1	41417	1	2	0	0	0	0	0	
49334	16	1	41418	1	2	0	0	0	0	0	
49334	17	1	41419	1	2	0	0	0	0	0	
49334	18	1	41420	1	2	0	0	0	0	0	
49334	19	1	41440	1	1	0	0	0	0	0	
49334	20	1	41441	1	1	0	0	0	0	0	
49334	21	1	41442	1	1	0	0	0	0	0	
49334	22	1	41443	1	1	0	0	0	0	0	
49334	23	1	41444	1	1	0	0	0	0	0	
49334	24	1	41445	1	1	0	0	0	0	0	
49334	25	1	41446	1	1	0	0	0	0	0	
49334	26	1	41467	1	0.4	0	0	0	0	0	
49334	27	1	41468	1	0.4	0	0	0	0	0	
49334	28	1	41469	1	0.4	0	0	0	0	0	
49334	29	1	41482	1	0.4	0	0	0	0	0	
49334	30	1	41483	1	0.4	0	0	0	0	0	
49334	31	1	41484	1	0.4	0	0	0	0	0	
49334	32	1	34396	1	1	0	0	0	0	0	
49334	33	1	34397	1	1	0	0	0	0	0	
49334	34	1	34398	1	1	0	0	0	0	0	
49334	35	1	34399	1	1	0	0	0	0	0	
49334	36	1	34400	1	1	0	0	0	0	0	
49334	37	1	34401	1	1	0	0	0	0	0	
49334	38	1	34402	1	1	0	0	0	0	0	
49334	39	1	34403	1	2	0	0	0	0	0	
49334	40	1	34404	1	2	0	0	0	0	0	
49334	41	1	34405	1	2	0	0	0	0	0	
49334	42	1	34406	1	2	0	0	0	0	0	
49334	43	1	34407	1	2	0	0	0	0	0	
49334	44	1	34408	1	2	0	0	0	0	0	
49334	45	1	34410	1	0.4	0	0	0	0	0	
49334	46	1	34411	1	0.4	0	0	0	0	0	
49334	47	1	34412	1	0.4	0	0	0	0	0	
49334	48	1	34413	1	0.4	0	0	0	0	0	
49334	49	1	34414	1	0.4	0	0	0	0	0	
49334	50	1	34415	1	0.4	0	0	0	0	0	
49334	51	1	34937	2	1	0	0	0	0	0	
49334	52	1	34938	2	1	0	0	0	0	0	
49334	53	1	34939	2	1	0	0	0	0	0	
49334	54	1	36930	2	1	0	0	0	0	0	
49334	55	1	34940	2	1	0	0	0	0	0	
49334	56	1	34941	2	1	0	0	0	0	0	
49334	57	1	34942	2	1	0	0	0	0	0	
49334	58	1	36931	2	1	0	0	0	0	0	
49334	59	1	34943	1	1	0	0	0	0	0	
49334	60	1	34944	1	1	0	0	0	0	0	
49334	61	1	34945	1	1	0	0	0	0	0	
49334	62	1	34946	1	1	0	0	0	0	0	
49334	63	1	34947	1	1	0	0	0	0	0	
49334	64	1	34948	1	1	0	0	0	0	0	
49334	65	1	34949	1	1	0	0	0	0	0	
49334	66	1	34950	1	1	0	0	0	0	0	
49334	67	1	34951	1	1	0	0	0	0	0	
49334	68	1	34952	1	1	0	0	0	0	0	
49334	69	1	34953	1	1	0	0	0	0	0	
49334	70	1	34954	1	1	0	0	0	0	0	
49334	71	1	36584	1	1	0	0	0	0	0	
49334	72	1	36585	1	1	0	0	0	0	0	
49334	73	1	36586	1	1	0	0	0	0	0	
49334	74	1	36587	1	1	0	0	0	0	0	
49334	75	1	36926	1	1	0	0	0	0	0	
49334	76	1	36927	1	1	0	0	0	0	0	
49334	77	1	36928	1	1	0	0	0	0	0	
49334	78	1	36929	1	1	0	0	0	0	0	
49334	79	1	40209	2	2	0	0	0	0	0	
49334	80	1	40211	2	2	0	0	0	0	0	
49334	81	1	40213	2	2	0	0	0	0	0	
49334	82	1	40215	2	2	0	0	0	0	0	
49334	83	1	40217	2	2	0	0	0	0	0	
49334	84	1	40202	5	1	0	0	0	0	0	
49334	85	1	40190	3	1	0	0	0	0	0	
49334	86	1	40191	7	1	0	0	0	0	0	
49334	87	1	40192	7	1	0	0	0	0	0	
49334	88	1	40193	7	1	0	0	0	0	0	
49335	1	1	40509	3	12	0	0	0	0	0	
49335	2	1	41091	1	3	0	0	0	0	0	
49335	3	1	41785	1	0.8	1	0	0	0	0	
49335	4	1	41786	1	2	0	0	0	0	0	
49335	5	1	41789	1	0.6	1	0	0	0	0	
49335	6	1	41790	1	1.5	0	0	0	0	0	
49335	7	1	41155	1	0.4	1	0	0	0	0	
49335	8	1	41157	1	1.5	0	0	0	0	0	
49335	9	1	41196	1	0.4	0	0	0	0	0	
49335	10	1	41197	1	0.2	0	0	0	0	0	
49335	11	1	41300	1	1.5	0	0	0	0	0	
49335	12	1	40021	2	4	0	0	0	0	0	
49335	13	1	41089	1	4	0	0	0	0	0	
49335	14	1	41192	1	2	0	0	0	0	0	
49335	15	1	41193	1	1	0	0	0	0	0	
49335	16	1	40572	1	13.3	0	0	0	0	0	
49335	17	1	40122	10	5	0	0	0	0	0	
49335	19	1	40190	5	3.3	0	0	0	0	0	
49335	20	1	40191	11	5	0	0	0	0	0	
49335	21	1	40192	11	3.5	0	0	0	0	0	
49335	22	1	40193	11	6	0	0	0	0	0	
49335	23	1	41093	3	5	0	0	0	0	0	
49335	24	1	40202	7	5	0	0	0	0	0	
49335	25	1	41188	1	4	0	0	0	0	0	
49335	26	1	41189	1	2	0	0	0	0	0	
49335	27	1	40183	22	6	0	0	0	0	0	
49335	28	1	41088	45	7	0	0	0	0	0	
49336	1	1	40368	1	4	0	0	0	0	0	
49336	2	1	40022	4	5	0	0	0	0	0	
49336	3	1	41304	1	1.25	0	0	0	0	0	
49336	4	1	41301	1	0.05	1	0	0	0	0	
49336	5	1	41302	1	1	0	0	0	0	0	
49336	6	1	40687	1	0.1	1	0	0	0	0	
49336	7	1	40546	1	2	0	0	0	0	0	
49336	8	1	41591	1	0.25	1	0	0	0	0	
49336	9	1	41592	1	1.2	0	0	0	0	0	
49336	10	1	41571	1	0.5	1	0	0	0	0	
49336	11	1	41572	1	1.5	0	0	0	0	0	
49336	12	1	41599	1	0.6	1	0	0	0	0	
49336	13	1	41600	1	2	0	0	0	0	0	
49336	14	1	40369	1	2	0	0	0	0	0	
49336	15	1	40370	1	0.5	0	0	0	0	0	
49336	16	1	40184	2	3.5	0	0	0	0	0	
49336	17	1	41300	1	2.5	0	0	0	0	0	
49336	18	1	41193	1	2	0	0	0	0	0	
49336	19	1	41192	1	4	0	0	0	0	0	
49336	20	1	41191	2	7	0	0	0	0	0	
49336	21	1	41190	3	12	0	0	0	0	0	
49336	22	1	41189	1	3	0	0	0	0	0	
49336	23	1	41188	2	6	0	0	0	0	0	
49336	24	1	41187	3	9	0	0	0	0	0	
49336	25	1	41186	6	12	0	0	0	0	0	
49336	26	1	40362	6	17.05	0	0	0	0	0	
49337	1	1	40509	3	11.95	0	0	0	0	0	
49337	2	1	41090	40	5.5	0	0	0	0	0	
49337	3	1	41595	1	0.8	1	0	0	0	0	
49337	4	1	41596	1	2	0	0	0	0	0	
49337	5	1	41852	1	0.35	1	0	0	0	0	
49337	6	1	41853	1	1.5	0	0	0	0	0	
49337	7	1	41196	1	0.4	0	0	0	0	0	
49337	8	1	41197	1	0.2	0	0	0	0	0	
49337	9	1	41300	1	1.5	0	0	0	0	0	
49337	10	1	40021	2	4	0	0	0	0	0	
49337	11	1	41089	1	4	0	0	0	0	0	
49337	12	1	41192	1	2	0	0	0	0	0	
49337	13	1	41193	1	1	0	0	0	0	0	
49337	14	1	40572	1	13	0	0	0	0	0	
49337	15	1	40122	10	5	0	0	0	0	0	
49337	16	1	40190	5	3.3	0	0	0	0	0	
49337	17	1	40191	11	5	0	0	0	0	0	
49337	18	1	40192	11	3.5	0	0	0	0	0	
49337	19	1	40193	11	6	0	0	0	0	0	
49337	20	1	41093	3	5	0	0	0	0	0	
49337	21	1	40202	7	5	0	0	0	0	0	
49337	22	1	41188	1	4	0	0	0	0	0	
49337	23	1	41189	1	2	0	0	0	0	0	
49337	24	1	40183	22	6	0	0	0	0	0	
49337	25	1	41088	45	7	0	0	0	0	0	
49338	1	1	40509	3	12	0	0	0	0	0	
49338	2	1	49290	1	5.5	0	0	0	0	0	
49338	3	1	41156	1	0.6	1	0	0	0	0	
49338	4	1	41158	1	2	0	0	0	0	0	
49338	5	1	41575	1	0.5	1	0	0	0	0	
49338	6	1	41576	1	1.5	0	0	0	0	0	
49338	7	1	40702	1	0.35	1	0	0	0	0	
49338	8	1	40742	1	1.25	0	0	0	0	0	
49338	9	1	41196	1	0.4	0	0	0	0	0	
49338	10	1	41197	1	0.2	0	0	0	0	0	
49338	11	1	41300	1	1.5	0	0	0	0	0	
49338	12	1	40022	2	2	0	0	0	0	0	
49338	13	1	41493	1	3	0	0	0	0	0	
49338	14	1	41192	1	2	0	0	0	0	0	
49338	15	1	41193	1	1	0	0	0	0	0	
49338	16	1	40572	1	13.4	0	0	0	0	0	
49338	17	1	40380	1	3	0	0	0	0	0	
49338	18	1	40190	5	3.3	0	0	0	0	0	
49338	19	1	40191	11	5	0	0	0	0	0	
49338	20	1	40192	11	3.5	0	0	0	0	0	
49338	21	1	40193	11	6	0	0	0	0	0	
49338	22	1	41093	3	5	0	0	0	0	0	
49338	23	1	40202	7	5	0	0	0	0	0	
49338	24	1	41188	1	4	0	0	0	0	0	
49338	25	1	41189	1	2	0	0	0	0	0	
49338	26	1	40040	12	8	0	0	0	0	0	
49338	27	1	40042	5	8	0	0	0	0	0	
49339	1	1	40509	3	12	0	0	0	0	0	
49339	2	1	41091	1	3	0	0	0	0	0	
49339	3	1	41603	1	0.7	1	0	0	0	0	
49339	4	1	41604	1	2	0	0	0	0	0	
49339	5	1	41547	1	0.6	1	0	0	0	0	
49339	6	1	41548	1	1.5	0	0	0	0	0	
49339	7	1	41551	1	0.4	1	0	0	0	0	
49339	8	1	41552	1	1.5	0	0	0	0	0	
49339	9	1	41196	1	0.4	0	0	0	0	0	
49339	10	1	41197	1	0.2	0	0	0	0	0	
49339	11	1	41300	1	1.5	0	0	0	0	0	
49339	12	1	40021	2	4	0	0	0	0	0	
49339	13	1	41089	1	4	0	0	0	0	0	
49339	14	1	41192	1	2	0	0	0	0	0	
49339	15	1	41193	1	1	0	0	0	0	0	
49339	16	1	40572	1	13.4	0	0	0	0	0	
49339	17	1	40122	10	5	0	0	0	0	0	
49339	19	1	40190	5	3.3	0	0	0	0	0	
49339	20	1	40191	11	5	0	0	0	0	0	
49339	21	1	40192	11	3.5	0	0	0	0	0	
49339	22	1	40193	11	6	0	0	0	0	0	
49339	23	1	41093	3	5	0	0	0	0	0	
49339	24	1	40202	7	5	0	0	0	0	0	
49339	25	1	41188	1	4	0	0	0	0	0	
49339	26	1	41189	1	2	0	0	0	0	0	
49339	27	1	40183	22	6	0	0	0	0	0	
49339	28	1	41088	45	7	0	0	0	0	0	
49340	1	1	39101	1	17.4	0	0	0	0	0	
49340	2	1	31969	1	10	0	0	0	0	0	
49340	3	1	31974	1	10	0	0	0	0	0	
49340	4	1	31970	2	8	0	0	0	0	0	
49340	5	1	31975	2	8	0	0	0	0	0	
49340	6	1	31971	2	6	0	0	0	0	0	
49340	7	1	31976	2	6	0	0	0	0	0	
49340	8	1	31972	2	6	0	0	0	0	0	
49340	9	1	31977	2	6	0	0	0	0	0	
49340	10	1	31973	2	4	0	0	0	0	0	
49340	11	1	31978	2	4	0	0	0	0	0	
49340	12	1	34155	2	4	0	0	0	0	0	
49340	13	1	34156	2	4	0	0	0	0	0	
49340	14	1	41882	1	1.2	0	0	0	0	0	
49340	15	1	41886	1	1.2	0	0	0	0	0	
49340	16	1	41890	1	2	0	0	0	0	0	
49340	17	1	41894	1	2	0	0	0	0	0	
49340	18	1	41881	1	0.05	0	0	0	0	0	
49340	19	1	41885	1	0.05	0	0	0	0	0	
49340	20	1	41889	1	0.05	0	0	0	0	0	
49340	21	1	41893	1	0.05	0	0	0	0	0	
49341	1	1	40509	3	12	0	0	0	0	0	
49341	2	1	49290	1	5.5	0	0	0	0	0	
49341	3	1	41793	1	0.7	1	0	0	0	0	
49341	4	1	41794	1	2	0	0	0	0	0	
49341	5	1	41910	1	0.6	1	0	0	0	0	
49341	6	1	41911	1	1.5	0	0	0	0	0	
49341	7	1	41914	1	0.4	1	0	0	0	0	
49341	8	1	41915	1	1	0	0	0	0	0	
49341	9	1	41196	1	0.4	0	0	0	0	0	
49341	10	1	41197	1	0.2	0	0	0	0	0	
49341	11	1	41300	1	1.5	0	0	0	0	0	
49341	12	1	40022	2	2	0	0	0	0	0	
49341	13	1	41493	1	3	0	0	0	0	0	
49341	14	1	41192	1	2	0	0	0	0	0	
49341	15	1	41193	1	1	0	0	0	0	0	
49341	16	1	40572	1	13.4	0	0	0	0	0	
49341	17	1	40380	1	3	0	0	0	0	0	
49341	18	1	40190	5	3.3	0	0	0	0	0	
49341	19	1	40191	11	5	0	0	0	0	0	
49341	20	1	40192	11	3.5	0	0	0	0	0	
49341	21	1	40193	11	6	0	0	0	0	0	
49341	22	1	41093	3	5	0	0	0	0	0	
49341	23	1	40202	7	5	0	0	0	0	0	
49341	24	1	41188	1	4	0	0	0	0	0	
49341	25	1	41189	1	2	0	0	0	0	0	
49341	26	1	40040	12	8	0	0	0	0	0	
49341	27	1	40042	5	8	0	0	0	0	0	
49342	1	1	40509	3	12	0	0	0	0	0	
49342	2	1	41091	1	3	0	0	0	0	0	
49342	3	1	41856	1	0.8	1	0	0	0	0	
49342	4	1	41857	1	2	0	0	0	0	0	
49342	5	1	41860	1	0.6	1	0	0	0	0	
49342	6	1	41861	1	1.5	0	0	0	0	0	
49342	7	1	41314	1	0.4	1	0	0	0	0	
49342	8	1	41315	1	1.5	0	0	0	0	0	
49342	9	1	41196	1	0.4	0	0	0	0	0	
49342	10	1	41197	1	0.2	0	0	0	0	0	
49342	11	1	41300	1	1.5	0	0	0	0	0	
49342	12	1	40021	2	4	0	0	0	0	0	
49342	13	1	41089	1	4	0	0	0	0	0	
49342	14	1	41192	1	2	0	0	0	0	0	
49342	15	1	41193	1	1	0	0	0	0	0	
49342	16	1	40572	1	13.3	0	0	0	0	0	
49342	17	1	40122	10	5	0	0	0	0	0	
49342	18	1	40190	5	3.3	0	0	0	0	0	
49342	19	1	40191	11	5	0	0	0	0	0	
49342	20	1	40192	11	3.5	0	0	0	0	0	
49342	21	1	40193	11	6	0	0	0	0	0	
49342	22	1	41093	3	5	0	0	0	0	0	
49342	23	1	40202	7	5	0	0	0	0	0	
49342	24	1	41188	1	4	0	0	0	0	0	
49342	25	1	41189	1	2	0	0	0	0	0	
49342	26	1	40183	22	6	0	0	0	0	0	
49342	27	1	41088	45	7	0	0	0	0	0	
49343	1	1	40509	3	11.6	0	0	0	0	0	
49343	2	1	41090	40	5.5	0	0	0	0	0	
49343	3	1	41840	1	0.3	1	0	0	0	0	
49343	4	1	41841	1	1	0	0	0	0	0	
49343	5	1	41965	1	0.6	1	0	0	0	0	
49343	6	1	41966	1	1.5	0	0	0	0	0	
49343	7	1	41969	1	0.4	1	0	0	0	0	
49343	8	1	41970	1	1.2	0	0	0	0	0	
49343	9	1	41196	1	0.4	0	0	0	0	0	
49343	10	1	41197	1	0.2	0	0	0	0	0	
49343	11	1	41300	1	1.5	0	0	0	0	0	
49343	12	1	40021	2	4	0	0	0	0	0	
49343	13	1	41089	1	4	0	0	0	0	0	
49343	14	1	41192	1	2	0	0	0	0	0	
49343	15	1	41193	1	1	0	0	0	0	0	
49343	16	1	40572	1	13	0	0	0	0	0	
49343	17	1	40122	10	5	0	0	0	0	0	
49343	18	1	40190	5	3.3	0	0	0	0	0	
49343	19	1	40191	11	5	0	0	0	0	0	
49343	20	1	40192	11	3.5	0	0	0	0	0	
49343	21	1	40193	11	6	0	0	0	0	0	
49343	22	1	41093	3	5	0	0	0	0	0	
49343	23	1	40202	7	5	0	0	0	0	0	
49343	24	1	41188	1	4	0	0	0	0	0	
49343	25	1	41189	1	2	0	0	0	0	0	
49343	26	1	40183	22	6	0	0	0	0	0	
49343	27	1	41088	45	7	0	0	0	0	0	
49344	1	1	40509	3	11.4	0	0	0	0	0	
49344	2	1	49290	1	5.5	0	0	0	0	0	
49344	3	1	40488	1	0.7	1	0	0	0	0	
49344	4	1	40662	1	1.8	0	0	0	0	0	
49344	5	1	41555	1	0.6	1	0	0	0	0	
49344	6	1	41556	1	1.5	0	0	0	0	0	
49344	7	1	41559	1	0.4	1	0	0	0	0	
49344	8	1	41560	1	1.2	0	0	0	0	0	
49344	9	1	41197	1	0.2	0	0	0	0	0	
49344	10	1	41305	1	0.15	0	0	0	0	0	
49344	11	1	41300	1	1.5	0	0	0	0	0	
49344	12	1	40022	2	2	0	0	0	0	0	
49344	13	1	40122	10	5	0	0	0	0	0	
49344	14	1	41193	1	1	0	0	0	0	0	
49344	15	1	41304	1	0.6	0	0	0	0	0	
49344	16	1	40572	1	13	0	0	0	0	0	
49344	17	1	40156	4	6.15	0	0	0	0	0	
49344	18	1	40190	5	3.3	0	0	0	0	0	
49344	19	1	40191	11	5	0	0	0	0	0	
49344	20	1	40192	11	3.5	0	0	0	0	0	
49344	21	1	40193	11	6	0	0	0	0	0	
49344	22	1	41093	3	5	0	0	0	0	0	
49344	23	1	40202	7	5	0	0	0	0	0	
49344	24	1	41189	1	2	0	0	0	0	0	
49344	25	1	41303	1	1.5	0	0	0	0	0	
49344	26	1	40040	12	8	0	0	0	0	0	
49344	27	1	40042	5	8	0	0	0	0	0	
49345	1	1	40509	3	15.5	0	0	0	0	0	
49345	2	1	41091	1	3	0	0	0	0	0	
49345	3	1	41918	1	0.6	1	0	0	0	0	
49345	4	1	41919	1	2	0	0	0	0	0	
49345	5	1	41922	1	0.4	1	0	0	0	0	
49345	6	1	41923	1	1.5	0	0	0	0	0	
49345	7	1	41926	1	0.25	1	0	0	0	0	
49345	8	1	41927	1	1.2	0	0	0	0	0	
49345	9	1	41197	1	0.2	0	0	0	0	0	
49345	10	1	41305	1	0.15	0	0	0	0	0	
49345	11	1	41300	1	1.5	0	0	0	0	0	
49345	12	1	40022	2	2	0	0	0	0	0	
49345	13	1	41089	1	4	0	0	0	0	0	
49345	14	1	41193	1	1	0	0	0	0	0	
49345	15	1	41304	1	0.6	0	0	0	0	0	
49345	16	1	40572	1	16.8	0	0	0	0	0	
49345	17	1	40122	10	5	0	0	0	0	0	
49345	18	1	40190	5	3.3	0	0	0	0	0	
49345	19	1	40191	11	5	0	0	0	0	0	
49345	20	1	40192	11	3.5	0	0	0	0	0	
49345	21	1	40193	11	6	0	0	0	0	0	
49345	22	1	41093	3	5	0	0	0	0	0	
49345	23	1	40202	7	5	0	0	0	0	0	
49345	24	1	41189	1	2	0	0	0	0	0	
49345	25	1	41303	1	1.5	0	0	0	0	0	
49345	26	1	40183	22	6	0	0	0	0	0	
49345	27	1	41088	45	7	0	0	0	0	0	
49347	1	1	41092	1	3	0	0	0	0	0	
49347	2	1	48902	1	4	0	0	0	0	0	
49347	3	1	41091	1	2	0	0	0	0	0	
49347	4	1	40380	1	2	0	0	0	0	0	
49347	5	1	40115	1	1	0	0	0	0	0	
49347	6	1	48903	1	5	0	0	0	0	0	
49347	7	1	41493	1	1.8	0	0	0	0	0	
49347	8	1	40572	1	1	0	0	0	0	0	
49347	9	1	49290	1	5	0	0	0	0	0	
49347	10	1	41089	1	2	0	0	0	0	0	
49347	11	1	40509	3	12.9	0	0	0	0	0	
49347	12	1	41097	4	1	0	0	0	0	0	
49347	13	1	40042	5	8	0	0	0	0	0	
49347	14	1	40040	10	8	0	0	0	0	0	
49347	15	1	40122	10	5	0	0	0	0	0	
49347	16	2	41098	20	1	0	0	0	0	0	
49347	17	1	40183	22	5	0	0	0	0	0	
49347	18	1	41090	45	1	0	0	0	0	0	
49347	19	1	41088	45	15.5	0	0	0	0	0	
49347	20	1	41300	1	1	0	0	0	0	0	
49347	21	1	40022	2	2	0	0	0	0	0	
49347	22	1	40021	3	4	0	0	0	0	0	
49347	23	1	41196	1	0.35	0	0	0	0	0	
49347	24	1	41197	1	0.2	0	0	0	0	0	
49347	25	1	41305	1	0.15	0	0	0	0	0	
49347	26	1	41192	1	2	0	0	0	0	0	
49347	27	1	41193	1	1	0	0	0	0	0	
49347	28	1	41304	1	0.6	0	0	0	0	0	
49347	29	1	41188	1	2	0	0	0	0	0	
49347	30	1	41189	1	1.5	0	0	0	0	0	
49347	31	1	41303	1	1	0	0	0	0	0	
49348	1	1	40509	3	11.65	0	0	0	0	0	
49348	2	1	41091	1	3	0	0	0	0	0	
49348	3	1	41999	1	0.6	1	0	0	0	0	
49348	4	1	42000	1	2	0	0	0	0	0	
49348	5	1	42003	1	0.6	1	0	0	0	0	
49348	6	1	42004	1	2	0	0	0	0	0	
49348	7	1	40751	1	0.3	1	0	0	0	0	
49348	8	1	40752	1	2	0	0	0	0	0	
49348	9	1	42023	1	0.5	1	0	0	0	0	
49348	10	1	42024	1	2	0	0	0	0	0	
49348	11	1	41197	1	0.2	0	0	0	0	0	
49348	12	1	41305	1	0.15	0	0	0	0	0	
49348	13	1	41300	1	1.5	0	0	0	0	0	
49348	14	1	40022	2	2	0	0	0	0	0	
49348	15	1	41493	1	2.3	0	0	0	0	0	
49348	16	1	41193	1	1	0	0	0	0	0	
49348	17	1	41304	1	0.6	0	0	0	0	0	
49348	18	1	40572	1	16.8	0	0	0	0	0	
49348	19	1	40122	10	5	0	0	0	0	0	
49348	20	1	40190	5	3.3	0	0	0	0	0	
49348	21	1	40191	11	5	0	0	0	0	0	
49348	22	1	40192	11	3.5	0	0	0	0	0	
49348	23	1	40193	11	5	0	0	0	0	0	
49348	24	1	41093	3	5	0	0	0	0	0	
49348	25	1	40202	7	5	0	0	0	0	0	
49348	26	1	41189	1	2	0	0	0	0	0	
49348	27	1	41303	1	1	0	0	0	0	0	
49348	28	1	40183	22	8	0	0	0	0	0	
49348	29	1	41088	45	8	0	0	0	0	0	
49359	1	1	40509	3	11.4	0	0	0	0	0	
49359	2	1	49290	1	6	0	0	0	0	0	
49359	3	1	41844	1	0.3	1	0	0	0	0	
49359	4	1	41845	1	1	0	0	0	0	0	
49359	5	1	40991	1	0.6	1	0	0	0	0	
49359	6	1	40993	1	1.5	0	0	0	0	0	
49359	7	1	40994	1	0.4	1	0	0	0	0	
49359	8	1	40996	1	1.2	0	0	0	0	0	
49359	9	1	41197	1	0.2	0	0	0	0	0	
49359	10	1	41305	1	0.15	0	0	0	0	0	
49359	11	1	41300	1	1.5	0	0	0	0	0	
49359	12	1	40022	2	2	0	0	0	0	0	
49359	13	1	40122	10	5	0	0	0	0	0	
49359	14	1	41193	1	1	0	0	0	0	0	
49359	15	1	41304	1	0.6	0	0	0	0	0	
49359	16	1	40572	1	13	0	0	0	0	0	
49359	17	1	40156	4	6.85	0	0	0	0	0	
49359	18	1	40190	5	3.3	0	0	0	0	0	
49359	19	1	40191	11	5	0	0	0	0	0	
49359	20	1	40192	11	3.5	0	0	0	0	0	
49359	21	1	40193	11	6	0	0	0	0	0	
49359	22	1	41093	3	5	0	0	0	0	0	
49359	23	1	40202	7	5	0	0	0	0	0	
49359	24	1	41189	1	2	0	0	0	0	0	
49359	25	1	41303	1	1.5	0	0	0	0	0	
49359	26	1	40040	12	8	0	0	0	0	0	
49359	27	1	40042	5	8	0	0	0	0	0	
49360	1	1	41536	1	100	0	0	0	0	0	
49360	1	2	41539	1	100	0	0	0	0	0	
49360	1	3	40157	2	100	0	0	0	0	0	
49360	1	4	40350	1	100	0	0	0	0	0	
49360	1	5	40363	2	100	0	0	0	0	0	
49360	1	6	40364	2	101	0	0	0	0	0	
49360	1	7	40222	1	100	0	0	0	0	0	
49360	1	8	40572	5	100	0	0	0	0	0	
49361	1	1	41537	1	100	0	0	0	0	0	
49361	1	2	41540	1	100	0	0	0	0	0	
49361	1	3	40158	2	100	0	0	0	0	0	
49361	1	4	40274	1	100	0	0	0	0	0	
49361	1	5	40362	6	100	0	0	0	0	0	
49361	1	6	40364	2	101	0	0	0	0	0	
49361	1	7	40577	1	100	0	0	0	0	0	
49361	1	8	40184	1	100	0	0	0	0	0	
49362	1	1	41537	1	100	0	0	0	0	0	
49362	1	2	41541	1	100	0	0	0	0	0	
49362	1	3	40158	2	100	0	0	0	0	0	
49362	1	4	40312	1	100	0	0	0	0	0	
49362	1	5	41305	2	100	0	0	0	0	0	
49362	1	6	41302	1	101	0	0	0	0	0	
49362	1	7	40184	1	100	0	0	0	0	0	
49362	1	8	41494	1	100	0	0	0	0	0	
49362	1	9	41246	1	100	0	0	0	0	0	
49364	1	1	40509	3	12.95	0	0	0	0	0	
49364	2	1	41091	1	3	0	0	0	0	0	
49364	3	1	41543	1	0.6	1	0	0	0	0	
49364	4	1	41544	1	2	0	0	0	0	0	
49364	5	1	41360	1	0.4	1	0	0	0	0	
49364	6	1	41361	1	1.8	0	0	0	0	0	
49364	7	1	41901	1	0.4	1	0	0	0	0	
49364	8	1	41902	1	2	0	0	0	0	0	
49364	9	1	41197	1	0.2	0	0	0	0	0	
49364	10	1	41305	1	0.15	0	0	0	0	0	
49364	11	1	41300	1	1.5	0	0	0	0	0	
49364	12	1	40022	2	2	0	0	0	0	0	
49364	13	1	41493	1	2.3	0	0	0	0	0	
49364	14	1	41193	1	1	0	0	0	0	0	
49364	15	1	41304	1	0.6	0	0	0	0	0	
49364	16	1	40572	1	16.8	0	0	0	0	0	
49364	17	1	40122	10	5	0	0	0	0	0	
49364	18	1	40190	5	3.3	0	0	0	0	0	
49364	19	1	40191	11	5	0	0	0	0	0	
49364	20	1	40192	11	3.5	0	0	0	0	0	
49364	21	1	40193	11	6	0	0	0	0	0	
49364	22	1	41093	3	5	0	0	0	0	0	
49364	23	1	40202	7	5	0	0	0	0	0	
49364	24	1	41189	1	2	0	0	0	0	0	
49364	25	1	41303	1	1.5	0	0	0	0	0	
49364	26	1	40183	22	8	0	0	0	0	0	
49364	27	1	41088	45	8	0	0	0	0	0	
49365	1	1	40368	1	4	0	0	0	0	0	
49365	2	1	40022	4	4	0	0	0	0	0	
49365	3	1	41304	1	1.25	0	0	0	0	0	
49365	4	1	41301	1	0.05	1	0	0	0	0	
49365	5	1	41302	1	1	0	0	0	0	0	
49365	6	1	40687	1	0.1	1	0	0	0	0	
49365	7	1	40546	1	2	0	0	0	0	0	
49365	8	1	41289	1	0.45	1	0	0	0	0	
49365	9	1	41290	1	2	0	0	0	0	0	
49365	10	1	40772	1	0.3	1	0	0	0	0	
49365	11	1	40773	1	2	0	0	0	0	0	
49365	12	1	41539	1	0.9	1	0	0	0	0	
49365	13	1	41540	1	1.4	1	0	0	0	0	
49365	14	1	40369	1	2	0	0	0	0	0	
49365	15	1	40370	1	0.5	1	0	0	0	0	
49365	16	1	40184	2	3	0	0	0	0	0	
49365	17	1	41300	1	2	0	0	0	0	0	
49365	18	1	41193	1	3	0	0	0	0	0	
49365	19	1	41192	1	5	0	0	0	0	0	
49365	20	1	41191	2	7	0	0	0	0	0	
49365	21	1	41190	3	9	0	0	0	0	0	
49365	22	1	41189	1	5	0	0	0	0	0	
49365	23	1	41188	2	7	0	0	0	0	0	
49365	24	1	41187	3	9	0	0	0	0	0	
49365	25	1	41186	6	11	0	0	0	0	0	
49365	26	1	40362	6	17.05	0	0	0	0	0	
49366	1	1	40156	1	100	0	0	0	0	0	
49367	1	1	40156	2	100	0	0	0	0	0	
49367	2	2	41088	6	100	0	0	0	0	0	
49368	1	1	40156	2	100	0	0	0	0	0	
49368	2	2	40157	2	100	0	0	0	0	0	
49368	3	3	41088	6	100	0	0	0	0	0	
49368	4	4	41090	18	100	0	0	0	0	0	
49369	1	1	40311	1	100	0	0	0	0	0	
49369	2	2	41088	20	100	0	0	0	0	0	
49369	3	3	41090	27	100	0	0	0	0	0	
49370	1	1	40200	6	100	0	0	0	0	0	
49370	2	2	40367	1	100	0	0	0	0	0	
49371	1	1	41542	2	77	0	0	0	0	0	
49371	2	1	41536	1	8	0	0	0	0	0	
49371	3	1	40367	1	15	0	0	0	0	0	
49371	4	2	41542	2	100	0	0	0	0	0	
49372	1	1	41492	1	77	0	0	0	0	0	
49372	2	1	41493	1	20	0	0	0	0	0	
49372	3	1	41494	1	3	0	0	0	0	0	
49373	1	1	40509	3	12.15	0	0	0	0	0	
49373	2	1	41091	1	3	0	0	0	0	0	
49373	3	1	42045	1	0.6	1	0	0	0	0	
49373	4	1	42046	1	2	0	0	0	0	0	
49373	5	1	42053	1	0.8	1	0	0	0	0	
49373	6	1	42054	1	2	0	0	0	0	0	
49373	7	1	42061	1	0.6	1	0	0	0	0	
49373	8	1	42062	1	3	0	0	0	0	0	
49373	9	1	41197	1	0.2	0	0	0	0	0	
49373	10	1	41305	1	0.15	0	0	0	0	0	
49373	11	1	41300	1	1	0	0	0	0	0	
49373	12	1	40022	2	1.5	0	0	0	0	0	
49373	13	1	41493	1	1.8	0	0	0	0	0	
49373	14	1	41193	1	1	0	0	0	0	0	
49373	15	1	41304	1	0.6	0	0	0	0	0	
49373	16	1	40572	1	16.3	0	0	0	0	0	
49373	17	1	40122	10	5	0	0	0	0	0	
49373	18	1	40190	5	3.3	0	0	0	0	0	
49373	19	1	40191	11	5	0	0	0	0	0	
49373	20	1	40192	11	3.5	0	0	0	0	0	
49373	21	1	40193	11	6	0	0	0	0	0	
49373	22	1	41093	3	5	0	0	0	0	0	
49373	23	1	40202	7	5	0	0	0	0	0	
49373	24	1	41189	1	1.5	0	0	0	0	0	
49373	25	1	41303	1	1	0	0	0	0	0	
49373	26	1	40364	1	2	0	0	0	0	0	
49373	27	1	40040	12	8	0	0	0	0	0	
49373	28	1	40042	5	8	0	0	0	0	0	
49374	2	1	41755	1	0.2	1	0	0	0	0	
49374	3	1	42077	1	1.2	1	0	0	0	0	
49374	4	1	42081	1	1.8	1	0	0	0	0	
49374	5	1	42019	1	1.8	1	0	0	0	0	
49374	6	1	40225	1	3	0	0	0	0	0	
49374	7	1	40227	1	4	0	0	0	0	0	
49374	7	1	40346	1	4	0	0	0	0	0	
49374	7	1	40347	1	3	0	0	0	0	0	
49374	8	1	40100	1	4	0	0	0	0	0	
49374	9	1	40102	1	4	0	0	0	0	0	
49374	10	1	40116	1	4	0	0	0	0	0	
49374	11	1	41780	1	3	0	0	0	0	0	
49374	13	1	40545	1	4	0	0	0	0	0	
49374	14	1	40546	1	2	0	0	0	0	0	
49374	15	1	40350	1	4	0	0	0	0	0	
49374	16	1	40022	3	15	0	0	0	0	0	
49374	17	1	41192	1	5	0	0	0	0	0	
49374	18	1	41193	1	3	0	0	0	0	0	
49374	19	1	40367	3	15	0	0	0	0	0	
49374	20	1	41300	1	8	0	0	0	0	0	
49374	21	1	41493	3	10	0	0	0	0	0	
49374	1	2	39262	1	16	0	0	0	0	0	
49374	2	2	39263	1	16	0	0	0	0	0	
49374	3	2	39264	1	16	0	0	0	0	0	
49374	4	2	39265	1	16	0	0	0	0	0	
49374	5	2	39266	1	16	0	0	0	0	0	
49374	6	2	39267	1	15	0	0	0	0	0	
49374	7	2	39268	1	5	0	0	0	0	0	
49375	1	1	42065	1	5	0	0	0	0	0	
49375	2	1	42069	1	7	0	0	0	0	0	
49375	3	1	39075	1	5	0	0	0	0	0	
49375	4	1	39077	1	5	0	0	0	0	0	
49375	5	1	41632	1	7	0	0	0	0	0	
49375	6	1	39159	1	6	0	0	0	0	0	
49375	7	1	39143	1	6	0	0	0	0	0	
49375	8	1	41620	1	5	0	0	0	0	0	
49375	9	1	41624	1	5	0	0	0	0	0	
49375	10	1	38392	1	6	0	0	0	0	0	
49375	11	1	41245	1	6	0	0	0	0	0	
49375	12	1	41204	1	5	0	0	0	0	0	
49375	13	1	39157	1	5	0	0	0	0	0	
49375	14	1	39155	1	5	0	0	0	0	0	
49375	15	1	41893	1	5	0	0	0	0	0	
49375	16	1	41885	1	1	0	0	0	0	0	
49375	17	1	41889	1	5	0	0	0	0	0	
49375	18	1	41881	1	1	0	0	0	0	0	
49375	19	1	41212	1	5	0	0	0	0	0	
49375	20	1	41216	1	1	0	0	0	0	0	
49375	21	1	39092	1	1.3	0	0	0	0	0	
49375	22	1	39093	1	0.1	0	0	0	0	0	
49375	23	1	39094	1	1.6	0	0	0	0	0	
49375	24	1	36933	1	0.1	1	0	0	0	0	
49375	25	1	41302	1	0.6	1	0	0	0	0	
49375	26	1	41301	1	0.3	1	0	0	0	0	
49376	1	1	42073	1	0.3	1	0	0	0	0	
49376	2	1	42077	1	1.2	1	0	0	0	0	
49376	3	1	42081	1	1.8	1	0	0	0	0	
49376	4	1	40755	1	1	1	0	0	0	0	
49376	5	1	40229	1	4	0	0	0	0	0	
49376	6	1	40327	1	4	0	0	0	0	0	
49376	7	1	40224	1	3	0	0	0	0	0	
49376	8	1	40347	1	4	0	0	0	0	0	
49376	9	1	40231	1	3	0	0	0	0	0	
49376	10	1	40226	1	4	0	0	0	0	0	
49376	11	1	40223	1	4	0	0	0	0	0	
49376	12	1	40239	1	4	0	0	0	0	0	
49376	13	1	40322	1	4	0	0	0	0	0	
49376	14	1	40545	1	4	0	0	0	0	0	
49376	15	1	40546	1	2	0	0	0	0	0	
49376	16	1	40350	1	4	0	0	0	0	0	
49376	17	1	40022	3	14	0	0	0	0	0	
49376	18	1	41192	1	5	0	0	0	0	0	
49376	19	1	41193	1	3	0	0	0	0	0	
49376	20	1	40367	3	12	0	0	0	0	0	
49376	21	1	41300	1	8	0	0	0	0	0	
49376	22	1	41493	3	9.7	0	0	0	0	0	
49376	1	2	39262	1	16	0	0	0	0	0	
49376	2	2	39263	1	16	0	0	0	0	0	
49376	3	2	39264	1	16	0	0	0	0	0	
49376	4	2	39265	1	16	0	0	0	0	0	
49376	5	2	39266	1	16	0	0	0	0	0	
49376	6	2	39267	1	15	0	0	0	0	0	
49376	7	2	39268	1	5	0	0	0	0	0	
49377	1	1	42065	1	5	0	0	0	0	0	
49377	2	1	42069	1	5	0	0	0	0	0	
49377	3	1	39075	1	3	0	0	0	0	0	
49377	4	1	39077	1	3	0	0	0	0	0	
49377	5	1	41632	1	4	0	0	0	0	0	
49377	6	1	39159	1	0.5	0	0	0	0	0	
49377	7	1	39143	1	0.5	0	0	0	0	0	
49377	8	1	41620	1	4	0	0	0	0	0	
49377	9	1	41624	1	4	0	0	0	0	0	
49377	10	1	38392	1	0.5	0	0	0	0	0	
49377	11	1	41245	1	0.5	0	0	0	0	0	
49377	12	1	41204	1	3	0	0	0	0	0	
49377	13	1	40656	1	5	0	0	0	0	0	
49377	14	1	40657	1	4.5	0	0	0	0	0	
49377	15	1	40774	1	5	0	0	0	0	0	
49377	16	1	40812	1	4	0	0	0	0	0	
49377	17	1	40814	1	5	0	0	0	0	0	
49377	18	1	40816	1	5	0	0	0	0	0	
49377	19	1	40822	1	4	0	0	0	0	0	
49377	20	1	40824	1	5	0	0	0	0	0	
49377	21	1	40743	1	4	0	0	0	0	0	
49377	22	1	40745	1	4	0	0	0	0	0	
49377	23	1	40749	1	0.5	0	0	0	0	0	
49377	24	1	40751	1	5	0	0	0	0	0	
49377	25	1	39157	1	0.5	0	0	0	0	0	
49377	26	1	39155	1	0.5	0	0	0	0	0	
49377	27	1	41893	1	3	0	0	0	0	0	
49377	28	1	41885	1	1	0	0	0	0	0	
49377	29	1	41889	1	3	0	0	0	0	0	
49377	30	1	41881	1	1	0	0	0	0	0	
49377	31	1	41212	1	2	0	0	0	0	0	
49377	32	1	41216	1	1	0	0	0	0	0	
49377	33	1	39092	1	1.3	0	0	0	0	0	
49377	34	1	39093	1	0.1	0	0	0	0	0	
49377	35	1	39094	1	1.5	0	0	0	0	0	
49377	36	1	36933	1	0.1	1	0	0	0	0	
49377	37	1	36934	1	0.05	1	0	0	0	0	
49377	38	1	41302	1	0.55	1	0	0	0	0	
49377	39	1	41301	1	0.4	1	0	0	0	0	
49378	1	1	40509	3	12.15	0	0	0	0	0	
49378	2	1	41091	1	3	0	0	0	0	0	
49378	3	1	42113	1	0.6	1	0	0	0	0	
49378	4	1	42114	1	2	0	0	0	0	0	
49378	5	1	42109	1	0.8	1	0	0	0	0	
49378	6	1	42110	1	2	0	0	0	0	0	
49378	7	1	42105	1	0.6	1	0	0	0	0	
49378	8	1	42106	1	3	0	0	0	0	0	
49378	9	1	41197	1	0.2	0	0	0	0	0	
49378	10	1	41305	1	0.15	0	0	0	0	0	
49378	11	1	41300	1	1	0	0	0	0	0	
49378	12	1	40022	2	1.5	0	0	0	0	0	
49378	13	1	41493	1	1.8	0	0	0	0	0	
49378	14	1	41193	1	1	0	0	0	0	0	
49378	15	1	41304	1	0.6	0	0	0	0	0	
49378	16	1	40572	1	16.3	0	0	0	0	0	
49378	17	1	40122	10	5	0	0	0	0	0	
49378	18	1	40190	5	3.3	0	0	0	0	0	
49378	19	1	40191	11	5	0	0	0	0	0	
49378	20	1	40192	11	3.5	0	0	0	0	0	
49378	21	1	40193	11	6	0	0	0	0	0	
49378	22	1	41093	3	5	0	0	0	0	0	
49378	23	1	40202	7	5	0	0	0	0	0	
49378	24	1	41189	1	1.5	0	0	0	0	0	
49378	25	1	41303	1	1	0	0	0	0	0	
49378	26	1	40364	1	2	0	0	0	0	0	
49378	27	1	40040	12	8	0	0	0	0	0	
49378	28	1	40042	5	8	0	0	0	0	0	
49379	1	1	40311	1	100	0	0	0	0	0	
49379	2	2	48971	3	100	0	0	0	0	0	
49379	3	3	48907	20	100	0	0	0	0	0	
49380	1	1	40458	4	100	0	0	0	0	0	
49380	2	2	40451	10	100	0	0	0	0	0	
49380	3	3	48972	2	100	0	0	0	0	0	
49380	4	4	48907	50	100	0	0	0	0	0	
49380	5	5	40443	1	100	0	0	0	0	0	
49380	6	6	41136	1	50	0	0	0	0	0	
49380	7	6	41139	1	50	0	0	0	0	0	
49381	1	1	40458	6	100	0	0	0	0	0	
49381	2	2	40311	2	100	0	0	0	0	0	
49381	3	3	40451	10	100	0	0	0	0	0	
49381	4	4	48972	4	100	0	0	0	0	0	
49381	5	5	48907	50	100	0	0	0	0	0	
49381	6	6	40443	1	100	0	0	0	0	0	
49381	7	7	41136	1	50	0	0	0	0	0	
49381	8	7	41139	1	50	0	0	0	0	0	
49382	1	1	40458	10	100	0	0	0	0	0	
49382	2	2	40311	4	100	0	0	0	0	0	
49382	3	3	40451	20	100	0	0	0	0	0	
49382	4	4	48972	8	100	0	0	0	0	0	
49382	5	5	48969	20	100	0	0	0	0	0	
49382	6	6	48907	100	100	0	0	0	0	0	
49382	7	7	41118	20	100	0	0	0	0	0	
49382	8	8	41106	20	100	0	0	0	0	0	
49382	9	9	40443	1	100	0	0	0	0	0	
49382	10	10	41126	1	100	0	0	0	0	0	
49382	11	11	48904	1	100	0	0	0	0	0	
49382	12	12	48905	1	100	0	0	0	0	0	
49382	13	13	41136	1	49	0	0	0	0	0	
49382	14	13	41139	1	49	0	0	0	0	0	
49382	15	13	41134	1	1	0	0	0	0	0	
49382	16	13	41137	1	1	0	0	0	0	0	
49383	1	1	49281	1	8	0	0	0	0	0	
49383	2	1	49165	1	8	0	0	0	0	0	
49383	3	1	49289	1	8	0	0	0	0	0	
49383	4	1	49330	1	8	0	0	0	0	0	
49383	5	1	49332	1	7.5	0	0	0	0	0	
49383	6	1	49174	1	8	0	0	0	0	0	
49383	7	1	49269	1	0.5	1	0	0	0	0	
49383	8	1	49255	1	6	0	0	0	0	0	
49383	9	1	49257	1	5	0	0	0	0	0	
49383	10	1	49317	1	5	0	0	0	0	0	
49383	11	1	49167	1	4	0	0	0	0	0	
49383	12	1	49171	1	4	0	0	0	0	0	
49383	13	1	49192	1	4	0	0	0	0	0	
49383	14	1	49251	1	6	0	0	0	0	0	
49383	15	1	49318	1	5	0	0	0	0	0	
49383	16	1	49319	1	5	0	0	0	0	0	
49383	17	1	49311	1	4	0	0	0	0	0	
49383	18	1	49005	1	4	0	0	0	0	0	
49384	1	1	40760	1	0.2	1	0	0	0	0	
49384	2	1	40761	1	2	0	0	0	0	0	
49384	3	1	40826	1	0.05	1	0	0	0	0	
49384	4	1	40827	1	2	0	0	0	0	0	
49384	5	1	40812	1	1	1	0	0	0	0	
49384	6	1	40813	1	0.65	0	0	0	0	0	
49384	7	1	40814	1	1	1	0	0	0	0	
49384	8	1	40815	1	1	0	0	0	0	0	
49384	9	1	40816	1	0.8	1	0	0	0	0	
49384	10	1	40817	1	1	0	0	0	0	0	
49384	11	1	40822	1	0.8	1	0	0	0	0	
49384	12	1	40823	1	1	0	0	0	0	0	
49384	13	1	40236	1	0.8	1	0	0	0	0	
49384	14	1	40261	1	1	0	0	0	0	0	
49384	15	1	41189	1	2	0	0	0	0	0	
49384	16	1	41303	1	1.5	0	0	0	0	0	
49384	17	1	41193	1	1	0	0	0	0	0	
49384	18	1	41304	1	0.6	0	0	0	0	0	
49384	19	1	41197	1	0.2	0	0	0	0	0	
49384	20	1	41305	1	0.15	0	0	0	0	0	
49384	21	1	41300	1	1.5	0	0	0	0	0	
49384	22	1	40022	2	7	0	0	0	0	0	
49384	23	1	41493	2	8	0	0	0	0	0	
49384	24	1	40183	22	10	0	0	0	0	0	
49384	25	1	41088	45	10	0	0	0	0	0	
49384	26	1	40572	1	10.75	0	0	0	0	0	
49384	27	1	40122	10	6	0	0	0	0	0	
49384	28	1	41089	1	8	0	0	0	0	0	
49384	29	1	41090	45	12	0	0	0	0	0	
49384	30	1	49290	1	8	0	0	0	0	0	
49385	1	1	40760	1	0.2	1	0	0	0	0	
49385	2	1	40761	1	3	0	0	0	0	0	
49385	3	1	40826	1	0.05	1	0	0	0	0	
49385	4	1	40827	1	2	0	0	0	0	0	
49385	5	1	42105	1	1.2	1	0	0	0	0	
49385	6	1	42106	1	2.65	0	0	0	0	0	
49385	7	1	40230	1	1.2	1	0	0	0	0	
49385	8	1	40255	1	1	0	0	0	0	0	
49385	9	1	40247	1	1.2	1	0	0	0	0	
49385	15	1	41189	1	2	0	0	0	0	0	
49385	16	1	41303	1	1.5	0	0	0	0	0	
49385	17	1	41193	1	1	0	0	0	0	0	
49385	18	1	41304	1	0.6	0	0	0	0	0	
49385	19	1	41197	1	0.2	0	0	0	0	0	
49385	20	1	41305	1	0.15	0	0	0	0	0	
49385	21	1	41300	1	1.5	0	0	0	0	0	
49385	22	1	40022	2	7	0	0	0	0	0	
49385	23	1	41493	2	8	0	0	0	0	0	
49385	24	1	40183	22	10	0	0	0	0	0	
49385	25	1	41088	45	10	0	0	0	0	0	
49385	26	1	40572	1	12.55	0	0	0	0	0	
49385	27	1	40122	10	5	0	0	0	0	0	
49385	28	1	41089	1	8	0	0	0	0	0	
49385	29	1	41090	45	12	0	0	0	0	0	
49385	30	1	49290	1	8	0	0	0	0	0	
49386	1	1	40022	2	10	0	0	0	0	0	
49386	2	1	40362	4	10	0	0	0	0	0	
49386	3	1	40158	3	10	0	0	0	0	0	
49386	4	1	40577	1	1	1	0	0	0	0	
49386	5	1	40184	1	5	0	0	0	0	0	
49386	6	1	41493	4	5	0	0	0	0	0	
49386	7	1	41538	1	5	1	0	0	0	0	
49386	8	1	48902	1	4	1	0	0	0	0	
49386	9	1	48903	1	4	1	0	0	0	0	
49386	10	1	40319	1	6	1	0	0	0	0	
49386	11	1	40328	1	6	1	0	0	0	0	
49386	12	1	41225	1	6	1	0	0	0	0	
49386	13	1	41229	1	6	1	0	0	0	0	
49386	14	1	41793	1	5	1	0	0	0	0	
49386	15	1	41910	1	5	1	0	0	0	0	
49386	16	1	41914	1	5	1	0	0	0	0	
49386	17	1	41300	1	4	1	0	0	0	0	
49386	18	1	40312	1	1	1	0	0	0	0	
49386	19	1	41541	1	0.49	1	0	0	0	0	
49386	20	1	41340	1	1.0001	1	0	0	0	0	
49386	21	1	41344	1	0.5098	1	0	0	0	0	
49386	22	1	41352	1	0.0001	1	0	0	0	0	
49387	1	1	41301	1	0.08	1	0	0	0	0	
49387	2	1	40687	1	0.1	1	0	0	0	0	
49387	3	1	40370	1	0.5	1	0	0	0	0	
49387	4	1	40369	1	1	0	0	0	0	0	
49387	5	1	40368	1	2	0	0	0	0	0	
49387	6	1	41302	1	0.5	0	0	0	0	0	
49387	7	1	40546	1	1	0	0	0	0	0	
49387	8	1	40545	1	1.5	0	0	0	0	0	
49387	9	1	40544	1	2	0	0	0	0	0	
49387	10	1	40543	1	2	0	0	0	0	0	
49387	11	1	41304	1	2	0	0	0	0	0	
49387	12	1	41193	1	3	0	0	0	0	0	
49387	13	1	41192	1	4	0	0	0	0	0	
49387	14	1	41191	1	5	0	0	0	0	0	
49387	15	1	41190	1	6	0	0	0	0	0	
49387	16	1	41303	1	5	0	0	0	0	0	
49387	17	1	41189	2	6	0	0	0	0	0	
49387	18	1	41188	3	7	0	0	0	0	0	
49387	19	1	41352	1	0.3	1	0	0	0	0	
49387	20	1	40195	1	1	1	0	0	0	0	
49387	21	1	40196	1	1	1	0	0	0	0	
49387	22	1	42204	1	2.5	1	0	0	0	0	
49387	23	1	42206	1	1	1	0	0	0	0	
49387	24	1	41563	1	1.5	1	0	0	0	0	
49387	25	1	41567	1	1.5	1	0	0	0	0	
49387	26	1	41539	2	2	0	0	0	0	0	
49387	27	1	41540	1	1.4	0	0	0	0	0	
49387	28	1	41541	1	0.2	1	0	0	0	0	
49387	29	1	40372	1	0.1	1	0	0	0	0	
49387	30	1	40184	2	5	0	0	0	0	0	
49387	31	1	41300	1	2	0	0	0	0	0	
49387	32	1	40380	1	6	0	0	0	0	0	
49387	33	1	41542	6	15.32	0	0	0	0	0	
49387	34	1	40201	2	7	0	0	0	0	0	
49387	35	1	40363	1	3	0	0	0	0	0	
49387	36	1	40371	1	0.5	0	0	0	0	0	
49387	1	2	40313	10	20	0	0	0	0	0	
49387	2	2	40314	10	20	0	0	0	0	0	
49387	3	2	40315	10	20	0	0	0	0	0	
49387	4	2	42191	10	40	0	0	0	0	0	
49387	1	3	49269	1	0.5	0	0	0	0	0	
49387	2	3	40362	6	96.09	0	0	0	0	0	
49387	3	3	40362	25	2.5	0	0	0	0	0	
49387	4	3	40362	75	0.7	0	0	0	0	0	
49387	5	3	49213	2	0.15	1	0	0	0	0	
49387	6	3	49213	3	0.05	1	0	0	0	0	
49387	7	3	49213	5	0.01	1	0	0	0	0	
49388	1	1	40022	5	5	0	0	0	0	0	
49388	2	1	41301	1	0.08	1	0	0	0	0	
49388	3	1	40687	1	0.1	1	0	0	0	0	
49388	4	1	40370	1	0.5	1	0	0	0	0	
49388	5	1	40369	1	1	0	0	0	0	0	
49388	6	1	40368	1	2	0	0	0	0	0	
49388	7	1	41302	1	0.5	0	0	0	0	0	
49388	8	1	40546	1	1	0	0	0	0	0	
49388	9	1	40545	1	1.5	0	0	0	0	0	
49388	10	1	40544	1	2	0	0	0	0	0	
49388	11	1	40543	1	2	0	0	0	0	0	
49388	12	1	41304	1	2	0	0	0	0	0	
49388	13	1	41193	1	3	0	0	0	0	0	
49388	14	1	41192	1	4	0	0	0	0	0	
49388	15	1	41191	1	5	0	0	0	0	0	
49388	16	1	41190	1	6	0	0	0	0	0	
49388	17	1	41189	2	6	0	0	0	0	0	
49388	18	1	41188	3	7	0	0	0	0	0	
49388	19	1	41348	1	0.5	1	0	0	0	0	
49388	20	1	41350	1	2	0	0	0	0	0	
49388	21	1	34993	1	1	1	0	0	0	0	
49388	22	1	42192	1	2	1	0	0	0	0	
49388	23	1	42194	1	2	0	0	0	0	0	
49388	24	1	42049	1	2	1	0	0	0	0	
49388	25	1	42051	1	2	0	0	0	0	0	
49388	26	1	42057	1	2	1	0	0	0	0	
49388	27	1	42059	1	2	0	0	0	0	0	
49388	28	1	41539	2	2	0	0	0	0	0	
49388	29	1	41540	1	1.4	0	0	0	0	0	
49388	30	1	41541	1	0.2	1	0	0	0	0	
49388	31	1	40372	1	0.1	1	0	0	0	0	
49388	31	1	40184	2	5	0	0	0	0	0	
49388	32	1	41300	1	2	0	0	0	0	0	
49388	33	1	40380	1	6	0	0	0	0	0	
49388	34	1	40362	6	19.12	0	0	0	0	0	
49389	1	1	41196	1	0.6	0	0	0	0	0	
49389	2	1	41197	1	0.5	0	0	0	0	0	
49389	3	1	41305	1	0.4	0	0	0	0	0	
49389	4	1	41192	1	2	0	0	0	0	0	
49389	5	1	41193	1	1	0	0	0	0	0	
49389	6	1	41304	1	0.5	0	0	0	0	0	
49389	7	1	41188	1	2	0	0	0	0	0	
49389	8	1	41189	1	1.5	0	0	0	0	0	
49389	9	1	41303	1	1	0	0	0	0	0	
49389	10	1	42125	1	0.35	1	0	0	0	0	
49389	11	1	42126	1	0.65	0	0	0	0	0	
49389	12	1	41856	1	1	1	0	0	0	0	
49389	13	1	41857	1	1	0	0	0	0	0	
49389	14	1	41860	1	0.8	1	0	0	0	0	
49389	15	1	41861	1	1.2	0	0	0	0	0	
49389	16	1	42117	1	1	1	0	0	0	0	
49389	17	1	42118	1	1	0	0	0	0	0	
49389	18	1	42121	1	0.8	1	0	0	0	0	
49389	19	1	42122	1	1.2	0	0	0	0	0	
49389	20	1	42133	1	0.9	1	0	0	0	0	
49389	21	1	42134	1	1.1	0	0	0	0	0	
49389	22	1	42137	1	0.9	1	0	0	0	0	
49389	23	1	42138	1	1.1	0	0	0	0	0	
49389	24	1	41300	1	1	0	0	0	0	0	
49389	25	1	40022	2	2	0	0	0	0	0	
49389	26	1	40021	3	3	0	0	0	0	0	
49389	27	1	41092	1	2.5	0	0	0	0	0	
49389	28	1	41091	1	2.5	0	0	0	0	0	
49389	29	1	40572	1	16.5	0	0	0	0	0	
49389	30	1	49290	1	4	0	0	0	0	0	
49389	31	1	41493	1	2	0	0	0	0	0	
49389	32	1	40183	22	10	0	0	0	0	0	
49389	33	1	41090	45	10	0	0	0	0	0	
49389	34	1	40191	11	4	0	0	0	0	0	
49389	35	1	40192	11	4	0	0	0	0	0	
49389	36	1	40193	11	4	0	0	0	0	0	
49389	37	1	40202	7	4	0	0	0	0	0	
49389	38	1	40190	5	4	0	0	0	0	0	
49389	39	1	41093	3	4	0	0	0	0	0	
49390	1	1	41196	1	0.6	0	0	0	0	0	
49390	2	1	41197	1	0.5	0	0	0	0	0	
49390	3	1	41305	1	0.4	0	0	0	0	0	
49390	4	1	41192	1	2	0	0	0	0	0	
49390	5	1	41193	1	1	0	0	0	0	0	
49390	6	1	41304	1	0.5	0	0	0	0	0	
49390	7	1	41188	1	2	0	0	0	0	0	
49390	8	1	41189	1	1.5	0	0	0	0	0	
49390	9	1	41303	1	1	0	0	0	0	0	
49390	10	1	41344	1	0.5	1	0	0	0	0	
49390	11	1	41345	1	1.5	0	0	0	0	0	
49390	12	1	42145	1	1.5	1	0	0	0	0	
49390	13	1	42146	1	1.5	0	0	0	0	0	
49390	14	1	42141	1	1	1	0	0	0	0	
49390	15	1	42142	1	2	0	0	0	0	0	
49390	16	1	40831	1	0.35	1	0	0	0	0	
49390	17	1	40670	1	1.65	0	0	0	0	0	
49390	18	1	37084	1	0.65	1	0	0	0	0	
49390	19	1	37085	1	0.35	0	0	0	0	0	
49390	20	1	41300	1	1	0	0	0	0	0	
49390	21	1	40022	2	2	0	0	0	0	0	
49390	22	1	40021	3	3	0	0	0	0	0	
49390	23	1	40380	1	2.5	0	0	0	0	0	
49390	24	1	40115	1	2.5	0	0	0	0	0	
49390	25	1	40572	1	16.5	0	0	0	0	0	
49390	26	1	41089	1	4	0	0	0	0	0	
49390	27	1	41493	1	2	0	0	0	0	0	
49390	28	1	40183	22	11	0	0	0	0	0	
49390	29	1	41088	45	11	0	0	0	0	0	
49390	30	1	40191	11	4	0	0	0	0	0	
49390	31	1	40192	11	4	0	0	0	0	0	
49390	32	1	40193	11	4	0	0	0	0	0	
49390	33	1	40202	7	4	0	0	0	0	0	
49390	34	1	40190	5	4	0	0	0	0	0	
49390	35	1	41093	3	4	0	0	0	0	0	
49391	1	1	41221	1	0.1	1	0	0	0	0	
49391	2	1	41265	1	0.3	1	0	0	0	0	
49391	3	1	41348	1	0.4	1	0	0	0	0	
49391	4	1	40512	1	0.2	1	0	0	0	0	
49391	5	1	40511	1	0.6	1	0	0	0	0	
49391	6	1	40760	1	0.6	1	0	0	0	0	
49391	7	1	40605	1	0.3	1	0	0	0	0	
49391	8	1	40604	1	0.7	1	0	0	0	0	
49391	9	1	41222	1	1	0	0	0	0	0	
49391	10	1	41266	1	1.5	0	0	0	0	0	
49391	11	1	41349	1	1.5	0	0	0	0	0	
49391	12	1	40761	1	1.8	0	0	0	0	0	
49391	13	1	40607	1	1.8	0	0	0	0	0	
49391	14	1	40606	1	1.8	0	0	0	0	0	
49391	16	1	40362	3	46.4	0	0	0	0	0	
49391	17	1	40033	160	3	0	0	0	0	0	
49391	18	1	40034	120	3.5	0	0	0	0	0	
49391	19	1	40035	95	4	0	0	0	0	0	
49391	20	1	40036	80	4.5	0	0	0	0	0	
49391	21	1	40037	70	5.5	0	0	0	0	0	
49391	22	1	40038	160	3	0	0	0	0	0	
49391	23	1	40039	120	3.5	0	0	0	0	0	
49391	24	1	40104	95	4	0	0	0	0	0	
49391	25	1	40105	80	4.5	0	0	0	0	0	
49391	26	1	40106	70	5.5	0	0	0	0	0	
49392	1	1	41196	1	0.6	0	0	0	0	0	
49392	2	1	41197	1	0.5	0	0	0	0	0	
49392	3	1	41305	1	0.4	0	0	0	0	0	
49392	4	1	41192	1	2	0	0	0	0	0	
49392	5	1	41193	1	1	0	0	0	0	0	
49392	6	1	41304	1	0.5	0	0	0	0	0	
49392	7	1	41188	1	2	0	0	0	0	0	
49392	8	1	41189	1	1.5	0	0	0	0	0	
49392	9	1	41303	1	1	0	0	0	0	0	
49392	10	1	42225	1	0.8	1	0	0	0	0	
49392	11	1	42226	1	1.2	0	0	0	0	0	
49392	12	1	42221	1	0.8	1	0	0	0	0	
49392	13	1	42222	1	1.2	0	0	0	0	0	
49392	14	1	42217	1	0.8	1	0	0	0	0	
49392	15	1	42218	1	1.2	0	0	0	0	0	
49392	16	1	42229	1	0.8	1	0	0	0	0	
49392	17	1	42230	1	1.2	0	0	0	0	0	
49392	18	1	41300	1	1	0	0	0	0	0	
49392	19	1	40022	2	2	0	0	0	0	0	
49392	20	1	40021	3	3	0	0	0	0	0	
49392	21	1	41092	1	2.5	0	0	0	0	0	
49392	22	1	41091	1	2.5	0	0	0	0	0	
49392	23	1	40572	1	17.5	0	0	0	0	0	
49392	24	1	41089	1	4	0	0	0	0	0	
49392	25	1	41493	1	2	0	0	0	0	0	
49392	26	1	40183	22	12	0	0	0	0	0	
49392	27	1	41090	45	12	0	0	0	0	0	
49392	28	1	40191	11	4	0	0	0	0	0	
49392	29	1	40192	11	4	0	0	0	0	0	
49392	30	1	40193	11	4	0	0	0	0	0	
49392	31	1	40202	7	4	0	0	0	0	0	
49392	32	1	40190	5	4	0	0	0	0	0	
49392	33	1	41093	3	4	0	0	0	0	0	
49393	1	1	41536	10	100	0	0	0	0	0	
49394	1	1	41537	5	100	0	0	0	0	0	
49395	1	1	28716	1	100	0	0	0	0	0	
49395	2	2	28717	4	100	0	0	0	0	0	
49395	3	3	28718	4	100	0	0	0	0	0	
49395	4	4	28720	3	100	0	0	0	0	0	
49395	5	5	28721	3	100	0	0	0	0	0	
49395	6	6	28723	1	100	0	0	0	0	0	
49395	7	7	28724	1	100	0	0	0	0	0	
49396	1	1	41301	1	0.08	1	0	0	0	0	
49396	2	1	40687	1	0.1	1	0	0	0	0	
49396	3	1	40370	1	0.5	1	0	0	0	0	
49396	4	1	40369	1	1	0	0	0	0	0	
49396	5	1	40368	1	2	0	0	0	0	0	
49396	6	1	41302	1	0.5	0	0	0	0	0	
49396	7	1	40546	1	1	0	0	0	0	0	
49396	8	1	40545	1	1.5	0	0	0	0	0	
49396	9	1	40544	1	2	0	0	0	0	0	
49396	10	1	40543	1	3	0	0	0	0	0	
49396	11	1	42157	1	0.9	1	0	0	0	0	
49396	12	1	40069	1	1.5	1	0	0	0	0	
49396	13	1	41793	1	2	1	0	0	0	0	
49396	14	1	41910	1	1.5	1	0	0	0	0	
49396	15	1	41914	1	1.5	1	0	0	0	0	
49396	16	1	49200	1	10	0	0	0	0	0	
49396	17	1	40182	2	6	0	0	0	0	0	
49396	18	1	40022	4	4.52	0	0	0	0	0	
49396	19	1	41304	1	3	0	0	0	0	0	
49396	20	1	41193	1	4	0	0	0	0	0	
49396	21	1	41303	1	6	0	0	0	0	0	
49396	22	1	41189	2	8	0	0	0	0	0	
49396	23	1	41539	2	1	0	0	0	0	0	
49396	24	1	41540	1	1.2	0	0	0	0	0	
49396	25	1	41541	1	0.2	1	0	0	0	0	
49396	26	1	41542	6	8	0	0	0	0	0	
49396	27	1	41091	1	5	0	0	0	0	0	
49396	28	1	41092	1	4	0	0	0	0	0	
49396	29	1	48902	1	5	0	0	0	0	0	
49396	30	1	48903	1	8	0	0	0	0	0	
49396	31	1	49262	2	6	0	0	0	0	0	
49396	1	2	40362	6	96.59	0	0	0	0	0	
49396	2	2	40362	25	2.5	0	0	0	0	0	
49396	3	2	40362	75	0.7	0	0	0	0	0	
49396	4	2	49213	2	0.15	1	0	0	0	0	
49396	5	2	49213	3	0.05	1	0	0	0	0	
49396	6	2	49213	5	0.01	1	0	0	0	0	
49397	1	1	41532	1	1.2	1	0	0	0	0	
49397	2	1	41528	1	1.5	1	0	0	0	0	
49397	3	1	41534	1	2	0	0	0	0	0	
49397	4	1	41530	1	2	0	0	0	0	0	
49397	5	1	48979	1	1	1	0	0	0	0	
49397	6	1	48980	1	1.5	1	0	0	0	0	
49397	7	1	48981	1	1.2	1	0	0	0	0	
49397	8	1	40342	1	4	0	0	0	0	0	
49397	9	1	40343	1	4	0	0	0	0	0	
49397	10	1	40380	1	4	0	0	0	0	0	
49397	11	1	40184	2	5	0	0	0	0	0	
49397	12	1	40317	1	2	0	0	0	0	0	
49397	13	1	41493	2	5	0	0	0	0	0	
49397	14	1	40201	2	4	0	0	0	0	0	
49397	15	1	40021	5	5	0	0	0	0	0	
49397	16	1	40020	6	8.1	0	0	0	0	0	
49397	17	1	49256	8	8	0	0	0	0	0	
49397	18	1	41085	4	9	0	0	0	0	0	
49397	19	1	41087	5	9	0	0	0	0	0	
49397	20	1	41086	2	5.5	0	0	0	0	0	
49397	21	1	41082	3	7	0	0	0	0	0	
49397	22	1	40572	2	10	0	0	0	0	0	
49397	1	2	48982	1	96	0	0	0	0	0	
49397	2	2	48983	1	3	0	0	0	0	0	
49397	3	2	48984	1	1	0	0	0	0	0	
49398	1	1	40421	1	100	0	0	0	0	0	
49398	1	2	40422	1	100	0	0	0	0	0	
49399	1	1	40423	1	100	0	0	0	0	0	
49399	1	2	40424	1	100	0	0	0	0	0	
49400	1	1	40425	1	100	0	0	0	0	0	
49400	1	2	40426	1	100	0	0	0	0	0	
49401	1	1	40427	1	100	0	0	0	0	0	
49401	1	2	40428	1	100	0	0	0	0	0	
49402	1	1	40429	1	100	0	0	0	0	0	
49402	1	2	40430	1	100	0	0	0	0	0	
49403	1	1	40431	1	100	0	0	0	0	0	
49403	1	2	40432	1	100	0	0	0	0	0	
49404	1	1	40433	1	100	0	0	0	0	0	
49404	1	2	40434	1	100	0	0	0	0	0	
49405	1	1	40435	1	100	0	0	0	0	0	
49405	1	2	40436	1	100	0	0	0	0	0	
49406	1	1	42208	1	100	0	0	0	0	0	
49406	1	2	40181	1	100	0	0	0	0	0	
49406	1	3	49312	1	100	0	0	0	0	0	
49406	1	4	41336	1	100	0	0	0	0	0	
49406	1	5	40364	1	100	0	0	0	0	0	
49406	1	6	40317	1	100	0	0	0	0	0	
49406	1	7	40370	1	100	0	0	0	0	0	
49407	1	1	42170	1	100	0	0	0	0	0	
49407	1	2	40158	1	100	0	0	0	0	0	
49407	1	3	34429	1	100	0	0	0	0	0	
49407	1	4	42149	1	100	0	0	0	0	0	
49407	1	5	41537	1	100	0	0	0	0	0	
49407	1	6	41300	1	100	0	0	0	0	0	
49407	1	7	40687	1	100	0	0	0	0	0	
49408	1	1	42170	1	100	0	0	0	0	0	
49408	1	2	41246	1	100	0	0	0	0	0	
49408	1	3	40184	1	100	0	0	0	0	0	
49408	1	4	41352	1	100	0	0	0	0	0	
49408	1	5	41540	1	100	0	0	0	0	0	
49408	1	6	40189	1	100	0	0	0	0	0	
49408	1	7	41301	1	100	0	0	0	0	0	
49410	1	1	41265	1	0.25	1	0	0	0	0	
49410	2	1	41266	1	1.5	0	0	0	0	0	
49410	3	1	42247	1	0.7	1	0	0	0	0	
49410	4	1	42248	1	2	0	0	0	0	0	
49410	5	1	42251	1	0.7	1	0	0	0	0	
49410	6	1	42252	1	2	0	0	0	0	0	
49410	7	1	41300	1	1	0	0	0	0	0	
49410	8	1	40184	1	2	0	0	0	0	0	
49410	9	1	40022	2	3	0	0	0	0	0	
49410	10	1	41542	1	4	0	0	0	0	0	
49410	11	1	41088	45	5	0	0	0	0	0	
49410	12	1	41089	1	3	0	0	0	0	0	
49410	13	1	40183	22	7	0	0	0	0	0	
49410	14	1	40572	1	12	0	0	0	0	0	
49410	15	1	40509	3	13.85	0	0	0	0	0	
49410	16	1	40040	12	8	0	0	0	0	0	
49410	17	1	40042	5	8	0	0	0	0	0	
49410	18	1	40202	7	5	0	0	0	0	0	
49410	19	1	40190	5	5	0	0	0	0	0	
49410	20	1	41093	3	4	0	0	0	0	0	
49410	21	1	40191	11	4	0	0	0	0	0	
49410	22	1	40192	11	4	0	0	0	0	0	
49410	23	1	40193	11	4	0	0	0	0	0	
49411	1	1	42263	1	0.25	1	0	0	0	0	
49411	2	1	42264	1	1.5	0	0	0	0	0	
49411	3	1	41360	1	0.7	1	0	0	0	0	
49411	4	1	41361	1	2	0	0	0	0	0	
49411	5	1	41364	1	0.6	1	0	0	0	0	
49411	6	1	41365	1	2	0	0	0	0	0	
49411	7	1	41092	1	2.5	0	0	0	0	0	
49411	8	1	41091	1	2.5	0	0	0	0	0	
49411	9	1	40022	2	3	0	0	0	0	0	
49411	10	1	49290	1	4	0	0	0	0	0	
49411	11	1	40200	4	5	0	0	0	0	0	
49411	12	1	41493	1	2	0	0	0	0	0	
49411	13	1	40183	22	7	0	0	0	0	0	
49411	14	1	40572	1	13	0	0	0	0	0	
49411	15	1	40509	3	14.95	0	0	0	0	0	
49411	16	1	40040	12	8	0	0	0	0	0	
49411	17	1	40042	5	8	0	0	0	0	0	
49411	18	1	41082	1	3	0	0	0	0	0	
49411	19	1	41083	1	2	0	0	0	0	0	
49411	20	1	41085	3	6	0	0	0	0	0	
49411	21	1	41086	1	6	0	0	0	0	0	
49411	22	1	41087	3	6	0	0	0	0	0	
49412	1	1	42285	1	100	0	0	0	0	0	
49412	2	2	42286	1	100	0	0	0	0	0	
49412	3	3	42287	1	100	0	0	0	0	0	
49413	1	1	42289	1	100	0	0	0	0	0	
49413	2	2	42290	1	100	0	0	0	0	0	
49413	3	3	40299	2	100	0	0	0	0	0	
49414	1	1	42271	1	0.2	1	0	0	0	0	
49414	2	1	42272	1	1	0	0	0	0	0	
49414	3	1	41965	1	0.6	1	0	0	0	0	
49414	4	1	41966	1	2	0	0	0	0	0	
49414	5	1	41922	1	0.4	1	0	0	0	0	
49414	6	1	41923	1	2	0	0	0	0	0	
49414	7	1	40022	4	5	0	0	0	0	0	
49414	8	1	41189	1	6	0	0	0	0	0	
49414	9	1	41303	1	5	0	0	0	0	0	
49414	10	1	41193	1	3	0	0	0	0	0	
49414	11	1	41304	1	2	0	0	0	0	0	
49414	12	1	41197	1	0.5	0	0	0	0	0	
49414	13	1	41305	1	0.4	0	0	0	0	0	
49414	14	1	40184	2	5	0	0	0	0	0	
49414	15	1	41300	1	4	0	0	0	0	0	
49414	16	1	40368	1	2	0	0	0	0	0	
49414	17	1	40369	1	1	0	0	0	0	0	
49414	18	1	40370	1	0.5	0	0	0	0	0	
49414	19	1	40687	1	0.1	1	0	0	0	0	
49414	20	1	41301	1	0.05	1	0	0	0	0	
49414	21	1	40543	1	3	0	0	0	0	0	
49414	22	1	40544	1	2	0	0	0	0	0	
49414	23	1	40545	1	1.5	0	0	0	0	0	
49414	24	1	40546	1	1	0	0	0	0	0	
49414	25	1	41302	1	0.5	0	0	0	0	0	
49414	26	1	41090	45	12	0	0	0	0	0	
49414	27	1	40200	10	10	0	0	0	0	0	
49414	28	1	40201	2	10	0	0	0	0	0	
49414	29	1	40362	6	19.25	0	0	0	0	0	
49415	1	1	42295	1	0.4	1	0	0	0	0	
49415	2	1	42296	1	1.5	0	0	0	0	0	
49415	3	1	42303	1	0.5	1	0	0	0	0	
49415	4	1	42304	1	2	0	0	0	0	0	
49415	5	1	42311	1	0.6	1	0	0	0	0	
49415	6	1	42312	1	2	0	0	0	0	0	
49415	7	1	41300	1	1	0	0	0	0	0	
49415	8	1	40022	2	2	0	0	0	0	0	
49415	9	1	40021	3	3	0	0	0	0	0	
49415	10	1	40572	1	14	0	0	0	0	0	
49415	11	1	41089	1	4	0	0	0	0	0	
49415	12	1	41542	1	4	0	0	0	0	0	
49415	13	1	41088	45	5	0	0	0	0	0	
49415	14	1	40183	22	12	0	0	0	0	0	
49415	15	1	41090	45	12	0	0	0	0	0	
49415	16	1	40509	3	12	0	0	0	0	0	
49415	17	1	40191	11	4	0	0	0	0	0	
49415	18	1	40192	11	4	0	0	0	0	0	
49415	19	1	40193	11	4	0	0	0	0	0	
49415	20	1	40202	7	4	0	0	0	0	0	
49415	21	1	40190	5	4	0	0	0	0	0	
49415	22	1	41093	3	4	0	0	0	0	0	
49416	1	1	42291	1	0.4	1	0	0	0	0	
49416	2	1	42292	1	1.5	0	0	0	0	0	
49416	3	1	42299	1	0.5	1	0	0	0	0	
49416	4	1	42300	1	2	0	0	0	0	0	
49416	5	1	42307	1	0.6	1	0	0	0	0	
49416	6	1	42308	1	2	0	0	0	0	0	
49416	7	1	40184	2	5	0	0	0	0	0	
49416	8	1	41300	1	1	0	0	0	0	0	
49416	9	1	40022	2	2	0	0	0	0	0	
49416	10	1	40021	3	3	0	0	0	0	0	
49416	11	1	40183	22	12	0	0	0	0	0	
49416	12	1	41090	45	12	0	0	0	0	0	
49416	13	1	40572	1	17.1	0	0	0	0	0	
49416	14	1	41089	1	4	0	0	0	0	0	
49416	15	1	41542	1	4	0	0	0	0	0	
49416	16	1	41197	1	0.5	0	0	0	0	0	
49416	17	1	41305	1	0.4	0	0	0	0	0	
49416	18	1	41193	1	1	0	0	0	0	0	
49416	19	1	41304	1	0.5	0	0	0	0	0	
49416	20	1	41189	1	1.5	0	0	0	0	0	
49416	21	1	41303	1	1	0	0	0	0	0	
49416	22	1	40035	95	4	0	0	0	0	0	
49416	23	1	40036	80	4.5	0	0	0	0	0	
49416	24	1	40037	70	5.5	0	0	0	0	0	
49416	25	1	40104	95	4	0	0	0	0	0	
49416	26	1	40105	80	4.5	0	0	0	0	0	
49416	27	1	40106	70	5.5	0	0	0	0	0	
49417	1	1	42276	1	0.4	1	0	0	0	0	
49417	2	1	42277	1	2	0	0	0	0	0	
49417	3	1	42280	1	0.5	1	0	0	0	0	
49417	4	1	42281	1	2	0	0	0	0	0	
49417	5	1	40131	1	0.4	1	0	0	0	0	
49417	6	1	40279	1	2	0	0	0	0	0	
49417	7	1	40145	1	0.5	1	0	0	0	0	
49417	8	1	40285	1	2	0	0	0	0	0	
49417	9	1	40184	2	5	0	0	0	0	0	
49417	10	1	41300	1	1	0	0	0	0	0	
49417	11	1	40022	2	2	0	0	0	0	0	
49417	12	1	40021	3	3	0	0	0	0	0	
49417	13	1	40183	22	12	0	0	0	0	0	
49417	14	1	41493	1	2	0	0	0	0	0	
49417	15	1	49290	1	4	0	0	0	0	0	
49417	16	1	40509	3	15.2	0	0	0	0	0	
49417	17	1	40040	12	9	0	0	0	0	0	
49417	18	1	40042	5	9	0	0	0	0	0	
49417	19	1	41082	1	4	0	0	0	0	0	
49417	20	1	41083	1	3	0	0	0	0	0	
49417	21	1	41085	3	7	0	0	0	0	0	
49417	22	1	41086	1	7	0	0	0	0	0	
49417	23	1	41087	3	7	0	0	0	0	0	
49432	1	1	36284	1	100	0	0	0	0	0	
49432	2	2	36285	1	100	0	0	0	0	0	
49432	3	3	36286	1	100	0	0	0	0	0	
49432	4	4	36287	1	100	0	0	0	0	0	
49432	5	5	36288	1	100	0	0	0	0	0	
49433	1	1	36289	1	100	0	0	0	0	0	
49433	2	2	36290	1	100	0	0	0	0	0	
49433	3	3	36291	1	100	0	0	0	0	0	
49433	4	4	36292	1	100	0	0	0	0	0	
49433	5	5	36293	1	100	0	0	0	0	0	
49434	1	1	36294	1	100	0	0	0	0	0	
49434	2	2	36295	1	100	0	0	0	0	0	
49434	3	3	36296	1	100	0	0	0	0	0	
49434	4	4	36297	1	100	0	0	0	0	0	
49434	5	5	36298	1	100	0	0	0	0	0	
49435	1	1	36299	1	100	0	0	0	0	0	
49435	2	2	36300	1	100	0	0	0	0	0	
49435	3	3	36301	1	100	0	0	0	0	0	
49435	4	4	36302	1	100	0	0	0	0	0	
49435	5	5	36303	1	100	0	0	0	0	0	
49436	1	1	40451	2	100	0	0	0	0	0	
49436	2	2	40450	2	100	0	0	0	0	0	
49436	3	3	41266	1	100	0	0	0	0	0	
49436	4	4	40170	1	100	0	0	0	0	0	
49436	5	5	40250	1	100	0	0	0	0	0	
49436	6	6	40256	1	100	0	0	0	0	0	
49437	1	1	41266	1	100	0	0	0	0	0	
49437	2	2	41156	1	100	0	0	0	0	0	
49437	3	3	40440	1	100	0	0	0	0	0	
49437	4	4	40299	40	100	0	0	0	0	0	
49437	5	5	48906	3	100	0	0	0	0	0	
49456	1	1	42647	1	100	0	0	0	0	0	
49456	2	2	40170	1	100	0	0	0	0	0	
49456	3	3	40250	1	100	0	0	0	0	0	
49456	4	4	40256	1	100	0	0	0	0	0	
49456	5	5	40451	2	100	0	0	0	0	0	
49456	6	6	40450	2	100	0	0	0	0	0	
49456	7	7	41088	5	100	0	0	0	0	0	
49456	8	8	48998	1	100	0	0	0	0	0	
49477	1	1	28960	1	3	1	0	0	0	0	
49477	2	1	28961	1	7	0	0	0	0	0	
49477	3	1	48907	5	10	0	0	0	0	0	
49477	4	1	36362	5	5	0	0	0	0	0	
49477	5	1	36363	5	5	0	0	0	0	0	
49477	6	1	30007	5	5	0	0	0	0	0	
49477	7	1	30012	5	5	0	0	0	0	0	
49477	8	1	31303	10	7	0	0	0	0	0	
49477	9	1	31304	10	7	0	0	0	0	0	
49477	10	1	31777	15	11.8	0	0	0	0	0	
49477	11	1	31778	15	9.8	0	0	0	0	0	
49477	12	1	31300	5	10	0	0	0	0	0	
49477	13	1	31301	5	10	0	0	0	0	0	
49477	14	1	29815	10	1.4	0	0	0	0	0	
49477	15	1	29815	3	3	0	0	0	0	0	
49477	1	2	28955	1	100	0	0	0	0	0	
49478	1	1	28958	1	2.5	1	0	0	0	0	
49478	2	1	28959	1	5	0	0	0	0	0	
49478	3	1	48907	5	10	0	0	0	0	0	
49478	4	1	36362	5	5	0	0	0	0	0	
49478	5	1	36363	5	5	0	0	0	0	0	
49478	6	1	30007	5	5	0	0	0	0	0	
49478	7	1	30012	5	5	0	0	0	0	0	
49478	8	1	31303	10	7	0	0	0	0	0	
49478	9	1	31304	10	7	0	0	0	0	0	
49478	10	1	31777	15	13.1	0	0	0	0	0	
49478	11	1	31778	15	12	0	0	0	0	0	
49478	12	1	31300	5	9	0	0	0	0	0	
49478	13	1	31301	5	10	0	0	0	0	0	
49478	14	1	29815	10	1.4	0	0	0	0	0	
49478	15	1	29815	3	3	0	0	0	0	0	
49478	1	2	28956	1	100	0	0	0	0	0	
49479	1	1	28962	1	1.8	1	0	0	0	0	
49479	2	1	28963	1	4	0	0	0	0	0	
49479	3	1	48907	5	10	0	0	0	0	0	
49479	4	1	36362	5	5	0	0	0	0	0	
49479	5	1	36363	5	5	0	0	0	0	0	
49479	6	1	30007	5	5	0	0	0	0	0	
49479	7	1	30012	5	5	0	0	0	0	0	
49479	8	1	31303	10	7	0	0	0	0	0	
49479	9	1	31304	10	7	0	0	0	0	0	
49479	10	1	31777	15	13	0	0	0	0	0	
49479	11	1	31778	15	13	0	0	0	0	0	
49479	12	1	31300	5	9	0	0	0	0	0	
49479	13	1	31301	5	11	0	0	0	0	0	
49479	14	1	29815	10	1.2	0	0	0	0	0	
49479	15	1	29815	3	3	0	0	0	0	0	
49479	1	2	28957	1	100	0	0	0	0	0	
49511	1	1	25015	1	100	0	0	0	0	0	
49511	2	2	25016	1	100	0	0	0	0	0	
49511	3	3	25017	1	100	0	0	0	0	0	
49511	4	4	25018	1	100	0	0	0	0	0	
49511	5	5	25019	1	100	0	0	0	0	0	
49512	1	1	25020	1	100	0	0	0	0	0	
49512	2	2	25021	1	100	0	0	0	0	0	
49512	3	3	25022	1	100	0	0	0	0	0	
49512	4	4	25023	1	100	0	0	0	0	0	
49512	5	5	25024	1	100	0	0	0	0	0	
49513	1	1	25025	1	100	0	0	0	0	0	
49513	2	2	25026	1	100	0	0	0	0	0	
49513	3	3	25027	1	100	0	0	0	0	0	
49513	4	4	25028	1	100	0	0	0	0	0	
49513	5	5	25029	1	100	0	0	0	0	0	
49514	1	1	25030	1	100	0	0	0	0	0	
49514	2	2	25031	1	100	0	0	0	0	0	
49514	3	3	25032	1	100	0	0	0	0	0	
49514	4	4	25033	1	100	0	0	0	0	0	
49514	5	5	25034	1	100	0	0	0	0	0	
49515	1	1	25035	1	100	0	0	0	0	0	
49515	2	2	25036	1	100	0	0	0	0	0	
49515	3	3	25037	1	100	0	0	0	0	0	
49515	4	4	25038	1	100	0	0	0	0	0	
49515	5	5	25039	1	100	0	0	0	0	0	
49516	1	1	25040	1	100	0	0	0	0	0	
49516	2	2	25041	1	100	0	0	0	0	0	
49516	3	3	25042	1	100	0	0	0	0	0	
49516	4	4	25043	1	100	0	0	0	0	0	
49516	5	5	25044	1	100	0	0	0	0	0	
49517	1	1	25045	1	100	0	0	0	0	0	
49517	2	2	25046	1	100	0	0	0	0	0	
49517	3	3	25047	1	100	0	0	0	0	0	
49517	4	4	25048	1	100	0	0	0	0	0	
49517	5	5	25049	1	100	0	0	0	0	0	
49518	1	1	25050	1	100	0	0	0	0	0	
49518	2	2	25051	1	100	0	0	0	0	0	
49518	3	3	25052	1	100	0	0	0	0	0	
49518	4	4	25053	1	100	0	0	0	0	0	
49518	5	5	25054	1	100	0	0	0	0	0	
49519	1	1	42952	1	0.02	1	0	0	0	0	
49519	2	1	42953	1	0.2	0	0	0	0	0	
49519	3	1	42928	1	0.07	1	0	0	0	0	
49519	4	1	42929	1	0.5	0	0	0	0	0	
49519	5	1	41300	1	1	0	0	0	0	0	
49519	6	1	40184	2	6	0	0	0	0	0	
49519	7	1	40021	3	4	0	0	0	0	0	
49519	8	1	41297	60	21	0	0	0	0	0	
49519	9	1	41298	60	20.61	0	0	0	0	0	
49519	10	1	40200	4	5	0	0	0	0	0	
49519	11	1	40201	1	4	0	0	0	0	0	
49519	12	1	40156	4	23	0	0	0	0	0	
49519	13	1	40181	3	5	0	0	0	0	0	
49519	14	1	40122	10	5	0	0	0	0	0	
49519	15	1	40380	1	2.6	0	0	0	0	0	
49519	16	1	40115	1	2	0	0	0	0	0	
49520	1	1	42974	1	5	0	0	0	0	0	
49520	2	1	42975	1	5	0	0	0	0	0	
49520	3	1	42976	1	5	0	0	0	0	0	
49520	4	1	42977	1	5	0	0	0	0	0	
49520	5	1	40638	1	20	0	0	0	0	0	
49520	6	1	40639	1	20	0	0	0	0	0	
49520	7	1	40640	1	20	0	0	0	0	0	
49520	8	1	40641	1	20	0	0	0	0	0	
49520	9	2	41082	1	25	0	0	0	0	0	
49520	10	2	41083	1	25	0	0	0	0	0	
49520	11	2	41085	1	25	0	0	0	0	0	
49520	12	2	41087	1	25	0	0	0	0	0	
49520	13	3	41090	5	100	0	0	0	0	0	
49520	14	4	40040	10	100	0	0	0	0	0	
49520	15	5	40042	10	100	0	0	0	0	0	
49521	1	1	42978	1	2.5	0	0	0	0	0	
49521	2	1	42979	1	2.5	0	0	0	0	0	
49521	3	1	42980	1	2.5	0	0	0	0	0	
49521	4	1	42981	1	2.5	0	0	0	0	0	
49521	5	1	42982	1	2.5	0	0	0	0	0	
49521	6	1	42983	1	2.5	0	0	0	0	0	
49521	7	1	42984	1	2.5	0	0	0	0	0	
49521	8	1	42985	1	2.5	0	0	0	0	0	
49521	9	1	40642	1	10	0	0	0	0	0	
49521	10	1	40643	1	10	0	0	0	0	0	
49521	11	1	40644	1	10	0	0	0	0	0	
49521	12	1	40645	1	10	0	0	0	0	0	
49521	13	1	40646	1	10	0	0	0	0	0	
49521	14	1	40647	1	10	0	0	0	0	0	
49521	15	1	40648	1	10	0	0	0	0	0	
49521	16	1	40649	1	10	0	0	0	0	0	
49521	17	2	41082	1	25	0	0	0	0	0	
49521	18	2	41083	1	25	0	0	0	0	0	
49521	19	2	41085	1	25	0	0	0	0	0	
49521	20	2	41087	1	25	0	0	0	0	0	
49521	21	3	41090	5	100	0	0	0	0	0	
49521	22	4	40040	10	100	0	0	0	0	0	
49521	23	5	40042	10	100	0	0	0	0	0	
49522	1	1	42986	1	5	0	0	0	0	0	
49522	2	1	42987	1	5	0	0	0	0	0	
49522	3	1	42988	1	5	0	0	0	0	0	
49522	4	1	42989	1	5	0	0	0	0	0	
49522	5	1	40650	1	20	0	0	0	0	0	
49522	6	1	40651	1	20	0	0	0	0	0	
49522	7	1	40652	1	20	0	0	0	0	0	
49522	8	1	40653	1	20	0	0	0	0	0	
49522	9	2	41082	1	25	0	0	0	0	0	
49522	10	2	41083	1	25	0	0	0	0	0	
49522	11	2	41085	1	25	0	0	0	0	0	
49522	12	2	41087	1	25	0	0	0	0	0	
49522	13	3	41090	5	100	0	0	0	0	0	
49522	14	4	40040	10	100	0	0	0	0	0	
49522	15	5	40042	10	100	0	0	0	0	0	
49523	1	1	42920	1	0.8	1	0	0	0	0	
49523	2	1	42921	1	1.5	0	0	0	0	0	
49523	3	1	42924	1	0.5	1	0	0	0	0	
49523	4	1	42925	1	1	0	0	0	0	0	
49523	5	1	41193	1	1	0	0	0	0	0	
49523	6	1	41304	1	0.5	0	0	0	0	0	
49523	7	1	41189	1	1.5	0	0	0	0	0	
49523	8	1	41303	1	1	0	0	0	0	0	
49523	9	1	40021	3	3	0	0	0	0	0	
49523	10	1	40122	10	5	0	0	0	0	0	
49523	11	1	40183	22	12	0	0	0	0	0	
49523	12	1	41297	60	27.4	0	0	0	0	0	
49523	13	1	41298	60	27.5	0	0	0	0	0	
49523	14	1	40572	1	17.3	0	0	0	0	0	
49549	1	1	40297	5	100	0	0	0	0	0	
49549	1	2	40298	5	100	0	0	0	0	0	
49549	1	3	25428	1	100	0	0	0	0	0	
49537	1	1	48989	50	100	0	0	0	0	0	
49538	1	1	48992	50	100	0	0	0	0	0	
49539	1	1	43115	1	0.8	1	0	0	0	0	
49539	2	1	43116	1	1.2	0	0	0	0	0	
49539	3	1	43119	1	0.7	1	0	0	0	0	
49539	4	1	43120	1	1	0	0	0	0	0	
49539	5	1	41193	1	1	0	0	0	0	0	
49539	6	1	41304	1	0.5	0	0	0	0	0	
49539	7	1	41189	1	1.5	0	0	0	0	0	
49539	8	1	41303	1	1	0	0	0	0	0	
49539	9	1	40021	3	3	0	0	0	0	0	
49539	10	1	40122	10	5	0	0	0	0	0	
49539	11	1	40183	22	12	0	0	0	0	0	
49539	12	1	41297	60	26.6	0	0	0	0	0	
49539	13	1	41298	60	28.4	0	0	0	0	0	
49539	14	1	40572	1	17.3	0	0	0	0	0	
49540	1	1	43049	1	0.9	1	0	0	0	0	
49540	2	1	43050	1	1.6	0	0	0	0	0	
49540	3	1	43053	1	0.9	1	0	0	0	0	
49540	4	1	43054	1	1.6	0	0	0	0	0	
49540	5	1	43057	1	0.7	1	0	0	0	0	
49540	6	1	43058	1	1.5	0	0	0	0	0	
49540	7	1	43061	1	0.7	1	0	0	0	0	
49540	8	1	43062	1	1.5	0	0	0	0	0	
49540	9	1	41300	1	1	0	0	0	0	0	
49540	10	1	40184	2	6	0	0	0	0	0	
49540	11	1	40021	3	4	0	0	0	0	0	
49540	12	1	41297	60	18	0	0	0	0	0	
49540	13	1	41298	60	18	0	0	0	0	0	
49540	14	1	40200	4	5	0	0	0	0	0	
49540	15	1	40201	1	4	0	0	0	0	0	
49540	16	1	40156	4	21	0	0	0	0	0	
49540	17	1	40181	3	5	0	0	0	0	0	
49540	18	1	40122	10	4.5	0	0	0	0	0	
49540	19	1	40380	1	2.1	0	0	0	0	0	
49540	20	1	40115	1	2	0	0	0	0	0	
49544	1	1	43131	1	0.8	1	0	0	0	0	
49544	2	1	43132	1	1.4	0	0	0	0	0	
49544	3	1	43127	1	0.5	1	0	0	0	0	
49544	4	1	43128	1	1	0	0	0	0	0	
49544	5	1	41193	1	1	0	0	0	0	0	
49544	6	1	41304	1	0.5	0	0	0	0	0	
49544	7	1	41189	1	1.5	0	0	0	0	0	
49544	8	1	41303	1	1	0	0	0	0	0	
49544	9	1	40021	3	3	0	0	0	0	0	
49544	10	1	40122	10	5	0	0	0	0	0	
49544	11	1	40183	22	12	0	0	0	0	0	
49544	12	1	41297	60	26.6	0	0	0	0	0	
49544	13	1	41298	60	28.4	0	0	0	0	0	
49544	14	1	40572	1	17.3	0	0	0	0	0	
49545	1	1	43211	1	0.5	1	0	0	0	0	
49545	2	1	43212	1	1	0	0	0	0	0	
49545	3	1	42263	1	0.8	1	0	0	0	0	
49545	4	1	42264	1	1.5	0	0	0	0	0	
49545	5	1	41300	1	1	0	0	0	0	0	
49545	6	1	40184	2	6.2	0	0	0	0	0	
49545	7	1	40021	3	4	0	0	0	0	0	
49545	8	1	41297	60	19	0	0	0	0	0	
49545	9	1	41298	60	19	0	0	0	0	0	
49545	10	1	40200	4	5	0	0	0	0	0	
49545	11	1	40201	1	4	0	0	0	0	0	
49545	12	1	40156	4	23	0	0	0	0	0	
49545	13	1	40181	3	5	0	0	0	0	0	
49545	14	1	40122	10	5	0	0	0	0	0	
49545	15	1	40380	1	3	0	0	0	0	0	
49545	16	1	40115	1	2	0	0	0	0	0	
49547	1	1	43069	1	0.5	1	0	0	0	0	
49547	2	1	43070	1	1.5	0	0	0	0	0	
49547	3	1	43185	1	0.3	1	0	0	0	0	
49547	4	1	43186	1	0.9	0	0	0	0	0	
49547	5	1	40317	1	2	0	0	0	0	0	
49547	6	1	40367	1	2	0	0	0	0	0	
49547	7	1	40022	2	2	0	0	0	0	0	
49547	8	1	40200	4	5	0	0	0	0	0	
49547	9	1	40201	1	5	0	0	0	0	0	
49547	10	1	41089	1	5	0	0	0	0	0	
49547	11	1	40040	12	21.4	0	0	0	0	0	
49547	12	1	40042	5	21.4	0	0	0	0	0	
49547	13	1	41090	45	15	0	0	0	0	0	
49547	14	1	40509	3	18	0	0	0	0	0	
49546	1	1	42899	1	10	0	0	0	0	0	
49546	2	1	42899	3	10	0	0	0	0	0	
49546	3	1	42899	5	13	1	0	0	0	0	
49546	4	1	42903	1	8	0	0	0	0	0	
49546	5	1	42903	3	10	0	0	0	0	0	
49546	6	1	42903	5	2.5	1	0	0	0	0	
49546	7	1	42905	5	5	0	0	0	0	0	
49546	8	1	42905	3	8	0	0	0	0	0	
49546	9	1	42905	5	1	1	0	0	0	0	
49546	10	1	42900	1	1	0	0	0	0	0	
49546	11	1	42900	3	8	0	0	0	0	0	
49546	12	1	42900	5	5	1	0	0	0	0	
49546	13	1	42904	1	7	0	0	0	0	0	
49546	14	1	42904	3	6	0	0	0	0	0	
49546	15	1	42904	5	2	1	0	0	0	0	
49546	16	1	42906	1	2	0	0	0	0	0	
49546	17	1	42906	3	1	0	0	0	0	0	
49546	18	1	42906	5	0.5	1	0	0	0	0	
49548	1	1	40311	1	100	0	0	0	0	0	
49548	1	2	41088	20	100	0	0	0	0	0	
49548	1	3	41090	27	100	0	0	0	0	0	
49549	1	1	40297	5	100	0	0	0	0	0	
49549	1	2	40298	5	100	0	0	0	0	0	
49549	1	3	25428	1	100	0	0	0	0	0	
49550	1	1	43173	1	0.4	1	0	0	0	0	
49550	2	1	43174	1	1.3	0	0	0	0	0	
49550	3	1	43177	1	0.4	1	0	0	0	0	
49550	4	1	43178	1	1.3	0	0	0	0	0	
49550	5	1	41926	1	0.5	1	0	0	0	0	
49550	6	1	41927	1	1.3	0	0	0	0	0	
49550	7	1	42391	1	0.3	1	0	0	0	0	
49550	8	1	42392	1	1.2	0	0	0	0	0	
49550	9	1	41193	1	1	0	0	0	0	0	
49550	10	1	41304	1	0.5	0	0	0	0	0	
49550	11	1	41189	1	1.5	0	0	0	0	0	
49550	12	1	41303	1	1	0	0	0	0	0	
49550	13	1	40021	3	3	0	0	0	0	0	
49550	14	1	40122	10	5	0	0	0	0	0	
49550	15	1	40183	22	12	0	0	0	0	0	
49550	16	1	41297	60	25.3	0	0	0	0	0	
49550	17	1	41298	60	27	0	0	0	0	0	
49550	18	1	40572	1	17	0	0	0	0	0	
49551	1	1	43193	1	0.5	1	0	0	0	0	
49551	2	1	43194	1	1	0	0	0	0	0	
49551	3	1	42928	1	0.02	1	0	0	0	0	
49551	4	1	42929	1	0.3	0	0	0	0	0	
49551	5	1	40440	1	0.4	1	0	0	0	0	
49551	6	1	40442	1	1	0	0	0	0	0	
49551	7	1	41583	1	0.4	1	0	0	0	0	
49551	8	1	41584	1	1	0	0	0	0	0	
49551	9	1	42007	1	0.4	1	0	0	0	0	
49551	10	1	42008	1	1	0	0	0	0	0	
49551	11	1	41300	1	1	0	0	0	0	0	
49551	12	1	40184	2	6.2	0	0	0	0	0	
49551	13	1	40021	3	4	0	0	0	0	0	
49551	14	1	41297	60	18.28	0	0	0	0	0	
49551	15	1	41298	60	18.5	0	0	0	0	0	
49551	16	1	40200	4	5	0	0	0	0	0	
49551	17	1	40201	1	4	0	0	0	0	0	
49551	18	1	40156	4	22	0	0	0	0	0	
49551	19	1	40181	3	5	0	0	0	0	0	
49551	20	1	40122	10	5	0	0	0	0	0	
49551	21	1	40380	1	3	0	0	0	0	0	
49551	22	1	40115	1	2	0	0	0	0	0	
49745	1	1	40019	5	5	0	0	0	0	0	
49745	2	1	40020	3	5	0	0	0	0	0	
49745	3	1	40021	2	3	0	0	0	0	0	
49745	4	1	40022	1	1	0	0	0	0	0	
49745	5	1	40023	4	4	0	0	0	0	0	
49745	6	1	40024	2	3	0	0	0	0	0	
49745	7	1	40025	4	4	0	0	0	0	0	
49745	8	1	40026	2	3	0	0	0	0	0	
49745	9	1	40027	4	4	0	0	0	0	0	
49745	10	1	40028	2	3	0	0	0	0	0	
49745	11	1	40029	4	4	0	0	0	0	0	
49745	12	1	40030	2	3	0	0	0	0	0	
49745	13	1	40031	4	4	0	0	0	0	0	
49745	14	1	40032	2	3	0	0	0	0	0	
49745	15	1	40209	4	2	0	0	0	0	0	
49745	16	1	40210	2	1	0	0	0	0	0	
49745	17	1	40211	4	2	0	0	0	0	0	
49745	18	1	40212	2	1	0	0	0	0	0	
49745	19	1	40213	4	2	0	0	0	0	0	
49745	20	1	40214	2	1	0	0	0	0	0	
49745	21	1	40215	4	2	0	0	0	0	0	
49745	22	1	40216	2	1	0	0	0	0	0	
49745	23	1	40217	4	2	0	0	0	0	0	
49745	24	1	40218	2	1	0	0	0	0	0	
49745	25	1	40350	1	0.5	0	0	0	0	0	
49745	26	1	40156	3	6	0	0	0	0	0	
49745	27	1	40181	2	6.5	0	0	0	0	0	
49745	28	1	41088	10	10	0	0	0	0	0	
49745	29	1	40122	10	5	0	0	0	0	0	
49745	30	1	40034	80	1	0	0	0	0	0	
49745	31	1	40035	60	1	0	0	0	0	0	
49745	32	1	40036	40	1	0	0	0	0	0	
49745	33	1	40037	30	1	0	0	0	0	0	
49745	34	1	40039	80	1	0	0	0	0	0	
49745	35	1	40104	60	1	0	0	0	0	0	
49745	36	1	40105	40	1	0	0	0	0	0	
49745	37	1	40106	30	1	0	0	0	0	0	
49628	1	1	40122	3	20	0	0	0	0	0	
49628	2	1	40183	1	4.9	0	0	0	0	0	
49628	3	1	40200	1	5	0	0	0	0	0	
49628	4	1	40362	1	0.1	0	0	0	0	0	
49628	5	1	40040	3	20	0	0	0	0	0	
49628	6	1	40042	2	10	0	0	0	0	0	
49628	7	1	41090	3	20	0	0	0	0	0	
49628	8	1	40156	1	20	0	0	0	0	0	
49643	1	1	40362	2	100	0	0	0	0	0	
49623	1	1	43538	20	100	0	0	0	0	0	
49624	1	1	43538	50	100	0	0	0	0	0	
49625	1	1	43538	100	100	0	0	0	0	0	
49679	1	1	43612	1	100	0	0	0	0	0	
49679	2	2	43613	1	100	0	0	0	0	0	
49679	3	3	43614	1	100	0	0	0	0	0	
49679	4	4	43625	1	100	0	0	0	0	0	
49679	5	5	43629	1	100	0	0	0	0	0	
49679	6	6	43667	1	100	0	0	0	0	0	
49679	7	7	43671	1	100	0	0	0	0	0	
49679	8	8	43699	1	100	0	0	0	0	0	
49679	9	9	41208	1	100	0	0	0	0	0	
49679	10	10	43633	50	100	0	0	0	0	0	
49679	11	11	43615	5	100	0	0	0	0	0	
49679	12	12	26228	10	100	0	0	0	0	0	
49680	1	1	43612	1	100	0	0	0	0	0	
49680	2	2	43613	1	100	0	0	0	0	0	
49680	3	3	43614	1	100	0	0	0	0	0	
49680	4	4	43627	1	100	0	0	0	0	0	
49680	5	5	43631	1	100	0	0	0	0	0	
49680	6	6	43669	1	100	0	0	0	0	0	
49680	7	7	43673	1	100	0	0	0	0	0	
49680	8	8	43633	50	100	0	0	0	0	0	
49680	9	9	43615	5	100	0	0	0	0	0	
49680	10	10	26228	10	100	0	0	0	0	0	
49681	1	1	26230	10	100	0	0	0	0	0	
49681	1	2	26231	1	10	0	0	0	0	0	
49681	2	2	26231	2	10	0	0	0	0	0	
49681	3	2	26231	3	10	0	0	0	0	0	
49681	4	2	26231	4	10	0	0	0	0	0	
49681	5	2	26231	5	10	0	0	0	0	0	
49681	6	2	26231	6	10	0	0	0	0	0	
49681	7	2	26231	7	10	0	0	0	0	0	
49681	8	2	26231	8	10	0	0	0	0	0	
49681	9	2	26231	9	10	0	0	0	0	0	
49681	10	2	26231	10	10	0	0	0	0	0	
49458	1	1	42571	1	1.5	1	0	0	0	0	
49458	2	1	42572	1	0.75	0	0	0	0	0	
49458	3	1	41193	1	1	0	0	0	0	0	
49458	4	1	41304	1	0.5	0	0	0	0	0	
49458	5	1	41189	1	1.5	0	0	0	0	0	
49458	6	1	41303	1	1	0	0	0	0	0	
49458	7	1	40021	3	3	0	0	0	0	0	
49458	8	1	40122	10	5	0	0	0	0	0	
49458	9	1	40183	22	12	0	0	0	0	0	
49458	10	1	41297	60	27.75	0	0	0	0	0	
49458	11	1	41298	60	27.5	0	0	0	0	0	
49458	12	1	40572	1	18.5	0	0	0	0	0	
49474	1	1	40991	1	1	1	0	0	0	0	
49474	2	1	40993	1	0.5	0	0	0	0	0	
49474	3	1	40994	1	0.8	1	0	0	0	0	
49474	4	1	40996	1	0.4	0	0	0	0	0	
49474	5	1	41555	1	0.6	1	0	0	0	0	
49474	6	1	41556	1	0.3	0	0	0	0	0	
49474	7	1	41559	1	0.6	1	0	0	0	0	
49474	8	1	41560	1	0.3	0	0	0	0	0	
49474	9	1	41918	1	1	1	0	0	0	0	
49474	10	1	41919	1	0.5	0	0	0	0	0	
49474	11	1	41922	1	1	1	0	0	0	0	
49474	12	1	41923	1	0.5	0	0	0	0	0	
49474	13	1	42057	1	0.8	1	0	0	0	0	
49474	14	1	42058	1	0.4	0	0	0	0	0	
49474	15	1	42049	1	0.8	1	0	0	0	0	
49474	16	1	42050	1	0.4	0	0	0	0	0	
49474	17	1	41785	1	0.8	1	0	0	0	0	
49474	18	1	41786	1	0.4	0	0	0	0	0	
49474	19	1	41789	1	0.7	1	0	0	0	0	
49474	20	1	41790	1	0.35	0	0	0	0	0	
49474	21	1	41197	1	1	0	0	0	0	0	
49474	22	1	41305	1	5.5	0	0	0	0	0	
49474	23	1	40022	2	3.5	0	0	0	0	0	
49474	24	1	41493	1	25	0	0	0	0	0	
49474	25	1	41542	1	25	0	0	0	0	0	
49474	26	1	49290	1	13.25	0	0	0	0	0	
49474	27	1	40157	2	5	0	0	0	0	0	
49474	28	1	40182	2	5	0	0	0	0	0	
49474	29	1	40040	12	2.6	0	0	0	0	0	
49474	30	1	40042	5	2	0	0	0	0	0	
49721	1	1	36308	1	100	0	0	0	0	0	
49721	1	2	26458	1	100	0	0	0	0	0	
49722	1	1	36309	1	100	0	0	0	0	0	
49722	1	2	26458	1	100	0	0	0	0	0	
49723	1	1	36310	1	100	0	0	0	0	0	
49723	1	2	26458	1	100	0	0	0	0	0	
49724	1	1	36311	1	100	0	0	0	0	0	
49724	1	2	26458	1	100	0	0	0	0	0	
49725	1	1	36312	1	100	0	0	0	0	0	
49725	1	2	26458	1	100	0	0	0	0	0	
49726	1	1	36313	1	100	0	0	0	0	0	
49726	1	2	26458	1	100	0	0	0	0	0	
49727	1	1	36314	1	100	0	0	0	0	0	
49727	1	2	26458	1	100	0	0	0	0	0	
49728	1	1	36315	1	100	0	0	0	0	0	
49728	1	2	26458	1	100	0	0	0	0	0	
49729	1	1	36838	1	100	0	0	0	0	0	
49729	1	2	26459	1	100	0	0	0	0	0	
49730	1	1	36839	1	100	0	0	0	0	0	
49730	1	2	26459	1	100	0	0	0	0	0	
49731	1	1	36840	1	100	0	0	0	0	0	
49731	1	2	26459	1	100	0	0	0	0	0	
49732	1	1	36841	1	100	0	0	0	0	0	
49732	1	2	26459	1	100	0	0	0	0	0	
49733	1	1	36842	1	100	0	0	0	0	0	
49733	1	2	26459	1	100	0	0	0	0	0	
49734	1	1	36843	1	100	0	0	0	0	0	
49734	1	2	26459	1	100	0	0	0	0	0	
49735	1	1	36844	1	100	0	0	0	0	0	
49735	1	2	26459	1	100	0	0	0	0	0	
49736	1	1	36845	1	100	0	0	0	0	0	
49736	1	2	26459	1	100	0	0	0	0	0	
49737	1	1	39065	1	100	0	0	0	0	0	
49737	1	2	26460	1	100	0	0	0	0	0	
49738	1	1	39066	1	100	0	0	0	0	0	
49738	1	2	26460	1	100	0	0	0	0	0	
49739	1	1	39067	1	100	0	0	0	0	0	
49739	1	2	26460	1	100	0	0	0	0	0	
49740	1	1	39068	1	100	0	0	0	0	0	
49740	1	2	26460	1	100	0	0	0	0	0	
49741	1	1	39069	1	100	0	0	0	0	0	
49741	1	2	26460	1	100	0	0	0	0	0	
49742	1	1	39070	1	100	0	0	0	0	0	
49742	1	2	26460	1	100	0	0	0	0	0	
49743	1	1	39071	1	100	0	0	0	0	0	
49743	1	2	26460	1	100	0	0	0	0	0	
49744	1	1	39072	1	100	0	0	0	0	0	
49744	1	2	26460	1	100	0	0	0	0	0	
49760	1	1	26500	1	100	0	0	0	0	0	
49760	1	2	26501	1	100	0	0	0	0	0	
49760	1	3	26502	1	100	0	0	0	0	0	
49761	1	1	26504	1	100	0	0	0	0	0	
49761	1	2	26505	1	100	0	0	0	0	0	
49761	1	3	26506	1	100	0	0	0	0	0	
49762	1	1	26508	1	100	0	0	0	0	0	
49762	1	2	26509	1	100	0	0	0	0	0	
49762	1	3	26510	1	100	0	0	0	0	0	
49763	1	1	26512	1	100	0	0	0	0	0	
49763	1	2	26513	1	100	0	0	0	0	0	
49763	1	3	26514	1	100	0	0	0	0	0	
49764	1	1	26516	1	100	0	0	0	0	0	
49764	1	2	26517	1	100	0	0	0	0	0	
49764	1	3	26518	1	100	0	0	0	0	0	
49764	1	4	26519	1	100	0	0	0	0	0	
49765	1	1	26520	1	100	0	0	0	0	0	
49765	1	2	26521	1	100	0	0	0	0	0	
49765	1	3	26522	1	100	0	0	0	0	0	
49765	1	4	26523	1	100	0	0	0	0	0	
49766	1	1	26524	1	100	0	0	0	0	0	
49766	1	2	26525	1	100	0	0	0	0	0	
49766	1	3	26526	1	100	0	0	0	0	0	
49766	1	4	26527	1	100	0	0	0	0	0	
49767	1	1	26528	1	100	0	0	0	0	0	
49767	1	2	26529	1	100	0	0	0	0	0	
49767	1	3	26530	1	100	0	0	0	0	0	
49767	1	4	26531	1	100	0	0	0	0	0	
49768	1	1	26532	1	100	0	0	0	0	0	
49768	1	2	26533	1	100	0	0	0	0	0	
49768	1	3	26534	1	100	0	0	0	0	0	
49768	1	4	26535	1	100	0	0	0	0	0	
49769	1	1	26536	1	100	0	0	0	0	0	
49769	1	2	26537	1	100	0	0	0	0	0	
49769	1	3	26538	1	100	0	0	0	0	0	
49769	1	4	26539	1	100	0	0	0	0	0	
49770	1	1	26540	1	100	0	0	0	0	0	
49770	1	2	26541	1	100	0	0	0	0	0	
49770	1	3	26542	1	100	0	0	0	0	0	
49770	1	4	26543	1	100	0	0	0	0	0	
49771	1	1	26544	1	100	0	0	0	0	0	
49771	1	2	26545	1	100	0	0	0	0	0	
49771	1	3	26546	1	100	0	0	0	0	0	
49771	1	4	26547	1	100	0	0	0	0	0	
49772	1	1	33033	1	100	0	0	0	0	0	
49772	1	2	33036	1	100	0	0	0	0	0	
49772	1	3	31601	20	100	0	0	0	0	0	
49772	1	4	31620	2	100	0	0	0	0	0	
49773	1	1	33034	1	100	0	0	0	0	0	
49773	1	2	33035	1	100	0	0	0	0	0	
49773	1	3	31601	20	100	0	0	0	0	0	
49773	1	4	31620	2	100	0	0	0	0	0	
49774	1	1	33037	1	100	0	0	0	0	0	
49774	1	2	33040	1	100	0	0	0	0	0	
49774	1	3	31601	20	100	0	0	0	0	0	
49774	1	4	31620	2	100	0	0	0	0	0	
49775	1	1	33038	1	100	0	0	0	0	0	
49775	1	2	33040	1	100	0	0	0	0	0	
49775	1	3	31601	20	100	0	0	0	0	0	
49775	1	4	31620	2	100	0	0	0	0	0	
49776	1	1	26549	1	100	0	0	0	0	0	
49776	1	2	26550	1	100	0	0	0	0	0	
49776	1	3	26551	1	100	0	0	0	0	0	
49777	1	1	26552	1	100	0	0	0	0	0	
49777	1	2	26553	1	100	0	0	0	0	0	
49777	1	3	30063	250	100	0	0	0	0	0	
49777	1	4	30710	250	100	0	0	0	0	0	
49778	1	1	26554	1	100	0	0	0	0	0	
49778	1	2	26556	1	100	0	0	0	0	0	
49779	1	1	26555	1	100	0	0	0	0	0	
49779	1	2	26557	1	100	0	0	0	0	0	
49824	1	1	27084	3	100	0	0	0	0	0	
49824	1	2	27119	1	100	0	0	0	0	0	
48709	1	1	49432	1	100	0	0	0	0	0	
48709	1	2	49433	1	100	0	0	0	0	0	
48709	1	3	49434	1	100	0	0	0	0	0	
48709	1	4	49435	1	100	0	0	0	0	0	
48709	1	5	40450	2	100	0	0	0	0	0	
48709	1	6	40451	2	100	0	0	0	0	0	
48709	1	7	48907	5	100	0	0	0	0	0	
48709	1	8	48998	1	100	0	0	0	0	0	
48709	1	9	42647	1	100	0	0	0	0	0	
48709	1	10	48906	1	100	0	0	0	0	0	
48709	1	11	41865	1	100	0	0	0	0	0	
48709	1	12	48679	1	100	0	0	0	0	0	
48709	1	13	48681	1	100	0	0	0	0	0	
48709	1	14	48680	1	100	0	0	0	0	0	
48709	1	15	48682	1	100	0	0	0	0	0	
49884	1	1	20399	1	100	0	0	0	0	0	
49884	2	2	20400	1	100	0	0	0	0	0	
49884	3	3	20401	1	100	0	0	0	0	0	
49884	4	4	20402	1	100	0	0	0	0	0	
49884	5	5	20403	1	100	0	0	0	0	0	
49885	1	1	20404	1	100	0	0	0	0	0	
49885	2	2	20405	1	100	0	0	0	0	0	
49885	3	3	20406	1	100	0	0	0	0	0	
49885	4	4	20407	1	100	0	0	0	0	0	
49885	5	5	20408	1	100	0	0	0	0	0	
49886	1	1	20409	1	100	0	0	0	0	0	
49886	2	2	20410	1	100	0	0	0	0	0	
49886	3	3	20411	1	100	0	0	0	0	0	
49886	4	4	20412	1	100	0	0	0	0	0	
49886	5	5	20413	1	100	0	0	0	0	0	
49887	1	1	20414	1	100	0	0	0	0	0	
49887	2	2	20415	1	100	0	0	0	0	0	
49887	3	3	20416	1	100	0	0	0	0	0	
49887	4	4	20417	1	100	0	0	0	0	0	
49887	5	5	20418	1	100	0	0	0	0	0	
49888	1	1	20419	1	100	0	0	0	0	0	
49888	2	2	20420	1	100	0	0	0	0	0	
49888	3	3	20421	1	100	0	0	0	0	0	
49888	4	4	20422	1	100	0	0	0	0	0	
49888	5	5	20423	1	100	0	0	0	0	0	
49889	1	1	20424	1	100	0	0	0	0	0	
49889	2	2	20425	1	100	0	0	0	0	0	
49889	3	3	20426	1	100	0	0	0	0	0	
49889	4	4	20427	1	100	0	0	0	0	0	
49889	5	5	20428	1	100	0	0	0	0	0	
49890	1	1	20429	1	100	0	0	0	0	0	
49890	2	2	20430	1	100	0	0	0	0	0	
49890	3	3	20431	1	100	0	0	0	0	0	
49890	4	4	20432	1	100	0	0	0	0	0	
49890	5	5	20433	1	100	0	0	0	0	0	
49891	1	1	20434	1	100	0	0	0	0	0	
49891	2	2	20435	1	100	0	0	0	0	0	
49891	3	3	20436	1	100	0	0	0	0	0	
49891	4	4	20437	1	100	0	0	0	0	0	
49891	5	5	20438	1	100	0	0	0	0	0	
48471	1	1	48469	5	100	0	0	0	0	0	
48471	1	2	24620	1	100	0	0	0	0	0	
48471	1	3	24626	2	100	0	0	0	0	0	
48472	1	1	48469	10	100	0	0	0	0	0	
48472	1	2	24626	2	100	0	0	0	0	0	
48473	1	1	48993	5	100	0	0	0	0	0	
48473	1	2	24620	1	100	0	0	0	0	0	
48473	1	3	24626	4	100	0	0	0	0	0	
48474	1	1	48993	10	100	0	0	0	0	0	
48474	1	2	24626	4	100	0	0	0	0	0	
48475	1	1	48994	5	100	0	0	0	0	0	
48475	1	2	24620	2	100	0	0	0	0	0	
48475	1	3	24626	8	100	0	0	0	0	0	
48476	1	1	48994	10	100	0	0	0	0	0	
48476	1	2	24626	8	100	0	0	0	0	0	
48477	1	1	48995	5	100	0	0	0	0	0	
48477	1	2	24620	2	100	0	0	0	0	0	
48477	1	3	24626	12	100	0	0	0	0	0	
48478	1	1	48995	10	100	0	0	0	0	0	
48478	1	2	24626	12	100	0	0	0	0	0	
48479	1	1	48995	15	100	0	0	0	0	0	
48479	1	2	24620	3	100	0	0	0	0	0	
48479	1	3	24626	16	100	0	0	0	0	0	
48480	1	1	48995	20	100	0	0	0	0	0	
48480	1	2	24626	16	100	0	0	0	0	0	
48481	1	1	48470	5	100	0	0	0	0	0	
48481	1	2	24620	3	100	0	0	0	0	0	
48481	1	4	24626	16	100	0	0	0	0	0	
48482	1	1	48470	10	100	0	0	0	0	0	
48482	1	2	24626	16	100	0	0	0	0	0	
48483	1	1	48470	15	100	0	0	0	0	0	
48483	1	2	24620	4	100	0	0	0	0	0	
48483	1	4	24626	16	100	0	0	0	0	0	
48484	1	1	48470	20	100	0	0	0	0	0	
48484	1	2	24626	16	100	0	0	0	0	0	
48485	1	1	48793	10	100	0	0	0	0	0	
48485	1	2	24620	4	100	0	0	0	0	0	
48485	1	3	48467	1	100	0	0	0	0	0	
48485	1	4	24626	16	100	0	0	0	0	0	
48486	1	1	48793	15	100	0	0	0	0	0	
48486	1	2	24626	16	100	0	0	0	0	0	
48487	1	1	48793	20	100	0	0	0	0	0	
48487	1	2	24620	4	100	0	0	0	0	0	
48487	1	3	48466	1	100	0	0	0	0	0	
48487	1	4	24626	16	100	0	0	0	0	0	
49937	1	1	21318	1	100	0	0	0	0	0	
49937	1	2	21319	1	100	0	0	0	0	0	
49937	1	3	21320	1	100	0	0	0	0	0	
49938	1	1	21322	1	100	0	0	0	0	0	
49938	1	2	21323	1	100	0	0	0	0	0	
49938	1	3	21324	1	100	0	0	0	0	0	
49938	1	4	21325	1	100	0	0	0	0	0	
49939	1	1	21326	1	100	0	0	0	0	0	
49939	1	2	21327	1	100	0	0	0	0	0	
49939	1	3	21328	1	100	0	0	0	0	0	
49939	1	4	21329	1	100	0	0	0	0	0	
49940	1	1	23039	1	100	0	0	0	0	0	
49940	1	2	23045	1	100	0	0	0	0	0	
49940	1	3	31601	20	100	0	0	0	0	0	
49940	1	4	31620	2	100	0	0	0	0	0	
49941	1	1	21330	1	100	0	0	0	0	0	
49941	1	2	21331	1	100	0	0	0	0	0	
49941	1	3	22050	250	100	0	0	0	0	0	
49942	1	1	21318	1	100	0	0	0	0	0	
49942	1	2	21319	1	100	0	0	0	0	0	
49942	1	3	21320	1	100	0	0	0	0	0	
49942	1	4	21321	1	100	0	0	0	0	0	
49943	1	1	21322	1	100	0	0	0	0	0	
49943	1	2	21323	1	100	0	0	0	0	0	
49943	1	3	21324	1	100	0	0	0	0	0	
49943	1	4	21325	1	100	0	0	0	0	0	
49944	1	1	21326	1	100	0	0	0	0	0	
49944	1	2	21327	1	100	0	0	0	0	0	
49944	1	3	21328	1	100	0	0	0	0	0	
49944	1	4	21329	1	100	0	0	0	0	0	
49958	1	1	22329	1	100	0	0	0	0	0	
49958	1	2	22330	1	100	0	0	0	0	0	
49958	1	3	22331	1	100	0	0	0	0	0	
49958	1	4	22332	1	100	0	0	0	0	0	
49958	1	5	22333	1	100	0	0	0	0	0	
49959	1	1	22334	1	100	0	0	0	0	0	
49959	1	2	22335	1	100	0	0	0	0	0	
49959	1	3	22336	1	100	0	0	0	0	0	
49959	1	4	22337	1	100	0	0	0	0	0	
49959	1	5	22338	1	100	0	0	0	0	0	
49960	1	1	22359	1	100	0	0	0	0	0	
49960	1	2	22360	1	100	0	0	0	0	0	
49960	1	3	22361	1	100	0	0	0	0	0	
49960	1	4	22362	1	100	0	0	0	0	0	
49960	1	5	22363	1	100	0	0	0	0	0	
49961	1	1	22339	1	100	0	0	0	0	0	
49961	1	2	22340	1	100	0	0	0	0	0	
49961	1	3	22341	1	100	0	0	0	0	0	
49961	1	4	22342	1	100	0	0	0	0	0	
49961	1	5	22343	1	100	0	0	0	0	0	
49962	1	1	22364	1	100	0	0	0	0	0	
49962	1	2	22365	1	100	0	0	0	0	0	
49962	1	3	22366	1	100	0	0	0	0	0	
49962	1	4	22367	1	100	0	0	0	0	0	
49962	1	5	22368	1	100	0	0	0	0	0	
49963	1	1	45172	1	100	0	0	0	0	0	
49963	1	2	45175	1	100	0	0	0	0	0	
49964	1	1	45173	1	100	0	0	0	0	0	
49964	1	2	45176	1	100	0	0	0	0	0	
49965	1	1	45174	1	100	0	0	0	0	0	
49965	1	2	45177	1	100	0	0	0	0	0	
49966	1	1	22329	1	100	0	0	0	0	0	
49966	1	2	22330	1	100	0	0	0	0	0	
49966	1	3	22331	1	100	0	0	0	0	0	
49966	1	4	22332	1	100	0	0	0	0	0	
49966	1	5	22333	1	100	0	0	0	0	0	
49975	1	1	22344	1	100	0	0	0	0	0	
49975	1	2	22345	1	100	0	0	0	0	0	
49975	1	3	22346	1	100	0	0	0	0	0	
49975	1	4	22347	1	100	0	0	0	0	0	
49975	1	5	22348	1	100	0	0	0	0	0	
49976	1	1	22369	1	100	0	0	0	0	0	
49976	1	2	22370	1	100	0	0	0	0	0	
49976	1	3	22371	1	100	0	0	0	0	0	
49976	1	4	22372	1	100	0	0	0	0	0	
49976	1	5	22373	1	100	0	0	0	0	0	
49947	1	1	22781	1	100	0	0	0	0	0	
49947	1	2	26458	1	100	0	0	0	0	0	
49948	1	1	22782	1	100	0	0	0	0	0	
49948	1	2	26458	1	100	0	0	0	0	0	
49949	1	1	22783	1	100	0	0	0	0	0	
49949	1	2	26459	1	100	0	0	0	0	0	
49950	1	1	22784	1	100	0	0	0	0	0	
49950	1	2	26459	1	100	0	0	0	0	0	
49951	1	1	22785	1	100	0	0	0	0	0	
49951	1	2	26460	1	100	0	0	0	0	0	
49952	1	1	22786	1	100	0	0	0	0	0	
49952	1	2	26460	1	100	0	0	0	0	0	
49980	1	1	23693	1	100	0	0	0	0	0	
49980	1	2	29815	1	100	0	0	0	0	0	
49980	1	3	27691	1	100	0	0	0	0	0	
49980	1	4	49981	1	100	0	0	0	0	0	
49981	1	1	20384	1	2.7	0	0	0	0	0	
49981	2	1	20490	1	2.7	0	0	0	0	0	
49981	3	1	21042	1	2.7	0	0	0	0	0	
49981	4	1	21460	1	2.7	0	0	0	0	0	
49981	5	1	23696	1	2.8	0	0	0	0	0	
49981	6	1	26454	1	2.8	0	0	0	0	0	
49981	7	1	26773	1	2.7	0	0	0	0	0	
49981	8	1	23699	1	2.8	0	0	0	0	0	
49981	9	1	27110	1	2.7	0	0	0	0	0	
49981	10	1	27114	1	2.7	0	0	0	0	0	
49981	11	1	23700	1	2.8	0	0	0	0	0	
49981	12	1	27706	1	2.7	0	0	0	0	0	
49981	13	1	28945	1	2.8	0	0	0	0	0	
49981	14	1	28996	1	2.8	0	0	0	0	0	
49981	15	1	29230	1	2.8	0	0	0	0	0	
49981	16	1	34120	1	2.8	0	0	0	0	0	
49981	17	1	34784	1	2.8	0	0	0	0	0	
49981	18	1	34926	1	2.8	0	0	0	0	0	
49981	19	1	38391	1	2.8	0	0	0	0	0	
49981	20	1	39142	1	2.8	0	0	0	0	0	
49981	21	1	39160	1	2.8	0	0	0	0	0	
49981	22	1	39321	1	2.8	0	0	0	0	0	
49981	23	1	40750	1	2.8	0	0	0	0	0	
49981	24	1	40752	1	2.8	0	0	0	0	0	
49981	25	1	40771	1	2.8	0	0	0	0	0	
49981	26	1	40813	1	2.8	0	0	0	0	0	
49981	27	1	41205	1	2.8	0	0	0	0	0	
49981	28	1	41990	1	2.8	0	0	0	0	0	
49981	29	1	42066	1	2.8	0	0	0	0	0	
49981	30	1	42086	1	2.8	0	0	0	0	0	
49981	31	1	43198	1	2.8	0	0	0	0	0	
49981	32	1	43324	1	2.8	0	0	0	0	0	
49981	33	1	40974	1	2.8	0	0	0	0	0	
49981	34	1	40975	1	2.8	0	0	0	0	0	
49981	35	1	40977	1	2.8	0	0	0	0	0	
49981	36	1	48674	1	2.8	0	0	0	0	0	
49982	1	1	20383	1	0.4	0	0	0	0	0	
49982	2	1	20384	1	0.88	0	0	0	0	0	
49982	3	1	20490	1	0.88	0	0	0	0	0	
49982	4	1	20494	1	0.4	0	0	0	0	0	
49982	5	1	20596	1	0.6	0	0	0	0	0	
49982	6	1	20597	1	0.3	0	0	0	0	0	
49982	7	1	20791	1	0.6	0	0	0	0	0	
49982	8	1	20792	1	0.3	0	0	0	0	0	
49982	9	1	21042	1	0.88	0	0	0	0	0	
49982	10	1	21043	1	0.4	0	0	0	0	0	
49982	11	1	21460	1	0.88	0	0	0	0	0	
49982	12	1	21461	1	0.4	0	0	0	0	0	
49982	13	1	21476	1	0.4	0	0	0	0	0	
49982	14	1	21477	1	0.9	0	0	0	0	0	
49982	15	1	25244	1	0.3	0	0	0	0	0	
49982	16	1	23694	1	0.6	0	0	0	0	0	
49982	17	1	25453	1	0.3	0	0	0	0	0	
49982	18	1	23695	1	0.6	0	0	0	0	0	
49982	19	1	25615	1	0.4	0	0	0	0	0	
49982	20	1	23696	1	0.88	0	0	0	0	0	
49982	21	1	25733	1	0.3	0	0	0	0	0	
49982	22	1	25734	1	0.6	0	0	0	0	0	
49982	23	1	25988	1	0.3	0	0	0	0	0	
49982	24	1	23697	1	0.6	0	0	0	0	0	
49982	25	1	26232	1	0.6	0	0	0	0	0	
49982	26	1	26233	1	0.3	0	0	0	0	0	
49982	27	1	26256	1	0.3	0	0	0	0	0	
49982	28	1	26257	1	0.6	0	0	0	0	0	
49982	29	1	26454	1	0.88	0	0	0	0	0	
49982	30	1	26455	1	0.4	0	0	0	0	0	
49982	31	1	26473	1	0.3	0	0	0	0	0	
49982	32	1	26474	1	0.6	0	0	0	0	0	
49982	33	1	26486	1	0.3	0	0	0	0	0	
49982	34	1	23698	1	0.6	0	0	0	0	0	
49982	35	1	26773	1	0.88	0	0	0	0	0	
49982	36	1	26774	1	0.4	0	0	0	0	0	
49982	37	1	27073	1	0.4	0	0	0	0	0	
49982	38	1	23699	1	0.88	0	0	0	0	0	
49982	39	1	27109	1	0.4	0	0	0	0	0	
49982	40	1	27110	1	0.88	0	0	0	0	0	
49982	41	1	27113	1	0.4	0	0	0	0	0	
49982	42	1	27114	1	0.88	0	0	0	0	0	
49982	43	1	27197	1	0.4	0	0	0	0	0	
49982	44	1	23699	1	0.88	0	0	0	0	0	
49982	45	1	27208	1	0.4	0	0	0	0	0	
49982	46	1	27209	1	0.9	0	0	0	0	0	
49982	47	1	27690	1	0.4	0	0	0	0	0	
49982	48	1	27706	1	0.88	0	0	0	0	0	
49982	49	1	28716	1	0.3	0	0	0	0	0	
49982	50	1	23701	1	0.6	0	0	0	0	0	
49982	51	1	28745	1	0.6	0	0	0	0	0	
49982	52	1	28746	1	0.3	0	0	0	0	0	
49982	53	1	28929	1	0.6	0	0	0	0	0	
49982	54	1	28930	1	0.3	0	0	0	0	0	
49982	55	1	28931	1	0.9	0	0	0	0	0	
49982	56	1	28932	1	0.4	0	0	0	0	0	
49982	57	1	28942	1	0.6	0	0	0	0	0	
49982	58	1	28944	1	0.3	0	0	0	0	0	
49982	59	1	28945	1	0.88	0	0	0	0	0	
49982	60	1	28946	1	0.4	0	0	0	0	0	
49982	61	1	28962	1	0.3	0	0	0	0	0	
49982	62	1	28963	1	0.6	0	0	0	0	0	
49982	63	1	28973	1	0.6	0	0	0	0	0	
49982	64	1	28974	1	0.3	0	0	0	0	0	
49982	65	1	28977	1	0.3	0	0	0	0	0	
49982	66	1	28978	1	0.6	0	0	0	0	0	
49982	67	1	28996	1	0.88	0	0	0	0	0	
49982	68	1	28997	1	0.4	0	0	0	0	0	
49982	69	1	28998	1	0.9	0	0	0	0	0	
49982	70	1	28999	1	0.4	0	0	0	0	0	
49982	71	1	29210	1	0.3	0	0	0	0	0	
49982	72	1	29211	1	0.64	0	0	0	0	0	
49982	73	1	29225	1	0.3	0	0	0	0	0	
49982	74	1	29226	1	0.6	0	0	0	0	0	
49982	75	1	29229	1	0.4	0	0	0	0	0	
49982	76	1	29230	1	0.88	0	0	0	0	0	
49982	77	1	29907	1	0.88	0	0	0	0	0	
49982	78	1	29908	1	0.4	0	0	0	0	0	
49982	79	1	34120	1	0.88	0	0	0	0	0	
49982	80	1	34122	1	0.4	0	0	0	0	0	
49982	81	1	34784	1	0.88	0	0	0	0	0	
49982	82	1	34785	1	0.4	0	0	0	0	0	
49982	83	1	34926	1	0.88	0	0	0	0	0	
49982	84	1	34927	1	0.4	0	0	0	0	0	
49982	85	1	38391	1	0.88	0	0	0	0	0	
49982	86	1	38392	1	0.4	0	0	0	0	0	
49982	87	1	39142	1	0.88	0	0	0	0	0	
49982	88	1	39143	1	0.4	0	0	0	0	0	
49982	89	1	39159	1	0.4	0	0	0	0	0	
49982	90	1	39160	1	0.88	0	0	0	0	0	
49982	91	1	39321	1	0.88	0	0	0	0	0	
49982	92	1	39322	1	0.4	0	0	0	0	0	
49982	93	1	39542	1	0.3	0	0	0	0	0	
49982	94	1	39543	1	0.6	0	0	0	0	0	
49982	95	1	23574	1	0.9	0	0	0	0	0	
49982	96	1	23575	1	0.4	0	0	0	0	0	
49982	97	1	23580	1	0.3	0	0	0	0	0	
49982	98	1	23581	1	0.6	0	0	0	0	0	
49982	99	1	39075	1	0.18	0	0	0	0	0	
49982	100	1	39076	1	0.88	0	0	0	0	0	
49982	101	1	39077	1	0.18	0	0	0	0	0	
49982	102	1	39078	1	0.88	0	0	0	0	0	
49982	103	1	40749	1	0.4	0	0	0	0	0	
49982	104	1	40750	1	0.88	0	0	0	0	0	
49982	105	1	40751	1	0.4	0	0	0	0	0	
49982	106	1	40752	1	0.88	0	0	0	0	0	
49982	107	1	40770	1	0.4	0	0	0	0	0	
49982	108	1	40771	1	0.88	0	0	0	0	0	
49982	109	1	40812	1	0.4	0	0	0	0	0	
49982	110	1	40813	1	0.88	0	0	0	0	0	
49982	111	1	41204	1	0.4	0	0	0	0	0	
49982	112	1	41205	1	0.88	0	0	0	0	0	
49982	113	1	41989	1	0.4	0	0	0	0	0	
49982	114	1	41990	1	0.88	0	0	0	0	0	
49982	115	1	42065	1	0.4	0	0	0	0	0	
49982	116	1	42066	1	0.88	0	0	0	0	0	
49982	117	1	42085	1	0.4	0	0	0	0	0	
49982	118	1	42086	1	0.88	0	0	0	0	0	
49982	119	1	43197	1	0.4	0	0	0	0	0	
49982	120	1	43198	1	0.88	0	0	0	0	0	
49982	121	1	43323	1	0.4	0	0	0	0	0	
49982	122	1	43324	1	0.88	0	0	0	0	0	
49982	123	1	43325	1	0.4	0	0	0	0	0	
49982	124	1	43326	1	0.4	0	0	0	0	0	
49982	125	1	43327	1	0.4	0	0	0	0	0	
49982	126	1	40974	1	0.88	0	0	0	0	0	
49982	127	1	40975	1	0.88	0	0	0	0	0	
49982	128	1	40977	1	0.88	0	0	0	0	0	
49982	129	1	43329	1	0.4	0	0	0	0	0	
49982	130	1	48674	1	0.88	0	0	0	0	0	
49982	131	1	41632	1	0.4	0	0	0	0	0	
49982	132	1	41633	1	0.9	0	0	0	0	0	
49982	133	1	41993	1	0.4	0	0	0	0	0	
49982	134	1	41994	1	0.9	0	0	0	0	0	
49982	135	1	42069	1	0.4	0	0	0	0	0	
49982	136	1	42070	1	0.9	0	0	0	0	0	
49982	137	1	43013	1	0.4	0	0	0	0	0	
49982	138	1	43014	1	0.9	0	0	0	0	0	
49982	139	1	43207	1	0.4	0	0	0	0	0	
49982	140	1	43208	1	0.9	0	0	0	0	0	
49982	141	1	40743	1	0.18	0	0	0	0	0	
49982	142	1	40744	1	0.85	0	0	0	0	0	
49982	143	1	40745	1	0.18	0	0	0	0	0	
49982	144	1	40746	1	0.85	0	0	0	0	0	
49982	145	1	40814	1	0.18	0	0	0	0	0	
49982	146	1	40815	1	0.8	0	0	0	0	0	
49982	147	1	40816	1	0.18	0	0	0	0	0	
49982	148	1	40817	1	0.8	0	0	0	0	0	
49982	149	1	41620	1	0.18	0	0	0	0	0	
49982	150	1	41621	1	0.8	0	0	0	0	0	
49982	151	1	41624	1	0.18	0	0	0	0	0	
49982	152	1	41625	1	0.8	0	0	0	0	0	
49982	153	1	40656	1	0.3	0	0	0	0	0	
49982	154	1	40679	1	0.6	0	0	0	0	0	
49982	155	1	40657	1	0.3	0	0	0	0	0	
49982	156	1	40680	1	0.6	0	0	0	0	0	
49982	157	1	40774	1	0.3	0	0	0	0	0	
49982	158	1	40775	1	0.6	0	0	0	0	0	
49982	159	1	40822	1	0.3	0	0	0	0	0	
49982	160	1	40823	1	0.6	0	0	0	0	0	
49982	161	1	40824	1	0.3	0	0	0	0	0	
49982	162	1	40825	1	0.6	0	0	0	0	0	
49982	163	1	42840	1	0.3	0	0	0	0	0	
49982	164	1	42841	1	0.6	0	0	0	0	0	
49982	165	1	23726	1	0.8	0	0	0	0	0	
49982	166	1	33670	1	0.1	0	0	0	0	0	
49982	167	1	34932	1	0.1	0	0	0	0	0	
49982	168	1	23702	1	0.8	0	0	0	0	0	
49982	169	1	34933	1	0.1	0	0	0	0	0	
49982	170	1	23703	1	0.8	0	0	0	0	0	
49982	171	1	38909	1	0.1	0	0	0	0	0	
49982	172	1	23704	1	0.8	0	0	0	0	0	
49982	173	1	38911	1	0.1	0	0	0	0	0	
49982	174	1	23705	1	0.8	0	0	0	0	0	
49982	175	1	44136	1	0.1	0	0	0	0	0	
49982	176	1	44137	1	0.8	0	0	0	0	0	
49982	177	1	43796	1	0.1	0	0	0	0	0	
49982	178	1	43797	1	0.8	0	0	0	0	0	
49982	186	1	40753	1	0.1	0	0	0	0	0	
49982	187	1	48675	1	0.8	0	0	0	0	0	
49989	1	1	41613	1	100	0	0	0	0	0	
49989	1	2	40456	1	100	0	0	0	0	0	
49989	1	3	40299	1	100	0	0	0	0	0	
49989	1	4	40300	1	100	0	0	0	0	0	
49990	1	1	48929	1	100	0	0	0	0	0	
49990	1	2	40299	1	100	0	0	0	0	0	
49990	1	3	40300	1	100	0	0	0	0	0	
49991	1	1	48951	1	100	0	0	0	0	0	
49991	1	2	40456	1	100	0	0	0	0	0	
49991	1	3	41613	1	100	0	0	0	0	0	
49992	1	1	49877	1	100	0	0	0	0	0	
49992	1	2	40456	1	100	0	0	0	0	0	
49992	1	3	41613	1	100	0	0	0	0	0	
49877	1	1	48811	1	20	0	0	0	0	0	
49877	2	1	48812	1	20	0	0	0	0	0	
49877	3	1	48813	1	20	0	0	0	0	0	
49877	4	1	48814	1	20	0	0	0	0	0	
49877	5	1	48815	1	20	0	0	0	0	0	
49986	1	1	22349	1	100	0	0	0	0	0	
49986	1	2	22350	1	100	0	0	0	0	0	
49986	1	3	22351	1	100	0	0	0	0	0	
49986	1	4	22352	1	100	0	0	0	0	0	
49986	1	5	22353	1	100	0	0	0	0	0	
49987	1	1	22374	1	100	0	0	0	0	0	
49987	1	2	22375	1	100	0	0	0	0	0	
49987	1	3	22376	1	100	0	0	0	0	0	
49987	1	4	22377	1	100	0	0	0	0	0	
49987	1	5	22378	1	100	0	0	0	0	0	
48668	1	1	26001	1	0.1	0	0	0	0	0	
48668	2	1	26002	1	0.1	0	0	0	0	0	
48668	3	1	26003	1	0.1	0	0	0	0	0	
48668	4	1	26004	1	0.1	0	0	0	0	0	
48668	5	1	26005	1	0.1	0	0	0	0	0	
48668	6	1	26006	1	0.1	0	0	0	0	0	
48668	7	1	25269	3	10	0	0	0	0	0	
48668	8	1	25270	1	3	0	0	0	0	0	
48668	9	1	25271	1	1	0	0	0	0	0	
48668	10	1	25273	1	5	0	0	0	0	0	
48668	11	1	25274	1	3	0	0	0	0	0	
48668	12	1	25275	1	1	0	0	0	0	0	
48668	13	1	39520	1	3	0	0	0	0	0	
48668	14	1	39528	1	12	0	0	0	0	0	
48668	15	1	28984	3	12	0	0	0	0	0	
48668	16	1	28985	1	1	0	0	0	0	0	
48668	17	1	42903	1	0.4	0	0	0	0	0	
48668	18	1	25317	2	10	0	0	0	0	0	
48668	19	1	25318	1	3	0	0	0	0	0	
48668	20	1	25319	1	1	0	0	0	0	0	
48668	21	1	21094	1	3	0	0	0	0	0	
48668	22	1	20961	1	3	0	0	0	0	0	
48668	23	1	21079	1	5.5	0	0	0	0	0	
48668	24	1	21080	1	5.5	0	0	0	0	0	
48668	25	1	21081	1	5	0	0	0	0	0	
48668	26	1	21082	1	5	0	0	0	0	0	
48668	27	1	25305	1	3	0	0	0	0	0	
48668	28	1	20960	1	2	0	0	0	0	0	
48668	29	1	26098	1	2	0	0	0	0	0	
48669	1	1	26081	1	4.8	0	0	0	0	0	
48669	2	1	25872	1	4.8	0	0	0	0	0	
48669	3	1	25795	1	4.8	0	0	0	0	0	
48669	4	1	25796	1	4.8	0	0	0	0	0	
48669	5	1	25797	1	4.8	0	0	0	0	0	
48669	6	1	25798	1	4.8	0	0	0	0	0	
48669	7	1	25306	1	5	0	0	0	0	0	
48669	8	1	25892	1	1	0	0	0	0	0	
48669	9	1	25851	1	1	0	0	0	0	0	
48669	10	1	26085	1	1	0	0	0	0	0	
48669	11	1	26086	1	1	0	0	0	0	0	
48669	12	1	26087	1	1	0	0	0	0	0	
48669	13	1	26088	1	1	0	0	0	0	0	
48669	14	1	25751	1	1	0	0	0	0	0	
48669	15	1	25273	1	10	0	0	0	0	0	
48669	16	1	25274	1	5	0	0	0	0	0	
48669	17	1	25275	1	3	0	0	0	0	0	
48669	18	1	25317	1	10	0	0	0	0	0	
48669	19	1	25318	1	5	0	0	0	0	0	
48669	20	1	25319	1	3	0	0	0	0	0	
48669	21	1	25313	1	2	0	0	0	0	0	
48669	22	1	26098	1	2	0	0	0	0	0	
48669	23	1	26001	1	0.2	0	0	0	0	0	
48669	24	1	26002	1	0.2	0	0	0	0	0	
48669	25	1	26003	1	0.2	0	0	0	0	0	
48669	26	1	26004	1	0.2	0	0	0	0	0	
48669	27	1	26005	1	0.2	0	0	0	0	0	
48669	28	1	26006	1	0.2	0	0	0	0	0	
48669	29	1	25269	1	10	0	0	0	0	0	
48669	30	1	25270	1	4	0	0	0	0	0	
48669	31	1	25271	1	4	0	0	0	0	0	
48670	1	1	26082	1	5	0	0	0	0	0	
48670	2	1	25873	1	5	0	0	0	0	0	
48670	3	1	25799	1	5	0	0	0	0	0	
48670	4	1	25800	1	5	0	0	0	0	0	
48670	5	1	25801	1	5	0	0	0	0	0	
48670	6	1	25802	1	5	0	0	0	0	0	
48670	7	1	25307	1	5.2	0	0	0	0	0	
48670	8	1	25893	1	2	0	0	0	0	0	
48670	9	1	25853	1	2	0	0	0	0	0	
48670	10	1	25854	1	2	0	0	0	0	0	
48670	11	1	26089	1	2	0	0	0	0	0	
48670	12	1	26090	1	2	0	0	0	0	0	
48670	13	1	26091	1	2	0	0	0	0	0	
48670	14	1	26092	1	2	0	0	0	0	0	
48670	15	1	25752	1	2	0	0	0	0	0	
48670	16	1	25274	1	10	0	0	0	0	0	
48670	17	1	25275	1	5	0	0	0	0	0	
48670	18	1	25318	1	10	0	0	0	0	0	
48670	19	1	25319	1	5	0	0	0	0	0	
48670	20	1	25314	1	5	0	0	0	0	0	
48670	21	1	26098	1	5	0	0	0	0	0	
48670	22	1	26001	1	0.3	0	0	0	0	0	
48670	23	1	26002	1	0.3	0	0	0	0	0	
48670	24	1	26003	1	0.3	0	0	0	0	0	
48670	25	1	26004	1	0.3	0	0	0	0	0	
48670	26	1	26005	1	0.3	0	0	0	0	0	
48670	27	1	26006	1	0.3	0	0	0	0	0	
48670	28	1	25270	1	4	0	0	0	0	0	
48670	29	1	25271	1	3	0	0	0	0	0	
48671	1	1	26083	1	5	0	0	0	0	0	
48671	2	1	26084	1	5	0	0	0	0	0	
48671	3	1	25874	1	5	0	0	0	0	0	
48671	4	1	25875	1	5	0	0	0	0	0	
48671	5	1	25803	1	5	0	0	0	0	0	
48671	6	1	25804	1	5	0	0	0	0	0	
48671	7	1	25805	1	5	0	0	0	0	0	
48671	8	1	25806	1	5	0	0	0	0	0	
48671	9	1	25308	1	5	0	0	0	0	0	
48671	10	1	25894	1	1.5	0	0	0	0	0	
48671	11	1	25855	1	1.4	0	0	0	0	0	
48671	12	1	25856	1	1.4	0	0	0	0	0	
48671	13	1	25857	1	1.4	0	0	0	0	0	
48671	14	1	26093	1	1.5	0	0	0	0	0	
48671	15	1	26094	1	1.5	0	0	0	0	0	
48671	16	1	26095	1	1.5	0	0	0	0	0	
48671	17	1	26096	1	1.5	0	0	0	0	0	
48671	18	1	26097	1	1.5	0	0	0	0	0	
48671	19	1	25274	1	7	0	0	0	0	0	
48671	20	1	25275	1	4	0	0	0	0	0	
48671	21	1	25318	1	7	0	0	0	0	0	
48671	22	1	25319	1	4	0	0	0	0	0	
48671	23	1	25315	1	5	0	0	0	0	0	
48671	24	1	26098	1	5	0	0	0	0	0	
48671	25	1	26001	1	0.3	0	0	0	0	0	
48671	26	1	26002	1	0.3	0	0	0	0	0	
48671	27	1	26003	1	0.3	0	0	0	0	0	
48671	28	1	26004	1	0.3	0	0	0	0	0	
48671	29	1	26005	1	0.3	0	0	0	0	0	
48671	30	1	26006	1	0.3	0	0	0	0	0	
48671	31	1	25270	1	5	0	0	0	0	0	
48671	32	1	25271	1	3	0	0	0	0	0	
49094	1	1	40236	1	0.5	1	0	0	0	0	
49094	2	1	40237	1	1	1	0	0	0	0	
49094	3	1	40238	1	1	1	0	0	0	0	
49094	4	1	40169	1	1	1	0	0	0	0	
49094	5	1	40399	1	0.5	1	0	0	0	0	
49094	6	1	40440	1	0.5	1	0	0	0	0	
49094	7	1	34992	1	0.1	1	0	0	0	0	
49094	8	1	35015	1	0.9	0	0	0	0	0	
49094	9	1	40180	1	4.5	0	0	0	0	0	
49094	10	1	40261	1	4	0	0	0	0	0	
49094	11	1	40262	1	4	0	0	0	0	0	
49094	12	1	40263	1	4	0	0	0	0	0	
49094	13	1	40402	1	4	0	0	0	0	0	
49094	14	1	40442	1	4	0	0	0	0	0	
49094	15	1	40362	1	50	0	0	0	0	0	
49094	16	1	40033	50	2	0	0	0	0	0	
49094	17	1	40034	50	2	0	0	0	0	0	
49094	18	1	40035	50	2	0	0	0	0	0	
49094	19	1	40036	50	2	0	0	0	0	0	
49094	20	1	40037	50	2	0	0	0	0	0	
49094	21	1	40038	50	2	0	0	0	0	0	
49094	22	1	40039	50	2	0	0	0	0	0	
49094	23	1	40104	50	2	0	0	0	0	0	
49094	24	1	40105	50	2	0	0	0	0	0	
49094	25	1	40106	50	2	0	0	0	0	0	
48228	1	1	31777	10	100	0	0	0	0	0	
48228	1	2	31778	10	100	0	0	0	0	0	
48228	1	3	41099	5	100	0	0	0	0	0	
48228	1	4	41100	5	100	0	0	0	0	0	
48228	1	5	48907	6	100	0	0	0	0	0	
48229	1	1	40299	3	100	0	0	0	0	0	
48229	1	2	40300	3	100	0	0	0	0	0	
48229	1	3	41106	2	100	0	0	0	0	0	
48229	1	4	41107	2	100	0	0	0	0	0	
48230	1	1	29815	1	100	0	0	0	0	0	
48230	1	2	40455	3	100	0	0	0	0	0	
48230	1	3	48998	3	100	0	0	0	0	0	
48230	1	4	43283	3	100	0	0	0	0	0	
48230	1	5	41109	5	100	0	0	0	0	0	
48230	1	6	41110	5	100	0	0	0	0	0	
48230	1	7	41112	1	100	0	0	0	0	0	
48231	1	1	40450	5	100	0	0	0	0	0	
48231	1	2	40311	1	100	0	0	0	0	0	
48231	1	3	40456	3	100	0	0	0	0	0	
48231	1	4	17261	1	100	0	0	0	0	0	
48231	1	5	48698	2	100	0	0	0	0	0	
48232	1	1	40351	1	100	0	0	0	0	0	
48232	1	2	40457	3	100	0	0	0	0	0	
48232	1	3	48700	1	100	0	0	0	0	0	
48232	1	4	48699	1	100	0	0	0	0	0	
48233	1	1	42333	1	100	0	0	0	0	0	
48233	1	2	40458	3	100	0	0	0	0	0	
48233	1	3	40926	1	100	0	0	0	0	0	
48233	1	4	48701	1	100	0	0	0	0	0	
48234	1	1	40451	10	100	0	0	0	0	0	
48234	1	2	34428	10	100	0	0	0	0	0	
48234	1	3	41115	1	100	0	0	0	0	0	
48234	1	4	48702	1	100	0	0	0	0	0	
48235	1	1	27994	5	100	0	0	0	0	0	
48235	1	2	48703	1	100	0	0	0	0	0	
48652	1	1	40311	1	100	0	0	0	0	0	
48652	1	2	48906	2	100	0	0	0	0	0	
48652	1	3	49877	1	100	0	0	0	0	0	
48652	1	4	41117	1	100	0	0	0	0	0	
48653	1	1	40311	1	100	0	0	0	0	0	
48653	1	2	48906	2	100	0	0	0	0	0	
48653	1	3	49877	1	100	0	0	0	0	0	
48653	1	4	41117	1	100	0	0	0	0	0	
48654	1	1	40311	1	100	0	0	0	0	0	
48654	1	2	48906	2	100	0	0	0	0	0	
48654	1	3	49877	1	100	0	0	0	0	0	
48654	1	4	41117	1	100	0	0	0	0	0	
48654	1	5	41089	1	100	0	0	0	0	0	
48664	1	1	41106	5	100	0	0	0	0	0	
48664	1	2	41107	5	100	0	0	0	0	0	
48664	1	3	41113	30	100	0	0	0	0	0	
48664	1	4	48658	1	100	0	0	0	0	0	
48664	1	5	48659	1	100	0	0	0	0	0	
48664	1	6	48660	1	100	0	0	0	0	0	
48664	1	7	48661	1	100	0	0	0	0	0	
48665	1	1	49877	1	100	0	0	0	0	0	
48665	1	2	48662	1	100	0	0	0	0	0	
48665	1	3	48663	1	100	0	0	0	0	0	
48666	1	1	48656	1	100	0	0	0	0	0	
49136	1	1	40107	10	100	0	0	0	0	0	
49136	1	2	40604	1	0.3	0	0	0	0	0	
49136	2	2	40605	1	0.1	0	0	0	0	0	
49136	3	2	40606	1	2.3	0	0	0	0	0	
49136	4	2	40607	1	2.3	0	0	0	0	0	
49136	5	2	40160	1	0.5	0	0	0	0	0	
49136	6	2	40161	1	0.5	0	0	0	0	0	
49136	7	2	40162	1	0.5	0	0	0	0	0	
49136	8	2	40163	1	0.5	0	0	0	0	0	
49136	9	2	40171	1	4	0	0	0	0	0	
49136	10	2	40172	1	4	0	0	0	0	0	
49136	11	2	40173	1	4	0	0	0	0	0	
49136	12	2	40174	1	3.5	0	0	0	0	0	
49136	13	2	30018	1	1	0	0	0	0	0	
49136	14	2	40023	2	2.5	0	0	0	0	0	
49136	15	2	40025	2	2.5	0	0	0	0	0	
49136	16	2	40027	2	2.5	0	0	0	0	0	
49136	17	2	40029	2	2.5	0	0	0	0	0	
49136	18	2	40031	2	2.5	0	0	0	0	0	
49136	19	2	40210	1	5	0	0	0	0	0	
49136	20	2	40212	1	5	0	0	0	0	0	
49136	21	2	40214	1	5	0	0	0	0	0	
49136	22	2	40216	1	5	0	0	0	0	0	
49136	23	2	40218	1	5	0	0	0	0	0	
49136	24	2	40181	1	13	0	0	0	0	0	
49136	25	2	40041	1	13	0	0	0	0	0	
49136	26	2	40156	2	13	0	0	0	0	0	
48139	1	1	40152	5	4.25	0	0	0	0	0	
48139	2	1	40153	5	1.12	0	0	0	0	0	
48139	3	1	40154	5	4.25	0	0	0	0	0	
48139	4	1	40155	5	1.12	0	0	0	0	0	
48139	5	1	40200	4	7.5	0	0	0	0	0	
48139	6	1	40201	1	3.76	0	0	0	0	0	
48139	7	1	40186	1	12.4	0	0	0	0	0	
48139	8	1	40187	1	10.17	0	0	0	0	0	
48139	9	1	40188	1	8.17	0	0	0	0	0	
48139	10	1	40317	1	1.88	0	0	0	0	0	
48139	11	1	40189	1	0.38	0	0	0	0	0	
48139	12	1	40183	22	18	0	0	0	0	0	
48139	13	1	40184	1	1	0	0	0	0	0	
48139	14	1	40185	3	5	0	0	0	0	0	
48139	15	1	40380	1	3	0	0	0	0	0	
48139	16	1	40033	160	2	0	0	0	0	0	
48139	17	1	40034	160	2	0	0	0	0	0	
48139	18	1	40035	95	2	0	0	0	0	0	
48139	19	1	40036	80	2	0	0	0	0	0	
48139	20	1	40037	70	2	0	0	0	0	0	
48139	21	1	40038	160	2	0	0	0	0	0	
48139	22	1	40039	120	2	0	0	0	0	0	
48139	23	1	40104	95	2	0	0	0	0	0	
48139	24	1	40105	80	1	0	0	0	0	0	
48139	25	1	40106	70	1	0	0	0	0	0	
48140	1	1	40019	5	5	0	0	0	0	0	
48140	2	1	40020	5	5	0	0	0	0	0	
48140	3	1	40021	2	5	0	0	0	0	0	
48140	4	1	40022	2	3	0	0	0	0	0	
48140	5	1	40023	4	1	0	0	0	0	0	
48140	6	1	40024	2	1	0	0	0	0	0	
48140	7	1	40025	4	1	0	0	0	0	0	
48140	8	1	40026	2	1	0	0	0	0	0	
48140	9	1	40027	4	1	0	0	0	0	0	
48140	10	1	40028	2	1	0	0	0	0	0	
48140	11	1	40029	4	1	0	0	0	0	0	
48140	12	1	40030	2	1	0	0	0	0	0	
48140	13	1	40031	4	1	0	0	0	0	0	
48140	14	1	40032	2	1	0	0	0	0	0	
48140	15	1	40209	2	1	0	0	0	0	0	
48140	16	1	40210	1	1	0	0	0	0	0	
48140	17	1	40211	2	1	0	0	0	0	0	
48140	18	1	40212	1	1	0	0	0	0	0	
48140	19	1	40213	2	1	0	0	0	0	0	
48140	20	1	40214	1	1	0	0	0	0	0	
48140	21	1	40215	2	1	0	0	0	0	0	
48140	22	1	40216	1	1	0	0	0	0	0	
48140	23	1	40217	2	1	0	0	0	0	0	
48140	24	1	40218	1	1	0	0	0	0	0	
48140	25	1	40113	1	4	0	0	0	0	0	
48140	26	1	40222	1	1	0	0	0	0	0	
48140	27	1	40273	1	0.5	0	0	0	0	0	
48140	28	1	40274	1	0.2	0	0	0	0	0	
48140	29	1	40350	1	0.3	0	0	0	0	0	
48140	30	1	40156	4	13	0	0	0	0	0	
48140	31	1	40157	2	12	0	0	0	0	0	
48140	32	1	40158	1	5	0	0	0	0	0	
48140	33	1	40181	3	3	0	0	0	0	0	
48140	34	1	40182	1	3	0	0	0	0	0	
48140	35	1	41088	45	10	0	0	0	0	0	
48140	36	1	40122	10	5	0	0	0	0	0	
48140	37	1	40033	160	0.5	0	0	0	0	0	
48140	38	1	40034	160	0.5	0	0	0	0	0	
48140	39	1	40035	95	0.5	0	0	0	0	0	
48140	40	1	40036	80	0.5	0	0	0	0	0	
48140	41	1	40037	70	0.5	0	0	0	0	0	
48140	42	1	40038	160	0.5	0	0	0	0	0	
48140	43	1	40039	120	0.5	0	0	0	0	0	
48140	44	1	40104	95	0.5	0	0	0	0	0	
48140	45	1	40105	80	0.5	0	0	0	0	0	
48140	46	1	40106	70	0.5	0	0	0	0	0	
48141	1	1	40331	1	0.09	1	0	0	0	0	
48141	2	1	40332	1	0.02	1	0	0	0	0	
48141	3	1	40265	1	0.09	1	0	0	0	0	
48141	4	1	40266	1	0.02	1	0	0	0	0	
48141	5	1	40267	1	0.09	1	0	0	0	0	
48141	6	1	40268	1	0.02	1	0	0	0	0	
48141	7	1	40335	1	0.09	1	0	0	0	0	
48141	8	1	40336	1	0.02	1	0	0	0	0	
48141	9	1	40333	1	2.59	0	0	0	0	0	
48141	10	1	40334	1	1.3	0	0	0	0	0	
48141	11	1	40269	1	2.59	0	0	0	0	0	
48141	12	1	40270	1	1.3	0	0	0	0	0	
48141	13	1	40271	1	2.59	0	0	0	0	0	
48141	14	1	40272	1	1.3	0	0	0	0	0	
48141	15	1	40337	1	2.59	0	0	0	0	0	
48141	16	1	40338	1	1.3	0	0	0	0	0	
48141	17	1	40033	160	8	0	0	0	0	0	
48141	18	1	40034	160	8	0	0	0	0	0	
48141	19	1	40035	95	8	0	0	0	0	0	
48141	20	1	40036	80	8	0	0	0	0	0	
48141	21	1	40037	70	8	0	0	0	0	0	
48141	22	1	40038	160	8	0	0	0	0	0	
48141	23	1	40039	120	8	0	0	0	0	0	
48141	24	1	40104	95	8	0	0	0	0	0	
48141	25	1	40105	80	10	0	0	0	0	0	
48141	26	1	40106	70	10	0	0	0	0	0	
48142	1	1	34937	1	7	0	0	0	0	0	
48142	2	1	34938	1	5	0	0	0	0	0	
48142	3	1	34939	1	3	0	0	0	0	0	
48142	4	1	34940	1	7	0	0	0	0	0	
48142	5	1	34941	1	5	0	0	0	0	0	
48142	6	1	34942	1	3	0	0	0	0	0	
48142	7	1	48697	1	2	0	0	0	0	0	
48142	8	1	48698	1	1	0	0	0	0	0	
48142	9	1	48699	1	0.05	0	0	0	0	0	
48142	10	1	34426	1	12	0	0	0	0	0	
48142	11	1	33515	1	0.1	0	0	0	0	0	
48142	12	1	33518	1	0.1	0	0	0	0	0	
48142	13	1	34396	1	1	0	0	0	0	0	
48142	14	1	34397	1	1	0	0	0	0	0	
48142	15	1	34398	1	1	0	0	0	0	0	
48142	16	1	34399	1	1	0	0	0	0	0	
48142	17	1	34400	1	1	0	0	0	0	0	
48142	18	1	34401	1	1	0	0	0	0	0	
48142	19	1	34402	1	1	0	0	0	0	0	
48142	20	1	34427	1	0.1	0	0	0	0	0	
48142	21	1	34428	1	0.1	0	0	0	0	0	
48142	22	1	34429	1	0.1	0	0	0	0	0	
48142	23	1	31510	30	0.1	0	0	0	0	0	
48142	24	1	31511	30	0.1	0	0	0	0	0	
48142	25	1	31512	30	0.1	0	0	0	0	0	
48142	26	1	31601	30	0.5	0	0	0	0	0	
48142	27	1	31602	30	0.5	0	0	0	0	0	
48142	28	1	31603	30	1	0	0	0	0	0	
48142	29	1	31604	30	0.5	0	0	0	0	0	
48142	30	1	31605	30	1	0	0	0	0	0	
48142	31	1	31606	30	1	0	0	0	0	0	
48142	32	1	31607	30	1	0	0	0	0	0	
48142	33	1	40023	4	1	0	0	0	0	0	
48142	34	1	40024	2	1	0	0	0	0	0	
48142	35	1	40025	4	1	0	0	0	0	0	
48142	36	1	40026	2	1	0	0	0	0	0	
48142	37	1	40027	4	1	0	0	0	0	0	
48142	38	1	40028	2	1	0	0	0	0	0	
48142	39	1	40029	4	1	0	0	0	0	0	
48142	40	1	40030	2	1	0	0	0	0	0	
48142	41	1	40031	4	1	0	0	0	0	0	
48142	42	1	40032	2	1	0	0	0	0	0	
48142	43	1	40209	2	1	0	0	0	0	0	
48142	44	1	40210	1	1	0	0	0	0	0	
48142	45	1	40211	2	1	0	0	0	0	0	
48142	46	1	40212	1	1	0	0	0	0	0	
48142	47	1	40213	2	1	0	0	0	0	0	
48142	48	1	40214	1	1	0	0	0	0	0	
48142	49	1	40215	2	1	0	0	0	0	0	
48142	50	1	40216	1	1.05	0	0	0	0	0	
48142	51	1	40217	2	1.3	0	0	0	0	0	
48142	52	1	40218	1	1.3	0	0	0	0	0	
48142	54	1	40033	160	2	0	0	0	0	0	
48142	55	1	40034	160	2	0	0	0	0	0	
48142	56	1	40035	95	2	0	0	0	0	0	
48142	57	1	40036	80	2	0	0	0	0	0	
48142	58	1	40037	70	2	0	0	0	0	0	
48142	59	1	40038	160	2	0	0	0	0	0	
48142	60	1	40039	120	2	0	0	0	0	0	
48142	61	1	40104	95	2	0	0	0	0	0	
48142	62	1	40105	80	2	0	0	0	0	0	
48142	63	1	40106	70	3	0	0	0	0	0	
48143	1	1	34937	1	7	0	0	0	0	0	
48143	2	1	34938	1	5	0	0	0	0	0	
48143	3	1	34939	1	3	0	0	0	0	0	
48143	4	1	34940	1	7	0	0	0	0	0	
48143	5	1	34941	1	5	0	0	0	0	0	
48143	6	1	34942	1	3	0	0	0	0	0	
48143	7	1	48697	1	2	0	0	0	0	0	
48143	8	1	48698	1	1	0	0	0	0	0	
48143	9	1	48699	1	0.05	0	0	0	0	0	
48143	10	1	34426	1	12	0	0	0	0	0	
48143	11	1	33516	1	0.1	0	0	0	0	0	
48143	12	1	33519	1	0.1	0	0	0	0	0	
48143	13	1	34403	1	1.2	0	0	0	0	0	
48143	14	1	34404	1	1.2	0	0	0	0	0	
48143	15	1	34405	1	1.2	0	0	0	0	0	
48143	16	1	34406	1	1.2	0	0	0	0	0	
48143	17	1	34407	1	1.2	0	0	0	0	0	
48143	18	1	34408	1	1.2	0	0	0	0	0	
48143	19	1	34427	1	0.1	0	0	0	0	0	
48143	20	1	34428	1	0.1	0	0	0	0	0	
48143	21	1	34429	1	0.1	0	0	0	0	0	
48143	22	1	31510	30	0.1	0	0	0	0	0	
48143	23	1	31511	30	0.1	0	0	0	0	0	
48143	24	1	31512	30	0.1	0	0	0	0	0	
48143	25	1	31601	30	0.5	0	0	0	0	0	
48143	26	1	31602	30	0.5	0	0	0	0	0	
48143	27	1	31603	30	1	0	0	0	0	0	
48143	28	1	31604	30	0.5	0	0	0	0	0	
48143	29	1	31605	30	1	0	0	0	0	0	
48143	30	1	31606	30	1	0	0	0	0	0	
48143	31	1	31607	30	1	0	0	0	0	0	
48143	32	1	40023	4	1	0	0	0	0	0	
48143	33	1	40024	2	1	0	0	0	0	0	
48143	34	1	40025	4	1	0	0	0	0	0	
48143	35	1	40026	2	1	0	0	0	0	0	
48143	36	1	40027	4	1	0	0	0	0	0	
48143	37	1	40028	2	1	0	0	0	0	0	
48143	38	1	40029	4	1	0	0	0	0	0	
48143	39	1	40030	2	1	0	0	0	0	0	
48143	40	1	40031	4	1	0	0	0	0	0	
48143	41	1	40032	2	1	0	0	0	0	0	
48143	42	1	40209	2	1	0	0	0	0	0	
48143	43	1	40210	1	1	0	0	0	0	0	
48143	44	1	40211	2	1	0	0	0	0	0	
48143	45	1	40212	1	1	0	0	0	0	0	
48143	46	1	40213	2	1	0	0	0	0	0	
48143	47	1	40214	1	1	0	0	0	0	0	
48143	48	1	40215	2	1	0	0	0	0	0	
48143	49	1	40216	1	1	0	0	0	0	0	
48143	50	1	40217	2	1	0	0	0	0	0	
48143	51	1	40218	1	2	0	0	0	0	0	
48143	53	1	40033	160	2	0	0	0	0	0	
48143	54	1	40034	160	2	0	0	0	0	0	
48143	55	1	40035	95	2	0	0	0	0	0	
48143	56	1	40036	80	2	0	0	0	0	0	
48143	57	1	40037	70	2	0	0	0	0	0	
48143	58	1	40038	160	2	0	0	0	0	0	
48143	59	1	40039	120	2	0	0	0	0	0	
48143	60	1	40104	95	2	0	0	0	0	0	
48143	61	1	40105	80	2.4	0	0	0	0	0	
48143	62	1	40106	70	2.05	0	0	0	0	0	
48144	1	1	34937	1	7	0	0	0	0	0	
48144	2	1	34938	1	5	0	0	0	0	0	
48144	3	1	34939	1	3	0	0	0	0	0	
48144	4	1	34940	1	7	0	0	0	0	0	
48144	5	1	34941	1	5	0	0	0	0	0	
48144	6	1	34942	1	3	0	0	0	0	0	
48144	7	1	48697	1	2	0	0	0	0	0	
48144	8	1	48698	1	1	0	0	0	0	0	
48144	9	1	48699	1	0.05	0	0	0	0	0	
48144	10	1	34426	1	12	0	0	0	0	0	
48144	11	1	33517	1	0.1	0	0	0	0	0	
48144	12	1	33520	1	0.1	0	0	0	0	0	
48144	13	1	34410	1	1.2	0	0	0	0	0	
48144	14	1	34411	1	1.2	0	0	0	0	0	
48144	15	1	34413	1	1.2	0	0	0	0	0	
48144	16	1	34414	1	1.2	0	0	0	0	0	
48144	17	1	34412	1	1.2	0	0	0	0	0	
48144	18	1	34415	1	1.2	0	0	0	0	0	
48144	19	1	34427	1	0.1	0	0	0	0	0	
48144	20	1	34428	1	0.1	0	0	0	0	0	
48144	21	1	34429	1	0.1	0	0	0	0	0	
48144	22	1	31510	30	0.1	0	0	0	0	0	
48144	23	1	31511	30	0.1	0	0	0	0	0	
48144	24	1	31512	30	0.1	0	0	0	0	0	
48144	25	1	31601	30	0.5	0	0	0	0	0	
48144	26	1	31602	30	0.5	0	0	0	0	0	
48144	27	1	31603	30	1	0	0	0	0	0	
48144	28	1	31604	30	0.5	0	0	0	0	0	
48144	29	1	31605	30	1	0	0	0	0	0	
48144	30	1	31606	30	1	0	0	0	0	0	
48144	31	1	31607	30	1	0	0	0	0	0	
48144	32	1	40023	4	1	0	0	0	0	0	
48144	33	1	40024	2	1	0	0	0	0	0	
48144	34	1	40025	4	1	0	0	0	0	0	
48144	35	1	40026	2	1	0	0	0	0	0	
48144	36	1	40027	4	1	0	0	0	0	0	
48144	37	1	40028	2	1	0	0	0	0	0	
48144	38	1	40029	4	1	0	0	0	0	0	
48144	39	1	40030	2	1	0	0	0	0	0	
48144	40	1	40031	4	1	0	0	0	0	0	
48144	41	1	40032	2	1	0	0	0	0	0	
48144	42	1	40209	2	1	0	0	0	0	0	
48144	43	1	40210	1	1	0	0	0	0	0	
48144	44	1	40211	2	1	0	0	0	0	0	
48144	45	1	40212	1	1	0	0	0	0	0	
48144	46	1	40213	2	1	0	0	0	0	0	
48144	47	1	40214	1	1	0	0	0	0	0	
48144	48	1	40215	2	1	0	0	0	0	0	
48144	49	1	40216	1	1	0	0	0	0	0	
48144	50	1	40217	2	1	0	0	0	0	0	
48144	51	1	40218	1	2	0	0	0	0	0	
48144	52	1	40033	160	2	0	0	0	0	0	
48144	53	1	40034	160	2	0	0	0	0	0	
48144	54	1	40035	95	2	0	0	0	0	0	
48144	55	1	40036	80	2	0	0	0	0	0	
48144	56	1	40037	70	2	0	0	0	0	0	
48144	57	1	40038	160	2	0	0	0	0	0	
48144	58	1	40039	120	2	0	0	0	0	0	
48144	59	1	40104	95	2	0	0	0	0	0	
48144	60	1	40105	80	2.4	0	0	0	0	0	
48144	61	1	40106	70	2.05	0	0	0	0	0	
48145	1	1	28960	1	3	1	0	0	0	0	
48145	2	1	28961	1	7	0	0	0	0	0	
48145	3	1	48907	5	10	0	0	0	0	0	
48145	4	1	36362	5	5	0	0	0	0	0	
48145	5	1	36363	5	5	0	0	0	0	0	
48145	6	1	30007	5	5	0	0	0	0	0	
48145	7	1	30012	5	5	0	0	0	0	0	
48145	8	1	31303	10	7	0	0	0	0	0	
48145	9	1	31304	10	7	0	0	0	0	0	
48145	10	1	31777	15	11.7	0	0	0	0	0	
48145	11	1	31778	15	9.9	0	0	0	0	0	
48145	12	1	31300	5	12	0	0	0	0	0	
48145	13	1	31301	5	12.4	0	0	0	0	0	
48145	1	2	28955	1	100	0	0	0	0	0	
48146	1	1	28958	1	2.5	1	0	0	0	0	
48146	2	1	28959	1	5	0	0	0	0	0	
48146	3	1	48907	5	10	0	0	0	0	0	
48146	4	1	36362	5	5	0	0	0	0	0	
48146	5	1	36363	5	5	0	0	0	0	0	
48146	6	1	30007	5	5	0	0	0	0	0	
48146	7	1	30012	5	5	0	0	0	0	0	
48146	8	1	31303	10	7	0	0	0	0	0	
48146	9	1	31304	10	7	0	0	0	0	0	
48146	10	1	31777	15	13.1	0	0	0	0	0	
48146	11	1	31778	15	12	0	0	0	0	0	
48146	12	1	31300	5	11	0	0	0	0	0	
48146	13	1	31301	5	12.4	0	0	0	0	0	
48146	1	2	28956	1	100	0	0	0	0	0	
48147	1	1	28962	1	1.8	1	0	0	0	0	
48147	2	1	28963	1	4	0	0	0	0	0	
48147	3	1	48907	5	10	0	0	0	0	0	
48147	4	1	36362	5	5	0	0	0	0	0	
48147	5	1	36363	5	5	0	0	0	0	0	
48147	6	1	30007	5	5	0	0	0	0	0	
48147	7	1	30012	5	5	0	0	0	0	0	
48147	8	1	31303	10	7	0	0	0	0	0	
48147	9	1	31304	10	7	0	0	0	0	0	
48147	10	1	31777	15	13	0	0	0	0	0	
48147	11	1	31778	15	13	0	0	0	0	0	
48147	12	1	31300	5	12	0	0	0	0	0	
48147	13	1	31301	5	12.2	0	0	0	0	0	
48147	1	2	28957	1	100	0	0	0	0	0	
48404	1	1	15241	1	100	0	0	0	0	0	
48404	1	2	15242	1	100	0	0	0	0	0	
48405	1	1	15241	1	100	0	0	0	0	0	
48405	1	2	15242	1	100	0	0	0	0	0	
48405	1	3	15243	1	100	0	0	0	0	0	
48405	1	4	15244	1	100	0	0	0	0	0	
48405	1	5	15705	1	100	0	0	0	0	0	
48406	1	1	15241	1	100	0	0	0	0	0	
48406	1	2	15242	1	100	0	0	0	0	0	
48406	1	3	15243	1	100	0	0	0	0	0	
48406	1	4	15244	1	100	0	0	0	0	0	
48406	1	5	15245	1	100	0	0	0	0	0	
48406	1	6	15246	1	100	0	0	0	0	0	
48406	1	7	15705	1	100	0	0	0	0	0	
48407	1	1	15241	1	100	0	0	0	0	0	
48407	1	2	15242	1	100	0	0	0	0	0	
48407	1	3	15243	1	100	0	0	0	0	0	
48407	1	4	15244	1	100	0	0	0	0	0	
48407	1	5	15245	1	100	0	0	0	0	0	
48407	1	6	15246	1	100	0	0	0	0	0	
48407	1	7	15705	1	100	0	0	0	0	0	
48407	1	8	48426	1	100	0	0	0	0	0	
48408	1	1	15176	1	100	0	0	0	0	0	
48408	1	2	15703	1	100	0	0	0	0	0	
48408	1	3	15704	1	100	0	0	0	0	0	
48408	1	4	15248	1	100	0	0	0	0	0	
48408	1	5	24906	1	100	0	0	0	0	0	
48426	1	1	48427	1	100	0	0	0	0	0	
48426	1	2	48428	1	100	0	0	0	0	0	
48426	1	3	48429	1	100	0	0	0	0	0	
48426	1	4	48430	1	100	0	0	0	0	0	
48426	1	5	48431	1	100	0	0	0	0	0	
48409	1	1	15682	1	100	0	0	0	0	0	
48409	1	2	15683	1	100	0	0	0	0	0	
48409	1	3	15684	1	100	0	0	0	0	0	
48409	1	4	15693	1	100	0	0	0	0	0	
48409	1	5	15694	1	100	0	0	0	0	0	
48409	1	6	15695	1	100	0	0	0	0	0	
48409	1	7	15696	1	100	0	0	0	0	0	
48409	1	8	15697	1	100	0	0	0	0	0	
48410	1	1	15685	1	100	0	0	0	0	0	
48410	1	2	15686	1	100	0	0	0	0	0	
48410	1	3	24842	250	100	0	0	0	0	0	
48410	1	4	24851	250	100	0	0	0	0	0	
48410	1	5	15693	1	100	0	0	0	0	0	
48410	1	6	15694	1	100	0	0	0	0	0	
48410	1	7	15695	1	100	0	0	0	0	0	
48410	1	8	15696	1	100	0	0	0	0	0	
48410	1	9	15697	1	100	0	0	0	0	0	
48411	1	1	15687	1	100	0	0	0	0	0	
48411	1	2	15689	1	100	0	0	0	0	0	
48411	1	3	15693	1	100	0	0	0	0	0	
48411	1	4	15694	1	100	0	0	0	0	0	
48411	1	5	15695	1	100	0	0	0	0	0	
48411	1	6	15696	1	100	0	0	0	0	0	
48411	1	7	15697	1	100	0	0	0	0	0	
48412	1	1	15688	1	100	0	0	0	0	0	
48412	1	2	15690	1	100	0	0	0	0	0	
48412	1	3	15693	1	100	0	0	0	0	0	
48412	1	4	15694	1	100	0	0	0	0	0	
48412	1	5	15695	1	100	0	0	0	0	0	
48412	1	6	15696	1	100	0	0	0	0	0	
48412	1	7	15697	1	100	0	0	0	0	0	
48413	1	1	15691	1	100	0	0	0	0	0	
48413	1	2	15692	1	100	0	0	0	0	0	
48413	1	3	24819	250	100	0	0	0	0	0	
48413	1	4	15693	1	100	0	0	0	0	0	
48413	1	5	15694	1	100	0	0	0	0	0	
48413	1	6	15695	1	100	0	0	0	0	0	
48413	1	7	15696	1	100	0	0	0	0	0	
48413	1	8	15697	1	100	0	0	0	0	0	
48100	1	1	37978	1	100	1	0	0	0	0	
48100	2	2	48699	1	0.1	1	0	0	0	0	
48100	3	2	40022	10	8.9	0	0	0	0	0	
48100	4	2	48101	1	4	1	0	0	0	0	
48100	5	2	40274	1	5	1	0	0	0	0	
48100	6	2	40037	20	32	0	0	0	0	0	
48100	7	2	40106	20	32	0	0	0	0	0	
48100	8	2	40111	20	18	0	0	0	0	0	
49346	2	1	40276	1	7	0	0	0	0	0	
49346	3	1	40277	1	7	0	0	0	0	0	
49346	4	1	40279	1	7	0	0	0	0	0	
49346	5	1	40280	1	6	0	0	0	0	0	
49346	6	1	40281	1	6	0	0	0	0	0	
49346	7	1	40282	1	6	0	0	0	0	0	
49346	8	1	40283	1	6	0	0	0	0	0	
49346	9	1	40284	1	6	0	0	0	0	0	
49346	10	1	40285	1	6	0	0	0	0	0	
49346	11	1	40286	1	6	0	0	0	0	0	
49346	12	1	40287	1	6	0	0	0	0	0	
49346	13	1	40288	1	6	0	0	0	0	0	
49346	14	1	40289	1	6	0	0	0	0	0	
49346	15	1	40290	1	6	0	0	0	0	0	
49346	16	1	40291	1	6	0	0	0	0	0	
49347	1	1	41421	1	8	0	0	0	0	0	
49347	2	1	41422	1	8	0	0	0	0	0	
49347	3	1	41423	1	8	0	0	0	0	0	
49347	4	1	41424	1	8	0	0	0	0	0	
49347	5	1	41425	1	8	0	0	0	0	0	
49347	6	1	41426	1	8	0	0	0	0	0	
49347	7	1	41447	1	8	0	0	0	0	0	
49347	8	1	41448	1	8	0	0	0	0	0	
49347	9	1	41449	1	8	0	0	0	0	0	
49347	10	1	41450	1	7	0	0	0	0	0	
49347	11	1	41451	1	7	0	0	0	0	0	
49347	12	1	41452	1	7	0	0	0	0	0	
49347	13	1	41453	1	7	0	0	0	0	0	
49056	1	1	40194	1	2	0	0	0	0	0	
49056	2	1	40195	1	1	0	0	0	0	0	
49056	3	1	40196	1	1	0	0	0	0	0	
49056	4	1	40232	1	1	0	0	0	0	0	
49056	5	1	40375	1	0.5	0	0	0	0	0	
49056	6	1	40383	1	21.5	0	0	0	0	0	
49056	7	1	40384	1	22	0	0	0	0	0	
49056	5	1	40397	1	7	0	0	0	0	0	
49056	8	1	40398	1	22	0	0	0	0	0	
49056	9	1	40382	1	22	0	0	0	0	0	
49438	1	1	42426	1	1.25	1	0	0	0	0	
49438	2	1	42427	1	0.5	0	0	0	0	0	
49438	3	1	42430	1	1.25	1	0	0	0	0	
49438	4	1	42431	1	0.5	0	0	0	0	0	
49438	5	1	40317	1	2	0	0	0	0	0	
49438	6	1	40367	1	2	0	0	0	0	0	
49438	7	1	40022	2	2	0	0	0	0	0	
49438	8	1	40200	4	5	0	0	0	0	0	
49438	9	1	40201	1	4	0	0	0	0	0	
49438	10	1	41089	1	4	0	0	0	0	0	
49438	11	1	40040	12	22	0	0	0	0	0	
49438	12	1	40042	5	22	0	0	0	0	0	
49438	13	1	41090	45	16.75	0	0	0	0	0	
49438	14	1	40509	3	16.75	0	0	0	0	0	
49439	1	1	40169	1	5	1	0	0	0	0	
49439	2	1	40180	1	2.5	0	0	0	0	0	
49439	3	1	41300	1	1	0	0	0	0	0	
49439	4	1	40184	2	5	0	0	0	0	0	
49439	5	1	40021	3	3	0	0	0	0	0	
49439	6	1	41297	60	25	0	0	0	0	0	
49439	7	1	41298	60	25	0	0	0	0	0	
49439	8	1	40156	4	18.5	0	0	0	0	0	
49439	9	1	40181	3	5	0	0	0	0	0	
49439	10	1	40122	10	5	0	0	0	0	0	
49439	11	1	40380	1	2.5	0	0	0	0	0	
49439	12	1	40115	1	2.5	0	0	0	0	0	
49440	1	1	42413	1	1.5	1	0	0	0	0	
49440	2	1	42414	1	0.75	0	0	0	0	0	
49440	3	1	41193	1	1	0	0	0	0	0	
49440	4	1	41304	1	0.5	0	0	0	0	0	
49440	5	1	41189	1	1.5	0	0	0	0	0	
49440	6	1	41303	1	1	0	0	0	0	0	
49440	7	1	40021	3	3	0	0	0	0	0	
49440	8	1	40122	10	5	0	0	0	0	0	
49440	9	1	40183	22	12	0	0	0	0	0	
49440	10	1	41297	60	28	0	0	0	0	0	
49440	11	1	41298	60	28	0	0	0	0	0	
49440	12	1	40572	1	17.75	0	0	0	0	0	
49441	1	1	40991	1	1.5	1	0	0	0	0	
49441	2	1	40993	1	0.75	0	0	0	0	0	
49441	3	1	40994	1	1	1	0	0	0	0	
49441	4	1	40996	1	0.5	0	0	0	0	0	
49441	5	1	41197	1	0.5	0	0	0	0	0	
49441	6	1	41305	1	0.4	0	0	0	0	0	
49441	7	1	40022	2	2	0	0	0	0	0	
49441	8	1	41493	1	2	0	0	0	0	0	
49441	9	1	41542	1	10.35	0	0	0	0	0	
49441	10	1	49290	1	16	0	0	0	0	0	
49441	11	1	40157	2	10	0	0	0	0	0	
49441	12	1	40182	2	5	0	0	0	0	0	
49441	13	1	40040	12	25	0	0	0	0	0	
49441	14	1	40042	5	25	0	0	0	0	0	
49442	1	1	42486	1	1.25	1	0	0	0	0	
49442	2	1	42487	1	0.75	0	0	0	0	0	
49442	3	1	42478	1	1	1	0	0	0	0	
49442	4	1	42479	1	0.5	0	0	0	0	0	
49442	5	1	40317	1	2	0	0	0	0	0	
49442	6	1	40367	1	2	0	0	0	0	0	
49442	7	1	40022	2	2	0	0	0	0	0	
49442	8	1	40200	4	5	0	0	0	0	0	
49442	9	1	40201	1	4	0	0	0	0	0	
49442	10	1	41089	1	4	0	0	0	0	0	
49442	11	1	40040	12	22	0	0	0	0	0	
49442	12	1	40042	5	22	0	0	0	0	0	
49442	13	1	41090	45	16.75	0	0	0	0	0	
49442	14	1	40509	3	16.75	0	0	0	0	0	
49443	1	1	42486	1	1.25	1	0	0	0	0	
49443	2	1	42487	1	0.75	0	0	0	0	0	
49443	3	1	42482	1	1	1	0	0	0	0	
49443	4	1	42483	1	0.5	0	0	0	0	0	
49443	5	1	40317	1	2	0	0	0	0	0	
49443	6	1	40367	1	2	0	0	0	0	0	
49443	7	1	40022	2	2	0	0	0	0	0	
49443	8	1	40200	4	5	0	0	0	0	0	
49443	9	1	40201	1	4	0	0	0	0	0	
49443	10	1	41089	1	4	0	0	0	0	0	
49443	11	1	40040	12	22	0	0	0	0	0	
49443	12	1	40042	5	22	0	0	0	0	0	
49443	13	1	41090	45	16.75	0	0	0	0	0	
49443	14	1	40509	3	16.75	0	0	0	0	0	
49646	1	1	49323	120	100	0	0	0	0	0	
49444	1	1	40467	1	2	1	0	0	0	0	
49444	2	1	40468	1	1	0	0	0	0	0	
49444	3	1	41300	1	1	0	0	0	0	0	
49444	4	1	40184	2	5	0	0	0	0	0	
49444	5	1	40021	3	3	0	0	0	0	0	
49444	6	1	41297	60	26	0	0	0	0	0	
49444	7	1	41298	60	26	0	0	0	0	0	
49444	8	1	40156	4	21	0	0	0	0	0	
49444	9	1	40181	3	5	0	0	0	0	0	
49444	10	1	40122	10	5	0	0	0	0	0	
49444	11	1	40380	1	2.5	0	0	0	0	0	
49444	12	1	40115	1	2.5	0	0	0	0	0	
49445	1	1	42409	1	1.5	1	0	0	0	0	
49445	2	1	42410	1	0.75	0	0	0	0	0	
49445	3	1	41193	1	1	0	0	0	0	0	
49445	4	1	41304	1	0.5	0	0	0	0	0	
49445	5	1	41189	1	1.5	0	0	0	0	0	
49445	6	1	41303	1	1	0	0	0	0	0	
49445	7	1	40021	3	3	0	0	0	0	0	
49445	8	1	40122	10	5	0	0	0	0	0	
49445	9	1	40183	22	12	0	0	0	0	0	
49445	10	1	41297	60	28	0	0	0	0	0	
49445	11	1	41298	60	28	0	0	0	0	0	
49445	12	1	40572	1	17.75	0	0	0	0	0	
49446	1	1	41324	1	1.5	1	0	0	0	0	
49446	2	1	41325	1	0.75	0	0	0	0	0	
49446	3	1	41340	1	1	1	0	0	0	0	
49446	4	1	41341	1	0.5	0	0	0	0	0	
49446	5	1	41197	1	0.5	0	0	0	0	0	
49446	6	1	41305	1	0.4	0	0	0	0	0	
49446	7	1	40022	2	2	0	0	0	0	0	
49446	8	1	41493	1	2	0	0	0	0	0	
49446	9	1	41542	1	10.35	0	0	0	0	0	
49446	10	1	49290	1	16	0	0	0	0	0	
49446	11	1	40157	2	10	0	0	0	0	0	
49446	12	1	40182	2	5	0	0	0	0	0	
49446	13	1	40040	12	25	0	0	0	0	0	
49446	14	1	40042	5	25	0	0	0	0	0	
49447	1	1	41519	1	2	1	0	0	0	0	
49447	2	1	41520	1	1	0	0	0	0	0	
49447	3	1	41523	1	1	1	0	0	0	0	
49447	4	1	41524	1	0.5	0	0	0	0	0	
49447	5	1	41197	1	0.5	0	0	0	0	0	
49447	6	1	41305	1	0.4	0	0	0	0	0	
49447	7	1	40022	2	2	0	0	0	0	0	
49447	8	1	41493	1	2	0	0	0	0	0	
49447	9	1	41542	1	9.6	0	0	0	0	0	
49447	10	1	49290	1	16	0	0	0	0	0	
49447	11	1	40157	2	10	0	0	0	0	0	
49447	12	1	40182	2	5	0	0	0	0	0	
49447	13	1	40040	12	25	0	0	0	0	0	
49447	14	1	40042	5	25	0	0	0	0	0	
49448	1	1	40129	1	0.5	0	0	0	0	0	
49448	2	1	40278	1	1	0	0	0	0	0	
49448	3	1	48897	1	10	0	0	0	0	0	
49448	4	1	48898	1	10	0	0	0	0	0	
49448	5	1	48899	1	10	0	0	0	0	0	
49448	6	1	48900	1	10	0	0	0	0	0	
49448	7	1	48904	1	4	0	0	0	0	0	
49448	8	1	40300	1	8.4	0	0	0	0	0	
49448	9	1	40452	1	6	0	0	0	0	0	
49448	10	1	40450	1	5	0	0	0	0	0	
49448	11	1	40299	1	10	0	0	0	0	0	
49448	12	1	48969	10	15	0	0	0	0	0	
49448	13	1	40449	2	10	0	0	0	0	0	
49448	14	1	48953	1	0.0998	0	0	0	0	0	
49448	15	1	48945	1	0.0001	0	0	0	0	0	
49448	16	1	41352	1	0.0001	0	0	0	0	0	
49448	1	2	41106	7	100	0	0	0	0	0	
49448	1	3	41107	4	100	0	0	0	0	0	
49592	1	1	44186	1	100	0	0	0	0	0	
49592	1	2	44187	1	100	0	0	0	0	0	
49592	1	3	44188	1	100	0	0	0	0	0	
49592	1	4	44189	1	100	0	0	0	0	0	
49592	1	5	44190	1	100	0	0	0	0	0	
49464	1	1	40311	1	2.5	0	0	0	0	0	
49464	2	1	42285	1	20	0	0	0	0	0	
49464	3	1	42286	1	20	0	0	0	0	0	
49464	4	1	42287	1	20	0	0	0	0	0	
49464	5	1	40455	3	16	0	0	0	0	0	
49464	6	1	40456	2	12	0	0	0	0	0	
49464	7	1	40457	1	6	0	0	0	0	0	
49464	8	1	40458	1	3.4	0	0	0	0	0	
49464	9	1	48953	1	0.0998	0	0	0	0	0	
49464	10	1	48945	1	0.0001	0	0	0	0	0	
49464	11	1	48915	1	0.0001	0	0	0	0	0	
49464	1	2	48956	1	100	0	0	0	0	0	
49489	1	1	49281	1	8	0	0	0	0	0	
49489	2	1	49165	1	8	0	0	0	0	0	
49489	3	1	49289	1	8	0	0	0	0	0	
49489	4	1	49330	1	8	0	0	0	0	0	
49489	5	1	49332	1	7.8	0	0	0	0	0	
49489	6	1	49174	1	8	0	0	0	0	0	
49489	7	1	49269	1	0.2	1	0	0	0	0	
49489	8	1	49255	1	6	0	0	0	0	0	
49489	9	1	49257	1	5	0	0	0	0	0	
49489	10	1	49317	1	5	0	0	0	0	0	
49489	11	1	49167	1	4	0	0	0	0	0	
49489	12	1	49171	1	4	0	0	0	0	0	
49489	13	1	49192	1	4	0	0	0	0	0	
49489	14	1	49251	1	6	0	0	0	0	0	
49489	15	1	49318	1	5	0	0	0	0	0	
49489	16	1	49319	1	5	0	0	0	0	0	
49489	17	1	49311	1	4	0	0	0	0	0	
49489	18	1	49005	1	4	0	0	0	0	0	
48332	1	1	16597	1	100	0	0	0	0	0	
48332	2	2	16598	1	100	0	0	0	0	0	
48332	3	3	16599	1	100	0	0	0	0	0	
48332	4	4	16600	1	100	0	0	0	0	0	
48332	5	5	16601	1	100	0	0	0	0	0	
48333	1	1	16602	1	100	0	0	0	0	0	
48333	2	2	16603	1	100	0	0	0	0	0	
48333	3	3	16604	1	100	0	0	0	0	0	
48333	4	4	16605	1	100	0	0	0	0	0	
48333	5	5	16606	1	100	0	0	0	0	0	
48334	1	1	16607	1	100	0	0	0	0	0	
48334	2	2	16608	1	100	0	0	0	0	0	
48334	3	3	16609	1	100	0	0	0	0	0	
48334	4	4	16610	1	100	0	0	0	0	0	
48334	5	5	16611	1	100	0	0	0	0	0	
48335	1	1	16612	1	100	0	0	0	0	0	
48335	2	2	16613	1	100	0	0	0	0	0	
48335	3	3	16614	1	100	0	0	0	0	0	
48335	4	4	16615	1	100	0	0	0	0	0	
48335	5	5	16616	1	100	0	0	0	0	0	
48336	1	1	16617	1	100	0	0	0	0	0	
48336	2	2	16618	1	100	0	0	0	0	0	
48336	3	3	16619	1	100	0	0	0	0	0	
48336	4	4	16620	1	100	0	0	0	0	0	
48336	5	5	16621	1	100	0	0	0	0	0	
48337	1	1	16622	1	100	0	0	0	0	0	
48337	2	2	16623	1	100	0	0	0	0	0	
48337	3	3	16624	1	100	0	0	0	0	0	
48337	4	4	16625	1	100	0	0	0	0	0	
48337	5	5	16626	1	100	0	0	0	0	0	
48338	1	1	16627	1	100	0	0	0	0	0	
48338	2	2	16628	1	100	0	0	0	0	0	
48338	3	3	16629	1	100	0	0	0	0	0	
48338	4	4	16630	1	100	0	0	0	0	0	
48338	5	5	16631	1	100	0	0	0	0	0	
48339	1	1	16632	1	100	0	0	0	0	0	
48339	2	2	16633	1	100	0	0	0	0	0	
48339	3	3	16634	1	100	0	0	0	0	0	
48339	4	4	16635	1	100	0	0	0	0	0	
48339	5	5	16636	1	100	0	0	0	0	0	
48340	1	1	16637	1	100	0	0	0	0	0	
48340	2	2	16638	1	100	0	0	0	0	0	
48340	3	3	16639	1	100	0	0	0	0	0	
48340	4	4	16640	1	100	0	0	0	0	0	
48340	5	5	16641	1	100	0	0	0	0	0	
48341	1	1	16642	1	100	0	0	0	0	0	
48341	2	2	16643	1	100	0	0	0	0	0	
48341	3	3	16644	1	100	0	0	0	0	0	
48341	4	4	16645	1	100	0	0	0	0	0	
48341	5	5	16646	1	100	0	0	0	0	0	
48342	1	1	16647	1	100	0	0	0	0	0	
48342	2	2	16648	1	100	0	0	0	0	0	
48342	3	3	16649	1	100	0	0	0	0	0	
48342	4	4	16650	1	100	0	0	0	0	0	
48342	5	5	16651	1	100	0	0	0	0	0	
48343	1	1	16652	1	100	0	0	0	0	0	
48343	2	2	16653	1	100	0	0	0	0	0	
48343	3	3	16654	1	100	0	0	0	0	0	
48343	4	4	16655	1	100	0	0	0	0	0	
48343	5	5	16656	1	100	0	0	0	0	0	
48344	1	1	16657	1	100	0	0	0	0	0	
48344	2	2	16658	1	100	0	0	0	0	0	
48344	3	3	16659	1	100	0	0	0	0	0	
48344	4	4	16660	1	100	0	0	0	0	0	
48344	5	5	16661	1	100	0	0	0	0	0	
48345	1	1	16662	1	100	0	0	0	0	0	
48345	2	2	16663	1	100	0	0	0	0	0	
48345	3	3	16664	1	100	0	0	0	0	0	
48345	4	4	16665	1	100	0	0	0	0	0	
48345	5	5	16666	1	100	0	0	0	0	0	
48346	1	1	16667	1	100	0	0	0	0	0	
48346	2	2	16668	1	100	0	0	0	0	0	
48346	3	3	16669	1	100	0	0	0	0	0	
48346	4	4	16670	1	100	0	0	0	0	0	
48346	5	5	16671	1	100	0	0	0	0	0	
48347	1	1	16672	1	100	0	0	0	0	0	
48347	2	2	16673	1	100	0	0	0	0	0	
48347	3	3	16674	1	100	0	0	0	0	0	
48347	4	4	16675	1	100	0	0	0	0	0	
48347	5	5	16676	1	100	0	0	0	0	0	
48348	1	1	16677	1	100	0	0	0	0	0	
48348	2	2	16678	1	100	0	0	0	0	0	
48348	3	3	16679	1	100	0	0	0	0	0	
48348	4	4	16680	1	100	0	0	0	0	0	
48348	5	5	16681	1	100	0	0	0	0	0	
48349	1	1	16682	1	100	0	0	0	0	0	
48349	2	2	16683	1	100	0	0	0	0	0	
48349	3	3	16684	1	100	0	0	0	0	0	
48349	4	4	16685	1	100	0	0	0	0	0	
48349	5	5	16686	1	100	0	0	0	0	0	
48350	1	1	16687	1	100	0	0	0	0	0	
48350	2	2	16688	1	100	0	0	0	0	0	
48350	3	3	16689	1	100	0	0	0	0	0	
48350	4	4	16690	1	100	0	0	0	0	0	
48350	5	5	16691	1	100	0	0	0	0	0	
48351	1	1	16692	1	100	0	0	0	0	0	
48351	2	2	16693	1	100	0	0	0	0	0	
48351	3	3	16694	1	100	0	0	0	0	0	
48351	4	4	16695	1	100	0	0	0	0	0	
48351	5	5	16696	1	100	0	0	0	0	0	
48352	1	1	16697	1	100	0	0	0	0	0	
48352	2	2	16698	1	100	0	0	0	0	0	
48352	3	3	16699	1	100	0	0	0	0	0	
48352	4	4	16700	1	100	0	0	0	0	0	
48352	5	5	16701	1	100	0	0	0	0	0	
48353	1	1	16702	1	100	0	0	0	0	0	
48353	2	2	16703	1	100	0	0	0	0	0	
48353	3	3	16704	1	100	0	0	0	0	0	
48353	4	4	16705	1	100	0	0	0	0	0	
48353	5	5	16706	1	100	0	0	0	0	0	
48354	1	1	16707	1	100	0	0	0	0	0	
48354	2	2	16708	1	100	0	0	0	0	0	
48354	3	3	16709	1	100	0	0	0	0	0	
48354	4	4	16710	1	100	0	0	0	0	0	
48354	5	5	16711	1	100	0	0	0	0	0	
48355	1	1	16712	1	100	0	0	0	0	0	
48355	2	2	16713	1	100	0	0	0	0	0	
48355	3	3	16714	1	100	0	0	0	0	0	
48355	4	4	16715	1	100	0	0	0	0	0	
48355	5	5	16716	1	100	0	0	0	0	0	
48356	1	1	16717	1	100	0	0	0	0	0	
48356	2	2	16718	1	100	0	0	0	0	0	
48356	3	3	16719	1	100	0	0	0	0	0	
48356	4	4	16720	1	100	0	0	0	0	0	
48356	5	5	16721	1	100	0	0	0	0	0	
48357	1	1	16722	1	100	0	0	0	0	0	
48357	2	2	16723	1	100	0	0	0	0	0	
48357	3	3	16724	1	100	0	0	0	0	0	
48357	4	4	16725	1	100	0	0	0	0	0	
48357	5	5	16726	1	100	0	0	0	0	0	
48358	1	1	16727	1	100	0	0	0	0	0	
48358	2	2	16728	1	100	0	0	0	0	0	
48358	3	3	16729	1	100	0	0	0	0	0	
48358	4	4	16730	1	100	0	0	0	0	0	
48358	5	5	16731	1	100	0	0	0	0	0	
48359	1	1	16732	1	100	0	0	0	0	0	
48359	2	2	16733	1	100	0	0	0	0	0	
48359	3	3	16734	1	100	0	0	0	0	0	
48359	4	4	16735	1	100	0	0	0	0	0	
48359	5	5	16736	1	100	0	0	0	0	0	
48360	1	1	16737	1	100	0	0	0	0	0	
48360	2	2	16738	1	100	0	0	0	0	0	
48360	3	3	16739	1	100	0	0	0	0	0	
48360	4	4	16740	1	100	0	0	0	0	0	
48360	5	5	16741	1	100	0	0	0	0	0	
48361	1	1	16742	1	100	0	0	0	0	0	
48361	2	2	16743	1	100	0	0	0	0	0	
48361	3	3	16744	1	100	0	0	0	0	0	
48361	4	4	16745	1	100	0	0	0	0	0	
48361	5	5	16746	1	100	0	0	0	0	0	
48362	1	1	16747	1	100	0	0	0	0	0	
48362	2	2	16748	1	100	0	0	0	0	0	
48362	3	3	16749	1	100	0	0	0	0	0	
48362	4	4	16750	1	100	0	0	0	0	0	
48362	5	5	16751	1	100	0	0	0	0	0	
48363	1	1	16752	1	100	0	0	0	0	0	
48363	2	2	16753	1	100	0	0	0	0	0	
48363	3	3	16754	1	100	0	0	0	0	0	
48363	4	4	16755	1	100	0	0	0	0	0	
48363	5	5	16756	1	100	0	0	0	0	0	
48364	1	1	16757	1	100	0	0	0	0	0	
48364	2	2	16758	1	100	0	0	0	0	0	
48364	3	3	16759	1	100	0	0	0	0	0	
48364	4	4	16760	1	100	0	0	0	0	0	
48364	5	5	16761	1	100	0	0	0	0	0	
48365	1	1	16762	1	100	0	0	0	0	0	
48365	2	2	16763	1	100	0	0	0	0	0	
48365	3	3	16764	1	100	0	0	0	0	0	
48365	4	4	16765	1	100	0	0	0	0	0	
48365	5	5	16766	1	100	0	0	0	0	0	
48366	1	1	16767	1	100	0	0	0	0	0	
48366	2	2	16768	1	100	0	0	0	0	0	
48366	3	3	16769	1	100	0	0	0	0	0	
48366	4	4	16770	1	100	0	0	0	0	0	
48366	5	5	16771	1	100	0	0	0	0	0	
48367	1	1	16772	1	100	0	0	0	0	0	
48367	2	2	16773	1	100	0	0	0	0	0	
48367	3	3	16774	1	100	0	0	0	0	0	
48367	4	4	16775	1	100	0	0	0	0	0	
48367	5	5	16776	1	100	0	0	0	0	0	
48368	1	1	16777	1	100	0	0	0	0	0	
48368	2	2	16778	1	100	0	0	0	0	0	
48368	3	3	16779	1	100	0	0	0	0	0	
48368	4	4	16780	1	100	0	0	0	0	0	
48368	5	5	16781	1	100	0	0	0	0	0	
48369	1	1	16782	1	100	0	0	0	0	0	
48369	2	2	16783	1	100	0	0	0	0	0	
48369	3	3	16784	1	100	0	0	0	0	0	
48369	4	4	16785	1	100	0	0	0	0	0	
48369	5	5	16786	1	100	0	0	0	0	0	
48370	1	1	16787	1	100	0	0	0	0	0	
48370	2	2	16788	1	100	0	0	0	0	0	
48370	3	3	16789	1	100	0	0	0	0	0	
48370	4	4	16790	1	100	0	0	0	0	0	
48370	5	5	16791	1	100	0	0	0	0	0	
48371	1	1	16792	1	100	0	0	0	0	0	
48371	2	2	16793	1	100	0	0	0	0	0	
48371	3	3	16794	1	100	0	0	0	0	0	
48371	4	4	16795	1	100	0	0	0	0	0	
48371	5	5	16796	1	100	0	0	0	0	0	
48372	1	1	16797	1	100	0	0	0	0	0	
48372	2	2	16798	1	100	0	0	0	0	0	
48372	3	3	16799	1	100	0	0	0	0	0	
48372	4	4	16800	1	100	0	0	0	0	0	
48372	5	5	16801	1	100	0	0	0	0	0	
48373	1	1	16802	1	100	0	0	0	0	0	
48373	2	2	16803	1	100	0	0	0	0	0	
48373	3	3	16804	1	100	0	0	0	0	0	
48373	4	4	16805	1	100	0	0	0	0	0	
48373	5	5	16806	1	100	0	0	0	0	0	
48374	1	1	16807	1	100	0	0	0	0	0	
48374	2	2	16808	1	100	0	0	0	0	0	
48374	3	3	16809	1	100	0	0	0	0	0	
48374	4	4	16810	1	100	0	0	0	0	0	
48374	5	5	16811	1	100	0	0	0	0	0	
48375	1	1	16812	1	100	0	0	0	0	0	
48375	2	2	16813	1	100	0	0	0	0	0	
48375	3	3	16814	1	100	0	0	0	0	0	
48375	4	4	16815	1	100	0	0	0	0	0	
48375	5	5	16816	1	100	0	0	0	0	0	
48376	1	1	16817	1	100	0	0	0	0	0	
48376	2	2	16818	1	100	0	0	0	0	0	
48376	3	3	16819	1	100	0	0	0	0	0	
48376	4	4	16820	1	100	0	0	0	0	0	
48376	5	5	16821	1	100	0	0	0	0	0	
48158	1	1	13922	1	100	0	0	0	0	0	
48158	2	2	13923	1	100	0	0	0	0	0	
48158	3	3	13924	1	100	0	0	0	0	0	
48158	4	4	13925	1	100	0	0	0	0	0	
48158	5	5	13926	1	100	0	0	0	0	0	
48159	1	1	13912	1	100	0	0	0	0	0	
48159	2	2	13913	1	100	0	0	0	0	0	
48159	3	3	13914	1	100	0	0	0	0	0	
48159	4	4	13915	1	100	0	0	0	0	0	
48159	5	5	13916	1	100	0	0	0	0	0	
48160	1	1	13917	1	100	0	0	0	0	0	
48160	2	2	13918	1	100	0	0	0	0	0	
48160	3	3	13919	1	100	0	0	0	0	0	
48160	4	4	13920	1	100	0	0	0	0	0	
48160	5	5	13921	1	100	0	0	0	0	0	
48161	1	1	13960	1	100	0	0	0	0	0	
48161	2	2	13961	1	100	0	0	0	0	0	
48161	3	3	13962	1	100	0	0	0	0	0	
48161	4	4	13963	1	100	0	0	0	0	0	
48161	5	5	13964	1	100	0	0	0	0	0	
48162	1	1	13965	1	100	0	0	0	0	0	
48162	2	2	13966	1	100	0	0	0	0	0	
48162	3	3	13967	1	100	0	0	0	0	0	
48162	4	4	13968	1	100	0	0	0	0	0	
48162	5	5	13969	1	100	0	0	0	0	0	
48163	1	1	13258	1	100	0	0	0	0	0	
48163	2	2	13259	1	100	0	0	0	0	0	
48163	3	3	13260	1	100	0	0	0	0	0	
48163	4	4	13261	1	100	0	0	0	0	0	
48163	5	5	13262	1	100	0	0	0	0	0	
48164	1	1	13263	1	100	0	0	0	0	0	
48164	2	2	13264	1	100	0	0	0	0	0	
48164	3	3	13265	1	100	0	0	0	0	0	
48164	4	4	13266	1	100	0	0	0	0	0	
48164	5	5	13267	1	100	0	0	0	0	0	
48165	1	1	13228	1	100	0	0	0	0	0	
48165	2	2	13229	1	100	0	0	0	0	0	
48165	3	3	13230	1	100	0	0	0	0	0	
48165	4	4	13231	1	100	0	0	0	0	0	
48165	5	5	13232	1	100	0	0	0	0	0	
48166	1	1	13233	1	100	0	0	0	0	0	
48166	2	2	13234	1	100	0	0	0	0	0	
48166	3	3	13235	1	100	0	0	0	0	0	
48166	4	4	13236	1	100	0	0	0	0	0	
48166	5	5	13237	1	100	0	0	0	0	0	
48167	1	1	13183	1	100	0	0	0	0	0	
48167	2	2	13184	1	100	0	0	0	0	0	
48167	3	3	13185	1	100	0	0	0	0	0	
48167	4	4	13186	1	100	0	0	0	0	0	
48167	5	5	13187	1	100	0	0	0	0	0	
48168	1	1	13188	1	100	0	0	0	0	0	
48168	2	2	13189	1	100	0	0	0	0	0	
48168	3	3	13190	1	100	0	0	0	0	0	
48168	4	4	13191	1	100	0	0	0	0	0	
48168	5	5	13192	1	100	0	0	0	0	0	
48169	1	1	13193	1	100	0	0	0	0	0	
48169	2	2	13194	1	100	0	0	0	0	0	
48169	3	3	13195	1	100	0	0	0	0	0	
48169	4	4	13196	1	100	0	0	0	0	0	
48169	5	5	13197	1	100	0	0	0	0	0	
48170	1	1	13198	1	100	0	0	0	0	0	
48170	2	2	13199	1	100	0	0	0	0	0	
48170	3	3	13200	1	100	0	0	0	0	0	
48170	4	4	13201	1	100	0	0	0	0	0	
48170	5	5	13202	1	100	0	0	0	0	0	
48171	1	1	13203	1	100	0	0	0	0	0	
48171	2	2	13204	1	100	0	0	0	0	0	
48171	3	3	13205	1	100	0	0	0	0	0	
48171	4	4	13206	1	100	0	0	0	0	0	
48171	5	5	13207	1	100	0	0	0	0	0	
48172	1	1	13208	1	100	0	0	0	0	0	
48172	2	2	13209	1	100	0	0	0	0	0	
48172	3	3	13210	1	100	0	0	0	0	0	
48172	4	4	13211	1	100	0	0	0	0	0	
48172	5	5	13212	1	100	0	0	0	0	0	
48173	1	1	13213	1	100	0	0	0	0	0	
48173	2	2	13214	1	100	0	0	0	0	0	
48173	3	3	13215	1	100	0	0	0	0	0	
48173	4	4	13216	1	100	0	0	0	0	0	
48173	5	5	13217	1	100	0	0	0	0	0	
48174	1	1	13218	1	100	0	0	0	0	0	
48174	2	2	13219	1	100	0	0	0	0	0	
48174	3	3	13220	1	100	0	0	0	0	0	
48174	4	4	13221	1	100	0	0	0	0	0	
48174	5	5	13222	1	100	0	0	0	0	0	
48175	1	1	13223	1	100	0	0	0	0	0	
48175	2	2	13224	1	100	0	0	0	0	0	
48175	3	3	13225	1	100	0	0	0	0	0	
48175	4	4	13226	1	100	0	0	0	0	0	
48175	5	5	13227	1	100	0	0	0	0	0	
48191	1	1	48194	1	100	0	0	0	0	0	
48191	1	2	48195	1	100	0	0	0	0	0	
48192	1	1	48197	1	100	0	0	0	0	0	
48192	1	2	48198	1	100	0	0	0	0	0	
48193	1	1	48200	1	100	0	0	0	0	0	
48193	1	2	48201	1	100	0	0	0	0	0	
48206	1	1	14696	1	100	0	0	0	0	0	
48206	1	2	14697	1	100	0	0	0	0	0	
48206	1	3	14698	1	100	0	0	0	0	0	
48207	1	1	14700	1	100	0	0	0	0	0	
48207	1	2	14701	1	100	0	0	0	0	0	
48207	1	3	14702	1	100	0	0	0	0	0	
48207	1	4	14703	1	100	0	0	0	0	0	
48208	1	1	14704	1	100	0	0	0	0	0	
48208	1	2	14705	1	100	0	0	0	0	0	
48208	1	3	14706	1	100	0	0	0	0	0	
48208	1	4	14707	1	100	0	0	0	0	0	
48209	1	1	12608	1	100	0	0	0	0	0	
48209	1	2	12614	1	100	0	0	0	0	0	
48209	1	3	31601	20	100	0	0	0	0	0	
48209	1	4	31620	2	100	0	0	0	0	0	
48210	1	1	14153	1	100	0	0	0	0	0	
48210	1	2	14041	1	100	0	0	0	0	0	
48211	1	1	14696	1	100	0	0	0	0	0	
48211	1	2	14697	1	100	0	0	0	0	0	
48211	1	3	14698	1	100	0	0	0	0	0	
48211	1	4	14699	1	100	0	0	0	0	0	
48212	1	1	14700	1	100	0	0	0	0	0	
48212	1	2	14701	1	100	0	0	0	0	0	
48212	1	3	14702	1	100	0	0	0	0	0	
48212	1	4	14703	1	100	0	0	0	0	0	
48213	1	1	14704	1	100	0	0	0	0	0	
48213	1	2	14705	1	100	0	0	0	0	0	
48213	1	3	14706	1	100	0	0	0	0	0	
48213	1	4	14707	1	100	0	0	0	0	0	
48154	1	1	14035	1	100	0	0	0	0	0	
48154	1	2	14036	1	100	0	0	0	0	0	
48154	1	3	15693	1	100	0	0	0	0	0	
48154	1	4	15694	1	100	0	0	0	0	0	
48154	1	5	15695	1	100	0	0	0	0	0	
48154	1	6	15696	1	100	0	0	0	0	0	
48154	1	7	15697	1	100	0	0	0	0	0	
47882	1	1	47156	1	33.3	0	0	0	0	0	
47882	2	1	47157	1	33.4	0	0	0	0	0	
47882	3	1	47158	1	33.3	0	0	0	0	0	
48149	1	1	13922	1	100	0	0	0	0	0	
48149	2	2	13923	1	100	0	0	0	0	0	
48149	3	3	13924	1	100	0	0	0	0	0	
48149	4	4	13925	1	100	0	0	0	0	0	
48149	5	5	13926	1	100	0	0	0	0	0	
48453	1	1	40451	1	100	0	0	0	0	0	
48453	1	2	48804	1	100	0	0	0	0	0	
49856	1	1	40156	2	100	0	0	0	0	0	
49856	1	2	40157	1	100	0	0	0	0	0	
49857	1	1	40158	1	100	0	0	0	0	0	
49857	1	2	44191	1	100	0	0	0	0	0	
49858	1	1	49201	1	100	0	0	0	0	0	
49858	1	2	49202	1	100	0	0	0	0	0	
49859	1	1	49203	1	100	0	0	0	0	0	
49859	1	2	49204	1	100	0	0	0	0	0	
49860	1	1	49205	1	100	0	0	0	0	0	
49860	1	2	49208	1	100	0	0	0	0	0	
49861	1	1	49206	1	100	0	0	0	0	0	
49861	1	2	49209	1	100	0	0	0	0	0	
48214	1	1	14647	1	100	0	0	0	0	0	
48214	1	2	26458	1	100	0	0	0	0	0	
48215	1	1	14648	1	100	0	0	0	0	0	
48215	1	2	26458	1	100	0	0	0	0	0	
48216	1	1	14649	1	100	0	0	0	0	0	
48216	1	2	26459	1	100	0	0	0	0	0	
48217	1	1	14650	1	100	0	0	0	0	0	
48217	1	2	26459	1	100	0	0	0	0	0	
48218	1	1	14651	1	100	0	0	0	0	0	
48218	1	2	26460	1	100	0	0	0	0	0	
48219	1	1	14652	1	100	0	0	0	0	0	
48219	1	2	26460	1	100	0	0	0	0	0	
49496	1	1	42812	1	1.2	1	0	0	0	0	
49496	2	1	42813	1	2.4	0	0	0	0	0	
49496	3	1	41197	1	0.5	0	0	0	0	0	
49496	4	1	41305	1	0.4	0	0	0	0	0	
49496	5	1	40022	2	2	0	0	0	0	0	
49496	6	1	41493	1	2	0	0	0	0	0	
49496	7	1	41542	1	10	0	0	0	0	0	
49496	8	1	49290	1	16.3	0	0	0	0	0	
49496	9	1	40157	2	10	0	0	0	0	0	
49496	10	1	40182	2	5	0	0	0	0	0	
49496	11	1	40040	12	25.3	0	0	0	0	0	
49496	12	1	40042	5	26	0	0	0	0	0	
49806	1	1	40118	1	1	1	0	0	0	0	
49806	2	1	40121	1	1	1	0	0	0	0	
49806	3	1	40123	1	1	1	0	0	0	0	
49806	4	1	40124	1	1	1	0	0	0	0	
49806	5	1	40125	1	1	1	0	0	0	0	
49806	6	1	40135	1	1	1	0	0	0	0	
49806	7	1	40130	1	1	1	0	0	0	0	
49806	8	1	40241	1	1	1	0	0	0	0	
49806	9	1	40134	1	1	1	0	0	0	0	
49806	10	1	40131	1	1	1	0	0	0	0	
49806	11	1	40136	1	1	1	0	0	0	0	
49806	12	1	40137	1	1	1	0	0	0	0	
49806	13	1	40139	1	1	1	0	0	0	0	
49806	14	1	40142	1	1	1	0	0	0	0	
49806	15	1	40143	1	1	1	0	0	0	0	
49806	16	1	40147	1	1	1	0	0	0	0	
49806	17	1	40245	1	1	1	0	0	0	0	
49806	18	1	40244	1	1	1	0	0	0	0	
49806	19	1	40144	1	1	1	0	0	0	0	
49806	20	1	40145	1	1	1	0	0	0	0	
49806	21	1	40320	1	1	1	0	0	0	0	
49806	22	1	40243	1	1	1	0	0	0	0	
49806	23	1	40100	1	1	1	0	0	0	0	
49806	24	1	40101	1	1	1	0	0	0	0	
49806	25	1	40102	1	1	1	0	0	0	0	
49806	26	1	40103	1	1	1	0	0	0	0	
49806	27	1	40116	1	1	1	0	0	0	0	
49806	28	1	40117	1	1	1	0	0	0	0	
49806	29	1	40119	1	1	1	0	0	0	0	
49806	30	1	40120	1	1	1	0	0	0	0	
49806	31	1	40321	1	1	1	0	0	0	0	
49806	32	1	40150	1	1	1	0	0	0	0	
49806	33	1	40138	1	1	1	0	0	0	0	
49806	34	1	40140	1	1	1	0	0	0	0	
49806	35	1	40141	1	1	1	0	0	0	0	
49806	36	1	40146	1	1	1	0	0	0	0	
49806	37	1	40148	1	1	1	0	0	0	0	
49806	38	1	40149	1	1	1	0	0	0	0	
49806	39	1	40151	1	1	1	0	0	0	0	
49806	40	1	40349	1	1	1	0	0	0	0	
49806	41	1	40126	1	1	1	0	0	0	0	
49806	42	1	40127	1	1	1	0	0	0	0	
49806	43	1	40128	1	1	1	0	0	0	0	
49806	44	1	40129	1	1	1	0	0	0	0	
49806	45	1	40132	1	1	1	0	0	0	0	
49806	46	1	40133	1	1	1	0	0	0	0	
49806	47	1	40239	1	1	1	0	0	0	0	
49806	48	1	40240	1	1	1	0	0	0	0	
49806	49	1	40242	1	1	1	0	0	0	0	
49806	50	1	40319	1	1	1	0	0	0	0	
49806	51	1	40406	1	1	1	0	0	0	0	
49806	52	1	40408	1	1	1	0	0	0	0	
49806	53	1	40410	1	1	1	0	0	0	0	
49806	54	1	40412	1	1	1	0	0	0	0	
49806	55	1	40414	1	1	1	0	0	0	0	
49806	56	1	40416	1	1	1	0	0	0	0	
49806	57	1	40418	1	1	1	0	0	0	0	
49806	58	1	40420	1	1	1	0	0	0	0	
49806	59	1	40422	1	1	1	0	0	0	0	
49806	60	1	40424	1	1	1	0	0	0	0	
49806	61	1	40405	1	1	1	0	0	0	0	
49806	62	1	40407	1	1	1	0	0	0	0	
49806	63	1	40409	1	1	1	0	0	0	0	
49806	64	1	40411	1	1	1	0	0	0	0	
49806	65	1	40413	1	1	1	0	0	0	0	
49806	66	1	40415	1	1	1	0	0	0	0	
49806	67	1	40417	1	1	1	0	0	0	0	
49806	68	1	40419	1	1	1	0	0	0	0	
49806	69	1	40421	1	1	1	0	0	0	0	
49806	70	1	40423	1	1	1	0	0	0	0	
49806	71	1	40426	1	1	1	0	0	0	0	
49806	72	1	40425	1	1	1	0	0	0	0	
49806	73	1	40428	1	1	1	0	0	0	0	
49806	74	1	40427	1	1	1	0	0	0	0	
49806	75	1	40430	1	1	1	0	0	0	0	
49806	76	1	40429	1	1	1	0	0	0	0	
49806	77	1	40432	1	1	1	0	0	0	0	
49806	78	1	40431	1	1	1	0	0	0	0	
49806	79	1	40434	1	1	1	0	0	0	0	
49806	80	1	40433	1	1	1	0	0	0	0	
49806	81	1	40436	1	1	1	0	0	0	0	
49806	82	1	40435	1	1	1	0	0	0	0	
49806	83	1	40322	1	1	1	0	0	0	0	
49806	84	1	40323	1	1	1	0	0	0	0	
49806	85	1	40401	1	1	1	0	0	0	0	
49806	86	1	40439	1	1	1	0	0	0	0	
49806	87	1	40469	1	1	1	0	0	0	0	
49806	88	1	40470	1	1	1	0	0	0	0	
49806	89	1	40573	1	1	1	0	0	0	0	
49806	90	1	40574	1	1	1	0	0	0	0	
49806	91	1	41269	1	1	1	0	0	0	0	
49806	92	1	41273	1	0.9	1	0	0	0	0	
49806	93	1	41780	1	0.9	1	0	0	0	0	
49806	94	1	42133	1	0.9	1	0	0	0	0	
49806	95	1	42137	1	0.9	1	0	0	0	0	
49806	96	1	42418	1	0.9	1	0	0	0	0	
49806	97	1	42422	1	0.9	1	0	0	0	0	
49806	98	1	42648	1	0.9	1	0	0	0	0	
49806	99	1	42680	1	0.9	1	0	0	0	0	
49806	100	1	42866	1	0.9	1	0	0	0	0	
49806	101	1	42870	1	0.9	1	0	0	0	0	
52574	1	1	10314	1	100	0	0	0	0	0	
52574	1	2	10315	1	100	0	0	0	0	0	
52574	1	3	10316	1	100	0	0	0	0	0	
52574	1	4	10317	1	100	0	0	0	0	0	
52575	1	1	10318	1	100	0	0	0	0	0	
52575	1	2	10319	1	100	0	0	0	0	0	
52575	1	3	10320	1	100	0	0	0	0	0	
52575	1	4	10321	1	100	0	0	0	0	0	
49633	1	1	40368	1	2	0	0	0	0	0	
49633	2	1	40369	1	1	0	0	0	0	0	
49633	3	1	40370	1	0.1	0	0	0	0	0	
49633	4	1	40687	1	0.04	1	0	0	0	0	
49633	5	1	41301	1	0.02	1	0	0	0	0	
49633	6	1	42963	1	0.01	1	0	0	0	0	
49633	7	1	40543	1	4	0	0	0	0	0	
49633	8	1	40544	1	3	0	0	0	0	0	
49633	9	1	40545	1	2	0	0	0	0	0	
49633	10	1	40546	1	0.6	0	0	0	0	0	
49633	11	1	41302	1	0.4	0	0	0	0	0	
49633	12	1	42965	1	0.2	0	0	0	0	0	
49633	13	1	41194	1	7	0	0	0	0	0	
49633	14	1	41195	1	5	0	0	0	0	0	
49633	15	1	41196	1	4	0	0	0	0	0	
49633	16	1	41197	1	2	0	0	0	0	0	
49633	17	1	41305	1	1	0	0	0	0	0	
49633	18	1	42969	1	0.5	0	0	0	0	0	
49633	19	1	41186	1	8	0	0	0	0	0	
49633	20	1	41187	1	7	0	0	0	0	0	
49633	21	1	41188	1	6	0	0	0	0	0	
49633	22	1	41189	1	4	0	0	0	0	0	
49633	23	1	41303	1	3	0	0	0	0	0	
49633	24	1	42967	1	2	0	0	0	0	0	
49633	25	1	41539	1	1.2	0	0	0	0	0	
49633	26	1	41540	1	0.7	0	0	0	0	0	
49633	27	1	41541	1	0.1	1	0	0	0	0	
49633	28	1	40372	1	0.05	1	0	0	0	0	
49633	29	1	40371	1	0.2	1	0	0	0	0	
49633	30	1	40184	1	3	0	0	0	0	0	
49633	31	1	41300	1	2	0	0	0	0	0	
49633	32	1	40380	1	6	0	0	0	0	0	
49633	33	1	41542	1	13.88	0	0	0	0	0	
49633	34	1	40201	1	7	0	0	0	0	0	
49633	35	1	40363	1	3	0	0	0	0	0	
49810	1	1	44050	100	100	0	0	0	0	0	
48031	1	1	40362	1	95	0	0	0	0	0	
48031	2	1	40362	2	3.5	1	0	0	0	0	
48031	3	1	40362	3	1.2	1	0	0	0	0	
48031	4	1	40362	4	0.09	1	0	0	0	0	
48031	5	1	40362	5	0.06	1	0	0	0	0	
48031	6	1	40362	6	0.05	1	0	0	0	0	
48031	7	1	40362	7	0.04	1	0	0	0	0	
48031	8	1	40362	8	0.03	1	0	0	0	0	
48031	9	1	40362	9	0.02	1	0	0	0	0	
48031	10	1	40362	10	0.01	1	0	0	0	0	
48031	1	99	18453	1	0.1	1	0	0	0	0	
48032	1	1	40362	78	95	0	0	0	0	0	
48032	2	1	40362	88	3.4	1	0	0	0	0	
48032	3	1	40362	98	1.5	1	0	0	0	0	
48032	4	1	40362	128	0.05	1	0	0	0	0	
48032	5	1	40362	188	0.018	1	0	0	0	0	
48032	6	1	40362	288	0.01	1	0	0	0	0	
48032	7	1	40362	388	0.007	1	0	0	0	0	
48032	8	1	40362	488	0.005	1	0	0	0	0	
48032	9	1	40362	588	0.004	1	0	0	0	0	
48032	10	1	40362	688	0.003	1	0	0	0	0	
48032	11	1	40362	788	0.002	1	0	0	0	0	
48032	12	1	40362	888	0.001	1	0	0	0	0	
49507	1	1	42792	1	1	1	0	0	0	0	
49507	2	1	42793	1	0.6	0	0	0	0	0	
49507	3	1	42796	1	1	1	0	0	0	0	
49507	4	1	42797	1	0.6	0	0	0	0	0	
49507	5	1	40317	1	2	0	0	0	0	0	
49507	6	1	40367	1	2	0	0	0	0	0	
49507	7	1	40022	2	2	0	0	0	0	0	
49507	8	1	40200	4	5	0	0	0	0	0	
49507	9	1	40201	1	4	0	0	0	0	0	
49507	10	1	41089	1	4	0	0	0	0	0	
49507	11	1	40040	12	21.95	0	0	0	0	0	
49507	12	1	40042	5	21.55	0	0	0	0	0	
49507	13	1	41090	45	17.55	0	0	0	0	0	
49507	14	1	40509	3	16.75	0	0	0	0	0	
\.


--
-- TOC entry 3115 (class 0 OID 42650)
-- Dependencies: 212
-- Data for Name: gm_tool_accounts; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.gm_tool_accounts (id, account_name, password, privilege) FROM stdin;
\.


--
-- TOC entry 3107 (class 0 OID 42607)
-- Dependencies: 204
-- Data for Name: high_lottery; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.high_lottery (lottery_id, item_index, week, round, item_id, item_amount, probability, num_replay, bulletin, probability_plus1, probability_plus2, probability_plus3) FROM stdin;
40362	1	0	1	40021	1	1	-1	1	15	3	1
40362	2	0	1	40022	1	1	-1	0	10	17	29
40362	3	0	1	43538	2	1	-1	0	15	20	10
40362	4	0	1	49628	1	1	-1	0	1	1	1
40362	1	1	1	40019	5	17	-1	0	5	5	5
40362	2	1	1	40122	30	19	-1	0	4	4	4
40362	3	1	1	40200	1	17	-1	0	5	5	5
40362	4	1	1	40181	2	17	-1	0	4	4	4
40362	5	1	1	40156	2	15.8	-1	0	2	2	2
40362	6	1	1	40030	2	14	-1	1	0.8	0.8	0.8
40362	7	1	1	40370	1	1.1	-1	0	5	5	5
40362	8	1	1	49146	1	1.1	-1	0	0.3	0.3	0.3
40362	1	1	2	40509	1	1	-1	0	4	4	4
40362	2	1	2	40509	1	1	-1	0	4	4	4
40362	3	1	2	40066	1	13.5	-1	0	4	4	4
40362	4	1	2	40368	1	7.5	-1	0	3	3	3
40362	5	1	2	40227	1	31	-1	0	0.8	0.8	0.8
40362	6	1	2	40229	1	5	-1	1	0.1	0.1	0.1
40362	7	1	2	49153	1	2.5	-1	0	0.4	0.4	0.4
40362	8	1	2	40366	1	1.5	-1	1	0.016	0.016	0.016
40362	1	1	3	40509	1	1	-1	0	5	5	5
40362	2	1	3	40509	1	1	-1	0	3	3	3
40362	3	1	3	40509	1	1	-1	1	0.35	0.35	0.35
40362	4	1	3	40509	1	1	-1	0	1	1	1
40362	5	1	3	40791	1	11	-1	0	0.8	0.8	0.8
40362	6	1	3	40490	1	5	-1	1	0.35	0.35	0.35
40362	7	1	3	40225	1	43	-1	0	0.3	0.3	0.3
40362	8	1	3	40378	1	1	-1	1	0.005	0.005	0.005
40362	1	1	4	40509	1	1	-1	0	3	3	3
40362	2	1	4	40509	1	1	-1	1	0.06	0.06	0.06
40362	3	1	4	40509	1	1	-1	1	0.06	0.06	0.06
40362	4	1	4	40509	1	1	-1	0	0.8	0.8	0.8
40362	5	1	4	40509	1	1	-1	0	1	1	1
40362	6	1	4	40509	1	1	-1	1	0.16	0.16	0.16
40362	7	1	4	40369	1	29	-1	1	0.003	0.003	0.003
40362	8	1	4	49143	1	1	-1	1	0.003	0.003	0.003
40362	1	1	5	40509	1	1	-1	0	0.8	0.8	0.8
40362	2	1	5	40509	1	1	-1	0	0.822	0.822	0.822
40362	3	1	5	40509	1	1	-1	1	0.002	0.002	0.002
40362	4	1	5	40509	1	1	-1	1	0.002	0.002	0.002
40362	5	1	5	40509	1	1	-1	1	0.001	0.001	0.001
40362	6	1	5	40509	1	1	-1	1	0.06	0.06	0.06
40362	7	1	5	40509	1	1	-1	1	0.003	0.003	0.003
40362	8	1	5	40370	2	1	-1	1	0.003	0.003	0.003
40362	1	2	1	40203	5	21	-1	0	5	5	5
40362	2	2	1	40205	5	21	-1	0	4	4	4
40362	3	2	1	40207	5	21	-1	0	5	5	5
40362	4	2	1	40269	1	11	-1	0	4	4	4
40362	5	2	1	40271	1	11	-1	0	2	2	2
40362	6	2	1	40333	1	11	-1	1	0.8	0.8	0.8
40362	7	2	1	40337	1	9.9	-1	0	5	5	5
40362	8	2	1	40370	1	1.1	-1	0	0.3	0.3	0.3
40362	1	2	2	40385	1	12	-1	0	4	4	4
40362	2	2	2	40386	1	1	-1	0	4	4	4
40362	3	2	2	40387	1	12	-1	0	4	4	4
40362	4	2	2	40388	1	1	-1	0	3	3	3
40362	5	2	2	40389	1	12	-1	0	0.8	0.8	0.8
40362	6	2	2	40390	1	1	-1	1	0.1	0.1	0.1
40362	7	2	2	40391	1	12	-1	0	0.4	0.4	0.4
40362	8	2	2	40392	1	1	-1	1	0.016	0.016	0.016
40362	1	2	3	40001	1	3	-1	0	5	5	5
40362	2	2	3	40004	1	3	-1	0	3	3	3
40362	3	2	3	40007	1	3	-1	1	0.35	0.35	0.35
40362	4	2	3	40010	1	3	-1	0	1	1	1
40362	5	2	3	40013	1	3	-1	0	0.8	0.8	0.8
40362	6	2	3	40016	1	3	-1	1	0.35	0.35	0.35
40362	7	2	3	40010	1	3	-1	0	0.3	0.3	0.3
40362	8	2	3	40004	1	3	-1	1	0.005	0.005	0.005
40362	1	2	4	40265	1	3	-1	0	3	3	3
40362	2	2	4	40266	1	1	-1	1	0.06	0.06	0.06
40362	3	2	4	40267	1	3	-1	1	0.06	0.06	0.06
40362	4	2	4	40268	1	1	-1	0	0.8	0.8	0.8
40362	5	2	4	40331	1	3	-1	0	1	1	1
40362	6	2	4	40332	1	1	-1	1	0.16	0.16	0.16
40362	7	2	4	40335	1	3	-1	1	0.003	0.003	0.003
40362	8	2	4	40336	1	1	-1	1	0.003	0.003	0.003
40362	1	2	5	40459	1	1.5	-1	0	0.8	0.8	0.8
40362	2	2	5	40460	1	1	-1	0	0.822	0.822	0.822
40362	3	2	5	40461	1	1.5	-1	1	0.002	0.002	0.002
40362	4	2	5	40462	1	1	-1	1	0.002	0.002	0.002
40362	5	2	5	40463	1	1.5	-1	1	0.001	0.001	0.001
40362	6	2	5	40464	1	1	-1	1	0.06	0.06	0.06
40362	7	2	5	40511	1	1.5	-1	1	0.003	0.003	0.003
40362	8	2	5	40512	1	1	-1	1	0.003	0.003	0.003
40362	1	3	1	40019	5	17	-1	0	5	5	5
40362	2	3	1	40122	30	19	-1	0	4	4	4
40362	3	3	1	40200	1	17	-1	0	5	5	5
40362	4	3	1	40181	2	17	-1	0	4	4	4
40362	5	3	1	40156	2	15.8	-1	0	2	2	2
40362	6	3	1	40030	2	14	-1	1	0.8	0.8	0.8
40362	7	3	1	40370	1	1.1	-1	0	5	5	5
40362	8	3	1	49149	1	1.1	-1	0	0.3	0.3	0.3
40362	1	3	2	40509	1	1	-1	0	4	4	4
40362	2	3	2	40509	1	1	-1	0	4	4	4
40362	3	3	2	40067	1	13.5	-1	0	4	4	4
40362	4	3	2	40368	1	7.5	-1	0	3	3	3
40362	5	3	2	40227	1	31	-1	0	0.8	0.8	0.8
40362	6	3	2	40226	1	5	-1	1	0.1	0.1	0.1
40362	7	3	2	49150	1	1.5	-1	0	0.4	0.4	0.4
40362	8	3	2	40366	1	1.5	-1	1	0.016	0.016	0.016
40362	1	3	3	40509	1	1	-1	0	5	5	5
40362	2	3	3	40509	1	1	-1	0	3	3	3
40362	3	3	3	40509	1	1	-1	1	0.35	0.35	0.35
40362	4	3	3	40509	1	1	-1	0	1	1	1
40362	5	3	3	40692	1	11	-1	0	0.8	0.8	0.8
40362	6	3	3	40368	1	6	-1	1	0.35	0.35	0.35
40362	7	3	3	40224	1	43	-1	0	0.3	0.3	0.3
40362	8	3	3	40605	1	1	-1	1	0.005	0.005	0.005
40362	1	3	4	40509	1	1	-1	0	3	3	3
40362	2	3	4	40509	1	1	-1	1	0.06	0.06	0.06
40362	3	3	4	40509	1	1	-1	1	0.06	0.06	0.06
40362	4	3	4	40509	1	1	-1	0	0.8	0.8	0.8
40362	5	3	4	40509	1	1	-1	0	1	1	1
40362	6	3	4	40509	1	1	-1	1	0.16	0.16	0.16
40362	7	3	4	40372	1	9	-1	1	0.003	0.003	0.003
40362	8	3	4	40372	20	1	-1	1	0.003	0.003	0.003
40362	1	3	5	40509	1	1	-1	0	0.8	0.8	0.8
40362	2	3	5	40509	1	1	-1	0	0.822	0.822	0.822
40362	3	3	5	40509	1	1	-1	1	0.002	0.002	0.002
40362	4	3	5	40509	1	1	-1	1	0.002	0.002	0.002
40362	5	3	5	40509	1	1	-1	1	0.001	0.001	0.001
40362	6	3	5	40509	1	1	-1	1	0.06	0.06	0.06
40362	7	3	5	40509	1	1	-1	1	0.003	0.003	0.003
40362	8	3	5	40370	2	1	-1	1	0.003	0.003	0.003
40362	1	4	1	40616	1	15	-1	0	5	5	5
40362	2	4	1	40617	1	14	-1	0	4	4	4
40362	3	4	1	40618	1	14	-1	0	5	5	5
40362	4	4	1	40619	1	14	-1	0	4	4	4
40362	5	4	1	40620	1	14	-1	0	2	2	2
40362	6	4	1	40621	1	14	-1	1	0.8	0.8	0.8
40362	7	4	1	40622	1	14	-1	0	5	5	5
40362	8	4	1	40608	1	1	-1	0	0.3	0.3	0.3
40362	1	4	2	40182	1	18.5	-1	0	4	4	4
40362	2	4	2	40231	1	18.5	-1	0	4	4	4
40362	3	4	2	40157	5	19	-1	0	4	4	4
40362	4	4	2	40368	1	7.5	-1	0	3	3	3
40362	5	4	2	40066	1	13.5	-1	0	0.8	0.8	0.8
40362	6	4	2	40226	1	5	-1	1	0.1	0.1	0.1
40362	7	4	2	49143	1	1.5	-1	0	0.4	0.4	0.4
40362	8	4	2	40366	1	1	-1	1	0.016	0.016	0.016
40362	1	4	3	41054	1	11	-1	0	5	5	5
40362	2	4	3	41053	1	11	-1	0	3	3	3
40362	3	4	3	40112	1	11	-1	1	0.35	0.35	0.35
40362	4	4	3	49029	1	11	-1	0	1	1	1
40362	5	4	3	40465	1	8	-1	0	0.8	0.8	0.8
40362	6	4	3	40368	1	5	-1	1	0.35	0.35	0.35
40362	7	4	3	40507	1	5	-1	0	0.3	0.3	0.3
40362	8	4	3	40379	1	1	-1	1	0.005	0.005	0.005
40362	1	4	4	40241	1	8	-1	0	3	3	3
40362	2	4	4	40182	3	7.5	-1	1	0.06	0.06	0.06
40362	3	4	4	41091	1	11	-1	1	0.06	0.06	0.06
40362	4	4	4	40022	10	8	-1	0	0.8	0.8	0.8
40362	5	4	4	40512	1	1.5	-1	0	1	1	1
40362	6	4	4	40354	1	5	-1	1	0.16	0.16	0.16
40362	7	4	4	40466	1	1.5	-1	1	0.003	0.003	0.003
40362	8	4	4	40692	1	1.5	-1	1	0.003	0.003	0.003
40362	1	4	5	40373	1	1.5	-1	0	0.8	0.8	0.8
40362	2	4	5	40374	1	1.1	-1	0	0.822	0.822	0.822
40362	3	4	5	40459	1	1.5	-1	1	0.002	0.002	0.002
40362	4	4	5	40460	1	1.1	-1	1	0.002	0.002	0.002
40362	5	4	5	40461	1	1.5	-1	1	0.001	0.001	0.001
40362	6	4	5	40462	1	1.1	-1	1	0.06	0.06	0.06
40362	7	4	5	40463	1	1.5	-1	1	0.003	0.003	0.003
40362	8	4	5	40464	1	1.1	-1	1	0.003	0.003	0.003
40362	1	5	1	40019	5	17	-1	0	5	5	5
40362	2	5	1	40122	30	19	-1	0	4	4	4
40362	3	5	1	40200	1	17	-1	0	5	5	5
40362	4	5	1	40181	2	17	-1	0	4	4	4
40362	5	5	1	40156	2	15.8	-1	0	2	2	2
40362	6	5	1	40030	2	14	-1	1	0.8	0.8	0.8
40362	7	5	1	40370	1	1.1	-1	0	5	5	5
40362	8	5	1	49149	1	1.1	-1	0	0.3	0.3	0.3
40362	1	5	2	40509	1	1	-1	0	4	4	4
40362	2	5	2	40509	1	1	-1	0	4	4	4
40362	3	5	2	40157	5	34.5	-1	0	4	4	4
40362	4	5	2	40368	1	7.5	-1	0	3	3	3
40362	5	5	2	40227	1	31	-1	0	0.8	0.8	0.8
40362	6	5	2	40223	1	5	-1	1	0.1	0.1	0.1
40362	7	5	2	49153	1	2.5	-1	0	0.4	0.4	0.4
40362	8	5	2	40366	1	1.5	-1	1	0.016	0.016	0.016
40362	1	5	3	40509	1	1	-1	0	5	5	5
40362	2	5	3	40509	1	1	-1	0	3	3	3
40362	3	5	3	40509	1	1	-1	1	0.35	0.35	0.35
40362	4	5	3	40509	1	1	-1	0	1	1	1
40362	5	5	3	40791	1	11	-1	0	0.8	0.8	0.8
40362	6	5	3	40368	1	5	-1	1	0.35	0.35	0.35
40362	7	5	3	40225	1	43	-1	0	0.3	0.3	0.3
40362	8	5	3	40335	1	2	-1	1	0.005	0.005	0.005
40362	1	5	4	40509	1	1	-1	0	3	3	3
40362	2	5	4	40509	1	1	-1	1	0.06	0.06	0.06
40362	3	5	4	40509	1	1	-1	1	0.06	0.06	0.06
40362	4	5	4	40509	1	1	-1	0	0.8	0.8	0.8
40362	5	5	4	40509	1	1	-1	0	1	1	1
40362	6	5	4	40509	1	1	-1	1	0.16	0.16	0.16
40362	7	5	4	40369	1	19	-1	1	0.003	0.003	0.003
40362	8	5	4	49144	1	1	-1	1	0.003	0.003	0.003
40362	1	5	5	40509	1	1	-1	0	0.8	0.8	0.8
40362	2	5	5	40509	1	1	-1	0	0.822	0.822	0.822
40362	3	5	5	40509	1	1	-1	1	0.002	0.002	0.002
40362	4	5	5	40509	1	1	-1	1	0.002	0.002	0.002
40362	5	5	5	40509	1	1	-1	1	0.001	0.001	0.001
40362	6	5	5	40509	1	1	-1	1	0.06	0.06	0.06
40362	7	5	5	40509	1	1	-1	1	0.003	0.003	0.003
40362	8	5	5	40370	2	1	-1	1	0.003	0.003	0.003
40362	1	6	1	40886	1	14	-1	0	5	5	5
40362	2	6	1	40889	1	12	-1	0	4	4	4
40362	3	6	1	40892	1	12	-1	0	5	5	5
40362	4	6	1	40895	1	12	-1	0	4	4	4
40362	5	6	1	40898	1	12	-1	0	2	2	2
40362	6	6	1	40901	1	23	-1	1	0.8	0.8	0.8
40362	7	6	1	40886	1	14	-1	0	5	5	5
40362	8	6	1	49151	1	1	-1	0	0.3	0.3	0.3
40362	1	6	2	40182	1	18.5	-1	0	4	4	4
40362	2	6	2	40231	1	18.5	-1	0	4	4	4
40362	3	6	2	40157	5	19	-1	0	4	4	4
40362	4	6	2	40368	1	7.5	-1	0	3	3	3
40362	5	6	2	40157	5	13.5	-1	0	0.8	0.8	0.8
40362	6	6	2	40226	1	5	-1	1	0.1	0.1	0.1
40362	7	6	2	49152	1	2.5	-1	0	0.4	0.4	0.4
40362	8	6	2	40366	1	1.5	-1	1	0.016	0.016	0.016
40362	1	6	3	40352	1	7	-1	0	5	5	5
40362	2	6	3	40353	1	7	-1	0	3	3	3
40362	3	6	3	40354	1	7	-1	1	0.35	0.35	0.35
40362	4	6	3	40355	1	7	-1	0	1	1	1
40362	5	6	3	40356	1	7	-1	0	0.8	0.8	0.8
40362	6	6	3	40357	1	7	-1	1	0.35	0.35	0.35
40362	7	6	3	40358	1	7	-1	0	0.3	0.3	0.3
40362	8	6	3	40379	1	1	-1	1	0.005	0.005	0.005
40362	1	6	4	41091	1	5	-1	0	3	3	3
40362	2	6	4	40022	10	8	-1	1	0.06	0.06	0.06
40362	3	6	4	40182	4	9.5	-1	1	0.06	0.06	0.06
40362	4	6	4	49145	1	1.5	-1	0	0.8	0.8	0.8
40362	5	6	4	40371	1	8	-1	0	1	1	1
40362	6	6	4	40372	1	8	-1	1	0.16	0.16	0.16
40362	7	6	4	40466	1	1.5	-1	1	0.003	0.003	0.003
40362	8	6	4	40463	1	1.5	-1	1	0.003	0.003	0.003
40362	1	6	5	49143	1	1.5	-1	0	0.8	0.8	0.8
40362	2	6	5	49144	1	1.5	-1	0	0.822	0.822	0.822
40362	3	6	5	49145	1	1.5	-1	1	0.002	0.002	0.002
40362	4	6	5	49146	1	1.5	-1	1	0.002	0.002	0.002
40362	5	6	5	49147	1	1.5	-1	1	0.001	0.001	0.001
40362	6	6	5	49148	1	1.5	-1	1	0.06	0.06	0.06
40362	7	6	5	49149	1	1.5	-1	1	0.003	0.003	0.003
40362	8	6	5	49150	1	1.5	-1	1	0.003	0.003	0.003
40362	1	7	1	40616	1	15	-1	0	5	5	5
40362	2	7	1	40617	1	14	-1	0	4	4	4
40362	3	7	1	40618	1	14	-1	0	5	5	5
40362	4	7	1	40619	1	14	-1	0	4	4	4
40362	5	7	1	40620	1	14	-1	0	2	2	2
40362	6	7	1	40621	1	14	-1	1	0.8	0.8	0.8
40362	7	7	1	40622	1	14	-1	0	5	5	5
40362	8	7	1	40608	1	1	-1	0	0.3	0.3	0.3
40362	1	7	2	40182	1	18.5	-1	0	4	4	4
40362	2	7	2	40231	1	18.5	-1	0	4	4	4
40362	3	7	2	40157	5	19	-1	0	4	4	4
40362	4	7	2	40368	1	7.5	-1	0	3	3	3
40362	5	7	2	40067	1	13.5	-1	0	0.8	0.8	0.8
40362	6	7	2	40226	1	5	-1	1	0.1	0.1	0.1
40362	7	7	2	49154	1	2.5	-1	0	0.4	0.4	0.4
40362	8	7	2	40366	1	1.5	-1	1	0.016	0.016	0.016
40362	1	7	3	41053	1	11	-1	0	5	5	5
40362	2	7	3	41054	1	11	-1	0	3	3	3
40362	3	7	3	41053	1	11	-1	1	0.35	0.35	0.35
40362	4	7	3	40112	1	11	-1	0	1	1	1
40362	5	7	3	49147	1	1	-1	0	0.8	0.8	0.8
40362	6	7	3	40368	1	5	-1	1	0.35	0.35	0.35
40362	7	7	3	40507	1	5	-1	0	0.3	0.3	0.3
40362	8	7	3	40379	1	1	-1	1	0.005	0.005	0.005
40362	1	7	4	40472	1	6	-1	0	3	3	3
40362	2	7	4	40473	1	6	-1	1	0.06	0.06	0.06
40362	3	7	4	40474	1	6	-1	1	0.06	0.06	0.06
40362	4	7	4	40475	1	6	-1	0	0.8	0.8	0.8
40362	5	7	4	40476	1	1	-1	0	1	1	1
40362	6	7	4	40477	1	5	-1	1	0.16	0.16	0.16
40362	7	7	4	40478	1	5	-1	1	0.003	0.003	0.003
40362	8	7	4	40479	1	5	-1	1	0.003	0.003	0.003
40362	1	7	5	34279	50	1.8	-1	0	0.8	0.8	0.8
40362	2	7	5	40437	1	1.7	-1	0	0.822	0.822	0.822
40362	3	7	5	40350	1	6.9	-1	1	0.002	0.002	0.002
40362	4	7	5	40511	1	1.1	-1	1	0.002	0.002	0.002
40362	5	7	5	40400	1	5	-1	1	0.001	0.001	0.001
40362	6	7	5	40265	1	3	-1	1	0.06	0.06	0.06
40362	7	7	5	49148	1	1	-1	1	0.003	0.003	0.003
40362	8	7	5	40463	1	1.5	-1	1	0.003	0.003	0.003
\.


--
-- TOC entry 3116 (class 0 OID 42654)
-- Dependencies: 213
-- Data for Name: item_receipt; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.item_receipt (id, purchase_time, receieved_time, account_name, item_id, item_quantity, point, amount, world_id, player_name, unique_id, create_time, mail_name) FROM stdin;
\.


--
-- TOC entry 3117 (class 0 OID 42666)
-- Dependencies: 214
-- Data for Name: item_receivable; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.item_receivable (id, state, purchase_time, receivable_time, account_name, item_id, item_quantity, world_id, player_name, point, amount, mail_name, money_type) FROM stdin;
\.


--
-- TOC entry 3119 (class 0 OID 42681)
-- Dependencies: 216
-- Data for Name: itemmall; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.itemmall (item_id, item_group, item_index, item_num, money_unit, point, special_price, sell, not_sell_date, fortune_bag, note) FROM stdin;
52239	7	11	1	1	5000	0	1	0		
53071	7	12	1	1	5000	0	1	0		
40096	2	14	1	1	49	0	1	0		
40097	2	15	1	1	49	0	1	0		
40069	2	16	1	1	49	0	1	0		
40063	2	17	1	1	49	0	1	0		
40064	2	18	1	1	49	0	1	0		
40065	2	19	1	1	49	0	1	0		
40044	2	20	1	1	9	0	1	0		
40045	2	21	1	1	9	0	1	0		
40046	2	22	1	1	9	0	1	0		
40047	2	23	1	1	9	0	1	0		
40048	2	24	1	1	9	0	1	0		
40049	2	25	1	1	9	0	1	0		
40050	2	26	1	1	9	0	1	0		
40051	2	27	1	1	9	0	1	0		
40056	2	28	1	1	29	0	1	0		
40059	2	29	1	1	29	0	1	0		
40053	2	30	1	1	29	0	1	0		
40052	2	31	1	1	29	0	1	0		
40054	2	32	1	1	29	0	1	0		
40055	2	33	1	1	29	0	1	0		
40057	2	34	1	1	29	0	1	0		
40058	2	35	1	1	29	0	1	0		
40072	2	36	1	1	29	0	1	0		
40074	2	37	1	1	29	0	1	0		
40075	2	38	1	1	29	0	1	0		
40083	2	39	1	1	29	0	1	0		
41081	2	40	1	1	9	0	1	0		
41065	2	41	1	1	9	0	1	0		
41066	2	42	1	1	9	0	1	0		
41067	2	43	1	1	9	0	1	0		
41068	2	44	1	1	9	0	1	0		
41069	2	45	1	1	9	0	1	0		
41070	2	46	1	1	9	0	1	0		
41071	2	47	1	1	9	0	1	0		
41072	2	48	1	1	9	0	1	0		
41073	2	49	1	1	9	0	1	0		
41074	2	50	1	1	9	0	1	0		
41075	2	51	1	1	9	0	1	0		
41077	2	52	1	1	9	0	1	0		
41078	2	53	1	1	9	0	1	0		
41079	2	54	1	1	9	0	1	0		
41080	2	55	1	1	9	0	1	0		
41082	2	56	1	1	9	0	1	0		
41085	2	57	1	1	9	0	1	0		
41086	2	58	1	1	9	0	1	0		
41087	2	59	1	1	9	0	1	0		
40115	2	60	1	1	149	0	1	0		
39311	2	11	1	1	10000	0	1	0		
39312	2	12	1	1	10000	0	1	0		
31343	8	14	1000	1	1000	0	1	0		
31344	8	15	1000	1	1000	0	1	0		
31345	8	16	1000	1	1000	0	1	0		
27655	8	17	1000	1	1000	0	1	0		
39920	8	18	10000	1	1000	0	1	0		
20780	4	13	1000	1	500	0	1	0		
20782	4	14	1000	1	500	0	1	0		
16225	5	15	1	1	1000	0	1	0		
16269	5	16	1	1	1000	0	1	0		
16221	5	17	1	1	1000	0	1	0		
16265	5	18	1	1	1000	0	1	0		
16224	5	19	1	1	1000	0	1	0		
16268	5	20	1	1	1000	0	1	0		
39314	2	13	1	1	99	0	1	0		
19285	3	17	1	1	199	0	1	0		
23875	2	6	250	1	1000	0	1	0		
48896	1	13	250	1	1199	0	1	0		
41091	1	2	1	1	299	0	1	0		
31301	1	15	250	1	9	0	1	0		
52421	1	9	250	1	899	0	1	0		
40436	2	1	1	1	100	0	1	0		
43599	1	10	50	1	249	0	1	0		
40184	1	11	250	1	1699	0	1	0		
48444	1	14	250	1	2000	0	1	0		
48915	1	12	250	1	1449	0	1	0		
41088	1	8	250	1	49	0	1	0		
36347	1	1	250	1	69	0	1	0		
23883	2	5	250	1	1000	0	1	0		
42170	1	3	24464	1	2499	0	1	0		
40040	2	9	250	1	29	0	1	0		
40431	2	4	1	1	100	0	1	0		
40434	2	3	1	1	100	0	1	0		
23882	2	7	250	1	1000	0	1	0		
23876	2	8	250	1	1000	999	1	0		
40042	2	10	250	1	99	0	1	0		
26738	3	1	1	1	299	0	1	0		
26748	3	6	1	1	399	0	1	0		
26739	3	2	1	1	299	0	1	0		
26740	3	3	1	1	399	0	1	0		
26741	3	4	1	1	399	0	1	0		
26742	3	5	1	1	1000	0	1	0		
26749	3	7	1	1	399	0	1	0		
26750	3	8	1	1	499	0	1	0		
26751	3	9	1	1	399	0	1	0		
26743	3	11	1	1	599	0	1	0		
26744	3	12	1	1	599	0	1	0		
26747	3	15	1	1	599	0	1	0		
24893	1	4	1	1	100	0	1	0		
26746	3	14	1	1	599	0	1	0		
24962	3	16	1	1	599	0	1	0		
26752	3	10	1	1	599	0	1	0		
19278	3	18	1	1	199	0	1	0		
40368	4	1	250	1	500	0	1	0		
40370	4	3	250	1	500	0	1	0		
40369	4	2	250	1	500	0	1	0		
41301	4	5	250	1	500	0	1	0		
40687	4	4	250	1	500	0	1	0		
42964	4	6	250	1	500	0	1	0		
41368	4	7	250	1	500	0	1	0		
24862	4	8	250	1	49	0	1	0		
27647	4	9	250	1	49	0	1	0		
24863	4	10	250	1	49	0	1	0		
27648	4	11	250	1	49	0	1	0		
45816	7	1	1	1	2000	0	1	0		
53421	7	2	1	1	5000	0	1	0		
54148	7	3	1	1	5000	0	1	0		
54419	7	4	1	1	5000	0	1	0		
53283	7	5	1	1	2000	0	1	0		
51344	7	6	1	1	2000	0	1	0		
34209	8	3	1000	1	1000	0	1	0		
50588	7	7	1	1	5000	0	1	0		
45828	7	8	1	1	5000	0	1	0		
50954	7	9	1	1	2000	0	1	0		
51163	7	10	1	1	5000	0	1	0		
44340	1	26	1000	1	1000	0	1	0		
53300	1	27	1000	1	1000	0	1	0		
47242	1	28	1000	1	1000	0	1	0		
52438	1	29	1000	1	1000	0	1	0		
47276	1	30	1000	1	1000	0	1	0		
17137	3	47	250	1	999	0	1	0		
26236	3	49	250	1	999	0	1	0		
27681	3	50	250	1	999	0	1	0		
25419	3	51	250	1	999	0	1	0		
25339	3	52	250	1	999	0	1	0		
34211	8	1	1000	1	1000	0	1	0		
34210	8	2	1000	1	1000	0	1	0		
34212	8	4	1000	1	1000	0	1	0		
16231	5	21	1	1	1000	0	1	0		
31325	8	6	1000	1	1000	0	1	0		
31336	8	7	1000	1	1000	0	1	0		
31337	8	8	1000	1	1000	0	1	0		
31338	8	9	1000	1	1000	0	1	0		
31340	8	11	1000	1	1000	0	1	0		
31339	8	10	1000	1	1000	0	1	0		
31341	8	12	1000	1	1000	0	1	0		
31342	8	13	1000	1	1000	0	1	0		
53285	1	33	1	1	1000	0	1	0		
28957	3	48	250	1	999	0	1	0		
12315	1	74	1	1	1000	0	1	0		
39557	1	37	250	1	1000	0	1	0		
49153	50	2	1	1	1	0	1	0		
49152	50	3	1	1	1	0	1	0		
49151	50	4	1	1	1	0	1	0		
49958	50	5	1	1	1	0	1	0		
27662	50	8	1	1	1	0	1	0		
27660	50	7	1	1	1	0	1	0		
27658	50	6	1	1	1	0	1	0		
12308	50	9	1	1	1	0	1	0		
48158	50	1	1	1	1	0	1	0		
48978	1	38	250	1	1000	0	1	0		
41495	1	39	250	1	1000	0	1	0		
27992	1	7	90000	1	1	0	1	0		
52430	1	40	1	1	1000	0	1	0		
31304	1	16	250	1	9	0	1	0		
47107	1	17	250	1	9	0	1	0		
47113	1	18	250	1	9	0	1	0		
47114	1	19	250	1	9	0	1	0		
43968	1	20	1	1	1000	0	1	0		
52470	1	21	1	1	1000	0	1	0		
40450	1	22	250	1	1000	0	1	0		
40451	1	23	250	1	1000	0	1	0		
48804	1	24	250	1	1000	0	1	0		
52466	1	25	250	1	1000	0	1	0		
51203	1	32	1	1	1000	0	1	0		
15191	1	34	250	1	1000	0	1	0		
15192	1	35	250	1	1000	0	1	0		
39556	1	36	250	1	1000	0	1	0		
43796	1	41	1	1	1000	0	1	0		
40371	1	42	250	1	1000	0	1	0		
46738	1	43	200	1	1000	0	1	0		
46739	1	44	200	1	1000	0	1	0		
48998	1	45	200	1	1000	0	1	0		
49000	1	46	200	1	1000	0	1	0		
43663	1	47	200	1	1000	0	1	0		
43665	1	48	200	1	100	0	1	0		
10822	1	49	200	1	1000	0	1	0		
10823	1	50	200	1	1000	0	1	0		
10824	1	51	200	1	1000	0	1	0		
10825	1	52	200	1	1000	0	1	0		
10826	1	53	200	1	1000	0	1	0		
53335	1	54	200	1	1000	0	1	0		
53336	1	55	200	1	1000	0	1	0		
53337	1	56	200	1	1000	0	1	0		
53338	1	57	200	1	1000	0	1	0		
53339	1	58	200	1	1000	0	1	0		
53345	1	64	200	1	2000	0	1	0		
53340	1	59	200	1	2000	0	1	0		
53341	1	60	200	1	2000	0	1	0		
53342	1	61	200	1	2000	0	1	0		
53343	1	62	200	1	2000	0	1	0		
53344	1	63	200	1	2000	0	1	0		
41131	1	65	250	1	100	0	1	0		
41127	1	66	250	1	100	0	1	0		
41123	1	67	250	1	100	0	1	0		
41118	1	68	250	1	100	0	1	0		
41122	1	69	250	1	100	0	1	0		
41093	1	70	250	1	100	90	1	0		
40413	2	2	5	1	100	0	1	0		
40380	1	71	1	1	100	99	1	0		
43101	1	72	1	1	100	0	1	0		
43103	1	73	1	1	100	0	1	0		
16910	5	6	1	1	5000	4999	1	0		
16913	5	3	1	1	5000	4999	1	0		
18975	5	1	1	1	10000	9999	1	0		
16992	5	2	1	1	5000	4999	1	0		
16988	5	4	1	1	20000	19999	1	0		
10285	5	9	1	1	5000	0	1	0		
14941	5	5	1	1	10000	9999	1	0		
10283	5	10	1	1	5000	0	1	0		
19711	5	8	1	1	5000	0	1	0		
21372	5	11	1	1	5000	0	1	0		
16989	5	7	1	1	5000	0	1	0		
34999	6	3	1	1	5000	0	1	0		
34997	6	1	1	1	5000	0	1	0		
34998	6	2	1	1	5000	0	1	0		
27069	3	53	250	1	999	0	1	0		
42170	1	31	10000	1	1000	0	1	0		
26745	3	13	1	1	599	0	1	0		
19280	3	19	1	1	999	0	1	0		
19284	3	20	1	1	999	0	1	0		
44186	3	21	250	1	999	0	1	0		
44187	3	22	250	1	999	0	1	0		
23840	3	54	250	1	999	0	1	0		
44188	3	23	250	1	999	0	1	0		
44189	3	24	250	1	999	0	1	0		
44190	3	25	250	1	999	0	1	0		
25470	3	26	250	1	999	0	1	0		
25469	3	27	250	1	999	0	1	0		
25468	3	28	250	1	999	0	1	0		
18627	3	29	250	1	999	0	1	0		
18626	3	30	250	1	999	0	1	0		
18631	3	31	250	1	999	0	1	0		
18637	3	32	250	1	999	0	1	0		
18621	3	33	250	1	999	0	1	0		
24059	3	34	250	1	999	0	1	0		
26770	3	35	250	1	999	0	1	0		
28976	3	55	250	1	999	0	1	0		
18635	3	36	250	1	999	0	1	0		
18630	3	37	250	1	999	0	1	0		
18625	3	38	250	1	999	0	1	0		
18614	3	39	250	1	999	0	1	0		
26482	3	40	250	1	999	0	1	0		
23839	3	41	250	1	999	0	1	0		
19072	3	42	250	1	999	0	1	0		
19073	3	43	250	1	999	0	1	0		
19074	3	44	250	1	999	0	1	0		
26768	3	45	250	1	999	0	1	0		
23717	3	56	250	1	999	0	1	0		
26237	3	46	250	1	999	0	1	0		
17205	3	57	1000	1	999	0	1	0		
35875	4	12	250	1	49	0	1	0		
21371	5	12	1	1	5000	0	1	0		
21509	5	13	1	1	5000	0	1	0		
21510	5	14	1	1	5000	0	1	0		
17242	3	58	1000	1	999	0	1	0		
36589	3	59	250	1	1000	0	1	0		
36588	3	60	250	1	1000	0	1	0		
16275	5	22	1	1	1000	0	1	0		
34765	8	19	60	1	100	0	1	0		
49679	1	6	1	1	1000	0	1	0		
26152	8	20	1	1	1000	0	1	0		
26155	8	21	1	1	1000	0	1	0		
44207	8	23	1	1	1000	0	1	0		
44205	8	22	1	1	1000	0	1	0		
44210	8	24	1	1	1000	0	1	0		
20045	8	25	1	1	1000	0	1	0		
20046	8	26	1	1	1000	0	1	0		
20047	8	27	1	1	1000	0	1	0		
27189	9	1	500	1	99	0	1	0		
20048	8	28	1	1	1000	0	1	0		
\.


--
-- TOC entry 3123 (class 0 OID 42946)
-- Dependencies: 220
-- Data for Name: itemmall_limit_amount; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.itemmall_limit_amount (account_id, sell_amount, item_id, item_group, item_index, item_num, money_unit) FROM stdin;
\.


--
-- TOC entry 3120 (class 0 OID 42689)
-- Dependencies: 217
-- Data for Name: itemmall_old; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.itemmall_old (item_id, item_group, item_index, item_num, point, sell, note) FROM stdin;
\.


--
-- TOC entry 3106 (class 0 OID 42603)
-- Dependencies: 203
-- Data for Name: lottery; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.lottery (lottery_id, item_index, week, round, item_id, item_amount, probability, num_replay, bulletin, probability_plus1, probability_plus2, probability_plus3) FROM stdin;
40362	1	0	1	40021	1	1	-1	1	15	3	1
40362	2	0	1	40022	1	1	-1	0	10	17	29
40362	3	0	1	43538	2	1	-1	0	15	20	10
40362	4	0	1	49628	1	1	-1	0	1	1	1
40362	1	1	1	40019	5	17	-1	0	5	5	5
40362	2	1	1	40122	30	19	-1	0	4	4	4
40362	3	1	1	40200	1	17	-1	0	5	5	5
40362	4	1	1	40181	2	17	-1	0	4	4	4
40362	5	1	1	40156	2	15.8	-1	0	2	2	2
40362	6	1	1	40030	2	14	-1	1	0.8	0.8	0.8
40362	7	1	1	40370	1	1.1	-1	0	5	5	5
40362	8	1	1	49146	1	1.1	-1	0	0.3	0.3	0.3
40362	1	1	2	40509	1	1	-1	0	4	4	4
40362	2	1	2	40509	1	1	-1	0	4	4	4
40362	3	1	2	40066	1	13.5	-1	0	4	4	4
40362	4	1	2	40368	1	7.5	-1	0	3	3	3
40362	5	1	2	40227	1	31	-1	0	0.8	0.8	0.8
40362	6	1	2	40229	1	5	-1	1	0.1	0.1	0.1
40362	7	1	2	49153	1	2.5	-1	0	0.4	0.4	0.4
40362	8	1	2	40366	1	1.5	-1	1	0.016	0.016	0.016
40362	1	1	3	40509	1	1	-1	0	5	5	5
40362	2	1	3	40509	1	1	-1	0	3	3	3
40362	3	1	3	40509	1	1	-1	1	0.35	0.35	0.35
40362	4	1	3	40509	1	1	-1	0	1	1	1
40362	5	1	3	40791	1	11	-1	0	0.8	0.8	0.8
40362	6	1	3	40490	1	5	-1	1	0.35	0.35	0.35
40362	7	1	3	40225	1	43	-1	0	0.3	0.3	0.3
40362	8	1	3	40378	1	1	-1	1	0.005	0.005	0.005
40362	1	1	4	40509	1	1	-1	0	3	3	3
40362	2	1	4	40509	1	1	-1	1	0.06	0.06	0.06
40362	3	1	4	40509	1	1	-1	1	0.06	0.06	0.06
40362	4	1	4	40509	1	1	-1	0	0.8	0.8	0.8
40362	5	1	4	40509	1	1	-1	0	1	1	1
40362	6	1	4	40509	1	1	-1	1	0.16	0.16	0.16
40362	7	1	4	40369	1	29	-1	1	0.003	0.003	0.003
40362	8	1	4	49143	1	1	-1	1	0.003	0.003	0.003
40362	1	1	5	40509	1	1	-1	0	0.8	0.8	0.8
40362	2	1	5	40509	1	1	-1	0	0.822	0.822	0.822
40362	3	1	5	40509	1	1	-1	1	0.002	0.002	0.002
40362	4	1	5	40509	1	1	-1	1	0.002	0.002	0.002
40362	5	1	5	40509	1	1	-1	1	0.001	0.001	0.001
40362	6	1	5	40509	1	1	-1	1	0.06	0.06	0.06
40362	7	1	5	40509	1	1	-1	1	0.003	0.003	0.003
40362	8	1	5	40370	2	1	-1	1	0.003	0.003	0.003
40362	1	2	1	40203	5	21	-1	0	5	5	5
40362	2	2	1	40205	5	21	-1	0	4	4	4
40362	3	2	1	40207	5	21	-1	0	5	5	5
40362	4	2	1	40269	1	11	-1	0	4	4	4
40362	5	2	1	40271	1	11	-1	0	2	2	2
40362	6	2	1	40333	1	11	-1	1	0.8	0.8	0.8
40362	7	2	1	40337	1	9.9	-1	0	5	5	5
40362	8	2	1	40370	1	1.1	-1	0	0.3	0.3	0.3
40362	1	2	2	40385	1	12	-1	0	4	4	4
40362	2	2	2	40386	1	1	-1	0	4	4	4
40362	3	2	2	40387	1	12	-1	0	4	4	4
40362	4	2	2	40388	1	1	-1	0	3	3	3
40362	5	2	2	40389	1	12	-1	0	0.8	0.8	0.8
40362	6	2	2	40390	1	1	-1	1	0.1	0.1	0.1
40362	7	2	2	40391	1	12	-1	0	0.4	0.4	0.4
40362	8	2	2	40392	1	1	-1	1	0.016	0.016	0.016
40362	1	2	3	40001	1	3	-1	0	5	5	5
40362	2	2	3	40004	1	3	-1	0	3	3	3
40362	3	2	3	40007	1	3	-1	1	0.35	0.35	0.35
40362	4	2	3	40010	1	3	-1	0	1	1	1
40362	5	2	3	40013	1	3	-1	0	0.8	0.8	0.8
40362	6	2	3	40016	1	3	-1	1	0.35	0.35	0.35
40362	7	2	3	40010	1	3	-1	0	0.3	0.3	0.3
40362	8	2	3	40004	1	3	-1	1	0.005	0.005	0.005
40362	1	2	4	40265	1	3	-1	0	3	3	3
40362	2	2	4	40266	1	1	-1	1	0.06	0.06	0.06
40362	3	2	4	40267	1	3	-1	1	0.06	0.06	0.06
40362	4	2	4	40268	1	1	-1	0	0.8	0.8	0.8
40362	5	2	4	40331	1	3	-1	0	1	1	1
40362	6	2	4	40332	1	1	-1	1	0.16	0.16	0.16
40362	7	2	4	40335	1	3	-1	1	0.003	0.003	0.003
40362	8	2	4	40336	1	1	-1	1	0.003	0.003	0.003
40362	1	2	5	40459	1	1.5	-1	0	0.8	0.8	0.8
40362	2	2	5	40460	1	1	-1	0	0.822	0.822	0.822
40362	3	2	5	40461	1	1.5	-1	1	0.002	0.002	0.002
40362	4	2	5	40462	1	1	-1	1	0.002	0.002	0.002
40362	5	2	5	40463	1	1.5	-1	1	0.001	0.001	0.001
40362	6	2	5	40464	1	1	-1	1	0.06	0.06	0.06
40362	7	2	5	40511	1	1.5	-1	1	0.003	0.003	0.003
40362	8	2	5	40512	1	1	-1	1	0.003	0.003	0.003
40362	1	3	1	40019	5	17	-1	0	5	5	5
40362	2	3	1	40122	30	19	-1	0	4	4	4
40362	3	3	1	40200	1	17	-1	0	5	5	5
40362	4	3	1	40181	2	17	-1	0	4	4	4
40362	5	3	1	40156	2	15.8	-1	0	2	2	2
40362	6	3	1	40030	2	14	-1	1	0.8	0.8	0.8
40362	7	3	1	40370	1	1.1	-1	0	5	5	5
40362	8	3	1	49149	1	1.1	-1	0	0.3	0.3	0.3
40362	1	3	2	40509	1	1	-1	0	4	4	4
40362	2	3	2	40509	1	1	-1	0	4	4	4
40362	3	3	2	40067	1	13.5	-1	0	4	4	4
40362	4	3	2	40368	1	7.5	-1	0	3	3	3
40362	5	3	2	40227	1	31	-1	0	0.8	0.8	0.8
40362	6	3	2	40226	1	5	-1	1	0.1	0.1	0.1
40362	7	3	2	49150	1	1.5	-1	0	0.4	0.4	0.4
40362	8	3	2	40366	1	1.5	-1	1	0.016	0.016	0.016
40362	1	3	3	40509	1	1	-1	0	5	5	5
40362	2	3	3	40509	1	1	-1	0	3	3	3
40362	3	3	3	40509	1	1	-1	1	0.35	0.35	0.35
40362	4	3	3	40509	1	1	-1	0	1	1	1
40362	5	3	3	40692	1	11	-1	0	0.8	0.8	0.8
40362	6	3	3	40368	1	6	-1	1	0.35	0.35	0.35
40362	7	3	3	40224	1	43	-1	0	0.3	0.3	0.3
40362	8	3	3	40605	1	1	-1	1	0.005	0.005	0.005
40362	1	3	4	40509	1	1	-1	0	3	3	3
40362	2	3	4	40509	1	1	-1	1	0.06	0.06	0.06
40362	3	3	4	40509	1	1	-1	1	0.06	0.06	0.06
40362	4	3	4	40509	1	1	-1	0	0.8	0.8	0.8
40362	5	3	4	40509	1	1	-1	0	1	1	1
40362	6	3	4	40509	1	1	-1	1	0.16	0.16	0.16
40362	7	3	4	40372	1	9	-1	1	0.003	0.003	0.003
40362	8	3	4	40372	20	1	-1	1	0.003	0.003	0.003
40362	1	3	5	40509	1	1	-1	0	0.8	0.8	0.8
40362	2	3	5	40509	1	1	-1	0	0.822	0.822	0.822
40362	3	3	5	40509	1	1	-1	1	0.002	0.002	0.002
40362	4	3	5	40509	1	1	-1	1	0.002	0.002	0.002
40362	5	3	5	40509	1	1	-1	1	0.001	0.001	0.001
40362	6	3	5	40509	1	1	-1	1	0.06	0.06	0.06
40362	7	3	5	40509	1	1	-1	1	0.003	0.003	0.003
40362	8	3	5	40370	2	1	-1	1	0.003	0.003	0.003
40362	1	4	1	40616	1	15	-1	0	5	5	5
40362	2	4	1	40617	1	14	-1	0	4	4	4
40362	3	4	1	40618	1	14	-1	0	5	5	5
40362	4	4	1	40619	1	14	-1	0	4	4	4
40362	5	4	1	40620	1	14	-1	0	2	2	2
40362	6	4	1	40621	1	14	-1	1	0.8	0.8	0.8
40362	7	4	1	40622	1	14	-1	0	5	5	5
40362	8	4	1	40608	1	1	-1	0	0.3	0.3	0.3
40362	1	4	2	40182	1	18.5	-1	0	4	4	4
40362	2	4	2	40231	1	18.5	-1	0	4	4	4
40362	3	4	2	40157	5	19	-1	0	4	4	4
40362	4	4	2	40368	1	7.5	-1	0	3	3	3
40362	5	4	2	40066	1	13.5	-1	0	0.8	0.8	0.8
40362	6	4	2	40226	1	5	-1	1	0.1	0.1	0.1
40362	7	4	2	49143	1	1.5	-1	0	0.4	0.4	0.4
40362	8	4	2	40366	1	1	-1	1	0.016	0.016	0.016
40362	1	4	3	41054	1	11	-1	0	5	5	5
40362	2	4	3	41053	1	11	-1	0	3	3	3
40362	3	4	3	40112	1	11	-1	1	0.35	0.35	0.35
40362	4	4	3	49029	1	11	-1	0	1	1	1
40362	5	4	3	40465	1	8	-1	0	0.8	0.8	0.8
40362	6	4	3	40368	1	5	-1	1	0.35	0.35	0.35
40362	7	4	3	40507	1	5	-1	0	0.3	0.3	0.3
40362	8	4	3	40379	1	1	-1	1	0.005	0.005	0.005
40362	1	4	4	40241	1	8	-1	0	3	3	3
40362	2	4	4	40182	3	7.5	-1	1	0.06	0.06	0.06
40362	3	4	4	41091	1	11	-1	1	0.06	0.06	0.06
40362	4	4	4	40022	10	8	-1	0	0.8	0.8	0.8
40362	5	4	4	40512	1	1.5	-1	0	1	1	1
40362	6	4	4	40354	1	5	-1	1	0.16	0.16	0.16
40362	7	4	4	40466	1	1.5	-1	1	0.003	0.003	0.003
40362	8	4	4	40692	1	1.5	-1	1	0.003	0.003	0.003
40362	1	4	5	40373	1	1.5	-1	0	0.8	0.8	0.8
40362	2	4	5	40374	1	1.1	-1	0	0.822	0.822	0.822
40362	3	4	5	40459	1	1.5	-1	1	0.002	0.002	0.002
40362	4	4	5	40460	1	1.1	-1	1	0.002	0.002	0.002
40362	5	4	5	40461	1	1.5	-1	1	0.001	0.001	0.001
40362	6	4	5	40462	1	1.1	-1	1	0.06	0.06	0.06
40362	7	4	5	40463	1	1.5	-1	1	0.003	0.003	0.003
40362	8	4	5	40464	1	1.1	-1	1	0.003	0.003	0.003
40362	1	5	1	40019	5	17	-1	0	5	5	5
40362	2	5	1	40122	30	19	-1	0	4	4	4
40362	3	5	1	40200	1	17	-1	0	5	5	5
40362	4	5	1	40181	2	17	-1	0	4	4	4
40362	5	5	1	40156	2	15.8	-1	0	2	2	2
40362	6	5	1	40030	2	14	-1	1	0.8	0.8	0.8
40362	7	5	1	40370	1	1.1	-1	0	5	5	5
40362	8	5	1	49149	1	1.1	-1	0	0.3	0.3	0.3
40362	1	5	2	40509	1	1	-1	0	4	4	4
40362	2	5	2	40509	1	1	-1	0	4	4	4
40362	3	5	2	40157	5	34.5	-1	0	4	4	4
40362	4	5	2	40368	1	7.5	-1	0	3	3	3
40362	5	5	2	40227	1	31	-1	0	0.8	0.8	0.8
40362	6	5	2	40223	1	5	-1	1	0.1	0.1	0.1
40362	7	5	2	49153	1	2.5	-1	0	0.4	0.4	0.4
40362	8	5	2	40366	1	1.5	-1	1	0.016	0.016	0.016
40362	1	5	3	40509	1	1	-1	0	5	5	5
40362	2	5	3	40509	1	1	-1	0	3	3	3
40362	3	5	3	40509	1	1	-1	1	0.35	0.35	0.35
40362	4	5	3	40509	1	1	-1	0	1	1	1
40362	5	5	3	40791	1	11	-1	0	0.8	0.8	0.8
40362	6	5	3	40368	1	5	-1	1	0.35	0.35	0.35
40362	7	5	3	40225	1	43	-1	0	0.3	0.3	0.3
40362	8	5	3	40335	1	2	-1	1	0.005	0.005	0.005
40362	1	5	4	40509	1	1	-1	0	3	3	3
40362	2	5	4	40509	1	1	-1	1	0.06	0.06	0.06
40362	3	5	4	40509	1	1	-1	1	0.06	0.06	0.06
40362	4	5	4	40509	1	1	-1	0	0.8	0.8	0.8
40362	5	5	4	40509	1	1	-1	0	1	1	1
40362	6	5	4	40509	1	1	-1	1	0.16	0.16	0.16
40362	7	5	4	40369	1	19	-1	1	0.003	0.003	0.003
40362	8	5	4	49144	1	1	-1	1	0.003	0.003	0.003
40362	1	5	5	40509	1	1	-1	0	0.8	0.8	0.8
40362	2	5	5	40509	1	1	-1	0	0.822	0.822	0.822
40362	3	5	5	40509	1	1	-1	1	0.002	0.002	0.002
40362	4	5	5	40509	1	1	-1	1	0.002	0.002	0.002
40362	5	5	5	40509	1	1	-1	1	0.001	0.001	0.001
40362	6	5	5	40509	1	1	-1	1	0.06	0.06	0.06
40362	7	5	5	40509	1	1	-1	1	0.003	0.003	0.003
40362	8	5	5	40370	2	1	-1	1	0.003	0.003	0.003
40362	1	6	1	40886	1	14	-1	0	5	5	5
40362	2	6	1	40889	1	12	-1	0	4	4	4
40362	3	6	1	40892	1	12	-1	0	5	5	5
40362	4	6	1	40895	1	12	-1	0	4	4	4
40362	5	6	1	40898	1	12	-1	0	2	2	2
40362	6	6	1	40901	1	23	-1	1	0.8	0.8	0.8
40362	7	6	1	40886	1	14	-1	0	5	5	5
40362	8	6	1	49151	1	1	-1	0	0.3	0.3	0.3
40362	1	6	2	40182	1	18.5	-1	0	4	4	4
40362	2	6	2	40231	1	18.5	-1	0	4	4	4
40362	3	6	2	40157	5	19	-1	0	4	4	4
40362	4	6	2	40368	1	7.5	-1	0	3	3	3
40362	5	6	2	40157	5	13.5	-1	0	0.8	0.8	0.8
40362	6	6	2	40226	1	5	-1	1	0.1	0.1	0.1
40362	7	6	2	49152	1	2.5	-1	0	0.4	0.4	0.4
40362	8	6	2	40366	1	1.5	-1	1	0.016	0.016	0.016
40362	1	6	3	40352	1	7	-1	0	5	5	5
40362	2	6	3	40353	1	7	-1	0	3	3	3
40362	3	6	3	40354	1	7	-1	1	0.35	0.35	0.35
40362	4	6	3	40355	1	7	-1	0	1	1	1
40362	5	6	3	40356	1	7	-1	0	0.8	0.8	0.8
40362	6	6	3	40357	1	7	-1	1	0.35	0.35	0.35
40362	7	6	3	40358	1	7	-1	0	0.3	0.3	0.3
40362	8	6	3	40379	1	1	-1	1	0.005	0.005	0.005
40362	1	6	4	41091	1	5	-1	0	3	3	3
40362	2	6	4	40022	10	8	-1	1	0.06	0.06	0.06
40362	3	6	4	40182	4	9.5	-1	1	0.06	0.06	0.06
40362	4	6	4	49145	1	1.5	-1	0	0.8	0.8	0.8
40362	5	6	4	40371	1	8	-1	0	1	1	1
40362	6	6	4	40372	1	8	-1	1	0.16	0.16	0.16
40362	7	6	4	40466	1	1.5	-1	1	0.003	0.003	0.003
40362	8	6	4	40463	1	1.5	-1	1	0.003	0.003	0.003
40362	1	6	5	49143	1	1.5	-1	0	0.8	0.8	0.8
40362	2	6	5	49144	1	1.5	-1	0	0.822	0.822	0.822
40362	3	6	5	49145	1	1.5	-1	1	0.002	0.002	0.002
40362	4	6	5	49146	1	1.5	-1	1	0.002	0.002	0.002
40362	5	6	5	49147	1	1.5	-1	1	0.001	0.001	0.001
40362	6	6	5	49148	1	1.5	-1	1	0.06	0.06	0.06
40362	7	6	5	49149	1	1.5	-1	1	0.003	0.003	0.003
40362	8	6	5	49150	1	1.5	-1	1	0.003	0.003	0.003
40362	1	7	1	40616	1	15	-1	0	5	5	5
40362	2	7	1	40617	1	14	-1	0	4	4	4
40362	3	7	1	40618	1	14	-1	0	5	5	5
40362	4	7	1	40619	1	14	-1	0	4	4	4
40362	5	7	1	40620	1	14	-1	0	2	2	2
40362	6	7	1	40621	1	14	-1	1	0.8	0.8	0.8
40362	7	7	1	40622	1	14	-1	0	5	5	5
40362	8	7	1	40608	1	1	-1	0	0.3	0.3	0.3
40362	1	7	2	40182	1	18.5	-1	0	4	4	4
40362	2	7	2	40231	1	18.5	-1	0	4	4	4
40362	3	7	2	40157	5	19	-1	0	4	4	4
40362	4	7	2	40368	1	7.5	-1	0	3	3	3
40362	5	7	2	40067	1	13.5	-1	0	0.8	0.8	0.8
40362	6	7	2	40226	1	5	-1	1	0.1	0.1	0.1
40362	7	7	2	49154	1	2.5	-1	0	0.4	0.4	0.4
40362	8	7	2	40366	1	1.5	-1	1	0.016	0.016	0.016
40362	1	7	3	41053	1	11	-1	0	5	5	5
40362	2	7	3	41054	1	11	-1	0	3	3	3
40362	3	7	3	41053	1	11	-1	1	0.35	0.35	0.35
40362	4	7	3	40112	1	11	-1	0	1	1	1
40362	5	7	3	49147	1	1	-1	0	0.8	0.8	0.8
40362	6	7	3	40368	1	5	-1	1	0.35	0.35	0.35
40362	7	7	3	40507	1	5	-1	0	0.3	0.3	0.3
40362	8	7	3	40379	1	1	-1	1	0.005	0.005	0.005
40362	1	7	4	40472	1	6	-1	0	3	3	3
40362	2	7	4	40473	1	6	-1	1	0.06	0.06	0.06
40362	3	7	4	40474	1	6	-1	1	0.06	0.06	0.06
40362	4	7	4	40475	1	6	-1	0	0.8	0.8	0.8
40362	5	7	4	40476	1	1	-1	0	1	1	1
40362	6	7	4	40477	1	5	-1	1	0.16	0.16	0.16
40362	7	7	4	40478	1	5	-1	1	0.003	0.003	0.003
40362	8	7	4	40479	1	5	-1	1	0.003	0.003	0.003
40362	1	7	5	34279	50	1.8	-1	0	0.8	0.8	0.8
40362	2	7	5	40437	1	1.7	-1	0	0.822	0.822	0.822
40362	3	7	5	40350	1	6.9	-1	1	0.002	0.002	0.002
40362	4	7	5	40511	1	1.1	-1	1	0.002	0.002	0.002
40362	5	7	5	40400	1	5	-1	1	0.001	0.001	0.001
40362	6	7	5	40265	1	3	-1	1	0.06	0.06	0.06
40362	7	7	5	49148	1	1	-1	1	0.003	0.003	0.003
40362	8	7	5	40463	1	1.5	-1	1	0.003	0.003	0.003
34279	1	0	1	34428	1	1	-1	1	20	10	1
34279	2	0	1	42899	1	1	-1	0	20	20	20
34279	3	0	1	26185	3	1	-1	0	10	20	29
34279	4	0	1	26187	1	1	-1	0	1	1	1
34279	1	1	1	31970	4	16	-1	0	0.006	0.006	0.006
34279	2	1	1	31975	4	16	-1	0	0.006	0.006	0.006
34279	3	1	1	31603	30	21	-1	0	6	6	6
34279	4	1	1	31605	30	21	-1	0	6	6	6
34279	5	1	1	32990	6	21	-1	0	0.006	0.006	0.006
34279	6	1	1	26360	1	2	-1	0	0.006	0.006	0.006
34279	7	1	1	26369	1	2	-1	0	10	10	10
34279	8	1	1	26941	1	2	-1	0	1	1	1
34279	1	1	2	31971	4	12	-1	0	2	2	2
34279	2	1	2	31976	4	12	-1	0	2	2	2
34279	3	1	2	31606	30	12	-1	0	5	5	5
34279	4	1	2	31607	30	12	-1	0	5	5	5
34279	5	1	2	39921	50	8	-1	0	0.006	0.006	0.006
34279	6	1	2	25276	1	8	-1	0	0.006	0.006	0.006
34279	7	1	2	25764	10	3	-1	0	0.006	0.006	0.006
34279	8	1	2	25272	1	3	-1	0	0.013	0.013	0.013
34279	1	1	3	31972	4	11	-1	0	1	1	1
34279	2	1	3	31977	4	11	-1	0	1	1	1
34279	3	1	3	31608	60	8	-1	0	5	5	5
34279	4	1	3	31609	60	8	-1	0	0.23	0.23	0.23
34279	5	1	3	34428	1	3	-1	0	0.005	0.005	0.005
34279	6	1	3	36915	1	1	-1	1	0.005	0.005	0.005
34279	7	1	3	34210	3	3.5	-1	0	0.5	0.5	0.5
34279	8	1	3	28775	1	7.5	-1	0	0.001	0.001	0.001
34279	1	1	4	34155	4	7	-1	0	0.5	0.5	0.5
34279	2	1	4	34156	4	7	-1	0	0.5	0.5	0.5
34279	3	1	4	31610	60	6.5	-1	0	0.8	0.8	0.8
34279	4	1	4	31611	60	6.5	-1	0	0.8	0.8	0.8
34279	5	1	4	34409	1	7	-1	0	0.001	0.001	0.001
34279	6	1	4	26423	1	2	-1	1	0.001	0.001	0.001
34279	7	1	4	26432	1	2	-1	1	0.001	0.001	0.001
34279	8	1	4	27004	1	2	-1	1	0.25	0.25	0.25
34279	1	1	5	39260	4	4	-1	0	0.05	0.05	0.05
34279	2	1	5	39261	4	4	-1	0	0.025	0.025	0.025
34279	3	1	5	34427	1	8	-1	0	0.025	0.025	0.025
34279	4	1	5	34429	1	1.2	-1	1	0.8	0.8	0.8
34279	5	1	5	42965	1	5	-1	0	1.389	1.389	1.389
34279	6	1	5	34411	1	1.7	-1	1	0.001	0.001	0.001
34279	7	1	5	28779	1	4.1	-1	0	0.001	0.001	0.001
34279	8	1	5	26198	1	1.5	-1	1	0.06	0.06	0.06
34279	1	2	1	31970	4	16	-1	0	0.006	0.006	0.006
34279	2	2	1	31975	4	16	-1	0	0.006	0.006	0.006
34279	3	2	1	31603	30	21	-1	0	6	6	6
34279	4	2	1	31605	30	21	-1	0	6	6	6
34279	5	2	1	32990	6	21	-1	0	0.006	0.006	0.006
34279	6	2	1	26359	1	2	-1	0	0.006	0.006	0.006
34279	7	2	1	26363	1	2	-1	0	10	10	10
34279	8	2	1	26944	1	2	-1	0	1	1	1
34279	1	2	2	31971	4	12	-1	0	2	2	2
34279	2	2	2	31976	4	12	-1	0	2	2	2
34279	3	2	2	31606	30	12	-1	0	5	5	5
34279	4	2	2	31607	30	12	-1	0	5	5	5
34279	5	2	2	39921	50	8	-1	0	0.006	0.006	0.006
34279	6	2	2	25276	1	8	-1	0	0.006	0.006	0.006
34279	7	2	2	25764	10	3	-1	0	0.006	0.006	0.006
34279	8	2	2	25272	1	3	-1	0	0.013	0.013	0.013
34279	1	2	3	31972	4	11	-1	0	1	1	1
34279	2	2	3	31977	4	11	-1	0	1	1	1
34279	3	2	3	31608	60	8	-1	0	0.23	0.23	0.23
34279	4	2	3	31609	60	8	-1	0	5	5	5
34279	5	2	3	34428	1	3	-1	0	0.005	0.005	0.005
34279	6	2	3	34410	1	1	-1	1	0.005	0.005	0.005
34279	7	2	3	34211	3	3.5	-1	0	0.5	0.5	0.5
34279	8	2	3	28771	1	7.5	-1	0	0.001	0.001	0.001
34279	1	2	4	34155	4	7	-1	0	0.5	0.5	0.5
34279	2	2	4	34156	4	7	-1	0	0.5	0.5	0.5
34279	3	2	4	31610	60	6.5	-1	0	0.8	0.8	0.8
34279	4	2	4	31611	60	6.5	-1	0	0.8	0.8	0.8
34279	5	2	4	34409	1	7	-1	0	0.001	0.001	0.001
34279	6	2	4	26422	1	2	-1	1	0.001	0.001	0.001
34279	7	2	4	26426	1	2	-1	1	0.001	0.001	0.001
34279	8	2	4	27007	1	2	-1	1	0.25	0.25	0.25
34279	1	2	5	39260	4	4	-1	0	0.05	0.05	0.05
34279	2	2	5	39261	4	4	-1	0	0.025	0.025	0.025
34279	3	2	5	34427	1	8	-1	0	0.025	0.025	0.025
34279	4	2	5	34429	1	1.2	-1	1	0.8	0.8	0.8
34279	5	2	5	42965	1	5	-1	0	1.389	1.389	1.389
34279	6	2	5	36914	1	1.7	-1	1	0.001	0.001	0.001
34279	7	2	5	28778	1	4.1	-1	0	0.001	0.001	0.001
34279	8	2	5	26197	1	1.5	-1	1	0.06	0.06	0.06
34279	1	3	1	31970	4	16	-1	0	0.006	0.006	0.006
34279	2	3	1	31975	4	16	-1	0	0.006	0.006	0.006
34279	3	3	1	31603	30	21	-1	0	6	6	6
34279	4	3	1	31605	30	21	-1	0	6	6	6
34279	5	3	1	32990	6	21	-1	0	0.006	0.006	0.006
34279	6	3	1	26366	1	2	-1	0	0.006	0.006	0.006
34279	7	3	1	26361	1	2	-1	0	10	10	10
34279	8	3	1	26947	1	2	-1	0	1	1	1
34279	1	3	2	31971	4	12	-1	0	2	2	2
34279	2	3	2	31976	4	12	-1	0	2	2	2
34279	3	3	2	31606	30	12	-1	0	5	5	5
34279	4	3	2	31607	30	12	-1	0	5	5	5
34279	5	3	2	39921	50	8	-1	0	0.006	0.006	0.006
34279	6	3	2	25276	1	8	-1	0	0.006	0.006	0.006
34279	7	3	2	25764	10	3	-1	0	0.006	0.006	0.006
34279	8	3	2	25272	1	3	-1	0	0.013	0.013	0.013
34279	1	3	3	31972	4	11	-1	0	1	1	1
34279	2	3	3	31977	4	11	-1	0	1	1	1
34279	3	3	3	31608	60	8	-1	0	5	5	5
34279	4	3	3	31609	60	8	-1	0	0.23	0.23	0.23
34279	5	3	3	34428	1	3	-1	0	0.005	0.005	0.005
34279	6	3	3	36916	1	1	-1	1	0.005	0.005	0.005
34279	7	3	3	34209	3	3.5	-1	0	0.5	0.5	0.5
34279	8	3	3	28774	1	7.5	-1	0	0.001	0.001	0.001
34279	1	3	4	34155	4	7	-1	0	0.5	0.5	0.5
34279	2	3	4	34156	4	7	-1	0	0.5	0.5	0.5
34279	3	3	4	31610	60	6.5	-1	0	0.8	0.8	0.8
34279	4	3	4	31611	60	6.5	-1	0	0.8	0.8	0.8
34279	5	3	4	34409	1	7	-1	0	0.001	0.001	0.001
34279	6	3	4	26429	1	2	-1	1	0.001	0.001	0.001
34279	7	3	4	26424	1	2	-1	1	0.001	0.001	0.001
34279	8	3	4	27010	1	2	-1	1	0.25	0.25	0.25
34279	1	3	5	39260	4	4	-1	0	0.05	0.05	0.05
34279	2	3	5	39261	4	4	-1	0	0.025	0.025	0.025
34279	3	3	5	34427	1	8	-1	0	0.025	0.025	0.025
34279	4	3	5	34429	1	1.2	-1	1	0.8	0.8	0.8
34279	5	3	5	42965	1	5	-1	0	1.389	1.389	1.389
34279	6	3	5	34411	1	1.7	-1	1	0.001	0.001	0.001
34279	7	3	5	25622	1	4.1	-1	0	0.001	0.001	0.001
34279	8	3	5	26196	1	1.5	-1	1	0.06	0.06	0.06
34279	1	4	1	31970	4	16	-1	0	0.006	0.006	0.006
34279	2	4	1	31975	4	16	-1	0	0.006	0.006	0.006
34279	3	4	1	31603	30	21	-1	0	6	6	6
34279	4	4	1	31605	30	21	-1	0	6	6	6
34279	5	4	1	32990	6	21	-1	0	0.006	0.006	0.006
34279	6	4	1	26364	1	2	-1	0	0.006	0.006	0.006
34279	7	4	1	26367	1	2	-1	0	10	10	10
34279	8	4	1	26942	1	2	-1	0	1	1	1
34279	1	4	2	31971	4	12	-1	0	2	2	2
34279	2	4	2	31976	4	12	-1	0	2	2	2
34279	3	4	2	31606	30	12	-1	0	5	5	5
34279	4	4	2	31607	30	12	-1	0	5	5	5
34279	5	4	2	39921	50	8	-1	0	0.006	0.006	0.006
34279	6	4	2	25276	1	8	-1	0	0.006	0.006	0.006
34279	7	4	2	25764	10	3	-1	0	0.006	0.006	0.006
34279	8	4	2	25272	1	3	-1	0	0.013	0.013	0.013
34279	1	4	3	31972	4	11	-1	0	1	1	1
34279	2	4	3	31977	4	11	-1	0	1	1	1
34279	3	4	3	31608	60	8	-1	0	0.23	0.23	0.23
34279	4	4	3	31609	60	8	-1	0	5	5	5
34279	5	4	3	34428	1	3	-1	0	0.005	0.005	0.005
34279	6	4	3	34414	1	1	-1	1	0.005	0.005	0.005
34279	7	4	3	34415	1	3.5	-1	0	0.5	0.5	0.5
34279	8	4	3	28776	1	7.5	-1	0	0.001	0.001	0.001
34279	1	4	4	34155	4	7	-1	0	0.5	0.5	0.5
34279	2	4	4	34156	4	7	-1	0	0.5	0.5	0.5
34279	3	4	4	31610	60	6.5	-1	0	0.8	0.8	0.8
34279	4	4	4	31611	60	6.5	-1	0	0.8	0.8	0.8
34279	5	4	4	34409	1	7	-1	0	0.001	0.001	0.001
34279	6	4	4	26427	1	2	-1	1	0.001	0.001	0.001
34279	7	4	4	26430	1	2	-1	1	0.001	0.001	0.001
34279	8	4	4	27005	1	2	-1	1	0.25	0.25	0.25
34279	1	4	5	39260	4	4	-1	0	0.05	0.05	0.05
34279	2	4	5	39261	4	4	-1	0	0.025	0.025	0.025
34279	3	4	5	34427	1	8	-1	0	0.025	0.025	0.025
34279	4	4	5	34429	1	1.2	-1	1	0.8	0.8	0.8
34279	5	4	5	42965	1	5	-1	0	1.389	1.389	1.389
34279	6	4	5	36913	1	1.7	-1	1	0.001	0.001	0.001
34279	7	4	5	26237	1	4.1	-1	0	0.001	0.001	0.001
34279	8	4	5	26238	10	1.5	-1	1	0.06	0.06	0.06
34279	1	5	1	31970	4	16	-1	0	0.006	0.006	0.006
34279	2	5	1	31975	4	16	-1	0	0.006	0.006	0.006
34279	3	5	1	31603	30	21	-1	0	6	6	6
34279	4	5	1	31605	30	21	-1	0	6	6	6
34279	5	5	1	32990	6	21	-1	0	0.006	0.006	0.006
34279	6	5	1	26945	1	2	-1	0	0.006	0.006	0.006
34279	7	5	1	26948	1	2	-1	0	10	10	10
34279	8	5	1	26362	1	2	-1	0	1	1	1
34279	1	5	2	31971	4	12	-1	0	2	2	2
34279	2	5	2	31976	4	12	-1	0	2	2	2
34279	3	5	2	31606	30	12	-1	0	5	5	5
34279	4	5	2	31607	30	12	-1	0	5	5	5
34279	5	5	2	39921	50	8	-1	0	0.006	0.006	0.006
34279	6	5	2	25276	1	8	-1	0	0.006	0.006	0.006
34279	7	5	2	25764	10	3	-1	0	0.006	0.006	0.006
34279	8	5	2	25272	1	3	-1	0	0.013	0.013	0.013
34279	1	5	3	31972	4	11	-1	0	1	1	1
34279	2	5	3	31977	4	11	-1	0	1	1	1
34279	3	5	3	31608	60	8	-1	0	5	5	5
34279	4	5	3	31609	60	8	-1	0	0.23	0.23	0.23
34279	5	5	3	34428	1	3	-1	0	0.005	0.005	0.005
34279	6	5	3	34412	1	1	-1	1	0.005	0.005	0.005
34279	7	5	3	34210	3	3.5	-1	0	0.5	0.5	0.5
34279	8	5	3	28772	1	7.5	-1	0	0.001	0.001	0.001
34279	1	5	4	34155	4	7	-1	0	0.5	0.5	0.5
34279	2	5	4	34156	4	7	-1	0	0.5	0.5	0.5
34279	3	5	4	31610	60	6.5	-1	0	0.8	0.8	0.8
34279	4	5	4	31611	60	6.5	-1	0	0.8	0.8	0.8
34279	5	5	4	34409	1	7	-1	0	0.001	0.001	0.001
34279	6	5	4	27008	1	2	-1	1	0.001	0.001	0.001
34279	7	5	4	27011	1	2	-1	1	0.001	0.001	0.001
34279	8	5	4	26425	1	2	-1	1	0.25	0.25	0.25
34279	1	5	5	39260	4	4	-1	0	0.05	0.05	0.05
34279	2	5	5	39261	4	4	-1	0	0.025	0.025	0.025
34279	3	5	5	34427	1	8	-1	0	0.025	0.025	0.025
34279	4	5	5	34429	1	1.2	-1	1	0.8	0.8	0.8
34279	5	5	5	42965	1	5	-1	0	1.389	1.389	1.389
34279	6	5	5	36919	1	1.7	-1	1	0.001	0.001	0.001
34279	7	5	5	26006	1	4.1	-1	0	0.001	0.001	0.001
34279	8	5	5	26195	1	1.5	-1	1	0.06	0.06	0.06
34279	1	6	1	31970	5	16	-1	0	0.006	0.006	0.006
34279	2	6	1	31975	5	16	-1	0	0.006	0.006	0.006
34279	3	6	1	31603	30	21	-1	0	6	6	6
34279	4	6	1	31605	30	21	-1	0	6	6	6
34279	5	6	1	32990	6	21	-1	0	0.006	0.006	0.006
34279	6	6	1	26950	1	2	-1	0	0.006	0.006	0.006
34279	7	6	1	26940	1	2	-1	0	10	10	10
34279	8	6	1	26943	1	2	-1	0	1	1	1
34279	1	6	2	31971	4	12	-1	0	2	2	2
34279	2	6	2	31976	4	12	-1	0	2	2	2
34279	3	6	2	31606	30	12	-1	0	5	5	5
34279	4	6	2	31607	30	12	-1	0	5	5	5
34279	5	6	2	39921	50	8	-1	0	0.006	0.006	0.006
34279	6	6	2	25276	1	8	-1	0	0.006	0.006	0.006
34279	7	6	2	25764	10	3	-1	0	0.006	0.006	0.006
34279	8	6	2	25272	1	3	-1	0	0.013	0.013	0.013
34279	1	6	3	31972	4	11	-1	0	1	1	1
34279	2	6	3	31977	4	11	-1	0	1	1	1
34279	3	6	3	31608	60	8	-1	0	0.23	0.23	0.23
34279	4	6	3	31609	60	8	-1	0	5	5	5
34279	5	6	3	34428	1	3	-1	0	0.005	0.005	0.005
34279	6	6	3	34414	1	1	-1	1	0.005	0.005	0.005
34279	7	6	3	34211	3	3.5	-1	0	0.5	0.5	0.5
34279	8	6	3	28773	1	7.5	-1	0	0.001	0.001	0.001
34279	1	6	4	34155	4	7	-1	0	0.5	0.5	0.5
34279	2	6	4	34156	4	7	-1	0	0.5	0.5	0.5
34279	3	6	4	31610	60	6.5	-1	0	0.8	0.8	0.8
34279	4	6	4	31611	60	6.5	-1	0	0.8	0.8	0.8
34279	5	6	4	34409	1	7	-1	0	0.001	0.001	0.001
34279	6	6	4	27013	1	2	-1	1	0.001	0.001	0.001
34279	7	6	4	27003	1	2	-1	1	0.001	0.001	0.001
34279	8	6	4	27006	1	2	-1	1	0.25	0.25	0.25
34279	1	6	5	39260	4	4	-1	0	0.05	0.05	0.05
34279	2	6	5	39261	4	4	-1	0	0.025	0.025	0.025
34279	3	6	5	34427	1	8	-1	0	0.025	0.025	0.025
34279	4	6	5	34429	1	1.2	-1	1	0.8	0.8	0.8
34279	5	6	5	42965	1	5	-1	0	1.389	1.389	1.389
34279	6	6	5	36918	1	1.7	-1	1	0.001	0.001	0.001
34279	7	6	5	26004	1	4.1	-1	0	0.001	0.001	0.001
34279	8	6	5	26005	1	1.5	-1	1	0.06	0.06	0.06
34279	1	7	1	31970	4	16	-1	0	0.006	0.006	0.006
34279	2	7	1	31975	4	16	-1	0	0.006	0.006	0.006
34279	3	7	1	31603	30	21	-1	0	6.246	6.246	6.246
34279	4	7	1	31605	30	21	-1	0	6	6	6
34279	5	7	1	32990	6	21	-1	0	0.006	0.006	0.006
34279	6	7	1	26368	1	2	-1	0	0.006	0.006	0.006
34279	7	7	1	26946	1	2	-1	0	10	10	10
34279	8	7	1	26949	1	2	-1	0	1	1	1
34279	1	7	2	31971	4	12	-1	0	2	2	2
34279	2	7	2	31976	4	12	-1	0	2	2	2
34279	3	7	2	31606	30	12	-1	0	5	5	5
34279	4	7	2	31607	30	12	-1	0	5	5	5
34279	5	7	2	39921	50	8	-1	0	0.006	0.006	0.006
34279	6	7	2	25276	1	8	-1	0	0.006	0.006	0.006
34279	7	7	2	25764	10	3	-1	0	0.006	0.006	0.006
34279	8	7	2	25272	1	3	-1	0	0.013	0.013	0.013
34279	1	7	3	31972	4	11	-1	0	1	1	1
34279	2	7	3	31977	4	11	-1	0	1	1	1
34279	3	7	3	31608	60	8	-1	0	5	5	5
34279	4	7	3	31609	60	8	-1	0	0.23	0.23	0.23
34279	5	7	3	34428	1	3	-1	0	0.005	0.005	0.005
34279	6	7	3	34413	1	1	-1	1	0.005	0.005	0.005
34279	7	7	3	34209	3	3.5	-1	0	0.5	0.5	0.5
34279	8	7	3	28777	1	7.5	-1	0	0.001	0.001	0.001
34279	1	7	4	34155	4	7	-1	0	0.5	0.5	0.5
34279	2	7	4	34156	4	7	-1	0	0.5	0.5	0.5
34279	3	7	4	31610	60	6.5	-1	0	0.8	0.8	0.8
34279	4	7	4	31611	60	6.5	-1	0	0.8	0.8	0.8
34279	5	7	4	34409	1	7	-1	0	0.001	0.001	0.001
34279	6	7	4	26431	1	2	-1	1	0.001	0.001	0.001
34279	7	7	4	27009	1	2	-1	1	0.001	0.001	0.001
34279	8	7	4	27012	1	2	-1	1	0.004	0.004	0.004
34279	1	7	5	39260	4	4	-1	0	0.05	0.05	0.05
34279	2	7	5	39261	4	4	-1	0	0.025	0.025	0.025
34279	3	7	5	34427	1	8	-1	0	0.025	0.025	0.025
34279	4	7	5	34429	1	1.2	-1	1	0.8	0.8	0.8
34279	5	7	5	42965	1	5	-1	0	1.389	1.389	1.389
34279	6	7	5	26001	1	1.3	-1	1	0.001	0.001	0.001
34279	7	7	5	26002	1	1.3	-1	1	0.001	0.001	0.001
34279	8	7	5	26003	1	2.7	-1	1	0.06	0.06	0.06
\.


--
-- TOC entry 3121 (class 0 OID 42697)
-- Dependencies: 218
-- Data for Name: worlds; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.worlds (id, name, ip, port, online_user, maxnum_user, state, version, show_order) FROM stdin;
1010	Dev-CH1	192.168.0.110	5567	1	1000	0	Unknown_Version	0
\.


--
-- TOC entry 3131 (class 0 OID 0)
-- Dependencies: 215
-- Name: item_receivable_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.item_receivable_id_seq', 1, true);


--
-- TOC entry 3132 (class 0 OID 0)
-- Dependencies: 219
-- Name: worlds_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.worlds_id_seq', 1, false);


--
-- TOC entry 2952 (class 2606 OID 42710)
-- Name: accounts accounts_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.accounts
    ADD CONSTRAINT accounts_pkey PRIMARY KEY (id);


--
-- TOC entry 2956 (class 2606 OID 42712)
-- Name: character_number character_number_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.character_number
    ADD CONSTRAINT character_number_pkey PRIMARY KEY (account_id, world_id);


--
-- TOC entry 2958 (class 2606 OID 42714)
-- Name: configuration configuration_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.configuration
    ADD CONSTRAINT configuration_pkey PRIMARY KEY (schema_version);


--
-- TOC entry 2960 (class 2606 OID 42716)
-- Name: crashlog crashlog_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.crashlog
    ADD CONSTRAINT crashlog_pkey PRIMARY KEY (host, eth0, regdate);


--
-- TOC entry 2962 (class 2606 OID 42718)
-- Name: crashmonitor crashmonitor_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.crashmonitor
    ADD CONSTRAINT crashmonitor_pkey PRIMARY KEY (host, daemon, eth0);


--
-- TOC entry 2965 (class 2606 OID 42720)
-- Name: exchange_pin exchange_pin_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.exchange_pin
    ADD CONSTRAINT exchange_pin_pkey PRIMARY KEY (pin);


--
-- TOC entry 2968 (class 2606 OID 42722)
-- Name: gm_tool_accounts gm_tool_accounts_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.gm_tool_accounts
    ADD CONSTRAINT gm_tool_accounts_pkey PRIMARY KEY (id);


--
-- TOC entry 2970 (class 2606 OID 42724)
-- Name: item_receipt item_receipt_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.item_receipt
    ADD CONSTRAINT item_receipt_pkey PRIMARY KEY (id);


--
-- TOC entry 2973 (class 2606 OID 42726)
-- Name: item_receivable item_receivable_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.item_receivable
    ADD CONSTRAINT item_receivable_pkey PRIMARY KEY (id);


--
-- TOC entry 2976 (class 2606 OID 42728)
-- Name: itemmall_old itemmall_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.itemmall_old
    ADD CONSTRAINT itemmall_pkey PRIMARY KEY (item_id, item_group);


--
-- TOC entry 2978 (class 2606 OID 42730)
-- Name: worlds worlds_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.worlds
    ADD CONSTRAINT worlds_pkey PRIMARY KEY (id);


--
-- TOC entry 2950 (class 1259 OID 42731)
-- Name: account_username_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX account_username_index ON public.accounts USING btree (username);


--
-- TOC entry 2963 (class 1259 OID 42732)
-- Name: exchange_pin_account_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX exchange_pin_account_index ON public.exchange_pin USING btree (account_id);


--
-- TOC entry 2966 (class 1259 OID 42733)
-- Name: gm_tool_account_name_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX gm_tool_account_name_index ON public.gm_tool_accounts USING btree (account_name);


--
-- TOC entry 2954 (class 1259 OID 42610)
-- Name: high_lottery_pi_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX high_lottery_pi_index ON public.high_lottery USING btree (lottery_id, item_index, week, round);


--
-- TOC entry 2971 (class 1259 OID 42734)
-- Name: item_receivable_account_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX item_receivable_account_index ON public.item_receivable USING btree (account_name);


--
-- TOC entry 2974 (class 1259 OID 42735)
-- Name: itemmall_pi_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX itemmall_pi_index ON public.itemmall USING btree (item_group, item_index, money_unit);


--
-- TOC entry 2953 (class 1259 OID 42606)
-- Name: lottery_pi_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX lottery_pi_index ON public.lottery USING btree (lottery_id, item_index, week, round);


-- Completed on 2023-01-15 10:23:47

--
-- PostgreSQL database dump complete
--

