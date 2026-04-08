  FIND {2} NO-LOCK NO-ERROR.
  IF AVAILABLE {2} THEN DO:
       v-cdg_{1}:SCREEN-VALUE IN FRAME {&FRAME-NAME} = {3}.
       v-dsc_{1}:SCREEN-VALUE IN FRAME {&FRAME-NAME} = {4}.
  END.
  ELSE DO:
       v-cdg_{1}:SCREEN-VALUE IN FRAME {&FRAME-NAME} = "".
       v-dsc_{1}:SCREEN-VALUE IN FRAME {&FRAME-NAME} = "".   
  END. 
