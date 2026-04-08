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
&Scoped-define EXTERNAL-TABLES Representante
&Scoped-define FIRST-EXTERNAL-TABLE Representante


/* Need to scope the external tables to this procedure                  */
DEFINE QUERY external_tables FOR Representante.
/* Standard List Definitions                                            */
&Scoped-Define ENABLED-FIELDS Representante.cdg_represente ~
Representante.nom_represente Representante.desc_represente ~
Representante.direccion Representante.cdg_postal Representante.cdg_pais ~
Representante.localidad Representante.provincia Representante.contacto ~
Representante.cuenta_numero Representante.telefonos Representante.fax ~
Representante.email Representante.leyenda 
&Scoped-define FIELD-PAIRS~
 ~{&FP1}cdg_represente ~{&FP2}cdg_represente ~{&FP3}~
 ~{&FP1}nom_represente ~{&FP2}nom_represente ~{&FP3}~
 ~{&FP1}desc_represente ~{&FP2}desc_represente ~{&FP3}~
 ~{&FP1}direccion ~{&FP2}direccion ~{&FP3}~
 ~{&FP1}cdg_postal ~{&FP2}cdg_postal ~{&FP3}~
 ~{&FP1}cdg_pais ~{&FP2}cdg_pais ~{&FP3}~
 ~{&FP1}localidad ~{&FP2}localidad ~{&FP3}~
 ~{&FP1}provincia ~{&FP2}provincia ~{&FP3}~
 ~{&FP1}contacto ~{&FP2}contacto ~{&FP3}~
 ~{&FP1}cuenta_numero ~{&FP2}cuenta_numero ~{&FP3}~
 ~{&FP1}telefonos ~{&FP2}telefonos ~{&FP3}~
 ~{&FP1}fax ~{&FP2}fax ~{&FP3}~
 ~{&FP1}email ~{&FP2}email ~{&FP3}~
 ~{&FP1}leyenda ~{&FP2}leyenda ~{&FP3}
&Scoped-define ENABLED-TABLES Representante
&Scoped-define FIRST-ENABLED-TABLE Representante
&Scoped-Define ENABLED-OBJECTS RECT-8 
&Scoped-Define DISPLAYED-FIELDS Representante.cdg_represente ~
Representante.nom_represente Representante.desc_represente ~
Representante.direccion Representante.cdg_postal Representante.cdg_pais ~
Representante.localidad Representante.provincia Representante.contacto ~
Representante.cuenta_numero Representante.telefonos Representante.fax ~
Representante.email Representante.leyenda 

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
DEFINE RECTANGLE RECT-8
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL 
     SIZE 65 BY 10.5.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME F-Main
     Representante.cdg_represente AT ROW 1.54 COL 11 COLON-ALIGNED
          LABEL "Cod.Rep."
          VIEW-AS FILL-IN 
          SIZE 4 BY .81
          BGCOLOR 15 FGCOLOR 9 
     Representante.nom_represente AT ROW 1.54 COL 26 COLON-ALIGNED
          VIEW-AS FILL-IN 
          SIZE 36.72 BY .81
          BGCOLOR 15 FGCOLOR 9 
     Representante.desc_represente AT ROW 2.62 COL 26 COLON-ALIGNED
          VIEW-AS FILL-IN 
          SIZE 36.72 BY .81
          BGCOLOR 15 FGCOLOR 9 
     Representante.direccion AT ROW 3.69 COL 11 COLON-ALIGNED
          VIEW-AS FILL-IN 
          SIZE 51.72 BY .81
          BGCOLOR 15 FGCOLOR 9 
     Representante.cdg_postal AT ROW 4.77 COL 11 COLON-ALIGNED
          LABEL "C. Postal"
          VIEW-AS FILL-IN 
          SIZE 12.72 BY .81
          BGCOLOR 15 FGCOLOR 9 
     Representante.cdg_pais AT ROW 4.77 COL 31 COLON-ALIGNED
          VIEW-AS FILL-IN 
          SIZE 6.29 BY .81
          BGCOLOR 15 FGCOLOR 9 
     Representante.localidad AT ROW 4.77 COL 46 COLON-ALIGNED
          VIEW-AS FILL-IN 
          SIZE 16.72 BY .81
          BGCOLOR 15 FGCOLOR 9 
     Representante.provincia AT ROW 5.85 COL 11 COLON-ALIGNED
          LABEL "Pcia."
          VIEW-AS FILL-IN 
          SIZE 16.72 BY .81
          BGCOLOR 15 FGCOLOR 9 
     Representante.contacto AT ROW 6.92 COL 11 COLON-ALIGNED
          VIEW-AS FILL-IN 
          SIZE 26.72 BY .81
          BGCOLOR 15 FGCOLOR 9 
     Representante.cuenta_numero AT ROW 6.92 COL 46 COLON-ALIGNED
          VIEW-AS FILL-IN 
          SIZE 16.72 BY .81
          BGCOLOR 15 FGCOLOR 9 
     Representante.telefonos AT ROW 8 COL 11 COLON-ALIGNED
          VIEW-AS FILL-IN 
          SIZE 27 BY .81
          BGCOLOR 15 FGCOLOR 9 
     Representante.fax AT ROW 8 COL 46 COLON-ALIGNED
          VIEW-AS FILL-IN 
          SIZE 16.72 BY .81
          BGCOLOR 15 FGCOLOR 9 
     Representante.email AT ROW 9.08 COL 11 COLON-ALIGNED
          VIEW-AS FILL-IN 
          SIZE 26.72 BY .81
          BGCOLOR 15 FGCOLOR 9 
     Representante.leyenda AT ROW 10.15 COL 7.28
          VIEW-AS FILL-IN 
          SIZE 52 BY .81
          BGCOLOR 15 FGCOLOR 9 
     RECT-8 AT ROW 1 COL 1
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1 SCROLLABLE .


/* *********************** Procedure Settings ************************ */

&ANALYZE-SUSPEND _PROCEDURE-SETTINGS
/* Settings for THIS-PROCEDURE
   Type: SmartViewer
   External Tables: sic.Representante
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
         HEIGHT             = 17.46
         WIDTH              = 66.
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

/* SETTINGS FOR FILL-IN Representante.cdg_postal IN FRAME F-Main
   EXP-LABEL                                                            */
/* SETTINGS FOR FILL-IN Representante.cdg_represente IN FRAME F-Main
   EXP-LABEL                                                            */
/* SETTINGS FOR FILL-IN Representante.leyenda IN FRAME F-Main
   ALIGN-L                                                              */
/* SETTINGS FOR FILL-IN Representante.provincia IN FRAME F-Main
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
  {src/adm/template/row-list.i "Representante"}

  /* Get the record ROWID's from the RECORD-SOURCE.                  */
  {src/adm/template/row-get.i}

  /* FIND each record specified by the RECORD-SOURCE.                */
  {src/adm/template/row-find.i "Representante"}

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
  {src/adm/template/snd-list.i "Representante"}

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


