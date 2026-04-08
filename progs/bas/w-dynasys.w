&ANALYZE-SUSPEND _VERSION-NUMBER AB_v10r12 GUI ADM2
&ANALYZE-RESUME
/* Connected Databases 
*/
&Scoped-define WINDOW-NAME wWin
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _DEFINITIONS wWin 
/*------------------------------------------------------------------------

  File: 

  Description: from cntnrwin.w - ADM SmartWindow Template

  Input Parameters:
      <none>

  Output Parameters:
      <none>

  History: New V9 Version - January 15, 1998
          
------------------------------------------------------------------------*/
/*          This .W file was created with the Progress AB.              */
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

DEFINE VARIABLE itraceEventTime AS INTEGER    NO-UNDO.
DEFINE VARIABLE iETime          AS INTEGER    NO-UNDO.
DEFINE VARIABLE lTraceEvents    AS LOGICAL NO-UNDO INITIAL NO.
DEF TEMP-TABLE osFile NO-UNDO
 FIELD cFileName AS CHAR
 FIELD cFullPath  AS CHAR
 FIELD cAttr AS CHAR
 INDEX af cAttr cFileName.

DEFINE BUFFER Submenu FOR Treemenu.
DEFINE BUFFER B-Submenu FOR Treemenu.
DEFINE BUFFER B-Empresa FOR Empresa.

{vrshared.i "NEW"}
{nrorelea.i}

DEFINE NEW SHARED VARIABLE MAIN-WINDOW  AS WIDGET-HANDLE NO-UNDO.
DEFINE NEW SHARED VARIABLE titulo       AS CHARACTER NO-UNDO.
DEFINE NEW SHARED VARIABLE titulo_ini   AS CHARACTER INITIAL "Ingreso al sistema" NO-UNDO.
DEFINE NEW SHARED VARIABLE NOM_SISTEMA  AS CHARACTER INITIAL "Solución Integrada Computel" NO-UNDO.
DEFINE VARIABLE hoy                     AS DATE INITIAL TODAY NO-UNDO.
DEFINE VARIABLE proceso                 AS CHARACTER NO-UNDO.

DEFINE VARIABLE carga_logo              AS LOGICAL INITIAL NO NO-UNDO.
DEFINE VARIABLE hubo_logon              AS LOGICAL INITIAL YES NO-UNDO.
DEFINE VARIABLE hubo_conexion           AS LOGICAL INITIAL NO NO-UNDO.
DEFINE VARIABLE puede_salir             AS LOGICAL INITIAL YES NO-UNDO.
DEFINE VARIABLE v-lista_modulos         AS CHARACTER NO-UNDO.
DEFINE VARIABLE v-cdg_modulo            LIKE Modulo-sic.cdg_sigla-sic NO-UNDO.
DEFINE VARIABLE v-btn_handle            AS WIDGET-HANDLE NO-UNDO.

DEFINE VARIABLE x0                      AS DECIMAL NO-UNDO.

{valoressalida.i}

DEFINE TEMP-TABLE tt LIKE evento
    FIELD Freminder AS DATE LABEL "Fecha"
    FIELD cdg_tipo_evento LIKE tipo_evento.cdg_tipo_evento
    FIELD direccion LIKE cliente.direccion
    FIELD nom_cliente LIKE Cliente.nom_cliente
    INDEX idx1 IS PRIMARY freminder ASCENDING fasignado ASCENDING.

DEFINE TEMP-TABLE ttipo
    FIELD cdg LIKE tarea.cdg_tipotarea COLUMN-LABEL "CDG"
    FIELD dsc LIKE Tipo_tarea.dsc_tipotarea FORMAT "X(25)"
    FIELD cant AS INT COLUMN-LABEL "Cant"
    INDEX cdg cdg .

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE SmartWindow
&Scoped-define DB-AWARE no

&Scoped-define ADM-CONTAINER WINDOW

&Scoped-define ADM-SUPPORTED-LINKS Data-Target,Data-Source,Page-Target,Update-Source,Update-Target,Filter-target,Filter-Source

/* Name of designated FRAME-NAME and/or first browse and/or first query */
&Scoped-define FRAME-NAME fContainer
&Scoped-define BROWSE-NAME BROWSE-2

/* Internal Tables (found by Frame, Query & Browse Queries)             */
&Scoped-define INTERNAL-TABLES tt ttipo

/* Definitions for BROWSE BROWSE-2                                      */
&Scoped-define FIELDS-IN-QUERY-BROWSE-2 tt.cdg_tipo_evento tt.nro_evento tt.freminder tt.FAsignado tt.Reminder tt.recursos tt.nom_cliente tt.direccion   
&Scoped-define ENABLED-FIELDS-IN-QUERY-BROWSE-2   
&Scoped-define SELF-NAME BROWSE-2
&Scoped-define OPEN-QUERY-BROWSE-2 RUN ttllena. OPEN QUERY {&SELF-NAME} FOR EACH tt.
&Scoped-define TABLES-IN-QUERY-BROWSE-2 tt
&Scoped-define FIRST-TABLE-IN-QUERY-BROWSE-2 tt


/* Definitions for BROWSE BROWSE-4                                      */
&Scoped-define FIELDS-IN-QUERY-BROWSE-4 ttipo.cdg ttipo.dsc ttipo.cant   
&Scoped-define ENABLED-FIELDS-IN-QUERY-BROWSE-4   
&Scoped-define SELF-NAME BROWSE-4
&Scoped-define QUERY-STRING-BROWSE-4 FOR EACH ttipo
&Scoped-define OPEN-QUERY-BROWSE-4 OPEN QUERY {&SELF-NAME} FOR EACH ttipo.
&Scoped-define TABLES-IN-QUERY-BROWSE-4 ttipo
&Scoped-define FIRST-TABLE-IN-QUERY-BROWSE-4 ttipo


/* Definitions for FRAME fContainer                                     */
&Scoped-define OPEN-BROWSERS-IN-QUERY-fContainer ~
    ~{&OPEN-QUERY-BROWSE-2}~
    ~{&OPEN-QUERY-BROWSE-4}

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS BTN-MENU tptareas BCRM ttareas BROWSE-4 ~
BUTTON-refresh bevdet-2 btn_APM tsasig v-accion bevdet fbatch BUTTON-8 ~
c_nro_tipo_evento v-desde v-nom_cliente v-operario v-direccion BROWSE-2 ~
btn_RGV btn_TQM btn_ABA btn_ADP btn_AFI btn_BDU btn_COM btn_CPS btn_CPY ~
btn_CXC btn_CXP btn_DSP btn_FAC btn_GLA btn_INV btn_PRD btn_TES btn_UTL ~
btn_SALIR btn_acerca btn_ayuda btn_clave btn_empresa btn_login ~
btn_verconexion 
&Scoped-Define DISPLAYED-OBJECTS v-nom_modulo v-cdg_empresa tptareas ~
ttareas tsasig v-accion fbatch c_nro_tipo_evento v-desde v-nom_cliente ~
v-operario v-direccion 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */
&Scoped-define List-1 btn_APM btn_RGV btn_TQM btn_ABA btn_ADP btn_AFI ~
btn_BDU btn_COM btn_CPS btn_CPY btn_CXC btn_CXP btn_DSP btn_FAC btn_GLA ~
btn_INV btn_PRD btn_TES btn_UTL 

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME


/* ************************  Function Prototypes ********************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION-FORWARD AddtoEdMsg wWin 
FUNCTION AddtoEdMsg RETURNS LOGICAL
  (pcTxt AS CHAR)  FORWARD.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION-FORWARD durmiendo wWin 
FUNCTION durmiendo RETURNS INTEGER
  ( /* parameter-definitions */ )  FORWARD.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


/* ***********************  Control Definitions  ********************** */

/* Define the widget handle for the window                              */
DEFINE VAR wWin AS WIDGET-HANDLE NO-UNDO.

/* Definitions of handles for SmartObjects                              */
DEFINE VARIABLE h_pure4gltv AS HANDLE NO-UNDO.
DEFINE VARIABLE h_sfavoritos AS HANDLE NO-UNDO.

/* Definitions of the field level widgets                               */
DEFINE BUTTON BCRM 
     LABEL "CRM" 
     SIZE 9 BY 3.

DEFINE BUTTON bevdet 
     LABEL "Vecinos" 
     SIZE 9 BY 1.19.

DEFINE BUTTON bevdet-2 
     LABEL "Detalle" 
     SIZE 9 BY 1.19.

DEFINE BUTTON BTN-MENU 
     LABEL "MENU" 
     SIZE 9 BY 1.

DEFINE BUTTON btn_ABA  NO-FOCUS
     LABEL "&Abastecimientos" 
     SIZE 30 BY 1.1
     FONT 6.

DEFINE BUTTON btn_acerca 
     IMAGE-UP FILE "iconos24/about.jpg":U NO-FOCUS FLAT-BUTTON NO-CONVERT-3D-COLORS
     LABEL "Acerca" 
     SIZE 5.4 BY 1.29 TOOLTIP "Acerca de Dynasys".

DEFINE BUTTON btn_ADP  NO-FOCUS
     LABEL "P&ersonal" 
     SIZE 30 BY 1.1
     FONT 6.

DEFINE BUTTON btn_AFI  NO-FOCUS
     LABEL "&Servicios" 
     SIZE 30 BY 1.1
     FONT 6.

DEFINE BUTTON btn_APM  NO-FOCUS
     LABEL "APM" 
     SIZE 30 BY 1.1
     FONT 6.

DEFINE BUTTON btn_ayuda 
     IMAGE-UP FILE "iconos24/help2.jpg":U NO-FOCUS FLAT-BUTTON NO-CONVERT-3D-COLORS
     LABEL "Ayuda" 
     SIZE 5.4 BY 1.29 TOOLTIP "Ayuda".

DEFINE BUTTON btn_BDU  NO-FOCUS
     LABEL "&Bienes de Uso" 
     SIZE 30 BY 1.1
     FONT 6.

DEFINE BUTTON btn_clave 
     IMAGE-UP FILE "iconos24/key1.jpg":U NO-FOCUS FLAT-BUTTON NO-CONVERT-3D-COLORS
     LABEL "Clave" 
     SIZE 5.4 BY 1.29 TOOLTIP "Cambio de Clave - Credenciales".

DEFINE BUTTON btn_COM  NO-FOCUS
     LABEL "&Compras" 
     SIZE 30 BY 1.1
     FONT 6.

DEFINE BUTTON btn_CPS  NO-FOCUS
     LABEL "Pre&supuesto" 
     SIZE 30 BY 1.1
     FONT 6.

DEFINE BUTTON btn_CPY  NO-FOCUS
     LABEL "Pro&yectos" 
     SIZE 30 BY 1.1
     FONT 6.

DEFINE BUTTON btn_CXC  NO-FOCUS
     LABEL "&Cuentas X Cobrar" 
     SIZE 30 BY 1.1
     FONT 6.

DEFINE BUTTON btn_CXP  NO-FOCUS
     LABEL "C&uentas X Pagar" 
     SIZE 30 BY 1.1
     FONT 6.

DEFINE BUTTON btn_DSP  NO-FOCUS
     LABEL "Despac&ho" 
     SIZE 30 BY 1.1
     FONT 6.

DEFINE BUTTON btn_empresa 
     IMAGE-UP FILE "iconos24/home.jpg":U NO-FOCUS FLAT-BUTTON NO-CONVERT-3D-COLORS
     LABEL "Empresa" 
     SIZE 5.4 BY 1.29 TOOLTIP "Empresa en Uso".

DEFINE BUTTON btn_FAC  NO-FOCUS
     LABEL "&Facturación" 
     SIZE 30 BY 1.1
     FONT 6.

DEFINE BUTTON btn_GLA  NO-FOCUS
     LABEL "Conta&bilidad" 
     SIZE 30 BY 1.1
     FONT 6.

DEFINE BUTTON btn_INV  NO-FOCUS
     LABEL "&Inventario" 
     SIZE 30 BY 1.1
     FONT 6.

DEFINE BUTTON btn_login 
     IMAGE-UP FILE "iconos24/id_card.jpg":U NO-FOCUS FLAT-BUTTON NO-CONVERT-3D-COLORS
     LABEL "Login" 
     SIZE 5.4 BY 1.29 TOOLTIP "Login - Identificacion".

DEFINE BUTTON btn_PRD  NO-FOCUS
     LABEL "&Producción" 
     SIZE 30 BY 1.1
     FONT 6.

DEFINE BUTTON btn_RGV  NO-FOCUS
     LABEL "&Rendición de Gastos" 
     SIZE 30 BY 1.1
     FONT 6.

DEFINE BUTTON btn_SALIR 
     IMAGE-UP FILE "iconos24/error.jpg":U NO-FOCUS FLAT-BUTTON
     LABEL "Salir" 
     SIZE 5.4 BY 1.29 TOOLTIP "Salir".

DEFINE BUTTON btn_TES  NO-FOCUS
     LABEL "&Tesorería" 
     SIZE 30 BY 1.1
     FONT 6.

DEFINE BUTTON btn_TQM  NO-FOCUS
     LABEL "&Gestión de Calidad" 
     SIZE 30 BY 1.1
     FONT 6.

DEFINE BUTTON btn_UTL  NO-FOCUS
     LABEL "Uti&lidades" 
     SIZE 30 BY 1.1
     FONT 6.

DEFINE BUTTON btn_verconexion 
     IMAGE-UP FILE "iconos24/client_network.jpg":U NO-FOCUS FLAT-BUTTON NO-CONVERT-3D-COLORS
     LABEL "Conexión" 
     SIZE 5.4 BY 1.29.

DEFINE BUTTON BUTTON-8 
     IMAGE-UP FILE "img/excel.gif":U
     LABEL "Button 8" 
     SIZE 6 BY 1.14.

DEFINE BUTTON BUTTON-refresh 
     LABEL "Syn" 
     SIZE 5 BY 5.71.

DEFINE VARIABLE c_nro_tipo_evento AS INTEGER FORMAT "->>>>>>>>9" INITIAL 0 
     LABEL "Tipo" 
     VIEW-AS COMBO-BOX INNER-LINES 5
     LIST-ITEM-PAIRS "0",1
     DROP-DOWN-LIST
     SIZE 12 BY 1 TOOLTIP "Tipo de Restriccion o Tipo de Evento"
     BGCOLOR 14 FGCOLOR 0 .

DEFINE VARIABLE v-cdg_empresa AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS COMBO-BOX INNER-LINES 5
     LIST-ITEM-PAIRS "Item 1","Item 1"
     DROP-DOWN-LIST
     SIZE 40 BY 1
     BGCOLOR 15 FGCOLOR 9 FONT 4 NO-UNDO.

DEFINE VARIABLE v-accion AS CHARACTER 
     VIEW-AS EDITOR SCROLLBAR-VERTICAL
     SIZE 70 BY 1.43
     BGCOLOR 15 FGCOLOR 9  NO-UNDO.

DEFINE VARIABLE fbatch AS INTEGER FORMAT "->,>>>,>>9":U INITIAL 0 
     LABEL "Email pendientes" 
     VIEW-AS FILL-IN 
     SIZE 14 BY 1 NO-UNDO.

DEFINE VARIABLE tptareas AS INTEGER FORMAT ">>>9":U INITIAL 0 
     LABEL "Tareas propias" 
     VIEW-AS FILL-IN 
     SIZE 22 BY 1.67
     FONT 11 NO-UNDO.

DEFINE VARIABLE tsasig AS INTEGER FORMAT ">>>9":U INITIAL 0 
     LABEL "Evento sin Asig" 
     VIEW-AS FILL-IN 
     SIZE 22 BY 1.43
     FONT 11 NO-UNDO.

DEFINE VARIABLE ttareas AS INTEGER FORMAT ">>>9":U INITIAL 0 
     LABEL "Total Tareas" 
     VIEW-AS FILL-IN 
     SIZE 22 BY 1.48
     FONT 11 NO-UNDO.

DEFINE VARIABLE v-desde AS DATE FORMAT "99/99/9999":U 
     LABEL "Desde" 
     VIEW-AS FILL-IN 
     SIZE 18 BY 1
     BGCOLOR 14 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE v-direccion AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 123 BY .95
     BGCOLOR 11 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE v-nom_cliente AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 57 BY 1
     BGCOLOR 11  NO-UNDO.

DEFINE VARIABLE v-nom_modulo AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 64 BY 1
     BGCOLOR 9 FGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE v-operario AS CHARACTER FORMAT "X(256)":U 
     LABEL "" 
     VIEW-AS FILL-IN 
     SIZE 14 BY 1
     BGCOLOR 11 FGCOLOR 0  NO-UNDO.

/* Query definitions                                                    */
&ANALYZE-SUSPEND
DEFINE QUERY BROWSE-2 FOR 
      tt SCROLLING.

DEFINE QUERY BROWSE-4 FOR 
      ttipo SCROLLING.
&ANALYZE-RESUME

/* Browse definitions                                                   */
DEFINE BROWSE BROWSE-2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS BROWSE-2 wWin _FREEFORM
  QUERY BROWSE-2 NO-LOCK DISPLAY
      tt.cdg_tipo_evento
      tt.nro_evento FORMAT ">>>>>>>9":U
      tt.freminder FORMAT "99/99/9999":U
      tt.FAsignado FORMAT "99/99/9999":U
      tt.Reminder FORMAT "x(200)":U
      tt.recursos
      tt.nom_cliente FORMAT "X(50)"
      tt.direccion FORMAT "X(50)"
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ROW-MARKERS SEPARATORS MULTIPLE SIZE 123 BY 6.19 ROW-HEIGHT-CHARS .61 FIT-LAST-COLUMN.

DEFINE BROWSE BROWSE-4
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS BROWSE-4 wWin _FREEFORM
  QUERY BROWSE-4 DISPLAY
      ttipo.cdg
 ttipo.dsc
 ttipo.cant
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ROW-MARKERS SEPARATORS SIZE 44 BY 5.71 ROW-HEIGHT-CHARS .61 FIT-LAST-COLUMN.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME fContainer
     v-nom_modulo AT ROW 1.48 COL 33 COLON-ALIGNED NO-LABEL WIDGET-ID 58
     BTN-MENU AT ROW 1.48 COL 100 WIDGET-ID 82
     v-cdg_empresa AT ROW 1.48 COL 108 COLON-ALIGNED NO-LABEL WIDGET-ID 12
     tptareas AT ROW 4.81 COL 121 COLON-ALIGNED WIDGET-ID 2
     BCRM AT ROW 4.91 COL 146.2 WIDGET-ID 104
     ttareas AT ROW 6.48 COL 121 COLON-ALIGNED WIDGET-ID 4
     BROWSE-4 AT ROW 8.14 COL 107 WIDGET-ID 300
     BUTTON-refresh AT ROW 8.14 COL 152 WIDGET-ID 114
     bevdet-2 AT ROW 14.1 COL 147 WIDGET-ID 116
     btn_APM AT ROW 24.1 COL 3 WIDGET-ID 88
     tsasig AT ROW 14.14 COL 122 COLON-ALIGNED WIDGET-ID 108
     v-accion AT ROW 15.29 COL 35 NO-LABEL WIDGET-ID 6
     bevdet AT ROW 15.52 COL 147.4 WIDGET-ID 110
     fbatch AT ROW 15.71 COL 122 COLON-ALIGNED WIDGET-ID 112
     BUTTON-8 AT ROW 16.71 COL 79 WIDGET-ID 96
     c_nro_tipo_evento AT ROW 16.86 COL 38 COLON-ALIGNED WIDGET-ID 90
     v-desde AT ROW 16.86 COL 57.8 COLON-ALIGNED WIDGET-ID 94
     v-nom_cliente AT ROW 16.86 COL 84 COLON-ALIGNED NO-LABEL WIDGET-ID 100
     v-operario AT ROW 16.86 COL 142 COLON-ALIGNED WIDGET-ID 102
     v-direccion AT ROW 17.95 COL 33 COLON-ALIGNED NO-LABEL WIDGET-ID 98
     BROWSE-2 AT ROW 19.1 COL 35 WIDGET-ID 200
     btn_RGV AT ROW 9.81 COL 3 WIDGET-ID 50
     btn_TQM AT ROW 21.71 COL 3 WIDGET-ID 84
     btn_ABA AT ROW 2.67 COL 3 WIDGET-ID 16
     btn_ADP AT ROW 19.33 COL 3 WIDGET-ID 18
     btn_AFI AT ROW 12.19 COL 3 WIDGET-ID 20
     btn_BDU AT ROW 6.24 COL 3 WIDGET-ID 22
     btn_COM AT ROW 7.43 COL 3 WIDGET-ID 24
     btn_CPS AT ROW 16.95 COL 3 WIDGET-ID 26
     btn_CPY AT ROW 20.52 COL 3 WIDGET-ID 28
     btn_CXC AT ROW 14.57 COL 3 WIDGET-ID 30
     btn_CXP AT ROW 8.62 COL 3 WIDGET-ID 32
     btn_DSP AT ROW 11 COL 3 WIDGET-ID 36
     btn_FAC AT ROW 13.38 COL 3 WIDGET-ID 40
     btn_GLA AT ROW 15.76 COL 3 WIDGET-ID 42
     btn_INV AT ROW 3.86 COL 3 WIDGET-ID 46
     btn_PRD AT ROW 5.05 COL 3 WIDGET-ID 48
     btn_TES AT ROW 18.14 COL 3 WIDGET-ID 52
     btn_UTL AT ROW 22.91 COL 3 WIDGET-ID 54
     btn_SALIR AT ROW 1.14 COL 152.8 WIDGET-ID 64
     btn_acerca AT ROW 1.24 COL 28 WIDGET-ID 80
     btn_ayuda AT ROW 1.24 COL 23 WIDGET-ID 78
     btn_clave AT ROW 1.24 COL 13.2 WIDGET-ID 74
     btn_empresa AT ROW 1.24 COL 8 WIDGET-ID 72
     btn_login AT ROW 1.24 COL 18 WIDGET-ID 76
     btn_verconexion AT ROW 1.24 COL 2.8 WIDGET-ID 66
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1.2 ROW 1
         SIZE 164.8 BY 28.95.


/* *********************** Procedure Settings ************************ */

&ANALYZE-SUSPEND _PROCEDURE-SETTINGS
/* Settings for THIS-PROCEDURE
   Type: SmartWindow
   Allow: Basic,Browse,DB-Fields,Query,Smart,Window
   Container Links: Data-Target,Data-Source,Page-Target,Update-Source,Update-Target,Filter-target,Filter-Source
   Other Settings: COMPILE
 */
&ANALYZE-RESUME _END-PROCEDURE-SETTINGS

/* *************************  Create Window  ************************** */

&ANALYZE-SUSPEND _CREATE-WINDOW
IF SESSION:DISPLAY-TYPE = "GUI":U THEN
  CREATE WINDOW wWin ASSIGN
         HIDDEN             = YES
         TITLE              = "Dynasys Rel. 10"
         HEIGHT             = 24.62
         WIDTH              = 158
         MAX-HEIGHT         = 35.24
         MAX-WIDTH          = 256
         VIRTUAL-HEIGHT     = 35.24
         VIRTUAL-WIDTH      = 256
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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _INCLUDED-LIB wWin 
/* ************************* Included-Libraries *********************** */

{getmenu4gl.i}
{src/adm2/containr.i}
{excel-export.i}

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME




/* ***********  Runtime Attributes and AppBuilder Settings  *********** */

&ANALYZE-SUSPEND _RUN-TIME-ATTRIBUTES
/* SETTINGS FOR WINDOW wWin
  VISIBLE,,RUN-PERSISTENT                                               */
/* SETTINGS FOR FRAME fContainer
   FRAME-NAME                                                           */
/* BROWSE-TAB BROWSE-4 ttareas fContainer */
/* BROWSE-TAB BROWSE-2 v-direccion fContainer */
/* SETTINGS FOR BUTTON btn_ABA IN FRAME fContainer
   1                                                                    */
ASSIGN 
       btn_ABA:PRIVATE-DATA IN FRAME fContainer     = 
                "ABA".

/* SETTINGS FOR BUTTON btn_ADP IN FRAME fContainer
   1                                                                    */
ASSIGN 
       btn_ADP:PRIVATE-DATA IN FRAME fContainer     = 
                "ADP".

/* SETTINGS FOR BUTTON btn_AFI IN FRAME fContainer
   1                                                                    */
ASSIGN 
       btn_AFI:PRIVATE-DATA IN FRAME fContainer     = 
                "AFI".

/* SETTINGS FOR BUTTON btn_APM IN FRAME fContainer
   1                                                                    */
ASSIGN 
       btn_APM:PRIVATE-DATA IN FRAME fContainer     = 
                "APM".

/* SETTINGS FOR BUTTON btn_BDU IN FRAME fContainer
   1                                                                    */
ASSIGN 
       btn_BDU:PRIVATE-DATA IN FRAME fContainer     = 
                "BDU".

/* SETTINGS FOR BUTTON btn_COM IN FRAME fContainer
   1                                                                    */
ASSIGN 
       btn_COM:PRIVATE-DATA IN FRAME fContainer     = 
                "COM".

/* SETTINGS FOR BUTTON btn_CPS IN FRAME fContainer
   1                                                                    */
ASSIGN 
       btn_CPS:PRIVATE-DATA IN FRAME fContainer     = 
                "CPS".

/* SETTINGS FOR BUTTON btn_CPY IN FRAME fContainer
   1                                                                    */
ASSIGN 
       btn_CPY:PRIVATE-DATA IN FRAME fContainer     = 
                "CPY".

/* SETTINGS FOR BUTTON btn_CXC IN FRAME fContainer
   1                                                                    */
ASSIGN 
       btn_CXC:PRIVATE-DATA IN FRAME fContainer     = 
                "CXC".

/* SETTINGS FOR BUTTON btn_CXP IN FRAME fContainer
   1                                                                    */
ASSIGN 
       btn_CXP:PRIVATE-DATA IN FRAME fContainer     = 
                "CXP".

/* SETTINGS FOR BUTTON btn_DSP IN FRAME fContainer
   1                                                                    */
ASSIGN 
       btn_DSP:PRIVATE-DATA IN FRAME fContainer     = 
                "DSP".

/* SETTINGS FOR BUTTON btn_FAC IN FRAME fContainer
   1                                                                    */
ASSIGN 
       btn_FAC:PRIVATE-DATA IN FRAME fContainer     = 
                "FAC".

/* SETTINGS FOR BUTTON btn_GLA IN FRAME fContainer
   1                                                                    */
ASSIGN 
       btn_GLA:PRIVATE-DATA IN FRAME fContainer     = 
                "GLA".

/* SETTINGS FOR BUTTON btn_INV IN FRAME fContainer
   1                                                                    */
ASSIGN 
       btn_INV:PRIVATE-DATA IN FRAME fContainer     = 
                "INV".

/* SETTINGS FOR BUTTON btn_PRD IN FRAME fContainer
   1                                                                    */
ASSIGN 
       btn_PRD:PRIVATE-DATA IN FRAME fContainer     = 
                "PRD".

/* SETTINGS FOR BUTTON btn_RGV IN FRAME fContainer
   1                                                                    */
ASSIGN 
       btn_RGV:PRIVATE-DATA IN FRAME fContainer     = 
                "RGV".

/* SETTINGS FOR BUTTON btn_TES IN FRAME fContainer
   1                                                                    */
ASSIGN 
       btn_TES:PRIVATE-DATA IN FRAME fContainer     = 
                "TES".

/* SETTINGS FOR BUTTON btn_TQM IN FRAME fContainer
   1                                                                    */
ASSIGN 
       btn_TQM:PRIVATE-DATA IN FRAME fContainer     = 
                "TQM".

/* SETTINGS FOR BUTTON btn_UTL IN FRAME fContainer
   1                                                                    */
ASSIGN 
       btn_UTL:PRIVATE-DATA IN FRAME fContainer     = 
                "UTL".

ASSIGN 
       v-accion:READ-ONLY IN FRAME fContainer        = TRUE.

/* SETTINGS FOR COMBO-BOX v-cdg_empresa IN FRAME fContainer
   NO-ENABLE                                                            */
ASSIGN 
       v-direccion:READ-ONLY IN FRAME fContainer        = TRUE.

ASSIGN 
       v-nom_cliente:READ-ONLY IN FRAME fContainer        = TRUE.

/* SETTINGS FOR FILL-IN v-nom_modulo IN FRAME fContainer
   NO-ENABLE                                                            */
IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(wWin)
THEN wWin:HIDDEN = yes.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME


/* Setting information for Queries and Browse Widgets fields            */

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE BROWSE-2
/* Query rebuild information for BROWSE BROWSE-2
     _START_FREEFORM
RUN ttllena.
OPEN QUERY {&SELF-NAME} FOR EACH tt.
     _END_FREEFORM
     _Options          = "NO-LOCK INDEXED-REPOSITION"
     _Query            is OPENED
*/  /* BROWSE BROWSE-2 */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE BROWSE-4
/* Query rebuild information for BROWSE BROWSE-4
     _START_FREEFORM
OPEN QUERY {&SELF-NAME} FOR EACH ttipo.
     _END_FREEFORM
     _Query            is OPENED
*/  /* BROWSE BROWSE-4 */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME wWin
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL wWin wWin
ON END-ERROR OF wWin /* Dynasys Rel. 10 */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
DEFINE VAR rok AS LOGICAL NO-UNDO.
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF puede_salir
  THEN DO:
        MESSAGE "Desea salir de la aplicacion" VIEW-AS ALERT-BOX BUTTONS YES-NO SET rok.
        IF NOT rok THEN RETURN NO-APPLY.
        RUN limpiar_sesion.
        APPLY "CLOSE":U TO THIS-PROCEDURE.
        RETURN NO-APPLY.
  END.
  ELSE DO:
        MESSAGE "No puede abandonar el sistema porque hay un módulo ejecutándose"
                VIEW-AS ALERT-BOX ERROR.
        RETURN NO-APPLY.
  END.
  
 /* IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.*/
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL wWin wWin
ON WINDOW-CLOSE OF wWin /* Dynasys Rel. 10 */
DO:
  /* This ADM code must be left here in order for the SmartWindow
     and its descendents to terminate properly on exit. */
  IF puede_salir
  THEN DO:
        RUN limpiar_sesion.
        APPLY "CLOSE":U TO THIS-PROCEDURE.
        RETURN NO-APPLY.
  END.
  ELSE DO:
        MESSAGE "No puede abandonar el sistema porque hay un módulo ejecutándose"
                VIEW-AS ALERT-BOX ERROR.
        RETURN NO-APPLY.
  END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL wWin wWin
ON WINDOW-RESIZED OF wWin /* Dynasys Rel. 10 */
DO: /*
  DEFINE VARIABLE iHorizontalGap  AS DEC    NO-UNDO.
  DEFINE VARIABLE iVerticalGap    AS DEC    NO-UNDO.
  DEFINE VARIABLE iTvWidth        AS DEC    NO-UNDO.
  DEFINE VARIABLE lresizeVertical AS LOGICAL    NO-UNDO.
  DEFINE VARIABLE lresizeHorizontal AS LOGICAL    NO-UNDO.
  
  
  {get resizeVertical lresizeVertical h_pure4glTv}.
  IF lresizeVertical = ? THEN lresizeVertical = YES.
  {get resizeHorizontal lresizeHorizontal h_pure4glTv}.
  IF lresizeHorizontal = ? THEN lresizeHorizontal = YES.
  
  iTvWidth = FRAME fMain:COL - 1.7.

  iVerticalGap = SELF:HEIGHT-CHAR - FRAME fContainer:HEIGHT-CHARS.
  iHorizontalGap = SELF:WIDTH-CHAR - FRAME fContainer:WIDTH-CHARS.
  
  IF iVerticalGap > 0 THEN ASSIGN
   FRAME fContainer:HEIGHT-CHARS = SELF:HEIGHT-CHAR
   FRAME fMain:HEIGHT-CHARS = SELF:HEIGHT-CHAR
  /* edMsg:HEIGHT-CHARS = SELF:HEIGHT-CHARS - 0.2 - edMsg:ROW + 1*/ .
  
  IF iHorizontalGap > 0 THEN ASSIGN
   FRAME fContainer:WIDTH-CHARS = SELF:WIDTH-CHAR
   FRAME fMain:COL = FRAME fMain:COL + iHorizontalGap.
  
  RUN resizeObject IN h_pure4glTv
    (IF lresizeVertical THEN SELF:HEIGHT-CHARS - 0.2 ELSE ?
    ,IF lresizeHorizontal THEN iTVWidth + iHorizontalGap ELSE ?).

  IF iVerticalGap < 0 THEN ASSIGN
   /*edMsg:HEIGHT-CHARS = SELF:HEIGHT-CHARS - 0.2 - edMsg:ROW + 1*/
   FRAME fMain:HEIGHT-CHARS = SELF:HEIGHT-CHAR
   FRAME fContainer:HEIGHT-CHARS = SELF:HEIGHT-CHAR.

  IF iHorizontalGap < 0 THEN ASSIGN
   FRAME fMain:COL = FRAME fMain:COL + iHorizontalGap
   FRAME fContainer:WIDTH-CHARS = SELF:WIDTH-CHAR.

   
   /* no scrollbar when shrinking please */
   FRAME fMain:VIRTUAL-HEIGHT-CHARS = FRAME fMain:HEIGHT-CHARS.
   FRAME fMain:VIRTUAL-WIDTH-CHARS = FRAME fMain:WIDTH-CHARS.
   FRAME fContainer:VIRTUAL-HEIGHT-CHARS = SELF:HEIGHT-CHAR.
   FRAME fContainer:VIRTUAL-WIDTH-CHARS = SELF:WIDTH-CHAR.
   */
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME BCRM
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL BCRM wWin
ON CHOOSE OF BCRM IN FRAME fContainer /* CRM */
DO:
  RUN w-tareas-red.w.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bevdet
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bevdet wWin
ON CHOOSE OF bevdet IN FRAME fContainer /* Vecinos */
DO:
  /*RUN w-eventossinasig.w.*/
  RUN w-geoeventos.w.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bevdet wWin
ON MOUSE-MENU-DOWN OF bevdet IN FRAME fContainer /* Vecinos */
DO:
  RUN w-eventossinasig.w.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bevdet-2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bevdet-2 wWin
ON CHOOSE OF bevdet-2 IN FRAME fContainer /* Detalle */
DO:
  RUN w-eventossinasig.w.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bevdet-2 wWin
ON MOUSE-MENU-DOWN OF bevdet-2 IN FRAME fContainer /* Detalle */
DO:
  RUN w-eventossinasig.w.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define BROWSE-NAME BROWSE-2
&Scoped-define SELF-NAME BROWSE-2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL BROWSE-2 wWin
ON VALUE-CHANGED OF BROWSE-2 IN FRAME fContainer
DO:
  v-direccion:SCREEN-VALUE = tt.direccion.
  v-nom_cliente:SCREEN-VALUE = tt.nom_cliente.
  v-operario:SCREEN-VALUE = STRING(tt.recursos).
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME BTN-MENU
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL BTN-MENU wWin
ON CHOOSE OF BTN-MENU IN FRAME fContainer /* MENU */
DO:
  RUN w-abmtreemenu.w.
  RUN emptyTree IN h_pure4gltv.  
  RUN carga_menu_modulo.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btn_ABA
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btn_ABA wWin
ON CHOOSE OF btn_ABA IN FRAME fContainer /* Abastecimientos */
DO:
  RUN cambiar_menu.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btn_acerca
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btn_acerca wWin
ON CHOOSE OF btn_acerca IN FRAME fContainer /* Acerca */
DO:
 /* RUN d-acerca_dynasys.w. */
    RUN w-reminder.w.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btn_ADP
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btn_ADP wWin
ON CHOOSE OF btn_ADP IN FRAME fContainer /* Personal */
DO:
  RUN cambiar_menu.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btn_AFI
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btn_AFI wWin
ON CHOOSE OF btn_AFI IN FRAME fContainer /* Servicios */
DO:
  RUN cambiar_menu.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btn_APM
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btn_APM wWin
ON CHOOSE OF btn_APM IN FRAME fContainer /* APM */
DO:
  RUN cambiar_menu.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btn_ayuda
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btn_ayuda wWin
ON CHOOSE OF btn_ayuda IN FRAME fContainer /* Ayuda */
DO:
  RUN mostrar_ayuda.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btn_BDU
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btn_BDU wWin
ON CHOOSE OF btn_BDU IN FRAME fContainer /* Bienes de Uso */
DO:
  RUN cambiar_menu.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btn_clave
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btn_clave wWin
ON CHOOSE OF btn_clave IN FRAME fContainer /* Clave */
DO:
  DEFINE VARIABLE v-ok AS LOGICAL.
  RUN d-asignar_clave.w (OUTPUT v-ok).  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btn_COM
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btn_COM wWin
ON CHOOSE OF btn_COM IN FRAME fContainer /* Compras */
DO:
  RUN cambiar_menu.  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btn_CPS
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btn_CPS wWin
ON CHOOSE OF btn_CPS IN FRAME fContainer /* Presupuesto */
DO:
  RUN cambiar_menu.  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btn_CPY
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btn_CPY wWin
ON CHOOSE OF btn_CPY IN FRAME fContainer /* Proyectos */
DO:
  RUN cambiar_menu.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btn_CXC
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btn_CXC wWin
ON CHOOSE OF btn_CXC IN FRAME fContainer /* Cuentas X Cobrar */
DO:
  RUN cambiar_menu.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btn_CXP
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btn_CXP wWin
ON CHOOSE OF btn_CXP IN FRAME fContainer /* Cuentas X Pagar */
DO:
  RUN cambiar_menu.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btn_DSP
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btn_DSP wWin
ON CHOOSE OF btn_DSP IN FRAME fContainer /* Despacho */
DO:
  RUN cambiar_menu.  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btn_empresa
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btn_empresa wWin
ON CHOOSE OF btn_empresa IN FRAME fContainer /* Empresa */
DO:
    RUN d-ver-datos-empresa.w.
    RUN verpermiso.p ( OUTPUT cod_aut ).
    RUN poner_sesion ( INPUT cod_aut = 0, INPUT {&WINDOW-NAME}:TITLE).
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btn_FAC
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btn_FAC wWin
ON CHOOSE OF btn_FAC IN FRAME fContainer /* Facturación */
DO:
  RUN cambiar_menu.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btn_GLA
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btn_GLA wWin
ON CHOOSE OF btn_GLA IN FRAME fContainer /* Contabilidad */
DO:
  RUN cambiar_menu.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btn_INV
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btn_INV wWin
ON CHOOSE OF btn_INV IN FRAME fContainer /* Inventario */
DO:
  RUN cambiar_menu.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btn_login
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btn_login wWin
ON CHOOSE OF btn_login IN FRAME fContainer /* Login */
DO:
  RUN conectar_ambiente ( OUTPUT hubo_logon ).
  IF NOT hubo_logon THEN QUIT.
    RUN emptyTree IN h_pure4gltv.  
    RUN levantar_ambiente.
END.
/*  RUN armar_titulo ( OUTPUT titulo ).
  RUN poner_sesion ( hubo_logon, INPUT titulo ).*/

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btn_PRD
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btn_PRD wWin
ON CHOOSE OF btn_PRD IN FRAME fContainer /* Producción */
DO:
  RUN cambiar_menu.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btn_RGV
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btn_RGV wWin
ON CHOOSE OF btn_RGV IN FRAME fContainer /* Rendición de Gastos */
DO:
  RUN cambiar_menu.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btn_SALIR
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btn_SALIR wWin
ON CHOOSE OF btn_SALIR IN FRAME fContainer /* Salir */
DO:
  IF puede_salir
  THEN DO:
        RUN limpiar_sesion.
        APPLY "CLOSE":U TO THIS-PROCEDURE.
        RETURN NO-APPLY.
  END.
  ELSE DO:
        MESSAGE "No puede abandonar el sistema porque hay un módulo ejecutándose"
                VIEW-AS ALERT-BOX ERROR.
        RETURN NO-APPLY.

  END.  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btn_TES
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btn_TES wWin
ON CHOOSE OF btn_TES IN FRAME fContainer /* Tesorería */
DO:
  RUN cambiar_menu.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btn_TQM
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btn_TQM wWin
ON CHOOSE OF btn_TQM IN FRAME fContainer /* Gestión de Calidad */
DO:
  RUN cambiar_menu.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btn_UTL
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btn_UTL wWin
ON CHOOSE OF btn_UTL IN FRAME fContainer /* Utilidades */
DO:
  RUN cambiar_menu.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btn_verconexion
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btn_verconexion wWin
ON CHOOSE OF btn_verconexion IN FRAME fContainer /* Conexión */
DO:
  RUN d-verconect.w.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME BUTTON-8
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL BUTTON-8 wWin
ON CHOOSE OF BUTTON-8 IN FRAME fContainer /* Button 8 */
DO:
  run excel-export ( browse-2:HANDLE ).
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME BUTTON-refresh
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL BUTTON-refresh wWin
ON CHOOSE OF BUTTON-refresh IN FRAME fContainer /* Syn */
DO:
  RUN viewObject.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME c_nro_tipo_evento
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL c_nro_tipo_evento wWin
ON VALUE-CHANGED OF c_nro_tipo_evento IN FRAME fContainer /* Tipo */
DO:
  ASSIGN {&self-name}.
  {&OPEN-QUERY-{&BROWSE-NAME}}
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME v-cdg_empresa
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-cdg_empresa wWin
ON VALUE-CHANGED OF v-cdg_empresa IN FRAME fContainer
DO:
    ASSIGN v-cdg_empresa.
    RUN emptyTree IN h_pure4gltv.  
    DO TRANSACTION:
        FIND Usuario WHERE Usuario.cdg_usuario = USERID("sic") EXCLUSIVE-LOCK.
        Usuario.cdg_empresa = v-cdg_empresa.
        RELEASE Usuario.
    END.
    RUN levantar_ambiente.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME v-desde
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-desde wWin
ON LEAVE OF v-desde IN FRAME fContainer /* Desde */
DO:
  ASSIGN {&SELF-NAME}.
  {&OPEN-QUERY-{&BROWSE-NAME}}
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-desde wWin
ON MOUSE-MENU-DOWN OF v-desde IN FRAME fContainer /* Desde */
DO:
  {selfecha.i}
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&UNDEFINE SELF-NAME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _MAIN-BLOCK wWin 


/* ***************************  Main Block  *************************** */


/* Include custom  Main Block code for SmartWindows. */
{src/adm2/windowmn.i}


/*   This was a bad idea to run a test instance persistently form protools/run
 so I could interact with it.  when running the window directly form the AppBuilder
 I was initializing the window and smartTV twice, resulting in 2 sets of widgets
 for the scrollbar....
  It is better to use runit.w from protools/run with persistent option.  This 
 last guy will take care of initializeing the window.
  
    Anyway, I have added a protection to not call initializeObject twice in the
     4GLTreeview object 
RUN initializeObject.
  */

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


/* **********************  Internal Procedures  *********************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE adm-create-objects wWin  _ADM-CREATE-OBJECTS
PROCEDURE adm-create-objects :
/*------------------------------------------------------------------------------
  Purpose:     Create handles for all SmartObjects used in this procedure.
               After SmartObjects are initialized, then SmartLinks are added.
  Parameters:  <none>
------------------------------------------------------------------------------*/
  DEFINE VARIABLE currentPage  AS INTEGER NO-UNDO.

  ASSIGN currentPage = getCurrentPage().

  CASE currentPage: 

    WHEN 0 THEN DO:
       RUN constructObject (
             INPUT  'sfavoritos.w':U ,
             INPUT  FRAME fContainer:HANDLE ,
             INPUT  'HideOnInitnoDisableOnInitnoObjectLayout':U ,
             OUTPUT h_sfavoritos ).
       RUN repositionObject IN h_sfavoritos ( 2.67 , 35.00 ) NO-ERROR.
       /* Size in AB:  ( 1.67 , 124.00 ) */

       RUN constructObject (
             INPUT  'pure4gltv.w':U ,
             INPUT  FRAME fContainer:HANDLE ,
             INPUT  'wineModeAutomaticwindowsSkinAutomaticpicCacheCoef1labCacheCoef1tvIterationHeight17TreeStyle3FocSelNodeBgColor1UnfSelNodeBgColor16tvnodeDefaultFont1FocSelNodeFgColor15UnfSelNodeFgColor0resizeVerticalyesresizeHorizontalyesDragSourceallautoSortnoMSkeyScrollForcePaintyesHideOnInitnoDisableOnInitnoObjectLayout':U ,
             OUTPUT h_pure4gltv ).
       RUN repositionObject IN h_pure4gltv ( 4.57 , 35.00 ) NO-ERROR.
       RUN resizeObject IN h_pure4gltv ( 10.48 , 70.00 ) NO-ERROR.

       /* Links to SmartObject h_sfavoritos. */
       RUN addLink ( h_pure4gltv , 'tvNodeEvent':U , h_sfavoritos ).
       RUN addLink ( h_sfavoritos , 'tvNodeEvent':U , THIS-PROCEDURE ).

       /* Links to pure4glTv h_pure4gltv. */
       RUN addLink ( h_pure4gltv , 'tvNodeEvent':U , THIS-PROCEDURE ).

       /* Adjust the tab order of the smart objects. */
       RUN adjustTabOrder ( h_sfavoritos ,
             v-cdg_empresa:HANDLE IN FRAME fContainer , 'AFTER':U ).
       RUN adjustTabOrder ( h_pure4gltv ,
             h_sfavoritos , 'AFTER':U ).
    END. /* Page 0 */

  END CASE.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE armar_titulo wWin 
PROCEDURE armar_titulo :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

  DEFINE OUTPUT PARAMETER p-titulo AS CHARACTER.
  
  {findempresa.i}
  {findsector.i}

  p-titulo = "DYNASYS " + NRO_RELEASE /*VERSION_SIC*/ + " - " +
               " User:" + USERID("sic") + "-" + " Sector: " + Area.cdg_area + " - DB: " + PDBNAME("sic").

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE cambiar_menu wWin 
PROCEDURE cambiar_menu :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

    ASSIGN v-cdg_modulo = SELF:PRIVATE-DATA
           v-btn_handle = SELF:HANDLE.

    RUN emptyTree IN h_pure4gltv.  
    RUN carga_menu_modulo.  

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE carga_menu_modulo wWin 
PROCEDURE carga_menu_modulo :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

    {findempresa.i}

    DO ON ERROR UNDO, LEAVE:
    
        FOR EACH Treemenu NO-LOCK 
            WHERE Treemenu.cdg_padre = v-cdg_modulo 
              AND Treemenu.cdg_empresa = Empresa.cdg_empresa
              AND Treemenu.cdg_item <> ""
              AND CAN-FIND (FIRST Usuario_funcion OF Usuario 
                                  WHERE Usuario_funcion.cdg_empresa = Treemenu.cdg_empresa
                                    AND CAN-DO(Treemenu.permitidos,Usuario_funcion.cdg_funcion))
                                               BY Treemenu.cdg_item:
    
            RUN addNode IN h_pure4gltv (Treemenu.cdg_item
                                       ,""
                                       ,Treemenu.titulo
                                       ,IF Treemenu.archivo_icono = "" THEN "tvpics/usermale.bmp" ELSE Treemenu.archivo_icono
                                       ,IF CAN-FIND(FIRST Submenu WHERE Submenu.cdg_padre = Treemenu.cdg_item ) THEN "addOnExpand" ELSE "").
                                       
        END. 
    
    END.
    DYNAMIC-FUNCTION('tvRefresh':U IN h_pure4gltv).
    
    IF lTraceEvents THEN addToEdMsg("TV loaded in " + STRING(ETIME - iEtime) + " ms~n").

    FIND Modulo-sic WHERE Modulo-sic.cdg_sigla-sic = v-cdg_modulo NO-LOCK.
    v-nom_modulo = Modulo-sic.descripcion.
    v-accion = "".
    DISPLAY v-nom_modulo
            v-accion 
            WITH FRAME {&FRAME-NAME}.

    /*
    IF ERROR-STATUS:ERROR THEN MESSAGE RETURN-VALUE.
    APPLY 'CHOOSE' TO btnDisplay.
    */

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE conectar_ambiente wWin 
PROCEDURE conectar_ambiente :
/*------------------------------------------------------------------------------
  Purpose: CONECTA UN AMBIENTE EN PARTICULAR. INVOCA VALIDACION DE LA LICENCIA
           DE USO    
  Parameters:  hubo_logon QUE INDICA SI TODO ANDUVO BIEN
  Notes:       
------------------------------------------------------------------------------*/

   DEFINE OUTPUT PARAMETER hubo_logon AS LOGICAL.
   
   {&WINDOW-NAME}:SENSITIVE = NO.
   RUN c-logon.W ( OUTPUT codigo_salir,  OUTPUT entidad_logon).
   {&WINDOW-NAME}:SENSITIVE = YES.

   IF codigo_salir = CD_CANCELAR
   THEN DO:
        hubo_logon = NO.
   END.
   ELSE DO:
       hubo_logon = YES.
       RUN levantar_ambiente.
   END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE disable_UI wWin  _DEFAULT-DISABLE
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
  IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(wWin)
  THEN DELETE WIDGET wWin.
  IF THIS-PROCEDURE:PERSISTENT THEN DELETE PROCEDURE THIS-PROCEDURE.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE enable_UI wWin  _DEFAULT-ENABLE
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
  DISPLAY v-nom_modulo v-cdg_empresa tptareas ttareas tsasig v-accion fbatch 
          c_nro_tipo_evento v-desde v-nom_cliente v-operario v-direccion 
      WITH FRAME fContainer IN WINDOW wWin.
  ENABLE BTN-MENU tptareas BCRM ttareas BROWSE-4 BUTTON-refresh bevdet-2 
         btn_APM tsasig v-accion bevdet fbatch BUTTON-8 c_nro_tipo_evento 
         v-desde v-nom_cliente v-operario v-direccion BROWSE-2 btn_RGV btn_TQM 
         btn_ABA btn_ADP btn_AFI btn_BDU btn_COM btn_CPS btn_CPY btn_CXC 
         btn_CXP btn_DSP btn_FAC btn_GLA btn_INV btn_PRD btn_TES btn_UTL 
         btn_SALIR btn_acerca btn_ayuda btn_clave btn_empresa btn_login 
         btn_verconexion 
      WITH FRAME fContainer IN WINDOW wWin.
  {&OPEN-BROWSERS-IN-QUERY-fContainer}
  VIEW wWin.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE exitObject wWin 
PROCEDURE exitObject :
/*------------------------------------------------------------------------------
  Purpose:  Window-specific override of this procedure which destroys 
            its contents and itself.
    Notes:  
------------------------------------------------------------------------------*/

  APPLY "CLOSE":U TO THIS-PROCEDURE.
  RETURN.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE habilitar_botones wWin 
PROCEDURE habilitar_botones :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

  DEFINE INPUT PARAMETER p-habilitado AS LOGICAL.

  DEFINE VARIABLE h_proximo AS HANDLE.
  DEFINE VARIABLE delta AS DECIMAL INITIAL 1.10.
  DEFINE VARIABLE x1 AS DECIMAL.
  
  x0 = 2.67 - delta . /* IF x0 = ? THEN x0 = btn_ABA:ROW IN FRAME {&FRAME-NAME}. */

  x1 = ?.
  
  DO WITH FRAME {&FRAME-NAME}:
     
      h_proximo = FRAME {&FRAME-NAME}:FIRST-CHILD.
      h_proximo = h_proximo:FIRST-CHILD.
      DO WHILE VALID-HANDLE(h_proximo):
          IF h_proximo:TYPE = "BUTTON" 
          THEN DO:
              IF LOOKUP(h_proximo:NAME,"{&List-1}"," ") <> 0
              THEN DO:
                IF x1 = ? THEN x1 = x0.
                  h_proximo:SENSITIVE = p-habilitado AND LOOKUP(h_proximo:PRIVATE-DATA,v-lista_modulos,",") <> 0.
                  h_proximo:HIDDEN = NOT h_proximo:SENSITIVE . 
                  IF NOT h_proximo:HIDDEN 
                      THEN ASSIGN x1 = x1 + delta 
                                  h_proximo:ROW = x1 .
              END.
              ELSE DO:
                  IF h_proximo:NAME = "BTN-MENU"
                  THEN DO:
                      FIND FIRST Usuario_funcion 
                          WHERE Usuario_funcion.nro_usuario = Usuario.nro_usuario
                            AND Usuario_funcion.cdg_empresa = Usuario.cdg_empresa
                            AND Usuario_funcion.cdg_funcion = "DYNASYS"
                                NO-LOCK NO-ERROR.
                      h_proximo:HIDDEN = NOT AVAILABLE Usuario_funcion.
                  END.
              END.
          END.
          h_proximo = h_proximo:NEXT-SIBLING.

      END.
     
  END.


/*SUB-MENU  m_Archivo:SENSITIVE = YES.
  SUB-MENU  m_Seguridad:SENSITIVE = CONNECTED("SIC") AND p-habilitado.
  MENU-ITEM m_Cambio_de_Empresa:SENSITIVE IN MENU m_Archivo = CONNECTED("SIC") AND p-habilitado.
  MENU-ITEM m_Conectar_Ambiente:SENSITIVE IN MENU m_Archivo = YES AND p-habilitado.
  MENU-ITEM m_Desconectar_Ambiente:SENSITIVE IN MENU m_Archivo = CONNECTED("SIC") AND p-habilitado. 
  MENU-ITEM m_Salir:SENSITIVE IN MENU m_Archivo = YES AND p-habilitado.*/

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE initializeObject wWin 
PROCEDURE initializeObject :
/*------------------------------------------------------------------------------
  Purpose:     Super Override
  Parameters:  
  Notes:       
------------------------------------------------------------------------------*/
  DEFINE VAR lista AS CHAR NO-UNDO.

  DO WITH FRAME {&FRAME-NAME}:
     {levantacombo.i &TABLA=Tipo_evento &NOMBRE=cdg_tipo_evento &CODIGO=nro_tipo_evento &OBJETO=c_nro_tipo_evento}
  END. 
  c_nro_tipo_evento:ADD-FIRST("Todos",-1).
   v-desde = TODAY.
  c_nro_tipo_evento = -1.
  DISPLAY  c_nro_tipo_evento.

  /* Code placed here will execute PRIOR to standard behavior. */

  RUN SUPER.
  c_nro_tipo_evento:SCREEN-VALUE = "-1".
  /* Code placed here will execute AFTER standard behavior.    */
  wwin:MAX-WIDTH-PIXELS = SESSION:WIDTH-PIXELS * 2 NO-ERROR.
  wWin:MIN-WIDTH-PIXELS = wWin:WIDTH-PIXELS - 100.
  /*
  btnEmptyTv:LOAD-MOUSE-POINTER("CROSS") IN FRAME fMain. /* to test if effective with drag and drop
                                                          => well, apparently, it is not */
  */

  DO TRANSACTION:
      FIND FIRST Usuario WHERE Usuario.cdg_usuario = USERID("SIC") EXCLUSIVE-LOCK.
      FIND CURRENT Usuario NO-LOCK.
  END.
  FIND recurso WHERE recurso.nro_usuario =  usuario.nro_usuario NO-LOCK NO-ERROR.
  IF NOT AVAILABLE recurso THEN DO:
      MESSAGE "No esta registrado como recurso" SKIP
          "No tiene posibilidad de ver las tareas"
          VIEW-AS ALERT-BOX INFORMATION.
  END.
  RUN levantar_ambiente.
  {&OPEN-QUERY-browse-9}
/*RUN ver_cuadro.
  fbatch = 0.
  FOR EACH BATCH NO-LOCK:
      fbatch = fbatch + 1.
  END.
  DISPLAY fbatch WITH FRAME {&FRAME-NAME}.
*/
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE levantar_ambiente wWin 
PROCEDURE levantar_ambiente :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

  RUN verpermiso.p ( OUTPUT cod_aut ).
    
  RUN cargar_parametros.p.

  FIND FIRST Usuario WHERE Usuario.cdg_usuario = USERID("SIC") NO-LOCK.

  act_usuario = ROWID(Usuario).
  RUN armar_titulo ( OUTPUT titulo ).
  RUN poner_sesion ( INPUT cod_aut = 0 , INPUT titulo ).

  /*{setwintit.i "SIC/BAS" "Menu Principal"}*/

  {&WINDOW-NAME}:TITLE = titulo.

  RUN levantar_empresas.
  RUN levantar_modulos.

  RUN carga_menu_modulo.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE levantar_empresas wWin 
PROCEDURE levantar_empresas :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

    DEFINE VARIABLE lista AS CHARACTER.

    DO WITH FRAME {&FRAME-NAME}:

        v-cdg_empresa:DELIMITER = "|".
        lista = "".
        FOR EACH User_empresa OF Usuario 
                   WHERE User_empresa.rige_desde <= TODAY /*v-fecha_proceso*/
                     AND User_empresa.rige_hasta >= TODAY /*v-fecha_proceso*/ NO-LOCK,
            FIRST B-Empresa OF User_empresa NO-LOCK BY B-Empresa.nombre:
    
            lista = lista + "|" + TRIM(B-Empresa.nombre) + "|" + STRING(B-Empresa.cdg_empresa).
    
        END.

        v-cdg_empresa:LIST-ITEM-PAIRS = SUBSTRING(lista,2).
        {findempresa.i}
        v-cdg_empresa = Usuario.cdg_empresa.
        DISPLAY v-cdg_empresa.
        v-cdg_empresa:SENSITIVE = NUM-ENTRIES(v-cdg_empresa:LIST-ITEM-PAIRS,"|" ) > 2.

    END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE levantar_modulos wWin 
PROCEDURE levantar_modulos :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

    DO WITH FRAME {&FRAME-NAME}:

        {findempresa.i}

        v-lista_modulos = "".
        FOR EACH Modulo-sic WHERE Modulo-SIC.activo BY Modulo-SIC.descripcion:

            IF CAN-FIND(FIRST Treemenu NO-LOCK 
                    WHERE Treemenu.cdg_padre = Modulo-sic.cdg_sigla-sic 
                      AND Treemenu.cdg_empresa = Empresa.cdg_empresa
                      AND Treemenu.cdg_item <> ""
                      AND CAN-FIND (FIRST Usuario_funcion OF Usuario 
                                          WHERE Usuario_funcion.cdg_empresa = Treemenu.cdg_empresa
                                            AND CAN-DO(Treemenu.permitidos,Usuario_funcion.cdg_funcion)))
            THEN DO:
                v-lista_modulos = v-lista_modulos + "," + STRING(Modulo-sic.cdg_sigla-sic).
            END.
    
        END.
        v-lista_modulos = SUBSTRING(v-lista_modulos,2).
        IF VALID-HANDLE(v-btn_handle)
           THEN v-cdg_modulo = v-btn_handle:PRIVATE-DATA.
           ELSE v-cdg_modulo = ENTRY(1,v-lista_modulos).
        RUN habilitar_botones ( YES ).
    END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE limpiar_sesion wWin 
PROCEDURE limpiar_sesion :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

    DEFINE VARIABLE i-posicion AS INTEGER NO-UNDO.

    DO TRANSACTION:

        i-posicion = 0.

        FIND Usuario WHERE Usuario.cdg_usuario = USERID("sic") EXCLUSIVE-LOCK.
        FOR EACH Mfavorito WHERE Mfavorito.nro_usuario = Usuario.nro_usuario 
                           AND Mfavorito.cdg_empresa = Empresa.cdg_empresa EXCLUSIVE-LOCK:

            IF Mfavorito.opcion = "P"
            THEN DO:
                i-posicion = i-posicion + 1.
                Mfavorito.posicion = i-posicion.
            END.
            ELSE DO:
                DELETE Mfavorito.
            END.
     
       END.

       FOR EACH Logusuario OF Usuario WHERE Logusuario.abierta EXCLUSIVE-LOCK:
           ASSIGN Logusuario.abierta          = NO
                  Logusuario.fch_hasta        = TODAY
                  Logusuario.hor_hasta        = TIME
                  Logusuario.hms_hasta        = STRING(Logusuario.hor_hasta,"HH:MM:SS")
                  Usuario.cdg_empresa         = "".
       END.
       RELEASE Usuario.
       RELEASE Logusuario.
    END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE loadDirectory wWin 
PROCEDURE loadDirectory :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEFINE INPUT  PARAMETER pcParentKey AS CHARACTER  NO-UNDO.
DEFINE INPUT  PARAMETER cDir      AS CHARACTER  NO-UNDO.

DEFINE VARIABLE iEtime AS INTEGER    NO-UNDO.
iEtime = ETIME.


DEFINE VARIABLE cFileName   AS CHARACTER  NO-UNDO.
DEFINE VARIABLE cFullPath   AS CHARACTER  NO-UNDO.
DEFINE VARIABLE cAttr       AS CHARACTER  NO-UNDO.
DEFINE VARIABLE ico         AS CHARACTER  NO-UNDO.
DEFINE VARIABLE optn        AS CHARACTER  NO-UNDO.


EMPTY TEMP-TABLE osFile. /* should be useless now */

/* First load the directory in a temp-table so we can sort it afterwards */
INPUT FROM OS-DIR(cDir).
REPEAT:
    IMPORT cfileName cFullPath cAttr.
    
    IF cFileName = ".."  THEN NEXT.
    IF cFileName = "."   THEN NEXT.
    
    CREATE osFile.
    ASSIGN
     osFile.cFileName = cFileName
     osFile.cFullPath = cFullPath
     osFile.cAttr     = cAttr.
END.
INPUT CLOSE.

/* now, load the nodes */
FOR EACH osFile
 BY osFile.cAttr /* the directories ("D") will come first */
 BY osFile.cFileName:
    IF osFile.cAttr = "D" THEN ASSIGN
     ico = "tvpics/fold"
     optn = "addOnExpand".
    ELSE ASSIGN
     ico = "tvpics/blankSheet"
     optn = "".
    
    RUN addNode IN h_pure4gltv  ("fileName=" + osFile.cFullPath
                                ,pcParentKey
                                ,osFile.cFileName
                                ,ico
                                ,optn) NO-ERROR.
    
    IF ERROR-STATUS:ERROR THEN DO:
        EMPTY TEMP-TABLE osFile.
        MESSAGE RETURN-VALUE VIEW-AS ALERT-BOX INFO BUTTONS OK.
        RETURN ERROR.
    END.
END.

EMPTY TEMP-TABLE osFile.

IF lTraceEvents THEN addToEdMsg("File system TV loaded in " + STRING(ETIME - iEtime) + " ms~n").

/*APPLY 'CHOOSE' TO btnDisplay IN FRAME fMain.*/

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE mostrar_ayuda wWin 
PROCEDURE mostrar_ayuda :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

    DEFINE VARIABLE hInstance AS INTEGER.
    IF AVAILABLE Treemenu
    THEN DO:
        IF Treemenu.archivo_help <> ""
            THEN RUN ShellExecute{&A} IN hpApi  (0,
                                                "open",
                                                Treemenu.archivo_help,
                                                "",
                                                "",
                                                1,
                                                OUTPUT hInstance).
            ELSE MESSAGE "No se halla definido el archivo de ayuda"
                    VIEW-AS ALERT-BOX WARNING.
    END.
    ELSE MESSAGE "Seleccione un nodo del menú"
            VIEW-AS ALERT-BOX WARNING.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE poner_sesion wWin 
PROCEDURE poner_sesion :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

  DEFINE INPUT PARAMETER p-estado AS LOGICAL.
  DEFINE INPUT PARAMETER p-titulo AS CHARACTER.

/*==========================================================================*/
/*                              VARIABLES                                   */
/*==========================================================================*/  

  DEFINE VARIABLE lOk AS LOGICAL.
  DEFINE VARIABLE cImagen AS CHARACTER.

/*==========================================================================*/
/*                          BLOQUE PRINCIPAL                                */
/*==========================================================================*/

  {&WINDOW-NAME}:TITLE = p-titulo.

  /*
  RUN getparametro_c.p (  INPUT  "IMAGENBG", OUTPUT cImagen).
  IF cImagen <> ? 
     THEN lOk = IMAGE-1:LOAD-IMAGE(cImagen) IN FRAME {&FRAME-NAME}.

  RUN habilitar_botones ( INPUT p-estado ).
  */

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE selectNode wWin 
PROCEDURE selectNode :
/*------------------------------------------------------------------------------
  Purpose:  cuando se arrastra el nodo   
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEFINE INPUT  PARAMETER pcnodeKey AS CHARACTER  NO-UNDO.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE traceIt wWin 
PROCEDURE traceIt :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
    DEFINE INPUT  PARAMETER pc  AS CHARACTER  NO-UNDO.
    
    /*addToEdMsg(pc + "~n").*/
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE ttllena wWin 
PROCEDURE ttllena :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
EMPTY TEMP-TABLE tt.
DEFINE VAR ii AS INT NO-UNDO.
DEFINE VAR opt AS LOGICAL NO-UNDO.
FOR EACH evento WHERE NOT evento.anulado AND 
    evento.fasignado >= v-desde AND 
    evento.reminder <> "" AND
    ( evento.nro_tipo_evento = c_nro_tipo_evento OR c_nro_tipo_evento = -1 ) NO-LOCK:
    FIND tipo_evento  WHERE tipo_evento.nro_tipo_evento = evento.nro_tipo_evento NO-LOCK.
    IF evento.fasignado + Evento.dreminder <= v-desde THEN NEXT.
    CREATE tt.
    FIND cliente OF evento NO-LOCK.
    BUFFER-COPY evento TO tt ASSIGN
        tt.freminder = Evento.fasignado + Evento.dreminder
        tt.cdg_tipo_evento = tipo_evento.cdg_tipo_evento. 
        tt.direccion = cliente.direccion.
        tt.nom_cliente = cliente.nom_cliente.
       /* ii = ii + 1.*/
   /*IF ii MOD 100 = 0 THEN DO:
        MESSAGE "Ya van " + STRING(ii) + " recordatorios, continua" VIEW-AS ALERT-BOX QUESTION BUTTON YES-NO SET opt.
        IF NOT opt THEN LEAVE.
    END.  */
END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE tvDoubleClick wWin 
PROCEDURE tvDoubleClick :
/*------------------------------------------------------------------------------
  Purpose: example to use tvNodeEvent procedure with pure4GlTv
  Parameters: 
  Notes: I use this procedure for mulitple demo treeview
     Note that I rely on pcnodeKey to distinguish the different
     sample treeview
------------------------------------------------------------------------------*/

  DEFINE INPUT  PARAMETER pcnodeKey AS CHARACTER  NO-UNDO.

  FIND Treemenu WHERE Treemenu.cdg_item = pcNodeKey
                  AND Treemenu.cdg_empresa = v-cdg_empresa NO-LOCK.

  IF Treemenu.accion <> "" 
  THEN DO:
      IF Treemenu.ancho_pixeles <= SESSION:WIDTH-PIXELS AND Treemenu.alto_pixeles <= SESSION:HEIGHT-PIXELS 
          THEN RUN ejecutar ( INPUT Treemenu.accion, INPUT Treemenu.modo, INPUT Treemenu.cdg_comprobante ).
          ELSE RUN mensajepar.p ( INPUT TRIM(STRING(SESSION:WIDTH-PIXELS,">>>9")) + CHR(1) + 
                                  TRIM(STRING(SESSION:HEIGHT-PIXELS,">>>9")) + CHR(1) + 
                                  TRIM(STRING(Treemenu.ancho_pixeles,">>>9")) + CHR(1) + 
                                  TRIM(STRING(Treemenu.alto_pixeles,">>>9")) , INPUT "SYST001" ).
  END.
  ELSE DO:
      v-accion = Treemenu.descripcion.
      DISPLAY v-accion
          WITH FRAME {&FRAME-NAME}.
  END.

/*========= For text treview sample, nodeKey beings 'n' ================*/

/*======== For data treeview example on salesrep customer order orderline: ========*/

/*-------------- add more customers to salesrep --------------*/
/*
IF pcNodeKey BEGINS "MoreCust=" THEN DO:
    ASSIGN
     icustnum = INT(ENTRY(2,pcNodeKey,"="))
     cparentKey = DYNAMIC-FUNCTION('getNodeParentKey' IN h_pure4glTv, pcNodeKey)
     cSalesrep = ENTRY(2,cparentKey,"=").
    FIND customer NO-LOCK WHERE customer.custnum = icustnum.
    cCustName = customer.name.
    
    FOR EACH customer NO-LOCK WHERE
     customer.salesrep = cSalesrep
     AND customer.name >= cCustName
     BY customer.name:
        nCust = nCust + 1.
        IF nCust > giRowsToBatch THEN DO:
            RUN addNode IN h_pure4gltv ("MoreCust=" + STRING(customer.custnum)
                                       ,cparentKey
                                       ,"More..."
                                       ,""
                                       ,"InViewPortIfPossible").
            LEAVE.
        END.
        optn = "InViewPortIfPossible".
        IF nCust = 1 THEN optn = optn + CHR(1) + "selected".
        IF CAN-FIND(FIRST order OF customer)
         THEN optn = optn + CHR(1) + "addOnExpand".
        
        RUN addNode IN h_pure4gltv ("cust=" + STRING(customer.custnum)
                                   ,cParentKey
                                   ,customer.name
                                   ,"tvpics/smile56.bmp"
                                   ,optn).
    END.  /* for each customer */
    
    RUN deleteNode IN h_Pure4glTv (pcNodeKey, "refresh").
END. /* add more customers to salesrep node */


/*-------------- add more orders to customer --------------*/
IF pcNodeKey BEGINS "MoreOrder=" THEN DO:
    ASSIGN
     iorder = INT(ENTRY(2,pcNodeKey,"="))
     cparentKey = DYNAMIC-FUNCTION('getNodeParentKey' IN h_pure4glTv, pcNodeKey)
     icustnum = INT(ENTRY(2,cparentKey,"=")).
     
    FOR EACH order NO-LOCK WHERE
     order.custnum = icustnum
     AND order.ordernum >= iorder
     BY order.ordernum:
        norder = nOrder + 1.
        IF norder > giRowsToBatch THEN DO:
            RUN addNode IN h_pure4gltv ("MoreOrder=" + STRING(order.ordernum)
                                       ,cparentKey
                                       ,"More..."
                                       ,""
                                       ,"InViewPortIfPossible").
            LEAVE.
        END.
        optn = "InViewPortIfPossible".
        IF norder = 1 THEN optn = optn + CHR(1) + "selected".
        IF CAN-FIND(FIRST orderline OF order)
         THEN optn = optn + CHR(1) + "addOnExpand".
        
        RUN addNode IN h_pure4gltv ("order=" + STRING(order.ordernum)
                                   ,cparentKey
                                   ,STRING(order.ordernum) + " (" + STRING(order.orderdate) + ")"
                                   ,"tvpics/book02.bmp"
                                   ,optn).
    END.  /* for each customer */
    RUN deleteNode IN h_Pure4glTv (pcNodeKey, "refresh").
END. /* add customers to salesrep node */
*/
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE tvNodeAddOnExpand wWin 
PROCEDURE tvNodeAddOnExpand :
/*------------------------------------------------------------------------------
  Purpose: example to use tvNodeEvent procedure with pure4GlTv
  Parameters: 
  Notes: I use this procedure for mulitple demo treeview
     Note that I rely on pcnodeKey to distinguish the different
     sample treeview
------------------------------------------------------------------------------*/
DEFINE INPUT  PARAMETER pcnodeKey AS CHARACTER  NO-UNDO.

FIND Treemenu WHERE Treemenu.cdg_item = pcNodeKey AND Treemenu.cdg_empresa = v-cdg_empresa NO-LOCK.
IF CAN-FIND(FIRST Submenu NO-LOCK 
            WHERE Submenu.cdg_padre = Treemenu.cdg_item 
              AND Submenu.cdg_empresa = Treemenu.cdg_empresa
              AND CAN-FIND (FIRST Usuario_funcion OF Usuario 
                      WHERE Usuario_funcion.cdg_empresa = Treemenu.cdg_empresa
                        AND CAN-DO(Submenu.permitidos,Usuario_funcion.cdg_funcion)))
THEN DO:
    FOR EACH Submenu NO-LOCK 
        WHERE Submenu.cdg_padre = Treemenu.cdg_item 
          AND Submenu.cdg_empresa = Treemenu.cdg_empresa
          AND CAN-FIND (FIRST Usuario_funcion OF Usuario 
                  WHERE Usuario_funcion.cdg_empresa = Treemenu.cdg_empresa
                    AND CAN-DO(Submenu.permitidos,Usuario_funcion.cdg_funcion))
                       BY Submenu.cdg_item:

        RUN addNode IN h_pure4gltv (Submenu.cdg_item
                                   ,pcNodeKey
                                   ,Submenu.titulo
                                   ,IF Submenu.archivo_icono = "" 
                                       THEN IF CAN-FIND(FIRST B-Submenu WHERE B-Submenu.cdg_padre = Submenu.cdg_item ) 
                                                        THEN "tvpics/fold.bmp" ELSE "tvpics/windows.bmp"
                                       ELSE Submenu.archivo_icono
                                   ,IF CAN-FIND(FIRST B-Submenu WHERE B-Submenu.cdg_padre = Submenu.cdg_item ) 
                                       THEN "addOnExpand" 
                                       ELSE "").
                                   
        
    END.
END.

/*-------------- add customers to salesrep --------------*/
/*
IF pcNodeKey BEGINS "sr=" THEN DO:
    cSalesrep = ENTRY(2,pcNodeKey,"=").
    FOR EACH customer NO-LOCK WHERE customer.salesrep = cSalesrep BY customer.name:
        nCust = nCust + 1.
        IF nCust > giRowsToBatch THEN DO:
            RUN addNode IN h_pure4gltv ("MoreCust=" + STRING(customer.custnum)
                                       ,pcNodeKey
                                       ,"More..."
                                       ,""
                                       ,"").
            LEAVE.
        END.
        RUN addNode IN h_pure4gltv ("cust=" + STRING(customer.custnum)
                                   ,pcNodeKey
                                   ,customer.name
                                   ,"tvpics/smile56.bmp"
                                   ,IF CAN-FIND(FIRST order OF customer) THEN "addOnExpand" ELSE "").
    END.  /* for each customer */
END. /* add customers to salesrep node */
*/

/*-------------- add orders to customer --------------*/
/*
IF pcNodeKey BEGINS "cust=" THEN DO:
    icustnum = INT(ENTRY(2,pcNodeKey,"=")).
    FOR EACH order NO-LOCK WHERE order.custnum = icustnum BY order.ordernum:
        norder = nOrder + 1.
        IF norder > giRowsToBatch THEN DO:
            RUN addNode IN h_pure4gltv ("MoreOrder=" + STRING(order.ordernum)
                                       ,pcNodeKey
                                       ,"More..."
                                       ,""
                                       ,"").
            LEAVE.
        END.
        RUN addNode IN h_pure4gltv ("order=" + STRING(order.ordernum)
                                   ,pcNodeKey
                                   ,STRING(order.ordernum) + " (" + STRING(order.orderdate) + ")"
                                   ,"tvpics/book02.bmp"
                                   ,IF CAN-FIND(FIRST orderline OF order) THEN "addOnExpand" ELSE "").
    END.  /* for each customer */
END. /* add customers to salesrep node */
*/

/*-------------- add orderline to order --------------*/
/*
IF pcNodeKey BEGINS "order=" THEN DO:
    iorder   = INT(ENTRY(2,pcNodeKey,"=")).
    FOR EACH orderline NO-LOCK WHERE orderline.ordernum = iorder BY orderline.linenum:
        FIND ITEM OF orderline NO-LOCK. 
        RUN addNode IN h_pure4gltv ("OL=" + STRING(iorder) + ";" + STRING(orderline.linenum)
                                   ,pcNodeKey
                                   ,STRING(orderline.linenum) + "  " + ITEM.itemname
                                   ,"tvpics/present1.bmp"
                                   ,"") NO-ERROR.
    END. /* FOR EACH orderline */
    IF ERROR-STATUS:ERROR THEN MESSAGE RETURN-VALUE VIEW-AS ALERT-BOX INFO BUTTONS OK.
END.

/* example with directory tree */

IF pcNodeKey BEGINS "fileName=" THEN DO:
    cFullPath = ENTRY(2,pcNodeKey,"=").
    RUN loadDirectory (pcNodeKey, cFullPath).
END.

*/

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE tvNodeCreatePopup wWin 
PROCEDURE tvNodeCreatePopup :
/*------------------------------------------------------------------------------
  Purpose: example to use tvNodePopup procedure with pure4GlTv
  Parameters: 
  Notes: I use this procedure for mulitple demo treeview
     Note that I rely on pcnodeKey to distinguish the different
     sample treeview
------------------------------------------------------------------------------*/
DEFINE INPUT  PARAMETER pcnodeKey AS CHARACTER  NO-UNDO.

DEFINE VARIABLE nCust     AS INTEGER    NO-UNDO.
DEFINE VARIABLE norder    AS INTEGER    NO-UNDO.

DEFINE VARIABLE cSalesrep  AS CHARACTER  NO-UNDO.
DEFINE VARIABLE icustnum   AS INTEGER    NO-UNDO.
DEFINE VARIABLE ccustname  AS CHARACTER  NO-UNDO.
DEFINE VARIABLE iorder     AS INTEGER    NO-UNDO.
DEFINE VARIABLE cparentKey AS CHARACTER  NO-UNDO.

/*========= For text treview sample, nodeKey beings 'n' ================*/
IF pcNodeKey BEGINS "n"
 AND NUM-ENTRIES(pcNodeKey, "=") = 1
 THEN RETURN "Add a child node,MenuAddChildNode,RULE,,Hello World,MenuHelloWorld".


/*======== For data treeview example on salesrep customer order orderline: ========*/
/* popup menu addSalesRep and addCustomer */
IF pcNodeKey BEGINS "sr="
 THEN RETURN "Add Salesrep,MenuAddSR,Add Customer,MenuAddCustomer".

/*-------------- Popup menu addOrder  --------------*/
IF pcNodeKey BEGINS "cust="
 THEN RETURN "Add order,MenuAddOrder".

/*-------------- Popup menu addOrderline --------------*/
IF pcNodeKey BEGINS "order="
 THEN RETURN "Add order line,MenuAddOrderLine".

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE tvNodeDropEnd wWin 
PROCEDURE tvNodeDropEnd :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

DEFINE INPUT  PARAMETER pcEvent   AS CHARACTER  NO-UNDO.
DEFINE INPUT  PARAMETER pcnodeKey AS CHARACTER  NO-UNDO.

DEFINE VARIABLE mouseX   AS INTEGER    NO-UNDO.
DEFINE VARIABLE mouseY   AS INTEGER    NO-UNDO.
DEFINE VARIABLE cWidgets AS CHARACTER  NO-UNDO.
DEFINE VARIABLE hWidget  AS HANDLE     NO-UNDO.
DEFINE VARIABLE icount   AS INTEGER    NO-UNDO.

mouseX = INT(ENTRY(2,pcEvent)) NO-ERROR.
mouseY = INT(ENTRY(3,pcEvent)) NO-ERROR.

/* Example with the large tree (1000 node) and drag-drop used to move
 a node somewhere else (drop in the treeview itself */
IF pcnodeKey BEGINS "k" THEN DO:
    DEFINE VARIABLE targetKe AS CHARACTER  NO-UNDO.
    targetKe = DYNAMIC-FUNCTION('getNodeLocatedAtXY' IN h_pure4GlTv, mouseX, mouseY).
    
    IF lTraceEvents THEN DO:
        addToEdMsg("Drop end fired in MouseX: " + STRING(mouseX)
         + "  mouseY: " + STRING(mouseY) + "   nodeKey: " + pcnodeKey
         + "~n         => This falls in the following widgets:" + cWidgets
         + "~n         => Detected Target Nodekey: " + targetKe + "~n").
    END.
    
    IF targetKe <> "" AND targetKe <> pcnodeKey THEN
     RUN moveNode IN h_pure4gltv (pcnodeKey, targetKe, "after", "refresh") NO-ERROR.
    IF NOT ERROR-STATUS:ERROR THEN DYNAMIC-FUNCTION('selectNode' IN h_pure4gltv , pcnodeKey).
    ELSE MESSAGE "This node cannot be moved here!"
         VIEW-AS ALERT-BOX INFO BUTTONS OK.
END.

/* other cases, the drop is done in this container */
ELSE DO:
    /* work out the name of drop target widgets from the handles passed in pcEvent*/
    DO iCount = 4 TO NUM-ENTRIES(pcEvent):
        hWidget = WIDGET-HANDLE(ENTRY(iCount,pcEvent)) NO-ERROR.
        cWidgets = cWidgets + " "
         + IF hWidget:NAME = ?
            THEN (IF CAN-QUERY(hWidget,"SCREEN-VALUE")
                   THEN "SCREEN-VALUE=" + hWidget:SCREEN-VALUE
                   ELSE "?")
            ELSE hWidget:NAME.
    END.
    
    /* if trace enable, then display info in the monitoring editor */
    
    IF lTraceEvents THEN DO:
        addToEdMsg("Drop end fired in at mouseX: " + STRING(mouseX)
         + "  mouseY: " + STRING(mouseY) + "   nodeKey: " + pcnodeKey + "~n").
        
        IF cWidgets = "" THEN addToEdMsg("         This (X,Y) does not falls in any widget~n").
        ELSE addToEdMsg("         This (X,Y) falls in the following widgets:" + cWidgets + "~n").
    END.
    
    /* at last insert the label of the dragged node into the drop target widget */
    hWidget = ?.
    DO iCount = 4 TO NUM-ENTRIES(pcEvent):
        hWidget = WIDGET-HANDLE(ENTRY(iCount,pcEvent)) NO-ERROR.
        IF NOT CAN-QUERY(hWidget, "SCREEN-VALUE") THEN NEXT.
        IF NOT hWidget:SENSITIVE THEN NEXT. /* otherwise, we give the ability to change a label :o */
    
        DEFINE VARIABLE hNodeBuffer AS HANDLE     NO-UNDO.
        RUN getNodeDetails IN h_pure4gltv
        ( INPUT  pcnodeKey /* CHARACTER */,
          OUTPUT hNodeBuffer /* HANDLE */).
        
        IF NOT VALID-HANDLE (hNodeBuffer) THEN LEAVE.
        
        CASE hWidget:TYPE:
          WHEN "EDITOR" THEN DO:
            hWidget:CURSOR-OFFSET = hWidget:LENGTH + 1.
            hWidget:INSERT-STRING(hNodeBuffer:BUFFER-FIELD("lab"):BUFFER-VALUE + "~n").
          END.
          WHEN "FILL-IN" THEN hWidget:SCREEN-VALUE = hWidget:SCREEN-VALUE + 
            hNodeBuffer:BUFFER-FIELD("lab"):BUFFER-VALUE NO-ERROR.
          OTHERWISE hWidget:SCREEN-VALUE = hNodeBuffer:BUFFER-FIELD("lab"):BUFFER-VALUE NO-ERROR.
        END CASE. /* CASE hWidget:TYPE: */
        APPLY 'VALUE-CHANGED'TO hWidget. /*very important if we want the change of the SCREEN-VALUE
                                          to result in the same as typing */

        DELETE OBJECT hNodeBuffer.
        
        LEAVE. /* one widget is enough ;) */
    END. /* DO iCount = 4 TO NUM-ENTRIES(cWidgets): */
END. /* other cases, the drop is done in this container */

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE tvnodeEvent wWin 
PROCEDURE tvnodeEvent :
/*------------------------------------------------------------------------------
  Purpose: example to use tvNodeEvent procedure with pure4GlTv
  Parameters: 
  Notes: I use this procedure for mulitple demo treeview
     Note that I rely on pcnodeKey to distinguish the different
     sample treeview
------------------------------------------------------------------------------*/
DEFINE INPUT  PARAMETER pcEvent   AS CHARACTER  NO-UNDO.
DEFINE INPUT  PARAMETER pcnodeKey AS CHARACTER  NO-UNDO.

DEFINE VARIABLE nCust     AS INTEGER    NO-UNDO.
DEFINE VARIABLE norder    AS INTEGER    NO-UNDO.

DEFINE VARIABLE cSalesrep AS CHARACTER  NO-UNDO.
DEFINE VARIABLE icustnum  AS INTEGER    NO-UNDO.
DEFINE VARIABLE iorder AS INTEGER    NO-UNDO.

DEFINE VARIABLE modo            AS INTEGER.
DEFINE VARIABLE cdg_salida      AS INTEGER.              

IF lTraceEvents THEN addToEdMsg(STRING(pcEvent,FILL("X",25)) + pcnodeKey + "~n").

CASE pcEvent:
  WHEN "addOnExpand" THEN RUN tvNodeaddOnExpand (pcnodeKey).
  WHEN "select"      THEN RUN tvNodeSelect (pcnodeKey).
  
  WHEN "rightClick"  THEN DO:
          /*MESSAGE "me apretaste el boton derecho del mouse"
              VIEW-AS ALERT-BOX INFO BUTTONS OK TITLE "tvnodeevent".*/

          FIND Treemenu WHERE Treemenu.cdg_item = pcNodeKey
                  AND Treemenu.cdg_empresa = v-cdg_empresa NO-LOCK.

          RUN d-zoom_itemmenu.w ( INPUT   ROWID(Treemenu),
                                  INPUT   modo,
                                  OUTPUT  cdg_salida).

/*      RUN tvNodeCreatePopup (pcnodeKey) NO-ERROR.
      IF NOT ERROR-STATUS:ERROR THEN RETURN RETURN-VALUE.
      ELSE MESSAGE "tvNodeCreatePopup failed with the following message:" RETURN-VALUE
        VIEW-AS ALERT-BOX INFO BUTTONS OK.
        */
  END.
  
  /* place to handle the Menu event */
  WHEN "MenuAddChildNode"
   OR WHEN "MenuAddSR"
   OR WHEN "MenuAddCustomer"
   OR WHEN "MenuAddOrder"
   OR WHEN "MenuAddOrderLine"
   THEN /*addToEdMsg("Menu item event fired: " + pcEvent + " for key " + pcnodeKey + "~n")*/.
   
   WHEN "MenuHelloWorld" THEN MESSAGE "Hello World!" SKIP
      "Node key parent of the popup menu item:" + pcNodeKey
        VIEW-AS ALERT-BOX INFO BUTTONS OK.
   
   WHEN "DragBegin" THEN DO:
       /* sample with Large tree (1000 nodes), the node keys are of type "k<n>" 
         by returning "yourself" the treview will be the drop target to move a node
         to another location in the tree */
       IF pcnodeKey BEGINS "k" THEN RETURN "dropOnYourself".
       
       /* see node n4 in small TV */
       IF pcnodeKey = "n4" THEN RETURN "cancelDrag".
       
       /* drop target frame is in another window */
       IF pcnodeKey = "n1" THEN DO:
           /* to test that, use PRO*Tools/run to run C:\BabouSoft\tv4gl\OtherDropTargetWin.w
             with the persistent option before running this test container */
           DEFINE VARIABLE hTargetFrame AS HANDLE     NO-UNDO.
           PUBLISH "getOtherWinTargetFrame" (OUTPUT hTargetFrame).
           IF VALID-HANDLE(hTargetFrame) THEN RETURN STRING(hTargetFrame).
       END.

       /* for the other samle, the target is this container */
       RETURN /*STRING(FRAME fMain:HANDLE) */.
   END.

   WHEN "DoubleClick"      THEN RUN tvDoubleClick (pcnodeKey).

   OTHERWISE IF pcEvent BEGINS "DropEnd," THEN RUN tvNodeDropEnd (pcEvent, pcNodeKey).
END CASE.
 
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE tvNodeSelect wWin 
PROCEDURE tvNodeSelect :
/*------------------------------------------------------------------------------
  Purpose: example to use tvNodeEvent procedure with pure4GlTv
  Parameters: 
  Notes: I use this procedure for mulitple demo treeview
     Note that I rely on pcnodeKey to distinguish the different
     sample treeview
------------------------------------------------------------------------------*/
DEFINE INPUT  PARAMETER pcnodeKey AS CHARACTER  NO-UNDO.

DEFINE VARIABLE nCust     AS INTEGER    NO-UNDO.
DEFINE VARIABLE norder    AS INTEGER    NO-UNDO.

DEFINE VARIABLE cSalesrep  AS CHARACTER  NO-UNDO.
DEFINE VARIABLE icustnum   AS INTEGER    NO-UNDO.
DEFINE VARIABLE ccustname  AS CHARACTER  NO-UNDO.
DEFINE VARIABLE iorder     AS INTEGER    NO-UNDO.
DEFINE VARIABLE cparentKey AS CHARACTER  NO-UNDO.
DEFINE VARIABLE optn       AS CHARACTER  NO-UNDO.

FIND Treemenu 
    WHERE Treemenu.cdg_item = pcNodeKey 
    AND Treemenu.cdg_empresa = v-cdg_empresa
        NO-LOCK.

IF Treemenu.accion <> "" AND Treemenu.accion <> ":X"
THEN DO:
  v-accion = Treemenu.accion.
  IF Treemenu.cdg_comprobante <> "" 
      THEN v-accion = v-accion + ":" + Treemenu.cdg_comprobante + ":" + Treemenu.modo.
  IF Treemenu.descripcion <> ""
      THEN v-accion = v-accion + "=" + Treemenu.descripcion.
  DISPLAY v-accion
      WITH FRAME {&FRAME-NAME}.

END.
ELSE DO:
  v-accion = Treemenu.descripcion.
  DISPLAY v-accion
      WITH FRAME {&FRAME-NAME}.
END.
/*
IF Treemenu.accion <> "" AND Treemenu.accion <> ":X"
THEN DO:
  v-accion = Treemenu.accion.
  DISPLAY v-accion
      WITH FRAME {&FRAME-NAME}.
END.
ELSE DO:
  v-accion = "".
  DISPLAY v-accion
      WITH FRAME {&FRAME-NAME}.
END.
*/
/*========= For text treview sample, nodeKey beings 'n' ================*/


/*======== For data treeview example on salesrep customer order orderline: ========*/



/*-------------- add more customers to salesrep --------------*/
/*
IF pcNodeKey BEGINS "MoreCust=" THEN DO:
    ASSIGN
     icustnum = INT(ENTRY(2,pcNodeKey,"="))
     cparentKey = DYNAMIC-FUNCTION('getNodeParentKey' IN h_pure4glTv, pcNodeKey)
     cSalesrep = ENTRY(2,cparentKey,"=").
    FIND customer NO-LOCK WHERE customer.custnum = icustnum.
    cCustName = customer.name.
    
    FOR EACH customer NO-LOCK WHERE
     customer.salesrep = cSalesrep
     AND customer.name >= cCustName
     BY customer.name:
        nCust = nCust + 1.
        IF nCust > giRowsToBatch THEN DO:
            RUN addNode IN h_pure4gltv ("MoreCust=" + STRING(customer.custnum)
                                       ,cparentKey
                                       ,"More..."
                                       ,""
                                       ,"InViewPortIfPossible").
            LEAVE.
        END.
        optn = "InViewPortIfPossible".
        IF nCust = 1 THEN optn = optn + CHR(1) + "selected".
        IF CAN-FIND(FIRST order OF customer)
         THEN optn = optn + CHR(1) + "addOnExpand".
        
        RUN addNode IN h_pure4gltv ("cust=" + STRING(customer.custnum)
                                   ,cParentKey
                                   ,customer.name
                                   ,"tvpics/smile56.bmp"
                                   ,optn).
    END.  /* for each customer */
    
    RUN deleteNode IN h_Pure4glTv (pcNodeKey, "refresh").
END. /* add more customers to salesrep node */


/*-------------- add more orders to customer --------------*/
IF pcNodeKey BEGINS "MoreOrder=" THEN DO:
    ASSIGN
     iorder = INT(ENTRY(2,pcNodeKey,"="))
     cparentKey = DYNAMIC-FUNCTION('getNodeParentKey' IN h_pure4glTv, pcNodeKey)
     icustnum = INT(ENTRY(2,cparentKey,"=")).
     
    FOR EACH order NO-LOCK WHERE
     order.custnum = icustnum
     AND order.ordernum >= iorder
     BY order.ordernum:
        norder = nOrder + 1.
        IF norder > giRowsToBatch THEN DO:
            RUN addNode IN h_pure4gltv ("MoreOrder=" + STRING(order.ordernum)
                                       ,cparentKey
                                       ,"More..."
                                       ,""
                                       ,"InViewPortIfPossible").
            LEAVE.
        END.
        optn = "InViewPortIfPossible".
        IF norder = 1 THEN optn = optn + CHR(1) + "selected".
        IF CAN-FIND(FIRST orderline OF order)
         THEN optn = optn + CHR(1) + "addOnExpand".
        
        RUN addNode IN h_pure4gltv ("order=" + STRING(order.ordernum)
                                   ,cparentKey
                                   ,STRING(order.ordernum) + " (" + STRING(order.orderdate) + ")"
                                   ,"tvpics/book02.bmp"
                                   ,optn).
    END.  /* for each customer */
    RUN deleteNode IN h_Pure4glTv (pcNodeKey, "refresh").
END. /* add customers to salesrep node */
*/
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE ver_cuadro wWin 
PROCEDURE ver_cuadro :
/*------------------------------------------------------------------------------
  Purpose:   indicadores de la gestion  
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEFINE VAR cttareas AS INT NO-UNDO.
DEFINE VAR ctptareas AS INT NO-UNDO.
DEFINE VAR cuu AS CHAR NO-UNDO.
DEFINE VAR pperiodo AS INT NO-UNDO.
DEFINE VAR sasig AS INT NO-UNDO.
cuu = "".
cttareas = 0.
ctptareas = 0.
EMPTY TEMP-TABLE ttipo.
FIND Usuario WHERE Usuario.cdg_usuario = USERID("sic") NO-LOCK NO-ERROR.
FIND recurso OF usuario NO-LOCK NO-ERROR.
IF AVAILABLE recurso THEN cuu = recurso.cdg_recurso.
  
FOR EACH tarea WHERE tarea.estado = "A" NO-LOCK:
  FIND ttipo WHERE ttipo.cdg = tarea.cdg_tipotarea NO-LOCK NO-ERROR.
  IF NOT AVAILABLE ttipo THEN DO:
      FIND tipo_tarea OF tarea NO-LOCK.
      CREATE ttipo.
      ASSIGN ttipo.cdg =  tarea.cdg_tipotarea
             ttipo.dsc =  Tipo_tarea.dsc_tipotarea.
  END.
  IF durmiendo() < 0  THEN NEXT.
  ttipo.cant = ttipo.cant + 1.
  IF tarea.cdg_recurso = cuu THEN  ctptareas = ctptareas + 1.
END.
FOR EACH ttipo:
      cttareas = cttareas + ttipo.cant.
END.
ttareas = cttareas.
tptareas = ctptareas.

DISPLAY tptareas ttareas WITH FRAME {&FRAME-NAME}.
{&OPEN-QUERY-BROWSE-4}

pperiodo = YEAR(TODAY) * 100 + MONTH(TODAY).
FOR EACH evento NO-LOCK WHERE evento.fasignado = ? AND NOT evento.anulado AND evento.frealizado = ? AND
     evento.periodo <= pperiodo :
   sasig = sasig + 1.
END.
IF sasig > 50 THEN tsasig:FGCOLOR = 12.
DISPLAY sasig @ tsasig WITH FRAME {&FRAME-NAME}.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE viewObject wWin 
PROCEDURE viewObject :
/*------------------------------------------------------------------------------
  Purpose:     Super Override
  Parameters:  
  Notes:       
------------------------------------------------------------------------------*/

  /* Code placed here will execute PRIOR to standard behavior. */

  RUN SUPER.

  /* Code placed here will execute AFTER standard behavior.    */
  RUN ver_cuadro.
  fbatch = 0.
  FOR EACH BATCH NO-LOCK:
      fbatch = fbatch + 1.
  END.
  DISPLAY fbatch WITH FRAME {&FRAME-NAME}.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

/* ************************  Function Implementations ***************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION AddtoEdMsg wWin 
FUNCTION AddtoEdMsg RETURNS LOGICAL
  (pcTxt AS CHAR) :
/*------------------------------------------------------------------------------
  Purpose:  
    Notes:  
------------------------------------------------------------------------------*/
/*

  IF edMsg:LENGTH IN FRAME fMain > 31000 THEN edMsg:SCREEN-VALUE =
    SUBSTR(edMsg:SCREEN-VALUE,1000).
       
  edmsg:CURSOR-OFFSET = edmsg:LENGTH + 1.
  edMsg:INSERT-STRING(pcTxt).
*/  
  RETURN YES.   /* Function return value. */

END FUNCTION.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION durmiendo wWin 
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

