&ANALYZE-SUSPEND _VERSION-NUMBER UIB_v8r12 GUI ADM1
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

  DEFINE VARIABLE h_window    AS HANDLE NO-UNDO.
  DEFINE VARIABLE c_window    AS CHAR   NO-UNDO.
  DEFINE VARIABLE que_reporte AS CHAR   NO-UNDO.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE SmartViewer
&Scoped-define DB-AWARE no

&Scoped-define ADM-SUPPORTED-LINKS Record-Source,Record-Target,TableIO-Target

/* Name of first Frame and/or Browse and/or first Query                 */
&Scoped-define FRAME-NAME F-Main

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS RECT-11 btn_salir v-formato_salida ~
v-FechaList v-graba 
&Scoped-Define DISPLAYED-OBJECTS v-preview v-formato_salida v-FechaList ~
v-graba 

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


/* Menu Definitions                                                     */
DEFINE MENU POPUP-MENU-v-FechaList 
       MENU-ITEM m_Elimina      LABEL "Elimina"       .


/* Definitions of the field level widgets                               */
DEFINE BUTTON btn_ejecutar 
     IMAGE-UP FILE "iconos24/checks.jpg":U NO-FOCUS FLAT-BUTTON
     LABEL "&Ejecutar" 
     SIZE 5.4 BY 1.29 TOOLTIP "Ejecutar".

DEFINE BUTTON btn_salir DEFAULT 
     IMAGE-UP FILE "iconos24/error.jpg":U
     LABEL "&Salir" 
     SIZE 5.4 BY 1.29 TOOLTIP "Salir"
     BGCOLOR 8 .

DEFINE VARIABLE v-FechaList AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS COMBO-BOX INNER-LINES 5
     DROP-DOWN-LIST
     SIZE 34 BY 1
     BGCOLOR 15 FGCOLOR 9  NO-UNDO.

DEFINE VARIABLE v-formato_salida AS CHARACTER FORMAT "X(256)":U INITIAL "RPT" 
     LABEL "Formato de Salida" 
     VIEW-AS COMBO-BOX INNER-LINES 5
     DROP-DOWN-LIST
     SIZE 10 BY 1
     BGCOLOR 15 FGCOLOR 9  NO-UNDO.

DEFINE RECTANGLE RECT-11
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 100 BY 2.38.

DEFINE VARIABLE v-graba AS LOGICAL INITIAL no 
     LABEL "Graba" 
     VIEW-AS TOGGLE-BOX
     SIZE 11 BY .81 NO-UNDO.

DEFINE VARIABLE v-preview AS LOGICAL INITIAL yes 
     LABEL "Preview" 
     VIEW-AS TOGGLE-BOX
     SIZE 13 BY .95 NO-UNDO.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME F-Main
     btn_ejecutar AT ROW 1.48 COL 86 WIDGET-ID 12
     v-preview AT ROW 1.24 COL 33 WIDGET-ID 16
     btn_salir AT ROW 1.48 COL 92
     v-formato_salida AT ROW 1.67 COL 19 COLON-ALIGNED WIDGET-ID 14
     v-FechaList AT ROW 1.71 COL 48 COLON-ALIGNED NO-LABEL WIDGET-ID 20
     v-graba AT ROW 2.19 COL 33 WIDGET-ID 22
     RECT-11 AT ROW 1 COL 1
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1 SCROLLABLE .


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
  MESSAGE "{&FILE-NAME} should only be RUN PERSISTENT.":U
          VIEW-AS ALERT-BOX ERROR BUTTONS OK.
  RETURN.
END.

&ANALYZE-RESUME _END-PROCEDURE-SETTINGS

/* *************************  Create Window  ************************** */

&ANALYZE-SUSPEND _CREATE-WINDOW
/* DESIGN Window definition (used by the UIB) 
  CREATE WINDOW V-table-Win ASSIGN
         HEIGHT             = 4.19
         WIDTH              = 110.8.
/* END WINDOW DEFINITION */
                                                                        */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _INCLUDED-LIB V-table-Win 
/* ************************* Included-Libraries *********************** */

{crystal_dyna.p}
{src/adm/method/viewer.i}

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME




/* ***********  Runtime Attributes and AppBuilder Settings  *********** */

&ANALYZE-SUSPEND _RUN-TIME-ATTRIBUTES
/* SETTINGS FOR WINDOW V-table-Win
  VISIBLE,,RUN-PERSISTENT                                               */
/* SETTINGS FOR FRAME F-Main
   NOT-VISIBLE Size-to-Fit                                              */
ASSIGN 
       FRAME F-Main:SCROLLABLE       = FALSE
       FRAME F-Main:HIDDEN           = TRUE.

/* SETTINGS FOR BUTTON btn_ejecutar IN FRAME F-Main
   NO-ENABLE                                                            */
ASSIGN 
       v-FechaList:POPUP-MENU IN FRAME F-Main       = MENU POPUP-MENU-v-FechaList:HANDLE.

/* SETTINGS FOR TOGGLE-BOX v-preview IN FRAME F-Main
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

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME btn_ejecutar
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btn_ejecutar V-table-Win
ON CHOOSE OF btn_ejecutar IN FRAME F-Main /* Ejecutar */
DO:
    ASSIGN v-formato_salida v-preview v-fechalist.
    RUN get-link-handle IN adm-broker-hdl
       (THIS-PROCEDURE, 'Container-Source':U, OUTPUT c_window).
    h_window = WIDGET-HANDLE (c_window).
    RUN lst-ejecutar IN h_window  ( INPUT v-formato_salida, INPUT v-preview , INPUT v-fechalist ).
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btn_salir
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btn_salir V-table-Win
ON CHOOSE OF btn_salir IN FRAME F-Main /* Salir */
DO:
  RUN get-link-handle IN adm-broker-hdl
       (THIS-PROCEDURE, 'Container-Source':U, OUTPUT c_window).
  IF NUM-ENTRIES (c_window) eq 1 THEN DO:
    h_window = WIDGET-HANDLE (c_window).
    RUN salir IN h_window.
  END.
  ELSE MESSAGE c_window VIEW-AS ALERT-BOX MESSAGE TITLE "p-ejecutar.w".

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME m_Elimina
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL m_Elimina V-table-Win
ON CHOOSE OF MENU-ITEM m_Elimina /* Elimina */
DO:
  DEFINE VAR ii AS INTEGER NO-UNDO.
  DEFINE VAR opc AS LOGICAL NO-UNDO.
  MESSAGE "Desea eliminar esta instancia del reporte" VIEW-AS ALERT-BOX QUESTION BUTTONS YES-NO SET opc.
  IF opc THEN DO:
      FIND datalistados WHERE datalistados.reporte = que_reporte AND
      fecha = DATETIME(v-fechalist:SCREEN-VALUE IN FRAME {&FRAME-NAME}).
      DELETE datalistados.
      ii = 0.
      v-fechalist:LIST-ITEMS = "".
      FOR EACH datalistados WHERE datalistados.reporte = listadef.reporte NO-LOCK:
        v-fechalist:add-last(string(datalistados.fecha)).
        ii = ii + 1.
        IF ii > 10 THEN LEAVE.
      END.
      IF num-entries(v-fechalist:LIST-ITEMS) > 0 THEN v-fechalist = entry(1,v-fechalist:LIST-ITEMS).
  END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME v-FechaList
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-FechaList V-table-Win
ON VALUE-CHANGED OF v-FechaList IN FRAME F-Main
DO:
  ASSIGN v-fechaList.
  v-graba:SENSITIVE = ( v-fechalist = "Ejecutar" ) AND listadef.admite_graba.
END.

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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE adm-row-available V-table-Win  _ADM-ROW-AVAILABLE
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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE disable_UI V-table-Win  _DEFAULT-DISABLE
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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE local-initialize V-table-Win 
PROCEDURE local-initialize :
/*------------------------------------------------------------------------------
  Purpose:     Override standard ADM method
  Notes:       
------------------------------------------------------------------------------*/

DEFINE VAR ii AS INT NO-UNDO.
{findempresa.i}

  /* Code placed here will execute PRIOR to standard behavior. */
  
  /* Dispatch standard ADM method.                             */
  RUN dispatch IN THIS-PROCEDURE ( INPUT 'initialize':U ) .

  /* Code placed here will execute AFTER standard behavior.    */


DO WITH FRAME {&FRAME-NAME}:
  RUN get-link-handle IN adm-broker-hdl
     (THIS-PROCEDURE, 'Container-Source':U, OUTPUT c_window).
  h_window = WIDGET-HANDLE (c_window).
  IF NOT VALID-HANDLE(h_window) THEN RETURN.
  que_reporte = dynamic-function("que_listado" IN h_window ).
/*analisis de los permisos para el usuario*/

FIND listadef WHERE listadef.reporte = que_reporte NO-LOCK NO-ERROR.

IF NOT AVAILABLE listadef THEN DO:
    RUN mensajepar.p (INPUT que_reporte, INPUT "CREP000").
    RETURN ERROR.
END.
/*salir no permitido informar*/
IF NOT CAN-DO(listadef.lst_empresa,empresa.cdg_empresa) THEN DO:
    RUN mensajepar.p (INPUT que_reporte, INPUT "CREP005").
END.
btn_ejecutar:SENSITIVE = YES.
v-fechalist:LIST-ITEMS = "".
IF CAN-DO(listadef.lstR_usuario,USERID("sic")) THEN DO:
    v-fechalist:LIST-ITEMS  = "Ejecutar".
    v-fechalist:screen-value = entry(1,v-fechalist:LIST-ITEMS ).
END.
ii = 0.
FOR EACH datalistados WHERE datalistados.reporte = listadef.reporte NO-LOCK:
    v-fechalist:add-last(STRING(datalistados.fecha)).
    ii = ii + 1.
    IF ii > 10 THEN LEAVE.
END.
IF num-entries(v-fechalist:LIST-ITEMS) > 0 THEN v-fechalist = entry(1,v-fechalist:LIST-ITEMS).
v-fechalist:SENSITIVE = NUM-ENTRIES( v-fechalist:LIST-ITEMS ) > 1.
IF CAN-DO(listadef.lstV_usuario,USERID("sic")) THEN v-formato_salida:LIST-ITEMS = listadef.lst_visualizacion.
ELSE v-formato_salida:LIST-ITEMS = listadef.dfl_visualizacion.
v-formato_salida = listadef.dfl_visualizacion.
v-formato_salida:SENSITIVE = NUM-ENTRIES(v-formato_salida:LIST-ITEMS ) > 1.
v-preview:SENSITIVE = listadef.admite_preview.
v-preview = sic.Listadef.dfl_preview.
v-graba:SENSITIVE = ( v-fechalist = "Ejecutar" ) AND listadef.admite_graba.
v-graba = sic.Listadef.dfl_graba.

DISPLAY v-formato_salida v-preview v-fechalist v-graba.
        /* Ask the Record-Source for the current customer record.  Make sure
     there is only one.*/
END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE send-records V-table-Win  _ADM-SEND-RECORDS
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

