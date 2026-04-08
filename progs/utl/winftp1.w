&ANALYZE-SUSPEND _VERSION-NUMBER UIB_v8r12 GUI
&ANALYZE-RESUME
&Scoped-define WINDOW-NAME C-Win
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _DEFINITIONS C-Win 
/*------------------------------------------------------------------------

  File:   winftp.p

  Description: Uses the wininet.dll to access an ftp site.  Detail 
               documentation on funtions can be found at:
               http://msdn.microsoft.com/workshop/networking/wininet/overview/overview.asp
               http://www.oehive.org/node/455
  Input Parameters:
      <none>

  Output Parameters:
      <none>

  Author: Todd G. Nist

  Created: 3/31/99

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

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE Window
&Scoped-define DB-AWARE no

/* Name of designated FRAME-NAME and/or first browse and/or first query */
&Scoped-define FRAME-NAME DEFAULT-FRAME

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS cUrl cUser cPasswd slDirs slFiles btnConnect 
&Scoped-Define DISPLAYED-OBJECTS cUrl cUser cPasswd slDirs slFiles 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME


/* ************************  Function Prototypes ********************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION-FORWARD SetButtons C-Win 
FUNCTION SetButtons RETURNS LOGICAL
  ( /* parameter-definitions */ )  FORWARD.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


/* ***********************  Control Definitions  ********************** */

/* Define the widget handle for the window                              */
DEFINE VAR C-Win AS WIDGET-HANDLE NO-UNDO.

/* Definitions of the field level widgets                               */
DEFINE BUTTON btnConnect 
     LABEL "Connect to FTP" 
     SIZE 22.2 BY 1.14.

DEFINE BUTTON btnDelete 
     LABEL "Delete" 
     SIZE 15 BY 1.14.

DEFINE BUTTON btnGet 
     LABEL "Get" 
     SIZE 15 BY 1.14.

DEFINE BUTTON btnPut 
     LABEL "Put" 
     SIZE 15 BY 1.14.

DEFINE VARIABLE cPasswd AS CHARACTER FORMAT "X(256)":U INITIAL "vero2471" 
     LABEL "Passwd" 
     VIEW-AS FILL-IN 
     SIZE 23 BY 1 NO-UNDO.

DEFINE VARIABLE cUrl AS CHARACTER FORMAT "X(256)":U INITIAL "paulista.movildyna.com.ar" 
     LABEL "URL" 
     VIEW-AS FILL-IN 
     SIZE 69 BY 1 NO-UNDO.

DEFINE VARIABLE cUser AS CHARACTER FORMAT "X(256)":U INITIAL "paulista@movildyna.com.ar" 
     LABEL "Usuario" 
     VIEW-AS FILL-IN 
     SIZE 23 BY 1 NO-UNDO.

DEFINE VARIABLE slDirs AS CHARACTER 
     VIEW-AS SELECTION-LIST SINGLE SCROLLBAR-VERTICAL 
     SIZE 36 BY 8 NO-UNDO.

DEFINE VARIABLE slFiles AS CHARACTER 
     VIEW-AS SELECTION-LIST SINGLE SCROLLBAR-VERTICAL 
     SIZE 36 BY 8 NO-UNDO.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME DEFAULT-FRAME
     cUrl AT ROW 1.05 COL 7.4 COLON-ALIGNED
     cUser AT ROW 2.19 COL 7.4 COLON-ALIGNED WIDGET-ID 2
     cPasswd AT ROW 2.19 COL 41 COLON-ALIGNED WIDGET-ID 4 PASSWORD-FIELD 
     slDirs AT ROW 4.24 COL 4 NO-LABEL
     slFiles AT ROW 4.24 COL 42.4 NO-LABEL
     btnPut AT ROW 13.19 COL 4
     btnGet AT ROW 13.19 COL 19.6
     btnDelete AT ROW 13.19 COL 35.2
     btnConnect AT ROW 13.19 COL 56.2
     "Directories:" VIEW-AS TEXT
          SIZE 12 BY .62 AT ROW 3.57 COL 4
     "Files:" VIEW-AS TEXT
          SIZE 8 BY .62 AT ROW 3.57 COL 42.4
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 80 BY 13.95.


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
         TITLE              = "FTP"
         HEIGHT             = 13.91
         WIDTH              = 80
         MAX-HEIGHT         = 16
         MAX-WIDTH          = 80
         VIRTUAL-HEIGHT     = 16
         VIRTUAL-WIDTH      = 80
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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _INCLUDED-LIB C-Win 
/* ************************* Included-Libraries *********************** */

{ftp.i}

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME




/* ***********  Runtime Attributes and AppBuilder Settings  *********** */

&ANALYZE-SUSPEND _RUN-TIME-ATTRIBUTES
/* SETTINGS FOR WINDOW C-Win
  VISIBLE,,RUN-PERSISTENT                                               */
/* SETTINGS FOR FRAME DEFAULT-FRAME
   FRAME-NAME                                                           */
/* SETTINGS FOR BUTTON btnDelete IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR BUTTON btnGet IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR BUTTON btnPut IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(C-Win)
THEN C-Win:HIDDEN = no.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME C-Win
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON END-ERROR OF C-Win /* FTP */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON WINDOW-CLOSE OF C-Win /* FTP */
DO:
  CloseInternetConnection(hInternetSession).
  /* This event will close the window and terminate the procedure.  */
  APPLY "CLOSE":U TO THIS-PROCEDURE.
  RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btnConnect
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btnConnect C-Win
ON CHOOSE OF btnConnect IN FRAME DEFAULT-FRAME /* Connect to FTP */
DO:
  Session:Set-Wait-State('General':U).
  if cURL:screen-value <> '':U THEN
  do:
    if not ConnectWinInet() then
      message substitute('Unable to establish a connection to &1.',
                         cURL:screen-value).
    else
    do:
      /*-----------------------------------------------------------------------
        Start and FTP Sesion.
      ------------------------------------------------------------------------*/
      if FTPConnect(cURL:Screen-Value,cuser:SCREEN-VALUE,cpasswd:SCREEN-VALUE) then
      do:
        /*----------------------------------------------------------------------- 
         If hFTPSession is a valid handle, then read the contents of the FTP
         site.
        ------------------------------------------------------------------------*/
        FTPListDir(INPUT '.',
                   INPUT '*.*',
                   INPUT hFTPSession,
                   INPUT 'CreateFileList',
                   INPUT THIS-PROCEDURE).
                 
        SetButtons().
      end.
    end.
  end.
  else
    message 'Please enter a URL...' view-as alert-box.

  Session:Set-Wait-State('':U).
    
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btnDelete
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btnDelete C-Win
ON CHOOSE OF btnDelete IN FRAME DEFAULT-FRAME /* Delete */
DO:
  message substitute('Are you sure you want to delete file &1?',
                     trim(entry(1,slFiles:Screen-Value, '(':U) ) )
                     view-as alert-box Question buttons YES-NO
                     update lAnswer as Logical.
  if lAnswer then
    FtpDeleteFile(TRIM(entry(1,slFiles:Screen-Value in frame {&frame-name}, '(' ) )).

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btnGet
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btnGet C-Win
ON CHOOSE OF btnGet IN FRAME DEFAULT-FRAME /* Get */
DO:
  define variable cNewFilename  as  char format "x(32)" no-undo.
  
  /* no file selected for down loading */
  if slFiles:screen-value = '':u or
     slFiles:screen-value = ? then
    return no-apply.
  
  message 'Destination File Spec: ' update cNewFileName.

  FtpGetFile(cNewFileName,trim(entry(1,slFiles:Screen-Value in frame {&frame-name}, '(' ) )).
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btnPut
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btnPut C-Win
ON CHOOSE OF btnPut IN FRAME DEFAULT-FRAME /* Put */
DO:
  define var cLocalFile  as char format "x(60)".
  define var cRemoteFile as char format "x(60)".

  message 'Local Filename: ' update cLocalFile.
  message 'Remote Filename: ' update cRemoteFile.
  
  FtpPutFile(input cLocalFile,
             input cRemoteFile).
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME slDirs
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL slDirs C-Win
ON MOUSE-SELECT-DBLCLICK OF slDirs IN FRAME DEFAULT-FRAME
DO:
  define variable cDir                  as  char     no-undo.
  define variable iRetCode              as  integer  no-undo.
  define variable lpCurrentDirectory    as  memptr   no-undo.
  define variable lpDirectory           as  memptr   no-undo.
  define variable dwCurDir              as  int      no-undo.
  define variable cCurDir               as  char     no-undo.
  DEFINE VAR aa AS INT.

  assign set-size(lpCurrentDirectory) = {&MAX_PATH}
         set-size(lpDirectory)        = {&MAX_PATH}
         dwCurDir                     = {&MAX_PATH}.

  run FtpGetCurrentDirectoryA(input hFTPSession,
                              input get-pointer-value(lpCurrentDirectory),
                              input-output dwCurDir,
                              output iRetCode).

  cCurDir = get-string(lpCurrentDirectory,1).

  if self:screen-value = '..':u then
    assign
    cCurDir = substr(cCurDir,1,length(cCurDir) - ((length(cCurDir) + 1) - r-index(cCurDir, '/')) )
    cCurDir = if cCurDir = '' then '/' else cCurDir
    put-string(lpDirectory,1) = cCurDir.
  else if self:screen-value = '.' then
    put-string(lpDirectory,1) = cCurDir.
  else
    put-string(lpDirectory,1) =get-string(lpCurrentDirectory,1) + '/' + self:screen-value.
                                            
  run FtpSetCurrentDirectoryA(input hFTPSession,
                              input get-pointer-value(lpDirectory),
                              output iRetCode).
    
  if iRetCode = 0 then
  do:
    /* this only works under v9 and above */
    RUN GetLastError(OUTPUT iRetCode).
    IF iRetCode = 12003 THEN /* INTERNET_EXTENDED_ERROR */
      InternetGetLastResponseInfo().
    ELSE
      message 'FtpSetCurrentDirectory failed:' iRetCode view-as alert-box.  
  end.
  
  else 
  do:
    assign
    cDir = self:screen-value
    self:list-items = ''
    self:screen-value = ''
    slFiles:screen-value = ''
    slFiles:list-items = ''.

    FTPListDir(INPUT '.',
               INPUT '*.*',
               INPUT hFTPSession,
               INPUT 'CreateFileList',
               INPUT THIS-PROCEDURE).
  end.

  set-size(lpDirectory) = 0.
  set-size(lpCurrentDirectory) = 0.
  
  SetButtons().

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


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

/* Now enable the interface and wait for the exit condition.            */
/* (NOTE: handle ERROR and END-KEY so cleanup code will always fire.    */
MAIN-BLOCK:
DO ON ERROR   UNDO MAIN-BLOCK, LEAVE MAIN-BLOCK
   ON END-KEY UNDO MAIN-BLOCK, LEAVE MAIN-BLOCK:
  RUN enable_UI.
  IF NOT THIS-PROCEDURE:PERSISTENT THEN
    WAIT-FOR CLOSE OF THIS-PROCEDURE.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


/* **********************  Internal Procedures  *********************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE CreateFileList C-Win 
PROCEDURE CreateFileList :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       iFileSize should be converted to a decimal so that it can
               support very large file sizes.  Currently we are only looking
               at the low value and not taking the high value into
               consideration.       
------------------------------------------------------------------------------*/
define input parameter lpFindData   as  memptr no-undo.
define input parameter pcSearchDir  as  char   no-undo.

define variable iFileSize           as  integer no-undo.
define variable lResult             as  logical no-undo.

do with frame {&frame-name}:
    if get-long(lpFindData, 1) = 16 then
      slDirs:add-last(get-string(lpFindData,45)) .
    else
      assign iFileSize = get-long(lpFindData,33)  /* nFileSizeLow */
             lResult = slFiles:add-last(substitute('&1 (&2 &3)',
                                        get-string(lpFindData,45),
                                        iFileSize,
                                        if iFileSize > 1024 then 'KB':U
                                        else 'Bytes':U)).
  end.
  
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

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
  DISPLAY cUrl cUser cPasswd slDirs slFiles 
      WITH FRAME DEFAULT-FRAME IN WINDOW C-Win.
  ENABLE cUrl cUser cPasswd slDirs slFiles btnConnect 
      WITH FRAME DEFAULT-FRAME IN WINDOW C-Win.
  {&OPEN-BROWSERS-IN-QUERY-DEFAULT-FRAME}
  VIEW C-Win.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

/* ************************  Function Implementations ***************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION SetButtons C-Win 
FUNCTION SetButtons RETURNS LOGICAL
  ( /* parameter-definitions */ ) :
/*------------------------------------------------------------------------------
  Purpose:  
    Notes:  
------------------------------------------------------------------------------*/
  
  do with frame {&frame-name}:
    assign
    btnPut:Sensitive = slDirs:List-Items <> ''
    btnGet:Sensitive = slFiles:List-Items <> ? and slFiles:List-Items <> '':U
    btnDelete:Sensitive = slFiles:List-Items <> ? and slFiles:List-Items <> '':U.
  end.
  
  RETURN FALSE.   /* Function return value. */

END FUNCTION.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

