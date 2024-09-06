-- PROCEDURE: nr.deleterawvideoinfo(bigint, character varying)

-- DROP PROCEDURE IF EXISTS nr.deleterawvideoinfo(bigint, character varying);

CREATE OR REPLACE PROCEDURE nr.deleterawvideoinfo(
	IN par_rawvideoinfoid bigint,
	INOUT par_status character varying DEFAULT ''::character varying)
LANGUAGE 'plpgsql'
AS $BODY$

/* ============================================================ */
/* Author: Manu M S */
/* Create date:  07/02/2024 */
/* Description: */
/* ============================================================ */

    BEGIN
        /* Variables for capturing error */
        IF EXISTS (SELECT
            1
            FROM nr.rawvideoinfo
            WHERE rawvideoinfoid = par_RawVideoInfoId AND isdeleted = 0) THEN
            UPDATE nr.rawvideoinfo
            SET isdeleted = 1, modifieddate = timezone('UTC', CURRENT_TIMESTAMP(6))
                WHERE rawvideoinfoid = par_RawVideoInfoId;
            UPDATE nr.audiotracksettings
            SET isdeleted = 1, modifieddate = timezone('UTC', CURRENT_TIMESTAMP(6))
                WHERE rawvideoinfoid = par_RawVideoInfoId;
            UPDATE nr.videotracksettings
            SET isdeleted = 1, modifieddate = timezone('UTC', CURRENT_TIMESTAMP(6))
                WHERE rawvideoinfoid = par_RawVideoInfoId;
            par_Status := 'S001';
        ELSE
            par_Status := 'S002';
        END IF;
        
END;
$BODY$;
ALTER PROCEDURE nr.deleterawvideoinfo(bigint, character varying)
    OWNER TO postgres;
