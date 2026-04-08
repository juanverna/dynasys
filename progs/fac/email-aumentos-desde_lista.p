/*lee el archivo y aplica el aumento para que e el precio total
el archivo tiene 
nro_contrato,precio_total
Primero verifica que todo lo enviado este correcto y sino informa el error
*/

DEFINE VAR archivo AS CHAR FORMAT "X(50)" INITIAL "c:\temp\aumentos.txt".
DEFINE VAR nro LIKE contrato_hd.nro_contrato.
DEFINE BUFFER administrador FOR cliente.
DEFINE TEMP-TABLE adm
    FIELD cdg AS CHAR
    FIELD nombre AS CHAR
    FIELD email AS CHAR.

DEFINE VAR imp AS decimal.
UPDATE archivo.
INPUT FROM value(archivo) NO-ECHO.
REPEAT:
    SET nro imp.
    FIND contrato_hd WHERE contrato_hd.nro_contrato = nro NO-LOCK NO-ERROR.
    FIND cliente OF contrato_hd.
    FIND administrador WHERE cliente.nro_admin = administrador.nro_cliente.
    FIND adm WHERE adm.cdg = administrador.cdg_cliente NO-LOCK NO-ERROR.
    IF AVAILABLE adm THEN NEXT.
    CREATE adm.
    ASSIGN adm.cdg = administrador.cdg_cliente
           adm.nombre = administrador.nom_cliente.
    FIND FIRST domicilio OF administrador.
    
    FOR EACH cliente-contacto OF domicilio, persona OF cliente-contacto  BY preferido:
        ASSIGN adm.email = persona.email.
    END.
    
END.
INPUT CLOSE.
OUTPUT TO c:\temp\emailaumentos.txt.
FOR EACH adm:
    EXPORT adm.
END.
OUTPUT CLOSE.
