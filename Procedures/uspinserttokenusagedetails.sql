-- PROCEDURE: public.uspinserttokenusagedetails(character varying, character varying, character varying, character varying, character varying, bigint, bigint, bigint, bigint, character varying, character varying, bigint, character varying, bigint, bigint)

-- DROP PROCEDURE IF EXISTS public.uspinserttokenusagedetails(character varying, character varying, character varying, character varying, character varying, bigint, bigint, bigint, bigint, character varying, character varying, bigint, character varying, bigint, bigint);

CREATE OR REPLACE PROCEDURE public.uspinserttokenusagedetails(
	IN par_custcode character varying,
	IN par_orgcode character varying,
	IN par_usercode character varying,
	IN par_appcode character varying,
	IN par_referenceinfo character varying,
	IN par_booknameid bigint,
	IN par_questiontypeid bigint,
	IN par_taxonomyid bigint,
	IN par_difficultlevelid bigint,
	IN par_chaptercode character varying DEFAULT ''::character varying,
	IN par_locode character varying DEFAULT ''::character varying,
	IN par_sourcetype bigint DEFAULT (0)::bigint,
	INOUT par_status character varying DEFAULT ''::character varying,
	IN par_inputtoken bigint DEFAULT 0,
	IN par_responsetoken bigint DEFAULT 0)
LANGUAGE 'plpgsql'
AS $BODY$
BEGIN
    INSERT INTO tbltokenusage (
        custcode,
        usercode,
        appcode,
        orgcode,
        inputtoken_usage,
        responsetoken_usage,
        referenceinfo,
        booknameid,
        questiontypeid,
        taxonomyid,
        difficultylevelid,
        chaptercode,
        locode
    )
    VALUES (
        par_custcode,
        par_usercode,
        par_appcode,
        par_orgcode,
        par_inputtoken,
        par_responsetoken,
        par_referenceinfo,
        par_booknameid,
        par_questiontypeid,
        par_taxonomyid,
        par_difficultlevelid,
        par_chaptercode,
        par_locode
    );
    par_status := 'S001';
END;
$BODY$;
ALTER PROCEDURE public.uspinserttokenusagedetails(character varying, character varying, character varying, character varying, character varying, bigint, bigint, bigint, bigint, character varying, character varying, bigint, character varying, bigint, bigint)
    OWNER TO postgres;
