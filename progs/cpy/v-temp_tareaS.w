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
{advtexto.i}
{findempresa.i}
{tiempo.i}

DEFINE VARIABLE pleyenda LIKE tarea.leyenda NO-UNDO.
DEFINE VAR acciones AS CHAR INITIAL "Inicial,0,Visitar,1,Cotizar,2".

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
&Scoped-define EXTERNAL-TABLES Tarea
&Scoped-define FIRST-EXTERNAL-TABLE Tarea


/* Need to scope the external tables to this procedure                  */
DEFINE QUERY external_tables FOR Tarea.
/* Definitions for FRAME F-Main                                         */

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-FIELDS Tarea.fecha_prevista Tarea.hora_prevista ~
Tarea.horas_estimadas 
&Scoped-define ENABLED-TABLES Tarea
&Scoped-define FIRST-ENABLED-TABLE Tarea
&Scoped-Define ENABLED-OBJECTS BUTTON-12 evsigue BROWSE-7 
&Scoped-Define DISPLAYED-FIELDS Tarea.fecha_prevista Tarea.hora_prevista ~
Tarea.horas_estimadas 
&Scoped-define DISPLAYED-TABLES Tarea
&Scoped-define FIRST-DISPLAYED-TABLE Tarea
&Scoped-Define DISPLAYED-OBJECTS evsigue frecursos hora_fin turno avisar ~
v-texto 

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


/* ***********************  Control Definitions  ********************** */


/* Definitions of the field level widgets                               */
DEFINE BUTTON b-agrega 
     IMAGE-UP FILE "img/add.gif":U
     LABEL "Agrega" 
     SIZE 5 BY 5.71.

DEFINE BUTTON Bfin 
     LABEL "C" 
     SIZE 4 BY 1 TOOLTIP "Nuestra datos de destino de la tarea finalizada".

DEFINE BUTTON BLeyenda 
     LABEL "Leyenda" 
     SIZE 21 BY 1.14.

DEFINE BUTTON BRECURSOS 
     LABEL "Sel" 
     SIZE 4 BY 1.

DEFINE BUTTON Bresuelto 
     LABEL "Resuelto" 
     SIZE 21 BY 1.14.

DEFINE BUTTON BUTTON-12 
     IMAGE-UP FILE "iconos24/zoom_in.jpg":U
     IMAGE-DOWN FILE "iconos24i/zoom_in.jpg":U
     LABEL "Button 12" 
     SIZE 6 BY 1.14.

DEFINE VARIABLE v-texto AS CHARACTER 
     VIEW-AS EDITOR SCROLLBAR-VERTICAL
     SIZE 59 BY 5.71
     BGCOLOR 15 FGCOLOR 9 .

DEFINE VARIABLE evsigue AS INTEGER FORMAT ">>>>>>>9" INITIAL 0 
     LABEL "Evento" 
     VIEW-AS FILL-IN 
     SIZE 16 BY 1 TOOLTIP "Evento para ser seguido en la supervicion".

DEFINE VARIABLE frecursos AS CHARACTER FORMAT "X(8)" 
     LABEL "Recur" 
     VIEW-AS FILL-IN 
     SIZE 16 BY 1 TOOLTIP "Recursos asignados para realizar el evento".

DEFINE VARIABLE hora_fin AS CHARACTER FORMAT "X(5)":U 
     LABEL "Fin" 
     VIEW-AS FILL-IN 
     SIZE 14 BY 1 TOOLTIP "Hora prevista para la finalizacion" NO-UNDO.

DEFINE VARIABLE turno AS CHARACTER FORMAT "X(256)":U 
     LABEL "Turno" 
     VIEW-AS FILL-IN 
     SIZE 7 BY 1 NO-UNDO.

DEFINE VARIABLE avisar AS LOGICAL INITIAL no 
     LABEL "Avisar" 
     VIEW-AS TOGGLE-BOX
     SIZE 10 BY .81 TOOLTIP "Si se genera o no un aviso para este evento" NO-UNDO.


/* Browse definitions                                                   */
DEFINE BROWSE BROWSE-7
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS BROWSE-7 V-table-Win _STRUCTURED
  
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ROW-MARKERS SEPARATORS SIZE 82 BY 5.71 ROW-HEIGHT-CHARS .68.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME F-Main
     Bfin AT ROW 1.1 COL 124 WIDGET-ID 82
     BUTTON-12 AT ROW 1.14 COL 40 WIDGET-ID 28
     Tarea.fecha_prevista AT ROW 1.14 COL 105 COLON-ALIGNED WIDGET-ID 22
          LABEL "Fecha"
          VIEW-AS FILL-IN 
          SIZE 16 BY 1 TOOLTIP "Fecha Previsto"
     evsigue AT ROW 1.24 COL 21 COLON-ALIGNED WIDGET-ID 118
     Tarea.hora_prevista AT ROW 1.24 COL 135 COLON-ALIGNED WIDGET-ID 26
          LABEL "Inicio" FORMAT "X(5)"
          VIEW-AS FILL-IN 
          SIZE 13.6 BY 1 TOOLTIP "Hora Previstade comienzo de la tarea"
     frecursos AT ROW 2.19 COL 105 COLON-ALIGNED WIDGET-ID 66
     BRECURSOS AT ROW 2.19 COL 124.2 WIDGET-ID 36
     hora_fin AT ROW 2.43 COL 135 COLON-ALIGNED WIDGET-ID 68
     Bresuelto AT ROW 2.67 COL 23 WIDGET-ID 84
     BLeyenda AT ROW 2.67 COL 47 WIDGET-ID 94
     turno AT ROW 3.48 COL 104.8 COLON-ALIGNED WIDGET-ID 126
     avisar AT ROW 3.62 COL 117 WIDGET-ID 128
     BROWSE-7 AT ROW 5.29 COL 3 WIDGET-ID 200
     v-texto AT ROW 5.29 COL 86 NO-LABEL WIDGET-ID 50
     b-agrega AT ROW 5.29 COL 146 WIDGET-ID 52
     Tarea.horas_estimadas AT ROW 3.71 COL 139.8 COLON-ALIGNED WIDGET-ID 24
          LABEL "Durac." FORMAT ">>9"
           VIEW-AS TEXT 
          SIZE 9 BY .62
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1 SCROLLABLE  WIDGET-ID 100.


/* *********************** Procedure Settings ************************ */

&ANALYZE-SUSPEND _PROCEDURE-SETTINGS
/* Settings for THIS-PROCEDURE
   Type: SmartViewer
   External Tables: sic.Tarea
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
         HEIGHT             = 10.14
         WIDTH              = 150.8.
/* END WINDOW DEFINITION */
                                                                        */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _INCLUDED-LIB V-table-Win 
/* ************************* Included-Libraries *********************** */

{src/adm/method/viewer.i}

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME




/* ***********  Runtime Attributes and AppBuilder Settings  *********** */

&ANALYZE-SUSPEND _RUN-TIME-ATTRIBUTES
/* SETTINGS FOR WINDOW V-table-Win
  VISIBLE,,RUN-PERSISTENT                                               */
/* SETTINGS FOR FRAME F-Main
   NOT-VISIBLE FRAME-NAME Size-to-Fit                                   */
/* BROWSE-TAB BROWSE-7 avisar F-Main */
ASSIGN 
       FRAME F-Main:SCROLLABLE       = FALSE
       FRAME F-Main:HIDDEN           = TRUE.

/* SETTINGS FOR TOGGLE-BOX avisar IN FRAME F-Main
   NO-ENABLE                                                            */
/* SETTINGS FOR BUTTON b-agrega IN FRAME F-Main
   NO-ENABLE                                                            */
/* SETTINGS FOR BUTTON Bfin IN FRAME F-Main
   NO-ENABLE                                                            */
/* SETTINGS FOR BUTTON BLeyenda IN FRAME F-Main
   NO-ENABLE                                                            */
/* SETTINGS FOR BUTTON BRECURSOS IN FRAME F-Main
   NO-ENABLE                                                            */
/* SETTINGS FOR BUTTON Bresuelto IN FRAME F-Main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN Tarea.fecha_prevista IN FRAME F-Main
   EXP-LABEL                                                            */
/* SETTINGS FOR FILL-IN frecursos IN FRAME F-Main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN Tarea.horas_estimadas IN FRAME F-Main
   EXP-LABEL EXP-FORMAT                                                 */
ASSIGN 
       Tarea.horas_estimadas:READ-ONLY IN FRAME F-Main        = TRUE.

/* SETTINGS FOR FILL-IN hora_fin IN FRAME F-Main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN Tarea.hora_prevista IN FRAME F-Main
   EXP-LABEL EXP-FORMAT                                                 */
/* SETTINGS FOR FILL-IN turno IN FRAME F-Main
   NO-ENABLE                                                            */
/* SETTINGS FOR EDITOR v-texto IN FRAME F-Main
   NO-ENABLE                                                            */
ASSIGN 
       v-texto:RETURN-INSERTED IN FRAME F-Main  = TRUE
       v-texto:READ-ONLY IN FRAME F-Main        = TRUE.

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

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME b-agrega
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL b-agrega V-table-Win
ON CHOOSE OF b-agrega IN FRAME F-Main /* Agrega */
DO:
  v-texto = "".
  v-texto:READ-ONLY = FALSE.
  b-agrega:SENSITIVE = FALSE.
  DISPLAY v-texto WITH FRAME {&FRAME-NAME}.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME Bfin
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Bfin V-table-Win
ON CHOOSE OF Bfin IN FRAME F-Main /* C */
DO:
  IF tarea.destino BEGINS "REMIT" THEN
      FIND rem_header WHERE rem_header.nro_remito =  tarea.nro_destino NO-LOCK.
      FIND evento WHERE evento.origen = tarea.destino and
                        evento.nro_identificacion = tarea.nro_destino NO-LOCK.
  MESSAGE "Destino:" tarea.destino SKIP
          "Identificacion:" rem_header.nro_comprob SKIP
          "Canal vta:" rem_header.prf_comprob skip
          "Evento:" evento.nro_evento 
      VIEW-AS alert-box INFORMATION.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME BLeyenda
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL BLeyenda V-table-Win
ON CHOOSE OF BLeyenda IN FRAME F-Main /* Leyenda */
DO:
   DEFINE VARIABLE puso_ok AS LOGICAL.
   IF pleyenda="" THEN
            pleyenda = tarea.leyenda.
   RUN c-edttexto.w ( INPUT-OUTPUT pleyenda,
                      INPUT "Leyenda",
                      INPUT 0, /* en RW siempre */
                      OUTPUT puso_ok).
   RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME BRECURSOS
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL BRECURSOS V-table-Win
ON CHOOSE OF BRECURSOS IN FRAME F-Main /* Sel */
DO:
  DEF VAR lista AS CHAR.
  lista = frecursos:SCREEN-VALUE IN FRAME {&FRAME-NAME}.
  RUN d-recursos.w (INPUT-OUTPUT lista, string(12) ). /*fijo porque es para supervicion*/
  frecursos:SCREEN-VALUE = lista.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME Bresuelto
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Bresuelto V-table-Win
ON CHOOSE OF Bresuelto IN FRAME F-Main /* Resuelto */
DO:
  RUN d-tarearesol.w (INPUT tarea.nro_tarea).
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


&Scoped-define SELF-NAME BUTTON-12
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL BUTTON-12 V-table-Win
ON CHOOSE OF BUTTON-12 IN FRAME F-Main /* Button 12 */
DO:
  RUN d-zoom-evento.w(tarea.nro_evento,"ZOOM").
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME evsigue
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL evsigue V-table-Win
ON LEAVE OF evsigue IN FRAME F-Main /* Evento */
DO:
  IF evsigue:input-value <> 0 THEN DO:
      FIND evento WHERE evento.nro_evento = evsigue:input-value NO-LOCK NO-ERROR.
      IF AVAILABLE evento THEN DO:
            tarea.fecha_prevista:SCREEN-VALUE = STRING(evento.fasignado).
            turno:SCREEN-VALUE = evento.turno.
      END.
  END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME Tarea.fecha_prevista
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Tarea.fecha_prevista V-table-Win
ON MOUSE-MENU-DOWN OF Tarea.fecha_prevista IN FRAME F-Main /* Fecha */
DO:
    {selfecha.i}
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME Tarea.horas_estimadas
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Tarea.horas_estimadas V-table-Win
ON LEAVE OF Tarea.horas_estimadas IN FRAME F-Main /* Durac. */
DO:
   IF aint(tarea.horas_estimadas:SCREEN-VALUE) <> 0 AND aint(tarea.hora_prevista:screen-value) <> 0 THEN DO:
        hora_fin:SCREEN-VALUE= ajuh(string(addmil(aint(tarea.hora_prevista:SCREEN-VALUE),int(tarea.horas_estimadas:SCREEN-VALUE)))).
   END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME hora_fin
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL hora_fin V-table-Win
ON LEAVE OF hora_fin IN FRAME F-Main /* Fin */
DO:
   DEFINE VAR i AS INT NO-UNDO.
   SELF:SCREEN-VALUE= ajuh(SELF:SCREEN-VALUE).
  IF aINT(hora_fin:SCREEN-VALUE) <> 0 AND 
      aINT(hora_prevista:SCREEN-VALUE) <> 0 THEN DO:
      i = INT(TRUNCATE( ( ahdec(aint(hora_fin:INPUT-VALUE) ) - ahdec( aint(hora_prevista:INPUT-VALUE) ) ) * 60 , 0 )).
      IF i < 0 THEN DO:
          MESSAGE "Mal la hora".
          RETURN NO-APPLY.
      END.
      tarea.horas_estimadas:SCREEN-VALUE = string(i).

  END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME Tarea.hora_prevista
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Tarea.hora_prevista V-table-Win
ON LEAVE OF Tarea.hora_prevista IN FRAME F-Main /* Inicio */
DO:
   DEFINE VAR i AS INT NO-UNDO.
   SELF:SCREEN-VALUE= ajuh(SELF:SCREEN-VALUE).
   IF int(tarea.horas_estimadas:SCREEN-VALUE) <> 0 AND aint(tarea.hora_prevista:screen-value) <> 0 THEN DO:
        hora_fin:SCREEN-VALUE= ajuh(string(addmil(aint(tarea.hora_prevista:SCREEN-VALUE),int(tarea.horas_estimadas:SCREEN-VALUE)))).
    END.
   IF aINT(hora_fin:SCREEN-VALUE) <> 0 AND 
      aINT(hora_prevista:SCREEN-VALUE) <> 0 THEN DO:
      i = INT(TRUNCATE( ( ahdec(aint(hora_fin:INPUT-VALUE) ) - ahdec( aint(hora_prevista:INPUT-VALUE) ) ) * 60 , 0 )).
      IF i < 0 THEN DO:
          MESSAGE "Mal la hora".
          RETURN NO-APPLY.
      END.
      tarea.horas_estimadas:SCREEN-VALUE = string(i).

  END.
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
  {src/adm/template/row-list.i "Tarea"}

  /* Get the record ROWID's from the RECORD-SOURCE.                  */
  {src/adm/template/row-get.i}

  /* FIND each record specified by the RECORD-SOURCE.                */
  {src/adm/template/row-find.i "Tarea"}

  /* Process the newly available records (i.e. display fields,
     open queries, and/or pass records on to any RECORD-TARGETS).    */
  {src/adm/template/row-end.i}

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE borraind V-table-Win 
PROCEDURE borraind :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEFINE INPUT PARAMETER h AS WIDGET-HANDLE NO-UNDO.
    h:LIST-ITEM-PAIRS="NADA,0".
    h:SCREEN-VALUE = "0".
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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE local-add-record V-table-Win 
PROCEDURE local-add-record :
/*------------------------------------------------------------------------------
  Purpose:     Override standard ADM method
  Notes:       
------------------------------------------------------------------------------*/
    RUN loadAdvTexto ( "" ,BROWSE BROWSE-7:HANDLE,OUTPUT TABLE tttexto,OUTPUT v-texto).
  DISPLAY v-texto WITH FRAME {&FRAME-NAME}.

  /* Code placed here will execute PRIOR to standard behavior. */

  /* Dispatch standard ADM method.                             */
  RUN dispatch IN THIS-PROCEDURE ( INPUT 'add-record':U ) .

  /* Code placed here will execute AFTER standard behavior.    */
  tarea.horas_estimadas:SCREEN-VALUE IN FRAME {&FRAME-NAME}= "90".
  tarea.fecha_prevista:SCREEN-VALUE = STRING(TODAY).
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE local-assign-statement V-table-Win 
PROCEDURE local-assign-statement :
/*------------------------------------------------------------------------------
  Purpose:     Override standard ADM method
  Notes:       
------------------------------------------------------------------------------*/
DEFINE VAR k AS INT NO-UNDO.
DEFINE VARIABLE hWidget AS HANDLE     NO-UNDO.
DEFINE VARIABLE hField  AS HANDLE     NO-UNDO.
DEFINE VAR phframe AS HANDLE NO-UNDO.
DEFINE VAR sal AS CHAR NO-UNDO.
DEFINE VAR vartemplate AS CHAR NO-UNDO.
DEFINE VAR resu AS CHAR NO-UNDO.
DEFINE VAR recno AS LOGICAL NO-UNDO.
DEFINE VAR caccion AS LOGICAL NO-UNDO.

RUN dispatch IN THIS-PROCEDURE ( INPUT 'assign-statement':U ) .

tarea.nro_tipo_evento = 12.

IF Tarea.hora_prevista:INPUT-VALUE IN FRAME {&FRAME-NAME} = 0 THEN DO:
    MESSAGE "indique duracion de la tarea" VIEW-AS ALERT-BOX ERROR.
    RETURN error.
END.

recno = TRUE.
DO k = 1 TO num-entries(frecursos):
  FIND recurso WHERE recurso.cdg_recurso = ENTRY(k,frecursos) NO-LOCK NO-ERROR.
  IF NOT AVAILABLE recurso THEN do:
      recno = false.
      LEAVE.
  END.
  FIND FIRST recurso_habilidad OF Recurso 
       WHERE can-do("12",string( recurso_habilidad.nro_tipo_evento)) NO-LOCK NO-ERROR.
  IF NOT AVAILABLE recurso_habilidad THEN do:
      recno = false.
      LEAVE.
  END.
END.
IF NOT recno THEN DO:
    MESSAGE "Alguno de los recursos, tiene la habilidad necesaria para efectuar la tarea" 
    VIEW-AS ALERT-BOX ERROR.
    RETURN ERROR.
END.

phframe = FRAME {&FRAME-NAME}:HANDLE.
hWidget = phFrame:CURRENT-ITERATION:FIRST-CHILD.
sal = "".

vartemplate = "evsigue|turno|avisar|frecursos|hora_fin".
  DO WHILE VALID-HANDLE(hWidget):
    k = lookup(hWidget:NAME ,vartemplate, "|").
    IF  k > 0 AND CAN-QUERY( hWidget, 'SCREEN-VALUE' ) THEN
    DO:
        IF hWidget:TYPE = 'COMBO-BOX'  THEN 
            resu = hWidget:NAME + "|" + hWidget:SCREEN-VALUE.
        ELSE IF CAN-QUERY( hWidget, 'INPUT-VALUE':U ) THEN
            resu = hWidget:NAME + "|" + hWidget:SCREEN-VALUE.
        ELSE IF CAN-QUERY( hWidget, 'CHECKED':U ) THEN
            resu = hWidget:NAME + "|" +  IF hWidget:CHECKED THEN "yes" ELSE "no".
        ELSE resu = hWidget:NAME + "|" + hWidget:SCREEN-VALUE.
        IF resu <> ? THEN
            sal = sal + "|" + resu.
    END.
    hWidget = hWidget:NEXT-SIBLING.
  END.
  Tarea.datos-template = substring(sal,2).
  tarea.descripcion = saveAdvTexto(v-texto:INPUT-VALUE,TABLE tttexto).
  tarea.leyenda = pleyenda.
  tarea.descripcion = saveAdvTexto2(IF caccion THEN entry(int( tarea.accion ) * 2 + 1 ,acciones ) ELSE "", v-texto:INPUT-VALUE,TABLE tttexto).
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE local-disable-fields V-table-Win 
PROCEDURE local-disable-fields :
/*------------------------------------------------------------------------------
  Purpose:     Override standard ADM method
  Notes:       
------------------------------------------------------------------------------*/
DEFINE VAR k AS INT NO-UNDO.
DEFINE VARIABLE hWidget AS HANDLE     NO-UNDO.
DEFINE VARIABLE hField  AS HANDLE     NO-UNDO.
DEFINE VAR phframe AS HANDLE NO-UNDO.

  RUN dispatch IN THIS-PROCEDURE ( INPUT 'disable-fields':U ) .

phframe = FRAME {&FRAME-NAME}:HANDLE.
hWidget = phFrame:CURRENT-ITERATION:FIRST-CHILD.

  DO WHILE VALID-HANDLE(hWidget):
    IF  CAN-QUERY( hWidget, 'SCREEN-VALUE' ) THEN
        hWidget:SENSITIVE = FALSE.
    hWidget = hWidget:NEXT-SIBLING.
  END.
  v-texto:READ-ONLY = TRUE.
  b-agrega:SENSITIVE = FALSE.
  brecursos:SENSITIVE = FALSE.
  bleyenda:SENSITIVE = FALSE.
  END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE local-display-fields V-table-Win 
PROCEDURE local-display-fields :
/*------------------------------------------------------------------------------
  Purpose:     Override standard ADM method
  Notes:       
------------------------------------------------------------------------------*/
DEFINE VAR k AS INT NO-UNDO.
DEFINE VARIABLE hWidget AS HANDLE     NO-UNDO.
DEFINE VARIABLE hField  AS HANDLE     NO-UNDO.
DEFINE VAR phframe AS HANDLE NO-UNDO.

IF AVAILABLE tarea THEN DO:
    bfin:SENSITIVE IN FRAME {&FRAME-NAME} = NOT tarea.destino = "".
    bresuelto:SENSITIVE = tarea.fecha_resuelto <> ?. 
END.

RUN dispatch IN THIS-PROCEDURE ( INPUT 'display-fields':U ) .

phframe = FRAME {&FRAME-NAME}:HANDLE.
hWidget = phFrame:CURRENT-ITERATION:FIRST-CHILD.
IF AVAILABLE tarea THEN DO: 
    DO WHILE VALID-HANDLE(hWidget):
    k = lookup(hWidget:NAME ,Tarea.datos-template, "|").
    IF  k > 0 AND CAN-QUERY( hWidget, 'SCREEN-VALUE' ) THEN
    DO:
        IF hWidget:TYPE = 'COMBO-BOX'  THEN
          hWidget:SCREEN-VALUE = ENTRY( k + 1 , tarea.datos-template , "|" ).
        ELSE IF CAN-QUERY( hWidget, 'INPUT-VALUE':U ) THEN
          hWidget:SCREEN-VALUE = ENTRY( k + 1  , tarea.datos-template  , "|" ).
        ELSE IF CAN-QUERY( hWidget, 'CHECKED':U ) THEN
          hWidget:CHECKED = LOGICAL(ENTRY( k + 1 , tarea.datos-template , "|" ) ).
        ELSE IF CAN-QUERY( hWidget, 'SCREEN-VALUE' ) THEN
          hWidget:SCREEN-VALUE = ENTRY( k + 1 , tarea.datos-template , "|" ).
    END.
    hWidget = hWidget:NEXT-SIBLING.
  END.
    RUN loadAdvTexto ( tarea.descripcion ,BROWSE BROWSE-7:HANDLE,OUTPUT TABLE tttexto,OUTPUT v-texto).
  DISPLAY v-texto WITH FRAME {&FRAME-NAME}.

  tarea.hora_prevista:SCREEN-VALUE= ajuh(tarea.hora_prevista).
  IF aint(tarea.hora_prevista:screen-value) <> 0 THEN DO:
      hora_fin:SCREEN-VALUE= ajuh(string(addmil(aint(tarea.hora_prevista:SCREEN-VALUE),int(tarea.horas_estimadas)))).
  END.
  bresuelto:SENSITIVE = tarea.fecha_resuelto <> ?. 
  pleyenda = tarea.leyenda.
END.
  ELSE DO:
      RUN loadAdvTexto ("",BROWSE BROWSE-7:HANDLE,OUTPUT TABLE tttexto,OUTPUT v-texto).
      DISPLAY v-texto WITH FRAME {&FRAME-NAME}.
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
DEFINE VAR k AS INT NO-UNDO.
DEFINE VARIABLE hWidget AS HANDLE     NO-UNDO.
DEFINE VARIABLE hField  AS HANDLE     NO-UNDO.
DEFINE VAR phframe AS HANDLE NO-UNDO.

RUN dispatch IN THIS-PROCEDURE ( INPUT 'enable-fields':U ) .

phframe = FRAME {&FRAME-NAME}:HANDLE.
hWidget = phFrame:CURRENT-ITERATION:FIRST-CHILD.

DO WHILE VALID-HANDLE(hWidget):
    IF  CAN-QUERY( hWidget, 'SCREEN-VALUE' ) THEN
        hWidget:SENSITIVE = TRUE.
    hWidget = hWidget:NEXT-SIBLING.
END.
b-agrega:SENSITIVE = TRUE.
brecursos:SENSITIVE = TRUE.

bleyenda:SENSITIVE = TRUE.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE local-initialize V-table-Win 
PROCEDURE local-initialize :
/*------------------------------------------------------------------------------
  Purpose:     Override standard ADM method
  Notes:       
------------------------------------------------------------------------------*/
DEFINE VAR lista AS CHAR NO-UNDO.
lista = "".
FIND tipo_evento WHERE tipo_evento.cdg_tipo_evento = "LT" NO-LOCK NO-ERROR.
IF AVAILABLE tipo_evento THEN lista = lista + "," + tipo_evento.cdg_tipo_evento + "," + string(tipo_evento.nro_tipo_evento).
FIND tipo_evento WHERE tipo_evento.cdg_tipo_evento = "RT" NO-LOCK NO-ERROR.
IF AVAILABLE tipo_evento THEN lista = lista + "," + tipo_evento.cdg_tipo_evento + "," + string(tipo_evento.nro_tipo_evento).

  RUN dispatch IN THIS-PROCEDURE ( INPUT 'initialize':U ) .

  /* Code placed here will execute AFTER standard behavior.    */

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
  {src/adm/template/snd-list.i "Tarea"}

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

