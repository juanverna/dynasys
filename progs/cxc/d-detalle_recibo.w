&ANALYZE-SUSPEND _VERSION-NUMBER UIB_v8r12 GUI
&ANALYZE-RESUME
/* Connected Databases 
          sic              PROGRESS
*/
&Scoped-define WINDOW-NAME CURRENT-WINDOW
&Scoped-define FRAME-NAME Dialog-Frame

/* Temp-Table and Buffer definitions                                    */
DEFINE TEMP-TABLE T-Rec_detalle NO-UNDO LIKE Rec_detalle.
DEFINE TEMP-TABLE T-Rec_header NO-UNDO LIKE Rec_header.


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

/* Local Variable Definitions ---                                       */

&IF DEFINED(UIB_is_Running) NE 0
&THEN

DEFINE VARIABLE          p-nro_linea-i        LIKE Asn_detalle.nro_linea.
DEFINE VARIABLE          p-modo-cabecera      AS INTEGER.
DEFINE VARIABLE          p-modo-detalle       AS INTEGER.
DEFINE VARIABLE          p-nro_linea-o        LIKE Asn_detalle.nro_linea.

DEFINE VARIABLE          p-tip_cancela        LIKE Rec_detalle.tip_cancela.
DEFINE VARIABLE          p-prf_cancela        LIKE Rec_detalle.prf_cancela.
DEFINE VARIABLE          p-nro_cancela        LIKE Rec_detalle.nro_cancela.
DEFINE VARIABLE          p-nro_vencimiento    LIKE Rec_detalle.nro_vencimiento.

&ELSE

DEFINE INPUT   PARAMETER p-tip_cancela        LIKE Rec_detalle.tip_cancela.
DEFINE INPUT   PARAMETER p-prf_cancela        LIKE Rec_detalle.prf_cancela.
DEFINE INPUT   PARAMETER p-nro_cancela        LIKE Rec_detalle.nro_cancela.
DEFINE INPUT   PARAMETER p-nro_vencimiento    LIKE Rec_detalle.nro_vencimiento.
DEFINE INPUT   PARAMETER p-importe            LIKE Rec_detalle.importe.

DEFINE INPUT   PARAMETER p-nro_linea-i        LIKE Asn_detalle.nro_linea.
DEFINE INPUT   PARAMETER p-modo-cabecera      AS INTEGER.
DEFINE INPUT   PARAMETER p-modo-detalle       AS INTEGER.
DEFINE OUTPUT  PARAMETER p-nro_linea-o        LIKE Asn_detalle.nro_linea.

DEFINE INPUT-OUTPUT PARAMETER TABLE FOR T-Rec_header.
DEFINE INPUT-OUTPUT PARAMETER TABLE FOR T-Rec_detalle.

&ENDIF

{valoresmodo.i}
{valoressalida.i}

DEFINE VARIABLE x-fecha_cotizacion AS DATE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE DIALOG-BOX
&Scoped-define DB-AWARE no

/* Name of first Frame and/or Browse and/or first Query                 */
&Scoped-define FRAME-NAME Dialog-Frame

/* Internal Tables (found by Frame, Query & Browse Queries)             */
&Scoped-define INTERNAL-TABLES T-Rec_detalle

/* Definitions for DIALOG-BOX Dialog-Frame                              */
&Scoped-define FIELDS-IN-QUERY-Dialog-Frame T-Rec_detalle.prc_difcambio ~
T-Rec_detalle.prc_mincambio T-Rec_detalle.importe T-Rec_detalle.cambio ~
T-Rec_detalle.new_cambio T-Rec_detalle.new_cambio_dolar ~
T-Rec_detalle.cambio_dolar T-Rec_detalle.leyenda 
&Scoped-define ENABLED-FIELDS-IN-QUERY-Dialog-Frame ~
T-Rec_detalle.prc_difcambio T-Rec_detalle.prc_mincambio ~
T-Rec_detalle.new_cambio T-Rec_detalle.new_cambio_dolar 
&Scoped-define ENABLED-TABLES-IN-QUERY-Dialog-Frame T-Rec_detalle
&Scoped-define FIRST-ENABLED-TABLE-IN-QUERY-Dialog-Frame T-Rec_detalle
&Scoped-define QUERY-STRING-Dialog-Frame FOR EACH T-Rec_detalle SHARE-LOCK
&Scoped-define OPEN-QUERY-Dialog-Frame OPEN QUERY Dialog-Frame FOR EACH T-Rec_detalle SHARE-LOCK.
&Scoped-define TABLES-IN-QUERY-Dialog-Frame T-Rec_detalle
&Scoped-define FIRST-TABLE-IN-QUERY-Dialog-Frame T-Rec_detalle


/* Standard List Definitions                                            */
&Scoped-Define ENABLED-FIELDS T-Rec_detalle.prc_difcambio ~
T-Rec_detalle.prc_mincambio T-Rec_detalle.new_cambio ~
T-Rec_detalle.new_cambio_dolar 
&Scoped-define ENABLED-TABLES T-Rec_detalle
&Scoped-define FIRST-ENABLED-TABLE T-Rec_detalle
&Scoped-Define ENABLED-OBJECTS Btn_Cancel RECT-1 RECT-2 RECT-3 
&Scoped-Define DISPLAYED-FIELDS T-Rec_detalle.prc_difcambio ~
T-Rec_detalle.prc_mincambio T-Rec_detalle.importe T-Rec_detalle.cambio ~
T-Rec_detalle.new_cambio T-Rec_detalle.new_cambio_dolar ~
T-Rec_detalle.cambio_dolar T-Rec_detalle.leyenda 
&Scoped-define DISPLAYED-TABLES T-Rec_detalle
&Scoped-define FIRST-DISPLAYED-TABLE T-Rec_detalle
&Scoped-Define DISPLAYED-OBJECTS v-moneda v-clausula_dolar v-saldo 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME



/* ***********************  Control Definitions  ********************** */

/* Define a dialog box                                                  */

/* Definitions of the field level widgets                               */
DEFINE BUTTON Btn_Cancel AUTO-END-KEY 
     LABEL "Cancel" 
     SIZE 21 BY 1.14
     BGCOLOR 8 .

DEFINE BUTTON Btn_OK AUTO-GO 
     LABEL "OK" 
     SIZE 21 BY 1.14
     BGCOLOR 8 .

DEFINE VARIABLE v-moneda AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 53 BY 1
     BGCOLOR 7 FGCOLOR 15  NO-UNDO.

DEFINE VARIABLE v-saldo AS DECIMAL FORMAT "->>,>>>,>>9.99":U INITIAL 0 
     LABEL "Saldo" 
     VIEW-AS FILL-IN 
     SIZE 21 BY 1
     BGCOLOR 15 FGCOLOR 9  NO-UNDO.

DEFINE VARIABLE v-clausula_dolar AS LOGICAL 
     VIEW-AS RADIO-SET HORIZONTAL
     RADIO-BUTTONS 
          "Si", yes,
"No", no
     SIZE 16 BY .86 NO-UNDO.

DEFINE RECTANGLE RECT-1
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL 
     SIZE 74 BY 9.

DEFINE RECTANGLE RECT-2
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL 
     SIZE 74 BY 2.62.

DEFINE RECTANGLE RECT-3
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL 
     SIZE 74 BY 2.86.

/* Query definitions                                                    */
&ANALYZE-SUSPEND
DEFINE QUERY Dialog-Frame FOR 
      T-Rec_detalle SCROLLING.
&ANALYZE-RESUME

/* ************************  Frame Definitions  *********************** */

DEFINE FRAME Dialog-Frame
     v-moneda AT ROW 2.91 COL 3 COLON-ALIGNED NO-LABEL
     v-clausula_dolar AT ROW 2.91 COL 60 NO-LABEL
     T-Rec_detalle.prc_difcambio AT ROW 5.76 COL 25 COLON-ALIGNED
          LABEL "%"
          VIEW-AS FILL-IN 
          SIZE 11 BY 1
          BGCOLOR 15 FGCOLOR 9 
     T-Rec_detalle.prc_mincambio AT ROW 5.76 COL 62 COLON-ALIGNED
          LABEL "%"
          VIEW-AS FILL-IN 
          SIZE 11 BY 1
          BGCOLOR 15 FGCOLOR 9 
     v-saldo AT ROW 9.05 COL 15 COLON-ALIGNED
     T-Rec_detalle.importe AT ROW 9.05 COL 52 COLON-ALIGNED
          VIEW-AS FILL-IN 
          SIZE 21 BY 1
          BGCOLOR 15 FGCOLOR 9 
     T-Rec_detalle.cambio AT ROW 10.24 COL 15 COLON-ALIGNED
          VIEW-AS FILL-IN 
          SIZE 21 BY 1
          BGCOLOR 15 FGCOLOR 9 
     T-Rec_detalle.new_cambio AT ROW 10.24 COL 52 COLON-ALIGNED
          LABEL "Cambio"
          VIEW-AS FILL-IN 
          SIZE 21 BY 1
          BGCOLOR 15 FGCOLOR 9 
     T-Rec_detalle.new_cambio_dolar AT ROW 11.43 COL 52 COLON-ALIGNED
          VIEW-AS FILL-IN 
          SIZE 21 BY 1
          BGCOLOR 15 FGCOLOR 9 
     T-Rec_detalle.cambio_dolar AT ROW 11.48 COL 15 COLON-ALIGNED
          VIEW-AS FILL-IN 
          SIZE 21 BY 1
          BGCOLOR 15 FGCOLOR 9 
     T-Rec_detalle.leyenda AT ROW 13.81 COL 3 COLON-ALIGNED NO-LABEL
          VIEW-AS FILL-IN 
          SIZE 70 BY 1
          BGCOLOR 15 FGCOLOR 9 
     Btn_OK AT ROW 15 COL 5
     Btn_Cancel AT ROW 15 COL 54
     RECT-1 AT ROW 7.43 COL 3
     RECT-2 AT ROW 1.48 COL 3
     RECT-3 AT ROW 4.33 COL 3
     "   Observ. de Cta.Cte. del Comprobante" VIEW-AS TEXT
          SIZE 70 BY 1 AT ROW 12.62 COL 5
          BGCOLOR 5 FGCOLOR 15 
     "   Datos del Comprobante" VIEW-AS TEXT
          SIZE 33 BY 1 AT ROW 7.86 COL 5
          BGCOLOR 5 FGCOLOR 15 
     "   Datos del Pago" VIEW-AS TEXT
          SIZE 33 BY 1 AT ROW 7.86 COL 42
          BGCOLOR 5 FGCOLOR 15 
     "   Moneda del comprobante" VIEW-AS TEXT
          SIZE 53 BY 1 AT ROW 1.71 COL 5
          BGCOLOR 5 FGCOLOR 15 
     "   % Mínimo de Dif. Cambio" VIEW-AS TEXT
          SIZE 33 BY 1 AT ROW 4.57 COL 42
          BGCOLOR 5 FGCOLOR 15 
     "   % Generación de Dif. Cambio" VIEW-AS TEXT
          SIZE 33 BY 1 AT ROW 4.57 COL 5
          BGCOLOR 5 FGCOLOR 15 
     "   Cláusula Dólar" VIEW-AS TEXT
          SIZE 17 BY 1 AT ROW 1.71 COL 59
          BGCOLOR 5 FGCOLOR 15 
     SPACE(2.59) SKIP(13.85)
    WITH VIEW-AS DIALOG-BOX KEEP-TAB-ORDER 
         SIDE-LABELS NO-UNDERLINE THREE-D  SCROLLABLE 
         TITLE "Detalle de Recibos de Pago"
         DEFAULT-BUTTON Btn_OK CANCEL-BUTTON Btn_Cancel.


/* *********************** Procedure Settings ************************ */

&ANALYZE-SUSPEND _PROCEDURE-SETTINGS
/* Settings for THIS-PROCEDURE
   Type: DIALOG-BOX
   Allow: Basic,Browse,DB-Fields,Query
   Other Settings: COMPILE
   Temp-Tables and Buffers:
      TABLE: T-Rec_detalle T "?" NO-UNDO sic Rec_detalle
      TABLE: T-Rec_header T "?" NO-UNDO sic Rec_header
   END-TABLES.
 */
&ANALYZE-RESUME _END-PROCEDURE-SETTINGS



/* ***********  Runtime Attributes and AppBuilder Settings  *********** */

&ANALYZE-SUSPEND _RUN-TIME-ATTRIBUTES
/* SETTINGS FOR DIALOG-BOX Dialog-Frame
                                                                        */
ASSIGN 
       FRAME Dialog-Frame:SCROLLABLE       = FALSE
       FRAME Dialog-Frame:HIDDEN           = TRUE.

/* SETTINGS FOR BUTTON Btn_OK IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN T-Rec_detalle.cambio IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN T-Rec_detalle.cambio_dolar IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN T-Rec_detalle.importe IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN T-Rec_detalle.leyenda IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN T-Rec_detalle.new_cambio IN FRAME Dialog-Frame
   EXP-LABEL                                                            */
/* SETTINGS FOR FILL-IN T-Rec_detalle.prc_difcambio IN FRAME Dialog-Frame
   EXP-LABEL                                                            */
/* SETTINGS FOR FILL-IN T-Rec_detalle.prc_mincambio IN FRAME Dialog-Frame
   EXP-LABEL                                                            */
/* SETTINGS FOR RADIO-SET v-clausula_dolar IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN v-moneda IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN v-saldo IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME


/* Setting information for Queries and Browse Widgets fields            */

&ANALYZE-SUSPEND _QUERY-BLOCK DIALOG-BOX Dialog-Frame
/* Query rebuild information for DIALOG-BOX Dialog-Frame
     _TblList          = "Temp-Tables.T-Rec_detalle"
     _Options          = "SHARE-LOCK"
     _Query            is OPENED
*/  /* DIALOG-BOX Dialog-Frame */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME Dialog-Frame
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Dialog-Frame Dialog-Frame
ON WINDOW-CLOSE OF FRAME Dialog-Frame /* Detalle de Recibos de Pago */
DO:
  APPLY "END-ERROR":U TO SELF.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME Btn_Cancel
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Btn_Cancel Dialog-Frame
ON CHOOSE OF Btn_Cancel IN FRAME Dialog-Frame /* Cancel */
DO:
  IF p-modo-detalle = 0 
  THEN DO:  
      DELETE T-Rec_detalle.  
  END.  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME Btn_OK
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Btn_OK Dialog-Frame
ON CHOOSE OF Btn_OK IN FRAME Dialog-Frame /* OK */
DO:

  DEFINE VARIABLE hubo_error AS LOGICAL.
  
  ASSIGN FRAME {&FRAME-NAME}
         T-Rec_detalle.importe
         T-Rec_detalle.new_cambio
         T-Rec_detalle.new_cambio_dolar
         T-Rec_detalle.prc_difcambio 
         T-Rec_detalle.prc_mincambio.
         
  RUN  validar_datos ( OUTPUT hubo_error ).
  IF NOT hubo_error
  THEN DO:
        IF p-modo-detalle = 0 /* Es un alta */ 
        THEN DO:
            ASSIGN
                T-Rec_header.ultima_linea     = T-Rec_header.ultima_linea + 1
                T-Rec_detalle.nro_recibo      = T-Rec_header.nro_recibo
                T-Rec_detalle.nro_linea       = T-Rec_header.ultima_linea.
        END.

        p-nro_linea-o = T-Rec_detalle.nro_linea.
        codigo_salir = CD_GRABAR.
        APPLY "U1" TO THIS-PROCEDURE.
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

{findempresa.i}

/* Now enable the interOpge and wait for the exit condition.            */
/* (NOTE: handle ERROR and END-KEY so cleanup code will always fire.    */

MAIN-BLOCK:
DO ON ERROR   UNDO MAIN-BLOCK, LEAVE MAIN-BLOCK
   ON END-KEY UNDO MAIN-BLOCK, LEAVE MAIN-BLOCK:
  RUN enable_UI.
  FIND FIRST T-Rec_header.
  
  FIND Cta_cte
      WHERE Cta_cte.cdg_empresa     = Empresa.cdg_empresa
        AND Cta_cte.tip_comprob     = p-tip_cancela
        AND Cta_cte.prf_comprob     = p-prf_cancela
        AND Cta_cte.nro_comprob     = p-nro_cancela
        AND Cta_cte.nro_vencimiento = p-nro_vencimiento
            NO-LOCK.
  v-saldo = Cta_cte.debito - Cta_cte.credito.
  v-clausula_dolar = Cta_cte.clausula_dolar.

  FIND Moneda OF Cta_cte NO-LOCK.
  v-moneda = Moneda.descripcion.

  IF p-modo-detalle = 0
  THEN DO:

     CREATE T-Rec_detalle.
     BUFFER-COPY Cta_cte TO T-Rec_detalle
         ASSIGN T-Rec_detalle.cdg_emprecancela = Cta_cte.cdg_empresa
                T-Rec_detalle.tip_cancela      = Cta_cte.tip_comprob
                T-Rec_detalle.prf_cancela      = Cta_cte.prf_comprob
                T-Rec_detalle.nro_cancela      = Cta_cte.nro_comprob
                T-Rec_detalle.nro_vencimiento  = Cta_cte.nro_vencimiento
                T-Rec_detalle.importe          = IF p-importe <> 0 
                                                    THEN MINIMUM(Cta_cte.debito - Cta_cte.credito,p-importe)
                                                    ELSE Cta_cte.debito - Cta_cte.credito.

     FIND Moneda OF Cta_cte NO-LOCK.
     v-moneda = Moneda.descripcion.
     IF Moneda.es_local 
     THEN DO:
         IF Cta_cte.clausula_dolar
         THEN DO:
             FIND Cliente OF T-Rec_header NO-LOCK.
             ASSIGN T-Rec_detalle.prc_difcambio = Cliente.prc_difcambio
                    T-Rec_detalle.prc_mincambio = Cliente.prc_mincambio.
             RUN cotizar_moneda.p ( INPUT  "DO",
                                    INPUT  Cta_cte.cdg_empresa,
                                    INPUT  T-Rec_header.fecha,
                                    OUTPUT T-Rec_detalle.new_cambio_dolar,
                                    OUTPUT x-fecha_cotizacion).
         END.
         ELSE DO:
             ASSIGN T-Rec_detalle.new_cambio_dolar = 1
                    T-Rec_detalle.new_cambio       = 1
                    T-Rec_detalle.prc_difcambio    = 0
                    T-Rec_detalle.prc_mincambio    = 0.
         END.
     END.
     ELSE DO:
         FIND Cliente OF T-Rec_header NO-LOCK.
         ASSIGN T-Rec_detalle.prc_difcambio = Cliente.prc_difcambio
                T-Rec_detalle.prc_mincambio = Cliente.prc_mincambio.

         RUN cotizar_moneda.p ( INPUT  Moneda.cdg_moneda,
                                INPUT  Cta_cte.cdg_empresa,
                                INPUT  T-Rec_header.fecha,
                                OUTPUT T-Rec_detalle.new_cambio,
                                OUTPUT x-fecha_cotizacion).
         T-Rec_detalle.new_cambio_dolar = T-Rec_detalle.new_cambio.
     END.

  END.
  ELSE DO:
     FIND FIRST T-Rec_detalle WHERE T-Rec_detalle.nro_linea = p-nro_linea-i EXCLUSIVE-LOCK.
  END.

  DISPLAY 
     T-Rec_detalle.importe 
     T-Rec_detalle.cambio           
     T-Rec_detalle.cambio_dolar     
     T-Rec_detalle.leyenda          
     T-Rec_detalle.new_cambio 
     T-Rec_detalle.new_cambio_dolar 
     T-Rec_detalle.prc_difcambio
     T-Rec_detalle.prc_mincambio
     v-moneda
     v-clausula_dolar
     v-saldo
     WITH FRAME {&FRAME-NAME}.      

  FRAME {&FRAME-NAME}:TITLE = Cta_cte.tip_comprob + " " +
                              STRING(Cta_cte.prf_comprob,"9999") + " " +
                              STRING(Cta_cte.nro_comprob,"99999999").

  RUN habilitar_campos.

/*WAIT-FOR GO OF FRAME {&FRAME-NAME}.*/
  WAIT-FOR U1 OF THIS-PROCEDURE.
  CASE codigo_salir:
       WHEN CD_SALIR    THEN UNDO,LEAVE.
       WHEN CD_CANCELAR THEN UNDO,RETRY.
       WHEN CD_GRABAR   THEN LEAVE.
  END CASE.

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
  DISPLAY v-moneda v-clausula_dolar v-saldo 
      WITH FRAME Dialog-Frame.
  IF AVAILABLE T-Rec_detalle THEN 
    DISPLAY T-Rec_detalle.prc_difcambio T-Rec_detalle.prc_mincambio 
          T-Rec_detalle.importe T-Rec_detalle.cambio T-Rec_detalle.new_cambio 
          T-Rec_detalle.new_cambio_dolar T-Rec_detalle.cambio_dolar 
          T-Rec_detalle.leyenda 
      WITH FRAME Dialog-Frame.
  ENABLE T-Rec_detalle.prc_difcambio T-Rec_detalle.prc_mincambio 
         T-Rec_detalle.new_cambio T-Rec_detalle.new_cambio_dolar Btn_Cancel 
         RECT-1 RECT-2 RECT-3 
      WITH FRAME Dialog-Frame.
  VIEW FRAME Dialog-Frame.
  {&OPEN-BROWSERS-IN-QUERY-Dialog-Frame}
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE habilitar_campos Dialog-Frame 
PROCEDURE habilitar_campos :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

  DO WITH FRAME {&FRAME-NAME}:

    ASSIGN
        Btn_Cancel:SENSITIVE                                = NO
        Btn_OK:SENSITIVE                                    = NO
        T-Rec_detalle.importe:SENSITIVE                     = NO
        T-Rec_detalle.new_cambio:SENSITIVE                  = NO
        T-Rec_detalle.new_cambio_dolar:SENSITIVE            = NO
        T-Rec_detalle.prc_difcambio:SENSITIVE               = NO 
        T-Rec_detalle.prc_mincambio:SENSITIVE               = NO.

    CASE p-modo-cabecera:

        WHEN MD_ALTA                   
        THEN DO:
            ASSIGN
                Btn_Cancel:SENSITIVE                                = YES
                Btn_OK:SENSITIVE                                    = YES
                T-Rec_detalle.importe:SENSITIVE                     = YES
                T-Rec_detalle.new_cambio:SENSITIVE                  = NOT Moneda.es_local
                T-Rec_detalle.new_cambio_dolar:SENSITIVE            = Moneda.es_local AND Cta_cte.clausula_dolar
                T-Rec_detalle.prc_difcambio:SENSITIVE               = T-Rec_detalle.new_cambio:SENSITIVE OR T-Rec_detalle.new_cambio_dolar:SENSITIVE 
                T-Rec_detalle.prc_mincambio:SENSITIVE               = T-Rec_detalle.new_cambio:SENSITIVE OR T-Rec_detalle.new_cambio_dolar:SENSITIVE.
        END.
        
        WHEN MD_MULTIPLE               
        THEN DO:
            ASSIGN
                Btn_Cancel:SENSITIVE                                = YES.
        END.
        
        WHEN MD_DEFINIDA               
        THEN DO:
            ASSIGN
                Btn_Cancel:SENSITIVE                                = YES.
        END.
        
        WHEN MD_RELACION               
        THEN DO:
            ASSIGN
                Btn_Cancel:SENSITIVE                                = YES.
        END.
        
        WHEN MD_READONLY               
        THEN DO:
            ASSIGN
                Btn_Cancel:SENSITIVE                                = YES.
        END.
        
        WHEN MD_CAMBIO                 
        THEN DO:
            ASSIGN
                Btn_Cancel:SENSITIVE                                = YES.
        END.
        
        WHEN MD_GENERADO               
        THEN DO:
            ASSIGN
                Btn_Cancel:SENSITIVE                                = YES.
        END.
         
        WHEN MD_ANULACION              
        THEN DO:
            ASSIGN
                Btn_Cancel:SENSITIVE                                = YES.
        END.
         
        WHEN MD_EMISION                
        THEN DO:
            ASSIGN
                Btn_Cancel:SENSITIVE                                = YES.
        END.

    END CASE.

  END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE validar_datos Dialog-Frame 
PROCEDURE validar_datos :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

   DEFINE OUTPUT PARAMETER hay_error AS LOGICAL.
   
   hay_error = YES.

   IF Cta_cte.debito > Cta_cte.credito
   THEN DO:
        IF T-Rec_detalle.importe > v-saldo
        THEN  DO:
            RUN PONMENSJ.P ( INPUT "CCTE001" ).
            RETURN.
        END.   
        ELSE DO:
            IF T-Rec_detalle.importe < 0
            THEN  DO:
               RUN PONMENSJ.P ( INPUT "CCTE002" ).
               RETURN.
            END.   
        END.
        
   END. 
   ELSE DO:
        IF T-Rec_detalle.importe < v-saldo
        THEN  DO:
            RUN PONMENSJ.P ( INPUT "CCTE001" ).
            RETURN.
        END.   
        ELSE DO:
            IF T-Rec_detalle.importe > 0
            THEN  DO:
               RUN PONMENSJ.P ( INPUT "CCTE002" ).
               RETURN.
            END.   
        END.
   END.   

   hay_error = NO.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

