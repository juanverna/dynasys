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
DEFINE VAR que_empresa LIKE Empresa.cdg_empresa NO-UNDO.
DEFINE VAR que_sector LIKE Area.cdg_area NO-UNDO.

DEFINE VAR vcontratos_activos AS LOGICAL COLUMN-LABEL "CA" FORMAT "S/N".

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
&Scoped-define INTERNAL-TABLES Cliente Administrador

/* Define KEY-PHRASE in case it is used by any query. */
&Scoped-define KEY-PHRASE TRUE

/* Definitions for BROWSE br_table                                      */
&Scoped-define FIELDS-IN-QUERY-br_table Cliente.cdg_cliente Cliente.direccion Administrador.nom_cliente   
&Scoped-define ENABLED-FIELDS-IN-QUERY-br_table   
&Scoped-define SELF-NAME br_table
&Scoped-define OPEN-QUERY-br_table IF Relegir = "1" THEN     OPEN QUERY  {&BROWSE-NAME}  FOR EACH Cliente WHERE       Cliente.cdg_cliente BEGINS "C"   AND        cliente.direccion CONTAINS que_nombre NO-LOCK, ~
             FIRST Administrador WHERE       Administrador.nro_cliente = Cliente.nro_administrador NO-LOCK       BY Cliente.direccion. ELSE IF Relegir = "2" THEN     OPEN QUERY {&BROWSE-NAME}  FOR EACH Cliente WHERE         Cliente.cdg_cliente BEGINS "C"  NO-LOCK, ~
             FIRST Administrador WHERE       Administrador.nro_cliente = Cliente.nro_administrador and         administrador.nom_cliente CONTAINS que_nombre NO-LOCK       BY Administrador.nom_cliente BY Cliente.direccion. ELSE     OPEN QUERY {&BROWSE-NAME}  FOR EACH Cliente WHERE         Cliente.cdg_cliente BEGINS que_nombre   NO-LOCK, ~
             FIRST Administrador WHERE       Administrador.nro_cliente = Cliente.nro_administrador and         administrador.nom_cliente CONTAINS que_nombre NO-LOCK       BY Administrador.nom_cliente BY Cliente.direccion.
&Scoped-define TABLES-IN-QUERY-br_table Cliente Administrador
&Scoped-define FIRST-TABLE-IN-QUERY-br_table Cliente
&Scoped-define SECOND-TABLE-IN-QUERY-br_table Administrador


/* Definitions for FRAME F-Main                                         */

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS que_nombre Buscar Relegir Btodos ~
c_nro_tipo_evento br_table 
&Scoped-Define DISPLAYED-OBJECTS que_nombre Relegir c_nro_tipo_evento 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */
&Scoped-define List-1 c_nro_tipo_evento 

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _XFTR "Foreign Keys" B-table-Win _INLINE
/* Actions: ? adm/support/keyedit.w ? ? ? */
/* STRUCTURED-DATA
<KEY-OBJECT>
&BROWSE-NAME
</KEY-OBJECT>
<FOREIGN-KEYS>
</FOREIGN-KEYS
><EXECUTING-CODE>
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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION-FORWARD contratos_activos B-table-Win 
FUNCTION contratos_activos RETURNS LOGICAL
  ( c_nro_tipo_evento AS INT )  FORWARD.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


/* ***********************  Control Definitions  ********************** */


/* Definitions of the field level widgets                               */
DEFINE BUTTON Btodos 
     LABEL "&Todos" 
     SIZE 9 BY 1.

DEFINE BUTTON Buscar 
     LABEL "Buscar" 
     SIZE 15 BY 1.

DEFINE VARIABLE c_nro_tipo_evento AS INTEGER FORMAT ">>>>9" INITIAL 1 
     LABEL "CA" 
     VIEW-AS COMBO-BOX SORT INNER-LINES 5
     LIST-ITEM-PAIRS "FU",1
     DROP-DOWN-LIST
     SIZE 7.8 BY 1 TOOLTIP "Tipo de evento que genera el contrato"
     BGCOLOR 15 FGCOLOR 9 .

DEFINE VARIABLE que_nombre AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 49 BY 1 NO-UNDO.

DEFINE VARIABLE Relegir AS CHARACTER INITIAL "1" 
     VIEW-AS RADIO-SET HORIZONTAL
     RADIO-BUTTONS 
          "Consorcio", "1",
"Administ.", "2",
"Codigo", "3",
"Contrato", "4"
     SIZE 52 BY 1 NO-UNDO.

/* Query definitions                                                    */
&ANALYZE-SUSPEND
DEFINE QUERY br_table FOR 
      Cliente, 
      Administrador SCROLLING.
&ANALYZE-RESUME

/* Browse definitions                                                   */
DEFINE BROWSE br_table
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS br_table B-table-Win _FREEFORM
  QUERY br_table NO-LOCK DISPLAY
      Cliente.cdg_cliente COLUMN-LABEL "Codigo" FORMAT "x(8)":U
      Cliente.direccion COLUMN-LABEL "Consorcio" FORMAT "X(45)":U
            WIDTH 71.2
      Administrador.nom_cliente COLUMN-LABEL "Administración" FORMAT "X(40)":U
            WIDTH 75.5
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ASSIGN SEPARATORS SIZE 152 BY 6.43 ROW-HEIGHT-CHARS .67 FIT-LAST-COLUMN.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME F-Main
     que_nombre AT ROW 1.24 COL 2 NO-LABEL
     Buscar AT ROW 1.24 COL 52
     Relegir AT ROW 1.24 COL 71 NO-LABEL
     Btodos AT ROW 1.24 COL 125
     c_nro_tipo_evento AT ROW 1.24 COL 144 COLON-ALIGNED WIDGET-ID 28
     br_table AT ROW 2.67 COL 2
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
         HEIGHT             = 8.57
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

/* SETTINGS FOR COMBO-BOX c_nro_tipo_evento IN FRAME F-Main
   1                                                                    */
/* SETTINGS FOR FILL-IN que_nombre IN FRAME F-Main
   ALIGN-L                                                              */
/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME


/* Setting information for Queries and Browse Widgets fields            */

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE br_table
/* Query rebuild information for BROWSE br_table
     _START_FREEFORM
IF Relegir = "1" THEN
    OPEN QUERY  {&BROWSE-NAME}  FOR EACH Cliente WHERE
      Cliente.cdg_cliente BEGINS "C"   AND
       cliente.direccion CONTAINS que_nombre NO-LOCK,
      FIRST Administrador WHERE
      Administrador.nro_cliente = Cliente.nro_administrador NO-LOCK
      BY Cliente.direccion.
ELSE IF Relegir = "2" THEN
    OPEN QUERY {&BROWSE-NAME}  FOR EACH Cliente WHERE
        Cliente.cdg_cliente BEGINS "C"  NO-LOCK,
      FIRST Administrador WHERE
      Administrador.nro_cliente = Cliente.nro_administrador and
        administrador.nom_cliente CONTAINS que_nombre NO-LOCK
      BY Administrador.nom_cliente BY Cliente.direccion.
ELSE
    OPEN QUERY {&BROWSE-NAME}  FOR EACH Cliente WHERE
        Cliente.cdg_cliente BEGINS que_nombre   NO-LOCK,
      FIRST Administrador WHERE
      Administrador.nro_cliente = Cliente.nro_administrador and
        administrador.nom_cliente CONTAINS que_nombre NO-LOCK
      BY Administrador.nom_cliente BY Cliente.direccion.
     _END_FREEFORM
     _Options          = "NO-LOCK KEY-PHRASE"
     _TblOptList       = ", FIRST"
     _OrdList          = "sic.Cliente.nom_cliente|yes"
     _Where[1]         = "Cliente.cdg_cliente BEGINS ""C"""
     _Where[2]         = "Administrador.nro_cliente = Cliente.nro_administrador"
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
  IF contratos_activos(c_nro_tipo_evento) THEN DO:
      FIND tipo_evento WHERE tipo_evento.nro_tipo_evento = c_nro_tipo_evento.
      IF AVAILABLE tipo_evento THEN DO:
          cliente.cdg_cliente:FGCOLOR IN BROWSE {&BROWSE-NAME} = tipo_evento.color_letra.
          cliente.cdg_cliente:BGCOLOR IN BROWSE {&BROWSE-NAME} = tipo_evento.color_fondo.
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


&Scoped-define SELF-NAME Btodos
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Btodos B-table-Win
ON CHOOSE OF Btodos IN FRAME F-Main /* Todos */
DO:
    que_nombre:screen-VALUE IN FRAME {&FRAME-NAME} = "".
IF Relegir = "1" THEN
    OPEN QUERY  {&BROWSE-NAME}  FOR EACH Cliente WHERE
      Cliente.cdg_cliente BEGINS "C" NO-LOCK,
      FIRST Administrador WHERE
      Administrador.nro_cliente = Cliente.nro_administrador NO-LOCK
      BY Cliente.direccion.
ELSE
    OPEN QUERY {&BROWSE-NAME}  FOR EACH Cliente WHERE
        Cliente.cdg_cliente BEGINS "C" NO-LOCK,
      FIRST Administrador WHERE
      Administrador.nro_cliente = Cliente.nro_administrador NO-LOCK
      BY Administrador.nom_cliente BY Cliente.direccion.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME Buscar
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Buscar B-table-Win
ON CHOOSE OF Buscar IN FRAME F-Main /* Buscar */
DO:
  APPLY "return" TO que_nombre.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME c_nro_tipo_evento
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL c_nro_tipo_evento B-table-Win
ON VALUE-CHANGED OF c_nro_tipo_evento IN FRAME F-Main /* CA */
DO:
    ASSIGN c_nro_tipo_evento.
    APPLY "return" TO que_nombre.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME que_nombre
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL que_nombre B-table-Win
ON Return OF que_nombre IN FRAME F-Main
DO:
DEF VAR rr AS HANDLE.
DEF VAR rowcli AS rowid NO-UNDO.
ASSIGN que_nombre relegir.
IF relegir = "4" THEN DO:
    FIND contrato_hd WHERE contrato_hd.nro_contrato = INT(que_nombre) NO-ERROR.
    FIND cliente OF contrato_hd NO-ERROR.
    rowcli = IF AVAILABLE cliente THEN ROWID(cliente) ELSE ?.
END.

IF que_nombre <> "" THEN DO:
    IF Relegir = "1" THEN
        OPEN QUERY  {&BROWSE-NAME}  FOR EACH Cliente WHERE
          Cliente.cdg_cliente BEGINS "C"  AND 
          cliente.direccion CONTAINS que_nombre NO-LOCK,
          FIRST Administrador WHERE
          Administrador.nro_cliente = Cliente.nro_administrador NO-LOCK
          BY Cliente.direccion.
    ELSE IF Relegir = "2" THEN
        OPEN QUERY {&BROWSE-NAME}  FOR EACH Cliente WHERE
            Cliente.cdg_cliente BEGINS "C"  NO-LOCK,
          FIRST Administrador WHERE
          Administrador.nro_cliente = Cliente.nro_administrador and
            administrador.nom_cliente CONTAINS que_nombre NO-LOCK
          BY Administrador.nom_cliente BY Cliente.direccion.
    ELSE IF Relegir = "3" THEN
        OPEN QUERY {&BROWSE-NAME}  FOR EACH Cliente WHERE
            Cliente.cdg_cliente BEGINS que_nombre  NO-LOCK,
            FIRST Administrador WHERE
          Administrador.nro_cliente = Cliente.nro_administrador
          BY cliente.cdg_cliente BY Cliente.direccion.
    ELSE
        OPEN QUERY {&BROWSE-NAME}  FOR EACH Cliente WHERE
            Cliente.cdg_cliente BEGINS "C"  AND  ROWID(cliente) = rowcli,
            FIRST Administrador WHERE
          Administrador.nro_cliente = Cliente.nro_administrador
          BY cliente.cdg_cliente BY Cliente.direccion.

    RUN dispatch IN THIS-PROCEDURE ('row-changed':U).
END.
ELSE
    APPLY "choose" TO btodos.
        END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME Relegir
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Relegir B-table-Win
ON VALUE-CHANGED OF Relegir IN FRAME F-Main
DO:
  APPLY "return" TO que_nombre.
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
DEF VAR lista AS CHAR NO-UNDO.
/* Code placed here will execute PRIOR to standard behavior. */

   {findempresa.i}
   que_empresa = Empresa.cdg_empresa.
   {findsector.i}
   que_sector = Area.cdg_area.
    lista = "".
    FOR EACH tipo_evento:
        lista = lista + "," + tipo_evento.cdg_tipo + "," + STRING(tipo_evento.nro_tipo_evento).
    END.  /* Dispatch standard ADM method.    */
    IF NUM-ENTRIES(lista) >= 2 THEN
    c_nro_tipo_evento:LIST-ITEM-PAIRS IN FRAME {&FRAME-NAME} = substring(lista,2).
  RUN dispatch IN THIS-PROCEDURE ( INPUT 'initialize':U ) .

  /* Code placed here will execute AFTER standard behavior.    */

  APPLY "CHOOSE" TO btodos IN FRAME {&FRAME-NAME}.
  /*  {&OPEN-QUERY-{&BROWSE-NAME}}*/

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
  {src/adm/template/snd-list.i "Administrador"}

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
        btodos:SENSITIVE = FALSE.
    END.
    WHEN "update-complete":U THEN DO:
        que_nombre:SENSITIVE = true.
        relegir:SENSITIVE = true.
        buscar:SENSITIVE = true.
        btodos:SENSITIVE = true.
    END.
  END CASE.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

/* ************************  Function Implementations ***************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION contratos_activos B-table-Win 
FUNCTION contratos_activos RETURNS LOGICAL
  ( c_nro_tipo_evento AS INT ) :
/*------------------------------------------------------------------------------
  Purpose:  retorna los contratos activos del tipo asignado si el tipo es ? todos los que tenga
    Notes: si tca = true da el resultado correcto sino solo informa el parametro 
    sino da true.
------------------------------------------------------------------------------*/
RETURN CAN-FIND( FIRST  Contrato_hd OF Cliente
        WHERE contrato_hd.nro_tipo_evento = c_nro_tipo_evento and
              Contrato_hd.fecha_baja = ?  AND
              Contrato_hd.rige_hasta > TODAY AND
     ( contrato_hd.cant_periodos  = contrato_hd.resto_periodos OR
       contrato_hd.resto_periodos > 0 ) ).

END FUNCTION.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

