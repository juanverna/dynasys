&ANALYZE-SUSPEND _VERSION-NUMBER UIB_v8r12 GUI ADM1
&ANALYZE-RESUME
/* Connected Databases 
          sic              PROGRESS
*/
&Scoped-define WINDOW-NAME CURRENT-WINDOW
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _DEFINITIONS V-table-Win 
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

  Description: from VIEWER.W - Template for SmartViewer Objects

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
DEF VAR i AS INT NO-UNDO.
DEF VAR sino-msg AS LOGICAL NO-UNDO.
{extrae.i}
{stavisado.i}
{tiempo.i}
{crystal_dyna.p}
{advtexto.i}
{impresoras.i}

DEFINE VAR nro_tipo_evento_aviso LIKE  tipo_evento.nro_tipo_evento NO-UNDO.
DEFINE VAR nro_tipo_evento_tanque LIKE  tipo_evento.nro_tipo_evento NO-UNDO.
DEFINE VAR nro_tipo_evento_retiro_libro LIKE  tipo_evento.nro_tipo_evento NO-UNDO.

DEFINE VAR hcp AS CHAR.
DEFINE VAR hp AS HANDLE.
DEFINE TEMP-TABLE lstorden
    FIELD ind AS INT
    FIELD nro_evento AS int 
    FIELD direccion LIKE cliente.direccion
    FIELD fecha_analisis AS date
    FIELD fa_dia AS INT
    FIELD fa_mes AS character
    FIELD fa_ano AS CHARACTER
    FIELD estado_tanque AS CHAR
    FIELD frealizado LIKE evento.frealizado
    FIELD fvencimiento LIKE evento.frealizado
    FIELD Fecha_toma  LIKE evento_protocolo.Fecha_toma 
    FIELD extrajo  LIKE evento_protocolo.extrajo 
    FIELD nro_protocolo LIKE evento_protocolo.nro_protocolo
    FIELD nro_certificado AS CHAR
    FIELD letraprefijo AS CHAR
    FIELD referencia AS CHAR
    FIELD laboratorio LIKE evento_protocolo.laboratorio
    FIELD recurso LIKE Recurso.nom_recurso
    INDEX ind ind.  
{resultados.i}
DEFINE TEMP-TABLE lstdetalle LIKE resultados
        FIELD ind LIKE lstorden.ind.
DEFINE DATASET dset FOR lstorden,lstdetalle 
    DATA-RELATION FOR lstorden, lstdetalle  NESTED
    RELATION-FIELDS ( ind,ind).

DEFINE BUFFER bevento FOR evento.
DEFINE TEMP-TABLE parametros
    FIELD direccion      AS CHAR
    FIELD mesano         AS CHAR
    FIELD operario      AS CHAR
    FIELD proserv       AS CHAR
    FIELD frecuencia    AS CHAR
    FIELD nrocertif     AS CHAR.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE SmartViewer
&Scoped-define DB-AWARE no

&Scoped-define ADM-SUPPORTED-LINKS Record-Source,Record-Target,TableIO-Target

/* Name of designated FRAME-NAME and/or first browse and/or first query */
&Scoped-define FRAME-NAME F-Main
&Scoped-define BROWSE-NAME BROWSE-7

/* External Tables                                                      */
&Scoped-define EXTERNAL-TABLES Evento
&Scoped-define FIRST-EXTERNAL-TABLE Evento


/* Need to scope the external tables to this procedure                  */
DEFINE QUERY external_tables FOR Evento.
/* Definitions for FRAME F-Main                                         */

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-FIELDS Evento.FRealizado Evento.hora_desde ~
Evento.hora_hasta Evento.Turno Evento.Recursos Evento.Leyenda ~
Evento.FAsignado 
&Scoped-define ENABLED-TABLES Evento
&Scoped-define FIRST-ENABLED-TABLE Evento
&Scoped-Define ENABLED-OBJECTS tlibro Treclamo x_cdg_tipotarea BUTTON-1 ~
cestado vadm BROWSE-7 v-texto 
&Scoped-Define DISPLAYED-FIELDS Evento.FRealizado Evento.hora_desde ~
Evento.hora_hasta Evento.Turno Evento.Recursos Evento.Leyenda ~
Evento.FAsignado 
&Scoped-define DISPLAYED-TABLES Evento
&Scoped-define FIRST-DISPLAYED-TABLE Evento
&Scoped-Define DISPLAYED-OBJECTS tlibro Tnorealizado Treclamo ~
x_cdg_tipotarea cestado r_Entrega vadm v-texto leyenda_contrato eleyenda ~
dsc_tipo_evento 

/* Custom List Definitions                                              */
/* ADM-CREATE-FIELDS,ADM-ASSIGN-FIELDS,List-3,List-4,List-5,List-6      */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _XFTR "Foreign Keys" V-table-Win _INLINE
/* Actions: ? adm/support/keyedit.w ? ? ? */
/* STRUCTURED-DATA
<KEY-OBJECT>
THIS-PROCEDURE
</KEY-OBJECT>
<FOREIGN-KEYS>
nro_evento|y|y|sic.Evento.nro_evento
</FOREIGN-KEYS> 
<EXECUTING-CODE>
**************************
* Set attributes related to FOREIGN KEYS
*/
RUN set-attribute-list (
    'Keys-Accepted = "nro_evento",
     Keys-Supplied = "nro_evento"':U).
/**************************
</EXECUTING-CODE> */
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

/* ************************  Function Prototypes ********************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION-FORWARD formulario V-table-Win 
FUNCTION formulario RETURNS CHARACTER
  ( INPUT rid_fac_header AS ROWID )  FORWARD.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


/* ***********************  Control Definitions  ********************** */


/* Definitions of handles for OCX Containers                            */
DEFINE VARIABLE CtrlFrame AS WIDGET-HANDLE NO-UNDO.
DEFINE VARIABLE chCtrlFrame AS COMPONENT-HANDLE NO-UNDO.
DEFINE VARIABLE ProgressBar AS WIDGET-HANDLE NO-UNDO.
DEFINE VARIABLE chProgressBar AS COMPONENT-HANDLE NO-UNDO.

/* Definitions of the field level widgets                               */
DEFINE BUTTON BRECURSOS 
     LABEL "Recursos" 
     SIZE 10 BY 1.14.

DEFINE BUTTON BUTTON-1 
     LABEL "Prueba" 
     SIZE 15 BY 1.14.

DEFINE VARIABLE cestado AS INTEGER FORMAT "9":U INITIAL 0 
     LABEL "Estado" 
     VIEW-AS COMBO-BOX INNER-LINES 5
     LIST-ITEM-PAIRS "Acalarar Estado Tanque",0,
                     "Sin Observacion",1,
                     "Verificar estado Tapas",2,
                     "Verificar estado Mamposteria",3
     DROP-DOWN-LIST
     SIZE 30 BY 1 NO-UNDO.

DEFINE VARIABLE tlibro AS CHARACTER FORMAT "XX":U INITIAL "*" 
     LABEL "Libro" 
     VIEW-AS COMBO-BOX INNER-LINES 5
     LIST-ITEMS "*","Si","No" 
     DROP-DOWN-LIST
     SIZE 9 BY 1 NO-UNDO.

DEFINE VARIABLE x_cdg_tipotarea AS CHARACTER FORMAT "X(1)" INITIAL "*" 
     VIEW-AS COMBO-BOX INNER-LINES 10
     LIST-ITEM-PAIRS "Item 1","Item 1"
     DROP-DOWN-LIST
     SIZE 30 BY 1
     BGCOLOR 15 FGCOLOR 9 .

DEFINE VARIABLE eleyenda AS CHARACTER 
     VIEW-AS EDITOR NO-WORD-WRAP SCROLLBAR-HORIZONTAL SCROLLBAR-VERTICAL
     SIZE 113 BY 2.67
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE leyenda_contrato AS CHARACTER 
     VIEW-AS EDITOR NO-WORD-WRAP SCROLLBAR-HORIZONTAL SCROLLBAR-VERTICAL
     SIZE 113 BY 2.38 TOOLTIP "Si tiene que modificar esta leyenda ir a CONTRATOS"
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE v-texto LIKE Evento.Observaciones
     VIEW-AS EDITOR NO-WORD-WRAP MAX-CHARS 400 SCROLLBAR-HORIZONTAL SCROLLBAR-VERTICAL
     SIZE 112 BY 2.29 TOOLTIP "Observaciones del evento Privada de la empresa"
     BGCOLOR 15 FGCOLOR 9  NO-UNDO.

DEFINE VARIABLE dsc_tipo_evento AS CHARACTER FORMAT "X(256)":U 
     LABEL "Tipo Evento" 
      VIEW-AS TEXT 
     SIZE 38 BY .62
     BGCOLOR 15 FGCOLOR 9  NO-UNDO.

DEFINE VARIABLE vadm AS CHARACTER FORMAT "X(256)":U 
     LABEL "Administracion" 
     VIEW-AS FILL-IN 
     SIZE 98 BY 1 NO-UNDO.

DEFINE VARIABLE r_Entrega AS INTEGER 
     VIEW-AS RADIO-SET HORIZONTAL
     RADIO-BUTTONS 
          "Sin Ref.", 0,
"Mano", 1,
"Buzon", 2,
"No entregado", 3
     SIZE 50 BY .71 NO-UNDO.

DEFINE VARIABLE Tnorealizado AS LOGICAL INITIAL no 
     LABEL "No realizado" 
     VIEW-AS TOGGLE-BOX
     SIZE 21 BY .81 TOOLTIP "Marcar si este evento NO PUDO REALIZARSE" NO-UNDO.

DEFINE VARIABLE Treclamo AS LOGICAL INITIAL no 
     LABEL "Solicito Reclamo" 
     VIEW-AS TOGGLE-BOX
     SIZE 21 BY .81 TOOLTIP "Se generara un reclamo en funcion al tipo de evento" NO-UNDO.


/* Browse definitions                                                   */
DEFINE BROWSE BROWSE-7
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS BROWSE-7 V-table-Win _STRUCTURED
  
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ROW-MARKERS SEPARATORS SIZE 112 BY 4.05 ROW-HEIGHT-CHARS .57.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME F-Main
     tlibro AT ROW 1 COL 94 COLON-ALIGNED WIDGET-ID 128
     Tnorealizado AT ROW 1.95 COL 86 WIDGET-ID 126
     Evento.FRealizado AT ROW 2.43 COL 14 COLON-ALIGNED WIDGET-ID 58
          VIEW-AS FILL-IN 
          SIZE 16 BY 1
          BGCOLOR 15 FGCOLOR 9 
     Evento.hora_desde AT ROW 2.43 COL 37 COLON-ALIGNED WIDGET-ID 52
          LABEL "Hora" FORMAT "x(5)"
          VIEW-AS FILL-IN 
          SIZE 11.6 BY 1 TOOLTIP "Hora inicio de tareas HHMM"
          BGCOLOR 15 FGCOLOR 9 
     Evento.hora_hasta AT ROW 2.43 COL 49 COLON-ALIGNED NO-LABEL WIDGET-ID 54 FORMAT "x(5)"
          VIEW-AS FILL-IN 
          SIZE 11.6 BY 1 TOOLTIP "Hora fin de tareas formato HHMM"
          BGCOLOR 15 FGCOLOR 9 
     Evento.Turno AT ROW 2.43 COL 69 COLON-ALIGNED WIDGET-ID 64
          VIEW-AS FILL-IN 
          SIZE 5 BY 1
          BGCOLOR 15 FGCOLOR 9  NO-TAB-STOP 
     Treclamo AT ROW 2.62 COL 83 WIDGET-ID 88
     x_cdg_tipotarea AT ROW 3.57 COL 81 COLON-ALIGNED NO-LABEL WIDGET-ID 2
     Evento.Recursos AT ROW 3.67 COL 14 COLON-ALIGNED WIDGET-ID 26
          VIEW-AS FILL-IN 
          SIZE 39 BY 1 TOOLTIP "Recursos asignados para realizar el evento"
          BGCOLOR 15 FGCOLOR 9 
     BRECURSOS AT ROW 3.71 COL 56 WIDGET-ID 36
     BUTTON-1 AT ROW 4.57 COL 67 WIDGET-ID 150
     cestado AT ROW 4.81 COL 81 COLON-ALIGNED WIDGET-ID 124
     r_Entrega AT ROW 5.05 COL 16 NO-LABEL WIDGET-ID 100
     vadm AT ROW 6.14 COL 14 COLON-ALIGNED WIDGET-ID 154
     BROWSE-7 AT ROW 7.38 COL 2 WIDGET-ID 200
     v-texto AT ROW 11.52 COL 2 HELP
          "" NO-LABEL WIDGET-ID 78
          BGCOLOR 15 FGCOLOR 9 
     Evento.Leyenda AT ROW 14.57 COL 2 NO-LABEL WIDGET-ID 94
          VIEW-AS EDITOR NO-WORD-WRAP MAX-CHARS 400 SCROLLBAR-HORIZONTAL SCROLLBAR-VERTICAL
          SIZE 113 BY 2.14 TOOLTIP "Leyenda Publica"
          BGCOLOR 15 FGCOLOR 7 
     leyenda_contrato AT ROW 16.91 COL 2 HELP
          "Leyenda" NO-LABEL WIDGET-ID 122
     eleyenda AT ROW 20.24 COL 2 NO-LABEL WIDGET-ID 114
     dsc_tipo_evento AT ROW 1.24 COL 14 COLON-ALIGNED WIDGET-ID 42
     Evento.FAsignado AT ROW 1.24 COL 64 COLON-ALIGNED WIDGET-ID 10
           VIEW-AS TEXT 
          SIZE 16 BY .62
          BGCOLOR 15 FGCOLOR 9 
     "Leyenda actual :" VIEW-AS TEXT
          SIZE 24 BY .62 AT ROW 13.91 COL 2 WIDGET-ID 96
     "Obs:" VIEW-AS TEXT
          SIZE 5 BY .62 AT ROW 5.24 COL 3 WIDGET-ID 80
     "Leyenda proxima ( este texto se agregara a la leyenda del proximo evento ):" VIEW-AS TEXT
          SIZE 75 BY .62 AT ROW 19.52 COL 2 WIDGET-ID 110
     SPACE(35.00) SKIP(0.00)
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
         HEIGHT             = 22.29
         WIDTH              = 115.4.
/* END WINDOW DEFINITION */
                                                                        */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _INCLUDED-LIB V-table-Win 
/* ************************* Included-Libraries *********************** */

{src/adm/method/viewer.i}
{html.i}

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME




/* ***********  Runtime Attributes and AppBuilder Settings  *********** */

&ANALYZE-SUSPEND _RUN-TIME-ATTRIBUTES
/* SETTINGS FOR WINDOW V-table-Win
  VISIBLE,,RUN-PERSISTENT                                               */
/* SETTINGS FOR FRAME F-Main
   NOT-VISIBLE FRAME-NAME Size-to-Fit                                   */
/* BROWSE-TAB BROWSE-7 vadm F-Main */
ASSIGN 
       FRAME F-Main:SCROLLABLE       = FALSE
       FRAME F-Main:HIDDEN           = TRUE.

/* SETTINGS FOR BUTTON BRECURSOS IN FRAME F-Main
   NO-ENABLE                                                            */
ASSIGN 
       BUTTON-1:HIDDEN IN FRAME F-Main           = TRUE.

/* SETTINGS FOR FILL-IN dsc_tipo_evento IN FRAME F-Main
   NO-ENABLE                                                            */
ASSIGN 
       dsc_tipo_evento:READ-ONLY IN FRAME F-Main        = TRUE.

/* SETTINGS FOR EDITOR eleyenda IN FRAME F-Main
   NO-ENABLE                                                            */
ASSIGN 
       Evento.FAsignado:READ-ONLY IN FRAME F-Main        = TRUE.

/* SETTINGS FOR FILL-IN Evento.hora_desde IN FRAME F-Main
   EXP-LABEL EXP-FORMAT                                                 */
/* SETTINGS FOR FILL-IN Evento.hora_hasta IN FRAME F-Main
   EXP-LABEL EXP-FORMAT                                                 */
ASSIGN 
       Evento.Leyenda:READ-ONLY IN FRAME F-Main        = TRUE.

/* SETTINGS FOR EDITOR leyenda_contrato IN FRAME F-Main
   NO-ENABLE                                                            */
/* SETTINGS FOR RADIO-SET r_Entrega IN FRAME F-Main
   NO-ENABLE                                                            */
/* SETTINGS FOR TOGGLE-BOX Tnorealizado IN FRAME F-Main
   NO-ENABLE                                                            */
ASSIGN 
       Tnorealizado:HIDDEN IN FRAME F-Main           = TRUE.

/* SETTINGS FOR EDITOR v-texto IN FRAME F-Main
   LIKE = sic.Evento.Observaciones EXP-SIZE                             */
ASSIGN 
       vadm:READ-ONLY IN FRAME F-Main        = TRUE.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME


/* Setting information for Queries and Browse Widgets fields            */

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE BROWSE-7
/* Query rebuild information for BROWSE BROWSE-7
     _Query            is NOT OPENED
*/  /* BROWSE BROWSE-7 */
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

CREATE CONTROL-FRAME CtrlFrame ASSIGN
       FRAME           = FRAME F-Main:HANDLE
       ROW             = 1.71
       COLUMN          = 106
       HEIGHT          = 1.43
       WIDTH           = 6
       WIDGET-ID       = 148
       HIDDEN          = yes
       SENSITIVE       = yes.

CREATE CONTROL-FRAME ProgressBar ASSIGN
       FRAME           = FRAME F-Main:HANDLE
       ROW             = 4.1
       COLUMN          = 68
       HEIGHT          = .71
       WIDTH           = 12
       WIDGET-ID       = 152
       HIDDEN          = no
       SENSITIVE       = yes.

PROCEDURE adm-create-controls:
      CtrlFrame:NAME = "CtrlFrame":U .
/* CtrlFrame OCXINFO:CREATE-CONTROL from: {F0B88A90-F5DA-11CF-B545-0020AF6ED35A} type: PSTimer */
      ProgressBar:NAME = "ProgressBar":U .
/* ProgressBar OCXINFO:CREATE-CONTROL from: {4A5E5E35-91F4-46B1-B62F-78148132EF93} type: XP_ProgressBar */
      CtrlFrame:MOVE-AFTER(tlibro:HANDLE IN FRAME F-Main).
      ProgressBar:MOVE-AFTER(BRECURSOS:HANDLE IN FRAME F-Main).

END PROCEDURE.

&ENDIF

&ANALYZE-RESUME /* End of _CREATE-DYNAMIC */


/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME BRECURSOS
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL BRECURSOS V-table-Win
ON CHOOSE OF BRECURSOS IN FRAME F-Main /* Recursos */
DO:
  DEF VAR lista AS CHAR.
  lista = evento.recursos:SCREEN-VALUE.
  RUN d-recursos.w (INPUT-OUTPUT lista,STRING(evento.nro_tipo_evento)).
  evento.recursos:SCREEN-VALUE = lista.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define BROWSE-NAME BROWSE-7
&Scoped-define SELF-NAME BROWSE-7
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL BROWSE-7 V-table-Win
ON VALUE-CHANGED OF BROWSE-7 IN FRAME F-Main
DO:
    IF AVAILABLE tttexto THEN v-texto = tttexto.ttexto.
    DISPLAY v-texto WITH FRAME {&FRAME-NAME}. 
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME BUTTON-1
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL BUTTON-1 V-table-Win
ON CHOOSE OF BUTTON-1 IN FRAME F-Main /* Prueba */
DO:

find evento WHERE evento.nro_certif = 16887.
/*{debug.i}*/


RUN sendemail(evento.nro_evento,"fvergniaud@gmail.com").
MESSAGE "FIN".
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME CtrlFrame
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL CtrlFrame V-table-Win OCX.Tick
PROCEDURE CtrlFrame.PSTimer.Tick .
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  None required for OCX.
  Notes:       
------------------------------------------------------------------------------*/

IF chProgressBar:ProgressBar-2:VALUE < 10 THEN 
        chProgressBar:ProgressBar-2:VALUE = chProgressBar:ProgressBar-2:VALUE + 1.
ELSE
        chProgressBar:ProgressBar-2:VALUE = 0.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME Evento.FAsignado
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Evento.FAsignado V-table-Win
ON LEAVE OF Evento.FAsignado IN FRAME F-Main /* Asignado */
DO:
    /*
  IF SELF:MODIFIED THEN DO:
      /*se modificaron los recursos asignados o a asignar*/
      IF evento.asignado:CHECKED THEN DO:
          /*se desasigna los recursos anteriores y se asignan los nuevos*/
          sino-msg = NO.
          RUN mensajepregunta.p ( INPUT "",INPUT "OPR0005", INPUT-OUTPUT sino-msg ). 
          IF sino-msg THEN DO:
              /*primero desagignar las agendas*/
              DO i = 1 TO NUM-ENTRIES(evento.recursos):
                      FIND recurso_agenda NO-LOCK WHERE recurso.cdg_recurso = ENTRY(i,evento.recurso) AND
                          recurso_agenda.fecha = evento.fasignado AND
                          recurso_agenda.nro_evento = evento.nro_evento NO-ERROR.
                          IF AVAILABLE recurso_agenda THEN DELETE recurso_agenda.
                          
              END.
              /*reasignar*/
              DO i = 1 TO NUM-ENTRIES(evento.recursos:SCREEN-VALUE):
                      FIND recurso_agenda WHERE recurso.cdg_recurso = ENTRY(i,evento.recurso:SCREEN-VALUE) AND
                          recurso_agenda.fecha = evento.fasignado:INPUT-VALUE AND
                          recurso_agenda.nro_evento = evento.nro_evento NO-LOCK NO-ERROR.
                          IF NOT AVAILABLE recurso_agenda THEN do:
                              CREATE recurso_agenda.
                              ASSIGN recurso_agenda.cdg_recurso = ENTRY(i,evento.recurso:SCREEN-VALUE)
                                     recurso_agenda.fecha = evento.fasignado:INPUT-VALUE
                                     recurso_agenda.nro_evento = evento.nro_evento.
                          END.
              END.
          END.
          ELSE RETURN NO-APPLY.
      END.
  END.*/
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME Evento.FRealizado
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Evento.FRealizado V-table-Win
ON MOUSE-MENU-CLICK OF Evento.FRealizado IN FRAME F-Main /* FRealizado */
DO:
  { selfecha.i }
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


&Scoped-define SELF-NAME Evento.Recursos
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Evento.Recursos V-table-Win
ON LEAVE OF Evento.Recursos IN FRAME F-Main /* Recursos */
DO:


/*   IF SELF:MODIFIED THEN DO:                                                                                    */
/*       /*se modificaron los recursos asignados o a asignar*/                                                    */
/*       IF evento.asignado:CHECKED THEN DO:                                                                      */
/*           /*se desasigna los recursos anteriores y se asignan los nuevos*/                                     */
/*           sino-msg = NO.                                                                                       */
/*           RUN mensajepregunta.p ( INPUT "",INPUT "OPR0005", INPUT-OUTPUT sino-msg ).                           */
/*           IF sino-msg THEN DO:                                                                                 */
/*               /*primero desagignar las agendas*/                                                               */
/*               MESSAGE evento.recursos evento.recursos:SCREEN-VALUE evento.recursos:INPUT-VALUE                 */
/*                   VIEW-AS ALERT-BOX INFO BUTTONS OK.                                                           */
/*                                                                                                                */
/*               DO i = 1 TO NUM-ENTRIES(evento.recursos):                                                        */
/*                       FIND recurso_agenda WHERE recurso.cdg_recurso = ENTRY(i,evento.recurso) AND              */
/*                           recurso_agenda.fecha = evento.fasignado AND                                          */
/*                           recurso_agenda.nro_evento = evento.nro_evento NO-LOCK NO-ERROR.                      */
/*                           IF AVAILABLE recurso_agenda THEN DELETE recurso_agenda.                              */
/*                                                                                                                */
/*               END.                                                                                             */
/*               /*reasignar*/                                                                                    */
/*               DO i = 1 TO NUM-ENTRIES(evento.recursos:SCREEN-VALUE):                                           */
/*                       FIND recurso_agenda WHERE recurso.cdg_recurso = ENTRY(i,evento.recurso:SCREEN-VALUE) AND */
/*                           recurso_agenda.fecha = evento.fasignado:INPUT-VALUE AND                              */
/*                           recurso_agenda.nro_evento = evento.nro_evento NO-LOCK NO-ERROR.                      */
/*                           IF NOT AVAILABLE recurso_agenda THEN do:                                             */
/*                               CREATE recurso_agenda.                                                           */
/*                               ASSIGN recurso_agenda.cdg_recurso = ENTRY(i,evento.recurso:SCREEN-VALUE)         */
/*                                      recurso_agenda.fecha = evento.fasignado:INPUT-VALUE                       */
/*                                      recurso_agenda.nro_evento = evento.nro_evento.                            */
/*                           END.                                                                                 */
/*               END.                                                                                             */
/*           END.                                                                                                 */
/*           ELSE RETURN NO-APPLY.                                                                                */
/*       END.                                                                                                     */
/*   END.                                                                                                         */
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME Treclamo
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Treclamo V-table-Win
ON VALUE-CHANGED OF Treclamo IN FRAME F-Main /* Solicito Reclamo */
DO:
  X_cdg_tipotarea:SENSITIVE = treclamo:CHECKED.
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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE adm-find-using-key V-table-Win  adm/support/_key-fnd.p
PROCEDURE adm-find-using-key :
/*------------------------------------------------------------------------------
  Purpose:     Finds the current record using the contents of
               the 'Key-Name' and 'Key-Value' attributes.
  Parameters:  <none>
------------------------------------------------------------------------------*/
  DEF VAR key-value AS CHAR NO-UNDO.
  DEF VAR row-avail-enabled AS LOGICAL NO-UNDO.

  /* LOCK status on the find depends on FIELDS-ENABLED. */
  RUN get-attribute ('FIELDS-ENABLED':U).
  row-avail-enabled = (RETURN-VALUE eq 'yes':U).
  /* Look up the current key-value. */
  RUN get-attribute ('Key-Value':U).
  key-value = RETURN-VALUE.

  /* Find the current record using the current Key-Name. */
  RUN get-attribute ('Key-Name':U).
  CASE RETURN-VALUE:
    WHEN 'nro_evento':U THEN
       {src/adm/template/find-tbl.i
           &TABLE = Evento
           &WHERE = "WHERE Evento.nro_evento eq INTEGER(key-value)"
       }
  END CASE.

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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE control_load V-table-Win  _CONTROL-LOAD
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

OCXFile = SEARCH( "v-evento1.wrx":U ).
IF OCXFile = ? THEN
  OCXFile = SEARCH(SUBSTRING(THIS-PROCEDURE:FILE-NAME, 1,
                     R-INDEX(THIS-PROCEDURE:FILE-NAME, ".":U), "CHARACTER":U) + "wrx":U).

IF OCXFile <> ? THEN
DO:
  ASSIGN
    chCtrlFrame = CtrlFrame:COM-HANDLE
    UIB_S = chCtrlFrame:LoadControls( OCXFile, "CtrlFrame":U)
    chProgressBar = ProgressBar:COM-HANDLE
    UIB_S = chProgressBar:LoadControls( OCXFile, "ProgressBar":U)
  .
  RUN DISPATCH IN THIS-PROCEDURE("initialize-controls":U) NO-ERROR.
END.
ELSE MESSAGE "v-evento1.wrx":U SKIP(1)
             "The binary control file could not be found. The controls cannot be loaded."
             VIEW-AS ALERT-BOX TITLE "Controls Not Loaded".

&ENDIF

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
/*DEFINE VAR nnro AS INT.
DEFINE VAR nro_tipo_evento_rl LIKE tipo_evento.nro_tipo_evento NO-UNDO.
DEFINE BUFFER bevento FOR evento.
FIND tipo_evento WHERE tipo_evento.cdg_tipo_evento = "RL" NO-LOCK.
nro_tipo_evento_rl = tipo_evento.nro_tipo_evento.

IF evento.nro_tipo_evento <> nro_tipo_evento_tanque OR evento.sub_evento <> 1 OR 
   evento.origen <> "CONTRATO" THEN RETURN.
FIND evento_protocolo OF evento NO-ERROR.
IF NOT AVAILABLE evento_protocolo THEN RETURN.
IF evento_protocolo.estado <> "P" AND evento_protocolo.estado <> "I" THEN RETURN.
      /*verificar el libro y las tareas relacionadas*/
/*ver si tiene restriccion de libroT*/
FIND restriccion NO-LOCK WHERE restriccion.cdg_restriccion = "LIBROT".
FIND cliente_restriccion NO-LOCK WHERE cliente_restriccion.nro_cliente = evento.nro_cliente AND
cliente_restriccion.nro_restriccion = restriccion.nro_restriccion.
IF AVAILABLE cliente_restriccion AND cliente_restriccion.valor = "N" THEN DO:
                FIND tipo_evento WHERE tipo_evento.cdg_tipo_evento = "EC" NO-LOCK.
                FIND bevento WHERE bevento.nro_identificacion = evento.nro_evento AND
                                   bevento.nro_tipo_evento = tipo_evento.nro_tipo_evento NO-ERROR.
                IF AVAILABLE bevento THEN return.
                CREATE bevento.
                ASSIGN bevento.nro_evento = NEXT-VALUE(proximo_evento)
                       bevento.nro_tipo_evento = tipo_evento.nro_tipo_evento
                       bevento.fasignado = ?
                       bevento.nro_identificacion = evento.nro_evento /*porque deviene de un evento*/
                       bevento.origen = "EVENTO"
                       bevento.nro_cliente = tarea.nro_cliente
                       bevento.FCreado = TODAY
                       bevento.periodo = YEAR(today) * 100 + MONTH(today)
                       bevento.fmin = TODAY
                       bevento.fmax = TODAY + 20 /*fijo cualquier cosa se vera*/
                       bevento.recurso = ""
                       bevento.observacion = "Por LT:" + STRING(evento.frealizado)
                       bevento.duracion = 15.
                       bevento.turno = "**".
RETURN.
END.
/*vamos por las tareas*/
      IF Evento.trae_libro THEN DO: 
          FIND FIRST tarea WHERE tarea.cdg_tipotarea = "H" AND tarea.origen = "EVENTO" AND tarea.nro_identificacion = evento.nro_evento and
                                         tarea.estado <> "D" NO-LOCK NO-ERROR.
          IF NOT AVAILABLE tarea THEN DO:
            FIND FIRST tarea WHERE tarea.cdg_tipotarea = "J" AND tarea.origen = "EVENTO" AND tarea.nro_identificacion = evento.nro_evento AND 
                                        tarea.estado <> "D" NO-LOCK NO-ERROR.
            IF NOT AVAILABLE tarea THEN DO: /*me aseguro que no fue por el camino de la J*/
               RUN crea_tarea.p( evento.nro_evento,evento.nro_cliente, "H" , "Origen EventoLT:" + STRING(evento.nro_evento),"Origen EventoLT:" + STRING(evento.nro_evento),TODAY,"*",OUTPUT nnro).
               FIND tarea WHERE tarea.nro_tarea = nnro NO-ERROR.
               IF NOT AVAILABLE tarea THEN DO:
                  DISPLAY "No se ha podido crear la tarea H para el evento" evento.nro_evento. 
                  RETURN ERROR.
               END.
               tarea.datos-template = "EVENTOLT|" + STRING(evento_protocolo.nro_evento).
            END.
            ELSE DO:
               FIND FIRST bevento WHERE bevento.origen = "TAREA" AND bevento.nro_identificacion = tarea.nro_tarea and
                                        bevento.nro_tipo_evento = nro_tipo_evento_RL AND NOT bevento.anulado NO-LOCK NO-ERROR.
               IF AVAILABLE bevento THEN DO:
                        IF bevento.frealizado <> ? THEN DO:
                           RUN crea_tarea.p( bevento.nro_evento,bevento.nro_cliente, "H" , "Origen EventoRL:" + STRING(bevento.nro_evento),"EventoLT:" + STRING(evento.nro_evento),TODAY,"*",OUTPUT nnro).
                           FIND tarea WHERE tarea.nro_tarea = nnro NO-ERROR.
                           IF NOT AVAILABLE tarea THEN DO:
                              DISPLAY "No se ha podido crear la tarea H para el evento" evento.nro_evento. 
                              RETURN ERROR.
                           END.
                           tarea.datos-template = "EVENTOLT|" + STRING(evento_protocolo.nro_evento).
                        END.
               END.
          
            END.
          END.
      END.
      /*ver si existen tareas J con tienelibro en falso y cerradas*/
      IF NOT evento.trae_libro AND ( evento_protocolo.estado = "P" OR evento_protocolo.estado = "I" )THEN DO:
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
      END.
/*crear tarea J*/
*/
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
/*DEFINE VAR nnro AS INT.
DEFINE BUFFER bevento FOR evento.
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
IF NOT (evento_protocolo.estado = "I" OR evento_protocolo.estado="P") THEN RETURN.
/*ver si tiene restriccion de libroT*/
FIND restriccion NO-LOCK WHERE restriccion.cdg_restriccion = "LIBROT".
FIND cliente_restriccion NO-LOCK WHERE cliente_restriccion.nro_cliente = evento.nro_cliente AND
cliente_restriccion.nro_restriccion = restriccion.nro_restriccion.
IF AVAILABLE cliente_restriccion AND cliente_restriccion.valor = "N" THEN DO:
                FIND tipo_evento WHERE tipo_evento.cdg_tipo_evento = "EC" NO-LOCK.
                FIND bevento WHERE bevento.nro_identificacion = evento.nro_evento AND
                                   bevento.nro_tipo_evento = tipo_evento.nro_tipo_evento NO-ERROR.
                IF AVAILABLE bevento THEN return.
                CREATE bevento.
                ASSIGN bevento.nro_evento = NEXT-VALUE(proximo_evento)
                       bevento.nro_tipo_evento = tipo_evento.nro_tipo_evento
                       bevento.fasignado = ?
                       bevento.nro_identificacion = evento.nro_evento /*porque deviene de un evento*/
                       bevento.origen = "EVENTO"
                       bevento.nro_cliente = tarea.nro_cliente
                       bevento.FCreado = TODAY
                       bevento.periodo = YEAR(today) * 100 + MONTH(today)
                       bevento.fmin = TODAY
                       bevento.fmax = TODAY + 20 /*fijo cualquier cosa se vera*/
                       bevento.recurso = ""
                       bevento.observacion = "Por LT:" + STRING(evento.frealizado)
                       bevento.duracion = 15.
                       bevento.turno = "**".
RETURN.
END.
/*vamos por las tareas*/
RUN crea_tarea.p( evento.nro_evento,evento.nro_cliente, "H" , "Origen EventoRL:" + STRING(evento.nro_evento),"EventoLT:" + STRING(bevento.nro_evento),TODAY,"*",OUTPUT nnro).
FIND tarea WHERE tarea.nro_tarea = nnro NO-ERROR.
IF NOT AVAILABLE tarea THEN DO:
            DISPLAY "No se ha podido crear la tarea H para el evento" evento.nro_evento. 
            NEXT.
END.
tarea.datos-template = "EVENTOLT|" + STRING(evento_protocolo.nro_evento).
*/
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE desasignar V-table-Win 
PROCEDURE desasignar :
/*------------------------------------------------------------------------------
  Purpose:     desasigna el evento corriente
  Parameters:  <non
  Notes:       
------------------------------------------------------------------------------*/
DEFINE BUFFER bevento FOR evento.
DEFINE VAR hproc AS WIDGET-HANDLE NO-UNDO.   
DEFINE VAR hcproc AS CHARACTER NO-UNDO.
DEFINE VAR eve-rela AS CHAR NO-UNDO.
DEFINE VAR k AS INT NO-UNDO.
DEFINE INPUT PARAMETER vv AS CHAR NO-UNDO.
/*eliminar aviso*/
FIND FIRST bevento WHERE bevento.RefEvento = evento.nro_evento AND NOT bevento.anulado NO-ERROR.
    IF AVAILABLE bevento THEN DO:
          FOR each recurso_agenda WHERE recurso_agenda.nro_evento = bevento.nro_evento:
               DELETE recurso_agenda.
          END.
          DELETE bevento.
    END.
   eve-rela = "".
    FOR EACH bevento WHERE bevento.evsigue = evento.nro_evento AND
        bevento.fasignado = evento.fasignado AND
        bevento.frealizado = ? AND
        NOT bevento.anulado NO-LOCK:
        eve-rela = eve-rela + "," + STRING(bevento.nro_evento,">>>>>>>>9").
    END.
    IF evento.evsigue <> 0 THEN DO:
        FIND FIRST bevento WHERE bevento.nro_evento = evento.evsigue and
            NOT bevento.anulado and
            ( avisoentregado(bevento.nro_evento) OR bevento.bloqueado OR bevento.frealizado <> ?) NO-LOCK NO-ERROR.
            IF AVAILABLE bevento THEN
                eve-rela = eve-rela + "," + STRING(evento.evsigue,">>>>>>>>9").
    END.
    eve-rela = SUBSTRING(eve-rela,2). 
    IF num-entries(eve-rela) > 0 THEN DO:
          MESSAGE "El evento posee los siguientes eventos relacionados" SKIP
                  eve-rela SKIP
                  "con acciones en curso, de todas meneras se va a desasignar" skip
                  "eliminando la relacion existente entre ellos" 
                  VIEW-AS ALERT-BOX INFORMATION.
        DO k = 1 TO NUM-ENTRIES(eve-rela):
             FIND FIRST bevento WHERE bevento.nro_evento = INT(ENTRY(k,eve-rela)).
             bevento.evsigue = 0.
        END.
    END.
    FIND CURRENT evento EXCLUSIVE-LOCK.
    evento.observaciones = agregaAdvTexto("Se desasigna (" + evento.recursos + ")" + string(evento.fasignado)+ "#" + v-texto, evento.observaciones).
    evento.fasignado = ?.
    evento.frealizado = ?.
    evento.impreso = FALSE.
    IF evento.nro_tipo_evento = 1 AND evento.nro_certif <> 0 THEN DO:
        IF evento.origen = "CONTRATO" THEN DO:
                FIND contrato_hd NO-LOCK WHERE contrato_hd.nro_contrato = evento.nro_identificacion.
                IF contrato_hd.numero_eventos = evento.sub_evento THEN DO:
                    MESSAGE "Recupere la oblea" evento.letraprefijo evento.nro_certif 
                         "del certificado" VIEW-AS ALERT-BOX INFORMATION.
                    CREATE certificados.
                    ASSIGN certificados.tipo = evento.tipo_certif
                           certificados.nro_Hasta = evento.nro_certificado
                           certificados.observaciones = string(evento.nro_evento)
                           certificados.nro_desde = evento.nro_certificado
                           certificados.nro_certificado = 0
                           certificados.letraprefijo = evento.letraprefijo
                           certificados.nro_tipo_evento = evento.nro_tipo_evento
                           certificados.falta = TODAY
                           evento.observaciones = agregaAdvTexto("Recupera oblea:" + certificados.letraprefijo + string(certificados.nro_desde), evento.observaciones).
                           FOR EACH bevento WHERE bevento.nro_certificado =  certificados.nro_desde AND
                                                  bevento.letraprefijo = certificados.letraprefijo :
                               ASSIGN bevento.nro_certificado = 0
                                      bevento.letraprefijo = ""
                                      bevento.tipo_certif = "".
                           END.       
                END.
        END.
    END.
     /*
    FOR each recurso_agenda WHERE recurso_agenda.nro_evento = evento.nro_evento:
        DELETE recurso_agenda.
    END. 
    */

   k= evento.nro_evento.
   RELEASE evento.
   RUN get-link-handle IN adm-broker-hdl
            ( INPUT THIS-PROCEDURE,
              INPUT "record-source",
              OUTPUT hcp ).
     hp = WIDGET-HANDLE(hcp).
     IF VALID-HANDLE( hp) THEN DYNAMIC-FUNCTION("desa1" IN hp , k).

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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE imprecibo V-table-Win 
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

            FOR each fac_detalle OF fac_header .
                FIND articulo OF fac_detalle.
                IF articulo.nro_tipo_evento <> evento.nro_tipo_evento THEN NEXT.
                LEAVE.
            END.
            IF NOT AVAILABLE fac_detalle THEN NEXT.
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
            FOR each fac_detalle OF fac_header .
                FIND articulo OF fac_detalle.
                IF articulo.nro_tipo_evento <> evento.nro_tipo_evento THEN NEXT.
                LEAVE.
            END.
            IF NOT AVAILABLE fac_detalle THEN NEXT.
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
    RUN crearReporte(chReport,"rpt",/*ViewReport*/ FALSE, /*impresora*/ impreport(6) , 
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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE inicio_tipo_tarea V-table-Win 
PROCEDURE inicio_tipo_tarea :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
  DEFINE VAR x-lista AS CHAR NO-UNDO.
  x-lista = "[Indique Tipo de Tarea],*".
  FOR EACH Tipo_tarea  NO-LOCK BY Tipo_tarea.cdg_tipotarea BY tipo_tarea.dsc_tipotarea:
    x-lista = x-lista +  "," + Tipo_tarea.dsc_tipotarea + "," + Tipo_tarea.cdg_tipotarea.
  END.
  x_cdg_tipotarea:LIST-ITEM-PAIRS IN FRAME {&FRAME-NAME} = SUBSTRING(x-lista,1).


END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE local-assign-statement V-table-Win 
PROCEDURE local-assign-statement :
/*------------------------------------------------------------------------------
  Purpose:     Override standard ADM method
  Notes:       
------------------------------------------------------------------------------*/
DEFINE BUFFER bevento FOR evento.
DEFINE VAR opt AS LOGICAL NO-UNDO.
DEFINE VAR pdur AS INT NO-UNDO.
DEFINE VAR rok LIKE tarea.nro_tarea NO-UNDO.
DEFINE BUFFER btarea FOR tarea.
DEFINE VAR hproc AS HANDLE.
DEFINE VAR hcproc AS CHARACTER.
DEFINE VAR grabobs AS LOGICAL.
 
ASSIGN FRAME {&FRAME-NAME} 
    treclamo 
    x_cdg_tipotarea
    eleyenda
    tlibro
    tnorealizado
    v-texto.
grabobs = FALSE.
IF r_entrega:SENSITIVE THEN ASSIGN r_entrega.
IF cestado:SENSITIVE THEN ASSIGN cestado.

tlibro = "No".
IF treclamo AND x_cdg_tipotarea = "*" THEN DO:
        MESSAGE "Debe indicar el tipo de tarea a realizar" VIEW-AS ALERT-BOX ERROR.
        RETURN ERROR.
END.

evento.hora_hasta:SCREEN-VALUE = ajuh(evento.hora_hasta:SCREEN-VALUE).    
evento.hora_desde:SCREEN-VALUE = ajuh(evento.hora_desde:SCREEN-VALUE).
pdur = (ahdec(aint(evento.hora_hasta:SCREEN-VALUE)) - ahdec(aint(evento.hora_desde:SCREEN-VALUE))) * 60. 

IF pdur <= 0 
THEN DO:
        MESSAGE "Horario invalido".
        RETURN ERROR.
END.

IF (pdur < evento.duracion * .8 OR pdur > evento.duracion * 1.2) AND FALSE
THEN DO:
    IF NOT v-texto:MODIFIED THEN DO:
        MESSAGE "El horario esta fuera de los limites, debe justificar la diferencia".
        RETURN ERROR.
    END.
    ELSE DO:
        MESSAGE "Esta Seguro aceptar este horario fuera de lo normal" VIEW-AS ALERT-BOX QUESTION BUTTONS YES-NO UPDATE opt.
        IF NOT opt THEN RETURN ERROR.
    END.
END.

IF frealizado:INPUT-VALUE = ? THEN DO:
        MESSAGE "Fecha realizado invalida".
        RETURN ERROR.
END.

IF frealizado:INPUT-VALUE > TODAY THEN DO:
    MESSAGE "La fecha no puede ser mayor a la actual".
        RETURN ERROR.
END.
opt = false.
IF frealizado:INPUT-VALUE < TODAY - 5 THEN DO:
    MESSAGE "Esta cargando una fecha atrazada, Confirme que es correcta" VIEW-AS ALERT-BOX QUESTION BUTTONS YES-NO UPDATE opt.
    IF NOT opt THEN
        RETURN ERROR.
END.
IF frealizado:INPUT-VALUE < fasignado THEN DO:
    MESSAGE "Esta cargando una fecha anterior a la asignada, corrija los valores" VIEW-AS ALERT-BOX ERROR.
    RETURN ERROR.
END.
IF frealizado:INPUT-VALUE = ? THEN DO:
    MESSAGE "Para desasignar marque el evento como NO realizado" VIEW-AS ALERT-BOX ERROR.
    RETURN ERROR.
END.
IF evento.nro_tipo_evento = nro_tipo_evento_aviso THEN
    IF r_entrega = 0 THEN DO:
        MESSAGE "Opcion invalida indique alguna opcion" VIEW-AS ALERT-BOX ERROR.
        RETURN ERROR.
    END.
IF evento.nro_tipo_evento = nro_tipo_evento_tanque AND NOT tnorealizado THEN
    IF cestado = 0 THEN DO:
        MESSAGE "Estado tanque invalido, seleccione alguna opcion" VIEW-AS ALERT-BOX ERROR.
        RETURN ERROR.
    END.
IF tnorealizado AND NOT v-texto:MODIFIED THEN DO:
        MESSAGE "Por favor aclare porque no se pudo realizar el trabajo" VIEW-AS ALERT-BOX ERROR.
        RETURN ERROR.
END.


  RUN dispatch IN THIS-PROCEDURE ( INPUT 'assign-statement':U ) .
  
  IF tnorealizado THEN DO:
         /*desasignamos el evento*/
            RUN desasignar(v-texto).
            grabobs = TRUE.
            RETURN.
  END.
  IF evento.nro_tipo_evento = nro_tipo_evento_aviso THEN DO:
        evento.entrega = r_entrega.
        IF r_entrega = 3 THEN DO:
         /*desasignamos el evento*/
            RUN desasignar(v-texto).
            grabobs = TRUE.
            RETURN.
        END.
  END.
  IF evento.nro_tipo_evento = nro_tipo_evento_tanque THEN DO:
        evento.entrega = cestado.
  END.

/*propagando las leyendas*/
  IF v-texto:MODIFIED AND NOT grabobs THEN DO:
      evento.observaciones = agregaAdvTexto( v-texto, evento.observaciones).
      grabobs = TRUE.
  END.

FOR EACH bevento WHERE bevento.origen = evento.origen AND
    bevento.nro_identificacion = evento.nro_identificacion AND
    bevento.nro_tipo_evento = evento.nro_tipo_evento AND
    bevento.nro_identificacion <> 0 AND
    bevento.sub_evento = evento.sub_evento AND
    bevento.nro_cliente = evento.nro_cliente AND
    NOT bevento.anulado AND
    NOT bevento.frealizado<>? 
    AND bevento.periodo >= evento.periodo
    AND ROWID(bevento) <> ROWID(evento) BY bevento.periodo:
    bevento.leyenda =  eleyenda.
    LEAVE.
END.

IF treclamo THEN DO:
    FIND FIRST tarea WHERE Tarea.nro_identificacion = evento.nro_evento AND tarea.cdg_tipotarea <> "Z" AND tarea.estado = "A" NO-LOCK NO-ERROR.
    IF AVAILABLE tarea THEN DO:
        MESSAGE "Ya existe una tarea para este evento, Abre otra mas?" VIEW-AS ALERT-BOX QUESTION BUTTONS YES-NO UPDATE opt.
    END.
    ELSE opt = TRUE.
    IF opt THEN DO:
        RUN crea_tarea.p( evento.nro_evento,
                          evento.nro_cliente,x_cdg_tipotarea ,
                          "Evento:" + string(evento.nro_evento) ,
                          v-texto:INPUT-VALUE /*evento.observaciones*/,
                          TODAY,"",OUTPUT rok).
        IF rok = ? THEN DO:
            MESSAGE "No se puede crear tarea por error en usuario/recurso".
            RETURN ERROR.
        END.
        ELSE DO: 
            FIND tarea WHERE tarea.nro_tarea = rok EXCLUSIVE-LOCK.
            FIND recurso WHERE recurso.cdg_recurso = ENTRY(1,evento.recurso) NO-LOCK.
            tarea.reportado_por = Recurso.nom_recurso.
            tarea.leyenda = eleyenda.
            MESSAGE "Se ha creado la tarea " rok VIEW-AS ALERT-BOX INFORMATION.
        END.
        
    END.
END.

/*De aca en mas el evento se realizo*/
IF evento.fasignado = ? THEN DO:
    ASSIGN evento.fasignado = evento.frealizado.
    FOR EACH recurso_agenda  WHERE recurso_agenda .nro_evento = evento.nro_evento:
            recurso_agenda.fecha = evento.fasignado.
    END.

END.
FOR EACH tarea OF evento WHERE ( tarea.cdg_tipotarea="Z" OR tarea.cdg_tipotarea="T" ) AND tarea.estado = "A":
        tarea.estado="D".
        tarea.descripcion = agregaAdvTexto("Se realizo el evento sin confirmacion",tarea.descripcion).
END.
/*
IF evento.refevento<>0 THEN DO:
    FOR EACH tarea WHERE tarea.nro_evento = evento.refevento and ( tarea.cdg_tipotarea="Z" OR tarea.cdg_tipotarea="T" ) AND tarea.estado = "A":
            tarea.estado="D".
            tarea.descripcion = agregaAdvTexto("Se realizo el evento sin confirmacion",tarea.descripcion).
    END.
END.
*/
IF evento.origen BEGINS "REMIT" THEN DO: 
    FIND rem_header WHERE rem_header.nro_remito = evento.nro_identificacion.
    if sic.Rem_header.cdg_formapago <> 0 AND NOT rem_header.sin_cargo THEN DO:
            RUN crea_tarea.p( evento.nro_evento,evento.nro_cliente, "C" , "Cobranza Remito" + rem_header.tip_comprob + "-" + STRING(rem_header.prf_comprob) + "-" + string(rem_header.nro_comprob),"Cobranza Remito" + rem_header.tip_comprob + "-" + STRING(rem_header.prf_comprob) + "-" + string(rem_header.nro_comprob), USERID("SIC"),TODAY,"*",OUTPUT rok).
            IF rok = ? THEN DO:
                MESSAGE "No se puede crear tarea por error en usuario/recurso".
                RETURN ERROR.
            END.
            ELSE DO: 
                FIND tarea WHERE tarea.nro_tarea = rok EXCLUSIVE-LOCK.
                FIND recurso WHERE recurso.cdg_recurso = ENTRY(1,evento.recurso) NO-LOCK.
                tarea.reportado_por = Recurso.nom_recurso.
                MESSAGE "Se ha creado la tarea " rok VIEW-AS ALERT-BOX INFORMATION.
            END.
                
    END.
END.

RUN imprecibo.
/*RUN impcertif.p ( evento.nro_evento , "R" ,8).*/
IF evento.nro_tipo_evento = 1 THEN
  RUN sendemail(evento.nro_evento,"").  
IF evento.frealizado <> ? THEN DO:
            RUN get-link-handle IN adm-broker-hdl
             ( INPUT THIS-PROCEDURE,
               INPUT "record-source",
               OUTPUT hcproc ).
               hproc = WIDGET-HANDLE( hcproc ).
               IF VALID-HANDLE(hProc) THEN
                 DYNAMIC-FUNCTION("oc" IN hproc ).
      END.
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
  Brecursos:SENSITIVE IN FRAME {&FRAME-NAME}  = FALSE.
  treclamo:SENSITIVE = false.
  evento.leyenda:SENSITIVE = false.
  v-texto:SENSITIVE = false.
  X_cdg_tipotarea:SENSITIVE = FALSE.
  r_entrega:SENSITIVE = FALSE.
  r_entrega:HIDDEN = TRUE.
  cestado:SENSITIVE = FALSE.
  cestado:HIDDEN = TRUE.
  eleyenda:SENSITIVE = false.
  tlibro:sensitive IN FRAME {&FRAME-NAME} = FALSE.
  tnorealizado:sensitive IN FRAME {&FRAME-NAME} = FALSE.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE local-display-fields V-table-Win 
PROCEDURE local-display-fields :
/*------------------------------------------------------------------------------
  Purpose:     Override standard ADM method
  Notes:       
------------------------------------------------------------------------------*/
DEFINE BUFFER bevento FOR evento.
    DEFINE BUFFER administracion FOR cliente.
  /* Code placed here will execute PRIOR to standard behavior. */
  leyenda_contrato = "".

  /* Dispatch standard ADM method.                             */
  RUN dispatch IN THIS-PROCEDURE ( INPUT 'display-fields':U ) .
  IF AVAILABLE evento THEN DO:
      FOR EACH bevento WHERE bevento.origen = evento.origen AND
        bevento.nro_identificacion = evento.nro_identificacion AND
        bevento.nro_tipo_evento = evento.nro_tipo_evento AND
        bevento.nro_cliente = evento.nro_cliente AND
        bevento.nro_identificacion <> 0 AND
        bevento.sub_evento = evento.sub_evento AND
        NOT bevento.anulado AND
        NOT bevento.frealizado<>? 
        AND bevento.periodo >= evento.periodo
        AND ROWID(bevento) <> ROWID(evento)
        BY evento.periodo:
           eleyenda = bevento.leyenda.
           LEAVE.
      END.
      IF evento.origen = "contrato" THEN do:
         FIND contrato_hd WHERE contrato_hd.nro_contrato = evento.nro_identificacion NO-LOCK.
         leyenda_contrato = contrato_hd.leyenda.
      END.
      FIND tipo_evento WHERE evento.nro_tipo_evento = tipo_evento.nro_tipo_evento NO-LOCK NO-ERROR.
      IF AVAILABLE tipo_evento THEN
       dsc_tipo_evento:SCREEN-VALUE IN FRAME {&FRAME-NAME} = tipo_evento.descripcion.
      ELSE
       dsc_tipo_evento:SCREEN-VALUE = "NO REGISTRADO".
       evento.hora_desde:SCREEN-VALUE = ajuh(evento.hora_desde).
       evento.hora_hasta:SCREEN-VALUE = ajuh(evento.hora_hasta).
      IF evento.nro_tipo_evento = nro_tipo_evento_aviso THEN DO:
          r_entrega:HIDDEN = evento.nro_tipo_evento <> nro_tipo_evento_aviso.
          r_entrega = evento.entrega.
          tnorealizado:HIDDEN = FALSE.
          tnorealizado = FALSE.
          DISPLAY r_entrega WITH FRAME {&FRAME-NAME}.
      END.
      ELSE do:
            r_entrega:HIDDEN = true.
      END.
      IF evento.nro_tipo_evento = nro_tipo_evento_tanque THEN DO:
         IF evento.sub_evento = 1 THEN DO:
             tlibro:HIDDEN = FALSE.
             IF evento.trae_libro = ? THEN tlibro = "*".
             ELSE tlibro = if evento.trae_libro THEN "Si" ELSE "No". 
         END.
         cestado:HIDDEN = FALSE.
         cestado = evento.entrega.
         DISPLAY cestado tlibro WITH FRAME {&FRAME-NAME}.
      END.
      ELSE DO:
         tlibro:HIDDEN = TRUE.
         cestado:HIDDEN = TRUE.
      END.
         
      RUN loadAdvTexto ( evento.observacion ,BROWSE BROWSE-7:HANDLE,OUTPUT TABLE tttexto,OUTPUT v-texto).
      DISPLAY v-texto leyenda_contrato WITH FRAME {&FRAME-NAME}.
      FIND cliente OF evento NO-LOCK NO-ERROR.
      FIND administracion WHERE cliente.nro_admin = administracion.nro_cliente NO-LOCK NO-ERROR.
      IF AVAILABLE administracion THEN DO:
          DISPLAY administracion.nom_cliente  + " - " + administracion.direccion @ vadm WITH FRAME {&FRAME-NAME}.
      END.
  END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE local-enable-fields V-table-Win 
PROCEDURE local-enable-fields :
/*------------------------------------------------------------------------------
  Purpose:     Override standard ADM method
  Notes:       
------------------------------------------------------------------------------*/
DEFINE VAR hproc AS HANDLE NO-UNDO.
DEF VAR hcproc AS CHAR NO-UNDO.
 
  /* Dispatch standard ADM method.                             */
  RUN dispatch IN THIS-PROCEDURE ( INPUT 'enable-fields':U ) .
  DO WITH FRAME {&FRAME-NAME}:
  /* Code placed here will execute PRIOR to standard behavior. */
      IF evento.nro_tipo_evento = nro_tipo_evento_aviso THEN DO:
          r_entrega:HIDDEN IN FRAME {&FRAME-NAME} = false.
          r_entrega:SENSITIVE IN FRAME {&FRAME-NAME} = true.
          r_entrega = evento.entrega.
          DISPLAY r_entrega WITH FRAME {&FRAME-NAME}.
      END.
      ELSE DO:
          tnorealizado:HIDDEN IN FRAME {&FRAME-NAME} = FALSE.
          tnorealizado:sensitive IN FRAME {&FRAME-NAME} = TRUE.
          tnorealizado = FALSE.
          DISPLAY tnorealizado WITH FRAME {&FRAME-NAME}.
      END.

     IF evento.nro_tipo_evento = nro_tipo_evento_tanque THEN DO:
       IF evento.sub_evento = 1 THEN DO:
          tlibro = "*".
          tlibro:HIDDEN IN FRAME {&FRAME-NAME} = FALSE.
          tlibro:sensitive IN FRAME {&FRAME-NAME} = TRUE.
       END.
          cestado:HIDDEN IN FRAME {&FRAME-NAME} = false.
          cestado:SENSITIVE IN FRAME {&FRAME-NAME} = true.
          cestado = evento.entrega.
     END.
      Brecursos:SENSITIVE IN FRAME {&FRAME-NAME} = TRUE.
      treclamo:CHECKED=FALSE.
      treclamo:SENSITIVE = TRUE.
      evento.leyenda:SENSITIVE = TRUE.
      v-texto:SENSITIVE = TRUE.
      eleyenda:SENSITIVE = TRUE.
      IF evento.frealizado:INPUT-VALUE = ? THEN DO:
            RUN get-link-handle IN adm-broker-hdl
             ( INPUT THIS-PROCEDURE,
               INPUT "record-source",
               OUTPUT hcproc ).
               hproc = WIDGET-HANDLE( hcproc ).
               IF VALID-HANDLE(hProc) THEN
            evento.frealizado:SCREEN-VALUE = string(DYNAMIC-FUNCTION("que_fecha" IN hproc)).
      END.
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
FIND tipo_evento WHERE tipo_evento.cdg_tipo_evento = "AV" NO-LOCK.
nro_tipo_evento_aviso = tipo_evento.nro_tipo_evento.
FIND tipo_evento WHERE tipo_evento.cdg_tipo_evento = "LT" NO-LOCK.
nro_tipo_evento_tanque = tipo_evento.nro_tipo_evento.
FIND tipo_evento WHERE tipo_evento.cdg_tipo_evento = "RL" NO-LOCK.
nro_tipo_evento_retiro_libro = tipo_evento.nro_tipo_evento.
RUN inicio_tipo_tarea.
  /* Code placed here will execute PRIOR to standard behavior. */

  /* Dispatch standard ADM method.                             */
  RUN dispatch IN THIS-PROCEDURE ( INPUT 'initialize':U ) .

  /* Code placed here will execute AFTER standard behavior.    */

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE openq V-table-Win 
PROCEDURE openq :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

RUN get-link-handle IN adm-broker-hdl
            ( INPUT THIS-PROCEDURE,
              INPUT "record-source",
              OUTPUT hcp ).
     hp = WIDGET-HANDLE(hcp).
     IF VALID-HANDLE( hp) THEN DYNAMIC-FUNCTION("openq" IN hp ).
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE send-key V-table-Win  adm/support/_key-snd.p
PROCEDURE send-key :
/*------------------------------------------------------------------------------
  Purpose:     Sends a requested KEY value back to the calling
               SmartObject.
  Parameters:  <see adm/template/sndkytop.i>
------------------------------------------------------------------------------*/

  /* Define variables needed by this internal procedure.             */
  {src/adm/template/sndkytop.i}

  /* Return the key value associated with each key case.             */
  {src/adm/template/sndkycas.i "nro_evento" "Evento" "nro_evento"}

  /* Close the CASE statement and end the procedure.                 */
  {src/adm/template/sndkyend.i}

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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE sendemail V-table-Win 
PROCEDURE sendemail :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEFINE INPUT PARAMETER pnro AS INT NO-UNDO.
DEFINE INPUT PARAMETER adtest AS CHAR.

/*    CREATE BATCH.
    ASSIGN prgm = "s-emailcf.p"
           batch.fecha = NOW
           batch.parametro[1] = STRING(pnro)
           batch.parametro[2] = adtest.
    RELEASE BATCH. */
    
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE set-sensitivo V-table-Win 
PROCEDURE set-sensitivo :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEFINE INPUT PARAMETER p-estado AS LOGICAL.

  IF p-estado THEN ENABLE  ALL WITH FRAME {&FRAME-NAME}.
              ELSE DISABLE ALL WITH FRAME {&FRAME-NAME}.

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

/* ************************  Function Implementations ***************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION formulario V-table-Win 
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

