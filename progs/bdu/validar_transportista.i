
    FIND {1} WHERE {1}.{2} = INPUT FRAME {&FRAME-NAME} v-cdg_{1} NO-LOCK NO-ERROR.
    
    IF NOT AVAILABLE {1} 
    THEN DO:
        hay_error = TRUE.
        RUN PONMENSJ.P ( '{3}' ).
    END.
