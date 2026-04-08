&ANALYZE-SUSPEND _VERSION-NUMBER UIB_v8r12 GUI ADM1
&ANALYZE-RESUME
/* Connected Databases 
          sic              PROGRESS
*/
&Scoped-define WINDOW-NAME CURRENT-WINDOW
&Scoped-define FRAME-NAME D-Dialog


/* Temp-Table and Buffer definitions                                    */
DEFINE TEMP-TABLE T-Evento NO-UNDO LIKE Evento
       field nro_linea as int.



&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _DEFINITIONS D-Dialog 
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

  Description: from cntnrdlg.w - ADM SmartDialog Template

  Input Parameters:
      <none>

  Output Parameters:
      <none>

  Author: 

  Created: 
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
&IF DEFINED(UIB_is_Running)
&THEN
    DEFINE VARIABLE p-nro_linea AS int.
    DEFINE VARIABLE p-modo   AS INTEGER   INITIAL 2.
    DEFINE VARIABLE puso_Ok  AS LOGICAL.
&ELSE    
    DEFINE INPUT-OUTPUT PARAMETER TABLE FOR t-evento.
    DEFINE INPUT        PARAMETER p-nro_linea AS int.
    DEFINE INPUT        PARAMETER p-modo   AS INTEGER.
    DEFINE OUTPUT       PARAMETER puso_Ok  AS LOGICAL.
&ENDIF

/* Local Variable Definitions ---                                       */
    {valoresmodo.i}

DEFINE TEMP-TABLE aimp
    FIELD c_nro_tipo_evento LIKE tipo_evento.nro_tipo_evento COLUMN-LABEL "Tipo!Evento"
    FIELD nro_evento AS INT LABEL "EVENTO"
    FIELD recurso LIKE evento.recurso 
    FIELD turno LIKE evento.turno
    FIELD aviso_evento AS INT LABEL "AVISO EVENTO"
    FIELD aviso_fasignado AS DATE LABEL "REPARTIR"
    FIELD aviso_recurso AS CHAR LABEL "RECURSO"
    FIELD tipoespecial AS CHAR LABEL "ESPECIAL".


{crystal_dyna.p}

DEFINE VAR h_agenda_recurso AS HANDLE NO-UNDO.

{stavisado.i}

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE SmartDialog
&Scoped-define DB-AWARE no

&Scoped-define ADM-CONTAINER DIALOG-BOX

/* Name of designated FRAME-NAME and/or first browse and/or first query */
&Scoped-define FRAME-NAME D-Dialog

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-FIELDS T-Evento.Evaluar T-Evento.FRealizado ~
T-Evento.Anulado T-Evento.FAsignado T-Evento.hora_desde T-Evento.hora_hasta ~
T-Evento.Duracion T-Evento.Viaje T-Evento.FMin T-Evento.Recursos ~
T-Evento.Bloqueado T-Evento.FMax T-Evento.Periodo T-Evento.Observaciones ~
T-Evento.Leyenda T-Evento.Reminder T-Evento.dreminder 
&Scoped-define ENABLED-TABLES T-Evento
&Scoped-define FIRST-ENABLED-TABLE T-Evento
&Scoped-Define ENABLED-OBJECTS RECT-7 Btn_OK c_nro_tipo_evento durtotal ~
BUTTON-1 Btn_Cancel BRECURSOS Bagenda_recurso bOT v-stavisado Bobserv ~
Bleyenda Bleyenda-2 
&Scoped-Define DISPLAYED-FIELDS T-Evento.Evaluar T-Evento.FRealizado ~
T-Evento.nro_evento T-Evento.Anulado T-Evento.FAsignado T-Evento.hora_desde ~
T-Evento.hora_hasta T-Evento.Duracion T-Evento.Viaje T-Evento.FMin ~
T-Evento.Recursos T-Evento.Bloqueado T-Evento.FMax T-Evento.Periodo ~
T-Evento.Observaciones T-Evento.Leyenda T-Evento.Reminder ~
T-Evento.dreminder 
&Scoped-define DISPLAYED-TABLES T-Evento
&Scoped-define FIRST-DISPLAYED-TABLE T-Evento
&Scoped-Define DISPLAYED-OBJECTS c_nro_tipo_evento dsc_tipo_evento durtotal ~
tAsignado tRealizado v-stavisado 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME


/* ************************  Function Prototypes ********************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION-FORWARD habil_campos D-Dialog 
FUNCTION habil_campos RETURNS CHARACTER
  ( sino AS LOGICAL )  FORWARD.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION-FORWARD minutos D-Dialog 
FUNCTION minutos RETURNS INTEGER
  ( hh AS CHAR  )  FORWARD.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


/* ***********************  Control Definitions  ********************** */

/* Define a dialog box                                                  */

/* Definitions of the field level widgets                               */
DEFINE BUTTON Bagenda_recurso 
     LABEL "Agenda" 
     SIZE 10 BY 1.

DEFINE BUTTON Bleyenda 
     IMAGE-UP FILE "iconos16/trafficlight_on.jpg":U
     LABEL "Button 12" 
     SIZE 3.8 BY 1.14.

DEFINE BUTTON Bleyenda-2 
     IMAGE-UP FILE "iconos16/about.jpg":U
     IMAGE-INSENSITIVE FILE "iconos16i/about.jpg":U
     LABEL "Bleyenda 2" 
     SIZE 3.8 BY 1.14.

DEFINE BUTTON Bobserv 
     IMAGE-UP FILE "iconos16/text.jpg":U
     LABEL "Button 11" 
     SIZE 3.8 BY 1.14.

DEFINE BUTTON bOT 
     IMAGE-UP FILE "iconos24/wrench.jpg":U
     IMAGE-INSENSITIVE FILE "iconos24/wrench.jpg":U
     LABEL "Imp. Aviso" 
     SIZE 6 BY 1.43.

DEFINE BUTTON BRECURSOS 
     LABEL "Recursos" 
     SIZE 10 BY 1.

DEFINE BUTTON Btn_Cancel AUTO-END-KEY 
     IMAGE-UP FILE "iconos24/delete.jpg":U
     LABEL "Cancel" 
     SIZE 6 BY 1.43
     BGCOLOR 8 .

DEFINE BUTTON Btn_OK AUTO-GO 
     IMAGE-UP FILE "iconos24/check.jpg":U
     LABEL "OK" 
     SIZE 6 BY 1.43
     BGCOLOR 8 .

DEFINE BUTTON BUTTON-1 
     IMAGE-UP FILE "vortex100.jpg":U
     LABEL "Button 1" 
     SIZE 8 BY 1.91 DROP-TARGET.

DEFINE VARIABLE c_nro_tipo_evento AS INTEGER FORMAT ">>>>>>>>9" INITIAL 0 
     LABEL "Tipo" 
     VIEW-AS COMBO-BOX INNER-LINES 5
     LIST-ITEM-PAIRS "0",1
     DROP-DOWN-LIST
     SIZE 12 BY 1 TOOLTIP "Tipo de Restriccion o Tipo de T-Evento".

DEFINE VARIABLE dsc_tipo_evento AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 27 BY 1 NO-UNDO.

DEFINE VARIABLE durtotal AS CHARACTER FORMAT "X(256)":U 
     LABEL "DT" 
     VIEW-AS FILL-IN 
     SIZE 8 BY 1 TOOLTIP "Duracion total"
     BGCOLOR 13 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE v-stavisado AS CHARACTER FORMAT "X":U 
     VIEW-AS FILL-IN 
     SIZE 3 BY 1 NO-UNDO.

DEFINE RECTANGLE RECT-7
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 17 BY 5.48.

DEFINE VARIABLE tAsignado AS LOGICAL INITIAL no 
     LABEL "Asignado" 
     VIEW-AS TOGGLE-BOX
     SIZE 13.8 BY .81.

DEFINE VARIABLE tRealizado AS LOGICAL INITIAL no 
     LABEL "Realizado" 
     VIEW-AS TOGGLE-BOX
     SIZE 13.4 BY .81.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME D-Dialog
     T-Evento.Evaluar AT ROW 1.14 COL 80 WIDGET-ID 28
          VIEW-AS TOGGLE-BOX
          SIZE 12.2 BY .81
     T-Evento.FRealizado AT ROW 1.14 COL 106.6 COLON-ALIGNED WIDGET-ID 80
          LABEL "Realizado"
          VIEW-AS FILL-IN 
          SIZE 16 BY 1
     Btn_OK AT ROW 1.14 COL 136.6
     T-Evento.nro_evento AT ROW 1.24 COL 13 COLON-ALIGNED WIDGET-ID 18
          LABEL "Evento"
          VIEW-AS FILL-IN 
          SIZE 13.2 BY 1 NO-TAB-STOP 
     c_nro_tipo_evento AT ROW 1.24 COL 34.2 COLON-ALIGNED WIDGET-ID 40
     dsc_tipo_evento AT ROW 1.24 COL 47.2 COLON-ALIGNED NO-LABEL WIDGET-ID 42
     T-Evento.Anulado AT ROW 1.95 COL 80 WIDGET-ID 2
          VIEW-AS TOGGLE-BOX
          SIZE 12.8 BY .81
     T-Evento.FAsignado AT ROW 2.29 COL 106.6 COLON-ALIGNED WIDGET-ID 10
          VIEW-AS FILL-IN 
          SIZE 16 BY 1
     T-Evento.hora_desde AT ROW 2.48 COL 12.8 COLON-ALIGNED WIDGET-ID 52
          LABEL "Hora" FORMAT "x(5)"
          VIEW-AS FILL-IN 
          SIZE 11.6 BY 1
     T-Evento.hora_hasta AT ROW 2.52 COL 26.6 COLON-ALIGNED WIDGET-ID 54
          LABEL "-" FORMAT "x(5)"
          VIEW-AS FILL-IN 
          SIZE 11.6 BY 1
     T-Evento.Duracion AT ROW 2.52 COL 43.8 COLON-ALIGNED WIDGET-ID 6
          LABEL "Dur"
          VIEW-AS FILL-IN 
          SIZE 6 BY 1 TOOLTIP "Duracion en minutos"
     T-Evento.Viaje AT ROW 2.52 COL 56 COLON-ALIGNED WIDGET-ID 118
          VIEW-AS FILL-IN 
          SIZE 6.2 BY 1 TOOLTIP "Duracion de viaje"
     durtotal AT ROW 2.52 COL 66.6 COLON-ALIGNED WIDGET-ID 112
     BUTTON-1 AT ROW 2.76 COL 127 WIDGET-ID 114
     tAsignado AT ROW 2.81 COL 80 WIDGET-ID 4
     Btn_Cancel AT ROW 2.91 COL 136.4
     T-Evento.FMin AT ROW 3.48 COL 106.6 COLON-ALIGNED WIDGET-ID 16
          LABEL "Fech Min"
          VIEW-AS FILL-IN 
          SIZE 16 BY 1 TOOLTIP "Desde que fecha puede realizarse el evento"
     tRealizado AT ROW 3.67 COL 80 WIDGET-ID 46
     T-Evento.Recursos AT ROW 3.86 COL 12.6 COLON-ALIGNED WIDGET-ID 26
          VIEW-AS FILL-IN 
          SIZE 36.8 BY 1 TOOLTIP "Recursos asignados para realizar el evento"
     BRECURSOS AT ROW 3.86 COL 53.4 WIDGET-ID 36
     Bagenda_recurso AT ROW 3.86 COL 64.4 WIDGET-ID 38
     T-Evento.Bloqueado AT ROW 4.48 COL 80 WIDGET-ID 74
          LABEL "Bloqueado"
          VIEW-AS TOGGLE-BOX
          SIZE 14 BY .81 TOOLTIP "Evento bloqueado si cambia la asignacion debe coordinarse"
     T-Evento.FMax AT ROW 4.48 COL 106.6 COLON-ALIGNED WIDGET-ID 14
          LABEL "Fech.Max"
          VIEW-AS FILL-IN 
          SIZE 16 BY 1 TOOLTIP "hasta que fecha puede realizarse"
     bOT AT ROW 4.57 COL 136.6 WIDGET-ID 76
     v-stavisado AT ROW 5.29 COL 78 COLON-ALIGNED NO-LABEL WIDGET-ID 120
     T-Evento.Periodo AT ROW 5.52 COL 106.6 COLON-ALIGNED WIDGET-ID 90
          VIEW-AS FILL-IN 
          SIZE 10.4 BY 1 TOOLTIP "Periodo mensual al que corresponde"
     T-Evento.Observaciones AT ROW 6.71 COL 1.4 WIDGET-ID 62
          LABEL "Observacion"
          VIEW-AS FILL-IN 
          SIZE 118.4 BY 1
     Bobserv AT ROW 6.71 COL 134 WIDGET-ID 86
     T-Evento.Leyenda AT ROW 7.91 COL 12.6 COLON-ALIGNED WIDGET-ID 82
          VIEW-AS FILL-IN 
          SIZE 118.4 BY 1 TOOLTIP "Publico dirigido al cliente"
    WITH VIEW-AS DIALOG-BOX KEEP-TAB-ORDER 
         SIDE-LABELS NO-UNDERLINE THREE-D  SCROLLABLE 
         DEFAULT-BUTTON Btn_OK CANCEL-BUTTON Btn_Cancel WIDGET-ID 100.

/* DEFINE FRAME statement is approaching 4K Bytes.  Breaking it up   */
DEFINE FRAME D-Dialog
     Bleyenda AT ROW 7.91 COL 134 WIDGET-ID 104
     T-Evento.Reminder AT ROW 9.1 COL 12.6 COLON-ALIGNED WIDGET-ID 96
          VIEW-AS FILL-IN 
          SIZE 99.4 BY 1
     T-Evento.dreminder AT ROW 9.1 COL 124 COLON-ALIGNED WIDGET-ID 98
          VIEW-AS FILL-IN 
          SIZE 7 BY 1 TOOLTIP "Dias en + o - de la fecha avisado para el recordatorio"
     Bleyenda-2 AT ROW 9.1 COL 134 WIDGET-ID 106
     "Avisado" VIEW-AS TEXT
          SIZE 9.4 BY .62 AT ROW 5.43 COL 84 WIDGET-ID 122
     RECT-7 AT ROW 1 COL 78 WIDGET-ID 48
     SPACE(50.19) SKIP(4.08)
    WITH VIEW-AS DIALOG-BOX KEEP-TAB-ORDER 
         SIDE-LABELS NO-UNDERLINE THREE-D  SCROLLABLE 
         TITLE "Detalle del Evento"
         DEFAULT-BUTTON Btn_OK CANCEL-BUTTON Btn_Cancel WIDGET-ID 100.


/* *********************** Procedure Settings ************************ */

&ANALYZE-SUSPEND _PROCEDURE-SETTINGS
/* Settings for THIS-PROCEDURE
   Type: SmartDialog
   Allow: Basic,Browse,DB-Fields,Query,Smart
   Other Settings: COMPILE
   Temp-Tables and Buffers:
      TABLE: T-Evento T "?" NO-UNDO sic Evento
      ADDITIONAL-FIELDS:
          field nro_linea as int
      END-FIELDS.
   END-TABLES.
 */
&ANALYZE-RESUME _END-PROCEDURE-SETTINGS

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _INCLUDED-LIB D-Dialog 
/* ************************* Included-Libraries *********************** */

{src/adm/method/Vortex.i}
{src/adm/method/containr.i}

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME




/* ***********  Runtime Attributes and AppBuilder Settings  *********** */

&ANALYZE-SUSPEND _RUN-TIME-ATTRIBUTES
/* SETTINGS FOR DIALOG-BOX D-Dialog
   FRAME-NAME                                                           */
ASSIGN 
       FRAME D-Dialog:SCROLLABLE       = FALSE
       FRAME D-Dialog:HIDDEN           = TRUE.

/* SETTINGS FOR TOGGLE-BOX T-Evento.Bloqueado IN FRAME D-Dialog
   EXP-LABEL                                                            */
/* SETTINGS FOR FILL-IN dsc_tipo_evento IN FRAME D-Dialog
   NO-ENABLE                                                            */
ASSIGN 
       dsc_tipo_evento:READ-ONLY IN FRAME D-Dialog        = TRUE.

/* SETTINGS FOR FILL-IN T-Evento.Duracion IN FRAME D-Dialog
   EXP-LABEL                                                            */
ASSIGN 
       durtotal:READ-ONLY IN FRAME D-Dialog        = TRUE.

/* SETTINGS FOR FILL-IN T-Evento.FMax IN FRAME D-Dialog
   EXP-LABEL                                                            */
/* SETTINGS FOR FILL-IN T-Evento.FMin IN FRAME D-Dialog
   EXP-LABEL                                                            */
/* SETTINGS FOR FILL-IN T-Evento.FRealizado IN FRAME D-Dialog
   EXP-LABEL                                                            */
/* SETTINGS FOR FILL-IN T-Evento.hora_desde IN FRAME D-Dialog
   EXP-LABEL EXP-FORMAT                                                 */
/* SETTINGS FOR FILL-IN T-Evento.hora_hasta IN FRAME D-Dialog
   EXP-LABEL EXP-FORMAT                                                 */
/* SETTINGS FOR FILL-IN T-Evento.nro_evento IN FRAME D-Dialog
   NO-ENABLE EXP-LABEL                                                  */
ASSIGN 
       T-Evento.nro_evento:READ-ONLY IN FRAME D-Dialog        = TRUE.

/* SETTINGS FOR FILL-IN T-Evento.Observaciones IN FRAME D-Dialog
   ALIGN-L EXP-LABEL                                                    */
/* SETTINGS FOR TOGGLE-BOX tAsignado IN FRAME D-Dialog
   NO-ENABLE                                                            */
/* SETTINGS FOR TOGGLE-BOX tRealizado IN FRAME D-Dialog
   NO-ENABLE                                                            */
ASSIGN 
       v-stavisado:READ-ONLY IN FRAME D-Dialog        = TRUE.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME


/* Setting information for Queries and Browse Widgets fields            */

&ANALYZE-SUSPEND _QUERY-BLOCK DIALOG-BOX D-Dialog
/* Query rebuild information for DIALOG-BOX D-Dialog
     _Options          = "SHARE-LOCK KEEP-EMPTY"
     _Query            is NOT OPENED
*/  /* DIALOG-BOX D-Dialog */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME D-Dialog
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL D-Dialog D-Dialog
ON WINDOW-CLOSE OF FRAME D-Dialog /* Detalle del Evento */
DO:  
  /* Add Trigger to equate WINDOW-CLOSE to END-ERROR. */
  APPLY "END-ERROR":U TO SELF.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME T-Evento.Anulado
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL T-Evento.Anulado D-Dialog
ON VALUE-CHANGED OF T-Evento.Anulado IN FRAME D-Dialog /* Anulado */
DO:
    DEF VAR sino-msg AS LOGICAL NO-UNDO.
    DEF VAR i AS INT NO-UNDO.
  /*hay que verificar si esta asignado se debe desasignar y despues anular 
  si la fecha de asignacion es mayor o igual a la del dia
  se pregunta y sino se debe anular solamente*/

    IF self:CHECKED AND t-evento.fasignado:INPUT-VALUE IN FRAME {&FRAME-NAME}<>? THEN DO:
      IF t-evento.fasignado:INPUT-VALUE >= TODAY THEN DO:
      sino-msg = NO.
      RUN mensajepregunta.p ( INPUT "",INPUT "OPR0003", INPUT-OUTPUT sino-msg ). 
          IF sino-msg THEN DO:
                t-evento.fasignado:INPUT-VALUE = ?.
              DO i = 1 TO NUM-ENTRIES(t-evento.recursos):
                  FIND recurso_agenda WHERE recurso.cdg_recurso = ENTRY(i,t-evento.recurso) AND
                      recurso_agenda.fecha = t-evento.fasignado:INPUT-VALUE AND
                      recurso_agenda.nro_evento = t-evento.nro_evento NO-LOCK NO-ERROR.
                      IF AVAILABLE recurso_agenda THEN DELETE recurso_agenda.
        
              END.
          END.
          ELSE RETURN NO-APPLY.
      END.
      ELSE DO:
          RUN ponmensj.p("OPR0004"). /*no puede anularse ya paso*/
      END.
    END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME Bagenda_recurso
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Bagenda_recurso D-Dialog
ON CHOOSE OF Bagenda_recurso IN FRAME D-Dialog /* Agenda */
DO:
  IF NOT VALID-HANDLE(h_agenda_recurso) THEN DO:
      RUN w-agenda_recurso.w PERSISTENT SET h_agenda_recurso.
      IF VALID-HANDLE(h_agenda_recurso) THEN
         RUN dispatch IN h_agenda_recurso ( INPUT 'initialize':U ) .
  END.
  ELSE DYNAMIC-FUNCTION("tope" IN h_agenda_recurso ). 
  
  RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME Bleyenda
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Bleyenda D-Dialog
ON CHOOSE OF Bleyenda IN FRAME D-Dialog /* Button 12 */
DO:
  DEFINE VAR aedit AS CHAR NO-UNDO.
  aedit = t-evento.leyenda:SCREEN-VALUE IN FRAME {&FRAME-NAME}.
  RUN d-editorstr.w (INPUT-OUTPUT aedit,t-evento.leyenda:SENSITIVE ).
  t-evento.leyenda:SCREEN-VALUE = aedit.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME Bleyenda-2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Bleyenda-2 D-Dialog
ON CHOOSE OF Bleyenda-2 IN FRAME D-Dialog /* Bleyenda 2 */
DO:
  DEFINE VAR aedit AS CHAR NO-UNDO.
  aedit = t-evento.reminder:SCREEN-VALUE IN FRAME {&FRAME-NAME}.
  RUN d-editorstr.w (INPUT-OUTPUT aedit,t-evento.reminder:SENSITIVE ).
  t-evento.reminder:SCREEN-VALUE = aedit.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME Bobserv
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Bobserv D-Dialog
ON CHOOSE OF Bobserv IN FRAME D-Dialog /* Button 11 */
DO:
  DEFINE VAR aedit AS CHAR NO-UNDO.
  aedit = t-evento.observaciones:SCREEN-VALUE.
  RUN d-editorstr.w (INPUT-OUTPUT aedit, t-evento.observaciones:SENSITIVE ).
  t-evento.observaciones:SCREEN-VALUE = aedit.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bOT
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bOT D-Dialog
ON CHOOSE OF bOT IN FRAME D-Dialog /* Imp. Aviso */
DO:
    DEFI VAR xfile AS CHAR NO-UNDO.
    DEF VAR ReportePath AS CHAR NO-UNDO.
    DEF VAR cFullPath AS CHAR NO-UNDO.
    DEF VAR XFullPath AS CHAR NO-UNDO.
    DEF VAR exportFileName AS CHAR NO-UNDO.
    DEFINE VAR p-des_fecha AS DATE.
    DEFINE VAR p-has_fecha AS DATE.
    DEFINE VAR ERROR_rango AS LOGICAL.

    IF t-evento.nro_evento = 0 OR t-evento.nro_evento = ? THEN DO:
        MESSAGE "El evento aun no esta grabado" VIEW-AS ALERT-BOX INFORMATION.
        RETURN NO-APPLY.
    END.
    ReportePath = "orden_" + STRING(t-evento.nro_tipo_evento) .
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
            aimp.nro_evento = t-evento.nro_evento.

      RUN printorden.p ( INPUT TABLE aimp, OUTPUT xfile, 1 ). 


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
      END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME BRECURSOS
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL BRECURSOS D-Dialog
ON CHOOSE OF BRECURSOS IN FRAME D-Dialog /* Recursos */
DO:
  DEF VAR lista AS CHAR.
  lista = t-evento.recursos:SCREEN-VALUE.
  RUN d-recursos.w (INPUT-OUTPUT lista,STRING(c_nro_tipo_evento:INPUT-VALUE)).
  t-evento.recursos:SCREEN-VALUE = lista.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME Btn_OK
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Btn_OK D-Dialog
ON CHOOSE OF Btn_OK IN FRAME D-Dialog /* OK */
DO:
  IF p-modo = MD_ALTA  THEN do:
      RUN grabar_datos.
      puso_ok = TRUE.
  END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME BUTTON-1
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL BUTTON-1 D-Dialog
ON CHOOSE OF BUTTON-1 IN FRAME D-Dialog /* Button 1 */
DO:
    /*carpeta,indice usuario*/
DEFINE var p-carpeta LIKE vortex.carpeta NO-UNDO.
DEFINE var p-indice LIKE vortex.indice NO-UNDO.
RUN getter( OUTPUT p-carpeta, OUTPUT p-indice ).
IF p-indice <> ? THEN
  RUN d-vortex.w (INPUT p-carpeta, INPUT p-indice).
ELSE
  MESSAGE "No hay datos" VIEW-AS ALERT-BOX INFORMATION.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL BUTTON-1 D-Dialog
ON DROP-FILE-NOTIFY OF BUTTON-1 IN FRAME D-Dialog /* Button 1 */
DO:
  DEF VAR i AS INT no-undo.
  DEF VAR listarch AS CHAR NO-UNDO.
  REPEAT i = 1 TO self:NUM-DROPPED-FILES:
      /*falta ver si son directorios los que se ingresaron*/
      FILE-INFO:FILE-NAME = SELF:GET-DROPPED-FILE(i).
      listarch = listarch + "," + FILE-INFO:FILE-NAME.
  END.
  listarch = SUBSTRING(listarch,2). /*saco la coma que sobra*/
  self:END-FILE-DROP() .
  RUN archivar(listarch).
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL BUTTON-1 D-Dialog
ON MOUSE-MENU-CLICK OF BUTTON-1 IN FRAME D-Dialog /* Button 1 */
DO :
DEFINE VARIABLE lok AS LOGICAL NO-UNDO.
DEFINE VARIABLE cFile AS CHARACTER NO-UNDO.

    SYSTEM-DIALOG GET-FILE cFile
        FILTERS "All Files (*.*)" "*.*",
        "Bitmap Image (*.bmp)" "*.bmp",
        "JPG Files(*.jpg) " "*.jpg",
        "GIF Files (*.gif) " "*.gif"
        MUST-EXIST
        USE-FILENAME
        UPDATE lOk.
    IF lok THEN DO:
          FILE-INFO:FILE-NAME = cfile.
          cfile = FILE-INFO:FILE-NAME.
        RUN archivar(cfile).
    END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME c_nro_tipo_evento
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL c_nro_tipo_evento D-Dialog
ON VALUE-CHANGED OF c_nro_tipo_evento IN FRAME D-Dialog /* Tipo */
DO:
  FIND FIRST tipo_evento WHERE tipo_evento.nro_tipo_evento = c_nro_tipo_evento:INPUT-VALUE NO-ERROR.
  IF AVAILABLE tipo_evento THEN 
       dsc_tipo_evento:SCREEN-VALUE IN FRAME {&FRAME-NAME} = tipo_evento.descripcion.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME T-Evento.FAsignado
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL T-Evento.FAsignado D-Dialog
ON LEAVE OF T-Evento.FAsignado IN FRAME D-Dialog /* Asignado */
DO:
      IF t-evento.fasignado:INPUT-VALUE <> ? THEN
      INPUT tasignado:CHECKED = TRUE.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL T-Evento.FAsignado D-Dialog
ON MOUSE-MENU-DOWN OF T-Evento.FAsignado IN FRAME D-Dialog /* Asignado */
DO:
{selfecha.i}
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME T-Evento.FMax
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL T-Evento.FMax D-Dialog
ON MOUSE-MENU-DOWN OF T-Evento.FMax IN FRAME D-Dialog /* Fech.Max */
DO:
{selfecha.i}
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME T-Evento.FMin
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL T-Evento.FMin D-Dialog
ON LEAVE OF T-Evento.FMin IN FRAME D-Dialog /* Fech Min */
DO:
  ASSIGN {&SELF-NAME}.
  t-evento.periodo:SCREEN-VALUE IN FRAME {&FRAME-NAME} = string( YEAR( {&SELF-NAME} ) * 100 + MONTH({&SELF-NAME})).
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL T-Evento.FMin D-Dialog
ON MOUSE-MENU-DOWN OF T-Evento.FMin IN FRAME D-Dialog /* Fech Min */
DO:
{selfecha.i}
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME T-Evento.FRealizado
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL T-Evento.FRealizado D-Dialog
ON LEAVE OF T-Evento.FRealizado IN FRAME D-Dialog /* Realizado */
DO:
    IF t-evento.frealizado:INPUT-VALUE <> ? THEN
      INPUT trealizado:CHECKED = TRUE.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL T-Evento.FRealizado D-Dialog
ON MOUSE-MENU-DOWN OF T-Evento.FRealizado IN FRAME D-Dialog /* Realizado */
DO:
{selfecha.i}
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME T-Evento.hora_desde
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL T-Evento.hora_desde D-Dialog
ON LEAVE OF T-Evento.hora_desde IN FRAME D-Dialog /* Hora */
DO:
    DEF VAR i AS INT NO-UNDO.
    IF LENGTH(SELF:SCREEN-VALUE) <> 0 THEN DO:
        i = INT(replace(SELF:SCREEN-VALUE,":","")) NO-ERROR.
        SELF:SCREEN-VALUE = SUBstring(STRING(i,"9999"),1,2) + ":" + SUBstring(STRING(i,"9999"),3,2).
        IF INT(ENTRY(1, SUBstring(STRING(i,"9999"),1,2) + ":" + SUBstring(STRING(i,"9999"),3,2),":")) > 23 THEN do:
            MESSAGE "Hora invalida" VIEW-AS ALERT-BOX ERROR.
            RETURN NO-APPLY.
        END.
        IF INT(ENTRY(2,SUBstring(STRING(i,"9999"),1,2) + ":" + SUBstring(STRING(i,"9999"),3,2),":")) > 59 THEN do:
            MESSAGE "Hora invalida" VIEW-AS ALERT-BOX ERROR.
            RETURN NO-APPLY.
        END.
    END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME T-Evento.hora_hasta
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL T-Evento.hora_hasta D-Dialog
ON LEAVE OF T-Evento.hora_hasta IN FRAME D-Dialog /* - */
DO:
    DEF VAR i AS INT NO-UNDO.
    IF LENGTH(SELF:SCREEN-VALUE) <> 0 THEN DO:
        i = INT(replace(SELF:SCREEN-VALUE,":","")) NO-ERROR.
        SELF:SCREEN-VALUE = SUBstring(STRING(i,"9999"),1,2) + ":" + SUBstring(STRING(i,"9999"),3,2).
        IF INT(ENTRY(1, SUBstring(STRING(i,"9999"),1,2) + ":" + SUBstring(STRING(i,"9999"),3,2),":")) > 23 THEN do:
            MESSAGE "Hora invalida" VIEW-AS ALERT-BOX ERROR.
            RETURN NO-APPLY.
        END.
        IF INT(ENTRY(2,SUBstring(STRING(i,"9999"),1,2) + ":" + SUBstring(STRING(i,"9999"),3,2),":")) > 59 THEN do:
            MESSAGE "Hora invalida" VIEW-AS ALERT-BOX ERROR.
            RETURN NO-APPLY.
        END.
    END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME T-Evento.Leyenda
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL T-Evento.Leyenda D-Dialog
ON MOUSE-MENU-DOWN OF T-Evento.Leyenda IN FRAME D-Dialog /* Leyenda */
DO:
APPLY "choose" TO bleyenda.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&UNDEFINE SELF-NAME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _MAIN-BLOCK D-Dialog 


/* ***************************  Main Block  *************************** */

{src/adm/template/dialogmn.i}

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


/* **********************  Internal Procedures  *********************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE adm-create-objects D-Dialog  _ADM-CREATE-OBJECTS
PROCEDURE adm-create-objects :
/*------------------------------------------------------------------------------
  Purpose:     Create handles for all SmartObjects used in this procedure.
               After SmartObjects are initialized, then SmartLinks are added.
  Parameters:  <none>
------------------------------------------------------------------------------*/

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE adm-row-available D-Dialog  _ADM-ROW-AVAILABLE
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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE disable_UI D-Dialog  _DEFAULT-DISABLE
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
  HIDE FRAME D-Dialog.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE enable_UI D-Dialog  _DEFAULT-ENABLE
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
  DISPLAY c_nro_tipo_evento dsc_tipo_evento durtotal tAsignado tRealizado 
          v-stavisado 
      WITH FRAME D-Dialog.
  IF AVAILABLE T-Evento THEN 
    DISPLAY T-Evento.Evaluar T-Evento.FRealizado T-Evento.nro_evento 
          T-Evento.Anulado T-Evento.FAsignado T-Evento.hora_desde 
          T-Evento.hora_hasta T-Evento.Duracion T-Evento.Viaje T-Evento.FMin 
          T-Evento.Recursos T-Evento.Bloqueado T-Evento.FMax T-Evento.Periodo 
          T-Evento.Observaciones T-Evento.Leyenda T-Evento.Reminder 
          T-Evento.dreminder 
      WITH FRAME D-Dialog.
  ENABLE RECT-7 T-Evento.Evaluar T-Evento.FRealizado Btn_OK c_nro_tipo_evento 
         T-Evento.Anulado T-Evento.FAsignado T-Evento.hora_desde 
         T-Evento.hora_hasta T-Evento.Duracion T-Evento.Viaje durtotal BUTTON-1 
         Btn_Cancel T-Evento.FMin T-Evento.Recursos BRECURSOS Bagenda_recurso 
         T-Evento.Bloqueado T-Evento.FMax bOT v-stavisado T-Evento.Periodo 
         T-Evento.Observaciones Bobserv T-Evento.Leyenda Bleyenda 
         T-Evento.Reminder T-Evento.dreminder Bleyenda-2 
      WITH FRAME D-Dialog.
  VIEW FRAME D-Dialog.
  {&OPEN-BROWSERS-IN-QUERY-D-Dialog}
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE getter D-Dialog 
PROCEDURE getter :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/


/*esta funcion se debe adicionar el codigo a fin de completar que se puedan obtener
los valores de carpeta e indice en funcion a la ubicacion que tenga este objeto en 
la aplicacion*/
  DEFINE OUTPUT PARAMETER p-carpeta LIKE vortex.carpeta NO-UNDO.
  DEFINE OUTPUT PARAMETER p-indice LIKE vortex.indice NO-UNDO.

/*ejemplo si la tabla externa es cliente y existe un link de record 
se podran almacenar documentos relacinoados*/

  p-carpeta = "EVENTOS".
  p-indice = IF AVAILABLE evento THEN string(t-evento.nro_evento) ELSE ?.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE grabar_datos D-Dialog 
PROCEDURE grabar_datos :
/*------------------------------------------------------------------------------
  Purpose:     Override standard ADM method
  Notes:       
------------------------------------------------------------------------------*/
DEF VAR sino-msg AS LOGICAL NO-UNDO.
DEF VAR i AS INT NO-UNDO.

IF t-evento.recursos:INPUT-VALUE IN FRAME {&FRAME-NAME} BEGINS "#" THEN
    t-evento.recursos:SCREEN-VALUE = SUBSTRING(t-evento.recursos:INPUT-VALUE,2).

IF t-evento.fasignado:INPUT-VALUE IN FRAME {&FRAME-NAME}  <> t-evento.fasignado AND
    t-evento.fasignado:INPUT-VALUE IN FRAME {&FRAME-NAME} < TODAY THEN DO:
    MESSAGE "No puede asignar una fecha menor a la de hoy" SKIP
        "Deberia cargarlo como realizado si corresponde" VIEW-AS ALERT-BOX ERROR.
    RETURN NO-APPLY.
END.

IF t-evento.fasignado:INPUT-VALUE IN FRAME {&FRAME-NAME} <> t-evento.fasignado AND
    ( t-evento.fasignado:INPUT-VALUE IN FRAME {&FRAME-NAME} > t-evento.fmax:INPUT-VALUE OR
      t-evento.fasignado:INPUT-VALUE IN FRAME {&FRAME-NAME} < t-evento.fmin:INPUT-VALUE ) THEN  DO:
        MESSAGE "Esta fuera del periodo original" SKIP
            "Verifique si es correcto...."  SKIP
            "Se proseguira con la grabacion pero es algo anormal"
            "Tengalo en cuenta!!!!!" VIEW-AS ALERT-BOX information.
END.

IF t-evento.fasignado:INPUT-VALUE IN FRAME {&FRAME-NAME}<> ?  THEN DO:
    IF t-evento.fasignado:INPUT-VALUE = ? THEN DO:
        RUN ponmensj.p("OPR0006").
        tasignado:CHECKED = FALSE.
        RETURN NO-APPLY.
    END.
    IF t-evento.recursos:INPUT-VALUE = "" THEN DO:
        RUN ponmensj.p("OPR0007").
        tasignado:CHECKED = FALSE.
        RETURN NO-APPLY.
    END.
    IF t-evento.fasignado:INPUT-VALUE > t-evento.fmax:INPUT-VALUE OR t-evento.fasignado:INPUT-VALUE < t-evento.fmin:INPUT-VALUE  THEN  DO:
        sino-msg = NO.
        RUN mensajepregunta.p ( INPUT "",INPUT "OPR0008", INPUT-OUTPUT sino-msg ).
        IF NOT sino-msg THEN DO:
            tasignado:CHECKED = FALSE.
            RETURN NO-APPLY.
        END.
     END.
    
END.

ASSIGN c_nro_tipo_evento. 
ASSIGN T-Evento.nro_tipo_evento = c_nro_tipo_evento.
IF t-evento.frealizado:INPUT-VALUE <> ? THEN
    trealizado:CHECKED = TRUE.
IF t-evento.hora_desde:INPUT-VALUE <> "" AND
    t-evento.hora_hasta <> "" THEN
    trealizado:CHECKED = TRUE.

DO WITH FRAME {&FRAME-NAME}:
  ASSIGN  T-Evento.Anulado
          T-Evento.Duracion
          T-Evento.Evaluar
          T-Evento.FAsignado
          T-Evento.FMax
          T-Evento.FMin
          T-Evento.nro_evento
          t-evento.frealizado
          T-Evento.Recursos
          t-evento.bloqueado
          t-evento.periodo
          t-evento.viaje
          t-evento.observacion.
   ASSIGN T-Evento.hora_desde NO-ERROR.
   ASSIGN T-Evento.hora_hasta NO-ERROR.

      END.
   
IF evento.fasignado = ? AND evento.frealizado <> ? THEN DO:
    ASSIGN evento.fasignado = evento.frealizado.
          
END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE local-display-fields D-Dialog 
PROCEDURE local-display-fields :
/*------------------------------------------------------------------------------
  Purpose:     Override standard ADM method
  Notes:       
------------------------------------------------------------------------------*/

  /* Code placed here will execute PRIOR to standard behavior. */

  /* Dispatch standard ADM method.                             */
  RUN dispatch IN THIS-PROCEDURE ( INPUT 'display-fields':U ) .

  /* Code placed here will execute AFTER standard behavior.    */
  IF AVAILABLE evento THEN
      trealizado:CHECKED IN FRAME {&FRAME-NAME}= evento.frealizado<>?.
      tasignado:CHECKED = evento.fasignado<>?.


END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE local-initialize D-Dialog 
PROCEDURE local-initialize :
/*------------------------------------------------------------------------------
  Purpose:     Override standard ADM method
  Notes:       
------------------------------------------------------------------------------*/
DEF VAR lista AS CHAR NO-UNDO.
  /* Code placed here will execute PRIOR to standard behavior. */
puso_Ok = NO.
  &Scoped-define CONDICION tipo_evento.nro_tipo_evento > 0 
  DO WITH FRAME {&FRAME-NAME}:
     {levantacombo.i &TABLA=Tipo_evento &NOMBRE=cdg_tipo_evento &CODIGO=nro_tipo_evento &OBJETO=c_nro_tipo_evento}
  END. 
FIND t-evento WHERE t-evento.nro_linea = p-nro_linea NO-ERROR.
IF NOT AVAILABLE t-evento THEN do:
    MESSAGE "Error de Implementacion" skip
            "Verifique que el articulo tenga asociado un tipo de evento" VIEW-AS ALERT-BOX ERROR.
    STOP.
END.
   c_nro_tipo_evento = t-evento.nro_tipo_evento.
   DISPLAY c_nro_tipo_evento WITH FRAME {&FRAME-NAME}.

  /* Dispatch standard ADM method.                             */
  RUN dispatch IN THIS-PROCEDURE ( INPUT 'initialize':U ) .


  IF p-modo = MD_ALTA  THEN DO:
      habil_campos(YES).
  END.
  ELSE habil_campos(NO).
  /* Code placed here will execute AFTER standard behavior.    */

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE send-records D-Dialog  _ADM-SEND-RECORDS
PROCEDURE send-records :
/*------------------------------------------------------------------------------
  Purpose:     Send record ROWID's for all tables used by
               this file.
  Parameters:  see template/snd-head.i
------------------------------------------------------------------------------*/

  /* SEND-RECORDS does nothing because there are no External
     Tables specified for this SmartDialog, and there are no
     tables specified in any contained Browse, Query, or Frame. */

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE state-changed D-Dialog 
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

/* ************************  Function Implementations ***************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION habil_campos D-Dialog 
FUNCTION habil_campos RETURNS CHARACTER
  ( sino AS LOGICAL ) :
/*------------------------------------------------------------------------------
  Purpose:  
    Notes:  
------------------------------------------------------------------------------*/
DO WITH FRAME {&FRAME-NAME}:
    t-evento.Anulado:sensitive = sino.
    t-evento.Duracion:sensitive = sino.
    t-evento.Evaluar:sensitive = sino.
    t-evento.FAsignado:sensitive = sino.
    t-evento.FMax:sensitive = sino.
    t-evento.FMin:sensitive = sino.
    t-evento.hora_desde:sensitive = sino.
    t-evento.hora_hasta:sensitive = sino.
    t-evento.nro_evento:sensitive = sino.
    /*t-evento.nro_evento_padre:sensitive = sino.*/
    /*t-evento.nro_identificacion:sensitive = sino.*/
    t-evento.Recursos:sensitive = sino.
    /*t-evento.origen:sensitive = sino.*/
/*     c_nro_tipo_evento:sensitive = sino. */
    t-evento.bloqueado:sensitive = sino.
    t-evento.observacion:sensitive = sino.
    brecursos:SENSITIVE = sino.
/*     bagenda_recurso:SENSITIVE = t-evento.recursos:INPUT-VALUE <> "". */
    
END.

  RETURN "".   /* Function return value. */

END FUNCTION.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION minutos D-Dialog 
FUNCTION minutos RETURNS INTEGER
  ( hh AS CHAR  ) :
/*------------------------------------------------------------------------------
  Purpose: es una hora en formato HH:MM 
    Notes:  devuelve los minutos desde las 00:00
------------------------------------------------------------------------------*/
IF LENGTH(hh) = 5 THEN
  RETURN int(substr(hh,1,2)) * 60 + int(substr(hh,4,2)).   /* Function return value. */
ELSE
  RETURN 0.

END FUNCTION.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

