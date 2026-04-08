&ANALYZE-SUSPEND _VERSION-NUMBER UIB_v8r12 GUI
&ANALYZE-RESUME
&Scoped-define WINDOW-NAME CURRENT-WINDOW
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _DEFINITIONS V-table-Win 
/*------------------------------------------------------------------------

  File:

  Description: from VIEWER.W - Template for SmartViewer Objects

  Input Parameters:
      <none>

  Output Parameters:
      <none>

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

/* Local Variable Definitions ---                                       */

DEFINE VARIABLE fec-desde                   AS DATE.
DEFINE VARIABLE fec-hasta                   AS DATE.
DEFINE VARIABLE hms-desde                   AS CHARACTER.
DEFINE VARIABLE hms-hasta                   AS CHARACTER.
DEFINE VARIABLE v-cdg_depsalida             LIKE Deposito.cdg_deposito INITIAL 1.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE SmartViewer

&Scoped-define ADM-SUPPORTED-LINKS Record-Source,Record-Target,TableIO-Target

/* Name of first Frame and/or Browse and/or first Query                 */
&Scoped-define FRAME-NAME F-Main

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS RECT-3 RECT-2 RECT-6 RECT-1 RECT-4 RECT-5 ~
v-debug btn_arrancar btn_manual 
&Scoped-Define DISPLAYED-OBJECTS v-estado v-desde-fecha v-frecuencia ~
v-desde-hora v-debug v-intervalo 

/* Custom List Definitions                                              */
/* ADM-CREATE-FIELDS,ADM-ASSIGN-FIELDS,List-3,List-4,List-5,List-6      */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _XFTR "Foreign Keys" V-table-Win _INLINE
/* Actions: ? adm/support/keyedit.w ? ? ? */
/* STRUCTURED-DATA
<KEY-OBJECT>
THIS-PROCEDURE
</KEY-OBJECT>
<FOREIGN-KEYS>
</FOREIGN-KEYS> 
<EXECUTING-CODE>
**************************
* Set attributes related to FOREIGN KEYS
*/
RUN set-attribute-list (
    'Keys-Accepted = "",
     Keys-Supplied = ""':U).
/**************************
</EXECUTING-CODE> */   

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


/* ***********************  Control Definitions  ********************** */


/* Definitions of handles for OCX Containers                            */
DEFINE VARIABLE CtrlFrame AS WIDGET-HANDLE NO-UNDO.
DEFINE VARIABLE chCtrlFrame AS COMPONENT-HANDLE NO-UNDO.

/* Definitions of the field level widgets                               */
DEFINE BUTTON btn_arrancar 
     LABEL "&Arrancar" 
     SIZE 26 BY 1.13
     FONT 4.

DEFINE BUTTON btn_detener 
     LABEL "&Detener" 
     SIZE 26 BY 1.13
     FONT 4.

DEFINE BUTTON btn_manual 
     LABEL "&Ejecutar manualmente" 
     SIZE 53 BY 1.13
     FONT 4.

DEFINE VARIABLE v-desde-fecha AS CHARACTER FORMAT "X(256)":U 
     LABEL "Fecha" 
     VIEW-AS FILL-IN NATIVE 
     SIZE 11 BY .81
     BGCOLOR 11 FGCOLOR 9 FONT 0 NO-UNDO.

DEFINE VARIABLE v-desde-hora AS CHARACTER FORMAT "X(256)":U 
     LABEL "Hora" 
     VIEW-AS FILL-IN NATIVE 
     SIZE 11 BY .81
     BGCOLOR 11 FGCOLOR 9 FONT 0 NO-UNDO.

DEFINE VARIABLE v-estado AS CHARACTER FORMAT "X(256)":U 
     LABEL "Estado" 
     VIEW-AS FILL-IN NATIVE 
     SIZE 45 BY .81
     BGCOLOR 11 FGCOLOR 9 FONT 0 NO-UNDO.

DEFINE VARIABLE v-frecuencia AS INTEGER FORMAT "->,>>>,>>9":U INITIAL 0 
     LABEL "Frecuencia (Segs.)" 
     VIEW-AS FILL-IN NATIVE 
     SIZE 11 BY .81
     BGCOLOR 11 FGCOLOR 9 FONT 0 NO-UNDO.

DEFINE VARIABLE v-intervalo AS INTEGER FORMAT "->,>>>,>>9":U INITIAL 0 
     LABEL "Intervalo" 
     VIEW-AS FILL-IN NATIVE 
     SIZE 11 BY .81
     BGCOLOR 11 FGCOLOR 9 FONT 0 NO-UNDO.

DEFINE RECTANGLE RECT-1
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL 
     SIZE 20 BY 2.75.

DEFINE RECTANGLE RECT-2
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL 
     SIZE 34 BY 2.75.

DEFINE RECTANGLE RECT-3
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL 
     SIZE 55 BY 1.5.

DEFINE RECTANGLE RECT-4
     EDGE-PIXELS 6 GRAPHIC-EDGE  NO-FILL 
     SIZE 61 BY 11.75.

DEFINE RECTANGLE RECT-5
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL 
     SIZE 55 BY 1.75.

DEFINE RECTANGLE RECT-6
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL 
     SIZE 55 BY 1.75.

DEFINE VARIABLE v-debug AS LOGICAL INITIAL no 
     LABEL "Activar Log" 
     VIEW-AS TOGGLE-BOX
     SIZE 11 BY .75 NO-UNDO.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME F-Main
     v-estado AT ROW 3.75 COL 9 COLON-ALIGNED
     v-desde-fecha AT ROW 6 COL 9 COLON-ALIGNED
     v-frecuencia AT ROW 6 COL 43 COLON-ALIGNED
     v-desde-hora AT ROW 7.25 COL 9 COLON-ALIGNED
     v-debug AT ROW 7.25 COL 27
     v-intervalo AT ROW 7.25 COL 43 COLON-ALIGNED
     btn_arrancar AT ROW 8.75 COL 5
     btn_detener AT ROW 8.75 COL 32
     btn_manual AT ROW 10.75 COL 5
     RECT-3 AT ROW 3.5 COL 4
     "  Ultimo disparo fue" VIEW-AS TEXT
          SIZE 14 BY .5 AT ROW 5.25 COL 6
     RECT-2 AT ROW 5.5 COL 25
     RECT-6 AT ROW 10.5 COL 4
     "    << Estado actual de ejecución de JARVIUS >>" VIEW-AS TEXT
          SIZE 55 BY 1.13 AT ROW 1.75 COL 4
          BGCOLOR 9 FGCOLOR 14 FONT 6
     RECT-1 AT ROW 5.5 COL 4
     "  Parámetros de la ejecución" VIEW-AS TEXT
          SIZE 20 BY .5 AT ROW 5.25 COL 31
     RECT-4 AT ROW 1 COL 1
     RECT-5 AT ROW 8.5 COL 4
     SPACE(0.00) SKIP(3.88)
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1 SCROLLABLE 
         FONT 4.


/* *********************** Procedure Settings ************************ */

&ANALYZE-SUSPEND _PROCEDURE-SETTINGS
/* Settings for THIS-PROCEDURE
   Type: SmartViewer
   Allow: Basic,DB-Fields
   Frames: 1
   Add Fields to: EXTERNAL-TABLES
   Other Settings: PERSISTENT-ONLY COMPILE
 */

/* This procedure should always be RUN PERSISTENT.  Report the error,  */
/* then cleanup and return.                                            */
IF NOT THIS-PROCEDURE:PERSISTENT THEN DO:
  MESSAGE "{&FILE-NAME} should only be RUN PERSISTENT."
          VIEW-AS ALERT-BOX ERROR BUTTONS OK.
  RETURN.
END.

&ANALYZE-RESUME _END-PROCEDURE-SETTINGS

/* *************************  Create Window  ************************** */

&ANALYZE-SUSPEND _CREATE-WINDOW
/* DESIGN Window definition (used by the UIB) 
  CREATE WINDOW V-table-Win ASSIGN
         HEIGHT             = 13.63
         WIDTH              = 66.
/* END WINDOW DEFINITION */
                                                                        */
&ANALYZE-RESUME


/* ***************  Runtime Attributes and UIB Settings  ************** */

&ANALYZE-SUSPEND _RUN-TIME-ATTRIBUTES
/* SETTINGS FOR WINDOW V-table-Win
  VISIBLE,,RUN-PERSISTENT                                               */
/* SETTINGS FOR FRAME F-Main
   NOT-VISIBLE Size-to-Fit                                              */
ASSIGN 
       FRAME F-Main:SCROLLABLE       = FALSE
       FRAME F-Main:HIDDEN           = TRUE.

/* SETTINGS FOR BUTTON btn_detener IN FRAME F-Main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN v-desde-fecha IN FRAME F-Main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN v-desde-hora IN FRAME F-Main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN v-estado IN FRAME F-Main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN v-frecuencia IN FRAME F-Main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN v-intervalo IN FRAME F-Main
   NO-ENABLE                                                            */
/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME


/* Setting information for Queries and Browse Widgets fields            */

&ANALYZE-SUSPEND _QUERY-BLOCK FRAME F-Main
/* Query rebuild information for FRAME F-Main
     _Options          = "NO-LOCK"
     _Query            is NOT OPENED
*/  /* FRAME F-Main */
&ANALYZE-RESUME

 


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _INCLUDED-LIB V-table-Win 
/* ************************* Included-Libraries *********************** */

{src/adm/method/viewer.i}

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME



/* **********************  Create OCX Containers  ********************** */

&ANALYZE-SUSPEND _CREATE-DYNAMIC

&IF "{&OPSYS}" = "WIN32":U AND "{&WINDOW-SYSTEM}" NE "TTY":U &THEN

CREATE CONTROL-FRAME CtrlFrame ASSIGN
       FRAME        = FRAME F-Main:HANDLE
       ROW          = 13.25
       COLUMN       = 5
       HEIGHT       = .88
       WIDTH        = 3.11
       HIDDEN       = yes
       SENSITIVE    = yes.

PROCEDURE adm-create-controls:
      CtrlFrame:NAME = "CtrlFrame":U .
/* CtrlFrame OCXINFO:CREATE-CONTROL from: {F0B88A90-F5DA-11CF-B545-0020AF6ED35A} type: PSTimer */
      CtrlFrame:MOVE-AFTER(btn_manual:HANDLE IN FRAME F-Main).

END PROCEDURE.

&ENDIF

&ANALYZE-RESUME /* End of _CREATE-DYNAMIC */


/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME btn_arrancar
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btn_arrancar V-table-Win
ON CHOOSE OF btn_arrancar IN FRAME F-Main /* Arrancar */
DO:
  btn_detener:SENSITIVE = YES.
  btn_arrancar:SENSITIVE = NO.
  btn_manual:SENSITIVE = NO.
  v-estado = "ESPERANDO...".
  DISPLAY v-estado
          WITH FRAME {&FRAME-NAME}.
  DISPLAY v-intervalo
          v-frecuencia
          WITH FRAME {&FRAME-NAME}.

  RUN borrar_log.
  RUN lanzar_proceso.

  chCtrlFrame:PSTimer:Interval = v-frecuencia * 100.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btn_detener
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btn_detener V-table-Win
ON CHOOSE OF btn_detener IN FRAME F-Main /* Detener */
DO:
  btn_detener:SENSITIVE = NO.
  btn_arrancar:SENSITIVE = YES.
  btn_manual:SENSITIVE = YES.
  v-estado = "DETENIDO !!!".
  DISPLAY v-estado
          WITH FRAME {&FRAME-NAME}.
  DISPLAY v-intervalo
          v-frecuencia
          WITH FRAME {&FRAME-NAME}.

  chCtrlFrame:PSTimer:Interval = 0.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btn_manual
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btn_manual V-table-Win
ON CHOOSE OF btn_manual IN FRAME F-Main /* Ejecutar manualmente */
DO:
  v-estado = "CORRIENDO...".
  DISPLAY v-estado
          WITH FRAME {&FRAME-NAME}.

  RUN borrar_log.
  RUN lanzar_proceso.

  btn_detener:SENSITIVE = YES.
  btn_arrancar:SENSITIVE = NO.
                       
  v-estado = "ESPERANDO...".
  DISPLAY v-estado
          WITH FRAME {&FRAME-NAME}.
        
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME CtrlFrame
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL CtrlFrame V-table-Win
PROCEDURE CtrlFrame.PSTimer.Tick .
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  None required for OCX.
  Notes:       
------------------------------------------------------------------------------*/

  RUN lanzar_proceso.
    
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&UNDEFINE SELF-NAME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _MAIN-BLOCK V-table-Win 


/* ***************************  Main Block  *************************** */

  &IF DEFINED(UIB_IS_RUNNING) <> 0 &THEN          
    RUN dispatch IN THIS-PROCEDURE ('initialize':U).        
  &ENDIF         
  
  /************************ INTERNAL PROCEDURES ********************/

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


/* **********************  Internal Procedures  *********************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE adm-row-available V-table-Win _ADM-ROW-AVAILABLE
PROCEDURE adm-row-available :
/*------------------------------------------------------------------------------
  Purpose:     Dispatched to this procedure when the Record-
               Source has a new row available.  This procedure
               tries to get the new row (or foriegn keys) from
               the Record-Source and process it.
  Parameters:  <none>
------------------------------------------------------------------------------*/

  /* Define variables needed by this internal procedure.             */
  {src/adm/template/row-head.i}

  /* Process the newly available records (i.e. display fields,
     open queries, and/or pass records on to any RECORD-TARGETS).    */
  {src/adm/template/row-end.i}

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE borrar_log V-table-Win 
PROCEDURE borrar_log :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

  OUTPUT TO "u:\desa\sic\r2.5\temp\reqpsp.log".
  PUT " " SKIP.
  OUTPUT CLOSE.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE control_load V-table-Win _CONTROL-LOAD
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

OCXFile = SEARCH( "v-par-jarvius.wrx":U ).
IF OCXFile = ? THEN
  OCXFile = SEARCH(SUBSTRING(THIS-PROCEDURE:FILE-NAME, 1,
                     R-INDEX(THIS-PROCEDURE:FILE-NAME, ".":U), "CHARACTER":U) + "wrx":U).

IF OCXFile <> ? THEN
DO:
  ASSIGN
    chCtrlFrame = CtrlFrame:COM-HANDLE
    UIB_S = chCtrlFrame:LoadControls( OCXFile, "CtrlFrame":U)
  .
  RUN DISPATCH IN THIS-PROCEDURE("initialize-controls":U) NO-ERROR.
END.
ELSE MESSAGE "v-par-jarvius.wrx":U SKIP(1)
             "The binary control file could not be found. The controls cannot be loaded."
             VIEW-AS ALERT-BOX TITLE "Controls Not Loaded".

&ENDIF

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE disable_UI V-table-Win _DEFAULT-DISABLE
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
  HIDE FRAME F-Main.
  IF THIS-PROCEDURE:PERSISTENT THEN DELETE PROCEDURE THIS-PROCEDURE.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE lanzar_proceso V-table-Win 
PROCEDURE lanzar_proceso :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

  ASSIGN FRAME {&FRAME-NAME} v-debug.
  fec-desde = TODAY.
  hms-desde = STRING(TIME,"HH:MM:SS").
  
  v-desde-fecha = STRING(fec-desde).
  v-desde-hora = hms-desde.

  DISPLAY   v-desde-fecha
            v-desde-hora
            WITH FRAME {&FRAME-NAME}.

  RUN sumahora.p ( INPUT  fec-desde,
                   INPUT  hms-desde,
                   OUTPUT fec-hasta,
                   OUTPUT hms-hasta,
                   INPUT  v-intervalo * 60 ).

  RUN requerir-psp.p ( INPUT  fec-desde,
                       INPUT  fec-hasta,
                       INPUT  hms-desde,
                       INPUT  hms-hasta,
                       INPUT  v-cdg_depsalida,
                       INPUT  v-debug) /* Deposito de salida forzado a 1 */.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE local-display-fields V-table-Win 
PROCEDURE local-display-fields :
/*------------------------------------------------------------------------------
  Purpose:     Override standard ADM method
  Notes:       
------------------------------------------------------------------------------*/

  /* Code placed here will execute PRIOR to standard behavior. */

  /* Dispatch standard ADM method.                             */
  RUN dispatch IN THIS-PROCEDURE ( INPUT 'display-fields':U ) .

  /* Code placed here will execute AFTER standard behavior.    */

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE local-view V-table-Win 
PROCEDURE local-view :
/*------------------------------------------------------------------------------
  Purpose:     Override standard ADM method
  Notes:       
------------------------------------------------------------------------------*/

  /* Code placed here will execute PRIOR to standard behavior. */

  /* Dispatch standard ADM method.                             */
  RUN dispatch IN THIS-PROCEDURE ( INPUT 'view':U ) .

  /* Code placed here will execute AFTER standard behavior.    */

   FIND Parametro "INTERVAL" NO-LOCK.
   v-intervalo = Parametro.valor_n.

   FIND Parametro "FRECUENC" NO-LOCK.
   v-frecuencia = Parametro.valor_n.

   DISPLAY v-intervalo
           v-frecuencia
           WITH FRAME {&FRAME-NAME}.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE send-records V-table-Win _ADM-SEND-RECORDS
PROCEDURE send-records :
/*------------------------------------------------------------------------------
  Purpose:     Send record ROWID's for all tables used by
               this file.
  Parameters:  see template/snd-head.i
------------------------------------------------------------------------------*/

  /* SEND-RECORDS does nothing because there are no External
     Tables specified for this SmartViewer, and there are no
     tables specified in any contained Browse, Query, or Frame. */

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE state-changed V-table-Win 
PROCEDURE state-changed :
/* -----------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
-------------------------------------------------------------*/
  DEFINE INPUT PARAMETER p-issuer-hdl AS HANDLE    NO-UNDO.
  DEFINE INPUT PARAMETER p-state      AS CHARACTER NO-UNDO.

  CASE p-state:
      /* Object instance CASEs can go here to replace standard behavior
         or add new cases. */
      {src/adm/template/vstates.i}
  END CASE.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


