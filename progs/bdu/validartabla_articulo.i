
  FIND {1} WHERE {1}.{2} = INPUT FRAME {&FRAME-NAME} v-cdg_{1} 
                 AND CAN-DO({1}.{4}, ' {5} ' ) NO-LOCK NO-ERROR.
  IF NOT AVAILABLE {1} 
  THEN DO:
        RUN PONMENSJ.P ( '{6}' ).
        hay_error = TRUE.
  END.
        

  IF NOT hay_error THEN DO:
      v-dsc_{1} = {1}.{3}.
      DISPLAY v-dsc_{1} WITH FRAME {&FRAME-NAME}.     
  END.
