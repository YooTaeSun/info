create or replace FUNCTION test_func (
p_name IN VARCHAR2,
seq IN NUMBER
)
RETURN VARCHAR IS v_test VARCHAR2(100);

BEGIN v_test := 'testFunction';

DBMS_OUTPUT.PUT_LINE('p_name >> ' || p_name);
DBMS_OUTPUT.PUT_LINE('seq >> ' || seq);

RETURN v_test;
END;

--------------------------------------------------

show serveroutput;
set serveroutput on;

SELECT
	test_func('aaaa',123)
FROM
	dual;


declare
  resultVal VARCHAR2(100);
begin
  resultVal := test_func('aaaa',123);
  DBMS_OUTPUT.PUT_LINE('func result >> ' || resultVal);
end;