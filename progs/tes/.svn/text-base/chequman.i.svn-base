
/*=================================================================================*/
/*                                                                                 */
/*                      C O M I E N Z O   D E   S E C C I O N                      */
/*                                                                                 */
/*               DEFINICIONES LOCALES:VARIABLES, FRAMES, Y SUBMENUES               */
/*                                                                                 */
/*=================================================================================*/
/*                                                                                 */
&IF {&SECCION} = "DEFINICIONES"
&THEN
/*                                                                                 */
/*---------------------------------------------------------------------------------*/

&ENDIF

/*=================================================================================*/
/*                           F I N   D E   S E C C I O N                           */
/*=================================================================================*/

/*=================================================================================*/
/*                                                                                 */
/*                      C O M I E N Z O   D E   S E C C I O N                      */
/*                                                                                 */
/*                           FRAME PRINCIPAL DEL DOCUMENTO                         */
/*                                                                                 */
/*=================================================================================*/
/*                                                                                 */
&IF {&SECCION} = "FRAME_PPAL"
&THEN
/*                                                                                 */
/*---------------------------------------------------------------------------------*/

    SKIP(0.3)    
    Cheque.numero_cheque                  COLON 20 FGCOLOR fe_c BGCOLOR be_c 
    Banco.nombre                     LABEL "Banco" FGCOLOR fg_c BGCOLOR bg_c 
    SKIP(0.3)
    Cheque.cdg_cuenta_ban                 COLON 20 FGCOLOR fe_c BGCOLOR be_c LABEL "Cuenta"
    Cuenta_bancaria.denominacion_cta      NO-LABEL FGCOLOR fg_c BGCOLOR bg_c
    Cuenta_bancaria.numero_cuenta         NO-LABEL FGCOLOR fg_c BGCOLOR bg_c
    SKIP(0.1)
    Cheque.fecha_salida                   COLON 20 FGCOLOR fe_c BGCOLOR be_c
    SKIP(0.1)
    Cheque.fecha_emision                  COLON 20 FGCOLOR fe_c BGCOLOR be_c 
    SKIP(0.1)
    Cheque.fecha_deposito                 COLON 20 FGCOLOR fe_c BGCOLOR be_c 
    SKIP(0.1)
    Cheque.dias_clearing                  COLON 20 FGCOLOR fe_c BGCOLOR be_c 
    SKIP(0.1)
    Cheque.fecha_acredita                 COLON 20 FGCOLOR fg_c BGCOLOR bg_c
    SKIP(0.1)
    Cheque.importe                        COLON 20 FGCOLOR fe_c BGCOLOR be_c
    SKIP(0.1)
    Cheque.estado                         COLON 20 FGCOLOR fg_c BGCOLOR bg_c
    SKIP(0.1)
    Proveedor.cdg_proveedor               COLON 20 FGCOLOR fe_c BGCOLOR be_c
    Proveedor.nombre                      NO-LABEL FGCOLOR fg_c BGCOLOR bg_c
    SKIP(0.5)

&ENDIF

/*=================================================================================*/
/*                           F I N   D E   S E C C I O N                           */
/*=================================================================================*/

/*=================================================================================*/
/*                                                                                 */
/*                      C O M I E N Z O   D E   S E C C I O N                      */
/*                                                                                 */
/*                                      MENUES                                     */
/*                                                                                 */
/*=================================================================================*/
/*                                                                                 */
&IF {&SECCION} = "MENUES"
&THEN
/*                                                                                 */
/*---------------------------------------------------------------------------------*/
          
/* ------------------------------------------------------------------------
                              S U B M E N U E S 
   ------------------------------------------------------------------------  */

DEFINE SUB-MENU Archivo
   MENU-ITEM Salir                  LABEL "&Salir".

DEFINE MENU  Principal MENUBAR
   SUB-MENU  Archivo                LABEL "&Archivo".

&ENDIF

/*=================================================================================*/
/*                           F I N   D E   S E C C I O N                           */
/*=================================================================================*/

/*=================================================================================*/
/*                                                                                 */
/*                      C O M I E N Z O   D E   S E C C I O N                      */
/*                                                                                 */
/*                          TRIGGERS PARTICULARES DEL CASO                         */
/*                                                                                 */
/*=================================================================================*/
/*                                                                                 */
&IF {&SECCION} = "TRIGGERS"
&THEN
/*                                                                                 */
/*---------------------------------------------------------------------------------*/

ON RETURN,TAB OF Cheque.fecha_emision IN FRAME frm-entidad
DO:

   ASSIGN Cheque.fecha_emision Cheque.dias_clearing.

   IF TODAY - Cheque.fecha_emision > 30 
   THEN DO:
      RUN PONMENSJ.P ( INPUT "CHEQ004" ).
      RETURN NO-APPLY.
   END.

   IF WEEKDAY(Cheque.fecha_emision) = 1 OR
      WEEKDAY(Cheque.fecha_emision) = 7
   THEN DO:
      RUN PONMENSJ.P ( INPUT "CHEQ002").
   END.

   IF CAN-FIND(First Feriado WHERE Feriado.fecha = Cheque.fecha_emision)
   THEN DO:
      RUN PONMENSJ.P ( INPUT "CHEQ003").
   END.

   ASSIGN   Cheque.fecha_deposito  = Cheque.fecha_emision.      
   RUN PONER_FECHAS.
              
END.   

ON RETURN,TAB OF Cheque.fecha_deposito IN FRAME frm-entidad
DO:

   ASSIGN Cheque.fecha_deposito Cheque.dias_clearing.

   IF Cheque.fecha_deposito - Cheque.fecha_emision > 30 
   THEN DO:
      RUN PONMENSJ.P ( INPUT "CHEQ004" ).
      RETURN NO-APPLY.
   END.

   IF WEEKDAY(Cheque.fecha_deposito) = 1 OR
      WEEKDAY(Cheque.fecha_deposito) = 7
   THEN DO:
      RUN PONMENSJ.P ( INPUT "CHEQ002").
   END.

   IF CAN-FIND(First Feriado WHERE Feriado.fecha = Cheque.fecha_deposito)
   THEN DO:
      RUN PONMENSJ.P ( INPUT "CHEQ003").
      RETURN NO-APPLY.
   END.

   RUN PONER_FECHAS.

END.  

ON RETURN,TAB OF Cheque.dias_clearing IN FRAME frm-entidad
DO:

   ASSIGN Cheque.dias_clearing.
   RUN PONER_FECHAS.

END.  

/*============================= H E L P S =======================================*/

&SCOPED-DEFINE ENTIDAD          Cheque

        /* -------------------- Cuenta Bancaria ------------*/

&SCOPED-DEFINE TABLA            Cuenta_Bancaria
&SCOPED-DEFINE CODIGO-TAB       cdg_cuenta_ban
&SCOPED-DEFINE CODIGO-ENT       cdg_cuenta_ban
&SCOPED-DEFINE NOMBRE           denominacion_cta
&SCOPED-DEFINE RUTINA           SELCTBCO
&SCOPED-DEFINE FRAME-INGRESO    frm-entidad
&SCOPED-DEFINE ROWID-TABLA      act_cuenta_ban
&SCOPED-DEFINE TRADUCIR         YES
&SCOPED-DEFINE MOSTRAR          NO
&SCOPED-DEFINE PROCESO          PONER_CUENTA
&SCOPED-DEFINE ALTA-MODIF       ACTCTBCO
&SCOPED-DEFINE ULT_REGISTRO     ult_cuenta_ban
&SCOPED-DEFINE ALT-MOD          YES

{TRIGHELP.I} 

/*=================== F I N   D E   L O S   H E L P S ======================*/

&ENDIF

/*=================================================================================*/
/*                           F I N   D E   S E C C I O N                           */
/*=================================================================================*/

/*=================================================================================*/
/*                                                                                 */
/*                      C O M I E N Z O   D E   S E C C I O N                      */
/*                                                                                 */
/*                      PROCESO DE INICIALIZACION DEL PROGRAMA                     */
/*                                                                                 */
/*=================================================================================*/
/*                                                                                 */
&IF {&SECCION} = "INICIAR"
&THEN
/*                                                                                 */
/*---------------------------------------------------------------------------------*/



&ENDIF

/*=================================================================================*/
/*                           F I N   D E   S E C C I O N                           */
/*=================================================================================*/

/*=================================================================================*/
/*                                                                                 */
/*                      C O M I E N Z O   D E   S E C C I O N                      */
/*                                                                                 */
/*                      PROCESO A EJECUTAR DESPUES DE VALIDAR                      */
/*                                                                                 */
/*=================================================================================*/
/*                                                                                 */
&IF {&SECCION} = "VALIDACION"
&THEN
/*                                                                                 */
/*---------------------------------------------------------------------------------*/

     IF ROWID(Cheque) = ?
     THEN DO:
        RUN PONMENSJ.P (INPUT "CHEQ000").
        RETURN.
     END.

     IF CAN-FIND(FIRST Cheque 
                       WHERE Cheque.numero_cheque  = INPUT FRAME frm-entidad Cheque.numero_cheque
                         AND Cheque.cdg_cuenta_ban = INPUT FRAME frm-entidad Cheque.cdg_cuenta_ban
                         AND ROWID(Cheque) <> act_cheque )
     THEN DO:
        RUN PONMENSJ.P (INPUT "CHEQ002").
        RETURN.
     END.            
     
{IFNOTAVA.I "Banco" "cdg_banco" "frm-entidad" "Cheque" "CHEQ003" }

&ENDIF

/*=================================================================================*/
/*                           F I N   D E   S E C C I O N                           */
/*=================================================================================*/
/*=================================================================================*/
/*                                                                                 */
/*                      C O M I E N Z O   D E   S E C C I O N                      */
/*                                                                                 */
/*                      PROCEDIMIENTOS PARTICULARES DEL CASO                       */
/*                                                                                 */
/*=================================================================================*/
/*                                                                                 */
&IF {&SECCION} = "PROCEDIMIENTOS"
&THEN
/*                                                                                 */
/*---------------------------------------------------------------------------------*/

PROCEDURE PONER_CUENTA:

   FIND Banco OF Cuenta_bancaria NO-LOCK.
   DISPLAY Cuenta_bancaria.denominacion_cta
           Cuenta_bancaria.numero_cuenta
           Banco.nombre
           WITH FRAME frm-entidad.
          
END PROCEDURE.
          
PROCEDURE PONER_FECHAS:

   act_cheque = ROWID(Cheque).
   RUN FECHEQUE.P ( INPUT ROWID(Cheque) ).
   FIND Cheque WHERE ROWID(Cheque) = act_cheque.
   DISPLAY Cheque.fecha_deposito 
           Cheque.fecha_emision 
           Cheque.fecha_acredita
           WITH FRAME frm-entidad.

END PROCEDURE.

&ENDIF

/*=================================================================================*/
/*                           F I N   D E   S E C C I O N                           */
/*=================================================================================*/
