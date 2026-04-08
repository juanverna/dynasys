/*asignarEC.p*/
/*{tiempo.i}
DEFINE VAR ff AS DATE.

DEFINE BUFFER bevento FOR evento.
DEFINE VAR nro_co LIKE tipo_evento.nro_tipo_evento.
OUTPUT TO c:\dynasys10\logs\asignarEC.LOG APPEND.
DISPLAY "Fecha corrida" NOW.

FIND tipo_evento WHERE tipo_evento.cdg_tipo_evento = "EC" NO-LOCK NO-ERROR.
IF NOT AVAILABLE tipo_evento THEN do:
    DISPLAY "Tipo EC no registrado".
    RETURN ERROR.
END.

FOR EACH evento WHERE evento.nro_tipo_evento = tipo_evento.nro_tipo_evento AND 
    evento.frealizado = ? AND 
    evento.fasignado = ? AND
    NOT evento.anulado :
    RUN asignarEC-cli.p ( evento.nro_cliente ).
END.
*/
