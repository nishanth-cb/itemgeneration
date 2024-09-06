-- PROCEDURE: nr.uspgetvideosessiondetails(character varying, refcursor, refcursor, refcursor)

-- DROP PROCEDURE IF EXISTS nr.uspgetvideosessiondetails(character varying, refcursor, refcursor, refcursor);

CREATE OR REPLACE PROCEDURE nr.uspgetvideosessiondetails(
	IN par_sessionid character varying,
	INOUT p_refcur refcursor,
	INOUT p_refcur_2 refcursor,
	INOUT p_refcur_3 refcursor)
LANGUAGE 'plpgsql'
AS $BODY$

/* ============================================================ */
/* Author: Manu M S */
/* Create date:  12/02/2024 */
/* Description: */
/* ============================================================ */

    BEGIN
        /* Variables for capturing error */
        OPEN p_refcur FOR
        SELECT
            videostatusid, sessionid, supersessionid
            FROM nr.videostatus
            WHERE LOWER(sessionid) = LOWER(par_sessionId) AND isdeleted = 0;
        /* selecting columns from videostatus table */
        OPEN p_refcur_2 FOR
        SELECT
            webcamvideostatusid, videostatusid, sessionid, partid, filename, starttime, endtime, source, videotag, duration, audiobitspersecond, videobitspersecond, mimetype, aspectratio, brightness, colortemperature, contrast, deviceid, exposurecompensation, exposuremode, exposuretime, facingmode, framerate, groupid, height, resizemode, saturation, sharpness, whitebalancemode, width, autogaincontrol, channelcount, echocancellation, latency, noisesuppression, samplerate, samplesize, blobhash, filesize, etag, md5, savewebmlocal, uploadtos3, deletelocalwebm, videostatus
            FROM nr.webcamvideostatus
            WHERE videostatusid IN (SELECT
                videostatusid
                FROM nr.videostatus
                WHERE LOWER(sessionid) = LOWER(par_sessionId) AND isdeleted = 0) AND isdeleted = 0;
        OPEN p_refcur_3 FOR
        SELECT
            screenvideostatusid, videostatusid, sessionid, partid, filename, starttime, endtime, source, videotag, duration, audiobitspersecond, videobitspersecond, mimetype, aspectratio, brightness, colortemperature, contrast, deviceid, exposurecompensation, exposuremode, exposuretime, facingmode, framerate, groupid, height, resizemode, saturation, sharpness, whitebalancemode, width, autogaincontrol, channelcount, echocancellation, latency, noisesuppression, samplerate, samplesize, blobhash, filesize, etag, md5, savewebmlocal, uploadtos3, deletelocalwebm, videostatus
            FROM nr.screenvideostatus
            WHERE videostatusid IN (SELECT
                videostatusid
                FROM nr.videostatus
                WHERE LOWER(sessionid) = LOWER(par_sessionId) AND isdeleted = 0) AND isdeleted = 0;
       
END;
$BODY$;
ALTER PROCEDURE nr.uspgetvideosessiondetails(character varying, refcursor, refcursor, refcursor)
    OWNER TO postgres;
