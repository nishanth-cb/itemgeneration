-- PROCEDURE: nr.uspinserterrorlog(bigint, bigint, character varying, character varying, character varying, character varying, character varying, bigint, character varying, character varying, character varying, character varying)

-- DROP PROCEDURE IF EXISTS nr.uspinserterrorlog(bigint, bigint, character varying, character varying, character varying, character varying, character varying, bigint, character varying, character varying, character varying, character varying);

CREATE OR REPLACE PROCEDURE nr.uspinserterrorlog(
	IN par_partnerintegrationid bigint DEFAULT 0,
	IN par_attemptid bigint DEFAULT 0,
	IN par_supersessionid character varying DEFAULT ''::character varying,
	IN par_sessionid character varying DEFAULT ''::character varying,
	IN par_errordetails character varying DEFAULT ''::character varying,
	IN par_errordescription character varying DEFAULT ''::character varying,
	IN par_errorcode character varying DEFAULT ''::character varying,
	IN par_createdby bigint DEFAULT 0,
	IN par_extension1 character varying DEFAULT ''::character varying,
	IN par_extension2 character varying DEFAULT ''::character varying,
	IN par_extension3 character varying DEFAULT ''::character varying,
	INOUT par_status character varying DEFAULT ''::character varying)
LANGUAGE 'plpgsql'
AS $BODY$

/* ============================================================ */
/* Author: Raghuveer */
/* Create date:  06-02-2024 */
/* Description: */
/* ============================================================ */

    BEGIN
        INSERT INTO nr.errorlogs (partnerintegrationid, attemptid, supersessionid, sessionid, errordetails, errordescription, errorcode, createdby, extension1, extension2, extension3)
        VALUES (par_PartnerIntegrationID, par_AttemptID, par_SuperSessionID, par_SessionID, par_ErrorDetails, par_ErrorDescription, par_ErrorCode, par_CreatedBy, par_extension1, par_extension2, par_extension3);
        par_Status := 'S001';
      
END;
$BODY$;
ALTER PROCEDURE nr.uspinserterrorlog(bigint, bigint, character varying, character varying, character varying, character varying, character varying, bigint, character varying, character varying, character varying, character varying)
    OWNER TO postgres;
