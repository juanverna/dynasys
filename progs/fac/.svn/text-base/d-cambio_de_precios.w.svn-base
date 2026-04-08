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
&Scoped-Define ENABLED-OBJECTS v-desde_lista v-fecha_vigencia v-prc_cambio ~
btn_cambiar Btn_Cancel RECT-3 
&Scoped-Define DISPLAYED-OBJECTS v-desde_lista v-nom_desde v-fecha_vigencia ~
v-prc_cambio 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME



/* ***********************  Control Definitions  ********************** */

/* Define a dialog box                                                  */

/* Definitions of the field level widgets                               */
DEFINE BUTTON btn_cambiar 
     LABEL "Cambiar" 
     SIZE 15 BY 1.14.

DEFINE BUTTON Btn_Cancel AUTO-END-KEY 
     LABEL "Salir" 
     SIZE 15 BY 1.14
     BGCOLOR 8 .

DEFINE VARIABLE v-desde_lista AS INTEGER FORMAT "->,>>>,>>9":U INITIAL 0 
     LABEL "Lista" 
     VIEW-AS FILL-IN 
     SIZE 15 BY 1
     BGCOLOR 14 FGCOLOR 12 FONT 5 NO-UNDO.

DEFINE VARIABLE v-fecha_vigencia AS DATE FORMAT "99/99/9999":U 
     LABEL "Vigencia" 
     VIEW-AS FILL-IN NATIVE 
     SIZE 15 BY 1
     BGCOLOR 15 FGCOLOR 9 FONT 5 NO-UNDO.

DEFINE VARIABLE v-nom_desde AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 45 BY 1
     BGCOLOR 5 FGCOLOR 15 FONT 5 NO-UNDO.

DEFINE VARIABLE v-prc_cambio AS DECIMAL FORMAT "->>>9.99":U INITIAL 0 
     LABEL "% Variación" 
     VIEW-AS FILL-IN NATIVE 
     SIZE 15 BY 1
     BGCOLOR 15 FGCOLOR 9 FONT 5 NO-UNDO.

DEFINE RECTANGLE RECT-3
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL 
     SIZE 75 BY 5.38.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME Dialog-Frame
     v-desde_lista AT ROW 2.1 COL 13 COLON-ALIGNED
     v-nom_desde AT ROW 2.1 COL 29 COLON-ALIGNED NO-LABEL
     v-fecha_vigencia AT ROW 3.43 COL 13 COLON-ALIGNED
     v-prc_cambio AT ROW 3.43 COL 59 COLON-ALIGNED
     btn_cambiar AT ROW 4.76 COL 15
     Btn_Cancel AT ROW 4.76 COL 61
     RECT-3 AT ROW 1.29 COL 2
     SPACE(1.28) SKIP(0.28)
    WITH VIEW-AS DIALOG-BOX KEEP-TAB-ORDER 
         SIDE-LABELS NO-UNDERLINE THREE-D  SCROLLABLE 
         TITLE "Cambio Masivo de Precios"
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
/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME Dialog-Frame
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Dialog-Frame Dialog-Frame
ON WINDOW-CLOSE OF FRAME Dialog-Frame /* Cambio Masivo de Precios */
DO:
  APPLY "END-ERROR":U TO SELF.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btn_cambiar
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btn_cambiar Dialog-Frame
ON CHOOSE OF btn_cambiar IN FRAME Dialog-Frame /* Cambiar */
DO:
  DEFINE VARIABLE a-tit AS CHARACTER.
  a-tit = FRAME {&FRAME-NAME}:TITLE.
  FRAME {&FRAME-NAME}:TITLE = "Cambiando precios ...".
  ASSIGN v-desde_lista v-prc_cambio v-fecha_vigencia.
  RUN cambiar_precios.
  DISPLAY " " @ v-desde_lista
          " " @ v-nom_desde
          WITH FRAME {&FRAME-NAME}.
  FRAME {&FRAME-NAME}:TITLE = a-tit.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME v-desde_lista
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-desde_lista Dialog-Frame
ON LEAVE OF v-desde_lista IN FRAME Dialog-Frame /* Lista */
DO:
  ASSIGN v-desde_lista.
  FIND Lista_precios WHERE Lista_precios.cdg_lista = v-desde_lista NO-LOCK NO-ERROR.
  IF NOT AVAILABLE Lista_precios
  THEN DO:
      RUN ponmensj.p ( INPUT "LPE001").
      RETURN NO-APPLY.
  END.
  ELSE DO:
      IF NOT CAN-DO(Lista_precios.lista_empresa,Empresa.cdg_empresa)
      THEN DO:
          RUN ponmensj.p ( INPUT "LPE002").
          RETURN NO-APPLY.
      END.
      ELSE DO:
           v-nom_desde = Lista_precios.descripcion.
           DISPLAY v-nom_desde 
             WITH FRAME {&FRAME-NAME}.
      END.
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
  v-fecha_vigencia = TODAY + 1.

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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE cambiar_precios Dialog-Frame 
PROCEDURE cambiar_precios :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

  DO TRANSACTION:

     FOR EACH Articulo_precio WHERE Articulo_precio.cdg_empresa = Empresa.cdg_empresa 
                                AND Articulo_precio.cdg_lista   = v-desde_lista
                                AND Articulo_precio.fch_desde   = v-fecha_vigencia
                                    EXCLUSIVE-LOCK:

         ASSIGN
            Articulo_precio.precio    = Articulo_precio.precio * ( 1 + v-prc_cambio / 100.0 )
            Articulo_precio.precio_cf = Articulo_precio.precio_cf * ( 1 + v-prc_cambio / 100.0 ).
 
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
  DISPLAY v-desde_lista v-nom_desde v-fecha_vigencia v-prc_cambio 
      WITH FRAME Dialog-Frame.
  ENABLE v-desde_lista v-fecha_vigencia v-prc_cambio btn_cambiar Btn_Cancel 
         RECT-3 
      WITH FRAME Dialog-Frame.
  VIEW FRAME Dialog-Frame.
  {&OPEN-BROWSERS-IN-QUERY-Dialog-Frame}
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

