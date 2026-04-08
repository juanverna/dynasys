&ANALYZE-SUSPEND _VERSION-NUMBER UIB_v8r12 GUI ADM1
&ANALYZE-RESUME
/* Connected Databases 
          sic              PROGRESS
*/
&Scoped-define WINDOW-NAME W-Win
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _DEFINITIONS W-Win 
/*********************************************************************
* Copyright (C) 2000 by Progress Software Corporation ("PSC"),       *
* 14 Oak Park, Bedford, MA 01730, and other contributors as listed   *
* below.  All Rights Reserved.                                       *
*                                                                    *
* The Initial Developer of the Original Code is PSC.  The Original   *
* Code is Progress IDE code released to open source December 1, 2000.*
*                                                                    *
* The contents of this file are subject to the Possenet Public       *
* License Version 1.0 (the "License"); you may not use this file     *
* except in compliance with the License.  A copy of the License is   *
* available as of the date of this notice at                         *
* http://www.possenet.org/license.html                               *
*                                                                    *
* Software distributed under the License is distributed on an "AS IS"*
* basis, WITHOUT WARRANTY OF ANY KIND, either express or implied. You*
* should refer to the License for the specific language governing    *
* rights and limitations under the License.                          *
*                                                                    *
* Contributors:                                                      *
*                                                                    *
*********************************************************************/
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

{geolibrary.i}
DEFINE INPUT PARAMETER ptipo AS INT.
DEFINE INPUT PARAMETER pfmin AS DATE.
DEFINE INPUT PARAMETER pfmax AS DATE.
DEFINE INPUT PARAMETER dmaxp AS INT.
DEFINE INPUT PARAMETER pevento AS INT.
DEFINE INPUT PARAMETER pgeoLAT AS DECIMAL.
DEFINE INPUT PARAMETER pgeoLONG AS DECIMAL.
DEFINE INPUT PARAMETER preferencia AS CHAR.
DEFINE INPUT PARAMETER pcdg_cliente  AS CHAR.
DEFINE INPUT PARAMETER pdireccion AS CHAR.
DEFINE INPUT PARAMETER caller AS HANDLE. /*si perdon!!!!*/
DEFINE INPUT PARAMETER pdurac AS int.



DEFINE TEMP-TABLE vecino
    FIELD nro_evento LIKE evento.nro_evento
    FIELD cdg_cliente LIKE cliente.cdg_cliente
    FIELD nro_cliente LIKE cliente.nro_cliente
    FIELD direccion LIKE cliente.direccion
    FIELD disponible AS INT
    FIELD distancia AS DECIMAL
    FIELD fasignado LIKE evento.fasignado
    FIELD recursos LIKE evento.recursos
    FIELD turno LIKE evento.turno
    FIELD geolat AS DECIMAL
    FIELD duracion LIKE evento.durac 
    FIELD geolong AS DECIMAL
    FIELD origen LIKE evento.origen
    FIELD cdg_tipo_evento LIKE tipo_evento.cdg_tipo_evento
    FIELD nro_tipo_evento LIKE tipo_evento.nro_tipo_evento
    INDEX distancia IS PRIMARY distancia ASCENDING.


DEFINE VAR h_geoTT AS HANDLE.
DEFINE VAR h_geoTT2 AS HANDLE.

DEFINE TEMP-TABLE ttgeo NO-UNDO
    FIELD ttind AS INT
    FIELD ttgeolat AS DECIMAL
    FIELD ttgeolong AS DECIMAL
    FIELD tttipo AS INT
    FIELD tturl AS CHARACTER
    INDEX ind AS PRIMARY ttind.

DEFINE VAR nelegido AS INT.
DEFINE BUFFER bevento FOR evento.
{restricciones.i}
DEFINE VAR pcdg_tipo LIKE tipo_evento.cdg_tipo_evento NO-UNDO.
DEFINE VAR direccion LIKE cliente.direccion NO-UNDO.
DEFINE VAR nro_aviso_tipo_evento LIKE evento.nro_evento NO-UNDO.
DEFINE VAR unidades LIKE sic.Cliente_otros_datos.Unidades NO-UNDO.
DEFINE VAR rdur AS INT FORMAT ">>9" COLUMN-LABEL "RDUR" .
DEFINE VAR ocupado AS INT NO-UNDO FORMAT ">>9".

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
&Scoped-define INTERNAL-TABLES vecino recurso_agenda bEvento

/* Definitions for BROWSE BROWSE-2                                      */
&Scoped-define FIELDS-IN-QUERY-BROWSE-2 vecino.cdg_cliente vecino.direccion vecino.distancia vecino.fasignado vecino.recursos vecino.duracion ocupado( entry( 1 , vecino.recursos ), vecino.fasignado) @ ocupado unidades(vecino.nro_cliente) @ unidades vecino.turno vecino.cdg_tipo_evento vecino.nro_evento   
&Scoped-define ENABLED-FIELDS-IN-QUERY-BROWSE-2   
&Scoped-define SELF-NAME BROWSE-2
&Scoped-define QUERY-STRING-BROWSE-2 FOR EACH vecino
&Scoped-define OPEN-QUERY-BROWSE-2 OPEN QUERY {&SELF-NAME} FOR EACH vecino.
&Scoped-define TABLES-IN-QUERY-BROWSE-2 vecino
&Scoped-define FIRST-TABLE-IN-QUERY-BROWSE-2 vecino


/* Definitions for BROWSE BROWSE-4                                      */
&Scoped-define FIELDS-IN-QUERY-BROWSE-4 bevento.recursos cdg_tip() @ cdg_tip bevento.origen bevento.nro_identificacion direccion() @ direccion bevento.sub_evento bevento.turno bevento.duracion rdur(bevento.NRO_EVENTO) @ rdur unidades(bevento.nro_cliente) @ unidades bevento.fasignado bevento.frealizado perant(bevento.nro_evento) @ perant bevento.hora_desde bevento.hora_hasta comprest(bevento.nro_evento)@ comprest bevento.nro_evento bevento.nro_evento_padre bevento.mobs bevento.observacion bevento.reminder bevento.fmin bevento.fmax   
&Scoped-define ENABLED-FIELDS-IN-QUERY-BROWSE-4   
&Scoped-define SELF-NAME BROWSE-4
&Scoped-define QUERY-STRING-BROWSE-4 FOR EACH recurso_agenda       WHERE  recurso_agenda.fecha = vecino.fasignado and     can-do(  vecino.recursos , ~
       recurso_agenda.cdg_recurso ) NO-LOCK, ~
             EACH bEvento NO-LOCK OF recurso_agenda WHERE NOT bevento.anulado BY bevento.turno  INDEXED-REPOSITION. IF AVAILABLE bevento THEN     DYNAMIC-FUNCTION("pevento" IN h_q-evento, ~
      bevento.nro_evento)
&Scoped-define OPEN-QUERY-BROWSE-4 OPEN QUERY {&SELF-NAME} FOR EACH recurso_agenda       WHERE  recurso_agenda.fecha = vecino.fasignado and     can-do(  vecino.recursos , ~
       recurso_agenda.cdg_recurso ) NO-LOCK, ~
             EACH bEvento NO-LOCK OF recurso_agenda WHERE NOT bevento.anulado BY bevento.turno  INDEXED-REPOSITION. IF AVAILABLE bevento THEN     DYNAMIC-FUNCTION("pevento" IN h_q-evento, ~
      bevento.nro_evento).
&Scoped-define TABLES-IN-QUERY-BROWSE-4 recurso_agenda bEvento
&Scoped-define FIRST-TABLE-IN-QUERY-BROWSE-4 recurso_agenda
&Scoped-define SECOND-TABLE-IN-QUERY-BROWSE-4 bEvento


/* Definitions for FRAME F-Main                                         */
&Scoped-define OPEN-BROWSERS-IN-QUERY-F-Main ~
    ~{&OPEN-QUERY-BROWSE-2}~
    ~{&OPEN-QUERY-BROWSE-4}

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS fcdg fdirec BROWSE-2 BUTTON-11 exav Tdia-1 ~
Tdia-2 Tdia-3 tignore v-singeo dmax Btn_OK Btn_Cancel pridia ultdia Tdia-4 ~
Tdia-5 Tdia-6 Tcompatibles BROWSE-4 Ttodos BUTTON-13 Bp1 Bp2 
&Scoped-Define DISPLAYED-OBJECTS fcdg fdirec exav Tdia-1 Tdia-2 Tdia-3 ~
tignore v-singeo dmax pridia ultdia Tdia-4 Tdia-5 Tdia-6 Tcompatibles ~
Ttodos 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME


/* ************************  Function Prototypes ********************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION-FORWARD alcanza W-Win 
FUNCTION alcanza RETURNS CHAR
  ( precursos AS char,fa AS date, ddur AS INT)  FORWARD.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION-FORWARD cdg_tip W-Win 
FUNCTION cdg_tip RETURNS CHARACTER
  ( )  FORWARD.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION-FORWARD direccion W-Win 
FUNCTION direccion RETURNS CHARACTER
  ( /* parameter-definitions */ )  FORWARD.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION-FORWARD durdia W-Win 
FUNCTION durdia RETURNS INT64
  ( pcdg_recurso AS char, ff AS DATE )  FORWARD.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION-FORWARD duref W-Win 
FUNCTION duref RETURNS INT
  ( d AS CHAR, h AS CHAR )  FORWARD.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION-FORWARD es_compatible W-Win 
FUNCTION es_compatible RETURNS LOGICAL
( cdg_tipo AS CHAR , precursos AS CHAR )  FORWARD.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION-FORWARD limpia W-Win 
FUNCTION limpia RETURNS CHARACTER
  ( INPUT aa AS CHARACTER )  FORWARD.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION-FORWARD ocupado W-Win 
FUNCTION ocupado RETURNS INTEGER
  ( prec AS CHAR , fa AS DATE )  FORWARD.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION-FORWARD rdur W-Win 
FUNCTION rdur RETURNS INTEGER
  ( rr AS INT )  FORWARD.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION-FORWARD unidades W-Win 
FUNCTION unidades RETURNS INTEGER
  ( pnro AS INT )  FORWARD.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


/* ***********************  Control Definitions  ********************** */

/* Define the widget handle for the window                              */
DEFINE VAR W-Win AS WIDGET-HANDLE NO-UNDO.

/* Definitions of handles for OCX Containers                            */
DEFINE VARIABLE CtrlFrame AS WIDGET-HANDLE NO-UNDO.
DEFINE VARIABLE chCtrlFrame AS COMPONENT-HANDLE NO-UNDO.

/* Definitions of handles for SmartObjects                              */
DEFINE VARIABLE h_b-eventocli AS HANDLE NO-UNDO.
DEFINE VARIABLE h_p-soloedita AS HANDLE NO-UNDO.
DEFINE VARIABLE h_q-evento AS HANDLE NO-UNDO.
DEFINE VARIABLE h_v-evento-2 AS HANDLE NO-UNDO.

/* Definitions of the field level widgets                               */
DEFINE BUTTON Bp1 
     LABEL "EV" 
     SIZE 5.4 BY 1.14 TOOLTIP "Evento detalle del evento".

DEFINE BUTTON Bp2 
     LABEL "HIS" 
     SIZE 5.4 BY 1.14 TOOLTIP "Historia de los eventos del cliente".

DEFINE BUTTON Btn_Cancel AUTO-END-KEY 
     LABEL "Can" 
     SIZE 6 BY 1.14 TOOLTIP "Cancel"
     BGCOLOR 8 .

DEFINE BUTTON Btn_OK AUTO-GO 
     LABEL "OK" 
     SIZE 5 BY 1.14 TOOLTIP "OK - refrescar"
     BGCOLOR 8 .

DEFINE BUTTON BUTTON-11 
     IMAGE-UP FILE "C:/Dynasys10/progs/img/earth_location.jpg":U
     LABEL "b-geocli" 
     SIZE 5 BY 8.1.

DEFINE BUTTON BUTTON-13 
     IMAGE-UP FILE "C:/Dynasys10/progs/img/earth_location.jpg":U
     LABEL "b-geocli" 
     SIZE 5 BY 1.19.

DEFINE VARIABLE dmax AS DECIMAL FORMAT ">>>>>>9":U INITIAL 1000 
     LABEL "Dmax" 
     VIEW-AS FILL-IN 
     SIZE 8.8 BY 1 TOOLTIP "Distancia maxima en metros" NO-UNDO.

DEFINE VARIABLE fcdg AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN NATIVE 
     SIZE 14 BY 1 TOOLTIP "Codigo de cliente buscado."
     BGCOLOR 11  NO-UNDO.

DEFINE VARIABLE fdirec AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN NATIVE 
     SIZE 87 BY 1 TOOLTIP "Direccion Buscada"
     BGCOLOR 11  NO-UNDO.

DEFINE VARIABLE pridia AS DATE FORMAT "99/99/9999":U 
     LABEL "del" 
     VIEW-AS FILL-IN 
     SIZE 15.6 BY 1 NO-UNDO.

DEFINE VARIABLE ultdia AS DATE FORMAT "99/99/9999":U 
     LABEL "a" 
     VIEW-AS FILL-IN 
     SIZE 15.2 BY 1 NO-UNDO.

DEFINE VARIABLE v-singeo AS CHARACTER FORMAT "X(256)":U 
     LABEL "SinGeo" 
     VIEW-AS FILL-IN 
     SIZE 11.8 BY 1 NO-UNDO.

DEFINE VARIABLE exav AS LOGICAL INITIAL yes 
     LABEL "ExAV" 
     VIEW-AS TOGGLE-BOX
     SIZE 13.4 BY .81 TOOLTIP "Excluir  Avisos" NO-UNDO.

DEFINE VARIABLE Tcompatibles AS LOGICAL INITIAL yes 
     LABEL "Compa" 
     VIEW-AS TOGGLE-BOX
     SIZE 11.4 BY .81 TOOLTIP "Que alguno de los recursos asignados tenga la habilidad pedida" NO-UNDO.

DEFINE VARIABLE Tdia-1 AS LOGICAL INITIAL yes 
     LABEL "LU" 
     VIEW-AS TOGGLE-BOX
     SIZE 6 BY .81 NO-UNDO.

DEFINE VARIABLE Tdia-2 AS LOGICAL INITIAL yes 
     LABEL "Ma" 
     VIEW-AS TOGGLE-BOX
     SIZE 6 BY .81 NO-UNDO.

DEFINE VARIABLE Tdia-3 AS LOGICAL INITIAL yes 
     LABEL "Mi" 
     VIEW-AS TOGGLE-BOX
     SIZE 6 BY .81 NO-UNDO.

DEFINE VARIABLE Tdia-4 AS LOGICAL INITIAL yes 
     LABEL "JU" 
     VIEW-AS TOGGLE-BOX
     SIZE 6 BY .81 NO-UNDO.

DEFINE VARIABLE Tdia-5 AS LOGICAL INITIAL yes 
     LABEL "VI" 
     VIEW-AS TOGGLE-BOX
     SIZE 6 BY .81 NO-UNDO.

DEFINE VARIABLE Tdia-6 AS LOGICAL INITIAL yes 
     LABEL "SA" 
     VIEW-AS TOGGLE-BOX
     SIZE 8.2 BY .81 NO-UNDO.

DEFINE VARIABLE tignore AS LOGICAL INITIAL no 
     LABEL "IgnDurac" 
     VIEW-AS TOGGLE-BOX
     SIZE 13.4 BY .81 TOOLTIP "Ignore Durac" NO-UNDO.

DEFINE VARIABLE Ttodos AS LOGICAL INITIAL yes 
     LABEL "T" 
     VIEW-AS TOGGLE-BOX
     SIZE 6 BY .81 TOOLTIP "Nuestra todos los eventos o solo los del mismo tipo" NO-UNDO.

/* Query definitions                                                    */
&ANALYZE-SUSPEND
DEFINE QUERY BROWSE-2 FOR 
      vecino SCROLLING.

DEFINE QUERY BROWSE-4 FOR 
      recurso_agenda, 
      bEvento SCROLLING.
&ANALYZE-RESUME

/* Browse definitions                                                   */
DEFINE BROWSE BROWSE-2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS BROWSE-2 W-Win _FREEFORM
  QUERY BROWSE-2 NO-LOCK DISPLAY
      vecino.cdg_cliente 
    vecino.direccion 
    vecino.distancia COLUMN-LABEL "Dist.![mtrs]"
    vecino.fasignado 
    vecino.recursos 
    vecino.duracion  COLUMN-LABEL "DUR" 
    ocupado( entry( 1 , vecino.recursos ), vecino.fasignado) @ ocupado COLUMN-LABEL "OCUP"
    unidades(vecino.nro_cliente) @ unidades
    vecino.turno COLUMN-LABEL "Turno"
    vecino.cdg_tipo_evento COLUMN-LABEL "TI"
    vecino.nro_evento COLUMN-LABEL "Evento"
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ROW-MARKERS SEPARATORS SIZE 144 BY 8.1 FIT-LAST-COLUMN.

DEFINE BROWSE BROWSE-4
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS BROWSE-4 W-Win _FREEFORM
  QUERY BROWSE-4 NO-LOCK DISPLAY
      bevento.recursos
      cdg_tip() @ cdg_tip
      bevento.origen
      bevento.nro_identificacion
      direccion() @ direccion
      bevento.sub_evento
      bevento.turno
      bevento.duracion
      rdur(bevento.NRO_EVENTO) @ rdur
      unidades(bevento.nro_cliente) @ unidades
      bevento.fasignado
      bevento.frealizado
      perant(bevento.nro_evento) @ perant
      bevento.hora_desde
      bevento.hora_hasta
      comprest(bevento.nro_evento)@ comprest
      bevento.nro_evento
      bevento.nro_evento_padre
      bevento.mobs
      bevento.observacion
      bevento.reminder
      bevento.fmin
      bevento.fmax
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ROW-MARKERS SEPARATORS SIZE 144 BY 7.71
         TITLE "Agenda de los recursos" FIT-LAST-COLUMN.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME F-Main
     fcdg AT ROW 1.24 COL 1 COLON-ALIGNED NO-LABEL WIDGET-ID 96
     fdirec AT ROW 1.24 COL 16 COLON-ALIGNED NO-LABEL WIDGET-ID 98
     BROWSE-2 AT ROW 2.43 COL 3 WIDGET-ID 200
     BUTTON-11 AT ROW 2.67 COL 148 WIDGET-ID 36
     exav AT ROW 10.52 COL 137 WIDGET-ID 116
     Tdia-1 AT ROW 10.57 COL 100.2 WIDGET-ID 102
     Tdia-2 AT ROW 10.57 COL 106.8 WIDGET-ID 104
     Tdia-3 AT ROW 10.57 COL 113.8 WIDGET-ID 106
     tignore AT ROW 10.57 COL 122.6 WIDGET-ID 100
     v-singeo AT ROW 11 COL 9.2 COLON-ALIGNED WIDGET-ID 78
     dmax AT ROW 11 COL 28 COLON-ALIGNED WIDGET-ID 86
     Btn_OK AT ROW 11 COL 40 WIDGET-ID 84
     Btn_Cancel AT ROW 11 COL 45.8 WIDGET-ID 80
     pridia AT ROW 11 COL 54.8 COLON-ALIGNED WIDGET-ID 74
     ultdia AT ROW 11 COL 72.8 COLON-ALIGNED WIDGET-ID 76
     Tdia-4 AT ROW 11.29 COL 100 WIDGET-ID 108
     Tdia-5 AT ROW 11.29 COL 106.8 WIDGET-ID 110
     Tdia-6 AT ROW 11.29 COL 113.8 WIDGET-ID 112
     Tcompatibles AT ROW 11.43 COL 122.6 WIDGET-ID 92
     BROWSE-4 AT ROW 12.24 COL 3.2 WIDGET-ID 300
     Ttodos AT ROW 12.43 COL 147.8 WIDGET-ID 90
     BUTTON-13 AT ROW 13.67 COL 147.8 WIDGET-ID 88
     Bp1 AT ROW 14.95 COL 147.8 WIDGET-ID 40
     Bp2 AT ROW 16.14 COL 147.8 WIDGET-ID 42
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 153.6 BY 30.1 WIDGET-ID 100.


/* *********************** Procedure Settings ************************ */

&ANALYZE-SUSPEND _PROCEDURE-SETTINGS
/* Settings for THIS-PROCEDURE
   Type: SmartWindow
   Allow: Basic,Browse,DB-Fields,Query,Smart,Window
   Design Page: 1
   Other Settings: COMPILE
 */
&ANALYZE-RESUME _END-PROCEDURE-SETTINGS

/* *************************  Create Window  ************************** */

&ANALYZE-SUSPEND _CREATE-WINDOW
IF SESSION:DISPLAY-TYPE = "GUI":U THEN
  CREATE WINDOW W-Win ASSIGN
         HIDDEN             = YES
         TITLE              = "Eventos Vecinos en el Rango de Fechas"
         HEIGHT             = 30.1
         WIDTH              = 153.6
         MAX-HEIGHT         = 30.19
         MAX-WIDTH          = 153.6
         VIRTUAL-HEIGHT     = 30.19
         VIRTUAL-WIDTH      = 153.6
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

{src/adm/method/containr.i}

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME




/* ***********  Runtime Attributes and AppBuilder Settings  *********** */

&ANALYZE-SUSPEND _RUN-TIME-ATTRIBUTES
/* SETTINGS FOR WINDOW W-Win
  VISIBLE,,RUN-PERSISTENT                                               */
/* SETTINGS FOR FRAME F-Main
   FRAME-NAME                                                           */
/* BROWSE-TAB BROWSE-2 fdirec F-Main */
/* BROWSE-TAB BROWSE-4 Tcompatibles F-Main */
ASSIGN 
       BROWSE-2:COLUMN-RESIZABLE IN FRAME F-Main       = TRUE
       BROWSE-2:COLUMN-MOVABLE IN FRAME F-Main         = TRUE.

ASSIGN 
       BROWSE-4:COLUMN-RESIZABLE IN FRAME F-Main       = TRUE
       BROWSE-4:COLUMN-MOVABLE IN FRAME F-Main         = TRUE.

ASSIGN 
       fcdg:READ-ONLY IN FRAME F-Main        = TRUE.

ASSIGN 
       fdirec:READ-ONLY IN FRAME F-Main        = TRUE.

IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(W-Win)
THEN W-Win:HIDDEN = yes.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME


/* Setting information for Queries and Browse Widgets fields            */

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE BROWSE-2
/* Query rebuild information for BROWSE BROWSE-2
     _START_FREEFORM
OPEN QUERY {&SELF-NAME} FOR EACH vecino.
     _END_FREEFORM
     _Options          = "NO-LOCK INDEXED-REPOSITION"
     _Query            is OPENED
*/  /* BROWSE BROWSE-2 */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE BROWSE-4
/* Query rebuild information for BROWSE BROWSE-4
     _START_FREEFORM
OPEN QUERY {&SELF-NAME} FOR EACH recurso_agenda
      WHERE  recurso_agenda.fecha = vecino.fasignado and
    can-do(  vecino.recursos , recurso_agenda.cdg_recurso ) NO-LOCK,
      EACH bEvento NO-LOCK OF recurso_agenda WHERE NOT bevento.anulado BY bevento.turno  INDEXED-REPOSITION.
IF AVAILABLE bevento THEN
    DYNAMIC-FUNCTION("pevento" IN h_q-evento,bevento.nro_evento).
     _END_FREEFORM
     _Options          = "NO-LOCK INDEXED-REPOSITION"
     _TblOptList       = ","
     _Where[1]         = "can-do( recurso_agenda.cdg_recurso  ) and recurso_agenda.fecha = vecino.fasignado"
     _Query            is OPENED
*/  /* BROWSE BROWSE-4 */
&ANALYZE-RESUME

 


/* **********************  Create OCX Containers  ********************** */

&ANALYZE-SUSPEND _CREATE-DYNAMIC

&IF "{&OPSYS}" = "WIN32":U AND "{&WINDOW-SYSTEM}" NE "TTY":U &THEN

CREATE CONTROL-FRAME CtrlFrame ASSIGN
       FRAME           = FRAME F-Main:HANDLE
       ROW             = 11
       COLUMN          = 91.2
       HEIGHT          = 1.05
       WIDTH           = 8
       WIDGET-ID       = 94
       HIDDEN          = no
       SENSITIVE       = yes.

PROCEDURE adm-create-controls:
      CtrlFrame:NAME = "CtrlFrame":U .
/* CtrlFrame OCXINFO:CREATE-CONTROL from: {EAF26C8F-9586-101B-9306-0020AF234C9D} type: CSSpin */
      CtrlFrame:MOVE-AFTER(ultdia:HANDLE IN FRAME F-Main).

END PROCEDURE.

&ENDIF

&ANALYZE-RESUME /* End of _CREATE-DYNAMIC */


/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME W-Win
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL W-Win W-Win
ON END-ERROR OF W-Win /* Eventos Vecinos en el Rango de Fechas */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL W-Win W-Win
ON WINDOW-CLOSE OF W-Win /* Eventos Vecinos en el Rango de Fechas */
DO:
  /* Add Trigger to equate WINDOW-CLOSE to END-ERROR. */
    APPLY "CLOSE":U TO THIS-PROCEDURE.
    RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME Bp1
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Bp1 W-Win
ON CHOOSE OF Bp1 IN FRAME F-Main /* EV */
DO:
  RUN select-Page IN THIS-PROCEDURE (1).
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME Bp2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Bp2 W-Win
ON CHOOSE OF Bp2 IN FRAME F-Main /* HIS */
DO:
    RUN select-Page IN THIS-PROCEDURE (2).
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define BROWSE-NAME BROWSE-2
&Scoped-define SELF-NAME BROWSE-2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL BROWSE-2 W-Win
ON MOUSE-MENU-DOWN OF BROWSE-2 IN FRAME F-Main
DO:
  IF vecino.origen = "CONTRATO" THEN
       RUN d-contrato_restriccion.w ( vecino.nro_evento ).
  ELSE
      MESSAGE "No existe informacion adicional" VIEW-AS ALERT-BOX INFORMATION.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL BROWSE-2 W-Win
ON MOUSE-SELECT-DBLCLICK OF BROWSE-2 IN FRAME F-Main
DO:
    nelegido = IF AVAILABLE vecino THEN vecino.nro_evento ELSE ?.
    IF VALID-HANDLE(caller) THEN
    DYNAMIC-FUNCTION("felegido" In caller , nelegido ) NO-ERROR.   
    APPLY "CLOSE":U TO THIS-PROCEDURE.
    RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL BROWSE-2 W-Win
ON ROW-DISPLAY OF BROWSE-2 IN FRAME F-Main
DO:
  DEFINE  BUFFER baevento FOR evento.
  DEFINE BUFFER btipo_evento FOR tipo_evento.
  DEFINE VAR letra AS INT NO-UNDO.
  DEFINE VAR fondo AS INT NO-UNDO.
  DEFINE VAR ctipo LIKE Tipo_evento.cdg_tipo_evento. 
      FIND evento WHERE evento.nro_evento = vecino.nro_evento NO-LOCK.
      IF  vecino.nro_tipo_evento = nro_aviso_tipo_evento THEN DO:
           FIND FIRST baevento WHERE baevento.nro_evento = evento.refevento NO-LOCK NO-ERROR.
           IF AVAILABLE baevento THEN DO:
                FIND btipo_evento OF baevento NO-LOCK.
                letra = bTipo_evento.color_letra.
                fondo = bTipo_evento.color_fondo.
           END.
      END.
      ELSE DO:
          FIND tipo_evento WHERE vecino.nro_tipo_evento = tipo_evento.nro_tipo_evento NO-LOCK.
          ctipo = Tipo_evento.cdg_tipo_evento.
          letra = Tipo_evento.color_letra.
          fondo = Tipo_evento.color_fondo.
      END.
      vecino.cdg_tipo_evento:FGCOLOR IN BROWSE BROWSE-2 = letra.
      vecino.cdg_tipo_evento:BGCOLOR IN BROWSE BROWSE-2 = fondo.
          
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL BROWSE-2 W-Win
ON VALUE-CHANGED OF BROWSE-2 IN FRAME F-Main
DO:
    {&OPEN-QUERY-BROWSE-4}
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define BROWSE-NAME BROWSE-4
&Scoped-define SELF-NAME BROWSE-4
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL BROWSE-4 W-Win
ON ITERATION-CHANGED OF BROWSE-4 IN FRAME F-Main /* Agenda de los recursos */
DO:
      DYNAMIC-FUNCTION("pevento" IN h_q-evento,bevento.nro_evento).
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL BROWSE-4 W-Win
ON MOUSE-MENU-DOWN OF BROWSE-4 IN FRAME F-Main /* Agenda de los recursos */
DO:
  IF bevento.origen = "CONTRATO" THEN
      RUN d-contrato_restriccion.w ( bevento.nro_identificacion).
  ELSE
      MESSAGE "No hay informacion adicional" VIEW-AS ALERT-BOX INFORMATION.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL BROWSE-4 W-Win
ON ROW-DISPLAY OF BROWSE-4 IN FRAME F-Main /* Agenda de los recursos */
DO:
  DEFINE VAR dmin AS INT NO-UNDO.
  DEFINE VAR dmax AS INT NO-UNDO.
  DEFINE VAR kk AS INT NO-UNDO.
  dmin = bevento.duracion * 0.9.
  dmax = bevento.duracion * 1.10.
  kk = rdur(bevento.nro_evento).
  IF kk = ? THEN rdur:BGCOLOR IN BROWSE {&browse-NAME}= ?.

  IF  kk <> 0 THEN DO:
      IF  kk < dmin THEN
              rdur:BGCOLOR IN BROWSE {&BROWSE-NAME}= 10.
          ELSE 
              IF  kk > dmax THEN
                  rdur:BGCOLOR = 12.
          ELSE
              rdur:BGCOLOR = ?.
  END.
  ELSE rdur:BGCOLOR = ?.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME Btn_Cancel
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Btn_Cancel W-Win
ON CHOOSE OF Btn_Cancel IN FRAME F-Main /* Can */
DO:
  nelegido = ?.
  APPLY "Close" TO THIS-PROCEDURE.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME Btn_OK
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Btn_OK W-Win
ON CHOOSE OF Btn_OK IN FRAME F-Main /* OK */
DO:
  nelegido = IF AVAILABLE vecino THEN vecino.nro_evento ELSE ?.
  IF VALID-HANDLE(caller) THEN
    DYNAMIC-FUNCTION("felegido" In caller , nelegido ) NO-ERROR.                                                             
  /*APPLY "Close" TO THIS-PROCEDURE.*/
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME BUTTON-11
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL BUTTON-11 W-Win
ON CHOOSE OF BUTTON-11 IN FRAME F-Main /* b-geocli */
DO:
  IF NOT VALID-HANDLE( h_geoTT ) THEN DO:
      RUN w-geoTT.w PERSISTENT SET h_geoTT.
      RUN dispatch IN h_geoTT ( INPUT 'initialize':U ) .
  END.
  RUN creaTTgeo.
  DYNAMIC-FUNCTION( "mostrar"  IN h_geoTT,  INPUT TABLE ttgeo ).
  RETURN NO-APPLY. /*Asi se queda arriba la otra window*/
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME BUTTON-13
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL BUTTON-13 W-Win
ON CHOOSE OF BUTTON-13 IN FRAME F-Main /* b-geocli */
DO:
  ASSIGN ttodos.
  IF NOT VALID-HANDLE( h_geoTT2 ) THEN DO:
      RUN w-geoTT.w PERSISTENT SET h_geoTT2.
      RUN dispatch IN h_geoTT2 ( INPUT 'initialize':U ) .
  END.
  RUN creaTTgeo2.
  DYNAMIC-FUNCTION( "mostrar"  IN h_geoTT2,  INPUT TABLE ttgeo ).
  RETURN NO-APPLY. /*Asi se queda arriba la otra window*/
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME CtrlFrame
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL CtrlFrame W-Win OCX.SpinDown
PROCEDURE CtrlFrame.CSSpin.SpinDown .
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  None required for OCX.
  Notes:       
------------------------------------------------------------------------------*/
    pridia:SCREEN-VALUE IN FRAME {&FRAME-NAME}= STRING(pridia:INPUT-VALUE - 1 ).
    ultdia:SCREEN-VALUE = pridia:SCREEN-VALUE.
    RUN ttvecinos.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL CtrlFrame W-Win OCX.SpinUp
PROCEDURE CtrlFrame.CSSpin.SpinUp .
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  None required for OCX.
  Notes:       
------------------------------------------------------------------------------*/
    pridia:SCREEN-VALUE IN FRAME {&FRAME-NAME}= STRING(pridia:INPUT-VALUE + 1 ).
    ultdia:SCREEN-VALUE = pridia:SCREEN-VALUE.
    RUN ttvecinos.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME dmax
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL dmax W-Win
ON LEAVE OF dmax IN FRAME F-Main /* Dmax */
DO:
   RUN ttvecinos.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME exav
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL exav W-Win
ON VALUE-CHANGED OF exav IN FRAME F-Main /* ExAV */
DO:
   RUN ttvecinos.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME pridia
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL pridia W-Win
ON LEAVE OF pridia IN FRAME F-Main /* del */
DO:
         IF ultdia:INPUT-VALUE < pridia:INPUT-VALUE  THEN
           ultdia:SCREEN-VALUE = string(pridia:INPUT-VALUE).
         RUN ttvecinos.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL pridia W-Win
ON MOUSE-MENU-DOWN OF pridia IN FRAME F-Main /* del */
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


&Scoped-define SELF-NAME Tcompatibles
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Tcompatibles W-Win
ON VALUE-CHANGED OF Tcompatibles IN FRAME F-Main /* Compa */
DO:
  ASSIGN tcompatibles.
  RUN ttvecinos.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME Tdia-1
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Tdia-1 W-Win
ON VALUE-CHANGED OF Tdia-1 IN FRAME F-Main /* LU */
DO:
   RUN ttvecinos.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME Tdia-2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Tdia-2 W-Win
ON VALUE-CHANGED OF Tdia-2 IN FRAME F-Main /* Ma */
DO:
   RUN ttvecinos.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME Tdia-3
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Tdia-3 W-Win
ON VALUE-CHANGED OF Tdia-3 IN FRAME F-Main /* Mi */
DO:
   RUN ttvecinos.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME Tdia-4
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Tdia-4 W-Win
ON VALUE-CHANGED OF Tdia-4 IN FRAME F-Main /* JU */
DO:
   RUN ttvecinos.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME Tdia-5
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Tdia-5 W-Win
ON VALUE-CHANGED OF Tdia-5 IN FRAME F-Main /* VI */
DO:
   RUN ttvecinos.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME Tdia-6
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Tdia-6 W-Win
ON VALUE-CHANGED OF Tdia-6 IN FRAME F-Main /* SA */
DO:
   RUN ttvecinos.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME tignore
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL tignore W-Win
ON VALUE-CHANGED OF tignore IN FRAME F-Main /* IgnDurac */
DO:
  ASSIGN {&SELF-NAME}.
  RUN ttvecinos.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME Ttodos
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Ttodos W-Win
ON VALUE-CHANGED OF Ttodos IN FRAME F-Main /* T */
DO:
  ASSIGN ttodos.
  OPEN QUERY {&SELF-NAME} FOR EACH vecino.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME ultdia
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL ultdia W-Win
ON LEAVE OF ultdia IN FRAME F-Main /* a */
DO:
  RUN ttvecinos.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL ultdia W-Win
ON MOUSE-MENU-DOWN OF ultdia IN FRAME F-Main /* a */
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


&Scoped-define BROWSE-NAME BROWSE-2
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
  DEFINE VARIABLE adm-current-page  AS INTEGER NO-UNDO.

  RUN get-attribute IN THIS-PROCEDURE ('Current-Page':U).
  ASSIGN adm-current-page = INTEGER(RETURN-VALUE).

  CASE adm-current-page: 

    WHEN 0 THEN DO:
       RUN init-object IN THIS-PROCEDURE (
             INPUT  'q-evento.w':U ,
             INPUT  FRAME F-Main:HANDLE ,
             INPUT  '':U ,
             OUTPUT h_q-evento ).
       RUN set-position IN h_q-evento ( 11.00 , 146.00 ) NO-ERROR.
       /* Size in UIB:  ( 1.86 , 8.60 ) */

    END. /* Page 0 */
    WHEN 1 THEN DO:
       RUN init-object IN THIS-PROCEDURE (
             INPUT  'v-evento.w':U ,
             INPUT  FRAME F-Main:HANDLE ,
             INPUT  'Layout = ':U ,
             OUTPUT h_v-evento-2 ).
       RUN set-position IN h_v-evento-2 ( 20.29 , 3.00 ) NO-ERROR.
       /* Size in UIB:  ( 10.67 , 143.40 ) */

       RUN init-object IN THIS-PROCEDURE (
             INPUT  'p-soloedita.w':U ,
             INPUT  FRAME F-Main:HANDLE ,
             INPUT  'Edge-Pixels = 2,
                     SmartPanelType = Update-Trans,
                     AddFunction = One-Record':U ,
             OUTPUT h_p-soloedita ).
       RUN set-position IN h_p-soloedita ( 20.29 , 148.00 ) NO-ERROR.
       RUN set-size IN h_p-soloedita ( 10.48 , 6.60 ) NO-ERROR.

       /* Links to SmartViewer h_v-evento-2. */
       RUN add-link IN adm-broker-hdl ( h_p-soloedita , 'TableIO':U , h_v-evento-2 ).
       RUN add-link IN adm-broker-hdl ( h_q-evento , 'Record':U , h_v-evento-2 ).

       /* Adjust the tab order of the smart objects. */
       RUN adjust-tab-order IN adm-broker-hdl ( h_v-evento-2 ,
             Bp2:HANDLE IN FRAME F-Main , 'AFTER':U ).
       RUN adjust-tab-order IN adm-broker-hdl ( h_p-soloedita ,
             h_v-evento-2 , 'AFTER':U ).
    END. /* Page 1 */
    WHEN 2 THEN DO:
       RUN init-object IN THIS-PROCEDURE (
             INPUT  'b-eventocli.w':U ,
             INPUT  FRAME F-Main:HANDLE ,
             INPUT  'Layout = ':U ,
             OUTPUT h_b-eventocli ).
       RUN set-position IN h_b-eventocli ( 20.52 , 3.00 ) NO-ERROR.
       RUN set-size IN h_b-eventocli ( 10.24 , 150.00 ) NO-ERROR.

       /* Links to SmartBrowser h_b-eventocli. */
       RUN add-link IN adm-broker-hdl ( h_q-evento , 'Record':U , h_b-eventocli ).

       /* Adjust the tab order of the smart objects. */
       RUN adjust-tab-order IN adm-broker-hdl ( h_b-eventocli ,
             Bp2:HANDLE IN FRAME F-Main , 'AFTER':U ).
    END. /* Page 2 */

  END CASE.
  /* Select a Startup page. */
  IF adm-current-page eq 0 
  THEN RUN select-page IN THIS-PROCEDURE ( 1 ).

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

OCXFile = SEARCH( "w-vecinosEV.wrx":U ).
IF OCXFile = ? THEN
  OCXFile = SEARCH(SUBSTRING(THIS-PROCEDURE:FILE-NAME, 1,
                     R-INDEX(THIS-PROCEDURE:FILE-NAME, ".":U), "CHARACTER":U) + "wrx":U).

IF OCXFile <> ? THEN
DO:
  ASSIGN
    chCtrlFrame = CtrlFrame:COM-HANDLE
    UIB_S = chCtrlFrame:LoadControls( OCXFile, "CtrlFrame":U)
  .
  RUN DISPATCH IN THIS-PROCEDURE("initialize-controls":U) NO-ERROR.
END.
ELSE MESSAGE "w-vecinosEV.wrx":U SKIP(1)
             "The binary control file could not be found. The controls cannot be loaded."
             VIEW-AS ALERT-BOX TITLE "Controls Not Loaded".

&ENDIF

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE creaTTgeo W-Win 
PROCEDURE creaTTgeo :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEFINE VAR ctipos AS CHAR.
DEFINE VAR kk AS INT NO-UNDO.
/*vemos cuantos tipos diferentes hay el 1 es para el buscado y los demas el resto*/
FOR EACH vecino BREAK BY vecino.cdg_tipo_evento:
    IF LAST-OF(vecino.cdg_tipo_evento) THEN
        ctipos = ctipos + "," + STRING(vecino.cdg_tipo_evento).
END.
ctipos = "OBJETIVO" + "," + SUBSTRING(ctipos,2).

EMPTY TEMP-TABLE ttgeo.
/*crear el objetivo de la busqueda*/
CREATE ttgeo.
ASSIGN ttgeolat = pgeoLAT
       ttgeolong = pgeoLONG
       tttipo = 1
       tturl = preferencia
       ttind = 0.
kk = 1.             
FOR EACH vecino BY vecino.distancia:
    FIND cliente NO-LOCK WHERE cliente.cdg_cliente =  vecino.cdg_cliente.
    FIND cliente_otros_datos OF cliente NO-LOCK NO-ERROR.
    IF vecino.geolat = 0 THEN NEXT. /*no deveria haber ninguno*/
    CREATE ttgeo.
    ASSIGN ttgeo.ttind = kk
           kk = kk + 1
           ttgeolat = vecino.geolat
           ttgeolong = vecino.geolong
           tttipo = lookup(vecino.cdg_tipo_evento,ctipos).
           tturl = limpia(Cliente.nom_cliente) +
                '<BR>Dir:' + limpia(vecino.direccion) +
                '<BR>Tipo:' + vecino.cdg_tipo_evento +
                '<BR>Evento:' + string(vecino.nro_evento) +
                '<BR>Unidades:' + (IF AVAILABLE cliente_otros_datos THEN string(cliente_otros_datos.unidad) ELSE "NO DISPONIBLE" )+
                '<BR>Operario:' + vecino.recursos +
                '<BR>Asignado:' + string(vecino.fasignado) +  ' ' +  vecino.turno. 
END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE creaTTgeo2 W-Win 
PROCEDURE creaTTgeo2 :
/*------------------------------------------------------------------------------
  Purpose:   nuestra los vecinos de ul cliente seleccionado ( pevento pasado como parametro en ROJO )
             El vecino seleccionado mostrado en AZUL y en AMARILLO todo el resto de la agenda
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEFINE VAR ctipos AS CHAR.
DEFINE VAR kk AS INT NO-UNDO.

/*vemos cuantos tipos diferentes hay el 1 es para el buscado y los demas el resto*/
EMPTY TEMP-TABLE ttgeo.
/*creo tipos de objetos en pantalla*/
FOR EACH recurso_agenda 
      WHERE  recurso_agenda.fecha = vecino.fasignado and
    can-do(  vecino.recursos , recurso_agenda.cdg_recurso ) NO-LOCK,
      EACH evento OF recurso_agenda WHERE NOT evento.anulado and
      ( evento.nro_tipo_evento = vecino.nro_tipo_evento OR ttodos ) NO-LOCK,tipo_evento OF evento BREAK BY evento.nro_tipo_evento:
     
    IF LAST-OF(evento.nro_tipo_evento) THEN
        ctipos = ctipos + "," + STRING(tipo_evento.cdg_tipo_evento).
END.
ctipos = "OBJETIVO,VECINO" + "," + SUBSTRING(ctipos,2).

/*creo objetivo*/
FIND evento WHERE evento.nro_evento = pevento NO-LOCK.
FIND cliente OF evento NO-LOCK.
FIND cliente_otros_datos OF cliente NO-LOCK NO-ERROR.
CREATE ttgeo.
ASSIGN ttgeolat = pgeoLAT
       ttgeolong = pgeoLONG
       tttipo = 1 /*objetivo*/
       ttind = 0.
       tturl = limpia(cliente.nom_cliente) +
                '<BR>Dir:' + cliente.direccion +
                '<BR>Tipo:' + tipo_evento.cdg_tipo_evento +
                '<BR>Evento:' + string(evento.nro_evento) +
                '<BR>Recursos:' + string(evento.recursos) +
                '<BR>Unidades:' + (IF AVAILABLE cliente_otros_datos THEN string(cliente_otros_datos.unidad) ELSE "NO DISPONIBLE" )+
                '<BR>Asignado:' + string(evento.fasignado) +  ' ' +  evento.turno. 
/*creo vecino seleccionado*/
FIND evento WHERE evento.nro_evento = vecino.nro_evento NO-LOCK.
FIND tipo_evento OF evento NO-LOCK.
FIND cliente OF evento NO-LOCK.
FIND cliente_otros_datos OF cliente NO-LOCK NO-ERROR.
CREATE ttgeo.
ASSIGN ttgeolat = cliente.geoLAT
       ttgeolong = cliente.geoLONG
       tttipo = 2 /*vecino*/
       ttind = 1.
       tturl = limpia(cliente.nom_cliente) +
                '<BR>Dir:' + cliente.direccion +
                '<BR>Tipo:' + tipo_evento.cdg_tipo_evento +
                '<BR>Evento:' + string(evento.nro_evento) +
                '<BR>Recursos:' + string(evento.recursos) +
                '<BR>Unidades:' + (IF AVAILABLE cliente_otros_datos THEN string(cliente_otros_datos.unidad) ELSE "NO DISPONIBLE" )+
                '<BR>Asignado:' + string(evento.fasignado) +  ' ' +  evento.turno. 
kk = 3. 
FOR EACH recurso_agenda
      WHERE  recurso_agenda.nro_evento <> evento.nro_evento and
        recurso_agenda.fecha = vecino.fasignado and
    can-do(  vecino.recursos , recurso_agenda.cdg_recurso ) NO-LOCK,
      EACH bEvento OF recurso_agenda WHERE NOT bevento.anulado and
      ( bevento.nro_tipo_evento = vecino.nro_tipo_evento OR ttodos ) NO-LOCK:
    FIND cliente OF bevento NO-LOCK.
    FIND cliente_otros_datos OF cliente NO-LOCK NO-ERROR.
    FIND tipo_evento OF bevento NO-LOCK.
            
    IF vecino.geolat = 0 THEN do:
            MESSAGE "Falta georeferencia evento:" vecino.nro_evento skip
                    "No se mostrara en el mapa" VIEW-AS ALERT-BOX ERROR. /*no deveria haber ninguno*/
            NEXT.
    END.
    CREATE ttgeo.
    ASSIGN ttgeo.ttind = kk
           kk = kk + 1
           ttgeolat = cliente.geolat
           ttgeolong = cliente.geolong
           tttipo = lookup(vecino.cdg_tipo_evento,ctipos).
           tturl = limpia(Cliente.nom_cliente) +
                '<BR>Dir:' + cliente.direccion +
                '<BR>Tipo:' + tipo_evento.cdg_tipo_evento +
                '<BR>Evento:' + string(bevento.nro_evento) +
                '<BR>Recursos:' + string(bevento.recursos) +
                '<BR>Unidades:' + (IF AVAILABLE cliente_otros_datos THEN string(cliente_otros_datos.unidad) ELSE "NO DISPONIBLE" )+
                '<BR>Asignado:' + string(bevento.fasignado) +  ' ' +  bevento.turno. 
END.
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
  DISPLAY fcdg fdirec exav Tdia-1 Tdia-2 Tdia-3 tignore v-singeo dmax pridia 
          ultdia Tdia-4 Tdia-5 Tdia-6 Tcompatibles Ttodos 
      WITH FRAME F-Main IN WINDOW W-Win.
  ENABLE fcdg fdirec BROWSE-2 BUTTON-11 exav Tdia-1 Tdia-2 Tdia-3 tignore 
         v-singeo dmax Btn_OK Btn_Cancel pridia ultdia Tdia-4 Tdia-5 Tdia-6 
         Tcompatibles BROWSE-4 Ttodos BUTTON-13 Bp1 Bp2 
      WITH FRAME F-Main IN WINDOW W-Win.
  {&OPEN-BROWSERS-IN-QUERY-F-Main}
  VIEW W-Win.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE local-destroy W-Win 
PROCEDURE local-destroy :
/*------------------------------------------------------------------------------
  Purpose:     Override standard ADM method
  Notes:       
------------------------------------------------------------------------------*/

  /* Code placed here will execute PRIOR to standard behavior. */
    IF valid-handle(h_geoTT) THEN DO:
        APPLY "Close" TO h_geoTT.
        DELETE PROCEDURE h_geoTT.
        END.
  /* Dispatch standard ADM method.                             */
  RUN dispatch IN THIS-PROCEDURE ( INPUT 'destroy':U ) .

  /* Code placed here will execute AFTER standard behavior.    */

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
   APPLY "CLOSE":U TO THIS-PROCEDURE.
   
   RETURN.
       
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE local-initialize W-Win 
PROCEDURE local-initialize :
/*------------------------------------------------------------------------------
  Purpose:     Override standard ADM method
  Notes:       
------------------------------------------------------------------------------*/
/* ptipo = 1.                                                                        */
/* FIND FIRST cliente WHERE cliente.direccion BEGINS "ROOS" AND cliente.geolat <> 0. */
/* pfmin = TODAY.                                                                    */
/* pfmax = pfmin + 4.                                                                */
/* pgeolat = cliente.geolat.                                                         */
/* pgeolong = cliente.geolong.                                                       */
/* pridia = pfmin.                                                                   */
/* ultdia = pfmax.  
                                                                 */
fdirec = pdireccion.
fcdg = pcdg_cliente.
FIND tipo_evento WHERE Tipo_evento.cdg_tipo_evento = "AV" NO-LOCK NO-ERROR.
IF AVAILABLE tipo_evento THEN 
    nro_aviso_tipo_evento = Tipo_evento.nro_tipo_evento.
FIND tipo_evento WHERE tipo_evento.nro_tipo_evento = ptipo NO-LOCK.
pcdg_tipo = tipo_evento.cdg_tipo_evento.
tcompatibles:LABEL IN FRAME {&FRAME-NAME}= "Compatible " + pcdg_tipo.
pridia = IF pfmin <> ? THEN pfmin ELSE TODAY.
ultdia = IF pfmax <> ? THEN pfmax ELSE TODAY + 7.
IF pridia < TODAY THEN do:
        pridia = TODAY.
        IF ultdia<TODAY THEN ultdia=TODAY.
END.
IF ultdia < pridia THEN DO:
    MESSAGE "El rango de fechas de la busqueda es invalido"
        VIEW-AS ALERT-BOX ERROR.
    APPLY "Close" TO THIS-PROCEDURE.
END.
  /* Code placed here will execute PRIOR to standard behavior. */

  /* Dispatch standard ADM method.                             */
  RUN dispatch IN THIS-PROCEDURE ( INPUT 'initialize':U ) .

  /* Code placed here will execute AFTER standard behavior.    */
dmax = dmaxp.
DISPLAY dmax fdirec fcdg WITH FRAME {&FRAME-NAME}.

  RUN ttvecinos.

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
  {src/adm/template/snd-list.i "recurso_agenda"}
  {src/adm/template/snd-list.i "bEvento"}
  {src/adm/template/snd-list.i "vecino"}

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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE ttvecinos W-Win 
PROCEDURE ttvecinos :
/*------------------------------------------------------------------------------
  Purpose: crea la tabla vecinos con las distancias     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEFINE VAR pgeoX AS DECIMAL NO-UNDO.
DEFINE VAR pgeoY AS DECIMAL NO-UNDO.
DEFINE VAR singeo AS INT NO-UNDO.
ASSIGN FRAME {&FRAME-NAME} pridia ultdia.
DEFINE VAR ddist AS DECIMAL NO-UNDO.
DEFINE VAR prec AS CHAR NO-UNDO.
DEF VAR dias AS CHAR NO-UNDO.
ASSIGN FRAME {&FRAME-NAME} dmax tignore tcompatibles tignore tdia-1 tdia-2 tdia-3 tdia-4 tdia-5 tdia-6 exav.
dias = "".
IF tdia-1 THEN dias = dias + "2".
IF tdia-2 THEN dias = dias + "3".
IF tdia-3 THEN dias = dias + "4".
IF tdia-4 THEN dias = dias + "5".
IF tdia-5 THEN dias = dias + "6".
IF tdia-6 THEN dias = dias + "7".
pgeoX = X(pgeolat , pgeolong).
pgeoY = Y(pgeolat , pgeolong).

EMPTY TEMP-TABLE vecino.
singeo = 0.
FOR EACH evento WHERE 
    evento.fasignado<>? AND
    NOT evento.anulado AND
    NOT evento.frealizado<>? AND
/*( evento.nro_tipo_evento = ptipo OR ptipo = ? ) AND */
    evento.fasignado >= pridia AND
    evento.fasignado <= ultdia NO-LOCK:
    IF evento.nro_tipo_evento = 10 AND exav THEN NEXT.
    IF INDEX(dias, STRING(WEEKDAY(evento.fasignado),"9")) = 0 THEN NEXT.
    FIND cliente OF evento NO-LOCK.
    IF cliente.geolat = 0 THEN do:
        singeo = singeo + 1.
        NEXT.
    END.
    ddist = distGeodesicaUTM(cliente.geoX , cliente.geoY ,
                    pgeoX,pgeoY).
    IF ddist > dmax THEN NEXT.

/*es compatible los recursos*/
    IF NOT es_compatible(IF tcompatibles THEN pcdg_tipo ELSE "*",evento.recursos) THEN NEXT.
    IF NOT tignore THEN
        prec = alcanza(evento.recursos , evento.fasignado , pdurac ).
    ELSE prec = entry( 1 , evento.recursos ).
    IF prec = "" THEN NEXT.
    FIND tipo_evento NO-LOCK WHERE tipo_evento.nro_tipo_evento = evento.nro_tipo_evento NO-ERROR.
    CREATE vecino.
    ASSIGN vecino.cdg_cliente = cliente.cdg_cliente
           vecino.nro_cliente = cliente.nro_cliente
           vecino.direccion = cliente.direccion
           vecino.nro_evento = evento.nro_evento
           vecino.geolat = cliente.geolat
           vecino.geolong = cliente.geolong
           vecino.distancia = ddist
           vecino.fasignado = evento.fasignado
           vecino.recursos = prec
           vecino.turno = evento.turno
           vecino.origen = evento.origen
           vecino.duracion = evento.durac
           vecino.cdg_tipo_evento = tipo_evento.cdg_tipo_evento WHEN AVAILABLE tipo_evento
           vecino.nro_tipo_evento = tipo_evento.nro_tipo_evento WHEN AVAILABLE tipo_evento.
END.
v-singeo:SCREEN-VALUE = string(singeo).
{&OPEN-QUERY-{&BROWSE-NAME}}
{&OPEN-QUERY-BROWSE-4}
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

/* ************************  Function Implementations ***************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION alcanza W-Win 
FUNCTION alcanza RETURNS CHAR
  ( precursos AS char,fa AS date, ddur AS INT) :
/*------------------------------------------------------------------------------
  Purpose:  Si le  a alguno de los eventos a realizar el evento solicitado
    Notes:  
------------------------------------------------------------------------------*/
DEFINE VAR kk AS INT NO-UNDO.
DEFINE VAR dispon AS INT NO-UNDO.
DEFINE VAR prec AS CHAR NO-UNDO.
DEFINE BUFFER bbevento FOR evento.
 DO kk = 1 TO NUM-ENTRIES(precursos):
      prec = ENTRY(kk,precursos).
      FIND recurso_horasxdia NO-LOCK WHERE recurso_horasxdia.cdg_recurso = prec AND 
                           recurso_horasxdia.fecha = fa NO-ERROR.
      IF NOT AVAILABLE recurso_horasxdia THEN NEXT.
      dispon = recurso_horasxdia.horas.
      FOR EACH recurso_agenda NO-LOCK WHERE recurso_agenda.fecha = fa AND recurso_agenda.cdg_recurso = prec, 
           bbevento OF recurso_agenda NO-LOCK :
                dispon = dispon - bbevento.durac.
      END.
      IF dispon > ddur THEN RETURN recurso_habilidad.cdg_recurso.
 END.

  RETURN "".   /* Function return value. */

END FUNCTION.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION cdg_tip W-Win 
FUNCTION cdg_tip RETURNS CHARACTER
  ( ) :
/*------------------------------------------------------------------------------
  Purpose:  
    Notes:  
------------------------------------------------------------------------------*/
FIND tipo_evento OF bevento NO-LOCK NO-ERROR.
RETURN IF AVAILABLE tipo_evento THEN tipo_evento.cdg_tipo_evento ELSE "".   
END FUNCTION.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION direccion W-Win 
FUNCTION direccion RETURNS CHARACTER
  ( /* parameter-definitions */ ) :
/*------------------------------------------------------------------------------
  Purpose:  
    Notes:  
------------------------------------------------------------------------------*/
FIND cliente OF bevento NO-LOCK NO-ERROR.
  RETURN IF AVAILABLE cliente THEN cliente.direccion ELSE "".   

END FUNCTION.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION durdia W-Win 
FUNCTION durdia RETURNS INT64
  ( pcdg_recurso AS char, ff AS DATE ) :
/*------------------------------------------------------------------------------
  Purpose:  suma de las dureciones de los eventos a efectuar en el dia
    Notes:  
------------------------------------------------------------------------------*/
  DEFINE VAR suma AS INT.
  FOR EACH recurso_agenda WHERE recurso_agenda.cdg_recurso = pcdg_recurso AND recurso_agenda.fecha = ff NO-LOCK:
    FIND evento OF recurso_agenda NO-LOCK NO-ERROR.
    IF AVAILABLE evento THEN
      suma = suma + evento.durac.
  END.
  RETURN suma.   /* Function return value. */

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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION es_compatible W-Win 
FUNCTION es_compatible RETURNS LOGICAL
( cdg_tipo AS CHAR , precursos AS CHAR ) :

/*------------------------------------------------------------------------------
  Purpose: Ver si es compatible al menos unos de los recursos con el ptipo solicitado
    Notes: Esta directamente relacionado con la aptitud del recurso 
------------------------------------------------------------------------------*/
 DEFINE VAR kk AS INT NO-UNDO.
 DO kk = 1 TO NUM-ENTRIES(precursos):
    FOR EACH recurso_habilidad NO-LOCK WHERE recurso_habilidad.cdg_recurso = ENTRY(kk,precursos), 
         FIRST tipo_evento NO-LOCK WHERE tipo_evento.nro_tipo_evento = recurso_habilidad.nro_tipo_evento :
        IF can-do(cdg_tipo,tipo_evento.cdg_tipo_evento) THEN RETURN TRUE.
    END.
 END.
RETURN FALSE.
END FUNCTION.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION limpia W-Win 
FUNCTION limpia RETURNS CHARACTER
  ( INPUT aa AS CHARACTER ) :
/*------------------------------------------------------------------------------
  Purpose: limpia de caractener " y ' a la string pasada 
    Notes:  
------------------------------------------------------------------------------*/
           aa = REPLACE( aa,'"','').
           aa = REPLACE( aa,"'","").
  RETURN aa.   /* Function return value. */

END FUNCTION.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION ocupado W-Win 
FUNCTION ocupado RETURNS INTEGER
  ( prec AS CHAR , fa AS DATE ) :
/*------------------------------------------------------------------------------
  Purpose:  
    Notes:  
------------------------------------------------------------------------------*/
DEFINE VAR k AS INT NO-UNDO.
FOR EACH recurso_agenda WHERE recurso_agenda.cdg_recurso = prec AND 
    recurso_agenda.fecha = fa NO-LOCK:
    FIND evento OF recurso_agenda NO-LOCK.
    k = k + evento.durac.
END.
  RETURN k.   /* Function return value. */

END FUNCTION.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION rdur W-Win 
FUNCTION rdur RETURNS INTEGER
  ( rr AS INT ) :
/*------------------------------------------------------------------------------
  Purpose:  Duracion media
    Notes:  Se tiene en cuenta de descartar valores  alejados +- 20% de la media
------------------------------------------------------------------------------*/
DEFINE VAR kk AS INT NO-UNDO.
DEFINE VAR pp1 AS INT NO-UNDO.
DEFINE VAR media AS INT NO-UNDO.
DEFINE VAR suma AS INT NO-UNDO.
DEFINE VAR pp AS INT INITIAL 5 NO-UNDO. /*cantidad de periodos maximos de analisis*/
DEFINE BUFFER bevento FOR evento.
DEFINE BUFFER weve FOR evento.
pp1 = 0.
suma = 0.
FIND weve WHERE weve.NRO_EVENTO = rr NO-LOCK.
CASE weve.origen:
WHEN "CONTRATO" THEN DO:
    FOR EACH bevento NO-LOCK WHERE bevento.origen = weve.origen AND 
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
        FOR EACH bevento NO-LOCK WHERE bevento.origen = weve.origen AND 
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
WHEN "COBRANZA" THEN DO:
    FOR EACH bevento NO-LOCK WHERE bevento.nro_cliente = weve.nro_cliente AND 
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
        FOR EACH bevento NO-LOCK WHERE bevento.nro_cliente = weve.nro_cliente AND 
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
OTHERWISE RETURN ?.
END.
END FUNCTION.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION unidades W-Win 
FUNCTION unidades RETURNS INTEGER
  ( pnro AS INT ) :
/*------------------------------------------------------------------------------
  Purpose:  
    Notes:  
------------------------------------------------------------------------------*/
  FIND cliente_otros_datos WHERE cliente_otros_datos.nro_cliente = pnro NO-LOCK NO-ERROR.
  IF AVAILABLE cliente_otros_datos THEN RETURN cliente_otros_datos.unidades.
  RETURN ?.

END FUNCTION.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

