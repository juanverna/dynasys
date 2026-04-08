&ANALYZE-SUSPEND _VERSION-NUMBER UIB_v8r12 GUI
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
/*          This .W file was created with the Progress UIB.             */
/*----------------------------------------------------------------------*/

/* ***************************  Definitions  ************************** */

/* Parameters Definitions ---                                           */

/* Local Variable Definitions ---                                       */

  DEFINE VARIABLE que_empresa   LIKE Empresa.cdg_empresa.
  DEFINE VARIABLE fecha_inicial AS DATE.
  DEFINE VARIABLE fecha_elegida AS DATE.

  DEFINE VARIABLE sino          AS LOGICAL.
  DEFINE VARIABLE dire_tmp      AS CHARACTER.

  DEFINE VARIABLE rid_tabla     AS ROWID NO-UNDO.
  DEFINE VARIABLE no_aplicar    AS LOGICAL NO-UNDO.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE DIALOG-BOX
&Scoped-define DB-AWARE no

/* Name of first Frame and/or Browse and/or first Query                 */
&Scoped-define FRAME-NAME Dialog-Frame

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS v-cdg_caja v-cdg_cuenta_bancaria ~
v-fecha_deposito v-totdeposito v-referencia Btn_OK Btn_Cancel RECT-1 
&Scoped-Define DISPLAYED-OBJECTS v-cdg_caja v-dsc_caja ~
v-cdg_cuenta_bancaria v-dsc_cuenta_bancaria v-fecha_deposito v-totdeposito ~
v-referencia 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME



/* ***********************  Control Definitions  ********************** */

/* Define a dialog box                                                  */

/* Definitions of the field level widgets                               */
DEFINE BUTTON Btn_Cancel AUTO-END-KEY 
     LABEL "&Salir" 
     SIZE 15 BY 1.14
     BGCOLOR 8 .

DEFINE BUTTON Btn_OK 
     LABEL "&Hacer" 
     SIZE 15 BY 1.14
     BGCOLOR 8 .

DEFINE VARIABLE v-cdg_caja AS INTEGER FORMAT "->,>>>,>>9" INITIAL 0 
     LABEL "Caja" 
     VIEW-AS FILL-IN 
     SIZE 11 BY 1
     BGCOLOR 15 FGCOLOR 9 .

DEFINE VARIABLE v-cdg_cuenta_bancaria AS CHARACTER FORMAT "X(8)" 
     LABEL "Cuenta" 
     VIEW-AS FILL-IN 
     SIZE 11 BY 1
     BGCOLOR 15 FGCOLOR 9 .

DEFINE VARIABLE v-dsc_caja AS CHARACTER FORMAT "X(25)" 
     VIEW-AS FILL-IN 
     SIZE 37 BY 1
     BGCOLOR 7 FGCOLOR 15 .

DEFINE VARIABLE v-dsc_cuenta_bancaria AS CHARACTER FORMAT "X(25)" 
     VIEW-AS FILL-IN 
     SIZE 37 BY 1
     BGCOLOR 7 FGCOLOR 15 .

DEFINE VARIABLE v-fecha_deposito AS DATE FORMAT "99/99/99":U 
     LABEL "Fecha" 
     VIEW-AS FILL-IN 
     SIZE 11 BY 1
     BGCOLOR 15 FGCOLOR 9  NO-UNDO.

DEFINE VARIABLE v-referencia AS CHARACTER FORMAT "X(256)":U 
     LABEL "Ref." 
     VIEW-AS FILL-IN 
     SIZE 49 BY 1
     BGCOLOR 15 FGCOLOR 9  NO-UNDO.

DEFINE VARIABLE v-totdeposito AS DECIMAL FORMAT ">>,>>>,>>9.99":U INITIAL 0 
     LABEL "$" 
     VIEW-AS FILL-IN 
     SIZE 16 BY 1
     BGCOLOR 15 FGCOLOR 9 FONT 6 NO-UNDO.

DEFINE RECTANGLE RECT-1
     EDGE-PIXELS 4 GRAPHIC-EDGE  NO-FILL 
     SIZE 64 BY 7.29.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME Dialog-Frame
     v-cdg_caja AT ROW 3 COL 13 COLON-ALIGNED
     v-dsc_caja AT ROW 3 COL 25 COLON-ALIGNED NO-LABEL
     v-cdg_cuenta_bancaria AT ROW 4.19 COL 13 COLON-ALIGNED
     v-dsc_cuenta_bancaria AT ROW 4.19 COL 25 COLON-ALIGNED NO-LABEL
     v-fecha_deposito AT ROW 5.38 COL 13 COLON-ALIGNED
     v-totdeposito AT ROW 5.38 COL 46 COLON-ALIGNED
     v-referencia AT ROW 6.57 COL 13 COLON-ALIGNED
     Btn_OK AT ROW 7.81 COL 15
     Btn_Cancel AT ROW 7.81 COL 49
     RECT-1 AT ROW 2.43 COL 4
     "                       DEPOSITO DE EFECTIVO" VIEW-AS TEXT
          SIZE 64 BY 1 AT ROW 1.24 COL 4
          BGCOLOR 9 FGCOLOR 15 FONT 6
     SPACE(3.59) SKIP(8.08)
    WITH VIEW-AS DIALOG-BOX KEEP-TAB-ORDER 
         SIDE-LABELS NO-UNDERLINE THREE-D  SCROLLABLE 
         TITLE "Registro de depósito en efectivo"
         DEFAULT-BUTTON Btn_OK CANCEL-BUTTON Btn_Cancel.


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
   NOT-VISIBLE                                                          */
ASSIGN 
       FRAME Dialog-Frame:SCROLLABLE       = FALSE.

/* SETTINGS FOR FILL-IN v-dsc_caja IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN v-dsc_cuenta_bancaria IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME Dialog-Frame
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Dialog-Frame Dialog-Frame
ON WINDOW-CLOSE OF FRAME Dialog-Frame /* Registro de depósito en efectivo */
DO:
  APPLY "END-ERROR":U TO SELF.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME Btn_OK
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Btn_OK Dialog-Frame
ON CHOOSE OF Btn_OK IN FRAME Dialog-Frame /* Hacer */
DO:
/*
  ASSIGN FRAME {&FRAME-NAME}
        T-Caj_header.fecha 
        T-Caj_header.fch_cambio 
        T-Caj_header.cambio
        T-Caj_header.importe 
        T-Caj_header.observacion 
        T-Caj_header.tipo_mov
        v-cdg_receptora.
*/
  DEFINE VARIABLE hay_error AS LOGICAL.
  RUN validar_datos ( OUTPUT hay_error).
  IF NOT hay_error
  THEN DO:
      ASSIGN FRAME {&FRAME-NAME} v-cdg_caja v-cdg_cuenta_bancaria.
      RUN depositar_efectivo.
  END.
  ELSE RETURN NO-APPLY.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME v-cdg_caja
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-cdg_caja Dialog-Frame
ON MOUSE-SELECT-DBLCLICK OF v-cdg_caja IN FRAME Dialog-Frame /* Caja */
OR "." OF v-cdg_caja IN FRAME {&FRAME-NAME}
OR MOUSE-MENU-DOWN OF v-cdg_caja IN FRAME {&FRAME-NAME}
DO:
   {helptabla.i "caja" "cdg_caja" "SELNCAJA.P"}
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-cdg_caja Dialog-Frame
ON RETURN OF v-cdg_caja IN FRAME Dialog-Frame /* Caja */
DO:
   &SCOPED-DEFINE PONER-TABLA RUN poner_caja.
   {traducetabla.i "caja" "cdg_caja" "nombre"} 
   &UNDEFINE PONER-TABLA
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME v-cdg_cuenta_bancaria
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-cdg_cuenta_bancaria Dialog-Frame
ON MOUSE-SELECT-DBLCLICK OF v-cdg_cuenta_bancaria IN FRAME Dialog-Frame /* Cuenta */
OR "." OF v-cdg_cuenta_bancaria IN FRAME {&FRAME-NAME}
OR MOUSE-MENU-DOWN OF v-cdg_cuenta_bancaria IN FRAME {&FRAME-NAME}
DO:
   {helptabla.i "Cuenta_bancaria" "cdg_cuenta_ban" "selctbco.p"}
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-cdg_cuenta_bancaria Dialog-Frame
ON RETURN OF v-cdg_cuenta_bancaria IN FRAME Dialog-Frame /* Cuenta */
DO:
   {traducetabla.i "Cuenta_bancaria" "cdg_cuenta_ban" "denominacion_cta"} 
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME v-fecha_deposito
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-fecha_deposito Dialog-Frame
ON MOUSE-MENU-DOWN OF v-fecha_deposito IN FRAME Dialog-Frame /* Fecha */
DO:

  fecha_inicial = DATE(v-fecha_deposito:SCREEN-VALUE IN FRAME {&FRAME-NAME}) NO-ERROR.
  IF fecha_inicial = ? THEN fecha_inicial = TODAY.
  RUN d-calendario.w ( INPUT fecha_inicial, OUTPUT fecha_elegida).
  IF fecha_elegida <> ?
  THEN DO:
       DISPLAY fecha_elegida @ v-fecha_deposito 
               WITH FRAME {&FRAME-NAME}.
       APPLY "TAB" TO SELF.        
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

{findempresa.i}

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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE depositar_efectivo Dialog-Frame 
PROCEDURE depositar_efectivo :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

    DEFINE VARIABLE cod_efectivo        LIKE Rubro.cdg_rubro.
    DEFINE VARIABLE v-comprobante       AS CHARACTER.

    {parlocales.i}

    {findempresa.i}

    RUN getparametro.p (  INPUT  "DFCCJEFV",
                          OUTPUT v-valor_c,
                          OUTPUT v-valor_d,
                          OUTPUT v-valor_l,
                          OUTPUT v-valor_n,
                          OUTPUT v-observacion ).

    
    IF v-valor_n <> ? 
       THEN  cod_efectivo = v-valor_n.
       ELSE  cod_efectivo = 1.
    
    FIND Cuenta_bancaria WHERE Cuenta_bancaria.cdg_cuenta_ban = v-cdg_cuenta_bancaria NO-LOCK.
    FIND Cuenta WHERE Cuenta.nro_cuenta = Cuenta_bancaria.nro_cuenta_acredita NO-LOCK.

    DO TRANSACTION:
        
        ASSIGN FRAME {&FRAME-NAME} v-fecha_deposito v-totdeposito v-referencia.

        FIND Parametro 
             WHERE Parametro.cdg_parametro = "PROXNCAJ" 
               AND Parametro.cdg_empresa   = Empresa.cdg_empresa
                   EXCLUSIVE-LOCK.
    
        FIND FIRST Moneda WHERE Moneda.es_local NO-LOCK.

        CREATE Caj_header.
        ASSIGN Caj_header.fecha           = v-fecha_deposito
               Caj_header.hora            = TIME
               Caj_header.cdg_empresa     = Empresa.cdg_empresa
               Caj_header.tip_comprob     = "DP"
               Caj_header.ultima_linea    = 0
               Caj_header.cambio          = 1
               Caj_header.nro_moneda      = Moneda.nro_moneda
               Caj_header.nro_transaccion = NEXT-VALUE(proxima_txncaja)
               Caj_header.ingreso         = 0
               Caj_header.cdg_caja        = Caja.cdg_caja
               Caj_header.nro_cuenta      = Cuenta.nro_cuenta
               Caj_header.emitir          = YES
               Caj_header.importe         = 0 
               Caj_header.nro_cliente     = 0
               Caj_header.tipo_mov        = "E"
               Caj_header.observacion     = "Deposito bancario"
               Caj_header.nro_comprob     = Parametro.valor_n
               Parametro.valor_n          = Parametro.valor_n + 1.

        CREATE Boleta_deposito_hd.
        ASSIGN Boleta_deposito_hd.cdg_caja        = Caja.cdg_caja
               Boleta_deposito_hd.cdg_cuenta_ban  = Cuenta_bancaria.cdg_cuenta_ban
               Boleta_deposito_hd.efectivo        = v-totdeposito 
               Boleta_deposito_hd.fecha_deposito  = v-fecha_deposito
               Boleta_deposito_hd.nro_boletadep   = Caj_header.nro_comprob
               Boleta_deposito_hd.referencia      = v-referencia.
   
        Caj_header.ultima_linea = Caj_header.ultima_linea + 1.
        Caj_header.importe      = v-totdeposito.

       CREATE Caj_detalle.
       ASSIGN Caj_detalle.cambio           = 0
              Caj_detalle.cdg_Rubro        = cod_efectivo
              Caj_detalle.divisas          = 0
              Caj_detalle.importe          = v-totdeposito
              Caj_detalle.nro_linea        = Caj_header.ultima_linea
              Caj_detalle.nro_transaccion  = Caj_header.nro_transaccion
              Caj_detalle.observacion      = Caj_header.observacion
              Caj_detalle.tipo_mov         = Caj_header.tipo_mov.

       CREATE Caja-imputacion.
       ASSIGN Caja-imputacion.nro_transaccion = Caj_header.nro_transaccion
              Caja-imputacion.nro_cuenta      = Cuenta_bancaria.nro_cuenta_acredita
              Caja-imputacion.valor           = Caj_header.importe
              caja-imputacion.nro_entidad     = Caja.nro_entidad.

       CREATE Cta_cte_bco.
       ASSIGN Cta_cte_bco.tip_comprob     = Caj_header.tip_comprob
              Cta_cte_bco.prf_comprob     = Caj_header.prf_comprob
              Cta_cte_bco.nro_comprob     = Caj_header.nro_comprob
              Cta_cte_bco.fecha_efectiva  = Caj_header.fecha
              Cta_cte_bco.fecha_movimto   = Caj_header.fecha
              Cta_cte_bco.credito         = v-totdeposito
              Cta_cte_bco.debito          = 0
              Cta_cte_bco.cdg_cuenta_ban  = Cuenta_bancaria.cdg_cuenta_ban.
   
       Caj_header.observacion = v-referencia.
       v-comprobante = Caj_header.tip_comprob + " " + 
                       STRING(Caj_header.prf_comprob,"9999") + " " + 
                       STRING(Caj_header.nro_comprob,"99999999").

       RELEASE Parametro.
       RELEASE Caj_header.
       RELEASE Caj_detalle.
       RELEASE Cta_cte_bco.
       RELEASE Boleta_deposito_hd.
       
 END. /* De la transaccion de deposito */
 
 MESSAGE "Comprobante " v-comprobante
         VIEW-AS ALERT-BOX MESSAGE TITLE "Depósito registrado". 
            
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

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
  DISPLAY v-cdg_caja v-dsc_caja v-cdg_cuenta_bancaria v-dsc_cuenta_bancaria 
          v-fecha_deposito v-totdeposito v-referencia 
      WITH FRAME Dialog-Frame.
  ENABLE v-cdg_caja v-cdg_cuenta_bancaria v-fecha_deposito v-totdeposito 
         v-referencia Btn_OK Btn_Cancel RECT-1 
      WITH FRAME Dialog-Frame.
  {&OPEN-BROWSERS-IN-QUERY-Dialog-Frame}
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE poner_caja Dialog-Frame 
PROCEDURE poner_caja :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
  
  IF NOT CAN-DO(Caja.lista_usuarios,Usuario.cdg_usuario)
  THEN DO:
      no_aplicar = YES.
      RUN ponmensj.p ( INPUT "CAJA028" ).
      RETURN ERROR.

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

    DEFINE OUTPUT PARAMETER p-error AS LOGICAL.

    p-error = YES.

    {validartabla.i "Caja"              "cdg_caja"        "nombre"             "DEPF001"}
    {validartabla.i "Cuenta_bancaria"   "cdg_cuenta_ban"  "denominacion_cta"   "DEPF002"}

    IF v-fecha_deposito:INPUT-VALUE = DATE("")
    THEN DO:
        RUN ponmensj.p ( INPUT "DEPF003").
        RETURN ERROR.
    END.

    IF v-totdeposito:INPUT-VALUE = 0
    THEN DO:
        RUN ponmensj.p ( INPUT "DEPF004").
        RETURN ERROR.
    END.

    p-error = NO.



END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

