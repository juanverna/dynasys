DEF VAR c AS INT.
FOR EACH _file 
    WHERE NOT ( _file._file-name BEGINS "_" OR _file._file-name BEGINS "SYS" ) 
               AND SUBSTRING(_file._desc,5,2) = "MA"
                   BY SUBSTRING(_file._desc,1,3):
    IF NOT CAN-FIND(FIRST _Field OF _File WHERE _Field._Field-name = "lista_empresas") AND
       NOT CAN-FIND(FIRST _Field OF _File WHERE _Field._Field-name = "empresas_habilitadas")
    THEN DO:
        c = c + 1.
        DISPLAY _file._file-name SUBSTRING(_file._desc,1,3) WITH STREAM-IO.
    END.

END.
DISPLAY c.
