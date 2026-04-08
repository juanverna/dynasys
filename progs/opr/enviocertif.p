/*envio automatizado de los emails de los certificados*/.    
    DEFINE BUFFER bevento FOR evento.
        /*
    FOR EACH bevento WHERE bevento.url1<> "" AND NOT bevento.envio_email and bevento.sub_evento = 1 AND bevento.nro_tipo_evento = 1:
        FIND evento WHERE RECID(evento) = RECID(bevento) EXCLUSIVE-LOCK NO-WAIT.
        IF NOT AVAILABLE evento THEN NEXT.
    RUN qrcodemcba.p(evento.nro_evento,"").*/
        FOR each bevento WHERE bevento.frealizado >= 06/01/2019 AND 
            NOT bevento.envio_email and 
            /*bevento.sub_evento = 1 AND*/ 
            bevento.nro_tipo_evento = 1:
            FIND evento WHERE RECID(evento) = RECID(bevento) EXCLUSIVE-LOCK NO-WAIT.
            IF NOT AVAILABLE evento THEN NEXT.
            RUN emailcertiffumi.p( bevento.nro_evento , ""). 
            PAUSE 0.
        END.

