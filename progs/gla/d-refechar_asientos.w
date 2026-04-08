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

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE Dialog-Box
&Scoped-define DB-AWARE no

/* Name of first Frame and/or Browse and/or first Query                 */
&Scoped-define FRAME-NAME Dialog-Frame

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS v-tip_comprob v-prf_comprob v-nro_comprob ~
v-fecha_nueva BUTTON-2 Btn_Cancel RECT-1 
&Scoped-Define DISPLAYED-OBJECTS v-tip_comprob v-prf_comprob v-nro_comprob ~
v-fecha_original v-fecha_nueva v-leyenda 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME



/* ***********************  Control Definitions  ********************** */

/* Define a dialog box                                                  */

/* Definitions of the field level widgets                               */
DEFINE BUTTON Btn_Cancel AUTO-END-KEY 
     LABEL "&Salir" 
     SIZE 33 BY 1.14
     BGCOLOR 8 .

DEFINE BUTTON BUTTON-2 
     LABEL "Aplicar Cambio de Fecha" 
     SIZE 33 BY 1.14.

DEFINE VARIABLE v-fecha_nueva AS DATE FORMAT "99/99/99":U 
     LABEL "Nueva Fecha" 
     VIEW-AS FILL-IN 
     SIZE 14 BY 1
     BGCOLOR 14 FGCOLOR 9  NO-UNDO.

DEFINE VARIABLE v-fecha_original AS DATE FORMAT "99/99/99":U 
     LABEL "Fecha" 
     VIEW-AS FILL-IN 
     SIZE 14 BY 1
     BGCOLOR 15 FGCOLOR 9  NO-UNDO.

DEFINE VARIABLE v-leyenda AS CHARACTER FORMAT "X(256)":U 
     LABEL "Leyenda" 
     VIEW-AS FILL-IN 
     SIZE 88 BY 1
     BGCOLOR 15 FGCOLOR 9  NO-UNDO.

DEFINE VARIABLE v-nro_comprob AS INTEGER FORMAT ">>>>>>>9":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 14 BY 1
     BGCOLOR 15 FGCOLOR 9  NO-UNDO.

DEFINE VARIABLE v-prf_comprob AS INTEGER FORMAT ">,>>9":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 8.2 BY 1
     BGCOLOR 15 FGCOLOR 9  NO-UNDO.

DEFINE VARIABLE v-tip_comprob AS CHARACTER FORMAT "X(256)":U 
     LABEL "Asiento" 
     VIEW-AS FILL-IN 
     SIZE 7 BY 1
     BGCOLOR 15 FGCOLOR 9  NO-UNDO.

DEFINE RECTANGLE RECT-1
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL 
     SIZE 105 BY 5.71.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME Dialog-Frame
     v-tip_comprob AT ROW 1.95 COL 15 COLON-ALIGNED
     v-prf_comprob AT ROW 1.95 COL 24 COLON-ALIGNED NO-LABEL
     v-nro_comprob AT ROW 1.95 COL 34 COLON-ALIGNED NO-LABEL
     v-fecha_original AT ROW 1.95 COL 58 COLON-ALIGNED
     v-fecha_nueva AT ROW 1.95 COL 89 COLON-ALIGNED
     v-leyenda AT ROW 3.38 COL 15 COLON-ALIGNED
     BUTTON-2 AT ROW 4.81 COL 17
     Btn_Cancel AT ROW 4.81 COL 72
     RECT-1 AT ROW 1.48 COL 3
     SPACE(1.79) SKIP(0.32)
    WITH VIEW-AS DIALOG-BOX KEEP-TAB-ORDER 
         SIDE-LABELS NO-UNDERLINE THREE-D  SCROLLABLE 
         TITLE "Cambio de Fecha de Asientos Contables"
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

/* SETTINGS FOR FILL-IN v-fecha_original IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN v-leyenda IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME Dialog-Frame
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Dialog-Frame Dialog-Frame
ON WINDOW-CLOSE OF FRAME Dialog-Frame /* Cambio de Fecha de Asientos Contables */
DO:
  APPLY "END-ERROR":U TO SELF.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME BUTTON-2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL BUTTON-2 Dialog-Frame
ON CHOOSE OF BUTTON-2 IN FRAME Dialog-Frame /* Aplicar Cambio de Fecha */
DO:
  {findempresa.i}
  ASSIGN v-tip_comprob v-prf_comprob v-nro_comprob v-fecha_nueva.

  FIND Asn_header 
      WHERE Asn_header.cdg_empresa = Empresa.cdg_empresa
        AND Asn_header.tip_comprob = v-tip_comprob
        AND Asn_header.prf_comprob = v-prf_comprob
        AND Asn_header.nro_comprob = v-nro_comprob
            NO-LOCK NO-ERROR.

  IF NOT AVAILABLE Asn_header
  THEN DO:
      RUN ponmensj.p ( INPUT "ASIE060" ).
      RETURN NO-APPLY.
  END.
  ELSE DO:
      IF v-fecha_nueva = DATE("")
      THEN DO:
          RUN ponmensj.p ( INPUT "ASIE061" ).
          RETURN NO-APPLY.
      END.
      ELSE DO:
          DO TRANSACTION: 
              FIND CURRENT Asn_header EXCLUSIVE-LOCK.
              Asn_header.fecha = v-fecha_nueva.
              FOR EACH Asn_detalle OF Asn_header EXCLUSIVE-LOCK:
                  Asn_detalle.fecha_mayor = Asn_header.fecha.
              END.
              RELEASE Asn_detalle.
              RELEASE Asn_header.
          END.

          ASSIGN v-tip_comprob = ""
                 v-prf_comprob = 0
                 v-nro_comprob = 0
                 v-leyenda = ""
                 v-fecha_original = DATE("").

         DISPLAY v-tip_comprob
                 v-prf_comprob
                 v-nro_comprob
                 v-leyenda
                 v-fecha_original
             WITH FRAME {&FRAME-NAME}.
    
      END.
  END.  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME v-nro_comprob
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-nro_comprob Dialog-Frame
ON MOUSE-SELECT-DBLCLICK OF v-nro_comprob IN FRAME Dialog-Frame
OR MOUSE-MENU-DOWN,"." OF v-nro_comprob IN FRAME {&FRAME-NAME}
DO:

  DEFINE VARIABLE rid_asiento AS ROWID.

  RUN d-seleccionar_asiento.w (INPUT-OUTPUT rid_asiento).
  IF rid_asiento <> ?
  THEN DO:
     FIND Asn_header WHERE ROWID(Asn_header) = rid_asiento NO-LOCK.
     DISPLAY Asn_header.tip_comprob @ v-tip_comprob 
             Asn_header.prf_comprob @ v-prf_comprob
             Asn_header.nro_comprob @ v-nro_comprob
             Asn_header.fecha       @ v-fecha_original
             Asn_header.leyenda     @ v-leyenda
             WITH FRAME {&FRAME-NAME}.
  END.
  RETURN NO-APPLY.  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-nro_comprob Dialog-Frame
ON RETURN OF v-nro_comprob IN FRAME Dialog-Frame
DO:
    {findempresa.i}
    ASSIGN v-tip_comprob v-prf_comprob v-nro_comprob.

    FIND Asn_header 
        WHERE Asn_header.cdg_empresa = Empresa.cdg_empresa
          AND Asn_header.tip_comprob = v-tip_comprob
          AND Asn_header.prf_comprob = v-prf_comprob
          AND Asn_header.nro_comprob = v-nro_comprob
              NO-LOCK NO-ERROR.

    IF NOT AVAILABLE Asn_header
    THEN DO:
        RUN ponmensj.p ( INPUT "ASIE060" ).
        RETURN NO-APPLY.
    END.
    ELSE DO:
        DISPLAY Asn_header.tip_comprob @ v-tip_comprob
                Asn_header.prf_comprob @ v-prf_comprob
                Asn_header.nro_comprob @ v-nro_comprob
                Asn_header.fecha       @ v-fecha_original
                Asn_header.leyenda     @ v-leyenda
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
  DISPLAY v-tip_comprob v-prf_comprob v-nro_comprob v-fecha_original 
          v-fecha_nueva v-leyenda 
      WITH FRAME Dialog-Frame.
  ENABLE v-tip_comprob v-prf_comprob v-nro_comprob v-fecha_nueva BUTTON-2 
         Btn_Cancel RECT-1 
      WITH FRAME Dialog-Frame.
  VIEW FRAME Dialog-Frame.
  {&OPEN-BROWSERS-IN-QUERY-Dialog-Frame}
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

