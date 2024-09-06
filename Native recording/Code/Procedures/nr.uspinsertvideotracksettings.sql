-- PROCEDURE: nr.uspinsertvideotracksettings(bigint, numeric, integer, integer, integer, character varying, numeric, character varying, character varying, character varying, integer, character varying, integer, character varying, integer, integer, character varying, integer, bigint, bigint)

-- DROP PROCEDURE IF EXISTS nr.uspinsertvideotracksettings(bigint, numeric, integer, integer, integer, character varying, numeric, character varying, character varying, character varying, integer, character varying, integer, character varying, integer, integer, character varying, integer, bigint, bigint);

CREATE OR REPLACE PROCEDURE nr.uspinsertvideotracksettings(
	IN par_rawvideoinfoid bigint,
	IN par_aspectratio numeric,
	IN par_brightness integer,
	IN par_colortemperature integer,
	IN par_contrast integer,
	IN par_deviceid character varying,
	IN par_exposurecompensation numeric,
	IN par_exposuremode character varying,
	IN par_exposuretime character varying,
	IN par_facingmode character varying,
	IN par_framerate integer,
	IN par_groupid character varying,
	IN par_height integer,
	IN par_resizemode character varying,
	IN par_saturation integer,
	IN par_sharpness integer,
	IN par_whitebalancemode character varying,
	IN par_width integer,
	IN par_createdby bigint DEFAULT NULL::bigint,
	IN par_modifiedby bigint DEFAULT NULL::bigint)
LANGUAGE 'plpgsql'
AS $BODY$

/* ============================================================ */
/* Author: Nishanth */
/* Create date:  08-02-2024 */
/* Description: */
/* ============================================================ */

    BEGIN
        INSERT INTO nr.videotracksettings (rawvideoinfoid, aspectratio, brightness, colortemperature, contrast, deviceid, exposurecompensation, exposuremode, exposuretime, facingmode, framerate, groupid, height, resizemode, saturation, sharpness, whitebalancemode, width, createdby, createddate, modifieddate, modifiedby, isdeleted)
        VALUES (par_RawVideoInfoID, par_AspectRatio, par_Brightness, par_ColorTemperature, par_Contrast, par_DeviceId, par_ExposureCompensation, par_ExposureMode, par_ExposureTime, par_FacingMode, par_FrameRate, par_GroupId, par_Height, par_ResizeMode, par_Saturation, par_Sharpness, par_WhiteBalanceMode, par_Width, par_CreatedBy, timezone('UTC', CURRENT_TIMESTAMP(6)), timezone('UTC', CURRENT_TIMESTAMP(6)), par_ModifiedBy, 0);
        
      
END;
$BODY$;
ALTER PROCEDURE nr.uspinsertvideotracksettings(bigint, numeric, integer, integer, integer, character varying, numeric, character varying, character varying, character varying, integer, character varying, integer, character varying, integer, integer, character varying, integer, bigint, bigint)
    OWNER TO postgres;
