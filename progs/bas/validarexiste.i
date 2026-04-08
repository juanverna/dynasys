  IF NOT CAN-FIND({1} WHERE {1}.{2} = INPUT FRAME {3} {4}.{5})
  THEN DO:
       RUN PONMENSJ.P (INPUT "{6}").
       RETURN.
  END.
  &IF "{7}" <> ""
  &THEN
  ELSE DO:
       FIND {1} WHERE {1}.{2} = INPUT FRAME {3} {4}.{5} NO-LOCK.
       como_fue = YES.
       RUN {7}.
       IF NOT como_fue THEN RETURN.
  END.
  &ENDIF     
