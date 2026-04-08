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

      /* Variables para el registro de header y control  */

DEFINE VARIABLE h-idreg         AS CHARACTER.
DEFINE VARIABLE h-nrosuc        AS CHARACTER INITIAL "086".
DEFINE VARIABLE h-nroemp        AS CHARACTER.
DEFINE VARIABLE h-namemp        AS CHARACTER.
DEFINE VARIABLE h-nrosuc-deb    AS CHARACTER INITIAL "086".
DEFINE VARIABLE h-tipcta-deb    AS CHARACTER.
DEFINE VARIABLE h-nrocta-deb    AS CHARACTER.
DEFINE VARIABLE h-fecacred      AS CHARACTER.
DEFINE VARIABLE h-total_a_pagar AS CHARACTER.
DEFINE VARIABLE h-cant_movim    AS CHARACTER.
DEFINE VARIABLE h-nrosuc-adm    AS CHARACTER INITIAL "086".
DEFINE VARIABLE h-obligat       AS CHARACTER INITIAL "9".
DEFINE VARIABLE h-filler1       AS CHARACTER.

      /* Variables para el registro de movimientos */

DEFINE VARIABLE m-idreg         AS CHARACTER.
DEFINE VARIABLE m-nrosuc        AS CHARACTER INITIAL "086".
DEFINE VARIABLE m-nroemp        AS CHARACTER.
DEFINE VARIABLE m-filler1       AS CHARACTER.
DEFINE VARIABLE m-nrocta        AS CHARACTER.
DEFINE VARIABLE m-filler2       AS CHARACTER.
DEFINE VARIABLE m-importe       AS CHARACTER.
DEFINE VARIABLE m-filler3       AS CHARACTER.

            /* Variables para el proceso */

DEFINE VARIABLE cant_empleados  AS INTEGER.
DEFINE VARIABLE total_a_pagar   AS DECIMAL.
DEFINE VARIABLE total_empleado  AS DECIMAL.

DEFINE VARIABLE v-sucursal      AS CHARACTER FORMAT "X(3)".
DEFINE VARIABLE v-tipo_cuenta   AS CHARACTER FORMAT "X(1)".
DEFINE VARIABLE v-cuenta_nro    AS CHARACTER FORMAT "X(8)".
DEFINE VARIABLE v-fecha_pago    AS DATE.

DEFINE TEMP-TABLE Salida
  FIELD s-idreg  AS INTEGER
  FIELD s-regis  AS CHARACTER FORMAT "X(128)".

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
  "Planilla Acreditación de Haberes" AT 25
  "Página:" AT 69 PAGE-NUMBER FORMAT ">>9" AT 76
  SKIP
  fecha_lis               
  det_titulo AT 25
  hora_lis AT 69
  SKIP(1)
  "------------------------------------------------------------------------------" SKIP
  "Número  Apellido y                          Nro. Tip. Número de     Total a   " SKIP
  "Legajo  Nombre                              Suc. Cta. Cuenta        Pagar     " SKIP
  "------------------------------------------------------------------------------" SKIP(1)
  WITH WIDTH 80 FRAME frm-titulo TOP-ONLY PAGE-TOP STREAM-IO.

DEFINE FRAME frm-footer HEADER
  "------------------------------------------------------------------------------" SKIP
  WITH WIDTH 80 FRAME frm-footer PAGE-BOTTOM STREAM-IO.
  
DEFINE FRAME frm-listado-emp
  Empleado.nro_legajo 
  Empleado.nombre     
  v-sucursal
  SPACE(4)
  v-tipo_cuenta
  SPACE(2)
  v-cuenta_nro
  SPACE(2)
  total_empleado
  WITH WIDTH 80 DOWN CENTERED FRAME frm-listado-emp USE-TEXT STREAM-IO NO-BOX
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

  ASSIGN v-fecha_pago.

  FOR EACH Salida:
      DELETE Salida.
  END.    

  total_a_pagar  = 0.
  cant_empleados = 0.

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

          IF total_empleado <> 0
          THEN DO:

               cant_empleados  = cant_empleados + 1.
               total_a_pagar   = total_a_pagar + total_empleado.
               RUN CREAR_REGISTRO_MOVIMIENTO.

               ASSIGN
                   v-tipo_cuenta = SUBSTRING(Empleado.cuenta_nro,1,1)
                   v-sucursal    = SUBSTRING(Empleado.cuenta_nro,2,3)
                   v-cuenta_nro  = SUBSTRING(Empleado.cuenta_nro,5,6) + 
                                   SUBSTRING(Empleado.cuenta_nro,12,1).

               DISPLAY Empleado.nro_legajo 
                       Empleado.nombre     
                       v-sucursal
                       v-tipo_cuenta
                       v-cuenta_nro
                       total_empleado
                       WITH FRAME frm-listado-emp.
               DOWN    WITH FRAME frm-listado-emp.

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


  UNDERLINE Empleado.nro_legajo 
            Empleado.nombre     
            v-sucursal
            v-tipo_cuenta
            v-cuenta_nro
            total_empleado
            WITH FRAME frm-listado-emp.
  DISPLAY   "Total general"  @ Empleado.nombre
             cant_empleados  @ v-cuenta_nro
             total_a_pagar   @ total_empleado
             WITH FRAME frm-listado-emp.

  RUN GENERAR_INTERFACE.
  
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

PROCEDURE CREAR_REGISTRO_CONTROL:

   ASSIGN h-idreg         = "0"
          h-nrosuc        = "000"
          h-nroemp        = "8702"
          h-namemp        = STRING(SUBSTRING(Empresa.nombre,1,30),"X(30)")
          h-nrosuc-deb    = "086"
          h-tipcta-deb    = "1"
          h-nrocta-deb    = "0012663"
          h-fecacred      = STRING(v-fecha_pago,"999999")
          h-cant_movim    = STRING(cant_empleados,"9999")
          h-nrosuc-adm    = "086"
          h-obligat       = "9"
          h-filler1       = FILL(" ",48).

   h-total_a_pagar = STRING(total_a_pagar,"999999999999999.99").
   h-total_a_pagar = SUBSTRING(h-total_a_pagar,1,15) + SUBSTRING(h-total_a_pagar,17,2).

   CREATE Salida.
   ASSIGN Salida.s-idreg = 1
          Salida.s-regis = STRING(Salida.s-idreg,"9") +
                           h-idreg         +
                           h-nrosuc        +
                           h-nroemp        +
                           h-namemp        +
                           h-nrosuc-deb    +
                           h-tipcta-deb    +
                           h-nrocta-deb    +
                           h-fecacred      +
                           h-total_a_pagar +
                           h-cant_movim    +
                           h-nrosuc-adm    +
                           h-obligat       +
                           h-filler1       .
          

END PROCEDURE.

PROCEDURE CREAR_REGISTRO_MOVIMIENTO:

   ASSIGN m-idreg         = IF SUBSTRING(Empleado.cuenta_nro,1,1) = "1" THEN "7" ELSE "6"
          m-nrosuc        = SUBSTRING(Empleado.cuenta_nro,2,3)
          m-nroemp        = "8702"
          m-filler1       = FILL(" ",2)
          m-nrocta        = SUBSTRING(Empleado.cuenta_nro,5,6) + 
                            SUBSTRING(Empleado.cuenta_nro,12,1)
          m-filler2       = FILL(" ",4)
          m-filler3       = FILL(" ",94).

   m-importe = STRING(total_empleado,"99999999999.99").
   m-importe = SUBSTRING(m-importe,1,11) + SUBSTRING(m-importe,13,2).

   CREATE Salida.
   ASSIGN Salida.s-idreg = 2
          Salida.s-regis = STRING(Salida.s-idreg,"9") + 
                           m-idreg         +
                           m-nrosuc        +
                           m-nroemp        +
                           m-filler1       +
                           m-nrocta        +
                           m-filler2       +
                           m-importe       +
                           m-filler3       .

END PROCEDURE.

PROCEDURE GENERAR_INTERFACE:

  OUTPUT TO VALUE (dire_tmp + "bancorio.txt") .

  RUN CREAR_REGISTRO_CONTROL.
  FIND FIRST Salida WHERE Salida.s-idreg = 1.
  PUT Salida.s-regis SKIP.
  FOR EACH Salida WHERE Salida.s-idreg = 2:
      PUT Salida.s-regis SKIP.
  END.

  OUTPUT CLOSE.
   
END PROCEDURE.

&ENDIF

/*=================================================================================*/
/*                           F I N   D E   S E C C I O N                           */
/*=================================================================================*/
