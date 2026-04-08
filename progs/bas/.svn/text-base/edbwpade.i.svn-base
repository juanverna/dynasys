PROCEDURE CREAR_DETALLE:

  RUN {1} ( INPUT 0 ).
  IF ult_partidepo <> ?
  THEN DO:
     RUN ABRE_QUERY.
     RUN PONER_SESION.
  END.
         
END PROCEDURE.

PROCEDURE ELIMINAR_DETALLE:

   IF NOT AVAILABLE Partida-deposito
   THEN DO:
        RUN PONMENSJ.P ( INPUT "REQU013" ).
        RETURN.
   END.

   IF Partida-deposito.remanente_unidades <> 0 OR Partida-deposito.remanente_granel <> 0
   THEN DO:
        RUN PONMENSJ.P ( INPUT "REQU012" ).
        RETURN.
   END.
   ELSE DO:
      sino = NO.
      MESSAGE "Realmente desea eliminar esta partida en este deposito?"
         VIEW-AS ALERT-BOX QUESTION BUTTONS YES-NO UPDATE sino.
      IF sino
      THEN DO:   
         aux_ROWID = ROWID(Partida-deposito).
         DO TRANSACTION:
            FIND Partida-deposito WHERE aux_ROWID = ROWID(Partida-deposito) EXCLUSIVE-LOCK.
            DELETE Partida-deposito.
         END.   
         RUN ABRE_QUERY.    
         RUN TOCARSND.P ( INPUT "SOUND\ELIMINAR.WAV").            
      END.   
   END.
   
END PROCEDURE.

PROCEDURE CORREGIR_DETALLE:

   IF NOT AVAILABLE Partida-deposito
   THEN DO:
        RUN PONMENSJ.P ( INPUT "REQU013" ).
        RETURN.
   END.

   act_partidepo = ROWID(Partida-deposito).

   RUN {1} ( INPUT 1 ).
   RUN PONER_SESION.
   IF ult_partidepo <> ?
   THEN DO:
        RUN ABRE_QUERY.
   END.

END PROCEDURE.

{DUMYSESN.I}
