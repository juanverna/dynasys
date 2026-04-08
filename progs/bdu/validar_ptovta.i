    {findempresa.i}
    FIND {1} WHERE {1}.{2} = INPUT FRAME {&FRAME-NAME} v-{3} AND {1}.cdg_empresa = que_empresa NO-LOCK NO-ERROR.
    
    IF NOT AVAILABLE {1}  THEN DO:  
            hay_error = TRUE.
            RUN PONMENSJ.P ( '{4}' ).
    END.
   
