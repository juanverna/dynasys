  FIND {1} WHERE {1}.{2} = INPUT FRAME {&FRAME-NAME} v-cdg_{1} NO-LOCK NO-ERROR.
  IF NOT AVAILABLE {1} 
  THEN DO:
      RUN PONMENSJ.P ( '{4}' ).
  END.
  ELSE DO:
      v-dsc_{1} = {1}.{3}.
      DISPLAY v-dsc_{1} WITH FRAME {&FRAME-NAME}.     
  END.


