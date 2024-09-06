-- PROCEDURE: nr.uspupdatesessionstatus(character varying, numeric, character varying)

-- DROP PROCEDURE IF EXISTS nr.uspupdatesessionstatus(character varying, numeric, character varying);

CREATE OR REPLACE PROCEDURE nr.uspupdatesessionstatus(
	IN par_sessionid character varying,
	IN par_successfullycompleted numeric,
	INOUT par_status character varying DEFAULT ''::character varying)
LANGUAGE 'plpgsql'
AS $BODY$

/* ============================================================ */
/* Author: Raghuveer */
/* Create date:  08-02-2024 */
/* Description: */
/* History : */
/* ============================================================ */

    BEGIN
        IF EXISTS (SELECT
            1
            FROM nr.sessiondetails
            WHERE LOWER(sessionid) = LOWER(par_SessionID) AND isdeleted = 0) THEN
            UPDATE nr.sessiondetails
            SET successfullycompleted = par_SuccessfullyCompleted
                WHERE LOWER(sessionid) = LOWER(par_SessionID) AND starttime != '' AND endtime = '' AND successfullycompleted = '' AND isdeleted = 0;
            par_Status := 'S001';
        ELSE
            par_Status := 'S002';
        END IF;
       
END;
$BODY$;
ALTER PROCEDURE nr.uspupdatesessionstatus(character varying, numeric, character varying)
    OWNER TO postgres;
