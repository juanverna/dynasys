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

DEFINE VARIABLE dlq_nconyu LIKE Tit_dat_liquid.cdg_datliq LABEL "Dlq.Cony.".
DEFINE VARIABLE dlq_nhijos LIKE Tit_dat_liquid.cdg_datliq LABEL "Dlq.Hijos".
DEFINE VARIABLE dlq_nadher LIKE Tit_dat_liquid.cdg_datliq LABEL "Dlq.Ad.Os".

DEFINE VARIABLE dr-dgi    AS CHARACTER FORMAT "X(112)".

DEFINE VARIABLE v-cuil    AS CHARACTER FORMAT "X(11)".
DEFINE VARIABLE v-nconyu  AS INTEGER   FORMAT "9".
DEFINE VARIABLE v-nhijos  AS INTEGER   FORMAT "Z9".
DEFINE VARIABLE v-nadher  AS INTEGER   FORMAT "Z9".
DEFINE VARIABLE v-cdzona  AS CHARACTER FORMAT "X(02)"  LABEL "Zona".
DEFINE VARIABLE v-cdacti  AS CHARACTER FORMAT "X(04)".
DEFINE VARIABLE v-prcadi  AS INTEGER   FORMAT "ZZ9"  LABEL "% Reduc.".
DEFINE VARIABLE v-rebaja  AS INTEGER   FORMAT "ZZ9" LABEL "% Rebaja".
DEFINE VARIABLE v-filler1 AS CHARACTER FORMAT "X(02)" INITIAL "  ".
DEFINE VARIABLE v-prcred  AS INTEGER   FORMAT "Z9" LABEL "% Reduc.".
DEFINE VARIABLE v-filler2 AS CHARACTER FORMAT "X(02)" INITIAL "  ".
DEFINE VARIABLE v-obsnro  AS INTEGER   FORMAT "ZZZZZ9".
DEFINE VARIABLE v-salfam  AS DECIMAL   FORMAT "ZZZZZ9.99" DECIMALS 2.
DEFINE VARIABLE v-totbru  AS DECIMAL   FORMAT "ZZZZZ9.99" DECIMALS 2.
DEFINE VARIABLE v-totrem  AS DECIMAL   FORMAT "ZZZZZ9.99" DECIMALS 2.
DEFINE VARIABLE v-totvol  AS DECIMAL   FORMAT "ZZZZZ9.99" DECIMALS 2.
DEFINE VARIABLE v-totexc  AS DECIMAL   FORMAT "ZZZZZ9.99" DECIMALS 2.
DEFINE VARIABLE v-totosc  AS DECIMAL   FORMAT "ZZZZZ9.99" DECIMALS 2.
DEFINE VARIABLE v-totado  AS DECIMAL   FORMAT "ZZZZZ9.99" DECIMALS 2.
DEFINE VARIABLE v-totexo  AS DECIMAL   FORMAT "ZZZZZ9.99" DECIMALS 2.

DEFINE VARIABLE t-regist  AS INTEGER.
DEFINE VARIABLE t-salfam  AS DECIMAL   FORMAT "ZZZZZ9.99" DECIMALS 2.
DEFINE VARIABLE t-totbru  AS DECIMAL   FORMAT "ZZZZZ9.99" DECIMALS 2.
DEFINE VARIABLE t-totrem  AS DECIMAL   FORMAT "ZZZZZ9.99" DECIMALS 2.
DEFINE VARIABLE t-totvol  AS DECIMAL   FORMAT "ZZZZZ9.99" DECIMALS 2.
DEFINE VARIABLE t-totexc  AS DECIMAL   FORMAT "ZZZZZ9.99" DECIMALS 2.
DEFINE VARIABLE t-totosc  AS DECIMAL   FORMAT "ZZZZZ9.99" DECIMALS 2.
DEFINE VARIABLE t-totado  AS DECIMAL   FORMAT "ZZZZZ9.99" DECIMALS 2.
DEFINE VARIABLE t-totexo  AS DECIMAL   FORMAT "ZZZZZ9.99" DECIMALS 2.

DEFINE STREAM s-dgi.

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
  que_empresa 
  "Generacion de archivo DGI" AT 70
  "Pagina:" AT 138 PAGE-NUMBER FORMAT ">>9" AT 146
  SKIP
  fecha_lis               
  det_titulo AT 70
  hora_lis AT 138
  SKIP(1)
  "----------------------------------------------------------------------------------------------------------------------------------------------------" SKIP
  "Legajo Apell.y Nombre  Nro. CUIL   C Hi Ad Zn Act. %Ad %re %r obsnro    salfam    totbru    totrem    totvol    totexc    totosc    totado    totexo" SKIP
  "----------------------------------------------------------------------------------------------------------------------------------------------------" SKIP
  WITH WIDTH 220 FRAME frm-titulo TOP-ONLY PAGE-TOP STREAM-IO.

DEFINE FRAME frm-listado-emp
  Empleado.nro_legajo
  Empleado.nombre  FORMAT "X(15)"
  v-cuil    
  v-nconyu  
  v-nhijos  
  v-nadher  
  v-cdzona  
  v-cdacti  
  v-prcadi  
  v-rebaja  
  v-prcred  
  v-obsnro
  v-salfam
  v-totbru
  v-totrem
  v-totvol
  v-totexc
  v-totosc
  v-totado
  v-totexo
  WITH WIDTH 160 DOWN FRAME frm-listado-emp USE-TEXT STREAM-IO NO-BOX 
       NO-LABEL.

&ENDIF

/*=================================================================================*/
/*                                                                                 */
/*                      C O M I E N Z O   D E   S E C C I O N                      */
/*                                                                                 */
/*                    INICIALIZACION DEL PROCESO DE CADA EMPLEADO                  */
/*                                                                                 */
/*=================================================================================*/
/*                                                                                 */
&IF {&SECCION} = "INICIAR-PROGRAMA"
&THEN
/*                                                                                 */
/*---------------------------------------------------------------------------------*/


      FIND Parametro "DLQCONYU" NO-LOCK NO-ERROR.
      IF AVAILABLE Parametro THEN dlq_nconyu = Parametro.valor_n.

      FIND Parametro "DLQHIJOS" NO-LOCK NO-ERROR.
      IF AVAILABLE Parametro THEN dlq_nhijos = Parametro.valor_n.

      FIND Parametro "DLQHIJIN" NO-LOCK NO-ERROR.
      IF AVAILABLE Parametro THEN dlq_nhijos = dlq_nhijos + Parametro.valor_n.

      FIND Parametro "DLQADHER" NO-LOCK NO-ERROR.
      IF AVAILABLE Parametro THEN dlq_nadher = Parametro.valor_n.


&ENDIF

/*=================================================================================*/
/*                           F I N   D E   S E C C I O N                           */
/*=================================================================================*/


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
         dlq_nconyu
         dlq_nhijos
         dlq_nadher
         v-cdzona
         v-rebaja
         v-prcred
         des_legajo
         has_legajo.

  ASSIGN
         t-regist  = 0
         t-salfam  = 0 
         t-totbru  = 0 
         t-totrem  = 0 
         t-totvol  = 0 
         t-totexc  = 0 
         t-totosc  = 0 
         t-totado  = 0 
         t-totexo  = 0. 


  OUTPUT STREAM s-dgi TO VALUE(dire_tmp + "ARCDGI.DAT").

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

      IF NUM-ENTRIES(Empleado.nro_cuil,"-") <> 3
         THEN v-cuil    = Empleado.nro_cuil.
         ELSE v-cuil    = ENTRY(1,Empleado.nro_cuil,"-") + 
                          ENTRY(2,Empleado.nro_cuil,"-") +
                          ENTRY(3,Empleado.nro_cuil,"-").

      FIND Datos_liq OF Empleado WHERE Datos_liq.cdg_datliq = dlq_nconyu NO-ERROR.
      IF AVAILABLE Datos_liq
         THEN v-nconyu = Datos_liq.valor.
         ELSE v-nconyu = 0.

      FIND Datos_liq OF Empleado WHERE Datos_liq.cdg_datliq = dlq_nhijos NO-ERROR.
      IF AVAILABLE Datos_liq
         THEN v-nhijos = Datos_liq.valor.
         ELSE v-nhijos = 0.
         
      FIND Datos_liq OF Empleado WHERE Datos_liq.cdg_datliq = dlq_nadher NO-ERROR.
      IF AVAILABLE Datos_liq
         THEN v-nadher = Datos_liq.valor.
         ELSE v-nadher = 0.

      ASSIGN
         v-cdacti  = Empleado.carac_servicios  
         v-prcadi  = 0   
         v-obsnro  = Empleado.cdg_prepaga
         v-salfam  = 0 
         v-totbru  = 0 
         v-totrem  = 0 
         v-totvol  = 0 
         v-totexc  = 0 
         v-totosc  = 0 
         v-totado  = 0 
         v-totexo  = 0. 

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

         v-totrem  = v-totrem + Rcb_header.remunerativo.

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


     IF Concepto.salario_fliar THEN v-salfam = v-salfam + Rcb_detalle.importe.
     IF Concepto.haber_retenc = "H" THEN v-totbru = v-totbru + Rcb_detalle.importe.

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


   v-totado = ROUND(v-totrem * 0.08,2).

   dr-dgi = "".
   dr-dgi = dr-dgi + STRING( v-cuil    , "X(11)"      ).
   dr-dgi = dr-dgi + STRING( v-nconyu  , "9"          ).
   dr-dgi = dr-dgi + STRING( v-nhijos  , "99"         ).
   dr-dgi = dr-dgi + STRING( v-nadher  , "99"         ).
   dr-dgi = dr-dgi + STRING( v-cdzona  , "X(02)"      ).
   dr-dgi = dr-dgi + STRING( v-cdacti  , "X(04)"      ).
   dr-dgi = dr-dgi + STRING( v-prcadi  , "999"        ).
   dr-dgi = dr-dgi + STRING( v-prcred  , "99"         ). /* Se swapeo prcred y rebaja 28/4/98 */
   dr-dgi = dr-dgi + STRING( v-filler1 , "X(02)"      ).
   dr-dgi = dr-dgi + STRING( v-rebaja  , "999"        ).
   dr-dgi = dr-dgi + STRING( v-filler2 , "X(02)"      ).
   dr-dgi = dr-dgi + STRING( v-obsnro  , "999999"     ).
   dr-dgi = dr-dgi + STRING( v-salfam  , "999999.99"  ).
   dr-dgi = dr-dgi + STRING( v-totbru  , "999999.99"  ).
   dr-dgi = dr-dgi + STRING( v-totrem  , "999999.99"  ).
   dr-dgi = dr-dgi + STRING( v-totvol  , "999999.99"  ).
   dr-dgi = dr-dgi + STRING( v-totexc  , "999999.99"  ).
   dr-dgi = dr-dgi + STRING( v-totosc  , "999999.99"  ).
   dr-dgi = dr-dgi + STRING( v-totado  , "999999.99"  ).
   dr-dgi = dr-dgi + STRING( v-totexo  , "999999.99"  ).

   PUT STREAM s-dgi dr-dgi SKIP.

   DISPLAY
           Empleado.nro_legajo
           Empleado.nombre 
           v-cuil    
           v-nconyu  
           v-nhijos  
           v-nadher  
           v-cdzona  
           v-cdacti  
           v-prcadi  
           v-rebaja  
           v-prcred  
           v-obsnro
           v-salfam
           v-totbru
           v-totrem
           v-totvol
           v-totexc
           v-totosc
           v-totado
           v-totexo
           WITH FRAME frm-listado-emp.

  DOWN WITH FRAME frm-listado-emp.


  ASSIGN
         t-regist  = t-regist + 1 
         t-salfam  = t-salfam + v-salfam 
         t-totbru  = t-totbru + v-totbru
         t-totrem  = t-totrem + v-totrem
         t-totvol  = t-totvol + v-totvol
         t-totexc  = t-totexc + v-totexc
         t-totosc  = t-totosc + v-totosc
         t-totado  = t-totado + v-totado
         t-totexo  = t-totexo + v-totexo . 



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


   UNDERLINE
           Empleado.nro_legajo
           Empleado.nombre 
           v-cuil    
           v-nconyu  
           v-nhijos  
           v-nadher  
           v-cdzona  
           v-cdacti  
           v-prcadi  
           v-rebaja  
           v-prcred  
           v-obsnro
           v-salfam
           v-totbru
           v-totrem
           v-totvol
           v-totexc
           v-totosc
           v-totado
           v-totexo
           WITH FRAME frm-listado-emp.

   DISPLAY
           "Totales" @ Empleado.nombre 
           t-regist  @ v-cuil    
           t-salfam  @ v-salfam
           t-totbru  @ v-totbru
           t-totrem  @ v-totrem
           t-totvol  @ v-totvol
           t-totexc  @ v-totexc
           t-totosc  @ v-totosc
           t-totado  @ v-totado
           t-totexo  @ v-totexo
           WITH FRAME frm-listado-emp.


   UNDERLINE
           Empleado.nro_legajo
           Empleado.nombre 
           v-cuil    
           v-nconyu  
           v-nhijos  
           v-nadher  
           v-cdzona  
           v-cdacti  
           v-prcadi  
           v-rebaja  
           v-prcred  
           v-obsnro
           v-salfam
           v-totbru
           v-totrem
           v-totvol
           v-totexc
           v-totosc
           v-totado
           v-totexo
           WITH FRAME frm-listado-emp.

  DOWN WITH FRAME frm-listado-emp.


OUTPUT STREAM s-dgi CLOSE.


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












