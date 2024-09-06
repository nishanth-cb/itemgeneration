-- PROCEDURE: nr.uspinsertaudiotracksettings(bigint, numeric, integer, character varying, numeric, character varying, numeric, numeric, integer, integer, bigint, bigint)

-- DROP PROCEDURE IF EXISTS nr.uspinsertaudiotracksettings(bigint, numeric, integer, character varying, numeric, character varying, numeric, numeric, integer, integer, bigint, bigint);

CREATE OR REPLACE PROCEDURE nr.uspinsertaudiotracksettings(
	IN par_rawvideoinfoid bigint,
	IN par_autogaincontrol numeric,
	IN par_channelcount integer,
	IN par_deviceid character varying DEFAULT ''::character varying,
	IN par_echocancellation numeric DEFAULT NULL::numeric,
	IN par_groupid character varying DEFAULT ''::character varying,
	IN par_latency numeric DEFAULT NULL::numeric,
	IN par_noisesuppression numeric DEFAULT NULL::numeric,
	IN par_samplerate integer DEFAULT NULL::integer,
	IN par_samplesize integer DEFAULT NULL::integer,
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
    BEGIN
        INSERT INTO nr.audiotracksettings (rawvideoinfoid, autogaincontrol, channelcount, deviceid, echocancellation, groupid, latency, noisesuppression, samplerate, samplesize, createdby, createddate, modifieddate, modifiedby, isdeleted)
        VALUES (par_RawVideoInfoID, aws_sqlserver_ext.tomsbit(par_AutoGainControl), par_ChannelCount, par_DeviceId, aws_sqlserver_ext.tomsbit(par_EchoCancellation), par_GroupId, par_Latency, aws_sqlserver_ext.tomsbit(par_NoiseSuppression), par_SampleRate, par_SampleSize, par_CreatedBy, timezone('UTC', CURRENT_TIMESTAMP(6)), timezone('UTC', CURRENT_TIMESTAMP(6)), par_ModifiedBy, 0);
      
        
    END;
END;
$BODY$;
ALTER PROCEDURE nr.uspinsertaudiotracksettings(bigint, numeric, integer, character varying, numeric, character varying, numeric, numeric, integer, integer, bigint, bigint)
    OWNER TO postgres;
