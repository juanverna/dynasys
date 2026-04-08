&ANALYZE-SUSPEND _VERSION-NUMBER UIB_v8r12 GUI
&ANALYZE-RESUME
/* Connected Databases 
          sic              PROGRESS
*/
&Scoped-define WINDOW-NAME CURRENT-WINDOW
&Scoped-define FRAME-NAME Dialog-Frame


/* Temp-Table and Buffer definitions                                    */
DEFINE BUFFER Administrador FOR Cliente.



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
DEFINE OUTPUT PARAMETER p-nro_rendicion  AS INTEGER.
&ELSE
DEFINE VARIABLE p-nro_rendicion  AS INTEGER.
&ENDIF

/* Local Variable Definitions ---                                       */

DEFINE VARIABLE rid_tabla AS ROWID.
DEFINE VARIABLE v-nro_administrador LIKE Administrador.nro_cliente.
DEFINE VARIABLE que_empresa LIKE Empresa.cdg_empresa.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE DIALOG-BOX
&Scoped-define DB-AWARE no

/* Name of designated FRAME-NAME and/or first browse and/or first query */
&Scoped-define FRAME-NAME Dialog-Frame
&Scoped-define BROWSE-NAME BROWSE-1

/* Internal Tables (found by Frame, Query & Browse Queries)             */
&Scoped-define INTERNAL-TABLES Rendicion_hd Cobrador

/* Definitions for BROWSE BROWSE-1                                      */
&Scoped-define FIELDS-IN-QUERY-BROWSE-1 Rendicion_hd.nro_rendicion Rendicion_hd.fch_rendicion Rendicion_hd.imp_imputado /*Rendicion_hd.imp_rendicion*/ Cobrador.cdg_cobrador Cobrador.nom_cobrador   
&Scoped-define ENABLED-FIELDS-IN-QUERY-BROWSE-1   
&Scoped-define SELF-NAME BROWSE-1
&Scoped-define QUERY-STRING-BROWSE-1 FOR EACH Rendicion_hd NO-LOCK     WHERE Rendicion_hd.nro_administrador = v-nro_administrador           AND Rendicion_hd.cdg_empresa = que_empresa, ~
                 FIRST Cobrador OF Rendicion_hd            BY Rendicion_hd.fch_rendicion DESCENDING
&Scoped-define OPEN-QUERY-BROWSE-1 OPEN QUERY {&SELF-NAME} FOR EACH Rendicion_hd NO-LOCK     WHERE Rendicion_hd.nro_administrador = v-nro_administrador           AND Rendicion_hd.cdg_empresa = que_empresa, ~
                 FIRST Cobrador OF Rendicion_hd            BY Rendicion_hd.fch_rendicion DESCENDING.
&Scoped-define TABLES-IN-QUERY-BROWSE-1 Rendicion_hd Cobrador
&Scoped-define FIRST-TABLE-IN-QUERY-BROWSE-1 Rendicion_hd
&Scoped-define SECOND-TABLE-IN-QUERY-BROWSE-1 Cobrador


/* Definitions for DIALOG-BOX Dialog-Frame                              */
&Scoped-define OPEN-BROWSERS-IN-QUERY-Dialog-Frame ~
    ~{&OPEN-QUERY-BROWSE-1}

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS v-cdg_administrador bVer BROWSE-1 Btn_Cancel ~
Btn_elegir 
&Scoped-Define DISPLAYED-OBJECTS v-cdg_administrador v-dsc_administrador 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME



/* ***********************  Control Definitions  ********************** */

/* Define a dialog box                                                  */

/* Definitions of the field level widgets                               */
DEFINE BUTTON Btn_Cancel AUTO-END-KEY 
     LABEL "&Cancelar" 
     SIZE 15 BY 1.14
     BGCOLOR 8 .

DEFINE BUTTON Btn_elegir AUTO-GO 
     LABEL "&Elegir" 
     SIZE 15 BY 1.14
     BGCOLOR 8 .

DEFINE BUTTON bVer 
     LABEL "Ver" 
     SIZE 8 BY 1.

DEFINE VARIABLE v-cdg_administrador AS CHARACTER FORMAT "X(8)" 
     LABEL "Administ." 
     VIEW-AS FILL-IN NATIVE 
     SIZE 13 BY 1
     BGCOLOR 15 FGCOLOR 9 .

DEFINE VARIABLE v-dsc_administrador AS CHARACTER FORMAT "X(35)" 
     VIEW-AS FILL-IN 
     SIZE 51 BY 1
     BGCOLOR 7 FGCOLOR 15 .

/* Query definitions                                                    */
&ANALYZE-SUSPEND
DEFINE QUERY BROWSE-1 FOR 
      Rendicion_hd, 
      Cobrador SCROLLING.
&ANALYZE-RESUME

/* Browse definitions                                                   */
DEFINE BROWSE BROWSE-1
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS BROWSE-1 Dialog-Frame _FREEFORM
  QUERY BROWSE-1 NO-LOCK DISPLAY
      Rendicion_hd.nro_rendicion 
      Rendicion_hd.fch_rendicion 
      Rendicion_hd.imp_imputado COLUMN-LABEL "Importe!Rendido"
      /*Rendicion_hd.imp_rendicion*/
      Cobrador.cdg_cobrador COLUMN-LABEL "Código de!Cobrador"
      Cobrador.nom_cobrador
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ROW-MARKERS SEPARATORS SIZE 86 BY 12.05
         BGCOLOR 15 FGCOLOR 9 FONT 4
         TITLE BGCOLOR 15 FGCOLOR 9 "Rendiciones del Administrador".


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME Dialog-Frame
     v-cdg_administrador AT ROW 1.48 COL 11 COLON-ALIGNED WIDGET-ID 4
     v-dsc_administrador AT ROW 1.48 COL 25 COLON-ALIGNED HELP
          "Denominacion" NO-LABEL WIDGET-ID 6
     bVer AT ROW 1.48 COL 79 WIDGET-ID 2
     BROWSE-1 AT ROW 2.67 COL 2
     Btn_Cancel AT ROW 14.81 COL 73
     Btn_elegir AT ROW 15 COL 2
     SPACE(72.19) SKIP(0.00)
    WITH VIEW-AS DIALOG-BOX KEEP-TAB-ORDER 
         SIDE-LABELS NO-UNDERLINE THREE-D  SCROLLABLE 
         FONT 4
         TITLE "Selección de Rendiciones de Cobranza"
         DEFAULT-BUTTON Btn_elegir CANCEL-BUTTON Btn_Cancel.


/* *********************** Procedure Settings ************************ */

&ANALYZE-SUSPEND _PROCEDURE-SETTINGS
/* Settings for THIS-PROCEDURE
   Type: DIALOG-BOX
   Allow: Basic,Browse,DB-Fields,Query
   Other Settings: COMPILE
   Temp-Tables and Buffers:
      TABLE: Administrador B "?" ? sic Cliente
   END-TABLES.
 */
&ANALYZE-RESUME _END-PROCEDURE-SETTINGS



/* ***********  Runtime Attributes and AppBuilder Settings  *********** */

&ANALYZE-SUSPEND _RUN-TIME-ATTRIBUTES
/* SETTINGS FOR DIALOG-BOX Dialog-Frame
   FRAME-NAME                                                           */
/* BROWSE-TAB BROWSE-1 bVer Dialog-Frame */
ASSIGN 
       FRAME Dialog-Frame:SCROLLABLE       = FALSE
       FRAME Dialog-Frame:HIDDEN           = TRUE.

/* SETTINGS FOR FILL-IN v-dsc_administrador IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME


/* Setting information for Queries and Browse Widgets fields            */

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE BROWSE-1
/* Query rebuild information for BROWSE BROWSE-1
     _START_FREEFORM
OPEN QUERY {&SELF-NAME} FOR EACH Rendicion_hd NO-LOCK
    WHERE Rendicion_hd.nro_administrador = v-nro_administrador
          AND Rendicion_hd.cdg_empresa = que_empresa,
          FIRST Cobrador OF Rendicion_hd
           BY Rendicion_hd.fch_rendicion DESCENDING.
     _END_FREEFORM
     _Options          = "NO-LOCK INDEXED-REPOSITION"
     _Where[1]         = "Cta_cte.nro_moneda = Moneda.nro_moneda
 AND Cta_cte.cdg_empresa = Empresa.cdg_empresa"
     _Query            is OPENED
*/  /* BROWSE BROWSE-1 */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _QUERY-BLOCK DIALOG-BOX Dialog-Frame
/* Query rebuild information for DIALOG-BOX Dialog-Frame
     _Options          = "SHARE-LOCK"
     _Query            is NOT OPENED
*/  /* DIALOG-BOX Dialog-Frame */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME Dialog-Frame
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Dialog-Frame Dialog-Frame
ON WINDOW-CLOSE OF FRAME Dialog-Frame /* Selección de Rendiciones de Cobranza */
DO:
  APPLY "END-ERROR":U TO SELF.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME Btn_Cancel
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Btn_Cancel Dialog-Frame
ON CHOOSE OF Btn_Cancel IN FRAME Dialog-Frame /* Cancelar */
DO:
  p-nro_rendicion = 0.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME Btn_elegir
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Btn_elegir Dialog-Frame
ON CHOOSE OF Btn_elegir IN FRAME Dialog-Frame /* Elegir */
DO:
  p-nro_rendicion = Rendicion_hd.nro_rendicion.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bVer
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bVer Dialog-Frame
ON CHOOSE OF bVer IN FRAME Dialog-Frame /* Ver */
DO:
  FIND administrador WHERE administrador.nro_cliente = cliente.nro_administrador NO-LOCK NO-ERROR.
    IF AVAILABLE administrador THEN
  RUN w-zoom_cliente.w ( INPUT ROWID(administrador) ).
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME v-cdg_administrador
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-cdg_administrador Dialog-Frame
ON MOUSE-SELECT-DBLCLICK OF v-cdg_administrador IN FRAME Dialog-Frame /* Administ. */
OR "." OF v-cdg_administrador IN FRAME {&FRAME-NAME}
OR MOUSE-MENU-DOWN OF v-cdg_administrador IN FRAME {&FRAME-NAME}
DO:
   {helptabla.i "Administrador" "cdg_cliente" "SELadminis.P"}
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-cdg_administrador Dialog-Frame
ON RETURN OF v-cdg_administrador IN FRAME Dialog-Frame /* Administ. */
DO:
    &SCOPED-DEFINE PONER-TABLA RUN poner_administrador.
   {traducetabla.i "Administrador" "cdg_cliente" "nom_cliente"} 
    &UNDEFINE PONER-TABLA 
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define BROWSE-NAME BROWSE-1
&UNDEFINE SELF-NAME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _MAIN-BLOCK Dialog-Frame 


/* ***************************  Main Block  *************************** */

/* Parent the dialog-box to the ACTIVE-WINDOW, if there is no parent.   */
IF VALID-HANDLE(ACTIVE-WINDOW) AND FRAME {&FRAME-NAME}:PARENT eq ?
THEN FRAME {&FRAME-NAME}:PARENT = ACTIVE-WINDOW.

{findempresa.i}
ASSIGN
  que_empresa = Empresa.cdg_empresa.
  
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
  DISPLAY v-cdg_administrador v-dsc_administrador 
      WITH FRAME Dialog-Frame.
  ENABLE v-cdg_administrador bVer BROWSE-1 Btn_Cancel Btn_elegir 
      WITH FRAME Dialog-Frame.
  VIEW FRAME Dialog-Frame.
  {&OPEN-BROWSERS-IN-QUERY-Dialog-Frame}
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE poner_administrador Dialog-Frame 
PROCEDURE poner_administrador :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

   ASSIGN v-nro_administrador = Administrador.nro_cliente.
   {&OPEN-QUERY-{&BROWSE-NAME}}

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

