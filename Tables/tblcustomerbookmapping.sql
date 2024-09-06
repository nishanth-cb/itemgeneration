-- Table: public.tblcustomerbookmapping

-- DROP TABLE IF EXISTS public.tblcustomerbookmapping;

CREATE TABLE IF NOT EXISTS public.tblcustomerbookmapping
(
    id bigint NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 9223372036854775807 CACHE 1 ),
    bookid bigint,
    customercode character varying(1000) COLLATE pg_catalog."default",
    appcode character varying(1000) COLLATE pg_catalog."default",
    isdeleted numeric(1,0) NOT NULL DEFAULT 0,
    CONSTRAINT tblcustomerbookmapping_pkey PRIMARY KEY (id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.tblcustomerbookmapping
    OWNER to postgres;