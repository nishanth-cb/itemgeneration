-- PROCEDURE: nr.uspinsertactivesessions(character varying, timestamp without time zone, character varying, timestamp without time zone, text, text, text, timestamp without time zone, bigint, character varying, bigint, bigint, character varying)

-- DROP PROCEDURE IF EXISTS nr.uspinsertactivesessions(character varying, timestamp without time zone, character varying, timestamp without time zone, text, text, text, timestamp without time zone, bigint, character varying, bigint, bigint, character varying);

CREATE OR REPLACE PROCEDURE nr.uspinsertactivesessions(
	IN par_sessionid character varying DEFAULT ''::character varying,
	IN par_initialconnection timestamp without time zone DEFAULT NULL::timestamp without time zone,
	IN par_currentstate character varying DEFAULT ''::character varying,
	IN par_statechangetime timestamp without time zone DEFAULT NULL::timestamp without time zone,
	IN par_videosgenerated text DEFAULT ''::text,
	IN par_videosuploadfailed text DEFAULT ''::text,
	IN par_videosuploadsuccess text DEFAULT ''::text,
	IN par_disconnectedsince timestamp without time zone DEFAULT NULL::timestamp without time zone,
	IN par_partnerintegrationid bigint DEFAULT 0,
	IN par_supersessionid character varying DEFAULT ''::character varying,
	IN par_createdby bigint DEFAULT 0,
	IN par_modifiedby bigint DEFAULT NULL::bigint,
	INOUT par_status character varying DEFAULT NULL::character varying)
LANGUAGE 'plpgsql'
AS $BODY$

/* ============================================================ */
/* Author: Nishanth */
/* Create date:  06-02-2024 */
/* Description: */
/* ============================================================ */

    BEGIN
        INSERT INTO nr.activesessions (sessionid, initialconnection, currentstate, statechangetime, videosgenerated, videosuploadfailed, videosuploadsuccess, disconnectedsince, partnerintegrationid, supersessionid, createdby, createddate, modifieddate, modifiedby, isdeleted)
        VALUES (par_SessionID, par_InitialConnection, par_CurrentState, par_StateChangeTime, par_VideosGenerated, par_VideosUploadFailed, par_VideosUploadSuccess, par_DisconnectedSince, par_PartnerIntegrationID, par_SuperSessionID, par_CreatedBy, timezone('UTC', CURRENT_TIMESTAMP(6)), timezone('UTC', CURRENT_TIMESTAMP(6)), par_ModifiedBy, 0);
        par_Status := 'S001';
    
      
   
END;
$BODY$;
ALTER PROCEDURE nr.uspinsertactivesessions(character varying, timestamp without time zone, character varying, timestamp without time zone, text, text, text, timestamp without time zone, bigint, character varying, bigint, bigint, character varying)
    OWNER TO postgres;
