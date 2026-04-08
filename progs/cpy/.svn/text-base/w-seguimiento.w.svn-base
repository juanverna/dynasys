&ANALYZE-SUSPEND _VERSION-NUMBER UIB_v8r12 GUI ADM1
&ANALYZE-RESUME
&Scoped-define WINDOW-NAME W-Win
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _DEFINITIONS W-Win 
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

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE SmartWindow
&Scoped-define DB-AWARE no

&Scoped-define ADM-CONTAINER WINDOW

/* Name of first Frame and/or Browse and/or first Query                 */
&Scoped-define FRAME-NAME F-Main

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS IMAGE-1 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME



/* ***********************  Control Definitions  ********************** */

/* Define the widget handle for the window                              */
DEFINE VAR W-Win AS WIDGET-HANDLE NO-UNDO.

/* Menu Definitions                                                     */
DEFINE SUB-MENU m_Archivo 
       MENU-ITEM m_Ver_Conexin  LABEL "&Ver Conexión" 
       RULE
       MENU-ITEM m_Conectar_Ambiente LABEL "&Conectar Ambiente"
       MENU-ITEM m_Desconectar_Ambiente LABEL "&Desconectar Ambiente"
       RULE
       MENU-ITEM m_Datos_de_la_Empresa_Actual LABEL "Da&tos de la Empresa Actual"
              DISABLED
       MENU-ITEM m_Cambio_de_Empresa LABEL "Cam&bio de Empresa"
       RULE
       MENU-ITEM m_Salir        LABEL "&Salir"        .

DEFINE SUB-MENU m_Seguridad 
       MENU-ITEM m_Cambio_de_Clave LABEL "Cambio de &Clave"
       MENU-ITEM m_Cambio_de_Login LABEL "Cambio de &Login".

DEFINE MENU MENU-BAR-W-Win MENUBAR
       SUB-MENU  m_Archivo      LABEL "&Archivo"      
       SUB-MENU  m_Seguridad    LABEL "&Seguridad"    .


/* Definitions of the field level widgets                               */
DEFINE IMAGE IMAGE-1
     FILENAME "imagenes\dibujo":U
     SIZE 108 BY 19.65.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME F-Main
     IMAGE-1 AT ROW 1.81 COL 4
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 114.29 BY 23.81.


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
         TITLE              = "DYNASYS 1.0"
         HEIGHT             = 23.08
         WIDTH              = 114.29
         MAX-HEIGHT         = 28.62
         MAX-WIDTH          = 146.29
         VIRTUAL-HEIGHT     = 28.62
         VIRTUAL-WIDTH      = 146.29
         RESIZE             = no
         SCROLL-BARS        = no
         STATUS-AREA        = no
         BGCOLOR            = ?
         FGCOLOR            = ?
         THREE-D            = yes
         MESSAGE-AREA       = no
         SENSITIVE          = yes.
ELSE {&WINDOW-NAME} = CURRENT-WINDOW.

ASSIGN {&WINDOW-NAME}:MENUBAR    = MENU MENU-BAR-W-Win:HANDLE.

&IF '{&WINDOW-SYSTEM}' NE 'TTY' &THEN
IF NOT W-Win:LOAD-ICON("adeicon\clrchnge":U) THEN
    MESSAGE "Unable to load icon: adeicon\clrchnge"
            VIEW-AS ALERT-BOX WARNING BUTTONS OK.
&ENDIF
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
IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(W-Win)
THEN W-Win:HIDDEN = yes.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME W-Win
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL W-Win W-Win
ON END-ERROR OF W-Win /* DYNASYS 1.0 */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL W-Win W-Win
ON WINDOW-CLOSE OF W-Win /* DYNASYS 1.0 */
DO:
  /* This ADM code must be left here in order for the SmartWindow
     and its descendents to terminate properly on exit. */

  IF puede_salir
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


&Scoped-define SELF-NAME m_Cambio_de_Clave
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL m_Cambio_de_Clave W-Win
ON CHOOSE OF MENU-ITEM m_Cambio_de_Clave /* Cambio de Clave */
DO:
  RUN d-segcmbpw.w.  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME m_Cambio_de_Empresa
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL m_Cambio_de_Empresa W-Win
ON CHOOSE OF MENU-ITEM m_Cambio_de_Empresa /* Cambio de Empresa */
DO:
  RUN c-cambioempresa.w.
  RUN armar_titulo ( OUTPUT titulo ).
  RUN levantar_ambiente.
  RUN poner_sesion ( hubo_logon, INPUT titulo ).
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME m_Cambio_de_Login
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL m_Cambio_de_Login W-Win
ON CHOOSE OF MENU-ITEM m_Cambio_de_Login /* Cambio de Login */
DO:
  RUN conectar_ambiente ( OUTPUT hubo_logon ).
  IF NOT hubo_logon THEN QUIT.
  RUN armar_titulo ( OUTPUT titulo ).
  RUN poner_sesion ( hubo_logon, INPUT titulo ).
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME m_Datos_de_la_Empresa_Actual
&Scoped-define SELF-NAME m_Salir
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL m_Salir W-Win
ON CHOOSE OF MENU-ITEM m_Salir /* Salir */
DO:
  IF puede_salir
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


&Scoped-define SELF-NAME m_Ver_Conexin
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL m_Ver_Conexin W-Win
ON CHOOSE OF MENU-ITEM m_Ver_Conexin /* Ver Conexión */
DO:
  RUN d-verconect.w.
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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE ejecutar_menu W-Win 
PROCEDURE ejecutar_menu :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

  DEFINE VARIABLE x-titulo AS CHARACTER.
  
  RUN habilitar_frame ( INPUT NO ).
  RUN habilitar_salida ( INPUT NO ).

  RUN w-treemenu.w ( INPUT SELF:PRIVATE-DATA ).
  RUN armar_titulo ( OUTPUT x-titulo ).
  {&WINDOW-NAME}:TITLE = x-titulo.

  RUN habilitar_salida ( INPUT YES ).
  RUN habilitar_frame ( INPUT YES ).

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
  ENABLE IMAGE-1 
      WITH FRAME F-Main IN WINDOW W-Win.
  {&OPEN-BROWSERS-IN-QUERY-F-Main}
  VIEW W-Win.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE habilitar_salida W-Win 
PROCEDURE habilitar_salida :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

  DEFINE INPUT PARAMETER p-habilitado AS LOGICAL.

  puede_salir = p-habilitado.

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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE poner_sesion W-Win 
PROCEDURE poner_sesion :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

  DEFINE INPUT PARAMETER p-estado AS LOGICAL.
  DEFINE INPUT PARAMETER p-titulo AS CHARACTER.

/*==========================================================================*/
/*                          BLOQUE PRINCIPAL                                */
/*==========================================================================*/

  {&WINDOW-NAME}:TITLE = p-titulo.

  RUN habilitar_frame ( INPUT p-estado ).

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

  /* SEND-RECORDS does nothing because there are no External
     Tables specified for this SmartWindow, and there are no
     tables specified in any contained Browse, Query, or Frame. */

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

