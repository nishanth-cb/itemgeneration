-- PROCEDURE: nr.deleteuserdetail(bigint, character varying)

-- DROP PROCEDURE IF EXISTS nr.deleteuserdetail(bigint, character varying);

CREATE OR REPLACE PROCEDURE nr.deleteuserdetail(
	IN par_userdetailsid bigint,
	INOUT par_status character varying DEFAULT ''::character varying)
LANGUAGE 'plpgsql'
AS $BODY$

/* ============================================================ */
/* Author: Manu M S */
/* Create date:  07/02/2024 */
/* Description: */
/* ============================================================ */

    BEGIN
        IF EXISTS (SELECT
            1
            FROM nr.userdetails
            WHERE userdetailsid = par_UserDetailsId AND isdeleted = 0) THEN
            UPDATE nr.userdetails
            SET isdeleted = 1, modifieddate = timezone('UTC', CURRENT_TIMESTAMP(6))
                WHERE userdetailsid = par_UserDetailsId;
            par_Status := 'S001';
        ELSE
            par_Status := 'S002';
        END IF;
       
END;
$BODY$;
ALTER PROCEDURE nr.deleteuserdetail(bigint, character varying)
    OWNER TO postgres;
