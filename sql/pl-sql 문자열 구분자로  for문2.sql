
SET SERVEROUTPUT ON ;

DECLARE
--    V_LS_TEMP VARCHAR2(100) := '#C+#E-#F';
    V_LS_TEMP VARCHAR2(100) := '';
--    V_LS_TEMP VARCHAR2(100) := '아이디,이름,등록일';
    
    V_LL_POS INTEGER;
    V_LL_POS_2 INTEGER;
    V_LS_VAL VARCHAR2(1000);
    
    V_UPDAET_SQL VARCHAR2(3000);
    
    V_VAL VARCHAR2(100);
    V_SIGN VARCHAR2(100);
    
BEGIN
    V_LS_TEMP := '-AC+#AE -    #F       /#G*#G';
    V_UPDAET_SQL := '';
    
    LOOP
--        V_LL_POS := INSTR(V_LS_TEMP, ',');

DBMS_OUTPUT.PUT_LINE(' INIT VAL ======== ' || V_LS_TEMP);
        V_LL_POS := INSTR(V_LS_TEMP, '#');        
        IF V_LL_POS = 0 THEN 
            V_LS_VAL := V_LS_TEMP;
            
            DBMS_OUTPUT.PUT_LINE(V_LS_VAL);
            V_UPDAET_SQL := V_UPDAET_SQL || ' ' || V_SIGN || ' COL_' || V_VAL;
            EXIT;
        END IF;
            
        V_LS_VAL := TRIM(SUBSTR(V_LS_TEMP, 1, V_LL_POS - 1));

        DBMS_OUTPUT.PUT_LINE(V_LS_VAL);
        V_VAL := REGEXP_REPLACE(V_LS_VAL,'\+|\-|\*|\/','');
        V_UPDAET_SQL := V_UPDAET_SQL || ' ' || V_SIGN || ' COL_' || V_VAL;
        V_SIGN := REPLACE(V_LS_VAL, V_VAL,'');

        
        DBMS_OUTPUT.PUT_LINE(' V_VAL >> ' || V_VAL || '  V_SIGN >> ' || V_SIGN);
        
        DBMS_OUTPUT.PUT_LINE(' V_LS_TEMP >> ' || V_LS_TEMP);
        V_LS_TEMP := SUBSTR(V_LS_TEMP, V_LL_POS + 1);
    END LOOP;
    
    DBMS_OUTPUT.PUT_LINE('=========================================');
    DBMS_OUTPUT.PUT_LINE(V_UPDAET_SQL);
END;
--      -AC+#AE -    #F       /#G*#G
--      -3+22 -    4       /#7*#8

