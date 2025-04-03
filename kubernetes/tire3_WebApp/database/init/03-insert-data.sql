COPY public.myuser (id, fullname, email, mobile) FROM stdin;
1	undefined	undefined	undefined
2	harshit	h.a@g.com	6546546541
3	harshit	asdf.asdf@g.com	6546546544
4	harshit	asdf.asdf@g.com	6546546544
\.
SELECT pg_catalog.setval('public.myuser_id_seq', 6, true);