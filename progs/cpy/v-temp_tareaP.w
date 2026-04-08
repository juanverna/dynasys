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
{tiempo.i}
DEFINE VAR h_c AS HANDLE.
DEFINE VAR acciones AS CHAR INITIAL "Inicial,0,Visitar,1,Cotizar,2".
DEFINE VAR npresu AS INT NO-UNDO.
DEFINE VAR acc LIKE tarea.accion.
DEF VAR h_vecinos AS WIDGET-HANDLE NO-UNDO.
DEFINE BUFFER administrador FOR cliente.
    DEFINE BUFFER bdomicilio FOR domicilio.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE SmartViewer
&Scoped-define DB-AWARE no

&Scoped-define ADM-SUPPORTED-LINKS Record-Source,Record-Target,TableIO-Target

/* Name of designated FRAME-NAME and/or first browse and/or first query */
&Scoped-define FRAME-NAME sF-Main
&Scoped-define BROWSE-NAME BROWSE-7

/* External Tables                                                      */
&Scoped-define EXTERNAL-TABLES Tarea
&Scoped-define FIRST-EXTERNAL-TABLE Tarea


/* Need to scope the external tables to this procedure                  */
DEFINE QUERY external_tables FOR Tarea.
/* Internal Tables (found by Frame, Query & Browse Queries)             */
&Scoped-define INTERNAL-TABLES Cliente

/* Definitions for FRAME sF-Main                                        */
&Scoped-define QUERY-STRING-sF-Main FOR EACH Cliente OF Tarea NO-LOCK
&Scoped-define OPEN-QUERY-sF-Main OPEN QUERY sF-Main FOR EACH Cliente OF Tarea NO-LOCK.
&Scoped-define TABLES-IN-QUERY-sF-Main Cliente
&Scoped-define FIRST-TABLE-IN-QUERY-sF-Main Cliente


/* Standard List Definitions                                            */
&Scoped-Define ENABLED-FIELDS Tarea.nro_destino Tarea.accion 
&Scoped-define ENABLED-TABLES Tarea
&Scoped-define FIRST-ENABLED-TABLE Tarea
&Scoped-Define ENABLED-OBJECTS RECT-10 BUTTON-12 BUTTON-1 vcontrato ~
horario_de_atencion BROWSE-7 
&Scoped-Define DISPLAYED-FIELDS Tarea.nro_evento Tarea.nro_destino ~
Tarea.accion Tarea.estado 
&Scoped-define DISPLAYED-TABLES Tarea
&Scoped-define FIRST-DISPLAYED-TABLE Tarea
&Scoped-Define DISPLAYED-OBJECTS horario_de_atencion v-texto 

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
nro_usuario||y|sic.Tarea.nro_usuario
descripcion||y|sic.Tarea.descripcion
cdg_cargo||y|sic.Tarea.cdg_cargo
nro_cliente||y|sic.Tarea.nro_cliente
cdg_postal||y|sic.Tarea.cdg_postal
nro_evento||y|sic.Tarea.nro_evento
nro_persona||y|sic.Tarea.nro_persona
cdg_proyecto||y|sic.Tarea.cdg_proyecto
cdg_recurso||y|sic.Tarea.cdg_recurso
nro_tipo_evento||y|sic.Tarea.nro_tipo_evento
cdg_tipotarea||y|sic.Tarea.cdg_tipotarea
cdg_tarea||y|sic.Tarea.cdg_tarea
cdg_usuario||y|sic.Tarea.cdg_usuario
</FOREIGN-KEYS> 
<EXECUTING-CODE>
**************************
* Set attributes related to FOREIGN KEYS
*/
RUN set-attribute-list (
    'Keys-Accepted = ,
     Keys-Supplied = "nro_usuario,descripcion,cdg_cargo,nro_cliente,cdg_postal,nro_evento,nro_persona,cdg_proyecto,cdg_recurso,nro_tipo_evento,cdg_tipotarea,cdg_tarea,cdg_usuario"':U).
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


/* ***********************  Control Definitions  ********************** */


/* Definitions of the field level widgets                               */
DEFINE BUTTON b-agrega 
     IMAGE-UP FILE "img/add.gif":U
     LABEL "Agrega" 
     SIZE 7 BY 2.14.

DEFINE BUTTON Bresuelto 
     LABEL "Res" 
     SIZE 7 BY 1.14.

DEFINE BUTTON BUTTON-1 
     IMAGE-UP FILE "vortex100.jpg":U
     LABEL "Button 1" 
     SIZE 6 BY 1.52 DROP-TARGET.

DEFINE BUTTON BUTTON-12 
     IMAGE-UP FILE "iconos24/zoom_in.jpg":U
     IMAGE-DOWN FILE "iconos24i/zoom_in.jpg":U
     LABEL "Button 12" 
     SIZE 6 BY 1.52.

DEFINE BUTTON Bvecino 
     LABEL "Vecinos" 
     SIZE 9 BY 1.14.

DEFINE BUTTON vcontrato 
     LABEL "Ver" 
     SIZE 6 BY 1.14.

DEFINE VARIABLE v-texto AS CHARACTER 
     VIEW-AS EDITOR SCROLLBAR-VERTICAL
     SIZE 140 BY 2.14
     BGCOLOR 15 FGCOLOR 9 .

DEFINE VARIABLE horario_de_atencion LIKE Cliente.horario_de_atencion
     VIEW-AS FILL-IN 
     SIZE 35 BY 1 TOOLTIP "Horario de atencion de la ADMINISTRACION"
     BGCOLOR 14  NO-UNDO.

DEFINE RECTANGLE RECT-10
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 9 BY 1.05 TOOLTIP "Administracion con Observacion"
     BGCOLOR 10 .

/* Query definitions                                                    */
&ANALYZE-SUSPEND
DEFINE QUERY sF-Main FOR 
      Cliente SCROLLING.
&ANALYZE-RESUME

/* Browse definitions                                                   */
DEFINE BROWSE BROWSE-7
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS BROWSE-7 V-table-Win _STRUCTURED
  
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ROW-MARKERS SEPARATORS SIZE 148 BY 5.95 ROW-HEIGHT-CHARS 1.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME sF-Main
     BUTTON-12 AT ROW 1 COL 23 WIDGET-ID 28
     BUTTON-1 AT ROW 1 COL 29 WIDGET-ID 114
     Bresuelto AT ROW 1.19 COL 144 WIDGET-ID 64
     Tarea.nro_evento AT ROW 1.24 COL 10 COLON-ALIGNED WIDGET-ID 26
          LABEL "Ev."
          VIEW-AS FILL-IN 
          SIZE 10.8 BY 1
     Tarea.nro_destino AT ROW 1.24 COL 38 COLON-ALIGNED WIDGET-ID 122
          LABEL "Cto"
          VIEW-AS FILL-IN 
          SIZE 14 BY 1
     vcontrato AT ROW 1.24 COL 55 WIDGET-ID 124
     Tarea.accion AT ROW 1.24 COL 75 COLON-ALIGNED WIDGET-ID 116
          LABEL "Acc"
          VIEW-AS COMBO-BOX INNER-LINES 5
          LIST-ITEM-PAIRS "0","0"
          DROP-DOWN-LIST
          SIZE 18.8 BY 1
     Bvecino AT ROW 1.24 COL 97 WIDGET-ID 136
     horario_de_atencion AT ROW 1.24 COL 105 COLON-ALIGNED HELP
          "" NO-LABEL WIDGET-ID 118
          BGCOLOR 14 
     BROWSE-7 AT ROW 2.43 COL 2 HELP
          "" WIDGET-ID 200
     v-texto AT ROW 8.86 COL 3 NO-LABEL WIDGET-ID 2
     b-agrega AT ROW 8.86 COL 144 WIDGET-ID 22
     Tarea.estado AT ROW 1.43 COL 1 COLON-ALIGNED NO-LABEL WIDGET-ID 24
           VIEW-AS TEXT 
          SIZE 3 BY .62
     RECT-10 AT ROW 1.24 COL 62 WIDGET-ID 84
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
         HEIGHT             = 10
         WIDTH              = 150.8.
/* END WINDOW DEFINITION */
                                                                        */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _INCLUDED-LIB V-table-Win 
/* ************************* Included-Libraries *********************** */

{src/adm/method/Vortex.i}
{src/adm/method/viewer.i}

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME




/* ***********  Runtime Attributes and AppBuilder Settings  *********** */

&ANALYZE-SUSPEND _RUN-TIME-ATTRIBUTES
/* SETTINGS FOR WINDOW V-table-Win
  VISIBLE,,RUN-PERSISTENT                                               */
/* SETTINGS FOR FRAME sF-Main
   NOT-VISIBLE FRAME-NAME Size-to-Fit                                   */
/* BROWSE-TAB BROWSE-7 horario_de_atencion sF-Main */
ASSIGN 
       FRAME sF-Main:SCROLLABLE       = FALSE
       FRAME sF-Main:HIDDEN           = TRUE.

/* SETTINGS FOR COMBO-BOX Tarea.accion IN FRAME sF-Main
   EXP-LABEL                                                            */
/* SETTINGS FOR BUTTON b-agrega IN FRAME sF-Main
   NO-ENABLE                                                            */
/* SETTINGS FOR BUTTON Bresuelto IN FRAME sF-Main
   NO-ENABLE                                                            */
/* SETTINGS FOR BUTTON Bvecino IN FRAME sF-Main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN Tarea.estado IN FRAME sF-Main
   NO-ENABLE EXP-LABEL                                                  */
/* SETTINGS FOR FILL-IN horario_de_atencion IN FRAME sF-Main
   LIKE = sic.Cliente. EXP-LABEL EXP-SIZE                               */
ASSIGN 
       horario_de_atencion:READ-ONLY IN FRAME sF-Main        = TRUE.

/* SETTINGS FOR FILL-IN Tarea.nro_destino IN FRAME sF-Main
   EXP-LABEL                                                            */
/* SETTINGS FOR FILL-IN Tarea.nro_evento IN FRAME sF-Main
   NO-ENABLE EXP-LABEL                                                  */
/* SETTINGS FOR EDITOR v-texto IN FRAME sF-Main
   NO-ENABLE                                                            */
ASSIGN 
       v-texto:RETURN-INSERTED IN FRAME sF-Main  = TRUE
       v-texto:READ-ONLY IN FRAME sF-Main        = TRUE.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME


/* Setting information for Queries and Browse Widgets fields            */

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE BROWSE-7
/* Query rebuild information for BROWSE BROWSE-7
     _Query            is NOT OPENED
*/  /* BROWSE BROWSE-7 */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _QUERY-BLOCK FRAME sF-Main
/* Query rebuild information for FRAME sF-Main
     _TblList          = "sic.Cliente OF sic.Tarea"
     _Options          = "NO-LOCK"
     _Query            is OPENED
*/  /* FRAME sF-Main */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME Tarea.accion
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Tarea.accion V-table-Win
ON VALUE-CHANGED OF Tarea.accion IN FRAME sF-Main /* Acc */
DO:
  IF tarea.nro_destino:INPUT-VALUE IN FRAME {&FRAME-NAME} = 0 THEN
  MESSAGE "Se creara el contrato al grabar la tarea" VIEW-AS ALERT-BOX INFORMATION.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME b-agrega
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL b-agrega V-table-Win
ON CHOOSE OF b-agrega IN FRAME sF-Main /* Agrega */
DO:
  v-texto = "".
  v-texto:READ-ONLY = FALSE.
  b-agrega:SENSITIVE = FALSE.
  DISPLAY v-texto WITH FRAME {&FRAME-NAME}.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME Bresuelto
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Bresuelto V-table-Win
ON CHOOSE OF Bresuelto IN FRAME sF-Main /* Res */
DO:
  RUN d-tarearesol.w (INPUT tarea.nro_tarea).
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define BROWSE-NAME BROWSE-7
&Scoped-define SELF-NAME BROWSE-7
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL BROWSE-7 V-table-Win
ON VALUE-CHANGED OF BROWSE-7 IN FRAME sF-Main
DO:
    IF AVAILABLE tttexto THEN v-texto = tttexto.ttexto.
    DISPLAY v-texto WITH FRAME {&FRAME-NAME}. 
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME BUTTON-1
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL BUTTON-1 V-table-Win
ON CHOOSE OF BUTTON-1 IN FRAME sF-Main /* Button 1 */
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
ON DROP-FILE-NOTIFY OF BUTTON-1 IN FRAME sF-Main /* Button 1 */
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
ON MOUSE-MENU-CLICK OF BUTTON-1 IN FRAME sF-Main /* Button 1 */
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


&Scoped-define SELF-NAME BUTTON-12
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL BUTTON-12 V-table-Win
ON CHOOSE OF BUTTON-12 IN FRAME sF-Main /* Button 12 */
DO:
  IF tarea.nro_evento <> 0 THEN
    RUN d-zoom-evento.w(tarea.nro_evento,"ZOOM").
  ELSE
      MESSAGE "No hay evento relacionado"VIEW-AS ALERT-BOX INFORMATION.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME Bvecino
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Bvecino V-table-Win
ON CHOOSE OF Bvecino IN FRAME sF-Main /* Vecinos */
DO:
DEFINE VAR pnro_cliente LIKE cliente.nro_cliente.
DEFINE VAR hproc AS HANDLE NO-UNDO.
DEFINE VAR hcproc AS CHAR NO-UNDO.
DEFINE VAR pcdg_tipotarea LIKE tarea.cdg_tipotarea.
DEFINE VAR ii AS INT NO-UNDO.
DEFINE VAR geolat AS DECIMAL NO-UNDO.
DEFINE VAR geolong AS DECIMAL NO-UNDO.

RUN get-link-handle IN adm-broker-hdl
      ( INPUT THIS-PROCEDURE,
        INPUT "record-Source",
        OUTPUT hcproc ).
    /* Code placed here will execute PRIOR to standard behavior. */
hproc = WIDGET-HANDLE(hcproc).

IF NOT VALID-HANDLE(hproc) THEN DO:
    MESSAGE "No se puede obtener el handle para el record-source" VIEW-AS ALERT-BOX ERROR.
    RETURN NO-APPLY.
END.

RUN damegeo IN hproc (OUTPUT geolat, OUTPUT geolong).
RUN dametipo IN hproc(OUTPUT pcdg_tipotarea).
IF geolat = 0 OR geolong = 0 THEN DO:
    MESSAGE "Referencia no geocodidicada correctamente" VIEW-AS ALERT-BOX ERROR.
    RETURN NO-APPLY.
END.

cerrar(h_vecinos).

IF pcdg_tipotarea = "C" THEN
        RUN w-vecinosCO.w PERSISTENT SET h_vecinos ( tarea.nro_tarea,"T",5000,THIS-PROCEDURE).
ELSE
        RUN w-vecinosEV.w PERSISTENT  SET h_vecinos ( ? ,
                       primerdia(today),
                       ultimodia(today),
                       3000,
                       ?,
                       geolat,
                       geolong,
                       IF AVAILABLE cliente THEN Cliente.nom_cliente + '<BR>Tarea:' + string(tarea.nro_tarea) + '<BR>Dir:' + cliente.direccion ELSE 'Tarea:' + string(tarea.nro_tarea) + "<BR>Cliente buscado",
                       IF AVAILABLE cliente THEN cliente.cdg_cliente ELSE ?,
                       tarea.direccion,
                       THIS-PROCEDURE ,
                       tarea.horas_estimadas ).

RUN dispatch IN h_vecinos ( INPUT 'initialize':U ) .
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME Tarea.nro_destino
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Tarea.nro_destino V-table-Win
ON MOUSE-MENU-CLICK OF Tarea.nro_destino IN FRAME sF-Main /* Cto */
DO:
  IF AVAILABLE tarea THEN 
  RUN d-contrato.w(INPUT-OUTPUT tarea.nro_destino).
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME RECT-10
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL RECT-10 V-table-Win
ON MOUSE-SELECT-CLICK OF RECT-10 IN FRAME sF-Main
DO:
   DEFINE BUFFER administrador FOR cliente.
   DEFINE VARIABLE puso_ok AS LOGICAL.
       FIND administrador WHERE administrador.nro_cliente = int( rect-10:PRIVATE-DATA ) NO-ERROR.
   IF AVAILABLE administrador THEN DO:
     IF administrador.observacion <> "" THEN DO:
        RUN c-edttexto.w ( INPUT-OUTPUT administrador.observacion,
                      INPUT "Observaciónes del administrador",
                      4,
                      OUTPUT puso_ok).
     END.
   END.
   
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME vcontrato
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL vcontrato V-table-Win
ON CHOOSE OF vcontrato IN FRAME sF-Main /* Ver */
DO:
    npresu = ?.
 IF tarea.nro_destino:INPUT-VALUE > 0  THEN DO:
      npresu =  tarea.nro_destino:INPUT-VALUE.
      IF NOT VALID-HANDLE( h_c ) THEN DO:
        RUN w-contrato.w PERSISTENT SET h_c  .
        RUN dispatch IN h_c ("initialize").
      END.
      ELSE
        RUN dispatch IN h_c ("view").
      DYNAMIC-FUNCTION( "pcontrato" IN h_c , tarea.nro_destino ).
  END.
  ELSE DO:
      MESSAGE "Aun no se ha creado el contrato"
          VIEW-AS ALERT-BOX INFORMATION.
      RETURN NO-APPLY.
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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE adm-find-using-key V-table-Win  adm/support/_key-fnd.p
PROCEDURE adm-find-using-key :
/*------------------------------------------------------------------------------
  Purpose:     Finds the current record using the contents of
               the 'Key-Name' and 'Key-Value' attributes.
  Parameters:  <none>
------------------------------------------------------------------------------*/

  /* No Foreign keys are accepted by this SmartObject. */

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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE ass V-table-Win 
PROCEDURE ass :
/* /*------------------------------------------------------------------------------         */
/*   Purpose:     Override standard ADM method                                              */
/*   Notes:                                                                                 */
/* ------------------------------------------------------------------------------*/         */
/* DEFINE VAR k AS INT NO-UNDO.                                                             */
/* DEFINE VARIABLE hWidget AS HANDLE     NO-UNDO.                                           */
/* DEFINE VARIABLE hField  AS HANDLE     NO-UNDO.                                           */
/*                                                                                          */
/* RUN dispatch IN THIS-PROCEDURE ( INPUT 'display-fields':U ) .                            */
/*                                                                                          */
/*   hWidget = phFrame:CURRENT-ITERATION:FIRST-CHILD.                                       */
/*   DO WHILE VALID-HANDLE(hWidget):                                                        */
/*     k = lookup(hWidget:NAME ,tareas.datos-template, chr(1)).                             */
/*     IF  k<> 0                                                                            */
/*       AND CAN-QUERY(hWidget, 'SCREEN-VALUE':U) THEN                                      */
/*     DO:                                                                                  */
/*       hField = phBuffer:BUFFER-FIELD(hWidget:NAME).                                      */
/*       IF VALID-HANDLE(hField) THEN                                                       */
/*       DO:                                                                                */
/*         IF hWidget:TYPE = 'COMBO-BOX'                                                    */
/*           AND hWidget:SCREEN-VALUE = ENTRY(2,ENTRY(k , tareas.datos-template , CHR(1) )) */
/*           AND hWidget:LOOKUP('') > 0 THEN                                                */
/*           hField:BUFFER-VALUE = ''.                                                      */
/*         ELSE IF CAN-QUERY(hWidget, 'INPUT-VALUE':U) THEN                                 */
/*           hField:BUFFER-VALUE = hWidget:INPUT-VALUE.                                     */
/*         ELSE IF CAN-QUERY(hWidget, 'CHECKED':U) THEN                                     */
/*           hField:BUFFER-VALUE = hWidget:CHECKED.                                         */
/*         ELSE IF CAN-QUERY(hWidget, 'SCREEN-VALUE') THEN                                  */
/*           hField:BUFFER-VALUE = hWidget:SCREEN-VALUE.                                    */
/*       END.                                                                               */
/*     END.                                                                                 */
/*     hWidget = hWidget:NEXT-SIBLING.                                                      */
/*   END.                                                                                   */
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE cambia_cliente V-table-Win 
PROCEDURE cambia_cliente :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEFINE INPUT PARAM p AS ROWID.
DEFINE BUFFER administrador FOR cliente.
    FIND cliente WHERE ROWID(cliente) = p NO-LOCK NO-ERROR.
    IF AVAILABLE cliente  THEN DO WITH FRAME {&FRAME-NAME}:
        /*ver el rect-10 de advertencias*/
        FIND administrador WHERE administrador.nro_cliente = cliente.nro_admin NO-LOCK NO-ERROR.
        IF AVAILABLE administrador THEN DO:
            rect-10:PRIVATE-DATA = string(administrador.nro_administrador).
            IF administrador.observacion <> "" THEN DO:
                rect-10:BGCOLOR  = 12.
            END.
            ELSE rect-10:BGCOLOR = 10.
        END.
        ELSE rect-10:BGCOLOR = 10.
    END.
    ELSE rect-10:BGCOLOR = 10.
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
  HIDE FRAME sF-Main.
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

  IF NOT AVAILABLE tarea THEN DO:
            MESSAGE "No existe la tarea, no se puede incluir el documento" SKIP
                    "grabe la tarea primero" VIEW-AS ALERT-BOX ERROR.
            RETURN NO-APPLY.
  END.
  p-carpeta = "TAREAS".
  p-indice = string(tarea.nro_tarea).

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
    RUN loadAdvTexto ( "" ,BROWSE BROWSE-7:HANDLE,OUTPUT TABLE tttexto,OUTPUT v-texto).
  DISPLAY v-texto WITH FRAME {&FRAME-NAME}.

  /* Dispatch standard ADM method.                             */
  RUN dispatch IN THIS-PROCEDURE ( INPUT 'add-record':U ) .

  /* Code placed here will execute AFTER standard behavior.    */
tarea.accion:SCREEN-VALUE = "0".
DISPLAY tarea.accion.

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
DEFINE VAR caccion AS LOGICAL NO-UNDO.
{findempresa.i}
  DEF VAR auxvend as CHAR NO-UNDO.
  DEF VAR aux AS INT NO-UNDO.
  DEF VAR dflprf AS INT NO-UNDO.

caccion = tarea.accion <> tarea.accion:INPUT-VALUE IN FRAME {&FRAME-NAME}. 

RUN dispatch IN THIS-PROCEDURE ( INPUT 'assign-statement':U ) .

phframe = FRAME {&FRAME-NAME}:HANDLE.
hWidget = phFrame:CURRENT-ITERATION:FIRST-CHILD.

  DO WHILE VALID-HANDLE(hWidget):

    k = lookup(hWidget:NAME ,Tarea.datos-template, "|").
    IF  k > 0 AND CAN-QUERY( hWidget, 'SCREEN-VALUE' ) THEN
    DO:
        IF hWidget:TYPE = 'COMBO-BOX'  THEN
          sal = sal + "|" + hWidget:NAME + "|" + hWidget:SCREEN-VALUE.
        ELSE IF CAN-QUERY( hWidget, 'INPUT-VALUE':U ) THEN
          sal = sal + "|" +  hWidget:NAME + "|" + hWidget:SCREEN-VALUE.
        ELSE IF CAN-QUERY( hWidget, 'CHECKED':U ) THEN
          sal = sal + "|" +  hWidget:NAME + "|" +  IF hWidget:CHECKED THEN "yes" ELSE "no".
        ELSE IF CAN-QUERY( hWidget, 'SCREEN-VALUE' ) THEN
          sal = sal + "|" +  hWidget:NAME + "|" + hWidget:SCREEN-VALUE.
    END.
    hWidget = hWidget:NEXT-SIBLING.
  END.
  Tarea.datos-template = substring(sal,2).

  tarea.descripcion = saveAdvTexto2(IF caccion THEN entry(int( tarea.accion ) * 2 + 1 ,acciones ) ELSE "", v-texto:INPUT-VALUE,TABLE tttexto).
  Tarea.Destino = "CONTRATO".
  

  IF tarea.nro_destino = 0 AND tarea.accion:INPUT-VALUE = "2"  THEN DO:
          IF tarea.nro_cliente = 0 THEN DO:
              MESSAGE "No ha gabado la tarea inicial" SKIP
                      "hagalo y despues cambie el estado"
                  VIEW-AS ALERT-BOX ERROR.
              DISPLAY tarea.accion WITH FRAME {&FRAME-NAME}.
              RETURN NO-APPLY.
          END.
          RUN getparametro_n.p ("DFRENOV",OUTPUT aux).
          RUN getparametro_n.p ("DFPRPRF",OUTPUT dflprf).
          FIND CURRENT tarea EXCLUSIVE-LOCK.
          FIND cliente NO-LOCK of tarea.
          FIND FIRST Domicilio OF Cliente NO-LOCK.
          FIND FIRST vendedor NO-LOCK NO-ERROR.
          FIND condicion_venta WHERE condicion_venta.cdg_cndventa = 
               cliente.dfl_cndventa.
          FIND persona NO-LOCK OF tarea NO-ERROR.
          IF NOT AVAILABLE persona THEN DO:
              MESSAGE "Debe seleccion una persona que tenga email en el cliente"VIEW-AS ALERT-BOX ERROR.
              RETURN ERROR.
          END.
          IF persona.email="" THEN do:
            MESSAGE "Esta tarea requiere una persona de contacto que tenga direccion de email, " skip
                "para enviar el presupuesto" SKIP
                    "corrija esta situacion antes de proseguir con la aprobacion" SKIP
                    "puede hacerlo desde esta misma pantalla"
                VIEW-AS ALERT-BOX ERROR.
            DISPLAY tarea.accion WITH FRAME {&FRAME-NAME}.
            RETURN ERROR.
         END.

          CREATE contrato_hd.
          BUFFER-COPY cliente TO contrato_hd.
          ASSIGN Contrato_hd.nro_cliente    = Cliente.nro_cliente
                 Contrato_hd.nro_cndventa   = condicion_venta.nro_cndventa 
                 Contrato_hd.cdg_provincia  = Cliente.cdg_provincia
                 Contrato_hd.cdg_empresa    = Empresa.cdg_empresa
                 Contrato_hd.nro_contrato   = NEXT-VALUE(proximo_contrato)
                 Contrato_hd.num_contrato   = Contrato_hd.nro_contrato
                 contrato_hd.cdg_imputacion = 51 
                 contrato_hd.nro_vendedor = vendedor.nro_vendedor /*por defecto*/
                 contrato_hd.fecha_alta = TODAY
                 Contrato_hd.rige_desde = TODAY
                 Contrato_hd.rige_hasta = 01/01/2999
                 Contrato_hd.primer_mes = MONTH(TODAY)
                 Contrato_hd.primer_ano = year(TODAY)
                 contrato_hd.prf_contrato   = dflprf
                 tarea.destino = "CONTRATO"
                 contrato_hd.nro_plazo = aux
                 tarea.nro_destino = contrato_hd.nro_contrato
                 tarea.destino = "CONTRATO"
                 contrato_hd.estado = "P"
                 contrato_hd.cant_periodos = 0
                 contrato_hd.nro_persona = persona.nro_persona
                 Contrato_hd.resto_periodos = Contrato_hd.cant_periodos
                 Contrato_hd.nro_domicilio = Domicilio.nro_domicilio.
                 tarea.descripcion = agregaAdvTexto("Contrato creado " + string(contrato_hd.nro_contrato) ,tarea.descripcion).
                 DISPLAY tarea.nro_destino WITH FRAME {&FRAME-NAME}.

  
  /*crear o editar el presupuesto*/
  /*   IF NOT VALID-HANDLE( h_c ) THEN DO:
         RUN w-contrato.w PERSISTENT SET h_c .
         RUN dispatch IN h_c ("initialize").
      END.
      RUN dispatch IN h_c ("view").
      DYNAMIC-FUNCTION('pcontrato' IN  h_c,  tarea.nro_destino ).
      */
  END. 

  IF tarea.destino = "CONTRATO" AND tarea.nro_destino <> 0 THEN DO:
      FIND persona OF tarea NO-ERROR.
      IF NOT AVAILABLE persona THEN DO:
          MESSAGE "Debe seleccionar una perona con direccion de email" VIEW-AS ALERT-BOX ERROR.
          RETURN ERROR.
      END.
      IF persona.email = "" THEN DO:
          MESSAGE "Debe seleccionar una perona con direccion de email" VIEW-AS ALERT-BOX ERROR.
          RETURN ERROR.
      END.
      FIND contrato_hd WHERE nro_contrato = tarea.nro_destino.
        contrato_hd.nro_persona = persona.nro_persona.
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
DEFINE VAR k AS INT NO-UNDO.
DEFINE VARIABLE hWidget AS HANDLE     NO-UNDO.
DEFINE VARIABLE hField  AS HANDLE     NO-UNDO.
DEFINE VAR phframe AS HANDLE NO-UNDO.

  RUN dispatch IN THIS-PROCEDURE ( INPUT 'disable-fields':U ) .

phframe = FRAME {&FRAME-NAME}:HANDLE.
hWidget = phFrame:CURRENT-ITERATION:FIRST-CHILD.
bvecino:SENSITIVE = FALSE.
  DO WHILE VALID-HANDLE(hWidget):
    IF  CAN-QUERY( hWidget, 'SCREEN-VALUE' ) THEN
        hWidget:SENSITIVE = FALSE.
    hWidget = hWidget:NEXT-SIBLING.
  END.
  v-texto:READ-ONLY = TRUE.
  b-agrega:SENSITIVE = FALSE.
IF VALID-HANDLE(h_c) THEN DO:
    RUN adm-destroy IN h_c NO-ERROR.
    h_c = ?.
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
DEFINE VAR k AS INT NO-UNDO.
DEFINE VARIABLE hWidget AS HANDLE     NO-UNDO.
DEFINE VARIABLE hField  AS HANDLE     NO-UNDO.
DEFINE VAR phframe AS HANDLE NO-UNDO.
DEFINE BUFFER administracion FOR cliente.
RUN dispatch IN THIS-PROCEDURE ( INPUT 'display-fields':U ) .

phframe = FRAME {&FRAME-NAME}:HANDLE.
hWidget = phFrame:CURRENT-ITERATION:FIRST-CHILD.
IF AVAILABLE tarea THEN DO:
  bresuelto:SENSITIVE = tarea.fecha_resuelto <> ?.
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
   RUN loadAdvTexto ( IF AVAILABLE tarea THEN tarea.descripcion ELSE "" ,BROWSE BROWSE-7:HANDLE,OUTPUT TABLE tttexto,OUTPUT v-texto).
  FIND administracion WHERE administracion.nro_cliente = tarea.nro_admin NO-LOCK NO-ERROR.
  IF AVAILABLE administracion THEN 
        horario_de_atencion = administracion.horario_de_atencion.  
  ELSE  horario_de_atencion = "".

DISPLAY v-texto tarea.accion 
        horario_de_atencion WITH FRAME {&FRAME-NAME}.
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
bvecino:SENSITIVE = TRUE.
  DO WHILE VALID-HANDLE(hWidget):
    IF  CAN-QUERY( hWidget, 'SCREEN-VALUE' ) THEN
        hWidget:SENSITIVE = TRUE.
    hWidget = hWidget:NEXT-SIBLING.
  END.
  b-agrega:SENSITIVE = TRUE.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE local-initialize V-table-Win 
PROCEDURE local-initialize :
/*------------------------------------------------------------------------------
  Purpose:     Override standard ADM method
  Notes:       
------------------------------------------------------------------------------*/

  /* Code placed here will execute PRIOR to standard behavior. */

  /* Dispatch standard ADM method.                             */
  tarea.accion:LIST-ITEM-PAIRS IN FRAME {&FRAME-NAME} = acciones.
  RUN dispatch IN THIS-PROCEDURE ( INPUT 'initialize':U ) .

  /* Code placed here will execute AFTER standard behavior.    */

IF AVAILABLE tarea THEN DISPLAY tarea.accion WITH FRAME {&FRAME-NAME}.
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
  {src/adm/template/sndkycas.i "nro_usuario" "Tarea" "nro_usuario"}
  {src/adm/template/sndkycas.i "descripcion" "Tarea" "descripcion"}
  {src/adm/template/sndkycas.i "cdg_cargo" "Tarea" "cdg_cargo"}
  {src/adm/template/sndkycas.i "nro_cliente" "Tarea" "nro_cliente"}
  {src/adm/template/sndkycas.i "cdg_postal" "Tarea" "cdg_postal"}
  {src/adm/template/sndkycas.i "nro_evento" "Tarea" "nro_evento"}
  {src/adm/template/sndkycas.i "nro_persona" "Tarea" "nro_persona"}
  {src/adm/template/sndkycas.i "cdg_proyecto" "Tarea" "cdg_proyecto"}
  {src/adm/template/sndkycas.i "cdg_recurso" "Tarea" "cdg_recurso"}
  {src/adm/template/sndkycas.i "nro_tipo_evento" "Tarea" "nro_tipo_evento"}
  {src/adm/template/sndkycas.i "cdg_tipotarea" "Tarea" "cdg_tipotarea"}
  {src/adm/template/sndkycas.i "cdg_tarea" "Tarea" "cdg_tarea"}
  {src/adm/template/sndkycas.i "cdg_usuario" "Tarea" "cdg_usuario"}

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
  {src/adm/template/snd-list.i "Tarea"}
  {src/adm/template/snd-list.i "Cliente"}

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

