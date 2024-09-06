-- PROCEDURE: nr.updatesessionidinattemptdetails(bigint, character varying, character varying)

-- DROP PROCEDURE IF EXISTS nr.updatesessionidinattemptdetails(bigint, character varying, character varying);

CREATE OR REPLACE PROCEDURE nr.updatesessionidinattemptdetails(
	IN par_partnerintegrationid bigint,
	IN par_sessionid character varying,
	INOUT par_status character varying)
LANGUAGE 'plpgsql'
AS $BODY$

/* ============================================================ */
/* Author: Nishanth */
/* Create date:  07-02-2024 */
/* Description: */
/* ============================================================ */

    BEGIN
        IF EXISTS (SELECT
            1
            FROM nr.attemptdetails
            WHERE partnerintegrationid = par_PartnerIntegrationId AND LOWER(sessionid) = LOWER('') AND isdeleted = 0) THEN
            /* Update the SessionId for the given Partner Integration ID */
            UPDATE nr.attemptdetails
            SET sessionid = par_sessionId, modifieddate = timezone('UTC', CURRENT_TIMESTAMP(6))
                WHERE partnerintegrationid = par_PartnerIntegrationId;
            /* Set status to success */
            par_Status := 'S001';
        ELSE
            /* SessionId is not empty, no need to update */
            par_Status := 'S002';
        END IF;
        
END;
$BODY$;
ALTER PROCEDURE nr.updatesessionidinattemptdetails(bigint, character varying, character varying)
    OWNER TO postgres;
