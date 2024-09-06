-- PROCEDURE: public.uspgetchapters(character varying, refcursor)

-- DROP PROCEDURE IF EXISTS public.uspgetchapters(character varying, refcursor);

CREATE OR REPLACE PROCEDURE public.uspgetchapters(
	IN par_bookcode character varying,
	INOUT ref refcursor DEFAULT NULL::refcursor)
LANGUAGE 'plpgsql'
AS $BODY$
BEGIN
    OPEN ref FOR
      select c.chaptercode,c.chaptername
	  from tblchapters C
	  inner join tblbookdetails B 
	  ON B.id=C.bookid
	  and C.isdeleted=0 and b.isdeleted=0
	  where lower(b.bookcode)=lower(par_bookcode)
	  Order by C.id;

EXCEPTION
    WHEN OTHERS THEN
        RAISE NOTICE 'An error occurred: %', SQLERRM;
END;
$BODY$;
ALTER PROCEDURE public.uspgetchapters(character varying, refcursor)
    OWNER TO postgres;
