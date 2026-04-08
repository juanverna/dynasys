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
DEFINE VARIABLE p-que_clase  AS CHARACTER.   
DEFINE VARIABLE puso_ok      AS LOGICAL.   
&ELSE
DEFINE OUTPUT PARAMETER   p-que_clase  AS CHARACTER.   
DEFINE OUTPUT PARAMETER   puso_ok      AS LOGICAL.   
&ENDIF

/* Local Variable Definitions ---                                       */

{nrorelea.i}

DEFINE BUFFER B-Clase_de_articulo FOR Clase_de_articulo.
DEFINE BUFFER C-Clase_de_articulo FOR Clase_de_articulo.

DEFINE VARIABLE f-que_clase LIKE Clase_de_articulo.cdg_subclaseart.

DEFINE VARIABLE p_punto              AS INTEGER INITIAL 0.
DEFINE VARIABLE l_rotulo             AS INTEGER INITIAL 0.
DEFINE VARIABLE como_fue             AS LOGICAL.
DEFINE VARIABLE si_no                AS LOGICAL.
DEFINE VARIABLE v-a_nombre           AS CHARACTER .

FORM           
   SKIP(0.2)   
   Clase_de_articulo.nombre_subclaseart  COLON 16 FGCOLOR 9 BGCOLOR 15
   SKIP(0.2)   
   Clase_de_articulo.rotulo_siguiente COLON 16 FGCOLOR 9 BGCOLOR 15
   SKIP(0.2)   
   Clase_de_articulo.longitud_siguiente COLON 16 FGCOLOR 9 BGCOLOR 15
   Clase_de_articulo.tipo_siguiente COLON 16 FGCOLOR 9
   SKIP(0.2)   
   WITH TITLE "Modificación de Clasificación.F2=Finalizar" THREE-D KEEP-TAB-ORDER
        FONT 4 FGCOLOR 9 BGCOLOR 8 VIEW-AS DIALOG-BOX SIDE-LABELS
        FRAME frm-registro.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE Window
&Scoped-define DB-AWARE no

/* Name of designated FRAME-NAME and/or first browse and/or first query */
&Scoped-define FRAME-NAME DEFAULT-FRAME
&Scoped-define BROWSE-NAME brw_clasificacion

/* Internal Tables (found by Frame, Query & Browse Queries)             */
&Scoped-define INTERNAL-TABLES Clase_de_articulo

/* Definitions for BROWSE brw_clasificacion                             */
&Scoped-define FIELDS-IN-QUERY-brw_clasificacion ~
SUBSTRING(Clase_de_articulo.cdg_subclaseart,LENGTH(que_clase) + 2) ~
Clase_de_articulo.nombre_subclaseart 
&Scoped-define ENABLED-FIELDS-IN-QUERY-brw_clasificacion 
&Scoped-define QUERY-STRING-brw_clasificacion FOR EACH Clase_de_articulo ~
      WHERE Clase_de_articulo.cdg_claseart = que_clase NO-LOCK
&Scoped-define OPEN-QUERY-brw_clasificacion OPEN QUERY brw_clasificacion FOR EACH Clase_de_articulo ~
      WHERE Clase_de_articulo.cdg_claseart = que_clase NO-LOCK.
&Scoped-define TABLES-IN-QUERY-brw_clasificacion Clase_de_articulo
&Scoped-define FIRST-TABLE-IN-QUERY-brw_clasificacion Clase_de_articulo


/* Definitions for FRAME DEFAULT-FRAME                                  */
&Scoped-define OPEN-BROWSERS-IN-QUERY-DEFAULT-FRAME ~
    ~{&OPEN-QUERY-brw_clasificacion}

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS que_subclase v-que_nombre brw_clasificacion ~
camino btn_copist btn_modificar btn_eliminar btn_vaciar btn_generar ~
Btn_edquiv Btn_Imprimir Btn_Elegir Btn_Salir 
&Scoped-Define DISPLAYED-OBJECTS que_subclase v-que_nombre que_clase camino 

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

/* Definitions of handles for OCX Containers                            */
DEFINE VARIABLE CtrlFrame AS WIDGET-HANDLE NO-UNDO.
DEFINE VARIABLE chCtrlFrame AS COMPONENT-HANDLE NO-UNDO.

/* Definitions of the field level widgets                               */
DEFINE BUTTON btn_copist 
     LABEL "&Copiar" 
     SIZE 13 BY 1.14.

DEFINE BUTTON Btn_edquiv DEFAULT 
     LABEL "&Equivalencias" 
     SIZE 20 BY 1.14
     BGCOLOR 8 .

DEFINE BUTTON Btn_Elegir DEFAULT 
     LABEL "&Elegir y Salir" 
     SIZE 20 BY 1.14
     BGCOLOR 8 .

DEFINE BUTTON btn_eliminar 
     LABEL "&Eliminar" 
     SIZE 13 BY 1.14.

DEFINE BUTTON btn_generar 
     LABEL "&Generar" 
     SIZE 13 BY 1.14.

DEFINE BUTTON Btn_Imprimir DEFAULT 
     LABEL "&Imprimir" 
     SIZE 20 BY 1.14
     BGCOLOR 8 .

DEFINE BUTTON btn_modificar 
     LABEL "&Modificar" 
     SIZE 13 BY 1.14.

DEFINE BUTTON Btn_Salir DEFAULT 
     LABEL "&Salir" 
     SIZE 20 BY 1.14
     BGCOLOR 8 .

DEFINE BUTTON btn_vaciar 
     LABEL "&Vaciar" 
     SIZE 13 BY 1.14.

DEFINE VARIABLE que_clase AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 83 BY 1 NO-UNDO.

DEFINE VARIABLE que_subclase AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 15 BY 1 TOOLTIP "Blanco-Enter para subir un nivel o una clasificacion para Bajar" NO-UNDO.

DEFINE VARIABLE v-que_nombre AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 50 BY 1
     BGCOLOR 7 FGCOLOR 15  NO-UNDO.

DEFINE VARIABLE camino AS CHARACTER 
     VIEW-AS SELECTION-LIST SINGLE 
     SIZE 83 BY 22.38
     FONT 2 NO-UNDO.

/* Query definitions                                                    */
&ANALYZE-SUSPEND
DEFINE QUERY brw_clasificacion FOR 
      Clase_de_articulo SCROLLING.
&ANALYZE-RESUME

/* Browse definitions                                                   */
DEFINE BROWSE brw_clasificacion
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS brw_clasificacion C-Win _STRUCTURED
  QUERY brw_clasificacion DISPLAY
      SUBSTRING(Clase_de_articulo.cdg_subclaseart,LENGTH(que_clase) + 2) COLUMN-LABEL "Código!Clase" FORMAT "X(8)":U
            WIDTH 13.2
      Clase_de_articulo.nombre_subclaseart COLUMN-LABEL "Denominacion!Clasificación" FORMAT "X(40)":U
            WIDTH 54.2
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ROW-MARKERS SIZE 73 BY 22.38
         FONT 4
         TITLE "Clasificación".


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME DEFAULT-FRAME
     que_subclase AT ROW 1.24 COL 2 NO-LABEL
     v-que_nombre AT ROW 1.24 COL 23 COLON-ALIGNED NO-LABEL
     que_clase AT ROW 1.24 COL 74 COLON-ALIGNED NO-LABEL
     brw_clasificacion AT ROW 2.43 COL 2
     camino AT ROW 2.43 COL 76 NO-LABEL
     btn_copist AT ROW 25.05 COL 2
     btn_modificar AT ROW 25.05 COL 17
     btn_eliminar AT ROW 25.05 COL 32
     btn_vaciar AT ROW 25.05 COL 47
     btn_generar AT ROW 25.05 COL 62
     Btn_edquiv AT ROW 25.05 COL 76
     Btn_Imprimir AT ROW 25.05 COL 97
     Btn_Elegir AT ROW 25.05 COL 118
     Btn_Salir AT ROW 25.05 COL 139
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 160 BY 25.71
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
         TITLE              = "Mantenimiento de Clases de Artículos"
         HEIGHT             = 25.71
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
   FRAME-NAME                                                           */
/* BROWSE-TAB brw_clasificacion que_clase DEFAULT-FRAME */
/* SETTINGS FOR FILL-IN que_clase IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
ASSIGN 
       que_clase:READ-ONLY IN FRAME DEFAULT-FRAME        = TRUE.

/* SETTINGS FOR FILL-IN que_subclase IN FRAME DEFAULT-FRAME
   ALIGN-L                                                              */
IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(C-Win)
THEN C-Win:HIDDEN = no.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME


/* Setting information for Queries and Browse Widgets fields            */

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE brw_clasificacion
/* Query rebuild information for BROWSE brw_clasificacion
     _TblList          = "sic.Clase_de_articulo"
     _Where[1]         = "Clase_de_articulo.cdg_claseart = que_clase"
     _FldNameList[1]   > "_<CALC>"
"SUBSTRING(Clase_de_articulo.cdg_subclaseart,LENGTH(que_clase) + 2)" "Código!Clase" "X(8)" ? ? ? ? ? ? ? no ? no no "13.2" yes no no "U" "" ""
     _FldNameList[2]   > sic.Clase_de_articulo.nombre_subclaseart
"Clase_de_articulo.nombre_subclaseart" "Denominacion!Clasificación" ? "character" ? ? ? ? ? ? no ? no no "54.2" yes no no "U" "" ""
     _Query            is OPENED
*/  /* BROWSE brw_clasificacion */
&ANALYZE-RESUME

 


/* **********************  Create OCX Containers  ********************** */

&ANALYZE-SUSPEND _CREATE-DYNAMIC

&IF "{&OPSYS}" = "WIN32":U AND "{&WINDOW-SYSTEM}" NE "TTY":U &THEN

CREATE CONTROL-FRAME CtrlFrame ASSIGN
       FRAME           = FRAME DEFAULT-FRAME:HANDLE
       ROW             = 1.14
       COLUMN          = 18.6
       HEIGHT          = 1.19
       WIDTH           = 5
       WIDGET-ID       = 4
       HIDDEN          = no
       SENSITIVE       = yes.
/* CtrlFrame OCXINFO:CREATE-CONTROL from: {EAF26C8F-9586-101B-9306-0020AF234C9D} type: CSSpin */
      CtrlFrame:MOVE-BEFORE(que_subclase:HANDLE IN FRAME DEFAULT-FRAME).

&ENDIF

&ANALYZE-RESUME /* End of _CREATE-DYNAMIC */


/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME C-Win
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON END-ERROR OF C-Win /* Mantenimiento de Clases de Artículos */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON WINDOW-CLOSE OF C-Win /* Mantenimiento de Clases de Artículos */
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

   que_subclase = SUBSTRING(Clase_de_articulo.cdg_subclaseart,LENGTH(que_clase) + 2).
   DISPLAY que_subclase
           WITH FRAME {&FRAME-NAME}.
   APPLY "RETURN" TO que_subclase IN FRAME {&FRAME-NAME}.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL brw_clasificacion C-Win
ON VALUE-CHANGED OF brw_clasificacion IN FRAME DEFAULT-FRAME /* Clasificación */
DO:
  RUN habilitar_botones.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btn_copist
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btn_copist C-Win
ON CHOOSE OF btn_copist IN FRAME DEFAULT-FRAME /* Copiar */
DO:
    RUN copiar_estructura.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME Btn_edquiv
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Btn_edquiv C-Win
ON CHOOSE OF Btn_edquiv IN FRAME DEFAULT-FRAME /* Equivalencias */
DO:
    DEFINE VARIABLE puso_ok AS LOGICAL.
    DEFINE VARIABLE s-reemplazo AS CHARACTER.

    RUN getparametro_o.p ( INPUT "EQVDESCR", OUTPUT s-reemplazo ).

    RUN c-edttexto.w ( INPUT-OUTPUT s-reemplazo,
                       INPUT "Abreviaturas en descripciones de artículos",
                       INPUT 0, /* Modo modificaciones */
                       OUTPUT puso_ok).
    IF puso_ok
    THEN DO:
        RUN setparametro.p ( INPUT "EQVDESCR",
                             INPUT "",
                             INPUT 0.0,
                             INPUT NO,
                             INPUT 0,
                             INPUT s-reemplazo).

    END.
    
    RETURN NO-APPLY.
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
    RUN eliminar_nodo.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btn_generar
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btn_generar C-Win
ON CHOOSE OF btn_generar IN FRAME DEFAULT-FRAME /* Generar */
DO:
  RUN generar_articulos.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME Btn_Imprimir
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Btn_Imprimir C-Win
ON CHOOSE OF Btn_Imprimir IN FRAME DEFAULT-FRAME /* Imprimir */
DO:
  
  RUN poner_estado ( "Generando imagen de impresión ..." ).

  RUN lsclasificacion_articulos.p ( INPUT Clase_de_articulo.cdg_clase ) .

  RUN restaurar_estado.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btn_modificar
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btn_modificar C-Win
ON CHOOSE OF btn_modificar IN FRAME DEFAULT-FRAME /* Modificar */
DO:
   DO TRANSACTION:
        FIND CURRENT Clase_de_articulo EXCLUSIVE-LOCK.   
        RUN modificar_clasificacion.
        DISPLAY Clase_de_articulo.nombre_subclaseart
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


&Scoped-define SELF-NAME btn_vaciar
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btn_vaciar C-Win
ON CHOOSE OF btn_vaciar IN FRAME DEFAULT-FRAME /* Vaciar */
DO:
  RUN vaciar_estructura.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME CtrlFrame
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL CtrlFrame C-Win OCX.SpinDown
PROCEDURE CtrlFrame.CSSpin.SpinDown .
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  None required for OCX.
  Notes:       
------------------------------------------------------------------------------*/

APPLY "RETURN" TO que_subclase IN FRAME {&FRAME-NAME}.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL CtrlFrame C-Win OCX.SpinUp
PROCEDURE CtrlFrame.CSSpin.SpinUp .
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  None required for OCX.
  Notes:       
------------------------------------------------------------------------------*/

APPLY "mouse-select-dblclick" TO que_subclase IN FRAME {&FRAME-NAME}.

END PROCEDURE.

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
            FIND FIRST Clase_de_articulo WHERE Clase_de_articulo.cdg_subclaseart = que_clase.
            v-que_nombre = Clase_de_articulo.nombre.
            RUN armar_rotulo.
         END.
         ELSE DO:
            que_clase = "".
            v-que_nombre = "".
         END.
               
         como_fue = camino:DELETE(camino:NUM-ITEMS).
         que_subclase = "".
         DISPLAY que_subclase
                 v-que_nombre                     
                 camino
                 WITH FRAME {&FRAME-NAME}.      
         RUN abre_query.
         RUN abre_query_cuentas.
         
      END.   
   END.   
   ELSE DO:

      FIND FIRST Clase_de_articulo WHERE Clase_de_articulo.cdg_claseart = que_clase 
                         AND Clase_de_articulo.cdg_subclaseart = que_clase + "." + que_subclase NO-ERROR.

      IF NOT AVAILABLE Clase_de_articulo
      THEN DO:
         v-que_nombre = "".
         RUN crear_clasificacion.         
      END.
      ELSE DO:
         v-que_nombre = Clase_de_articulo.nombre_subclaseart.
         ASSIGN que_clase = que_clase + "." + que_subclase
                que_subclase = "".
         como_fue = camino:ADD-LAST(relleno( camino:NUM-ITEMS ) + v-que_nombre).

         RUN armar_rotulo.
         DISPLAY que_subclase
                 v-que_nombre                     
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

/* Now enable the interface and wait for the exit condition.            */
/* (NOTE: handle ERROR and END-KEY so cleanup code will always fire.    */
MAIN-BLOCK:
DO ON ERROR   UNDO MAIN-BLOCK, LEAVE MAIN-BLOCK
   ON END-KEY UNDO MAIN-BLOCK, LEAVE MAIN-BLOCK:
  RUN enable_UI.
  {setwintit.i "SIC/INV" "Clasificación de Artículos"}
  RUN habilitar_botones.
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
   RUN habilitar_botones.

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
  IF AVAILABLE Clase_de_articulo
     THEN rotulo = FILL(" ",l_rotulo - LENGTH(Clase_de_articulo.rotulo_siguiente) - 1) + Clase_de_articulo.rotulo_siguiente + ":".           ELSE rotulo = FILL(" ",l_rotulo - 1) + ":".
*/

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE control_load C-Win  _CONTROL-LOAD
PROCEDURE control_load :
/*------------------------------------------------------------------------------
  Purpose:     Load the OCXs    
  Parameters:  <none>
  Notes:       Here we load, initialize and make visible the 
               OCXs in the interface.                        
------------------------------------------------------------------------------*/

&IF "{&OPSYS}" = "WIN32":U AND "{&WINDOW-SYSTEM}" NE "TTY":U &THEN
DEFINE VARIABLE UIB_S    AS LOGICAL    NO-UNDO.
DEFINE VARIABLE OCXFile  AS CHARACTER  NO-UNDO.

OCXFile = SEARCH( "c-abmclasearticulo.wrx":U ).
IF OCXFile = ? THEN
  OCXFile = SEARCH(SUBSTRING(THIS-PROCEDURE:FILE-NAME, 1,
                     R-INDEX(THIS-PROCEDURE:FILE-NAME, ".":U), "CHARACTER":U) + "wrx":U).

IF OCXFile <> ? THEN
DO:
  ASSIGN
    chCtrlFrame = CtrlFrame:COM-HANDLE
    UIB_S = chCtrlFrame:LoadControls( OCXFile, "CtrlFrame":U)
    CtrlFrame:NAME = "CtrlFrame":U
  .
  RUN initialize-controls IN THIS-PROCEDURE NO-ERROR.
END.
ELSE MESSAGE "c-abmclasearticulo.wrx":U SKIP(1)
             "The binary control file could not be found. The controls cannot be loaded."
             VIEW-AS ALERT-BOX TITLE "Controls Not Loaded".

&ENDIF

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE copiar_estructura C-Win 
PROCEDURE copiar_estructura :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

    DEFINE VARIABLE v-nodo_destino LIKE Clase_de_articulo.cdg_subclase.
    DEFINE VARIABLE v-lista_nodos  AS CHARACTER.
    DEFINE VARIABLE j-nodo         AS INTEGER.
    DEFINE VARIABLE p-ok           AS LOGICAL.

    RUN d-seleccionar_nodo_destino.w ( INPUT Clase_de_articulo.cdg_subclase,
                                       OUTPUT v-lista_nodos,
                                       OUTPUT p-ok).
    IF p-ok
    THEN DO:

        RUN poner_estado ( "Copiando estructura de un nodo a otro ..." ).

        DO TRANSACTION:

            DO j-nodo = 1 TO NUM-ENTRIES(v-lista_nodos,CHR(1)):
    
                v-nodo_destino = ENTRY(j-nodo,v-lista_nodos,CHR(1)).
                /*
                MESSAGE "Donde dice:" Clase_de_articulo.cdg_subclase SKIP
                        "debe ponerse:" v-nodo_destino
                        VIEW-AS ALERT-BOX INFO BUTTONS OK.
                */        
        
                FOR EACH B-Clase_de_articulo 
                    WHERE B-Clase_de_articulo.cdg_clase BEGINS Clase_de_articulo.cdg_subclase NO-LOCK:   
                
                    CREATE C-Clase_de_articulo.
                    BUFFER-COPY B-Clase_de_articulo TO C-Clase_de_articulo
                        ASSIGN C-Clase_de_articulo.cdg_clase    = REPLACE(B-Clase_de_articulo.cdg_clase,Clase_de_articulo.cdg_subclase,v-nodo_destino)
                               C-Clase_de_articulo.cdg_subclase = REPLACE(B-Clase_de_articulo.cdg_subclase,Clase_de_articulo.cdg_subclase,v-nodo_destino).
                   /*
                    MESSAGE "padre" SKIP
                            Clase_de_articulo.cdg_clase SKIP 
                            Clase_de_articulo.cdg_subclase SKIP(1)
                            "origen y destino" SKIP
                            B-Clase_de_articulo.cdg_clase " va a reemplazar por" REPLACE(B-Clase_de_articulo.cdg_clase,Clase_de_articulo.cdg_subclase,v-nodo_destino)        SKIP 
                            B-Clase_de_articulo.cdg_subclase " va a reemplazar por" REPLACE(B-Clase_de_articulo.cdg_subclase,Clase_de_articulo.cdg_subclase,v-nodo_destino) SKIP(1)
                            VIEW-AS ALERT-BOX INFO BUTTONS OK.
                    */
                    RELEASE C-Clase_de_articulo.
                END.
        
            
                RUN restaurar_estado.
            END.
        END.


    END.
    /*
    DO TRANSACTION:
        FIND CURRENT Clase_de_articulo EXCLUSIVE-LOCK.   
        RUN modificar_clasificacion.
        DISPLAY Clase_de_articulo.nombre_subclaseart
                WITH BROWSE brw_clasificacion.
   END.        
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

  DO ON ERROR UNDO, LEAVE:

      CREATE Clase_de_articulo.
      ASSIGN Clase_de_articulo.cdg_claseart = que_clase                                 
             Clase_de_articulo.cdg_subclaseart = que_clase + "." + que_subclase.
      RUN modificar_clasificacion.       

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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE eliminar_nodo C-Win 
PROCEDURE eliminar_nodo :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

   IF CAN-FIND(FIRST B-Clase_de_articulo WHERE B-Clase_de_articulo.cdg_claseart = Clase_de_articulo.cdg_subclaseart)
   THEN DO:
       RUN PONMENSJ.P (INPUT "CLAS001" ).
   END.    
   ELSE DO:                                                 
       DO TRANSACTION:
          FIND CURRENT Clase_de_articulo EXCLUSIVE-LOCK.   
          DELETE Clase_de_articulo.
       END.
       RUN ABRE_QUERY.
   END.    

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
  RUN control_load.
  DISPLAY que_subclase v-que_nombre que_clase camino 
      WITH FRAME DEFAULT-FRAME IN WINDOW C-Win.
  ENABLE que_subclase v-que_nombre brw_clasificacion camino btn_copist 
         btn_modificar btn_eliminar btn_vaciar btn_generar Btn_edquiv 
         Btn_Imprimir Btn_Elegir Btn_Salir 
      WITH FRAME DEFAULT-FRAME IN WINDOW C-Win.
  {&OPEN-BROWSERS-IN-QUERY-DEFAULT-FRAME}
  VIEW C-Win.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE generar_articulos C-Win 
PROCEDURE generar_articulos :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

    DEFINE VARIABLE p-ok           AS LOGICAL.
    
    RUN c-generar_articulos.w ( INPUT ROWID(Clase_de_articulo), OUTPUT p-ok).

    IF p-ok
        THEN MESSAGE "Los artículos han sido generados"
            VIEW-AS ALERT-BOX INFO BUTTONS OK.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE habilitar_botones C-Win 
PROCEDURE habilitar_botones :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

   IF AVAILABLE Clase_de_articulo
   THEN DO:
       btn_generar:SENSITIVE IN FRAME {&FRAME-NAME} = 
             CAN-FIND(FIRST B-Clase_de_articulo 
                      WHERE B-Clase_de_articulo.cdg_clase = Clase_de_articulo.cdg_subclase ).
       btn_vaciar:SENSITIVE IN FRAME {&FRAME-NAME} = 
             CAN-FIND(FIRST B-Clase_de_articulo 
                      WHERE B-Clase_de_articulo.cdg_clase = Clase_de_articulo.cdg_subclase ).
       btn_eliminar:SENSITIVE IN FRAME {&FRAME-NAME} = 
             NOT btn_vaciar:SENSITIVE IN FRAME {&FRAME-NAME}.
       btn_copist:SENSITIVE IN FRAME {&FRAME-NAME} = 
             CAN-FIND(FIRST B-Clase_de_articulo 
                      WHERE B-Clase_de_articulo.cdg_clase = Clase_de_articulo.cdg_subclase ).
       btn_modificar:SENSITIVE IN FRAME {&FRAME-NAME} = YES.
       btn_imprimir:SENSITIVE IN FRAME {&FRAME-NAME} = YES.
       btn_elegir:SENSITIVE IN FRAME {&FRAME-NAME} = YES.

   END.
   ELSE DO:
       btn_generar:SENSITIVE IN FRAME {&FRAME-NAME} = NO.
       btn_vaciar:SENSITIVE IN FRAME {&FRAME-NAME} = NO.
       btn_eliminar:SENSITIVE IN FRAME {&FRAME-NAME} = NO.
       btn_copist:SENSITIVE IN FRAME {&FRAME-NAME} = NO.
       btn_modificar:SENSITIVE IN FRAME {&FRAME-NAME} = NO.
       btn_imprimir:SENSITIVE IN FRAME {&FRAME-NAME} = NO.
       btn_elegir:SENSITIVE IN FRAME {&FRAME-NAME} = NO.
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

  RUN d-editar_nodo.w ( INPUT-OUTPUT Clase_de_articulo.nombre_subclaseart,
                        INPUT-OUTPUT Clase_de_articulo.rotulo_siguiente,
                        INPUT-OUTPUT Clase_de_articulo.longitud_siguiente,
                        INPUT-OUTPUT Clase_de_articulo.tipo_siguiente).

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE poner_estado C-Win 
PROCEDURE poner_estado :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

  DEFINE INPUT PARAMETER p-texto-estado AS CHARACTER.

  ASSIGN v-a_nombre = v-que_nombre
         v-que_nombre:FGCOLOR IN FRAME {&FRAME-NAME} = 15
         v-que_nombre:BGCOLOR IN FRAME {&FRAME-NAME} = 12
         v-que_nombre = p-texto-estado.

  DISPLAY v-que_nombre
      WITH FRAME {&FRAME-NAME}.


END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE restaurar_estado C-Win 
PROCEDURE restaurar_estado :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

  ASSIGN v-que_nombre:FGCOLOR IN FRAME {&FRAME-NAME} = 15
         v-que_nombre:BGCOLOR IN FRAME {&FRAME-NAME} = 7
         v-que_nombre = v-a_nombre.

  DISPLAY v-que_nombre
      WITH FRAME {&FRAME-NAME}.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE vaciar_estructura C-Win 
PROCEDURE vaciar_estructura :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/


   DEFINE VARIABLE c AS INTEGER.

   si_no = NO.
   MESSAGE "Si vacia este nodo, se eliminarán todos los niveles inferiores asociados. Desea proseguir"
           VIEW-AS ALERT-BOX QUESTION BUTTONS YES-NO TITLE "Confirmación" UPDATE si_no.

   IF si_no
   THEN DO:        
       RUN poner_estado ( "Borrando estructura ..." ).
       DO TRANSACTION:
          c = 0.
          FOR EACH B-Clase_de_articulo 
              WHERE B-Clase_de_articulo.cdg_clase BEGINS Clase_de_articulo.cdg_subclase EXCLUSIVE-LOCK:   

              DELETE B-Clase_de_articulo.
              c = c + 1.

          END.
       END.
       MESSAGE "Eliminados " c "registros"
           VIEW-AS ALERT-BOX INFO BUTTONS OK.
       RUN restaurar_estado.
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

