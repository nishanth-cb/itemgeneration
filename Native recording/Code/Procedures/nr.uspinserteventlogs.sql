-- PROCEDURE: nr.uspinserteventlogs(bigint, bigint, character varying, character varying, integer, character varying, bigint, bigint, character varying, character varying, character varying, character varying)

-- DROP PROCEDURE IF EXISTS nr.uspinserteventlogs(bigint, bigint, character varying, character varying, integer, character varying, bigint, bigint, character varying, character varying, character varying, character varying);

CREATE OR REPLACE PROCEDURE nr.uspinserteventlogs(
	IN par_partnerintegrationid bigint DEFAULT 0,
	IN par_attemptid bigint DEFAULT 0,
	IN par_supersessionid character varying DEFAULT ''::character varying,
	IN par_sessionid character varying DEFAULT ''::character varying,
	IN par_eventtype integer DEFAULT 0,
	IN par_eventdescription character varying DEFAULT ''::character varying,
	IN par_createdby bigint DEFAULT 0,
	IN par_modifiedby bigint DEFAULT NULL::bigint,
	IN par_extension1 character varying DEFAULT NULL::character varying,
	IN par_extension2 character varying DEFAULT NULL::character varying,
	IN par_extension3 character varying DEFAULT NULL::character varying,
	INOUT par_status character varying DEFAULT NULL::character varying)
LANGUAGE 'plpgsql'
AS $BODY$

/* ============================================================ */
/* Author: Nishanth */
/* Create date:  06-02-2024 */
/* Description: */
/* ============================================================ */

    BEGIN
        INSERT INTO nr.eventlogs (partnerintegrationid, attemptid, supersessionid, sessionid, eventtype, eventdescription, createddate, modifieddate, createdby, modifiedby, isdeleted, extension1, extension2, extension3)
        VALUES (par_PartnerIntegrationID, par_AttemptId, par_SuperSessionID, par_SessionID, par_EventType, par_EventDescription, timezone('UTC', CURRENT_TIMESTAMP(6)), timezone('UTC', CURRENT_TIMESTAMP(6)), par_CreatedBy, par_ModifiedBy, 0, par_Extension1, par_Extension2, par_Extension3);
        par_Status := 'S001';
       
END;
$BODY$;
ALTER PROCEDURE nr.uspinserteventlogs(bigint, bigint, character varying, character varying, integer, character varying, bigint, bigint, character varying, character varying, character varying, character varying)
    OWNER TO postgres;
