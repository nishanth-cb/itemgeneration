-- PROCEDURE: nr.getallrawvideoinfo(refcursor, refcursor, refcursor)

-- DROP PROCEDURE IF EXISTS nr.getallrawvideoinfo(refcursor, refcursor, refcursor);

CREATE OR REPLACE PROCEDURE nr.getallrawvideoinfo(
	INOUT p_refcur refcursor,
	INOUT p_refcur_2 refcursor,
	INOUT p_refcur_3 refcursor)
LANGUAGE 'plpgsql'
AS $BODY$

/* ============================================================ */
/* Author: Manu M S */
/* Create date:  07-02-2024 */
/* Description: */
/* ============================================================ */

    BEGIN
        /* Variables for capturing error */
        OPEN p_refcur FOR
        SELECT
            rawvideoinfoid, sessionid, partid, filename, starttime, endtime, source, videotag, duration, audiobitspersecond, videobitspersecond, mimetype, partnerintegrationid, supersessionid
            FROM nr.rawvideoinfo
            WHERE isdeleted = 0;
        /* Fetching Audio track settings */
        OPEN p_refcur_2 FOR
        SELECT
            audiotracksettingsid, rawvideoinfoid, autogaincontrol, channelcount, deviceid, echocancellation, groupid, latency, noisesuppression, samplerate, samplesize
            FROM nr.audiotracksettings
            WHERE isdeleted = 0;
        /* Fecthing Video track settings */
        OPEN p_refcur_3 FOR
        SELECT
            videotracksettingsid, rawvideoinfoid, aspectratio, brightness, colortemperature, contrast, deviceid, exposurecompensation, exposuremode, exposuretime, facingmode, framerate, groupid, height, resizemode, saturation, sharpness, whitebalancemode, width
            FROM nr.videotracksettings
            WHERE isdeleted = 0;
       
END;
$BODY$;
ALTER PROCEDURE nr.getallrawvideoinfo(refcursor, refcursor, refcursor)
    OWNER TO postgres;
