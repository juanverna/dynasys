&ANALYZE-SUSPEND _VERSION-NUMBER AB_v10r12 GUI ADM2
&ANALYZE-RESUME
&Scoped-define WINDOW-NAME wWin
{adecomm/appserv.i}
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

{src/adm2/widgetprto.i}

{eztwain.i}
Def var h_Window       as int    NO-UNDO.
Def var TWAIN_ANYTYPE  as int    NO-UNDO    initial 0.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE SmartWindow
&Scoped-define DB-AWARE no

&Scoped-define ADM-CONTAINER WINDOW

&Scoped-define ADM-SUPPORTED-LINKS Data-Target,Data-Source,Page-Target,Update-Source,Update-Target,Filter-target,Filter-Source

/* Name of designated FRAME-NAME and/or first browse and/or first query */
&Scoped-define FRAME-NAME fMain

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS BUTTON-7 BUTTON-8 BUTTON-3 Fresolution ~
BUTTON-2 BUTTON-5 BUTTON-4 BUTTON-6 
&Scoped-Define DISPLAYED-OBJECTS Fresolution 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME


/* ************************  Function Prototypes ********************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION-FORWARD qhandle wWin 
FUNCTION qhandle RETURNS INT
  ( /* parameter-definitions */ )  FORWARD.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


/* ***********************  Control Definitions  ********************** */

/* Define the widget handle for the window                              */
DEFINE VAR wWin AS WIDGET-HANDLE NO-UNDO.

/* Definitions of the field level widgets                               */
DEFINE BUTTON BUTTON-2 
     LABEL "Soft Original" 
     SIZE 32 BY 3.33.

DEFINE BUTTON BUTTON-3 
     LABEL "Seleccionar fuente" 
     SIZE 31 BY 3.33.

DEFINE BUTTON BUTTON-4 
     LABEL "barcode" 
     SIZE 30 BY 2.62.

DEFINE BUTTON BUTTON-5 
     LABEL "scan region" 
     SIZE 32 BY 3.33.

DEFINE BUTTON BUTTON-6 
     LABEL "Button 6" 
     SIZE 15 BY 1.14.

DEFINE BUTTON BUTTON-7 
     LABEL "SourceList" 
     SIZE 15 BY 1.14.

DEFINE BUTTON BUTTON-8 
     LABEL "PDF" 
     SIZE 15 BY 1.14.

DEFINE VARIABLE Fresolution AS DECIMAL FORMAT ">>>9.9":U INITIAL 150.0 
     LABEL "Resol" 
     VIEW-AS FILL-IN 
     SIZE 14 BY 1 NO-UNDO.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME fMain
     BUTTON-7 AT ROW 1.48 COL 5 WIDGET-ID 14
     BUTTON-8 AT ROW 1.71 COL 55 WIDGET-ID 16
     BUTTON-3 AT ROW 5.05 COL 12 WIDGET-ID 4
     Fresolution AT ROW 7.19 COL 53 COLON-ALIGNED WIDGET-ID 10
     BUTTON-2 AT ROW 8.86 COL 10 WIDGET-ID 2
     BUTTON-5 AT ROW 8.86 COL 45 WIDGET-ID 8
     BUTTON-4 AT ROW 13.62 COL 12 WIDGET-ID 6
     BUTTON-6 AT ROW 14.1 COL 59 WIDGET-ID 12
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 79.8 BY 17 WIDGET-ID 100.


/* *********************** Procedure Settings ************************ */

&ANALYZE-SUSPEND _PROCEDURE-SETTINGS
/* Settings for THIS-PROCEDURE
   Type: SmartWindow
   Allow: Basic,Browse,DB-Fields,Query,Smart,Window
   Container Links: Data-Target,Data-Source,Page-Target,Update-Source,Update-Target,Filter-target,Filter-Source
   Other Settings: APPSERVER
 */
&ANALYZE-RESUME _END-PROCEDURE-SETTINGS

/* *************************  Create Window  ************************** */

&ANALYZE-SUSPEND _CREATE-WINDOW
IF SESSION:DISPLAY-TYPE = "GUI":U THEN
  CREATE WINDOW wWin ASSIGN
         HIDDEN             = YES
         TITLE              = "<insert SmartWindow title>"
         HEIGHT             = 17
         WIDTH              = 80
         MAX-HEIGHT         = 33.05
         MAX-WIDTH          = 256
         VIRTUAL-HEIGHT     = 33.05
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

{src/adm2/containr.i}

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME




/* ***********  Runtime Attributes and AppBuilder Settings  *********** */

&ANALYZE-SUSPEND _RUN-TIME-ATTRIBUTES
/* SETTINGS FOR WINDOW wWin
  VISIBLE,,RUN-PERSISTENT                                               */
/* SETTINGS FOR FRAME fMain
   FRAME-NAME                                                           */
IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(wWin)
THEN wWin:HIDDEN = yes.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME wWin
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL wWin wWin
ON END-ERROR OF wWin /* <insert SmartWindow title> */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL wWin wWin
ON WINDOW-CLOSE OF wWin /* <insert SmartWindow title> */
DO:
  /* This ADM code must be left here in order for the SmartWindow
     and its descendents to terminate properly on exit. */
  APPLY "CLOSE":U TO THIS-PROCEDURE.
  RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME BUTTON-2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL BUTTON-2 wWin
ON CHOOSE OF BUTTON-2 IN FRAME fMain /* Soft Original */
DO:
Def var DIB            as int    NO-UNDO.    
Def var h              as int    NO-UNDO.
Def var Z              as memptr NO-UNDO.
Def var R              as int    NO-UNDO. 
Def var BitDepth            as int NO-UNDO.
def var CurrentResolution   as int NO-UNDO.
Def var PixelType           as int NO-UNDO.
def var arch as char no-undo initial "prueba.bmp".
define var HideUi as int initial 1 no-undo.
define var retval as decimal no-undo.
  set-size(Z)                       = length(arch) + 1.  /* Store the filename */
  put-string(Z,1)                   = arch.
  put-byte(Z, 1 + length(arch)) = 0.
       
  Run GetParent( {&WINDOW-NAME}:hwnd, Output h_Window).  
  Run    TWAIN_SetHideUI( HideUi ).            /* Scanner dialog-Box */

  
  run TWAIN_GetYResolution (output retval ).
  message retval.


  run TWAIN_AcquireNative (h_Window,TWAIN_ANYTYPE,output DIB).
  IF DIB = 0 then do:
      message "Fallo scaneada" view-as alert-box error.
      return no-apply.
  END.

    Run    TWAIN_WriteNativeToFilename(
                                DIB,
                                arch,
                                output R
                                ).  

    If R <> 0 then
                  Message "Return code from 'writeNativeToFile = " R view-as alert-box WARNING.   

    set-size(Z) = 0.                           /* Free PROGRESS memory */

    Run    TWAIN_FreeNative( DIB ).            /* And free DIB memory */

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME BUTTON-3
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL BUTTON-3 wWin
ON CHOOSE OF BUTTON-3 IN FRAME fMain /* Seleccionar fuente */
DO:
def var h as int no-undo.
  Run TWAIN_SelectImageSource(h_Window, output h).
  IF h <> 1 THEN do:
      message "No se ha elegido un scanner correctamente" view-as alert-box error.
  END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME BUTTON-4
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL BUTTON-4 wWin
ON CHOOSE OF BUTTON-4 IN FRAME fMain /* barcode */
DO:
    define var ireturn as int.
    define var c as char initial "prueba.bmp" no-undo.
    define var sResult as char no-undo.
    define var err as int no-undo.
    run ReadCode39(c, output sResult, output err ).
    If Err <> 1 Then do:
        message "ERROR " Err.
        return no-apply.
    END.
    message sResult.
        
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME BUTTON-5
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL BUTTON-5 wWin
ON CHOOSE OF BUTTON-5 IN FRAME fMain /* scan region */
DO:




Def var DIB            as int    NO-UNDO.    
Def var h              as int    NO-UNDO.
Def var Z              as memptr NO-UNDO.
Def var R              as int    NO-UNDO. 
Def var BitDepth            as int NO-UNDO.

Def var PixelType           as int NO-UNDO.
define var CurrentResolution as decimal initial 80.
DEF VAR scan AS CHAR INITIAL "RemoteScan (TM)".
def var arch as char no-undo initial "prueba".
define var retval as decimal no-undo.
assign fresolution.
currentResolution = fresolution.
arch = arch + string(CurrentResolution) + ".bmp".
  set-size(Z)                       = length(arch) + 1.  /* Store the filename */
  put-string(Z,1)                   = arch.
  put-byte(Z, 1 + length(arch)) = 0.
       
  Run GetParent( {&WINDOW-NAME}:hwnd, Output h_Window).  
  
  run TWAIN_IsAvailable(output r ).
  IF r <> 1 THEN do:
      message "TWAIN no disponible".
      return no-apply.
  END.
  RUN TWAIN_OpenSource(scan,OUTPUT r).
  IF r <> 1 THEN DO:
        MESSAGE "No se ha podido abrir el scanner " VIEW-AS ALERT-BOX ERROR.
  END.

 /*Run TWAIN_OpenDefaultSource(output R). */
  run TWAIN_SetRegion(2.0, 3.0, 5.0, 7.0).
  Run TWAIN_SetHideUI(1).
  
 /* run TWAIN_SetCurrentPixelType( 1, output R ).*/
  run TWAIN_SetCurrentResolution( CurrentResolution, output R). 
  run TWAIN_SetCurrentUnits(1,output R).

   /*run TWAIN_SetRegionCurrentUnits(1,output R).*/
  run TWAIN_AcquireNative (h_Window,1,output DIB).
  IF DIB = 0 then do:
      message "Fallo scaneada" view-as alert-box error.
      return no-apply.
  END.

    Run    TWAIN_WriteNativeToFilename(
                                DIB,
                                arch,
                                output R
                                ).  

    If R <> 0 then
                  Message "Return code from 'writeNativeToFile = " R view-as alert-box WARNING.   

    set-size(Z) = 0.                           /* Free PROGRESS memory */

    Run    TWAIN_FreeNative( DIB ).            /* And free DIB memory */

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME BUTTON-6
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL BUTTON-6 wWin
ON CHOOSE OF BUTTON-6 IN FRAME fMain /* Button 6 */
DO:
assign fresolution.
    DEFINE VARIABLE LRet AS INT NO-UNDO.
    Run GetParent( {&WINDOW-NAME}:hwnd, Output h_Window).  
  RUN TWAIN_SetHideUI(1).
  RUN TWAIN_SetFileAppendFlag(0).
/*  RUN TWAIN_OpenDefaultSource(OUTPUT LRet).*/
  RUN TWAIN_OpenSource("WIA-HP Scanjet G2410", OUTPUT LRet).

  IF LRet<>0 THEN DO:
    RUN TWAIN_SetPixelType(0, OUTPUT lRet).
    RUN TWAIN_SetBitDepth(1,OUTPUT lRet).
    run TWAIN_SetCurrentResolution( fresolution, output lRet). 
    RUN TWAIN_SetXferCount(1,OUTPUT lRet).
   /* RUN TWAIN_SetRegion(2.0, 3.0, 5.0, 5.0).*/
    /* If you can't get a Window handle, use 0: */
    RUN TWAIN_AcquireToFilename(h_Window, "image" + string(fresolution,">>>.9") + ".pdf",OUTPUT lRet).
  END.
  RUN TWAIN_LastErrorCode(OUTPUT LRet).
  IF LRet<>0 THEN DO:
    RUN TWAIN_ReportLastError("Unable to scan.").
  END.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME BUTTON-7
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL BUTTON-7 wWin
ON CHOOSE OF BUTTON-7 IN FRAME fMain /* SourceList */
DO:
  DEFINE VARIABLE Name AS CHARACTER NO-UNDO.
  DEFINE VARIABLE LRet AS INT NO-UNDO.
  DEFINE VARIABLE mpName AS MEMPTR NO-UNDO.
  SET-SIZE(mpName) = 78.
  RUN TWAIN_GetSourceList(OUTPUT LRet).
  IF LRet<>0 THEN DO:
    REPEAT:
      RUN TWAIN_GetNextSourceName(INPUT-OUTPUT mpName, OUTPUT LRet).
      IF LRet=0 THEN LEAVE.
      Name = GET-STRING(mpName, 1).
      MESSAGE Name VIEW-AS ALERT-BOX INFORMATION.
    END.
  END.
  ELSE DO:
    MESSAGE "No TWAIN devices found." VIEW-AS ALERT-BOX INFORMATION.
  END.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME BUTTON-8
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL BUTTON-8 wWin
ON CHOOSE OF BUTTON-8 IN FRAME fMain /* PDF */
DO:
    DEFINE VARIABLE LRet AS INT NO-UNDO.
DEFINE VARIABLE resolucion AS DECIMAL INITIAL 100 NO-UNDO.
  RUN TWAIN_SetHideUI(1).
  RUN TWAIN_OpenSource("RemoteScan (TM)", OUTPUT LRet).
  IF LRet<>0 THEN DO:
    RUN TWAIN_SetPixelType(0,OUTPUT Lret).
    RUN TWAIN_SetBitDepth(1,OUTPUT Lret).
    RUN TWAIN_SetResolution(resolucion,OUTPUT Lret).
    RUN TWAIN_SetXferCount(1,OUTPUT Lret).
    RUN TWAIN_SetAutoContrast(1).
    RUN TWAIN_SetAutoScan(0,OUTPUT Lret).
    RUN TWAIN_SetRegion(2.0, 3.0, 5.0, 5.0).
    /* If you can't get a Window handle, use 0: */
    RUN TWAIN_AcquireToFilename(qHandle(), "c:\image.pdf",OUTPUT Lret).
  END.
  RUN TWAIN_LastErrorCode(OUTPUT LRet).
  IF LRet<>0 THEN DO:
    MESSAGE "No se logro scanear".
  END.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&UNDEFINE SELF-NAME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _MAIN-BLOCK wWin 


/* ***************************  Main Block  *************************** */

/* Include custom  Main Block code for SmartWindows. */
{src/adm2/windowmn.i}

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
  DISPLAY Fresolution 
      WITH FRAME fMain IN WINDOW wWin.
  ENABLE BUTTON-7 BUTTON-8 BUTTON-3 Fresolution BUTTON-2 BUTTON-5 BUTTON-4 
         BUTTON-6 
      WITH FRAME fMain IN WINDOW wWin.
  {&OPEN-BROWSERS-IN-QUERY-fMain}
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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE EX_ReadCode39 wWin 
PROCEDURE EX_ReadCode39 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

END PROCEDURE.

PROCEDURE ReadCode39 EXTERNAL "qsBar39.dll":
    define input parameter sFileName as char.
    define output parameter sResult as char.
    DEFINE RETURN PARAMETER result AS LONG.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE initializeObject wWin 
PROCEDURE initializeObject :
/*------------------------------------------------------------------------------
  Purpose:     Super Override
  Parameters:  
  Notes:       
------------------------------------------------------------------------------*/
define var retval as int.
  /* Code placed here will execute PRIOR to standard behavior. */

  RUN SUPER.

  /* Code placed here will execute AFTER standard behavior.    */
 
      run TWAIN_IsAvailable( output retval).
IF retval <> 1 THEN do:
    message "TWAIN no esta instalado correctamente en el sistema" view-as alert-box error.
    RETURN ERROR.
END.


END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE WINDOWS wWin 
PROCEDURE WINDOWS :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

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

/* ************************  Function Implementations ***************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION qhandle wWin 
FUNCTION qhandle RETURNS INT
  ( /* parameter-definitions */ ) :
/*------------------------------------------------------------------------------
  Purpose:  
    Notes:  
------------------------------------------------------------------------------*/
  Def var h_Window       as int    NO-UNDO. 
  Run GetParent( {&WINDOW-NAME}:hwnd, Output h_Window). 
  RETURN h_Window.   /* Function return value. */

END FUNCTION.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

