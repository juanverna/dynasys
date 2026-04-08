&ANALYZE-SUSPEND _VERSION-NUMBER UIB_v8r12 GUI
&ANALYZE-RESUME
/* Connected Databases 
          sic              PROGRESS
*/
&Scoped-define WINDOW-NAME CURRENT-WINDOW
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _DEFINITIONS V-table-Win 
/*------------------------------------------------------------------------

  File:

  Description: from VIEWER.W - Template for SmartViewer Objects

  Input Parameters:
      <none>

  Output Parameters:
      <none>

------------------------------------------------------------------------*/
/*          This .W file was created with the Progress UIB.             */
/*----------------------------------------------------------------------*/

/* Create an unnamed pool to store all the widgets created 
     by this procedure. This is a good default which assures
     that this procedure's triggers and internal procedures 
     will execute in this procedure's storage, and that proper
     cleanup will occur on deletion of the procedure. */

CREATE WIDGET-POOL.

/* ***************************  Definitions  ************************** */

/* Parameters Definitions ---                                           */

/* Local Variable Definitions ---                                       */

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE SmartViewer

&Scoped-define ADM-SUPPORTED-LINKS Record-Source,Record-Target,TableIO-Target

/* Name of first Frame and/or Browse and/or first Query                 */
&Scoped-define FRAME-NAME F-Main

/* External Tables                                                      */
&Scoped-define EXTERNAL-TABLES Recorrido
&Scoped-define FIRST-EXTERNAL-TABLE Recorrido


/* Need to scope the external tables to this procedure                  */
DEFINE QUERY external_tables FOR Recorrido.
/* Standard List Definitions                                            */
&Scoped-Define ENABLED-FIELDS Recorrido.cdg_recorrido ~
Recorrido.dsc_recorrido Recorrido.cdg_fletero Recorrido.dia_habilitado[1] ~
Recorrido.dia_habilitado[2] Recorrido.dia_habilitado[3] ~
Recorrido.dia_habilitado[4] Recorrido.dia_habilitado[5] ~
Recorrido.dia_habilitado[6] Recorrido.dia_habilitado[7] 
&Scoped-define FIELD-PAIRS~
 ~{&FP1}cdg_recorrido ~{&FP2}cdg_recorrido ~{&FP3}~
 ~{&FP1}dsc_recorrido ~{&FP2}dsc_recorrido ~{&FP3}~
 ~{&FP1}cdg_fletero ~{&FP2}cdg_fletero ~{&FP3}
&Scoped-define ENABLED-TABLES Recorrido
&Scoped-define FIRST-ENABLED-TABLE Recorrido
&Scoped-Define ENABLED-OBJECTS RECT-4 
&Scoped-Define DISPLAYED-FIELDS Recorrido.cdg_recorrido ~
Recorrido.dsc_recorrido Recorrido.cdg_fletero Recorrido.dia_habilitado[1] ~
Recorrido.dia_habilitado[2] Recorrido.dia_habilitado[3] ~
Recorrido.dia_habilitado[4] Recorrido.dia_habilitado[5] ~
Recorrido.dia_habilitado[6] Recorrido.dia_habilitado[7] 

/* Custom List Definitions                                              */
/* ADM-CREATE-FIELDS,ADM-ASSIGN-FIELDS,List-3,List-4,List-5,List-6      */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _XFTR "Foreign Keys" V-table-Win _INLINE
/* Actions: ? adm/support/keyedit.w ? ? ? */
/* STRUCTURED-DATA
<KEY-OBJECT>
THIS-PROCEDURE
</KEY-OBJECT>
<FOREIGN-KEYS>
</FOREIGN-KEYS> 
<EXECUTING-CODE>
**************************
* Set attributes related to FOREIGN KEYS
*/
RUN set-attribute-list (
    'Keys-Accepted = "",
     Keys-Supplied = ""':U).
/**************************
</EXECUTING-CODE> */   

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


/* ***********************  Control Definitions  ********************** */


/* Definitions of the field level widgets                               */
DEFINE RECTANGLE RECT-4
     EDGE-PIXELS 4 GRAPHIC-EDGE  NO-FILL 
     SIZE 69 BY 13.46.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME F-Main
     Recorrido.cdg_recorrido AT ROW 1.54 COL 20 COLON-ALIGNED
          VIEW-AS FILL-IN 
          SIZE 9.72 BY 1
     Recorrido.dsc_recorrido AT ROW 2.88 COL 20 COLON-ALIGNED
          VIEW-AS FILL-IN 
          SIZE 36.72 BY 1
     Recorrido.cdg_fletero AT ROW 4.23 COL 20 COLON-ALIGNED
          VIEW-AS FILL-IN 
          SIZE 9.72 BY 1
     Recorrido.dia_habilitado[1] AT ROW 5.85 COL 22 NO-LABEL
          VIEW-AS RADIO-SET HORIZONTAL
          RADIO-BUTTONS 
                    "Si", "S",
"No", "",
"Sin LLuvia", "L"
          SIZE 28 BY .81
     Recorrido.dia_habilitado[2] AT ROW 6.92 COL 22 NO-LABEL
          VIEW-AS RADIO-SET HORIZONTAL
          RADIO-BUTTONS 
                    "Si", "S",
"No", "",
"Sin LLuvia", "L"
          SIZE 28 BY .81
     Recorrido.dia_habilitado[3] AT ROW 8 COL 22 NO-LABEL
          VIEW-AS RADIO-SET HORIZONTAL
          RADIO-BUTTONS 
                    "Si", "S",
"No", "",
"Sin LLuvia", "L"
          SIZE 28 BY .81
     Recorrido.dia_habilitado[4] AT ROW 9.08 COL 22 NO-LABEL
          VIEW-AS RADIO-SET HORIZONTAL
          RADIO-BUTTONS 
                    "Si", "S",
"No", "",
"Sin LLuvia", "L"
          SIZE 28 BY .81
     Recorrido.dia_habilitado[5] AT ROW 10.15 COL 22 NO-LABEL
          VIEW-AS RADIO-SET HORIZONTAL
          RADIO-BUTTONS 
                    "Si", "S",
"No", "",
"Sin LLuvia", "L"
          SIZE 28 BY .81
     Recorrido.dia_habilitado[6] AT ROW 11.23 COL 22 NO-LABEL
          VIEW-AS RADIO-SET HORIZONTAL
          RADIO-BUTTONS 
                    "Si", "S",
"No", "",
"Sin LLuvia", "L"
          SIZE 28 BY .81
     Recorrido.dia_habilitado[7] AT ROW 12.31 COL 22 NO-LABEL
          VIEW-AS RADIO-SET HORIZONTAL
          RADIO-BUTTONS 
                    "Si", "S",
"No", "",
"Sin LLuvia", "L"
          SIZE 28 BY .96
     RECT-4 AT ROW 1 COL 1
     "Sábado:" VIEW-AS TEXT
          SIZE 8 BY .58 AT ROW 12.31 COL 20 RIGHT-ALIGNED
     "Viernes:" VIEW-AS TEXT
          SIZE 7 BY .62 AT ROW 11.23 COL 20 RIGHT-ALIGNED
     "Jueves:" VIEW-AS TEXT
          SIZE 7 BY .62 AT ROW 10.15 COL 20 RIGHT-ALIGNED
     "Martes:" VIEW-AS TEXT
          SIZE 6 BY .62 AT ROW 8 COL 20 RIGHT-ALIGNED
     "Miércoles:" VIEW-AS TEXT
          SIZE 9 BY .62 AT ROW 9.08 COL 20 RIGHT-ALIGNED
     "Domingo:" VIEW-AS TEXT
          SIZE 8 BY .62 AT ROW 5.85 COL 20 RIGHT-ALIGNED
     "Lunes:" VIEW-AS TEXT
          SIZE 6 BY .62 AT ROW 6.92 COL 20 RIGHT-ALIGNED
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1 SCROLLABLE 
         FONT 4.


/* *********************** Procedure Settings ************************ */

&ANALYZE-SUSPEND _PROCEDURE-SETTINGS
/* Settings for THIS-PROCEDURE
   Type: SmartViewer
   External Tables: sic.Recorrido
   Allow: Basic,DB-Fields
   Frames: 1
   Add Fields to: EXTERNAL-TABLES
   Other Settings: PERSISTENT-ONLY COMPILE
 */

/* This procedure should always be RUN PERSISTENT.  Report the error,  */
/* then cleanup and return.                                            */
IF NOT THIS-PROCEDURE:PERSISTENT THEN DO:
  MESSAGE "{&FILE-NAME} should only be RUN PERSISTENT."
          VIEW-AS ALERT-BOX ERROR BUTTONS OK.
  RETURN.
END.

&ANALYZE-RESUME _END-PROCEDURE-SETTINGS

/* *************************  Create Window  ************************** */

&ANALYZE-SUSPEND _CREATE-WINDOW
/* DESIGN Window definition (used by the UIB) 
  CREATE WINDOW V-table-Win ASSIGN
         HEIGHT             = 14.15
         WIDTH              = 79.57.
/* END WINDOW DEFINITION */
                                                                        */
&ANALYZE-RESUME


/* ***************  Runtime Attributes and UIB Settings  ************** */

&ANALYZE-SUSPEND _RUN-TIME-ATTRIBUTES
/* SETTINGS FOR WINDOW V-table-Win
  VISIBLE,,RUN-PERSISTENT                                               */
/* SETTINGS FOR FRAME F-Main
   NOT-VISIBLE Size-to-Fit                                              */
ASSIGN 
       FRAME F-Main:SCROLLABLE       = FALSE
       FRAME F-Main:HIDDEN           = TRUE.

/* SETTINGS FOR TEXT-LITERAL "Domingo:"
          SIZE 8 BY .62 AT ROW 5.85 COL 20 RIGHT-ALIGNED                */

/* SETTINGS FOR TEXT-LITERAL "Lunes:"
          SIZE 6 BY .62 AT ROW 6.92 COL 20 RIGHT-ALIGNED                */

/* SETTINGS FOR TEXT-LITERAL "Martes:"
          SIZE 6 BY .62 AT ROW 8 COL 20 RIGHT-ALIGNED                   */

/* SETTINGS FOR TEXT-LITERAL "Miércoles:"
          SIZE 9 BY .62 AT ROW 9.08 COL 20 RIGHT-ALIGNED                */

/* SETTINGS FOR TEXT-LITERAL "Jueves:"
          SIZE 7 BY .62 AT ROW 10.15 COL 20 RIGHT-ALIGNED               */

/* SETTINGS FOR TEXT-LITERAL "Viernes:"
          SIZE 7 BY .62 AT ROW 11.23 COL 20 RIGHT-ALIGNED               */

/* SETTINGS FOR TEXT-LITERAL "Sábado:"
          SIZE 8 BY .58 AT ROW 12.31 COL 20 RIGHT-ALIGNED               */

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME


/* Setting information for Queries and Browse Widgets fields            */

&ANALYZE-SUSPEND _QUERY-BLOCK FRAME F-Main
/* Query rebuild information for FRAME F-Main
     _Options          = "NO-LOCK"
     _Query            is NOT OPENED
*/  /* FRAME F-Main */
&ANALYZE-RESUME

 

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _XFTR "SmartViewerCues" V-table-Win _INLINE
/* Actions: adecomm/_so-cue.w ? adecomm/_so-cued.p ? adecomm/_so-cuew.p */
/* SmartViewer,uib,49270
Destroy on next read */
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _INCLUDED-LIB V-table-Win 
/* ************************* Included-Libraries *********************** */

{src/adm/method/viewer.i}

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME



&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _MAIN-BLOCK V-table-Win 


/* ***************************  Main Block  *************************** */

  &IF DEFINED(UIB_IS_RUNNING) <> 0 &THEN          
    RUN dispatch IN THIS-PROCEDURE ('initialize':U).        
  &ENDIF         
  
  /************************ INTERNAL PROCEDURES ********************/

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


/* **********************  Internal Procedures  *********************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE adm-row-available V-table-Win _ADM-ROW-AVAILABLE
PROCEDURE adm-row-available :
/*------------------------------------------------------------------------------
  Purpose:     Dispatched to this procedure when the Record-
               Source has a new row available.  This procedure
               tries to get the new row (or foriegn keys) from
               the Record-Source and process it.
  Parameters:  <none>
------------------------------------------------------------------------------*/

  /* Define variables needed by this internal procedure.             */
  {src/adm/template/row-head.i}

  /* Create a list of all the tables that we need to get.            */
  {src/adm/template/row-list.i "Recorrido"}

  /* Get the record ROWID's from the RECORD-SOURCE.                  */
  {src/adm/template/row-get.i}

  /* FIND each record specified by the RECORD-SOURCE.                */
  {src/adm/template/row-find.i "Recorrido"}

  /* Process the newly available records (i.e. display fields,
     open queries, and/or pass records on to any RECORD-TARGETS).    */
  {src/adm/template/row-end.i}

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE disable_UI V-table-Win _DEFAULT-DISABLE
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
  HIDE FRAME F-Main.
  IF THIS-PROCEDURE:PERSISTENT THEN DELETE PROCEDURE THIS-PROCEDURE.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE send-records V-table-Win _ADM-SEND-RECORDS
PROCEDURE send-records :
/*------------------------------------------------------------------------------
  Purpose:     Send record ROWID's for all tables used by
               this file.
  Parameters:  see template/snd-head.i
------------------------------------------------------------------------------*/

  /* Define variables needed by this internal procedure.               */
  {src/adm/template/snd-head.i}

  /* For each requested table, put it's ROWID in the output list.      */
  {src/adm/template/snd-list.i "Recorrido"}

  /* Deal with any unexpected table requests before closing.           */
  {src/adm/template/snd-end.i}

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE state-changed V-table-Win 
PROCEDURE state-changed :
/* -----------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
-------------------------------------------------------------*/
  DEFINE INPUT PARAMETER p-issuer-hdl AS HANDLE    NO-UNDO.
  DEFINE INPUT PARAMETER p-state      AS CHARACTER NO-UNDO.

  CASE p-state:
      /* Object instance CASEs can go here to replace standard behavior
         or add new cases. */
      {src/adm/template/vstates.i}
  END CASE.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


