ON CHOOSE OF btn_PROXIMO OR "+" OF que_fecha IN FRAME frm-cheques
DO:

   que_fecha = que_fecha + 1.
   DISPLAY que_fecha WITH FRAME frm-cheques.
   RUN PONER_CHEQUES.
   RETURN NO-APPLY.
      
END.

ON CHOOSE OF btn_ANTERIOR OR "-" OF que_fecha IN FRAME frm-cheques
DO:

   que_fecha = que_fecha - 1.
   DISPLAY que_fecha WITH FRAME frm-cheques.
   RUN PONER_CHEQUES.
   RETURN NO-APPLY.
      
END.

/*                Verifica la fecha, y habilita el browser                  */

ON RETURN, TAB OF que_fecha IN FRAME frm-cheques
DO:

     IF INPUT que_fecha = ?
     THEN DO:
        BELL.
        MESSAGE "No puede indicarse esta fecha en blanco"
           VIEW-AS ALERT-BOX ERROR BUTTONS OK.
        RETURN NO-APPLY.
     END. 

     ASSIGN que_fecha.
     RUN PONER_CHEQUES.

END.


ON CHOOSE OF btn_DEPOSITAR IN FRAME frm-cheques
DO:

   IF NOT AVAILABLE Cheque 
   THEN DO:
      BELL.
      MESSAGE "No hay Cheques que puedan procesarse"
        VIEW-AS ALERT-BOX ERROR BUTTONS OK.
      RETURN NO-APPLY.
   END.

   sino_cancel = NO.
   sino_salir = NO. 
   APPLY "U1" TO FRAME frm-cheques.
   
END.

ON CHOOSE OF btn_CANCEL IN FRAME frm-cheques
DO:
   MESSAGE "Realmente desea cancelar el proceso en curso?" 
           VIEW-AS ALERT-BOX QUESTION BUTTONS YES-NO
           TITLE "Se pide confirmacion" SET sino_cancel.
   IF sino_cancel 
      THEN APPLY "U1" TO FRAME frm-cheques.

   RETURN NO-APPLY.   
   
END.

ON CHOOSE OF btn_EXIT IN FRAME frm-cheques
DO:
   MESSAGE "Realmente desea abandonar este proceso?" 
           VIEW-AS ALERT-BOX QUESTION BUTTONS YES-NO
           TITLE "Se pide confirmacion" SET sino_salir.
   IF sino_salir THEN APPLY "U1" TO FRAME frm-cheques.
   RETURN NO-APPLY.         
END.

ON CHOOSE OF btn_LISTADOS IN FRAME frm-cheques
DO:

   MESSAGE "Confirme con OK que desea emitir el listado"
   VIEW-AS ALERT-BOX ERROR BUTTONS OK-CANCEL TITLE "Se pçde confirmacion"
   SET sino AS LOGICAL.
   IF sino 
   THEN DO:

      OUTPUT TO "{1}".
      tot_importe = 0.
      FOR EACH B-Cheque
          WHERE B-Cheque.fecha_acredita = que_fecha 
            AND B-Cheque.estado = stchq_deposit, 
           EACH Banco OF B-Cheque, EACH Cliente OF B-Cheque. 
                                
         VIEW FRAME frm-titulo.
         DISPLAY B-Cheque.cdg_banco
                 Banco.abrevia
                 B-Cheque.nro_cheque
                 B-Cheque.estado
                 B-Cheque.importe
                 Cliente.cdg_cliente WHEN Cliente.cdg_cliente <> 0
                 Cliente.nom_cliente WHEN Cliente.cdg_cliente <> 0
                 WITH FRAME frm-listado.

         DOWN WITH FRAME frm-listado.
         tot_importe = tot_importe + B-Cheque.importe.
         tot_cheques = tot_cheques + 1.
      END.

      DISPLAY   tot_cheques tot_importe WITH FRAME frm-total.
      UNDERLINE tot_cheques tot_importe WITH FRAME frm-total.      
      OUTPUT CLOSE.
      RUN PRINFILE.P ( INPUT "{1}", INPUT "LPT1" ).
      
   END.

END.

ON CHOOSE OF btn_TODOS IN FRAME frm-cheques
DO:

   FOR EACH B-Cheque
       WHERE B-Cheque.fecha_acredita = que_fecha 
         AND Cheque.estado = stchq_deposit EXCLUSIVE-LOCK:
                                
       B-Cheque.selectado = NOT B-Cheque.selectado.
         
   END.
   RUN ABRE_QUERY.

END.

ON RETURN, MOUSE-SELECT-DBLCLICK OF brw_cheque IN FRAME frm-cheques
DO:

   IF NOT AVAILABLE Cheque 
   THEN DO:
      BELL.
      MESSAGE "No hay cheques que puedan {2}"
        VIEW-AS ALERT-BOX ERROR BUTTONS OK.
      RETURN NO-APPLY.
   END.
   
   aux_ROWID = ROWID(Cheque).
   FIND Cheque WHERE ROWID(Cheque) = aux_ROWID EXCLUSIVE-LOCK.
   Cheque.selectado = NOT Cheque.selectado.
   RELEASE Cheque.
   FIND Cheque WHERE ROWID(Cheque) = aux_ROWID NO-LOCK.   
   DISPLAY Cheque.selectado WITH BROWSE brw_cheque.
   
END.   

ON CHOOSE OF btn_COMPROBTE IN FRAME frm-cheques
DO:

   IF NOT AVAILABLE Cheque 
   THEN DO:
      BELL.
      MESSAGE "No hay cheques que puedan consultarse"
        VIEW-AS ALERT-BOX ERROR BUTTONS OK.
      RETURN NO-APPLY.
   END.

   ult_cheque = ROWID(Cheque).
   HIDE FRAME frm-cheques NO-PAUSE.
   RUN ACTCHEQU.P (INPUT 2).
   RUN PONER_SESION.
   VIEW FRAME frm-cheques.
   RUN ABRE_QUERY.

END.
