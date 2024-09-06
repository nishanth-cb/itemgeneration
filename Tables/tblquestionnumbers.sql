-- Table: public.tblquestionnumbers

-- DROP TABLE IF EXISTS public.tblquestionnumbers;

CREATE TABLE IF NOT EXISTS public.tblquestionnumbers
(
    id bigint NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 9223372036854775807 CACHE 1 ),
    numberof_questions integer,
    created_at timestamp(3) without time zone NOT NULL DEFAULT timezone('UTC'::text, CURRENT_TIMESTAMP(6)),
    updated_at timestamp(3) without time zone,
    isdeleted numeric(1,0) NOT NULL DEFAULT 0,
    CONSTRAINT tblquestionnumbers_pkey PRIMARY KEY (id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.tblquestionnumbers
    OWNER to postgres;