-- PROCEDURE: nr.uspvalidateuserdetails(bigint, numeric, integer, character varying, bigint, character varying)

-- DROP PROCEDURE IF EXISTS nr.uspvalidateuserdetails(bigint, numeric, integer, character varying, bigint, character varying);

CREATE OR REPLACE PROCEDURE nr.uspvalidateuserdetails(
	IN par_pid bigint,
	IN par_isrr numeric,
	IN par_rrno integer,
	IN par_supersessionid character varying,
	IN par_integrationuserid bigint,
	INOUT par_status character varying DEFAULT ''::character varying)
LANGUAGE 'plpgsql'
AS $BODY$

/* ============================================================ */
/* Author: Nishanth */
/* Create date:  07-02-2024 */
/* Description: */
/* History: */
/* 1;Nishanth ;09-02-2024;Fixed data type conversion. */
/* 2;Nishanth ;14-02-2024;Removed the result set and changes in  input parameters */
/* ============================================================ */

    BEGIN
        IF NOT EXISTS (SELECT
            1
            FROM nr.userdetails
            WHERE integrationuserid = par_integrationUserId AND partnerintegrationid = par_pId AND isrerecording = par_isRR AND recordingnumber = par_rrNo AND isdeleted = 0) THEN
            /* Insert new record if no record exists */
            INSERT INTO nr.userdetails (integrationuserid, partnerintegrationid, supersessionid, isrerecording, recordingnumber)
            VALUES (par_integrationUserId, par_pId, par_superSessionId, aws_sqlserver_ext.tomsbit(par_isRR), par_rrNo);
            /* Set status to success */
            par_Status := 'S001';
        ELSE
            /* Update StatusCode if record exists with Status 5 or 6 */
            UPDATE nr.userdetails
            SET statuscode = 'S002'
                WHERE integrationuserid = par_integrationUserId AND partnerintegrationid = par_pId AND isrerecording = par_isRR AND recordingnumber = par_rrNo AND status IN (5, 6) AND isdeleted = 0;
            /* Set status to success */
            par_Status := 'S001';
        END IF;
       
END;
$BODY$;
ALTER PROCEDURE nr.uspvalidateuserdetails(bigint, numeric, integer, character varying, bigint, character varying)
    OWNER TO postgres;
