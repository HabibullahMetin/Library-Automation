--
-- PostgreSQL database dump
--

-- Dumped from database version 10.6
-- Dumped by pg_dump version 11.0

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: KitapMiktariDegisikligi(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public."KitapMiktariDegisikligi"() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
    book record;
BEGIN
    IF NEW."Miktar" < OLD."Miktar" THEN
        UPDATE "Kitap"
        SET NEW."Miktar" = OLD."Miktar" - book."KitapMiktar"  
        WHERE "Miktar" = NEW."Miktar"; 
    END IF;
    
    RETURN NEW;
END;
$$;


ALTER FUNCTION public."KitapMiktariDegisikligi"() OWNER TO postgres;

--
-- Name: kisiekle(text, text, text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.kisiekle(personfirstname text, personlastname text, address text) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE
    adresler record;
    adresNumara record;
BEGIN
    SELECT INTO adresler "Adres" FROM "Adres" WHERE "Adres" = address;
    IF adresler IS NULL THEN
        INSERT INTO "Adres"("Adres") VALUES(address);
    END IF;
    SELECT INTO adresNumara "AdresNo" FROM "Adres" WHERE "Adres" = address;


    INSERT INTO "Kisi"("Ad","Soyad","Adres")
    VALUES(personfirstName,personLastName,adresNumara."AdresNo");
    
    RETURN 1;
   
END;
$$;


ALTER FUNCTION public.kisiekle(personfirstname text, personlastname text, address text) OWNER TO postgres;

--
-- Name: kitapal(integer, text, integer, timestamp without time zone); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.kitapal(kisino integer, kitapadi text, kitapmiktar integer, kalistarihi timestamp without time zone) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE
    tarihler record;
    tarihNumara record;
BEGIN
    SELECT INTO tarihler "AlisTarihi" FROM "Tarih" WHERE "AlisTarihi" = kAlisTarihi;
    IF tarihler IS NULL THEN
        INSERT INTO "Tarih"("AlisTarihi") VALUES(kAlisTarihi);
    END IF;
    SELECT INTO tarihNumara "TarihNo" FROM "Tarih" WHERE "AlisTarihi" = kAlisTarihi;

    INSERT INTO "IslemListesi"("Kisi","KitapAdi","KitapMiktar","Sure")
    VALUES(kisiNo,kitapAdi,kitapMiktar,tarihNumara."TarihNo");
    
    RETURN 1;
END;
$$;


ALTER FUNCTION public.kitapal(kisino integer, kitapadi text, kitapmiktar integer, kalistarihi timestamp without time zone) OWNER TO postgres;

--
-- Name: kitapekle(text, timestamp without time zone, integer, integer, text, character, text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.kitapekle(bookname text, printdate timestamp without time zone, quantity integer, pagenumber integer, tur text, tip character, author text) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE
    yazarlar record;
    turler record;
    tarihler record;
    yazarNumara record;
    tarihNumara record;
    turNumarasi record;
    kitapNumarasi record;
BEGIN
    SELECT INTO tarihler "BasimTarihi" FROM "Tarih" WHERE "BasimTarihi" = printDate;
    IF tarihler IS NULL THEN
        INSERT INTO "Tarih"("BasimTarihi") VALUES(printDate);
    END IF;
    SELECT INTO tarihNumara "TarihNo" FROM "Tarih" WHERE "BasimTarihi" = printDate;

    
    SELECT INTO yazarlar "YazarNo" FROM "Yazar" WHERE "YazarAdi" = author;
    IF yazarlar IS NULL THEN
        INSERT INTO "Yazar"("YazarAdi") VALUES(author);
    END IF;
    SELECT INTO yazarNumara "YazarNo" FROM "Yazar" WHERE "YazarAdi" = author;
    
    
    SELECT INTO turler "TurNo" FROM "Tur" WHERE "TurAdi" = tur;
    IF turler IS NULL THEN
        INSERT INTO "Tur"("TurAdi") VALUES(tur);
    END IF;
    SELECT INTO turNumarasi "TurNo" FROM "Tur" WHERE "TurAdi" = tur;
	
	
    INSERT INTO "Kitap"("KitapAdi","BasimTarihi","Miktar","SayfaSayisi","Tip","Yazar")
    VALUES(bookName,tarihNumara."TarihNo",quantity,pageNumber,tip,yazarNumara."YazarNo");
    
    
    SELECT INTO kitapNumarasi "KitapNo" FROM "Kitap" ORDER BY "KitapNo" DESC LIMIT 1;
    INSERT INTO "KitapTur"("Kitap","Tur") VALUES(kitapNumarasi."KitapNo",turNumarasi."TurNo");
    
    RETURN 1;
   
END;
$$;


ALTER FUNCTION public.kitapekle(bookname text, printdate timestamp without time zone, quantity integer, pagenumber integer, tur text, tip character, author text) OWNER TO postgres;

--
-- Name: kitapsil(integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.kitapsil(kitapnumara integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE
    kitapTurSil "KitapTur"%ROWTYPE;
BEGIN
    FOR kitapTurSil IN SELECT "ListeNo" FROM "KitapTur" WHERE "Kitap" = kitapNumara LOOP
        DELETE FROM "KitapTur" WHERE "ListeNo" = kitapTurSil."ListeNo";
    END LOOP;
    
    DELETE FROM "Kitap" WHERE "KitapNo" = kitapNumara;
    RETURN 1;
END;
$$;


ALTER FUNCTION public.kitapsil(kitapnumara integer) OWNER TO postgres;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: Adres; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Adres" (
    "AdresNo" integer NOT NULL,
    "Adres" text NOT NULL
);


ALTER TABLE public."Adres" OWNER TO postgres;

--
-- Name: Adres_AdresNo_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Adres_AdresNo_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."Adres_AdresNo_seq" OWNER TO postgres;

--
-- Name: Adres_AdresNo_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Adres_AdresNo_seq" OWNED BY public."Adres"."AdresNo";


--
-- Name: Ansiklopedi; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Ansiklopedi" (
    "KitapNo" integer NOT NULL
);


ALTER TABLE public."Ansiklopedi" OWNER TO postgres;

--
-- Name: Dergi; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Dergi" (
    "KitapNo" integer NOT NULL
);


ALTER TABLE public."Dergi" OWNER TO postgres;

--
-- Name: IslemListesi; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."IslemListesi" (
    "IslemListeNo" integer NOT NULL,
    "Kisi" integer NOT NULL,
    "KitapAdi" text NOT NULL,
    "KitapMiktar" integer NOT NULL,
    "Sure" integer NOT NULL
);


ALTER TABLE public."IslemListesi" OWNER TO postgres;

--
-- Name: IslemListesi_IslemListeNo_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."IslemListesi_IslemListeNo_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."IslemListesi_IslemListeNo_seq" OWNER TO postgres;

--
-- Name: IslemListesi_IslemListeNo_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."IslemListesi_IslemListeNo_seq" OWNED BY public."IslemListesi"."IslemListeNo";


--
-- Name: Kisi; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Kisi" (
    "KisiNo" integer NOT NULL,
    "Ad" text NOT NULL,
    "Soyad" text NOT NULL,
    "Adres" integer NOT NULL
);


ALTER TABLE public."Kisi" OWNER TO postgres;

--
-- Name: Kisi_KisiNo_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Kisi_KisiNo_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."Kisi_KisiNo_seq" OWNER TO postgres;

--
-- Name: Kisi_KisiNo_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Kisi_KisiNo_seq" OWNED BY public."Kisi"."KisiNo";


--
-- Name: Kitap; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Kitap" (
    "KitapNo" integer NOT NULL,
    "KitapAdi" text NOT NULL,
    "SayfaSayisi" integer NOT NULL,
    "Miktar" integer NOT NULL,
    "BasimTarihi" integer NOT NULL,
    "Tip" character(1) NOT NULL,
    "Yazar" integer NOT NULL
);


ALTER TABLE public."Kitap" OWNER TO postgres;

--
-- Name: KitapTur; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."KitapTur" (
    "ListeNo" integer NOT NULL,
    "Kitap" integer NOT NULL,
    "Tur" integer NOT NULL
);


ALTER TABLE public."KitapTur" OWNER TO postgres;

--
-- Name: KitapTur_ListeNo_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."KitapTur_ListeNo_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."KitapTur_ListeNo_seq" OWNER TO postgres;

--
-- Name: KitapTur_ListeNo_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."KitapTur_ListeNo_seq" OWNED BY public."KitapTur"."ListeNo";


--
-- Name: Kitap_KitapNo_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Kitap_KitapNo_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."Kitap_KitapNo_seq" OWNER TO postgres;

--
-- Name: Kitap_KitapNo_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Kitap_KitapNo_seq" OWNED BY public."Kitap"."KitapNo";


--
-- Name: Roman; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Roman" (
    "KitapNo" integer NOT NULL
);


ALTER TABLE public."Roman" OWNER TO postgres;

--
-- Name: Tarih; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Tarih" (
    "TarihNo" integer NOT NULL,
    "BasimTarihi" date,
    "AlisTarihi" date
);


ALTER TABLE public."Tarih" OWNER TO postgres;

--
-- Name: Tarih_TarihNo_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Tarih_TarihNo_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."Tarih_TarihNo_seq" OWNER TO postgres;

--
-- Name: Tarih_TarihNo_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Tarih_TarihNo_seq" OWNED BY public."Tarih"."TarihNo";


--
-- Name: Tur; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Tur" (
    "TurNo" integer NOT NULL,
    "TurAdi" character varying(20) NOT NULL
);


ALTER TABLE public."Tur" OWNER TO postgres;

--
-- Name: Tur_TurNo_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Tur_TurNo_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."Tur_TurNo_seq" OWNER TO postgres;

--
-- Name: Tur_TurNo_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Tur_TurNo_seq" OWNED BY public."Tur"."TurNo";


--
-- Name: UcretlenenIslemler; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."UcretlenenIslemler" (
    "UcretliNo" integer NOT NULL,
    "Ad" text NOT NULL,
    "Soyad" text NOT NULL,
    "Ucret" integer NOT NULL
);


ALTER TABLE public."UcretlenenIslemler" OWNER TO postgres;

--
-- Name: UcretlenenIslemler_UcretliNo_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."UcretlenenIslemler_UcretliNo_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."UcretlenenIslemler_UcretliNo_seq" OWNER TO postgres;

--
-- Name: UcretlenenIslemler_UcretliNo_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."UcretlenenIslemler_UcretliNo_seq" OWNED BY public."UcretlenenIslemler"."UcretliNo";


--
-- Name: Yazar; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Yazar" (
    "YazarNo" integer NOT NULL,
    "YazarAdi" text NOT NULL
);


ALTER TABLE public."Yazar" OWNER TO postgres;

--
-- Name: Yazar_YazarNo_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Yazar_YazarNo_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."Yazar_YazarNo_seq" OWNER TO postgres;

--
-- Name: Yazar_YazarNo_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Yazar_YazarNo_seq" OWNED BY public."Yazar"."YazarNo";


--
-- Name: Adres AdresNo; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Adres" ALTER COLUMN "AdresNo" SET DEFAULT nextval('public."Adres_AdresNo_seq"'::regclass);


--
-- Name: IslemListesi IslemListeNo; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."IslemListesi" ALTER COLUMN "IslemListeNo" SET DEFAULT nextval('public."IslemListesi_IslemListeNo_seq"'::regclass);


--
-- Name: Kisi KisiNo; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Kisi" ALTER COLUMN "KisiNo" SET DEFAULT nextval('public."Kisi_KisiNo_seq"'::regclass);


--
-- Name: Kitap KitapNo; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Kitap" ALTER COLUMN "KitapNo" SET DEFAULT nextval('public."Kitap_KitapNo_seq"'::regclass);


--
-- Name: KitapTur ListeNo; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."KitapTur" ALTER COLUMN "ListeNo" SET DEFAULT nextval('public."KitapTur_ListeNo_seq"'::regclass);


--
-- Name: Tarih TarihNo; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Tarih" ALTER COLUMN "TarihNo" SET DEFAULT nextval('public."Tarih_TarihNo_seq"'::regclass);


--
-- Name: Tur TurNo; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Tur" ALTER COLUMN "TurNo" SET DEFAULT nextval('public."Tur_TurNo_seq"'::regclass);


--
-- Name: UcretlenenIslemler UcretliNo; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."UcretlenenIslemler" ALTER COLUMN "UcretliNo" SET DEFAULT nextval('public."UcretlenenIslemler_UcretliNo_seq"'::regclass);


--
-- Name: Yazar YazarNo; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Yazar" ALTER COLUMN "YazarNo" SET DEFAULT nextval('public."Yazar_YazarNo_seq"'::regclass);


--
-- Data for Name: Adres; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."Adres" VALUES (1, 'sakarya');
INSERT INTO public."Adres" VALUES (2, 'istanbul');
INSERT INTO public."Adres" VALUES (3, 'alamanya');
INSERT INTO public."Adres" VALUES (4, 'kamboçya');
INSERT INTO public."Adres" VALUES (7, 'nijerya');


--
-- Data for Name: Ansiklopedi; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: Dergi; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: IslemListesi; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."IslemListesi" VALUES (1, 1, 'agwgawg', 50, 4);


--
-- Data for Name: Kisi; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."Kisi" VALUES (1, 'Ali', 'Deli', 1);
INSERT INTO public."Kisi" VALUES (2, 'Koca', 'Ahmak', 2);
INSERT INTO public."Kisi" VALUES (3, 'Danza', 'Kuduro', 4);
INSERT INTO public."Kisi" VALUES (4, 'Ahmet', 'Yıldırım', 7);


--
-- Data for Name: Kitap; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."Kitap" VALUES (1, 'agwgawg', 200, 100, 1, 'R', 3);
INSERT INTO public."Kitap" VALUES (3, 'Çalıkuşu', 250, 78, 1, 'R', 1);
INSERT INTO public."Kitap" VALUES (4, 'dsd', 200, 100, 1, 'R', 2);


--
-- Data for Name: KitapTur; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: Roman; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: Tarih; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."Tarih" VALUES (1, '5620-12-07', NULL);
INSERT INTO public."Tarih" VALUES (2, '2020-10-07', NULL);
INSERT INTO public."Tarih" VALUES (4, NULL, '2017-08-18');


--
-- Data for Name: Tur; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: UcretlenenIslemler; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: Yazar; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."Yazar" VALUES (1, 'Reşat Nuri Güntekin');
INSERT INTO public."Yazar" VALUES (2, 'Ahmet Hamdi Tanpınar');
INSERT INTO public."Yazar" VALUES (3, 'Galib Derviş');
INSERT INTO public."Yazar" VALUES (4, 'Gargano Derviş');


--
-- Name: Adres_AdresNo_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Adres_AdresNo_seq"', 7, true);


--
-- Name: IslemListesi_IslemListeNo_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."IslemListesi_IslemListeNo_seq"', 11, true);


--
-- Name: Kisi_KisiNo_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Kisi_KisiNo_seq"', 4, true);


--
-- Name: KitapTur_ListeNo_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."KitapTur_ListeNo_seq"', 1, false);


--
-- Name: Kitap_KitapNo_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Kitap_KitapNo_seq"', 4, true);


--
-- Name: Tarih_TarihNo_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Tarih_TarihNo_seq"', 6, true);


--
-- Name: Tur_TurNo_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Tur_TurNo_seq"', 1, false);


--
-- Name: UcretlenenIslemler_UcretliNo_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."UcretlenenIslemler_UcretliNo_seq"', 1, false);


--
-- Name: Yazar_YazarNo_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Yazar_YazarNo_seq"', 4, true);


--
-- Name: Adres Adres_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Adres"
    ADD CONSTRAINT "Adres_pkey" PRIMARY KEY ("AdresNo");


--
-- Name: Ansiklopedi Ansiklopedi_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Ansiklopedi"
    ADD CONSTRAINT "Ansiklopedi_pkey" PRIMARY KEY ("KitapNo");


--
-- Name: Dergi Dergi_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Dergi"
    ADD CONSTRAINT "Dergi_pkey" PRIMARY KEY ("KitapNo");


--
-- Name: IslemListesi IslemListesi_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."IslemListesi"
    ADD CONSTRAINT "IslemListesi_pkey" PRIMARY KEY ("IslemListeNo");


--
-- Name: Kisi Kisi_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Kisi"
    ADD CONSTRAINT "Kisi_pkey" PRIMARY KEY ("KisiNo");


--
-- Name: KitapTur KitapTur_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."KitapTur"
    ADD CONSTRAINT "KitapTur_pkey" PRIMARY KEY ("ListeNo");


--
-- Name: Kitap Kitap_KitapAdi_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Kitap"
    ADD CONSTRAINT "Kitap_KitapAdi_key" UNIQUE ("KitapAdi");


--
-- Name: Kitap Kitap_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Kitap"
    ADD CONSTRAINT "Kitap_pkey" PRIMARY KEY ("KitapNo");


--
-- Name: Roman Roman_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Roman"
    ADD CONSTRAINT "Roman_pkey" PRIMARY KEY ("KitapNo");


--
-- Name: Tarih Tarih_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Tarih"
    ADD CONSTRAINT "Tarih_pkey" PRIMARY KEY ("TarihNo");


--
-- Name: Tur Tur_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Tur"
    ADD CONSTRAINT "Tur_pkey" PRIMARY KEY ("TurNo");


--
-- Name: UcretlenenIslemler UcretlenenIslemler_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."UcretlenenIslemler"
    ADD CONSTRAINT "UcretlenenIslemler_pkey" PRIMARY KEY ("UcretliNo");


--
-- Name: Yazar Yazar_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Yazar"
    ADD CONSTRAINT "Yazar_pkey" PRIMARY KEY ("YazarNo");


--
-- Name: IslemListesi KitapAlindiginda; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER "KitapAlindiginda" AFTER INSERT ON public."IslemListesi" FOR EACH ROW EXECUTE PROCEDURE public."KitapMiktariDegisikligi"();


--
-- Name: Ansiklopedi AnsiklopediBaglanti; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Ansiklopedi"
    ADD CONSTRAINT "AnsiklopediBaglanti" FOREIGN KEY ("KitapNo") REFERENCES public."Kitap"("KitapNo") ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: Roman RomanBaglanti; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Roman"
    ADD CONSTRAINT "RomanBaglanti" FOREIGN KEY ("KitapNo") REFERENCES public."Kitap"("KitapNo") ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: Kisi lnk_Adres_Kisi; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Kisi"
    ADD CONSTRAINT "lnk_Adres_Kisi" FOREIGN KEY ("Adres") REFERENCES public."Adres"("AdresNo") MATCH FULL ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: IslemListesi lnk_Kisi_IslemListesi; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."IslemListesi"
    ADD CONSTRAINT "lnk_Kisi_IslemListesi" FOREIGN KEY ("Kisi") REFERENCES public."Kisi"("KisiNo") MATCH FULL ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: Dergi lnk_Kitap_Dergi; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Dergi"
    ADD CONSTRAINT "lnk_Kitap_Dergi" FOREIGN KEY ("KitapNo") REFERENCES public."Kitap"("KitapNo") MATCH FULL ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: KitapTur lnk_Kitap_KitapTur; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."KitapTur"
    ADD CONSTRAINT "lnk_Kitap_KitapTur" FOREIGN KEY ("Kitap") REFERENCES public."Kitap"("KitapNo") MATCH FULL ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: IslemListesi lnk_Tarih_IslemListesi; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."IslemListesi"
    ADD CONSTRAINT "lnk_Tarih_IslemListesi" FOREIGN KEY ("Sure") REFERENCES public."Tarih"("TarihNo") MATCH FULL ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: Kitap lnk_Tarih_Kitap; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Kitap"
    ADD CONSTRAINT "lnk_Tarih_Kitap" FOREIGN KEY ("BasimTarihi") REFERENCES public."Tarih"("TarihNo") MATCH FULL ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: KitapTur lnk_Tur_KitapTur; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."KitapTur"
    ADD CONSTRAINT "lnk_Tur_KitapTur" FOREIGN KEY ("Tur") REFERENCES public."Tur"("TurNo") MATCH FULL ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: Kitap lnk_Yazar_Kitap; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Kitap"
    ADD CONSTRAINT "lnk_Yazar_Kitap" FOREIGN KEY ("Yazar") REFERENCES public."Yazar"("YazarNo") MATCH FULL ON UPDATE CASCADE ON DELETE CASCADE;


--
-- PostgreSQL database dump complete
--

