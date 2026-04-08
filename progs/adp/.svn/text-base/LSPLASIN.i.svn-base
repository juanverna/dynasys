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


DEFINE VARIABLE total_a_pagar      AS DECIMAL.
DEFINE VARIABLE total_ap_empl      AS DECIMAL.
DEFINE VARIABLE total_ap_adic      AS DECIMAL.
DEFINE VARIABLE total_ap_patr      AS DECIMAL.

DEFINE VARIABLE nro_conc_empl      LIKE Concepto.nro_concepto.
DEFINE VARIABLE nro_conc_adic      LIKE Concepto.nro_concepto.

DEFINE VARIABLE total_empleado     LIKE Rcb_header.a_pagar.
DEFINE VARIABLE aporte_empleado    LIKE Rcb_header.a_pagar.
DEFINE VARIABLE aporte_adicional   LIKE Rcb_header.a_pagar.
DEFINE VARIABLE aporte_patronal    LIKE Rcb_header.a_pagar.

DEFINE VARIABLE ry                 AS CHARACTER.
DEFINE VARIABLE sel_convenios      AS CHARACTER.
DEFINE VARIABLE det_titulo2        AS CHARACTER FORMAT "X(40)".


&ENDIF

/*=================================================================================*/
/*                           F I N   D E   S E C C I O N                           */
/*=================================================================================*/

/*=================================================================================*/
/*                                                                                 */
/*                      C O M I E N Z O   D E   S E C C I O N                      */
/*                                                                                 */
/*                       FRAMES PARTICULARES DE CADA LISTADO                       */
/*                                                                                 */
/*=================================================================================*/
/*                                                                                 */
&IF {&SECCION} = "FRAMES"
&THEN
/*                                                                                 */
/*---------------------------------------------------------------------------------*/
        
DEFINE FRAME frm-titulo HEADER
  que_empresa FORMAT "X(18)"
  "Aportes Sindicales" AT 30
  "Pagina:" AT 68 PAGE-NUMBER FORMAT ">>9" AT 76
  SKIP
  fecha_lis               
  det_titulo AT 30
  hora_lis AT 68  
  SKIP       
  det_titulo2 AT 30
  SKIP(1)
  "------------------------------------------------------------------------------" SKIP
  "                                              Aporte   Contrib.   " SKIP
  "Legajo  Apellido y Nombre           Neto     Empleado  Patronal   " SKIP
  "------------------------------------------------------------------------------" SKIP
  WITH WIDTH 132 FRAME frm-titulo TOP-ONLY PAGE-TOP STREAM-IO.

DEFINE FRAME frm-listado-emp
  Empleado.nro_legajo
  Empleado.nombre  FORMAT "X(23)"
  total_empleado
  aporte_empleado
  aporte_patronal
  WITH WIDTH 80 DOWN CENTERED FRAME frm-listado-emp USE-TEXT STREAM-IO NO-BOX
       NO-LABEL.

DEFINE FRAME frm-footer HEADER
  ry SKIP
  WITH WIDTH 132 FRAME frm-footer PAGE-BOTTOM STREAM-IO.

                /* -------------- Sindicato ----------------------*/

&SCOPED-DEFINE TABLA            Sindicato
&SCOPED-DEFINE CODIGO           cdg_sindicato
&SCOPED-DEFINE NOMBRE           nombre
&SCOPED-DEFINE RUTINA           SELSINDI
&SCOPED-DEFINE FRAME-INGRESO    frm-rango
&SCOPED-DEFINE ROWID-TABLA      act_Sindicato
&SCOPED-DEFINE TRADUCIR         YES
&SCOPED-DEFINE MOSTRAR          YES
&SCOPED-DEFINE ALTA-MODIF       ACTSINDI
&SCOPED-DEFINE ULT_REGISTRO     ult_Sindicato
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
/*                   INCIALIZACION DEL PROCESAMIENTO DEL REPORTE                   */
/*                                                                                 */
/*=================================================================================*/
/*                                                                                 */
&IF {&SECCION} = "INICIAR-PROCESO"
&THEN
/*                                                                                 */
/*---------------------------------------------------------------------------------*/

 IF NOT AVAILABLE Sindicato
 THEN DO:
    BELL.
    MESSAGE "No se ha indicado el Sindicato" VIEW-AS ALERT-BOX ERROR.
    RETURN NO-APPLY.
 END.   

 sel_convenios = "".
 FOR EACH Sindicato_Convenio OF Sindicato NO-LOCK:
    sel_convenios = sel_convenios + STRING(Sindicato_Convenio.cdg_convenio,"999") + ",".
 END.
 sel_convenios = SUBSTRING(sel_convenios,1,LENGTH(sel_convenios) - 1 ).   

 det_titulo2 = "Afiliado Nro. " + Sindicato.numero_afiliacion + " * " +
               STRING(Sindicato.cdg_sindicato,"999") + "-" + Sindicato.nombre.

 total_a_pagar = 0.
 total_ap_empl = 0.
 total_ap_adic = 0.
 total_ap_patr = 0.
 
 FIND FIRST Concepto NO-LOCK WHERE Concepto.cdg_concepto = Sindicato.cdg_concepto_empl.
 nro_conc_empl = Concepto.nro_concepto.

&ENDIF

/*=================================================================================*/
/*                           F I N   D E   S E C C I O N                           */
/*=================================================================================*/

/*=================================================================================*/
/*                                                                                 */
/*                      C O M I E N Z O   D E   S E C C I O N                      */
/*                                                                                 */
/*                    INICIALIZACION DEL PROCESO DE CADA EMPLEADO                  */
/*                                                                                 */
/*=================================================================================*/
/*                                                                                 */
&IF {&SECCION} = "INICIAR-EMPLEADO"
&THEN
/*                                                                                 */
/*---------------------------------------------------------------------------------*/

             VIEW FRAME frm-titulo.
             VIEW FRAME frm-footer.
             total_empleado = 0.
             aporte_empleado = 0.
             aporte_adicional = 0.
             aporte_patronal = 0.

&ENDIF

/*=================================================================================*/
/*                           F I N   D E   S E C C I O N                           */
/*=================================================================================*/

/*=================================================================================*/
/*                                                                                 */
/*                      C O M I E N Z O   D E   S E C C I O N                      */
/*                                                                                 */
/*                    INICIALIZACION DEL PROCESO DE CADA RECIBO                    */
/*                                                                                 */
/*=================================================================================*/
/*                                                                                 */
&IF {&SECCION} = "INICIAR-RECIBO"
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
/*                             PROCESO DE CADA RECIBO                              */
/*                                                                                 */
/*=================================================================================*/
/*                                                                                 */
&IF {&SECCION} = "PROCESAR-RECIBO"
&THEN
/*                                                                                 */
/*---------------------------------------------------------------------------------*/

          total_empleado = total_empleado + Rcb_header.remunerativo.

          FIND FIRST Rcb_detalle
               WHERE Rcb_detalle.nro_recibo = Rcb_header.nro_recibo
                 AND Rcb_detalle.nro_concepto = nro_conc_empl NO-LOCK NO-ERROR.
          IF AVAILABLE Rcb_detalle                  
             THEN aporte_empleado = aporte_empleado + Rcb_detalle.importe.

&ENDIF

/*=================================================================================*/
/*                           F I N   D E   S E C C I O N                           */
/*=================================================================================*/

/*=================================================================================*/
/*                                                                                 */
/*                      C O M I E N Z O   D E   S E C C I O N                      */
/*                                                                                 */
/*                    INICIALIZACION DEL PROCESO DE CADA CONCEPTO                  */
/*                                                                                 */
/*=================================================================================*/
/*                                                                                 */
&IF {&SECCION} = "PROCESAR-CONCEPTO"
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
/*                    FINALIZACION DEL PROCESO DE LOS CONCEPTOS                    */
/*                                                                                 */
/*=================================================================================*/
/*                                                                                 */
&IF {&SECCION} = "FIN-CONCEPTOS"
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
/*                    FINALIZACION DEL PROCESO DE CADA RECIBO                      */
/*                                                                                 */
/*=================================================================================*/
/*                                                                                 */
&IF {&SECCION} = "FIN-RECIBOS"
&THEN
/*                                                                                 */
/*---------------------------------------------------------------------------------*/

      aporte_patronal = ROUND(total_empleado * Sindicato.porc_contribucion / 100.0,2).
 
      IF aporte_empleado <> 0
      THEN DO:
         DISPLAY Empleado.nro_legajo
                 Empleado.nombre
                 total_empleado 
                 aporte_empleado
                 aporte_patronal
                 WITH FRAME frm-listado-emp.
         DOWN  WITH FRAME frm-listado-emp.        
         total_a_pagar = total_a_pagar + total_empleado. 
         total_ap_empl = total_ap_empl + aporte_empleado.
         total_ap_patr = total_ap_patr + aporte_patronal.
      END.
      



&ENDIF

/*=================================================================================*/
/*                           F I N   D E   S E C C I O N                           */
/*=================================================================================*/

/*=================================================================================*/
/*                                                                                 */
/*                      C O M I E N Z O   D E   S E C C I O N                      */
/*                                                                                 */
/*                    FINALIZACION DEL PROCESO DE CADA EMPLEADO                    */
/*                                                                                 */
/*=================================================================================*/
/*                                                                                 */
&IF {&SECCION} = "FIN-EMPLEADOS"
&THEN
/*                                                                                 */
/*---------------------------------------------------------------------------------*/

  UNDERLINE   Empleado.nro_legajo
              Empleado.nombre
              total_empleado 
              aporte_empleado
              aporte_patronal
              WITH FRAME frm-listado-emp.


  DISPLAY     total_a_pagar @ total_empleado 
              total_ap_empl @ aporte_empleado
              total_ap_patr @ aporte_patronal
              WITH FRAME frm-listado-emp.
  DOWN  WITH FRAME frm-total-emp.        
  HIDE FRAME frm-footer.
  
&ENDIF

/*=================================================================================*/
/*                           F I N   D E   S E C C I O N                           */
/*=================================================================================*/

/*=================================================================================*/
/*                                                                                 */
/*                      C O M I E N Z O   D E   S E C C I O N                      */
/*                                                                                 */
/*                    PROCEDIMIENTOS PARTICULARES DE CADA CASO                     */
/*                                                                                 */
/*=================================================================================*/
/*                                                                                 */
&IF {&SECCION} = "PROCEDIMIENTOS"
&THEN
/*                                                                                 */
/*---------------------------------------------------------------------------------*/


&ENDIF

/*=================================================================================*/
/*                           F I N   D E   S E C C I O N                           */
/*=================================================================================*/












