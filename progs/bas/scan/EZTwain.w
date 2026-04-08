&ANALYZE-SUSPEND _VERSION-NUMBER UIB_v8r12 GUI
&ANALYZE-RESUME
&Scoped-define WINDOW-NAME WINDOW-1
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _DEFINITIONS WINDOW-1 
/*------------------------------------------------------------------------

  File:                         EZTwain.w

  Description:                  EZTwain interface.
                                Updated to 32 bits.

  Input Parameters:
      <none>

  Output Parameters:
      <none>

  Author:                       Marcel FONDACCI
                                m.fondacci@4gl.fr
                                www.4gl.fr

  Created: 15/06/98 - 11:25 am

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

Def var h              as int    NO-UNDO.
Def var h_eztw32       as int    NO-UNDO.          /* Handle DLL eztw32.dll */
Def var h_Window       as int    NO-UNDO.          /* Window Handle WINDOWS       */
Def var h_twain        as int    NO-UNDO.          /* Handle DLL twain.dll */

Def var TWAIN_ANYTYPE  as int    NO-UNDO    initial 0.

Def var x            as int no-undo.
def var y            as int no-undo.

Def var RetCode      as int no-undo.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE WINDOW

/* Name of first Frame and/or Browse and/or first Query                 */
&Scoped-define FRAME-NAME FRAME-A

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS Ombre Ombre2 B-Image RECT-3 HideUi FileName ~
Scan B-UP B-LEFT BB B-Right B-Down 
&Scoped-Define DISPLAYED-OBJECTS HideUi FileName 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME



/* ***********************  Control Definitions  ********************** */

/* Define the widget handle for the window                              */
DEFINE VAR WINDOW-1 AS WIDGET-HANDLE NO-UNDO.

/* Menu Definitions                                                     */
DEFINE SUB-MENU m_Fichier 
       MENU-ITEM m_Slection_Source LABEL "Source selection"
       RULE
       MENU-ITEM m_Quitter      LABEL "Quit"          .

DEFINE MENU MENU-BAR-WINDOW-1 MENUBAR
       SUB-MENU  m_Fichier      LABEL "Scanner"       .


/* Definitions of the field level widgets                               */
DEFINE BUTTON B-Down 
     LABEL "V":L 
     SIZE 5 BY 1.19 TOOLTIP "Scroll down.".

DEFINE BUTTON B-LEFT 
     LABEL "<-":L 
     SIZE 5 BY 1.19 TOOLTIP "Scroll left.".

DEFINE BUTTON B-Right 
     LABEL "->":L 
     SIZE 5 BY 1.19 TOOLTIP "Scroll right.".

DEFINE BUTTON B-UP 
     LABEL "A":L 
     SIZE 5 BY 1.19 TOOLTIP "Scroll Up.".

DEFINE BUTTON BB 
     LABEL "":L 
     SIZE 5 BY 1.19 TOOLTIP "Reset.".

DEFINE BUTTON Scan 
     LABEL "Go! SCAN":L 
     SIZE 29 BY 1.19.

DEFINE VARIABLE FileName AS CHARACTER FORMAT "X(256)":U INITIAL "scan.bmp" 
     LABEL "File" 
     VIEW-AS FILL-IN 
     SIZE 21 BY 1 NO-UNDO.

DEFINE IMAGE B-Image
     SIZE 123.8 BY 21.52 TOOLTIP "Image.".

DEFINE VARIABLE HideUi AS INTEGER INITIAL 1 
     VIEW-AS RADIO-SET VERTICAL
     RADIO-BUTTONS 
          "With scanner dialog", 0,
"Without scanner dialog", 1
     SIZE 29 BY 1.76 NO-UNDO.

DEFINE RECTANGLE Ombre
     EDGE-PIXELS 0  
     SIZE 18 BY 4.24
     BGCOLOR 0 .

DEFINE RECTANGLE Ombre2
     EDGE-PIXELS 1 GRAPHIC-EDGE  
     SIZE 123.8 BY 21.52
     BGCOLOR 7 .

DEFINE RECTANGLE RECT-2
     EDGE-PIXELS 1 GRAPHIC-EDGE  
     SIZE 18 BY 4.24
     BGCOLOR 7 .

DEFINE RECTANGLE RECT-3
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL 
     SIZE 124.6 BY 21.71.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME FRAME-A
     HideUi AT ROW 1.24 COL 2 NO-LABEL
     FileName AT ROW 3 COL 8 COLON-ALIGNED
     Scan AT ROW 4 COL 2
     B-UP AT ROW 19.52 COL 12
     B-LEFT AT ROW 20.76 COL 7
     BB AT ROW 20.76 COL 12
     B-Right AT ROW 20.76 COL 17
     B-Down AT ROW 22 COL 12
     Ombre AT ROW 19.52 COL 6
     RECT-2 AT ROW 19.24 COL 5
     Ombre2 AT ROW 2.52 COL 33.6
     B-Image AT ROW 2.24 COL 32.6
     " DOCUMENT" VIEW-AS TEXT
          SIZE 15.2 BY .86 AT ROW 1.05 COL 31
          FGCOLOR 9 FONT 9
     RECT-3 AT ROW 2.14 COL 32
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 156.8 BY 24.1.


/* *********************** Procedure Settings ************************ */

&ANALYZE-SUSPEND _PROCEDURE-SETTINGS
/* Settings for THIS-PROCEDURE
   Type: WINDOW
 */
&ANALYZE-RESUME _END-PROCEDURE-SETTINGS

/* *************************  Create Window  ************************** */

&ANALYZE-SUSPEND _CREATE-WINDOW
IF SESSION:DISPLAY-TYPE = "GUI":U THEN
  CREATE WINDOW WINDOW-1 ASSIGN
         HIDDEN             = YES
         TITLE              = "Eztwain - PROGRESS interface"
         COLUMN             = 25.4
         ROW                = 7.33
         HEIGHT             = 25
         WIDTH              = 157.2
         MAX-HEIGHT         = 25
         MAX-WIDTH          = 157.2
         VIRTUAL-HEIGHT     = 25
         VIRTUAL-WIDTH      = 157.2
         RESIZE             = yes
         SCROLL-BARS        = yes
         STATUS-AREA        = no
         BGCOLOR            = ?
         FGCOLOR            = ?
         THREE-D            = yes
         MESSAGE-AREA       = no
         SENSITIVE          = yes.
ELSE {&WINDOW-NAME} = CURRENT-WINDOW.

ASSIGN {&WINDOW-NAME}:MENUBAR    = MENU MENU-BAR-WINDOW-1:HANDLE.
/* END WINDOW DEFINITION                                                */
&ANALYZE-RESUME


/* ***************  Runtime Attributes and UIB Settings  ************** */

&ANALYZE-SUSPEND _RUN-TIME-ATTRIBUTES
/* SETTINGS FOR FRAME FRAME-A
                                                                        */
/* SETTINGS FOR RECTANGLE RECT-2 IN FRAME FRAME-A
   NO-ENABLE                                                            */
IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(WINDOW-1)
THEN WINDOW-1:HIDDEN = no.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME

 




/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME B-Down
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL B-Down WINDOW-1
ON CHOOSE OF B-Down IN FRAME FRAME-A /* V */
DO:
          Y = Y + B-Image:Height-pixels / 2.
          IF 
          B-Image:LOAD-IMAGE( Filename, X, Y, B-Image:Width-pixels, B-Image:Height-pixels )
          THEN.    
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME B-LEFT
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL B-LEFT WINDOW-1
ON CHOOSE OF B-LEFT IN FRAME FRAME-A /* <- */
DO:
          X = MAX(X - B-Image:Width-pixels / 2, 0).
          
          B-Image:LOAD-IMAGE( Filename, X, Y, B-Image:Width-pixels, B-Image:Height-pixels ). 
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME B-Right
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL B-Right WINDOW-1
ON CHOOSE OF B-Right IN FRAME FRAME-A /* -> */
DO:
          X = X + B-Image:Width-pixels / 2.
          IF 
          B-Image:LOAD-IMAGE( Filename, X, Y, B-Image:Width-pixels, B-Image:Height-pixels )
          THEN.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME B-UP
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL B-UP WINDOW-1
ON CHOOSE OF B-UP IN FRAME FRAME-A /* A */
DO:
          Y = MAX(Y - B-Image:Height-pixels / 2, 0).
          IF 
          B-Image:LOAD-IMAGE( Filename, X, Y, B-Image:Width-pixels, B-Image:Height-pixels )
          THEN.  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME BB
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL BB WINDOW-1
ON CHOOSE OF BB IN FRAME FRAME-A
DO:
Assign    X = 0 
          Y = 0.

          IF 
          B-Image:LOAD-IMAGE( Filename, X, Y, B-Image:Width-pixels, B-Image:Height-pixels )
          THEN.     
          
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME m_Slection_Source
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL m_Slection_Source WINDOW-1
ON CHOOSE OF MENU-ITEM m_Slection_Source /* Source selection */
DO:
def var h as int no-undo.
  Run TWAIN_SelectImageSource(h_Window, output h).
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME Scan
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Scan WINDOW-1
ON CHOOSE OF Scan IN FRAME FRAME-A /* Go! SCAN */
DO:
Def var DIB            as int    NO-UNDO.    
Def var h              as int    NO-UNDO.
Def var Z              as memptr NO-UNDO.
Def var R              as int    NO-UNDO. 

Def var BitDepth            as int NO-UNDO.
def var CurrentResolution   as int NO-UNDO.
Def var PixelType           as int NO-UNDO.
         
  Assign FileName HideUi.  
  
  Run GetParent( {&WINDOW-NAME}:hwnd, Output h_Window).  
    
  set-size(Z)                       = length(FileName) + 1.  /* Store the filename */
  put-string(Z,1)                   = FileName.
  put-byte(Z, 1 + length(FileName)) = 0.
    
  B-Image:LOAD-IMAGE( ? ).
  
  Run    TWAIN_OpenSourceManager( h_Window, output h).
            
  Run    TWAIN_SetHideUI( HideUi ).            /* Scanner dialog-Box */
  
  Run    TWAIN_AcquireNative(
                              h_Window,
                              TWAIN_ANYTYPE,        /* Color scale */
                              output DIB
                           ).

  If DIB = 0 then do :
                Message "SCANNING ERROR." view-as alert-box ERROR.
                RETURN.   
                end.
          
  Run    TWAIN_WriteNativeToFilename(
                              DIB,
                              Z,
                              output R
                              ).  

  If R <> 0 then
                Message "Return code from 'writeNativeToFile = " R view-as alert-box WARNING.   
  
  set-size(Z) = 0.                           /* Free PROGRESS memory */
  
  Run    TWAIN_FreeNative( DIB ).            /* And free DIB memory */
  
  X = 0.
  Y = 0.
  
  B-Image:LOAD-IMAGE( FileName,0, 0, B-Image:WIDTH-pixels, B-Image:Height-pixels ).
                         
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&UNDEFINE SELF-NAME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _MAIN-BLOCK WINDOW-1 


/* ***************************  Main Block  *************************** */

/* Set CURRENT-WINDOW: this will parent dialog-boxes and frames.        */
ASSIGN CURRENT-WINDOW                = {&WINDOW-NAME} 
       THIS-PROCEDURE:CURRENT-WINDOW = {&WINDOW-NAME}.

/* The CLOSE event can be used from inside or outside the procedure to  */
/* terminate it.                                                        */
ON CLOSE OF THIS-PROCEDURE 
   RUN disable_UI.

/* These events will close the window and terminate the procedure.      */
/* (NOTE: this will override any user-defined triggers previously       */
/*  defined on the window.)                                             */
ON WINDOW-CLOSE OF {&WINDOW-NAME} DO:
  APPLY "CLOSE":U TO THIS-PROCEDURE.
  RETURN NO-APPLY.
END.
ON ENDKEY, END-ERROR OF {&WINDOW-NAME} ANYWHERE DO:
  APPLY "CLOSE":U TO THIS-PROCEDURE.
  RETURN NO-APPLY.
END.

/* Best default for GUI applications is...                              */
PAUSE 0 BEFORE-HIDE.

/* Now enable the interface and wait for the exit condition.            */
/* (NOTE: handle ERROR and END-KEY so cleanup code will always fire.    */
MAIN-BLOCK:
DO ON ERROR   UNDO MAIN-BLOCK, LEAVE MAIN-BLOCK
   ON END-KEY UNDO MAIN-BLOCK, LEAVE MAIN-BLOCK:

  Run    TWAIN_IsAvailable(output h).    
  
  If H <> 1 then do :
          MESSAGE "EZTWAIN is not available !"
                  view-as alert-box ERROR.
          RETURN.
          END.    

   /*    Chargement de la dll eztw32
         ==========================*/
    { loaddll.i    &dll = twain }
    { loaddll.i    &dll = eztw32 }
        
                  
   Run LoadLibraryA( P_twain,  output h_twain).
   Run LoadLibraryA( P_eztw32, output h_eztw32).   
     
   Run TWAIN_EasyVersion(Output h).            /* version number EZTWAIN */   
   {&WINDOW-NAME}:Title = "eztw32.dll version " + string(h / 100, "9.99").
  
  Run    TWAIN_LoadSourceManager(Output h).

  
  Ombre:Move-To-Bottom().
  Ombre2:Move-To-Bottom().
    
  RUN enable_UI.
    
  IF NOT THIS-PROCEDURE:PERSISTENT THEN
    WAIT-FOR CLOSE OF THIS-PROCEDURE.
END.

Run FreeLibrary(h_Twain, output RetCode).
Run FreeLibrary(h_eztw32, output RetCode).

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


/* **********************  Internal Procedures  *********************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE disable_UI WINDOW-1 _DEFAULT-DISABLE
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
  IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(WINDOW-1)
  THEN DELETE WIDGET WINDOW-1.
  IF THIS-PROCEDURE:PERSISTENT THEN DELETE PROCEDURE THIS-PROCEDURE.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE enable_UI WINDOW-1 _DEFAULT-ENABLE
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
  DISPLAY HideUi FileName 
      WITH FRAME FRAME-A IN WINDOW WINDOW-1.
  ENABLE Ombre Ombre2 B-Image RECT-3 HideUi FileName Scan B-UP B-LEFT BB 
         B-Right B-Down 
      WITH FRAME FRAME-A IN WINDOW WINDOW-1.
  {&OPEN-BROWSERS-IN-QUERY-FRAME-A}
  VIEW WINDOW-1.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE EZTWAIN WINDOW-1 
PROCEDURE EZTWAIN :
/* -----------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
-------------------------------------------------------------*/
  
END PROCEDURE.

PROCEDURE TWAIN_AcquireNative external "eztw32.dll" :
Def input parameter    h             as long.
Def input parameter    Image-Type    as unsigned-short.

def return parameter   DIB           as long.
END.

PROCEDURE TWAIN_EasyVersion external "eztw32.dll" :
Def return parameter    Ret        as LONG.
END.

PROCEDURE TWAIN_WriteNativeToFilename external "eztw32.dll" :
Def input parameter    DIB           as long.
Def input parameter    Image-Name    as memptr.

Def return parameter    Ret          as LONG.
END.

PROCEDURE TWAIN_AcquireToFileName external "eztw32.dll" :
Def input parameter    DIB           as long.
Def input parameter    Image-Name    as memptr.

Def return parameter    Ret        as LONG.
END.

PROCEDURE TWAIN_IsAvailable external "eztw32.dll" :
Def return parameter    DllReturn    as long.
END.

PROCEDURE TWAIN_SetHideUI external "eztw32.dll" :
Def input parameter    DLLValue      as LONG.
END.

PROCEDURE TWAIN_GetHideUI external "eztw32.dll" :
Def Return parameter    DLLValue      as LONG.
END.

PROCEDURE TWAIN_LoadSourceManager external "eztw32.dll" :
Def return parameter    DllReturn    as LONG.
END.

PROCEDURE TWAIN_OpenDefaultSource external "eztw32.dll" :
Def return parameter    DllReturn    as LONG.
END.

PROCEDURE TWAIN_CloseSource external "eztw32.dll" :
Def return parameter    DllReturn    as short.
END.

PROCEDURE TWAIN_DisableSource external "eztw32.dll" :
Def return parameter    DllReturn    as LONG.
END.

PROCEDURE TWAIN_State external "eztw32.dll" :
Def return parameter    DllReturn    as LONG.
END.

PROCEDURE TWAIN_EnableSource external "eztw32.dll" :
Def input parameter    h             as long.
Def return parameter    DllReturn    as short.
END.

PROCEDURE TWAIN_OpenSourceManager external "eztw32.dll" :
Def input  parameter    h               as Long.
Def return parameter    DllReturn       as LONG.
END.

PROCEDURE  TWAIN_SelectImageSource external "eztw32.dll" :
Def input parameter     h               as Long.
Def return parameter    DllReturn       as LONG.
END.


PROCEDURE TWAIN_NegotiatePixelTypes external "eztw32.dll" :
Def input parameter    h                as unsigned-short.
Def return parameter   DllReturn        as LONG.
END.

PROCEDURE TWAIN_GetBitDepth external "eztw32.dll" :
Def return parameter   DllReturn    as LONG.
END.
PROCEDURE TWAIN_GetPixelType external "eztw32.dll" :
Def return parameter   DllReturn    as LONG.
END.
PROCEDURE TWAIN_GetCurrentResolution external "eztw32.dll" :
Def return parameter   DllReturn    as short.
END.

PROCEDURE TWAIN_FreeNative external "eztw32.dll" :
Def input parameter    DIB      as long.
end.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE WINDOWS WINDOW-1 
PROCEDURE WINDOWS :
/* -----------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
-------------------------------------------------------------*/
  
END PROCEDURE.

Procedure LoadLibraryA external "KERNEL32" :
def input parameter    Lib-Name    as char.
def return parameter   Ret         as long.
end.

PROCEDURE GetParent external "user32" :
Def input  parameter  h              as long.
Def return parameter  Ret            as long.
end.

PROCEDURE FreeLibrary EXTERNAL "KERNEL32" :
  DEFINE INPUT  PARAMETER h           AS LONG.
  DEFINE RETURN PARAMETER Ret         AS LONG.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


