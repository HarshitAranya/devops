--
-- PostgreSQL database dump
--

-- Dumped from database version 16.3
-- Dumped by pg_dump version 16.3

-- Name: myuser; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.myuser (
    id integer NOT NULL,
    fullname character varying(100),
    email character varying(100),
    mobile character varying(11)
);

ALTER TABLE public.myuser OWNER TO postgres;

-- Name: myuser_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.myuser ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.myuser_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

-- Name: myuser myuser_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.myuser
    ADD CONSTRAINT myuser_pkey PRIMARY KEY (id);
