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

DEFINE OUTPUT PARAMETER p-fecha_retorno     LIKE Regreso_solicitud.fecha_retorno.
DEFINE OUTPUT PARAMETER p-modo_cumplimiento LIKE Regreso_solicitud.modo_cumplimiento.
DEFINE OUTPUT PARAMETER p-tip_comprob       LIKE Regreso_solicitud.tip_comprob.
DEFINE OUTPUT PARAMETER p-prf_comprob       LIKE Regreso_solicitud.prf_comprob.
DEFINE OUTPUT PARAMETER p-nro_comprob       LIKE Regreso_solicitud.nro_comprob.
DEFINE OUTPUT PARAMETER p-nro_ocm           LIKE Regreso_solicitud.nro_ocm.
DEFINE OUTPUT PARAMETER p-ok                AS LOGICAL.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE Dialog-Box
&Scoped-define DB-AWARE no

/* Name of first Frame and/or Browse and/or first Query                 */
&Scoped-define FRAME-NAME Dialog-Frame

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS v-fecha_retorno v-modo_cumplimiento ~
v-tip_comprob v-prf_comprob v-nro_comprob v-nro_ocm Btn_OK Btn_Cancel 
&Scoped-Define DISPLAYED-OBJECTS v-fecha_retorno v-modo_cumplimiento ~
v-tip_comprob v-prf_comprob v-nro_comprob v-nro_ocm 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME



/* ***********************  Control Definitions  ********************** */

/* Define a dialog box                                                  */

/* Definitions of the field level widgets                               */
DEFINE BUTTON Btn_Cancel AUTO-END-KEY 
     LABEL "&Cancelar" 
     SIZE 15 BY 1.67
     BGCOLOR 8 .

DEFINE BUTTON Btn_OK AUTO-GO 
     LABEL "&Aceptar" 
     SIZE 15 BY 1.67
     BGCOLOR 8 .

DEFINE VARIABLE v-fecha_retorno LIKE Regreso_solicitud.fecha_retorno
     VIEW-AS FILL-IN NATIVE 
     SIZE 16 BY 1
     BGCOLOR 15 FGCOLOR 9  NO-UNDO.

DEFINE VARIABLE v-nro_comprob LIKE Regreso_solicitud.nro_comprob
     VIEW-AS FILL-IN NATIVE 
     SIZE 23 BY 1
     BGCOLOR 15 FGCOLOR 9  NO-UNDO.

DEFINE VARIABLE v-nro_ocm LIKE Regreso_solicitud.nro_ocm
     VIEW-AS FILL-IN NATIVE 
     SIZE 42 BY 1
     BGCOLOR 15 FGCOLOR 9  NO-UNDO.

DEFINE VARIABLE v-prf_comprob LIKE Regreso_solicitud.prf_comprob
     VIEW-AS FILL-IN 
     SIZE 7.6 BY 1
     BGCOLOR 15 FGCOLOR 9  NO-UNDO.

DEFINE VARIABLE v-tip_comprob LIKE Regreso_solicitud.tip_comprob
     LABEL "Nro. Remito" 
     VIEW-AS FILL-IN 
     SIZE 8.6 BY 1
     BGCOLOR 15 FGCOLOR 9  NO-UNDO.

DEFINE VARIABLE v-modo_cumplimiento LIKE Regreso_solicitud.modo_cumplimiento
     VIEW-AS RADIO-SET HORIZONTAL
     RADIO-BUTTONS 
          "Cumplido", "C":U,
"Finalizado", "D":U
     SIZE 47 BY .95 NO-UNDO.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME Dialog-Frame
     v-fecha_retorno AT ROW 1.71 COL 13 COLON-ALIGNED
          BGCOLOR 15 FGCOLOR 9 
     v-modo_cumplimiento AT ROW 4.1 COL 12 NO-LABEL
     v-tip_comprob AT ROW 6.24 COL 15 COLON-ALIGNED
          LABEL "Nro. Remito"
          BGCOLOR 15 FGCOLOR 9 
     v-prf_comprob AT ROW 6.24 COL 25 COLON-ALIGNED NO-LABEL
          BGCOLOR 15 FGCOLOR 9 
     v-nro_comprob AT ROW 6.24 COL 34 COLON-ALIGNED NO-LABEL
          BGCOLOR 15 FGCOLOR 9 
     v-nro_ocm AT ROW 9.19 COL 15 COLON-ALIGNED
          BGCOLOR 15 FGCOLOR 9 
     Btn_OK AT ROW 11 COL 15
     Btn_Cancel AT ROW 11 COL 36
     "        Comprobante con el que se cumple la solicitud" VIEW-AS TEXT
          SIZE 55 BY .95 AT ROW 5.19 COL 4
          BGCOLOR 5 FGCOLOR 15 
     "        Orden de Compra con la que se relaciona el ingreso" VIEW-AS TEXT
          SIZE 55 BY .95 AT ROW 7.81 COL 4
          BGCOLOR 5 FGCOLOR 15 
     "                            Modo de cumplimiento" VIEW-AS TEXT
          SIZE 55 BY .95 AT ROW 3.14 COL 4
          BGCOLOR 5 FGCOLOR 15 
     SPACE(3.59) SKIP(8.95)
    WITH VIEW-AS DIALOG-BOX KEEP-TAB-ORDER 
         SIDE-LABELS NO-UNDERLINE THREE-D  SCROLLABLE 
         TITLE "Ingresar Parámetros"
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
                                                                        */
ASSIGN 
       FRAME Dialog-Frame:SCROLLABLE       = FALSE
       FRAME Dialog-Frame:HIDDEN           = TRUE.

/* SETTINGS FOR FILL-IN v-fecha_retorno IN FRAME Dialog-Frame
   LIKE = sic.Regreso_solicitud.fecha_retorno EXP-SIZE                  */
/* SETTINGS FOR RADIO-SET v-modo_cumplimiento IN FRAME Dialog-Frame
   LIKE = sic.Regreso_solicitud.modo_cumplimiento EXP-SIZE              */
/* SETTINGS FOR FILL-IN v-nro_comprob IN FRAME Dialog-Frame
   LIKE = sic.Regreso_solicitud.nro_comprob EXP-SIZE                    */
/* SETTINGS FOR FILL-IN v-nro_ocm IN FRAME Dialog-Frame
   LIKE = sic.Regreso_solicitud.nro_ocm EXP-SIZE                        */
/* SETTINGS FOR FILL-IN v-prf_comprob IN FRAME Dialog-Frame
   LIKE = sic.Regreso_solicitud.prf_comprob EXP-LABEL EXP-SIZE          */
/* SETTINGS FOR FILL-IN v-tip_comprob IN FRAME Dialog-Frame
   LIKE = sic.Regreso_solicitud.tip_comprob EXP-LABEL EXP-SIZE          */
/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME Dialog-Frame
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Dialog-Frame Dialog-Frame
ON WINDOW-CLOSE OF FRAME Dialog-Frame /* Ingresar Parámetros */
DO:
  APPLY "END-ERROR":U TO SELF.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME Btn_Cancel
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Btn_Cancel Dialog-Frame
ON CHOOSE OF Btn_Cancel IN FRAME Dialog-Frame /* Cancelar */
DO:
   p-ok = NO.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME Btn_OK
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Btn_OK Dialog-Frame
ON CHOOSE OF Btn_OK IN FRAME Dialog-Frame /* Aceptar */
DO:

  IF DATE(v-fecha_retorno:SCREEN-VALUE IN FRAME {&FRAME-NAME}) = DATE("")
        THEN v-fecha_retorno:SCREEN-VALUE IN FRAME {&FRAME-NAME} = STRING(TODAY).

    DO WITH FRAME {&FRAME-NAME}:

          ASSIGN
              v-fecha_retorno
              v-modo_cumplimiento
              v-tip_comprob
              v-prf_comprob
              v-nro_comprob
              v-nro_ocm.

          p-fecha_retorno     = v-fecha_retorno.
          p-modo_cumplimiento = v-modo_cumplimiento.
          p-tip_comprob       = v-tip_comprob.
          p-prf_comprob       = v-prf_comprob.
          p-nro_comprob       = v-nro_comprob.
          p-nro_ocm           = v-nro_ocm.
          p-ok = YES.
    END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME v-fecha_retorno
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-fecha_retorno Dialog-Frame
ON RETURN OF v-fecha_retorno IN FRAME Dialog-Frame /* Regresa el */
DO:
  IF DATE(v-fecha_retorno:SCREEN-VALUE IN FRAME {&FRAME-NAME}) = DATE("")
        THEN v-fecha_retorno:SCREEN-VALUE IN FRAME {&FRAME-NAME} = STRING(TODAY).
  
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
  DISPLAY v-fecha_retorno v-modo_cumplimiento v-tip_comprob v-prf_comprob 
          v-nro_comprob v-nro_ocm 
      WITH FRAME Dialog-Frame.
  ENABLE v-fecha_retorno v-modo_cumplimiento v-tip_comprob v-prf_comprob 
         v-nro_comprob v-nro_ocm Btn_OK Btn_Cancel 
      WITH FRAME Dialog-Frame.
  VIEW FRAME Dialog-Frame.
  {&OPEN-BROWSERS-IN-QUERY-Dialog-Frame}
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

