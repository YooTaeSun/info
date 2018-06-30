SELECT
	EMPNO,
	ENAME,
	LEVEL,
	MGR,
	PRIOR ENAME AS MGR_ENAME,
	SUBSTR( SYS_CONNECT_BY_PATH( ENAME, '-' ), 2 )
FROM
	EMP
START WITH
	MGR IS NULL
CONNECT BY
	PRIOR EMPNO = MGR
ORDER SIBLINGS BY EMPNO;

EMPNO |ENAME  |LEVEL |MGR  |MGR_ENAME |SUBSTR(SYS_CONNECT_BY_PATH(ENAME,'-'),2) |
------|-------|------|-----|----------|-----------------------------------------|
7839  |KING   |1     |     |          |KING                                     |
7566  |JONES  |2     |7839 |KING      |KING-JONES                               |
7788  |SCOTT  |3     |7566 |JONES     |KING-JONES-SCOTT                         |
7876  |ADAMS  |4     |7788 |SCOTT     |KING-JONES-SCOTT-ADAMS                   |
7902  |FORD   |3     |7566 |JONES     |KING-JONES-FORD                          |
7369  |SMITH  |4     |7902 |FORD      |KING-JONES-FORD-SMITH                    |
7698  |BLAKE  |2     |7839 |KING      |KING-BLAKE                               |
7499  |ALLEN  |3     |7698 |BLAKE     |KING-BLAKE-ALLEN                         |
7521  |WARD   |3     |7698 |BLAKE     |KING-BLAKE-WARD                          |
7654  |MARTIN |3     |7698 |BLAKE     |KING-BLAKE-MARTIN                        |
7844  |TURNER |3     |7698 |BLAKE     |KING-BLAKE-TURNER                        |
7900  |JAMES  |3     |7698 |BLAKE     |KING-BLAKE-JAMES                         |
7782  |CLARK  |2     |7839 |KING      |KING-CLARK                               |
7934  |MILLER |3     |7782 |CLARK     |KING-CLARK-MILLER                        |
