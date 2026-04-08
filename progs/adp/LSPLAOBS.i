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
  "Aportes de Prepaga" AT 30
  "Pagina:" AT 68 PAGE-NUMBER FORMAT ">>9" AT 76
  SKIP
  fecha_lis               
  det_titulo AT 30
  hora_lis AT 68  
  SKIP       
  det_titulo2 AT 30
  SKIP(1)
  "------------------------------------------------------------------------------" SKIP
  "                                              Aporte    Aporte     Contrib.   " SKIP
  "Legajo  Apellido y Nombre           Neto     Empleado  Adicional   Patronal   " SKIP
  "------------------------------------------------------------------------------" SKIP
  WITH WIDTH 132 FRAME frm-titulo TOP-ONLY PAGE-TOP STREAM-IO.

DEFINE FRAME frm-listado-emp
  Empleado.nro_legajo
  Empleado.nombre  FORMAT "X(23)"
  total_empleado
  aporte_empleado
  aporte_adicional
  aporte_patronal
  WITH WIDTH 80 DOWN CENTERED FRAME frm-listado-emp USE-TEXT STREAM-IO NO-BOX
       NO-LABEL.

DEFINE FRAME frm-footer HEADER
  ry SKIP
  WITH WIDTH 132 FRAME frm-footer PAGE-BOTTOM STREAM-IO.

                /* -------------- Obra Social ----------------------*/

&SCOPED-DEFINE TABLA            Prepaga
&SCOPED-DEFINE CODIGO           cdg_prepaga
&SCOPED-DEFINE NOMBRE           nombre
&SCOPED-DEFINE RUTINA           SELOBRAS
&SCOPED-DEFINE FRAME-INGRESO    frm-rango
&SCOPED-DEFINE ROWID-TABLA      act_Prepaga
&SCOPED-DEFINE TRADUCIR         YES
&SCOPED-DEFINE MOSTRAR          YES
&SCOPED-DEFINE ALTA-MODIF       ACTOBRAS
&SCOPED-DEFINE ULT_REGISTRO     ult_Prepaga
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

 IF NOT AVAILABLE Prepaga
 THEN DO:
    BELL.
    MESSAGE "No se ha indicado la Obra SOcial" VIEW-AS ALERT-BOX ERROR.
    RETURN NO-APPLY.
 END.   

 sel_convenios = "".
 FOR EACH Prepaga_Convenio OF Prepaga NO-LOCK:
    sel_convenios = sel_convenios + STRING(Prepaga_Convenio.cdg_convenio,"999") + ",".
 END.
 sel_convenios = SUBSTRING(sel_convenios,1,LENGTH(sel_convenios) - 1 ).   

 det_titulo2 = "Afiliado Nro. " + Prepaga.nro_afiliacion + " * " +
               STRING(Prepaga.cdg_prepaga,"999999") + "-" + Prepaga.nombre.

 total_a_pagar = 0.
 total_ap_empl = 0.
 total_ap_adic = 0.
 total_ap_patr = 0.
 
 FIND FIRST Concepto NO-LOCK WHERE Concepto.cdg_concepto = Prepaga.cdg_concepto_empl.
 nro_conc_empl = Concepto.nro_concepto.

 FIND FIRST Concepto NO-LOCK WHERE Concepto.cdg_concepto = Prepaga.cdg_concepto_adic.
 nro_conc_adic = Concepto.nro_concepto.

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

          FIND FIRST Rcb_detalle OF Rcb_header
               WHERE Rcb_detalle.nro_concepto = nro_conc_empl NO-LOCK NO-ERROR.
          IF AVAILABLE Rcb_detalle                  
             THEN aporte_empleado = aporte_empleado + Rcb_detalle.importe.

          FIND FIRST Rcb_detalle OF Rcb_header
               WHERE Rcb_detalle.nro_concepto = nro_conc_adic NO-LOCK NO-ERROR.
          IF AVAILABLE Rcb_detalle 
             THEN aporte_adicional = aporte_adicional + Rcb_detalle.importe.
                   
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

      aporte_patronal = ROUND(total_empleado * Prepaga.porc_contribucion / 100.0,2).
 
      DISPLAY Empleado.nro_legajo
              Empleado.nombre
              total_empleado 
              aporte_empleado
              aporte_adicional
              aporte_patronal
              WITH FRAME frm-listado-emp.
      DOWN  WITH FRAME frm-listado-emp.        

      total_a_pagar = total_a_pagar + total_empleado. 
      total_ap_empl = total_ap_empl + aporte_empleado.
      total_ap_adic = total_ap_adic + aporte_adicional.      
      total_ap_patr = total_ap_patr + aporte_patronal.


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
              aporte_adicional
              aporte_patronal
              WITH FRAME frm-listado-emp.


  DISPLAY     total_a_pagar @ total_empleado 
              total_ap_empl @ aporte_empleado
              total_ap_adic @ aporte_adicional      
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












