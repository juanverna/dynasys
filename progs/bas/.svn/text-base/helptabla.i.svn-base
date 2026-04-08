ASSIGN v-cdg_{1}.
FIND {1} WHERE {1}.{2} = v-cdg_{1} NO-LOCK NO-ERROR.
   rid_tabla = IF AVAILABLE {1} THEN ROWID( {1} ) ELSE ?.

  RUN {3} ( INPUT-OUTPUT rid_tabla, INPUT YES ).
  IF rid_tabla <> ?
  THEN DO:
       FIND {1} WHERE ROWID({1}) = rid_tabla NO-LOCK.
       DISPLAY {1}.{2} @ v-cdg_{1}
               WITH  FRAME {&FRAME-NAME}.
       APPLY "RETURN" TO SELF.
  END.       
  RETURN NO-APPLY.  
