-- PROCEDURE: nr.uspgetuserdetails(refcursor)

-- DROP PROCEDURE IF EXISTS nr.uspgetuserdetails(refcursor);

CREATE OR REPLACE PROCEDURE nr.uspgetuserdetails(
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
            userdetailsid, integrationuserid, partnerintegrationid, attemptid, supersessionid, isrerecording, recordingnumber, status, recordingurl, totalduration, roleid, statuscode, s3url, stitchstatus
            FROM nr.userdetails
            WHERE isdeleted = 0;
       
END;
$BODY$;
ALTER PROCEDURE nr.uspgetuserdetails(refcursor)
    OWNER TO postgres;
