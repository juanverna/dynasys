/*--------------------------- Mantenimiento de la tabla asociada ------------------*/

ON RETURN, MOUSE-SELECT-DBLCLICK OF {&BROWSE} IN FRAME {&FRAME-MAIN}
DO:
  sino_grabar = NO.
  {&ACT_REGBROWSE} = ROWID({&TABLA-BRW}).
  IF {&ACT_REGBROWSE} <> ?
  THEN DO:
      RUN {&ACTREGIS}.P (INPUT 2).
      &IF DEFINED(PROC_ACTUALIZAR) NE 0
      &THEN
      RUN {&PROC_ACTUALIZAR}.
      &ENDIF
      OPEN QUERY {&QRY_BROWSE} FOR EACH {&QRY_CONDICION}.
  END.
  ELSE DO:
     BELL.
     MESSAGE "{&MENSAJE-VACIO}"
             VIEW-AS ALERT-BOX WARNING BUTTONS OK TITLE "Aviso".
  END.        
END.  

ON DELETE OF {&BROWSE} IN FRAME {&FRAME-MAIN}
DO:

  sino = NO.
  {&ACT_REGBROWSE} = ROWID({&TABLA-BRW}).
  IF {&ACT_REGBROWSE} <> ?
  THEN DO:
     FIND {&TABLA-BRW} WHERE ROWID({&TABLA-BRW}) = {&ACT_REGBROWSE} EXCLUSIVE-LOCK.
     MESSAGE "{&MENSAJE-BAJA}"
             VIEW-AS ALERT-BOX QUESTION BUTTONS OK-CANCEL 
             TITLE "Se pide Confirmacion" SET sino.
     IF sino 
     THEN DO:
        DELETE {&TABLA-BRW}.
      &IF {&MULTI-BROWSE} &THEN 
        ver = {&VER}.
        APPLY "VALUE-CHANGED" TO ver IN FRAME {&FRAME-MAIN}.
      &ENDIF
      &IF NOT {&MULTI-BROWSE} &THEN
       &IF DEFINED(PROC_ACTUALIZAR) NE 0
       &THEN
       RUN {&PROC_ACTUALIZAR}.
       &ENDIF
        OPEN QUERY {&QRY_BROWSE} FOR EACH {&QRY_CONDICION}.
      &ENDIF    
     END.
  END.
  ELSE DO:
     BELL.
     MESSAGE "{&MENSAJE-VACIO}"
             VIEW-AS ALERT-BOX WARNING BUTTONS OK TITLE "Aviso".
  END.             
  
END.  

ON INSERT OF {&BROWSE} IN FRAME {&FRAME-MAIN}
DO:

  {&ACT_REGBROWSE} = ROWID({&TABLA-BRW}).
  RUN {&ACTREGIS}.P (INPUT 1).
  &IF DEFINED(PROC_ACTUALIZAR) NE 0
  &THEN
  RUN {&PROC_ACTUALIZAR}.
  &ENDIF
  IF {&ULT_REGBROWSE} <> ?
  THEN DO:
      &IF {&MULTI-BROWSE} &THEN 
        ver = {&VER}.
        APPLY "VALUE-CHANGED" TO ver IN FRAME {&FRAME-MAIN}.
      &ENDIF
      &IF NOT {&MULTI-BROWSE} &THEN
        &IF DEFINED(PROC_ACTUALIZAR) NE 0
        &THEN
        RUN {&PROC_ACTUALIZAR}.
        &ENDIF
        OPEN QUERY {&QRY_BROWSE} FOR EACH {&QRY_CONDICION}.
      &ENDIF    
  END.    

END.
