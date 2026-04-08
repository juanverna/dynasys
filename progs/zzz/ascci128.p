DEFINE VARIABLE j AS INTEGER.
DEFINE VARIABLE revisado AS LOGICAL.
OUTPUT TO "c:\sic-temp\asciis.txt" PAGE-SIZE 0.
FOR EACH domicilio:
    revisado = NO.
    DO j = 1 TO LENGTH(direccion) WHILE NOT revisado:
        IF ASC(SUBSTRING(direccion,j,1)) > 127 
        THEN DO:
            FIND Cliente OF Domicilio.
            DISPLAY Cliente.cdg_cliente 
                /*
                ASC(SUBSTRING(domicilio.direccion,j,1)) 
                SUBSTRING(domicilio.direccion,j,1)
                */
                domicilio.direccion
                  WITH WIDTH 132.
            revisado = YES.
        END.
    END.

END.
