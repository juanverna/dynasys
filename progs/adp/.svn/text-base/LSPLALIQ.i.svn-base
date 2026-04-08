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
DEFINE VARIABLE list_a     LIKE Rcb_detalle.importe.
DEFINE VARIABLE list_c     LIKE Rcb_detalle.importe.

DEFINE VARIABLE lisa_h     LIKE Rcb_detalle.importe FORMAT "ZZ,ZZZ,ZZ9.99-".
DEFINE VARIABLE lisa_r     LIKE Rcb_detalle.importe FORMAT "ZZ,ZZZ,ZZ9.99-".
DEFINE VARIABLE lisa_a     LIKE Rcb_detalle.importe FORMAT "ZZ,ZZZ,ZZ9.99-".
DEFINE VARIABLE lisa_c     LIKE Rcb_detalle.importe FORMAT "ZZ,ZZZ,ZZ9.99-".

DEFINE VARIABLE tot_h      LIKE Rcb_detalle.importe.
DEFINE VARIABLE tot_r      LIKE Rcb_detalle.importe.
DEFINE VARIABLE tot_a      LIKE Rcb_detalle.importe.
DEFINE VARIABLE tot_c      LIKE Rcb_detalle.importe.

DEFINE VARIABLE gen_h      LIKE Rcb_detalle.importe.
DEFINE VARIABLE gen_r      LIKE Rcb_detalle.importe.
DEFINE VARIABLE gen_a      LIKE Rcb_detalle.importe.
DEFINE VARIABLE gen_c      LIKE Rcb_detalle.importe.

DEFINE VARIABLE tot_apg    AS DECIMAL LABEL "Total Neto a pagar" FORMAT "ZZ,ZZZ,ZZ9.99".
DEFINE VARIABLE tot_rem    AS DECIMAL LABEL "Total Remunerativo" FORMAT "ZZ,ZZZ,ZZ9.99".
DEFINE VARIABLE tot_ayc    AS DECIMAL LABEL "Total Ap.y Contrib" FORMAT "ZZ,ZZZ,ZZ9.99".
DEFINE VARIABLE tot_con    AS DECIMAL LABEL "Total Asiento     " FORMAT "ZZ,ZZZ,ZZ9.99".

DEFINE VARIABLE tot_liq    AS INTEGER LABEL "Nro. Liquidaciones" FORMAT "ZZZZZZZZZZZZ9".

DEFINE VARIABLE emitir_resumen   AS LOGICAL 
       LABEL "Emitir Resumen"  VIEW-AS TOGGLE-BOX INITIAL YES.
DEFINE VARIABLE emitir_planilla  AS LOGICAL 
       LABEL "Emitir Planilla"  VIEW-AS TOGGLE-BOX INITIAL YES.
DEFINE VARIABLE listar_conceptos AS LOGICAL 
       LABEL "Listar conceptos"  VIEW-AS TOGGLE-BOX INITIAL YES.
                
DEFINE TEMP-TABLE Acumulado
       FIELD cdg_concepto  LIKE Concepto.cdg_concepto
       FIELD liquidados    AS INTEGER FORMAT ">>>9"
       FIELD importe       LIKE Rcb_detalle.importe 
       FIELD unidades      LIKE Rcb_detalle.unidades FORMAT ">>>>>9.99-".

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
  "Planilla de Liquidación" AT 35
  "Pagina:" AT 92 PAGE-NUMBER FORMAT ">>9" AT 100
  SKIP
  fecha_lis               
  det_titulo AT 35
  hora_lis AT 92
  SKIP(1)
  "------------------------------------------------------------------------------------------------------" SKIP
  "Legajo  Apellido y Nombre                 F/P  N.L.  N.R.   T.Rem.     A Pagar  Aportes y  Contrapar. " SKIP
  "        Concepto  Descripcion                 Unidades     Haberes    Retencs.  Contribs.  Asiento SyJ" SKIP
  "------------------------------------------------------------------------------------------------------"
  WITH WIDTH 131 FRAME frm-titulo TOP-ONLY PAGE-TOP STREAM-IO.


DEFINE FRAME frm-footer HEADER
  "------------------------------------------------------------------------------------------------------" SKIP
  WITH WIDTH 131 FRAME frm-footer PAGE-BOTTOM STREAM-IO.
  
DEFINE FRAME frm-listado-emp
  Empleado.nro_legajo
  Empleado.nombre   FORMAT "X(34)"               
  Empleado.cdg_forma
  Rcb_header.sec_liquidacion
  Rcb_header.nro_recibo
  Rcb_header.remunerativo       
  Rcb_header.a_pagar 
  WITH WIDTH 131 DOWN CENTERED FRAME frm-listado-emp USE-TEXT STREAM-IO NO-BOX
       NO-LABEL.

DEFINE FRAME frm-listado-nov
  SPACE(5)
  Concepto.cdg_concepto
  Concepto.descripcion
  Rcb_detalle.unidades
  list_h
  list_r
  list_a
  list_c
  WITH WIDTH 131 DOWN CENTERED FRAME frm-listado-nov USE-TEXT STREAM-IO NO-BOX
       NO-LABEL.

DEFINE FRAME frm-titulo-res HEADER
  que_empresa FORMAT "X(18)"
  "Resumen de Liquidación" AT 35
  "Pagina:" AT 106 PAGE-NUMBER FORMAT ">>9" AT 114
  SKIP
  fecha_lis               
  det_titulo AT 35
  hora_lis AT 106
  SKIP(1)
  "--------------------------------------------------------------------------------------------------------------------" SKIP
  "Co-  Concepto                           Total  Acumulado       Total de    Total de        Aportes y     Contrapar. " SKIP
  "digo Descripcion                        Liq.   Unidades       Haberes     Retenciones     Contribs.      Asiento SyJ" SKIP
  "--------------------------------------------------------------------------------------------------------------------"
  WITH WIDTH 131 FRAME frm-titulo-res TOP-ONLY PAGE-TOP STREAM-IO.

DEFINE FRAME frm-listado-res
  Concepto.cdg_concepto
  Concepto.descripcion
  Acumulado.liquidados
  Acumulado.unidades
  lisa_h
  lisa_r
  lisa_a
  lisa_c
  WITH WIDTH 131 DOWN CENTERED FRAME frm-listado-res USE-TEXT STREAM-IO NO-BOX
       NO-LABEL.

DEFINE FRAME frm-totales-res
  tot_liq COLON 20
  SKIP
  tot_rem COLON 20
  SKIP
  tot_apg COLON 20
  SKIP
  tot_ayc COLON 20
  SKIP
  tot_con COLON 20
  WITH WIDTH 96 DOWN CENTERED FRAME frm-totales-res USE-TEXT STREAM-IO NO-BOX
       SIDE-LABELS.

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
    emitir_resumen
    listar_conceptos.

  tot_liq = 0.
  tot_apg = 0.
  tot_rem = 0.
  tot_ayc = 0.
  tot_con = 0.
  gen_h   = 0.
  gen_r   = 0.
  gen_a   = 0.

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

      IF emitir_planilla
      THEN DO:
         VIEW FRAME frm-titulo.
         VIEW FRAME frm-footer.
      END.

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

          tot_h = 0.
          tot_r = 0.
          tot_a = 0.
          tot_c = 0.

          tot_apg = tot_apg + Rcb_header.a_pagar.
          tot_rem = tot_rem + Rcb_header.remunerativo.
          tot_liq = tot_liq + 1.
      
          IF emitir_planilla
          THEN DO:
             DISPLAY Empleado.nro_legajo WHEN NOT hay_empleado
                     Empleado.nombre     WHEN NOT hay_empleado
                     Empleado.cdg_forma  WHEN NOT hay_empleado
                     Rcb_header.sec_liquidacion
                     Rcb_header.nro_recibo
                     Rcb_header.remunerativo       
                     Rcb_header.a_pagar 
                     WITH FRAME frm-listado-emp.
             hay_empleado = YES.
             IF listar_conceptos THEN DOWN 2 WITH FRAME frm-listado-emp.
                                 ELSE DOWN   WITH FRAME frm-listado-emp.
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

              IF LOOKUP(Concepto.haber_retenc,"H,R,A,C") <> 0
              THEN DO:
        
                   list_h = Rcb_detalle.importe.
                   list_r = Rcb_detalle.importe.
                   list_a = Rcb_detalle.importe.
                   list_c = Rcb_detalle.importe.
                   IF emitir_planilla AND listar_conceptos
                   THEN DO:
                        DISPLAY Concepto.cdg_concepto
                                Concepto.descripcion
                                Rcb_detalle.unidades WHEN Concepto.unidad <> 0
                                list_h WHEN Concepto.haber_retenc = "H"
                                list_r WHEN Concepto.haber_retenc = "R"
                                list_a WHEN Concepto.haber_retenc = "A"
                                list_c WHEN Concepto.haber_retenc = "C"
                                WITH FRAME frm-listado-nov.
                        DOWN WITH FRAME frm-listado-nov.
                   END.   

                   CASE Concepto.haber_retenc:
                        WHEN "H" THEN tot_h = tot_h + Rcb_detalle.importe.
                        WHEN "R" THEN tot_r = tot_r + Rcb_detalle.importe.
                        WHEN "A" THEN tot_a = tot_a + Rcb_detalle.importe.
                        WHEN "C" THEN tot_c = tot_c + Rcb_detalle.importe.
                   END CASE.
                   
                   IF emitir_resumen 
                      THEN RUN ACUMULAR_CONCEPTO.
                      
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
         
          IF emitir_planilla AND listar_conceptos
          THEN DO:
             UNDERLINE Rcb_detalle.unidades 
                       list_h 
                       list_r
                       list_a
                       list_c
                       WITH FRAME frm-listado-nov.
             DISPLAY tot_h @ list_h
                     tot_r @ list_r
                     tot_a @ list_a
                     tot_c @ list_c
                     WITH FRAME frm-listado-nov.
              
             DOWN 2 WITH FRAME frm-listado-nov.

          END.                               

          gen_h = gen_h + tot_h.
          gen_r = gen_r + tot_r.
          gen_a = gen_a + tot_a.
          gen_c = gen_c + tot_c.

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


  IF emitir_planilla
  THEN DO:
     UNDERLINE Rcb_detalle.unidades 
               list_h 
               list_r
               list_a
               list_c
               WITH FRAME frm-listado-nov.
     DISPLAY   "Total general" @ Concepto.descripcion
               gen_h @ list_h
               gen_r @ list_r
               gen_a @ list_a
               gen_c @ list_c
               WITH FRAME frm-listado-nov.
  END.

  IF emitir_resumen 
  THEN DO:
     tot_ayc = gen_a.
     tot_con = gen_c.
     IF emitir_planilla 
     THEN DO:
        HIDE FRAME frm-titulo.
        HIDE FRAME frm-footer.                  
        PAGE.
     END.
     RUN EMITIR_RESUMEN.
  END.   
  
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

PROCEDURE ACUMULAR_CONCEPTO:

   FIND FIRST Acumulado WHERE Acumulado.cdg_concepto = Concepto.cdg_concepto NO-ERROR.
   IF NOT AVAILABLE Acumulado
   THEN DO:
      CREATE Acumulado.
      ASSIGN Acumulado.cdg_concepto = Concepto.cdg_concepto.
   END.
   
   ASSIGN
      Acumulado.importe    = Acumulado.importe    + Rcb_detalle.importe      
      Acumulado.unidades   = Acumulado.unidades   + Rcb_detalle.unidades      
      Acumulado.liquidados = Acumulado.liquidados + 1.   

END PROCEDURE.

PROCEDURE EMITIR_RESUMEN:

   tot_h = 0.
   tot_r = 0. 
   tot_a = 0. 
   tot_c = 0. 

   CLEAR FRAME frm-listado-res ALL NO-PAUSE.

   FOR EACH Acumulado BY cdg_concepto:
    
       VIEW FRAME frm-titulo-res.
       VIEW FRAME frm-footer.
       FIND Concepto WHERE Concepto.cdg_concepto = Acumulado.cdg_concepto.
       lisa_h = Acumulado.importe.
       lisa_r = Acumulado.importe.
       lisa_a = Acumulado.importe.
       lisa_c = Acumulado.importe.
       
       DISPLAY Concepto.cdg_concepto
               Concepto.descripcion
               Acumulado.liquidados
               Acumulado.unidades WHEN Acumulado.unidades <> 0
               lisa_h WHEN Concepto.haber_retenc = "H"
               lisa_r WHEN Concepto.haber_retenc = "R"
               lisa_a WHEN Concepto.haber_retenc = "A"
               lisa_c WHEN Concepto.haber_retenc = "C"
               WITH FRAME frm-listado-res.
       DOWN WITH FRAME frm-listado-res.

       CASE Concepto.haber_retenc:
            WHEN "H" THEN tot_h = tot_h + Acumulado.importe.
            WHEN "R" THEN tot_r = tot_r + Acumulado.importe.
            WHEN "A" THEN tot_a = tot_a + Acumulado.importe.
            WHEN "C" THEN tot_c = tot_c + Acumulado.importe.
       END CASE.

   END.

   UNDERLINE Acumulado.liquidados 
             Acumulado.unidades 
             lisa_h 
             lisa_r 
             lisa_a
             lisa_c
             WITH FRAME frm-listado-res.
   DISPLAY tot_h @ lisa_h
           tot_r @ lisa_r
           tot_a @ lisa_a
           tot_c @ lisa_c
           WITH FRAME frm-listado-res.   
              
   DOWN 2 WITH FRAME frm-listado-res.

   DISPLAY tot_liq 
           tot_apg 
           tot_rem 
           tot_ayc
           tot_con
           WITH FRAME frm-totales-res.
   HIDE FRAME frm-footer.          
   
END PROCEDURE.

&ENDIF

/*=================================================================================*/
/*                           F I N   D E   S E C C I O N                           */
/*=================================================================================*/
