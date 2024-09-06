-- PROCEDURE: nr.uspgetactivesessiondetails(character varying, refcursor)

-- DROP PROCEDURE IF EXISTS nr.uspgetactivesessiondetails(character varying, refcursor);

CREATE OR REPLACE PROCEDURE nr.uspgetactivesessiondetails(
	IN par_sessionid character varying,
	INOUT p_refcur refcursor)
LANGUAGE 'plpgsql'
AS $BODY$

/* ============================================================ */
/* Author: Raghuveer */
/* Create date:  09-02-2024 */
/* Description: retrieves details of an active session by @sessionId */
/* ============================================================ */

    BEGIN
        OPEN p_refcur FOR
        SELECT
            activesessionsid, sessionid, initialconnection, currentstate, statechangetime, videosgenerated, videosuploadfailed, videosuploadsuccess, disconnectedsince, partnerintegrationid, supersessionid
            FROM nr.activesessions
            WHERE LOWER(sessionid) = LOWER(par_sessionId) AND isdeleted = 0;
        
END;
$BODY$;
ALTER PROCEDURE nr.uspgetactivesessiondetails(character varying, refcursor)
    OWNER TO postgres;
