&ANALYZE-SUSPEND _VERSION-NUMBER UIB_v9r12 GUI
&ANALYZE-RESUME
/* Connected Databases 
          sic              PROGRESS
*/
&Scoped-define WINDOW-NAME CURRENT-WINDOW
&Scoped-define FRAME-NAME F-Main
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _DEFINITIONS F-Main 
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
/*          This .W file was created with the Progress AppBuilder.       */
/*----------------------------------------------------------------------*/

/* ***************************  Definitions  ************************** */

/* Parameters Definitions ---                                           */

/* Local Variable Definitions ---                                       */

DEFINE TEMP-TABLE T-Connect NO-UNDO LIKE _Connect.
DEFINE VARIABLE v-usuarios  AS CHARACTER.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE Dialog-Box
&Scoped-define DB-AWARE no

/* Name of designated FRAME-NAME and/or first browse and/or first query */
&Scoped-define FRAME-NAME F-Main
&Scoped-define BROWSE-NAME BROWSE-1

/* Internal Tables (found by Frame, Query & Browse Queries)             */
&Scoped-define INTERNAL-TABLES T-Connect _User

/* Definitions for BROWSE BROWSE-1                                      */
&Scoped-define FIELDS-IN-QUERY-BROWSE-1 T-Connect._Connect-Name T-Connect._Connect-Device T-Connect._Connect-Type T-Connect._Connect-Time _User._User-name /* T-Connect._Connect-Id T-Connect._Connect-Usr T-Connect._Connect-Pid T-Connect._Connect-Server T-Connect._Connect-Wait1 T-Connect._Connect-Wait T-Connect._Connect-TransId T-Connect._Connect-SemNum T-Connect._Connect-semid T-Connect._Connect-Disconnect T-Connect._Connect-Resync T-Connect._Connect-Interrupt T-Connect._Connect-2phase T-Connect._Connect-Batch T-Connect._Connect-Misc */   
&Scoped-define ENABLED-FIELDS-IN-QUERY-BROWSE-1   
&Scoped-define SELF-NAME BROWSE-1
&Scoped-define OPEN-QUERY-BROWSE-1 IF v-usuarios = ""     THEN OPEN QUERY {&SELF-NAME} FOR EACH T-Connect, ~
       FIRST _User OUTER-JOIN WHERE _User._Userid = T-Connect._connect-name.     ELSE OPEN QUERY {&SELF-NAME} FOR EACH T-Connect WHERE CAN-DO(v-usuarios, ~
      T-Connect._Connect-Type), ~
               FIRST _User OUTER-JOIN WHERE _User._Userid = T-Connect._connect-name.
&Scoped-define TABLES-IN-QUERY-BROWSE-1 T-Connect _User
&Scoped-define FIRST-TABLE-IN-QUERY-BROWSE-1 T-Connect
&Scoped-define SECOND-TABLE-IN-QUERY-BROWSE-1 _User


/* Definitions for DIALOG-BOX F-Main                                    */
&Scoped-define OPEN-BROWSERS-IN-QUERY-F-Main ~
    ~{&OPEN-QUERY-BROWSE-1}

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS RECT-1 RECT-2 BROWSE-1 BUTTON-1 x-usuarios ~
v-ultimo_refresh v-Connect-Name v-Connect-device v-Connect-Time ~
v-Connect-Type v-Connect-id v-Connect-Usr v-Connect-Pid v-Connect-Server ~
v-Connect-Batch v-Connect-Semnum v-Connect-Semid v-Connect-Wait1 ~
v-Connect-Wait v-Connect-Transid v-Connect-Disconnect v-Connect-2phase ~
v-Connect-Resync v-Connect-Interrupt v-Connect-Misc 
&Scoped-Define DISPLAYED-OBJECTS x-usuarios v-ultimo_refresh v-Connect-Name ~
v-Connect-device v-Connect-Time v-Connect-Type v-Connect-id v-Connect-Usr ~
v-Connect-Pid v-Connect-Server v-Connect-Batch v-Connect-Semnum ~
v-Connect-Semid v-Connect-Wait1 v-Connect-Wait v-Connect-Transid ~
v-Connect-Disconnect v-Connect-2phase v-Connect-Resync v-Connect-Interrupt ~
v-Connect-Misc 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME



/* ***********************  Control Definitions  ********************** */

/* Define a dialog box                                                  */

/* Definitions of the field level widgets                               */
DEFINE BUTTON BUTTON-1 
     LABEL "Refrescar" 
     SIZE 14 BY 1.14.

DEFINE VARIABLE v-Connect-2phase AS INTEGER FORMAT "->,>>>,>>9":U INITIAL 0 
     LABEL "2Phase" 
     VIEW-AS FILL-IN 
     SIZE 14 BY 1 NO-UNDO.

DEFINE VARIABLE v-Connect-Batch AS CHARACTER FORMAT "X(256)":U 
     LABEL "Batch" 
     VIEW-AS FILL-IN 
     SIZE 14 BY 1 NO-UNDO.

DEFINE VARIABLE v-Connect-device AS CHARACTER FORMAT "X(256)":U 
     LABEL "Terminal" 
     VIEW-AS FILL-IN 
     SIZE 14 BY 1 NO-UNDO.

DEFINE VARIABLE v-Connect-Disconnect AS INTEGER FORMAT "->,>>>,>>9":U INITIAL 0 
     LABEL "Disconnect" 
     VIEW-AS FILL-IN 
     SIZE 14 BY 1 NO-UNDO.

DEFINE VARIABLE v-Connect-id AS INTEGER FORMAT "->>>>>>9":U INITIAL 0 
     LABEL "Id. Conexión" 
     VIEW-AS FILL-IN 
     SIZE 14 BY 1 NO-UNDO.

DEFINE VARIABLE v-Connect-Interrupt AS INTEGER FORMAT "->,>>>,>>9":U INITIAL 0 
     LABEL "Interrupt" 
     VIEW-AS FILL-IN 
     SIZE 14 BY 1 NO-UNDO.

DEFINE VARIABLE v-Connect-Misc AS INTEGER FORMAT "->,>>>,>>9":U INITIAL 0 
     LABEL "Misc" 
     VIEW-AS FILL-IN 
     SIZE 14 BY 1 NO-UNDO.

DEFINE VARIABLE v-Connect-Name AS CHARACTER FORMAT "X(256)":U 
     LABEL "Usuario" 
     VIEW-AS FILL-IN 
     SIZE 14 BY 1 NO-UNDO.

DEFINE VARIABLE v-Connect-Pid AS INTEGER FORMAT "->,>>>,>>9":U INITIAL 0 
     LABEL "Id.Proceso" 
     VIEW-AS FILL-IN 
     SIZE 14 BY 1 NO-UNDO.

DEFINE VARIABLE v-Connect-Resync AS INTEGER FORMAT "->,>>>,>>9":U INITIAL 0 
     LABEL "Resync" 
     VIEW-AS FILL-IN 
     SIZE 14 BY 1 NO-UNDO.

DEFINE VARIABLE v-Connect-Semid AS INTEGER FORMAT "->,>>>,>>9":U INITIAL 0 
     LABEL "Semid" 
     VIEW-AS FILL-IN 
     SIZE 14 BY 1 NO-UNDO.

DEFINE VARIABLE v-Connect-Semnum AS INTEGER FORMAT "->,>>>,>>9":U INITIAL 0 
     LABEL "SemNum" 
     VIEW-AS FILL-IN 
     SIZE 14 BY 1 NO-UNDO.

DEFINE VARIABLE v-Connect-Server AS INTEGER FORMAT "->,>>>,>>9":U INITIAL 0 
     LABEL "Server.Id." 
     VIEW-AS FILL-IN 
     SIZE 14 BY 1 NO-UNDO.

DEFINE VARIABLE v-Connect-Time AS CHARACTER FORMAT "X(256)":U 
     LABEL "Hora Conexión" 
     VIEW-AS FILL-IN 
     SIZE 42 BY 1 NO-UNDO.

DEFINE VARIABLE v-Connect-Transid AS INTEGER FORMAT "->,>>>,>>9":U INITIAL 0 
     LABEL "Trans.Id." 
     VIEW-AS FILL-IN 
     SIZE 14 BY 1 NO-UNDO.

DEFINE VARIABLE v-Connect-Type AS CHARACTER FORMAT "X(256)":U 
     LABEL "Conexión" 
     VIEW-AS FILL-IN 
     SIZE 14 BY 1 NO-UNDO.

DEFINE VARIABLE v-Connect-Usr AS INTEGER FORMAT ">>>>>9":U INITIAL 0 
     LABEL "Nro.Usuario" 
     VIEW-AS FILL-IN 
     SIZE 14 BY 1 NO-UNDO.

DEFINE VARIABLE v-Connect-Wait AS CHARACTER FORMAT "X(256)":U 
     LABEL "Wait" 
     VIEW-AS FILL-IN 
     SIZE 14 BY 1 NO-UNDO.

DEFINE VARIABLE v-Connect-Wait1 AS INTEGER FORMAT "->,>>>,>>9":U INITIAL 0 
     LABEL "Wait1" 
     VIEW-AS FILL-IN 
     SIZE 14 BY 1 NO-UNDO.

DEFINE VARIABLE v-ultimo_refresh AS CHARACTER FORMAT "X(256)":U 
     LABEL "Ultimo Refresh" 
     VIEW-AS FILL-IN 
     SIZE 14 BY 1 NO-UNDO.

DEFINE VARIABLE x-usuarios AS CHARACTER 
     VIEW-AS RADIO-SET VERTICAL
     RADIO-BUTTONS 
          "Todos los Usuarios", "T",
"Sólo Usuarios Físicos", "F",
"Todas las conexiones", "X"
     SIZE 26 BY 2.62 NO-UNDO.

DEFINE RECTANGLE RECT-1
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 63 BY 12.62.

DEFINE RECTANGLE RECT-2
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 63 BY 3.1.

/* Query definitions                                                    */
&ANALYZE-SUSPEND
DEFINE QUERY BROWSE-1 FOR 
      T-Connect, 
      _User SCROLLING.
&ANALYZE-RESUME

/* Browse definitions                                                   */
DEFINE BROWSE BROWSE-1
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS BROWSE-1 F-Main _FREEFORM
  QUERY BROWSE-1 DISPLAY
      T-Connect._Connect-Name         FORMAT "x(12)"  COLUMN-LABEL "Nombre!Login"
      T-Connect._Connect-Device       FORMAT "x(12)" COLUMN-LABEL "Dispositivo!Acceso"
      T-Connect._Connect-Type         FORMAT "x(8)"  COLUMN-LABEL "Tipo de!Conexión"  
      T-Connect._Connect-Time         FORMAT "x(22)" COLUMN-LABEL "Fecha y Hora!de Conexión"  
      _User._User-name                FORMAT "x(24)" COLUMN-LABEL "Nombre del!Usuario"  
/*
      T-Connect._Connect-Id           FORMAT "->>>>>>>>>9"
      T-Connect._Connect-Usr          FORMAT "->>>>>>>>>9"
    
      T-Connect._Connect-Pid          FORMAT "->>>>>>>>>9"
      T-Connect._Connect-Server       FORMAT "->>>>>>>>>9"
      T-Connect._Connect-Wait1        FORMAT "->>>>>>>>>9"
      T-Connect._Connect-Wait         FORMAT "x(4)"
      T-Connect._Connect-TransId      FORMAT "->>>>>>>>>9"
      T-Connect._Connect-SemNum       FORMAT "->>>>>>>>>9"
      T-Connect._Connect-semid        FORMAT "->>>>>>>>>9"
      T-Connect._Connect-Disconnect   FORMAT "->>>>>>>>>9"
      T-Connect._Connect-Resync       FORMAT "->>>>>>>>>9"
      T-Connect._Connect-Interrupt    FORMAT "->>>>>>>>>9"
      T-Connect._Connect-2phase       FORMAT "->>>>>>>>>9"
      T-Connect._Connect-Batch        FORMAT "x(3)"
      T-Connect._Connect-Misc         FORMAT "->>>>>>>>>9"
*/
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ROW-MARKERS SEPARATORS SIZE 87 BY 15.71 FIT-LAST-COLUMN.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME F-Main
     BROWSE-1 AT ROW 1.24 COL 2
     BUTTON-1 AT ROW 1.48 COL 107
     x-usuarios AT ROW 1.48 COL 125 NO-LABEL
     v-ultimo_refresh AT ROW 2.91 COL 105 COLON-ALIGNED
     v-Connect-Name AT ROW 4.81 COL 105 COLON-ALIGNED
     v-Connect-device AT ROW 4.81 COL 133 COLON-ALIGNED
     v-Connect-Time AT ROW 6 COL 105 COLON-ALIGNED
     v-Connect-Type AT ROW 7.19 COL 105 COLON-ALIGNED
     v-Connect-id AT ROW 7.19 COL 133 COLON-ALIGNED
     v-Connect-Usr AT ROW 8.38 COL 105 COLON-ALIGNED
     v-Connect-Pid AT ROW 8.38 COL 133 COLON-ALIGNED
     v-Connect-Server AT ROW 9.57 COL 105 COLON-ALIGNED
     v-Connect-Batch AT ROW 9.57 COL 133 COLON-ALIGNED
     v-Connect-Semnum AT ROW 10.76 COL 105 COLON-ALIGNED
     v-Connect-Semid AT ROW 10.76 COL 133 COLON-ALIGNED
     v-Connect-Wait1 AT ROW 11.95 COL 105 COLON-ALIGNED
     v-Connect-Wait AT ROW 11.95 COL 133 COLON-ALIGNED
     v-Connect-Transid AT ROW 13.14 COL 105 COLON-ALIGNED
     v-Connect-Disconnect AT ROW 13.14 COL 133 COLON-ALIGNED
     v-Connect-2phase AT ROW 14.33 COL 105 COLON-ALIGNED
     v-Connect-Resync AT ROW 14.33 COL 133 COLON-ALIGNED
     v-Connect-Interrupt AT ROW 15.52 COL 105 COLON-ALIGNED
     v-Connect-Misc AT ROW 15.52 COL 133 COLON-ALIGNED
     RECT-1 AT ROW 4.33 COL 90
     RECT-2 AT ROW 1.24 COL 90
     SPACE(0.59) SKIP(13.03)
    WITH VIEW-AS DIALOG-BOX KEEP-TAB-ORDER 
         SIDE-LABELS NO-UNDERLINE THREE-D  SCROLLABLE 
         TITLE "Estado actual de conexión a la base Dynasys".


/* *********************** Procedure Settings ************************ */

&ANALYZE-SUSPEND _PROCEDURE-SETTINGS
/* Settings for THIS-PROCEDURE
   Type: Dialog-Box
   Allow: Basic,Browse,DB-Fields,Query
   Other Settings: COMPILE
 */
&ANALYZE-RESUME _END-PROCEDURE-SETTINGS



/* ***********  Runtime Attributes and AppBuilder Settings  *********** */

&ANALYZE-SUSPEND _RUN-TIME-ATTRIBUTES
/* SETTINGS FOR DIALOG-BOX F-Main
   FRAME-NAME                                                           */
/* BROWSE-TAB BROWSE-1 RECT-2 F-Main */
ASSIGN 
       FRAME F-Main:SCROLLABLE       = FALSE
       FRAME F-Main:HIDDEN           = TRUE.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME


/* Setting information for Queries and Browse Widgets fields            */

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE BROWSE-1
/* Query rebuild information for BROWSE BROWSE-1
     _START_FREEFORM
IF v-usuarios = ""
    THEN OPEN QUERY {&SELF-NAME} FOR EACH T-Connect, FIRST _User OUTER-JOIN WHERE _User._Userid = T-Connect._connect-name.
    ELSE OPEN QUERY {&SELF-NAME} FOR EACH T-Connect WHERE CAN-DO(v-usuarios,T-Connect._Connect-Type),
        FIRST _User OUTER-JOIN WHERE _User._Userid = T-Connect._connect-name.
     _END_FREEFORM
     _Query            is OPENED
*/  /* BROWSE BROWSE-1 */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME F-Main
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL F-Main F-Main
ON WINDOW-CLOSE OF FRAME F-Main /* Estado actual de conexión a la base Dynasys */
DO:
  APPLY "END-ERROR":U TO SELF.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define BROWSE-NAME BROWSE-1
&Scoped-define SELF-NAME BROWSE-1
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL BROWSE-1 F-Main
ON VALUE-CHANGED OF BROWSE-1 IN FRAME F-Main
DO:
    ASSIGN  v-Connect-Name              = T-Connect._Connect-Name 
            v-Connect-Device            = T-Connect._Connect-Device 
            v-Connect-Type              = T-Connect._Connect-Type   
            v-Connect-Time              = T-Connect._Connect-Time       
                                                                          
            v-Connect-Id                = T-Connect._Connect-Id         
            v-Connect-Usr               = T-Connect._Connect-Usr          
                                                                             
            v-Connect-Pid               = T-Connect._Connect-Pid          
            v-Connect-Server            = T-Connect._Connect-Server        
            v-Connect-Wait1             = T-Connect._Connect-Wait1          
            v-Connect-Wait              = T-Connect._Connect-Wait            
            v-Connect-TransId           = T-Connect._Connect-TransId          
            v-Connect-SemNum            = T-Connect._Connect-SemNum            
            v-Connect-semid             = T-Connect._Connect-semid              
            v-Connect-Disconnect        = T-Connect._Connect-Disconnect          
            v-Connect-Resync            = T-Connect._Connect-Resync               
            v-Connect-Interrupt         = T-Connect._Connect-Interrupt             
            v-Connect-2phase            = T-Connect._Connect-2phase                 
            v-Connect-Batch             = T-Connect._Connect-Batch                   
            v-Connect-Misc              = T-Connect._Connect-Misc.

    DISPLAY                 
        v-Connect-Name              
        v-Connect-Device            
        v-Connect-Type              
        v-Connect-Time                      
                    
        v-Connect-Id                        
        v-Connect-Usr                       
                    
        v-Connect-Pid                       
        v-Connect-Server      
        v-Connect-Wait1        
        v-Connect-Wait        
        v-Connect-TransId     
        v-Connect-SemNum      
        v-Connect-semid       
        v-Connect-Disconnect  
        v-Connect-Resync      
        v-Connect-Interrupt   
        v-Connect-2phase      
        v-Connect-Batch      
        v-Connect-Misc
        WITH FRAME {&FRAME-NAME}.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME BUTTON-1
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL BUTTON-1 F-Main
ON CHOOSE OF BUTTON-1 IN FRAME F-Main /* Refrescar */
DO:
  RUN refrescar_datos.
  {&OPEN-QUERY-{&BROWSE-NAME}}
  APPLY "VALUE-CHANGED" TO BROWSE-1.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME x-usuarios
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL x-usuarios F-Main
ON VALUE-CHANGED OF x-usuarios IN FRAME F-Main
DO:
    ASSIGN x-usuarios.
    CASE x-usuarios:
        WHEN "T" THEN v-usuarios = "*".
        WHEN "F" THEN v-usuarios = "SELF,REMC".
        WHEN "X" THEN v-usuarios = "".
    END CASE.
    {&OPEN-QUERY-{&BROWSE-NAME}}
    APPLY "VALUE-CHANGED" TO BROWSE-1.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&UNDEFINE SELF-NAME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _MAIN-BLOCK F-Main 


/* ***************************  Main Block  *************************** */

/* Parent the dialog-box to the ACTIVE-WINDOW, if there is no parent.   */
IF VALID-HANDLE(ACTIVE-WINDOW) AND FRAME {&FRAME-NAME}:PARENT eq ?
THEN FRAME {&FRAME-NAME}:PARENT = ACTIVE-WINDOW.

v-usuarios = "".
x-usuarios = "X".

/* Now enable the interface and wait for the exit condition.            */
/* (NOTE: handle ERROR and END-KEY so cleanup code will always fire.    */
MAIN-BLOCK:
DO ON ERROR   UNDO MAIN-BLOCK, LEAVE MAIN-BLOCK
   ON END-KEY UNDO MAIN-BLOCK, LEAVE MAIN-BLOCK:
  RUN enable_UI.
  RUN refrescar_datos.
  {&OPEN-QUERY-{&BROWSE-NAME}}
  DISPLAY x-usuarios WITH FRAME {&FRAME-NAME}.
  APPLY "VALUE-CHANGED" TO BROWSE-1.
  WAIT-FOR GO OF FRAME {&FRAME-NAME}.
END.
RUN disable_UI.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


/* **********************  Internal Procedures  *********************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE disable_UI F-Main  _DEFAULT-DISABLE
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
  HIDE FRAME F-Main.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE enable_UI F-Main  _DEFAULT-ENABLE
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
  DISPLAY x-usuarios v-ultimo_refresh v-Connect-Name v-Connect-device 
          v-Connect-Time v-Connect-Type v-Connect-id v-Connect-Usr v-Connect-Pid 
          v-Connect-Server v-Connect-Batch v-Connect-Semnum v-Connect-Semid 
          v-Connect-Wait1 v-Connect-Wait v-Connect-Transid v-Connect-Disconnect 
          v-Connect-2phase v-Connect-Resync v-Connect-Interrupt v-Connect-Misc 
      WITH FRAME F-Main.
  ENABLE RECT-1 RECT-2 BROWSE-1 BUTTON-1 x-usuarios v-ultimo_refresh 
         v-Connect-Name v-Connect-device v-Connect-Time v-Connect-Type 
         v-Connect-id v-Connect-Usr v-Connect-Pid v-Connect-Server 
         v-Connect-Batch v-Connect-Semnum v-Connect-Semid v-Connect-Wait1 
         v-Connect-Wait v-Connect-Transid v-Connect-Disconnect v-Connect-2phase 
         v-Connect-Resync v-Connect-Interrupt v-Connect-Misc 
      WITH FRAME F-Main.
  VIEW FRAME F-Main.
  {&OPEN-BROWSERS-IN-QUERY-F-Main}
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE refrescar_datos F-Main 
PROCEDURE refrescar_datos :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

  EMPTY TEMP-TABLE T-Connect.
  FOR EACH _Connect:
      CREATE T-Connect.
/*
         MESSAGE                "1"   ENTRY(1,_Connect._Connect-Time, " ") SKIP  
                                "2"   ENTRY(2,_Connect._Connect-Time, " ") SKIP
                                "3"   ENTRY(3,_Connect._Connect-Time, " ") SKIP 
                                "4"   ENTRY(4,_Connect._Connect-Time, " ") SKIP
                                "5"   ENTRY(5,_Connect._Connect-Time, " ") SKIP
                                "6"   ENTRY(6,_Connect._Connect-Time, " ") SKIP
             NUM-ENTRIES(_Connect._Connect-Time, " ")
             VIEW-AS ALERT-BOX MESSAGE.
*/

      BUFFER-COPY _Connect TO T-Connect
          ASSIGN T-Connect._Connect-Time = REPLACE(_Connect._Connect-Time,"  "," ").


      /* --------- habilitar esta porcion de código para poner el día en la fecha de conexión
      CASE ENTRY(1,_Connect._Connect-Time, " "):
          WHEN "Sun" THEN T-Connect._Connect-Time = "Domingo".
          WHEN "Mon" THEN T-Connect._Connect-Time = "Lunes".
          WHEN "Tue" THEN T-Connect._Connect-Time = "Martes".
          WHEN "Wed" THEN T-Connect._Connect-Time = "Miércoles".
          WHEN "Thu" THEN T-Connect._Connect-Time = "Jueves".
          WHEN "Fri" THEN T-Connect._Connect-Time = "Viernes".
          WHEN "Sat" THEN T-Connect._Connect-Time = "Sábado".
      END CASE.
      
      IF ENTRY(3,_Connect._Connect-Time, " ") = ""
          THEN T-Connect._Connect-Time = T-Connect._Connect-Time + 
                                " " + ENTRY(4,_Connect._Connect-Time, " ") + 
                                " " + ENTRY(2,_Connect._Connect-Time, " ") +
                                " " + ENTRY(6,_Connect._Connect-Time, " ") + 
                                " " + ENTRY(5,_Connect._Connect-Time, " ").
          ELSE T-Connect._Connect-Time = T-Connect._Connect-Time + 
                            " " + ENTRY(3,_Connect._Connect-Time, " ") + 
                            " " + ENTRY(2,_Connect._Connect-Time, " ") +
                            " " + ENTRY(5,_Connect._Connect-Time, " ") + 
                            " " + ENTRY(4,_Connect._Connect-Time, " ").
      
      */

      T-Connect._Connect-Time = "".
      IF ENTRY(3,_Connect._Connect-Time, " ") = ""
          THEN T-Connect._Connect-Time = ENTRY(4,_Connect._Connect-Time, " ") + 
                                " " + ENTRY(2,_Connect._Connect-Time, " ") +
                                " " + ENTRY(6,_Connect._Connect-Time, " ") + 
                                " " + ENTRY(5,_Connect._Connect-Time, " ").
          ELSE T-Connect._Connect-Time = ENTRY(3,_Connect._Connect-Time, " ") + 
                            " " + ENTRY(2,_Connect._Connect-Time, " ") +
                            " " + ENTRY(5,_Connect._Connect-Time, " ") + 
                            " " + ENTRY(4,_Connect._Connect-Time, " ").

  END.
  v-ultimo_refresh = STRING(TIME,"HH:MM:SS").
  DISPLAY v-ultimo_refresh
      WITH FRAME {&FRAME-NAME}.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

