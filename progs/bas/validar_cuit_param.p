/*validacion de cuit*/
/*
1= No control (no utilizar salvo casos especiales de mostrador)
2= Se avisa que el cuit es invalido ( checkeando solamente si esta en blanco o no )
3= Se avisa que el cuit es invalido validando por la rutina de digito verificador afip.
4=Si es vacio el cuit no permite proseguit pero no hay otra validacion
5=validacion completa del cuit segun afip
*/

DEFINE VARIABLE mLine AS MEMPTR     NO-UNDO.
DEFINE VAR js AS CHAR NO-UNDO.
DEFINE VAR cc AS CHAR NO-UNDO.
DEFINE VAR tempfile AS CHAR NO-UNDO.
tempfile = SESSION:TEMP-DIRECTORY + USERID("sic") + ".tmp".


FUNCTION vcuit RETURNS LOGICAL ( ipccuit AS CHAR ):

DEF VAR cMascara AS CHAR NO-UNDO INITIAL '54327654321'.
DEF VAR dArray AS DEC EXTENT 11 NO-UNDO.
DEF VAR dResultado AS DEC NO-UNDO.
DEF VAR lresultado AS logical NO-UNDO.
DEF VAR i AS INT.
    REPLACE(ipccuit,"-","").
    ipccuit = TRIM(ipccuit).
    IF LENGTH(ipccuit) <> 11 THEN RETURN NO.
    DO  i = 1 TO 11.
        dArray[i] = DEC(SUBSTRING(ipcCuit,i,1)).
        dArray[i] = dArray[i] * DEC(SUBSTRING(cMascara,i,1)).
        dResultado = dResultado + dArray[i].
    END.
    IF NOT (dResultado MOD 11 = 0) THEN
        RETURN FALSE.
    ELSE DO:
        RETURN TRUE.
        /*DOS SILENT VALUE("..\procs\curl  -k -o " + tempfile + " https://soa.afip.gob.ar/sr-padron/v2/persona/" +  ipccuit ).
        INPUT FROM value(tempfile) BINARY.
        SEEK INPUT TO END .
        SEEK INPUT TO ( SEEK(INPUT) - 1) .
        SET-SIZE(mLine) = 0 .
        SET-SIZE(mLine) = 1 .
        IMPORT UNFORMATTED mLine .
        INPUT CLOSE .
    
        IF get-byte(mLine,1) <> 10 THEN DO:
          OUTPUT TO VALUE(tempfile) APPEND .
          PUT UNFORMATTED "~n" .
        OUTPUT CLOSE .
        END.
        INPUT FROM VALUE(tempfile) BINARY.
        cc = "".
        REPEAT:
            IMPORT UNFORMATTED js .
            cc = cc + js.
        END.
        INPUT CLOSE.
        RETURN index(cc,'"success":true') <> 0.*/
    
    END.
END FUNCTION.


DEFINE INPUT PARAMETER cuit AS CHAR NO-UNDO.
DEFINE INPUT PARAMETER valcuit AS int NO-UNDO.

DEFINE VAR nivel AS INT NO-UNDO.
IF valcuit = ? THEN
   RUN getparametro_n.p ( "CNDCUIT" , OUTPUT nivel).
ELSE
    nivel = valcuit.

/*cuidado al leer este case por los if do end y los que no */

CASE nivel: 
    WHEN 5 THEN DO:
        IF vcuit(cuit) = FALSE THEN do:
        RUN ponmensj.p ("usr_016").
            RETURN "NO".
        END.
        ELSE RETURN "OK".
    END.    
    WHEN 4 THEN DO:
        IF cuit = "" THEN do:
            RUN ponmensj.p ("usr_016").
            RETURN "NO".
        END.
        ELSE RETURN "OK".
    END.    
    WHEN 3 THEN DO:
        IF vcuit(cuit) = FALSE THEN 
            RUN ponmensj.p ("usr_016").
            RETURN "OK".
    END.
    WHEN 2 THEN DO:
        IF vcuit(cuit) = FALSE THEN 
            RUN ponmensj.p ("usr_016").
            RETURN "OK".
    END.    
    WHEN 1 THEN DO:
            RETURN "OK".
        END.
END CASE.
MESSAGE "ERROR DE IMPLEMENTACION - AVISE INMEDIATAMENTE" SKIP
    "Falta poner el valor del parametro CNDCUIT"
    VIEW-AS ALERT-BOX INFO BUTTONS OK.
RETURN "NO".


