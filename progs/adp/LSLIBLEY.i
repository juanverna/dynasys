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

DEFINE VARIABLE hay_empleado      AS LOGICAL.
DEFINE VARIABLE tot_apg           LIKE Rcb_detalle.importe.
DEFINE VARIABLE tot_rem           LIKE Rcb_detalle.importe.
DEFINE VARIABLE tot_hr            LIKE Rcb_detalle.importe.
DEFINE VARIABLE tot_nr            LIKE Rcb_detalle.importe.
DEFINE VARIABLE tot_ds            LIKE Rcb_detalle.importe.

DEFINE VARIABLE emp_apg           LIKE Rcb_detalle.importe.
DEFINE VARIABLE emp_rem           LIKE Rcb_detalle.importe.
DEFINE VARIABLE emp_hr            LIKE Rcb_detalle.importe.
DEFINE VARIABLE emp_nr            LIKE Rcb_detalle.importe.
DEFINE VARIABLE emp_ds            LIKE Rcb_detalle.importe.

DEFINE BUFFER Hab_siremun FOR Rcb_detalle.
DEFINE BUFFER Hab_noremun FOR Rcb_detalle.
DEFINE BUFFER Descuentos  FOR Rcb_detalle.  

DEFINE BUFFER Re_Concepto FOR Concepto.  
DEFINE BUFFER No_Concepto FOR Concepto.  
DEFINE BUFFER Ds_Concepto FOR Concepto.  

DEFINE QUERY qry_siremun FOR Hab_siremun, Re_Concepto.
DEFINE QUERY qry_noremun FOR Hab_noremun, No_Concepto.
DEFINE QUERY qry_descuen FOR Descuentos , Ds_Concepto.

DEFINE VARIABLE que_periodo   AS CHARACTER FORMAT "X(15)" LABEL "Periodo".

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
  que_empresa FORMAT "X(50)" 
  "Libro Art 52 Ley 21927" AT 60
  "Pagina:" AT 140 PAGE-NUMBER FORMAT ">>9" AT 148
  SKIP
  que_domicilio
  det_titulo AT 60
  SKIP(1)                                              
  "---------------------------------------------------------------------------------------------------------------------------------------------------------" SKIP
  "Legajo Nombre y Apellido                   Ingreso  Baja  " SKIP
  "<---------- Haberes remunerativos ---------------> <---------- Haberes No Remunerativos ------------> <--------- Descuentos y Retenciones ------------->" SKIP
  "---------------------------------------------------------------------------------------------------------------------------------------------------------" SKIP
  WITH WIDTH 160 FRAME frm-titulo TOP-ONLY PAGE-TOP STREAM-IO.


DEFINE FRAME frm-footer HEADER
  "---------------------------------------------------------------------------------------------------------------------------------------------------------" SKIP
  WITH WIDTH 160 FRAME frm-footer PAGE-BOTTOM STREAM-IO.
  
DEFINE FRAME frm-listado-emp
  Empleado.nro_legajo
  Empleado.nombre    
  Empleado.nro_cuil
  Empleado.fecha_ingreso
  Empleado.fecha_baja
  Rcb_header.nro_recibo
  Rcb_header.fecha
  WITH WIDTH 160 DOWN CENTERED FRAME frm-listado-emp USE-TEXT STREAM-IO NO-BOX
       NO-LABEL.

DEFINE FRAME frm-listado-nov
  Re_Concepto.cdg_concepto
  Re_concepto.descripcion FORMAT "X(25)"
  Hab_siremun.unidades
  Hab_siremun.importe

  No_Concepto.cdg_concepto
  No_concepto.descripcion FORMAT "X(25)"
  Hab_noremun.unidades
  Hab_noremun.importe
  
  Ds_Concepto.cdg_concepto
  Ds_concepto.descripcion FORMAT "X(25)"
  Descuentos.unidades
  Descuentos.importe

  WITH WIDTH 160 DOWN CENTERED FRAME frm-listado-nov USE-TEXT STREAM-IO NO-BOX
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
    que_periodo.

  tot_apg = 0.
  tot_rem = 0.
  tot_hr  = 0.
  tot_nr  = 0.
  tot_ds  = 0.

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

      det_titulo = "Corresponde:" + que_periodo.
      que_empresa = que_empresa + " - " + que_actividad.
      VIEW FRAME frm-titulo.
      VIEW FRAME frm-footer.
      emp_apg = 0.
      emp_rem = 0.
      emp_hr  = 0.
      emp_nr  = 0.
      emp_ds  = 0.
      hay_empleado = NO.
      
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

          emp_apg = emp_apg + Rcb_header.a_pagar.
          emp_rem = emp_rem + Rcb_header.remunerativo.
      
          DISPLAY Empleado.nro_legajo     WHEN NOT hay_empleado
                  Empleado.nombre         WHEN NOT hay_empleado
                  Empleado.nro_cuil       WHEN NOT hay_empleado
                  Empleado.fecha_ingreso  WHEN NOT hay_empleado
                  Empleado.fecha_baja     WHEN NOT hay_empleado
                  Rcb_header.nro_recibo
                  Rcb_header.fecha
                  WITH FRAME frm-listado-emp.
          hay_empleado = YES.
          DOWN 2 WITH FRAME frm-listado-emp.

          OPEN QUERY qry_siremun
                     FOR EACH Hab_siremun 
                        WHERE Hab_siremun.nro_recibo = Rcb_header.nro_recibo
                          AND Hab_siremun.sec_liquidacion = Rcb_header.sec_liquidacion, 
                          FIRST Re_Concepto OF Hab_siremun 
                                WHERE Re_Concepto.haber_retenc = "H" 
                                  AND NOT Re_Concepto.salario_fliar
                                  BY Re_Concepto.cdg_concepto.

          OPEN QUERY qry_noremun
                     FOR EACH Hab_noremun 
                        WHERE Hab_noremun.nro_recibo = Rcb_header.nro_recibo
                          AND Hab_noremun.sec_liquidacion = Rcb_header.sec_liquidacion, 
                          FIRST No_Concepto OF Hab_noremun 
                                WHERE No_Concepto.haber_retenc = "H" 
                                  AND No_Concepto.salario_fliar
                                  BY No_Concepto.cdg_concepto.

          OPEN QUERY qry_descuen
                     FOR EACH Descuentos 
                        WHERE Descuentos.nro_recibo = Rcb_header.nro_recibo
                          AND Descuentos.sec_liquidacion = Rcb_header.sec_liquidacion, 
                          FIRST Ds_Concepto OF Descuentos 
                                WHERE Ds_Concepto.haber_retenc = "R" 
                                  AND Ds_Concepto.salario_fliar
                                  BY Ds_Concepto.cdg_concepto.                                    
           GET FIRST qry_siremun.
           GET FIRST qry_noremun.
           GET FIRST qry_descuen.
           
           DO WHILE AVAILABLE Hab_siremun OR AVAILABLE Hab_noremun OR AVAILABLE Descuentos:

              DISPLAY 
                   
                   Re_Concepto.cdg_concepto  WHEN AVAILABLE Hab_siremun
                   Re_concepto.descripcion   WHEN AVAILABLE Hab_siremun
                   Hab_siremun.unidades      WHEN AVAILABLE Hab_siremun 
                                              AND Re_Concepto.unidad <> 0
                   Hab_siremun.importe       WHEN AVAILABLE Hab_siremun

                   No_Concepto.cdg_concepto  WHEN AVAILABLE Hab_noremun
                   No_concepto.descripcion   WHEN AVAILABLE Hab_noremun
                   Hab_noremun.unidades      WHEN AVAILABLE Hab_noremun 
                                              AND No_concepto.unidad <> 0
                   Hab_noremun.importe       WHEN AVAILABLE Hab_noremun
  
                   Ds_Concepto.cdg_concepto  WHEN AVAILABLE Descuentos
                   Ds_concepto.descripcion   WHEN AVAILABLE Descuentos
                   Descuentos.unidades       WHEN AVAILABLE Descuentos  
                                              AND Ds_concepto.unidad <> 0
                   Descuentos.importe        WHEN AVAILABLE Descuentos
                   
                   WITH FRAME frm-listado-nov.
                   
              DOWN WITH FRAME frm-listado-nov.
              
              IF AVAILABLE Hab_siremun THEN emp_hr = emp_hr + Hab_siremun.importe.
              IF AVAILABLE Hab_noremun THEN emp_nr = emp_nr + Hab_noremun.importe.
              IF AVAILABLE Descuentos  THEN emp_ds = emp_ds + Descuentos.importe.
              
              GET NEXT qry_siremun.
              GET NEXT qry_noremun.
              GET NEXT qry_descuen.
              
           END.   

           UNDERLINE 
                   
                   Re_Concepto.cdg_concepto
                   Re_concepto.descripcion 
                   Hab_siremun.unidades    
                   Hab_siremun.importe     

                   No_Concepto.cdg_concepto
                   No_concepto.descripcion 
                   Hab_noremun.unidades    
                   Hab_noremun.importe     
  
                   Ds_Concepto.cdg_concepto
                   Ds_concepto.descripcion 
                   Descuentos.unidades     
                   Descuentos.importe      
                   
                   WITH FRAME frm-listado-nov.
                   
              DISPLAY 
                   
                   "T.Rem.:" + STRING(emp_rem,"Z,ZZZ,ZZ9.99") @ Re_concepto.descripcion
                   "A Pagar:" + STRING(emp_rem,"Z,ZZZ,ZZ9.99") @ No_concepto.descripcion
                   emp_hr @ Hab_siremun.importe       
                   emp_nr @ Hab_noremun.importe       
                   emp_ds @ Descuentos.importe        
                   WITH FRAME frm-listado-nov.
                   
              DOWN 2 WITH FRAME frm-listado-nov.
              
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












