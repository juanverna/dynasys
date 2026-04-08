&ANALYZE-SUSPEND _VERSION-NUMBER UIB_v8r12 GUI
&ANALYZE-RESUME
/* Connected Databases 
          padron           PROGRESS
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

/* Local Variable Definitions ---                                       */

&IF DEFINED(UIB_is_Running)
&THEN 
DEFINE VARIABLE rid_grupofam AS ROWID.
FIND FIRST Grupofam NO-LOCK.
rid_grupofam = ROWID(Grupofam). 
&ELSE
DEFINE INPUT PARAMETER rid_grupofam AS ROWID.
&ENDIF

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE DIALOG-BOX

/* Name of first Frame and/or Browse and/or first Query                 */
&Scoped-define FRAME-NAME Dialog-Frame

/* Internal Tables (found by Frame, Query & Browse Queries)             */
&Scoped-define INTERNAL-TABLES Grupofam

/* Definitions for DIALOG-BOX Dialog-Frame                              */
&Scoped-define FIELDS-IN-QUERY-Dialog-Frame Grupofam.cdg_grupofam ~
Grupofam.nom_grupofam 
&Scoped-define OPEN-QUERY-Dialog-Frame OPEN QUERY Dialog-Frame FOR EACH Grupofam SHARE-LOCK.
&Scoped-define TABLES-IN-QUERY-Dialog-Frame Grupofam
&Scoped-define FIRST-TABLE-IN-QUERY-Dialog-Frame Grupofam


/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS RECT-1 des_registro v-tip_comprob ~
v-prf_comprob v-nro_comprob v-mes v-ano v-fecha v-num_sucursal v-imp_total ~
Btn_OK Btn_Cancel 
&Scoped-Define DISPLAYED-FIELDS Grupofam.cdg_grupofam Grupofam.nom_grupofam 
&Scoped-Define DISPLAYED-OBJECTS des_registro des_nombre v-tip_comprob ~
v-prf_comprob v-nro_comprob v-mes v-ano v-fecha v-num_sucursal v-imp_total 

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

DEFINE VARIABLE des_nombre AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN NATIVE 
     SIZE 42 BY .77
     BGCOLOR 7 FGCOLOR 15  NO-UNDO.

DEFINE VARIABLE des_registro AS CHARACTER FORMAT "X(256)":U 
     LABEL "Cobrador" 
     VIEW-AS FILL-IN 
     SIZE 13 BY .77
     BGCOLOR 15 FGCOLOR 9  NO-UNDO.

DEFINE VARIABLE v-ano AS INTEGER FORMAT "9999" INITIAL 0 
     LABEL "Año" 
     VIEW-AS FILL-IN NATIVE 
     SIZE 7 BY .81
     BGCOLOR 15 FGCOLOR 9 .

DEFINE VARIABLE v-fecha AS DATE FORMAT "99/99/9999" 
     LABEL "Fecha" 
     VIEW-AS FILL-IN NATIVE 
     SIZE 13.14 BY .81
     BGCOLOR 15 FGCOLOR 9 .

DEFINE VARIABLE v-imp_total AS DECIMAL FORMAT "->>>>>>9.99" INITIAL 0 
     LABEL "Importe" 
     VIEW-AS FILL-IN 
     SIZE 12 BY .81
     BGCOLOR 15 FGCOLOR 9 .

DEFINE VARIABLE v-mes AS INTEGER FORMAT "99" INITIAL 0 
     LABEL "Mes" 
     VIEW-AS FILL-IN NATIVE 
     SIZE 4 BY .81
     BGCOLOR 15 FGCOLOR 9 .

DEFINE VARIABLE v-nro_comprob AS INTEGER FORMAT ">>>>>>>9" INITIAL 0 
     VIEW-AS FILL-IN NATIVE 
     SIZE 10.86 BY .81
     BGCOLOR 15 FGCOLOR 9 .

DEFINE VARIABLE v-num_sucursal AS CHARACTER FORMAT "X(4)" 
     LABEL "Sucursal" 
     VIEW-AS FILL-IN NATIVE 
     SIZE 7 BY .81
     BGCOLOR 15 FGCOLOR 9 .

DEFINE VARIABLE v-prf_comprob AS INTEGER FORMAT "9999" INITIAL 0 
     VIEW-AS FILL-IN NATIVE 
     SIZE 6.29 BY .81
     BGCOLOR 15 FGCOLOR 9 .

DEFINE VARIABLE v-tip_comprob AS CHARACTER FORMAT "X(3)" 
     LABEL "Tipo" 
     VIEW-AS FILL-IN 
     SIZE 13 BY .81.

DEFINE RECTANGLE RECT-1
     EDGE-PIXELS 4 GRAPHIC-EDGE  NO-FILL 
     SIZE 70 BY 7.81.

/* Query definitions                                                    */
&ANALYZE-SUSPEND
DEFINE QUERY Dialog-Frame FOR 
      Grupofam SCROLLING.
&ANALYZE-RESUME

/* ************************  Frame Definitions  *********************** */

DEFINE FRAME Dialog-Frame
     Grupofam.cdg_grupofam AT ROW 1.81 COL 12 COLON-ALIGNED
          LABEL "Socio"
          VIEW-AS FILL-IN NATIVE 
          SIZE 13 BY .81
          BGCOLOR 15 FGCOLOR 9 
     Grupofam.nom_grupofam AT ROW 1.81 COL 26 COLON-ALIGNED NO-LABEL
          VIEW-AS FILL-IN NATIVE 
          SIZE 42 BY .81
          BGCOLOR 7 FGCOLOR 15 
     des_registro AT ROW 2.88 COL 12 COLON-ALIGNED
     des_nombre AT ROW 2.88 COL 26 COLON-ALIGNED NO-LABEL
     v-tip_comprob AT ROW 3.96 COL 12 COLON-ALIGNED HELP
          "Tipo de comprobante"
     v-prf_comprob AT ROW 3.96 COL 26 COLON-ALIGNED HELP
          "Prefijo de comprobante" NO-LABEL
     v-nro_comprob AT ROW 3.96 COL 33 COLON-ALIGNED HELP
          "Nro. de comprobante" NO-LABEL
     v-mes AT ROW 3.96 COL 51 COLON-ALIGNED
     v-ano AT ROW 3.96 COL 61 COLON-ALIGNED HELP
          "Año al que imputa este registro de cuenta corriente"
     v-fecha AT ROW 5.31 COL 12 COLON-ALIGNED HELP
          "Fecha de emision"
     v-num_sucursal AT ROW 5.31 COL 37 COLON-ALIGNED HELP
          "Código de sucursal"
     v-imp_total AT ROW 5.31 COL 56 COLON-ALIGNED HELP
          "Importe total, excluyendo descuentos"
     Btn_OK AT ROW 6.92 COL 14
     Btn_Cancel AT ROW 6.92 COL 55
     RECT-1 AT ROW 1.27 COL 3
     SPACE(5.42) SKIP(0.29)
    WITH VIEW-AS DIALOG-BOX KEEP-TAB-ORDER 
         SIDE-LABELS NO-UNDERLINE THREE-D  SCROLLABLE 
         TITLE "Emision de Débitos de Telmarketing"
         DEFAULT-BUTTON Btn_OK CANCEL-BUTTON Btn_Cancel.


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
ASSIGN 
       FRAME Dialog-Frame:SCROLLABLE       = FALSE
       FRAME Dialog-Frame:HIDDEN           = TRUE.

/* SETTINGS FOR FILL-IN Grupofam.cdg_grupofam IN FRAME Dialog-Frame
   NO-ENABLE EXP-LABEL                                                  */
/* SETTINGS FOR FILL-IN des_nombre IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN Grupofam.nom_grupofam IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME


/* Setting information for Queries and Browse Widgets fields            */

&ANALYZE-SUSPEND _QUERY-BLOCK DIALOG-BOX Dialog-Frame
/* Query rebuild information for DIALOG-BOX Dialog-Frame
     _TblList          = "padron.Grupofam"
     _Options          = "SHARE-LOCK"
     _Query            is NOT OPENED
*/  /* DIALOG-BOX Dialog-Frame */
&ANALYZE-RESUME

 




/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME Dialog-Frame
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Dialog-Frame Dialog-Frame
ON WINDOW-CLOSE OF FRAME Dialog-Frame /* Emision de Débitos de Telmarketing */
DO:
  APPLY "END-ERROR":U TO SELF.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME Btn_OK
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Btn_OK Dialog-Frame
ON CHOOSE OF Btn_OK IN FRAME Dialog-Frame /* OK */
DO:

   DO TRANSACTION:

        FIND Cliente OF Grupofam NO-LOCK.
        FIND Vendedor OF Cliente NO-LOCK.
        FIND FIRST Domicilio OF Cliente NO-LOCK.
        FIND Usuario WHERE Usuario.cdg_usuario = USERID("sic") NO-LOCK.
        FIND Moneda WHERE Moneda.cdg_moneda = "PE" NO-LOCK.
        FIND Condicion_venta WHERE Condicion_venta.cdg_cndventa = "00" NO-LOCK.
        
        CREATE  Rec_header.
        ASSIGN  Rec_header.cdg_empresa    = Grupofam.cdg_empresa
                Rec_header.nro_usuario    = Usuario.nro_usuario 
                Rec_header.nro_cobrador   = Cobrador.nro_cobrador 
                /*
                Rec_header.fecha          = TODAY 
                Rec_header.mes            = MONTH(Rec_header.fecha) 
                Rec_header.ano            = YEAR(Rec_header.fecha) 
                */
                Rec_header.nro_recibo     = NEXT-VALUE(proxima_transaccion) 
                Rec_header.nro_moneda     = Moneda.nro_moneda 
                Rec_header.cambio         = Moneda.cambio  
                Rec_header.tipo_pago      = 2
                Rec_header.cdg_imputacion = 4
                Rec_header.origen         = "A"            
                Rec_header.nro_cliente    = Cliente.nro_cliente
                Rec_header.nro_domicilio  = Domicilio.nro_domicilio
                Rec_header.cdg_provincia  = Domicilio.cdg_provincia
                Rec_header.nombre         = Grupofam.nom_grupofam
                Rec_header.nro_vendedor   = Vendedor.nro_vendedor
                Rec_header.nro_cndventa   = Condicion_venta.nro_cndventa.
    
        ASSIGN FRAME {&FRAME-NAME}
                v-fecha
                v-mes 
                v-ano 
                v-num_sucursal
                v-imp_total
                v-tip_comprob
                v-prf_comprob
                v-nro_comprob.
/*
        MESSAGE 
                STRING(v-fecha) SKIP
                STRING(v-mes) SKIP 
                STRING(v-ano) SKIP 
                v-num_sucursal
                STRING(v-imp_total) SKIP
                v-tip_comprob
                STRING(v-prf_comprob) SKIP
                STRING(v-nro_comprob) SKIP
                VIEW-AS ALERT-BOX MESSAGE TITLE "d-crear_recibo.w".
*/
        ASSIGN 
                Rec_header.fecha         = v-fecha
                Rec_header.mes           = v-mes
                Rec_header.ano           = v-ano
                Rec_header.num_sucursal  = v-num_sucursal
                Rec_header.imp_total     = v-imp_total
                Rec_header.tip_comprob   = v-tip_comprob
                Rec_header.prf_comprob   = v-prf_comprob
                Rec_header.nro_comprob   = v-nro_comprob. 
        
        RUN TOLETRAS.P (INPUT  Rec_header.imp_total, OUTPUT Rec_header.monto_letras ).
        IF Rec_header.leyenda <> ""
            THEN RUN RENGLONS.P (INPUT  Rec_header.leyenda, 
                                 INPUT  90,
                                 OUTPUT Rec_header.leyenda,
                                 INPUT  "|").
    
        CREATE Cta_cte.
        ASSIGN Cta_cte.cdg_empresa          = Rec_header.cdg_empresa
               Cta_cte.tip_comprob          = Rec_header.tip_comprob
               Cta_cte.prf_comprob          = Rec_header.prf_comprob
               Cta_cte.nro_comprob          = Rec_header.nro_comprob
               Cta_cte.nro_vencimiento      = 1
               Cta_cte.nro_cobrador         = Rec_header.nro_cobrador
               Cta_cte.cambio               = Rec_header.cambio
               Cta_cte.nro_moneda           = Rec_header.nro_moneda
               Cta_cte.cdg_imputacion       = Rec_header.cdg_imputacion
               Cta_cte.fecha_emision        = Rec_header.fecha
               Cta_cte.fecha_vencimiento    = Rec_header.fecha
               Cta_cte.nro_cliente          = Rec_header.nro_cliente
               Cta_cte.imp_neto             = Rec_header.imp_neto
               Cta_cte.imp_iva              = Rec_header.imp_total - Rec_header.imp_neto
               Cta_cte.imp_total            = Rec_header.imp_total
               Cta_cte.leyenda              = STRING(Rec_header.mes) + "/" + STRING(Rec_header.ano)
               Cta_cte.mes                  = Rec_header.mes
               Cta_cte.ano                  = Rec_header.ano
               Cta_cte.debito               = Rec_header.imp_total
               Cta_cte.credito              = 0.
    
   END.

END. /* De la transaccion */

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME des_registro
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL des_registro Dialog-Frame
ON + OF des_registro IN FRAME Dialog-Frame /* Cobrador */
DO:
  APPLY "MOUSE-MENU-DOWN" TO SELF.
  RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL des_registro Dialog-Frame
ON MOUSE-MENU-DOWN OF des_registro IN FRAME Dialog-Frame /* Cobrador */
DO:
  &SCOPED-DEFINE ROWID_TABLA        rid_descobrador
  &SCOPED-DEFINE SELECCION          SELCOBRA.P
  &SCOPED-DEFINE TABLA              Cobrador
  &SCOPED-DEFINE CDG_TABLA          cdg_cobrador
  &SCOPED-DEFINE DSC_TABLA          nom_cobrador
  &SCOPED-DEFINE V-DSC_TABLA        des_nombre    
  &SCOPED-DEFINE V-CDG_TABLA        des_registro    
  &SCOPED-DEFINE MOSTRAR_DSC        YES

  {hlptabla-var.i}      

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL des_registro Dialog-Frame
ON RETURN OF des_registro IN FRAME Dialog-Frame /* Cobrador */
DO:

    ASSIGN FRAME {&FRAME-NAME} des_registro.
    IF SELF:SCREEN-VALUE IN FRAME {&FRAME-NAME} <> ""
        THEN FIND Cobrador WHERE Cobrador.cdg_cobrador = SELF:SCREEN-VALUE IN FRAME {&FRAME-NAME} NO-LOCK NO-ERROR.
        ELSE FIND FIRST Cobrador NO-LOCK NO-ERROR.
    
    IF AVAILABLE Cobrador 
    THEN DO:
         des_nombre = Cobrador.nom_cobrador.
         des_registro = Cobrador.cdg_cobrador.
    END.
    ELSE DO:
         des_nombre = "???".
    END.

    DISPLAY des_nombre des_registro WITH FRAME {&FRAME-NAME}.

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
  
  FIND Grupofam WHERE ROWID(Grupofam) = rid_grupofam NO-LOCK.
  FIND Cobrador OF Grupofam NO-LOCK.
  des_registro = Cobrador.cdg_cobrador.
  des_nombre   = Cobrador.nom_cobrador.
  DISPLAY Grupofam.cdg_grupofam  
          Grupofam.nom_grupofam
          des_registro
          des_nombre
          WITH FRAME {&FRAME-NAME}.
   
  RUN enable_UI.
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
  DISPLAY des_registro des_nombre v-tip_comprob v-prf_comprob v-nro_comprob 
          v-mes v-ano v-fecha v-num_sucursal v-imp_total 
      WITH FRAME Dialog-Frame.
  IF AVAILABLE Grupofam THEN 
    DISPLAY Grupofam.cdg_grupofam Grupofam.nom_grupofam 
      WITH FRAME Dialog-Frame.
  ENABLE RECT-1 des_registro v-tip_comprob v-prf_comprob v-nro_comprob v-mes 
         v-ano v-fecha v-num_sucursal v-imp_total Btn_OK Btn_Cancel 
      WITH FRAME Dialog-Frame.
  VIEW FRAME Dialog-Frame.
  {&OPEN-BROWSERS-IN-QUERY-Dialog-Frame}
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


