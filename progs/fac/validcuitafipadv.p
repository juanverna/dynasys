/*validar cuit con la afip*/
/*https://soa.afip.gob.ar/sr-padron/v2/persona/30552991237*/
DEFINE STREAM cu.
DEFINE VARIABLE mLine AS MEMPTR     NO-UNDO.
DEFINE VAR js AS CHAR NO-UNDO.
DEFINE VAR cc AS CHAR NO-UNDO.
DEFINE STREAM mal.

FOR EACH cliente WHERE cuit <> "" AND cliente.cuit <> "1" :

    DOS SILENT VALUE("..\procs\curl  -k -o c:\temp\pp.txt https://soa.afip.gob.ar/sr-padron/v2/persona/" + cliente.cuit ).
    INPUT FROM "c:\temp\pp.txt" BINARY.
    SEEK INPUT TO END .
    SEEK INPUT TO (SEEK(INPUT) - 1) .
    SET-SIZE(mLine) = 0 .
    SET-SIZE(mLine) = 1 .
    IMPORT UNFORMATTED mLine .
    INPUT CLOSE .
    
    IF get-byte(mLine,1) <> 10 THEN DO:
      OUTPUT TO "c:\temp\pp.txt" APPEND .
      PUT UNFORMATTED "~n" .
      OUTPUT CLOSE .
    END. 
    INPUT STREAM cu FROM "c:\temp\pp.txt" BINARY.
    cc = "".
    REPEAT:
    IMPORT STREAM cu  UNFORMATTED js .
    cc = cc + js.
    END.
    IF index(cc,'"success":true') = 0 THEN DO:
        OUTPUT STREAM mal TO c:\temp\cuitinvalidos4.txt APPEND.
        PUT STREAM mal cliente.cdg_cliente cliente.cuit SKIP.
        OUTPUT STREAM mal CLOSE.
        cliente.cuit = "".
    END.
    INPUT STREAM cu CLOSE.
END.
