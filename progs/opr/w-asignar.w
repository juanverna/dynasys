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

DEFINE output parameter recursos AS CHAR NO-UNDO.
DEFINE output parameter fecha AS DATE NO-UNDO.
DEFINE output parameter hora_desde AS CHAR NO-UNDO.
DEFINE output parameter hora_hasta AS CHAR NO-UNDO.
DEFINE INPUT parameter tipo AS INT NO-UNDO INITIAL 10.
DEFINE INPUT PARAMETER REV AS ROWID NO-UNDO.

/* Local Variable Definitions ---                                       */
{tiempo.i}
DEFINE VAR h_agenda_recurso AS HANDLE NO-UNDO.
DEF VAR h_vecinos AS HANDLE NO-UNDO.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE SmartWindow
&Scoped-define DB-AWARE no

&Scoped-define ADM-CONTAINER WINDOW

/* Name of first Frame and/or Browse and/or first Query                 */
&Scoped-define FRAME-NAME F-Main

/* Internal Tables (found by Frame, Query & Browse Queries)             */
&Scoped-define INTERNAL-TABLES Evento

/* Definitions for FRAME F-Main                                         */
&Scoped-define QUERY-STRING-F-Main FOR EACH Evento SHARE-LOCK
&Scoped-define OPEN-QUERY-F-Main OPEN QUERY F-Main FOR EACH Evento SHARE-LOCK.
&Scoped-define TABLES-IN-QUERY-F-Main Evento
&Scoped-define FIRST-TABLE-IN-QUERY-F-Main Evento


/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS Basigna v-Recursos BRECURSOS Bagenda_recurso ~
Bvecino v-FAsignado Bcancel v-hora_desde v-hora_hasta v-durac 
&Scoped-Define DISPLAYED-OBJECTS v-Recursos v-FAsignado v-hora_desde ~
v-hora_hasta v-durac 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME


/* ************************  Function Prototypes ********************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION-FORWARD cerrar W-Win 
FUNCTION cerrar RETURNS LOGICAL
  ( hh AS WIDGET-HANDLE )  FORWARD.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION-FORWARD felegido W-Win 
FUNCTION felegido RETURNS LOGICAL
  ( nelegido AS INT )  FORWARD.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


/* ***********************  Control Definitions  ********************** */

/* Define the widget handle for the window                              */
DEFINE VAR W-Win AS WIDGET-HANDLE NO-UNDO.

/* Definitions of the field level widgets                               */
DEFINE BUTTON Bagenda_recurso 
     LABEL "Agenda" 
     SIZE 10 BY 1.

DEFINE BUTTON Basigna 
     LABEL "Asignar" 
     SIZE 15 BY 1.14.

DEFINE BUTTON Bcancel 
     LABEL "Cancelar" 
     SIZE 15 BY 1.19.

DEFINE BUTTON BRECURSOS 
     LABEL "Recursos" 
     SIZE 10 BY 1.

DEFINE BUTTON Bvecino 
     LABEL "Vecinos" 
     SIZE 10 BY 1.

DEFINE VARIABLE v-durac AS CHARACTER FORMAT "X(256)":U 
     LABEL "Duracion" 
     VIEW-AS FILL-IN 
     SIZE 14 BY 1 NO-UNDO.

DEFINE VARIABLE v-FAsignado AS DATE FORMAT "99/99/9999" 
     LABEL "Asignado" 
     VIEW-AS FILL-IN 
     SIZE 16 BY 1.

DEFINE VARIABLE v-hora_desde AS CHARACTER FORMAT "x(5)" 
     LABEL "Hora" 
     VIEW-AS FILL-IN 
     SIZE 11.6 BY 1 TOOLTIP "Hora inicio de tareas HHMM".

DEFINE VARIABLE v-hora_hasta AS CHARACTER FORMAT "x(5)" 
     VIEW-AS FILL-IN 
     SIZE 11.6 BY 1 TOOLTIP "Hora fin de tareas formato HHMM".

DEFINE VARIABLE v-Recursos AS CHARACTER FORMAT "X(20)" 
     LABEL "Recursos" 
     VIEW-AS FILL-IN 
     SIZE 23.4 BY 1 TOOLTIP "Recursos asignados para realizar el evento".

/* Query definitions                                                    */
&ANALYZE-SUSPEND
DEFINE QUERY F-Main FOR 
      Evento SCROLLING.
&ANALYZE-RESUME

/* ************************  Frame Definitions  *********************** */

DEFINE FRAME F-Main
     Basigna AT ROW 1.48 COL 65 WIDGET-ID 80
     v-Recursos AT ROW 1.57 COL 10 COLON-ALIGNED WIDGET-ID 26
     BRECURSOS AT ROW 1.62 COL 36.6 WIDGET-ID 36
     Bagenda_recurso AT ROW 1.62 COL 47.2 WIDGET-ID 38
     Bvecino AT ROW 2.86 COL 36 WIDGET-ID 124
     v-FAsignado AT ROW 2.91 COL 10 COLON-ALIGNED WIDGET-ID 78
     Bcancel AT ROW 2.91 COL 65 WIDGET-ID 84
     v-hora_desde AT ROW 4.1 COL 10 COLON-ALIGNED WIDGET-ID 52
     v-hora_hasta AT ROW 4.1 COL 21.6 COLON-ALIGNED NO-LABEL WIDGET-ID 54
     v-durac AT ROW 4.1 COL 45 COLON-ALIGNED WIDGET-ID 82
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 80 BY 4.81 WIDGET-ID 100.


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
         TITLE              = "Datos Asignacion Eventos"
         HEIGHT             = 4.71
         WIDTH              = 80
         MAX-HEIGHT         = 17
         MAX-WIDTH          = 80
         VIRTUAL-HEIGHT     = 17
         VIRTUAL-WIDTH      = 80
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
                                                                        */
ASSIGN 
       v-durac:READ-ONLY IN FRAME F-Main        = TRUE.

IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(W-Win)
THEN W-Win:HIDDEN = yes.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME


/* Setting information for Queries and Browse Widgets fields            */

&ANALYZE-SUSPEND _QUERY-BLOCK FRAME F-Main
/* Query rebuild information for FRAME F-Main
     _TblList          = "sic.Evento"
     _Query            is OPENED
*/  /* FRAME F-Main */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME W-Win
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL W-Win W-Win
ON END-ERROR OF W-Win /* Datos Asignacion Eventos */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL W-Win W-Win
ON WINDOW-CLOSE OF W-Win /* Datos Asignacion Eventos */
DO:
    /* Modificado para que el control retorne a la window padre al cerrar una windows hija */
    DEFINE VARIABLE h_parent AS HANDLE      NO-UNDO.
    h_parent = THIS-PROCEDURE:CURRENT-WINDOW:PARENT.
    IF VALID-HANDLE(h_parent) THEN DO:
        CURRENT-WINDOW = h_parent.
        APPLY 'ENTRY' TO h_parent.
    END.
    cerrar(h_agenda_recurso).
    APPLY "CLOSE":U TO THIS-PROCEDURE.
    RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME Bagenda_recurso
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Bagenda_recurso W-Win
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


&Scoped-define SELF-NAME Basigna
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Basigna W-Win
ON CHOOSE OF Basigna IN FRAME F-Main /* Asignar */
DO:
DEFINE VAR k AS INT NO-UNDO.
DEFINE VAR i AS INT no-undo.
IF NUM-ENTRIES(v-recursos:SCREEN-VALUE) < 1 THEN DO:
            MESSAGE "Debe indicar al menos un recurso"
                VIEW-AS ALERT-BOX ERROR.
            RETURN NO-APPLY.
END.
DO k = 1 TO NUM-ENTRIES(v-recursos:SCREEN-VALUE):
        FIND recurso WHERE recurso.cdg_recurso = ENTRY(k,v-recursos:SCREEN-VALUE) NO-LOCK NO-ERROR.
        IF NOT AVAILABLE recurso THEN DO:
            MESSAGE "El recurso " ENTRY(k,v-recursos:SCREEN-VALUE) SKIP
                "No es valido, verifique" VIEW-AS ALERT-BOX ERROR.
            RETURN NO-APPLY.
        END.
    END.
IF v-fasignado:INPUT-VALUE < TODAY THEN DO:
           MESSAGE "No puede asignar una fecha anterior a HOY" VIEW-AS ALERT-BOX ERROR.
            RETURN NO-APPLY.
END.
IF aINT(v-hora_hasta:SCREEN-VALUE) <> 0 AND 
      aINT(v-hora_desde:SCREEN-VALUE) <> 0 THEN DO:
      i = INT(TRUNCATE( ( ahdec(aint(v-hora_hasta:INPUT-VALUE) ) - ahdec( aint(v-hora_desde:INPUT-VALUE) ) ) * 60 , 0 )).
      IF i < 0 THEN DO:
          MESSAGE "Mal la hora".
          RETURN NO-APPLY.
      END.
      

  END.
/*todo bien*/
  recursos = v-recursos:INPUT-VALUE.
  fecha = v-fasignado:INPUT-VALUE.
  hora_desde = v-hora_desde:INPUT-VALUE.
  hora_hasta = v-hora_hasta:INPUT-VALUE.
  cerrar(h_vecinos).
  APPLY "CLOSE" TO THIS-PROCEDURE.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME Bcancel
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Bcancel W-Win
ON CHOOSE OF Bcancel IN FRAME F-Main /* Cancelar */
DO:
  recursos = "".
  APPLY "CLOSE" TO THIS-PROCEDURE.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME BRECURSOS
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL BRECURSOS W-Win
ON CHOOSE OF BRECURSOS IN FRAME F-Main /* Recursos */
DO:
  DEF VAR lista AS CHAR.
  lista = v-recursos:SCREEN-VALUE IN FRAME {&FRAME-NAME}.
  RUN d-recursos.w (INPUT-OUTPUT lista,STRING(tipo)).
  v-recursos:SCREEN-VALUE = lista.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME Bvecino
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Bvecino W-Win
ON CHOOSE OF Bvecino IN FRAME F-Main /* Vecinos */
DO:
DEFINE VAR pnro_cliente LIKE cliente.nro_cliente.
DEFINE VAR hproc AS HANDLE.
DEFINE VAR hcproc AS CHARACTER.
FIND evento WHERE rowid(evento) = rev NO-LOCK.
FIND cliente OF evento NO-LOCK NO-ERROR.
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
        RUN w-vecinosCO.w PERSISTENT SET h_vecinos ( evento.nro_evento,"E",5000,THIS-PROCEDURE).
ELSE
        RUN w-vecinosEV.w PERSISTENT  SET h_vecinos ( evento.nro_tipo_evento ,
                       evento.fmin,
                       evento.fmax,
                       evento.nro_evento,
                       3000,
                       cliente.geolat,
                       cliente.geolong,
                       Cliente.nom_cliente + '<BR>Dir:' + cliente.direccion,
                       cliente.cdg_cliente,
                       cliente.direccion,
                       THIS-PROCEDURE ,
                       evento.duracion).

RUN dispatch IN h_vecinos ( INPUT 'initialize':U ) .
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME v-FAsignado
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-FAsignado W-Win
ON MOUSE-MENU-DOWN OF v-FAsignado IN FRAME F-Main /* Asignado */
DO:
   {selfecha.i}
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-FAsignado W-Win
ON MOUSE-SELECT-DBLCLICK OF v-FAsignado IN FRAME F-Main /* Asignado */
DO:
DEFINE VAR pnro_cliente LIKE cliente.nro_cliente.
DEFINE VAR hproc AS HANDLE.
DEFINE VAR hcproc AS CHARACTER.
        
RUN get-link-handle IN adm-broker-hdl
        ( INPUT THIS-PROCEDURE,
          INPUT "record-source",
          OUTPUT hcproc ).
          hproc = WIDGET-HANDLE( hcproc ).
/*IF evento.nro_cliente = 0 THEN
    pnro_cliente = IF VALID-HANDLE(hProc) THEN dynamic-function('que_cliente' IN hproc ) ELSE ?.    
ELSE  */
    pnro_cliente = evento.nro_cliente.
FIND cliente WHERE cliente.nro_cliente = pnro_cliente NO-LOCK NO-ERROR.
IF NOT AVAILABLE cliente THEN DO:
    MESSAGE "Cliente No registrado" VIEW-AS ALERT-BOX ERROR.
    RETURN NO-APPLY.
END.
IF cliente.geolat = 0 THEN DO:
    MESSAGE "Cliente No georeferenciado" VIEW-AS ALERT-BOX ERROR.
    RETURN NO-APPLY.
END.

cerrar(h_vecinos).
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME v-hora_desde
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-hora_desde W-Win
ON LEAVE OF v-hora_desde IN FRAME F-Main /* Hora */
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
    DISPLAY INT(TRUNCATE( ( ahdec(aint(v-hora_hasta:INPUT-VALUE) ) - ahdec( aint(v-hora_desde:INPUT-VALUE) ) ) * 60 , 0 )) @ v-durac.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME v-hora_hasta
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-hora_hasta W-Win
ON LEAVE OF v-hora_hasta IN FRAME F-Main
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
    DISPLAY INT(TRUNCATE( ( ahdec(aint(v-hora_hasta:INPUT-VALUE) ) - ahdec( aint(v-hora_desde:INPUT-VALUE) ) ) * 60 , 0 )) @ v-durac.
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
  DISPLAY v-Recursos v-FAsignado v-hora_desde v-hora_hasta v-durac 
      WITH FRAME F-Main IN WINDOW W-Win.
  ENABLE Basigna v-Recursos BRECURSOS Bagenda_recurso Bvecino v-FAsignado 
         Bcancel v-hora_desde v-hora_hasta v-durac 
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

  /* Code placed here will execute PRIOR to standard behavior. */

  /* Dispatch standard ADM method.                             */
  RUN dispatch IN THIS-PROCEDURE ( INPUT 'initialize':U ) .
  v-FAsignado = TODAY.
DISPLAY v-FAsignado WITH FRAME {&FRAME-NAME}.
  /* Code placed here will execute AFTER standard behavior.    */

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
  {src/adm/template/snd-list.i "Evento"}

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

/* ************************  Function Implementations ***************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION cerrar W-Win 
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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION felegido W-Win 
FUNCTION felegido RETURNS LOGICAL
  ( nelegido AS INT ) :
/*------------------------------------------------------------------------------
  Purpose:  
    Notes:  
------------------------------------------------------------------------------*/
DEFINE BUFFER bevento FOR evento.
FIND bevento WHERE bevento.nro_evento = nelegido NO-LOCK.
IF AVAILABLE bevento THEN DO:
    v-recursos:SCREEN-VALUE IN FRAME {&FRAME-NAME} = ENTRY(1,bevento.recursos).
    v-fasignado:SCREEN-VALUE = string(bevento.fasignado).
END.
  RETURN FALSE.   /* Function return value. */

END FUNCTION.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

