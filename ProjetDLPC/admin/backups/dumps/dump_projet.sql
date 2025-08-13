--
-- PostgreSQL database dump
--

-- Dumped from database version 17.2
-- Dumped by pg_dump version 17.2

-- Started on 2025-06-07 12:01:49

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
-- TOC entry 229 (class 1255 OID 41243)
-- Name: ajout_pc(text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.ajout_pc(text) RETURNS integer
    LANGUAGE plpgsql
    AS $_$
	DECLARE p_nom_pc ALIAS FOR $1;
	DECLARE id integer;
	
BEGIN
	INSERT INTO pc (nom_pc) VALUES (p_nom_pc) 
	ON CONFLICT (nom_pc) DO NOTHING;
	SELECT INTO ID id_pc FROM pc WHERE nom_pc = p_nom_pc;
	
	IF id IS NULL
	THEN
	  return -1;
	ELSE
	  return id;
	END IF;
END;
$_$;


ALTER FUNCTION public.ajout_pc(text) OWNER TO postgres;

--
-- TOC entry 231 (class 1255 OID 41510)
-- Name: delete_pc(integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.delete_pc(integer) RETURNS integer
    LANGUAGE plpgsql
    AS $_$
	declare p_id alias for $1;

begin
	delete from pc where id_pc = p_id;
	return 1;
end;
$_$;


ALTER FUNCTION public.delete_pc(integer) OWNER TO postgres;

--
-- TOC entry 233 (class 1255 OID 41242)
-- Name: get_admin(text, text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.get_admin(p_login_admin text, p_password_admin text) RETURNS text
    LANGUAGE plpgsql
    AS $$
DECLARE
    r_nom_admin TEXT;
BEGIN
    SELECT nom_admin INTO r_nom_admin
    FROM admin
    WHERE login_admin = p_login_admin
      AND password_admin = p_password_admin;

    RETURN r_nom_admin;  -- retourne NULL si rien trouvé
END;
$$;


ALTER FUNCTION public.get_admin(p_login_admin text, p_password_admin text) OWNER TO postgres;

--
-- TOC entry 230 (class 1255 OID 41258)
-- Name: get_utilisateur(text, text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.get_utilisateur(p_login_utilisateur text, p_password_utilisateur text) RETURNS text
    LANGUAGE plpgsql
    AS $$
DECLARE
    r_nom_utilisateur TEXT;
    retour TEXT;
BEGIN
    SELECT nom_utilisateur INTO r_nom_utilisateur
    FROM Utilisateur
    WHERE login_utilisateur = p_login_utilisateur
      AND password_utilisateur = p_password_utilisateur;

    IF r_nom_utilisateur IS NOT NULL THEN
        retour := r_nom_utilisateur;
    ELSE
        retour := 'Utilisateur inconnu';
    END IF;

    RETURN retour;
END;
$$;


ALTER FUNCTION public.get_utilisateur(p_login_utilisateur text, p_password_utilisateur text) OWNER TO postgres;

--
-- TOC entry 232 (class 1255 OID 49741)
-- Name: update_pc_column(text, text, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.update_pc_column(champ text, valeur text, id_pc integer) RETURNS void
    LANGUAGE plpgsql
    AS $_$
BEGIN
    EXECUTE format('UPDATE pc SET %I = $1 WHERE id_pc = $2', champ)
    USING valeur, id_pc;
END;
$_$;


ALTER FUNCTION public.update_pc_column(champ text, valeur text, id_pc integer) OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 222 (class 1259 OID 41232)
-- Name: admin; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.admin (
    id_admin integer NOT NULL,
    nom_admin text NOT NULL,
    login_admin text NOT NULL,
    password_admin text NOT NULL
);


ALTER TABLE public.admin OWNER TO postgres;

--
-- TOC entry 221 (class 1259 OID 41231)
-- Name: admin_id_admin_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.admin_id_admin_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.admin_id_admin_seq OWNER TO postgres;

--
-- TOC entry 4914 (class 0 OID 0)
-- Dependencies: 221
-- Name: admin_id_admin_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.admin_id_admin_seq OWNED BY public.admin.id_admin;


--
-- TOC entry 225 (class 1259 OID 41259)
-- Name: categorie; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.categorie (
    id_cat integer NOT NULL,
    nom_categorie text NOT NULL,
    image_cat text
);


ALTER TABLE public.categorie OWNER TO postgres;

--
-- TOC entry 226 (class 1259 OID 41264)
-- Name: categorie_id_cat_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.categorie_id_cat_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.categorie_id_cat_seq OWNER TO postgres;

--
-- TOC entry 4915 (class 0 OID 0)
-- Dependencies: 226
-- Name: categorie_id_cat_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.categorie_id_cat_seq OWNED BY public.categorie.id_cat;


--
-- TOC entry 218 (class 1259 OID 41210)
-- Name: materiel; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.materiel (
    id_materiel integer NOT NULL,
    nom_materiel text NOT NULL,
    photo_materiel text
);


ALTER TABLE public.materiel OWNER TO postgres;

--
-- TOC entry 217 (class 1259 OID 41209)
-- Name: materiel_id_materiel_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.materiel_id_materiel_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.materiel_id_materiel_seq OWNER TO postgres;

--
-- TOC entry 4916 (class 0 OID 0)
-- Dependencies: 217
-- Name: materiel_id_materiel_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.materiel_id_materiel_seq OWNED BY public.materiel.id_materiel;


--
-- TOC entry 220 (class 1259 OID 41221)
-- Name: pc; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.pc (
    id_pc integer NOT NULL,
    nom_pc text NOT NULL,
    photo_pc text,
    prix_pc numeric(20,2),
    type_pc character varying(100)
);


ALTER TABLE public.pc OWNER TO postgres;

--
-- TOC entry 219 (class 1259 OID 41220)
-- Name: pc_id_pc_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.pc_id_pc_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.pc_id_pc_seq OWNER TO postgres;

--
-- TOC entry 4917 (class 0 OID 0)
-- Dependencies: 219
-- Name: pc_id_pc_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.pc_id_pc_seq OWNED BY public.pc.id_pc;


--
-- TOC entry 227 (class 1259 OID 41265)
-- Name: produit; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.produit (
    id_produit integer NOT NULL,
    nom_produit text NOT NULL,
    image text,
    prix_produit numeric,
    description text,
    id_cat integer
);


ALTER TABLE public.produit OWNER TO postgres;

--
-- TOC entry 228 (class 1259 OID 41270)
-- Name: produit_id_produit_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.produit_id_produit_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.produit_id_produit_seq OWNER TO postgres;

--
-- TOC entry 4918 (class 0 OID 0)
-- Dependencies: 228
-- Name: produit_id_produit_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.produit_id_produit_seq OWNED BY public.produit.id_produit;


--
-- TOC entry 224 (class 1259 OID 41248)
-- Name: utilisateur; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.utilisateur (
    id_utilisateur integer NOT NULL,
    nom_utilisateur text NOT NULL,
    login_utilisateur text NOT NULL,
    password_utilisateur text NOT NULL
);


ALTER TABLE public.utilisateur OWNER TO postgres;

--
-- TOC entry 223 (class 1259 OID 41247)
-- Name: utilisateur_id_utilisateur_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.utilisateur_id_utilisateur_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.utilisateur_id_utilisateur_seq OWNER TO postgres;

--
-- TOC entry 4919 (class 0 OID 0)
-- Dependencies: 223
-- Name: utilisateur_id_utilisateur_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.utilisateur_id_utilisateur_seq OWNED BY public.utilisateur.id_utilisateur;


--
-- TOC entry 4727 (class 2604 OID 41235)
-- Name: admin id_admin; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.admin ALTER COLUMN id_admin SET DEFAULT nextval('public.admin_id_admin_seq'::regclass);


--
-- TOC entry 4729 (class 2604 OID 41275)
-- Name: categorie id_cat; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.categorie ALTER COLUMN id_cat SET DEFAULT nextval('public.categorie_id_cat_seq'::regclass);


--
-- TOC entry 4725 (class 2604 OID 41213)
-- Name: materiel id_materiel; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.materiel ALTER COLUMN id_materiel SET DEFAULT nextval('public.materiel_id_materiel_seq'::regclass);


--
-- TOC entry 4726 (class 2604 OID 41224)
-- Name: pc id_pc; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pc ALTER COLUMN id_pc SET DEFAULT nextval('public.pc_id_pc_seq'::regclass);


--
-- TOC entry 4730 (class 2604 OID 41276)
-- Name: produit id_produit; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.produit ALTER COLUMN id_produit SET DEFAULT nextval('public.produit_id_produit_seq'::regclass);


--
-- TOC entry 4728 (class 2604 OID 41251)
-- Name: utilisateur id_utilisateur; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.utilisateur ALTER COLUMN id_utilisateur SET DEFAULT nextval('public.utilisateur_id_utilisateur_seq'::regclass);


--
-- TOC entry 4902 (class 0 OID 41232)
-- Dependencies: 222
-- Data for Name: admin; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.admin (id_admin, nom_admin, login_admin, password_admin) FROM stdin;
1	Loris	lolo	password
\.


--
-- TOC entry 4905 (class 0 OID 41259)
-- Dependencies: 225
-- Data for Name: categorie; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.categorie (id_cat, nom_categorie, image_cat) FROM stdin;
1	PC GAMER TOUR	\N
2	PC GAMER PORTABLE	\N
3	ACCESSOIRES	\N
\.


--
-- TOC entry 4898 (class 0 OID 41210)
-- Dependencies: 218
-- Data for Name: materiel; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.materiel (id_materiel, nom_materiel, photo_materiel) FROM stdin;
\.


--
-- TOC entry 4900 (class 0 OID 41221)
-- Dependencies: 220
-- Data for Name: pc; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.pc (id_pc, nom_pc, photo_pc, prix_pc, type_pc) FROM stdin;
2	PC Razor	pc3.jpg	699.99	PC GAMER PORTABLE
1	Bureautique	pc2.jpg	599.99	PC GAMER TOUR
6	PC RGB	pc1.jpg	1000.00	PC GAMER TOUR
8	PC WaterCooling	pc5.jpg	2000.00	ACCESSOIRES
20	ECRAN MSI	MSI.jpg	140.00	ACCESSOIRES
19	ACER2	ACER.jpg	2099.00	PC GAMER PORTABLE
\.


--
-- TOC entry 4907 (class 0 OID 41265)
-- Dependencies: 227
-- Data for Name: produit; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.produit (id_produit, nom_produit, image, prix_produit, description, id_cat) FROM stdin;
10	Croissants nature	viennoiseries2.jpg	0.50	Croissant	1
11	Pains au chocolat	viennoiseries1.jpg	0.50	Pain au chocolat traditionnels	1
9	Eclairs au chocolat	patisserie2.jpg	10.99	Pâtisseries pour tous les jours	2
8	Tartelette aux fraises	patisserie3.jpg	12.99	Pâtisserie de saison	2
2	Gâteau festif	cake2.jpg	34.59	Gâteau type Forêt Noire	3
4	Bûche de Noël vanillée	christmas2.jpg	21.49	Bûche vanille - chocolat fondant	3
3	Bûche de Noël moka	christmas1.jpg	18.49	Bûche roulée au moka et noix de pécan	3
6	Gâteau de mariage	wedding2.jpg	75.99	Pièce montée crème	3
12	Petits choux garnis	patisserie1.jpg	3.50	Petits choux garnis, ganache vanille	2
1	Pains de froment	pain_blanc.jpg	1.00	Pain blanc	1
5	Gâteau traditionnel de Noël	cake2.jpg	15.09	Gâteau aux fruits confits	3
7	Gâteaux aux fraises	cake3.jpg	12.99	Pour 8 personnes	3
\.


--
-- TOC entry 4904 (class 0 OID 41248)
-- Dependencies: 224
-- Data for Name: utilisateur; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.utilisateur (id_utilisateur, nom_utilisateur, login_utilisateur, password_utilisateur) FROM stdin;
1	Antoine	antoinelegoat	legoat
\.


--
-- TOC entry 4920 (class 0 OID 0)
-- Dependencies: 221
-- Name: admin_id_admin_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.admin_id_admin_seq', 1, true);


--
-- TOC entry 4921 (class 0 OID 0)
-- Dependencies: 226
-- Name: categorie_id_cat_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.categorie_id_cat_seq', 3, true);


--
-- TOC entry 4922 (class 0 OID 0)
-- Dependencies: 217
-- Name: materiel_id_materiel_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.materiel_id_materiel_seq', 1, false);


--
-- TOC entry 4923 (class 0 OID 0)
-- Dependencies: 219
-- Name: pc_id_pc_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.pc_id_pc_seq', 21, true);


--
-- TOC entry 4924 (class 0 OID 0)
-- Dependencies: 228
-- Name: produit_id_produit_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.produit_id_produit_seq', 1, false);


--
-- TOC entry 4925 (class 0 OID 0)
-- Dependencies: 223
-- Name: utilisateur_id_utilisateur_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.utilisateur_id_utilisateur_seq', 1, true);


--
-- TOC entry 4740 (class 2606 OID 41241)
-- Name: admin admin_nom_admin_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.admin
    ADD CONSTRAINT admin_nom_admin_key UNIQUE (nom_admin);


--
-- TOC entry 4742 (class 2606 OID 41239)
-- Name: admin admin_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.admin
    ADD CONSTRAINT admin_pkey PRIMARY KEY (id_admin);


--
-- TOC entry 4748 (class 2606 OID 41278)
-- Name: categorie categorie_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.categorie
    ADD CONSTRAINT categorie_pkey PRIMARY KEY (id_cat);


--
-- TOC entry 4732 (class 2606 OID 41219)
-- Name: materiel materiel_nom_materiel_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.materiel
    ADD CONSTRAINT materiel_nom_materiel_key UNIQUE (nom_materiel);


--
-- TOC entry 4734 (class 2606 OID 41217)
-- Name: materiel materiel_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.materiel
    ADD CONSTRAINT materiel_pkey PRIMARY KEY (id_materiel);


--
-- TOC entry 4736 (class 2606 OID 41230)
-- Name: pc pc_nom_pc_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pc
    ADD CONSTRAINT pc_nom_pc_key UNIQUE (nom_pc);


--
-- TOC entry 4738 (class 2606 OID 41228)
-- Name: pc pc_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pc
    ADD CONSTRAINT pc_pkey PRIMARY KEY (id_pc);


--
-- TOC entry 4750 (class 2606 OID 41280)
-- Name: produit produit_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.produit
    ADD CONSTRAINT produit_pkey PRIMARY KEY (id_produit);


--
-- TOC entry 4744 (class 2606 OID 41257)
-- Name: utilisateur utilisateur_nom_utilisateur_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_nom_utilisateur_key UNIQUE (nom_utilisateur);


--
-- TOC entry 4746 (class 2606 OID 41255)
-- Name: utilisateur utilisateur_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_pkey PRIMARY KEY (id_utilisateur);


--
-- TOC entry 4751 (class 2606 OID 41281)
-- Name: produit produit_id_cat_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.produit
    ADD CONSTRAINT produit_id_cat_fkey FOREIGN KEY (id_cat) REFERENCES public.categorie(id_cat);


-- Completed on 2025-06-07 12:01:50

--
-- PostgreSQL database dump complete
--

