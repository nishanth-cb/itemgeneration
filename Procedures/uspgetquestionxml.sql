-- PROCEDURE: public.uspgetquestionxml(character varying, character varying, character varying, character varying, bigint, character varying, character varying, bigint, bigint, bigint, bigint, bigint, refcursor)

-- DROP PROCEDURE IF EXISTS public.uspgetquestionxml(character varying, character varying, character varying, character varying, bigint, character varying, character varying, bigint, bigint, bigint, bigint, bigint, refcursor);

CREATE OR REPLACE PROCEDURE public.uspgetquestionxml(
	IN par_custcode character varying,
	IN par_orgcode character varying,
	IN par_usercode character varying,
	IN par_appcode character varying,
	IN par_booknameid bigint DEFAULT (0)::bigint,
	IN par_chaptercode character varying DEFAULT ''::character varying,
	IN par_locode character varying DEFAULT ''::character varying,
	IN par_questiontypeid bigint DEFAULT (0)::bigint,
	IN par_taxonomyid bigint DEFAULT (0)::bigint,
	IN par_sourcetype bigint DEFAULT (0)::bigint,
	IN par_pagesize bigint DEFAULT (0)::bigint,
	IN par_pageno bigint DEFAULT (0)::bigint,
	INOUT par_ref refcursor DEFAULT NULL::refcursor)
LANGUAGE 'plpgsql'
AS $BODY$
DECLARE
    var_from BIGINT;
    var_to BIGINT;
	varq text;
BEGIN
    IF par_pagesize <= 0 OR par_pageno <= 0 THEN
        var_from := 1;
        var_to := 1234567890;
    ELSE
        var_from := ((par_pagesize * par_pageno) - par_pagesize + 1);
        var_to := (par_pagesize * par_pageno);
    END IF;

        OPEN par_ref FOR
         WITH ValidQuestions AS (
		 SELECT
                qg.questionid,
                qg.questionrequestid,
                qg.questionxml,
                qg.marks,
                qg.keypoints,
                ROW_NUMBER() OVER (ORDER BY qg.questionid) AS row_num,
                qg.questionguid,
			    qr.questiontypeid,
			    qr.locode,
			    qr.booknameid,
			    qr.usercode,
			    qr.taxonomyid ,
			    qr.chaptercode ,qr.sourcetype
            FROM tblquestiongeneratedlist qg
			INNER JOIN  tblquestionrequest qr ON qr.questionrequestid = qg.questionrequestid
            WHERE qg.isdeleted = 0 AND qr.isdeleted=0
			AND (lower(qr.usercode) = lower(par_usercode) OR lower(COALESCE(par_usercode,''))='')
        AND qr.isdeleted = 0
        AND lower(qr.custcode) = lower(par_custcode)
        AND lower(qr.orgcode) = lower(par_orgcode)
        AND lower(qr.appcode) = lower(par_appcode)
        AND ( qr.booknameid = par_booknameid OR coalesce(par_booknameid, 0) = 0 )
        AND ( lower(qr.chaptercode) = lower(par_chaptercode) OR coalesce(par_chaptercode, '') = '')
        AND ( lower(qr.locode) = lower(par_locode) OR coalesce(par_locode, '') = '')
        AND (qr.questiontypeid = par_questiontypeid OR coalesce(par_questiontypeid, 0) = 0)
        AND ( qr.taxonomyid = par_taxonomyid OR coalesce(par_taxonomyid, 0) = 0 )
        AND (qr.sourcetype = par_sourcetype or par_sourcetype=0)
        AND (
                jsonb_typeof(qg.questionxml) IS NOT NULL
                AND jsonb_typeof(qg.questionxml) IN ('object', 'array')
		)
	 ),
        UsernameCTE AS (
            SELECT u.usercode, COALESCE(u.firstname,'') || ' '|| COALESCE(u.lastname,'') AS username
            FROM dblink('dbname=aihubdata user=postgres password=AI@POC',
                        'SELECT usercode, firstname, lastname FROM tbluser U 
						INNER JOIN tblorganization O ON O.organizationid=U.organizationid
						WHERE lower(organizationcode) = lower(''' || par_orgcode || ''') AND U.isdeleted = 0 AND O.isdeleted = 0')
            AS u(usercode VARCHAR, firstname VARCHAR, lastname VARCHAR)
        )
        SELECT 
            qg.questionid, 
            qg.questionrequestid, 
            qg.questionxml, 
            qg.marks, 
            qg.keypoints,
            qg.questiontypeid,
            qt.questiontype,
            qg.questionguid,
            t1.taxonomy,
            l1.loname,
            b1.bookname,
            COALESCE(u.username, '') AS username,qg.sourcetype,c1.chaptername
		FROM  ValidQuestions qg 
        LEFT JOIN tblquestiontype qt ON qg.questiontypeid = qt.id AND qt.isdeleted = 0
        LEFT JOIN tbltaxonomy t1 ON t1.id = qg.taxonomyid AND t1.isdeleted = 0
        LEFT JOIN tbllearningoutcomes l1 ON lower(l1.locode) = lower(qg.locode) AND l1.isdeleted = 0
        LEFT JOIN tblbookdetails b1 ON qg.booknameid = b1.id AND b1.isdeleted = 0
		LEFT JOIN tblchapters c1 ON lower(c1.chaptercode)=lower(qg.chaptercode) AND c1.isdeleted = 0
        LEFT JOIN UsernameCTE u ON lower(u.usercode) = lower(qg.usercode);

END;
$BODY$;
ALTER PROCEDURE public.uspgetquestionxml(character varying, character varying, character varying, character varying, bigint, character varying, character varying, bigint, bigint, bigint, bigint, bigint, refcursor)
    OWNER TO postgres;
