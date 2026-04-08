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

  DEFINE VARIABLE h AS HANDLE NO-UNDO.
  DEFINE VARIABLE c AS CHAR   NO-UNDO.

  DEFINE VARIABLE que_autorizado LIKE Asn_header.cdg_estadoasiento.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE SmartViewer

&Scoped-define ADM-SUPPORTED-LINKS Record-Source,Record-Target,TableIO-Target

/* Name of first Frame and/or Browse and/or first Query                 */
&Scoped-define FRAME-NAME F-Main

/* External Tables                                                      */
&Scoped-define EXTERNAL-TABLES Asn_header
&Scoped-define FIRST-EXTERNAL-TABLE Asn_header


/* Need to scope the external tables to this procedure                  */
DEFINE QUERY external_tables FOR Asn_header.
/* Standard List Definitions                                            */
&Scoped-Define ENABLED-FIELDS Asn_header.observacion 
&Scoped-define FIELD-PAIRS
&Scoped-define ENABLED-TABLES Asn_header
&Scoped-define FIRST-ENABLED-TABLE Asn_header
&Scoped-Define ENABLED-OBJECTS RECT-2 RECT-1 btn_autorizar btn_todos ~
btn_rechazar btn_imprimir btn_verasiento 
&Scoped-Define DISPLAYED-FIELDS Asn_header.observacion 

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
DEFINE BUTTON btn_autorizar 
     LABEL "&Autorizar" 
     SIZE 21 BY 1.12.

DEFINE BUTTON btn_imprimir 
     LABEL "&Imprimir" 
     SIZE 10 BY 1.12.

DEFINE BUTTON btn_rechazar 
     LABEL "&Rechazar" 
     SIZE 21 BY 1.12.

DEFINE BUTTON btn_todos 
     LABEL "Autorizar &Todos" 
     SIZE 21 BY 1.12.

DEFINE BUTTON btn_verasiento 
     LABEL "&Ver" 
     SIZE 10 BY 1.12.

DEFINE RECTANGLE RECT-1
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL 
     SIZE 46 BY 2.96.

DEFINE RECTANGLE RECT-2
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL 
     SIZE 46 BY 5.65.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME F-Main
     btn_autorizar AT ROW 1.27 COL 2
     btn_todos AT ROW 1.27 COL 25
     btn_rechazar AT ROW 2.62 COL 2
     btn_imprimir AT ROW 2.62 COL 25
     btn_verasiento AT ROW 2.62 COL 36
     Asn_header.observacion AT ROW 4.5 COL 2 NO-LABEL
          VIEW-AS EDITOR SCROLLBAR-VERTICAL
          SIZE 44 BY 5.12
          BGCOLOR 15 FGCOLOR 9 
     RECT-2 AT ROW 4.23 COL 1
     RECT-1 AT ROW 1 COL 1
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1 SCROLLABLE .


/* *********************** Procedure Settings ************************ */

&ANALYZE-SUSPEND _PROCEDURE-SETTINGS
/* Settings for THIS-PROCEDURE
   Type: SmartViewer
   External Tables: sic.Asn_header
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
         HEIGHT             = 11.92
         WIDTH              = 67.29.
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




/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME btn_autorizar
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btn_autorizar V-table-Win
ON CHOOSE OF btn_autorizar IN FRAME F-Main /* Autorizar */
DO:
  
  /* Ask the Record-Source for the current customer record.  Make sure
     there is only one.*/
  RUN get-link-handle IN adm-broker-hdl
       (THIS-PROCEDURE, "Record-Source":U, OUTPUT c).
  IF NUM-ENTRIES (c) eq 1 THEN DO:
     h = WIDGET-HANDLE (c).
     RUN cambiar_estado_asiento IN h ( INPUT  que_autorizado).
  END.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btn_rechazar
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btn_rechazar V-table-Win
ON CHOOSE OF btn_rechazar IN FRAME F-Main /* Rechazar */
DO:
  
  /* Ask the Record-Source for the current customer record.  Make sure
     there is only one.*/
  RUN get-link-handle IN adm-broker-hdl
       (THIS-PROCEDURE, "Record-Source":U, OUTPUT c).
  IF NUM-ENTRIES (c) eq 1 THEN DO:
     h = WIDGET-HANDLE (c).
     RUN cambiar_estado_asiento IN h ( INPUT  "R").
  END.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btn_todos
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btn_todos V-table-Win
ON CHOOSE OF btn_todos IN FRAME F-Main /* Autorizar Todos */
DO:
  
  /* Ask the Record-Source for the current customer record.  Make sure
     there is only one.*/
  RUN get-link-handle IN adm-broker-hdl
       (THIS-PROCEDURE, "Record-Source":U, OUTPUT c).
  IF NUM-ENTRIES (c) eq 1 THEN DO:
     h = WIDGET-HANDLE (c).
     RUN autorizar_todos IN h.
  END.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btn_verasiento
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btn_verasiento V-table-Win
ON CHOOSE OF btn_verasiento IN FRAME F-Main /* Ver */
DO:
  DEFINE VARIABLE rid_asiento AS ROWID.
  rid_asiento = ROWID(Asn_header).
  RUN c-asiento_contable.w ( INPUT-OUTPUT rid_asiento, INPUT 2).
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&UNDEFINE SELF-NAME

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
  {src/adm/template/row-list.i "Asn_header"}

  /* Get the record ROWID's from the RECORD-SOURCE.                  */
  {src/adm/template/row-get.i}

  /* FIND each record specified by the RECORD-SOURCE.                */
  {src/adm/template/row-find.i "Asn_header"}

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


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE fijar_autorizado V-table-Win 
PROCEDURE fijar_autorizado :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

  DEFINE INPUT PARAMETER p-estado LIKE Asn_header.cdg_estadoasiento.

  que_autorizado = p-estado.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE local-display-fields V-table-Win 
PROCEDURE local-display-fields :
/*------------------------------------------------------------------------------
  Purpose:     Override standard ADM method
  Notes:       
------------------------------------------------------------------------------*/

  /* Code placed here will execute PRIOR to standard behavior. */

  /* Dispatch standard ADM method.                             */
  RUN dispatch IN THIS-PROCEDURE ( INPUT 'display-fields':U ) .

  /* Code placed here will execute AFTER standard behavior.    */

    btn_autorizar:SENSITIVE IN FRAME {&FRAME-NAME} = AVAILABLE Asn_header.
    btn_imprimir:SENSITIVE IN FRAME {&FRAME-NAME} = AVAILABLE Asn_header. 
    btn_rechazar:SENSITIVE IN FRAME {&FRAME-NAME} = AVAILABLE Asn_header. 
    btn_todos:SENSITIVE IN FRAME {&FRAME-NAME} = AVAILABLE Asn_header.


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
  {src/adm/template/snd-list.i "Asn_header"}

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


