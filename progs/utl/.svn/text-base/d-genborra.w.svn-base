&ANALYZE-SUSPEND _VERSION-NUMBER UIB_v8r12 GUI
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
/*          This .W file was created with the Progress UIB.             */
/*----------------------------------------------------------------------*/

/* ***************************  Definitions  ************************** */

/* Parameters Definitions ---                                           */

/* Local Variable Definitions ---                                       */

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE DIALOG-BOX

/* Name of first Frame and/or Browse and/or first Query                 */
&Scoped-define FRAME-NAME Dialog-Frame

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS dir_instal que_salida v-aba v-bas v-adp ~
v-cps v-cxc v-gla v-cxp v-seg v-dsp v-vnd v-fac v-afi v-com v-prd v-tes ~
v-exp v-inv v-imp tipo_tabla Btn_OK Btn_Cancel 
&Scoped-Define DISPLAYED-OBJECTS dir_instal que_salida v-aba v-bas v-adp ~
v-cps v-cxc v-gla v-cxp v-seg v-dsp v-vnd v-fac v-afi v-com v-prd v-tes ~
v-exp v-inv v-imp tipo_tabla 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME



/* ***********************  Control Definitions  ********************** */

/* Define a dialog box                                                  */

/* Definitions of the field level widgets                               */
DEFINE BUTTON Btn_Cancel AUTO-END-KEY 
     LABEL "Cancel" 
     SIZE 15 BY 1.15
     BGCOLOR 8 .

DEFINE BUTTON Btn_OK AUTO-GO 
     LABEL "OK" 
     SIZE 15 BY 1.15
     BGCOLOR 8 .

DEFINE VARIABLE dir_instal AS CHARACTER FORMAT "X(256)":U 
     LABEL "Instalación" 
     VIEW-AS FILL-IN 
     SIZE 71 BY 1 NO-UNDO.

DEFINE VARIABLE que_salida AS CHARACTER FORMAT "X(256)":U 
     LABEL "Salida" 
     VIEW-AS FILL-IN 
     SIZE 71 BY 1 NO-UNDO.

DEFINE VARIABLE tipo_tabla AS INTEGER 
     VIEW-AS RADIO-SET HORIZONTAL
     RADIO-BUTTONS 
          "Sistema", 1,
"Maestros", 2,
"Transacciones", 3
     SIZE 44 BY 1.08 NO-UNDO.

DEFINE VARIABLE v-aba AS LOGICAL INITIAL no 
     LABEL "ABA - Abastecimientos" 
     VIEW-AS TOGGLE-BOX
     SIZE 33 BY .77 NO-UNDO.

DEFINE VARIABLE v-adp AS LOGICAL INITIAL no 
     LABEL "ADP - Administración de Personal" 
     VIEW-AS TOGGLE-BOX
     SIZE 33 BY .77 NO-UNDO.

DEFINE VARIABLE v-afi AS LOGICAL INITIAL no 
     LABEL "AFI - Afiliados" 
     VIEW-AS TOGGLE-BOX
     SIZE 33 BY .77 NO-UNDO.

DEFINE VARIABLE v-bas AS LOGICAL INITIAL no 
     LABEL "BAS - Módulo Básico" 
     VIEW-AS TOGGLE-BOX
     SIZE 33 BY .77 NO-UNDO.

DEFINE VARIABLE v-com AS LOGICAL INITIAL no 
     LABEL "COM - Compras" 
     VIEW-AS TOGGLE-BOX
     SIZE 33 BY .77 NO-UNDO.

DEFINE VARIABLE v-cps AS LOGICAL INITIAL no 
     LABEL "CPS - Control Presupuestario" 
     VIEW-AS TOGGLE-BOX
     SIZE 33 BY .77 NO-UNDO.

DEFINE VARIABLE v-cxc AS LOGICAL INITIAL no 
     LABEL "CXC - Cuentas por Cobrar" 
     VIEW-AS TOGGLE-BOX
     SIZE 33 BY .77 NO-UNDO.

DEFINE VARIABLE v-cxp AS LOGICAL INITIAL no 
     LABEL "CXP - Cuentas por Pagar" 
     VIEW-AS TOGGLE-BOX
     SIZE 33 BY .77 NO-UNDO.

DEFINE VARIABLE v-dsp AS LOGICAL INITIAL no 
     LABEL "DSP - Despacho de Mercaderías" 
     VIEW-AS TOGGLE-BOX
     SIZE 33 BY .77 NO-UNDO.

DEFINE VARIABLE v-exp AS LOGICAL INITIAL no 
     LABEL "EXP - Exportaciones" 
     VIEW-AS TOGGLE-BOX
     SIZE 33 BY .77 NO-UNDO.

DEFINE VARIABLE v-fac AS LOGICAL INITIAL no 
     LABEL "FAC - Facturación" 
     VIEW-AS TOGGLE-BOX
     SIZE 33 BY .77 NO-UNDO.

DEFINE VARIABLE v-gla AS LOGICAL INITIAL no 
     LABEL "GLA - Contabilidad General" 
     VIEW-AS TOGGLE-BOX
     SIZE 33 BY .77 NO-UNDO.

DEFINE VARIABLE v-imp AS LOGICAL INITIAL no 
     LABEL "IMP - Importaciones" 
     VIEW-AS TOGGLE-BOX
     SIZE 33 BY .77 NO-UNDO.

DEFINE VARIABLE v-inv AS LOGICAL INITIAL no 
     LABEL "INV - Inventario" 
     VIEW-AS TOGGLE-BOX
     SIZE 33 BY .77 NO-UNDO.

DEFINE VARIABLE v-prd AS LOGICAL INITIAL no 
     LABEL "PRD - Producción" 
     VIEW-AS TOGGLE-BOX
     SIZE 33 BY .77 NO-UNDO.

DEFINE VARIABLE v-seg AS LOGICAL INITIAL no 
     LABEL "SEG - Seguridad" 
     VIEW-AS TOGGLE-BOX
     SIZE 33 BY .77 NO-UNDO.

DEFINE VARIABLE v-tes AS LOGICAL INITIAL no 
     LABEL "TES - Caja, Bancos y Tesorería" 
     VIEW-AS TOGGLE-BOX
     SIZE 33 BY .77 NO-UNDO.

DEFINE VARIABLE v-vnd AS LOGICAL INITIAL no 
     LABEL "VND - Vendedores" 
     VIEW-AS TOGGLE-BOX
     SIZE 33 BY .77 NO-UNDO.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME Dialog-Frame
     dir_instal AT ROW 1.54 COL 11 COLON-ALIGNED
     que_salida AT ROW 2.88 COL 11 COLON-ALIGNED
     v-aba AT ROW 4.5 COL 13
     v-bas AT ROW 4.5 COL 52
     v-adp AT ROW 5.31 COL 13
     v-cps AT ROW 5.31 COL 52
     v-cxc AT ROW 6.12 COL 13
     v-gla AT ROW 6.12 COL 52
     v-cxp AT ROW 6.92 COL 13
     v-seg AT ROW 6.92 COL 52
     v-dsp AT ROW 7.73 COL 13
     v-vnd AT ROW 7.73 COL 52
     v-fac AT ROW 8.54 COL 13
     v-afi AT ROW 8.54 COL 52
     v-com AT ROW 9.35 COL 13
     v-prd AT ROW 9.35 COL 52
     v-tes AT ROW 10.15 COL 13
     v-exp AT ROW 10.15 COL 52
     v-inv AT ROW 10.96 COL 13
     v-imp AT ROW 10.96 COL 52
     tipo_tabla AT ROW 11.77 COL 33 NO-LABEL
     Btn_OK AT ROW 14.19 COL 4
     Btn_Cancel AT ROW 14.19 COL 43
     "Borrar tablas de:" VIEW-AS TEXT
          SIZE 14 BY .62 AT ROW 12.04 COL 15
     SPACE(61.13) SKIP(4.60)
    WITH VIEW-AS DIALOG-BOX KEEP-TAB-ORDER 
         SIDE-LABELS NO-UNDERLINE THREE-D  SCROLLABLE 
         TITLE "Generación de Borrado de Tablas"
         DEFAULT-BUTTON Btn_OK CANCEL-BUTTON Btn_Cancel.


/* *********************** Procedure Settings ************************ */

&ANALYZE-SUSPEND _PROCEDURE-SETTINGS
/* Settings for THIS-PROCEDURE
   Type: DIALOG-BOX
   Allow: Basic,Browse,DB-Fields,Query
   Other Settings: COMPILE
 */
&ANALYZE-RESUME _END-PROCEDURE-SETTINGS


/* ***************  Runtime Attributes and UIB Settings  ************** */

&ANALYZE-SUSPEND _RUN-TIME-ATTRIBUTES
/* SETTINGS FOR DIALOG-BOX Dialog-Frame
                                                                        */
ASSIGN 
       FRAME Dialog-Frame:SCROLLABLE       = FALSE
       FRAME Dialog-Frame:HIDDEN           = TRUE.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME

 




/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME Dialog-Frame
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Dialog-Frame Dialog-Frame
ON WINDOW-CLOSE OF FRAME Dialog-Frame /* Generación de Borrado de Tablas */
DO:
  APPLY "END-ERROR":U TO SELF.
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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE disable_UI Dialog-Frame _DEFAULT-DISABLE
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


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE enable_UI Dialog-Frame _DEFAULT-ENABLE
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
  DISPLAY dir_instal que_salida v-aba v-bas v-adp v-cps v-cxc v-gla v-cxp v-seg 
          v-dsp v-vnd v-fac v-afi v-com v-prd v-tes v-exp v-inv v-imp tipo_tabla 
      WITH FRAME Dialog-Frame.
  ENABLE dir_instal que_salida v-aba v-bas v-adp v-cps v-cxc v-gla v-cxp v-seg 
         v-dsp v-vnd v-fac v-afi v-com v-prd v-tes v-exp v-inv v-imp tipo_tabla 
         Btn_OK Btn_Cancel 
      WITH FRAME Dialog-Frame.
  VIEW FRAME Dialog-Frame.
  {&OPEN-BROWSERS-IN-QUERY-Dialog-Frame}
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


