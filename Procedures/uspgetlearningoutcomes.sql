-- PROCEDURE: public.uspgetlearningoutcomes(character varying, refcursor)

-- DROP PROCEDURE IF EXISTS public.uspgetlearningoutcomes(character varying, refcursor);

CREATE OR REPLACE PROCEDURE public.uspgetlearningoutcomes(
	IN par_chaptercode character varying,
	INOUT ref refcursor DEFAULT NULL::refcursor)
LANGUAGE 'plpgsql'
AS $BODY$
BEGIN
    OPEN ref FOR
        SELECT lo.locode, lo.loname
        FROM tbllearningoutcomes lo
        INNER JOIN tblchapters ch ON ch.id = lo.chapterid AND ch.isdeleted = 0  AND lo.isdeleted = 0
        WHERE lower(ch.chaptercode) = lower(par_chaptercode)
        ORDER BY lo.Id;

EXCEPTION
    WHEN OTHERS THEN
        RAISE NOTICE 'An error occurred: %', SQLERRM;
END;
$BODY$;
ALTER PROCEDURE public.uspgetlearningoutcomes(character varying, refcursor)
    OWNER TO postgres;
