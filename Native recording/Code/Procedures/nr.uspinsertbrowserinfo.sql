-- PROCEDURE: nr.uspinsertbrowserinfo(character varying, text, bigint, bigint, character varying)

-- DROP PROCEDURE IF EXISTS nr.uspinsertbrowserinfo(character varying, text, bigint, bigint, character varying);

CREATE OR REPLACE PROCEDURE nr.uspinsertbrowserinfo(
	IN par_sessionid character varying DEFAULT ''::character varying,
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
        INSERT INTO nr.browserinfo (sessionid, browserdetails, createdby, createddate, modifieddate, modifiedby, isdeleted)
        VALUES (par_sessionId, par_BrowserDetails, par_CreatedBy, timezone('UTC', CURRENT_TIMESTAMP(6)), timezone('UTC', CURRENT_TIMESTAMP(6)), par_ModifiedBy, 0);
        par_Status := 'S001';
       
        
               
END;
$BODY$;
ALTER PROCEDURE nr.uspinsertbrowserinfo(character varying, text, bigint, bigint, character varying)
    OWNER TO postgres;
