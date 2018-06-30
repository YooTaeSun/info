
SELECT 
INSTR('AC+#AE-#F/#G*#G', '#'),
SUBSTR('AC+#AE-#F/#G*#G', 4 + 1)
FROM DUAL;

AC+#AE-#F/#G*#G
AE-#F/#G*#G
F/#G*#G
G*#G
G
;



SELECT 
REGEXP_REPLACE('AC+ ','\+|\-|\*|\/',''),
REPLACE('AC+ ','A _',''),
TRIM(' a b c d ')
FROM DUAL;


SELECT REGEXP_SUBSTR(email, '[^@]+', 1, 1) AS "ID"
,REGEXP_SUBSTR('-AC+#AE-#F/#G*#G', '[^#]+', 1, 1) bbb
,REGEXP_SUBSTR('-AC+','[^0-9]') ccc
--,REGEXP_LIKE('','[a-z]|[A-Z]|[0-9]|[가-히]')
FROM ( SELECT 'hellokitty@empal.com' email
FROM dual );

-- 문자만 특수문자 제외 
-- -AC+#AE-#F/#G*#G  -->  -AC AE F G G
select 
--REGEXP_REPLACE('-AC', '[0-9]') AAA, -- 문자만
--REGEXP_REPLACE('ab111cc', '[^0-9]') BBB, --숫자만 
--REGEXP_REPLACE('-AC+#AE-#F/#G*#G', '[0-9]') CCC,
REGEXP_REPLACE('-AC+#AE-#F/#G*#G',  '[-|+|*|/]','') DDD,
REGEXP_REPLACE(TRIM(' AC #AE #F #G #G
'),  ' ',' ') EEE,
INSTR('AC  AE  F  G  G','A') FFF,
REGEXP_REPLACE('A B C A','^(A){1}','')  GGG,
REGEXP_REPLACE('AABBAA', '^(AA){1}', 'CC') HHH,
REGEXP_REPLACE('-AC+#AE-#F/#G*#G', '(AC){1}', '') HHH,
SUBSTR('AB', 1,1) GG,
SUBSTR('AB', 2, 1) GG,
REGEXP_REPLACE('A B C A','','')  GGG
from dual;


SELECT TRIM(REGEXP_REPLACE('(agc010)-1!@1 1&%1-22**2 2', '[^[:alpha:]+]', ''))
FROM DUAL;

--


