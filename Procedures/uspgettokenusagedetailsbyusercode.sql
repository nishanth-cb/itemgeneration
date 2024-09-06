-- PROCEDURE: public.uspgettokenusagedetailsbyusercode(character varying, character varying, character varying, character varying, refcursor, refcursor)

-- DROP PROCEDURE IF EXISTS public.uspgettokenusagedetailsbyusercode(character varying, character varying, character varying, character varying, refcursor, refcursor);

CREATE OR REPLACE PROCEDURE public.uspgettokenusagedetailsbyusercode(
	IN par_custcode character varying,
	IN par_orgcode character varying,
	IN par_usercode character varying,
	IN par_appcode character varying,
	INOUT par_ref refcursor DEFAULT NULL::refcursor,
	INOUT par_ref2 refcursor DEFAULT NULL::refcursor)
LANGUAGE 'plpgsql'
AS $BODY$
DECLARE var_todaystoken bigint;
var_totalquestions bigint;
var_mcqcount bigint;
var_laqcount bigint;
var_totaltokenused BIGINT;
var_todayusage BIGINT;
BEGIN

  var_todaystoken := (SELECT COALESCE(u.tokencountperday ,0) 
            FROM dblink('dbname=aihubdata user=postgres password=AI@POC',
                        'SELECT t.tokencountperday 
						FROM tbluser U 
						INNER JOIN tblorganization O ON O.organizationid=U.organizationid 
						INNER JOIN tblsubscription s on s.userid= U.userid  AND S.isdeleted=0 
						INNER JOIN tbltokenmanager t on t.subscriptionid=s.subscriptionid AND t.isdeleted=0
						INNER JOIN tblapplication A on A.appid=s.app_id AND A.isdeleted=0
						WHERE lower(organizationcode) = lower(''' || par_orgcode || ''') AND lower(usercode)=lower(''' || par_usercode || ''') 
						AND lower(A.appcode)=lower(''' || par_appcode || ''')
						AND U.isdeleted = 0 AND O.isdeleted = 0')
            AS u(tokencountperday BIGINT));
			
select COUNT(q.id)  INTO var_totalquestions
		from  tblquestionrequest qr 
		inner join public.tblquestiongeneratedlist Q ON Q.questionrequestid=qr.questionrequestid 
		AND qr.isdeleted=0 and q.isdeleted=0
		 WHERE  lower(qr.usercode)=lower(par_usercode);

select COUNT(q.id)  INTO var_mcqcount
		from  tblquestionrequest qr 
		inner join public.tblquestiongeneratedlist Q ON Q.questionrequestid=qr.questionrequestid 
		AND qr.isdeleted=0 and q.isdeleted=0
		 WHERE  lower(qr.usercode)=lower(par_usercode) and qr.questiontypeid=1 ;

select COUNT(q.id) INTO var_laqcount
		from  tblquestionrequest qr 
		inner join public.tblquestiongeneratedlist Q ON Q.questionrequestid=qr.questionrequestid 
		AND qr.isdeleted=0 and q.isdeleted=0
		 WHERE  lower(qr.usercode)=lower(par_usercode) and qr.questiontypeid=7 ;
		 
select SUM(COALESCE(TK.inputtoken_usage,0)) + SUM(COALESCE(TK.responsetoken_usage,0)) INTO var_totaltokenused
			from tbltokenusage TK 
			where lower(tk.usercode)=lower(par_usercode);		 

 select SUM(COALESCE(TK.inputtoken_usage,0)) + SUM(COALESCE(TK.responsetoken_usage,0)) INTO var_todayusage
			from tbltokenusage TK 
			where lower(tk.usercode)=lower(par_usercode) and CAST(TK.created_at AS date) = CURRENT_DATE;

    OPEN par_ref FOR 
   
		 SELECT  coalesce (var_totaltokenused,0) totaltokenused,
		 CASE WHEN coalesce (var_todayusage,0)>var_todaystoken THEN var_todaystoken ELSE coalesce (var_todayusage,0) END AS todayusage,GREATEST(var_todaystoken-COALESCE(var_todayusage,0), 0) AS balancetokencount
		 ,coalesce(var_totalquestions,0) AS totalquestioncount,
		 coalesce (var_mcqcount,0) AS mcqcount,
		 coalesce (var_laqcount,0) AS laqcount,
		 Coalesce(var_todaystoken) AS todaystoken;
		 

    OPEN par_ref2 FOR
--     WITH CTE2 AS (
--         SELECT
--             TK.booknameid,
--             SUM(coalesce(TK.noofquestions, 0)) OVER (PARTITION BY TK.booknameid) AS questioncount,
--             (TK.inputtoken_usage + TK.responsetoken_usage) AS totaltokenused,
--             CASE
--                 WHEN CAST(TK.created_at AS date) = CURRENT_DATE THEN 
--                     TK.inputtoken_usage + TK.responsetoken_usage
--                 ELSE 0
--             END AS todayusage, 
--             TK.noofquestions, 
--             TK.questiontypeid
--         FROM tbltokenusage TK 
--         WHERE
--             lower(TK.orgcode) = lower(par_orgcode) AND lower(TK.appcode) = lower(par_appcode)
-- 			 AND lower(TK.custcode) = lower(par_custcode) AND coalesce(lower(TK.usercode),'') = coalesce(lower(par_usercode),'')
--     )
--      	SELECT
--             B.bookname, B.bookcode, 
--             COALESCE(COUNT(DISTINCT q.id),0) AS questioncount,
--             COALESCE(SUM(totaltokenused),0) AS totaltokenused,
--             COALESCE(SUM(todayusage),0) AS todayusage
--         FROM tblbookdetails B 
-- 		inner join  tblquestionrequest qr ON qr.booknameid=b.id and b.isdeleted=0 AND lower(qr.usercode)=lower(par_usercode)
-- 		inner join public.tblquestiongeneratedlist Q ON Q.questionrequestid=qr.questionrequestid 
-- 		AND qr.isdeleted=0 and q.isdeleted=0
-- 		LEFT JOIN CTE2 C ON C.booknameid=B.id and B.isdeleted=0
--         GROUP BY bookname, bookcode;

with cte AS
		(
		select B.bookname, B.bookcode,B.id
		FROM tblbookdetails B 	
		 WHERE  isdeleted=0
		 ),
		 totalquestions AS 
		 (
		 	select COUNT(q.id) as questioncount,qr.usercode,qr.booknameid
		from  tblquestionrequest qr 
		inner join public.tblquestiongeneratedlist Q ON Q.questionrequestid=qr.questionrequestid 
		AND qr.isdeleted=0 and q.isdeleted=0
		 WHERE  lower(qr.usercode)=lower(par_usercode)
		group by qr.usercode,qr.booknameid
		 ),
		 totaltoken as
		 (
		  select tk.booknameid,tk.usercode, SUM(COALESCE(TK.inputtoken_usage,0)) + SUM(COALESCE(TK.responsetoken_usage,0)) totaltokenused
			from 
			 cte C
			 INNER JOIN tbltokenusage TK ON TK.booknameid=C.id
			where lower(tk.usercode)=lower(par_usercode)
			 group by tk.booknameid,tk.usercode
		 ),
		 tokenusage AS
		 (
		 select tk.booknameid,tk.usercode, SUM(COALESCE(TK.inputtoken_usage,0)) + SUM(COALESCE(TK.responsetoken_usage,0)) todayusage
			FROM cte C
			 INNER JOIN tbltokenusage TK ON TK.booknameid=C.id
			where lower(tk.usercode)=lower(par_usercode) and CAST(TK.created_at AS date) = CURRENT_DATE
			 group by tk.booknameid,tk.usercode
		 )
		 SELECT  B.bookname, B.bookcode,
		 SUM(coalesce(questioncount,0)) AS questioncount,
		 coalesce (totaltokenused,0)totaltokenused, coalesce (todayusage,0)  todayusage
		 from cte b
		 left join totalquestions Q On  B.id=Q.booknameid
		 left join totaltoken T ON B.id=T.booknameid
		 left join tokenusage TK   ON  B.id=TK.booknameid
		 group by B.bookname, B.bookcode,totaltokenused,todayusage
		 ORDER BY B.bookcode;
	
	
END;
$BODY$;
ALTER PROCEDURE public.uspgettokenusagedetailsbyusercode(character varying, character varying, character varying, character varying, refcursor, refcursor)
    OWNER TO postgres;
