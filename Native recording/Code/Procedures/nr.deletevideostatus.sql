-- PROCEDURE: nr.deletevideostatus(bigint, character varying)

-- DROP PROCEDURE IF EXISTS nr.deletevideostatus(bigint, character varying);

CREATE OR REPLACE PROCEDURE nr.deletevideostatus(
	IN par_videostatusid bigint,
	INOUT par_status character varying DEFAULT ''::character varying)
LANGUAGE 'plpgsql'
AS $BODY$

/* ----------------------------------------------------------------------------------------------------------------- */
/* ============================================================ */
/* Author: Nishanth */
/* Create date:  07-02-2024 */
/* Description: */
/* ============================================================ */

    BEGIN
        IF EXISTS (SELECT
            1
            FROM nr.videostatus
            WHERE videostatusid = par_VideoStatusId AND isdeleted = 0) THEN
            
            /* Soft delete in the child table ScreenVideoStatus */
            UPDATE nr.screenvideostatus
            SET isdeleted = 1, modifieddate = timezone('UTC', CURRENT_TIMESTAMP(6))
                WHERE videostatusid = par_VideoStatusId;
            /* Soft delete in the child table WebCamVideoStatus */
            UPDATE nr.webcamvideostatus
            SET isdeleted = 1, modifieddate = timezone('UTC', CURRENT_TIMESTAMP(6))
                WHERE videostatusid = par_VideoStatusId;
            /* Soft delete in the parent table VideoStatus */
            UPDATE nr.videostatus
            SET isdeleted = 1, modifieddate = timezone('UTC', CURRENT_TIMESTAMP(6))
                WHERE videostatusid = par_VideoStatusId;
           
            par_Status := 'S001';
        ELSE
            par_Status := 'S002';
        END IF;
       
END;
$BODY$;
ALTER PROCEDURE nr.deletevideostatus(bigint, character varying)
    OWNER TO postgres;
