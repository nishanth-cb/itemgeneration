-- PROCEDURE: nr.uspdeleteattemptdetails(bigint, character varying)

-- DROP PROCEDURE IF EXISTS nr.uspdeleteattemptdetails(bigint, character varying);

CREATE OR REPLACE PROCEDURE nr.uspdeleteattemptdetails(
	IN par_attemptdetailsid bigint,
	INOUT par_status character varying DEFAULT ''::character varying)
LANGUAGE 'plpgsql'
AS $BODY$

/* ============================================================ */
/* Author: Nishanth */
/* Create date:  07-02-2024 */
/* Description: */
/* ============================================================ */

    BEGIN
        IF EXISTS (SELECT
            1
            FROM nr.attemptdetails
            WHERE attemptdetailsid = par_AttemptDetailsId AND isdeleted = 0) THEN
            UPDATE nr.attemptdetails
            SET isdeleted = 1, modifieddate = timezone('UTC', CURRENT_TIMESTAMP(6))
                WHERE attemptdetailsid = par_AttemptDetailsId;
            par_Status := 'S001';
        ELSE
            par_Status := 'S002';
        END IF;
       
END;
$BODY$;
ALTER PROCEDURE nr.uspdeleteattemptdetails(bigint, character varying)
    OWNER TO postgres;
