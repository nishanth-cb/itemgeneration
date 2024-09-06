-- PROCEDURE: nr.uspinsertrawvideoinfo(character varying, character varying, character varying, timestamp without time zone, timestamp without time zone, character varying, integer, numeric, integer, integer, character varying, bigint, character varying, bigint, bigint, character varying, bigint)

-- DROP PROCEDURE IF EXISTS nr.uspinsertrawvideoinfo(character varying, character varying, character varying, timestamp without time zone, timestamp without time zone, character varying, integer, numeric, integer, integer, character varying, bigint, character varying, bigint, bigint, character varying, bigint);

CREATE OR REPLACE PROCEDURE nr.uspinsertrawvideoinfo(
	IN par_sessionid character varying DEFAULT ''::character varying,
	IN par_partid character varying DEFAULT ''::character varying,
	IN par_filename character varying DEFAULT ''::character varying,
	IN par_starttime timestamp without time zone DEFAULT NULL::timestamp without time zone,
	IN par_endtime timestamp without time zone DEFAULT NULL::timestamp without time zone,
	IN par_source character varying DEFAULT ''::character varying,
	IN par_videotag integer DEFAULT NULL::integer,
	IN par_duration numeric DEFAULT NULL::numeric,
	IN par_audiobitspersecond integer DEFAULT NULL::integer,
	IN par_videobitspersecond integer DEFAULT NULL::integer,
	IN par_mimetype character varying DEFAULT ''::character varying,
	IN par_partnerintegrationid bigint DEFAULT NULL::bigint,
	IN par_supersessionid character varying DEFAULT ''::character varying,
	IN par_createdby bigint DEFAULT NULL::bigint,
	IN par_modifiedby bigint DEFAULT NULL::bigint,
	INOUT par_status character varying DEFAULT ''::character varying,
	INOUT par_rawvideoinfo bigint DEFAULT NULL::bigint)
LANGUAGE 'plpgsql'
AS $BODY$

/* ============================================================ */
/* Author: Nishanth */
/* Create date:  08-02-2024 */
/* Description: */
/* ============================================================ */

    BEGIN
        INSERT INTO nr.rawvideoinfo (sessionid, partid, filename, starttime, endtime, source, videotag, duration, audiobitspersecond, videobitspersecond, mimetype, partnerintegrationid, supersessionid, createdby, createddate, modifieddate, modifiedby, isdeleted)
        VALUES (par_SessionID, par_PartID, par_FileName, par_StartTime, par_EndTime, par_Source, par_VideoTag, par_Duration, par_AudioBitsPerSecond, par_VideoBitsPerSecond, par_MimeType, par_PartnerIntegrationID, par_SuperSessionID, par_CreatedBy, timezone('UTC', CURRENT_TIMESTAMP(6)), timezone('UTC', CURRENT_TIMESTAMP(6)), par_ModifiedBy, 0);
        par_RawVideoInfo := SCOPE_IDENTITY;
        par_Status := 'S001';
        /* Insert data into RawVideoInfo table */
       
	END;
$BODY$;
ALTER PROCEDURE nr.uspinsertrawvideoinfo(character varying, character varying, character varying, timestamp without time zone, timestamp without time zone, character varying, integer, numeric, integer, integer, character varying, bigint, character varying, bigint, bigint, character varying, bigint)
    OWNER TO postgres;
