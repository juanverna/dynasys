&ANALYZE-SUSPEND _VERSION-NUMBER UIB_v9r12 GUI
&ANALYZE-RESUME
/* Connected Databases 
          sic              PROGRESS
*/
&Scoped-define WINDOW-NAME C-Win
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _DEFINITIONS C-Win 
/*------------------------------------------------------------------------

  File: 

  Description: 

  Input Parameters:
      <none>

  Output Parameters:
      <none>

  Author: 

  Created: 

------------------------------------------------------------------------*/
/*          This .W file was created with the Progress AppBuilder.      */
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

&GLOBAL-DEFINE INFINITE                         -2147483648
&GLOBAL-DEFINE FILE_NOTIFY_CHANGE_FILE_NAME     1
&GLOBAL-DEFINE FILE_NOTIFY_CHANGE_DIR_NAME      2
&GLOBAL-DEFINE FILE_NOTIFY_CHANGE_ATTRIBUTES    4
&GLOBAL-DEFINE FILE_NOTIFY_CHANGE_SIZE          8
&GLOBAL-DEFINE FILE_NOTIFY_CHANGE_LAST_WRITE    16
&GLOBAL-DEFINE FILE_NOTIFY_CHANGE_LAST_ACCESS   32
&GLOBAL-DEFINE FILE_NOTIFY_CHANGE_CREATION      64
&GLOBAL-DEFINE FILE_NOTIFY_CHANGE_SECURITY      256

&GLOBAL-DEFINE WAIT_OBJECT_0                    0
&GLOBAL-DEFINE WAIT_ABANDONED                   144
&GLOBAL-DEFINE WAIT_IO_COMPLETION                       192
&GLOBAL-DEFINE WAIT_TIMEOUT                     258     
&GLOBAL-DEFINE STATUS_PENDING                   259

DEFINE VARIABLE TerminateFlag AS LOGICAL NO-UNDO.
DEFINE VARIABLE hWatched      AS INTEGER NO-UNDO.

DEFINE VARIABLE PathInp      AS CHARACTER NO-UNDO INIT "z:\watch\in".
DEFINE VARIABLE PathOut       AS CHARACTER NO-UNDO INIT "z:\watch\out".

DEFINE TEMP-TABLE TT_File NO-UNDO
    FIELD File_Name   AS CHARACTER
    FIELD FullPath    AS CHARACTER
    FIELD CreateDate  AS DATE
    FIELD CreateTime  AS INTEGER
    FIELD ModDate     AS DATE
    FIELD ModTime     AS INTEGER.

DEFINE TEMP-TABLE T-Logaccion NO-UNDO
    FIELD fecha AS DATE COLUMN-LABEL "Fecha!Novedad"
    FIELD hora AS CHARACTER COLUMN-LABEL "Hora!Novedad" 
    FIELD File_Name   AS CHARACTER FORMAT "X(50)" COLUMN-LABEL "Descripción!Novedad".

{parlocales.i}

{XPRINT.I}

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE Window
&Scoped-define DB-AWARE no

/* Name of first Frame and/or Browse and/or first Query                 */
&Scoped-define FRAME-NAME DEFAULT-FRAME
&Scoped-define BROWSE-NAME BROWSE-5

/* Internal Tables (found by Frame, Query & Browse Queries)             */
&Scoped-define INTERNAL-TABLES T-Logaccion

/* Definitions for BROWSE BROWSE-5                                      */
&Scoped-define FIELDS-IN-QUERY-BROWSE-5 T-Logaccion.fecha T-Logaccion.hora T-Logaccion.file_name   
&Scoped-define ENABLED-FIELDS-IN-QUERY-BROWSE-5   
&Scoped-define SELF-NAME BROWSE-5
&Scoped-define QUERY-STRING-BROWSE-5 FOR EACH T-Logaccion BY T-Logaccion.fecha DESCENDING                                              BY T-Logaccion.hora DESCENDING
&Scoped-define OPEN-QUERY-BROWSE-5 OPEN QUERY {&SELF-NAME} FOR EACH T-Logaccion BY T-Logaccion.fecha DESCENDING                                              BY T-Logaccion.hora DESCENDING.
&Scoped-define TABLES-IN-QUERY-BROWSE-5 T-Logaccion
&Scoped-define FIRST-TABLE-IN-QUERY-BROWSE-5 T-Logaccion


/* Definitions for FRAME DEFAULT-FRAME                                  */
&Scoped-define OPEN-BROWSERS-IN-QUERY-DEFAULT-FRAME ~
    ~{&OPEN-QUERY-BROWSE-5}

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS b_BeginWatch b_Exit btn_minimizar ~
v-directorio BUTTON-1 BROWSE-5 
&Scoped-Define DISPLAYED-OBJECTS v-directorio 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME


/* ************************  Function Prototypes ********************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION-FORWARD WatchChangeAction C-Win 
FUNCTION WatchChangeAction RETURNS LOGICAL
  ( INPUT pAction   AS CHARACTER)  FORWARD.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION-FORWARD WatchCreate C-Win 
FUNCTION WatchCreate RETURNS INTEGER
  ( INPUT pPath AS CHARACTER,
    INPUT pFlags AS INTEGER )  FORWARD.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION-FORWARD WatchDelete C-Win 
FUNCTION WatchDelete RETURNS LOGICAL
  ( INPUT pWatched  AS INTEGER )  FORWARD.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


/* ***********************  Control Definitions  ********************** */

/* Define the widget handle for the window                              */
DEFINE VAR C-Win AS WIDGET-HANDLE NO-UNDO.

/* Definitions of the field level widgets                               */
DEFINE BUTTON btn_minimizar 
     LABEL "Minimizar" 
     SIZE 12 BY 1.14.

DEFINE BUTTON BUTTON-1 
     LABEL "Asignar" 
     SIZE 14 BY 1.14.

DEFINE BUTTON b_BeginWatch 
     LABEL "Iniciar Monitor" 
     SIZE 24 BY 1.14.

DEFINE BUTTON b_Exit 
     LABEL "Salir" 
     SIZE 11 BY 1.14.

DEFINE BUTTON b_StopWatch 
     LABEL "Detener Monitor" 
     SIZE 24 BY 1.14.

DEFINE VARIABLE v-directorio AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 59 BY 1 NO-UNDO.

/* Query definitions                                                    */
&ANALYZE-SUSPEND
DEFINE QUERY BROWSE-5 FOR 
      T-Logaccion SCROLLING.
&ANALYZE-RESUME

/* Browse definitions                                                   */
DEFINE BROWSE BROWSE-5
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS BROWSE-5 C-Win _FREEFORM
  QUERY BROWSE-5 DISPLAY
      T-Logaccion.fecha 
     T-Logaccion.hora
     T-Logaccion.file_name
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ROW-MARKERS SEPARATORS SIZE 74 BY 17.38 EXPANDABLE.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME DEFAULT-FRAME
     b_BeginWatch AT ROW 1.24 COL 4
     b_StopWatch AT ROW 1.24 COL 29
     b_Exit AT ROW 1.24 COL 54
     btn_minimizar AT ROW 1.24 COL 66
     v-directorio AT ROW 2.67 COL 2 COLON-ALIGNED NO-LABEL
     BUTTON-1 AT ROW 2.67 COL 64
     BROWSE-5 AT ROW 4.1 COL 4
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 80 BY 20.86.


/* *********************** Procedure Settings ************************ */

&ANALYZE-SUSPEND _PROCEDURE-SETTINGS
/* Settings for THIS-PROCEDURE
   Type: Window
   Allow: Basic,Browse,DB-Fields,Window,Query
   Other Settings: COMPILE
 */
&ANALYZE-RESUME _END-PROCEDURE-SETTINGS

/* *************************  Create Window  ************************** */

&ANALYZE-SUSPEND _CREATE-WINDOW
IF SESSION:DISPLAY-TYPE = "GUI":U THEN
  CREATE WINDOW C-Win ASSIGN
         HIDDEN             = YES
         TITLE              = "Monitor de Impresión"
         HEIGHT             = 20.86
         WIDTH              = 80
         MAX-HEIGHT         = 25.91
         MAX-WIDTH          = 160
         VIRTUAL-HEIGHT     = 25.91
         VIRTUAL-WIDTH      = 160
         CONTROL-BOX        = no
         MIN-BUTTON         = no
         MAX-BUTTON         = no
         RESIZE             = yes
         SCROLL-BARS        = no
         STATUS-AREA        = no
         BGCOLOR            = ?
         FGCOLOR            = ?
         KEEP-FRAME-Z-ORDER = yes
         THREE-D            = yes
         MESSAGE-AREA       = no
         SENSITIVE          = yes.
ELSE {&WINDOW-NAME} = CURRENT-WINDOW.
/* END WINDOW DEFINITION                                                */
&ANALYZE-RESUME



/* ***********  Runtime Attributes and AppBuilder Settings  *********** */

&ANALYZE-SUSPEND _RUN-TIME-ATTRIBUTES
/* SETTINGS FOR FRAME DEFAULT-FRAME
                                                                        */
/* BROWSE-TAB BROWSE-5 BUTTON-1 DEFAULT-FRAME */
/* SETTINGS FOR BUTTON b_StopWatch IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(C-Win)
THEN C-Win:HIDDEN = no.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME


/* Setting information for Queries and Browse Widgets fields            */

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE BROWSE-5
/* Query rebuild information for BROWSE BROWSE-5
     _START_FREEFORM
OPEN QUERY {&SELF-NAME} FOR EACH T-Logaccion BY T-Logaccion.fecha DESCENDING
                                             BY T-Logaccion.hora DESCENDING.
     _END_FREEFORM
     _Query            is OPENED
*/  /* BROWSE BROWSE-5 */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME C-Win
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON END-ERROR OF C-Win /* Monitor de Impresión */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  MESSAGE "You must select the 'Exit' button to leave"
          VIEW-AS ALERT-BOX WARNING.
  RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON WINDOW-CLOSE OF C-Win /* Monitor de Impresión */
DO:
  RUN StopWatch.

  /* This event will close the window and terminate the procedure.  */
  APPLY "CLOSE":U TO THIS-PROCEDURE.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btn_minimizar
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btn_minimizar C-Win
ON CHOOSE OF btn_minimizar IN FRAME DEFAULT-FRAME /* Minimizar */
DO:
  CURRENT-WINDOW:WINDOW-STATE = 2.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME BUTTON-1
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL BUTTON-1 C-Win
ON CHOOSE OF BUTTON-1 IN FRAME DEFAULT-FRAME /* Asignar */
DO:
  PathInp = v-directorio:INPUT-VALUE.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME b_BeginWatch
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL b_BeginWatch C-Win
ON CHOOSE OF b_BeginWatch IN FRAME DEFAULT-FRAME /* Iniciar Monitor */
DO:
  ASSIGN SELF:SENSITIVE = FALSE.

  ENABLE b_StopWatch WITH FRAME {&FRAME-NAME}.

  RUN WatchFolder.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME b_Exit
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL b_Exit C-Win
ON CHOOSE OF b_Exit IN FRAME DEFAULT-FRAME /* Salir */
DO:
    RUN StopWatch.

  /* This event will close the window and terminate the procedure.  */
  APPLY "CLOSE":U TO THIS-PROCEDURE.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME b_StopWatch
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL b_StopWatch C-Win
ON CHOOSE OF b_StopWatch IN FRAME DEFAULT-FRAME /* Detener Monitor */
DO:
  ASSIGN SELF:SENSITIVE = FALSE.
  RUN StopWatch.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define BROWSE-NAME BROWSE-5
&UNDEFINE SELF-NAME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _MAIN-BLOCK C-Win 


/* ***************************  Main Block  *************************** */

/* Set CURRENT-WINDOW: this will parent dialog-boxes and frames.        */
ASSIGN CURRENT-WINDOW                = {&WINDOW-NAME} 
       THIS-PROCEDURE:CURRENT-WINDOW = {&WINDOW-NAME}.

/* The CLOSE event can be used from inside or outside the procedure to  */
/* terminate it.                                                        */
ON CLOSE OF THIS-PROCEDURE 
   RUN disable_UI.

/* Best default for GUI applications is...                              */
PAUSE 0 BEFORE-HIDE.
/*
RUN getparametro.p (  INPUT  "ICONOBIG",
                      OUTPUT v-valor_c,
                      OUTPUT v-valor_d,
                      OUTPUT v-valor_l,
                      OUTPUT v-valor_n,
                      OUTPUT v-observacion ).

SESSION:LOAD-ICON(v-valor_c).

RUN getparametro.p (  INPUT  "ICONOSML",
                      OUTPUT v-valor_c,
                      OUTPUT v-valor_d,
                      OUTPUT v-valor_l,
                      OUTPUT v-valor_n,
                      OUTPUT v-observacion ).

RUN seticonotarea.p ( INPUT "Monitor de Archivos",
                      INPUT v-valor_c).
*/
v-directorio = Pathinp.

/* Now enable the interface and wait for the exit condition.            */
/* (NOTE: handle ERROR and END-KEY so cleanup code will always fire.    */

MAIN-BLOCK:
DO ON ERROR   UNDO MAIN-BLOCK, LEAVE MAIN-BLOCK
   ON END-KEY UNDO MAIN-BLOCK, LEAVE MAIN-BLOCK:
  RUN enable_UI.
  WAIT-FOR CLOSE OF THIS-PROCEDURE.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


/* **********************  Internal Procedures  *********************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE disable_UI C-Win  _DEFAULT-DISABLE
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
  IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(C-Win)
  THEN DELETE WIDGET C-Win.
  IF THIS-PROCEDURE:PERSISTENT THEN DELETE PROCEDURE THIS-PROCEDURE.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE enable_UI C-Win  _DEFAULT-ENABLE
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
  DISPLAY v-directorio 
      WITH FRAME DEFAULT-FRAME IN WINDOW C-Win.
  ENABLE b_BeginWatch b_Exit btn_minimizar v-directorio BUTTON-1 BROWSE-5 
      WITH FRAME DEFAULT-FRAME IN WINDOW C-Win.
  {&OPEN-BROWSERS-IN-QUERY-DEFAULT-FRAME}
  VIEW C-Win.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE imprimir_texto C-Win 
PROCEDURE imprimir_texto :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

  DEFINE INPUT PARAMETER p-archivo AS CHARACTER.

  DEFINE VARIABLE x-nombre_archivo   AS CHARACTER.
  DEFINE VARIABLE x-que_font         AS INTEGER.
  DEFINE VARIABLE x-modo_hoja        AS INTEGER.
  DEFINE VARIABLE x-lin_pagina       AS INTEGER.
  DEFINE VARIABLE x-Printed        AS INTEGER.

  x-nombre_archivo = ENTRY(NUM-ENTRIES(p-archivo,"\"),p-archivo,"\").
  x-modo_hoja = IF SUBSTRING(x-nombre_archivo,1,1) = "H"
                 THEN 0 ELSE 2.
  x-que_font = INTEGER(SUBSTRING(x-nombre_archivo,2,2)).
  x-lin_pagina = INTEGER(SUBSTRING(x-nombre_archivo,4,2)).

  RUN _osprint.p ( INPUT  CURRENT-WINDOW:HANDLE, /* HANDLE de la WINDOW    */
                   INPUT  p-archivo,             /* Archivo a imprimir     */
                   INPUT  x-que_font,            /* FONT a utilizar        */
                   INPUT  x-modo_hoja,           /* Print Flags 2=Apaisado */
                   INPUT  x-lin_pagina,          /* Lineas por Pagina      */
                   INPUT  0,                     /* 0= Todo, <>0 seleccion */
                   OUTPUT x-Printed ).           /* Se imprimió o no       */

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE LoadDirectoryFiles C-Win 
PROCEDURE LoadDirectoryFiles :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

  EMPTY TEMP-TABLE TT_File.
  
  INPUT FROM OS-DIR(PathInp) NO-ECHO.
  REPEAT:

    CREATE TT_File.
    IMPORT TT_File.File_Name
           TT_File.FullPath.
    
  END.
  INPUT CLOSE.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE ProcessFiles C-Win 
PROCEDURE ProcessFiles :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

FOR EACH TT_File:
  FILE-INFO:FILE-NAME = TT_File.FullPath.

  IF INDEX(FILE-INFO:FILE-TYPE,"F") > 0 THEN
    RUN ProcessOneFile.

  DELETE TT_File.
END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE ProcessOneFile C-Win 
PROCEDURE ProcessOneFile :
/*------------------------------------------------------------------------------
  Purpose:     Perform an action against a file.
  Parameters:  <none>
  Notes:       You have access to the TT_File buffer in this procedure so use
               the filename to perform some actions.
               
------------------------------------------------------------------------------*/
  
  /* Copy Original File to OUT Directory */
  /*
  MESSAGE TT_File.FullPath
      VIEW-AS ALERT-BOX INFO BUTTONS OK.
  */
  
    FILE-INFO:File-NAME = TT_File.FullPath.

    CASE ENTRY(NUM-ENTRIES(FILE-INFO:FULL-PATHNAME,"."),FILE-INFO:FULL-PATHNAME,"."):
        WHEN "XPR" THEN RUN printFile( FILE-INFO:FULL-PATHNAME). /* Primera copia */
        WHEN "TXT" THEN RUN imprimir_texto( FILE-INFO:FULL-PATHNAME). /* Primera copia */
        OTHERWISE MESSAGE "We are in the furnace!!!" VIEW-AS ALERT-BOX MESSAGE.
    END CASE.

    
  
  
  /* Delete Original File */
    OS-DELETE VALUE(TT_File.FullPath).

  /* Update the screen log to show that we processed the file */
    WatchChangeAction (TT_File.FullPath).

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE StopWatch C-Win 
PROCEDURE StopWatch :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

  WatchDelete(hWatched).
  hWatched = 0.

  WatchChangeAction("Monitor Detenido").

  ENABLE b_BeginWatch WITH FRAME {&FRAME-NAME}.
  
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE WatchDirectory C-Win 
PROCEDURE WatchDirectory :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEFINE INPUT  PARAMETER pWatched  AS INTEGER NO-UNDO.
DEFINE INPUT  PARAMETER pInterval AS INTEGER NO-UNDO.
DEFINE OUTPUT PARAMETER pStatus   AS INTEGER NO-UNDO.

DO WHILE TRUE: 
  RUN WaitForSingleObject(pWatched, pInterval, OUTPUT pStatus).
  PROCESS EVENTS.
  IF pStatus = 0 OR TerminateFlag = TRUE THEN LEAVE.
END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE WatchFolder C-Win 
PROCEDURE WatchFolder :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
  DEFINE VARIABLE WatchStatus AS INTEGER NO-UNDO.

  WatchChangeAction("Esperando actividad en: " + PathInp ).

  /* Modificar aca los eventos que se desea monitorear, pueden ser:
  
             FILE_NOTIFY_CHANGE_FILE_NAME     1
             FILE_NOTIFY_CHANGE_DIR_NAME      2
             FILE_NOTIFY_CHANGE_ATTRIBUTES    4
             FILE_NOTIFY_CHANGE_SIZE          8
             FILE_NOTIFY_CHANGE_LAST_WRITE    16
             FILE_NOTIFY_CHANGE_LAST_ACCESS   32
             FILE_NOTIFY_CHANGE_CREATION      64
             FILE_NOTIFY_CHANGE_SECURITY      256
*/  
   
/*   hWatched = WatchCreate(PathInp, {&FILE_NOTIFY_CHANGE_ATTRIBUTES}       */
/*                                    + {&FILE_NOTIFY_CHANGE_FILE_NAME}      */
/*                                    + {&FILE_NOTIFY_CHANGE_LAST_WRITE}  ). */
  
  hWatched = WatchCreate(PathInp, {&FILE_NOTIFY_CHANGE_ATTRIBUTES} ).
       
  TerminateFlag = FALSE.

  RUN LoadDirectoryFiles.
  IF CAN-FIND(FIRST TT_File) THEN
    RUN ProcessFiles.

  RUN WatchDirectory(hWatched, 100,OUTPUT WatchStatus).

  IF WatchStatus = 0 THEN DO:

    RUN LoadDirectoryFiles.
    IF CAN-FIND(FIRST TT_File) THEN
      RUN ProcessFiles.

    /* now go into a second loop, this time calling the
      FindNextChangeNotification API, again exiting if
      watchStatus indicates the terminate flag was set */

    DO WHILE TRUE:
      RUN WatchResume(hWatched, 100, OUTPUT WatchStatus).
      IF WatchStatus = -1 THEN DO:
        MESSAGE "Watching has been terminated for" PathInp
                VIEW-AS ALERT-BOX.
        LEAVE.
      END.
         
      RUN LoadDirectoryFiles.
      IF CAN-FIND(FIRST TT_File) THEN
        RUN ProcessFiles.

    END.
  END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE WatchResume C-Win 
PROCEDURE WatchResume :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

DEFINE INPUT  PARAMETER pWatched  AS INTEGER NO-UNDO.
DEFINE INPUT  PARAMETER pInterval AS INTEGER NO-UNDO.
DEFINE OUTPUT PARAMETER pStatus   AS INTEGER NO-UNDO.

  RUN FindNextChangeNotification(pWatched, OUTPUT pStatus).

  DO WHILE TRUE: 
    RUN WaitForSingleObject(pWatched, pInterval, OUTPUT pStatus).
    PROCESS EVENTS.
    IF pStatus = 0 OR TerminateFlag = TRUE THEN LEAVE.
  END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE WinAPI C-Win 
PROCEDURE WinAPI :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

END PROCEDURE.

PROCEDURE FindFirstChangeNotificationA EXTERNAL "kernel32":
  DEFINE INPUT PARAMETER lpPathInp     AS CHARACTER.
  DEFINE INPUT PARAMETER bWatchSubTree  AS LONG.
  DEFINE INPUT PARAMETER dwNotifyFilter AS LONG.
  DEFINE RETURN PARAMETER pOut          AS LONG.
END.

PROCEDURE FindCloseChangeNotification EXTERNAL "kernel32":
  DEFINE INPUT  PARAMETER hChangeHandle AS LONG.
  DEFINE RETURN PARAMETER pOut          AS LONG.
END.

PROCEDURE FindNextChangeNotification EXTERNAL "kernel32":
  DEFINE INPUT  PARAMETER hChangeHandle  AS LONG.
  DEFINE RETURN PARAMETER pOut           AS LONG.
END.

PROCEDURE WaitForSingleObject EXTERNAL "kernel32":
  DEFINE INPUT  PARAMETER hHandle        AS LONG.
  DEFINE INPUT  PARAMETER dwMilliseconds AS LONG.
  DEFINE RETURN PARAMETER rOut           AS LONG.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

/* ************************  Function Implementations ***************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION WatchChangeAction C-Win 
FUNCTION WatchChangeAction RETURNS LOGICAL
  ( INPUT pAction   AS CHARACTER) :
/*------------------------------------------------------------------------------
  Purpose:  
    Notes:  
------------------------------------------------------------------------------*/

  CREATE T-Logaccion.
  ASSIGN T-Logaccion.fecha = TODAY
         T-Logaccion.hora = STRING(TIME,"HH:MM:SS")
         T-Logaccion.file_name = pAction.
  {&OPEN-QUERY-{&BROWSE-NAME}}

  RETURN TRUE.   /* Function return value. */

END FUNCTION.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION WatchCreate C-Win 
FUNCTION WatchCreate RETURNS INTEGER
  ( INPUT pPath AS CHARACTER,
    INPUT pFlags AS INTEGER ) :
/*------------------------------------------------------------------------------
  Purpose:  
    Notes:  
------------------------------------------------------------------------------*/

  DEFINE VARIABLE hOut  AS INTEGER NO-UNDO.

  RUN FindFirstChangeNotificationA(pPath, 0, pFlags, OUTPUT hOut ).

  RETURN hOut.   /* Function return value. */

END FUNCTION.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION WatchDelete C-Win 
FUNCTION WatchDelete RETURNS LOGICAL
  ( INPUT pWatched  AS INTEGER ) :
/*------------------------------------------------------------------------------
  Purpose:  
    Notes:  
------------------------------------------------------------------------------*/

  DEFINE VARIABLE hStatus AS INTEGER NO-UNDO.

  TerminateFlag = TRUE.
  RUN FindCloseChangeNotification(pWatched, OUTPUT hStatus).

  RETURN TRUE.   /* Function return value. */

END FUNCTION.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

