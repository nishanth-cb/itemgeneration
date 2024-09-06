-- PROCEDURE: nr.uspgetallsessiondetails(refcursor)

-- DROP PROCEDURE IF EXISTS nr.uspgetallsessiondetails(refcursor);

CREATE OR REPLACE PROCEDURE nr.uspgetallsessiondetails(
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
            sessiondetailsid, sessionid, starttime, endtime, videosgenerated, uploadattemptedvideos, faileduploads, successfullycompleted, remark, supersessionid, partnerintegrationid
            FROM nr.sessiondetails
            WHERE isdeleted = 0;
        
END;
$BODY$;
ALTER PROCEDURE nr.uspgetallsessiondetails(refcursor)
    OWNER TO postgres;
