-- PROCEDURE: nr.uspdeletesessiondetails(bigint, character varying)

-- DROP PROCEDURE IF EXISTS nr.uspdeletesessiondetails(bigint, character varying);

CREATE OR REPLACE PROCEDURE nr.uspdeletesessiondetails(
	IN par_sessiondetailsid bigint,
	INOUT par_status character varying DEFAULT ''::character varying)
LANGUAGE 'plpgsql'
AS $BODY$

/* ============================================================ */
/* Author: Raghuveer */
/* Create date:  07-02-2024 */
/* Description: */
/* ============================================================ */

    BEGIN
        IF EXISTS (SELECT
            1
            FROM nr.sessiondetails
            WHERE sessiondetailsid = par_SessionDetailsID AND isdeleted = 0) THEN
            UPDATE nr.sessiondetails
            SET isdeleted = 1, modifieddate = timezone('UTC', CURRENT_TIMESTAMP(6))
                WHERE sessiondetailsid = par_SessionDetailsID;
            par_Status := 'S001';
        ELSE
            par_Status := 'S002';
        END IF;
       
END;
$BODY$;
ALTER PROCEDURE nr.uspdeletesessiondetails(bigint, character varying)
    OWNER TO postgres;
