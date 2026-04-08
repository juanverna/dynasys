  IF ( INPUT FRAME {3} {4}.{5} ) <> 0  AND
     NOT CAN-FIND({1} WHERE {1}.{2} = INPUT FRAME {3} {4}.{5})
  THEN DO:
     RUN PONMENSJ.P (INPUT "{6}").
     RETURN.
  END.     
