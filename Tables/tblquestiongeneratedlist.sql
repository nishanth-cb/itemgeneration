-- Table: public.tblquestiongeneratedlist

-- DROP TABLE IF EXISTS public.tblquestiongeneratedlist;

CREATE TABLE IF NOT EXISTS public.tblquestiongeneratedlist
(
    id bigint NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 9223372036854775807 CACHE 1 ),
    questionrequestid bigint NOT NULL,
    questionid bigint,
    questionxml jsonb,
    marks bigint,
    keypoints jsonb,
    questiontypeid bigint,
    createdby bigint,
    modifieddate timestamp without time zone,
    modifiedby bigint,
    isdeleted numeric(1,0) DEFAULT 0,
    questionguid character varying(500) COLLATE pg_catalog."default",
    CONSTRAINT tblquestiongeneratedlist_pkey PRIMARY KEY (id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.tblquestiongeneratedlist
    OWNER to postgres;