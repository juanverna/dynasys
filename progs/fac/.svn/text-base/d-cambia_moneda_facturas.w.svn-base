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
&Scoped-Define ENABLED-OBJECTS v-des-tip_comprob v-des-prf_comprob ~
v-old_moneda v-des-nro_comprob v-nue_moneda v-has-nro_comprob v-nue_cambio ~
Btn_OK Btn_Cancel RECT-1 
&Scoped-Define DISPLAYED-OBJECTS v-des-tip_comprob v-des-prf_comprob ~
v-old_moneda v-des-nro_comprob v-nue_moneda v-has-nro_comprob v-nue_cambio 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME



/* ***********************  Control Definitions  ********************** */

/* Define a dialog box                                                  */

/* Definitions of the field level widgets                               */
DEFINE BUTTON Btn_Cancel AUTO-END-KEY 
     LABEL "Cancel" 
     SIZE 22 BY 1.14
     BGCOLOR 8 .

DEFINE BUTTON Btn_OK AUTO-GO 
     LABEL "Cambiar Moneda" 
     SIZE 22 BY 1.14
     BGCOLOR 8 .

DEFINE VARIABLE v-des-nro_comprob AS INTEGER FORMAT ">>>>>>>9":U INITIAL 0 
     LABEL "Desde Número" 
     VIEW-AS FILL-IN 
     SIZE 18 BY 1
     BGCOLOR 15 FGCOLOR 9  NO-UNDO.

DEFINE VARIABLE v-des-prf_comprob AS INTEGER FORMAT ">>>9":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 9 BY 1
     BGCOLOR 15 FGCOLOR 9  NO-UNDO.

DEFINE VARIABLE v-des-tip_comprob AS CHARACTER FORMAT "X(2)":U 
     LABEL "Comprobante" 
     VIEW-AS FILL-IN 
     SIZE 7 BY 1
     BGCOLOR 15 FGCOLOR 9  NO-UNDO.

DEFINE VARIABLE v-has-nro_comprob AS INTEGER FORMAT ">>>>>>>9":U INITIAL 0 
     LABEL "Hasta Número" 
     VIEW-AS FILL-IN 
     SIZE 18 BY 1
     BGCOLOR 15 FGCOLOR 9  NO-UNDO.

DEFINE VARIABLE v-nue_cambio AS DECIMAL FORMAT "->>,>>9.9999":U INITIAL 0 
     LABEL "Cambio" 
     VIEW-AS FILL-IN 
     SIZE 14 BY 1
     BGCOLOR 15 FGCOLOR 9  NO-UNDO.

DEFINE VARIABLE v-nue_moneda AS INTEGER FORMAT "->,>>>,>>9":U INITIAL 0 
     LABEL "Moneda Nueva" 
     VIEW-AS FILL-IN 
     SIZE 14 BY 1
     BGCOLOR 15 FGCOLOR 9  NO-UNDO.

DEFINE VARIABLE v-old_moneda AS INTEGER FORMAT "->,>>>,>>9":U INITIAL 0 
     LABEL "Moneda Anterior" 
     VIEW-AS FILL-IN 
     SIZE 14 BY 1
     BGCOLOR 15 FGCOLOR 9  NO-UNDO.

DEFINE RECTANGLE RECT-1
     EDGE-PIXELS 6 GRAPHIC-EDGE  NO-FILL 
     SIZE 99 BY 4.52.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME Dialog-Frame
     v-des-tip_comprob AT ROW 2.19 COL 19 COLON-ALIGNED
     v-des-prf_comprob AT ROW 2.19 COL 28 COLON-ALIGNED NO-LABEL
     v-old_moneda AT ROW 2.19 COL 57 COLON-ALIGNED
     v-des-nro_comprob AT ROW 3.38 COL 19 COLON-ALIGNED
     v-nue_moneda AT ROW 3.38 COL 57 COLON-ALIGNED
     v-has-nro_comprob AT ROW 4.57 COL 19 COLON-ALIGNED
     v-nue_cambio AT ROW 4.57 COL 57 COLON-ALIGNED
     Btn_OK AT ROW 6.71 COL 3
     Btn_Cancel AT ROW 6.71 COL 79
     RECT-1 AT ROW 1.71 COL 3
     SPACE(1.79) SKIP(2.24)
    WITH VIEW-AS DIALOG-BOX KEEP-TAB-ORDER 
         SIDE-LABELS NO-UNDERLINE THREE-D  SCROLLABLE 
         TITLE "Cambio de Moneda de Facturas de Venta"
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
                                                                        */
ASSIGN 
       FRAME Dialog-Frame:SCROLLABLE       = FALSE
       FRAME Dialog-Frame:HIDDEN           = TRUE.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME Dialog-Frame
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Dialog-Frame Dialog-Frame
ON WINDOW-CLOSE OF FRAME Dialog-Frame /* Cambio de Moneda de Facturas de Venta */
DO:
  APPLY "END-ERROR":U TO SELF.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME Btn_OK
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Btn_OK Dialog-Frame
ON CHOOSE OF Btn_OK IN FRAME Dialog-Frame /* Cambiar Moneda */
DO:
    DEFINE VARIABLE sino AS LOGICAL.
    sino = YES.
    MESSAGE "Confirma que desea cambiar la fecha del rango de facturas indicado"
       VIEW-AS ALERT-BOX QUESTION BUTTONS YES-NO UPDATE sino.
    IF sino 
    THEN DO:
        DO TRANSACTION: 

            ASSIGN FRAME {&FRAME-NAME}
                v-des-tip_comprob 
                v-des-prf_comprob 
                v-des-nro_comprob 
                v-has-nro_comprob 
                v-nue_moneda
                v-old_moneda
                v-nue_cambio.

            FOR EACH Fac_header 
                WHERE Fac_header.tip_comprob = v-des-tip_comprob 
                AND Fac_header.prf_comprob =   v-des-prf_comprob 
                AND Fac_header.nro_comprob >=  v-des-nro_comprob    
                AND Fac_header.nro_comprob <=  v-has-nro_comprob
                AND Fac_header.nro_moneda   =   v-old_moneda:

                /*DISPLAY Fac_header.tip_comprob Fac_header.prf_comprob Fac_header.nro_comprob Fac_header.fecha.*/

                ASSIGN Fac_header.nro_moneda = v-nue_moneda
                       Fac_header.cambio     = v-nue_cambio.
                
                FOR EACH Cta_cte  
                    WHERE Cta_cte.cdg_empresa = Fac_header.cdg_empresa
                    AND   Cta_cte.tip_comprob = Fac_header.tip_comprob
                    AND   Cta_cte.prf_comprob = Fac_header.prf_comprob
                    AND   Cta_cte.nro_comprob = Fac_header.nro_comprob:
          
                    /*DISPLAY Cta_cte.cdg_empresa Cta_cte.tip_comprob Cta_cte.prf_comprob Cta_cte.nro_comprob.*/
                    ASSIGN Cta_cte.nro_moneda = v-nue_moneda
                           Cta_cte.cambio     = v-nue_cambio.               
                END. /**/

                FOR EACH sub_header_vta WHERE sub_header_vta.cdg_empresa = Fac_header.cdg_empresa 
                    AND   sub_header_vta.tip_comprob = Fac_header.tip_comprob
                    AND   sub_header_vta.prf_comprob = Fac_header.prf_comprob
                    AND   sub_header_vta.nro_comprob = Fac_header.nro_comprob:
                    
                    /*DISPLAY sub_header_vta.tip_comprob sub_header_vta.prf_comprob sub_header_vta.nro_comprob sub_header_vta.tip_comprob.*/
                    ASSIGN sub_header_vta.nro_moneda = v-nue_moneda
                           sub_header_vta.cambio     = v-nue_cambio.

                END.
            END. 
        END. 
        MESSAGE "TERMINADO"
            VIEW-AS ALERT-BOX INFORMATION.

    END. 
    ELSE DO:
        MESSAGE "No se realiza proceso alguno"
           VIEW-AS ALERT-BOX ERROR.
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
  DISPLAY v-des-tip_comprob v-des-prf_comprob v-old_moneda v-des-nro_comprob 
          v-nue_moneda v-has-nro_comprob v-nue_cambio 
      WITH FRAME Dialog-Frame.
  ENABLE v-des-tip_comprob v-des-prf_comprob v-old_moneda v-des-nro_comprob 
         v-nue_moneda v-has-nro_comprob v-nue_cambio Btn_OK Btn_Cancel RECT-1 
      WITH FRAME Dialog-Frame.
  VIEW FRAME Dialog-Frame.
  {&OPEN-BROWSERS-IN-QUERY-Dialog-Frame}
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

