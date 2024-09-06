-- PROCEDURE: nr.uspgetactivesessioncount(character varying, refcursor)

-- DROP PROCEDURE IF EXISTS nr.uspgetactivesessioncount(character varying, refcursor);

CREATE OR REPLACE PROCEDURE nr.uspgetactivesessioncount(
	IN par_sessionid character varying,
	INOUT p_refcur refcursor)
LANGUAGE 'plpgsql'
AS $BODY$

/* ============================================================ */
/* Author: Nishanth */
/* Create date:  09-02-2024 */
/* Description: To get the active session count */
/* ============================================================ */
DECLARE
    
    var_Count INTEGER;
   
    BEGIN
        SELECT
            COALESCE(COUNT(activesessionsid), 0)
            INTO var_Count
            FROM nr.activesessions
            WHERE LOWER(sessionid) = LOWER(par_sessionId) AND isdeleted = 0;
        OPEN p_refcur FOR
        SELECT
            var_Count AS count;
       
END;
$BODY$;
ALTER PROCEDURE nr.uspgetactivesessioncount(character varying, refcursor)
    OWNER TO postgres;
