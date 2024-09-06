-- Table: public.tblquestionrequest

-- DROP TABLE IF EXISTS public.tblquestionrequest;

CREATE TABLE IF NOT EXISTS public.tblquestionrequest
(
    questionrequestid bigint NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 9223372036854775807 CACHE 1 ),
    usercode character varying COLLATE pg_catalog."default",
    promtquestiondetails text COLLATE pg_catalog."default",
    referenceinfo character varying COLLATE pg_catalog."default",
    booknameid bigint,
    noofquestions bigint,
    questiontypeid bigint,
    taxonomyid bigint,
    createddate timestamp without time zone DEFAULT timezone('UTC'::text, CURRENT_TIMESTAMP(6)),
    createdby bigint,
    modifieddate timestamp without time zone,
    modifiedby bigint,
    isdeleted numeric(1,0) DEFAULT 0,
    difficultlevelid bigint,
    chaptercode character varying(100) COLLATE pg_catalog."default",
    locode character varying(100) COLLATE pg_catalog."default",
    custcode character varying(100) COLLATE pg_catalog."default",
    orgcode character varying(100) COLLATE pg_catalog."default",
    appcode character varying(100) COLLATE pg_catalog."default",
    sourcetype numeric,
    CONSTRAINT tblquestionrequest_pkey PRIMARY KEY (questionrequestid)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.tblquestionrequest
    OWNER to postgres;