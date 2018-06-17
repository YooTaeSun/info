-- 1. OBJECT 타입 생성
CREATE OR REPLACE
TYPE T_OBJ AS OBJECT
(
	  COL1 VARCHAR2(100)
	, COL2 VARCHAR2(100)
);

------------------------------------------------------------------------

-- 2. TABLE 타입 생성
CREATE OR REPLACE
TYPE T_TABLE AS TABLE OF T_OBJ;
------------------------------------------------------------------------

-- 3. 함수 생성 (테이블 리턴)
CREATE OR REPLACE
FUNCTION TFN_LIST(P_COL1 VARCHAR2)
RETURN T_TABLE
IS
    V_RTN T_TABLE;
BEGIN
    SELECT T_OBJ(COL1, COL2)
    BULK COLLECT INTO V_RTN
    FROM
    (
        SELECT DEPT.DNAME AS COL1, DEPT.LOC AS COL2
        FROM DEPT
    );
    RETURN V_RTN;
END TFN_LIST;

------------------------------------------------------------------------

-- 실행
DECLARE
BEGIN
    FOR I IN
    (
        SELECT *
        FROM TABLE(TFN_LIST('AA'))
    )
    LOOP
        DBMS_OUTPUT.PUT_LINE(I.COL1 || ',  ' || I.COL2);
    END LOOP;
END;
------------------------------------------------------------------------