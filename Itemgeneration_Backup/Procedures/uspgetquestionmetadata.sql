-- PROCEDURE: public.uspgetquestionmetadata(character varying, character varying, character varying, refcursor)

-- DROP PROCEDURE IF EXISTS public.uspgetquestionmetadata(character varying, character varying, character varying, refcursor);

CREATE OR REPLACE PROCEDURE public.uspgetquestionmetadata(
	IN par_customercode character varying,
	IN par_orgcode character varying,
	IN par_appcode character varying,
	INOUT par_cursor refcursor DEFAULT NULL::refcursor)
LANGUAGE 'plpgsql'
AS $BODY$
declare var_customerid bigint;
BEGIN

OPEN par_cursor FOR
SELECT 1 id,'QuestionType' type,json_agg(row_to_json(A)) As Jsondetails
FROM (
    SELECT  qt.id, qt.questiontype,questiontypecode
    FROM tblquestiontype QT
	INNER JOIN tblcustomerconfiguration CC
	ON CC.mappingid=QT.id and qt.isdeleted=0 AND cc.isdeleted=0 and CC.type=1
	WHERE lower(CC.customercode)=lower(par_customercode) and lower(cc.orgcode)= lower(par_orgcode) 
	AND lower(cc.appcode)=lower(par_appcode) 
) A
UNION ALL
SELECT 2 id,'taxonomy' type,json_agg(row_to_json(B))
FROM (
    SELECT id, taxonomy
    FROM tbltaxonomy WHERE Isdeleted=0
) B
UNION ALL
SELECT 3 id,'difficultylevel' type,json_agg(row_to_json(C))
FROM (
    SELECT id, difficultylevel
    FROM tbldifficultylevel WHERE Isdeleted=0
) C
UNION ALL
SELECT 4 id,'bookname' type,json_agg(row_to_json(D))
FROM (
    SELECT id, bookname
    FROM tblbookdetails WHERE Isdeleted=0
) D
UNION ALL
SELECT 5 id,'numberof_questions' type,json_agg(row_to_json(E))
FROM (
	SELECT id,numberof_questions
	FROM tblquestionnumbers WHERE isdeleted=0
) E;

END
$BODY$;
ALTER PROCEDURE public.uspgetquestionmetadata(character varying, character varying, character varying, refcursor)
    OWNER TO postgres;
