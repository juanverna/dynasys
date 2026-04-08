&ANALYZE-SUSPEND _VERSION-NUMBER AB_v10r12 GUI
&ANALYZE-RESUME
&Scoped-define WINDOW-NAME C-Win
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _DEFINITIONS C-Win 
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
/*          This .W file was created with the Progress AppBuilder.      */
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

DEFINE VAR ultnro AS INT NO-UNDO.
DEFINE VAR prefcndor AS CHAR NO-UNDO.

{VRSHARED.I}

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE Window
&Scoped-define DB-AWARE no

/* Name of designated FRAME-NAME and/or first browse and/or first query */
&Scoped-define FRAME-NAME DEFAULT-FRAME

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS RECT-1 v-vie_tip_comprob v-vie_prf_comprob ~
v-vie_nro_comprob v-vie_nro_comprob-2 Tanula v-nue_tip_comprob ~
v-nue_prf_comprob v-nue_nro_comprob Btn_OK Btn_Cancel 
&Scoped-Define DISPLAYED-OBJECTS v-vie_tip_comprob v-vie_prf_comprob ~
v-vie_nro_comprob v-vie_nro_comprob-2 Tanula v-nue_tip_comprob ~
v-nue_prf_comprob v-nue_nro_comprob 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME



/* ***********************  Control Definitions  ********************** */

/* Define the widget handle for the window                              */
DEFINE VAR C-Win AS WIDGET-HANDLE NO-UNDO.

/* Definitions of the field level widgets                               */
DEFINE BUTTON Btn_Cancel AUTO-END-KEY 
     LABEL "Cancel" 
     SIZE 22 BY 1.14
     BGCOLOR 8 .

DEFINE BUTTON Btn_OK AUTO-GO 
     LABEL "&Ejecutar" 
     SIZE 22 BY 1.14
     BGCOLOR 8 .

DEFINE VARIABLE v-nue_nro_comprob AS INTEGER FORMAT ">>>>>>>9":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 18 BY 1
     BGCOLOR 15 FGCOLOR 9  NO-UNDO.

DEFINE VARIABLE v-nue_prf_comprob AS INTEGER FORMAT "9999":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 9 BY 1
     BGCOLOR 15 FGCOLOR 9  NO-UNDO.

DEFINE VARIABLE v-nue_tip_comprob AS CHARACTER FORMAT "X(2)":U 
     LABEL "Desde Número Asignado" 
     VIEW-AS FILL-IN 
     SIZE 7 BY 1
     BGCOLOR 15 FGCOLOR 9  NO-UNDO.

DEFINE VARIABLE v-vie_nro_comprob AS INTEGER FORMAT ">>>>>>>9":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 18 BY 1
     BGCOLOR 15 FGCOLOR 9  NO-UNDO.

DEFINE VARIABLE v-vie_nro_comprob-2 AS INTEGER FORMAT ">>>>>>>9":U INITIAL 0 
     LABEL "Hasta Numero Anterior" 
     VIEW-AS FILL-IN 
     SIZE 18 BY 1
     BGCOLOR 15 FGCOLOR 9  NO-UNDO.

DEFINE VARIABLE v-vie_prf_comprob AS INTEGER FORMAT "9999":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 9 BY 1
     BGCOLOR 15 FGCOLOR 9  NO-UNDO.

DEFINE VARIABLE v-vie_tip_comprob AS CHARACTER FORMAT "X(2)":U 
     LABEL "Desde Número Anterior" 
     VIEW-AS FILL-IN 
     SIZE 7 BY 1
     BGCOLOR 15 FGCOLOR 9  NO-UNDO.

DEFINE RECTANGLE RECT-1
     EDGE-PIXELS 6 GRAPHIC-EDGE  NO-FILL   
     SIZE 66 BY 5.71.

DEFINE VARIABLE Tanula AS LOGICAL INITIAL yes 
     LABEL "Anula" 
     VIEW-AS TOGGLE-BOX
     SIZE 13.4 BY .81 TOOLTIP "Si desea anular los comprobantes liberados" NO-UNDO.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME DEFAULT-FRAME
     v-vie_tip_comprob AT ROW 2.43 COL 27.6 COLON-ALIGNED WIDGET-ID 18
     v-vie_prf_comprob AT ROW 2.43 COL 35.6 COLON-ALIGNED NO-LABEL WIDGET-ID 16
     v-vie_nro_comprob AT ROW 2.43 COL 45.6 COLON-ALIGNED NO-LABEL WIDGET-ID 14
     v-vie_nro_comprob-2 AT ROW 3.62 COL 45.6 COLON-ALIGNED WIDGET-ID 24
     Tanula AT ROW 3.86 COL 7 WIDGET-ID 26
     v-nue_tip_comprob AT ROW 5.67 COL 27.6 COLON-ALIGNED WIDGET-ID 4
     v-nue_prf_comprob AT ROW 5.67 COL 35.6 COLON-ALIGNED NO-LABEL WIDGET-ID 2
     v-nue_nro_comprob AT ROW 5.67 COL 45.6 COLON-ALIGNED NO-LABEL WIDGET-ID 12
     Btn_OK AT ROW 7.91 COL 15 WIDGET-ID 8
     Btn_Cancel AT ROW 7.91 COL 39 WIDGET-ID 6
     RECT-1 AT ROW 1.71 COL 3 WIDGET-ID 10
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1.05
         SIZE 72.6 BY 8.62 WIDGET-ID 100.


/* *********************** Procedure Settings ************************ */

&ANALYZE-SUSPEND _PROCEDURE-SETTINGS
/* Settings for THIS-PROCEDURE
   Type: Window
   Allow: Basic,Browse,DB-Fields,Window,Query
   Other Settings: COMPILE
 */
&ANALYZE-RESUME _END-PROCEDURE-SETTINGS

/* *************************  Create Window  ************************** */

&ANALYZE-SUSPEND _CREATE-WINDOW
IF SESSION:DISPLAY-TYPE = "GUI":U THEN
  CREATE WINDOW C-Win ASSIGN
         HIDDEN             = YES
         TITLE              = "Renumeración de Comprobantes de Facturación"
         HEIGHT             = 8.62
         WIDTH              = 72.6
         MAX-HEIGHT         = 25.91
         MAX-WIDTH          = 160
         VIRTUAL-HEIGHT     = 25.91
         VIRTUAL-WIDTH      = 160
         RESIZE             = yes
         SCROLL-BARS        = no
         STATUS-AREA        = no
         BGCOLOR            = ?
         FGCOLOR            = ?
         KEEP-FRAME-Z-ORDER = yes
         THREE-D            = yes
         MESSAGE-AREA       = no
         SENSITIVE          = yes.
ELSE {&WINDOW-NAME} = CURRENT-WINDOW.
/* END WINDOW DEFINITION                                                */
&ANALYZE-RESUME



/* ***********  Runtime Attributes and AppBuilder Settings  *********** */

&ANALYZE-SUSPEND _RUN-TIME-ATTRIBUTES
/* SETTINGS FOR WINDOW C-Win
  VISIBLE,,RUN-PERSISTENT                                               */
/* SETTINGS FOR FRAME DEFAULT-FRAME
   FRAME-NAME                                                           */
IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(C-Win)
THEN C-Win:HIDDEN = no.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME C-Win
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON END-ERROR OF C-Win /* Renumeración de Comprobantes de Facturación */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON WINDOW-CLOSE OF C-Win /* Renumeración de Comprobantes de Facturación */
DO:
  /* This event will close the window and terminate the procedure.  */
  APPLY "CLOSE":U TO THIS-PROCEDURE.
  RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME Btn_OK
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Btn_OK C-Win
ON CHOOSE OF Btn_OK IN FRAME DEFAULT-FRAME /* Ejecutar */
DO:
    
    DEFINE VAR k AS INT.
    DEFINE VARIABLE sino AS LOGICAL.
    DEFINE BUFFER bfac_header FOR fac_header.
    DEFINE BUFFER bSub_header_vta FOR Sub_header_vta.
    sino = YES.
    MESSAGE "Confirma que desea cambiar el/los números del comprobante indicado"
       VIEW-AS ALERT-BOX QUESTION BUTTONS YES-NO UPDATE sino.
    IF sino 
    THEN DO:

        {findempresa.i}

        ASSIGN FRAME {&FRAME-NAME}
                     v-vie_tip_comprob  
                     v-vie_prf_comprob  
                     v-vie_nro_comprob  
                     v-vie_nro_comprob-2         
                     v-nue_tip_comprob
                     v-nue_prf_comprob  
                     v-nue_nro_comprob
                     tanula.
        DO k = v-nue_nro_comprob TO v-nue_nro_comprob + v-vie_nro_comprob-2 - v-vie_nro_comprob :
            IF CAN-FIND(Fac_header WHERE Fac_header.cdg_empresa = Empresa.cdg_empresa
                                 AND Fac_header.tip_comprob = v-nue_tip_comprob 
                                 AND Fac_header.prf_comprob = v-nue_prf_comprob
                                 AND Fac_header.nro_comprob = k )
            THEN DO:
                MESSAGE "Ya existe un comprobante con el número " v-nue_tip_comprob "-" v-nue_prf_comprob "-" k
                    VIEW-AS ALERT-BOX ERROR TITLE "Error de Numeración".
                RETURN NO-APPLY.
            END.
        END.
        DO TRANSACTION:
            DO k = 0 TO  v-vie_nro_comprob-2 - v-vie_nro_comprob :

            FIND Fac_header WHERE Fac_header.cdg_empresa = Empresa.cdg_empresa
                                  AND Fac_header.tip_comprob = v-vie_tip_comprob 
                                  AND Fac_header.prf_comprob = v-vie_prf_comprob
                                  AND Fac_header.nro_comprob = v-vie_nro_comprob + k
                                      EXCLUSIVE-LOCK.
                ASSIGN Fac_header.tip_comprob = v-nue_tip_comprob 
                       Fac_header.prf_comprob = v-nue_prf_comprob
                       Fac_header.nro_comprob = v-nue_nro_comprob + k.
                IF fac_header.tip_comprob BEGINS "F" OR fac_header.tip_comprob BEGINS "C" THEN do:
                    FIND aplicacion_pagos WHERE 
                        aplicacion_pagos.tip_cancela = fac_header.tip_comprob AND
                        aplicacion_pagos.prf_cancela = fac_header.prf_comprob AND
                        aplicacion_pagos.nro_cancela = fac_header.nro_comprob NO-ERROR.
                    IF AVAILABLE aplicacion_pagos  THEN DO:
                        aplicacion_pagos.nro_cancela = aplicacion_pagos.nro_comprob + k.
                    END.
                end.
                IF fac_header.tip_comprob BEGINS "C" THEN do:
                    FIND aplicacion_pagos WHERE 
                        aplicacion_pagos.tip_comprob = fac_header.tip_comprob AND
                        aplicacion_pagos.prf_comprob = fac_header.prf_comprob AND
                        aplicacion_pagos.nro_comprob = fac_header.nro_comprob NO-ERROR.
                    IF AVAILABLE aplicacion_pagos  THEN DO:
                        aplicacion_pagos.nro_comprob = aplicacion_pagos.nro_comprob + k.
                    END.
                end.        

                FOR EACH Sub_header_vta WHERE Sub_header_vta.cdg_empresa = Empresa.cdg_empresa
                                          AND Sub_header_vta.tip_comprob = v-vie_tip_comprob 
                                          AND Sub_header_vta.prf_comprob = v-vie_prf_comprob
                                          AND Sub_header_vta.nro_comprob = v-vie_nro_comprob + k
                                              EXCLUSIVE-LOCK:
                 
                    ASSIGN Sub_header_vta.tip_comprob = v-nue_tip_comprob 
                           Sub_header_vta.prf_comprob = v-nue_prf_comprob
                           Sub_header_vta.nro_comprob = v-nue_nro_comprob + k .
                END.
                IF tanula THEN DO:
                        CREATE bFac_header.
                        ASSIGN bFac_header.fecha       = fac_header.fecha
                               bFac_header.cdg_empresa = Empresa.cdg_empresa
                               bFac_header.tip_comprob = Fac_header.tip_compro
                               bFac_header.prf_comprob = v-vie_prf_comprob
                               bFac_header.nro_comprob = v-vie_nro_comprob + k 
                               bFac_header.origen      = "A"
                               bFac_header.anulado     = YES
                               bFac_header.nro_factura = NEXT-VALUE(proxima_transaccion)
                               bFac_header.impreso     = "S".
                    
                        CREATE bSub_header_vta.
                        ASSIGN
                                bSub_header_vta.cdg_empresa = bFac_header.cdg_empresa
                                bSub_header_vta.tip_comprob = bFac_header.tip_comprob
                                bSub_header_vta.prf_comprob = bFac_header.prf_comprob
                                bSub_header_vta.nro_comprob = bFac_header.nro_comprob
                                bSub_header_vta.fecha       = bFac_header.fecha
                                bSub_header_vta.anulado     = YES.
                END.

                FOR EACH Sub_detalle_vta WHERE Sub_detalle_vta.cdg_empresa = Empresa.cdg_empresa
                                          AND Sub_detalle_vta.tip_comprob = v-vie_tip_comprob 
                                          AND Sub_detalle_vta.prf_comprob = v-vie_prf_comprob
                                          AND Sub_detalle_vta.nro_comprob = v-vie_nro_comprob + k
                                              EXCLUSIVE-LOCK:

                    ASSIGN Sub_detalle_vta.tip_comprob = v-nue_tip_comprob 
                           Sub_detalle_vta.prf_comprob = v-nue_prf_comprob
                           Sub_detalle_vta.nro_comprob = v-nue_nro_comprob + k .

                END.

                FOR EACH Cta_cte WHERE Cta_cte.cdg_empresa = Empresa.cdg_empresa
                                   AND Cta_cte.tip_comprob = v-vie_tip_comprob 
                                   AND Cta_cte.prf_comprob = v-vie_prf_comprob
                                   AND Cta_cte.nro_comprob = v-vie_nro_comprob + k
                                              EXCLUSIVE-LOCK:

                    ASSIGN Cta_cte.tip_comprob = v-nue_tip_comprob 
                           Cta_cte.prf_comprob = v-nue_prf_comprob
                           Cta_cte.nro_comprob = v-nue_nro_comprob + k.

                END.

                FOR EACH Rec_detalle WHERE Rec_detalle.cdg_emprecancela = Empresa.cdg_empresa
                                       AND Rec_detalle.tip_cancela = v-vie_tip_comprob
                                       AND Rec_detalle.prf_cancela = v-vie_prf_comprob
                                       AND Rec_detalle.nro_cancela = v-vie_nro_comprob + k
                                              EXCLUSIVE-LOCK:

                    ASSIGN Rec_detalle.tip_cancela = v-nue_tip_comprob 
                           Rec_detalle.prf_cancela = v-nue_prf_comprob
                           Rec_detalle.nro_cancela = v-nue_nro_comprob + k .

                END.

                FOR EACH Cct_stock WHERE Cct_stock.cdg_empresa = Empresa.cdg_empresa
                                     AND Cct_stock.tip_comprob = v-vie_tip_comprob 
                                     AND Cct_stock.prf_comprob = v-vie_prf_comprob
                                     AND Cct_stock.nro_comprob = v-vie_nro_comprob + k
                                              EXCLUSIVE-LOCK:

                    ASSIGN Cct_stock.tip_comprob = v-nue_tip_comprob 
                           Cct_stock.prf_comprob = v-nue_prf_comprob
                           Cct_stock.nro_comprob = v-nue_nro_comprob + k.

                END. 
            END.
        END.
        IF ultnro < v-nue_nro_comprob + k THEN do:
            RUN setparametro.p ( prefcndor,"",0,false,v-vie_nro_comprob + k).
            MESSAGE "La Proxima NUEVA factura a imprimirse sera " v-nue_nro_comprob + k SKIP
                    "sino es asi verifique el parametro "  prefcndor VIEW-AS ALERT-BOX INFORMATION. 
        END.
        ELSE MESSAGE "Proceso Terminado" VIEW-AS ALERT-BOX INFORMATION.
    END. 
    ELSE DO:
        MESSAGE "CANCELADO"
           VIEW-AS ALERT-BOX ERROR.
    END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME v-nue_prf_comprob
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-nue_prf_comprob C-Win
ON LEAVE OF v-nue_prf_comprob IN FRAME DEFAULT-FRAME
DO:
    v-nue_prf_comprob:SCREEN-VALUE = string(v-nue_prf_comprob:INPUT-VALUE,"9999").
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME v-vie_nro_comprob
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-vie_nro_comprob C-Win
ON LEAVE OF v-vie_nro_comprob IN FRAME DEFAULT-FRAME
DO:
          
    {findempresa.i}
        ASSIGN FRAME {&FRAME-NAME}
                     v-vie_tip_comprob  
                     v-vie_prf_comprob  
                     v-vie_nro_comprob.
    FIND fac_header WHERE fac_header.prf_comprob = v-vie_prf_comprob AND 
    nro_comprob = v-vie_nro_comprob AND 
    Fac_header.cdg_empresa = Empresa.cdg_empresa AND
    fac_header.tip_comprob = v-vie_tip_comprob NO-LOCK.
IF NOT AVAILABLE fac_header THEN LEAVE.
FIND tipocomprobante WHERE tipocomprobante.cdg_comprobante = fac_header.cdg_comprobante NO-LOCK.
prefcndor = replace(prefijo_contador,"*", SUBSTRING(fac_header.tip_comprob,2,1) + STRING(fac_header.prf_comprob,"9999")).
RUN getparametro_n.p ( prefcndor, OUTPUT ultnro).
v-nue_nro_comprob:SCREEN-VALUE = STRING(ultnro).
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME v-vie_prf_comprob
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-vie_prf_comprob C-Win
ON LEAVE OF v-vie_prf_comprob IN FRAME DEFAULT-FRAME
DO:

  v-vie_prf_comprob:SCREEN-VALUE = string(v-vie_prf_comprob:INPUT-VALUE).
  v-nue_prf_comprob:SCREEN-VALUE = string(v-vie_prf_comprob:INPUT-VALUE).
    ASSIGN FRAME {&FRAME-NAME}
                     v-vie_prf_comprob  
                     v-nue_prf_comprob.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME v-vie_tip_comprob
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-vie_tip_comprob C-Win
ON LEAVE OF v-vie_tip_comprob IN FRAME DEFAULT-FRAME /* Desde Número Anterior */
DO:
  v-vie_tip_comprob:SCREEN-VALUE = UPPER(v-vie_tip_comprob:INPUT-VALUE).
  v-nue_tip_comprob:SCREEN-VALUE = UPPER(v-vie_tip_comprob:INPUT-VALUE).
  ASSIGN FRAME {&FRAME-NAME}
                     v-vie_tip_comprob  
                     v-nue_tip_comprob.
                     
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&UNDEFINE SELF-NAME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _MAIN-BLOCK C-Win 


/* ***************************  Main Block  *************************** */

/* Set CURRENT-WINDOW: this will parent dialog-boxes and frames.        */
ASSIGN CURRENT-WINDOW                = {&WINDOW-NAME} 
       THIS-PROCEDURE:CURRENT-WINDOW = {&WINDOW-NAME}.

/* The CLOSE event can be used from inside or outside the procedure to  */
/* terminate it.                                                        */
ON CLOSE OF THIS-PROCEDURE 
   RUN disable_UI.

/* Best default for GUI applications is...                              */
PAUSE 0 BEFORE-HIDE.

/* Now enable the interface and wait for the exit condition.            */
/* (NOTE: handle ERROR and END-KEY so cleanup code will always fire.    */
MAIN-BLOCK:
DO ON ERROR   UNDO MAIN-BLOCK, LEAVE MAIN-BLOCK
   ON END-KEY UNDO MAIN-BLOCK, LEAVE MAIN-BLOCK:
  RUN enable_UI.
  IF NOT THIS-PROCEDURE:PERSISTENT THEN
    WAIT-FOR CLOSE OF THIS-PROCEDURE.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


/* **********************  Internal Procedures  *********************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE disable_UI C-Win  _DEFAULT-DISABLE
PROCEDURE disable_UI :
/*------------------------------------------------------------------------------
  Purpose:     DISABLE the User Interface
  Parameters:  <none>
  Notes:       Here we clean-up the user-interface by deleting
               dynamic widgets we have created and/or hide 
               frames.  This procedure is usually called when
               we are ready to "clean-up" after running.
------------------------------------------------------------------------------*/
  /* Delete the WINDOW we created */
  IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(C-Win)
  THEN DELETE WIDGET C-Win.
  IF THIS-PROCEDURE:PERSISTENT THEN DELETE PROCEDURE THIS-PROCEDURE.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE enable_UI C-Win  _DEFAULT-ENABLE
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
  DISPLAY v-vie_tip_comprob v-vie_prf_comprob v-vie_nro_comprob 
          v-vie_nro_comprob-2 Tanula v-nue_tip_comprob v-nue_prf_comprob 
          v-nue_nro_comprob 
      WITH FRAME DEFAULT-FRAME IN WINDOW C-Win.
  ENABLE RECT-1 v-vie_tip_comprob v-vie_prf_comprob v-vie_nro_comprob 
         v-vie_nro_comprob-2 Tanula v-nue_tip_comprob v-nue_prf_comprob 
         v-nue_nro_comprob Btn_OK Btn_Cancel 
      WITH FRAME DEFAULT-FRAME IN WINDOW C-Win.
  {&OPEN-BROWSERS-IN-QUERY-DEFAULT-FRAME}
  VIEW C-Win.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

