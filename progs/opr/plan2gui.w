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
    FIELD prioridad AS INTEGER
    FIELD turno AS CHAR LABEL "TU"
    INDEX prior1 utilizacion ASCENDING prioridad DESCENDING
    INDEX baln cdg_recurso
    INDEX utilz IS PRIMARY utilizacion.

DEFINE BUFFER bevento FOR evento.
DEFINE BUFFER banalizado FOR analizado.

define temp-table aanalizar /*tabla que contiene los analizados cuyo sub_evento en 1 ya que en el loop de analizar se modifica en indice*/
    field nro_evento as int
    field ind as integer
    index idx is primary ind.

DEFINE VAR nplan AS INTEGER NO-UNDO.

DEFINE VAR h_capac AS WIDGET-HANDLE NO-UNDO.
DEFINE VAR h_restriccion AS WIDGET-HANDLE NO-UNDO.
DEFINE VAR h_consorcios AS WIDGET-HANDLE NO-UNDO.
DEFINE VAR h_rvalor AS WIDGET-HANDLE NO-UNDO.
DEFINE VAR h_balanceo AS WIDGET-HANDLE NO-UNDO.
DEFINE VAR h_analizado AS WIDGET-HANDLE NO-UNDO.
DEFINE VAR h_agenda_recursos AS WIDGET-HANDLE NO-UNDO.
DEFINE VAR h_eventos AS WIDGET-HANDLE NO-UNDO.
DEFINE VAR h_recursos AS WIDGET-HANDLE NO-UNDO.
DEFINE VAR h_aseventos AS WIDGET-HANDLE NO-UNDO.
DEFINE VAR h_naseventos AS WIDGET-HANDLE NO-UNDO.
{findempresa.i}
{GeoLibrary.I}

DEFINE TEMP-TABLE evearea NO-UNDO
    FIELD nro_evento LIKE evento.nro_evento
    FIELD recursos LIKE evento.recursos
    FIELD turno LIKE evento.turno
    FIELD distancia AS int.


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

DEFINE VAR dgeomax AS DECIMAL INITIAL 400 NO-UNDO.
DEFINE VAR dgeoinc AS DECIMAL INITIAL 100 NO-UNDO.
DEFINE VAR dgeomaxmax AS DECIMAL INITIAL 800 NO-UNDO.
DEFINE VAR corrida AS INT NO-UNDO INITIAL 1.

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
dsc_tipo_evento cdisponibles cteventos ctanal cnecesarios ctasig b-nasig-2 ~
fdesbrec ctnasig b-nasig faddoper tbloques Bcapac Bagenda_recurso BUTTON-2 ~
Beventos v-mes v-ano BUTTON-8 brecursos ultdia pridia BUTTON-7 BUTTON-6 ~
BUTTON-5 Bvalor Bborraultimo 
&Scoped-Define DISPLAYED-OBJECTS v-origen c_nro_tipo_evento dsc_tipo_evento ~
cdisponibles cteventos ctanal cnecesarios ctasig fdesbrec ctnasig faddoper ~
tbloques v-mes v-ano ultdia pridia 

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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION-FORWARD asignar_evento C-Win 
FUNCTION asignar_evento RETURNS CHARACTER
  ( pnro_evento as integer , analizar_compatibilidad AS LOGICAL ,pind AS INT)  FORWARD.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION-FORWARD calcula_encadenado C-Win 
FUNCTION calcula_encadenado RETURNS INTEGER
  ( pagrupado as CHARACTER )  FORWARD.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION-FORWARD cerrar C-Win 
FUNCTION cerrar RETURNS LOGICAL
  ( hh AS WIDGET-HANDLE )  FORWARD.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION-FORWARD compatible C-Win 
FUNCTION compatible RETURNS LOGICAL
  ( pnro-evento AS INT , lista AS CHAR, pfecha AS DATE,dgeomax AS DECIMAL )  FORWARD.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION-FORWARD create_evento C-Win 
FUNCTION create_evento RETURNS LOGICAL
  ( pp as char )  FORWARD.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION-FORWARD desasignar C-Win 
FUNCTION desasignar RETURNS LOGICAL
  ( pnro AS INT )  FORWARD.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION-FORWARD dia_prohibido C-Win 
FUNCTION dia_prohibido RETURNS LOGICAL
  ( /* parameter-definitions */ )  FORWARD.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION-FORWARD disponible C-Win 
FUNCTION disponible RETURNS LOGICAL
  ( INPUT p-nro_tipo_evento AS INT , INPUT lista AS CHAR , pfecha AS DATE , durac AS INT )  FORWARD.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION-FORWARD fechaant C-Win 
FUNCTION fechaant RETURNS DATE ( f AS DATE , d AS INT ) FORWARD.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION-FORWARD prohibir C-Win 
FUNCTION prohibir RETURNS LOGICAL
  ( pnro AS INT )  FORWARD.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION-FORWARD ubicar_N_recurso C-Win 
FUNCTION ubicar_N_recurso RETURNS INTEGER
  ( pnro_evento AS INT, N AS INT , vm AS CHAR, recadd AS INT , analizar_compatibilidad AS LOGICAL)  FORWARD.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION-FORWARD ubicar_recurso C-Win 
FUNCTION ubicar_recurso RETURNS LOGICAL
  ( INPUT lista AS char, pnro_evento AS INT , pmobs AS CHAR , recadd AS INT , analizar_compatibilidad AS LOGICAL)  FORWARD.

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
     SIZE 4 BY .95.

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

DEFINE BUTTON BUTTON-2 
     LABEL "Restricciones" 
     SIZE 15 BY 1.14.

DEFINE BUTTON BUTTON-5 
     LABEL "Analizado" 
     SIZE 15 BY 1.14.

DEFINE BUTTON BUTTON-6 
     LABEL "Rvalor" 
     SIZE 15 BY 1.14.

DEFINE BUTTON BUTTON-7 
     LABEL "Balanceo" 
     SIZE 15 BY 1.14.

DEFINE BUTTON BUTTON-8 
     LABEL "Consorcios" 
     SIZE 15 BY 1.14.

DEFINE BUTTON Bvalor 
     LABEL "Ejecutar" 
     SIZE 15 BY 1.14.

DEFINE VARIABLE c_nro_tipo_evento AS INTEGER FORMAT ">>>>>>>>9" INITIAL 1 
     LABEL "Tipo" 
     VIEW-AS COMBO-BOX INNER-LINES 5
     LIST-ITEM-PAIRS "0",1
     DROP-DOWN-LIST
     SIZE 10.2 BY 1 TOOLTIP "Tipo de Restriccion o Tipo de Evento".

DEFINE VARIABLE v-origen AS CHARACTER FORMAT "X(256)":U INITIAL "CONTRATO" 
     VIEW-AS COMBO-BOX INNER-LINES 5
     LIST-ITEMS "CONTRATO","RECTUCLM","AVISO" 
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

DEFINE VARIABLE ctanal AS INTEGER FORMAT "->,>>>,>>9":U INITIAL 0 
     LABEL "Analizados" 
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

DEFINE VARIABLE dsc_tipo_evento AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 22.2 BY 1 NO-UNDO.

DEFINE VARIABLE pridia AS DATE FORMAT "99/99/9999":U 
     LABEL "del" 
     VIEW-AS FILL-IN 
     SIZE 15.6 BY 1 NO-UNDO.

DEFINE VARIABLE ultdia AS DATE FORMAT "99/99/9999":U 
     LABEL "a" 
     VIEW-AS FILL-IN 
     SIZE 15.2 BY 1 NO-UNDO.

DEFINE VARIABLE v-ano AS INTEGER FORMAT "9999":U INITIAL 0 
     LABEL "" 
     VIEW-AS FILL-IN 
     SIZE 7 BY 1 NO-UNDO.

DEFINE VARIABLE v-mes AS INTEGER FORMAT ">9":U INITIAL 0 
     LABEL "Periodo" 
     VIEW-AS FILL-IN 
     SIZE 6 BY 1 NO-UNDO.

DEFINE RECTANGLE RECT-1
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 54 BY 8.1.

DEFINE VARIABLE faddoper AS LOGICAL INITIAL no 
     LABEL "Agrega Recursos" 
     VIEW-AS TOGGLE-BOX
     SIZE 25 BY .81 TOOLTIP "Agrega operarios para disminuir el tiempo" NO-UNDO.

DEFINE VARIABLE fdesbrec AS LOGICAL INITIAL no 
     LABEL "Cambio Recurso" 
     VIEW-AS TOGGLE-BOX
     SIZE 24 BY .81 TOOLTIP "Cambio de recurso cuando la agenda este agotada" NO-UNDO.

DEFINE VARIABLE tbloques AS LOGICAL INITIAL yes 
     LABEL "Bloques" 
     VIEW-AS TOGGLE-BOX
     SIZE 13.4 BY .81 NO-UNDO.

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
     cteventos AT ROW 2.91 COL 39 COLON-ALIGNED WIDGET-ID 80
     ctanal AT ROW 3.95 COL 39 COLON-ALIGNED
     cnecesarios AT ROW 4.1 COL 11 COLON-ALIGNED WIDGET-ID 66
     ctasig AT ROW 5.29 COL 39 COLON-ALIGNED
     b-nasig-2 AT ROW 5.29 COL 56 WIDGET-ID 52
     fdesbrec AT ROW 5.52 COL 3 WIDGET-ID 68
     ctnasig AT ROW 6.24 COL 39 COLON-ALIGNED
     b-nasig AT ROW 6.33 COL 56 WIDGET-ID 50
     faddoper AT ROW 6.48 COL 3 WIDGET-ID 70
     tbloques AT ROW 7.43 COL 3 WIDGET-ID 78
     Bcapac AT ROW 7.67 COL 25
     Bagenda_recurso AT ROW 7.67 COL 41 WIDGET-ID 4
     BUTTON-2 AT ROW 8.86 COL 25
     Beventos AT ROW 8.86 COL 41 WIDGET-ID 6
     v-mes AT ROW 9.86 COL 83.8 COLON-ALIGNED
     v-ano AT ROW 9.86 COL 91.8 COLON-ALIGNED
     BUTTON-8 AT ROW 10.05 COL 25 WIDGET-ID 54
     brecursos AT ROW 10.05 COL 41 WIDGET-ID 16
     ultdia AT ROW 11.29 COL 92.8 COLON-ALIGNED WIDGET-ID 76
     pridia AT ROW 11.33 COL 74.4 COLON-ALIGNED WIDGET-ID 74
     BUTTON-7 AT ROW 11.71 COL 2 WIDGET-ID 22
     BUTTON-6 AT ROW 11.71 COL 23 WIDGET-ID 20
     BUTTON-5 AT ROW 11.71 COL 44 WIDGET-ID 18
     Bvalor AT ROW 12.91 COL 74
     Bborraultimo AT ROW 12.91 COL 94 WIDGET-ID 56
     "Iniciar" VIEW-AS TEXT
          SIZE 14 BY .62 AT ROW 3.38 COL 67 WIDGET-ID 24
     "Asignacion" VIEW-AS TEXT
          SIZE 13 BY .62 AT ROW 8.14 COL 67 WIDGET-ID 32
     "Valorizando" VIEW-AS TEXT
          SIZE 13 BY .62 AT ROW 5.76 COL 67 WIDGET-ID 28
     "Analizando" VIEW-AS TEXT
          SIZE 13 BY .62 AT ROW 4.57 COL 67 WIDGET-ID 26
     "Actualiza" VIEW-AS TEXT
          SIZE 14 BY .62 AT ROW 2.43 COL 67 WIDGET-ID 72
     "Ordenando" VIEW-AS TEXT
          SIZE 13 BY .62 AT ROW 6.95 COL 67 WIDGET-ID 30
     RECT-1 AT ROW 1.48 COL 64
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
         HEIGHT             = 14.29
         WIDTH              = 122.2
         MAX-HEIGHT         = 17.29
         MAX-WIDTH          = 122.2
         VIRTUAL-HEIGHT     = 17.29
         VIRTUAL-WIDTH      = 122.2
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
       ctanal:READ-ONLY IN FRAME DEFAULT-FRAME        = TRUE.

ASSIGN 
       ctasig:READ-ONLY IN FRAME DEFAULT-FRAME        = TRUE.

ASSIGN 
       cteventos:READ-ONLY IN FRAME DEFAULT-FRAME        = TRUE.

ASSIGN 
       ctnasig:READ-ONLY IN FRAME DEFAULT-FRAME        = TRUE.

ASSIGN 
       dsc_tipo_evento:READ-ONLY IN FRAME DEFAULT-FRAME        = TRUE.

/* SETTINGS FOR COMBO-BOX v-origen IN FRAME DEFAULT-FRAME
   ALIGN-L                                                              */
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

CREATE CONTROL-FRAME ProgressBar-6 ASSIGN
       FRAME           = FRAME DEFAULT-FRAME:HANDLE
       ROW             = 2.19
       COLUMN          = 82
       HEIGHT          = .95
       WIDTH           = 35
       WIDGET-ID       = 44
       HIDDEN          = no
       SENSITIVE       = yes.

CREATE CONTROL-FRAME ProgressBar-1 ASSIGN
       FRAME           = FRAME DEFAULT-FRAME:HANDLE
       ROW             = 3.38
       COLUMN          = 82
       HEIGHT          = .95
       WIDTH           = 35
       WIDGET-ID       = 10
       HIDDEN          = no
       SENSITIVE       = yes.

CREATE CONTROL-FRAME ProgressBar-2 ASSIGN
       FRAME           = FRAME DEFAULT-FRAME:HANDLE
       ROW             = 4.57
       COLUMN          = 82
       HEIGHT          = .95
       WIDTH           = 35
       WIDGET-ID       = 34
       HIDDEN          = no
       SENSITIVE       = yes.

CREATE CONTROL-FRAME ProgressBar-3 ASSIGN
       FRAME           = FRAME DEFAULT-FRAME:HANDLE
       ROW             = 5.76
       COLUMN          = 82
       HEIGHT          = .95
       WIDTH           = 35
       WIDGET-ID       = 36
       HIDDEN          = no
       SENSITIVE       = yes.

CREATE CONTROL-FRAME ProgressBar-4 ASSIGN
       FRAME           = FRAME DEFAULT-FRAME:HANDLE
       ROW             = 6.95
       COLUMN          = 82
       HEIGHT          = .95
       WIDTH           = 35
       WIDGET-ID       = 38
       HIDDEN          = no
       SENSITIVE       = yes.

CREATE CONTROL-FRAME ProgressBar-5 ASSIGN
       FRAME           = FRAME DEFAULT-FRAME:HANDLE
       ROW             = 8.14
       COLUMN          = 82
       HEIGHT          = .95
       WIDTH           = 35
       WIDGET-ID       = 40
       HIDDEN          = no
       SENSITIVE       = yes.
/* ProgressBar-6 OCXINFO:CREATE-CONTROL from: {35053A22-8589-11D1-B16A-00C0F0283628} type: ProgressBar */
/* ProgressBar-1 OCXINFO:CREATE-CONTROL from: {35053A22-8589-11D1-B16A-00C0F0283628} type: ProgressBar */
/* ProgressBar-2 OCXINFO:CREATE-CONTROL from: {35053A22-8589-11D1-B16A-00C0F0283628} type: ProgressBar */
/* ProgressBar-3 OCXINFO:CREATE-CONTROL from: {35053A22-8589-11D1-B16A-00C0F0283628} type: ProgressBar */
/* ProgressBar-4 OCXINFO:CREATE-CONTROL from: {35053A22-8589-11D1-B16A-00C0F0283628} type: ProgressBar */
/* ProgressBar-5 OCXINFO:CREATE-CONTROL from: {35053A22-8589-11D1-B16A-00C0F0283628} type: ProgressBar */
      ProgressBar-6:MOVE-AFTER(dsc_tipo_evento:HANDLE IN FRAME DEFAULT-FRAME).
      ProgressBar-1:MOVE-AFTER(cteventos:HANDLE IN FRAME DEFAULT-FRAME).
      ProgressBar-2:MOVE-AFTER(cnecesarios:HANDLE IN FRAME DEFAULT-FRAME).
      ProgressBar-3:MOVE-AFTER(fdesbrec:HANDLE IN FRAME DEFAULT-FRAME).
      ProgressBar-4:MOVE-AFTER(faddoper:HANDLE IN FRAME DEFAULT-FRAME).
      ProgressBar-5:MOVE-AFTER(Bagenda_recurso:HANDLE IN FRAME DEFAULT-FRAME).

&ENDIF

&ANALYZE-RESUME /* End of _CREATE-DYNAMIC */


/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME C-Win
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON END-ERROR OF C-Win /* Asignacion de Recursos */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
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
  IF NOT valid-handle(h_naseventos) THEN DO:
      RUN w-evento.w PERSISTENT SET h_naseventos ( FALSE , v-origen , c_nro_tipo_evento , v-mes , v-ano ).
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
  IF NOT valid-handle(h_aseventos) THEN DO:
      RUN w-evento.w PERSISTENT SET h_aseventos ( TRUE , v-origen , c_nro_tipo_evento , v-mes , v-ano ).
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
  DEFINE VAR precursos AS CHAR NO-UNDO.

  IF NOT valid-handle(h_agenda_recursos) THEN DO:
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
    DEFINE VAR preg AS LOGICAL NO-UNDO.
   DEFINE VAR LAST_plan AS INT NO-UNDO.
   ASSIGN v-origen c_nro_tipo_evento.

   chProgressBar-6:ProgressBar:MIN = 0. 
   chProgressBar-6:ProgressBar:max = 2. 
   chProgressBar-6:ProgressBar:VALUE = 0. 
   RUN getparametro_n.p("PLASIG", OUTPUT LAST_plan ).
   LAST_plan = LAST_plan - 1.
  MESSAGE "Se eliminaran los evento NO realizados y NO avisados y NO Bloqueados" SKIP
      "del plan " LAST_plan VIEW-AS ALERT-BOX INFORMATION BUTTONS OK-CANCEL UPDATE preg.
   IF NOT preg THEN RETURN NO-APPLY.
  FOR EACH evento WHERE nro_planasignar = LAST_plan AND NOT avisado AND NOT realizado AND NOT bloqueado AND
      evento.nro_tipo_evento = c_nro_tipo_evento AND evento.origen = v-origen :
    FOR EACH recurso_agenda WHERE recurso_agenda.nro_evento = evento.nro_evento:
        DELETE recurso_agenda. 
    END.
    FOR each bevento WHERE bevento.rEFevento = evento.nro_evento:
        FOR EACH recurso_agenda WHERE recurso_agenda.nro_evento = bevento.nro_evento:
            DELETE recurso_agenda. 
        END.
        DELETE bevento.
    END.
    DELETE evento.
  END.
  FIND Parametro WHERE Parametro.cdg_empresa   = Empresa.cdg_empresa
                 AND Parametro.cdg_parametro = "PLASIG" 
                 no-lock NO-ERROR.
  IF NOT available parametro THEN DO:
        CREATE parametro.
        ASSIGN Parametro.cdg_parametro = "PLASIG" 
               Parametro.cdg_empresa   = Empresa.cdg_empresa.
  END.
  FIND CURRENT parametro EXCLUSIVE-LOCK.
  ASSIGN
        Parametro.valor_n       = LAST_plan
        Parametro.observacion   = STRING(NOW).
  RELEASE parametro.
  bborraultimo:LABEL = "Borra Plan " +  string(LAST_plan - 1).

  FIND FIRST evento WHERE evento.nro_planasig = nplan - 1 NO-ERROR.
  
  v-mes:SCREEN-VALUE IN FRAME {&FRAME-NAME} = IF AVAILABLE evento THEN string(month(evento.fmin)) ELSE string(MONTH(TODAY)).
  v-ano:SCREEN-VALUE IN FRAME {&FRAME-NAME} = IF AVAILABLE evento THEN string(YEAR(evento.fmin)) ELSE string(YEAR(TODAY)).

   chProgressBar-6:ProgressBar:VALUE = 2. 
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME Bcapac
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Bcapac C-Win
ON CHOOSE OF Bcapac IN FRAME DEFAULT-FRAME /* Capacidades */
DO:
  IF NOT valid-handle(h_capac) THEN DO:
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
    IF NOT valid-handle(h_eventos) THEN DO:
      RUN w-evento.w PERSISTENT SET h_eventos ( ? , v-origen , c_nro_tipo_evento , v-mes , v-ano ).
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
        IF NOT valid-handle(h_recursos) THEN DO:
          RUN w-recursos.w  PERSISTENT SET h_recursos.
          RUN dispatch IN h_recursos ( INPUT 'initialize':U ) .
        END.
          ELSE DYNAMIC-FUNCTION("tope" IN h_recursos ). 
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME BUTTON-2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL BUTTON-2 C-Win
ON CHOOSE OF BUTTON-2 IN FRAME DEFAULT-FRAME /* Restricciones */
DO:
    IF NOT valid-handle(h_restriccion) THEN DO:
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
    IF NOT valid-handle(h_analizado) THEN DO:
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
    IF NOT valid-handle(h_rvalor) THEN DO:  
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
    IF NOT valid-handle(h_balanceo) THEN DO:  
      RUN w-balanceo.w PERSISTENT SET h_balanceo ( INPUT TABLE balanceo ).
      RUN dispatch IN h_balanceo ( INPUT 'initialize':U ) .
    END.
        ELSE DYNAMIC-FUNCTION("tope" IN h_balanceo ). 
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME BUTTON-8
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL BUTTON-8 C-Win
ON CHOOSE OF BUTTON-8 IN FRAME DEFAULT-FRAME /* Consorcios */
DO:
  IF NOT valid-handle(h_consorcios) THEN DO:  
      RUN w-consorcios.w  PERSISTENT SET h_consorcios.
      RUN dispatch IN h_consorcios ( INPUT 'initialize':U ) .
  END.
    ELSE DYNAMIC-FUNCTION("tope" IN h_consorcios ). 
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME Bvalor
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Bvalor C-Win
ON CHOOSE OF Bvalor IN FRAME DEFAULT-FRAME /* Ejecutar */
DO :
 /*Asigna los eventos a los recursos en funcion de sus capacidades y disponibilidades*/

 DEFINE VAR i AS INT NO-UNDO.
 DEFINE VAR ii AS INT NO-UNDO.
 DEFINE VAR jj AS INT NO-UNDO.
 def var gg as int no-undo.
 DEFINE VAR v AS DECIMAL NO-UNDO.
 DEFINE VAR cc1 AS INT NO-UNDO.
 DEFINE VAR num-eventos AS INT NO-UNDO.
 DEFINE VAR num-analizado AS INT NO-UNDO.
 DEF VAR lista AS CHAR NO-UNDO.
 DEFINE VAR prioricomb AS INT NO-UNDO.
 DEF BUFFER bevento FOR evento.
 DEF BUFFER baevento FOR evento.
 DEFINE VAR imd AS LOGICAL NO-UNDO.
 DEFINE VAR opt AS LOGICAL NO-UNDO.
 DEFINE VAR posicind AS INT NO-UNDO.
 DEFINE QUERY qaanal FOR aanalizar.
 DEFINE VAR retasig AS CHAR NO-UNDO.


 corrida = 1.
 posicind = 0.
 imd = SESSION:IMMEDIATE-DISPLAY.
 chProgressBar-1:ProgressBar:MIN = 0.    
 chProgressBar-2:ProgressBar:MIN = 0.
 chProgressBar-3:ProgressBar:MIN = 0.
 chProgressBar-4:ProgressBar:MIN = 0.
 chProgressBar-5:ProgressBar:MIN = 0.
 chProgressBar-1:ProgressBar:max = 2.    
 chProgressBar-2:ProgressBar:max = 2.
 chProgressBar-3:ProgressBar:max = 2.
 chProgressBar-4:ProgressBar:max = 2.
 chProgressBar-5:ProgressBar:max = 2.
 chProgressBar-1:ProgressBar:value = 0.    
 chProgressBar-2:ProgressBar:value = 0.
 chProgressBar-3:ProgressBar:value = 0.
 chProgressBar-4:ProgressBar:value = 0.
 chProgressBar-5:ProgressBar:value = 0.
  cnecesarios = 0.
  cdisponibles = 0.
ASSIGN v-mes v-ano c_nro_tipo_evento v-origen pridia ultdia.

IF pridia = ? AND ultdia = ? THEN DO:
    pridia = DATE(v-mes,1,v-ano).
    ultdia = pridia + 32.
    ultdia = DATE(MONTH(ultdia),1,YEAR(ultdia)) - 1.
    IF pridia < TODAY + 2 THEN
         pridia = TODAY + 2.
     DISPLAY pridia ultdia WITH FRAME {&FRAME-NAME}.
 END.
 MESSAGE "Confirma el rango de fechas" SKIP "del " pridia " al " ultdia VIEW-AS ALERT-BOX QUESTION  BUTTONS YES-NO TITLE "Confirme" SET opt. 
 IF NOT opt THEN RETURN NO-APPLY.
 FIND tipo_evento WHERE tipo_evento.nro_tipo_evento = c_nro_tipo_evento NO-LOCK NO-ERROR.
 IF NOT AVAILABLE tipo_evento THEN DO:
     RUN ponmensj.p("OPR0009").
     RETURN NO-APPLY.
 END.
 
 SESSION:IMMEDIATE-DISPLAY = TRUE.

 RUN carga_eventos_periodo.

 IF ERROR-STATUS:error THEN 
    RETURN NO-APPLY.
 num-eventos = 0.

 /*Comienzo de la ejecucion*/
 FOR EACH evento WHERE 
     evento.origen = v-origen AND
     evento.realizado = FALSE AND 
     evento.asignado = FALSE AND 
     evento.nro_tipo_evento = tipo_evento.nro_tipo_evento AND
     evento.evaluar = TRUE AND
     NOT evento.anulado AND
     evento.fmax >= pridia AND
     evento.fmin <= ultdia NO-LOCK:
          num-eventos = num-eventos + 1.
          i = IF NUM-ENTRIES( evento.recursos ) <> 0 THEN NUM-ENTRIES( evento.recursos ) ELSE 1.
          cnecesarios = cnecesarios + i * evento.duracion.
 END.
 
 cteventos = num-eventos.
 DISPLAY cteventos WITH FRAME {&FRAME-NAME}.
 chProgressBar-1:ProgressBar:value = 2.     
 
 EMPTY TEMP-TABLE rvalor.
 EMPTY TEMP-TABLE analizado.
 EMPTY TEMP-TABLE balanceo. /*tabla con los recursos disponibles a ser asignados a los eventos por cada dia de analisis*/

 FOR EACH recurso_capacidad WHERE recurso_capacidad.fecha >= pridia AND recurso_capacidad.fecha <= ultdia:
       FIND recurso OF recurso_capacidad NO-LOCK NO-ERROR.
       IF AVAILABLE recurso THEN DO:
           FIND feriado WHERE feriado.fecha = recurso_capacidad.fecha NO-LOCK NO-ERROR.
           IF AVAILABLE feriado THEN NEXT.
           cdisponibles = cdisponibles +  recurso_capacidad.capacidad.
           FIND balanceo WHERE balanceo.cdg_recurso = recurso_capacidad.cdg_recurso NO-ERROR.
           IF NOT AVAILABLE balanceo THEN DO:
                CREATE balanceo.
                ASSIGN balanceo.cdg_recurso = recurso_capacidad.cdg_recurso
                       balanceo.turno = recurso.turno.
           END.
           FIND recurso_habilidad WHERE recurso_habilidad.cdg_recurso = recurso_capacidad.cdg_recurso AND
                                        recurso_habilidad.nro_tipo_evento = tipo_evento.nro_tipo_evento NO-LOCK NO-ERROR.
           ASSIGN balanceo.prioridad = IF AVAILABLE recurso_habilidad THEN recurso_habilidad.prioridad ELSE 0.
                  balanceo.disponible = balanceo.disponible + recurso_capacidad.capacidad.
     
           FOR EACH recurso_agenda WHERE recurso_agenda.cdg_recurso = recurso_capacidad.cdg_recurso AND
               recurso_agenda.fecha >= pridia AND recurso_agenda.fecha <= ultdia NO-LOCK:
               FIND bevento WHERE bevento.nro_evento = recurso_agenda.nro_evento NO-ERROR.
               IF AVAILABLE bevento THEN
                 ASSIGN balanceo.utilizacion = balanceo.utilizacion + bevento.duracion
                        cdisponibles = cdisponibles - bevento.duracion .
           END. 
       END.
 END.
 DISPLAY cdisponibles cnecesarios WITH FRAME {&FRAME-NAME}.

/*******************************************************************/
/*Analisis*/

 /* En este paso se crea la tabla analizado con todos los eventos restrictores a
  ser agendados a cada analizado se le asigna el restrictor o a si mismo, si tiene un padre,
  tiene como duracion contendra la suma de todos sus hijos Se genera la tabla de
  rvalor para cada analizado con los dias a ser evaluados y en ella se determinara
  la satisfaccion */
 /*una vez eveluado un evento , si pertenece a una identificacion que tiene sub-eventos de nivel superior se le suma 1
 al valor obtenido ese dia, mejorando la satisfaccion, ya que se ubicara primero ese evento(o bloque ) y a posterior el evento(bloque) que tenga sub-evento*/
 chProgressBar-2:ProgressBar:MAX = IF num-eventos > 1 THEN num-eventos ELSE 2.
 cc1 = 0.
 num-analizado = 0.
 FOR EACH evento WHERE 
     evento.realizado = FALSE AND
     evento.asignado = FALSE AND
     evento.nro_tipo_evento = tipo_evento.nro_tipo_evento AND
     evento.evaluar AND 
     NOT evento.anulado AND
     evento.fmax >= pridia AND
     evento.fmin <= ultdia:
     IF cc1 MOD 20 = 0 THEN chProgressBar-2:ProgressBar:value = cc1.
       cc1 = cc1 + 1.

     IF evento.nro_evento_padre = 0 OR evento.nro_evento_padre = evento.nro_evento THEN
         FIND bevento WHERE ROWID(bevento) = ROWID(evento). /*restrictor de si mismo*/
     ELSE DO:
         FIND bevento WHERE bevento.nro_evento = evento.nro_evento_padre AND
              bevento.asignado = FALSE AND bevento.nro_tipo_evento = evento.nro_tipo_evento AND bevento.evaluar AND NOT bevento.anulado AND bevento.fmax >= pridia AND bevento.fmin <= ultdia NO-LOCK NO-ERROR.
         IF NOT AVAILABLE bevento THEN do: 
             evento.nro_evento_padre = evento.nro_evento. /*se corrige el restrictor ya que el evento padre no existe o esta signado*/
             FIND bevento WHERE ROWID(bevento) = ROWID(evento).
         END.
     END. /*bevento tiene el restrictor a ser analizado*/

     /*se crea analizado y rvalor */
     FIND analizado where analizado.nro_evento = bevento.nro_evento NO-ERROR.
     IF NOT AVAILABLE analizado THEN do:
                              
          CREATE analizado. 
          ASSIGN analizado.nro_evento = bevento.nro_evento
                 analizado.muestras = 0
                 analizado.sumas = 0
                 analizado.recursos = bevento.recursos
                 analizado.evsigue = bevento.evsigue.
                 num-analizado = num-analizado + 1.
           FOR LAST baevento WHERE baevento.origen = bevento.origen AND
                              baevento.asignado AND
                              baevento.fmax < bevento.fmin AND
                              baevento.nro_identificacion = bevento.nro_identificacion AND
                              baevento.sub_evento = bevento.sub_evento NO-LOCK:
               analizado.antasig = baevento.fasignado.
           END.

           ii = IF bevento.fmin <= pridia THEN day(pridia) ELSE day(bevento.fmin). /*todo lo no realizado con anterioridad se intentara ubicar*/
           jj = IF bevento.fmax <= ultdia THEN day( bevento.fmax ) else day(ultdia) .
                 
           DO i = ii TO jj: /*creo rvalor con el rango de dias determinado por el padre*/
             FIND feriado WHERE feriado.fecha = DATE(v-mes , i , v-ano ) NO-LOCK NO-ERROR.
             IF AVAILABLE feriado THEN NEXT.
             CREATE rvalor.
             ASSIGN rvalor.fecha = DATE(v-mes,i,v-ano)
                    rvalor.nro_evento = bevento.nro_evento.
          END.
     END.
     ASSIGN analizado.duracion = analizado.duracion + evento.duracion 
            analizado.hduracion = analizado.hduracion + evento.duracion * NUM-ENTRIES(evento.recursos)
            analizado.agrupado = IF analizado.agrupado = "" THEN STRING(evento.nro_evento) ELSE analizado.agrupado + "," + STRING(evento.nro_evento).
            
 END.
 ctanal = num-analizado.
 DISPLAY ctanal WITH FRAME {&FRAME-NAME}.
 chProgressBar-2:ProgressBar:value = chProgressBar-2:ProgressBar:max.   

/*calculo de los encadenados, al ser encadenado suma  tantos puntos como encadenados tenga lo que le mejora la competencia contra otro mas simple*/
chProgressBar-2:ProgressBar:MAX = IF num-analizado > 1 THEN num-analizado ELSE 2.
cc1 = 0.
FOR each analizado use-index idx2:
        assign analizado.encadenado = calcula_encadenado ( analizado.agrupado ) 
               analizado.sumas = analizado.sumas + analizado.encadenado
               cc1 = cc1 + 1
               chProgressBar-2:ProgressBar:value = cc1.

END.
chProgressBar-2:ProgressBar:value = chProgressBar-2:ProgressBar:max.

/*******************************************************************/

 /*segun el origen del tipo de evento se llama a un programa especializado en ese origen
 que llenara la tabla de analizado pasada como parametro 
 Tambien se pasa la tabla se pasa la tabla rvalor que volvera con los valores de las satisfacciones de ese dia
 */

chProgressBar-3:ProgressBar:MAX = IF num-analizado > 1 THEN num-analizado ELSE 2.
RUN VALUE(trim(tipo_evento.origen) + "-opr.p" ) ( INPUT-OUTPUT TABLE analizado, INPUT-OUTPUT TABLE rvalor, input this-procedure, ? ).
chProgressBar-3:ProgressBar:value = chProgressBar-3:ProgressBar:max.


/*******************************************************************/
/*Ordenamiento y asignacion*/

/*aca se fija el orden en la evaluacion*/
     cc1 = 0.  
     chProgressBar-4:ProgressBar:MAX = IF num-analizado > 1 THEN num-analizado ELSE 2.
     empty temp-table aanalizar.
     for EACH analizado USE-INDEX idx1 , evento OF analizado  where not evento.asignado :
         find evento of analizado.
         IF evento.sub_evento > 1 OR evento.evsigue <> 0 THEN next. /*no intengar analizar los eventos con subeventos o los que estan encadenados ya que se realizan porteriormente al principal*/
         create aanalizar.
         assign   posicind = posicind + 1
                  aanalizar.ind = posicind.
                  IF posicind  > chProgressBar-4:ProgressBar:MAX THEN chProgressBar-4:ProgressBar:MAX = posicind.
                  chProgressBar-4:ProgressBar:VALUE = posicind.
         ASSIGN   aanalizar.nro_evento = evento.nro_evento
                  analizado.ind = aanalizar.ind
                  analizado.heredado = "D".
     END.
/*aca se asignan los eventos*/
    EMPTY TEMP-TABLE dproh. /*borra los dias prohibidos*/
    DO corrida = 1 TO 2:

     DO WHILE dgeomax <= dgeomaxmax:
         OPEN QUERY qaanal FOR EACH aanalizar WHERE aanalizar.ind <> 0 by aanalizar.ind.
         GET FIRST qaanal.
         DO WHILE AVAILABLE aanalizar:
                chProgressBar-4:ProgressBar:VALUE = aanalizar.ind.

                retasig = asignar_evento(aanalizar.nro_evento, TRUE,aanalizar.ind).
                IF retasig = "R" THEN do:
                   
                    IF prohibir(aanalizar.nro_evento) THEN DO:
                        desasignar(aanalizar.nro_evento).
                        NEXT. /*asignara recursivamente los eventos que dependan de este*/
                    END.
                END.
                GET NEXT qaanal.
         END.
         dgeomax = dgeomax + dgeoinc.
     END.
    END.
    chProgressBar-4:ProgressBar:VALUE = chProgressBar-4:ProgressBar:MAX.

/*******************************************************************/
/*entrega final y resultados*/

 chProgressBar-5:ProgressBar:MAX = IF num-analizado > 1 THEN num-analizado ELSE 2.
 chProgressBar-5:ProgressBar:value = chProgressBar-5:ProgressBar:max.  
 ctnasig = 0.
  FOR EACH evento WHERE
      evento.realizado = FALSE AND
       evento.asignado = FALSE AND
       evento.nro_tipo_evento = tipo_evento.nro_tipo_evento AND
       evento.evaluar AND 
       NOT evento.anulado AND 
       evento.fmax >= pridia AND
       evento.fmin <= ultdia:
      ctnasig = ctnasig + 1.
  END.
  ctasig = cteventos - ctnasig.
  DISPLAY ctnasig ctasig WITH FRAME {&FRAME-NAME}.
/*asignar avisos*/
  RUN asignar_avisos.
  SESSION:IMMEDIATE-DISPLAY = imd.
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
  SELF:INPUT-VALUE = DATE(self:SCREEN-VALUE IN FRAME {&FRAME-NAME}) NO-ERROR.
  IF SELF:INPUT-VALUE = ? THEN SELF:SCREEN-VALUE = string(TODAY).
  RUN d-calendario.w ( INPUT date(SELF:SCREEN-VALUE), OUTPUT fecha_elegida).
  IF fecha_elegida <> ?
  THEN DO:
       SELF:SCREEN-VALUE = string(fecha_elegida).
       APPLY "TAB" TO SELF.        
  END.               

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME ultdia
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL ultdia C-Win
ON MOUSE-MENU-DOWN OF ultdia IN FRAME DEFAULT-FRAME /* a */
DO:
    DEFINE VAR fecha_elegida AS DATE NO-UNDO.
  SELF:INPUT-VALUE = DATE(self:SCREEN-VALUE IN FRAME {&FRAME-NAME}) NO-ERROR.
  IF SELF:INPUT-VALUE = ? THEN SELF:SCREEN-VALUE = string(TODAY).
  RUN d-calendario.w ( INPUT date(SELF:SCREEN-VALUE), OUTPUT fecha_elegida).
  IF fecha_elegida <> ?
  THEN DO:
       SELF:SCREEN-VALUE = string(fecha_elegida).
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
     {levantacombo.i &TABLA=Tipo_evento &NOMBRE=cdg_tipo_evento &CODIGO=nro_tipo_evento &OBJETO=c_nro_tipo_evento}
  END.  
  /* Code placed here will execute AFTER standard behavior.    */

   FOR EACH evento NO-LOCK BREAK BY Evento.nro_planasignar DESC :
       nplan = nro_plan + 1.
       LEAVE.
   END.
   FIND parametro WHERE parametro.cdg_parametro = "PLASIG" AND
       parametro.cdg_empresa = empresa.cdg_empresa.
   ASSIGN parametro.valor_n = nplan.

   bborraultimo:LABEL IN FRAME {&FRAME-NAME}= "Borra Plan " + STRING(nplan - 1).
MAIN-BLOCK:
DO ON ERROR   UNDO MAIN-BLOCK, LEAVE MAIN-BLOCK
   ON END-KEY UNDO MAIN-BLOCK, LEAVE MAIN-BLOCK:
  RUN enable_UI.
/*  v-mes:SCREEN-VALUE IN FRAME {&FRAME-NAME} = STRING(MONTH(TODAY + 32),">9").
  v-ano:SCREEN-VALUE IN FRAME {&FRAME-NAME} = STRING(year(TODAY + 32),"9999").
  */
  FIND FIRST evento WHERE evento.nro_planasig = nplan - 1 NO-ERROR.
  
  v-mes:SCREEN-VALUE IN FRAME {&FRAME-NAME} = IF AVAILABLE evento THEN string(month(evento.fmin)) ELSE string(MONTH(TODAY)).
  v-ano:SCREEN-VALUE IN FRAME {&FRAME-NAME} = IF AVAILABLE evento THEN string(YEAR(evento.fmin)) ELSE string(YEAR(TODAY)).
  IF NOT THIS-PROCEDURE:PERSISTENT THEN
    WAIT-FOR CLOSE OF THIS-PROCEDURE.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


/* **********************  Internal Procedures  *********************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE asignar_avisos C-Win 
PROCEDURE asignar_avisos :
/*------------------------------------------------------------------------------
  Purpose: asigna los avisos de los eventos asignados   
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

/*evento realizado en el rango de fechas, distancia a cada uno de ellos */

DEFINE BUFFER bevento FOR evento.
DEFINE VAR vgeoX AS DECIMAL NO-UNDO.
DEFINE VAR vgeoY AS DECIMAL NO-UNDO.
DEFINE VAR i AS INT NO-UNDO.
DEFINE VAR fdisponible AS LOGICAL NO-UNDO.
DEFINE VAR maxdist AS INTEGER INITIAL 800 NO-UNDO. /*distancia maxima en metros*/
DEFINE VAR pasada AS INT NO-UNDO.
DEFINE VAR almenos AS LOGICAL NO-UNDO.
DEFINE VAR sinasig AS INT NO-UNDO.

FIND tipo_evento WHERE tipo_evento.cdg_tipo = "AV" NO-LOCK.

chProgressBar-5:ProgressBar:value = 0.

FOR EACH evento WHERE NOT evento.anulado AND NOT evento.realizado AND
     NOT evento.asignado AND evento.origen = tipo_evento.origen AND
     evento.origen = tipo_evento.origen:
 sinasig = sinasig + 1.
END.

chProgressBar-5:ProgressBar:MAX = IF sinasig < 1 THEN 2 ELSE sinasig.
sinasig = 0.
REPEAT pasada = 1 TO 10:
    almenos = FALSE.
    FOR EACH evento WHERE NOT evento.realizado AND
            NOT evento.asignado AND evento.origen = tipo_evento.origen AND
            evento.origen = tipo_evento.origen:
            FIND cliente OF evento NO-LOCK NO-ERROR.
            IF NOT AVAILABLE cliente THEN DO:
                MESSAGE "Error interno  no existe el cliente para evento:" evento.nro_evento VIEW-AS ALERT-BOX.
                NEXT.
            END.
            vgeoX = cliente.geoX.
            vgeoY = cliente.geoY.
            EMPTY TEMP-TABLE evearea.
            FOR EACH bevento WHERE bevento.asignado AND 
                        NOT bevento.realizado AND 
                        NOT bevento.anulado AND
                        bevento.fasignado >= evento.fmin AND
                        bevento.fasignado <= evento.fmax AND 
                        ROWID(bevento) <> ROWID(evento):
                FIND cliente OF bevento NO-LOCK NO-ERROR.
                IF NOT AVAILABLE cliente THEN DO:
                MESSAGE "Error interno  no existe el cliente para evento:" bevento.nro_evento VIEW-AS ALERT-BOX.
                NEXT.
            END.
                fdisponible = FALSE.
                DO i = 1 TO NUM-ENTRIES(bevento.recursos):
                    fdisponible = disponible(tipo_evento.nro_tipo_evento , bevento.recursos , bevento.fasignado , evento.duracion ).
                    IF fdisponible THEN LEAVE.
                END.
                IF fdisponible THEN DO:
                    /* calculando el area */
                    CREATE evearea.
                    evearea.turno = bevento.turno.
                    evearea.nro_evento = bevento.nro_evento.
                    evearea.recursos = ENTRY(i,bevento.recursos).
                    evearea.distancia = distGeodesicaUTM(cliente.geoX , cliente.geoY ,
                                       vgeoX,vgeoY).
                END.
            END.
            FOR FIRST evearea WHERE (evearea.distancia <= maxdist AND substring(evearea.turno,2,1) <> "1" ) AND
                   evearea.turno<> ""
                  BY evearea.distancia:
                FIND bevento WHERE bevento.nro_evento = evearea.nro_evento.
                evento.recursos = evearea.recursos.
                evento.asignado = TRUE .
                evento.fasignado = bevento.fasignado.
                evento.mobs = "Cercano EV:" + string(evearea.nro_evento) + "[" + string(evearea.distancia) + "]" .
                almenos = TRUE.
                                /*crea agenda de recurso*/
                CREATE recurso_agenda.
                ASSIGN recurso_agenda.cdg_recurso = evento.recursos
                      recurso_agenda.fecha = evento.fasignado
                      recurso_agenda.nro_evento = evento.nro_evento
                      sinasig = sinasig + 1
                      chProgressBar-5:ProgressBar:VALUE = sinasig
                      recurso_agenda.observacion = IF recurso_agenda.observacion <> "" THEN recurso_agenda.observacion + " " + evento.mobs ELSE evento.mobs.
            END.
    END.
    IF almenos = FALSE THEN LEAVE.
END.
chProgressBar-5:ProgressBar:VALUE = chProgressBar-5:ProgressBar:MAX.

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
  /*este proceso crea en funcion a los contratos a ser evaluados resuelve los bloques y la signacion forzada de recursos por restriccion*/
  DEFINE BUFFER extevento FOR evento.
  DEFINE BUFFER bevento FOR evento.
  DEF VAR i AS INT NO-UNDO.
  DEF VAR ddd AS DATE NO-UNDO.
  DEF VAR hhh AS DATE NO-UNDO.
  DEF VAR j AS DATE NO-UNDO.
  DEFINE VAR pridia AS DATE NO-UNDO.
  DEFINE VAR ultdia AS DATE NO-UNDO.
  DEFINE VAR ecreados AS INT NO-UNDO.
  DEFINE VAR OPRDDTA AS INT NO-UNDO.
  DEFINE VARIABLE v-transcurridos           AS INTEGER    NO-UNDO.
  DEFINE VARIABLE v-ciclo_facturacion       AS INTEGER    NO-UNDO.
  DEFINE VAR nplan AS INTEGER NO-UNDO.
  DEFINE VAR pperiodo AS INTEGER NO-UNDO.
   chProgressBar-6:ProgressBar:MIN = 0. 
   chProgressBar-6:ProgressBar:max = 2. 

   chProgressBar-6:ProgressBar:VALUE = 0. 
  ASSIGN FRAME {&FRAME-NAME} v-mes v-ano c_nro_tipo_evento.

   ASSIGN v-mes v-ano c_nro_tipo_evento v-origen.
 pperiodo = v-ano * 100 + v-mes.
 pridia = DATE(v-mes,1,v-ano).
 ultdia = pridia + 32.
 ultdia = DATE(MONTH(ultdia),1,YEAR(ultdia)) - 1.


FIND tipo_evento WHERE tipo_evento.nro_tipo_evento = c_nro_tipo_evento:INPUT-VALUE NO-ERROR.
IF NOT AVAILABLE tipo_evento THEN DO:
    MESSAGE "Debe elegir el tipo de evento a analizar"
        VIEW-AS ALERT-BOX INFO BUTTONS OK.
    RETURN ERROR.
END.

  j  = DATE(v-mes,1,v-ano).
  ddd = DATE(v-mes,1,v-ano).
  hhh = DATE( MONTH(ddd + 32 ), 1 , YEAR( ddd + 32 ) ) - 1 .
  RUN GETparametro_n.p ("PLASIG", OUTPUT nplan).
  nplan = nplan + 1.
  EMPTY TEMP-TABLE analizado.
  EMPTY TEMP-TABLE rvalor.
  ecreados = 0.  
  RUN getparametro_n.p ( "OPRDDTA" , OUTPUT OPRDDTA ).
  FOR EACH contrato_hd WHERE contrato_hd.rige_hasta >= ddd AND
      contrato_hd.rige_desde <= hhh AND
      ( contrato_hd.cant_periodos = 0 OR resto_periodos > 0 )
      AND contrato_hd.primer_ano * 100 + contrato_hd.primer_mes  <= pperiodo and 
      not Contrato_hd.anulado and  ( contrato_hd.fecha_baja = ? OR year(contrato_hd.fecha_baja) * 100 + MONTH(contrato_hd.fecha_baja) > pperiodo )
      ,FIRST cliente OF contrato_hd :
      IF contrato_hd.nro_tipo_evento <> c_nro_tipo_evento THEN NEXT.
      v-ciclo_facturacion = INTEGER(Contrato_hd.modo_facturacion).

      v-transcurridos = ( year(j) - Contrato_hd.primer_ano ) * 12 + 
                        ( month(j) - Contrato_hd.primer_mes ).

      IF v-transcurridos MOD v-ciclo_facturacion <> 0 THEN NEXT.
      FIND contrato_dt OF contrato_hd NO-ERROR.
      IF NOT AVAILABLE contrato_dt THEN NEXT.
      FIND articulo OF contrato_dt NO-ERROR.
      IF NOT AVAILABLE articulo THEN NEXT.
      /*carga eventos*/
      DO i = 1 TO contrato_hd.numero_eventos:
          find first contrato_restriccion where contrato_restriccion.nro_contrato = contrato_hd.nro_contrato and contrato_restriccion.sub_evento = i and contrato_restriccion.nro_restriccion = 16 no-lock no-error. 
          FIND FIRST evento WHERE
              evento.nro_tipo_evento = tipo_evento.nro_tipo_evento AND
              evento.nro_identificacion = contrato_hd.nro_contrato AND
              evento.sub_evento = i AND
              NOT evento.anulado AND
              NOT evento.realizado AND
              evento.periodo = pperiodo NO-ERROR.
          ecreados = ecreados + 1.
          IF AVAILABLE evento THEN NEXT.
          CREATE evento.
          Evento.nro_planasignar = nplan.
          evento.nro_cliente = contrato_hd.nro_cliente.
          ASSIGN
              evento.reminder = contrato_hd.reminder
              evento.dreminder = contrato_hd.dreminder
              Evento.Asignado = FALSE
              evento.origen = "CONTRATO"
              Evento.Duracion = IF available contrato_restriccion THEN int(contrato_restriccion.valor) ELSE OPRDDTA
              Evento.FAsignado = ?
              Evento.FCreado = TODAY
              evento.fmin = ddd
              evento.fmax = hhh
              Evento.nro_evento = NEXT-VALUE(proximo_evento)
              Evento.nro_evento_padre = 0
              Evento.nro_identificacion = contrato_hd.nro_contrato
              Evento.nro_tipo_evento = c_nro_tipo_evento 
              Evento.Recursos = ""
              evento.sub_evento = i
              evento.evaluar=true
              evento.periodo = pperiodo
              evento.leyenda = contrato_hd.leyenda
              evento.reminder = contrato_hd.reminder
              Evento.dreminder = contrato_hd.dreminder.
      END.
  END.
  IF ecreados = 0 THEN DO:
      RETURN .
  END.
  chProgressBar-6:ProgressBar:max = IF ecreados = 0 THEN 2 ELSE ecreados. 
/*generamos los bloques de eventos y la asignacion de recursos forzados por restricciones*/
  ecreados = 0.
  FOR EACH evento WHERE 
      evento.origen = v-origen AND
      evento.realizado = FALSE AND 
      evento.asignado = FALSE AND 
      evento.nro_tipo_evento = tipo_evento.nro_tipo_evento AND
      evento.evaluar = TRUE AND
       NOT evento.anulado AND
      evento.periodo = pperiodo:
      ecreados = ecreados + 1.
      chProgressBar-6:ProgressBar:VALUE = ecreados.
      /*BLOQUE*/
      FIND restriccion WHERE restriccion.evaluar and
                   Restriccion.nro_tipo_evento = evento.nro_tipo_evento AND CAN-DO("BLOQ*",Restriccion.cdg_restriccion) NO-ERROR.
      IF AVAILABLE restriccion AND tbloques:CHECKED THEN do:
          FIND contrato_restriccion WHERE contrato_restriccion.nro_contrato = evento.nro_identificacion AND
           contrato_restriccion.sub_evento = evento.sub_evento AND
           contrato_restriccion.nro_restriccion = restriccion.nro_restriccion NO-ERROR. 
          IF AVAILABLE contrato_restriccion THEN do:
               
               FIND bevento WHERE bevento.origen = evento.origen and
                             bevento.nro_identificacion = int(entry(1,contrato_restriccion.valor, "|")) and
                             bevento.sub_evento = int(entry(2,contrato_restriccion.valor, "|")) and
                             bevento.realizado = FALSE AND 
                             bevento.asignado = FALSE AND 
                             bevento.nro_tipo_evento = evento.nro_tipo_evento AND
                             bevento.evaluar = TRUE AND 
                             NOT bevento.anulado AND
                             bevento.periodo = pperiodo
                             NO-ERROR.
               IF AVAILABLE bevento THEN do:
                   evento.nro_evento_padre = bevento.nro_evento.
                   /*MESSAGE "BLOQUE" evento.nro_evento_padre  bevento.nro_evento VIEW-AS ALERT-BOX INFORMATION.*/
               END.
               else do:
                  /*  MESSAGE "BLOQUE" evento.nro_identificacion evento.sub_evento int(entry(1,contrato_restriccion.valor, "|")) int(entry(2,contrato_restriccion.valor, "|")) VIEW-AS ALERT-BOX INFORMATION.*/
               END.

          END.
      END.
      /*turnos*/
      FIND restriccion WHERE restriccion.evaluar AND Restriccion.nro_tipo_evento = evento.nro_tipo_evento AND Restriccion.cdg_restriccion BEGINS "TURNO" NO-ERROR .
      IF AVAILABLE restriccion THEN DO:
          FIND contrato_restriccion WHERE contrato_restriccion.nro_contrato = evento.nro_identificacion AND
               contrato_restriccion.sub_evento = evento.sub_evento AND contrato_restriccion.nro_restriccion = restriccion.nro_restriccion NO-LOCK NO-ERROR.
          IF AVAILABLE contrato_restriccion THEN do:
              evento.turno = ( IF entry(1,contrato_restriccion.valor,"|") = "" THEN "M" ELSE entry(1,contrato_restriccion.valor,"|")) + entry(2,contrato_restriccion.valor,"|").
          END.
          ELSE evento.turno = "M*".
      END.
      ELSE evento.turno = "M*".

      /*bloques virtuales*/
      FIND restriccion WHERE restriccion.evaluar AND Restriccion.nro_tipo_evento = evento.nro_tipo_evento AND Restriccion.cdg_restriccion BEGINS "dfEV" NO-ERROR.
       IF AVAILABLE restriccion  AND tbloques:CHECKED THEN DO:
           FIND contrato_restriccion WHERE contrato_restriccion.nro_contrato = evento.nro_identificacion AND
                contrato_restriccion.sub_evento = evento.sub_evento AND contrato_restriccion.nro_restriccion = restriccion.nro_restriccion NO-ERROR.
           IF AVAILABLE contrato_restriccion THEN do:
               FIND bevento WHERE bevento.nro_identificacion = int(ENTRY( 1 , contrato_restriccion.valor , "|" )) AND
                   bevento.sub_evento = int(ENTRY( 2 ,contrato_restriccion.valor,"|")) and
                   bevento.fmin = evento.fmin and
                   bevento.fmax = evento.fmax NO-LOCK NO-ERROR.
               IF AVAILABLE bevento THEN
                     evento.evsigue = bevento.nro_evento.
               ELSE 
                     evento.evsigue = 0.
           END.
       END.

      /*RECURSOS FORZADOS*/
      FIND restriccion WHERE restriccion.evaluar AND Restriccion.nro_tipo_evento = evento.nro_tipo_evento AND Restriccion.cdg_restriccion BEGINS "OPER" NO-ERROR.
      IF AVAILABLE restriccion THEN DO:
          FIND contrato_restriccion WHERE contrato_restriccion.nro_contrato = evento.nro_identificacion AND
               contrato_restriccion.sub_evento = evento.sub_evento AND contrato_restriccion.nro_restriccion = restriccion.nro_restriccion NO-ERROR.
          IF AVAILABLE contrato_restriccion THEN do:
              /*MESSAGE "OPER" evento.nro_evento VIEW-AS ALERT-BOX INFORMATION.*/
              evento.recursos = IF evento.recursos = "" THEN ( IF Restriccion.cdg_restriccion BEGINS "OPERF" THEN "#" ELSE "" ) + contrato_restriccion.valor ELSE evento.recursos.
          END.
      END.

      /*si hay eventos hijos asignados, reasignar el padre y todos ssus hijos, basado en el contrato no en los eventos*/
  END.
/*
  FIND restriccion WHERE CAN-DO("BLOQ*",Restriccion.cdg_restriccion).
  FOR EACH evento WHERE evento.periodo = pperiodo AND evento.origen = "CONTRATO" AND 
      NOT evento.anulado AND 
      evento.asignado:
      FIND contrato_restriccion WHERE contrato_restriccion.nro_contrato = evento.nro_evento and
          contrato_restriccion.sub_evento = evento.sub_evento AND
          contrato_restriccion.nro_restriccion = restriccion.nro_restriccion.
      DO i = 1 TO NUM-ENTRIES( contrato_restriccion.valor):
          FIND bevento WHERE bevento.periodo = evento.periodo AND
              bevento.nro_identificacion = int(entry(1,entry(i,contrato_restriccion.valor,"|"))) and
              bevento.sub_evento = int(entry(2,entry(i,contrato_restriccion.valor,"|"))) and
              rowid(bevento)  <> ROWID(evento).
          bevento.asignado = evento.asignado.
          bevento.mobs = ( IF bevento.mobs <> "" THEN bevento.mobs + " " ELSE "" ) + "APAREADOR EN CARGA".
      END.
  END.
  FOR EACH evento WHERE evento.periodo = pperiodo AND evento.origen = "CONTRATO" AND 
      NOT evento.anulado AND 
      evento.asignado:
      FIND contrato_restriccion WHERE can-do(string(evento.nro_identificacion) + "|" + string(evento.sub_evento) , contrato_restriccion.valor ) NO-ERROR.
      IF AVAILABLE contrato_restriccion THEN DO:
          FIND bevento WHERE bevento.periodo = evento.periodo AND
              bevento.nro_identificacion = contrato_restriccion.nro_contrato AND
              bevento.sub_evento = contrato_restriccion.sub_evento AND NOT bevento.anulado.
          bevento.asignado = evento.asignado.
          bevento.fasignado = evento.fasignado.
          evento.nro_evento_padre = evento.nro_evento.
          bevento.mobs = ( IF bevento.mobs <> "" THEN bevento.mobs + " " ELSE "" ) + "ADOPTADO".
      END.
  END.
*/
  FIND Parametro WHERE Parametro.cdg_empresa   = Empresa.cdg_empresa
                   AND Parametro.cdg_parametro = "PLASIG" 
                       EXCLUSIVE-LOCK NO-ERROR.
  IF NOT available parametro THEN DO:
      CREATE parametro.
      ASSIGN Parametro.cdg_parametro = "PLASIG" 
             Parametro.cdg_empresa   = Empresa.cdg_empresa.
  END.
  ASSIGN
      Parametro.valor_n       = nplan
      Parametro.observacion   = STRING(NOW).

  bborraultimo:LABEL = "Borra Plan " +  string(nplan - 1).
  chProgressBar-6:ProgressBar:VALUE = chProgressBar-6:ProgressBar:max.

END PROCEDURE.

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
          ctanal cnecesarios ctasig fdesbrec ctnasig faddoper tbloques v-mes 
          v-ano ultdia pridia 
      WITH FRAME DEFAULT-FRAME IN WINDOW C-Win.
  ENABLE RECT-1 v-origen c_nro_tipo_evento dsc_tipo_evento cdisponibles 
         cteventos ctanal cnecesarios ctasig b-nasig-2 fdesbrec ctnasig b-nasig 
         faddoper tbloques Bcapac Bagenda_recurso BUTTON-2 Beventos v-mes v-ano 
         BUTTON-8 brecursos ultdia pridia BUTTON-7 BUTTON-6 BUTTON-5 Bvalor 
         Bborraultimo 
      WITH FRAME DEFAULT-FRAME IN WINDOW C-Win.
  {&OPEN-BROWSERS-IN-QUERY-DEFAULT-FRAME}
  VIEW C-Win.
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
define input parameter vv as int no-undo.
IF vv <= chProgressBar-3:ProgressBar:max THEN
        chProgressBar-3:ProgressBar:value = vv.
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
        FIND bcontrato_restriccion WHERE contrato_restriccion.nro_contrato = bcontrato_restriccion.nro_contrato and
            contrato_restriccion.sub_evento = bcontrato_restriccion.sub_evento and
            bcontrato_restriccion.nro_restriccion = 1 NO-ERROR.       
        IF NOT AVAILABLE bcontrato_restriccion THEN NEXT.
        R = bcontrato_restriccion.valor. /*valor del recurso en el hijo*/
        FIND ccontrato_restriccion WHERE ccontrato_restriccion.nro_contrato = int(entry(1,contrato_restriccion.valor,"|")) AND
             ccontrato_restriccion.sub_evento = int(entry(2,contrato_restriccion.valor,"|")) AND
             ccontrato_restriccion.nro_restriccion = 1 NO-ERROR. /*recursos del padre*/  
        IF NOT AVAILABLE ccontrato_restriccion THEN do: 
            MESSAGE "ERROR PADRE INEXISTENTE " contrato_restriccion.valor VIEW-AS ALERT-BOX.
            NEXT.
        END.
        IF ccontrato_restriccion.valor <> r THEN
            MESSAGE "Recursos diferentes en el hijo " + string(bcontrato_restriccion.nro_contrato) + "|" + string(bcontrato_restriccion.sub_evento) + " con el padre " + contrato_restriccion.valor VIEW-AS ALERT-BOX.
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
define buffer buevento for evento.
DEF VAR durac AS INT NO-UNDO.
    durac = 0.
    FOR each recurso_agenda WHERE recurso_agenda.cdg_recurso = pcodigo
          AND recurso_agenda.fecha = pfecha ,
          each buevento WHERE buevento.nro_evento = recurso_agenda.nro_evento AND
               NOT buevento.anulado AND
               buevento.asignado AND
               buevento.evaluar AND
               buevento.nro_tipo_evento = p-nro_tipo_evento :
             durac = durac + buevento.duracion.
    END.
RETURN durac.   /* Function return value. */

END FUNCTION.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION asignar_evento C-Win 
FUNCTION asignar_evento RETURNS CHARACTER
  ( pnro_evento as integer , analizar_compatibilidad AS LOGICAL ,pind AS INT) :
/*------------------------------------------------------------------------------
  Purpose: asigna el evento y a todos los que estan encadenados, al asignar un padre confirma las agenda de todos los hijos.
           
  Notes: geocod habilita la geocodificacion, en la compatibilidad
         el pind indica el orden del analisis dentro del nro_plan
------------------------------------------------------------------------------*/
DEF VAR flg AS LOGICAL NO-UNDO.
def var ppadre as integer no-undo.   
def var i as integer no-undo.
def var res as logical no-undo.
def var pagrupados as character no-undo.
def var arecursos as char no-undo.
DEF VAR pevsigue AS INT NO-UNDO.
def buffer bevento for evento.
DEF BUFFER banalizado FOR analizado.
DEF VAR urec AS INT NO-UNDO.

find evento where evento.nro_evento = pnro_evento .
IF evento.asignado THEN RETURN "P".

find analizado where analizado.nro_evento = pnro_evento NO-ERROR.
IF NOT AVAILABLE analizado THEN  return "I". /*solo padres*/
IF analizado.ind <> pind THEN
    ASSIGN analizado.ind = pind
           analizado.heredado = "H".


ppadre = IF evento.nro_evento_padre = 0 THEN evento.nro_evento else evento.nro_evento_padre.
IF ppadre <> pnro_evento THEN do:                                                   
     message "Se ha realizado un bloque de bloques ,operacion no permitida" skip
             "detectado con el evento cuyo restrictor es el eventoIidentificacion es  " pnro_evento " " evento.nro_identificacion SKIP
             "y que a su vez tiene como padre el " ppadre SKIP
             "Elimine el problema y ejecute nuevamente"
             view-as alert-box error. 
     return "E".                                                                   
end.

arecursos=analizado.recursos.
pevsigue=analizado.evsigue.
pagrupados = analizado.agrupados.

IF NOT evento.asignado THEN do:
    IF substring(arecursos,1,1) = "#" THEN DO: /*mandatorio ubicar esos recursos*/
        IF not ubicar_recurso( substring(arecursos,2) , pnro_evento, "", 0 , analizar_compatibilidad ) THEN DO:
            IF fdesbrec THEN DO:
                    urec = ubicar_N_recurso( pnro_evento,  num-entries(arecursos), "CFOPER[ " + substring(arecursos , 2 ) + "]", 0 , analizar_compatibilidad ).
                    IF  urec <> 0 AND urec = 1 THEN DO:
                        IF faddoper THEN DO:
                            urec = ubicar_N_recurso( pnro_evento,  num-entries(arecursos) + 1, "ADD1OPER[ " + substring( arecursos , 2 ) + "]", 1 , analizar_compatibilidad ).
                            IF urec <> 0 AND urec = 1 THEN
                              urec = ubicar_N_recurso( pnro_evento,  num-entries(arecursos) + 1, "ADD2OPER[ " + substring( arecursos , 2 ) + "]" , 2 , analizar_compatibilidad ).
                        END.
                    END.
                    res = urec = 0.
            END.
        END.
        ELSE res = true.
    END.
    ELSE DO:
        IF arecursos <> "" THEN DO:
            IF NOT ubicar_recurso( arecursos , pnro_evento , "" , 0 , analizar_compatibilidad ) THEN  DO:
                /*intentar ubicar a estos recursos*/
            /*se asignara el analizado a los recursos, en caso de mas de un recurso con esa habilidad se verificara
              se tomara segun el balanceo de los que tengan prioridad en 9-5 sino a todos los que tengan esa habilidad*/ 
            /*primero intentar con los de 9-5 de prioridad*/
                urec = ubicar_N_recurso( pnro_evento,  num-entries(arecursos) , "OPER[ " + substring(arecursos , 2 ) + "]" , 0 , analizar_compatibilidad ).
                IF urec <> 0 AND urec > 1 THEN DO:
                    IF faddoper THEN DO:
                        urec =  ubicar_N_recurso( pnro_evento,  num-entries(arecursos) , "ADD1OPER[ " + substring(arecursos , 2 ) + "]" , 1 , analizar_compatibilidad ).
                        IF urec <> 0 AND urec > 1 THEN
                          urec = ubicar_N_recurso( pnro_evento,  num-entries(arecursos) , "ADD1OPER[ " + substring(arecursos , 2 ) + "]" , 2 , analizar_compatibilidad ).
                    END.
                END.
                res = urec = 0.
            END.
            else res = true.
        END.
        ELSE DO:
                urec = ubicar_N_recurso( pnro_evento,  1 , "OPER NO FIJADO" , 0 , analizar_compatibilidad  ).
                IF urec <> 0 AND urec > 1 THEN DO:
                    IF faddoper THEN DO:
                        urec =  ubicar_N_recurso( pnro_evento,  num-entries(arecursos) , "ADD1OPER[ " + substring(arecursos , 2 ) + "]" , 1 , analizar_compatibilidad ).
                        IF urec <> 0 AND urec > 1 THEN
                          urec = ubicar_N_recurso( pnro_evento,  num-entries(arecursos) , "ADD1OPER[ " + substring(arecursos , 2 ) + "]" , 2 , analizar_compatibilidad ).
                    END.
                END.
                res = urec = 0.
        END.
    END.
END.
ELSE res = TRUE.

IF NOT res THEN do:
    IF analizado.heredado = "D" THEN
            RETURN "N". /*no tiene sentido seguir adelante no esta asignado el principal*/
    ELSE RETURN "R". /*repetir*/
END.
/*Verificar la existencia de un sub_evento de orden mayor (hijos de este padre ) 
    para alguno de los eventos agrupados en el restrictor , analizar y procesar*/
DO i = 1 to num-entries(pagrupados):
    find evento where evento.nro_evento = integer( entry( i , pagrupados )) no-error.
    IF not available evento THEN next.
    IF NOT evento.asignado THEN NEXT. /*el proceso de hubicar los asigno a todos los hijos*/
    find first bevento where evento.nro_identificacion = bevento.nro_identificacion  and
               bevento.sub_evento > evento.sub_evento AND NOT bevento.asignado and
               bevento.fmin >= evento.fmin AND bevento.fmax <= evento.fmax 
               NO-ERROR.
    IF NOT AVAILABLE bevento THEN NEXT.
    /*buscar el padre de ese evento*/
    ppadre = IF bevento.nro_evento_padre = 0 THEN bevento.nro_evento ELSE bevento.nro_evento_padre.
                                                                      
    RUN VALUE(trim(tipo_evento.origen) + "-opr.p" ) ( INPUT-OUTPUT TABLE analizado, INPUT-OUTPUT TABLE rvalor, input this-procedure,input ppadre ).
    IF asignar_evento(ppadre, FALSE , pind) = "R" THEN RETURN "R".
END.

/* lo sigue algun evento? */
pagrupados = "".

FOR EACH banalizado WHERE banalizado.evsigue = pnro_evento NO-LOCK :
        pagrupados = pagrupados + "," + string(banalizado.nro_evento).
END.
pagrupados = IF pagrupados <> "" THEN SUBSTRING(pagrupados,2) ELSE "".

DO i = 1 TO num-entries(pagrupados):
            
        RUN VALUE(trim(tipo_evento.origen) + "-opr.p" ) ( INPUT-OUTPUT TABLE analizado, 
                                                          INPUT-OUTPUT TABLE rvalor, 
                                                          input this-procedure,
                                                          input INT(ENTRY(i,pagrupados)) ).
        IF asignar_evento(input INT(ENTRY(i,pagrupados)) , FALSE ,pind) = "R" THEN RETURN "R".
END.

RETURN IF res THEN "A" ELSE "N".   /* Function return value. */
END FUNCTION.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION calcula_encadenado C-Win 
FUNCTION calcula_encadenado RETURNS INTEGER
  ( pagrupado as CHARACTER ) :
/*------------------------------------------------------------------------------
  Purpose:  Funcion que calculo los eventos que dependen de este , 
  eso implica que una vez asignado se asignarar los encadenados
  y eso sucede por:
    subeventos de nivel superior
    eventos que lo siguen ( tienen restriccion dfEV ) campo evsigue es el nro de evento del cual dependen
    
    Notes: Lo puede llegar a sumas mas de una vez pero por ahora no es preocupandte 
------------------------------------------------------------------------------*/
DEF VAR i AS INTEGER NO-UNDO.
def var res as integer no-undo.
define buffer buevento  for evento .
define buffer beevento  for evento .
define buffer buanalizado  for analizado.

res = 0.
DO i  = 1 to num-entries(pagrupado):
        find beevento where beevento.nro_evento = integer(entry(i,pagrupado)).
        for each buevento where buevento.nro_identificacion = beevento.nro_identificacion
                         and buevento.sub_evento > beevento.sub_evento AND
            buevento.fmin >= beevento.fmin AND
            buevento.fmax >= beevento.fmax :
            IF buevento.duracion <> 0 THEN res = res + 1. /*si son hitos no estan considerados en los encadenados*/
            for each buanalizado where buanalizado.agrupado contains string(buevento.nro_evento):
                IF LOOKUP(string(buevento.nro_evento),pagrupado) <> 0 THEN /*no alcanza con el contains*/
                    res = res + calcula_encadenado(buanalizado.agrupado).
            END.
        END.
/*eventos que siguen al pasado como parametro*/

        FIND FIRST buanalizado WHERE buanalizado.evsigue = integer(entry(i,pagrupado)) NO-ERROR.
        IF AVAILABLE buanalizado THEN DO:
            FIND beevento OF analizado.
            IF beevento.duracion <> 0 THEN res = res + 1. /*si son hitos no estan considerados en los encadenados*/
            /*MESSAGE "dfEV" beevento.nro_identificacion beevento.sub_evento.*/
            res = res + calcula_encadenado(string(buanalizado.nro_evento)).
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
IF VALID-HANDLE(hh) THEN   do:
    RUN dispatch IN hh ( INPUT 'destroy':U ) . 
    RETURN TRUE.
END.
ELSE RETURN FALSE.   /* Function return value. */

END FUNCTION.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION compatible C-Win 
FUNCTION compatible RETURNS LOGICAL
  ( pnro-evento AS INT , lista AS CHAR, pfecha AS DATE,dgeomax AS DECIMAL ) :
/*------------------------------------------------------------------------------
  Purpose: Verifica compatibilidad del evento a asignar con otros eventos asignados el mismo dia 
    Notes: si dgeomax = 0 , no evaluar distancias  
------------------------------------------------------------------------------*/
DEFINE BUFFer b1evento FOR evento.
DEFINE BUFFer b2evento FOR evento.
DEFINE BUFFER b1analizado FOR analizado.
    DEFINE VAR i AS INT NO-UNDO.
    DEFINE VAR j AS INT NO-UNDO.
    DEF VAR sal AS LOGICAL NO-UNDO.
    DEFINE VAR pgeoX AS DECIMAL NO-UNDO.
    DEFINE VAR pgeoY AS DECIMAL NO-UNDO.
    DEFINE VAR geocompatible AS LOGICAL NO-UNDO.
    DEFINE VAR distcalc AS DECIMAL NO-UNDO.
    DEFINE VAR asdistcalc AS DECIMAL NO-UNDO.
    DEFINE VAR asevento AS INT.
    DEFINE VAR almenos AS LOGICAL NO-UNDO.
    /*ver que ninguno de los eventos que estan por asignarse tengan un turno igual a los eventos existentes en ninguno de los recursos de la lista*/ 
    
    sal = TRUE.
    geocompatible = TRUE.
    asevento = 0.
    asdistcalc = dgeomax.
    almenos = FALSE.

    FIND b1analizado WHERE b1analizado.nro_evento = pnro-evento NO-LOCK. /*el evento a analizar a su vez puede ser un bloque con varios eventos*/
    DO i = 1 TO NUM-ENTRIES(b1analizado.agrupados):
        FIND b1evento WHERE b1evento.nro_evento = int( entry(i , b1analizado.agrupados )) NO-LOCK.
        IF b1evento.asignado THEN NEXT.
        FIND cliente OF b1evento.
        pgeoX = cliente.geoX.
        pgeoY = cliente.geoY.
        DO j = 1 TO NUM-ENTRIES(lista): /*cada recurso involucrados*/
            FOR EACH recurso_agenda WHERE recurso_agenda.cdg_recurso = ENTRY( j , lista ) AND recurso_agenda.fecha = pfecha,
                EACH b2evento WHERE b2evento.nro_evento = recurso_agenda.nro_evento and
                b2evento.origen = b1evento.origen and
                b1evento.nro_tipo_evento = b2evento.nro_tipo_evento and
                rowid(b1evento) <> rowid(b2evento) NO-LOCK:
                FIND cliente OF b2evento.
                IF NOT almenos AND dgeomax > 0 THEN geocompatible = FALSE.
                almenos = TRUE.

                sal = substring(b1evento.turno, 1,1 ) = substring(b2evento.turno, 1, 1 ) OR
                      substring(b1evento.turno, 1,1 ) = "*" OR 
                      substring(b2evento.turno, 1, 1 ) = "*" .

                sal = sal AND ( substring(b1evento.turno, 2,1 ) = "*" OR 
                                substring(b2evento.turno, 2, 1 ) = "*" OR
                                substring(b1evento.turno, 2,1 ) <> substring(b2evento.turno, 2, 1)  OR
                               corrida > 1 ). /*si es la segunda corrida o mayor sin turnos*/
                IF dgeomax > 0 THEN DO:
                    distcalc = distgeodesicaUTM( pgeoX , pGeoY , cliente.geoX , cliente.geoY ).
                    IF distcalc <= dgeomax THEN DO:
                        geocompatible = TRUE.
                        IF distcalc < asdistcalc THEN DO:
                            asevento = b2evento.nro_evento.
                            asdistcalc = distcalc.
                        END.
                    END.
                END.
            END.
        END.
    END.
    IF sal AND geocompatible THEN DO:
        IF asevento <> 0 THEN DO:
            FIND b1evento WHERE b1evento.nro_evento = pnro-evento.
            b1evento.mobs = ( IF  b1evento.mobs = "" THEN "" ELSE  b1evento.mobs + " " ) + "GEO: " + string(asevento) + " a " + string(int(asdistcalc)). 
        END.
    END.
    RETURN sal AND geocompatible.
 END FUNCTION.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION create_evento C-Win 
FUNCTION create_evento RETURNS LOGICAL
  ( pp as char ) :
/*------------------------------------------------------------------------------
  Purpose:  create_evento("71,1,90,10/09/08",fmin,fmax,recursos).
    Notes:  
------------------------------------------------------------------------------*/
DEFINE VAR i AS INT NO-UNDO.
MESSAGE "Error en create evento, funcion en deshuso, ver las asignaciones".
CREATE evento.
          ASSIGN 
              Evento.Asignado = true
              evento.origen = "CONTRATO"
              Evento.Duracion = int(entry( 3 ,pp ))  /*la tiene que asignar de los eventos anteriores*/
              Evento.FAsignado = date( entry( 4 , pp ) )
              Evento.FRealizado = date( entry( 4 , pp ) )
              Evento.FCreado = TODAY
              evento.fmin = date( entry( 5 ,pp ) )
              evento.fmax = date( entry( 6 ,pp ) )
              Evento.nro_evento = NEXT-VALUE(proximo_evento)
              Evento.nro_evento_padre = 0
              Evento.nro_identificacion = int(entry( 1 , pp ))
              Evento.nro_tipo_evento = c_nro_tipo_evento 
              Evento.Recursos = replace(IF substring( entry( 7 ,pp ) ,1 ,1 )= "#" THEN substring( entry( 7 ,pp ) ,2 ) ELSE ENTRY( 7 , pp ),"|",",")
              evento.sub_evento = int(entry(2, pp ))
              evento.evaluar=true.
          IF evento.asignado THEN DO:
          DO i = 1 TO NUM-ENTRIES(evento.recursos):
              FIND recurso_agenda WHERE recurso_agenda.cdg_recurso = ENTRY(i,evento.recurso) AND
                  recurso_agenda.fecha = evento.fasignado AND
                  recurso_agenda.nro_evento = evento.nro_evento NO-LOCK NO-ERROR.
                  IF NOT AVAILABLE recurso_agenda THEN do:
                      CREATE recurso_agenda.
                      ASSIGN recurso_agenda.cdg_recurso = ENTRY(i,evento.recurso)
                             recurso_agenda.fecha = evento.fasignado
                             recurso_agenda.nro_evento = evento.nro_evento
                             recurso_agenda.observacion = "Creado externo".
                  END.
          END.
END.
        RETURN FALSE.   /* Function return value. */

END FUNCTION.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION desasignar C-Win 
FUNCTION desasignar RETURNS LOGICAL
  ( pnro AS INT ) :
/*------------------------------------------------------------------------------
  Purpose: desasigna el evento y todos los que depende directamente de el 
    Notes:  
------------------------------------------------------------------------------*/
DEFINE BUFFER devento  FOR evento.  
DEFINE BUFFER danalizado FOR analizado.
DEFINE BUFFER danalizado1 FOR analizado.
DEFINE VAR pagrupados AS CHARACTER NO-UNDO.
DEFINE VAR ii AS INT NO-UNDO.
FIND danalizado WHERE danalizado.nro_evento = pnro NO-LOCK NO-ERROR.
IF NOT AVAILABLE danalizado THEN RETURN false.

FOR EACH danalizado1 WHERE danalizado1.ind = analizado.ind: 
    pagrupados = pagrupados + "," + danalizado1.agrupado.
END.
pagrupados = SUBSTRING(pagrupados,2).


DO ii = 1 TO NUM-ENTRIES(pagrupados):
    FIND evento WHERE evento.nro_evento = INT(ENTRY(ii,pagrupados)).
    FOR EACH recurso_agenda WHERE recurso_agenda.nro_evento = evento.nro_evento:
          DELETE recurso_agenda.
      END.
      ASSIGN evento.fasignado = ?
             evento.asignado = NO.
      IF evento.origen = "CONTRATO" THEN DO:
          FOR EACH devento WHERE devento.RefEvento = evento.nro_evento:
              FOR EACH recurso_agenda WHERE recurso_agenda.nro_evento = devento.nro_evento:
                  FIND balanceo WHERE balanceo.cdg_recurso = recurso_agenda.cdg_recurso.
                  ASSIGN balanceo.utilizacion = balanceo.utilizacion - devento.duracion.
                  DELETE recurso_agenda.
              END.
              DELETE devento.
          END.
      END.
END.
 
RETURN TRUE.   /* Function return value. */

END FUNCTION.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION dia_prohibido C-Win 
FUNCTION dia_prohibido RETURNS LOGICAL
  ( /* parameter-definitions */ ) :
/*------------------------------------------------------------------------------
  Purpose: Se fija en la base de datos dproh si el dia esta prohibido para ser usado
    por el bloque o por la hubicacion recursiva 
    Notes:  
------------------------------------------------------------------------------*/
  FIND dproh WHERE dproh.fecha = rvalor.fecha NO-LOCK NO-ERROR.
  RETURN AVAILABLE dproh.

END FUNCTION.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION disponible C-Win 
FUNCTION disponible RETURNS LOGICAL
  ( INPUT p-nro_tipo_evento AS INT , INPUT lista AS CHAR , pfecha AS DATE , durac AS INT ) :
/*------------------------------------------------------------------------------
  Purpose:  verifica que todos los recursos de la lista tengan disponibilidad de una duracion determinada para un dia 
    Notes:  
------------------------------------------------------------------------------*/
DEF VAR i AS INT NO-UNDO.      
DO i = 1 TO NUM-ENTRIES(lista):
        FIND recurso_capacidad WHERE recurso_capacidad.nro_tipo_evento = p-nro_tipo_evento AND 
            recurso_capacidad.cdg_recurso = entry(i,lista) AND
            recurso_capacidad.fecha = pfecha NO-LOCK NO-ERROR.
        IF NOT AVAILABLE recurso_capacidad THEN RETURN false.
        IF recurso_capacidad.capacidad - asignado_dia( INPUT p-nro_tipo_evento , 
                                                       INPUT recurso_capacidad.cdg_recurso,pfecha ) < durac THEN do:
                RETURN false.
        END.
END.
RETURN true.   

END FUNCTION.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION fechaant C-Win 
FUNCTION fechaant RETURNS DATE ( f AS DATE , d AS INT ):
    /*retorna una fecha anterior en dia habil, no domingo , ni feriados */ 
       DEFINE VAR dd AS DATE.
       dd = f  - d.
       FIND feriado WHERE feriado.fecha = dd NO-ERROR.
       IF AVAILABLE feriado THEN DO:
           repeat:
               dd = dd - 1.
               IF WEEKDAY(dd) = 1  THEN NEXT.
               FIND feriado WHERE feriado.fecha = dd NO-ERROR.
               IF NOT AVAILABLE feriado THEN leave.
           END.
       END.
       RETURN dd.

END FUNCTION.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION prohibir C-Win 
FUNCTION prohibir RETURNS LOGICAL
  ( pnro AS INT ) :
/*------------------------------------------------------------------------------
  Purpose:  bloquea el dia que ha sido utilizado por el evento y desasigna todo los eventos
            relacionados a este.
    Notes:  
------------------------------------------------------------------------------*/
  /*levantar el asignado del D y prohibir el dia*/
    FIND analizado WHERE analizado.nro_evento = pnro.
    FIND evento OF analizado.
    IF NOT evento.asignado THEN RETURN FALSE.
    FIND dproh WHERE dproh.ind = analizado.ind AND fecha = evento.fasignado NO-ERROR.
    IF NOT AVAILABLE dproh THEN DO:
        CREATE dproh.
        ASSIGN dproh.ind = analizado.ind
               dproh.fecha = evento.fasignado.
    END.
    RETURN TRUE.   /* Function return value. */

END FUNCTION.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION ubicar_N_recurso C-Win 
FUNCTION ubicar_N_recurso RETURNS INTEGER
  ( pnro_evento AS INT, N AS INT , vm AS CHAR, recadd AS INT , analizar_compatibilidad AS LOGICAL) :
/*------------------------------------------------------------------------------
  Purpose: Ubicar la cantidad de recursos solicitados de ese tipo segun el balanceo 
          y utilizando los mas aptos segun prioridad ( falta no imprementado ) de ser elegidos 
           en la lista se retornan los recursos efectivamente elegidos,
           En vez de una funcion deberia haber sido un procedimiento pero 
           es elije funcion por compatibilidad con ubicar_recurso.   
           recadd son los recursos agregados a un evento se disminuye el tiempo en forma proporcional
           aunque en realidad no es asi no se considera el factor molestia o coordinacion
------------------------------------------------------------------------------*/
DEF VAR i AS INT NO-UNDO.
DEF VAR durac AS INT NO-UNDO.
DEF VAR rlista AS CHAR NO-UNDO.
DEF VAR lista AS CHAR NO-UNDO.
DEF BUFFER banalizado FOR analizado.
DEF BUFFER brvalor FOR rvalor.
define buffer buevento for evento.
DEFINE VAR pturno AS CHAR .
FIND buevento WHERE buevento.nro_evento = pnro_evento.
pturno = substring(buevento.turno,1,1).
lista = "".

FOR EACH balanceo WHERE balanceo.turno = pturno OR balanceo.turno = "I"  BY balanceo.utilizacion : /*intento asignar a los que les asigno menos eventos*/
    IF lookup( cdg_recurso , buevento.recursos) = 0 THEN
       lista = lista + "," + STRING(cdg_recurso).
END.
lista = IF lista <> "" THEN SUBSTR(lista,2) ELSE "".
IF NUM-ENTRIES(lista) < n THEN do:
    message "El evento " + string(pnro_evento) + " require de " + string(n) + " recursos " skip
    " y no se llega a la cantidad, verifique " skip
        "identificacion " + Evento.Origen + string(buevento.nro_identificacion) view-as alert-box error.
    RETURN 3. /*no alcanzan los recursos minimos*/
END.

FIND first banalizado WHERE banalizado.nro_evento = pnro_evento no-error.
IF not available banalizado THEN do:
    message "Error interno analizado nro_evento " + string(pnro_evento) view-as alert-box error.
    return 2.
END.
   /*encontrar el mejor dia y asignar*/
    FOR EACH brvalor WHERE brvalor.nro_evento = banalizado.nro_evento USE-INDEX idx2 : 
        rlista = "".
        DO i = 1 TO NUM-ENTRIES(lista):
            IF  brvalor.valor <> 0 and  disponible(buevento.nro_tipo_evento , entry(i,lista) , brvalor.fecha, banalizado.duracion  -  INT(recadd * banalizado.duracion / NUM-ENTRIES( vm ) )) THEN
                rlista = IF rlista = "" THEN ENTRY(i,lista) ELSE rlista + "," + ENTRY(i,lista).
            IF num-entries(rlista) >= n THEN LEAVE. /*suficiente estos recursos elegidos tiene disponibilidad*/
        END.
        IF NUM-ENTRIES(rlista) < n THEN NEXT. /*seguir con otro dia para el seleccionado no hay recursos disponibles*/
        if ubicar_recurso(INPUT rlista, banalizado.nro_evento, vm, recadd, analizar_compatibilidad ) THEN RETURN 0.
    END.
    RETURN 1.   /* NO SE PUDO ASIGNAR */
    END FUNCTION.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION ubicar_recurso C-Win 
FUNCTION ubicar_recurso RETURNS LOGICAL
  ( INPUT lista AS char, pnro_evento AS INT , pmobs AS CHAR , recadd AS INT , analizar_compatibilidad AS LOGICAL) :
/*------------------------------------------------------------------------------
  Purpose: ubicar los recursos segun la tabla rvalor. 
    Notes:  
------------------------------------------------------------------------------*/
/*------------------------------------------------------------------------------
  Purpose: Ubicar todos los recursos mencionados en la lista    
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF VAR v_i AS INT NO-UNDO.
DEF VAR v_j AS INT NO-UNDO.
DEF VAR durac AS INT NO-UNDO.
define buffer buevento for evento.
DEFINE VAR intento AS INT NO-UNDO.
IF lista = "" THEN RETURN FALSE.


FIND buevento WHERE buevento.nro_evento = pnro_evento. /*evento en tratamiento */
FIND analizado WHERE analizado.nro_evento = pnro_evento.
/*el recurso esta explicitamente asignado, encontrar el mejor dia y asignar*/
FOR EACH rvalor WHERE rvalor.nro_evento = analizado.nro_evento AND rvalor.valor <> 0 USE-INDEX idx2: 
    intento = intento + 1.
/*   IF buevento.nro_identificacion = 10216 AND buevento.sub_evento = 2 THEN
       {DEBUG.i} */
   IF NOT disponible(buevento.nro_tipo_evento , 
                 lista , 
                 rvalor.fecha , 
                 analizado.duracion -  INT(recadd * analizado.duracion / NUM-ENTRIES( lista ) ) ) 
   THEN do:
       rvalor.mobs = ( IF rvalor.mobs <> "" THEN rvalor.mobs + " " ELSE "" ) + "NO-DISPON[" + STRING(intento) + "]".
       NEXT.
   END.
   IF dia_prohibido() THEN DO:
         IF INDEX(rvalor.mobs,"PROHIBIDO") = 0 THEN
            rvalor.mobs = ( IF rvalor.mobs <> "" THEN rvalor.mobs + " " ELSE "" ) + "PROHIBIDO".
         NEXT.
   END.
       /*los recursos necesarios estan disponibles para ser utilizados*/
   IF analizar_compatibilidad  AND NOT compatible( pnro_evento , lista , rvalor.fecha, dgeomax ) THEN do:
         rvalor.mobs = ( IF rvalor.mobs <> "" THEN rvalor.mobs + " " ELSE "" ) + "NO-COMPAT[" + STRING(intento) + "]".
         NEXT.
   END.

   DO v_i = 1 TO NUM-ENTRIES(analizado.agrupados): /*informar a los eventos hijos*/
             FIND buevento WHERE buevento.nro_evento = int(entry(v_i,analizado.agrupados)).
             ASSIGN buevento.asignado = TRUE
                    buevento.recursos = lista
                    buevento.fasignado = rvalor.fecha
                    buevento.mobs = buevento.mobs + rvalor.mobs 
                    buevento.mobs = IF  buevento.mobs <> "" THEN  buevento.mobs + " " + pmobs ELSE pmobs.
             DO v_j = 1 TO NUM-ENTRIES(lista): /*crear las agendas*/
                   FIND balanceo WHERE balanceo.cdg_recurso = ENTRY(v_j,lista).
                   ASSIGN balanceo.utilizacion = balanceo.utilizacion + buevento.duracion.
                   CREATE recurso_agenda.
                   ASSIGN recurso_agenda.cdg_recurso = ENTRY(v_j,lista)
                          recurso_agenda.fecha = rvalor.fecha
                          recurso_agenda.nro_evento = buevento.nro_evento
                          recurso_agenda.observacion = IF recurso_agenda.observacion <> "" THEN recurso_agenda.observacion + " " + buevento.mobs ELSE buevento.mobs.
             END.
             /*crear el aviso si corresponde a ese evento.*/
             RUN crea_aviso_evento.p ( INPUT ROWID(buevento) ).
   END.
   RETURN TRUE.   
END.
RETURN FALSE.   /* NO SE PUDO ASIGNAR */  
END FUNCTION.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

