DEFINE BUFFER bevento FOR evento.
    
FOR EACH evento WHERE NOT evento.anulado AND evento.origen = "CONTRATO" AND 
        evento.nro_tipo_evento = 1 AND frealizado > 01/01/2013 AND nro_certif = 0 AND
    evento.nro_evento = 338126 :
    FIND cliente WHERE cliente.nro_cliente =  evento.nro_cliente NO-LOCK.
    IF cliente.cdg_prov <> "01" THEN do:
    /*    DISPLAY evento.nro_cliente cliente.cdg_prov.*/
        NEXT.
    END.
    /*DISPLAY evento.nro_evento cliente.cdg_prov.*/
    FIND FIRST bevento WHERE bevento.periodo = evento.periodo AND
      NOT bevento.anulado AND ROWID(evento) <> ROWID(bevento) AND bevento.origen = "CONTRATO" AND bevento.nro_tipo_evento = 1 and
        evento.nro_cliente = bevento.nro_cliente NO-ERROR.
    IF AVAILABLE bevento THEN do:
        DISPLAY bevento.nro_evento. 
        NEXT. 
    END.
    DISPLAY evento.nro_evento evento.frealizado.
END.

