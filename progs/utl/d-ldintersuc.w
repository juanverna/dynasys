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

/* Name of first Frame and/or Browse and/or first Query                 */
&Scoped-define FRAME-NAME Dialog-Frame

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS RECT-5 RECT-6 x-marca x-dsp v-archivo x-fac ~
x-cxc v-has_fecha x-tes x-inv x-COM btn_proceso Btn_OK 
&Scoped-Define DISPLAYED-OBJECTS v-estado x-marca x-dsp v-archivo x-fac ~
x-cxc v-has_fecha x-tes x-inv x-COM 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME



/* ***********************  Control Definitions  ********************** */

/* Define a dialog box                                                  */

/* Definitions of the field level widgets                               */
DEFINE BUTTON Btn_OK AUTO-GO 
     LABEL "Salir" 
     SIZE 14 BY 1.15
     BGCOLOR 8 .

DEFINE BUTTON btn_proceso 
     LABEL "&Procesar" 
     SIZE 14 BY 1.12
     FONT 6.

DEFINE VARIABLE v-archivo AS CHARACTER FORMAT "X(256)":U 
     LABEL "Sucursal" 
     VIEW-AS COMBO-BOX INNER-LINES 5
     LIST-ITEMS " "
     SIZE 46 BY 1 NO-UNDO.

DEFINE VARIABLE v-estado AS CHARACTER FORMAT "X(256)":U 
     LABEL "Estado" 
     VIEW-AS FILL-IN 
     SIZE 46 BY .81
     BGCOLOR 2 FGCOLOR 14 FONT 6 NO-UNDO.

DEFINE VARIABLE v-has_fecha AS DATE FORMAT "99/99/9999":U 
     LABEL "Hasta Fecha" 
     VIEW-AS FILL-IN NATIVE 
     SIZE 14 BY .81
     BGCOLOR 15 FGCOLOR 9 FONT 6 NO-UNDO.

DEFINE RECTANGLE RECT-5
     EDGE-PIXELS 4 GRAPHIC-EDGE  NO-FILL 
     SIZE 68 BY 9.96.

DEFINE RECTANGLE RECT-6
     EDGE-PIXELS 4 GRAPHIC-EDGE  NO-FILL 
     SIZE 18 BY 10.

DEFINE VARIABLE x-COM AS LOGICAL INITIAL no 
     LABEL "COM" 
     VIEW-AS TOGGLE-BOX
     SIZE 7 BY .77 NO-UNDO.

DEFINE VARIABLE x-cxc AS LOGICAL INITIAL no 
     LABEL "CXC" 
     VIEW-AS TOGGLE-BOX
     SIZE 7 BY .77 NO-UNDO.

DEFINE VARIABLE x-dsp AS LOGICAL INITIAL no 
     LABEL "DSP" 
     VIEW-AS TOGGLE-BOX
     SIZE 7 BY .77 NO-UNDO.

DEFINE VARIABLE x-fac AS LOGICAL INITIAL no 
     LABEL "FAC" 
     VIEW-AS TOGGLE-BOX
     SIZE 7 BY .77 NO-UNDO.

DEFINE VARIABLE x-inv AS LOGICAL INITIAL no 
     LABEL "INV" 
     VIEW-AS TOGGLE-BOX
     SIZE 7 BY .77 NO-UNDO.

DEFINE VARIABLE x-marca AS LOGICAL INITIAL no 
     LABEL "Marca Mov." 
     VIEW-AS TOGGLE-BOX
     SIZE 14 BY .77 NO-UNDO.

DEFINE VARIABLE x-tes AS LOGICAL INITIAL no 
     LABEL "TES" 
     VIEW-AS TOGGLE-BOX
     SIZE 7 BY .77 NO-UNDO.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME Dialog-Frame
     v-estado AT ROW 2.62 COL 21 COLON-ALIGNED
     x-marca AT ROW 3.77 COL 73
     x-dsp AT ROW 4.77 COL 75
     v-archivo AT ROW 5.27 COL 21 COLON-ALIGNED
     x-fac AT ROW 5.77 COL 75
     x-cxc AT ROW 6.77 COL 75
     v-has_fecha AT ROW 7.46 COL 53 COLON-ALIGNED
     x-tes AT ROW 7.77 COL 75
     x-inv AT ROW 8.77 COL 75
     x-COM AT ROW 9.77 COL 75
     btn_proceso AT ROW 10.15 COL 23
     Btn_OK AT ROW 10.15 COL 55
     RECT-5 AT ROW 2 COL 3
     RECT-6 AT ROW 2 COL 71
     "Procesar" VIEW-AS TEXT
          SIZE 8 BY .62 AT ROW 2.77 COL 74
     SPACE(10.56) SKIP(9.41)
    WITH VIEW-AS DIALOG-BOX KEEP-TAB-ORDER 
         SIDE-LABELS NO-UNDERLINE THREE-D  SCROLLABLE 
         TITLE "Lectura y Carga de Interface de Sucursales"
         DEFAULT-BUTTON Btn_OK.


/* *********************** Procedure Settings ************************ */

&ANALYZE-SUSPEND _PROCEDURE-SETTINGS
/* Settings for THIS-PROCEDURE
   Type: DIALOG-BOX
   Allow: Basic,Browse,DB-Fields,Query
   Other Settings: COMPILE
 */
&ANALYZE-RESUME _END-PROCEDURE-SETTINGS


/* ***************  Runtime Attributes and UIB Settings  ************** */

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
ON WINDOW-CLOSE OF FRAME Dialog-Frame /* Lectura y Carga de Interface de Sucursales */
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
    ASSIGN v-archivo v-has_fecha
    x-cxc x-dsp x-fac x-inv x-marca x-tes x-com.

    FIND Sucursal WHERE Sucursal.dsc_sucursal BEGINS "Casa" NO-LOCK.

    IF x-marca
    THEN DO:
        v-estado:SCREEN-VALUE = "Marcando Movimientos ...".
        v-estado:BGCOLOR = 12.
        RUN marcasucursal.p (INPUT Sucursal.num_sucursal ). 
    END.
    
    FIND Sucursal WHERE Sucursal.dsc_sucursal = v-archivo NO-LOCK.

    Actualizacion:
    DO ON ERROR UNDO Actualizacion, LEAVE Actualizacion:
    
        IF x-dsp
        THEN DO:

            v-estado:SCREEN-VALUE = "Cargando Interface DSP ...".
            v-estado:BGCOLOR = 12.
            RUN ldintersuc_dsp.p ( INPUT "",
                                   INPUT v-has_fecha, 
                                   INPUT v-has_fecha, 
                                   INPUT Sucursal.num_sucursal ). 
        END.

        IF x-fac
        THEN DO:
 
        
            v-estado:SCREEN-VALUE = "Cargando Interface FAC ...".
            v-estado:BGCOLOR = 12.
            RUN ldintersuc_fac.p ( INPUT "",
                                   INPUT v-has_fecha, 
                                   INPUT v-has_fecha, 
                                   INPUT Sucursal.num_sucursal ). 

        END.

        IF x-cxc
        THEN DO:

        
            v-estado:SCREEN-VALUE = "Cargando Interface CXC ...".
            v-estado:BGCOLOR = 12.
            RUN ldintersuc_cxc.p ( INPUT "",
                                   INPUT v-has_fecha, 
                                   INPUT v-has_fecha, 
                                   INPUT Sucursal.num_sucursal ). 

        END.

        IF x-tes
        THEN DO:

        
            v-estado:SCREEN-VALUE = "Cargando Interface TES ...".
            v-estado:BGCOLOR = 12.
            RUN ldintersuc_tes.p ( INPUT "",
                                   INPUT v-has_fecha, 
                                   INPUT v-has_fecha, 
                                   INPUT Sucursal.num_sucursal ). 

        END.


        IF x-inv
        THEN DO:
        
            v-estado:SCREEN-VALUE = "Cargando Interface INV ...".
            v-estado:BGCOLOR = 12.
            RUN ldintersuc_inv.p ( INPUT "",
                                   INPUT v-has_fecha, 
                                   INPUT v-has_fecha, 
                                   INPUT Sucursal.num_sucursal ). 

        END.

        IF x-com
        THEN DO:
        
            v-estado:SCREEN-VALUE = "Cargando Interface COM ...".
            v-estado:BGCOLOR = 12.
            RUN ldintersuc_com.p ( INPUT "",
                                   INPUT v-has_fecha, 
                                   INPUT v-has_fecha, 
                                   INPUT Sucursal.num_sucursal ). 

        END.



    END.                       

    v-estado:SCREEN-VALUE = "Proceso Terminado.".
    v-estado:BGCOLOR = 2.

  END.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME v-has_fecha
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-has_fecha Dialog-Frame
ON MOUSE-MENU-DOWN OF v-has_fecha IN FRAME Dialog-Frame /* Hasta Fecha */
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


/* Now enable the interface and wait for the exit condition.            */
/* (NOTE: handle ERROR and END-KEY so cleanup code will always fire.    */
MAIN-BLOCK:
DO ON ERROR   UNDO MAIN-BLOCK, LEAVE MAIN-BLOCK
   ON END-KEY UNDO MAIN-BLOCK, LEAVE MAIN-BLOCK:
  RUN enable_UI.
  RUN cargar_combo.
  WAIT-FOR GO OF FRAME {&FRAME-NAME}.
END.
RUN disable_UI.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


/* **********************  Internal Procedures  *********************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE cargar_combo Dialog-Frame 
PROCEDURE cargar_combo :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

  DEFINE VARIABLE ok AS LOGICAL.
  v-estado:SCREEN-VALUE IN FRAME {&FRAME-NAME} = "Ingresando Parámetros...".
  v-archivo:LIST-ITEMS IN FRAME {&FRAME-NAME}  = "".
  FOR EACH Sucursal:
      ok = v-archivo:ADD-LAST(Sucursal.dsc_sucursal).
  END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE disable_UI Dialog-Frame _DEFAULT-DISABLE
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


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE enable_UI Dialog-Frame _DEFAULT-ENABLE
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
  DISPLAY v-estado x-marca x-dsp v-archivo x-fac x-cxc v-has_fecha x-tes x-inv 
          x-COM 
      WITH FRAME Dialog-Frame.
  ENABLE RECT-5 RECT-6 x-marca x-dsp v-archivo x-fac x-cxc v-has_fecha x-tes 
         x-inv x-COM btn_proceso Btn_OK 
      WITH FRAME Dialog-Frame.
  VIEW FRAME Dialog-Frame.
  {&OPEN-BROWSERS-IN-QUERY-Dialog-Frame}
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


