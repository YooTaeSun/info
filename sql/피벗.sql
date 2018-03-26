SELECT (TO_DATE('20180101','YYYYMMDD') + LEVEL -1) DTE,
LEVEL
FROM dual
CONNECT BY LEVEL -1 <= TO_DATE('20180110','YYYYMMDD') - TO_DATE('20180101','YYYYMMDD');
/*

DTE                 |LEVEL |
--------------------|------|
2018-01-01 00:00:00 |1     |
2018-01-02 00:00:00 |2     |
2018-01-03 00:00:00 |3     |
2018-01-04 00:00:00 |4     |
2018-01-05 00:00:00 |5     |
2018-01-06 00:00:00 |6     |
2018-01-07 00:00:00 |7     |
2018-01-08 00:00:00 |8     |
2018-01-09 00:00:00 |9     |
2018-01-10 00:00:00 |10    |
*/


--가상테이블
WITH TEMP_TABLE AS (
SELECT (TO_DATE('20180101','YYYYMMDD') + LEVEL-1) DTE
   FROM DUAL
    CONNECT BY LEVEL -1 <= TO_DATE('20180110','YYYYMMDD') - TO_DATE('20180101','YYYYMMDD')
)
--월별 요일건수 (PIVOT 이용)
SELECT *
   FROM (
  SELECT TO_CHAR(DTE,'MM') || '월' MON
              , DECODE(TO_CHAR(DTE,'D'),'1','일','2','월','3','화','4','수','5','목','6','금','7','토') WEEK
              , DTE
     FROM TEMP_TABLE
              )
--PIVOT
--(
--COUNT(DTE)
--FOR WEEK IN ('일','월','화','수','목','금','토')
--)
    ORDER BY MON
;
/*

MON |WEEK |DTE                 |
----|-----|--------------------|
01월 |월    |2018-01-01 00:00:00 |
01월 |화    |2018-01-02 00:00:00 |
01월 |수    |2018-01-03 00:00:00 |
01월 |목    |2018-01-04 00:00:00 |
01월 |수    |2018-01-10 00:00:00 |
01월 |토    |2018-01-06 00:00:00 |
01월 |일    |2018-01-07 00:00:00 |
01월 |월    |2018-01-08 00:00:00 |
01월 |화    |2018-01-09 00:00:00 |
01월 |금    |2018-01-05 00:00:00 |
*/

--가상테이블
WITH TEMP_TABLE AS (
SELECT (TO_DATE('20180101','YYYYMMDD') + LEVEL-1) DTE
   FROM DUAL
    CONNECT BY LEVEL -1 <= TO_DATE('20180110','YYYYMMDD') - TO_DATE('20180101','YYYYMMDD')
)
--월별 요일건수 (PIVOT 이용)
SELECT *
   FROM (
  SELECT TO_CHAR(DTE,'MM') || '월' MON
              , DECODE(TO_CHAR(DTE,'D'),'1','일','2','월','3','화','4','수','5','목','6','금','7','토') WEEK
              , DTE
     FROM TEMP_TABLE
              )
PIVOT
(
COUNT(DTE)
FOR WEEK IN ('일','월','화','수','목','금','토')
)
ORDER BY MON
;
/*
MON |'일' |'월' |'화' |'수' |'목' |'금' |'토
----|----|----|----|----|----|----|----|
01월 |1   |2   |2   |2   |1   |1   |1   |
*/
