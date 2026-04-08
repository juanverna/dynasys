&ANALYZE-SUSPEND _VERSION-NUMBER UIB_v8r12 GUI
&ANALYZE-RESUME
/* Connected Databases 
          padron           PROGRESS
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
&Scoped-define EXTERNAL-TABLES Hst_domicilio
&Scoped-define FIRST-EXTERNAL-TABLE Hst_domicilio


/* Need to scope the external tables to this procedure                  */
DEFINE QUERY external_tables FOR Hst_domicilio.
/* Standard List Definitions                                            */
&Scoped-Define ENABLED-FIELDS Hst_domicilio.num_domicilio ~
Hst_domicilio.cdg_tipodom Hst_domicilio.calle Hst_domicilio.nropta ~
Hst_domicilio.piso Hst_domicilio.depto Hst_domicilio.casa ~
Hst_domicilio.barrio Hst_domicilio.monoblk Hst_domicilio.prefijotel ~
Hst_domicilio.telefono Hst_domicilio.cdg_zona Hst_domicilio.cdg_localidad ~
Hst_domicilio.cdg_postal Hst_domicilio.cdg_provincia Hst_domicilio.entre1 ~
Hst_domicilio.entre2 Hst_domicilio.refer 
&Scoped-define FIELD-PAIRS~
 ~{&FP1}num_domicilio ~{&FP2}num_domicilio ~{&FP3}~
 ~{&FP1}cdg_tipodom ~{&FP2}cdg_tipodom ~{&FP3}~
 ~{&FP1}calle ~{&FP2}calle ~{&FP3}~
 ~{&FP1}nropta ~{&FP2}nropta ~{&FP3}~
 ~{&FP1}piso ~{&FP2}piso ~{&FP3}~
 ~{&FP1}depto ~{&FP2}depto ~{&FP3}~
 ~{&FP1}casa ~{&FP2}casa ~{&FP3}~
 ~{&FP1}barrio ~{&FP2}barrio ~{&FP3}~
 ~{&FP1}monoblk ~{&FP2}monoblk ~{&FP3}~
 ~{&FP1}prefijotel ~{&FP2}prefijotel ~{&FP3}~
 ~{&FP1}telefono ~{&FP2}telefono ~{&FP3}~
 ~{&FP1}cdg_zona ~{&FP2}cdg_zona ~{&FP3}~
 ~{&FP1}cdg_localidad ~{&FP2}cdg_localidad ~{&FP3}~
 ~{&FP1}cdg_postal ~{&FP2}cdg_postal ~{&FP3}~
 ~{&FP1}cdg_provincia ~{&FP2}cdg_provincia ~{&FP3}~
 ~{&FP1}entre1 ~{&FP2}entre1 ~{&FP3}~
 ~{&FP1}entre2 ~{&FP2}entre2 ~{&FP3}~
 ~{&FP1}refer ~{&FP2}refer ~{&FP3}
&Scoped-define ENABLED-TABLES Hst_domicilio
&Scoped-define FIRST-ENABLED-TABLE Hst_domicilio
&Scoped-Define ENABLED-OBJECTS RECT-5 
&Scoped-Define DISPLAYED-FIELDS Hst_domicilio.num_domicilio ~
Hst_domicilio.cdg_tipodom Hst_domicilio.calle Hst_domicilio.nropta ~
Hst_domicilio.piso Hst_domicilio.depto Hst_domicilio.casa ~
Hst_domicilio.barrio Hst_domicilio.monoblk Hst_domicilio.prefijotel ~
Hst_domicilio.telefono Hst_domicilio.cdg_zona Hst_domicilio.cdg_localidad ~
Hst_domicilio.cdg_postal Hst_domicilio.cdg_provincia Hst_domicilio.entre1 ~
Hst_domicilio.entre2 Hst_domicilio.refer 

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
DEFINE RECTANGLE RECT-5
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL 
     SIZE 60 BY 10.23.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME F-Main
     Hst_domicilio.num_domicilio AT ROW 1.27 COL 8 COLON-ALIGNED
          LABEL "Nro."
          VIEW-AS FILL-IN 
          SIZE 7 BY .81
          BGCOLOR 15 FGCOLOR 9 
     Hst_domicilio.cdg_tipodom AT ROW 1.27 COL 47 COLON-ALIGNED
          LABEL "Tipo"
          VIEW-AS FILL-IN 
          SIZE 10 BY .81
          BGCOLOR 15 FGCOLOR 9 
     Hst_domicilio.calle AT ROW 2.35 COL 8 COLON-ALIGNED
          VIEW-AS FILL-IN 
          SIZE 27 BY .81
          BGCOLOR 15 FGCOLOR 9 
     Hst_domicilio.nropta AT ROW 2.35 COL 47 COLON-ALIGNED
          VIEW-AS FILL-IN 
          SIZE 10 BY .81
          BGCOLOR 15 FGCOLOR 9 
     Hst_domicilio.piso AT ROW 3.42 COL 8 COLON-ALIGNED
          VIEW-AS FILL-IN 
          SIZE 7 BY .81
          BGCOLOR 15 FGCOLOR 9 
     Hst_domicilio.depto AT ROW 3.42 COL 25 COLON-ALIGNED
          VIEW-AS FILL-IN 
          SIZE 10 BY .81
          BGCOLOR 15 FGCOLOR 9 
     Hst_domicilio.casa AT ROW 3.42 COL 47 COLON-ALIGNED
          VIEW-AS FILL-IN 
          SIZE 10 BY .81
          BGCOLOR 15 FGCOLOR 9 
     Hst_domicilio.barrio AT ROW 4.5 COL 8 COLON-ALIGNED
          VIEW-AS FILL-IN 
          SIZE 27 BY .81
          BGCOLOR 15 FGCOLOR 9 
     Hst_domicilio.monoblk AT ROW 4.5 COL 47 COLON-ALIGNED
          VIEW-AS FILL-IN 
          SIZE 10 BY .81
          BGCOLOR 15 FGCOLOR 9 
     Hst_domicilio.prefijotel AT ROW 5.58 COL 8 COLON-ALIGNED
          LABEL "Tel."
          VIEW-AS FILL-IN 
          SIZE 7 BY .81
          BGCOLOR 15 FGCOLOR 9 
     Hst_domicilio.telefono AT ROW 5.58 COL 16 COLON-ALIGNED NO-LABEL
          VIEW-AS FILL-IN 
          SIZE 19 BY .81
          BGCOLOR 15 FGCOLOR 9 
     Hst_domicilio.cdg_zona AT ROW 5.58 COL 47 COLON-ALIGNED
          VIEW-AS FILL-IN 
          SIZE 10 BY .81
          BGCOLOR 15 FGCOLOR 9 
     Hst_domicilio.cdg_localidad AT ROW 6.65 COL 8 COLON-ALIGNED
          LABEL "Loc."
          VIEW-AS FILL-IN 
          SIZE 7 BY .81
          BGCOLOR 15 FGCOLOR 9 
     Hst_domicilio.cdg_postal AT ROW 6.65 COL 25 COLON-ALIGNED
          VIEW-AS FILL-IN 
          SIZE 10 BY .81
          BGCOLOR 15 FGCOLOR 9 
     Hst_domicilio.cdg_provincia AT ROW 6.65 COL 47 COLON-ALIGNED
          VIEW-AS FILL-IN 
          SIZE 10 BY .81
          BGCOLOR 15 FGCOLOR 9 
     Hst_domicilio.entre1 AT ROW 7.73 COL 8 COLON-ALIGNED
          VIEW-AS FILL-IN 
          SIZE 27 BY .81
          BGCOLOR 15 FGCOLOR 9 
     Hst_domicilio.entre2 AT ROW 8.81 COL 8 COLON-ALIGNED
          VIEW-AS FILL-IN 
          SIZE 27 BY .81
          BGCOLOR 15 FGCOLOR 9 
     Hst_domicilio.refer AT ROW 9.88 COL 8 COLON-ALIGNED
          VIEW-AS FILL-IN 
          SIZE 49 BY .81
          BGCOLOR 15 FGCOLOR 9 
     RECT-5 AT ROW 1 COL 1
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1 SCROLLABLE 
         FONT 4.


/* *********************** Procedure Settings ************************ */

&ANALYZE-SUSPEND _PROCEDURE-SETTINGS
/* Settings for THIS-PROCEDURE
   Type: SmartViewer
   External Tables: padron.Hst_domicilio
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
         HEIGHT             = 14.5
         WIDTH              = 88.43.
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

/* SETTINGS FOR FILL-IN Hst_domicilio.cdg_localidad IN FRAME F-Main
   EXP-LABEL                                                            */
/* SETTINGS FOR FILL-IN Hst_domicilio.cdg_tipodom IN FRAME F-Main
   EXP-LABEL                                                            */
/* SETTINGS FOR FILL-IN Hst_domicilio.num_domicilio IN FRAME F-Main
   EXP-LABEL                                                            */
/* SETTINGS FOR FILL-IN Hst_domicilio.prefijotel IN FRAME F-Main
   EXP-LABEL                                                            */
/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME


/* Setting information for Queries and Browse Widgets fields            */

&ANALYZE-SUSPEND _QUERY-BLOCK FRAME F-Main
/* Query rebuild information for FRAME F-Main
     _Options          = "NO-LOCK"
     _Query            is NOT OPENED
*/  /* FRAME F-Main */
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
  {src/adm/template/row-list.i "Hst_domicilio"}

  /* Get the record ROWID's from the RECORD-SOURCE.                  */
  {src/adm/template/row-get.i}

  /* FIND each record specified by the RECORD-SOURCE.                */
  {src/adm/template/row-find.i "Hst_domicilio"}

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
  {src/adm/template/snd-list.i "Hst_domicilio"}

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


