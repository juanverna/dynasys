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


DEFINE VAR ttipo LIKE tipo_evento.nro_tipo_evento NO-UNDO INITIAL 21.
DEFINE VAR pgeoX AS DECIMAL NO-UNDO.
DEFINE VAR pgeoY AS DECIMAL NO-UNDO.
DEFINE VAR dirbase AS CHAR INITIAL "3568 Cabrera,Capital Federal , Argentina".
DEFINE VAR baseX AS DECIMAL.
DEFINE VAR baseY AS DECIMAL.
{geolibrary.i}
DEFINE TEMP-TABLE vecinos LIKE evento
    FIELD cdg_tipo_evento LIKE tipo_evento.cdg_tipo_evento
    FIELD cdg_ref_tipo_evento LIKE tipo_evento.cdg_tipo_evento column-LABEL "Tipo!Origen"
    FIELD distancia AS DECIMAL  COLUMN-LABEL "Dist.![mtrs]" FORMAT ">>>>>9"
    FIELD Adicional AS CHAR FORMAT "X(50)"
    INDEX idx1 distancia.
/* Local Variable Definitions ---                                       */
{stavisado.i}
{tiempo.i}
DEFINE VAR stavisado AS CHAR NO-UNDO.
DEFINE VAR evavisado AS INT NO-UNDO.

DEFINE VAR h_asignar AS HANDLE NO-UNDO.
DEFINE TEMP-TABLE ttasig
    FIELD rowasig AS ROWID.

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
&Scoped-define INTERNAL-TABLES vecinos cliente

/* Definitions for BROWSE BROWSE-2                                      */
&Scoped-define FIELDS-IN-QUERY-BROWSE-2 vecinos.nro_evento ( IF vecinos.distancia > 9999 THEN 9999 ELSE vecinos.distancia ) cliente.direccion vecinos.cdg_tipo_evento vecinos.cdg_ref_tipo_evento vecinos.durac vecinos.origen vecinos.nro_identificacion vecinos.sub_evento vecinos.fasignado vecinos.fmin vecinos.fmax vecinos.recursos stavisado(vecinos.nro_evento) @ stavisado evavisado(vecinos.nro_evento) @ evavisado vecinos.periodo Cliente.nom_cliente vecinos.adicional   
&Scoped-define ENABLED-FIELDS-IN-QUERY-BROWSE-2   
&Scoped-define SELF-NAME BROWSE-2
&Scoped-define QUERY-STRING-BROWSE-2 FOR EACH vecinos, ~
       FIRST cliente OF vecinos NO-LOCK INDEXED-REPOSITION
&Scoped-define OPEN-QUERY-BROWSE-2 OPEN QUERY {&SELF-NAME} FOR EACH vecinos, ~
       FIRST cliente OF vecinos NO-LOCK INDEXED-REPOSITION.
&Scoped-define TABLES-IN-QUERY-BROWSE-2 vecinos cliente
&Scoped-define FIRST-TABLE-IN-QUERY-BROWSE-2 vecinos
&Scoped-define SECOND-TABLE-IN-QUERY-BROWSE-2 cliente


/* Definitions for FRAME F-Main                                         */

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS fhas c_nro_tipo_evento Bprint brefresh ~
Bmuestra Basignar Bexcel Tsinasig Borigen Bevento ccli pxal BROWSE-2 
&Scoped-Define DISPLAYED-OBJECTS fdes fhas c_nro_tipo_evento Tsinasig ccli ~
pxal 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME


/* ************************  Function Prototypes ********************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION-FORWARD duref W-Win 
FUNCTION duref RETURNS INT
  ( d AS CHAR, h AS CHAR )  FORWARD.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION-FORWARD genehtml W-Win 
FUNCTION genehtml RETURNS CHARACTER
  (  )  FORWARD.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION-FORWARD muestradia W-Win 
FUNCTION muestradia RETURNS LOGICAL
  ( )  FORWARD.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION-FORWARD rdur W-Win 
FUNCTION rdur RETURNS INTEGER
  ( rr AS INT )  FORWARD.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


/* ***********************  Control Definitions  ********************** */

/* Define the widget handle for the window                              */
DEFINE VAR W-Win AS WIDGET-HANDLE NO-UNDO.

/* Definitions of handles for OCX Containers                            */
DEFINE VARIABLE Mundo AS WIDGET-HANDLE NO-UNDO.
DEFINE VARIABLE chMundo AS COMPONENT-HANDLE NO-UNDO.

/* Definitions of the field level widgets                               */
DEFINE BUTTON Basignar 
     LABEL "Asignar" 
     SIZE 10 BY 1.14.

DEFINE BUTTON Bevento 
     LABEL "Evento Relacion" 
     SIZE 18 BY 1.14.

DEFINE BUTTON Bexcel 
     IMAGE-UP FILE "excel.gif":U
     LABEL "bexcel" 
     SIZE 6.2 BY 1.14.

DEFINE BUTTON Bmuestra 
     LABEL "GeoV" 
     SIZE 9 BY 1.14.

DEFINE BUTTON Borigen 
     LABEL "Origen" 
     SIZE 15 BY 1.14.

DEFINE BUTTON Bprint 
     LABEL "Print" 
     SIZE 9 BY 1.14.

DEFINE BUTTON brefresh 
     LABEL "Refresh" 
     SIZE 9 BY 1.14.

DEFINE VARIABLE ccli AS CHARACTER 
     VIEW-AS COMBO-BOX INNER-LINES 5
     LIST-ITEMS "BASE" 
     DROP-DOWN
     SIZE 16 BY 1 NO-UNDO.

DEFINE VARIABLE c_nro_tipo_evento AS INTEGER FORMAT ">>>>>>>>9" INITIAL 0 
     LABEL "Tipo" 
     VIEW-AS COMBO-BOX INNER-LINES 5
     LIST-ITEM-PAIRS "0",1
     DROP-DOWN-LIST
     SIZE 12 BY 1 TOOLTIP "Tipo de Restriccion o Tipo de Evento".

DEFINE VARIABLE fdes AS DATE FORMAT "99/99/9999":U INITIAL 01/01/1000 
     LABEL "Fill 2" 
     VIEW-AS FILL-IN 
     SIZE 17 BY 1 NO-UNDO.

DEFINE VARIABLE fhas AS DATE FORMAT "99/99/9999":U 
     LABEL "Fill 2" 
     VIEW-AS FILL-IN 
     SIZE 17 BY 1 NO-UNDO.

DEFINE VARIABLE pxal AS CHARACTER FORMAT "X(256)":U 
     LABEL "Fill 3" 
     VIEW-AS FILL-IN 
     SIZE 93 BY 1 NO-UNDO.

DEFINE VARIABLE Tsinasig AS LOGICAL INITIAL yes 
     LABEL "Sin Asignar" 
     VIEW-AS TOGGLE-BOX
     SIZE 17 BY .81 TOOLTIP "Si es Sin Asignar el rango es fmin/fmax sino asignados" NO-UNDO.

/* Query definitions                                                    */
&ANALYZE-SUSPEND
DEFINE QUERY BROWSE-2 FOR 
      vecinos, 
      cliente SCROLLING.
&ANALYZE-RESUME

/* Browse definitions                                                   */
DEFINE BROWSE BROWSE-2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS BROWSE-2 W-Win _FREEFORM
  QUERY BROWSE-2 NO-LOCK DISPLAY
      vecinos.nro_evento
     ( IF vecinos.distancia > 9999 THEN 9999 ELSE vecinos.distancia ) 
     cliente.direccion
     vecinos.cdg_tipo_evento
     vecinos.cdg_ref_tipo_evento
     vecinos.durac COLUMN-LABEL "DUR"
     vecinos.origen FORMAT "X(10)"
     vecinos.nro_identificacion COLUMN-LABEL "Identf."
     vecinos.sub_evento COLUMN-LABEL "SE"
     vecinos.fasignado
     vecinos.fmin
     vecinos.fmax
     vecinos.recursos FORMAT "X(8)"
     stavisado(vecinos.nro_evento) @ stavisado COLUMN-LABEL "AV" FORMAT "X"
     evavisado(vecinos.nro_evento) @ evavisado COLUMN-LABEL "AVISADO" FORMAT ">>>>>>>>9"
     vecinos.periodo
     Cliente.nom_cliente
     vecinos.adicional
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH SEPARATORS SIZE 209 BY 16.91 ROW-HEIGHT-CHARS .81 FIT-LAST-COLUMN.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME F-Main
     fdes AT ROW 1 COL 1 WIDGET-ID 68
     fhas AT ROW 1 COL 19 WIDGET-ID 14
     c_nro_tipo_evento AT ROW 1 COL 37 WIDGET-ID 40
     Bprint AT ROW 1 COL 76 WIDGET-ID 60
     brefresh AT ROW 1 COL 86 WIDGET-ID 44
     Bmuestra AT ROW 1 COL 96 WIDGET-ID 46
     Basignar AT ROW 1 COL 106 WIDGET-ID 64
     Bexcel AT ROW 1 COL 117 WIDGET-ID 48
     Tsinasig AT ROW 1.14 COL 55 WIDGET-ID 62
     Borigen AT ROW 1.71 COL 124.2 WIDGET-ID 70
     Bevento AT ROW 1.71 COL 140.2 WIDGET-ID 72
     ccli AT ROW 2.19 COL 2 NO-LABEL WIDGET-ID 54
     pxal AT ROW 2.19 COL 19 WIDGET-ID 56
     BROWSE-2 AT ROW 3.38 COL 1 WIDGET-ID 200
    WITH 1 DOWN NO-BOX NO-HIDE KEEP-TAB-ORDER OVERLAY NO-HELP 
         NO-LABELS NO-UNDERLINE NO-VALIDATE THREE-D 
         AT COL 1 ROW 1
         SIZE 209.4 BY 19.62 WIDGET-ID 100.


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
         TITLE              = "Mapa - Por fecha de asignacion"
         HEIGHT             = 20.05
         WIDTH              = 209.4
         MAX-HEIGHT         = 35.67
         MAX-WIDTH          = 212.8
         VIRTUAL-HEIGHT     = 35.67
         VIRTUAL-WIDTH      = 212.8
         SHOW-IN-TASKBAR    = no
         MIN-BUTTON         = no
         RESIZE             = yes
         SCROLL-BARS        = no
         STATUS-AREA        = no
         BGCOLOR            = ?
         FGCOLOR            = ?
         THREE-D            = yes
         MESSAGE-AREA       = yes
         SENSITIVE          = yes.
ELSE {&WINDOW-NAME} = CURRENT-WINDOW.
/* END WINDOW DEFINITION                                                */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _INCLUDED-LIB W-Win 
/* ************************* Included-Libraries *********************** */

{excel-export.i}
{src/adm/method/containr.i}

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME




/* ***********  Runtime Attributes and AppBuilder Settings  *********** */

&ANALYZE-SUSPEND _RUN-TIME-ATTRIBUTES
/* SETTINGS FOR WINDOW W-Win
  VISIBLE,,RUN-PERSISTENT                                               */
/* SETTINGS FOR FRAME F-Main
   FRAME-NAME                                                           */
/* BROWSE-TAB BROWSE-2 pxal F-Main */
ASSIGN 
       Bexcel:HIDDEN IN FRAME F-Main           = TRUE.

ASSIGN 
       BROWSE-2:HIDDEN  IN FRAME F-Main                = TRUE
       BROWSE-2:COLUMN-RESIZABLE IN FRAME F-Main       = TRUE
       BROWSE-2:COLUMN-MOVABLE IN FRAME F-Main         = TRUE.

/* SETTINGS FOR COMBO-BOX ccli IN FRAME F-Main
   ALIGN-L                                                              */
/* SETTINGS FOR COMBO-BOX c_nro_tipo_evento IN FRAME F-Main
   ALIGN-L LABEL "Tipo:"                                                */
/* SETTINGS FOR FILL-IN fdes IN FRAME F-Main
   NO-ENABLE ALIGN-L LABEL "Fill 2:"                                    */
ASSIGN 
       fdes:HIDDEN IN FRAME F-Main           = TRUE.

/* SETTINGS FOR FILL-IN fhas IN FRAME F-Main
   ALIGN-L LABEL "Fill 2:"                                              */
/* SETTINGS FOR FILL-IN pxal IN FRAME F-Main
   ALIGN-L LABEL "Fill 3:"                                              */
IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(W-Win)
THEN W-Win:HIDDEN = no.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME


/* Setting information for Queries and Browse Widgets fields            */

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE BROWSE-2
/* Query rebuild information for BROWSE BROWSE-2
     _START_FREEFORM
OPEN QUERY {&SELF-NAME} FOR EACH vecinos, FIRST cliente OF vecinos NO-LOCK INDEXED-REPOSITION.
     _END_FREEFORM
     _Options          = "NO-LOCK INDEXED-REPOSITION"
     _Query            is NOT OPENED
*/  /* BROWSE BROWSE-2 */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _QUERY-BLOCK FRAME F-Main
/* Query rebuild information for FRAME F-Main
     _Query            is NOT OPENED
*/  /* FRAME F-Main */
&ANALYZE-RESUME

 


/* **********************  Create OCX Containers  ********************** */

&ANALYZE-SUSPEND _CREATE-DYNAMIC

&IF "{&OPSYS}" = "WIN32":U AND "{&WINDOW-SYSTEM}" NE "TTY":U &THEN

CREATE CONTROL-FRAME Mundo ASSIGN
       FRAME           = FRAME F-Main:HANDLE
       ROW             = 3.38
       COLUMN          = 1
       HEIGHT          = 13.57
       WIDTH           = 66
       WIDGET-ID       = 10
       HIDDEN          = no
       SENSITIVE       = yes.

PROCEDURE adm-create-controls:
      Mundo:NAME = "Mundo":U .
/* Mundo OCXINFO:CREATE-CONTROL from: {8856F961-340A-11D0-A96B-00C04FD705A2} type: WebBrowser */
      Mundo:MOVE-AFTER(BROWSE-2:HANDLE IN FRAME F-Main).

END PROCEDURE.

&ENDIF

&ANALYZE-RESUME /* End of _CREATE-DYNAMIC */


/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME W-Win
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL W-Win W-Win
ON END-ERROR OF W-Win /* Mapa - Por fecha de asignacion */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL W-Win W-Win
ON WINDOW-CLOSE OF W-Win /* Mapa - Por fecha de asignacion */
DO:
    /* Modificado para que el control retorne a la window padre al cerrar una windows hija */
    DEFINE VARIABLE h_parent AS HANDLE      NO-UNDO.
    IF VALID-HANDLE(h_asignar) THEN   do:
        RUN dispatch IN h_asignar ( INPUT 'destroy':U ) . 
    END.
    h_parent = THIS-PROCEDURE:CURRENT-WINDOW:PARENT.
    APPLY "CLOSE":U TO THIS-PROCEDURE.
    IF VALID-HANDLE(h_parent) THEN DO:
        CURRENT-WINDOW = h_parent.
        APPLY 'ENTRY' TO h_parent.
    END.
    RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL W-Win W-Win
ON WINDOW-RESIZED OF W-Win /* Mapa - Por fecha de asignacion */
DO:
  muestradia( ) .
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME Basignar
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Basignar W-Win
ON CHOOSE OF Basignar IN FRAME F-Main /* Asignar */
DO:
  /*asignacion de eventos*/
DEFINE VAR tipoevento LIKE tipo_evento.nro_tipo_evento NO-UNDO.
DEFINE VAR recursos AS CHAR NO-UNDO.
DEFINE VAR fecha AS DATE NO-UNDO.
DEFINE VAR hmin AS CHAR NO-UNDO.
DEFINE VAR hmax AS CHAR NO-UNDO.
DEF VAR i AS INT NO-UNDO.

IF NOT tsinasig:INPUT-VALUE THEN DO:
    MESSAGE "Los eventos ya estan asignados" VIEW-AS ALERT-BOX ERROR.
    RETURN NO-APPLY.
END.
IF NOT AVAILABLE vecinos THEN DO:
    MESSAGE "Selecione un registro" VIEW-AS ALERT-BOX ERROR.
    RETURN NO-APPLY.
END.
EMPTY TEMP-TABLE ttasig.
DO i = 1 TO {&BROWSE-NAME}:NUM-SELECTED-ROWS IN FRAME {&FRAME-NAME}:
    {&BROWSE-NAME}:FETCH-SELECTED-ROW ( i ).
    FIND evento OF vecinos EXCLUSIVE-LOCK.
    CREATE ttasig.
    ASSIGN ttasig.rowasig = ROWID(evento).
END.
RUN  w-asignar.w (OUTPUT recursos,OUTPUT fecha,OUTPUT hmin,OUTPUT hmax, evento.nro_tipo_evento, ROWID(evento)) .

IF recursos = "" THEN DO:
        MESSAGE "No se realizo ningun cambio" VIEW-AS ALERT-BOX ERROR.
END.
FOR EACH ttasig:
    FIND evento WHERE rowid(evento) = ttasig.rowasig EXCLUSIVE-LOCK.
    ASSIGN evento.fasignado = fecha
           evento.recursos = recursos.
           IF hmax <> "" AND hmin <> "" THEN DO:
               evento.hora_desde = hmin.
               evento.hora_hasta = hmax.
               evento.duracion = INT( TRUNCATE( ( ahdec( aint( hmin ) ) - ahdec( aint( hmax ) ) ) * 60 , 0 ) ).
           END.
   /*update de las agenda de los recursos*/
    RUN recrea_agenda(evento.nro_evento).
    RELEASE evento.
    APPLY "CHOOSE" TO brefresh.
END.


END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME Bevento
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Bevento W-Win
ON CHOOSE OF Bevento IN FRAME F-Main /* Evento Relacion */
DO:
DEFINE BUFFER b-relacionado FOR evento.
  /*asignacion de eventos*/
FIND evento OF vecinos NO-LOCK.
IF NOT AVAILABLE evento THEN RETURN NO-APPLY.
/*RUN d-zoom-evento.w(evento.nro_evento,"ZOOM").*/
IF evento.origen <> "AVISO" THEN DO:
    FIND FIRST b-relacionado WHERE b-relacionado.REFevento = evento.nro_evento and NOT b-relacionado.anulado NO-LOCK NO-ERROR.
    IF NOT AVAILABLE b-relacionado THEN DO:
            MESSAGE "No hay evento relacionado" VIEW-AS ALERT-BOX INFORMATION.
            RETURN NO-APPLY.
    END.
      RUN d-zoom-evento.w ( b-relacionado.nro_evento, "Evento relacionado al " + string(evento.nro_evento) ).
END.
ELSE DO:
    FIND FIRST b-relacionado WHERE b-relacionado.nro_evento = evento.refevento and NOT b-relacionado.anulado NO-LOCK NO-ERROR.
    IF NOT AVAILABLE b-relacionado THEN DO:
            MESSAGE "No hay aviso relacionado" VIEW-AS ALERT-BOX INFORMATION.
            RETURN NO-APPLY.
    END.
      RUN d-zoom-evento.w ( b-relacionado.nro_evento, "Aviso relacionado al " + string(evento.refevento) ).
END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME Bexcel
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Bexcel W-Win
ON CHOOSE OF Bexcel IN FRAME F-Main /* bexcel */
DO:
    run excel-export (browse-2:handle).
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME Bmuestra
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Bmuestra W-Win
ON CHOOSE OF Bmuestra IN FRAME F-Main /* GeoV */
DO:
    IF bmuestra:LABEL = "Browse" THEN DO:
        chmundo:VISIBLE = false.
        browse-2:HIDDEN = FALSE.
        BMUESTRA:LABEL = "GeoV".
        bexcel:HIDDEN = FALSE.
    END.
    ELSE DO:
        chmundo:VISIBLE = TRUE.
        browse-2:HIDDEN = TRUE.
        BMUESTRA:LABEL = "Browse".
        bexcel:HIDDEN = TRUE.
    END.
    APPLY "Choose" TO brefresh.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME Borigen
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Borigen W-Win
ON CHOOSE OF Borigen IN FRAME F-Main /* Origen */
DO:
DEFINE BUFFER b-relacionado FOR evento.
DEF VAR rrowid AS ROWID NO-UNDO.
FIND b-relacionado OF vecinos NO-LOCK.
IF NOT AVAILABLE b-relacionado THEN RETURN NO-APPLY.
FIND evento WHERE evento.nro_evento = b-relacionado.refevento NO-LOCK NO-ERROR.
IF NOT AVAILABLE evento THEN RETURN NO-APPLY.
    IF evento.origen BEGINS "REMIT" THEN DO:
              FIND rem_header WHERE rem_header.nro_remito = evento.nro_identificacion NO-ERROR.
              IF NOT AVAILABLE rem_header THEN DO:
                  MESSAGE "Remito no registrato" VIEW-AS ALERT-BOX ERROR.
                  RETURN NO-APPLY.
              END.
              rrowid = ROWID(Rem_header).
              /*RUN ocultar_window.*/
              RUN c-comprobante_despacho.w ( INPUT-OUTPUT rrowid , INPUT 2, INPUT Rem_header.cdg_comprobante ).
              /*RUN mostrar_window.*/
    END.
    ELSE DO:    
        IF evento.origen = "CONTRATO" THEN DO:
              FIND contrato_hd WHERE contrato_hd.nro_contrato = evento.nro_identificacion NO-ERROR.
                  IF NOT AVAILABLE contrato_hd THEN DO:
                  MESSAGE "Cotrato no registrato" VIEW-AS ALERT-BOX ERROR.
                  RETURN NO-APPLY.
              END.
              /*RUN ocultar_window.*/
              RUN d-zoom-contrato.w ( contrato_hd.nro_contrato ).
              /*RUN mostrar_window.*/
        END.
    END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME Bprint
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Bprint W-Win
ON CHOOSE OF Bprint IN FRAME F-Main /* Print */
DO:
    IF NOT tsinasig:INPUT-VALUE THEN DO:
        IF bmuestra:LABEL = "Browse" THEN DO:
          chMundo:WebBrowser:Navigate().
          chMundo:WebBrowser:Print().
        END.
    END.
    ELSE DO:
        FIND tipo_evento WHERE tipo_evento.nro_tipo_evento = c_nro_tipo_evento:INPUT-VALUE NO-LOCK NO-ERROR.
        IF AVAILABLE tipo_evento THEN DO:
            IF tipo_evento.cdg_tipo_evento = "AV" THEN DO:
                RUN w-avisos_eventos_AV.w.
            END.
        END.
        
    END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME brefresh
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL brefresh W-Win
ON CHOOSE OF brefresh IN FRAME F-Main /* Refresh */
DO:
  DEFINE VAR v-extra AS CHAR NO-UNDO.
    MESSAGE "Un momento por favor.....".
   ASSIGN ccli .
   FIND cliente WHERE cliente.cdg_cliente = ccli NO-LOCK NO-ERROR.
   IF AVAILABLE cliente THEN DO:
       FIND provincia OF cliente.
       pxal:SCREEN-VALUE = toxAL(cliente.direccion,OUTPUT v-extra) +
                         ( IF cliente.localidad <> "" AND cliente.localidad <> ? THEN  "," + trim(cliente.localidad) ELSE "" ) +
                         ( IF cliente.localidad <> provincia.nombre THEN "," + trim(provincia.nombre) ELSE "" ).
       IF cliente.geolat = 0 THEN DO:
           MESSAGE "Cliente no georeferenciado" VIEW-AS ALERT-BOX ERROR.
           RETURN NO-APPLY.
       END.
       pgeoX = cliente.geoX.
       pgeoY = cliente.geoY.
   END.
   ELSE DO:
       pxal:SCREEN-VALUE = dirbase.
       pgeoX = baseX.
       pgeoY = baseY.
   END.
   
   RUN ttvecinos.

   IF bmuestra:LABEL = "Browse" THEN
        muestradia().
   ELSE
       {&OPEN-QUERY-{&BROWSE-NAME}}
APPLY "ITERATION-CHANGED" TO {&BROWSE-NAME}.
APPLY "value-changed" TO {&BROWSE-NAME}.
   MESSAGE "Listo".
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define BROWSE-NAME BROWSE-2
&Scoped-define SELF-NAME BROWSE-2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL BROWSE-2 W-Win
ON MOUSE-MENU-CLICK OF BROWSE-2 IN FRAME F-Main
DO:
  /*asignacion de eventos*/
FIND evento OF vecinos NO-LOCK.
IF AVAILABLE evento THEN 
    RUN d-zoom-evento.w(evento.nro_evento,"ZOOM").
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL BROWSE-2 W-Win
ON MOUSE-SELECT-DBLCLICK OF BROWSE-2 IN FRAME F-Main
DO:
  ccli:SCREEN-VALUE = cliente.cdg_cliente.
  APPLY "CHOOSE" TO brefresh.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL BROWSE-2 W-Win
ON ROW-DISPLAY OF BROWSE-2 IN FRAME F-Main
DO:
    FIND tipo_evento WHERE tipo_evento.cdg_tipo_evento = vecinos.cdg_tipo_evento NO-LOCK NO-ERROR.
    IF AVAILABLE tipo_evento THEN do:
        vecinos.cdg_tipo_evento:FGCOLOR IN BROWSE {&BROWSE-NAME} = Tipo_evento.color_letra.
        vecinos.cdg_tipo_evento:BGCOLOR = Tipo_evento.color_fondo.
    END.
    FIND tipo_evento WHERE tipo_evento.cdg_tipo_evento = vecinos.cdg_ref_tipo_evento NO-LOCK NO-ERROR.
    IF AVAILABLE tipo_evento THEN do:
        vecinos.cdg_ref_tipo_evento:FGCOLOR = Tipo_evento.color_letra.
        vecinos.cdg_ref_tipo_evento:BGCOLOR = Tipo_evento.color_fondo.
    END.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME ccli
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL ccli W-Win
ON VALUE-CHANGED OF ccli IN FRAME F-Main
DO:
  APPLY "choose" TO brefresh.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME c_nro_tipo_evento
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL c_nro_tipo_evento W-Win
ON VALUE-CHANGED OF c_nro_tipo_evento IN FRAME F-Main /* Tipo */
DO:
  ASSIGN c_nro_tipo_evento.
  FIND FIRST tipo_evento WHERE tipo_evento.nro_tipo_evento = c_nro_tipo_evento:INPUT-VALUE NO-ERROR.
       APPLY "CHoose" TO brefresh.
  END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fdes
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fdes W-Win
ON LEAVE OF fdes IN FRAME F-Main /* Fill 2 */
DO:
/*fhas:SCREEN-VALUE = fdes:SCREEN-VALUE.*/
         APPLY "CHoose" TO brefresh.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fdes W-Win
ON MOUSE-MENU-CLICK OF fdes IN FRAME F-Main /* Fill 2 */
DO:
    {selfecha.i}
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fhas
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fhas W-Win
ON LEAVE OF fhas IN FRAME F-Main /* Fill 2 */
DO:
         APPLY "CHoose" TO brefresh.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fhas W-Win
ON MOUSE-MENU-CLICK OF fhas IN FRAME F-Main /* Fill 2 */
DO:
    {selfecha.i}
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME Tsinasig
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Tsinasig W-Win
ON VALUE-CHANGED OF Tsinasig IN FRAME F-Main /* Sin Asignar */
DO:
   APPLY "CHoose" TO brefresh.
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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE adm-row-available W-Win 
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

OCXFile = SEARCH( "w-geoeventos.wrx":U ).
IF OCXFile = ? THEN
  OCXFile = SEARCH(SUBSTRING(THIS-PROCEDURE:FILE-NAME, 1,
                     R-INDEX(THIS-PROCEDURE:FILE-NAME, ".":U), "CHARACTER":U) + "wrx":U).

IF OCXFile <> ? THEN
DO:
  ASSIGN
    chMundo = Mundo:COM-HANDLE
    UIB_S = chMundo:LoadControls( OCXFile, "Mundo":U)
  .
  RUN DISPATCH IN THIS-PROCEDURE("initialize-controls":U) NO-ERROR.
END.
ELSE MESSAGE "w-geoeventos.wrx":U SKIP(1)
             "The binary control file could not be found. The controls cannot be loaded."
             VIEW-AS ALERT-BOX TITLE "Controls Not Loaded".

&ENDIF

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
  DISPLAY fdes fhas c_nro_tipo_evento Tsinasig ccli pxal 
      WITH FRAME F-Main IN WINDOW W-Win.
  ENABLE fhas c_nro_tipo_evento Bprint brefresh Bmuestra Basignar Bexcel 
         Tsinasig Borigen Bevento ccli pxal BROWSE-2 
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
DEFINE VAR lista AS CHAR NO-UNDO.
DEFINE VAR baselat AS DECIMAL.
DEFINE VAR baselong AS DECIMAL.
{findempresa.i}
  /* Code placed here will execute PRIOR to standard behavior. */
  DO WITH FRAME {&FRAME-NAME}:
     {levantacombo.i &TABLA=Tipo_evento &NOMBRE=cdg_tipo_evento &CODIGO=nro_tipo_evento &OBJETO=c_nro_tipo_evento}
  END. 
RUN geocoding( dirbase,OUTPUT baselat,OUTPUT baselong).
baseX = X(baselat,baselong).
baseY = Y(baselat,baselong).
pgeoX = baseX.
pgeoY = baseY.
    /* Dispatch standard ADM method.                             */
  RUN dispatch IN THIS-PROCEDURE ( INPUT 'initialize':U ) .

  /* Code placed here will execute AFTER standard behavior.    */

/*fdes = 02/01/2010.*/
/*fdes:SCREEN-VALUE = string(TODAY).*/
fhas:SCREEN-VALUE = string(TODAY).
chmundo:VISIBLE = false.
browse-2:HIDDEN = FALSE.
BMUESTRA:LABEL = "GeoV".
bexcel:HIDDEN = FALSE.
ccli:SCREEN-VALUE = "BASE".
/*run ttvecinos.*/
muestradia().
APPLY "CHoose" TO brefresh.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE moviendo W-Win 
PROCEDURE moviendo :
/*------------------------------------------------------------------------------
  Purpose:  mueve las asignaciones de los eventos seleccionado a la fecha del parametro  
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEFINE INPUT PARAMETER  fechad AS DATE.
DEF VAR i AS INT NO-UNDO.
DEFINE BUFFER bevento FOR evento.
DEFINE BUFFER baevento FOR evento.
DEFINE VAR nro_tipo_evento_aviso LIKE evento.nro_tipo_evento.
DEFINE VAR eve-rela AS CHAR no-undo.
DEFINE VAR fasigevsigue AS DATE NO-UNDO.
DEFINE VAR opt AS LOGICAL NO-UNDO.


FIND tipo_evento WHERE tipo_evento.cdg_tipo_evento = "AV" NO-LOCK.
nro_tipo_evento_aviso = tipo_evento.nro_tipo_evento.

DO i = 1 TO {&BROWSE-NAME}:NUM-SELECTED-ROWS IN FRAME {&FRAME-NAME} TRANSACTION:
    {&BROWSE-NAME}:FETCH-SELECTED-ROW ( i ).
    FIND evento OF vecinos EXCLUSIVE-LOCK.
    eve-rela = "".
    FOR EACH bevento WHERE bevento.RefEvento = evento.nro_evento AND
        NOT bevento.anulado NO-LOCK:
        IF avisoentregado(bevento.nro_evento) OR bevento.bloqueado OR bevento.frealizado <> ? THEN
        eve-rela = eve-rela + STRING(bevento.nro_evento,">>>>>>>>9").
    END.
    FOR EACH bevento WHERE bevento.evsigue = evento.nro_evento AND
        NOT bevento.anulado NO-LOCK:
        IF avisoentregado(bevento.nro_evento) OR bevento.bloqueado OR bevento.frealizado <> ? THEN
        eve-rela = eve-rela + STRING(bevento.nro_evento,">>>>>>>>9").
    END.

    IF evento.evsigue <> 0 THEN DO:
            FIND bevento WHERE bevento.nro_evento = evento.evsigue and
                NOT bevento.anulado and
                ( avisoentregado(bevento.nro_evento) OR bevento.bloqueado OR bevento.frealizado <> ? ) NO-LOCK NO-ERROR.
            IF AVAILABLE bevento THEN
                eve-rela = eve-rela + STRING(evento.evsigue,">>>>>>>>9").
    END.
    eve-rela = SUBSTRING(eve-rela,2). 
    IF num-entries(eve-rela) > 0  THEN DO:
      MESSAGE "El evento " evento.nro_evento " posee los siguientes eventos relacionados" SKIP
              eve-rela SKIP
              "con acciones en curso o acciones relacionadas ya ejecutadas" skip
              "que deben realizarse nuevamente y no puede ser modificado" skip
              "hasta que no resuelva las mismas" VIEW-AS ALERT-BOX ERROR.
       undo , RETURN ERROR.
    END.    
    
    fasigevsigue=?.
    eve-rela = "".
    FOR EACH bevento WHERE bevento.evsigue = evento.nro_evento AND
        bevento.fasignado = evento.fasignado AND
        bevento.frealizado = ? AND
        NOT bevento.anulado NO-LOCK:
        eve-rela = eve-rela + STRING(bevento.nro_evento,">>>>>>>>9").
    END.
    IF evento.evsigue <> 0 THEN DO:
        FIND bevento WHERE bevento.nro_evento = evento.evsigue and
            NOT bevento.anulado and
            ( avisoentregado(bevento.nro_evento) OR bevento.bloqueado OR bevento.frealizado <> ? ) NO-LOCK NO-ERROR.
            IF AVAILABLE bevento THEN
                eve-rela = eve-rela + STRING(evento.evsigue,">>>>>>>>9").
    END.
    eve-rela = SUBSTRING(eve-rela,2). 
    IF num-entries(eve-rela) > 0  THEN DO:
      MESSAGE "La modificacion del evento " evento.nro_evento " arrastra cambios en el/los evento" SKIP
              eve-rela SKIP
              "Se asignaran en la misma fecha, modificando ambos eventos"
              VIEW-AS ALERT-BOX QUESTION BUTTON YES-NO SET opt.
      IF NOT opt  THEN RETURN ERROR.
      fasigevsigue = evento.fasignado.
    END.
    
    IF NOT evento.anulado AND 
        evento.frealizado = ? AND
        evento.fasignado <> ? THEN DO:
        FIND CURRENT evento EXCLUSIVE-LOCK.
        IF evento.nro_tipo_evento = nro_tipo_evento_aviso THEN DO:
            FOR EACH recurso_agenda WHERE recurso_agenda.nro_evento = evento.nro_evento:
                DELETE recurso_agenda.
            END.
            ASSIGN evento.recursos = ""
                   evento.fasignado = ?.
        END.
        ELSE
            ASSIGN evento.fasignado = fechad.
        /*borrar los avisos*/
        FOR EACH bevento WHERE bevento.refevento = evento.nro_evento:
            DELETE bevento.
        END.
        RUN recrea_agenda (evento.nro_evento).

        /*reasignar los eventos relacionados*/
        FOR EACH bevento WHERE bevento.evsigue = evento.nro_evento AND
                bevento.fasignado = fasigevsigue AND
                bevento.frealizado = ? AND
                NOT bevento.anulado:
                bevento.fasignado = evento.fasignado.
                RUN recrea_agenda (bevento.nro_evento).
        
                /*ver si tenia a su vez un aviso*/
                FOR EACH baevento WHERE bevento.refevento = baevento.nro_evento:
                    RUN recrea_agenda (baevento.nro_evento).
                END.
        END.
        IF evento.evsigue <> 0 THEN DO:
                FIND bevento WHERE bevento.nro_evento = evento.evsigue and
                     NOT bevento.anulado and
                     ( avisoentregado(bevento.nro_evento) OR bevento.bloqueado OR bevento.frealizado <> ?) NO-ERROR.
                IF AVAILABLE bevento THEN DO:
                  bevento.fasignado = evento.fasignado.
                /*ver si tenia a su vez un aviso*/
                 RUN recrea_agenda (bevento.nro_evento).
                 FOR EACH baevento WHERE bevento.refevento = baevento.nro_evento:
                     RUN recrea_agenda (baevento.nro_evento).
                 END.
                END.
        END.
    END.
    RELEASE evento.
END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE recrea_agenda W-Win 
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

    DO i = 1 TO NUM-ENTRIES(recevento.recursos):
          FIND recurso_agenda WHERE recurso_agenda.cdg_recurso = ENTRY(i,recevento.recurso) AND
              recurso_agenda.nro_evento = recevento.nro_evento NO-ERROR.
          IF NOT AVAILABLE recurso_agenda THEN DO:
              CREATE recurso_agenda.
              ASSIGN recurso_agenda.cdg_recurso = ENTRY(i,recevento.recurso)
                     recurso_agenda.nro_evento = recevento.nro_evento.
          END.
          ASSIGN  recurso_agenda.fecha = recevento.fasignado.
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
  {src/adm/template/snd-list.i "vecinos"}
  {src/adm/template/snd-list.i "cliente"}

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
  Purpose:   crea la tabla de vecinos  
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
    EMPTY TEMP-TABLE vecinos.
    DEFINE BUFFER bevento FOR evento.
    DEFINE BUFFER btipo_evento FOR tipo_evento.
    
    ASSIGN FRAME {&FRAME-NAME} c_nro_tipo_evento  /*fdes*/ fhas tsinasig.
IF NOT tsinasig THEN DO:
    FOR EACH evento NO-LOCK WHERE
         ( evento.nro_tipo_evento = c_nro_tipo_evento OR c_nro_tipo_evento = 0 ) and
         evento.evaluar AND
        NOT evento.anulado AND
         /* can-do(corigen,evento.origen) AND */
         /*evento.fasignado >= fdes AND*/
         evento.fasignado <= fhas:
             FIND tipo_evento OF evento NO-LOCK.
             FIND cliente OF evento NO-LOCK NO-ERROR.
             IF NOT AVAILABLE cliente THEN DO:
                MESSAGE "Para evento " evento.nro_evento " no se encuentra el cliente" VIEW-AS ALERT-BOX ERROR.
                NEXT.
             END.
             CREATE vecinos.
             BUFFER-COPY evento TO vecinos.
                 ASSIGN vecinos.distancia = distgeodesicaUTM( pgeoX , pgeoY , cliente.geoX , cliente.geoY )
                        vecinos.cdg_tipo_evento = tipo_evento.cdg_tipo_evento
                        vecinos.adicional = ENTRY( 3 , Evento.Observaciones, "|" ) NO-ERROR.
             IF evento.refevento <> 0  THEN DO:
                  FIND bevento WHERE bevento.nro_evento = evento.refevento NO-LOCK NO-ERROR.
                  IF AVAILABLE bevento THEN DO:
                      FIND btipo_evento OF bevento NO-LOCK.
                      vecinos.cdg_ref_tipo_evento = btipo_evento.cdg_tipo_evento.
                  END.
             END.
    END.
END.
ELSE DO:
    FOR EACH evento NO-LOCK WHERE
         ( evento.nro_tipo_evento = c_nro_tipo_evento OR c_nro_tipo_evento = 0 ) and
         NOT evento.anulado AND
         evento.evaluar AND
         evento.fasignado = ? AND evento.frealizado = ? AND
         NOT evento.fmin > fhas /*AND NOT evento.fmax < fdes */:
         FIND tipo_evento OF evento NO-LOCK.
         FIND cliente OF evento NO-LOCK NO-ERROR.
         IF NOT AVAILABLE cliente THEN DO:
                MESSAGE "Para evento " evento.nro_evento " no se encuentra el cliente" VIEW-AS ALERT-BOX ERROR.
                NEXT.
         END.
         CREATE vecinos.
         BUFFER-COPY evento TO vecinos
         ASSIGN vecinos.distancia = distgeodesicaUTM( pgeoX , pgeoY , cliente.geoX , cliente.geoY )
                vecinos.cdg_tipo_evento = tipo_evento.cdg_tipo_evento
             vecinos.adicional = ENTRY( 3 , Evento.Observaciones, "|" ) NO-ERROR.
         IF evento.refevento <> 0  THEN DO:

            FIND bevento WHERE bevento.nro_evento = evento.refevento NO-LOCK NO-ERROR.
            IF AVAILABLE bevento THEN DO:
                      FIND btipo_evento OF bevento NO-LOCK.
                      vecinos.cdg_ref_tipo_evento = btipo_evento.cdg_tipo_evento.
            END.
         END.
    END.
END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

/* ************************  Function Implementations ***************** */

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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION genehtml W-Win 
FUNCTION genehtml RETURNS CHARACTER
  (  ) :
/*------------------------------------------------------------------------------
  Purpose:  Genera el html para googlemaps
    Notes: aplicque CSS para maquetear la frame
------------------------------------------------------------------------------*/
def var archivo as char no-undo.
DEFINE VAR sistema AS CHAR NO-UNDO.
DEFINE VAR ancho AS INT NO-UNDO.
DEFINE VAR alto AS INT NO-UNDO.
DEFINE VAR fr AS WIDGET-HANDLE NO-UNDO.
DEFINE VAR i AS INT NO-UNDO.
DEFINE VAR almenos AS LOGICAL NO-UNDO.
DEFINE VAR colores AS CHAR INITIAL "red,blue" NO-UNDO.
DEFINE VAR kk AS INT NO-UNDO.
fr = FRAME F-Main:HANDLE.
ancho = w-win:WIDTH-PIXELS.
alto = w-win:HEIGHT-PIXELS.
IF fr:WIDTH-PIXELS < ancho OR fr:HEIGHT-PIXELS < alto THEN DO:
    fr:WIDTH-PIXELS = ancho.
    fr:HEIGHT-PIXELS = alto.
END.
chMundo:WIDTH = ancho.
chMundo:HEIGHT = alto - 70 .
fr:WIDTH-PIXELS = ancho .
fr:HEIGHT-PIXELS = alto .
almenos = FALSE.
FOR FIRST vecinos:
    almenos = TRUE.
END.
IF NOT almenos THEN DO:
  FILE-INFO:FILE-NAME = search("nogeo.htm").
  RETURN FILE-INFO:FULL-PATHNAME.
END.
MESSAGE "Generando archivo .....".
archivo = SESSION:TEMP-DIR + STRING( USERID("sic") ) + ".htm".
sistema = SESSION:NUMERIC-FORMAT.
SESSION:NUMERIC-FORMAT= "American".
output to value(archivo).
put UNFORMATTED '<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"' skip
    '"http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">' skip
    '<html xmlns="http://www.w3.org/1999/xhtml">' skip
    '<head>' skip
    '<meta http-equiv="X-UA-Compatible" content="IE=edge" charset=utf-8/>'  skip
    '<title>Google Maps JavaScript API Example</title>' skip
    '<script src="https://maps.google.com/maps?file=api&amp;v=3&amp;key=AIzaSyDWJAlUHjKWv4cB1O2QKRt1JI-khfVvy4s"' skip
    'type="text/javascript"></script>' skip
    '<script type="text/javascript">' skip
    '//<![CDATA[' skip
    'function load() ~{' skip
    'if (GBrowserIsCompatible()) ~{' skip
    'var map = new GMap2(document.getElementById("map"));' skip.
almenos = FALSE.

FOR EACH vecinos  BY vecinos.distancia:
        FIND cliente OF vecinos NO-LOCK.
        FIND cliente_otros_datos OF cliente NO-LOCK NO-ERROR.
        FOR EACH evento OF cliente WHERE evento.nro_tipo_evento = vecinos.nro_tipo_evento 
                BY evento.frealizado DESC:
            LEAVE.
        END.
        IF cliente.geolat <> 0 THEN DO:
            IF NOT almenos THEN DO:
                PUT UNFORMATTED
                'map.setCenter(new GLatLng(' cliente.geolat ',' cliente.geolong '), 15);' skip
                'map.addControl(new GSmallMapControl());' SKIP
                'var customIcons = [];' SKIP.
                DO kk = 1 TO 7:
                    IF kk > NUM-ENTRIES(colores) THEN LEAVE.
                    PUT UNFORMATTED
                    'var icon' entry(kk,colores) ' = new GIcon(); ' SKIP
                    'icon' entry(kk,colores) ".image = 'http://labs.google.com/ridefinder/images/mm_20_" entry(kk,colores) ".png';" SKIP
                    'icon' entry(kk,colores) ".shadow = 'http://labs.google.com/ridefinder/images/mm_20_shadow.png';" SKIP
                    'icon' entry(kk,colores) '.iconSize = new GSize(12, 20);' SKIP
                    'icon' entry(kk,colores) '.shadowSize = new GSize(22, 20);' SKIP
                    'icon' entry(kk,colores) '.iconAnchor = new GPoint(6, 20);' SKIP
                    'icon' entry(kk,colores) '.infoWindowAnchor = new GPoint(5, 1);' SKIP
                    'customIcons["' string(kk) '"] = icon' entry(kk,colores) ';' SKIP.
                END.
                PUT UNFORMATTED
                'function createMarker(point, nombre,origen) ' '~{' SKIP
                'var marker = new GMarker(point,customIcons[origen]);' SKIP
                "GEvent.addListener(marker, 'click', function()" '~{' SKIP
                'marker.openInfoWindowHtml(nombre);' '~}' ');' SKIP
                'return marker;' SKIP
                '~}' SKIP.
                almenos = TRUE.
            END.
            PUT UNFORMATTED
            'var point = new GPoint (' cliente.geolong ',' cliente.geolat ' );' skip
            'map.addOverlay(createMarker (point,"' Cliente.nom_cliente 
                '<BR>Dir:' cliente.direccion
                '<BR>Origen:' vecinos.origen 
                '<BR>Evento:' vecinos.nro_evento 
                '<BR>Operario:' vecinos.recursos
                '<BR>Anterior:' ( IF AVAILABLE evento THEN string(Evento.hora_desde) + ":" + string(Evento.hora_hasta) ELSE "NO DISPONIBLE" )  
                '<BR>Rdur:' rdur(vecinos.nro_evento)
                '<BR>Unidades:' ( IF AVAILABLE cliente_otros_datos THEN  string(cliente_otros_datos.unidades) ELSE "NO DISPONIBLE" )
                '<BR>Asignado:' vecinos.fasignado ' ' vecinos.turno 
                '<BR>Distancia:' int(vecinos.distancia) 
                 '","' (IF ccli = cliente.cdg_cliente THEN "1" ELSE "2" ) '"));' skip.
        END.
END.

PUT UNFORMATTED 
    '~}' skip
    '~}' skip
    '//]]>' skip
    '</script>' skip
    '</head>' skip
    '<body onload="load()" onunload="GUnload()">' skip
    '<div id="map" style="width:' + string( ancho - 20 ) + 'px;height:' + string( alto - 2 ) + 'px;position:absolute; top: 0px; left:0px;"></div>' skip
    '</body>' skip
    '</html>' skip(1).
OUTPUT CLOSE.
MESSAGE "Listo".
SESSION:NUMERIC-FORMAT= sistema.
  RETURN archivo.   /* Function return value. */

END FUNCTION.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION muestradia W-Win 
FUNCTION muestradia RETURNS LOGICAL
  ( ) :
/*------------------------------------------------------------------------------
  Purpose:  
    Notes:  
------------------------------------------------------------------------------*/
 
chMundo:WebBrowser:Navigate( genehtml( ) ).
  w-win:WINDOW-STATE = 3.
  w-win:MOVE-TO-TOP().
  RETURN  true.   /* Function return value. */

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
DEFINE BUFFER bevento FOR evento.
DEFINE BUFFER weve FOR evento.
DEFINE VAR pp AS INTEGER INITIAL 5.
pp1 = 0.
suma = 0.
FIND weve WHERE weve.nro_evento = rr NO-LOCK.
IF weve.origen = "CONTRATO" THEN DO:
    FOR EACH bevento NO-LOCK WHERE bevento.origen = weve.origen AND 
        bevento.nro_identificacion = weve.nro_identificacion AND
        bevento.sub_evento = weve.sub_evento AND
        NOT bevento.anulado AND bevento.frealizado<>? BY bevento.fasignado DESCENDING :
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
ELSE  RETURN ?.
END FUNCTION.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

