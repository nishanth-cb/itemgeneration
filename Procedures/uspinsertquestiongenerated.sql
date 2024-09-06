-- PROCEDURE: public.uspinsertquestiongenerated(character varying, character varying, character varying, character varying, character varying, bigint, bigint, bigint, bigint, jsonb, bigint, character varying, character varying, bigint, character varying, character varying)

-- DROP PROCEDURE IF EXISTS public.uspinsertquestiongenerated(character varying, character varying, character varying, character varying, character varying, bigint, bigint, bigint, bigint, jsonb, bigint, character varying, character varying, bigint, character varying, character varying);

CREATE OR REPLACE PROCEDURE public.uspinsertquestiongenerated(
	IN par_custcode character varying,
	IN par_orgcode character varying,
	IN par_usercode character varying,
	IN par_appcode character varying,
	IN par_referenceinfo character varying,
	IN par_booknameid bigint,
	IN par_noofquestions bigint,
	IN par_questiontypeid bigint,
	IN par_taxonomyid bigint,
	IN par_questiondata jsonb,
	IN par_difficultlevelid bigint,
	IN par_chaptercode character varying DEFAULT ''::character varying,
	IN par_locode character varying DEFAULT ''::character varying,
	IN par_sourcetype bigint DEFAULT (0)::bigint,
	INOUT par_status character varying DEFAULT ''::character varying,
	IN par_questionguid character varying DEFAULT ''::character varying)
LANGUAGE 'plpgsql'
AS $BODY$
DECLARE
    var_idd BIGINT;
	var_tokenusageid BIGINT;
BEGIN
    INSERT INTO tblquestionrequest (
      custcode,orgcode,appcode,  usercode,  QuestionTypeid, referenceinfo, booknameid, noofquestions, taxonomyid, difficultlevelid
		,chaptercode,locode,sourcetype
    )
    VALUES (
       par_custcode,par_orgcode,par_appcode, par_usercode, par_questiontypeid, par_referenceinfo, par_booknameid, par_noofquestions, par_taxonomyid, par_difficultlevelid
		,par_chaptercode,par_locode,par_sourcetype
    )
    RETURNING questionrequestid INTO var_idd;

 
    WITH json_elements AS (
        SELECT 
            var_idd AS questionrequestid,
             ROW_NUMBER() OVER () AS questionid ,
            CASE
                WHEN par_questiontypeid = 1 THEN jsonb_build_object(
                    'label', elem->>'label',
                    'values', elem->'values',
                    'CorrectAnswer', elem->>'CorrectAnswer',
                    'FeedbackOptionA', elem->>'FeedbackOptionA',
                    'FeedbackOptionB', elem->>'FeedbackOptionB',
                    'FeedbackOptionC', elem->>'FeedbackOptionC',
                    'FeedbackOptionD', elem->>'FeedbackOptionD',
                    'ReferenceInfo', elem->>'ReferenceInfo',
                    'BookName', elem->>'BookName'
                )
                WHEN par_questiontypeid = 7 THEN jsonb_build_object(
                    'label', elem->>'label',
                    'CorrectAnswer', elem->>'CorrectAnswer',
                    'ReferenceInfo', elem->>'ReferenceInfo',
                    'BookName', elem->>'BookName',
					'KeyPoints', elem->>'KeyPoints'
                )
                ELSE jsonb_build_object(
                    'label', elem->>'label'
                )
            END AS questionxml,
            (elem->>'MaxMarks')::TEXT::BIGINT AS marks,  
            CASE
                WHEN par_questiontypeid = 7 THEN (elem->'KeyPoints')::jsonb
                ELSE NULL
            END AS keypoints,
            par_questiontypeid AS QuestionTypeid,par_questionguid||var_idd::character varying  as questionguid
        FROM jsonb_array_elements(par_questiondata) AS elem
        WHERE elem->>'label' IS NOT NULL
    )

    INSERT INTO tblquestiongeneratedlist (
        questionrequestid, questionid, questionxml, marks, keypoints, QuestionTypeid,questionguid
    )
    SELECT 
        je.questionrequestid, 
        je.questionid, 
        je.questionxml, 
        je.marks,
        CASE
            WHEN je.QuestionTypeid = 7 THEN jsonb_agg(je.keypoints)::TEXT::jsonb
            ELSE NULL
        END AS keypoints,
        je.QuestionTypeid,je.questionguid
    FROM json_elements je
    GROUP BY je.questionrequestid, je.questionid, je.questionxml, je.marks, je.QuestionTypeid,je.questionguid;

 		SELECT max(id) INTO var_tokenusageid
		FROM public.tbltokenusage
		WHERE COALESCE(custcode, '') = COALESCE(par_custcode, '') 
		AND COALESCE(usercode, '') = COALESCE(par_usercode, '') 
		AND COALESCE(appcode, '') = COALESCE(par_appcode, '') 
		AND COALESCE(orgcode, '') = COALESCE(par_orgcode, '') 
		AND isdeleted = 0;
		
		
	--  RAISE NOTICE 'Token usage ID: %,%,%', var_tokenusageid,var_idd,par_noofquestions;
	
		UPDATE tbltokenusage
		SET noofquestions = par_noofquestions, questionrequestid = var_idd
		WHERE id = var_tokenusageid AND isdeleted = 0;

	
	par_status := 'S001';  
	

EXCEPTION
    WHEN others THEN
        par_status := 'F001';  
        RAISE NOTICE 'Error occurred: %', SQLERRM;
END;
$BODY$;
ALTER PROCEDURE public.uspinsertquestiongenerated(character varying, character varying, character varying, character varying, character varying, bigint, bigint, bigint, bigint, jsonb, bigint, character varying, character varying, bigint, character varying, character varying)
    OWNER TO postgres;
