&ANALYZE-SUSPEND _VERSION-NUMBER UIB_v9r12 GUI
&ANALYZE-RESUME
/* Connected Databases 
          sic              PROGRESS
*/
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
DEFINE INPUT PARAMETER r AS CHAR NO-UNDO.
/* Local Variable Definitions ---                                       */

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE Dialog-Box
&Scoped-define DB-AWARE no

/* Name of designated FRAME-NAME and/or first browse and/or first query */
&Scoped-define FRAME-NAME Dialog-Frame

/* Internal Tables (found by Frame, Query & Browse Queries)             */
&Scoped-define INTERNAL-TABLES Tarea

/* Definitions for DIALOG-BOX Dialog-Frame                              */
&Scoped-define FIELDS-IN-QUERY-Dialog-Frame Tarea.titulo Tarea.descripcion 
&Scoped-define ENABLED-FIELDS-IN-QUERY-Dialog-Frame Tarea.titulo ~
Tarea.descripcion 
&Scoped-define ENABLED-TABLES-IN-QUERY-Dialog-Frame Tarea
&Scoped-define FIRST-ENABLED-TABLE-IN-QUERY-Dialog-Frame Tarea
&Scoped-define QUERY-STRING-Dialog-Frame FOR EACH Tarea SHARE-LOCK
&Scoped-define OPEN-QUERY-Dialog-Frame OPEN QUERY Dialog-Frame FOR EACH Tarea SHARE-LOCK.
&Scoped-define TABLES-IN-QUERY-Dialog-Frame Tarea
&Scoped-define FIRST-TABLE-IN-QUERY-Dialog-Frame Tarea


/* Standard List Definitions                                            */
&Scoped-Define ENABLED-FIELDS Tarea.titulo Tarea.descripcion 
&Scoped-define ENABLED-TABLES Tarea
&Scoped-define FIRST-ENABLED-TABLE Tarea
&Scoped-Define ENABLED-OBJECTS Btn_OK Btn_Cancel Btn_Help v_cdg_tipotarea ~
v-r v-v 
&Scoped-Define DISPLAYED-FIELDS Tarea.titulo Tarea.descripcion 
&Scoped-define DISPLAYED-TABLES Tarea
&Scoped-define FIRST-DISPLAYED-TABLE Tarea
&Scoped-Define DISPLAYED-OBJECTS v_cdg_tipotarea v-r v-v 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME



/* ***********************  Control Definitions  ********************** */

/* Define a dialog box                                                  */

/* Definitions of the field level widgets                               */
DEFINE BUTTON Btn_Cancel AUTO-END-KEY 
     LABEL "Cancel" 
     SIZE 15 BY 1.14
     BGCOLOR 8 .

DEFINE BUTTON Btn_Help 
     LABEL "&Help" 
     SIZE 15 BY 1.14
     BGCOLOR 8 .

DEFINE BUTTON Btn_OK AUTO-GO 
     LABEL "OK" 
     SIZE 15 BY 1.14
     BGCOLOR 8 .

DEFINE VARIABLE v_cdg_tipotarea AS CHARACTER FORMAT "X(1)" 
     LABEL "Tipo" 
     VIEW-AS COMBO-BOX INNER-LINES 5
     LIST-ITEM-PAIRS "Arreglo","A",
                     "Cambio","C",
                     "Mejora","M",
                     "Desarrollo","D"
     DROP-DOWN-LIST
     SIZE 16 BY 1 TOOLTIP "Tipo de la tarea a realizar".

DEFINE VARIABLE v-r AS CHARACTER FORMAT "X(256)":U 
     LABEL "Programa" 
      VIEW-AS TEXT 
     SIZE 79.8 BY .62 NO-UNDO.

DEFINE VARIABLE v-v AS CHARACTER FORMAT "X(256)":U 
     LABEL "Referencias" 
      VIEW-AS TEXT 
     SIZE 77.4 BY .62 NO-UNDO.

/* Query definitions                                                    */
&ANALYZE-SUSPEND
DEFINE QUERY Dialog-Frame FOR 
      Tarea SCROLLING.
&ANALYZE-RESUME

/* ************************  Frame Definitions  *********************** */

DEFINE FRAME Dialog-Frame
     Btn_OK AT ROW 1.24 COL 38
     Btn_Cancel AT ROW 1.24 COL 55
     Btn_Help AT ROW 1.24 COL 73
     v_cdg_tipotarea AT ROW 1.38 COL 6 COLON-ALIGNED
     Tarea.titulo AT ROW 4.57 COL 2 NO-LABEL
          VIEW-AS FILL-IN 
          SIZE 89 BY 1
     Tarea.descripcion AT ROW 5.52 COL 2 NO-LABEL
          VIEW-AS EDITOR
          SIZE 89 BY 7.86
     v-r AT ROW 2.67 COL 9.2 COLON-ALIGNED
     v-v AT ROW 3.38 COL 11.6 COLON-ALIGNED
     SPACE(1.59) SKIP(9.66)
    WITH VIEW-AS DIALOG-BOX KEEP-TAB-ORDER 
         SIDE-LABELS NO-UNDERLINE THREE-D  SCROLLABLE 
         TITLE "Control de errores del sistema y seguimiento de software"
         DEFAULT-BUTTON Btn_OK CANCEL-BUTTON Btn_Cancel.


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
   FRAME-NAME                                                           */
ASSIGN 
       FRAME Dialog-Frame:SCROLLABLE       = FALSE
       FRAME Dialog-Frame:HIDDEN           = TRUE.

/* SETTINGS FOR FILL-IN Tarea.titulo IN FRAME Dialog-Frame
   ALIGN-L                                                              */
/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME


/* Setting information for Queries and Browse Widgets fields            */

&ANALYZE-SUSPEND _QUERY-BLOCK DIALOG-BOX Dialog-Frame
/* Query rebuild information for DIALOG-BOX Dialog-Frame
     _TblList          = "sic.Tarea"
     _Options          = "SHARE-LOCK"
     _Query            is OPENED
*/  /* DIALOG-BOX Dialog-Frame */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME Dialog-Frame
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Dialog-Frame Dialog-Frame
ON WINDOW-CLOSE OF FRAME Dialog-Frame /* Control de errores del sistema y seguimiento de software */
DO:
  APPLY "END-ERROR":U TO SELF.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME Btn_Help
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Btn_Help Dialog-Frame
ON CHOOSE OF Btn_Help IN FRAME Dialog-Frame /* Help */
OR HELP OF FRAME {&FRAME-NAME}
DO: /* Call Help Function (or a simple message). */
  MESSAGE "Control de errores internos de Dynasys" SKIP
          "se le asignara una tarea en forma automatica" SKIP
          "para el seguimiento posterior"  VIEW-AS ALERT-BOX INFORMATION.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME Btn_OK
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Btn_OK Dialog-Frame
ON CHOOSE OF Btn_OK IN FRAME Dialog-Frame /* OK */
DO:

  RUN grabar.

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
  RUN iniciar.
MAIN-BLOCK:
DO ON ERROR   UNDO MAIN-BLOCK, LEAVE MAIN-BLOCK
   ON END-KEY UNDO MAIN-BLOCK, LEAVE MAIN-BLOCK:
    CREATE tarea.
  RUN enable_UI.
  WAIT-FOR GO OF FRAME {&FRAME-NAME}.
  LEAVE.
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

  {&OPEN-QUERY-Dialog-Frame}
  GET FIRST Dialog-Frame.
  DISPLAY v_cdg_tipotarea v-r v-v 
      WITH FRAME Dialog-Frame.
  IF AVAILABLE Tarea THEN 
    DISPLAY Tarea.titulo Tarea.descripcion 
      WITH FRAME Dialog-Frame.
  ENABLE Btn_OK Btn_Cancel Btn_Help v_cdg_tipotarea Tarea.titulo 
         Tarea.descripcion v-r v-v 
      WITH FRAME Dialog-Frame.
  VIEW FRAME Dialog-Frame.
  {&OPEN-BROWSERS-IN-QUERY-Dialog-Frame}
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE grabar Dialog-Frame 
PROCEDURE grabar :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DO WITH FRAME {&FRAME-NAME}:

ASSIGN 
    Tarea.nro_tarea  = next-value(proxima_tarea)
    Tarea.hora_alta = string(time,"HH:mm:ss")
    Tarea.fecha_reportado = today
    Tarea.estado = "A"
    Tarea.fecha_alta = TODAY
    /*
    Tarea.version-reporte 
    Tarea.version-arreglo 
    Tarea.resuelto_por 
    Tarea.prioridad 
    Tarea.pc_name 
    Tarea.nro_usuario 
    Tarea.nro_predecesora 
    Tarea.horas_reales 
    Tarea.horas_estimadas 
    Tarea.fecha_resuelto 
    Tarea.fecha_alta 
    Tarea.cdg_usuario 
    Tarea.fecha_prevista 
    Tarea.cdg_tarea 
    Tarea.cdg_subclasepry 
    Tarea.cdg_recurso 
    Tarea.cdg_proyecto 
    */
    v_cdg_tipotarea
    TAREA.titulo 
    TAREA.descripcion 
    TAREA.cdg_tipotarea = v_cdg_tipotarea
    Tarea.cdg_tarea = empresa.cdg_empresa + STRING(tarea.nro_tarea,"9999")
    Tarea.cdg_sitio = empresa.cdg_empresa
    Tarea.reportado_ref  = userid("sic")
    Tarea.reportado_por = empresa.nombre
    Tarea.accion = r.
    Tarea.descripcion = v-v + v-r + tarea.descripcion.
END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE iniciar Dialog-Frame 
PROCEDURE iniciar :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
{findempresa.i}
    v_cdg_tipotarea = "".
FOR EACH tipo_tarea NO-LOCK:
    v_cdg_tipotarea = v_cdg_tipotarea + "," + tipo_tarea.cdg_tipotarea + "," + tipo_tarea.dsc.
END.
    v_cdg_tipotarea = substring(v_cdg_tipotarea,2).
v-v = ENTRY(1,r,CHR(13)).
v-r = ENTRY(2,r,CHR(13)).

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

