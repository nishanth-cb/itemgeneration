-- Table: public.postgres_spprofiler

-- DROP TABLE IF EXISTS public.postgres_spprofiler;

CREATE TABLE IF NOT EXISTS public.postgres_spprofiler
(
    id bigint NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 9223372036854775807 CACHE 1 ),
    profiler text COLLATE pg_catalog."default"
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.postgres_spprofiler
    OWNER to postgres;