&ANALYZE-SUSPEND _VERSION-NUMBER UIB_v8r12 GUI
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
/*          This .W file was created with the Progress UIB.             */
/*----------------------------------------------------------------------*/

/* ***************************  Definitions  ************************** */

/* Parameters Definitions ---                                           */

&IF DEFINED(UIB_is_Running) EQ 0
&THEN
DEFINE INPUT PARAMETER rid_cliente AS ROWID.
DEFINE INPUT PARAMETER rid_moneda  AS ROWID.
&ELSE
DEFINE VARIABLE rid_cliente AS ROWID.
DEFINE VARIABLE rid_moneda  AS ROWID.
&ENDIF

/* Local Variable Definitions ---                                       */

DEFINE VARIABLE st_seleccionado AS CHARACTER.
DEFINE VARIABLE que_empresa LIKE Empresa.cdg_empresa.
DEFINE VARIABLE que_moneda  LIKE Moneda.nro_moneda.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE DIALOG-BOX

/* Name of first Frame and/or Browse and/or first Query                 */
&Scoped-define FRAME-NAME Dialog-Frame
&Scoped-define BROWSE-NAME BROWSE-1

/* Internal Tables (found by Frame, Query & Browse Queries)             */
&Scoped-define INTERNAL-TABLES Cta_cte Cliente Moneda

/* Definitions for BROWSE BROWSE-1                                      */
&Scoped-define FIELDS-IN-QUERY-BROWSE-1 Cta_cte.tip_comprob Cta_cte.prf_comprob Cta_cte.nro_comprob Cta_cte.fecha_emision Cta_cte.fecha_vencimiento Cta_cte.debito Cta_cte.credito Cta_cte.liberada Cta_cte.selectado   
&Scoped-define ENABLED-FIELDS-IN-QUERY-BROWSE-1   
&Scoped-define FIELD-PAIRS-IN-QUERY-BROWSE-1
&Scoped-define SELF-NAME BROWSE-1
&Scoped-define OPEN-QUERY-BROWSE-1 OPEN QUERY {&SELF-NAME} FOR EACH Cta_cte NO-LOCK OF Cliente         WHERE Cta_cte.cdg_empresa = que_empresa           AND Cta_cte.nro_moneda = que_moneda           AND Cta_cte.debito <> Cta_cte.credito           AND NOT Cta_cte.imputado            BY Cta_cte.fecha_vencimiento.
&Scoped-define TABLES-IN-QUERY-BROWSE-1 Cta_cte
&Scoped-define FIRST-TABLE-IN-QUERY-BROWSE-1 Cta_cte


/* Definitions for DIALOG-BOX Dialog-Frame                              */
&Scoped-define FIELDS-IN-QUERY-Dialog-Frame Cliente.cdg_cliente ~
Cliente.nom_cliente Moneda.cdg_moneda Moneda.descripcion 
&Scoped-define ENABLED-FIELDS-IN-QUERY-Dialog-Frame Cliente.cdg_cliente ~
Moneda.cdg_moneda 
&Scoped-define ENABLED-TABLES-IN-QUERY-Dialog-Frame Cliente Moneda
&Scoped-define FIRST-ENABLED-TABLE-IN-QUERY-Dialog-Frame Cliente
&Scoped-define SECOND-ENABLED-TABLE-IN-QUERY-Dialog-Frame Moneda

&Scoped-define FIELD-PAIRS-IN-QUERY-Dialog-Frame~
 ~{&FP1}cdg_cliente ~{&FP2}cdg_cliente ~{&FP3}~
 ~{&FP1}cdg_moneda ~{&FP2}cdg_moneda ~{&FP3}
&Scoped-define OPEN-BROWSERS-IN-QUERY-Dialog-Frame ~
    ~{&OPEN-QUERY-BROWSE-1}
&Scoped-define OPEN-QUERY-Dialog-Frame OPEN QUERY Dialog-Frame FOR EACH Cliente SHARE-LOCK, ~
      EACH Moneda WHERE TRUE /* Join to Cliente incomplete */ SHARE-LOCK.
&Scoped-define TABLES-IN-QUERY-Dialog-Frame Cliente Moneda
&Scoped-define FIRST-TABLE-IN-QUERY-Dialog-Frame Cliente


/* Standard List Definitions                                            */
&Scoped-Define ENABLED-FIELDS Cliente.cdg_cliente Moneda.cdg_moneda 
&Scoped-define FIELD-PAIRS~
 ~{&FP1}cdg_cliente ~{&FP2}cdg_cliente ~{&FP3}~
 ~{&FP1}cdg_moneda ~{&FP2}cdg_moneda ~{&FP3}
&Scoped-define ENABLED-TABLES Cliente Moneda
&Scoped-define FIRST-ENABLED-TABLE Cliente
&Scoped-define SECOND-ENABLED-TABLE Moneda
&Scoped-Define ENABLED-OBJECTS BROWSE-1 Btn_elegir Btn_Cancel 
&Scoped-Define DISPLAYED-FIELDS Cliente.cdg_cliente Cliente.nom_cliente ~
Moneda.cdg_moneda Moneda.descripcion 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME



/* ***********************  Control Definitions  ********************** */

/* Define a dialog box                                                  */

/* Definitions of the field level widgets                               */
DEFINE BUTTON Btn_Cancel AUTO-END-KEY 
     LABEL "&Cancelar" 
     SIZE 15 BY 1.15
     BGCOLOR 8 .

DEFINE BUTTON Btn_elegir AUTO-GO 
     LABEL "&Elegir" 
     SIZE 15 BY 1.15
     BGCOLOR 8 .

/* Query definitions                                                    */
&ANALYZE-SUSPEND
DEFINE QUERY BROWSE-1 FOR 
      Cta_cte SCROLLING.

DEFINE QUERY Dialog-Frame FOR 
      Cliente, 
      Moneda SCROLLING.
&ANALYZE-RESUME

/* Browse definitions                                                   */
DEFINE BROWSE BROWSE-1
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS BROWSE-1 Dialog-Frame _FREEFORM
  QUERY BROWSE-1 NO-LOCK DISPLAY
      Cta_cte.tip_comprob COLUMN-LABEL "Tipo!Comp"
      Cta_cte.prf_comprob COLUMN-LABEL "Pto.!Vta."
      Cta_cte.nro_comprob COLUMN-LABEL "Número!Comprobte."
      Cta_cte.fecha_emision COLUMN-LABEL "Fecha!Emisión"
      Cta_cte.fecha_vencimiento COLUMN-LABEL "Fecha!Vencimiento"
      Cta_cte.debito COLUMN-LABEL "Importe!Débito"
      Cta_cte.credito COLUMN-LABEL "Importe!Crédito"
      Cta_cte.liberada COLUMN-LABEL "Libe-!rada"
      Cta_cte.selectado
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ROW-MARKERS SEPARATORS SIZE 82 BY 11.04
         BGCOLOR 15 FGCOLOR 9 FONT 4
         TITLE BGCOLOR 15 FGCOLOR 9 "Documentos Pendientes".


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME Dialog-Frame
     Cliente.cdg_cliente AT ROW 1.27 COL 16 COLON-ALIGNED
          LABEL "Cliente"
          VIEW-AS FILL-IN 
          SIZE 10 BY .81
     Cliente.nom_cliente AT ROW 1.27 COL 27 COLON-ALIGNED NO-LABEL
          VIEW-AS FILL-IN 
          SIZE 42 BY .81
          BGCOLOR 7 FGCOLOR 15 
     Moneda.cdg_moneda AT ROW 2.35 COL 16 COLON-ALIGNED
          VIEW-AS FILL-IN 
          SIZE 10 BY .81
     Moneda.descripcion AT ROW 2.35 COL 27 COLON-ALIGNED NO-LABEL
          VIEW-AS FILL-IN 
          SIZE 42 BY .81
          BGCOLOR 7 FGCOLOR 15 
     BROWSE-1 AT ROW 3.69 COL 2
     Btn_elegir AT ROW 15 COL 2
     Btn_Cancel AT ROW 15 COL 69
     SPACE(1.56) SKIP(0.00)
    WITH VIEW-AS DIALOG-BOX KEEP-TAB-ORDER 
         SIDE-LABELS NO-UNDERLINE THREE-D  SCROLLABLE 
         FONT 4
         TITLE "Selección de Documentos de Cuenta Corriente"
         DEFAULT-BUTTON Btn_elegir CANCEL-BUTTON Btn_Cancel.


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
/* BROWSE-TAB BROWSE-1 descripcion Dialog-Frame */
ASSIGN 
       FRAME Dialog-Frame:SCROLLABLE       = FALSE
       FRAME Dialog-Frame:HIDDEN           = TRUE.

/* SETTINGS FOR FILL-IN Cliente.cdg_cliente IN FRAME Dialog-Frame
   EXP-LABEL                                                            */
/* SETTINGS FOR FILL-IN Moneda.descripcion IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN Cliente.nom_cliente IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME


/* Setting information for Queries and Browse Widgets fields            */

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE BROWSE-1
/* Query rebuild information for BROWSE BROWSE-1
     _START_FREEFORM
OPEN QUERY {&SELF-NAME} FOR EACH Cta_cte NO-LOCK OF Cliente
        WHERE Cta_cte.cdg_empresa = que_empresa
          AND Cta_cte.nro_moneda = que_moneda
          AND Cta_cte.debito <> Cta_cte.credito
          AND NOT Cta_cte.imputado
           BY Cta_cte.fecha_vencimiento.
     _END_FREEFORM
     _Options          = "NO-LOCK INDEXED-REPOSITION"
     _Where[1]         = "Cta_cte.nro_moneda = Moneda.nro_moneda
 AND Cta_cte.cdg_empresa = Empresa.cdg_empresa"
     _Query            is OPENED
*/  /* BROWSE BROWSE-1 */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _QUERY-BLOCK DIALOG-BOX Dialog-Frame
/* Query rebuild information for DIALOG-BOX Dialog-Frame
     _TblList          = "sic.Cliente,sic.Moneda WHERE sic.Cliente ..."
     _Options          = "SHARE-LOCK"
     _Query            is NOT OPENED
*/  /* DIALOG-BOX Dialog-Frame */
&ANALYZE-RESUME

 




/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME Dialog-Frame
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Dialog-Frame Dialog-Frame
ON WINDOW-CLOSE OF FRAME Dialog-Frame /* Selección de Documentos de Cuenta Corriente */
DO:
  APPLY "END-ERROR":U TO SELF.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define BROWSE-NAME BROWSE-1
&Scoped-define SELF-NAME BROWSE-1
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL BROWSE-1 Dialog-Frame
ON MOUSE-SELECT-DBLCLICK OF BROWSE-1 IN FRAME Dialog-Frame /* Documentos Pendientes */
DO:
  FIND CURRENT Cta_cte EXCLUSIVE-LOCK.
  Cta_cte.selectado = NOT Cta_cte.selectado.
  IF Cta_cte.selectado 
    THEN Cta_cte.user-id-sel = st_seleccionado.
    ELSE Cta_cte.user-id-sel = "".
  FIND CURRENT Cta_cte NO-LOCK.

  DISPLAY Cta_cte.selectado WITH BROWSE BROWSE-1.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME Btn_Cancel
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Btn_Cancel Dialog-Frame
ON CHOOSE OF Btn_Cancel IN FRAME Dialog-Frame /* Cancelar */
DO:
   FOR EACH Cta_cte WHERE Cta_cte.user-id-sel = st_seleccionado:
      Cta_cte.selectado = NO.
      Cta_cte.user-id-sel = "".
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

FIND Cliente WHERE ROWID(Cliente) = rid_cliente NO-LOCK.
FIND Moneda  WHERE ROWID(Moneda) = rid_moneda NO-LOCK.
st_seleccionado = "UU-" + USERID("SIC").
{findempresa.i}

ASSIGN
  que_empresa = Empresa.cdg_empresa.
  que_moneda = Moneda.nro_moneda.

/* Now enable the interface and wait for the exit condition.            */
/* (NOTE: handle ERROR and END-KEY so cleanup code will always fire.    */
MAIN-BLOCK:
DO ON ERROR   UNDO MAIN-BLOCK, LEAVE MAIN-BLOCK
   ON END-KEY UNDO MAIN-BLOCK, LEAVE MAIN-BLOCK:
  RUN enable_UI.
  /*RUN abre_query.*/
  WAIT-FOR GO OF FRAME {&FRAME-NAME}.
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
  IF AVAILABLE Cliente THEN 
    DISPLAY Cliente.cdg_cliente Cliente.nom_cliente 
      WITH FRAME Dialog-Frame.
  IF AVAILABLE Moneda THEN 
    DISPLAY Moneda.cdg_moneda Moneda.descripcion 
      WITH FRAME Dialog-Frame.
  ENABLE Cliente.cdg_cliente Moneda.cdg_moneda BROWSE-1 Btn_elegir Btn_Cancel 
      WITH FRAME Dialog-Frame.
  VIEW FRAME Dialog-Frame.
  {&OPEN-BROWSERS-IN-QUERY-Dialog-Frame}
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


