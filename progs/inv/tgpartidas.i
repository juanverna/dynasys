ON ".", MOUSE-SELECT-DBLCLICK OF Partida.cdg_partida  IN FRAME frm-cantidad
DO:

  IF NOT AVAILABLE Deposito
  THEN DO:
       RUN PONMENSJ.P ( INPUT "VSAL008" ).
       RETURN NO-APPLY.
  END.     

  RUN SELPARDE.P ( INPUT ROWID(Deposito)).
  IF ult_partida <> ?
  THEN DO:
     FIND Partida WHERE ROWID(Partida) = ult_partida NO-LOCK.
     DISPLAY Partida.cdg_partida WITH FRAME frm-cantidad.
     APPLY "RETURN" TO Partida.cdg_partida IN FRAME frm-cantidad.
     RETURN NO-APPLY.
  END.
END.

ON ENTRY OF Partida.cdg_partida  IN FRAME frm-cantidad
DO:
  ant_ROWID = ROWID(Partida).
END.

ON RETURN, TAB OF Partida.cdg_partida  IN FRAME frm-cantidad
DO:

   IF NOT AVAILABLE Deposito
   THEN DO:
        RUN PONMENSJ.P ( INPUT "VSAL008" ).
        RETURN NO-APPLY.
   END.     

   FIND FIRST Partida OF Articulo USING cdg_partida NO-LOCK NO-ERROR.

   IF NOT AVAILABLE Partida
   THEN DO:
      BELL.
      MESSAGE "El codigo indicado no existe en la tabla maestra"
        VIEW-AS ALERT-BOX ERROR BUTTONS OK.
      RETURN NO-APPLY.
   END.
   ELSE DO:
      act_partida = ROWID(Partida).
      FIND Partida-deposito OF Partida WHERE Partida-deposito.cdg_deposito = 
                                             Deposito.cdg_deposito NO-LOCK NO-ERROR.
      IF NOT AVAILABLE Partida-deposito
      THEN DO:
           DO TRANSACTION:
                CREATE Partida-deposito.
                ASSIGN Partida-deposito.cdg_deposito = Deposito.cdg_deposito
                       Partida-deposito.nro_articulo = Partida.nro_articulo
                       Partida-deposito.nro_partida  = Partida.nro_partida.
           END.       
      END.            
      DISPLAY Partida.descripcion 
              Partida-deposito.remanente_cantidad
              Partida-deposito.remanente_granel
              WITH FRAME frm-cantidad.
    END.

END.

ON F7 OF Partida.cdg_partida  IN FRAME frm-cantidad
DO:
  HIDE FRAME frm-cantidad.
  ult_partida = ?.
  RUN ACTPARTI.P (INPUT 1).
  RUN PONER_SESION.
  IF ult_partida <> ?
  THEN DO:
     ant_ROWID = ?.
     FIND Partida WHERE ROWID(Partida) = ult_partida NO-LOCK.
     DISPLAY Partida.cdg_partida WITH FRAME frm-cantidad.
     APPLY "RETURN" TO Partida.cdg_partida IN FRAME frm-cantidad.
  END.
  ELSE DO:
     VIEW FRAME frm-cantidad.
     APPLY "ENTRY" TO Partida.cdg_partida IN FRAME frm-cantidad.
  END.
  RETURN NO-APPLY.
END.

ON F8 OF Partida.cdg_partida  IN FRAME frm-cantidad
DO:
  IF NOT AVAILABLE Partida
  THEN DO:
     RUN PONMENSJ.P (INPUT "HELP001").
  END.
  ELSE DO:
     HIDE FRAME frm-cantidad.
     ult_partida = ROWID(Partida).
     RUN ACTPARTI.P (INPUT 2).
     RUN PONER_SESION.
     IF ult_partida <> ?
     THEN DO:
        ant_ROWID = ?.
        FIND Partida WHERE ROWID(Partida) = ult_partida NO-LOCK.
        DISPLAY Partida.cdg_partida WITH FRAME frm-cantidad.
        APPLY "RETURN" TO Partida.cdg_partida IN FRAME frm-cantidad.
     END.
     ELSE DO:
        VIEW FRAME frm-cantidad.
        APPLY "ENTRY" TO Partida.cdg_partida IN FRAME frm-cantidad.
     END.
  END.
  RETURN NO-APPLY.
END.
