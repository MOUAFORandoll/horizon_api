--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

--
-- Name: notify_messenger_messages(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION notify_messenger_messages() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
    BEGIN
        PERFORM pg_notify('messenger_messages', NEW.queue_name::text);
        RETURN NEW;
    END;
$$;


ALTER FUNCTION public.notify_messenger_messages() OWNER TO postgres;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: abonnement_boutique; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE abonnement_boutique (
    id integer NOT NULL,
    boutique_id integer,
    client_id integer,
    date_created timestamp(0) without time zone NOT NULL,
    status boolean NOT NULL
);


ALTER TABLE public.abonnement_boutique OWNER TO postgres;

--
-- Name: abonnement_boutique_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE abonnement_boutique_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.abonnement_boutique_id_seq OWNER TO postgres;

--
-- Name: boutique; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE boutique (
    id integer NOT NULL,
    user_id integer,
    localisation_id integer,
    category_id integer,
    titre character varying(255) NOT NULL,
    description character varying(255) DEFAULT NULL::character varying,
    status boolean NOT NULL,
    code_boutique character varying(255) DEFAULT NULL::character varying,
    date_created date,
    date_first_activated date,
    date_last_desactivated date
);


ALTER TABLE public.boutique OWNER TO postgres;

--
-- Name: boutique_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE boutique_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.boutique_id_seq OWNER TO postgres;

--
-- Name: boutique_object; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE boutique_object (
    id integer NOT NULL,
    boutique_id integer,
    src character varying(255) NOT NULL,
    date_created timestamp(0) without time zone NOT NULL
);


ALTER TABLE public.boutique_object OWNER TO postgres;

--
-- Name: boutique_object_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE boutique_object_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.boutique_object_id_seq OWNER TO postgres;

--
-- Name: category; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE category (
    id integer NOT NULL,
    libelle character varying(255) NOT NULL,
    description character varying(255) DEFAULT NULL::character varying,
    date_created date NOT NULL,
    status boolean NOT NULL,
    logo character varying(255) DEFAULT NULL::character varying
);


ALTER TABLE public.category OWNER TO postgres;

--
-- Name: category_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE category_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.category_id_seq OWNER TO postgres;

--
-- Name: commande; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE commande (
    id integer NOT NULL,
    mode_paiement_id integer,
    panier_id integer,
    type_commande_id integer,
    point_livraison_id integer,
    titre character varying(255) NOT NULL,
    description character varying(10000) DEFAULT NULL::character varying,
    date_created date NOT NULL,
    code_commande character varying(255) NOT NULL,
    code_client character varying(255) NOT NULL,
    status_buy boolean NOT NULL,
    status_finish integer NOT NULL,
    token text NOT NULL,
    montant integer
);


ALTER TABLE public.commande OWNER TO postgres;

--
-- Name: commande_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE commande_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.commande_id_seq OWNER TO postgres;

--
-- Name: commission; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE commission (
    id integer NOT NULL,
    pourcentage_produit double precision,
    frais_livraison_produit double precision NOT NULL,
    frais_buy_livreur double precision NOT NULL
);


ALTER TABLE public.commission OWNER TO postgres;

--
-- Name: commission_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE commission_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.commission_id_seq OWNER TO postgres;

--
-- Name: communication; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE communication (
    id integer NOT NULL,
    client_id integer,
    date_created timestamp(0) without time zone DEFAULT NULL::timestamp without time zone,
    code_communication character varying(255) DEFAULT NULL::character varying
);


ALTER TABLE public.communication OWNER TO postgres;

--
-- Name: communication_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE communication_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.communication_id_seq OWNER TO postgres;

SET default_with_oids = true;

--
-- Name: compte; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE compte (
    id integer NOT NULL,
    user_id integer,
    solde integer NOT NULL
);


ALTER TABLE public.compte OWNER TO postgres;

--
-- Name: compte_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE compte_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.compte_id_seq OWNER TO postgres;

SET default_with_oids = false;

--
-- Name: connexion; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE connexion (
    id integer NOT NULL,
    user_id integer,
    date_in timestamp(0) without time zone NOT NULL,
    date_out timestamp(0) without time zone DEFAULT NULL::timestamp without time zone,
    user_agent character varying(255) NOT NULL,
    ip character varying(255) NOT NULL
);


ALTER TABLE public.connexion OWNER TO postgres;

--
-- Name: connexion_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE connexion_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.connexion_id_seq OWNER TO postgres;

--
-- Name: doctrine_migration_versions; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE doctrine_migration_versions (
    version character varying(191) NOT NULL,
    executed_at timestamp(0) without time zone DEFAULT NULL::timestamp without time zone,
    execution_time integer
);


ALTER TABLE public.doctrine_migration_versions OWNER TO postgres;

--
-- Name: historique_paiement; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE historique_paiement (
    id integer NOT NULL,
    user_id integer,
    type_paiement_id integer,
    commande_id integer,
    montant character varying(255) NOT NULL,
    date_created timestamp(0) without time zone NOT NULL,
    token character varying(255) NOT NULL,
    status boolean NOT NULL
);


ALTER TABLE public.historique_paiement OWNER TO postgres;

--
-- Name: historique_paiement_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE historique_paiement_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.historique_paiement_id_seq OWNER TO postgres;

--
-- Name: jwt_refresh_token; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE jwt_refresh_token (
    id integer NOT NULL,
    refresh_token character varying(128) NOT NULL,
    username character varying(255) NOT NULL,
    valid timestamp(0) without time zone NOT NULL,
    date_expire_token timestamp(0) without time zone DEFAULT NULL::timestamp without time zone
);


ALTER TABLE public.jwt_refresh_token OWNER TO postgres;

--
-- Name: jwt_refresh_token_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE jwt_refresh_token_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.jwt_refresh_token_id_seq OWNER TO postgres;

--
-- Name: like_produit; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE like_produit (
    id integer NOT NULL,
    client_id integer,
    produit_id integer,
    like_produit boolean NOT NULL,
    date_created date NOT NULL
);


ALTER TABLE public.like_produit OWNER TO postgres;

--
-- Name: like_produit_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE like_produit_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.like_produit_id_seq OWNER TO postgres;

--
-- Name: list_commande_livreur; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE list_commande_livreur (
    id integer NOT NULL,
    commande_id integer,
    livreur_id integer,
    date_created date NOT NULL
);


ALTER TABLE public.list_commande_livreur OWNER TO postgres;

--
-- Name: list_commande_livreur_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE list_commande_livreur_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.list_commande_livreur_id_seq OWNER TO postgres;

--
-- Name: list_produit_panier; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE list_produit_panier (
    id integer NOT NULL,
    panier_id integer,
    produit_id integer,
    status boolean NOT NULL,
    quantite integer NOT NULL,
    code_produit_panier character varying(255) NOT NULL,
    date_created timestamp(0) without time zone NOT NULL,
    prix_unitaire_vente integer
);


ALTER TABLE public.list_produit_panier OWNER TO postgres;

--
-- Name: list_produit_panier_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE list_produit_panier_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.list_produit_panier_id_seq OWNER TO postgres;

--
-- Name: list_produit_promotion; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE list_produit_promotion (
    id integer NOT NULL,
    produit_id integer,
    promotion_id integer,
    date_created date NOT NULL,
    prix_promotion integer NOT NULL
);


ALTER TABLE public.list_produit_promotion OWNER TO postgres;

--
-- Name: list_produit_promotion_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE list_produit_promotion_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.list_produit_promotion_id_seq OWNER TO postgres;

--
-- Name: localisation; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE localisation (
    id integer NOT NULL,
    user_id integer,
    ville character varying(1000) DEFAULT NULL::character varying,
    longitude double precision,
    latitude double precision,
    ip character varying(255) DEFAULT NULL::character varying,
    date_in timestamp(0) without time zone NOT NULL
);


ALTER TABLE public.localisation OWNER TO postgres;

--
-- Name: localisation_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE localisation_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.localisation_id_seq OWNER TO postgres;

--
-- Name: message_communication; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE message_communication (
    id integer NOT NULL,
    communication_id integer,
    initiateur_id integer,
    emetteur boolean NOT NULL,
    message text NOT NULL,
    date_envoi timestamp(0) without time zone NOT NULL
);


ALTER TABLE public.message_communication OWNER TO postgres;

--
-- Name: message_communication_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE message_communication_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.message_communication_id_seq OWNER TO postgres;

--
-- Name: message_negociation; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE message_negociation (
    id integer NOT NULL,
    negociation_id integer,
    emetteur boolean NOT NULL,
    message text NOT NULL,
    date_envoi timestamp(0) without time zone NOT NULL,
    initiateur_id integer
);


ALTER TABLE public.message_negociation OWNER TO postgres;

--
-- Name: message_negociation_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE message_negociation_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.message_negociation_id_seq OWNER TO postgres;

--
-- Name: messenger_messages; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE messenger_messages (
    id bigint NOT NULL,
    body text NOT NULL,
    headers text NOT NULL,
    queue_name character varying(190) NOT NULL,
    created_at timestamp(0) without time zone NOT NULL,
    available_at timestamp(0) without time zone NOT NULL,
    delivered_at timestamp(0) without time zone DEFAULT NULL::timestamp without time zone
);


ALTER TABLE public.messenger_messages OWNER TO postgres;

--
-- Name: messenger_messages_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE messenger_messages_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.messenger_messages_id_seq OWNER TO postgres;

--
-- Name: messenger_messages_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE messenger_messages_id_seq OWNED BY messenger_messages.id;


--
-- Name: mode_paiement; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE mode_paiement (
    id integer NOT NULL,
    libelle character varying(255) NOT NULL
);


ALTER TABLE public.mode_paiement OWNER TO postgres;

--
-- Name: mode_paiement_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE mode_paiement_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.mode_paiement_id_seq OWNER TO postgres;

--
-- Name: negociation_produit; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE negociation_produit (
    id integer NOT NULL,
    produit_id integer,
    code_negociation character varying(255) DEFAULT NULL::character varying,
    prix_negocie character varying(255),
    date_created timestamp(0) without time zone NOT NULL,
    initiateur_id integer
);


ALTER TABLE public.negociation_produit OWNER TO postgres;

--
-- Name: negociation_produit_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE negociation_produit_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.negociation_produit_id_seq OWNER TO postgres;

--
-- Name: notation_boutique; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE notation_boutique (
    id integer NOT NULL,
    client_id integer,
    boutique_id integer,
    note double precision NOT NULL,
    date_created date NOT NULL
);


ALTER TABLE public.notation_boutique OWNER TO postgres;

--
-- Name: notation_boutique_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE notation_boutique_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.notation_boutique_id_seq OWNER TO postgres;

--
-- Name: notification; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE notification (
    id integer NOT NULL,
    user_id integer,
    title character varying(255) NOT NULL,
    description character varying(255) NOT NULL,
    date_created timestamp(0) without time zone NOT NULL
);


ALTER TABLE public.notification OWNER TO postgres;

--
-- Name: notification_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE notification_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.notification_id_seq OWNER TO postgres;

--
-- Name: panier; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE panier (
    id integer NOT NULL,
    user_id integer,
    date_created date,
    code_panier character varying(255) NOT NULL,
    nom_client character varying(255) NOT NULL,
    prenom_client character varying(255) DEFAULT NULL::character varying,
    phone_client character varying(255) NOT NULL
);


ALTER TABLE public.panier OWNER TO postgres;

--
-- Name: panier_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE panier_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.panier_id_seq OWNER TO postgres;

--
-- Name: point_livraison; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE point_livraison (
    id integer NOT NULL,
    libelle character varying(255) NOT NULL,
    ville character varying(255) NOT NULL,
    quartier character varying(255) NOT NULL,
    image character varying(255) DEFAULT NULL::character varying,
    status boolean NOT NULL
);


ALTER TABLE public.point_livraison OWNER TO postgres;

--
-- Name: point_livraison_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE point_livraison_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.point_livraison_id_seq OWNER TO postgres;

--
-- Name: produit; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE produit (
    id integer NOT NULL,
    category_id integer,
    boutique_id integer,
    titre character varying(255) NOT NULL,
    description character varying(10000) DEFAULT NULL::character varying,
    date_created date NOT NULL,
    prix_unitaire integer NOT NULL,
    quantite integer NOT NULL,
    status boolean NOT NULL,
    code_produit character varying(255) NOT NULL,
    taille integer,
    negociable boolean
);


ALTER TABLE public.produit OWNER TO postgres;

--
-- Name: produit_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE produit_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.produit_id_seq OWNER TO postgres;

--
-- Name: produit_object; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE produit_object (
    id integer NOT NULL,
    produit_id integer,
    src text NOT NULL,
    date_created date NOT NULL
);


ALTER TABLE public.produit_object OWNER TO postgres;

--
-- Name: produit_object_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE produit_object_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.produit_object_id_seq OWNER TO postgres;

--
-- Name: promotion; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE promotion (
    id integer NOT NULL,
    libelle character varying(255) NOT NULL,
    date_created date NOT NULL
);


ALTER TABLE public.promotion OWNER TO postgres;

--
-- Name: promotion_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE promotion_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.promotion_id_seq OWNER TO postgres;

--
-- Name: short; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE short (
    id integer NOT NULL,
    boutique_id integer,
    src character varying(255) NOT NULL,
    titre character varying(255) NOT NULL,
    status boolean NOT NULL,
    description character varying(10000) DEFAULT NULL::character varying,
    date_created date NOT NULL,
    preview character varying(255) DEFAULT NULL::character varying
);


ALTER TABLE public.short OWNER TO postgres;

--
-- Name: short_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE short_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.short_id_seq OWNER TO postgres;

--
-- Name: transaction; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE transaction (
    id integer NOT NULL,
    client_id integer,
    panier_id integer,
    mode_paiement_id integer,
    type_transaction_id integer,
    libelle character varying(255) NOT NULL,
    montant integer NOT NULL,
    token character varying(255) NOT NULL,
    date_create timestamp(0) without time zone NOT NULL,
    status boolean NOT NULL,
    nom_client character varying(255) NOT NULL,
    prenom_client character varying(255) NOT NULL,
    numero_client character varying(255) NOT NULL
);


ALTER TABLE public.transaction OWNER TO postgres;

--
-- Name: transaction_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE transaction_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.transaction_id_seq OWNER TO postgres;

--
-- Name: type_commande; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE type_commande (
    id integer NOT NULL,
    libelle character varying(255) NOT NULL
);


ALTER TABLE public.type_commande OWNER TO postgres;

--
-- Name: type_commande_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE type_commande_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.type_commande_id_seq OWNER TO postgres;

--
-- Name: type_paiement; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE type_paiement (
    id integer NOT NULL,
    libelle character varying(255) NOT NULL
);


ALTER TABLE public.type_paiement OWNER TO postgres;

--
-- Name: type_paiement_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE type_paiement_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.type_paiement_id_seq OWNER TO postgres;

--
-- Name: type_transaction; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE type_transaction (
    id integer NOT NULL,
    libelle character varying(255) NOT NULL
);


ALTER TABLE public.type_transaction OWNER TO postgres;

--
-- Name: type_transaction_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE type_transaction_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.type_transaction_id_seq OWNER TO postgres;

--
-- Name: type_user; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE type_user (
    id integer NOT NULL,
    libelle character varying(255) NOT NULL,
    status boolean NOT NULL
);


ALTER TABLE public.type_user OWNER TO postgres;

--
-- Name: type_user_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE type_user_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.type_user_id_seq OWNER TO postgres;

--
-- Name: user_plateform; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE user_plateform (
    id integer NOT NULL,
    type_user_id integer,
    nom character varying(255) NOT NULL,
    prenom character varying(255) NOT NULL,
    email character varying(255) NOT NULL,
    roles json NOT NULL,
    phone integer NOT NULL,
    status boolean NOT NULL,
    password character varying(255) NOT NULL,
    date_created date NOT NULL,
    key_secret text,
    code_parrain character varying(255) DEFAULT NULL::character varying,
    code_recup character varying(255) DEFAULT NULL::character varying
);


ALTER TABLE public.user_plateform OWNER TO postgres;

--
-- Name: user_plateform_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE user_plateform_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.user_plateform_id_seq OWNER TO postgres;

--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY messenger_messages ALTER COLUMN id SET DEFAULT nextval('messenger_messages_id_seq'::regclass);


--
-- Data for Name: abonnement_boutique; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY abonnement_boutique (id, boutique_id, client_id, date_created, status) FROM stdin;
7	27	1	2023-06-18 16:38:34	t
8	30	1	2023-06-18 16:39:40	t
\.


--
-- Name: abonnement_boutique_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('abonnement_boutique_id_seq', 8, true);


--
-- Data for Name: boutique; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY boutique (id, user_id, localisation_id, category_id, titre, description, status, code_boutique, date_created, date_first_activated, date_last_desactivated) FROM stdin;
16	94	16	1	Johns-Erdman	 Irure elit Lorem incididunt enim pariatur exercitation deserunt sunt consequat quis nisi veniam do. Adipisicing voluptate occaecat id dolore duis incididunt eu occaecat tempor Lorem adipisicing. Sunt officia elit ex anim consectetur\n          	t	boutiqueoF4ig	2023-05-28	2023-07-08	2023-07-08
21	87	21	6	Lubowitz, Dietrich and Stamm	 Irure elit Lorem incididunt enim pariatur exercitation deserunt sunt consequat quis nisi veniam do. Adipisicing voluptate occaecat id dolore duis incididunt eu occaecat tempor Lorem adipisicing. Sunt officia elit ex anim consectetur\n          	f	boutiqueADRGh	2023-05-28	2023-07-08	2023-07-08
20	89	20	1	Rice, Morar and Rutherford	 Irure elit Lorem incididunt enim pariatur exercitation deserunt sunt consequat quis nisi veniam do. Adipisicing voluptate occaecat id dolore duis incididunt eu occaecat tempor Lorem adipisicing. Sunt officia elit ex anim consectetur\n          	t	boutiqueVo2v1	2023-05-28	2023-07-08	2023-07-08
22	36	22	6	Thompson, Graham and Kuhn	 Irure elit Lorem incididunt enim pariatur exercitation deserunt sunt consequat quis nisi veniam do. Adipisicing voluptate occaecat id dolore duis incididunt eu occaecat tempor Lorem adipisicing. Sunt officia elit ex anim consectetur\n          	t	boutiqueFtFAO	2023-05-28	2023-07-08	2023-07-08
23	62	23	1	Bruen-Bayer	 Irure elit Lorem incididunt enim pariatur exercitation deserunt sunt consequat quis nisi veniam do. Adipisicing voluptate occaecat id dolore duis incididunt eu occaecat tempor Lorem adipisicing. Sunt officia elit ex anim consectetur\n          	t	boutiqueXVgKu	2023-05-28	2023-07-08	2023-07-08
24	88	24	4	Stamm-Block	 Irure elit Lorem incididunt enim pariatur exercitation deserunt sunt consequat quis nisi veniam do. Adipisicing voluptate occaecat id dolore duis incididunt eu occaecat tempor Lorem adipisicing. Sunt officia elit ex anim consectetur\n          	t	boutiqueJNDSx	2023-05-28	2023-07-08	2023-07-08
25	90	25	3	Satterfield, Corwin and Lind	 Irure elit Lorem incididunt enim pariatur exercitation deserunt sunt consequat quis nisi veniam do. Adipisicing voluptate occaecat id dolore duis incididunt eu occaecat tempor Lorem adipisicing. Sunt officia elit ex anim consectetur\n          	t	boutique34uak	2023-05-28	2023-07-08	2023-07-08
26	93	26	3	Schaden, Toy and Klein	 Irure elit Lorem incididunt enim pariatur exercitation deserunt sunt consequat quis nisi veniam do. Adipisicing voluptate occaecat id dolore duis incididunt eu occaecat tempor Lorem adipisicing. Sunt officia elit ex anim consectetur\n          	t	boutiqueJR1gu	2023-05-28	2023-07-08	2023-07-08
27	83	27	5	Purdy, Rogahn and Swift	 Irure elit Lorem incididunt enim pariatur exercitation deserunt sunt consequat quis nisi veniam do. Adipisicing voluptate occaecat id dolore duis incididunt eu occaecat tempor Lorem adipisicing. Sunt officia elit ex anim consectetur\n          	t	boutique98l4I	2023-05-28	2023-07-08	2023-07-08
28	89	28	6	Walter, Price and Marquardt	 Irure elit Lorem incididunt enim pariatur exercitation deserunt sunt consequat quis nisi veniam do. Adipisicing voluptate occaecat id dolore duis incididunt eu occaecat tempor Lorem adipisicing. Sunt officia elit ex anim consectetur\n          	t	boutiqueD16Vn	2023-05-28	2023-07-08	2023-07-08
29	2	29	1	Kessler, Waelchi and Dare	 Irure elit Lorem incididunt enim pariatur exercitation deserunt sunt consequat quis nisi veniam do. Adipisicing voluptate occaecat id dolore duis incididunt eu occaecat tempor Lorem adipisicing. Sunt officia elit ex anim consectetur\n          	t	boutique4kNE6	2023-05-28	2023-07-08	2023-07-08
30	62	30	1	Mills-Padberg	 Irure elit Lorem incididunt enim pariatur exercitation deserunt sunt consequat quis nisi veniam do. Adipisicing voluptate occaecat id dolore duis incididunt eu occaecat tempor Lorem adipisicing. Sunt officia elit ex anim consectetur\n          	t	boutiqueHOl4F	2023-05-28	2023-07-08	2023-07-08
11	1	11	7	Hettinger LLC	 Irure elit Lorem incididunt enim pariatur exercitation deserunt sunt consequat quis nisi veniam do. Adipisicing voluptate occaecat id dolore duis incididunt eu occaecat tempor Lorem adipisicing. Sunt officia elit ex anim consectetur\n          	t	boutiquecuQau	2023-05-28	2023-07-08	2023-07-08
13	88	13	7	Glover Ltd	 Irure elit Lorem incididunt enim pariatur exercitation deserunt sunt consequat quis nisi veniam do. Adipisicing voluptate occaecat id dolore duis incididunt eu occaecat tempor Lorem adipisicing. Sunt officia elit ex anim consectetur\n          	t	boutiqueanqHT	2023-05-28	2023-07-08	2023-07-08
17	88	17	1	Bernhard, Kirlin and Kertzmann	 Irure elit Lorem incididunt enim pariatur exercitation deserunt sunt consequat quis nisi veniam do. Adipisicing voluptate occaecat id dolore duis incididunt eu occaecat tempor Lorem adipisicing. Sunt officia elit ex anim consectetur\n          	t	boutiqueIAYFl	2023-05-28	2023-07-08	2023-07-08
18	34	18	3	Bode, O'Hara and Nicolas	 Irure elit Lorem incididunt enim pariatur exercitation deserunt sunt consequat quis nisi veniam do. Adipisicing voluptate occaecat id dolore duis incididunt eu occaecat tempor Lorem adipisicing. Sunt officia elit ex anim consectetur\n          	t	boutiquesgViU	2023-05-28	2023-07-08	2023-07-08
14	70	14	3	McGlynn Ltd	 Irure elit Lorem incididunt enim pariatur exercitation deserunt sunt consequat quis nisi veniam do. Adipisicing voluptate occaecat id dolore duis incididunt eu occaecat tempor Lorem adipisicing. Sunt officia elit ex anim consectetur\n          	t	boutiqueNZ2CG	2023-05-28	2023-07-08	2023-07-08
19	91	19	3	Roob, Romaguera and Sipes	 Irure elit Lorem incididunt enim pariatur exercitation deserunt sunt consequat quis nisi veniam do. Adipisicing voluptate occaecat id dolore duis incididunt eu occaecat tempor Lorem adipisicing. Sunt officia elit ex anim consectetur\n          	f	boutique5dm5z	2023-05-28	2023-07-08	2023-07-08
15	34	15	5	McGlynn, Quitzon and Von	 Irure elit Lorem incididunt enim pariatur exercitation deserunt sunt consequat quis nisi veniam do. Adipisicing voluptate occaecat id dolore duis incididunt eu occaecat tempor Lorem adipisicing. Sunt officia elit ex anim consectetur\n          	f	boutiquez54eR	2023-05-28	2023-07-08	2023-07-08
12	88	12	5	Bailey Group	 Irure elit Lorem incididunt enim pariatur exercitation deserunt sunt consequat quis nisi veniam do. Adipisicing voluptate occaecat id dolore duis incididunt eu occaecat tempor Lorem adipisicing. Sunt officia elit ex anim consectetur\n          	t	boutiquekJio1	2023-05-28	2023-07-08	2023-07-08
\.


--
-- Name: boutique_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('boutique_id_seq', 30, true);


--
-- Data for Name: boutique_object; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY boutique_object (id, boutique_id, src, date_created) FROM stdin;
11	11	btg0Izt.jpg	2023-05-28 12:46:06
12	12	produitLuz1V.jpg	2023-05-28 12:46:06
13	13	Screenshot 2023-05-09 at 08.53.25.png	2023-05-28 12:46:06
14	14	photo_2023-05-28_13-37-32.jpg	2023-05-28 12:46:06
15	15	produitLuz1V.jpg	2023-05-28 12:46:06
16	16	photo_2023-05-28_13-35-31.jpg	2023-05-28 12:46:06
17	17	photo_2023-05-28_12-08-49.jpg	2023-05-28 12:46:06
18	18	photo_2023-05-28_12-06-57.jpg	2023-05-28 12:46:06
19	19	btwbuTW.jpg	2023-05-28 12:46:06
20	20	produitLuz1V.jpg	2023-05-28 12:46:06
21	21	photo_2023-05-28_13-35-59.jpg	2023-05-28 12:46:45
22	22	Screenshot 2023-05-09 at 08.53.25.png	2023-05-28 12:46:45
23	23	photo_2023-05-28_13-35-31.jpg	2023-05-28 12:46:45
24	24	photo_2023-05-28_12-07-58.jpg	2023-05-28 12:46:45
25	25	photo_2023-05-28_13-36-35.jpg	2023-05-28 12:46:45
26	26	bt65pc4.jpg	2023-05-28 12:46:45
27	27	bt67wKJ.jpg	2023-05-28 12:46:45
28	28	btLBRwC.jpg	2023-05-28 12:46:45
29	29	btD9JB4.jpg	2023-05-28 12:46:45
30	30	photo_2023-05-28_12-06-57.jpg	2023-05-28 12:46:45
\.


--
-- Name: boutique_object_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('boutique_object_id_seq', 30, true);


--
-- Data for Name: category; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY category (id, libelle, description, date_created, status, logo) FROM stdin;
3	Alimentaire	description*****	2022-12-18	t	alimentaire.jpg
1	Electronique	description*****	2022-12-18	t	electronique.jpg
4	Electro-Menager	description*****	2022-12-18	t	eletro-menager.jpg
6	Ustenciles	description*****	2022-12-18	t	ustencile.jpg
7	Super-marche	Super-marche	2023-02-20	t	super-marche.jpg
5	Vetements	description*****	2022-12-18	t	vetement.jpg
8	test	new	2023-07-13	f	http://127.0.0.1:8000/images/default/boutique.png
\.


--
-- Name: category_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('category_id_seq', 8, true);


--
-- Data for Name: commande; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY commande (id, mode_paiement_id, panier_id, type_commande_id, point_livraison_id, titre, description, date_created, code_commande, code_client, status_buy, status_finish, token, montant) FROM stdin;
29	1	27	1	5	Achat de produit	Achat de produit	2023-07-01	IusF	QuDA	f	1	p.Scb60WTxIc9idMo5jIimrxIlOK8QFJiqN6Dvczl6CVLX70RGElu8A5ecb2csx4gIVCngrzSzOHfsOLZEA0ycexQwXS4exGD7	1000
30	1	27	1	5	Achat de produit	Achat de produit	2023-07-01	IusF	QuDA	f	1	p.Scb60WTxIc9idMo5jIimrxIlOK8QFJiqN6Dvczl6CVLX70RGElu8A5ecb2csx4gIVCngrzSzOHfsOLZEA0ycexQwXS4exGD7	1000
31	1	27	1	5	Achat de produit	Achat de produit	2023-07-01	IusF	QuDA	f	1	p.Scb60WTxIc9idMo5jIimrxIlOK8QFJiqN6Dvczl6CVLX70RGElu8A5ecb2csx4gIVCngrzSzOHfsOLZEA0ycexQwXS4exGD7	1000
32	1	27	1	5	Achat de produit	Achat de produit	2023-07-01	IusF	QuDA	f	1	p.Scb60WTxIc9idMo5jIimrxIlOK8QFJiqN6Dvczl6CVLX70RGElu8A5ecb2csx4gIVCngrzSzOHfsOLZEA0ycexQwXS4exGD7	1000
1	1	27	1	5	Achat de produit	Achat de produit	2023-07-01	IusF	QuDA	f	1	p.Scb60WTxIc9idMo5jIimrxIlOK8QFJiqN6Dvczl6CVLX70RGElu8A5ecb2csx4gIVCngrzSzOHfsOLZEA0ycexQwXS4exGD7	1000
2	1	27	1	5	Achat de produit	Achat de produit	2023-07-01	IusF	QuDA	f	1	p.Scb60WTxIc9idMo5jIimrxIlOK8QFJiqN6Dvczl6CVLX70RGElu8A5ecb2csx4gIVCngrzSzOHfsOLZEA0ycexQwXS4exGD7	1000
3	1	27	1	5	Achat de produit	Achat de produit	2023-07-01	IusF	QuDA	f	1	p.Scb60WTxIc9idMo5jIimrxIlOK8QFJiqN6Dvczl6CVLX70RGElu8A5ecb2csx4gIVCngrzSzOHfsOLZEA0ycexQwXS4exGD7	1000
4	1	27	1	5	Achat de produit	Achat de produit	2023-07-01	IusF	QuDA	f	1	p.Scb60WTxIc9idMo5jIimrxIlOK8QFJiqN6Dvczl6CVLX70RGElu8A5ecb2csx4gIVCngrzSzOHfsOLZEA0ycexQwXS4exGD7	1000
5	1	27	1	5	Achat de produit	Achat de produit	2023-07-01	IusF	QuDA	f	1	p.Scb60WTxIc9idMo5jIimrxIlOK8QFJiqN6Dvczl6CVLX70RGElu8A5ecb2csx4gIVCngrzSzOHfsOLZEA0ycexQwXS4exGD7	1000
6	1	27	1	5	Achat de produit	Achat de produit	2023-07-01	IusF	QuDA	f	1	p.Scb60WTxIc9idMo5jIimrxIlOK8QFJiqN6Dvczl6CVLX70RGElu8A5ecb2csx4gIVCngrzSzOHfsOLZEA0ycexQwXS4exGD7	1000
33	1	31	1	2	Achat de produit	Achat de produit	2023-07-05	G12O	Gm7u	f	0	p.V6M9k3ihBwXLUrvUmCPoFKBIqLiSwjCw3NUUN2zeZo6EqS85vJyML5Q94LUcCKS7Eh6ATFDcjIJKVT4JZRTCu1j30OcdW7LF	40350
25	2	28	1	2	Achat de produit	Achat de produit	2023-07-01	wDoO	XSQD	f	0	p.D4KHLIOHHLthlqVE4LBnVfi2LGMouuyxg7osw9OjqoeBUOKVg4cnhFT62vzFejcIzqpomMs1TPkaIG6vRaRH0siG57JnqljB	50000
27	1	28	1	5	Achat de produit	Achat de produit	2023-07-01	gffggfg	QuDA	f	0	p.Scb60WTxIc9idMo5jIimrxIlOK8QFJiqN6Dvczl6CVLX70RGElu8A5ecb2csx4gIVCngrzSzOHfsOLZEA0ycexQwXS4exGD7	8000
24	1	27	1	5	Achat de produit	Achat de produit	2023-07-01	IusF	QuDA	f	1	p.Scb60WTxIc9idMo5jIimrxIlOK8QFJiqN6Dvczl6CVLX70RGElu8A5ecb2csx4gIVCngrzSzOHfsOLZEA0ycexQwXS4exGD7	1000
26	1	27	1	5	Achat de produit	Achat de produit	2023-07-01	IusF	QuDA	t	3	p.Scb60WTxIc9idMo5jIimrxIlOK8QFJiqN6Dvczl6CVLX70RGElu8A5ecb2csx4gIVCngrzSzOHfsOLZEA0ycexQwXS4exGD7	1000
28	1	27	1	5	Achat de produit	Achat de produit	2023-07-01	IusF	QuDA	f	1	p.Scb60WTxIc9idMo5jIimrxIlOK8QFJiqN6Dvczl6CVLX70RGElu8A5ecb2csx4gIVCngrzSzOHfsOLZEA0ycexQwXS4exGD7	1000
\.


--
-- Name: commande_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('commande_id_seq', 33, true);


--
-- Data for Name: commission; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY commission (id, pourcentage_produit, frais_livraison_produit, frais_buy_livreur) FROM stdin;
1	2	250	500
\.


--
-- Name: commission_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('commission_id_seq', 1, false);


--
-- Data for Name: communication; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY communication (id, client_id, date_created, code_communication) FROM stdin;
1	1	2023-06-28 00:00:00	1234
\.


--
-- Name: communication_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('communication_id_seq', 1, false);


--
-- Data for Name: compte; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY compte (id, user_id, solde) FROM stdin;
2	12	0
3	13	0
4	14	0
5	16	0
6	17	0
1	1	119500
7	2	0
8	3	0
9	19	0
10	34	0
11	36	0
12	39	0
13	60	0
14	62	0
15	70	0
16	72	0
17	74	0
18	76	0
19	80	0
20	83	0
21	84	0
22	85	0
23	86	0
24	87	0
25	88	0
26	89	0
27	90	0
28	91	0
29	92	0
30	93	0
31	94	0
32	96	0
33	98	0
34	100	0
35	101	0
36	102	0
\.


--
-- Name: compte_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('compte_id_seq', 36, true);


--
-- Data for Name: connexion; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY connexion (id, user_id, date_in, date_out, user_agent, ip) FROM stdin;
\.


--
-- Name: connexion_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('connexion_id_seq', 1, false);


--
-- Data for Name: doctrine_migration_versions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY doctrine_migration_versions (version, executed_at, execution_time) FROM stdin;
DoctrineMigrations\\Version20230524201012	2023-05-25 20:48:10	88
DoctrineMigrations\\Version20230525204827	2023-05-25 20:48:31	94
DoctrineMigrations\\Version20230527105645	2023-05-27 10:56:57	941
DoctrineMigrations\\Version20230527210331	2023-05-27 21:04:33	256
DoctrineMigrations\\Version20230528113556	2023-05-28 11:36:00	660
DoctrineMigrations\\Version20230528114128	2023-05-28 11:41:32	138
DoctrineMigrations\\Version20230528121352	2023-05-28 12:13:56	514
DoctrineMigrations\\Version20230528122532	2023-05-28 12:25:35	715
DoctrineMigrations\\Version20230528124137	2023-05-28 12:41:41	863
DoctrineMigrations\\Version20230528124421	2023-05-28 12:44:31	246
DoctrineMigrations\\Version20230602230358	2023-06-02 23:12:18	305
DoctrineMigrations\\Version20230602233858	2023-06-02 23:39:04	171
DoctrineMigrations\\Version20230603010106	2023-06-03 01:01:15	240
DoctrineMigrations\\Version20230603231347	2023-06-03 23:13:57	1613
DoctrineMigrations\\Version20230611191357	2023-06-11 19:14:20	284
DoctrineMigrations\\Version20230611210620	2023-06-11 21:06:31	529
DoctrineMigrations\\Version20230611212139	2023-06-11 21:21:50	217
DoctrineMigrations\\Version20230611220526	2023-06-11 22:05:45	76
DoctrineMigrations\\Version20230622200343	2023-06-22 20:05:15	218
DoctrineMigrations\\Version20230628184749	2023-06-28 18:47:58	507
DoctrineMigrations\\Version20230628185450	2023-06-28 18:55:55	127
DoctrineMigrations\\Version20230628185553	2023-06-28 18:55:55	2
DoctrineMigrations\\Version20230628190916	2023-06-28 19:09:29	2462
DoctrineMigrations\\Version20230628190950	2023-06-28 19:09:54	95
DoctrineMigrations\\Version20230628190952	2023-06-28 19:09:54	2
DoctrineMigrations\\Version20230628192950	2023-06-28 19:29:55	156
DoctrineMigrations\\Version20230628193442	2023-06-28 19:34:52	120
DoctrineMigrations\\Version20230703103622	2023-07-03 10:36:25	76
DoctrineMigrations\\Version20230708145428	2023-07-08 14:57:41	25
DoctrineMigrations\\Version20230708173726	2023-07-08 17:38:15	58
\.


--
-- Data for Name: historique_paiement; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY historique_paiement (id, user_id, type_paiement_id, commande_id, montant, date_created, token, status) FROM stdin;
\.


--
-- Name: historique_paiement_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('historique_paiement_id_seq', 1, false);


--
-- Data for Name: jwt_refresh_token; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY jwt_refresh_token (id, refresh_token, username, valid, date_expire_token) FROM stdin;
1	8a11a9275d2ba665dbdacb6b2e5788d620145e7acbb0a88bd8d4752eb42353794581131bc96eee7d8e07bf1c2665f499f77531455dcf8bccadb27d19cd58f58c	690863838	2023-06-24 20:56:02	2023-05-25 21:56:02
2	2644aa59f7b522c8db6edb13fe3a988a0ee8d9d363ca3ee1e5005dff190b73903916281bab444bc4b507a2c86e2c1a47e4e4dc958d5bf4ebef52ab402681126a	690863838	2023-06-27 17:54:20	2023-05-28 18:54:20
3	ba41130d27525b36285392102f2981fb545fd703d50bd904eaff3afb46d8d4dacbbeec2cefcd32401035c143e75da9a32c8a77cbea490e12563b446ab427dd0b	690863838	2023-07-02 22:27:29	2023-06-02 23:27:29
4	93c18846a54ec0abb1f9540f7a1752ca45813c3c3701cd6fa06fe8a973c0e1cf371bed6562ffcbc00c982e6876d79755c3963a66ed45d11ba8aa60f54a1e785c	690863838	2023-07-04 09:56:40	2023-06-04 10:56:40
5	07d6d0546e0a26299ff437557e41c7d4653ab007770c3da12c0d0921328eaae2729fdaf403e88ac1072cf183538cd7deeba8acc3f91309781537e2c2755fdbb9	690863838	2023-07-04 09:57:30	2023-06-04 10:57:30
6	ffc45c9bfa1033bb4863669cf2f4129fa849c81e7459b3d48c0f2dd4bb64c14437a22ae555f412a6042c3ef7dbdfaf7db32dba10f151a215ea2bcb0a43ae0e9f	690863838	2023-07-11 20:33:51	2023-06-11 21:33:51
7	29f2c060238aff1d40ee229061f8d083028c8b1d0725c16ed7c298906d5e9ad72a442a5ce7fc8b00977d772a5d219d8377f6e3dd80ace04111bf2b500b21d0ac	690863838	2023-07-12 19:35:08	2023-06-12 20:35:08
8	27fcc3781a671ea05f012162228a7069e0403963f9420d19f3197271a3b72d3718227cbcf61aa028f7411b51dbc3cb11f86aa4ee82b58500b58c691f466186db	690863838	2023-07-28 10:03:09	2023-06-28 11:03:09
9	b13246bb4f5bb0fdd48d40cd4c81d3c5f52d0b1eac07f5a49bef038c3da66d1b3c49ab87f5ec9bde5544fcaf943a50dce4e4bfa6b58efc23fd4b368a85a66d6f	690863838	2023-07-28 10:19:54	2023-06-28 11:19:54
10	9e19cbaddff3bcd280da071fb211e03002b898452e3229429436ecef4b0234021eede9a3c0198969a6887b51546c4758890027bc993c6cfa932953b626ae4107	690863838	2023-07-28 10:37:01	2023-06-28 11:37:01
11	8947ab6214eb0ac928560a70bf7752da1dc12e2d15ef0297eb1022ebbe023f4ada55a7b9c5aac9ee5a54f8a560b0e879090736518b1a2634391ed427b76d98bd	690863838	2023-07-28 10:37:03	2023-06-28 11:37:03
12	c578dfadbf2167861e2874d7169073f9a0eff208dcb7f7525541e151bb7bbce77e38e7a621966efd174760cf225d226081d95ee7d90899cd82610ee43031cd05	690863838	2023-07-28 19:26:57	2023-06-28 20:26:57
13	7f0395059576047ffeb6314489a500267036f10f90f64d4f4b7a13fee8e2e787f309cbd1b5212aba23f12781238018cb52ebb7ff0642232eb902d63932586dbb	690863838	2023-07-28 19:44:36	2023-06-28 20:44:36
14	088e108ce086d1cb73cfdb036e3a3ddd00bfb7c14d9a95b50ac3af5c50f7e3e71a10d5a010a9ed22ed5424374feacfda2cbc38a99ee1bc4439d27734915f41d3	690863838	2023-07-28 19:47:27	2023-06-28 20:47:27
15	e12678a99e32855a90cbfb3c38d46422116c916aa8e1afa70a94b1d92b1fb28ea2567a720681b7704be2635b18524a53501308efb770e6e5849a0f087d4d978e	690863838	2023-07-31 09:58:42	2023-07-01 10:58:42
16	94180bab17d88f6bca75e34b4b87f2cb8f06760d87a6cc1aaa2f0c8ab4ef789ae4e922ebc3604b17d84f87d1f84c707224e5165de85c37ade725b72f6215165c	690863838	2023-07-31 10:03:25	2023-07-01 11:03:25
17	acb748c6a273753deaf72bdb8b6dbb9d7b1f10e600c3b00bc2dd6fdf7ee3eb8f3b33c5bdcc434f8ff1663303d3626d57a597e8e16d4d9d3f909e982d9e340702	690863838	2023-07-31 10:03:27	2023-07-01 11:03:27
18	16ca957d42233b0a03ef21d2a00b1629f4bd85b154b35c9fd3b71cb0c956cb0b1d5f78aeac45497b4a53d2a0e7489a6017021bb1705a3caa2ed1d0c4c5ee12fc	690863838	2023-07-31 10:05:10	2023-07-01 11:05:10
19	dfd18606a875a04eedcb65d8a33c033d3588b17ef515d6e45159218225c1a23996a0dfe54dd72808f1a2afa6462be2060b89bfe8862acb44e5baf350d6f8f432	690863838	2023-07-31 14:38:01	2023-07-01 15:38:01
20	daa6c9a0e70df1da2692482994c421585c9f6fe7ab9b46f1fd49dc7182fa5f7c354562da9846319765e52d2dae1686538dc8f9cfa37598dd2fe6237c9f2e6a02	690863838	2023-08-03 13:03:48	\N
21	2a983f08ac9c366aa573d27999e214b6eec0bb1a130bcb9cb673f5af6f560fc5ab5dc95be521915278c3014a91f0209ee65a4873bab9420d6846cccc48677370	690863838	2023-08-03 13:04:32	\N
22	7bca792b295dcb2a0bbe2005e085fe787defc4214e7cc15491af6693678e96c45665034fd19141237cdb81d9b0c6239c49daf6eddec0f24e0b8121462c56311f	690863838	2023-08-03 13:04:35	\N
23	eaa3afa47fd94b861c5a6d3e794a0cfc09cd20f9e7b3dced00a6c3b9763fc97c60d264117acce88e9969b4c3ee2cabf340782f06507097fbd041cad7a7e741f1	690863838	2023-08-03 13:22:07	\N
24	a66842bfda91ad367162cfcdb1b1a57e7dad8f884e5ff91b32674961cbda23dc8eb42af922eb2697a1310c347a773156e452f2117736ed921cc3c33e5e9d7431	690863838	2023-08-03 13:22:24	\N
25	3cd688fbda1573772860ec139361e411241a6e8ff152f7c728f7843291a6b1ee5a1e48e5ca93af5415f34ce15a3856a0ed6733f59ccdd062382d5cbd915145ca	690863838	2023-08-03 13:43:03	\N
26	c4eda48f9585216349c410ee14ef2a0ffae64a5026a8f63e0be1564edcbae66af78e4047fa08eb8dd1f6d55df66d546d78153e8d19b3383f94aca25547258b09	690863838	2023-08-03 13:54:42	\N
27	07ff8360bd0ceede20be63cbc64fc25cc7c504751185ca02bdf72b42cdc24f69f0a2185a22ddaddbaefa080537cd05ed4d016982942af8e030f7d137af3a4319	690863838	2023-08-03 14:12:29	\N
28	b9b46bd7f6312f5a19f4f3966ef5421ecec408749851179bded9b982b54864c1ba50d1626a886e1c7bc8867f3db6fb2d9912fc39a3e4a83db1bd91684722cabe	690863838	2023-08-03 14:14:06	\N
29	73277df8e830a06490256db41021b15919920b383a2a3e480317fd37886bf592c1c56899c7d26cc0e855950e8ca294a795ceb4286f8334c989bbff30890b68c3	690863838	2023-08-03 14:14:17	\N
30	aecd5134b70e36bbbfc0aebdc77926dc396bedb32422e51fe4f88cc55c8288055e316fae5ae3a2b2742677461dd10bc585ea392aea95e7a67db69f96ba8baa6f	690863838	2023-08-03 14:15:02	\N
31	a8404becb9caddcf6579f4c71ba671a116b85e1d3b21958ebeb7397bd8b2d6376f39dd5a405705105bee8ffb585c6ad367752374afa6b058a9580535f4c3baa4	690863838	2023-08-03 14:15:41	\N
32	aaf39e80bd9270f6cf2db1b0d08d365a6731787881e434eb5a468f50ce97b046156e3f4cb8823ee6af0ec14a00d0049f4a0087efe21e5e63f338f65012012c9a	690863838	2023-08-03 14:16:23	\N
33	7ddb306e21cdef645374e6b4189618e1261d5dfc456353044c4abd5bbc41eb6f16e112465007157cfb57392f4827d30daf0da300d795437b0c4b0e42cbd514ab	690863838	2023-08-03 14:16:59	\N
34	4e7f2b907a73ed30a7eda1930aaeff60079a32ecfe65004b4461cfa39802dca48050335b31f0a422c0904cfd9d5dcbf4f1d09d704495dfa59f3cacbb6a9905e4	690863838	2023-08-03 14:17:40	\N
35	b9ed14ac30f9bc8c496e9d0e0e0101f47bbf74f159246811b4413482d9311cc3548a97cc9cb68c6440b8b0f80e7092b209a24ee2edca9d5ac5028aca545d6142	690863838	2023-08-03 14:20:11	\N
36	5f2d398203bf228dbbc2ccce9b6c5c30fc0cc6d87d2f287ce69012d5148f441e086743fdec50fe899d2fa25f8b0efc7797d3de104b9c575441278d51a04a84e6	690863838	2023-08-03 14:27:20	\N
37	2ae32e7d6fb8064e8d6c101ccbfcc8222740a55355b7f1a7a51aca6f3c4faeed8114ddc9d546db2efa309045f726a5119045dd5f5d56277f2d55997a14272ccc	690863838	2023-08-03 14:30:29	\N
38	87387fab9e7d963905ae8401c75dcf96bea92598368f8ca5996ac3e7ecec741448a9831a6c6f1d9e46551ef0b884c66fee57965d51e85990625dd7680762d6db	690863838	2023-08-03 14:31:35	\N
39	f70e671c131eb189455e5f8c3c405713473c3f8a4e970d004ab6e693a19bf821321893cfca3f4fbaaf4f394b73aa5eb3372c54c9c7c7c413f55262f7d9e5519d	690863838	2023-08-03 14:32:34	\N
40	381c470db80884e913a5e5e67d5a8b85d5f757b43fd91b72e7cda2194fa47a9effaec757c42329d72e20b773f5303f1d7201a48d96de3d5adf0f3446b1256f10	690863838	2023-08-03 14:35:08	\N
41	2be0121c3cf93abf2f34344e077d486240a97497297013a4b10ea82cbcdb2b9be0e92d0812a7d61ce97f9fba0a84c2afbc2430a2beee571eeb6998ababae54d6	690863838	2023-08-04 09:15:36	\N
42	50351fff796a6f3e3b7088be9d28edbcf9b6bb1e0363c6ff678040fcb69f111f5a5491f72820aa742b08bd0f75caec427310a165238bdd40e049117a5c4cc788	690863838	2023-08-04 09:18:54	\N
43	af205dad92a6034dfe3509aba6b584b4f5734f2f867b9e7b6f89f8c3165e7ef0e4139d823e86d3589afbda72b81534d80d51bde7b8e9eaaac1df82e20655bae9	690863838	2023-08-04 09:19:40	\N
44	2cbdea02cdaf9a4530a8c6c26d10552a070ec47bfabd7cb5828bf4b7faa083acceeefcbad7bb4cb709a38a248c6036b0e87ce26616d51b88b13acc0a0b5ec5ed	690863838	2023-08-04 09:20:36	\N
45	530284c0f56eeec64d175fbbc8c1e53d44a3f1487309400d1d66f2243a7cb5e62235c1ba405eefad75df5eb0a9d303297c079e8dd7566bdcb5d27ed6801ec2c4	690863838	2023-08-04 09:21:54	\N
46	f3892f0d2c3be69c241f5b28b27f6eb874310db1221ea12bc788d10aa2f8034c7a9ec530d4037c90ee7d4a073eb6a0a415637ede5783d529094313f2e5c83396	690863838	2023-08-04 09:45:53	\N
47	0a6f8949330bc7fbbb7e26229197cea7cf3877cab89a2ae57dcd109da6ab9b7827ad3698b1027c76fb0d22155dfc2ae24e672e4e4e13fdd9d0c0a1b5729cb104	690863838	2023-08-04 09:46:51	\N
48	3f5038811675cc608a197efa6d57d4cbadbfa3c52a479ba96bcea77e8f681ee5183d87edf5afa2f54ced84041665c8550d2928ce74401cf42d87d01e19732821	690863838	2023-08-04 11:06:33	\N
49	5f73678a1e36c2a48160fba0da8989ea40d6630d452982233ef7e6a4aad3210132527c1ece751233014b49c4bd3d0a553d8942a4c88114be797bdc50dc508801	690863838	2023-08-06 11:13:08	\N
50	8cbc6ccffe039a9a25c75636780939c0193c967cb297d5730da2746f516e633ba759e596338c58d90201071b6317bb4ed0743ae99c5215a1e60b031cc57e2984	690863838	2023-08-06 11:14:31	\N
51	37d1e6e6647e7f07ddffd714d1fddd953352024907c2d1a185c35ea3742501d199ccc109517a03c6ba139fdaa5a801daf688682a1a9f60aca6398cd6388ee793	690863838	2023-08-06 19:10:38	\N
52	7310780a8107fabda8ed401bfa8ffe23bd3f68565dc5048c4b530e7445b9d367282647715165d876bc75ba6261a5f2269dae3e1bce96f1e6ddd55e4ecd75253b	690863838	2023-08-07 10:07:20	\N
53	7cce086fc00392bd5c09366a2a21feeb6c19613dbd5b9ee4b30720e93da8cc31c46e4465f67a5b9bf447ad2221df210689c539776398ac89b86c1573518ab991	690863838	2023-08-07 11:28:38	\N
54	bfe16330d5c40ccfc13e67ebe833a4a1afaf10ffe6cab1f0132fee665739ba44a88043db20b4d7d0751feb52a43a01f572f35e951e1daf8e857060af3ea5d441	690863838	2023-08-07 12:29:20	\N
55	a22095d7179844e09acf91b0321a955aa75276d941e345c8c11b01f7351ed4e92198b6711ee5d1f0c69dd5daaba960b9a4830af42dbbb85e0eae61eef4fed171	690863838	2023-08-13 18:23:25	\N
56	41d0dcfc8976b0edc0d801710b1215ce28ca793c7e0799ce0477a2c38a952839ef1eb8f29f3fdbd3f8ef1787963186818dcc0c66e9ccd8aa5cd9408ece90dd9c	690863838	2023-08-14 13:51:45	\N
\.


--
-- Name: jwt_refresh_token_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('jwt_refresh_token_id_seq', 56, true);


--
-- Data for Name: like_produit; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY like_produit (id, client_id, produit_id, like_produit, date_created) FROM stdin;
14	1	45	t	2023-06-11
13	1	1	f	2023-06-11
16	1	43	f	2023-06-11
15	1	25	f	2023-06-11
17	1	81	t	2023-06-11
\.


--
-- Name: like_produit_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('like_produit_id_seq', 17, true);


--
-- Data for Name: list_commande_livreur; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY list_commande_livreur (id, commande_id, livreur_id, date_created) FROM stdin;
\.


--
-- Name: list_commande_livreur_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('list_commande_livreur_id_seq', 1, false);


--
-- Data for Name: list_produit_panier; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY list_produit_panier (id, panier_id, produit_id, status, quantite, code_produit_panier, date_created, prix_unitaire_vente) FROM stdin;
12	1	1	f	1	Nn63	2023-05-28 13:09:43	\N
17	6	1	f	1	ibJW	2023-05-31 20:51:36	\N
18	7	1	f	1	p2X9	2023-05-31 20:53:07	\N
22	11	1	f	1	J9OO	2023-05-31 20:59:30	\N
23	12	1	f	1	J8al	2023-05-31 21:00:15	\N
24	13	1	f	1	6EZv	2023-05-31 21:11:37	\N
25	13	4	f	2	zNKp	2023-05-31 21:11:37	\N
26	14	1	f	1	A2V4	2023-05-31 21:13:45	\N
27	14	4	f	2	qJlu	2023-05-31 21:13:45	\N
28	15	2	f	1	KwuC	2023-05-31 21:19:18	\N
29	16	2	f	1	TDOv	2023-05-31 21:21:00	\N
30	17	2	f	1	m6Tr	2023-05-31 21:23:03	\N
31	18	2	f	1	FKsP	2023-05-31 21:24:32	\N
32	19	2	f	1	jl2r	2023-05-31 21:25:53	\N
33	20	2	f	1	RZQ2	2023-05-31 21:26:26	\N
34	21	2	f	1	A03y	2023-05-31 21:27:25	\N
35	22	2	f	1	L0Ag	2023-05-31 21:30:11	\N
36	23	2	f	1	dZ0z	2023-05-31 21:30:16	\N
41	28	33	f	1	uHlD	2023-07-01 20:57:23	\N
21	10	2	f	1	I5So	2023-05-31 20:58:16	\N
19	8	3	f	1	IEya	2023-05-31 20:54:54	\N
20	9	5	f	1	bVuY	2023-05-31 20:55:42	\N
13	1	4	f	1	gY34	2023-05-28 13:10:17	\N
40	1	25	f	2	ehJy	2023-07-01 14:51:23	\N
48	31	87	f	6	B53U	2023-07-05 11:01:51	\N
49	31	54	f	2	jopB	2023-07-05 11:01:51	\N
50	31	91	f	1	RZjS	2023-07-05 11:01:51	\N
\.


--
-- Name: list_produit_panier_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('list_produit_panier_id_seq', 50, true);


--
-- Data for Name: list_produit_promotion; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY list_produit_promotion (id, produit_id, promotion_id, date_created, prix_promotion) FROM stdin;
\.


--
-- Name: list_produit_promotion_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('list_produit_promotion_id_seq', 1, false);


--
-- Data for Name: localisation; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY localisation (id, user_id, ville, longitude, latitude, ip, date_in) FROM stdin;
58	\N	2651 Boyle Pass Apt. 014\nNorth Cordell, IN 67862-4327	86.188500000000005	19.417104999999999		2023-05-28 11:36:12
59	\N	38397 Beer Drive\nNorth Eribertoside, RI 73143	97.538702000000001	48.171055000000003		2023-05-28 11:36:12
60	\N	9400 Bergstrom Mission\nPort Eunice, NM 18696-2846	-76.859692999999993	-45.980946000000003		2023-05-28 11:36:12
61	\N	6550 Kshlerin Lane Suite 006\nSouth Isobelland, NY 02484	56.148318000000003	19.667394000000002		2023-05-28 11:36:12
62	\N	15285 Kautzer Inlet Apt. 907\nO'Keefeberg, HI 68868-1263	-43.425006000000003	89.443807000000007		2023-05-28 11:36:12
63	\N	1487 Goyette Lake\nNew Nia, AK 62817-9520	24.647044999999999	19.139416000000001		2023-05-28 11:36:12
64	\N	118 Nelson Cliffs Apt. 255\nLake Vilma, CT 49482-8319	-101.884777	-32.783785000000002		2023-05-28 11:36:12
65	\N	2027 Elaina Mountain Apt. 450\nLeannaside, ID 68865	146.21806100000001	86.766901000000004		2023-05-28 11:36:12
66	\N	53720 Chanelle Ferry\nMedhurstville, MN 97511-1780	-176.135806	-45.288603999999999		2023-05-28 11:36:12
67	\N	2677 Declan Plaza\nWest Carmelo, KY 98999	104.021062	-17.337378000000001		2023-05-28 11:36:13
79	\N	91430 Rosalee Divide Apt. 882\nEast Avaland, WV 37758-2191	-49.213569	-36.923388000000003		2023-05-28 11:41:43
80	\N	33922 Abbott Pass\nKulasport, DC 84485	-54.280157000000003	-71.792816999999999		2023-05-28 11:41:43
81	\N	88888 Kendrick Mission\nRatketon, CT 51419	-78.946192999999994	-34.144328999999999		2023-05-28 11:41:43
82	\N	028 Nikita Crest Apt. 023\nEast Odellshire, NH 46145	51.717666999999999	0.77808699999999997		2023-05-28 11:41:43
83	\N	60586 Little Circle\nPort Rooseveltburgh, NM 80134	57.659320999999998	-82.819599999999994		2023-05-28 11:41:43
84	\N	92591 Hannah Ridges Apt. 356\nPort Arnoldport, CT 56453	77.571167000000003	-9.6192460000000004		2023-05-28 11:41:43
85	\N	486 Hollis Pass Apt. 120\nPort Bart, IA 40836-4593	155.62461300000001	-3.5478990000000001		2023-05-28 11:41:43
86	\N	77451 Eulalia Junctions Suite 521\nNew Aracelyville, MT 02136	-135.44504000000001	-27.437459		2023-05-28 11:41:43
87	\N	607 Reynolds Crescent Suite 446\nEast Addie, RI 83897	4.5312419999999998	-65.666636999999994		2023-05-28 11:41:43
88	\N	10456 Pacocha Coves\nLake Ariane, WY 58407	-16.776128	-68.445710000000005		2023-05-28 11:41:43
89	\N	4754 Feest Ridge Apt. 989\nLeonoraton, WI 39217	51.356513	-56.843404999999997		2023-05-28 11:42:54
90	\N	210 Boehm Island\nBurdetteburgh, NE 89901-1406	37.035696999999999	19.438317999999999		2023-05-28 11:42:54
91	\N	3915 Goyette Crossing\nEmmaleefort, AK 28096	-47.121831	-4.26485		2023-05-28 11:42:54
92	\N	58730 Rhiannon Mission\nLeannonville, MO 29305	109.659775	27.812290999999998		2023-05-28 11:42:54
93	\N	13759 Gail Plains\nJessicaport, OK 31561	71.518411	-47.907031000000003		2023-05-28 11:42:54
94	\N	4047 Dakota Knolls\nPort Darryl, NE 52696	56.246009000000001	24.754213		2023-05-28 11:42:54
95	\N	5195 Samantha Manors\nPort Leslie, NH 43688	6.4059030000000003	-49.520642000000002		2023-05-28 11:42:54
96	\N	250 Jacobs Rapid Apt. 549\nKaileymouth, DE 39043-6723	3.2184349999999999	7.3831160000000002		2023-05-28 11:42:54
97	\N	74340 Olin Manor Suite 538\nWest Vilmastad, SD 84777	-98.152997999999997	-12.063266		2023-05-28 11:42:54
98	\N	4160 Jett Curve Suite 530\nNew Emelyville, IN 10601-9262	145.43410499999999	-59.684221999999998		2023-05-28 11:42:54
99	\N	03377 Medhurst Gateway\nVeumton, AK 66045-9150	95.903514000000001	35.308230999999999		2023-05-28 11:44:45
100	\N	83955 Adella Trace\nEast Shannon, NH 89167	4.1426749999999997	1.499374		2023-05-28 11:44:45
101	\N	396 Jordyn Mews\nMurielchester, MT 65696	-150.38659899999999	25.717127000000001		2023-05-28 11:44:45
102	\N	21651 Bobby Ways\nLaurieburgh, CA 51847	-131.470045	47.983130000000003		2023-05-28 11:44:45
103	\N	65380 Sheila Court Suite 302\nAureliestad, DE 47061-2170	-169.824139	10.903053		2023-05-28 11:44:45
104	\N	65490 Gudrun Landing Apt. 709\nPort Eusebiochester, CT 26914-9505	143.76000099999999	-88.15652		2023-05-28 11:44:45
105	\N	7346 Larry Forest Apt. 554\nNew Melanyfort, SC 32508	-159.79478399999999	-14.283042999999999		2023-05-28 11:44:45
106	\N	6038 Madaline Ford\nPort Elsie, AL 99583	-70.532287999999994	18.862110999999999		2023-05-28 11:44:45
107	\N	70319 Denesik Manor\nBrekkehaven, DE 62135	153.719798	49.417203999999998		2023-05-28 11:44:45
108	\N	829 Stokes Knolls\nNorth Rae, UT 82727	-110.888429	-35.423309000000003		2023-05-28 11:44:45
109	\N	7376 Hoeger Island Apt. 384\nMorissettetown, NY 66380	168.40216899999999	-17.278169999999999		2023-05-28 11:45:00
110	\N	08265 Ankunding Field Apt. 748\nDeloresview, NM 84887-4492	-9.3615779999999997	49.976833999999997		2023-05-28 11:45:00
111	\N	436 Cormier Oval\nSouth Wardtown, OR 82789-7790	-100.212169	-64.174690999999996		2023-05-28 11:45:00
112	\N	3077 Amaya Pass\nNorth Joannyland, HI 44827	-124.533023	11.793412		2023-05-28 11:45:00
113	\N	0852 Melyssa Bridge\nParisianborough, SC 53557	28.848374	60.149842		2023-05-28 11:45:00
114	\N	84793 Gleason Crescent Suite 453\nClaudefurt, ND 60645	-160.62259599999999	-39.007246000000002		2023-05-28 11:45:00
115	\N	9148 Bernardo Route Suite 411\nMohammadland, AZ 26118-2863	147.58237500000001	-73.194428000000002		2023-05-28 11:45:00
116	\N	48126 Destany Mall Suite 542\nNorth Kirsten, MN 06423	-109.92832	-83.898431000000002		2023-05-28 11:45:00
117	\N	9938 Cremin Summit\nNew Jalonfurt, WI 13843	-47.413513999999999	41.665270999999997		2023-05-28 11:45:00
118	\N	7230 Bernita Courts Apt. 620\nPort Guadalupechester, PA 33640-1328	83.887844999999999	31.936463		2023-05-28 11:45:00
119	\N	0658 Hessel Tunnel\nSouth Kayla, UT 52491-3664	60.032972999999998	-32.450612		2023-05-28 11:46:15
120	\N	65939 Jones Lights Suite 378\nNorth Libby, NV 67183-0507	79.119754	-22.399042999999999		2023-05-28 11:46:15
121	\N	06227 Annabell Glens\nLloydtown, MS 79956-4042	-13.752321	86.042134000000004		2023-05-28 11:46:15
122	\N	19007 Fahey Mountain\nGottliebville, NV 37583	-155.664244	11.384259999999999		2023-05-28 11:46:15
123	\N	96208 Kamren Islands\nPort Ritamouth, HI 50799	-76.198026999999996	26.915937		2023-05-28 11:46:15
124	\N	51519 Anderson Knolls\nGayleton, PA 96647-0223	31.220136	-84.473477000000003		2023-05-28 11:46:15
125	\N	65300 Geovany Tunnel\nPort Max, OR 17019	95.225757000000002	15.425017		2023-05-28 11:46:15
126	\N	290 Clementina Lane\nWunschchester, IN 30091-6443	-13.240546999999999	-54.345284999999997		2023-05-28 11:46:15
127	\N	335 Jamal Canyon\nLake Ruthiefurt, LA 33167	-132.93402900000001	28.097283000000001		2023-05-28 11:46:15
128	\N	7626 Dudley Parkway\nGoodwinburgh, KS 86706	-94.304356999999996	86.801302000000007		2023-05-28 11:46:15
130	\N	8053 Swift Grove\nBinsshire, AK 17873	-48.040667999999997	-63.195954999999998		2023-05-28 11:48:04
131	\N	13860 Feil Extensions\nKautzerburgh, WA 21029	115.760481	64.841847999999999		2023-05-28 11:48:04
132	\N	9620 Elias River Apt. 799\nTurnerberg, AK 84748-3364	131.70791800000001	32.246003000000002		2023-05-28 11:48:04
133	\N	30350 Haskell Knolls Suite 656\nTarynland, ND 23965	-176.16050200000001	22.590319999999998		2023-05-28 11:48:04
134	\N	49846 Johnston Forks Suite 190\nMckaylaland, SD 74484	136.84464199999999	31.604334999999999		2023-05-28 11:48:04
135	\N	13848 Felipe Courts\nRosinafort, WV 61133	-98.260439000000005	-11.084864		2023-05-28 11:48:04
136	\N	59615 Terrill Crossroad Apt. 440\nDaughertymouth, FL 27964-3821	43.153469999999999	-79.048979000000003		2023-05-28 11:48:04
137	\N	41788 Altenwerth Loaf Suite 186\nLake Otilia, TX 25173	25.943646999999999	-80.652755999999997		2023-05-28 11:48:05
138	\N	230 Natasha Plaza Suite 624\nLake Savionhaven, WA 70287	-84.813642999999999	-78.580579		2023-05-28 11:48:05
139	\N	02140 Sister Hills\nNorth Emilianoburgh, OH 04028	2.963867	22.312401000000001		2023-05-28 11:48:05
141	\N	387 Filomena Gardens Suite 977\nPort Clydechester, RI 77806-7460	-91.721226999999999	-34.519610999999998		2023-05-28 11:54:54
142	\N	201 Oberbrunner Locks Suite 471\nBartolettiburgh, GA 33814-7349	-120.833304	-66.799031999999997		2023-05-28 11:54:54
143	\N	268 Boyle Brooks\nLake Yazmin, AK 26263-8130	95.076695999999998	63.807828000000001		2023-05-28 11:54:54
144	\N	521 Eleonore Crescent\nEast Malcolmbury, VA 53097	156.23002099999999	-16.003717999999999		2023-05-28 11:54:54
145	\N	646 Raul Meadows\nAnselville, AK 82329-8860	-167.689851	-9.7218049999999998		2023-05-28 11:54:54
146	\N	94088 Clifton Street Apt. 392\nWest Kurtland, NV 41408-0209	17.417297000000001	-2.7183039999999998		2023-05-28 11:54:54
147	\N	0079 Alvera Prairie\nPort Issacfurt, GA 51187	165.31209699999999	65.642752000000002		2023-05-28 11:54:54
148	\N	5142 Ericka Circle Apt. 043\nTayaland, WV 40385-5713	-7.7454520000000002	57.033518000000001		2023-05-28 11:54:54
149	\N	26116 Howe Pass Suite 197\nErdmanhaven, OK 32991-1054	-49.265770000000003	-64.057111000000006		2023-05-28 11:54:54
150	\N	7770 Champlin Meadows Apt. 094\nPort Bryana, TX 88756	169.70884000000001	82.772810000000007		2023-05-28 11:54:54
151	\N	758 Ebert Unions\nEast Generaltown, MA 65308	47.022224000000001	-77.630876000000001		2023-05-28 11:57:43
152	\N	623 Terry Union\nEast Noemieview, CT 32385	173.47090800000001	-28.086352999999999		2023-05-28 11:57:43
153	\N	084 Alysa Isle Apt. 465\nNorth Samir, IL 95756	-5.3581859999999999	-28.282988		2023-05-28 11:57:43
154	\N	850 Cronin Walk Suite 270\nNikolauschester, ND 44947	12.215576	-43.106797		2023-05-28 11:57:43
155	\N	503 Vandervort Union Suite 253\nLake Laurence, MT 45138-6387	-57.679487999999999	-9.8636440000000007		2023-05-28 11:57:43
156	\N	452 Daugherty Mission Suite 511\nNorth Shaniyahaven, CO 98758	-8.3618229999999993	24.922190000000001		2023-05-28 11:57:43
157	\N	00073 Maurice Fort Suite 876\nNorth Kevinstad, CA 05376-5008	123.573204	85.135968000000005		2023-05-28 11:57:43
158	\N	19847 Zena Viaduct Suite 316\nTrantowport, VT 18639-6511	107.328722	-81.079076999999998		2023-05-28 11:57:43
159	\N	293 Mohr Ferry Suite 644\nEast Cleve, IL 10502	-41.595753999999999	-35.101948		2023-05-28 11:57:43
160	\N	322 Dell Mount\nSouth Nikko, MT 55292-2060	74.885917000000006	-72.510749000000004		2023-05-28 11:57:43
161	\N	74796 Nova Knoll\nLake Blaise, NY 52583	6.607704	-11.808828999999999		2023-05-28 12:04:06
162	\N	775 McClure Cliff\nNorth Brandonmouth, MA 64286	127.452438	10.595465000000001		2023-05-28 12:04:06
163	\N	0946 Jaskolski Trail\nNew Caden, UT 71257	-29.216086000000001	-42.458891000000001		2023-05-28 12:04:06
164	\N	7523 Kautzer Creek\nEast Elisabethport, DC 28219-4140	120.225398	68.786856		2023-05-28 12:04:06
165	\N	7393 Boyer Prairie\nNew Hadley, TX 18764	-105.258916	70.869963999999996		2023-05-28 12:04:06
166	\N	0574 Myrtis Meadow\nMitchelltown, HI 03721-4119	-39.412669999999999	57.187655999999997		2023-05-28 12:04:06
167	\N	64852 Parker Club Suite 306\nPort Lilianeville, VT 32833	13.098110999999999	53.622790999999999		2023-05-28 12:04:06
168	\N	8047 Amber Corner\nLake Dusty, NV 05066	4.7142309999999998	-66.138057000000003		2023-05-28 12:04:06
169	\N	869 Tabitha Views Apt. 411\nDamarishaven, MI 04421	-36.031356000000002	-48.203532000000003		2023-05-28 12:04:06
170	\N	05567 Shaniya Extensions Apt. 182\nNew Lonny, CA 27576-1449	14.549908	58.693038999999999		2023-05-28 12:04:06
171	\N	0744 Garrick Trail Suite 725\nLake Brooke, TN 42024-9479	61.942332	-60.614632999999998		2023-05-28 12:14:09
172	\N	16714 Yesenia Orchard Suite 311\nRyleeside, PA 36044-4234	46.962567999999997	56.713777999999998		2023-05-28 12:14:09
173	\N	679 Antoinette Pines\nIsmaelport, TX 06357-1456	29.595852000000001	36.328971000000003		2023-05-28 12:14:09
174	\N	6778 Kuvalis Port\nWest Jennyfer, DE 97461	122.97904800000001	-15.792636999999999		2023-05-28 12:14:09
175	\N	19779 Rodriguez Circle\nBreanaborough, HI 38583-8344	10.730872	22.254099		2023-05-28 12:14:09
176	\N	38483 Zakary Cove\nSouth Reneestad, MI 61796-9109	-19.930188999999999	-74.44699		2023-05-28 12:14:09
177	\N	22463 Champlin Park\nWisozkburgh, MA 71019	41.699787999999998	-88.048952999999997		2023-05-28 12:14:09
178	\N	265 Haag Well Apt. 162\nPollichberg, OH 96911	8.1979089999999992	-53.486324000000003		2023-05-28 12:14:09
179	\N	2909 Jocelyn Trail Suite 677\nFriesenmouth, KS 81367-8328	-44.297192000000003	51.253898		2023-05-28 12:14:09
180	\N	8747 Leannon Port Suite 223\nKatlynmouth, PA 42141-1110	-25.918548999999999	52.076720000000002		2023-05-28 12:14:09
201	\N	93280 Aliya Rapids\nLake Lydafurt, IA 80503-5440	-8.4165379999999992	32.186715		2023-05-28 12:26:07
202	\N	096 Kohler Bypass Apt. 625\nMaudetown, MD 88371-3894	105.903379	-5.6797279999999999		2023-05-28 12:26:07
203	\N	554 Francis Crest Apt. 539\nBrigitteberg, NE 13212	145.43732399999999	22.177775		2023-05-28 12:26:07
204	\N	235 Haag River\nLarkinstad, MN 30815	-155.45164800000001	53.110765000000001		2023-05-28 12:26:07
205	\N	306 Hammes Keys\nTyreefurt, NE 82901-2421	-103.75013300000001	22.589144000000001		2023-05-28 12:26:07
206	\N	772 Trudie Village\nCummerataburgh, DE 78873	39.370412999999999	66.391921999999994		2023-05-28 12:26:07
207	\N	6133 Feest Village Suite 697\nLake Frankmouth, MS 13751-4602	153.59189599999999	-48.314298999999998		2023-05-28 12:26:07
208	\N	1197 Guy Station Suite 253\nFionaview, MN 38657	163.06	-19.984627		2023-05-28 12:26:07
209	\N	1613 Langosh Fords\nEast Dario, NM 95267-7123	52.082765000000002	-25.326392999999999		2023-05-28 12:26:07
210	\N	064 Considine Path Suite 014\nSouth Creola, ND 03693-6271	-98.430886999999998	-36.157850000000003		2023-05-28 12:26:07
211	\N	963 Rodriguez Light\nArnulfomouth, KS 54699-2946	-124.10372599999999	0.69340299999999999		2023-05-28 12:26:22
212	\N	24473 Fisher Creek Suite 249\nDarlenemouth, IL 53084	-106.484938	-53.659309999999998		2023-05-28 12:26:22
213	\N	5728 Stark Plains\nPort Makaylabury, NH 35200	-58.169992999999998	-42.746825999999999		2023-05-28 12:26:22
214	\N	83430 Madilyn Drive Apt. 527\nPort Hulda, NJ 01757-0271	-72.455659999999995	-41.634630999999999		2023-05-28 12:26:22
215	\N	54745 Gleichner Lodge\nAbbotttown, NH 35611-3909	59.697572000000001	88.227936		2023-05-28 12:26:22
216	\N	15428 Okuneva Island\nChaddmouth, NE 63616-6921	-50.589328999999999	-25.891801000000001		2023-05-28 12:26:22
217	\N	733 Isadore Streets Suite 716\nPort Alexie, OH 24170	74.274987999999993	50.840725999999997		2023-05-28 12:26:22
218	\N	3617 Bayer Harbors\nSouth Cornell, ND 47489-8425	150.48712800000001	64.954837999999995		2023-05-28 12:26:22
219	\N	0765 Chasity Points Suite 667\nCandidobury, WA 67912	29.692034	-54.903863999999999		2023-05-28 12:26:22
220	\N	0437 Dusty Prairie Suite 007\nGreenmouth, GA 48678	-26.847884000000001	-48.745587999999998		2023-05-28 12:26:22
1	\N	5561 Eichmann Inlet\nPort Adelia, MS 12265-8315	143.15703999999999	52.585517000000003		2023-05-28 12:42:29
2	\N	8952 Schiller Landing Suite 113\nMedhurstview, MA 93238	-102.386813	17.054656999999999		2023-05-28 12:42:29
3	\N	917 McDermott Lake Suite 533\nLake Alison, NE 50214	-70.764607999999996	-0.071815999999998006		2023-05-28 12:42:29
4	\N	735 Hills Row Suite 823\nEast Kirsten, MI 09959-2181	-170.41160099999999	8.3586589999999994		2023-05-28 12:42:29
5	\N	0055 Brenden Plain Suite 779\nCrooksville, GA 69650-6680	-158.714136	-68.169950999999998		2023-05-28 12:42:29
6	\N	13748 Bahringer Trail\nLakinport, NM 19327	67.401494999999997	-82.353741999999997		2023-05-28 12:42:29
7	\N	9953 Russel Skyway Suite 170\nGreenholtstad, KS 87017	-89.591120000000004	27.47438		2023-05-28 12:42:29
8	\N	6467 Marcella Mission\nCartwrightstad, GA 97735	24.449444	-83.622817999999995		2023-05-28 12:42:29
9	\N	0034 Kunze Light\nNorth Jackelineberg, MT 97530-9419	173.62169700000001	-38.682184999999997		2023-05-28 12:42:29
10	\N	09860 Romaine Fords Suite 823\nKautzerland, ID 06445	-133.61793	-54.002153		2023-05-28 12:42:29
11	\N	06747 Larson Gardens\nCartwrightton, NV 73374-9851	-37.440492999999996	10.158892		2023-05-28 12:46:06
12	\N	4644 Paolo Turnpike Apt. 003\nCeliaberg, NH 42533-7240	-14.342249000000001	67.081339		2023-05-28 12:46:06
13	\N	59336 Kamron Landing Apt. 766\nToneyberg, NE 18824-6218	-35.833041000000001	9.1697830000000007		2023-05-28 12:46:06
14	\N	65550 Lehner Street Suite 629\nSunnyburgh, RI 67328-4622	155.33446699999999	-27.891051999999998		2023-05-28 12:46:06
15	\N	536 Bernhard Causeway\nJuanaborough, PA 87259	99.144722999999999	-82.861228999999994		2023-05-28 12:46:06
16	\N	61747 Fritsch Isle\nLake Vernice, AR 98722	-41.102324000000003	-42.513648000000003		2023-05-28 12:46:06
17	\N	0527 Wallace Trail\nPort Alba, AZ 83511	21.690047	-38.422907000000002		2023-05-28 12:46:06
18	\N	54570 Kamryn Ridge Apt. 508\nWest Kirstin, NH 67340	160.903109	71.720733999999993		2023-05-28 12:46:06
19	\N	2802 Jaskolski Route\nDeondretown, AL 51158-2910	44.138838999999997	2.1639339999999998		2023-05-28 12:46:06
20	\N	18457 Hollis Row Suite 436\nPort Carlo, DE 86191	-43.590079000000003	-59.447941999999998		2023-05-28 12:46:06
21	\N	88310 Marlin Extensions\nNorth Lorna, WA 23999	-143.205153	-65.923880999999994		2023-05-28 12:46:45
22	\N	8690 Russel Circle Suite 470\nLake Lavernastad, KS 89681-1877	-102.119338	59.759984000000003		2023-05-28 12:46:45
23	\N	640 Weimann Groves\nMurphyberg, NE 38572-9822	-143.11794599999999	70.785201999999998		2023-05-28 12:46:45
24	\N	37759 Bernita Burgs Suite 634\nWest Vergiestad, OR 11913-6004	150.49821499999999	31.423134999999998		2023-05-28 12:46:45
25	\N	3153 Bernardo Field Suite 032\nEast Preston, AR 39416-4398	17.119620000000001	12.382452000000001		2023-05-28 12:46:45
26	\N	3338 Mack Stravenue Apt. 653\nRudyfurt, AK 06776	-147.04871199999999	-12.943123		2023-05-28 12:46:45
27	\N	8964 Borer Island Apt. 490\nSouth Garth, PA 20663-0908	-154.84952100000001	6.4810590000000001		2023-05-28 12:46:45
28	\N	942 Bayer Brook Apt. 137\nWest Randallshire, NC 22345-7658	88.143006999999997	-79.636950999999996		2023-05-28 12:46:45
29	\N	148 Bobbie Center Apt. 463\nSouth Chanelle, VT 71146	-66.722907000000006	-0.14067399999999999		2023-05-28 12:46:45
30	\N	65619 Preston Overpass\nNew Fernandoton, MO 62953-7316	-155.86966200000001	-74.427164000000005		2023-05-28 12:46:45
31	\N	Douala	9.7022999999999993	4.0505000000000004		2023-05-28 13:09:43
32	\N	Douala	9.7022999999999993	4.0505000000000004		2023-05-28 13:10:17
33	1	Douala	9.7022999999999993	4.0505000000000004	154.72.167.222	2023-05-28 15:52:47
34	1	Douala	9.7022999999999993	4.0505000000000004	154.72.167.222	2023-05-28 15:52:49
35	1	Douala	9.7022999999999993	4.0505000000000004	154.72.167.219	2023-05-28 15:57:47
36	1	Douala	9.7022999999999993	4.0505000000000004	154.72.167.219	2023-05-28 15:57:49
37	1	Douala	9.7022999999999993	4.0505000000000004	154.72.167.234	2023-05-28 17:55:01
38	1	Douala	9.7022999999999993	4.0505000000000004	154.72.167.234	2023-05-28 17:55:03
39	1	Douala	9.7022999999999993	4.0505000000000004	154.72.167.151	2023-05-28 19:51:56
40	1	Douala	9.7022999999999993	4.0505000000000004	154.72.167.151	2023-05-28 19:51:58
41	1	Douala	9.7022999999999993	4.0505000000000004	154.72.167.238	2023-05-30 19:52:27
42	1	Douala	9.7022999999999993	4.0505000000000004	154.72.167.238	2023-05-30 19:55:55
43	1	Douala	9.7022999999999993	4.0505000000000004	154.72.167.238	2023-05-30 20:06:36
44	1	Douala	9.7022999999999993	4.0505000000000004	154.72.167.238	2023-05-30 20:07:37
45	1	Douala	9.7022999999999993	4.0505000000000004	154.72.167.238	2023-05-30 20:07:39
46	1	Douala	9.7022999999999993	4.0505000000000004	154.72.167.238	2023-05-30 20:15:30
47	1	Douala	9.7022999999999993	4.0505000000000004	154.72.167.238	2023-05-30 20:15:34
48	1	Douala	9.7022999999999993	4.0505000000000004	154.72.167.238	2023-05-30 20:22:15
49	1	Douala	9.7022999999999993	4.0505000000000004	154.72.167.238	2023-05-30 20:22:17
50	1	Douala	9.7022999999999993	4.0505000000000004	154.72.167.238	2023-05-30 20:27:10
51	1	Douala	9.7022999999999993	4.0505000000000004	154.72.167.238	2023-05-30 20:27:13
52	1	Douala	9.7022999999999993	4.0505000000000004	154.72.167.238	2023-05-30 20:30:10
53	1	Douala	9.7022999999999993	4.0505000000000004	154.72.167.238	2023-05-30 20:30:12
54	1	Douala	9.7022999999999993	4.0505000000000004	154.72.167.238	2023-05-30 21:56:31
55	1	Douala	9.7022999999999993	4.0505000000000004	154.72.167.238	2023-05-30 21:56:32
56	1	Douala	9.7022999999999993	4.0505000000000004	154.72.167.238	2023-05-30 21:56:54
57	1	Douala	9.7022999999999993	4.0505000000000004	154.72.167.238	2023-05-30 21:56:55
68	1	Douala	9.7022999999999993	4.0505000000000004	154.72.167.238	2023-05-30 22:37:00
69	1	Douala	9.7022999999999993	4.0505000000000004	154.72.167.238	2023-05-30 23:03:02
70	1	Douala	9.7022999999999993	4.0505000000000004	154.72.167.238	2023-05-30 23:11:00
71	1	Douala	9.7022999999999993	4.0505000000000004	154.72.167.238	2023-05-30 23:11:01
72	1	Douala	9.7022999999999993	4.0505000000000004	154.72.167.238	2023-05-30 23:11:43
73	1	Douala	9.7022999999999993	4.0505000000000004	154.72.167.238	2023-05-30 23:21:59
74	1	Douala	9.7022999999999993	4.0505000000000004	154.72.167.238	2023-05-30 23:22:01
75	1	Douala	9.7022999999999993	4.0505000000000004	154.72.167.232	2023-05-31 06:10:06
76	1	Douala	9.7022999999999993	4.0505000000000004	154.72.167.232	2023-05-31 06:10:09
77	1	Douala	9.7022999999999993	4.0505000000000004	154.72.167.232	2023-05-31 06:17:54
78	1	Douala	9.7022999999999993	4.0505000000000004	154.72.167.232	2023-05-31 06:17:55
129	1	Douala	9.7022999999999993	4.0505000000000004	154.72.150.152	2023-06-03 20:44:03
140	1	Douala	9.7022999999999993	4.0505000000000004	154.72.167.219	2023-06-04 10:55:42
181	1	Douala	9.7022999999999993	4.0505000000000004	154.72.150.137	2023-06-20 19:04:53
182	1	Douala	9.7022999999999993	4.0505000000000004	154.72.150.137	2023-06-20 19:04:54
183	1	Yaound├®	11.5154	3.8660999999999999	154.72.167.203	2023-06-23 21:02:28
184	1	Yaound├®	11.5154	3.8660999999999999	154.72.167.203	2023-06-23 21:02:30
185	1	Yaound├®	11.5154	3.8660999999999999	154.72.167.203	2023-06-23 21:08:22
186	1	Yaound├®	11.5154	3.8660999999999999	154.72.167.203	2023-06-23 21:08:25
187	1	Yaound├®	11.5154	3.8660999999999999	154.72.167.203	2023-06-23 21:09:36
188	1	Yaound├®	11.5154	3.8660999999999999	154.72.167.203	2023-06-23 21:09:38
189	1	Yaound├®	11.5154	3.8660999999999999	154.72.167.203	2023-06-23 21:11:27
190	1	Yaound├®	11.5154	3.8660999999999999	154.72.167.203	2023-06-23 21:11:39
191	1	Yaound├®	11.5154	3.8660999999999999	154.72.167.203	2023-06-23 21:12:09
192	1	Yaound├®	11.5154	3.8660999999999999	154.72.167.203	2023-06-23 21:12:11
193	1	Douala	9.7022999999999993	4.0505000000000004	154.72.150.151	2023-06-28 10:14:21
194	1	Douala	9.7022999999999993	4.0505000000000004	154.72.150.151	2023-06-28 10:14:23
195	1	Douala	9.7022999999999993	4.0505000000000004	154.72.150.151	2023-06-28 10:20:12
196	1	Douala	9.7022999999999993	4.0505000000000004	154.72.150.151	2023-06-28 10:20:14
197	1	Douala	9.7022999999999993	4.0505000000000004	154.72.150.151	2023-06-28 11:15:04
198	1	Douala	9.7022999999999993	4.0505000000000004	154.72.150.224	2023-06-28 16:16:14
199	1	Douala	9.7022999999999993	4.0505000000000004	154.72.150.224	2023-06-28 16:16:15
200	1	Douala	9.7022999999999993	4.0505000000000004	154.72.150.199	2023-06-28 19:27:18
221	1	Douala	9.7022999999999993	4.0505000000000004	154.72.150.250	2023-06-28 21:28:28
222	1	Douala	9.7022999999999993	4.0505000000000004	154.72.150.250	2023-06-28 21:28:35
223	1	Douala	9.7022999999999993	4.0505000000000004	154.72.150.250	2023-06-28 21:30:32
224	1	Douala	9.7022999999999993	4.0505000000000004	154.72.150.250	2023-06-28 21:30:49
225	1	Douala	9.7022999999999993	4.0505000000000004	154.72.150.250	2023-06-28 21:34:59
226	1	Douala	9.7022999999999993	4.0505000000000004	154.72.150.250	2023-06-28 21:35:07
227	1	Douala	9.7022999999999993	4.0505000000000004	154.72.150.250	2023-06-28 21:37:10
228	1	Douala	9.7022999999999993	4.0505000000000004	154.72.150.250	2023-06-28 21:37:17
229	1	Douala	9.7022999999999993	4.0505000000000004	154.72.150.250	2023-06-28 22:12:19
230	1	Douala	9.7022999999999993	4.0505000000000004	154.72.150.164	2023-07-01 06:03:07
231	1	Douala	9.7022999999999993	4.0505000000000004	154.72.150.164	2023-07-01 06:03:10
232	1	Douala	9.7022999999999993	4.0505000000000004	154.72.150.164	2023-07-01 06:06:53
233	1	Douala	9.7022999999999993	4.0505000000000004	154.72.150.164	2023-07-01 06:06:54
234	1	Douala	9.7022999999999993	4.0505000000000004	154.72.150.140	2023-07-01 06:43:30
235	1	Douala	9.7022999999999993	4.0505000000000004	154.72.150.140	2023-07-01 06:51:58
236	1	Douala	9.7022999999999993	4.0505000000000004	154.72.150.140	2023-07-01 06:51:59
237	1	Douala	9.7022999999999993	4.0505000000000004	154.72.150.140	2023-07-01 07:46:07
238	1	Douala	9.7022999999999993	4.0505000000000004	154.72.150.140	2023-07-01 07:46:08
239	1	Douala	9.7022999999999993	4.0505000000000004	154.72.150.140	2023-07-01 07:56:06
240	1	Douala	9.7022999999999993	4.0505000000000004	154.72.150.140	2023-07-01 07:56:08
241	1	Douala	9.7022999999999993	4.0505000000000004	154.72.150.206	2023-07-01 09:03:08
242	1	Douala	9.7022999999999993	4.0505000000000004	154.72.150.206	2023-07-01 09:03:10
243	1	Douala	9.7022999999999993	4.0505000000000004	154.72.150.206	2023-07-01 09:08:52
244	1	Douala	9.7022999999999993	4.0505000000000004	154.72.150.206	2023-07-01 09:08:53
245	1	Douala	9.7022999999999993	4.0505000000000004	154.72.150.206	2023-07-01 09:44:39
246	1	Douala	9.7022999999999993	4.0505000000000004	154.72.150.206	2023-07-01 09:44:43
247	1	Douala	9.7022999999999993	4.0505000000000004	154.72.150.206	2023-07-01 09:59:12
248	1	Douala	9.7022999999999993	4.0505000000000004	154.72.150.206	2023-07-01 10:00:07
249	1	Douala	9.7022999999999993	4.0505000000000004	154.72.150.206	2023-07-01 10:04:15
250	1	Douala	9.7022999999999993	4.0505000000000004	154.72.150.206	2023-07-01 10:04:22
251	1	Douala	9.7022999999999993	4.0505000000000004	154.72.150.206	2023-07-01 10:04:33
252	1	Douala	9.7022999999999993	4.0505000000000004	154.72.150.206	2023-07-01 10:04:36
253	1	Douala	9.7022999999999993	4.0505000000000004	154.72.150.206	2023-07-01 10:06:08
254	1	Douala	9.7022999999999993	4.0505000000000004	154.72.150.206	2023-07-01 10:06:18
255	1	Douala	9.7022999999999993	4.0505000000000004	154.72.150.206	2023-07-01 10:06:37
256	1	Douala	9.7022999999999993	4.0505000000000004	154.72.150.206	2023-07-01 10:06:38
257	1	Douala	9.7022999999999993	4.0505000000000004	154.72.150.206	2023-07-01 10:48:51
258	1	Douala	9.7022999999999993	4.0505000000000004	154.72.150.206	2023-07-01 10:49:25
259	1	Douala	9.7022999999999993	4.0505000000000004	154.72.150.206	2023-07-01 10:49:53
260	1	Douala	9.7022999999999993	4.0505000000000004	154.72.150.206	2023-07-01 14:42:05
261	1	Douala	9.7022999999999993	4.0505000000000004	154.72.150.206	2023-07-01 14:44:30
262	1	Douala	9.7022999999999993	4.0505000000000004	154.72.150.206	2023-07-01 14:45:39
263	1	Douala	9.7022999999999993	4.0505000000000004	154.72.150.206	2023-07-01 14:45:40
264	1	Douala	9.7022999999999993	4.0505000000000004	154.72.150.206	2023-07-01 15:04:43
265	1	Douala	9.7022999999999993	4.0505000000000004	154.72.150.206	2023-07-01 15:04:48
266	1	Douala	9.7022999999999993	4.0505000000000004	154.72.150.206	2023-07-01 16:06:07
267	1	Douala	9.7022999999999993	4.0505000000000004	154.72.150.206	2023-07-01 16:06:46
268	1	Douala	9.7022999999999993	4.0505000000000004	154.72.150.206	2023-07-01 16:08:06
269	1	Douala	9.7022999999999993	4.0505000000000004	154.72.150.206	2023-07-01 16:11:07
270	1	Yaound├®	11.5154	3.8660999999999999	154.72.167.234	2023-07-01 20:53:35
271	1	Yaound├®	11.5154	3.8660999999999999	154.72.167.234	2023-07-01 20:54:29
272	1	Yaound├®	11.5154	3.8660999999999999	154.72.167.234	2023-07-01 20:54:54
273	1	Yaound├®	11.5154	3.8660999999999999	154.72.167.234	2023-07-01 20:54:55
274	1	Yaound├®	11.5154	3.8660999999999999	154.72.167.234	2023-07-01 21:00:35
275	1	Yaound├®	11.5154	3.8660999999999999	154.72.150.208	2023-07-05 10:55:12
276	1	Yaound├®	11.5154	3.8660999999999999	154.72.150.208	2023-07-05 10:55:38
277	1	Yaound├®	11.5154	3.8660999999999999	154.72.150.208	2023-07-05 10:55:40
\.


--
-- Name: localisation_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('localisation_id_seq', 277, true);


--
-- Data for Name: message_communication; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY message_communication (id, communication_id, initiateur_id, emetteur, message, date_envoi) FROM stdin;
1	1	1	t	produitvlLQu	2023-06-28 19:11:14
2	1	1	t	0000	2023-06-28 19:14:13
3	1	1	t	0000	2023-06-28 19:22:16
4	1	1	t	0000	2023-06-28 19:24:54
5	1	1	t	0000	2023-06-28 19:26:30
6	1	1	t	yo	2023-06-28 20:23:44
7	1	2	f	0000	2023-06-28 20:24:37
8	1	2	f	0000	2023-06-28 20:26:49
9	1	2	f	0000	2023-06-28 20:28:19
10	1	2	f	set	2023-06-28 20:29:15
11	1	2	f	se00t	2023-06-28 20:30:34
12	1	2	f	erre	2023-06-28 20:31:14
13	1	1	t	yes	2023-06-28 20:32:01
14	1	1	t	00	2023-06-28 20:38:49
15	1	2	f	fdf	2023-06-28 21:13:32
16	1	1	t	dd	2023-06-28 21:14:12
17	1	2	f	fdf	2023-06-28 21:14:23
18	1	2	f	fdf	2023-06-28 21:14:45
19	1	2	f	fdf	2023-06-28 21:15:15
20	1	2	f	fdf	2023-06-28 21:15:37
21	1	2	f	fdf	2023-06-28 21:16:37
22	1	2	f	fdf	2023-06-28 21:17:02
23	1	1	t	01	2023-06-28 21:17:28
24	1	2	f	fdf	2023-06-28 21:18:27
25	1	2	f	newwe	2023-06-28 21:21:57
26	1	1	t	fd	2023-06-28 21:24:25
27	1	2	f	newwe	2023-06-28 21:25:15
28	1	1	t	yre	2023-06-28 21:54:57
29	1	2	f	fggff	2023-06-28 21:56:09
30	1	2	f	fggff	2023-06-28 22:07:02
31	1	2	f	54545	2023-06-28 22:07:39
32	1	2	f	54545	2023-06-28 22:07:57
33	1	2	f	nrer	2023-06-28 22:10:30
34	1	2	f	nrer	2023-06-28 22:12:35
35	1	2	f	nrer	2023-06-28 22:16:25
36	1	2	f	nrer	2023-06-28 22:18:13
37	1	2	f	nrer	2023-06-28 22:19:37
38	1	2	f	nrer	2023-06-28 22:19:47
39	1	2	f	nrer	2023-06-28 22:21:00
40	1	2	f	nrer	2023-06-28 22:21:12
41	1	2	f	nrer	2023-06-28 22:21:34
42	1	2	f	nrer	2023-06-28 22:22:07
43	1	2	f	nrer	2023-06-28 22:22:26
44	1	2	f	FDDFnrer	2023-06-28 22:22:39
45	1	1	t	02	2023-07-01 06:03:33
46	1	1	t	tesy	2023-07-01 08:01:51
47	1	2	f	FDDFnrer	2023-07-01 08:02:00
48	1	2	f	mouafo	2023-07-01 08:02:25
49	1	2	f	mouafo randoll	2023-07-01 08:02:45
50	1	2	f	mouafo tstl	2023-07-01 08:49:49
51	1	1	t	bro	2023-07-01 16:10:53
52	1	1	t	dd	2023-07-09 16:58:31
53	1	1	t	new	2023-07-09 17:29:01
54	1	1	t	new	2023-07-09 17:29:36
55	1	1	t	aer	2023-07-09 17:46:06
56	1	1	t	Goood	2023-07-09 18:05:34
57	1	1	t	passs	2023-07-12 20:11:27
58	1	1	t	ggg	2023-07-12 20:12:22
\.


--
-- Name: message_communication_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('message_communication_id_seq', 58, true);


--
-- Data for Name: message_negociation; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY message_negociation (id, negociation_id, emetteur, message, date_envoi, initiateur_id) FROM stdin;
1	30	t	J'aimerais negocier le prix de ce produit : Goyette and Sons	2023-06-03 01:04:35	\N
2	30	f	comment norrrr bro	2023-06-03 01:05:22	\N
3	30	t	werr	2023-06-03 01:08:14	\N
4	30	t	werr	2023-06-03 01:08:15	\N
5	30	t	jerg	2023-06-03 01:08:23	\N
6	30	t	je vaidj	2023-06-03 01:08:28	\N
7	30	t	je vaidj	2023-06-03 01:08:29	\N
8	31	t	J'aimerais negocier le prix de ce produit : Goyette and Sons	2023-06-03 01:08:46	\N
9	32	t	J'aimerais negocier le prix de ce produit : Goyette and Sons	2023-06-03 15:15:31	\N
10	33	t	J'aimerais negocier le prix de ce produit : Goyette and Sons	2023-06-03 15:16:13	\N
12	33	t	­ƒÿâ	2023-06-03 15:21:32	\N
14	34	t	J'aimerais negocier le prix de ce produit : Goyette and Sons	2023-06-03 15:33:28	\N
15	35	t	J'aimerais negocier le prix de ce produit : Goyette and Sons	2023-06-03 15:38:13	\N
16	36	t	J'aimerais negocier le prix de ce produit : Goyette and Sons	2023-06-03 15:38:47	\N
17	37	t	J'aimerais negocier le prix de ce produit : Goyette and Sons	2023-06-03 15:40:23	\N
18	38	t	J'aimerais negocier le prix de ce produit : Goyette and Sons	2023-06-03 15:40:45	\N
19	39	t	J'aimerais negocier le prix de ce produit : Goyette and Sons	2023-06-03 15:45:21	\N
21	38	t	raf	2023-06-03 20:47:27	\N
23	38	t	yo	2023-06-03 20:53:09	\N
11	33	f	ok	2023-06-03 15:17:22	\N
13	33	f	hi	2023-06-03 15:22:23	\N
22	38	f	comment tu vas	2023-06-03 20:47:49	\N
20	37	t	yoGGF GFFG GFFG545	2023-06-03 20:45:50	\N
24	38	f	ch "J'aimerais negocier le prix de ce produit : Goyette and Sons" "J'aimerais negocier le prix de ce produit : Goyette and Sons" "J'aimerais negocier le prix de ce produit : Goyette and Sons"	2023-06-03 20:53:26	\N
26	38	f	ch "J'aimerais negocier le prix de ce produit : Goyette and Sons" "J'aimerais negocier le prix de ce produit : Goyette and Sons" "J'aimerais negocier le prix de ce produit : Goyette and Sons"	2023-06-03 20:53:26	\N
25	38	t	ch "J'aimerais negocier le prix de ce produit : Goyette and Sons" "J'aimerais negocier le prix de ce produit : Goyette and Sons" "J'aimerais negocier le prix de ce produit : Goyette and Sons"	2023-06-03 20:53:26	\N
27	38	t	00000	2023-06-03 22:28:29	\N
28	40	t	J'aimerais negocier le prix de ce produit : Hammes, Mraz and O'Conner	2023-06-03 22:51:37	\N
29	40	t	Yowa	2023-06-03 22:51:51	\N
30	40	t	Abo	2023-06-03 22:52:00	\N
31	41	t	J'aimerais negocier le prix de ce produit : Carroll PLC	2023-06-03 22:52:55	\N
32	42	t	J'aimerais negocier le prix de ce produit : Kunze-Gibson	2023-06-03 22:54:44	\N
33	43	t	J'aimerais negocier le prix de ce produit : Medhurst-Baumbach	2023-06-03 22:56:18	\N
34	44	t	J'aimerais negocier le prix de ce produit : Robel-Rowe	2023-06-03 22:56:33	\N
35	33	t	­ƒñ¡	2023-06-04 08:58:11	\N
36	33	t	­ƒñ¡	2023-06-04 08:58:12	\N
37	37	t	yeae	2023-06-04 09:58:33	\N
38	38	t	tst	2023-06-28 10:23:20	\N
39	44	t	hh	2023-06-28 15:54:41	\N
\.


--
-- Name: message_negociation_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('message_negociation_id_seq', 39, true);


--
-- Data for Name: messenger_messages; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY messenger_messages (id, body, headers, queue_name, created_at, available_at, delivered_at) FROM stdin;
\.


--
-- Name: messenger_messages_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('messenger_messages_id_seq', 1, false);


--
-- Data for Name: mode_paiement; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY mode_paiement (id, libelle) FROM stdin;
1	Orange Money
2	Momo
3	Carte
4	free coin
\.


--
-- Name: mode_paiement_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('mode_paiement_id_seq', 1, false);


--
-- Data for Name: negociation_produit; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY negociation_produit (id, produit_id, code_negociation, prix_negocie, date_created, initiateur_id) FROM stdin;
3	19	cnjyuNsyik	\N	2023-06-02 23:39:13	1
4	19	cnbKnTLQeG	\N	2023-06-02 23:40:04	1
5	19	cn5lEN4H9Q	\N	2023-06-02 23:40:22	1
6	19	cnmlTzXzVd	\N	2023-06-02 23:40:45	1
7	19	cn2gVFiFvX	\N	2023-06-02 23:41:16	1
8	19	cnSEKL9JNU	\N	2023-06-02 23:41:32	1
9	19	cnMsIkyOXB	\N	2023-06-02 23:41:59	1
10	19	cnhivTxMW2	\N	2023-06-02 23:42:20	1
11	19	cnPm2Wdifg	\N	2023-06-02 23:42:38	1
12	19	cnC8EThyxg	\N	2023-06-02 23:43:00	1
13	19	cntP7es4fb	\N	2023-06-02 23:43:23	1
14	19	cnuFx0inM9	\N	2023-06-02 23:43:40	1
15	19	cngRvKa6iJ	\N	2023-06-02 23:44:06	1
16	19	cn6aRaYeCm	\N	2023-06-02 23:55:15	1
17	19	cnNfbqc8i1	\N	2023-06-02 23:56:44	1
18	19	cnKU7EhNGp	\N	2023-06-03 00:00:11	1
19	19	cnUWCb0CnL	\N	2023-06-03 00:02:12	2
20	19	cn4dRtjEjM	\N	2023-06-03 00:04:50	2
22	19	cnE8ApzWbU	\N	2023-06-03 00:08:21	3
21	19	cnTAf5jwmz	\N	2023-06-03 00:05:26	1
23	19	cnVofR5fcs	\N	2023-06-03 00:10:37	3
25	19	cnhoOgSTUu	\N	2023-06-03 00:25:10	1
28	19	cnL5VAVBkp	\N	2023-06-03 00:27:47	1
26	19	cn0mnZZKen	\N	2023-06-03 00:25:57	1
29	19	cnzTbxqiUW	\N	2023-06-03 00:39:36	1
30	19	cnXjKeHWot	\N	2023-06-03 01:04:35	1
31	19	cnKjeN9Ahj	\N	2023-06-03 01:08:46	1
43	13	cnRx3HIbxa	\N	2023-06-03 22:56:18	1
42	5	cnAqp6kpKy	\N	2023-06-03 22:54:44	1
41	4	cn6ff741Hi	\N	2023-06-03 22:52:55	1
40	1	cnrKvDIERr	\N	2023-06-03 22:51:37	3
38	19	cnS6FAaIFh	\N	2023-06-03 15:40:45	3
37	19	cnextRnX3s	\N	2023-06-03 15:40:23	1
35	19	cnpabZMgCa	\N	2023-06-03 15:38:13	3
34	19	cnw62n6oeY	\N	2023-06-03 15:33:28	3
33	19	cn1xI3UAFq	\N	2023-06-03 15:16:13	3
32	19	cnYDdcFlaA	\N	2023-06-03 15:15:30	3
27	19	cn94JQRSYU	10	2023-06-03 00:26:51	1
36	19	cnM56HrwYD	01	2023-06-03 15:38:47	3
39	19	cn1RDIdfYE	10	2023-06-03 15:45:21	1
24	19	cnWBi8YnxJ	10	2023-06-03 00:20:08	1
44	30	cnxOANSFvp	1000	2023-06-03 22:56:33	1
\.


--
-- Name: negociation_produit_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('negociation_produit_id_seq', 44, true);


--
-- Data for Name: notation_boutique; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY notation_boutique (id, client_id, boutique_id, note, date_created) FROM stdin;
1	2	11	3	2023-06-04
\.


--
-- Name: notation_boutique_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('notation_boutique_id_seq', 1, true);


--
-- Data for Name: notification; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY notification (id, user_id, title, description, date_created) FROM stdin;
1	1	dd	dd	2023-07-08 18:02:22
2	1	new	Adddddddd	2023-07-08 18:04:43
3	1	test	ggfg	2023-07-08 18:05:47
4	1	promotion	Nouvelle promotion	2023-07-08 18:06:08
\.


--
-- Name: notification_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('notification_id_seq', 4, true);


--
-- Data for Name: panier; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY panier (id, user_id, date_created, code_panier, nom_client, prenom_client, phone_client) FROM stdin;
1	\N	2023-05-28	comIkFLV	mouf 		690863838
2	\N	2023-05-28	combVhZT	mouf 		690863838
6	\N	2023-05-31	com4X7ZG	admin		690863838
7	\N	2023-05-31	com2bLpi	admin		690863838
8	\N	2023-05-31	como05JB	admin		690863838
9	\N	2023-05-31	comRF2B3	admin		690863838
10	\N	2023-05-31	comeOjZY	admin		690863838
11	\N	2023-05-31	comtrvWR	admin		690863838
12	\N	2023-05-31	comDonof	admin		690863838
13	\N	2023-05-31	com3gy0i	admin		690863838
14	\N	2023-05-31	comzxWAE	admin		690863838
15	\N	2023-05-31	comIanDQ	admin		690863838
16	\N	2023-05-31	comgbdGw	admin		690863838
17	\N	2023-05-31	com7ymdU	admin		690863838
18	\N	2023-05-31	comUw9yw	admin		690863838
19	\N	2023-05-31	comg6plb	admin		690863838
20	\N	2023-05-31	com5qxmk	admin		690863838
21	\N	2023-05-31	com4Oqqy	admin		690863838
22	\N	2023-05-31	comCY9no	admin		690863838
23	\N	2023-05-31	come437d	admin		690863838
27	\N	2023-07-01	comMhYWy	admin		690863838
28	\N	2023-07-01	comXqbUO	admin		690863838
31	\N	2023-07-05	com7KmKL	admin		690863838
\.


--
-- Name: panier_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('panier_id_seq', 31, true);


--
-- Data for Name: point_livraison; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY point_livraison (id, libelle, ville, quartier, image, status) FROM stdin;
1	Waelchi, Kling and Kuhlman	Port Marquise	66743 Asia Alley\nNorth Claudiemouth, NM 62448	\N	t
2	Stiedemann Ltd	Bergemouth	8487 Kolby Fork Suite 201\nPort Karsonland, OR 58862	\N	t
3	Aufderhar Ltd	Goodwinborough	52133 Elissa Dam Suite 016\nWest Deionfort, SD 86998	\N	t
4	Padberg-Auer	South Tesston	8337 Jacobson Canyon Suite 030\nLake Stan, GA 40856-3057	\N	t
5	Mertz, Howe and Mayert	Fadelbury	102 Amari Expressway\nDeronmouth, WI 53267-0269	\N	t
6	Smith, Rogahn and Cummings	Mitchellmouth	4620 Jakubowski Crossing\nProsaccoshire, OK 53788	\N	t
7	Harvey PLC	Lake Jordiborough	83260 O'Connell Plain Apt. 403\nLake Carminechester, ND 93312	\N	t
8	Gleichner Ltd	Lake Eloisa	90515 Blanda Streets Apt. 330\nLake Kaelyn, MA 06325-3721	\N	t
9	Mills, Olson and Blanda	Croninbury	37527 Cremin Rapids\nLake Betsy, NV 53706	\N	t
10	Wunsch-Reichel	Boyerfurt	21270 Dach Plains Suite 915\nSouth Candiceborough, UT 76678	\N	t
11	Satterfield, Renner and Kiehn	Jaylonbury	51165 Sadie Center Suite 145\nGissellebury, MA 70283	\N	t
12	Stehr Inc	North Joshuahfurt	89961 Ardith Cove Apt. 044\nKuvalishaven, WV 75281-9322	\N	t
13	Gibson-Stoltenberg	West Stellamouth	5197 Rocky Harbor\nWisozkport, MT 40094	\N	t
14	Gislason, Wolf and Lakin	West Brooksburgh	47432 Pfannerstill Fall Suite 875\nErnsertown, WV 13541	\N	t
15	Considine Ltd	Pollichville	0747 Schaden Rapids Suite 456\nSouth Janiya, TN 27446	\N	t
16	Runolfsson-Bartell	Labadieview	5970 Dawn Burg\nHillltown, CO 89175	\N	t
17	Mayer-Larson	Port Donnastad	429 Bailey Hills Suite 198\nMcGlynnstad, SC 26849	\N	t
18	Bernier-VonRueden	Angelinaton	220 Joy Neck Suite 024\nMetzfort, MT 23780-1129	\N	t
19	Hane, Ruecker and Harris	South Orie	634 Stokes Drive\nSkilestown, FL 07881	\N	t
20	Kuhlman-Harber	Bauchmouth	096 Willms Mission\nSelinaview, MO 43593-2258	\N	t
21	O'Hara and Sons	Port Xander	557 Alexzander Road Suite 820\nEast Todberg, MO 46603	\N	t
22	Glover, Hayes and Kemmer	Schulistton	92422 Torp Lock\nNorth Willyland, OR 43980-6295	\N	t
23	Ratke, Brekke and Brown	Christopherville	43419 Terry Circle Suite 926\nEast Shyann, ND 50558	\N	t
24	Erdman-Okuneva	Lake Armandside	12186 Breitenberg Rest\nWest Tarynstad, OH 11497-0721	\N	t
25	Dooley-Zieme	McDermottchester	89286 Yundt Shores\nPort Henrietteshire, OR 85490	\N	t
26	Schulist Ltd	Runolfsdottirhaven	404 Leannon Route\nMorarberg, LA 61086	\N	t
27	Simonis-Mosciski	Lake Virginiahaven	3965 Herzog Place\nDavidstad, DE 65013-3811	\N	t
28	Beier-Aufderhar	Gibsonbury	88143 Stark Keys\nLake Bertram, LA 40114	\N	t
29	Johnston-Mertz	Deronshire	1177 Lina Isle Suite 453\nNew Oceaneport, OR 08322-7146	\N	t
30	Pacocha PLC	Melissaton	483 Dorian Squares Apt. 122\nSouth Darbyport, VA 32321	\N	t
31	Rempel, Dach and Brakus	North Ebbabury	345 Verda Cove\nMayerchester, TN 18123	\N	t
32	Kozey-Hauck	Lake Delberthaven	2538 Hauck Points\nNorth Alexander, OH 07551-9549	\N	t
33	Ullrich and Sons	Port Fabian	5576 Hyatt Fork\nPort Roycefort, CA 59558	\N	t
34	Zboncak Ltd	Funkshire	030 Hansen Creek\nDickifort, NE 82122	\N	t
35	Stroman-Kuhn	Hilllbury	59271 Monahan Circles Apt. 059\nLake Verniceport, NJ 72309	\N	t
36	Abshire-Strosin	New Maynard	3738 Madaline Meadows\nAlyceshire, MT 75968-9162	\N	t
37	Schimmel Inc	Cronahaven	3178 Von Manor Apt. 837\nMelbaport, OH 37747-1687	\N	t
38	Casper-Von	Roseborough	31310 Parisian Track\nBrittanymouth, TN 37225	\N	t
39	Dietrich LLC	Purdyburgh	208 Bennett Route\nSchadenton, CT 83672	\N	t
40	Gulgowski, Goldner and Spinka	Heavenchester	89245 Smitham Rue Apt. 519\nNolaview, MN 70295-9091	\N	t
41	Gutkowski-Ward	Danielbury	03923 Tamia Vista\nHyatthaven, TN 84283-7642	\N	t
42	Kuhic, Bauch and Brown	Langtown	6663 Hoeger Isle\nConroyshire, KS 11147	\N	t
43	Huels Group	West Krystalville	60723 Tromp Vista\nJadamouth, CA 70226	\N	t
44	Satterfield Inc	Madisenmouth	153 Purdy Rapids Suite 736\nGwenfurt, TX 67206	\N	t
45	Crist, Reinger and Wehner	New Leda	405 Heathcote Lodge\nNew Marisa, NC 83610-8661	\N	t
46	Welch-Treutel	Willmsfort	79104 Haag Dam Suite 047\nKerlukeside, KY 89599-7861	\N	t
47	Sipes, Lemke and Dickens	Bartholomeside	137 Shanel Corner\nSouth Bradfordbury, ME 73987	\N	t
48	Schinner-Franecki	South Tatyanamouth	637 Maggio Point Suite 449\nNorth Colin, KS 40643	\N	t
49	Schaden, Quigley and Davis	Rubytown	443 Maxine Island Apt. 061\nDelaneymouth, CA 74250-1345	\N	t
50	Nienow, Reinger and Farrell	Johanchester	46586 Fay Ranch Apt. 406\nPort Lincolnshire, NE 74471-1479	\N	t
\.


--
-- Name: point_livraison_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('point_livraison_id_seq', 50, true);


--
-- Data for Name: produit; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY produit (id, category_id, boutique_id, titre, description, date_created, prix_unitaire, quantite, status, code_produit, taille, negociable) FROM stdin;
25	\N	15	Sanford-Parisian	 Irure elit Lorem incididunt enim pariatur exercitation deserunt sunt consequat quis nisi veniam do. Adipisicing voluptate occaecat id dolore duis incididunt eu occaecat tempor Lorem adipisicing. Sunt officia elit ex anim consectetur\n             proident occaecat sint amet minim et. Sit quis consequat do deserunt sunt. Sunt aliquip esse id aliqua esse esse commodo excepteur ea aliqua labore quis cillum.	2023-05-28	3310	10	t	produitqzZhJ	16	f
43	\N	15	Blick Inc	 Irure elit Lorem incididunt enim pariatur exercitation deserunt sunt consequat quis nisi veniam do. Adipisicing voluptate occaecat id dolore duis incididunt eu occaecat tempor Lorem adipisicing. Sunt officia elit ex anim consectetur\n             proident occaecat sint amet minim et. Sit quis consequat do deserunt sunt. Sunt aliquip esse id aliqua esse esse commodo excepteur ea aliqua labore quis cillum.	2023-05-28	4450	6	t	produitmt5qO	4	f
81	\N	11	Green and Sons	 Irure elit Lorem incididunt enim pariatur exercitation deserunt sunt consequat quis nisi veniam do. Adipisicing voluptate occaecat id dolore duis incididunt eu occaecat tempor Lorem adipisicing. Sunt officia elit ex anim consectetur\nproident occaecat sint amet minim et. Sit quis consequat do deserunt sunt. Sunt aliquip esse id aliqua esse esse commodo excepteur ea aliqua labore quis cillum.	2023-05-28	8767	19	t	produitwMnYc	13	t
1	\N	20	Hammes, Mraz and O'Conner	 Irure elit Lorem incididunt enim pariatur exercitation deserunt sunt consequat quis nisi veniam do. Adipisicing voluptate occaecat id dolore duis incididunt eu occaecat tempor Lorem adipisicing. Sunt officia elit ex anim consectetur\n             proident occaecat sint amet minim et. Sit quis consequat do deserunt sunt. Sunt aliquip esse id aliqua esse esse commodo excepteur ea aliqua labore quis cillum.	2023-05-28	8370	20	t	produitvlLQu	17	t
2	\N	17	Metz, Bogisich and Sawayn	 Irure elit Lorem incididunt enim pariatur exercitation deserunt sunt consequat quis nisi veniam do. Adipisicing voluptate occaecat id dolore duis incididunt eu occaecat tempor Lorem adipisicing. Sunt officia elit ex anim consectetur\n             proident occaecat sint amet minim et. Sit quis consequat do deserunt sunt. Sunt aliquip esse id aliqua esse esse commodo excepteur ea aliqua labore quis cillum.	2023-05-28	2450	9	t	produitPnSKg	2	t
4	\N	18	Carroll PLC	 Irure elit Lorem incididunt enim pariatur exercitation deserunt sunt consequat quis nisi veniam do. Adipisicing voluptate occaecat id dolore duis incididunt eu occaecat tempor Lorem adipisicing. Sunt officia elit ex anim consectetur\n             proident occaecat sint amet minim et. Sit quis consequat do deserunt sunt. Sunt aliquip esse id aliqua esse esse commodo excepteur ea aliqua labore quis cillum.	2023-05-28	7350	17	t	produitXAvkn	9	t
5	\N	14	Kunze-Gibson	 Irure elit Lorem incididunt enim pariatur exercitation deserunt sunt consequat quis nisi veniam do. Adipisicing voluptate occaecat id dolore duis incididunt eu occaecat tempor Lorem adipisicing. Sunt officia elit ex anim consectetur\n             proident occaecat sint amet minim et. Sit quis consequat do deserunt sunt. Sunt aliquip esse id aliqua esse esse commodo excepteur ea aliqua labore quis cillum.	2023-05-28	5390	6	t	produitTs8bC	15	t
6	\N	17	Kuhic-Schamberger	 Irure elit Lorem incididunt enim pariatur exercitation deserunt sunt consequat quis nisi veniam do. Adipisicing voluptate occaecat id dolore duis incididunt eu occaecat tempor Lorem adipisicing. Sunt officia elit ex anim consectetur\n             proident occaecat sint amet minim et. Sit quis consequat do deserunt sunt. Sunt aliquip esse id aliqua esse esse commodo excepteur ea aliqua labore quis cillum.	2023-05-28	9350	14	t	produitC11I7	4	t
7	\N	16	Adams, Christiansen and Von	 Irure elit Lorem incididunt enim pariatur exercitation deserunt sunt consequat quis nisi veniam do. Adipisicing voluptate occaecat id dolore duis incididunt eu occaecat tempor Lorem adipisicing. Sunt officia elit ex anim consectetur\n             proident occaecat sint amet minim et. Sit quis consequat do deserunt sunt. Sunt aliquip esse id aliqua esse esse commodo excepteur ea aliqua labore quis cillum.	2023-05-28	3270	7	t	produitC7EtP	3	t
9	\N	17	Waelchi Ltd	 Irure elit Lorem incididunt enim pariatur exercitation deserunt sunt consequat quis nisi veniam do. Adipisicing voluptate occaecat id dolore duis incididunt eu occaecat tempor Lorem adipisicing. Sunt officia elit ex anim consectetur\n             proident occaecat sint amet minim et. Sit quis consequat do deserunt sunt. Sunt aliquip esse id aliqua esse esse commodo excepteur ea aliqua labore quis cillum.	2023-05-28	3330	19	t	produitI4ivl	19	t
8	\N	20	Welch, Nitzsche and Tromp	 Irure elit Lorem incididunt enim pariatur exercitation deserunt sunt consequat quis nisi veniam do. Adipisicing voluptate occaecat id dolore duis incididunt eu occaecat tempor Lorem adipisicing. Sunt officia elit ex anim consectetur\n             proident occaecat sint amet minim et. Sit quis consequat do deserunt sunt. Sunt aliquip esse id aliqua esse esse commodo excepteur ea aliqua labore quis cillum.	2023-05-28	3450	5	t	produit2hXx1	10	f
3	\N	16	Collier-Ernser	 Irure elit Lorem incididunt enim pariatur exercitation deserunt sunt consequat quis nisi veniam do. Adipisicing voluptate occaecat id dolore duis incididunt eu occaecat tempor Lorem adipisicing. Sunt officia elit ex anim consectetur\n             proident occaecat sint amet minim et. Sit quis consequat do deserunt sunt. Sunt aliquip esse id aliqua esse esse commodo excepteur ea aliqua labore quis cillum.	2023-05-28	10370	7	t	produit4o7Qv	16	f
10	\N	16	Lowe, Auer and Pfeffer	 Irure elit Lorem incididunt enim pariatur exercitation deserunt sunt consequat quis nisi veniam do. Adipisicing voluptate occaecat id dolore duis incididunt eu occaecat tempor Lorem adipisicing. Sunt officia elit ex anim consectetur\n             proident occaecat sint amet minim et. Sit quis consequat do deserunt sunt. Sunt aliquip esse id aliqua esse esse commodo excepteur ea aliqua labore quis cillum.	2023-05-28	4270	11	t	produitAQGs9	7	t
11	\N	11	Hyatt Ltd	 Irure elit Lorem incididunt enim pariatur exercitation deserunt sunt consequat quis nisi veniam do. Adipisicing voluptate occaecat id dolore duis incididunt eu occaecat tempor Lorem adipisicing. Sunt officia elit ex anim consectetur\n             proident occaecat sint amet minim et. Sit quis consequat do deserunt sunt. Sunt aliquip esse id aliqua esse esse commodo excepteur ea aliqua labore quis cillum.	2023-05-28	4430	11	t	produitGfVK3	8	t
12	\N	20	Padberg Ltd	 Irure elit Lorem incididunt enim pariatur exercitation deserunt sunt consequat quis nisi veniam do. Adipisicing voluptate occaecat id dolore duis incididunt eu occaecat tempor Lorem adipisicing. Sunt officia elit ex anim consectetur\n             proident occaecat sint amet minim et. Sit quis consequat do deserunt sunt. Sunt aliquip esse id aliqua esse esse commodo excepteur ea aliqua labore quis cillum.	2023-05-28	6390	8	t	produitkrwAU	14	t
22	\N	12	Kling-Murray	 Irure elit Lorem incididunt enim pariatur exercitation deserunt sunt consequat quis nisi veniam do. Adipisicing voluptate occaecat id dolore duis incididunt eu occaecat tempor Lorem adipisicing. Sunt officia elit ex anim consectetur\n             proident occaecat sint amet minim et. Sit quis consequat do deserunt sunt. Sunt aliquip esse id aliqua esse esse commodo excepteur ea aliqua labore quis cillum.	2023-05-28	1290	12	t	produit02BdZ	20	f
14	\N	15	Ortiz-Monahan	 Irure elit Lorem incididunt enim pariatur exercitation deserunt sunt consequat quis nisi veniam do. Adipisicing voluptate occaecat id dolore duis incididunt eu occaecat tempor Lorem adipisicing. Sunt officia elit ex anim consectetur\n             proident occaecat sint amet minim et. Sit quis consequat do deserunt sunt. Sunt aliquip esse id aliqua esse esse commodo excepteur ea aliqua labore quis cillum.	2023-05-28	2370	12	t	produityUmFF	4	t
15	\N	20	Abbott Group	 Irure elit Lorem incididunt enim pariatur exercitation deserunt sunt consequat quis nisi veniam do. Adipisicing voluptate occaecat id dolore duis incididunt eu occaecat tempor Lorem adipisicing. Sunt officia elit ex anim consectetur\n             proident occaecat sint amet minim et. Sit quis consequat do deserunt sunt. Sunt aliquip esse id aliqua esse esse commodo excepteur ea aliqua labore quis cillum.	2023-05-28	6370	12	t	produitujdbV	19	t
17	\N	14	Douglas, Rohan and Hoeger	 Irure elit Lorem incididunt enim pariatur exercitation deserunt sunt consequat quis nisi veniam do. Adipisicing voluptate occaecat id dolore duis incididunt eu occaecat tempor Lorem adipisicing. Sunt officia elit ex anim consectetur\n             proident occaecat sint amet minim et. Sit quis consequat do deserunt sunt. Sunt aliquip esse id aliqua esse esse commodo excepteur ea aliqua labore quis cillum.	2023-05-28	2290	3	t	produitFjKC5	11	t
19	\N	19	Goyette and Sons	 Irure elit Lorem incididunt enim pariatur exercitation deserunt sunt consequat quis nisi veniam do. Adipisicing voluptate occaecat id dolore duis incididunt eu occaecat tempor Lorem adipisicing. Sunt officia elit ex anim consectetur\n             proident occaecat sint amet minim et. Sit quis consequat do deserunt sunt. Sunt aliquip esse id aliqua esse esse commodo excepteur ea aliqua labore quis cillum.	2023-05-28	10290	9	t	produit4Snif	2	t
20	\N	15	Lind-Turcotte	 Irure elit Lorem incididunt enim pariatur exercitation deserunt sunt consequat quis nisi veniam do. Adipisicing voluptate occaecat id dolore duis incididunt eu occaecat tempor Lorem adipisicing. Sunt officia elit ex anim consectetur\n             proident occaecat sint amet minim et. Sit quis consequat do deserunt sunt. Sunt aliquip esse id aliqua esse esse commodo excepteur ea aliqua labore quis cillum.	2023-05-28	1290	4	t	produittLNa1	15	t
21	\N	15	Reilly and Sons	 Irure elit Lorem incididunt enim pariatur exercitation deserunt sunt consequat quis nisi veniam do. Adipisicing voluptate occaecat id dolore duis incididunt eu occaecat tempor Lorem adipisicing. Sunt officia elit ex anim consectetur\n             proident occaecat sint amet minim et. Sit quis consequat do deserunt sunt. Sunt aliquip esse id aliqua esse esse commodo excepteur ea aliqua labore quis cillum.	2023-05-28	3270	1	t	produitzIlmW	9	t
23	\N	16	Hudson-Wolf	 Irure elit Lorem incididunt enim pariatur exercitation deserunt sunt consequat quis nisi veniam do. Adipisicing voluptate occaecat id dolore duis incididunt eu occaecat tempor Lorem adipisicing. Sunt officia elit ex anim consectetur\n             proident occaecat sint amet minim et. Sit quis consequat do deserunt sunt. Sunt aliquip esse id aliqua esse esse commodo excepteur ea aliqua labore quis cillum.	2023-05-28	8330	8	t	produitL4hMt	3	t
24	\N	20	Cartwright, Cremin and Koch	 Irure elit Lorem incididunt enim pariatur exercitation deserunt sunt consequat quis nisi veniam do. Adipisicing voluptate occaecat id dolore duis incididunt eu occaecat tempor Lorem adipisicing. Sunt officia elit ex anim consectetur\n             proident occaecat sint amet minim et. Sit quis consequat do deserunt sunt. Sunt aliquip esse id aliqua esse esse commodo excepteur ea aliqua labore quis cillum.	2023-05-28	8330	14	t	produitPigCM	5	t
16	\N	20	Kuhlman, Fahey and Heidenreich	 Irure elit Lorem incididunt enim pariatur exercitation deserunt sunt consequat quis nisi veniam do. Adipisicing voluptate occaecat id dolore duis incididunt eu occaecat tempor Lorem adipisicing. Sunt officia elit ex anim consectetur\n             proident occaecat sint amet minim et. Sit quis consequat do deserunt sunt. Sunt aliquip esse id aliqua esse esse commodo excepteur ea aliqua labore quis cillum.	2023-05-28	2330	10	t	produit4Wy0n	14	f
18	\N	13	Lowe Ltd	 Irure elit Lorem incididunt enim pariatur exercitation deserunt sunt consequat quis nisi veniam do. Adipisicing voluptate occaecat id dolore duis incididunt eu occaecat tempor Lorem adipisicing. Sunt officia elit ex anim consectetur\n             proident occaecat sint amet minim et. Sit quis consequat do deserunt sunt. Sunt aliquip esse id aliqua esse esse commodo excepteur ea aliqua labore quis cillum.	2023-05-28	5330	14	t	produitKaH0h	8	f
26	\N	19	Effertz, Ledner and Marvin	 Irure elit Lorem incididunt enim pariatur exercitation deserunt sunt consequat quis nisi veniam do. Adipisicing voluptate occaecat id dolore duis incididunt eu occaecat tempor Lorem adipisicing. Sunt officia elit ex anim consectetur\n             proident occaecat sint amet minim et. Sit quis consequat do deserunt sunt. Sunt aliquip esse id aliqua esse esse commodo excepteur ea aliqua labore quis cillum.	2023-05-28	5350	1	t	produityf9XA	3	t
27	\N	13	Schinner Inc	 Irure elit Lorem incididunt enim pariatur exercitation deserunt sunt consequat quis nisi veniam do. Adipisicing voluptate occaecat id dolore duis incididunt eu occaecat tempor Lorem adipisicing. Sunt officia elit ex anim consectetur\n             proident occaecat sint amet minim et. Sit quis consequat do deserunt sunt. Sunt aliquip esse id aliqua esse esse commodo excepteur ea aliqua labore quis cillum.	2023-05-28	6350	4	t	produitatnAs	13	t
28	\N	15	Streich-Gislason	 Irure elit Lorem incididunt enim pariatur exercitation deserunt sunt consequat quis nisi veniam do. Adipisicing voluptate occaecat id dolore duis incididunt eu occaecat tempor Lorem adipisicing. Sunt officia elit ex anim consectetur\n             proident occaecat sint amet minim et. Sit quis consequat do deserunt sunt. Sunt aliquip esse id aliqua esse esse commodo excepteur ea aliqua labore quis cillum.	2023-05-28	1390	17	t	produitu683L	10	t
29	\N	18	Paucek-Sanford	 Irure elit Lorem incididunt enim pariatur exercitation deserunt sunt consequat quis nisi veniam do. Adipisicing voluptate occaecat id dolore duis incididunt eu occaecat tempor Lorem adipisicing. Sunt officia elit ex anim consectetur\n             proident occaecat sint amet minim et. Sit quis consequat do deserunt sunt. Sunt aliquip esse id aliqua esse esse commodo excepteur ea aliqua labore quis cillum.	2023-05-28	2350	12	t	produitpn0br	11	t
30	\N	12	Robel-Rowe	 Irure elit Lorem incididunt enim pariatur exercitation deserunt sunt consequat quis nisi veniam do. Adipisicing voluptate occaecat id dolore duis incididunt eu occaecat tempor Lorem adipisicing. Sunt officia elit ex anim consectetur\n             proident occaecat sint amet minim et. Sit quis consequat do deserunt sunt. Sunt aliquip esse id aliqua esse esse commodo excepteur ea aliqua labore quis cillum.	2023-05-28	8370	16	t	produitIjapk	17	t
32	\N	20	Bogisich Ltd	 Irure elit Lorem incididunt enim pariatur exercitation deserunt sunt consequat quis nisi veniam do. Adipisicing voluptate occaecat id dolore duis incididunt eu occaecat tempor Lorem adipisicing. Sunt officia elit ex anim consectetur\n             proident occaecat sint amet minim et. Sit quis consequat do deserunt sunt. Sunt aliquip esse id aliqua esse esse commodo excepteur ea aliqua labore quis cillum.	2023-05-28	4450	16	t	produit2RDug	20	t
33	\N	13	Dooley, White and Johnston	 Irure elit Lorem incididunt enim pariatur exercitation deserunt sunt consequat quis nisi veniam do. Adipisicing voluptate occaecat id dolore duis incididunt eu occaecat tempor Lorem adipisicing. Sunt officia elit ex anim consectetur\n             proident occaecat sint amet minim et. Sit quis consequat do deserunt sunt. Sunt aliquip esse id aliqua esse esse commodo excepteur ea aliqua labore quis cillum.	2023-05-28	7350	1	t	produitNtV1n	7	t
35	\N	13	Gutmann PLC	 Irure elit Lorem incididunt enim pariatur exercitation deserunt sunt consequat quis nisi veniam do. Adipisicing voluptate occaecat id dolore duis incididunt eu occaecat tempor Lorem adipisicing. Sunt officia elit ex anim consectetur\n             proident occaecat sint amet minim et. Sit quis consequat do deserunt sunt. Sunt aliquip esse id aliqua esse esse commodo excepteur ea aliqua labore quis cillum.	2023-05-28	10430	13	t	produitvnnXn	14	t
36	\N	14	Murazik-Hayes	 Irure elit Lorem incididunt enim pariatur exercitation deserunt sunt consequat quis nisi veniam do. Adipisicing voluptate occaecat id dolore duis incididunt eu occaecat tempor Lorem adipisicing. Sunt officia elit ex anim consectetur\n             proident occaecat sint amet minim et. Sit quis consequat do deserunt sunt. Sunt aliquip esse id aliqua esse esse commodo excepteur ea aliqua labore quis cillum.	2023-05-28	8330	2	t	produitvEJxG	17	t
38	\N	11	Windler-Bergnaum	 Irure elit Lorem incididunt enim pariatur exercitation deserunt sunt consequat quis nisi veniam do. Adipisicing voluptate occaecat id dolore duis incididunt eu occaecat tempor Lorem adipisicing. Sunt officia elit ex anim consectetur\n             proident occaecat sint amet minim et. Sit quis consequat do deserunt sunt. Sunt aliquip esse id aliqua esse esse commodo excepteur ea aliqua labore quis cillum.	2023-05-28	1370	18	t	produitnF45i	3	t
39	\N	18	Strosin LLC	 Irure elit Lorem incididunt enim pariatur exercitation deserunt sunt consequat quis nisi veniam do. Adipisicing voluptate occaecat id dolore duis incididunt eu occaecat tempor Lorem adipisicing. Sunt officia elit ex anim consectetur\n             proident occaecat sint amet minim et. Sit quis consequat do deserunt sunt. Sunt aliquip esse id aliqua esse esse commodo excepteur ea aliqua labore quis cillum.	2023-05-28	4270	19	t	produitgyln8	10	t
31	\N	19	Feeney-Walsh	 Irure elit Lorem incididunt enim pariatur exercitation deserunt sunt consequat quis nisi veniam do. Adipisicing voluptate occaecat id dolore duis incididunt eu occaecat tempor Lorem adipisicing. Sunt officia elit ex anim consectetur\n             proident occaecat sint amet minim et. Sit quis consequat do deserunt sunt. Sunt aliquip esse id aliqua esse esse commodo excepteur ea aliqua labore quis cillum.	2023-05-28	10430	7	t	produit1dhKZ	8	f
34	\N	12	Satterfield LLC	 Irure elit Lorem incididunt enim pariatur exercitation deserunt sunt consequat quis nisi veniam do. Adipisicing voluptate occaecat id dolore duis incididunt eu occaecat tempor Lorem adipisicing. Sunt officia elit ex anim consectetur\n             proident occaecat sint amet minim et. Sit quis consequat do deserunt sunt. Sunt aliquip esse id aliqua esse esse commodo excepteur ea aliqua labore quis cillum.	2023-05-28	7390	5	t	produitHbatN	3	f
37	\N	18	Jast-Tremblay	 Irure elit Lorem incididunt enim pariatur exercitation deserunt sunt consequat quis nisi veniam do. Adipisicing voluptate occaecat id dolore duis incididunt eu occaecat tempor Lorem adipisicing. Sunt officia elit ex anim consectetur\n             proident occaecat sint amet minim et. Sit quis consequat do deserunt sunt. Sunt aliquip esse id aliqua esse esse commodo excepteur ea aliqua labore quis cillum.	2023-05-28	3350	11	t	produitjpAqZ	10	f
40	\N	19	Stark and Sons	 Irure elit Lorem incididunt enim pariatur exercitation deserunt sunt consequat quis nisi veniam do. Adipisicing voluptate occaecat id dolore duis incididunt eu occaecat tempor Lorem adipisicing. Sunt officia elit ex anim consectetur\n             proident occaecat sint amet minim et. Sit quis consequat do deserunt sunt. Sunt aliquip esse id aliqua esse esse commodo excepteur ea aliqua labore quis cillum.	2023-05-28	5370	16	t	produit5TUCJ	16	t
41	\N	17	Weber Inc	 Irure elit Lorem incididunt enim pariatur exercitation deserunt sunt consequat quis nisi veniam do. Adipisicing voluptate occaecat id dolore duis incididunt eu occaecat tempor Lorem adipisicing. Sunt officia elit ex anim consectetur\n             proident occaecat sint amet minim et. Sit quis consequat do deserunt sunt. Sunt aliquip esse id aliqua esse esse commodo excepteur ea aliqua labore quis cillum.	2023-05-28	8370	6	t	produitiZjBI	19	t
42	\N	18	Parker, Eichmann and Feil	 Irure elit Lorem incididunt enim pariatur exercitation deserunt sunt consequat quis nisi veniam do. Adipisicing voluptate occaecat id dolore duis incididunt eu occaecat tempor Lorem adipisicing. Sunt officia elit ex anim consectetur\n             proident occaecat sint amet minim et. Sit quis consequat do deserunt sunt. Sunt aliquip esse id aliqua esse esse commodo excepteur ea aliqua labore quis cillum.	2023-05-28	9310	6	t	produitQ8HHX	1	t
44	\N	14	Sawayn PLC	 Irure elit Lorem incididunt enim pariatur exercitation deserunt sunt consequat quis nisi veniam do. Adipisicing voluptate occaecat id dolore duis incididunt eu occaecat tempor Lorem adipisicing. Sunt officia elit ex anim consectetur\n             proident occaecat sint amet minim et. Sit quis consequat do deserunt sunt. Sunt aliquip esse id aliqua esse esse commodo excepteur ea aliqua labore quis cillum.	2023-05-28	10270	17	t	produit0lAWe	8	t
45	\N	12	Mueller-McKenzie	 Irure elit Lorem incididunt enim pariatur exercitation deserunt sunt consequat quis nisi veniam do. Adipisicing voluptate occaecat id dolore duis incididunt eu occaecat tempor Lorem adipisicing. Sunt officia elit ex anim consectetur\n             proident occaecat sint amet minim et. Sit quis consequat do deserunt sunt. Sunt aliquip esse id aliqua esse esse commodo excepteur ea aliqua labore quis cillum.	2023-05-28	2350	6	t	produitWm7dk	2	t
46	\N	14	Gutmann LLC	 Irure elit Lorem incididunt enim pariatur exercitation deserunt sunt consequat quis nisi veniam do. Adipisicing voluptate occaecat id dolore duis incididunt eu occaecat tempor Lorem adipisicing. Sunt officia elit ex anim consectetur\n             proident occaecat sint amet minim et. Sit quis consequat do deserunt sunt. Sunt aliquip esse id aliqua esse esse commodo excepteur ea aliqua labore quis cillum.	2023-05-28	3370	2	t	produitgyBLt	11	t
47	\N	11	Douglas, Sawayn and Hahn	 Irure elit Lorem incididunt enim pariatur exercitation deserunt sunt consequat quis nisi veniam do. Adipisicing voluptate occaecat id dolore duis incididunt eu occaecat tempor Lorem adipisicing. Sunt officia elit ex anim consectetur\n             proident occaecat sint amet minim et. Sit quis consequat do deserunt sunt. Sunt aliquip esse id aliqua esse esse commodo excepteur ea aliqua labore quis cillum.	2023-05-28	9410	6	t	produitnjyJO	4	t
48	\N	17	Turcotte, Kunze and Price	 Irure elit Lorem incididunt enim pariatur exercitation deserunt sunt consequat quis nisi veniam do. Adipisicing voluptate occaecat id dolore duis incididunt eu occaecat tempor Lorem adipisicing. Sunt officia elit ex anim consectetur\n             proident occaecat sint amet minim et. Sit quis consequat do deserunt sunt. Sunt aliquip esse id aliqua esse esse commodo excepteur ea aliqua labore quis cillum.	2023-05-28	2330	17	t	produit7VYu0	12	t
49	\N	18	Grimes-Runolfsdottir	 Irure elit Lorem incididunt enim pariatur exercitation deserunt sunt consequat quis nisi veniam do. Adipisicing voluptate occaecat id dolore duis incididunt eu occaecat tempor Lorem adipisicing. Sunt officia elit ex anim consectetur\n             proident occaecat sint amet minim et. Sit quis consequat do deserunt sunt. Sunt aliquip esse id aliqua esse esse commodo excepteur ea aliqua labore quis cillum.	2023-05-28	9450	3	t	produithoPix	12	t
50	\N	12	Skiles-Koelpin	 Irure elit Lorem incididunt enim pariatur exercitation deserunt sunt consequat quis nisi veniam do. Adipisicing voluptate occaecat id dolore duis incididunt eu occaecat tempor Lorem adipisicing. Sunt officia elit ex anim consectetur\n             proident occaecat sint amet minim et. Sit quis consequat do deserunt sunt. Sunt aliquip esse id aliqua esse esse commodo excepteur ea aliqua labore quis cillum.	2023-05-28	6350	14	t	produitH6jgB	12	t
51	\N	20	Ernser, Gaylord and Weimann	 Irure elit Lorem incididunt enim pariatur exercitation deserunt sunt consequat quis nisi veniam do. Adipisicing voluptate occaecat id dolore duis incididunt eu occaecat tempor Lorem adipisicing. Sunt officia elit ex anim consectetur\n             proident occaecat sint amet minim et. Sit quis consequat do deserunt sunt. Sunt aliquip esse id aliqua esse esse commodo excepteur ea aliqua labore quis cillum.	2023-05-28	6430	1	t	produitQ7GQj	15	t
52	\N	11	Bahringer-Kris	 Irure elit Lorem incididunt enim pariatur exercitation deserunt sunt consequat quis nisi veniam do. Adipisicing voluptate occaecat id dolore duis incididunt eu occaecat tempor Lorem adipisicing. Sunt officia elit ex anim consectetur\n             proident occaecat sint amet minim et. Sit quis consequat do deserunt sunt. Sunt aliquip esse id aliqua esse esse commodo excepteur ea aliqua labore quis cillum.	2023-05-28	4290	20	t	produitvxsOF	12	t
53	\N	26	Schimmel, Mitchell and Lehner	 Irure elit Lorem incididunt enim pariatur exercitation deserunt sunt consequat quis nisi veniam do. Adipisicing voluptate occaecat id dolore duis incididunt eu occaecat tempor Lorem adipisicing. Sunt officia elit ex anim consectetur\n             proident occaecat sint amet minim et. Sit quis consequat do deserunt sunt. Sunt aliquip esse id aliqua esse esse commodo excepteur ea aliqua labore quis cillum.	2023-05-28	5310	5	t	produit3iQK6	13	t
54	\N	24	Terry and Sons	 Irure elit Lorem incididunt enim pariatur exercitation deserunt sunt consequat quis nisi veniam do. Adipisicing voluptate occaecat id dolore duis incididunt eu occaecat tempor Lorem adipisicing. Sunt officia elit ex anim consectetur\n             proident occaecat sint amet minim et. Sit quis consequat do deserunt sunt. Sunt aliquip esse id aliqua esse esse commodo excepteur ea aliqua labore quis cillum.	2023-05-28	5350	4	t	produitWyJ43	13	t
55	\N	19	Steuber-Shanahan	 Irure elit Lorem incididunt enim pariatur exercitation deserunt sunt consequat quis nisi veniam do. Adipisicing voluptate occaecat id dolore duis incididunt eu occaecat tempor Lorem adipisicing. Sunt officia elit ex anim consectetur\n             proident occaecat sint amet minim et. Sit quis consequat do deserunt sunt. Sunt aliquip esse id aliqua esse esse commodo excepteur ea aliqua labore quis cillum.	2023-05-28	4370	11	t	produit4FWik	20	t
56	\N	13	Ullrich, Kuhn and Weber	 Irure elit Lorem incididunt enim pariatur exercitation deserunt sunt consequat quis nisi veniam do. Adipisicing voluptate occaecat id dolore duis incididunt eu occaecat tempor Lorem adipisicing. Sunt officia elit ex anim consectetur\n             proident occaecat sint amet minim et. Sit quis consequat do deserunt sunt. Sunt aliquip esse id aliqua esse esse commodo excepteur ea aliqua labore quis cillum.	2023-05-28	1270	16	t	produit6ZwKf	20	t
57	\N	24	Ledner, Schowalter and Runolfsson	 Irure elit Lorem incididunt enim pariatur exercitation deserunt sunt consequat quis nisi veniam do. Adipisicing voluptate occaecat id dolore duis incididunt eu occaecat tempor Lorem adipisicing. Sunt officia elit ex anim consectetur\n             proident occaecat sint amet minim et. Sit quis consequat do deserunt sunt. Sunt aliquip esse id aliqua esse esse commodo excepteur ea aliqua labore quis cillum.	2023-05-28	1430	3	t	produitbVEIq	3	t
58	\N	19	Kris-Moen	 Irure elit Lorem incididunt enim pariatur exercitation deserunt sunt consequat quis nisi veniam do. Adipisicing voluptate occaecat id dolore duis incididunt eu occaecat tempor Lorem adipisicing. Sunt officia elit ex anim consectetur\n             proident occaecat sint amet minim et. Sit quis consequat do deserunt sunt. Sunt aliquip esse id aliqua esse esse commodo excepteur ea aliqua labore quis cillum.	2023-05-28	5270	3	t	produitv5O4l	12	t
59	\N	11	Prohaska-Baumbach	 Irure elit Lorem incididunt enim pariatur exercitation deserunt sunt consequat quis nisi veniam do. Adipisicing voluptate occaecat id dolore duis incididunt eu occaecat tempor Lorem adipisicing. Sunt officia elit ex anim consectetur\n             proident occaecat sint amet minim et. Sit quis consequat do deserunt sunt. Sunt aliquip esse id aliqua esse esse commodo excepteur ea aliqua labore quis cillum.	2023-05-28	5430	16	t	produitJjELp	13	t
60	\N	23	Farrell-Jacobi	 Irure elit Lorem incididunt enim pariatur exercitation deserunt sunt consequat quis nisi veniam do. Adipisicing voluptate occaecat id dolore duis incididunt eu occaecat tempor Lorem adipisicing. Sunt officia elit ex anim consectetur\n             proident occaecat sint amet minim et. Sit quis consequat do deserunt sunt. Sunt aliquip esse id aliqua esse esse commodo excepteur ea aliqua labore quis cillum.	2023-05-28	2330	17	t	produitwlm2M	18	t
61	\N	12	Medhurst, Abshire and Emard	 Irure elit Lorem incididunt enim pariatur exercitation deserunt sunt consequat quis nisi veniam do. Adipisicing voluptate occaecat id dolore duis incididunt eu occaecat tempor Lorem adipisicing. Sunt officia elit ex anim consectetur\n             proident occaecat sint amet minim et. Sit quis consequat do deserunt sunt. Sunt aliquip esse id aliqua esse esse commodo excepteur ea aliqua labore quis cillum.	2023-05-28	2350	13	t	produit21Gw3	3	t
62	\N	26	Parisian Ltd	 Irure elit Lorem incididunt enim pariatur exercitation deserunt sunt consequat quis nisi veniam do. Adipisicing voluptate occaecat id dolore duis incididunt eu occaecat tempor Lorem adipisicing. Sunt officia elit ex anim consectetur\n             proident occaecat sint amet minim et. Sit quis consequat do deserunt sunt. Sunt aliquip esse id aliqua esse esse commodo excepteur ea aliqua labore quis cillum.	2023-05-28	5370	18	t	produit3hTyr	12	t
63	\N	27	Gleichner, Lind and Stiedemann	 Irure elit Lorem incididunt enim pariatur exercitation deserunt sunt consequat quis nisi veniam do. Adipisicing voluptate occaecat id dolore duis incididunt eu occaecat tempor Lorem adipisicing. Sunt officia elit ex anim consectetur\n             proident occaecat sint amet minim et. Sit quis consequat do deserunt sunt. Sunt aliquip esse id aliqua esse esse commodo excepteur ea aliqua labore quis cillum.	2023-05-28	6450	13	t	produitRemD4	1	t
64	\N	23	Stanton-Russel	 Irure elit Lorem incididunt enim pariatur exercitation deserunt sunt consequat quis nisi veniam do. Adipisicing voluptate occaecat id dolore duis incididunt eu occaecat tempor Lorem adipisicing. Sunt officia elit ex anim consectetur\n             proident occaecat sint amet minim et. Sit quis consequat do deserunt sunt. Sunt aliquip esse id aliqua esse esse commodo excepteur ea aliqua labore quis cillum.	2023-05-28	8290	20	t	produit558kH	6	t
65	\N	23	Kozey, Smith and McDermott	 Irure elit Lorem incididunt enim pariatur exercitation deserunt sunt consequat quis nisi veniam do. Adipisicing voluptate occaecat id dolore duis incididunt eu occaecat tempor Lorem adipisicing. Sunt officia elit ex anim consectetur\n             proident occaecat sint amet minim et. Sit quis consequat do deserunt sunt. Sunt aliquip esse id aliqua esse esse commodo excepteur ea aliqua labore quis cillum.	2023-05-28	5350	10	t	produit2HkOB	17	t
66	\N	11	Sipes-Frami	 Irure elit Lorem incididunt enim pariatur exercitation deserunt sunt consequat quis nisi veniam do. Adipisicing voluptate occaecat id dolore duis incididunt eu occaecat tempor Lorem adipisicing. Sunt officia elit ex anim consectetur\n             proident occaecat sint amet minim et. Sit quis consequat do deserunt sunt. Sunt aliquip esse id aliqua esse esse commodo excepteur ea aliqua labore quis cillum.	2023-05-28	10350	6	t	produitKnMrk	8	t
67	\N	18	Swaniawski-Jacobs	 Irure elit Lorem incididunt enim pariatur exercitation deserunt sunt consequat quis nisi veniam do. Adipisicing voluptate occaecat id dolore duis incididunt eu occaecat tempor Lorem adipisicing. Sunt officia elit ex anim consectetur\n             proident occaecat sint amet minim et. Sit quis consequat do deserunt sunt. Sunt aliquip esse id aliqua esse esse commodo excepteur ea aliqua labore quis cillum.	2023-05-28	5310	15	t	produitwVhWF	11	t
68	\N	15	Kiehn Inc	 Irure elit Lorem incididunt enim pariatur exercitation deserunt sunt consequat quis nisi veniam do. Adipisicing voluptate occaecat id dolore duis incididunt eu occaecat tempor Lorem adipisicing. Sunt officia elit ex anim consectetur\n             proident occaecat sint amet minim et. Sit quis consequat do deserunt sunt. Sunt aliquip esse id aliqua esse esse commodo excepteur ea aliqua labore quis cillum.	2023-05-28	2330	15	t	produitUMDTn	18	t
69	\N	18	Lowe, Friesen and Larson	 Irure elit Lorem incididunt enim pariatur exercitation deserunt sunt consequat quis nisi veniam do. Adipisicing voluptate occaecat id dolore duis incididunt eu occaecat tempor Lorem adipisicing. Sunt officia elit ex anim consectetur\n             proident occaecat sint amet minim et. Sit quis consequat do deserunt sunt. Sunt aliquip esse id aliqua esse esse commodo excepteur ea aliqua labore quis cillum.	2023-05-28	5370	16	t	produitT3KnX	3	t
70	\N	15	Dietrich-Kiehn	 Irure elit Lorem incididunt enim pariatur exercitation deserunt sunt consequat quis nisi veniam do. Adipisicing voluptate occaecat id dolore duis incididunt eu occaecat tempor Lorem adipisicing. Sunt officia elit ex anim consectetur\n             proident occaecat sint amet minim et. Sit quis consequat do deserunt sunt. Sunt aliquip esse id aliqua esse esse commodo excepteur ea aliqua labore quis cillum.	2023-05-28	5310	17	t	produitfngIc	11	t
71	\N	26	Emard, Schiller and Langworth	 Irure elit Lorem incididunt enim pariatur exercitation deserunt sunt consequat quis nisi veniam do. Adipisicing voluptate occaecat id dolore duis incididunt eu occaecat tempor Lorem adipisicing. Sunt officia elit ex anim consectetur\n             proident occaecat sint amet minim et. Sit quis consequat do deserunt sunt. Sunt aliquip esse id aliqua esse esse commodo excepteur ea aliqua labore quis cillum.	2023-05-28	5370	19	t	produitaEV2L	5	t
72	\N	22	Murphy, Gislason and Hegmann	 Irure elit Lorem incididunt enim pariatur exercitation deserunt sunt consequat quis nisi veniam do. Adipisicing voluptate occaecat id dolore duis incididunt eu occaecat tempor Lorem adipisicing. Sunt officia elit ex anim consectetur\n             proident occaecat sint amet minim et. Sit quis consequat do deserunt sunt. Sunt aliquip esse id aliqua esse esse commodo excepteur ea aliqua labore quis cillum.	2023-05-28	2430	9	t	produitxHep8	7	t
73	\N	12	Fay and Sons	 Irure elit Lorem incididunt enim pariatur exercitation deserunt sunt consequat quis nisi veniam do. Adipisicing voluptate occaecat id dolore duis incididunt eu occaecat tempor Lorem adipisicing. Sunt officia elit ex anim consectetur\n             proident occaecat sint amet minim et. Sit quis consequat do deserunt sunt. Sunt aliquip esse id aliqua esse esse commodo excepteur ea aliqua labore quis cillum.	2023-05-28	8390	3	t	produitx6g9V	11	t
74	\N	28	Stokes, Leuschke and Hodkiewicz	 Irure elit Lorem incididunt enim pariatur exercitation deserunt sunt consequat quis nisi veniam do. Adipisicing voluptate occaecat id dolore duis incididunt eu occaecat tempor Lorem adipisicing. Sunt officia elit ex anim consectetur\n             proident occaecat sint amet minim et. Sit quis consequat do deserunt sunt. Sunt aliquip esse id aliqua esse esse commodo excepteur ea aliqua labore quis cillum.	2023-05-28	7310	4	t	produitI7jSM	3	t
75	\N	25	Ortiz-Morissette	 Irure elit Lorem incididunt enim pariatur exercitation deserunt sunt consequat quis nisi veniam do. Adipisicing voluptate occaecat id dolore duis incididunt eu occaecat tempor Lorem adipisicing. Sunt officia elit ex anim consectetur\n             proident occaecat sint amet minim et. Sit quis consequat do deserunt sunt. Sunt aliquip esse id aliqua esse esse commodo excepteur ea aliqua labore quis cillum.	2023-05-28	7370	11	t	produitugxPe	5	t
76	\N	11	Christiansen, Marvin and VonRueden	 Irure elit Lorem incididunt enim pariatur exercitation deserunt sunt consequat quis nisi veniam do. Adipisicing voluptate occaecat id dolore duis incididunt eu occaecat tempor Lorem adipisicing. Sunt officia elit ex anim consectetur\n             proident occaecat sint amet minim et. Sit quis consequat do deserunt sunt. Sunt aliquip esse id aliqua esse esse commodo excepteur ea aliqua labore quis cillum.	2023-05-28	3370	10	t	produityczfw	4	t
77	\N	17	Parker Group	 Irure elit Lorem incididunt enim pariatur exercitation deserunt sunt consequat quis nisi veniam do. Adipisicing voluptate occaecat id dolore duis incididunt eu occaecat tempor Lorem adipisicing. Sunt officia elit ex anim consectetur\n             proident occaecat sint amet minim et. Sit quis consequat do deserunt sunt. Sunt aliquip esse id aliqua esse esse commodo excepteur ea aliqua labore quis cillum.	2023-05-28	1450	12	t	produitbzVzU	10	t
78	\N	27	Eichmann Inc	 Irure elit Lorem incididunt enim pariatur exercitation deserunt sunt consequat quis nisi veniam do. Adipisicing voluptate occaecat id dolore duis incididunt eu occaecat tempor Lorem adipisicing. Sunt officia elit ex anim consectetur\n             proident occaecat sint amet minim et. Sit quis consequat do deserunt sunt. Sunt aliquip esse id aliqua esse esse commodo excepteur ea aliqua labore quis cillum.	2023-05-28	5310	5	t	produitbZWDn	12	t
79	\N	28	Hayes-Rohan	 Irure elit Lorem incididunt enim pariatur exercitation deserunt sunt consequat quis nisi veniam do. Adipisicing voluptate occaecat id dolore duis incididunt eu occaecat tempor Lorem adipisicing. Sunt officia elit ex anim consectetur\n             proident occaecat sint amet minim et. Sit quis consequat do deserunt sunt. Sunt aliquip esse id aliqua esse esse commodo excepteur ea aliqua labore quis cillum.	2023-05-28	8350	15	t	produit9vPeJ	5	t
80	\N	17	Grady Inc	 Irure elit Lorem incididunt enim pariatur exercitation deserunt sunt consequat quis nisi veniam do. Adipisicing voluptate occaecat id dolore duis incididunt eu occaecat tempor Lorem adipisicing. Sunt officia elit ex anim consectetur\n             proident occaecat sint amet minim et. Sit quis consequat do deserunt sunt. Sunt aliquip esse id aliqua esse esse commodo excepteur ea aliqua labore quis cillum.	2023-05-28	6450	15	t	produitMz52k	6	t
82	\N	11	Stoltenberg-Tromp	 Irure elit Lorem incididunt enim pariatur exercitation deserunt sunt consequat quis nisi veniam do. Adipisicing voluptate occaecat id dolore duis incididunt eu occaecat tempor Lorem adipisicing. Sunt officia elit ex anim consectetur\n             proident occaecat sint amet minim et. Sit quis consequat do deserunt sunt. Sunt aliquip esse id aliqua esse esse commodo excepteur ea aliqua labore quis cillum.	2023-05-28	4330	4	t	produitnRcN3	17	t
83	\N	16	Langosh-Murphy	 Irure elit Lorem incididunt enim pariatur exercitation deserunt sunt consequat quis nisi veniam do. Adipisicing voluptate occaecat id dolore duis incididunt eu occaecat tempor Lorem adipisicing. Sunt officia elit ex anim consectetur\n             proident occaecat sint amet minim et. Sit quis consequat do deserunt sunt. Sunt aliquip esse id aliqua esse esse commodo excepteur ea aliqua labore quis cillum.	2023-05-28	3450	20	t	produitLQzdr	14	t
84	\N	15	McGlynn-Feil	 Irure elit Lorem incididunt enim pariatur exercitation deserunt sunt consequat quis nisi veniam do. Adipisicing voluptate occaecat id dolore duis incididunt eu occaecat tempor Lorem adipisicing. Sunt officia elit ex anim consectetur\n             proident occaecat sint amet minim et. Sit quis consequat do deserunt sunt. Sunt aliquip esse id aliqua esse esse commodo excepteur ea aliqua labore quis cillum.	2023-05-28	8370	12	t	produitjNUoL	5	t
85	\N	26	Gislason Inc	 Irure elit Lorem incididunt enim pariatur exercitation deserunt sunt consequat quis nisi veniam do. Adipisicing voluptate occaecat id dolore duis incididunt eu occaecat tempor Lorem adipisicing. Sunt officia elit ex anim consectetur\n             proident occaecat sint amet minim et. Sit quis consequat do deserunt sunt. Sunt aliquip esse id aliqua esse esse commodo excepteur ea aliqua labore quis cillum.	2023-05-28	7290	5	t	produitH6jEG	4	t
86	\N	29	Heaney LLC	 Irure elit Lorem incididunt enim pariatur exercitation deserunt sunt consequat quis nisi veniam do. Adipisicing voluptate occaecat id dolore duis incididunt eu occaecat tempor Lorem adipisicing. Sunt officia elit ex anim consectetur\n             proident occaecat sint amet minim et. Sit quis consequat do deserunt sunt. Sunt aliquip esse id aliqua esse esse commodo excepteur ea aliqua labore quis cillum.	2023-05-28	1350	9	t	produitSLKGr	13	t
87	\N	28	Koss, Stroman and Torp	 Irure elit Lorem incididunt enim pariatur exercitation deserunt sunt consequat quis nisi veniam do. Adipisicing voluptate occaecat id dolore duis incididunt eu occaecat tempor Lorem adipisicing. Sunt officia elit ex anim consectetur\n             proident occaecat sint amet minim et. Sit quis consequat do deserunt sunt. Sunt aliquip esse id aliqua esse esse commodo excepteur ea aliqua labore quis cillum.	2023-05-28	3370	6	t	produitAjV8X	4	t
88	\N	19	Terry, Mann and Champlin	 Irure elit Lorem incididunt enim pariatur exercitation deserunt sunt consequat quis nisi veniam do. Adipisicing voluptate occaecat id dolore duis incididunt eu occaecat tempor Lorem adipisicing. Sunt officia elit ex anim consectetur\n             proident occaecat sint amet minim et. Sit quis consequat do deserunt sunt. Sunt aliquip esse id aliqua esse esse commodo excepteur ea aliqua labore quis cillum.	2023-05-28	7410	3	t	produitxqARo	17	t
89	\N	30	D'Amore and Sons	 Irure elit Lorem incididunt enim pariatur exercitation deserunt sunt consequat quis nisi veniam do. Adipisicing voluptate occaecat id dolore duis incididunt eu occaecat tempor Lorem adipisicing. Sunt officia elit ex anim consectetur\n             proident occaecat sint amet minim et. Sit quis consequat do deserunt sunt. Sunt aliquip esse id aliqua esse esse commodo excepteur ea aliqua labore quis cillum.	2023-05-28	5450	15	t	produit4NsYk	14	t
90	\N	27	Bayer, Schuppe and Cremin	 Irure elit Lorem incididunt enim pariatur exercitation deserunt sunt consequat quis nisi veniam do. Adipisicing voluptate occaecat id dolore duis incididunt eu occaecat tempor Lorem adipisicing. Sunt officia elit ex anim consectetur\n             proident occaecat sint amet minim et. Sit quis consequat do deserunt sunt. Sunt aliquip esse id aliqua esse esse commodo excepteur ea aliqua labore quis cillum.	2023-05-28	7270	2	t	produitBWHtf	13	t
91	\N	24	Wolff, Lang and Denesik	 Irure elit Lorem incididunt enim pariatur exercitation deserunt sunt consequat quis nisi veniam do. Adipisicing voluptate occaecat id dolore duis incididunt eu occaecat tempor Lorem adipisicing. Sunt officia elit ex anim consectetur\n             proident occaecat sint amet minim et. Sit quis consequat do deserunt sunt. Sunt aliquip esse id aliqua esse esse commodo excepteur ea aliqua labore quis cillum.	2023-05-28	9430	2	t	produitPRigW	13	t
92	\N	30	Macejkovic-Roob	 Irure elit Lorem incididunt enim pariatur exercitation deserunt sunt consequat quis nisi veniam do. Adipisicing voluptate occaecat id dolore duis incididunt eu occaecat tempor Lorem adipisicing. Sunt officia elit ex anim consectetur\n             proident occaecat sint amet minim et. Sit quis consequat do deserunt sunt. Sunt aliquip esse id aliqua esse esse commodo excepteur ea aliqua labore quis cillum.	2023-05-28	4390	11	t	produith3x6z	13	t
93	\N	11	Beahan-Bogisich	 Irure elit Lorem incididunt enim pariatur exercitation deserunt sunt consequat quis nisi veniam do. Adipisicing voluptate occaecat id dolore duis incididunt eu occaecat tempor Lorem adipisicing. Sunt officia elit ex anim consectetur\n             proident occaecat sint amet minim et. Sit quis consequat do deserunt sunt. Sunt aliquip esse id aliqua esse esse commodo excepteur ea aliqua labore quis cillum.	2023-05-28	1330	12	t	produite7lDQ	20	t
94	\N	13	Strosin Group	 Irure elit Lorem incididunt enim pariatur exercitation deserunt sunt consequat quis nisi veniam do. Adipisicing voluptate occaecat id dolore duis incididunt eu occaecat tempor Lorem adipisicing. Sunt officia elit ex anim consectetur\n             proident occaecat sint amet minim et. Sit quis consequat do deserunt sunt. Sunt aliquip esse id aliqua esse esse commodo excepteur ea aliqua labore quis cillum.	2023-05-28	6270	7	t	produityLfhw	13	t
95	\N	26	Moore-Abernathy	 Irure elit Lorem incididunt enim pariatur exercitation deserunt sunt consequat quis nisi veniam do. Adipisicing voluptate occaecat id dolore duis incididunt eu occaecat tempor Lorem adipisicing. Sunt officia elit ex anim consectetur\n             proident occaecat sint amet minim et. Sit quis consequat do deserunt sunt. Sunt aliquip esse id aliqua esse esse commodo excepteur ea aliqua labore quis cillum.	2023-05-28	2330	8	t	produit1cMqQ	11	t
96	\N	29	Lakin, Marvin and Kuhlman	 Irure elit Lorem incididunt enim pariatur exercitation deserunt sunt consequat quis nisi veniam do. Adipisicing voluptate occaecat id dolore duis incididunt eu occaecat tempor Lorem adipisicing. Sunt officia elit ex anim consectetur\n             proident occaecat sint amet minim et. Sit quis consequat do deserunt sunt. Sunt aliquip esse id aliqua esse esse commodo excepteur ea aliqua labore quis cillum.	2023-05-28	7410	14	t	produitJLlUp	1	t
97	\N	22	Lowe PLC	 Irure elit Lorem incididunt enim pariatur exercitation deserunt sunt consequat quis nisi veniam do. Adipisicing voluptate occaecat id dolore duis incididunt eu occaecat tempor Lorem adipisicing. Sunt officia elit ex anim consectetur\n             proident occaecat sint amet minim et. Sit quis consequat do deserunt sunt. Sunt aliquip esse id aliqua esse esse commodo excepteur ea aliqua labore quis cillum.	2023-05-28	5290	2	t	produitIOPjd	15	t
98	\N	21	Pfeffer, Swaniawski and Emmerich	 Irure elit Lorem incididunt enim pariatur exercitation deserunt sunt consequat quis nisi veniam do. Adipisicing voluptate occaecat id dolore duis incididunt eu occaecat tempor Lorem adipisicing. Sunt officia elit ex anim consectetur\n             proident occaecat sint amet minim et. Sit quis consequat do deserunt sunt. Sunt aliquip esse id aliqua esse esse commodo excepteur ea aliqua labore quis cillum.	2023-05-28	10270	12	t	produitYdEET	5	t
99	\N	20	Effertz Group	 Irure elit Lorem incididunt enim pariatur exercitation deserunt sunt consequat quis nisi veniam do. Adipisicing voluptate occaecat id dolore duis incididunt eu occaecat tempor Lorem adipisicing. Sunt officia elit ex anim consectetur\n             proident occaecat sint amet minim et. Sit quis consequat do deserunt sunt. Sunt aliquip esse id aliqua esse esse commodo excepteur ea aliqua labore quis cillum.	2023-05-28	1310	13	t	produitef3wv	8	t
100	\N	13	Morar-Franecki	 Irure elit Lorem incididunt enim pariatur exercitation deserunt sunt consequat quis nisi veniam do. Adipisicing voluptate occaecat id dolore duis incididunt eu occaecat tempor Lorem adipisicing. Sunt officia elit ex anim consectetur\n             proident occaecat sint amet minim et. Sit quis consequat do deserunt sunt. Sunt aliquip esse id aliqua esse esse commodo excepteur ea aliqua labore quis cillum.	2023-05-28	6450	10	t	produitJj6w4	18	t
13	\N	12	Medhurst-Baumbach	 Irure elit Lorem incididunt enim pariatur exercitation deserunt sunt consequat quis nisi veniam do. Adipisicing voluptate occaecat id dolore duis incididunt eu occaecat tempor Lorem adipisicing. Sunt officia elit ex anim consectetur\n             proident occaecat sint amet minim et. Sit quis consequat do deserunt sunt. Sunt aliquip esse id aliqua esse esse commodo excepteur ea aliqua labore quis cillum.	2023-05-28	8390	5	t	produitzZkO9	9	f
\.


--
-- Name: produit_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('produit_id_seq', 100, true);


--
-- Data for Name: produit_object; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY produit_object (id, produit_id, src, date_created) FROM stdin;
1	1	produitgoKvZ.png	2023-05-28
2	1	produitJeXQ1.jpg	2023-05-28
3	2	produityYzAF.jpg	2023-05-28
4	2	produitaqG48.jpg	2023-05-28
5	3	produitgoKvZ.png	2023-05-28
6	3	photo_2023-05-28_12-02-51 (2).jpg	2023-05-28
7	4	photo_2023-05-28_12-02-51 (2).jpg	2023-05-28
8	4	produitHrQl4.png	2023-05-28
9	5	produit9VBWv.jpg	2023-05-28
10	5	produitgZGWC.jpg	2023-05-28
11	6	produitMekiO.jpg	2023-05-28
12	6	produitBfKT3.jpg	2023-05-28
13	7	produitL2Aqh.jpg	2023-05-28
14	7	produitqUV6R.png	2023-05-28
15	8	produitGroZM.jpg	2023-05-28
16	8	photo_2023-05-28_12-02-56.jpg	2023-05-28
17	9	produit2KIC5.jpg	2023-05-28
18	9	photo_2023-05-28_12-03-22.jpg	2023-05-28
19	10	photo_2023-05-28_12-04-34.jpg	2023-05-28
20	10	photo_2023-05-28_12-03-42.jpg	2023-05-28
21	11	produit2O2wt.jpg	2023-05-28
22	11	produit8KdRb.jpg	2023-05-28
23	12	produitQWv7O.jpg	2023-05-28
24	12	photo_2023-05-28_12-02-55 (2).jpg	2023-05-28
25	13	produitkzn5v.png	2023-05-28
26	13	photo_2023-05-28_12-02-55 (2).jpg	2023-05-28
27	14	produitkzn5v.png	2023-05-28
28	14	produitMekiO.jpg	2023-05-28
29	15	produitqUV6R.png	2023-05-28
30	15	photo_2023-05-28_12-00-59.jpg	2023-05-28
31	16	photo_2023-05-28_12-00-47.jpg	2023-05-28
32	16	produitBIrbD.png	2023-05-28
33	17	produit2KIC5.jpg	2023-05-28
34	17	produit2KIC5.jpg	2023-05-28
35	18	produit9VBWv.jpg	2023-05-28
36	18	photo_2023-05-28_12-04-46.jpg	2023-05-28
37	19	produit4jpVs.jpg	2023-05-28
38	19	photo_2023-05-28_12-02-58.jpg	2023-05-28
39	20	photo_2023-05-28_12-03-58.jpg	2023-05-28
40	20	photo_2023-05-28_12-02-56.jpg	2023-05-28
41	21	produit2KIC5.jpg	2023-05-28
42	21	photo_2023-05-28_11-59-11.jpg	2023-05-28
43	22	produit0EwJy.jpg	2023-05-28
44	22	photo_2023-05-28_12-02-35.jpg	2023-05-28
45	23	produitzhhbz.jpg	2023-05-28
46	23	photo_2023-05-28_12-03-15.jpg	2023-05-28
47	24	produitMekiO.jpg	2023-05-28
48	24	produitTbEIB.jpg	2023-05-28
49	25	photo_2023-05-15_21-12-16.jpg	2023-05-28
50	25	produitHrQl4.png	2023-05-28
51	26	produit2O2wt.jpg	2023-05-28
52	26	produitP1oeo.jpg	2023-05-28
53	27	produit2O2wt.jpg	2023-05-28
54	27	produitlfzAN.jpg	2023-05-28
55	28	produitC3XcN.jpg	2023-05-28
56	28	produith4Fun.jpg	2023-05-28
57	29	produitJeXQ1.jpg	2023-05-28
58	29	photo_2023-05-28_12-04-04.jpg	2023-05-28
59	30	photo_2023-05-28_12-02-57.jpg	2023-05-28
60	30	produitGroZM.jpg	2023-05-28
61	31	produitqUV6R.png	2023-05-28
62	31	photo_2023-05-28_12-04-13.jpg	2023-05-28
63	32	photo_2023-05-28_12-01-15.jpg	2023-05-28
64	32	photo_2023-05-28_11-59-11.jpg	2023-05-28
65	33	photo_2023-05-28_12-02-53 (2).jpg	2023-05-28
66	33	photo_2023-05-28_12-02-40.jpg	2023-05-28
67	34	photo_2023-05-28_12-03-25.jpg	2023-05-28
68	34	produit8KdRb.jpg	2023-05-28
69	35	produitJeXQ1.jpg	2023-05-28
70	35	produit9VBWv.jpg	2023-05-28
71	36	photo_2023-05-28_12-02-57.jpg	2023-05-28
72	36	photo_2023-05-28_12-02-55 (2).jpg	2023-05-28
73	37	photo_2023-05-28_12-03-24.jpg	2023-05-28
74	37	produitTbEIB.jpg	2023-05-28
75	38	produitKSujd.png	2023-05-28
76	38	produitGA0OM.jpg	2023-05-28
77	39	produitQWv7O.jpg	2023-05-28
78	39	produitHrQl4.png	2023-05-28
79	40	produit1fj4S.jpg	2023-05-28
80	40	produit4jpVs.jpg	2023-05-28
81	41	produitGA0OM.jpg	2023-05-28
82	41	produitcmt4I.jpg	2023-05-28
83	42	photo_2023-05-28_12-04-09.jpg	2023-05-28
84	42	photo_2023-05-28_12-02-54.jpg	2023-05-28
85	43	photo_2023-05-28_12-01-20.jpg	2023-05-28
86	43	produit4jpVs.jpg	2023-05-28
87	44	photo_2023-05-28_12-00-59.jpg	2023-05-28
88	44	photo_2023-05-28_12-02-51 (2).jpg	2023-05-28
89	45	produitaqG48.jpg	2023-05-28
90	45	produitBIrbD.png	2023-05-28
91	46	photo_2023-05-28_12-04-13.jpg	2023-05-28
92	46	produitbN086.jpg	2023-05-28
93	47	produitPMBtS.jpg	2023-05-28
94	47	produitBfKT3.jpg	2023-05-28
95	48	produitKSujd.png	2023-05-28
96	48	produitqUV6R.png	2023-05-28
97	49	photo_2023-05-28_12-02-51.jpg	2023-05-28
98	49	produitFHmAD.png	2023-05-28
99	50	produitHrQl4.png	2023-05-28
100	50	produit0llgU.jpg	2023-05-28
101	51	produitJeXQ1.jpg	2023-05-28
102	51	produitgoKvZ.png	2023-05-28
103	52	produitC3XcN.jpg	2023-05-28
104	52	photo_2023-05-28_12-02-38.jpg	2023-05-28
105	53	produitwukmo.jpg	2023-05-28
106	53	produit61FpZ.jpg	2023-05-28
107	54	produitP1oeo.jpg	2023-05-28
108	54	photo_2023-05-28_12-02-38.jpg	2023-05-28
109	55	produitqknvm.jpg	2023-05-28
110	55	produitgZGWC.jpg	2023-05-28
111	56	photo_2023-05-28_12-02-58.jpg	2023-05-28
112	56	produit4Ooot.jpg	2023-05-28
113	57	produitHrQl4.png	2023-05-28
114	57	produitYooeu.jpg	2023-05-28
115	58	produitFjJOR.png	2023-05-28
116	58	produitaqG48.jpg	2023-05-28
117	59	produit4vcKU.jpg	2023-05-28
118	59	produitcmt4I.jpg	2023-05-28
119	60	photo_2023-05-28_12-03-22.jpg	2023-05-28
120	60	produitCxCpP.jpg	2023-05-28
121	61	produitY8HUz.jpg	2023-05-28
122	61	produithKA1T.png	2023-05-28
123	62	photo_2023-05-28_12-02-51 (2).jpg	2023-05-28
124	62	produitMekiO.jpg	2023-05-28
125	63	photo_2023-05-28_12-02-53.jpg	2023-05-28
126	63	produitBIrbD.png	2023-05-28
127	64	photo_2023-05-28_12-04-04.jpg	2023-05-28
128	64	photo_2023-05-28_12-03-58.jpg	2023-05-28
129	65	photo_2023-05-28_12-02-56.jpg	2023-05-28
130	65	produitL2Aqh.jpg	2023-05-28
131	66	produitKSujd.png	2023-05-28
132	66	produitkzn5v.png	2023-05-28
133	67	produithKA1T.png	2023-05-28
134	67	produitIGlHZ.jpg	2023-05-28
135	68	produitJeXQ1.jpg	2023-05-28
136	68	produitGroZM.jpg	2023-05-28
137	69	produit4vcKU.jpg	2023-05-28
138	69	photo_2023-05-28_12-02-53.jpg	2023-05-28
139	70	produitkzn5v.png	2023-05-28
140	70	produityYzAF.jpg	2023-05-28
141	71	photo_2023-05-28_12-00-59.jpg	2023-05-28
142	71	produit4Ooot.jpg	2023-05-28
143	72	photo_2023-05-28_12-00-47.jpg	2023-05-28
144	72	photo_2023-05-28_12-04-04.jpg	2023-05-28
145	73	produitwukmo.jpg	2023-05-28
146	73	produitY8HUz.jpg	2023-05-28
147	74	photo_2023-05-28_12-02-42.jpg	2023-05-28
148	74	photo_2023-05-28_12-02-55 (2).jpg	2023-05-28
149	75	photo_2023-05-15_21-12-16.jpg	2023-05-28
150	75	produit8EIdh.jpg	2023-05-28
151	76	produit4jpVs.jpg	2023-05-28
152	76	photo_2023-05-15_21-12-16.jpg	2023-05-28
153	77	produitgoKvZ.png	2023-05-28
154	77	photo_2023-05-28_12-02-55.jpg	2023-05-28
155	78	produit61FpZ.jpg	2023-05-28
156	78	photo_2023-05-28_12-02-40.jpg	2023-05-28
157	79	photo_2023-05-28_11-59-11.jpg	2023-05-28
158	79	produit4jpVs.jpg	2023-05-28
159	80	photo_2023-05-28_12-02-38.jpg	2023-05-28
160	80	produitu87I2.png	2023-05-28
161	81	produitd5vz5.jpg	2023-05-28
162	81	produit4Ooot.jpg	2023-05-28
163	82	photo_2023-05-28_12-01-15.jpg	2023-05-28
164	82	produit9VBWv.jpg	2023-05-28
165	83	produit4Ooot.jpg	2023-05-28
166	83	produit2O2wt.jpg	2023-05-28
167	84	produitu87I2.png	2023-05-28
168	84	produith4Fun.jpg	2023-05-28
169	85	produithKA1T.png	2023-05-28
170	85	produitKSujd.png	2023-05-28
171	86	photo_2023-05-15_21-12-16.jpg	2023-05-28
172	86	photo_2023-05-28_12-04-09.jpg	2023-05-28
173	87	photo_2023-05-28_11-59-11.jpg	2023-05-28
174	87	photo_2023-05-28_12-04-09.jpg	2023-05-28
175	88	photo_2023-05-28_12-02-42.jpg	2023-05-28
176	88	produittveeR.jpg	2023-05-28
177	89	produitB9q4r.jpg	2023-05-28
178	89	photo_2023-05-28_12-03-42.jpg	2023-05-28
179	90	produitKSujd.png	2023-05-28
180	90	produitcmt4I.jpg	2023-05-28
181	91	photo_2023-05-15_21-12-16.jpg	2023-05-28
182	91	photo_2023-05-28_12-02-58.jpg	2023-05-28
183	92	produitY8HUz.jpg	2023-05-28
184	92	photo_2023-05-28_12-04-46.jpg	2023-05-28
185	93	produitJeXQ1.jpg	2023-05-28
186	93	photo_2023-05-28_12-04-13.jpg	2023-05-28
187	94	photo_2023-05-28_12-02-57.jpg	2023-05-28
188	94	photo_2023-05-28_12-02-51.jpg	2023-05-28
189	95	photo_2023-05-28_12-03-58.jpg	2023-05-28
190	95	photo_2023-05-28_12-02-58.jpg	2023-05-28
191	96	photo_2023-05-28_12-03-31.jpg	2023-05-28
192	96	produitu87I2.png	2023-05-28
193	97	produitlfzAN.jpg	2023-05-28
194	97	photo_2023-05-28_12-03-58.jpg	2023-05-28
195	98	photo_2023-05-28_12-00-59.jpg	2023-05-28
196	98	produitP1oeo.jpg	2023-05-28
197	99	produitzhhbz.jpg	2023-05-28
198	99	photo_2023-05-28_12-03-24.jpg	2023-05-28
199	100	photo_2023-05-28_12-03-42.jpg	2023-05-28
200	100	produitCxCpP.jpg	2023-05-28
\.


--
-- Name: produit_object_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('produit_object_id_seq', 200, true);


--
-- Data for Name: promotion; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY promotion (id, libelle, date_created) FROM stdin;
\.


--
-- Name: promotion_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('promotion_id_seq', 1, false);


--
-- Data for Name: short; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY short (id, boutique_id, src, titre, status, description, date_created, preview) FROM stdin;
21	11	3bcc97592a015af326f60cafef56b25b.mp4	Dach-Nienow	t	Irure elit Lorem incididunt enim pariatur exercitation deserunt sunt consequat quis nisi veniam do. Adipisicing voluptate occaecat id dolore duis incididunt eu occaecat tempor Lorem adipisicing. Sunt officia elit ex anim consectetur\n             proident occaec 	2023-05-28	\N
22	15	5d161e64fd4accf2e59fb6f2953cf5eb.mp4	Quigley-Doyle	t	Irure elit Lorem incididunt enim pariatur exercitation deserunt sunt consequat quis nisi veniam do. Adipisicing voluptate occaecat id dolore duis incididunt eu occaecat tempor Lorem adipisicing. Sunt officia elit ex anim consectetur\n             proident occaec 	2023-05-28	\N
23	20	6dd9d072b51e57060fdd9e64cd437c24.mp4	Moore-Ward	t	Irure elit Lorem incididunt enim pariatur exercitation deserunt sunt consequat quis nisi veniam do. Adipisicing voluptate occaecat id dolore duis incididunt eu occaecat tempor Lorem adipisicing. Sunt officia elit ex anim consectetur\n             proident occaec 	2023-05-28	\N
24	11	produitR6KAe.mp4	Nikolaus-Cronin	t	Irure elit Lorem incididunt enim pariatur exercitation deserunt sunt consequat quis nisi veniam do. Adipisicing voluptate occaecat id dolore duis incididunt eu occaecat tempor Lorem adipisicing. Sunt officia elit ex anim consectetur\n             proident occaec 	2023-05-28	\N
25	19	5d161e64fd4accf2e59fb6f2953cf5eb.mp4	Torp, Treutel and Mayer	t	Irure elit Lorem incididunt enim pariatur exercitation deserunt sunt consequat quis nisi veniam do. Adipisicing voluptate occaecat id dolore duis incididunt eu occaecat tempor Lorem adipisicing. Sunt officia elit ex anim consectetur\n             proident occaec 	2023-05-28	\N
26	15	produitWxCZH.mp4	Balistreri, Lynch and Berge	t	Irure elit Lorem incididunt enim pariatur exercitation deserunt sunt consequat quis nisi veniam do. Adipisicing voluptate occaecat id dolore duis incididunt eu occaecat tempor Lorem adipisicing. Sunt officia elit ex anim consectetur\n             proident occaec 	2023-05-28	\N
27	11	produitZt0RX.mp4	Barrows Ltd	t	Irure elit Lorem incididunt enim pariatur exercitation deserunt sunt consequat quis nisi veniam do. Adipisicing voluptate occaecat id dolore duis incididunt eu occaecat tempor Lorem adipisicing. Sunt officia elit ex anim consectetur\n             proident occaec 	2023-05-28	\N
28	19	produitZt0RX.mp4	Medhurst-Dare	t	Irure elit Lorem incididunt enim pariatur exercitation deserunt sunt consequat quis nisi veniam do. Adipisicing voluptate occaecat id dolore duis incididunt eu occaecat tempor Lorem adipisicing. Sunt officia elit ex anim consectetur\n             proident occaec 	2023-05-28	\N
29	11	4f2c7547a40e47763d618fd37b7dbd2a.mp4	Emmerich-Miller	t	Irure elit Lorem incididunt enim pariatur exercitation deserunt sunt consequat quis nisi veniam do. Adipisicing voluptate occaecat id dolore duis incididunt eu occaecat tempor Lorem adipisicing. Sunt officia elit ex anim consectetur\n             proident occaec 	2023-05-28	\N
30	14	produitR6KAe.mp4	Schowalter, DuBuque and Wunsch	t	Irure elit Lorem incididunt enim pariatur exercitation deserunt sunt consequat quis nisi veniam do. Adipisicing voluptate occaecat id dolore duis incididunt eu occaecat tempor Lorem adipisicing. Sunt officia elit ex anim consectetur\n             proident occaec 	2023-05-28	\N
31	16	produitWxCZH.mp4	Bashirian-Hilll	t	Irure elit Lorem incididunt enim pariatur exercitation deserunt sunt consequat quis nisi veniam do. Adipisicing voluptate occaecat id dolore duis incididunt eu occaecat tempor Lorem adipisicing. Sunt officia elit ex anim consectetur\n             proident occaec 	2023-05-28	\N
32	18	0c969b1001a9c4c647c844dc2ceeb18f.mp4	Leffler-Rodriguez	t	Irure elit Lorem incididunt enim pariatur exercitation deserunt sunt consequat quis nisi veniam do. Adipisicing voluptate occaecat id dolore duis incididunt eu occaecat tempor Lorem adipisicing. Sunt officia elit ex anim consectetur\n             proident occaec 	2023-05-28	\N
33	15	7a00378706b1e64865063f8549e66b10.mp4	Schimmel, Fritsch and Dickens	t	Irure elit Lorem incididunt enim pariatur exercitation deserunt sunt consequat quis nisi veniam do. Adipisicing voluptate occaecat id dolore duis incididunt eu occaecat tempor Lorem adipisicing. Sunt officia elit ex anim consectetur\n             proident occaec 	2023-05-28	\N
34	15	6dd9d072b51e57060fdd9e64cd437c24.mp4	Oberbrunner-DuBuque	t	Irure elit Lorem incididunt enim pariatur exercitation deserunt sunt consequat quis nisi veniam do. Adipisicing voluptate occaecat id dolore duis incididunt eu occaecat tempor Lorem adipisicing. Sunt officia elit ex anim consectetur\n             proident occaec 	2023-05-28	\N
35	15	0c969b1001a9c4c647c844dc2ceeb18f.mp4	Fahey, Walsh and Torphy	t	Irure elit Lorem incididunt enim pariatur exercitation deserunt sunt consequat quis nisi veniam do. Adipisicing voluptate occaecat id dolore duis incididunt eu occaecat tempor Lorem adipisicing. Sunt officia elit ex anim consectetur\n             proident occaec 	2023-05-28	\N
36	11	produitR6KAe.mp4	Streich-Schuppe	t	Irure elit Lorem incididunt enim pariatur exercitation deserunt sunt consequat quis nisi veniam do. Adipisicing voluptate occaecat id dolore duis incididunt eu occaecat tempor Lorem adipisicing. Sunt officia elit ex anim consectetur\n             proident occaec 	2023-05-28	\N
37	17	6dd9d072b51e57060fdd9e64cd437c24.mp4	Goyette-Bradtke	t	Irure elit Lorem incididunt enim pariatur exercitation deserunt sunt consequat quis nisi veniam do. Adipisicing voluptate occaecat id dolore duis incididunt eu occaecat tempor Lorem adipisicing. Sunt officia elit ex anim consectetur\n             proident occaec 	2023-05-28	\N
38	15	produitR6KAe.mp4	Ortiz-Herman	t	Irure elit Lorem incididunt enim pariatur exercitation deserunt sunt consequat quis nisi veniam do. Adipisicing voluptate occaecat id dolore duis incididunt eu occaecat tempor Lorem adipisicing. Sunt officia elit ex anim consectetur\n             proident occaec 	2023-05-28	\N
39	20	produitR6KAe.mp4	Wilderman-Deckow	t	Irure elit Lorem incididunt enim pariatur exercitation deserunt sunt consequat quis nisi veniam do. Adipisicing voluptate occaecat id dolore duis incididunt eu occaecat tempor Lorem adipisicing. Sunt officia elit ex anim consectetur\n             proident occaec 	2023-05-28	\N
40	17	produitZt0RX.mp4	Konopelski PLC	t	Irure elit Lorem incididunt enim pariatur exercitation deserunt sunt consequat quis nisi veniam do. Adipisicing voluptate occaecat id dolore duis incididunt eu occaecat tempor Lorem adipisicing. Sunt officia elit ex anim consectetur\n             proident occaec 	2023-05-28	\N
41	17	5d161e64fd4accf2e59fb6f2953cf5eb.mp4	Pfeffer PLC	t	Irure elit Lorem incididunt enim pariatur exercitation deserunt sunt consequat quis nisi veniam do. Adipisicing voluptate occaecat id dolore duis incididunt eu occaecat tempor Lorem adipisicing. Sunt officia elit ex anim consectetur\n             proident occaec 	2023-05-28	\N
42	25	produitR6KAe.mp4	Orn PLC	t	Irure elit Lorem incididunt enim pariatur exercitation deserunt sunt consequat quis nisi veniam do. Adipisicing voluptate occaecat id dolore duis incididunt eu occaecat tempor Lorem adipisicing. Sunt officia elit ex anim consectetur\n             proident occaec 	2023-05-28	\N
43	30	produitZt0RX.mp4	Spinka, Haley and Lind	t	Irure elit Lorem incididunt enim pariatur exercitation deserunt sunt consequat quis nisi veniam do. Adipisicing voluptate occaecat id dolore duis incididunt eu occaecat tempor Lorem adipisicing. Sunt officia elit ex anim consectetur\n             proident occaec 	2023-05-28	\N
44	18	produitWxCZH.mp4	Kris-Nikolaus	t	Irure elit Lorem incididunt enim pariatur exercitation deserunt sunt consequat quis nisi veniam do. Adipisicing voluptate occaecat id dolore duis incididunt eu occaecat tempor Lorem adipisicing. Sunt officia elit ex anim consectetur\n             proident occaec 	2023-05-28	\N
45	22	produitR6KAe.mp4	Runte, Considine and Breitenberg	t	Irure elit Lorem incididunt enim pariatur exercitation deserunt sunt consequat quis nisi veniam do. Adipisicing voluptate occaecat id dolore duis incididunt eu occaecat tempor Lorem adipisicing. Sunt officia elit ex anim consectetur\n             proident occaec 	2023-05-28	\N
46	16	5d161e64fd4accf2e59fb6f2953cf5eb.mp4	Koelpin Ltd	t	Irure elit Lorem incididunt enim pariatur exercitation deserunt sunt consequat quis nisi veniam do. Adipisicing voluptate occaecat id dolore duis incididunt eu occaecat tempor Lorem adipisicing. Sunt officia elit ex anim consectetur\n             proident occaec 	2023-05-28	\N
47	25	4f2c7547a40e47763d618fd37b7dbd2a.mp4	Runolfsdottir, Blick and Kassulke	t	Irure elit Lorem incididunt enim pariatur exercitation deserunt sunt consequat quis nisi veniam do. Adipisicing voluptate occaecat id dolore duis incididunt eu occaecat tempor Lorem adipisicing. Sunt officia elit ex anim consectetur\n             proident occaec 	2023-05-28	\N
48	17	3bcc97592a015af326f60cafef56b25b.mp4	Toy-Hettinger	t	Irure elit Lorem incididunt enim pariatur exercitation deserunt sunt consequat quis nisi veniam do. Adipisicing voluptate occaecat id dolore duis incididunt eu occaecat tempor Lorem adipisicing. Sunt officia elit ex anim consectetur\n             proident occaec 	2023-05-28	\N
49	27	6dd9d072b51e57060fdd9e64cd437c24.mp4	Romaguera-Cassin	t	Irure elit Lorem incididunt enim pariatur exercitation deserunt sunt consequat quis nisi veniam do. Adipisicing voluptate occaecat id dolore duis incididunt eu occaecat tempor Lorem adipisicing. Sunt officia elit ex anim consectetur\n             proident occaec 	2023-05-28	\N
50	17	5d161e64fd4accf2e59fb6f2953cf5eb.mp4	Schumm LLC	t	Irure elit Lorem incididunt enim pariatur exercitation deserunt sunt consequat quis nisi veniam do. Adipisicing voluptate occaecat id dolore duis incididunt eu occaecat tempor Lorem adipisicing. Sunt officia elit ex anim consectetur\n             proident occaec 	2023-05-28	\N
51	19	6dd9d072b51e57060fdd9e64cd437c24.mp4	Gulgowski-Herman	t	Irure elit Lorem incididunt enim pariatur exercitation deserunt sunt consequat quis nisi veniam do. Adipisicing voluptate occaecat id dolore duis incididunt eu occaecat tempor Lorem adipisicing. Sunt officia elit ex anim consectetur\n             proident occaec 	2023-05-28	\N
52	19	6dd9d072b51e57060fdd9e64cd437c24.mp4	Heaney-Walter	t	Irure elit Lorem incididunt enim pariatur exercitation deserunt sunt consequat quis nisi veniam do. Adipisicing voluptate occaecat id dolore duis incididunt eu occaecat tempor Lorem adipisicing. Sunt officia elit ex anim consectetur\n             proident occaec 	2023-05-28	\N
53	25	produitZt0RX.mp4	Gutmann, Ferry and Effertz	t	Irure elit Lorem incididunt enim pariatur exercitation deserunt sunt consequat quis nisi veniam do. Adipisicing voluptate occaecat id dolore duis incididunt eu occaecat tempor Lorem adipisicing. Sunt officia elit ex anim consectetur\n             proident occaec 	2023-05-28	\N
54	22	3bcc97592a015af326f60cafef56b25b.mp4	Walter-Leuschke	t	Irure elit Lorem incididunt enim pariatur exercitation deserunt sunt consequat quis nisi veniam do. Adipisicing voluptate occaecat id dolore duis incididunt eu occaecat tempor Lorem adipisicing. Sunt officia elit ex anim consectetur\n             proident occaec 	2023-05-28	\N
55	19	produitWxCZH.mp4	Donnelly, Romaguera and Purdy	t	Irure elit Lorem incididunt enim pariatur exercitation deserunt sunt consequat quis nisi veniam do. Adipisicing voluptate occaecat id dolore duis incididunt eu occaecat tempor Lorem adipisicing. Sunt officia elit ex anim consectetur\n             proident occaec 	2023-05-28	\N
56	21	produitZt0RX.mp4	Harber, Satterfield and Doyle	t	Irure elit Lorem incididunt enim pariatur exercitation deserunt sunt consequat quis nisi veniam do. Adipisicing voluptate occaecat id dolore duis incididunt eu occaecat tempor Lorem adipisicing. Sunt officia elit ex anim consectetur\n             proident occaec 	2023-05-28	\N
57	30	0ccc5e58031d7ed1e56e5e0bc99e6aea.mp4	Hackett-Witting	t	Irure elit Lorem incididunt enim pariatur exercitation deserunt sunt consequat quis nisi veniam do. Adipisicing voluptate occaecat id dolore duis incididunt eu occaecat tempor Lorem adipisicing. Sunt officia elit ex anim consectetur\n             proident occaec 	2023-05-28	\N
58	13	4f2c7547a40e47763d618fd37b7dbd2a.mp4	Lockman Ltd	t	Irure elit Lorem incididunt enim pariatur exercitation deserunt sunt consequat quis nisi veniam do. Adipisicing voluptate occaecat id dolore duis incididunt eu occaecat tempor Lorem adipisicing. Sunt officia elit ex anim consectetur\n             proident occaec 	2023-05-28	\N
59	24	7a00378706b1e64865063f8549e66b10.mp4	Marks, Christiansen and Bergstrom	t	Irure elit Lorem incididunt enim pariatur exercitation deserunt sunt consequat quis nisi veniam do. Adipisicing voluptate occaecat id dolore duis incididunt eu occaecat tempor Lorem adipisicing. Sunt officia elit ex anim consectetur\n             proident occaec 	2023-05-28	\N
60	21	6dd9d072b51e57060fdd9e64cd437c24.mp4	Wisozk-Legros	t	Irure elit Lorem incididunt enim pariatur exercitation deserunt sunt consequat quis nisi veniam do. Adipisicing voluptate occaecat id dolore duis incididunt eu occaecat tempor Lorem adipisicing. Sunt officia elit ex anim consectetur\n             proident occaec 	2023-05-28	\N
62	11	produit9sqGq.mp4	titre	t	690863838	2023-06-21	\N
63	11	produitJyLOy.mp4	titre	t	690863838	2023-06-21	\N
\.


--
-- Name: short_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('short_id_seq', 63, true);


--
-- Data for Name: transaction; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY transaction (id, client_id, panier_id, mode_paiement_id, type_transaction_id, libelle, montant, token, date_create, status, nom_client, prenom_client, numero_client) FROM stdin;
1	1	\N	1	3	Depot	1000	p.dfI7cNk4tWLe8Bk4TjV9qiJww5L2V2J5J8Z0IqEribi4jqYlRiY6VhCbTdkuHy9h7tGB32QaNS8TmSQmEZ5Wc20o6qd5CcmL	2023-05-28 13:12:19	t	admin	mouafo	690863838
7	1	\N	1	3	Depot	1500	p.JUyJIv4ryGaHpIxGNn4ev6wDJtKPmcX1TRF5OuuSuDUbk1LjubsEnB2RVe7cOcXbWFT1ZVePvWpNtxYbiY49U94T6YQlrFUR	2023-05-31 20:26:40	t	admin	mouafo	690863838
8	1	\N	1	3	Depot	1500	p.mW4FIDxGrw01Li8yOwxDzkhok0FuxAEav2VwquVGM1h4DHPfIp6bEmLrX0862wSR3BdVlo51GU8sKYbtwH4MEGMP44Lzx7XY	2023-05-31 20:29:36	t	admin	mouafo	690863838
9	1	\N	1	3	Depot	1500	p.P6SwGJLhNn6T9YRO3g1SpKDjeG67fAVJxO6YFchiJ0L0EvCnHXhIFVjFGilhuYsU9oW84Pmy87edbiJ5GPD33p1S67lhfv4r	2023-05-31 20:31:17	t	admin	mouafo	690863838
10	1	\N	1	3	Depot	1500	p.sDs4DAjAHSuLVgha3M78XiE6PMd2y8VGU5HgWfw7iQ3a7UIro1umCzusJVP5CbPUN6v9gCKpcNy1MPFGX40fAhYLwmtVJpEU	2023-05-31 20:32:36	t	admin	mouafo	690863838
11	1	\N	1	3	Depot	5000	p.QOMxwumNjFgrCbpRQJXMzBUJ6r5TUTHJBdscUP8v5832mccaKNgoKvPmOy6bGV9r145g0wwfvR8IpTq6mDYMGNl2QOyoRygx	2023-05-31 20:35:08	t	admin	mouafo	690863838
12	1	\N	1	3	Depot	1500	p.ghRKhqFyCxv0UAJ0ZYl6jtUR3VMdlkEqMftIuhZwIwKnQ76ebmFKvyxskBnmLh8surhSx8gA6hruZbJf2T3Eu8QLiCl9EqpA	2023-05-31 20:38:07	t	admin	mouafo	690863838
13	1	\N	1	3	Depot	5000	p.N3EMp0soYAFeg6BwsrLcDTfySOsPOiKF5waDmdp958O0onmUqtiV4W4VTfchdU8DcPBWjQaTmXZIJRI6dFVHgDNxfmSmRFiw	2023-06-04 10:00:33	f	admin	mouafo	690863838
\.


--
-- Name: transaction_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('transaction_id_seq', 13, true);


--
-- Data for Name: type_commande; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY type_commande (id, libelle) FROM stdin;
1	commande normale
2	commande negocie
\.


--
-- Name: type_commande_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('type_commande_id_seq', 1, false);


--
-- Data for Name: type_paiement; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY type_paiement (id, libelle) FROM stdin;
1	livreur
2	Boutique
\.


--
-- Name: type_paiement_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('type_paiement_id_seq', 1, false);


--
-- Data for Name: type_transaction; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY type_transaction (id, libelle) FROM stdin;
1	Achat
2	Retrait
3	Depot
\.


--
-- Name: type_transaction_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('type_transaction_id_seq', 1, false);


--
-- Data for Name: type_user; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY type_user (id, libelle, status) FROM stdin;
1	admin	t
2	client	t
3	livreur	t
\.


--
-- Name: type_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('type_user_id_seq', 1, false);


--
-- Data for Name: user_plateform; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY user_plateform (id, type_user_id, nom, prenom, email, roles, phone, status, password, date_created, key_secret, code_parrain, code_recup) FROM stdin;
2	3	Toche	Hermann 	h@h.com	["ROLE_USER"]	650863838	t	$2y$13$EPYqK4p5UszFfrj3IHEvAu3AYV4JQZZgVkQZD9G4//rDiwIBYxG8G	2022-12-16	12341	\N	\N
3	3	Estou	shouki	h@h.com	["ROLE_USER"]	693087868	t	$2y$13$EPYqK4p5UszFfrj3IHEvAu3AYV4JQZZgVkQZD9G4//rDiwIBYxG8G	2022-12-16	12349	\N	\N
13	2	romi	ari		["ROLE_USER"]	655555555	t	$2y$13$nr9cVGdP59Smy7VlaVHLiONoyy0x5fozz/csd0Qy2rNCwK7cjclfu	2023-01-24	$2y$10$9l17jYzqnWSWgopVTkdx9uN2eWYNOpOlKvVS38JBVUK9W3dHevcv.	\N	\N
14	2	hgg	hh		["ROLE_USER"]	5455	t	$2y$13$NM9mOsqcZ7mzJTuRX6JmfujHw1GoNLJNBmpVuBz/mP7HTheseCOsK	2023-01-24	$2y$10$nkf5cGMWduqLI2FvigyHZ.97No8i3qzDuFRzisAZoRIRHA6By09oK	\N	\N
17	2	rr	uy		["ROLE_USER"]	424	t	$2y$13$y5CIhrLmXAYLXJ0I6BdfoesO8O1MhEjET9j/2IweInBlbvbyH6pIu	2023-01-24	$2y$10$csx9mI0pyvhF6Q.4sS7YFesexF/oYGQ8QZpUpbm4qQstLs4fhR0IW	\N	\N
19	2	yrt	ggg		["ROLE_USER"]	56576766	t	$2y$13$GccQCC.V78PXDcj6M8DyL.08545fPu25i9InQs.uqkI4NPSo/R2l.	2023-03-08	$2y$10$5/ZXFNb.19o7LIyaHQtgPe5Mc2WJdTh3E3hjmJgObgl6MofOPmhxW	\N	\N
34	2	name.text	surname.text	email.text	["ROLE_USER"]	6565655	t	$2y$13$DZU5sssGyNsm0hG6/3Z12.itpzo1XF6xjMjA6kN85UEj7DNAgofNa	2023-05-10	$2y$10$XG0uWdhizLKlTBPPva.lbuLg4HxRf3BamEx7KPsCZ3yI7rf3mdFHG	\N	\N
36	2	name.text	surname.text	email.text	["ROLE_USER"]	65645	t	$2y$13$48hvKTstHFLoBJjFwrM1DO0u0KrAo0j91bCNOHZ9MNcUE8FQqPCTi	2023-05-10	$2y$10$MwO/f3ArizO4FSVk0mpEaOI7c5L9xUWJ8tkYhDLfmnhbBk8sXGp4y	\N	\N
39	2	name.text	surname.text	email.text	["ROLE_USER"]	2147483647	t	$2y$13$YxkWsa1ZNTcYFnln7Kzs3.c0nDidsvNsiyXBO44EbVGq.W5Di3ivy	2023-05-10	$2y$10$M6Ps.mF6hBZaySM5OiO70.zb2Q74VYDSgQJ4ar8FEGJmI/mIMAab2	\N	\N
60	2	name.text	surname.text	email.text	["ROLE_USER"]	70006655	t	$2y$13$KZMx6lMCvRUEgW7rOvR7vuT59ZfdGsa.uP4z4XUhhj1UmS7j2vR4G	2023-05-10	$2y$10$.QOqYS89eWFC7itDIkCJCewLmZwQRaeCvw45YNbzwK8.mBKZVo8uG	39@60	\N
62	2	name.text	surname.text	email.text	["ROLE_USER"]	464564654	t	$2y$13$5OB3ApRT9RuCS/pL0vgszuqT3Iuely0VBNW9wvAc67gvRSUI2./Fy	2023-05-10	$2y$10$r0Bj3HgaxGIXfYpGXepV8.tG8LMv9XclBk46iB.glLjWpUgG4hxhy	39@62	\N
70	2	name.text	surname.text	email.text	["ROLE_USER"]	40545	t	$2y$13$U2WieckzEhwN69lFF9nPl.cduTaA/lfQmpOrCHEmBZA/NgjhFR4Na	2023-05-11	$2y$10$ybjxAyCd.bpJpXKhYHIrueYNF.VwmJXPDcq5lic0PaxfRdQFNsQZO	39	\N
72	2	name.text	surname.text	email.text	["ROLE_USER"]	445450545	t	$2y$13$bvk8ZDfDkvMVIVTPsEyJGOHix1prk2lvlDYGOcfBE.lKtXebSpwvS	2023-05-11	$2y$10$IOeUkzhAdK9BPDzBYYZdvuXI8B6J6.YU2XcFFL8UWSWoqUrYpSYwG	39	\N
74	2	name.text	surname.text	email.text	["ROLE_USER"]	6959555	t	$2y$13$amB1NyjnAltL4Y8umN7LuOoxcQ8uHC1SDa37m8xgg89TUfN3e48mi	2023-05-11	$2y$10$T4FX.FulYWu1ZelT7ZyOE.tNz9p1VU/CurNirFDlfOD3VMjnaXALu	39	\N
76	\N	name.text	surname.text	email.text	["ROLE_USER"]	694559555	t	$2y$13$Ker0kIfhCVoIe7GzZBiXh.6/ph7kKxHr.FYTV413NQmgzXFpYApEm	2023-05-11	$2y$10$BlyleHTtUUf9hSAL0fE1uePgfmh44K/HumTJ8iDgRlzjNg9AV5Uii	39	\N
80	\N	name.text	surname.text	email.text	["ROLE_USER"]	698586868	t	$2y$13$5HSvAA62/VIpxJV69BwDlOTaVuII1c1H.2B09/MqGRtRHlX8KXQdy	2023-05-11	$2y$10$Z7wy8bOxTl83xX/mTebNguOaVygBO1KH9dkKQvmU0rn6u4OOOXCM2	39	\N
83	\N	name.text	surname.text	email.text	["ROLE_USER"]	689886868	t	$2y$13$Otzfi20UUTitUuQesE6rruR1F6VWJ/Vj0vA1sxqt2vrhOkLBVN/0y	2023-05-11	$2y$10$1ddprJjuHW8hPBBP8RLc3eEu11e2c3v6iZoc24cF4JdPcm9j.GBUW	125	\N
84	2	name.text	surname.text	email.text	["ROLE_USER"]	689886869	t	$2y$13$s6mfHtm/MJqggK.uJwu1leqOVEzPVj5y79LAazOT7QXefqnzgpiO.	2023-05-11	$2y$10$kdN4ztlYgq.4kAIH9j8zReGyRtT1yQwkaXH4jhjpZZxicnSbiRUEW	125	\N
85	2	name.text	surname.text	email.text	["ROLE_USER"]	689886069	t	$2y$13$yJKH9iZ28aRY.VwelRGXV.byrfGpo2fmZvZpAPDpBMw58kXQ43V6G	2023-05-11	$2y$10$PN1lQLl4ofNbRYpon08Z2e3SpHxhzMKR.L5W3/h4.2Wf19fIBK57e	125	\N
86	2	name.text	surname.text	email.text	["ROLE_USER"]	89886069	t	$2y$13$mK9lfiAwAizbXrWuTsjsLOtUEDPRDtgMEoseKOXPXMormaqsdbsK.	2023-05-11	$2y$10$.FWIMSxm3Pp5E2CfQ6ONVOZI/Ewt0tsTxofptCLlK.7xU.afFNlWe	125	\N
87	2	name.text	surname.text	email.text	["ROLE_USER"]	898806069	t	$2y$13$K.rLJ0ZJlH13kV/m3ZlK1OwI51gTROLUfRf0pCyEI44AyaAwSAUU.	2023-05-11	$2y$10$iW1HopjWotqI9ylOfr90U.5u0IaZ.vdli11tujbrRJIHxViGtm3VW	125	\N
89	2	name.text	surname.text	email.text	["ROLE_USER"]	848006069	t	$2y$13$jO.LsIQLBX.d3Csf9./Tc.0RxbiuLV0YiZhFkrGA074wDgS4xGJiS	2023-05-11	$2y$10$soNDLQJx.l005KzF/28TgenhbRVNbBM9GAMdltmUPhIbvrlIHrKUS	125	\N
90	2	string	string	string	["ROLE_USER"]	0	t	$2y$13$WJaB20MQ3cBFja7jJoJ63.iT3wcnqF8UGxeNGCOuLzM1yE4MEvPl2	2023-05-11	$2y$10$Krme7yFgCe0/rvXWLB2uZ.jRJ6uhvv2W8.YacxZASl4n7xWZ3XpE6	string	\N
91	2	name.text	surname.text	email.text	["ROLE_USER"]	8406069	t	$2y$13$PHWNko2yGXfgDAR139M3Aub9UjKqyx/70Eb7IP9/iLy7pbR9Vsqea	2023-05-11	$2y$10$H8ah99wwi3Qs6POL9hNxS.gWSOaymhEnAbLh3r5.vYM8Wh4xl28QK	125	\N
92	2	name.text	surname.text	email.text	["ROLE_USER"]	84060969	t	$2y$13$s1VVhj51iydJC6n3qjf4j.HM2BBTCXkTZs8pSlHduWB362i3JDAOi	2023-05-11	$2y$10$qnMVgMvFZRAhAFfMp0VLjOWNl55OdprSd5ECKE7M03wpayBCY6QHK	125	\N
93	2	name.text	surname.text	email.text	["ROLE_USER"]	6989789	t	$2y$13$/d0uBZnNJJBr8iYDG7rvsegzTDJrzmqdY65.tVqC78zsV6FTo0b/i	2023-05-11	$2y$10$zbggye2TWvEsYz7xamMSruAWbwsOGMc3SZgDLunfO0/jknDuEhprO	1	\N
94	2	name.text	surname.text	email.text	["ROLE_USER"]	69849789	t	$2y$13$BuVdeA63g6yVu8w5P2POjuEcOg6waCg7EZ06Fie0VUz1ORmVKb0gW	2023-05-11	$2y$10$E1DTeYAF51ZIndhY5HAv1eSFhIyDl1.6YGkMCmxxSLTSzHlA1gkba	1	\N
96	2	name.text	surname.text	email.text	["ROLE_USER"]	698479789	t	$2y$13$Ipk7oL8gU39q7b4dFQo2tOxaq7cluIOnjWwONrh7TCa3elRYy9aLa	2023-05-11	$2y$10$jYYpJwZDFxF3lnsjJFOEqONYwLMkKNiOcwwROqxIiWUUMy5SX60ny	1	\N
98	2	name.text	surname.text	email.text	["ROLE_USER"]	6984789	t	$2y$13$9DI3DLlUQSHNzr7qEVOUO.zXmvc4lruZ3UStdu90TsRomtaon3ib2	2023-05-11	$2y$10$Rlri5LBRb3hq0uIDi9OSjuZmUwIu/Sh7bplYR0sZLjAG7dR5PshRG	1	\N
102	2	name.text	surname.text	email.text	["ROLE_USER"]	6847809	t	$2y$13$k/kdXvXKPU96DbVfKVXdUeTaX26jcK0b4mUWzn3BEmxKbp0iPHEPe	2023-05-11	$2y$10$M5mtzfM0E7LeOp07zjfKKOnhEwgrhjoVOMZIjOIyfajTqQVRT.MfG	1	\N
1	1	admin	mouafo	h@4.com	["ROLE_USER"]	690863838	t	$2y$13$EPYqK4p5UszFfrj3IHEvAu3AYV4JQZZgVkQZD9G4//rDiwIBYxG8G	2022-12-16	1234	\N	\N
101	2	name.text	surname.text	email.text	["ROLE_USER"]	690847809	f	$2y$13$G2ebVWO313sKFrdznqTfpOc2nJOwzqlrMCliQHtEb0fJpj7gaDAXi	2023-05-11	$2y$10$WfC.EPFYXLqkVHWGRNSJAO4nxAXJ3qAK1DDPRSvekX5.Jq5hn0Qci	1	\N
16	2	hgg	hh		["ROLE_USER"]	54554	f	$2y$13$Zjci5ync10SGHECIZ6Bhruyg.KUefBfW78OdMlqo5RQfP0LFKWKIe	2023-01-24	$2y$10$TADG5sIp/Z1wqBJGUX1rw.3FDUO3JXz5FJasDNKOZsB/Gl7sbWCga	\N	\N
88	2	name.text	surname.text	email.text	["ROLE_USER"]	848806069	t	$2y$13$qtWAWuarJj1O9EgSnIICyem2tKDMXZnEP7QwA21HWixnEwn2i2FP6	2023-05-11	$2y$10$OL171wGV6Ecq3IBOzKMjfu9eRKd5pLgAd6yy8.FCULpI3.PACgidC	125	\N
12	2	Mouafo 	Ran 		["ROLE_USER"]	612345678	f	$2y$13$v.mmj4oeB88YvSQCj9WgTOfpefbDtZmoHIzmbpCj7NS/LROMUBrem	2023-01-24	$2y$10$a0JWYP.yzOThE.Ylez56MuTQOIzTccfHo7HpKNZL14HiNUiIeTm8a	\N	\N
100	1	name.text	surname.text	email.text	["ROLE_USER"]	69847809	t	$2y$13$cJnVor.IMVX0vUWp3xVfS.pnASkuQPuV/4BhZd2f/BXaxoy0Q5MXW	2023-05-11	$2y$10$f7AhXkN8csYmX41awrYc/uU9qNtGos.5Keje7Ek8u8Zr5YDVXn2ma	1	\N
\.


--
-- Name: user_plateform_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('user_plateform_id_seq', 1, false);


--
-- Name: ID; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY compte
    ADD CONSTRAINT "ID" UNIQUE (id);


--
-- Name: abonnement_boutique_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY abonnement_boutique
    ADD CONSTRAINT abonnement_boutique_pkey PRIMARY KEY (id);


--
-- Name: boutique_object_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY boutique_object
    ADD CONSTRAINT boutique_object_pkey PRIMARY KEY (id);


--
-- Name: boutique_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY boutique
    ADD CONSTRAINT boutique_pkey PRIMARY KEY (id);


--
-- Name: category_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY category
    ADD CONSTRAINT category_pkey PRIMARY KEY (id);


--
-- Name: commande_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY commande
    ADD CONSTRAINT commande_pkey PRIMARY KEY (id);


--
-- Name: commission_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY commission
    ADD CONSTRAINT commission_pkey PRIMARY KEY (id);


--
-- Name: communication_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY communication
    ADD CONSTRAINT communication_pkey PRIMARY KEY (id);


--
-- Name: compte_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY compte
    ADD CONSTRAINT compte_pkey PRIMARY KEY (id);


--
-- Name: connexion_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY connexion
    ADD CONSTRAINT connexion_pkey PRIMARY KEY (id);


--
-- Name: doctrine_migration_versions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY doctrine_migration_versions
    ADD CONSTRAINT doctrine_migration_versions_pkey PRIMARY KEY (version);


--
-- Name: historique_paiement_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY historique_paiement
    ADD CONSTRAINT historique_paiement_pkey PRIMARY KEY (id);


--
-- Name: jwt_refresh_token_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY jwt_refresh_token
    ADD CONSTRAINT jwt_refresh_token_pkey PRIMARY KEY (id);


--
-- Name: like_produit_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY like_produit
    ADD CONSTRAINT like_produit_pkey PRIMARY KEY (id);


--
-- Name: list_commande_livreur_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY list_commande_livreur
    ADD CONSTRAINT list_commande_livreur_pkey PRIMARY KEY (id);


--
-- Name: list_produit_panier_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY list_produit_panier
    ADD CONSTRAINT list_produit_panier_pkey PRIMARY KEY (id);


--
-- Name: list_produit_promotion_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY list_produit_promotion
    ADD CONSTRAINT list_produit_promotion_pkey PRIMARY KEY (id);


--
-- Name: localisation_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY localisation
    ADD CONSTRAINT localisation_pkey PRIMARY KEY (id);


--
-- Name: message_communication_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY message_communication
    ADD CONSTRAINT message_communication_pkey PRIMARY KEY (id);


--
-- Name: message_negociation_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY message_negociation
    ADD CONSTRAINT message_negociation_pkey PRIMARY KEY (id);


--
-- Name: messenger_messages_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY messenger_messages
    ADD CONSTRAINT messenger_messages_pkey PRIMARY KEY (id);


--
-- Name: mode_paiement_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY mode_paiement
    ADD CONSTRAINT mode_paiement_pkey PRIMARY KEY (id);


--
-- Name: negociation_produit_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY negociation_produit
    ADD CONSTRAINT negociation_produit_pkey PRIMARY KEY (id);


--
-- Name: notation_boutique_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY notation_boutique
    ADD CONSTRAINT notation_boutique_pkey PRIMARY KEY (id);


--
-- Name: notification_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY notification
    ADD CONSTRAINT notification_pkey PRIMARY KEY (id);


--
-- Name: panier_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY panier
    ADD CONSTRAINT panier_pkey PRIMARY KEY (id);


--
-- Name: point_livraison_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY point_livraison
    ADD CONSTRAINT point_livraison_pkey PRIMARY KEY (id);


--
-- Name: produit_object_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY produit_object
    ADD CONSTRAINT produit_object_pkey PRIMARY KEY (id);


--
-- Name: produit_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY produit
    ADD CONSTRAINT produit_pkey PRIMARY KEY (id);


--
-- Name: promotion_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY promotion
    ADD CONSTRAINT promotion_pkey PRIMARY KEY (id);


--
-- Name: short_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY short
    ADD CONSTRAINT short_pkey PRIMARY KEY (id);


--
-- Name: transaction_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY transaction
    ADD CONSTRAINT transaction_pkey PRIMARY KEY (id);


--
-- Name: type_commande_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY type_commande
    ADD CONSTRAINT type_commande_pkey PRIMARY KEY (id);


--
-- Name: type_paiement_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY type_paiement
    ADD CONSTRAINT type_paiement_pkey PRIMARY KEY (id);


--
-- Name: type_transaction_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY type_transaction
    ADD CONSTRAINT type_transaction_pkey PRIMARY KEY (id);


--
-- Name: type_user_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY type_user
    ADD CONSTRAINT type_user_pkey PRIMARY KEY (id);


--
-- Name: user_plateform_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY user_plateform
    ADD CONSTRAINT user_plateform_pkey PRIMARY KEY (id);


--
-- Name: idx_24cc0df2a76ed395; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX idx_24cc0df2a76ed395 ON panier USING btree (user_id);


--
-- Name: idx_29a5ec2712469de2; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX idx_29a5ec2712469de2 ON produit USING btree (category_id);


--
-- Name: idx_29a5ec27ab677be6; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX idx_29a5ec27ab677be6 ON produit USING btree (boutique_id);


--
-- Name: idx_5fff60d6f347efb; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX idx_5fff60d6f347efb ON produit_object USING btree (produit_id);


--
-- Name: idx_6eeaa67d438f5b63; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX idx_6eeaa67d438f5b63 ON commande USING btree (mode_paiement_id);


--
-- Name: idx_6eeaa67d78db0241; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX idx_6eeaa67d78db0241 ON commande USING btree (point_livraison_id);


--
-- Name: idx_6eeaa67dc9f3f9c5; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX idx_6eeaa67dc9f3f9c5 ON commande USING btree (type_commande_id);


--
-- Name: idx_6eeaa67df77d927c; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX idx_6eeaa67df77d927c ON commande USING btree (panier_id);


--
-- Name: idx_710402ec615593e9; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX idx_710402ec615593e9 ON historique_paiement USING btree (type_paiement_id);


--
-- Name: idx_710402ec82ea2e54; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX idx_710402ec82ea2e54 ON historique_paiement USING btree (commande_id);


--
-- Name: idx_710402eca76ed395; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX idx_710402eca76ed395 ON historique_paiement USING btree (user_id);


--
-- Name: idx_723705d119eb6921; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX idx_723705d119eb6921 ON transaction USING btree (client_id);


--
-- Name: idx_723705d1438f5b63; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX idx_723705d1438f5b63 ON transaction USING btree (mode_paiement_id);


--
-- Name: idx_723705d17903e29b; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX idx_723705d17903e29b ON transaction USING btree (type_transaction_id);


--
-- Name: idx_723705d1f77d927c; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX idx_723705d1f77d927c ON transaction USING btree (panier_id);


--
-- Name: idx_75ea56e016ba31db; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX idx_75ea56e016ba31db ON messenger_messages USING btree (delivered_at);


--
-- Name: idx_75ea56e0e3bd61ce; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX idx_75ea56e0e3bd61ce ON messenger_messages USING btree (available_at);


--
-- Name: idx_75ea56e0fb7336f0; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX idx_75ea56e0fb7336f0 ON messenger_messages USING btree (queue_name);


--
-- Name: idx_7a28a60419eb6921; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX idx_7a28a60419eb6921 ON like_produit USING btree (client_id);


--
-- Name: idx_7a28a604f347efb; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX idx_7a28a604f347efb ON like_produit USING btree (produit_id);


--
-- Name: idx_7b281e2419eb6921; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX idx_7b281e2419eb6921 ON notation_boutique USING btree (client_id);


--
-- Name: idx_7b281e24ab677be6; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX idx_7b281e24ab677be6 ON notation_boutique USING btree (boutique_id);


--
-- Name: idx_8f2890a2ab677be6; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX idx_8f2890a2ab677be6 ON short USING btree (boutique_id);


--
-- Name: idx_936bf99ca76ed395; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX idx_936bf99ca76ed395 ON connexion USING btree (user_id);


--
-- Name: idx_a1223c5412469de2; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX idx_a1223c5412469de2 ON boutique USING btree (category_id);


--
-- Name: idx_a1223c54a76ed395; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX idx_a1223c54a76ed395 ON boutique USING btree (user_id);


--
-- Name: idx_a1223c54c68be09c; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX idx_a1223c54c68be09c ON boutique USING btree (localisation_id);


--
-- Name: idx_a629619382ea2e54; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX idx_a629619382ea2e54 ON list_commande_livreur USING btree (commande_id);


--
-- Name: idx_a6296193f8646701; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX idx_a6296193f8646701 ON list_commande_livreur USING btree (livreur_id);


--
-- Name: idx_aac86140f347efb; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX idx_aac86140f347efb ON list_produit_panier USING btree (produit_id);


--
-- Name: idx_aac86140f77d927c; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX idx_aac86140f77d927c ON list_produit_panier USING btree (panier_id);


--
-- Name: idx_b002f3931c2d1e0c; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX idx_b002f3931c2d1e0c ON message_communication USING btree (communication_id);


--
-- Name: idx_b002f39356d142fc; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX idx_b002f39356d142fc ON message_communication USING btree (initiateur_id);


--
-- Name: idx_bb6a4419ab677be6; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX idx_bb6a4419ab677be6 ON boutique_object USING btree (boutique_id);


--
-- Name: idx_bf5476caa76ed395; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX idx_bf5476caa76ed395 ON notification USING btree (user_id);


--
-- Name: idx_bfd3ce8fa76ed395; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX idx_bfd3ce8fa76ed395 ON localisation USING btree (user_id);


--
-- Name: idx_c9e2b793139df194; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX idx_c9e2b793139df194 ON list_produit_promotion USING btree (promotion_id);


--
-- Name: idx_c9e2b793f347efb; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX idx_c9e2b793f347efb ON list_produit_promotion USING btree (produit_id);


--
-- Name: idx_cff65260a76ed395; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX idx_cff65260a76ed395 ON compte USING btree (user_id);


--
-- Name: idx_d59e692156d142fc; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX idx_d59e692156d142fc ON message_negociation USING btree (initiateur_id);


--
-- Name: idx_d59e6921a2d1d3d7; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX idx_d59e6921a2d1d3d7 ON message_negociation USING btree (negociation_id);


--
-- Name: idx_e0eeb46c56d142fc; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX idx_e0eeb46c56d142fc ON negociation_produit USING btree (initiateur_id);


--
-- Name: idx_e0eeb46cf347efb; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX idx_e0eeb46cf347efb ON negociation_produit USING btree (produit_id);


--
-- Name: idx_e22b878319eb6921; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX idx_e22b878319eb6921 ON abonnement_boutique USING btree (client_id);


--
-- Name: idx_e22b8783ab677be6; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX idx_e22b8783ab677be6 ON abonnement_boutique USING btree (boutique_id);


--
-- Name: idx_e623d838f4fbc60; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX idx_e623d838f4fbc60 ON user_plateform USING btree (type_user_id);


--
-- Name: idx_f9afb5eb19eb6921; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX idx_f9afb5eb19eb6921 ON communication USING btree (client_id);


--
-- Name: uniq_64c19c1a4d60759; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE UNIQUE INDEX uniq_64c19c1a4d60759 ON category USING btree (libelle);


--
-- Name: uniq_9f3d9535c74f2195; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE UNIQUE INDEX uniq_9f3d9535c74f2195 ON jwt_refresh_token USING btree (refresh_token);


--
-- Name: uniq_e623d83444f97dd; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE UNIQUE INDEX uniq_e623d83444f97dd ON user_plateform USING btree (phone);


--
-- Name: notify_trigger; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER notify_trigger AFTER INSERT OR UPDATE ON messenger_messages FOR EACH ROW EXECUTE PROCEDURE notify_messenger_messages();


--
-- Name: fk_24cc0df2a76ed395; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY panier
    ADD CONSTRAINT fk_24cc0df2a76ed395 FOREIGN KEY (user_id) REFERENCES user_plateform(id);


--
-- Name: fk_29a5ec2712469de2; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY produit
    ADD CONSTRAINT fk_29a5ec2712469de2 FOREIGN KEY (category_id) REFERENCES category(id);


--
-- Name: fk_29a5ec27ab677be6; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY produit
    ADD CONSTRAINT fk_29a5ec27ab677be6 FOREIGN KEY (boutique_id) REFERENCES boutique(id);


--
-- Name: fk_5fff60d6f347efb; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY produit_object
    ADD CONSTRAINT fk_5fff60d6f347efb FOREIGN KEY (produit_id) REFERENCES produit(id);


--
-- Name: fk_6eeaa67d438f5b63; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY commande
    ADD CONSTRAINT fk_6eeaa67d438f5b63 FOREIGN KEY (mode_paiement_id) REFERENCES mode_paiement(id);


--
-- Name: fk_6eeaa67d78db0241; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY commande
    ADD CONSTRAINT fk_6eeaa67d78db0241 FOREIGN KEY (point_livraison_id) REFERENCES point_livraison(id);


--
-- Name: fk_6eeaa67dc9f3f9c5; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY commande
    ADD CONSTRAINT fk_6eeaa67dc9f3f9c5 FOREIGN KEY (type_commande_id) REFERENCES type_commande(id);


--
-- Name: fk_6eeaa67df77d927c; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY commande
    ADD CONSTRAINT fk_6eeaa67df77d927c FOREIGN KEY (panier_id) REFERENCES panier(id);


--
-- Name: fk_710402ec615593e9; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY historique_paiement
    ADD CONSTRAINT fk_710402ec615593e9 FOREIGN KEY (type_paiement_id) REFERENCES type_paiement(id);


--
-- Name: fk_710402ec82ea2e54; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY historique_paiement
    ADD CONSTRAINT fk_710402ec82ea2e54 FOREIGN KEY (commande_id) REFERENCES commande(id);


--
-- Name: fk_710402eca76ed395; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY historique_paiement
    ADD CONSTRAINT fk_710402eca76ed395 FOREIGN KEY (user_id) REFERENCES user_plateform(id);


--
-- Name: fk_723705d119eb6921; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY transaction
    ADD CONSTRAINT fk_723705d119eb6921 FOREIGN KEY (client_id) REFERENCES user_plateform(id);


--
-- Name: fk_723705d1438f5b63; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY transaction
    ADD CONSTRAINT fk_723705d1438f5b63 FOREIGN KEY (mode_paiement_id) REFERENCES mode_paiement(id);


--
-- Name: fk_723705d17903e29b; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY transaction
    ADD CONSTRAINT fk_723705d17903e29b FOREIGN KEY (type_transaction_id) REFERENCES type_transaction(id);


--
-- Name: fk_723705d1f77d927c; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY transaction
    ADD CONSTRAINT fk_723705d1f77d927c FOREIGN KEY (panier_id) REFERENCES panier(id);


--
-- Name: fk_7a28a60419eb6921; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY like_produit
    ADD CONSTRAINT fk_7a28a60419eb6921 FOREIGN KEY (client_id) REFERENCES user_plateform(id);


--
-- Name: fk_7a28a604f347efb; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY like_produit
    ADD CONSTRAINT fk_7a28a604f347efb FOREIGN KEY (produit_id) REFERENCES produit(id);


--
-- Name: fk_7b281e2419eb6921; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY notation_boutique
    ADD CONSTRAINT fk_7b281e2419eb6921 FOREIGN KEY (client_id) REFERENCES user_plateform(id);


--
-- Name: fk_7b281e24ab677be6; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY notation_boutique
    ADD CONSTRAINT fk_7b281e24ab677be6 FOREIGN KEY (boutique_id) REFERENCES boutique(id);


--
-- Name: fk_8f2890a2ab677be6; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY short
    ADD CONSTRAINT fk_8f2890a2ab677be6 FOREIGN KEY (boutique_id) REFERENCES boutique(id);


--
-- Name: fk_936bf99ca76ed395; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY connexion
    ADD CONSTRAINT fk_936bf99ca76ed395 FOREIGN KEY (user_id) REFERENCES user_plateform(id);


--
-- Name: fk_a1223c5412469de2; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY boutique
    ADD CONSTRAINT fk_a1223c5412469de2 FOREIGN KEY (category_id) REFERENCES category(id);


--
-- Name: fk_a1223c54a76ed395; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY boutique
    ADD CONSTRAINT fk_a1223c54a76ed395 FOREIGN KEY (user_id) REFERENCES user_plateform(id);


--
-- Name: fk_a1223c54c68be09c; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY boutique
    ADD CONSTRAINT fk_a1223c54c68be09c FOREIGN KEY (localisation_id) REFERENCES localisation(id);


--
-- Name: fk_a629619382ea2e54; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY list_commande_livreur
    ADD CONSTRAINT fk_a629619382ea2e54 FOREIGN KEY (commande_id) REFERENCES commande(id);


--
-- Name: fk_a6296193f8646701; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY list_commande_livreur
    ADD CONSTRAINT fk_a6296193f8646701 FOREIGN KEY (livreur_id) REFERENCES user_plateform(id);


--
-- Name: fk_aac86140f347efb; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY list_produit_panier
    ADD CONSTRAINT fk_aac86140f347efb FOREIGN KEY (produit_id) REFERENCES produit(id);


--
-- Name: fk_aac86140f77d927c; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY list_produit_panier
    ADD CONSTRAINT fk_aac86140f77d927c FOREIGN KEY (panier_id) REFERENCES panier(id);


--
-- Name: fk_b002f3931c2d1e0c; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY message_communication
    ADD CONSTRAINT fk_b002f3931c2d1e0c FOREIGN KEY (communication_id) REFERENCES communication(id);


--
-- Name: fk_b002f39356d142fc; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY message_communication
    ADD CONSTRAINT fk_b002f39356d142fc FOREIGN KEY (initiateur_id) REFERENCES user_plateform(id);


--
-- Name: fk_bb6a4419ab677be6; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY boutique_object
    ADD CONSTRAINT fk_bb6a4419ab677be6 FOREIGN KEY (boutique_id) REFERENCES boutique(id);


--
-- Name: fk_bf5476caa76ed395; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY notification
    ADD CONSTRAINT fk_bf5476caa76ed395 FOREIGN KEY (user_id) REFERENCES user_plateform(id);


--
-- Name: fk_bfd3ce8fa76ed395; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY localisation
    ADD CONSTRAINT fk_bfd3ce8fa76ed395 FOREIGN KEY (user_id) REFERENCES user_plateform(id);


--
-- Name: fk_c9e2b793139df194; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY list_produit_promotion
    ADD CONSTRAINT fk_c9e2b793139df194 FOREIGN KEY (promotion_id) REFERENCES promotion(id);


--
-- Name: fk_c9e2b793f347efb; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY list_produit_promotion
    ADD CONSTRAINT fk_c9e2b793f347efb FOREIGN KEY (produit_id) REFERENCES produit(id);


--
-- Name: fk_cff65260a76ed395; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY compte
    ADD CONSTRAINT fk_cff65260a76ed395 FOREIGN KEY (user_id) REFERENCES user_plateform(id);


--
-- Name: fk_d59e692156d142fc; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY message_negociation
    ADD CONSTRAINT fk_d59e692156d142fc FOREIGN KEY (initiateur_id) REFERENCES user_plateform(id);


--
-- Name: fk_d59e6921a2d1d3d7; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY message_negociation
    ADD CONSTRAINT fk_d59e6921a2d1d3d7 FOREIGN KEY (negociation_id) REFERENCES negociation_produit(id);


--
-- Name: fk_e0eeb46c56d142fc; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY negociation_produit
    ADD CONSTRAINT fk_e0eeb46c56d142fc FOREIGN KEY (initiateur_id) REFERENCES user_plateform(id);


--
-- Name: fk_e0eeb46cf347efb; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY negociation_produit
    ADD CONSTRAINT fk_e0eeb46cf347efb FOREIGN KEY (produit_id) REFERENCES produit(id);


--
-- Name: fk_e22b878319eb6921; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY abonnement_boutique
    ADD CONSTRAINT fk_e22b878319eb6921 FOREIGN KEY (client_id) REFERENCES user_plateform(id);


--
-- Name: fk_e22b8783ab677be6; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY abonnement_boutique
    ADD CONSTRAINT fk_e22b8783ab677be6 FOREIGN KEY (boutique_id) REFERENCES boutique(id);


--
-- Name: fk_e623d838f4fbc60; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY user_plateform
    ADD CONSTRAINT fk_e623d838f4fbc60 FOREIGN KEY (type_user_id) REFERENCES type_user(id);


--
-- Name: fk_f9afb5eb19eb6921; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY communication
    ADD CONSTRAINT fk_f9afb5eb19eb6921 FOREIGN KEY (client_id) REFERENCES user_plateform(id);


--
-- Name: public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- PostgreSQL database dump complete
--

