-- PROCEDURE: nr.uspcaptureerror(bigint, text, character varying, character varying, bigint, bigint, bigint, character varying, character varying, character varying, character varying, text, character varying)

-- DROP PROCEDURE IF EXISTS nr.uspcaptureerror(bigint, text, character varying, character varying, bigint, bigint, bigint, character varying, character varying, character varying, character varying, text, character varying);

CREATE OR REPLACE PROCEDURE nr.uspcaptureerror(
	IN par_errorline bigint,
	IN par_errormessage text,
	IN par_schemaname character varying,
	IN par_errorprocedure character varying,
	IN par_errorseverity bigint,
	IN par_errorstate bigint,
	IN par_spid bigint,
	IN par_servername character varying,
	IN par_servicename character varying,
	IN par_hostname character varying,
	IN par_programname character varying,
	IN par_commandline text,
	IN par_loginuser character varying)
LANGUAGE 'plpgsql'
AS $BODY$

/*
=============================================
Author		: Touhid Mustakhim. M. J
Create date	: 21 November 2014
Description	: To capture error
=============================================
*/

    BEGIN
        INSERT INTO nr.sperrorlog (errorline, errormessage, schemaname, errorprocedure, errorseverity, errorstate, spid, servername, servicename, hostname, programname, commandline, loginuser)
        VALUES (par_ErrorLine, par_ErrorMessage, par_SchemaName, par_ErrorProcedure, par_ErrorSeverity, par_ErrorState, par_SPID, par_ServerName, par_ServiceName, par_HostName, par_ProgramName, par_CommandLine, par_LoginUser);
        
END;
$BODY$;
ALTER PROCEDURE nr.uspcaptureerror(bigint, text, character varying, character varying, bigint, bigint, bigint, character varying, character varying, character varying, character varying, text, character varying)
    OWNER TO postgres;
