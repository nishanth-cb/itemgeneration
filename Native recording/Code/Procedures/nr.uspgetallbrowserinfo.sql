-- PROCEDURE: nr.uspgetallbrowserinfo(refcursor)

-- DROP PROCEDURE IF EXISTS nr.uspgetallbrowserinfo(refcursor);

CREATE OR REPLACE PROCEDURE nr.uspgetallbrowserinfo(
	INOUT p_refcur refcursor)
LANGUAGE 'plpgsql'
AS $BODY$

/* ============================================================ */
/* Author: Raghuveer */
/* Create date:  07-02-2024 */
/* Description: */
/* ============================================================ */

    BEGIN
        OPEN p_refcur FOR
        SELECT
            browserinfoid, sessionid, browserdetails
            FROM nr.browserinfo
            WHERE isdeleted = 0;
        
END;
$BODY$;
ALTER PROCEDURE nr.uspgetallbrowserinfo(refcursor)
    OWNER TO postgres;
