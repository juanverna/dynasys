&ANALYZE-SUSPEND _VERSION-NUMBER UIB_v8r12 GUI
&ANALYZE-RESUME
/* Connected Databases 
          sic              PROGRESS
*/
&Scoped-define WINDOW-NAME CURRENT-WINDOW
&Scoped-define FRAME-NAME Dialog-Frame

/* Temp-Table and Buffer definitions                                    */
DEFINE TEMP-TABLE T-Ped_header NO-UNDO LIKE sic.Ped_header.


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

&IF DEFINED(UIB_is_Running) NE 0
&THEN
DEFINE VARIABLE           p-modo-cabecera  AS INTEGER.
&ELSE
DEFINE INPUT   PARAMETER  p-modo-cabecera  AS INTEGER.
DEFINE INPUT-OUTPUT PARAMETER TABLE FOR T-Ped_header.
&ENDIF

/* Local Variable Definitions ---                                       */

{valoresmodo.i}
{valoressalida.i}

DEFINE VARIABLE           rid_tabla       AS ROWID.
DEFINE VARIABLE           hubo_error      AS LOGICAL.
DEFINE VARIABLE           hay_obras       AS LOGICAL.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE DIALOG-BOX

/* Name of first Frame and/or Browse and/or first Query                 */
&Scoped-define FRAME-NAME Dialog-Frame

/* Internal Tables (found by Frame, Query & Browse Queries)             */
&Scoped-define INTERNAL-TABLES T-Ped_header

/* Definitions for DIALOG-BOX Dialog-Frame                              */
&Scoped-define FIELDS-IN-QUERY-Dialog-Frame T-Ped_header.comision 
&Scoped-define ENABLED-FIELDS-IN-QUERY-Dialog-Frame T-Ped_header.comision 
&Scoped-define ENABLED-TABLES-IN-QUERY-Dialog-Frame T-Ped_header
&Scoped-define FIRST-ENABLED-TABLE-IN-QUERY-Dialog-Frame T-Ped_header
&Scoped-define OPEN-QUERY-Dialog-Frame OPEN QUERY Dialog-Frame FOR EACH T-Ped_header SHARE-LOCK.
&Scoped-define TABLES-IN-QUERY-Dialog-Frame T-Ped_header
&Scoped-define FIRST-TABLE-IN-QUERY-Dialog-Frame T-Ped_header


/* Standard List Definitions                                            */
&Scoped-Define ENABLED-FIELDS T-Ped_header.comision 
&Scoped-define FIELD-PAIRS~
 ~{&FP1}comision ~{&FP2}comision ~{&FP3}
&Scoped-define ENABLED-TABLES T-Ped_header
&Scoped-define FIRST-ENABLED-TABLE T-Ped_header
&Scoped-Define ENABLED-OBJECTS RECT-13 v-cdg_notify v-cdg_consignatario ~
v-cdg_despachante v-cdg_representante Btn_OK Btn_Cancel 
&Scoped-Define DISPLAYED-FIELDS T-Ped_header.comision 
&Scoped-Define DISPLAYED-OBJECTS v-cdg_notify v-dsc_notify ~
v-cdg_consignatario v-dsc_consignatario v-cdg_despachante v-dsc_despachante ~
v-cdg_representante v-dsc_representante 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME



/* ***********************  Control Definitions  ********************** */

/* Define a dialog box                                                  */

/* Definitions of the field level widgets                               */
DEFINE BUTTON Btn_Cancel AUTO-END-KEY 
     LABEL "Cancel" 
     SIZE 18 BY 1.15
     BGCOLOR 8 .

DEFINE BUTTON Btn_OK AUTO-GO 
     LABEL "OK" 
     SIZE 18 BY 1.15
     BGCOLOR 8 .

DEFINE VARIABLE v-cdg_consignatario AS INTEGER FORMAT "->,>>>,>>9" INITIAL 0 
     LABEL "Consignatario" 
     VIEW-AS FILL-IN NATIVE 
     SIZE 7 BY .81
     BGCOLOR 15 FGCOLOR 9 .

DEFINE VARIABLE v-cdg_despachante AS INTEGER FORMAT "->,>>>,>>9" INITIAL 0 
     LABEL "Despachante" 
     VIEW-AS FILL-IN NATIVE 
     SIZE 7 BY .81
     BGCOLOR 15 FGCOLOR 9 .

DEFINE VARIABLE v-cdg_notify AS INTEGER FORMAT "->,>>>,>>9" INITIAL 0 
     LABEL "Notify to" 
     VIEW-AS FILL-IN NATIVE 
     SIZE 7 BY .81
     BGCOLOR 15 FGCOLOR 9 .

DEFINE VARIABLE v-cdg_representante AS INTEGER FORMAT "->,>>>,>>9" INITIAL 0 
     LABEL "Representante" 
     VIEW-AS FILL-IN NATIVE 
     SIZE 7 BY .81
     BGCOLOR 15 FGCOLOR 9 .

DEFINE VARIABLE v-dsc_consignatario AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN NATIVE 
     SIZE 37 BY .81
     BGCOLOR 7 FGCOLOR 15  NO-UNDO.

DEFINE VARIABLE v-dsc_despachante AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN NATIVE 
     SIZE 37 BY .81
     BGCOLOR 7 FGCOLOR 15  NO-UNDO.

DEFINE VARIABLE v-dsc_notify AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN NATIVE 
     SIZE 37 BY .81
     BGCOLOR 7 FGCOLOR 15  NO-UNDO.

DEFINE VARIABLE v-dsc_representante AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN NATIVE 
     SIZE 37 BY .81
     BGCOLOR 7 FGCOLOR 15  NO-UNDO.

DEFINE RECTANGLE RECT-13
     EDGE-PIXELS 6 GRAPHIC-EDGE  NO-FILL 
     SIZE 65 BY 7.81.

/* Query definitions                                                    */
&ANALYZE-SUSPEND
DEFINE QUERY Dialog-Frame FOR 
      T-Ped_header SCROLLING.
&ANALYZE-RESUME

/* ************************  Frame Definitions  *********************** */

DEFINE FRAME Dialog-Frame
     v-cdg_notify AT ROW 1.81 COL 17 COLON-ALIGNED HELP
          "Codigo de consignatario"
     v-dsc_notify AT ROW 1.81 COL 25 COLON-ALIGNED NO-LABEL
     v-cdg_consignatario AT ROW 2.88 COL 17 COLON-ALIGNED HELP
          "Codigo de consignatario"
     v-dsc_consignatario AT ROW 2.88 COL 25 COLON-ALIGNED NO-LABEL
     v-cdg_despachante AT ROW 3.96 COL 17 COLON-ALIGNED HELP
          "Codigo de tipo de embarque"
     v-dsc_despachante AT ROW 3.96 COL 25 COLON-ALIGNED NO-LABEL
     v-cdg_representante AT ROW 5.04 COL 17 COLON-ALIGNED HELP
          "Codigo de tipo de embarque"
     v-dsc_representante AT ROW 5.04 COL 25 COLON-ALIGNED NO-LABEL
     T-Ped_header.comision AT ROW 6.12 COL 17 COLON-ALIGNED
          VIEW-AS FILL-IN NATIVE 
          SIZE 18 BY .81
          BGCOLOR 15 FGCOLOR 9 
     Btn_OK AT ROW 7.19 COL 19
     Btn_Cancel AT ROW 7.19 COL 46
     RECT-13 AT ROW 1.27 COL 1
     SPACE(1.13) SKIP(1.22)
    WITH VIEW-AS DIALOG-BOX KEEP-TAB-ORDER 
         SIDE-LABELS NO-UNDERLINE THREE-D  SCROLLABLE 
         TITLE "Datos de Notify del Pedido Internacional"
         DEFAULT-BUTTON Btn_OK CANCEL-BUTTON Btn_Cancel.


/* *********************** Procedure Settings ************************ */

&ANALYZE-SUSPEND _PROCEDURE-SETTINGS
/* Settings for THIS-PROCEDURE
   Type: DIALOG-BOX
   Allow: Basic,Browse,DB-Fields,Query
   Other Settings: COMPILE
   Temp-Tables and Buffers:
      TABLE: T-Ped_header T "?" NO-UNDO sic Ped_header
   END-TABLES.
 */
&ANALYZE-RESUME _END-PROCEDURE-SETTINGS


/* ***************  Runtime Attributes and UIB Settings  ************** */

&ANALYZE-SUSPEND _RUN-TIME-ATTRIBUTES
/* SETTINGS FOR DIALOG-BOX Dialog-Frame
                                                                        */
ASSIGN 
       FRAME Dialog-Frame:SCROLLABLE       = FALSE
       FRAME Dialog-Frame:HIDDEN           = TRUE.

/* SETTINGS FOR FILL-IN v-dsc_consignatario IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN v-dsc_despachante IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN v-dsc_notify IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN v-dsc_representante IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME


/* Setting information for Queries and Browse Widgets fields            */

&ANALYZE-SUSPEND _QUERY-BLOCK DIALOG-BOX Dialog-Frame
/* Query rebuild information for DIALOG-BOX Dialog-Frame
     _TblList          = "Temp-Tables.T-Ped_header"
     _Options          = "SHARE-LOCK"
     _Query            is OPENED
*/  /* DIALOG-BOX Dialog-Frame */
&ANALYZE-RESUME

 




/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME Dialog-Frame
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Dialog-Frame Dialog-Frame
ON WINDOW-CLOSE OF FRAME Dialog-Frame /* Datos de Notify del Pedido Internacional */
DO:
  APPLY "END-ERROR":U TO SELF.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME Btn_OK
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Btn_OK Dialog-Frame
ON CHOOSE OF Btn_OK IN FRAME Dialog-Frame /* OK */
DO:

  RUN  validar_datos ( OUTPUT hubo_error ).
  IF NOT hubo_error
  THEN DO:
        ASSIGN FRAME {&FRAME-NAME}
               T-Ped_header.comision .
        codigo_salir = CD_GRABAR.
        APPLY "U1" TO THIS-PROCEDURE.
  END.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME v-cdg_consignatario
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-cdg_consignatario Dialog-Frame
ON MOUSE-MENU-DOWN OF v-cdg_consignatario IN FRAME Dialog-Frame /* Consignatario */
OR "." OF v-cdg_consignatario IN FRAME {&FRAME-NAME}
OR MOUSE-MENU-DOWN OF v-cdg_consignatario IN FRAME {&FRAME-NAME}
DO:

   {helptabla.i "consignatario" "cdg_consignatario" "SELCONSG.P"}
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-cdg_consignatario Dialog-Frame
ON RETURN OF v-cdg_consignatario IN FRAME Dialog-Frame /* Consignatario */
DO:
   {traducetabla.i "consignatario" "cdg_consignatario" "nombre"} 
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME v-cdg_despachante
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-cdg_despachante Dialog-Frame
ON MOUSE-MENU-DOWN OF v-cdg_despachante IN FRAME Dialog-Frame /* Despachante */
OR "." OF v-cdg_despachante IN FRAME {&FRAME-NAME}
OR MOUSE-MENU-DOWN OF v-cdg_despachante IN FRAME {&FRAME-NAME}
DO:

   {helptabla.i "despachante" "cdg_despachante" "SELDESPA.P"}
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-cdg_despachante Dialog-Frame
ON RETURN OF v-cdg_despachante IN FRAME Dialog-Frame /* Despachante */
DO:
   {traducetabla.i "despachante" "cdg_despachante" "nom_despachante"} 
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME v-cdg_notify
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-cdg_notify Dialog-Frame
ON MOUSE-MENU-DOWN OF v-cdg_notify IN FRAME Dialog-Frame /* Notify to */
OR "." OF v-cdg_notify IN FRAME {&FRAME-NAME}
OR MOUSE-MENU-DOWN OF v-cdg_notify IN FRAME {&FRAME-NAME}
DO:

   {helptabla.i "Notify" "cdg_notify" "SELNOTIF.P"}
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-cdg_notify Dialog-Frame
ON RETURN OF v-cdg_notify IN FRAME Dialog-Frame /* Notify to */
DO:
   {traducetabla.i "Notify" "cdg_notify" "nom_notify"} 
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME v-cdg_representante
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-cdg_representante Dialog-Frame
ON MOUSE-MENU-DOWN OF v-cdg_representante IN FRAME Dialog-Frame /* Representante */
OR "." OF v-cdg_representante IN FRAME {&FRAME-NAME}
OR MOUSE-MENU-DOWN OF v-cdg_representante IN FRAME {&FRAME-NAME}
DO:

   {helptabla.i "representante" "cdg_represente" "SELREPRE.P"}
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-cdg_representante Dialog-Frame
ON RETURN OF v-cdg_representante IN FRAME Dialog-Frame /* Representante */
DO:
   {traducetabla.i "representante" "cdg_represente" "nom_represente"} 
  
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

  FIND FIRST T-Ped_header.
  RUN traer_tablas.
  DISPLAY 
        T-Ped_header.comision 
        v-cdg_notify
        v-dsc_notify
        v-cdg_consignatario
        v-dsc_consignatario
        v-cdg_despachante
        v-dsc_despachante
        v-cdg_representante
        v-dsc_representante
        WITH FRAME {&FRAME-NAME}.      

  WAIT-FOR U1 OF THIS-PROCEDURE.
  CASE codigo_salir:
       WHEN CD_SALIR    THEN UNDO,LEAVE.
       WHEN CD_CANCELAR THEN UNDO,RETRY.
       WHEN CD_GRABAR   THEN LEAVE.
  END CASE.

END.
RUN disable_UI.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


/* **********************  Internal Procedures  *********************** */

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

  {&OPEN-QUERY-Dialog-Frame}
  GET FIRST Dialog-Frame.
  DISPLAY v-cdg_notify v-dsc_notify v-cdg_consignatario v-dsc_consignatario 
          v-cdg_despachante v-dsc_despachante v-cdg_representante 
          v-dsc_representante 
      WITH FRAME Dialog-Frame.
  IF AVAILABLE T-Ped_header THEN 
    DISPLAY T-Ped_header.comision 
      WITH FRAME Dialog-Frame.
  ENABLE RECT-13 v-cdg_notify v-cdg_consignatario v-cdg_despachante 
         v-cdg_representante T-Ped_header.comision Btn_OK Btn_Cancel 
      WITH FRAME Dialog-Frame.
  VIEW FRAME Dialog-Frame.
  {&OPEN-BROWSERS-IN-QUERY-Dialog-Frame}
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE traer_consignatario Dialog-Frame 
PROCEDURE traer_consignatario :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

    FIND Consignatario OF T-Ped_header   NO-LOCK NO-ERROR.
    IF AVAILABLE Consignatario
       THEN ASSIGN
                  v-cdg_consignatario = Consignatario.cdg_consignatario
                  v-dsc_consignatario = Consignatario.nombre.
       ELSE ASSIGN
                  v-cdg_consignatario = 0
                  v-dsc_consignatario = "".

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE traer_despachante Dialog-Frame 
PROCEDURE traer_despachante :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

    FIND Despachante OF T-Ped_header   NO-LOCK NO-ERROR.
    IF AVAILABLE Despachante
       THEN ASSIGN
                  v-cdg_despachante = Despachante.cdg_despachante
                  v-dsc_despachante = Despachante.nom_despachante.
       ELSE ASSIGN
                  v-cdg_despachante = 0
                  v-dsc_despachante = "".


END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE traer_notify Dialog-Frame 
PROCEDURE traer_notify :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

    FIND Notify OF T-Ped_header   NO-LOCK NO-ERROR.
    IF AVAILABLE Notify
       THEN ASSIGN
                   v-cdg_notify = Notify.cdg_notify
                   v-dsc_notify = Notify.nom_notify.
       ELSE ASSIGN
                   v-cdg_notify = 0
                   v-dsc_notify = "".


END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE traer_representante Dialog-Frame 
PROCEDURE traer_representante :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

    FIND Representante OF T-Ped_header   NO-LOCK NO-ERROR.
    IF AVAILABLE Representante
       THEN ASSIGN
                    v-cdg_representante = Representante.cdg_represente
                    v-dsc_representante = Representante.nom_represente.
       ELSE ASSIGN
                    v-cdg_representante = 0
                    v-dsc_representante = "".


END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE traer_tablas Dialog-Frame 
PROCEDURE traer_tablas :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

  RUN traer_notify.
  RUN traer_representante.
  RUN traer_consignatario.
  RUN traer_despachante.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE validar_datos Dialog-Frame 
PROCEDURE validar_datos :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

    DEFINE OUTPUT PARAMETER hubo_error AS LOGICAL.
    
    hubo_error = YES.
    
    {validartabla.i "Notify"        "cdg_notify"        "nom_notify"      "PINT015"}
    {validartabla.i "Consignatario" "cdg_consignatario" "nombre"          "PINT016"}
    {validartabla.i "Despachante"   "cdg_despachante"   "nom_despachante" "PINT017"}
    {validartabla.i "Representante" "cdg_represente"    "nom_represente"  "PINT018"}

    hubo_error = NO.

    &SCOPED-DEFINE TABLA-MAESTRA  T-Ped_header

    {asignartabla.i "Notify"        "cdg_notify"        "cdg_notify"}
    {asignartabla.i "Consignatario" "cdg_consignatario" "cdg_consignatario"}
    {asignartabla.i "Despachante"   "cdg_despachante"   "cdg_despachante"}
    {asignartabla.i "Representante" "cdg_represente"    "cdg_represente"}

    &UNDEFINE TABLA-MAESTRA

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


