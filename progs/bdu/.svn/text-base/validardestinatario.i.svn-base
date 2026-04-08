
    FIND {1} WHERE {1}.{2} = INPUT FRAME {&FRAME-NAME} v-cdg_{1} 
                      AND {1}.{3} = {4} NO-LOCK NO-ERROR.
    IF NOT AVAILABLE {1} 
    THEN DO:
        RUN PONMENSJ.P ( '{5}' ).
        hay_error = TRUE.
    END.
