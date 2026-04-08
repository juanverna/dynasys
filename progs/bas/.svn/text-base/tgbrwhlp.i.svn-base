ON ".", MOUSE-SELECT-DBLCLICK OF {&ENTIDAD}.{&CODIGO-ENT}  IN BROWSE {&BROWSE-INGRESO}
DO:

  aux_ROWID = {&ROWID-TABLA}.
  RUN {&RUTINA}.P (OUTPUT {&ROWID-TABLA}, INPUT {&ALT-MOD}).
  IF {&ROWID-TABLA} <> ?
  THEN DO:
     FIND {&TABLA} WHERE ROWID({&TABLA}) = {&ROWID-TABLA} NO-LOCK.
     {&ENTIDAD}.{&CODIGO-ENT}:SCREEN-VALUE IN BROWSE {&BROWSE-INGRESO} = {&TABLA}.{&CODIGO-TAB}.
     APPLY "LEAVE" TO {&ENTIDAD}.{&CODIGO-ENT} IN BROWSE {&BROWSE-INGRESO}.
  END.  
  ELSE DO:
     {&ROWID-TABLA} = aux_ROWID.
  END.     
  RETURN NO-APPLY.
END.   

/*------------------ ANULAMOS POR AHORA --------------------------------------------

&IF {&TRADUCIR} &THEN

ON ENTRY OF {&TABLA}.{&CODIGO}  IN BROWSE {&BROWSE-INGRESO}
DO:
  ant_ROWID = ROWID({&TABLA}). 
END.  

ON RETURN, TAB OF {&TABLA}.{&CODIGO}  IN BROWSE {&BROWSE-INGRESO}
DO:
    
   &IF DEFINED(SEL_EXCLUSIVO)
   &THEN
   FIND {&TABLA} USING {&CODIGO} EXCLUSIVE-LOCK NO-WAIT NO-ERROR.
   &ELSE
   FIND {&TABLA} USING {&CODIGO} NO-LOCK NO-ERROR.
   &ENDIF
           
   IF NOT AVAILABLE {&TABLA}
   THEN DO:
      RUN TOCARSND.P ( INPUT "SOUND\ERROR" ).
      IF LOCKED {&TABLA}
         THEN MESSAGE "El registro indicado se halla en uso exclusivo por otro usuario"
                      VIEW-AS ALERT-BOX ERROR BUTTONS OK.      
         ELSE MESSAGE "El codigo indicado no existe en la tabla maestra"
                      VIEW-AS ALERT-BOX ERROR BUTTONS OK.
         RETURN NO-APPLY.
   END.
   ELSE DO:
      {&ROWID-TABLA} = ROWID({&TABLA}).
&IF {&MOSTRAR} &THEN   
      DISPLAY {&TABLA}.{&NOMBRE} WITH BROWSE {&BROWSE-INGRESO}.
&ENDIF
    END.
    
&IF DEFINED(PROCESO) &THEN
   IF ant_ROWID <> ROWID({&TABLA}) 
   THEN DO:
      RUN {&PROCESO}.
      IF hay_error 
      THEN DO:
         ant_ROWID = ?.
         RETURN NO-APPLY.
      END.   
   END.   
&ENDIF   

   {&ROWID-TABLA} = ROWID({&TABLA}).

END.

&ENDIF
---------------------------- HASTA AQUI ANULAMOS ------------------------------------*/

ON F7,F8 OF {&ENTIDAD}.{&CODIGO-ENT}  IN BROWSE {&BROWSE-INGRESO}
DO:

  IF KEY-LABEL(LAST-KEY) = "F8"
  THEN DO:
     IF NOT AVAILABLE {&TABLA}
     THEN DO:
        RUN PONMENSJ.P (INPUT "HELP001").
        RETURN NO-APPLY.
     END.   
     modo_mant = 2.
  END.   
  ELSE DO:
     modo_mant = 1.
  END.
  
  &IF SUBSTRING("{&ALTA-MODIF}",1,5) <> "ACBRW" 
  &THEN 
  HIDE BROWSE {&BROWSE-INGRESO}.
  &ENDIF
  &IF {&HAY-MENU} 
  &THEN
  MENU Principal:SENSITIVE = NO.
  &ENDIF
  {&ULT_REGISTRO} = ( IF KEY-LABEL(LAST-KEY) = "F8" THEN ROWID({&TABLA}) ELSE ?).
  RUN {&ALTA-MODIF}.P (INPUT modo_mant).
  RUN PONER_SESION.
  VIEW BROWSE {&BROWSE-INGRESO}.
  IF {&ULT_REGISTRO} <> ?
  THEN DO:
     ant_ROWID = ?.
     FIND {&TABLA} WHERE ROWID({&TABLA}) = {&ULT_REGISTRO} NO-LOCK.
     DISPLAY {&TABLA}.{&CODIGO-TAB} @ {&ENTIDAD}.{&CODIGO-ENT} 
             WITH BROWSE {&BROWSE-INGRESO}.
     APPLY "RETURN" TO {&ENTIDAD}.{&CODIGO-ENT} IN BROWSE {&BROWSE-INGRESO}.
  END.
  ELSE DO:
     APPLY "ENTRY" TO {&ENTIDAD}.{&CODIGO-ENT} IN BROWSE {&BROWSE-INGRESO}.
  END.   
  RETURN NO-APPLY.   
END.  

