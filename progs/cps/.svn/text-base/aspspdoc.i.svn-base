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

DEFINE BUFFER B-Aps_detalle FOR Aps_detalle.

DEFINE BUTTON btn_elegir-modelo  
       LABEL "&Modelo":L 
       SIZE 10 BY 0.9 FONT 4.

DEFINE BUTTON btn_copiar-asiento  
       LABEL "&Copiar":L 
       SIZE 10 BY 0.9 FONT 4.

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
     Aps_header.tip_comprob COLON 12 LABEL "Asiento" FGCOLOR fe_c BGCOLOR be_c 
     Aps_header.nro_comprob NO-LABEL FGCOLOR fe_c BGCOLOR be_c
     Aps_header.fecha LABEL "Fec&ha" FGCOLOR fg_c BGCOLOR bg_c
     Aps_header.nro_secuencia FGCOLOR fg_c BGCOLOR bg_c LABEL "Nro."
     Aps_header.cdg_sigla-sic  FGCOLOR fg_c BGCOLOR bg_c LABEL "Gen."
     Aps_header.origen        FGCOLOR fg_c BGCOLOR bg_c LABEL "Org."
     SKIP(0.1)     
     Aps_header.leyenda      COLON 12 LABEL "&T¡tulo" FGCOLOR fe_c BGCOLOR be_c 
     btn_elegir-modelo
     btn_copiar-asiento
     SKIP(0.1)
     Ctapsp.cdg_ctapsp       COLON 12 LABEL "C&uenta" FGCOLOR fe_c BGCOLOR be_c
     Aps_header.tot_debitos  COLON 28 LABEL "Debe"    FGCOLOR fg_c BGCOLOR bg_c SPACE(2)
     Aps_header.tot_creditos          LABEL "Haber"   FGCOLOR fg_c BGCOLOR bg_c SPACE(3)
     aux_diferencia                   LABEL "Dif."    FGCOLOR fg_c BGCOLOR bg_c 
     SKIP
     Aps_header.tot_debitos_div  COLON 28 LABEL "D.Div."  FGCOLOR fg_c BGCOLOR bg_c 
     Aps_header.tot_creditos_div          LABEL "H.Div."  FGCOLOR fg_c BGCOLOR bg_c 
     aux_diferencia_div                   LABEL "Dif.D."  FGCOLOR fg_c BGCOLOR bg_c 
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

DEFINE SUB-MENU Tablas
   MENU-ITEM Ctapsps                LABEL "&Cuentas Controladoras".

DEFINE SUB-MENU Asientos
   MENU-ITEM Ingresos               LABEL "&Ingresos"
   MENU-ITEM Consultas              LABEL "&Consultas/Anulaciones".

DEFINE MENU  Principal MENUBAR
   SUB-MENU  Archivo                LABEL "&Archivo"
   SUB-MENU  Tablas                 LABEL "&Tablas"
   SUB-MENU  Asientos               LABEL "A&sientos".

{TRIGMENU.I "Ctapsps"      "Tablas"        "ACTCTAPS"  "(INPUT 0)"}

{TRIGMENU.I "Ingresos"     "Asientos"      "ABMAEAPS"  "(INPUT 0)" }
{TRIGMENU.I "Consultas"    "Asientos"      "ABMAEAPS"  "(INPUT 1)" }

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


ON LEAVE OF Aps_header.fecha IN FRAME frm-documento
DO:
   ASSIGN Aps_header.fecha.
   FOR EACH B-Aps_detalle OF Aps_header EXCLUSIVE-LOCK:
       B-Aps_detalle.fecha_mayor = Aps_header.fecha.
   END.    
END.      

ON LEAVE OF Aps_header.leyenda IN FRAME frm-documento
DO:
   ASSIGN Aps_header.leyenda.
END.      

/*                              Copiar un Asiento Modelo                           */ 

ON CHOOSE OF btn_elegir-modelo IN FRAME frm-documento
DO:
  RUN COPIAR_MODELO.
END.

/*                              Copiar un Asiento Existente                        */ 

ON CHOOSE OF btn_copiar-asiento IN FRAME frm-documento
DO:
  RUN COPIAR_ASIENTO.
END.

        /* -------------------- Ctapsp ------------*/

&SCOPED-DEFINE TABLA            Ctapsp
&SCOPED-DEFINE CODIGO           cdg_ctapsp
&SCOPED-DEFINE NOMBRE           nombre_cps
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



            IF Aps_header.tot_debitos <> Aps_header.tot_creditos 
            THEN DO:
               RUN PONMENSJ.P ( INPUT "ASIE010" ).
               NEXT Espera.
            END.

            
            IF Aps_header.tot_debitos_div <> Aps_header.tot_creditos_div
            THEN DO:
               RUN PONMENSJ.P ( INPUT "ASIE011" ).
               NEXT Espera.
            END.
               
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

   IF NOT NEW Aps_header
   THEN DO:
      act_aps_detl = ROWID(Aps_detalle).
      RUN ACUMCUEN.P ( INPUT "B" ).
   END.   

END PROCEDURE.

PROCEDURE SUMAR_RENGLON:

   IF NOT NEW Aps_header
   THEN DO:
      act_aps_detl = ROWID(Aps_detalle).
      RUN ACUMCUEN.P ( INPUT "A" ).
   END.   

END PROCEDURE.

PROCEDURE VALIDAR_DOCUMENTO:

  hubo_error = YES.

  IF ROWID(Aps_header) = ?
  THEN DO:
     RUN PONMENSJ.P (INPUT "ASIE007").
     RETURN.
  END.

  IF NOT CAN-FIND(FIRST Aps_detalle OF  Aps_header)
  THEN DO:
     RUN PONMENSJ.P (INPUT "ASIE005").
     RETURN.
  END.

  IF Aps_header.tot_debitos <> Aps_header.tot_creditos 
  THEN DO:
     RUN PONMENSJ ( INPUT "ASIE010" ).
     RETURN.
  END.

  IF Aps_header.tot_debitos_div <> Aps_header.tot_creditos_div
  THEN DO:
     RUN PONMENSJ.P ( INPUT "ASIE011" ).
     RETURN.
  END.

  hubo_error = NO.

END PROCEDURE.

PROCEDURE CALCULOS:

  IF Aps_header.ultima_linea = 0 THEN RETURN.

  {CALCASPS.I }

  DISPLAY Aps_header.tot_debitos     Aps_header.tot_creditos     aux_diferencia 
          Aps_header.tot_debitos_div Aps_header.tot_creditos_div aux_diferencia_div 
          WITH FRAME frm-documento.

END PROCEDURE.

PROCEDURE ASIGNAR_DETALLE:

  Aps_detalle.fecha_mayor = Aps_header.fecha.

END PROCEDURE.

PROCEDURE TRAER_DOCUMENTO:

   hay_error = YES.

   aux_diferencia     =  Aps_header.tot_debitos     - Aps_header.tot_creditos.
   aux_diferencia_div =  Aps_header.tot_debitos_div - Aps_header.tot_creditos_div.
   
   DISPLAY
        Aps_header.tip_comprob 
        Aps_header.nro_comprob 
        Aps_header.fecha 
        Aps_header.nro_secuencia
        Aps_header.cdg_sigla-sic
        Aps_header.origen
        Aps_header.leyenda
        Aps_header.tot_debitos 
        Aps_header.tot_creditos
        Aps_header.tot_debitos_div 
        Aps_header.tot_creditos_div
        aux_diferencia 
        aux_diferencia_div
        brw-detalle
        WITH FRAME frm-documento.
        
   OPEN QUERY qry-detalle FOR EACH Aps_detalle OF Aps_header,
                              EACH Ctapsp    OF Aps_detalle.

   ENABLE brw-detalle btn_OBSERV WITH FRAME frm-documento.
   IF Aps_header.origen <> "M" THEN DISABLE btn_GRABAR WITH FRAME frm-documento.
   hay_error = NO.
   act_aps_head = ROWID(Aps_header).
   APPLY "TAB" TO Aps_header.nro_comprob.

END PROCEDURE.

PROCEDURE ANULAR_DOCUMENTO:

   RUN NOESTA.P.

END PROCEDURE.

PROCEDURE REIMPRIMIR_DOCUMENTO:

   RUN PRASIEPS.P (INPUT ROWID(Aps_header)).

END PROCEDURE.

PROCEDURE COPIAR_MODELO:

  act_aps_head = ROWID(Aps_header).
  RUN ELEASMPS.P.
  RUN PONER_SESION.
  IF ult_amd_head <> ?
  THEN DO:
     RUN COPIAAMP.P.
     RUN TRAER_DOCUMENTO.
     RUN CALCULOS.
     DISABLE btn_elegir-modelo btn_copiar-asiento WITH  FRAME frm-documento.
  END.  
  
END PROCEDURE.

PROCEDURE COPIAR_ASIENTO:

  act_aps_head = ROWID(Aps_header).
  RUN COPASPSP.P ( INPUT "AP" ).
  RUN PONER_SESION.
  IF ult_aps_head <> ?
  THEN DO:
     RUN COPIAAPS.P.
     RUN TRAER_DOCUMENTO.
     RUN CALCULOS.
     DISABLE btn_elegir-modelo btn_copiar-asiento WITH  FRAME frm-documento.
  END.  
  
END PROCEDURE.

&ENDIF

/*=================================================================================*/
/*                           F I N   D E   S E C C I O N                           */
/*=================================================================================*/
