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
  DEFINE VARIABLE p-saldo_cc       AS DECIMAL.
  DEFINE VARIABLE p-saldo_ccv      AS DECIMAL.
  DEFINE VARIABLE p-tot_valores    AS DECIMAL.
  DEFINE VARIABLE p-tot_remitos    AS DECIMAL.
  DEFINE VARIABLE p-tot_pedidos    AS DECIMAL.
  DEFINE VARIABLE p-cant_rech      AS INTEGER.
  DEFINE VARIABLE p-tot_credito    AS DECIMAL.

  FIND Cliente WHERE Cliente.cdg_cliente = "R000569" NO-LOCK.
  p-rid_cliente = ROWID(Cliente).

  &ELSE
  DEFINE INPUT PARAMETER p-rid_cliente    AS ROWID.
  DEFINE INPUT PARAMETER p-saldo_cc       AS DECIMAL.
  DEFINE INPUT PARAMETER p-saldo_ccv      AS DECIMAL.
  DEFINE INPUT PARAMETER p-tot_valores    AS DECIMAL.
  DEFINE INPUT PARAMETER p-tot_remitos    AS DECIMAL.
  DEFINE INPUT PARAMETER p-tot_pedidos    AS DECIMAL.
  DEFINE INPUT PARAMETER p-cant_rech      AS INTEGER.
  DEFINE INPUT PARAMETER p-tot_credito    AS DECIMAL.
  &ENDIF

/* Local Variable Definitions ---                                       */

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE DIALOG-BOX
&Scoped-define DB-AWARE no

/* Name of first Frame and/or Browse and/or first Query                 */
&Scoped-define FRAME-NAME Dialog-Frame

/* Internal Tables (found by Frame, Query & Browse Queries)             */
&Scoped-define INTERNAL-TABLES Cliente

/* Definitions for DIALOG-BOX Dialog-Frame                              */
&Scoped-define FIELDS-IN-QUERY-Dialog-Frame Cliente.cdg_cliente ~
Cliente.nom_cliente Cliente.credito_maximo 
&Scoped-define ENABLED-FIELDS-IN-QUERY-Dialog-Frame Cliente.cdg_cliente ~
Cliente.nom_cliente Cliente.credito_maximo 
&Scoped-define ENABLED-TABLES-IN-QUERY-Dialog-Frame Cliente
&Scoped-define FIRST-ENABLED-TABLE-IN-QUERY-Dialog-Frame Cliente
&Scoped-define QUERY-STRING-Dialog-Frame FOR EACH Cliente SHARE-LOCK
&Scoped-define OPEN-QUERY-Dialog-Frame OPEN QUERY Dialog-Frame FOR EACH Cliente SHARE-LOCK.
&Scoped-define TABLES-IN-QUERY-Dialog-Frame Cliente
&Scoped-define FIRST-TABLE-IN-QUERY-Dialog-Frame Cliente


/* Standard List Definitions                                            */
&Scoped-Define ENABLED-FIELDS Cliente.cdg_cliente Cliente.nom_cliente ~
Cliente.credito_maximo 
&Scoped-define ENABLED-TABLES Cliente
&Scoped-define FIRST-ENABLED-TABLE Cliente
&Scoped-Define ENABLED-OBJECTS saldo_ccv saldo_cc cant_rech tot_valores ~
tot_remitos tot_pedidos tot_credito dis_credito Btn_OK 
&Scoped-Define DISPLAYED-FIELDS Cliente.cdg_cliente Cliente.nom_cliente ~
Cliente.credito_maximo 
&Scoped-define DISPLAYED-TABLES Cliente
&Scoped-define FIRST-DISPLAYED-TABLE Cliente
&Scoped-Define DISPLAYED-OBJECTS saldo_ccv saldo_cc cant_rech tot_valores ~
tot_remitos tot_pedidos tot_credito dis_credito 

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

DEFINE VARIABLE cant_rech AS INTEGER FORMAT "->,>>>,>>9":U INITIAL 0 
     LABEL "Rechazados" 
     VIEW-AS FILL-IN 
     SIZE 19.6 BY 1
     BGCOLOR 15 FGCOLOR 9 FONT 2 NO-UNDO.

DEFINE VARIABLE dis_credito AS DECIMAL FORMAT "-Z,ZZZ,ZZ9.99":U INITIAL 0 
     LABEL "Crédito Disponible" 
     VIEW-AS FILL-IN 
     SIZE 23.8 BY 1
     BGCOLOR 15 FGCOLOR 9 FONT 2 NO-UNDO.

DEFINE VARIABLE saldo_cc AS DECIMAL FORMAT "-Z,ZZZ,ZZ9.99":U INITIAL 0 
     LABEL "Saldo Cta.Cte." 
     VIEW-AS FILL-IN 
     SIZE 24 BY 1
     BGCOLOR 15 FGCOLOR 9 FONT 2 NO-UNDO.

DEFINE VARIABLE saldo_ccv AS DECIMAL FORMAT "-Z,ZZZ,ZZ9.99":U INITIAL 0 
     LABEL "Vencido" 
     VIEW-AS FILL-IN 
     SIZE 19.6 BY 1
     BGCOLOR 15 FGCOLOR 9 FONT 2 NO-UNDO.

DEFINE VARIABLE tot_credito AS DECIMAL FORMAT "-Z,ZZZ,ZZ9.99":U INITIAL 0 
     LABEL "Crédito Consumido" 
     VIEW-AS FILL-IN 
     SIZE 23.8 BY 1
     BGCOLOR 15 FGCOLOR 9 FONT 2 NO-UNDO.

DEFINE VARIABLE tot_pedidos AS DECIMAL FORMAT "-Z,ZZZ,ZZ9.99":U INITIAL 0 
     LABEL "Total Pedidos" 
     VIEW-AS FILL-IN 
     SIZE 24 BY 1
     BGCOLOR 15 FGCOLOR 9 FONT 2 NO-UNDO.

DEFINE VARIABLE tot_remitos AS DECIMAL FORMAT "-Z,ZZZ,ZZ9.99":U INITIAL 0 
     LABEL "Total Remitos" 
     VIEW-AS FILL-IN 
     SIZE 24 BY 1
     BGCOLOR 15 FGCOLOR 9 FONT 2 NO-UNDO.

DEFINE VARIABLE tot_valores AS DECIMAL FORMAT "-Z,ZZZ,ZZ9.99":U INITIAL 0 
     LABEL "Total Valores" 
     VIEW-AS FILL-IN 
     SIZE 24 BY 1
     BGCOLOR 15 FGCOLOR 9 FONT 2 NO-UNDO.

/* Query definitions                                                    */
&ANALYZE-SUSPEND
DEFINE QUERY Dialog-Frame FOR 
      Cliente SCROLLING.
&ANALYZE-RESUME

/* ************************  Frame Definitions  *********************** */

DEFINE FRAME Dialog-Frame
     Cliente.cdg_cliente AT ROW 1.52 COL 20 COLON-ALIGNED
          LABEL "Cliente"
          VIEW-AS FILL-IN 
          SIZE 24 BY 1
          BGCOLOR 15 FGCOLOR 9 
     Cliente.nom_cliente AT ROW 1.52 COL 46 COLON-ALIGNED NO-LABEL
          VIEW-AS FILL-IN 
          SIZE 40.6 BY 1
          BGCOLOR 15 FGCOLOR 9 
     saldo_ccv AT ROW 2.86 COL 67 COLON-ALIGNED
     saldo_cc AT ROW 3.1 COL 20 COLON-ALIGNED
     cant_rech AT ROW 3.95 COL 67 COLON-ALIGNED
     tot_valores AT ROW 4.29 COL 20 COLON-ALIGNED
     tot_remitos AT ROW 5.48 COL 20 COLON-ALIGNED
     tot_pedidos AT ROW 6.67 COL 20 COLON-ALIGNED
     Cliente.credito_maximo AT ROW 7.19 COL 66 COLON-ALIGNED FORMAT "-Z,ZZZ,ZZ9.99"
          VIEW-AS FILL-IN 
          SIZE 20.6 BY 1
          BGCOLOR 15 FGCOLOR 9 FONT 2
     tot_credito AT ROW 7.81 COL 20.2 COLON-ALIGNED
     dis_credito AT ROW 9 COL 20.2 COLON-ALIGNED
     Btn_OK AT ROW 9.33 COL 73.6
     SPACE(6.19) SKIP(2.19)
    WITH VIEW-AS DIALOG-BOX KEEP-TAB-ORDER 
         SIDE-LABELS NO-UNDERLINE THREE-D  SCROLLABLE 
         FONT 4
         TITLE "Consulta de Estados Crediticios"
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

/* SETTINGS FOR FILL-IN Cliente.cdg_cliente IN FRAME Dialog-Frame
   EXP-LABEL                                                            */
/* SETTINGS FOR FILL-IN Cliente.credito_maximo IN FRAME Dialog-Frame
   EXP-FORMAT                                                           */
/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME


/* Setting information for Queries and Browse Widgets fields            */

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
ON WINDOW-CLOSE OF FRAME Dialog-Frame /* Consulta de Estados Crediticios */
DO:
  APPLY "END-ERROR":U TO SELF.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&UNDEFINE SELF-NAME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _MAIN-BLOCK Dialog-Frame 


/* ***************************  Main Block  *************************** */

/* Parent the dialog-box to the ACTIVE-WINDOW, if there is no parent.   */
IF VALID-HANDLE(ACTIVE-WINDOW) AND FRAME {&FRAME-NAME}:PARENT eq ?
THEN FRAME {&FRAME-NAME}:PARENT = ACTIVE-WINDOW.

FIND Cliente WHERE ROWID(Cliente) = p-rid_cliente NO-LOCK.
ASSIGN
     saldo_cc    = p-saldo_cc
     saldo_ccv   = p-saldo_ccv
     tot_valores = p-tot_valores
     tot_remitos = p-tot_remitos
     tot_pedidos = p-tot_pedidos
     cant_rech   = p-cant_rech
     tot_credito = p-tot_credito.

dis_credito = Cliente.credito_maximo - tot_credito.

DISPLAY Cliente.cdg_cliente
        Cliente.nom_cliente
        Cliente.credito_maximo
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
  DISPLAY saldo_ccv saldo_cc cant_rech tot_valores tot_remitos tot_pedidos 
          tot_credito dis_credito 
      WITH FRAME Dialog-Frame.
  IF AVAILABLE Cliente THEN 
    DISPLAY Cliente.cdg_cliente Cliente.nom_cliente Cliente.credito_maximo 
      WITH FRAME Dialog-Frame.
  ENABLE Cliente.cdg_cliente Cliente.nom_cliente saldo_ccv saldo_cc cant_rech 
         tot_valores tot_remitos tot_pedidos Cliente.credito_maximo tot_credito 
         dis_credito Btn_OK 
      WITH FRAME Dialog-Frame.
  VIEW FRAME Dialog-Frame.
  {&OPEN-BROWSERS-IN-QUERY-Dialog-Frame}
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

