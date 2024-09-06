-- PROCEDURE: nr.uspinsertvideostatus(character varying, character varying, character varying, bigint)

-- DROP PROCEDURE IF EXISTS nr.uspinsertvideostatus(character varying, character varying, character varying, bigint);

CREATE OR REPLACE PROCEDURE nr.uspinsertvideostatus(
	IN par_sessionid character varying DEFAULT ''::character varying,
	IN par_supersessionid character varying DEFAULT ''::character varying,
	INOUT par_status character varying DEFAULT ''::character varying,
	INOUT par_videostatusid bigint DEFAULT NULL::bigint)
LANGUAGE 'plpgsql'
AS $BODY$

/* ============================================================ */
/* Author: Manu M S */
/* Create date:  08-02-2024 */
/* Description: */
/* ============================================================ */

    BEGIN
        /* Variables for capturing error */
        INSERT INTO nr.videostatus (sessionid, supersessionid)
        VALUES (par_SessionId, par_SuperSessionID);
        par_Status := 'S001';
        par_VideoStatusID := SCOPE_IDENTITY;
       
END;
$BODY$;
ALTER PROCEDURE nr.uspinsertvideostatus(character varying, character varying, character varying, bigint)
    OWNER TO postgres;
