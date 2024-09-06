-- PROCEDURE: nr.uspgetvideouploadsuccesscount(character varying, character varying, refcursor)

-- DROP PROCEDURE IF EXISTS nr.uspgetvideouploadsuccesscount(character varying, character varying, refcursor);

CREATE OR REPLACE PROCEDURE nr.uspgetvideouploadsuccesscount(
	IN par_sessionid character varying DEFAULT ''::character varying,
	IN par_partid character varying DEFAULT ''::character varying,
	INOUT p_refcur refcursor DEFAULT NULL::refcursor)
LANGUAGE 'plpgsql'
AS $BODY$

/* ============================================================ */
/* Author: Manu M S */
/* Create date:  08/02/2024 */
/* Description: */
/* ============================================================ */
DECLARE
   
    var_count INTEGER;
    var_Pos1 INTEGER;
    var_Pos2 INTEGER;
    var_Len SMALLINT;
    var_Delimiter VARCHAR(10) DEFAULT ',';
    var_String TEXT;

    BEGIN
        /* Variables for capturing error */
        BEGIN
            /* Table variable to get comma separated values */
            CREATE TEMPORARY TABLE stringtable$uspgetvideouploadsuccesscount
            (videosuploadsuccess TEXT);
            SELECT
                videosuploadsuccess
                INTO var_String
                FROM nr.activesessions
                WHERE LOWER(sessionid) = LOWER(par_sessionId) AND isdeleted = 0;

            IF LENGTH(var_Delimiter) = 0 THEN
                var_Len := 1;
            ELSE
                var_Len := LENGTH(var_Delimiter);
            END IF;
            var_String := var_String || var_Delimiter;
            /* Append comma */
            var_Pos1 := 1;
            /* Start from first character */
            var_Pos2 := 1;

            WHILE var_Pos1 < LENGTH(var_String) LOOP
                var_Pos1 := aws_sqlserver_ext.STRPOS3(var_Delimiter, var_String, var_Pos1);
                INSERT INTO stringtable$uspgetvideouploadsuccesscount (videosuploadsuccess)
                SELECT
                    SUBSTR(var_String, var_Pos2, var_Pos1 - var_Pos2);
                var_Pos2 := var_Pos1 + var_Len;
                var_Pos1 := var_Pos1 + var_Len;
            END LOOP;
            SELECT
                COUNT(videosuploadsuccess)
                INTO var_count
                FROM stringtable$uspgetvideouploadsuccesscount
                WHERE LOWER(videosuploadsuccess) = LOWER(par_PartId);
            DROP TABLE IF EXISTS stringtable$uspgetvideouploadsuccesscount;
        END;
        OPEN p_refcur FOR
        SELECT
            var_count AS videosuploadcount;
       
END;
$BODY$;
ALTER PROCEDURE nr.uspgetvideouploadsuccesscount(character varying, character varying, refcursor)
    OWNER TO postgres;
