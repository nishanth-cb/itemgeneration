-- PROCEDURE: nr.uspupdatestichingstatus(character varying, character varying, integer, character varying)

-- DROP PROCEDURE IF EXISTS nr.uspupdatestichingstatus(character varying, character varying, integer, character varying);

CREATE OR REPLACE PROCEDURE nr.uspupdatestichingstatus(
	IN par_supersessionid character varying,
	IN par_stitchstatus character varying,
	IN par_status1 integer,
	INOUT par_status character varying DEFAULT ''::character varying)
LANGUAGE 'plpgsql'
AS $BODY$

/* ============================================================ */
/* Author: Raghuveer */
/* Create date:  08-02-2024 */
/* Description: */
/* ============================================================ */

    BEGIN
        IF EXISTS (SELECT
            1
            FROM nr.userdetails
            WHERE LOWER(supersessionid) = LOWER(par_superSessionId) AND isdeleted = 0) THEN
            UPDATE nr.userdetails
            SET stitchstatus = par_stitchStatus, status = par_status1
                WHERE LOWER(supersessionid) = LOWER(par_superSessionId) AND isdeleted = 0;
            par_Status := 'S001';
        ELSE
            par_Status := 'S002';
        END IF;
       
END;
$BODY$;
ALTER PROCEDURE nr.uspupdatestichingstatus(character varying, character varying, integer, character varying)
    OWNER TO postgres;
