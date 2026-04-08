&ANALYZE-SUSPEND _VERSION-NUMBER UIB_v8r12 GUI
&ANALYZE-RESUME
&Scoped-define WINDOW-NAME CURRENT-WINDOW
&Scoped-define FRAME-NAME DIALOG-1
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _DEFINITIONS DIALOG-1 
/*------------------------------------------------------------------------

  File: 

  Description: 

  Input Parameters:
      <none>

  Output Parameters:
      <none>

  Author: 

  Created: 04/07/94 -  6:19 pm

------------------------------------------------------------------------*/
/*          This .W file was created with the Progress UIB.             */
/*----------------------------------------------------------------------*/

/* ***************************  Definitions  ************************** */

/* Parameters Definitions ---                                           */

/* Local Variable Definitions ---                                       */

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE DIALOG-BOX

/* Name of first Frame and/or Browse and/or first Query                 */
&Scoped-define FRAME-NAME DIALOG-1

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS R-Library B-Library R-Report RS-Printer ~
F-NumberCopies R-PageBeg R-PageEnd R-OutputFile B-Output R-Include E-Filter ~
R-Memo B-Memo T-Batch T-Status R-Database R-Run F-User F-Password Exit 
&Scoped-Define DISPLAYED-OBJECTS R-Library R-Report RS-Printer ~
F-NumberCopies R-PageBeg R-PageEnd R-OutputFile R-Include E-Filter R-Memo ~
T-Batch T-Status R-Database F-User F-Password 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME



/* ***********************  Control Definitions  ********************** */

/* Define a dialog box                                                  */

/* Definitions of the field level widgets                               */
DEFINE BUTTON B-Library 
     LABEL "Archivos":L 
     SIZE 10 BY 1.

DEFINE BUTTON B-Memo 
     LABEL "Archivos":L 
     SIZE 10 BY 1.

DEFINE BUTTON B-Output 
     LABEL "Archivos":L 
     SIZE 10 BY 1.

DEFINE BUTTON Exit AUTO-GO 
     LABEL "Cancelar":L 
     SIZE 10 BY .91.

DEFINE BUTTON R-Run 
     LABEL "OK":L 
     SIZE 10 BY .91.

DEFINE VARIABLE R-Report AS CHARACTER FORMAT "X(256)":U 
     LABEL "Reporte" 
     VIEW-AS COMBO-BOX INNER-LINES 5
     LIST-ITEMS "","" 
     SIZE 60 BY 1.

DEFINE VARIABLE E-Filter AS CHARACTER 
     VIEW-AS EDITOR NO-WORD-WRAP SCROLLBAR-HORIZONTAL SCROLLBAR-VERTICAL
     SIZE 49.45 BY 2.41.

DEFINE VARIABLE F-NumberCopies AS INTEGER FORMAT "->>,>>9":U INITIAL 0 
     LABEL "Numero de Copias" 
     VIEW-AS FILL-IN 
     SIZE 6 BY 1.

DEFINE VARIABLE F-Password AS CHARACTER FORMAT "X(256)":U 
     LABEL "Password" 
     VIEW-AS FILL-IN 
     SIZE 15 BY 1.

DEFINE VARIABLE F-User AS CHARACTER FORMAT "X(256)":U 
     LABEL "Usuario" 
     VIEW-AS FILL-IN 
     SIZE 15 BY 1.

DEFINE VARIABLE R-Database AS CHARACTER FORMAT "X(256)":U 
     LABEL "Parms. Conexion" 
     VIEW-AS FILL-IN 
     SIZE 41.67 BY 1.

DEFINE VARIABLE R-Library AS CHARACTER FORMAT "X(256)":U 
     LABEL "Libreria" 
     VIEW-AS FILL-IN 
     SIZE 49 BY 1.

DEFINE VARIABLE R-Memo AS CHARACTER FORMAT "X(256)":U 
     LABEL "Archivo Memo" 
     VIEW-AS FILL-IN 
     SIZE 39 BY 1.

DEFINE VARIABLE R-OutputFile AS CHARACTER FORMAT "X(256)":U 
     LABEL "Arhivo" 
     VIEW-AS FILL-IN 
     SIZE 39 BY 1.

DEFINE VARIABLE R-PageBeg AS INTEGER FORMAT "->>,>>9":U INITIAL 0 
     LABEL "De Pagina" 
     VIEW-AS FILL-IN 
     SIZE 6 BY 1.

DEFINE VARIABLE R-PageEnd AS INTEGER FORMAT "->>,>>9":U INITIAL 0 
     LABEL "A Pagina" 
     VIEW-AS FILL-IN 
     SIZE 6 BY 1.

DEFINE VARIABLE R-Include AS INTEGER 
     VIEW-AS RADIO-SET VERTICAL
     RADIO-BUTTONS 
          "Usar Filtro", 1,
"Especificar Filtro", 2,
"Incluir Todos", 3,
"Requerir", 4
     SIZE 23 BY 2.75.

DEFINE VARIABLE RS-Printer AS INTEGER 
     VIEW-AS RADIO-SET VERTICAL
     RADIO-BUTTONS 
          "Pantalla", 1,
"Impresora", 2,
"Archivo", 3
     SIZE 12 BY 2.25.

DEFINE VARIABLE T-Batch AS LOGICAL INITIAL no 
     LABEL "Mostrar Errores en Pantalla":L 
     VIEW-AS TOGGLE-BOX
     SIZE 31 BY .75.

DEFINE VARIABLE T-Status AS LOGICAL INITIAL no 
     LABEL "Mostrar Dialogo de Printer":L 
     VIEW-AS TOGGLE-BOX
     SIZE 28.56 BY .75.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME DIALOG-1
     R-Library AT ROW 1.25 COL 6.33
     B-Library AT ROW 1.25 COL 66
     R-Report AT ROW 2.5 COL 10 COLON-ALIGNED
     RS-Printer AT ROW 4.5 COL 3 NO-LABEL
     F-NumberCopies AT ROW 4.5 COL 18.11
     R-PageBeg AT ROW 4.5 COL 42.89
     R-PageEnd AT ROW 4.5 COL 61.44
     R-OutputFile AT ROW 5.75 COL 17.11
     B-Output AT ROW 5.75 COL 66
     R-Include AT ROW 7.75 COL 2 NO-LABEL
     E-Filter AT ROW 8.5 COL 26 NO-LABEL
     R-Memo AT ROW 11.25 COL 12.23
     B-Memo AT ROW 11.25 COL 66
     T-Batch AT ROW 13.5 COL 2
     T-Status AT ROW 13.5 COL 47.33
     R-Database AT ROW 15.5 COL 5.56
     R-Run AT ROW 15.5 COL 66
     F-User AT ROW 16.75 COL 12.67
     F-Password AT ROW 16.75 COL 40.23
     Exit AT ROW 16.75 COL 66
     " Opciones de Conexion a la Base de Datos:" VIEW-AS TEXT
          SIZE 74 BY .75 AT ROW 14.5 COL 2
          BGCOLOR 1 FGCOLOR 15 
     " Opciones de Monitor de Estado" VIEW-AS TEXT
          SIZE 74 BY .75 AT ROW 12.5 COL 2
          BGCOLOR 1 FGCOLOR 15 
     " Filtro:" VIEW-AS TEXT
          SIZE 8 BY .75 AT ROW 7.75 COL 26
     " Opciones del Reporte:" VIEW-AS TEXT
          SIZE 74 BY .66 AT ROW 7 COL 2
          BGCOLOR 1 FGCOLOR 15 
     " Opciones de Impresion:" VIEW-AS TEXT
          SIZE 74 BY .66 AT ROW 3.75 COL 2
          BGCOLOR 1 FGCOLOR 15 
     SPACE(1.87) SKIP(13.68)
    WITH VIEW-AS DIALOG-BOX 
         SIDE-LABELS THREE-D  SCROLLABLE 
         FONT 4
         TITLE "Interface al Constructor de Reportes":L.


/* *********************** Procedure Settings ************************ */

&ANALYZE-SUSPEND _PROCEDURE-SETTINGS
/* Settings for THIS-PROCEDURE
   Type: DIALOG-BOX
   Other Settings: COMPILE
 */
&ANALYZE-RESUME _END-PROCEDURE-SETTINGS


/* ***************  Runtime Attributes and UIB Settings  ************** */

&ANALYZE-SUSPEND _RUN-TIME-ATTRIBUTES
/* SETTINGS FOR DIALOG-BOX DIALOG-1
   UNDERLINE                                                            */
ASSIGN 
       FRAME DIALOG-1:SCROLLABLE       = FALSE.

ASSIGN 
       B-Library:PRIVATE-DATA IN FRAME DIALOG-1     = 
                "B-Library".

ASSIGN 
       B-Memo:PRIVATE-DATA IN FRAME DIALOG-1     = 
                "B-Memo".

ASSIGN 
       B-Output:PRIVATE-DATA IN FRAME DIALOG-1     = 
                "B-Output".

ASSIGN 
       E-Filter:PRIVATE-DATA IN FRAME DIALOG-1     = 
                "E-Filter".

ASSIGN 
       Exit:PRIVATE-DATA IN FRAME DIALOG-1     = 
                "Exit".

/* SETTINGS FOR FILL-IN F-NumberCopies IN FRAME DIALOG-1
   ALIGN-L                                                              */
ASSIGN 
       F-NumberCopies:PRIVATE-DATA IN FRAME DIALOG-1     = 
                "F-NumberCopies".

/* SETTINGS FOR FILL-IN F-Password IN FRAME DIALOG-1
   ALIGN-L                                                              */
ASSIGN 
       F-Password:PRIVATE-DATA IN FRAME DIALOG-1     = 
                "F-Password".

/* SETTINGS FOR FILL-IN F-User IN FRAME DIALOG-1
   ALIGN-L                                                              */
ASSIGN 
       F-User:PRIVATE-DATA IN FRAME DIALOG-1     = 
                "F-User".

/* SETTINGS FOR FILL-IN R-Database IN FRAME DIALOG-1
   ALIGN-L                                                              */
ASSIGN 
       R-Database:PRIVATE-DATA IN FRAME DIALOG-1     = 
                "R-Database".

/* SETTINGS FOR FILL-IN R-Library IN FRAME DIALOG-1
   ALIGN-L                                                              */
ASSIGN 
       R-Library:PRIVATE-DATA IN FRAME DIALOG-1     = 
                "R-Library".

/* SETTINGS FOR FILL-IN R-Memo IN FRAME DIALOG-1
   ALIGN-L                                                              */
ASSIGN 
       R-Memo:PRIVATE-DATA IN FRAME DIALOG-1     = 
                "R-Memo".

/* SETTINGS FOR FILL-IN R-OutputFile IN FRAME DIALOG-1
   ALIGN-L                                                              */
ASSIGN 
       R-OutputFile:PRIVATE-DATA IN FRAME DIALOG-1     = 
                "R-OutputFile".

/* SETTINGS FOR FILL-IN R-PageBeg IN FRAME DIALOG-1
   ALIGN-L                                                              */
ASSIGN 
       R-PageBeg:PRIVATE-DATA IN FRAME DIALOG-1     = 
                "R-PageBeg".

/* SETTINGS FOR FILL-IN R-PageEnd IN FRAME DIALOG-1
   ALIGN-L                                                              */
ASSIGN 
       R-PageEnd:PRIVATE-DATA IN FRAME DIALOG-1     = 
                "R-PageEnd".

ASSIGN 
       R-Report:PRIVATE-DATA IN FRAME DIALOG-1     = 
                "R-Report".

ASSIGN 
       R-Run:PRIVATE-DATA IN FRAME DIALOG-1     = 
                "R-Run".

ASSIGN 
       T-Batch:PRIVATE-DATA IN FRAME DIALOG-1     = 
                "T-Batch".

ASSIGN 
       T-Status:PRIVATE-DATA IN FRAME DIALOG-1     = 
                "T-Status".

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME

 




/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME DIALOG-1
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL DIALOG-1 DIALOG-1
ON ENTRY OF FRAME DIALOG-1 /* Interface al Constructor de Reportes */
DO:
  assign
    R-Database:screen-value = ""
    R-Library:screen-value  = "reports.prl"
    T-Status:screen-value = "YES"
    R-Report:sensitive     = No
    .
  
  APPLY "VALUE-CHANGED" TO RS-Printer.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME B-Library
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL B-Library DIALOG-1
ON CHOOSE OF B-Library IN FRAME DIALOG-1 /* Archivos */
DO:
def var name    as char    no-undo.
def var bPicked as logical no-undo.

  system-dialog get-file
      name
      filters           "*.prl" "*.prl"  /* Filter                */
      default-extension "*.prl"        /* default-extensions     */
      title             "Librerias de Reportes"
      must-exist
      update bPicked.

  if bPicked then
    R-library:screen-value = name.  
      
      
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME B-Memo
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL B-Memo DIALOG-1
ON CHOOSE OF B-Memo IN FRAME DIALOG-1 /* Archivos */
DO:
  def var name    as char    no-undo.
def var bPicked as logical no-undo.

  system-dialog get-file
      name
      filters           "*.txt" "*.txt"  /* Filter                */
      default-extension "*.txt"        /* default-extensions     */
      title             "Archivos Memo para Reportes"
      must-exist
      update bPicked.

  if bPicked then
    R-Memo:screen-value = name.  
      

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME B-Output
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL B-Output DIALOG-1
ON CHOOSE OF B-Output IN FRAME DIALOG-1 /* Archivos */
DO:
def var name    as char    no-undo.
def var bPicked as logical no-undo.

  system-dialog get-file
      name
      filters           "*.*" "*.*"  /* Filter                */
      default-extension "*.*"        /* default-extensions     */
      title             "Archivo de salida para el Report"
      must-exist
      update bPicked.

  if bPicked then
    R-OutputFile:screen-value = name.  
      

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME R-Include
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL R-Include DIALOG-1
ON VALUE-CHANGED OF R-Include IN FRAME DIALOG-1
DO:
  E-Filter:sensitive = (r-include:screen-value = "2").
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME R-Library
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL R-Library DIALOG-1
ON LEAVE OF R-Library IN FRAME DIALOG-1 /* Libreria */
DO:
  run fill-report-list.
/*
  def var cName  as char    no-undo.
  def var iCount as integer no-undo.
  
  run aderb/_getname.p (R-Library:screen-value, output cName, output iCount).
  
  assign
    R-Report:sensitive    = yes
    R-Report:list-items   = cName
    R-Report:screen-value = ENTRY (1,cName)
  .
*/  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME R-Report
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL R-Report DIALOG-1
ON ENTRY OF R-Report IN FRAME DIALOG-1 /* Reporte */
DO:
  run fill-report-list.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME R-Run
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL R-Run DIALOG-1
ON CHOOSE OF R-Run IN FRAME DIALOG-1 /* OK */
DO:
def var cPrinter   as char    no-undo.
def var iCopies    as integer no-undo.
def var iBegPage   as integer no-undo.
def var iEndPage   as integer no-undo.
def var lDispError as logical no-undo.
def var lStatus    as logical no-undo.
def var cInclude   as char    no-undo.
def var cConnect   as char    no-undo.

assign
  cPrinter   = if (RS-Printer:screen-value = "1") then "D" else "A"
  iCopies    = INTEGER (F-NumberCopies:screen-value)
  iBegPage   = INTEGER (R-PageBeg:screen-value)
  iEndPage   = INTEGER (R-PageEnd:screen-value)
  lDispError = if (T-Batch:screen-value = "yes") then TRUE else FALSE
  lStatus    = if (T-Status:screen-value = "yes") then TRUE else FALSE
  cInclude   = if      (R-Include:screen-value = "1") then "S" 
               else if (R-Include:screen-value = "2") then "O" 
               else if (R-Include:screen-value = "3") then "E" 
               else "?"
  .

  cConnect = "-db " + R-DataBase:screen-value.
  if (F-User:screen-value > "") then
    cConnect = cConnect + " -U " + F-User:screen-value.
    
  if (F-Password:screen-value > "") then
    cConnect = cConnect + " -P " + F-Password:screen-value.
/*    
  message 
  cConnect 
  view-as alert-box information. 
*/
  
  /****
  run aderb/_printrb.p 
  ( 
    R-library:screen-value,    /* RB-REPORT-LIBRARY      The name of the report library */
    R-Report:screen-value,     /* RB-REPORT-NAME         The name of the report  */
    cConnect,                  /* RB-DB-CONNECTION Progress style connection parms "-db sports -N DDE" */
    cInclude,                  /* RB-INCLUDE-RECORDS     S - saved, O - Override, E - Ignore, ? - Prompt  */
    E-Filter:screen-value,     /* RB-FILTER              Filter/Where expression */
    R-Memo:screen-value,       /* RB-MEMO-FILE           Memo file spec. */
    cPrinter,                  /* RB-PRINT-DESTINATION   "D" -Display on Screen, "A" -Ascii File "?" -Prompt " " -Printer */
    "",                        /* RB-PRINTER-NAME          */
    "",                        /* RB-PRINTER-PORT          */
    R-OutputFile:screen-value, /* RB-OUTPUT-FILE         Output file spec. */
    iCopies,                   /* RB-NUMBER-COPIES       Number of copies to print */
    iBegPage,                  /* RB-BEGIN-PAGE          Begining page number */
    iEndPage,                  /* RB-END-PAGE            Ending page number */
    FALSE,                     /* RB-TEST-PATTERN        */
    R-Report:screen-value      /* RB-WINDOW-TITLE        Title for the report */
    lDispError,                /* RB-DISPLAY-ERRORS      Display Error ? TRUE/FALSE */
    lStatus,                   /* RB-DISPLAY-STATUS      Status ? TRUE/FALSE */
    FALSE,                     /* RB-NOWAIT */
    ""                         /* OTHER-PARAMETERS XXX=YYY~nZZZ=WWW */
   ).
             
  run aderb/_printrb.p (
             R-library:screen-value, 
             R-Report:screen-value, 
             cConnect,
             cInclude,
             E-Filter:screen-value,
             R-Memo:screen-value,
             cPrinter,
             "", 
             "", 
             R-OutputFile:screen-value,
             iCopies,
             iBegPage,
             iEndPage,
             FALSE,
             R-Report:screen-value,
             lDispError,
             lStatus,
             FALSE,
             ""
             ).

  ****/

RUN exreport.p (  INPUT  R-library:screen-value,     /* Librería desde la que se ejecuta */
                  INPUT  R-Report:screen-value,      /* Nombre del reporte a ejecutar    */
                  INPUT  "",                         /* Filtro de registros a imponer    */
                  INPUT  "D",                        /* Salida de datos    (ver cPrinter)*/
                  INPUT  "",                         /* Impresora de destino del listado */
                  INPUT  ""                          /* Parametros de Ejecucion          */
               ).
 
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME RS-Printer
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL RS-Printer DIALOG-1
ON VALUE-CHANGED OF RS-Printer IN FRAME DIALOG-1
DO:
  if RS-Printer:screen-value = '1' then  /* output to screen */
    assign
      F-NumberCopies:sensitive = FALSE
      R-PageBeg:sensitive    = TRUE
      R-PageEnd:sensitive    = TRUE
      R-OutputFile:sensitive = FALSE
      B-Output:sensitive     = FALSE
      .
  else if RS-Printer:screen-value = '2' then /* Output to Printer */
    assign
      F-NumberCopies:sensitive = TRUE
      R-PageBeg:sensitive      = TRUE
      R-PageEnd:sensitive      = TRUE
      R-OutputFile:sensitive   = FALSE
      B-Output:sensitive       = FALSE
      .
   else                                      /* Output to File */
   assign
      F-NumberCopies:sensitive = FALSE
      R-PageBeg:sensitive    = FALSE
      R-PageEnd:sensitive    = FALSE   
      R-PageEnd:screen-value = "0"
      R-PageBeg:screen-value = "0"
      R-OutputFile:sensitive = TRUE
      B-Output:sensitive     = TRUE
      .
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&UNDEFINE SELF-NAME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _MAIN-BLOCK DIALOG-1 


/* ***************************  Main Block  *************************** */

/* Restore the current-window if it is an icon.                         */
/* Otherwise the dialog box will be hidden                              */
IF CURRENT-WINDOW:WINDOW-STATE = WINDOW-MINIMIZED 
THEN CURRENT-WINDOW:WINDOW-STATE = WINDOW-NORMAL.

/* Add Trigger to equate WINDOW-CLOSE to END-ERROR                      */
ON WINDOW-CLOSE OF FRAME {&FRAME-NAME} APPLY "END-ERROR":U TO SELF.

/* Now enable the interface and wait for the exit condition.            */
/* (NOTE: handle ERROR and END-KEY so cleanup code will always fire.    */
MAIN-BLOCK:
DO ON ERROR   UNDO MAIN-BLOCK, LEAVE MAIN-BLOCK
   ON END-KEY UNDO MAIN-BLOCK, LEAVE MAIN-BLOCK:
  RUN enable_UI.    
  E-Filter:sensitive IN FRAME {&FRAME-NAME} = (R-Include = 2).
  WAIT-FOR GO OF FRAME {&FRAME-NAME}.
END.
RUN disable_UI.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


/* **********************  Internal Procedures  *********************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE disable_UI DIALOG-1 _DEFAULT-DISABLE
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
  HIDE FRAME DIALOG-1.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE enable_UI DIALOG-1 _DEFAULT-ENABLE
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
  DISPLAY R-Library R-Report RS-Printer F-NumberCopies R-PageBeg R-PageEnd 
          R-OutputFile R-Include E-Filter R-Memo T-Batch T-Status R-Database 
          F-User F-Password 
      WITH FRAME DIALOG-1.
  ENABLE R-Library B-Library R-Report RS-Printer F-NumberCopies R-PageBeg 
         R-PageEnd R-OutputFile B-Output R-Include E-Filter R-Memo B-Memo 
         T-Batch T-Status R-Database R-Run F-User F-Password Exit 
      WITH FRAME DIALOG-1.
  {&OPEN-BROWSERS-IN-QUERY-DIALOG-1}
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE fill-report-list DIALOG-1 
PROCEDURE fill-report-list :
/* -----------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
-------------------------------------------------------------*/
DO WITH FRAME DIALOG-1:

  def var cName  as char    no-undo.
  def var iCount as integer no-undo.
  
  run aderb/_getname.p (R-Library:screen-value in frame dialog-1,
                        output cName, 
                        output iCount).
  
  assign
    R-Report:sensitive    = yes
    R-Report:list-items   = cName
    R-Report:screen-value = ENTRY (1,cName)
  . 
 END. 
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


