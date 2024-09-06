-- PROCEDURE: nr.uspupdatesessionexitdetails(character varying, character varying, timestamp without time zone, numeric, character varying)

-- DROP PROCEDURE IF EXISTS nr.uspupdatesessionexitdetails(character varying, character varying, timestamp without time zone, numeric, character varying);

CREATE OR REPLACE PROCEDURE nr.uspupdatesessionexitdetails(
	IN par_sessionid character varying,
	IN par_data character varying,
	IN par_endtime timestamp without time zone,
	IN par_successfullycompleted numeric,
	INOUT par_status character varying DEFAULT ''::character varying)
LANGUAGE 'plpgsql'
AS $BODY$

/* ============================================================ */
/* Author: Manu M S */
/* Create date:  08/02/2024 */
/* Description: */
/* ============================================================ */

    BEGIN
        /* Variables for capturing error */
        IF EXISTS (SELECT
            1
            FROM nativerecording_nr.sessiondetails
            WHERE LOWER(sessionid) = LOWER(par_SessionId) AND isdeleted = 0) THEN
            UPDATE nativerecording_nr.sessiondetails
            SET endtime = par_endTime, successfullycompleted = par_SuccessfullyCompleted, remark = par_Data
                WHERE LOWER(sessionid) = LOWER(par_SessionId) AND starttime != NULL AND endtime = NULL AND successfullycompleted = NULL AND isdeleted = 0;
            par_Status := 'S001';
        ELSE
            par_Status := 'S002';
        END IF;
        
END;
$BODY$;
ALTER PROCEDURE nr.uspupdatesessionexitdetails(character varying, character varying, timestamp without time zone, numeric, character varying)
    OWNER TO postgres;
