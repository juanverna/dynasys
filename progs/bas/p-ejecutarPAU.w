&ANALYZE-SUSPEND _VERSION-NUMBER UIB_v8r12 GUI ADM1
&ANALYZE-RESUME
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

  DEFINE VARIABLE h_window AS HANDLE NO-UNDO.
  DEFINE VARIABLE c_window AS CHAR   NO-UNDO.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE SmartViewer
&Scoped-define DB-AWARE no

&Scoped-define ADM-SUPPORTED-LINKS Record-Source,Record-Target,TableIO-Target

/* Name of designated FRAME-NAME and/or first browse and/or first query */
&Scoped-define FRAME-NAME F-Main

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS RECT-11 btn_ejecutar btn_verlistado ~
btn_salir 

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
DEFINE BUTTON btn_ejecutar 
     LABEL "&Ejecutar" 
     SIZE 22 BY 1.33.

DEFINE BUTTON btn_imprimir 
     LABEL "&Imprimir Listado" 
     SIZE 22 BY 1.33.

DEFINE BUTTON btn_salir DEFAULT 
     LABEL "&Salir" 
     SIZE 22 BY 1.33
     BGCOLOR 8 .

DEFINE BUTTON btn_verlistado 
     LABEL "&Ver Listado" 
     SIZE 24 BY 1.33.

DEFINE RECTANGLE RECT-11
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 100 BY 2.62.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME F-Main
     btn_ejecutar AT ROW 1.71 COL 3
     btn_verlistado AT ROW 1.71 COL 27
     btn_imprimir AT ROW 1.71 COL 53
     btn_salir AT ROW 1.71 COL 77
     RECT-11 AT ROW 1 COL 1
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1 SCROLLABLE .


/* *********************** Procedure Settings ************************ */

&ANALYZE-SUSPEND _PROCEDURE-SETTINGS
/* Settings for THIS-PROCEDURE
   Type: SmartViewer
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
         HEIGHT             = 2.76
         WIDTH              = 110.8.
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
   NOT-VISIBLE FRAME-NAME Size-to-Fit                                   */
ASSIGN 
       FRAME F-Main:SCROLLABLE       = FALSE
       FRAME F-Main:HIDDEN           = TRUE.

/* SETTINGS FOR BUTTON btn_imprimir IN FRAME F-Main
   NO-ENABLE                                                            */
/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME


/* Setting information for Queries and Browse Widgets fields            */

&ANALYZE-SUSPEND _QUERY-BLOCK FRAME F-Main
/* Query rebuild information for FRAME F-Main
     _Options          = "NO-LOCK"
     _Query            is NOT OPENED
*/  /* FRAME F-Main */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME btn_ejecutar
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btn_ejecutar V-table-Win
ON CHOOSE OF btn_ejecutar IN FRAME F-Main /* Ejecutar */
DO:
 
  RUN get-link-handle IN adm-broker-hdl
       (THIS-PROCEDURE, 'Container-Source':U, OUTPUT c_window).
  IF NUM-ENTRIES (c_window) eq 1 THEN DO:
    h_window = WIDGET-HANDLE (c_window).
    RUN lst-ejecutar IN h_window.
  END.
  ELSE MESSAGE c_window VIEW-AS ALERT-BOX MESSAGE TITLE "p-ejecutarPAU.w".

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btn_imprimir
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btn_imprimir V-table-Win
ON CHOOSE OF btn_imprimir IN FRAME F-Main /* Imprimir Listado */
DO:
  RUN get-link-handle IN adm-broker-hdl
       (THIS-PROCEDURE, 'Container-Source':U, OUTPUT c_window).
  IF NUM-ENTRIES (c_window) eq 1 THEN DO:
    h_window = WIDGET-HANDLE (c_window).
    RUN lst-imprimir IN h_window.
  END.
  ELSE MESSAGE c_window VIEW-AS ALERT-BOX MESSAGE TITLE "p-ejecutarPAU.w".

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btn_salir
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btn_salir V-table-Win
ON CHOOSE OF btn_salir IN FRAME F-Main /* Salir */
DO:
  RUN get-link-handle IN adm-broker-hdl
       (THIS-PROCEDURE, 'Container-Source':U, OUTPUT c_window).
  IF NUM-ENTRIES (c_window) eq 1 THEN DO:
    h_window = WIDGET-HANDLE (c_window).
    RUN salir IN h_window.
  END.
  ELSE MESSAGE c_window VIEW-AS ALERT-BOX MESSAGE TITLE "p-ejecutarPAU.w".

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btn_verlistado
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btn_verlistado V-table-Win
ON CHOOSE OF btn_verlistado IN FRAME F-Main /* Ver Listado */
DO:

  RUN get-link-handle IN adm-broker-hdl
       (THIS-PROCEDURE, 'Container-Source':U, OUTPUT c_window).
  IF NUM-ENTRIES (c_window) eq 1 THEN DO:
    h_window = WIDGET-HANDLE (c_window).
    RUN lst-mostrar IN h_window.
  END.
  ELSE MESSAGE c_window VIEW-AS ALERT-BOX MESSAGE TITLE "p-ejecutarPAU.w".

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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE habilitar_botones V-table-Win 
PROCEDURE habilitar_botones :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

  DEFINE INPUT PARAMETER str_habilitar AS CHARACTER.
  
  DEFINE VARIABLE j                    AS INTEGER.
  DEFINE VARIABLE v-habilita           AS LOGICAL.
  
  DO j = 1 TO NUM-ENTRIES(str_habilitar,","):

     v-habilita = ENTRY(2,ENTRY(j,str_habilitar,","),"=") = "SI".
     
     CASE ENTRY(1,ENTRY(j,str_habilitar,","),"="):
          WHEN "salir"      THEN btn_salir:SENSITIVE      IN FRAME {&FRAME-NAME} =  v-habilita.
          WHEN "ejecutar"   THEN btn_ejecutar:SENSITIVE   IN FRAME {&FRAME-NAME} =  v-habilita.
          WHEN "imprimir"   THEN btn_imprimir:SENSITIVE   IN FRAME {&FRAME-NAME} =  v-habilita.
          WHEN "verlistado" THEN btn_verlistado:SENSITIVE IN FRAME {&FRAME-NAME} =  v-habilita.
     END CASE.
     
  END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE local-initialize V-table-Win 
PROCEDURE local-initialize :
/*------------------------------------------------------------------------------
  Purpose:     Override standard ADM method
  Notes:       
------------------------------------------------------------------------------*/

  /* Code placed here will execute PRIOR to standard behavior. */

  /* Dispatch standard ADM method.                             */
  RUN dispatch IN THIS-PROCEDURE ( INPUT 'initialize':U ) .

  /* Code placed here will execute AFTER standard behavior.    */

  /* Ask the Record-Source for the current customer record.  Make sure
     there is only one.*/

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

  /* SEND-RECORDS does nothing because there are no External
     Tables specified for this SmartViewer, and there are no
     tables specified in any contained Browse, Query, or Frame. */

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

