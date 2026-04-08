     FIND FIRST {1} WHERE {1}.cdg_rubro = INPUT Tipo_actividad.cdg_{1} NO-LOCK NO-ERROR.
     IF NOT AVAILABLE {1}
     THEN DO:
        RUN PONMENSJ.P (INPUT "{2}").
        RETURN.
     END.                 
     ELSE DO:
        IF {1}.es_retencion <> "{4}"
        THEN DO:
           RUN PONMENSJ.P (INPUT "{3}").
           RETURN.
        END.   
     END.                 
     
