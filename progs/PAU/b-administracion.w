&ANALYZE-SUSPEND _VERSION-NUMBER UIB_v8r12 GUI ADM1
&ANALYZE-RESUME
/* Connected Databases 
          sic              PROGRESS
*/
&Scoped-define WINDOW-NAME CURRENT-WINDOW


/* Temp-Table and Buffer definitions                                    */
DEFINE BUFFER Administrador FOR Cliente.



&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _DEFINITIONS B-table-Win 
/*------------------------------------------------------------------------

  File:  

  Description: from BROWSER.W - Basic SmartBrowser Object Template

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
  {windows.i}

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE SmartBrowser
&Scoped-define DB-AWARE no

&Scoped-define ADM-SUPPORTED-LINKS Record-Source,Record-Target,TableIO-Target

/* Name of first Frame and/or Browse and/or first Query                 */
&Scoped-define FRAME-NAME F-Main
&Scoped-define BROWSE-NAME br_table

/* Internal Tables (found by Frame, Query & Browse Queries)             */
&Scoped-define INTERNAL-TABLES Cliente

/* Define KEY-PHRASE in case it is used by any query. */
&Scoped-define KEY-PHRASE TRUE

/* Definitions for BROWSE br_table                                      */
&Scoped-define FIELDS-IN-QUERY-br_table Cliente.cdg_cliente Cliente.nom_cliente Cliente.direccion Cliente.telefonos   
&Scoped-define ENABLED-FIELDS-IN-QUERY-br_table   
&Scoped-define SELF-NAME br_table
&Scoped-define QUERY-STRING-br_table FOR EACH Cliente WHERE ~{&KEY-PHRASE}       AND cliente.nro_cliente = cliente.nro_administrador NO-LOCK     BY Cliente.nom_cliente
&Scoped-define OPEN-QUERY-br_table OPEN QUERY {&SELF-NAME} FOR EACH Cliente WHERE ~{&KEY-PHRASE}       AND cliente.nro_cliente = cliente.nro_administrador NO-LOCK     BY Cliente.nom_cliente.
&Scoped-define TABLES-IN-QUERY-br_table Cliente
&Scoped-define FIRST-TABLE-IN-QUERY-br_table Cliente


/* Definitions for FRAME F-Main                                         */

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS buscar Relegir que_nombre c_nro_tipo_evento ~
br_table 
&Scoped-Define DISPLAYED-OBJECTS Relegir que_nombre c_nro_tipo_evento 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _XFTR "Foreign Keys" B-table-Win _INLINE
/* Actions: ? adm/support/keyedit.w ? ? ? */
/* STRUCTURED-DATA
<KEY-OBJECT>
&BROWSE-NAME
</KEY-OBJECT>
<FOREIGN-KEYS>
cdg_cliente||y|sic.Cliente.cdg_cliente
nro_administrador||y|sic.Cliente.nro_administrador
nro_cliente||y|sic.Cliente.nro_cliente
</FOREIGN-KEYS> 
<EXECUTING-CODE>
**************************
* Set attributes related to FOREIGN KEYS
*/
RUN set-attribute-list (
    'Keys-Accepted = ,
     Keys-Supplied = "cdg_cliente,nro_administrador,nro_cliente"':U).

/* Tell the ADM to use the OPEN-QUERY-CASES. */
&Scoped-define OPEN-QUERY-CASES RUN dispatch ('open-query-cases':U).
/**************************
</EXECUTING-CODE> */
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _XFTR "Advanced Query Options" B-table-Win _INLINE
/* Actions: ? adm/support/advqedit.w ? ? ? */
/* STRUCTURED-DATA
<KEY-OBJECT>
&BROWSE-NAME
</KEY-OBJECT>
<SORTBY-OPTIONS>
</SORTBY-OPTIONS>
<SORTBY-RUN-CODE>
************************
* Set attributes related to SORTBY-OPTIONS */
RUN set-attribute-list (
    'SortBy-Options = ""':U).
/************************
</SORTBY-RUN-CODE>
<FILTER-ATTRIBUTES>
</FILTER-ATTRIBUTES> */   

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

/* ************************  Function Prototypes ********************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION-FORWARD contratos_activosADM B-table-Win 
FUNCTION contratos_activosADM RETURNS LOGICAL
  ( c_nro_tipo_evento AS INT )  FORWARD.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


/* ***********************  Control Definitions  ********************** */


/* Definitions of the field level widgets                               */
DEFINE BUTTON buscar 
     LABEL "Buscar" 
     SIZE 15 BY 1.14.

DEFINE VARIABLE c_nro_tipo_evento AS INTEGER FORMAT "->9" INITIAL -1 
     LABEL "CA" 
     VIEW-AS COMBO-BOX SORT INNER-LINES 5
     LIST-ITEM-PAIRS "**",-1
     DROP-DOWN-LIST
     SIZE 7.8 BY 1 TOOLTIP "Tipo de evento que genera el contrato"
     BGCOLOR 15 FGCOLOR 9 .

DEFINE VARIABLE que_nombre AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 27.6 BY 1 NO-UNDO.

DEFINE VARIABLE Relegir AS CHARACTER 
     VIEW-AS RADIO-SET HORIZONTAL
     RADIO-BUTTONS 
          "Nombre", "1",
"Dirección", "2",
"Codigo", "3",
"Evento", "4",
"Tarea", "5",
"CUIT", "6"
     SIZE 86 BY 1.19 NO-UNDO.

/* Query definitions                                                    */
&ANALYZE-SUSPEND
DEFINE QUERY br_table FOR 
      Cliente SCROLLING.
&ANALYZE-RESUME

/* Browse definitions                                                   */
DEFINE BROWSE br_table
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS br_table B-table-Win _FREEFORM
  QUERY br_table NO-LOCK DISPLAY
      Cliente.cdg_cliente COLUMN-LABEL "Codigo" FORMAT "X(8)":U
      Cliente.nom_cliente COLUMN-LABEL "Administración" FORMAT "X(40)":U
            WIDTH 56.2
      Cliente.direccion COLUMN-LABEL "Dirección" FORMAT "X(45)":U
      Cliente.telefonos COLUMN-LABEL "Teléfonos" FORMAT "X(30)":U WIDTH 44.8
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ASSIGN SEPARATORS SIZE 152 BY 4.29 ROW-HEIGHT-CHARS .62 FIT-LAST-COLUMN.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME F-Main
     buscar AT ROW 1 COL 34
     Relegir AT ROW 1 COL 51 NO-LABEL
     que_nombre AT ROW 1.1 COL 1.4 NO-LABEL
     c_nro_tipo_evento AT ROW 1.24 COL 144 COLON-ALIGNED WIDGET-ID 28
     br_table AT ROW 2.43 COL 1
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1 SCROLLABLE .


/* *********************** Procedure Settings ************************ */

&ANALYZE-SUSPEND _PROCEDURE-SETTINGS
/* Settings for THIS-PROCEDURE
   Type: SmartBrowser
   Allow: Basic,Browse
   Frames: 1
   Add Fields to: EXTERNAL-TABLES
   Other Settings: PERSISTENT-ONLY COMPILE
   Temp-Tables and Buffers:
      TABLE: Administrador B "?" ? sic Cliente
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
  CREATE WINDOW B-table-Win ASSIGN
         HEIGHT             = 6.14
         WIDTH              = 156.8.
/* END WINDOW DEFINITION */
                                                                        */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _INCLUDED-LIB B-table-Win 
/* ************************* Included-Libraries *********************** */

{src/adm/method/browser.i}

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME




/* ***********  Runtime Attributes and AppBuilder Settings  *********** */

&ANALYZE-SUSPEND _RUN-TIME-ATTRIBUTES
/* SETTINGS FOR WINDOW B-table-Win
  NOT-VISIBLE,,RUN-PERSISTENT                                           */
/* SETTINGS FOR FRAME F-Main
   NOT-VISIBLE Size-to-Fit                                              */
/* BROWSE-TAB br_table c_nro_tipo_evento F-Main */
ASSIGN 
       FRAME F-Main:SCROLLABLE       = FALSE
       FRAME F-Main:HIDDEN           = TRUE.

/* SETTINGS FOR FILL-IN que_nombre IN FRAME F-Main
   ALIGN-L                                                              */
/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME


/* Setting information for Queries and Browse Widgets fields            */

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE br_table
/* Query rebuild information for BROWSE br_table
     _START_FREEFORM
OPEN QUERY {&SELF-NAME} FOR EACH Cliente WHERE ~{&KEY-PHRASE}
      AND cliente.nro_cliente = cliente.nro_administrador NO-LOCK
    BY Cliente.nom_cliente.
     _END_FREEFORM
     _Options          = "NO-LOCK KEY-PHRASE"
     _TblOptList       = ", FIRST"
     _OrdList          = "sic.Cliente.nom_cliente|yes"
     _Where[1]         = "Cliente.cdg_cliente BEGINS ""A"""
     _Query            is NOT OPENED
*/  /* BROWSE br_table */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _QUERY-BLOCK FRAME F-Main
/* Query rebuild information for FRAME F-Main
     _Options          = "NO-LOCK"
     _Query            is NOT OPENED
*/  /* FRAME F-Main */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define BROWSE-NAME br_table
&Scoped-define SELF-NAME br_table
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL br_table B-table-Win
ON ROW-DISPLAY OF br_table IN FRAME F-Main
DO:
IF AVAILABLE cliente THEN DO:

  IF contratos_activosADM(c_nro_tipo_evento) THEN DO:
      FIND tipo_evento WHERE tipo_evento.nro_tipo_evento = c_nro_tipo_evento NO-LOCK NO-ERROR.
      IF AVAILABLE tipo_evento THEN DO:
          cliente.cdg_cliente:FGCOLOR IN BROWSE {&BROWSE-NAME} = tipo_evento.color_letra.
          cliente.cdg_cliente:BGCOLOR IN BROWSE {&BROWSE-NAME} = tipo_evento.color_fondo.
      END.
      ELSE DO:
          cliente.cdg_cliente:FGCOLOR IN BROWSE {&BROWSE-NAME} = 10.
          cliente.cdg_cliente:BGCOLOR IN BROWSE {&BROWSE-NAME} = 3.
      END.
  END.
END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL br_table B-table-Win
ON ROW-ENTRY OF br_table IN FRAME F-Main
DO:
  /* This code displays initial values for newly added or copied rows. */
  {src/adm/template/brsentry.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL br_table B-table-Win
ON ROW-LEAVE OF br_table IN FRAME F-Main
DO:
    /* Do not disable this code or no updates will take place except
     by pressing the Save button on an Update SmartPanel. */
   {src/adm/template/brsleave.i}
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL br_table B-table-Win
ON VALUE-CHANGED OF br_table IN FRAME F-Main
DO:
  /* This ADM trigger code must be preserved in order to notify other
     objects when the browser's current row changes. */
  {src/adm/template/brschnge.i}

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME buscar
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL buscar B-table-Win
ON CHOOSE OF buscar IN FRAME F-Main /* Buscar */
DO:
  APPLY "return" TO que_nombre.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME c_nro_tipo_evento
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL c_nro_tipo_evento B-table-Win
ON MOUSE-MENU-CLICK OF c_nro_tipo_evento IN FRAME F-Main /* CA */
DO:
  /*fuerza la apertura del combo y lo deja abierto*/
&GLOBAL-DEFINE CB_SHOWDROPDOWN 335
 
DEFINE VARIABLE retval AS INTEGER NO-UNDO.
 
  RUN SendMessage{&A} IN hpApi (INPUT  c_nro_tipo_evento:HWND,
                                       {&CB_SHOWDROPDOWN},
                                       1,   /* True */
                                       0,
                                OUTPUT retval
                                )
                                NO-ERROR /* Stop C Stack Errors */.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL c_nro_tipo_evento B-table-Win
ON VALUE-CHANGED OF c_nro_tipo_evento IN FRAME F-Main /* CA */
DO:

    ASSIGN c_nro_tipo_evento.

&GLOBAL-DEFINE CB_SHOWDROPDOWN 335
 
DEFINE VARIABLE retval AS INTEGER NO-UNDO.
 
  RUN SendMessage{&A} IN hpApi (INPUT  c_nro_tipo_evento:HWND,
                                       {&CB_SHOWDROPDOWN},
                                       1,   /* True */
                                       0,
                                OUTPUT retval
                                )
                                NO-ERROR /* Stop C Stack Errors */.
    APPLY "return" TO que_nombre.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME que_nombre
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL que_nombre B-table-Win
ON return OF que_nombre IN FRAME F-Main
DO:
  DEFINE VAR nro AS INT NO-UNDO.
  nro = INT(que_nombre) NO-ERROR.

  ASSIGN que_nombre relegir.
  IF relegir = "5" THEN
        FIND tarea WHERE tarea.nro_tarea = nro NO-ERROR.
  IF relegir = "4" THEN
        FIND evento WHERE evento.nro_evento = nro NO-ERROR.
  IF que_nombre = "" THEN 
        OPEN QUERY {&SELF-NAME} FOR EACH Cliente WHERE 
       cliente.nro_cliente = cliente.nro_administrador NO-LOCK
    BY Cliente.nom_cliente.
  ELSE DO:
      IF relegir = "1" THEN
          OPEN QUERY {&BROWSE-NAME} FOR EACH Cliente WHERE 
         cliente.nro_cliente = cliente.nro_administrador AND 
          cliente.nom_cliente CONTAINS que_nombre NO-LOCK
        BY Cliente.nom_cliente.
      ELSE IF relegir = "2" THEN
          OPEN QUERY {&BROWSE-NAME} FOR EACH Cliente WHERE 
         cliente.nro_cliente = cliente.nro_administrador and
              cliente.direccion CONTAINS que_nombre NO-LOCK
        BY Cliente.direccion.
      ELSE IF relegir = "3" THEN
          OPEN QUERY {&BROWSE-NAME} FOR EACH Cliente WHERE 
         cliente.nro_cliente = cliente.nro_administrador and
              cliente.cdg_cliente begins que_nombre NO-LOCK
         BY Cliente.cdg_cliente.
      ELSE IF relegir = "4" THEN
          OPEN QUERY {&BROWSE-NAME} FOR EACH cliente OF evento NO-LOCK.
      ELSE IF relegir = "5" THEN
          OPEN QUERY {&BROWSE-NAME} FOR EACH cliente OF tarea NO-LOCK.
      ELSE IF relegir = "6" THEN
          OPEN QUERY {&BROWSE-NAME} FOR EACH cliente WHERE cliente.cuit BEGINS que_nombre NO-LOCK.
  END.
  RUN dispatch IN THIS-PROCEDURE ('row-changed':U).
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&UNDEFINE SELF-NAME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _MAIN-BLOCK B-table-Win 


/* ***************************  Main Block  *************************** */

&IF DEFINED(UIB_IS_RUNNING) <> 0 &THEN          
RUN dispatch IN THIS-PROCEDURE ('initialize':U).        
&ENDIF

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


/* **********************  Internal Procedures  *********************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE adm-open-query-cases B-table-Win  adm/support/_adm-opn.p
PROCEDURE adm-open-query-cases :
/*------------------------------------------------------------------------------
  Purpose:     Opens different cases of the query based on attributes
               such as the 'Key-Name', or 'SortBy-Case'
  Parameters:  <none>
------------------------------------------------------------------------------*/

  /* No Foreign keys are accepted by this SmartObject. */

  {&OPEN-QUERY-{&BROWSE-NAME}}

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE adm-row-available B-table-Win  _ADM-ROW-AVAILABLE
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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE disable_UI B-table-Win  _DEFAULT-DISABLE
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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE local-initialize B-table-Win 
PROCEDURE local-initialize :
/*------------------------------------------------------------------------------
  Purpose:     Override standard ADM method
  Notes:       
------------------------------------------------------------------------------*/

    DEFINE VAR lista AS CHAR NO-UNDO.
    lista = ",**,-1".
    FOR EACH tipo_evento:
        lista = lista + "," + tipo_evento.cdg_tipo + "," + STRING(tipo_evento.nro_tipo_evento).
    END.  /* Dispatch standard ADM method.    */
    IF NUM-ENTRIES(lista) >= 2 THEN
    c_nro_tipo_evento:LIST-ITEM-PAIRS IN FRAME {&FRAME-NAME} = substring(lista,2).

  /* Code placed here will execute PRIOR to standard behavior. */

  /* Dispatch standard ADM method.                             */
  RUN dispatch IN THIS-PROCEDURE ( INPUT 'initialize':U ) .

  /* Code placed here will execute AFTER standard behavior.    */

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE posicionar_query B-table-Win 
PROCEDURE posicionar_query :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

  DEFINE INPUT PARAMETER rid AS ROWID.
  
  REPOSITION {&BROWSE-NAME} TO ROWID rid.
  GET NEXT {&BROWSE-NAME}.

  RUN dispatch IN THIS-PROCEDURE ('row-changed':U).


END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE send-key B-table-Win  adm/support/_key-snd.p
PROCEDURE send-key :
/*------------------------------------------------------------------------------
  Purpose:     Sends a requested KEY value back to the calling
               SmartObject.
  Parameters:  <see adm/template/sndkytop.i>
------------------------------------------------------------------------------*/

  /* Define variables needed by this internal procedure.             */
  {src/adm/template/sndkytop.i}

  /* Return the key value associated with each key case.             */
  {src/adm/template/sndkycas.i "cdg_cliente" "Cliente" "cdg_cliente"}
  {src/adm/template/sndkycas.i "nro_administrador" "Cliente" "nro_administrador"}
  {src/adm/template/sndkycas.i "nro_cliente" "Cliente" "nro_cliente"}

  /* Close the CASE statement and end the procedure.                 */
  {src/adm/template/sndkyend.i}

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE send-records B-table-Win  _ADM-SEND-RECORDS
PROCEDURE send-records :
/*------------------------------------------------------------------------------
  Purpose:     Send record ROWID's for all tables used by
               this file.
  Parameters:  see template/snd-head.i
------------------------------------------------------------------------------*/

  /* Define variables needed by this internal procedure.               */
  {src/adm/template/snd-head.i}

  /* For each requested table, put it's ROWID in the output list.      */
  {src/adm/template/snd-list.i "Cliente"}

  /* Deal with any unexpected table requests before closing.           */
  {src/adm/template/snd-end.i}

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE state-changed B-table-Win 
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
      {src/adm/template/bstates.i}
  END CASE.

  CASE p-state:
    WHEN "update":U THEN DO:
        que_nombre:SENSITIVE = FALSE.
        relegir:SENSITIVE = FALSE.
        buscar:SENSITIVE = FALSE.
    END.
    WHEN "update-complete":U THEN DO:
        que_nombre:SENSITIVE = true.
        relegir:SENSITIVE = true.
        buscar:SENSITIVE = true.
    END.
    WHEN "refrescar":U THEN DO:
        APPLY "value-changed" TO {&BROWSE-NAME}.
    END.

END CASE.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

/* ************************  Function Implementations ***************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION contratos_activosADM B-table-Win 
FUNCTION contratos_activosADM RETURNS LOGICAL
  ( c_nro_tipo_evento AS INT ) :
/*------------------------------------------------------------------------------
  Purpose:  retorna true si existe un contrato activo de algun cliente de un administrador    sino da true.
------------------------------------------------------------------------------*/
DEFINE BUFFER bcliente FOR cliente.
    FOR EACH bcliente WHERE bcliente.nro_administrador = cliente.nro_cliente:
        IF CAN-FIND( FIRST  Contrato_hd OF bcliente WHERE
              contrato_hd.estado = "A" AND 
              (contrato_hd.nro_tipo_evento = c_nro_tipo_evento OR c_nro_tipo_evento = -1 ) AND
              Contrato_hd.fecha_baja = ?  AND
              Contrato_hd.rige_hasta > TODAY AND
              ( contrato_hd.cant_periodos  = contrato_hd.resto_periodos OR
              contrato_hd.resto_periodos > 0 ) ) THEN
            RETURN TRUE.
    END.
RETURN FALSE.
END FUNCTION.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

