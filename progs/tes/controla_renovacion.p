 /*  DEFINE BUFFER bevento FOR evento.
    FOR EACH evento WHERE NOT evento.anulado AND evento.frealizado > 07/01/2015 AND
    evento.origen = "Contrato" , contrato_hd WHERE contrato_hd.nro_contrato = evento.nro_identificacion AND 
        contrato_hd.fecha_baja <> ? :
    IF NOT CAN-FIND(bevento WHERE bevento.origen = "contrato" AND bevento.nro_tipo_evento = evento.nro_tipo_evento AND NOT bevento.anulado AND
                    bevento.nro_identificacion > evento.nro_identificacion ) THEN DISPLAY evento.nro_identificacion.
END.
*/
DEFINE BUFFER bevento FOR evento.
    FOR EACH evento WHERE evento.nro_tipo_evento = 3 AND NOT evento.anulado AND evento.frealizado > 01/01/2014  AND
        evento.frealizado < 01/01/2015 AND evento.origen = "Contrato":
    IF NOT CAN-FIND(tarea WHERE tarea.nro_identificacion = evento.nro_identificacion AND Tarea.cdg_tipotarea = "L" 
                    ) THEN DISPLAY evento.nro_evento.
END.
