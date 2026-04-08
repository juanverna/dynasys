&ANALYZE-SUSPEND _VERSION-NUMBER AB_v10r12 GUI ADM2
&ANALYZE-RESUME
&Scoped-define WINDOW-NAME wWin
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

DEFINE BUFFER Submenu FOR Treemenu.
DEFINE BUFFER B-Submenu FOR Treemenu.
DEFINE BUFFER B-Empresa FOR Empresa.

{vrshared.i "NEW"}
{nrorelea.i}

DEFINE NEW SHARED VARIABLE MAIN-WINDOW  AS WIDGET-HANDLE NO-UNDO.
DEFINE NEW SHARED VARIABLE titulo       AS CHARACTER.
DEFINE NEW SHARED VARIABLE titulo_ini   AS CHARACTER INITIAL "Ingreso al sistema".
DEFINE NEW SHARED VARIABLE NOM_SISTEMA  AS CHARACTER INITIAL "Solución Integrada Computel".
DEFINE VARIABLE hoy                     AS DATE INITIAL TODAY.
DEFINE VARIABLE proceso                 AS CHARACTER.

DEFINE VARIABLE carga_logo              AS LOGICAL INITIAL NO.
DEFINE VARIABLE hubo_logon              AS LOGICAL INITIAL YES.
DEFINE VARIABLE hubo_conexion           AS LOGICAL INITIAL NO.
DEFINE VARIABLE puede_salir             AS LOGICAL INITIAL YES NO-UNDO.
DEFINE VARIABLE v-lista_modulos         AS CHARACTER.
DEFINE VARIABLE v-cdg_modulo            LIKE Modulo-sic.cdg_sigla-sic.

{valoressalida.i}

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

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS RECT-1 v-cdg_empresa btn_ABA btn_DSP btn_INV ~
btn_DAC btn_PRD btn_AFI btn_BDU btn_FAC btn_COM btn_CXC btn_CXP btn_GLA ~
btn_RGV btn_CPS btn_EXP btn_TES btn_IMP btn_ADP btn_UTL btn_CPY v-accion 
&Scoped-Define DISPLAYED-OBJECTS v-nom_modulo v-cdg_empresa v-accion 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME


/* ************************  Function Prototypes ********************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION-FORWARD AddtoEdMsg wWin 
FUNCTION AddtoEdMsg RETURNS LOGICAL
  (pcTxt AS CHAR)  FORWARD.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


/* ***********************  Control Definitions  ********************** */

/* Define the widget handle for the window                              */
DEFINE VAR wWin AS WIDGET-HANDLE NO-UNDO.

/* Menu Definitions                                                     */
DEFINE SUB-MENU m_Archivo 
       MENU-ITEM m_Ver_Conexin  LABEL "&Ver Conexión" 
       RULE
       MENU-ITEM m_Conectar_Ambiente LABEL "&Conectar Ambiente"
              DISABLED
       MENU-ITEM m_Desconectar_Ambiente LABEL "&Desconectar Ambiente"
              DISABLED
       RULE
       MENU-ITEM m_Datos_de_la_Empresa_Actual LABEL "Da&tos de la Empresa Actual"
       RULE
       MENU-ITEM m_Salir        LABEL "&Salir"        .

DEFINE SUB-MENU m_Seguridad 
       MENU-ITEM m_Cambio_de_Clave LABEL "Cambio de &Clave"
       MENU-ITEM m_Cambio_de_Login LABEL "Cambio de &Login".

DEFINE SUB-MENU m_Ayuda 
       MENU-ITEM m_Transaccin_Actual LABEL "&Transacción Actual"
       RULE
       MENU-ITEM m_Acerca_de_Dynasys LABEL "Acerca de D&ynasys".

DEFINE MENU MENU-BAR-wWin MENUBAR
       SUB-MENU  m_Archivo      LABEL "&Archivo"      
       SUB-MENU  m_Seguridad    LABEL "&Seguridad"    
       SUB-MENU  m_Ayuda        LABEL "A&yuda"        .


/* Definitions of handles for SmartObjects                              */
DEFINE VARIABLE h_pure4gltv AS HANDLE NO-UNDO.

/* Definitions of the field level widgets                               */
DEFINE BUTTON btn_ABA 
     LABEL "&ABA" 
     SIZE 9 BY 1.67
     FONT 6.

DEFINE BUTTON btn_ADP 
     LABEL "ADP" 
     SIZE 9 BY 1.67
     FONT 6.

DEFINE BUTTON btn_AFI 
     LABEL "AFI" 
     SIZE 9 BY 1.67
     FONT 6.

DEFINE BUTTON btn_BDU 
     LABEL "BDU" 
     SIZE 9 BY 1.67
     FONT 6.

DEFINE BUTTON btn_COM 
     LABEL "COM" 
     SIZE 9 BY 1.67
     FONT 6.

DEFINE BUTTON btn_CPS 
     LABEL "CPS" 
     SIZE 9 BY 1.67
     FONT 6.

DEFINE BUTTON btn_CPY 
     LABEL "CPY" 
     SIZE 9 BY 1.67
     FONT 6.

DEFINE BUTTON btn_CXC 
     LABEL "CXC" 
     SIZE 9 BY 1.67
     FONT 6.

DEFINE BUTTON btn_CXP 
     LABEL "CXP" 
     SIZE 9 BY 1.67
     FONT 6.

DEFINE BUTTON btn_DAC 
     LABEL "DAC" 
     SIZE 9 BY 1.67
     FONT 6.

DEFINE BUTTON btn_DSP 
     LABEL "DSP" 
     SIZE 9 BY 1.67
     FONT 6.

DEFINE BUTTON btn_EXP 
     LABEL "EXP" 
     SIZE 9 BY 1.67
     FONT 6.

DEFINE BUTTON btn_FAC 
     LABEL "FAC" 
     SIZE 9 BY 1.67
     FONT 6.

DEFINE BUTTON btn_GLA 
     LABEL "GLA" 
     SIZE 9 BY 1.67
     FONT 6.

DEFINE BUTTON btn_IMP 
     LABEL "IMP" 
     SIZE 9 BY 1.67
     FONT 6.

DEFINE BUTTON btn_INV 
     LABEL "INV" 
     SIZE 9 BY 1.67
     FONT 6.

DEFINE BUTTON btn_PRD 
     LABEL "PRD" 
     SIZE 9 BY 1.67
     FONT 6.

DEFINE BUTTON btn_RGV 
     LABEL "RGV" 
     SIZE 9 BY 1.67
     FONT 6.

DEFINE BUTTON btn_TES 
     LABEL "TES" 
     SIZE 9 BY 1.67
     FONT 6.

DEFINE BUTTON btn_UTL 
     LABEL "UTL" 
     SIZE 9 BY 1.67
     FONT 6.

DEFINE VARIABLE v-cdg_empresa AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS COMBO-BOX INNER-LINES 5
     LIST-ITEM-PAIRS "Item 1","Item 1"
     DROP-DOWN-LIST
     SIZE 43 BY 1
     BGCOLOR 15 FGCOLOR 9 FONT 4 NO-UNDO.

DEFINE VARIABLE v-accion AS CHARACTER 
     VIEW-AS EDITOR SCROLLBAR-VERTICAL
     SIZE 134 BY 1.91
     BGCOLOR 15 FGCOLOR 9  NO-UNDO.

DEFINE VARIABLE v-nom_modulo AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 90 BY 1
     BGCOLOR 9 FGCOLOR 15 FONT 6 NO-UNDO.

DEFINE RECTANGLE RECT-1
     EDGE-PIXELS 2 GRAPHIC-EDGE    ROUNDED 
     SIZE 22 BY 24.76
     BGCOLOR 7 .


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME fContainer
     v-nom_modulo AT ROW 1.24 COL 23 COLON-ALIGNED NO-LABEL WIDGET-ID 58
     v-cdg_empresa AT ROW 1.24 COL 114 COLON-ALIGNED NO-LABEL WIDGET-ID 12
     btn_ABA AT ROW 2.43 COL 3 WIDGET-ID 16
     btn_DSP AT ROW 2.43 COL 14 WIDGET-ID 36
     btn_INV AT ROW 4.57 COL 3 WIDGET-ID 46
     btn_DAC AT ROW 4.57 COL 14 WIDGET-ID 34
     btn_PRD AT ROW 6.71 COL 3 WIDGET-ID 48
     btn_AFI AT ROW 6.71 COL 14 WIDGET-ID 20
     btn_BDU AT ROW 8.86 COL 3 WIDGET-ID 22
     btn_FAC AT ROW 8.86 COL 14 WIDGET-ID 40
     btn_COM AT ROW 11 COL 3 WIDGET-ID 24
     btn_CXC AT ROW 11 COL 14 WIDGET-ID 30
     btn_CXP AT ROW 13.14 COL 3 WIDGET-ID 32
     btn_GLA AT ROW 13.14 COL 14 WIDGET-ID 42
     btn_RGV AT ROW 15.29 COL 3 WIDGET-ID 50
     btn_CPS AT ROW 15.29 COL 14 WIDGET-ID 26
     btn_EXP AT ROW 17.43 COL 3 WIDGET-ID 38
     btn_TES AT ROW 17.43 COL 14 WIDGET-ID 52
     btn_IMP AT ROW 19.57 COL 3 WIDGET-ID 44
     btn_ADP AT ROW 19.57 COL 14 WIDGET-ID 18
     btn_UTL AT ROW 21.71 COL 3 WIDGET-ID 54
     btn_CPY AT ROW 21.71 COL 14 WIDGET-ID 28
     v-accion AT ROW 24.1 COL 25 NO-LABEL WIDGET-ID 6
     RECT-1 AT ROW 1.24 COL 2 WIDGET-ID 60
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
 */
&ANALYZE-RESUME _END-PROCEDURE-SETTINGS

/* *************************  Create Window  ************************** */

&ANALYZE-SUSPEND _CREATE-WINDOW
IF SESSION:DISPLAY-TYPE = "GUI":U THEN
  CREATE WINDOW wWin ASSIGN
         HIDDEN             = YES
         TITLE              = "Dynasys Rel. 4"
         HEIGHT             = 25.33
         WIDTH              = 160
         MAX-HEIGHT         = 29.67
         MAX-WIDTH          = 256
         VIRTUAL-HEIGHT     = 29.67
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

ASSIGN {&WINDOW-NAME}:MENUBAR    = MENU MENU-BAR-wWin:HANDLE.
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
ASSIGN 
       btn_ABA:PRIVATE-DATA IN FRAME fContainer     = 
                "ABA".

ASSIGN 
       btn_ADP:PRIVATE-DATA IN FRAME fContainer     = 
                "ADP".

ASSIGN 
       btn_AFI:PRIVATE-DATA IN FRAME fContainer     = 
                "AFI".

ASSIGN 
       btn_BDU:PRIVATE-DATA IN FRAME fContainer     = 
                "BDU".

ASSIGN 
       btn_COM:PRIVATE-DATA IN FRAME fContainer     = 
                "COM".

ASSIGN 
       btn_CPS:PRIVATE-DATA IN FRAME fContainer     = 
                "CPS".

ASSIGN 
       btn_CPY:PRIVATE-DATA IN FRAME fContainer     = 
                "CPY".

ASSIGN 
       btn_CXC:PRIVATE-DATA IN FRAME fContainer     = 
                "CXC".

ASSIGN 
       btn_CXP:PRIVATE-DATA IN FRAME fContainer     = 
                "CXP".

ASSIGN 
       btn_DAC:PRIVATE-DATA IN FRAME fContainer     = 
                "DAC".

ASSIGN 
       btn_DSP:PRIVATE-DATA IN FRAME fContainer     = 
                "DSP".

ASSIGN 
       btn_EXP:PRIVATE-DATA IN FRAME fContainer     = 
                "EXP".

ASSIGN 
       btn_FAC:PRIVATE-DATA IN FRAME fContainer     = 
                "FAC".

ASSIGN 
       btn_GLA:PRIVATE-DATA IN FRAME fContainer     = 
                "GLA".

ASSIGN 
       btn_IMP:PRIVATE-DATA IN FRAME fContainer     = 
                "IMP".

ASSIGN 
       btn_INV:PRIVATE-DATA IN FRAME fContainer     = 
                "INV".

ASSIGN 
       btn_PRD:PRIVATE-DATA IN FRAME fContainer     = 
                "PRD".

ASSIGN 
       btn_RGV:PRIVATE-DATA IN FRAME fContainer     = 
                "RGV".

ASSIGN 
       btn_TES:PRIVATE-DATA IN FRAME fContainer     = 
                "TES".

ASSIGN 
       btn_UTL:PRIVATE-DATA IN FRAME fContainer     = 
                "UTL".

ASSIGN 
       v-accion:READ-ONLY IN FRAME fContainer        = TRUE.

/* SETTINGS FOR FILL-IN v-nom_modulo IN FRAME fContainer
   NO-ENABLE                                                            */
IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(wWin)
THEN wWin:HIDDEN = yes.

/* _RUN-TIME-ATTRIBUTES-END */
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

  IF puede_salir
  THEN DO:
        RUN borrar_empresa.
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


&Scoped-define SELF-NAME btn_ABA
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btn_ABA wWin
ON CHOOSE OF btn_ABA IN FRAME fContainer /* ABA */
DO:
  RUN cambiar_menu.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btn_ADP
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btn_ADP wWin
ON CHOOSE OF btn_ADP IN FRAME fContainer /* ADP */
DO:
  RUN cambiar_menu.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btn_AFI
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btn_AFI wWin
ON CHOOSE OF btn_AFI IN FRAME fContainer /* AFI */
DO:
  RUN cambiar_menu.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btn_BDU
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btn_BDU wWin
ON CHOOSE OF btn_BDU IN FRAME fContainer /* BDU */
DO:
  RUN cambiar_menu.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btn_COM
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btn_COM wWin
ON CHOOSE OF btn_COM IN FRAME fContainer /* COM */
DO:
  RUN cambiar_menu.  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btn_CPS
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btn_CPS wWin
ON CHOOSE OF btn_CPS IN FRAME fContainer /* CPS */
DO:
  RUN cambiar_menu.  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btn_CPY
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btn_CPY wWin
ON CHOOSE OF btn_CPY IN FRAME fContainer /* CPY */
DO:
  RUN cambiar_menu.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btn_CXC
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btn_CXC wWin
ON CHOOSE OF btn_CXC IN FRAME fContainer /* CXC */
DO:
  RUN cambiar_menu.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btn_CXP
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btn_CXP wWin
ON CHOOSE OF btn_CXP IN FRAME fContainer /* CXP */
DO:
  RUN cambiar_menu.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btn_DAC
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btn_DAC wWin
ON CHOOSE OF btn_DAC IN FRAME fContainer /* DAC */
DO:
  RUN cambiar_menu.  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btn_DSP
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btn_DSP wWin
ON CHOOSE OF btn_DSP IN FRAME fContainer /* DSP */
DO:
  RUN cambiar_menu.  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btn_EXP
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btn_EXP wWin
ON CHOOSE OF btn_EXP IN FRAME fContainer /* EXP */
DO:
  RUN cambiar_menu.  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btn_FAC
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btn_FAC wWin
ON CHOOSE OF btn_FAC IN FRAME fContainer /* FAC */
DO:
  RUN cambiar_menu.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btn_GLA
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btn_GLA wWin
ON CHOOSE OF btn_GLA IN FRAME fContainer /* GLA */
DO:
  RUN cambiar_menu.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btn_IMP
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btn_IMP wWin
ON CHOOSE OF btn_IMP IN FRAME fContainer /* IMP */
DO:
  RUN cambiar_menu.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btn_INV
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btn_INV wWin
ON CHOOSE OF btn_INV IN FRAME fContainer /* INV */
DO:
  RUN cambiar_menu.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btn_PRD
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btn_PRD wWin
ON CHOOSE OF btn_PRD IN FRAME fContainer /* PRD */
DO:
  RUN cambiar_menu.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btn_RGV
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btn_RGV wWin
ON CHOOSE OF btn_RGV IN FRAME fContainer /* RGV */
DO:
  RUN cambiar_menu.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btn_TES
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btn_TES wWin
ON CHOOSE OF btn_TES IN FRAME fContainer /* TES */
DO:
  RUN cambiar_menu.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btn_UTL
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btn_UTL wWin
ON CHOOSE OF btn_UTL IN FRAME fContainer /* UTL */
DO:
  RUN cambiar_menu.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME m_Acerca_de_Dynasys
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL m_Acerca_de_Dynasys wWin
ON CHOOSE OF MENU-ITEM m_Acerca_de_Dynasys /* Acerca de Dynasys */
DO:
  RUN d-acerca_dynasys.w.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME m_Cambio_de_Clave
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL m_Cambio_de_Clave wWin
ON CHOOSE OF MENU-ITEM m_Cambio_de_Clave /* Cambio de Clave */
DO:
    DEFINE VARIABLE v-ok AS LOGICAL.
    RUN d-asignar_clave.w (OUTPUT v-ok).  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME m_Cambio_de_Login
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL m_Cambio_de_Login wWin
ON CHOOSE OF MENU-ITEM m_Cambio_de_Login /* Cambio de Login */
DO:
  RUN conectar_ambiente ( OUTPUT hubo_logon ).
  IF NOT hubo_logon THEN QUIT.
    RUN emptyTree IN h_pure4gltv.  
    RUN levantar_ambiente.
END.
/*  RUN armar_titulo ( OUTPUT titulo ).
  RUN poner_sesion ( hubo_logon, INPUT titulo ).
END.
                                                */

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME m_Datos_de_la_Empresa_Actual
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL m_Datos_de_la_Empresa_Actual wWin
ON CHOOSE OF MENU-ITEM m_Datos_de_la_Empresa_Actual /* Datos de la Empresa Actual */
DO:
  RUN d-ver-datos-empresa.w.
  RUN verpermiso.p ( OUTPUT cod_aut ).
  RUN poner_sesion ( INPUT cod_aut = 0, INPUT {&WINDOW-NAME}:TITLE).
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME m_Salir
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL m_Salir wWin
ON CHOOSE OF MENU-ITEM m_Salir /* Salir */
DO:
  IF puede_salir
  THEN DO:
        RUN borrar_empresa.
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


&Scoped-define SELF-NAME m_Transaccin_Actual
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL m_Transaccin_Actual wWin
ON CHOOSE OF MENU-ITEM m_Transaccin_Actual /* Transacción Actual */
DO:
  RUN mostrar_ayuda.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME m_Ver_Conexin
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL m_Ver_Conexin wWin
ON CHOOSE OF MENU-ITEM m_Ver_Conexin /* Ver Conexión */
DO:
  RUN d-verconect.w.
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
             INPUT  'wineModeAutomaticwindowsSkinAutomaticpicCacheCoef1labCacheCoef1tvIterationHeight17TreeStyle3FocSelNodeBgColor1UnfSelNodeBgColor16tvnodeDefaultFont1FocSelNodeFgColor15UnfSelNodeFgColor0resizeVerticalyesresizeHorizontalyesDragSourceallautoSortnoMSkeyScrollForcePaintyesHideOnInitnoDisableOnInitnoObjectLayout':U ,
             OUTPUT h_pure4gltv ).
       RUN repositionObject IN h_pure4gltv ( 2.43 , 25.00 ) NO-ERROR.
       RUN resizeObject IN h_pure4gltv ( 21.43 , 134.00 ) NO-ERROR.

       /* Links to pure4glTv h_pure4gltv. */
       RUN addLink ( h_pure4gltv , 'tvNodeEvent':U , THIS-PROCEDURE ).

       /* Adjust the tab order of the smart objects. */
       RUN adjustTabOrder ( h_pure4gltv ,
             btn_DSP:HANDLE IN FRAME fContainer , 'AFTER':U ).
    END. /* Page 0 */

  END CASE.

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

  p-titulo = "DYNASYS " + NRO_RELEASE /*VERSION_SIC*/ + " - " + Empresa.cdg_empresa + 
                         " - " + " User:" + USERID("sic") + " - DB:" + PDBNAME("sic").

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE borrar_empresa wWin 
PROCEDURE borrar_empresa :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

    DO TRANSACTION:
       FIND Usuario WHERE Usuario.cdg_usuario = USERID("sic") EXCLUSIVE-LOCK.
       FOR EACH Logusuario OF Usuario WHERE Logusuario.abierta EXCLUSIVE-LOCK:
           ASSIGN Logusuario.abierta          = NO
                  Logusuario.fch_hasta        = TODAY
                  Logusuario.hor_hasta        = TIME
                  Logusuario.hms_hasta        = STRING(Logusuario.hor_hasta,"HH:MM:SS")
                  Usuario.cdg_empresa         = "".
       END.
       RELEASE Usuario.
       RELEASE Logusuario.
    END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE cambiar_menu wWin 
PROCEDURE cambiar_menu :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

    ASSIGN v-cdg_modulo = SELF:PRIVATE-DATA.
    RUN emptyTree IN h_pure4gltv.  
    RUN carga_inicial.  

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

    {findempresa.i}

    DO ON ERROR UNDO, LEAVE:
    
        FOR EACH Treemenu NO-LOCK 
            WHERE Treemenu.cdg_padre = v-cdg_modulo 
              AND Treemenu.cdg_empresa = Empresa.cdg_empresa
              AND Treemenu.cdg_item <> ""
              AND CAN-FIND (FIRST Usuario_funcion OF Usuario 
                                  WHERE Usuario_funcion.cdg_empresa = Treemenu.cdg_empresa
                                    AND CAN-DO(Treemenu.permitidos,Usuario_funcion.cdg_funcion))
                                               BY Treemenu.cdg_item:
    
            RUN addNode IN h_pure4gltv (Treemenu.cdg_item
                                       ,""
                                       ,Treemenu.titulo
                                       ,IF Treemenu.archivo_icono = "" THEN "tvpics/usermale.bmp" ELSE Treemenu.archivo_icono
                                       ,IF CAN-FIND(FIRST Submenu WHERE Submenu.cdg_padre = Treemenu.cdg_item ) THEN "addOnExpand" ELSE "").
                                       
        END. 
    
    END.
    DYNAMIC-FUNCTION('tvRefresh':U IN h_pure4gltv).
    
    IF lTraceEvents THEN addToEdMsg("TV loaded in " + STRING(ETIME - iEtime) + " ms~n").

    FIND Modulo-sic WHERE Modulo-sic.cdg_sigla-sic = v-cdg_modulo NO-LOCK.
    v-nom_modulo = Modulo-sic.descripcion.
    v-accion = "".
    DISPLAY v-nom_modulo
            v-accion 
            WITH FRAME {&FRAME-NAME}.

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
  DISPLAY v-nom_modulo v-cdg_empresa v-accion 
      WITH FRAME fContainer IN WINDOW wWin.
  ENABLE RECT-1 v-cdg_empresa btn_ABA btn_DSP btn_INV btn_DAC btn_PRD btn_AFI 
         btn_BDU btn_FAC btn_COM btn_CXC btn_CXP btn_GLA btn_RGV btn_CPS 
         btn_EXP btn_TES btn_IMP btn_ADP btn_UTL btn_CPY v-accion 
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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE habilitar_frame wWin 
PROCEDURE habilitar_frame :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

  DEFINE INPUT PARAMETER p-habilitado AS LOGICAL.

  DEFINE VARIABLE h_proximo AS HANDLE.
  
  DO WITH FRAME {&FRAME-NAME}:

     /*
      h_proximo = FRAME {&FRAME-NAME}:LAST-CHILD.
      h_proximo = h_proximo:NEXT-SIBLING.
      MESSAGE h_proximo:LABEL VIEW-AS ALERT-BOX MESSAGE TITLE "habilitar_frame".
     */

     btn_ABA:SENSITIVE = p-habilitado AND LOOKUP("ABA",v-lista_modulos,",") <> 0.
     btn_ADP:SENSITIVE = p-habilitado AND LOOKUP("ADP",v-lista_modulos,",") <> 0.
     btn_AFI:SENSITIVE = p-habilitado AND LOOKUP("AFI",v-lista_modulos,",") <> 0.
     btn_BDU:SENSITIVE = p-habilitado AND LOOKUP("BDU",v-lista_modulos,",") <> 0.
     btn_COM:SENSITIVE = p-habilitado AND LOOKUP("COM",v-lista_modulos,",") <> 0.
     btn_CPS:SENSITIVE = p-habilitado AND LOOKUP("CPS",v-lista_modulos,",") <> 0.
     btn_CPY:SENSITIVE = p-habilitado AND LOOKUP("CPY",v-lista_modulos,",") <> 0.
     btn_CXC:SENSITIVE = p-habilitado AND LOOKUP("CXC",v-lista_modulos,",") <> 0.
     btn_CXP:SENSITIVE = p-habilitado AND LOOKUP("CXP",v-lista_modulos,",") <> 0.
     btn_DAC:SENSITIVE = p-habilitado AND LOOKUP("DAC",v-lista_modulos,",") <> 0.     
     btn_DSP:SENSITIVE = p-habilitado AND LOOKUP("DSP",v-lista_modulos,",") <> 0.     
     btn_EXP:SENSITIVE = p-habilitado AND LOOKUP("EXP",v-lista_modulos,",") <> 0.
     btn_FAC:SENSITIVE = p-habilitado AND LOOKUP("FAC",v-lista_modulos,",") <> 0.
     btn_GLA:SENSITIVE = p-habilitado AND LOOKUP("GLA",v-lista_modulos,",") <> 0.
     btn_IMP:SENSITIVE = p-habilitado AND LOOKUP("IMP",v-lista_modulos,",") <> 0.
     btn_INV:SENSITIVE = p-habilitado AND LOOKUP("INV",v-lista_modulos,",") <> 0.
     btn_PRD:SENSITIVE = p-habilitado AND LOOKUP("PRD",v-lista_modulos,",") <> 0.
     btn_RGV:SENSITIVE = p-habilitado AND LOOKUP("RGV",v-lista_modulos,",") <> 0.
     btn_TES:SENSITIVE = p-habilitado AND LOOKUP("TES",v-lista_modulos,",") <> 0.
     btn_UTL:SENSITIVE = p-habilitado AND LOOKUP("UTL",v-lista_modulos,",") <> 0.

     btn_ABA:HIDDEN = NOT btn_ABA:SENSITIVE .
     btn_ADP:HIDDEN = NOT btn_ADP:SENSITIVE .
     btn_AFI:HIDDEN = NOT btn_AFI:SENSITIVE .
     btn_BDU:HIDDEN = NOT btn_BDU:SENSITIVE .
     btn_COM:HIDDEN = NOT btn_COM:SENSITIVE .
     btn_CPS:HIDDEN = NOT btn_CPS:SENSITIVE .
     btn_CPY:HIDDEN = NOT btn_CPY:SENSITIVE .
     btn_CXC:HIDDEN = NOT btn_CXC:SENSITIVE .
     btn_CXP:HIDDEN = NOT btn_CXP:SENSITIVE .
     btn_DAC:HIDDEN = NOT btn_DAC:SENSITIVE .
     btn_DSP:HIDDEN = NOT btn_DSP:SENSITIVE .
     btn_EXP:HIDDEN = NOT btn_EXP:SENSITIVE .
     btn_FAC:HIDDEN = NOT btn_FAC:SENSITIVE .
     btn_GLA:HIDDEN = NOT btn_GLA:SENSITIVE .
     btn_IMP:HIDDEN = NOT btn_IMP:SENSITIVE .
     btn_INV:HIDDEN = NOT btn_INV:SENSITIVE .
     btn_PRD:HIDDEN = NOT btn_PRD:SENSITIVE .
     btn_RGV:HIDDEN = NOT btn_RGV:SENSITIVE .
     btn_TES:HIDDEN = NOT btn_TES:SENSITIVE .
     btn_UTL:HIDDEN = NOT btn_UTL:SENSITIVE .

  END.

/*SUB-MENU  m_Archivo:SENSITIVE = YES.
  SUB-MENU  m_Seguridad:SENSITIVE = CONNECTED("SIC") AND p-habilitado.
  MENU-ITEM m_Cambio_de_Empresa:SENSITIVE IN MENU m_Archivo = CONNECTED("SIC") AND p-habilitado.
  MENU-ITEM m_Conectar_Ambiente:SENSITIVE IN MENU m_Archivo = YES AND p-habilitado.
  MENU-ITEM m_Desconectar_Ambiente:SENSITIVE IN MENU m_Archivo = CONNECTED("SIC") AND p-habilitado. 
  MENU-ITEM m_Salir:SENSITIVE IN MENU m_Archivo = YES AND p-habilitado.*/

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
/*      Usuario.cdg_empresa = "F". */
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

  {setwintit.i "SIC/BAS" "Menu Principal"}

  RUN levantar_empresas.
  RUN levantar_modulos.

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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE levantar_modulos wWin 
PROCEDURE levantar_modulos :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

    DO WITH FRAME {&FRAME-NAME}:

        {findempresa.i}

        v-lista_modulos = "".
        FOR EACH Modulo-sic BY Modulo-SIC.descripcion:

            IF CAN-FIND(FIRST Treemenu NO-LOCK 
                    WHERE Treemenu.cdg_padre = Modulo-sic.cdg_sigla-sic 
                      AND Treemenu.cdg_empresa = Empresa.cdg_empresa
                      AND Treemenu.cdg_item <> ""
                      AND CAN-FIND (FIRST Usuario_funcion OF Usuario 
                                          WHERE Usuario_funcion.cdg_empresa = Treemenu.cdg_empresa
                                            AND CAN-DO(Treemenu.permitidos,Usuario_funcion.cdg_funcion)))
            THEN DO:
                v-lista_modulos = v-lista_modulos + "," + STRING(Modulo-sic.cdg_sigla-sic).
            END.
    
        END.

        v-lista_modulos = SUBSTRING(v-lista_modulos,2).
        v-cdg_modulo = ENTRY(1,v-lista_modulos).
        RUN habilitar_frame ( YES ).

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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE selectNode wWin 
PROCEDURE selectNode :
/*------------------------------------------------------------------------------
  Purpose:  cuando se arrastra el nodo   
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEFINE INPUT  PARAMETER pcnodeKey AS CHARACTER  NO-UNDO.
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

DEFINE VARIABLE nCust     AS INTEGER    NO-UNDO.
DEFINE VARIABLE norder    AS INTEGER    NO-UNDO.

DEFINE VARIABLE cSalesrep  AS CHARACTER  NO-UNDO.
DEFINE VARIABLE icustnum   AS INTEGER    NO-UNDO.
DEFINE VARIABLE ccustname  AS CHARACTER  NO-UNDO.
DEFINE VARIABLE iorder     AS INTEGER    NO-UNDO.
DEFINE VARIABLE cparentKey AS CHARACTER  NO-UNDO.
DEFINE VARIABLE optn       AS CHARACTER  NO-UNDO.

  FIND Treemenu WHERE Treemenu.cdg_item = pcNodeKey
                  AND Treemenu.cdg_empresa = v-cdg_empresa NO-LOCK.


  IF Treemenu.accion <> "" 
  THEN DO:
      v-accion = Treemenu.accion + ":" + Treemenu.descripcion.
      DISPLAY v-accion
          WITH FRAME {&FRAME-NAME}.
      RUN ejecutar ( INPUT Treemenu.accion, INPUT Treemenu.modo, INPUT Treemenu.cdg_comprobante ).
  END.
  ELSE DO:
      v-accion = Treemenu.descripcion.
      DISPLAY v-accion
          WITH FRAME {&FRAME-NAME}.
  END.


/*========= For text treview sample, nodeKey beings 'n' ================*/


/*======== For data treeview example on salesrep customer order orderline: ========*/



/*-------------- add more customers to salesrep --------------*/
/*
IF pcNodeKey BEGINS "MoreCust=" THEN DO:
    ASSIGN
     icustnum = INT(ENTRY(2,pcNodeKey,"="))
     cparentKey = DYNAMIC-FUNCTION('getNodeParentKey' IN h_pure4glTv, pcNodeKey)
     cSalesrep = ENTRY(2,cparentKey,"=").
    FIND customer NO-LOCK WHERE customer.custnum = icustnum.
    cCustName = customer.name.
    
    FOR EACH customer NO-LOCK WHERE
     customer.salesrep = cSalesrep
     AND customer.name >= cCustName
     BY customer.name:
        nCust = nCust + 1.
        IF nCust > giRowsToBatch THEN DO:
            RUN addNode IN h_pure4gltv ("MoreCust=" + STRING(customer.custnum)
                                       ,cparentKey
                                       ,"More..."
                                       ,""
                                       ,"InViewPortIfPossible").
            LEAVE.
        END.
        optn = "InViewPortIfPossible".
        IF nCust = 1 THEN optn = optn + CHR(1) + "selected".
        IF CAN-FIND(FIRST order OF customer)
         THEN optn = optn + CHR(1) + "addOnExpand".
        
        RUN addNode IN h_pure4gltv ("cust=" + STRING(customer.custnum)
                                   ,cParentKey
                                   ,customer.name
                                   ,"tvpics/smile56.bmp"
                                   ,optn).
    END.  /* for each customer */
    
    RUN deleteNode IN h_Pure4glTv (pcNodeKey, "refresh").
END. /* add more customers to salesrep node */


/*-------------- add more orders to customer --------------*/
IF pcNodeKey BEGINS "MoreOrder=" THEN DO:
    ASSIGN
     iorder = INT(ENTRY(2,pcNodeKey,"="))
     cparentKey = DYNAMIC-FUNCTION('getNodeParentKey' IN h_pure4glTv, pcNodeKey)
     icustnum = INT(ENTRY(2,cparentKey,"=")).
     
    FOR EACH order NO-LOCK WHERE
     order.custnum = icustnum
     AND order.ordernum >= iorder
     BY order.ordernum:
        norder = nOrder + 1.
        IF norder > giRowsToBatch THEN DO:
            RUN addNode IN h_pure4gltv ("MoreOrder=" + STRING(order.ordernum)
                                       ,cparentKey
                                       ,"More..."
                                       ,""
                                       ,"InViewPortIfPossible").
            LEAVE.
        END.
        optn = "InViewPortIfPossible".
        IF norder = 1 THEN optn = optn + CHR(1) + "selected".
        IF CAN-FIND(FIRST orderline OF order)
         THEN optn = optn + CHR(1) + "addOnExpand".
        
        RUN addNode IN h_pure4gltv ("order=" + STRING(order.ordernum)
                                   ,cparentKey
                                   ,STRING(order.ordernum) + " (" + STRING(order.orderdate) + ")"
                                   ,"tvpics/book02.bmp"
                                   ,optn).
    END.  /* for each customer */
    RUN deleteNode IN h_Pure4glTv (pcNodeKey, "refresh").
END. /* add customers to salesrep node */
*/
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

FIND Treemenu WHERE Treemenu.cdg_item = pcNodeKey AND Treemenu.cdg_empresa = v-cdg_empresa NO-LOCK.
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
                                       THEN IF CAN-FIND(FIRST B-Submenu WHERE B-Submenu.cdg_padre = Submenu.cdg_item ) 
                                                        THEN "tvpics/fold.bmp" ELSE "tvpics/windows.bmp"
                                       ELSE Submenu.archivo_icono
                                   ,IF CAN-FIND(FIRST B-Submenu WHERE B-Submenu.cdg_padre = Submenu.cdg_item ) 
                                       THEN "addOnExpand" 
                                       ELSE "").
                                   
        
    END.
END.

/*-------------- add customers to salesrep --------------*/
/*
IF pcNodeKey BEGINS "sr=" THEN DO:
    cSalesrep = ENTRY(2,pcNodeKey,"=").
    FOR EACH customer NO-LOCK WHERE customer.salesrep = cSalesrep BY customer.name:
        nCust = nCust + 1.
        IF nCust > giRowsToBatch THEN DO:
            RUN addNode IN h_pure4gltv ("MoreCust=" + STRING(customer.custnum)
                                       ,pcNodeKey
                                       ,"More..."
                                       ,""
                                       ,"").
            LEAVE.
        END.
        RUN addNode IN h_pure4gltv ("cust=" + STRING(customer.custnum)
                                   ,pcNodeKey
                                   ,customer.name
                                   ,"tvpics/smile56.bmp"
                                   ,IF CAN-FIND(FIRST order OF customer) THEN "addOnExpand" ELSE "").
    END.  /* for each customer */
END. /* add customers to salesrep node */
*/

/*-------------- add orders to customer --------------*/
/*
IF pcNodeKey BEGINS "cust=" THEN DO:
    icustnum = INT(ENTRY(2,pcNodeKey,"=")).
    FOR EACH order NO-LOCK WHERE order.custnum = icustnum BY order.ordernum:
        norder = nOrder + 1.
        IF norder > giRowsToBatch THEN DO:
            RUN addNode IN h_pure4gltv ("MoreOrder=" + STRING(order.ordernum)
                                       ,pcNodeKey
                                       ,"More..."
                                       ,""
                                       ,"").
            LEAVE.
        END.
        RUN addNode IN h_pure4gltv ("order=" + STRING(order.ordernum)
                                   ,pcNodeKey
                                   ,STRING(order.ordernum) + " (" + STRING(order.orderdate) + ")"
                                   ,"tvpics/book02.bmp"
                                   ,IF CAN-FIND(FIRST orderline OF order) THEN "addOnExpand" ELSE "").
    END.  /* for each customer */
END. /* add customers to salesrep node */
*/

/*-------------- add orderline to order --------------*/
/*
IF pcNodeKey BEGINS "order=" THEN DO:
    iorder   = INT(ENTRY(2,pcNodeKey,"=")).
    FOR EACH orderline NO-LOCK WHERE orderline.ordernum = iorder BY orderline.linenum:
        FIND ITEM OF orderline NO-LOCK. 
        RUN addNode IN h_pure4gltv ("OL=" + STRING(iorder) + ";" + STRING(orderline.linenum)
                                   ,pcNodeKey
                                   ,STRING(orderline.linenum) + "  " + ITEM.itemname
                                   ,"tvpics/present1.bmp"
                                   ,"") NO-ERROR.
    END. /* FOR EACH orderline */
    IF ERROR-STATUS:ERROR THEN MESSAGE RETURN-VALUE VIEW-AS ALERT-BOX INFO BUTTONS OK.
END.

/* example with directory tree */

IF pcNodeKey BEGINS "fileName=" THEN DO:
    cFullPath = ENTRY(2,pcNodeKey,"=").
    RUN loadDirectory (pcNodeKey, cFullPath).
END.

*/

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
 THEN RETURN "Add a child node,MenuAddChildNode,RULE,,Hello World,MenuHelloWorld".


/*======== For data treeview example on salesrep customer order orderline: ========*/
/* popup menu addSalesRep and addCustomer */
IF pcNodeKey BEGINS "sr="
 THEN RETURN "Add Salesrep,MenuAddSR,Add Customer,MenuAddCustomer".

/*-------------- Popup menu addOrder  --------------*/
IF pcNodeKey BEGINS "cust="
 THEN RETURN "Add order,MenuAddOrder".

/*-------------- Popup menu addOrderline --------------*/
IF pcNodeKey BEGINS "order="
 THEN RETURN "Add order line,MenuAddOrderLine".

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
IF pcnodeKey BEGINS "k" THEN DO:
    DEFINE VARIABLE targetKe AS CHARACTER  NO-UNDO.
    targetKe = DYNAMIC-FUNCTION('getNodeLocatedAtXY' IN h_pure4GlTv, mouseX, mouseY).
    
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
/*          MESSAGE "me apretaste el boton derecho del mouse"
              VIEW-AS ALERT-BOX INFO BUTTONS OK TITLE "tvnodeevent".
      RUN tvNodeCreatePopup (pcnodeKey) NO-ERROR.
      IF NOT ERROR-STATUS:ERROR THEN RETURN RETURN-VALUE.
      ELSE MESSAGE "tvNodeCreatePopup failed with the following message:" RETURN-VALUE
        VIEW-AS ALERT-BOX INFO BUTTONS OK.
        */
  END.
  
  /* place to handle the Menu event */
  WHEN "MenuAddChildNode"
   OR WHEN "MenuAddSR"
   OR WHEN "MenuAddCustomer"
   OR WHEN "MenuAddOrder"
   OR WHEN "MenuAddOrderLine"
   THEN /*addToEdMsg("Menu item event fired: " + pcEvent + " for key " + pcnodeKey + "~n")*/.
   
   WHEN "MenuHelloWorld" THEN MESSAGE "Hello World!" SKIP
      "Node key parent of the popup menu item:" + pcNodeKey
        VIEW-AS ALERT-BOX INFO BUTTONS OK.
   
   WHEN "DragBegin" THEN DO:
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

DEFINE VARIABLE nCust     AS INTEGER    NO-UNDO.
DEFINE VARIABLE norder    AS INTEGER    NO-UNDO.

DEFINE VARIABLE cSalesrep  AS CHARACTER  NO-UNDO.
DEFINE VARIABLE icustnum   AS INTEGER    NO-UNDO.
DEFINE VARIABLE ccustname  AS CHARACTER  NO-UNDO.
DEFINE VARIABLE iorder     AS INTEGER    NO-UNDO.
DEFINE VARIABLE cparentKey AS CHARACTER  NO-UNDO.
DEFINE VARIABLE optn       AS CHARACTER  NO-UNDO.

FIND Treemenu 
    WHERE Treemenu.cdg_item = pcNodeKey 
    AND Treemenu.cdg_empresa = v-cdg_empresa
        NO-LOCK.
IF Treemenu.accion <> "" AND Treemenu.accion <> ":X"
THEN DO:
  v-accion = Treemenu.accion.
  DISPLAY v-accion
      WITH FRAME {&FRAME-NAME}.
END.
ELSE DO:
  v-accion = "".
  DISPLAY v-accion
      WITH FRAME {&FRAME-NAME}.
END.

/*========= For text treview sample, nodeKey beings 'n' ================*/


/*======== For data treeview example on salesrep customer order orderline: ========*/



/*-------------- add more customers to salesrep --------------*/
/*
IF pcNodeKey BEGINS "MoreCust=" THEN DO:
    ASSIGN
     icustnum = INT(ENTRY(2,pcNodeKey,"="))
     cparentKey = DYNAMIC-FUNCTION('getNodeParentKey' IN h_pure4glTv, pcNodeKey)
     cSalesrep = ENTRY(2,cparentKey,"=").
    FIND customer NO-LOCK WHERE customer.custnum = icustnum.
    cCustName = customer.name.
    
    FOR EACH customer NO-LOCK WHERE
     customer.salesrep = cSalesrep
     AND customer.name >= cCustName
     BY customer.name:
        nCust = nCust + 1.
        IF nCust > giRowsToBatch THEN DO:
            RUN addNode IN h_pure4gltv ("MoreCust=" + STRING(customer.custnum)
                                       ,cparentKey
                                       ,"More..."
                                       ,""
                                       ,"InViewPortIfPossible").
            LEAVE.
        END.
        optn = "InViewPortIfPossible".
        IF nCust = 1 THEN optn = optn + CHR(1) + "selected".
        IF CAN-FIND(FIRST order OF customer)
         THEN optn = optn + CHR(1) + "addOnExpand".
        
        RUN addNode IN h_pure4gltv ("cust=" + STRING(customer.custnum)
                                   ,cParentKey
                                   ,customer.name
                                   ,"tvpics/smile56.bmp"
                                   ,optn).
    END.  /* for each customer */
    
    RUN deleteNode IN h_Pure4glTv (pcNodeKey, "refresh").
END. /* add more customers to salesrep node */


/*-------------- add more orders to customer --------------*/
IF pcNodeKey BEGINS "MoreOrder=" THEN DO:
    ASSIGN
     iorder = INT(ENTRY(2,pcNodeKey,"="))
     cparentKey = DYNAMIC-FUNCTION('getNodeParentKey' IN h_pure4glTv, pcNodeKey)
     icustnum = INT(ENTRY(2,cparentKey,"=")).
     
    FOR EACH order NO-LOCK WHERE
     order.custnum = icustnum
     AND order.ordernum >= iorder
     BY order.ordernum:
        norder = nOrder + 1.
        IF norder > giRowsToBatch THEN DO:
            RUN addNode IN h_pure4gltv ("MoreOrder=" + STRING(order.ordernum)
                                       ,cparentKey
                                       ,"More..."
                                       ,""
                                       ,"InViewPortIfPossible").
            LEAVE.
        END.
        optn = "InViewPortIfPossible".
        IF norder = 1 THEN optn = optn + CHR(1) + "selected".
        IF CAN-FIND(FIRST orderline OF order)
         THEN optn = optn + CHR(1) + "addOnExpand".
        
        RUN addNode IN h_pure4gltv ("order=" + STRING(order.ordernum)
                                   ,cparentKey
                                   ,STRING(order.ordernum) + " (" + STRING(order.orderdate) + ")"
                                   ,"tvpics/book02.bmp"
                                   ,optn).
    END.  /* for each customer */
    RUN deleteNode IN h_Pure4glTv (pcNodeKey, "refresh").
END. /* add customers to salesrep node */
*/
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

