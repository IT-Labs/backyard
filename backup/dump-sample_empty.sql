--
-- PostgreSQL database dump
--

-- Dumped from database version 12.4
-- Dumped by pg_dump version 14.0

-- Started on 2021-10-30 08:46:29

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
-- TOC entry 3 (class 2615 OID 2200)
-- Name: public; Type: SCHEMA; Schema: -; Owner: -
--

CREATE SCHEMA public;


--
-- TOC entry 2928 (class 0 OID 0)
-- Dependencies: 3
-- Name: SCHEMA public; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON SCHEMA public IS 'standard public schema';


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 202 (class 1259 OID 106530)
-- Name: flyway_schema_history; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.flyway_schema_history (
    installed_rank integer NOT NULL,
    version character varying(50),
    description character varying(200) NOT NULL,
    type character varying(20) NOT NULL,
    script character varying(1000) NOT NULL,
    checksum integer,
    installed_by character varying(100) NOT NULL,
    installed_on timestamp without time zone DEFAULT now() NOT NULL,
    execution_time integer NOT NULL,
    success boolean NOT NULL
);


--
-- TOC entry 203 (class 1259 OID 106540)
-- Name: item_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.item_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 2147483647
    CACHE 1;


--
-- TOC entry 204 (class 1259 OID 106542)
-- Name: items; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.items (
    id integer DEFAULT nextval('public.item_id_seq'::regclass) NOT NULL,
    name character varying(255) NOT NULL,
    description text,
    status character varying(100) NOT NULL,
    type character varying(100) NOT NULL,
    created timestamp without time zone NOT NULL,
    updated timestamp without time zone NOT NULL,
    guid uuid DEFAULT (md5((random())::text))::uuid NOT NULL,
    created_by uuid NOT NULL,
    updated_by uuid NOT NULL,
    published timestamp without time zone,
    is_public boolean DEFAULT false NOT NULL
);


--
-- TOC entry 2920 (class 0 OID 106530)
-- Dependencies: 202
-- Data for Name: flyway_schema_history; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.flyway_schema_history (installed_rank, version, description, type, script, checksum, installed_by, installed_on, execution_time, success) FROM stdin;
1	1.1	Item	SQL	V1.1__Item.sql	572695683	dev	2021-02-13 15:49:32.784442	16	t
2	1.2	Item	SQL	V1.2__Item.sql	-1657134404	dev	2021-02-13 15:49:32.827527	18	t
3	1.3	Item	SQL	V1.3__Item.sql	958239504	dev	2021-02-13 15:49:32.866029	42	t
\.


--
-- TOC entry 2922 (class 0 OID 106542)
-- Dependencies: 204
-- Data for Name: items; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.items (id, name, description, status, type, created, updated, guid, created_by, updated_by, published, is_public) FROM stdin;
\.


--
-- TOC entry 2929 (class 0 OID 0)
-- Dependencies: 203
-- Name: item_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.item_id_seq', 1, false);


--
-- TOC entry 2788 (class 2606 OID 106538)
-- Name: flyway_schema_history flyway_schema_history_pk; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.flyway_schema_history
    ADD CONSTRAINT flyway_schema_history_pk PRIMARY KEY (installed_rank);


--
-- TOC entry 2791 (class 2606 OID 106550)
-- Name: items items_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.items
    ADD CONSTRAINT items_pkey PRIMARY KEY (id);


--
-- TOC entry 2789 (class 1259 OID 106539)
-- Name: flyway_schema_history_s_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX flyway_schema_history_s_idx ON public.flyway_schema_history USING btree (success);


--
-- TOC entry 2792 (class 1259 OID 106559)
-- Name: ix_items_guid; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX ix_items_guid ON public.items USING btree (guid);


--
-- TOC entry 2793 (class 1259 OID 106561)
-- Name: ix_items_published; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX ix_items_published ON public.items USING btree (published);


-- Completed on 2021-10-30 08:46:29

--
-- PostgreSQL database dump complete
--

