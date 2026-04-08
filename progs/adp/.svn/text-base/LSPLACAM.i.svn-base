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

&GLOBAL-DEFINE NTBILL 11
DEFINE VARIABLE billete    AS DECIMAL EXTENT {&NTBILL} 
                INITIAL [100.0,50.0,20.0,10.0,5.0,2.0,1.0,0.50,0.25,0.10,0.01].
DEFINE VARIABLE cambio     AS INTEGER EXTENT {&NTBILL} FORMAT "ZZ9".
DEFINE VARIABLE cambio_t   AS INTEGER EXTENT {&NTBILL} FORMAT "ZZ9".                
DEFINE VARIABLE remanente  AS DECIMAL.
DEFINE VARIABLE total_a_pagar AS DECIMAL.
DEFINE VARIABLE total_empleado LIKE Rcb_header.a_pagar.
DEFINE VARIABLE k_bill      AS INTEGER.
DEFINE VARIABLE ry          AS CHARACTER.

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
  que_empresa FORMAT "X(35)"
  "Planilla de Cambio" AT 38
  "Pagina:" AT 76 PAGE-NUMBER FORMAT ">>9" AT 84
  SKIP
  fecha_lis               
  det_titulo AT 38
  hora_lis AT 76
  SKIP(1)
  "--------------------------------------------------------------------------------------" SKIP
  "Legajo  Apellido y Nombre          A pagar 100  50  20  10   5   2   1 050 025 010 001" SKIP
  "--------------------------------------------------------------------------------------"
  WITH WIDTH 132 FRAME frm-titulo TOP-ONLY PAGE-TOP STREAM-IO.

DEFINE FRAME frm-listado-emp
  Empleado.nro_legajo
  Empleado.nombre  FORMAT "X(24)"
  total_empleado
  cambio
  WITH WIDTH 132 DOWN CENTERED FRAME frm-listado-emp USE-TEXT STREAM-IO NO-BOX
       NO-LABEL.

DEFINE FRAME frm-total-emp
  SPACE(8)
  "TOTALES" SPACE(17)
  total_a_pagar 
  cambio_t
  WITH WIDTH 132 DOWN CENTERED FRAME frm-total-emp USE-TEXT STREAM-IO NO-BOX
       NO-LABEL.

DEFINE FRAME frm-footer HEADER
  ry SKIP
  WITH WIDTH 132 FRAME frm-footer PAGE-BOTTOM STREAM-IO.

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

  total_a_pagar = 0.

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

          total_empleado = total_empleado + Rcb_header.a_pagar.
                   
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

      total_a_pagar = total_a_pagar + total_empleado.
      cambio = 0.
      remanente = total_empleado.
      DO k_bill = 1 TO {&NTBILL} WHILE remanente <> 0:
         cambio [ k_bill ] = TRUNC(remanente / billete [ k_bill ] , 0 ).
         remanente = remanente - cambio [ k_bill ] * billete [ k_bill ].
         cambio_t [ k_bill ] = cambio_t [ k_bill ] + cambio [ k_bill ].
      END.   
      DISPLAY Empleado.nro_legajo
              Empleado.nombre
              total_empleado
              cambio
              WITH FRAME frm-listado-emp.
      DOWN  WITH FRAME frm-listado-emp.        

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
              cambio
              WITH FRAME frm-listado-emp.

  DISPLAY     total_a_pagar
              cambio_t
              WITH FRAME frm-total-emp.
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












