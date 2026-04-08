DEFINE BUFFER bevento FOR evento.
FIND tipo_evento WHERE tipo_evento.cdg_tipo_evento = "EL". 
FOR EACH evento WHERE evento.nro_identificacion <> 0 AND evento.nro_tipo_evento = tipo_evento.nro_tipo_evento AND NOT evento.anulado BY evento.frealizado BY evento.nro_evento:
    FIND bevento WHERE bevento.nro_tipo_evento = tipo_evento.nro_tipo_evento AND
                       evento.origen = bevento.origen AND 
                       evento.sub_evento = bevento.sub_evento AND 
                       NOT bevento.anulado AND
                       ROWID(bevento) <> ROWID(evento) AND
                       bevento.nro_identificacion = evento.nro_identificacion NO-ERROR.
IF NOT AVAILABLE bevento THEN 
   IF AMBIGUO bevento THEN do:
       FOR EACH bevento WHERE bevento.nro_tipo_evento = tipo_evento.nro_tipo_evento AND
                       evento.sub_evento = bevento.sub_evento AND 
                       evento.origen = bevento.origen AND 
                       NOT bevento.anulado AND
                       ROWID(bevento) <> ROWID(evento) AND
                       bevento.nro_identificacion = evento.nro_identificacion :
        DELETE bevento.
       END.

END.

END.

