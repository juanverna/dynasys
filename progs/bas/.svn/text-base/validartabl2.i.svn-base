  FIND {1} WHERE {1}.{2} = {&ENTIDAD}.{3} NO-LOCK NO-ERROR.
  IF NOT AVAILABLE {1} 
  THEN DO:
        RUN PONMENSJ.P ( '{4}' ).
        RETURN ERROR.
  END.
