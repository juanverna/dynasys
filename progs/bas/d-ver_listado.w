&ANALYZE-SUSPEND _VERSION-NUMBER UIB_v9r12 GUI
&ANALYZE-RESUME
/* Connected Databases 
          sic              PROGRESS
*/
&Scoped-define WINDOW-NAME CURRENT-WINDOW
&Scoped-define FRAME-NAME Dialog-Frame

/* Temp-Table and Buffer definitions                                    */
DEFINE TEMP-TABLE T-Lineas_listado NO-UNDO LIKE Lineas_listado.


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

DEFINE TEMP-TABLE T-Listado NO-UNDO
    FIELD nro_linea AS INTEGER
    FIELD linea_lst AS CHARACTER FORMAT "X(192)"
    INDEX por_linea IS PRIMARY UNIQUE nro_linea.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE Dialog-Box
&Scoped-define DB-AWARE no

/* Name of first Frame and/or Browse and/or first Query                 */
&Scoped-define FRAME-NAME Dialog-Frame
&Scoped-define BROWSE-NAME BROWSE-10

/* Internal Tables (found by Frame, Query & Browse Queries)             */
&Scoped-define INTERNAL-TABLES T-Lineas_listado

/* Definitions for BROWSE BROWSE-10                                     */
&Scoped-define FIELDS-IN-QUERY-BROWSE-10 T-Lineas_listado.linea_lst 
&Scoped-define ENABLED-FIELDS-IN-QUERY-BROWSE-10 
&Scoped-define QUERY-STRING-BROWSE-10 FOR EACH T-Lineas_listado NO-LOCK INDEXED-REPOSITION
&Scoped-define OPEN-QUERY-BROWSE-10 OPEN QUERY BROWSE-10 FOR EACH T-Lineas_listado NO-LOCK INDEXED-REPOSITION.
&Scoped-define TABLES-IN-QUERY-BROWSE-10 T-Lineas_listado
&Scoped-define FIRST-TABLE-IN-QUERY-BROWSE-10 T-Lineas_listado


/* Definitions for DIALOG-BOX Dialog-Frame                              */
&Scoped-define OPEN-BROWSERS-IN-QUERY-Dialog-Frame ~
    ~{&OPEN-QUERY-BROWSE-10}

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS v-archivo BUTTON-1 BUTTON-2 Btn_Cancel ~
Btn_OK BROWSE-10 
&Scoped-Define DISPLAYED-OBJECTS v-archivo 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME



/* ***********************  Control Definitions  ********************** */

/* Define a dialog box                                                  */

/* Definitions of the field level widgets                               */
DEFINE BUTTON Btn_Cancel AUTO-END-KEY 
     LABEL "Cancel" 
     SIZE 15 BY 1
     BGCOLOR 8 .

DEFINE BUTTON Btn_OK AUTO-GO 
     LABEL "OK" 
     SIZE 15 BY 1
     BGCOLOR 8 .

DEFINE BUTTON BUTTON-1 
     LABEL "&Elegir" 
     SIZE 15 BY 1.

DEFINE BUTTON BUTTON-2 
     LABEL "&Local" 
     SIZE 15 BY 1.

DEFINE VARIABLE v-archivo AS CHARACTER FORMAT "X(256)":U 
     LABEL "Archivo" 
     VIEW-AS FILL-IN 
     SIZE 85 BY 1 NO-UNDO.

/* Query definitions                                                    */
&ANALYZE-SUSPEND
DEFINE QUERY BROWSE-10 FOR 
      T-Lineas_listado SCROLLING.
&ANALYZE-RESUME

/* Browse definitions                                                   */
DEFINE BROWSE BROWSE-10
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS BROWSE-10 Dialog-Frame _STRUCTURED
  QUERY BROWSE-10 NO-LOCK DISPLAY
      T-Lineas_listado.linea_lst FORMAT "X(192)":U WIDTH 151.6
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ROW-MARKERS SIZE 156 BY 24.52
         FONT 22 ROW-HEIGHT-CHARS .52.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME Dialog-Frame
     v-archivo AT ROW 1.48 COL 9 COLON-ALIGNED
     BUTTON-1 AT ROW 1.48 COL 97
     BUTTON-2 AT ROW 1.48 COL 113
     Btn_Cancel AT ROW 1.48 COL 129
     Btn_OK AT ROW 1.48 COL 145
     BROWSE-10 AT ROW 3.14 COL 4
     SPACE(0.99) SKIP(0.95)
    WITH VIEW-AS DIALOG-BOX KEEP-TAB-ORDER 
         SIDE-LABELS NO-UNDERLINE THREE-D  SCROLLABLE 
         TITLE "<insert dialog title>"
         DEFAULT-BUTTON Btn_OK CANCEL-BUTTON Btn_Cancel.


/* *********************** Procedure Settings ************************ */

&ANALYZE-SUSPEND _PROCEDURE-SETTINGS
/* Settings for THIS-PROCEDURE
   Type: Dialog-Box
   Allow: Basic,Browse,DB-Fields,Query
   Other Settings: COMPILE
   Temp-Tables and Buffers:
      TABLE: T-Lineas_listado T "?" NO-UNDO sic Lineas_listado
   END-TABLES.
 */
&ANALYZE-RESUME _END-PROCEDURE-SETTINGS



/* ***********  Runtime Attributes and AppBuilder Settings  *********** */

&ANALYZE-SUSPEND _RUN-TIME-ATTRIBUTES
/* SETTINGS FOR DIALOG-BOX Dialog-Frame
                                                                        */
/* BROWSE-TAB BROWSE-10 Btn_OK Dialog-Frame */
ASSIGN 
       FRAME Dialog-Frame:SCROLLABLE       = FALSE
       FRAME Dialog-Frame:HIDDEN           = TRUE.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME


/* Setting information for Queries and Browse Widgets fields            */

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE BROWSE-10
/* Query rebuild information for BROWSE BROWSE-10
     _TblList          = "Temp-Tables.T-Lineas_listado"
     _Options          = "NO-LOCK INDEXED-REPOSITION"
     _FldNameList[1]   > Temp-Tables.T-Lineas_listado.linea_lst
"linea_lst" ? ? "character" ? ? ? ? ? ? no ? no no "151.6" yes no no "U" "" ""
     _Query            is OPENED
*/  /* BROWSE BROWSE-10 */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME Dialog-Frame
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Dialog-Frame Dialog-Frame
ON WINDOW-CLOSE OF FRAME Dialog-Frame /* <insert dialog title> */
DO:
  APPLY "END-ERROR":U TO SELF.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME BUTTON-1
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL BUTTON-1 Dialog-Frame
ON CHOOSE OF BUTTON-1 IN FRAME Dialog-Frame /* Elegir */
DO:
    DEFINE VARIABLE xx AS CHARACTER.
    DEFINE VARIABLE puso_ok AS LOGICAL.
    RUN selarchivo.p ( INPUT-OUTPUT xx, OUTPUT puso_ok ).
    IF puso_ok 
    THEN DO:
        DISPLAY xx @ v-archivo
                  WITH FRAME {&FRAME-NAME}.     
        APPLY "return" TO v-archivo  IN FRAME {&FRAME-NAME}.     
    END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME BUTTON-2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL BUTTON-2 Dialog-Frame
ON CHOOSE OF BUTTON-2 IN FRAME Dialog-Frame /* Local */
DO:
  OUTPUT TO "c:\sic-temp\local.txt" PAGE-SIZE 0.
  FOR EACH T-Lineas_listado:
      PUT UNFORMATTED T-Lineas_listado.linea_lst SKIP.
  END.
  OUTPUT CLOSE.
  RUN veresult.w ( INPUT "c:\sic-temp\local.txt", INPUT 22 ).
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME v-archivo
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-archivo Dialog-Frame
ON RETURN OF v-archivo IN FRAME Dialog-Frame /* Archivo */
DO:
    DEFINE VARIABLE n-reng  AS INTEGER.
    DEFINE VARIABLE c-linea AS CHARACTER.

    FILE-INFO:FILE-NAME = v-archivo:SCREEN-VALUE IN FRAME {&FRAME-NAME}.
    IF FILE-INFO:FULL-PATHNAME <> ?
    THEN DO:
        EMPTY TEMP-TABLE T-Lineas_listado.
        n-reng = 0.
        INPUT FROM VALUE(FILE-INFO:FULL-PATHNAME).
        REPEAT:
            IMPORT UNFORMATTED c-linea.
            CREATE T-Lineas_listado.
            ASSIGN n-reng = n-reng + 1
                   T-Lineas_listado.nro_linea = n-reng
                   T-Lineas_listado.linea_lst = c-linea.
        END.
        {&OPEN-QUERY-{&BROWSE-NAME}}

  END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define BROWSE-NAME BROWSE-10
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
  DISPLAY v-archivo 
      WITH FRAME Dialog-Frame.
  ENABLE v-archivo BUTTON-1 BUTTON-2 Btn_Cancel Btn_OK BROWSE-10 
      WITH FRAME Dialog-Frame.
  VIEW FRAME Dialog-Frame.
  {&OPEN-BROWSERS-IN-QUERY-Dialog-Frame}
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

