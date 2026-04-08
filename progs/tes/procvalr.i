/*=================================================================================*/
/*                           VARIABLES, FRAMES, Y SUBMENUES                        */
/*=================================================================================*/

{VRSHARED.I }

DEFINE VARIABLE que_empresa    LIKE Empresa.nombre.
DEFINE VARIABLE que_fecha      AS DATE INITIAL TODAY LABEL "Fecha".
DEFINE VARIABLE que_caja       AS INTEGER.
DEFINE VARIABLE suma_habil     AS INTEGER.
DEFINE VARIABLE diasem         AS INTEGER.
DEFINE VARIABLE tot_valores    AS INTEGER LABEL "Valors".
DEFINE VARIABLE tot_importe    LIKE Valor.importe LABEL "Importes".
DEFINE BUFFER B-Valor  FOR Valor.
DEFINE QUERY qry_valor FOR Valor, Banco, Cliente.

/*=================================================================================*/
/*                   B O T O N E S    Y   B R O W S E S                            */
/*=================================================================================*/


DEFINE BUTTON btn_PROCESAR
     LABEL "&Procesar":L 
     SIZE 10 BY 1 FONT 4.
     
DEFINE BUTTON btn_CANCEL
     LABEL "&Cancelar":L 
     SIZE 10 BY 1 FONT 4.
     
DEFINE BUTTON btn_TODOS
     LABEL "&Todos":L 
     SIZE 10 BY 1 FONT 4.

DEFINE BUTTON btn_COMPROBTE
     LABEL "C&heque":L 
     SIZE 10 BY 1 FONT 4.
     
DEFINE BUTTON btn_LISTADOS
     LABEL "&Listado":L 
     SIZE 10 BY 1 FONT 4.
          
DEFINE BUTTON btn_EXIT
     LABEL "&Salir":L 
     SIZE 10 BY 1 FONT 4.

DEFINE BUTTON btn_PROXIMO
     LABEL "->":L IMAGE FILE "BTN-RIGHT-ARROW"
     SIZE 4 BY 1 FONT 4.

DEFINE BUTTON btn_ANTERIOR
     LABEL "<-":L IMAGE FILE "BTN-LEFT-ARROW"
     SIZE 4 BY 1 FONT 4.

DEFINE BROWSE brw_valor QUERY qry_valor
       DISPLAY   
           Banco.abrevia COLUMN-LABEL "Banco"
           Valor.numero_cheque
           Valor.selectado
           Valor.importe
           Cliente.cdg_cliente
           (IF Cliente.cdg_cliente <> "" THEN Cliente.nom_cliente ELSE " " ) LABEL "Cliente" FORMAT "X(35)"
           WITH 16 DOWN FONT 4 NO-UNDERLINE SEPARATORS FGCOLOR b-fg_c BGCOLOR b-bg_c
                TITLE "Valores correspondientes a la fecha".     

/*-------------------------------------------------------------------------
                            F R A M E S 
--------------------------------------------------------------------------*/

FORM
  SKIP(0.2)
  Cuenta_bancaria.cdg_cuenta_ban LABEL "Cuenta"  COLON 10     FGCOLOR fe_c BGCOLOR be_c
  Cuenta_bancaria.denominacion_cta                 NO-LABEL FGCOLOR fg_c BGCOLOR bg_c
  btn_ANTERIOR SPACE(0)
  que_fecha                     NO-LABEL    FGCOLOR fe_c BGCOLOR be_c
  SPACE(0) btn_PROXIMO  
  SKIP(0.2)
  btn_PROCESAR AT 3 
  btn_CANCEL btn_TODOS btn_COMPROBTE 
  btn_LISTADOS btn_EXIT SKIP(0.1)
  brw_valor AT 3
  WITH CENTERED AT ROW 1 COL 1 FRAME frm-valores FONT 4
       TITLE nom_funcion THREE-D KEEP-TAB-ORDER
       SIDE-LABELS  FGCOLOR f-fg_c BGCOLOR f-bg_c WIDTH 110.

DEFINE FRAME frm-titulo HEADER
  que_empresa
  "{&TITULO_LIST}" que_fecha
  "Pagina:" AT 70 PAGE-NUMBER FORMAT ">9" AT 77 SKIP(2)
  WITH WIDTH 96 FRAME frm-titulo TOP-ONLY PAGE-TOP STREAM-IO.
  
DEFINE FRAME frm-listado
           B-Valor.cdg_banco
           Banco.abrevia
           B-Valor.numero_cheque
           B-Valor.estado
           B-Valor.importe
           Cliente.cdg_cliente
           Cliente.nom_cliente
  WITH WIDTH 96 DOWN CENTERED FRAME frm-listado USE-TEXT STREAM-IO.

FORM
      SKIP(1)
      tot_valores tot_importe 
  WITH CENTERED FRAME frm-total USE-TEXT STREAM-IO SIDE-LABELS
       TITLE "{&RESUMEN_LIST}".


/*=================================================================================*/
/*                              S U B M E N U E S                                  */
/*=================================================================================*/

DEFINE MENU  Principal MENUBAR
   MENU-ITEM Salir                  LABEL "Sa&lir".

/*=================================================================================*/
/*                      T R I G G E R S    D E    U S U A R I O                    */
/*=================================================================================*/

ON CHOOSE OF btn_PROXIMO OR "+" OF que_fecha IN FRAME frm-valores
DO:

   que_fecha = que_fecha + 1.
   DISPLAY que_fecha WITH FRAME frm-valores.
   RUN PONER_CHEQUES.
   RETURN NO-APPLY.
      
END.

ON CHOOSE OF btn_ANTERIOR OR "-" OF que_fecha IN FRAME frm-valores
DO:

   que_fecha = que_fecha - 1.
   DISPLAY que_fecha WITH FRAME frm-valores.
   RUN PONER_CHEQUES.
   RETURN NO-APPLY.
      
END.

/*                Verifica la fecha, y habilita el browser                  */

ON RETURN, TAB OF que_fecha IN FRAME frm-valores
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


ON CHOOSE OF btn_PROCESAR IN FRAME frm-valores
DO:

   IF NOT AVAILABLE Valor 
   THEN DO:
      BELL.
      MESSAGE "No hay Valors que puedan procesarse"
        VIEW-AS ALERT-BOX ERROR BUTTONS OK.
      RETURN NO-APPLY.
   END.

   sino_cancel = NO.
   sino_salir = NO. 
   APPLY "U1" TO FRAME frm-valores.
   
END.

ON CHOOSE OF btn_CANCEL IN FRAME frm-valores
DO:
   MESSAGE "Realmente desea cancelar el proceso en curso?" 
           VIEW-AS ALERT-BOX QUESTION BUTTONS YES-NO
           TITLE "Se pide confirmacion" SET sino_cancel.
   IF sino_cancel 
      THEN APPLY "U1" TO FRAME frm-valores.

   RETURN NO-APPLY.   
   
END.

ON CHOOSE OF btn_EXIT IN FRAME frm-valores
DO:
   MESSAGE "Realmente desea abandonar este proceso?" 
           VIEW-AS ALERT-BOX QUESTION BUTTONS YES-NO
           TITLE "Se pide confirmacion" SET sino_salir.
   IF sino_salir THEN APPLY "U1" TO FRAME frm-valores.
   RETURN NO-APPLY.         
END.

ON CHOOSE OF btn_LISTADOS IN FRAME frm-valores
DO:

   MESSAGE "Confirme con OK que desea emitir el listado"
   VIEW-AS ALERT-BOX ERROR BUTTONS OK-CANCEL TITLE "Se pçde confirmacion"
   SET sino AS LOGICAL.
   IF sino 
   THEN DO:

      OUTPUT TO {&SALIDA} PAGE-SIZE 72.
      tot_importe = 0.
      FOR EACH B-Valor
          WHERE B-Valor.fecha_acredita = que_fecha 
            AND B-Valor.estado = stchq_deposit, 
           EACH Banco OF B-Valor, EACH Cliente OF B-Valor. 
                                
         VIEW FRAME frm-titulo.
         DISPLAY B-Valor.cdg_banco
                 Banco.abrevia
                 B-Valor.numero_cheque
                 B-Valor.estado
                 B-Valor.importe
                 Cliente.cdg_cliente WHEN Cliente.cdg_cliente <> ""
                 Cliente.nom_cliente WHEN Cliente.cdg_cliente <> "" 
                 WITH FRAME frm-listado.

         DOWN WITH FRAME frm-listado.
         tot_importe = tot_importe + B-Valor.importe.
         tot_valores = tot_valores + 1.
      END.

      DISPLAY   tot_valores tot_importe WITH FRAME frm-total.
      UNDERLINE tot_valores tot_importe WITH FRAME frm-total.      
      OUTPUT CLOSE.
      RUN PRINFILE.P ( INPUT "{&SALIDA}", INPUT "LPT1" ).
      
   END.

END.

ON CHOOSE OF btn_TODOS IN FRAME frm-valores
DO:

   FOR EACH B-Valor
       WHERE B-Valor.fecha_acredita = que_fecha 
         AND Valor.estado = stchq_deposit EXCLUSIVE-LOCK:
                                
       B-Valor.selectado = NOT B-Valor.selectado.
         
   END.
   RUN ABRE_QUERY.

END.

ON RETURN, MOUSE-SELECT-DBLCLICK OF brw_valor IN FRAME frm-valores
DO:

   IF NOT AVAILABLE Valor 
   THEN DO:
      BELL.
      MESSAGE "No hay valores que puedan {&NOMBRE_PROC}"
        VIEW-AS ALERT-BOX ERROR BUTTONS OK.
      RETURN NO-APPLY.
   END.
   
   aux_ROWID = ROWID(Valor).
   FIND Valor WHERE ROWID(Valor) = aux_ROWID EXCLUSIVE-LOCK.
   Valor.selectado = NOT Valor.selectado.
   RELEASE Valor.
   FIND Valor WHERE ROWID(Valor) = aux_ROWID NO-LOCK.   
   DISPLAY Valor.selectado WITH BROWSE brw_valor.
   
END.   

ON CHOOSE OF btn_COMPROBTE IN FRAME frm-valores
DO:

   IF NOT AVAILABLE Valor 
   THEN DO:
      BELL.
      MESSAGE "No hay valores que puedan consultarse"
        VIEW-AS ALERT-BOX ERROR BUTTONS OK.
      RETURN NO-APPLY.
   END.

   ult_valor = ROWID(Valor).
   HIDE FRAME frm-valores NO-PAUSE.
   RUN ACTVALOR.P (INPUT 2).
   RUN PONER_SESION.
   VIEW FRAME frm-valores.
   RUN ABRE_QUERY.

END.

        /* -------------------- Cuenta Bancaria -----------------------*/

&SCOPED-DEFINE TABLA            Cuenta_bancaria
&SCOPED-DEFINE CODIGO           cdg_cuenta_ban
&SCOPED-DEFINE NOMBRE           denominacion_cta
&SCOPED-DEFINE RUTINA           SELCTBCO
&SCOPED-DEFINE FRAME-INGRESO    frm-valores
&SCOPED-DEFINE ROWID-TABLA      act_cuenta_ban
&SCOPED-DEFINE TRADUCIR         YES
&SCOPED-DEFINE MOSTRAR          YES
&SCOPED-DEFINE ALTA-MODIF       ACTCTBCO
&SCOPED-DEFINE ULT_REGISTRO     ult_cuenta_ban
&SCOPED-DEFINE ALT-MOD          YES
&SCOPED-DEFINE PROCESO          PONER_CUENTA

{TRIGSELC.I} 


/*=================================================================================*/
/*   C O M I E N Z O   D E   L A   T R A N S A C C I O N   D E   I N G R E S O     */
/*=================================================================================*/

nom_funcion = "{&NOMBRE_FUNC}".
FIND Empresa WHERE ROWID(Empresa) = act_empresa NO-LOCK.
titulo_w = Empresa.nombre + "   " + nom_menu + " -- " + nom_funcion.
que_empresa = Empresa.nombre.
act_valor = ?.

DO TRANSACTION:
Actualizacion:
REPEAT: /* aqui comienza el ciclo de alta de las Movimientos */

  sino_salir = NO.
  sino_cancel = NO.

  CLEAR FRAME frm-valores ALL.
  HIDE brw_valor.  
  DISPLAY que_fecha WITH FRAME frm-valores.
  DISABLE ALL WITH FRAME frm-valores.
  
  ENABLE  Cuenta_bancaria.cdg_cuenta_ban
          btn_EXIT 
          WITH FRAME frm-valores.

  WAIT-FOR U1 OF FRAME frm-valores FOCUS que_fecha.

  IF sino_salir  THEN LEAVE Actualizacion.
  IF sino_cancel THEN UNDO  Actualizacion, RETRY Actualizacion.

  RUN PROCESAR_CHEQUES.
                    
END.
END. /* TRANSACTION */

act_valor = ?.
HIDE FRAME frm-valores NO-PAUSE.

/*=================================================================================*/
/*                              PROCEDIMIENTOS                                     */
/*=================================================================================*/

PROCEDURE PONER_SESION.

END PROCEDURE.

PROCEDURE PONER_CHEQUES:

     RUN ABRE_QUERY.

     ENABLE  brw_valor
             btn_PROCESAR 
             btn_CANCEL 
             btn_TODOS
             btn_COMPROBTE
             btn_LISTADOS
             btn_EXIT
             WITH FRAME frm-valores.
             
END PROCEDURE.             

PROCEDURE PONER_CUENTA:

    ENABLE que_fecha 
           btn_ANTERIOR
           btn_PROXIMO
           WITH FRAME frm-valores.
           
    RUN ABRE_QUERY.       

END PROCEDURE.

PROCEDURE ABRE_QUERY:

     OPEN QUERY qry_valor       
          FOR EACH Valor OF Cuenta_bancaria
             WHERE Valor.fecha_acredita = que_fecha 
               AND Valor.estado = stchq_deposit NO-LOCK, 
              EACH Banco OF Valor NO-LOCK, EACH Cliente OF Valor NO-LOCK. 

END PROCEDURE.

PROCEDURE PROCESAR_CHEQUES:

   FOR EACH B-Valor EXCLUSIVE-LOCK
       WHERE B-Valor.fecha_acredita = que_fecha 
         AND B-Valor.estado = stchq_deposit
         AND B-Valor.selectado:
                                
       ASSIGN
            B-Valor.estado              = {&VALOR_STATUS}
            B-Valor.selectado           = NO.

       RUN FECVALOR.P ( INPUT ROWID(B-Valor) ).

       &IF DEFINED(PROCESO_ESTADO) <> 0
       &THEN 
       {&PROCESO_ESTADO}
       &ENDIF
      
   END.  

   BELL.
   MESSAGE  "Los valores han sido marcados como {&NOMBRE_STATUS}"
            VIEW-AS ALERT-BOX MESSAGE TITLE "Mensaje del sistema".
            
END PROCEDURE.            

