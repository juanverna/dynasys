&ANALYZE-SUSPEND _VERSION-NUMBER UIB_v8r12 GUI ADM1
&ANALYZE-RESUME
/* Connected Databases 
          sic              PROGRESS
*/
&Scoped-define WINDOW-NAME CURRENT-WINDOW
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _DEFINITIONS V-table-Win 
/*********************************************************************
*********************************************************************/

CREATE WIDGET-POOL.

/* ***************************  Definitions  ************************** */

/* Parameters Definitions ---                                           */

/* Local Variable Definitions ---                                       */

DEF VAR i AS INT NO-UNDO.
DEF VAR sino-msg AS LOGICAL NO-UNDO.


DEFINE TEMP-TABLE aimp
    FIELD c_nro_tipo_evento LIKE tipo_evento.nro_tipo_evento COLUMN-LABEL "Tipo!Evento"
    FIELD nro_evento AS INT LABEL "EVENTO"
    FIELD recurso LIKE evento.recurso 
    FIELD turno LIKE evento.turno
    FIELD aviso_evento AS INT LABEL "AVISO EVENTO"
    FIELD aviso_fasignado AS DATE LABEL "REPARTIR"
    FIELD aviso_recurso AS CHAR LABEL "RECURSO"
    FIELD tipoespecial AS CHAR LABEL "ESPECIAL".
{extrae.i}
{crystal_dyna.p}
{impresoras.i}
DEFINE VAR ant_rid AS ROWID NO-UNDO.
DEFINE BUFFER bevento FOR evento.
DEFINE VAR refrescar AS LOGICAL NO-UNDO. /*si esta en true al terminar la transaccion debe realizar un open-query en el source-record*/
DEFINE VAR h_vecinos AS HANDLE.
DEFINE VAR h_agenda_recurso AS HANDLE.
DEFINE VAR nro_tipo_evento_cobranza LIKE tipo_evento.nro_tipo_evento NO-UNDO.
DEFINE VAR nro_tipo_evento_tanque LIKE tipo_evento.nro_tipo_evento NO-UNDO.
DEFINE VAR nro_tipo_evento_aviso LIKE tipo_evento.nro_tipo_evento NO-UNDO.
DEFINE BUFFER administrador FOR cliente.
{stavisado.i}
{tiempo.i}
{restricciones.i}
{advtexto.i}

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE SmartViewer
&Scoped-define DB-AWARE no

&Scoped-define ADM-SUPPORTED-LINKS Record-Source,Record-Target,TableIO-Target

/* Name of designated FRAME-NAME and/or first browse and/or first query */
&Scoped-define FRAME-NAME F-Main

/* External Tables                                                      */
&Scoped-define EXTERNAL-TABLES Evento
&Scoped-define FIRST-EXTERNAL-TABLE Evento


/* Need to scope the external tables to this procedure                  */
DEFINE QUERY external_tables FOR Evento.
/* Standard List Definitions                                            */
&Scoped-Define ENABLED-FIELDS Evento.Evaluar Evento.informa Evento.Anulado ~
Evento.REFevento Evento.EVSigue Evento.nro_evento Evento.nro_evento_padre ~
Evento.Bloqueado Evento.FAsignado Evento.nro_planasignar Evento.Periodo ~
Evento.hora_desde Evento.hora_hasta Evento.Duracion Evento.Viaje ~
Evento.Recursos Evento.Turno Evento.FMin Evento.FMax Evento.dreminder ~
Evento.Transporte Evento.trae_libro Evento.url1 
&Scoped-define ENABLED-TABLES Evento
&Scoped-define FIRST-ENABLED-TABLE Evento
&Scoped-Define ENABLED-OBJECTS RECT-7 v-perant Bvecino v-sttarea Bzoom ~
b_infoadic v-modo v-stavisado durtotal BUTTON-1 Bagenda_recurso Bcertif ~
b-alerta label-TA label-AV 
&Scoped-Define DISPLAYED-FIELDS Evento.FCreado Evento.Evaluar ~
Evento.informa Evento.Anulado Evento.FRealizado Evento.REFevento ~
Evento.EVSigue Evento.nro_evento Evento.nro_evento_padre Evento.Bloqueado ~
Evento.FAsignado Evento.nro_planasignar Evento.Origen ~
Evento.nro_identificacion Evento.sub_evento Evento.Periodo ~
Evento.hora_desde Evento.hora_hasta Evento.Duracion Evento.Viaje ~
Evento.Recursos Evento.Turno Evento.FMin Evento.FMax Evento.Reminder ~
Evento.dreminder Evento.Transporte Evento.trae_libro Evento.LetraPrefijo ~
Evento.nro_certificado Evento.tipo_certif Evento.url1 Evento.Leyenda 
&Scoped-define DISPLAYED-TABLES Evento
&Scoped-define FIRST-DISPLAYED-TABLE Evento
&Scoped-Define DISPLAYED-OBJECTS v-perant c_nro_tipo_evento nom_admin ~
v-sttarea v-modo v-stavisado durtotal Observaciones leyenda_contrato ~
label-TA label-AV 

/* Custom List Definitions                                              */
/* ADM-CREATE-FIELDS,ADM-ASSIGN-FIELDS,List-3,List-4,List-5,List-6      */
&Scoped-define ADM-ASSIGN-FIELDS Evento.Reminder 

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _XFTR "Foreign Keys" V-table-Win _INLINE
/* Actions: ? adm/support/keyedit.w ? ? ? */
/* STRUCTURED-DATA
<KEY-OBJECT>
THIS-PROCEDURE
</KEY-OBJECT>
<FOREIGN-KEYS>
</FOREIGN-KEYS> 
<EXECUTING-CODE>
**************************
* Set attributes related to FOREIGN KEYS
*/
RUN set-attribute-list (
    'Keys-Accepted = "",
     Keys-Supplied = ""':U).
/**************************
</EXECUTING-CODE> */   

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

/* ************************  Function Prototypes ********************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION-FORWARD cerrar V-table-Win 
FUNCTION cerrar RETURNS LOGICAL
  ( hh AS WIDGET-HANDLE )  FORWARD.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION-FORWARD fac_bloqueo V-table-Win 
FUNCTION fac_bloqueo RETURNS LOGICAL ( nro AS INT , cant AS INT )  FORWARD.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION-FORWARD felegido V-table-Win 
FUNCTION felegido RETURNS LOGICAL
  ( felegido  AS INT )  FORWARD.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION-FORWARD pagado V-table-Win 
FUNCTION pagado RETURNS CHARACTER
  ( nro AS INT )  FORWARD.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION-FORWARD recurso-invalido V-table-Win 
FUNCTION recurso-invalido RETURNS LOGICAL
  ( recu AS CHAR )  FORWARD.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


/* ***********************  Control Definitions  ********************** */


/* Menu Definitions                                                     */
DEFINE MENU POPUP-MENU-Bcertif 
       MENU-ITEM m_Impreso      LABEL "Impreso"       
              TOGGLE-BOX
       MENU-ITEM m_Email        LABEL "Email"         
              TOGGLE-BOX
       MENU-ITEM m_PDF          LABEL "PDF"           
              TOGGLE-BOX.


/* Definitions of the field level widgets                               */
DEFINE BUTTON b-alerta 
     IMAGE-UP FILE "iconos16/trafficlight_on.jpg":U
     IMAGE-INSENSITIVE FILE "iconos16i/trafficlight_on.jpg":U
     LABEL "Leyenda" 
     SIZE 3.8 BY 1.14 TOOLTIP "Leyenda interna que viene del contrato va la OT".

DEFINE BUTTON Bagenda_recurso 
     LABEL "Agenda" 
     SIZE 10 BY 1.

DEFINE BUTTON banal 
     IMAGE-UP FILE "iconos24/application.jpg":U
     IMAGE-INSENSITIVE FILE "iconos24/application.jpg":U
     LABEL "Imp. Aviso" 
     SIZE 6 BY 1.43 TOOLTIP "Analisis de laboratorio".

DEFINE BUTTON bAviso 
     IMAGE-UP FILE "iconos24/text_marked.jpg":U
     LABEL "Imp. Aviso" 
     SIZE 6 BY 1.43 TOOLTIP "Aviso".

DEFINE BUTTON Bcertif 
     IMAGE-UP FILE "iconos24/data.jpg":U
     LABEL "Button 13" 
     SIZE 6 BY 1.43 TOOLTIP "Imprime el certificado definitivo".

DEFINE BUTTON Bleyenda 
     IMAGE-UP FILE "iconos16/trafficlight_on.jpg":U
     LABEL "Button 12" 
     SIZE 3.8 BY 1.14 TOOLTIP "Leyenda Publica del evento va a la OT".

DEFINE BUTTON Bleyenda-2 
     IMAGE-UP FILE "iconos16/about.jpg":U
     IMAGE-INSENSITIVE FILE "iconos16i/about.jpg":U
     LABEL "Bleyenda 2" 
     SIZE 3.8 BY 1.14.

DEFINE BUTTON Bmobs 
     IMAGE-UP FILE "iconos16/qrcode.jpg":U
     LABEL "Bobserv 2" 
     SIZE 5 BY 1.14 TOOLTIP "Aclaracion del MOBS (Calculos Computacionales)".

DEFINE BUTTON Bobserv 
     IMAGE-UP FILE "iconos16/text.jpg":U
     LABEL "Button 11" 
     SIZE 4.8 BY 1.14.

DEFINE BUTTON Bobserv-2 
     IMAGE-UP FILE "iconos16/target.jpg":U
     LABEL "Bobserv 2" 
     SIZE 3.8 BY 1.14.

DEFINE BUTTON bOT 
     IMAGE-UP FILE "iconos24/wrench.jpg":U
     IMAGE-INSENSITIVE FILE "iconos24/wrench.jpg":U
     LABEL "Imp. Aviso" 
     SIZE 6 BY 1.43 TOOLTIP "OT".

DEFINE BUTTON BRECURSOS 
     LABEL "Recursos" 
     SIZE 10 BY 1.

DEFINE BUTTON BUTTON-1 
     IMAGE-UP FILE "vortex100.jpg":U
     LABEL "Button 1" 
     SIZE 8 BY 1.91 DROP-TARGET.

DEFINE BUTTON Bvecino 
     LABEL "Vec." 
     SIZE 6 BY 1.14.

DEFINE BUTTON Bzoom 
     IMAGE-UP FILE "iconos24i/about.jpg":U
     LABEL "Button 15" 
     SIZE 5 BY 1.14 TOOLTIP "Tarea relacionada".

DEFINE BUTTON b_infoadic 
     IMAGE-UP FILE "iconos16/box.jpg":U
     IMAGE-INSENSITIVE FILE "iconos16i/box.jpg":U
     LABEL "Inf.Adicional" 
     SIZE 5 BY 1.14 TOOLTIP "Informacion adicional sobre el item".

DEFINE VARIABLE c_nro_tipo_evento AS INTEGER FORMAT ">>>>>>>>9" INITIAL 0 
     LABEL "Tipo" 
     VIEW-AS COMBO-BOX INNER-LINES 15
     LIST-ITEM-PAIRS "0",1
     DROP-DOWN-LIST
     SIZE 12 BY 1 TOOLTIP "Tipo de Restriccion o Tipo de Evento".

DEFINE VARIABLE durtotal AS CHARACTER FORMAT "X(256)":U 
     LABEL "DT" 
     VIEW-AS FILL-IN 
     SIZE 8 BY 1 TOOLTIP "Duracion total"
     BGCOLOR 13 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE label-AV AS CHARACTER FORMAT "X(256)":U INITIAL "Avisado" 
      VIEW-AS TEXT 
     SIZE 9 BY .62 NO-UNDO.

DEFINE VARIABLE label-TA AS CHARACTER FORMAT "X(256)":U INITIAL "Tarea" 
      VIEW-AS TEXT 
     SIZE 9 BY .62 NO-UNDO.

DEFINE VARIABLE leyenda_contrato AS CHARACTER FORMAT "X(256)":U 
     LABEL "LContrato" 
     VIEW-AS FILL-IN 
     SIZE 121 BY 1 TOOLTIP "Leyenda de los contratos que dieron origen al evento" NO-UNDO.

DEFINE VARIABLE nom_admin AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 29 BY 1 NO-UNDO.

DEFINE VARIABLE Observaciones LIKE Evento.Observaciones
     LABEL "Observ" 
     VIEW-AS FILL-IN 
     SIZE 83 BY 1 TOOLTIP "Interno a la empresa (si comienza con **)  es que hay mas" NO-UNDO.

DEFINE VARIABLE v-modo AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 8 BY 1 NO-UNDO.

DEFINE VARIABLE v-perant AS CHARACTER FORMAT "X(256)":U 
     LABEL "AsigAnt" 
     VIEW-AS FILL-IN 
     SIZE 14 BY 1 NO-UNDO.

DEFINE VARIABLE v-stavisado AS CHARACTER FORMAT "X":U 
     VIEW-AS FILL-IN 
     SIZE 3 BY 1 NO-UNDO.

DEFINE VARIABLE v-sttarea AS CHARACTER FORMAT "X":U 
     VIEW-AS FILL-IN 
     SIZE 3 BY 1 NO-UNDO.

DEFINE RECTANGLE RECT-7
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 14.2 BY 5.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME F-Main
     Evento.FCreado AT ROW 1 COL 99 COLON-ALIGNED WIDGET-ID 12
          VIEW-AS FILL-IN 
          SIZE 16 BY 1 TOOLTIP "Fecha de creacion del evento" NO-TAB-STOP 
     v-perant AT ROW 1.1 COL 127 COLON-ALIGNED WIDGET-ID 102
     Evento.Evaluar AT ROW 1.14 COL 78.6 WIDGET-ID 28
          VIEW-AS TOGGLE-BOX
          SIZE 12.2 BY .81 NO-TAB-STOP 
     c_nro_tipo_evento AT ROW 1.24 COL 9.6 COLON-ALIGNED WIDGET-ID 40
     nom_admin AT ROW 1.24 COL 23 COLON-ALIGNED NO-LABEL WIDGET-ID 42
     Evento.informa AT ROW 1.33 COL 57 WIDGET-ID 150
          VIEW-AS TOGGLE-BOX
          SIZE 13.4 BY .81 TOOLTIP "Se se informa en la agenda diara"
     Evento.Anulado AT ROW 1.86 COL 78.6 WIDGET-ID 2
          VIEW-AS TOGGLE-BOX
          SIZE 12.8 BY .81 NO-TAB-STOP 
     Evento.FRealizado AT ROW 2.19 COL 99 COLON-ALIGNED WIDGET-ID 58
          LABEL "FRealiz."
          VIEW-AS FILL-IN 
          SIZE 16 BY 1 TOOLTIP "Fecha de realizacion del trabajo"
     Evento.REFevento AT ROW 2.19 COL 128.8 COLON-ALIGNED WIDGET-ID 68
          VIEW-AS FILL-IN 
          SIZE 12 BY 1 NO-TAB-STOP 
     Evento.EVSigue AT ROW 2.38 COL 57 COLON-ALIGNED WIDGET-ID 116 FORMAT ">>>>>>>9"
          VIEW-AS FILL-IN 
          SIZE 12 BY 1
     Evento.nro_evento AT ROW 2.43 COL 9.6 COLON-ALIGNED WIDGET-ID 18
          LABEL "Evento"
          VIEW-AS FILL-IN 
          SIZE 13.2 BY 1 NO-TAB-STOP 
     Evento.nro_evento_padre AT ROW 2.43 COL 32 COLON-ALIGNED WIDGET-ID 20
          LABEL "Padre"
          VIEW-AS FILL-IN 
          SIZE 13.2 BY 1
     Evento.Bloqueado AT ROW 2.62 COL 78.6 WIDGET-ID 74
          LABEL "Bloq."
          VIEW-AS TOGGLE-BOX
          SIZE 10.2 BY .81 TOOLTIP "Evento bloqueado si cambia la asignacion debe coordinarse" NO-TAB-STOP 
     Evento.FAsignado AT ROW 3.38 COL 99 COLON-ALIGNED WIDGET-ID 78
          LABEL "Asign."
          VIEW-AS FILL-IN 
          SIZE 16 BY 1
     Bvecino AT ROW 3.38 COL 119.8 WIDGET-ID 124
     Evento.nro_planasignar AT ROW 3.38 COL 130.6 COLON-ALIGNED WIDGET-ID 70
          LABEL "Pln"
          VIEW-AS FILL-IN 
          SIZE 10 BY 1
     v-sttarea AT ROW 3.52 COL 76.6 COLON-ALIGNED NO-LABEL WIDGET-ID 128
     Bzoom AT ROW 3.57 COL 65.8 WIDGET-ID 126
     b_infoadic AT ROW 3.57 COL 75.2 RIGHT-ALIGNED WIDGET-ID 94
     Evento.Origen AT ROW 3.62 COL 9.6 COLON-ALIGNED WIDGET-ID 34
          VIEW-AS FILL-IN 
          SIZE 18 BY 1
     Evento.nro_identificacion AT ROW 3.62 COL 34.6 COLON-ALIGNED WIDGET-ID 22
          LABEL "Ident."
          VIEW-AS FILL-IN 
          SIZE 15.8 BY 1 NO-TAB-STOP 
     Evento.sub_evento AT ROW 3.62 COL 50.8 COLON-ALIGNED NO-LABEL WIDGET-ID 56
          VIEW-AS FILL-IN 
          SIZE 3.8 BY 1
     v-modo AT ROW 3.62 COL 55 COLON-ALIGNED NO-LABEL WIDGET-ID 156
     v-stavisado AT ROW 4.71 COL 76.6 COLON-ALIGNED NO-LABEL WIDGET-ID 120
     Evento.Periodo AT ROW 4.76 COL 99 COLON-ALIGNED WIDGET-ID 90
          LABEL "Periodo" FORMAT "999999"
          VIEW-AS FILL-IN 
          SIZE 10.4 BY 1 TOOLTIP "Periodo mensual al que corresponde"
     Evento.hora_desde AT ROW 4.81 COL 9.6 COLON-ALIGNED WIDGET-ID 52
          LABEL "Hora" FORMAT "x(5)"
          VIEW-AS FILL-IN 
          SIZE 11.6 BY 1 TOOLTIP "Hora inicio de tareas HHMM"
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1 SCROLLABLE  WIDGET-ID 100.

/* DEFINE FRAME statement is approaching 4K Bytes.  Breaking it up   */
DEFINE FRAME F-Main
     Evento.hora_hasta AT ROW 4.81 COL 21.2 COLON-ALIGNED NO-LABEL WIDGET-ID 54 FORMAT "x(5)"
          VIEW-AS FILL-IN 
          SIZE 11.6 BY 1 TOOLTIP "Hora fin de tareas formato HHMM"
     Evento.Duracion AT ROW 4.81 COL 38.2 COLON-ALIGNED WIDGET-ID 6
          LABEL "Dur."
          VIEW-AS FILL-IN 
          SIZE 6 BY 1 TOOLTIP "Duracion en minutos"
     Evento.Viaje AT ROW 4.81 COL 50.2 COLON-ALIGNED WIDGET-ID 104
          VIEW-AS FILL-IN 
          SIZE 6.2 BY 1
     durtotal AT ROW 4.81 COL 60.8 COLON-ALIGNED WIDGET-ID 112
     BUTTON-1 AT ROW 4.81 COL 122 WIDGET-ID 114
     bAviso AT ROW 4.81 COL 132.4 WIDGET-ID 72
     bOT AT ROW 4.81 COL 138.4 WIDGET-ID 76
     Evento.Recursos AT ROW 5.95 COL 9.6 COLON-ALIGNED WIDGET-ID 26 FORMAT "X(20)"
          VIEW-AS FILL-IN 
          SIZE 23.4 BY 1 TOOLTIP "Recursos asignados para realizar el evento"
     Evento.Turno AT ROW 5.95 COL 63.6 COLON-ALIGNED WIDGET-ID 64
          LABEL "TU" FORMAT "xx"
          VIEW-AS FILL-IN 
          SIZE 5 BY 1
     BRECURSOS AT ROW 6 COL 38 WIDGET-ID 36
     Bagenda_recurso AT ROW 6 COL 49 WIDGET-ID 38
     Evento.FMin AT ROW 6 COL 82 COLON-ALIGNED WIDGET-ID 16
          LABEL "F.Analisis"
          VIEW-AS FILL-IN 
          SIZE 16 BY 1 TOOLTIP "Desde que fecha puede asignarse el evento"
     Evento.FMax AT ROW 6 COL 100.8 COLON-ALIGNED WIDGET-ID 14
          LABEL "a"
          VIEW-AS FILL-IN 
          SIZE 16 BY 1 TOOLTIP "hasta que fecha puede realizarse"
     banal AT ROW 6.33 COL 138.2 WIDGET-ID 118
     Bcertif AT ROW 6.38 COL 132.2 WIDGET-ID 142
     Evento.Reminder AT ROW 7 COL 9.8 COLON-ALIGNED WIDGET-ID 96 FORMAT "x(400)"
          VIEW-AS FILL-IN 
          SIZE 57.2 BY 1
     Bleyenda-2 AT ROW 7 COL 87.4 WIDGET-ID 100
     Evento.dreminder AT ROW 7.1 COL 77.8 COLON-ALIGNED WIDGET-ID 98
          LABEL "DiasRem"
          VIEW-AS FILL-IN 
          SIZE 7 BY 1 TOOLTIP "Dias en + o - de la fecha avisado para el recordatorio"
     Evento.Transporte AT ROW 7.1 COL 97.8 COLON-ALIGNED WIDGET-ID 108
          LABEL "Transp."
          VIEW-AS FILL-IN 
          SIZE 16.2 BY 1 TOOLTIP "Como se llega desde el evento anterior"
     Bobserv-2 AT ROW 7.1 COL 117 WIDGET-ID 110
     Evento.trae_libro AT ROW 7.19 COL 122 WIDGET-ID 136
          VIEW-AS TOGGLE-BOX
          SIZE 9.4 BY .81 TOOLTIP "Indica si el libro esta en poder de la empresa"
     Observaciones AT ROW 8.14 COL 10 COLON-ALIGNED HELP
          "" WIDGET-ID 62
          LABEL "Observ" FORMAT "x(100)"
     Bobserv AT ROW 8.14 COL 96.2 WIDGET-ID 86
     Evento.LetraPrefijo AT ROW 8.14 COL 113.2 COLON-ALIGNED NO-LABEL WIDGET-ID 148
          VIEW-AS FILL-IN 
          SIZE 10.8 BY 1
     Evento.nro_certificado AT ROW 8.14 COL 124.6 COLON-ALIGNED NO-LABEL WIDGET-ID 144
          VIEW-AS FILL-IN 
          SIZE 11.8 BY 1
     Bmobs AT ROW 8.14 COL 139 WIDGET-ID 92
     Evento.tipo_certif AT ROW 8.19 COL 106 COLON-ALIGNED WIDGET-ID 146
          LABEL "Certif." FORMAT "xxx"
          VIEW-AS FILL-IN 
          SIZE 6.4 BY 1
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1 SCROLLABLE  WIDGET-ID 100.

/* DEFINE FRAME statement is approaching 4K Bytes.  Breaking it up   */
DEFINE FRAME F-Main
     leyenda_contrato AT ROW 9.33 COL 10 COLON-ALIGNED WIDGET-ID 138
     b-alerta AT ROW 9.33 COL 134.4 WIDGET-ID 140
     Evento.url1 AT ROW 10 COL 120.8 COLON-ALIGNED WIDGET-ID 152
          VIEW-AS FILL-IN 
          SIZE 22 BY 1
     Evento.Leyenda AT ROW 10.52 COL 10 COLON-ALIGNED WIDGET-ID 82 FORMAT "x(400)"
          VIEW-AS FILL-IN 
          SIZE 121.4 BY 1 TOOLTIP "Leyenda publico dirigido al cliente"
     Bleyenda AT ROW 10.52 COL 134.4 WIDGET-ID 88
     label-TA AT ROW 3.71 COL 80.8 COLON-ALIGNED NO-LABEL WIDGET-ID 134
     label-AV AT ROW 4.86 COL 80.8 COLON-ALIGNED NO-LABEL WIDGET-ID 132
     RECT-7 AT ROW 1 COL 77 WIDGET-ID 48
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1 SCROLLABLE  WIDGET-ID 100.


/* *********************** Procedure Settings ************************ */

&ANALYZE-SUSPEND _PROCEDURE-SETTINGS
/* Settings for THIS-PROCEDURE
   Type: SmartViewer
   External Tables: sic.Evento
   Allow: Basic,DB-Fields
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
  CREATE WINDOW V-table-Win ASSIGN
         HEIGHT             = 10.67
         WIDTH              = 143.8.
/* END WINDOW DEFINITION */
                                                                        */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _INCLUDED-LIB V-table-Win 
/* ************************* Included-Libraries *********************** */

{valida_fechas.i}
{src/adm/method/Vortex.i}
{src/adm/method/viewer.i}

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME




/* ***********  Runtime Attributes and AppBuilder Settings  *********** */

&ANALYZE-SUSPEND _RUN-TIME-ATTRIBUTES
/* SETTINGS FOR WINDOW V-table-Win
  VISIBLE,,RUN-PERSISTENT                                               */
/* SETTINGS FOR FRAME F-Main
   NOT-VISIBLE FRAME-NAME Size-to-Fit                                   */
ASSIGN 
       FRAME F-Main:SCROLLABLE       = FALSE
       FRAME F-Main:HIDDEN           = TRUE.

/* SETTINGS FOR BUTTON banal IN FRAME F-Main
   NO-ENABLE                                                            */
ASSIGN 
       banal:HIDDEN IN FRAME F-Main           = TRUE.

/* SETTINGS FOR BUTTON bAviso IN FRAME F-Main
   NO-ENABLE                                                            */
ASSIGN 
       bAviso:HIDDEN IN FRAME F-Main           = TRUE.

ASSIGN 
       Bcertif:POPUP-MENU IN FRAME F-Main       = MENU POPUP-MENU-Bcertif:HANDLE.

/* SETTINGS FOR BUTTON Bleyenda IN FRAME F-Main
   NO-ENABLE                                                            */
/* SETTINGS FOR BUTTON Bleyenda-2 IN FRAME F-Main
   NO-ENABLE                                                            */
/* SETTINGS FOR TOGGLE-BOX Evento.Bloqueado IN FRAME F-Main
   EXP-LABEL                                                            */
/* SETTINGS FOR BUTTON Bmobs IN FRAME F-Main
   NO-ENABLE                                                            */
/* SETTINGS FOR BUTTON Bobserv IN FRAME F-Main
   NO-ENABLE                                                            */
/* SETTINGS FOR BUTTON Bobserv-2 IN FRAME F-Main
   NO-ENABLE                                                            */
/* SETTINGS FOR BUTTON bOT IN FRAME F-Main
   NO-ENABLE                                                            */
/* SETTINGS FOR BUTTON BRECURSOS IN FRAME F-Main
   NO-ENABLE                                                            */
/* SETTINGS FOR BUTTON b_infoadic IN FRAME F-Main
   ALIGN-R                                                              */
/* SETTINGS FOR COMBO-BOX c_nro_tipo_evento IN FRAME F-Main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN Evento.dreminder IN FRAME F-Main
   EXP-LABEL                                                            */
/* SETTINGS FOR FILL-IN Evento.Duracion IN FRAME F-Main
   EXP-LABEL                                                            */
ASSIGN 
       durtotal:READ-ONLY IN FRAME F-Main        = TRUE.

/* SETTINGS FOR FILL-IN Evento.EVSigue IN FRAME F-Main
   EXP-FORMAT                                                           */
/* SETTINGS FOR FILL-IN Evento.FAsignado IN FRAME F-Main
   EXP-LABEL                                                            */
/* SETTINGS FOR FILL-IN Evento.FCreado IN FRAME F-Main
   NO-ENABLE                                                            */
ASSIGN 
       Evento.FCreado:READ-ONLY IN FRAME F-Main        = TRUE.

/* SETTINGS FOR FILL-IN Evento.FMax IN FRAME F-Main
   EXP-LABEL                                                            */
/* SETTINGS FOR FILL-IN Evento.FMin IN FRAME F-Main
   EXP-LABEL                                                            */
/* SETTINGS FOR FILL-IN Evento.FRealizado IN FRAME F-Main
   NO-ENABLE EXP-LABEL                                                  */
/* SETTINGS FOR FILL-IN Evento.hora_desde IN FRAME F-Main
   EXP-LABEL EXP-FORMAT                                                 */
/* SETTINGS FOR FILL-IN Evento.hora_hasta IN FRAME F-Main
   EXP-LABEL EXP-FORMAT                                                 */
/* SETTINGS FOR FILL-IN Evento.LetraPrefijo IN FRAME F-Main
   NO-ENABLE EXP-LABEL                                                  */
/* SETTINGS FOR FILL-IN Evento.Leyenda IN FRAME F-Main
   NO-ENABLE EXP-FORMAT                                                 */
/* SETTINGS FOR FILL-IN leyenda_contrato IN FRAME F-Main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN nom_admin IN FRAME F-Main
   NO-ENABLE                                                            */
ASSIGN 
       nom_admin:READ-ONLY IN FRAME F-Main        = TRUE.

/* SETTINGS FOR FILL-IN Evento.nro_certificado IN FRAME F-Main
   NO-ENABLE EXP-LABEL                                                  */
/* SETTINGS FOR FILL-IN Evento.nro_evento IN FRAME F-Main
   EXP-LABEL                                                            */
ASSIGN 
       Evento.nro_evento:READ-ONLY IN FRAME F-Main        = TRUE.

/* SETTINGS FOR FILL-IN Evento.nro_evento_padre IN FRAME F-Main
   EXP-LABEL                                                            */
ASSIGN 
       Evento.nro_evento_padre:READ-ONLY IN FRAME F-Main        = TRUE.

/* SETTINGS FOR FILL-IN Evento.nro_identificacion IN FRAME F-Main
   NO-ENABLE EXP-LABEL                                                  */
ASSIGN 
       Evento.nro_identificacion:READ-ONLY IN FRAME F-Main        = TRUE.

/* SETTINGS FOR FILL-IN Evento.nro_planasignar IN FRAME F-Main
   EXP-LABEL                                                            */
/* SETTINGS FOR FILL-IN Observaciones IN FRAME F-Main
   NO-ENABLE LIKE = sic.Evento. EXP-LABEL EXP-FORMAT EXP-HELP EXP-SIZE  */
/* SETTINGS FOR FILL-IN Evento.Origen IN FRAME F-Main
   NO-ENABLE                                                            */
ASSIGN 
       Evento.Origen:READ-ONLY IN FRAME F-Main        = TRUE.

/* SETTINGS FOR FILL-IN Evento.Periodo IN FRAME F-Main
   EXP-LABEL EXP-FORMAT                                                 */
/* SETTINGS FOR FILL-IN Evento.Recursos IN FRAME F-Main
   EXP-FORMAT                                                           */
/* SETTINGS FOR FILL-IN Evento.Reminder IN FRAME F-Main
   NO-ENABLE 2 EXP-FORMAT                                               */
/* SETTINGS FOR FILL-IN Evento.sub_evento IN FRAME F-Main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN Evento.tipo_certif IN FRAME F-Main
   NO-ENABLE EXP-LABEL EXP-FORMAT                                       */
/* SETTINGS FOR FILL-IN Evento.Transporte IN FRAME F-Main
   EXP-LABEL                                                            */
/* SETTINGS FOR FILL-IN Evento.Turno IN FRAME F-Main
   EXP-LABEL EXP-FORMAT                                                 */
ASSIGN 
       Evento.url1:HIDDEN IN FRAME F-Main           = TRUE.

ASSIGN 
       v-modo:READ-ONLY IN FRAME F-Main        = TRUE.

ASSIGN 
       v-perant:READ-ONLY IN FRAME F-Main        = TRUE.

ASSIGN 
       v-stavisado:READ-ONLY IN FRAME F-Main        = TRUE.

ASSIGN 
       v-sttarea:READ-ONLY IN FRAME F-Main        = TRUE.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME


/* Setting information for Queries and Browse Widgets fields            */

&ANALYZE-SUSPEND _QUERY-BLOCK FRAME F-Main
/* Query rebuild information for FRAME F-Main
     _Options          = "NO-LOCK"
     _Query            is NOT OPENED
*/  /* FRAME F-Main */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME b-alerta
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL b-alerta V-table-Win
ON CHOOSE OF b-alerta IN FRAME F-Main /* Leyenda */
DO:
  RUN d-editorstr.w (INPUT-OUTPUT leyenda_contrato,FALSE ).
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME Bagenda_recurso
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Bagenda_recurso V-table-Win
ON CHOOSE OF Bagenda_recurso IN FRAME F-Main /* Agenda */
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


&Scoped-define SELF-NAME banal
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL banal V-table-Win
ON CHOOSE OF banal IN FRAME F-Main /* Imp. Aviso */
DO:
    DEFINE BUFFER btarea FOR tarea.
    IF NOT evento.frealizado<>? THEN DO:
    MESSAGE "El evento no esta realizado, falta la OT" VIEW-AS ALERT-BOX INFORMATION.
        RETURN NO-APPLY.
    END.
    IF evento.anulado THEN DO:
        MESSAGE "El evento esta anulado" VIEW-AS ALERT-BOX INFORMATION.
        RETURN NO-APPLY.
    END.
    FIND evento_protocolo OF evento NO-ERROR.
    IF AVAILABLE evento_protocolo THEN DO:
        IF index("PI",evento_protocolo.estado) = 0  THEN DO:
            MESSAGE "El protocolo no tiene es estado adecuado para imprimirse" VIEW-AS ALERT-BOX INFORMATION.
            RETURN NO-APPLY.
        END.
    END.

    EMPTY TEMP-TABLE aimp.
    CREATE aimp.
    ASSIGN aimp.c_nro_tipo_evento = evento.nro_tipo_evento
           aimp.nro_evento = evento.nro_evento.
    /*FIND btarea WHERE btarea.cdg_tipotarea = "J" AND btarea.estado = "R" AND
                     btarea.nro_evento = evento.nro_evento NO-LOCK NO-ERROR.
    IF AVAILABLE btarea THEN DO:
         IF NOT logical(extrae("tienelibro",btarea.datos-template)) THEN aimp.tipoespecial = "EC".
    END.*/
    FIND impresora WHERE impresora.cdg_impresora = 12 NO-LOCK.
    MESSAGE "El analisis se realizara por la impresora (" impresora.cdg_impresora ")" Impresora.nombre
        VIEW-AS ALERT-BOX INFORMATION.
    RUN analisisdef.p ( INPUT TABLE aimp ,12 ).
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bAviso
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bAviso V-table-Win
ON CHOOSE OF bAviso IN FRAME F-Main /* Imp. Aviso */
/*------------------------------------------------------------------------------
  Purpose:     imprime el aviso para el cliente
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DO:
    IF evento.anulado THEN DO:
        MESSAGE "El evento esta anulado no puede imprimirse el aviso"
            VIEW-AS ALERT-BOX ERROR.
        RETURN NO-APPLY.
    END.
{findempresa.i}
DEFINE VAR i AS INT NO-UNDO.
DEFINE BUFFER realevento FOR evento.
DEFINE BUFFER baviso FOR evento.
  EMPTY TEMP-TABLE aimp.
  IF evento.origen = "AVISO" THEN DO:
     FIND realevento WHERE realevento.nro_evento = evento.refevento NO-LOCK NO-ERROR.
     FIND baviso WHERE ROWID(baviso) = ROWID(evento) NO-LOCK NO-ERROR.
  END.
  ELSE DO:
     FIND realevento WHERE rowid(realevento) = rowid(evento) NO-LOCK NO-ERROR.
     FIND baviso WHERE baviso.refevento = evento.nro_evento AND NOT baviso.anulado NO-LOCK NO-ERROR.
  END.
  IF NOT available(realevento) OR NOT AVAILABLE(baviso) THEN DO:
        MESSAGE "Verifique no se encuentra o el aviso o el evento" VIEW-AS ALERT-BOX ERROR.
  END.
  IF NOT baviso.impreso THEN DO:
     MESSAGE "El aviso no esta impreso, realizelo desde el impresor de eventos" VIEW-AS ALERT-BOX ERROR.
     RETURN NO-APPLY.
  END.
  IF realevento.anulado THEN DO:
      MESSAGE "El evento que referencia este aviso esta anulado" VIEW-AS ALERT-BOX ERROR.
      RETURN NO-APPLY.
  END.
  
  CREATE aimp.
  ASSIGN aimp.c_nro_tipo_evento = realevento.nro_tipo_evento
         aimp.nro_evento = realevento.nro_evento
         aimp.aviso_fasignado = realevento.fasignado 
         aimp.aviso_evento = baviso.nro_evento 
         aimp.aviso_recurso = baviso.recurso.
  RUN printavisos2.p ( INPUT TABLE aimp,  1). 

 END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME Bcertif
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Bcertif V-table-Win
ON CHOOSE OF Bcertif IN FRAME F-Main /* Button 13 */
DO:
DEFINE VAR conf AS LOGICAL.
DEFINE VAR timpre AS INT NO-UNDO.

    IF evento.anulado THEN DO:
        MESSAGE "El evento esta anulado no puede imprimirse el certificado"
            VIEW-AS ALERT-BOX ERROR.
        RETURN NO-APPLY.
    END.
    IF evento.nro_certif = 0 THEN DO:
        MESSAGE "El evento aun NO tiene impreso el certificado" SKIP
                "quiere generarlo en este momento" VIEW-AS ALERT-BOX QUESTION BUTTONS YES-NO SET conf.
        IF conf THEN DO:
           IF evento.nro_tipo_evento = 1 THEN timpre = 8.
           IF evento.nro_tipo_evento = 3 THEN timpre = 9.
           FIND impresora WHERE impresora.cdg_impresora = timpre NO-LOCK NO-ERROR.
           MESSAGE "El certificado se imprimira por la impresora (" timpre ")" impresora.nombre
                VIEW-AS ALERT-BOX INFORMATION.
           RUN  impcertif.p ( evento.nro_evento , "*" , timpre ).
        END.
    END.
    ELSE  do:
        /*IF evento.nro_tipo_evento <> 1 THEN DO:
            MESSAGE "Solamente los certificados de FUMIGACION tienen estas opciones" VIEW-AS ALERT-BOX INFORMATION.
            LEAVE.
        END. */
        IF NOT ( MENU-ITEM m_Impreso:CHECKED IN MENU  POPUP-MENU-Bcertif OR
            MENU-ITEM m_email:CHECKED IN MENU  POPUP-MENU-Bcertif OR
                 MENU-ITEM m_PDF:CHECKED IN MENU  POPUP-MENU-Bcertif ) THEN DO:
            MESSAGE "Seleccione como se va reenviar el certificado" VIEW-AS ALERT-BOX INFORMATION.
            RETURN NO-APPLY.
        END.
        IF MENU-ITEM m_Impreso:CHECKED IN MENU  POPUP-MENU-Bcertif THEN DO:
            IF evento.nro_tipo_evento = 1 THEN timpre = 8.
            IF evento.nro_tipo_evento = 3 THEN timpre = 9.
            FIND impresora WHERE impresora.cdg_impresora = timpre NO-LOCK NO-ERROR.
            MESSAGE "El certificado se imprimira por la impresora (" timpre ")" impresora.nombre
                VIEW-AS ALERT-BOX INFORMATION.
            
            RUN  impcertif.p ( evento.nro_evento , "*" , timpre ).
        END.
        IF MENU-ITEM m_PDF:CHECKED IN MENU  POPUP-MENU-Bcertif THEN RUN pdfcertiffumi.p(evento.nro_evento,"").
        IF MENU-ITEM m_email:CHECKED IN MENU  POPUP-MENU-Bcertif THEN  do:
            IF evento.nro_certif = 0 THEN DO:
                    MESSAGE "Aun no se ha cargado el certificado de este evento no puede enviarse"
                        VIEW-AS ALERT-BOX ERROR.
            END.
            ELSE DO:
                CREATE BATCH.
                BATCH.fecha = NOW.
                IF evento.url1<>"" THEN BATCH.prgm = "s-emailco.p".
                ELSE BATCH.prgm = "s-emailcf.p".
                batch.parametro[1] = STRING(evento.nro_evento).
                RELEASE BATCH.
                MESSAGE "Se ha programado un envio de email" VIEW-AS ALERT-BOX INFORMATION.
            END.
        END.

    END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME Bleyenda
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Bleyenda V-table-Win
ON CHOOSE OF Bleyenda IN FRAME F-Main /* Button 12 */
DO:
  DEFINE BUFFER bevento FOR evento.
  DEFINE VAR aedit AS CHAR NO-UNDO.
  aedit = evento.leyenda.
  RUN d-editorstr.w (INPUT-OUTPUT aedit,periodo:SENSITIVE ).
  evento.leyenda:SCREEN-VALUE = aedit.
  FIND bevento WHERE ROWID(bevento) = ROWID(evento).
  bevento.leyenda = aedit.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME Bleyenda-2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Bleyenda-2 V-table-Win
ON CHOOSE OF Bleyenda-2 IN FRAME F-Main /* Bleyenda 2 */
DO:
  DEFINE VAR aedit AS CHAR NO-UNDO.
  aedit = evento.reminder:SCREEN-VALUE.
  RUN d-editorstr.w (INPUT-OUTPUT aedit,periodo:SENSITIVE ).
  evento.reminder:SCREEN-VALUE = aedit.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME Bmobs
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Bmobs V-table-Win
ON CHOOSE OF Bmobs IN FRAME F-Main /* Bobserv 2 */
DO:
  /*DEFINE VAR aedit AS CHAR NO-UNDO.
  RUN d-editorstr.w (INPUT-OUTPUT evento.mobs, FALSE ).*/

    DEFINE VAR a AS CHAR NO-UNDO.
    DEFINE VAR b AS CHAR NO-UNDO.
    a = string(evento.nro_certificado).
    b = Evento.URL1.
  
    RUN d-qrcode.w ( INPUT-OUTPUT a, INPUT-OUTPUT b ).
    Evento.LetraPrefijo:SCREEN-VALUE = "ELE".
    evento.nro_certificado:SCREEN-VALUE = a.
    evento.URL1:SCREEN-VALUE = b.
    
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME Bobserv
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Bobserv V-table-Win
ON CHOOSE OF Bobserv IN FRAME F-Main /* Button 11 */
DO:
  DEFINE VAR aedit AS CHAR NO-UNDO.
  DEFINE VAR opt AS LOGICAL.
  aedit = observaciones:PRIVATE-DATA IN FRAME {&FRAME-NAME}.
  RUN c-edttexto-avanzado.w (INPUT-OUTPUT aedit, "OBSERVACIONES",evento.periodo:SENSITIVE,OUTPUT opt ).
  IF opt THEN DO:
       observaciones:PRIVATE-DATA = aedit. 
       RUN loadAdvTTTexto( aedit , OUTPUT TABLE tttexto ).
       observaciones:SCREEN-VALUE IN FRAME {&FRAME-NAME}= cortoAdvTexto( TABLE tttexto ). 
  END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME Bobserv-2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Bobserv-2 V-table-Win
ON CHOOSE OF Bobserv-2 IN FRAME F-Main /* Bobserv 2 */
DO:
  DEFINE VAR aedit AS CHAR NO-UNDO.
  aedit = evento.transporte:SCREEN-VALUE.
  RUN d-editorstr.w (INPUT-OUTPUT aedit, evento.transporte:SENSITIVE ).
  evento.transporte:SCREEN-VALUE = aedit.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bOT
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bOT V-table-Win
ON CHOOSE OF bOT IN FRAME F-Main /* Imp. Aviso */
DO:
    DEFI VAR xfile AS CHAR NO-UNDO.
    DEF VAR ReportePath AS CHAR NO-UNDO.
    DEF VAR cFullPath AS CHAR NO-UNDO.
    DEF VAR XFullPath AS CHAR NO-UNDO.
    DEF VAR exportFileName AS CHAR NO-UNDO.
    DEFINE VAR p-des_fecha AS DATE.
    DEFINE VAR p-has_fecha AS DATE.
    DEFINE VAR ERROR_rango AS LOGICAL.
    DEFINE VAR opc AS LOGICAL NO-UNDO.

        IF evento.anulado THEN DO:
        MESSAGE "El evento esta anulado no puede imprimirse la OT"
            VIEW-AS ALERT-BOX ERROR.
        RETURN NO-APPLY.
    END.
    IF fac_bloqueo( evento.nro_cliente , 3 ) THEN DO:
        IF USERID("sic") <> "canepa" THEN DO:
        MESSAGE "El cliente esta bloqueado por adeudo de tres facturas"
            VIEW-AS ALERT-BOX INFO BUTTONS OK.
        RETURN NO-APPLY.
        END.
        ELSE DO:
            MESSAGE "El cliente esta bloqueado por adeudo de tres facturas"
                "Quiere permitirlo de todas maneras"
            VIEW-AS ALERT-BOX question BUTTONS YES-NO UPDATE opc.
            IF NOT opc THEN RETURN NO-APPLY.
        END.
    END.
  
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
    IF evento.nro_tipo_evento <> 1 THEN RETURN. /*como es para FU no tengo que tener en cuenta la cuota*/
    FIND contrato_hd WHERE contrato_hd.nro_contrato = evento.nro_identificacion.
    FIND contrato_restriccion OF restriccion WHERE contrato_restriccion.nro_contrato = evento.nro_identificacion AND contrato_restriccion.sub_evento = 1 NO-LOCK NO-ERROR.
    IF NOT AVAILABLE contrato_restriccion THEN RETURN.
    IF contrato_restriccion.valor <> "O" THEN RETURN.
    FOR EACH bevento NO-LOCK WHERE bevento.nro_identificacion = evento.nro_identificacion AND bevento.periodo = evento.periodo AND 
        NOT evento.anulado AND bevento.nro_tipo_evento = evento.nro_tipo_evento BY bevento.sub_evento DESC:
        LEAVE.
    END.
    IF ROWID(bevento) <> ROWID(evento) THEN NEXT. /*para saber si es el ultimo*/
    MESSAGE "Desea imprimir el certificado" VIEW-AS ALERT-BOX BUTTONS YES-NO SET opc .
    IF opc THEN RUN impcertif.p ( evento.nro_evento , "O" , 8).
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME BRECURSOS
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL BRECURSOS V-table-Win
ON CHOOSE OF BRECURSOS IN FRAME F-Main /* Recursos */
DO:
  DEF VAR lista AS CHAR.
  lista = evento.recursos:SCREEN-VALUE.
  RUN d-recursos.w (INPUT-OUTPUT lista,STRING(c_nro_tipo_evento:INPUT-VALUE)).
  evento.recursos:SCREEN-VALUE = lista.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME BUTTON-1
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL BUTTON-1 V-table-Win
ON CHOOSE OF BUTTON-1 IN FRAME F-Main /* Button 1 */
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


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL BUTTON-1 V-table-Win
ON DROP-FILE-NOTIFY OF BUTTON-1 IN FRAME F-Main /* Button 1 */
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


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL BUTTON-1 V-table-Win
ON MOUSE-MENU-CLICK OF BUTTON-1 IN FRAME F-Main /* Button 1 */
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


&Scoped-define SELF-NAME Bvecino
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Bvecino V-table-Win
ON CHOOSE OF Bvecino IN FRAME F-Main /* Vec. */
DO:
FIND cliente WHERE cliente.nro_cliente = evento.nro_cliente NO-LOCK NO-ERROR.
IF NOT AVAILABLE cliente THEN DO:
    MESSAGE "Cliente No registrado" VIEW-AS ALERT-BOX ERROR.
    RETURN NO-APPLY.
END.
IF cliente.geolat = 0 THEN DO:
    MESSAGE "Cliente No georeferenciado" VIEW-AS ALERT-BOX ERROR.
    RETURN NO-APPLY.
END.

cerrar(h_vecinos).

IF evento.origen = "COBRANZA" THEN
        RUN w-vecinosCO.w PERSISTENT SET h_vecinos ( evento.nro_evento,"E",5000,THIS-PROCEDURE,evento.fmin:INPUT-VALUE,
                       evento.fmax:INPUT-VALUE,?,?).
ELSE
        RUN w-vecinosEV.w PERSISTENT  SET h_vecinos ( 
                       c_nro_tipo_evento:INPUT-VALUE ,
                       evento.fmin:INPUT-VALUE,
                       evento.fmax:INPUT-VALUE,
                       3000,
                       evento.nro_evento,
                       cliente.geolat,
                       cliente.geolong,
                       Cliente.nom_cliente + '<BR>Dir:' + cliente.direccion,
                       cliente.cdg_cliente,
                       cliente.direccion,
                       THIS-PROCEDURE, 
                       evento.duracion:INPUT-VALUE ).

RUN dispatch IN h_vecinos ( INPUT 'initialize':U ) .

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME Bzoom
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Bzoom V-table-Win
ON CHOOSE OF Bzoom IN FRAME F-Main /* Button 15 */
DO:
  IF evento.origen = "COBRANZA" THEN RUN d-zoom-tareaC.w(evento.nro_identificacion,"DETALLE").
  ELSE DO: 
      FIND tarea OF evento NO-LOCK NO-ERROR.
      IF AVAILABLE tarea THEN MESSAGE "Tarea" tarea.nro_tarea VIEW-AS ALERT-BOX INFORMATION.
ELSE
      MESSAGE "No implementado aun" VIEW-AS ALERT-BOX INFORMATION.
      RETURN NO-APPLY.
  END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME b_infoadic
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL b_infoadic V-table-Win
ON CHOOSE OF b_infoadic IN FRAME F-Main /* Inf.Adicional */
DO:
  IF evento.origen = "CONTRATO" THEN
  RUN d-contrato_restriccion.w ( INPUT evento.nro_identificacion:INPUT-VALUE IN FRAME {&FRAME-NAME}).
  ELSE
  RUN d-cliente_restriccion.w ( INPUT evento.nro_cliente ).
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME Evento.EVSigue
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Evento.EVSigue V-table-Win
ON MOUSE-MENU-CLICK OF Evento.EVSigue IN FRAME F-Main /* EVSigue */
DO:
    RUN d-padrehijo.w (evento.evsigue:INPUT-VALUE).
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME Evento.FAsignado
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Evento.FAsignado V-table-Win
ON MOUSE-MENU-DOWN OF Evento.FAsignado IN FRAME F-Main /* Asign. */
DO:
   {selfecha.i}
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Evento.FAsignado V-table-Win
ON MOUSE-SELECT-DBLCLICK OF Evento.FAsignado IN FRAME F-Main /* Asign. */
DO:
DEFINE VAR pnro_cliente LIKE cliente.nro_cliente.
DEFINE VAR hproc AS HANDLE.
DEFINE VAR hcproc AS CHARACTER.
        
RUN get-link-handle IN adm-broker-hdl
        ( INPUT THIS-PROCEDURE,
          INPUT "record-source",
          OUTPUT hcproc ).
          hproc = WIDGET-HANDLE( hcproc ).
IF evento.nro_cliente = 0 THEN
    pnro_cliente = IF VALID-HANDLE(hProc) THEN dynamic-function('que_cliente' IN hproc ) ELSE ?.    
ELSE
    pnro_cliente = evento.nro_cliente.
FIND cliente WHERE cliente.nro_cliente = pnro_cliente NO-ERROR.
IF NOT AVAILABLE cliente THEN DO:
    MESSAGE "Cliente No registrado" VIEW-AS ALERT-BOX ERROR.
    RETURN NO-APPLY.
END.
IF cliente.geolat = 0 THEN DO:
    MESSAGE "Cliente No georeferenciado" VIEW-AS ALERT-BOX ERROR.
    RETURN NO-APPLY.
END.
    IF NOT VALID-HANDLE(h_vecinos) THEN DO:
        IF evento.origen = "COBRANZA" THEN
                RUN w-vecinosCO.w PERSISTENT SET h_vecinos ( evento.nro_evento,"E",THIS-PROCEDURE).
        ELSE
                RUN w-vecinosEV.w PERSISTENT  SET h_vecinos ( c_nro_tipo_evento:INPUT-VALUE ,
                               evento.fmin:INPUT-VALUE,
                               evento.fmax:INPUT-VALUE,
                               0 /* evento.nro_evento */ ,
                               cliente.geolat,
                               cliente.geolong,
                               Cliente.nom_cliente + '<BR>Dir:' + cliente.direccion,
                               THIS-PROCEDURE ).
        RUN dispatch IN h_vecinos ( INPUT 'initialize':U ) .
    END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME Evento.FMax
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Evento.FMax V-table-Win
ON MOUSE-MENU-DOWN OF Evento.FMax IN FRAME F-Main /* a */
DO:
{selfecha.i}
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME Evento.FMin
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Evento.FMin V-table-Win
ON LEAVE OF Evento.FMin IN FRAME F-Main /* F.Analisis */
DO:

  evento.periodo:SCREEN-VALUE IN FRAME {&FRAME-NAME} = string( YEAR( {&SELF-NAME}:INPUT-VALUE ) * 100 + MONTH({&SELF-NAME}:INPUT-VALUE)).
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Evento.FMin V-table-Win
ON MOUSE-MENU-DOWN OF Evento.FMin IN FRAME F-Main /* F.Analisis */
DO:
{selfecha.i}
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME Evento.FRealizado
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Evento.FRealizado V-table-Win
ON MOUSE-MENU-DOWN OF Evento.FRealizado IN FRAME F-Main /* FRealiz. */
DO:
{selfecha.i}
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME Evento.hora_desde
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Evento.hora_desde V-table-Win
ON LEAVE OF Evento.hora_desde IN FRAME F-Main /* Hora */
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


&Scoped-define SELF-NAME Evento.hora_hasta
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Evento.hora_hasta V-table-Win
ON LEAVE OF Evento.hora_hasta IN FRAME F-Main /* Hora!Hasta */
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


&Scoped-define SELF-NAME Evento.Leyenda
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Evento.Leyenda V-table-Win
ON MOUSE-MENU-DOWN OF Evento.Leyenda IN FRAME F-Main /* Leyenda */
DO:
APPLY "choose" TO bleyenda.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME m_Email
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL m_Email V-table-Win
ON VALUE-CHANGED OF MENU-ITEM m_Email /* Email */
DO:
  IF MENU-ITEM m_email:CHECKED IN MENU  POPUP-MENU-Bcertif THEN DO:
    MENU-ITEM m_impreso:CHECKED IN MENU  POPUP-MENU-Bcertif = FALSE.
    MENU-ITEM m_pdf:CHECKED IN MENU  POPUP-MENU-Bcertif = FALSE.
  END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME m_Impreso
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL m_Impreso V-table-Win
ON VALUE-CHANGED OF MENU-ITEM m_Impreso /* Impreso */
DO:
  IF MENU-ITEM m_impreso:CHECKED IN MENU  POPUP-MENU-Bcertif THEN DO:
    MENU-ITEM m_email:CHECKED IN MENU  POPUP-MENU-Bcertif = FALSE.
    MENU-ITEM m_pdf:CHECKED IN MENU  POPUP-MENU-Bcertif = FALSE.
  END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME m_PDF
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL m_PDF V-table-Win
ON VALUE-CHANGED OF MENU-ITEM m_PDF /* PDF */
DO:
    IF MENU-ITEM m_pdf:CHECKED IN MENU  POPUP-MENU-Bcertif THEN DO:
    MENU-ITEM m_email:CHECKED IN MENU  POPUP-MENU-Bcertif = FALSE.
    MENU-ITEM m_impreso:CHECKED IN MENU  POPUP-MENU-Bcertif = FALSE.
  END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME Evento.nro_evento
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Evento.nro_evento V-table-Win
ON MOUSE-MENU-CLICK OF Evento.nro_evento IN FRAME F-Main /* Evento */
DO:
      RUN d-padrehijo.w ({&SELF-NAME}:INPUT-VALUE).
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME Evento.nro_evento_padre
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Evento.nro_evento_padre V-table-Win
ON MOUSE-MENU-CLICK OF Evento.nro_evento_padre IN FRAME F-Main /* Padre */
DO:
  RUN d-padrehijo.w ({&SELF-NAME}:INPUT-VALUE).
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME Observaciones
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Observaciones V-table-Win
ON MOUSE-MENU-DOWN OF Observaciones IN FRAME F-Main /* Observ */
DO:
APPLY "choose" TO bobserv.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME Evento.REFevento
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Evento.REFevento V-table-Win
ON MOUSE-MENU-CLICK OF Evento.REFevento IN FRAME F-Main /* Ref.Evento */
DO:
    RUN d-padrehijo.w ({&SELF-NAME}:INPUT-VALUE).
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME Evento.Turno
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Evento.Turno V-table-Win
ON LEAVE OF Evento.Turno IN FRAME F-Main /* TU */
DO:
  SELF:SCREEN-VALUE = CAPS(SELF:SCREEN-VALUE).
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&UNDEFINE SELF-NAME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _MAIN-BLOCK V-table-Win 


/* ***************************  Main Block  *************************** */

  &IF DEFINED(UIB_IS_RUNNING) <> 0 &THEN          
    RUN dispatch IN THIS-PROCEDURE ('initialize':U).        
  &ENDIF         
  
  /************************ INTERNAL PROCEDURES ********************/

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


/* **********************  Internal Procedures  *********************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE aborrar_desasignar_evento V-table-Win 
PROCEDURE aborrar_desasignar_evento :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:Desasigna un evento en particular
------------------------------------------------------------------------------*/
DEFINE INPUT PARAM nroe LIKE evento.nro_evento.
FIND evento WHERE evento.nro_evento = nroe.
/*RUN recupcertif(nroe).*/
FOR EACH recurso_agenda OF evento:
    DELETE recurso_agenda.
END.
FOR EACH tarea OF evento WHERE lookup(tarea.cdg_tipotarea,"TZY") <> 0 AND tarea.estado <> "D":
      tarea.estado = "D".
      tarea.descripcion = agregaAdvTexto("Descartada al cambiar asignacion evento:" + string(evento.nro_evento) ,tarea.descripcion).
END.
    
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE adm-row-available V-table-Win  _ADM-ROW-AVAILABLE
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

  /* Create a list of all the tables that we need to get.            */
  {src/adm/template/row-list.i "Evento"}

  /* Get the record ROWID's from the RECORD-SOURCE.                  */
  {src/adm/template/row-get.i}

  /* FIND each record specified by the RECORD-SOURCE.                */
  {src/adm/template/row-find.i "Evento"}

  /* Process the newly available records (i.e. display fields,
     open queries, and/or pass records on to any RECORD-TARGETS).    */
  {src/adm/template/row-end.i}

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE anula-cascada V-table-Win 
PROCEDURE anula-cascada :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
    DEFINE INPUT PARAM rr AS CHAR NO-UNDO.
    DEFINE BUFFER bb FOR evento.
    DEFINE VAR k AS INT.
    REPEAT k = 1 TO NUM-ENTRIES(rr):
        FIND FIRST BB WHERE BB.nro_evento = int( entry( k,rr )).
        BB.anulado = TRUE.
        BB.observacion = agregaAdvTexto("Anulado an reasignar evento principal" , BB.observacion).
        FOR EACH recurso_agenda WHERE recurso_agenda.nro_evento = BB.nro_evento:
           DELETE recurso_agenda.
        END.
     END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE borraavisos V-table-Win 
PROCEDURE borraavisos :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
    DEFINE INPUT PARAMETER nnro LIKE evento.nro_evento NO-UNDO.
    DEFINE BUFFER aviso FOR evento.
    FOR EACH aviso WHERE aviso.refevento = nnro AND NOT aviso.anulado:
        FOR EACH recurso_agenda WHERE recurso_agenda.nro_evento = aviso.nro_evento:
           DELETE recurso_agenda.
        END.
        DELETE aviso.        
     END.
     FOR EACH tarea WHERE tarea.nro_evento = nnro AND  tarea.estado = "A" AND ( tarea.cdg_tipotarea = "T" OR tarea.cdg_tipotarea = "Z" ):
                DELETE tarea.
     END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE calcula_fecha_aviso V-table-Win 
PROCEDURE calcula_fecha_aviso :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEFINE INPUT PARAM pnro AS INT NO-UNDO.
DEFINE BUFFER aviso FOR evento.
DEFINE BUFFER levento FOR evento.

FIND aviso WHERE aviso.nro_evento = pnro.
IF evento.origen = "CONTRATO" THEN DO:
          FIND restriccion WHERE restriccion.cdg_restriccion BEGINS "AVISO" AND
               restriccion.nro_tipo_evento = evento.nro_tipo_evento NO-LOCK NO-ERROR.
          IF NOT AVAILABLE restriccion THEN RETURN.
          FIND FIRST contrato_restriccion WHERE contrato_restriccion.nro_contrato = evento.nro_identificacion AND
                   contrato_restriccion.sub_evento = evento.sub_evento AND 
                   contrato_restriccion.nro_restriccion = restriccion.nro_restriccion NO-LOCK NO-ERROR.
          IF AVAILABLE contrato_restriccion THEN DO: /*hay que mandar aviso*/
            IF ENTRY(3 , contrato_restriccion.valor ,"|" ) = "E" THEN DO: /*lo tiene que generar*/
                     IF int(ENTRY( 2 , contrato_restriccion.valor , "|" )) >= 7 THEN 
                        aviso.fmax = resta_dia_habil( evento.fasignado:INPUT-VALUE IN FRAME {&FRAME-NAME}, int(ENTRY( 2 , contrato_restriccion.valor , "|" )),"234567" ).
                     ELSE
                        aviso.fmax = resta_dia_habil( evento.fasignado:INPUT-VALUE  , 7, "234567" ).
                     aviso.fmin = resta_dia_habil( evento.fasignado:INPUT-VALUE  , 10, "234567" ). 
                     IF aviso.fmax < TODAY - 1 THEN DO:
                        MESSAGE "AVISO ASIGNADO PARA HOY, asignelo ahora manualmente" VIEW-AS ALERT-BOX ERROR.
                     END.
                     IF aviso.fmin > aviso.fmax THEN aviso.fmin = aviso.fmax.
                     
            END.
            ELSE DO: /*es del tipo LLEVA analizar fecha si no paso el evento que lo llevaria*/
                     FIND FIRST levento WHERE NOT levento.anulado AND levento.periodo < aviso.periodo AND
                       levento.frealizado = ? AND levento.fasignado > TODAY AND
                       ROWID(levento) <> ROWID(evento)
                       NO-LOCK NO-ERROR.
       
                     IF AVAILABLE levento THEN DO:
                         aviso.fmin = evento.fasignado.
                         aviso.fmax = evento.fasignado.
                     END.
                     ELSE DO: /*es del tipo E por esta vez solo*/
                         IF int(ENTRY( 2 , contrato_restriccion.valor , "|" )) >= 7 THEN 
                            aviso.fmin = resta_dia_habil( evento.fasignado:INPUT-VALUE  , int(ENTRY( 2 , contrato_restriccion.valor , "|" )),"234567" ).
                         ELSE
                            aviso.fmin = resta_dia_habil( evento.fasignado:INPUT-VALUE  , 10, "234567" ).
                         IF aviso.fmin < TODAY THEN aviso.fmin = TODAY.
                         aviso.fmax = resta_dia_habil( evento.fasignado:INPUT-VALUE  , 7, "234567" ). 
                         IF aviso.fmax < aviso.fmin THEN aviso.fmax = aviso.fmin.
                         aviso.observacion = agregaAdvTexto( "Este mes funciona como tipo E-Genera Eventos , el mes que viene sera LLeva",aviso.observacion). 
                     END.
            END.
          END.
END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE cambiatareaconf V-table-Win 
PROCEDURE cambiatareaconf :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
    DEFINE INPUT PARAMETER rr AS ROWID.
    FIND evento WHERE ROWID(evento) = rr.
    FOR EACH tarea OF evento WHERE LOOKUP(tarea.cdg_tipotarea,"TZY") <> 0 :
                   IF tarea.estado = "A" THEN
                    DELETE tarea.
                   IF tarea.estado = "R" THEN DO:
                       tarea.estado = "D".
                       tarea.descripcion = agregaAdvTexto("Descartada al cambiar la asignacion del evento" , tarea.descripcion).
                   END.
    END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE crea_H-LT V-table-Win 
PROCEDURE crea_H-LT :
/*------------------------------------------------------------------------------
  Purpose: crea la tarea J al cerrar un LT confirmado desde aca.    
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEFINE VAR nnro AS INT.
DEFINE VAR nro_tipo_evento_rl LIKE tipo_evento.nro_tipo_evento NO-UNDO.
FIND tipo_evento WHERE tipo_evento.cdg_tipo_evento = "RL" NO-LOCK.
nro_tipo_evento_rl = tipo_evento.nro_tipo_evento.

IF evento.nro_tipo_evento <> nro_tipo_evento_tanque OR evento.sub_evento <> 1 OR 
   evento.origen <> "CONTRATO" THEN RETURN.
FIND evento_protocolo OF evento NO-ERROR.
IF NOT AVAILABLE evento_protocolo THEN RETURN.
IF evento_protocolo.estado <> "P" AND evento_protocolo.estado <> "I" THEN RETURN.
      /*verificar el libro y las tareas relacionadas*/
      IF Evento.trae_libro THEN DO: 
          FIND FIRST tarea  WHERE tarea.cdg_tipotarea = "H" AND tarea.origen = "EVENTO" AND tarea.nro_identificacion = evento.nro_evento and
                                         tarea.estado <> "D" NO-LOCK NO-ERROR.
          IF NOT AVAILABLE tarea THEN DO:
            FIND FIRST tarea WHERE tarea.cdg_tipotarea = "J" AND tarea.origen = "EVENTO" AND tarea.nro_identificacion = evento.nro_evento AND 
                                        tarea.estado <> "D" NO-LOCK NO-ERROR.
            IF NOT AVAILABLE tarea THEN DO: /*me aseguro que no fue por el camino de la J*/
               RUN crea_tarea.p( evento.nro_evento,evento.nro_cliente, "H" , "Origen EventoLT:" + STRING(evento.nro_evento),"Origen EventoLT:" + STRING(evento.nro_evento),TODAY,"*",OUTPUT nnro).
               FIND tarea WHERE tarea.nro_tarea = nnro NO-ERROR.
               IF NOT AVAILABLE tarea THEN DO:
                  DISPLAY "No se ha podido crear la tarea H para el evento" evento.nro_evento. 
                  NEXT.
               END.
               tarea.datos-template = "EVENTOLT|" + STRING(evento_protocolo.nro_evento).
            END.
            ELSE DO:
               FIND FIRST bevento WHERE bevento.origen = "TAREA" AND bevento.nro_identificacion = tarea.nro_tarea and
                                        bevento.nro_tipo_evento = nro_tipo_evento_RL AND NOT bevento.anulado NO-LOCK NO-ERROR.
               IF AVAILABLE bevento THEN DO:
                        IF bevento.frealizado <> ? THEN DO:
                           RUN crea_tarea.p( bevento.nro_evento,bevento.nro_cliente, "H" , "Origen EventoRL:" + STRING(bevento.nro_evento),"EventoLT:" + STRING(evento.nro_evento), TODAY,"*",OUTPUT nnro).
                           FIND tarea WHERE tarea.nro_tarea = nnro NO-ERROR.
                           IF NOT AVAILABLE tarea THEN DO:
                              DISPLAY "No se ha podido crear la tarea H para el evento" evento.nro_evento. 
                              NEXT.
                           END.
                           tarea.datos-template = "EVENTOLT|" + STRING(evento_protocolo.nro_evento).
                        END.
               END.
          
            END.
          END.
      END.
      /*ver si existen tareas J con tienelibro en falso y cerradas*/
      /*IF NOT evento.trae_libro AND ( evento_protocolo.estado = "P" OR evento_protocolo.estado = "I" )THEN DO:
            FOR each tarea WHERE tarea.cdg_tipotarea = "J" AND 
                                        tarea.nro_evento = evento.nro_evento AND 
                                        tarea.estado = "R" NO-LOCK:
              IF logical( extrae( "tienelibro", tarea.datos-template )) THEN LEAVE.
            END.
            IF AVAILABLE tarea THEN DO:
                /*creando el evento EC*/
                FIND tipo_evento WHERE tipo_evento.cdg_tipo_evento = "EC" NO-LOCK.
                CREATE evento.
                ASSIGN evento.nro_evento = NEXT-VALUE(proximo_evento)
                       evento.nro_tipo_evento = tipo_evento.nro_tipo_evento
                       evento.fasignado = ?
                       evento.nro_identificacion = tarea.nro_tarea /*porque deviene de una tarea J*/
                       evento.origen = "TAREA"
                       evento.nro_cliente = tarea.nro_cliente
                       Evento.FCreado = TODAY
                       evento.periodo = YEAR(today) * 100 + MONTH(today)
                       evento.fmin = TODAY
                       evento.fmax = TODAY + 20 /*fijo cualquier cosa se vera*/
                       evento.recurso = ""
                       evento.observacion = tarea.descripcion.
                       evento.duracion = 15.
                       tarea.destino = "EVENTO".
                       tarea.nro_destino = evento.nro_evento.
                       evento.turno = "**".
            END.
      END.      */
/*crear tarea J*/
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE crea_H-RL V-table-Win 
PROCEDURE crea_H-RL :
/*------------------------------------------------------------------------------
  Purpose: crea la tarea H si es evento RL y se esta realizando
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEFINE VAR nnro AS INT.
FIND tipo_evento WHERE tipo_evento.cdg_tipo_evento = "RL" NO-LOCK.
IF evento.nro_tipo_evento <> tipo_evento.nro_tipo_evento THEN RETURN.
FIND FIRST tarea WHERE tarea.nro_tarea = evento.nro_identificacion AND tarea.estado <> "D"  NO-ERROR.
IF NOT AVAILABLE tarea THEN DO:
   MESSAGE "No se encontro la tarea de origen " evento.nro_identificacion VIEW-AS ALERT-BOX ERROR.
   RETURN ERROR.
END.
FIND bevento WHERE bevento.nro_evento = tarea.nro_evento NO-ERROR.
IF NOT AVAILABLE bevento THEN DO:
   MESSAGE "No se encontro el evento " tarea.nro_evento VIEW-AS ALERT-BOX ERROR.
   RETURN ERROR.
END.
FIND evento_protocolo WHERE evento_protocolo.nro_evento = bevento.nro_evento NO-LOCK NO-ERROR.
IF NOT AVAILABLE evento_protocolo THEN RETURN.
IF evento_protocolo.estado <> "P" AND evento_protocolo.estado <> "I" THEN RETURN.
          FIND FIRST tarea OF cliente WHERE tarea.cdg_tipotarea = "H" AND tarea.origen = "EVENTO" AND tarea.nro_evento = evento.nro_evento and
                                         tarea.estado <> "D" NO-LOCK NO-ERROR.
          IF NOT AVAILABLE tarea THEN DO:
             RUN crea_tarea.p( evento.nro_evento,
                          evento.nro_cliente, "H" ,
                          "Origen EventoRL:" + STRING(evento.nro_evento) + "EventoLT:" + STRING(bevento.nro_evento), 
                          "*",
                          TODAY,"*",OUTPUT nnro).
             FIND tarea WHERE tarea.nro_tarea = nnro NO-ERROR.
             IF NOT AVAILABLE tarea THEN DO:
                DISPLAY "No se ha podido crear la tarea H para el evento" evento.nro_evento. 
                RETURN ERROR.
             END.
             tarea.datos-template = "EVENTOLT|" + STRING(evento_protocolo.nro_evento).
          END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE crea_J-LT V-table-Win 
PROCEDURE crea_J-LT :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
    DEFINE VAR nnro AS INT NO-UNDO.
    IF evento.nro_tipo_evento = nro_tipo_evento_tanque AND evento.origen = "CONTRATO" AND evento.sub_evento = 1 THEN DO:
            IF evento.trae_libro THEN RETURN.
            /*generar la tareaa de confirmacion de libro*/
            FIND tarea OF evento WHERE tarea.cdg_tipotarea = "J" AND tarea.estado <> "D" NO-LOCK NO-ERROR.
            IF NOT AVAILABLE tarea THEN DO:
                RUN crea_tarea.p( evento.nro_evento,
                    evento.nro_cliente,"J" ,
                   "Evento:" + string(evento.nro_evento) ,
                   "",
                   USERID("SIC"),TODAY,"*",OUTPUT nnro).
            END.
            ELSE DO:              
               MESSAGE "La tarea de Entrega de Libro se generara cuando este el analisis de agua correspondiente"
                VIEW-AS ALERT-BOX INFORMATION.
            END.
    END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE desasigevsigue V-table-Win 
PROCEDURE desasigevsigue :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEFINE INPUT PARAM nnro LIKE evento.nro_evento NO-UNDO.
DEFINE BUFFER bevento FOR evento.
    FOR EACH bevento WHERE bevento.evsigue = nnro AND
            NOT bevento.anulado :
            IF bevento.bloqueado AND bevento.frealizado<>? THEN DO:
                bevento.fasignado = ?.
                bevento.recurso = "".
                bevento.evsigue = 0.
                bevento.observacion = agregaAdvTexto("No es mas lleva por cambio de evento " + STRING(nnro),bevento.observacion).
                /*RUN recupcertif(bevento.nro_evento).*/
            END.
            FOR EACH recurso_agenda OF bevento:
                DELETE recurso_agenda.
            END.
     END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE disable_UI V-table-Win  _DEFAULT-DISABLE
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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE getter V-table-Win 
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
  p-indice = IF AVAILABLE evento THEN string(evento.nro_evento) ELSE ?.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE local-add-record V-table-Win 
PROCEDURE local-add-record :
/*------------------------------------------------------------------------------
  Purpose:     Override standard ADM method
  Notes:       
------------------------------------------------------------------------------*/

  /* Code placed here will execute PRIOR to standard behavior. */
  
  RUN set-attribute-list IN adm-broker-hdl ( "modo-cambio=ADD" ).


    /* Dispatch standard ADM method.                             */
  RUN dispatch IN THIS-PROCEDURE ( INPUT 'add-record':U ) .

  /* Code placed here will execute AFTER standard behavior.    */
      c_nro_tipo_evento:SENSITIVE IN FRAME {&FRAME-NAME} = true.
      c_nro_tipo_evento = 0.
      DISPLAY c_nro_tipo_evento WITH FRAME {&FRAME-NAME}.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE local-assign-statement V-table-Win 
PROCEDURE local-assign-statement :
DEF BUFFER baevento FOR evento.
DEF BUFFER aviso FOR evento.
DEF VAR hproc AS HANDLE NO-UNDO.
DEF VAR hcproc AS CHARACTER NO-UNDO.
DEF VAR pnro_cliente LIKE cliente.nro_cliente NO-UNDO.
DEF VAR eve-rela AS CHAR NO-UNDO.
DEF VAR eve-relaref AS CHAR NO-UNDO.
DEF VAR k AS INT NO-UNDO.
DEF VAR fasigevsigue AS DATE NO-UNDO.
DEF VAR rok AS LOGICAL NO-UNDO.
DEF VAR nnro LIKE tarea.nro_tarea NO-UNDO.
DEF VAR pudo_anular AS LOGICAL NO-UNDO.
DEF VAR pfasignado LIKE evento.fasignado NO-UNDO.
DEF VAR precursos LIKE evento.recursos NO-UNDO.
DEF VAR panulado LIKE evento.anulado NO-UNDO.
DEF VAR quemodo AS CHAR NO-UNDO.
DEFINE VAR p-texto AS CHAR NO-UNDO.
refrescar=TRUE.


ASSIGN FRAME {&FRAME-NAME} c_nro_tipo_evento.
evento.turno=UPPER(evento.turno).
evento.hora_desde:SCREEN-VALUE = ajuh(evento.hora_desde:SCREEN-VALUE).
evento.hora_hasta:SCREEN-VALUE = ajuh(evento.hora_hasta:SCREEN-VALUE).
pfasignado = evento.fasignado.
panulado = evento.anulado.
precursos = evento.recursos.
RUN get-attribute IN adm-broker-hdl ( INPUT  "modo-cambio" ).
quemodo=RETURN-VALUE.
/*validacion de datos*/

IF evento.origen BEGINS "REMIT" THEN DO:
        FIND rem_header WHERE rem_header.cdg_comprobante = evento.origen AND
        rem_header.nro_remito = evento.nro_evento NO-LOCK NO-ERROR.
        IF AVAILABLE rem_header THEN DO:
                IF rem_header.anulado AND NOT evento.anulado:INPUT-VALUE IN FRAME {&FRAME-NAME} THEN DO:
                        MESSAGE "No puede desanular el evento" SKIP
                                "viene de un remito ya anulado" SKIP
                                "debe generar otro comprobante" VIEW-AS ALERT-BOX ERROR.
                        RETURN ERROR.
                END.
        END.
END.

IF evento.duracion:INPUT-VALUE <= 0 THEN DO:
        MESSAGE "El evento NO puede tener una duracion de 0" skip
                "asigne una duracion pronosticada en minutos" VIEW-AS ALERT-BOX ERROR.
        RETURN ERROR.
END.

IF evento.fasignado:INPUT-VALUE <> ? THEN DO:
    IF evento.origen = "CONTRATO" THEN DO:
        FIND contrato_hd WHERE contrato_hd.nro_contrato = Evento.nro_identificacion NO-LOCK NO-ERROR.
        IF contrato_hd.suspendido THEN DO:
            MESSAGE "El contrato esta suspendido no puede asignarse un evento"
                VIEW-AS ALERT-BOX INFORMATION.
            RETURN ERROR.
        END.
    END.

    IF NOT evento.anulado:INPUT-VALUE THEN DO:
            IF NOT recurso-invalido( evento.recursos:INPUT-VALUE IN FRAME {&FRAME-NAME} ) THEN DO:
                MESSAGE "Recurso no es valido" VIEW-AS ALERT-BOX error.
                RETURN ERROR.
            END.
            IF evento.fasignado:INPUT-VALUE <> evento.fasignado THEN DO:
                IF evento.fasignado:INPUT-VALUE < TODAY THEN DO:
                    MESSAGE "No puede asignar una fecha menor a la de hoy" SKIP
                            "Deberia cargarlo como realizado ,si corresponde" VIEW-AS ALERT-BOX ERROR.
                    RETURN ERROR.
                END.
                
                IF quemodo = "MODIFY" THEN DO:
                     RUN validar_cambio(OUTPUT eve-relaref , OUTPUT eve-rela ,OUTPUT fasigevsigue ).
                     IF RETURN-VALUE = "NO" THEN RETURN ERROR.
                END.
                IF ( evento.fasignado:INPUT-VALUE > evento.fmax:INPUT-VALUE OR
                  evento.fasignado:INPUT-VALUE < evento.fmin:INPUT-VALUE ) THEN  DO:
                    MESSAGE "Esta fuera del periodo original" SKIP
                            "Se proseguira con la grabacion pero NO es algo anormal" SKIP
                            "verifique o corrija el fmin y fmax" VIEW-AS ALERT-BOX information.
                END.
            END.
    END.
END.
ELSE DO:
    /* IF stavisado(evento.nro_evento) = "X" THEN DO:
        MESSAGE "Existe aviso vigente" VIEW-AS ALERT-BOX .
        RETURN ERROR. */

         RUN validar_cambio(OUTPUT eve-relaref , OUTPUT eve-rela ,OUTPUT fasigevsigue ).
         IF RETURN-VALUE = "NO" THEN RETURN ERROR.
END.

RUN dispatch IN THIS-PROCEDURE ( INPUT 'assign-statement':U ) .

evento.observaciones = observaciones:PRIVATE-DATA.
ASSIGN evento.nro_tipo_evento = c_nro_tipo_evento. 

IF pfasignado <> ? THEN DO: 
    IF pfasignado <= suma_dia_habil( today  , 1, "23456" ) AND pfasignado <> evento.fasignado THEN do:
        rok=FALSE.
        p-texto = "".
        repeat WHILE NOT rok OR p-texto = "":
            RUN c-edttexto.w ( INPUT-OUTPUT p-texto, "Motivo de desasignacion" ,0,OUTPUT rok).
        END.
        evento.observacion = agregaAdvTexto("Cambio asignacion evento " + STRING(pfasignado) + "[" + precursos + "]" + "Motivo:" + p-texto,evento.observacion).
    END.
    IF NOT panulado 
    THEN DO:
        IF quemodo = "MODIFY" THEN DO:
            IF evento.fasignado <> pfasignado  /*se cambio la asignacion*/ 
                THEN DO:
                CASE stavisado( evento.nro_evento ):
                     WHEN "R" or when "B" or WHEN "X" OR WHEN "T" OR WHEN "S" OR WHEN "N"THEN DO: 
                        /*se incluye N falta el aviso y S para los sin aviso*/
                        /*IF evento.fasignado <> ? THEN DO:
                            CREATE bevento.
                            BUFFER-COPY evento TO bevento
                            ASSIGN 
                                bevento.anulado = TRUE
                                evento.nro_evento = NEXT-VALUE(proximo_evento)
                                evento.nro_evento:screen-value = string(evento.nro_evento)
                                evento.fcreado:SCREEN-VALUE = string(TODAY,"99/99/9999")
                                refrescar = TRUE
                                evento.nro_certif = 0
                                evento.url1 = ""
                                evento.url2 = ""
                                evento.tipo_certif = ""
                                evento.letraprefijo = ""
                                evento.mobs = evento.mobs + (IF evento.mobs <> "" THEN "##" ELSE "") + "EV-ORIGINAL:" + STRING(bevento.nro_evento)
                                bevento.mobs = bevento.mobs + (IF bevento.mobs <> "" THEN "##" ELSE "") + "EV-REEMPLAZADO:" + STRING(evento.nro_evento) + " el " + entry(1,STRING(NOW)) + " por " + USERID("sic").
                        END.
                        ELSE*/
                        evento.mobs = evento.mobs + (IF evento.mobs <> "" THEN "##" ELSE "") + "SIG PREV:" + string(evento.fasignado) + " OPER:" + evento.recursos .
                        FIND bevento OF evento.
                        RUN recrea_agenda(bevento.nro_evento).
                        /*RUN recupcertif(bevento.nro_evento).*/
                        FIND FIRST aviso WHERE aviso.refevento = bevento.nro_evento AND NOT aviso.anulado NO-ERROR.
                        IF AVAILABLE aviso THEN DO:
                                RUN recrea_agenda(aviso.nro_evento).
                                aviso.anulado = TRUE.
                                aviso.observacion = agregaAdvTexto("Anulado al reemplazar:" + STRING(evento.nro_evento) , aviso.observacion).
                                MESSAGE "Se ha anulado el aviso entregado" aviso.nro_evento VIEW-AS ALERT-BOX INFORMATION.
                        END.
                        FIND FIRST aviso WHERE aviso.evsigue = bevento.nro_evento AND NOT aviso.anulado NO-ERROR.
                        IF AVAILABLE aviso THEN DO:
                                FIND bevento WHERE bevento.nro_evento = evento.nro_evento NO-LOCK NO-ERROR.
                                ASSIGN aviso.observacion = agregaAdvTexto("Desasignado al reemplazar:" + STRING(evento.nro_evento) , aviso.observacion)
                                    aviso.evsigue = evento.nro_evento   
                                    aviso.fasignado = bevento.fasignado
                                       aviso.recurso = ENTRY(1,bevento.recurso).
                                RUN recrea_agenda(aviso.nro_evento).
                        END.
                        FOR EACH tarea OF bevento WHERE tarea.estado = "A":
                                tarea.estado = "D".
                                tarea.descripcion = agregaAdvTexto("Descartada al anular evento aviso:" + string(aviso.nro_evento) ,tarea.descripcion).
                        END.
                        
                    END.
                    WHEN "A" OR WHEN "P" THEN DO:
                        FIND FIRST aviso WHERE aviso.refevento = evento.nro_evento AND NOT aviso.anulado AND aviso.frealizado = ? NO-ERROR.
                        IF AVAILABLE aviso THEN DO:
                            RUN recrea_agenda(aviso.nro_evento).
                            /*si es un lleva lo borro */
                            IF evento.origen = "CONTRATO" THEN DO:
                                find restriccion no-lock WHERE restriccion.cdg_restriccion BEGINS "AVISO" AND
                                                restriccion.nro_tipo_evento = evento.nro_tipo_evento NO-ERROR.
                                IF NOT AVAILABLE restriccion THEN RETURN.
                                FIND FIRST contrato_restriccion WHERE contrato_restriccion.nro_contrato = evento.nro_identificacion AND
                                   contrato_restriccion.sub_evento = evento.sub_evento AND 
                                   contrato_restriccion.nro_restriccion = restriccion.nro_restriccion NO-LOCK NO-ERROR.
                                IF ENTRY(3 , contrato_restriccion.valor ,"|" ) <> "E" THEN DO: /*es lleva*/
                                   aviso.observacion = agregaAdvTexto("Evento desasignado el cambiar asignacion evento " + string(evento.nro_evento) + " originalmente aviso asignado el " + string(aviso.fasignado,"99/99/9999") + " [" + aviso.recurso + "]", aviso.observacion ).
                                   aviso.anulado = TRUE.
                                END.
                                ELSE DO:                                
                                   RUN calcula_fecha_aviso(aviso.nro_evento).
                                   aviso.observacion = agregaAdvTexto("Evento desasignado el cambiar asignacion evento " + string(evento.nro_evento) + " originalmente aviso asignado el " + string(aviso.fasignado,"99/99/9999") + " [" + aviso.recurso + "]", aviso.observacion ).
                                   aviso.fasignado = ?.
                                   aviso.impreso = FALSE.
                                END.
                            END.
                        END.
                    END.
               END CASE.
               RUN cambiatareaconf(ROWID(evento)).
            END.
        END.
        /*evento se anulo ahora?*/
        IF evento.anulado THEN DO:
             IF evento.origen BEGINS "REMIT" THEN DO:
                            FIND rem_header WHERE rem_header.cdg_comprobante = evento.origen AND
                            rem_header.nro_remito = evento.nro_evento NO-LOCK NO-ERROR.
                            IF AVAILABLE rem_header THEN DO:
                                RUN anular_compdespacho.p (INPUT ROWID(Rem_header), OUTPUT pudo_anular).                                
                                IF NOT pudo_anular THEN do:
                                    MESSAGE "No se puede anular el evento " SKIP
                                            "tiene el remito asociado:" string(rem_header.prf_comprob,"9") + string(rem_header.nro_comprob,"9") + " que no puede anularse" SKIP
                                            "Debe investigar la razon, puede estar facturado" VIEW-AS ALERT-BOX ERROR.
                                    RETURN ERROR.
                                END.
                            END.
                    END.
             RUN borraavisos(evento.nro_evento).
             RUN desasigevsigue(evento.nro_evento).
             /*RUN recupcertif(evento.nro_evento).*/
        END.
    END.
END. /*fin evento anteriormente asignado*/
ELSE
    evento.mobs = evento.mobs + (IF evento.mobs <> "" THEN "##" ELSE "") + "SIG PREV:" + string(evento.fasignado) + " OPER:" + evento.recursos .


CASE quemodo:
    WHEN "ADD" THEN DO:
        RUN get-link-handle IN adm-broker-hdl
        ( INPUT THIS-PROCEDURE,
          INPUT "record-source",
          OUTPUT hcproc ).
          hproc = WIDGET-HANDLE( hcproc ).
          pnro_cliente = IF VALID-HANDLE(hProc) THEN dynamic-function('que_cliente' IN hproc ) ELSE ?.    
    
        ASSIGN evento.nro_evento = NEXT-VALUE(proximo_evento)
               evento.nro_evento_padre = 0
               evento.origen = "MANUAL"
               evento.fcreado = TODAY
               evento.nro_cliente = pnro_cliente.
        IF evento.nro_tipo_evento = nro_tipo_evento_cobranza THEN DO:
               evento.turno = IF int(aint(evento.hora_desde)) < 1230 THEN "M*" ELSE "T*".
               IF INT(aint(evento.hora_hasta)) > 1230 THEN 
                       evento.turno = IF evento.turno BEGINS "M" then "**" ELSE evento.turno.
        END.
    END.
END.
IF evento.fasignado = ? THEN DO:
    IF evento.fmin = ? THEN ASSIGN evento.fmin = TODAY
    evento.periodo = YEAR(evento.fmin) * 100 + MONTH(evento.fmin).
    IF evento.fmax = ? THEN ASSIGN evento.fmax = evento.fmin + 10.
    /*RUN recupcertif(evento.nro_evento).*/
END.
ELSE DO:
    IF evento.fmin = ? THEN ASSIGN evento.fmin = evento.fasignado
    evento.periodo = YEAR(evento.fasignado) * 100 + MONTH(evento.fasignado).
    IF evento.fmax = ? THEN ASSIGN evento.fmax = evento.fasignado.
END.
    
IF quemodo = "COPY" THEN DO:
      RUN get-attribute IN adm-broker-hdl ( INPUT  "ant_rid" ).
      ant_rid = TO-ROWID(RETURN-VALUE).
      FIND FIRST bevento WHERE ROWID(bevento ) = ant_rid.
      ASSIGN evento.nro_evento = NEXT-VALUE(proximo_evento)
             evento.nro_cliente = bevento.nro_cliente
             evento.origen = bevento.origen
             evento.nro_evento_padre = bevento.nro_evento_padre
             evento.nro_identificacion = bevento.nro_identificacion
             evento.sub_evento = bevento.sub_evento
             evento.mobs = evento.mobs + (IF evento.mobs <> "" THEN "##" ELSE "") + "ES COPIA:" + STRING(bevento.nro_evento)+ " por " + USERID("sic").
END.

IF evento.frealizado <> ? THEN DO:
    IF evento.fasignado = ? THEN
/*        evento.fasignado = evento.frealizado.
    /*solo si es de tanque*/
    IF evento.nro_tipo_evento = nro_tipo_evento_tanque THEN DO:
      MESSAGE "Los eventos de LT es conveniente dar los por realizardos" SKIP
              "por la carga de Ordenes de Trabajo" SKIP
              "Se realizara la accion de todas maneras" VIEW-AS ALERT-BOX INFORMATION.
      if evento.origen = "CONTRATO" AND evento.sub_evento = 1 THEN DO:
            evento.observacion = agregaAdvTexto("Se fuerza que se TIENELIBRO desde EDITOR",evento.observacion).
            RUN crea_J-LT.
            RUN crea_H-LT.
      END.
    END.
    ELSE RUN crea_H-RL.
*/    
END.
IF evento.nro_certif = 0 THEN
    ASSIGN evento.letraprefijo = ""
    evento.url1 = ""
    evento.url2 = "".

RUN recrea_agenda(evento.nro_evento).

IF evento.nro_tipo_evento = nro_tipo_evento_cobranza THEN RUN asignarEC-cli.p (evento.nro_cliente).


DO i = 1 TO num-entries(eve-rela):
find bevento WHERE bevento.nro_evento = int(entry(i,eve-rela)).
        bevento.fasignado = evento.fasignado.
        bevento.recurso =IF evento.nro_tipo_evento = nro_tipo_evento_aviso THEN ENTRY(1, evento.recurso) ELSE evento.recurso.
        RUN recrea_agenda (bevento.nro_evento).

        /*ver si tenia a su vez un aviso*/
        FOR EACH baevento WHERE bevento.refevento = baevento.nro_evento:
            RUN recrea_agenda (baevento.nro_evento).
        END.
        refrescar = TRUE.
END.
IF evento.evsigue <> 0 THEN DO:
        FIND FIRST bevento WHERE bevento.nro_evento = evento.evsigue and
             NOT bevento.anulado and
             ( avisoentregado(bevento.nro_evento)  OR bevento.bloqueado OR bevento.frealizado<>? ) NO-ERROR.
        IF AVAILABLE bevento THEN DO:
          bevento.fasignado = evento.fasignado.
        /*ver si tenia a su vez un aviso*/
         RUN recrea_agenda (bevento.nro_evento).
         FOR EACH baevento WHERE bevento.refevento = baevento.nro_evento:
             RUN recrea_agenda (baevento.nro_evento).
         END.
          refrescar = TRUE.
        END.
END.
ASSIGN evento.url1 = evento.url1:SCREEN-VALUE
    evento.nro_certificado = int(evento.nro_certificado:SCREEN-VALUE)
    evento.letraPrefijo = evento.letraPrefijo:SCREEN-VALUE.
IF evento.url1 <> "" AND evento.url2="" THEN DO:
    FIND cliente OF evento NO-LOCK.
    evento.url2 = cliente.direccion.
END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE local-copy-record V-table-Win 
PROCEDURE local-copy-record :
RUN set-attribute-list IN adm-broker-hdl ( "ant_rid=" + string( rowid(evento) ) ).
  RUN set-attribute-list IN adm-broker-hdl ( "modo-cambio=COPY" ).
  evento.anulado:CHECKED IN FRAME {&FRAME-NAME}= FALSE.
  evento.fasignado:SCREEN-VALUE = "".
  evento.frealizado:SCREEN-VALUE = "".
  evento.fasignado:SENSITIVE IN FRAME {&FRAME-NAME}= true.

  RUN dispatch IN THIS-PROCEDURE ( INPUT 'copy-record':U ) .


END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE local-destroy V-table-Win 
PROCEDURE local-destroy :
cerrar(h_vecinos).
cerrar(h_agenda_recurso).
  RUN dispatch IN THIS-PROCEDURE ( INPUT 'destroy':U ) .
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE local-disable-fields V-table-Win 
PROCEDURE local-disable-fields :
/*------------------------------------------------------------------------------
  Purpose:     Override standard ADM method
  Notes:       
------------------------------------------------------------------------------*/

  /* Code placed here will execute PRIOR to standard behavior. */

  /* Dispatch standard ADM method.                             */
  RUN dispatch IN THIS-PROCEDURE ( INPUT 'disable-fields':U ) .

  /* Code placed here will execute AFTER standard behavior.    */
    

    v-perant:SENSITIVE IN FRAME {&FRAME-NAME}= FALSE.
    Brecursos:SENSITIVE  = false.
    c_nro_tipo_evento:SENSITIVE = false. 
    bobserv-2:SENSITIVE = TRUE.
    bmobs:SENSITIVE = FALSE.
    bobserv:SENSITIVE = TRUE.
    bleyenda:SENSITIVE = TRUE.
    bleyenda-2:SENSITIVE = TRUE.
    evento.frealizado:SENSITIVE = FALSE.
    RUN set-attribute-list IN adm-broker-hdl ( "modo-cambio=MODIFY" ).
    IF VALID-HANDLE(h_vecinos) THEN DO:
       cerrar (h_vecinos).
    END.


END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE local-display-fields V-table-Win 
PROCEDURE local-display-fields :
/*------------------------------------------------------------------------------
  Purpose:     Override standard ADM method
  Notes:       
------------------------------------------------------------------------------*/
DEFINE VAR hcproc AS CHARACTER NO-UNDO.
DEFINE VAR hproc AS HANDLE NO-UNDO.
DEFINE BUFFER aviso FOR evento.
DEFINE VAR vm AS CHAR INITIAL "Men,1,Bim,2,Tri,3,Cua,4,Sem,6,9Ms,9,Anu,12" NO-undo.

/* Code placed here will execute PRIOR to standard behavior. */
IF refrescar THEN DO:
    refrescar = FALSE.
    RUN get-link-handle IN adm-broker-hdl
    ( INPUT THIS-PROCEDURE,
      INPUT "record-source",
      OUTPUT hcproc ).
      hproc = WIDGET-HANDLE( hcproc ).
      IF VALID-HANDLE(hProc) THEN DO:
          RUN dispatch IN hproc ( INPUT 'open-query':U ).
      END.

END.

  /* Dispatch standard ADM method.                             */
  RUN dispatch IN THIS-PROCEDURE ( INPUT 'display-fields':U ) .
  c_nro_tipo_evento = ?.
  IF AVAILABLE evento THEN DO:
      ASSIGN  
       durtotal = Evento.Duracion:INPUT-VALUE IN FRAME {&FRAME-NAME} + evento.viaje:INPUT-VALUE IN FRAME {&FRAME-NAME}.  
       c_nro_tipo_evento  = evento.nro_tipo_evento.
       bAviso:SENSITIVE IN FRAME {&FRAME-NAME} = AVAILABLE evento . 
       bOT:SENSITIVE = AVAILABLE evento . 
       IF evento.nro_tipo_evento = nro_tipo_evento_aviso THEN DO:
            label-av:SCREEN-VALUE = "Entrega".
            label-ta:HIDDEN = TRUE.
            v-sttarea:HIDDEN = TRUE.
            v-stavisado:TOOLTIP = "0-No entregado" + CHR(10) + 
                                  "1-En mano" + CHR(10) +
                                  "2-Buzon".
      END.
       
       ELSE DO:
            label-av:SCREEN-VALUE = "Avisado".
            label-ta:HIDDEN = false.
            v-sttarea:HIDDEN = FALSE.
            v-stavisado:TOOLTIP = "".
       END.
       FIND cliente OF evento NO-LOCK.
       FIND administrador WHERE cliente.nro_admin = administrador.nro_cliente NO-LOCK.
       nom_admin = administrador.nom_cliente.
       b_infoadic:HIDDEN = NOT can-do("CONTRATO,ENVIO,COBRANZA",evento.origen:INPUT-VALUE).
       DISPLAY  nom_admin durtotal perant(evento.nro_evento) @ v-perant WITH FRAME {&FRAME-NAME}.
       FIND evento_protocolo OF evento NO-ERROR.
       banal:HIDDEN = NOT available(evento_protocolo). 
       banal:SENSITIVE = available(evento_protocolo).
       bcertif:HIDDEN = NOT (evento.nro_tipo_evento = 1 OR evento.nro_tipo_evento = 3) .
       bcertif:SENSITIVE = evento.nro_tipo_evento = 1 OR evento.nro_tipo_evento = 3 . 
       v-stavisado:SCREEN-VALUE = IF evento.nro_tipo_evento = nro_tipo_evento_aviso THEN string(evento.entrega) ELSE stavisado(evento.nro_evento).
       v-sttarea:SCREEN-VALUE = sttarea(evento.nro_evento).
       bot:HIDDEN = evento.origen = "AVISO".
       baviso:HIDDEN =  NOT evento.origen = "AVISO" AND NOT CAN-FIND(FIRST aviso WHERE aviso.refevento = evento.nro_evento AND NOT aviso.anulado ).
       observaciones:PRIVATE-DATA = evento.observaciones.
       RUN loadAdvTTTexto( observaciones:PRIVATE-DATA , OUTPUT TABLE tttexto ).
       observaciones:SCREEN-VALUE = cortoAdvTexto( TABLE tttexto ). 
       IF evento.origen = "CONTRATO" THEN DO:
                    FIND contrato_hd WHERE contrato_hd.nro_contrato = evento.nro_identificacion NO-LOCK.
                    leyenda_contrato = contrato_hd.leyenda.
                    v-modo = ENTRY(lookup(string(contrato_hd.modo_facturacion),vm) - 1, vm).
       END.
       ELSE do:
           leyenda_contrato = "".
           v-modo = "".
       END.
  END. 

  c_nro_tipo_evento:SCREEN-VALUE = string(c_nro_tipo_evento).
  

  DISPLAY leyenda_contrato v-modo WITH FRAME {&FRAME-NAME}.

  /* Code placed here will execute AFTER standard behavior.    */ 

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE local-enable-fields V-table-Win 
PROCEDURE local-enable-fields :
/*------------------------------------------------------------------------------
  Purpose:     Override standard ADM method
  Notes:       
------------------------------------------------------------------------------*/
DEFINE BUFFER aviso FOR evento.
DEFINE VAR prgm AS CHAR.

  /* Code placed here will execute PRIOR to standard behavior. */

  /* Dispatch standard ADM method.                             */
    RUN dispatch IN THIS-PROCEDURE ( INPUT 'enable-fields':U ) .
    DO WITH FRAME {&FRAME-NAME}:
      Brecursos:SENSITIVE  = TRUE.
      v-perant:SENSITIVE = FALSE.
      IF AVAILABLE evento THEN DO:
        bot:sensitive = evento.origen <> "AVISO".
        baviso:SENSITIVE = CAN-FIND(FIRST aviso WHERE aviso.refevento = evento.nro_evento AND NOT aviso.anulado ).
        bobserv-2:SENSITIVE = TRUE.
        bobserv:SENSITIVE = TRUE.
        bleyenda:SENSITIVE = TRUE.
        bleyenda-2:SENSITIVE = TRUE.
        bmobs:SENSITIVE = TRUE.
      END.
    END.

   {findempresa.i}
prgm = entry(2,PROGRAM-NAME(1)," ").

 
    FIND usuario_programa OF usuario WHERE usuario_programa.MODULO = prgm NO-ERROR.
    IF AVAILABLE usuario_programa AND sic.Usuario_programa.permiso >= "A" THEN DO:
        evento.frealizado:SENSITIVE = TRUE.
    END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE local-initialize V-table-Win 
PROCEDURE local-initialize :
/*------------------------------------------------------------------------------
  Purpose:     Override standard ADM method
  Notes:       
------------------------------------------------------------------------------*/

nro_tipo_evento_cobranza = ?.
FIND tipo_evento WHERE tipo_evento.cdg_tipo_evento = "CO" NO-LOCK NO-ERROR.
IF AVAILABLE tipo_evento THEN nro_tipo_evento_cobranza = tipo_evento.nro_tipo_evento.
nro_tipo_evento_tanque = ?.
FIND tipo_evento WHERE tipo_evento.cdg_tipo_evento = "LT" NO-LOCK NO-ERROR.
IF AVAILABLE tipo_evento THEN nro_tipo_evento_tanque = tipo_evento.nro_tipo_evento.
nro_tipo_evento_aviso = ?.
FIND tipo_evento WHERE tipo_evento.cdg_tipo_evento = "AV" NO-LOCK NO-ERROR.
IF AVAILABLE tipo_evento THEN nro_tipo_evento_aviso = tipo_evento.nro_tipo_evento.
  /* Code placed here will execute PRIOR to standard behavior. */
RUN set-attribute-list IN adm-broker-hdl ( "modo-cambio=MODIFY" ).
  /* Dispatch standard ADM method.                             */
DEFINE VAR lista AS CHAR NO-UNDO.
  &Scoped-define CONDICION tipo_evento.nro_tipo_evento > 0 
  DO WITH FRAME {&FRAME-NAME}:
     {levantacombo.i &TABLA=Tipo_evento &NOMBRE=cdg_tipo_evento &CODIGO=nro_tipo_evento &OBJETO=c_nro_tipo_evento}
  END. 

  RUN dispatch IN THIS-PROCEDURE ( INPUT 'initialize':U ) .


END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE local-row-available V-table-Win 
PROCEDURE local-row-available :
/*------------------------------------------------------------------------------
  Purpose:     Override standard ADM method
  Notes:       
------------------------------------------------------------------------------*/

  /* Code placed here will execute PRIOR to standard behavior. */

  /* Dispatch standard ADM method.                             */
  RUN dispatch IN THIS-PROCEDURE ( INPUT 'row-available':U ) .

  /* Code placed here will execute AFTER standard behavior.    */
  MENU-ITEM m_impreso:CHECKED IN MENU  POPUP-MENU-Bcertif = TRUE.
  MENU-ITEM m_email:CHECKED IN MENU  POPUP-MENU-Bcertif = FALSE.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE local-update-record V-table-Win 
PROCEDURE local-update-record :
/*------------------------------------------------------------------------------
  Purpose:     Override standard ADM method
  Notes:       
------------------------------------------------------------------------------*/
IF evento.origen BEGINS "REMIT" THEN DO:
    FIND rem_header WHERE rem_header.cdg_comprobante = evento.origen AND
    rem_header.nro_remito = evento.nro_evento NO-LOCK NO-ERROR.
    IF AVAILABLE rem_header THEN DO:
            IF rem_header.anulado AND NOT evento.anulado:INPUT-VALUE IN FRAME {&FRAME-NAME} THEN DO:
                    MESSAGE "No puede desanular el evento" SKIP
                            "viene de un remito ya anulado" SKIP
                            "debe generar otro comprobante" VIEW-AS ALERT-BOX ERROR.
                    RETURN ERROR.
            END.
    END.
END.
IF evento.anulado THEN DO:
    MESSAGE "El evento esta anulado" SKIP
        "tenga cuidado en la operacion" VIEW-AS ALERT-BOX ERROR.
END.
  /* Code placed here will execute PRIOR to standard behavior. */

  /* Dispatch standard ADM method.                             */
  RUN dispatch IN THIS-PROCEDURE ( INPUT 'update-record':U ) .

  /* Code placed here will execute AFTER standard behavior.    */

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE recrea_agenda V-table-Win 
PROCEDURE recrea_agenda :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEFINE INPUT PARAMETER pevento LIKE evento.nro_evento.

DEFINE BUFFER recevento FOR evento.
DEFINE BUFFER rec1evento FOR evento.
    DEFINE VAR i AS INT NO-UNDO.

    FIND recevento WHERE recevento.nro_evento = pevento NO-ERROR.
    IF NOT AVAILABLE recevento  THEN RETURN.
    FOR EACH recurso_agenda OF recevento:
        DELETE recurso_agenda.
    END.
    IF NOT recevento.anulado THEN DO:
        DO i = 1 TO NUM-ENTRIES(recevento.recursos):
                  CREATE recurso_agenda.
                  ASSIGN recurso_agenda.cdg_recurso = ENTRY(i,recevento.recurso)
                         recurso_agenda.nro_evento = recevento.nro_evento
                         recurso_agenda.fecha = recevento.fasignado.
        END.
    END.
          /*crear el aviso si corresponde a ese evento.*/

/*esto no es lo perfecto pero por compromiso solo se regereran avisos cuando es derivado de un contrato caso contrario hay que hacerlo a mano*/
    IF recevento.origen = "CONTRATO" THEN
        RUN crea_aviso_evento.p ( INPUT ROWID(recevento) ).
    IF recevento.origen = "MANUAL" THEN DO:
          FIND rec1evento WHERE rec1evento.refevento = recevento.nro_evento NO-LOCK NO-ERROR.
          IF AVAILABLE rec1evento THEN 
            MESSAGE "Verifique el evento aviso y corrijalo manualmente" VIEW-AS ALERT-BOX INFORMATION.
    END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE recupcertif V-table-Win 
PROCEDURE recupcertif :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEFINE INPUT PARAM nroe AS INT.
DEFINE BUFFER recuevento FOR evento.
FIND recuevento WHERE recuevento.nro_evento = nroe.
IF recuevento.nro_tipo_evento = 1 AND recuevento.nro_certif <> 0 THEN DO:
        IF recuevento.origen = "CONTRATO" THEN DO:
                FIND contrato_hd NO-LOCK WHERE contrato_hd.nro_contrato = recuevento.nro_identificacion.
                IF contrato_hd.numero_eventos = recuevento.sub_evento THEN DO:
                    MESSAGE "Recupere la oblea" recuevento.LetraPrefijo recuevento.nro_certificado "del evento" nroe VIEW-AS ALERT-BOX INFORMATION.
                    CREATE certificados.
                    ASSIGN certificados.tipo = recuevento.tipo_certif
                           certificados.nro_Hasta = recuevento.nro_certificado
                           certificados.nro_desde = recuevento.nro_certificado
                           certificados.letraprefijo = recuevento.letraprefijo
                           certificados.nro_tipo_evento = recuevento.nro_tipo_evento
                           certificados.nro_certificado = 0
                           certificados.observaciones = string(recuevento.nro_evento)
                           certificados.falta = TODAY
                           recuevento.observaciones = agregaAdvTexto("Recupera oblea:" + certificados.letraprefijo + string(certificados.nro_desde), recuevento.observaciones).
                           FOR EACH recuevento WHERE recuevento.nro_certificado =  certificados.nro_desde AND
                                                  recuevento.letraprefijo = certificados.letraprefijo :
                               ASSIGN recuevento.nro_certificado = 0
                                      recuevento.letraprefijo = ""
                                      recuevento.tipo_certif = "".
                           END.

                END.
        END.
    END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE send-records V-table-Win  _ADM-SEND-RECORDS
PROCEDURE send-records :
/*------------------------------------------------------------------------------
  Purpose:     Send record ROWID's for all tables used by
               this file.
  Parameters:  see template/snd-head.i
------------------------------------------------------------------------------*/

  /* Define variables needed by this internal procedure.               */
  {src/adm/template/snd-head.i}

  /* For each requested table, put it's ROWID in the output list.      */
  {src/adm/template/snd-list.i "Evento"}

  /* Deal with any unexpected table requests before closing.           */
  {src/adm/template/snd-end.i}

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE state-changed V-table-Win 
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
      {src/adm/template/vstates.i}
  END CASE.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE validar_cambio V-table-Win 
PROCEDURE validar_cambio :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/*Validar o avisos antes del cambio del evento*/
DEFINE OUTPUT PARAM eve-relaref AS CHAR.
DEFINE OUTPUT PARAM eve-rela AS CHAR.
DEFINE OUTPUT PARAM fasigevsigue AS DATE.
DEFINE VAR opt AS LOGICAL NO-UNDO.
DO WITH FRAME {&FRAME-NAME}:

    eve-relaref = "".
    IF evento.nro_tipo_evento <> c_nro_tipo_evento THEN refrescar = TRUE.
    IF avisoentregado(evento.nro_evento) THEN DO: 
         FIND FIRST bevento WHERE bevento.RefEvento = evento.nro_evento AND NOT bevento.anulado AND bevento.frealizado = ? NO-LOCK NO-ERROR.
         IF AVAILABLE bevento THEN
             eve-relaref = eve-relaref + "," + STRING(bevento.nro_evento,">>>>>>>>9").
    END.
    eve-relaref = SUBSTRING(eve-relaref,2).
    IF num-entries(eve-relaref) > 0 AND evento.fasignado:MODIFIED THEN DO:
      MESSAGE "El evento posee Avisos ya referenciados " SKIP
              eve-relaref SKIP
              "Debe anularlo ,sino no puede ser modificado" skip
              "hasta que no resuelva las mismas" skip
              "Quiere hacerlo en este momento" VIEW-AS ALERT-BOX QUESTION BUTTONS OK-CANCEL UPDATE opt.
      IF opt THEN DO: 
          RUN anula-cascada( eve-relaref ).
      END.
      ELSE
          RETURN "NO".
    END.

    /*eventos que siguen*/
    eve-rela = "".
    FOR EACH bevento WHERE bevento.evsigue = evento.nro_evento AND
        NOT bevento.anulado :
        IF bevento.nro_tipo_evento <> 10 THEN
           IF NOT bevento.bloqueado AND bevento.frealizado=? THEN DO:
           bevento.evsigue = 0.
           /*eve-rela = eve-rela + "," + STRING(bevento.nro_evento,">>>>>>>>9").*/
        END.
    END.
    
    IF evento.evsigue <> 0 THEN DO:
        IF evento.nro_tipo_evento <> 10 THEN
            FIND FIRST bevento WHERE bevento.nro_evento = evento.evsigue and
                NOT bevento.anulado and
                ( avisoentregado(bevento.nro_evento) OR  bevento.bloqueado OR bevento.frealizado = ? ) NO-LOCK NO-ERROR.
                    IF AVAILABLE bevento THEN
                eve-rela = eve-rela + "," +  STRING(evento.evsigue,">>>>>>>>9").
    END.
    eve-rela = IF SUBSTRING(eve-rela,1,1) = "," THEN SUBSTRING(eve-rela,2) ELSE eve-rela. 
    IF num-entries(eve-rela) > 0 THEN DO:
      MESSAGE "El evento posee los siguientes eventos relacionados" SKIP
              eve-rela SKIP
              "con acciones en curso o acciones relacionadas ya ejecutadas" skip
              "que deben realizarse nuevamente y no puede ser modificado" skip
              "hasta que no resuelva las mismas" VIEW-AS ALERT-BOX ERROR.
      RETURN "NO".
    END.
    
    fasigevsigue=?.
    eve-rela = "".
    FOR EACH bevento WHERE bevento.evsigue = evento.nro_evento AND
        bevento.fasignado = evento.fasignado AND
        bevento.frealizado = ? AND
        NOT bevento.anulado NO-LOCK:
        eve-rela = eve-rela + "," + STRING(bevento.nro_evento,">>>>>>>>9").
    END.
   /* IF evento.evsigue <> 0 THEN DO:
        FIND FIRST bevento WHERE bevento.nro_evento = evento.evsigue and
            NOT bevento.anulado and
            ( avisoentregado(bevento.nro_evento) OR bevento.bloqueado OR bevento.frealizado = ?) NO-LOCK NO-ERROR.
            IF AVAILABLE bevento THEN
                eve-rela = eve-rela + "," + STRING(evento.evsigue,">>>>>>>>9").
    END.*/
    eve-rela = SUBSTRING(eve-rela,2). 
    IF num-entries(eve-rela) > 0  THEN DO:
      MESSAGE "Esta modificacion arrastra cambios en el/los evento" SKIP
              eve-rela SKIP
              "Se asignaran en la misma fecha, modificando ambos eventos"
              VIEW-AS ALERT-BOX QUESTION BUTTON YES-NO SET opt.
      IF NOT opt  THEN RETURN "NO".
      fasigevsigue = evento.fasignado.
    END.
END.
RETURN "SI".
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

/* ************************  Function Implementations ***************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION cerrar V-table-Win 
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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION fac_bloqueo V-table-Win 
FUNCTION fac_bloqueo RETURNS LOGICAL ( nro AS INT , cant AS INT ) :
    DEFINE BUFFER fac FOR fac_header.
    DEFINE VAR ii AS INT64 NO-UNDO.
    DEFINE VAR dfecha AS DATE.
    DEFINE VAR hfecha AS DATE.
    hfecha = TODAY - 45.
    dfecha = 01/01/2016.

    FOR EACH fac WHERE fac.nro_cliente = nro AND fac.fecha > dfecha AND fac.fecha < hfecha AND NOT fac.anulado BY fac.fecha DESC:
        IF pagado(fac.nro_factura) <> "S" THEN
            ii = ii  + 1.
        IF ii >= cant THEN RETURN TRUE.
    END.
    RETURN FALSE.

END FUNCTION.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION felegido V-table-Win 
FUNCTION felegido RETURNS LOGICAL
  ( felegido  AS INT ) :
/*------------------------------------------------------------------------------
  Purpose:  
    Notes:  
------------------------------------------------------------------------------*/
DEFINE BUFFER rbevento FOR evento.  
FIND rbevento WHERE rbevento.nro_evento = felegido NO-LOCK NO-ERROR.
IF NOT AVAILABLE rbevento THEN RETURN FALSE.
IF evento.fasignado:SENSITIVE IN FRAME {&FRAME-NAME} THEN DO:
  evento.fasignado:SCREEN-VALUE IN FRAME {&FRAME-NAME}= string(rbevento.fasignado).
  evento.recursos:SCREEN-VALUE IN FRAME {&FRAME-NAME}= entry(1,string(rbevento.recursos)).
  RETURN TRUE. 
END.
RETURN FALSE.   /* Function return value. */

END FUNCTION.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION pagado V-table-Win 
FUNCTION pagado RETURNS CHARACTER
  ( nro AS INT ) :
    DEF VAR PAGA AS CHAR NO-UNDO.
    DEFINE BUFFER fac FOR fac_header.
      FIND fac WHERE fac.nro_factura = nro NO-LOCK NO-ERROR.
      IF NOT AVAILABLE fac THEN RETURN ?.
      FIND cta_cte WHERE
      cta_cte.cdg_empresa = fac.cdg_empresa AND
      cta_cte.tip_comprob = fac.tip_comprob AND
      cta_cte.prf_comprob = fac.prf_comprob AND
      cta_cte.nro_comprob = fac.nro_comprob NO-LOCK NO-ERROR.
   
IF AVAILABLE cta_cte THEN DO:
      IF cta_cte.credito = 0 AND cta_cte.debito = 0 THEN paga = "S".
      ELSE DO:
          IF cta_cte.credito = 0 OR cta_cte.debito = 0 
              THEN paga = "N".
              ELSE IF cta_cte.credito = cta_cte.debito 
                  THEN paga = "S".
                  ELSE paga = "P".
      END.
  END.
  ELSE paga = "?".
     
RETURN paga.

END FUNCTION.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION recurso-invalido V-table-Win 
FUNCTION recurso-invalido RETURNS LOGICAL
  ( recu AS CHAR ) :
/*------------------------------------------------------------------------------
  Purpose:  
    Notes:  
------------------------------------------------------------------------------*/
DEFINE VAR k AS INT NO-UNDO.
IF recu = "" THEN DO:
    MESSAGE "Recursos invalidos" VIEW-AS ALERT-BOX ERROR.
    RETURN FALSE.
END.
DO k = 1 TO NUM-ENTRIES(recu):
                FIND recurso WHERE recurso.cdg_recurso = ENTRY(k,recu) NO-LOCK NO-ERROR.
                IF NOT AVAILABLE recurso THEN DO:
                    MESSAGE "El recurso " ENTRY(k,recu) SKIP
                        "No es valido, verifique" VIEW-AS ALERT-BOX ERROR.
                    RETURN FALSE.
                END.
END.
RETURN TRUE.   /* Function return value. */

END FUNCTION.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

