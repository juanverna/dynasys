&ANALYZE-SUSPEND _VERSION-NUMBER AB_v10r12 GUI ADM2
&ANALYZE-RESUME
/* Connected Databases 
          sic              PROGRESS
*/
&Scoped-define WINDOW-NAME wWin


/* Temp-Table and Buffer definitions                                    */
DEFINE BUFFER B-Empresa FOR Empresa.
DEFINE BUFFER B-Submenu FOR Treemenu.
DEFINE BUFFER B-Treemenu FOR Treemenu.
DEFINE BUFFER C-Treemenu FOR Treemenu.
DEFINE BUFFER Submenu FOR Treemenu.
DEFINE TEMP-TABLE T-Treemenu NO-UNDO LIKE Treemenu.



&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _DEFINITIONS wWin 
/*------------------------------------------------------------------------

  File: 

  Description: from cntnrwin.w - ADM SmartWindow Template

  Input Parameters:
      <none>

  Output Parameters:
      <none>

  History: New V9 Version - January 15, 1998
          
------------------------------------------------------------------------*/
/*          This .W file was created with the Progress AB.              */
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

{windows.i}

DEFINE VARIABLE itraceEventTime AS INTEGER    NO-UNDO.
DEFINE VARIABLE iETime          AS INTEGER    NO-UNDO.
DEFINE VARIABLE lTraceEvents    AS LOGICAL NO-UNDO INITIAL NO.
DEF TEMP-TABLE osFile NO-UNDO
 FIELD cFileName AS CHAR
 FIELD cFullPath  AS CHAR
 FIELD cAttr AS CHAR
 INDEX af cAttr cFileName.

{vrshared.i "NEW"}
{nrorelea.i}

DEFINE VARIABLE hoy                     AS DATE INITIAL TODAY.
DEFINE VARIABLE proceso                 AS CHARACTER.
DEFINE VARIABLE aux_archivo             AS CHARACTER.

DEFINE VARIABLE carga_logo              AS LOGICAL INITIAL NO.
DEFINE VARIABLE hubo_logon              AS LOGICAL INITIAL YES.
DEFINE VARIABLE hubo_conexion           AS LOGICAL INITIAL NO.
DEFINE VARIABLE puede_salir             AS LOGICAL INITIAL YES NO-UNDO.
DEFINE VARIABLE puso_ok                 AS LOGICAL INITIAL YES NO-UNDO.
DEFINE VARIABLE titulo                  LIKE Treemenu.titulo.
{valoressalida.i}

DEFINE VARIABLE ES_ALTA                 AS LOGICAL.

DEFINE VARIABLE v-icono_programa        AS CHARACTER INITIAL "tvpics/windows.bmp".
DEFINE VARIABLE v-icono_submenu         AS CHARACTER INITIAL "tvpics/fold.bmp".
DEFINE VARIABLE v-icono_modulo          AS CHARACTER INITIAL "tvpics/usermale.bmp".

DEFINE VARIABLE boton_habilito          AS CHARACTER.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE SmartWindow
&Scoped-define DB-AWARE no

&Scoped-define ADM-CONTAINER WINDOW

&Scoped-define ADM-SUPPORTED-LINKS Data-Target,Data-Source,Page-Target,Update-Source,Update-Target,Filter-target,Filter-Source

/* Name of designated FRAME-NAME and/or first browse and/or first query */
&Scoped-define FRAME-NAME fContainer

/* Internal Tables (found by Frame, Query & Browse Queries)             */
&Scoped-define INTERNAL-TABLES Treemenu

/* Definitions for FRAME fContainer                                     */
&Scoped-define FIELDS-IN-QUERY-fContainer Treemenu.cdg_padre ~
Treemenu.cdg_item Treemenu.titulo Treemenu.accion Treemenu.cdg_comprobante ~
Treemenu.modo Treemenu.archivo_help Treemenu.archivo_icono ~
Treemenu.permitidos Treemenu.descripcion 
&Scoped-define ENABLED-FIELDS-IN-QUERY-fContainer Treemenu.permitidos ~
Treemenu.descripcion 
&Scoped-define ENABLED-TABLES-IN-QUERY-fContainer Treemenu
&Scoped-define FIRST-ENABLED-TABLE-IN-QUERY-fContainer Treemenu
&Scoped-define QUERY-STRING-fContainer FOR EACH Treemenu SHARE-LOCK
&Scoped-define OPEN-QUERY-fContainer OPEN QUERY fContainer FOR EACH Treemenu SHARE-LOCK.
&Scoped-define TABLES-IN-QUERY-fContainer Treemenu
&Scoped-define FIRST-TABLE-IN-QUERY-fContainer Treemenu


/* Standard List Definitions                                            */
&Scoped-Define ENABLED-FIELDS Treemenu.permitidos Treemenu.descripcion 
&Scoped-define ENABLED-TABLES Treemenu
&Scoped-define FIRST-ENABLED-TABLE Treemenu
&Scoped-Define ENABLED-OBJECTS v-cdg_empresa Btn_Done btn_exportar ~
btn_exportar_menu btn_importar btn_copiar v-que_empresa btn_ejecutar ~
btn_heredar 
&Scoped-Define DISPLAYED-FIELDS Treemenu.cdg_padre Treemenu.cdg_item ~
Treemenu.titulo Treemenu.accion Treemenu.cdg_comprobante Treemenu.modo ~
Treemenu.archivo_help Treemenu.archivo_icono Treemenu.permitidos ~
Treemenu.descripcion 
&Scoped-define DISPLAYED-TABLES Treemenu
&Scoped-define FIRST-DISPLAYED-TABLE Treemenu
&Scoped-Define DISPLAYED-OBJECTS v-cdg_empresa v-codigo_mover ~
v-codigo_destino v-que_empresa 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */
&Scoped-define List-1 Treemenu.cdg_item Treemenu.titulo Treemenu.accion ~
btn_programas Treemenu.cdg_comprobante Treemenu.modo Treemenu.archivo_help ~
btn_ayudas Treemenu.archivo_icono btn_iconos Treemenu.permitidos ~
Treemenu.descripcion 
&Scoped-define List-2 v-codigo_mover v-codigo_destino Treemenu.cdg_padre 

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME


/* ************************  Function Prototypes ********************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION-FORWARD AddtoEdMsg wWin 
FUNCTION AddtoEdMsg RETURNS LOGICAL
  (pcTxt AS CHAR)  FORWARD.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION-FORWARD fnPadre wWin 
FUNCTION fnPadre RETURNS CHARACTER
  ( p-cdg_item AS CHARACTER )  FORWARD.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


/* ***********************  Control Definitions  ********************** */

/* Define the widget handle for the window                              */
DEFINE VAR wWin AS WIDGET-HANDLE NO-UNDO.

/* Definitions of handles for SmartObjects                              */
DEFINE VARIABLE h_pure4gltv AS HANDLE NO-UNDO.

/* Definitions of the field level widgets                               */
DEFINE BUTTON btn_addnode 
     LABEL "&Agregar Nodo" 
     SIZE 23 BY 1.14.

DEFINE BUTTON btn_addsubnode 
     LABEL "Agregar &Subnodo" 
     SIZE 23 BY 1.14.

DEFINE BUTTON btn_ayudas 
     LABEL "&Ayudas" 
     SIZE 15 BY 1.

DEFINE BUTTON btn_cancelar 
     LABEL "&Cancelar" 
     SIZE 23 BY 1.14.

DEFINE BUTTON btn_copiar 
     LABEL "&Copiar a" 
     SIZE 12 BY 1.

DEFINE BUTTON btn_copynode 
     LABEL "&Copiar Nodo" 
     SIZE 23 BY 1.14 TOOLTIP "Copy a child node for the selected one.".

DEFINE BUTTON btn_copyrama 
     LABEL "&Copiar &Rama" 
     SIZE 23 BY 1.14 TOOLTIP "Copy a child node for the selected one.".

DEFINE BUTTON btn_deletenode 
     LABEL "&Eliminar" 
     SIZE 23 BY 1.14 TOOLTIP "Add a child node for the selected one.".

DEFINE BUTTON btn_deshacer 
     LABEL "&Deshacer" 
     SIZE 23 BY 1.14.

DEFINE BUTTON Btn_Done DEFAULT 
     LABEL "&Salir" 
     SIZE 23 BY 1.14
     BGCOLOR 8 .

DEFINE BUTTON btn_ejecutar 
     LABEL "&Comprobar Ejecución" 
     SIZE 23 BY 1.14.

DEFINE BUTTON btn_exportar 
     LABEL "&Exportar Rama" 
     SIZE 23 BY 1.14.

DEFINE BUTTON btn_exportar_menu 
     LABEL "Menú &Completo" 
     SIZE 23 BY 1.14.

DEFINE BUTTON btn_grabar 
     LABEL "&Grabar" 
     SIZE 23 BY 1.14.

DEFINE BUTTON btn_heredar 
     LABEL "&Heredar permisos" 
     SIZE 23 BY 1.14.

DEFINE BUTTON btn_iconos 
     LABEL "&Imágenes" 
     SIZE 15 BY 1.

DEFINE BUTTON btn_importar 
     LABEL "&Import" 
     SIZE 23 BY 1.14.

DEFINE BUTTON btn_programas 
     LABEL "&Programas" 
     SIZE 15 BY 1.

DEFINE BUTTON btn_updatenode 
     LABEL "&Modificar" 
     SIZE 23 BY 1.14 TOOLTIP "Add a child node for the selected one.".

DEFINE VARIABLE v-cdg_empresa AS CHARACTER FORMAT "X(256)":U 
     LABEL "Empresa" 
     VIEW-AS COMBO-BOX INNER-LINES 5
     LIST-ITEM-PAIRS "Item 1","Item 1"
     DROP-DOWN-LIST
     SIZE 44 BY 1
     BGCOLOR 15 FGCOLOR 9  NO-UNDO.

DEFINE VARIABLE v-codigo_destino AS CHARACTER FORMAT "X(256)":U 
     LABEL "Destino" 
     VIEW-AS FILL-IN 
     SIZE 22 BY 1
     BGCOLOR 15 FGCOLOR 9  NO-UNDO.

DEFINE VARIABLE v-codigo_mover AS CHARACTER FORMAT "X(256)":U 
     LABEL "Mover" 
     VIEW-AS FILL-IN 
     SIZE 21 BY 1
     BGCOLOR 15 FGCOLOR 9  NO-UNDO.

DEFINE VARIABLE v-que_empresa AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN NATIVE 
     SIZE 9 BY 1
     BGCOLOR 15 FGCOLOR 9  NO-UNDO.

/* Query definitions                                                    */
&ANALYZE-SUSPEND
DEFINE QUERY fContainer FOR 
      Treemenu SCROLLING.
&ANALYZE-RESUME

/* ************************  Frame Definitions  *********************** */

DEFINE FRAME fContainer
     v-cdg_empresa AT ROW 1 COL 14 COLON-ALIGNED WIDGET-ID 12
     v-codigo_mover AT ROW 1 COL 69 COLON-ALIGNED WIDGET-ID 82
     v-codigo_destino AT ROW 1 COL 104 COLON-ALIGNED WIDGET-ID 84
     Btn_Done AT ROW 2.19 COL 135 WIDGET-ID 50
     btn_exportar AT ROW 4.57 COL 135 WIDGET-ID 52
     btn_exportar_menu AT ROW 5.76 COL 135 WIDGET-ID 56
     btn_importar AT ROW 8.38 COL 135 WIDGET-ID 58
     btn_copiar AT ROW 10.76 COL 135 WIDGET-ID 38
     v-que_empresa AT ROW 10.76 COL 147 COLON-ALIGNED NO-LABEL WIDGET-ID 32
     btn_ejecutar AT ROW 11.95 COL 135 WIDGET-ID 40
     btn_heredar AT ROW 13.14 COL 135 WIDGET-ID 42
     btn_addnode AT ROW 15.29 COL 135 WIDGET-ID 44
     Treemenu.cdg_padre AT ROW 15.52 COL 78 COLON-ALIGNED WIDGET-ID 18 FORMAT "X(20)"
          VIEW-AS FILL-IN NATIVE 
          SIZE 48 BY 1
          BGCOLOR 15 FGCOLOR 9 
     Treemenu.cdg_item AT ROW 15.62 COL 14 COLON-ALIGNED WIDGET-ID 16 FORMAT "X(40)"
          VIEW-AS FILL-IN NATIVE 
          SIZE 55 BY 1
          BGCOLOR 15 FGCOLOR 9 
     btn_addsubnode AT ROW 16.48 COL 135 WIDGET-ID 92
     Treemenu.titulo AT ROW 16.71 COL 14 COLON-ALIGNED WIDGET-ID 24
          VIEW-AS FILL-IN NATIVE 
          SIZE 112 BY 1
          BGCOLOR 15 FGCOLOR 9 
     btn_updatenode AT ROW 17.67 COL 135 WIDGET-ID 46
     Treemenu.accion AT ROW 17.91 COL 14 COLON-ALIGNED WIDGET-ID 26
          VIEW-AS FILL-IN NATIVE 
          SIZE 95.8 BY 1
          BGCOLOR 15 FGCOLOR 9 
     btn_programas AT ROW 17.91 COL 113 WIDGET-ID 34
     btn_deletenode AT ROW 18.86 COL 135 WIDGET-ID 48
     Treemenu.cdg_comprobante AT ROW 19.1 COL 14 COLON-ALIGNED WIDGET-ID 28
          VIEW-AS COMBO-BOX INNER-LINES 5
          LIST-ITEM-PAIRS "Item 1","Item 1"
          DROP-DOWN-LIST
          SIZE 82 BY 1
          BGCOLOR 15 FGCOLOR 9 
     Treemenu.modo AT ROW 19.1 COL 105 COLON-ALIGNED WIDGET-ID 30
          VIEW-AS COMBO-BOX INNER-LINES 5
          LIST-ITEM-PAIRS "Sin Modo","X",
                     "Altas","0",
                     "Consultas","1",
                     "Modificaciones","5",
                     "Anulaciones","7",
                     "Emision","8"
          DROP-DOWN-LIST
          SIZE 21 BY 1
          BGCOLOR 15 FGCOLOR 9 
     btn_copynode AT ROW 20.05 COL 135 WIDGET-ID 88
     Treemenu.archivo_help AT ROW 20.29 COL 14 COLON-ALIGNED WIDGET-ID 14 FORMAT "X(90)"
          VIEW-AS FILL-IN NATIVE 
          SIZE 95.8 BY 1
          BGCOLOR 15 FGCOLOR 9 
     btn_ayudas AT ROW 20.29 COL 113 WIDGET-ID 36
     btn_copyrama AT ROW 21.24 COL 135 WIDGET-ID 94
     Treemenu.archivo_icono AT ROW 21.48 COL 14 COLON-ALIGNED WIDGET-ID 76
          VIEW-AS FILL-IN NATIVE 
          SIZE 96 BY 1
          BGCOLOR 15 FGCOLOR 9 
     btn_iconos AT ROW 21.48 COL 113 WIDGET-ID 78
     btn_grabar AT ROW 22.43 COL 135 WIDGET-ID 80
     Treemenu.permitidos AT ROW 22.67 COL 16 NO-LABEL WIDGET-ID 22
          VIEW-AS EDITOR SCROLLBAR-VERTICAL
          SIZE 111.8 BY 1.62
          BGCOLOR 15 FGCOLOR 7 
     btn_deshacer AT ROW 23.62 COL 135 WIDGET-ID 70
     Treemenu.descripcion AT ROW 24.33 COL 16 NO-LABEL WIDGET-ID 20
          VIEW-AS EDITOR SCROLLBAR-VERTICAL
          SIZE 111.8 BY 1.62
          BGCOLOR 15 FGCOLOR 7 
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1.2 ROW 1
         SIZE 164.8 BY 26.33.

/* DEFINE FRAME statement is approaching 4K Bytes.  Breaking it up   */
DEFINE FRAME fContainer
     btn_cancelar AT ROW 24.81 COL 135 WIDGET-ID 68
     "Descripción:" VIEW-AS TEXT
          SIZE 12 BY .86 AT ROW 24.33 COL 3 WIDGET-ID 74
     "    Export de Menúes" VIEW-AS TEXT
          SIZE 23 BY .95 AT ROW 3.38 COL 135 WIDGET-ID 60
          BGCOLOR 9 FGCOLOR 15 
     "    Import de Menúes" VIEW-AS TEXT
          SIZE 23 BY .95 AT ROW 7.19 COL 135 WIDGET-ID 62
          BGCOLOR 9 FGCOLOR 15 
     " Copiar a otra empresa:" VIEW-AS TEXT
          SIZE 23 BY .95 AT ROW 9.57 COL 135 WIDGET-ID 86
          BGCOLOR 9 FGCOLOR 15 
     "Funciones:" VIEW-AS TEXT
          SIZE 11 BY .86 AT ROW 22.67 COL 5 WIDGET-ID 72
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1.2 ROW 1
         SIZE 164.8 BY 26.33.


/* *********************** Procedure Settings ************************ */

&ANALYZE-SUSPEND _PROCEDURE-SETTINGS
/* Settings for THIS-PROCEDURE
   Type: SmartWindow
   Allow: Basic,Browse,DB-Fields,Query,Smart,Window
   Container Links: Data-Target,Data-Source,Page-Target,Update-Source,Update-Target,Filter-target,Filter-Source
   Other Settings: COMPILE
   Temp-Tables and Buffers:
      TABLE: B-Empresa B "?" ? sic Empresa
      TABLE: B-Submenu B "?" ? sic Treemenu
      TABLE: B-Treemenu B "?" ? sic Treemenu
      TABLE: C-Treemenu B "?" ? sic Treemenu
      TABLE: Submenu B "?" ? sic Treemenu
      TABLE: T-Treemenu T "?" NO-UNDO sic Treemenu
   END-TABLES.
 */
&ANALYZE-RESUME _END-PROCEDURE-SETTINGS

/* *************************  Create Window  ************************** */

&ANALYZE-SUSPEND _CREATE-WINDOW
IF SESSION:DISPLAY-TYPE = "GUI":U THEN
  CREATE WINDOW wWin ASSIGN
         HIDDEN             = YES
         TITLE              = "Dynasys Rel. 4"
         HEIGHT             = 25.71
         WIDTH              = 160
         MAX-HEIGHT         = 35.33
         MAX-WIDTH          = 256
         VIRTUAL-HEIGHT     = 35.33
         VIRTUAL-WIDTH      = 256
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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _INCLUDED-LIB wWin 
/* ************************* Included-Libraries *********************** */

{getmenu4gl.i}
{src/adm2/containr.i}

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME




/* ***********  Runtime Attributes and AppBuilder Settings  *********** */

&ANALYZE-SUSPEND _RUN-TIME-ATTRIBUTES
/* SETTINGS FOR WINDOW wWin
  VISIBLE,,RUN-PERSISTENT                                               */
/* SETTINGS FOR FRAME fContainer
   FRAME-NAME                                                           */
/* SETTINGS FOR FILL-IN Treemenu.accion IN FRAME fContainer
   NO-ENABLE 1                                                          */
/* SETTINGS FOR FILL-IN Treemenu.archivo_help IN FRAME fContainer
   NO-ENABLE 1 EXP-FORMAT                                               */
/* SETTINGS FOR FILL-IN Treemenu.archivo_icono IN FRAME fContainer
   NO-ENABLE 1                                                          */
/* SETTINGS FOR BUTTON btn_addnode IN FRAME fContainer
   NO-ENABLE                                                            */
/* SETTINGS FOR BUTTON btn_addsubnode IN FRAME fContainer
   NO-ENABLE                                                            */
/* SETTINGS FOR BUTTON btn_ayudas IN FRAME fContainer
   NO-ENABLE 1                                                          */
/* SETTINGS FOR BUTTON btn_cancelar IN FRAME fContainer
   NO-ENABLE                                                            */
/* SETTINGS FOR BUTTON btn_copynode IN FRAME fContainer
   NO-ENABLE                                                            */
/* SETTINGS FOR BUTTON btn_copyrama IN FRAME fContainer
   NO-ENABLE                                                            */
/* SETTINGS FOR BUTTON btn_deletenode IN FRAME fContainer
   NO-ENABLE                                                            */
/* SETTINGS FOR BUTTON btn_deshacer IN FRAME fContainer
   NO-ENABLE                                                            */
/* SETTINGS FOR BUTTON btn_grabar IN FRAME fContainer
   NO-ENABLE                                                            */
/* SETTINGS FOR BUTTON btn_iconos IN FRAME fContainer
   NO-ENABLE 1                                                          */
/* SETTINGS FOR BUTTON btn_programas IN FRAME fContainer
   NO-ENABLE 1                                                          */
/* SETTINGS FOR BUTTON btn_updatenode IN FRAME fContainer
   NO-ENABLE                                                            */
/* SETTINGS FOR COMBO-BOX Treemenu.cdg_comprobante IN FRAME fContainer
   NO-ENABLE 1                                                          */
/* SETTINGS FOR FILL-IN Treemenu.cdg_item IN FRAME fContainer
   NO-ENABLE 1 EXP-FORMAT                                               */
/* SETTINGS FOR FILL-IN Treemenu.cdg_padre IN FRAME fContainer
   NO-ENABLE 2 EXP-FORMAT                                               */
/* SETTINGS FOR EDITOR Treemenu.descripcion IN FRAME fContainer
   1                                                                    */
/* SETTINGS FOR COMBO-BOX Treemenu.modo IN FRAME fContainer
   NO-ENABLE 1                                                          */
/* SETTINGS FOR EDITOR Treemenu.permitidos IN FRAME fContainer
   1                                                                    */
/* SETTINGS FOR FILL-IN Treemenu.titulo IN FRAME fContainer
   NO-ENABLE 1                                                          */
/* SETTINGS FOR FILL-IN v-codigo_destino IN FRAME fContainer
   NO-ENABLE 2                                                          */
/* SETTINGS FOR FILL-IN v-codigo_mover IN FRAME fContainer
   NO-ENABLE 2                                                          */
IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(wWin)
THEN wWin:HIDDEN = yes.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME


/* Setting information for Queries and Browse Widgets fields            */

&ANALYZE-SUSPEND _QUERY-BLOCK FRAME fContainer
/* Query rebuild information for FRAME fContainer
     _TblList          = "sic.Treemenu"
     _Query            is OPENED
*/  /* FRAME fContainer */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME wWin
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL wWin wWin
ON END-ERROR OF wWin /* Dynasys Rel. 4 */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL wWin wWin
ON WINDOW-CLOSE OF wWin /* Dynasys Rel. 4 */
DO:

  /* This ADM code must be left here in order for the SmartWindow
     and its descendents to terminate properly on exit. */

  IF btn_done:SENSITIVE IN FRAME {&FRAME-NAME}
  THEN DO:
        APPLY "CLOSE":U TO THIS-PROCEDURE.
        RETURN NO-APPLY.
  END.
  ELSE DO:
        MESSAGE "No puede abandonar el sistema porque hay un módulo ejecutándose"
                VIEW-AS ALERT-BOX ERROR.
        RETURN NO-APPLY.

  END.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL wWin wWin
ON WINDOW-RESIZED OF wWin /* Dynasys Rel. 4 */
DO: /*
  DEFINE VARIABLE iHorizontalGap  AS DEC    NO-UNDO.
  DEFINE VARIABLE iVerticalGap    AS DEC    NO-UNDO.
  DEFINE VARIABLE iTvWidth        AS DEC    NO-UNDO.
  DEFINE VARIABLE lresizeVertical AS LOGICAL    NO-UNDO.
  DEFINE VARIABLE lresizeHorizontal AS LOGICAL    NO-UNDO.
  
  
  {get resizeVertical lresizeVertical h_pure4glTv}.
  IF lresizeVertical = ? THEN lresizeVertical = YES.
  {get resizeHorizontal lresizeHorizontal h_pure4glTv}.
  IF lresizeHorizontal = ? THEN lresizeHorizontal = YES.
  
  iTvWidth = FRAME fMain:COL - 1.7.

  iVerticalGap = SELF:HEIGHT-CHAR - FRAME fContainer:HEIGHT-CHARS.
  iHorizontalGap = SELF:WIDTH-CHAR - FRAME fContainer:WIDTH-CHARS.
  
  IF iVerticalGap > 0 THEN ASSIGN
   FRAME fContainer:HEIGHT-CHARS = SELF:HEIGHT-CHAR
   FRAME fMain:HEIGHT-CHARS = SELF:HEIGHT-CHAR
  /* edMsg:HEIGHT-CHARS = SELF:HEIGHT-CHARS - 0.2 - edMsg:ROW + 1*/ .
  
  IF iHorizontalGap > 0 THEN ASSIGN
   FRAME fContainer:WIDTH-CHARS = SELF:WIDTH-CHAR
   FRAME fMain:COL = FRAME fMain:COL + iHorizontalGap.
  
  RUN resizeObject IN h_pure4glTv
    (IF lresizeVertical THEN SELF:HEIGHT-CHARS - 0.2 ELSE ?
    ,IF lresizeHorizontal THEN iTVWidth + iHorizontalGap ELSE ?).

  IF iVerticalGap < 0 THEN ASSIGN
   /*edMsg:HEIGHT-CHARS = SELF:HEIGHT-CHARS - 0.2 - edMsg:ROW + 1*/
   FRAME fMain:HEIGHT-CHARS = SELF:HEIGHT-CHAR
   FRAME fContainer:HEIGHT-CHARS = SELF:HEIGHT-CHAR.

  IF iHorizontalGap < 0 THEN ASSIGN
   FRAME fMain:COL = FRAME fMain:COL + iHorizontalGap
   FRAME fContainer:WIDTH-CHARS = SELF:WIDTH-CHAR.

   
   /* no scrollbar when shrinking please */
   FRAME fMain:VIRTUAL-HEIGHT-CHARS = FRAME fMain:HEIGHT-CHARS.
   FRAME fMain:VIRTUAL-WIDTH-CHARS = FRAME fMain:WIDTH-CHARS.
   FRAME fContainer:VIRTUAL-HEIGHT-CHARS = SELF:HEIGHT-CHAR.
   FRAME fContainer:VIRTUAL-WIDTH-CHARS = SELF:WIDTH-CHAR.
   */
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME Treemenu.accion
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Treemenu.accion wWin
ON LEAVE OF Treemenu.accion IN FRAME fContainer /* Acción */
DO:
      IF Treemenu.accion <> "" THEN DO:
    IF SEARCH(Treemenu.accion) = ? AND search(entry(1,Treemenu.accion,".") + ".r" ) = ? THEN DO:
       Treemenu.accion:BGCOLOR = 12.
       Treemenu.accion:FGCOLOR = 15.
      END.
      ELSE DO:
       Treemenu.accion:BGCOLOR = 15.
       Treemenu.accion:FGCOLOR = 9.
    END.
    END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btn_addnode
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btn_addnode wWin
ON CHOOSE OF btn_addnode IN FRAME fContainer /* Agregar Nodo */
DO:

    DEFINE VARIABLE rid AS ROWID.
    DEFINE VARIABLE v-nueitem LIKE Treemenu.cdg_item.
    DEFINE VARIABLE v-item LIKE Treemenu.cdg_item.
    DEFINE VARIABLE j AS INTEGER.
    DEFINE VARIABLE l AS INTEGER.

    IF AVAILABLE Treemenu
    THEN DO:
        RUN adm-add-record.
        
        FOR EACH B-Treemenu NO-LOCK 
            WHERE B-Treemenu.cdg_padre   = Treemenu.cdg_padre 
              AND B-Treemenu.cdg_empresa = Treemenu.cdg_empresa
                  BY B-Treemenu.cdg_item:
            rid = ROWID(B-Treemenu).
        END.
        FIND B-Treemenu WHERE ROWID(B-Treemenu) = rid NO-LOCK.
      
        v-nueitem = fnPadre(B-Treemenu.cdg_item) + ".".
        v-item = ENTRY(NUM-ENTRIES(B-Treemenu.cdg_item,"."),B-Treemenu.cdg_item,".").
        l = LENGTH(v-item).
        IF l = 1
           THEN v-item = CHR(ASC(v-item) + 1).
           ELSE v-item = SUBSTRING(v-item,1,l - 1) + CHR(ASC(SUBSTRING(v-item,l,1)) + 1).
        v-nueitem = v-nueitem + v-item.
  
        DISPLAY v-nueitem @ Treemenu.cdg_item
                fnPadre(v-nueitem) @ Treemenu.cdg_padre
           WITH FRAME {&FRAME-NAME}.
                            
    END.
    ELSE DO:
        MESSAGE "Seleccione un nodo del árbol" VIEW-AS ALERT-BOX MESSAGE.
    END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btn_addsubnode
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btn_addsubnode wWin
ON CHOOSE OF btn_addsubnode IN FRAME fContainer /* Agregar Subnodo */
DO:
    DEFINE VARIABLE rid AS ROWID.
    DEFINE VARIABLE v-nueitem LIKE Treemenu.cdg_item.
    DEFINE VARIABLE v-item LIKE Treemenu.cdg_item.
    DEFINE VARIABLE j AS INTEGER.
    DEFINE VARIABLE l AS INTEGER.

    IF AVAILABLE Treemenu
    THEN DO:
        RUN adm-add-record.
        
        IF CAN-FIND(FIRST B-Treemenu NO-LOCK 
            WHERE B-Treemenu.cdg_padre   = Treemenu.cdg_item 
              AND B-Treemenu.cdg_empresa = Treemenu.cdg_empresa)
        THEN DO:
            FOR EACH B-Treemenu NO-LOCK 
               WHERE B-Treemenu.cdg_padre   = Treemenu.cdg_item 
                 AND B-Treemenu.cdg_empresa = Treemenu.cdg_empresa
                  BY B-Treemenu.cdg_item:
                rid = ROWID(B-Treemenu).
            END.
            FIND B-Treemenu WHERE ROWID(B-Treemenu) = rid NO-LOCK.

            v-nueitem = fnPadre(B-Treemenu.cdg_item) + ".".
            v-item = ENTRY(NUM-ENTRIES(B-Treemenu.cdg_item,"."),B-Treemenu.cdg_item,".").
            l = LENGTH(v-item).
            IF l = 1
               THEN v-item = CHR(ASC(v-item) + 1).
               ELSE v-item = SUBSTRING(v-item,1,l - 1) + CHR(ASC(SUBSTRING(v-item,l,1)) + 1).
            v-nueitem = v-nueitem + v-item.
        END.
        ELSE DO:
            v-nueitem = Treemenu.cdg_item + ".1".
        END.
  
        DISPLAY v-nueitem @ Treemenu.cdg_item
                fnPadre(v-nueitem) @ Treemenu.cdg_padre
           WITH FRAME {&FRAME-NAME}.
                            
    END.
    ELSE DO:
        MESSAGE "Seleccione un nodo del árbol" VIEW-AS ALERT-BOX MESSAGE.
    END.
    /*RUN adm-add-record.*/
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btn_ayudas
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btn_ayudas wWin
ON CHOOSE OF btn_ayudas IN FRAME fContainer /* Ayudas */
DO:
    DEFINE VARIABLE ok AS LOGICAL.
    DEFINE VARIABLE x-archivo AS CHARACTER.
    DEFINE VARIABLE x-carpeta_inicial AS CHARACTER.
    DEFINE VARIABLE x-carpeta_default AS CHARACTER INITIAL ".\ayudas".
    DEFINE VARIABLE x-separador AS CHARACTER INITIAL "\".
    DEFINE VARIABLE j-carpeta AS INTEGER.

    ASSIGN x-archivo = Treemenu.archivo_help:SCREEN-VALUE IN FRAME {&FRAME-NAME}.

    x-archivo = REPLACE(x-archivo,"/","\").
    x-carpeta_inicial = "".
    DO j-carpeta = 1 TO NUM-ENTRIES(x-archivo,x-separador) - 1:
        x-carpeta_inicial = x-carpeta_inicial + x-separador + ENTRY(j-carpeta,x-archivo,x-separador).
    END.
    x-carpeta_inicial = SUBSTRING(x-carpeta_inicial,2).
    
    IF x-carpeta_inicial = ""
        THEN x-carpeta_inicial = x-carpeta_default.
    
    SYSTEM-DIALOG GET-FILE x-archivo
          FILTERS "Archivos (*.*)" "*.*",
                  "Programas (*.*)" "*.*"
          INITIAL-FILTER 1
          MUST-EXIST
          DEFAULT-EXTENSION ".*"
          INITIAL-DIR x-carpeta_inicial
          RETURN-TO-START-DIR 
          TITLE "Seleccione el archivo de ayuda" 
          USE-FILENAME
          UPDATE puso_ok.

  IF puso_ok 
  THEN DO:
      FILE-INFO:FILE-NAME = ".".
      ASSIGN x-archivo = REPLACE(x-archivo,FILE-INFO:FULL-PATHNAME + "\","").

      DISPLAY x-archivo @ Treemenu.archivo_help
                  WITH FRAME {&FRAME-NAME}.
  END.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btn_cancelar
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btn_cancelar wWin
ON CHOOSE OF btn_cancelar IN FRAME fContainer /* Cancelar */
DO:
  RUN adm-disable-fields.
  RUN adm-display-fields.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btn_copiar
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btn_copiar wWin
ON CHOOSE OF btn_copiar IN FRAME fContainer /* Copiar a */
DO:
  DEFINE BUFFER B-Treemenu FOR Treemenu.
  
  ASSIGN v-que_empresa.
  DO TRANSACTION:
     FIND B-Treemenu WHERE B-Treemenu.cdg_empresa = v-que_empresa
                       AND B-Treemenu.cdg_item    = Treemenu.cdg_item
                           EXCLUSIVE-LOCK NO-ERROR.
     IF NOT AVAILABLE B-Treemenu 
        THEN CREATE B-Treemenu.
     BUFFER-COPY Treemenu TO B-Treemenu ASSIGN B-Treemenu.cdg_empresa = v-que_empresa.
     RELEASE B-Treemenu.
  END.
  DISPLAY "" @ v-que_empresa
          WITH FRAME {&FRAME-NAME}.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btn_copynode
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btn_copynode wWin
ON CHOOSE OF btn_copynode IN FRAME fContainer /* Copiar Nodo */
DO:
  RUN adm-enable-fields.
  ES_ALTA = YES.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btn_copyrama
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btn_copyrama wWin
ON CHOOSE OF btn_copyrama IN FRAME fContainer /* Copiar Rama */
DO:
    RUN adm-enable-fields.
    ES_ALTA = YES.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btn_deletenode
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btn_deletenode wWin
ON CHOOSE OF btn_deletenode IN FRAME fContainer /* Eliminar */
DO:
    DEFINE VARIABLE sino AS LOGICAL.
    RUN mensajepregunta.p (INPUT "este nodo", INPUT "PREG004", INPUT-OUTPUT sino ).
    IF sino 
    THEN DO:
        RUN adm-delete-record.
    END.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btn_deshacer
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btn_deshacer wWin
ON CHOOSE OF btn_deshacer IN FRAME fContainer /* Deshacer */
DO:
    RUN adm-display-fields.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME Btn_Done
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Btn_Done wWin
ON CHOOSE OF Btn_Done IN FRAME fContainer /* Salir */
DO:
  &IF DEFINED (adm-panel) <> 0 &THEN
      RUN dispatch IN THIS-PROCEDURE ('exit').
  &ELSE
      APPLY "CLOSE":U TO THIS-PROCEDURE.
  &ENDIF
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btn_ejecutar
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btn_ejecutar wWin
ON CHOOSE OF btn_ejecutar IN FRAME fContainer /* Comprobar Ejecución */
DO:
  DEFINE VARIABLE rid AS ROWID.
  
  IF Treemenu.accion <> ""
  THEN DO:
      IF SEARCH(Treemenu.accion:SCREEN-VALUE IN FRAME {&FRAME-NAME}) <> ?
      THEN DO:
           IF Treemenu.modo = "X"
              THEN RUN VALUE(Treemenu.accion:SCREEN-VALUE IN FRAME {&FRAME-NAME}).
              ELSE RUN VALUE(Treemenu.accion:SCREEN-VALUE IN FRAME {&FRAME-NAME}) ( INPUT-OUTPUT rid, INPUT INTEGER(Treemenu.modo) ).
      END.     
      ELSE DO:
           MESSAGE "No se halló " Treemenu.accion:SCREEN-VALUE IN FRAME {&FRAME-NAME}
                    VIEW-AS ALERT-BOX ERROR TITLE "No puede ejecutarse esta opción".
      END.
  END.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btn_exportar
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btn_exportar wWin
ON CHOOSE OF btn_exportar IN FRAME fContainer /* Exportar Rama */
DO:
    SYSTEM-DIALOG GET-FILE aux_archivo
        TITLE      "Exportar al archivo..."
        SAVE-AS
        ASK-OVERWRITE
        CREATE-TEST-FILE
        USE-FILENAME
        UPDATE puso_ok.

    IF puso_ok
    THEN DO:
         RUN exportar_rama ( INPUT aux_archivo ).
         MESSAGE "Exportación terminada" VIEW-AS ALERT-BOX MESSAGE.
    END.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btn_exportar_menu
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btn_exportar_menu wWin
ON CHOOSE OF btn_exportar_menu IN FRAME fContainer /* Menú Completo */
DO:                                   /*
    SYSTEM-DIALOG GET-FILE aux_archivo
        TITLE      "Exportar al archivo..."
        SAVE-AS
        ASK-OVERWRITE
        CREATE-TEST-FILE
        USE-FILENAME
        UPDATE puso_ok.

    IF puso_ok
    THEN DO:
        ASSIGN FRAME {&FRAME-NAME} v-que_modulo.
        RUN exportar_menu_completo ( INPUT aux_archivo ).
        MESSAGE "Exportación terminada" VIEW-AS ALERT-BOX MESSAGE.
    END.                                */
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btn_grabar
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btn_grabar wWin
ON CHOOSE OF btn_grabar IN FRAME fContainer /* Grabar */
DO:
    RUN adm-assign-statment.
    IF RETURN-VALUE <> "ERROR"
       THEN RUN adm-disable-fields.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btn_heredar
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btn_heredar wWin
ON CHOOSE OF btn_heredar IN FRAME fContainer /* Heredar permisos */
DO:
  DEFINE VARIABLE j_padre AS INTEGER.
  DEFINE VARIABLE sino AS LOGICAL.

  sino = NO.
  MESSAGE "Desea copiar los permisos de este nodo a todos sus nodos dependientes"
      VIEW-AS ALERT-BOX QUESTION BUTTONS YES-NO TITLE "Confirmación" SET sino.

  IF sino
  THEN DO:
      DO TRANSACTION:
          FOR EACH B-Treemenu WHERE B-Treemenu.cdg_item BEGINS Treemenu.cdg_item 
                                AND B-Treemenu.cdg_empresa = Treemenu.cdg_empresa
                                    EXCLUSIVE-LOCK:
    
              DO j_padre = 1 TO NUM-ENTRIES(Treemenu.permitidos,","):
                  IF LOOKUP(ENTRY(j_padre,Treemenu.permitidos,","),B-Treemenu.permitidos,",") = 0 
                  THEN DO:
                      B-Treemenu.permitidos = B-Treemenu.permitidos + "," + ENTRY(j_padre,Treemenu.permitidos,",").
                  END.
              END.
              IF SUBSTRING(B-Treemenu.permitidos,1,1) = ","
                  THEN B-Treemenu.permitidos = SUBSTRING(B-Treemenu.permitidos,2).
    
          END.
          RELEASE B-Treemenu.
      END.
  END.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btn_iconos
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btn_iconos wWin
ON CHOOSE OF btn_iconos IN FRAME fContainer /* Imágenes */
DO:
    DEFINE VARIABLE ok AS LOGICAL.
    DEFINE VARIABLE x-icono AS CHARACTER.
    DEFINE VARIABLE x-carpeta_inicial AS CHARACTER.
    DEFINE VARIABLE x-carpeta_default AS CHARACTER INITIAL ".\tvpics".
    DEFINE VARIABLE x-separador AS CHARACTER INITIAL "\".
    DEFINE VARIABLE j-carpeta AS INTEGER.

    ASSIGN x-icono = Treemenu.archivo_icono:SCREEN-VALUE IN FRAME {&FRAME-NAME}.

    x-icono = REPLACE(x-icono,"/","\").
    x-carpeta_inicial = "".
    DO j-carpeta = 1 TO NUM-ENTRIES(x-icono,x-separador) - 1:
        x-carpeta_inicial = x-carpeta_inicial + x-separador + ENTRY(j-carpeta,x-icono,x-separador).
    END.
    x-carpeta_inicial = SUBSTRING(x-carpeta_inicial,2).
    
    IF x-carpeta_inicial = ""
        THEN x-carpeta_inicial = x-carpeta_default.
    
    SYSTEM-DIALOG GET-FILE x-icono
          FILTERS "Mapas de Bits (*.BMP)" "*.bmp",
                  "Mapas de Bits (*.bmp)" "*.bmp"
          INITIAL-FILTER 1
          MUST-EXIST
          DEFAULT-EXTENSION ".bmp"
          INITIAL-DIR x-carpeta_inicial
          RETURN-TO-START-DIR 
          TITLE "Seleccione el archivo de imagen" 
          USE-FILENAME
          UPDATE puso_ok.

  IF puso_ok 
  THEN DO:
      FILE-INFO:FILE-NAME = ".".
      ASSIGN x-icono = REPLACE(x-icono,"Minus","")
             x-icono = REPLACE(x-icono,"Plus","")
             x-icono = REPLACE(x-icono,"noSIgn","")
             x-icono = REPLACE(x-icono,"Open","")
             x-icono = REPLACE(x-icono,FILE-INFO:FULL-PATHNAME + "\","").

      DISPLAY x-icono @ Treemenu.archivo_icono
                  WITH FRAME {&FRAME-NAME}.
  END.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btn_importar
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btn_importar wWin
ON CHOOSE OF btn_importar IN FRAME fContainer /* Import */
DO:

    DEFINE VARIABLE nue_empresa  LIKE Empresa.cdg_empresa.
    DEFINE VARIABLE modo_importa AS CHARACTER.
    DEFINE VARIABLE modo_rama    AS CHARACTER.

    SYSTEM-DIALOG GET-FILE aux_archivo
        TITLE      "Importar menu desde el archivo..."
        MUST-EXIST
        USE-FILENAME
        UPDATE puso_ok.

    IF puso_ok
    THEN DO:
         RUN d-que_empresa.w ( OUTPUT nue_empresa, OUTPUT modo_importa, OUTPUT modo_rama ).
         IF nue_empresa <> ?
         THEN DO:
              RUN importar_menu ( INPUT aux_archivo, INPUT nue_empresa, INPUT modo_importa, INPUT modo_rama ).
              MESSAGE "Importación terminada" VIEW-AS ALERT-BOX MESSAGE.
         END.     
    END.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btn_programas
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btn_programas wWin
ON CHOOSE OF btn_programas IN FRAME fContainer /* Programas */
DO:
    DEFINE VARIABLE ok AS LOGICAL.
    DEFINE VARIABLE x-programa AS CHARACTER.
        DEFINE VARIABLE x-carpeta_inicial AS CHARACTER.
    DEFINE VARIABLE x-carpeta_default AS CHARACTER INITIAL ".\".
    DEFINE VARIABLE x-separador AS CHARACTER INITIAL "\".
    DEFINE VARIABLE j-carpeta AS INTEGER.

    ASSIGN x-programa = Treemenu.accion:SCREEN-VALUE IN FRAME {&FRAME-NAME}.

    x-programa = REPLACE(x-programa,"/","\").
    x-carpeta_inicial = "".
    DO j-carpeta = 1 TO NUM-ENTRIES(x-programa,x-separador) - 1:
        x-carpeta_inicial = x-carpeta_inicial + x-separador + ENTRY(j-carpeta,x-programa,x-separador).
    END.
    x-carpeta_inicial = SUBSTRING(x-carpeta_inicial,2).
    
    IF x-carpeta_inicial = ""
        THEN x-carpeta_inicial = x-carpeta_default.
    
    SYSTEM-DIALOG GET-FILE x-programa
          FILTERS "Programas (*.w)" "*.w",
                  "Programas (*.p)" "*.p"
          INITIAL-FILTER 1
          MUST-EXIST
          DEFAULT-EXTENSION ".w"
          INITIAL-DIR x-carpeta_inicial
          RETURN-TO-START-DIR 
          TITLE "Seleccione el programa a ejecutar" 
          USE-FILENAME
          UPDATE puso_ok.

  IF puso_ok 
  THEN DO:
      FILE-INFO:FILE-NAME = ".".
      ASSIGN x-programa = REPLACE(x-programa,FILE-INFO:FULL-PATHNAME + "\","").

      DISPLAY x-programa @ Treemenu.accion
                  WITH FRAME {&FRAME-NAME}.
      IF SEARCH(x-programa) = ? AND search(entry(1,x-programa,".") + ".r" ) = ? THEN 
          MESSAGE "Tenga en cuenta que este programa no existe"
              VIEW-AS ALERT-BOX INFO BUTTONS OK.
  END.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btn_updatenode
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btn_updatenode wWin
ON CHOOSE OF btn_updatenode IN FRAME fContainer /* Modificar */
DO:
    RUN adm-enable-fields.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME v-cdg_empresa
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-cdg_empresa wWin
ON VALUE-CHANGED OF v-cdg_empresa IN FRAME fContainer /* Empresa */
DO:
    ASSIGN v-cdg_empresa.
    RUN emptyTree IN h_pure4gltv.  
    DO TRANSACTION:
        FIND Usuario WHERE Usuario.cdg_usuario = USERID("sic") EXCLUSIVE-LOCK.
        Usuario.cdg_empresa = v-cdg_empresa.
        RELEASE Usuario.
    END.
    RUN levantar_ambiente.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&UNDEFINE SELF-NAME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _MAIN-BLOCK wWin 


/* ***************************  Main Block  *************************** */

/* Include custom  Main Block code for SmartWindows. */
{src/adm2/windowmn.i}


/*   This was a bad idea to run a test instance persistently form protools/run
 so I could interact with it.  when running the window directly form the AppBuilder
 I was initializing the window and smartTV twice, resulting in 2 sets of widgets
 for the scrollbar....
  It is better to use runit.w from protools/run with persistent option.  This 
 last guy will take care of initializeing the window.
  
    Anyway, I have added a protection to not call initializeObject twice in the
     4GLTreeview object 
RUN initializeObject.
  */

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


/* **********************  Internal Procedures  *********************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE adm-add-record wWin 
PROCEDURE adm-add-record :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

  CLEAR FRAME {&FRAME-NAME} ALL.
  ASSIGN Treemenu.descripcion:SCREEN-VALUE IN FRAME {&FRAME-NAME} = ""
         Treemenu.permitidos:SCREEN-VALUE IN FRAME {&FRAME-NAME} = "".
  RUN adm-enable-fields.
  ES_ALTA = YES.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE adm-assign-record wWin 
PROCEDURE adm-assign-record :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

  DEFINE VARIABLE n                    AS INTEGER   NO-UNDO.
  DEFINE VARIABLE j                    AS INTEGER   NO-UNDO.
  DEFINE VARIABLE l                    AS INTEGER   NO-UNDO.
  DEFINE VARIABLE v-item               AS CHARACTER NO-UNDO.
  DEFINE VARIABLE v-codigo_padre       AS CHARACTER NO-UNDO.
  DEFINE VARIABLE lmovernodo           AS LOGICAL   NO-UNDO.
  DEFINE VARIABLE v-old_nodo           LIKE Treemenu.cdg_item.
  DEFINE VARIABLE x-padre              LIKE Submenu.cdg_padre.

  DO TRANSACTION WITH FRAME {&FRAME-NAME}:

      IF ES_ALTA
      THEN DO:
          lmovernodo = FALSE.
          CREATE Treemenu.
      END.
      ELSE DO:
          ASSIGN lmovernodo = Treemenu.cdg_item <> Treemenu.cdg_item:INPUT-VALUE
                 v-old_nodo = Treemenu.cdg_item.
          FIND CURRENT Treemenu EXCLUSIVE-LOCK.
      END.
    
      ASSIGN FRAME {&FRAME-NAME}
          Treemenu.archivo_help 
          Treemenu.cdg_item 
          Treemenu.descripcion 
          Treemenu.permitidos 
          Treemenu.titulo
          Treemenu.archivo_icono 
          Treemenu.cdg_comprobante 
          Treemenu.accion 
          Treemenu.modo.

      IF Treemenu.cdg_comprobante = "Z" THEN Treemenu.cdg_comprobante = "".

      Treemenu.cdg_empresa = v-cdg_empresa.

      Treemenu.cdg_padre = fnPadre(Treemenu.cdg_item).
      Treemenu.permitidos = REPLACE(Treemenu.permitidos ,CHR(10) ,"").
      Treemenu.permitidos = REPLACE(Treemenu.permitidos ,CHR(13) ,"").

      IF ES_ALTA
      THEN DO:

          RUN addNode IN h_pure4gltv (Treemenu.cdg_item
                               ,Treemenu.cdg_padre
                               ,Treemenu.titulo
                               ,IF Treemenu.archivo_icono = "" 
                                   THEN ( IF CAN-FIND(FIRST Submenu WHERE Submenu.cdg_padre = Treemenu.cdg_item ) 
                                             OR boton_habilito = "btn_copyrama" THEN v-icono_submenu ELSE  v-icono_programa )
                                                               ELSE Treemenu.archivo_icono
                               ,IF CAN-FIND(FIRST Submenu WHERE Submenu.cdg_padre = Treemenu.cdg_item ) 
                                   OR boton_habilito = "btn_copyrama" THEN "addOnExpand" ELSE "") NO-ERROR.
          IF ERROR-STATUS:ERROR THEN MESSAGE RETURN-VALUE.
    
          IF Treemenu.cdg_padre <> ""
          THEN DO:
              FIND B-Treemenu 
                  WHERE B-Treemenu.cdg_item = Treemenu.cdg_padre
                    AND B-Treemenu.cdg_empresa = Treemenu.cdg_empresa
                        NO-LOCK.
              /*
              updOptn   = REPLACE(updoptn,"#", CHR(1)).
              updOptn   = REPLACE(updoptn,"@", CHR(2)).
    
              updLabIco = REPLACE(updLabIco,"#", CHR(1)).
              */
    
              RUN updateNode IN h_pure4gltv  ( B-Treemenu.cdg_item
                                               ,"lab,ico" 
                                               ,B-Treemenu.titulo + CHR(1) + IF B-Treemenu.archivo_icono = "" THEN v-icono_submenu ELSE B-Treemenu.archivo_icono
                                               ,"refresh" + CHR(1) + "Addonexpand" + CHR(1) + "Expanded") NO-ERROR.
              IF ERROR-STATUS:ERROR THEN MESSAGE RETURN-VALUE.
    
              RELEASE B-Treemenu.
    
          END.

      END.
      ELSE DO:
          IF lmovernodo
          THEN DO:
              /* Da de baja los subnodos asociados al nodo que se esta moviendo */
              FOR EACH Submenu WHERE Submenu.cdg_empresa = Treemenu.cdg_empresa
                                 AND Submenu.cdg_padre BEGINS v-old_nodo EXCLUSIVE-LOCK:

                  RUN deletenode IN h_pure4gltv (Submenu.cdg_item,"") NO-ERROR.
                  IF ERROR-STATUS:ERROR THEN MESSAGE RETURN-VALUE.
                  
                  ASSIGN Submenu.cdg_item = REPLACE(Submenu.cdg_item,v-old_nodo,Treemenu.cdg_item).
                  ASSIGN x-padre = fnPadre(Submenu.cdg_item)
                         Submenu.cdg_padre = x-padre.
              END.

              /* Baja y realta del nodo que se esta moviendo */
              RUN deletenode IN h_pure4gltv (v-old_nodo,"refresh") NO-ERROR.
              IF ERROR-STATUS:ERROR THEN MESSAGE RETURN-VALUE.
              RUN addNode IN h_pure4gltv (Treemenu.cdg_item
                                   ,Treemenu.cdg_padre
                                   ,Treemenu.titulo
                                   ,IF Treemenu.archivo_icono = "" THEN v-icono_programa ELSE Treemenu.archivo_icono
                                   ,IF CAN-FIND(FIRST Submenu WHERE Submenu.cdg_padre = Treemenu.cdg_item ) THEN "addOnExpand" ELSE "") NO-ERROR.
              IF ERROR-STATUS:ERROR THEN MESSAGE RETURN-VALUE.

              /* Realta de los subnodos asociados al nodo que se esta moviendo */
              FOR EACH Submenu WHERE Submenu.cdg_empresa = Treemenu.cdg_empresa
                                 AND Submenu.cdg_padre BEGINS Treemenu.cdg_item EXCLUSIVE-LOCK:

                  RUN addNode IN h_pure4gltv (Submenu.cdg_item
                                       ,Submenu.cdg_padre
                                       ,Submenu.titulo
                                       ,IF Submenu.archivo_icono = "" THEN v-icono_programa ELSE Submenu.archivo_icono
                                       ,IF CAN-FIND(FIRST B-Submenu WHERE B-Submenu.cdg_padre = Submenu.cdg_item
                                                                      AND B-Submenu.cdg_empresa = Submenu.cdg_empresa ) THEN "addOnExpand" ELSE "") NO-ERROR.
                  IF ERROR-STATUS:ERROR THEN MESSAGE RETURN-VALUE.
                /*  DYNAMIC-FUNCTION('tvRefresh':U IN h_pure4gltv).*/

              END.

          END.
          ELSE DO:
              RUN updateNode IN h_pure4gltv  ( Treemenu.cdg_item
                                               ,"lab,ico" 
                                               ,Treemenu.titulo + CHR(1) + 
                                                IF Treemenu.archivo_icono = "" 
                                                   THEN IF CAN-FIND(FIRST B-Treemenu 
                                                                          WHERE B-Treemenu.cdg_padre = Treemenu.cdg_item
                                                                            AND B-Treemenu.cdg_empresa = Treemenu.cdg_empresa ) 
                                                           THEN v-icono_submenu 
                                                           ELSE v-icono_programa
                                                   ELSE Treemenu.archivo_icono
                                               ,"refresh" + CHR(1) + "Addonexpand" + CHR(1) + "Expanded") NO-ERROR.
          END.
      END.

      FIND CURRENT Treemenu NO-LOCK.

  END. /* De la transaccion */

  DYNAMIC-FUNCTION('tvRefresh':U IN h_pure4gltv).


END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE adm-assign-statment wWin 
PROCEDURE adm-assign-statment :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

  DEFINE VARIABLE sino         AS LOGICAL.
  DEFINE VARIABLE v-old_padre  LIKE Treemenu.cdg_item.

  DEFINE VARIABLE v-new_item   LIKE Treemenu.cdg_item.
  DEFINE VARIABLE v-new_padre  LIKE Treemenu.cdg_padre.

  DO WITH FRAME {&FRAME-NAME}:

      IF boton_habilito = "btn_copyrama"
          THEN v-old_padre = Treemenu.cdg_item.
          ELSE v-old_padre = ?.

      IF Treemenu.cdg_item:INPUT-VALUE = ""
      THEN DO:
          RUN ponmensj.p ( INPUT "TREE001").
          RETURN ERROR.
      END.

      IF ES_ALTA
      THEN DO:
          IF CAN-FIND(B-Treemenu WHERE B-Treemenu.cdg_item    = Treemenu.cdg_item:INPUT-VALUE
                                   AND B-Treemenu.cdg_empresa = v-cdg_empresa)
          THEN DO:
              RUN mensajepar.p ( INPUT Treemenu.cdg_item:INPUT-VALUE + CHR(1) + v-cdg_empresa , INPUT "TREE006").
              RETURN ERROR.
          END.
      END.
      ELSE DO:
          IF CAN-FIND(B-Treemenu WHERE B-Treemenu.cdg_item    = Treemenu.cdg_item:INPUT-VALUE
                                   AND B-Treemenu.cdg_empresa = v-cdg_empresa
                                   AND ROWID(B-Treemenu) <> ROWID(Treemenu) )
          THEN DO:
              RUN mensajepar.p ( INPUT Treemenu.cdg_item:INPUT-VALUE + CHR(1) + v-cdg_empresa , INPUT "TREE006").
              RETURN ERROR.
          END.
      END.

      IF NOT CAN-FIND(B-Treemenu WHERE B-Treemenu.cdg_item    = fnPadre(Treemenu.cdg_item:INPUT-VALUE)
                                   AND B-Treemenu.cdg_empresa = v-cdg_empresa)
      THEN DO:
          RUN mensajepar.p ( INPUT fnPadre(Treemenu.cdg_item:INPUT-VALUE) + CHR(1) + v-cdg_empresa , INPUT "TREE002").
          RETURN ERROR.
      END.

      IF Treemenu.titulo:INPUT-VALUE = ""
      THEN DO:
          RUN ponmensj.p ( INPUT "TREE003").
          RETURN ERROR.
      END.

      IF Treemenu.permitidos:INPUT-VALUE = ""
      THEN DO:
          RUN ponmensj.p ( INPUT "TREE004").
          RETURN ERROR.
      END.

  END.

  RUN adm-assign-record.
      
  IF boton_habilito = "btn_copyrama"
  THEN DO:

      EMPTY TEMP-TABLE T-Treemenu.

      FOR EACH B-Treemenu WHERE B-Treemenu.cdg_padre BEGINS v-old_padre:
             
          CREATE T-Treemenu.
          BUFFER-COPY B-Treemenu TO T-Treemenu.

      END.

      FOR EACH T-Treemenu:

          ASSIGN v-new_item = Treemenu.cdg_item + SUBSTRING(T-Treemenu.cdg_item,LENGTH(v-old_padre) + 1)
                 v-new_padre = fnPadre(v-new_item).

          CREATE C-Treemenu.
          BUFFER-COPY T-Treemenu TO C-Treemenu
              ASSIGN C-Treemenu.cdg_item  = v-new_item 
                     C-Treemenu.cdg_padre = v-new_padre.
      END.

  END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE adm-create-objects wWin  _ADM-CREATE-OBJECTS
PROCEDURE adm-create-objects :
/*------------------------------------------------------------------------------
  Purpose:     Create handles for all SmartObjects used in this procedure.
               After SmartObjects are initialized, then SmartLinks are added.
  Parameters:  <none>
------------------------------------------------------------------------------*/
  DEFINE VARIABLE currentPage  AS INTEGER NO-UNDO.

  ASSIGN currentPage = getCurrentPage().

  CASE currentPage: 

    WHEN 0 THEN DO:
       RUN constructObject (
             INPUT  'pure4gltv.w':U ,
             INPUT  FRAME fContainer:HANDLE ,
             INPUT  'wineModeAutomaticwindowsSkinAutomaticpicCacheCoef1labCacheCoef1tvIterationHeight17TreeStyle3FocSelNodeBgColor1UnfSelNodeBgColor8tvnodeDefaultFont1FocSelNodeFgColor15UnfSelNodeFgColor1resizeVerticalyesresizeHorizontalyesDragSourceallautoSortyesMSkeyScrollForcePaintyesHideOnInitnoDisableOnInitnoObjectLayout':U ,
             OUTPUT h_pure4gltv ).
       RUN repositionObject IN h_pure4gltv ( 2.19 , 16.00 ) NO-ERROR.
       RUN resizeObject IN h_pure4gltv ( 12.86 , 112.00 ) NO-ERROR.

       /* Links to pure4glTv h_pure4gltv. */
       RUN addLink ( h_pure4gltv , 'tvNodeEvent':U , THIS-PROCEDURE ).

       /* Adjust the tab order of the smart objects. */
       RUN adjustTabOrder ( h_pure4gltv ,
             v-codigo_destino:HANDLE IN FRAME fContainer , 'AFTER':U ).
    END. /* Page 0 */

  END CASE.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE adm-delete-record wWin 
PROCEDURE adm-delete-record :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

    DEFINE VARIABLE v-cdg_padre     LIKE Treemenu.cdg_padre.   
    DEFINE VARIABLE v-cdg_empresa   LIKE Treemenu.cdg_empresa. 

    ASSIGN v-cdg_padre     = Treemenu.cdg_padre   
           v-cdg_empresa   = Treemenu.cdg_empresa. 

    RUN deletenode IN h_pure4gltv (Treemenu.cdg_item
                                   ,"refresh") NO-ERROR.
    IF ERROR-STATUS:ERROR THEN MESSAGE RETURN-VALUE.
    ELSE DO:
        DO TRANSACTION:
            FOR EACH Submenu WHERE Submenu.cdg_padre BEGINS Treemenu.cdg_item 
                               AND Submenu.cdg_empresa = Treemenu.cdg_empresa 
                                   EXCLUSIVE-LOCK:
                DELETE Submenu.
            END.
            FIND CURRENT Treemenu.
            DELETE Treemenu.
        END.
    END.
    
    /* Si el nodo eliminado pertenecía a una estructura, hay que ver si el padre  */
    /* tiene otros hijos para cambiar el icono en caso contrario                  */

    IF v-cdg_padre <> "" 
    THEN DO:

        FIND B-Treemenu 
            WHERE B-Treemenu.cdg_item = v-cdg_padre
              AND B-Treemenu.cdg_empresa = v-cdg_empresa
                  NO-LOCK.
    
        IF NOT CAN-FIND(FIRST Treemenu
                              WHERE Treemenu.cdg_padre   = B-Treemenu.cdg_item     
                                AND Treemenu.cdg_empresa = B-Treemenu.cdg_empresa)
        THEN DO:
            RUN updateNode IN h_pure4gltv  ( B-Treemenu.cdg_item
                                             ,"lab,ico" 
                                             ,B-Treemenu.titulo + CHR(1) + IF B-Treemenu.archivo_icono <> "" THEN B-Treemenu.archivo_icono ELSE v-icono_programa
                                             ,"refresh" + CHR(1) + "!Addonexpand" + CHR(1) + "!Expanded") NO-ERROR.
            IF ERROR-STATUS:ERROR THEN MESSAGE RETURN-VALUE.
        END.
     
        RELEASE B-Treemenu.
    
    END.

  

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE adm-disable-fields wWin 
PROCEDURE adm-disable-fields :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
  ENABLE ALL EXCEPT {&LIST-2}
      WITH FRAME {&FRAME-NAME}.

  DISABLE {&LIST-1}
      WITH FRAME {&FRAME-NAME}.

  ASSIGN Treemenu.descripcion:FGCOLOR IN FRAME {&FRAME-NAME} = 7
         Treemenu.permitidos:FGCOLOR IN FRAME {&FRAME-NAME} = 7.

  RUN habilitar_abm ( YES ).
  RUN habilitar_edit ( NO ).

  btn_done:SENSITIVE IN FRAME {&FRAME-NAME} = YES.
  ES_ALTA = NO.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE adm-display-fields wWin 
PROCEDURE adm-display-fields :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

    DISPLAY
        Treemenu.archivo_help 
        Treemenu.cdg_item 
        Treemenu.cdg_padre 
        Treemenu.descripcion 
        Treemenu.permitidos 
        Treemenu.titulo
        Treemenu.archivo_icono 
        Treemenu.cdg_comprobante  
        Treemenu.accion 
        Treemenu.modo
        WITH FRAME {&FRAME-NAME}.
    IF Treemenu.accion <> "" 
    THEN DO:
        IF SEARCH(Treemenu.accion) = ? AND SEARCH(ENTRY(1,Treemenu.accion,".") + ".r" ) = ? 
        THEN DO:
           Treemenu.accion:BGCOLOR = 12.
           Treemenu.accion:FGCOLOR = 15.
        END.
        ELSE DO:
           Treemenu.accion:BGCOLOR = 15.
           Treemenu.accion:FGCOLOR = 9.
        END.
    END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE adm-enable-fields wWin 
PROCEDURE adm-enable-fields :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

  DISABLE ALL WITH FRAME {&FRAME-NAME}.

  boton_habilito = SELF:NAME.

  ENABLE {&LIST-1}
      WITH FRAME {&FRAME-NAME}.
  
  RUN habilitar_abm ( NO ).
  RUN habilitar_edit ( YES ).

  ASSIGN Treemenu.descripcion:FGCOLOR IN FRAME {&FRAME-NAME} = 9
         Treemenu.permitidos:FGCOLOR IN FRAME {&FRAME-NAME} = 9.
         Treemenu.descripcion:SENSITIVE IN FRAME {&FRAME-NAME} = TRUE.
         Treemenu.permitidos:SENSITIVE IN FRAME {&FRAME-NAME} = TRUE.
         Treemenu.descripcion:READ-ONLY IN FRAME {&FRAME-NAME} = FALSE.
         Treemenu.permitidos:READ-ONLY IN FRAME {&FRAME-NAME} = FALSE.



  btn_done:SENSITIVE IN FRAME {&FRAME-NAME} = NO.
  
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE armar_titulo wWin 
PROCEDURE armar_titulo :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

  DEFINE OUTPUT PARAMETER p-titulo AS CHARACTER.
  
  {findempresa.i}

  p-titulo = "DYNASYS " + NRO_RELEASE /*VERSION_SIC*/ + " - " + "F" + 
                         " - " + " User:" + USERID("sic") + " - DB:" + PDBNAME("sic").

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE carga_inicial wWin 
PROCEDURE carga_inicial :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/



    DO ON ERROR UNDO, LEAVE:
    
        FOR EACH Treemenu NO-LOCK 
            WHERE Treemenu.cdg_padre = "" 
              AND Treemenu.cdg_empresa = v-cdg_empresa
              AND Treemenu.cdg_item <> ""
              AND CAN-FIND (FIRST Usuario_funcion OF Usuario 
                                  WHERE Usuario_funcion.cdg_empresa = Treemenu.cdg_empresa
                                    AND CAN-DO(Treemenu.permitidos,Usuario_funcion.cdg_funcion))
                                               BY Treemenu.cdg_item:
    
            RUN addNode IN h_pure4gltv (Treemenu.cdg_item
                                       ,""
                                       ,Treemenu.titulo
                                       ,IF Treemenu.archivo_icono = "" THEN v-icono_submenu ELSE Treemenu.archivo_icono
                                       ,IF CAN-FIND(FIRST Submenu WHERE Submenu.cdg_padre = Treemenu.cdg_item ) THEN "addOnExpand" ELSE "").

        END. 
    
    END.

    DYNAMIC-FUNCTION('tvRefresh':U IN h_pure4gltv).
    
    IF lTraceEvents THEN addToEdMsg("TV loaded in " + STRING(ETIME - iEtime) + " ms~n").
    /*
    IF ERROR-STATUS:ERROR THEN MESSAGE RETURN-VALUE.
    APPLY 'CHOOSE' TO btnDisplay.
    */

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE conectar_ambiente wWin 
PROCEDURE conectar_ambiente :
/*------------------------------------------------------------------------------
  Purpose: CONECTA UN AMBIENTE EN PARTICULAR. INVOCA VALIDACION DE LA LICENCIA
           DE USO    
  Parameters:  hubo_logon QUE INDICA SI TODO ANDUVO BIEN
  Notes:       
------------------------------------------------------------------------------*/

   DEFINE OUTPUT PARAMETER hubo_logon AS LOGICAL.
   
   {&WINDOW-NAME}:SENSITIVE = NO.
   RUN c-logon.W ( OUTPUT codigo_salir,  OUTPUT entidad_logon).
   {&WINDOW-NAME}:SENSITIVE = YES.

   IF codigo_salir = CD_CANCELAR
   THEN DO:
        hubo_logon = NO.
   END.
   ELSE DO:
       hubo_logon = YES.
       RUN levantar_ambiente.
   END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE disable_UI wWin  _DEFAULT-DISABLE
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
  IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(wWin)
  THEN DELETE WIDGET wWin.
  IF THIS-PROCEDURE:PERSISTENT THEN DELETE PROCEDURE THIS-PROCEDURE.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE enable_UI wWin  _DEFAULT-ENABLE
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

  {&OPEN-QUERY-fContainer}
  GET FIRST fContainer.
  DISPLAY v-cdg_empresa v-codigo_mover v-codigo_destino v-que_empresa 
      WITH FRAME fContainer IN WINDOW wWin.
  IF AVAILABLE Treemenu THEN 
    DISPLAY Treemenu.cdg_padre Treemenu.cdg_item Treemenu.titulo Treemenu.accion 
          Treemenu.cdg_comprobante Treemenu.modo Treemenu.archivo_help 
          Treemenu.archivo_icono Treemenu.permitidos Treemenu.descripcion 
      WITH FRAME fContainer IN WINDOW wWin.
  ENABLE v-cdg_empresa Btn_Done btn_exportar btn_exportar_menu btn_importar 
         btn_copiar v-que_empresa btn_ejecutar btn_heredar Treemenu.permitidos 
         Treemenu.descripcion 
      WITH FRAME fContainer IN WINDOW wWin.
  {&OPEN-BROWSERS-IN-QUERY-fContainer}
  VIEW wWin.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE exitObject wWin 
PROCEDURE exitObject :
/*------------------------------------------------------------------------------
  Purpose:  Window-specific override of this procedure which destroys 
            its contents and itself.
    Notes:  
------------------------------------------------------------------------------*/

  APPLY "CLOSE":U TO THIS-PROCEDURE.
  RETURN.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE exportar_rama wWin 
PROCEDURE exportar_rama :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

  DEFINE INPUT PARAMETER a-salida AS CHARACTER.

  OUTPUT TO VALUE(a-salida) PAGE-SIZE 0.
  EXPORT Delimiter "@" Treemenu.
  FOR EACH B-Treemenu NO-LOCK 
      WHERE B-Treemenu.cdg_padre BEGINS Treemenu.cdg_item 
        AND B-Treemenu.cdg_empresa = Treemenu.cdg_empresa
            BY B-Treemenu.cdg_item:

      EXPORT Delimiter "@" B-Treemenu.
  
  END.
  OUTPUT CLOSE.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE habilitar_abm wWin 
PROCEDURE habilitar_abm :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

    DEFINE INPUT PARAMETER p-sino AS LOGICAL.

    ASSIGN btn_addnode:SENSITIVE IN FRAME {&FRAME-NAME} = p-sino
           btn_addsubnode:SENSITIVE IN FRAME {&FRAME-NAME} = p-sino
           btn_updatenode:SENSITIVE IN FRAME {&FRAME-NAME} = p-sino
           btn_copynode:SENSITIVE IN FRAME {&FRAME-NAME} = p-sino
           btn_copyrama:SENSITIVE IN FRAME {&FRAME-NAME} = p-sino
           btn_deletenode:SENSITIVE IN FRAME {&FRAME-NAME} = p-sino.
               
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE habilitar_edit wWin 
PROCEDURE habilitar_edit :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
    DEFINE INPUT PARAMETER p-sino AS LOGICAL.

    ASSIGN btn_grabar:SENSITIVE IN FRAME {&FRAME-NAME} = p-sino
           btn_cancelar:SENSITIVE IN FRAME {&FRAME-NAME} = p-sino
           btn_deshacer:SENSITIVE IN FRAME {&FRAME-NAME} = p-sino.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE importar_menu wWin 
PROCEDURE importar_menu :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

  DEFINE INPUT PARAMETER a-entrada    AS CHARACTER.
  DEFINE INPUT PARAMETER nue_empresa  AS CHARACTER.
  DEFINE INPUT PARAMETER modo_bajada  AS CHARACTER.
  DEFINE INPUT PARAMETER modo_rama    AS CHARACTER.

  DEFINE VARIABLE v-cdg_item LIKE Treemenu.cdg_item.
  DEFINE VARIABLE v-nue_item LIKE Treemenu.cdg_item.

  DEFINE VARIABLE j-item     AS INTEGER.

  v-cdg_item = Treemenu.cdg_item.

  EMPTY TEMP-TABLE T-Treemenu.

  INPUT FROM VALUE(a-entrada) PAGE-SIZE 0.
  REPEAT:
      CREATE T-Treemenu.
      IMPORT Delimiter "@" T-Treemenu.
  END.
  INPUT CLOSE.

  IF modo_bajada = "reemplazar"
  THEN DO:
      FOR EACH Treemenu WHERE Treemenu.cdg_empresa = nue_empresa EXCLUSIVE-LOCK :
                          /*AND Treemenu.cdg_item BEGINS v-que_modulo:SCREEN-VALUE IN FRAME {&FRAME-NAME}:*/
           DELETE Treemenu.
      END.    
  END.
      
  FOR EACH T-Treemenu:

      CASE modo_bajada:

           WHEN "reemplazar"
           THEN DO:
                CREATE Treemenu.
                BUFFER-COPY T-Treemenu TO Treemenu 
                            ASSIGN Treemenu.cdg_empresa = nue_empresa.
           END.

           WHEN "actualizar"
           THEN DO:
                FIND Treemenu WHERE Treemenu.cdg_empresa = nue_empresa
                                AND Treemenu.cdg_item    = T-Treemenu.cdg_item EXCLUSIVE-LOCK NO-ERROR.
                IF NOT AVAILABLE Treemenu THEN CREATE Treemenu.            
                BUFFER-COPY T-Treemenu TO Treemenu 
                            ASSIGN Treemenu.cdg_empresa = nue_empresa.
           END.
           WHEN "agregar"
           THEN DO:
               CASE modo_rama:

                   WHEN "absoluto"
                   THEN DO:     
                       FIND Treemenu WHERE Treemenu.cdg_empresa = nue_empresa
                                   AND Treemenu.cdg_item    = T-Treemenu.cdg_item EXCLUSIVE-LOCK NO-ERROR.
                       IF NOT AVAILABLE Treemenu 
                       THEN DO:
                           CREATE Treemenu.            
                           BUFFER-COPY T-Treemenu TO Treemenu 
                                     ASSIGN Treemenu.cdg_empresa = nue_empresa.
                       END.
                   END.

                   WHEN "relativo"
                   THEN DO:     
                       v-nue_item = v-cdg_item.
                       DO j-item = 2 TO NUM-ENTRIES(T-Treemenu.cdg_item,"."):
                           v-nue_item = v-nue_item + "." + ENTRY(j-item,T-Treemenu.cdg_item,".").
                       END.
                       CREATE Treemenu.            
                       BUFFER-COPY T-Treemenu TO Treemenu 
                                 ASSIGN Treemenu.cdg_empresa = nue_empresa
                                        Treemenu.cdg_item = v-nue_item.
                   END.

               END CASE.
           END.
   
      END CASE.     

      DELETE T-Treemenu.

  END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE inicia_combo wWin 
PROCEDURE inicia_combo :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

  DEFINE VARIABLE ok AS LOGICAL.
  DEFINE VARIABLE lista AS CHARACTER.

  {findempresa.i}

  DO WITH FRAME {&FRAME-NAME}:
      lista = "[Sin Comprobante]|Z".
      Treemenu.cdg_comprobante:DELIMITER = "|".
      FOR EACH Tipocomprobante NO-LOCK WHERE Tipocomprobante.cdg_empresa = Empresa.cdg_empresa BY Tipocomprobante.dsc_comprobante:
          lista = lista + "|" + TRIM(Tipocomprobante.dsc_comprobante) + " - " + STRING(Tipocomprobante.cdg_comprobante) + "|" + STRING(Tipocomprobante.cdg_comprobante).
      END.
      Treemenu.cdg_comprobante:LIST-ITEM-PAIRS = lista.
  END.          
  
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE initializeObject wWin 
PROCEDURE initializeObject :
/*------------------------------------------------------------------------------
  Purpose:     Super Override
  Parameters:  
  Notes:       
------------------------------------------------------------------------------*/

  /* Code placed here will execute PRIOR to standard behavior. */
RUN inicia_combo.
  RUN SUPER.

  /* Code placed here will execute AFTER standard behavior.    */
  wwin:MAX-WIDTH-PIXELS = SESSION:WIDTH-PIXELS * 2 NO-ERROR.
  wWin:MIN-WIDTH-PIXELS = wWin:WIDTH-PIXELS - 100.
  /*
  btnEmptyTv:LOAD-MOUSE-POINTER("CROSS") IN FRAME fMain. /* to test if effective with drag and drop
                                                          => well, apparently, it is not */
  */
  
  DO TRANSACTION:
      FIND FIRST Usuario WHERE Usuario.cdg_usuario = USERID("SIC") EXCLUSIVE-LOCK.
    /*Usuario.cdg_empresa = "F".*/
      FIND CURRENT Usuario NO-LOCK.
  END.

  RUN levantar_ambiente.
 
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE levantar_ambiente wWin 
PROCEDURE levantar_ambiente :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

  RUN verpermiso.p ( OUTPUT cod_aut ).
    
  RUN cargar_parametros.p.

  FIND FIRST Usuario WHERE Usuario.cdg_usuario = USERID("SIC") NO-LOCK.

  act_usuario = ROWID(Usuario).
  RUN armar_titulo ( OUTPUT titulo ).
  RUN poner_sesion ( INPUT cod_aut = 0 , INPUT titulo ).

  {setwintit.i "SIC/BAS" "Mantenimiento de menúes"}

  RUN levantar_empresas.

  RUN carga_inicial.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE levantar_empresas wWin 
PROCEDURE levantar_empresas :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

    DEFINE VARIABLE lista AS CHARACTER.

    DO WITH FRAME {&FRAME-NAME}:

        v-cdg_empresa:DELIMITER = "|".
        lista = "".
        FOR EACH User_empresa OF Usuario 
                   WHERE User_empresa.rige_desde <= TODAY /*v-fecha_proceso*/
                     AND User_empresa.rige_hasta >= TODAY /*v-fecha_proceso*/ NO-LOCK,
            FIRST B-Empresa OF User_empresa NO-LOCK BY B-Empresa.nombre:
    
            lista = lista + "|" + TRIM(B-Empresa.nombre) + "|" + STRING(B-Empresa.cdg_empresa).
    
        END.

        v-cdg_empresa:LIST-ITEM-PAIRS = SUBSTRING(lista,2).
        {findempresa.i}
        v-cdg_empresa = Usuario.cdg_empresa.
        DISPLAY v-cdg_empresa.

    END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE loadDirectory wWin 
PROCEDURE loadDirectory :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEFINE INPUT  PARAMETER pcParentKey AS CHARACTER  NO-UNDO.
DEFINE INPUT  PARAMETER cDir      AS CHARACTER  NO-UNDO.

DEFINE VARIABLE iEtime AS INTEGER    NO-UNDO.
iEtime = ETIME.


DEFINE VARIABLE cFileName   AS CHARACTER  NO-UNDO.
DEFINE VARIABLE cFullPath   AS CHARACTER  NO-UNDO.
DEFINE VARIABLE cAttr       AS CHARACTER  NO-UNDO.
DEFINE VARIABLE ico         AS CHARACTER  NO-UNDO.
DEFINE VARIABLE optn        AS CHARACTER  NO-UNDO.


EMPTY TEMP-TABLE osFile. /* should be useless now */

/* First load the directory in a temp-table so we can sort it afterwards */
INPUT FROM OS-DIR(cDir).
REPEAT:
    IMPORT cfileName cFullPath cAttr.
    
    IF cFileName = ".."  THEN NEXT.
    IF cFileName = "."   THEN NEXT.
    
    CREATE osFile.
    ASSIGN
     osFile.cFileName = cFileName
     osFile.cFullPath = cFullPath
     osFile.cAttr     = cAttr.
END.
INPUT CLOSE.

/* now, load the nodes */
FOR EACH osFile
 BY osFile.cAttr /* the directories ("D") will come first */
 BY osFile.cFileName:
    IF osFile.cAttr = "D" THEN ASSIGN
     ico = "tvpics/fold"
     optn = "addOnExpand".
    ELSE ASSIGN
     ico = "tvpics/blankSheet"
     optn = "".
    
    RUN addNode IN h_pure4gltv  ("fileName=" + osFile.cFullPath
                                ,pcParentKey
                                ,osFile.cFileName
                                ,ico
                                ,optn) NO-ERROR.
    
    IF ERROR-STATUS:ERROR THEN DO:
        EMPTY TEMP-TABLE osFile.
        MESSAGE RETURN-VALUE VIEW-AS ALERT-BOX INFO BUTTONS OK.
        RETURN ERROR.
    END.
END.

EMPTY TEMP-TABLE osFile.

IF lTraceEvents THEN addToEdMsg("File system TV loaded in " + STRING(ETIME - iEtime) + " ms~n").

/*APPLY 'CHOOSE' TO btnDisplay IN FRAME fMain.*/

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE mostrar_ayuda wWin 
PROCEDURE mostrar_ayuda :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

    DEFINE VARIABLE hInstance AS INTEGER.
    IF AVAILABLE Treemenu
    THEN DO:
        IF Treemenu.archivo_help <> ""
            THEN RUN ShellExecute{&A} IN hpApi  (0,
                                                "open",
                                                Treemenu.archivo_help,
                                                "",
                                                "",
                                                1,
                                                OUTPUT hInstance).
            ELSE MESSAGE "No se halla definido el archivo de ayuda"
                    VIEW-AS ALERT-BOX WARNING.
    END.
    ELSE MESSAGE "Seleccione un nodo del menú"
            VIEW-AS ALERT-BOX WARNING.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE poner_sesion wWin 
PROCEDURE poner_sesion :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

  DEFINE INPUT PARAMETER p-estado AS LOGICAL.
  DEFINE INPUT PARAMETER p-titulo AS CHARACTER.

/*==========================================================================*/
/*                              VARIABLES                                   */
/*==========================================================================*/  

  DEFINE VARIABLE lOk AS LOGICAL.
  DEFINE VARIABLE cImagen AS CHARACTER.

/*==========================================================================*/
/*                          BLOQUE PRINCIPAL                                */
/*==========================================================================*/

  {&WINDOW-NAME}:TITLE = p-titulo.

  /*
  RUN getparametro_c.p (  INPUT  "IMAGENBG", OUTPUT cImagen).
  IF cImagen <> ? 
     THEN lOk = IMAGE-1:LOAD-IMAGE(cImagen) IN FRAME {&FRAME-NAME}.

  RUN habilitar_frame ( INPUT p-estado ).
  */

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE traceIt wWin 
PROCEDURE traceIt :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
    DEFINE INPUT  PARAMETER pc  AS CHARACTER  NO-UNDO.
    
    /*addToEdMsg(pc + "~n").*/
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE tvDoubleClick wWin 
PROCEDURE tvDoubleClick :
/*------------------------------------------------------------------------------
  Purpose: example to use tvNodeEvent procedure with pure4GlTv
  Parameters: 
  Notes: I use this procedure for mulitple demo treeview
     Note that I rely on pcnodeKey to distinguish the different
     sample treeview
------------------------------------------------------------------------------*/

  DEFINE INPUT  PARAMETER pcnodeKey AS CHARACTER  NO-UNDO.

  FIND Treemenu 
      /*WHERE Treemenu.cdg_item = ENTRY(2,pcNodeKey,"=") AND Treemenu.cdg_empresa = "F" NO-LOCK.*/
      WHERE Treemenu.cdg_item = pcNodeKey
        AND Treemenu.cdg_empresa = v-cdg_empresa
            NO-LOCK.
  IF Treemenu.accion <> "" 
  THEN DO:
      RUN ejecutar ( INPUT Treemenu.accion, INPUT Treemenu.modo, INPUT Treemenu.cdg_comprobante ).
  END.
  ELSE DO:
      RUN mensajepar.p ( INPUT Treemenu.titulo + CHR(1) + Treemenu.cdg_item, INPUT "TREE005" ).
  END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE tvNodeAddOnExpand wWin 
PROCEDURE tvNodeAddOnExpand :
/*------------------------------------------------------------------------------
  Purpose: example to use tvNodeEvent procedure with pure4GlTv
  Parameters: 
  Notes: I use this procedure for mulitple demo treeview
     Note that I rely on pcnodeKey to distinguish the different
     sample treeview
------------------------------------------------------------------------------*/

    DEFINE INPUT  PARAMETER pcnodeKey AS CHARACTER  NO-UNDO.
    
    
    FIND Treemenu WHERE Treemenu.cdg_item = pcNodeKey AND Treemenu.cdg_empresa = Usuario.cdg_empresa NO-LOCK.
    IF CAN-FIND(FIRST Submenu NO-LOCK 
                WHERE Submenu.cdg_padre = Treemenu.cdg_item 
                  AND Submenu.cdg_empresa = Treemenu.cdg_empresa
                  AND CAN-FIND (FIRST Usuario_funcion OF Usuario 
                          WHERE Usuario_funcion.cdg_empresa = Treemenu.cdg_empresa
                            AND CAN-DO(Submenu.permitidos,Usuario_funcion.cdg_funcion)))
    THEN DO:
        FOR EACH Submenu NO-LOCK 
            WHERE Submenu.cdg_padre = Treemenu.cdg_item 
              AND Submenu.cdg_empresa = Treemenu.cdg_empresa
              AND CAN-FIND (FIRST Usuario_funcion OF Usuario 
                      WHERE Usuario_funcion.cdg_empresa = Treemenu.cdg_empresa
                        AND CAN-DO(Submenu.permitidos,Usuario_funcion.cdg_funcion))
                           BY Submenu.cdg_item:
    
            RUN addNode IN h_pure4gltv (Submenu.cdg_item
                                       ,pcNodeKey
                                       ,Submenu.titulo
                                       ,IF Submenu.archivo_icono = "" 
                                           THEN IF CAN-FIND(FIRST B-Submenu 
                                                                  WHERE B-Submenu.cdg_padre = Submenu.cdg_item 
                                                                    AND B-Submenu.cdg_empresa = Submenu.cdg_empresa) 
                                                            THEN v-icono_submenu ELSE v-icono_programa
                                           ELSE Submenu.archivo_icono
                                       ,IF CAN-FIND(FIRST B-Submenu WHERE B-Submenu.cdg_padre = Submenu.cdg_item ) 
                                           THEN "addOnExpand" 
                                           ELSE "").
                                       
            
        END.
    END.


END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE tvNodeCreatePopup wWin 
PROCEDURE tvNodeCreatePopup :
/*------------------------------------------------------------------------------
  Purpose: example to use tvNodePopup procedure with pure4GlTv
  Parameters: 
  Notes: I use this procedure for mulitple demo treeview
     Note that I rely on pcnodeKey to distinguish the different
     sample treeview
------------------------------------------------------------------------------*/
DEFINE INPUT  PARAMETER pcnodeKey AS CHARACTER  NO-UNDO.

DEFINE VARIABLE nCust     AS INTEGER    NO-UNDO.
DEFINE VARIABLE norder    AS INTEGER    NO-UNDO.

DEFINE VARIABLE cSalesrep  AS CHARACTER  NO-UNDO.
DEFINE VARIABLE icustnum   AS INTEGER    NO-UNDO.
DEFINE VARIABLE ccustname  AS CHARACTER  NO-UNDO.
DEFINE VARIABLE iorder     AS INTEGER    NO-UNDO.
DEFINE VARIABLE cparentKey AS CHARACTER  NO-UNDO.

/*========= For text treview sample, nodeKey beings 'n' ================*/
IF pcNodeKey BEGINS "n"
 AND NUM-ENTRIES(pcNodeKey, "=") = 1
 THEN RETURN "Add a child node,TreemenuAddChildNode,RULE,,Hello World,TreemenuHelloWorld".


/*======== For data treeview example on salesrep customer order orderline: ========*/
/* popup menu addSalesRep and addCustomer */
IF pcNodeKey BEGINS "sr="
 THEN RETURN "Add Salesrep,TreemenuAddSR,Add Customer,TreemenuAddCustomer".

/*-------------- Popup menu addOrder  --------------*/
IF pcNodeKey BEGINS "cust="
 THEN RETURN "Add order,TreemenuAddOrder".

/*-------------- Popup menu addOrderline --------------*/
IF pcNodeKey BEGINS "order="
 THEN RETURN "Add order line,TreemenuAddOrderLine".

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE tvNodeDropEnd wWin 
PROCEDURE tvNodeDropEnd :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

DEFINE INPUT  PARAMETER pcEvent   AS CHARACTER  NO-UNDO.
DEFINE INPUT  PARAMETER pcnodeKey AS CHARACTER  NO-UNDO.

DEFINE VARIABLE mouseX   AS INTEGER    NO-UNDO.
DEFINE VARIABLE mouseY   AS INTEGER    NO-UNDO.
DEFINE VARIABLE cWidgets AS CHARACTER  NO-UNDO.
DEFINE VARIABLE hWidget  AS HANDLE     NO-UNDO.
DEFINE VARIABLE icount   AS INTEGER    NO-UNDO.

mouseX = INT(ENTRY(2,pcEvent)) NO-ERROR.
mouseY = INT(ENTRY(3,pcEvent)) NO-ERROR.

/* Example with the large tree (1000 node) and drag-drop used to move
 a node somewhere else (drop in the treeview itself */
IF pcnodeKey BEGINS "k" OR TRUE
THEN DO:
    DEFINE VARIABLE targetKe AS CHARACTER  NO-UNDO.
    targetKe = DYNAMIC-FUNCTION('getNodeLocatedAtXY' IN h_pure4GlTv, mouseX, mouseY).

    v-codigo_destino = targetKe.
    DISPLAY v-codigo_destino
          WITH FRAME {&FRAME-NAME}.

    IF lTraceEvents THEN DO:
        addToEdMsg("Drop end fired in MouseX: " + STRING(mouseX)
         + "  mouseY: " + STRING(mouseY) + "   nodeKey: " + pcnodeKey
         + "~n         => This falls in the following widgets:" + cWidgets
         + "~n         => Detected Target Nodekey: " + targetKe + "~n").
    END.
    
    IF targetKe <> "" AND targetKe <> pcnodeKey THEN
     RUN moveNode IN h_pure4gltv (pcnodeKey, targetKe, "after", "refresh") NO-ERROR.
    IF NOT ERROR-STATUS:ERROR THEN DYNAMIC-FUNCTION('selectNode' IN h_pure4gltv , pcnodeKey).
    ELSE MESSAGE "This node cannot be moved here!"
         VIEW-AS ALERT-BOX INFO BUTTONS OK.
END.

/* other cases, the drop is done in this container */
ELSE DO:
    /* work out the name of drop target widgets from the handles passed in pcEvent*/
    DO iCount = 4 TO NUM-ENTRIES(pcEvent):
        hWidget = WIDGET-HANDLE(ENTRY(iCount,pcEvent)) NO-ERROR.
        cWidgets = cWidgets + " "
         + IF hWidget:NAME = ?
            THEN (IF CAN-QUERY(hWidget,"SCREEN-VALUE")
                   THEN "SCREEN-VALUE=" + hWidget:SCREEN-VALUE
                   ELSE "?")
            ELSE hWidget:NAME.
    END.
    
    /* if trace enable, then display info in the monitoring editor */
    
    IF lTraceEvents THEN DO:
        addToEdMsg("Drop end fired in at mouseX: " + STRING(mouseX)
         + "  mouseY: " + STRING(mouseY) + "   nodeKey: " + pcnodeKey + "~n").
        
        IF cWidgets = "" THEN addToEdMsg("         This (X,Y) does not falls in any widget~n").
        ELSE addToEdMsg("         This (X,Y) falls in the following widgets:" + cWidgets + "~n").
    END.
    
    /* at last insert the label of the dragged node into the drop target widget */
    hWidget = ?.
    DO iCount = 4 TO NUM-ENTRIES(pcEvent):
        hWidget = WIDGET-HANDLE(ENTRY(iCount,pcEvent)) NO-ERROR.
        IF NOT CAN-QUERY(hWidget, "SCREEN-VALUE") THEN NEXT.
        IF NOT hWidget:SENSITIVE THEN NEXT. /* otherwise, we give the ability to change a label :o */
    
        DEFINE VARIABLE hNodeBuffer AS HANDLE     NO-UNDO.
        RUN getNodeDetails IN h_pure4gltv
        ( INPUT  pcnodeKey /* CHARACTER */,
          OUTPUT hNodeBuffer /* HANDLE */).
        
        IF NOT VALID-HANDLE (hNodeBuffer) THEN LEAVE.
        
        CASE hWidget:TYPE:
          WHEN "EDITOR" THEN DO:
            hWidget:CURSOR-OFFSET = hWidget:LENGTH + 1.
            hWidget:INSERT-STRING(hNodeBuffer:BUFFER-FIELD("lab"):BUFFER-VALUE + "~n").
          END.
          WHEN "FILL-IN" THEN hWidget:SCREEN-VALUE = hWidget:SCREEN-VALUE + 
            hNodeBuffer:BUFFER-FIELD("lab"):BUFFER-VALUE NO-ERROR.
          OTHERWISE hWidget:SCREEN-VALUE = hNodeBuffer:BUFFER-FIELD("lab"):BUFFER-VALUE NO-ERROR.
        END CASE. /* CASE hWidget:TYPE: */
        APPLY 'VALUE-CHANGED'TO hWidget. /*very important if we want the change of the SCREEN-VALUE
                                          to result in the same as typing */

        DELETE OBJECT hNodeBuffer.
        
        LEAVE. /* one widget is enough ;) */
    END. /* DO iCount = 4 TO NUM-ENTRIES(cWidgets): */
END. /* other cases, the drop is done in this container */

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE tvnodeEvent wWin 
PROCEDURE tvnodeEvent :
/*------------------------------------------------------------------------------
  Purpose: example to use tvNodeEvent procedure with pure4GlTv
  Parameters: 
  Notes: I use this procedure for mulitple demo treeview
     Note that I rely on pcnodeKey to distinguish the different
     sample treeview
------------------------------------------------------------------------------*/
DEFINE INPUT  PARAMETER pcEvent   AS CHARACTER  NO-UNDO.
DEFINE INPUT  PARAMETER pcnodeKey AS CHARACTER  NO-UNDO.

DEFINE VARIABLE nCust     AS INTEGER    NO-UNDO.
DEFINE VARIABLE norder    AS INTEGER    NO-UNDO.

DEFINE VARIABLE cSalesrep AS CHARACTER  NO-UNDO.
DEFINE VARIABLE icustnum  AS INTEGER    NO-UNDO.
DEFINE VARIABLE iorder AS INTEGER    NO-UNDO.
      
IF lTraceEvents THEN addToEdMsg(STRING(pcEvent,FILL("X",25)) + pcnodeKey + "~n").
 
CASE pcEvent:
  WHEN "addOnExpand" THEN RUN tvNodeaddOnExpand (pcnodeKey).
  WHEN "select"      THEN RUN tvNodeSelect (pcnodeKey).
  
  WHEN "rightClick"  THEN DO:
          MESSAGE "me apretaste el boton derecho del mouse"
              VIEW-AS ALERT-BOX INFO BUTTONS OK TITLE "tvnodeevent".
      RUN tvNodeCreatePopup (pcnodeKey) NO-ERROR.
      IF NOT ERROR-STATUS:ERROR THEN RETURN RETURN-VALUE.
      ELSE MESSAGE "tvNodeCreatePopup failed with the following message:" RETURN-VALUE
        VIEW-AS ALERT-BOX INFO BUTTONS OK.
  END.
  
  /* place to handle the Treemenu event */
  WHEN "TreemenuAddChildNode"
   OR WHEN "TreemenuAddSR"
   OR WHEN "TreemenuAddCustomer"
   OR WHEN "TreemenuAddOrder"
   OR WHEN "TreemenuAddOrderLine"
   THEN /*addToEdMsg("Treemenu item event fired: " + pcEvent + " for key " + pcnodeKey + "~n")*/.
   
   WHEN "TreemenuHelloWorld" THEN MESSAGE "Hello World!" SKIP
      "Node key parent of the popup menu item:" + pcNodeKey
        VIEW-AS ALERT-BOX INFO BUTTONS OK.
   
   WHEN "DragBegin" THEN DO:

          v-codigo_mover = pcnodeKey.
          DISPLAY v-codigo_mover
              WITH FRAME {&FRAME-NAME}.

       /* sample with Large tree (1000 nodes), the node keys are of type "k<n>" 
         by returning "yourself" the treview will be the drop target to move a node
         to another location in the tree */
       IF pcnodeKey BEGINS "k" THEN RETURN "dropOnYourself".
       
       /* see node n4 in small TV */
       IF pcnodeKey = "n4" THEN RETURN "cancelDrag".
       
       /* drop target frame is in another window */
       IF pcnodeKey = "n1" THEN DO:
           /* to test that, use PRO*Tools/run to run C:\BabouSoft\tv4gl\OtherDropTargetWin.w
             with the persistent option before running this test container */
           DEFINE VARIABLE hTargetFrame AS HANDLE     NO-UNDO.
           PUBLISH "getOtherWinTargetFrame" (OUTPUT hTargetFrame).
           IF VALID-HANDLE(hTargetFrame) THEN RETURN STRING(hTargetFrame).
       END.

       /* for the other samle, the target is this container */
       RETURN /*STRING(FRAME fMain:HANDLE) */.
   END.

   WHEN "DoubleClick"      THEN RUN tvDoubleClick (pcnodeKey).

   OTHERWISE IF pcEvent BEGINS "DropEnd," THEN RUN tvNodeDropEnd (pcEvent, pcNodeKey).
   
END CASE.
 
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE tvNodeSelect wWin 
PROCEDURE tvNodeSelect :
/*------------------------------------------------------------------------------
  Purpose: example to use tvNodeEvent procedure with pure4GlTv
  Parameters: 
  Notes: I use this procedure for mulitple demo treeview
     Note that I rely on pcnodeKey to distinguish the different
     sample treeview
------------------------------------------------------------------------------*/

    DEFINE INPUT  PARAMETER pcnodeKey AS CHARACTER  NO-UNDO.
    
    DEFINE VARIABLE cparentKey AS CHARACTER  NO-UNDO.
    DEFINE VARIABLE optn       AS CHARACTER  NO-UNDO.

    FIND Treemenu 
        WHERE Treemenu.cdg_item = pcNodeKey 
          AND Treemenu.cdg_empresa = v-cdg_empresa 
              NO-LOCK.

    RUN adm-display-fields.

    RUN habilitar_abm ( YES ).
   
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

/* ************************  Function Implementations ***************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION AddtoEdMsg wWin 
FUNCTION AddtoEdMsg RETURNS LOGICAL
  (pcTxt AS CHAR) :
/*------------------------------------------------------------------------------
  Purpose:  
    Notes:  
------------------------------------------------------------------------------*/
/*

  IF edMsg:LENGTH IN FRAME fMain > 31000 THEN edMsg:SCREEN-VALUE =
    SUBSTR(edMsg:SCREEN-VALUE,1000).
       
  edmsg:CURSOR-OFFSET = edmsg:LENGTH + 1.
  edMsg:INSERT-STRING(pcTxt).
*/  
  RETURN YES.   /* Function return value. */

END FUNCTION.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION fnPadre wWin 
FUNCTION fnPadre RETURNS CHARACTER
  ( p-cdg_item AS CHARACTER ) :
/*------------------------------------------------------------------------------
  Purpose:  
    Notes:  
------------------------------------------------------------------------------*/

  DEFINE VARIABLE v-cdg_padre AS CHARACTER.
  DEFINE VARIABLE j           AS INTEGER.
  
  v-cdg_padre = "".
  DO j = 1 TO NUM-ENTRIES(p-cdg_item,".") - 1:
      v-cdg_padre = v-cdg_padre + "." + ENTRY(j,p-cdg_item,".").
  END.
  v-cdg_padre = SUBSTRING(v-cdg_padre,2).

  RETURN v-cdg_padre.

END FUNCTION.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

