&ANALYZE-SUSPEND _VERSION-NUMBER UIB_v8r12 GUI ADM1
&ANALYZE-RESUME
/* Connected Databases 
          sic              PROGRESS
*/
&Scoped-define WINDOW-NAME CURRENT-WINDOW
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
{extrae.i}
{findempresa.i}
  DEFINE VARIABLE x-lista      AS CHARACTER.
  DEFINE VARIABLE x-sino       AS LOGICAL.

DEFINE VAR diasabierto AS INT LABEL "Hace".
DEFINE VAR quiencargo LIKE usuario.cdg_usuario LABEL "Cargo".
DEFINE VAR quienrecurso AS CHAR LABEL "Responsable" NO-UNDO.
DEFINE VAR quienadministrador AS CHAR LABEL "Admin." NO-UNDO.
DEFINE VAR quiencliente AS CHAR LABEL "Cliente" NO-UNDO.
DEFINE BUFFER administrador FOR cliente.
DEFINE VAR nro AS INT NO-UNDO.
DEFINE VAR calc-col AS HANDLE EXTENT 15 NO-UNDO.
DEFINE VAR calc-val AS CHAR EXTENT 15 NO-UNDO.
DEFINE VAR sortby AS char NO-UNDO .
DEFINE VAR sortdir AS LOGICAL INITIAL TRUE NO-UNDO.
DEFINE VAR querystring AS CHARACTER NO-UNDO VIEW-AS EDITOR SIZE 40 BY 40 .
DEFINE VAR horario_de_atencion LIKE cliente.horario_de_atencion NO-undo.
DEFINE VAR idletime AS INT NO-UNDO INITIAL 30000.



/*creacion del remito*/

DEFINE TEMP-TABLE T-rem_detalle like rem_detalle.
DEFINE TEMP-TABLE T-rem_header like rem_header.
DEFINE TEMP-TABLE T-rem_detalle-bon like rem_detalle-bon.
DEFINE TEMP-TABLE T-rem_header-bon like rem_header-bon.
DEFINE TEMP-TABLE T-Sub_header_vta like Sub_header_vta.
DEFINE TEMP-TABLE T-Sub_detalle_vta LIKE Sub_detalle_vta.
DEFINE TEMP-TABLE T-Sub_header_inv like Sub_header_inv.
DEFINE TEMP-TABLE T-Sub_detalle_inv LIKE Sub_detalle_inv.
DEFINE TEMP-TABLE T-Rem_header_impuesto LIKE Rem_header_impuesto.
DEFINE TEMP-TABLE T-Rem_detalle_impuesto LIKE Rem_detalle_impuesto.
DEFINE TEMP-TABLE T-Registrable-remito like Registrable-remito.
DEFINE TEMP-TABLE T-remito-pedido like remito-pedido.

DEFINE TEMP-TABLE T-Fac_detalle NO-UNDO LIKE Fac_detalle.
DEFINE TEMP-TABLE T-Fac_detalle-bon NO-UNDO LIKE Fac_detalle-bon.
DEFINE TEMP-TABLE T-Fac_detalle_impuesto NO-UNDO LIKE Fac_detalle_impuesto.
DEFINE TEMP-TABLE T-Fac_header NO-UNDO LIKE Fac_header.
DEFINE TEMP-TABLE T-Fac_header-bon NO-UNDO LIKE Fac_header-bon.
DEFINE TEMP-TABLE T-Fac_header_impuesto NO-UNDO LIKE Fac_header_impuesto.
DEFINE TEMP-TABLE T-Registrable-factura NO-UNDO LIKE Registrable-factura.

DEFINE TEMP-TABLE t-evento like evento
    FIELD nro_linea LIKE t-rem_detalle.nro_linea
    INDEX por_linea nro_linea.

DEFINE VAR h_geocli AS WIDGET-HANDLE NO-UNDO.

{geolibrary.i}


DEFINE VAR h_geoTT AS HANDLE.

DEFINE TEMP-TABLE ttgeo NO-UNDO
    FIELD ttind AS INT
    FIELD ttgeolat AS DECIMAL
    FIELD ttgeolong AS DECIMAL
    FIELD tttipo AS INT
    FIELD tturl AS CHARACTER
    INDEX ind AS PRIMARY ttind.

{tiempo.i}
{advTexto.i}
{crystal_dyna.p}
{impresoras.i}
DEFINE TEMP-TABLE aimp
    FIELD c_nro_tipo_evento LIKE tipo_evento.nro_tipo_evento COLUMN-LABEL "Tipo!Evento"
    FIELD nro_evento AS INT LABEL "EVENTO"
    FIELD recurso LIKE evento.recurso 
    FIELD turno LIKE evento.turno
    FIELD aviso_evento AS INT LABEL "AVISO EVENTO"
    FIELD aviso_fasignado AS DATE LABEL "REPARTIR"
    FIELD aviso_recurso AS CHAR LABEL "RECURSO"
    FIELD tipoespecial AS CHAR LABEL "ESPECIAL".

DEFINE VAR acciones AS CHAR INITIAL "Inicial,0,Visitar,1,Cotizar,2,Enviado,3,Aceptar,4,Rechazar,5".

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE SmartBrowser
&Scoped-define DB-AWARE no

&Scoped-define ADM-SUPPORTED-LINKS Record-Source,Record-Target,TableIO-Target

/* Name of designated FRAME-NAME and/or first browse and/or first query */
&Scoped-define FRAME-NAME F-Main
&Scoped-define BROWSE-NAME br_table

/* Internal Tables (found by Frame, Query & Browse Queries)             */
&Scoped-define INTERNAL-TABLES Tarea tipo_tarea

/* Define KEY-PHRASE in case it is used by any query. */
&Scoped-define KEY-PHRASE TRUE

/* Definitions for BROWSE br_table                                      */
&Scoped-define FIELDS-IN-QUERY-br_table Tarea.prioridad tarea.estado tarea.turnogestion Tarea.nro_tarea /* Tarea.nro_predecesora */ Tarea.cdg_tipotarea quiencargo() @ quiencargo durmiendo() @ diasabierto quienrecurso( tarea.cdg_recurso ) @ quienrecurso quiennombre(tarea.nro_administrador) @ quienadministrador Tarea.direccion Tarea.FultimaM   
&Scoped-define ENABLED-FIELDS-IN-QUERY-br_table   
&Scoped-define SELF-NAME br_table
&Scoped-define OPEN-QUERY-br_table /*OPEN QUERY {&SELF-NAME} FOR EACH Tarea WHERE TRUE NO-LOCK, ~
           FIRST tipo_tarea OF tarea NO-LOCK {&SORT-FRASE}*/.
&Scoped-define TABLES-IN-QUERY-br_table Tarea tipo_tarea
&Scoped-define FIRST-TABLE-IN-QUERY-br_table Tarea
&Scoped-define SECOND-TABLE-IN-QUERY-br_table tipo_tarea


/* Definitions for FRAME F-Main                                         */

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS RECT-2 fnombre v-cdg_administrador Badm ~
ftarea que_estado que_recurso Fdireccion v-cdg_cliente Bcli Tauto ~
x_cdg_tipotarea que_proyecto fdescrip fvisualizar Texcluido Treloj ~
Brefrescar br_table BUTTON-12 BTN_nueva 
&Scoped-Define DISPLAYED-OBJECTS fnombre v-cdg_administrador ftarea ~
que_estado que_recurso Fdireccion v-cdg_cliente Tauto x_cdg_tipotarea ~
que_proyecto fdescrip fvisualizar Texcluido Treloj 

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
cdg_proyecto|y|y|sic.Tarea.cdg_proyecto
cdg_recurso|y|y|sic.Tarea.cdg_recurso
nro_tarea||y|sic.Tarea.nro_tarea
cdg_tipotarea||y|sic.Tarea.cdg_tipotarea
descripcion|y|y|sic.Tarea.descripcion
nro_cliente||y|sic.Tarea.nro_cliente
cdg_postal||y|sic.Tarea.cdg_postal
cdg_tarea||y|sic.Tarea.cdg_tarea
cdg_usuario||y|sic.Tarea.cdg_usuario
nro_usuario||y|sic.Tarea.nro_usuario
</FOREIGN-KEYS> 
<EXECUTING-CODE>
**************************
* Set attributes related to FOREIGN KEYS
*/
RUN set-attribute-list (
    'Keys-Accepted = "cdg_proyecto,cdg_recurso,descripcion",
     Keys-Supplied = "cdg_proyecto,cdg_recurso,nro_tarea,cdg_tipotarea,descripcion,nro_cliente,cdg_postal,cdg_tarea,cdg_usuario,nro_usuario"':U).

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
cdg_postal|y||sic.Tarea.cdg_postal|yes
</SORTBY-OPTIONS>
<SORTBY-RUN-CODE>
************************
* Set attributes related to SORTBY-OPTIONS */
RUN set-attribute-list (
    'SortBy-Options = "':U + 'cdg_postal' + '",
     SortBy-Case = ':U + 'cdg_postal').

/* Tell the ADM to use the OPEN-QUERY-CASES. */
&Scoped-define OPEN-QUERY-CASES RUN dispatch ('open-query-cases':U).

/************************
</SORTBY-RUN-CODE>
<FILTER-ATTRIBUTES>
</FILTER-ATTRIBUTES> */   

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

/* ************************  Function Prototypes ********************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION-FORWARD busca_email B-table-Win 
FUNCTION busca_email RETURNS CHARACTER
  ( nro AS INT )  FORWARD.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION-FORWARD durmiendo B-table-Win 
FUNCTION durmiendo RETURNS INTEGER
  ( /* parameter-definitions */ )  FORWARD.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION-FORWARD fcorte B-table-Win 
FUNCTION fcorte RETURNS DATE
  ( /* parameter-definitions */ )  FORWARD.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION-FORWARD formulario B-table-Win 
FUNCTION formulario RETURNS CHARACTER
  ( INPUT rid_fac_header AS ROWID )  FORWARD.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION-FORWARD quehorario B-table-Win 
FUNCTION quehorario RETURNS CHARACTER
  ( /* parameter-definitions */ )  FORWARD.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION-FORWARD quiencargo B-table-Win 
FUNCTION quiencargo RETURNS CHARACTER
  ( /* parameter-definitions */ )  FORWARD.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION-FORWARD quiencliente B-table-Win 
FUNCTION quiencliente RETURNS CHARACTER
  ( INPUT pp AS INT )  FORWARD.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION-FORWARD quiennombre B-table-Win 
FUNCTION quiennombre RETURNS CHARACTER
  ( INPUT pp AS INT )  FORWARD.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION-FORWARD quienrecurso B-table-Win 
FUNCTION quienrecurso RETURNS CHARACTER
  ( INPUT pp AS CHAR )  FORWARD.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION-FORWARD refresco B-table-Win 
FUNCTION refresco RETURNS LOGICAL
  ( cond AS LOGICAL )  FORWARD.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION-FORWARD tiene_presup B-table-Win 
FUNCTION tiene_presup RETURNS CHARACTER
  ( nro AS int )  FORWARD.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION-FORWARD validaprf B-table-Win 
FUNCTION validaprf RETURNS LOGICAL
  ( prf AS INT , imp_servicio AS decimal )  FORWARD.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


/* ***********************  Control Definitions  ********************** */


/* Definitions of handles for OCX Containers                            */
DEFINE VARIABLE CtrlTimer AS WIDGET-HANDLE NO-UNDO.
DEFINE VARIABLE chCtrlTimer AS COMPONENT-HANDLE NO-UNDO.
DEFINE VARIABLE ProgressBar AS WIDGET-HANDLE NO-UNDO.
DEFINE VARIABLE chProgressBar AS COMPONENT-HANDLE NO-UNDO.

/* Definitions of the field level widgets                               */
DEFINE BUTTON Badm 
     LABEL "SADM" 
     SIZE 7.6 BY 1 TOOLTIP "Filtrar por este administrador".

DEFINE BUTTON Bcli 
     LABEL "SCLI" 
     SIZE 7.6 BY 1 TOOLTIP "Filtrar por este administrador".

DEFINE BUTTON Brefrescar 
     LABEL "Refrescar" 
     SIZE 15 BY .91.

DEFINE BUTTON BTN_arecuperar 
     LABEL "&Caido" 
     SIZE 15 BY 1.14 TOOLTIP "A realizar alguna accion para porder recuperar el cliente de esta tarea".

DEFINE BUTTON BTN_CERRAR 
     LABEL "&Cierra" 
     SIZE 15 BY 1.14 TOOLTIP "Cierre de la tarea".

DEFINE BUTTON BTN_DESCARTAR 
     LABEL "&Descarta" 
     SIZE 15 BY 1.14 TOOLTIP "Descarta la tarea".

DEFINE BUTTON btn_FaltaOT 
     LABEL "&Falta OT" 
     SIZE 15 BY 1.14 TOOLTIP "Estado previo al cierre donde solo falta la OT".

DEFINE BUTTON BTN_nueva 
     LABEL "&Nueva" 
     SIZE 15 BY 1.14.

DEFINE BUTTON BTN_REABRIR 
     LABEL "&Reabre" 
     SIZE 15 BY 1.14 TOOLTIP "Reabre una tarea cerrada".

DEFINE BUTTON BUTTON-12 
     IMAGE-UP FILE "excel.gif":U
     LABEL "Button 12" 
     SIZE 7.6 BY 1.14.

DEFINE VARIABLE que_estado AS CHARACTER FORMAT "X(256)":U 
     LABEL "Estado" 
     VIEW-AS COMBO-BOX SORT INNER-LINES 15
     LIST-ITEM-PAIRS "Todos","*",
                     "Abierto","A",
                     "Resuelto","R",
                     "Descartado","D",
                     "Caido","C",
                     "Precedida","Z",
                     "Falta OT","F"
     DROP-DOWN-LIST
     SIZE 18 BY 1
     BGCOLOR 15 FGCOLOR 9  NO-UNDO.

DEFINE VARIABLE que_proyecto AS CHARACTER FORMAT "X(8)" 
     LABEL "Proy" 
     VIEW-AS COMBO-BOX INNER-LINES 25
     LIST-ITEM-PAIRS "Item 1","Item 1"
     DROP-DOWN-LIST
     SIZE 27 BY 1
     BGCOLOR 15 FGCOLOR 9 .

DEFINE VARIABLE que_recurso AS CHARACTER FORMAT "X(8)" 
     LABEL "Recurso" 
     VIEW-AS COMBO-BOX INNER-LINES 25
     LIST-ITEM-PAIRS "Item 1","Item 1"
     DROP-DOWN-LIST
     SIZE 27 BY 1
     BGCOLOR 15 FGCOLOR 9 .

DEFINE VARIABLE x_cdg_tipotarea AS CHARACTER FORMAT "X(10)" INITIAL "*" 
     LABEL "Tipo" 
     VIEW-AS COMBO-BOX SORT INNER-LINES 25
     LIST-ITEM-PAIRS "Item 1","Item 1"
     DROP-DOWN-LIST
     SIZE 25 BY 1
     BGCOLOR 15 FGCOLOR 9 .

DEFINE VARIABLE fdescrip AS CHARACTER FORMAT "X(256)":U 
     LABEL "Descrip" 
     VIEW-AS FILL-IN NATIVE 
     SIZE 32 BY 1
     BGCOLOR 15 FGCOLOR 9  NO-UNDO.

DEFINE VARIABLE Fdireccion AS CHARACTER FORMAT "X(256)":U 
     LABEL "Direccion" 
     VIEW-AS FILL-IN NATIVE 
     SIZE 32 BY 1
     BGCOLOR 15 FGCOLOR 9  NO-UNDO.

DEFINE VARIABLE fnombre AS CHARACTER FORMAT "X(256)":U 
     LABEL "Nombre" 
     VIEW-AS FILL-IN NATIVE 
     SIZE 32 BY 1
     BGCOLOR 15 FGCOLOR 9  NO-UNDO.

DEFINE VARIABLE ftarea AS CHARACTER FORMAT "X(256)":U 
     LABEL "Tarea" 
     VIEW-AS FILL-IN NATIVE 
     SIZE 14 BY 1
     BGCOLOR 15 FGCOLOR 9  NO-UNDO.

DEFINE VARIABLE fvisualizar AS DATETIME FORMAT "99/99/99 HH:MM:SS":U 
     LABEL "Vis." 
     VIEW-AS FILL-IN NATIVE 
     SIZE 25 BY 1
     BGCOLOR 15 FGCOLOR 9  NO-UNDO.

DEFINE VARIABLE v-cdg_administrador AS CHARACTER FORMAT "X(256)":U 
     LABEL "Admin" 
     VIEW-AS FILL-IN NATIVE 
     SIZE 14 BY 1
     BGCOLOR 15 FGCOLOR 9  NO-UNDO.

DEFINE VARIABLE v-cdg_cliente AS CHARACTER FORMAT "X(256)":U 
     LABEL "Clien" 
     VIEW-AS FILL-IN NATIVE 
     SIZE 14 BY 1
     BGCOLOR 15 FGCOLOR 9  NO-UNDO.

DEFINE RECTANGLE RECT-2
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 196 BY 1.62.

DEFINE VARIABLE Tauto AS LOGICAL INITIAL yes 
     LABEL "Auto" 
     VIEW-AS TOGGLE-BOX
     SIZE 13.4 BY .81 NO-UNDO.

DEFINE VARIABLE Texcluido AS LOGICAL INITIAL no 
     LABEL "Exc" 
     VIEW-AS TOGGLE-BOX
     SIZE 8 BY .81 NO-UNDO.

DEFINE VARIABLE Treloj AS LOGICAL INITIAL yes 
     LABEL "Reloj" 
     VIEW-AS TOGGLE-BOX
     SIZE 13.4 BY .81 TOOLTIP "Si la visualizacion sigue al reloj del CPU" NO-UNDO.

/* Query definitions                                                    */
&ANALYZE-SUSPEND
DEFINE QUERY br_table FOR 
      Tarea, 
      tipo_tarea SCROLLING.
&ANALYZE-RESUME

/* Browse definitions                                                   */
DEFINE BROWSE br_table
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS br_table B-table-Win _FREEFORM
  QUERY br_table NO-LOCK DISPLAY
      Tarea.prioridad COLUMN-LABEL "P" FORMAT "9":U 
      tarea.estado COLUMN-LABEL "E" FORMAT "X":U 
      tarea.turnogestion COLUMN-LABEL "TG" FORMAT "XX":U
      Tarea.nro_tarea COLUMN-LABEL "Nro.!Tarea" FORMAT ">>>>>9":U
      /* Tarea.nro_predecesora FORMAT ">>>>>9":U COLUMN-LABEL "Tarea!Prede." */
      Tarea.cdg_tipotarea COLUMN-LABEL "T" FORMAT "X"
      quiencargo() @ quiencargo COLUMN-LABEL "Cgr" FORMAT "x(3)":U
      durmiendo() @ diasabierto COLUMN-LABEL "LAT" FORMAT "->>9" WIDTH 4 
      quienrecurso( tarea.cdg_recurso ) @ quienrecurso COLUMN-LABEL "Rsp" FORMAT "x(3)":U
      quiennombre(tarea.nro_administrador) @ quienadministrador COLUMN-LABEL "Admin" FORMAT "X(20)"
      Tarea.direccion COLUMN-LABEL "Cliente" FORMAT "X(80)":U WIDTH 35.5
      Tarea.FultimaM COLUMN-LABEL "Ultima!Modificacion" FORMAT  "99/99/99"
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ASSIGN SEPARATORS SIZE 198 BY 9.05
         BGCOLOR 15 FGCOLOR 9  ROW-HEIGHT-CHARS .71.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME F-Main
     fnombre AT ROW 1 COL 81 COLON-ALIGNED WIDGET-ID 20
     v-cdg_administrador AT ROW 1 COL 131 COLON-ALIGNED WIDGET-ID 10
     Badm AT ROW 1 COL 148 WIDGET-ID 12
     ftarea AT ROW 1.24 COL 173 COLON-ALIGNED WIDGET-ID 54
     que_estado AT ROW 1.95 COL 3.2
     que_recurso AT ROW 1.95 COL 43 COLON-ALIGNED
     Fdireccion AT ROW 1.95 COL 81 COLON-ALIGNED WIDGET-ID 22
     v-cdg_cliente AT ROW 1.95 COL 131 COLON-ALIGNED WIDGET-ID 28
     Bcli AT ROW 1.95 COL 148 WIDGET-ID 26
     Tauto AT ROW 2.19 COL 157 WIDGET-ID 50
     x_cdg_tipotarea AT ROW 2.91 COL 9 COLON-ALIGNED WIDGET-ID 2
     que_proyecto AT ROW 2.91 COL 43 COLON-ALIGNED
     fdescrip AT ROW 2.91 COL 81 COLON-ALIGNED WIDGET-ID 24
     fvisualizar AT ROW 3 COL 120 COLON-ALIGNED WIDGET-ID 34
     Texcluido AT ROW 3.14 COL 148 WIDGET-ID 36
     Treloj AT ROW 3.14 COL 157 WIDGET-ID 46
     Brefrescar AT ROW 3.14 COL 174 WIDGET-ID 40
     br_table AT ROW 4.33 COL 2
     BUTTON-12 AT ROW 14.33 COL 4.8 WIDGET-ID 14
     BTN_CERRAR AT ROW 14.33 COL 14
     BTN_DESCARTAR AT ROW 14.33 COL 30
     BTN_REABRIR AT ROW 14.33 COL 47
     BTN_arecuperar AT ROW 14.33 COL 64
     btn_FaltaOT AT ROW 14.33 COL 81 WIDGET-ID 52
     BTN_nueva AT ROW 14.38 COL 182.4 WIDGET-ID 32
     "                                           Selectores y Filtros" VIEW-AS TEXT
          SIZE 70 BY .71 AT ROW 1.19 COL 1.4 WIDGET-ID 30
          BGCOLOR 5 FGCOLOR 15 
     RECT-2 AT ROW 14.1 COL 3
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
         HEIGHT             = 14.71
         WIDTH              = 199.4.
/* END WINDOW DEFINITION */
                                                                        */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _INCLUDED-LIB B-table-Win 
/* ************************* Included-Libraries *********************** */

{excel-export.i}
{src/adm/method/browser.i}

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME




/* ***********  Runtime Attributes and AppBuilder Settings  *********** */

&ANALYZE-SUSPEND _RUN-TIME-ATTRIBUTES
/* SETTINGS FOR WINDOW B-table-Win
  NOT-VISIBLE,,RUN-PERSISTENT                                           */
/* SETTINGS FOR FRAME F-Main
   NOT-VISIBLE FRAME-NAME Size-to-Fit                                   */
/* BROWSE-TAB br_table Brefrescar F-Main */
ASSIGN 
       FRAME F-Main:SCROLLABLE       = FALSE
       FRAME F-Main:HIDDEN           = TRUE.

ASSIGN 
       br_table:ALLOW-COLUMN-SEARCHING IN FRAME F-Main = TRUE
       br_table:COLUMN-RESIZABLE IN FRAME F-Main       = TRUE.

/* SETTINGS FOR BUTTON BTN_arecuperar IN FRAME F-Main
   NO-ENABLE                                                            */
/* SETTINGS FOR BUTTON BTN_CERRAR IN FRAME F-Main
   NO-ENABLE                                                            */
/* SETTINGS FOR BUTTON BTN_DESCARTAR IN FRAME F-Main
   NO-ENABLE                                                            */
/* SETTINGS FOR BUTTON btn_FaltaOT IN FRAME F-Main
   NO-ENABLE                                                            */
/* SETTINGS FOR BUTTON BTN_REABRIR IN FRAME F-Main
   NO-ENABLE                                                            */
/* SETTINGS FOR COMBO-BOX que_estado IN FRAME F-Main
   ALIGN-L                                                              */
/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME


/* Setting information for Queries and Browse Widgets fields            */

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE br_table
/* Query rebuild information for BROWSE br_table
     _START_FREEFORM
/*OPEN QUERY {&SELF-NAME} FOR EACH Tarea WHERE TRUE NO-LOCK,
    FIRST tipo_tarea OF tarea NO-LOCK {&SORT-FRASE}*/
     _END_FREEFORM
     _Options          = "NO-LOCK INDEXED-REPOSITION KEY-PHRASE SORTBY-PHRASE"
     _Where[1]         = "CAN-DO(que_proyecto,Tarea.cdg_proyecto)
 AND Tarea.estado = que_estado and can-do(x_cdg_tipotarea, tarea.cdg_tipotarea )
 AND CAN-DO(que_recurso,Tarea.cdg_recurso)"
     _Query            is NOT OPENED
*/  /* BROWSE br_table */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _QUERY-BLOCK FRAME F-Main
/* Query rebuild information for FRAME F-Main
     _Options          = "NO-LOCK"
     _Query            is NOT OPENED
*/  /* FRAME F-Main */
&ANALYZE-RESUME

 


/* **********************  Create OCX Containers  ********************** */

&ANALYZE-SUSPEND _CREATE-DYNAMIC

&IF "{&OPSYS}" = "WIN32":U AND "{&WINDOW-SYSTEM}" NE "TTY":U &THEN

CREATE CONTROL-FRAME ProgressBar ASSIGN
       FRAME           = FRAME F-Main:HANDLE
       ROW             = 2.38
       COLUMN          = 173.6
       HEIGHT          = .71
       WIDTH           = 16
       WIDGET-ID       = 58
       HIDDEN          = no
       SENSITIVE       = yes.

CREATE CONTROL-FRAME CtrlTimer ASSIGN
       FRAME           = FRAME F-Main:HANDLE
       ROW             = 13.62
       COLUMN          = 100
       HEIGHT          = 1.86
       WIDTH           = 8
       WIDGET-ID       = 56
       HIDDEN          = yes
       SENSITIVE       = yes.

PROCEDURE adm-create-controls:
      ProgressBar:NAME = "ProgressBar":U .
/* ProgressBar OCXINFO:CREATE-CONTROL from: {4A5E5E35-91F4-46B1-B62F-78148132EF93} type: XP_ProgressBar */
      CtrlTimer:NAME = "CtrlTimer":U .
/* CtrlTimer OCXINFO:CREATE-CONTROL from: {F0B88A90-F5DA-11CF-B545-0020AF6ED35A} type: PSTimer */
      ProgressBar:MOVE-AFTER(Tauto:HANDLE IN FRAME F-Main).
      CtrlTimer:MOVE-AFTER(br_table:HANDLE IN FRAME F-Main).

END PROCEDURE.

&ENDIF

&ANALYZE-RESUME /* End of _CREATE-DYNAMIC */


/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME Badm
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Badm B-table-Win
ON CHOOSE OF Badm IN FRAME F-Main /* SADM */
DO:
  ASSIGN v-cdg_administrador.
  IF v-cdg_administrador <> "" THEN do: 
          v-cdg_administrador = "".
          badm:LABEL = "SADM".
  END.
  ELSE DO:
      IF tarea.nro_cliente <> 0 THEN DO:
              FIND cliente WHERE cliente.nro_cliente = tarea.nro_administrador NO-LOCK NO-ERROR.
              IF NOT AVAILABLE cliente  THEN RETURN NO-APPLY.
              v-cdg_administrador = cliente.cdg_cliente.
              badm:LABEL = "TODO".
      END.
  END.
      DISPLAY v-cdg_administrador WITH FRAME {&FRAME-NAME}.
      RUN dispatch IN THIS-PROCEDURE ('open-query':U).
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME Bcli
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Bcli B-table-Win
ON CHOOSE OF Bcli IN FRAME F-Main /* SCLI */
DO:
  DEFINE VAR nro AS INT.
  ASSIGN v-cdg_cliente.
  IF v-cdg_cliente <> "" THEN do: 
          v-cdg_cliente = "".
          bcli:LABEL = "SCLI".
  END.
  ELSE DO:
      IF tarea.nro_cliente <> 0 THEN DO:
              FIND cliente WHERE cliente.nro_cliente = tarea.nro_cliente NO-LOCK NO-ERROR.
              IF NOT AVAILABLE cliente  THEN RETURN NO-APPLY.
              v-cdg_cliente = cliente.cdg_cliente.
              bcli:LABEL = "TODO".
      END.
  END.
      DISPLAY v-cdg_cliente WITH FRAME {&FRAME-NAME}.
      RUN dispatch IN THIS-PROCEDURE ('open-query':U).
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME Brefrescar
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Brefrescar B-table-Win
ON CHOOSE OF Brefrescar IN FRAME F-Main /* Refrescar */
DO:
  IF fvisualizar:SCREEN-VALUE <> "" THEN
      RUN dispatch IN THIS-PROCEDURE ('open-query':U).
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define BROWSE-NAME br_table
&Scoped-define SELF-NAME br_table
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL br_table B-table-Win
ON CTRL-ALT-ENTER OF br_table IN FRAME F-Main
DO:
  FIND CURRENT tarea EXCLUSIVE-LOCK.
  UPDATE tarea EXCEPT titulo  WITH FRAME edita SIDE-LABELS 3 COLUMNS SIZE 180 BY 30  VIEW-AS DIALOG-BOX.
  FIND CURRENT tarea NO-LOCK.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL br_table B-table-Win
ON MOUSE-SELECT-DBLCLICK OF br_table IN FRAME F-Main
DO:
    DEFINE VAR hproc AS HANDLE NO-UNDO.
    DEFINE VAR hcproc AS CHAR NO-UNDO.
    DEFINE BUFFER btarea FOR tarea.

    FIND btarea WHERE rowid(btarea) = rowid(tarea) NO-WAIT NO-ERROR.
    IF NOT AVAILABLE btarea THEN do:
            MESSAGE "La tarea la esta editando otro usuario" VIEW-AS ALERT-BOX information.
    END.
    refresco(FALSE).
    RUN get-link-handle IN adm-broker-hdl
        ( INPUT THIS-PROCEDURE,
          INPUT "CONTAINER-source",
          OUTPUT hcproc ).
      /* Code placed here will execute PRIOR to standard behavior. */
    hproc = WIDGET-HANDLE(hcproc).
    IF VALID-HANDLE(hProc) THEN 
          RUN select-page IN hproc (2).
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL br_table B-table-Win
ON ROW-DISPLAY OF br_table IN FRAME F-Main
DO:
  DEFINE VAR k AS INT NO-UNDO.
  DEFINE VAR fge AS INT NO-UNDO.
  DEFINE VAR bge AS INT NO-UNDO.
  DEFINE VAR auxi AS int NO-UNDO.
  DEFINE VAR auxd AS DECIMAL NO-UNDO.
  DEFINE VAR auxf AS DATE NO-UNDO.
  DEFINE VAR auxc AS CHAR NO-UNDO.
  DEFINE BUFFER btarea FOR tarea.
      
  /*refresco( FALSE ).*/
  DO k = 1 TO 15:
      IF calc-val[k] = "" THEN NEXT.
       IF VALID-HANDLE(calc-col[k]) THEN DO:
        /*especiales que deben ejecutar programans para obtener el dato*/
        CASE X_cdg_tipotarea:
            WHEN "*" THEN DO:
                CASE calc-val[k]:
                    WHEN "Resuelto" THEN DISPLAY tarea.fecha_resuelto.
                END.
            END.
            WHEN "H" THEN DO:
                    CASE calc-val[k]:
                        WHEN "Fecha Limpieza" THEN do:
                              auxi = INTEGER(extrae("EVENTOLT",tarea.dato)) NO-ERROR.
                              IF auxi <> ? THEN DO:
                                FIND evento WHERE evento.nro_evento = auxi NO-LOCK NO-error.
                                IF AVAILABLE evento THEN calc-col[k]:SCREEN-VALUE = STRING(evento.frealizado).
                              END.
                        END.
                        WHEN "E" THEN DO:
                              auxi = INTEGER(extrae("EVENTOLT",tarea.dato)) NO-ERROR.
                              IF auxi <> ? THEN DO:
                                FIND evento_protocolo WHERE evento_protocolo.nro_evento = auxi NO-LOCK NO-ERROR.
                                IF AVAILABLE evento_protocolo THEN calc-col[k]:SCREEN-VALUE = evento_protocolo.estado.
                              END.
                        END.
                        WHEN "Protocolo" THEN DO:
                              auxi = INTEGER(extrae("EVENTOLT",tarea.dato)) NO-ERROR.
                              IF auxi <> ? THEN DO:
                                FIND evento_protocolo WHERE evento_protocolo.nro_evento = auxi NO-LOCK NO-ERROR.
                                IF AVAILABLE evento_protocolo THEN calc-col[k]:SCREEN-VALUE = string(evento_protocolo.nro_protocolo,">>>>>>>>9").
                              END.
                        END.
                        WHEN "Certificado" THEN DO:
                              auxi = INTEGER(extrae("EVENTOLT",tarea.dato)) NO-ERROR.
                              IF auxi <> ? THEN DO:
                                FIND evento_protocolo WHERE evento_protocolo.nro_evento = auxi NO-LOCK NO-ERROR.
                                IF AVAILABLE evento_protocolo THEN calc-col[k]:SCREEN-VALUE = evento_protocolo.LetraPrefijo + string(evento_protocolo.nro_certificado,">>>>>>>>9").
                              END.
                        END.
                        WHEN "Email" THEN calc-col[k]:SCREEN-VALUE = busca_email(tarea.nro_admin).                    
                  END CASE.
            END.
            WHEN "J" THEN DO:
                  CASE calc-val[k]:
                    WHEN "Origen" THEN calc-col[k]:SCREEN-VALUE = tarea.origen.
                    WHEN "Fecha Limpieza" THEN do:
                         FIND evento OF tarea NO-LOCK NO-ERROR.
                         IF AVAILABLE evento THEN
                          calc-col[k]:SCREEN-VALUE = STRING(evento.frealizado).
                    END.
                    WHEN "Protocolo" THEN DO:
                                FIND evento_protocolo WHERE evento_protocolo.nro_evento = tarea.nro_identificacion NO-LOCK NO-ERROR.
                                IF AVAILABLE evento_protocolo THEN calc-col[k]:SCREEN-VALUE = string(evento_protocolo.nro_protocolo,">>>>>>>>9").
                    END.
                    WHEN "Certificado" THEN DO:
                                FIND evento_protocolo WHERE evento_protocolo.nro_evento = tarea.nro_identificacion NO-LOCK NO-ERROR.
                                IF AVAILABLE evento_protocolo THEN calc-col[k]:SCREEN-VALUE = evento_protocolo.LetraPrefijo + string(evento_protocolo.nro_certificado,">>>>>>>>9").
                    END.
                    WHEN "Email" THEN calc-col[k]:SCREEN-VALUE = busca_email(tarea.nro_admin).
                  END.
            END.
        
            WHEN "P" THEN DO:
                  CASE calc-val[k]:
                    WHEN "Accion" THEN calc-col[k]:SCREEN-VALUE = entry( int(tarea.accion) * 2  + 1, acciones ).
                    WHEN "Tipo" THEN do:
                        FIND contrato_hd WHERE contrato_hd.nro_contrato = tarea.nro_destino NO-LOCK NO-ERROR.
                        IF AVAILABLE contrato_hd THEN do:
                                FIND tipo_evento OF contrato_hd NO-LOCK NO-ERROR.
                                IF AVAILABLE tipo_evento THEN calc-col[k]:SCREEN-VALUE = tipo_evento.cdg_tipo_evento.
                        END.
                        /*IF tarea.origen = "EVENTO" THEN do:
                            FIND evento WHERE evento.nro_evento = tarea.nro_identificacion NO-LOCK no-error.
                            IF AVAILABLE evento THEN DO:
                                FIND tipo_evento OF evento NO-LOCK NO-ERROR.
                                IF AVAILABLE tipo_evento THEN calc-col[k]:SCREEN-VALUE = tipo_evento.cdg_tipo_evento.
                            END.
                        END.*/
                    END.
                    WHEN "Fecha" THEN do:
                        IF tarea.origen = "EVENTO" THEN do:
                            FIND evento WHERE evento.nro_evento = tarea.nro_identificacion NO-LOCK no-error.
                            IF AVAILABLE evento THEN DO:
                                calc-col[k]:SCREEN-VALUE = string(sumarmeses(evento.frealizado , 5 ) ,"99/99/99" ).
                            END.
                        END.
                    END.
                    WHEN "Origen" THEN calc-col[k]:SCREEN-VALUE = tarea.origen.
                    WHEN "Identif" THEN calc-col[k]:SCREEN-VALUE = string(tarea.nro_identificacion).
                  END.
            END.

            WHEN "Z" OR WHEN "TYZ" OR WHEN "T" THEN DO:
                 CASE calc-val[k]:
                    WHEN "Resuelto" THEN DISPLAY tarea.fecha_resuelto.
                    WHEN "Email" THEN calc-col[k]:SCREEN-VALUE = busca_email(tarea.nro_admin).
                    OTHERWISE calc-col[k]:SCREEN-VALUE = extrae( calc-val[k],tarea.dato) .
                 END.
            END.
            WHEN "F"  THEN DO:
                 CASE calc-val[k]:
                    WHEN "Resuelto" THEN DISPLAY tarea.fecha_resuelto.
                    WHEN "Origen" THEN calc-col[k]:SCREEN-VALUE = tarea.origen.
                    WHEN "Email" THEN calc-col[k]:SCREEN-VALUE = busca_email(tarea.nro_admin).
                    OTHERWISE calc-col[k]:SCREEN-VALUE = extrae( calc-val[k],tarea.dato) .
                 END.
            END.
            WHEN "L" THEN DO:
                 CASE calc-val[k]:
                     WHEN "Art" THEN DO:
                         auxc = "".
                         FIND contrato_hd WHERE contrato_hd.nro_contrato = int(Tarea.nro_identificacion) NO-LOCK NO-ERROR.
                         IF AVAILABLE contrato_hd THEN DO:
                             FOR EACH contrato_dt NO-LOCK OF contrato_hd:
                                 FIND articulo NO-LOCK WHERE articulo.nro_articulo = contrato_dt.nro_articulo no-error.
                                 IF AVAILABLE articulo  THEN 
                                         auxc = auxc + "," + articulo.cdg_articulo.
                             END.
                             calc-col[k]:SCREEN-VALUE = SUBSTRING(auxc,2).
                         END.

                     END.
                     WHEN "imp_renov" THEN DO:
                         FIND contrato_hd WHERE contrato_hd.nro_contrato = int(Tarea.nro_identificacion) NO-LOCK NO-ERROR.
                         IF AVAILABLE contrato_hd THEN DO:
                             calc-col[k]:SCREEN-VALUE = string(contrato_hd.nro_plazo).
                         END.
                     END.

                    WHEN "Resuelto" THEN DISPLAY tarea.fecha_resuelto.
                    WHEN "Presupuesto" THEN calc-col[k]:SCREEN-VALUE = tiene_presup(tarea.nro_identificacion).
                     WHEN "Descrip" THEN DO:
                         calc-col[k]:SCREEN-VALUE = IF num-entries(tarea.descripcion,"|") >= 3 THEN entry( 3 , tarea.descripcion , "|" ) ELSE "".
                     END.
                    WHEN "Email" THEN calc-col[k]:SCREEN-VALUE = busca_email(tarea.nro_admin).
                    OTHERWISE calc-col[k]:SCREEN-VALUE = extrae( calc-val[k],tarea.dato) .
                 END.
            END.
            WHEN "Q" OR WHEN "DQFE" THEN DO:
                CASE calc-val[k]:
                    WHEN "Origen" THEN calc-col[k]:SCREEN-VALUE = tarea.origen.
                    WHEN "Resuelto" THEN DISPLAY tarea.fecha_resuelto.
                    WHEN "Email" THEN calc-col[k]:SCREEN-VALUE = busca_email(tarea.nro_admin).
                    OTHERWISE calc-col[k]:SCREEN-VALUE = extrae( calc-val[k],tarea.dato) .
                END.
            END.
            WHEN "C" THEN DO:
                
                CASE calc-val[k]:
                    WHEN "Resuelto" THEN DISPLAY tarea.fecha_resuelto.
                    WHEN "Deuda" THEN DO:
                          auxd = 0.
                          FIND cliente OF tarea NO-LOCK NO-ERROR.
                          IF AVAILABLE cliente THEN DO:
                             RUN deuda_administracion-corte.p(cliente.nro_cliente,fcorte(),OUTPUT auxd).
                          END.
                          calc-col[k]:SCREEN-VALUE = STRING(auxd).
                    END.
                    WHEN "Ult.Cob" THEN DO:
                          auxf = ?.
                          FIND cliente OF tarea NO-LOCK NO-ERROR.
                          IF AVAILABLE cliente THEN 
                             RUN deuda_administracionF.p(cliente.nro_cliente,OUTPUT auxf).
                          calc-col[k]:SCREEN-VALUE = STRING(auxf).
                    END.
                    WHEN "Horario Atenc." THEN DO:
                          FIND cliente OF tarea NO-LOCK NO-ERROR.
                          IF AVAILABLE cliente THEN 
                            calc-col[k]:SCREEN-VALUE = cliente.horario_de_atencion.
                    END.
                    WHEN "Email" THEN calc-col[k]:SCREEN-VALUE = busca_email(tarea.nro_admin).
                    OTHERWISE calc-col[k]:SCREEN-VALUE = extrae( calc-val[k],tarea.dato) .
                END.
            END.
            
            OTHERWISE calc-col[k]:SCREEN-VALUE = extrae( calc-val[k],tarea.dato) .
        END.
       END.
  END.
   IF Tipo_tarea.color_letra = 0 AND Tipo_tarea.color_fondo = 0 THEN DO:
       Tarea.cdg_tipotarea:FGCOLOR IN BROWSE {&BROWSE-NAME}= ?.
       Tarea.cdg_tipotarea:BGCOLOR = ?.
   END.
   ELSE DO:
       Tarea.cdg_tipotarea:FGCOLOR IN BROWSE {&BROWSE-NAME}= Tipo_tarea.color_letra.
       Tarea.cdg_tipotarea:BGCOLOR = Tipo_tarea.color_fondo.
   END.

   IF tarea.cdg_tipotarea = "C" THEN DO:
        FIND cliente OF tarea NO-LOCK NO-ERROR.
        IF AVAILABLE cliente THEN 
           IF index(cliente.horario_de_atencion , ":" ) <> 0 THEN DO:
            IF en_hora( cliente.horario_de_atencion ,STRING(TIME,"HH:MM")) THEN 
                tarea.turnogestion:BGCOLOR = 12.
           END.
           ELSE 
                tarea.turnogestion:BGCOLOR = 13.
   END.
   IF tarea.cdg_tipotarea = "J" THEN DO:
        FIND administrador WHERE tarea.nro_admin = administrador.nro_cliente NO-LOCK NO-ERROR.
        IF AVAILABLE cliente THEN 
           IF index(administrador.horario_de_atencion , ":" ) <> 0 THEN DO:
            IF en_hora( administrador.horario_de_atencion ,STRING(TIME,"HH:MM")) THEN 
                tarea.turnogestion:BGCOLOR = 12.
           END.
           ELSE 
                tarea.turnogestion:BGCOLOR = 13.
   END.
   IF tarea.cdg_tipotarea = "P" THEN DO:
        FIND administrador WHERE administrador.nro_cliente = tarea.nro_admin NO-LOCK NO-ERROR.
        IF AVAILABLE administrador THEN 
            IF en_hora( administrador.horario_de_atencion ,STRING(TIME,"HH:MM")) THEN 
                tarea.turnogestion:BGCOLOR = 12.
   END.

  IF tarea.cdg_tipotarea = "D" OR  tarea.cdg_tipotarea = "DQFE" THEN DO: 
        IF TODAY = tarea.fecha_prevista AND 
             string( TIME , "HH:MM" ) >= tarea.hora_prevista AND 
             string( TIME , "HH:MM" ) <= extrae("hora_fin",tarea.dato) THEN DO:
                IF VALID-HANDLE(calc-col[4]) THEN
                    calc-col[4]:BGCOLOR = 14.
        END.
        ELSE DO:
           IF TODAY = tarea.fecha_prevista AND 
             string( TIME , "HH:MM" ) >= tarea.hora_prevista AND 
             string( TIME , "HH:MM" ) > extrae("hora_fin",tarea.dato) THEN DO:
                IF VALID-HANDLE(calc-col[4]) THEN
                    calc-col[4]:BGCOLOR = 12.
           END.
        END.
        
  END.
   
  CASE tarea.estado.
      WHEN "A" THEN DO:
          fge = 17.
          bge = 0.   
      END.
      WHEN "D" THEN DO:
          bge = 12.
          fge = 0.
      END.
      WHEN "R" THEN DO:
          bge = 10.
          fge = 0.
      END.
      WHEN "F" THEN DO:
              bge = 13.
              fge = ?.
      END.
      OTHERWISE DO:
          bge = ?.
          fge = ?.
      END.
  END CASE.
   tarea.estado:FGCOLOR IN BROWSE {&BROWSE-NAME}= fge.
   tarea.estado:BGCOLOR = bge.

    /*
    Tipo_tarea.dsc_tipotarea:FGCOLOR IN BROWSE {&BROWSE-NAME}= Tipo_tarea.color_letra.
    Tipo_tarea.dsc_tipotarea:BGCOLOR = Tipo_tarea.color_fondo.
    */
   FIND btarea WHERE rowid(btarea) = rowid(tarea) NO-WAIT NO-ERROR.
   IF NOT AVAILABLE btarea THEN Tarea.nro_tarea:BGCOLOR IN BROWSE {&BROWSE-NAME} = 7 .
     ELSE Tarea.nro_tarea:BGCOLOR IN BROWSE {&BROWSE-NAME} = ?.
   refresco(TRUE).
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
ON START-SEARCH OF br_table IN FRAME F-Main
DO:
    DEFINE VAR h_col AS HANDLE NO-UNDO.
    DEFINE VAR k AS INT NO-UNDO.
    DEFINE VAR h_query AS HANDLE NO-UNDO.
/*   DEF VAR cc AS CHAR NO-UNDO.                 */
/*   DO WITH WITH FRAME {&FRAME-NAME}:           */
/*     CASE SELF:CURRENT-COLUMN:NAME :           */
/*       WHEN "nom_cliente" THEN cc = "Nombre".  */
/*       WHEN "localidad" THEN cc = "Localidad". */
/*       WHEN "direccion" THEN cc = "Direccion". */
/*       WHEN "cdg_cliente" THEN cc = "Codigo".  */
/*       WHEN "cuit" THEN cc = "C.U.I.T.".       */
/*      END CASE.                                */
/*     que_nombre:LABEL = cc.                    */
/*     v-fantasia:HIDDEN = ( cc <> "Nombre" ) .  */
/*     APPLY "select" TO que_nombre.             */
/*    END.                                       */
    DEF VAR h_browser AS HANDLE NO-UNDO.
    h_browser = BROWSE {&BROWSE-NAME}:HANDLE.
    h_browser:CLEAR-SORT-ARROW().
    k = 0.
    h_col = h_browser:FIRST-COLUMN.
    DO k = 1 TO h_browser:NUM-COLUMNS:
        IF h_col = h_browser:CURRENT-COLUMN THEN LEAVE.
        h_col = h_col:NEXT-COLUMN.
    END.
    IF sortby <> h_col:NAME  THEN sortdir = TRUE.
    ELSE sortdir = NOT sortdir.
   
    h_browser:SET-SORT-ARROW ( k, sortdir ). 
    
    sortby = h_col:NAME.
    RUN dispatch IN THIS-PROCEDURE ('open-query':U).
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL br_table B-table-Win
ON VALUE-CHANGED OF br_table IN FRAME F-Main
DO:
  /* This ADM trigger code must be preserved in order to notify other
     objects when the browser's current row changes. */
  {src/adm/template/brschnge.i}
  IF AVAILABLE tarea THEN DO:

  BTN_CERRAR:SENSITIVE IN FRAME {&FRAME-NAME} = ( tarea.estado = "A" OR  tarea.estado = "C" OR tarea.estado = "F" ). 
  BTN_DESCARTAR:SENSITIVE IN FRAME {&FRAME-NAME} = ( tarea.estado = "A" OR tarea.estado = "C" ). 
  BTN_REABRIR:SENSITIVE IN FRAME {&FRAME-NAME} = ( tarea.estado = "D" OR tarea.estado = "R").
  BTN_arecuperar:SENSITIVE IN FRAME {&FRAME-NAME} = tarea.estado = "A".
  IF tarea.cdg_tipotarea = "D" THEN DO:
   IF tarea.estado = "A" THEN DO:
        btn_faltaOT:SENSITIVE IN FRAME {&FRAME-NAME} = TRUE.
        btn_faltaOT:LABEL IN FRAME {&FRAME-NAME} = "Falta OT".
   END.
   IF tarea.estado = "F" THEN DO:
        btn_faltaOT:SENSITIVE IN FRAME {&FRAME-NAME} = TRUE.
        btn_faltaOT:LABEL IN FRAME {&FRAME-NAME} = "Abre OT".
   END.
  END.
     RUN cambia_templateprinc ( tarea.cdg_tipotarea ).
  END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME BTN_arecuperar
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL BTN_arecuperar B-table-Win
ON CHOOSE OF BTN_arecuperar IN FRAME F-Main /* Caido */
DO:
    DEFINE VAR conf AS LOGICAL.
    MESSAGE "Confirma pasar al estado CAIDA esta tarea" VIEW-AS ALERT-BOX QUESTION
        BUTTONS YES-NO UPDATE conf.
    IF conf THEN DO:
        FIND CURRENT tarea EXCLUSIVE-LOCK.
        tarea.estado = "C".
        ETIME(TRUE).
        RELEASE tarea.
        RUN dispatch IN THIS-PROCEDURE ('open-query':U).
    END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME BTN_CERRAR
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL BTN_CERRAR B-table-Win
ON CHOOSE OF BTN_CERRAR IN FRAME F-Main /* Cierra */
DO:
DEFINE VAR k AS INT NO-UNDO.
DEFINE VAR ultrow AS INT NO-UNDO.
DEFINE VAR todook AS LOGICAL NO-UNDO.
DEFINE VAR explica AS CHAR NO-UNDO.
DEFINE VAR h_browser AS HANDLE NO-UNDO.
h_browser = BROWSE {&BROWSE-NAME}:HANDLE.

explica = "".
x-sino = NO.
refresco(FALSE).
DEFINE VAR pnro AS INT NO-UNDO.
IF AVAILABLE tarea THEN DO:
    IF Tarea.cdg_proyecto = "" THEN DO:
        MESSAGE "No indicó el proyecto al que se refiere la tarea"
        VIEW-AS ALERT-BOX ERROR TITLE "TARE001".
        chCtrlTimer:PSTimer:ENABLED = TRUE.
        return no-apply.
    END.
    ultrow = h_browser:GET-REPOSITIONED-ROW ( ).
    IF tarea.telefonos = "" THEN DO:
        MESSAGE "Indique al menos un telefono de contacto" VIEW-AS ALERT-BOX ERROR.
        chCtrlTimer:PSTimer:ENABLED = TRUE.
        return no-apply.
    END.
    
    IF tarea.cdg_cargo = "" THEN DO:
        MESSAGE "Indique la relacion de la persona con el cliente" VIEW-AS ALERT-BOX ERROR.
        chCtrlTimer:PSTimer:ENABLED = TRUE.
        return no-apply.
    END.
    
    IF Tarea.cdg_recurso = ""
    THEN DO:
        MESSAGE "No indicó el recurso responsable"
            VIEW-AS ALERT-BOX ERROR TITLE "TARE003".
        chCtrlTimer:PSTimer:ENABLED = TRUE.
        return no-apply.
    END.
    
    MESSAGE "Desea CERRAR esta tarea" VIEW-AS ALERT-BOX MESSAGE BUTTONS YES-NO
            TITLE "Confirmacion" UPDATE x-sino .
         IF x-sino
          THEN DO:
                  FIND CURRENT Tarea EXCLUSIVE-LOCK.
                  CASE Tarea.cdg_tipotarea:
                      WHEN "S" THEN DO:
                         IF DATE( extrae("fecha",Tarea.datos-template) ) < TODAY
                         THEN DO:
                          MESSAGE "No puede asignar a una fecha menor a la actual" VIEW-AS ALERT-BOX ERROR.
                          chCtrlTimer:PSTimer:ENABLED = TRUE.
                          RETURN NO-APPLY.
                         END.
                             RUN crea_supervicion(OUTPUT todook).
                             IF NOT todook THEN RETURN NO-APPLY.
                      END.
                      WHEN "T" OR WHEN "R" THEN DO:
                                    find evento OF tarea.
                                    evento.observacion = agregaAdvTexto("Evento confirmado tarea:" + string(tarea.nro_tarea) , evento.observacion ).
                                    explica ="Evento:" + string(evento.nro_evento). 
                      END.
                      /*WHEN "J" THEN DO: /*Retiro de libro*/
                             IF DATE( extrae("fecha",Tarea.datos-template) ) < TODAY
                                 THEN DO:
                                  MESSAGE "No puede asignar a una fecha menor a la actual" VIEW-AS ALERT-BOX ERROR.
                                  chCtrlTimer:PSTimer:ENABLED = TRUE.
                                  RETURN NO-APPLY.
                             END.
                             RUN crea_retiro_libro(OUTPUT explica,OUTPUT todook).
                             IF NOT todook THEN RETURN NO-APPLY.
                      END.*/
                      
                      /*WHEN "H" THEN DO: /*Entrega de libro*/
                             IF DATE( extrae("fecha",Tarea.datos-template) ) < TODAY
                                 THEN DO:
                                  MESSAGE "No puede asignar a una fecha menor a la actual" VIEW-AS ALERT-BOX ERROR.
                                  chCtrlTimer:PSTimer:ENABLED = TRUE.
                                  RETURN NO-APPLY.
                             END.
                             RUN crea_entrega_libro(OUTPUT explica,OUTPUT todook).
                             IF NOT todook THEN RETURN NO-APPLY.
                      END.*/
                      WHEN "C" THEN DO: /*cobranzas*/
                             IF tarea.hora_prevista = ? THEN DO:
                                    MESSAGE "Indique hora prevista" VIEW-AS ALERT-BOX ERROR.
                                    chCtrlTimer:PSTimer:ENABLED = TRUE.
                                    RETURN NO-APPLY.
                             END.
                             IF extrae("hora_fin",tarea.dato) = "" OR extrae("hora_fin",tarea.dato) = "?" THEN DO:
                                    MESSAGE "Indique hora finalizacion" VIEW-AS ALERT-BOX ERROR.
                                    chCtrlTimer:PSTimer:ENABLED = TRUE.
                                    RETURN NO-APPLY.
                             END.
                             IF tarea.horas_estimadas = 0 THEN DO:
                                    MESSAGE "Indique los minutos de duracion" VIEW-AS ALERT-BOX ERROR.
                                    chCtrlTimer:PSTimer:ENABLED = TRUE.
                                    RETURN NO-APPLY.
                             END.
                             IF extrae("frecursos",Tarea.datos-template) = "" or
                                extrae("frecursos",Tarea.datos-template) = ? THEN DO:
                                MESSAGE "No indico el recurso, se crea el evento sin asignar" VIEW-AS ALERT-BOX ERROR.
                                RETURN NO-APPLY.
                             END.
    /*solo se puede cerrar tareas asignadas a un dia determinado no es valido el rango
    esto se pone por control no porque sea necesario, ya que corriendo la agenda se soluciona*/
                             IF extrae("fmin",tarea.datos-template) <> extrae("fmax",tarea.datos-template) THEN DO:
                                MESSAGE "La fecha son distintas, no se asignara el evento" VIEW-AS ALERT-BOX ERROR.
                                RETURN NO-APPLY.
                             END.
                             IF extrae("fmin",tarea.datos-template) = extrae("fmax",tarea.datos-template) and
                                DATE(extrae("fmin",tarea.datos-template)) < TODAY THEN DO:
                                MESSAGE "No puede asignar a una fecha menor a la actual" VIEW-AS ALERT-BOX ERROR.
                                RETURN NO-APPLY.
                             END.
                             
                             RUN crea_cobranza ( OUTPUT todook ).
                             IF NOT todook THEN RETURN NO-APPLY.
                             RUN asignarEC-cli.p ( tarea.nro_cliente ).
                      END.
                      WHEN "L" THEN DO:
                          IF tarea.origen = "CONTRATO" THEN DO:
                              pnro = tarea.nro_identificacion.
                              IF pnro <> 0 THEN DO:
                                  IF NOT validaprf(int(extrae("prf",Tarea.datos-template)) ,DECIMAL(extrae("imp_servicio",Tarea.datos-template))) THEN DO:
                                      chCtrlTimer:PSTimer:ENABLED = TRUE.
                                      RETURN NO-apply.
                                  END.
                                  RUN renov_contrato.p (
                                      DECIMAL(extrae("imp_servicio",Tarea.datos-template)),
                                      int(extrae("cant_periodos",Tarea.datos-template)),
                                      tarea.fecha_prevista,
                                      int(extrae("prf",Tarea.datos-template)),
                                      extrae("cdg_art",Tarea.datos-template),
                                      "A" /*lo crea aprobados por defecto*/,
                                      INPUT-OUTPUT pnro
                                  ).
                                  FIND FIRST evento WHERE evento.origen = "CONTRATO" AND evento.nro_identificacion = pnro AND NOT evento.anulado NO-ERROR.
                                  IF pnro <> ?  THEN DO:
                                      ASSIGN tarea.nro_destino = pnro
                                             tarea.destino = "CONTRATO".
                                  END.
                                  ELSE do:
                                      MESSAGE "La renovacion del contrato ha dado un error" SKIP
                                          "la tarea no puede cerrarse, es un problema del sistema" VIEW-AS ALERT-BOX ERROR.
                                      chCtrlTimer:PSTimer:ENABLED = TRUE.
                                      RETURN NO-apply.
                                  END.
                                  explica ="Ctrto:" + string(evento.nro_identificacion) + "Ev:" + string(evento.nro_evento). 
                              END.
                              ELSE DO:
                                  MESSAGE "Error contrato no registrado" VIEW-AS ALERT-BOX ERROR.
                                  chCtrlTimer:PSTimer:ENABLED = TRUE.
                                  RETURN NO-APPLY.
                              END.
                          END.
                          ELSE do: 
                              MESSAGE "Debo crear contrato - NO IMPLEMENTADO AUN".
                              chCtrlTimer:PSTimer:ENABLED = TRUE.
                              RETURN NO-APPLY.
                          END.
                      END.
                  when "D" THEN DO: /*destapacion crear evento manual o contrato segun tarea*/
                      IF NOT CAN-FIND( FIRST dato-precio WHERE dato-precio.ind1 = int(extrae("ind1",Tarea.datos-template)) AND
                                         dato-precio.ind2 = int(extrae("ind2",Tarea.datos-template)) AND
                                         dato-precio.ind3 = int(extrae("ind3",Tarea.datos-template)) and
                                         dato-precio.ind4 = int(extrae("ind4",Tarea.datos-template)) NO-LOCK ) THEN DO:
                          MESSAGE "No puede cerrar una tarea con una combinacion de servicio inexistente" VIEW-AS ALERT-BOX ERROR. 
                          chCtrlTimer:PSTimer:ENABLED = TRUE.
                          RETURN NO-APPLY.
                      END.
                      IF NOT validaprf(int(extrae("prf",Tarea.datos-template)) ,DECIMAL(extrae("imp_servicio",Tarea.datos-template))) THEN DO:
                            chCtrlTimer:PSTimer:ENABLED = TRUE.
                            RETURN NO-apply.
                      END.
                      IF DECIMAL(extrae("imp_servicio",Tarea.datos-template)) = 0 THEN DO:
                          MESSAGE "No puede cerrar sin indicar el precio" VIEW-AS ALERT-BOX ERROR.
                          chCtrlTimer:PSTimer:ENABLED = TRUE.
                          RETURN NO-APPLY.
                      END.

                      IF extrae("articulo",Tarea.datos-template) = "" THEN DO:
                          MESSAGE "No puede cerrar sin indicar articulo" VIEW-AS ALERT-BOX ERROR.
                          chCtrlTimer:PSTimer:ENABLED = TRUE.
                          RETURN NO-APPLY.
                      END.
                      IF extrae("frecursos",Tarea.datos-template) = "" or
                         extrae("frecursos",Tarea.datos-template) = ? THEN DO:
                          MESSAGE "No indico el recurso" VIEW-AS ALERT-BOX ERROR.
                          chCtrlTimer:PSTimer:ENABLED = TRUE.
                          RETURN NO-APPLY.
                      END.
                      IF hora_prevista = ? OR extrae("hora_fin",Tarea.datos-template) = "" THEN DO:
                          MESSAGE "No indico la hora de inicio y fin de la tarea" VIEW-AS ALERT-BOX ERROR.
                          chCtrlTimer:PSTimer:ENABLED = TRUE.
                          RETURN NO-APPLY.
                      END.
                      /*RUN crea_remitoD.*/
                      RUN crea_facturaD ( OUTPUT todook ).
                      IF NOT todook THEN RETURN NO-APPLY.
                  END.
                  when "F" THEN DO: /*fumigacion evento manual*/
                      IF DECIMAL(extrae("imp_servicio",Tarea.datos-template)) = 0 and
                             NOT logical(extrae("sin_cargo",Tarea.datos-template)) THEN DO:
                          MESSAGE "No puede cerrar sin indicar el precio" VIEW-AS ALERT-BOX ERROR.
                          chCtrlTimer:PSTimer:ENABLED = TRUE.
                          RETURN NO-APPLY.
                      END.
                      IF extrae("frecursos",Tarea.datos-template) = "" or
                         extrae("frecursos",Tarea.datos-template) = ? THEN DO:
                          MESSAGE "No indico el recurso" VIEW-AS ALERT-BOX ERROR.
                          chCtrlTimer:PSTimer:ENABLED = TRUE.
                          RETURN NO-APPLY.
                      END.
                      IF NOT logical(extrae("sin_cargo",Tarea.datos-template)) THEN
                          IF NOT validaprf(int(extrae("prf",Tarea.datos-template)) ,DECIMAL(extrae("imp_servicio",Tarea.datos-template))) THEN DO:
                            chCtrlTimer:PSTimer:ENABLED = TRUE.
                            RETURN NO-apply.
                          END.

                       IF extrae("turno",Tarea.datos-template) = "" or
                         extrae("turno",Tarea.datos-template) = ? THEN DO:
                          MESSAGE "Indique el turno" VIEW-AS ALERT-BOX ERROR.
                          chCtrlTimer:PSTimer:ENABLED = TRUE.
                          RETURN NO-APPLY.
                      END.
                      IF DATE( extrae("fecha",Tarea.datos-template) ) < TODAY
                         THEN DO:
                          MESSAGE "No puede asignar a una fecha menor a la actual" VIEW-AS ALERT-BOX ERROR.
                          chCtrlTimer:PSTimer:ENABLED = TRUE.
                          RETURN NO-APPLY.
                      END.
                      IF LOGICAL( extrae("sin_cargo",Tarea.datos-template) ) 
                         THEN RUN crea_manual ( OUTPUT todook ).
                         ELSE RUN crea_remitoFQ ( OUTPUT todook ).
                      
                      IF NOT todook THEN RETURN NO-APPLY.  
                  END.              
    
                  when "Q" THEN DO: /*Tanque crear evento manual*/
                      IF tarea.accion <> "2" THEN DO:
                         MESSAGE "No esta en el estado de Cotizacion" SKIP
                                 "verifique" VIEW-AS ALERT-BOX ERROR.
                         chCtrlTimer:PSTimer:ENABLED = TRUE.
                         RETURN NO-APPLY.
                      END.
                      IF DECIMAL(extrae("imp_servicio",Tarea.datos-template)) = 0 and
                        NOT logical(extrae("sin_cargo",Tarea.datos-template)) THEN DO:
                          MESSAGE "No puede cerrar sin indicar el precio" VIEW-AS ALERT-BOX ERROR.
                          chCtrlTimer:PSTimer:ENABLED = TRUE.
                          RETURN NO-APPLY.
                      END.
                      IF NOT logical(extrae("sin_cargo",Tarea.datos-template)) THEN
                          IF NOT validaprf(int(extrae("prf",Tarea.datos-template)) ,DECIMAL(extrae("imp_servicio",Tarea.datos-template))) THEN DO:
                                chCtrlTimer:PSTimer:ENABLED = TRUE.
                                RETURN NO-apply.
                          END.

                      IF extrae("frecursos",Tarea.datos-template) = "" or
                         extrae("frecursos",Tarea.datos-template) = ? THEN DO:
                          MESSAGE "No indico el recurso" VIEW-AS ALERT-BOX ERROR.
                          chCtrlTimer:PSTimer:ENABLED = TRUE.
                          RETURN NO-APPLY.
                      END.
                      IF DATE( extrae("fecha",Tarea.datos-template) ) < TODAY
                         THEN DO:
                          MESSAGE "No puede asignar a una fecha menor a la actual" VIEW-AS ALERT-BOX ERROR.
                          chCtrlTimer:PSTimer:ENABLED = TRUE.
                          RETURN NO-APPLY.
                      END.
                      IF LOGICAL( extrae("sin_cargo",Tarea.datos-template) ) THEN 
                              RUN crea_manual ( OUTPUT todook ).
                         ELSE RUN crea_remitoFQ ( OUTPUT todook ).
                      IF NOT todook THEN RETURN NO-APPLY.  .
                  END.              
                  END CASE.
                  /*verificar si se solicito impresion de OT relacionada al evento*/
                  IF logical(extrae("impreOT",Tarea.datos-template)) THEN DO:
                      IF tarea.nro_evento <> 0 THEN
                        RUN impreot(tarea.nro_evento).
                  END.
                  Tarea.estado = "R".
                  tarea.descripcion = agregaAdvTexto("Cerro " + explica ,tarea.descripcion).
                  IF Tarea.fecha_resuelto = ? THEN Tarea.fecha_resuelto = TODAY.
                  RELEASE tarea.
                  RUN dispatch IN THIS-PROCEDURE ('open-query':U).
                  h_browser = BROWSE {&BROWSE-NAME}:HANDLE.
                  h_browser:SET-REPOSITIONED-ROW ( ultrow , "CONDITIONAL" ). 
         END.
END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME BTN_DESCARTAR
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL BTN_DESCARTAR B-table-Win
ON CHOOSE OF BTN_DESCARTAR IN FRAME F-Main /* Descarta */
DO:
    x-sino = NO.
    refresco( FALSE ).
    IF AVAILABLE tarea THEN DO:
        IF int(tarea.nro_destino) <> 0 THEN DO:
            MESSAGE "Existe una accion posterior no puede descartar" VIEW-AS ALERT-BOX ERROR.
            chCtrlTimer:PSTimer:ENABLED = TRUE.
            RETURN NO-APPLY.
        END.
        IF tarea.cdg_tipotarea = "T" THEN DO:
            MESSAGE "*************************************" SKIP
                    "* Esta tarea no se DESCARTA se CIERRA *" SKIP
                    "*      caso contrario se regenerara   *" SKIP
                    "*************************************" SKIP.
            RETURN NO-APPLY.
        END.
            MESSAGE "Desea DESCARTAR esta tarea" VIEW-AS ALERT-BOX MESSAGE BUTTONS YES-NO
                    TITLE "Confirmacion" UPDATE x-sino .
        IF x-sino
        THEN DO:
                FIND CURRENT Tarea EXCLUSIVE-LOCK.
                tarea.descripcion = agregaAdvTexto("Descarto ",tarea.descripcion).
                Tarea.estado = "D".
                IF Tarea.fecha_resuelto = ? THEN Tarea.fecha_resuelto = TODAY.
                RUN dispatch IN THIS-PROCEDURE ('open-query':U).
        END.
    END.
    refresco(TRUE).
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btn_FaltaOT
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btn_FaltaOT B-table-Win
ON CHOOSE OF btn_FaltaOT IN FRAME F-Main /* Falta OT */
DO:
    DEFINE VAR conf AS LOGICAL.
    IF tarea.estado <> "F" THEN DO:
        MESSAGE "Confirma pasar al estado Falta OT esta tarea" VIEW-AS ALERT-BOX QUESTION
            BUTTONS YES-NO UPDATE conf.
        IF conf THEN DO:
            FIND CURRENT tarea EXCLUSIVE-LOCK.
            tarea.estado = "F".
            ETIME(TRUE).
            RELEASE tarea.
            RUN dispatch IN THIS-PROCEDURE ('open-query':U).
        END.
    END.
    ELSE DO:
        MESSAGE "Confirma pasar al estado de Abierto" VIEW-AS ALERT-BOX QUESTION
            BUTTONS YES-NO UPDATE conf.
        IF conf THEN DO:
            FIND CURRENT tarea EXCLUSIVE-LOCK.
            tarea.estado = "A".
            ETIME(TRUE).
            RELEASE tarea.
            RUN dispatch IN THIS-PROCEDURE ('open-query':U).
        END.
    END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME BTN_nueva
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL BTN_nueva B-table-Win
ON CHOOSE OF BTN_nueva IN FRAME F-Main /* Nueva */
DO:
DEFINE VAR hproc AS HANDLE NO-UNDO.
DEFINE VAR hcproc AS CHAR NO-UNDO.
    RUN get-link-handle IN adm-broker-hdl
        ( INPUT THIS-PROCEDURE,
          INPUT "CONTAINER-source",
          OUTPUT hcproc ).
      /* Code placed here will execute PRIOR to standard behavior. */
    hproc = WIDGET-HANDLE(hcproc).
    IF VALID-HANDLE(hProc) THEN DO:
        RUN select-page IN hproc (2).
        RUN new-state ('add-record':U).
    END.
    RELEASE cliente.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME BTN_REABRIR
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL BTN_REABRIR B-table-Win
ON CHOOSE OF BTN_REABRIR IN FRAME F-Main /* Reabre */
DO:
    x-sino = NO.
    refresco( FALSE ).
    IF AVAILABLE tarea THEN DO:
        IF int(tarea.nro_destino) <> 0 THEN DO:
            IF tarea.destino BEGINS "REMIT" THEN DO:
                FIND rem_header WHERE rem_header.nro_remito = tarea.nro_destino NO-LOCK.
                IF rem_header.anulado THEN DO:
                    FIND CURRENT  Tarea EXCLUSIVE-LOCK.
                    tarea.destino = "".
                    tarea.nro_destino = 0.
                END.
            END.
            IF tarea.destino BEGINS "CONTRATO" THEN DO:
                FIND contrato_hd WHERE contrato_hd.nro_contrato = tarea.nro_destino NO-LOCK NO-ERROR.
                IF NOT AVAILABLE contrato_hd THEN DO:
                    MESSAGE "Hay un error interno al reabrir contrato no registrado nro" tarea.nro_destino VIEW-AS ALERT-BOX ERROR.
                    RETURN NO-APPLY.
                END.
                IF contrato_hd.anulado OR Contrato_hd.fecha_baja <> ? THEN DO:
                    MESSAGE "No puede reabrir una tarea con un contrato anulado o dado de baja" tarea.nro_destino VIEW-AS ALERT-BOX ERROR.
                    RETURN NO-APPLY.
                END.
            END.
            IF tarea.destino BEGINS "EVENTO" THEN DO:
                FIND evento WHERE evento.nro_evento = tarea.nro_destino NO-LOCK NO-ERROR.
                IF AVAILABLE evento THEN DO:
                    IF evento.anulado THEN DO:
                        FIND CURRENT Tarea EXCLUSIVE-LOCK.
                        tarea.destino = "".
                        tarea.nro_destino = 0.
                    END.
                END.
                ELSE DO:
                        FIND CURRENT Tarea EXCLUSIVE-LOCK.
                        tarea.destino = "".
                        tarea.nro_destino = 0.
                END.
            END.

         END.
        IF int(tarea.nro_destino) <> 0 THEN DO:
            MESSAGE "Existe una accion posterior no puede reabrirse" skip
                    "Destino:" tarea.destino skip
                    "Identificacion:" tarea.nro_destino VIEW-AS ALERT-BOX ERROR.
            refresco(TRUE).
            RETURN NO-APPLY.
        END.
        MESSAGE "Desea REABRIR esta tarea" VIEW-AS ALERT-BOX MESSAGE BUTTONS YES-NO
            TITLE "Confirmacion" UPDATE x-sino .
        IF x-sino
        THEN DO:
                FIND CURRENT  Tarea EXCLUSIVE-LOCK.
                Tarea.estado = "A".
                Tarea.fecha_resuelto = ?.
                tarea.descripcion = agregaAdvTexto("Reabrio",tarea.descripcion).
                RUN dispatch IN THIS-PROCEDURE ('open-query':U).
        END.
    END.
    refresco(TRUE).
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME BUTTON-12
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL BUTTON-12 B-table-Win
ON CHOOSE OF BUTTON-12 IN FRAME F-Main /* Button 12 */
DO:
  refresco( FALSE ).
  run excel-export ( BROWSE {&BROWSE-NAME}:HANDLE ).

  refresco( TRUE ).
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fdescrip
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fdescrip B-table-Win
ON LEAVE OF fdescrip IN FRAME F-Main /* Descrip */
DO:
    IF {&SELF-NAME}:SCREEN-VALUE <> "" THEN
      RUN dispatch IN THIS-PROCEDURE ('open-query':U).
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fdescrip B-table-Win
ON RETURN OF fdescrip IN FRAME F-Main /* Descrip */
DO:
      IF {&SELF-NAME}:SCREEN-VALUE <> "" THEN
      RUN dispatch IN THIS-PROCEDURE ('open-query':U).
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME Fdireccion
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Fdireccion B-table-Win
ON LEAVE OF Fdireccion IN FRAME F-Main /* Direccion */
DO:
  IF {&SELF-NAME}:SCREEN-VALUE <> "" THEN
      RUN dispatch IN THIS-PROCEDURE ('open-query':U).
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Fdireccion B-table-Win
ON return OF Fdireccion IN FRAME F-Main /* Direccion */
DO:
  IF {&SELF-NAME}:SCREEN-VALUE <> "" THEN
      RUN dispatch IN THIS-PROCEDURE ('open-query':U).
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fnombre
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fnombre B-table-Win
ON LEAVE OF fnombre IN FRAME F-Main /* Nombre */
DO:
  IF {&SELF-NAME}:SCREEN-VALUE <> "" THEN
      RUN dispatch IN THIS-PROCEDURE ('open-query':U).
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fnombre B-table-Win
ON RETURN OF fnombre IN FRAME F-Main /* Nombre */
DO:
    IF {&SELF-NAME}:SCREEN-VALUE <> "" THEN
      RUN dispatch IN THIS-PROCEDURE ('open-query':U).
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME ftarea
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL ftarea B-table-Win
ON LEAVE OF ftarea IN FRAME F-Main /* Tarea */
DO:
    IF {&SELF-NAME}:SCREEN-VALUE <> "" THEN
      RUN dispatch IN THIS-PROCEDURE ('open-query':U).
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL ftarea B-table-Win
ON RETURN OF ftarea IN FRAME F-Main /* Tarea */
DO:
    IF {&SELF-NAME}:SCREEN-VALUE <> "" THEN
      RUN dispatch IN THIS-PROCEDURE ('open-query':U).
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fvisualizar
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fvisualizar B-table-Win
ON LEAVE OF fvisualizar IN FRAME F-Main /* Vis. */
DO:
  IF {&SELF-NAME}:SCREEN-VALUE <> "" THEN
      RUN dispatch IN THIS-PROCEDURE ('open-query':U).
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fvisualizar B-table-Win
ON MOUSE-MENU-CLICK OF fvisualizar IN FRAME F-Main /* Vis. */
DO:
  {selfecha.i}
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fvisualizar B-table-Win
ON RETURN OF fvisualizar IN FRAME F-Main /* Vis. */
DO:
      IF {&SELF-NAME}:SCREEN-VALUE <> "" THEN
      RUN dispatch IN THIS-PROCEDURE ('open-query':U).
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME que_estado
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL que_estado B-table-Win
ON VALUE-CHANGED OF que_estado IN FRAME F-Main /* Estado */
DO:
    ASSIGN que_estado.
    APPLY "VALUE-CHANGED" TO x_cdg_tipotarea.
    RUN dispatch IN THIS-PROCEDURE ('open-query':U).
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME que_proyecto
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL que_proyecto B-table-Win
ON VALUE-CHANGED OF que_proyecto IN FRAME F-Main /* Proy */
DO:
  ASSIGN que_proyecto.
  RUN dispatch IN THIS-PROCEDURE ('open-query':U).
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME que_recurso
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL que_recurso B-table-Win
ON VALUE-CHANGED OF que_recurso IN FRAME F-Main /* Recurso */
DO:
  ASSIGN que_recurso.
  RUN dispatch IN THIS-PROCEDURE ('open-query':U).
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME Tauto
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Tauto B-table-Win
ON VALUE-CHANGED OF Tauto IN FRAME F-Main /* Auto */
DO:
   ASSIGN {&SELF-NAME}.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME Texcluido
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Texcluido B-table-Win
ON VALUE-CHANGED OF Texcluido IN FRAME F-Main /* Exc */
DO:
  ASSIGN texcluido.
  RUN dispatch IN THIS-PROCEDURE ('open-query':U).
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME Treloj
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Treloj B-table-Win
ON VALUE-CHANGED OF Treloj IN FRAME F-Main /* Reloj */
DO:
  ASSIGN {&SELF-NAME}.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME v-cdg_administrador
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-cdg_administrador B-table-Win
ON LEAVE OF v-cdg_administrador IN FRAME F-Main /* Admin */
DO:
  IF {&SELF-NAME}:SCREEN-VALUE <> "" THEN
      RUN dispatch IN THIS-PROCEDURE ('open-query':U).
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-cdg_administrador B-table-Win
ON MOUSE-SELECT-DBLCLICK OF v-cdg_administrador IN FRAME F-Main /* Admin */
OR "." OF v-cdg_administrador IN FRAME {&FRAME-NAME}
OR MOUSE-MENU-DOWN OF v-cdg_administrador IN FRAME {&FRAME-NAME}
DO:
    DEFINE VAR rid_tabla AS ROWID.
   {helptabla.i "Administrador" "cdg_cliente" "SELADMINIS.P"}
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-cdg_administrador B-table-Win
ON return OF v-cdg_administrador IN FRAME F-Main /* Admin */
DO:
    ASSIGN v-cdg_administrador.
    RUN dispatch IN THIS-PROCEDURE ('open-query':U).
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME v-cdg_cliente
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-cdg_cliente B-table-Win
ON LEAVE OF v-cdg_cliente IN FRAME F-Main /* Clien */
DO:
  IF {&SELF-NAME}:SCREEN-VALUE <> "" THEN
      RUN dispatch IN THIS-PROCEDURE ('open-query':U).
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-cdg_cliente B-table-Win
ON MOUSE-SELECT-DBLCLICK OF v-cdg_cliente IN FRAME F-Main /* Clien */
OR "." OF v-cdg_cliente IN FRAME {&FRAME-NAME}
OR MOUSE-MENU-DOWN OF v-cdg_cliente IN FRAME {&FRAME-NAME}
DO:
    DEFINE VAR rid_tabla AS ROWID.
   {helptabla.i "cliente" "cdg_cliente" "SELclien.P"}
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-cdg_cliente B-table-Win
ON return OF v-cdg_cliente IN FRAME F-Main /* Clien */
DO:
    ASSIGN v-cdg_administrador.
    
    RUN dispatch IN THIS-PROCEDURE ('open-query':U).
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME x_cdg_tipotarea
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL x_cdg_tipotarea B-table-Win
ON VALUE-CHANGED OF x_cdg_tipotarea IN FRAME F-Main /* Tipo */
DO:
    DEFINE VAR k AS INT NO-UNDO.
    DEFINE VAR h_browser AS HANDLE.
    DEFINE VAR h_query AS HANDLE.
    DEFINE VAR fondo AS INT NO-UNDO.
    DEFINE VAR letra AS INT NO-UNDO.
    ASSIGN X_cdg_tipotarea.

    FIND tipo_tarea WHERE tipo_tarea.cdg_tipotarea = X_cdg_tipotarea NO-LOCK NO-ERROR.
    letra = ?.
    fondo = ?.
    IF AVAILABLE tipo_tarea THEN DO:
        letra = Tipo_tarea.color_letra.
        fondo = Tipo_tarea.color_fondo.
    END.
    DO k = 15 TO 1 BY -1:
              IF VALID-HANDLE( calc-col[k] )  THEN DO:
                DELETE WIDGET calc-col[k].
                calc-val[k] = "".
                calc-col[k] = ?.
              END.
    END.
    RUN dispatch IN THIS-PROCEDURE ('open-query':U).
    h_browser = BROWSE {&BROWSE-NAME}:HANDLE.

    CASE X_cdg_tipotarea:
        WHEN "C"  THEN DO: /*CObranza*/
          calc-col[1] = h_browser:ADD-LIKE-COLUMN("Tarea.visualizar").
          calc-col[1]:LABEL = "Visualizar".
          calc-val[2] = "CP".
          calc-val[3] = "fmin".
          calc-val[4] = "fmax".
          calc-val[5] = "Deuda".
          calc-val[6] = "Ult.Cob".
          calc-val[7] = "frecurso".
          calc-val[8] = "Horario Atenc.".
          calc-val[9] = "Email".
          calc-col[2] = h_browser:ADD-CALC-COLUMN("char","xx","","CP").
          calc-col[3] = h_browser:ADD-CALC-COLUMN("date","99/99/99","","Fmin").
          calc-col[4] = h_browser:ADD-CALC-COLUMN("date","99/99/99","","Fmax").
          calc-col[5] = h_browser:ADD-CALC-COLUMN("decimal","->>>>9.99","","Deuda").
          calc-col[6] = h_browser:ADD-CALC-COLUMN("date","99/99/99","","Ult.Cob").
          calc-col[7] = h_browser:ADD-CALC-COLUMN("char","x(10)","","Recurs").
          calc-col[8] = h_browser:ADD-CALC-COLUMN("char","x(30)","","Horario Atenc.").
          calc-col[9] = h_browser:ADD-CALC-COLUMN("char","x(50)","","Email").
          IF que_estado = "R" THEN DO:
            calc-val[10] = "Resuelto".
            calc-col[10] = h_browser:ADD-LIKE-COLUMN("Tarea.fecha_resuelto").
          END.
        END.

        WHEN "H" THEN DO:
          calc-val[1] = "Fecha Limpieza".
          calc-col[1] = h_browser:ADD-CALC-COLUMN("date","99/99/99","","Fecha Limpieza").
          calc-val[2] = "E".
          calc-col[2] = h_browser:ADD-CALC-COLUMN("char","x(2)","","E").
          calc-val[3] = "Protocolo".
          calc-col[3] = h_browser:ADD-CALC-COLUMN("int",">>>>>>>>9","","Protocolo").
          calc-val[4] = "Certificado".
          calc-col[4] = h_browser:ADD-CALC-COLUMN("int",">>>>>>>>9","","Certificado").
          calc-val[5] = "Email".
          calc-col[5] = h_browser:ADD-CALC-COLUMN("char","x(50)","","Email").
        END.
        
        WHEN "Q" THEN DO:
          calc-val[1] = "Email".
          calc-col[1] = h_browser:ADD-CALC-COLUMN("char","x(50)","","Email").
          IF que_estado = "R" THEN DO:
            calc-val[2] = "Resuelto".
            calc-col[2] = h_browser:ADD-LIKE-COLUMN("Tarea.fecha_resuelto").
          END.
        END.

        WHEN "P" THEN DO:
          calc-val[1] = "Origen".
          calc-col[1] = h_browser:ADD-LIKE-COLUMN("Tarea.origen").
          calc-val[2] = "Identif".
          calc-col[2] = h_browser:ADD-LIKE-COLUMN("Tarea.nro_identificacion").
          calc-val[3] = "Contr.".
          calc-col[3] = h_browser:ADD-LIKE-COLUMN("Tarea.nro_destino").
          calc-val[4] = "Tipo".
          calc-col[4] = h_browser:ADD-CALC-COLUMN("char","XX","","Tipo").
          calc-val[5] = "Alta".
          calc-col[5] = h_browser:ADD-LIKE-COLUMN("Tarea.fecha_alta").
          calc-val[6] = "Fecha".
          calc-col[6] = h_browser:ADD-CALC-COLUMN("date","99/99/99","","Fecha!Prevista").
          calc-val[7] = "Accion".
          calc-col[7] = h_browser:ADD-LIKE-COLUMN("Tarea.accion").
        END.

        WHEN "J" THEN DO:
          calc-val[1] = "Fecha Limpieza".
          calc-col[1] = h_browser:ADD-CALC-COLUMN("date","99/99/99","","Fecha Limpieza").
          IF que_estado = "R" THEN DO:
            calc-val[2] = "Resuelto".
            calc-col[2] = h_browser:ADD-LIKE-COLUMN("Tarea.fecha_resuelto").
          END.
          calc-val[3] = "Origen".
          calc-col[3] = h_browser:ADD-LIKE-COLUMN("Tarea.origen").
          calc-val[4] = "Protocolo".
          calc-col[4] = h_browser:ADD-CALC-COLUMN("int",">>>>>>>>9","","Protocolo").
          calc-val[5] = "Certificado".
          calc-col[5] = h_browser:ADD-CALC-COLUMN("int",">>>>>>>>9","","Certificado").
          calc-val[6] = "Email".
          calc-col[6] = h_browser:ADD-CALC-COLUMN("char","x(50)","","Email").
        END.

        WHEN "Z" OR WHEN "TYZ" THEN DO:
          calc-val[1] = "Email".
          calc-col[1] = h_browser:ADD-CALC-COLUMN("char","x(50)","","Email").
          IF que_estado = "R" THEN DO:
            calc-val[2] = "Resuelto".
            calc-col[2] = h_browser:ADD-LIKE-COLUMN("Tarea.fecha_resuelto").
          END.

        END.

        WHEN "T" THEN DO:
          calc-val[1] = "Email".
          calc-col[1] = h_browser:ADD-CALC-COLUMN("char","x(50)","","Email").
          IF que_estado = "R" THEN DO:
            calc-val[2] = "Resuelto".
            calc-col[2] = h_browser:ADD-LIKE-COLUMN("Tarea.fecha_resuelto").
          END.

        END.
        WHEN "F" THEN DO:
          calc-val[1] = "Origen".
          calc-col[1] = h_browser:ADD-LIKE-COLUMN("Tarea.origen").
          calc-val[2] = "Email".
          calc-col[2] = h_browser:ADD-CALC-COLUMN("char","x(50)","","Email").
          IF que_estado = "R" THEN DO:
            calc-val[3] = "Resuelto".
            calc-col[3] = h_browser:ADD-LIKE-COLUMN("Tarea.fecha_resuelto").
          END.

        END.

        WHEN "L"  THEN DO: /*Limpieza de tanques*/
          calc-val[1] = "imp_servicio".
          calc-col[1] = h_browser:ADD-CALC-COLUMN("DECIMAL",">>>>>9.99","","Precio").
          calc-val[2] = "imp_firma".
          calc-col[2] = h_browser:ADD-CALC-COLUMN("DECIMAL",">>>>>9.99","","Certif").
          calc-val[3] = "cant_periodos".
          calc-col[3] = h_browser:ADD-CALC-COLUMN("CHAR","X(3)","","Per").
          calc-col[4] = h_browser:ADD-LIKE-COLUMN("Tarea.fecha_prevista").
          calc-col[5] = h_browser:ADD-LIKE-COLUMN("Tarea.Origen").
          calc-col[5]:FORMAT = "X(4)"  NO-ERROR.
          calc-col[5]:WIDTH = 7 NO-ERROR.
          calc-col[6] = h_browser:ADD-LIKE-COLUMN("Tarea.nro_identificacion").
          calc-col[6]:LABEL = "Identif".
          calc-col[6]:WIDTH = 7 NO-ERROR.
          calc-col[7] = h_browser:ADD-CALC-COLUMN("char","x(5)","","Art").
          calc-col[7]:LABEL = "Art".
          calc-val[7] = "Art".
          calc-col[7]:WIDTH = 5 NO-ERROR.
          calc-val[8] = "presupuesto".
          calc-col[8] = h_browser:ADD-CALC-COLUMN("char","x(2)","","Pr").
          calc-val[9] = "Email".
          calc-col[9] = h_browser:ADD-CALC-COLUMN("char","x(50)","","Email").
          calc-col[10] = h_browser:ADD-CALC-COLUMN("char","x(50)","","Descrip").
          calc-val[10] = "Descrip".
          calc-col[10]:LABEL = "Descripcion".
          calc-col[10]:WIDTH = 50 NO-ERROR.  
          calc-val[11] = "imp_renov".
          calc-col[11] = h_browser:ADD-CALC-COLUMN("INTEGER",">9","","Renov").
          IF que_estado = "R" THEN DO:
            calc-val[12] = "Resuelto".
            calc-col[12] = h_browser:ADD-LIKE-COLUMN("Tarea.fecha_resuelto").
          END.
          
        END.
        WHEN "D"  THEN DO: /*Destapacion*/
          calc-col[1] = h_browser:ADD-LIKE-COLUMN("Tarea.fecha_prevista").
          calc-col[1]:WIDTH = 6 NO-ERROR.
          calc-col[1]:FORMAT = "99/99/99" NO-ERROR.
          calc-col[2] = h_browser:ADD-LIKE-COLUMN("Tarea.hora_prevista").
          calc-val[3] = "hora_fin".
          calc-col[3] = h_browser:ADD-CALC-COLUMN("CHARACTER","x(5)","","Rec.").
          calc-col[3]:LABEL = "Hora!Fin" NO-ERROR.
          calc-col[3]:FORMAT = "x(5)" NO-ERROR.
          calc-col[3]:WIDTH = 6 NO-ERROR.
          calc-val[4] = "frecursos".
          calc-col[4] = h_browser:ADD-CALC-COLUMN("CHARACTER","x(15)","","Rec.").
          IF que_estado = "R" THEN DO:
            calc-val[5] = "Resuelto".
            calc-col[5] = h_browser:ADD-LIKE-COLUMN("Tarea.fecha_resuelto").
          END.
        END.
        WHEN "DQFE"  THEN DO: /*Destapacion,tanques,fumigacion*/
          calc-col[1] = h_browser:ADD-LIKE-COLUMN("Tarea.fecha_prevista").
          calc-col[1]:WIDTH = 11 NO-ERROR.
          calc-col[1]:FORMAT = "99/99/99"  NO-ERROR.
          calc-col[2] = h_browser:ADD-LIKE-COLUMN("Tarea.hora_prevista").
          calc-val[3] = "hora_fin".
          calc-col[3] = h_browser:ADD-CALC-COLUMN("CHARACTER","x(5)","","Rec.").
          calc-col[3]:LABEL = "Hora!Hasta".
          calc-col[3]:FORMAT = "x(5)" NO-ERROR.
          calc-col[3]:WIDTH = 6  NO-ERROR.
          calc-val[4] = "frecursos".
          calc-col[4] = h_browser:ADD-CALC-COLUMN("CHARACTER","x(15)","","Rec.").
          calc-val[5] = "Email".
          calc-col[5] = h_browser:ADD-CALC-COLUMN("char","x(50)","","Email").
          IF que_estado = "R" THEN DO:
            calc-val[6] = "Resuelto".
            calc-col[6] = h_browser:ADD-LIKE-COLUMN("Tarea.fecha_resuelto").
          END.
        END.
        OTHERWISE DO:
              IF que_estado = "R" THEN DO:
                calc-val[1] = "Resuelto".
                calc-col[1] = h_browser:ADD-LIKE-COLUMN("Tarea.fecha_resuelto").
              END.
        END.
    END CASE.
    DO k = 15 TO 1 BY -1:
          IF VALID-HANDLE( calc-col[k] )  THEN DO:
            calc-col[k]:LABEL-BGCOLOR = fondo.
            calc-col[k]:LABEL-FGCOLOR = letra.
          END.
    END.

    IF AVAILABLE tarea THEN DO:
        h_browser = BROWSE {&BROWSE-NAME}:HANDLE.
        h_query = h_browser:QUERY.
        h_browser:refresh() NO-ERROR.
        h_query:REPOSITION-TO-ROW(1) NO-ERROR.
END.

END.
 /*   IF AVAILABLE tarea THEN
        br_table:refresh(). */

 /* browse-hdl:EXPANDABLE = YES. */

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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE actividades_por_tarea B-table-Win 
PROCEDURE actividades_por_tarea :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

  RUN actividades_por_tarea.p ( INPUT que_estado,
                                INPUT que_proyecto,
                                INPUT que_recurso ).


END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE adm-open-query-cases B-table-Win  adm/support/_adm-opn.p
PROCEDURE adm-open-query-cases :
/*------------------------------------------------------------------------------
  Purpose:     Opens different cases of the query based on attributes
               such as the 'Key-Name', or 'SortBy-Case'
  Parameters:  <none>
------------------------------------------------------------------------------*/
  DEF VAR key-value AS CHAR NO-UNDO.

  /* Look up the current key-value. */
  RUN get-attribute ('Key-Value':U).
  key-value = RETURN-VALUE.

  /* Find the current record using the current Key-Name. */
  RUN get-attribute ('Key-Name':U).
  CASE RETURN-VALUE:
    WHEN 'cdg_proyecto':U THEN DO:
       &Scope KEY-PHRASE Tarea.cdg_proyecto eq key-value
       RUN get-attribute ('SortBy-Case':U).
       CASE RETURN-VALUE:
         WHEN 'cdg_postal':U THEN DO:
           &Scope SORTBY-PHRASE BY Tarea.cdg_postal
           {&OPEN-QUERY-{&BROWSE-NAME}}
         END.
         OTHERWISE DO:
           &Undefine SORTBY-PHRASE
           {&OPEN-QUERY-{&BROWSE-NAME}}
         END. /* OTHERWISE...*/
       END CASE.
    END. /* cdg_proyecto */
    WHEN 'cdg_recurso':U THEN DO:
       &Scope KEY-PHRASE Tarea.cdg_recurso eq key-value
       RUN get-attribute ('SortBy-Case':U).
       CASE RETURN-VALUE:
         WHEN 'cdg_postal':U THEN DO:
           &Scope SORTBY-PHRASE BY Tarea.cdg_postal
           {&OPEN-QUERY-{&BROWSE-NAME}}
         END.
         OTHERWISE DO:
           &Undefine SORTBY-PHRASE
           {&OPEN-QUERY-{&BROWSE-NAME}}
         END. /* OTHERWISE...*/
       END CASE.
    END. /* cdg_recurso */
    WHEN 'descripcion':U THEN DO:
       &Scope KEY-PHRASE Tarea.descripcion eq key-value
       RUN get-attribute ('SortBy-Case':U).
       CASE RETURN-VALUE:
         WHEN 'cdg_postal':U THEN DO:
           &Scope SORTBY-PHRASE BY Tarea.cdg_postal
           {&OPEN-QUERY-{&BROWSE-NAME}}
         END.
         OTHERWISE DO:
           &Undefine SORTBY-PHRASE
           {&OPEN-QUERY-{&BROWSE-NAME}}
         END. /* OTHERWISE...*/
       END CASE.
    END. /* descripcion */
    OTHERWISE DO:
       &Scope KEY-PHRASE TRUE
       RUN get-attribute ('SortBy-Case':U).
       CASE RETURN-VALUE:
         WHEN 'cdg_postal':U THEN DO:
           &Scope SORTBY-PHRASE BY Tarea.cdg_postal
           {&OPEN-QUERY-{&BROWSE-NAME}}
         END.
         OTHERWISE DO:
           &Undefine SORTBY-PHRASE
           {&OPEN-QUERY-{&BROWSE-NAME}}
         END. /* OTHERWISE...*/
       END CASE.
    END. /* OTHERWISE...*/
  END CASE.

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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE aparea_envio B-table-Win 
PROCEDURE aparea_envio :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEFINE VAR pperiodo AS INT NO-UNDO.
DEFINE BUFFER coevento FOR evento.

find tipo_evento WHERE tipo_evento.cdg_tipo_evento = "CO".
pperiodo = evento.periodo.
FOR EACH evento WHERE evento.origen = "ENVIO" AND evento.periodo = pperiodo:
    FIND FIRST coevento WHERE evento.nro_cliente = coevento.nro_cliente and
    coevento.nro_tipo_evento = tipo_evento.nro_tipo_evento AND
    coevento.fasignado <= evento.fmax AND coevento.fasignado >= evento.fmin AND
    coevento.frealizado <> ? AND NOT coevento.anulado AND
           coevento.periodo = evento.periodo NO-LOCK NO-ERROR.
    IF AVAILABLE coevento THEN DO:
        evento.evsigue = coevento.nro_evento.
        evento.fasignado = coevento.fasignado.
        evento.recurso = coevento.recurso.
        evento.durac = 1.
        REPEAT:
            FIND recurso_agenda WHERE recurso_agenda.nro_evento = evento.nro_evento AND
                    recurso_agenda.cdg_recurso = entry(1,evento.recurso) NO-ERROR.
            IF NOT AVAILABLE recurso_agenda THEN DO:
                IF LOCKED recurso_agenda THEN DO:
                    MESSAGE "La agenda del recurso esta tomada por otro usuario" VIEW-AS ALERT-BOX INFORMATION.
                    NEXT.
                END.
                CREATE recurso_agenda.
                ASSIGN recurso_agenda.nro_evento = evento.nro_evento
                       recurso_agenda.cdg_recurso = entry(1,evento.recurso).
            END.
            recurso_agenda.fecha = evento.fasignado.
            RELEASE recurso_agenda.
            LEAVE.
        END.
    END.
END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE asignar_caja B-table-Win 
PROCEDURE asignar_caja :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

    ASSIGN 
       Caj_header.nro_cuenta      = Cuenta.nro_cuenta
       Caj_header.nro_cliente     = T-Fac_header.nro_cliente
       Caj_header.cdg_empresa     = T-Fac_header.cdg_empresa
       Caj_header.prf_comprob     = T-Fac_header.prf_comprob
       Caj_header.tip_comprob     = T-Fac_header.tip_comprob
       Caj_header.importe         = T-Fac_header.imp_total.


END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE asignar_release B-table-Win 
PROCEDURE asignar_release :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

  DEFINE VARIABLE que_version AS CHARACTER.
  
  IF NOT CAN-FIND(Proyecto WHERE Proyecto.cdg_proyecto = que_proyecto)
  THEN DO:
      MESSAGE "No se indicó el proyecto" VIEW-AS ALERT-BOX ERROR.
      RETURN ERROR.
  END.

  RUN d-que_version.w ( OUTPUT que_version ).

  IF que_version <> ?
       THEN RUN asignar_version.p ( INPUT que_proyecto,
                                    INPUT que_version ).

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE borrar_tablas_remito B-table-Win 
PROCEDURE borrar_tablas_remito :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

  EMPTY TEMP-TABLE T-Rem_header.
  EMPTY TEMP-TABLE T-Rem_detalle.
  EMPTY TEMP-TABLE T-Registrable-remito.
  EMPTY TEMP-TABLE T-Rem_header-bon.
  EMPTY TEMP-TABLE T-Rem_detalle-bon.
  EMPTY TEMP-TABLE T-Remito-pedido.
  EMPTY TEMP-TABLE T-Sub_header_inv.
  EMPTY TEMP-TABLE T-Sub_detalle_inv.
  EMPTY TEMP-TABLE T-evento.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE borrar_tablas_temporales B-table-Win 
PROCEDURE borrar_tablas_temporales :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
  EMPTY TEMP-TABLE T-Rem_header.
  EMPTY TEMP-TABLE T-Rem_detalle.
  EMPTY TEMP-TABLE T-Registrable-remito.
  EMPTY TEMP-TABLE T-Rem_header-bon.
  EMPTY TEMP-TABLE T-Rem_detalle-bon.
  EMPTY TEMP-TABLE T-Remito-pedido.
  EMPTY TEMP-TABLE T-Sub_header_inv.
  EMPTY TEMP-TABLE T-Sub_detalle_inv.
  EMPTY TEMP-TABLE T-evento.
   EMPTY TEMP-TABLE T-Fac_header.
   EMPTY TEMP-TABLE T-Fac_detalle.
   EMPTY TEMP-TABLE T-Fac_header-bon.
   EMPTY TEMP-TABLE T-Fac_detalle-bon.
   EMPTY TEMP-TABLE T-Sub_detalle_vta.
   EMPTY TEMP-TABLE T-Sub_header_vta.
   EMPTY TEMP-TABLE T-Fac_header_impuesto.
   EMPTY TEMP-TABLE T-Fac_detalle_impuesto.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE calcular_valores B-table-Win 
PROCEDURE calcular_valores :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEFINE VARIABLE que_tasa LIKE Impuesto_condicion.tasa.

          /* --------------------------------------------------- */
          /*  El precio a CF es el precio + impuestos. SI no hay */
          /*  impuestos, el precio_cf quedará igual al precio    */
          /* --------------------------------------------------- */

RUN hallar_iva_detalle ( OUTPUT que_tasa ).


IF T-rem_detalle.cantidad = 0.0 THEN T-rem_detalle.cantidad = 1.0.
T-rem_detalle.precio = T-rem_detalle.precio_cf / ( 1 + que_tasa / 100).

T-rem_detalle.subtotal_neto = T-rem_detalle.precio * T-rem_detalle.cantidad.
T-rem_detalle.subtotal_neto_cf = T-rem_detalle.precio_cf * T-rem_detalle.cantidad.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE calculos B-table-Win 
PROCEDURE calculos :
/*------------------------------------------------------------------------------
  Purpose: Realiza el calculo del importe final de una factura     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

  RUN calcular_comprobante_cliente.p ( 
                           INPUT-OUTPUT TABLE T-Fac_header,
                           INPUT-OUTPUT TABLE T-Fac_detalle,
                           INPUT-OUTPUT TABLE T-Sub_header_vta,
                           INPUT-OUTPUT TABLE T-Sub_detalle_vta,
                           INPUT-OUTPUT TABLE T-Fac_header-bon,
                           INPUT-OUTPUT TABLE T-Fac_detalle-bon,
                           INPUT-OUTPUT TABLE T-Fac_header_impuesto,
                           INPUT-OUTPUT TABLE T-Fac_detalle_impuesto).
                         
  FIND FIRST T-Fac_header.

  {&OPEN-QUERY-{&BROWSE-NAME}}

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE cambia_templateprinc B-table-Win 
PROCEDURE cambia_templateprinc :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEFINE INPUT PARAMETER ppar LIKE tarea.cdg_tipotarea.
DEFINE VAR i AS INT NO-UNDO.
DEFINE VAR hproc AS HANDLE NO-UNDO.
DEFINE VAR hcproc AS CHAR NO-UNDO.
    RUN get-link-handle IN adm-broker-hdl
        ( INPUT THIS-PROCEDURE,
          INPUT "CONTAINER-source",
          OUTPUT hcproc ).
      /* Code placed here will execute PRIOR to standard behavior. */
    hproc = WIDGET-HANDLE(hcproc).
    IF VALID-HANDLE(hProc) THEN DO:
        RUN templateprinc IN hproc (ppar).
    END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE control_load B-table-Win  _CONTROL-LOAD
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

OCXFile = SEARCH( "b-tareas-red.wrx":U ).
IF OCXFile = ? THEN
  OCXFile = SEARCH(SUBSTRING(THIS-PROCEDURE:FILE-NAME, 1,
                     R-INDEX(THIS-PROCEDURE:FILE-NAME, ".":U), "CHARACTER":U) + "wrx":U).

IF OCXFile <> ? THEN
DO:
  ASSIGN
    chCtrlTimer = CtrlTimer:COM-HANDLE
    UIB_S = chCtrlTimer:LoadControls( OCXFile, "CtrlTimer":U)
    chProgressBar = ProgressBar:COM-HANDLE
    UIB_S = chProgressBar:LoadControls( OCXFile, "ProgressBar":U)
  .
  RUN DISPATCH IN THIS-PROCEDURE("initialize-controls":U) NO-ERROR.
END.
ELSE MESSAGE "b-tareas-red.wrx":U SKIP(1)
             "The binary control file could not be found. The controls cannot be loaded."
             VIEW-AS ALERT-BOX TITLE "Controls Not Loaded".

&ENDIF

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE crear_caja B-table-Win 
PROCEDURE crear_caja :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

   CREATE Caj_header.
   ASSIGN 
          Caj_header.fecha             = TODAY
          Caj_header.hora              = TIME
          Caj_header.nro_cliente       = T-Fac_header.nro_cliente
          Caj_header.cdg_empresa       = T-Fac_header.cdg_empresa
          Caj_header.tip_comprob       = T-Fac_header.tip_comprob
          Caj_header.nro_comprob       = T-Fac_header.nro_comprob
          Caj_header.ultima_linea      = 0
          Caj_header.nro_transaccion   = NEXT-VALUE(proxima_txncaja)
          Caj_header.importe           = T-Fac_header.imp_total
          Caj_header.emitir            = NO
          Caj_header.cdg_caja          = Caja.cdg_caja
          Caj_header.nro_cuenta        = Cuenta.nro_cuenta
          Caj_header.nro_cliente       = Cliente.nro_cliente
          Caj_header.observacion       = STRING(Cliente.cdg_cliente,"99999") + 
                                         "-" + Cliente.nom_cliente
          Caj_header.tipo_mov          = "I"
          T-Fac_header.nro_transaccion = Caj_header.nro_transaccion.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE crea_cobranza B-table-Win 
PROCEDURE crea_cobranza :
/*------------------------------------------------------------------------------
  Purpose:  Crea el evento de la cobranza   
  Parameters:  <none>
  Notes: el funcionamiento depende mucho de las restricciones
         puede estar asignada o no
------------------------------------------------------------------------------*/
DEFINE OUTPUT PARAMETER todook AS LOGICAL NO-UNDO.
DEFINE VAR precursos AS CHAR NO-UNDO.
DEFINE VAR pfasignado AS DATE NO-UNDO.
DEFINE VAR pfmin AS DATE NO-UNDO.
DEFINE VAR pfmax AS DATE NO-UNDO.
DEFINE VAR prest AS CHAR NO-UNDO.
DEFINE VAR pevsigue AS INT NO-UNDO.
DEFINE BUFFER bevento FOR evento.
DEFINE BUFFER btipo_evento FOR tipo_evento.
todook = FALSE.
FIND cliente OF tarea NO-LOCK.
precursos = "".
pfasignado = ?.
pfmin = ?.
pfmax = ?.
pevsigue = 0.

pfmin  = date( extrae("fmin" , tarea.dato) ).
pfmax  = date( extrae("fmax" , tarea.dato) ).
precursos  =  entry(1,extrae("frecursos" , tarea.dato)) .
FIND btipo_evento WHERE btipo_evento.cdg_tipo_evento = "CO" NO-LOCK.
FIND recurso WHERE recurso.cdg_recurso = precursos NO-LOCK NO-ERROR.
IF AVAILABLE recurso THEN DO:
    FIND recurso_habilidad OF recurso WHERE recurso_habilidad.nro_tipo_evento = btipo_evento.nro_tipo_evento NO-LOCK NO-ERROR.
END.
IF pfmin = pfmax AND  precursos <> ? AND precursos <> "" AND extrae("COPER",tarea.dato)<>"S" AND
            AVAILABLE recurso_habilidad  THEN pfasignado = pfmin.

/*creando el evento*/
 CREATE evento.
        ASSIGN evento.nro_evento = NEXT-VALUE(proximo_evento)
               evento.nro_tipo_evento = btipo_evento.nro_tipo_evento
               tarea.nro_tipo_evento = btipo_evento.nro_tipo_evento
               evento.fasignado = IF precursos <> "" THEN pfasignado ELSE ?
               evento.nro_identificacion = tarea.nro_tarea /*porque deviene de una tarea tiene numero de tarea sino tiene 0*/
               evento.origen = "COBRANZA"
               evento.nro_cliente = cliente.nro_cliente
               Evento.FCreado = TODAY
               evento.periodo = IF pfasignado <> ? THEN YEAR(pfasignado) * 100 + MONTH(pfasignado) ELSE YEAR(pfmin) * 100 + MONTH(pfmin)
               evento.fmin = pfmin
               evento.fmax = pfmax
               evento.recurso = precursos
               evento.observacion = tarea.descripcion.
               evento.leyenda = tarea.leyenda.
               evento.duracion = 15.
               /*evento.duracion = tarea_horas_estimadas.*/
               evento.hora_desde = ajuh(replace(tarea.hora_prevista,":","")).
               evento.hora_hasta = ajuh(replace(extrae("hora_fin" , tarea.dato),":","")).
               tarea.destino = "EVENTO".
               tarea.nro_destino = evento.nro_evento.
               evento.turno = IF int(aint(evento.hora_desde)) < 1230 THEN "M*" ELSE "T*".
               IF INT(aint(evento.hora_hasta)) > 1230 THEN 
                       evento.turno = IF evento.turno BEGINS "M" then "**" ELSE evento.turno.

          
           IF pfasignado <> ? THEN DO:
                CREATE recurso_agenda.
                ASSIGN recurso_agenda.cdg_recurso = precursos
                       recurso_agenda.Fecha = pfasignado
                       recurso_agenda.nro_evento = evento.nro_evento.
           END.
               
           MESSAGE "Se ha generado el evento " evento.nro_evento SKIP 
                   IF evento.evsigue <> 0 THEN "incorporando la cobranza al realizar el evento " + string( evento.evsigue ) ELSE "" 
                   IF pfasignado <> ? THEN "Se a asignado el mismo el " + STRING(pfasignado) + " para " + precursos ELSE ""  SKIP
                   VIEW-AS ALERT-BOX information.
/*apareo de eventos de entrega de documentacion ENVIO*/

RUN aparea_envio.
todook = TRUE.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE crea_entrega_libro B-table-Win 
PROCEDURE crea_entrega_libro :
/*------------------------------------------------------------------------------
  Purpose:  Crea el evento para la entrega de libro al cerrar tarea H
  Parameters:  <none>
  Notes: 
------------------------------------------------------------------------------*/
/*creando el evento*/
DEFINE OUTPUT PARAMETER explica AS CHAR NO-UNDO.
DEFINE OUTPUT PARAMETER todook AS LOGICAL NO-UNDO.
DEFINE VAR precursos AS CHAR.

todook = FALSE.
FIND tipo_evento WHERE tipo_evento.cdg_tipo_evento = "EL" NO-LOCK.
 precursos  =  entry(1,extrae("frecursos" , tarea.dato)) .
IF precursos = "" OR tarea.fecha_prevista = ? THEN DO:
   MESSAGE "Se cerrara la tarea creando un evento no asignado" SKIP
           "sino especifique fecha y recurso" VIEW-AS ALERT-BOX BUTTONS OK-CANCEL SET todook.
   IF NOT todook THEN RETURN ERROR.
END.
CREATE evento.
        ASSIGN evento.nro_evento = NEXT-VALUE(proximo_evento)
               evento.nro_tipo_evento = tipo_evento.nro_tipo_evento
               evento.fasignado = tarea.fecha_prevista
               evento.nro_identificacion = tarea.nro_tarea /*porque deviene de una tarea tiene numero de tarea sino tiene 0*/
               evento.origen = "TAREA"
               evento.nro_cliente = tarea.nro_cliente
               Evento.FCreado = TODAY
               evento.periodo = YEAR(today) * 100 + MONTH(today)
               evento.fmin = TODAY
               evento.fmax = TODAY + 20 /*fijo cualquier cosa se vera*/
               evento.recurso = precursos
               evento.observacion = tarea.descripcion.
               evento.duracion = 15.
               evento.leyenda = tarea.leyenda.
               tarea.destino = "EVENTO".
               tarea.nro_destino = evento.nro_evento.
               evento.turno = "**".
               explica ="EventoEL:" + string(evento.nro_evento). 
                IF precursos <> ? AND evento.fasignado <> ? THEN DO:
                    CREATE recurso_agenda.
                    ASSIGN recurso_agenda.cdg_recurso = precursos
                           recurso_agenda.Fecha = evento.fasignado
                           recurso_agenda.nro_evento = evento.nro_evento.
                END.
todook = TRUE.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE crea_facturaD B-table-Win 
PROCEDURE crea_facturaD :
/*------------------------------------------------------------------------------
  Purpose:  Resuelve remito y factura de destapacion de destapacion hasta la impresion de los certificador o lo que sea.   
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEFINE OUTPUT PARAMETER todook AS LOGICAL NO-UNDO.
DEFINE VAR oldnf AS CHAR NO-UNDO.
DEFINE VAR opt AS LOGICAL INITIAL FALSE.
DEFINE VAR v-valor_c AS CHAR NO-UNDO.
DEFINE VAR v-valor_n AS INT NO-UNDO.
DEFINE VAR k AS INT NO-UNDO.
DEFINE VAR v-calle AS CHAR NO-UNDO.
DEFINE VAR v-altura AS CHAR NO-UNDO.
DEFINE VAR v-refer AS CHAR NO-UNDO.
DEFINE VAR v-extra AS CHAR NO-UNDO.
DEFINE VAR rok AS INTEGER NO-UNDO.
DEFINE VAR carfac AS CHARACTER FORMAT "X(40)" NO-UNDO.
DEFINE BUFFER bbtarea FOR tarea.
DEFINE VAR facadm LIKE cliente.nro_cliente NO-UNDO.
DEFINE VAR afmaxv AS DECIMAL DECIMALS 2 NO-UNDO.
DEFINE VAR nro_tipo_evento_DTS LIKE evento.nro_tipo_evento NO-UNDO.
{findempresa.i}
todook = FALSE.
IF NOT AVAILABLE tarea THEN RETURN ERROR.

FIND tipo_evento WHERE tipo_evento.cdg_tipo_evento = "DTS" NO-LOCK.
nro_tipo_evento_DTS = tipo_evento.nro_tipo_evento.

RUN borrar_tablas_temporales.
RUN getparametro_d.p( "AFMAXV", OUTPUT afmaxv).
    DO:
    
    RUN getparametro_c.p (  INPUT  "DFMONEDA",
                  OUTPUT v-valor_c ).
    FIND Moneda WHERE Moneda.cdg_moneda = v-valor_c NO-LOCK.
    
    RUN getparametro_n.p (  INPUT  "DFDEPOSI", OUTPUT v-valor_n ).
    FIND Deposito WHERE Deposito.nro_deposito = v-valor_n 
                NO-LOCK.
    FIND cliente OF tarea NO-LOCK NO-ERROR.
    IF NOT AVAILABLE cliente THEN DO:
        IF tarea.geolat = 0 THEN DO:
            MESSAGE "La direccion no esta georeferenciada" VIEW-AS ALERT-BOX ERROR.
            UNDO,LEAVE.
        END.

        RUN decodir(tarea.direccion, OUTPUT v-calle,OUTPUT v-altura,OUTPUT v-refer,OUTPUT v-extra).
        
        CREATE cliente.
        ASSIGN Cliente.nro_cliente = NEXT-VALUE(proximo_cliente)
               tarea.nro_cliente = cliente.nro_cliente
               Cliente.fecha_alta  = tarea.fecha_prevista
               Cliente.hora_alta   = TIME.
        ASSIGN Cliente.fecha_grab = TODAY
               Cliente.hora_grab = TIME
               cliente.geolat = tarea.geolat
               cliente.geolong = tarea.geolong.
        cliente.geoX = X(tarea.geolat,tarea.geolong).
        cliente.geoY = Y(tarea.geolat,tarea.geolong).
        cliente.direccion = trim( v-calle + " " + v-altura + " " + v-refer ).
        cliente.nom_cliente = "CP. " + cliente.direccion.
        cliente.cdg_cliente = "C" + STRING(Cliente.nro_cliente,"99999").
        Cliente.lista_empresas = Empresa.cdg_empresa.
        Cliente.lista_sectores = Empresa.cdg_empresa.
        cliente.ult_domicilio = 1.  
        FIND Entidad WHERE Entidad.cdg_entidad = Empresa.cdg_empresa NO-LOCK.
        Cliente.nro_entidad = Entidad.nro_entidad.
        
        FIND FIRST Lista_precios NO-LOCK.
        Cliente.dfl_lista = Lista_precios.cdg_lista.
        
        FIND FIRST Vendedor NO-LOCK.
        Cliente.nro_vendedor = Vendedor.nro_vendedor.
        
        FIND FIRST Cobrador NO-LOCK.
        Cliente.nro_cobrador = Cobrador.nro_cobrador.
        
        FIND FIRST Grupo-empresario NO-LOCK.
        Cliente.cdg_grupoemp = Grupo-empresario.cdg_grupoemp.
    /*lo que viene a continuacion es ASQUEROSO perdon si alguien ve esto*/
    /*dynasys no tiene defaults para las tablas maestras*/
    /*pero igual es nauseabundo */
        Cliente.cdg_condiva = 2.
        Cliente.cdg_estado = "A".
        Cliente.cdg_pais = 1.
        Cliente.dfl_cdg_puntovta = 0.
        Cliente.cdg_tipoclie = "2".
        cliente.localidad = "Capital Federal".
        Cliente.cdg_provincia = "01".
        Cliente.dfl_cndventa = "00".
        Cliente.dfl_lista = 1. 
        cliente.cdg_famclie = "1".
    /*fin asquerosidad*/

        CREATE domicilio.

        ASSIGN  
            Domicilio.nro_domicilio = 1
            Domicilio.nro_cliente = cliente.nro_cliente
            Domicilio.nombre = "Domicilio"
            Domicilio.factura = TRUE
            Domicilio.retira = FALSE
            Domicilio.es_fiscal = TRUE
            Domicilio.cdg_pais = 1
            Domicilio.telefono = cliente.telefonos
            Domicilio.localidad = cliente.localidad
            Domicilio.direccion = cliente.direccion 
            Domicilio.cdg_provincia = cliente.cdg_provincia
            Domicilio.cdg_postal = REPLACE(cliente.cdg_postal,"-","").
    

        CREATE Hst_Cliente.
        BUFFER-COPY Cliente TO Hst_cliente.
        RUN completar_auditoria.p ( OUTPUT Hst_Cliente.user_cambio,
                OUTPUT Hst_cliente.fecha_cambio,
                OUTPUT Hst_cliente.hor_cambio,
                OUTPUT Hst_cliente.pc_cambio).
        ASSIGN Hst_cliente.hms_cambio = STRING(Hst_cliente.hor_cambio,"HH:MM:SS").
    
    
        FIND administrador WHERE administrador.nro_cliente = cliente.nro_admin NO-LOCK NO-ERROR.
        IF NOT AVAILABLE administrador THEN
            cliente.nro_admin = cliente.nro_cliente.
        ELSE
            cliente.nro_admin = administrador.nro_cliente.
    END.

    RUN decodir(tarea.direccion, OUTPUT v-calle,OUTPUT v-altura,OUTPUT v-refer,OUTPUT v-extra).
    FIND administrador WHERE administrador.nro_cliente = cliente.nro_admin NO-LOCK.  
    IF LOGICAL(extrae( "propietario", Tarea.datos-template ))  THEN
            facadm = cliente.nro_cliente.
    ELSE 
        facadm = administrador.nro_cliente.
    /*creacion del remito*/
    CREATE t-rem_header.
    /*Ver el canal*/

    FIND punto-venta WHERE punto-venta.cdg_puntovta = int(extrae( "prf", Tarea.datos-template )) NO-LOCK NO-ERROR.
    IF NOT AVAILABLE punto-venta THEN DO:
        MESSAGE "El canal propuesto no existe, verifique" VIEW-AS ALERT-BOX ERROR.
        UNDO,LEAVE.
    END.
    IF NOT punto-venta.habilitado  THEN DO:
        MESSAGE "EL punto de venta no esta habilitado" VIEW-AS ALERT-BOX ERROR.
        UNDO,LEAVE.
    END.
    T-Rem_header.prf_comprob = punto-venta.cdg_puntovta.
    t-rem_header.cdg_comprob = IF punto-venta.impresor = "M" OR punto-venta.impresor = "A" THEN "REMITCLM" ELSE "REMITCLI".
    FIND tipocomprobante 
        WHERE tipocomprobante.cdg_empresa = empresa.cdg_empresa AND
              tipocomprobante.cdg_comprob  = t-rem_header.cdg_comprob NO-LOCK.
    t-rem_header.tip_comprob = tipocomprobante.tip_comprob.


    find FIRST Comprobante_concepto OF Tipocomprobante 
              WHERE Comprobante_concepto.cdg_empresa = Empresa.cdg_empresa NO-LOCK.
    FIND Imputacion OF Comprobante_concepto NO-LOCK.
    {DEBUG.i}
    FIND FIRST Tipo_puntovta 
            WHERE Tipo_puntovta.cdg_comprobante = tipocomprobante.cdg_comprobante
              AND Tipo_puntovta.cdg_empresa = Empresa.cdg_empresa
              AND Tipo_puntovta.cdg_puntovta = t-rem_header.prf_comprob
                  NO-LOCK NO-ERROR.
        IF NOT AVAILABLE Tipo_puntovta
        THEN DO:
            MESSAGE "NO SE ENCUENTRA EL PRIMER CENTRO EMISOR HABILITADO PARA ESTE COMPROBANTE O BIEN NO SE ENCUENTRA EL PREFERIDO"
                    VIEW-AS ALERT-BOX ERROR TITLE "ERROR DE IMPLEMENTACION- NO PROSIGA!!!!".
            UNDO,LEAVE.
        END.
FIND condicion_venta WHERE condicion_venta.cdg_cndventa = cliente.dfl_cndventa NO-ERROR.
    BUFFER-COPY cliente TO t-rem_header.
    ASSIGN T-Rem_header.cdg_comprobante = Tipocomprobante.cdg_comprobante
           T-Rem_header.nro_usuario    = Usuario.nro_usuario 
           T-Rem_header.cdg_empresa    = Empresa.cdg_empresa
           T-Rem_header.fecha          = TODAY 
           T-Rem_header.fecha_iva      = TODAY 
           T-Rem_header.mes            = MONTH(T-Rem_header.fecha) 
           T-Rem_header.ano            = YEAR(T-Rem_header.fecha)
           T-Rem_header.nro_deposito   = Deposito.nro_deposito 
           T-Rem_header.tip_comprob    = "" 
           T-Rem_header.estado         = "E"
           T-Rem_header.nro_comprob    = T-Rem_header.nro_remito
           T-Rem_header.nro_moneda     = Moneda.nro_moneda 
           T-Rem_header.cambio         = Moneda.cambio  
           T-Rem_header.cdg_imputacion = Imputacion.cdg_imputacion 
           T-Rem_header.cta_cte        = Imputacion.cta_cte
           t-rem_header.nro_domicilio  = 1
           t-rem_header.nro_cndventa   = condicion_venta.nro_cndventa
           T-Rem_header.origen         = "M".
    t-rem_header.sin_cargo = logical(extrae("sin_cargo",Tarea.datos-template)).
    T-Rem_header.leyenda_cc = "".
    t-rem_header.nro_cliente = cliente.nro_cliente.
    t-rem_header.codigo_cliente = cliente.cdg_cliente.
    t-rem_header.nombre = cliente.nom_cliente.
    t-rem_header.direccion = trim(trim( v-calle + " " + v-altura + " " + v-refer ) + " " + v-extra).
    t-rem_header.direccion_leg = cliente.direccion.
    t-rem_header.cdg_postal = cliente.cdg_postal.
    t-rem_header.localidad = cliente.localidad.
    t-rem_header.cdg_provincia = cliente.cdg_provincia.
    t-rem_header.cdg_postal_leg = cliente.cdg_postal.
    t-rem_header.localidad_leg = cliente.localidad.
    t-rem_header.cdg_provincia_leg = cliente.cdg_provincia.
    T-Rem_header.ultima_linea     = 1.
    T-Rem_header.nro_admin = facadm.

    CREATE t-rem_detalle.

    FIND FIRST articulo WHERE articulo.nro_tipo_evento = tarea.nro_tipo_evento NO-LOCK NO-ERROR.
    IF NOT AVAILABLE articulo THEN DO:
        MESSAGE "Articulo no registrado para el tipo de evento de la tarea o es mas de uno" VIEW-AS ALERT-BOX ERROR.
        UNDO,LEAVE.
    END.
    IF articulo.nro_tipo_evento <> tarea.nro_tipo_evento THEN DO:
        MESSAGE "El articulo no es valido para el tipo de evento de la tarea" VIEW-AS ALERT-BOX ERROR.
        UNDO,LEAVE.
    END.
    
    IF Articulo.cdg_estado <> ""
       THEN DO:
          RUN PONMENSJ.P (INPUT "FACT032").
          undo,leave.
    END.

    FIND Familia_articulo OF Articulo NO-LOCK.
    FIND FIRST Familia_cuenta 
       WHERE Familia_cuenta.cdg_imputacion = T-Rem_header.cdg_imputacion
         AND Familia_cuenta.nro_familia    = Familia_articulo.nro_familia
         AND Familia_cuenta.cdg_empresa    = T-Rem_header.cdg_empresa
             NO-LOCK NO-ERROR.
   
    IF NOT AVAILABLE Familia_cuenta
    THEN DO:
      RUN PONMENSJ.P (INPUT "FAPR061").
      UNDO,LEAVE.
    END.

    ASSIGN
           t-rem_detalle.nro_articulo = articulo.nro_articulo
           /*t-rem_detalle.detallada = articulo.detallada*/
           t-rem_detalle.cantidad = 1
           t-rem_detalle.nro_linea = 1
           t-rem_detalle.costo = 0.
           t-rem_detalle.precio_cf = decimal(extrae("imp_servicio", Tarea.datos-template )).
           T-Rem_detalle.nro_remito      = T-Rem_header.nro_remito.
     /*descripcion detallada segun combos y anexos*/
           
    FIND tipo-precio WHERE tipo-precio.ind = int(extrae("ind1",Tarea.datos-template  )) AND
                           tipo-precio.tabla = 1 NO-LOCK NO-ERROR.
    IF AVAILABLE tipo-precio THEN
        IF tipo-precio.ind <> 0 THEN
            T-Rem_detalle.detallada = "Destapacion de " + tipo-precio.descripcion.
    
    FIND tipo-precio WHERE tipo-precio.ind = int(extrae("ind2",Tarea.datos-template )) AND
                            tipo-precio.tabla = 2 NO-LOCK NO-ERROR.
    IF AVAILABLE tipo-precio THEN
        IF tipo-precio.ind <> 0 THEN
            T-Rem_detalle.detallada = T-Rem_detalle.detallada + " desde " + tipo-precio.descripcion.

    FIND tipo-precio WHERE tipo-precio.ind = int(extrae("ind3",Tarea.datos-template )) AND
                           tipo-precio.tabla = 3 NO-LOCK NO-ERROR.
    IF AVAILABLE tipo-precio THEN
        IF tipo-precio.ind <> 0 THEN
            T-Rem_detalle.detallada = T-Rem_detalle.detallada + " a " + tipo-precio.descripcion.

    FIND tipo-precio WHERE tipo-precio.ind = int(extrae("ind4",Tarea.datos-template )) AND
                           tipo-precio.tabla = 4 NO-LOCK NO-ERROR.
        IF AVAILABLE tipo-precio THEN
             IF tipo-precio.ind <> 0 THEN
                 T-Rem_detalle.detallada = T-Rem_detalle.detallada + "" + tipo-precio.descripcion.
    T-Rem_detalle.detallada = IF T-Rem_detalle.detallada <> "" THEN T-Rem_detalle.detallada + chr(13) + extrae("texto_adic",Tarea.datos-template  )
        ELSE extrae("texto_adic",Tarea.datos-template ).

    RUN calcular_valores.
    EMPTY TEMP-TABLE T-Sub_header_inv NO-ERROR. 
    EMPTY TEMP-TABLE T-Sub_detalle_inv NO-ERROR.       
    
    { calcularemito.i "T-"}

    RUN valuar_remito.p ( 
            INPUT-OUTPUT  TABLE  T-Rem_header,
            INPUT-OUTPUT  TABLE  T-Rem_detalle,
            INPUT-OUTPUT  TABLE  T-Sub_header_vta,
            INPUT-OUTPUT  TABLE  T-Sub_detalle_vta,
            INPUT-OUTPUT  TABLE  T-Rem_header-bon,
            INPUT-OUTPUT  TABLE  T-Rem_detalle-bon,
            INPUT-OUTPUT  TABLE  T-Rem_header_impuesto,
            INPUT-OUTPUT  TABLE  T-Rem_detalle_impuesto ).

    FIND FIRST t-rem_header.
    IF punto-venta.impresor <> "M" AND T-rem_header.imp_total > afmaxv and
        t-rem_header.CUIT = "" AND t-Rem_header.Cod_docu <> "CUIT"  THEN DO:
        MESSAGE "Se ha superado el maximo permitido de" afmaxv "debe indicar CUIT para el cliente" 
        VIEW-AS ALERT-BOX ERROR.
        RETURN ERROR.
    END.
    IF NOT logical(extrae( "Factura",Tarea.datos-template )) THEN t-rem_header.estado = "-".    

    RUN emitir_compdespacho.p (  INPUT-OUTPUT TABLE T-Rem_header,
                                    INPUT TABLE T-Rem_detalle,
                                    INPUT TABLE T-Registrable-remito, 
                                    INPUT TABLE T-Rem_header-bon,
                                    INPUT TABLE T-Rem_detalle-bon,
                                    INPUT TABLE T-Remito-pedido,
                                    INPUT TABLE T-Sub_header_inv,
                                    INPUT TABLE T-Sub_detalle_inv
                                   ). 
    FIND FIRST t-rem_header.
    FIND rem_detalle WHERE rem_detalle.nro_remito = t-rem_header.nro_remito AND
                                  rem_detalle.nro_linea = 1.
    FIND articulo OF rem_detalle NO-LOCK.
    tarea.nro_destino = t-rem_header.nro_remito.
    tarea.destino = T-Rem_header.cdg_comprobante.
       /*si dispara un evento evaluar*/
       /*crear el evento correspondiente*/
    CREATE evento.
    ASSIGN evento.nro_evento = NEXT-VALUE(proximo_evento)
           evento.nro_tipo_evento = articulo.nro_tipo_evento
           evento.fasignado = tarea.fecha_prevista
           evento.frealizado = tarea.fecha_prevista
           evento.nro_identificacion = t-rem_header.nro_remito
           evento.origen = t-rem_header.cdg_comprobante
           evento.nro_cliente = cliente.nro_cliente
           Evento.FCreado = TODAY
           evento.periodo = YEAR(TODAY) * 100 + MONTH(TODAY)
           evento.fmin = tarea.fecha_prevista
           evento.fmax = tarea.fecha_prevista.
           evento.hora_hasta = ajuh(extrae("hora_fin",Tarea.datos-template)).
           evento.duracion = tarea.horas_estimadas.
           evento.recurso = extrae("frecursos",Tarea.datos-template).
           evento.observacion = tarea.descripcion.
           evento.leyenda = tarea.leyenda.
           evento.hora_desde = ajuh(tarea.hora_prevista).
           tarea.nro_evento = evento.nro_evento.
           DO k = 1 TO NUM-ENTRIES(evento.recursos):
           CREATE recurso_agenda.
           ASSIGN recurso_agenda.cdg_recurso = ENTRY(k,evento.recursos)
                     recurso_agenda.fecha = Evento.FAsignado
                     recurso_agenda.nro_evento = Evento.nro_evento.
           END.
           
           ASSIGN rem_detalle.nro_evento = evento.nro_evento.
    END.

    FIND FIRST t-rem_header NO-ERROR.
    IF NOT AVAILABLE t-rem_header THEN do:
        MESSAGE "ERROR interno al intentar generar el remito para evento:" evento.nro_evento skip
           "No se podra proseguir!!!!!" VIEW-AS ALERT-BOX error.
        RETURN ERROR.
    END.

    carfac = "".
    IF NOT t-rem_header.sin_cargo THEN DO:
        RUN crea_facturadeRemito( t-rem_header.nro_remito , OUTPUT todook).
        IF NOT todook THEN RETURN ERROR.
        FIND FIRST t-rem_header. 
        FIND FIRST t-fac_header.
        FIND fac_header WHERE fac_header.nro_factura = t-fac_header.nro_factura.
        carfac = "Factura " + fac_header.tip_comprob + "-" + string( fac_header.prf_comprob , "9999" ) + "-" + string( fac_header.nro_comprob,"99999999" ).            
    END.
    
    MESSAGE "Se ha generado" skip
            "Evento " evento.nro_evento SKIP
            "Remito " t-rem_header.tip_comprob + "-" + string( t-rem_header.prf_comprob,"9999") + "-" + STRING( t-rem_header.nro_comprob,"99999999") SKIP
            carfac
             SKIP
            "asientelo en la orden de trabajo" VIEW-AS ALERT-BOX information.
    RUN borrar_tablas_temporales.
    RELEASE rem_header.
    RELEASE fac_header.
    
    /*impresion*/
    /*De aca en mas el evento se realizo*/
    FOR EACH recurso_agenda  WHERE recurso_agenda .nro_evento = evento.nro_evento:
                recurso_agenda.fecha = evento.frealizado.
    END.
    FIND rem_header WHERE rem_header.nro_remito = evento.nro_identificacion.
    if sic.Rem_header.cdg_formapago <> 0 AND NOT rem_header.sin_cargo THEN DO:
            RUN crea_tarea.p( evento.nro_evento,evento.nro_cliente, "C" , "Cobranza Remito" + rem_header.tip_comprob + "-" + STRING(rem_header.prf_comprob) + "-" + string(rem_header.nro_comprob),"Cobranza Remito" + rem_header.tip_comprob + "-" + STRING(rem_header.prf_comprob) + "-" + string(rem_header.nro_comprob),TODAY,"*",OUTPUT rok).
            IF rok = ? THEN DO:
                MESSAGE "No se puede crear tarea por error en usuario/recurso".
                RETURN ERROR.
            END.
            ELSE DO: 
                FIND bbtarea WHERE bbtarea.nro_tarea = rok EXCLUSIVE-LOCK.
                FIND recurso WHERE recurso.cdg_recurso = ENTRY(1,evento.recurso) NO-LOCK.
                bbtarea.reportado_por = Recurso.nom_recurso.
                MESSAGE "Se ha creado la tarea para la cobranza" rok VIEW-AS ALERT-BOX INFORMATION.
            END.
                
    END.
    
    RUN imprecibo.
    todook = TRUE.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE crea_facturadeRemito B-table-Win 
PROCEDURE crea_facturadeRemito :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/*generacion de la factura en funcion al remito creado*/

DEFINE INPUT PARAMETER rr LIKE rem_header.nro_remito NO-UNDO.
DEFINE OUTPUT PARAMETER todook AS LOGICAL NO-UNDO.
todook = FALSE.
FIND Rem_header WHERE Rem_header.nro_remito = rr.
IF AVAILABLE Rem_header THEN DO:
      IF Rem_header.estado = "E" OR Rem_header.estado = "-" THEN DO:
            FIND FIRST Relacion_comprobante 
                 WHERE Relacion_comprobante.cdg_comproborigen = Rem_header.cdg_comprobante
                   AND Relacion_comprobante.cdg_empresa       = Rem_header.cdg_empresa
                       NO-LOCK NO-ERROR.
                IF NOT AVAILABLE relacion_comprobante THEN DO:
                     MESSAGE "No se encuentra el comprobante de destino para el origen " Tipocomprobante.cdg_comprobante
                             "Empresa" T-Fac_header.cdg_empresa 
                         VIEW-AS ALERT-BOX ERROR TITLE "ERROR DE IMPLEMENTACION:FACTURAR_REMITOS.P".
                END.
    
                FIND tipocomprobante WHERE tipocomprobante.cdg_comprobante = Relacion_comprobante.cdg_comprobdestino NO-LOCK.
                FIND FIRST Comprobante_concepto OF tipocomprobante NO-LOCK.
      
                CREATE T-Fac_header.
                ASSIGN T-Fac_header.cdg_comprobante   = Tipocomprobante.cdg_comprobante 
                         T-Fac_header.nro_usuario     = Usuario.nro_usuario 
                         T-Fac_header.cdg_empresa     = Empresa.cdg_empresa
                         T-Fac_header.fecha           = IF Punto-venta.modo_fecha = "T" THEN Punto-venta.fch_cierre + 1 ELSE TODAY
                         T-Fac_header.fecha_iva       = T-Fac_header.fecha 
                         T-Fac_header.fecha_precios   = T-Fac_header.fecha 
                         T-Fac_header.mes             = MONTH(T-Fac_header.fecha) 
                         T-Fac_header.ano             = YEAR(T-Fac_header.fecha)
                         T-Fac_header.cdg_empresa     = Empresa.cdg_empresa 
                         T-Fac_header.nro_deposito    = Deposito.nro_deposito 
                         T-Fac_header.tip_comprob     = ""                  
                         T-Fac_header.nro_factura     = 0  
                         T-Fac_header.estado          = "E"  
                         T-Fac_header.nro_comprob     = T-Fac_header.nro_factura
                         T-Fac_header.prf_comprob     = t-rem_header.prf_comprob
                         T-Fac_header.nro_moneda      = Moneda.nro_moneda 
                         T-Fac_header.cambio          = Moneda.cambio  
                         T-Fac_header.cdg_imputacion  = comprobante_concepto.cdg_imputacion
                         T-Fac_header.cta_cte         = YES /*Imputacion.cta_cte */
                         T-Fac_header.num_sucursal    = rem_header.num_sucursal   
                         T-Fac_header.origen          = "M"
                         T-Fac_header.nro_admin       = rem_header.nro_admin
                         T-Fac_header.leyenda         = rem_header.leyenda. 
                
                RUN copiar_comprobante_despacho.p ( 
                    INPUT ROWID(Rem_header),
                    INPUT-OUTPUT TABLE T-Fac_header,
                    INPUT-OUTPUT TABLE T-Fac_detalle,
                    INPUT-OUTPUT TABLE T-Registrable-factura,
                    INPUT-OUTPUT TABLE T-Fac_header-bon,
                    INPUT-OUTPUT TABLE T-Fac_detalle-bon,
                    INPUT-OUTPUT TABLE T-Fac_header_impuesto,
                    INPUT-OUTPUT TABLE T-Fac_detalle_impuesto).
                FIND FIRST T-Fac_header.
                RUN traer_tablas.
                RUN calculos.  
        END.
        ELSE DO:
             RUN ponmensj.p ( "REMI025" ).
             RETURN NO-APPLY.
        END.
END.
        
/*listo a generar la factura*/
    IF NOT T-Fac_header.cta_cte
            THEN DO:
                IF NOT AVAILABLE Caj_header
                THEN DO:
                     RUN crear_caja.
                END.
                ELSE DO:
                     RUN asignar_caja.
                END.  
    END.
    /*grabar datos*/
    T-Fac_header.prf_comprob = rem_header.prf_comprob.
    FIND administrador WHERE administrador.nro_cliente = rem_header.nro_admin NO-LOCK.
    t-fac_header.nro_administrador =       administrador.nro_cliente.
    t-fac_header.cdg_administrador =       administrador.cdg_cliente.
    t-Fac_header.direccion_administrador = administrador.direccion.
    t-Fac_header.nom_Administrador =       administrador.nom_cliente.
    t-fac_header.mostrar_admin =           administrador.mostrar_admin.


RUN emitir_comprobante_cliente.p ( 
                             INPUT-OUTPUT TABLE T-Fac_header,
                             INPUT-OUTPUT TABLE T-Fac_detalle,
                             INPUT-OUTPUT TABLE T-Registrable-factura,
                             INPUT-OUTPUT TABLE T-Sub_header_vta,
                             INPUT-OUTPUT TABLE T-Sub_detalle_vta,
                             INPUT-OUTPUT TABLE T-Fac_header-bon,
                             INPUT-OUTPUT TABLE T-Fac_detalle-bon,
                             INPUT-OUTPUT TABLE T-Fac_header_impuesto,
                             INPUT-OUTPUT TABLE T-Fac_detalle_impuesto).  
FIND FIRST t-fac_header.
rem_header.nro_factura = t-fac_header.nro_factura.
rem_header.estado = "P".
todook = TRUE.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE crea_manual B-table-Win 
PROCEDURE crea_manual :
/*------------------------------------------------------------------------------
  Purpose:     Creacion de un evento tipo manual para un repaso o arreglo.
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEFINE OUTPUT PARAMETER todook AS LOGICAL NO-UNDO.
DEFINE VAR v-calle AS CHAR NO-UNDO.
DEFINE VAR v-altura AS CHAR NO-UNDO.
DEFINE VAR v-refer AS CHAR NO-UNDO.
DEFINE VAR v-extra AS CHAR NO-UNDO.

DEFINE VAR k AS INT NO-UNDO.
todook = FALSE.
{findempresa.i}

IF NOT AVAILABLE tarea THEN RETURN ERROR.
   FIND cliente OF tarea NO-LOCK NO-ERROR.
    IF NOT AVAILABLE cliente THEN DO:
        IF tarea.geolat = 0 THEN DO:
            MESSAGE "La direccion no esta georeferenciada" VIEW-AS ALERT-BOX ERROR.
            UNDO,LEAVE.
        END.

        RUN decodir(tarea.direccion, OUTPUT v-calle,OUTPUT v-altura,OUTPUT v-refer,OUTPUT v-extra).
        
        CREATE cliente.
        ASSIGN Cliente.nro_cliente = NEXT-VALUE(proximo_cliente)
               tarea.nro_cliente = cliente.nro_cliente
               Cliente.fecha_alta  = TODAY
               Cliente.hora_alta   = TIME.
        ASSIGN Cliente.fecha_grab = TODAY
               Cliente.hora_grab = TIME
               cliente.geolat = tarea.geolat
               cliente.geolong = tarea.geolong.
        cliente.geoX = X(tarea.geolat,tarea.geolong).
        cliente.geoY = Y(tarea.geolat,tarea.geolong).
        cliente.direccion = trim( v-calle + " " + v-altura + " " + v-refer ).
        cliente.nom_cliente = "CP. " + cliente.direccion.
        cliente.cdg_cliente = "C" + STRING(Cliente.nro_cliente,"99999").
        Cliente.lista_empresas = Empresa.cdg_empresa.
        Cliente.lista_sectores = Empresa.cdg_empresa.
        cliente.ult_domicilio = 1.  
        FIND Entidad WHERE Entidad.cdg_entidad = Empresa.cdg_empresa NO-LOCK.
        Cliente.nro_entidad = Entidad.nro_entidad.
        
        FIND FIRST Lista_precios NO-LOCK.
        Cliente.dfl_lista = Lista_precios.cdg_lista.
        
        FIND FIRST Vendedor NO-LOCK.
        Cliente.nro_vendedor = Vendedor.nro_vendedor.
        
        FIND FIRST Cobrador NO-LOCK.
        Cliente.nro_cobrador = Cobrador.nro_cobrador.
        
        FIND FIRST Grupo-empresario NO-LOCK.
        Cliente.cdg_grupoemp = Grupo-empresario.cdg_grupoemp.
    /*lo que viene a continuacion es ASQUEROSO perdon si alguien ve esto*/
    /*dynasys no tiene defaults para las tablas maestras*/
    /*pero igual es nauseabundo */
        Cliente.cdg_condiva = 2.
        Cliente.cdg_estado = "A".
        Cliente.cdg_pais = 1.
        Cliente.dfl_cdg_puntovta = 0.
        Cliente.cdg_tipoclie = "2".
        cliente.localidad = "Capital Federal".
        Cliente.cdg_provincia = "01".
        Cliente.dfl_cndventa = "00".
        Cliente.dfl_lista = 1. 
        cliente.cdg_famclie = "1".
    /*fin asquerosidad*/

        CREATE domicilio.

        ASSIGN  
            Domicilio.nro_domicilio = 1
            Domicilio.nro_cliente = cliente.nro_cliente
            Domicilio.nombre = "Domicilio"
            Domicilio.factura = TRUE
            Domicilio.retira = FALSE
            Domicilio.es_fiscal = TRUE
            Domicilio.cdg_pais = 1
            Domicilio.telefono = cliente.telefonos
            Domicilio.localidad = cliente.localidad
            Domicilio.direccion = cliente.direccion 
            Domicilio.cdg_provincia = cliente.cdg_provincia
            Domicilio.cdg_postal = REPLACE(cliente.cdg_postal,"-","").
    

        CREATE Hst_Cliente.
        BUFFER-COPY Cliente TO Hst_cliente.
        RUN completar_auditoria.p ( OUTPUT Hst_Cliente.user_cambio,
                OUTPUT Hst_cliente.fecha_cambio,
                OUTPUT Hst_cliente.hor_cambio,
                OUTPUT Hst_cliente.pc_cambio).
        ASSIGN Hst_cliente.hms_cambio = STRING(Hst_cliente.hor_cambio,"HH:MM:SS").
    
    
        FIND administrador WHERE administrador.nro_cliente = cliente.nro_admin NO-LOCK NO-ERROR.
        IF NOT AVAILABLE administrador OR logical(extrae( "propietario", Tarea.datos-template )) THEN
            cliente.nro_admin = cliente.nro_cliente.
        ELSE
            cliente.nro_admin = administrador.nro_cliente.
    END.

    RUN decodir(tarea.direccion, OUTPUT v-calle,OUTPUT v-altura,OUTPUT v-refer,OUTPUT v-extra).
    
    FIND administrador WHERE administrador.nro_cliente = cliente.nro_admin NO-LOCK.  
    CREATE evento.
    ASSIGN evento.nro_evento = NEXT-VALUE(proximo_evento)
           evento.nro_tipo_evento = tarea.nro_tipo_evento
           evento.fasignado = tarea.fecha_prevista
           evento.nro_identificacion = tarea.nro_tarea
           evento.origen = "MANUAL"
           evento.nro_cliente = cliente.nro_cliente
           Evento.FCreado = TODAY
           evento.periodo = YEAR(TODAY) * 100 + MONTH(TODAY)
           evento.fmin = tarea.fecha_prevista
           evento.fmax = tarea.fecha_prevista.
           evento.hora_hasta = ajuh(extrae("hora_fin",Tarea.datos-template)).
           evento.duracion = tarea.horas_estimadas.
           evento.recurso = extrae("frecursos",Tarea.datos-template).
           evento.observacion = tarea.descripcion.
           evento.leyenda = tarea.leyenda + "INFO:" + v-extra.
           evento.hora_desde = ajuh(tarea.hora_prevista).
           evento.turno = extrae("turno",Tarea.datos-template).
           DO k = 1 TO NUM-ENTRIES(evento.recursos):
           CREATE recurso_agenda.
           ASSIGN recurso_agenda.cdg_recurso = ENTRY(k,evento.recursos)
                     recurso_agenda.fecha = Evento.FAsignado
                     recurso_agenda.nro_evento = Evento.nro_evento.
           
           IF LOGICAL(extrae("avisar",Tarea.datos-template)) THEN
                RUN crea_aviso_evento.p(rowid(evento)).
           END.
         
           tarea.nro_evento = evento.nro_evento.
           tarea.nro_destino = evento.nro_evento.
           tarea.destino = "EVENTO".
           todook = TRUE.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE crea_remitoD B-table-Win 
PROCEDURE crea_remitoD :
/*------------------------------------------------------------------------------
  Purpose:  Resulve remito de destapacion hasta la impresion de los certificador o lo que sea.   
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEFINE OUTPUT PARAMETER todook AS LOGICAL NO-UNDO.
DEFINE VAR oldnf AS CHAR NO-UNDO.
DEFINE VAR opt AS LOGICAL INITIAL FALSE.
DEFINE VAR v-valor_c AS CHAR NO-UNDO.
DEFINE VAR v-valor_n AS INT NO-UNDO.
DEFINE VAR k AS INT NO-UNDO.

DEFINE VAR v-calle AS CHAR NO-UNDO.
DEFINE VAR v-altura AS CHAR NO-UNDO.
DEFINE VAR v-refer AS CHAR NO-UNDO.
DEFINE VAR v-extra AS CHAR NO-UNDO.
DEFINE VAR rok AS INTEGER NO-UNDO.
DEFINE BUFFER bbtarea FOR tarea.
DEFINE VAR nro_tipo_evento_DTS LIKE evento.nro_tipo_evento NO-UNDO.
{findempresa.i}
todook = FALSE.

IF NOT AVAILABLE tarea THEN RETURN ERROR.

FIND tipo_evento WHERE tipo_evento.cdg_tipo_evento = "DTS" NO-LOCK.
nro_tipo_evento_DTS = tipo_evento.nro_tipo_evento.

RUN borrar_tablas_temporales.


    
    RUN getparametro_c.p (  INPUT  "DFMONEDA",
                  OUTPUT v-valor_c ).
    FIND Moneda WHERE Moneda.cdg_moneda = v-valor_c NO-LOCK.
    
    RUN getparametro_n.p (  INPUT  "DFDEPOSI", OUTPUT v-valor_n ).
    FIND Deposito WHERE Deposito.nro_deposito = v-valor_n 
                NO-LOCK.
    FIND cliente OF tarea NO-LOCK NO-ERROR.
    IF NOT AVAILABLE cliente THEN DO:
        IF tarea.geolat = 0 THEN DO:
            MESSAGE "La direccion no esta georeferenciada" VIEW-AS ALERT-BOX ERROR.
            UNDO,LEAVE.
        END.

        RUN decodir(tarea.direccion, OUTPUT v-calle,OUTPUT v-altura,OUTPUT v-refer,OUTPUT v-extra).
        
        CREATE cliente.
        ASSIGN Cliente.nro_cliente = NEXT-VALUE(proximo_cliente)
               tarea.nro_cliente = cliente.nro_cliente
               Cliente.fecha_alta  = TODAY
               Cliente.hora_alta   = TIME.
        ASSIGN Cliente.fecha_grab = TODAY
               Cliente.hora_grab = TIME
               cliente.geolat = tarea.geolat
               cliente.geolong = tarea.geolong.
        cliente.geoX = X(tarea.geolat,tarea.geolong).
        cliente.geoY = Y(tarea.geolat,tarea.geolong).
        cliente.direccion = trim( v-calle + " " + v-altura + " " + v-refer ).
        cliente.nom_cliente = "CP. " + cliente.direccion.
        cliente.cdg_cliente = "C" + STRING(Cliente.nro_cliente,"99999").
        Cliente.lista_empresas = Empresa.cdg_empresa.
        Cliente.lista_sectores = Empresa.cdg_empresa.
        cliente.ult_domicilio = 1.  
        FIND Entidad WHERE Entidad.cdg_entidad = Empresa.cdg_empresa NO-LOCK.
        Cliente.nro_entidad = Entidad.nro_entidad.
        
        FIND FIRST Lista_precios NO-LOCK.
        Cliente.dfl_lista = Lista_precios.cdg_lista.
        
        FIND FIRST Vendedor NO-LOCK.
        Cliente.nro_vendedor = Vendedor.nro_vendedor.
        
        FIND FIRST Cobrador NO-LOCK.
        Cliente.nro_cobrador = Cobrador.nro_cobrador.
        
        FIND FIRST Grupo-empresario NO-LOCK.
        Cliente.cdg_grupoemp = Grupo-empresario.cdg_grupoemp.
    /*lo que viene a continuacion es ASQUEROSO perdon si alguien ve esto*/
    /*dynasys no tiene defaults para las tablas maestras*/
    /*pero igual es nauseabundo */
        Cliente.cdg_condiva = 2.
        Cliente.cdg_estado = "A".
        Cliente.cdg_pais = 1.
        Cliente.dfl_cdg_puntovta = 0.
        Cliente.cdg_tipoclie = "2".
        cliente.localidad = "Capital Federal".
        Cliente.cdg_provincia = "01".
        Cliente.dfl_cndventa = "00".
        Cliente.dfl_lista = 1.
        cliente.cdg_famclie = "1".
    /*fin asquerosidad*/

        CREATE domicilio.

        ASSIGN  
            Domicilio.nro_domicilio = 1
            Domicilio.nro_cliente = cliente.nro_cliente
            Domicilio.nombre = "Domicilio"
            Domicilio.factura = TRUE
            Domicilio.retira = FALSE
            Domicilio.es_fiscal = TRUE
            Domicilio.cdg_pais = 1
            Domicilio.telefono = cliente.telefonos
            Domicilio.localidad = cliente.localidad
            Domicilio.direccion = cliente.direccion 
            Domicilio.cdg_provincia = cliente.cdg_provincia
            Domicilio.cdg_postal = REPLACE(cliente.cdg_postal,"-","").
    

        CREATE Hst_Cliente.
        BUFFER-COPY Cliente TO Hst_cliente.
        RUN completar_auditoria.p ( OUTPUT Hst_Cliente.user_cambio,
                OUTPUT Hst_cliente.fecha_cambio,
                OUTPUT Hst_cliente.hor_cambio,
                OUTPUT Hst_cliente.pc_cambio).
        ASSIGN Hst_cliente.hms_cambio = STRING(Hst_cliente.hor_cambio,"HH:MM:SS").
    
    
        FIND administrador WHERE administrador.nro_cliente = cliente.nro_admin NO-LOCK NO-ERROR.
        IF NOT AVAILABLE administrador THEN
            cliente.nro_admin = cliente.nro_cliente.
        ELSE
            cliente.nro_admin = administrador.nro_cliente.
    END.

    FIND administrador WHERE administrador.nro_cliente = cliente.nro_admin NO-LOCK NO-ERROR.
    IF NOT AVAILABLE administrador THEN
        cliente.nro_admin = cliente.nro_cliente.
    ELSE
        cliente.nro_admin = administrador.nro_cliente.

    RUN decodir(tarea.direccion, OUTPUT v-calle,OUTPUT v-altura,OUTPUT v-refer,OUTPUT v-extra).
    
    FIND administrador WHERE administrador.nro_cliente = cliente.nro_admin NO-LOCK.  
    /*creacion del remito*/
    CREATE t-rem_header.
    /*Ver el canal*/

    FIND punto-venta WHERE punto-venta.cdg_puntovta = int(extrae( "prf", Tarea.datos-template )) NO-LOCK NO-ERROR.
    IF NOT AVAILABLE punto-venta THEN DO:
        MESSAGE "El canal propuesto no existe, verifique" VIEW-AS ALERT-BOX ERROR.
        UNDO,LEAVE.
    END.
    IF NOT punto-venta.habilitado  THEN DO:
        MESSAGE "EL punto de venta no esta habilitado" VIEW-AS ALERT-BOX ERROR.
        UNDO,LEAVE.
    END.
    T-Rem_header.prf_comprob = punto-venta.cdg_puntovta.
    t-rem_header.cdg_comprob = IF punto-venta.impresor = "M" THEN "REMITCLM" ELSE "REMITCLI".
    FIND tipocomprobante 
        WHERE tipocomprobante.cdg_empresa = empresa.cdg_empresa AND
              tipocomprobante.cdg_comprob  = t-rem_header.cdg_comprob NO-LOCK.
    t-rem_header.tip_comprob = tipocomprobante.tip_comprob.


    find FIRST Comprobante_concepto OF Tipocomprobante 
              WHERE Comprobante_concepto.cdg_empresa = Empresa.cdg_empresa NO-LOCK.
    FIND Imputacion OF Comprobante_concepto NO-LOCK.
    FIND FIRST Tipo_puntovta 
            WHERE Tipo_puntovta.cdg_comprobante = tipocomprobante.cdg_comprobante
              AND Tipo_puntovta.cdg_empresa = Empresa.cdg_empresa
              AND Tipo_puntovta.cdg_puntovta = t-rem_header.prf_comprob
                  NO-LOCK NO-ERROR.
        IF NOT AVAILABLE Tipo_puntovta
        THEN DO:
            MESSAGE "NO SE ENCUENTRA EL PRIMER CENTRO EMISOR HABILITADO PARA ESTE COMPROBANTE O BIEN NO SE ENCUENTRA EL PREFERIDO"
                    VIEW-AS ALERT-BOX ERROR TITLE "ERROR DE IMPLEMENTACION- NO PROSIGA!!!!".
            UNDO,LEAVE.
        END.
    FIND condicion_venta WHERE condicion_venta.cdg_cndventa = cliente.dfl_cndventa NO-ERROR.
    BUFFER-COPY cliente TO t-rem_header.
    ASSIGN T-Rem_header.cdg_comprobante = Tipocomprobante.cdg_comprobante
           T-Rem_header.nro_usuario    = Usuario.nro_usuario 
           T-Rem_header.cdg_empresa    = Empresa.cdg_empresa
           T-Rem_header.fecha          = TODAY 
           T-Rem_header.fecha_iva      = TODAY 
           T-Rem_header.mes            = MONTH(T-Rem_header.fecha) 
           T-Rem_header.ano            = YEAR(T-Rem_header.fecha)
           T-Rem_header.nro_deposito   = Deposito.nro_deposito 
           T-Rem_header.tip_comprob    = "" 
           T-Rem_header.estado         = "E"
           T-Rem_header.nro_comprob    = T-Rem_header.nro_remito
           T-Rem_header.nro_moneda     = Moneda.nro_moneda 
           T-Rem_header.cambio         = Moneda.cambio  
           T-Rem_header.cdg_imputacion = Imputacion.cdg_imputacion 
           T-Rem_header.cta_cte        = Imputacion.cta_cte
           t-rem_header.nro_domicilio  = 1
           t-rem_header.nro_cndventa   = condicion_venta.nro_cndventa
           T-Rem_header.origen         = "M".
    t-rem_header.sin_cargo = logical(extrae("sin_cargo",Tarea.datos-template)).
    T-Rem_header.leyenda_cc = "".
    t-rem_header.nombre = cliente.nom_cliente.
    t-rem_header.direccion = trim(trim( v-calle + " " + v-altura + " " + v-refer ) + " " + v-extra).
    t-rem_header.direccion_leg = cliente.direccion.
    t-rem_header.cdg_postal = cliente.cdg_postal.
    t-rem_header.localidad = cliente.localidad.
    t-rem_header.cdg_provincia = cliente.cdg_provincia.
    t-rem_header.cdg_postal_leg = cliente.cdg_postal.
    t-rem_header.localidad_leg = cliente.localidad.
    t-rem_header.cdg_provincia_leg = cliente.cdg_provincia.
    T-Rem_header.ultima_linea     = 1.

    CREATE t-rem_detalle.

    FIND FIRST articulo WHERE articulo.cdg_articulo = extrae("articulo", Tarea.datos-template ) NO-LOCK NO-ERROR.
    IF NOT AVAILABLE articulo THEN DO:
        MESSAGE "Articulo no registrado" VIEW-AS ALERT-BOX ERROR.
        UNDO,LEAVE.
    END.
    IF articulo.nro_tipo_evento <> tarea.nro_tipo_evento THEN DO:
        MESSAGE "El articulo no es valido para el tipo de evento de la tarea" VIEW-AS ALERT-BOX ERROR.
        UNDO,LEAVE.
    END.
    
    IF Articulo.cdg_estado <> ""
       THEN DO:
          RUN PONMENSJ.P (INPUT "FACT032").
          undo,leave.
    END.

    FIND Familia_articulo OF Articulo NO-LOCK.
    FIND FIRST Familia_cuenta 
       WHERE Familia_cuenta.cdg_imputacion = T-Rem_header.cdg_imputacion
         AND Familia_cuenta.nro_familia    = Familia_articulo.nro_familia
         AND Familia_cuenta.cdg_empresa    = T-Rem_header.cdg_empresa
             NO-LOCK NO-ERROR.
   
    IF NOT AVAILABLE Familia_cuenta
    THEN DO:
      RUN PONMENSJ.P (INPUT "FAPR061").
      UNDO,LEAVE.
    END.

    ASSIGN
           t-rem_detalle.nro_articulo = articulo.nro_articulo
           /*t-rem_detalle.detallada = articulo.detallada*/
           t-rem_detalle.cantidad = 1
           t-rem_detalle.nro_linea = 1
           t-rem_detalle.costo = 0.
           t-rem_detalle.precio_cf = decimal(extrae("imp_servicio", Tarea.datos-template )).
           T-Rem_detalle.nro_remito      = T-Rem_header.nro_remito.
     /*descripcion detallada segun combos y anexos*/
           
    FIND tipo-precio WHERE tipo-precio.ind = int(extrae("ind1",Tarea.datos-template  )) AND
                           tipo-precio.tabla = 1 NO-LOCK NO-ERROR.
    IF AVAILABLE tipo-precio THEN
        IF tipo-precio.ind <> 0 THEN
            T-Rem_detalle.detallada = "Destapacion de " + tipo-precio.descripcion.
    
    FIND tipo-precio WHERE tipo-precio.ind = int(extrae("ind2",Tarea.datos-template )) AND
                            tipo-precio.tabla = 2 NO-LOCK NO-ERROR.
    IF AVAILABLE tipo-precio THEN
        IF tipo-precio.ind <> 0 THEN
            T-Rem_detalle.detallada = T-Rem_detalle.detallada + " desde " + tipo-precio.descripcion.

    FIND tipo-precio WHERE tipo-precio.ind = int(extrae("ind3",Tarea.datos-template )) AND
                           tipo-precio.tabla = 3 NO-LOCK NO-ERROR.
    IF AVAILABLE tipo-precio THEN
        IF tipo-precio.ind <> 0 THEN
            T-Rem_detalle.detallada = T-Rem_detalle.detallada + " a " + tipo-precio.descripcion.

    FIND tipo-precio WHERE tipo-precio.ind = int(extrae("ind4",Tarea.datos-template )) AND
                           tipo-precio.tabla = 4 NO-LOCK NO-ERROR.
        IF AVAILABLE tipo-precio THEN
             IF tipo-precio.ind <> 0 THEN
                 T-Rem_detalle.detallada = T-Rem_detalle.detallada + "" + tipo-precio.descripcion.
    T-Rem_detalle.detallada = IF T-Rem_detalle.detallada <> "" THEN T-Rem_detalle.detallada + chr(13) + extrae("texto_adic",Tarea.datos-template  )
        ELSE extrae("texto_adic",Tarea.datos-template ).

    RUN calcular_valores.
    EMPTY TEMP-TABLE T-Sub_header_inv NO-ERROR. 
    EMPTY TEMP-TABLE T-Sub_detalle_inv NO-ERROR.       
    
    { calcularemito.i "T-"}

    RUN valuar_remito.p ( 
            INPUT-OUTPUT  TABLE  T-Rem_header,
            INPUT-OUTPUT  TABLE  T-Rem_detalle,
            INPUT-OUTPUT  TABLE  T-Sub_header_vta,
            INPUT-OUTPUT  TABLE  T-Sub_detalle_vta,
            INPUT-OUTPUT  TABLE  T-Rem_header-bon,
            INPUT-OUTPUT  TABLE  T-Rem_detalle-bon,
            INPUT-OUTPUT  TABLE  T-Rem_header_impuesto,
            INPUT-OUTPUT  TABLE  T-Rem_detalle_impuesto ).

    FIND FIRST t-rem_header.
    IF NOT logical(extrae( "Factura",Tarea.datos-template )) THEN t-rem_header.estado = "-".    

    RUN emitir_compdespacho.p (  INPUT-OUTPUT TABLE T-Rem_header,
                                    INPUT TABLE T-Rem_detalle,
                                    INPUT TABLE T-Registrable-remito, 
                                    INPUT TABLE T-Rem_header-bon,
                                    INPUT TABLE T-Rem_detalle-bon,
                                    INPUT TABLE T-Remito-pedido,
                                    INPUT TABLE T-Sub_header_inv,
                                    INPUT TABLE T-Sub_detalle_inv
                                   ). 
    FIND FIRST t-rem_header.
    FIND rem_detalle WHERE rem_detalle.nro_remito = t-rem_header.nro_remito AND
                                  rem_detalle.nro_linea = 1.
    FIND articulo OF rem_detalle NO-LOCK.
    tarea.nro_destino = t-rem_header.nro_remito.
    tarea.destino = T-Rem_header.cdg_comprobante.
       /*si dispara un evento evaluar*/
       /*crear el evento correspondiente*/
    CREATE evento.
    ASSIGN evento.nro_evento = NEXT-VALUE(proximo_evento)
           evento.nro_tipo_evento = articulo.nro_tipo_evento
           evento.fasignado = tarea.fecha_prevista
           evento.frealizado = IF tarea.nro_tipo_evento = Nro_tipo_evento_DTS THEN evento.frealizado ELSE ?
           evento.nro_identificacion = t-rem_header.nro_remito
           evento.origen = t-rem_header.cdg_comprobante
           evento.nro_cliente = cliente.nro_cliente
           Evento.FCreado = TODAY
           evento.periodo = YEAR(TODAY) * 100 + MONTH(TODAY)
           evento.fmin = tarea.fecha_prevista
           evento.fmax = tarea.fecha_prevista.
           evento.hora_hasta = ajuh(extrae("hora_fin",Tarea.datos-template)).
           evento.duracion = tarea.horas_estimadas.
           evento.recurso = extrae("frecursos",Tarea.datos-template).
           evento.observacion = tarea.descripcion.
           evento.leyenda = tarea.leyenda.
           evento.hora_desde = ajuh(tarea.hora_prevista).
           tarea.nro_evento = evento.nro_evento.
           DO k = 1 TO NUM-ENTRIES(evento.recursos):
           CREATE recurso_agenda.
           ASSIGN recurso_agenda.cdg_recurso = ENTRY(k,evento.recursos)
                     recurso_agenda.fecha = Evento.FAsignado
                     recurso_agenda.nro_evento = Evento.nro_evento.
           
           END.
           
           ASSIGN rem_detalle.nro_evento = evento.nro_evento.
           MESSAGE "Se ha generado el evento " evento.nro_evento SKIP
                   "asientelo en la orden de trabajo" VIEW-AS ALERT-BOX information.

   FIND FIRST t-rem_header NO-ERROR.
   IF NOT AVAILABLE t-rem_header THEN RETURN ERROR.

/*impresion*/
/*De aca en mas el evento se realizo*/
IF evento.fasignado = ? THEN DO:
    ASSIGN evento.fasignado = evento.frealizado.
    FOR EACH recurso_agenda  WHERE recurso_agenda .nro_evento = evento.nro_evento:
            recurso_agenda.fecha = evento.fasignado.
    END.

END.

FIND rem_header WHERE rem_header.nro_remito = evento.nro_identificacion.
if sic.Rem_header.cdg_formapago <> 0 AND NOT rem_header.sin_cargo THEN DO:
        RUN crea_tarea.p( evento.nro_evento,evento.nro_cliente, "C" , "Cobranza Remito" + rem_header.tip_comprob + "-" + STRING(rem_header.prf_comprob) + "-" + string(rem_header.nro_comprob),"Cobranza Remito" + rem_header.tip_comprob + "-" + STRING(rem_header.prf_comprob) + "-" + string(rem_header.nro_comprob),TODAY,"*",OUTPUT rok).
        IF rok = ? THEN DO:
            MESSAGE "No se puede crear tarea por error en usuario/recurso".
            RETURN ERROR.
        END.
        ELSE DO: 
            FIND bbtarea WHERE bbtarea.nro_tarea = rok EXCLUSIVE-LOCK.
            FIND recurso WHERE recurso.cdg_recurso = ENTRY(1,evento.recurso) NO-LOCK.
            bbtarea.reportado_por = Recurso.nom_recurso.
            MESSAGE "Se ha creado la tarea para la cobranza" rok VIEW-AS ALERT-BOX INFORMATION.
        END.
            
END.

RUN imprecibo.
/*RUN impcertif.p ( evento.nro_evento , "R" ,8).*/
todook = TRUE.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE crea_remitoFQ B-table-Win 
PROCEDURE crea_remitoFQ :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEFINE OUTPUT PARAMETER todook AS LOGICAL NO-UNDO.
DEFINE VAR oldnf AS CHAR NO-UNDO.
DEFINE VAR opt AS LOGICAL INITIAL FALSE.
DEFINE VAR v-valor_c AS CHAR NO-UNDO.
DEFINE VAR v-valor_n AS INT NO-UNDO.
DEFINE VAR k AS INT NO-UNDO.

DEFINE VAR v-calle AS CHAR NO-UNDO.
DEFINE VAR v-altura AS CHAR NO-UNDO.
DEFINE VAR v-refer AS CHAR NO-UNDO.
DEFINE VAR v-extra AS CHAR NO-UNDO.
DEFINE VAR facadmin LIKE cliente.nro_cliente.
{findempresa.i}
todook = FALSE.


IF NOT AVAILABLE tarea THEN RETURN ERROR.

RUN borrar_tablas_temporales.

    
    RUN getparametro_c.p (  INPUT  "DFMONEDA",
                  OUTPUT v-valor_c ).
    FIND Moneda WHERE Moneda.cdg_moneda = v-valor_c NO-LOCK.
    
    RUN getparametro_n.p (  INPUT  "DFDEPOSI", OUTPUT v-valor_n ).
    FIND Deposito WHERE Deposito.nro_deposito = v-valor_n 
                NO-LOCK.
    FIND cliente OF tarea NO-LOCK NO-ERROR.
    IF NOT AVAILABLE cliente THEN DO:
        IF tarea.geolat = 0 THEN DO:
            MESSAGE "La direccion no esta georeferenciada" VIEW-AS ALERT-BOX ERROR.
            UNDO,LEAVE.
        END.

        RUN decodir(tarea.direccion, OUTPUT v-calle,OUTPUT v-altura,OUTPUT v-refer,OUTPUT v-extra).
        
        CREATE cliente.
        ASSIGN Cliente.nro_cliente = NEXT-VALUE(proximo_cliente)
               tarea.nro_cliente = cliente.nro_cliente
               Cliente.fecha_alta  = TODAY
               Cliente.hora_alta   = TIME.
        ASSIGN Cliente.fecha_grab = TODAY
               Cliente.hora_grab = TIME
               cliente.geolat = tarea.geolat
               cliente.geolong = tarea.geolong.
        cliente.geoX = X(tarea.geolat,tarea.geolong).
        cliente.geoY = Y(tarea.geolat,tarea.geolong).
        cliente.direccion = trim( v-calle + " " + v-altura + " " + v-refer ).
        cliente.nom_cliente = "CP. " + cliente.direccion.
        cliente.cdg_cliente = "C" + STRING(Cliente.nro_cliente,"99999").
        Cliente.lista_empresas = Empresa.cdg_empresa.
        Cliente.lista_sectores = Empresa.cdg_empresa.
        cliente.ult_domicilio = 1.  
        FIND Entidad WHERE Entidad.cdg_entidad = Empresa.cdg_empresa NO-LOCK.
        Cliente.nro_entidad = Entidad.nro_entidad.
        
        FIND FIRST Lista_precios NO-LOCK.
        Cliente.dfl_lista = Lista_precios.cdg_lista.
        
        FIND FIRST Vendedor NO-LOCK.
        Cliente.nro_vendedor = Vendedor.nro_vendedor.
        
        FIND FIRST Cobrador NO-LOCK.
        Cliente.nro_cobrador = Cobrador.nro_cobrador.
        
        FIND FIRST Grupo-empresario NO-LOCK.
        Cliente.cdg_grupoemp = Grupo-empresario.cdg_grupoemp.
    /*lo que viene a continuacion es ASQUEROSO perdon si alguien ve esto*/
    /*dynasys no tiene defaults para las tablas maestras*/
    /*pero igual es nauseabundo */
        Cliente.cdg_condiva = 2.
        Cliente.cdg_estado = "A".
        Cliente.cdg_pais = 1.
        Cliente.dfl_cdg_puntovta = 0.
        Cliente.cdg_tipoclie = "2".
        cliente.localidad = "Capital Federal".
        Cliente.cdg_provincia = "01".
        Cliente.dfl_cndventa = "00".
        Cliente.dfl_lista = 1. 
        cliente.cdg_famclie = "1".
    /*fin asquerosidad*/

        CREATE domicilio.

        ASSIGN  
            Domicilio.nro_domicilio = 1
            Domicilio.nro_cliente = cliente.nro_cliente
            Domicilio.nombre = "Domicilio"
            Domicilio.factura = TRUE
            Domicilio.retira = FALSE
            Domicilio.es_fiscal = TRUE
            Domicilio.cdg_pais = 1
            Domicilio.telefono = cliente.telefonos
            Domicilio.localidad = cliente.localidad
            Domicilio.direccion = cliente.direccion 
            Domicilio.cdg_provincia = cliente.cdg_provincia
            Domicilio.cdg_postal = REPLACE(cliente.cdg_postal,"-","").
    

        CREATE Hst_Cliente.
        BUFFER-COPY Cliente TO Hst_cliente.
        RUN completar_auditoria.p ( OUTPUT Hst_Cliente.user_cambio,
                OUTPUT Hst_cliente.fecha_cambio,
                OUTPUT Hst_cliente.hor_cambio,
                OUTPUT Hst_cliente.pc_cambio).
        ASSIGN Hst_cliente.hms_cambio = STRING(Hst_cliente.hor_cambio,"HH:MM:SS").
    
    END.
    FIND administrador WHERE administrador.nro_cliente = cliente.nro_admin NO-LOCK NO-ERROR.
    IF NOT AVAILABLE administrador OR logical(extrae( "propietario", Tarea.datos-template )) THEN
        facadmin = cliente.nro_cliente.
    ELSE
        facadmin = administrador.nro_cliente.
    RUN decodir(tarea.direccion, OUTPUT v-calle,OUTPUT v-altura,OUTPUT v-refer,OUTPUT v-extra).
    
    FIND administrador WHERE administrador.nro_cliente = facadmin NO-LOCK.  
    /*creacion del remito*/
    CREATE t-rem_header.
    /*Ver el canal*/

    FIND punto-venta WHERE punto-venta.cdg_puntovta = int(extrae( "prf", Tarea.datos-template )) NO-LOCK NO-ERROR.
    IF NOT AVAILABLE punto-venta THEN DO:
        MESSAGE "El canal propuesto no existe, verifique" VIEW-AS ALERT-BOX ERROR.
        UNDO,LEAVE.
    END.
    IF NOT punto-venta.habilitado  THEN DO:
        MESSAGE "EL punto de venta no esta habilitado" VIEW-AS ALERT-BOX ERROR.
        UNDO,LEAVE.
    END.
    T-Rem_header.prf_comprob = punto-venta.cdg_puntovta.
    t-rem_header.cdg_comprob = IF punto-venta.impresor = "M" THEN "REMITCLM" ELSE "REMITCLI".
    FIND tipocomprobante 
        WHERE tipocomprobante.cdg_empresa = empresa.cdg_empresa AND
              tipocomprobante.cdg_comprob  = t-rem_header.cdg_comprob NO-LOCK.
    t-rem_header.tip_comprob = tipocomprobante.tip_comprob.

    FIND condicion_venta WHERE condicion_venta.cdg_cndventa = cliente.dfl_cndventa NO-LOCK.
    find FIRST Comprobante_concepto OF Tipocomprobante 
              WHERE Comprobante_concepto.cdg_empresa = Empresa.cdg_empresa NO-LOCK.
    FIND Imputacion OF Comprobante_concepto NO-LOCK.
    FIND FIRST Tipo_puntovta 
            WHERE Tipo_puntovta.cdg_comprobante = tipocomprobante.cdg_comprobante
              AND Tipo_puntovta.cdg_empresa = Empresa.cdg_empresa
              AND Tipo_puntovta.cdg_puntovta = t-rem_header.prf_comprob
                  NO-LOCK NO-ERROR.
        IF NOT AVAILABLE Tipo_puntovta
        THEN DO:
            MESSAGE "NO SE ENCUENTRA EL PRIMER CENTRO EMISOR HABILITADO PARA ESTE COMPROBANTE O BIEN NO SE ENCUENTRA EL PREFERIDO"
                    VIEW-AS ALERT-BOX ERROR TITLE "ERROR DE IMPLEMENTACION- NO PROSIGA!!!!".
            UNDO,LEAVE.
        END.
    BUFFER-COPY cliente TO t-rem_header.
    ASSIGN T-Rem_header.cdg_comprobante = Tipocomprobante.cdg_comprobante
           T-Rem_header.nro_usuario    = Usuario.nro_usuario 
           T-Rem_header.cdg_empresa    = Empresa.cdg_empresa
           T-Rem_header.fecha          = TODAY 
           T-Rem_header.fecha_iva      = TODAY 
           T-Rem_header.mes            = MONTH(T-Rem_header.fecha) 
           T-Rem_header.ano            = YEAR(T-Rem_header.fecha)
           T-Rem_header.nro_deposito   = Deposito.nro_deposito 
           T-Rem_header.tip_comprob    = "" 
           T-Rem_header.estado         = "E"
           T-Rem_header.nro_comprob    = T-Rem_header.nro_remito
           T-Rem_header.nro_moneda     = Moneda.nro_moneda 
           T-Rem_header.cambio         = Moneda.cambio  
           T-Rem_header.cdg_imputacion = Imputacion.cdg_imputacion 
           T-Rem_header.cta_cte        = Imputacion.cta_cte
           t-rem_header.nro_domicilio  = 1
           t-rem_header.nro_cndventa   = condicion_venta.nro_cndventa
           T-Rem_header.origen         = "M".

    t-rem_header.sin_cargo = logical(extrae("sin_cargo",Tarea.datos-template)).
    T-Rem_header.leyenda_cc = "".
    t-rem_header.nombre = cliente.nom_cliente.
    t-rem_header.direccion = trim(trim( v-calle + " " + v-altura + " " + v-refer ) + " " + v-extra).
    t-rem_header.direccion_leg = cliente.direccion.
    t-rem_header.cdg_postal = cliente.cdg_postal.
    t-rem_header.localidad = cliente.localidad.
    t-rem_header.cdg_provincia = cliente.cdg_provincia.
    t-rem_header.cdg_postal_leg = cliente.cdg_postal.
    t-rem_header.localidad_leg = cliente.localidad.
    t-rem_header.cdg_provincia_leg = cliente.cdg_provincia.
    T-Rem_header.ultima_linea     = 1.

    CREATE t-rem_detalle.

    FIND FIRST articulo WHERE articulo.cdg_articulo = extrae("articulo", Tarea.datos-template ) NO-LOCK NO-ERROR.
    IF NOT AVAILABLE articulo THEN DO:
        MESSAGE "Articulo no registrado" VIEW-AS ALERT-BOX ERROR.
        UNDO,LEAVE.
    END.
    IF articulo.nro_tipo_evento <> tarea.nro_tipo_evento THEN DO:
        MESSAGE "El articulo no es valido para el tipo de evento de la tarea" VIEW-AS ALERT-BOX ERROR.
        UNDO,LEAVE.
    END.
    
    IF Articulo.cdg_estado <> ""
       THEN DO:
          RUN PONMENSJ.P (INPUT "FACT032").
          undo,leave.
    END.

    FIND Familia_articulo OF Articulo NO-LOCK.
    FIND FIRST Familia_cuenta 
       WHERE Familia_cuenta.cdg_imputacion = T-Rem_header.cdg_imputacion
         AND Familia_cuenta.nro_familia    = Familia_articulo.nro_familia
         AND Familia_cuenta.cdg_empresa    = T-Rem_header.cdg_empresa
             NO-LOCK NO-ERROR.
   
    IF NOT AVAILABLE Familia_cuenta
    THEN DO:
      RUN PONMENSJ.P (INPUT "FAPR061").
      UNDO,LEAVE.
    END.

    ASSIGN
           t-rem_detalle.nro_articulo = articulo.nro_articulo
           t-rem_detalle.detallada = articulo.detallada
           t-rem_detalle.cantidad = 1
           t-rem_detalle.nro_linea = 1
           t-rem_detalle.costo = 0.
           t-rem_detalle.precio_cf = decimal(extrae("imp_servicio", Tarea.datos-template )).
           T-Rem_detalle.nro_remito      = T-Rem_header.nro_remito.
     /*descripcion detallada segun combos y anexos*/
           
    T-Rem_detalle.detallada = IF T-Rem_detalle.detallada <> "" THEN T-Rem_detalle.detallada + chr(13) + extrae("texto_adic",Tarea.datos-template  )
        ELSE extrae("texto_adic",Tarea.datos-template ).

    RUN calcular_valores.
    EMPTY TEMP-TABLE T-Sub_header_inv NO-ERROR. 
    EMPTY TEMP-TABLE T-Sub_detalle_inv NO-ERROR.       
    
    { calcularemito.i "T-"}

    RUN valuar_remito.p ( 
            INPUT-OUTPUT  TABLE  T-Rem_header,
            INPUT-OUTPUT  TABLE  T-Rem_detalle,
            INPUT-OUTPUT  TABLE  T-Sub_header_vta,
            INPUT-OUTPUT  TABLE  T-Sub_detalle_vta,
            INPUT-OUTPUT  TABLE  T-Rem_header-bon,
            INPUT-OUTPUT  TABLE  T-Rem_detalle-bon,
            INPUT-OUTPUT  TABLE  T-Rem_header_impuesto,
            INPUT-OUTPUT  TABLE  T-Rem_detalle_impuesto ).

    FIND FIRST t-rem_header.
    IF NOT logical(extrae( "Factura",Tarea.datos-template )) THEN t-rem_header.estado = "-".   

    RUN emitir_compdespacho.p (  INPUT-OUTPUT TABLE T-Rem_header,
                                    INPUT TABLE T-Rem_detalle,
                                    INPUT TABLE T-Registrable-remito, 
                                    INPUT TABLE T-Rem_header-bon,
                                    INPUT TABLE T-Rem_detalle-bon,
                                    INPUT TABLE T-Remito-pedido,
                                    INPUT TABLE T-Sub_header_inv,
                                    INPUT TABLE T-Sub_detalle_inv
                                   ). 
    FIND FIRST t-rem_header.
    FIND rem_detalle WHERE rem_detalle.nro_remito = t-rem_header.nro_remito AND
                                  rem_detalle.nro_linea = 1.
    FIND articulo OF rem_detalle NO-LOCK.
    tarea.nro_destino = t-rem_header.nro_remito.
    tarea.destino = T-Rem_header.cdg_comprobante.
       /*si dispara un evento evaluar*/
       /*crear el evento correspondiente*/
    CREATE evento.
    ASSIGN evento.nro_evento = NEXT-VALUE(proximo_evento)
           evento.nro_tipo_evento = tarea.nro_tipo_evento
           evento.fasignado = tarea.fecha_prevista
           evento.nro_identificacion = t-rem_header.nro_remito
           evento.origen = t-rem_header.cdg_comprobante
           evento.nro_cliente = cliente.nro_cliente
           Evento.FCreado = TODAY
           evento.periodo = YEAR(TODAY) * 100 + MONTH(TODAY)
           evento.fmin = tarea.fecha_prevista
           evento.fmax = tarea.fecha_prevista.
           evento.turno = extrae("turno",Tarea.datos-template).
           evento.hora_hasta = ajuh(extrae("hora_fin",Tarea.datos-template)).
           evento.duracion = tarea.horas_estimadas.
           evento.recurso = extrae("frecursos",Tarea.datos-template).
           evento.observacion = tarea.descripcion.
           evento.leyenda = tarea.leyenda + "INFO:" + v-extra.
           evento.hora_desde = ajuh(tarea.hora_prevista).
           /*tiene certif*/
           tarea.nro_evento = evento.nro_evento.
           DO k = 1 TO NUM-ENTRIES(evento.recursos):
           CREATE recurso_agenda.
               ASSIGN recurso_agenda.cdg_recurso = ENTRY(k,evento.recursos)
                         recurso_agenda.fecha = Evento.FAsignado
                         recurso_agenda.nro_evento = Evento.nro_evento.
           END.
           
           ASSIGN rem_detalle.nro_evento = evento.nro_evento.
           MESSAGE "Se ha generado el evento " evento.nro_evento 
                    VIEW-AS ALERT-BOX information.
   
   FIND FIRST t-rem_header NO-ERROR.
   IF NOT AVAILABLE t-rem_header THEN RETURN ERROR.
   todook = TRUE.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE crea_retiro_libro B-table-Win 
PROCEDURE crea_retiro_libro :
/*------------------------------------------------------------------------------
  Purpose:  Crea el evento para el retiro de libro RL o bien un EC
  Parameters:  <none>
  Notes: El parametro tienelibro si esta en no ya a crear no crea el paso que sigue
------------------------------------------------------------------------------*/
DEFINE OUTPUT PARAMETER explica AS CHAR NO-UNDO.
DEFINE OUTPUT PARAMETER todook AS LOGICAL NO-UNDO.
/*
DEFINE VAR precursos AS CHAR.
DEFI VAR xfile AS CHAR NO-UNDO.
DEF VAR ReportePath AS CHAR NO-UNDO.
DEF VAR cFullPath AS CHAR NO-UNDO.
DEF VAR XFullPath AS CHAR NO-UNDO.
DEF VAR exportFileName AS CHAR NO-UNDO.
DEFINE VAR p-des_fecha AS DATE.
DEFINE VAR p-has_fecha AS DATE.
DEFINE VAR ERROR_rango AS LOGICAL.
DEFINE VAR rok AS LOGICAL NO-UNDO.
DEFINE VAR rimprime AS LOGICAL NO-UNDO.
DEFINE VAR tev AS CHAR NO-UNDO.
DEFINE BUFFER administrador FOR cliente.
todook = FALSE.
IF NOT LOGICAL(extrae("tienelibro",tarea.dato)) THEN DO:
        MESSAGE "Esta por cerrar la tarea indicando que el cliente no tiene el libro" SKIP
                "esto generara un evento de Entrega de certificado" VIEW-AS ALERT-BOX QUESTION BUTTONS OK-CANCEL SET rok.
        IF NOT rok THEN RETURN.
END.
IF tarea.fecha_prevista < TODAY THEN DO:
        MESSAGE "No puede asignar con una fecha anterior a hoy" VIEW-AS ALERT-BOX ERROR.
        RETURN ERROR.
END.
 precursos  =  entry(1,extrae("frecursos" , tarea.dato)) .

 IF precursos = "" OR tarea.fecha_prevista = ? THEN DO:
   MESSAGE "Se cerrara la tarea creando un evento no asignado" SKIP
           "sino especifique fecha y recurso" VIEW-AS ALERT-BOX BUTTONS OK-CANCEL SET todook.
   IF NOT todook THEN RETURN ERROR.
END.
 tev = "RL".
    find restriccion no-lock where restriccion.cdg_restriccion = "LIBROT".
    find cliente_restriccion where cliente_restriccion.nro_restriccion = restriccion.nro_restriccion and
                                   cliente_restriccion.nro_cliente = evento.nro_cliente no-lock no-error.
    if available cliente_restriccion then do:
       if cliente_restriccion.valor = "N" then tev = "EC".
    end.
    else do:
     IF NOT LOGICAL(extrae("tienelibro", tarea.dato)) THEN tev="EC".
    END.

 FIND tipo_evento WHERE tipo_evento.cdg_tipo_evento = tev NO-LOCK.
 CREATE evento.
        ASSIGN evento.nro_evento = NEXT-VALUE(proximo_evento)
               evento.nro_tipo_evento = tipo_evento.nro_tipo_evento
               evento.fasignado = tarea.fecha_prevista
               evento.nro_identificacion = tarea.nro_tarea /*porque deviene de una tarea tiene numero de tarea sino tiene 0*/
               evento.origen = "TAREA"
               evento.nro_cliente = tarea.nro_cliente
               Evento.FCreado = TODAY
               evento.periodo = YEAR(today) * 100 + MONTH(today)
               evento.fmin = TODAY
               evento.fmax = TODAY + 20 /*fijo cualquier cosa se vera*/
               evento.recurso = precursos
               evento.observacion = tarea.descripcion.
               evento.leyenda = tarea.leyenda.
               evento.duracion = 15.
               tarea.destino = "EVENTO".
               tarea.nro_destino = evento.nro_evento.
               evento.turno = "**".
               explica ="Evento:" + string(evento.nro_evento).
     IF extrae("retira",tarea.dato)="A" then do:
        FIND administrador WHERE administrador.nro_cliente = cliente.nro_admin NO-LOCK NO-ERROR.
        IF AVAILABLE administrador THEN DO:
            evento.leyenda = evento.leyenda + " Retirar por administracion " + administrador.direccion.
        END.
     END.
    evento.leyenda = evento.leyenda + extrae("TEXTO_ADIC",tarea.dato).
    IF evento.fasignado <> ? AND evento.recursos <> "" THEN DO:
                   CREATE recurso_agenda.
                   ASSIGN recurso_agenda.cdg_recurso = entry(1,precursos)
                           recurso_agenda.Fecha = evento.fasignado
                           recurso_agenda.nro_evento = evento.nro_evento.
                   IF tev = "RL" THEN DO:
            MESSAGE "Desea imprimir la orden de trabajo " tev SET rimprime VIEW-AS ALERT-BOX BUTTONS YES-NO.
            IF rimprime THEN DO:
            /*impresion de la orden ya que esta asignada*/
              ReportePath = "orden_" + STRING(evento.nro_tipo_evento) .
              RUN fullPath (ReportePath, '.rpt':U, OUTPUT cFullPath).
              IF cFullPath = ? THEN DO:
                  MESSAGE "No se encuentra el archivo de impresion " ReportePath SKIP
                     "para el tipo de evento seleccionado" VIEW-AS ALERT-BOX ERROR.
                  RETURN NO-apply.  
              END.
              EMPTY TEMP-TABLE aimp.
              CREATE aimp.
              ASSIGN aimp.c_nro_tipo_evento = evento.nro_tipo_evento
                     aimp.nro_evento = evento.nro_evento
                     aimp.recurso = evento.recurso
                     aimp.turno = evento.turno.
              RUN printorden.p ( INPUT TABLE aimp, OUTPUT xfile, 1 ). 
            
              CREATE "CrystalRuntime.Application" chApplication.
                chReport = chApplication:OpenReport(cFullPath, {&crOpenReportByTempCopy}).
                chReport:DiscardSavedData(). /*eliminando lo previamente grabado*/
              RUN fullpath ( INPUT xfile, INPUT "", OUTPUT xFullPath ).
                chReport:Database:Tables:item(1):setTableLocation(xFullPath, '', '').
              RUN crearReporte(chReport,"rpt",/*ViewReport*/ TRUE,/*PrinterName*/ "?",
                                   /*exportToDisk*/ FALSE, INPUT-OUTPUT exportFileName ).    
              RELEASE OBJECT chReport. 
              chReport = ?.
              RELEASE OBJECT chApplication.     
            END.  
        END.
    END.
    todook = TRUE.*/
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE crea_supervicion B-table-Win 
PROCEDURE crea_supervicion :
/*------------------------------------------------------------------------------
  Purpose:  Crea el evento de la cobranza   
  Parameters:  <none>
  Notes: el funcionamiento depende mucho de las restricciones
         puede estar asignada o no
------------------------------------------------------------------------------*/
DEFINE OUTPUT PARAMETER todook AS LOGICAL NO-UNDO.
DEFINE VAR precursos AS CHAR NO-UNDO.
DEFINE VAR pfasignado AS DATE NO-UNDO.
DEFINE VAR pfmin AS DATE NO-UNDO.
DEFINE VAR pfmax AS DATE NO-UNDO.
DEFINE VAR prest AS CHAR NO-UNDO.
DEFINE VAR pevsigue AS INT NO-UNDO.
DEFINE BUFFER bevento FOR evento.
DEFINE BUFFER btipo_evento FOR tipo_evento.
todook = FALSE.
FIND cliente OF tarea NO-LOCK.
precursos = "".
pfasignado = ?.
pfmin = ?.
pfmax = ?.
pevsigue = 0.

pfmin  = tarea.fecha_prevista.
pfmax  = tarea.fecha_prevista.
precursos = entry(1 , extrae("frecursos" , tarea.dato ) ) .
pevsigue = int(entry(1 , extrae("evsigue",tarea.dato) )).
FIND btipo_evento WHERE btipo_evento.cdg_tipo_evento = "CSE" NO-LOCK.
FIND recurso WHERE recurso.cdg_recurso = precursos NO-LOCK NO-ERROR.
IF AVAILABLE recurso THEN DO:
    FIND recurso_habilidad OF recurso WHERE recurso_habilidad.nro_tipo_evento = btipo_evento.nro_tipo_evento NO-LOCK NO-ERROR.
END.
IF pfmin = pfmax AND  precursos <> ? AND precursos <> "" AND
            AVAILABLE recurso_habilidad  THEN pfasignado = pfmin.

/*creando el evento*/
 CREATE evento.
        ASSIGN evento.nro_evento = NEXT-VALUE(proximo_evento)
               evento.nro_tipo_evento = btipo_evento.nro_tipo_evento
               tarea.nro_tipo_evento = btipo_evento.nro_tipo_evento
               evento.fasignado = IF precursos <> "" THEN pfasignado ELSE ?
               evento.nro_identificacion = tarea.nro_tarea /*porque deviene de una tarea tiene numero de tarea sino tiene 0*/
               evento.origen = "TAREA"
               evento.nro_cliente = cliente.nro_cliente
               Evento.FCreado = TODAY
               evento.periodo = IF pfasignado <> ? THEN YEAR(pfasignado) * 100 + MONTH(pfasignado) ELSE YEAR(pfmin) * 100 + MONTH(pfmin)
               evento.fmin = pfmin
               evento.fmax = pfmax
               evento.recurso = precursos
               evento.observacion = tarea.descripcion.
               evento.leyenda = tarea.leyenda.
               evento.duracion = 15.
               evento.evsigue = pevsigue.
               /*evento.duracion = tarea_horas_estimadas.*/
               evento.hora_desde = ajuh(replace(tarea.hora_prevista,":","")).
               evento.hora_hasta = ajuh(replace(extrae("hora_fin" , tarea.dato),":","")).
               tarea.destino = "EVENTO".
               tarea.nro_destino = evento.nro_evento.
               evento.turno = IF int(aint(evento.hora_desde)) < 1230 THEN "M*" ELSE "T*".
               IF INT(aint(evento.hora_hasta)) > 1230 THEN 
                       evento.turno = IF evento.turno BEGINS "M" then "**" ELSE evento.turno.

          
           IF pfasignado <> ? THEN DO:
                CREATE recurso_agenda.
                ASSIGN recurso_agenda.cdg_recurso = precursos
                       recurso_agenda.Fecha = pfasignado
                       recurso_agenda.nro_evento = evento.nro_evento.
                
           END.
               
           MESSAGE "Se ha generado el evento " evento.nro_evento SKIP 
                   IF evento.evsigue <> 0 THEN "incorporando la supervicion a el evento " + string( evento.evsigue ) ELSE "" 
                   IF pfasignado <> ? THEN "Se a asignado el mismo el " + STRING(pfasignado) + " para " + precursos ELSE ""  SKIP
                   VIEW-AS ALERT-BOX information.
/*apareo de eventos de entrega de documentacion ENVIO*/

RUN aparea_envio.
todook = TRUE.
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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE ficha_tarea B-table-Win 
PROCEDURE ficha_tarea :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

/*   IF AVAILABLE Tarea */
/*       THEN           */
      MESSAGE "No implementado aun".
  RETURN NO-APPLY.
      /*RUN prtarea.p ( INPUT Tarea.nro_tarea).*/

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE hallar_iva_detalle B-table-Win 
PROCEDURE hallar_iva_detalle :
DEFINE OUTPUT PARAMETER p-tasa LIKE Impuesto_condicion.tasa.
 
 p-tasa = 0.
 /*ver si el comprobante aplica impuestos o no*/
 FIND tipocomprobante OF t-rem_header NO-LOCK.

 IF Tipocomprobante.aplica_impuestos THEN DO:
      
     FIND Familia_impositiva OF Articulo NO-LOCK.
        
     FIND first Impuesto_condicion OF  Familia_impositiva 
           WHERE Impuesto_condicion.cdg_condiva = T-rem_header.cdg_condiva
             AND Impuesto_condicion.cdg_empresa = T-rem_header.cdg_empresa 
             AND Impuesto_condicion.fch_desde <= T-rem_header.fecha_iva
             AND Impuesto_condicion.fch_hasta >= T-rem_header.fecha_iva
             AND CAN-DO(Impuesto_condicion.lista_provincias,T-rem_header.cdg_provincia) 
             AND CAN-FIND(FIRST Impuesto OF Impuesto_condicion WHERE Impuesto.es_iva) NO-LOCK NO-ERROR.
     IF AVAILABLE Impuesto_condicion THEN DO:
         FIND FIRST  Cliente_excencion OF Cliente 
                      WHERE Cliente_excencion.cdg_empresa  = T-rem_header.cdg_empresa
                        AND Cliente_excencion.cdg_impuesto = Impuesto_condicion.cdg_impuesto
                        AND Cliente_excencion.fch_desde <= T-rem_header.fecha_iva
                        AND Cliente_excencion.fch_hasta >= T-rem_header.fecha_iva NO-LOCK NO-ERROR.
        
         IF NOT AVAILABLE Cliente_excencion
             THEN p-tasa = Impuesto_condicion.tasa.
             ELSE p-tasa = Impuesto_condicion.tasa * ( 1 - Cliente_excencion.prc_excencion  / 100.0 ).
              
     END.
 END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE horas_x_tarea B-table-Win 
PROCEDURE horas_x_tarea :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

  RUN horas_x_tarea.p ( INPUT que_estado,
                        INPUT que_proyecto,
                        INPUT que_recurso ).

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE imprecibo B-table-Win 
PROCEDURE imprecibo :
/*------------------------------------------------------------------------------
  Purpose:     imprime el recibo si corresponde al conformar la OT
  Parameters:  <none>
  Notes: El evento ya esta disponible y seleccionado      
------------------------------------------------------------------------------*/
DEFINE VAR fmin AS DATE NO-UNDO.
DEFINE VAR fmax AS DATE NO-UNDO.
DEFINE VAR almenos AS INT NO-UNDO.
DEFINE VAR procesar AS LOGICAL NO-UNDO.
  DEFINE VAR cFullPath AS CHAR NO-UNDO.
  DEFINE VAR xFullPath AS CHAR NO-UNDO.
  DEFINE VAR ReportePath AS CHAR NO-UNDO.
  DEFINE VAR exportFileName AS CHAR NO-UNDO.
DEFINE VAR ERROR_nro AS INT NO-UNDO.
  DEF VAR xfile AS CHAR NO-UNDO.

DEFINE BUFFER bevento FOR evento.
    procesar = FALSE.
    fmin = DATE( int( SUBSTRING( string( evento.periodo,"999999") , 5 , 2 ) ) , 1 , int( SUBSTRING( string(evento.periodo,"999999"), 1 , 4 ) ) ).
    fmax = fmin + 32.
    fmax = DATE( MONTH(fmax), 1, YEAR(fmax)).
    fmax = fmax - 1.
    IF evento.origen <> "CONTRATO" THEN LEAVE. /*no corresponde*/
    /*es el ultimo subevento*/
    FIND bevento WHERE bevento.nro_identificacion = evento.nro_identificacion AND NOT bevento.anulado AND NOT evento.anulado AND 
    bevento.sub_evento > evento.sub_evento AND bevento.periodo = evento.periodo NO-LOCK NO-ERROR.
    IF AVAILABLE bevento THEN LEAVE. /*no es el ultimo*/
    /*imprimir el recibo de la factura del mes*/
IF evento.origen = "CONTRATO" THEN DO:
    FOR EACH fac_header WHERE fac_header.tip_comprob BEGINS "F" AND 
        fac_header.nro_contrato = evento.nro_identificacion AND
        fac_header.fecha >= fmin AND fac_header.fecha <= fmax AND
        NOT fac_header.anulado BY fac_header.fecha:
            FIND FIRST fac_detalle OF fac_header.
            FIND articulo OF fac_detalle.
            IF articulo.nro_tipo_evento <> evento.nro_tipo_evento THEN NEXT.
            /*DISPLAY fac_header.tip_comprob WHEN AVAILABLE fac_header
                    fac_header.prf_comprob WHEN AVAILABLE fac_header
                    fac_header.nro_comprob WHEN AVAILABLE fac_header.*/
        IF Fac_header.estado_2_impresion = "OT" THEN DO:
                RUN afi/CUP000.p ( fac_header.tip_comprob ,
                                   fac_header.prf_comprob ,
                                   fac_header.nro_comprob , 
                                   fac_header.nro_comprob ,
                                   fac_header.cdg_empresa ,
                                   TRUE ,
                                   OUTPUT xfile ).
                procesar = TRUE.
        END.
        LEAVE.
    END.
END.
ELSE IF evento.origen BEGINS "REMITCL" THEN DO:
    FIND FIRST rem_header WHERE rem_header.nro_remito = evento.nro_identificacion AND NOT rem_header.anulado.
    IF rem_header.sin_cargo THEN NEXT.
    FOR EACH fac_header WHERE fac_header.nro_factura  = rem_header.nro_factura AND
            NOT fac_header.anulado:
                FIND FIRST fac_detalle OF fac_header.
                FIND articulo OF fac_detalle.
                IF articulo.nro_tipo_evento <> evento.nro_tipo_evento THEN NEXT.
     /*           DISPLAY fac_header.tip_comprob WHEN AVAILABLE fac_header
                        fac_header.prf_comprob WHEN AVAILABLE fac_header
                        fac_header.nro_comprob WHEN AVAILABLE fac_header. */

        IF Fac_header.estado_2_impresion = "OT" THEN DO:
                RUN afi/CUP000.p ( fac_header.tip_comprob ,
                                   fac_header.prf_comprob ,
                                   fac_header.nro_comprob , 
                                   fac_header.nro_comprob ,
                                   fac_header.cdg_empresa ,
                                   TRUE).
                procesar = TRUE.

        END.
        LEAVE.
    END.
END.
IF procesar THEN DO:
  /*a Imprimir*/
    ReportePath = "AFI/" + formulario( ROWID(fac_header) ).
    RUN fullPath (ReportePath, '.rpt':U, OUTPUT cFullPath).
    IF cFullPath = ? 
    THEN DO:
        RUN mensajepar.p (INPUT ReportePath, INPUT "CREP000").
        RETURN ERROR.
    END.
    CREATE "CrystalRuntime.Application" chApplication.
    chReport = chApplication:OpenReport(cFullPath, {&crOpenReportByTempCopy}).
    chReport:DiscardSavedData(). /*eliminando lo previamente grabado*/
    RUN fullpath ( INPUT xfile, INPUT "", OUTPUT xFullPath ).
    chReport:Database:Tables:item(1):setTableLocation(xFullPath, '', '').
    RUN crearReporte(chReport,"rpt",/*ViewReport*/ FALSE, /*impresora*/ impreport(1) , 
        /*exportToDisk*/ FALSE, INPUT-OUTPUT exportFileName ).        
        RELEASE OBJECT chReport. 
        chReport = ?.
        RELEASE OBJECT chApplication.
        chApplication = ?.
       RUN borra_temp ( INPUT xfile, OUTPUT ERROR_nro ).
END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE impreot B-table-Win 
PROCEDURE impreot :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:      
------------------------------------------------------------------------------*/
DEFINE INPUT PARAM nnro LIKE evento.nro_evento NO-UNDO.

FIND evento WHERE evento.nro_evento = nnro NO-ERROR.
IF NOT AVAILABLE evento THEN RETURN ERROR.
    DEFI VAR xfile AS CHAR NO-UNDO.
    DEF VAR ReportePath AS CHAR NO-UNDO.
    DEF VAR cFullPath AS CHAR NO-UNDO.
    DEF VAR XFullPath AS CHAR NO-UNDO.
    DEF VAR exportFileName AS CHAR NO-UNDO.
    DEFINE VAR p-des_fecha AS DATE.
    DEFINE VAR p-has_fecha AS DATE.
    DEFINE VAR ERROR_rango AS LOGICAL.
    DEFINE VAR opc AS LOGICAL NO-UNDO.

    MESSAGE "Confirme la impresion de la OT en este momento" VIEW-AS ALERT-BOX BUTTONS YES-NO SET opc .
    IF opc THEN RUN impcertif.p ( evento.nro_evento , "O" , 8).

    ReportePath = "orden_" + STRING(evento.nro_tipo_evento) .
    RUN fullPath (ReportePath, '.rpt':U, OUTPUT cFullPath).

    IF cFullPath = ? 
      THEN DO:
        MESSAGE "No se encuentra el archivo de impresion " ReportePath SKIP
                "para el tipo de evento seleccionado" VIEW-AS ALERT-BOX ERROR.
          RETURN NO-apply.
      END.
    IF evento.frealizado<>? OR evento.anulado THEN DO:
        MESSAGE "Verifique el evento esta " SKIP
        "anulado o realizado" VIEW-AS ALERT-BOX.
            RETURN NO-APPLY.
    END.

    EMPTY TEMP-TABLE aimp.
    CREATE aimp.
    ASSIGN aimp.c_nro_tipo_evento = evento.nro_tipo_evento
            aimp.nro_evento = evento.nro_evento
            aimp.recurso = evento.recurso
            aimp.turno = evento.turno.

    RUN printorden.p ( INPUT TABLE aimp, OUTPUT xfile, 1 ). 

    CREATE "CrystalRuntime.Application" chApplication.
    chReport = chApplication:OpenReport(cFullPath, {&crOpenReportByTempCopy}).
    chReport:DiscardSavedData(). /*eliminando lo previamente grabado*/
    RUN fullpath ( INPUT xfile, INPUT "", OUTPUT xFullPath ).
    chReport:Database:Tables:item(1):setTableLocation(xFullPath, '', '').
    RUN crearReporte(chReport,"rpt",/*ViewReport*/ FALSE,/*PrinterName*/ impreport(1),
                       /*exportToDisk*/ FALSE, INPUT-OUTPUT exportFileName ).        

    RELEASE OBJECT chReport. 
    chReport = ?.
    RELEASE OBJECT chApplication.
    FIND restriccion WHERE restriccion.cdg_restriccion BEGINS "CERTI" AND restriccion.nro_tipo_evento = evento.nro_tipo_evento NO-LOCK NO-ERROR.
    IF NOT AVAILABLE restriccion THEN RETURN.
    IF evento.origen <> "CONTRATO" THEN RETURN. /*no corresponde*/
    IF Evento.sub_evento <> 1 THEN return. /*no es el primero*/
    IF evento.nro_tipo_evento <> 1 THEN RETURN. /*como es para FU no tengo que tener en cuenta la cuota*/
    FIND contrato_hd WHERE contrato_hd.nro_contrato = evento.nro_identificacion.
    FIND contrato_restriccion OF restriccion WHERE contrato_restriccion.nro_contrato = evento.nro_identificacion NO-LOCK NO-ERROR.
    IF NOT AVAILABLE contrato_restriccion THEN RETURN.
    IF contrato_restriccion.valor <> "O" THEN RETURN.
    MESSAGE "Desea imprimir el certificado" VIEW-AS ALERT-BOX BUTTONS YES-NO SET opc .
    IF opc THEN RUN impcertif.p ( evento.nro_evento , "O" , 8).

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE imprimir_tareas B-table-Win 
PROCEDURE imprimir_tareas :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

  RUN imprimir_tareas.p ( INPUT que_estado,
                          INPUT que_proyecto,
                          INPUT que_recurso ).

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE iniciar_proyectos B-table-Win 
PROCEDURE iniciar_proyectos :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
  x-lista = "".
  FOR EACH Proyecto WHERE Proyecto.abierto BY Proyecto.dsc_proyecto:
    x-lista = x-lista +  "," + Proyecto.dsc_proyecto + "," + Proyecto.cdg_proyecto.
  END.
  x-lista = SUBSTRING(x-lista,2).

  IF NUM-ENTRIES(x-lista) = 2 THEN  DO:
       que_proyecto:LIST-ITEM-PAIRS IN FRAME {&FRAME-NAME} = x-lista.
  END.
  ELSE DO:
      x-lista = x-lista + ",[Todos los Proyectos],*".
      que_proyecto:LIST-ITEM-PAIRS IN FRAME {&FRAME-NAME} = x-lista.
  END.
  que_proyecto = ENTRY(2,x-lista,",").
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE iniciar_recursos B-table-Win 
PROCEDURE iniciar_recursos :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
x-lista = "[Todos],*".
  FOR EACH Recurso WHERE recurso.habilidad <> "" BY Recurso.nom_recurso:
    x-lista = x-lista +  "," + Recurso.nom_recurso + "," + Recurso.cdg_recurso.
  END.
  que_recurso:LIST-ITEM-PAIRS IN FRAME {&FRAME-NAME} = x-lista.
  que_recurso = ENTRY(2,x-lista,",").

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE iniciar_tipo_tareas B-table-Win 
PROCEDURE iniciar_tipo_tareas :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEFINE VAR xtip AS CHAR NO-UNDO.
  xtip = x_cdg_tipotarea:SCREEN-VALUE IN FRAME {&FRAME-NAME}.
  xtip = IF xtip = ? THEN "*" ELSE xtip.
  x-lista = "*TODAS*,*,*DQFE*,DQFE,*TYZ*,TYZ".

  FOR EACH Tipo_tarea  NO-LOCK BY Tipo_tarea.cdg_tipotarea :
    x-lista = x-lista +  "," + Tipo_tarea.dsc_tipotarea + "," + Tipo_tarea.cdg_tipotarea.
  END.
  x_cdg_tipotarea:LIST-ITEM-PAIRS IN FRAME {&FRAME-NAME} = SUBSTRING(x-lista,1).
  x_cdg_tipotarea:SCREEN-VALUE = xtip.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE local-display-fields B-table-Win 
PROCEDURE local-display-fields :
/*------------------------------------------------------------------------------
  Purpose:     Override standard ADM method
  Notes:       
------------------------------------------------------------------------------*/

  /* Code placed here will execute PRIOR to standard behavior. */

  /* Dispatch standard ADM method.                             */
  RUN dispatch IN THIS-PROCEDURE ( INPUT 'display-fields':U ) .

  /* Code placed here will execute AFTER standard behavior.    */

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE local-hide B-table-Win 
PROCEDURE local-hide :
/*------------------------------------------------------------------------------
  Purpose:     Override standard ADM method
  Notes:       
------------------------------------------------------------------------------*/

  /* Code placed here will execute PRIOR to standard behavior. */
  refresco(FALSE).
  /* Dispatch standard ADM method.                             */
  RUN dispatch IN THIS-PROCEDURE ( INPUT 'hide':U ) .

  /* Code placed here will execute AFTER standard behavior.    */
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE local-initialize B-table-Win 
PROCEDURE local-initialize :
/*------------------------------------------------------------------------------
  Purpose:     Override standard ADM method
  Notes:       
------------------------------------------------------------------------------*/
  DEF VAR h_browser AS HANDLE NO-UNDO.
  h_browser = BROWSE {&BROWSE-NAME}:HANDLE.
  h_browser:SET-SORT-ARROW ( 1, TRUE ). 
  sortby = "Tarea.prioridad".
  sortdir = TRUE.

  RUN iniciar_proyectos.
  RUN iniciar_tipo_tareas.
  RUN iniciar_recursos.
  
/*poner el cdg_recurso segun entro*/
/*FIND Usuario WHERE Usuario.cdg_usuario = USERID("sic") NO-LOCK NO-ERROR.
FIND recurso OF usuario NO-LOCK NO-ERROR.
IF AVAILABLE recurso THEN que_recurso = recurso.cdg_recurso.*/



  que_estado = "A".
  /* Dispatch standard ADM method.                             */
  RUN dispatch IN THIS-PROCEDURE ( INPUT 'initialize':U ) .

  /* Code placed here will execute AFTER standard behavior.    */
  fvisualizar = NOW.
  treloj = TRUE.
  tauto = TRUE.
  DISPLAY que_recurso 
          que_proyecto
          fvisualizar
          treloj
          tauto
          que_estado
      WITH FRAME {&FRAME-NAME}.
  chProgressBar:XP_ProgressBar:MIN = 0.   
  chProgressBar:XP_ProgressBar:MAX = idletime.  
  chProgressBar:XP_ProgressBar:VALUE = 1. 
  chCtrlTimer:PSTimer:ENABLED = TRUE.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE local-open-query B-table-Win 
PROCEDURE local-open-query :
/*------------------------------------------------------------------------------
  Purpose:     Override standard ADM method
  Notes:       
------------------------------------------------------------------------------*/

DEFINE VAR h_browser AS HANDLE NO-UNDO.
DEFINE VAR h_query AS HANDLE NO-UNDO.
DEFINE VAR nroadm AS INT NO-UNDO.
DEFINE VAR nrocli AS INT NO-UNDO.
DEFINE VAR sorttext AS CHAR NO-UNDO.
DEFINE VAR rrow AS ROWID NO-UNDO.
DEFINE VAR looktarea AS CHAR NO-UNDO.
refresco(FALSE).

h_browser = BROWSE {&BROWSE-NAME}:HANDLE.
IF AVAILABLE tarea THEN rrow = ROWID(tarea).
ELSE rrow = ?.
ETIME(TRUE).
h_browser = BROWSE {&BROWSE-NAME}:HANDLE.
/*h_browser:SET-REPOSITIONED-ROW ( 1 , "CONDITIONAL" ). */
h_query = h_browser:QUERY.

ASSIGN FRAME {&FRAME-NAME} v-cdg_administrador 
                           v-cdg_cliente 
                           fvisualizar
                           fdescrip
                           fdireccion
                           fnombre
                           ftarea.
FIND cliente WHERE cliente.cdg_cliente = v-cdg_cliente NO-LOCK NO-ERROR.
nrocli = IF AVAILABLE cliente THEN cliente.nro_cliente ELSE 0.
FIND administrador WHERE administrador.cdg_cliente = v-cdg_administrador NO-LOCK NO-ERROR.
nroadm = IF AVAILABLE administrador THEN administrador.nro_cliente ELSE 0.
IF fvisualizar = ? THEN fvisualizar = TODAY + 1.   

DO WITH FRAME {&FRAME-NAME}:
  querystring = "FOR EACH Tarea WHERE sic.Tarea.Visualizar " + ( IF texcluido THEN "> " ELSE "<= " )  + "datetime( '" + string( fvisualizar , "99-99-99 HH:MM:SS" ) + "') " + 
    ( IF que_proyecto <> "G" THEN " and Tarea.cdg_proyecto = '" + que_proyecto + "'" else "" ) +
    ( IF nroadm <> 0 THEN " AND tarea.nro_administrador = " + string(nroadm) ELSE "" ) +
    ( IF nrocli <> 0 THEN " AND tarea.nro_cliente = " + string(nrocli) ELSE "" ).

  IF que_estado <> "*" THEN 
             querystring = querystring + " AND Tarea.estado = '" + que_estado + "'" .
  
  IF x_cdg_tipotarea <> "*" THEN 
          querystring = querystring + " and index('" + x_cdg_tipotarea + "',tarea.cdg_tipotarea)<>0".

  IF X_cdg_tipotarea = "DQFE" THEN 
           querystring = querystring + " and tarea.prioridad <> 0".
  querystring = querystring +
    ( IF que_recurso <> "*" THEN " and Tarea.cdg_recurso = '" + que_recurso + "'"  ELSE "" ) +
    ( IF fdireccion:SCREEN-VALUE <> "" THEN " and tarea.direccion contains '" + fdireccion:SCREEN-VALUE + "'" ELSE "" ) + 
    ( IF fnombre:SCREEN-VALUE <> "" THEN " and tarea.nom_cliente contains '" + fnombre:SCREEN-VALUE + "'" ELSE "" ) + 
    ( IF ftarea:SCREEN-VALUE <> "" THEN " and tarea.nro_tarea = " + ftarea:SCREEN-VALUE ELSE "" ) + 
    ( IF fdescrip:SCREEN-VALUE <> "" THEN " and tarea.descripcion contains '" + fdescrip:SCREEN-VALUE + "'" ELSE "" ) + 
    " NO-LOCK, " + "FIRST tipo_tarea OF tarea NO-LOCK".
 
  IF que_estado = "R" THEN sortby = "resuelto".

END.
/*UPDATE querystring WITH FRAME aa VIEW-AS DIALOG-BOX.*/
IF x_cdg_tipotarea = "DQFE" THEN sortby = "DQFE".
IF x_cdg_tipotarea = "TYZ" THEN sortby = "TYZ".

CASE sortby :
    WHEN "FultimaM" THEN sorttext = "by tarea.FultimaM by  tarea.nro_tarea".
    WHEN "lTurnoGestion" THEN sorttext = "by tarea.prioridad desc by tarea.turnogestion by tarea.nro_tarea".
    WHEN "prioridad" THEN  sorttext = "by tarea.prioridad by tarea.nro_tarea".
    WHEN "nro_tarea" THEN SORTtext = "by tarea.nro_tarea".
    WHEN "direccion" THEN SORTtext = "by tarea.direccion".
    WHEN "dsc_tipotarea" THEN SORTtext = "by tarea.cdg_tipotarea".
    WHEN "quiencliente" THEN SORTtext = "by tarea.nro_cliente".
    WHEN "quienadministrador" THEN SORTtext = "by tarea.nro_administrador".
    WHEN "Resuelto" THEN SORTtext = "by Tarea.fecha_resuelto desc".
    WHEN "quienacargo" THEN SORTtext = "by tarea.nro_usuario".
    WHEN "durmiendo" THEN SORTtext = "by tarea.fecha_alta".
    WHEN "visualizar" THEN SORTtext = "by Tarea.visualizar".
    WHEN "accion" THEN SORTtext = "by Tarea.accion by Tarea.fecha_alta".
    WHEN "fecha_prevista" OR WHEN "hora_prevista" THEN SORTtext = "by tarea.fecha_prevista". 
    WHEN "origen" THEN SORTtext = "by Tarea.origen by Tarea.fecha_alta".
    WHEN "DQFE" THEN sorttext = "by tarea.fecha_prevista by Tarea.fecha_alta".
    WHEN "TYZ" THEN sorttext = "by tarea.fecha_prevista by Tarea.fecha_alta".
    OTHERWISE sorttext = "by tarea.prioridad desc by tarea.turnogestion by tarea.nro_tarea".
END.

IF sortby <> "" THEN
    querystring = querystring + " " + sorttext + ( IF NOT sortdir THEN " DESCENDING" ELSE "" ).
IF sortby = "fecha_prevista"  OR sortby = "hora_prevista" THEN 
    querystring = querystring + " by tarea.hora_prevista " + ( IF NOT sortdir THEN " DESCENDING" ELSE "" ).

h_query:QUERY-PREPARE( querystring ).
h_query:QUERY-OPEN.
IF NOT AVAILABLE tarea THEN DO:
    /*MESSAGE "Los filtros asignados no arrojan ningun resultado" VIEW-AS ALERT-BOX INFORMATION.*/
    RETURN ERROR.
END.
                                             
h_query:REPOSITION-TO-ROWID(rrow) NO-ERROR.
IF ERROR-STATUS:ERROR THEN DO:
    h_query:REPOSITION-TO-ROW(1) NO-ERROR.
END.

/*que actualize los relacionados*/
  {src/adm/template/brschnge.i}
  IF AVAILABLE tarea THEN
     RUN cambia_templateprinc ( tarea.cdg_tipotarea ).

  BTN_CERRAR:SENSITIVE IN FRAME {&FRAME-NAME} = ( tarea.estado = "A" OR  tarea.estado = "C" OR tarea.estado = "F" ). 
  BTN_DESCARTAR:SENSITIVE IN FRAME {&FRAME-NAME} = ( tarea.estado = "A" OR tarea.estado = "C" ). 
  BTN_REABRIR:SENSITIVE IN FRAME {&FRAME-NAME} = ( tarea.estado = "D" OR tarea.estado = "R").
  BTN_arecuperar:SENSITIVE IN FRAME {&FRAME-NAME} = tarea.estado = "A".
  IF tarea.cdg_tipotarea = "D" THEN DO:
   IF tarea.estado = "A" THEN DO:
        btn_faltaOT:SENSITIVE IN FRAME {&FRAME-NAME} = TRUE.
        btn_faltaOT:LABEL IN FRAME {&FRAME-NAME} = "Falta OT".
   END.
   IF tarea.estado = "F" THEN DO:
        btn_faltaOT:SENSITIVE IN FRAME {&FRAME-NAME} = TRUE.
        btn_faltaOT:LABEL IN FRAME {&FRAME-NAME} = "Abre OT".
   END.
  END.

refresco(TRUE).
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE local-row-changed B-table-Win 
PROCEDURE local-row-changed :
/*------------------------------------------------------------------------------
  Purpose:     Override standard ADM method
  Notes:       
------------------------------------------------------------------------------*/
  IF AVAILABLE tarea THEN DO:
     refresco(FALSE).
     RUN cambia_templateprinc ( tarea.cdg_tipotarea ).
     refresco(true).

  END.
  /* Code placed here will execute PRIOR to standard behavior. */

  /* Dispatch standard ADM method.                             */
  RUN dispatch IN THIS-PROCEDURE ( INPUT 'row-changed':U ) .

  /* Code placed here will execute AFTER standard behavior.    */


END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE local-view B-table-Win 
PROCEDURE local-view :
/*------------------------------------------------------------------------------
  Purpose:     Override standard ADM method
  Notes:       
------------------------------------------------------------------------------*/

  /* Code placed here will execute PRIOR to standard behavior. */
  /* Dispatch standard ADM method.                             */
  RUN dispatch IN THIS-PROCEDURE ( INPUT 'view':U ) .

  /* Code placed here will execute AFTER standard behavior.    */
refresco(TRUE).

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE refrescar_proyectos B-table-Win 
PROCEDURE refrescar_proyectos :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

  DEFINE OUTPUT PARAMETER p-lista AS CHARACTER.

  DEFINE VARIABLE x-proyecto LIKE Proyecto.cdg_proyecto.

  x-proyecto = que_proyecto:INPUT-VALUE IN FRAME {&FRAME-NAME}.
  RUN iniciar_proyectos.
  IF CAN-FIND(FIRST Proyecto 
              WHERE Proyecto.cdg_proyecto = x-proyecto
                AND LOOKUP(Proyecto.dsc_proyecto,que_proyecto:LIST-ITEM-PAIRS IN FRAME {&FRAME-NAME}) <> 0 )
  THEN DO:
      que_proyecto = x-proyecto.
  END.
  ELSE DO:
      que_proyecto = ENTRY(2,que_proyecto:LIST-ITEM-PAIRS IN FRAME {&FRAME-NAME},",").
  END.

  DISPLAY que_proyecto WITH FRAME {&FRAME-NAME}.

  p-lista = que_proyecto:LIST-ITEM-PAIRS IN FRAME {&FRAME-NAME}.


END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE refrescar_recursos B-table-Win 
PROCEDURE refrescar_recursos :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

  DEFINE VARIABLE x-recurso AS CHARACTER.

  x-recurso = que_recurso:SCREEN-VALUE IN FRAME {&FRAME-NAME}.
  RUN iniciar_recursos.
  que_recurso:SCREEN-VALUE IN FRAME {&FRAME-NAME} = x-recurso.


END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE refrescar_tipotareas B-table-Win 
PROCEDURE refrescar_tipotareas :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
 RUN iniciar_tipo_tareas.
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
  {src/adm/template/sndkycas.i "cdg_proyecto" "Tarea" "cdg_proyecto"}
  {src/adm/template/sndkycas.i "cdg_recurso" "Tarea" "cdg_recurso"}
  {src/adm/template/sndkycas.i "nro_tarea" "Tarea" "nro_tarea"}
  {src/adm/template/sndkycas.i "cdg_tipotarea" "Tarea" "cdg_tipotarea"}
  {src/adm/template/sndkycas.i "descripcion" "Tarea" "descripcion"}
  {src/adm/template/sndkycas.i "nro_cliente" "Tarea" "nro_cliente"}
  {src/adm/template/sndkycas.i "cdg_postal" "Tarea" "cdg_postal"}
  {src/adm/template/sndkycas.i "cdg_tarea" "Tarea" "cdg_tarea"}
  {src/adm/template/sndkycas.i "cdg_usuario" "Tarea" "cdg_usuario"}
  {src/adm/template/sndkycas.i "nro_usuario" "Tarea" "nro_usuario"}

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
  {src/adm/template/snd-list.i "Tarea"}
  {src/adm/template/snd-list.i "tipo_tarea"}

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
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE traer_tablas B-table-Win 
PROCEDURE traer_tablas :
/*------------------------------------------------------------------------------
  Purpose:   Trae las tablas que componen el documento  
  Parameters:  <none>
  Notes:     En esta version varias de las tablas relacionadas se encuentran 
             directamente en Fac_header, esto permite una fotografia del 
             documento en su generacion
------------------------------------------------------------------------------*/

  FIND Condicion_impos  OF T-Fac_header NO-LOCK.
  FIND Condicion_venta  OF T-Fac_header NO-LOCK.
  FIND Imputacion       OF T-Fac_header NO-LOCK.
  ASSIGN
        T-Fac_header.cdg_imputacion      = Imputacion.cdg_imputacion.
  FIND Moneda    OF T-Fac_header   NO-LOCK.
  FIND Cliente OF T-Fac_header NO-LOCK.

  FIND Domicilio OF T-Fac_header NO-LOCK.
  FIND Provincia OF Domicilio NO-LOCK.
  FIND Lista_precios  OF T-Fac_header NO-LOCK.
  FIND Vendedor    OF T-Fac_header   NO-LOCK.
  FIND administrador WHERE T-Fac_header.nro_administrador = administrador.nro_cliente NO-LOCK.
/*nominacion del comprobante segun remito*/
  ASSIGN  
       T-Fac_header.cdg_postal_leg    =     T-Fac_header.cdg_postal
       T-Fac_header.cdg_provincia_leg =     T-Fac_header.cdg_provincia
       T-Fac_header.direccion_leg     =     T-Fac_header.direccion
       T-Fac_header.localidad_leg     =     T-Fac_header.localidad
       T-Fac_header.nombre_leg        =     T-Fac_header.nombre.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE valor_proyecto B-table-Win 
PROCEDURE valor_proyecto :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

  DEFINE OUTPUT PARAMETER p-cdg_proyecto LIKE Proyecto.cdg_proyecto.

 p-cdg_proyecto = que_proyecto:SCREEN-VALUE IN FRAME {&FRAME-NAME}.
     

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE valor_recurso B-table-Win 
PROCEDURE valor_recurso :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

  DEFINE OUTPUT PARAMETER p-cdg_recurso LIKE Recurso.cdg_recurso.

  p-cdg_recurso = que_recurso:SCREEN-VALUE IN FRAME {&FRAME-NAME}.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

/* ************************  Function Implementations ***************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION busca_email B-table-Win 
FUNCTION busca_email RETURNS CHARACTER
  ( nro AS INT ) :
/*------------------------------------------------------------------------------
  Purpose:  
    Notes:  
------------------------------------------------------------------------------*/
 DEFINE VAR auxc AS CHAR INITIAL "" NO-UNDO. 
 auxc = "".
  FIND cliente WHERE cliente.nro_cliente = nro NO-LOCK NO-ERROR.
  IF AVAILABLE cliente THEN DO:
      FIND FIRST domicilio OF cliente NO-LOCK NO-ERROR.
      IF AVAILABLE domicilio THEN DO:
           FOR EACH Cliente-contacto OF Domicilio WHERE  can-do(Cliente-contacto.canal-email,"ADM"), first Persona OF Cliente-contacto WHERE persona.email <> "" NO-LOCK :
                auxc = persona.email.
                LEAVE.
           END.
           IF auxc = "" THEN
               FOR EACH Cliente-contacto OF Domicilio WHERE cliente-contacto.cdg_cargo BEGINS "ADM" , first Persona OF Cliente-contacto WHERE persona.email <> "" NO-LOCK :
                 auxc = persona.email.
                 LEAVE.
               END.
           IF auxc = "" THEN
               FOR EACH Cliente-contacto OF Domicilio , first Persona OF Cliente-contacto WHERE persona.email <> "" NO-LOCK :
                 auxc = persona.email.
                 LEAVE.
               END.
      END.
  END.
  RETURN auxc.   /* Function return value. */

END FUNCTION.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION durmiendo B-table-Win 
FUNCTION durmiendo RETURNS INTEGER
  ( /* parameter-definitions */ ) :
/*------------------------------------------------------------------------------
  Purpose:  Dias durmiendo sin ninguna accion
    Notes:  
------------------------------------------------------------------------------*/
  IF tarea.fecha_prevista <> ? THEN RETURN TODAY - tarea.fecha_prevista.
  RETURN IF TODAY - Tarea.fecha_alta > 0 THEN TODAY - Tarea.fecha_alta ELSE 0.   /* Function return value. */

END FUNCTION.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION fcorte B-table-Win 
FUNCTION fcorte RETURNS DATE
  ( /* parameter-definitions */ ) :
/*------------------------------------------------------------------------------
  Purpose:  
    Notes:  
------------------------------------------------------------------------------*/
    DEFINE VAR p-corte AS DATE.
    DEFINE VAR p-precorte AS DATE.
    p-precorte = DATE(MONTH(TODAY),1,YEAR(TODAY)) - 1.
    p-precorte = DATE(MONTH(p-precorte),1,YEAR(p-precorte)).
    FIND restriccion WHERE restriccion.cdg_restriccion = "CORTE" NO-LOCK NO-ERROR.
    IF NOT AVAILABLE restriccion THEN DO:
        MESSAGE "No existe la restriccion tipo CORTE" VIEW-AS ALERT-BOX ERROR.
        RETURN NO-APPLY.
    END.
    FIND cliente_restriccion OF cliente WHERE cliente_restriccion.nro_restriccion = restriccion.nro_restriccion NO-LOCK NO-ERROR.
    IF NOT AVAILABLE cliente_restriccion THEN p-corte = p-precorte + 9.
    ELSE do:
            p-corte = p-precorte + INT(cliente_restriccion.valor) - 1 NO-ERROR.
            IF ERROR-STATUS:ERROR THEN p-corte = p-precorte + INT(cliente_restriccion.valor) - 2 NO-ERROR.
            IF ERROR-STATUS:ERROR THEN p-corte = p-precorte + INT(cliente_restriccion.valor) - 3 NO-ERROR.
            IF ERROR-STATUS:ERROR THEN p-corte = p-precorte + INT(cliente_restriccion.valor) - 4 NO-ERROR.
    END.
    REPEAT:
         IF es_habil(p-corte,"23456") THEN LEAVE.
         p-corte = p-corte + 1.
    END.
    /*p-corte esta ok*/
RETURN p-corte.

END FUNCTION.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION formulario B-table-Win 
FUNCTION formulario RETURNS CHARACTER
  ( INPUT rid_fac_header AS ROWID ) :
/*------------------------------------------------------------------------------
  Purpose:  retorna el formulario a utilizar
    Notes:  La cantidad de copias no es un parametro ya que el formulario 
            define univocamente la cantidad de copias no es un dato separado
            es la definicion del mismo formulario
            
------------------------------------------------------------------------------*/
DEFINE VARIABLE que_formulario      AS CHARACTER.
DEFINE VARIABLE x-formulario        AS CHARACTER.
DEFINE VARIABLE j                   AS INTEGER.
{parlocales.i}
/*=================================================================================*/
/*                         INICIALIZACION DE LA EMISION                            */
/*=================================================================================*/

FIND fac_header WHERE ROWID(fac_header) = rid_fac_header EXCLUSIVE-LOCK.


FIND Punto-venta 
    WHERE Punto-venta.cdg_empresa = fac_header.cdg_empresa
      AND Punto-venta.cdg_puntovta = fac_header.prf_comprob
          NO-LOCK.

que_formulario = "CUP" + string(fac_header.prf_comprob,"9999").

RETURN que_formulario.   /* Function return value. */

END FUNCTION.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION quehorario B-table-Win 
FUNCTION quehorario RETURNS CHARACTER
  ( /* parameter-definitions */ ) :
/*------------------------------------------------------------------------------
  Purpose:  
    Notes:  
------------------------------------------------------------------------------*/
FIND cliente OF tarea NO-LOCK NO-ERROR.
IF NOT AVAILABLE cliente THEN RETURN "--".
ELSE RETURN cliente.horario_de_atencion.   

END FUNCTION.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION quiencargo B-table-Win 
FUNCTION quiencargo RETURNS CHARACTER
  ( /* parameter-definitions */ ) :
/*------------------------------------------------------------------------------
  Purpose:  debuelve quien cargo el reclamo
    Notes:  
------------------------------------------------------------------------------*/
  FIND usuario WHERE INT(tarea.cdg_usuario) = usuario.nro_usuario NO-LOCK NO-ERROR.
  IF AVAILABLE usuario THEN RETURN Usuario.cdg_usuario. 
  RETURN "SISTEMA".

END FUNCTION.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION quiencliente B-table-Win 
FUNCTION quiencliente RETURNS CHARACTER
  ( INPUT pp AS INT ) :
/*------------------------------------------------------------------------------
  Purpose:  
    Notes:  
------------------------------------------------------------------------------*/
DEFINE BUFFER bcliente FOR cliente.
IF pp = 0 THEN RETURN "---".
FIND bcliente WHERE bcliente.nro_cliente = pp NO-LOCK no-error.
    IF NOT AVAILABLE bcliente THEN RETURN "-----".

  RETURN bcliente.cdg_cliente.

END FUNCTION.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION quiennombre B-table-Win 
FUNCTION quiennombre RETURNS CHARACTER
  ( INPUT pp AS INT ) :
/*------------------------------------------------------------------------------
  Purpose:  
    Notes:  
------------------------------------------------------------------------------*/
DEFINE BUFFER bcliente FOR cliente.
IF pp = 0 THEN RETURN "---".
FIND bcliente WHERE bcliente.nro_cliente = pp NO-LOCK no-error.
IF NOT AVAILABLE bcliente THEN RETURN "------".
RETURN bcliente.nom_cliente.

END FUNCTION.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION quienrecurso B-table-Win 
FUNCTION quienrecurso RETURNS CHARACTER
  ( INPUT pp AS CHAR ) :
/*------------------------------------------------------------------------------
  Purpose:  
    Notes:  
------------------------------------------------------------------------------*/
  FIND recurso WHERE recurso.cdg_recurso = pp NO-LOCK NO-ERROR.

  RETURN IF AVAILABLE recurso THEN Recurso.nom_recurso ELSE "".

END FUNCTION.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION refresco B-table-Win 
FUNCTION refresco RETURNS LOGICAL
  ( cond AS LOGICAL ) :
/*------------------------------------------------------------------------------
  Purpose:  para y arranca el timer segun cond
    Notes:  
------------------------------------------------------------------------------*/
IF NOT VALID-HANDLE(chCtrlTimer) THEN RETURN ?.
IF NOT cond THEN ETIME(YES).
chCtrlTimer:PSTimer:ENABLED = cond.
  RETURN cond.   /* Function return value. */

END FUNCTION.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION tiene_presup B-table-Win 
FUNCTION tiene_presup RETURNS CHARACTER
  ( nro AS int ) :
/*------------------------------------------------------------------------------
  Purpose:  
    Notes:  
------------------------------------------------------------------------------*/
  DEFINE BUFFER btarea FOR tarea.
  DEFINE BUFFER bevento FOR evento.
  
  FIND bevento WHERE bevento.nro_identificacion = nro AND bevento.frealizado <> ? and
                     bevento.origen = "CONTRATO" AND
                     NOT bevento.anulado AND bevento.nro_tipo_evento = 3 NO-LOCK NO-ERROR.
  IF NOT AVAILABLE bevento THEN RETURN "Er".
  FIND FIRST btarea WHERE btarea.estado = "A" AND btarea.nro_identificacion = bevento.nro_evento AND
                          btarea.cdg_tipotarea = "P" NO-LOCK NO-ERROR.
  IF AVAILABLE btarea THEN RETURN "Si".
  RETURN "No".   /* Function return value. */

END FUNCTION.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION validaprf B-table-Win 
FUNCTION validaprf RETURNS LOGICAL
  ( prf AS INT , imp_servicio AS decimal ) :
/*------------------------------------------------------------------------------
  Purpose: validael prf del mono si no esta pasado de la categoria y los limites del mes.  
    Notes:  
------------------------------------------------------------------------------*/
    DEFINE VAR opc AS LOGICAL.
    FIND punto-venta WHERE Punto-venta.cdg_empresa = empresa.cdg_empresa and
    Punto-venta.cdg_puntovta = int(prf) NO-LOCK NO-ERROR.
    IF NOT AVAILABLE Punto-venta THEN do:
        MESSAGE "No existe el punto de venta" view-AS ALERT-BOX error.
        RETURN FALSE.
    END.
    IF Punto-venta.TP = "M" THEN DO:
        FIND acumulado_punto_venta  WHERE 
        acumulado_punto_venta.cdg_empresa = empresa.cdg_empresa AND 
        acumulado_punto_venta.periodo = YEAR(TODAY) * 100 + MONTH(TODAY) AND
        acumulado_punto_venta.cdg_puntovta = int(prf) NO-LOCK NO-ERROR.
        FIND categmono WHERE categMono.categoria = Punto-venta.categoria NO-LOCK NO-ERROR.
        IF AVAILABLE categmono AND AVAILABLE acumulado_punto_venta THEN DO:
            IF limitecuatrimestre / 4 - imp_servicio + acumulado_punto_venta.importe <=0 THEN DO:
                FIND usuario WHERE usuario.cdg_usuario = USERID("sic") NO-LOCK.
                FIND Usuario_funcion OF usuario WHERE Usuario_funcion.cdg_funcion = "EFAC" AND usuario_funcion.permiso =  "A"
                AND Usuario_funcion.cdg_empresa = empresa.cdg_empresa NO-LOCK NO-ERROR.
                IF NOT AVAILABLE Usuario_funcion THEN do:
                    MESSAGE "No puede facturar por este punto de venta" VIEW-AS ALERT-BOX ERROR.
                    RETURN false.        
                END.
                ELSE DO:
                    MESSAGE "No puede facturar por este punto de venta" skip
                    "Elija Si se utilizara este de todos modos" VIEW-AS ALERT-BOX QUESTION BUTTON YES-NO UPDATE opc.
                    RETURN opc.
                END.
            END.
        END.
    END.
    RETURN TRUE.

END FUNCTION.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

