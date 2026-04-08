&ANALYZE-SUSPEND _VERSION-NUMBER UIB_v8r12 GUI ADM1
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
&Scoped-define DB-AWARE no

&Scoped-define ADM-SUPPORTED-LINKS Record-Source,Record-Target,TableIO-Target

/* Name of first Frame and/or Browse and/or first Query                 */
&Scoped-define FRAME-NAME F-Main

/* External Tables                                                      */
&Scoped-define EXTERNAL-TABLES Cuarta-cat
&Scoped-define FIRST-EXTERNAL-TABLE Cuarta-cat


/* Need to scope the external tables to this procedure                  */
DEFINE QUERY external_tables FOR Cuarta-cat.
/* Standard List Definitions                                            */
&Scoped-Define ENABLED-FIELDS Cuarta-cat.mes Cuarta-cat.no_imponible ~
Cuarta-cat.carga_famcony Cuarta-cat.carga_famhijo Cuarta-cat.carga_famotro ~
Cuarta-cat.deduc_incid Cuarta-cat.deduc_inciabc Cuarta-cat.primaseg ~
Cuarta-cat.sepelio Cuarta-cat.seguretiro 
&Scoped-define ENABLED-TABLES Cuarta-cat
&Scoped-define FIRST-ENABLED-TABLE Cuarta-cat
&Scoped-define DISPLAYED-TABLES Cuarta-cat
&Scoped-define FIRST-DISPLAYED-TABLE Cuarta-cat
&Scoped-Define ENABLED-OBJECTS RECT-1 RECT-2 RECT-3 RECT-4 RECT-6 
&Scoped-Define DISPLAYED-FIELDS Cuarta-cat.mes Cuarta-cat.no_imponible ~
Cuarta-cat.carga_famcony Cuarta-cat.carga_famhijo Cuarta-cat.carga_famotro ~
Cuarta-cat.deduc_incid Cuarta-cat.deduc_inciabc Cuarta-cat.primaseg ~
Cuarta-cat.sepelio Cuarta-cat.seguretiro 

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
DEFINE RECTANGLE RECT-1
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL 
     SIZE 32 BY 1.52.

DEFINE RECTANGLE RECT-2
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL 
     SIZE 28 BY 3.76.

DEFINE RECTANGLE RECT-3
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL 
     SIZE 30 BY 3.24.

DEFINE RECTANGLE RECT-4
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL 
     SIZE 33 BY 4.52.

DEFINE RECTANGLE RECT-6
     EDGE-PIXELS 4 GRAPHIC-EDGE  NO-FILL 
     SIZE 37 BY 18.81.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME F-Main
     Cuarta-cat.mes AT ROW 5.29 COL 32 COLON-ALIGNED
          VIEW-AS FILL-IN 
          SIZE 2.8 BY 1
          BGCOLOR 15 FGCOLOR 9 
     Cuarta-cat.no_imponible AT ROW 7.19 COL 32 COLON-ALIGNED
          VIEW-AS FILL-IN 
          SIZE 14.6 BY 1
          BGCOLOR 15 FGCOLOR 9 
     Cuarta-cat.carga_famcony AT ROW 9.81 COL 32 COLON-ALIGNED
          LABEL "Cónyuge"
          VIEW-AS FILL-IN 
          SIZE 14.6 BY 1
          BGCOLOR 15 FGCOLOR 9 
     Cuarta-cat.carga_famhijo AT ROW 10.81 COL 32 COLON-ALIGNED
          LABEL "Hijo"
          VIEW-AS FILL-IN 
          SIZE 14.6 BY 1
          BGCOLOR 15 FGCOLOR 9 
     Cuarta-cat.carga_famotro AT ROW 11.81 COL 32 COLON-ALIGNED
          LABEL "Otros"
          VIEW-AS FILL-IN 
          SIZE 14.6 BY .76
          BGCOLOR 15 FGCOLOR 9 
     Cuarta-cat.deduc_incid AT ROW 15.05 COL 33 COLON-ALIGNED
          LABEL "Inciso D"
          VIEW-AS FILL-IN 
          SIZE 14.6 BY 1
          BGCOLOR 15 FGCOLOR 9 
     Cuarta-cat.deduc_inciabc AT ROW 16.1 COL 33 COLON-ALIGNED
          LABEL "Inciso A,B,C"
          VIEW-AS FILL-IN 
          SIZE 14.6 BY 1
          BGCOLOR 15 FGCOLOR 9 
     Cuarta-cat.primaseg AT ROW 19.33 COL 33 COLON-ALIGNED
          VIEW-AS FILL-IN 
          SIZE 14.6 BY 1
          BGCOLOR 15 FGCOLOR 9 
     Cuarta-cat.sepelio AT ROW 20.38 COL 33 COLON-ALIGNED
          VIEW-AS FILL-IN 
          SIZE 14.6 BY 1
          BGCOLOR 15 FGCOLOR 9 
     Cuarta-cat.seguretiro AT ROW 21.48 COL 33 COLON-ALIGNED
          VIEW-AS FILL-IN 
          SIZE 14.6 BY 1
          BGCOLOR 15 FGCOLOR 9 
     RECT-1 AT ROW 6.95 COL 19
     RECT-2 AT ROW 9.33 COL 23
     RECT-3 AT ROW 14.1 COL 21
     RECT-4 AT ROW 18.38 COL 18
     RECT-6 AT ROW 4.57 COL 16
     "    Otras Deducciones" VIEW-AS TEXT
          SIZE 22 BY .52 AT ROW 17.67 COL 25
     "    Deducciones Especiales" VIEW-AS TEXT
          SIZE 26 BY .52 AT ROW 13.38 COL 23
     "    Cargas de Familia" VIEW-AS TEXT
          SIZE 20 BY .71 AT ROW 8.62 COL 26
     "    Mínimo" VIEW-AS TEXT
          SIZE 8 BY .52 AT ROW 6.29 COL 24
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1 SCROLLABLE 
         FONT 4.


/* *********************** Procedure Settings ************************ */

&ANALYZE-SUSPEND _PROCEDURE-SETTINGS
/* Settings for THIS-PROCEDURE
   Type: SmartViewer
   External Tables: sic.Cuarta-cat
   Allow: Basic,DB-Fields
   Frames: 1
   Add Fields to: EXTERNAL-TABLES
   Other Settings: PERSISTENT-ONLY COMPILE
 */

/* This procedure should always be RUN PERSISTENT.  Report the error,  */
/* then cleanup and return.                                            */
IF NOT THIS-PROCEDURE:PERSISTENT THEN DO:
  MESSAGE "{&FILE-NAME} should only be RUN PERSISTENT.":U
          VIEW-AS ALERT-BOX ERROR BUTTONS OK.
  RETURN.
END.

&ANALYZE-RESUME _END-PROCEDURE-SETTINGS

/* *************************  Create Window  ************************** */

&ANALYZE-SUSPEND _CREATE-WINDOW
/* DESIGN Window definition (used by the UIB) 
  CREATE WINDOW V-table-Win ASSIGN
         HEIGHT             = 23.1
         WIDTH              = 135.
/* END WINDOW DEFINITION */
                                                                        */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _INCLUDED-LIB V-table-Win 
/* ************************* Included-Libraries *********************** */

{src/adm/method/viewer.i}

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME




/* ***********  Runtime Attributes and AppBuilder Settings  *********** */

&ANALYZE-SUSPEND _RUN-TIME-ATTRIBUTES
/* SETTINGS FOR WINDOW V-table-Win
  VISIBLE,,RUN-PERSISTENT                                               */
/* SETTINGS FOR FRAME F-Main
   NOT-VISIBLE Size-to-Fit                                              */
ASSIGN 
       FRAME F-Main:SCROLLABLE       = FALSE
       FRAME F-Main:HIDDEN           = TRUE.

/* SETTINGS FOR FILL-IN Cuarta-cat.carga_famcony IN FRAME F-Main
   EXP-LABEL                                                            */
/* SETTINGS FOR FILL-IN Cuarta-cat.carga_famhijo IN FRAME F-Main
   EXP-LABEL                                                            */
/* SETTINGS FOR FILL-IN Cuarta-cat.carga_famotro IN FRAME F-Main
   EXP-LABEL                                                            */
/* SETTINGS FOR FILL-IN Cuarta-cat.deduc_inciabc IN FRAME F-Main
   EXP-LABEL                                                            */
/* SETTINGS FOR FILL-IN Cuarta-cat.deduc_incid IN FRAME F-Main
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

 


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _MAIN-BLOCK V-table-Win 


/* ***************************  Main Block  *************************** */

  &IF DEFINED(UIB_IS_RUNNING) <> 0 &THEN          
    RUN dispatch IN THIS-PROCEDURE ('initialize':U).        
  &ENDIF         
  
  /************************ INTERNAL PROCEDURES ********************/

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


/* **********************  Internal Procedures  *********************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE adm-row-available V-table-Win  _ADM-ROW-AVAILABLE
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
  {src/adm/template/row-list.i "Cuarta-cat"}

  /* Get the record ROWID's from the RECORD-SOURCE.                  */
  {src/adm/template/row-get.i}

  /* FIND each record specified by the RECORD-SOURCE.                */
  {src/adm/template/row-find.i "Cuarta-cat"}

  /* Process the newly available records (i.e. display fields,
     open queries, and/or pass records on to any RECORD-TARGETS).    */
  {src/adm/template/row-end.i}

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE disable_UI V-table-Win  _DEFAULT-DISABLE
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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE send-records V-table-Win  _ADM-SEND-RECORDS
PROCEDURE send-records :
/*------------------------------------------------------------------------------
  Purpose:     Send record ROWID's for all tables used by
               this file.
  Parameters:  see template/snd-head.i
------------------------------------------------------------------------------*/

  /* Define variables needed by this internal procedure.               */
  {src/adm/template/snd-head.i}

  /* For each requested table, put it's ROWID in the output list.      */
  {src/adm/template/snd-list.i "Cuarta-cat"}

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

