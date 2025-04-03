--
-- Data for Name: myuser; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.myuser (id, fullname, email, mobile) FROM stdin;
3	undefined	undefined	undefined
4	harshit	h.a@g.com	6546546541
5	harshit	asdf.asdf@g.com	6546546544
6	harshit	asdf.asdf@g.com	6546546544
\.

--
-- Name: myuser_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.myuser_id_seq', 6, true);
