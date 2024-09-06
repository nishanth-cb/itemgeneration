-- PROCEDURE: public.uspgetbooks(character varying, character varying, refcursor)

-- DROP PROCEDURE IF EXISTS public.uspgetbooks(character varying, character varying, refcursor);

CREATE OR REPLACE PROCEDURE public.uspgetbooks(
	IN par_custcode character varying,
	IN par_appcode character varying,
	INOUT par_ref refcursor DEFAULT NULL::refcursor)
LANGUAGE 'plpgsql'
AS $BODY$
BEGIN
    OPEN par_ref FOR 
    SELECT  b1.bookcode, b1.bookname
    FROM public.tblbookdetails b1
    INNER JOIN public.tblcustomerconfiguration b2  ON b1.id = b2.mappingid  AND b1.isdeleted = 0  AND b2.isdeleted = 0 AND b2.type=5
     WHERE lower(b2.customercode) = lower(par_custcode) 
     AND lower(b2.appcode) = lower(par_appcode) 
	ORDER BY b1.id;
END;
$BODY$;
ALTER PROCEDURE public.uspgetbooks(character varying, character varying, refcursor)
    OWNER TO postgres;
