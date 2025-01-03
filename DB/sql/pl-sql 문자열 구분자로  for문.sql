SET SERVEROUTPUT ON ;
-----------------------------------------------------------
-- pl-sql 문자열 구분자로  for문 
-----------------------------------------------------------
DECLARE
    V_LS_TEMP VARCHAR2(100) := '';
    V_LS_ORGIN VARCHAR2(100) := '';
    
    V_LL_POS INTEGER;
    V_LS_VAL VARCHAR2(1000);
    V_LS_ASCII_VAL NUMBER;
BEGIN
    V_LS_ORGIN := '(-AC+ #AE)  -(#F/#G) * #H';
    DBMS_OUTPUT.PUT_LINE(' INIT VAL ======== ' || V_LS_ORGIN);
    V_LS_TEMP := REGEXP_REPLACE(V_LS_ORGIN,'[-|+|*|/]'); -- AC #AE #F #G #G
    V_LS_ORGIN := REPLACE(V_LS_ORGIN,'#'); -- AC #AE #F #G #G
    
    LOOP
        V_LL_POS := INSTR(V_LS_TEMP, '#');        
        IF V_LL_POS = 0 THEN 
            V_LS_VAL := V_LS_TEMP;
            V_LS_VAL := TRIM(REGEXP_REPLACE(V_LS_VAL, '[^[:alpha:]+]', ''));
            
            DBMS_OUTPUT.PUT_LINE(V_LS_VAL);
            IF LENGTH(V_LS_VAL) = 2 THEN
                V_LS_ASCII_VAL := (ASCII(SUBSTR(V_LS_VAL, 1, 1))-64) * 26 + (ASCII(SUBSTR(V_LS_VAL, 2, 1))-64);
            ELSIF LENGTH(V_LS_VAL) = 1 THEN 
             V_LS_ASCII_VAL := ASCII(V_LS_VAL) -64;
            END IF;
            V_LS_ORGIN := REGEXP_REPLACE(V_LS_ORGIN, '('||V_LS_VAL||'){1}', 'COL_'|| V_LS_ASCII_VAL);
            EXIT;
        END IF;
            
        V_LS_VAL := TRIM(SUBSTR(V_LS_TEMP, 1, V_LL_POS - 1));
        V_LS_VAL := TRIM(REGEXP_REPLACE(V_LS_VAL, '[^[:alpha:]+]', ''));
 DBMS_OUTPUT.PUT_LINE(' V_LS_VAL >> ' || V_LS_VAL);
        IF LENGTH(V_LS_VAL) = 2 THEN
            V_LS_ASCII_VAL := (ASCII(SUBSTR(V_LS_VAL, 1, 1))-64) * 26 + (ASCII(SUBSTR(V_LS_VAL, 2, 1))-64);
        ELSIF LENGTH(V_LS_VAL) = 1 THEN 
            V_LS_ASCII_VAL := ASCII(V_LS_VAL) -64;
        END IF;
        V_LS_ORGIN := REGEXP_REPLACE(V_LS_ORGIN, '('||V_LS_VAL||'){1}', 'COL_'|| V_LS_ASCII_VAL);
        V_LS_TEMP := SUBSTR(V_LS_TEMP, V_LL_POS + 1);
    END LOOP;
    
    DBMS_OUTPUT.PUT_LINE('=========================================');
    DBMS_OUTPUT.PUT_LINE('' || V_LS_ORGIN);
END;


