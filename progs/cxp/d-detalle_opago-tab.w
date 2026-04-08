&ANALYZE-SUSPEND _VERSION-NUMBER UIB_v8r12 GUI
&ANALYZE-RESUME
/* Connected Databases 
          sic              PROGRESS
*/
&Scoped-define WINDOW-NAME CURRENT-WINDOW
&Scoped-define FRAME-NAME Dialog-Frame

/* Temp-Table and Buffer definitions                                    */
DEFINE SHARED TEMP-TABLE T-Opg_detalle NO-UNDO LIKE sic.Opg_detalle.
DEFINE SHARED TEMP-TABLE T-Opg_header NO-UNDO LIKE sic.Opg_header.


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

DEFINE INPUT        PARAMETER rid_detalle LIKE Opg_detalle.nro_linea.
DEFINE INPUT-OUTPUT PARAMETER p-importe   LIKE Opg_detalle.importe.
DEFINE INPUT-OUTPUT PARAMETER p-descuento LIKE Opg_detalle.descuento.
DEFINE INPUT        PARAMETER modo        AS INTEGER.

/* Local Variable Definitions ---                                       */

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE DIALOG-BOX

/* Name of first Frame and/or Browse and/or first Query                 */
&Scoped-define FRAME-NAME Dialog-Frame

/* Internal Tables (found by Frame, Query & Browse Queries)             */
&Scoped-define INTERNAL-TABLES T-Opg_detalle

/* Definitions for DIALOG-BOX Dialog-Frame                              */
&Scoped-define OPEN-QUERY-Dialog-Frame OPEN QUERY Dialog-Frame FOR EACH T-Opg_detalle SHARE-LOCK.
&Scoped-define TABLES-IN-QUERY-Dialog-Frame T-Opg_detalle
&Scoped-define FIRST-TABLE-IN-QUERY-Dialog-Frame T-Opg_detalle


/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS RECT-1 v-importe v-descuento Btn_OK ~
Btn_Cancel 
&Scoped-Define DISPLAYED-OBJECTS v-saldo v-importe v-descuento 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME



/* ***********************  Control Definitions  ********************** */

/* Define a dialog box                                                  */

/* Definitions of the field level widgets                               */
DEFINE BUTTON Btn_Cancel AUTO-END-KEY 
     LABEL "Cancel" 
     SIZE 15 BY 1.15
     BGCOLOR 8 .

DEFINE BUTTON Btn_OK AUTO-GO 
     LABEL "OK" 
     SIZE 15 BY 1.15
     BGCOLOR 8 .

DEFINE VARIABLE v-descuento AS DECIMAL FORMAT "->>,>>9.99" INITIAL 0 
     LABEL "Descuento" 
     VIEW-AS FILL-IN 
     SIZE 17 BY .81
     BGCOLOR 15 FGCOLOR 9 .

DEFINE VARIABLE v-importe AS DECIMAL FORMAT "->>,>>9.99" INITIAL 0 
     LABEL "Cancela" 
     VIEW-AS FILL-IN 
     SIZE 17 BY .81
     BGCOLOR 15 FGCOLOR 9 .

DEFINE VARIABLE v-saldo AS DECIMAL FORMAT "->>,>>>,>>9.99":U INITIAL 0 
     LABEL "Saldo del Comprobante" 
     VIEW-AS FILL-IN 
     SIZE 17 BY .81
     BGCOLOR 15 FGCOLOR 9  NO-UNDO.

DEFINE RECTANGLE RECT-1
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL 
     SIZE 40 BY 5.92.

/* Query definitions                                                    */
&ANALYZE-SUSPEND
DEFINE QUERY Dialog-Frame FOR 
      T-Opg_detalle SCROLLING.
&ANALYZE-RESUME

/* ************************  Frame Definitions  *********************** */

DEFINE FRAME Dialog-Frame
     v-saldo AT ROW 2.08 COL 23 COLON-ALIGNED
     v-importe AT ROW 3.15 COL 23 COLON-ALIGNED
     v-descuento AT ROW 4.23 COL 23 COLON-ALIGNED
     Btn_OK AT ROW 6.12 COL 4
     Btn_Cancel AT ROW 6.12 COL 27
     RECT-1 AT ROW 1.54 COL 3
     SPACE(1.13) SKIP(0.41)
    WITH VIEW-AS DIALOG-BOX KEEP-TAB-ORDER 
         SIDE-LABELS NO-UNDERLINE THREE-D  SCROLLABLE 
         TITLE "Detalle de Orden de Pago"
         DEFAULT-BUTTON Btn_OK CANCEL-BUTTON Btn_Cancel.


/* *********************** Procedure Settings ************************ */

&ANALYZE-SUSPEND _PROCEDURE-SETTINGS
/* Settings for THIS-PROCEDURE
   Type: DIALOG-BOX
   Allow: Basic,Browse,DB-Fields,Query
   Other Settings: COMPILE
   Temp-Tables and Buffers:
      TABLE: T-Opg_detalle T "SHARED" NO-UNDO sic Opg_detalle
      TABLE: T-Opg_header T "SHARED" NO-UNDO sic Opg_header
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

/* SETTINGS FOR FILL-IN v-saldo IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME


/* Setting information for Queries and Browse Widgets fields            */

&ANALYZE-SUSPEND _QUERY-BLOCK DIALOG-BOX Dialog-Frame
/* Query rebuild information for DIALOG-BOX Dialog-Frame
     _TblList          = "Temp-Tables.T-Opg_detalle"
     _Options          = "SHARE-LOCK"
     _Query            is OPENED
*/  /* DIALOG-BOX Dialog-Frame */
&ANALYZE-RESUME

 




/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME Dialog-Frame
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Dialog-Frame Dialog-Frame
ON WINDOW-CLOSE OF FRAME Dialog-Frame /* Detalle de Orden de Pago */
DO:
  APPLY "END-ERROR":U TO SELF.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME Btn_OK
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Btn_OK Dialog-Frame
ON CHOOSE OF Btn_OK IN FRAME Dialog-Frame /* OK */
DO:

  ASSIGN FRAME {&FRAME-NAME}
     v-importe 
     v-descuento. 
  
  p-importe   = v-importe.
  p-descuento = v-descuento.

  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&UNDEFINE SELF-NAME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _MAIN-BLOCK Dialog-Frame 


/* ***************************  Main Block  *************************** */

/* Parent the dialog-box to the ACTIVE-WINDOW, if there is no parent.   */
IF VALID-HANDLE(ACTIVE-WINDOW) AND FRAME {&FRAME-NAME}:PARENT eq ?
THEN FRAME {&FRAME-NAME}:PARENT = ACTIVE-WINDOW.

{findempresa.i}

/* Now enable the interOpge and wait for the exit condition.            */
/* (NOTE: handle ERROR and END-KEY so cleanup code will always fire.    */

FIND FIRST T-Opg_header.
FIND FIRST T-Opg_detalle WHERE T-Opg_detalle.nro_linea = rid_detalle EXCLUSIVE-LOCK.
FIND Cta_cte_prv
     WHERE Cta_cte_prv.cdg_empresa     = T-Opg_header.cdg_empresa
       AND Cta_cte_prv.nro_proveedor   = T-Opg_header.nro_proveedor
       AND Cta_cte_prv.tip_comprob     = T-Opg_detalle.tip_cancela
       AND Cta_cte_prv.prf_comprob     = T-Opg_detalle.prf_cancela
       AND Cta_cte_prv.nro_comprob     = T-Opg_detalle.nro_cancela
       AND Cta_cte_prv.nro_vencimiento = T-Opg_detalle.nro_vencimiento
           NO-LOCK.

v-saldo = Cta_cte_prv.credito - Cta_cte_prv.debito.
v-importe = p-importe.
v-descuento = p-descuento.
MAIN-BLOCK:
DO ON ERROR   UNDO MAIN-BLOCK, LEAVE MAIN-BLOCK
   ON END-KEY UNDO MAIN-BLOCK, LEAVE MAIN-BLOCK:
  RUN enable_UI.
  DISPLAY 
     v-saldo
     v-importe 
     v-descuento 
     WITH FRAME {&FRAME-NAME}.
  FRAME {&FRAME-NAME}:TITLE = STRING(T-Opg_detalle.nro_linea,"999") + ":  " + 
                              Cta_cte_prv.tip_comprob + " " +
                              STRING(Cta_cte_prv.prf_comprob,"9999") + " " +
                              STRING(Cta_cte_prv.nro_comprob,"99999999").
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

  {&OPEN-QUERY-Dialog-Frame}
  GET FIRST Dialog-Frame.
  DISPLAY v-saldo v-importe v-descuento 
      WITH FRAME Dialog-Frame.
  ENABLE RECT-1 v-importe v-descuento Btn_OK Btn_Cancel 
      WITH FRAME Dialog-Frame.
  VIEW FRAME Dialog-Frame.
  {&OPEN-BROWSERS-IN-QUERY-Dialog-Frame}
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


