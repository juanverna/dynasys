DEF VAR xx AS CHAR FORMAT "X(50)".
RUN prinresumenes.p ( "P","a0000","zzz",DATE(11,30,2006), OUTPUT xx ).
UPDATE xx.
/*RUN prinresumenes.p ( "P","A0004","A0004",DATE(4,1,2006),DATE(4,30,2006)).*/
