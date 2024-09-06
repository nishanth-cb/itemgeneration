-- PROCEDURE: nr.uspupdatewebmlocalstatus(character varying, character varying, character varying, character varying)

-- DROP PROCEDURE IF EXISTS nr.uspupdatewebmlocalstatus(character varying, character varying, character varying, character varying);

CREATE OR REPLACE PROCEDURE nr.uspupdatewebmlocalstatus(
	IN par_sessionid character varying,
	IN par_partid character varying,
	IN par_source character varying,
	IN par_savewebmlocalstatus character varying)
LANGUAGE 'plpgsql'
AS $BODY$

--
-- /* ============================================================ */
-- /* Author: Nishanth */
-- /* Create date:  12-02-2024 */
-- /* Description: */
-- /* -1;Nishanth C B ;12-02-2024;Added logic to get status */
-- /* ============================================================ */
 DECLARE
    
    var_status VARCHAR(50);
   
 
    BEGIN
        IF LOWER(par_Source) = LOWER('webcam') THEN
            IF EXISTS (SELECT
                1
                FROM nr.webcamvideostatus
                WHERE LOWER(sessionid) = LOWER(par_SessionId) AND LOWER(partid) = LOWER(par_PartId)) THEN
                UPDATE nr.webcamvideostatus
                SET savewebmlocal = par_SaveWebmLocalStatus
                    WHERE LOWER(sessionid) = LOWER(par_SessionId) AND LOWER(partid) = LOWER(par_PartId);
            ELSE
                var_status := 'F001';
               
               
            END IF;
        ELSE
            IF LOWER(par_Source) = LOWER('screen') THEN
                IF EXISTS (SELECT
                    1
                    FROM nr.screenvideostatus
                    WHERE LOWER(sessionid) = LOWER(par_SessionId) AND LOWER(partid) = LOWER(par_PartId)) THEN
                    UPDATE nr.screenvideostatus
                    SET savewebmlocal = par_SaveWebmLocalStatus
                        WHERE LOWER(sessionid) = LOWER(par_SessionId) AND LOWER(partid) = LOWER(par_PartId);
                ELSE
                    var_status := 'F001';
                   
                        
                   
                END IF;
            END IF;
        END IF;
        var_status := 'S001';
       
       
 
END;
$BODY$;
ALTER PROCEDURE nr.uspupdatewebmlocalstatus(character varying, character varying, character varying, character varying)
    OWNER TO postgres;
