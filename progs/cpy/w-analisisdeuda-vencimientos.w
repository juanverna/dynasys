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
{findempresa.i}
{nrorelea.i}
{crystal_dyna.p}
{tiempo.i}
DEFINE BUFFER administrador FOR cliente.
DEFINE VARIABLE txn_activa AS LOGICAL.
DEFINE TEMP-TABLE anal
    FIELD cdg_cliente LIKE cliente.cdg_cliente
    FIELD nro_cliente LIKE cliente.nro_cliente
    FIELD nom_cliente LIKE Cliente.nom_cliente
    FIELD deuda1 LIKE sic.Cta_cte.imp_total
    FIELD deuda2 LIKE sic.Cta_cte.imp_total
    FIELD deuda3 LIKE sic.Cta_cte.imp_total
    FIELD deuda4 LIKE sic.Cta_cte.imp_total
    FIELD accion AS CHAR COLUMN-LABEL "Accion!Pend."
    FIELD fecha AS DATE COLUMN-LABEL "Fecha"
    FIELD nro LIKE evento.nro_evento COLUMN-LABEL "Nro.Ref."
    FIELD cobranza LIKE Rendicion_hd.nro_rendicion 
    FIELD ultcob LIKE Rendicion_hd.fch_rendicion
    FIELD estado AS CHAR LABEL "EST" FORMAT "X(25)".
  
DEFINE VAR nro_tipo_evento_cobranza LIKE tipo_evento.nro_tipo_evento NO-UNDO.
DEFINE VAR fanal AS DATE NO-UNDO.
DEFINE VAR h_administraciones AS WIDGET-HANDLE NO-UNDO.
DEFINE VAR h_agenda_recursos AS WIDGET-HANDLE NO-UNDO.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE SmartWindow
&Scoped-define DB-AWARE no

&Scoped-define ADM-CONTAINER WINDOW

/* Name of designated FRAME-NAME and/or first browse and/or first query */
&Scoped-define FRAME-NAME F-Main
&Scoped-define BROWSE-NAME BROWSE-2

/* Internal Tables (found by Frame, Query & Browse Queries)             */
&Scoped-define INTERNAL-TABLES anal

/* Definitions for BROWSE BROWSE-2                                      */
&Scoped-define FIELDS-IN-QUERY-BROWSE-2 anal.cdg_cliente anal.nom_cliente anal.deuda1 anal.deuda2 anal.deuda3 anal.deuda4 anal.accion anal.fecha anal.nro anal.ultcob anal.cobranza anal.estado   
&Scoped-define ENABLED-FIELDS-IN-QUERY-BROWSE-2   
&Scoped-define SELF-NAME BROWSE-2
&Scoped-define QUERY-STRING-BROWSE-2 FOR EACH anal
&Scoped-define OPEN-QUERY-BROWSE-2 OPEN QUERY {&SELF-NAME} FOR EACH anal.
&Scoped-define TABLES-IN-QUERY-BROWSE-2 anal
&Scoped-define FIRST-TABLE-IN-QUERY-BROWSE-2 anal


/* Definitions for FRAME F-Main                                         */
&Scoped-define OPEN-BROWSERS-IN-QUERY-F-Main ~
    ~{&OPEN-QUERY-BROWSE-2}

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS p-vencimiento1 p-vencimiento2 p-vencimiento3 ~
BUTTON-13 BUTTON-8 BROWSE-2 BUTTON-11 Bagenda_recurso b-resumen 
&Scoped-Define DISPLAYED-OBJECTS p-vencimiento1 p-vencimiento2 ~
p-vencimiento3 

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
DEFINE BUTTON b-resumen 
     LABEL "&Resumen Cobranza" 
     SIZE 22 BY 1.14.

DEFINE BUTTON Bagenda_recurso 
     LABEL "Agenda Recurso" 
     SIZE 19 BY 1.14.

DEFINE BUTTON BUTTON-11 
     LABEL "Admimistracion" 
     SIZE 19 BY 1.14.

DEFINE BUTTON BUTTON-13 
     LABEL "Recalculo" 
     SIZE 15 BY 1.14.

DEFINE BUTTON BUTTON-8 
     IMAGE-UP FILE "img/excel.gif":U
     LABEL "Button 8" 
     SIZE 15 BY 1.14.

DEFINE VARIABLE p-vencimiento1 AS DATE FORMAT "99/99/9999":U 
     LABEL "Vencimiento1" 
     VIEW-AS FILL-IN 
     SIZE 17 BY 1 TOOLTIP "Fecha para deuda exigible" NO-UNDO.

DEFINE VARIABLE p-vencimiento2 AS DATE FORMAT "99/99/9999":U 
     LABEL "Vencimiento2" 
     VIEW-AS FILL-IN 
     SIZE 17 BY 1 TOOLTIP "Fecha para deuda exigible" NO-UNDO.

DEFINE VARIABLE p-vencimiento3 AS DATE FORMAT "99/99/9999":U 
     LABEL "Vencimiento3" 
     VIEW-AS FILL-IN 
     SIZE 17 BY 1 TOOLTIP "Fecha para deuda exigible" NO-UNDO.

/* Query definitions                                                    */
&ANALYZE-SUSPEND
DEFINE QUERY BROWSE-2 FOR 
      anal SCROLLING.
&ANALYZE-RESUME

/* Browse definitions                                                   */
DEFINE BROWSE BROWSE-2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS BROWSE-2 W-Win _FREEFORM
  QUERY BROWSE-2 DISPLAY
      anal.cdg_cliente
   anal.nom_cliente
   anal.deuda1
   anal.deuda2
   anal.deuda3
   anal.deuda4
   anal.accion
   anal.fecha
   anal.nro
   anal.ultcob
   anal.cobranza
   anal.estado
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ROW-MARKERS SEPARATORS SIZE 192 BY 14.76 ROW-HEIGHT-CHARS .48 FIT-LAST-COLUMN.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME F-Main
     p-vencimiento1 AT ROW 1.24 COL 14.8 COLON-ALIGNED WIDGET-ID 2
     p-vencimiento2 AT ROW 1.24 COL 46.2 COLON-ALIGNED WIDGET-ID 4
     p-vencimiento3 AT ROW 1.24 COL 78 COLON-ALIGNED WIDGET-ID 6
     BUTTON-13 AT ROW 1.24 COL 104 WIDGET-ID 8
     BUTTON-8 AT ROW 1.24 COL 121 WIDGET-ID 46
     BROWSE-2 AT ROW 2.91 COL 3 WIDGET-ID 100
     BUTTON-11 AT ROW 17.91 COL 3 WIDGET-ID 124
     Bagenda_recurso AT ROW 17.91 COL 24 WIDGET-ID 48
     b-resumen AT ROW 17.91 COL 46 WIDGET-ID 126
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 196.2 BY 18.48.


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
         HEIGHT             = 18.62
         WIDTH              = 196.2
         MAX-HEIGHT         = 26.62
         MAX-WIDTH          = 196.2
         VIRTUAL-HEIGHT     = 26.62
         VIRTUAL-WIDTH      = 196.2
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
/* BROWSE-TAB BROWSE-2 BUTTON-8 F-Main */
IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(W-Win)
THEN W-Win:HIDDEN = yes.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME


/* Setting information for Queries and Browse Widgets fields            */

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE BROWSE-2
/* Query rebuild information for BROWSE BROWSE-2
     _START_FREEFORM
OPEN QUERY {&SELF-NAME} FOR EACH anal.
     _END_FREEFORM
     _Query            is OPENED
*/  /* BROWSE BROWSE-2 */
&ANALYZE-RESUME

 


/* **********************  Create OCX Containers  ********************** */

&ANALYZE-SUSPEND _CREATE-DYNAMIC

&IF "{&OPSYS}" = "WIN32":U AND "{&WINDOW-SYSTEM}" NE "TTY":U &THEN

CREATE CONTROL-FRAME ProgressBar ASSIGN
       FRAME           = FRAME F-Main:HANDLE
       ROW             = 1.24
       COLUMN          = 141
       HEIGHT          = 1.19
       WIDTH           = 24
       WIDGET-ID       = 128
       HIDDEN          = no
       SENSITIVE       = yes.

PROCEDURE adm-create-controls:
      ProgressBar:NAME = "ProgressBar":U .
/* ProgressBar OCXINFO:CREATE-CONTROL from: {4A5E5E35-91F4-46B1-B62F-78148132EF93} type: XP_ProgressBar */
      ProgressBar:MOVE-AFTER(BUTTON-8:HANDLE IN FRAME F-Main).

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


&Scoped-define SELF-NAME b-resumen
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL b-resumen W-Win
ON CHOOSE OF b-resumen IN FRAME F-Main /* Resumen Cobranza */
DO:
  RUN resumen_cob.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME Bagenda_recurso
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Bagenda_recurso W-Win
ON CHOOSE OF Bagenda_recurso IN FRAME F-Main /* Agenda Recurso */
DO:
  IF NOT valid-handle(h_agenda_recursos) THEN DO:
      RUN w-agenda_recurso.w PERSISTENT SET h_agenda_recursos .
      RUN dispatch IN h_agenda_recursos ( INPUT 'initialize':U ) .
  END.
      ELSE DYNAMIC-FUNCTION("tope" IN h_agenda_recursos ). 
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define BROWSE-NAME BROWSE-2
&Scoped-define SELF-NAME BROWSE-2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL BROWSE-2 W-Win
ON MOUSE-SELECT-DBLCLICK OF BROWSE-2 IN FRAME F-Main
DO:
  IF anal.accion = "evento" THEN RUN d-zoom-evento.w(anal.nro,"DETALLE").
ELSE IF anal.accion = "TAREA" THEN RUN d-zoom-tareaC.w(anal.nro,"DETALLE").
ELSE MESSAGE "No hay accion a realizar".

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL BROWSE-2 W-Win
ON ROW-DISPLAY OF BROWSE-2 IN FRAME F-Main
DO:
  IF anal.accion = "EVENTO" THEN do:
    IF anal.fecha < fanal  THEN do:
      anal.accion:BGCOLOR IN BROWSE {&BROWSE-NAME} = 0.
      anal.accion:FGCOLOR IN BROWSE {&BROWSE-NAME} = 15.
    END.
    IF anal.fecha = ? THEN anal.accion:BGCOLOR IN BROWSE {&BROWSE-NAME} = 12.
  END.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME BUTTON-11
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL BUTTON-11 W-Win
ON CHOOSE OF BUTTON-11 IN FRAME F-Main /* Admimistracion */
DO:
  IF NOT valid-handle(h_administraciones) THEN DO:  
      RUN w-administraciones.w  PERSISTENT SET h_administraciones.
      RUN dispatch IN h_administraciones ( INPUT 'initialize':U ) .
  END.
    ELSE DYNAMIC-FUNCTION("tope" IN h_administraciones ). 
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME BUTTON-13
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL BUTTON-13 W-Win
ON CHOOSE OF BUTTON-13 IN FRAME F-Main /* Recalculo */
DO:
    RUN calculo_deuda.
  {&OPEN-QUERY-{&BROWSE-NAME}}
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME BUTTON-8
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL BUTTON-8 W-Win
ON CHOOSE OF BUTTON-8 IN FRAME F-Main /* Button 8 */
DO:
  run excel-export ( {&BROWSE-NAME}:HANDLE ).
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME p-vencimiento1
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL p-vencimiento1 W-Win
ON MOUSE-MENU-CLICK OF p-vencimiento1 IN FRAME F-Main /* Vencimiento1 */
DO:
     {selfecha.i}
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME p-vencimiento3
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL p-vencimiento3 W-Win
ON MOUSE-MENU-CLICK OF p-vencimiento3 IN FRAME F-Main /* Vencimiento3 */
DO:
     {selfecha.i}
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE calculo_deuda W-Win 
PROCEDURE calculo_deuda :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEFINE VAR totdeuda1 LIKE sic.Cta_cte.imp_total NO-UNDO.
DEFINE VAR totdeuda2 LIKE sic.Cta_cte.imp_total NO-UNDO.
DEFINE VAR totdeuda3 LIKE sic.Cta_cte.imp_total NO-UNDO.
DEFINE VAR totdeuda4 LIKE sic.Cta_cte.imp_total NO-UNDO.
DEFINE VAR h_browser AS HANDLE.
ASSIGN FRAME {&FRAME-NAME} p-vencimiento1 p-vencimiento2 p-vencimiento3.
h_browser = BROWSE {&BROWSE-NAME}:HANDLE.
deuda1:LABEL IN BROWSE {&BROWSE-NAME} = STRING(p-vencimiento1).
deuda2:LABEL IN BROWSE {&BROWSE-NAME}= STRING(p-vencimiento1 + 1 ) + "!" + STRING(p-vencimiento2).
deuda3:LABEL IN BROWSE {&BROWSE-NAME}= STRING(p-vencimiento2 + 1 ) + "!" + STRING(p-vencimiento3).
deuda4:LABEL IN BROWSE {&BROWSE-NAME}= STRING(p-vencimiento3 + 1).
deuda1:LABEL-BGCOLOR IN BROWSE {&BROWSE-NAME}= 12.
deuda2:LABEL-BGCOLOR IN BROWSE {&BROWSE-NAME}= 14.
deuda3:LABEL-BGCOLOR IN BROWSE {&BROWSE-NAME}= 10.
deuda4:LABEL-BGCOLOR IN BROWSE {&BROWSE-NAME}= 11.

DEFINE VAR hay AS LOGICAL NO-UNDO.
DEFINE VAR prg AS INT NO-UNDO.
/*p-vencimiento2 = p-vencimiento.
p-vencimiento1 = date( month(p-vencimiento) , 1 ,year(p-vencimiento) ) - 1.
p-vencimiento1 = date( month(p-vencimiento1) , DAY(p-vencimiento2) ,year(p-vencimiento) ).
p-vencimiento3 = date( month(p-vencimiento) , 1 ,year(p-vencimiento) ) - 1.
p-vencimiento3 = date( month(p-vencimiento1) , DAY(p-vencimiento2) ,year(p-vencimiento) ).*/
chProgressBar:XP_ProgressBar:MIN = 0.
chProgressBar:XP_ProgressBar:MAX = 20.
prg = 0.
EMPTY TEMP-TABLE anal.
FOR EACH cliente NO-LOCK:
    prg = prg + 1.
    IF prg > 20 THEN prg = 1.
    chProgressBar:XP_ProgressBar:VALUE = prg.
    totdeuda1 = 0.
    totdeuda2 = 0.
    totdeuda3 = 0.
    totdeuda4 = 0.
    hay = FALSE.
    FOR EACH Cta_cte NO-LOCK
            WHERE cta_cte.nro_administrador = cliente.nro_cliente
              AND Cta_cte.cdg_empresa     = empresa.cdg_empresa
              AND Cta_cte.debito <> Cta_cte.credito 
                   BY cta_cte.fecha_emision:
         IF cta_cte.fecha_vencimiento <= p-vencimiento1 THEN 
              totdeuda1 = totdeuda1 + Cta_cte.debito - Cta_cte.credito.
         IF cta_cte.fecha_vencimiento > p-vencimiento1 AND 
            cta_cte.fecha_vencimiento <= p-vencimiento2 THEN 
              totdeuda2 = totdeuda2 + Cta_cte.debito - Cta_cte.credito.
        IF cta_cte.fecha_vencimiento > p-vencimiento2 AND 
            cta_cte.fecha_vencimiento <= p-vencimiento3 THEN 
              totdeuda3 = totdeuda3 + Cta_cte.debito - Cta_cte.credito.
         IF cta_cte.fecha_vencimiento > p-vencimiento3 THEN 
              totdeuda4 = totdeuda4 + Cta_cte.debito - Cta_cte.credito.
    END.
    IF totdeuda1 + totdeuda2 + totdeuda3 + totdeuda4 = 0 THEN NEXT.
    CREATE anal.
    ASSIGN anal.cdg_cliente = cliente.cdg_cliente
    anal.nro_cliente = cliente.nro_cliente
    anal.nom_cliente = Cliente.nom_cliente
    anal.deuda1 = totdeuda1
    anal.deuda2 = totdeuda2
    anal.deuda3 = totdeuda3.
    anal.deuda4 = totdeuda4.
/*ultima cobranza*/
    FOR EACH rendicion_hd WHERE Rendicion_hd.nro_administrador = cliente.nro_cliente BY Rendicion_hd.fch_rendicion DESC:
        ASSIGN anal.ultcob = Rendicion_hd.fch_rendicion
               anal.cobranza = Rendicion_hd.nro_rendicion.
        LEAVE.
    END.
    /*hay evento o tarea abierta*/
    FIND FIRST tarea WHERE tarea.nro_cliente = cliente.nro_cliente AND tarea.cdg_tipotarea = "C" AND tarea.estado = "A" NO-LOCK NO-ERROR.
    IF AVAILABLE tarea THEN DO:
            ASSIGN anal.accion = "TAREA"
                   anal.nro = tarea.nro_tarea
                   anal.fecha = sic.Tarea.Visualizar.
    END.
    FIND FIRST evento WHERE NOT evento.anulado AND evento.nro_tipo_evento = nro_tipo_evento_cobranza AND
            evento.frealizado = ? AND evento.nro_cliente = cliente.nro_cliente NO-LOCK NO-ERROR.
        IF AVAILABLE evento THEN DO:
            ASSIGN anal.accion = "EVENTO"
                   anal.fecha = evento.fasignado
                   anal.nro = evento.nro_evento.
        END.
    IF AVAILABLE tarea AND AVAILABLE evento THEN anal.estado = "ER:TAREA:" + string(tarea.nro_tarea).
END.


END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE carga_deuda W-Win 
PROCEDURE carga_deuda :
/*------------------------------------------------------------------------------
  Purpose:  carga la deuda de los clientes llemando la tabla anal.
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/*
DEF VAR pperiodo AS INT NO-UNDO.
DEF VAR pdeuda1 AS DECIMAL NO-UNDO.
DEF VAR pdeuda2 AS DECIMAL NO-UNDO.
pperiodo = YEAR(p-vencimiento) * 100 + MONTH(p-vencimiento).
FOR EACH Administrador  
    WHERE  CAN-DO(Administrador.lista_empresas,empresa.cdg_empresa) NO-LOCK:
RUN deuda_administracion.p ( administrador.nro_cliente,TODAY , OUTPUT pdeuda1 ).
RUN deuda_administracion.p ( administrador.nro_cliente,p-vencimiento, OUTPUT pdeuda2 ).
IF pdeuda2 <= 0 THEN NEXT.
    CREATE anal.
    ASSIGN anal.cdg_cliente = administrador.cdg_cliente
           anal.nro_cliente = administrador.nro_cliente
           anal.nom_cliente = administrador.nom_cliente
           anal.deuda1 = pdeuda1
           anal.deuda2 = pdeuda2.
    FOR EACH tarea WHERE tarea.nro_cliente = anal.nro_cliente AND tarea.cdg_tipotarea = "C" NO-LOCK BY tarea.fecha_alta DESC:
            anal.accion = "TAREA".
            anal.nro = tarea.nro_tarea.
            anal.estado = tarea.estado.
            LEAVE.
    END.
    FOR EACH evento WHERE evento.nro_cliente = anal.nro_cliente AND 
                          evento.nro_tipo_evento = nro_tipo_evento_cobranza AND 
                          NOT evento.anulado and
                          evento.periodo = pperiodo NO-LOCK BY Evento.FCreado DESC:
            anal.accion = "EVENTO".
            anal.nro = evento.nro_evento.
            anal.estado = IF evento.frealizado<>? THEN "R" ELSE IF evento.fasignado <> ? THEN "A" ELSE "N".
            LEAVE.
    END.
END. */
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

OCXFile = SEARCH( "w-analisisdeuda-vencimientos.wrx":U ).
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
ELSE MESSAGE "w-analisisdeuda-vencimientos.wrx":U SKIP(1)
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
  DISPLAY p-vencimiento1 p-vencimiento2 p-vencimiento3 
      WITH FRAME F-Main IN WINDOW W-Win.
  ENABLE p-vencimiento1 p-vencimiento2 p-vencimiento3 BUTTON-13 BUTTON-8 
         BROWSE-2 BUTTON-11 Bagenda_recurso b-resumen 
      WITH FRAME F-Main IN WINDOW W-Win.
  {&OPEN-BROWSERS-IN-QUERY-F-Main}
  VIEW W-Win.
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
p-vencimiento3 = DATE( MONTH( TODAY ) , 1 , YEAR( TODAY )).
p-vencimiento3 = DATE( MONTH( p-vencimiento3 + 32 ),1,YEAR( p-vencimiento3 + 31 )).
p-vencimiento2 = TODAY.
p-vencimiento1 = DATE( MONTH( TODAY ) , 1 , YEAR( TODAY )).
p-vencimiento1 = p-vencimiento1 - 1.
DISPLAY p-vencimiento1 p-vencimiento2 p-vencimiento3 WITH FRAME {&FRAME-NAME}.
FIND tipo_evento WHERE tipo_evento.cdg_tipo_evento = "CO" NO-LOCK.
nro_tipo_evento_cobranza = tipo_evento.nro_tipo_evento.
fanal = resta_dia_habil(TODAY,2,"23456").
  RUN calculo_deuda.
  {&OPEN-QUERY-{&BROWSE-NAME}}
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

  {setwintit.i "SIC/BAS" "Modelo de Transacción"}


END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE resumen_cob W-Win 
PROCEDURE resumen_cob :
/*------------------------------------------------------------------------------
  Purpose:     imprime el resumen de cobranza para el cliente
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
{findempresa.i} 

DEF VAR xfile AS CHAR NO-UNDO.
DEF VAR ReportePath AS CHAR NO-UNDO.
DEF VAR cFullPath AS CHAR NO-UNDO.
DEF VAR XFullPath AS CHAR NO-UNDO.
DEF VAR exportFileName AS CHAR NO-UNDO.

DEFINE VAR pcorte AS DATE NO-UNDO.

pcorte = date(month(p-vencimiento1),13,YEAR(p-vencimiento1)). 

  DEFINE VARIABLE chApplication AS COM-HANDLE NO-UNDO.
  DEFINE VARIABLE chReport      AS COM-HANDLE NO-UNDO.

  RUN prinresumenes.p ( INPUT Empresa.cdg_empresa,
                             INPUT anal.cdg_cliente,
                             INPUT anal.cdg_cliente,
                             INPUT p-vencimiento2,
                             INPUT p-vencimiento2,
                             INPUT "*", /*todos los puntos de venta*/
                             INPUT 1,
                             OUTPUT xfile). 

ReportePath = "resumen_cobranzas".
       RUN fullPath (ReportePath, '.rpt':U, OUTPUT cFullPath).
IF cFullPath = ? 
THEN DO:
    RUN mensajepar.p (INPUT ReportePath, INPUT "CREP000").
    RETURN NO-apply.
END.

CREATE "CrystalRuntime.Application" chApplication.
chReport = chApplication:OpenReport(cFullPath, {&crOpenReportByTempCopy}).
chReport:DiscardSavedData(). /*eliminando lo previamente grabado*/
RUN fullpath ( INPUT xfile, INPUT "", OUTPUT xFullPath ).
chReport:Database:Tables:item(1):setTableLocation(xFullPath, '', '').
RUN crearReporte(chReport,"rpt",/*ViewReport*/ TRUE,/*PrinterName*/ "",
                 /*exportToDisk*/ FALSE, INPUT-OUTPUT exportFileName ).        
RELEASE OBJECT chReport. 
chReport = ?.
RELEASE OBJECT chApplication.
chApplication = ?.


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
  {src/adm/template/snd-list.i "anal"}

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

