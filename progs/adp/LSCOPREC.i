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

DEFINE VARIABLE hay_empleado AS LOGICAL.

DEFINE VARIABLE list_h     LIKE Rcb_detalle.importe.
DEFINE VARIABLE list_r     LIKE Rcb_detalle.importe.

DEFINE VARIABLE tot_h      LIKE Rcb_detalle.importe.
DEFINE VARIABLE tot_r      LIKE Rcb_detalle.importe.

DEFINE VARIABLE gen_h      LIKE Rcb_detalle.importe.
DEFINE VARIABLE gen_r      LIKE Rcb_detalle.importe.
DEFINE VARIABLE tot_apg    AS DECIMAL LABEL "Total a pagar" FORMAT "Z,ZZZ,ZZ9.99".
DEFINE VARIABLE tot_rem    AS DECIMAL LABEL "Total Remun."  FORMAT "Z,ZZZ,ZZ9.99".

DEFINE VARIABLE tipo_cod AS INTEGER LABEL "Listar" VIEW-AS RADIO-SET 
                HORIZONTAL RADIO-BUTTONS "Codigos",  1, "Abreviaturas", 2 INITIAL 1.
                
DEFINE VARIABLE det_haberes AS CHARACTER FORMAT "X(84)".


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
  "Copia resumen de recibos" AT 30
  "Pagina:" AT 82 PAGE-NUMBER FORMAT ">>9" AT 92
  SKIP
  fecha_lis               
  det_titulo AT 30
  hora_lis AT 82
  SKIP(1)
  "----------------------------------------------------------------------------------------------" SKIP
  "Legajo  Apellido y Nombre                   Liq.     Nro Recibo  T.Remuner.   A Pagar"   SKIP
  "        Conceptos e Importes" SKIP
  "----------------------------------------------------------------------------------------------" SKIP
  WITH WIDTH 132 FRAME frm-titulo TOP-ONLY PAGE-TOP STREAM-IO.


DEFINE FRAME frm-footer HEADER
  "----------------------------------------------------------------------------------------------" SKIP
  WITH WIDTH 96 FRAME frm-footer PAGE-BOTTOM STREAM-IO.
  
DEFINE FRAME frm-listado-emp
  Empleado.nro_legajo
  Empleado.nombre                  
  Rcb_header.sec_liquidacion
  SPACE(5)
  Rcb_header.tip_comprob
  Rcb_header.nro_comprob 
  Rcb_header.remunerativo
  Rcb_header.a_pagar
  WITH WIDTH 96 DOWN CENTERED FRAME frm-listado-emp USE-TEXT STREAM-IO NO-BOX
       NO-LABEL.

DEFINE FRAME frm-listado-mov
  SPACE(8)
  det_haberes
  WITH WIDTH 96 DOWN CENTERED FRAME frm-listado-mov USE-TEXT STREAM-IO NO-BOX
       NO-LABEL.

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

  ASSIGN
    des_legajo
    has_legajo
    tipo_cod.

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

      DISPLAY Empleado.nro_legajo
              Empleado.nombre    
              Rcb_header.sec_liquidacion
              Rcb_header.tip_comprob
              Rcb_header.nro_comprob 
              Rcb_header.remunerativo              
              Rcb_header.a_pagar 
              WITH FRAME frm-listado-emp.
      DOWN WITH FRAME frm-listado-emp.

      det_haberes = "".                    

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

     IF LOOKUP(Concepto.haber_retenc,"H,R") <> 0
     THEN DO:

          det_haberes = det_haberes + 
          ( IF tipo_cod = 1 THEN STRING(Concepto.cdg_concepto,"9999") 
                            ELSE Concepto.abreviatura + FILL(" ",8 - LENGTH(Concepto.abreviatura)) +   
                                      STRING(Rcb_detalle.importe,"ZZZ,ZZ9.99-") +
                                      " " ).

          IF LENGTH(det_haberes) > 70 OR LAST(Concepto.cdg_concepto)
          THEN DO:
             DISPLAY det_haberes
                     WITH FRAME frm-listado-mov.
             DOWN WITH FRAME frm-listado-mov.
             det_haberes = "".
          END.   


     END.
     
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
         
      DOWN 1 WITH FRAME frm-listado-mov.
          
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












