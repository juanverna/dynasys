&ANALYZE-SUSPEND _VERSION-NUMBER UIB_v8r12 GUI
&ANALYZE-RESUME
&Scoped-define WINDOW-NAME CURRENT-WINDOW
&Scoped-define FRAME-NAME Dialog-Frame
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _DEFINITIONS Dialog-Frame 
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

/* ***************************  Definitions  ************************** */

/* Parameters Definitions ---                                           */

/* Local Variable Definitions ---                                       */

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE DIALOG-BOX
&Scoped-define DB-AWARE no

/* Name of first Frame and/or Browse and/or first Query                 */
&Scoped-define FRAME-NAME Dialog-Frame

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS v-desde_lista v-desde_fecha v-hasta_lista ~
v-hasta_fecha btn_copiar Btn_Cancel v-has_empresa RECT-3 
&Scoped-Define DISPLAYED-OBJECTS v-desde_lista v-nom_desde v-desde_fecha ~
v-hasta_lista v-nom_hasta v-hasta_fecha v-has_empresa 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME



/* ***********************  Control Definitions  ********************** */

/* Define a dialog box                                                  */

/* Definitions of the field level widgets                               */
DEFINE BUTTON Btn_Cancel AUTO-END-KEY 
     LABEL "Salir" 
     SIZE 16 BY 1.14
     BGCOLOR 8 .

DEFINE BUTTON btn_copiar 
     LABEL "Copiar" 
     SIZE 16 BY 1.14.

DEFINE VARIABLE v-desde_fecha AS DATE FORMAT "99/99/9999":U 
     VIEW-AS FILL-IN NATIVE 
     SIZE 16 BY 1
     BGCOLOR 15 FGCOLOR 9 FONT 6 NO-UNDO.

DEFINE VARIABLE v-desde_lista AS INTEGER FORMAT "->,>>>,>>9":U INITIAL 0 
     LABEL "Desde Lista" 
     VIEW-AS FILL-IN 
     SIZE 15 BY 1
     BGCOLOR 14 FGCOLOR 12 FONT 5 NO-UNDO.

DEFINE VARIABLE v-hasta_fecha AS DATE FORMAT "99/99/9999":U 
     VIEW-AS FILL-IN NATIVE 
     SIZE 16 BY 1
     BGCOLOR 15 FGCOLOR 9 FONT 6 NO-UNDO.

DEFINE VARIABLE v-hasta_lista AS INTEGER FORMAT "->,>>>,>>9":U INITIAL 0 
     LABEL "Hasta Lista" 
     VIEW-AS FILL-IN 
     SIZE 15 BY 1
     BGCOLOR 14 FGCOLOR 12 FONT 5 NO-UNDO.

DEFINE VARIABLE v-has_empresa AS CHARACTER FORMAT "X(256)":U 
     LABEL "Empresa" 
     VIEW-AS FILL-IN 
     SIZE 15 BY 1
     BGCOLOR 14 FGCOLOR 12 FONT 6 NO-UNDO.

DEFINE VARIABLE v-nom_desde AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 39 BY 1
     BGCOLOR 5 FGCOLOR 15 FONT 5 NO-UNDO.

DEFINE VARIABLE v-nom_hasta AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 39 BY 1
     BGCOLOR 5 FGCOLOR 15 FONT 5 NO-UNDO.

DEFINE RECTANGLE RECT-3
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL 
     SIZE 90 BY 5.91.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME Dialog-Frame
     v-desde_lista AT ROW 1.95 COL 14 COLON-ALIGNED
     v-nom_desde AT ROW 1.95 COL 30 COLON-ALIGNED NO-LABEL
     v-desde_fecha AT ROW 1.95 COL 70 COLON-ALIGNED NO-LABEL
     v-hasta_lista AT ROW 3.57 COL 14 COLON-ALIGNED
     v-nom_hasta AT ROW 3.57 COL 30 COLON-ALIGNED NO-LABEL
     v-hasta_fecha AT ROW 3.57 COL 70 COLON-ALIGNED NO-LABEL
     btn_copiar AT ROW 5.14 COL 55
     Btn_Cancel AT ROW 5.14 COL 72
     v-has_empresa AT ROW 5.19 COL 14 COLON-ALIGNED
     RECT-3 AT ROW 1.29 COL 2
     SPACE(0.79) SKIP(0.22)
    WITH VIEW-AS DIALOG-BOX KEEP-TAB-ORDER 
         SIDE-LABELS NO-UNDERLINE THREE-D  SCROLLABLE 
         TITLE "Copiar precios entre listas"
         CANCEL-BUTTON Btn_Cancel.


/* *********************** Procedure Settings ************************ */

&ANALYZE-SUSPEND _PROCEDURE-SETTINGS
/* Settings for THIS-PROCEDURE
   Type: DIALOG-BOX
   Allow: Basic,Browse,DB-Fields,Query
   Other Settings: COMPILE
 */
&ANALYZE-RESUME _END-PROCEDURE-SETTINGS



/* ***********  Runtime Attributes and AppBuilder Settings  *********** */

&ANALYZE-SUSPEND _RUN-TIME-ATTRIBUTES
/* SETTINGS FOR DIALOG-BOX Dialog-Frame
                                                                        */
ASSIGN 
       FRAME Dialog-Frame:SCROLLABLE       = FALSE
       FRAME Dialog-Frame:HIDDEN           = TRUE.

/* SETTINGS FOR FILL-IN v-nom_desde IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN v-nom_hasta IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME Dialog-Frame
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Dialog-Frame Dialog-Frame
ON WINDOW-CLOSE OF FRAME Dialog-Frame /* Copiar precios entre listas */
DO:
  APPLY "END-ERROR":U TO SELF.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btn_copiar
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btn_copiar Dialog-Frame
ON CHOOSE OF btn_copiar IN FRAME Dialog-Frame /* Copiar */
DO:
  DEFINE VARIABLE a-tit AS CHARACTER.
  ASSIGN FRAME {&FRAME-NAME} v-desde_lista v-hasta_lista v-has_empresa v-desde_fecha v-hasta_fecha.
  
  FIND Lista_precios WHERE Lista_precios.cdg_lista = v-desde_lista NO-LOCK NO-ERROR.
  IF NOT AVAILABLE Lista_precios
  THEN DO:
       RUN ponmensj.p ( "LPRE011").
       RETURN NO-APPLY.
  END.
  v-nom_desde = Lista_precios.descripcion.
  DISPLAY v-nom_desde 
          WITH FRAME {&FRAME-NAME}.

  FIND Lista_precios WHERE Lista_precios.cdg_lista = v-hasta_lista NO-LOCK NO-ERROR.
  IF NOT AVAILABLE Lista_precios
  THEN DO:
       RUN ponmensj.p ( "LPRE012").
       RETURN NO-APPLY.
  END.
  v-nom_hasta = Lista_precios.descripcion.
  DISPLAY v-nom_hasta 
          WITH FRAME {&FRAME-NAME}.

  IF v-desde_fecha = DATE("") OR v-hasta_fecha = DATE("")
  THEN DO:
      RUN ponmensj.p ( INPUT "LPRE008").
      RETURN NO-APPLY.
  END.

  IF NOT CAN-FIND(FIRST Vigencia_precios WHERE Vigencia_precios.cdg_lista = v-desde_lista 
                                           AND Vigencia_precios.fch_desde = v-desde_fecha)
  THEN DO:
      RUN ponmensj.p ( "LPRE007").
      RETURN NO-APPLY.
  END.

  a-tit = FRAME {&FRAME-NAME}:TITLE.
  FRAME {&FRAME-NAME}:TITLE = "Copiando precios ...".      
  RUN copiar_precios.
  DISPLAY " " @ v-desde_lista
          " " @ v-hasta_lista
          " " @ v-nom_desde
          " " @ v-nom_hasta
          Empresa.cdg_empresa @ v-has_empresa
          WITH FRAME {&FRAME-NAME}.
  FRAME {&FRAME-NAME}:TITLE = a-tit.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME v-desde_lista
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-desde_lista Dialog-Frame
ON LEAVE OF v-desde_lista IN FRAME Dialog-Frame /* Desde Lista */
DO:
    ASSIGN v-desde_lista.
    FIND Lista_precios WHERE Lista_precios.cdg_lista = v-desde_lista NO-LOCK NO-ERROR.
    IF AVAILABLE Lista_precios
    THEN DO:
        v-nom_desde = Lista_precios.descripcion.
        DISPLAY v-nom_desde 
                WITH FRAME {&FRAME-NAME}.
    END.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME v-hasta_lista
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-hasta_lista Dialog-Frame
ON LEAVE OF v-hasta_lista IN FRAME Dialog-Frame /* Hasta Lista */
DO:
  ASSIGN v-hasta_lista.
  FIND Lista_precios WHERE Lista_precios.cdg_lista = v-hasta_lista NO-LOCK NO-ERROR.
  IF AVAILABLE Lista_precios
  THEN DO:
      v-nom_hasta = Lista_precios.descripcion.
      DISPLAY v-nom_hasta 
              WITH FRAME {&FRAME-NAME}.
  END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&UNDEFINE SELF-NAME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _MAIN-BLOCK Dialog-Frame 


/* ***************************  Main Block  *************************** */

/* Parent the dialog-box to the ACTIVE-WINDOW, if there is no parent.   */
IF VALID-HANDLE(ACTIVE-WINDOW) AND FRAME {&FRAME-NAME}:PARENT eq ?
THEN FRAME {&FRAME-NAME}:PARENT = ACTIVE-WINDOW.

  {findempresa.i}
  v-has_empresa = Empresa.cdg_empresa.

/* Now enable the interface and wait for the exit condition.            */
/* (NOTE: handle ERROR and END-KEY so cleanup code will always fire.    */
MAIN-BLOCK:
DO ON ERROR   UNDO MAIN-BLOCK, LEAVE MAIN-BLOCK
   ON END-KEY UNDO MAIN-BLOCK, LEAVE MAIN-BLOCK:
  RUN enable_UI.
  WAIT-FOR GO OF FRAME {&FRAME-NAME}.
END.
RUN disable_UI.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


/* **********************  Internal Procedures  *********************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE copiar_precios Dialog-Frame 
PROCEDURE copiar_precios :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

  DEFINE BUFFER B-Articulo_precio FOR Articulo_precio.

  DO TRANSACTION:

     {findempresa.i}

     FIND Vigencia_precios WHERE Vigencia_precios.cdg_lista = v-hasta_lista
                             AND Vigencia_precios.fch_desde = v-hasta_fecha
                             AND Vigencia_precios.cdg_empresa = Empresa.cdg_empresa
                                 EXCLUSIVE-LOCK NO-ERROR.
     IF NOT AVAILABLE Vigencia_precios
     THEN DO:
          CREATE Vigencia_precios.
          ASSIGN Vigencia_precios.cdg_lista = v-hasta_lista          
                 Vigencia_precios.fch_desde = v-hasta_fecha          
                 Vigencia_precios.cdg_empresa = Empresa.cdg_empresa.  
     END.

     FOR EACH Articulo_precio WHERE Articulo_precio.cdg_empresa = Empresa.cdg_empresa
                                AND Articulo_precio.cdg_lista   = v-desde_lista
                                AND Articulo_precio.fch_desde   = v-desde_fecha
                                    NO-LOCK:

         FIND B-Articulo_precio
              WHERE B-Articulo_precio.cdg_empresa  = v-has_empresa
                AND B-Articulo_precio.nro_articulo = Articulo_precio.nro_articulo
                AND B-Articulo_precio.cdg_lista    = v-hasta_lista
                AND B-Articulo_precio.fch_desde    = v-hasta_fecha
                    EXCLUSIVE-LOCK NO-ERROR.
         IF NOT AVAILABLE B-Articulo_precio
         THEN DO:
              CREATE B-Articulo_precio.
              ASSIGN B-Articulo_precio.cdg_empresa  = v-has_empresa
                     B-Articulo_precio.nro_articulo = Articulo_precio.nro_articulo
                     B-Articulo_precio.cdg_lista    = v-hasta_lista
                     B-Articulo_precio.fch_desde    = v-hasta_fecha.
         END.           
         ASSIGN
            B-Articulo_precio.precio    = Articulo_precio.precio
            B-Articulo_precio.precio_cf = Articulo_precio.precio_cf.
 
     END.

  END.
  
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE disable_UI Dialog-Frame  _DEFAULT-DISABLE
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
  HIDE FRAME Dialog-Frame.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE enable_UI Dialog-Frame  _DEFAULT-ENABLE
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
  DISPLAY v-desde_lista v-nom_desde v-desde_fecha v-hasta_lista v-nom_hasta 
          v-hasta_fecha v-has_empresa 
      WITH FRAME Dialog-Frame.
  ENABLE v-desde_lista v-desde_fecha v-hasta_lista v-hasta_fecha btn_copiar 
         Btn_Cancel v-has_empresa RECT-3 
      WITH FRAME Dialog-Frame.
  VIEW FRAME Dialog-Frame.
  {&OPEN-BROWSERS-IN-QUERY-Dialog-Frame}
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

