-- PROCEDURE: nr.uspgetsupersessionids(integer, integer, character varying, refcursor)

-- DROP PROCEDURE IF EXISTS nr.uspgetsupersessionids(integer, integer, character varying, refcursor);

CREATE OR REPLACE PROCEDURE nr.uspgetsupersessionids(
	IN par_supersessionstatus integer,
	IN par_stichstatus integer,
	INOUT par_status character varying DEFAULT ''::character varying,
	INOUT p_refcur refcursor DEFAULT NULL::refcursor)
LANGUAGE 'plpgsql'
AS $BODY$

/* ============================================================ */
/* Author: Nishanth */
/* Create date:  07-02-2024 */
/* Description: */
/* ============================================================ */

    BEGIN
        UPDATE nr.userdetails
        SET stitchstatus = '1'
            WHERE status = par_superSessionStatus AND stitchstatus = CAST (par_StichStatus AS VARCHAR(100));
        /* Select SuperSessionIds */
        OPEN p_refcur FOR
        SELECT DISTINCT
            supersessionid
            FROM nr.userdetails
            WHERE status = par_superSessionStatus AND LOWER(stitchstatus) = LOWER('1');
        /* Set status to success */
        par_Status := 'S001';
        /* Update records in UserDetails table */
       
END;
$BODY$;
ALTER PROCEDURE nr.uspgetsupersessionids(integer, integer, character varying, refcursor)
    OWNER TO postgres;
