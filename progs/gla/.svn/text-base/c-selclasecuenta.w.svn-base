&ANALYZE-SUSPEND _VERSION-NUMBER UIB_v8r12 GUI
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

&IF DEFINED(UIB_is_Running) NE 0
&THEN
DEFINE VARIABLE que_libro LIKE Librocontable.cdg_librocontable.
DEFINE VARIABLE p-que_clase  AS CHARACTER.   
DEFINE VARIABLE puso_ok      AS LOGICAL.   
&ELSE
DEFINE INPUT PARAMETER    que_libro    LIKE Librocontable.cdg_librocontable.
DEFINE OUTPUT PARAMETER   p-que_clase  AS CHARACTER.   
DEFINE OUTPUT PARAMETER   puso_ok      AS LOGICAL.   
&ENDIF

/* Local Variable Definitions ---                                       */

{nrorelea.i}

DEFINE BUFFER B-Clase_de_cuenta FOR Clase_de_cuenta.

DEFINE VARIABLE f-que_clase LIKE Clase_de_cuenta.cdg_subclasecta.

DEFINE VARIABLE p_punto              AS INTEGER INITIAL 0.
DEFINE VARIABLE l_rotulo             AS INTEGER INITIAL 0.
DEFINE VARIABLE como_fue             AS LOGICAL.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE Window

/* Name of first Frame and/or Browse and/or first Query                 */
&Scoped-define FRAME-NAME DEFAULT-FRAME
&Scoped-define BROWSE-NAME brw_clasificacion

/* Internal Tables (found by Frame, Query & Browse Queries)             */
&Scoped-define INTERNAL-TABLES Clase_de_Cuenta

/* Definitions for BROWSE brw_clasificacion                             */
&Scoped-define FIELDS-IN-QUERY-brw_clasificacion ~
SUBSTRING(Clase_de_cuenta.cdg_subclasecta,LENGTH(que_clase) + 2) ~
Clase_de_Cuenta.nombre_subclasecta 
&Scoped-define ENABLED-FIELDS-IN-QUERY-brw_clasificacion 
&Scoped-define FIELD-PAIRS-IN-QUERY-brw_clasificacion
&Scoped-define OPEN-QUERY-brw_clasificacion OPEN QUERY brw_clasificacion FOR EACH Clase_de_Cuenta ~
      WHERE Clase_de_Cuenta.cdg_clasecta = que_clase ~
 AND Clase_de_Cuenta.cdg_librocontable = que_libro NO-LOCK.
&Scoped-define TABLES-IN-QUERY-brw_clasificacion Clase_de_Cuenta
&Scoped-define FIRST-TABLE-IN-QUERY-brw_clasificacion Clase_de_Cuenta


/* Definitions for FRAME DEFAULT-FRAME                                  */
&Scoped-define OPEN-BROWSERS-IN-QUERY-DEFAULT-FRAME ~
    ~{&OPEN-QUERY-brw_clasificacion}

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS RECT-24 que_subclase que_nombre que_clase ~
brw_clasificacion camino Btn_Elegir Btn_Salir 
&Scoped-Define DISPLAYED-OBJECTS que_subclase que_nombre que_clase camino 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME


/* ************************  Function Prototypes ********************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION-FORWARD relleno C-Win 
FUNCTION relleno RETURNS CHARACTER
  ( INPUT nivel AS INTEGER )  FORWARD.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


/* ***********************  Control Definitions  ********************** */

/* Define the widget handle for the window                              */
DEFINE VAR C-Win AS WIDGET-HANDLE NO-UNDO.

/* Definitions of the field level widgets                               */
DEFINE BUTTON Btn_Elegir DEFAULT 
     LABEL "&Elegir y Salir" 
     SIZE 26 BY 1.12
     BGCOLOR 8 .

DEFINE BUTTON Btn_Salir DEFAULT 
     LABEL "&Salir" 
     SIZE 26 BY 1.12
     BGCOLOR 8 .

DEFINE VARIABLE que_clase AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 56 BY .81 NO-UNDO.

DEFINE VARIABLE que_nombre AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 43 BY .81
     BGCOLOR 7 FGCOLOR 15  NO-UNDO.

DEFINE VARIABLE que_subclase AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 9 BY .81 NO-UNDO.

DEFINE RECTANGLE RECT-24
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL 
     SIZE 56 BY 1.62.

DEFINE VARIABLE camino AS CHARACTER 
     VIEW-AS SELECTION-LIST SINGLE 
     SIZE 56 BY 14.81
     FONT 2 NO-UNDO.

/* Query definitions                                                    */
&ANALYZE-SUSPEND
DEFINE QUERY brw_clasificacion FOR 
      Clase_de_Cuenta SCROLLING.
&ANALYZE-RESUME

/* Browse definitions                                                   */
DEFINE BROWSE brw_clasificacion
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS brw_clasificacion C-Win _STRUCTURED
  QUERY brw_clasificacion DISPLAY
      SUBSTRING(Clase_de_cuenta.cdg_subclasecta,LENGTH(que_clase) + 2) COLUMN-LABEL "Código!Clase" FORMAT "X(8)"
      Clase_de_Cuenta.nombre_subclasecta COLUMN-LABEL "Denominacion!Clasificación" FORMAT "X(40)"
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ROW-MARKERS SIZE 53 BY 16.69
         FONT 4
         TITLE "Clasificación".


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME DEFAULT-FRAME
     que_subclase AT ROW 1.27 COL 4 NO-LABEL
     que_nombre AT ROW 1.27 COL 12 COLON-ALIGNED NO-LABEL
     que_clase AT ROW 1.27 COL 57 COLON-ALIGNED NO-LABEL
     brw_clasificacion AT ROW 2.35 COL 4
     camino AT ROW 2.35 COL 59 NO-LABEL
     Btn_Elegir AT ROW 17.69 COL 60
     Btn_Salir AT ROW 17.69 COL 88
     RECT-24 AT ROW 17.42 COL 59
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 114.29 BY 19.81
         FONT 4
         DEFAULT-BUTTON Btn_Salir.


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
         TITLE              = "Selección de Clases de Cuentas por Libro"
         HEIGHT             = 19.73
         WIDTH              = 114.29
         MAX-HEIGHT         = 22.19
         MAX-WIDTH          = 114.29
         VIRTUAL-HEIGHT     = 22.19
         VIRTUAL-WIDTH      = 114.29
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


/* ***************  Runtime Attributes and UIB Settings  ************** */

&ANALYZE-SUSPEND _RUN-TIME-ATTRIBUTES
/* SETTINGS FOR WINDOW C-Win
  VISIBLE,,RUN-PERSISTENT                                               */
/* SETTINGS FOR FRAME DEFAULT-FRAME
                                                                        */
/* BROWSE-TAB brw_clasificacion que_clase DEFAULT-FRAME */
/* SETTINGS FOR FILL-IN que_subclase IN FRAME DEFAULT-FRAME
   ALIGN-L                                                              */
IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(C-Win)
THEN C-Win:HIDDEN = no.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME


/* Setting information for Queries and Browse Widgets fields            */

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE brw_clasificacion
/* Query rebuild information for BROWSE brw_clasificacion
     _TblList          = "sic.Clase_de_Cuenta"
     _Where[1]         = "Clase_de_Cuenta.cdg_clasecta = que_clase
 AND Clase_de_Cuenta.cdg_librocontable = que_libro"
     _FldNameList[1]   > "_<CALC>"
"SUBSTRING(Clase_de_cuenta.cdg_subclasecta,LENGTH(que_clase) + 2)" "Código!Clase" "X(8)" ? ? ? ? ? ? ? no ?
     _FldNameList[2]   > sic.Clase_de_Cuenta.nombre_subclasecta
"Clase_de_Cuenta.nombre_subclasecta" "Denominacion!Clasificación" "X(40)" "character" ? ? ? ? ? ? no ?
     _Query            is OPENED
*/  /* BROWSE brw_clasificacion */
&ANALYZE-RESUME

 




/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME C-Win
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON END-ERROR OF C-Win /* Selección de Clases de Cuentas por Libro */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON WINDOW-CLOSE OF C-Win /* Selección de Clases de Cuentas por Libro */
DO:
  /* This event will close the window and terminate the procedure.  */
  APPLY "CLOSE":U TO THIS-PROCEDURE.
  RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define BROWSE-NAME brw_clasificacion
&Scoped-define SELF-NAME brw_clasificacion
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL brw_clasificacion C-Win
ON RETURN OF brw_clasificacion IN FRAME DEFAULT-FRAME /* Clasificación */
OR MOUSE-SELECT-DBLCLICK OF brw_clasificacion IN FRAME {&FRAME-NAME}
DO:

   que_subclase = SUBSTRING(Clase_de_cuenta.cdg_subclasecta,LENGTH(que_clase) + 2).
   DISPLAY que_subclase
           WITH FRAME {&FRAME-NAME}.
   APPLY "RETURN" TO que_subclase IN FRAME {&FRAME-NAME}.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME Btn_Elegir
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Btn_Elegir C-Win
ON CHOOSE OF Btn_Elegir IN FRAME DEFAULT-FRAME /* Elegir y Salir */
DO:
  
  p-que_clase = que_clase.
  puso_ok = YES.
  
  &IF DEFINED (adm-panel) <> 0 &THEN
      RUN dispatch IN THIS-PROCEDURE ('exit').
  &ELSE
      APPLY "CLOSE":U TO THIS-PROCEDURE.
  &ENDIF
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME Btn_Salir
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Btn_Salir C-Win
ON CHOOSE OF Btn_Salir IN FRAME DEFAULT-FRAME /* Salir */
DO:

  p-que_clase = ?.
  puso_ok = NO.
  
  &IF DEFINED (adm-panel) <> 0 &THEN
      RUN dispatch IN THIS-PROCEDURE ('exit').
  &ELSE
      APPLY "CLOSE":U TO THIS-PROCEDURE.
  &ENDIF
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME que_subclase
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL que_subclase C-Win
ON MOUSE-SELECT-DBLCLICK OF que_subclase IN FRAME DEFAULT-FRAME
DO:
  que_subclase = "".
  DISPLAY que_subclase
          WITH FRAME {&FRAME-NAME}.
  APPLY "RETURN" TO que_subclase IN FRAME {&FRAME-NAME}.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL que_subclase C-Win
ON RETURN OF que_subclase IN FRAME DEFAULT-FRAME
DO:
   ASSIGN que_subclase.
   IF que_subclase = "" 
   THEN DO:

      p_punto = LENGTH(que_clase).
      DO WHILE p_punto > 0 AND SUBSTRING(que_clase,p_punto,1) <> ".":
         p_punto = p_punto - 1.
         que_clase = SUBSTRING(que_clase,1,p_punto).
      END.   
      IF p_punto = 0
      THEN DO:
         APPLY "U1" TO SELF.
         RETURN NO-APPLY.
      END.
      ELSE DO:
         
         IF p_punto > 1
         THEN DO:
            p_punto = p_punto - 1.
            que_clase = SUBSTRING(que_clase,1,p_punto).
            FIND FIRST Clase_de_cuenta 
                 WHERE Clase_de_cuenta.cdg_subclasecta = que_clase
                   AND Clase_de_cuenta.cdg_libro       = que_libro.
            que_nombre = Clase_de_cuenta.nombre.
            RUN armar_rotulo.
         END.
         ELSE DO:
            que_clase = "".
            que_nombre = "".
         END.
               
         como_fue = camino:DELETE(camino:NUM-ITEMS).
         que_subclase = "".
         DISPLAY que_subclase
                 que_nombre                     
                 camino
                 WITH FRAME {&FRAME-NAME}.      
         RUN abre_query.
         RUN abre_query_cuentas.
         
      END.   
   END.   
   ELSE DO:

      FIND FIRST Clase_de_cuenta 
           WHERE Clase_de_cuenta.cdg_clasecta    = que_clase 
             AND Clase_de_cuenta.cdg_libro       = que_libro
             AND Clase_de_cuenta.cdg_subclasecta = que_clase + "." + que_subclase 
                 NO-ERROR.

      IF NOT AVAILABLE Clase_de_cuenta
      THEN DO:
         que_nombre = "".
         RUN crear_clasificacion.         
      END.
      ELSE DO:
         que_nombre = Clase_de_cuenta.nombre_subclasecta.
         ASSIGN que_clase = que_clase + "." + que_subclase
                que_subclase = "".
         como_fue = camino:ADD-LAST(relleno( camino:NUM-ITEMS ) + que_nombre).

         RUN armar_rotulo.
         DISPLAY que_subclase
                 que_nombre                     
                 camino
                 WITH FRAME {&FRAME-NAME}.
      END.

   END.   

   DISPLAY que_clase WITH FRAME {&FRAME-NAME}.
   RUN abre_query.
   RUN abre_query_cuentas.
   RETURN NO-APPLY.
    
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

RUN iniciar_clase.

/* Now enable the interface and wait for the exit condition.            */
/* (NOTE: handle ERROR and END-KEY so cleanup code will always fire.    */
MAIN-BLOCK:
DO ON ERROR   UNDO MAIN-BLOCK, LEAVE MAIN-BLOCK
   ON END-KEY UNDO MAIN-BLOCK, LEAVE MAIN-BLOCK:

  FIND Librocontable WHERE Librocontable.cdg_librocontable = que_libro NO-LOCK.
  RUN enable_UI.
  {&WINDOW-NAME}:TITLE = "Selección de Clasificación en el libro:" + Librocontable.dsc_librocontable.
  IF NOT THIS-PROCEDURE:PERSISTENT THEN
    WAIT-FOR CLOSE OF THIS-PROCEDURE.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


/* **********************  Internal Procedures  *********************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE abre_query C-Win 
PROCEDURE abre_query :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
   
   {&OPEN-QUERY-{&BROWSE-NAME}}

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE abre_query_cuentas C-Win 
PROCEDURE abre_query_cuentas :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE armar_rotulo C-Win 
PROCEDURE armar_rotulo :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/*
  IF AVAILABLE Clase_de_cuenta
     THEN rotulo = FILL(" ",l_rotulo - LENGTH(Clase_de_cuenta.rotulo_siguiente) - 1) + Clase_de_cuenta.rotulo_siguiente + ":".           ELSE rotulo = FILL(" ",l_rotulo - 1) + ":".
*/

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE disable_UI C-Win _DEFAULT-DISABLE
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


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE enable_UI C-Win _DEFAULT-ENABLE
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
  DISPLAY que_subclase que_nombre que_clase camino 
      WITH FRAME DEFAULT-FRAME IN WINDOW C-Win.
  ENABLE RECT-24 que_subclase que_nombre que_clase brw_clasificacion camino 
         Btn_Elegir Btn_Salir 
      WITH FRAME DEFAULT-FRAME IN WINDOW C-Win.
  {&OPEN-BROWSERS-IN-QUERY-DEFAULT-FRAME}
  VIEW C-Win.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE iniciar_clase C-Win 
PROCEDURE iniciar_clase :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

  FIND FIRST Clase_de_cuenta NO-LOCK NO-ERROR.
  IF NOT AVAILABLE Clase_de_cuenta
  THEN DO:
       DO TRANSACTION:
          CREATE Clase_de_cuenta.
          ASSIGN Clase_de_cuenta.cdg_clasecta    = ?
                 Clase_de_cuenta.cdg_subclasecta = "".
       END.
       RELEASE Clase_de_cuenta.
  END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


/* ************************  Function Implementations ***************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION relleno C-Win 
FUNCTION relleno RETURNS CHARACTER
  ( INPUT nivel AS INTEGER ) :
/*------------------------------------------------------------------------------
  Purpose:  
    Notes:  
------------------------------------------------------------------------------*/

  DEFINE VARIABLE v-relleno AS CHARACTER.

  IF nivel = 0 
     THEN v-relleno = "".
     ELSE v-relleno = FILL(" ",nivel) + "-".

  RETURN v-relleno.   /* Function return value. */

END FUNCTION.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


