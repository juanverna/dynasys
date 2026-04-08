   DEFINE VARIABLE baja_no AS LOGICAL.
   RUN {2} ( INPUT ROWID({1}), OUTPUT baja_no ).
   IF baja_no 
   THEN DO:
        RUN PONMENSJ.P ( "IREF001" ).
        RETURN ERROR.
   END.        
