-- PROCEDURE: nr.uspgets3url(bigint, character varying, refcursor)

-- DROP PROCEDURE IF EXISTS nr.uspgets3url(bigint, character varying, refcursor);

CREATE OR REPLACE PROCEDURE nr.uspgets3url(
	IN par_partnerintegrationid bigint,
	IN par_supersessionid character varying,
	INOUT p_refcur refcursor)
LANGUAGE 'plpgsql'
AS $BODY$

/* ============================================================ */
/* Author: Manu M S */
/* Create date:  08/02/2024 */
/* Description: */
/* ============================================================ */

    BEGIN
        /* Variables for capturing error */
        OPEN p_refcur FOR
        SELECT
            s3url, status
            FROM nr.userdetails
            WHERE partnerintegrationid = par_partnerIntegrationId AND LOWER(supersessionid) = LOWER(par_superSessionId) AND isdeleted = 0;
        /* selecting S3Url and Status columns if partnerintegrationid and supersessionid is present */
      
END;
$BODY$;
ALTER PROCEDURE nr.uspgets3url(bigint, character varying, refcursor)
    OWNER TO postgres;
