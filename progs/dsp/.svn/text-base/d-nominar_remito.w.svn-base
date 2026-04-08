&ANALYZE-SUSPEND _VERSION-NUMBER UIB_v9r12 GUI
&ANALYZE-RESUME
/* Connected Databases 
          sic              PROGRESS
*/
&Scoped-define WINDOW-NAME CURRENT-WINDOW
&Scoped-define FRAME-NAME Dialog-Frame

/* Temp-Table and Buffer definitions                                    */
DEFINE TEMP-TABLE T-Rem_header NO-UNDO LIKE Rem_header.


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
DEFINE VARIABLE           p-modo-cabecera  AS INTEGER.
DEFINE VARIABLE           p-modo-detalle   AS INTEGER.
&ELSE
DEFINE INPUT   PARAMETER  p-modo-cabecera  AS INTEGER.
DEFINE INPUT   PARAMETER  p-modo-detalle   AS INTEGER.
DEFINE INPUT-OUTPUT PARAMETER TABLE FOR T-Rem_header.
&ENDIF

/* Local Variable Definitions ---                                       */

{valoresmodo.i}
{valoressalida.i}

DEFINE VARIABLE           rid_tabla       AS ROWID.
DEFINE VARIABLE           hubo_error      AS LOGICAL.
DEFINE VARIABLE           hay_obras       AS LOGICAL.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE Dialog-Box
&Scoped-define DB-AWARE no

/* Name of first Frame and/or Browse and/or first Query                 */
&Scoped-define FRAME-NAME Dialog-Frame

/* Internal Tables (found by Frame, Query & Browse Queries)             */
&Scoped-define INTERNAL-TABLES T-Rem_header

/* Definitions for DIALOG-BOX Dialog-Frame                              */
&Scoped-define FIELDS-IN-QUERY-Dialog-Frame T-Rem_header.nombre ~
T-Rem_header.direccion T-Rem_header.cdg_postal T-Rem_header.localidad ~
T-Rem_header.cuit T-Rem_header.cdg_provincia 
&Scoped-define ENABLED-FIELDS-IN-QUERY-Dialog-Frame T-Rem_header.nombre ~
T-Rem_header.direccion T-Rem_header.cdg_postal T-Rem_header.localidad ~
T-Rem_header.cuit T-Rem_header.cdg_provincia 
&Scoped-define ENABLED-TABLES-IN-QUERY-Dialog-Frame T-Rem_header
&Scoped-define FIRST-ENABLED-TABLE-IN-QUERY-Dialog-Frame T-Rem_header
&Scoped-define OPEN-QUERY-Dialog-Frame OPEN QUERY Dialog-Frame FOR EACH T-Rem_header SHARE-LOCK.
&Scoped-define TABLES-IN-QUERY-Dialog-Frame T-Rem_header
&Scoped-define FIRST-TABLE-IN-QUERY-Dialog-Frame T-Rem_header


/* Standard List Definitions                                            */
&Scoped-Define ENABLED-FIELDS T-Rem_header.nombre T-Rem_header.direccion ~
T-Rem_header.cdg_postal T-Rem_header.localidad T-Rem_header.cuit ~
T-Rem_header.cdg_provincia 
&Scoped-define ENABLED-TABLES T-Rem_header
&Scoped-define FIRST-ENABLED-TABLE T-Rem_header
&Scoped-define DISPLAYED-TABLES T-Rem_header
&Scoped-define FIRST-DISPLAYED-TABLE T-Rem_header
&Scoped-Define ENABLED-OBJECTS Btn_OK Btn_Cancel RECT-13 
&Scoped-Define DISPLAYED-FIELDS T-Rem_header.nombre T-Rem_header.direccion ~
T-Rem_header.cdg_postal T-Rem_header.localidad T-Rem_header.cuit ~
T-Rem_header.cdg_provincia 

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

DEFINE RECTANGLE RECT-13
     EDGE-PIXELS 6 GRAPHIC-EDGE  NO-FILL 
     SIZE 65 BY 6.46.

/* Query definitions                                                    */
&ANALYZE-SUSPEND
DEFINE QUERY Dialog-Frame FOR 
      T-Rem_header SCROLLING.
&ANALYZE-RESUME

/* ************************  Frame Definitions  *********************** */

DEFINE FRAME Dialog-Frame
     T-Rem_header.nombre AT ROW 1.81 COL 14 COLON-ALIGNED
          VIEW-AS FILL-IN NATIVE 
          SIZE 49 BY .81
          BGCOLOR 15 FGCOLOR 9 
     T-Rem_header.direccion AT ROW 2.88 COL 14 COLON-ALIGNED
          VIEW-AS FILL-IN NATIVE 
          SIZE 49 BY .81
          BGCOLOR 15 FGCOLOR 9 
     T-Rem_header.cdg_postal AT ROW 3.96 COL 14 COLON-ALIGNED
          LABEL "C. Postal"
          VIEW-AS FILL-IN NATIVE 
          SIZE 12.72 BY .81
          BGCOLOR 15 FGCOLOR 9 
     T-Rem_header.localidad AT ROW 3.96 COL 40 COLON-ALIGNED
          VIEW-AS FILL-IN NATIVE 
          SIZE 23 BY .81
          BGCOLOR 15 FGCOLOR 9 
     T-Rem_header.cuit AT ROW 5.04 COL 14 COLON-ALIGNED
          VIEW-AS FILL-IN NATIVE 
          SIZE 31 BY .81
          BGCOLOR 15 FGCOLOR 9 
     T-Rem_header.cdg_provincia AT ROW 5.04 COL 56 COLON-ALIGNED
          VIEW-AS FILL-IN NATIVE 
          SIZE 7 BY .81
          BGCOLOR 15 FGCOLOR 9 
     Btn_OK AT ROW 6.12 COL 16
     Btn_Cancel AT ROW 6.12 COL 50
     RECT-13 AT ROW 1.27 COL 2
     SPACE(1.13) SKIP(0.34)
    WITH VIEW-AS DIALOG-BOX KEEP-TAB-ORDER 
         SIDE-LABELS NO-UNDERLINE THREE-D  SCROLLABLE 
         TITLE "Datos de Nominación del Remito"
         DEFAULT-BUTTON Btn_OK CANCEL-BUTTON Btn_Cancel.


/* *********************** Procedure Settings ************************ */

&ANALYZE-SUSPEND _PROCEDURE-SETTINGS
/* Settings for THIS-PROCEDURE
   Type: Dialog-Box
   Allow: Basic,Browse,DB-Fields,Query
   Other Settings: COMPILE
   Temp-Tables and Buffers:
      TABLE: T-Rem_header T "?" NO-UNDO sic Rem_header
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

/* SETTINGS FOR FILL-IN T-Rem_header.cdg_postal IN FRAME Dialog-Frame
   EXP-LABEL                                                            */
/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME


/* Setting information for Queries and Browse Widgets fields            */

&ANALYZE-SUSPEND _QUERY-BLOCK DIALOG-BOX Dialog-Frame
/* Query rebuild information for DIALOG-BOX Dialog-Frame
     _TblList          = "Temp-Tables.T-Rem_header"
     _Options          = "SHARE-LOCK"
     _Query            is OPENED
*/  /* DIALOG-BOX Dialog-Frame */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME Dialog-Frame
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Dialog-Frame Dialog-Frame
ON WINDOW-CLOSE OF FRAME Dialog-Frame /* Datos de Nominación del Remito */
DO:
  APPLY "END-ERROR":U TO SELF.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME Btn_OK
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Btn_OK Dialog-Frame
ON CHOOSE OF Btn_OK IN FRAME Dialog-Frame /* OK */
DO:

  RUN  validar_datos ( OUTPUT hubo_error ).
  IF NOT hubo_error
  THEN DO:
        ASSIGN FRAME {&FRAME-NAME}
            T-Rem_header.cdg_postal
            T-Rem_header.cdg_provincia 
            T-Rem_header.cuit 
            T-Rem_header.direccion 
            T-Rem_header.localidad 
            T-Rem_header.nombre.
        codigo_salir = CD_GRABAR.
        APPLY "U1" TO THIS-PROCEDURE.
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

  FIND FIRST T-Rem_header.
  DISPLAY 
        T-Rem_header.cdg_postal
        T-Rem_header.cdg_provincia 
        T-Rem_header.cuit 
        T-Rem_header.direccion 
        T-Rem_header.localidad 
        T-Rem_header.nombre
        WITH FRAME {&FRAME-NAME}.      

  WAIT-FOR U1 OF THIS-PROCEDURE.
  CASE codigo_salir:
       WHEN CD_SALIR    THEN UNDO,LEAVE.
       WHEN CD_CANCELAR THEN UNDO,RETRY.
       WHEN CD_GRABAR   THEN LEAVE.
  END CASE.

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
  IF AVAILABLE T-Rem_header THEN 
    DISPLAY T-Rem_header.nombre T-Rem_header.direccion T-Rem_header.cdg_postal 
          T-Rem_header.localidad T-Rem_header.cuit T-Rem_header.cdg_provincia 
      WITH FRAME Dialog-Frame.
  ENABLE T-Rem_header.nombre T-Rem_header.direccion T-Rem_header.cdg_postal 
         T-Rem_header.localidad T-Rem_header.cuit T-Rem_header.cdg_provincia 
         Btn_OK Btn_Cancel RECT-13 
      WITH FRAME Dialog-Frame.
  VIEW FRAME Dialog-Frame.
  {&OPEN-BROWSERS-IN-QUERY-Dialog-Frame}
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE validar_datos Dialog-Frame 
PROCEDURE validar_datos :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

   DEFINE OUTPUT PARAMETER hay_error AS LOGICAL.

   hay_error = YES.

   IF NOT CAN-FIND(Provincia WHERE Provincia.cdg_provincia = INPUT FRAME {&FRAME-NAME} T-Rem_header.cdg_provincia)
   THEN DO:
        RUN ponmensj.p ( INPUT "FACT009" ).
        RETURN.
   END.

   hay_error = NO.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

