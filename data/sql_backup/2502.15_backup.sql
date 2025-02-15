--
-- PostgreSQL database dump
--

-- Dumped from database version 17.2 (Debian 17.2-1.pgdg120+1)
-- Dumped by pg_dump version 17.2 (Debian 17.2-1.pgdg120+1)

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

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: inquiries; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.inquiries (
    inquiry_id integer NOT NULL,
    inquiry_text text NOT NULL,
    product_id integer,
    product_name character varying(255) NOT NULL,
    quantity integer NOT NULL,
    material character varying(255),
    finishing character varying(255),
    shape character varying(255),
    product_length double precision,
    product_width double precision,
    product_height double precision,
    inquiry_date timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public.inquiries OWNER TO postgres;

--
-- Name: inquiries_inquiry_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.inquiries_inquiry_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.inquiries_inquiry_id_seq OWNER TO postgres;

--
-- Name: inquiries_inquiry_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.inquiries_inquiry_id_seq OWNED BY public.inquiries.inquiry_id;


--
-- Name: products; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.products (
    product_id integer NOT NULL,
    product_name character varying(255) NOT NULL
);


ALTER TABLE public.products OWNER TO postgres;

--
-- Name: products_product_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.products_product_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.products_product_id_seq OWNER TO postgres;

--
-- Name: products_product_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.products_product_id_seq OWNED BY public.products.product_id;


--
-- Name: suppliers; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.suppliers (
    supplier_id integer NOT NULL,
    supplier_name character varying(255) NOT NULL,
    supplier_email character varying(255) NOT NULL
);


ALTER TABLE public.suppliers OWNER TO postgres;

--
-- Name: suppliers_products; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.suppliers_products (
    supplier_id integer NOT NULL,
    product_id integer NOT NULL
);


ALTER TABLE public.suppliers_products OWNER TO postgres;

--
-- Name: suppliers_quotes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.suppliers_quotes (
    supplier_quote_id integer NOT NULL,
    supplier_id integer NOT NULL,
    product_id integer NOT NULL,
    inquiry_id integer NOT NULL,
    cost_average numeric(10,2),
    cost_price numeric(10,2),
    number_days integer,
    distance integer,
    quote_performance double precision,
    supplier_performance double precision,
    quality_item_performance double precision,
    accepted boolean,
    query_date timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public.suppliers_quotes OWNER TO postgres;

--
-- Name: suppliers_quotes_supplier_quote_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.suppliers_quotes_supplier_quote_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.suppliers_quotes_supplier_quote_id_seq OWNER TO postgres;

--
-- Name: suppliers_quotes_supplier_quote_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.suppliers_quotes_supplier_quote_id_seq OWNED BY public.suppliers_quotes.supplier_quote_id;


--
-- Name: suppliers_supplier_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.suppliers_supplier_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.suppliers_supplier_id_seq OWNER TO postgres;

--
-- Name: suppliers_supplier_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.suppliers_supplier_id_seq OWNED BY public.suppliers.supplier_id;


--
-- Name: inquiries inquiry_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.inquiries ALTER COLUMN inquiry_id SET DEFAULT nextval('public.inquiries_inquiry_id_seq'::regclass);


--
-- Name: products product_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.products ALTER COLUMN product_id SET DEFAULT nextval('public.products_product_id_seq'::regclass);


--
-- Name: suppliers supplier_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.suppliers ALTER COLUMN supplier_id SET DEFAULT nextval('public.suppliers_supplier_id_seq'::regclass);


--
-- Name: suppliers_quotes supplier_quote_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.suppliers_quotes ALTER COLUMN supplier_quote_id SET DEFAULT nextval('public.suppliers_quotes_supplier_quote_id_seq'::regclass);


--
-- Data for Name: inquiries; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.inquiries (inquiry_id, inquiry_text, product_id, product_name, quantity, material, finishing, shape, product_length, product_width, product_height, inquiry_date) FROM stdin;
1	I want to buy three notebooks, made of good quality paper, and a rectangular shape.	\N	notebook	3	\N	\N	rectangular	\N	\N	\N	2025-02-12 14:50:20.143204
2	I want to buy three notebooks, made of good quality paper, and a rectangular shape.	\N	notebook	3	\N	\N	rectangular	\N	\N	\N	2025-02-12 14:54:40.638454
3	I want to buy three notebooks, made of good quality paper, and a rectangular shape.	\N	notebook	3	\N	\N	rectangular	\N	\N	\N	2025-02-12 14:58:16.394628
4	I want to buy three notebooks, made of good quality paper, and a rectangular shape.	1	notebooks	3	good quality paper	\N	rectangular	\N	\N	\N	2025-02-12 14:59:45.157942
5	I want to buy three notebooks, made of good quality paper, and a rectangular shape.	1	notebooks	3	good quality paper	\N	rectangular	\N	\N	\N	2025-02-12 15:10:34.225478
6	I want to buy three notebooks, made of good quality paper, and a rectangular shape.	1	notebooks	3	good quality paper	\N	rectangular	\N	\N	\N	2025-02-12 15:12:25.970809
7	I want to buy three notebooks, made of good quality paper, and a rectangular shape.	1	notebooks	3	good quality paper	\N	rectangular	\N	\N	\N	2025-02-12 15:15:25.952096
8	I want to buy three notebooks, made of good quality paper, and a rectangular shape.	1	notebooks	3	good quality paper	\N	rectangular	\N	\N	\N	2025-02-12 15:17:43.615113
9	I want to buy three notebooks, made of good quality paper, and a rectangular shape.	1	notebooks	3	good quality paper	\N	rectangular	\N	\N	\N	2025-02-12 15:18:53.37564
10	I want to buy three notebooks, made of good quality paper, and a rectangular shape.	1	notebooks	3	good quality paper	\N	rectangular	\N	\N	\N	2025-02-12 15:20:46.642122
11	I want to buy three notebooks, made of good quality paper, and a rectangular shape.	1	notebooks	3	good quality paper	\N	rectangular	\N	\N	\N	2025-02-12 15:21:27.592002
12	I want to buy three notebooks, made of good quality paper, and a rectangular shape.	1	notebook	3	good quality paper	\N	rectangular	\N	\N	\N	2025-02-12 15:37:43.812612
13	I want to buy three notebooks, made of good quality paper, and a rectangular shape.	1	notebook	3	good quality paper	\N	rectangular	\N	\N	\N	2025-02-12 15:41:43.75337
14	I need 50 business cards printed on premium cardstock with matte finishing.	3	business card	50	premium cardstock	matte	\N	\N	\N	\N	2025-02-13 16:55:59.055784
15	Looking to order 1000 round stickers made of vinyl material.	2	sticker	1000	\N	\N	round	\N	\N	\N	2025-02-13 16:56:00.070861
16	Can I get 5 notebooks with recycled paper and spiral binding?	1	notebook	5	recycled paper	\N	\N	\N	\N	\N	2025-02-13 16:56:01.036434
17	I want to purchase 200 rectangular stickers with glossy finish.	2	sticker	200	\N	\N	rectangular	\N	\N	\N	2025-02-13 16:56:02.032716
18	Need 100 business cards with metallic finish and standard dimensions.	3	business card	100	\N	metallic	\N	\N	\N	\N	2025-02-13 16:56:02.977797
19	Please quote me for 10 notebooks with leather cover and A4 size.	1	notebook	10	leather	\N	A4	\N	\N	\N	2025-02-13 16:56:04.064624
20	I'd like to order 500 die-cut stickers with weather-resistant material.	2	sticker	500	weather-resistant	\N	die-cut	\N	\N	\N	2025-02-13 16:56:05.123089
21	Looking for 250 business cards with rounded corners and premium paper.	3	business card	250	premium paper	rounded corners	\N	\N	\N	\N	2025-02-13 16:56:06.226168
22	We need 25 notebooks with hardcover binding and lined paper.	1	notebook	25	lined paper	hardcover binding	\N	\N	\N	\N	2025-02-13 16:56:07.301696
23	Requesting a quote for 2000 square stickers with removable adhesive.	2	sticker	2000	\N	\N	\N	\N	\N	\N	2025-02-13 16:56:08.142125
24	I want to order 150 business cards with UV coating and standard size.	3	business card	150	\N	UV coating	\N	\N	\N	\N	2025-02-13 16:56:09.074813
25	Need 15 notebooks with kraft paper cover and dotted pages.	1	notebook	15	kraft paper	\N	dotted	\N	\N	\N	2025-02-13 16:56:10.02957
26	Planning to get 300 circular stickers with holographic finish.	2	sticker	300	\N	\N	circular	\N	\N	\N	2025-02-13 16:56:10.930347
27	Would like to purchase 75 business cards made of eco-friendly material.	3	business card	75	eco-friendly	\N	\N	\N	\N	\N	2025-02-13 16:56:11.866471
28	Can you provide 8 notebooks with cloth binding and blank pages?	1	notebook	8	\N	cloth binding	\N	\N	\N	\N	2025-02-13 16:56:12.682483
29	Need a batch of 1500 rectangular stickers with waterproof material.	2	sticker	1500	\N	\N	rectangular	\N	\N	\N	2025-02-13 16:56:13.683778
30	I need five white-collared stickers, of low quality	2	sticker	5	low quality	\N	\N	\N	\N	\N	2025-02-15 18:01:37.013167
31	I need a quote for five hundred business cards, rectangular, in a matte finish	3	business card	500	\N	\N	rectangular	\N	\N	\N	2025-02-15 18:09:53.460979
32	I need a quote for five hundred business cards, rectangular, in a matte finishing	3	business card	500	\N	\N	rectangular	\N	\N	\N	2025-02-15 18:10:09.23988
33	I need a quote for five hundred business cards, rectangular, in a matte finishing	3	business card	500	\N	\N	rectangular	\N	\N	\N	2025-02-15 18:48:58.970177
\.


--
-- Data for Name: products; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.products (product_id, product_name) FROM stdin;
1	notebook
2	sticker
3	business card
\.


--
-- Data for Name: suppliers; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.suppliers (supplier_id, supplier_name, supplier_email) FROM stdin;
1	Office Supply Co	contact@officesupply.com
2	Print Masters	sales@printmasters.com
3	Stationery Plus	info@stationeryplus.com
4	Paper World	orders@paperworld.com
5	Quality Prints	support@qualityprints.com
6	Creative Solutions	hello@creativesol.com
7	Supply Chain Pro	business@supplychain.com
8	Eco Supplies	green@ecosupplies.com
9	Global Stationers	info@globalstat.com
10	Local Print Shop	shop@localprint.com
\.


--
-- Data for Name: suppliers_products; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.suppliers_products (supplier_id, product_id) FROM stdin;
1	1
1	2
2	3
3	1
4	1
4	2
5	3
6	2
6	3
7	1
8	2
9	3
10	1
10	3
\.


--
-- Data for Name: suppliers_quotes; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.suppliers_quotes (supplier_quote_id, supplier_id, product_id, inquiry_id, cost_average, cost_price, number_days, distance, quote_performance, supplier_performance, quality_item_performance, accepted, query_date) FROM stdin;
115	1	1	3	0.73	0.77	19	594	0.77	0.89	82.13	t	2025-02-13 17:15:05.27698
116	1	1	12	0.94	1.02	27	777	0.43	0.55	69.11	f	2025-02-13 17:15:05.27698
117	1	1	11	0.72	0.78	18	954	0.77	0.36	80.9	t	2025-02-13 17:15:05.27698
118	1	1	17	0.40	0.47	5	829	1.05	0.65	91.57	t	2025-02-13 17:15:05.27698
120	1	1	14	0.60	0.68	13	338	0.91	0.88	82.61	t	2025-02-13 17:15:05.27698
121	1	1	18	0.87	0.87	24	226	0.61	1.01	78.14	t	2025-02-13 17:15:05.27698
122	1	1	10	0.48	0.57	8	542	1.03	0.77	95.87	t	2025-02-13 17:15:05.27698
123	1	1	8	0.47	0.49	8	821	0.96	0.48	75.02	t	2025-02-13 17:15:05.27698
124	1	1	15	0.64	0.72	15	176	0.96	1.07	92.7	t	2025-02-13 17:15:05.27698
125	1	1	16	0.94	0.88	28	418	0.53	0.81	72.51	f	2025-02-13 17:15:05.27698
128	1	1	4	0.64	0.74	15	846	0.99	0.53	83.17	t	2025-02-13 17:15:05.27698
129	1	1	5	0.49	0.55	9	359	1.12	0.8	98.78	t	2025-02-13 17:15:05.27698
131	1	1	13	0.98	1.05	29	663	0.61	0.7	68.61	f	2025-02-13 17:15:05.27698
135	1	1	7	0.60	0.54	14	523	0.99	0.73	78.06	t	2025-02-13 17:15:05.27698
136	1	1	2	0.67	0.59	16	727	0.9	0.62	88.06	t	2025-02-13 17:15:05.27698
138	1	1	1	0.79	0.70	21	195	0.71	1.1	75.34	t	2025-02-13 17:15:05.27698
147	1	2	19	0.96	0.99	28	317	0.44	0.95	64.95	f	2025-02-13 17:15:05.27698
149	1	2	20	0.56	0.48	12	120	0.93	1.1	86.44	t	2025-02-13 17:15:05.27698
157	1	2	9	0.50	0.54	9	791	0.95	0.53	76.61	t	2025-02-13 17:15:05.27698
173	2	3	16	0.91	0.96	26	676	0.55	0.68	70.13	f	2025-02-13 17:15:05.27698
175	2	3	7	0.47	0.51	8	777	0.93	0.46	90.03	t	2025-02-13 17:15:05.27698
176	2	3	11	0.61	0.61	14	221	0.78	1.13	79.44	t	2025-02-13 17:15:05.27698
177	2	3	13	0.74	0.80	19	420	0.82	1	73.24	f	2025-02-13 17:15:05.27698
178	2	3	8	0.44	0.46	7	652	1.23	0.57	94.54	t	2025-02-13 17:15:05.27698
179	2	3	14	0.88	0.88	25	162	0.71	1.19	87.02	t	2025-02-13 17:15:05.27698
181	2	3	19	0.80	0.79	22	348	0.61	0.87	72.21	f	2025-02-13 17:15:05.27698
184	2	3	3	0.53	0.52	11	141	1.11	1.11	95.09	t	2025-02-13 17:15:05.27698
186	2	3	18	0.72	0.70	18	532	0.73	0.82	69.64	f	2025-02-13 17:15:05.27698
187	2	3	17	0.60	0.55	13	824	1.04	0.52	81.75	t	2025-02-13 17:15:05.27698
188	2	3	1	0.92	0.94	27	772	0.54	0.64	72.31	f	2025-02-13 17:15:05.27698
191	2	3	9	0.96	0.94	28	408	0.54	0.87	79.02	t	2025-02-13 17:15:05.27698
194	2	3	12	0.92	0.96	27	821	0.68	0.55	77.04	t	2025-02-13 17:15:05.27698
202	3	1	20	0.42	0.51	6	823	1.06	0.68	83.92	t	2025-02-13 17:15:05.27698
203	3	1	12	0.79	0.84	21	610	0.76	0.78	81.51	t	2025-02-13 17:15:05.27698
204	3	1	1	0.80	0.70	22	392	0.7	0.88	82.12	t	2025-02-13 17:15:05.27698
205	3	1	15	0.91	0.84	26	287	0.61	1.11	77.31	t	2025-02-13 17:15:05.27698
206	3	1	13	0.44	0.39	7	119	0.99	0.97	100.1	t	2025-02-13 17:15:05.27698
207	3	1	17	0.49	0.46	9	261	0.95	1.01	93.02	t	2025-02-13 17:15:05.27698
208	3	1	6	0.90	0.96	26	812	0.67	0.49	75.78	t	2025-02-13 17:15:05.27698
209	3	1	19	0.94	1.01	28	823	0.44	0.51	73.06	f	2025-02-13 17:15:05.27698
210	3	1	3	0.55	0.54	11	439	1.11	1.01	90.97	t	2025-02-13 17:15:05.27698
214	3	1	8	0.56	0.52	11	181	0.85	1.12	89.17	t	2025-02-13 17:15:05.27698
215	3	1	18	0.94	0.90	28	592	0.58	0.68	80.44	t	2025-02-13 17:15:05.27698
216	3	1	4	0.72	0.70	18	856	0.79	0.62	75.89	t	2025-02-13 17:15:05.27698
223	3	1	5	0.75	0.77	19	190	0.84	0.92	89.67	t	2025-02-13 17:15:05.27698
226	3	1	14	0.46	0.46	7	85	1	1.2	94.7	t	2025-02-13 17:15:05.27698
231	4	1	3	0.84	0.86	23	940	0.72	0.35	73.02	f	2025-02-13 17:15:05.27698
232	4	1	17	0.58	0.60	13	212	0.88	1.15	85.32	t	2025-02-13 17:15:05.27698
233	4	1	2	0.65	0.70	16	397	0.79	0.95	74.68	f	2025-02-13 17:15:05.27698
234	4	1	9	0.60	0.57	13	457	1.04	0.86	92.17	t	2025-02-13 17:15:05.27698
235	4	1	11	0.61	0.58	14	206	0.9	1.11	78.11	t	2025-02-13 17:15:05.27698
236	4	1	15	0.61	0.68	14	86	0.97	1.27	77.81	t	2025-02-13 17:15:05.27698
237	4	1	20	0.46	0.43	7	647	1.18	0.83	88.25	t	2025-02-13 17:15:05.27698
238	4	1	16	0.90	0.85	26	877	0.51	0.63	67.19	f	2025-02-13 17:15:05.27698
239	4	1	19	0.72	0.67	18	252	0.93	0.91	79.69	t	2025-02-13 17:15:05.27698
242	4	1	13	0.77	0.87	20	192	0.83	1.01	81.05	t	2025-02-13 17:15:05.27698
244	4	1	12	0.46	0.48	7	875	1.11	0.59	93.18	t	2025-02-13 17:15:05.27698
245	4	1	6	0.61	0.53	14	527	1.02	0.83	78.29	t	2025-02-13 17:15:05.27698
247	4	1	8	0.53	0.43	10	446	0.94	0.98	80.64	t	2025-02-13 17:15:05.27698
250	4	1	10	0.90	0.83	26	684	0.61	0.56	76.23	t	2025-02-13 17:15:05.27698
251	4	1	4	0.57	0.47	12	514	1.09	0.89	77.82	t	2025-02-13 17:15:05.27698
254	4	1	7	0.68	0.64	17	501	0.95	0.92	71.54	f	2025-02-13 17:15:05.27698
255	4	1	18	0.90	0.92	26	399	0.67	1.04	71.05	f	2025-02-13 17:15:05.27698
263	4	2	1	0.63	0.53	15	97	0.86	1.14	76.89	t	2025-02-13 17:15:05.27698
265	4	2	5	0.65	0.60	16	325	0.91	0.93	76.88	t	2025-02-13 17:15:05.27698
270	4	2	14	0.43	0.40	6	341	1.25	1.04	96.43	t	2025-02-13 17:15:05.27698
289	5	3	14	0.79	0.79	21	563	0.77	0.87	81.29	t	2025-02-13 17:15:05.27698
290	5	3	18	0.69	0.76	17	842	0.95	0.66	72.92	f	2025-02-13 17:15:05.27698
291	5	3	9	0.72	0.81	18	211	0.77	0.9	84.23	t	2025-02-13 17:15:05.27698
292	5	3	13	0.96	1.00	28	185	0.52	1.04	70.34	f	2025-02-13 17:15:05.27698
293	5	3	3	0.85	0.80	24	758	0.72	0.66	63.42	f	2025-02-13 17:15:05.27698
294	5	3	17	0.66	0.74	16	993	0.89	0.41	68.95	f	2025-02-13 17:15:05.27698
296	5	3	5	0.53	0.45	10	589	1.14	0.78	86.85	t	2025-02-13 17:15:05.27698
300	5	3	20	0.49	0.48	9	883	1.03	0.55	92.84	t	2025-02-13 17:15:05.27698
301	5	3	6	0.76	0.69	20	567	0.69	0.75	69.93	f	2025-02-13 17:15:05.27698
305	5	3	10	0.49	0.44	9	831	1.04	0.6	75.78	t	2025-02-13 17:15:05.27698
309	5	3	12	0.78	0.68	21	866	0.77	0.42	67.48	f	2025-02-13 17:15:05.27698
310	5	3	1	0.49	0.51	9	817	1.02	0.6	88.06	t	2025-02-13 17:15:05.27698
311	5	3	7	0.81	0.75	22	281	0.57	0.95	86.14	t	2025-02-13 17:15:05.27698
314	5	3	16	0.83	0.80	23	581	0.54	0.83	77.37	t	2025-02-13 17:15:05.27698
316	5	3	8	0.89	0.93	25	276	0.73	0.93	67.88	f	2025-02-13 17:15:05.27698
318	6	2	11	0.52	0.45	10	576	1.11	0.69	76.41	t	2025-02-13 17:15:05.27698
319	6	2	19	0.43	0.41	6	334	1.26	0.95	83.61	t	2025-02-13 17:15:05.27698
320	6	2	6	0.54	0.55	11	104	1	1.11	80.21	t	2025-02-13 17:15:05.27698
321	6	2	10	0.47	0.40	8	356	1.21	0.93	98.74	t	2025-02-13 17:15:05.27698
322	6	2	12	0.40	0.39	5	990	1.15	0.48	81.62	t	2025-02-13 17:15:05.27698
324	6	2	14	0.78	0.85	21	628	0.72	0.64	69.98	f	2025-02-13 17:15:05.27698
325	6	2	9	0.45	0.40	7	811	1.01	0.69	93.05	t	2025-02-13 17:15:05.27698
326	6	2	4	0.84	0.79	23	555	0.63	0.81	78.23	t	2025-02-13 17:15:05.27698
327	6	2	1	0.79	0.82	21	117	0.78	1.02	84.8	t	2025-02-13 17:15:05.27698
328	6	2	20	0.88	0.97	25	908	0.51	0.63	62.94	f	2025-02-13 17:15:05.27698
329	6	2	15	0.43	0.42	6	160	1.13	0.97	87.74	t	2025-02-13 17:15:05.27698
330	6	2	5	0.75	0.69	20	798	0.67	0.52	65.86	f	2025-02-13 17:15:05.27698
333	6	2	16	0.58	0.65	13	661	0.82	0.84	88.61	t	2025-02-13 17:15:05.27698
345	6	2	2	0.55	0.56	11	836	1.02	0.71	78.81	t	2025-02-13 17:15:05.27698
346	6	2	3	0.91	0.82	26	371	0.59	1.05	79.5	t	2025-02-13 17:15:05.27698
353	6	3	7	0.44	0.40	7	161	1.09	1.22	100.6	t	2025-02-13 17:15:05.27698
356	6	3	18	0.91	0.99	26	260	0.47	0.88	84.2	t	2025-02-13 17:15:05.27698
357	6	3	13	0.96	0.89	28	701	0.57	0.66	75.91	t	2025-02-13 17:15:05.27698
375	7	1	11	0.93	0.85	27	272	0.4	0.93	65.6	f	2025-02-13 17:15:05.27698
376	7	1	18	0.69	0.70	17	939	0.71	0.38	67.76	f	2025-02-13 17:15:05.27698
377	7	1	4	0.95	0.95	28	258	0.42	0.93	76.42	t	2025-02-13 17:15:05.27698
379	7	1	1	0.83	0.85	23	674	0.59	0.76	83.33	t	2025-02-13 17:15:05.27698
382	7	1	3	0.92	0.91	26	932	0.66	0.57	70.35	f	2025-02-13 17:15:05.27698
383	7	1	5	0.47	0.48	8	258	1.1	0.87	95.52	t	2025-02-13 17:15:05.27698
384	7	1	17	0.63	0.59	14	745	1.02	0.77	73.25	f	2025-02-13 17:15:05.27698
385	7	1	16	0.46	0.36	7	278	1.13	0.96	93.36	t	2025-02-13 17:15:05.27698
387	7	1	7	0.49	0.53	9	971	1.07	0.41	87.74	t	2025-02-13 17:15:05.27698
388	7	1	13	0.56	0.58	11	346	1.07	0.93	82.16	t	2025-02-13 17:15:05.27698
389	7	1	2	0.82	0.81	23	876	0.59	0.48	70.36	f	2025-02-13 17:15:05.27698
396	7	1	19	0.59	0.65	13	136	1.02	1.16	86.15	t	2025-02-13 17:15:05.27698
399	7	1	12	0.93	0.86	27	232	0.58	1.04	84.65	t	2025-02-13 17:15:05.27698
401	7	1	14	0.92	0.83	27	187	0.61	0.96	75.52	t	2025-02-13 17:15:05.27698
402	7	1	15	0.68	0.64	16	139	0.82	0.98	90.73	t	2025-02-13 17:15:05.27698
403	8	2	3	0.42	0.47	6	320	1.1	0.86	81.63	t	2025-02-13 17:15:05.27698
404	8	2	2	0.79	0.80	21	602	0.78	0.83	68.81	f	2025-02-13 17:15:05.27698
405	8	2	20	0.85	0.79	24	753	0.76	0.59	73.66	f	2025-02-13 17:15:05.27698
406	8	2	8	0.82	0.89	23	293	0.61	0.92	83.96	t	2025-02-13 17:15:05.27698
407	8	2	13	0.69	0.66	17	452	0.83	0.96	71.62	f	2025-02-13 17:15:05.27698
410	8	2	6	0.67	0.63	16	674	0.7	0.59	70.23	f	2025-02-13 17:15:05.27698
413	8	2	14	0.97	0.93	29	194	0.61	1.14	81.67	t	2025-02-13 17:15:05.27698
415	8	2	18	0.59	0.65	13	984	0.78	0.44	75.18	t	2025-02-13 17:15:05.27698
416	8	2	9	0.76	0.82	20	960	0.87	0.58	77.62	t	2025-02-13 17:15:05.27698
422	8	2	19	0.45	0.49	7	393	1.02	0.98	89.52	t	2025-02-13 17:15:05.27698
425	8	2	11	0.51	0.49	10	191	0.99	1.02	94.4	t	2025-02-13 17:15:05.27698
427	8	2	15	0.51	0.48	9	974	1.06	0.5	81.53	t	2025-02-13 17:15:05.27698
428	8	2	16	0.57	0.66	12	450	0.92	0.74	88.26	t	2025-02-13 17:15:05.27698
431	9	3	3	0.53	0.50	11	649	1.07	0.73	80.69	t	2025-02-13 17:15:05.27698
432	9	3	16	0.78	0.79	21	664	0.69	0.59	85.43	t	2025-02-13 17:15:05.27698
433	9	3	5	0.92	0.88	27	872	0.46	0.48	73.42	f	2025-02-13 17:15:05.27698
434	9	3	20	0.63	0.59	15	333	0.85	0.8	84.31	t	2025-02-13 17:15:05.27698
436	9	3	7	0.61	0.67	14	950	0.84	0.38	78.58	t	2025-02-13 17:15:05.27698
438	9	3	4	0.78	0.87	21	313	0.64	1.1	82.43	t	2025-02-13 17:15:05.27698
439	9	3	13	1.00	1.00	30	714	0.51	0.65	73.72	f	2025-02-13 17:15:05.27698
440	9	3	10	0.95	0.89	28	555	0.43	0.89	62.84	f	2025-02-13 17:15:05.27698
442	9	3	12	0.78	0.87	21	631	0.7	0.8	86.04	t	2025-02-13 17:15:05.27698
445	9	3	14	0.61	0.69	14	50	0.88	1.27	85.33	t	2025-02-13 17:15:05.27698
446	9	3	15	0.55	0.51	11	838	0.87	0.59	80.62	t	2025-02-13 17:15:05.27698
452	9	3	6	0.54	0.44	11	853	1.1	0.57	83.82	t	2025-02-13 17:15:05.27698
453	9	3	11	0.79	0.88	21	63	0.57	1.05	73.29	f	2025-02-13 17:15:05.27698
454	9	3	18	0.69	0.74	17	467	0.68	0.94	74.3	f	2025-02-13 17:15:05.27698
456	9	3	1	0.99	0.90	30	197	0.53	1.05	66.65	f	2025-02-13 17:15:05.27698
459	10	1	1	0.83	0.82	23	137	0.69	1.13	80.53	t	2025-02-13 17:15:05.27698
460	10	1	5	0.42	0.41	6	656	1.21	0.77	83.14	t	2025-02-13 17:15:05.27698
461	10	1	18	0.83	0.83	23	881	0.51	0.64	64.33	f	2025-02-13 17:15:05.27698
462	10	1	3	0.74	0.69	19	559	0.62	0.77	71.01	f	2025-02-13 17:15:05.27698
463	10	1	15	0.99	1.02	30	458	0.42	0.78	66.34	f	2025-02-13 17:15:05.27698
464	10	1	6	0.54	0.58	11	827	0.91	0.68	73.88	f	2025-02-13 17:15:05.27698
465	10	1	11	0.62	0.58	14	786	0.84	0.66	72.42	f	2025-02-13 17:15:05.27698
466	10	1	10	0.86	0.81	24	343	0.73	1.02	71.22	f	2025-02-13 17:15:05.27698
467	10	1	12	0.41	0.45	5	758	1.08	0.64	81.32	t	2025-02-13 17:15:05.27698
471	10	1	7	0.96	1.01	29	278	0.48	1.05	69.96	f	2025-02-13 17:15:05.27698
472	10	1	17	0.80	0.76	22	858	0.68	0.48	79.48	t	2025-02-13 17:15:05.27698
473	10	1	9	0.79	0.78	21	189	0.76	0.9	78.49	t	2025-02-13 17:15:05.27698
474	10	1	13	0.87	0.96	25	771	0.48	0.58	66.74	f	2025-02-13 17:15:05.27698
479	10	1	14	0.50	0.49	9	92	0.92	1.01	91.76	t	2025-02-13 17:15:05.27698
480	10	1	2	0.76	0.68	20	526	0.87	0.75	72.88	f	2025-02-13 17:15:05.27698
483	10	1	16	0.46	0.43	7	85	1.2	1.09	96.29	t	2025-02-13 17:15:05.27698
484	10	1	8	0.89	0.88	26	422	0.71	0.73	79.28	t	2025-02-13 17:15:05.27698
497	10	3	4	0.45	0.55	7	418	1.12	0.94	98.46	t	2025-02-13 17:15:05.27698
500	10	3	19	0.74	0.80	19	840	0.67	0.68	74.47	f	2025-02-13 17:15:05.27698
510	10	3	20	0.51	0.55	10	203	0.9	1.16	94.27	t	2025-02-13 17:15:05.27698
\.


--
-- Name: inquiries_inquiry_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.inquiries_inquiry_id_seq', 33, true);


--
-- Name: products_product_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.products_product_id_seq', 3, true);


--
-- Name: suppliers_quotes_supplier_quote_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.suppliers_quotes_supplier_quote_id_seq', 514, true);


--
-- Name: suppliers_supplier_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.suppliers_supplier_id_seq', 10, true);


--
-- Name: inquiries inquiries_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.inquiries
    ADD CONSTRAINT inquiries_pkey PRIMARY KEY (inquiry_id);


--
-- Name: products products_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.products
    ADD CONSTRAINT products_pkey PRIMARY KEY (product_id);


--
-- Name: suppliers suppliers_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.suppliers
    ADD CONSTRAINT suppliers_pkey PRIMARY KEY (supplier_id);


--
-- Name: suppliers_products suppliers_products_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.suppliers_products
    ADD CONSTRAINT suppliers_products_pkey PRIMARY KEY (supplier_id, product_id);


--
-- Name: suppliers_quotes suppliers_quotes_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.suppliers_quotes
    ADD CONSTRAINT suppliers_quotes_pkey PRIMARY KEY (supplier_quote_id);


--
-- Name: suppliers_quotes suppliers_quotes_supplier_id_inquiry_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.suppliers_quotes
    ADD CONSTRAINT suppliers_quotes_supplier_id_inquiry_id_key UNIQUE (supplier_id, inquiry_id);


--
-- Name: inquiries inquiries_product_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.inquiries
    ADD CONSTRAINT inquiries_product_id_fkey FOREIGN KEY (product_id) REFERENCES public.products(product_id);


--
-- Name: suppliers_products suppliers_products_product_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.suppliers_products
    ADD CONSTRAINT suppliers_products_product_id_fkey FOREIGN KEY (product_id) REFERENCES public.products(product_id);


--
-- Name: suppliers_products suppliers_products_supplier_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.suppliers_products
    ADD CONSTRAINT suppliers_products_supplier_id_fkey FOREIGN KEY (supplier_id) REFERENCES public.suppliers(supplier_id);


--
-- Name: suppliers_quotes suppliers_quotes_inquiry_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.suppliers_quotes
    ADD CONSTRAINT suppliers_quotes_inquiry_id_fkey FOREIGN KEY (inquiry_id) REFERENCES public.inquiries(inquiry_id);


--
-- Name: suppliers_quotes suppliers_quotes_product_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.suppliers_quotes
    ADD CONSTRAINT suppliers_quotes_product_id_fkey FOREIGN KEY (product_id) REFERENCES public.products(product_id);


--
-- Name: suppliers_quotes suppliers_quotes_supplier_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.suppliers_quotes
    ADD CONSTRAINT suppliers_quotes_supplier_id_fkey FOREIGN KEY (supplier_id) REFERENCES public.suppliers(supplier_id);


--
-- PostgreSQL database dump complete
--

