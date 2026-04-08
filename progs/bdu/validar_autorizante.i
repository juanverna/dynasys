    
    FIND {1} WHERE {1}.{2} = INPUT FRAME {&FRAME-NAME} v-cdg_{3}
                    AND {1}.{4} = {5}
                    /*AND {1}.{6} = INPUT FRAME {&FRAME-NAME} v-cdg_{7} NO-LOCK NO-ERROR.*/
                    AND que_areas BEGINS {1}.{6} NO-LOCK NO-ERROR.
    
    IF NOT AVAILABLE {1} 
    THEN DO:
        hay_error = TRUE.
        RUN PONMENSJ.P ( '{8}' ).
    END.
