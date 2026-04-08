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


DEFINE VAR hsource AS HANDLE NO-UNDO.
DEFINE VAR chsource AS CHAR NO-UNDO.
DEFINE VAR hframe AS HANDLE NO-UNDO.

DEF VAR repos_pend AS LOGICAL NO-UNDO INITIAL FALSE.
DEF VAR ant_restriccion LIKE restriccion.nro_restriccion INITIAL -1 NO-UNDO.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE SmartViewer
&Scoped-define DB-AWARE no

&Scoped-define ADM-SUPPORTED-LINKS Record-Source,Record-Target,TableIO-Target

/* Name of designated FRAME-NAME and/or first browse and/or first query */
&Scoped-define FRAME-NAME F-Main

/* External Tables                                                      */
&Scoped-define EXTERNAL-TABLES cliente_Restriccion
&Scoped-define FIRST-EXTERNAL-TABLE cliente_Restriccion


/* Need to scope the external tables to this procedure                  */
DEFINE QUERY external_tables FOR cliente_Restriccion.
/* Standard List Definitions                                            */
&Scoped-Define ENABLED-FIELDS cliente_restriccion.Prioridad 
&Scoped-define ENABLED-TABLES cliente_restriccion
&Scoped-define FIRST-ENABLED-TABLE cliente_restriccion
&Scoped-Define ENABLED-OBJECTS v_nro_restriccion 
&Scoped-Define DISPLAYED-FIELDS cliente_restriccion.Prioridad 
&Scoped-define DISPLAYED-TABLES cliente_restriccion
&Scoped-define FIRST-DISPLAYED-TABLE cliente_restriccion
&Scoped-Define DISPLAYED-OBJECTS v_nro_restriccion v-descripcion 

/* Custom List Definitions                                              */
/* ADM-CREATE-FIELDS,ADM-ASSIGN-FIELDS,List-3,List-4,List-5,List-6      */
&Scoped-define ADM-ASSIGN-FIELDS v_nro_restriccion 

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _XFTR "Foreign Keys" V-table-Win _INLINE
/* Actions: ? adm/support/keyedit.w ? ? ? */
/* STRUCTURED-DATA
<KEY-OBJECT>
THIS-PROCEDURE
</KEY-OBJECT>
<FOREIGN-KEYS>
nro_cliente||y|sic.cliente_Restriccion.nro_cliente
nro_restriccion||y|sic.cliente_Restriccion.nro_restriccion
nro_cliente||y|sic.cliente.nro_cliente
</FOREIGN-KEYS> 
<EXECUTING-CODE>
**************************
* Set attributes related to FOREIGN KEYS
*/
RUN set-attribute-list (
    'Keys-Accepted = ,
     Keys-Supplied = "nro_cliente,nro_restriccion,nro_cliente"':U).
/**************************
</EXECUTING-CODE> */
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

/* ************************  Function Prototypes ********************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION-FORWARD que_cliente V-table-Win 
FUNCTION que_cliente RETURNS INTEGER
  ( /* parameter-definitions */ )  FORWARD.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION-FORWARD que_lista_restriccion V-table-Win 
FUNCTION que_lista_restriccion RETURNS CHARACTER
  ( /* parameter-definitions */ )  FORWARD.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION-FORWARD que_sub_evento V-table-Win 
FUNCTION que_sub_evento RETURNS INTEGER
  ( /* parameter-definitions */ )  FORWARD.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION-FORWARD que_valor V-table-Win 
FUNCTION que_valor RETURNS CHARACTER
  ( /* parameter-definitions */ )  FORWARD.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


/* ***********************  Control Definitions  ********************** */


/* Definitions of the field level widgets                               */
DEFINE VARIABLE v_nro_restriccion AS INTEGER FORMAT ">>9" INITIAL 0 
     VIEW-AS COMBO-BOX INNER-LINES 15
     LIST-ITEM-PAIRS "Nada",0
     DROP-DOWN-LIST
     SIZE 15 BY 1 NO-UNDO.

DEFINE VARIABLE v-descripcion LIKE Restriccion.descripcion
     VIEW-AS FILL-IN 
     SIZE 54 BY 1 NO-UNDO.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME F-Main
     v_nro_restriccion AT ROW 1.24 COL 2 COLON-ALIGNED NO-LABEL
     v-descripcion AT ROW 1.24 COL 19 COLON-ALIGNED HELP
          "" NO-LABEL
     cliente_restriccion.Prioridad AT ROW 2.91 COL 5 HELP
          "" NO-LABEL WIDGET-ID 6
          VIEW-AS SLIDER MIN-VALUE 0 MAX-VALUE 9 HORIZONTAL 
          TIC-MARKS BOTTOM FREQUENCY 1
          SIZE 59 BY 1.43 TOOLTIP "Prioridad de esta restriccion vs. otra del mismo tipo"
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1 SCROLLABLE .


/* *********************** Procedure Settings ************************ */

&ANALYZE-SUSPEND _PROCEDURE-SETTINGS
/* Settings for THIS-PROCEDURE
   Type: SmartViewer
   External Tables: sic.cliente_Restriccion
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
         HEIGHT             = 3.38
         WIDTH              = 83.6.
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

/* SETTINGS FOR SLIDER cliente_restriccion.Prioridad IN FRAME F-Main
   EXP-HELP                                                             */
/* SETTINGS FOR FILL-IN v-descripcion IN FRAME F-Main
   NO-ENABLE LIKE = sic.Restriccion.descripcion EXP-SIZE                */
/* SETTINGS FOR COMBO-BOX v_nro_restriccion IN FRAME F-Main
   2                                                                    */
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

&Scoped-define SELF-NAME v_nro_restriccion
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v_nro_restriccion V-table-Win
ON VALUE-CHANGED OF v_nro_restriccion IN FRAME F-Main
DO:
    DEF VAR hproc2 AS HANDLE NO-UNDO.
    DEF VAR hcproc2 AS CHAR NO-UNDO.
    DEF VAR hproc AS HANDLE NO-UNDO.
    DEF VAR hcproc AS CHAR NO-UNDO.
    ASSIGN FRAME {&FRAME-NAME} v_nro_restriccion.
    FIND restriccion WHERE restriccion.nro_restriccion = v_nro_restriccion NO-LOCK NO-ERROR.
    
     IF AVAILABLE Restriccion THEN
         v-descripcion = restriccion.descripcion.
     ELSE 
         v-descripcion = "Restriccion no registrada".
    /*se modifico este descriptor se debe actualizar es registro 
    y reinstanciar el objeto que corresponde ya que no es el mismo 
    antes de prosegir*/
    
    RUN get-link-handle IN adm-broker-hdl
      ( INPUT THIS-PROCEDURE,
        INPUT "record-target",
        OUTPUT hcproc ).
    hproc = WIDGET-HANDLE(hcproc).
    IF VALID-HANDLE(hproc) THEN DO:
        RUN des-instanciar IN hproc.
        RUN instanciar IN hproc ( v_nro_restriccion ).
        ant_restriccion = v_nro_restriccion.
        RUN get-link-handle IN adm-broker-hdl
      ( INPUT THIS-PROCEDURE,
        INPUT "Group-Assign-target",
        OUTPUT hcproc2 ).
        hproc2 = WIDGET-HANDLE(hcproc2).
        IF NOT VALID-HANDLE(hproc2) THEN RUN add-link IN adm-broker-hdl ( THIS-PROCEDURE , 'Group-Assign':U , hproc ).
    END.
    cliente_restriccion.prioridad:screen-value = string(restriccion.prioridad,"99").  
    DISPLAY v_nro_restriccion v-descripcion WITH FRAME {&FRAME-NAME}.
    RUN GET-ATTRIBUTE ( INPUT "ADM-NEW-RECORD" ). /* Averiguamos si es un alta */

    RUN dispatch IN hproc ('enable-fields':U).

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

  /* Create a list of all the tables that we need to get.            */
  {src/adm/template/row-list.i "cliente_Restriccion"}

  /* Get the record ROWID's from the RECORD-SOURCE.                  */
  {src/adm/template/row-get.i}

  /* FIND each record specified by the RECORD-SOURCE.                */
  {src/adm/template/row-find.i "cliente_Restriccion"}

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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE local-assign-statement V-table-Win 
PROCEDURE local-assign-statement :
/*------------------------------------------------------------------------------
  Purpose:     Override standard ADM method
  Notes:       
------------------------------------------------------------------------------*/

  /* Code placed here will execute AFTER standard behavior.    */
  DEF VAR v_nro_cliente LIKE cliente_restriccion.nro_cliente NO-UNDO.
  DEF VAR rr AS ROWID NO-UNDO.
  DEF VAR v_valor AS CHARACTER NO-UNDO.

  ASSIGN FRAME {&FRAME-NAME} v_nro_restriccion.
  v_nro_cliente = que_cliente().

  v_valor = que_valor().
  RUN dispatch IN THIS-PROCEDURE ( INPUT 'assign-statement':U ) .
  IF NEW cliente_restriccion THEN
  ASSIGN cliente_restriccion.nro_cliente = v_nro_cliente.
         
  IF v_valor = ? THEN RETURN ERROR.
  ASSIGN cliente_restriccion.valor = v_valor.
         cliente_restriccion.nro_restriccion = v_nro_restriccion.


END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE local-enable-fields V-table-Win 
PROCEDURE local-enable-fields :
/*------------------------------------------------------------------------------
  Purpose:     Override standard ADM method
  Notes:       
------------------------------------------------------------------------------*/
DEF VAR hcproc AS CHARACTER NO-UNDO.
DEF VAR hproc AS HANDLE NO-UNDO.
  /* Code placed here will execute PRIOR to standard behavior. */
/* Code placed here will execute PRIOR to standard behavior. */
  RUN get-link-handle IN adm-broker-hdl
  ( INPUT THIS-PROCEDURE,
    INPUT "group-assign-target",
    OUTPUT hcproc ).
hproc = WIDGET-HANDLE(hcproc).
IF NOT VALID-HANDLE(hproc) THEN DO:
    RUN get-link-handle IN adm-broker-hdl
      ( INPUT THIS-PROCEDURE,
        INPUT "record-target",
        OUTPUT hcproc ).
    hproc = WIDGET-HANDLE(hcproc).
    RUN add-link IN adm-broker-hdl ( THIS-PROCEDURE , 'Group-Assign':U , hproc ). 
END.
  /* Dispatch standard ADM method.                             */
RUN dispatch IN THIS-PROCEDURE ( INPUT 'enable-fields':U ) .

  /* Code placed here will execute AFTER standard behavior.    */

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE local-end-update V-table-Win 
PROCEDURE local-end-update :
/*------------------------------------------------------------------------------
  Purpose:     Override standard ADM method
  Notes:       
------------------------------------------------------------------------------*/
  DEF VAR hcproc AS CHARACTER NO-UNDO.
  DEF VAR hproc AS HANDLE NO-UNDO.  
  /* Code placed here will execute PRIOR to standard behavior. */

  /* Dispatch standard ADM method.                             */
  RUN dispatch IN THIS-PROCEDURE ( INPUT 'end-update':U ) .


    RUN get-link-handle IN adm-broker-hdl
      ( INPUT THIS-PROCEDURE,
        INPUT "record-source",
        OUTPUT hcproc ).
    hproc = WIDGET-HANDLE(hcproc).
    IF VALID-HANDLE(hproc) THEN RUN re-reposicionar IN hproc ( ROWID(cliente_restriccion) ).

  /* Code placed here will execute AFTER standard behavior.    */

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE local-row-available V-table-Win 
PROCEDURE local-row-available :
/*------------------------------------------------------------------------------
  Purpose:     Override standard ADM method
  Notes:       
------------------------------------------------------------------------------*/
DEF VAR hcproc AS CHAR NO-UNDO.
DEF VAR hproc AS HANDLE NO-UNDO.
  /* Code placed here will execute PRIOR to standard behavior. */
/* Dispatch standard ADM method.                             */
RUN dispatch IN THIS-PROCEDURE ( INPUT 'row-available':U ) .
  
/* Code placed here will execute AFTER standard behavior.    */

v_nro_restriccion:LIST-ITEM-PAIRS IN FRAME {&FRAME-NAME} = que_lista_restriccion().
 
RUN get-link-handle IN adm-broker-hdl
   ( INPUT THIS-PROCEDURE,
     INPUT "record-target",
     OUTPUT hcproc ).
     hproc = WIDGET-HANDLE(hcproc).
 
IF AVAILABLE cliente_restriccion THEN DO:
         v_nro_restriccion = cliente_restriccion.nro_restriccion.
         IF ant_restriccion <> cliente_restriccion.nro_restriccion THEN DO:
           ant_restriccion = cliente_restriccion.nro_restriccion.
           FIND restriccion OF cliente_restriccion NO-LOCK NO-ERROR.
           IF AVAILABLE Restriccion THEN DO:
               v-descripcion = restriccion.descripcion.
               RUN re-instanciar IN hproc ( restriccion.nro_restriccion ).
           END.
           ELSE DO:
               v-descripcion = "".
               RUN re-instanciar IN hproc ( 0 ).
           END.
         END.
         DISPLAY v_nro_restriccion v-descripcion WITH FRAME {&FRAME-NAME}.
END.
  ELSE RUN re-instanciar IN hproc ( 0 ).

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE send-key V-table-Win  adm/support/_key-snd.p
PROCEDURE send-key :
/*------------------------------------------------------------------------------
  Purpose:     Sends a requested KEY value back to the calling
               SmartObject.
  Parameters:  <see adm/template/sndkytop.i>
------------------------------------------------------------------------------*/

  /* Define variables needed by this internal procedure.             */
  {src/adm/template/sndkytop.i}

  /* Return the key value associated with each key case.             */
  {src/adm/template/sndkycas.i "nro_cliente" "cliente_Restriccion" "nro_cliente"}
  {src/adm/template/sndkycas.i "nro_restriccion" "cliente_Restriccion" "nro_restriccion"}
  {src/adm/template/sndkycas.i "nro_cliente" "cliente" "nro_cliente"}

  /* Close the CASE statement and end the procedure.                 */
  {src/adm/template/sndkyend.i}

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
  {src/adm/template/snd-list.i "cliente_Restriccion"}

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

/* ************************  Function Implementations ***************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION que_cliente V-table-Win 
FUNCTION que_cliente RETURNS INTEGER
  ( /* parameter-definitions */ ) :
/*------------------------------------------------------------------------------
  Purpose:  
    Notes:  
------------------------------------------------------------------------------*/
DEF VAR hcp AS CHARACTER NO-UNDO.
DEF VAR hp AS HANDLE NO-UNDO.
      RUN get-link-handle IN adm-broker-hdl
            ( INPUT THIS-PROCEDURE,
              INPUT "record-source",
              OUTPUT hcp ).
        hp = WIDGET-HANDLE(hcp).
RETURN IF VALID-HANDLE( hp) THEN DYNAMIC-FUNCTION( "que_cliente" IN hp ) ELSE ?.
                                                                               
END FUNCTION.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION que_lista_restriccion V-table-Win 
FUNCTION que_lista_restriccion RETURNS CHARACTER
  ( /* parameter-definitions */ ) :
/*------------------------------------------------------------------------------
  Purpose:  
    Notes:  
------------------------------------------------------------------------------*/
DEF VAR hcp AS CHARACTER NO-UNDO.
DEF VAR hp AS HANDLE NO-UNDO.
      RUN get-link-handle IN adm-broker-hdl
            ( INPUT THIS-PROCEDURE,
              INPUT "record-source",
              OUTPUT hcp ).
        hp = WIDGET-HANDLE(hcp).
RETURN IF VALID-HANDLE( hp) THEN DYNAMIC-FUNCTION( "que_lista_restriccion" IN hp ) ELSE ?.
                                                                               
END FUNCTION.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION que_sub_evento V-table-Win 
FUNCTION que_sub_evento RETURNS INTEGER
  ( /* parameter-definitions */ ) :
/*------------------------------------------------------------------------------
  Purpose:  
    Notes:  
------------------------------------------------------------------------------*/
DEF VAR HCP AS CHARACTER NO-UNDO.
DEF VAR Hp AS HANDLE NO-UNDO.
RUN get-link-handle IN adm-broker-hdl
      ( INPUT THIS-PROCEDURE,
        INPUT "record-source",
        OUTPUT hcp ).
 hp = WIDGET-HANDLE( hcp ) .

RETURN IF VALID-HANDLE( hp) THEN DYNAMIC-FUNCTION( "que_sub_evento" IN hp ) ELSE ?.

END FUNCTION.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION que_valor V-table-Win 
FUNCTION que_valor RETURNS CHARACTER
  ( /* parameter-definitions */ ) :
/*------------------------------------------------------------------------------
  Purpose:  
    Notes:  
------------------------------------------------------------------------------*/
DEF VAR hcp AS CHARACTER NO-UNDO.
DEF VAR hp AS HANDLE NO-UNDO.
RUN get-link-handle IN adm-broker-hdl
            ( INPUT THIS-PROCEDURE,
              INPUT "record-target",
              OUTPUT hcp ).
        hp = WIDGET-HANDLE(hcp).
      
RETURN IF VALID-HANDLE( hp) THEN DYNAMIC-FUNCTION( "que_valor" IN hp ) ELSE ?.
END FUNCTION.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

