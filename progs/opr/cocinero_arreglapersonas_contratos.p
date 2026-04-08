FOR EACH contrato_hd WHERE nro_persona = 0:
    FOR EACH tarea WHERE tarea.nro_destino = contrato_hd.nro_contrato AND
        tarea.destino = "CONTRATO" :
        IF NOT AVAILABLE tarea THEN NEXT.
        FIND persona OF tarea NO-ERROR.
        IF NOT AVAILABLE tarea THEN NEXT.
        contrato_hd.nro_persona = persona.nro_persona.
         
    END.
END.
