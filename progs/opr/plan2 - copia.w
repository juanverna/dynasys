
&ANALYZE-SUSPEND _VERSION-NUMBER UIB_v9r12 GUI
&ANALYZE-RESUME
/* Connected Databases 
          sic              PROGRESS
*/
&Scoped-define WINDOW-NAME C-Win
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _DEFINITIONS C-Win 
/*------------------------------------------------------------------------

  File: 

  Description: 

  Input Parameters:
      <none>

  Output Parameters:
      <none>

  Author: 

  Created: 

------------------------------------------------------------------------*/
/*          This .W file was created with the Progress AppBuilder.      */
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

/*temp tables recursos*/

{tablasTT-opr.i}


DEFINE TEMP-TABLE balanceo NO-UNDO
    FIELD cdg_recurso LIKE recurso.cdg_recurso
    FIELD utilizacion AS INTEGER
    FIELD disponible AS INTEGER
    FIELD prioridad   AS INTEGER
    FIELD turno       AS CHAR LABEL "TU"
    INDEX prior1           utilizacion ASCENDING prioridad DESCENDING
    INDEX baln             cdg_recurso
    INDEX utilz IS PRIMARY utilizacion.

DEFINE BUFFER bevento    FOR evento.
DEFINE BUFFER banalizado FOR analizado.

DEFINE TEMP-TABLE aanalizar /*tabla que contiene los analizados cuyo sub_evento en 1 ya que en el loop de analizar se modifica en indice*/
    FIELD nro_evento AS INT
    FIELD ind        AS INTEGER
    INDEX idx IS PRIMARY ind.

DEFINE VAR nplan              AS INTEGER       NO-UNDO.

DEFINE VAR h_capac            AS WIDGET-HANDLE NO-UNDO.
DEFINE VAR h_restriccion      AS WIDGET-HANDLE NO-UNDO.
DEFINE VAR h_consorcios       AS WIDGET-HANDLE NO-UNDO.
DEFINE VAR h_rvalor           AS WIDGET-HANDLE NO-UNDO.
DEFINE VAR h_balanceo         AS WIDGET-HANDLE NO-UNDO.
DEFINE VAR h_analizado        AS WIDGET-HANDLE NO-UNDO.
DEFINE VAR h_agenda_recursos  AS WIDGET-HANDLE NO-UNDO.
DEFINE VAR h_eventos          AS WIDGET-HANDLE NO-UNDO.
DEFINE VAR h_recursos         AS WIDGET-HANDLE NO-UNDO.
DEFINE VAR h_aseventos        AS WIDGET-HANDLE NO-UNDO.
DEFINE VAR h_naseventos       AS WIDGET-HANDLE NO-UNDO.
DEFINE VAR h_administraciones AS WIDGET-HANDLE NO-UNDO.
{tiempo.i}
{findempresa.i}
{GeoLibrary.I}

DEFINE TEMP-TABLE evearea NO-UNDO
    FIELD nro_evento LIKE evento.nro_evento
    FIELD direccion LIKE cliente.direccion
    FIELD recursos LIKE evento.recursos
    FIELD distancia AS INT.


/*Se multiplica por la distancia para obtener el tiempo adicional del viaje*/
/* DEFINE TEMP-TABLE addTrans NO-UNDO       */
/*     FIELD distancia AS DECIMAL           */
/*     FIELD multiplicador AS decimal       */
/*     FIELD transporte AS CHAR INITIAL "P" */
/*     INDEX idx1 distancia.                */
/*                                          */
/* CREATE addtrans.                         */
/* ASSIGN distancia = 800                   */
/*        multiplicador = 0.02              */
/*        transporte = "P".                 */
/* CREATE addtrans.                         */
/* ASSIGN distancia = 5000                  */
/*        adicional = 0.006                 */
/*        transporte = "C".                 */
/*                                          */


DEFINE VAR dgeoinc     AS DECIMAL INITIAL 100 NO-UNDO.
DEFINE VAR dgeomaxmax  AS DECIMAL INITIAL 800 NO-UNDO.
DEFINE VAR corrida     AS INT NO-UNDO INITIAL 1.
DEFINE VAR miraerrores AS LOGICAL NO-UNDO.

/*es un flag si le da bola o no a los avisos*/
DEFINE VAR VERAVISOS   AS LOGICAL INITIAL TRUE NO-UNDO. 

/*balanceo avisos*/
DEFINE TEMP-TABLE balaviso 
    FIELD cdg_recurso LIKE recurso.cdg_recurso
    FIELD fecha       AS DATE
    FIELD ocupados    AS INT
    FIELD cantidad    AS INT
    INDEX fecha    fecha
    INDEX cantidad cantidad.

{stavisado.i}

DEFINE TEMP-TABLE vecinos
    FIELD nro_evento LIKE evento.nro_evento
    FIELD distancia  AS DECIMAL
    INDEX distancia distancia.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE Window
&Scoped-define DB-AWARE no

/* Name of designated FRAME-NAME and/or first browse and/or first query */
&Scoped-define FRAME-NAME DEFAULT-FRAME

/* Internal Tables (found by Frame, Query & Browse Queries)             */
&Scoped-define INTERNAL-TABLES Restriccion

/* Definitions for FRAME DEFAULT-FRAME                                  */
&Scoped-define QUERY-STRING-DEFAULT-FRAME FOR EACH Restriccion SHARE-LOCK
&Scoped-define OPEN-QUERY-DEFAULT-FRAME OPEN QUERY DEFAULT-FRAME FOR EACH Restriccion SHARE-LOCK.
&Scoped-define TABLES-IN-QUERY-DEFAULT-FRAME Restriccion
&Scoped-define FIRST-TABLE-IN-QUERY-DEFAULT-FRAME Restriccion


/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS RECT-1 v-origen c_nro_tipo_evento ~
dsc_tipo_evento cdisponibles cteventos b-nasig-3 ctasig b-nasig-2 ~
cnecesarios ctnasig b-nasig num-analizado maxdia faddoper tcapacidad ~
Tavisos Tlimpia Bcapac Bagenda_recurso tturno fdesbrec BUTTON-2 Beventos ~
trdur v-mes v-ano BUTTON-8 BUTTON-11 brecursos pbloque ptentativos ultdia ~
pridia BUTTON-7 BUTTON-6 BUTTON-5 maximo_avisos_dia BUTTON-10 Bborraultimo 
&Scoped-Define DISPLAYED-OBJECTS v-origen c_nro_tipo_evento dsc_tipo_evento ~
cdisponibles cteventos ctasig cnecesarios ctnasig num-analizado maxdia ~
faddoper tcapacidad Tavisos dgeomax v-corrida Tlimpia tturno v-sinasig ~
fdesbrec trdur v-mes v-ano pbloque ptentativos ultdia pridia ~
maximo_avisos_dia 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME


/* ************************  Function Prototypes ********************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION-FORWARD asignado_dia C-Win 
FUNCTION asignado_dia RETURNS INTEGER
    ( INPUT p-nro_tipo_evento AS INT , INPUT pcodigo AS CHAR , INPUT pfecha AS DATE )  FORWARD.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION-FORWARD asignar_dia C-Win 
FUNCTION asignar_dia RETURNS LOGICAL
    ( nro AS INT , fecha AS DATE )  FORWARD.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION-FORWARD asignar_evento C-Win 
FUNCTION asignar_evento RETURNS LOGICAL
    ( pnro_evento AS INTEGER , analizar_compatibilidad AS LOGICAL ,pind AS INT)  FORWARD.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION-FORWARD calcula_encadenado C-Win 
FUNCTION calcula_encadenado RETURNS INTEGER
    ( pagrupado AS CHARACTER )  FORWARD.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION-FORWARD cerrar C-Win 
FUNCTION cerrar RETURNS LOGICAL
    ( hh AS WIDGET-HANDLE )  FORWARD.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION-FORWARD compatible C-Win 
FUNCTION compatible RETURNS LOGICAL
    ( pnro-evento AS INT , lista AS CHAR, pfecha AS DATE )  FORWARD.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION-FORWARD disponible C-Win 
FUNCTION disponible RETURNS LOGICAL
    ( INPUT p-nro_tipo_evento AS INT , INPUT lista AS CHAR , pfecha AS DATE , durac AS INT ,pturno AS CHAR )  FORWARD.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION-FORWARD duref C-Win 
FUNCTION duref RETURNS INT
    ( d AS CHAR, h AS CHAR )  FORWARD.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION-FORWARD eventosxdia C-Win 
FUNCTION eventosxdia RETURNS INTEGER
    ( ptipo AS INT , pcdg_recurso AS CHAR , pfecha AS DATE, pturno AS CHAR )  FORWARD.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION-FORWARD rdur C-Win 
FUNCTION rdur RETURNS INTEGER
    ( rr AS INT )  FORWARD.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION-FORWARD tienerestriccion C-Win 
FUNCTION tienerestriccion RETURNS LOGICAL
    ( prow AS ROWID )  FORWARD.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION-FORWARD ubicar_evento C-Win 
FUNCTION ubicar_evento RETURNS LOGICAL
    ( INPUT lista AS CHAR, pnro_evento AS INT , pmobs AS CHAR , recadd AS INT , analizar_compatibilidad AS LOGICAL,forzado AS LOGICAL,mejorvecino AS LOGICAL)  FORWARD.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION-FORWARD ubicar_N_evento C-Win 
FUNCTION ubicar_N_evento RETURNS INTEGER
    ( pnro_evento AS INT, N AS INT , vm AS CHAR, recadd AS INT , analizar_compatibilidad AS LOGICAL)  FORWARD.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION-FORWARD wmobs C-Win 
FUNCTION wmobs RETURNS CHARACTER
    ( m AS CHAR , w AS CHAR )  FORWARD.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


/* ***********************  Control Definitions  ********************** */

/* Define the widget handle for the window                              */
DEFINE VAR C-Win AS WIDGET-HANDLE NO-UNDO.

/* Menu Definitions                                                     */
DEFINE MENU POPUP-MENU-BUTTON-9 
       MENU-ITEM m_Set_plan     LABEL "Set plan"      .


/* Definitions of handles for OCX Containers                            */
DEFINE VARIABLE ProgressBar-1 AS WIDGET-HANDLE NO-UNDO.
DEFINE VARIABLE chProgressBar-1 AS COMPONENT-HANDLE NO-UNDO.
DEFINE VARIABLE ProgressBar-2 AS WIDGET-HANDLE NO-UNDO.
DEFINE VARIABLE chProgressBar-2 AS COMPONENT-HANDLE NO-UNDO.
DEFINE VARIABLE ProgressBar-3 AS WIDGET-HANDLE NO-UNDO.
DEFINE VARIABLE chProgressBar-3 AS COMPONENT-HANDLE NO-UNDO.
DEFINE VARIABLE ProgressBar-4 AS WIDGET-HANDLE NO-UNDO.
DEFINE VARIABLE chProgressBar-4 AS COMPONENT-HANDLE NO-UNDO.
DEFINE VARIABLE ProgressBar-5 AS WIDGET-HANDLE NO-UNDO.
DEFINE VARIABLE chProgressBar-5 AS COMPONENT-HANDLE NO-UNDO.
DEFINE VARIABLE ProgressBar-6 AS WIDGET-HANDLE NO-UNDO.
DEFINE VARIABLE chProgressBar-6 AS COMPONENT-HANDLE NO-UNDO.

/* Definitions of the field level widgets                               */
DEFINE BUTTON b-nasig 
     LABEL "NA" 
     SIZE 4 BY .95.

DEFINE BUTTON b-nasig-2 
     LABEL "AS" 
     SIZE 4 BY .95 TOOLTIP "Eventos Asignados".

DEFINE BUTTON b-nasig-3 
     LABEL "AN" 
     SIZE 4 BY .95 TOOLTIP "No asignados".

DEFINE BUTTON Bagenda_recurso 
     LABEL "Agenda Recurso" 
     SIZE 19 BY 1.14.

DEFINE BUTTON Bborraultimo 
     LABEL "Borra Ultimo" 
     SIZE 20 BY 1.14.

DEFINE BUTTON Bcapac 
     LABEL "Capacidades" 
     SIZE 15 BY 1.14.

DEFINE BUTTON Beventos 
     LABEL "Eventos" 
     SIZE 19 BY 1.14.

DEFINE BUTTON brecursos 
     LABEL "Recursos" 
     SIZE 19 BY 1.14.

DEFINE BUTTON BUTTON-10 
     LABEL "Ejecutar" 
     SIZE 15 BY 1.14.

DEFINE BUTTON BUTTON-11 
     LABEL "Adm" 
     SIZE 7 BY 1.14.

DEFINE BUTTON BUTTON-2 
     LABEL "Restricciones" 
     SIZE 15 BY 1.14.

DEFINE BUTTON BUTTON-5 
     LABEL "Analizado" 
     SIZE 12 BY 1.14.

DEFINE BUTTON BUTTON-6 
     LABEL "Rvalor" 
     SIZE 11 BY 1.14.

DEFINE BUTTON BUTTON-7 
     LABEL "Balanceo" 
     SIZE 10 BY 1.14.

DEFINE BUTTON BUTTON-8 
     LABEL "Cons" 
     SIZE 7 BY 1.14.

DEFINE VARIABLE c_nro_tipo_evento AS INTEGER FORMAT ">>>>>>>>9" INITIAL 1 
     LABEL "Tipo" 
     VIEW-AS COMBO-BOX INNER-LINES 15
     LIST-ITEM-PAIRS "0",1
     DROP-DOWN-LIST
     SIZE 10.2 BY 1 TOOLTIP "Tipo de Restriccion o Tipo de Evento".

DEFINE VARIABLE v-origen AS CHARACTER FORMAT "X(256)":U INITIAL "CONTRATO" 
     VIEW-AS COMBO-BOX INNER-LINES 10
     LIST-ITEMS "CONTRATO","COBRANZA","ENVIO","AVISO" 
     DROP-DOWN-LIST
     SIZE 18 BY 1 TOOLTIP "Entidad que dio origen al evento" NO-UNDO.

DEFINE VARIABLE cdisponibles AS INTEGER FORMAT "->,>>>,>>9":U INITIAL 0 
     LABEL "Disponibles" 
     VIEW-AS FILL-IN 
     SIZE 14 BY 1 TOOLTIP "Minutos disponibles recursos" NO-UNDO.

DEFINE VARIABLE cnecesarios AS INTEGER FORMAT "->,>>>,>>9":U INITIAL 0 
     LABEL "Necesarios" 
     VIEW-AS FILL-IN 
     SIZE 14 BY 1 NO-UNDO.

DEFINE VARIABLE ctasig AS INTEGER FORMAT "->,>>>,>>9":U INITIAL 0 
     LABEL "Asignados" 
     VIEW-AS FILL-IN 
     SIZE 14 BY 1 NO-UNDO.

DEFINE VARIABLE cteventos AS INTEGER FORMAT "->,>>>,>>9":U INITIAL 0 
     LABEL "Eventos" 
     VIEW-AS FILL-IN 
     SIZE 14 BY 1 NO-UNDO.

DEFINE VARIABLE ctnasig AS INTEGER FORMAT "->,>>>,>>9":U INITIAL 0 
     LABEL "No Asig." 
     VIEW-AS FILL-IN 
     SIZE 14 BY 1 NO-UNDO.

DEFINE VARIABLE dgeomax AS DECIMAL FORMAT ">>>>9":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 9 BY 1 NO-UNDO.

DEFINE VARIABLE dsc_tipo_evento AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 22.2 BY 1 NO-UNDO.

DEFINE VARIABLE maxdia AS INTEGER FORMAT "99":U INITIAL 3 
     LABEL "MD" 
     VIEW-AS FILL-IN 
     SIZE 5 BY 1 TOOLTIP "Cantidad maxima de eventos por dia" NO-UNDO.

DEFINE VARIABLE maximo_avisos_dia AS INTEGER FORMAT ">9":U INITIAL 4 
     LABEL "MaxAv" 
     VIEW-AS FILL-IN 
     SIZE 3.6 BY 1 NO-UNDO.

DEFINE VARIABLE num-analizado AS INTEGER FORMAT "->,>>>,>>9":U INITIAL 0 
     LABEL "Bloques" 
     VIEW-AS FILL-IN 
     SIZE 14 BY 1 NO-UNDO.

DEFINE VARIABLE pbloque AS CHARACTER FORMAT "X(256)":U INITIAL "!*" 
     LABEL "OPB" 
     VIEW-AS FILL-IN 
     SIZE 17 BY 1 TOOLTIP "Lista de operarios cuyos consorsorcios se romperan bloque" NO-UNDO.

DEFINE VARIABLE pridia AS DATE FORMAT "99/99/9999":U 
     LABEL "del" 
     VIEW-AS FILL-IN 
     SIZE 15.6 BY 1 NO-UNDO.

DEFINE VARIABLE ptentativos AS CHARACTER FORMAT "X(256)":U INITIAL "!*" 
     LABEL "OPT" 
     VIEW-AS FILL-IN 
     SIZE 17 BY 1 TOOLTIP "Operarios a pasar la tentativos" NO-UNDO.

DEFINE VARIABLE ultdia AS DATE FORMAT "99/99/9999":U 
     LABEL "a" 
     VIEW-AS FILL-IN 
     SIZE 15.2 BY 1 NO-UNDO.

DEFINE VARIABLE v-ano AS INTEGER FORMAT "9999":U INITIAL 0 
     LABEL "" 
     VIEW-AS FILL-IN 
     SIZE 7 BY 1 NO-UNDO.

DEFINE VARIABLE v-corrida AS INTEGER FORMAT "->,>>>,>>9":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 9 BY 1 NO-UNDO.

DEFINE VARIABLE v-mes AS INTEGER FORMAT ">9":U INITIAL 0 
     LABEL "Periodo" 
     VIEW-AS FILL-IN 
     SIZE 6 BY 1 NO-UNDO.

DEFINE VARIABLE v-sinasig AS INTEGER FORMAT "->,>>>,>>9":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 9 BY 1 NO-UNDO.

DEFINE RECTANGLE RECT-1
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 58 BY 8.1.

DEFINE VARIABLE faddoper AS LOGICAL INITIAL no 
     LABEL "Agrega Recursos" 
     VIEW-AS TOGGLE-BOX
     SIZE 21 BY .81 TOOLTIP "Agrega operarios para disminuir el tiempo" NO-UNDO.

DEFINE VARIABLE fdesbrec AS LOGICAL INITIAL no 
     LABEL "Cambio Recurso" 
     VIEW-AS TOGGLE-BOX
     SIZE 20 BY .81 TOOLTIP "Cambio de recurso cuando la agenda este agotada" NO-UNDO.

DEFINE VARIABLE Tavisos AS LOGICAL INITIAL yes 
     LABEL "Avisos" 
     VIEW-AS TOGGLE-BOX
     SIZE 11 BY .81 TOOLTIP "Si se procesan los avisos" NO-UNDO.

DEFINE VARIABLE tcapacidad AS LOGICAL INITIAL yes 
     LABEL "Capacid" 
     VIEW-AS TOGGLE-BOX
     SIZE 13 BY .81 TOOLTIP "Evalua la capacidad o las horas trabajadas" NO-UNDO.

DEFINE VARIABLE Tlimpia AS LOGICAL INITIAL no 
     LABEL "Limpia Agenda" 
     VIEW-AS TOGGLE-BOX
     SIZE 21 BY .81 NO-UNDO.

DEFINE VARIABLE trdur AS LOGICAL INITIAL no 
     LABEL "Rdur" 
     VIEW-AS TOGGLE-BOX
     SIZE 11 BY .81 TOOLTIP "Cambio de recurso cuando la agenda este agotada" NO-UNDO.

DEFINE VARIABLE tturno AS LOGICAL INITIAL yes 
     LABEL "Turnos" 
     VIEW-AS TOGGLE-BOX
     SIZE 13.4 BY .81 TOOLTIP "Evalua los turnos segun restriccion" NO-UNDO.

/* Query definitions                                                    */
&ANALYZE-SUSPEND
DEFINE QUERY DEFAULT-FRAME FOR 
      Restriccion SCROLLING.
&ANALYZE-RESUME

/* ************************  Frame Definitions  *********************** */

DEFINE FRAME DEFAULT-FRAME
     v-origen AT ROW 1.48 COL 2 NO-LABEL WIDGET-ID 42
     c_nro_tipo_evento AT ROW 1.48 COL 23.8 COLON-ALIGNED
     dsc_tipo_evento AT ROW 1.48 COL 35.8 COLON-ALIGNED NO-LABEL WIDGET-ID 12
     cdisponibles AT ROW 2.91 COL 11 COLON-ALIGNED WIDGET-ID 64
     cteventos AT ROW 2.91 COL 39 COLON-ALIGNED WIDGET-ID 108
     b-nasig-3 AT ROW 2.91 COL 56 WIDGET-ID 78
     ctasig AT ROW 4 COL 39 COLON-ALIGNED
     b-nasig-2 AT ROW 4 COL 56 WIDGET-ID 52
     cnecesarios AT ROW 4.1 COL 11 COLON-ALIGNED WIDGET-ID 66
     ctnasig AT ROW 4.95 COL 39 COLON-ALIGNED
     b-nasig AT ROW 5.05 COL 56 WIDGET-ID 50
     num-analizado AT ROW 5.29 COL 11 COLON-ALIGNED
     maxdia AT ROW 6.43 COL 29 COLON-ALIGNED WIDGET-ID 116
     faddoper AT ROW 6.48 COL 2 WIDGET-ID 70
     tcapacidad AT ROW 6.48 COL 40 WIDGET-ID 104
     Tavisos AT ROW 6.48 COL 53 WIDGET-ID 130
     dgeomax AT ROW 6.95 COL 100 COLON-ALIGNED NO-LABEL WIDGET-ID 110
     v-corrida AT ROW 6.95 COL 110 COLON-ALIGNED NO-LABEL WIDGET-ID 80
     Tlimpia AT ROW 7.19 COL 40 WIDGET-ID 126
     Bcapac AT ROW 7.67 COL 2
     Bagenda_recurso AT ROW 7.67 COL 18 WIDGET-ID 4
     tturno AT ROW 7.91 COL 40 WIDGET-ID 86
     v-sinasig AT ROW 8.14 COL 110 COLON-ALIGNED NO-LABEL WIDGET-ID 122
     fdesbrec AT ROW 8.62 COL 40 WIDGET-ID 68
     BUTTON-2 AT ROW 8.86 COL 2
     Beventos AT ROW 8.86 COL 18 WIDGET-ID 6
     trdur AT ROW 9.33 COL 40 WIDGET-ID 114
     v-mes AT ROW 9.86 COL 83.8 COLON-ALIGNED
     v-ano AT ROW 9.86 COL 91.8 COLON-ALIGNED
     BUTTON-8 AT ROW 10.05 COL 2 WIDGET-ID 54
     BUTTON-11 AT ROW 10.05 COL 10 WIDGET-ID 124
     brecursos AT ROW 10.05 COL 18 WIDGET-ID 16
     pbloque AT ROW 10.05 COL 43 COLON-ALIGNED WIDGET-ID 106
     ptentativos AT ROW 11 COL 43 COLON-ALIGNED WIDGET-ID 112
     ultdia AT ROW 11.29 COL 92.8 COLON-ALIGNED WIDGET-ID 76
     pridia AT ROW 11.33 COL 74.4 COLON-ALIGNED WIDGET-ID 74
     BUTTON-7 AT ROW 11.71 COL 2 WIDGET-ID 22
     BUTTON-6 AT ROW 11.71 COL 13 WIDGET-ID 20
     BUTTON-5 AT ROW 11.71 COL 25 WIDGET-ID 18
     maximo_avisos_dia AT ROW 11.95 COL 53 COLON-ALIGNED WIDGET-ID 128
     BUTTON-10 AT ROW 12.91 COL 76 WIDGET-ID 120
     Bborraultimo AT ROW 12.91 COL 94 WIDGET-ID 56
     "Asignacion" VIEW-AS TEXT
          SIZE 13 BY .62 AT ROW 6.95 COL 67 WIDGET-ID 30
     "Analizando" VIEW-AS TEXT
          SIZE 13 BY .62 AT ROW 4.57 COL 67 WIDGET-ID 26
     "Iniciar" VIEW-AS TEXT
          SIZE 14 BY .62 AT ROW 3.38 COL 67 WIDGET-ID 24
     "Asignacion inteligente" VIEW-AS TEXT
          SIZE 51 BY 1.19 AT ROW 13.05 COL 9 WIDGET-ID 82
          FONT 25
     "Avisos" VIEW-AS TEXT
          SIZE 13 BY .62 AT ROW 8.14 COL 67 WIDGET-ID 32
     "Actualiza" VIEW-AS TEXT
          SIZE 14 BY .62 AT ROW 2.43 COL 67 WIDGET-ID 72
     "Valorizando" VIEW-AS TEXT
          SIZE 13 BY .62 AT ROW 5.76 COL 67 WIDGET-ID 28
     RECT-1 AT ROW 1.48 COL 65
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 122.2 BY 13.62.


/* *********************** Procedure Settings ************************ */

&ANALYZE-SUSPEND _PROCEDURE-SETTINGS
/* Settings for THIS-PROCEDURE
   Type: Window
   Allow: Basic,Browse,DB-Fields,Window,Query
   Other Settings: COMPILE
 */
&ANALYZE-RESUME _END-PROCEDURE-SETTINGS

/* *************************  Create Window  ************************** */

&ANALYZE-SUSPEND _CREATE-WINDOW
IF SESSION:DISPLAY-TYPE = "GUI":U THEN
  CREATE WINDOW C-Win ASSIGN
         HIDDEN             = YES
         TITLE              = "Asignacion de Recursos"
         HEIGHT             = 13.52
         WIDTH              = 122.2
         MAX-HEIGHT         = 35.67
         MAX-WIDTH          = 256
         VIRTUAL-HEIGHT     = 35.67
         VIRTUAL-WIDTH      = 256
         RESIZE             = yes
         SCROLL-BARS        = no
         STATUS-AREA        = no
         BGCOLOR            = ?
         FGCOLOR            = ?
         KEEP-FRAME-Z-ORDER = yes
         THREE-D            = yes
         MESSAGE-AREA       = no
         SENSITIVE          = yes.
ELSE {&WINDOW-NAME} = CURRENT-WINDOW.
/* END WINDOW DEFINITION                                                */
&ANALYZE-RESUME



/* ***********  Runtime Attributes and AppBuilder Settings  *********** */

&ANALYZE-SUSPEND _RUN-TIME-ATTRIBUTES
/* SETTINGS FOR WINDOW C-Win
  VISIBLE,,RUN-PERSISTENT                                               */
/* SETTINGS FOR FRAME DEFAULT-FRAME
   FRAME-NAME                                                           */
ASSIGN 
       Bborraultimo:POPUP-MENU IN FRAME DEFAULT-FRAME       = MENU POPUP-MENU-BUTTON-9:HANDLE.

ASSIGN 
       cdisponibles:READ-ONLY IN FRAME DEFAULT-FRAME        = TRUE.

ASSIGN 
       cnecesarios:READ-ONLY IN FRAME DEFAULT-FRAME        = TRUE.

ASSIGN 
       ctasig:READ-ONLY IN FRAME DEFAULT-FRAME        = TRUE.

ASSIGN 
       cteventos:READ-ONLY IN FRAME DEFAULT-FRAME        = TRUE.

ASSIGN 
       ctnasig:READ-ONLY IN FRAME DEFAULT-FRAME        = TRUE.

/* SETTINGS FOR FILL-IN dgeomax IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
ASSIGN 
       dsc_tipo_evento:READ-ONLY IN FRAME DEFAULT-FRAME        = TRUE.

ASSIGN 
       num-analizado:READ-ONLY IN FRAME DEFAULT-FRAME        = TRUE.

/* SETTINGS FOR FILL-IN v-corrida IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR COMBO-BOX v-origen IN FRAME DEFAULT-FRAME
   ALIGN-L                                                              */
/* SETTINGS FOR FILL-IN v-sinasig IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(C-Win)
THEN C-Win:HIDDEN = no.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME


/* Setting information for Queries and Browse Widgets fields            */

&ANALYZE-SUSPEND _QUERY-BLOCK FRAME DEFAULT-FRAME
/* Query rebuild information for FRAME DEFAULT-FRAME
     _TblList          = "sic.Restriccion"
     _Query            is OPENED
*/  /* FRAME DEFAULT-FRAME */
&ANALYZE-RESUME

 


/* **********************  Create OCX Containers  ********************** */

&ANALYZE-SUSPEND _CREATE-DYNAMIC

&IF "{&OPSYS}" = "WIN32":U AND "{&WINDOW-SYSTEM}" NE "TTY":U &THEN

CREATE CONTROL-FRAME ProgressBar-1 ASSIGN
       FRAME           = FRAME DEFAULT-FRAME:HANDLE
       ROW             = 2.19
       COLUMN          = 79
       HEIGHT          = .71
       WIDTH           = 42
       WIDGET-ID       = 58
       HIDDEN          = no
       SENSITIVE       = yes.

CREATE CONTROL-FRAME ProgressBar-2 ASSIGN
       FRAME           = FRAME DEFAULT-FRAME:HANDLE
       ROW             = 3.38
       COLUMN          = 79
       HEIGHT          = .71
       WIDTH           = 42
       WIDGET-ID       = 132
       HIDDEN          = no
       SENSITIVE       = yes.

CREATE CONTROL-FRAME ProgressBar-3 ASSIGN
       FRAME           = FRAME DEFAULT-FRAME:HANDLE
       ROW             = 4.57
       COLUMN          = 79
       HEIGHT          = .71
       WIDTH           = 42
       WIDGET-ID       = 134
       HIDDEN          = no
       SENSITIVE       = yes.

CREATE CONTROL-FRAME ProgressBar-4 ASSIGN
       FRAME           = FRAME DEFAULT-FRAME:HANDLE
       ROW             = 5.76
       COLUMN          = 79
       HEIGHT          = .71
       WIDTH           = 42
       WIDGET-ID       = 136
       HIDDEN          = no
       SENSITIVE       = yes.

CREATE CONTROL-FRAME ProgressBar-5 ASSIGN
       FRAME           = FRAME DEFAULT-FRAME:HANDLE
       ROW             = 6.95
       COLUMN          = 79
       HEIGHT          = .71
       WIDTH           = 22
       WIDGET-ID       = 138
       HIDDEN          = no
       SENSITIVE       = yes.

CREATE CONTROL-FRAME ProgressBar-6 ASSIGN
       FRAME           = FRAME DEFAULT-FRAME:HANDLE
       ROW             = 8.14
       COLUMN          = 79
       HEIGHT          = .71
       WIDTH           = 30
       WIDGET-ID       = 140
       HIDDEN          = no
       SENSITIVE       = yes.
/* ProgressBar-1 OCXINFO:CREATE-CONTROL from: {4A5E5E35-91F4-46B1-B62F-78148132EF93} type: XP_ProgressBar */
/* ProgressBar-2 OCXINFO:CREATE-CONTROL from: {4A5E5E35-91F4-46B1-B62F-78148132EF93} type: XP_ProgressBar */
/* ProgressBar-3 OCXINFO:CREATE-CONTROL from: {4A5E5E35-91F4-46B1-B62F-78148132EF93} type: XP_ProgressBar */
/* ProgressBar-4 OCXINFO:CREATE-CONTROL from: {4A5E5E35-91F4-46B1-B62F-78148132EF93} type: XP_ProgressBar */
/* ProgressBar-5 OCXINFO:CREATE-CONTROL from: {4A5E5E35-91F4-46B1-B62F-78148132EF93} type: XP_ProgressBar */
/* ProgressBar-6 OCXINFO:CREATE-CONTROL from: {4A5E5E35-91F4-46B1-B62F-78148132EF93} type: XP_ProgressBar */
      ProgressBar-1:MOVE-AFTER(dsc_tipo_evento:HANDLE IN FRAME DEFAULT-FRAME).
      ProgressBar-2:MOVE-AFTER(b-nasig-3:HANDLE IN FRAME DEFAULT-FRAME).
      ProgressBar-3:MOVE-AFTER(cnecesarios:HANDLE IN FRAME DEFAULT-FRAME).
      ProgressBar-4:MOVE-AFTER(num-analizado:HANDLE IN FRAME DEFAULT-FRAME).
      ProgressBar-5:MOVE-AFTER(Tavisos:HANDLE IN FRAME DEFAULT-FRAME).
      ProgressBar-6:MOVE-AFTER(tturno:HANDLE IN FRAME DEFAULT-FRAME).

&ENDIF

&ANALYZE-RESUME /* End of _CREATE-DYNAMIC */


/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME C-Win
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON END-ERROR OF C-Win /* Asignacion de Recursos */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE 
    DO:
        /* This case occurs when the user presses the "Esc" key.
           In a persistently run window, just ignore this.  If we did not, the
           application would exit. */
        IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
    END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON WINDOW-CLOSE OF C-Win /* Asignacion de Recursos */
DO:
        /* This event will close the window and terminate the procedure.  */
        cerrar(h_capac).
        cerrar(h_restriccion).
        cerrar(h_consorcios).
        cerrar(h_rvalor).
        cerrar(h_balanceo).
        cerrar(h_analizado).
        cerrar(h_agenda_recursos).
        cerrar(h_eventos).
        cerrar(h_aseventos).
        cerrar(h_naseventos).
        cerrar(h_recursos).
        cerrar(h_administraciones).

        APPLY "CLOSE":U TO THIS-PROCEDURE.
        RETURN NO-APPLY.
    END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME b-nasig
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL b-nasig C-Win
ON CHOOSE OF b-nasig IN FRAME DEFAULT-FRAME /* NA */
DO:
        ASSIGN v-origen  c_nro_tipo_evento  v-mes  v-ano.
        IF NOT valid-handle(h_naseventos) THEN 
        DO:
            RUN w-evento.w PERSISTENT SET h_naseventos ( FALSE ,?, v-origen , c_nro_tipo_evento , v-mes , v-ano ,?,?).
            RUN dispatch IN h_naseventos ( INPUT 'initialize':U ) .
        END.
        ELSE DYNAMIC-FUNCTION("tope" IN h_naseventos ). 
    END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME b-nasig-2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL b-nasig-2 C-Win
ON CHOOSE OF b-nasig-2 IN FRAME DEFAULT-FRAME /* AS */
DO:
        ASSIGN v-origen  c_nro_tipo_evento  v-mes  v-ano.
        IF NOT valid-handle(h_aseventos) THEN 
        DO:
            RUN w-evento.w PERSISTENT SET h_aseventos ( TRUE ,?, v-origen , c_nro_tipo_evento , v-mes , v-ano ,?,?).
            RUN dispatch IN h_aseventos ( INPUT 'initialize':U ) .
        END.
        ELSE DYNAMIC-FUNCTION("tope" IN h_aseventos ). 
    END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME b-nasig-3
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL b-nasig-3 C-Win
ON CHOOSE OF b-nasig-3 IN FRAME DEFAULT-FRAME /* AN */
DO:
        ASSIGN v-origen  c_nro_tipo_evento  v-mes  v-ano.
        IF NOT valid-handle(h_aseventos) THEN 
        DO:
            RUN w-evento.w PERSISTENT SET h_aseventos ( FALSE , ?,v-origen , c_nro_tipo_evento , v-mes , v-ano , nplan,?).
            RUN dispatch IN h_aseventos ( INPUT 'initialize':U ) .
        END.
        ELSE DYNAMIC-FUNCTION("tope" IN h_aseventos ). 
    END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME Bagenda_recurso
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Bagenda_recurso C-Win
ON CHOOSE OF Bagenda_recurso IN FRAME DEFAULT-FRAME /* Agenda Recurso */
DO:
        IF NOT valid-handle(h_agenda_recursos) THEN 
        DO:
            RUN w-agenda_recurso.w PERSISTENT SET h_agenda_recursos .
            RUN dispatch IN h_agenda_recursos ( INPUT 'initialize':U ) .
        END.
        ELSE DYNAMIC-FUNCTION("tope" IN h_agenda_recursos ). 
    END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME Bborraultimo
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Bborraultimo C-Win
ON CHOOSE OF Bborraultimo IN FRAME DEFAULT-FRAME /* Borra Ultimo */
DO:
        DEFINE VAR preg      AS LOGICAL NO-UNDO.
        DEFINE VAR LAST_plan AS INT NO-UNDO.
        DEFINE BUFFER aviso FOR evento.


        chProgressBar-6:XP_ProgressBar:MIN = 0. 
        chProgressBar-6:XP_ProgressBar:max = 2. 
        chProgressBar-6:XP_ProgressBar:VALUE = 0. 
        FOR EACH evento NO-LOCK BREAK BY Evento.nro_planasignar DESC :
            LAST_plan = evento.nro_plan.
            LEAVE.
        END.

        MESSAGE "Se eliminaran/desasignaran los evento NO realizados y NO avisados y NO Bloqueados" SKIP
            "del plan " LAST_plan VIEW-AS ALERT-BOX INFORMATION BUTTONS OK-CANCEL UPDATE preg.
        IF NOT preg THEN RETURN NO-APPLY.

        FOR EACH evento WHERE nro_planasignar = LAST_plan AND  NOT evento.frealizado<>? AND NOT bloqueado:
            IF 
                index("RBT",stavisado(evento.nro_evento)) <> 0 THEN NEXT.
            FOR EACH recurso_agenda WHERE recurso_agenda.nro_evento = evento.nro_evento:
                DELETE recurso_agenda. 
            END.
            /*procesamientos de los avisos*/
            FOR EACH bevento WHERE bevento.rEFevento = evento.nro_evento:
                FOR EACH recurso_agenda WHERE recurso_agenda.nro_evento = bevento.nro_evento:
                    DELETE recurso_agenda. 
                END.
                DELETE bevento.
            END.
            IF evento.origen = "COBRANZA" THEN 
            DO:
                evento.fasignado = ?.
                evento.recurso = "".
                evento.nro_plan = 0.
            END.
            IF evento.origen = "CONTRATO" THEN 
            DO:
                FIND contrato_hd WHERE contrato_hd.nro_contrato = evento.nro_identificacion NO-LOCK NO-ERROR.
                IF NOT AVAILABLE contrato_hd THEN 
                DO:
                    FOR EACH aviso WHERE aviso.refevento = evento.nro_evento:
                        FOR EACH recurso_agenda WHERE recurso_agenda.nro_evento = aviso.nro_evento:
                            DELETE recurso_agenda. 
                        END.
                        DELETE aviso.
                    END.
                    FOR EACH tarea WHERE tarea.nro_identificacion = evento.nro_evento AND
                        tarea.origen = "EVENTO": 
                        DELETE tarea. 
                    END.
                    DELETE evento.
                END.
                ELSE 
                DO:
                    IF contrato_hd.cant_periodos <> 0 THEN 
                    DO: /*es un TANQUE*/
                        evento.fasignado = ?.
                        evento.recursos = "".
                        evento.mobs = "".
                        evento.nro_plan = 0.
                    END.
                    ELSE 
                    DO:
                        FOR EACH aviso WHERE aviso.refevento = evento.nro_evento.
                            FOR EACH recurso_agenda WHERE recurso_agenda.nro_evento = aviso.nro_evento:
                                DELETE recurso_agenda. 
                            END.
                            DELETE aviso.
                        END.
                        FOR EACH tarea OF evento: 
                            DELETE tarea. 
                        END.
                        DELETE evento.
                    END.
                END.
            END.
        END.
        FOR EACH evento NO-LOCK BREAK BY Evento.nro_planasignar DESC :
            nplan = evento.nro_plan.
            LEAVE.
        END. 
        bborraultimo:LABEL IN FRAME {&FRAME-NAME}= "Borra Plan " + STRING(nplan).
 
        v-mes:SCREEN-VALUE IN FRAME {&FRAME-NAME} = IF AVAILABLE evento THEN STRING(month(evento.fmin)) ELSE STRING(MONTH(TODAY)).
        v-ano:SCREEN-VALUE IN FRAME {&FRAME-NAME} = IF AVAILABLE evento THEN STRING(YEAR(evento.fmin)) ELSE STRING(YEAR(TODAY)).

        chProgressBar-6:XP_ProgressBar:VALUE = 2. 
    END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME Bcapac
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Bcapac C-Win
ON CHOOSE OF Bcapac IN FRAME DEFAULT-FRAME /* Capacidades */
DO:
        IF NOT valid-handle(h_capac) THEN 
        DO:
            RUN w-capacidad.w  PERSISTENT SET h_capac.
            RUN dispatch IN h_capac ( INPUT 'initialize':U ) .
        END.
        ELSE DYNAMIC-FUNCTION("tope" IN h_capac ). 
    END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME Beventos
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Beventos C-Win
ON CHOOSE OF Beventos IN FRAME DEFAULT-FRAME /* Eventos */
DO:
        ASSIGN v-origen  c_nro_tipo_evento  v-mes  v-ano.
        IF NOT valid-handle(h_eventos) THEN 
        DO:
            RUN w-evento.w PERSISTENT SET h_eventos ( ? , ?,v-origen , c_nro_tipo_evento , v-mes , v-ano ,?,?).
            RUN dispatch IN h_eventos ( INPUT 'initialize':U ) .
        END.
        ELSE DYNAMIC-FUNCTION("tope" IN h_eventos ). 
    END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME brecursos
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL brecursos C-Win
ON CHOOSE OF brecursos IN FRAME DEFAULT-FRAME /* Recursos */
DO:
        IF NOT valid-handle(h_recursos) THEN 
        DO:
            RUN w-recursos.w  PERSISTENT SET h_recursos.
            RUN dispatch IN h_recursos ( INPUT 'initialize':U ) .
        END.
        ELSE DYNAMIC-FUNCTION("tope" IN h_recursos ). 
    END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME BUTTON-10
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL BUTTON-10 C-Win
ON CHOOSE OF BUTTON-10 IN FRAME DEFAULT-FRAME /* Ejecutar */
DO:

        DEFINE VAR i           AS INT   NO-UNDO.
        DEFINE VAR ii          AS INT   NO-UNDO.
        DEFINE VAR jj          AS INT   NO-UNDO.
        DEF    VAR gg          AS INT   NO-UNDO.
        DEFINE VAR v           AS DECIMAL   NO-UNDO.
        DEFINE VAR cc1         AS INT   NO-UNDO.
        DEFINE VAR num-eventos AS INT   NO-UNDO.

        DEF    VAR lista       AS CHAR NO-UNDO.
        DEFINE VAR prioricomb  AS INT   NO-UNDO.
        DEF BUFFER bevento  FOR evento.
        DEF BUFFER baevento FOR evento.
        DEFINE VAR imd       AS LOGICAL   NO-UNDO.
        DEFINE VAR opt       AS LOGICAL   NO-UNDO.
        DEFINE VAR posicind  AS INT   NO-UNDO.
        DEFINE VAR LAST_PLAN AS INT   NO-UNDO.
        DEFINE VAR cerror    AS CHAR NO-UNDO.
        DEFINE VAR seguir    AS LOGICAL   NO-UNDO.

        miraerrores = FALSE.
        corrida = 1.
        posicind = 0.
        imd = SESSION:IMMEDIATE-DISPLAY.
        RUN borra_bar.

        IF v-origen = "COBRANZA" THEN dgeomax = dgeomaxmax. /*arranca sin geocodificacion*/
 
        ctnasig = 0.
        ctasig = 0.
        v-corrida = 0.
        cteventos = 0.
        DISPLAY  v-corrida dgeomax cteventos ctnasig ctasig WITH FRAME {&FRAME-NAME}.
        ASSIGN maxdia v-mes v-ano c_nro_tipo_evento v-origen pridia ultdia
            tturno tcapacidad pbloque ptentativos trdur tlimpia maximo_avisos_dia. 

        IF pridia = ? AND ultdia = ? THEN 
        DO:
            pridia = DATE(v-mes,1,v-ano).
            ultdia = pridia + 32.
            ultdia = DATE(MONTH(ultdia),1,YEAR(ultdia)) - 1.
        END.
      
        IF v-origen = "CONTRATO" THEN 
        DO:
            IF pridia < TODAY + 2 THEN pridia = TODAY .
            dgeomaxmax = 800.
        END.
        IF v-origen = "COBRANZA" THEN 
        DO:
            IF pridia < TODAY THEN pridia = TODAY.
            dgeomaxmax = 99999.
            /*dgeomaxmax = 5000*/.
        END.

        DISPLAY pridia ultdia WITH FRAME {&FRAME-NAME}.

        MESSAGE "Confirma el rango de fechas" SKIP "del " pridia " al " ultdia VIEW-AS ALERT-BOX QUESTION  BUTTONS YES-NO TITLE "Confirme" SET opt. 
        IF NOT opt THEN RETURN NO-APPLY.
        FIND tipo_evento WHERE tipo_evento.nro_tipo_evento = c_nro_tipo_evento NO-LOCK NO-ERROR.
        IF NOT AVAILABLE tipo_evento THEN 
        DO:
            RUN ponmensj.p("OPR0009").
            RETURN NO-APPLY.
        END.

        SESSION:IMMEDIATE-DISPLAY = TRUE.
        IF tlimpia THEN 
        DO:
            FOR EACH evento WHERE evento.anulado :
                FOR EACH recurso_agenda OF evento:
                    DELETE recurso_agenda.
                END.
            END.
            /*FOR EACH evento WHERE evento.fasignado<>? OR evento.frealizado<>?:
                DO i = 1 TO NUM-ENTRIES(evento.recursos):
                              FIND recurso_agenda WHERE recurso_agenda.cdg_recurso = ENTRY(i,evento.recurso) AND
                                   recurso_agenda.nro_evento = evento.nro_evento NO-LOCK NO-ERROR.
                              IF NOT AVAILABLE recurso_agenda THEN DO: 
                                CREATE recurso_agenda.
                                ASSIGN recurso_agenda.cdg_recurso = ENTRY(i,evento.recurso)
                                       recurso_agenda.nro_evento = evento.nro_evento
                                       recurso_agenda.observacion = evento.observacion.
                              END.
                              IF recurso_agenda.fecha = ( IF evento.frealizado = ? THEN evento.fasignado ELSE evento.frealizado ) THEN NEXT.
                              FIND CURRENT recurso_agenda EXCLUSIVE-LOCK.
                              recurso_agenda.fecha = ( IF evento.frealizado = ? THEN evento.fasignado ELSE evento.frealizado ).
                END.
            END.*/
            FOR EACH recurso_agenda: 
                FIND evento OF recurso_agenda NO-LOCK NO-ERROR.
                IF NOT AVAILABLE evento THEN
                    DELETE recurso_agenda.
                ELSE 
                DO:
                    IF evento.fasignado=? AND NOT evento.bloqueado AND evento.frealizado=? THEN
                        DELETE recurso_agenda.
                END.
            END.

            RUN limpia_mobs.
        END.

        num-eventos = 0.
        cnecesarios = 0.
        /*C*/

        FOR EACH evento WHERE 
            evento.origen = v-origen AND
            evento.frealizado = ? AND 
            evento.nro_tipo_evento = tipo_evento.nro_tipo_evento AND
            evento.evaluar = TRUE AND
            NOT evento.anulado AND
            evento.fmax >= pridia AND
            evento.fmin <= ultdia NO-LOCK:
            IF evento.fasignado <> ? THEN NEXT.
            num-eventos = num-eventos + 1.
            i = IF NUM-ENTRIES( evento.recursos ) <> 0 THEN NUM-ENTRIES( evento.recursos ) ELSE 1.
            cnecesarios = cnecesarios + i * evento.duracion.
            cteventos = num-eventos.
            DISPLAY cteventos WITH FRAME {&FRAME-NAME}.         
        END.
 
 
        DISPLAY cteventos WITH FRAME {&FRAME-NAME}.
        chProgressBar-1:XP_ProgressBar:value = 2.     
 
        FOR EACH rvalor : 
            DELETE rvalor. 
        END.
        FOR EACH analizado: 
            DELETE analizado. 
        END.
        FOR EACH balanceo: 
            DELETE balanceo. 
        END. 
        FOR EACH aanalizar: 
            DELETE aanalizar. 
        END.
        EMPTY TEMP-TABLE evearea.

        cdisponibles = 0.
        IF tcapacidad THEN 
        DO:
            FOR EACH recurso_capacidad WHERE recurso_capacidad.fecha >= pridia AND recurso_capacidad.fecha <= ultdia AND
                recurso_capacidad.nro_tipo_evento = c_nro_tipo_evento NO-LOCK:
                FIND recurso OF recurso_capacidad NO-LOCK NO-ERROR.
                IF AVAILABLE recurso THEN 
                DO:
                    FIND feriado WHERE feriado.fecha = recurso_capacidad.fecha NO-LOCK NO-ERROR.
                    IF AVAILABLE feriado THEN NEXT.
                    FIND recurso_horasxdia WHERE recurso_horasxdia.cdg_recurso = recurso_capacidad.cdg_recurso AND
                        recurso_horasxdia.fecha = recurso_capacidad.fecha NO-LOCK NO-ERROR.
                    IF NOT AVAILABLE recurso_horasxdia THEN NEXT.
                    IF recurso_horasxdia.horas > recurso_capacidad.capacidad THEN
                        cdisponibles = cdisponibles +  recurso_horasxdia.horas.
                    ELSE
                        cdisponibles = cdisponibles +  recurso_capacidad.capacidad.
                    FIND balanceo WHERE balanceo.cdg_recurso = recurso_capacidad.cdg_recurso NO-ERROR.
                    IF NOT AVAILABLE balanceo THEN 
                    DO:
                        CREATE balanceo.
                        ASSIGN 
                            balanceo.cdg_recurso = recurso_capacidad.cdg_recurso
                            balanceo.turno       = recurso.turno.
                    END.
                    FIND recurso_habilidad WHERE recurso_habilidad.cdg_recurso = recurso_capacidad.cdg_recurso AND
                        recurso_habilidad.nro_tipo_evento = c_nro_tipo_evento NO-LOCK NO-ERROR.
                    ASSIGN 
                        balanceo.prioridad = IF AVAILABLE recurso_habilidad THEN recurso_habilidad.prioridad ELSE 1.
                    balanceo.disponible = balanceo.disponible + recurso_capacidad.capacidad.
         
                    FOR EACH recurso_agenda WHERE recurso_agenda.cdg_recurso = recurso_capacidad.cdg_recurso AND
                        recurso_agenda.fecha = recurso_capacidad.fecha NO-LOCK:
                        FIND bevento WHERE bevento.nro_evento = recurso_agenda.nro_evento NO-ERROR.
                        IF AVAILABLE bevento THEN 
                        DO:
                            IF bevento.duracion = ? THEN 
                            DO:
                                MESSAGE "Corrija el evento " bevento.nro_evento " mal la duracion" VIEW-AS ALERT-BOX ERROR.
                                RETURN NO-APPLY.
                            END.
                            ASSIGN 
                                balanceo.utilizacion = balanceo.utilizacion + bevento.duracion
                                cdisponibles         = cdisponibles - bevento.duracion.
                        END.
                    END. 
                END.
            END.
        END.
        ELSE 
        DO:
            FOR EACH recurso_horasxdia WHERE recurso_horasxdia.fecha >= pridia AND recurso_horasxdia.fecha <= ultdia NO-LOCK:
                FIND recurso OF recurso_horasxdia NO-LOCK NO-ERROR.
                IF AVAILABLE recurso THEN 
                DO:
                    FIND feriado WHERE feriado.fecha = recurso_horasxdia.fecha NO-LOCK NO-ERROR.
                    IF AVAILABLE feriado THEN NEXT.
                    cdisponibles = cdisponibles +  recurso_horasxdia.horas.
                    FIND balanceo WHERE balanceo.cdg_recurso = recurso_horasxdia.cdg_recurso NO-ERROR.
                    IF NOT AVAILABLE balanceo THEN 
                    DO:
                        CREATE balanceo.
                        ASSIGN 
                            balanceo.cdg_recurso = recurso_horasxdia.cdg_recurso
                            balanceo.turno       = recurso.turno.
                    END.
                    FIND recurso_habilidad WHERE recurso_habilidad.cdg_recurso = recurso_horasxdia.cdg_recurso AND
                        recurso_habilidad.nro_tipo_evento = c_nro_tipo_evento NO-LOCK NO-ERROR.
                    ASSIGN 
                        balanceo.prioridad = IF AVAILABLE recurso_habilidad THEN recurso_habilidad.prioridad ELSE 1.
                    balanceo.disponible = balanceo.disponible + recurso_horasxdia.horas.

                    FOR EACH recurso_agenda WHERE recurso_agenda.cdg_recurso = recurso_horasxdia.cdg_recurso AND
                        recurso_agenda.fecha = recurso_horasxdia.fecha NO-LOCK:
                        FIND bevento WHERE bevento.nro_evento = recurso_agenda.nro_evento NO-ERROR.
                        IF AVAILABLE bevento THEN 
                        DO:
                            IF bevento.duracion = ? THEN 
                            DO:
                                MESSAGE "Corrija el evento " bevento.nro_evento " mal la duracion" VIEW-AS ALERT-BOX ERROR.
                                RETURN NO-APPLY.
        
                            END.
                            ASSIGN 
                                balanceo.utilizacion = balanceo.utilizacion + bevento.duracion
                                cdisponibles         = cdisponibles - bevento.duracion.
                        END.
                    END. 
                END.
            END.
        END.
        DISPLAY cdisponibles cnecesarios WITH FRAME {&FRAME-NAME}.

        RUN carga_eventos_periodo.
        cerror = RETURN-VALUE.
        IF cerror <> "" THEN 
        DO:
            MESSAGE cerror
                VIEW-AS ALERT-BOX INFO BUTTONS OK.
            RETURN NO-APPLY.

        END.

        IF miraerrores THEN 
        DO:
            MESSAGE "Mire el archivo de errores - no puede continuar" VIEW-AS ALERT-BOX ERROR.
            RETURN NO-APPLY.
        END.


        IF cnecesarios > cdisponibles THEN 
        DO:
            MESSAGE "Los recursos disponibles no alcanzan para asignar los eventos" SKIP
                "Suspende la corrida?"
                VIEW-AS ALERT-BOX QUESTION BUTTON YES-NO TITLE "Atencion" UPDATE opt   .
            IF opt THEN RETURN NO-APPLY.
        END.
        /*******************************************************************/
        /*Analisis*/
        /*una vez eveluado un evento , si pertenece a una identificacion que tiene sub-eventos de nivel superior se le suma 1
        al valor obtenido ese dia, mejorando la satisfaccion, ya que se ubicara primero ese evento(o bloque ) y a posterior el evento(bloque) que tenga sub-evento*/
        chProgressBar-2:XP_ProgressBar:MAX = IF num-eventos > 1 THEN num-eventos ELSE 2.
        cc1 = 0.
        num-analizado = 0.
        
        FOR EACH evento WHERE  
            evento.frealizado = ? AND
            evento.nro_tipo_evento = c_nro_tipo_evento AND
            evento.evaluar AND 
            NOT evento.anulado AND
            evento.fmax >= pridia AND
            evento.fmin <= ultdia:
            IF evento.fasignado <> ? AND evento.recursos <> "" THEN NEXT.
            IF cc1 MOD 20 = 0 THEN 
                IF cc1 >=0 THEN chProgressBar-2:XP_ProgressBar:value = cc1.
            cc1 = cc1 + 1.

            IF evento.nro_evento_padre = 0 OR CAN-DO(pbloque,replace(evento.recursos,"#","")) OR evento.nro_evento_padre = evento.nro_evento  THEN
                FIND bevento WHERE ROWID(bevento) = ROWID(evento). /*restrictor de si mismo*/
            ELSE 
            DO:
                FIND bevento WHERE bevento.nro_evento = evento.nro_evento_padre AND
                    bevento.fasignado = ? AND bevento.nro_tipo_evento = evento.nro_tipo_evento AND bevento.evaluar AND NOT bevento.anulado AND bevento.fmax >= pridia AND bevento.fmin <= ultdia NO-LOCK NO-ERROR.
                IF NOT AVAILABLE bevento THEN 
                DO: 
                    evento.nro_evento_padre = evento.nro_evento. /*se corrige el restrictor ya que el evento padre*/
                    FIND bevento WHERE ROWID(bevento) = ROWID(evento).
                END.
            END. /*bevento tiene el restrictor a ser analizado*/

            /*se crea analizado y rvalor */
            FIND analizado WHERE analizado.nro_evento = bevento.nro_evento NO-ERROR.
            IF NOT AVAILABLE analizado THEN 
            DO:
                CREATE analizado. 
                ASSIGN 
                    analizado.nro_evento = bevento.nro_evento
                    analizado.muestras   = 0
                    analizado.sumas      = 0
                    analizado.recursos   = bevento.recursos
                    analizado.evsigue    = bevento.evsigue
                    num-analizado        = num-analizado + 1.
                analizado.TR = tienerestriccion( rowid(bevento)).
                DISPLAY num-analizado WITH FRAME {&FRAME-NAME}.
                 
                FOR EACH baevento NO-LOCK WHERE baevento.origen = bevento.origen AND
                    baevento.fasignado <> ? AND
                    baevento.fmax < bevento.fmin AND
                    baevento.nro_identificacion = bevento.nro_identificacion AND
                    baevento.sub_evento = bevento.sub_evento BY baevento.nro_evento DESC :
                    analizado.antasig = baevento.fasignado.
                    LEAVE.
                END.
      
                ii = IF bevento.fmin <= pridia THEN day(pridia) ELSE day(bevento.fmin). /*todo lo no realizado con anterioridad se intentara ubicar*/
                jj = IF bevento.fmax <= ultdia THEN day( bevento.fmax ) ELSE day(ultdia) .
           
                DO i = ii TO jj: /*creo rvalor con el rango de dias determinado por el padre*/
                    CREATE rvalor.
                    ASSIGN 
                        rvalor.fecha      = DATE(v-mes,i,v-ano)
                        rvalor.nro_evento = bevento.nro_evento.
                END.
            END.
            ASSIGN 
                analizado.duracion  = analizado.duracion + evento.duracion 
                analizado.hduracion = analizado.hduracion + evento.duracion * (IF NUM-ENTRIES(trim(evento.recursos)) > 0 THEN NUM-ENTRIES(trim(evento.recursos)) ELSE 1). 
                analizado.agrupado = IF analizado.agrupado = "" THEN STRING(evento.nro_evento) ELSE analizado.agrupado + "," + STRING(evento.nro_evento).
                IF analizado.duracion > 240 THEN
                    analizado.duracion = 240.
        END.


        DISPLAY num-analizado  WITH FRAME {&FRAME-NAME}.
        chProgressBar-2:XP_ProgressBar:value = chProgressBar-2:XP_ProgressBar:max.   

        /* de los encadenados, al ser encadenado suma  tantos puntos como encadenados tenga lo que le mejora la competencia contra otro mas simple*/
        chProgressBar-2:XP_ProgressBar:MAX = IF num-analizado > 1 THEN num-analizado ELSE 2.
        cc1 = 0.
        FOR EACH analizado USE-INDEX idx2:
            ASSIGN 
                analizado.encadenado = calcula_encadenado ( analizado.agrupado ) 
                /*analizado.sumas = analizado.sumas + analizado.encadenado*/
                cc1                  = cc1 + 1.
            IF cc1 >=0 THEN chProgressBar-2:XP_ProgressBar:value = cc1.

        END.
        chProgressBar-2:XP_ProgressBar:value = chProgressBar-2:XP_ProgressBar:max.

        /*******************************************************************/

        /*segun el origen del tipo de evento se llama a un programa especializado en ese origen
        que llenara la tabla de analizado pasada como parametro 
        Tambien se pasa la tabla rvalor que volvera con los valores de las satisfacciones de ese dia
        */

        chProgressBar-3:XP_ProgressBar:MAX = IF num-analizado > 1 THEN num-analizado ELSE 2.
        /*tabla analizado,tabla rvalor,handle de este procedimiento,pnro_evento*/

        RUN VALUE( v-origen + "-opr2.p" ) ( 
            INPUT-OUTPUT TABLE analizado, 
            INPUT-OUTPUT TABLE rvalor, 
            INPUT THIS-PROCEDURE, 
            ? ,
            INPUT nplan).

        IF ERROR-STATUS:ERROR THEN 
        DO:
            MESSAGE "Se Detiene el proceso por errores"SKIP
                "revise c:\sic-temp\erroresplan" + STRING(nplan) + ".txt" VIEW-AS ALERT-BOX ERROR.
            RETURN NO-APPLY.
        END.
        chProgressBar-3:XP_ProgressBar:value = chProgressBar-3:XP_ProgressBar:max.


        /*******************************************************************/
        /*Ordenamiento y asignacion*/
        cc1 = 0.  
        chProgressBar-4:XP_ProgressBar:MAX = IF num-analizado > 1 THEN num-analizado ELSE 2.
        FOR EACH aanalizar: 
            DELETE aanalizar. 
        END.
        FOR EACH analizado  USE-INDEX idx1 , evento OF analizado WHERE evento.fasignado = ?:
            posicind = posicind + 1.
            CREATE aanalizar.
            ASSIGN   
                aanalizar.ind = posicind.
            IF i  > chProgressBar-4:XP_ProgressBar:MAX THEN chProgressBar-4:XP_ProgressBar:MAX = i.
            IF i >=0 THEN chProgressBar-4:XP_ProgressBar:VALUE = i.
            aanalizar.nro_evento = evento.nro_evento.
            analizado.ind = aanalizar.ind.
        END.
        /*buscar los eventos geocodificando los vecinos mas cercanos, la distancia se va a ir agendando asi
        vamos de los mas cercano a los mas lejano admisible*/
        DO WHILE dgeomax <= dgeomaxmax :
            DISPLAY dgeomax WITH FRAME {&FRAME-NAME}.
            v-corrida = 0.
            seguir = TRUE.
            DO WHILE seguir:
                seguir = FALSE.
                v-corrida = v-corrida + 1.
                DISPLAY dgeomax v-corrida WITH FRAME {&FRAME-NAME}.
                FOR EACH aanalizar WHERE aanalizar.ind <> 0 BY aanalizar.ind:
                    FIND evento WHERE evento.nro_evento = aanalizar.nro_evento.
                    IF evento.fasignado <> ?  THEN NEXT.
                    IF aanalizar.ind >=0 THEN chProgressBar-4:XP_ProgressBar:VALUE = aanalizar.ind.
                    IF asignar_evento(aanalizar.nro_evento, TRUE,aanalizar.ind) THEN
                        seguir = TRUE.
                END.
            END.
            dgeomax = dgeomax + dgeoinc.
        END.

        /*  dgeomax = 10000.                                             */
        /* DISPLAY dgeomax WITH FRAME {&FRAME-NAME}.                     */
        /* for EACH aanalizar WHERE aanalizar.ind <> 0 by aanalizar.ind: */
        /*     chProgressBar-4:XP_ProgressBar:VALUE = aanalizar.ind.        */
        /*     asignar_evento(aanalizar.nro_evento, TRUE,aanalizar.ind). */
        /* END.                                                          */

        chProgressBar-4:XP_ProgressBar:VALUE = chProgressBar-4:XP_ProgressBar:MAX.

        /*******************************************************************/
        /*Asignacion final y resultados*/

        chProgressBar-5:XP_ProgressBar:MAX = IF num-analizado > 1 THEN num-analizado ELSE 2.
        chProgressBar-5:XP_ProgressBar:value = 1.  

        ctnasig = cteventos - ctasig.
        DISPLAY ctnasig ctasig WITH FRAME {&FRAME-NAME}.
        /*asignar avisos*/

        IF VERAVISOS THEN 
        DO:
            RUN genera_avisos.
            RUN asignar_avisos.
        END.

        FOR EACH evento NO-LOCK BREAK BY Evento.nro_planasignar DESC :
            LAST_plan = evento.nro_plan.
            LEAVE.
        END.

        bborraultimo:LABEL = "Borra Plan " +  STRING(LAST_plan).
        SESSION:IMMEDIATE-DISPLAY = imd.
        chProgressBar-5:XP_ProgressBar:value = chProgressBar-5:XP_ProgressBar:max.
        TEMP-TABLE analizado:WRITE-XML("file",                      
            "c:\analizado.xml",YES, 
            ?,                      
            ?,                      
            NO,                     
            NO).                    
        TEMP-TABLE rvalor:WRITE-XML("file",                      
            "c:\rvalor.xml",YES, 
            ?,                      
            ?,                      
            NO,                     
            NO).   
        TEMP-TABLE balanceo:WRITE-XML("file",                      
            "c:\balanceo.xml",YES, 
            ?,                      
            ?,                      
            NO,                     
            NO). 

        MESSAGE "Fin de Ejecucion" VIEW-AS ALERT-BOX INFORMATION.
    END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME BUTTON-11
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL BUTTON-11 C-Win
ON CHOOSE OF BUTTON-11 IN FRAME DEFAULT-FRAME /* Adm */
DO:
        IF NOT valid-handle(h_administraciones) THEN 
        DO:  
            RUN w-administraciones.w  PERSISTENT SET h_administraciones.
            RUN dispatch IN h_administraciones ( INPUT 'initialize':U ) .
        END.
        ELSE DYNAMIC-FUNCTION("tope" IN h_administraciones ). 
    END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME BUTTON-2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL BUTTON-2 C-Win
ON CHOOSE OF BUTTON-2 IN FRAME DEFAULT-FRAME /* Restricciones */
DO:
        IF NOT valid-handle(h_restriccion) THEN 
        DO:
            RUN w-restriccion.w  PERSISTENT SET h_restriccion.
            RUN dispatch IN h_restriccion ( INPUT 'initialize':U ) .
        END.
        ELSE DYNAMIC-FUNCTION("tope" IN h_restriccion ). 
    END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME BUTTON-5
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL BUTTON-5 C-Win
ON CHOOSE OF BUTTON-5 IN FRAME DEFAULT-FRAME /* Analizado */
DO:
        IF NOT valid-handle(h_analizado) THEN 
        DO:
            RUN  w-analizado.w PERSISTENT  SET h_analizado ( INPUT TABLE analizado , INPUT TABLE rvalor ).
            RUN dispatch IN h_analizado ( INPUT 'initialize':U ) .
        END.
        ELSE DYNAMIC-FUNCTION("tope" IN h_analizado ). 
    END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME BUTTON-6
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL BUTTON-6 C-Win
ON CHOOSE OF BUTTON-6 IN FRAME DEFAULT-FRAME /* Rvalor */
DO:
        IF NOT valid-handle(h_rvalor) THEN 
        DO:  
            RUN  w-rvalor.w PERSISTENT  SET h_rvalor ( INPUT TABLE analizado , INPUT TABLE rvalor ).
            RUN dispatch IN h_rvalor ( INPUT 'initialize':U ) .
        END.
        ELSE DYNAMIC-FUNCTION("tope" IN h_rvalor ). 
    END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME BUTTON-7
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL BUTTON-7 C-Win
ON CHOOSE OF BUTTON-7 IN FRAME DEFAULT-FRAME /* Balanceo */
DO:
        IF NOT valid-handle(h_balanceo) THEN 
        DO:  
            RUN w-balanceo.w PERSISTENT SET h_balanceo ( INPUT TABLE balanceo ).
            RUN dispatch IN h_balanceo ( INPUT 'initialize':U ) .
        END.
        ELSE DYNAMIC-FUNCTION("tope" IN h_balanceo ). 
    END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME BUTTON-8
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL BUTTON-8 C-Win
ON CHOOSE OF BUTTON-8 IN FRAME DEFAULT-FRAME /* Cons */
DO:
        IF NOT valid-handle(h_consorcios) THEN 
        DO:  
            RUN w-consorcios.w  PERSISTENT SET h_consorcios.
            RUN dispatch IN h_consorcios ( INPUT 'initialize':U ) .
        END.
        ELSE DYNAMIC-FUNCTION("tope" IN h_consorcios ). 
    END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME c_nro_tipo_evento
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL c_nro_tipo_evento C-Win
ON VALUE-CHANGED OF c_nro_tipo_evento IN FRAME DEFAULT-FRAME /* Tipo */
DO:
        FIND FIRST tipo_evento WHERE tipo_evento.nro_tipo_evento = c_nro_tipo_evento:INPUT-VALUE NO-ERROR.
        IF AVAILABLE tipo_evento THEN 
            dsc_tipo_evento:SCREEN-VALUE IN FRAME {&FRAME-NAME} = tipo_evento.descripcion.
        ELSE
            dsc_tipo_evento:SCREEN-VALUE IN FRAME {&FRAME-NAME}="ERROR".
        CASE v-origen:
            WHEN "CONTRATO" THEN 
                DO:
                    CASE  tipo_evento.cdg_tipo_evento:
                        WHEN "LT" OR 
                        WHEN "RT" THEN 
                            maxdia:SCREEN-VALUE = "1".
                        OTHERWISE 
                        maxdia:SCREEN-VALUE = "3".
                    END.
                END.
        END.
    END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME faddoper
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL faddoper C-Win
ON VALUE-CHANGED OF faddoper IN FRAME DEFAULT-FRAME /* Agrega Recursos */
DO:
        ASSIGN faddoper.
    END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fdesbrec
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fdesbrec C-Win
ON VALUE-CHANGED OF fdesbrec IN FRAME DEFAULT-FRAME /* Cambio Recurso */
DO:
        ASSIGN fdesbrec.
    END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME pridia
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL pridia C-Win
ON MOUSE-MENU-DOWN OF pridia IN FRAME DEFAULT-FRAME /* del */
DO:
        DEFINE VAR fecha_elegida AS DATE NO-UNDO.
        SELF:INPUT-VALUE = DATE(SELF:SCREEN-VALUE IN FRAME {&FRAME-NAME}) NO-ERROR.
        IF SELF:INPUT-VALUE = ? THEN SELF:SCREEN-VALUE = STRING(TODAY).
        RUN d-calendario.w ( INPUT date(SELF:SCREEN-VALUE), OUTPUT fecha_elegida).
        IF fecha_elegida <> ?
            THEN 
        DO:
            SELF:SCREEN-VALUE = STRING(fecha_elegida).
            APPLY "TAB" TO SELF.        
        END.               

    END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME trdur
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL trdur C-Win
ON VALUE-CHANGED OF trdur IN FRAME DEFAULT-FRAME /* Rdur */
DO:
        ASSIGN fdesbrec.
    END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME ultdia
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL ultdia C-Win
ON MOUSE-MENU-DOWN OF ultdia IN FRAME DEFAULT-FRAME /* a */
DO:
        DEFINE VAR fecha_elegida AS DATE NO-UNDO.
        SELF:INPUT-VALUE = DATE(SELF:SCREEN-VALUE IN FRAME {&FRAME-NAME}) NO-ERROR.
        IF SELF:INPUT-VALUE = ? THEN SELF:SCREEN-VALUE = STRING(TODAY).
        RUN d-calendario.w ( INPUT date(SELF:SCREEN-VALUE), OUTPUT fecha_elegida).
        IF fecha_elegida <> ?
            THEN 
        DO:
            SELF:SCREEN-VALUE = STRING(fecha_elegida).
            APPLY "TAB" TO SELF.        
        END.               

    END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME v-mes
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-mes C-Win
ON LEAVE OF v-mes IN FRAME DEFAULT-FRAME /* Periodo */
DO:
        pridia:SCREEN-VALUE = "".
        ultdia:SCREEN-VALUE = "".
    END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME v-origen
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-origen C-Win
ON VALUE-CHANGED OF v-origen IN FRAME DEFAULT-FRAME
DO:
        DEFINE VAR lista AS CHAR NO-UNDO.
        ASSIGN v-origen.
        CASE v-origen:
            /*saque de las opciones RECTUCLM MANUAL AVISO*/
            WHEN "ENVIO" THEN 
                DO:
                    maxdia:SCREEN-VALUE = "20".
                    FIND tipo_evento WHERE tipo_evento.cdg_tipo_evento = "EV" NO-LOCK.
                    c_nro_tipo_evento = tipo_evento.nro_tipo_evento.
                    /*DISPLAY c_nro_tipo_evento WITH FRAME {&FRAME-NAME}.*/
                    button-10:SENSITIVE = TRUE.
                END.
            WHEN "COBRANZA" THEN 
                DO:
                    maxdia:SCREEN-VALUE = "99".
                    tturno = FALSE.
                    button-10:SENSITIVE = TRUE.
                    DISPLAY tturno WITH FRAME {&FRAME-NAME}.
                END.
            WHEN "CONTRATO" THEN 
                DO:
                    tturno = FALSE.
                    DISPLAY tturno WITH FRAME {&FRAME-NAME}.
                    FIND FIRST tipo_evento WHERE tipo_evento.nro_tipo_evento = c_nro_tipo_evento:INPUT-VALUE NO-ERROR.
                    IF AVAILABLE tipo_evento THEN 
                        dsc_tipo_evento:SCREEN-VALUE IN FRAME {&FRAME-NAME} = tipo_evento.descripcion.
                    ELSE
                        dsc_tipo_evento:SCREEN-VALUE IN FRAME {&FRAME-NAME}="ERROR".
                    CASE  tipo_evento.cdg_tipo_evento:
                        WHEN "LT" OR 
                        WHEN "RT" THEN 
                            maxdia:SCREEN-VALUE = "1".
                        OTHERWISE 
                        maxdia:SCREEN-VALUE = "3".
                    END.
                    button-10:SENSITIVE = TRUE.
                END.
            OTHERWISE 
            DO: 
                maxdia:SCREEN-VALUE = "0".
                button-10:SENSITIVE = FALSE.
            END.
        END.
  
        DO WITH FRAME {&FRAME-NAME}:
            c_nro_tipo_evento= 0.
    &SCOPED-DEFINE CONDICION tipo_evento.origen= v-origen:INPUT-VALUE
            {levantacombo.i &TABLA=Tipo_evento &NOMBRE=cdg_tipo_evento &CODIGO=nro_tipo_evento &OBJETO=c_nro_tipo_evento}
    
            IF NUM-ENTRIES(c_nro_tipo_evento:LIST-ITEM-PAIRS,"|") > 2 THEN 
            DO:
                c_nro_tipo_evento:HIDDEN = FALSE.
                c_nro_tipo_evento:SENSITIVE = TRUE.
            END.
            ELSE 
                c_nro_tipo_evento:HIDDEN = TRUE. 
        END. 
    END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&UNDEFINE SELF-NAME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _MAIN-BLOCK C-Win 


/* ***************************  Main Block  *************************** */

/* Set CURRENT-WINDOW: this will parent dialog-boxes and frames.        */
ASSIGN CURRENT-WINDOW                = {&WINDOW-NAME} 
       THIS-PROCEDURE:CURRENT-WINDOW = {&WINDOW-NAME}.

/* The CLOSE event can be used from inside or outside the procedure to  */
/* terminate it.                                                        */
ON CLOSE OF THIS-PROCEDURE 
    RUN disable_UI.

/* Best default for GUI applications is...                              */
PAUSE 0 BEFORE-HIDE.

/* Now enable the interface and wait for the exit condition.            */
/* (NOTE: handle ERROR and END-KEY so cleanup code will always fire.    */
  
DEF VAR lista AS CHAR NO-UNDO.
DO WITH FRAME {&FRAME-NAME}:
      &Scoped-define CONDICION tipo_evento.nro_tipo_evento > 0
    {levantacombo.i &TABLA=Tipo_evento &NOMBRE=cdg_tipo_evento &CODIGO=nro_tipo_evento &OBJETO=c_nro_tipo_evento}
END. 

/* Code placed here will execute AFTER standard behavior.    */

FOR EACH evento NO-LOCK BREAK BY Evento.nro_planasignar DESC :
    nplan = evento.nro_plan + 1.
    LEAVE.
END.
bborraultimo:LABEL IN FRAME {&FRAME-NAME}= "Borra Plan " + STRING(nplan - 1).
/*leer los ultimos xml guardados*/
IF SEARCH("c:\analizado.xml") <>? THEN 
DO:
    TEMP-TABLE analizado:READ-XML("file",                      
        "c:\analizado.xml",
        "empty", 
        ?,?,?,?).
END.
IF SEARCH("c:\rvalor.xml") <>? THEN 
DO:
    TEMP-TABLE rvalor:READ-XML("file",                      
        "c:\rvalor.xml",
        "empty", 
        ?,?,?,?).
END.
IF SEARCH("c:\balanceo.xml") <>? THEN 
DO:
    TEMP-TABLE balanceo:READ-XML("file",                      
        "c:\balanceo.xml",
        "empty", 
        ?,?,?,?).
END.

MAIN-BLOCK:
DO ON ERROR   UNDO MAIN-BLOCK, LEAVE MAIN-BLOCK
    ON END-KEY UNDO MAIN-BLOCK, LEAVE MAIN-BLOCK:
    RUN enable_UI.

    v-mes:SCREEN-VALUE IN FRAME {&FRAME-NAME} = IF AVAILABLE evento THEN STRING(month(evento.fmin)) ELSE STRING(MONTH(TODAY)).
    v-ano:SCREEN-VALUE IN FRAME {&FRAME-NAME} = IF AVAILABLE evento THEN STRING(YEAR(evento.fmin)) ELSE STRING(YEAR(TODAY)).
    IF NOT THIS-PROCEDURE:PERSISTENT THEN
        WAIT-FOR CLOSE OF THIS-PROCEDURE.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


/* **********************  Internal Procedures  *********************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE apareo_ENVIO C-Win 
PROCEDURE apareo_ENVIO :
/*------------------------------------------------------------------------------
      Purpose:     
      Parameters:  <none>
      Notes:       
    ------------------------------------------------------------------------------*/
    DEFINE VAR pperiodo AS INT NO-UNDO.
    DEFINE BUFFER coevento FOR evento.

    FIND tipo_evento WHERE tipo_evento.cdg_tipo_evento = "CO".
    pperiodo = v-ano:INPUT-VALUE IN FRAME {&FRAME-NAME} * 100 + v-mes:INPUT-VALUE.
    FOR EACH evento WHERE evento.origen = "ENVIO" AND evento.periodo = pperiodo:
        FIND FIRST coevento WHERE evento.nro_cliente = coevento.nro_cliente AND
            coevento.nro_tipo_evento = tipo_evento.nro_tipo_evento AND
            coevento.fasignado <= evento.fmax AND coevento.fasignado >= evento.fmin AND
            coevento.frealizado <> ? AND NOT coevento.anulado AND
            coevento.periodo = evento.periodo NO-LOCK NO-ERROR.
        IF AVAILABLE coevento THEN 
        DO:
            evento.evsigue = coevento.nro_evento.
            evento.fasignado = coevento.fasignado.
            evento.recurso = coevento.recurso.
            evento.durac = 1.
            FIND recurso_agenda OF evento NO-ERROR.
            IF NOT AVAILABLE recurso_agenda THEN 
            DO:
                CREATE recurso_agenda.
                ASSIGN 
                    recurso_agenda.nro_evento = evento.nro_evento.
            END.
            recurso_agenda.cdg_recurso = entry(1,evento.recurso).
            recurso_agenda.fecha = evento.fasignado.
        END.
    END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE asigna-inmediato C-Win 
PROCEDURE asigna-inmediato :
/*------------------------------------------------------------------------------
      Purpose:     
      Parameters:  <none>
      Notes:       
    ------------------------------------------------------------------------------*/
    DEFINE INPUT PARAM nnro AS ROWID NO-UNDO.
    DEFINE VAR temprdur AS INT   NO-UNDO.
    DEFINE VAR uno      AS LOGICAL   NO-UNDO.
    DEFINE VAR vv       AS INT   NO-UNDO.
    DEFINE VAR cc       AS CHAR NO-UNDO.
    DEFINE VAR vd       AS DATE      NO-UNDO.
    DEFINE VAR ii       AS INT   NO-UNDO.
  
    FIND evento WHERE ROWID(evento) = nnro.
    /*rango*/
    /*dfijo*/
    FIND restriccion WHERE restriccion.evaluar AND 
        Restriccion.nro_tipo_evento = evento.nro_tipo_evento AND
        Restriccion.cdg_restriccion BEGINS "RANGO" NO-LOCK NO-ERROR.
    IF AVAILABLE restriccion THEN 
    DO:
        FIND cliente_restriccion WHERE cliente_restriccion.nro_cliente = evento.nro_cliente AND
            cliente_restriccion.nro_restriccion = restriccion.nro_restriccion NO-LOCK NO-ERROR.
        IF  AVAILABLE cliente_restriccion THEN 
        DO:
            IF int( entry(1,cliente_restriccion.valor, "|" )) > DAY(ultdia) THEN RETURN.
            IF NOT es_habil(date( v-mes , int( entry(1,cliente_restriccion.valor,"|") ) , v-ano ),"23456") THEN RETURN.
            evento.fasignado = date( v-mes , int( entry(1,cliente_restriccion.valor,"|" )) , v-ano ) NO-ERROR.
            IF ERROR-STATUS:ERROR THEN 
            DO:
                MESSAGE "El cliente " cliente.cdg_cliente " tiene restriccion dfijo incorrecta" VIEW-AS ALERT-BOX INFORMATION.
                UNDO,RETURN.
            END.
            FIND restriccion WHERE restriccion.cdg_restriccion = "HORAC".
            FIND cliente_restriccion OF restriccion WHERE cliente_restriccion.nro_cliente = evento.nro_cliente NO-LOCK NO-ERROR.
            IF AVAILABLE cliente_restriccion THEN 
            DO:
                evento.hora_desde = SUBSTRING(cliente_restriccion.valor,1,4).
                evento.hora_hasta = SUBSTRING(cliente_restriccion.valor,LENGTH(cliente_restriccion.valor) - 3,4).
            END.
            ELSE 
            DO:
                evento.hora_desde = "0900".
                evento.hora_hasta = "1230".
            END.
            ctasig = ctasig + 1.
            DISPLAY ctasig WITH FRAME {&FRAME-NAME}.
            evento.nro_plan = nplan.
            IF evento.fasignado <> ? AND evento.recurso <> "" THEN 
            DO:
                FIND recurso_agenda WHERE recurso_agenda.nro_evento = evento.nro_evento NO-ERROR.
                IF NOT AVAILABLE recurso_agenda THEN
                    CREATE recurso_agenda.
                ASSIGN 
                    recurso_agenda.nro_evento  = evento.nro_evento
                    recurso_agenda.fecha       = evento.fasignado
                    recurso_agenda.cdg_recurso = evento.recurso.
                RETURN.
            END.
        END.
    END.

    /*dfijo*/
    FIND restriccion WHERE restriccion.evaluar AND 
        Restriccion.nro_tipo_evento = evento.nro_tipo_evento AND
        Restriccion.cdg_restriccion BEGINS "DFIJO" NO-LOCK NO-ERROR.
    IF AVAILABLE restriccion THEN 
    DO:
        FIND cliente_restriccion WHERE cliente_restriccion.nro_cliente = evento.nro_cliente AND
            cliente_restriccion.nro_restriccion = restriccion.nro_restriccion NO-LOCK NO-ERROR.
        IF  AVAILABLE cliente_restriccion THEN 
        DO:
            IF int( cliente_restriccion.valor ) > DAY(ultdia) THEN RETURN.
            IF NOT es_habil(date( v-mes , int( cliente_restriccion.valor ) , v-ano ),"23456") THEN RETURN.
            evento.fasignado = date( v-mes , int( cliente_restriccion.valor ) , v-ano ) NO-ERROR.
            IF ERROR-STATUS:ERROR THEN 
            DO:
                MESSAGE "El cliente " cliente.cdg_cliente " tiene restriccion dfijo incorrecta" VIEW-AS ALERT-BOX INFORMATION.
                UNDO,RETURN.
            END.
            FIND restriccion WHERE restriccion.cdg_restriccion = "HORAC".
            FIND cliente_restriccion OF restriccion WHERE cliente_restriccion.nro_cliente = evento.nro_cliente NO-LOCK NO-ERROR.
            IF AVAILABLE cliente_restriccion THEN 
            DO:
                evento.hora_desde = SUBSTRING(cliente_restriccion.valor,1,4).
                evento.hora_hasta = SUBSTRING(cliente_restriccion.valor,LENGTH(cliente_restriccion.valor) - 3,4).
            END.
            ELSE 
            DO:
                evento.hora_desde = "0900".
                evento.hora_hasta = "1230".
            END.
            ctasig = ctasig + 1.
            DISPLAY ctasig WITH FRAME {&FRAME-NAME}.
            evento.nro_plan = nplan.
            IF evento.fasignado <> ? AND evento.recurso <> "" THEN 
            DO:
                FIND recurso_agenda WHERE recurso_agenda.nro_evento = evento.nro_evento NO-ERROR.
                IF NOT AVAILABLE recurso_agenda THEN
                    CREATE recurso_agenda.
                ASSIGN 
                    recurso_agenda.nro_evento  = evento.nro_evento
                    recurso_agenda.fecha       = evento.fasignado
                    recurso_agenda.cdg_recurso = evento.recurso.
                RETURN.
            END.
        END.
    END.

    /*cronos*/
    FIND restriccion WHERE restriccion.evaluar AND 
        Restriccion.nro_tipo_evento = evento.nro_tipo_evento AND
        Restriccion.cdg_restriccion BEGINS "CRONO" NO-LOCK NO-ERROR.
    IF AVAILABLE restriccion THEN 
    DO:
        FIND cliente_restriccion WHERE cliente_restriccion.nro_cliente = evento.nro_cliente AND
            cliente_restriccion.nro_restriccion = restriccion.nro_restriccion NO-LOCK NO-ERROR.
        IF  AVAILABLE cliente_restriccion THEN 
        DO:
            IF ENTRY( v-mes , cliente_restriccion.valor , "|" )  <> ""  THEN 
            DO:
                cc = ENTRY( v-mes , cliente_restriccion.valor , "|" ). 
                DO ii = 1 TO  NUM-ENTRIES(cc):
                    IF int( entry(ii, cc )) > DAY(ultdia) THEN NEXT .
                    IF NOT es_habil(date( v-mes , int( entry(ii, cc )) , v-ano ),"23456") THEN NEXT .
                    evento.fasignado = date( v-mes , int( entry(ii, cc )) , v-ano ) NO-ERROR.
                    IF ERROR-STATUS:ERROR THEN 
                    DO:
                        MESSAGE "El cliente " cliente.cdg_cliente " tiene restriccion dfijo incorrecta" VIEW-AS ALERT-BOX INFORMATION.
                        UNDO,RETURN.
                    END.
                    FIND restriccion WHERE restriccion.cdg_restriccion = "HORAC".
                    FIND cliente_restriccion OF restriccion WHERE cliente_restriccion.nro_cliente = evento.nro_cliente NO-LOCK NO-ERROR.
                    IF AVAILABLE cliente_restriccion THEN 
                    DO:
                        evento.hora_desde = SUBSTRING(cliente_restriccion.valor,1,4).
                        evento.hora_hasta = SUBSTRING(cliente_restriccion.valor,LENGTH(cliente_restriccion.valor) - 3,4).
                    END.
                    ELSE 
                    DO:
                        evento.hora_desde = "0900".
                        evento.hora_hasta = "1230".
                    END.
                    ctasig = ctasig + 1.
                    DISPLAY ctasig WITH FRAME {&FRAME-NAME}.
                    evento.nro_plan = nplan.
                    IF evento.fasignado <> ? AND evento.recurso <> "" THEN 
                    DO:
                        FIND recurso_agenda WHERE recurso_agenda.nro_evento = evento.nro_evento NO-ERROR.
                        IF NOT AVAILABLE recurso_agenda THEN
                            CREATE recurso_agenda.
                        ASSIGN 
                            recurso_agenda.nro_evento  = evento.nro_evento
                            recurso_agenda.fecha       = evento.fasignado
                            recurso_agenda.cdg_recurso = evento.recurso.
                        RETURN.
                    END.
                END.
                IF evento.fasignado <> ?  THEN RETURN.
            
            END.
        END.
    END.
    /*fechai*/
    FIND restriccion WHERE restriccion.evaluar AND 
        Restriccion.nro_tipo_evento = evento.nro_tipo_evento AND
        Restriccion.cdg_restriccion BEGINS "FECHAI" NO-LOCK NO-ERROR.
    IF AVAILABLE restriccion THEN 
    DO:
        FOR EACH cliente_restriccion OF restriccion WHERE date(cliente_restriccion.valor) < TODAY :
            DELETE cliente_restriccion.
        END.
        FIND cliente_restriccion WHERE cliente_restriccion.nro_cliente = evento.nro_cliente AND
            cliente_restriccion.nro_restriccion = restriccion.nro_restriccion NO-LOCK NO-ERROR.
        IF  AVAILABLE cliente_restriccion THEN 
        DO:
            vd = DATE(cliente_restriccion.valor) NO-ERROR.
            IF ERROR-STATUS:ERROR THEN 
            DO:
                MESSAGE "El cliente " cliente.cdg_cliente " tiene restriccion dfijo incorrecta" VIEW-AS ALERT-BOX INFORMATION.
                UNDO,RETURN.
            END.
            IF vd > ultdia THEN RETURN.
            IF NOT es_habil(vd ,"23456") THEN RETURN.
            evento.fasignado = vd NO-ERROR.
            FIND restriccion WHERE restriccion.cdg_restriccion = "HORAC".
            FIND cliente_restriccion OF restriccion WHERE cliente_restriccion.nro_cliente = evento.nro_cliente NO-LOCK NO-ERROR.
            IF AVAILABLE cliente_restriccion THEN 
            DO:
                evento.hora_desde = SUBSTRING(cliente_restriccion.valor,1,4).
                evento.hora_hasta = SUBSTRING(cliente_restriccion.valor,LENGTH(cliente_restriccion.valor) - 3,4).
            END.
            ELSE 
            DO:
                evento.hora_desde = "0900".
                evento.hora_hasta = "1230".
            END.
            ctasig = ctasig + 1.
            DISPLAY ctasig WITH FRAME {&FRAME-NAME}.
            evento.nro_plan = nplan.
            IF evento.fasignado <> ? AND evento.recurso <> "" THEN 
            DO:
                FIND recurso_agenda WHERE recurso_agenda.nro_evento = evento.nro_evento NO-ERROR.
                IF NOT AVAILABLE recurso_agenda THEN
                    CREATE recurso_agenda.
                ASSIGN 
                    recurso_agenda.nro_evento  = evento.nro_evento
                    recurso_agenda.fecha       = evento.fasignado
                    recurso_agenda.cdg_recurso = evento.recurso.
                RETURN.
            END.
        END.
    END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE asignar_avisos C-Win 
PROCEDURE asignar_avisos :
/*------------------------------------------------------------------------------
  Purpose: asigna los avisos de los eventos asignados   
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/*no se usa mas los avisos van por unidad si tiene tiempo asignado el operario 
se fuerzan hasta 3avisos independiente de la duracion de los mismos solo si tiene*/

/*evento realizado en el rango de fechas, distancia a cada uno de ellos */
/*el overflow se maneja por un balanceo especiales segun la tabla recurso_habilidad 
y las capacidades de cada uno de los elegidos*/

DEFINE BUFFER bevento  FOR evento.
DEFINE BUFFER cevento  FOR evento.
DEFINE BUFFER bcliente FOR cliente.
    DEFINE VAR vgeoX       AS DECIMAL NO-UNDO.
    DEFINE VAR vgeoY       AS DECIMAL NO-UNDO.
    DEFINE VAR i           AS INT NO-UNDO.
    DEFINE VAR fdisponible AS LOGICAL NO-UNDO.
    DEFINE VAR maxdist     AS INTEGER INITIAL 500 NO-UNDO. /*distancia maxima en metros*/


    DEFINE VAR almenos     AS LOGICAL NO-UNDO.
    DEFINE VAR sinasig     AS INT NO-UNDO.
    DEFINE VAR dummydist   AS DECIMAL NO-UNDO.
    DEFINE VAR ii          AS INT NO-UNDO.
    DEFINE VAR k           AS DATE    NO-UNDO.
    DEFINE BUFFER bant FOR evento.

    DEFINE VAR aviso_nro_tipo_evento LIKE tipo_evento.nro_tipo_evento NO-UNDO.
    FIND tipo_evento WHERE tipo_evento.cdg_tipo = "AV" NO-LOCK.
    aviso_nro_tipo_evento = tipo_evento.nro_tipo_evento.
    sinasig = 0.
    FOR EACH evento NO-LOCK WHERE NOT evento.anulado AND evento.frealizado = ? AND
        evento.fasignado = ? AND evento.origen = tipo_evento.origen AND evento.nro_tipo_evento = aviso_nro_tipo_evento:
        sinasig = sinasig + 1.
        v-sinasig:SCREEN-VALUE IN FRAME {&FRAME-NAME}=STRING(sinasig).
    END.

    chProgressBar-5:XP_ProgressBar:MAX = IF sinasig < 1 THEN 2 ELSE sinasig.
    sinasig = 0.

    /*asignar los avisos lleva que no requieren ningun misterio*/
    FOR EACH evento NO-LOCK WHERE evento.frealizado = ? AND evento.fasignado = ? AND NOT evento.anulado AND
        evento.sub_evento = 1 AND
        evento.nro_tipo_evento = aviso_nro_tipo_evento, 
        FIRST bevento NO-LOCK WHERE bevento.nro_evento = evento.refevento 
        AND NOT bevento.anulado:

        IF bevento.origen <> "CONTRATO" THEN NEXT.
        FIND restriccion NO-LOCK WHERE restriccion.cdg_restriccion BEGINS "AVISO" AND restriccion.nro_tipo_evento = bevento.nro_tipo_evento NO-ERROR.
        IF NOT AVAILABLE restriccion THEN NEXT.
        FIND contrato_restriccion NO-LOCK WHERE contrato_restriccion.nro_contrato = bevento.nro_identificacion AND contrato_restriccion.nro_restriccion = restriccion.nro_restriccion AND contrato_restriccion.sub_evento = bevento.sub_evento NO-ERROR.
        IF NOT AVAILABLE contrato_restriccion THEN NEXT.
        IF ENTRY( 1 , contrato_restriccion.valor , "|" ) = "0" THEN NEXT.
        IF ENTRY( 3 , contrato_restriccion.valor , "|" ) <> "L" THEN NEXT.
        RELEASE bant.
        FOR EACH bant NO-LOCK WHERE bant.nro_cliente = bevento.nro_cliente AND NOT bant.anulado AND
            bant.nro_identificacion = bevento.nro_identificacion AND 
            bant.nro_tipo_evento = bevento.nro_tipo_evento AND
            bant.sub_evento = bevento.sub_evento AND bant.fasignado < bevento.fasignado 
            AND rowid(bevento) <> rowid(bant) BY bant.fasignado DESC :
            LEAVE.
        END.
        IF AVAILABLE bant THEN 
        DO:
            IF bant.fasignado <= TODAY + 1 THEN NEXT.
            FIND cevento WHERE rowid(cevento) = rowid(evento) EXCLUSIVE-LOCK.
            cevento.fasignado = bant.fasignado.
            cevento.recursos = ENTRY(1,bant.recursos).
            cevento.durac = 1.
            cevento.nro_plan = nplan.
            cevento.evsigue = bant.nro_evento.
            cevento.mobs = wmobs(evento.mobs ,"Lleva operario:" + STRING(bant.nro_evento)).
            CREATE recurso_agenda.
            ASSIGN 
                recurso_agenda.cdg_recurso = ENTRY(1,cevento.recursos)
                recurso_agenda.fecha       = cevento.fasignado
                recurso_agenda.nro_evento  = cevento.nro_evento
                recurso_agenda.observacion = "".
            sinasig = sinasig + 1.
            IF sinasig > 0 THEN chProgressBar-5:XP_ProgressBar:VALUE = sinasig.
            v-sinasig:SCREEN-VALUE = STRING(sinasig).
        END.
    END.

    /*creando un balance a los elegidos*/
    EMPTY TEMP-TABLE balaviso.

    FOR EACH recurso_capacidad WHERE recurso_capacidad.nro_tipo_evento = aviso_nro_tipo_evento AND
        recurso_capacidad.fecha > TODAY + 1 NO-LOCK:
        IF recurso_capacidad.capacidad > 0 THEN 
        DO:
            CREATE balaviso.
            ASSIGN 
                balaviso.cdg_recurso = recurso_capacidad.cdg_recurso
                balaviso.cantidad    = 0
                balaviso.fecha       = recurso_capacidad.fecha.
        END.
    END.

    /*cuento avisos asignados*/
    FOR EACH balaviso:
        FOR EACH recurso_agenda WHERE recurso_agenda.cdg_recurso = balaviso.cdg_recurso AND
            recurso_agenda.fecha = balaviso.fecha AND recurso_agenda.fecha > TODAY + 1 NO-LOCK:
            FIND bevento OF recurso_agenda NO-LOCK NO-ERROR.
            IF NOT AVAILABLE bevento THEN 
            DO:
                MESSAGE "Error interno la agenda debe sincronizarse" VIEW-AS ALERT-BOX ERROR.
                RETURN ERROR.
            END.
            IF bevento.nro_tipo_evento = aviso_nro_tipo_evento THEN
                balaviso.cantidad = balaviso.cantidad + 1.
        END.
    END.

    chProgressBar-5:XP_ProgressBar:value = 0.

    /*cantidad de avisos sinasignar*/
    FOR EACH evento WHERE NOT evento.anulado AND evento.frealizado = ? AND
        evento.fasignado = ? AND evento.origen = tipo_evento.origen AND evento.nro_tipo_evento = aviso_nro_tipo_evento:
        sinasig = sinasig + 1.
        v-sinasig:SCREEN-VALUE IN FRAME {&FRAME-NAME}=STRING(sinasig).
    END.

    chProgressBar-5:XP_ProgressBar:MAX = IF sinasig < 1 THEN 2 ELSE sinasig.
    sinasig = 0.
    /*mientras que asigne algo sigue*/
    v-corrida = 0.

    REPEAT:
        v-corrida = v-corrida + 1.
        DISPLAY v-corrida WITH FRAME {&FRAME-NAME}.
        almenos = FALSE.
        FOR EACH evento WHERE evento.frealizado = ? AND NOT evento.anulado AND
            evento.fasignado = ? AND evento.nro_tipo_evento = aviso_nro_tipo_evento AND
            evento.fmax >= TODAY + 1 :
            /*si es un aviso de un contrato y es lleva no hago nada*/
            FIND bevento WHERE bevento.nro_evento = evento.refevento NO-LOCK NO-ERROR.
            IF NOT AVAILABLE bevento THEN NEXT.
            IF bevento.origen = "CONTRATO" THEN 
            DO:
                IF bevento.nro_tipo_evento = 1 THEN 
                DO:
                    IF bevento.sub_evento <> 1 THEN NEXT.
                    FIND restriccion WHERE restriccion.cdg_restriccion BEGINS "AVISO" AND restriccion.nro_tipo_evento = c_nro_tipo_evento NO-LOCK NO-ERROR.
                    IF NOT AVAILABLE restriccion THEN NEXT.
                    FIND contrato_restriccion NO-LOCK WHERE contrato_restriccion.nro_restriccion = restriccion.nro_restriccion AND contrato_restriccion.nro_contrato = bevento.nro_identificacion AND bevento.sub_evento = bevento.sub_evento NO-ERROR.
                    IF AVAILABLE contrato_restriccion THEN
                        IF ENTRY(3,contrato_restriccion.valor,"|") = "L" THEN NEXT.
                END.
            END.
            FIND cliente OF evento NO-LOCK NO-ERROR.
            IF NOT AVAILABLE cliente THEN 
            DO:
                MESSAGE "Error interno  no existe el cliente para evento:" evento.nro_evento VIEW-AS ALERT-BOX.
                NEXT.
            END.
            vgeoX = cliente.geoX.
            vgeoY = cliente.geoY.
            EMPTY TEMP-TABLE evearea.
            FOR EACH bevento WHERE bevento.fasignado <> ? AND 
                bevento.frealizado = ? AND 
                NOT bevento.anulado AND
                bevento.fasignado >= evento.fmin AND
                bevento.fasignado <= evento.fmax AND 
                ROWID(bevento) <> ROWID(evento):
                FIND cliente OF bevento NO-LOCK NO-ERROR.
                IF NOT AVAILABLE cliente THEN 
                DO:
                    MESSAGE "Error interno  no existe el cliente para evento:" bevento.nro_evento VIEW-AS ALERT-BOX.
                    NEXT.
                END.
                fdisponible = FALSE.
                DO i = 1 TO NUM-ENTRIES(bevento.recursos):
                    FIND balaviso WHERE balaviso.cdg_recurso = ENTRY(i,bevento.recursos) AND
                        balaviso.fecha = bevento.fasignado NO-ERROR.
                    IF AVAILABLE balaviso THEN
                        fdisponible = balaviso.cantidad < maximo_avisos_dia. 
                    IF fdisponible THEN LEAVE.
                END.
                IF NOT fdisponible THEN NEXT.
                /* calculando el distancias y preasignando a uno de los recursos disponibles*/
                dummydist = distGeodesicaUTM(cliente.geoX , cliente.geoY ,
                    vgeoX,vgeoY).
                IF dummydist > maxdist THEN NEXT.
                CREATE evearea.
                FIND bcliente OF bevento NO-LOCK.
                evearea.direccion = bcliente.direccion.
                evearea.nro_evento = bevento.nro_evento.
                evearea.recursos = ENTRY(i,bevento.recursos).
                evearea.distancia = dummydist.
            END.
            /*asignando el mejor de los posibles*/
            FOR EACH evearea BY evearea.distancia:
                FIND bevento WHERE bevento.nro_evento = evearea.nro_evento.
                evento.recursos = evearea.recursos.
                evento.fasignado = bevento.fasignado.
                evento.nro_plan = nplan.
                evento.mobs = wmobs(evento.mobs ,"Cercano EV:" + STRING(evearea.nro_evento) + "[" + STRING(evearea.distancia) + "] " + evearea.direccion).
                almenos = TRUE.
                /*crea agenda de recurso*/
                CREATE recurso_agenda.
                ASSIGN 
                    recurso_agenda.cdg_recurso = evento.recursos
                    recurso_agenda.fecha       = evento.fasignado
                    recurso_agenda.nro_evento  = evento.nro_evento
                    sinasig                    = sinasig + 1.
                IF sinasig > 0 THEN chProgressBar-5:XP_ProgressBar:VALUE = sinasig.
                v-sinasig:SCREEN-VALUE = STRING(sinasig).
                recurso_agenda.observacion = IF recurso_agenda.observacion <> "" THEN recurso_agenda.observacion + " " + evento.mobs ELSE evento.mobs.
                FIND balaviso WHERE balaviso.cdg_recurso = recurso_agenda.cdg_recurso AND
                    balaviso.fecha = recurso_agenda.fecha NO-ERROR.
                IF AVAILABLE balaviso THEN 
                DO:
                    ASSIGN 
                        balaviso.cantidad = balaviso.cantidad + 1.
                    LEAVE.
                END.
            END.
        /*no anduvo con ningun recurso geocodificado vamos a los candidatos*/
        /*
                    IF evento.fasignado = ? AND FALSE THEN DO:
                              /*buscamos el recurso y dia que menos tiene que hacer en el rango admisible de analisis del evento*/
                              FOR EACH balaviso WHERE balaviso.fecha >= evento.fmin AND 
                                                       balaviso.fecha <= evento.fmax BY balaviso.cantidad:
                                   fdisponible = balaviso.cantidad < maximo_avisos_dia. 
                                   IF NOT fdisponible THEN NEXT.
                                   ASSIGN evento.fasignado = balaviso.fecha
                                          evento.nro_plan = nplan
                                          evento.recurso = balaviso.cdg_recurso
                                          evento.mobs = ( IF evento.mobs <> "" THEN evento.mobs + " " ELSE "" ) + "Sin cercania"
                                          almenos = TRUE
                                          balaviso.cantidad = balaviso.cantidad + 1.
                                   CREATE recurso_agenda.
                                   ASSIGN recurso_agenda.cdg_recurso = evento.recursos
                                          recurso_agenda.fecha = evento.fasignado
                                          recurso_agenda.nro_evento = evento.nro_evento
                                          sinasig = sinasig + 1
                                          v-sinasig:SCREEN-VALUE=STRING(sinasig)
                                          chProgressBar-5:XP_ProgressBar:VALUE = sinasig
                                          recurso_agenda.observacion = IF recurso_agenda.observacion <> "" THEN recurso_agenda.observacion + " " + evento.mobs ELSE evento.mobs.
                                   LEAVE.
                              END.
                    END.
                    /*IF evento.fasignado <> ? THEN LEAVE. /*se asigno un evento nuevo es un candidato para acoplarle otro evento*/*/
        */
        END.
        IF almenos = FALSE THEN LEAVE.
    END.
    chProgressBar-5:XP_ProgressBar:VALUE = chProgressBar-5:XP_ProgressBar:MAX.
    TEMP-TABLE balaviso:WRITE-XML("file",                      
        "c:\balaviso.xml",YES, 
        ?,                      
        ?,                      
        NO,                     
        NO).   

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE asignar_avisos_tiempo C-Win 
PROCEDURE asignar_avisos_tiempo :
/*------------------------------------------------------------------------------
  Purpose: asigna los avisos de los eventos asignados   
  Parameters:  <none>
  Notes:  NO SE USA MAS VER asignar_avisos    
------------------------------------------------------------------------------*/
/*no se usa mas los avisos van por unidad si tiene tiempo asignado el operario 
se fuerzan hasta 3 avisos*/
/*evento realizado en el rango de fechas, distancia a cada uno de ellos */
/*el overflow se maneja por un balanceo especiales segun la tabla recurso_habilidad 
y las capacidades de cada uno de los elegidos*/
DEFINE BUFFER bevento  FOR evento.
DEFINE BUFFER bcliente FOR cliente.
    DEFINE VAR vgeoX       AS DECIMAL NO-UNDO.
    DEFINE VAR vgeoY       AS DECIMAL NO-UNDO.
    DEFINE VAR i           AS INT NO-UNDO.
    DEFINE VAR fdisponible AS LOGICAL NO-UNDO.
    DEFINE VAR maxdist     AS INTEGER INITIAL 500 NO-UNDO. /*distancia maxima en metros*/

    DEFINE VAR almenos     AS LOGICAL NO-UNDO.
    DEFINE VAR sinasig     AS INT NO-UNDO.
    DEFINE VAR dummydist   AS DECIMAL NO-UNDO.
    DEFINE VAR ii          AS INT NO-UNDO.
    DEFINE VAR k           AS DATE    NO-UNDO.

    FIND tipo_evento WHERE tipo_evento.cdg_tipo = "AV" NO-LOCK.

    /*creando un balance a los elegidos*/
    EMPTY TEMP-TABLE balaviso.

    FOR EACH recurso_habilidad WHERE recurso_habilidad.nro_tipo_evento = tipo_evento.nro_tipo_evento NO-LOCK:
        k = TODAY + 1.
        DO WHILE k <= ultdia:
            CREATE balaviso.
            ASSIGN 
                balaviso.cdg_recurso = recurso_habilidad.cdg_recurso
                balaviso.cantidad    = 0
                balaviso.fecha       = k
                k                    = k + 1.
        END.
    END.
    FOR EACH balaviso:
        FOR EACH recurso_agenda WHERE recurso_agenda.cdg_recurso = balaviso.cdg_recurso AND
            recurso_agenda.fecha = balaviso.fecha:
            FIND bevento OF recurso_agenda NO-LOCK.
            balaviso.cantidad = balaviso.cantidad + bevento.duracion.
        END.
    END.

    chProgressBar-5:XP_ProgressBar:value = 0.

    FOR EACH evento WHERE NOT evento.anulado AND evento.frealizado = ? AND
        evento.fasignado = ? AND evento.origen = tipo_evento.origen:
        sinasig = sinasig + 1.
    END.

    chProgressBar-5:XP_ProgressBar:MAX = IF sinasig < 1 THEN 2 ELSE sinasig.
    sinasig = 0.
    /*mientras que asigne algo sigue*/
    v-corrida = 0.
    REPEAT:
        v-corrida = v-corrida + 1.
        DISPLAY v-corrida WITH FRAME {&FRAME-NAME}.
        almenos = FALSE.
        FOR EACH evento WHERE evento.frealizado = ? AND NOT evento.anulado AND
            evento.fasignado = ? AND evento.origen = tipo_evento.origen AND
            evento.fmax >= TODAY:
            FIND cliente OF evento NO-LOCK NO-ERROR.
            IF NOT AVAILABLE cliente THEN 
            DO:
                MESSAGE "Error interno  no existe el cliente para evento:" evento.nro_evento VIEW-AS ALERT-BOX.
                NEXT.
            END.
            vgeoX = cliente.geoX.
            vgeoY = cliente.geoY.
            EMPTY TEMP-TABLE evearea.
            FOR EACH bevento WHERE bevento.fasignado <> ? AND 
                bevento.frealizado = ? AND 
                NOT bevento.anulado AND
                bevento.fasignado >= evento.fmin AND
                bevento.fasignado <= evento.fmax AND 
                ROWID(bevento) <> ROWID(evento):
                FIND cliente OF bevento NO-LOCK NO-ERROR.
                IF NOT AVAILABLE cliente THEN 
                DO:
                    MESSAGE "Error interno  no existe el cliente para evento:" bevento.nro_evento VIEW-AS ALERT-BOX.
                    NEXT.
                END.
                fdisponible = FALSE.
                DO i = 1 TO NUM-ENTRIES(bevento.recursos):
                    fdisponible = disponible(tipo_evento.nro_tipo_evento , bevento.recursos , bevento.fasignado , evento.duracion ,evento.turno ).
                    IF fdisponible THEN LEAVE.
                END.
                IF fdisponible THEN 
                DO:
                    /* calculando el distancias */
                    dummydist = distGeodesicaUTM(cliente.geoX , cliente.geoY ,
                        vgeoX,vgeoY).
                    IF dummydist > maxdist THEN NEXT.
                    CREATE evearea.
                    FIND bcliente OF bevento NO-LOCK.
                    evearea.direccion = bcliente.direccion.
                    evearea.nro_evento = bevento.nro_evento.
                    evearea.recursos = ENTRY(i,bevento.recursos).
                    evearea.distancia = dummydist.
                END.
            END.
            FOR EACH evearea BY evearea.distancia:
                FIND bevento WHERE bevento.nro_evento = evearea.nro_evento.
                evento.recursos = evearea.recursos.
                evento.fasignado = bevento.fasignado.
                evento.nro_plan = nplan.
                evento.mobs = wmobs(evento.mobs,"Cercano EV:" + STRING(evearea.nro_evento) + "[" + STRING(evearea.distancia) + "] " + evearea.direccion).
                almenos = TRUE.
                /*crea agenda de recurso*/
                CREATE recurso_agenda.
                ASSIGN 
                    recurso_agenda.cdg_recurso = evento.recursos
                    recurso_agenda.fecha       = evento.fasignado
                    recurso_agenda.nro_evento  = evento.nro_evento
                    sinasig                    = sinasig + 1.
                IF sinasig > 0 THEN chProgressBar-5:XP_ProgressBar:VALUE = sinasig.
                recurso_agenda.observacion = IF recurso_agenda.observacion <> "" THEN recurso_agenda.observacion + " " + evento.mobs ELSE evento.mobs.
                FIND balaviso WHERE balaviso.cdg_recurso = recurso_agenda.cdg_recurso AND
                    balaviso.fecha = evento.fasignado NO-ERROR.
                IF AVAILABLE balaviso THEN
                    ASSIGN balaviso.cantidad = balaviso.cantidad + evento.duracion.
                LEAVE.
            END.
            /*no anduvo con ningun recurso geocodificado vamos a los candidatos*/
            IF evento.fasignado = ? AND FALSE THEN 
            DO:
                /*buscamos el recurso y dia que menos tiene que hacer en el rango admisible de analisis del evento*/
                FOR EACH balaviso WHERE balaviso.fecha >= evento.fmin AND 
                    balaviso.fecha <= evento.fmax BY balaviso.cantidad:
                    fdisponible = disponible(tipo_evento.nro_tipo_evento , balaviso.cdg_recurso , balaviso.fecha , evento.duracion ,evento.turno). 
                    IF NOT fdisponible THEN NEXT.
                            
                    ASSIGN 
                        evento.fasignado  = balaviso.fecha
                        evento.nro_plan   = nplan
                        evento.recurso    = balaviso.cdg_recurso
                        almenos           = TRUE
                        balaviso.cantidad = balaviso.cantidad + evento.duracion.
                    evento.mobs = wmobs(evento.mobs,"Sin cercania").
                    CREATE recurso_agenda.
                    ASSIGN 
                        recurso_agenda.cdg_recurso = evento.recursos
                        recurso_agenda.fecha       = evento.fasignado
                        recurso_agenda.nro_evento  = evento.nro_evento
                        sinasig                    = sinasig + 1.
                    IF sinasig > 0 THEN chProgressBar-5:XP_ProgressBar:VALUE = sinasig.
                    recurso_agenda.observacion = IF recurso_agenda.observacion <> "" THEN recurso_agenda.observacion + " " + evento.mobs ELSE evento.mobs.
                    LEAVE.
                END.
            END.
        /*IF evento.fasignado <> ? THEN LEAVE. /*se asigno un evento nuevo es un candidato para acoplarle otro evento*/*/
        END.
        IF almenos = FALSE THEN LEAVE.
    END.
    chProgressBar-5:XP_ProgressBar:VALUE = chProgressBar-5:XP_ProgressBar:MAX.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE borra_bar C-Win 
PROCEDURE borra_bar :
/*------------------------------------------------------------------------------
      Purpose:     
      Parameters:  <none>
      Notes:       
    ------------------------------------------------------------------------------*/
    chProgressBar-1:XP_ProgressBar:MIN = 0.    
    chProgressBar-2:XP_ProgressBar:MIN = 0.
    chProgressBar-3:XP_ProgressBar:MIN = 0.
    chProgressBar-4:XP_ProgressBar:MIN = 0.
    chProgressBar-5:XP_ProgressBar:MIN = 0.
    chProgressBar-1:XP_ProgressBar:max = 2.    
    chProgressBar-2:XP_ProgressBar:max = 2.
    chProgressBar-3:XP_ProgressBar:max = 2.
    chProgressBar-4:XP_ProgressBar:max = 2.
    chProgressBar-5:XP_ProgressBar:max = 2.
    chProgressBar-1:XP_ProgressBar:value = 0.    
    chProgressBar-2:XP_ProgressBar:value = 0.
    chProgressBar-3:XP_ProgressBar:value = 0.
    chProgressBar-4:XP_ProgressBar:value = 0.
    chProgressBar-5:XP_ProgressBar:VALUE = 0.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE calcula_vecinos C-Win 
PROCEDURE calcula_vecinos :
/*------------------------------------------------------------------------------
      Purpose:     
      Parameters:  <none>
      Notes:       
    ------------------------------------------------------------------------------*/
    DEFINE INPUT PARAMETER pnro_evento LIKE evento.nro_evento.
    DEFINE INPUT PARAMETER precursos AS CHAR.
    DEFINE OUTPUT PARAMETER TABLE FOR vecinos.
    DEFINE BUFFER vecevento  FOR evento.
    DEFINE BUFFER bvecevento FOR evento.
    DEFINE VAR pgeoX    AS DECIMAL   NO-UNDO.
    DEFINE VAR pgeoY    AS DECIMAL   NO-UNDO.
    DEFINE VAR ddist    AS DECIMAL   NO-UNDO.
    DEFINE VAR kk       AS INT   NO-UNDO.
    DEFINE VAR listarec AS CHAR.
    FIND vecevento WHERE vecevento.nro_evento = pnro_evento NO-LOCK.

    FIND cliente OF vecevento NO-LOCK.
    pgeoX = cliente.geoX.
    pgeoY = cliente.geoY.
    
    FOR EACH recurso WHERE CAN-DO( precursos , recurso.cdg_recurso ):
        listarec = listarec + "," + recurso.cdg_recurso .
    END.
    listarec = SUBSTRING(listarec,2).

    EMPTY TEMP-TABLE vecinos.
    /*calcular a distancia solo grabando los que sean menos a dgeomax*/
    /*Los eventos vecinos tienen que estar asignados no realizados ni anulados*/
    /*los vecinos estan agendados y se buscaran entre las agendas de los cando(precursos) y
    dentro del rango de analisis del evento buscado*/
    
    DO kk = 1 TO NUM-ENTRIES(listarec):
        FOR EACH recurso_agenda WHERE entry(kk,listarec) = recurso_agenda.cdg_recurso AND
            recurso_agenda.fecha >= vecevento.fmin AND recurso_agenda.fecha <= vecevento.fmax: 
            FIND bvecevento OF recurso_agenda NO-ERROR.
            IF NOT AVAILABLE bvecevento THEN 
            DO:
                MESSAGE "Error interno active Limpia Agenda" VIEW-AS ALERT-BOX ERROR.
                RETURN ERROR.
            END.
            IF bvecevento.fasignado = ? OR bvecevento.anulado OR bvecevento.frealizado <> ? THEN NEXT.
            FIND cliente OF bvecevento NO-LOCK.
            ddist = distGeodesicaUTM(cliente.geoX , cliente.geoY ,
                pgeoX,pgeoY).
            IF ddist > dgeomax THEN NEXT.
            CREATE vecinos.
            ASSIGN 
                vecinos.nro_evento = bvecevento.nro_evento
                vecinos.distancia  = ddist.
        END.
    END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE carga2 C-Win 
PROCEDURE carga2 :
/*------------------------------------------------------------------------------
      Purpose:     
      Parameters:  <none>
      Notes:       
    ------------------------------------------------------------------------------*/
    DEFINE INPUT PARAMETER ddd AS DATE NO-UNDO.
    DEFINE INPUT PARAMETER hhh AS DATE NO-UNDO.
    DEFINE INPUT PARAMETER pperiodo AS INT NO-UNDO.
    DEFINE VAR v-ciclo_facturacion AS INT NO-UNDO.
    DEFINE VAR OPRDDTA             AS INT NO-UNDO.
    DEFINE VAR v-transcurridos     AS INT NO-UNDO.
    DEFINE VAR ii                  AS INT.
    DEFINE VAR j                   AS DATE.
    DEFINE VAR uno                 AS LOGICAL NO-UNDO.
    RUN getparametro_n.p ( "OPRDDTA" , OUTPUT OPRDDTA ).
    j  = DATE(v-mes,1,v-ano).
    FOR EACH contrato_hd WHERE contrato_hd.estado = "A" AND contrato_hd.rige_hasta >= ddd AND
        contrato_hd.rige_desde <= hhh AND
        ( contrato_hd.cant_periodos = 0 )
        AND year(contrato_hd.rige_desde) * 100 + month(contrato_hd.rige_desde)  <= pperiodo AND 
        NOT Contrato_hd.anulado AND  ( contrato_hd.fecha_baja = ? OR year(contrato_hd.fecha_baja) * 100 + MONTH(contrato_hd.fecha_baja) > pperiodo ) AND
        contrato_hd.nro_tipo_evento = c_nro_tipo_evento
        ,FIRST cliente OF contrato_hd :
      
        ii = ii + 1.
        RUN checkeaerrores( ROWID(contrato_hd) ).
    END.

    chProgressBar-6:XP_ProgressBar:max = IF ii > 1 THEN ii ELSE 2. 
    ii = 0.
    FOR EACH contrato_hd WHERE contrato_hd.estado = "A" AND contrato_hd.rige_hasta >= ddd AND
        contrato_hd.rige_desde <= hhh AND NOT contrato_hd.suspendido AND
        ( contrato_hd.cant_periodos = 0 )
        AND year(contrato_hd.rige_desde) * 100 + month(contrato_hd.rige_desde)  <= pperiodo AND 
        NOT Contrato_hd.anulado AND  ( contrato_hd.fecha_baja = ? OR year(contrato_hd.fecha_baja) * 100 + MONTH(contrato_hd.fecha_baja) > pperiodo )
        AND contrato_hd.nro_tipo_evento = c_nro_tipo_evento
        ,FIRST cliente OF contrato_hd :
        ii = ii + 1.
        IF ii > 0 THEN chProgressBar-6:XP_ProgressBar:VALUE = ii. 
        v-ciclo_facturacion = INTEGER(Contrato_hd.modo_facturacion).

        IF contrato_hd.primer_mes = 0 THEN
            v-transcurridos = (year(j) - year(Contrato_hd.rige_desde )) * 12 + 
                month(j) - month(Contrato_hd.rige_hasta ).
        ELSE
            v-transcurridos = (year(j) - Contrato_hd.primer_ano) * 12 + 
                month(j) - contrato_hd.primer_mes.

        IF v-transcurridos MOD v-ciclo_facturacion <> 0 THEN NEXT.
        uno = FALSE.
        FOR EACH contrato_dt OF contrato_hd :
            FIND articulo OF contrato_dt NO-ERROR.
            IF NOT AVAILABLE articulo THEN NEXT.
            uno = uno OR articulo.nro_tipo_evento = c_nro_tipo_evento.
        END.
        IF NOT uno THEN NEXT.
        /*carga eventos*/
        DO ii = 1 TO contrato_hd.numero_eventos:
            FIND FIRST contrato_restriccion WHERE contrato_restriccion.nro_contrato = contrato_hd.nro_contrato AND contrato_restriccion.sub_evento = ii AND contrato_restriccion.nro_restriccion = 16 NO-LOCK NO-ERROR. 
            FIND FIRST evento WHERE
                evento.nro_tipo_evento = tipo_evento.nro_tipo_evento AND
                evento.nro_identificacion = contrato_hd.nro_contrato AND
                evento.sub_evento = ii AND
                NOT evento.anulado AND
                /*NOT evento.frealizado<>? AND*/
                evento.periodo = pperiodo NO-LOCK NO-ERROR.
            IF AVAILABLE evento THEN NEXT.
            CREATE evento.
            Evento.nro_planasignar = nplan.
            evento.nro_cliente = contrato_hd.nro_cliente.
            ASSIGN
                evento.reminder           = contrato_hd.reminder
                evento.dreminder          = contrato_hd.dreminder
                evento.origen             = "CONTRATO"
                Evento.Duracion           = IF AVAILABLE contrato_restriccion THEN int(contrato_restriccion.valor) ELSE OPRDDTA
                Evento.FAsignado          = ?
                Evento.FCreado            = TODAY
                evento.fmin               = ddd
                evento.fmax               = hhh
                Evento.nro_evento         = NEXT-VALUE(proximo_evento)
                Evento.nro_evento_padre   = 0
                Evento.nro_identificacion = contrato_hd.nro_contrato
                Evento.nro_tipo_evento    = c_nro_tipo_evento 
                Evento.Recursos           = ""
                evento.sub_evento         = ii
                evento.evaluar            = TRUE
                evento.periodo            = pperiodo
                evento.leyenda            = ""
                evento.reminder           = contrato_hd.reminder
                Evento.dreminder          = contrato_hd.dreminder.
            IF trdur THEN 
            DO:
                /*                   FIND cliente_otros_datos WHERE cliente_otros_datos.nro_cliente = evento.nro_cliente NO-LOCK NO-ERROR. */
                /*                   IF AVAILABLE  cliente_otros_datos THEN temprdur = cliente_otros_datos.unidades * 1 + 20.              */
                /*                   ELSE temprdur = rdur(Evento.nro_evento).                                                                */
                IF rdur(Evento.nro_evento) <> ? THEN
                    evento.duracion = rdur(Evento.nro_evento).
            END.
        END.
    END.
    chProgressBar-6:XP_ProgressBar:VALUE = chProgressBar-6:XP_ProgressBar:MAX.
    ii = 0.
    FOR EACH evento WHERE evento.fasignado = ? AND 
        NOT evento.bloqueado AND NOT evento.anulado AND
        evento.frealizado = ? AND
        evento.origen = v-origen AND
        Evento.nro_tipo_evento = c_nro_tipo_evento AND
        evento.fmin >= ddd AND
        evento.fmax <= hhh:
        ASSIGN 
            ii                     = ii + 1
            /* evento.fmin = ddd 
             evento.fmax = hhh */
            evento.periodo         = pperiodo
            Evento.nro_planasignar = nplan.
    END.
    IF ii = 0 THEN 
    DO:
        RETURN "No hay eventos creados".
    END.
    chProgressBar-6:XP_ProgressBar:VALUE=0.

    chProgressBar-6:XP_ProgressBar:max = ii. 
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE carga_eventos_periodo C-Win 
PROCEDURE carga_eventos_periodo :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/*este proceso crea en funcion a los contratos a ser evaluados resuelve los bloques 
y la signacion forzada de recursos por restriccion*/
DEFINE BUFFER extevento FOR evento.
DEFINE BUFFER bevento   FOR evento.
    DEF    VAR      i                   AS INT NO-UNDO.
    DEF    VAR      ddd                 AS DATE    NO-UNDO.
    DEF    VAR      hhh                 AS DATE    NO-UNDO.
    DEF    VAR      j                   AS DATE    NO-UNDO.
    DEFINE VAR      pridia              AS DATE    NO-UNDO.
    DEFINE VAR      ultdia              AS DATE    NO-UNDO.

  
    DEFINE VARIABLE v-transcurridos     AS INTEGER NO-UNDO.
    DEFINE VARIABLE v-ciclo_facturacion AS INTEGER NO-UNDO.
    DEFINE VAR      nplan               AS INTEGER NO-UNDO.
    DEFINE VAR      pperiodo            AS INTEGER NO-UNDO.
    DEFINE VAR      ii                  AS INT NO-UNDO.
    chProgressBar-6:XP_ProgressBar:MIN = 0. 
    chProgressBar-6:XP_ProgressBar:max = 2. 
    chProgressBar-6:XP_ProgressBar:VALUE = 0. 
    ASSIGN FRAME {&FRAME-NAME} v-mes v-ano c_nro_tipo_evento  .

    ASSIGN v-mes v-ano c_nro_tipo_evento v-origen.
    pperiodo = v-ano * 100 + v-mes.
    pridia = DATE(v-mes,1,v-ano).
    ultdia = pridia + 32.
    ultdia = DATE(MONTH(ultdia),1,YEAR(ultdia)) - 1.


    FIND tipo_evento WHERE tipo_evento.nro_tipo_evento = c_nro_tipo_evento:INPUT-VALUE NO-ERROR.
    IF NOT AVAILABLE tipo_evento THEN 
    DO:
        RETURN "Debe elegir el tipo de evento a analizar".
    END.

    j  = DATE(v-mes,1,v-ano).
    ddd = DATE(v-mes,1,v-ano).
    hhh = DATE( MONTH(ddd + 32 ), 1 , YEAR( ddd + 32 ) ) - 1 .
    FOR EACH evento NO-LOCK BREAK BY Evento.nro_planasignar DESC :
        nplan = evento.nro_plan.
        LEAVE.
    END.
    bborraultimo:LABEL IN FRAME {&FRAME-NAME}= "Borra Plan " + STRING(nplan).

    nplan = nplan + 1.

    
    RUN carga2(INPUT ddd , INPUT hhh , INPUT pperiodo).
    . /*precarga*/
  
    /*generamos los bloques de eventos y la asignacion de recursos forzados por restricciones, turnos etc */
    ii = 0.
    forza:
    FOR EACH evento WHERE 
        evento.origen = v-origen AND
        evento.fasignado = ? AND 
        evento.nro_tipo_evento = tipo_evento.nro_tipo_evento AND
        evento.evaluar = TRUE AND
        NOT evento.anulado AND 
        evento.fmin >= ddd AND
        evento.fmax <= hhh:
        ii = ii + 1.
        IF ii >=0 THEN chProgressBar-6:XP_ProgressBar:VALUE = ii.
        FIND cliente OF evento NO-LOCK.
        /*BLOQUE*/
        FIND restriccion WHERE restriccion.evaluar AND
            Restriccion.nro_tipo_evento = evento.nro_tipo_evento AND
            CAN-DO("BLOQ*",Restriccion.cdg_restriccion) NO-LOCK NO-ERROR.
        IF AVAILABLE restriccion THEN 
        DO:
            FIND contrato_restriccion WHERE 
                contrato_restriccion.nro_contrato = evento.nro_identificacion AND
                contrato_restriccion.sub_evento = evento.sub_evento AND
                contrato_restriccion.nro_restriccion = restriccion.nro_restriccion NO-LOCK NO-ERROR. 
            IF AVAILABLE contrato_restriccion THEN 
            DO:
                FIND bevento WHERE bevento.origen = evento.origen AND
                    bevento.nro_identificacion = int(entry(1,contrato_restriccion.valor, "|")) AND
                    bevento.sub_evento = int(entry(2,contrato_restriccion.valor, "|")) AND
                    bevento.fasignado = ? AND 
                    bevento.nro_tipo_evento = evento.nro_tipo_evento AND
                    bevento.evaluar = TRUE AND 
                    NOT bevento.anulado AND
                    bevento.periodo = pperiodo
                    NO-ERROR.
                IF AVAILABLE bevento THEN 
                DO:
                    evento.nro_evento_padre = bevento.nro_evento.
                END.
            END.
        END.
        IF evento.origen = "CONTRATO" THEN 
        DO:
            FIND restriccion WHERE restriccion.evaluar AND 
                Restriccion.nro_tipo_evento = evento.nro_tipo_evento 
                AND Restriccion.cdg_restriccion BEGINS "TURNO" NO-LOCK NO-ERROR .
            IF AVAILABLE restriccion  THEN 
            DO:
                FIND contrato_restriccion WHERE contrato_restriccion.nro_contrato = evento.nro_identificacion AND
                    contrato_restriccion.sub_evento = evento.sub_evento AND contrato_restriccion.nro_restriccion = restriccion.nro_restriccion NO-LOCK NO-ERROR.
                IF AVAILABLE contrato_restriccion THEN 
                DO:
                    evento.turno = ( IF entry(1,contrato_restriccion.valor,"|") = "" THEN "M" ELSE entry(1,contrato_restriccion.valor,"|")) + entry(2,contrato_restriccion.valor,"|").
                END.
                ELSE evento.turno = "M*".
            END.
            ELSE evento.turno = "M*".
    
            /*bloques virtuales*/
            FIND restriccion WHERE restriccion.evaluar AND 
                Restriccion.nro_tipo_evento = evento.nro_tipo_evento AND 
                Restriccion.cdg_restriccion BEGINS "dfEV" NO-LOCK NO-ERROR.
            IF AVAILABLE restriccion THEN 
            DO:
                FIND contrato_restriccion WHERE contrato_restriccion.nro_contrato = evento.nro_identificacion AND
                    contrato_restriccion.sub_evento = evento.sub_evento AND contrato_restriccion.nro_restriccion = restriccion.nro_restriccion NO-LOCK NO-ERROR.
                IF AVAILABLE contrato_restriccion THEN 
                DO:
                    FIND bevento WHERE bevento.nro_identificacion = int(ENTRY( 1 , contrato_restriccion.valor , "|" )) AND
                        bevento.sub_evento = int(ENTRY( 2 ,contrato_restriccion.valor,"|")) AND
                        bevento.fmin = evento.fmin AND
                        bevento.fmax = evento.fmax NO-LOCK NO-ERROR.
                    IF AVAILABLE bevento THEN
                        evento.evsigue = bevento.nro_evento.
                    ELSE 
                        evento.evsigue = 0.
                END.
            END.
    
            /*RECURSOS FORZADOS*/
            FIND restriccion WHERE restriccion.evaluar AND 
                Restriccion.nro_tipo_evento = evento.nro_tipo_evento AND
                Restriccion.cdg_restriccion BEGINS "OPERF" NO-LOCK NO-ERROR.
            IF AVAILABLE restriccion THEN 
            DO:
                FIND contrato_restriccion WHERE contrato_restriccion.nro_contrato = evento.nro_identificacion AND
                    contrato_restriccion.sub_evento = evento.sub_evento AND 
                    contrato_restriccion.nro_restriccion = restriccion.nro_restriccion NO-LOCK NO-ERROR.
                IF AVAILABLE contrato_restriccion THEN 
                DO:
                    /*MESSAGE "OPER" evento.nro_evento VIEW-AS ALERT-BOX INFORMATION.*/
                    evento.recursos = IF evento.recursos = "" THEN  "#" + contrato_restriccion.valor ELSE evento.recursos.
                END.
            END.
    
            FIND restriccion WHERE restriccion.evaluar AND 
                Restriccion.nro_tipo_evento = evento.nro_tipo_evento AND
                Restriccion.cdg_restriccion BEGINS "OPERN" NO-LOCK NO-ERROR.
            IF AVAILABLE restriccion THEN 
            DO:
                FIND contrato_restriccion WHERE contrato_restriccion.nro_contrato = evento.nro_identificacion AND
                    contrato_restriccion.sub_evento = evento.sub_evento AND 
                    contrato_restriccion.nro_restriccion = restriccion.nro_restriccion NO-LOCK NO-ERROR.
                IF AVAILABLE contrato_restriccion THEN 
                DO:
                    evento.recursos = IF evento.recursos = "" THEN  contrato_restriccion.valor ELSE evento.recursos.
                END.
            END.
        END.
        IF evento.origen = "COBRANZA" THEN 
        DO:
            FIND restriccion WHERE restriccion.evaluar AND 
                Restriccion.nro_tipo_evento = evento.nro_tipo_evento AND
                Restriccion.cdg_restriccion BEGINS "OPERF" NO-LOCK NO-ERROR.
            IF AVAILABLE restriccion THEN 
            DO:
                FIND cliente_restriccion WHERE cliente_restriccion.nro_cliente = evento.nro_cliente AND
                    cliente_restriccion.nro_restriccion = restriccion.nro_restriccion NO-LOCK NO-ERROR.
                IF  AVAILABLE cliente_restriccion THEN evento.recurso = cliente_restriccion.valor.
            END.
            /*sino mantendo el cobrador de la cobranza anterior*/
            IF evento.recurso = "" THEN 
            DO:
                FOR EACH bevento WHERE bevento.origen = evento.origen AND
                    bevento.nro_cliente = evento.nro_cliente AND
                    bevento.frealizado <> ? AND
                    bevento.nro_tipo_evento = evento.nro_tipo_evento AND
                    NOT bevento.anulado BY bevento.frealizado DESC:
                    evento.recurso = entry(1,bevento.recurso).
                    LEAVE.
                END.
            END.
            IF evento.recurso = "" THEN NEXT forza.
            RUN asigna-inmediato ( ROWID(evento) ).
        END.
    END.

    /*de los eventos cargados del periodo hay algunos asignados sin operario en ese caso se intentaran asignar y sino se desasignan*/
    FOR EACH evento WHERE evento.frealizado = ? AND
        NOT evento.anulado AND
        evento.fasignado <> ? AND
        evento.recursos = "" AND
        evento.nro_tipo_evento = c_nro_tipo_evento:
        IF NOT asignar_dia(evento.nro_evento,evento.fasignado) THEN 
        DO: 
            evento.fasignado = ?.
            evento.nro_plan = 0.
        END.
    END.

    bborraultimo:LABEL = "Borra Plan " +  STRING(nplan).
    chProgressBar-6:XP_ProgressBar:VALUE = chProgressBar-6:XP_ProgressBar:max.

    FOR EACH evento WHERE evento.nro_tipo_evento = 13 AND evento.fasignado <> ?
        AND evento.recurso = "" AND NOT evento.anulado AND evento.frealizado = ? :
        DISPLAY evento.nro_evento evento.fasignado.
    END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE checkeaerrores C-Win 
PROCEDURE checkeaerrores :
/*------------------------------------------------------------------------------
      Purpose:   den contrato vigente  
      Parameters:  <none>
      Notes:       
    ------------------------------------------------------------------------------*/
    DEFINE INPUT PARAMETER rcontrato AS ROWID.
    DEFINE BUFFER bcontrato_hd          FOR contrato_hd.
    DEFINE BUFFER bcontrato_restriccion FOR contrato_restriccion.
    FIND contrato_hd WHERE ROWID(contrato_hd) = rcontrato NO-LOCK.
    FIND restriccion WHERE restriccion.evaluar AND
        Restriccion.nro_tipo_evento = evento.nro_tipo_evento AND
        CAN-DO("BLOQ*",Restriccion.cdg_restriccion) NO-LOCK NO-ERROR.

    IF AVAILABLE restriccion THEN 
    DO:
        FOR EACH contrato_restriccion WHERE 
            contrato_restriccion.nro_contrato = contrato_hd.nro_contrato AND
            contrato_restriccion.nro_restriccion = restriccion.nro_restriccion NO-LOCK: 
            FIND bcontrato_hd WHERE  bcontrato_hd.nro_contrato = INT( entry( 1 , contrato_restriccion.valor , "|" ) )
                AND bcontrato_hd.numero_eventos >= int( entry( 2 , contrato_restriccion.valor , "|" ) ) NO-LOCK NO-ERROR.
            IF NOT AVAILABLE bcontrato_hd THEN 
            DO:
                OUTPUT TO value("c:\sic-temp\erroresplan" + STRING(nplan) + ".txt" ) APPEND.
                PUT UNFORMATTED "BLOQUE PARA " contrato_restriccion.nro_contrato "|" contrato_restriccion.sub_evento " No existe Padre " ENTRY( 1, contrato_restriccion.valor,"|") "|" ENTRY( 2, contrato_restriccion.valor,"|") SKIP.
                OUTPUT CLOSE.
                miraerrores = TRUE.
            END.
            ELSE 
            DO:
                /*que el padre exista y este activo*/
                IF NOT (bcontrato_hd.estado = "A" AND bcontrato_hd.fecha_baja = ?  AND bcontrato_hd.rige_hasta > TODAY AND
                    ( bcontrato_hd.cant_periodos  = bcontrato_hd.resto_periodos OR
                    bcontrato_hd.resto_periodos > 0 )) THEN 
                DO:
                    OUTPUT TO value("c:\sic-temp\erroresplan" + STRING(nplan) + ".txt" ) APPEND.
                    PUT UNFORMATTED "BLOQUE PARA " contrato_restriccion.nro_contrato "|" contrato_restriccion.sub_evento " No existe Padre " ENTRY( 1, contrato_restriccion.valor,"|") "|" ENTRY( 2, contrato_restriccion.valor,"|") SKIP.
                    OUTPUT CLOSE.
                END.
                /*que el padre no sea hijo en otro bloque*/
                /*el padre no puede tener ninguna restristrccion de bloque*/
                FIND FIRST bcontrato_restriccion WHERE 
                    bcontrato_restriccion.nro_contrato = bcontrato_hd.nro_contrato AND
                    bcontrato_restriccion.nro_restriccion = restriccion.nro_restriccion  NO-LOCK NO-ERROR.
                IF AVAILABLE bcontrato_restriccion THEN 
                DO: 
                    miraerrores = TRUE.
                    OUTPUT TO value("c:\sic-temp\erroresplan" + STRING(nplan) + ".txt" ) APPEND.
                    PUT UNFORMATTED "BLOQUE PARA " contrato_restriccion.nro_contrato "|" contrato_restriccion.sub_evento " Tiene como Padre " ENTRY( 1, contrato_restriccion.valor,"|") "|" ENTRY( 2, contrato_restriccion.valor,"|") " que es hijo en " ENTRY( 1, bcontrato_restriccion.valor,"|") "|" ENTRY( 2, bcontrato_restriccion.valor,"|") SKIP.
                    OUTPUT CLOSE.
                END.
            END.
        END.
    END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE control_load C-Win  _CONTROL-LOAD
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

OCXFile = SEARCH( "plan2.wrx":U ).
IF OCXFile = ? THEN
  OCXFile = SEARCH(SUBSTRING(THIS-PROCEDURE:FILE-NAME, 1,
                     R-INDEX(THIS-PROCEDURE:FILE-NAME, ".":U), "CHARACTER":U) + "wrx":U).

IF OCXFile <> ? THEN
DO:
  ASSIGN
    chProgressBar-1 = ProgressBar-1:COM-HANDLE
    UIB_S = chProgressBar-1:LoadControls( OCXFile, "ProgressBar-1":U)
    ProgressBar-1:NAME = "ProgressBar-1":U
    chProgressBar-2 = ProgressBar-2:COM-HANDLE
    UIB_S = chProgressBar-2:LoadControls( OCXFile, "ProgressBar-2":U)
    ProgressBar-2:NAME = "ProgressBar-2":U
    chProgressBar-3 = ProgressBar-3:COM-HANDLE
    UIB_S = chProgressBar-3:LoadControls( OCXFile, "ProgressBar-3":U)
    ProgressBar-3:NAME = "ProgressBar-3":U
    chProgressBar-4 = ProgressBar-4:COM-HANDLE
    UIB_S = chProgressBar-4:LoadControls( OCXFile, "ProgressBar-4":U)
    ProgressBar-4:NAME = "ProgressBar-4":U
    chProgressBar-5 = ProgressBar-5:COM-HANDLE
    UIB_S = chProgressBar-5:LoadControls( OCXFile, "ProgressBar-5":U)
    ProgressBar-5:NAME = "ProgressBar-5":U
    chProgressBar-6 = ProgressBar-6:COM-HANDLE
    UIB_S = chProgressBar-6:LoadControls( OCXFile, "ProgressBar-6":U)
    ProgressBar-6:NAME = "ProgressBar-6":U
  .
  RUN initialize-controls IN THIS-PROCEDURE NO-ERROR.
END.
ELSE MESSAGE "plan2.wrx":U SKIP(1)
             "The binary control file could not be found. The controls cannot be loaded."
             VIEW-AS ALERT-BOX TITLE "Controls Not Loaded".

&ENDIF

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE disable_UI C-Win  _DEFAULT-DISABLE
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
  IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(C-Win)
  THEN DELETE WIDGET C-Win.
  IF THIS-PROCEDURE:PERSISTENT THEN DELETE PROCEDURE THIS-PROCEDURE.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE enable_UI C-Win  _DEFAULT-ENABLE
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
  RUN control_load.

  {&OPEN-QUERY-DEFAULT-FRAME}
  GET FIRST DEFAULT-FRAME.
  DISPLAY v-origen c_nro_tipo_evento dsc_tipo_evento cdisponibles cteventos 
          ctasig cnecesarios ctnasig num-analizado maxdia faddoper tcapacidad 
          Tavisos dgeomax v-corrida Tlimpia tturno v-sinasig fdesbrec trdur 
          v-mes v-ano pbloque ptentativos ultdia pridia maximo_avisos_dia 
      WITH FRAME DEFAULT-FRAME IN WINDOW C-Win.
  ENABLE RECT-1 v-origen c_nro_tipo_evento dsc_tipo_evento cdisponibles 
         cteventos b-nasig-3 ctasig b-nasig-2 cnecesarios ctnasig b-nasig 
         num-analizado maxdia faddoper tcapacidad Tavisos Tlimpia Bcapac 
         Bagenda_recurso tturno fdesbrec BUTTON-2 Beventos trdur v-mes v-ano 
         BUTTON-8 BUTTON-11 brecursos pbloque ptentativos ultdia pridia 
         BUTTON-7 BUTTON-6 BUTTON-5 maximo_avisos_dia BUTTON-10 Bborraultimo 
      WITH FRAME DEFAULT-FRAME IN WINDOW C-Win.
  {&OPEN-BROWSERS-IN-QUERY-DEFAULT-FRAME}
  VIEW C-Win.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE genera_avisos C-Win 
PROCEDURE genera_avisos :
/*------------------------------------------------------------------------------
  Purpose:    genera avisos pendientes de cualquier tipo de evento
              esto hace que cada corrida los avisos se automantengan.
   
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEFINE BUFFER bevento FOR evento.
    DEFINE VAR ii AS INT.
    IF NOT tavisos:CHECKED IN FRAME {&FRAME-NAME} THEN LEAVE.
    IF cteventos = 0 THEN LEAVE.
    chProgressBar-5:XP_ProgressBar:max = cteventos.  
    ii = 0.  
    FOR EACH evento WHERE evento.origen = "CONTRATO" AND
        evento.fasignado >= TODAY AND 
        evento.frealizado = ? AND NOT anulado AND evento.sub_evento = 1:
        ii = ii + 1.
        IF ii > cteventos THEN ii = 1.
        IF ii > 0 THEN chProgressBar-5:XP_ProgressBar:value = ii.
        FIND restriccion WHERE restriccion.cdg_restriccion BEGINS "AVISO" AND
            restriccion.nro_tipo_evento = evento.nro_tipo_evento NO-LOCK NO-ERROR.
        FIND contrato_restriccion NO-LOCK WHERE contrato_restriccion.nro_contrato = evento.nro_identificacion AND 
            contrato_restriccion.sub_evento = evento.sub_evento AND
            contrato_restriccion.nro_restriccion = restriccion.nro_restriccion NO-ERROR.
        IF NOT AVAILABLE contrato_restriccion THEN NEXT.
        FIND bevento WHERE bevento.refevento = evento.nro_evento AND
            NOT bevento.anulado NO-LOCK NO-ERROR.
        IF NOT AVAILABLE bevento THEN 
        DO:
            /*esto no es lo perfecto pero por compromiso solo se regereran avisos cuando es derivado de un contrato caso contrario hay que hacerlo a mano*/
            IF evento.origen = "CONTRATO" THEN
                RUN crea_aviso_evento.p ( INPUT ROWID(evento) ).
            IF evento.origen = "MANUAL" THEN 
            DO:
                FIND bevento WHERE bevento.refevento = evento.nro_evento NO-LOCK NO-ERROR.
                IF AVAILABLE bevento THEN 
                    MESSAGE "Verifique el evento aviso y corrijalo manualmente" VIEW-AS ALERT-BOX INFORMATION.
            END.
        END.
           
    END.
    chProgressBar-5:XP_ProgressBar:value = chProgressBar-5:XP_ProgressBar:max.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE incprog3 C-Win 
PROCEDURE incprog3 :
/*------------------------------------------------------------------------------
      Purpose:     
      Parameters:  <none>
      Notes:       
    ------------------------------------------------------------------------------*/
    /*incrementa el progress var 3 */
    DEFINE INPUT PARAMETER vv AS INT NO-UNDO.
    IF vv <= chProgressBar-3:XP_ProgressBar:max AND
        vv >=0 THEN
        chProgressBar-3:XP_ProgressBar:value = vv.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE limpia_mobs C-Win 
PROCEDURE limpia_mobs :
/*------------------------------------------------------------------------------
      Purpose:     
      Parameters:  <none>
      Notes:       
    ------------------------------------------------------------------------------*/
    FOR EACH evento WHERE evento.frealizado = ? AND NOT evento.anulado.
        evento.mobs = "".
    END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE verificabloques C-Win 
PROCEDURE verificabloques :
/*------------------------------------------------------------------------------
      Purpose:     
      Parameters:  <none>
      Notes:       
    ------------------------------------------------------------------------------*/
    DEFINE VAR r AS CHAR NO-UNDO.
    DEFINE BUFFER bcontrato_restriccion FOR contrato_restriccion.
    DEFINE BUFFER ccontrato_restriccion FOR contrato_restriccion.

    FOR EACH contrato_restriccion WHERE contrato_restriccion.nro_restriccion = 14: /*solos los hijos*/
        FIND bcontrato_restriccion WHERE contrato_restriccion.nro_contrato = bcontrato_restriccion.nro_contrato AND
            contrato_restriccion.sub_evento = bcontrato_restriccion.sub_evento AND
            bcontrato_restriccion.nro_restriccion = 1 NO-ERROR.       
        IF NOT AVAILABLE bcontrato_restriccion THEN NEXT.
        R = bcontrato_restriccion.valor. /*valor del recurso en el hijo*/
        FIND ccontrato_restriccion WHERE ccontrato_restriccion.nro_contrato = int(entry(1,contrato_restriccion.valor,"|")) AND
            ccontrato_restriccion.sub_evento = int(entry(2,contrato_restriccion.valor,"|")) AND
            ccontrato_restriccion.nro_restriccion = 1 NO-ERROR. /*recursos del padre*/  
        IF NOT AVAILABLE ccontrato_restriccion THEN 
        DO: 
            MESSAGE "ERROR PADRE INEXISTENTE " contrato_restriccion.valor VIEW-AS ALERT-BOX.
            NEXT.
        END.
        IF ccontrato_restriccion.valor <> r THEN
            MESSAGE "Recursos diferentes en el hijo " + STRING(bcontrato_restriccion.nro_contrato) + "|" + STRING(bcontrato_restriccion.sub_evento) + " con el padre " + contrato_restriccion.valor VIEW-AS ALERT-BOX.
    END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

/* ************************  Function Implementations ***************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION asignado_dia C-Win 
FUNCTION asignado_dia RETURNS INTEGER
    ( INPUT p-nro_tipo_evento AS INT , INPUT pcodigo AS CHAR , INPUT pfecha AS DATE ) :
    /*------------------------------------------------------------------------------
      Purpose: devuelve la duracion que tiene asignada el recurso ese dia para esa habilidad (nro_tipo_evento) 
        Notes:  
    ------------------------------------------------------------------------------*/
    /*es todo lo asignado ese dia independiente del tipo_evento de que se trata queda excluido los avisos*/
    DEFINE BUFFER buevento FOR evento.
    DEFINE VAR nro_tipo_evento_aviso LIKE tipo_evento.nro_tipo_evento NO-UNDO.
    DEF    VAR durac                 AS INT NO-UNDO.
    FIND tipo_evento WHERE tipo_evento.cdg_tipo_evento = "AV" NO-LOCK NO-ERROR.
    nro_tipo_evento_aviso = tipo_evento.nro_tipo_evento.
    durac = 0.
    FOR EACH recurso_agenda WHERE recurso_agenda.cdg_recurso = pcodigo
        AND recurso_agenda.fecha = pfecha ,
        EACH buevento WHERE buevento.nro_evento = recurso_agenda.nro_evento AND
        NOT buevento.anulado AND
        buevento.fasignado <> ? AND
        buevento.evaluar 
        /* AND buevento.nro_tipo_evento = p-nro_tipo_evento */ :
        IF nro_tipo_evento_aviso <> buevento.nro_tipo_evento THEN 
            durac = durac + buevento.duracion.
    END.
    RETURN durac.   /* Function return value. */

END FUNCTION.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION asignar_dia C-Win 
FUNCTION asignar_dia RETURNS LOGICAL
    ( nro AS INT , fecha AS DATE ) :
    /*------------------------------------------------------------------------------
      Purpose: asigna el evento al dia prefijado si no puede retorna false  
        Notes: busca el mejor vecino de un evento del mismo tipo , si no encuentra ninguno asigna segun balanceo a los recursos
    ------------------------------------------------------------------------------*/


    DEFINE BUFFER bevento  FOR evento.
    DEFINE BUFFER cevento  FOR evento.
    DEFINE BUFFER bcliente FOR cliente.
    DEFINE VAR vgeoX       AS DECIMAL NO-UNDO.
    DEFINE VAR vgeoY       AS DECIMAL NO-UNDO.
    DEFINE VAR i           AS INT NO-UNDO.
    DEFINE VAR fdisponible AS LOGICAL NO-UNDO.
    DEFINE VAR maxdist     AS INTEGER INITIAL 500 NO-UNDO. /*distancia maxima en metros*/

    DEFINE VAR almenos     AS LOGICAL NO-UNDO.
    DEFINE VAR sinasig     AS INT NO-UNDO.
    DEFINE VAR dummydist   AS DECIMAL NO-UNDO.
    DEFINE VAR ii          AS INT NO-UNDO.
    DEFINE VAR k           AS DATE    NO-UNDO.
    DEFINE BUFFER bant FOR evento.
    DEFINE VAR aviso_nro_tipo_evento LIKE tipo_evento.nro_tipo_evento NO-UNDO.

    FIND evento WHERE evento.nro_evento = nro NO-ERROR.
    IF NOT AVAILABLE evento THEN RETURN FALSE.
    FIND cliente OF evento NO-LOCK NO-ERROR.
    IF NOT AVAILABLE cliente THEN 
    DO:
        MESSAGE "Error interno  no existe el cliente para evento:" evento.nro_evento VIEW-AS ALERT-BOX.
        NEXT.
    END.
    vgeoX = cliente.geoX.
    vgeoY = cliente.geoY.
    EMPTY TEMP-TABLE evearea.
    
    /*vemos que vecinos de ese mismo tipo hay para ese dia*/
    FOR EACH bevento WHERE bevento.fasignado = fecha AND 
        bevento.frealizado = ? AND 
        bevento.fasignado <> ? AND
        bevento.recursos <> "" AND
        NOT bevento.anulado AND
        ROWID(bevento) <> ROWID(evento) AND
        evento.nro_tipo_evento = bevento.nro_tipo_evento NO-LOCK:
        IF bevento.fasignado < TODAY THEN NEXT.
        FIND cliente OF bevento NO-LOCK NO-ERROR.
        IF NOT AVAILABLE cliente THEN 
        DO:
            MESSAGE "Error interno  no existe el cliente para evento:" bevento.nro_evento VIEW-AS ALERT-BOX.
            NEXT.
        END.
        /* calculando el distancias */
        dummydist = distGeodesicaUTM(cliente.geoX , cliente.geoY ,
            vgeoX,vgeoY).
        CREATE evearea.
        FIND bcliente OF bevento NO-LOCK.
        evearea.direccion = bcliente.direccion.
        evearea.nro_evento = bevento.nro_evento.
        evearea.recursos = ENTRY(1,bevento.recursos).
        evearea.distancia = dummydist.
    END.
    /*asignando el mejor de los posibles*/
    FOR EACH evearea BY evearea.distancia:
        FIND bevento WHERE bevento.nro_evento = evearea.nro_evento.
        IF NOT disponible(evento.nro_tipo_evento , 
            bevento.recursos , 
            fecha , 
            evento.duracion ,
            evento.turno )  THEN NEXT.
        evento.recursos = evearea.recursos.
        evento.fasignado = bevento.fasignado.
        evento.nro_plan = nplan.
        evento.mobs = wmobs(evento.mobs ,"Cercano EV:" + STRING(evearea.nro_evento) + "[" + STRING(evearea.distancia) + "] " + evearea.direccion).
        /*crea agenda de recurso*/
        FIND recurso_agenda WHERE recurso_agenda.nro_evento  = evento.nro_evento NO-ERROR.
        IF AVAILABLE recurso_agenda THEN 
        DO:
            MESSAGE "Error en la agenda de los recursos ya existe el evento " evento.nro_evento  SKIP
                "y se esta asignado ahora" VIEW-AS ALERT-BOX ERROR.
            RETURN ERROR.
        END.
        CREATE recurso_agenda.
        ASSIGN 
            recurso_agenda.cdg_recurso = evento.recursos
            recurso_agenda.fecha       = evento.fasignado
            recurso_agenda.nro_evento  = evento.nro_evento
            ctasig                     = ctasig + 1.
        DISPLAY ctasig WITH FRAME {&FRAME-NAME}.
        recurso_agenda.observacion = IF recurso_agenda.observacion <> "" THEN recurso_agenda.observacion + " " + evento.mobs ELSE evento.mobs.
        FIND balanceo WHERE balanceo.cdg_recurso = recurso_agenda.cdg_recurso NO-ERROR.
        IF AVAILABLE balanceo THEN
            ASSIGN balanceo.utilizacion = balanceo.utilizacion + evento.duracion.                                                                                                                              
        RETURN TRUE.                                                                                                                                        
    END.
    /*sigue sin asignar vemos los distintos recursos y se lo ponemos al que menos cosas tiene*/
    FOR EACH balanceo BY balanceo.utilizacion:
        /*sirve el recurso*/
        IF NOT disponible(evento.nro_tipo_evento , 
            balanceo.cdg_recurso , 
            fecha , 
            evento.duracion ,
            evento.turno )  THEN NEXT.
        FIND recurso_agenda WHERE recurso_agenda.nro_evento  = evento.nro_evento NO-ERROR.
        IF AVAILABLE recurso_agenda THEN 
        DO:
            MESSAGE "Error en la agenda de los recursos ya existe el evento " evento.nro_evento  SKIP
                "y se esta asignado ahora" VIEW-AS ALERT-BOX ERROR.
            RETURN ERROR.
        END.
        evento.recurso =  balanceo.cdg_recurso.
        evento.nro_plan = nplan.
        CREATE recurso_agenda.
        ASSIGN 
            recurso_agenda.cdg_recurso = evento.recursos
            recurso_agenda.fecha       = evento.fasignado
            recurso_agenda.nro_evento  = evento.nro_evento
            ctasig                     = ctasig + 1.
        recurso_agenda.observacion = IF recurso_agenda.observacion <> "" THEN recurso_agenda.observacion + " " + evento.mobs ELSE evento.mobs.
        balanceo.utilizacion = balanceo.utilizacion + evento.duracion.                                                                                                                              
        DISPLAY ctasig WITH FRAME {&FRAME-NAME}.
        RETURN TRUE.                                                                                                                                        
    END.
    RETURN FALSE.
END FUNCTION.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION asignar_evento C-Win 
FUNCTION asignar_evento RETURNS LOGICAL
    ( pnro_evento AS INTEGER , analizar_compatibilidad AS LOGICAL ,pind AS INT) :
    /*------------------------------------------------------------------------------
      Purpose: asigna el evento y a todos los que estan encadenados, 
               al asignar un padre confirma las agenda de todos los hijos.
               
      Notes: geocod habilita la geocodificacion, en la compatibilidad
             el pind indica el orden del analisis dentro del nro_plan
             para referencias y 
    ------------------------------------------------------------------------------*/

    DEF VAR flg        AS LOGICAL   NO-UNDO.
    DEF VAR ppadre     AS INTEGER   NO-UNDO.   
    DEF VAR i          AS INTEGER   NO-UNDO.
    DEF VAR res        AS LOGICAL   NO-UNDO.
    DEF VAR pagrupados AS CHARACTER NO-UNDO.
    DEF VAR arecursos  AS CHAR NO-UNDO.
    DEF VAR pevsigue   AS INT   NO-UNDO.
    DEF BUFFER bevento    FOR evento.
    DEF BUFFER banalizado FOR analizado.
    DEF VAR urec AS INT NO-UNDO.
    DEFINE VAR auxv AS LOGICAL NO-UNDO.
    FIND evento WHERE evento.nro_evento = pnro_evento .

    IF evento.fasignado <> ? THEN RETURN TRUE.
    DO TRANSACTION:

        FIND analizado WHERE analizado.nro_evento = pnro_evento NO-ERROR.
        IF NOT AVAILABLE analizado THEN  RETURN FALSE. /*solo padres*/
        /*como es reentrante cuando asigna los eventos B que dependen de A le asigna el numero de orden de A*/
        analizado.ind = pind.

        ppadre = IF evento.nro_evento_padre = 0 OR CAN-DO(pbloque,replace(evento.recursos,"#","")) THEN evento.nro_evento ELSE evento.nro_evento_padre.
        IF ppadre <> pnro_evento THEN 
        DO:                                                   
            MESSAGE "Se ha realizado un bloque de bloques ,operacion no permitida" SKIP
                "detectado con el evento " pnro_evento "cuyo restrictor es el evento identificacion es  " evento.nro_identificacion SKIP
                "y que a su vez tiene como padre el " ppadre SKIP
                "Elimine el problema y ejecute nuevamente"
                VIEW-AS ALERT-BOX ERROR. 
            RETURN ?.                                                                   
        END.

        arecursos=replace(analizado.recursos,"#","").
        pevsigue=analizado.evsigue.
        pagrupados = analizado.agrupados. /*eventos que conforman el bloque*/

        IF SUBSTRING(analizado.recursos,1,1) = "#" AND NOT can-do(ptentativos,entry(1,arecursos)) THEN 
        DO: /*mandatorio ubicar esos recursos*/
            IF NOT ubicar_evento( arecursos , pnro_evento, "", 0 , analizar_compatibilidad ,FALSE ,FALSE) THEN 
            DO:
                IF NOT ubicar_evento( arecursos , pnro_evento, "", 0 , analizar_compatibilidad , FALSE,TRUE ) THEN 
                DO:
                    IF NOT ubicar_evento( arecursos , pnro_evento, "", 0 , analizar_compatibilidad ,TRUE,FALSE ) THEN 
                    DO:
                        IF fdesbrec THEN 
                        DO:
                            urec = ubicar_N_evento( pnro_evento,  num-entries(arecursos), "CFOPER[ " + arecursos + "]", 0 , analizar_compatibilidad ).
                            IF  urec <> 0 AND urec = 1 THEN 
                            DO:
                                IF faddoper THEN 
                                DO:
                                    urec = ubicar_N_evento( pnro_evento,  num-entries(arecursos) + 1, "ADDOPER[ " +  arecursos + "]", 1 , analizar_compatibilidad ).
                                    IF urec <> 0 AND urec = 1 THEN
                                        urec = ubicar_N_evento( pnro_evento,  num-entries(arecursos) + 1, "ADD2OPER[ " +  arecursos + "]" , 2 , analizar_compatibilidad ).
                                END.
                            END.
                            res = urec = 0.
                        END.
                    END.
                END.
            END.
            ELSE res = TRUE.
        END.
        ELSE 
        DO:
            IF arecursos <> "" THEN 
            DO:
                IF NOT ubicar_evento( arecursos , pnro_evento , "" , 0 , analizar_compatibilidad , FALSE,FALSE) THEN  
                DO:
                    /*intentar ubicar a estos recursos*/
                    /*se asignara el analizado a los recursos, en caso de mas de un recurso con esa habilidad se verificara
                      se tomara segun el balanceo de los que tengan prioridad en 9-5 sino a todos los que tengan esa habilidad*/ 
                    /*primero intentar con los de 9-5 de prioridad*/
                    IF NOT ubicar_evento( arecursos , pnro_evento , "" , 0 , analizar_compatibilidad , FALSE,TRUE) THEN  
                    DO:
                        IF NOT ubicar_evento( arecursos , pnro_evento , "" , 0 , analizar_compatibilidad , TRUE,FALSE) THEN  
                        DO:
                            IF NOT ubicar_evento( arecursos , pnro_evento , "" , 0 , FALSE , TRUE,TRUE) THEN  
                            DO:
                                urec = ubicar_N_evento( pnro_evento,  num-entries(arecursos) , "OPER[ " + arecursos + "]" , 0 , analizar_compatibilidad ).
                                IF urec <> 0 AND urec > 1 THEN 
                                DO:
                                    IF faddoper THEN 
                                    DO:
                                        urec =  ubicar_N_evento( pnro_evento,  num-entries(arecursos) , "ADDOPER[ " + arecursos + "]" , 1 , analizar_compatibilidad ).
                                        IF urec <> 0 AND urec > 1 THEN
                                            urec = ubicar_N_evento( pnro_evento,  num-entries(arecursos) , "ADDOPER[ " + arecursos + "]" , 2 , analizar_compatibilidad ).
                                    END.
                                END.
                                res = urec = 0.
                            END.
                        END.
                    END.
                END.
                ELSE res = TRUE.
            END.
            ELSE 
            DO:
                urec = ubicar_N_evento( pnro_evento,  1 , "OPER NO FIJADO" , 0 , analizar_compatibilidad  ).
                IF urec <> 0 AND urec > 1 THEN 
                DO:
                    IF faddoper THEN 
                    DO:
                        urec =  ubicar_N_evento( pnro_evento,  num-entries(arecursos) , "ADDOPER[ " + arecursos + "]" , 1 , analizar_compatibilidad ).
                        IF urec <> 0 AND urec > 1 THEN
                            urec = ubicar_N_evento( pnro_evento,  num-entries(arecursos) , "ADDOPER[ " + arecursos + "]" , 2 , analizar_compatibilidad ).
                    END.
                END.
                res = urec = 0.
            END.
        END.
        
        IF NOT res THEN RETURN FALSE. /*no tiene sentido seguir asi no esta asignado el principal*/
        evento.mobs = wmobs(evento.mobs,"AGENDA").

        /*Verificar la existencia de un sub_evento de orden mayor a 1, busca el padre y lo asigna*/
        DO i = 1 TO num-entries(pagrupados): 
            /*debe seguir igual porque pueden no estar ablocados IF int(ENTRY(1,pagrupados)) = pnro_evento THEN NEXT.*/
            FIND evento WHERE evento.nro_evento = integer( entry( i , pagrupados )) NO-ERROR.
            IF NOT AVAILABLE evento THEN NEXT.
            IF evento.fasignado = ? THEN NEXT. /*el proceso de hubicar los asigno a todos los hijos, deberia esta asignado*/
            FIND FIRST bevento WHERE evento.nro_identificacion = bevento.nro_identificacion  AND
                bevento.sub_evento > evento.sub_evento AND bevento.fasignado = ? AND
                bevento.fmin >= evento.fmin AND bevento.fmax <= evento.fmax 
                NO-ERROR.
            IF NOT AVAILABLE bevento THEN NEXT.
            /*buscar el padre de ese evento*/
            ppadre = IF bevento.nro_evento_padre = 0  OR CAN-DO(pbloque,replace(evento.recursos,"#","")) THEN bevento.nro_evento ELSE bevento.nro_evento_padre.
            RUN VALUE(trim(evento.origen) + "-opr2.p" ) ( 
                INPUT-OUTPUT TABLE analizado, 
                INPUT-OUTPUT TABLE rvalor, 
                INPUT THIS-PROCEDURE,
                INPUT ppadre , 
                INPUT nplan).
            IF ERROR-STATUS:ERROR THEN 
            DO:
                MESSAGE "Se Detiene el proceso por errores"SKIP
                    "revise c:\sic-temp\erroresplan" + STRING(nplan) + ".txt" VIEW-AS ALERT-BOX ERROR.
                RETURN ERROR.
            END.
            auxv = asignar_evento(ppadre, FALSE , pind).
            IF auxv = ? THEN leave.
        END.
        /* lo sigue algun evento? */
        pagrupados = "".

        FOR EACH banalizado WHERE banalizado.evsigue = pnro_evento NO-LOCK :
            IF banalizado.nro_evento <> pnro_evento THEN
                pagrupados = pagrupados + "," + STRING(banalizado.nro_evento).
        END.
        pagrupados = IF pagrupados <> "" THEN SUBSTRING(pagrupados,2) ELSE "".

        DO i = 1 TO num-entries(pagrupados):
            
            RUN VALUE(trim(evento.origen) + "-opr2.p" ) ( 
                INPUT-OUTPUT TABLE analizado, 
                INPUT-OUTPUT TABLE rvalor, 
                INPUT THIS-PROCEDURE,
                INPUT INT(ENTRY(i,pagrupados)),
                nplan ).
            IF ERROR-STATUS:ERROR THEN 
            DO:
                MESSAGE "Se Detiene el proceso por errores"SKIP
                    "revise c:\sic-temp\erroresplan" + STRING(nplan) + ".txt" VIEW-AS ALERT-BOX ERROR.
                RETURN ERROR.
            END.
            auxv = asignar_evento(INPUT INT(ENTRY(i,pagrupados)) , FALSE ,pind).
            IF auxv = ? THEN leave.
            res = res AND auxv.
        END.
    END.
    IF NOT res THEN UNDO.
    RETURN res.   /* Function return value. */
END FUNCTION.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION calcula_encadenado C-Win 
FUNCTION calcula_encadenado RETURNS INTEGER
    ( pagrupado AS CHARACTER ) :
    /*------------------------------------------------------------------------------
      Purpose:  Funcion que  los eventos que dependen de este , 
      eso implica que una vez asignado se asignarar los encadenados
      y eso sucede por:
        subeventos de nivel superior
        eventos que lo siguen ( tienen restriccion dfEV ) campo evsigue es el nro de evento del cual dependen
    ------------------------------------------------------------------------------*/
    DEF VAR i   AS INTEGER NO-UNDO.
    DEF VAR res AS INTEGER NO-UNDO.
    DEFINE BUFFER buevento    FOR evento .
    DEFINE BUFFER beevento    FOR evento .
    DEFINE BUFFER buanalizado FOR analizado.

    res = 0.
    DO i  = 1 TO num-entries(pagrupado):
        FIND beevento WHERE beevento.nro_evento = integer(entry(i,pagrupado)).
        FOR EACH buevento WHERE buevento.nro_identificacion = beevento.nro_identificacion
            AND buevento.sub_evento > beevento.sub_evento AND
            buevento.fmin >= beevento.fmin AND
            buevento.fmax >= beevento.fmax :
            IF buevento.duracion <> 0 THEN res = res + 1. /*si son hitos no estan considerados en los encadenados*/
            FOR EACH buanalizado WHERE buanalizado.agrupado CONTAINS STRING(buevento.nro_evento):
                IF LOOKUP(STRING(buevento.nro_evento),pagrupado) <> 0 THEN /*no alcanza con el contains*/
                    res = res + calcula_encadenado(buanalizado.agrupado).
            END.
        END.
        /*eventos que siguen al pasado como parametro*/

        FIND FIRST buanalizado WHERE buanalizado.evsigue = integer(entry(i,pagrupado)) NO-ERROR.
        IF AVAILABLE buanalizado THEN 
        DO:
            FIND beevento OF analizado.
            IF beevento.duracion <> 0 THEN res = res + 1. /*si son hitos no estan considerados en los encadenados*/
            /*MESSAGE "dfEV" beevento.nro_identificacion beevento.sub_evento.*/
            res = res + calcula_encadenado(STRING(buanalizado.nro_evento)).
        END.
    END.
    RETURN res.   /* Function return value. */

END FUNCTION.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION cerrar C-Win 
FUNCTION cerrar RETURNS LOGICAL
    ( hh AS WIDGET-HANDLE ) :
    /*------------------------------------------------------------------------------
      Purpose:  
        Notes:  
    ------------------------------------------------------------------------------*/
    IF VALID-HANDLE(hh) THEN   
    DO:
        RUN dispatch IN hh ( INPUT 'destroy':U ) . 
        RETURN TRUE.
    END.
    ELSE RETURN FALSE.   /* Function return value. */

END FUNCTION.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION compatible C-Win 
FUNCTION compatible RETURNS LOGICAL
    ( pnro-evento AS INT , lista AS CHAR, pfecha AS DATE ) :
    /*------------------------------------------------------------------------------
      Purpose: Verifica compatibilidad del evento a asignar con otros eventos asignados el mismo dia 
               para todos los operarios involucrados en la lista.
               no pueden tener turno iguales, M mañana T tarde * cualquiera.
               Verifica que por lo menos exista unos de los eventos de la agenda a menos de la distancia geomax con el evento a asignar
               El pnro-evento puede ser un bloque por lo que en ese caso todos los eventos hijos tienen que ser compatibles 
                  en los turnos no es necesario en la geocodificacion
               Para el caso de Cobranzas no existen incompatibilidad solo contra turno del recurso
               
        Notes: Toma las geocodificaciones de los clientes.
    ------------------------------------------------------------------------------*/
    DEFINE BUFFER b1evento    FOR evento.
    DEFINE BUFFER b2evento    FOR evento.
    DEFINE BUFFER b1analizado FOR analizado.
    DEFINE VAR i             AS INT NO-UNDO.
    DEFINE VAR j             AS INT NO-UNDO.
    DEF    VAR sal           AS LOGICAL NO-UNDO.
    DEFINE VAR pgeoX         AS DECIMAL NO-UNDO.
    DEFINE VAR pgeoY         AS DECIMAL NO-UNDO.
    DEFINE VAR geocompatible AS LOGICAL NO-UNDO.
    DEFINE VAR distcalc      AS DECIMAL NO-UNDO.
    DEFINE VAR asdistcalc    AS DECIMAL NO-UNDO.
    DEFINE VAR asevento      AS INT.
    DEFINE VAR almenos       AS LOGICAL NO-UNDO.

    
    
    sal = TRUE.
    asevento = 0.
    asdistcalc = 999999999999999.
    almenos = FALSE.
    FIND b1evento WHERE b1evento.nro_evento = pnro-evento NO-LOCK.
    FIND b1analizado WHERE b1analizado.nro_evento = pnro-evento NO-LOCK . 

    /*veremos la geocodificacion del pnro_evento con los de la agenda.*/
    geocompatible = FALSE.
    IF b1evento.fasignado = ? THEN 
    DO:
        
        FIND cliente OF b1evento.
        pgeoX = cliente.geoX.
        pgeoY = cliente.geoY.
        DO j = 1 TO NUM-ENTRIES(lista): /*cada recurso involucrados*/
            FOR EACH recurso_agenda WHERE recurso_agenda.cdg_recurso = ENTRY( j , lista ) AND recurso_agenda.fecha = pfecha,
                EACH b2evento WHERE b2evento.nro_evento = recurso_agenda.nro_evento AND
                b2evento.origen = b1evento.origen AND
                b1evento.nro_tipo_evento = b2evento.nro_tipo_evento AND
                rowid(b1evento) <> rowid(b2evento) NO-LOCK:
                almenos = TRUE.
                FIND cliente OF b2evento.
                /*al menos uno tiene que ser compatible*/
                distcalc = distgeodesicaUTM( pgeoX , pGeoY , cliente.geoX , cliente.geoY ).
                IF distcalc <= dgeomax THEN 
                DO: 
                    geocompatible = TRUE.
                    IF distcalc < asdistcalc THEN 
                    DO:
                        asdistcalc = distcalc.
                        asevento = b2evento.nro_evento.
                    END.
                END.
            END.
        END.
    END.
    ELSE geocompatible = TRUE. /*no se puede hacer nada hay que darlo por bueno*/
    IF almenos AND NOT geocompatible THEN RETURN FALSE.
    IF asevento <> 0 THEN 
        b1evento.mobs = wmobs(b1evento.mobs,"GEO: " + STRING(asevento) + " a " + STRING(int(asdistcalc))). 

    /*el evento a analizar a su vez puede ser un bloque con varios eventos*/
    /*ver que ninguno de los eventos que estan por asignarse tengan un turno igual a los eventos existentes en ninguno de los recursos de la lista*/ 
    IF NOT tturno OR b1evento.origen <> "CONTRATO" THEN RETURN TRUE.
    DO i = 1 TO NUM-ENTRIES(b1analizado.agrupados):
        FIND b1evento WHERE b1evento.nro_evento = int( entry(i , b1analizado.agrupados )) NO-LOCK.
        IF b1evento.fasignado <> ? THEN NEXT.
        
        DO j = 1 TO NUM-ENTRIES(lista): /*cada recurso involucrados*/
            FOR EACH recurso_agenda WHERE recurso_agenda.cdg_recurso = ENTRY( j , lista ) AND recurso_agenda.fecha = pfecha,
                EACH b2evento WHERE b2evento.nro_evento = recurso_agenda.nro_evento AND
                b2evento.origen = b1evento.origen AND
                b1evento.nro_tipo_evento = b2evento.nro_tipo_evento AND
                rowid(b1evento) <> rowid(b2evento) NO-LOCK:
                
                /*veamos los turnos todos tiene que ser compatibles*/
                sal = substring(b1evento.turno, 1,1 ) = substring(b2evento.turno, 1, 1 ) OR
                    substring(b1evento.turno, 1,1 ) = "*" OR 
                    substring(b2evento.turno, 1, 1 ) = "*" .
                IF NOT tturno AND sal THEN RETURN TRUE.
                sal = sal AND ( substring(b1evento.turno, 2,1 ) = "*" OR 
                    substring(b2evento.turno, 2, 1 ) = "*" OR
                    substring(b1evento.turno, 2,1 ) <> substring(b2evento.turno, 2, 1)).
                IF NOT sal THEN RETURN FALSE.
            END.
            
        END.
        
    END.
    RETURN TRUE.
END FUNCTION.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION disponible C-Win 
FUNCTION disponible RETURNS LOGICAL
    ( INPUT p-nro_tipo_evento AS INT , INPUT lista AS CHAR , pfecha AS DATE , durac AS INT ,pturno AS CHAR ) :
    /*------------------------------------------------------------------------------
      Purpose:  verifica que todos los recursos de la lista tengan disponibilidad de una duracion determinada para un dia 
                y que la cantidad de eventos totales de ese turno (M,T) sea menos al maxdia (ver eventosXdia)
                
        Notes:  
    ------------------------------------------------------------------------------*/
    DEF VAR i AS INT NO-UNDO.      
    DO i = 1 TO NUM-ENTRIES(lista):
        FIND recurso_capacidad WHERE recurso_capacidad.nro_tipo_evento = p-nro_tipo_evento AND 
            recurso_capacidad.cdg_recurso = entry(i,lista) AND
            recurso_capacidad.fecha = pfecha NO-LOCK NO-ERROR.
        IF NOT AVAILABLE recurso_capacidad THEN RETURN FALSE.
        IF eventosXdia(INPUT p-nro_tipo_evento ,INPUT recurso_capacidad.cdg_recurso,pfecha,pturno ) > maxdia THEN RETURN FALSE.
        IF recurso_capacidad.capacidad - asignado_dia( INPUT p-nro_tipo_evento , 
            INPUT recurso_capacidad.cdg_recurso,pfecha ) < durac THEN 
        DO:
            RETURN FALSE.
        END.

        /*agregado para que no se superen las horas trabajadas*/
        FIND recurso_horasxdia WHERE 
            recurso_horasxdia.cdg_recurso = entry(i,lista) AND
            recurso_horasxdia.fecha = pfecha NO-LOCK NO-ERROR.
        IF NOT AVAILABLE recurso_horasxdia THEN RETURN FALSE.
        IF recurso_horasxdia.horas - asignado_dia( INPUT p-nro_tipo_evento , 
            INPUT recurso_horasxdia.cdg_recurso,pfecha ) < durac THEN 
        DO:
            RETURN FALSE.
        END.
    END.
    RETURN TRUE.   

END FUNCTION.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION duref C-Win 
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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION eventosxdia C-Win 
FUNCTION eventosxdia RETURNS INTEGER
    ( ptipo AS INT , pcdg_recurso AS CHAR , pfecha AS DATE, pturno AS CHAR ) :
    /*------------------------------------------------------------------------------
      Purpose:  entrega la cantidad de eventos del tipo especificado que hay en ese dia para el operario
                teniendo en cuenta el turno, y tipo de los eventos
                pturno es el turno que se quiera averiguar solo toma el primer caracter
    para mantener la variable entera sumo de a 2 en casi de M o T y 1 en caso de *.
    * * 1
    * T,M 1
    T,M * 1
    T,M T,M 2
    ------------------------------------------------------------------------------*/
    DEFINE VAR kk AS INT NO-UNDO.
    DEFINE BUFFER evex FOR evento.
    pturno = substring(pturno,1,1).
    FOR EACH recurso_agenda WHERE recurso_agenda.fecha = pfecha AND
        recurso_agenda.cdg_recurso = pcdg_recurso NO-LOCK:
        FIND recurso OF recurso_agenda NO-LOCK.
        FIND evex OF recurso_agenda WHERE 
            evex.nro_tipo_evento = ptipo NO-LOCK NO-ERROR.
        IF NOT AVAILABLE evex THEN NEXT.

        IF pturno = "*" THEN kk = kk + 1.
        ELSE 
        DO: 
            IF pturno = SUBSTRING(evex.turno,1,1) THEN kk = kk + 2.
            ELSE IF SUBSTRING(evex.turno,1,1) = "*" THEN kk = kk + 1.
        END.

                
    END.
    kk = kk / 2.
    RETURN  kk .   /* Function return value. */
END FUNCTION.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION rdur C-Win 
FUNCTION rdur RETURNS INTEGER
    ( rr AS INT ) :
    /*------------------------------------------------------------------------------
      Purpose:  Duracion media
        Notes:  Se tiene en cuenta de descartar valores  alejados +- 20% de la media
    ------------------------------------------------------------------------------*/
    DEFINE VAR kk    AS INT NO-UNDO.
    DEFINE VAR pp1   AS INT NO-UNDO.
    DEFINE VAR media AS INT NO-UNDO.
    DEFINE VAR suma  AS INT NO-UNDO.
    DEFINE VAR pp    AS INT INITIAL 5 NO-UNDO. /*cantidad de periodos maximos de analisis*/
    DEFINE BUFFER bevento FOR evento.
    DEFINE BUFFER weve    FOR evento.
    pp1 = 0.
    suma = 0.
    FIND weve WHERE weve.nro_evento = rr NO-LOCK.
    CASE weve.origen:
        WHEN "CONTRATO" THEN 
            DO:
                FOR EACH bevento WHERE bevento.origen = weve.origen AND 
                    bevento.nro_identificacion = weve.nro_identificacion AND
                    bevento.sub_evento = weve.sub_evento AND
                    NOT bevento.anulado AND bevento.frealizado<>? BY bevento.fasignado DESCENDING:
                    kk = abs(duref(bevento.hora_desde, bevento.hora_hasta)).
                    IF kk = 0 THEN NEXT.
                    pp1 = pp1 + 1.
                    suma = suma + kk.
                    IF pp1 > pp THEN LEAVE.
                END.
                media = suma / pp1.
                pp1 = 0.
                suma = 0.
                FOR EACH bevento WHERE bevento.origen = weve.origen AND 
                    bevento.nro_identificacion = weve.nro_identificacion AND
                    bevento.sub_evento = weve.sub_evento AND
                    NOT bevento.anulado AND bevento.frealizado<>? BY bevento.fasignado DESCENDING:
                    kk = duref(bevento.hora_desde, bevento.hora_hasta).
                    IF kk <= media * .8 OR kk >= media * 1.2 THEN NEXT.
                    pp1 = pp1 + 1.
                    suma = suma + duref(bevento.hora_desde, bevento.hora_hasta).
                    IF pp1 > pp THEN LEAVE.
                END.
                media = suma / pp1.
                RETURN media.
            END.
        WHEN "COBRANZA" THEN 
            DO:
                FOR EACH bevento WHERE bevento.nro_cliente = weve.nro_cliente AND 
                    bevento.nro_tipo_evento = weve.nro_tipo_evento AND
                    NOT bevento.anulado AND bevento.frealizado<>? BY bevento.fasignado DESCENDING:
                    kk = abs(duref(bevento.hora_desde, bevento.hora_hasta)).
                    IF kk = 0 THEN NEXT.
                    pp1 = pp1 + 1.
                    suma = suma + kk.
                    IF pp1 > pp THEN LEAVE.
                END.
                media = suma / pp1.
                pp1 = 0.
                suma = 0.
                FOR EACH bevento WHERE bevento.nro_cliente = weve.nro_cliente AND 
                    bevento.nro_tipo_evento = weve.nro_tipo_evento AND
                    NOT bevento.anulado AND bevento.frealizado<>? BY bevento.fasignado DESCENDING:
                    kk = duref(bevento.hora_desde, bevento.hora_hasta).
                    IF kk <= media * .8 OR kk >= media * 1.2 THEN NEXT.
                    pp1 = pp1 + 1.
                    suma = suma + duref(bevento.hora_desde, bevento.hora_hasta).
                    IF pp1 > pp THEN LEAVE.
                END.
                media = suma / pp1.
                RETURN media.
            END.
        OTHERWISE 
        RETURN ?.
    END.
END FUNCTION.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION tienerestriccion C-Win 
FUNCTION tienerestriccion RETURNS LOGICAL
    ( prow AS ROWID ) :
    /*------------------------------------------------------------------------------
      Purpose:  da true si tiene restricciones
        Notes:  
    ------------------------------------------------------------------------------*/
    DEFINE BUFFER tevento FOR evento.

    FIND tevento WHERE ROWID(tevento) = prow NO-LOCK.
    CASE tevento.origen:
        WHEN "CONTRATO" THEN 
            DO:
                FOR EACH contrato_restriccion NO-LOCK WHERE contrato_restriccion.nro_contrato = tevento.nro_identificacion AND
                    contrato_restriccion.sub_evento = tevento.sub_evento ,
                    EACH restriccion OF contrato_restriccion NO-LOCK WHERE restriccion.esrestriccion AND
                    Restriccion.nro_tipo_evento = tevento.nro_tipo_evento :
                    RETURN TRUE.
                END.
            END.
        WHEN "COBRANZA" THEN 
            DO:
                FOR EACH cliente_restriccion NO-LOCK WHERE cliente_restriccion.nro_cliente = tevento.nro_cliente,
                    EACH restriccion OF cliente_restriccion NO-LOCK WHERE restriccion.esrestriccion AND
                    Restriccion.nro_tipo_evento = tevento.nro_tipo_evento :
                    RETURN TRUE.
                END.
            END.
    END.
    RETURN FALSE.
END FUNCTION.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION ubicar_evento C-Win 
FUNCTION ubicar_evento RETURNS LOGICAL
    ( INPUT lista AS CHAR, pnro_evento AS INT , pmobs AS CHAR , recadd AS INT , analizar_compatibilidad AS LOGICAL,forzado AS LOGICAL,mejorvecino AS LOGICAL) :
    /*------------------------------------------------------------------------------
      Purpose: ubicar el evento en la mejor posicion segun los recursos y tabla rvalor. 
        Notes: Si tiene restriccion se respeta las restricciones y la valorizacion
               si no tiene restricciones se buscara el evento vecino segun la agenda
                del recurso.
               sino el primer dia vacio que lo contenga buscando lo mas vacios primero
    ------------------------------------------------------------------------------*/
    DEF VAR v_i   AS INT NO-UNDO.
    DEF VAR v_j   AS INT NO-UNDO.
    DEF VAR durac AS INT NO-UNDO.

    DEFINE BUFFER buevento      FOR evento.
    DEFINE BUFFER vecino_evento FOR evento.
    DEFINE VAR intento AS INT NO-UNDO.
    IF lista = "" THEN RETURN FALSE.

    IF NUM-ENTRIES(lista) > 1 AND mejorvecino THEN RETURN FALSE.
                                                           
    intento = 0.
    FIND buevento WHERE buevento.nro_evento = pnro_evento. /*evento en tratamiento */
    FIND analizado OF buevento.
    /*IF NOT (analizado.tr OR analizado.encadenado <> 0) AND forzado THEN MESSAGE "PARE" VIEW-AS ALERT-BOX ERROR.*/
    IF analizado.tr OR analizado.encadenado <> 0 OR forzado THEN 
    DO: /*si tiene restriccion no entra en los vecinos se debe intentar hubicar el el primer dia compatible*/
        /*servicios*/
        IF buevento.origen <> "COBRANZA" THEN 
        DO:
     
            FOR EACH rvalor WHERE rvalor.nro_evento = pnro_evento AND ( rvalor.valor <> 0 OR ( NOT analizado.tr AND analizado.encadenado = 0 AND forzado )) USE-INDEX idx2: 
                intento = intento + 1.
                IF rvalor.valor = 0 THEN NEXT. /*si no tiene al menos alguna posibilidad FUERA*/
       
                IF disponible(buevento.nro_tipo_evento , 
                    lista , 
                    rvalor.fecha , 
                    analizado.duracion -  INT(recadd * analizado.duracion / NUM-ENTRIES( lista ) ),buevento.turno ) 
                    THEN 
                DO: /*los recursos necesarios estan disponibles para ser utilizados*/
                    IF analizar_compatibilidad  AND NOT compatible( pnro_evento , lista , rvalor.fecha ) THEN 
                    DO:
                        /*rvalor.mobs = ( IF rvalor.mobs <> "" THEN rvalor.mobs + " " ELSE "" ) + "NO-COMPAT[" + STRING(intento) + "]".*/
                        NEXT.
                    END.
           
                    DO v_i = 1 TO NUM-ENTRIES(analizado.agrupados): /*informar a los eventos hijos*/
                        FIND buevento WHERE buevento.nro_evento = int(entry(v_i,analizado.agrupados)).
                        ASSIGN FRAME {&FRAME-NAME} ctasig.
                        ASSIGN 
                            buevento.recursos  = lista
                            buevento.fasignado = rvalor.fecha.
                        buevento.mobs = wmobs(buevento.mobs,rvalor.mobs). 
                        ctasig = ctasig + 1.
                        buevento.mobs = wmobs(buevento.mobs,pmobs).
                        DISPLAY ctasig WITH FRAME {&FRAME-NAME}.
                        DO v_j = 1 TO NUM-ENTRIES(lista): /*crear las agendas*/
                            FIND balanceo WHERE balanceo.cdg_recurso = ENTRY(v_j,lista).
                            ASSIGN 
                                balanceo.utilizacion = balanceo.utilizacion + buevento.duracion.
                            CREATE recurso_agenda.
                            ASSIGN 
                                recurso_agenda.cdg_recurso = ENTRY(v_j,lista)
                                recurso_agenda.fecha       = rvalor.fecha
                                recurso_agenda.nro_evento  = buevento.nro_evento
                                recurso_agenda.observacion = IF recurso_agenda.observacion <> "" THEN recurso_agenda.observacion + " " + buevento.mobs ELSE buevento.mobs.
                        END.
                    END.
                    RETURN TRUE.   
                END.
            /*ELSE DO:
                 rvalor.mobs = ( IF rvalor.mobs <> "" THEN rvalor.mobs + " " ELSE "" ) + "NO-DISPON[" + STRING(intento) + "]".
            END.*/
            END.
        END.
        ELSE 
        DO: /*es para cobranzas*/
            FOR EACH rvalor WHERE rvalor.nro_evento = pnro_evento AND ( rvalor.valor <> 0 OR ( NOT analizado.tr AND analizado.encadenado = 0 AND forzado )) USE-INDEX idx2: 
                intento = intento + 1.
                IF rvalor.valor = 0 THEN NEXT. /*si no tiene al menos alguna posibilidad FUERA*/
       
                IF disponible(buevento.nro_tipo_evento , 
                    lista , 
                    rvalor.fecha , 
                    analizado.duracion -  INT(recadd * analizado.duracion / NUM-ENTRIES( lista ) ),buevento.turno ) 
                    THEN 
                DO: /*los recursos necesarios estan disponibles para ser utilizados*/
                    IF analizar_compatibilidad  AND NOT compatible( pnro_evento , lista , rvalor.fecha ) THEN 
                    DO:
                        /*rvalor.mobs = ( IF rvalor.mobs <> "" THEN rvalor.mobs + " " ELSE "" ) + "NO-COMPAT[" + STRING(intento) + "]".*/
                        NEXT.
                    END.
           
                    DO v_i = 1 TO NUM-ENTRIES(analizado.agrupados): /*informar a los eventos hijos*/
                        FIND buevento WHERE buevento.nro_evento = int(entry(v_i,analizado.agrupados)).
                        ASSIGN FRAME {&FRAME-NAME} ctasig.
                        ASSIGN 
                            buevento.recursos  = lista
                            buevento.fasignado = rvalor.fecha.
                        buevento.mobs = wmobs(buevento.mobs,rvalor.mobs). 
                        ctasig = ctasig + 1.
                        buevento.mobs = wmobs(buevento.mobs,pmobs).
                        DISPLAY ctasig WITH FRAME {&FRAME-NAME}.
                        DO v_j = 1 TO NUM-ENTRIES(lista): /*crear las agendas*/
                            FIND balanceo WHERE balanceo.cdg_recurso = ENTRY(v_j,lista).
                            ASSIGN 
                                balanceo.utilizacion = balanceo.utilizacion + buevento.duracion.
                            CREATE recurso_agenda.
                            ASSIGN 
                                recurso_agenda.cdg_recurso = ENTRY(v_j,lista)
                                recurso_agenda.fecha       = rvalor.fecha
                                recurso_agenda.nro_evento  = buevento.nro_evento
                                recurso_agenda.observacion = IF recurso_agenda.observacion <> "" THEN recurso_agenda.observacion + " " + buevento.mobs ELSE buevento.mobs.
                        END.
                    END.
                    RETURN TRUE.   
                END.
            /*ELSE DO:
                 rvalor.mobs = ( IF rvalor.mobs <> "" THEN rvalor.mobs + " " ELSE "" ) + "NO-DISPON[" + STRING(intento) + "]".
            END.*/
            END.
        END.
    END.
    ELSE 
    DO: 
        /*no tiene restriccion vamos a intentar asignarle el mejor vecino proximo asignado dentro de la geomax*/
        /*se prioriza si es vecino sobre todo lo demas*/
        /*en donde busca el vecino definir operarios libres*/
        RUN calcula_vecinos(buevento.nro_evento,( IF buevento.recursos BEGINS "#" THEN substr(buevento.recursos,2) ELSE IF buevento.recursos <> "" AND NOT mejorvecino THEN buevento.recursos ELSE ptentativos ) ,OUTPUT TABLE vecinos).
        FOR EACH vecinos BY distancia DESC:
            FIND vecino_evento OF vecinos NO-LOCK.
            FIND rvalor WHERE rvalor.nro_evento = buevento.nro_evento AND
                rvalor.fecha = vecino_evento.fasignado.
            IF rvalor.valor = 0 THEN NEXT. /*descartar los lugares prohibidos con valorizacion en 0.*/

            /*si es el mejor vecino cambiar el recursos propuesto por el del vecino*/
            IF mejorvecino THEN 
            DO:
                pmobs = wmobs(pmobs,"CAMBIO " + lista + " x " + vecino_evento.recursos).
                lista = entry(1,vecino_evento.recursos).
            END.
            IF disponible(buevento.nro_tipo_evento , 
                lista , 
                rvalor.fecha , 
                analizado.duracion - INT(recadd * analizado.duracion / NUM-ENTRIES( lista ) ),buevento.turno) 
                THEN 
            DO: /*los recursos necesarios estan disponibles para ser utilizados*/
                IF analizar_compatibilidad AND NOT compatible( pnro_evento , lista , rvalor.fecha) THEN 
                DO:
                    rvalor.mobs = wmobs(rvalor.mobs,"NO-COMPAT[" + STRING(intento) + "]").
                    NEXT.
                END.
           
                DO v_i = 1 TO NUM-ENTRIES(analizado.agrupados): /*informar a los eventos hijos*/
                    FIND buevento WHERE buevento.nro_evento = int(entry(v_i,analizado.agrupados)).
                    ASSIGN FRAME {&FRAME-NAME} ctasig.
                    ASSIGN 
                        buevento.recursos  = lista
                        ctasig             = ctasig + 1
                        buevento.fasignado = rvalor.fecha.
                    buevento.mobs = wmobs(buevento.mobs,rvalor.mobs). 
                    buevento.mobs = wmobs(buevento.mobs,pmobs).
                    DISPLAY ctasig WITH FRAME {&FRAME-NAME}.
                    DO v_j = 1 TO NUM-ENTRIES(lista): /*crear las agendas*/
                        FIND balanceo WHERE balanceo.cdg_recurso = ENTRY(v_j,lista).
                        ASSIGN 
                            balanceo.utilizacion = balanceo.utilizacion + buevento.duracion.
                        CREATE recurso_agenda.
                        ASSIGN 
                            recurso_agenda.cdg_recurso = ENTRY(v_j,lista)
                            recurso_agenda.fecha       = rvalor.fecha
                            recurso_agenda.nro_evento  = buevento.nro_evento
                            recurso_agenda.observacion = IF recurso_agenda.observacion <> "" THEN recurso_agenda.observacion + " " + buevento.mobs ELSE buevento.mobs.
                    END.
                END.
                RETURN TRUE.   
            END.
        /*ELSE DO:
             rvalor.mobs = ( IF rvalor.mobs <> "" THEN rvalor.mobs + " " ELSE "" ) + "NO-DISPON[" + STRING(intento) + "]".
        END.*/
        END.
    END.
    RETURN FALSE.   /* NO SE PUDO ASIGNAR */  
END FUNCTION.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION ubicar_N_evento C-Win 
FUNCTION ubicar_N_evento RETURNS INTEGER
    ( pnro_evento AS INT, N AS INT , vm AS CHAR, recadd AS INT , analizar_compatibilidad AS LOGICAL) :
    /*------------------------------------------------------------------------------
      Purpose: Ubicar la cantidad de recursos solicitados de ese tipo segun el balanceo 
              y utilizando los mas aptos segun prioridad ( falta no imprementado ) de ser elegidos 
               en la lista se retornan los recursos efectivamente elegidos,
               En vez de una funcion deberia haber sido un procedimiento pero 
               es elije funcion por compatibilidad con ubicar_evento.   
               recadd son los recursos agregados a un evento se disminuye el tiempo en forma proporcional
               aunque en realidad no es asi no se considera el factor molestia o coordinacion
    ------------------------------------------------------------------------------*/
    DEF VAR i      AS INT   NO-UNDO.
    DEF VAR durac  AS INT   NO-UNDO.
    DEF VAR rlista AS CHAR NO-UNDO.
    DEF VAR lista  AS CHAR NO-UNDO.
    DEF    BUFFER banalizado FOR analizado.
    DEF    BUFFER brvalor    FOR rvalor.
    DEFINE BUFFER buevento   FOR evento.
    DEFINE VAR pturno AS CHAR .
    FIND buevento WHERE buevento.nro_evento = pnro_evento.
    pturno = substring(buevento.turno,1,1).
    lista = "".

    FOR EACH balanceo WHERE balanceo.turno = pturno OR balanceo.turno = "I"  BY balanceo.utilizacion : /*intento asignar a los que les asigno menos eventos*/
        IF lookup( cdg_recurso , buevento.recursos) = 0 THEN
            lista = lista + "," + STRING(balanceo.cdg_recurso).
    END.
    lista = IF lista <> "" THEN SUBSTR(lista,2) ELSE "".
    IF NUM-ENTRIES(lista) < n THEN 
    DO:
        MESSAGE "El evento " + STRING(pnro_evento) + " require de " + STRING(n) + " recursos " SKIP
            " y no se llega a la cantidad, verifique " SKIP
            " identificacion " + Evento.Origen + STRING(buevento.nro_identificacion) VIEW-AS ALERT-BOX ERROR.
        RETURN 3. /*no alcanzan los recursos minimos*/
    END.

    FIND FIRST banalizado WHERE banalizado.nro_evento = pnro_evento NO-ERROR.
    IF NOT AVAILABLE banalizado THEN 
    DO:
        MESSAGE "Error interno analizado nro_evento " + STRING(pnro_evento) VIEW-AS ALERT-BOX ERROR.
        RETURN 2.
    END.
    /*encontrar el mejor dia y asignar*/
    IF buevento.origen <> "COBRANZA" THEN 
    DO:

        FOR EACH brvalor WHERE brvalor.nro_evento = banalizado.nro_evento USE-INDEX idx2 : 
            rlista = "".
            DO i = 1 TO NUM-ENTRIES(lista):
                IF  brvalor.valor <> 0 AND  disponible(buevento.nro_tipo_evento , entry(i,lista) , brvalor.fecha, banalizado.duracion  -  INT(recadd * banalizado.duracion / NUM-ENTRIES( vm ) ),buevento.turno ) THEN
                    rlista = IF rlista = "" THEN ENTRY(i,lista) ELSE rlista + "," + ENTRY(i,lista).
                IF num-entries(rlista) >= n THEN LEAVE. /*suficiente estos recursos elegidos tiene disponibilidad*/
            END.
            IF NUM-ENTRIES(rlista) < n THEN NEXT. /*seguir con otro dia para el seleccionado no hay recursos disponibles*/
            IF ubicar_evento(INPUT rlista, banalizado.nro_evento, vm, recadd, analizar_compatibilidad , FALSE,FALSE) THEN RETURN 0.
            IF ubicar_evento(INPUT rlista, banalizado.nro_evento, vm, recadd, analizar_compatibilidad , FALSE,TRUE) THEN RETURN 0.
            IF ubicar_evento(INPUT rlista, banalizado.nro_evento, vm, recadd, analizar_compatibilidad , TRUE,FALSE ) THEN RETURN 0.
        END.
    END.
    ELSE 
    DO:
        FOR EACH brvalor WHERE brvalor.nro_evento = banalizado.nro_evento USE-INDEX idx3 : 
            rlista = "".
            DO i = 1 TO NUM-ENTRIES(lista):
                IF  brvalor.valor <> 0 AND  disponible(buevento.nro_tipo_evento , entry(i,lista) , brvalor.fecha, banalizado.duracion  -  INT(recadd * banalizado.duracion / NUM-ENTRIES( vm ) ),buevento.turno ) THEN
                    rlista = IF rlista = "" THEN ENTRY(i,lista) ELSE rlista + "," + ENTRY(i,lista).
                IF num-entries(rlista) >= n THEN LEAVE. /*suficiente estos recursos elegidos tiene disponibilidad*/
            END.
            IF NUM-ENTRIES(rlista) < n THEN NEXT. /*seguir con otro dia para el seleccionado no hay recursos disponibles*/
            IF ubicar_evento(INPUT rlista, banalizado.nro_evento, vm, recadd, analizar_compatibilidad , FALSE,TRUE) THEN RETURN 0.
            IF ubicar_evento(INPUT rlista, banalizado.nro_evento, vm, recadd, analizar_compatibilidad , TRUE,TRUE) THEN RETURN 0.
        
        END.
    END.
    RETURN 1.   /* NO SE PUDO ASIGNAR */
END FUNCTION.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION wmobs C-Win 
FUNCTION wmobs RETURNS CHARACTER
    ( m AS CHAR , w AS CHAR ) :
    /*------------------------------------------------------------------------------
      Purpose:  
        Notes:  
    ------------------------------------------------------------------------------*/
    IF 
        INDEX( m,w) = 0 THEN RETURN w + IF w = "" THEN m ELSE " " + m.  
    ELSE RETURN w.

END FUNCTION.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

