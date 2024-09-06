-- PROCEDURE: nr.uspinsertattemptdetails(bigint, bigint, character varying, numeric, numeric, timestamp without time zone, timestamp without time zone, integer, integer, character varying, character varying, numeric, integer, character varying, bigint)

-- DROP PROCEDURE IF EXISTS nr.uspinsertattemptdetails(bigint, bigint, character varying, numeric, numeric, timestamp without time zone, timestamp without time zone, integer, integer, character varying, character varying, numeric, integer, character varying, bigint);

CREATE OR REPLACE PROCEDURE nr.uspinsertattemptdetails(
	IN par_partnerintegrationid bigint,
	IN par_attemptid bigint,
	IN par_sessionid character varying,
	IN par_isscreen numeric,
	IN par_webcam numeric,
	IN par_schedulestarttime timestamp without time zone,
	IN par_scheduleendtime timestamp without time zone,
	IN par_status integer,
	IN par_totalduration integer,
	IN par_supersessionid character varying,
	IN par_videotype character varying,
	IN par_isrerecording numeric,
	IN par_recordingnumber integer,
	INOUT par_statuscode character varying DEFAULT ''::character varying,
	IN par_createdby bigint DEFAULT NULL::bigint)
LANGUAGE 'plpgsql'
AS $BODY$

/* ============================================================ */
/* Author: Raghuveer */
/* Create date:  06-02-2024 */
/* Description: */
/* ============================================================ */

BEGIN
   
        INSERT INTO nr.attemptdetails (partnerintegrationid, attemptid, sessionid, isscreen, webcam, schedulestarttime, scheduleendtime, status, totalduration, supersessionid, videotype, isrerecording, recordingnumber, statuscode, createdby)
        VALUES (par_PartnerIntegrationID, par_AttemptID, par_SessionID, aws_sqlserver_ext.tomsbit(par_IsScreen), aws_sqlserver_ext.tomsbit(par_Webcam), par_ScheduleStartTime, par_ScheduleEndTime, par_Status, par_TotalDuration, par_SuperSessionID, par_VideoType, aws_sqlserver_ext.tomsbit(par_IsRerecording), par_RecordingNumber, par_StatusCode, par_CreatedBy);
        par_StatusCode := 'S001';
       
       
END;
$BODY$;
ALTER PROCEDURE nr.uspinsertattemptdetails(bigint, bigint, character varying, numeric, numeric, timestamp without time zone, timestamp without time zone, integer, integer, character varying, character varying, numeric, integer, character varying, bigint)
    OWNER TO postgres;
