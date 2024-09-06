-- PROCEDURE: nr.uspupdateactivesessiondetails(character varying, character varying, timestamp without time zone, timestamp without time zone, character varying)

-- DROP PROCEDURE IF EXISTS nr.uspupdateactivesessiondetails(character varying, character varying, timestamp without time zone, timestamp without time zone, character varying);

CREATE OR REPLACE PROCEDURE nr.uspupdateactivesessiondetails(
	IN par_sessionid character varying,
	IN par_currentstate character varying,
	IN par_changetime timestamp without time zone,
	IN par_disconnectedsince timestamp without time zone,
	INOUT par_status character varying DEFAULT ''::character varying)
LANGUAGE 'plpgsql'
AS $BODY$

/* ============================================================ */
/* Author: Raghuveer */
/* Create date:  09-02-2024 */
/* Description: updates details of an active session by @SessionID,updating CurrentState, ChangeTime, DisconnectedSince */
/* ============================================================ */

    BEGIN
        IF EXISTS (SELECT
            1
            FROM nr.activesessions
            WHERE LOWER(sessionid) = LOWER(par_SessionID) AND isdeleted = 0) THEN
            UPDATE nr.activesessions
            SET currentstate = par_CurrentState, statechangetime = par_ChangeTime, disconnectedsince = par_DisconnectedSince
                WHERE LOWER(sessionid) = LOWER(par_SessionID) AND isdeleted = 0;
            par_Status := 'S001';
        ELSE
            par_Status := 'S002';
        END IF;
      
END;
$BODY$;
ALTER PROCEDURE nr.uspupdateactivesessiondetails(character varying, character varying, timestamp without time zone, timestamp without time zone, character varying)
    OWNER TO postgres;
