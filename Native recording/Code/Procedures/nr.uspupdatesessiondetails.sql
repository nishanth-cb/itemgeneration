-- PROCEDURE: nr.uspupdatesessiondetails(character varying, text, text, text, character varying)

-- DROP PROCEDURE IF EXISTS nr.uspupdatesessiondetails(character varying, text, text, text, character varying);

CREATE OR REPLACE PROCEDURE nr.uspupdatesessiondetails(
	IN par_sessionid character varying DEFAULT ''::character varying,
	IN par_videosgenerated text DEFAULT ''::text,
	IN par_uploadattemptedvideos text DEFAULT ''::text,
	IN par_faileduploads text DEFAULT ''::text,
	INOUT par_status character varying DEFAULT ''::character varying)
LANGUAGE 'plpgsql'
AS $BODY$

/* ============================================================ */
/* Author: Manu M S */
/* Create date:  12/02/2024 */
/* Description: This SP is used to Update session details */
/* ============================================================ */

    BEGIN
        /* Variables for capturing error */
        IF EXISTS (SELECT
            1
            FROM nr.sessiondetails
            WHERE LOWER(sessionid) = LOWER(par_Sessionid) AND isdeleted = 0) THEN
            IF EXISTS (SELECT
                1
                FROM nr.sessiondetails
                WHERE LOWER(sessionid) = LOWER(par_Sessionid) AND isdeleted = 0 AND LOWER(COALESCE(videosgenerated, '')) <> LOWER('')) THEN
                UPDATE nr.sessiondetails
                SET videosgenerated = videosgenerated || ',' || par_VideosGenerated
                    WHERE LOWER(sessionid) = LOWER(par_Sessionid) AND isdeleted = 0 AND LOWER(par_VideosGenerated) <> LOWER('');
                par_status := 'S001';
            ELSE
                IF EXISTS (SELECT
                    1
                    FROM nr.sessiondetails
                    WHERE LOWER(sessionid) = LOWER(par_Sessionid) AND isdeleted = 0 AND LOWER(COALESCE(videosgenerated, '')) = LOWER('')) THEN
                    UPDATE nr.sessiondetails
                    SET videosgenerated = par_VideosGenerated
                        WHERE LOWER(sessionid) = LOWER(par_Sessionid) AND isdeleted = 0 AND LOWER(par_VideosGenerated) <> LOWER('');
                    par_status := 'S001';
                END IF;
            END IF;

            IF EXISTS (SELECT
                1
                FROM nr.sessiondetails
                WHERE LOWER(sessionid) = LOWER(par_Sessionid) AND isdeleted = 0 AND LOWER(COALESCE(uploadattemptedvideos, '')) <> LOWER('')) THEN
                UPDATE nativerecording_nr.sessiondetails
                SET uploadattemptedvideos = uploadattemptedvideos || ',' || par_UploadAttemptedVideos
                    WHERE LOWER(sessionid) = LOWER(par_Sessionid) AND isdeleted = 0 AND LOWER(par_UploadAttemptedVideos) <> LOWER('');
                par_status := 'S001';
            ELSE
                IF EXISTS (SELECT
                    1
                    FROM nr.sessiondetails
                    WHERE LOWER(sessionid) = LOWER(par_Sessionid) AND isdeleted = 0 AND LOWER(COALESCE(uploadattemptedvideos, '')) = LOWER('')) THEN
                    UPDATE nr.sessiondetails
                    SET uploadattemptedvideos = par_UploadAttemptedVideos
                        WHERE LOWER(sessionid) = LOWER(par_Sessionid) AND isdeleted = 0 AND LOWER(par_UploadAttemptedVideos) <> LOWER('');
                    par_status := 'S001';
                END IF;
            END IF;

            IF EXISTS (SELECT
                1
                FROM nr.sessiondetails
                WHERE LOWER(sessionid) = LOWER(par_Sessionid) AND isdeleted = 0 AND LOWER(COALESCE(faileduploads, '')) <> LOWER('')) THEN
                UPDATE nr.sessiondetails
                SET faileduploads = faileduploads || ',' || par_FailedUploads
                    WHERE LOWER(sessionid) = LOWER(par_Sessionid) AND isdeleted = 0 AND LOWER(par_FailedUploads) <> LOWER('');
                par_status := 'S001';
            ELSE
                IF EXISTS (SELECT
                    1
                    FROM nr.sessiondetails
                    WHERE LOWER(sessionid) = LOWER(par_Sessionid) AND isdeleted = 0 AND LOWER(COALESCE(faileduploads, '')) = LOWER('')) THEN
                    UPDATE nr.sessiondetails
                    SET faileduploads = par_FailedUploads
                        WHERE LOWER(sessionid) = LOWER(par_Sessionid) AND isdeleted = 0 AND LOWER(par_FailedUploads) <> LOWER('');
                    par_status := 'S001';
                END IF;
            END IF;
        ELSE
            par_status := 'S002';
        END IF;
       
END;
$BODY$;
ALTER PROCEDURE nr.uspupdatesessiondetails(character varying, text, text, text, character varying)
    OWNER TO postgres;
