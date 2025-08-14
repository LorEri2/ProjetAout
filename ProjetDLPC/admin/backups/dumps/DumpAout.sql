--
-- PostgreSQL database dump
--

-- Dumped from database version 17.2
-- Dumped by pg_dump version 17.2

-- Started on 2025-08-14 11:24:13

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
-- TOC entry 230 (class 1255 OID 49743)
-- Name: ajout_pc(text, numeric, text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.ajout_pc(p_nom text, p_prix numeric, p_type text) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE
    id INTEGER;
BEGIN
    INSERT INTO pc(nom_pc, prix_pc, type_pc)
    VALUES (p_nom, p_prix, p_type)
    ON CONFLICT (nom_pc) DO NOTHING;

    SELECT id_pc INTO id FROM pc WHERE nom_pc = p_nom;

    IF id IS NULL THEN
        RETURN -1;
    ELSE
        RETURN id;
    END IF;
END;
$$;


ALTER FUNCTION public.ajout_pc(p_nom text, p_prix numeric, p_type text) OWNER TO postgres;

--
-- TOC entry 229 (class 1255 OID 49742)
-- Name: ajouter_pc(text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.ajouter_pc(p_nom_pc text) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE
    id INTEGER;
BEGIN
    INSERT INTO pc (nom_pc) 
    VALUES (p_nom_pc)
    ON CONFLICT (nom_pc) DO NOTHING;

    SELECT id_pc INTO id 
    FROM pc 
    WHERE nom_pc = p_nom_pc;

    IF id IS NULL THEN
        RETURN -1;
    ELSE
        RETURN id;
    END IF;
END;
$$;


ALTER FUNCTION public.ajouter_pc(p_nom_pc text) OWNER TO postgres;

--
-- TOC entry 226 (class 1255 OID 41510)
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
-- TOC entry 228 (class 1255 OID 41242)
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
-- TOC entry 225 (class 1255 OID 41258)
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
-- TOC entry 227 (class 1255 OID 49741)
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
-- TOC entry 220 (class 1259 OID 41232)
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
-- TOC entry 219 (class 1259 OID 41231)
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
-- TOC entry 4884 (class 0 OID 0)
-- Dependencies: 219
-- Name: admin_id_admin_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.admin_id_admin_seq OWNED BY public.admin.id_admin;


--
-- TOC entry 223 (class 1259 OID 41259)
-- Name: categorie; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.categorie (
    id_cat integer NOT NULL,
    nom_categorie text NOT NULL,
    image_cat text
);


ALTER TABLE public.categorie OWNER TO postgres;

--
-- TOC entry 224 (class 1259 OID 41264)
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
-- TOC entry 4885 (class 0 OID 0)
-- Dependencies: 224
-- Name: categorie_id_cat_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.categorie_id_cat_seq OWNED BY public.categorie.id_cat;


--
-- TOC entry 218 (class 1259 OID 41221)
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
-- TOC entry 217 (class 1259 OID 41220)
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
-- TOC entry 4886 (class 0 OID 0)
-- Dependencies: 217
-- Name: pc_id_pc_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.pc_id_pc_seq OWNED BY public.pc.id_pc;


--
-- TOC entry 222 (class 1259 OID 41248)
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
-- TOC entry 221 (class 1259 OID 41247)
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
-- TOC entry 4887 (class 0 OID 0)
-- Dependencies: 221
-- Name: utilisateur_id_utilisateur_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.utilisateur_id_utilisateur_seq OWNED BY public.utilisateur.id_utilisateur;


--
-- TOC entry 4717 (class 2604 OID 41235)
-- Name: admin id_admin; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.admin ALTER COLUMN id_admin SET DEFAULT nextval('public.admin_id_admin_seq'::regclass);


--
-- TOC entry 4719 (class 2604 OID 41275)
-- Name: categorie id_cat; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.categorie ALTER COLUMN id_cat SET DEFAULT nextval('public.categorie_id_cat_seq'::regclass);


--
-- TOC entry 4716 (class 2604 OID 41224)
-- Name: pc id_pc; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pc ALTER COLUMN id_pc SET DEFAULT nextval('public.pc_id_pc_seq'::regclass);


--
-- TOC entry 4718 (class 2604 OID 41251)
-- Name: utilisateur id_utilisateur; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.utilisateur ALTER COLUMN id_utilisateur SET DEFAULT nextval('public.utilisateur_id_utilisateur_seq'::regclass);


--
-- TOC entry 4725 (class 2606 OID 41241)
-- Name: admin admin_nom_admin_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.admin
    ADD CONSTRAINT admin_nom_admin_key UNIQUE (nom_admin);


--
-- TOC entry 4727 (class 2606 OID 41239)
-- Name: admin admin_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.admin
    ADD CONSTRAINT admin_pkey PRIMARY KEY (id_admin);


--
-- TOC entry 4733 (class 2606 OID 41278)
-- Name: categorie categorie_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.categorie
    ADD CONSTRAINT categorie_pkey PRIMARY KEY (id_cat);


--
-- TOC entry 4721 (class 2606 OID 41230)
-- Name: pc pc_nom_pc_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pc
    ADD CONSTRAINT pc_nom_pc_key UNIQUE (nom_pc);


--
-- TOC entry 4723 (class 2606 OID 41228)
-- Name: pc pc_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pc
    ADD CONSTRAINT pc_pkey PRIMARY KEY (id_pc);


--
-- TOC entry 4729 (class 2606 OID 41257)
-- Name: utilisateur utilisateur_nom_utilisateur_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_nom_utilisateur_key UNIQUE (nom_utilisateur);


--
-- TOC entry 4731 (class 2606 OID 41255)
-- Name: utilisateur utilisateur_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_pkey PRIMARY KEY (id_utilisateur);


-- Completed on 2025-08-14 11:24:13

--
-- PostgreSQL database dump complete
--

