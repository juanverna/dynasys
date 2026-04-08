FOR EACH banco:
    banco.nombre = REPLACE(banco.nombre,"@@ ","").
    banco.nombre = "@@ " + banco.nombre.
    
END.
DEF VAR a AS INT.
DEF VAR b AS CHAR NO-UNDO.
INPUT FROM c:\bancos1.csv NO-ECHO.
REPEAT:
    IMPORT DELIMITER ";" a b.
    FIND banco WHERE cdg_banco = a NO-ERROR.
    IF NOT AVAILABLE banco THEN DO: 
        CREATE banco.
        ASSIGN banco.cdg_banco = a.
    END.
    ASSIGN banco.nombre = b.
END.
INPUT CLOSE.

