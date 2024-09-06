-- PROCEDURE: nr.uspgetallsessions(refcursor)

-- DROP PROCEDURE IF EXISTS nr.uspgetallsessions(refcursor);

CREATE OR REPLACE PROCEDURE nr.uspgetallsessions(
	INOUT p_refcur refcursor)
LANGUAGE 'plpgsql'
AS $BODY$

/* ============================================================ */
/* Author: Raghuveer */
/* Create date:  07-02-2024 */
/* Description: */
/* ============================================================ */

    BEGIN
        OPEN p_refcur FOR
        SELECT
            activesessionsid, sessionid, initialconnection, currentstate, statechangetime, videosgenerated, videosuploadfailed, videosuploadsuccess, disconnectedsince, partnerintegrationid, supersessionid
            FROM nr.activesessions
            WHERE isdeleted = 0;
        
END;
$BODY$;
ALTER PROCEDURE nr.uspgetallsessions(refcursor)
    OWNER TO postgres;
