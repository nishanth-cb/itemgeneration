-- PROCEDURE: nr.deleteactivesessions(bigint, character varying, refcursor)

-- DROP PROCEDURE IF EXISTS nr.deleteactivesessions(bigint, character varying, refcursor);

CREATE OR REPLACE PROCEDURE nr.deleteactivesessions(
	IN par_activesessionid bigint,
	INOUT par_status character varying DEFAULT ''::character varying,
	INOUT p_refcur refcursor DEFAULT NULL::refcursor)
LANGUAGE 'plpgsql'
AS $BODY$

/* ------------------------------------------------------------------------------------------------------------------- */
/* ============================================================ */
/* Author: Manu M S */
/* Create date:  07/02/2024 */
/* Description: */
/* ============================================================ */

    BEGIN
        /* Variables for capturing error */
        IF EXISTS (SELECT
            1
            FROM nr.activesessions
            WHERE activesessionsid = par_ActiveSessionID AND isdeleted = 0) THEN
            UPDATE nr.activesessions
            SET isdeleted = 1, modifieddate = timezone('UTC', CURRENT_TIMESTAMP(6))
                WHERE activesessionsid = par_ActiveSessionID;
            par_Status := 'S001';
        ELSE
            par_Status := 'S002';
        END IF;
       
END;
$BODY$;
ALTER PROCEDURE nr.deleteactivesessions(bigint, character varying, refcursor)
    OWNER TO postgres;
