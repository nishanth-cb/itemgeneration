-- Table: public.tbltokenusage

-- DROP TABLE IF EXISTS public.tbltokenusage;

CREATE TABLE IF NOT EXISTS public.tbltokenusage
(
    id bigint NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 9223372036854775807 CACHE 1 ),
    custcode character varying(50) COLLATE pg_catalog."default",
    usercode character varying(50) COLLATE pg_catalog."default",
    appcode character varying(50) COLLATE pg_catalog."default",
    orgcode character varying(50) COLLATE pg_catalog."default",
    inputtoken_usage bigint,
    responsetoken_usage bigint,
    questionrequestid bigint,
    referenceinfo character varying COLLATE pg_catalog."default",
    booknameid bigint,
    noofquestions bigint,
    questiontypeid bigint,
    taxonomyid bigint,
    difficultylevelid bigint,
    chaptercode character varying COLLATE pg_catalog."default",
    locode character varying COLLATE pg_catalog."default",
    created_at timestamp(3) without time zone NOT NULL DEFAULT timezone('UTC'::text, CURRENT_TIMESTAMP(6)),
    updated_at timestamp(3) without time zone,
    isdeleted numeric(1,0) NOT NULL DEFAULT 0,
    CONSTRAINT tbltokenusage_pkey PRIMARY KEY (id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.tbltokenusage
    OWNER to postgres;