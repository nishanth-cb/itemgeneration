-- PROCEDURE: nr.deletebrowserinfo(bigint, character varying)

-- DROP PROCEDURE IF EXISTS nr.deletebrowserinfo(bigint, character varying);

CREATE OR REPLACE PROCEDURE nr.deletebrowserinfo(
	IN par_browserinfoid bigint,
	INOUT par_status character varying DEFAULT ''::character varying)
LANGUAGE 'plpgsql'
AS $BODY$

/* ------------------------------------------------------------------------------------------------------------------------ */
/* ----------------------------------------------------------------------------------------------------------------------- */
/* ============================================================ */
/* Author: Nishanth */
/* Create date:  07-02-2024 */
/* Description: */
/* ============================================================ */

    BEGIN
        IF EXISTS (SELECT
            1
            FROM nr.browserinfo
            WHERE browserinfoid = par_BrowserInfoId AND isdeleted = 0) THEN
            UPDATE nr.browserinfo
            SET isdeleted = 1, modifieddate = timezone('UTC', CURRENT_TIMESTAMP(6))
                WHERE browserinfoid = par_BrowserInfoId;
            par_Status := 'S001';
        ELSE
            par_Status := 'S002';
        END IF;
        
    
END;
$BODY$;
ALTER PROCEDURE nr.deletebrowserinfo(bigint, character varying)
    OWNER TO postgres;
