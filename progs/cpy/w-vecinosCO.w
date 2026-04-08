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
{extrae.i}
DEFINE INPUT PARAMETER pnro AS INT.
DEFINE INPUT PARAMETER pet AS CHAR NO-UNDO.
DEFINE INPUT PARAMETER dmaxp AS INT.
DEFINE INPUT PARAMETER caller AS HANDLE.
DEFINE INPUT PARAMETER ppridia AS DATE. 
DEFINE INPUT PARAMETER pultdia AS DATE. 
DEFINE INPUT PARAMETER phh_min AS CHARACTER.
DEFINE INPUT PARAMETER phh_max AS CHARACTER.

DEFINE TEMP-TABLE vecino
    FIELD xnro LIKE evento.nro_evento
    FIELD xtipo AS CHAR FORMAT "X"
    FIELD cdg_cliente LIKE cliente.cdg_cliente
    FIELD direccion LIKE cliente.direccion
    FIELD nom_cliente LIKE cliente.nom_cliente
    FIELD distancia AS DECIMAL
    FIELD fasignado LIKE evento.fasignado
    FIELD recursos LIKE evento.recursos
    FIELD horario AS CHAR FORMAT "x(11)"
    FIELD fmin AS DATE LABEL "Fmin"
    FIELD fmax AS DATE LABEL "Fmax"
    FIELD geolat AS DECIMAL
    FIELD duracion LIKE evento.durac COLUMN-LABEL "DUR" FORMAT ">>9"
    FIELD geolong AS DECIMAL
    FIELD origen LIKE evento.origen
    FIELD cdg_tipo LIKE tipo_evento.cdg_tipo_evento
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
DEFINE VAR cdg_tipos LIKE tipo_evento.cdg_tipo_evento NO-UNDO.
DEFINE VAR direccion LIKE cliente.direccion NO-UNDO.
{restricciones.i}
{tiempo.i}
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
&Scoped-define INTERNAL-TABLES vecino recurso_agenda bEvento Cliente

/* Definitions for BROWSE BROWSE-2                                      */
&Scoped-define FIELDS-IN-QUERY-BROWSE-2 vecino.xtipo vecino.xnro vecino.cdg_cliente vecino.direccion vecino.distancia vecino.fasignado vecino.recursos vecino.duracion ocupado(vecino.xtipo,vecino.xnro) @ ocupado vecino.horario vecino.fmin vecino.fmax vecino.nom_cliente restcli(vecino.cdg_cliente)@ comprest   
&Scoped-define ENABLED-FIELDS-IN-QUERY-BROWSE-2   
&Scoped-define SELF-NAME BROWSE-2
&Scoped-define QUERY-STRING-BROWSE-2 FOR EACH vecino
&Scoped-define OPEN-QUERY-BROWSE-2 OPEN QUERY {&SELF-NAME} FOR EACH vecino.
&Scoped-define TABLES-IN-QUERY-BROWSE-2 vecino
&Scoped-define FIRST-TABLE-IN-QUERY-BROWSE-2 vecino


/* Definitions for BROWSE BROWSE-4                                      */
&Scoped-define FIELDS-IN-QUERY-BROWSE-4 bevento.recursos cdg_tipos() @ cdg_tipos bevento.origen bevento.nro_identificacion direccion() @ direccion bevento.sub_evento bevento.turno bevento.duracion bevento.fasignado bevento.frealizado perant(bevento.nro_evento) @ perant bevento.hora_desde bevento.hora_hasta comprest(bevento.nro_evento)@ comprest bevento.nro_evento bevento.nro_evento_padre bevento.mobs bevento.observacion bevento.reminder bevento.fmin bevento.fmax   
&Scoped-define ENABLED-FIELDS-IN-QUERY-BROWSE-4   
&Scoped-define SELF-NAME BROWSE-4
&Scoped-define QUERY-STRING-BROWSE-4 FOR EACH recurso_agenda NO-LOCK       WHERE  recurso_agenda.fecha = vecino.fasignado and     can-do(  vecino.recursos , ~
       recurso_agenda.cdg_recurso ) , ~
             EACH bEvento  NO-LOCK OF recurso_agenda WHERE NOT bevento.anulado INDEXED-REPOSITION
&Scoped-define OPEN-QUERY-BROWSE-4 OPEN QUERY {&SELF-NAME} FOR EACH recurso_agenda NO-LOCK       WHERE  recurso_agenda.fecha = vecino.fasignado and     can-do(  vecino.recursos , ~
       recurso_agenda.cdg_recurso ) , ~
             EACH bEvento  NO-LOCK OF recurso_agenda WHERE NOT bevento.anulado INDEXED-REPOSITION.
&Scoped-define TABLES-IN-QUERY-BROWSE-4 recurso_agenda bEvento
&Scoped-define FIRST-TABLE-IN-QUERY-BROWSE-4 recurso_agenda
&Scoped-define SECOND-TABLE-IN-QUERY-BROWSE-4 bEvento


/* Definitions for FRAME F-Main                                         */
&Scoped-define OPEN-BROWSERS-IN-QUERY-F-Main ~
    ~{&OPEN-QUERY-BROWSE-2}~
    ~{&OPEN-QUERY-BROWSE-4}
&Scoped-define QUERY-STRING-F-Main FOR EACH Cliente SHARE-LOCK
&Scoped-define OPEN-QUERY-F-Main OPEN QUERY F-Main FOR EACH Cliente SHARE-LOCK.
&Scoped-define TABLES-IN-QUERY-F-Main Cliente
&Scoped-define FIRST-TABLE-IN-QUERY-F-Main Cliente


/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS fcdg fdirec BROWSE-2 BUTTON-11 BUTTON-14 ~
cnom_cliente crest Ttarea dmax Btn_OK Btn_Cancel pridia ultdia hh_min ~
hh_max Tnoasig BROWSE-4 BUTTON-13 Bp1 Bp2 
&Scoped-Define DISPLAYED-OBJECTS fcdg fdirec cnom_cliente crest Ttarea ~
v-singeo dmax pridia ultdia hh_min hh_max Tnoasig 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME


/* ************************  Function Prototypes ********************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION-FORWARD cdg_tipos W-Win 
FUNCTION cdg_tipos RETURNS CHARACTER
  ( /* parameter-definitions */ )  FORWARD.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION-FORWARD direccion W-Win 
FUNCTION direccion RETURNS CHARACTER
  ( /* parameter-definitions */ )  FORWARD.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION-FORWARD limpia W-Win 
FUNCTION limpia RETURNS CHARACTER
  ( INPUT aa AS CHARACTER )  FORWARD.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION-FORWARD ocupado W-Win 
FUNCTION ocupado RETURNS INTEGER
  ( xtipo AS char, nro AS INT )  FORWARD.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION-FORWARD tope W-Win 
FUNCTION tope RETURNS LOGICAL
  ( /* parameter-definitions */ ) FORWARD.

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
     SIZE 5 BY 1.19 TOOLTIP "Evento detalle del evento".

DEFINE BUTTON Bp2 
     LABEL "HIS" 
     SIZE 5 BY 1.19 TOOLTIP "Historia de los eventos del cliente".

DEFINE BUTTON Btn_Cancel AUTO-END-KEY 
     LABEL "Cancel" 
     SIZE 9 BY 1
     BGCOLOR 8 .

DEFINE BUTTON Btn_OK AUTO-GO 
     LABEL "OK" 
     SIZE 5.6 BY 1
     BGCOLOR 8 .

DEFINE BUTTON BUTTON-11 
     IMAGE-UP FILE "C:/Dynasys10/progs/img/earth_location.jpg":U
     LABEL "b-geocli" 
     SIZE 5 BY 6.67.

DEFINE BUTTON BUTTON-13 
     IMAGE-UP FILE "C:/Dynasys10/progs/img/earth_location.jpg":U
     LABEL "b-geocli" 
     SIZE 5 BY 1.29.

DEFINE BUTTON BUTTON-14 
     IMAGE-UP FILE "excel.gif":U
     LABEL "Btn 14" 
     SIZE 5 BY 1.

DEFINE VARIABLE cnom_cliente AS CHARACTER FORMAT "X(40)" 
     VIEW-AS FILL-IN 
     SIZE 62 BY 1
     BGCOLOR 14  NO-UNDO.

DEFINE VARIABLE crest AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 67.4 BY 1
     BGCOLOR 14  NO-UNDO.

DEFINE VARIABLE dmax AS DECIMAL FORMAT ">>,>>9":U INITIAL 1000 
     LABEL "Dmax" 
     VIEW-AS FILL-IN 
     SIZE 9 BY 1 TOOLTIP "Distancia maxima en metros" NO-UNDO.

DEFINE VARIABLE fcdg AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN NATIVE 
     SIZE 14 BY 1 TOOLTIP "Codigo de cliente buscado."
     BGCOLOR 11  NO-UNDO.

DEFINE VARIABLE fdirec AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN NATIVE 
     SIZE 129 BY 1 TOOLTIP "Direccion Buscada"
     BGCOLOR 11  NO-UNDO.

DEFINE VARIABLE hh_max AS CHARACTER FORMAT "X(5)":U 
     LABEL "a" 
     VIEW-AS FILL-IN 
     SIZE 13 BY 1 TOOLTIP "Hora de finalizacion de la atencion" NO-UNDO.

DEFINE VARIABLE hh_min AS CHARACTER FORMAT "X(5)":U 
     LABEL "del" 
     VIEW-AS FILL-IN 
     SIZE 12 BY 1 TOOLTIP "Hora de inicio de atencion" NO-UNDO.

DEFINE VARIABLE pridia AS DATE FORMAT "99/99/9999":U 
     LABEL "del" 
     VIEW-AS FILL-IN 
     SIZE 15.6 BY 1 NO-UNDO.

DEFINE VARIABLE ultdia AS DATE FORMAT "99/99/9999":U 
     LABEL "a" 
     VIEW-AS FILL-IN 
     SIZE 15.2 BY 1 NO-UNDO.

DEFINE VARIABLE v-singeo AS CHARACTER FORMAT "X(256)":U 
     LABEL "SG" 
     VIEW-AS FILL-IN 
     SIZE 6.2 BY 1 TOOLTIP "Sin geocodificar ( posibles errores en los datos)" NO-UNDO.

DEFINE VARIABLE Tnoasig AS LOGICAL INITIAL no 
     LABEL "Ev noAsig" 
     VIEW-AS TOGGLE-BOX
     SIZE 13.4 BY .81 NO-UNDO.

DEFINE VARIABLE Ttarea AS LOGICAL INITIAL no 
     LABEL "Tarea" 
     VIEW-AS TOGGLE-BOX
     SIZE 13.4 BY .81 NO-UNDO.

/* Query definitions                                                    */
&ANALYZE-SUSPEND
DEFINE QUERY BROWSE-2 FOR 
      vecino SCROLLING.

DEFINE QUERY BROWSE-4 FOR 
      recurso_agenda, 
      bEvento SCROLLING.

DEFINE QUERY F-Main FOR 
      Cliente SCROLLING.
&ANALYZE-RESUME

/* Browse definitions                                                   */
DEFINE BROWSE BROWSE-2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS BROWSE-2 W-Win _FREEFORM
  QUERY BROWSE-2 NO-LOCK DISPLAY
      vecino.xtipo COLUMN-LABEL "T" 
    vecino.xnro COLUMN-LABEL "Nro" 
    vecino.cdg_cliente 
    vecino.direccion 
    vecino.distancia COLUMN-LABEL "Dist.![mtrs]"
    vecino.fasignado 
    vecino.recursos 
    vecino.duracion 
    ocupado(vecino.xtipo,vecino.xnro) @ ocupado COLUMN-LABEL "OCUP"
    vecino.horario COLUMN-LABEL "Horario"
    vecino.fmin
    vecino.fmax
    vecino.nom_cliente
    restcli(vecino.cdg_cliente)@ comprest
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ROW-MARKERS SEPARATORS SIZE 141 BY 6.91 FIT-LAST-COLUMN.

DEFINE BROWSE BROWSE-4
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS BROWSE-4 W-Win _FREEFORM
  QUERY BROWSE-4 NO-LOCK DISPLAY
      bevento.recursos
          cdg_tipos() @ cdg_tipos
          bevento.origen
          bevento.nro_identificacion
          direccion() @ direccion
          bevento.sub_evento
          bevento.turno FORMAT "XX" COLUMN-LABEL "TU"
          bevento.duracion FORMAT ">>9" COLUMN-LABEL "DUR"
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
    WITH NO-ROW-MARKERS SEPARATORS SIZE 141 BY 6.71
         TITLE "Agenda de los recursos" ROW-HEIGHT-CHARS .62 FIT-LAST-COLUMN.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME F-Main
     fcdg AT ROW 1.1 COL 1 COLON-ALIGNED NO-LABEL WIDGET-ID 110
     fdirec AT ROW 1.1 COL 16 COLON-ALIGNED NO-LABEL WIDGET-ID 112
     BROWSE-2 AT ROW 2.19 COL 3.2 WIDGET-ID 200
     BUTTON-11 AT ROW 2.43 COL 146 WIDGET-ID 36
     BUTTON-14 AT ROW 9.1 COL 134.2 WIDGET-ID 106
     cnom_cliente AT ROW 9.19 COL 1.2 COLON-ALIGNED HELP
          "Razon Social del cliente" NO-LABEL WIDGET-ID 104
     crest AT ROW 9.19 COL 64.2 COLON-ALIGNED NO-LABEL WIDGET-ID 6
     Ttarea AT ROW 10.1 COL 128.6 WIDGET-ID 98
     v-singeo AT ROW 10.29 COL 4.2 COLON-ALIGNED WIDGET-ID 92
     dmax AT ROW 10.29 COL 17.6 COLON-ALIGNED WIDGET-ID 86
     Btn_OK AT ROW 10.29 COL 30 WIDGET-ID 84
     Btn_Cancel AT ROW 10.29 COL 36 WIDGET-ID 80
     pridia AT ROW 10.29 COL 48.2 COLON-ALIGNED WIDGET-ID 74
     ultdia AT ROW 10.29 COL 66.4 COLON-ALIGNED WIDGET-ID 76
     hh_min AT ROW 10.29 COL 97 COLON-ALIGNED WIDGET-ID 94
     hh_max AT ROW 10.29 COL 112 COLON-ALIGNED WIDGET-ID 96
     Tnoasig AT ROW 10.71 COL 128.6 WIDGET-ID 102
     BROWSE-4 AT ROW 11.48 COL 3.2 WIDGET-ID 300
     BUTTON-13 AT ROW 13.48 COL 145.6 WIDGET-ID 88
     Bp1 AT ROW 14.86 COL 145.6 WIDGET-ID 40
     Bp2 AT ROW 16.05 COL 145.6 WIDGET-ID 42
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 154.4 BY 28.71 WIDGET-ID 100.


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
         TITLE              = "Tareas/Eventos Vecinos en el Rango de Fechas"
         HEIGHT             = 29.71
         WIDTH              = 155.4
         MAX-HEIGHT         = 30.86
         MAX-WIDTH          = 179.6
         VIRTUAL-HEIGHT     = 30.86
         VIRTUAL-WIDTH      = 179.6
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
/* BROWSE-TAB BROWSE-4 Tnoasig F-Main */
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

/* SETTINGS FOR FILL-IN v-singeo IN FRAME F-Main
   NO-ENABLE                                                            */
ASSIGN 
       v-singeo:READ-ONLY IN FRAME F-Main        = TRUE.

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
OPEN QUERY {&SELF-NAME} FOR EACH recurso_agenda NO-LOCK
      WHERE  recurso_agenda.fecha = vecino.fasignado and
    can-do(  vecino.recursos , recurso_agenda.cdg_recurso ) ,
      EACH bEvento  NO-LOCK OF recurso_agenda WHERE NOT bevento.anulado INDEXED-REPOSITION.
     _END_FREEFORM
     _Options          = "NO-LOCK INDEXED-REPOSITION"
     _TblOptList       = ","
     _Where[1]         = "can-do( recurso_agenda.cdg_recurso  ) and recurso_agenda.fecha = vecino.fasignado"
     _Query            is OPENED
*/  /* BROWSE BROWSE-4 */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _QUERY-BLOCK FRAME F-Main
/* Query rebuild information for FRAME F-Main
     _TblList          = "sic.Cliente"
     _Query            is OPENED
*/  /* FRAME F-Main */
&ANALYZE-RESUME

 


/* **********************  Create OCX Containers  ********************** */

&ANALYZE-SUSPEND _CREATE-DYNAMIC

&IF "{&OPSYS}" = "WIN32":U AND "{&WINDOW-SYSTEM}" NE "TTY":U &THEN

CREATE CONTROL-FRAME CtrlFrame ASSIGN
       FRAME           = FRAME F-Main:HANDLE
       ROW             = 10.29
       COLUMN          = 85.8
       HEIGHT          = 1.05
       WIDTH           = 8
       WIDGET-ID       = 108
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
ON END-ERROR OF W-Win /* Tareas/Eventos Vecinos en el Rango de Fechas */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL W-Win W-Win
ON WINDOW-CLOSE OF W-Win /* Tareas/Eventos Vecinos en el Rango de Fechas */
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
ON MOUSE-SELECT-DBLCLICK OF BROWSE-2 IN FRAME F-Main
DO:
  nelegido = IF AVAILABLE vecino THEN vecino.xnro ELSE ?. 
   IF VALID-HANDLE(caller) THEN                                  
    DYNAMIC-FUNCTION("felegido" In caller , nelegido ).
    APPLY "CLOSE":U TO THIS-PROCEDURE.
    RETURN NO-APPLY.         
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL BROWSE-2 W-Win
ON VALUE-CHANGED OF BROWSE-2 IN FRAME F-Main
DO:
    {&OPEN-QUERY-BROWSE-4}
     DISPLAY nom_cliente @ cnom_cliente 
             restcli(vecino.cdg_cliente) @ crest WITH FRAME {&FRAME-NAME}.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define BROWSE-NAME BROWSE-4
&Scoped-define SELF-NAME BROWSE-4
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


&Scoped-define SELF-NAME Btn_Cancel
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Btn_Cancel W-Win
ON CHOOSE OF Btn_Cancel IN FRAME F-Main /* Cancel */
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
   nelegido = IF AVAILABLE vecino THEN vecino.xnro ELSE ?. 
   IF VALID-HANDLE(caller) THEN                                  
    DYNAMIC-FUNCTION("felegido" In caller , nelegido ).         
/*   APPLY "Close" TO THIS-PROCEDURE.                              */
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


&Scoped-define SELF-NAME BUTTON-14
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL BUTTON-14 W-Win
ON CHOOSE OF BUTTON-14 IN FRAME F-Main /* Btn 14 */
DO:
  RUN aexcel ( BROWSE-2:HANDLE IN FRAME {&FRAME-NAME} ).
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


&Scoped-define SELF-NAME hh_max
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL hh_max W-Win
ON LEAVE OF hh_max IN FRAME F-Main /* a */
DO:
     SELF:SCREEN-VALUE= ajuh(SELF:SCREEN-VALUE).
     RUN ttvecinos.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME hh_min
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL hh_min W-Win
ON LEAVE OF hh_min IN FRAME F-Main /* del */
DO:
     SELF:SCREEN-VALUE= ajuh(SELF:SCREEN-VALUE).
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


&Scoped-define SELF-NAME Tnoasig
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Tnoasig W-Win
ON VALUE-CHANGED OF Tnoasig IN FRAME F-Main /* Ev noAsig */
DO:
  ASSIGN tnoasig.
  RUN ttvecinos.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME Ttarea
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Ttarea W-Win
ON VALUE-CHANGED OF Ttarea IN FRAME F-Main /* Tarea */
DO:
   ASSIGN ttarea.
   RUN ttvecinos.
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
       RUN set-position IN h_q-evento ( 9.33 , 141.20 ) NO-ERROR.
       /* Size in UIB:  ( 1.86 , 7.80 ) */

    END. /* Page 0 */
    WHEN 1 THEN DO:
       RUN init-object IN THIS-PROCEDURE (
             INPUT  'p-soloedita.w':U ,
             INPUT  FRAME F-Main:HANDLE ,
             INPUT  'Edge-Pixels = 2,
                     SmartPanelType = Update-Trans,
                     AddFunction = One-Record':U ,
             OUTPUT h_p-soloedita ).
       RUN set-position IN h_p-soloedita ( 18.52 , 146.60 ) NO-ERROR.
       RUN set-size IN h_p-soloedita ( 10.29 , 6.40 ) NO-ERROR.

       RUN init-object IN THIS-PROCEDURE (
             INPUT  'v-evento.w':U ,
             INPUT  FRAME F-Main:HANDLE ,
             INPUT  'Layout = ':U ,
             OUTPUT h_v-evento-2 ).
       RUN set-position IN h_v-evento-2 ( 18.57 , 2.00 ) NO-ERROR.
       /* Size in UIB:  ( 10.67 , 143.40 ) */

       /* Links to SmartViewer h_v-evento-2. */
       RUN add-link IN adm-broker-hdl ( h_p-soloedita , 'TableIO':U , h_v-evento-2 ).
       RUN add-link IN adm-broker-hdl ( h_q-evento , 'Record':U , h_v-evento-2 ).

       /* Adjust the tab order of the smart objects. */
       RUN adjust-tab-order IN adm-broker-hdl ( h_p-soloedita ,
             Bp2:HANDLE IN FRAME F-Main , 'AFTER':U ).
       RUN adjust-tab-order IN adm-broker-hdl ( h_v-evento-2 ,
             h_p-soloedita , 'AFTER':U ).
    END. /* Page 1 */
    WHEN 2 THEN DO:
       RUN init-object IN THIS-PROCEDURE (
             INPUT  'b-eventocli.w':U ,
             INPUT  FRAME F-Main:HANDLE ,
             INPUT  'Layout = ':U ,
             OUTPUT h_b-eventocli ).
       RUN set-position IN h_b-eventocli ( 20.14 , 2.00 ) NO-ERROR.
       RUN set-size IN h_b-eventocli ( 9.57 , 142.00 ) NO-ERROR.

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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE aexcel W-Win 
PROCEDURE aexcel :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

   def input parameter p-browse as handle no-undo.
   def var h-excel as com-handle no-undo.
   def var h-book as com-handle no-undo.
   def var h-sheet as com-handle no-undo.
   def var v-item as char no-undo.
   def var v-alpha as char extent 52 no-undo init ["A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","x","y","Z","AA","AB","AC","AD","AE","AF","AG","AH","AI","AJ","AK","AL","AM","AN","AO","AP","AQ","AR","AS","AT","AU","AV","AW","Ax","Ay","AZ"].
   def var i as int no-undo.
   def var v-line as int no-undo.
   def var v-qu as log no-undo.
   def var v-handle as handle no-undo.
   DEF VAR opt AS LOGICAL NO-UNDO.
   v-qu = session:set-wait-state("General").
   CREATE "Excel.Application" h-Excel.
   h-book = h-Excel:Workbooks:Add().
   h-Sheet = h-Excel:Sheets:Item(1).
   
   do i = 1 to p-browse:num-columns:
      v-handle = p-browse:get-browse-column(i).
      v-item = v-alpha[i] + "1".
      h-sheet:range(v-item):value = v-handle:label.
   end.
   v-line = 1.
   sacar_excel:
   repeat:
      READKEY PAUSE 0.
      IF LASTKEY = 27 THEN DO:
          MESSAGE "Quiere cancelar la emision del excel" VIEW-AS ALERT-BOX QUESTION BUTTONS YES-NO SET opt.
          IF opt THEN DO:
              LEAVE sacar_excel.
          END.
              
      END.
      if v-line = 1 then 
         v-qu = p-browse:select-row(1).
      else v-qu = p-browse:select-next-row().
      if v-qu = no then leave.
      v-line = v-line + 1.
      do i = 1 to p-browse:num-columns:
          READKEY PAUSE 0.
          IF LASTKEY = 27 THEN DO:
              MESSAGE "Quiere cancelar la emision del excel" VIEW-AS ALERT-BOX QUESTION BUTTONS YES-NO SET opt.
              IF opt THEN DO:
                  LEAVE sacar_excel.
              END.
          END.
         v-handle = p-browse:get-browse-column(i).
         v-item = v-alpha[i] + string(v-line).
         if v-handle:data-type begins "dec" then assign
            h-sheet:range(v-item):value = dec(v-handle:screen-value)
            h-sheet:range(v-item):Numberformat = "########0.00"
            h-sheet:range(v-item):HorizontalAlignment = -4152.
         else if v-handle:data-type begins "int" then assign
            h-sheet:range(v-item):value = int(v-handle:screen-value)
            h-sheet:range(v-item):Numberformat = "########0"
            h-sheet:range(v-item):HorizontalAlignment = -4152.
         ELSE IF v-handle:data-type begins "date" then assign 
            h-sheet:range(v-item):value = substring(v-handle:screen-value,4,2) + "/" + substring(v-handle:screen-value,1,2) + "/" + substring(v-handle:screen-value,7,4).
            
         else h-sheet:range(v-item):value = v-handle:screen-value.
end.
   end.

   do i = 1 to p-browse:num-columns:
      v-qu = h-sheet:Columns(i):AutoFit.
   end.
   h-excel:visible = yes.
   release object h-sheet no-error.
   release object h-book no-error.
   release object h-excel no-error.
   v-qu = session:set-wait-state("").
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

OCXFile = SEARCH( "w-vecinosCO.wrx":U ).
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
ELSE MESSAGE "w-vecinosCO.wrx":U SKIP(1)
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
DEFINE VAR rr AS INT NO-UNDO.
/*vemos cuantos tipos diferentes hay el 1 es para el buscado y los demas el resto*/
ctipos = "OBJETIVO,TAREA,EVENTO".
EMPTY TEMP-TABLE ttgeo.
/*crear el objetivo de la busqueda*/
IF pet = "T" THEN DO:
    FIND tarea WHERE tarea.nro_tarea = pnro NO-LOCK.
    FIND cliente OF tarea NO-LOCK.
END.
ELSE DO:
    FIND evento WHERE evento.nro_evento = pnro NO-LOCK.
    FIND cliente OF evento NO-LOCK.
END.


rr = cliente.nro_cliente.
CREATE ttgeo.
ASSIGN ttgeolat = cliente.geolat
       ttgeolong = cliente.geolong
       tttipo = 1
       tturl =  limpia(Cliente.nom_cliente) +
                '<BR>Dir:' + limpia(Cliente.direccion) +
                IF pet = "T" THEN '<BR>Tarea:' + string(pnro) ELSE '<BR>Evento:' + string(pnro) /*+
                '<BR>Horario:' + vecino.horario */
       ttind = 0.
       /*restricciones*/
       FOR EACH cliente_restriccion OF cliente , restriccion OF cliente_restriccion:
       tturl = tturl + '<BR>' + restriccion.cdg_restriccion + ':' + limpia(cliente_restriccion.valor).
       END.
kk = 1.             
FOR EACH vecino BY vecino.distancia:
    FIND cliente WHERE cliente.cdg_cliente =  vecino.cdg_cliente.
    IF cliente.nro_cliente = rr THEN NEXT.
    IF vecino.geolat = 0 THEN NEXT. /*no deveria haber ninguno*/
    CREATE ttgeo.
    ASSIGN ttgeo.ttind = kk
           kk = kk + 1
           ttgeolat = vecino.geolat
           ttgeolong = vecino.geolong
           tttipo = IF vecino.xtipo = "T" THEN 2 ELSE 3.
           tturl = limpia(vecino.nom_cliente) +
                '<BR>Dir:' + limpia(vecino.direccion) +
                '<BR>' + (IF vecino.xtipo = "T" THEN "Tarea:" ELSE "Evento:" ) + string(vecino.xnro) +
                IF vecino.recursos <> ? THEN '<BR>Operario:' + vecino.recursos ELSE '' +
                IF vecino.fasignado <> ? THEN '<BR>Asignado:' + string(vecino.fasignado) ELSE ''/*+ 
                '<BR>Horario:' + vecino.horario*/ . 
       /*restricciones*/
       FOR EACH cliente_restriccion OF cliente , restriccion OF cliente_restriccion:
       tturl = tturl + '<BR>' + restriccion.cdg_restriccion + ':' + limpia(cliente_restriccion.valor).
       END.
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

  {&OPEN-QUERY-F-Main}
  GET FIRST F-Main.
  DISPLAY fcdg fdirec cnom_cliente crest Ttarea v-singeo dmax pridia ultdia 
          hh_min hh_max Tnoasig 
      WITH FRAME F-Main IN WINDOW W-Win.
  ENABLE fcdg fdirec BROWSE-2 BUTTON-11 BUTTON-14 cnom_cliente crest Ttarea 
         dmax Btn_OK Btn_Cancel pridia ultdia hh_min hh_max Tnoasig BROWSE-4 
         BUTTON-13 Bp1 Bp2 
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
IF pet = "T" THEN DO:
  FIND tarea WHERE tarea.nro_tarea = pnro NO-LOCK.
  /*pridia = IF extrae("fmin",tarea.dato) <> ? THEN date(extrae("fmin",tarea.dato)) ELSE TODAY.
  ultdia = IF extrae("fmax",tarea.dato) <> ? THEN date(extrae("fmax",tarea.dato)) ELSE TODAY + 7.*/
   pridia = IF ppridia <> ? THEN ppridia ELSE TODAY.
  ultdia = IF pultdia <> ? THEN pultdia ELSE TODAY + 7.

  /*hh_min = IF tarea.hora_prevista <> ? THEN ajuh( tarea.hora_prevista ) ELSE "09:00".
  hh_max = IF extrae("hora_fin",tarea.dato) <> ? THEN ajuh(extrae("hora_fin",tarea.dato)) ELSE "12:30".*/
  hh_min = IF phh_min <> ? THEN ajuh( phh_min ) ELSE "09:00".
  hh_max = IF phh_max <> ? THEN ajuh( phh_max ) ELSE "12:30".

  FIND cliente OF tarea NO-LOCK NO-ERROR.
  IF AVAILABLE cliente THEN 
    fcdg = cliente.cdg_cliente.
  ELSE
    fcdg = ?.
  fdirec = tarea.direccion.
END.
ELSE DO:
  FIND evento WHERE evento.nro_evento = pnro NO-LOCK.
  pridia = evento.fmin.
  ultdia = evento.fmax.
  hh_min = ajuh(evento.hora_desde).
  hh_max = ajuh(evento.hora_hasta).
  FIND cliente OF evento NO-LOCK.
  fcdg = cliente.cdg_cliente.
  fdirec = cliente.direccion.
END.

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
DISPLAY dmax WITH FRAME {&FRAME-NAME}.
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
  {src/adm/template/snd-list.i "Cliente"}

  /* Deal with any unexpected table requests before closing.           */
  {src/adm/template/snd-end.i}

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
DEFINE VAR hmin AS DECIMAL NO-UNDO.
DEFINE VAR hmax AS DECIMAL NO-UNDO.

ASSIGN FRAME {&FRAME-NAME} dmax pridia ultdia hh_min hh_max.
hmin = ahdec( aint( hh_min )).
hmax = ahdec( aint( hh_max )).
IF pet = "T" THEN DO:
    FIND tarea WHERE cdg_sitio = "" AND tarea.nro_tarea = pnro NO-LOCK.
    FIND cliente OF tarea NO-LOCK.
END.
ELSE DO:
    FIND evento WHERE evento.nro_evento = pnro NO-LOCK.
    FIND cliente OF evento NO-LOCK.
END.
pgeoX = X(cliente.geolat , cliente.geolong).

pgeoY = Y(cliente.geolat , cliente.geolong).
EMPTY TEMP-TABLE vecino.
    singeo = 0.
/*tareas vecinas de cobranzas*/
IF ttarea THEN DO:
    FOR EACH tarea WHERE 
            tarea.estado = "A" AND
            tarea.cdg_tipotarea = "C"  NO-LOCK:
            FIND cliente OF tarea NO-LOCK.
            IF cliente.geolat = 0 THEN do:
                singeo = singeo + 1.
                NEXT.
            END.
            IF DATE(extrae("fmin",tarea.dato)) > ultdia OR
             DATE(extrae("fmax",tarea.dato)) < pridia  THEN NEXT.
            IF ahdec(aint(extrae("hora_fin" , tarea.dato))) < hmin OR
             ahdec(aint(tarea.hora_prevista)) > hmax  THEN NEXT.
    
            ddist = distGeodesicaUTM(cliente.geoX , cliente.geoY , pgeoX,pgeoY).
            IF ddist > dmax THEN NEXT.
            CREATE vecino.
    
            ASSIGN vecino.nom_cliente = cliente.nom_cliente
                   vecino.cdg_cliente = cliente.cdg_cliente
                   vecino.direccion = cliente.direccion
                   vecino.xnro = tarea.nro_tarea
                   vecino.xtipo = "T"
                   vecino.geolat = cliente.geolat
                   vecino.geolong = cliente.geolong
                   vecino.distancia = ddist
                   vecino.fasignado = Tarea.fecha_prevista
                   vecino.origen = tarea.origen
                   vecino.duracion = Tarea.horas_estimadas
                   vecino.cdg_tipo = tarea.cdg_tipotarea.
                   vecino.fmin = date(extrae("fmin",tarea.dato)).
                   vecino.fmax = date(extrae("fmax",tarea.dato)). 
                   vecino.recursos = extrae("frecursos",tarea.dato).
                   vecino.recursos = IF vecino.recursos = ? THEN "" ELSE vecino.recursos.
                   vecino.horario = tarea.hora_prevista + ":" + extrae("hora_fin",tarea.dato).
                   
        END.
END.
/*eventos cercanos asignados*/

FIND tipo_evento WHERE tipo_evento.cdg_tipo_evento = "CO" NO-LOCK.
FOR EACH evento WHERE 
    NOT evento.anulado AND
    NOT evento.frealizado<>? AND
    evento.nro_tipo_evento = tipo_evento.nro_tipo_evento AND
    evento.fasignado >= pridia AND
    evento.fasignado <= ultdia NO-LOCK:
    FIND cliente OF evento NO-LOCK.
    IF cliente.geolat = 0 THEN do:
        singeo = singeo + 1.
        NEXT.
    END.
/*    IF evento.origen = "COBRANZA" THEN DO:
            FIND tarea WHERE tarea.nro_tarea = evento.nro_identificacion AND cdg_sitio = "" NO-LOCK.
            IF extrae("COPER",tarea.dato) = "S" THEN NEXT. /*no sirve de vecino cobra el operario*/
    END. */

    IF ahdec(aint(evento.hora_hasta)) < hmin OR
         ahdec(aint(evento.hora_desde )) > hmax  THEN NEXT.

    ddist = distGeodesicaUTM(cliente.geoX , cliente.geoY ,
                    pgeoX,pgeoY).
    IF ddist > dmax THEN NEXT.
    CREATE vecino.
    ASSIGN vecino.nom_cliente = cliente.nom_cliente
           vecino.cdg_cliente = cliente.cdg_cliente
           vecino.direccion = cliente.direccion
           vecino.xnro = evento.nro_evento
           vecino.xtipo = "E"
           vecino.geolat = cliente.geolat
           vecino.geolong = cliente.geolong
           vecino.distancia = ddist
           vecino.fasignado = evento.fasignado
           vecino.fmin = evento.fmin
           vecino.fmax = evento.fmax
           vecino.recursos = evento.recursos
           vecino.horario = evento.hora_desde + ":" + hora_hasta
           vecino.origen = evento.origen
           vecino.duracion = evento.durac
           vecino.cdg_tipo = tipo_evento.cdg_tipo_evento.
END.
/*eventos cercanos no asignados*/
IF tnoasig THEN DO:
    FIND tipo_evento WHERE tipo_evento.cdg_tipo_evento = "CO" NO-LOCK.
        FOR EACH evento WHERE 
            evento.fasignado=? AND 
            NOT evento.anulado AND
            NOT evento.frealizado<>? AND
            evento.nro_tipo_evento = tipo_evento.nro_tipo_evento 
            NO-LOCK:
            FIND tipo_evento WHERE tipo_evento.nro_tipo_evento = evento.nro_tipo_evento.
            FIND cliente OF evento NO-LOCK.
            IF cliente.geolat = 0 THEN do:
                singeo = singeo + 1.
                NEXT.
            END.
            IF evento.fmax < pridia OR evento.fmin> ultdia THEN NEXT.
 /*           IF evento.origen = "COBRANZA" THEN DO:
                    FIND tarea WHERE tarea.nro_tarea = evento.nro_identificacion NO-LOCK.
                    IF extrae("COPER",tarea.dato) = "S" THEN NEXT. /*no sirve de vecino cobra el operario*/
            END.*/
            IF ahdec(aint(evento.hora_hasta)) < hmin OR
                 ahdec(aint(evento.hora_desde)) > hmax  THEN NEXT.
            ddist = distGeodesicaUTM(cliente.geoX , cliente.geoY ,
                            pgeoX,pgeoY).
            IF ddist > dmax THEN NEXT.
            CREATE vecino.
            ASSIGN vecino.nom_cliente = cliente.nom_cliente
                   vecino.cdg_cliente = cliente.cdg_cliente
                   vecino.direccion = cliente.direccion
                   vecino.xnro = evento.nro_evento
                   vecino.xtipo = "N"
                   vecino.geolat = cliente.geolat
                   vecino.geolong = cliente.geolong
                   vecino.distancia = ddist
                   vecino.fasignado = evento.fasignado
                   vecino.fmin = evento.fmin
                   vecino.fmax = evento.fmax
                   vecino.recursos = evento.recursos
                   vecino.horario = evento.hora_desde + ":" + hora_hasta
                   vecino.origen = evento.origen
                   vecino.duracion = evento.durac
                   vecino.cdg_tipo = tipo_evento.cdg_tipo_evento.
        END.
END.

    v-singeo:SCREEN-VALUE = string(singeo).
    {&OPEN-QUERY-{&BROWSE-NAME}}
    {&OPEN-QUERY-BROWSE-4}
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

/* ************************  Function Implementations ***************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION cdg_tipos W-Win 
FUNCTION cdg_tipos RETURNS CHARACTER
  ( /* parameter-definitions */ ) :
/*------------------------------------------------------------------------------
  Purpose:  
    Notes:  
------------------------------------------------------------------------------*/
FIND tipo_evento WHERE tipo_evento.nro_tipo_evento = evento.nro_tipo_evento NO-LOCK NO-ERROR.
RETURN IF AVAILABLE tipo_evento THEN tipo_evento.cdg_tipo_evento ELSE "".   /* Function return value. */

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
  ( xtipo AS char, nro AS INT ) :
/*------------------------------------------------------------------------------
  Purpose:  
    Notes:  
------------------------------------------------------------------------------*/
DEFINE VAR k AS INT NO-UNDO.
DEFINE BUFFER bevento FOR evento.
IF xtipo = "T" THEN RETURN 0.
FIND bevento WHERE bevento.nro_evento = nro NO-LOCK.
FOR EACH recurso_agenda WHERE recurso_agenda.cdg_recurso = ENTRY(1,bevento.recurso) AND 
    recurso_agenda.fecha = bevento.fasignado NO-LOCK:
    FIND evento OF recurso_agenda NO-LOCK.
    k = k + evento.durac.
END.
  RETURN k.   /* Function return value. */

END FUNCTION.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION tope W-Win 
FUNCTION tope RETURNS LOGICAL
  ( /* parameter-definitions */ ):
/*------------------------------------------------------------------------------
  Purpose:  
    Notes:  
------------------------------------------------------------------------------*/
    /*w-win:WINDOW-STATE = 3.*/
{&WINDOW-NAME}:HANDLE:WINDOW-STATE = 3.
    {&WINDOW-NAME}:HANDLE:MOVE-TO-TOP().
    RETURN TRUE.

END FUNCTION.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

