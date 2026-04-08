&ANALYZE-SUSPEND _VERSION-NUMBER UIB_v8r12 GUI ADM1
&ANALYZE-RESUME
/* Connected Databases 
*/
&Scoped-define WINDOW-NAME W-Win
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _DEFINITIONS W-Win 
/*------------------------------------------------------------------------

  File: 

  Description: from cntnrwin.w - ADM SmartWindow Template

  Input Parameters:
      <none>

  Output Parameters:
      <none>

  History: 
          
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

{nrorelea.i}


DEFINE VARIABLE txn_activa AS LOGICAL.
DEFINE TEMP-TABLE tt
    FIELD nro_cliente LIKE cliente.nro_cliente
    FIELD nro_admin LIKE cliente.nro_admin
    FIELD direccion LIKE cliente.direccion
    FIELD unidades LIKE cliente_otros.unidades
    FIELD localidad LIKE cliente.localidad
    FIELD admin_nombre LIKE Cliente.nom_cliente FORMAT "X(50)"
    FIELD contrato_nro LIKE contrato_hd.nro_contrato
    FIELD prf_contrato LIKE contrato_hd.prf_contrato
    FIELD rige_desde LIKE contrato_hd.rige_desde
    FIELD imp_total LIKE Contrato_hd.imp_total DECIMALS 2 FORMAT ">>>>>9.99"
    FIELD imp_neto  LIKE Contrato_hd.imp_neto DECIMALS 2 FORMAT ">>>>>9.99"
    FIELD cliente_nombre LIKE cliente.direccion FORMAT "X(50)"
    FIELD cdg_cliente LIKE Cliente.cdg_cliente
    FIELD cdg_condiva LIKE  contrato_hd.cdg_condiva 
    FIELD cdg_tipo_evento LIKE  tipo_evento.cdg_tipo_evento
    FIELD resto_periodos LIKE contrato_hd.resto_periodos
    FIELD cant_periodos LIKE Contrato_hd.cant_periodos
    FIELD tratamiento LIKE Persona.tratamiento
    FIELD contacto LIKE persona.nombre FORMAT "X(50)"
    FIELD email LIKE persona.email FORMAT "X(50)"
    FIELD nro_persona LIKE Persona.nro_persona
    FIELD factu_admin LIKE cliente.factu_admin
    FIELD cod_docu LIKE cliente.cod_docu
    FIELD cuit LIKE cliente.cuit
    FIELD hat LIKE Contrato_hd.imp_total LABEL "HAT" DECIMALS 2 FORMAT ">>>>>9.99"
    FIELD restricciones AS CHAR FORMAT "X(120)"
    FIELD adeuda AS INT FORMAT "9"
    FIELD rdur AS INT
    FIELD modo_facturacion LIKE Contrato_hd.modo_facturacion LABEL "Modo"
    FIELD articulos AS CHAR FORMAT "X(30)"
    FIELD precio1 LIKE contrato_hd.imp_total
    INDEX idx1 admin_nombre
    INDEX idx2  nro_cliente cdg_tipo_evento.
    
DEFINE BUFFER administrador FOR cliente.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE SmartWindow
&Scoped-define DB-AWARE no

&Scoped-define ADM-CONTAINER WINDOW

/* Name of designated FRAME-NAME and/or first browse and/or first query */
&Scoped-define FRAME-NAME F-Main
&Scoped-define BROWSE-NAME BROWSE-9

/* Internal Tables (found by Frame, Query & Browse Queries)             */
&Scoped-define INTERNAL-TABLES tt

/* Definitions for BROWSE BROWSE-9                                      */
&Scoped-define FIELDS-IN-QUERY-BROWSE-9 tt.admin_nombre tt.cliente_nombre tt.direccion tt.unidades tt.localidad tt.contrato_nro tt.rige_desde tt.cdg_tipo_evento tt.prf_contrato tt.articulos tt.imp_total tt.imp_neto tt.hat tt.cdg_cliente tt.cdg_condiva tt.cant_periodos tt.resto_periodos tt.tratamiento tt.contacto tt.email tt.factu_admin tt.cod_docu tt.cuit tt.restricciones tt.adeuda tt.precio1 tt.rdur tt.modo   
&Scoped-define ENABLED-FIELDS-IN-QUERY-BROWSE-9   
&Scoped-define SELF-NAME BROWSE-9
&Scoped-define QUERY-STRING-BROWSE-9 FOR EACH tt
&Scoped-define OPEN-QUERY-BROWSE-9 OPEN QUERY {&SELF-NAME} FOR EACH tt .
&Scoped-define TABLES-IN-QUERY-BROWSE-9 tt
&Scoped-define FIRST-TABLE-IN-QUERY-BROWSE-9 tt


/* Definitions for FRAME F-Main                                         */
&Scoped-define OPEN-BROWSERS-IN-QUERY-F-Main ~
    ~{&OPEN-QUERY-BROWSE-9}

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS Btn-excel fhasta ftipo brefresh BROWSE-9 
&Scoped-Define DISPLAYED-OBJECTS fhasta ftipo 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME


/* ************************  Function Prototypes ********************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION-FORWARD adeuda W-Win 
FUNCTION adeuda RETURNS INT
  ( nroc AS int )  FORWARD.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION-FORWARD duref W-Win 
FUNCTION duref RETURNS INT
  ( d AS CHAR, h AS CHAR )  FORWARD.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION-FORWARD precio1 W-Win 
FUNCTION precio1 RETURNS DECIMAL
  ( nroc AS int )  FORWARD.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION-FORWARD rdur W-Win 
FUNCTION rdur RETURNS INTEGER ( nro AS INT ) FORWARD.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


/* ***********************  Control Definitions  ********************** */

/* Define the widget handle for the window                              */
DEFINE VAR W-Win AS WIDGET-HANDLE NO-UNDO.

/* Definitions of handles for OCX Containers                            */
DEFINE VARIABLE ProgressBar AS WIDGET-HANDLE NO-UNDO.
DEFINE VARIABLE chProgressBar AS COMPONENT-HANDLE NO-UNDO.

/* Definitions of the field level widgets                               */
DEFINE BUTTON brefresh 
     LABEL "Refrescar" 
     SIZE 15 BY 1.14.

DEFINE BUTTON Btn-excel 
     IMAGE-UP FILE "excel.gif":U NO-FOCUS
     LABEL "&Modifica" 
     SIZE 9 BY 1.33 TOOLTIP "Modifica el registro actual"
     FONT 4.

DEFINE VARIABLE fhasta AS DATE FORMAT "99/99/9999":U 
     LABEL "Fecha vigencia" 
     VIEW-AS FILL-IN 
     SIZE 19 BY 1 TOOLTIP "Fecha de vigencia hasta" NO-UNDO.

DEFINE VARIABLE ftipo AS CHARACTER FORMAT "X(256)":U INITIAL "FU,LT,DT" 
     LABEL "Tipos" 
     VIEW-AS FILL-IN 
     SIZE 14 BY 1 NO-UNDO.

/* Query definitions                                                    */
&ANALYZE-SUSPEND
DEFINE QUERY BROWSE-9 FOR 
      tt SCROLLING.
&ANALYZE-RESUME

/* Browse definitions                                                   */
DEFINE BROWSE BROWSE-9
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS BROWSE-9 W-Win _FREEFORM
  QUERY BROWSE-9 DISPLAY
      tt.admin_nombre
tt.cliente_nombre COLUMN-LABEL "Razon Social"
tt.direccion
tt.unidades
tt.localidad
tt.contrato_nro
tt.rige_desde
tt.cdg_tipo_evento
tt.prf_contrato
tt.articulos COLUMN-LABEL "Articulos"
tt.imp_total COLUMN-LABEL "TOTAL"
tt.imp_neto COLUMN-LABEL "NETO"
tt.hat COLUMN-LABEL "HAT"
tt.cdg_cliente
tt.cdg_condiva
tt.cant_periodos
tt.resto_periodos
tt.tratamiento
tt.contacto
tt.email
tt.factu_admin
tt.cod_docu
tt.cuit
tt.restricciones
tt.adeuda
tt.precio1
tt.rdur
tt.modo
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ROW-MARKERS SEPARATORS SIZE 188 BY 25.71 ROW-HEIGHT-CHARS .52 FIT-LAST-COLUMN.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME F-Main
     Btn-excel AT ROW 1.24 COL 73 WIDGET-ID 50
     fhasta AT ROW 1.24 COL 32 COLON-ALIGNED WIDGET-ID 46
     ftipo AT ROW 1.24 COL 90 COLON-ALIGNED WIDGET-ID 54
     brefresh AT ROW 1.24 COL 113 WIDGET-ID 2
     BROWSE-9 AT ROW 2.67 COL 4 WIDGET-ID 100
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 192.2 BY 27.67.


/* *********************** Procedure Settings ************************ */

&ANALYZE-SUSPEND _PROCEDURE-SETTINGS
/* Settings for THIS-PROCEDURE
   Type: SmartWindow
   Allow: Basic,Browse,DB-Fields,Query,Smart,Window
   Other Settings: COMPILE
 */
&ANALYZE-RESUME _END-PROCEDURE-SETTINGS

/* *************************  Create Window  ************************** */

&ANALYZE-SUSPEND _CREATE-WINDOW
IF SESSION:DISPLAY-TYPE = "GUI":U THEN
  CREATE WINDOW W-Win ASSIGN
         HIDDEN             = YES
         TITLE              = "Modelo"
         HEIGHT             = 27.67
         WIDTH              = 192.2
         MAX-HEIGHT         = 28.29
         MAX-WIDTH          = 192.2
         VIRTUAL-HEIGHT     = 28.29
         VIRTUAL-WIDTH      = 192.2
         RESIZE             = no
         SCROLL-BARS        = no
         STATUS-AREA        = no
         BGCOLOR            = ?
         FGCOLOR            = ?
         THREE-D            = yes
         MESSAGE-AREA       = no
         SENSITIVE          = yes.
ELSE {&WINDOW-NAME} = CURRENT-WINDOW.
/* END WINDOW DEFINITION                                                */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _INCLUDED-LIB W-Win 
/* ************************* Included-Libraries *********************** */

{excel-export.i}
{src/adm/method/containr.i}

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME




/* ***********  Runtime Attributes and AppBuilder Settings  *********** */

&ANALYZE-SUSPEND _RUN-TIME-ATTRIBUTES
/* SETTINGS FOR WINDOW W-Win
  VISIBLE,,RUN-PERSISTENT                                               */
/* SETTINGS FOR FRAME F-Main
   FRAME-NAME                                                           */
/* BROWSE-TAB BROWSE-9 brefresh F-Main */
ASSIGN 
       BROWSE-9:COLUMN-RESIZABLE IN FRAME F-Main       = TRUE
       BROWSE-9:COLUMN-MOVABLE IN FRAME F-Main         = TRUE.

IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(W-Win)
THEN W-Win:HIDDEN = yes.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME


/* Setting information for Queries and Browse Widgets fields            */

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE BROWSE-9
/* Query rebuild information for BROWSE BROWSE-9
     _START_FREEFORM
OPEN QUERY {&SELF-NAME} FOR EACH tt .
     _END_FREEFORM
     _Query            is OPENED
*/  /* BROWSE BROWSE-9 */
&ANALYZE-RESUME

 


/* **********************  Create OCX Containers  ********************** */

&ANALYZE-SUSPEND _CREATE-DYNAMIC

&IF "{&OPSYS}" = "WIN32":U AND "{&WINDOW-SYSTEM}" NE "TTY":U &THEN

CREATE CONTROL-FRAME ProgressBar ASSIGN
       FRAME           = FRAME F-Main:HANDLE
       ROW             = 1.1
       COLUMN          = 132
       HEIGHT          = 1.43
       WIDTH           = 30
       WIDGET-ID       = 56
       HIDDEN          = no
       SENSITIVE       = yes.

PROCEDURE adm-create-controls:
      ProgressBar:NAME = "ProgressBar":U .
/* ProgressBar OCXINFO:CREATE-CONTROL from: {4A5E5E35-91F4-46B1-B62F-78148132EF93} type: XP_ProgressBar */
      ProgressBar:MOVE-BEFORE(fhasta:HANDLE IN FRAME F-Main).

END PROCEDURE.

&ENDIF

&ANALYZE-RESUME /* End of _CREATE-DYNAMIC */


/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME W-Win
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL W-Win W-Win
ON END-ERROR OF W-Win /* Modelo */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL W-Win W-Win
ON WINDOW-CLOSE OF W-Win /* Modelo */
DO:
    /* Modificado para que el control retorne a la window padre al cerrar una windows hija */
  DEFINE VARIABLE h_parent AS HANDLE      NO-UNDO.


  RUN verificar_txn ( OUTPUT txn_activa ).
  IF NOT txn_activa
  THEN DO: 
    h_parent = THIS-PROCEDURE:CURRENT-WINDOW:PARENT.
    APPLY "CLOSE":U TO THIS-PROCEDURE.
    IF VALID-HANDLE(h_parent) THEN DO:
        CURRENT-WINDOW = h_parent.
        APPLY 'ENTRY' TO h_parent.
    END.
  END.

  RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL W-Win W-Win
ON WINDOW-MINIMIZED OF W-Win /* Modelo */
DO:
  RUN get-attribute ('ADM-TRANSACTION').
  IF RETURN-VALUE = "YES"
  THEN DO:
       MESSAGE "No debe minimizar esta ventana con una actualización pendiente"
               VIEW-AS ALERT-BOX WARNING TITLE "CUIDADO!!!".
       {&WINDOW-NAME}:WINDOW-STATE = 1.
       RETURN NO-APPLY.
  END.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME brefresh
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL brefresh W-Win
ON CHOOSE OF brefresh IN FRAME F-Main /* Refrescar */
DO:
  EMPTY TEMP-TABLE tt.
  ASSIGN fhasta.
  RUN llena(fhasta).
  {&OPEN-QUERY-{&BROWSE-NAME}}
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME Btn-excel
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Btn-excel W-Win
ON CHOOSE OF Btn-excel IN FRAME F-Main /* Modifica */
DO:
       run excel-export ( {&BROWSE-NAME}:HANDLE IN FRAME {&FRAME-NAME} ).
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define BROWSE-NAME BROWSE-9
&UNDEFINE SELF-NAME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _MAIN-BLOCK W-Win 


/* ***************************  Main Block  *************************** */

/* Include custom  Main Block code for SmartWindows. */
{src/adm/template/windowmn.i}

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


/* **********************  Internal Procedures  *********************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE adm-create-objects W-Win  _ADM-CREATE-OBJECTS
PROCEDURE adm-create-objects :
/*------------------------------------------------------------------------------
  Purpose:     Create handles for all SmartObjects used in this procedure.
               After SmartObjects are initialized, then SmartLinks are added.
  Parameters:  <none>
------------------------------------------------------------------------------*/

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE adm-row-available W-Win  _ADM-ROW-AVAILABLE
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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE control_load W-Win  _CONTROL-LOAD
PROCEDURE control_load :
/*------------------------------------------------------------------------------
  Purpose:     Load the OCXs    
  Parameters:  <none>
  Notes:       Here we load, initialize and make visible the 
               OCXs in the interface.                        
------------------------------------------------------------------------------*/

&IF "{&OPSYS}" = "WIN32":U AND "{&WINDOW-SYSTEM}" NE "TTY":U &THEN
DEFINE VARIABLE UIB_S    AS LOGICAL    NO-UNDO.
DEFINE VARIABLE OCXFile  AS CHARACTER  NO-UNDO.

OCXFile = SEARCH( "w-contratosvigentes.wrx":U ).
IF OCXFile = ? THEN
  OCXFile = SEARCH(SUBSTRING(THIS-PROCEDURE:FILE-NAME, 1,
                     R-INDEX(THIS-PROCEDURE:FILE-NAME, ".":U), "CHARACTER":U) + "wrx":U).

IF OCXFile <> ? THEN
DO:
  ASSIGN
    chProgressBar = ProgressBar:COM-HANDLE
    UIB_S = chProgressBar:LoadControls( OCXFile, "ProgressBar":U)
  .
  RUN DISPATCH IN THIS-PROCEDURE("initialize-controls":U) NO-ERROR.
END.
ELSE MESSAGE "w-contratosvigentes.wrx":U SKIP(1)
             "The binary control file could not be found. The controls cannot be loaded."
             VIEW-AS ALERT-BOX TITLE "Controls Not Loaded".

&ENDIF

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE disable_UI W-Win  _DEFAULT-DISABLE
PROCEDURE disable_UI :
/*------------------------------------------------------------------------------
  Purpose:     DISABLE the User Interface
  Parameters:  <none>
  Notes:       Here we clean-up the user-interface by deleting
               dynamic widgets we have created and/or hide 
               frames.  This procedure is usually called when
               we are ready to "clean-up" after running.
------------------------------------------------------------------------------*/
  /* Delete the WINDOW we created */
  IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(W-Win)
  THEN DELETE WIDGET W-Win.
  IF THIS-PROCEDURE:PERSISTENT THEN DELETE PROCEDURE THIS-PROCEDURE.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE enable_UI W-Win  _DEFAULT-ENABLE
PROCEDURE enable_UI :
/*------------------------------------------------------------------------------
  Purpose:     ENABLE the User Interface
  Parameters:  <none>
  Notes:       Here we display/view/enable the widgets in the
               user-interface.  In addition, OPEN all queries
               associated with each FRAME and BROWSE.
               These statements here are based on the "Other 
               Settings" section of the widget Property Sheets.
------------------------------------------------------------------------------*/
  DISPLAY fhasta ftipo 
      WITH FRAME F-Main IN WINDOW W-Win.
  ENABLE Btn-excel fhasta ftipo brefresh BROWSE-9 
      WITH FRAME F-Main IN WINDOW W-Win.
  {&OPEN-BROWSERS-IN-QUERY-F-Main}
  VIEW W-Win.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE llena W-Win 
PROCEDURE llena :
/*------------------------------------------------------------------------------
  Purpose:     llena la tabla de contratos vigentes a la fecha indicada
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEFINE INPUT PARAM p-fecha AS DATE.
DEFINE VAR rec AS INT NO-UNDO.
DEFINE BUFFER bcontrato_hd FOR contrato_hd.
DEFINE QUERY q FOR contrato_hd,cliente,tipo_evento,administrador.
DEFINE VAR art LIKE tt.articulos.
ASSIGN FRAME {&FRAME-NAME} ftipo fhasta.
SESSION:IMMEDIATE-DISPLAY=YES.
DEFINE VAR i AS INT NO-UNDO.
OPEN QUERY q FOR EACH Contrato_hd 
    WHERE contrato_hd.estado = "A" AND p-fecha <= Contrato_hd.rige_hasta 
      AND NOT anulado AND contrato_hd.fecha_baja = ? AND
          ((contrato_hd.cant_periodos<>0 AND contrato_hd.resto_periodos <> 0 ) OR
           contrato_hd.cant_periodos = 0 )  
      NO-LOCK,
          
          FIRST Cliente OF Contrato_hd NO-LOCK ,
          FIRST tipo_evento OF contrato_hd NO-LOCK,
          FIRST administrador WHERE administrador.nro_cliente = cliente.nro_administrador NO-LOCK
                               /*   BY administrador.nom_cliente
                                  BY cliente.direccion*/
                                  BY Contrato_hd.nro_contrato DESC.
rec = NUM-RESULTS("q").

IF rec = 0 THEN DO:
    MESSAGE "No hay registros para mostrar" VIEW-AS ALERT-BOX INFORMATION.
    RETURN.
END.
  chProgressBar:XP_ProgressBar:MIN = 0.   
  chProgressBar:XP_ProgressBar:MAX = rec.
  chProgressBar:XP_ProgressBar:VALUE = rec.
  i = 0.
REPEAT:
        GET NEXT q .
        IF NOT AVAILABLE contrato_hd THEN LEAVE.
        IF NOT CAN-DO(ftipo,tipo_evento.cdg_tipo_evento) THEN NEXT.
        IF tipo_evento.cdg_tipo_evento = "FU" AND contrato_hd.cant_periodos <> 0 THEN NEXT.
        IF Contrato_hd.fecha_baja <> ? OR contrato_hd.fecha_baja < p-fecha  THEN NEXT.
      /*  FIND tt WHERE tt.nro_cliente = contrato_hd.nro_cliente AND
                      tt.cdg_tipo_evento = tipo_evento.cdg_tipo_evento NO-ERROR.
        IF AVAILABLE tt THEN NEXT.*/
        IF NOT CAN-DO( ftipo,tipo_evento.cdg_tipo_evento) THEN NEXT.

        rec = rec - 1.
        IF rec MOD 20 = 0  THEN
            IF rec > 0 THEN chProgressBar:XP_ProgressBar:VALUE = rec.

        FIND domicilio OF administrador NO-LOCK NO-ERROR.
        FIND first Cliente-contacto OF Domicilio WHERE  can-do(Cliente-contacto.canal-email,"PRE") NO-LOCK NO-ERROR.
        FIND FIRST Persona OF Cliente-contacto NO-LOCK NO-ERROR.
        FIND FIRST cliente_otros OF cliente NO-LOCK NO-ERROR.
        art="".
        FOR EACH contrato_dt OF contrato_hd, articulo OF contrato_dt:
            art = art + "," + articulo.cdg_articulo.
        END.
        art = SUBSTRING(art,2).
        CREATE tt.
        ASSIGN 
            i = i + 1
            tt.nro_cliente = cliente.nro_cliente
            tt.direccion = cliente.direccion
            tt.unidades = IF AVAILABLE cliente_otros THEN cliente_otros.unidades ELSE 0
            tt.localidad = cliente.localidad
            tt.nro_admin = cliente.nro_admin
            tt.rige_desde = contrato_hd.rige_desde
            tt.contrato_nro = contrato_hd.nro_contrato
            tt.prf_contrato = contrato_hd.prf_contrato
            tt.imp_total = Contrato_hd.imp_total
            tt.imp_neto = Contrato_hd.imp_total / 1.21
            tt.cdg_cliente = cliente.cdg_cliente
            tt.admin_nombre = administrador.nom_cliente
            tt.cliente_nombre = cliente.nom_cliente
            tt.cod_docu = IF Cliente.factu_admin THEN administrador.cod_docu ELSE cliente.cod_docu
            tt.factu_admin = cliente.factu_admin
            tt.cdg_condiva = contrato_hd.cdg_condiva
            tt.cdg_tipo_evento = tipo_evento.cdg_tipo_evento
            tt.cant_periodos = contrato_hd.cant_periodos
            tt.resto_periodos = contrato_hd.resto_periodos
            tt.modo_facturacion = contrato_hd.modo_facturacion
            tt.cuit = IF Cliente.factu_admin THEN administrador.cuit ELSE cliente.cuit.
            tt.adeuda = adeuda(contrato_hd.nro_contrato).
            tt.precio1 = precio1(contrato_hd.nro_contrato).
            /*IF administrador.hat <> 0 THEN tt.hat = tt.imp_total * administrador.hat / 100.*/
            tt.articulos = art.
            tt.hat = administrador.hat.
            tt.rdur = rdur(contrato_hd.nro_contrato).
            IF AVAILABLE persona THEN DO:
                ASSIGN
                tt.tratamiento = persona.tratamiento
                tt.contacto = persona.nombre
                tt.email = persona.email.
            END.
            FOR EACH cliente_restriccion WHERE cliente_restriccion.nro_cliente = tt.nro_admin NO-LOCK,
                restriccion OF cliente_restriccion:
                tt.restriccion = tt.restriccion + "," + restriccion.cdg_restriccion + ":" + cliente_restriccion.valor.
            END.
            tt.restriccion = SUBSTRING(tt.restriccion,2).
END.
MESSAGE "Registros:" i.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE local-exit W-Win 
PROCEDURE local-exit :
/* -----------------------------------------------------------
  Purpose:  Starts an "exit" by APPLYing CLOSE event, which starts "destroy".
  Parameters:  <none>
  Notes:    If activated, should APPLY CLOSE, *not* dispatch adm-exit.   
-------------------------------------------------------------*/

  RUN verificar_txn ( OUTPUT txn_activa ).
  IF txn_activa
  THEN DO:
       RETURN NO-APPLY.
  END.     
  ELSE DO:
       APPLY "CLOSE":U TO THIS-PROCEDURE.
       RETURN.
  END.     

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE local-initialize W-Win 
PROCEDURE local-initialize :
/*------------------------------------------------------------------------------
  Purpose:     Override standard ADM method
  Notes:       
------------------------------------------------------------------------------*/
  /* Code placed here will execute PRIOR to standard behavior. */

  /* Dispatch standard ADM method.                             */
  RUN dispatch IN THIS-PROCEDURE ( INPUT 'initialize':U ) .

  /* Code placed here will execute AFTER standard behavior.    */
    fhasta:SCREEN-VALUE IN FRAME {&FRAME-NAME}= string(TODAY).

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE local-view W-Win 
PROCEDURE local-view :
/*------------------------------------------------------------------------------
  Purpose:     Override standard ADM method
  Notes:       
------------------------------------------------------------------------------*/

  /* Code placed here will execute PRIOR to standard behavior. */

  /* Dispatch standard ADM method.                             */
  RUN dispatch IN THIS-PROCEDURE ( INPUT 'view':U ) .

  /* Code placed here will execute AFTER standard behavior.    */

  {setwintit.i "SIC/BAS" "Contratos Vigentes a Fecha"}


END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE send-records W-Win  _ADM-SEND-RECORDS
PROCEDURE send-records :
/*------------------------------------------------------------------------------
  Purpose:     Send record ROWID's for all tables used by
               this file.
  Parameters:  see template/snd-head.i
------------------------------------------------------------------------------*/

  /* Define variables needed by this internal procedure.               */
  {src/adm/template/snd-head.i}

  /* For each requested table, put it's ROWID in the output list.      */
  {src/adm/template/snd-list.i "tt"}

  /* Deal with any unexpected table requests before closing.           */
  {src/adm/template/snd-end.i}

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE set-estado-folders W-Win 
PROCEDURE set-estado-folders :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
    DEFINE INPUT PARAMETER p-operacion AS CHARACTER.
/*
    DEFINE VARIABLE folder-labels AS CHARACTER.
    DEFINE VARIABLE page-hdl      AS CHARACTER.
    DEFINE VARIABLE j-pagina      AS INTEGER.

    RUN get-attribute IN h_folder ('FOLDER-LABELS':U).
    ASSIGN folder-labels   = IF RETURN-VALUE = ? THEN "":U
                             ELSE RETURN-VALUE.

    RUN get-link-handle IN adm-broker-hdl
                      (THIS-PROCEDURE, 'PAGE-TARGET',OUTPUT page-hdl).

    DO j-pagina = 1 TO NUM-ENTRIES(folder-labels,'|':U):                             

/*
       IF p-operacion = "HABILITAR"
          THEN RUN enable-folder-page  IN WIDGET-HANDLE(page-hdl) (j-pagina).
          ELSE RUN disable-folder-page IN WIDGET-HANDLE(page-hdl) (j-pagina).
*/
       IF p-operacion = "HABILITAR"
          THEN RUN enable-folder-page  IN h_folder (j-pagina).
          ELSE RUN disable-folder-page IN h_folder (j-pagina).

    END.
*/
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE state-changed W-Win 
PROCEDURE state-changed :
/* -----------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
-------------------------------------------------------------*/
  DEFINE INPUT PARAMETER p-issuer-hdl AS HANDLE NO-UNDO.
  DEFINE INPUT PARAMETER p-state AS CHARACTER NO-UNDO.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE verificar_txn W-Win 
PROCEDURE verificar_txn :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

  DEFINE OUTPUT PARAMETER p-estado AS LOGICAL.

  RUN get-attribute ('ADM-TRANSACTION').
  IF RETURN-VALUE = "YES"
  THEN DO:
       MESSAGE "No puede salir de esta pantalla con una actualización pendiente"
               VIEW-AS ALERT-BOX ERROR.
       p-estado = YES.
  END.
  ELSE DO:
       p-estado = NO.   /* Function return value. */
  END.
  
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

/* ************************  Function Implementations ***************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION adeuda W-Win 
FUNCTION adeuda RETURNS INT
  ( nroc AS int ) :
/*------------------------------------------------------------------------------
  Purpose:  
    Notes:  
------------------------------------------------------------------------------*/
DEFINE VAR k AS INT NO-UNDO.
DEFINE VAR ss AS DECIMAL NO-UNDO.
    k = 0.
    FIND contrato_hd WHERE nro_contrato = nroc NO-LOCK NO-ERROR.
    IF NOT AVAILABLE contrato_hd THEN RETURN 0.
    FOR EACH fac_header WHERE fac_header.nro_cliente = contrato_hd.nro_cliente AND 
        fac_header.nro_contrato = contrato_hd.nro_contrato NO-LOCK.
    FIND cta_cte WHERE
      cta_cte.cdg_empresa = fac_header.cdg_empresa AND
      cta_cte.tip_comprob = fac_header.tip_comprob AND
      cta_cte.prf_comprob = fac_header.prf_comprob AND
      cta_cte.nro_comprob = fac_header.nro_comprob NO-LOCK NO-ERROR.
  IF AVAILABLE cta_cte THEN DO:
          IF cta_cte.credito <> cta_cte.debito 
              THEN k = k + 1.
  END.
END.
RETURN k.
END FUNCTION.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION duref W-Win 
FUNCTION duref RETURNS INT
  ( d AS CHAR, h AS CHAR ) :
/*------------------------------------------------------------------------------
  Purpose:  
    Notes:  
------------------------------------------------------------------------------*/
DEFINE VAR hh1 AS DECIMAL NO-UNDO.
DEFINE VAR mm1 AS DECIMAL NO-UNDO.
DEFINE VAR hh2 AS DECIMAL NO-UNDO.
DEFINE VAR mm2 AS DECIMAL NO-UNDO.


h = REPLACE(h,":","").
d = REPLACE(d,":","").
hh1 = INT(h).
h = STRING(hh1,"9999").
hh1 = INT(d).
d = STRING(hh1,"9999").

hh1 = INT( SUBSTRING(d,1,2) ).
mm1 = INT( SUBSTRING(d,3,2) ).
hh2 = INT( SUBSTRING(h,1,2) ).
mm2 = INT( SUBSTRING(h,3,2) ).

mm1 = mm1 / 60.
mm2 = mm2 / 60.
hh1 = hh1 + mm1.
hh2 = hh2 + mm2.

RETURN INT((hh2 - hh1) * 60 ).   /* Function return value. */

END FUNCTION.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION precio1 W-Win 
FUNCTION precio1 RETURNS DECIMAL
  ( nroc AS int ) :
/*------------------------------------------------------------------------------
  Purpose:  
    Notes:  
------------------------------------------------------------------------------*/
DEFINE VAR ss AS DECIMAL NO-UNDO.
    ss = 0.
    FIND contrato_hd WHERE nro_contrato = nroc NO-LOCK NO-ERROR.
    IF NOT AVAILABLE contrato_hd THEN RETURN 0.
    FOR EACH contrato_dt OF contrato_hd NO-LOCK,articulo OF contrato_dt NO-LOCK:
        IF articulo.cdg_articulo = "01F" THEN NEXT.
        IF articulo.cdg_articulo = "05m" THEN NEXT.
        IF articulo.cdg_articulo = "23F" THEN NEXT.
        ss = ss + sic.Contrato_dt.subtotal_neto_cf.
    END.
RETURN ss.
END FUNCTION.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION rdur W-Win 
FUNCTION rdur RETURNS INTEGER ( nro AS INT ):
DEFINE VAR k AS INT NO-UNDO.
DEFINE VAR d AS INT NO-UNDO.
DEFINE VAR ac AS INT NO-UNDO.
ac = 0.
FOR EACH evento WHERE evento.origen = "CONTRATO" AND
    Evento.nro_identificacion = nro AND
    NOT evento.anulado AND
    evento.frealizado <> ? BY evento.frealizado DESC:



    k = k + 1.
    IF k > 6 THEN LEAVE.
    d = abs(duref(evento.hora_desde, evento.hora_hasta)).
    IF d <> ? THEN
        ac = ac + d.
END.
    IF ac = 0 OR k = 0 THEN RETURN 0.

    RETURN int(ac / 6).

END FUNCTION.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

