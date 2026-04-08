    
   FIND {1} WHERE {1}.{2} = INPUT FRAME {&FRAME-NAME} v-cdg_{1}
                   AND {1}.{3} = que_areas NO-LOCK NO-ERROR.
   
   IF NOT AVAILABLE {1} 
   THEN DO:
       hay_error = TRUE.
       RUN PONMENSJ.P ( '{5}' ).
   END.
