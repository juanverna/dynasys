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

DEFINE VARIABLE que_rutina          AS CHARACTER.
DEFINE VARIABLE ncopias             AS INTEGER.
DEFINE VARIABLE j                   AS INTEGER.

DEFINE BUFFER B-Rcb_detalle FOR Rcb_detalle.

DEFINE VARIABLE ant_Liquidacion   AS ROWID.
DEFINE VARIABLE v-tip_comprob LIKE Rcb_header.tip_comprob.

DEFINE VARIABLE importe_anterior  LIKE Caj_detalle.importe.

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

     SKIP(0.1)
     Rcb_header.sec_liquidacion LABEL "&Liq." FGCOLOR fe_c BGCOLOR be_c COLON 12
     Liquidacion.descripcion FORMAT "X(35)" NO-LABEL FGCOLOR fg_c BGCOLOR bg_c 
     ver  NO-LABEL FGCOLOR fg_c
     SKIP(0.1)
     Rcb_header.tip_comprob LABEL "&Recibo" FGCOLOR fe_c BGCOLOR be_c  COLON 12
     Rcb_header.nro_comprob NO-LABEL FGCOLOR fe_c BGCOLOR be_c 
     Rcb_header.fecha LABEL "Fec&ha" FGCOLOR fe_c BGCOLOR be_c 
     Rcb_header.estado  FGCOLOR fg_c LABEL "Emitida"
        VIEW-AS RADIO-SET HORIZONTAL RADIO-BUTTONS "Si", "E", "No", ""
     Rcb_header.anulado FGCOLOR fg_c BGCOLOR bg_c
     SKIP(0.1)
     Empleado.nro_legajo LABEL "&Empleado" FGCOLOR fe_c BGCOLOR be_c COLON 12
     Empleado.nombre NO-LABEL FGCOLOR fg_c BGCOLOR bg_c 
     SKIP(0.1)
     Rcb_header.basico        FGCOLOR fe_c BGCOLOR be_c  COLON 12
     Rcb_header.remunerativo  FGCOLOR fe_c BGCOLOR be_c 
     Rcb_header.a_pagar       FGCOLOR fe_c BGCOLOR be_c 
     SKIP(0.1)

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

DEFINE MENU  Principal MENUBAR
   MENU-ITEM Salir                  LABEL "&Salir".

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
/*-----------
ON ".", MOUSE-SELECT-DBLCLICK OF Cta_cte_prv.tip_comprob IN FRAME frm-documento,
                               Cta_cte_prv.nro_comprob IN FRAME frm-documento,
                               Cta_cte_prv.nro_vencimiento IN FRAME frm-documento
DO:
  RUN SELCCPRV.P.
  FOR EACH B-Cta_cte_prv OF Liquidacion WHERE B-Cta_cte_prv.selectado:
     DISPLAY B-Cta_cte_prv.tip_comprob @ Cta_cte_prv.tip_comprob
             B-Cta_cte_prv.nro_comprob @ Cta_cte_prv.nro_comprob
             B-Cta_cte_prv.nro_vencimiento @ Cta_cte_prv.nro_vencimiento WITH FRAME frm-documento.

     APPLY "RETURN" TO Cta_cte_prv.nro_vencimiento IN FRAME frm-documento.

     B-Cta_cte_prv.selectado = NO.
  END.
  RETURN NO-APPLY.
END.   

ON RETURN, TAB OF Cta_cte_prv.nro_vencimiento  IN FRAME frm-documento
DO:

   FIND Cta_cte_prv WHERE Cta_cte_prv.nro_Liquidacion = Liquidacion.nro_Liquidacion 
                    USING Cta_cte_prv.tip_comprob 
                      AND Cta_cte_prv.nro_comprob 
                      AND Cta_cte_prv.nro_vencimiento 
                          EXCLUSIVE-LOCK NO-ERROR.

   IF NOT AVAILABLE Cta_cte_prv
   THEN DO:
      RUN PONMENSJ.P (INPUT "OPAG001").
      RETURN NO-APPLY.
   END.

   IF Cta_cte_prv.nro_Liquidacion <> Liquidacion.nro_Liquidacion
   THEN DO:
      RUN PONMENSJ.P (INPUT "OPAG002").
      RETURN NO-APPLY.
   END.

   IF Cta_cte_prv.credito = Cta_cte_prv.debito
   THEN DO:
      RUN PONMENSJ.P (INPUT "OPAG003").
      RETURN NO-APPLY.
   END.

   IF CAN-FIND(FIRST Rcb_detalle OF Rcb_header
                     WHERE Rcb_detalle.tip_factura     = INPUT Cta_cte_prv.tip_comprob
                       AND Rcb_detalle.nro_factura     = INPUT Cta_cte_prv.nro_comprob
                       AND Rcb_detalle.nro_vencimiento = INPUT Cta_cte_prv.nro_vencimiento)
   THEN DO:
      RUN PONMENSJ.P (INPUT "OPAG004").
      RETURN NO-APPLY.
   END.
   
   IF Cta_cte_prv.imputado
   THEN DO:
      RUN PONMENSJ.P (INPUT "OPAG006").
      RETURN NO-APPLY.
   END.

   IF NOT Cta_cte_prv.liberada
   THEN DO:
      RUN PONMENSJ.P (INPUT "OPAG007").
      RETURN NO-APPLY.
   END.
   
   IF NOT Cta_cte_prv.programada
   THEN DO:
      RUN PONMENSJ.P (INPUT "OPAG008").
      RETURN NO-APPLY.
   END.
   
         
   act_ctacte = ROWID(Cta_cte_prv).
   Cta_cte_prv.imputado = YES.
   RUN CREAR_DETALLE.
   DISPLAY " " @ Cta_cte_prv.tip_comprob
           " " @ Cta_cte_prv.nro_comprob
           " " @ Cta_cte_prv.nro_vencimiento
           WITH FRAME frm-documento.
   APPLY "ENTRY" TO Cta_cte_prv.tip_comprob  IN FRAME frm-documento.
   RETURN NO-APPLY.
      
END.
--------------*/

&SCOPED-DEFINE ENTIDAD          Rcb_header

{HLPLIQUI.I "sec_liquidacion" "frm-documento" "YES" "YES" }

/*
        /* -------------------- Concepto del documento ------------------*/

&SCOPED-DEFINE TABLA            Concepto
&SCOPED-DEFINE CODIGO           cdg_concepto
&SCOPED-DEFINE NOMBRE           descripcion
&SCOPED-DEFINE RUTINA           SELCNDOC
&SCOPED-DEFINE FRAME-INGRESO    frm-documento
&SCOPED-DEFINE ROWID-TABLA      act_concepto
&SCOPED-DEFINE TRADUCIR         YES
&SCOPED-DEFINE MOSTRAR          YES
&SCOPED-DEFINE PROCESO          ASIGNAR_CONCEPTO
&SCOPED-DEFINE ALTA-MODIF       ACTCNDOC
&SCOPED-DEFINE ULT_REGISTRO     ult_concepto
&SCOPED-DEFINE ALT-MOD          YES

{TRIGSELC.I} 
*/

        /* -------------------- Empleado del documento ------------------*/

&SCOPED-DEFINE TABLA            Empleado
&SCOPED-DEFINE CODIGO           nro_legajo
&SCOPED-DEFINE NOMBRE           nombre
&SCOPED-DEFINE RUTINA           SELEMPLE
&SCOPED-DEFINE FRAME-INGRESO    frm-documento
&SCOPED-DEFINE ROWID-TABLA      act_Empleado
&SCOPED-DEFINE TRADUCIR         YES
&SCOPED-DEFINE MOSTRAR          YES
&SCOPED-DEFINE PROCESO          ASIGNAR_Empleado
&SCOPED-DEFINE ALTA-MODIF       ACTEMPLE
&SCOPED-DEFINE ULT_REGISTRO     ult_Empleado
&SCOPED-DEFINE ALT-MOD          YES

{TRIGSELC.I} 
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
/*                       PROCESO A EJECUTAR ANTES DE VALIDAR                       */
/*                                                                                 */
/*=================================================================================*/
/*                                                                                 */
&IF {&SECCION} = "ANT-VALIDAR"
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
&IF {&SECCION} = "DES-VALIDAR"
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
/*                      PROCEDIMIENTOS PARTICULARES DEL CASO                       */
/*                                                                                 */
/*=================================================================================*/
/*                                                                                 */
&IF {&SECCION} = "PROCEDIMIENTOS"
&THEN
/*                                                                                 */
/*---------------------------------------------------------------------------------*/
PROCEDURE RESTAR_RENGLON:

             
END PROCEDURE.

PROCEDURE SUMAR_RENGLON:


END PROCEDURE.

PROCEDURE VALIDAR_DOCUMENTO:

  hubo_error = YES.

  hubo_error = NO.

END PROCEDURE.

PROCEDURE CALCULOS:

/*  {CALCOPAG.I }*/

  DISPLAY Rcb_header.a_pagar 
          Rcb_header.basico
          Rcb_header.remunerativo
          WITH FRAME frm-documento.

END PROCEDURE.

PROCEDURE ASIGNAR_Empleado:

   Rcb_header.nro_empleado = Empleado.nro_empleado.

END PROCEDURE.

PROCEDURE TRAER_DOCUMENTO.

   hay_error = YES.

/*
   IF Rcb_header.anulado AND Rcb_header.origen = "A"
   THEN DO:
      RUN PONMENSJ.P (INPUT "RECB017").
      RETURN.
   END.   
*/
   FIND Liquidacion    OF Rcb_header NO-LOCK.
   FIND Empleado       OF Rcb_header NO-LOCK.
   
   DISPLAY
        Rcb_header.tip_comprob 
        Rcb_header.nro_comprob 
        Rcb_header.fecha 
        Rcb_header.sec_liquidacion WHEN AVAILABLE Liquidacion
        Liquidacion.descripcion     WHEN AVAILABLE Liquidacion
        Empleado.nro_legajo
        Empleado.nombre
        Rcb_header.a_pagar
        Rcb_header.basico
        Rcb_header.remunerativo
        WITH FRAME frm-documento.
       
   RUN ABRE_QUERY_DETALLE.
   VIEW FRAME frm-detalle.
   brw-detalle:VISIBLE IN FRAME frm-detalle = YES.
   brw-detalle:SENSITIVE IN FRAME frm-detalle = YES.
               
   ENABLE btn_OBSERV 
          WITH FRAME frm-documento.

   hay_error = NO.
   act_Rcb_head = ROWID(Rcb_header).
   APPLY "TAB" TO Rcb_header.nro_comprob.

END PROCEDURE.

PROCEDURE ANULAR_DOCUMENTO.


  Rcb_header.anulado = YES.

END PROCEDURE.

PROCEDURE REIMPRIMIR_DOCUMENTO.


   FIND Parametro "NFRECBSJ" NO-LOCK NO-ERROR.
   que_rutina = "PRRSJ" + STRING(Parametro.valor_n, "999") + ".P".

   FIND Parametro "NCOPRCSJ" NO-LOCK NO-ERROR.
   ncopias = Parametro.valor_n.
   
   FIND Parametro "RECBHOJA" NO-LOCK NO-ERROR.

   DO j = 1 TO ncopias:
      IF Parametro.valor_l
      THEN DO:
         MESSAGE "Por Favor, coloque formulario en la impresora para" 
                 + " imprimir copia de Recibo Nro.:" + STRING(j,"9")
                 VIEW-AS ALERT-BOX MESSAGE TITLE "Pausa de impresion".
      END.           

      RUN VALUE(que_rutina) (INPUT ROWID(Rcb_header)).

   END.


     
END PROCEDURE.

PROCEDURE TRAER_LIQUIDACION:

   ENABLE Rcb_header.tip_comprob
          Rcb_header.nro_comprob
          WITH FRAME frm-documento.

   DISABLE Rcb_header.sec_liquidacion
           WITH FRAME frm-documento.

END PROCEDURE.

&ENDIF

/*=================================================================================*/
/*                           F I N   D E   S E C C I O N                           */
/*=================================================================================*/
