-- PROCEDURE: nr.uspinsertsessiondetails(character varying, timestamp without time zone, timestamp without time zone, text, text, text, numeric, character varying, character varying, bigint, bigint, character varying)

-- DROP PROCEDURE IF EXISTS nr.uspinsertsessiondetails(character varying, timestamp without time zone, timestamp without time zone, text, text, text, numeric, character varying, character varying, bigint, bigint, character varying);

CREATE OR REPLACE PROCEDURE nr.uspinsertsessiondetails(
	IN par_sessionid character varying DEFAULT ''::character varying,
	IN par_starttime timestamp without time zone DEFAULT NULL::timestamp without time zone,
	IN par_endtime timestamp without time zone DEFAULT NULL::timestamp without time zone,
	IN par_videosgenerated text DEFAULT ''::text,
	IN par_uploadattemptedvideos text DEFAULT ''::text,
	IN par_faileduploads text DEFAULT ''::text,
	IN par_successfullycompleted numeric DEFAULT NULL::numeric,
	IN par_remark character varying DEFAULT ''::character varying,
	IN par_supersessionid character varying DEFAULT ''::character varying,
	IN par_partnerintegrationid bigint DEFAULT 0,
	IN par_createdby bigint DEFAULT 0,
	INOUT par_status character varying DEFAULT ''::character varying)
LANGUAGE 'plpgsql'
AS $BODY$

/* ============================================================ */
/* Author: Raghuveer */
/* Create date:  06-02-2024 */
/* Description: */
/* ============================================================ */

    BEGIN
        INSERT INTO nr.sessiondetails (sessionid, starttime, endtime, videosgenerated, uploadattemptedvideos, faileduploads, successfullycompleted, remark, supersessionid, partnerintegrationid, createdby)
        VALUES (par_SessionID, par_StartTime, par_EndTime, par_VideosGenerated, par_UploadAttemptedVideos, par_FailedUploads, aws_sqlserver_ext.tomsbit(par_SuccessfullyCompleted), par_Remark, par_SuperSessionID, par_PartnerIntegrationID, par_CreatedBy);
        par_Status := 'S001';
       
END;
$BODY$;
ALTER PROCEDURE nr.uspinsertsessiondetails(character varying, timestamp without time zone, timestamp without time zone, text, text, text, numeric, character varying, character varying, bigint, bigint, character varying)
    OWNER TO postgres;
