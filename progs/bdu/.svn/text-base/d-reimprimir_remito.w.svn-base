&ANALYZE-SUSPEND _VERSION-NUMBER UIB_v9r12 GUI
&ANALYZE-RESUME
/* Connected Databases 
          sic              PROGRESS
*/
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
DEFINE VARIABLE v-prox_docum AS CHARACTER.
DEFINE VARIABLE que_rutina AS CHARACTER.
DEFINE VARIABLE que_empresa AS CHARACTER.

{findempresa.i}

que_empresa = Empresa.cdg_empresa.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE Dialog-Box
&Scoped-define DB-AWARE no

/* Name of first Frame and/or Browse and/or first Query                 */
&Scoped-define FRAME-NAME Dialog-Frame

/* Internal Tables (found by Frame, Query & Browse Queries)             */
&Scoped-define INTERNAL-TABLES Tipo_puntovta

/* Definitions for DIALOG-BOX Dialog-Frame                              */
&Scoped-define QUERY-STRING-Dialog-Frame FOR EACH Tipo_puntovta ~
      WHERE Tipo_puntovta.cdg_comprobante = "REMPRBDU" ~
 AND Tipo_puntovta.cdg_empresa = que_empresa ~
 AND Tipo_puntovta.preferido = TRUE SHARE-LOCK
&Scoped-define OPEN-QUERY-Dialog-Frame OPEN QUERY Dialog-Frame FOR EACH Tipo_puntovta ~
      WHERE Tipo_puntovta.cdg_comprobante = "REMPRBDU" ~
 AND Tipo_puntovta.cdg_empresa = que_empresa ~
 AND Tipo_puntovta.preferido = TRUE SHARE-LOCK.
&Scoped-define TABLES-IN-QUERY-Dialog-Frame Tipo_puntovta
&Scoped-define FIRST-TABLE-IN-QUERY-Dialog-Frame Tipo_puntovta


/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS v-prf_comprob v-nro_comprob v-tip_comprob ~
btn_imprimir Btn_Cancel 
&Scoped-Define DISPLAYED-OBJECTS v-prf_comprob v-nro_comprob v-tip_comprob 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME



/* ***********************  Control Definitions  ********************** */

/* Define a dialog box                                                  */

/* Menu Definitions                                                     */
DEFINE MENU POPUP-MENU-v-tip_comprob 
       MENU-ITEM m_RM           LABEL "RM"            .


/* Definitions of the field level widgets                               */
DEFINE BUTTON Btn_Cancel AUTO-END-KEY 
     LABEL "Salir" 
     SIZE 15 BY 1.14
     BGCOLOR 8 .

DEFINE BUTTON btn_imprimir 
     LABEL "Imprimir" 
     SIZE 15 BY 1.14.

DEFINE VARIABLE v-nro_comprob AS INTEGER FORMAT "99999999":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 13 BY 1
     BGCOLOR 14 FGCOLOR 9 FONT 6 NO-UNDO.

DEFINE VARIABLE v-prf_comprob AS INTEGER FORMAT "9999":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 9 BY 1
     BGCOLOR 14 FGCOLOR 9 FONT 6 NO-UNDO.

DEFINE VARIABLE v-tip_comprob AS CHARACTER FORMAT "X(256)":U INITIAL "RM" 
     LABEL "Remito" 
     VIEW-AS FILL-IN 
     SIZE 8 BY 1
     BGCOLOR 14 FGCOLOR 9 FONT 6 NO-UNDO.

/* Query definitions                                                    */
&ANALYZE-SUSPEND
DEFINE QUERY Dialog-Frame FOR 
      Tipo_puntovta SCROLLING.
&ANALYZE-RESUME

/* ************************  Frame Definitions  *********************** */

DEFINE FRAME Dialog-Frame
     v-prf_comprob AT ROW 2.14 COL 20.6 COLON-ALIGNED NO-LABEL
     v-nro_comprob AT ROW 2.14 COL 31 COLON-ALIGNED NO-LABEL
     v-tip_comprob AT ROW 2.19 COL 11 COLON-ALIGNED
     btn_imprimir AT ROW 4.33 COL 13
     Btn_Cancel AT ROW 4.33 COL 31
     SPACE(9.19) SKIP(1.28)
    WITH VIEW-AS DIALOG-BOX KEEP-TAB-ORDER 
         SIDE-LABELS NO-UNDERLINE THREE-D  SCROLLABLE 
         TITLE "Reimpresión de Remitos"
         CANCEL-BUTTON Btn_Cancel.


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
                                                                        */
ASSIGN 
       FRAME Dialog-Frame:SCROLLABLE       = FALSE
       FRAME Dialog-Frame:HIDDEN           = TRUE.

ASSIGN 
       v-tip_comprob:POPUP-MENU IN FRAME Dialog-Frame       = MENU POPUP-MENU-v-tip_comprob:HANDLE.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME


/* Setting information for Queries and Browse Widgets fields            */

&ANALYZE-SUSPEND _QUERY-BLOCK DIALOG-BOX Dialog-Frame
/* Query rebuild information for DIALOG-BOX Dialog-Frame
     _TblList          = "sic.Tipo_puntovta"
     _Options          = "SHARE-LOCK"
     _Where[1]         = "Tipo_puntovta.cdg_comprobante = ""REMPRBDU""
 AND Tipo_puntovta.cdg_empresa = que_empresa
 AND Tipo_puntovta.preferido = TRUE"
     _Query            is OPENED
*/  /* DIALOG-BOX Dialog-Frame */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME Dialog-Frame
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Dialog-Frame Dialog-Frame
ON ENTRY OF FRAME Dialog-Frame /* Reimpresión de Remitos */
DO:
/*     FIND FIRST Tipo_puntovta NO-LOCK NO-ERROR.  */
       v-prf_comprob:SCREEN-VALUE IN FRAME {&FRAME-NAME} = STRING(Tipo_puntovta.cdg_puntovta).
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Dialog-Frame Dialog-Frame
ON WINDOW-CLOSE OF FRAME Dialog-Frame /* Reimpresión de Remitos */
DO:
  APPLY "END-ERROR":U TO SELF.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btn_imprimir
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btn_imprimir Dialog-Frame
ON CHOOSE OF btn_imprimir IN FRAME Dialog-Frame /* Imprimir */
DO:
  
    ASSIGN FRAME {&FRAME-NAME} v-tip_comprob v-prf_comprob v-nro_comprob.
    {findempresa.i}

    FIND Rem_header_prv 
         WHERE Rem_header_prv.tip_comprob = v-tip_comprob
           AND Rem_header_prv.prf_comprob = v-prf_comprob
           AND Rem_header_prv.nro_comprob = v-nro_comprob
           AND Rem_header_prv.cdg_empresa = Empresa.cdg_empresa
               NO-LOCK NO-ERROR.
        
    IF AVAILABLE Rem_header_prv THEN DO:
        FIND Tipocomprobante OF Rem_header_prv NO-LOCK NO-ERROR.
            IF AVAILABLE Tipocomprobante THEN DO:
            v-prox_docum = Tipocomprobante.prefijo_formulario. 
            END.
        FIND Parametro WHERE Parametro.cdg_parametro = v-prox_docum 
                       AND Parametro.cdg_empresa   = Rem_header_prv.cdg_empresa 
                       EXCLUSIVE-LOCK NO-ERROR.          
            IF AVAILABLE Parametro THEN DO:
                que_rutina = Tipocomprobante.prefijo_programa + STRING(Parametro.valor_n, "999") + ".p".
                RUN value(que_rutina) ( input rowid(Rem_header_prv)).
            END.

    END.
   
    ELSE DO:
             FIND Rem_header 
             WHERE Rem_header.tip_comprob = v-tip_comprob
               AND Rem_header.prf_comprob = v-prf_comprob
               AND Rem_header.nro_comprob = v-nro_comprob
               AND Rem_header.cdg_empresa = Empresa.cdg_empresa
                   NO-LOCK NO-ERROR.

            IF AVAILABLE Rem_header THEN DO:
                
                FIND Tipocomprobante OF Rem_header NO-LOCK NO-ERROR.
                    IF AVAILABLE Tipocomprobante THEN DO:
                    v-prox_docum = Tipocomprobante.prefijo_formulario. 
                    END.
                FIND Parametro WHERE Parametro.cdg_parametro = v-prox_docum 
                               AND Parametro.cdg_empresa   = Rem_header.cdg_empresa 
                               EXCLUSIVE-LOCK NO-ERROR.          
                    IF AVAILABLE Parametro THEN DO:
                        que_rutina = Tipocomprobante.prefijo_programa + STRING(Parametro.valor_n, "999") + ".p".
                        RUN value(que_rutina) ( input rowid(Rem_header)).
                   END.
          END.
           
               
        ELSE DO:
                FIND Transdep_hd
                 WHERE Transdep_hd.tip_comprob = v-tip_comprob
                   AND Transdep_hd.prf_comprob = v-prf_comprob
                   AND Transdep_hd.nro_comprob = v-nro_comprob
                   AND Transdep_hd.cdg_empresa = Empresa.cdg_empresa
                       NO-LOCK NO-ERROR.

                IF AVAILABLE Transdep_hd THEN DO:
                    FIND Tipocomprobante OF Transdep_hd NO-LOCK NO-ERROR.
                         IF AVAILABLE Tipocomprobante THEN DO:
                         v-prox_docum = Tipocomprobante.prefijo_formulario. 
                         END.
                    FIND Parametro WHERE Parametro.cdg_parametro = v-prox_docum 
                                   AND Parametro.cdg_empresa   = Transdep_hd.cdg_empresa 
                                   EXCLUSIVE-LOCK NO-ERROR.          
                         IF AVAILABLE Parametro THEN DO:
                            que_rutina = Tipocomprobante.prefijo_programa + STRING(Parametro.valor_n, "999") + ".p".
                            RUN value(que_rutina) ( input rowid(Transdep_hd)).
                         END.

               END.
 
    ELSE DO:
        RUN ponmensj.p ( INPUT "REMI025" ).
        RETURN NO-APPLY.
            END.
         END.

    END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME v-prf_comprob
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

  {&OPEN-QUERY-Dialog-Frame}
  GET FIRST Dialog-Frame.
  DISPLAY v-prf_comprob v-nro_comprob v-tip_comprob 
      WITH FRAME Dialog-Frame.
  ENABLE v-prf_comprob v-nro_comprob v-tip_comprob btn_imprimir Btn_Cancel 
      WITH FRAME Dialog-Frame.
  VIEW FRAME Dialog-Frame.
  {&OPEN-BROWSERS-IN-QUERY-Dialog-Frame}
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

