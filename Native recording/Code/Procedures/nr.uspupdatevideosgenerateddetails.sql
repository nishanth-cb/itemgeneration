-- PROCEDURE: nr.uspupdatevideosgenerateddetails(character varying, character varying, character varying, refcursor, refcursor)

-- DROP PROCEDURE IF EXISTS nr.uspupdatevideosgenerateddetails(character varying, character varying, character varying, refcursor, refcursor);

CREATE OR REPLACE PROCEDURE nr.uspupdatevideosgenerateddetails(
	IN par_sessionid character varying DEFAULT ''::character varying,
	IN par_partid character varying DEFAULT ''::character varying,
	INOUT par_status character varying DEFAULT ''::character varying,
	INOUT p_refcur refcursor DEFAULT NULL::refcursor,
	INOUT p_refcur_2 refcursor DEFAULT NULL::refcursor)
LANGUAGE 'plpgsql'
AS $BODY$

/* ============================================================ */
/* Author: Manu M S */
/* Create date:  09/02/2024 */
/* Description: */
/* History : */
/* ============================================================ */
DECLARE
    var_ErrorLine BIGINT;
    var_ErrorMessage VARCHAR(4000);
    var_SchemaName VARCHAR(500);
    var_ErrorProcedure VARCHAR(500);
    var_ErrorSeverity BIGINT;
    var_ErrorState BIGINT;
    var_SPID BIGINT;
    var_ServerName VARCHAR(500);
    var_ServiceName VARCHAR(500);
    var_HostName VARCHAR(500);
    var_ProgramName VARCHAR(1000);
    var_CommandLine VARCHAR(4000);
    var_LoginUser VARCHAR(50);
    var_VideosGenerated TEXT;
    error_catch$ERROR_NUMBER TEXT;
    error_catch$ERROR_SEVERITY TEXT;
    error_catch$ERROR_STATE TEXT;
    error_catch$ERROR_LINE TEXT;
    error_catch$ERROR_PROCEDURE TEXT;
    error_catch$ERROR_MESSAGE TEXT;
    uspcaptureerror$refcur_1 refcursor;
BEGIN
    BEGIN
        /* Variables for capturing error */
        IF EXISTS (SELECT
            1
            FROM nativerecording_nr.activesessions
            WHERE LOWER(sessionid) = LOWER(par_sessionId) AND isdeleted = 0) THEN
            IF EXISTS (SELECT
                1
                FROM nativerecording_nr.activesessions
                WHERE LOWER(sessionid) = LOWER(par_sessionId) AND isdeleted = 0 AND LOWER(COALESCE(videosgenerated, '')) <> LOWER('')) THEN
                SELECT
                    CONCAT(videosgenerated, ',')
                    INTO var_VideosGenerated
                    FROM nativerecording_nr.activesessions
                    WHERE LOWER(sessionid) = LOWER(par_sessionId) AND isdeleted = 0;
                var_VideosGenerated := var_VideosGenerated || par_PartId;
                OPEN p_refcur FOR
                SELECT
                    var_VideosGenerated;
                UPDATE nativerecording_nr.activesessions
                SET videosgenerated = var_VideosGenerated
                    WHERE LOWER(sessionid) = LOWER(par_sessionId) AND isdeleted = 0;
                par_Status := 'S001';
            ELSE
                IF EXISTS (SELECT
                    1
                    FROM nativerecording_nr.activesessions
                    WHERE LOWER(sessionid) = LOWER(par_sessionId) AND isdeleted = 0 AND LOWER(COALESCE(videosgenerated, '')) = LOWER('')) THEN
                    UPDATE nativerecording_nr.activesessions
                    SET videosgenerated = par_PartId
                        WHERE LOWER(sessionid) = LOWER(par_sessionId) AND isdeleted = 0;
                    par_Status := 'S001';
                END IF;
            END IF;
        ELSE
            par_Status := 'S002';
        END IF;
        EXCEPTION
            WHEN OTHERS THEN
                error_catch$ERROR_NUMBER := '0';
                error_catch$ERROR_SEVERITY := '0';
                error_catch$ERROR_LINE := '0';
                error_catch$ERROR_PROCEDURE := 'USPUPDATEVIDEOSGENERATEDDETAILS';
                GET STACKED DIAGNOSTICS error_catch$ERROR_STATE = RETURNED_SQLSTATE,
                    error_catch$ERROR_MESSAGE = MESSAGE_TEXT;
                par_Status := 'F001';
                /* Capturing Error */
                
                /*
                [7811 - Severity CRITICAL - PostgreSQL doesn't support the @@SERVERNAME function. DMS SC skips this unsupported function in the converted code. Create a user-defined function to replace the unsupported function., 7811 - Severity CRITICAL - PostgreSQL doesn't support the @@SERVICENAME function. DMS SC skips this unsupported function in the converted code. Create a user-defined function to replace the unsupported function., 7811 - Severity CRITICAL - PostgreSQL doesn't support the HOST_NAME() function. DMS SC skips this unsupported function in the converted code. Create a user-defined function to replace the unsupported function.]
                SELECT
                				@ErrorLine = ERROR_LINE(),
                				@ErrorMessage = ERROR_MESSAGE(),
                				@SchemaName = 'NR',
                				@ErrorProcedure = ERROR_PROCEDURE(),
                				@ErrorSeverity = ERROR_SEVERITY(),
                				@ErrorState = ERROR_STATE(),
                				@SPID = @@SPID,
                				@ServerName = @@SERVERNAME,
                				@ServiceName = @@SERVICENAME,
                				@HostName = HOST_NAME(),
                				@ProgramName = PROGRAM_NAME(),
                				@CommandLine = '''EXECUTE [NR].[uspUpdateVideosGeneratedDetails]''',
                				@LoginUser = SUSER_SNAME();
                */
                CALL nativerecording_nr.uspcaptureerror(var_ErrorLine, var_ErrorMessage, var_SchemaName, var_ErrorProcedure, var_ErrorSeverity, var_ErrorState, var_SPID, var_ServerName, var_ServiceName, var_HostName, var_ProgramName, var_CommandLine, var_LoginUser, p_refcur => uspcaptureerror$refcur_1);
                CLOSE uspcaptureerror$refcur_1;
                OPEN p_refcur_2 FOR
                SELECT
                    error_catch$ERROR_MESSAGE AS errormessage, error_catch$ERROR_LINE AS errorline;
    END;
END;
$BODY$;
ALTER PROCEDURE nr.uspupdatevideosgenerateddetails(character varying, character varying, character varying, refcursor, refcursor)
    OWNER TO postgres;
