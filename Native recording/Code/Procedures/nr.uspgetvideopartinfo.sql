-- PROCEDURE: nr.uspgetvideopartinfo(character varying, character varying, refcursor, refcursor)

-- DROP PROCEDURE IF EXISTS nr.uspgetvideopartinfo(character varying, character varying, refcursor, refcursor);

CREATE OR REPLACE PROCEDURE nr.uspgetvideopartinfo(
	IN par_source character varying,
	IN par_partid character varying,
	INOUT p_refcur refcursor,
	INOUT p_refcur_2 refcursor)
LANGUAGE 'plpgsql'
AS $BODY$

/* ============================================================ */
/* Author: Manu M S */
/* Create date:  08/02/2024 */
/* Description: */
/* History */
/* 1;added if condition for select statements */
/* ============================================================ */

    BEGIN
        /* Variables for capturing error */
        IF LOWER(par_source) = LOWER('webcam') THEN
            OPEN p_refcur FOR
            SELECT
                webcamvideostatusid, videostatusid, sessionid, partid, filename, starttime, endtime, source, videotag, duration, audiobitspersecond, videobitspersecond, mimetype, aspectratio, brightness, colortemperature, contrast, deviceid, exposurecompensation, exposuremode, exposuretime, facingmode, framerate, groupid, height, resizemode, saturation, sharpness, whitebalancemode, width, autogaincontrol, channelcount, echocancellation, latency, noisesuppression, samplerate, samplesize, blobhash, filesize, etag, md5, savewebmlocal, uploadtos3, deletelocalwebm, videostatus
                FROM nr.webcamvideostatus
                WHERE LOWER(partid) = LOWER(par_partId) AND isdeleted = 0;
        END IF;

        IF LOWER(par_source) = LOWER('screen') THEN
            OPEN p_refcur_2 FOR
            SELECT
                screenvideostatusid, videostatusid, sessionid, partid, filename, starttime, endtime, source, videotag, duration, audiobitspersecond, videobitspersecond, mimetype, aspectratio, brightness, colortemperature, contrast, deviceid, exposurecompensation, exposuremode, exposuretime, facingmode, framerate, groupid, height, resizemode, saturation, sharpness, whitebalancemode, width, autogaincontrol, channelcount, echocancellation, latency, noisesuppression, samplerate, samplesize, blobhash, filesize, etag, md5, savewebmlocal, uploadtos3, deletelocalwebm, videostatus
                FROM nr.screenvideostatus
                WHERE LOWER(partid) = LOWER(par_partId) AND isdeleted = 0;
        END IF;
       
END;
$BODY$;
ALTER PROCEDURE nr.uspgetvideopartinfo(character varying, character varying, refcursor, refcursor)
    OWNER TO postgres;
