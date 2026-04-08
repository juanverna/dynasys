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
    FIELD localidad LIKE cliente.localidad
    FIELD admin_nombre LIKE Cliente.nom_cliente FORMAT "X(50)"
    FIELD contrato_nro LIKE contrato_hd.nro_contrato
    FIELD prf_contrato LIKE contrato_hd.prf_contrato
    FIELD imp_total LIKE Contrato_hd.imp_total DECIMALS 2 FORMAT ">>>>>9.99" COLUMN-LABEL "Total CF"
    FIELD imp_neto  LIKE Contrato_hd.imp_total DECIMALS 2 FORMAT ">>>>>9.99" COLUMN-LABEL "Neto"
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
    FIELD frealizado LIKE evento.frealizado
    FIELD anulado LIKE contrato_hd.anulado
    FIELD fecha_baja LIKE contrato_hd.fecha_baja
    FIELD agotado AS LOGICAL FORMAT "Si/No" COLUMN-LABEL "AG"
    INDEX admin_nombre admin_nombre .
    
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
&Scoped-define FIELDS-IN-QUERY-BROWSE-9 tt.agotado tt.admin_nombre tt.cliente_nombre tt.direccion tt.localidad tt.contrato_nro tt.cdg_tipo_evento tt.frealizado tt.prf_contrato tt.imp_total tt.imp_neto tt.cdg_cliente tt.cdg_condiva tt.cant_periodos tt.resto_periodos tt.anulado tt.fecha_baja tt.tratamiento tt.contacto tt.email   
&Scoped-define ENABLED-FIELDS-IN-QUERY-BROWSE-9   
&Scoped-define SELF-NAME BROWSE-9
&Scoped-define QUERY-STRING-BROWSE-9 FOR EACH tt BY tt.admin_nombre BY cliente_nombre
&Scoped-define OPEN-QUERY-BROWSE-9 OPEN QUERY {&SELF-NAME} FOR EACH tt BY tt.admin_nombre BY cliente_nombre.
&Scoped-define TABLES-IN-QUERY-BROWSE-9 tt
&Scoped-define FIRST-TABLE-IN-QUERY-BROWSE-9 tt


/* Definitions for FRAME F-Main                                         */
&Scoped-define OPEN-BROWSERS-IN-QUERY-F-Main ~
    ~{&OPEN-QUERY-BROWSE-9}

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS Btn-excel fdesde fhasta brefresh BROWSE-9 
&Scoped-Define DISPLAYED-OBJECTS fdesde fhasta 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
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

DEFINE VARIABLE fdesde AS DATE FORMAT "99/99/9999":U 
     LABEL "Fecha" 
     VIEW-AS FILL-IN 
     SIZE 19 BY 1 TOOLTIP "Fecha de vigencia desde" NO-UNDO.

DEFINE VARIABLE fhasta AS DATE FORMAT "99/99/9999":U 
     VIEW-AS FILL-IN 
     SIZE 19 BY 1 TOOLTIP "Fecha de vigencia hasta" NO-UNDO.

/* Query definitions                                                    */
&ANALYZE-SUSPEND
DEFINE QUERY BROWSE-9 FOR 
      tt SCROLLING.
&ANALYZE-RESUME

/* Browse definitions                                                   */
DEFINE BROWSE BROWSE-9
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS BROWSE-9 W-Win _FREEFORM
  QUERY BROWSE-9 DISPLAY
      tt.agotado      
tt.admin_nombre
tt.cliente_nombre 
tt.direccion
tt.localidad
tt.contrato_nro
tt.cdg_tipo_evento
tt.frealizado
tt.prf_contrato
tt.imp_total
tt.imp_neto
tt.cdg_cliente
tt.cdg_condiva
tt.cant_periodos
tt.resto_periodos
tt.anulado
tt.fecha_baja
tt.tratamiento
tt.contacto
tt.email
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ROW-MARKERS SEPARATORS SIZE 161.8 BY 25.71 FIT-LAST-COLUMN.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME F-Main
     Btn-excel AT ROW 1.24 COL 73 WIDGET-ID 50
     fdesde AT ROW 1.24 COL 12 COLON-ALIGNED WIDGET-ID 44
     fhasta AT ROW 1.24 COL 32 COLON-ALIGNED NO-LABEL WIDGET-ID 46
     brefresh AT ROW 1.24 COL 113 WIDGET-ID 2
     BROWSE-9 AT ROW 2.67 COL 4 WIDGET-ID 100
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 164.8 BY 28.29.


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
         HEIGHT             = 28.29
         WIDTH              = 164.8
         MAX-HEIGHT         = 28.29
         MAX-WIDTH          = 164.8
         VIRTUAL-HEIGHT     = 28.29
         VIRTUAL-WIDTH      = 164.8
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
OPEN QUERY {&SELF-NAME} FOR EACH tt BY tt.admin_nombre BY cliente_nombre.
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
       COLUMN          = 83
       HEIGHT          = 1.43
       WIDTH           = 26
       WIDGET-ID       = 52
       HIDDEN          = no
       SENSITIVE       = yes.

PROCEDURE adm-create-controls:
      ProgressBar:NAME = "ProgressBar":U .
/* ProgressBar OCXINFO:CREATE-CONTROL from: {4A5E5E35-91F4-46B1-B62F-78148132EF93} type: XP_ProgressBar */

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
  ASSIGN fdesde fhasta.
  RUN llena(fdesde,fhasta).
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

OCXFile = SEARCH( "w-contratosactivos.wrx":U ).
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
ELSE MESSAGE "w-contratosactivos.wrx":U SKIP(1)
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
  DISPLAY fdesde fhasta 
      WITH FRAME F-Main IN WINDOW W-Win.
  ENABLE Btn-excel fdesde fhasta brefresh BROWSE-9 
      WITH FRAME F-Main IN WINDOW W-Win.
  {&OPEN-BROWSERS-IN-QUERY-F-Main}
  VIEW W-Win.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE llena W-Win 
PROCEDURE llena :
/*------------------------------------------------------------------------------
  Purpose:     llena la tabla de contratos por cada uno de los tipos de evento
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEFINE INPUT PARAM p-des_fecha AS DATE.
DEFINE INPUT PARAM p-has_fecha AS DATE.
DEFINE VAR rec AS INT NO-UNDO.

DEFINE QUERY q FOR tipo_evento,contrato_hd,cliente,administrador.
DEFINE VAR nn AS INT NO-UNDO.
SESSION:IMMEDIATE-DISPLAY=YES.
OPEN QUERY q FOR EACH tipo_evento, EACH Contrato_hd  
    WHERE contrato_hd.estado = "A" AND 
          NOT contrato_hd.anulado AND
          contrato_hd.nro_tipo_evento = tipo_evento.nro_tipo_evento AND
          ( Contrato_hd.rige_desde <= p-has_fecha  AND Contrato_hd.rige_hasta >= p-des_fecha ) 
          ,
          FIRST Cliente OF Contrato_hd NO-LOCK ,
          FIRST administrador WHERE administrador.nro_cliente = cliente.nro_administrador NO-LOCK
                                  BY contrato_hd.nro_cliente
                                  BY contrato_hd.nro_contrato DESCENDING.
rec = NUM-RESULTS("q").

IF rec = 0 THEN DO:
    MESSAGE "No hay registros para mostrar" VIEW-AS ALERT-BOX INFORMATION.
    RETURN.
END.
  chProgressBar:XP_ProgressBar:MIN = 0.   
  chProgressBar:XP_ProgressBar:MAX = rec.
  chProgressBar:XP_ProgressBar:VALUE = rec.

nn = -1.
REPEAT:
        GET NEXT q .
        IF NOT AVAILABLE contrato_hd THEN LEAVE.
        IF contrato_hd.fecha_baja <> ? AND contrato_hd.fecha_baja <=  p-des_fecha THEN NEXT.
        rec = rec - 1.
        IF rec MOD 20 = 0  THEN
            IF rec > 0 THEN chProgressBar:XP_ProgressBar:VALUE = rec.
        IF nn = contrato_hd.nro_cliente THEN NEXT.
        nn = contrato_hd.nro_cliente.
       /* IF contrato_hd.cant_periodos > 0 AND contrato_hd.resto_periodos = 0 THEN NEXT. */
        FIND tipo_evento OF contrato_hd NO-LOCK NO-ERROR.
        FIND domicilio OF administrador NO-LOCK NO-ERROR.
        FIND first Cliente-contacto OF Domicilio WHERE  can-do(Cliente-contacto.canal-email,"PRE") NO-LOCK NO-ERROR.
        FIND FIRST Persona OF Cliente-contacto NO-LOCK NO-ERROR.
        CREATE tt.
        
        ASSIGN 
            tt.nro_cliente = cliente.nro_cliente
            tt.direccion = cliente.direccion
            tt.localidad = cliente.localidad
            tt.nro_admin = cliente.nro_admin
            tt.contrato_nro = contrato_hd.nro_contrato
            tt.prf_contrato = contrato_hd.prf_contrato
            tt.imp_total = Contrato_hd.imp_total
            tt.imp_neto = Contrato_hd.imp_total / 1.21
            tt.cdg_cliente = cliente.cdg_cliente
            tt.admin_nombre = administrador.nom_cliente
            tt.cliente_nombre = cliente.nom_cliente
            tt.cdg_condiva = contrato_hd.cdg_condiva
            tt.cdg_tipo_evento = tipo_evento.cdg_tipo_evento
            tt.resto_periodos = contrato_hd.resto_periodos
            tt.cant_periodos = contrato_hd.cant_periodos
            tt.anulado = contrato_hd.anulado
            tt.fecha_baja = contrato_hd.fecha_baja.
            FOR EACH evento WHERE evento.origen = "CONTRATO" AND evento.nro_identificacion = contrato_hd.nro_contrato BY evento.periodo DESCENDING:
                    tt.frealizado = IF evento.frealizado <> ? THEN evento.frealizado ELSE evento.fasignado.
                    LEAVE.
            END.
            IF AVAILABLE persona THEN DO:
                ASSIGN
                tt.tratamiento = persona.tratamiento
                tt.contacto = persona.nombre
                tt.email = persona.email.
            END.
            tt.agotado = contrato_hd.resto_periodos = 0 AND contrato_hd.cant_periodos <> 0.
END.
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
    fdesde:SCREEN-VALUE IN FRAME {&FRAME-NAME}= string(TODAY).
    fhasta:SCREEN-VALUE = string(TODAY).

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

