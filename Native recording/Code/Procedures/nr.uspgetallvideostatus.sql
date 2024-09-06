-- PROCEDURE: nr.uspgetallvideostatus(refcursor, refcursor, refcursor)

-- DROP PROCEDURE IF EXISTS nr.uspgetallvideostatus(refcursor, refcursor, refcursor);

CREATE OR REPLACE PROCEDURE nr.uspgetallvideostatus(
	INOUT p_refcur refcursor,
	INOUT p_refcur_2 refcursor,
	INOUT p_refcur_3 refcursor)
LANGUAGE 'plpgsql'
AS $BODY$

/* ============================================================ */
/* Author: Nishanth */
/* Create date:  07-02-2024 */
/* Description: to get the all video status. */
/* ============================================================ */

    BEGIN
        OPEN p_refcur FOR
        SELECT
            videostatusid, sessionid, supersessionid
            FROM nr.videostatus
            WHERE isdeleted = 0;
        CREATE TEMPORARY TABLE videostatusid$uspgetallvideostatus
        (videostatusid BIGINT);
        INSERT INTO videostatusid$uspgetallvideostatus
        SELECT
            videostatusid
            FROM nr.videostatus
            WHERE isdeleted = 0;
        /* Retrieve data from [NR].[ScreenVideoStatus] */
        OPEN p_refcur_2 FOR
        SELECT
            screenvideostatusid, videostatusid, sessionid, partid, filename, starttime, endtime, source, videotag, duration, audiobitspersecond, videobitspersecond, mimetype, aspectratio, brightness, colortemperature, contrast, deviceid, exposurecompensation, exposuremode, exposuretime, facingmode, framerate, groupid, height, resizemode, saturation, sharpness, whitebalancemode, width, autogaincontrol, channelcount, echocancellation, latency, noisesuppression, samplerate, samplesize, blobhash, filesize, etag, md5, savewebmlocal, uploadtos3, deletelocalwebm, videostatus
            FROM nr.screenvideostatus
            WHERE isdeleted = 0 AND videostatusid IN (SELECT
                videostatusid
                FROM videostatusid$uspgetallvideostatus);
        /* Retrieve data from [NR].[WebCamVideoStatus] */
        OPEN p_refcur_3 FOR
        SELECT
            webcamvideostatusid, videostatusid, sessionid, partid, filename, starttime, endtime, source, videotag, duration, audiobitspersecond, videobitspersecond, mimetype, aspectratio, brightness, colortemperature, contrast, deviceid, exposurecompensation, exposuremode, exposuretime, facingmode, framerate, groupid, height, resizemode, saturation, sharpness, whitebalancemode, width, autogaincontrol, channelcount, echocancellation, latency, noisesuppression, samplerate, samplesize, blobhash, filesize, etag, md5, savewebmlocal, uploadtos3, deletelocalwebm, videostatus
            FROM nr.webcamvideostatus
            WHERE isdeleted = 0 AND videostatusid IN (SELECT
                videostatusid
                FROM videostatusid$uspgetallvideostatus);
       
END;
$BODY$;
ALTER PROCEDURE nr.uspgetallvideostatus(refcursor, refcursor, refcursor)
    OWNER TO postgres;
