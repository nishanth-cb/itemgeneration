-- PROCEDURE: nr.uspgetwebcamvideostatusfilenames(character varying, refcursor)

-- DROP PROCEDURE IF EXISTS nr.uspgetwebcamvideostatusfilenames(character varying, refcursor);

CREATE OR REPLACE PROCEDURE nr.uspgetwebcamvideostatusfilenames(
	IN par_supersessionid character varying,
	INOUT p_refcur refcursor)
LANGUAGE 'plpgsql'
AS $BODY$

/* ============================================================ */
/* Author: Raghuveer */
/* Create date:  12-02-2024 */
/* Description: retrieves filenames from the WebCamVideoStatus table,VideoStatus table. */
/* ============================================================ */

    BEGIN
        BEGIN
            OPEN p_refcur FOR
            SELECT
                wvs.filename
                FROM nr.webcamvideostatus AS wvs
                INNER JOIN nr.videostatus AS vs
                    ON wvs.videostatusid = vs.videostatusid
                WHERE LOWER(vs.supersessionid) = LOWER(par_superSessionId) AND wvs.isdeleted = 0
                ORDER BY wvs.starttime ASC NULLS FIRST;
        END;
        
END;
$BODY$;
ALTER PROCEDURE nr.uspgetwebcamvideostatusfilenames(character varying, refcursor)
    OWNER TO postgres;
