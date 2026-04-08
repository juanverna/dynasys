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
&Scoped-define EXTERNAL-TABLES Empleado
&Scoped-define FIRST-EXTERNAL-TABLE Empleado


/* Need to scope the external tables to this procedure                  */
DEFINE QUERY external_tables FOR Empleado.
/* Standard List Definitions                                            */
&Scoped-Define ENABLED-FIELDS Empleado.cdg_est_civil Empleado.nacionalid ~
Empleado.nom_madre Empleado.nom_padre Empleado.tipo_doc Empleado.numero_doc ~
Empleado.expedido_por Empleado.fecha_nac Empleado.grupo_sanguineo ~
Empleado.lugar_nac Empleado.cdg_sexo 
&Scoped-define FIELD-PAIRS~
 ~{&FP1}cdg_est_civil ~{&FP2}cdg_est_civil ~{&FP3}~
 ~{&FP1}nacionalid ~{&FP2}nacionalid ~{&FP3}~
 ~{&FP1}nom_madre ~{&FP2}nom_madre ~{&FP3}~
 ~{&FP1}nom_padre ~{&FP2}nom_padre ~{&FP3}~
 ~{&FP1}tipo_doc ~{&FP2}tipo_doc ~{&FP3}~
 ~{&FP1}numero_doc ~{&FP2}numero_doc ~{&FP3}~
 ~{&FP1}expedido_por ~{&FP2}expedido_por ~{&FP3}~
 ~{&FP1}fecha_nac ~{&FP2}fecha_nac ~{&FP3}~
 ~{&FP1}grupo_sanguineo ~{&FP2}grupo_sanguineo ~{&FP3}~
 ~{&FP1}lugar_nac ~{&FP2}lugar_nac ~{&FP3}
&Scoped-define ENABLED-TABLES Empleado
&Scoped-define FIRST-ENABLED-TABLE Empleado
&Scoped-Define ENABLED-OBJECTS RECT-3 
&Scoped-Define DISPLAYED-FIELDS Empleado.cdg_est_civil Empleado.nacionalid ~
Empleado.nom_madre Empleado.nom_padre Empleado.tipo_doc Empleado.numero_doc ~
Empleado.expedido_por Empleado.fecha_nac Empleado.grupo_sanguineo ~
Empleado.lugar_nac Empleado.cdg_sexo 

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
DEFINE RECTANGLE RECT-3
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL 
     SIZE 65 BY 11.03.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME F-Main
     Empleado.cdg_est_civil AT ROW 1.53 COL 14 COLON-ALIGNED
          VIEW-AS FILL-IN 
          SIZE 7.67 BY 1
          BGCOLOR 15 FGCOLOR 9 
     Empleado.nacionalid AT ROW 1.53 COL 42 COLON-ALIGNED
          VIEW-AS FILL-IN 
          SIZE 3.67 BY 1
          BGCOLOR 15 FGCOLOR 9 
     Empleado.nom_madre AT ROW 2.88 COL 14 COLON-ALIGNED
          VIEW-AS FILL-IN 
          SIZE 31.67 BY 1
          BGCOLOR 15 FGCOLOR 9 
     Empleado.nom_padre AT ROW 4.22 COL 14 COLON-ALIGNED
          VIEW-AS FILL-IN 
          SIZE 31.67 BY 1
          BGCOLOR 15 FGCOLOR 9 
     Empleado.tipo_doc AT ROW 5.59 COL 14 COLON-ALIGNED
          VIEW-AS FILL-IN 
          SIZE 7.67 BY 1
          BGCOLOR 15 FGCOLOR 9 
     Empleado.numero_doc AT ROW 5.59 COL 28 COLON-ALIGNED
          VIEW-AS FILL-IN 
          SIZE 10.89 BY 1
          BGCOLOR 15 FGCOLOR 9 
     Empleado.expedido_por AT ROW 5.59 COL 48 COLON-ALIGNED
          VIEW-AS FILL-IN 
          SIZE 7.67 BY 1
          BGCOLOR 15 FGCOLOR 9 
     Empleado.fecha_nac AT ROW 6.91 COL 14 COLON-ALIGNED
          VIEW-AS FILL-IN 
          SIZE 13.11 BY 1
          BGCOLOR 15 FGCOLOR 9 
     Empleado.grupo_sanguineo AT ROW 6.91 COL 48 COLON-ALIGNED
          VIEW-AS FILL-IN 
          SIZE 7.67 BY 1
          BGCOLOR 15 FGCOLOR 9 
     Empleado.lugar_nac AT ROW 9.09 COL 14 COLON-ALIGNED
          VIEW-AS FILL-IN 
          SIZE 21.67 BY 1
          BGCOLOR 15 FGCOLOR 9 
     Empleado.cdg_sexo AT ROW 10.97 COL 16 NO-LABEL
          VIEW-AS RADIO-SET HORIZONTAL
          RADIO-BUTTONS 
                    "Masc.", "M":U,
"Fem.", "F":U
          SIZE 17.45 BY .78
     RECT-3 AT ROW 1.28 COL 3
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1 SCROLLABLE .


/* *********************** Procedure Settings ************************ */

&ANALYZE-SUSPEND _PROCEDURE-SETTINGS
/* Settings for THIS-PROCEDURE
   Type: SmartViewer
   External Tables: sic.Empleado
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
         HEIGHT             = 11.97
         WIDTH              = 72.33.
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
  {src/adm/template/row-list.i "Empleado"}

  /* Get the record ROWID's from the RECORD-SOURCE.                  */
  {src/adm/template/row-get.i}

  /* FIND each record specified by the RECORD-SOURCE.                */
  {src/adm/template/row-find.i "Empleado"}

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
  {src/adm/template/snd-list.i "Empleado"}

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


