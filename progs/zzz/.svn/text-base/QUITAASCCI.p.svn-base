DEFINE VARIABLE j AS INTEGER.
DEFINE VARIABLE revisado AS LOGICAL.
OUTPUT TO "c:\sic-temp\asciis.txt" PAGE-SIZE 0.
FOR EACH domicilio:
    DO j = 1 TO LENGTH(direccion):
        IF ASC(SUBSTRING(direccion,j,1)) > 127 
        THEN DO:          
             SUBSTRING(Domicilio.direccion,j,1) = " ".
        END.
    END.
    DO j = 1 TO LENGTH(localidad):
        IF ASC(SUBSTRING(localidad,j,1)) > 127 
        THEN DO:          
             SUBSTRING(Domicilio.localidad,j,1) = " ".
        END.
    END.
END.
