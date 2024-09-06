-- PROCEDURE: nr.uspgetattemptdetails(refcursor)

-- DROP PROCEDURE IF EXISTS nr.uspgetattemptdetails(refcursor);

CREATE OR REPLACE PROCEDURE nr.uspgetattemptdetails(
	INOUT p_refcur refcursor)
LANGUAGE 'plpgsql'
AS $BODY$

/* ============================================================ */
/* Author: Nishanth */
/* Create date:  07-02-2024 */
/* Description: */
/* ============================================================ */

    BEGIN
        OPEN p_refcur FOR
        SELECT
            attemptdetailsid, partnerintegrationid, attemptid, sessionid, creationtime, isscreen, webcam, schedulestarttime, scheduleendtime, status, totalduration, supersessionid, videotype, isrerecording, recordingnumber, statuscode
            FROM nr.attemptdetails
            WHERE isdeleted = 0;
        
END;
$BODY$;
ALTER PROCEDURE nr.uspgetattemptdetails(refcursor)
    OWNER TO postgres;
