DEFINE VARIABLE ok AS LOGICAL.
RUN PONEMPRESA.P ("A").
ok = SETUSERID("cobrador","cobrador","sic").
IF ok 
   THEN run d-idemp.w.
   ELSE MESSAGE "Ni ahi" VIEW-AS ALERT-BOX MESSAGE.
QUIT.   
