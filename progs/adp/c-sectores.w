&ANALYZE-SUSPEND _VERSION-NUMBER UIB_v8r12 GUI
&ANALYZE-RESUME
/* Connected Databases 
          sic              PROGRESS
*/
&Scoped-define WINDOW-NAME C-Win

/* Temp-Table and Buffer definitions                                    */
DEFINE TEMP-TABLE T-Area NO-UNDO LIKE Area.


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
DEFINE VARIABLE p-que_clase  AS CHARACTER.   
DEFINE VARIABLE puso_ok      AS LOGICAL.   
&ELSE
DEFINE OUTPUT PARAMETER   p-que_clase  AS CHARACTER.   
DEFINE OUTPUT PARAMETER   puso_ok      AS LOGICAL.   
&ENDIF

/* Local Variable Definitions ---                                       */

{nrorelea.i}

DEFINE BUFFER B-Area FOR Area.

DEFINE VARIABLE f-que_clase LIKE Area.cdg_reporta.

DEFINE VARIABLE p_punto              AS INTEGER INITIAL 0.
DEFINE VARIABLE l_rotulo             AS INTEGER INITIAL 0.
DEFINE VARIABLE como_fue             AS LOGICAL.
DEFINE VARIABLE que_empresa          LIKE Empresa.cdg_empresa.

DEFINE VARIABLE v-denominacion         LIKE Area.denominacion.
DEFINE VARIABLE v-rotulo_siguiente     LIKE Area.rotulo_siguiente.
DEFINE VARIABLE v-longitud_siguiente   LIKE Area.longitud_siguiente.
DEFINE VARIABLE v-tipo_siguiente       LIKE Area.tipo_siguiente.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE Window
&Scoped-define DB-AWARE no

/* Name of first Frame and/or Browse and/or first Query                 */
&Scoped-define FRAME-NAME DEFAULT-FRAME
&Scoped-define BROWSE-NAME brw_clasificacion

/* Internal Tables (found by Frame, Query & Browse Queries)             */
&Scoped-define INTERNAL-TABLES Area

/* Definitions for BROWSE brw_clasificacion                             */
&Scoped-define FIELDS-IN-QUERY-brw_clasificacion ~
SUBSTRING(Area.cdg_reporta,LENGTH(que_clase) + 2) Area.denominacion 
&Scoped-define ENABLED-FIELDS-IN-QUERY-brw_clasificacion 
&Scoped-define QUERY-STRING-brw_clasificacion FOR EACH Area ~
      WHERE Area.cdg_reporta = que_clase NO-LOCK
&Scoped-define OPEN-QUERY-brw_clasificacion OPEN QUERY brw_clasificacion FOR EACH Area ~
      WHERE Area.cdg_reporta = que_clase NO-LOCK.
&Scoped-define TABLES-IN-QUERY-brw_clasificacion Area
&Scoped-define FIRST-TABLE-IN-QUERY-brw_clasificacion Area


/* Definitions for FRAME DEFAULT-FRAME                                  */
&Scoped-define OPEN-BROWSERS-IN-QUERY-DEFAULT-FRAME ~
    ~{&OPEN-QUERY-brw_clasificacion}

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS que_nombre que_clase que_subclase ~
brw_clasificacion camino btn_modificar btn_eliminar Btn_Elegir Btn_Salir 
&Scoped-Define DISPLAYED-OBJECTS que_nombre que_clase que_subclase camino 

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
     SIZE 27 BY 1.14
     BGCOLOR 8 .

DEFINE BUTTON btn_eliminar 
     LABEL "&Eliminar" 
     SIZE 26 BY 1.14.

DEFINE BUTTON btn_modificar 
     LABEL "&Modificar" 
     SIZE 26 BY 1.14.

DEFINE BUTTON Btn_Salir DEFAULT 
     LABEL "&Salir" 
     SIZE 27 BY 1.14
     BGCOLOR 8 .

DEFINE VARIABLE que_clase AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 85 BY 1 NO-UNDO.

DEFINE VARIABLE que_nombre AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 51 BY 1
     BGCOLOR 7 FGCOLOR 15  NO-UNDO.

DEFINE VARIABLE que_subclase AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 14 BY 1 NO-UNDO.

DEFINE VARIABLE camino AS CHARACTER 
     VIEW-AS SELECTION-LIST SINGLE 
     SIZE 85 BY 23.57
     FONT 2 NO-UNDO.

/* Query definitions                                                    */
&ANALYZE-SUSPEND
DEFINE QUERY brw_clasificacion FOR 
      Area SCROLLING.
&ANALYZE-RESUME

/* Browse definitions                                                   */
DEFINE BROWSE brw_clasificacion
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS brw_clasificacion C-Win _STRUCTURED
  QUERY brw_clasificacion DISPLAY
      SUBSTRING(Area.cdg_reporta,LENGTH(que_clase) + 2) COLUMN-LABEL "Código!Clase" FORMAT "X(8)":U
      Area.denominacion COLUMN-LABEL "Denominacion!Clasificación" FORMAT "X(50)":U
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ROW-MARKERS SIZE 66 BY 23.57
         FONT 4
         TITLE "Clasificación".


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME DEFAULT-FRAME
     que_nombre AT ROW 1.24 COL 16 COLON-ALIGNED NO-LABEL
     que_clase AT ROW 1.24 COL 69 COLON-ALIGNED NO-LABEL
     que_subclase AT ROW 1.29 COL 3 NO-LABEL
     brw_clasificacion AT ROW 2.67 COL 3
     camino AT ROW 2.67 COL 71 NO-LABEL
     btn_modificar AT ROW 26.48 COL 3
     btn_eliminar AT ROW 26.48 COL 43
     Btn_Elegir AT ROW 26.48 COL 71
     Btn_Salir AT ROW 26.48 COL 129
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 160 BY 27.67
         FONT 4
         DEFAULT-BUTTON Btn_Salir.


/* *********************** Procedure Settings ************************ */

&ANALYZE-SUSPEND _PROCEDURE-SETTINGS
/* Settings for THIS-PROCEDURE
   Type: Window
   Allow: Basic,Browse,DB-Fields,Window,Query
   Other Settings: COMPILE
   Temp-Tables and Buffers:
      TABLE: T-Area T "?" NO-UNDO sic Area
   END-TABLES.
 */
&ANALYZE-RESUME _END-PROCEDURE-SETTINGS

/* *************************  Create Window  ************************** */

&ANALYZE-SUSPEND _CREATE-WINDOW
IF SESSION:DISPLAY-TYPE = "GUI":U THEN
  CREATE WINDOW C-Win ASSIGN
         HIDDEN             = YES
         TITLE              = "Mantenimiento de Sectores"
         HEIGHT             = 27.67
         WIDTH              = 160
         MAX-HEIGHT         = 27.67
         MAX-WIDTH          = 160
         VIRTUAL-HEIGHT     = 27.67
         VIRTUAL-WIDTH      = 160
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
/* SETTINGS FOR WINDOW C-Win
  VISIBLE,,RUN-PERSISTENT                                               */
/* SETTINGS FOR FRAME DEFAULT-FRAME
                                                                        */
/* BROWSE-TAB brw_clasificacion que_subclase DEFAULT-FRAME */
/* SETTINGS FOR FILL-IN que_subclase IN FRAME DEFAULT-FRAME
   ALIGN-L                                                              */
IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(C-Win)
THEN C-Win:HIDDEN = no.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME


/* Setting information for Queries and Browse Widgets fields            */

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE brw_clasificacion
/* Query rebuild information for BROWSE brw_clasificacion
     _TblList          = "sic.Area"
     _Where[1]         = "Area.cdg_reporta = que_clase"
     _FldNameList[1]   > "_<CALC>"
"SUBSTRING(Area.cdg_reporta,LENGTH(que_clase) + 2)" "Código!Clase" "X(8)" ? ? ? ? ? ? ? no ? no no ? yes no no "U" "" ""
     _FldNameList[2]   > sic.Area.denominacion
"Area.denominacion" "Denominacion!Clasificación" "X(50)" "character" ? ? ? ? ? ? no ? no no ? yes no no "U" "" ""
     _Query            is OPENED
*/  /* BROWSE brw_clasificacion */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME C-Win
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON END-ERROR OF C-Win /* Mantenimiento de Sectores */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON WINDOW-CLOSE OF C-Win /* Mantenimiento de Sectores */
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

   que_subclase = SUBSTRING(Area.cdg_reporta,LENGTH(que_clase) + 2).
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


&Scoped-define SELF-NAME btn_eliminar
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btn_eliminar C-Win
ON CHOOSE OF btn_eliminar IN FRAME DEFAULT-FRAME /* Eliminar */
DO:

   IF CAN-FIND(FIRST B-Area WHERE B-Area.cdg_area = Area.cdg_reporta)
   THEN DO:
       RUN PONMENSJ.P (INPUT "CLAS001" ).
   END.    
   ELSE DO:                                                 
       DO TRANSACTION:
          FIND CURRENT Area EXCLUSIVE-LOCK.   
          DELETE Area.
       END.
       RUN ABRE_QUERY.
   END.    
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btn_modificar
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btn_modificar C-Win
ON CHOOSE OF btn_modificar IN FRAME DEFAULT-FRAME /* Modificar */
DO:
   DO TRANSACTION:
        RUN modificar_clasificacion.
        DISPLAY Area.denominacion
                WITH BROWSE brw_clasificacion.
   END.        
  
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
            FIND FIRST Area WHERE Area.cdg_reporta = que_clase.
            que_nombre = Area.denominacion.
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

      FIND FIRST Area WHERE Area.cdg_area = que_clase 
                         AND Area.cdg_reporta = que_clase + "." + que_subclase NO-ERROR.

      IF NOT AVAILABLE Area
      THEN DO:
         que_nombre = "".
         RUN crear_clasificacion.         
      END.
      ELSE DO:
         que_nombre = Area.denominacion.
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
  RUN enable_UI.
  {setwintit.i "SIC/ADP" "Mantenimiento de Sectores"}
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
  IF AVAILABLE Area
     THEN rotulo = FILL(" ",l_rotulo - LENGTH(Area.rotulo_siguiente) - 1) + Area.rotulo_siguiente + ":".           ELSE rotulo = FILL(" ",l_rotulo - 1) + ":".
*/

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE crear_clasificacion C-Win 
PROCEDURE crear_clasificacion :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

   EMPTY TEMP-TABLE T-Area.
   CREATE T-Area.
   ASSIGN T-Area.tipo_siguiente       = 1.

   RUN d-actualizar_area.w ( INPUT "Creación de Sectores",
                             INPUT-OUTPUT TABLE T-Area,
                             OUTPUT como_fue).    

   IF como_fue
   THEN DO TRANSACTION:
       CREATE Area.
       FIND FIRST T-Area.
       BUFFER-COPY T-Area TO Area
           ASSIGN Area.cdg_area             = que_clase                                 
                  Area.cdg_reporta          = que_clase + "." + que_subclase
                  Area.nro_area             = NEXT-VALUE(proxima_area).
       FIND CURRENT Area NO-LOCK.
   END.

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
  DISPLAY que_nombre que_clase que_subclase camino 
      WITH FRAME DEFAULT-FRAME IN WINDOW C-Win.
  ENABLE que_nombre que_clase que_subclase brw_clasificacion camino 
         btn_modificar btn_eliminar Btn_Elegir Btn_Salir 
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

  FIND FIRST Area NO-LOCK NO-ERROR.
  IF NOT AVAILABLE Area
  THEN DO:
       DO TRANSACTION:
          CREATE Area.
          ASSIGN Area.cdg_area    = ?
                 Area.cdg_reporta = "".
       END.
       RELEASE Area.
  END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE modificar_clasificacion C-Win 
PROCEDURE modificar_clasificacion :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

   EMPTY TEMP-TABLE T-Area.
   CREATE T-Area.
   BUFFER-COPY Area TO T-Area.

   RUN d-actualizar_area.w ( INPUT "Modificación de Sectores",
                             INPUT-OUTPUT TABLE T-Area,
                             OUTPUT como_fue).    

   IF como_fue
   THEN DO TRANSACTION:
       FIND CURRENT Area EXCLUSIVE-LOCK.
       FIND FIRST T-Area.
       BUFFER-COPY T-Area EXCEPT T-Area.cdg_area T-Area.cdg_reporta T-Area.nro_area TO Area.
       FIND CURRENT Area NO-LOCK.
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

