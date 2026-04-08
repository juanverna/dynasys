&ANALYZE-SUSPEND _VERSION-NUMBER UIB_v9r12 GUI
&ANALYZE-RESUME
/* Connected Databases 
          sic              PROGRESS
*/
&Scoped-define WINDOW-NAME CURRENT-WINDOW
&Scoped-define FRAME-NAME Dialog-Frame

/* Temp-Table and Buffer definitions                                    */
DEFINE TEMP-TABLE T-Area NO-UNDO LIKE Area.


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
DEFINE VARIABLE p-titulo               AS CHARACTER.   
DEFINE VARIABLE p-nombre_subclasesec   LIKE Clase_de_Sector.nombre_subclasesec.
DEFINE VARIABLE p-rotulo_siguiente     LIKE Clase_de_Sector.rotulo_siguiente.
DEFINE VARIABLE p-longitud_siguiente   LIKE Clase_de_Sector.longitud_siguiente.
DEFINE VARIABLE p-tipo_siguiente       LIKE Clase_de_Sector.tipo_siguiente.
DEFINE VARIABLE puso_ok                AS LOGICAL.   
&ELSE
DEFINE INPUT        PARAMETER p-titulo               AS CHARACTER.   
DEFINE INPUT-OUTPUT PARAMETER TABLE FOR T-Area.
DEFINE OUTPUT       PARAMETER puso_ok                AS LOGICAL.   
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

/* Internal Tables (found by Frame, Query & Browse Queries)             */
&Scoped-define INTERNAL-TABLES T-Area

/* Definitions for DIALOG-BOX Dialog-Frame                              */
&Scoped-define FIELDS-IN-QUERY-Dialog-Frame T-Area.denominacion ~
T-Area.rotulo_siguiente T-Area.longitud_siguiente T-Area.tipo_siguiente 
&Scoped-define ENABLED-FIELDS-IN-QUERY-Dialog-Frame T-Area.denominacion ~
T-Area.rotulo_siguiente T-Area.longitud_siguiente T-Area.tipo_siguiente 
&Scoped-define ENABLED-TABLES-IN-QUERY-Dialog-Frame T-Area
&Scoped-define FIRST-ENABLED-TABLE-IN-QUERY-Dialog-Frame T-Area
&Scoped-define QUERY-STRING-Dialog-Frame FOR EACH T-Area SHARE-LOCK
&Scoped-define OPEN-QUERY-Dialog-Frame OPEN QUERY Dialog-Frame FOR EACH T-Area SHARE-LOCK.
&Scoped-define TABLES-IN-QUERY-Dialog-Frame T-Area
&Scoped-define FIRST-TABLE-IN-QUERY-Dialog-Frame T-Area


/* Standard List Definitions                                            */
&Scoped-Define ENABLED-FIELDS T-Area.denominacion T-Area.rotulo_siguiente ~
T-Area.longitud_siguiente T-Area.tipo_siguiente 
&Scoped-define ENABLED-TABLES T-Area
&Scoped-define FIRST-ENABLED-TABLE T-Area
&Scoped-Define ENABLED-OBJECTS Btn_OK Btn_Cancel RECT-1 RECT-2 
&Scoped-Define DISPLAYED-FIELDS T-Area.denominacion T-Area.rotulo_siguiente ~
T-Area.longitud_siguiente T-Area.tipo_siguiente 
&Scoped-define DISPLAYED-TABLES T-Area
&Scoped-define FIRST-DISPLAYED-TABLE T-Area


/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME



/* ***********************  Control Definitions  ********************** */

/* Define a dialog box                                                  */

/* Definitions of the field level widgets                               */
DEFINE BUTTON Btn_Cancel AUTO-END-KEY 
     LABEL "Cancel" 
     SIZE 15 BY 1.14
     BGCOLOR 8 .

DEFINE BUTTON Btn_OK AUTO-GO 
     LABEL "OK" 
     SIZE 15 BY 1.14
     BGCOLOR 8 .

DEFINE RECTANGLE RECT-1
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL 
     SIZE 58 BY 8.1.

DEFINE RECTANGLE RECT-2
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL 
     SIZE 58 BY 1.91.

/* Query definitions                                                    */
&ANALYZE-SUSPEND
DEFINE QUERY Dialog-Frame FOR 
      T-Area SCROLLING.
&ANALYZE-RESUME

/* ************************  Frame Definitions  *********************** */

DEFINE FRAME Dialog-Frame
     T-Area.denominacion AT ROW 3.14 COL 4 COLON-ALIGNED NO-LABEL
          VIEW-AS FILL-IN 
          SIZE 52 BY 1
          BGCOLOR 15 FGCOLOR 9 
     T-Area.rotulo_siguiente AT ROW 5.52 COL 4 COLON-ALIGNED NO-LABEL
          VIEW-AS FILL-IN 
          SIZE 52 BY 1
          BGCOLOR 15 FGCOLOR 9 
     T-Area.longitud_siguiente AT ROW 7.91 COL 4 COLON-ALIGNED NO-LABEL
          VIEW-AS FILL-IN 
          SIZE 7 BY 1
          BGCOLOR 15 FGCOLOR 9 
     T-Area.tipo_siguiente AT ROW 7.91 COL 15 NO-LABEL
          VIEW-AS RADIO-SET HORIZONTAL
          RADIO-BUTTONS 
                    "Caracteres", 0,
"Carac. long. fija", 1,
"Numeros", 2
          SIZE 43 BY 1.19
     Btn_OK AT ROW 10.05 COL 6
     Btn_Cancel AT ROW 10.05 COL 43
     RECT-1 AT ROW 1.48 COL 3
     RECT-2 AT ROW 9.57 COL 3
     "  Denominación del Sector" VIEW-AS TEXT
          SIZE 52 BY 1 AT ROW 1.95 COL 6
          BGCOLOR 5 FGCOLOR 15 
     "  Denominación del Siguiente Nivel" VIEW-AS TEXT
          SIZE 52 BY 1 AT ROW 4.33 COL 6
          BGCOLOR 5 FGCOLOR 15 
     "  Longitud de código del siguiente nivel y tipo de datos" VIEW-AS TEXT
          SIZE 52 BY 1 AT ROW 6.71 COL 6
          BGCOLOR 5 FGCOLOR 15 
     SPACE(5.59) SKIP(4.14)
    WITH VIEW-AS DIALOG-BOX KEEP-TAB-ORDER 
         SIDE-LABELS NO-UNDERLINE THREE-D  SCROLLABLE 
         TITLE "Modificación de Sectores"
         DEFAULT-BUTTON Btn_OK CANCEL-BUTTON Btn_Cancel.


/* *********************** Procedure Settings ************************ */

&ANALYZE-SUSPEND _PROCEDURE-SETTINGS
/* Settings for THIS-PROCEDURE
   Type: Dialog-Box
   Allow: Basic,Browse,DB-Fields,Query
   Other Settings: COMPILE
   Temp-Tables and Buffers:
      TABLE: T-Area T "?" NO-UNDO sic Area
   END-TABLES.
 */
&ANALYZE-RESUME _END-PROCEDURE-SETTINGS



/* ***********  Runtime Attributes and AppBuilder Settings  *********** */

&ANALYZE-SUSPEND _RUN-TIME-ATTRIBUTES
/* SETTINGS FOR DIALOG-BOX Dialog-Frame
                                                                        */
ASSIGN 
       FRAME Dialog-Frame:SCROLLABLE       = FALSE
       FRAME Dialog-Frame:HIDDEN           = TRUE.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME


/* Setting information for Queries and Browse Widgets fields            */

&ANALYZE-SUSPEND _QUERY-BLOCK DIALOG-BOX Dialog-Frame
/* Query rebuild information for DIALOG-BOX Dialog-Frame
     _TblList          = "Temp-Tables.T-Area"
     _Options          = "SHARE-LOCK"
     _Query            is OPENED
*/  /* DIALOG-BOX Dialog-Frame */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME Dialog-Frame
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Dialog-Frame Dialog-Frame
ON WINDOW-CLOSE OF FRAME Dialog-Frame /* Modificación de Sectores */
DO:
  APPLY "END-ERROR":U TO SELF.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME Btn_Cancel
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Btn_Cancel Dialog-Frame
ON CHOOSE OF Btn_Cancel IN FRAME Dialog-Frame /* Cancel */
DO:

    ASSIGN puso_ok                = NO.   
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME Btn_OK
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Btn_OK Dialog-Frame
ON CHOOSE OF Btn_OK IN FRAME Dialog-Frame /* OK */
DO:
  ASSIGN FRAME {&FRAME-NAME}
        T-Area.denominacion   
        T-Area.rotulo_siguiente     
        T-Area.longitud_siguiente   
        T-Area.tipo_siguiente.       

  ASSIGN puso_ok = YES.   

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&UNDEFINE SELF-NAME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _MAIN-BLOCK Dialog-Frame 


/* ***************************  Main Block  *************************** */

/* Parent the dialog-box to the ACTIVE-WINDOW, if there is no parent.   */
IF VALID-HANDLE(ACTIVE-WINDOW) AND FRAME {&FRAME-NAME}:PARENT eq ?
THEN FRAME {&FRAME-NAME}:PARENT = ACTIVE-WINDOW.

FIND FIRST T-Area EXCLUSIVE-LOCK.

/* Now enable the interface and wait for the exit condition.            */
/* (NOTE: handle ERROR and END-KEY so cleanup code will always fire.    */
MAIN-BLOCK:
DO ON ERROR   UNDO MAIN-BLOCK, LEAVE MAIN-BLOCK
   ON END-KEY UNDO MAIN-BLOCK, LEAVE MAIN-BLOCK:
  RUN enable_UI.
  FRAME {&FRAME-NAME}:TITLE = p-titulo.
  DISPLAY T-Area.denominacion   
          T-Area.rotulo_siguiente     
          T-Area.longitud_siguiente   
          T-Area.tipo_siguiente
          WITH FRAME {&FRAME-NAME}.
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
  IF AVAILABLE T-Area THEN 
    DISPLAY T-Area.denominacion T-Area.rotulo_siguiente T-Area.longitud_siguiente 
          T-Area.tipo_siguiente 
      WITH FRAME Dialog-Frame.
  ENABLE T-Area.denominacion T-Area.rotulo_siguiente T-Area.longitud_siguiente 
         T-Area.tipo_siguiente Btn_OK Btn_Cancel RECT-1 RECT-2 
      WITH FRAME Dialog-Frame.
  VIEW FRAME Dialog-Frame.
  {&OPEN-BROWSERS-IN-QUERY-Dialog-Frame}
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

