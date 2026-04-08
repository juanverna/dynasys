  FIND {&TABLA} WHERE {&TABLA}.{&CDG_TABLA} = INPUT FRAME {&FRAME-NAME} {&CAMPO-FRAME} NO-LOCK NO-ERROR.
  IF AVAILABLE {&TABLA} 
  THEN DO:
       {&V-DSC_TABLA} = {&TABLA}.{&DSC_TABLA}.
       DISPLAY {&V-DSC_TABLA}
               WITH FRAME {&FRAME-NAME}. 
       APPLY "TAB" TO SELF.
  END.
  ELSE DO:
       MESSAGE "No existe el Registro indicado" VIEW-AS ALERT-BOX ERROR.
  END.               
  RETURN NO-APPLY.
