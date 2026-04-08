&ANALYZE-SUSPEND _VERSION-NUMBER UIB_v8r12 GUI ADM1
&ANALYZE-RESUME
/* Connected Databases 
          sic              PROGRESS
*/
&Scoped-define WINDOW-NAME CURRENT-WINDOW


/* Temp-Table and Buffer definitions                                    */
DEFINE BUFFER b_Contrato_Restriccion FOR Contrato_Restriccion.



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
DEF VAR que_empresa LIKE Empresa.cdg_empresa NO-UNDO.
DEF VAR que_sector LIKE  Area.cdg_area NO-UNDO.
DEFINE VARIABLE rid_tabla                 AS ROWID.
DEFINE BUFFER b_contrato_hd FOR contrato_hd.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE SmartV8Viewer
&Scoped-define DB-AWARE no

&Scoped-define ADM-SUPPORTED-LINKS Record-Source,Record-Target,TableIO-Target

/* Name of designated FRAME-NAME and/or first browse and/or first query */
&Scoped-define FRAME-NAME F-Main
&Scoped-define BROWSE-NAME BROWSE-4

/* External Tables                                                      */
&Scoped-define EXTERNAL-TABLES Contrato_Restriccion
&Scoped-define FIRST-EXTERNAL-TABLE Contrato_Restriccion


/* Need to scope the external tables to this procedure                  */
DEFINE QUERY external_tables FOR Contrato_Restriccion.
/* Internal Tables (found by Frame, Query & Browse Queries)             */
&Scoped-define INTERNAL-TABLES b_Contrato_Restriccion restriccion

/* Definitions for BROWSE BROWSE-4                                      */
&Scoped-define FIELDS-IN-QUERY-BROWSE-4 restriccion.cdg_restriccion b_Contrato_Restriccion.Valor   
&Scoped-define ENABLED-FIELDS-IN-QUERY-BROWSE-4   
&Scoped-define SELF-NAME BROWSE-4
&Scoped-define QUERY-STRING-BROWSE-4 FOR EACH b_Contrato_Restriccion WHERE b_Contrato_Restriccion.nro_contrato  =         integer(v-valor:SCREEN-VALUE IN FRAME {&FRAME-NAME}) AND         b_Contrato_Restriccion.sub_evento  =         integer(v-sub_evento:SCREEN-VALUE IN FRAME {&FRAME-NAME}) , ~
               FIRST restriccion OF  b_Contrato_Restriccion  NO-LOCK INDEXED-REPOSITION
&Scoped-define OPEN-QUERY-BROWSE-4 OPEN QUERY {&SELF-NAME}     FOR EACH b_Contrato_Restriccion WHERE b_Contrato_Restriccion.nro_contrato  =         integer(v-valor:SCREEN-VALUE IN FRAME {&FRAME-NAME}) AND         b_Contrato_Restriccion.sub_evento  =         integer(v-sub_evento:SCREEN-VALUE IN FRAME {&FRAME-NAME}) , ~
               FIRST restriccion OF  b_Contrato_Restriccion  NO-LOCK INDEXED-REPOSITION.
&Scoped-define TABLES-IN-QUERY-BROWSE-4 b_Contrato_Restriccion restriccion
&Scoped-define FIRST-TABLE-IN-QUERY-BROWSE-4 b_Contrato_Restriccion
&Scoped-define SECOND-TABLE-IN-QUERY-BROWSE-4 restriccion


/* Definitions for FRAME F-Main                                         */
&Scoped-define OPEN-BROWSERS-IN-QUERY-F-Main ~
    ~{&OPEN-QUERY-BROWSE-4}

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-FIELDS Contrato_Restriccion.Valor 
&Scoped-define ENABLED-TABLES Contrato_Restriccion
&Scoped-define FIRST-ENABLED-TABLE Contrato_Restriccion
&Scoped-Define ENABLED-OBJECTS BROWSE-4 
&Scoped-Define DISPLAYED-FIELDS Contrato_Restriccion.Valor 
&Scoped-define DISPLAYED-TABLES Contrato_Restriccion
&Scoped-define FIRST-DISPLAYED-TABLE Contrato_Restriccion
&Scoped-Define DISPLAYED-OBJECTS v-Valor v-sub_evento v-cdg_cliente ~
v-dsc_cliente 

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

/* ************************  Function Prototypes ********************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION-FORWARD muestra-error V-table-Win 
FUNCTION muestra-error RETURNS CHARACTER
  ( INPUT msg AS char )  FORWARD.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION-FORWARD QUE_VALOR V-table-Win 
FUNCTION QUE_VALOR RETURNS CHARACTER
  ( /* parameter-definitions */ )  FORWARD.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


/* ***********************  Control Definitions  ********************** */


/* Definitions of the field level widgets                               */
DEFINE VARIABLE v-cdg_cliente AS CHARACTER FORMAT "X(8)" 
     LABEL "Cliente" 
      VIEW-AS TEXT 
     SIZE 13 BY .62
     BGCOLOR 15 FGCOLOR 9  NO-UNDO.

DEFINE VARIABLE v-dsc_cliente AS CHARACTER FORMAT "X(256)":U 
     LABEL "Nombre" 
      VIEW-AS TEXT 
     SIZE 57 BY .62
     BGCOLOR 15 FGCOLOR 9  NO-UNDO.

DEFINE VARIABLE v-sub_evento AS INTEGER FORMAT ">9":U INITIAL 1 
     LABEL "Sub-Evento" 
     VIEW-AS FILL-IN NATIVE 
     SIZE 5 BY 1
     BGCOLOR 15 FGCOLOR 9  NO-UNDO.

DEFINE VARIABLE v-Valor LIKE Contrato_Restriccion.Valor
     LABEL "Contrato Restrictor" 
     VIEW-AS FILL-IN NATIVE 
     SIZE 13 BY .95 TOOLTIP "Contrato restrictor cabecera del bloque"
     BGCOLOR 15 FGCOLOR 9  NO-UNDO.

/* Query definitions                                                    */
&ANALYZE-SUSPEND
DEFINE QUERY BROWSE-4 FOR 
      b_Contrato_Restriccion, 
      restriccion SCROLLING.
&ANALYZE-RESUME

/* Browse definitions                                                   */
DEFINE BROWSE BROWSE-4
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS BROWSE-4 V-table-Win _FREEFORM
  QUERY BROWSE-4 NO-LOCK DISPLAY
      restriccion.cdg_restriccion FORMAT "X(8)":U
      b_Contrato_Restriccion.Valor FORMAT "X(20)":U
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ROW-MARKERS SEPARATORS SIZE 74 BY 3.57 ROW-HEIGHT-CHARS .57 FIT-LAST-COLUMN.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME F-Main
     v-Valor AT ROW 1 COL 22 COLON-ALIGNED HELP
          "Valor de la restriccion"
          LABEL "Contrato Restrictor" FORMAT "x(10)"
          BGCOLOR 15 FGCOLOR 9 
     v-sub_evento AT ROW 1 COL 50.4 COLON-ALIGNED WIDGET-ID 4
     Contrato_Restriccion.Valor AT ROW 2.67 COL 72 COLON-ALIGNED NO-LABEL WIDGET-ID 2
          VIEW-AS FILL-IN 
          SIZE 4 BY 1
     BROWSE-4 AT ROW 4.33 COL 5
     v-cdg_cliente AT ROW 2.29 COL 11 COLON-ALIGNED
     v-dsc_cliente AT ROW 3.14 COL 11 COLON-ALIGNED
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1 SCROLLABLE .


/* *********************** Procedure Settings ************************ */

&ANALYZE-SUSPEND _PROCEDURE-SETTINGS
/* Settings for THIS-PROCEDURE
   Type: SmartV8Viewer
   External Tables: sic.Contrato_Restriccion
   Allow: Basic,Browse,DB-Fields
   Frames: 1
   Add Fields to: External-Tables
   Other Settings: PERSISTENT-ONLY COMPILE
   Temp-Tables and Buffers:
      TABLE: b_Contrato_Restriccion B "?" ? sic Contrato_Restriccion
   END-TABLES.
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
         HEIGHT             = 7.19
         WIDTH              = 79.2.
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
/* BROWSE-TAB BROWSE-4 Valor F-Main */
ASSIGN 
       FRAME F-Main:SCROLLABLE       = FALSE
       FRAME F-Main:HIDDEN           = TRUE.

/* SETTINGS FOR FILL-IN v-cdg_cliente IN FRAME F-Main
   NO-ENABLE                                                            */
ASSIGN 
       v-cdg_cliente:READ-ONLY IN FRAME F-Main        = TRUE.

/* SETTINGS FOR FILL-IN v-dsc_cliente IN FRAME F-Main
   NO-ENABLE                                                            */
ASSIGN 
       v-dsc_cliente:READ-ONLY IN FRAME F-Main        = TRUE.

/* SETTINGS FOR FILL-IN v-sub_evento IN FRAME F-Main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN v-Valor IN FRAME F-Main
   NO-ENABLE LIKE = sic.Contrato_Restriccion.Valor EXP-LABEL EXP-FORMAT EXP-SIZE */
ASSIGN 
       Contrato_Restriccion.Valor:HIDDEN IN FRAME F-Main           = TRUE.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME


/* Setting information for Queries and Browse Widgets fields            */

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE BROWSE-4
/* Query rebuild information for BROWSE BROWSE-4
     _START_FREEFORM
OPEN QUERY {&SELF-NAME}
    FOR EACH b_Contrato_Restriccion WHERE b_Contrato_Restriccion.nro_contrato  =
        integer(v-valor:SCREEN-VALUE IN FRAME {&FRAME-NAME}) AND
        b_Contrato_Restriccion.sub_evento  =
        integer(v-sub_evento:SCREEN-VALUE IN FRAME {&FRAME-NAME}) ,
        FIRST restriccion OF  b_Contrato_Restriccion  NO-LOCK INDEXED-REPOSITION.
     _END_FREEFORM
     _Options          = "NO-LOCK INDEXED-REPOSITION"
     _JoinCode[1]      = "b_Contrato_Restriccion.nro_contrato  = integer(sic.Contrato_Restriccion.Valor:input-value)"
     _Query            is OPENED
*/  /* BROWSE BROWSE-4 */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _QUERY-BLOCK FRAME F-Main
/* Query rebuild information for FRAME F-Main
     _Options          = "NO-LOCK"
     _Query            is NOT OPENED
*/  /* FRAME F-Main */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME v-cdg_cliente
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-cdg_cliente V-table-Win
ON MOUSE-SELECT-DBLCLICK OF v-cdg_cliente IN FRAME F-Main /* Cliente */
OR "." OF v-cdg_cliente IN FRAME {&FRAME-NAME}
OR MOUSE-MENU-DOWN OF v-cdg_cliente IN FRAME {&FRAME-NAME}
DO:
   {helptabla.i "cliente" "cdg_cliente" "SELCLIEN.P"}
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-cdg_cliente V-table-Win
ON RETURN OF v-cdg_cliente IN FRAME F-Main /* Cliente */
DO:
     IF v-cdg_cliente:SCREEN-VALUE IN FRAME {&FRAME-NAME} <> ""
     THEN DO:
        FIND Cliente WHERE Cliente.cdg_cliente =  v-cdg_cliente:SCREEN-VALUE IN FRAME {&FRAME-NAME}
            AND LOOKUP(que_sector, Cliente.lista_sectores) <> 0 NO-LOCK NO-ERROR.
        IF NOT AVAILABLE Cliente 
        THEN DO:
             v-dsc_cliente:SCREEN-VALUE IN FRAME {&FRAME-NAME} = "".
             RUN PONMENSJ.P ( 'IREF002' ).
             RETURN NO-APPLY.
        END.
        
        v-dsc_cliente = Cliente.nom_cliente.
        DISPLAY v-dsc_cliente 
                WITH FRAME {&FRAME-NAME}. 
   
     END.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME v-Valor
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-Valor V-table-Win
ON LEAVE OF v-Valor IN FRAME F-Main /* Contrato Restrictor */
DO:
  DEF VAR a AS INT NO-UNDO.
  ASSIGN FRAME {&FRAME-NAME} v-valor .
  a = INT(v-valor) NO-ERROR.
  IF ERROR-STATUS:ERROR THEN do:
      muestra-error("El valor ingresado debe ser numerico").
      RETURN NO-APPLY.
  END.
  ELSE DO:
      FIND b_contrato_hd WHERE b_contrato_hd.nro_contrato = int(v-valor) NO-ERROR.
      IF AVAILABLE b_contrato_hd THEN DO:
          FIND cliente WHERE b_contrato_hd.NRO_CLIENTE = cliente.nro_cliente no-lock  NO-ERROR.
          v-cdg_cliente:SCREEN-VALUE= IF AVAILABLE cliente THEN cliente.cdg_cliente ELSE "ERROR".
          v-dsc_cliente:SCREEN-VALUE= IF AVAILABLE cliente THEN Cliente.nom_cliente ELSE "ERROR".
          {&OPEN-QUERY-{&BROWSE-NAME}} 
      END.
      ELSE do: 
          muestra-error("El contrato elegido no es valido").
          RETURN NO-APPLY.
      END.
  END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define BROWSE-NAME BROWSE-4
&UNDEFINE SELF-NAME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _MAIN-BLOCK V-table-Win 


/* ***************************  Main Block  *************************** */
{findempresa.i}
que_empresa = Empresa.cdg_empresa.
{findsector.i}
que_sector = Area.cdg_area.

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
  {src/adm/template/row-list.i "Contrato_Restriccion"}

  /* Get the record ROWID's from the RECORD-SOURCE.                  */
  {src/adm/template/row-get.i}

  /* FIND each record specified by the RECORD-SOURCE.                */
  {src/adm/template/row-find.i "Contrato_Restriccion"}

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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE local-disable-fields V-table-Win 
PROCEDURE local-disable-fields :
/*------------------------------------------------------------------------------
  Purpose:     Override standard ADM method
  Notes:       
------------------------------------------------------------------------------*/

  /* Code placed here will execute PRIOR to standard behavior. */

  /* Dispatch standard ADM method.                             */
  RUN dispatch IN THIS-PROCEDURE ( INPUT 'disable-fields':U ) .
  v-valor:SENSITIVE IN FRAME {&frame-name} = FALSE. 
  v-sub_evento:SENSITIVE IN FRAME {&frame-name} = FALSE. 
  v-cdg_cliente:SENSITIVE IN FRAME {&frame-name} = FALSE. 
  v-dsc_cliente:SENSITIVE IN FRAME {&frame-name} = FALSE .
  browse-4:SENSITIVE=FALSE.
  /* Code placed here will execute AFTER standard behavior.    */

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

IF AVAILABLE contrato_restriccion  THEN DO:
        v-valor = ENTRY(1,Contrato_restriccion.valor,"|") NO-ERROR.
        v-sub_evento = int(ENTRY(2,Contrato_restriccion.valor,"|")) NO-ERROR.
        DISPLAY v-valor v-sub_evento WITH FRAME {&FRAME-NAME}.        
        FIND b_contrato_hd WHERE b_contrato_hd.nro_contrato = int(v-valor) NO-ERROR.
        IF AVAILABLE b_contrato_hd THEN DO:
            FIND cliente OF b_contrato_hd NO-ERROR.
              v-cdg_cliente:SCREEN-VALUE= IF AVAILABLE cliente THEN cliente.cdg_cliente ELSE "ERROR".
              v-dsc_cliente:SCREEN-VALUE= IF AVAILABLE cliente THEN Cliente.nom_cliente ELSE "ERROR".
              {&OPEN-QUERY-{&BROWSE-NAME}}
        END.
        ELSE muestra-error("El valor de:" + Contrato_restriccion.valor + " no es valido se ignoraran").  
END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE local-enable-fields V-table-Win 
PROCEDURE local-enable-fields :
/*------------------------------------------------------------------------------
  Purpose:     Override standard ADM method
  Notes:       
------------------------------------------------------------------------------*/

  /* Code placed here will execute PRIOR to standard behavior. */

  /* Dispatch standard ADM method.                             */
  RUN dispatch IN THIS-PROCEDURE ( INPUT 'enable-fields':U ) .

/* Code placed here will execute AFTER standard behavior.    */
  v-valor:SENSITIVE IN FRAME {&frame-name} = TRUE. 
  v-sub_evento:SENSITIVE IN FRAME {&frame-name} = TRUE. 
  v-cdg_cliente:SENSITIVE IN FRAME {&frame-name} = TRUE. 
  v-dsc_cliente:SENSITIVE IN FRAME {&frame-name} = TRUE .
  browse-4:SENSITIVE=TRUE.

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
  {src/adm/template/snd-list.i "Contrato_Restriccion"}
  {src/adm/template/snd-list.i "b_Contrato_Restriccion"}
  {src/adm/template/snd-list.i "restriccion"}

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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION muestra-error V-table-Win 
FUNCTION muestra-error RETURNS CHARACTER
  ( INPUT msg AS char ) :
/*------------------------------------------------------------------------------
  Purpose:  
    Notes:  
------------------------------------------------------------------------------*/
DEF VAR h_cont AS HANDLE NO-UNDO.
RUN get-link-handle IN adm-broker-hdl
    ( INPUT THIS-PROCEDURE /* HANDLE */,
      INPUT 'container-source' /* CHARACTER */,
      OUTPUT h_cont /* CHARACTER */ ).
DYNAMIC-FUNCTION( 'muestra-error' IN h_cont , INPUT msg ).

  RETURN "".   /* Function return value. */

END FUNCTION.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION QUE_VALOR V-table-Win 
FUNCTION QUE_VALOR RETURNS CHARACTER
  ( /* parameter-definitions */ ) :
/*------------------------------------------------------------------------------
  Purpose:  
    Notes:  
------------------------------------------------------------------------------*/
  ASSIGN FRAME {&FRAME-NAME} v-valor v-sub_evento.
  RETURN trim(v-valor) + "|" + STRING(v-sub_evento).   /* Function return value. */

END FUNCTION.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

