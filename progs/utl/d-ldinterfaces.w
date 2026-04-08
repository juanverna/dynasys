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

DEFINE VARIABLE fecha_inicial AS DATE.
DEFINE VARIABLE fecha_elegida AS DATE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE DIALOG-BOX
&Scoped-define DB-AWARE no

/* Name of first Frame and/or Browse and/or first Query                 */
&Scoped-define FRAME-NAME Dialog-Frame

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS v-archivo v-has_fecha btn_proceso Btn_OK ~
RECT-5 
&Scoped-Define DISPLAYED-OBJECTS v-estado v-archivo v-has_fecha 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME



/* ***********************  Control Definitions  ********************** */

/* Define a dialog box                                                  */

/* Definitions of the field level widgets                               */
DEFINE BUTTON Btn_OK AUTO-GO 
     LABEL "Salir" 
     SIZE 21 BY 1.29
     BGCOLOR 8 .

DEFINE BUTTON btn_proceso 
     LABEL "&Procesar" 
     SIZE 21 BY 1.29
     FONT 6.

DEFINE VARIABLE v-archivo AS CHARACTER FORMAT "X(256)":U 
     LABEL "Interface" 
     VIEW-AS COMBO-BOX INNER-LINES 5
     LIST-ITEM-PAIRS "[Seleccione el proceso]","ZZZ",
                     "Remitos de Carga y Abastecimiento","CYA",
                     "Cuentas por Cobrar","CXC",
                     "Acreditación de Valores","TES"
     DROP-DOWN-LIST
     SIZE 46 BY 1 NO-UNDO.

DEFINE VARIABLE v-estado AS CHARACTER FORMAT "X(256)":U 
     LABEL "Estado" 
     VIEW-AS FILL-IN 
     SIZE 46 BY 1
     BGCOLOR 2 FGCOLOR 14 FONT 6 NO-UNDO.

DEFINE VARIABLE v-has_fecha AS DATE FORMAT "99/99/9999":U 
     LABEL "Fecha Proceso" 
     VIEW-AS FILL-IN NATIVE 
     SIZE 16 BY 1
     BGCOLOR 15 FGCOLOR 9 FONT 6 NO-UNDO.

DEFINE RECTANGLE RECT-5
     EDGE-PIXELS 4 GRAPHIC-EDGE  NO-FILL 
     SIZE 68 BY 8.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME Dialog-Frame
     v-estado AT ROW 2.43 COL 14 COLON-ALIGNED
     v-archivo AT ROW 4.05 COL 14 COLON-ALIGNED
     v-has_fecha AT ROW 5.67 COL 44 COLON-ALIGNED
     btn_proceso AT ROW 7.67 COL 11
     Btn_OK AT ROW 7.67 COL 41
     RECT-5 AT ROW 1.81 COL 3
     SPACE(1.99) SKIP(0.61)
    WITH VIEW-AS DIALOG-BOX KEEP-TAB-ORDER 
         SIDE-LABELS NO-UNDERLINE THREE-D  SCROLLABLE 
         TITLE "Lectura y Carga de Interfaces"
         DEFAULT-BUTTON Btn_OK.


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

/* SETTINGS FOR FILL-IN v-estado IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME Dialog-Frame
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Dialog-Frame Dialog-Frame
ON WINDOW-CLOSE OF FRAME Dialog-Frame /* Lectura y Carga de Interfaces */
DO:
  APPLY "END-ERROR":U TO SELF.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btn_proceso
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btn_proceso Dialog-Frame
ON CHOOSE OF btn_proceso IN FRAME Dialog-Frame /* Procesar */
DO:

  DO WITH FRAME {&FRAME-NAME}:
    ASSIGN v-archivo v-has_fecha.

    IF v-archivo = "ZZZ"
    THEN DO:
        MESSAGE "Seleccione un proceso a ejecutar" VIEW-AS ALERT-BOX MESSAGE.
        RETURN NO-APPLY.
    END.
    ELSE DO:

        CASE v-archivo:
            WHEN "CYA"  /* Carga Remitos */ 
            THEN DO: 
                v-estado:SCREEN-VALUE = "Cargando Interface de Remitos ...".
                v-estado:BGCOLOR = 12.
                RUN ldintersuc_rem.p. 

            END.

            WHEN "CXC" /* Carga cuentas por cobrar */
            THEN DO:
                v-estado:SCREEN-VALUE = "Cargando Interface de Caja ...".
                v-estado:BGCOLOR = 12.
                RUN ldintersuc_caj.p. 

            END.
            WHEN "TES" /* Marca cheques acreditados */
            THEN DO: 
                v-estado:SCREEN-VALUE = "Acreditando valores del día ...".
                v-estado:BGCOLOR = 12.
                RUN acredita_todos.p. 
            END.
/*             WHEN "FAC" /* Marca cheques acreditados */                         */
/*             THEN DO:                                                           */
/*                 v-estado:SCREEN-VALUE = "Cargando Interface de Artículos ...". */
/*                 v-estado:BGCOLOR = 12.                                         */
/*                 RUN ldintersuc_art.p.                                          */
/*             END.                                                               */
        END CASE.
    END.

    v-estado:SCREEN-VALUE = "Proceso Terminado.".
    v-estado:BGCOLOR = 2.

  END.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME v-has_fecha
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-has_fecha Dialog-Frame
ON MOUSE-MENU-DOWN OF v-has_fecha IN FRAME Dialog-Frame /* Fecha Proceso */
DO:
    {helpfecha.i "v-has_fecha"}
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&UNDEFINE SELF-NAME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _MAIN-BLOCK Dialog-Frame 


/* ***************************  Main Block  *************************** */

/* Parent the dialog-box to the ACTIVE-WINDOW, if there is no parent.   */
IF VALID-HANDLE(ACTIVE-WINDOW) AND FRAME {&FRAME-NAME}:PARENT eq ?
THEN FRAME {&FRAME-NAME}:PARENT = ACTIVE-WINDOW.

v-archivo = "ZZZ".
v-has_fecha = TODAY.
/* Now enable the interface and wait for the exit condition.            */
/* (NOTE: handle ERROR and END-KEY so cleanup code will always fire.    */
MAIN-BLOCK:
DO ON ERROR   UNDO MAIN-BLOCK, LEAVE MAIN-BLOCK
   ON END-KEY UNDO MAIN-BLOCK, LEAVE MAIN-BLOCK:
  RUN enable_UI.
    v-estado:SCREEN-VALUE IN FRAME {&FRAME-NAME} = "Ingresando Parámetros...".
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
  DISPLAY v-estado v-archivo v-has_fecha 
      WITH FRAME Dialog-Frame.
  ENABLE v-archivo v-has_fecha btn_proceso Btn_OK RECT-5 
      WITH FRAME Dialog-Frame.
  VIEW FRAME Dialog-Frame.
  {&OPEN-BROWSERS-IN-QUERY-Dialog-Frame}
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

