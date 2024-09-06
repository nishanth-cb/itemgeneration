-- PROCEDURE: nr.uspfetchpartnerintegrationids(character varying, integer, refcursor)

-- DROP PROCEDURE IF EXISTS nr.uspfetchpartnerintegrationids(character varying, integer, refcursor);

CREATE OR REPLACE PROCEDURE nr.uspfetchpartnerintegrationids(
	IN par_status character varying,
	IN par_stitchstatus integer,
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
        SELECT DISTINCT
            partnerintegrationid
            FROM nr.userdetails
            WHERE status::character varying = par_status AND stitchstatus = par_stitchStatus::character varying;
        /* Select PartnerIntegrationIds */
        
END;
$BODY$;
ALTER PROCEDURE nr.uspfetchpartnerintegrationids(character varying, integer, refcursor)
    OWNER TO postgres;
