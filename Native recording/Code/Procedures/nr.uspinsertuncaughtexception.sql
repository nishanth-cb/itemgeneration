-- PROCEDURE: nr.uspinsertuncaughtexception(character varying, character varying, character varying, text, bigint, bigint, character varying)

-- DROP PROCEDURE IF EXISTS nr.uspinsertuncaughtexception(character varying, character varying, character varying, text, bigint, bigint, character varying);

CREATE OR REPLACE PROCEDURE nr.uspinsertuncaughtexception(
	IN par_sessionid character varying DEFAULT ''::character varying,
	IN par_message character varying DEFAULT ''::character varying,
	IN par_stacktrace character varying DEFAULT ''::character varying,
	IN par_browserdetails text DEFAULT ''::text,
	IN par_createdby bigint DEFAULT 0,
	IN par_modifiedby bigint DEFAULT NULL::bigint,
	INOUT par_status character varying DEFAULT NULL::character varying)
LANGUAGE 'plpgsql'
AS $BODY$

/* ============================================================ */
/* Author: Nishanth */
/* Create date:  06-02-2024 */
/* Description: */
/* ============================================================ */

    BEGIN
        INSERT INTO nr.uncaughtexceptions (sessionid, message, stacktrace, browserdetails, createdby, createddate, modifieddate, modifiedby, isdeleted)
        VALUES (par_SessionID, par_Message, par_StackTrace, par_BrowserDetails, par_CreatedBy, timezone('UTC', CURRENT_TIMESTAMP(6)), timezone('UTC', CURRENT_TIMESTAMP(6)), par_ModifiedBy, 0);
        par_Status := 'S001';
       
       
END;
$BODY$;
ALTER PROCEDURE nr.uspinsertuncaughtexception(character varying, character varying, character varying, text, bigint, bigint, character varying)
    OWNER TO postgres;
