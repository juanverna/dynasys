&ANALYZE-SUSPEND _VERSION-NUMBER UIB_v9r12 GUI
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
/*          This .W file was created with the Progress AppBuilder.       */
/*----------------------------------------------------------------------*/

/* ***************************  Definitions  ************************** */

/* Parameters Definitions ---                                           */

/* Local Variable Definitions ---                                       */

DEFINE VARIABLE rid_tabla AS ROWID.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE Dialog-Box
&Scoped-define DB-AWARE no

/* Name of first Frame and/or Browse and/or first Query                 */
&Scoped-define FRAME-NAME Dialog-Frame

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS btn_generar v-cdg_proveedor Btn_Cancel ~
v-cdg_familia_articulo 
&Scoped-Define DISPLAYED-OBJECTS v-cdg_proveedor v-dsc_proveedor ~
v-cdg_familia_articulo v-dsc_familia_articulo 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME



/* ***********************  Control Definitions  ********************** */

/* Define a dialog box                                                  */

/* Definitions of the field level widgets                               */
DEFINE BUTTON Btn_Cancel AUTO-END-KEY 
     LABEL "Salir" 
     SIZE 15 BY 1.14
     BGCOLOR 8 .

DEFINE BUTTON btn_generar 
     LABEL "&Generar" 
     SIZE 15 BY 1.14.

DEFINE VARIABLE v-cdg_familia_articulo AS CHARACTER FORMAT "X(8)" 
     LABEL "F.Contable" 
     VIEW-AS FILL-IN 
     SIZE 15 BY 1
     BGCOLOR 15 FGCOLOR 9 .

DEFINE VARIABLE v-cdg_proveedor AS CHARACTER FORMAT "X(8)" 
     LABEL "Proveedor" 
     VIEW-AS FILL-IN 
     SIZE 15 BY 1
     BGCOLOR 15 FGCOLOR 9 .

DEFINE VARIABLE v-dsc_familia_articulo AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 60 BY 1
     BGCOLOR 7 FGCOLOR 15  NO-UNDO.

DEFINE VARIABLE v-dsc_proveedor AS CHARACTER FORMAT "X(40)" 
     VIEW-AS FILL-IN 
     SIZE 60 BY 1
     BGCOLOR 7 FGCOLOR 15 .


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME Dialog-Frame
     btn_generar AT ROW 1.48 COL 95
     v-cdg_proveedor AT ROW 2.67 COL 14 COLON-ALIGNED
     v-dsc_proveedor AT ROW 2.67 COL 30 COLON-ALIGNED NO-LABEL
     Btn_Cancel AT ROW 2.95 COL 95
     v-cdg_familia_articulo AT ROW 5.29 COL 14 COLON-ALIGNED
     v-dsc_familia_articulo AT ROW 5.29 COL 30 COLON-ALIGNED NO-LABEL
     "    Identificación del proveedor cuyos artículos desean generarse" VIEW-AS TEXT
          SIZE 88 BY 1 AT ROW 1.48 COL 4
          BGCOLOR 5 FGCOLOR 15 
     "    Familia contable a asignar a los articulos" VIEW-AS TEXT
          SIZE 88 BY 1 AT ROW 4.1 COL 4
          BGCOLOR 5 FGCOLOR 15 
     SPACE(20.59) SKIP(1.46)
    WITH VIEW-AS DIALOG-BOX KEEP-TAB-ORDER 
         SIDE-LABELS NO-UNDERLINE THREE-D  SCROLLABLE 
         TITLE "Crear Articulos-Funcionarios"
         CANCEL-BUTTON Btn_Cancel.


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
/* SETTINGS FOR DIALOG-BOX Dialog-Frame
                                                                        */
ASSIGN 
       FRAME Dialog-Frame:SCROLLABLE       = FALSE
       FRAME Dialog-Frame:HIDDEN           = TRUE.

/* SETTINGS FOR FILL-IN v-dsc_familia_articulo IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN v-dsc_proveedor IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME Dialog-Frame
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Dialog-Frame Dialog-Frame
ON WINDOW-CLOSE OF FRAME Dialog-Frame /* Crear Articulos-Funcionarios */
DO:
  APPLY "END-ERROR":U TO SELF.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME v-cdg_familia_articulo
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-cdg_familia_articulo Dialog-Frame
ON MOUSE-SELECT-DBLCLICK OF v-cdg_familia_articulo IN FRAME Dialog-Frame /* F.Contable */
OR "." OF v-cdg_familia_articulo IN FRAME {&FRAME-NAME}
OR MOUSE-MENU-DOWN OF v-cdg_familia_articulo IN FRAME {&FRAME-NAME}
DO:

   {helptabla.i "Familia_articulo" "cdg_familia" "SELFAMAR.P"}
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-cdg_familia_articulo Dialog-Frame
ON RETURN OF v-cdg_familia_articulo IN FRAME Dialog-Frame /* F.Contable */
DO:
    {traducetabla.i "Familia_articulo" "cdg_familia" "dsc_familia"} 
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME v-cdg_proveedor
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-cdg_proveedor Dialog-Frame
ON MOUSE-SELECT-DBLCLICK OF v-cdg_proveedor IN FRAME Dialog-Frame /* Proveedor */
OR "." OF v-cdg_proveedor IN FRAME {&FRAME-NAME}
OR MOUSE-MENU-DOWN OF v-cdg_proveedor IN FRAME {&FRAME-NAME}
DO:

   {helptabla.i "proveedor" "cdg_proveedor" "SELPROVE.P"}
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-cdg_proveedor Dialog-Frame
ON RETURN OF v-cdg_proveedor IN FRAME Dialog-Frame /* Proveedor */
DO:
   {traducetabla.i "proveedor" "cdg_proveedor" "nombre"} 
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&UNDEFINE SELF-NAME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _MAIN-BLOCK Dialog-Frame 


/* ***************************  Main Block  *************************** */

/* Parent the dialog-box to the ACTIVE-WINDOW, if there is no parent.   */
IF VALID-HANDLE(ACTIVE-WINDOW) AND FRAME {&FRAME-NAME}:PARENT eq ?
THEN FRAME {&FRAME-NAME}:PARENT = ACTIVE-WINDOW.


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
  DISPLAY v-cdg_proveedor v-dsc_proveedor v-cdg_familia_articulo 
          v-dsc_familia_articulo 
      WITH FRAME Dialog-Frame.
  ENABLE btn_generar v-cdg_proveedor Btn_Cancel v-cdg_familia_articulo 
      WITH FRAME Dialog-Frame.
  VIEW FRAME Dialog-Frame.
  {&OPEN-BROWSERS-IN-QUERY-Dialog-Frame}
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

