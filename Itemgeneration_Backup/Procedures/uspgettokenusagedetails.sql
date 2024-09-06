-- PROCEDURE: public.uspgettokenusagedetails(timestamp without time zone, timestamp without time zone, refcursor)

-- DROP PROCEDURE IF EXISTS public.uspgettokenusagedetails(timestamp without time zone, timestamp without time zone, refcursor);

CREATE OR REPLACE PROCEDURE public.uspgettokenusagedetails(
	IN par_fromdate timestamp without time zone,
	IN par_todate timestamp without time zone,
	IN par_ref refcursor DEFAULT NULL::refcursor)
LANGUAGE 'plpgsql'
AS $BODY$
BEGIN
    OPEN par_ref FOR
    SELECT
        custcode, usercode, appcode,orgcode,
        inputtoken_usage + responsetoken_usage AS totaltokenusage
    FROM tbltokenusage
    WHERE CAST(created_at AS DATE) BETWEEN par_fromdate AND par_todate
        AND isdeleted = 0;
END;
$BODY$;
ALTER PROCEDURE public.uspgettokenusagedetails(timestamp without time zone, timestamp without time zone, refcursor)
    OWNER TO postgres;
