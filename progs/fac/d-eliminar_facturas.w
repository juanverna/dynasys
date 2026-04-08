&ANALYZE-SUSPEND _VERSION-NUMBER UIB_v9r12 GUI
&ANALYZE-RESUME
&Scoped-define WINDOW-NAME CURRENT-WINDOW
&Scoped-define FRAME-NAME Dialog-Frame
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _DEFINITIONS Dialog-Frame 
/*------------------------------------------------------------------------

  File: 

  Description: 

  Input Parameters:
      <none>

  Output Parameters:
      <none>

  Author: 

  Created: 
------------------------------------------------------------------------*/
/*          This .W file was created with the Progress AppBuilder.       */
/*----------------------------------------------------------------------*/

/* ***************************  Definitions  ************************** */

/* Parameters Definitions ---                                           */

/* Local Variable Definitions ---                                       */

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE Dialog-Box
&Scoped-define DB-AWARE no

/* Name of designated FRAME-NAME and/or first browse and/or first query */
&Scoped-define FRAME-NAME Dialog-Frame

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS RECT-1 v-tip_comprob v-prf_comprob ~
v-des_nro_comprob v-has_nro_comprob Btn_OK Btn_Cancel 
&Scoped-Define DISPLAYED-OBJECTS v-tip_comprob v-prf_comprob ~
v-des_nro_comprob v-has_nro_comprob 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME



/* ***********************  Control Definitions  ********************** */

/* Define a dialog box                                                  */

/* Definitions of the field level widgets                               */
DEFINE BUTTON Btn_Cancel AUTO-END-KEY 
     LABEL "Cancel" 
     SIZE 22 BY 1.14
     BGCOLOR 8 .

DEFINE BUTTON Btn_OK AUTO-GO 
     LABEL "&Hacer" 
     SIZE 22 BY 1.14
     BGCOLOR 8 .

DEFINE VARIABLE v-des_nro_comprob AS INTEGER FORMAT ">>>>>>>9":U INITIAL 0 
     LABEL "Desde Número" 
     VIEW-AS FILL-IN 
     SIZE 18 BY 1
     BGCOLOR 15 FGCOLOR 9  NO-UNDO.

DEFINE VARIABLE v-has_nro_comprob AS INTEGER FORMAT ">>>>>>>9":U INITIAL 0 
     LABEL "Hasta Número" 
     VIEW-AS FILL-IN 
     SIZE 18 BY 1
     BGCOLOR 15 FGCOLOR 9  NO-UNDO.

DEFINE VARIABLE v-prf_comprob AS INTEGER FORMAT ">>>9":U INITIAL 0 
     LABEL "Prefijo" 
     VIEW-AS FILL-IN 
     SIZE 9 BY 1
     BGCOLOR 15 FGCOLOR 9  NO-UNDO.

DEFINE VARIABLE v-tip_comprob AS CHARACTER FORMAT "X(2)":U 
     LABEL "Tipo" 
     VIEW-AS FILL-IN 
     SIZE 7 BY 1
     BGCOLOR 15 FGCOLOR 9  NO-UNDO.

DEFINE RECTANGLE RECT-1
     EDGE-PIXELS 6 GRAPHIC-EDGE  NO-FILL   
     SIZE 83 BY 4.05.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME Dialog-Frame
     v-tip_comprob AT ROW 1.95 COL 24 COLON-ALIGNED
     v-prf_comprob AT ROW 1.95 COL 62 COLON-ALIGNED
     v-des_nro_comprob AT ROW 3.38 COL 24 COLON-ALIGNED
     v-has_nro_comprob AT ROW 3.38 COL 62 COLON-ALIGNED
     Btn_OK AT ROW 5.52 COL 3
     Btn_Cancel AT ROW 5.52 COL 64
     RECT-1 AT ROW 1.24 COL 3
     SPACE(1.59) SKIP(1.70)
    WITH VIEW-AS DIALOG-BOX KEEP-TAB-ORDER 
         SIDE-LABELS NO-UNDERLINE THREE-D  SCROLLABLE 
         TITLE "Eliminar Facturas de Venta"
         DEFAULT-BUTTON Btn_OK CANCEL-BUTTON Btn_Cancel.


/* *********************** Procedure Settings ************************ */

&ANALYZE-SUSPEND _PROCEDURE-SETTINGS
/* Settings for THIS-PROCEDURE
   Type: Dialog-Box
   Allow: Basic,Browse,DB-Fields,Query
   Other Settings: COMPILE
 */
&ANALYZE-RESUME _END-PROCEDURE-SETTINGS



/* ***********  Runtime Attributes and AppBuilder Settings  *********** */

&ANALYZE-SUSPEND _RUN-TIME-ATTRIBUTES
/* SETTINGS FOR DIALOG-BOX Dialog-Frame
   FRAME-NAME                                                           */
ASSIGN 
       FRAME Dialog-Frame:SCROLLABLE       = FALSE
       FRAME Dialog-Frame:HIDDEN           = TRUE.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME Dialog-Frame
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Dialog-Frame Dialog-Frame
ON WINDOW-CLOSE OF FRAME Dialog-Frame /* Eliminar Facturas de Venta */
DO:
  APPLY "END-ERROR":U TO SELF.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME Btn_OK
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Btn_OK Dialog-Frame
ON CHOOSE OF Btn_OK IN FRAME Dialog-Frame /* Hacer */
DO:
    DEFINE VARIABLE v-prox_docum AS CHARACTER.
    DEFINE VARIABLE sino AS LOGICAL.

    sino = YES.
    MESSAGE "Confirma que desea eliminar el número del comprobante indicado"
       VIEW-AS ALERT-BOX QUESTION BUTTONS YES-NO UPDATE sino.
    IF sino 
    THEN DO:

        {findempresa.i}

        ASSIGN FRAME {&FRAME-NAME}
                     v-tip_comprob  
                     v-prf_comprob  
                     v-des_nro_comprob  
                     v-has_nro_comprob.

        DO TRANSACTION:

            FOR EACH Fac_header 
               WHERE Fac_header.cdg_empresa = Empresa.cdg_empresa
                 AND Fac_header.tip_comprob = v-tip_comprob
                 AND Fac_header.prf_comprob = v-prf_comprob
                 AND Fac_header.nro_comprob >= v-des_nro_comprob
                 AND Fac_header.nro_comprob <= v-has_nro_comprob 
                 AND fac_header.cai = ""
                     EXCLUSIVE-LOCK:
                 IF fac_header.nro_contrato <> 0  THEN DO:
                     FIND contrato_hd WHERE contrato_hd.nro_contrato = fac_header.nro_contrato no-error.
                     IF AVAILABLE contrato_hd THEN DO:
                         IF contrato_hd.cant_periodos <> 0 THEN
                             contrato_hd.resto_periodos = contrato_hd.resto_periodos + 1.
                     END.
                 END.
                 FOR EACH Fac_detalle OF Fac_header EXCLUSIVE-LOCK:
                     DELETE Fac_detalle.
                 END.

                 FOR EACH Sub_header_vta
                     WHERE Sub_header_vta.cdg_empresa = Fac_header.cdg_empresa
                       AND Sub_header_vta.tip_comprob = Fac_header.tip_comprob
                       AND Sub_header_vta.prf_comprob = Fac_header.prf_comprob
                       AND Sub_header_vta.nro_comprob = Fac_header.nro_comprob 
                           EXCLUSIVE-LOCK:

                     DELETE Sub_header_vta.

                 END.    

                 FOR EACH Sub_detalle_vta
                     WHERE Sub_detalle_vta.cdg_empresa = Fac_header.cdg_empresa
                       AND Sub_detalle_vta.tip_comprob = Fac_header.tip_comprob
                       AND Sub_detalle_vta.prf_comprob = Fac_header.prf_comprob
                       AND Sub_detalle_vta.nro_comprob = Fac_header.nro_comprob 
                           EXCLUSIVE-LOCK:

                     DELETE Sub_detalle_vta.

                 END.    

                 FOR EACH Sub_header_inv
                     WHERE Sub_header_inv.cdg_empresa = Fac_header.cdg_empresa
                       AND Sub_header_inv.tip_comprob = Fac_header.tip_comprob
                       AND Sub_header_inv.prf_comprob = Fac_header.prf_comprob
                       AND Sub_header_inv.nro_comprob = Fac_header.nro_comprob
                           EXCLUSIVE-LOCK:

                     DELETE Sub_header_inv.

                 END.    

                 FOR EACH Sub_detalle_inv
                     WHERE Sub_detalle_inv.cdg_empresa = Fac_header.cdg_empresa
                       AND Sub_detalle_inv.tip_comprob = Fac_header.tip_comprob
                       AND Sub_detalle_inv.prf_comprob = Fac_header.prf_comprob
                       AND Sub_detalle_inv.nro_comprob = Fac_header.nro_comprob
                           EXCLUSIVE-LOCK:

                     DELETE Sub_detalle_inv.

                 END.    
                 FOR EACH Cta_cte
                       WHERE Cta_cte.cdg_empresa = Fac_header.cdg_empresa
                         AND Cta_cte.tip_comprob = Fac_header.tip_comprob
                         AND Cta_cte.prf_comprob = Fac_header.prf_comprob
                         AND Cta_cte.nro_comprob = Fac_header.nro_comprob
                             EXCLUSIVE-LOCK:

                     DELETE Cta_cte.

                 END. 

                 FOR EACH cct_stock 
                       WHERE cct_stock.cdg_empresa = Fac_header.cdg_empresa
                         AND cct_stock.tip_comprob = Fac_header.tip_comprob 
                         AND cct_stock.prf_comprob = Fac_header.prf_comprob 
                         AND cct_stock.nro_comprob = Fac_header.nro_comprob
                             EXCLUSIVE-LOCK:

                       DELETE Cct_stock.

                 END.

                 FIND Tipocomprobante of fac_header NO-LOCK NO-ERROR.
                 FIND Condicion_impos OF Fac_header NO-LOCK NO-ERROR.
                 IF NOT AVAILABLE TIPOCOMPROBANTE OR NOT AVAILABLE CONDICION_IMPOS  THEN
                 DO:
                     MESSAGE "NO SE ENCUENTRA EL TIPOCOMPROBANTE ASOCIADO" SKIP
                         "Verifique los contadores manualmente antes de volver a facturar"
                         VIEW-AS ALERT-BOX INFORMATION.

                 END.
                 ELSE DO:
                                 IF Tipocomprobante.autonumerado
                 THEN DO:

                     v-prox_docum = Tipocomprobante.prefijo_contador + STRING(Fac_header.prf_comprob,"9999").
                     Fac_header.tip_comprob =  Tipocomprobante.tip_comprob.    
                     IF Tipocomprobante.usa_letra
                     THEN DO:
                         v-prox_docum = REPLACE(v-prox_docum,"*",Condicion_impos.tipo_factura).
                         Fac_header.tip_comprob = REPLACE(Fac_header.tip_comprob,"*",Condicion_impos.tipo_factura).
                     END.

                     FIND Parametro WHERE Parametro.cdg_parametro = v-prox_docum 
                                      AND Parametro.cdg_empresa   = Fac_header.cdg_empresa 
                                          EXCLUSIVE-LOCK NO-ERROR.
                     IF AVAILABLE parametro THEN 
                         ASSIGN Parametro.valor_n = v-des_nro_comprob.
                     ELSE DO:
                         MESSAGE "No puedo actualizar el parametro "  v-prox_docum SKIP
                                 "actualize manualmente al numero " v-des_nro_comprob VIEW-AS ALERT-BOX INFORMATION.
                     END.

                                  END.
                 END.

                 

                 DELETE Fac_header.

            END.      

            MESSAGE "TERMINADO"
                 VIEW-AS ALERT-BOX INFORMATION.

        END.

    END. 
    ELSE DO:
        MESSAGE "CANCELADO"
           VIEW-AS ALERT-BOX ERROR.
    END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&UNDEFINE SELF-NAME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _MAIN-BLOCK Dialog-Frame 


/* ***************************  Main Block  *************************** */

/* Parent the dialog-box to the ACTIVE-WINDOW, if there is no parent.   */
IF VALID-HANDLE(ACTIVE-WINDOW) AND FRAME {&FRAME-NAME}:PARENT eq ?
THEN FRAME {&FRAME-NAME}:PARENT = ACTIVE-WINDOW.


/* Now enable the interface and wait for the exit condition.            */
/* (NOTE: handle ERROR and END-KEY so cleanup code will always fire.    */
MAIN-BLOCK:
DO ON ERROR   UNDO MAIN-BLOCK, LEAVE MAIN-BLOCK
   ON END-KEY UNDO MAIN-BLOCK, LEAVE MAIN-BLOCK:
  RUN enable_UI.
  WAIT-FOR GO OF FRAME {&FRAME-NAME}.
END.
RUN disable_UI.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


/* **********************  Internal Procedures  *********************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE disable_UI Dialog-Frame  _DEFAULT-DISABLE
PROCEDURE disable_UI :
/*------------------------------------------------------------------------------
  Purpose:     DISABLE the User Interface
  Parameters:  <none>
  Notes:       Here we clean-up the user-interface by deleting
               dynamic widgets we have created and/or hide 
               frames.  This procedure is usually called when
               we are ready to "clean-up" after running.
------------------------------------------------------------------------------*/
  /* Hide all frames. */
  HIDE FRAME Dialog-Frame.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE enable_UI Dialog-Frame  _DEFAULT-ENABLE
PROCEDURE enable_UI :
/*------------------------------------------------------------------------------
  Purpose:     ENABLE the User Interface
  Parameters:  <none>
  Notes:       Here we display/view/enable the widgets in the
               user-interface.  In addition, OPEN all queries
               associated with each FRAME and BROWSE.
               These statements here are based on the "Other 
               Settings" section of the widget Property Sheets.
------------------------------------------------------------------------------*/
  DISPLAY v-tip_comprob v-prf_comprob v-des_nro_comprob v-has_nro_comprob 
      WITH FRAME Dialog-Frame.
  ENABLE RECT-1 v-tip_comprob v-prf_comprob v-des_nro_comprob v-has_nro_comprob 
         Btn_OK Btn_Cancel 
      WITH FRAME Dialog-Frame.
  VIEW FRAME Dialog-Frame.
  {&OPEN-BROWSERS-IN-QUERY-Dialog-Frame}
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

