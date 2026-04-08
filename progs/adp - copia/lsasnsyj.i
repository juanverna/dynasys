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

DEFINE VARIABLE list_d     LIKE Rcb_detalle.importe FORMAT "ZZ,ZZZ,ZZ9.99-".
DEFINE VARIABLE list_c     LIKE Rcb_detalle.importe FORMAT "ZZ,ZZZ,ZZ9.99-".

DEFINE VARIABLE tot_d      LIKE Rcb_detalle.importe.
DEFINE VARIABLE tot_c      LIKE Rcb_detalle.importe.

DEFINE VARIABLE emitir_resumen   AS LOGICAL 
       LABEL "Emitir Resumen"  VIEW-AS TOGGLE-BOX INITIAL YES.
DEFINE VARIABLE emitir_planilla  AS LOGICAL 
       LABEL "Emitir Planilla"  VIEW-AS TOGGLE-BOX INITIAL YES.
DEFINE VARIABLE listar_conceptos AS LOGICAL 
       LABEL "Listar conceptos"  VIEW-AS TOGGLE-BOX INITIAL YES.
                
DEFINE TEMP-TABLE Acumulado
       FIELD deb-o-cred    AS INTEGER  /* 1=DEBITA , 2=ACREDITA */
       FIELD cdg_cuenta    LIKE Cuenta.cdg_cuenta
       FIELD importe       LIKE Rcb_detalle.importe FORMAT "ZZ,ZZZ,ZZ9.99".

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
        
DEFINE FRAME frm-titulo-res HEADER
  que_empresa FORMAT "X(18)"
  "Asiento de Sueldos y Jornales" AT 35
  "Página:" AT 82 PAGE-NUMBER FORMAT ">>9" AT 90
  SKIP
  fecha_lis               
  det_titulo AT 35
  hora_lis AT 82
  SKIP(1)
  "--------------------------------------------------------------------------------------------" SKIP
  "Cuenta   Cuenta                                                  Importe            Importe " SKIP
  "Código   Descripcion                                             Debitos           Creditos " SKIP
  "--------------------------------------------------------------------------------------------"
  WITH WIDTH 96 FRAME frm-titulo-res TOP-ONLY PAGE-TOP STREAM-IO.

DEFINE FRAME frm-footer HEADER
  "--------------------------------------------------------------------------------------------" SKIP
  WITH WIDTH 96 FRAME frm-footer PAGE-BOTTOM STREAM-IO.

DEFINE FRAME frm-listado-res
  Cuenta.cdg_cuenta
  Cuenta.nombre_cta
  SPACE(14)
  list_d
  SPACE(4)
  list_c
  WITH WIDTH 96 DOWN CENTERED FRAME frm-listado-res USE-TEXT STREAM-IO NO-BOX
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

  FOR EACH Acumulado:
      DELETE Acumulado.
  END.    

  ASSIGN
    emitir_planilla
    emitir_resumen.

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


      hay_empleado = NO.

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

         FIND Sub_header_syj OF Rcb_header NO-LOCK.
         FOR EACH Sub_detalle_syj OF Sub_header_syj:
             FIND Cuenta OF Sub_detalle_syj.
             RUN ACUMULAR_CUENTA.        
         END.            

                    
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

        RUN EMITIR_RESUMEN.

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

PROCEDURE ACUMULAR_CUENTA:

   FIND FIRST Acumulado 
        WHERE Acumulado.cdg_cuenta = Cuenta.cdg_cuenta 
          AND Acumulado.deb-o-cred = Sub_detalle_syj.tipo
              NO-ERROR.
   IF NOT AVAILABLE Acumulado
   THEN DO:
      CREATE Acumulado.
      ASSIGN Acumulado.cdg_cuenta = Cuenta.cdg_cuenta
             Acumulado.deb-o-cred = Sub_detalle_syj.tipo.
   END.
   
   ASSIGN
      Acumulado.importe    = Acumulado.importe    + Sub_detalle_syj.valor.      

END PROCEDURE.

PROCEDURE EMITIR_RESUMEN:

   tot_d = 0.
   tot_c = 0. 

   CLEAR FRAME frm-listado-res ALL NO-PAUSE.

   FOR EACH Acumulado BY Acumulado.deb-o-cred BY Acumulado.cdg_cuenta:
    
       VIEW FRAME frm-titulo-res.
       VIEW FRAME frm-footer.
       FIND Cuenta WHERE Cuenta.cdg_cuenta = Acumulado.cdg_cuenta.
       list_d = Acumulado.importe.
       list_c = Acumulado.importe.
       
       DISPLAY Cuenta.cdg_cuenta
               Cuenta.nombre_cta
               list_d WHEN Acumulado.deb-o-cred = 1
               list_c WHEN Acumulado.deb-o-cred = 2
               WITH FRAME frm-listado-res.
       DOWN WITH FRAME frm-listado-res.

       IF Acumulado.deb-o-cred = 1
          THEN tot_d = tot_d + Acumulado.importe.
          ELSE tot_c = tot_c + Acumulado.importe.
   END.

   UNDERLINE Cuenta.cdg_cuenta
             Cuenta.nombre_cta
             list_d 
             list_c 
             WITH FRAME frm-listado-res.

   DISPLAY tot_d @ list_d
           tot_c @ list_c
           WITH FRAME frm-listado-res.   

   UNDERLINE Cuenta.cdg_cuenta
             Cuenta.nombre_cta
             list_d 
             list_c 
             WITH FRAME frm-listado-res.
              
   HIDE FRAME frm-footer.          
   
END PROCEDURE.

&ENDIF

/*=================================================================================*/
/*                           F I N   D E   S E C C I O N                           */
/*=================================================================================*/
