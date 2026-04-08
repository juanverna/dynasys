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

DEFINE NEW SHARED VARIABLE ver_antes    AS INTEGER LABEL "Tratamiento"
                   VIEW-AS RADIO-SET HORIZONTAL 
                           RADIO-BUTTONS "S¢lo Ver", 0, "S¢lo Imprimir", 1, "Ambos",2.

DEFINE NEW SHARED VARIABLE uldep_banco  AS CHARACTER FORMAT "X(12)" LABEL "Banco".
DEFINE NEW SHARED VARIABLE uldep_period AS CHARACTER FORMAT "X(8)"  LABEL "Periodo".
DEFINE NEW SHARED VARIABLE uldep_fecha  AS CHARACTER FORMAT "X(8)"  LABEL "Fecha".
DEFINE NEW SHARED VARIABLE abonado      AS CHARACTER FORMAT "X(12)" LABEL "Per. Abonado".
DEFINE NEW SHARED VARIABLE cuando       AS CHARACTER FORMAT "X(15)" LABEL "Fecha de pago".

DEFINE VARIABLE hay_empleado AS LOGICAL.

DEFINE VARIABLE list_h     LIKE Rcb_detalle.importe.
DEFINE VARIABLE list_r     LIKE Rcb_detalle.importe.

DEFINE VARIABLE tot_h      LIKE Rcb_detalle.importe.
DEFINE VARIABLE tot_r      LIKE Rcb_detalle.importe.

DEFINE VARIABLE gen_h      LIKE Rcb_detalle.importe.
DEFINE VARIABLE gen_r      LIKE Rcb_detalle.importe.
DEFINE VARIABLE tot_apg    AS DECIMAL LABEL "Total a pagar" FORMAT "Z,ZZZ,ZZ9.99".
DEFINE VARIABLE tot_rem    AS DECIMAL LABEL "Total Remun."  FORMAT "Z,ZZZ,ZZ9.99".

DEFINE VARIABLE que_rutina  AS CHARACTER.
DEFINE VARIABLE j           AS INTEGER.
DEFINE VARIABLE ncopias     AS INTEGER.
DEFINE VARIABLE facthoja    AS LOGICAL.

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
  que_empresa FORMAT 
  "Emisi¢n de recibos" AT 38
  "Pagina:" AT 82 PAGE-NUMBER FORMAT ">>9" AT 92
  SKIP
  fecha_lis               
  det_titulo AT 30
  hora_lis AT 82
  SKIP(1)
  "----------------------------------------------------------------------------------------------" SKIP
  "Legajo  Apellido y Nombre            Liquidaci¢n    Nro Recibo      T.Remuner.       A Pagar"   SKIP
  "----------------------------------------------------------------------------------------------" SKIP
  WITH WIDTH 132 FRAME frm-titulo TOP-ONLY PAGE-TOP STREAM-IO.


DEFINE FRAME frm-footer HEADER
  "----------------------------------------------------------------------------------------------" SKIP
  WITH WIDTH 96 FRAME frm-footer PAGE-BOTTOM STREAM-IO.
  
DEFINE FRAME frm-listado-emp
  Empleado.nro_legajo
  Empleado.nombre                  
  Liquidacion.sec_liquidacion
  SPACE(9)
  Rcb_header.nro_recibo
  SPACE(5)
  Rcb_header.remunerativo
  SPACE(4)
  Rcb_header.a_pagar
  WITH WIDTH 96 DOWN FRAME frm-listado-emp USE-TEXT STREAM-IO NO-BOX 
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
&IF {&SECCION} = "INICIAR-PROGRAMA"
&THEN
/*                                                                                 */
/*---------------------------------------------------------------------------------*/

  FIND Parametro "ULDEPBCO" NO-LOCK.
  uldep_banco = Parametro.valor_c.

  FIND Parametro "ULDEPPER" NO-LOCK.
  uldep_period = Parametro.valor_c.
     
  FIND Parametro "ULDEPFCH" NO-LOCK.
  uldep_fecha = Parametro.valor_c.

  FIND Parametro "PERABONA" NO-LOCK.
  abonado  = Parametro.valor_c.

  FIND Parametro "FECHPAGO" NO-LOCK.
  cuando = Parametro.valor_c.
     
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
    uldep_banco
    uldep_period
    uldep_fecha
    abonado
    cuando
    des_legajo
    has_legajo
    ver_antes.

  DO TRANSACTION:

     FIND Parametro "ULDEPBCO" EXCLUSIVE-LOCK.
     Parametro.valor_c = uldep_banco.

     FIND Parametro "ULDEPPER" EXCLUSIVE-LOCK.
     Parametro.valor_c = uldep_period.
     
     FIND Parametro "ULDEPFCH" EXCLUSIVE-LOCK.
     Parametro.valor_c = uldep_fecha.

     FIND Parametro "PERABONA" EXCLUSIVE-LOCK.
     Parametro.valor_c = abonado.

     FIND Parametro "FECHPAGO" EXCLUSIVE-LOCK.
     Parametro.valor_c = cuando.
     
  END.   


  FIND Parametro "NFRECBSJ" NO-LOCK NO-ERROR.
  que_rutina = "PRRSJ" + STRING(Parametro.valor_n, "999") + ".P".
  FIND Parametro "NCOPRCSJ" NO-LOCK NO-ERROR.
  ncopias = Parametro.valor_n.

  FIND Parametro "RECBHOJA" NO-LOCK NO-ERROR.
  facthoja = Parametro.valor_l.

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

      DO j = 1 TO ncopias:
         IF facthoja
         THEN DO:
            MESSAGE "Por Favor, coloque formulario en la impresora para" 
                    + " imprimir copia de recibo Nro.:" + STRING(j,"9")
                    VIEW-AS ALERT-BOX MESSAGE TITLE "Pausa de impresion".
         END.           

         RUN VALUE(que_rutina) (INPUT ROWID(Rcb_header)).

      END.   

      DISPLAY Empleado.nro_legajo
              Empleado.nombre    
              Liquidacion.sec_liquidacion
              Rcb_header.nro_recibo
              Rcb_header.remunerativo              
              Rcb_header.a_pagar 
              WITH FRAME frm-listado-emp.
      DOWN WITH FRAME frm-listado-emp.

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












