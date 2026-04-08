&ANALYZE-SUSPEND _VERSION-NUMBER UIB_v8r12 GUI ADM1
&ANALYZE-RESUME
/* Connected Databases 
*/
&Scoped-define WINDOW-NAME W-Win
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _DEFINITIONS W-Win 
/*********************************************************************
* Copyright (C) 2000 by Progress Software Corporation. All rights    *
* reserved. Prior versions of this work may contain portions         *
* contributed by participants of Possenet.                           *
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
{findempresa.i}
   {VRSHARED.I NEW} 
    DEFINE TEMP-TABLE ex NO-UNDO
    FIELD certif AS INT COLUMN-LABEL "Oblea"
    FIELD correcto AS LOGICAL FORMAT "Si/No" COLUMN-LABEL " CORRECTO "
    FIELD tipo AS char COLUMN-LABEL "Tipo"
    FIELD fecha AS date COLUMN-LABEL "Fecha"
    FIELD direccion LIKE cliente.direccion LABEL "Original"
    FIELD alx LIKE cliente.direccion LABEL "ALX"
    FIELD URL AS CHAR FORMAT "X(15)" 
    FIELD nro_cliente LIKE cliente.nro_cliente
    FIELD nro_evento LIKE evento.nro_evento
    FIELD geolat LIKE cliente.geolat
    FIELD geolong LIKE cliente.geolong
    FIELD numero AS INT.


DEFINE TEMP-TABLE ev 
    FIELD lote LIKE sic.Evento.Lote
    FIELD nro_cliente LIKE cliente.nro_cliente
    FIELD nro_evento LIKE evento.nro_evento FORMAT ">>>>>>>9":U
    FIELD frealizado LIKE  Evento.FRealizado FORMAT "99/99/9999":U
    FIELD cdg_tipo_evento LIKE Tipo_evento.cdg_tipo_evento FORMAT "X(4)":U
    FIELD direccion LIKE Cliente.direccion FORMAT "X(45)":U
    FIELD origen LIKE evento.Origen FORMAT "X(15)":U
    FIELD nro_identificacion LIKE Evento.nro_identificacion FORMAT ">>>>>>>9":U
    FIELD unidades AS INT COLUMN-LABEL "UND"
    FIELD Hdesde AS CHAR
    FIELD tanques AS INT COLUMN-LABEL "TNQ"
    FIELD nom_cliente LIKE cliente.nom_cliente
    FIELD numero AS INT
    FIELD nom_recurso LIKE Recurso.nom_recurso EXTENT 3
    FIELD cuil LIKE sic.Recurso.CUIL EXTENT 3
    FIELD cdg_articulo LIKE articulo.cdg_articulo FORMAT "X(5)" COLUMN-LABEL "ARTIC"
    INDEX idx1 nro_evento.

{geoLibrary.i}
DEFINE TEMP-TABLE ott LIKE internal-ttgeo.
DEFINE VAR rowtt AS INT.
DEFINE VAR dbl AS LOGICAL.

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
&Scoped-define INTERNAL-TABLES ev ex

/* Definitions for BROWSE BROWSE-2                                      */
&Scoped-define FIELDS-IN-QUERY-BROWSE-2 ev.lote ev.FRealizado ev.cdg_tipo_evento ev.nro_evento ev.direccion ev.Origen ev.hdesde cdg_articulo ev.tanques ev.nom_cliente ev.nom_recurso[1] ev.cuil[1] ev.nom_recurso[2] ev.cuil[2] ev.nom_recurso[3] ev.cuil[3]   
&Scoped-define ENABLED-FIELDS-IN-QUERY-BROWSE-2   
&Scoped-define SELF-NAME BROWSE-2
&Scoped-define OPEN-QUERY-BROWSE-2          IF NOT dbl THEN OPEN QUERY {&SELF-NAME} FOR EACH ev NO-LOCK     BY ev.lote BY Ev.FRealizado INDEXED-REPOSITION. ELSE OPEN QUERY {&SELF-NAME} FOR EACH ev NO-LOCK WHERE ev.numero =         ex.numero         BY ev.lote BY Ev.FRealizado INDEXED-REPOSITION.
&Scoped-define TABLES-IN-QUERY-BROWSE-2 ev
&Scoped-define FIRST-TABLE-IN-QUERY-BROWSE-2 ev


/* Definitions for BROWSE BROWSE-4                                      */
&Scoped-define FIELDS-IN-QUERY-BROWSE-4 ex.certif ex.correcto ex.nro_evento ex.tipo ex.fecha ex.direccion ex.alx ex.URL ex.geolat ex.geolong   
&Scoped-define ENABLED-FIELDS-IN-QUERY-BROWSE-4   
&Scoped-define SELF-NAME BROWSE-4
&Scoped-define QUERY-STRING-BROWSE-4 FOR EACH ex
&Scoped-define OPEN-QUERY-BROWSE-4 OPEN QUERY {&SELF-NAME} FOR EACH ex.
&Scoped-define TABLES-IN-QUERY-BROWSE-4 ex
&Scoped-define FIRST-TABLE-IN-QUERY-BROWSE-4 ex


/* Definitions for FRAME F-Main                                         */
&Scoped-define OPEN-BROWSERS-IN-QUERY-F-Main ~
    ~{&OPEN-QUERY-BROWSE-2}~
    ~{&OPEN-QUERY-BROWSE-4}

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS BUTTON-15 BUTTON-13 TLT TFU BROWSE-2 ~
BUTTON-14 BROWSE-4 
&Scoped-Define DISPLAYED-OBJECTS TLT TFU 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME


/* ************************  Function Prototypes ********************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION-FORWARD numero W-Win 
FUNCTION numero RETURNS INTEGER
  ( d AS CHAR )  FORWARD.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


/* ***********************  Control Definitions  ********************** */

/* Define the widget handle for the window                              */
DEFINE VAR W-Win AS WIDGET-HANDLE NO-UNDO.

/* Definitions of handles for OCX Containers                            */
DEFINE VARIABLE ProgressBar-1 AS WIDGET-HANDLE NO-UNDO.
DEFINE VARIABLE chProgressBar-1 AS COMPONENT-HANDLE NO-UNDO.

/* Definitions of the field level widgets                               */
DEFINE BUTTON bElije 
     LABEL "Elije" 
     SIZE 9 BY 10.95.

DEFINE BUTTON BUTTON-13 
     IMAGE-UP FILE "excel.gif":U
     LABEL "Button 13" 
     SIZE 6 BY 1.14.

DEFINE BUTTON BUTTON-14 
     IMAGE-UP FILE "excel.gif":U
     LABEL "Button 14" 
     SIZE 6 BY 1.14.

DEFINE BUTTON BUTTON-15 
     IMAGE-UP FILE "iconos24/arrow_down_blue.jpg":U
     LABEL "Button 15" 
     SIZE 6 BY 1.43.

DEFINE VARIABLE TFU AS LOGICAL INITIAL yes 
     LABEL "Fumigaciones" 
     VIEW-AS TOGGLE-BOX
     SIZE 21 BY .81 NO-UNDO.

DEFINE VARIABLE TLT AS LOGICAL INITIAL yes 
     LABEL "Limpieza de tanques" 
     VIEW-AS TOGGLE-BOX
     SIZE 32 BY .81 NO-UNDO.

/* Query definitions                                                    */
&ANALYZE-SUSPEND
DEFINE QUERY BROWSE-2 FOR 
      ev SCROLLING.

DEFINE QUERY BROWSE-4 FOR 
      ex SCROLLING.
&ANALYZE-RESUME

/* Browse definitions                                                   */
DEFINE BROWSE BROWSE-2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS BROWSE-2 W-Win _FREEFORM
  QUERY BROWSE-2 NO-LOCK DISPLAY
      ev.lote COLUMN-LABEL "Lote" FORMAT ">>>>>9"      
      ev.FRealizado FORMAT "99/99/99" COLUMN-LABEL "Realizado"
      ev.cdg_tipo_evento COLUMN-LABEL "TE"
      ev.nro_evento 
      ev.direccion
      ev.Origen FORMAT "XX" COLUMN-LABEL "ORI"
      ev.hdesde COLUMN-LABEL "HDesde" FORMAT "x(5)"
      cdg_articulo 
      ev.tanques FORMAT ">9"
      ev.nom_cliente
      ev.nom_recurso[1]
      ev.cuil[1] FORMAT "X(15)"
      ev.nom_recurso[2]
      ev.cuil[2] FORMAT "X(15)"
      ev.nom_recurso[3]
      ev.cuil[3] FORMAT "X(15)"
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ROW-MARKERS SEPARATORS SIZE 209.4 BY 10.95 FIT-LAST-COLUMN.

DEFINE BROWSE BROWSE-4
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS BROWSE-4 W-Win _FREEFORM
  QUERY BROWSE-4 DISPLAY
      ex.certif 
    ex.correcto FORMAT "S/N" COLUMN-LABEL "CO"
    ex.nro_evento
    ex.tipo 
    ex.fecha 
    ex.direccion COLUMN-LABEL "MCBA DIRECCION"
    ex.alx COLUMN-LABEL "Google Direccion"
    ex.URL
    ex.geolat
    ex.geolong
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ROW-MARKERS SEPARATORS DROP-TARGET SIZE 209.6 BY 8.48 FIT-LAST-COLUMN.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME F-Main
     BUTTON-15 AT ROW 1.1 COL 77 WIDGET-ID 14
     BUTTON-13 AT ROW 1.24 COL 4 WIDGET-ID 10
     TLT AT ROW 1.38 COL 35.6 WIDGET-ID 8
     TFU AT ROW 1.48 COL 14 WIDGET-ID 6
     BROWSE-2 AT ROW 2.62 COL 3.6 WIDGET-ID 200
     bElije AT ROW 2.67 COL 214 WIDGET-ID 60
     BUTTON-14 AT ROW 13.76 COL 3.4 WIDGET-ID 12
     BROWSE-4 AT ROW 15.14 COL 3.4 WIDGET-ID 300
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 223.8 BY 23.43 WIDGET-ID 100.


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
         TITLE              = "Eventos sin Obleas MCBA"
         HEIGHT             = 23.43
         WIDTH              = 224.4
         MAX-HEIGHT         = 49.1
         MAX-WIDTH          = 336
         VIRTUAL-HEIGHT     = 49.1
         VIRTUAL-WIDTH      = 336
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
/* BROWSE-TAB BROWSE-2 TFU F-Main */
/* BROWSE-TAB BROWSE-4 BUTTON-14 F-Main */
/* SETTINGS FOR BUTTON bElije IN FRAME F-Main
   NO-ENABLE                                                            */
ASSIGN 
       BROWSE-4:COLUMN-RESIZABLE IN FRAME F-Main       = TRUE.

IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(W-Win)
THEN W-Win:HIDDEN = yes.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME


/* Setting information for Queries and Browse Widgets fields            */

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE BROWSE-2
/* Query rebuild information for BROWSE BROWSE-2
     _START_FREEFORM

        IF NOT dbl THEN
OPEN QUERY {&SELF-NAME} FOR EACH ev NO-LOCK
    BY ev.lote BY Ev.FRealizado INDEXED-REPOSITION.
ELSE
OPEN QUERY {&SELF-NAME} FOR EACH ev NO-LOCK WHERE ev.numero =
        ex.numero
        BY ev.lote BY Ev.FRealizado INDEXED-REPOSITION.
     _END_FREEFORM
     _Options          = "NO-LOCK INDEXED-REPOSITION"
     _TblOptList       = ",,"
     _OrdList          = "sic.Evento.FRealizado|yes"
     _Where[1]         = "evento.nro_certif = 0 and evento.origen = ""contrato"" AND evento.frealizado >= 01/01/2015 
and  pva( evento.nro_identificacion , evento.sub_evento ) and ( (tfu:checked and evento.nro_tipo_evento = 1 ) OR (tlt:checked and evento.nro_tipo_evento = 3 )) AND
      NOT evento.anulado  "
     _Query            is OPENED
*/  /* BROWSE BROWSE-2 */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE BROWSE-4
/* Query rebuild information for BROWSE BROWSE-4
     _START_FREEFORM
OPEN QUERY {&SELF-NAME} FOR EACH ex.
     _END_FREEFORM
     _Query            is OPENED
*/  /* BROWSE BROWSE-4 */
&ANALYZE-RESUME

 


/* **********************  Create OCX Containers  ********************** */

&ANALYZE-SUSPEND _CREATE-DYNAMIC

&IF "{&OPSYS}" = "WIN32":U AND "{&WINDOW-SYSTEM}" NE "TTY":U &THEN

CREATE CONTROL-FRAME ProgressBar-1 ASSIGN
       FRAME           = FRAME F-Main:HANDLE
       ROW             = 13.95
       COLUMN          = 12
       HEIGHT          = .71
       WIDTH           = 201
       WIDGET-ID       = 58
       HIDDEN          = no
       SENSITIVE       = yes.

PROCEDURE adm-create-controls:
      ProgressBar-1:NAME = "ProgressBar-1":U .
/* ProgressBar-1 OCXINFO:CREATE-CONTROL from: {4A5E5E35-91F4-46B1-B62F-78148132EF93} type: XP_ProgressBar */
      ProgressBar-1:MOVE-AFTER(BUTTON-14:HANDLE IN FRAME F-Main).

END PROCEDURE.

&ENDIF

&ANALYZE-RESUME /* End of _CREATE-DYNAMIC */


/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME W-Win
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL W-Win W-Win
ON END-ERROR OF W-Win /* Eventos sin Obleas MCBA */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL W-Win W-Win
ON WINDOW-CLOSE OF W-Win /* Eventos sin Obleas MCBA */
DO:
  /* This ADM code must be left here in order for the SmartWindow
     and its descendents to terminate properly on exit. */
  APPLY "CLOSE":U TO THIS-PROCEDURE.
  RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bElije
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bElije W-Win
ON CHOOSE OF bElije IN FRAME F-Main /* Elije */
DO:
  DEFINE BUFFER bevento FOR evento.
  FIND evento WHERE evento.nro_evento = ev.nro_evento.
        ex.nro_evento = evento.nro_evento.
        evento.nro_certif = int( ex.certif ).
        evento.letraprefijo = "ELE".
        ex.correcto = TRUE.
        evento.url1 = ex.URL.
        evento.url2 = ex.direccion.
        OUTPUT TO "c:\dynasys10\logs\MCBA-OBLEAS.LOG" APPEND.
        PUT NOW evento.nro_evento " " ex.certif " " ex.URL SKIP.
        FOR EACH bevento WHERE bevento.nro_cliente = evento.nro_cliente AND
        bevento.origen = evento.origen AND
        bevento.periodo = evento.periodo AND NOT bevento.anulado AND bevento.nro_identificacion = 
        evento.nro_identificacion AND bevento.frealizado <> ? AND 
        bevento.sub_evento < evento.sub_evento:
        bevento.nro_certif = int( ex.certif ).
        bevento.letraprefijo = "ELE".
        PUT NOW bevento.nro_evento " " ex.certif " " ex.URL SKIP.
        END.
        OUTPUT CLOSE.
        dbl = FALSE.
        belije:SENSITIVE IN FRAME {&FRAME-NAME} = FALSE.
        BROWSE browse-4:REFRESH().
        {&OPEN-QUERY-BROWSE-2}
        
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define BROWSE-NAME BROWSE-4
&Scoped-define SELF-NAME BROWSE-4
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL BROWSE-4 W-Win
ON DROP-FILE-NOTIFY OF BROWSE-4 IN FRAME F-Main
DO:
    DEF VAR i AS INT no-undo.
  DEF VAR listarch AS CHAR NO-UNDO.
  REPEAT i = 1 TO self:NUM-DROPPED-FILES:
      /*falta ver si son directorios los que se ingresaron*/
      FILE-INFO:FILE-NAME = SELF:GET-DROPPED-FILE(i).
      RUN procxls(FILE-INFO:FILE-NAME).
  END.
  self:END-FILE-DROP() .
  RUN dispatch IN THIS-PROCEDURE ( INPUT 'display-fields':U ) .
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL BROWSE-4 W-Win
ON MOUSE-SELECT-DBLCLICK OF BROWSE-4 IN FRAME F-Main
DO:
  DEFINE VAR k AS INT NO-UNDO.
  DEFINE VAR pnro AS INT NO-UNDO.
  DEFINE BUFFER bevento FOR evento.
  /*
  RUN d-asignaoblea.w( numero(ex.direccion), OUTPUT pnro).
  IF pnro <> ?  THEN DO:
        FIND evento WHERE evento.nro_evento = pnro.
        ex.nro_evento = evento.nro_evento.
        evento.nro_certif = int( ex.certif ).
        evento.letraprefijo = "ELE".
        ex.correcto = TRUE.
        evento.url1 = ex.URL.
        evento.url2 = ex.direccion.
        OUTPUT TO "c:\dynasys10\logs\MCBA-OBLEAS.LOG" APPEND.
        PUT NOW evento.nro_evento " " ex.certif " " ex.URL SKIP.
        FOR EACH bevento WHERE bevento.nro_cliente = evento.nro_cliente AND
        bevento.origen = evento.origen AND
        bevento.periodo = evento.periodo AND NOT bevento.anulado AND bevento.nro_identificacion = 
        evento.nro_identificacion AND bevento.frealizado <> ? AND 
        bevento.sub_evento < evento.sub_evento:
        bevento.nro_certif = int( ex.certif ).
        bevento.letraprefijo = "ELE".
        PUT NOW bevento.nro_evento " " ex.certif " " ex.URL SKIP.
        END.
        OUTPUT CLOSE.
        {&OPEN-QUERY-BROWSE-4}
  END.
  ELSE DO:
        MESSAGE "Evento NO asignado" view-as alert-box error.
  END. */
     
  IF AVAILABLE ex THEN DO:
     belije:SENSITIVE IN FRAME {&FRAME-NAME} = TRUE.
     dbl = TRUE.
     {&OPEN-QUERY-BROWSE-2}
  END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME BUTTON-13
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL BUTTON-13 W-Win
ON CHOOSE OF BUTTON-13 IN FRAME F-Main /* Button 13 */
DO:
  DEFINE VAR proxlote AS INT NO-UNDO.
  
  DEFINE VAR uno AS LOGICAL INITIAL FALSE.
  RUN getparametro_n.p("PROXLOTE",OUTPUT proxlote).
  
  proxlote = proxlote + 1.
  FOR EACH ev WHERE ev.lote = 0:
      FIND evento WHERE evento.nro_evento = ev.nro_evento.
      evento.lote = proxlote.
      ev.lote = proxlote.
      uno = TRUE.
  END.
  {&OPEN-QUERY-BROWSE-2}
  RUN setparametro.p("PROXLOTE","",0,false,proxlote,"").
  run excel-export ( BROWSE-2:HANDLE IN FRAME {&FRAME-NAME} ).
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME BUTTON-14
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL BUTTON-14 W-Win
ON CHOOSE OF BUTTON-14 IN FRAME F-Main /* Button 14 */
DO:
  run excel-export ( BROWSE-4:HANDLE IN FRAME {&FRAME-NAME} ).
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME BUTTON-15
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL BUTTON-15 W-Win
ON CHOOSE OF BUTTON-15 IN FRAME F-Main /* Button 15 */
DO:
  DEFINE VARIABLE archivo  AS CHARACTER NO-UNDO.
  DEFINE VARIABLE OKpressed AS LOGICAL   NO-UNDO INITIAL TRUE.
      SYSTEM-DIALOG GET-FILE archivo    TITLE   "Elija el archivo a importar"    
          FILTERS "Excel(*.xls)"   "*.xls,*.xlsx"
                    MUST-EXIST    
          USE-FILENAME    
          UPDATE OKpressed.
       IF OKpressed THEN  RUN procxls(archivo).
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME TFU
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL TFU W-Win
ON VALUE-CHANGED OF TFU IN FRAME F-Main /* Fumigaciones */
DO:
  RUN llena.
  {&OPEN-QUERY-BROWSE-2}
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME TLT
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL TLT W-Win
ON VALUE-CHANGED OF TLT IN FRAME F-Main /* Limpieza de tanques */
DO:
     RUN llena.
    {&OPEN-QUERY-BROWSE-2}
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

OCXFile = SEARCH( "w-obleas.wrx":U ).
IF OCXFile = ? THEN
  OCXFile = SEARCH(SUBSTRING(THIS-PROCEDURE:FILE-NAME, 1,
                     R-INDEX(THIS-PROCEDURE:FILE-NAME, ".":U), "CHARACTER":U) + "wrx":U).

IF OCXFile <> ? THEN
DO:
  ASSIGN
    chProgressBar-1 = ProgressBar-1:COM-HANDLE
    UIB_S = chProgressBar-1:LoadControls( OCXFile, "ProgressBar-1":U)
  .
  RUN DISPATCH IN THIS-PROCEDURE("initialize-controls":U) NO-ERROR.
END.
ELSE MESSAGE "w-obleas.wrx":U SKIP(1)
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
  DISPLAY TLT TFU 
      WITH FRAME F-Main IN WINDOW W-Win.
  ENABLE BUTTON-15 BUTTON-13 TLT TFU BROWSE-2 BUTTON-14 BROWSE-4 
      WITH FRAME F-Main IN WINDOW W-Win.
  {&OPEN-BROWSERS-IN-QUERY-F-Main}
  VIEW W-Win.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE llena W-Win 
PROCEDURE llena :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEFINE VAR kk AS INT NO-UNDO.
DEFINE BUFFER administrador FOR cliente.    
DEFINE VAR quecod AS CHAR NO-UNDO.
    DO WITH FRAME {&FRAME-NAME}:
      ASSIGN tfu tlt.
      EMPTY TEMP-TABLE ev.
      FOR EACH sic.Evento
          WHERE evento.nro_certif = 0 and evento.origen = "contrato" AND evento.frealizado >= 01/01/2015 
    and NOT evento.anulado AND ( (tfu:checked and evento.nro_tipo_evento = 1 ) OR (tlt:checked and evento.nro_tipo_evento = 3 )) 
        NO-LOCK ,
      EACH sic.Cliente OF sic.Evento
      WHERE Cliente.cdg_provincia = "01" NO-LOCK,
      EACH sic.Tipo_evento OF sic.Evento NO-LOCK
    BY Evento.FRealizado :
          FIND contrato_hd NO-LOCK WHERE contrato_hd.nro_contrato = evento.nro_identificacion NO-ERROR.
          IF NOT AVAILABLE contrato_hd THEN NEXT.
          IF evento.sub_evento <> 1 /*sic.Contrato_hd.numero_eventos*/ THEN NEXT.
          IF evento.nro_tipo_evento = 1 THEN DO:
            FIND restriccion WHERE restriccion.cdg_restriccion = "CERTIF" NO-LOCK.
            FIND FIRST contrato_restriccion OF contrato_hd WHERE 
             contrato_restriccion.nro_restriccion = restriccion.nro_restriccion NO-LOCK NO-ERROR.
            IF NOT AVAILABLE contrato_restriccion  THEN NEXT.
            IF contrato_restriccion.valor = "*" THEN NEXT.
          END.
          ELSE DO:
              FIND FIRST evento_protocolo OF evento WHERE fecha_analisis <> ? NO-ERROR.
              IF NOT AVAILABLE evento_protocolo THEN NEXT.
          END.
 
          FIND cliente_otros_datos OF cliente NO-LOCK NO-ERROR.
          quecod = "".
          FOR EACH contrato_dt OF contrato_hd WHERE (contrato_dt.nro_articulo <> 167 AND contrato_dt.nro_articulo <> 121) NO-LOCK:
            FIND articulo OF contrato_dt NO-LOCK NO-ERROR.
            quecod = quecod + "," + articulo.cdg_articulo.
          END.
          quecod = SUBSTRING(quecod,2).
          
          CREATE ev.
          FIND administrador WHERE administrador.nro_cliente = cliente.nro_admin NO-LOCK.
          ASSIGN ev.lote = evento.lote
                 ev.nro_evento = evento.nro_evento
                 ev.nro_cliente = cliente.nro_cliente
                 ev.frealizado = evento.FRealizado
                 ev.cdg_tipo_evento = Tipo_evento.cdg_tipo_evento
                 ev.direccion = Cliente.direccion
                 ev.numero = numero(cliente.direccion)
                 ev.origen = Evento.Origen
                 ev.hdesde = Evento.hora_desde
                 ev.nro_identificacion = Evento.nro_identificacion
                 ev.unidades = IF AVAILABLE  cliente_otros_datos THEN cliente_otros_datos.unidades ELSE 0
                 ev.tanques = IF AVAILABLE  cliente_otros_datos THEN cliente_otros_datos.tanques ELSE 0
                 ev.nom_cliente = IF Cliente.factu_admin THEN administrador.nom_cliente ELSE cliente.nom_cliente 
                 ev.cdg_articulo = quecod.
          REPEAT kk = 1 TO num-entries(evento.recursos):
              FIND FIRST recurso WHERE recurso.cdg_recurso = ENTRY(kk,evento.recurso) NO-LOCK NO-ERROR.
              IF NOT AVAILABLE recurso THEN NEXT.
              ev.cuil[kk] = recurso.cuil.
              ev.nom_recurso[kk] = Recurso.nom_recurso.
          END.
      END.
    END.
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

 RUN llena.
 {&OPEN-QUERY-BROWSE-2}

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE Procxls W-Win 
PROCEDURE Procxls :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEFINE INPUT PARAMETER arch AS CHAR NO-UNDO.
DEFINE VARIABLE chExcel    AS COM-HANDLE NO-UNDO.
DEFINE VARIABLE chWorksheet AS COM-HANDLE NO-UNDO.
DEFINE VARIABLE chWorkbook  AS COM-HANDLE NO-UNDO.
DEFINE VAR a AS CHAR.
CREATE "excel.application" chExcel.
DEFINE VAR k AS INT NO-UNDO.
DEFINE VAR r AS INT NO-UNDO.
DEFINE VAR rr AS INT NO-UNDO.
DEFINE VAR calx AS CHAR NO-UNDO.
DEFINE VAR ctipo LIKE tipo_evento.cdg_tipo_evento no-undo.
DEFINE VAR ntipo LIKE tipo_evento.nro_tipo_evento no-undo.
DEFINE VAR v-geolat LIKE cliente.geolat.
DEFINE VAR v-geolong LIKE cliente.geolong.
    DEFINE VARIABLE oldnf AS CHAR NO-UNDO.

DEFINE BUFFER bevento FOR evento.    
chExcel:Workbooks:Open(arch).
chExcel:visible = FALSE.
chWorkSheet = chExcel:Sheets:Item(1).
EMPTY TEMP-TABLE ex.
IF chWorksheet:Range( "A1"):VALUE <>"Nº Certif." OR 
    chWorksheet:Range( "B1"):VALUE <>"Tipo de certificado" OR
    chWorksheet:Range( "C1"):VALUE <>"Fecha" OR
    chWorksheet:Range( "D1"):VALUE <>"Dirección" THEN DO:
    MESSAGE "El archivo " arch SKIP
        "no tiene el formato correcto para ser procesado"
        VIEW-AS ALERT-BOX ERROR.
    RETURN NO-APPLY.
END.
k = 1.
REPEAT:
    k = k + 1.
    IF chWorksheet:Range( "A" + STRING(k) ):VALUE = ? THEN LEAVE.
    IF chWorksheet:Range( "A" + STRING(k) ):VALUE = "" THEN LEAVE.

   rr = int(chWorksheet:Range( "A" + STRING(k) ):VALUE) NO-ERROR.
   IF ERROR-STATUS:ERROR THEN NEXT.
   CREATE ex.
   ex.certif = rr.
   ex.tipo = chWorksheet:Range( "B" + STRING(k) ):VALUE.
   ex.fecha = DATE(SUBSTRING(chWorksheet:Range( "C" + STRING(k) ):VALUE,1,10)).
   ex.direccion = chWorksheet:Range( "D" + STRING(k) ):VALUE.
   ex.numero = numero(ex.direccion).

END.
chProgressBar-1:XP_ProgressBar:min = 0.
chProgressBar-1:XP_ProgressBar:max = k.
chProgressBar-1:XP_ProgressBar:value = 0.
 
REPEAT k = 1 TO chWorksheet:Hyperlinks:COUNT :
    a = chWorksheet:Hyperlinks:item(k):range:VALUE NO-ERROR.
    IF ERROR-STATUS:ERROR THEN LEAVE.
    FIND ex WHERE ex.certif = int(a) NO-ERROR.
    IF NOT AVAILABLE ex THEN NEXT.
    a = chWorksheet:Hyperlinks:item(k + 1):address NO-ERROR.
    IF a = ? THEN NEXT.
    
    IF INDEX(a,"getoblea") <> 0 THEN 
      ex.URL = SUBSTRING(a,R-INDEX( a , "~/" ) + 1 ).
END.


chExcel:quit().
RELEASE OBJECT chWorksheet NO-ERROR.
RELEASE OBJECT chWorkbook NO-ERROR.
RELEASE OBJECT chExcel NO-ERROR.
k = 0.

FOR EACH ex WHERE ex.URL = "":
    DELETE ex.
END.
FOR EACH ex :
    IF CAN-find( FIRST  evento WHERE evento.nro_certif = ex.certif AND evento.letraprefijo = "ELE" ) THEN DO:
        ex.correcto = TRUE.
        NEXT.
    END.
    FIND FIRST evento WHERE evento.url2 = ex.direccion NO-LOCK NO-ERROR.
    IF AVAILABLE evento THEN ex.nro_cliente = evento.nro_cliente.
    ELSE DO:
            IF ex.tipo BEGINS "Desinfección" THEN ntipo = 1.
                 ELSE ntipo = 3.
            IF CAN-FIND ( FIRST evento WHERE evento.nro_certif = INT( ex.certif ) AND evento.letra = "ELE" AND evento.frealizado > 01/01/2015 AND
                          evento.nro_tipo_evento = ntipo ) THEN DO:
                     k = k + 1.
                     chProgressBar-1:XP_ProgressBar:value = k.
                     NEXT.
        END.
        RUN w-geoOPT.w ( toxAL(ex.direccion, OUTPUT calx) + ", CAPITAL FEDERAL" ,
                              OUTPUT TABLE ott,
                              OUTPUT rowtt).
            IF rowtt <> ? THEN DO:
                 oldnf = SESSION:NUMERIC-FORMAT.
                 SESSION:NUMERIC-FORMAT = "AMERICAN".
                 FIND ott WHERE ott.pid = rowtt.
                 v-geolat= decimal(entry(2, ott.coordinates)).
                 v-geolong = decimal(entry(1, ott.coordinates)).
                 ex.geolat = v-geolat.
                 ex.geolong = v-geolong.
                 SESSION:NUMERIC-FORMAT = oldnf.
                 ex.alx =  upper(entry(1 , ott.xal ) + " " + calx ).
                 ex.alx = REPLACE( ex.alx ,"Í","I").
                 ex.alx = REPLACE( ex.alx ,"Á","A").
                 ex.alx = REPLACE( ex.alx ,"É","E").
                 ex.alx = REPLACE( ex.alx ,"Ó","O").
                 ex.alx = REPLACE( ex.alx ,"Ú","U").
                 
                FIND cliente WHERE cliente.direccion = ex.alx NO-LOCK NO-ERROR.
                IF NOT AVAILABLE cliente THEN
                   FIND FIRST cliente WHERE cliente.cdg_cliente BEGINS "C" AND
                    cliente.geolat = v-geolat AND
                    cliente.geolong = v-geolong NO-ERROR.
                IF AVAILABLE cliente THEN 
                    ex.nro_cliente = cliente.nro_cliente.
            END.
    END.
    IF ex.nro_cliente <> 0 THEN DO:
        IF ex.tipo BEGINS "Desinfección" THEN ctipo = "FU".
                 ELSE ctipo = "LT".
            FIND FIRST ev WHERE ev.nro_cliente = ex.nro_cliente and
                 ev.cdg_tipo_evento = ctipo NO-ERROR.
            IF AVAILABLE ev THEN DO:
                FIND evento WHERE evento.nro_evento = ev.nro_evento.
                ASSIGN ex.nro_evento = evento.nro_evento
                evento.nro_certif = int( ex.certif )
                evento.letraprefijo = "ELE"
                Evento.foblea = TODAY
                ex.correcto = TRUE
                evento.url1 = ex.URL
                evento.url2 = ex.direccion.
                FOR EACH evento_protocolo OF evento:
                    evento_protocolo.nro_certif  = evento.nro_certif.
                END.
                OUTPUT TO "c:\dynasys10\logs\MCBA-OBLEAS.LOG" APPEND.
                PUT NOW evento.nro_evento " " ex.certif " " ex.URL SKIP.
                FOR EACH bevento WHERE bevento.nro_cliente = evento.nro_cliente AND
                    bevento.origen = evento.origen AND bevento.nro_tipo_evento = evento.nro_tipo_evento AND
                    bevento.periodo = evento.periodo AND NOT bevento.anulado AND bevento.nro_identificacion = 
                    evento.nro_identificacion AND bevento.frealizado <> ? AND 
                    bevento.sub_evento < evento.sub_evento:
                    ASSIGN bevento.nro_certif = evento.nro_certif
                    bevento.foblea = evento.foblea
                    bevento.letraprefijo = evento.letraprefijo.
                    FOR EACH evento_protocolo OF bevento:
                    evento_protocolo.nro_certif  = evento.nro_certif.
                END.
                    PUT NOW bevento.nro_evento " " ex.certif " " ex.URL SKIP.
                END.
                OUTPUT CLOSE.
            END.
    END.
    k = k + 1.
    chProgressBar-1:XP_ProgressBar:value = k.
END.
chProgressBar-1:XP_ProgressBar:VALUE = chProgressBar-1:XP_ProgressBar:MAX.
RUN llena.
{&OPEN-QUERY-BROWSE-2}
{&OPEN-QUERY-BROWSE-4}
    

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
  {src/adm/template/snd-list.i "ex"}
  {src/adm/template/snd-list.i "ev"}

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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION numero W-Win 
FUNCTION numero RETURNS INTEGER
  ( d AS CHAR ) :
/*------------------------------------------------------------------------------
  Purpose:  
    Notes:  
------------------------------------------------------------------------------*/
DEFINE VAR k AS INT.
    DEFINE VAR n AS INT NO-UNDO.
    d= REPLACE(d,"/", " / ").
    REPEAT k =1 TO NUM-ENTRIES(d," "):
        n = INT(ENTRY(k,d," ")) NO-ERROR.
        IF NOT ERROR-STATUS:ERROR THEN RETURN n.
    END.
    RETURN ?.
END FUNCTION.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

