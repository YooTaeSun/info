/*
 * 오라클 피봇(Pivot)
 * 오라클 11g 부터 
 */
WITH TEMP AS (
   SELECT DEPTNO, SAL
    FROM EMP
)
SELECT *
  FROM TEMP
;      

DEPTNO |SAL  |
-------|-----|
20     |800  |
30     |1600 |
30     |1250 |
20     |2975 |
30     |1250 |
30     |2850 |
10     |2450 |
20     |3000 |
10     |5000 |
30     |1500 |
20     |1100 |
30     |950  |
20     |3000 |
40     |1300 |

------------------------------------------------

WITH TEMP AS (
   SELECT DEPTNO, SAL
    FROM EMP
)
SELECT *
  FROM TEMP
 PIVOT(
        SUM(SAL) AS SUM, MAX(SAL) AS MAX
        FOR DEPTNO
        IN (10, 20, 30)
      );
      
10_SUM |10_MAX |20_SUM |20_MAX |30_SUM |30_MAX |
-------|-------|-------|-------|-------|-------|
7450   |5000   |10875  |3000   |9400   |2850   |

------------------------------------------------

WITH TEMP AS (
   SELECT DEPTNO, SAL
    FROM EMP
)
SELECT *
  FROM TEMP
 PIVOT(
        SUM(SAL) AS "총합", AVG(SAL) AS "평균"
        FOR DEPTNO
        IN (10 AS "10부서", 20 AS "20부서", 30 AS "30부서")
      );      

10부서_총합 |10부서_평균 |20부서_총합 |20부서_평균 |30부서_총합 |30부서_평균                                   |
--------|--------|--------|--------|--------|------------------------------------------|
7450    |3725    |10875   |2175    |9400    |1566.666666666666666666666666666666666667 |      

-----------------------------------------------------------------------------

/*
 * 오라클 언피봇(Pivot) 
 */

SELECT ENAME, SAL FROM EMP;
/*
ENAME  |SAL  |
-------|-----|
SMITH  |800  |
ALLEN  |1600 |
WARD   |1250 |
JONES  |2975 |
MARTIN |1250 |
BLAKE  |2850 |
CLARK  |2450 |
SCOTT  |3000 |
KING   |5000 |
TURNER |1500 |
ADAMS  |1100 |
JAMES  |950  |
FORD   |3000 |
MILLER |1300 |
*/

WITH TEMP AS (
	SELECT ENAME, SAL FROM EMP
)
SELECT ENAME, COL, DATA
FROM TEMP
UNPIVOT (
	DATA
	FOR COL
	IN (SAL)
)
;

ENAME  |COL |DATA |
-------|----|-----|
SMITH  |SAL |800  |
ALLEN  |SAL |1600 |
WARD   |SAL |1250 |
JONES  |SAL |2975 |
MARTIN |SAL |1250 |
BLAKE  |SAL |2850 |
CLARK  |SAL |2450 |
SCOTT  |SAL |3000 |
KING   |SAL |5000 |
TURNER |SAL |1500 |
ADAMS  |SAL |1100 |
JAMES  |SAL |950  |
FORD   |SAL |3000 |
MILLER |SAL |1300 |


--------------------------------------------------------------------
WITH TEMP AS (
	SELECT ENAME, SAL, COMM FROM EMP
)
SELECT ENAME, COL, DATA
FROM TEMP
UNPIVOT (
	DATA
	FOR COL
	IN (SAL, COMM)
)
;

ENAME  |COL  |DATA |
-------|-----|-----|
SMITH  |SAL  |800  |
ALLEN  |SAL  |1600 |
ALLEN  |COMM |300  |
WARD   |SAL  |1250 |
WARD   |COMM |500  |
JONES  |SAL  |2975 |
MARTIN |SAL  |1250 |
MARTIN |COMM |1400 |
BLAKE  |SAL  |2850 |
CLARK  |SAL  |2450 |
SCOTT  |SAL  |3000 |
KING   |SAL  |5000 |
TURNER |SAL  |1500 |
TURNER |COMM |0    |
ADAMS  |SAL  |1100 |
JAMES  |SAL  |950  |
FORD   |SAL  |3000 |
MILLER |SAL  |1300 |

---------------------------------------------------
WITH TEMP AS (
	SELECT JOB, SAL, COMM FROM EMP
)
SELECT JOB, SUM(DATA), AVG(DATA)    
FROM TEMP
UNPIVOT (
	DATA
	FOR COL
	IN (SAL, COMM)
)
GROUP BY JOB
;
JOB       |SUM(DATA) |AVG(DATA)                                 |
----------|----------|------------------------------------------|
CLERK     |4150      |1037.5                                    |
SALESMAN  |7800      |975                                       |
PRESIDENT |5000      |5000                                      |
MANAGER   |8275      |2758.333333333333333333333333333333333333 |
ANALYST   |6000      |3000                                      |
