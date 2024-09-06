-- PROCEDURE: nr.uspinsertuserdetails(bigint, bigint, bigint, character varying, numeric, integer, integer, character varying, character varying, bigint, integer, character varying, character varying, character varying, character varying)

-- DROP PROCEDURE IF EXISTS nr.uspinsertuserdetails(bigint, bigint, bigint, character varying, numeric, integer, integer, character varying, character varying, bigint, integer, character varying, character varying, character varying, character varying);

CREATE OR REPLACE PROCEDURE nr.uspinsertuserdetails(
	IN par_integrationuserid bigint DEFAULT 0,
	IN par_partnerintegrationid bigint DEFAULT 0,
	IN par_attemptid bigint DEFAULT 0,
	IN par_supersessionid character varying DEFAULT ''::character varying,
	IN par_isrerecording numeric DEFAULT NULL::numeric,
	IN par_recordingnumber integer DEFAULT 0,
	IN par_status1 integer DEFAULT 0,
	IN par_recordingurl character varying DEFAULT ''::character varying,
	IN par_totalduration character varying DEFAULT ''::character varying,
	IN par_createdby bigint DEFAULT NULL::bigint,
	IN par_roleid integer DEFAULT NULL::integer,
	IN par_statuscode character varying DEFAULT ''::character varying,
	IN par_s3url character varying DEFAULT ''::character varying,
	IN par_stitchstatus character varying DEFAULT ''::character varying,
	INOUT par_status character varying DEFAULT ''::character varying)
LANGUAGE 'plpgsql'
AS $BODY$

/* ============================================================ */
/* Author: Raghuveer */
/* Create date:  06-02-2024 */
/* Description: */
/* ============================================================ */

    BEGIN
        INSERT INTO nr.userdetails (integrationuserid, partnerintegrationid, attemptid, supersessionid, isrerecording, recordingnumber, status, recordingurl, totalduration, createdby, roleid, statuscode, s3url, stitchstatus)
        VALUES (par_IntegrationUserID, par_PartnerIntegrationID, par_AttemptID, par_SuperSessionID, aws_sqlserver_ext.tomsbit(par_IsReRecording), par_RecordingNumber, par_Status1, par_RecordingUrl, par_TotalDuration, par_CreatedBy, par_RoleId, par_StatusCode, par_S3Url, par_StitchStatus);
        par_Status := 'S001';
       
       
END;
$BODY$;
ALTER PROCEDURE nr.uspinsertuserdetails(bigint, bigint, bigint, character varying, numeric, integer, integer, character varying, character varying, bigint, integer, character varying, character varying, character varying, character varying)
    OWNER TO postgres;
