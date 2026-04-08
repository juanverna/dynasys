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

  &IF DEFINED(UIB_is_Running) NE 0
  &THEN
  DEFINE VARIABLE p-rid_cliente    AS ROWID.
  FIND Cliente WHERE Cliente.cdg_cliente = "132696" NO-LOCK.
  p-rid_cliente = ROWID(Cliente).

  &ELSE
  DEFINE INPUT PARAMETER p-rid_cliente    AS ROWID.
  &ENDIF

/* Local Variable Definitions ---                                       */

DEFINE TEMP-TABLE T-Estado
  FIELD cdg_empresa    LIKE Empresa.cdg_empresa COLUMN-LABEL "Em-!presa"
  FIELD saldo_cc       AS DECIMAL COLUMN-LABEL "Saldo!Cta.Cte." FORMAT "->>>,>>>,>>9.99"
  FIELD saldo_ccv      AS DECIMAL COLUMN-LABEL "Saldo!Vencido"  FORMAT "->>>,>>>,>>9.99"
  FIELD tot_valores    AS DECIMAL COLUMN-LABEL "Valores!p/Acred." FORMAT "->>>,>>>,>>9.99"
  FIELD tot_remitos    AS DECIMAL COLUMN-LABEL "Remitos!S/Facturar" FORMAT "->>>,>>>,>>9.99"
  FIELD tot_pedidos    AS DECIMAL COLUMN-LABEL "Pedidos!S/Remitir" FORMAT "->>>,>>>,>>9.99"
  FIELD cant_rech      AS INTEGER COLUMN-LABEL "Cheq!Rech" FORMAT ">>>9"
  FIELD tot_credito    AS DECIMAL COLUMN-LABEL "Crédito!Consumido" FORMAT "->>>,>>>,>>9.99"
  INDEX por_empresa    IS PRIMARY cdg_empresa ASCENDING.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE DIALOG-BOX
&Scoped-define DB-AWARE no

/* Name of first Frame and/or Browse and/or first Query                 */
&Scoped-define FRAME-NAME Dialog-Frame
&Scoped-define BROWSE-NAME BROWSE-1

/* Internal Tables (found by Frame, Query & Browse Queries)             */
&Scoped-define INTERNAL-TABLES T-Estado Cliente

/* Definitions for BROWSE BROWSE-1                                      */
&Scoped-define FIELDS-IN-QUERY-BROWSE-1 T-Estado.cdg_empresa T-Estado.saldo_cc T-Estado.saldo_ccv T-Estado.tot_valores T-Estado.tot_remitos T-Estado.tot_pedidos T-Estado.cant_rech T-Estado.tot_credito   
&Scoped-define ENABLED-FIELDS-IN-QUERY-BROWSE-1   
&Scoped-define SELF-NAME BROWSE-1
&Scoped-define QUERY-STRING-BROWSE-1 FOR EACH T-Estado WHERE T-Estado.tot_credito <> 0 BY T-Estado.cdg_empresa
&Scoped-define OPEN-QUERY-BROWSE-1 OPEN QUERY {&SELF-NAME} FOR EACH T-Estado WHERE T-Estado.tot_credito <> 0 BY T-Estado.cdg_empresa.
&Scoped-define TABLES-IN-QUERY-BROWSE-1 T-Estado
&Scoped-define FIRST-TABLE-IN-QUERY-BROWSE-1 T-Estado


/* Definitions for DIALOG-BOX Dialog-Frame                              */
&Scoped-define FIELDS-IN-QUERY-Dialog-Frame Cliente.cdg_cliente ~
Cliente.nom_cliente Cliente.credito_maximo 
&Scoped-define ENABLED-FIELDS-IN-QUERY-Dialog-Frame Cliente.credito_maximo 
&Scoped-define ENABLED-TABLES-IN-QUERY-Dialog-Frame Cliente
&Scoped-define FIRST-ENABLED-TABLE-IN-QUERY-Dialog-Frame Cliente
&Scoped-define OPEN-BROWSERS-IN-QUERY-Dialog-Frame ~
    ~{&OPEN-QUERY-BROWSE-1}
&Scoped-define QUERY-STRING-Dialog-Frame FOR EACH Cliente SHARE-LOCK
&Scoped-define OPEN-QUERY-Dialog-Frame OPEN QUERY Dialog-Frame FOR EACH Cliente SHARE-LOCK.
&Scoped-define TABLES-IN-QUERY-Dialog-Frame Cliente
&Scoped-define FIRST-TABLE-IN-QUERY-Dialog-Frame Cliente


/* Standard List Definitions                                            */
&Scoped-Define ENABLED-FIELDS Cliente.credito_maximo 
&Scoped-define ENABLED-TABLES Cliente
&Scoped-define FIRST-ENABLED-TABLE Cliente
&Scoped-Define ENABLED-OBJECTS Btn_OK BROWSE-1 v-tot_credito dis_credito ~
RECT-2 
&Scoped-Define DISPLAYED-FIELDS Cliente.cdg_cliente Cliente.nom_cliente ~
Cliente.credito_maximo 
&Scoped-define DISPLAYED-TABLES Cliente
&Scoped-define FIRST-DISPLAYED-TABLE Cliente
&Scoped-Define DISPLAYED-OBJECTS v-tot_credito dis_credito 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME



/* ***********************  Control Definitions  ********************** */

/* Define a dialog box                                                  */

/* Definitions of the field level widgets                               */
DEFINE BUTTON Btn_OK AUTO-GO 
     LABEL "&Salir" 
     SIZE 15 BY 1.14
     BGCOLOR 8 .

DEFINE VARIABLE dis_credito AS DECIMAL FORMAT "->,>>>,>>>,>>9.99":U INITIAL 0 
     LABEL "Disponible" 
     VIEW-AS FILL-IN 
     SIZE 24 BY 1
     BGCOLOR 15 FGCOLOR 9 FONT 2 NO-UNDO.

DEFINE VARIABLE v-tot_credito AS DECIMAL FORMAT "->,>>>,>>>,>>9.99":U INITIAL 0 
     LABEL "Consumido" 
     VIEW-AS FILL-IN 
     SIZE 23 BY 1
     BGCOLOR 15 FGCOLOR 9 FONT 2 NO-UNDO.

DEFINE RECTANGLE RECT-2
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL 
     SIZE 117 BY 1.67.

/* Query definitions                                                    */
&ANALYZE-SUSPEND
DEFINE QUERY BROWSE-1 FOR 
      T-Estado SCROLLING.

DEFINE QUERY Dialog-Frame FOR 
      Cliente SCROLLING.
&ANALYZE-RESUME

/* Browse definitions                                                   */
DEFINE BROWSE BROWSE-1
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS BROWSE-1 Dialog-Frame _FREEFORM
  QUERY BROWSE-1 DISPLAY
      T-Estado.cdg_empresa    
      T-Estado.saldo_cc       
      T-Estado.saldo_ccv      
      T-Estado.tot_valores    
      T-Estado.tot_remitos    
      T-Estado.tot_pedidos    
      T-Estado.cant_rech      
      T-Estado.tot_credito
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ROW-MARKERS SIZE 117 BY 6.67
         FONT 4
         TITLE "Composición de crédito por empresa".


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME Dialog-Frame
     Cliente.cdg_cliente AT ROW 1.24 COL 7 COLON-ALIGNED
          LABEL "Cliente"
          VIEW-AS FILL-IN 
          SIZE 24 BY 1
          BGCOLOR 15 FGCOLOR 9 
     Cliente.nom_cliente AT ROW 1.24 COL 32 COLON-ALIGNED NO-LABEL
          VIEW-AS FILL-IN 
          SIZE 68 BY 1
          BGCOLOR 15 FGCOLOR 9 
     Btn_OK AT ROW 1.24 COL 104
     BROWSE-1 AT ROW 2.67 COL 2
     v-tot_credito AT ROW 10.71 COL 50 COLON-ALIGNED
     dis_credito AT ROW 10.71 COL 91 COLON-ALIGNED
     Cliente.credito_maximo AT ROW 10.76 COL 10 COLON-ALIGNED
          LABEL "Máximo" FORMAT "->,>>>,>>>,>>9.99"
          VIEW-AS FILL-IN 
          SIZE 23 BY 1
          BGCOLOR 15 FGCOLOR 9 FONT 2
     RECT-2 AT ROW 10.48 COL 2
     "  Valores Totales de Crédito para el Cliente Actual" VIEW-AS TEXT
          SIZE 117 BY .81 AT ROW 9.57 COL 2
          BGCOLOR 3 FGCOLOR 15 FONT 6
     SPACE(1.19) SKIP(1.99)
    WITH VIEW-AS DIALOG-BOX KEEP-TAB-ORDER 
         SIDE-LABELS NO-UNDERLINE THREE-D  SCROLLABLE 
         FONT 4
         TITLE "Consulta de Estados Crediticios por Empresa"
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
/* BROWSE-TAB BROWSE-1 Btn_OK Dialog-Frame */
ASSIGN 
       FRAME Dialog-Frame:SCROLLABLE       = FALSE
       FRAME Dialog-Frame:HIDDEN           = TRUE.

/* SETTINGS FOR FILL-IN Cliente.cdg_cliente IN FRAME Dialog-Frame
   NO-ENABLE EXP-LABEL                                                  */
/* SETTINGS FOR FILL-IN Cliente.credito_maximo IN FRAME Dialog-Frame
   EXP-LABEL EXP-FORMAT                                                 */
/* SETTINGS FOR FILL-IN Cliente.nom_cliente IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME


/* Setting information for Queries and Browse Widgets fields            */

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE BROWSE-1
/* Query rebuild information for BROWSE BROWSE-1
     _START_FREEFORM
OPEN QUERY {&SELF-NAME} FOR EACH T-Estado WHERE T-Estado.tot_credito <> 0 BY T-Estado.cdg_empresa.
     _END_FREEFORM
     _Query            is OPENED
*/  /* BROWSE BROWSE-1 */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _QUERY-BLOCK DIALOG-BOX Dialog-Frame
/* Query rebuild information for DIALOG-BOX Dialog-Frame
     _TblList          = "sic.Cliente"
     _Options          = "SHARE-LOCK"
     _Query            is NOT OPENED
*/  /* DIALOG-BOX Dialog-Frame */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME Dialog-Frame
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Dialog-Frame Dialog-Frame
ON WINDOW-CLOSE OF FRAME Dialog-Frame /* Consulta de Estados Crediticios por Empresa */
DO:
  APPLY "END-ERROR":U TO SELF.
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

FIND Cliente WHERE ROWID(Cliente) = p-rid_cliente NO-LOCK.
FOR EACH Empresa:
    CREATE T-Estado.
    ASSIGN T-Estado.cdg_empresa = Empresa.cdg_empresa.
    RUN sumar_estado_empresa.p ( INPUT p-rid_cliente,
                                 INPUT T-Estado.cdg_empresa,
                                 OUTPUT T-Estado.saldo_cc,
                                 OUTPUT T-Estado.saldo_ccv,
                                 OUTPUT T-Estado.tot_valores,
                                 OUTPUT T-Estado.tot_remitos,
                                 OUTPUT T-Estado.tot_pedidos,
                                 OUTPUT T-Estado.cant_rech,
                                 OUTPUT T-Estado.tot_credito).
    v-tot_credito = v-tot_credito + T-Estado.tot_credito. 
END.
dis_credito = Cliente.credito_maximo - v-tot_credito.

DISPLAY Cliente.cdg_cliente
        Cliente.nom_cliente
        Cliente.credito_maximo
        dis_credito
        v-tot_credito
        WITH FRAME {&FRAME-NAME}.

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
  DISPLAY v-tot_credito dis_credito 
      WITH FRAME Dialog-Frame.
  IF AVAILABLE Cliente THEN 
    DISPLAY Cliente.cdg_cliente Cliente.nom_cliente Cliente.credito_maximo 
      WITH FRAME Dialog-Frame.
  ENABLE Btn_OK BROWSE-1 v-tot_credito dis_credito Cliente.credito_maximo 
         RECT-2 
      WITH FRAME Dialog-Frame.
  VIEW FRAME Dialog-Frame.
  {&OPEN-BROWSERS-IN-QUERY-Dialog-Frame}
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

