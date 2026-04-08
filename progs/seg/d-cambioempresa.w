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

  &IF DEFINED(UIB_is_Running) NE 0
  &THEN
  DEFINE VARIABLE p-ok                      AS LOGICAL.
  &ELSE
  DEFINE OUTPUT PARAMETER p-ok              AS LOGICAL.   
  &ENDIF

/* Local Variable Definitions ---                                       */

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE Dialog-Box
&Scoped-define DB-AWARE no

/* Name of first Frame and/or Browse and/or first Query                 */
&Scoped-define FRAME-NAME Dialog-Frame

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS v-cdg_empresa btn_ok btn_cancel RECT-2 
&Scoped-Define DISPLAYED-OBJECTS v-cdg_empresa v-dsc_empresa 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME



/* ***********************  Control Definitions  ********************** */

/* Define a dialog box                                                  */

/* Definitions of the field level widgets                               */
DEFINE BUTTON btn_cancel 
     LABEL "&Cancelar" 
     SIZE 15 BY 1.14.

DEFINE BUTTON btn_ok 
     LABEL "&Ok" 
     SIZE 15 BY 1.14.

DEFINE VARIABLE v-cdg_empresa AS CHARACTER FORMAT "X(256)":U 
     LABEL "Empresa" 
     VIEW-AS FILL-IN 
     SIZE 10 BY 1
     BGCOLOR 15 FGCOLOR 9  NO-UNDO.

DEFINE VARIABLE v-dsc_empresa AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 32 BY 1
     BGCOLOR 7 FGCOLOR 15  NO-UNDO.

DEFINE RECTANGLE RECT-2
     EDGE-PIXELS 6 GRAPHIC-EDGE  NO-FILL 
     SIZE 59 BY 4.29.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME Dialog-Frame
     v-cdg_empresa AT ROW 2.43 COL 14 COLON-ALIGNED
     v-dsc_empresa AT ROW 2.43 COL 25 COLON-ALIGNED NO-LABEL
     btn_ok AT ROW 3.86 COL 6
     btn_cancel AT ROW 3.86 COL 44
     RECT-2 AT ROW 1.48 COL 3
     SPACE(2.19) SKIP(0.51)
    WITH VIEW-AS DIALOG-BOX KEEP-TAB-ORDER 
         SIDE-LABELS NO-UNDERLINE THREE-D  SCROLLABLE 
         TITLE "Cambio de Empresa".


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

/* SETTINGS FOR FILL-IN v-dsc_empresa IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME Dialog-Frame
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Dialog-Frame Dialog-Frame
ON WINDOW-CLOSE OF FRAME Dialog-Frame /* Cambio de Empresa */
DO:
  APPLY "END-ERROR":U TO SELF.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btn_cancel
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btn_cancel Dialog-Frame
ON CHOOSE OF btn_cancel IN FRAME Dialog-Frame /* Cancelar */
DO:
    p-ok = NO.
    APPLY "U1" TO FRAME {&FRAME-NAME}.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btn_ok
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btn_ok Dialog-Frame
ON CHOOSE OF btn_ok IN FRAME Dialog-Frame /* Ok */
DO:
  
  ASSIGN FRAME {&FRAME-NAME} v-cdg_empresa.
  FIND Empresa WHERE Empresa.cdg_empresa = v-cdg_empresa NO-LOCK NO-ERROR.
  IF NOT AVAILABLE Empresa 
  THEN DO:
       MESSAGE "No existe la Empresa indicada" VIEW-AS ALERT-BOX ERROR.
       RETURN NO-APPLY.
  END.
  ELSE DO:
       v-dsc_empresa = Empresa.nombre.
       DISPLAY v-dsc_empresa WITH FRAME {&FRAME-NAME}.
       FIND Usuario WHERE Usuario.cdg_usuario = USERID("sic") NO-LOCK.
       IF CAN-DO(Usuario.lista_empresas,Empresa.cdg_empresa)
       THEN DO:
           DO TRANSACTION:
              FIND CURRENT Usuario EXCLUSIVE-LOCK.                 
              Usuario.cdg_empresa = Empresa.cdg_empresa.
              RELEASE Usuario.
              p-ok = YES.
              APPLY "U1" TO FRAME {&FRAME-NAME}.
           END.
       END.
       ELSE DO:
            MESSAGE "El usuario no ya se halla habilitado para conectarse a la emporesa indicada" 
                    VIEW-AS ALERT-BOX ERROR.
            RETURN NO-APPLY.
       END.   
  END.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME v-cdg_empresa
&Scoped-define SELF-NAME v-dsc_empresa
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-dsc_empresa Dialog-Frame
ON RETURN OF v-dsc_empresa IN FRAME Dialog-Frame
DO:
  APPLY "CHOOSE" TO btn_ok.
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
  WAIT-FOR "U1" OF FRAME {&FRAME-NAME}.
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
  DISPLAY v-cdg_empresa v-dsc_empresa 
      WITH FRAME Dialog-Frame.
  ENABLE v-cdg_empresa btn_ok btn_cancel RECT-2 
      WITH FRAME Dialog-Frame.
  VIEW FRAME Dialog-Frame.
  {&OPEN-BROWSERS-IN-QUERY-Dialog-Frame}
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

