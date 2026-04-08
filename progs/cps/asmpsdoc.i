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

DEFINE NEW SHARED VARIABLE emitir_factura AS LOGICAL LABEL "Emitir factura".

DEFINE VARIABLE aux_diferencia     AS DECIMAL LABEL "Diferencia".
DEFINE VARIABLE aux_diferencia_div AS DECIMAL LABEL "Diferencia".

DEFINE BUFFER B-Amp_detalle FOR Amp_detalle.

&ENDIF

/*=================================================================================*/
/*                           F I N   D E   S E C C I O N                           */
/*=================================================================================*/

/*=================================================================================*/
/*                                                                                 */
/*                      C O M I E N Z O   D E   S E C C I O N                      */
/*                                                                                 */
/*                           FRAME PRINCIPAL DEL DOCUMENTO                         */
/*                                                                                 */
/*=================================================================================*/
/*                                                                                 */
&IF {&SECCION} = "FRAME_PPAL"
&THEN
/*                                                                                 */
/*---------------------------------------------------------------------------------*/

     SKIP(0.1)
     T-Amp_header.tip_comprob  COLON 12 LABEL "Modelo" FGCOLOR fe_c BGCOLOR be_c 
     T-Amp_header.nro_comprob                 NO-LABEL FGCOLOR fe_c BGCOLOR be_c
     T-Amp_header.fecha                 LABEL "Fec&ha" FGCOLOR fg_c BGCOLOR bg_c
     T-Amp_header.modo_importes                        FGCOLOR fe_c VIEW-AS RADIO-SET  HORIZONTAL
                                 RADIO-BUTTONS "Libres","L","Propor.","P","Fijos","F"
     SKIP(0.1)     
     T-Amp_header.leyenda      COLON 12 LABEL "&T¡tulo" FGCOLOR fe_c BGCOLOR be_c 
     SKIP(0.1)
     Ctapsp.cdg_ctapsp         COLON 12 LABEL "C&uenta" FGCOLOR fe_c BGCOLOR be_c
     T-Amp_header.tot_debitos  COLON 28 LABEL "Debe"    FGCOLOR fg_c BGCOLOR bg_c SPACE(2)
     T-Amp_header.tot_creditos          LABEL "Haber"   FGCOLOR fg_c BGCOLOR bg_c SPACE(3)
     aux_diferencia                     LABEL "Dif."    FGCOLOR fg_c BGCOLOR bg_c 
     SKIP
     T-Amp_header.tot_debitos_div  COLON 28 LABEL "D.Div."  FGCOLOR fg_c BGCOLOR bg_c 
     T-Amp_header.tot_creditos_div          LABEL "H.Div."  FGCOLOR fg_c BGCOLOR bg_c 
     aux_diferencia_div                     LABEL "Dif.D."  FGCOLOR fg_c BGCOLOR bg_c 
     SKIP(0.1)          

&ENDIF

/*=================================================================================*/
/*                           F I N   D E   S E C C I O N                           */
/*=================================================================================*/

/*=================================================================================*/
/*                                                                                 */
/*                      C O M I E N Z O   D E   S E C C I O N                      */
/*                                                                                 */
/*                                      MENUES                                     */
/*                                                                                 */
/*=================================================================================*/
/*                                                                                 */
&IF {&SECCION} = "MENUES"
&THEN
/*                                                                                 */
/*---------------------------------------------------------------------------------*/
          
/*---------------------------------------------------------------------------------*/
/*                              S U B M E N U E S                                  */
/*---------------------------------------------------------------------------------*/

DEFINE SUB-MENU Archivo
   MENU-ITEM Salir                  LABEL "&Salir".

DEFINE MENU  Principal MENUBAR
   SUB-MENU  Archivo                LABEL "&Archivo".

&ENDIF

/*=================================================================================*/
/*                           F I N   D E   S E C C I O N                           */
/*=================================================================================*/

/*=================================================================================*/
/*                                                                                 */
/*                      C O M I E N Z O   D E   S E C C I O N                      */
/*                                                                                 */
/*                          TRIGGERS PARTICULARES DEL CASO                         */
/*                                                                                 */
/*=================================================================================*/
/*                                                                                 */
&IF {&SECCION} = "TRIGGERS"
&THEN
/*                                                                                 */
/*---------------------------------------------------------------------------------*/

/*----------------------------------------------------------------------------------*/
/*                    IDENTIFICACION DEL DOCUMENTO A RECUPERAR                      */
/*----------------------------------------------------------------------------------*/

ON CHOOSE OF MENU-ITEM Salir IN MENU Principal OR 
   CHOOSE OF btn_salir IN FRAME frm-documento
DO:

  codigo_salir  = CD_SALIR.
  APPLY "U1" TO FRAME frm-documento.             
  RETURN NO-APPLY.

END.


ON LEAVE OF T-Amp_header.leyenda IN FRAME frm-documento
DO:
   ASSIGN T-Amp_header.leyenda.
END.      

        /* -------------------- Cuenta ------------*/

&SCOPED-DEFINE TABLA            Ctapsp
&SCOPED-DEFINE CODIGO           cdg_ctapsp
&SCOPED-DEFINE NOMBRE           descripcion
&SCOPED-DEFINE RUTINA           SELCTAPS
&SCOPED-DEFINE FRAME-INGRESO    frm-documento
&SCOPED-DEFINE ROWID-TABLA      act_ctapsp
&SCOPED-DEFINE TRADUCIR         NO
&SCOPED-DEFINE MOSTRAR          NO
&SCOPED-DEFINE ALTA-MODIF       ACTCTAPS
&SCOPED-DEFINE ULT_REGISTRO     ult_ctapsp
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
/*                      PROCESO DE INICIALIZACION DEL PROGRAMA                     */
/*                                                                                 */
/*=================================================================================*/
/*                                                                                 */
&IF {&SECCION} = "INICIAR"
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
/*                       PROCESO A EJECUTAR ANTES DE VALIDAR                       */
/*                                                                                 */
/*=================================================================================*/
/*                                                                                 */
&IF {&SECCION} = "ANT-VALIDAR"
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
/*                      PROCESO A EJECUTAR DESPUES DE VALIDAR                      */
/*                                                                                 */
/*=================================================================================*/
/*                                                                                 */
&IF {&SECCION} = "DES-VALIDAR"
&THEN
/*                                                                                 */
/*---------------------------------------------------------------------------------*/

  ASSIGN
     T-Amp_header.tip_comprob
     T-Amp_header.nro_comprob
     T-Amp_header.fecha
     T-Amp_header.modo_importes
     T-Amp_header.leyenda.
     
&ENDIF

/*=================================================================================*/
/*                           F I N   D E   S E C C I O N                           */
/*=================================================================================*/
/*=================================================================================*/
/*                                                                                 */
/*                      C O M I E N Z O   D E   S E C C I O N                      */
/*                                                                                 */
/*                      PROCEDIMIENTOS PARTICULARES DEL CASO                       */
/*                                                                                 */
/*=================================================================================*/
/*                                                                                 */
&IF {&SECCION} = "PROCEDIMIENTOS"
&THEN
/*                                                                                 */
/*---------------------------------------------------------------------------------*/

PROCEDURE RESTAR_RENGLON:

END PROCEDURE.

PROCEDURE SUMAR_RENGLON:


END PROCEDURE.

PROCEDURE VALIDAR_DOCUMENTO:

  hubo_error = YES.

  IF ROWID(T-Amp_header) = ?
  THEN DO:
     RUN PONMENSJ.P (INPUT "ASIE007").
     RETURN.
  END.

  IF NOT CAN-FIND(FIRST Amp_detalle OF  T-Amp_header)
  THEN DO:
     RUN PONMENSJ.P (INPUT "ASIE005").
     RETURN.
  END.

  IF T-Amp_header.tot_debitos <> T-Amp_header.tot_creditos 
  THEN DO:
     RUN PONMENSJ ( INPUT "ASIE010" ).
     RETURN.
  END.

  IF T-Amp_header.tot_debitos_div <> T-Amp_header.tot_creditos_div
  THEN DO:
     RUN PONMENSJ.P ( INPUT "ASIE011" ).
     RETURN.
  END.

  IF INPUT FRAME frm-documento T-Amp_header.modo_importes <> "L"  
     AND T-Amp_header.tot_debitos = 0
  THEN DO:
     RUN PONMENSJ.P ( INPUT "ASIE022" ).
     RETURN.
  END.

  IF INPUT FRAME frm-documento T-Amp_header.modo_importes = "L"  
     AND T-Amp_header.tot_debitos <> 0
  THEN DO:
     RUN PONMENSJ.P ( INPUT "ASIE023" ).
     RETURN.
  END.

  IF INPUT FRAME frm-documento T-Amp_header.tip_comprob = ""  
  THEN DO:
     RUN PONMENSJ.P ( INPUT "ASIE002" ).
     RETURN.
  END.

  IF INPUT FRAME frm-documento T-Amp_header.nro_comprob = ""  
  THEN DO:
     RUN PONMENSJ.P ( INPUT "ASIE003" ).
     RETURN.
  END.

  IF CAN-FIND(FIRST Amp_header WHERE Amp_header.tip_comprob = FRAME frm-documento T-Amp_header.tip_comprob 
                                 AND Amp_header.nro_comprob = FRAME frm-documento T-Amp_header.nro_comprob
                                 AND ROWID(Amp_header) <> act_amd_head )
  THEN DO:
     RUN PONMENSJ.P ( INPUT "ASIE009" ).
     RETURN.
  END.

  ASSIGN 
       T-Amp_header.tip_comprob
       T-Amp_header.nro_comprob
       T-Amp_header.fecha
       T-Amp_header.modo_importes
       T-Amp_header.leyenda.

  hubo_error = NO.

END PROCEDURE.

PROCEDURE CALCULOS:

  IF T-Amp_header.ultima_linea = 0 THEN RETURN.

  {CALCASMP.I "T-"}

  DISPLAY T-Amp_header.tot_debitos     
          T-Amp_header.tot_creditos     
          aux_diferencia 
          T-Amp_header.tot_debitos_div 
          T-Amp_header.tot_creditos_div 
          aux_diferencia_div 
          WITH FRAME frm-documento.

END PROCEDURE.

PROCEDURE ASIGNAR_DETALLE:


END PROCEDURE.

PROCEDURE TRAER_DOCUMENTO:

   hay_error = YES.

   aux_diferencia     =  T-Amp_header.tot_debitos     - T-Amp_header.tot_creditos.
   aux_diferencia_div =  T-Amp_header.tot_debitos_div - T-Amp_header.tot_creditos_div.
   
   DISPLAY
        T-Amp_header.tip_comprob 
        T-Amp_header.nro_comprob 
        T-Amp_header.leyenda
        T-Amp_header.modo_importes
        T-Amp_header.tot_debitos 
        T-Amp_header.tot_creditos
        T-Amp_header.tot_debitos_div 
        T-Amp_header.tot_creditos_div
        aux_diferencia 
        aux_diferencia_div
        brw-detalle
        WITH FRAME frm-documento.
        
   OPEN QUERY qry-detalle FOR EACH Amp_detalle OF T-Amp_header,
                              EACH Ctapsp      OF Amp_detalle.

   ENABLE brw-detalle btn_OBSERV WITH FRAME frm-documento.
   IF T-Amp_header.origen <> "M" THEN DISABLE btn_GRABAR WITH FRAME frm-documento.
   hay_error = NO.
   act_amd_head = ROWID(Amp_header).
   APPLY "TAB" TO T-Amp_header.nro_comprob.

END PROCEDURE.

PROCEDURE ANULAR_DOCUMENTO:

   RUN NOESTA.P.

END PROCEDURE.

PROCEDURE REIMPRIMIR_DOCUMENTO:

   RUN PRASIEMP.P (INPUT ROWID(T-Amp_header)).

END PROCEDURE.

&ENDIF

/*=================================================================================*/
/*                           F I N   D E   S E C C I O N                           */
/*=================================================================================*/

/*=================================================================================*/
/*                                                                                 */
/*                      C O M I E N Z O   D E   S E C C I O N                      */
/*                                                                                 */
/*                      PROCESO DE INICIALIZACION DEL PROGRAMA                     */
/*                                                                                 */
/*=================================================================================*/
/*                                                                                 */
&IF {&SECCION} = "LISTA_CAMPOS"
&THEN
/*                                                                                 */
/*---------------------------------------------------------------------------------*/


{&A-TABLA}Amp_header.anulado           = {&DE-TABLA}Amp_header.anulado
{&A-TABLA}Amp_header.entidades_validas = {&DE-TABLA}Amp_header.entidades_validas
{&A-TABLA}Amp_header.estado            = {&DE-TABLA}Amp_header.estado
{&A-TABLA}Amp_header.fecha             = {&DE-TABLA}Amp_header.fecha
{&A-TABLA}Amp_header.generado_por      = {&DE-TABLA}Amp_header.generado_por
{&A-TABLA}Amp_header.leyenda           = {&DE-TABLA}Amp_header.leyenda
{&A-TABLA}Amp_header.modo_importes     = {&DE-TABLA}Amp_header.modo_importes
{&A-TABLA}Amp_header.nro_comprob       = {&DE-TABLA}Amp_header.nro_comprob
{&A-TABLA}Amp_header.nro_modpsp        = {&DE-TABLA}Amp_header.nro_modpsp
{&A-TABLA}Amp_header.nro_usuario       = {&DE-TABLA}Amp_header.nro_usuario
{&A-TABLA}Amp_header.observacion       = {&DE-TABLA}Amp_header.observacion
{&A-TABLA}Amp_header.origen            = {&DE-TABLA}Amp_header.origen
{&A-TABLA}Amp_header.tip_comprob       = {&DE-TABLA}Amp_header.tip_comprob
{&A-TABLA}Amp_header.tot_creditos      = {&DE-TABLA}Amp_header.tot_creditos
{&A-TABLA}Amp_header.tot_creditos_div  = {&DE-TABLA}Amp_header.tot_creditos_div
{&A-TABLA}Amp_header.tot_debitos       = {&DE-TABLA}Amp_header.tot_debitos
{&A-TABLA}Amp_header.tot_debitos_div   = {&DE-TABLA}Amp_header.tot_debitos_div
{&A-TABLA}Amp_header.ultima_linea      = {&DE-TABLA}Amp_header.ultima_linea


&ENDIF

/*=================================================================================*/
/*                           F I N   D E   S E C C I O N                           */
/*=================================================================================*/