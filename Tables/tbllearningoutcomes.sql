-- Table: public.tbllearningoutcomes

-- DROP TABLE IF EXISTS public.tbllearningoutcomes;

CREATE TABLE IF NOT EXISTS public.tbllearningoutcomes
(
    id bigint NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 9223372036854775807 CACHE 1 ),
    loname character varying(500) COLLATE pg_catalog."default",
    locode character varying(50) COLLATE pg_catalog."default",
    chapterid bigint,
    created_at timestamp(3) without time zone NOT NULL DEFAULT timezone('UTC'::text, CURRENT_TIMESTAMP(6)),
    updated_at timestamp(3) without time zone,
    isdeleted numeric(1,0) NOT NULL DEFAULT 0,
    CONSTRAINT tbllearningoutcomes_pkey PRIMARY KEY (id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.tbllearningoutcomes
    OWNER to postgres;