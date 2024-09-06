-- PROCEDURE: nr.uspinsertwebcamvideostatus(bigint, character varying, character varying, character varying, timestamp without time zone, timestamp without time zone, character varying, integer, numeric, integer, integer, character varying, numeric, integer, integer, integer, character varying, numeric, character varying, numeric, character varying, integer, character varying, integer, character varying, integer, integer, character varying, integer, numeric, integer, numeric, numeric, numeric, integer, integer, character varying, integer, character varying, character varying, character varying, character varying, character varying, character varying)

-- DROP PROCEDURE IF EXISTS nr.uspinsertwebcamvideostatus(bigint, character varying, character varying, character varying, timestamp without time zone, timestamp without time zone, character varying, integer, numeric, integer, integer, character varying, numeric, integer, integer, integer, character varying, numeric, character varying, numeric, character varying, integer, character varying, integer, character varying, integer, integer, character varying, integer, numeric, integer, numeric, numeric, numeric, integer, integer, character varying, integer, character varying, character varying, character varying, character varying, character varying, character varying);

CREATE OR REPLACE PROCEDURE nr.uspinsertwebcamvideostatus(
	IN par_videostatusid bigint,
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
	IN par_aspectratio numeric DEFAULT NULL::numeric,
	IN par_brightness integer DEFAULT NULL::integer,
	IN par_colortemperature integer DEFAULT NULL::integer,
	IN par_contrast integer DEFAULT NULL::integer,
	IN par_deviceid character varying DEFAULT ''::character varying,
	IN par_exposurecompensation numeric DEFAULT NULL::numeric,
	IN par_exposuremode character varying DEFAULT ''::character varying,
	IN par_exposuretime numeric DEFAULT NULL::numeric,
	IN par_facingmode character varying DEFAULT ''::character varying,
	IN par_framerate integer DEFAULT NULL::integer,
	IN par_groupid character varying DEFAULT ''::character varying,
	IN par_height integer DEFAULT NULL::integer,
	IN par_resizemode character varying DEFAULT ''::character varying,
	IN par_saturation integer DEFAULT NULL::integer,
	IN par_sharpness integer DEFAULT NULL::integer,
	IN par_whitebalancemode character varying DEFAULT ''::character varying,
	IN par_width integer DEFAULT NULL::integer,
	IN par_autogaincontrol numeric DEFAULT NULL::numeric,
	IN par_channelcount integer DEFAULT NULL::integer,
	IN par_echocancellation numeric DEFAULT NULL::numeric,
	IN par_latency numeric DEFAULT NULL::numeric,
	IN par_noisesuppression numeric DEFAULT NULL::numeric,
	IN par_samplerate integer DEFAULT NULL::integer,
	IN par_samplesize integer DEFAULT NULL::integer,
	IN par_blobhash character varying DEFAULT ''::character varying,
	IN par_filesize integer DEFAULT NULL::integer,
	IN par_etag character varying DEFAULT ''::character varying,
	IN par_md5 character varying DEFAULT ''::character varying,
	IN par_savewebmlocal character varying DEFAULT ''::character varying,
	IN par_uploadtos3 character varying DEFAULT ''::character varying,
	IN par_deletelocalwebm character varying DEFAULT ''::character varying,
	IN par_videostatus character varying DEFAULT ''::character varying)
LANGUAGE 'plpgsql'
AS $BODY$

/* ============================================================ */
/* Author: Manu M S */
/* Create date:  08-02-2024 */
/* Description: */
/* ============================================================ */

    BEGIN
        /* Variables for capturing error */
        INSERT INTO nativerecording_nr.webcamvideostatus (videostatusid, sessionid, partid, filename, starttime, endtime, source, videotag, duration, audiobitspersecond, videobitspersecond, mimetype, aspectratio, brightness, colortemperature, contrast, deviceid, exposurecompensation, exposuremode, exposuretime, facingmode, framerate, groupid, height, resizemode, saturation, sharpness, whitebalancemode, width, autogaincontrol, channelcount, echocancellation, latency, noisesuppression, samplerate, samplesize, blobhash, filesize, etag, md5, savewebmlocal, uploadtos3, deletelocalwebm, videostatus)
        VALUES (par_VideoStatusID, par_SessionID, par_PartID, par_FileName, par_StartTime, par_EndTime, par_Source, par_VideoTag, par_Duration, par_AudioBitsPerSecond, par_VideoBitsPerSecond, par_MimeType, par_aspectRatio, par_Brightness, par_ColorTemperature, par_Contrast, par_DeviceId, par_ExposureCompensation, par_ExposureMode, par_ExposureTime, par_FacingMode, par_FrameRate, par_GroupID, par_Height, par_ResizeMode, par_Saturation, par_Sharpness, par_WhiteBalanceMode, par_Width, aws_sqlserver_ext.tomsbit(par_autoGainControl), par_ChannelCount, aws_sqlserver_ext.tomsbit(par_EchoCancellation), par_Latency, aws_sqlserver_ext.tomsbit(par_NoiseSuppression), par_SampleRate, par_SampleSize, par_BlobHash, par_FileSize, par_ETag, par_Md5, par_SaveWebmLocal, par_UploadToS3, par_DeleteLocalWebm, par_VideoStatus);
       
END;
$BODY$;
ALTER PROCEDURE nr.uspinsertwebcamvideostatus(bigint, character varying, character varying, character varying, timestamp without time zone, timestamp without time zone, character varying, integer, numeric, integer, integer, character varying, numeric, integer, integer, integer, character varying, numeric, character varying, numeric, character varying, integer, character varying, integer, character varying, integer, integer, character varying, integer, numeric, integer, numeric, numeric, numeric, integer, integer, character varying, integer, character varying, character varying, character varying, character varying, character varying, character varying)
    OWNER TO postgres;
