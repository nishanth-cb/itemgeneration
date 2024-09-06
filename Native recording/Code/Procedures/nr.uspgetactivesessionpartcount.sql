-- PROCEDURE: nr.uspgetactivesessionpartcount(character varying, character varying, refcursor)

-- DROP PROCEDURE IF EXISTS nr.uspgetactivesessionpartcount(character varying, character varying, refcursor);

CREATE OR REPLACE PROCEDURE nr.uspgetactivesessionpartcount(
	IN par_sessionid character varying DEFAULT ''::character varying,
	IN par_partid character varying DEFAULT ''::character varying,
	INOUT p_refcur refcursor DEFAULT NULL::refcursor)
LANGUAGE 'plpgsql'
AS $BODY$

/* ============================================================ */
/* Author: Nishanth */
/* Create date:  09-02-2024 */
/* Description: */
/* ============================================================ */
DECLARE
    
    var_Count INTEGER;
    var_Pos1 INTEGER;
    var_Pos2 INTEGER;
    var_Len SMALLINT;
    var_Delimiter VARCHAR(10) DEFAULT ',';
    var_String TEXT;
    

    BEGIN
        BEGIN
            CREATE TEMPORARY TABLE stringtable$uspgetactivesessionpartcount
            (videosgenerated TEXT);
            SELECT
                videosgenerated
                INTO var_String
                FROM nr.activesessions
                WHERE LOWER(sessionid) = LOWER(par_sessionId) AND isdeleted = 0;

            IF LENGTH(var_Delimiter) = 0 THEN
                var_Len := 1;
            ELSE
                var_Len := LENGTH(var_Delimiter);
            END IF;
            var_String := var_String || var_Delimiter;
            var_Pos1 := 1;
            var_Pos2 := 1;

            WHILE var_Pos1 < LENGTH(var_String) LOOP
                var_Pos1 := aws_sqlserver_ext.STRPOS3(var_Delimiter, var_String, var_Pos1);
                INSERT INTO stringtable$uspgetactivesessionpartcount (videosgenerated)
                SELECT
                    SUBSTR(var_String, var_Pos2, var_Pos1 - var_Pos2);
                var_Pos2 := var_Pos1 + var_Len;
                var_Pos1 := var_Pos1 + var_Len;
            END LOOP;
            SELECT
                COUNT(videosgenerated)
                INTO var_Count
                FROM stringtable$uspgetactivesessionpartcount
                WHERE LOWER(videosgenerated) = LOWER(par_PartId);
            DROP TABLE IF EXISTS stringtable$uspgetactivesessionpartcount;
        END;
        OPEN p_refcur FOR
        SELECT
            var_Count AS videosgeneratedcount;
       
END;
$BODY$;
ALTER PROCEDURE nr.uspgetactivesessionpartcount(character varying, character varying, refcursor)
    OWNER TO postgres;
