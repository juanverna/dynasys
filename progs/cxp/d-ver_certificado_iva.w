&ANALYZE-SUSPEND _VERSION-NUMBER UIB_v8r12 GUI
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
/*          This .W file was created with the Progress UIB.             */
/*----------------------------------------------------------------------*/

/* ***************************  Definitions  ************************** */

/* Parameters Definitions ---                                           */

/* Local Variable Definitions ---                                       */

&IF DEFINED(UIB_is_Running) EQ 0
&THEN
DEFINE INPUT PARAMETER rid_certificado AS ROWID.
&ELSE
DEFINE VARIABLE rid_certificado AS ROWID.
&ENDIF

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE DIALOG-BOX

/* Name of first Frame and/or Browse and/or first Query                 */
&Scoped-define FRAME-NAME Dialog-Frame

/* Internal Tables (found by Frame, Query & Browse Queries)             */
&Scoped-define INTERNAL-TABLES Certificado_iva

/* Definitions for DIALOG-BOX Dialog-Frame                              */
&Scoped-define FIELDS-IN-QUERY-Dialog-Frame Certificado_iva.nro_certifiva ~
Certificado_iva.cdg_tiporetiva Certificado_iva.fecha_emision ~
Certificado_iva.fecha_deposito Certificado_iva.imp_pagado ~
Certificado_iva.imp_retenido Certificado_iva.anulado ~
Certificado_iva.emitido 
&Scoped-define ENABLED-FIELDS-IN-QUERY-Dialog-Frame ~
Certificado_iva.nro_certifiva Certificado_iva.cdg_tiporetiva ~
Certificado_iva.fecha_emision Certificado_iva.fecha_deposito ~
Certificado_iva.imp_pagado Certificado_iva.imp_retenido ~
Certificado_iva.anulado Certificado_iva.emitido 
&Scoped-define ENABLED-TABLES-IN-QUERY-Dialog-Frame Certificado_iva
&Scoped-define FIRST-ENABLED-TABLE-IN-QUERY-Dialog-Frame Certificado_iva

&Scoped-define FIELD-PAIRS-IN-QUERY-Dialog-Frame~
 ~{&FP1}nro_certifiva ~{&FP2}nro_certifiva ~{&FP3}~
 ~{&FP1}cdg_tiporetiva ~{&FP2}cdg_tiporetiva ~{&FP3}~
 ~{&FP1}fecha_emision ~{&FP2}fecha_emision ~{&FP3}~
 ~{&FP1}fecha_deposito ~{&FP2}fecha_deposito ~{&FP3}~
 ~{&FP1}imp_pagado ~{&FP2}imp_pagado ~{&FP3}~
 ~{&FP1}imp_retenido ~{&FP2}imp_retenido ~{&FP3}
&Scoped-define OPEN-QUERY-Dialog-Frame OPEN QUERY Dialog-Frame FOR EACH Certificado_iva SHARE-LOCK.
&Scoped-define TABLES-IN-QUERY-Dialog-Frame Certificado_iva
&Scoped-define FIRST-TABLE-IN-QUERY-Dialog-Frame Certificado_iva


/* Standard List Definitions                                            */
&Scoped-Define ENABLED-FIELDS Certificado_iva.nro_certifiva ~
Certificado_iva.cdg_tiporetiva Certificado_iva.fecha_emision ~
Certificado_iva.fecha_deposito Certificado_iva.imp_pagado ~
Certificado_iva.imp_retenido Certificado_iva.anulado ~
Certificado_iva.emitido 
&Scoped-define FIELD-PAIRS~
 ~{&FP1}nro_certifiva ~{&FP2}nro_certifiva ~{&FP3}~
 ~{&FP1}cdg_tiporetiva ~{&FP2}cdg_tiporetiva ~{&FP3}~
 ~{&FP1}fecha_emision ~{&FP2}fecha_emision ~{&FP3}~
 ~{&FP1}fecha_deposito ~{&FP2}fecha_deposito ~{&FP3}~
 ~{&FP1}imp_pagado ~{&FP2}imp_pagado ~{&FP3}~
 ~{&FP1}imp_retenido ~{&FP2}imp_retenido ~{&FP3}
&Scoped-define ENABLED-TABLES Certificado_iva
&Scoped-define FIRST-ENABLED-TABLE Certificado_iva
&Scoped-Define ENABLED-OBJECTS RECT-9 Btn_OK 
&Scoped-Define DISPLAYED-FIELDS Certificado_iva.nro_certifiva ~
Certificado_iva.cdg_tiporetiva Certificado_iva.fecha_emision ~
Certificado_iva.fecha_deposito Certificado_iva.imp_pagado ~
Certificado_iva.imp_retenido Certificado_iva.anulado ~
Certificado_iva.emitido 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME



/* ***********************  Control Definitions  ********************** */

/* Define a dialog box                                                  */

/* Definitions of the field level widgets                               */
DEFINE BUTTON Btn_OK AUTO-GO 
     LABEL "&Salir" 
     SIZE 17 BY 1.15
     BGCOLOR 8 .

DEFINE RECTANGLE RECT-9
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL 
     SIZE 58 BY 6.73.

/* Query definitions                                                    */
&ANALYZE-SUSPEND
DEFINE QUERY Dialog-Frame FOR 
      Certificado_iva SCROLLING.
&ANALYZE-RESUME

/* ************************  Frame Definitions  *********************** */

DEFINE FRAME Dialog-Frame
     Certificado_iva.nro_certifiva AT ROW 2.08 COL 10 COLON-ALIGNED
          VIEW-AS FILL-IN 
          SIZE 17 BY .81
          BGCOLOR 15 FGCOLOR 9 
     Certificado_iva.cdg_tiporetiva AT ROW 2.08 COL 39 COLON-ALIGNED
          LABEL "Régimen"
          VIEW-AS FILL-IN 
          SIZE 17 BY .81
          BGCOLOR 15 FGCOLOR 9 
     Certificado_iva.fecha_emision AT ROW 3.15 COL 10 COLON-ALIGNED
          VIEW-AS FILL-IN 
          SIZE 17 BY .81
          BGCOLOR 15 FGCOLOR 9 
     Certificado_iva.fecha_deposito AT ROW 3.15 COL 39 COLON-ALIGNED
          VIEW-AS FILL-IN 
          SIZE 17 BY .81
          BGCOLOR 15 FGCOLOR 9 
     Certificado_iva.imp_pagado AT ROW 4.23 COL 10 COLON-ALIGNED
          VIEW-AS FILL-IN 
          SIZE 17 BY .81
          BGCOLOR 15 FGCOLOR 9 
     Certificado_iva.imp_retenido AT ROW 4.23 COL 39 COLON-ALIGNED
          VIEW-AS FILL-IN 
          SIZE 17 BY .81
          BGCOLOR 15 FGCOLOR 9 
     Certificado_iva.anulado AT ROW 5.31 COL 12
          VIEW-AS TOGGLE-BOX
          SIZE 11.14 BY .77
     Certificado_iva.emitido AT ROW 5.31 COL 41
          VIEW-AS TOGGLE-BOX
          SIZE 10.43 BY .77
     Btn_OK AT ROW 6.38 COL 41
     RECT-9 AT ROW 1.27 COL 2
     SPACE(1.56) SKIP(0.41)
    WITH VIEW-AS DIALOG-BOX KEEP-TAB-ORDER 
         SIDE-LABELS NO-UNDERLINE THREE-D  SCROLLABLE 
         TITLE "Datos del Certificado Actual"
         DEFAULT-BUTTON Btn_OK.


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

/* SETTINGS FOR FILL-IN Certificado_iva.cdg_tiporetiva IN FRAME Dialog-Frame
   EXP-LABEL                                                            */
/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME


/* Setting information for Queries and Browse Widgets fields            */

&ANALYZE-SUSPEND _QUERY-BLOCK DIALOG-BOX Dialog-Frame
/* Query rebuild information for DIALOG-BOX Dialog-Frame
     _TblList          = "sic.Certificado_iva"
     _Options          = "SHARE-LOCK"
     _Query            is NOT OPENED
*/  /* DIALOG-BOX Dialog-Frame */
&ANALYZE-RESUME

 




/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME Dialog-Frame
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Dialog-Frame Dialog-Frame
ON WINDOW-CLOSE OF FRAME Dialog-Frame /* Datos del Certificado Actual */
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
  FIND Certificado_iva WHERE ROWID(Certificado_iva) = rid_certificado NO-LOCK.
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
  IF AVAILABLE Certificado_iva THEN 
    DISPLAY Certificado_iva.nro_certifiva Certificado_iva.cdg_tiporetiva 
          Certificado_iva.fecha_emision Certificado_iva.fecha_deposito 
          Certificado_iva.imp_pagado Certificado_iva.imp_retenido 
          Certificado_iva.anulado Certificado_iva.emitido 
      WITH FRAME Dialog-Frame.
  ENABLE RECT-9 Certificado_iva.nro_certifiva Certificado_iva.cdg_tiporetiva 
         Certificado_iva.fecha_emision Certificado_iva.fecha_deposito 
         Certificado_iva.imp_pagado Certificado_iva.imp_retenido 
         Certificado_iva.anulado Certificado_iva.emitido Btn_OK 
      WITH FRAME Dialog-Frame.
  VIEW FRAME Dialog-Frame.
  {&OPEN-BROWSERS-IN-QUERY-Dialog-Frame}
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


