OUTPUT TO c:\compumap\bsas\clientes.txt.
DEF VAR cdire AS CHAR NO-UNDO.
DEF VAR calt AS CHAR NO-UNDO.
DEF VAR vd AS CHAR NO-UNDO.

FOR EACH cliente WHERE SUBSTRING(cdg_cliente,1,1) = "C":
    vd = TRIM(direccion).
    cdire = trim(SUBSTRING( vd , 1, R-INDEX( vd ," ") - 1 )).
    calt = TRIM(SUBSTRING( vd , R-INDEX( vd," ") + 1 )).


    PUT cdg_cliente FORMAT("x(5)") cdire FORMAT "X(40)" calt FORMAT "X(6)" SKIP.
END.
