-- Table: public.tblcustomerconfiguration

-- DROP TABLE IF EXISTS public.tblcustomerconfiguration;

CREATE TABLE IF NOT EXISTS public.tblcustomerconfiguration
(
    id bigint NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 9223372036854775807 CACHE 1 ),
    customercode character varying(500) COLLATE pg_catalog."default",
    type smallint,
    mappingid bigint,
    created_at timestamp(3) without time zone NOT NULL DEFAULT timezone('UTC'::text, CURRENT_TIMESTAMP(6)),
    updated_at timestamp(3) without time zone,
    isdeleted numeric(1,0) NOT NULL DEFAULT 0,
    orgcode character varying(100) COLLATE pg_catalog."default",
    appcode character varying(100) COLLATE pg_catalog."default",
    CONSTRAINT tblcustomerconfiguration_pkey PRIMARY KEY (id),
    CONSTRAINT tblcustomerconfiguration_fkey_mappingid FOREIGN KEY (mappingid)
        REFERENCES public.tblquestiontype (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.tblcustomerconfiguration
    OWNER to postgres;