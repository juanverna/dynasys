/*selecciona una fecha del calendario abriendo el mismo, va en los triggers de los campos fecha */
  DEFINE VAR fecha_elegida AS DATE NO-UNDO.
  fecha_elegida = DATE(self:SCREEN-VALUE IN FRAME {&FRAME-NAME}) NO-ERROR.
  IF fecha_elegida = ? THEN SELF:SCREEN-VALUE = string(TODAY).
  RUN d-calendario.w ( INPUT date(SELF:SCREEN-VALUE), OUTPUT fecha_elegida).
  IF fecha_elegida <> ?
  THEN DO:
       SELF:SCREEN-VALUE = string(fecha_elegida).
       APPLY "TAB" TO SELF.        
  END.               
