-- PROCEDURE: nr.uspgetsessiondetailsbysessionid(character varying, refcursor)

-- DROP PROCEDURE IF EXISTS nr.uspgetsessiondetailsbysessionid(character varying, refcursor);

CREATE OR REPLACE PROCEDURE nr.uspgetsessiondetailsbysessionid(
	IN par_sessionid character varying,
	INOUT p_refcur refcursor)
LANGUAGE 'plpgsql'
AS $BODY$

/* ============================================================ */
/* Author: Raghuveer */
/* Create date:  12-02-2024 */
/* Description: retrieves session details from the SessionDetails table */
/* ============================================================ */

    BEGIN
        BEGIN
            OPEN p_refcur FOR
            SELECT
                sessiondetailsid, sessionid, starttime, endtime, videosgenerated, uploadattemptedvideos, faileduploads, successfullycompleted, remark, supersessionid, partnerintegrationid
                FROM nr.sessiondetails
                WHERE LOWER(sessionid) = LOWER(par_sessionId) AND isdeleted = 0;
        END;
        
END;
$BODY$;
ALTER PROCEDURE nr.uspgetsessiondetailsbysessionid(character varying, refcursor)
    OWNER TO postgres;
