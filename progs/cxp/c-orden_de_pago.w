&ANALYZE-SUSPEND _VERSION-NUMBER UIB_v8r12 GUI
&ANALYZE-RESUME
/* Connected Databases 
          sic              PROGRESS
*/
&Scoped-define WINDOW-NAME C-Win


/* Temp-Table and Buffer definitions                                    */
DEFINE BUFFER Comprobante_cambio FOR Tipocomprobante.
DEFINE BUFFER Moneda_detalle FOR Moneda.
DEFINE BUFFER Moneda_local FOR Moneda.
DEFINE BUFFER Moneda_totales FOR Moneda.
DEFINE BUFFER PX-Opg_header FOR Opg_header.
DEFINE TEMP-TABLE T-Asn_detalle NO-UNDO LIKE Asn_detalle.
DEFINE TEMP-TABLE T-Asn_header NO-UNDO LIKE Asn_header.
DEFINE TEMP-TABLE T-Asn_totales NO-UNDO LIKE Asn_totales.
DEFINE TEMP-TABLE T-Caja-imputacion NO-UNDO LIKE Caja-imputacion.
DEFINE TEMP-TABLE T-Caj_detalle NO-UNDO LIKE Caj_detalle.
DEFINE TEMP-TABLE T-Caj_header NO-UNDO LIKE Caj_header.
DEFINE TEMP-TABLE T-Certificado_gan NO-UNDO LIKE Certificado_gan.
DEFINE TEMP-TABLE T-Certificado_ibr NO-UNDO LIKE Certificado_ibr.
DEFINE TEMP-TABLE T-Certificado_iva NO-UNDO LIKE Certificado_iva.
DEFINE TEMP-TABLE T-Certificado_sus NO-UNDO LIKE Certificado_sus.
DEFINE TEMP-TABLE T-Cert_gan-detalle NO-UNDO LIKE Cert_gan-detalle.
DEFINE TEMP-TABLE T-Cert_ibr-detalle NO-UNDO LIKE Cert_ibr-detalle.
DEFINE TEMP-TABLE T-Cert_iva-detalle NO-UNDO LIKE Cert_iva-detalle.
DEFINE TEMP-TABLE T-Cert_sus-detalle NO-UNDO LIKE Cert_sus-detalle.
DEFINE TEMP-TABLE T-Cheque NO-UNDO LIKE Cheque.
DEFINE TEMP-TABLE T-Cta_cte_prv NO-UNDO LIKE Cta_cte_prv.
DEFINE TEMP-TABLE T-Fac_detalle_prv NO-UNDO LIKE Fac_detalle_prv.
DEFINE TEMP-TABLE T-Fac_detalle_prv_bon NO-UNDO LIKE Fac_detalle_prv_bon.
DEFINE TEMP-TABLE T-Fac_detalle_prv_impuesto NO-UNDO LIKE Fac_detalle_prv_impuesto.
DEFINE TEMP-TABLE T-Fac_header_prv NO-UNDO LIKE Fac_header_prv.
DEFINE TEMP-TABLE T-Fac_header_prv_bon NO-UNDO LIKE Fac_header_prv_bon.
DEFINE TEMP-TABLE T-Fac_header_prv_impuesto NO-UNDO LIKE Fac_header_prv_impuesto.
DEFINE TEMP-TABLE T-Opg_detalle NO-UNDO LIKE Opg_detalle.
DEFINE NEW SHARED TEMP-TABLE T-Opg_header NO-UNDO LIKE Opg_header.
DEFINE TEMP-TABLE T-Pagos_x_actividad NO-UNDO LIKE Pagos_x_actividad.
DEFINE TEMP-TABLE T-Pagos_x_actividad_det NO-UNDO LIKE Pagos_x_actividad_det.
DEFINE TEMP-TABLE T-Pagos_x_retibr NO-UNDO LIKE Pagos_x_retibr.
DEFINE TEMP-TABLE T-Pagos_x_retibr_det NO-UNDO LIKE Pagos_x_retibr_det.
DEFINE TEMP-TABLE T-Pagos_x_retiva NO-UNDO LIKE Pagos_x_retiva.
DEFINE TEMP-TABLE T-Pagos_x_retiva_det NO-UNDO LIKE Pagos_x_retiva_det.
DEFINE TEMP-TABLE T-Pagos_x_retsus NO-UNDO LIKE Pagos_x_retsus.
DEFINE TEMP-TABLE T-Pagos_x_retsus_det NO-UNDO LIKE Pagos_x_retsus_det.
DEFINE TEMP-TABLE T-Sub_detalle_prv NO-UNDO LIKE Sub_detalle_prv.
DEFINE TEMP-TABLE T-Sub_header_prv NO-UNDO LIKE Sub_header_prv.
DEFINE TEMP-TABLE T-Totales_opago NO-UNDO LIKE Totales_opago.
DEFINE TEMP-TABLE T-Valor NO-UNDO LIKE Valor.



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
/*          This .W file was created with the Progress UIB.             */
/*----------------------------------------------------------------------*/

/* Create an unnamed pool to store all the widgets created 
     by this procedure. This is a good default which assures
     that this procedure's triggers and internal procedures 
     will execute in this procedure's storage, and that proper
     cleanup will occur on deletion of the procedure. */

CREATE WIDGET-POOL.

/* ***************************  Definitions  ************************** */

/* Parameters Definitions ---                                           */
&IF DEFINED(UIB_is_Running) NE 0
&THEN
DEFINE VARIABLE                rid_opago     AS ROWID.
DEFINE VARIABLE                modo           AS INTEGER.
&ELSE
DEFINE INPUT-OUTPUT PARAMETER  rid_opago     AS ROWID.
DEFINE INPUT        PARAMETER  modo           AS INTEGER.
&ENDIF

/* Local Variable Definitions ---                                       */

{VRSHARED.I "NEW"}

{nrorelea.i}
{valoresmodo.i}
{valoressalida.i}

DEFINE VARIABLE cotiza_dolar              AS DECIMAL.
DEFINE VARIABLE codigo_dolar              LIKE Moneda.cdg_moneda.
DEFINE VARIABLE v-tip_comprob             AS CHARACTER.
DEFINE VARIABLE dfl_leyenda               AS CHARACTER.

DEFINE VARIABLE sino-msg                  AS LOGICAL NO-UNDO.
DEFINE VARIABLE st_seleccionado           AS CHARACTER.

DEFINE VARIABLE v-prox_docum              LIKE Parametro.cdg_parametro INITIAL "PROXNASN".
DEFINE VARIABLE v-debito                  AS CHARACTER FORMAT "X(14)".
DEFINE VARIABLE v-credito                 AS CHARACTER FORMAT "X(14)".

DEFINE VARIABLE rid_tabla                 AS ROWID.

DEFINE VARIABLE v-nro_linea               AS INTEGER.
DEFINE VARIABLE v-nro_cuenta              AS INTEGER.
DEFINE VARIABLE aux_importe               AS DECIMAL.
DEFINE VARIABLE codigo_iva                AS INTEGER INITIAL 1.
DEFINE VARIABLE mod_cambio                AS LOGICAL.

DEFINE VARIABLE saldo_importe             LIKE Opg_detalle.importe.
DEFINE VARIABLE prop_importe              LIKE Opg_detalle.importe.
DEFINE VARIABLE v-pto_venta-org           LIKE Opg_header.prf_comprob.
DEFINE VARIABLE que_sector                LIKE Area.cdg_area.
DEFINE VARIABLE v-debito_cambio           LIKE Tipocomprobante.cdg_comprobante.
DEFINE VARIABLE v-credito_cambio          LIKE Tipocomprobante.cdg_comprobante.

DEFINE VARIABLE fecha_inicial             AS DATE.
DEFINE VARIABLE fecha_elegida             AS DATE.
/*
DEFINE BUFFER B-Sub_header_prv FOR T-Sub_header_prv.
DEFINE BUFFER B-Sub_detalle_prv FOR T-Sub_detalle_prv.
*/

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE Window
&Scoped-define DB-AWARE no

/* Name of designated FRAME-NAME and/or first browse and/or first query */
&Scoped-define FRAME-NAME DEFAULT-FRAME
&Scoped-define BROWSE-NAME BROWSE-6

/* Internal Tables (found by Frame, Query & Browse Queries)             */
&Scoped-define INTERNAL-TABLES T-Opg_detalle Moneda_detalle T-Totales_opago ~
Moneda_totales T-Opg_header

/* Definitions for BROWSE BROWSE-6                                      */
&Scoped-define FIELDS-IN-QUERY-BROWSE-6 T-Opg_detalle.tip_cancela ~
T-Opg_detalle.prf_cancela T-Opg_detalle.nro_cancela ~
T-Opg_detalle.nro_vencimiento Moneda_detalle.abrevia T-Opg_detalle.importe ~
T-Opg_detalle.imp_pesos T-Opg_detalle.cambio T-Opg_detalle.new_cambio ~
T-Opg_detalle.difcambio T-Opg_detalle.clausula_dolar ~
T-Opg_detalle.prc_difcambio T-Opg_detalle.prc_mincambio ~
T-Opg_detalle.leyenda 
&Scoped-define ENABLED-FIELDS-IN-QUERY-BROWSE-6 
&Scoped-define QUERY-STRING-BROWSE-6 FOR EACH T-Opg_detalle OF T-Opg_header NO-LOCK, ~
      EACH Moneda_detalle OF T-Opg_detalle NO-LOCK INDEXED-REPOSITION
&Scoped-define OPEN-QUERY-BROWSE-6 OPEN QUERY BROWSE-6 FOR EACH T-Opg_detalle OF T-Opg_header NO-LOCK, ~
      EACH Moneda_detalle OF T-Opg_detalle NO-LOCK INDEXED-REPOSITION.
&Scoped-define TABLES-IN-QUERY-BROWSE-6 T-Opg_detalle Moneda_detalle
&Scoped-define FIRST-TABLE-IN-QUERY-BROWSE-6 T-Opg_detalle
&Scoped-define SECOND-TABLE-IN-QUERY-BROWSE-6 Moneda_detalle


/* Definitions for BROWSE BRW-TOTALES                                   */
&Scoped-define FIELDS-IN-QUERY-BRW-TOTALES Moneda_totales.descripcion ~
T-Totales_opago.imp_total T-Totales_opago.imp_difcambio ~
T-Totales_opago.imp_pesos 
&Scoped-define ENABLED-FIELDS-IN-QUERY-BRW-TOTALES 
&Scoped-define QUERY-STRING-BRW-TOTALES FOR EACH T-Totales_opago OF T-Opg_header NO-LOCK, ~
      EACH Moneda_totales OF T-Opg_header NO-LOCK INDEXED-REPOSITION
&Scoped-define OPEN-QUERY-BRW-TOTALES OPEN QUERY BRW-TOTALES FOR EACH T-Totales_opago OF T-Opg_header NO-LOCK, ~
      EACH Moneda_totales OF T-Opg_header NO-LOCK INDEXED-REPOSITION.
&Scoped-define TABLES-IN-QUERY-BRW-TOTALES T-Totales_opago Moneda_totales
&Scoped-define FIRST-TABLE-IN-QUERY-BRW-TOTALES T-Totales_opago
&Scoped-define SECOND-TABLE-IN-QUERY-BRW-TOTALES Moneda_totales


/* Definitions for FRAME DEFAULT-FRAME                                  */
&Scoped-define FIELDS-IN-QUERY-DEFAULT-FRAME T-Opg_header.tip_comprob ~
T-Opg_header.prf_comprob T-Opg_header.nro_comprob T-Opg_header.fecha ~
T-Opg_header.fch_cambio T-Opg_header.mes T-Opg_header.ano ~
T-Opg_header.tipo_pago T-Opg_header.cambio T-Opg_header.calcular_cambio ~
T-Opg_header.cambio_dolar T-Opg_header.imp_pesos T-Opg_header.imp_bruto ~
T-Opg_header.imp_difcambio T-Opg_header.imp_total 
&Scoped-define OPEN-BROWSERS-IN-QUERY-DEFAULT-FRAME ~
    ~{&OPEN-QUERY-BROWSE-6}~
    ~{&OPEN-QUERY-BRW-TOTALES}
&Scoped-define QUERY-STRING-DEFAULT-FRAME FOR EACH T-Opg_header SHARE-LOCK
&Scoped-define OPEN-QUERY-DEFAULT-FRAME OPEN QUERY DEFAULT-FRAME FOR EACH T-Opg_header SHARE-LOCK.
&Scoped-define TABLES-IN-QUERY-DEFAULT-FRAME T-Opg_header
&Scoped-define FIRST-TABLE-IN-QUERY-DEFAULT-FRAME T-Opg_header


/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS RECT-10 RECT-11 RECT-12 RECT-13 RECT-2 ~
RECT-3 RECT-4 RECT-5 RECT-6 RECT-7 RECT-8 RECT-9 Btn_salir v-importe ~
BRW-TOTALES BROWSE-6 
&Scoped-Define DISPLAYED-FIELDS T-Opg_header.tip_comprob ~
T-Opg_header.prf_comprob T-Opg_header.nro_comprob T-Opg_header.fecha ~
T-Opg_header.fch_cambio T-Opg_header.mes T-Opg_header.ano ~
T-Opg_header.tipo_pago T-Opg_header.cambio T-Opg_header.calcular_cambio ~
T-Opg_header.cambio_dolar T-Opg_header.imp_pesos T-Opg_header.imp_bruto ~
T-Opg_header.imp_difcambio T-Opg_header.imp_total 
&Scoped-define DISPLAYED-TABLES T-Opg_header
&Scoped-define FIRST-DISPLAYED-TABLE T-Opg_header
&Scoped-Define DISPLAYED-OBJECTS v-anulado v-importe v-cdg_proveedor ~
v-dsc_proveedor v-cdg_domicilio v-dsc_domicilio v-abv_provincia ~
v-cdg_moneda v-dsc_moneda v-cdg_condicion_impos v-dsc_condicion_impos ~
v-cdg_imputacion v-dsc_imputacion a-tip_comprob a-prf_comprob a-nro_comprob ~
a-nro_vencimiento 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME



/* ***********************  Control Definitions  ********************** */

/* Define the widget handle for the window                              */
DEFINE VAR C-Win AS WIDGET-HANDLE NO-UNDO.

/* Definitions of the field level widgets                               */
DEFINE BUTTON btn_anular 
     LABEL "&Anular" 
     SIZE 21 BY 1.33.

DEFINE BUTTON btn_cancel 
     LABEL "&Cancelar" 
     SIZE 21 BY 1.33.

DEFINE BUTTON btn_grabar 
     LABEL "&Grabar" 
     SIZE 21 BY 1.33.

DEFINE BUTTON btn_imprim 
     LABEL "&Reimprimir" 
     SIZE 21 BY 1.33.

DEFINE BUTTON btn_leyenda 
     LABEL "&Leyenda" 
     SIZE 21 BY 1.33.

DEFINE BUTTON btn_nominar 
     LABEL "&Nominar" 
     SIZE 19 BY 1.

DEFINE BUTTON btn_observ 
     LABEL "&Observación" 
     SIZE 21 BY 1.33.

DEFINE BUTTON Btn_salir DEFAULT 
     LABEL "&Salir" 
     SIZE 20 BY 1.33
     BGCOLOR 8 .

DEFINE BUTTON btn_valores 
     LABEL "&Ver Caja" 
     SIZE 19 BY 1.

DEFINE VARIABLE a-nro_comprob AS INTEGER FORMAT ">>>>>>>9" INITIAL 0 
     VIEW-AS FILL-IN NATIVE 
     SIZE 13 BY 1
     BGCOLOR 15 FGCOLOR 9 .

DEFINE VARIABLE a-nro_vencimiento AS INTEGER FORMAT ">>9" INITIAL 0 
     VIEW-AS FILL-IN NATIVE 
     SIZE 5 BY 1
     BGCOLOR 15 FGCOLOR 9 .

DEFINE VARIABLE a-prf_comprob AS INTEGER FORMAT ">>>9" INITIAL 0 
     VIEW-AS FILL-IN NATIVE 
     SIZE 8 BY 1
     BGCOLOR 15 FGCOLOR 9 .

DEFINE VARIABLE a-tip_comprob AS CHARACTER FORMAT "X(3)" 
     LABEL "Aplicación" 
     VIEW-AS FILL-IN NATIVE 
     SIZE 8 BY 1
     BGCOLOR 15 FGCOLOR 9 .

DEFINE VARIABLE v-abv_provincia AS CHARACTER FORMAT "X(50)" 
     VIEW-AS FILL-IN 
     SIZE 20 BY 1
     BGCOLOR 7 FGCOLOR 15 .

DEFINE VARIABLE v-anulado AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 19 BY 1
     FGCOLOR 12 FONT 6 NO-UNDO.

DEFINE VARIABLE v-cdg_condicion_impos AS INTEGER FORMAT "->,>>>,>>9" INITIAL 0 
     LABEL "C.Iva." 
     VIEW-AS FILL-IN NATIVE 
     SIZE 13 BY 1
     BGCOLOR 15 FGCOLOR 9 .

DEFINE VARIABLE v-cdg_domicilio AS INTEGER FORMAT ">>>>>>9" INITIAL 0 
     LABEL "Domicilio" 
     VIEW-AS FILL-IN NATIVE 
     SIZE 15 BY 1
     BGCOLOR 15 FGCOLOR 9 .

DEFINE VARIABLE v-cdg_imputacion AS INTEGER FORMAT "->,>>>,>>9" INITIAL 0 
     LABEL "Imputación" 
     VIEW-AS FILL-IN NATIVE 
     SIZE 15 BY 1
     BGCOLOR 15 FGCOLOR 9 .

DEFINE VARIABLE v-cdg_moneda AS CHARACTER FORMAT "X(3)" 
     LABEL "Moneda" 
     VIEW-AS FILL-IN NATIVE 
     SIZE 15 BY 1
     BGCOLOR 15 FGCOLOR 9 .

DEFINE VARIABLE v-cdg_proveedor AS CHARACTER FORMAT "X(8)" 
     LABEL "Proveedor" 
     VIEW-AS FILL-IN NATIVE 
     SIZE 15 BY 1
     BGCOLOR 15 FGCOLOR 9 .

DEFINE VARIABLE v-dsc_condicion_impos AS CHARACTER FORMAT "X(25)" 
     VIEW-AS FILL-IN 
     SIZE 50 BY 1
     BGCOLOR 7 FGCOLOR 15 .

DEFINE VARIABLE v-dsc_domicilio AS CHARACTER FORMAT "X(40)" 
     VIEW-AS FILL-IN 
     SIZE 82 BY 1
     BGCOLOR 7 FGCOLOR 15 .

DEFINE VARIABLE v-dsc_imputacion AS CHARACTER FORMAT "X(30)" 
     VIEW-AS FILL-IN 
     SIZE 52 BY 1
     BGCOLOR 7 FGCOLOR 15 .

DEFINE VARIABLE v-dsc_moneda AS CHARACTER FORMAT "X(20)" 
     VIEW-AS FILL-IN 
     SIZE 37 BY 1
     BGCOLOR 7 FGCOLOR 15 .

DEFINE VARIABLE v-dsc_proveedor AS CHARACTER FORMAT "X(40)" 
     VIEW-AS FILL-IN 
     SIZE 82 BY 1
     BGCOLOR 7 FGCOLOR 15 .

DEFINE VARIABLE v-importe AS DECIMAL FORMAT ">>,>>>,>>9.99":U INITIAL 0 
     LABEL "Importe" 
     VIEW-AS FILL-IN NATIVE 
     SIZE 18 BY 1
     BGCOLOR 15 FGCOLOR 9  NO-UNDO.

DEFINE RECTANGLE RECT-10
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 35 BY 4.05.

DEFINE RECTANGLE RECT-11
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 156 BY 10.

DEFINE RECTANGLE RECT-12
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 83 BY 6.19.

DEFINE RECTANGLE RECT-13
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 72 BY 1.43.

DEFINE RECTANGLE RECT-2
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 134 BY 1.86.

DEFINE RECTANGLE RECT-3
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 22 BY 1.86.

DEFINE RECTANGLE RECT-4
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 134 BY 3.81.

DEFINE RECTANGLE RECT-5
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 19 BY 2.24.

DEFINE RECTANGLE RECT-6
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 21 BY 3.81.

DEFINE RECTANGLE RECT-7
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 156 BY 2.86.

DEFINE RECTANGLE RECT-8
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 72 BY 4.52.

DEFINE RECTANGLE RECT-9
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 34 BY 4.05.

/* Query definitions                                                    */
&ANALYZE-SUSPEND
DEFINE QUERY BROWSE-6 FOR 
      T-Opg_detalle, 
      Moneda_detalle SCROLLING.

DEFINE QUERY BRW-TOTALES FOR 
      T-Totales_opago, 
      Moneda_totales SCROLLING.

DEFINE QUERY DEFAULT-FRAME FOR 
      T-Opg_header SCROLLING.
&ANALYZE-RESUME

/* Browse definitions                                                   */
DEFINE BROWSE BROWSE-6
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS BROWSE-6 C-Win _STRUCTURED
  QUERY BROWSE-6 NO-LOCK DISPLAY
      T-Opg_detalle.tip_cancela FORMAT "X(3)":U
      T-Opg_detalle.prf_cancela FORMAT "9999":U
      T-Opg_detalle.nro_cancela FORMAT "ZZZZZZZZ9":U
      T-Opg_detalle.nro_vencimiento FORMAT ">>9":U
      Moneda_detalle.abrevia FORMAT "X(5)":U
      T-Opg_detalle.importe FORMAT "->>,>>>,>>9.99":U
      T-Opg_detalle.imp_pesos FORMAT "->>,>>>,>>9.99":U
      T-Opg_detalle.cambio FORMAT "->>,>>9.9999":U
      T-Opg_detalle.new_cambio FORMAT "->>,>>9.9999":U
      T-Opg_detalle.difcambio FORMAT "->,>>>,>>9.99":U
      T-Opg_detalle.clausula_dolar FORMAT "yes/no":U
      T-Opg_detalle.prc_difcambio FORMAT ">>9.99":U
      T-Opg_detalle.prc_mincambio FORMAT ">>9.99":U
      T-Opg_detalle.leyenda FORMAT "X(15)":U WIDTH 15.2
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ROW-MARKERS SIZE 153 BY 9.05
         TITLE "Comprobantes cancelados con la presente O/Pago" FIT-LAST-COLUMN.

DEFINE BROWSE BRW-TOTALES
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS BRW-TOTALES C-Win _STRUCTURED
  QUERY BRW-TOTALES NO-LOCK DISPLAY
      Moneda_totales.descripcion FORMAT "X(20)":U
      T-Totales_opago.imp_total FORMAT "->,>>>,>>>,>>9.99":U
      T-Totales_opago.imp_difcambio FORMAT "->,>>>,>>>,>>9.99":U
      T-Totales_opago.imp_pesos FORMAT "->,>>>,>>>,>>9.99":U
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ROW-MARKERS SEPARATORS SIZE 80 BY 5.71.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME DEFAULT-FRAME
     btn_cancel AT ROW 1.48 COL 27
     btn_anular AT ROW 1.48 COL 49
     btn_leyenda AT ROW 1.48 COL 71
     btn_observ AT ROW 1.48 COL 93
     btn_imprim AT ROW 1.48 COL 115
     Btn_salir AT ROW 1.48 COL 137
     btn_grabar AT ROW 1.52 COL 5
     v-anulado AT ROW 3.57 COL 137 COLON-ALIGNED NO-LABEL
     T-Opg_header.tip_comprob AT ROW 3.62 COL 15 COLON-ALIGNED
          VIEW-AS FILL-IN NATIVE 
          SIZE 6 BY 1
          BGCOLOR 15 FGCOLOR 9 
     T-Opg_header.prf_comprob AT ROW 3.62 COL 22 COLON-ALIGNED NO-LABEL
          VIEW-AS FILL-IN NATIVE 
          SIZE 8 BY 1
          BGCOLOR 15 FGCOLOR 9 
     T-Opg_header.nro_comprob AT ROW 3.62 COL 31 COLON-ALIGNED NO-LABEL
          VIEW-AS FILL-IN NATIVE 
          SIZE 16 BY 1
          BGCOLOR 15 FGCOLOR 9 
     T-Opg_header.fecha AT ROW 3.62 COL 56 COLON-ALIGNED
          VIEW-AS FILL-IN NATIVE 
          SIZE 17 BY 1
          BGCOLOR 15 FGCOLOR 9 
     v-importe AT ROW 3.62 COL 86 COLON-ALIGNED
     T-Opg_header.fch_cambio AT ROW 3.62 COL 118 COLON-ALIGNED
          LABEL "Cambio Al" FORMAT "99/99/99"
          VIEW-AS FILL-IN NATIVE 
          SIZE 16 BY 1
          BGCOLOR 15 FGCOLOR 9 
     v-cdg_proveedor AT ROW 4.81 COL 15 COLON-ALIGNED
     v-dsc_proveedor AT ROW 4.81 COL 31 COLON-ALIGNED NO-LABEL
     T-Opg_header.mes AT ROW 4.81 COL 118 COLON-ALIGNED
          LABEL "Per"
          VIEW-AS FILL-IN NATIVE 
          SIZE 7 BY 1
          BGCOLOR 15 FGCOLOR 9 
     T-Opg_header.ano AT ROW 4.81 COL 126 COLON-ALIGNED NO-LABEL
          VIEW-AS FILL-IN NATIVE 
          SIZE 8 BY 1
          BGCOLOR 15 FGCOLOR 9 
     T-Opg_header.tipo_pago AT ROW 5 COL 140 NO-LABEL
          VIEW-AS RADIO-SET VERTICAL
          RADIO-BUTTONS 
                    "Cancelación", 1,
"A Imputar", 2
          SIZE 17 BY 1.71
     v-cdg_domicilio AT ROW 6 COL 15 COLON-ALIGNED
     v-dsc_domicilio AT ROW 6 COL 31 COLON-ALIGNED NO-LABEL
     v-abv_provincia AT ROW 6 COL 114 COLON-ALIGNED NO-LABEL
     v-cdg_moneda AT ROW 7.67 COL 15 COLON-ALIGNED
     v-dsc_moneda AT ROW 7.67 COL 31 COLON-ALIGNED NO-LABEL
     T-Opg_header.cambio AT ROW 7.67 COL 69 COLON-ALIGNED NO-LABEL
          VIEW-AS FILL-IN NATIVE 
          SIZE 14 BY 1
          BGCOLOR 15 FGCOLOR 9 
     v-cdg_condicion_impos AT ROW 7.67 COL 91 COLON-ALIGNED
     v-dsc_condicion_impos AT ROW 7.67 COL 105 COLON-ALIGNED NO-LABEL
     v-cdg_imputacion AT ROW 8.86 COL 15 COLON-ALIGNED
     v-dsc_imputacion AT ROW 8.86 COL 31 COLON-ALIGNED NO-LABEL
     btn_nominar AT ROW 8.86 COL 87
     T-Opg_header.calcular_cambio AT ROW 8.86 COL 122 NO-LABEL
          VIEW-AS RADIO-SET HORIZONTAL
          RADIO-BUTTONS 
                    "Si", yes,
"No", no
          SIZE 14 BY 1.1
     T-Opg_header.cambio_dolar AT ROW 8.86 COL 141 COLON-ALIGNED
          VIEW-AS FILL-IN NATIVE 
          SIZE 14 BY 1
          BGCOLOR 15 FGCOLOR 9 
     BRW-TOTALES AT ROW 10.76 COL 5
     T-Opg_header.imp_pesos AT ROW 12.19 COL 102 COLON-ALIGNED
          LABEL "Eq.Pagado" FORMAT "->>>>,>>9.99"
          VIEW-AS FILL-IN 
          SIZE 17 BY 1
          BGCOLOR 7 FGCOLOR 15 
     T-Opg_header.imp_bruto AT ROW 12.19 COL 138 COLON-ALIGNED
          LABEL "Cancelado" FORMAT "->>>>,>>9.99"
          VIEW-AS FILL-IN NATIVE 
          SIZE 17 BY 1
          BGCOLOR 7 FGCOLOR 14 
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 158 BY 25.95.

/* DEFINE FRAME statement is approaching 4K Bytes.  Breaking it up   */
DEFINE FRAME DEFAULT-FRAME
     T-Opg_header.imp_difcambio AT ROW 13.38 COL 102 COLON-ALIGNED
          LABEL "Dif.Cambio"
          VIEW-AS FILL-IN 
          SIZE 17 BY 1
          BGCOLOR 7 FGCOLOR 15 
     T-Opg_header.imp_total AT ROW 13.38 COL 138 COLON-ALIGNED
          LABEL "Pagado" FORMAT "->>>>,>>9.99"
          VIEW-AS FILL-IN NATIVE 
          SIZE 17 BY 1
          BGCOLOR 7 FGCOLOR 15 
     btn_valores AT ROW 15.52 COL 88
     a-tip_comprob AT ROW 15.52 COL 118 COLON-ALIGNED HELP
          "Tipo de comprobante"
     a-prf_comprob AT ROW 15.52 COL 127 COLON-ALIGNED HELP
          "Prefijo de 4 digitos del comprobante" NO-LABEL
     a-nro_comprob AT ROW 15.52 COL 136 COLON-ALIGNED HELP
          "Nro. de comprobante" NO-LABEL
     a-nro_vencimiento AT ROW 15.52 COL 150 COLON-ALIGNED HELP
          "Numero de vencimiento del documento" NO-LABEL
     BROWSE-6 AT ROW 17.43 COL 5
     "   Total Pagado Equivalente" VIEW-AS TEXT
          SIZE 32 BY .86 AT ROW 11 COL 89
          BGCOLOR 1 FGCOLOR 15 FONT 4
     "Dif. de Cambio:" VIEW-AS TEXT
          SIZE 14 BY .95 AT ROW 8.86 COL 108
     "    Importes de esta O/Pago" VIEW-AS TEXT
          SIZE 33 BY .86 AT ROW 11 COL 124
          BGCOLOR 1 FGCOLOR 15 FONT 4
     RECT-10 AT ROW 10.76 COL 123
     RECT-11 AT ROW 16.95 COL 3
     RECT-12 AT ROW 10.52 COL 3
     RECT-13 AT ROW 15.29 COL 87
     RECT-2 AT ROW 1.24 COL 3
     RECT-3 AT ROW 1.24 COL 137
     RECT-4 AT ROW 3.38 COL 3
     RECT-5 AT ROW 4.71 COL 139
     RECT-6 AT ROW 3.38 COL 138
     RECT-7 AT ROW 7.43 COL 3
     RECT-8 AT ROW 10.52 COL 87
     RECT-9 AT ROW 10.76 COL 88
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 158 BY 25.95.


/* *********************** Procedure Settings ************************ */

&ANALYZE-SUSPEND _PROCEDURE-SETTINGS
/* Settings for THIS-PROCEDURE
   Type: Window
   Allow: Basic,Browse,DB-Fields,Window,Query
   Other Settings: COMPILE
   Temp-Tables and Buffers:
      TABLE: Comprobante_cambio B "?" ? sic Tipocomprobante
      TABLE: Moneda_detalle B "?" ? sic Moneda
      TABLE: Moneda_local B "?" ? sic Moneda
      TABLE: Moneda_totales B "?" ? sic Moneda
      TABLE: PX-Opg_header B "?" ? sic Opg_header
      TABLE: T-Asn_detalle T "?" NO-UNDO sic Asn_detalle
      TABLE: T-Asn_header T "?" NO-UNDO sic Asn_header
      TABLE: T-Asn_totales T "?" NO-UNDO sic Asn_totales
      TABLE: T-Caja-imputacion T "?" NO-UNDO sic Caja-imputacion
      TABLE: T-Caj_detalle T "?" NO-UNDO sic Caj_detalle
      TABLE: T-Caj_header T "?" NO-UNDO sic Caj_header
      TABLE: T-Certificado_gan T "?" NO-UNDO sic Certificado_gan
      TABLE: T-Certificado_ibr T "?" NO-UNDO sic Certificado_ibr
      TABLE: T-Certificado_iva T "?" NO-UNDO sic Certificado_iva
      TABLE: T-Certificado_sus T "?" NO-UNDO sic Certificado_sus
      TABLE: T-Cert_gan-detalle T "?" NO-UNDO sic Cert_gan-detalle
      TABLE: T-Cert_ibr-detalle T "?" NO-UNDO sic Cert_ibr-detalle
      TABLE: T-Cert_iva-detalle T "?" NO-UNDO sic Cert_iva-detalle
      TABLE: T-Cert_sus-detalle T "?" NO-UNDO sic Cert_sus-detalle
      TABLE: T-Cheque T "?" NO-UNDO sic Cheque
      TABLE: T-Cta_cte_prv T "?" NO-UNDO sic Cta_cte_prv
      TABLE: T-Fac_detalle_prv T "?" NO-UNDO sic Fac_detalle_prv
      TABLE: T-Fac_detalle_prv_bon T "?" NO-UNDO sic Fac_detalle_prv_bon
      TABLE: T-Fac_detalle_prv_impuesto T "?" NO-UNDO sic Fac_detalle_prv_impuesto
      TABLE: T-Fac_header_prv T "?" NO-UNDO sic Fac_header_prv
      TABLE: T-Fac_header_prv_bon T "?" NO-UNDO sic Fac_header_prv_bon
      TABLE: T-Fac_header_prv_impuesto T "?" NO-UNDO sic Fac_header_prv_impuesto
      TABLE: T-Opg_detalle T "?" NO-UNDO sic Opg_detalle
      TABLE: T-Opg_header T "NEW SHARED" NO-UNDO sic Opg_header
      TABLE: T-Pagos_x_actividad T "?" NO-UNDO sic Pagos_x_actividad
      TABLE: T-Pagos_x_actividad_det T "?" NO-UNDO sic Pagos_x_actividad_det
      TABLE: T-Pagos_x_retibr T "?" NO-UNDO sic Pagos_x_retibr
      TABLE: T-Pagos_x_retibr_det T "?" NO-UNDO sic Pagos_x_retibr_det
      TABLE: T-Pagos_x_retiva T "?" NO-UNDO sic Pagos_x_retiva
      TABLE: T-Pagos_x_retiva_det T "?" NO-UNDO sic Pagos_x_retiva_det
      TABLE: T-Pagos_x_retsus T "?" NO-UNDO sic Pagos_x_retsus
      TABLE: T-Pagos_x_retsus_det T "?" NO-UNDO sic Pagos_x_retsus_det
      TABLE: T-Sub_detalle_prv T "?" NO-UNDO sic Sub_detalle_prv
      TABLE: T-Sub_header_prv T "?" NO-UNDO sic Sub_header_prv
      TABLE: T-Totales_opago T "?" NO-UNDO sic Totales_opago
      TABLE: T-Valor T "?" NO-UNDO sic Valor
   END-TABLES.
 */
&ANALYZE-RESUME _END-PROCEDURE-SETTINGS

/* *************************  Create Window  ************************** */

&ANALYZE-SUSPEND _CREATE-WINDOW
IF SESSION:DISPLAY-TYPE = "GUI":U THEN
  CREATE WINDOW C-Win ASSIGN
         HIDDEN             = YES
         TITLE              = "Ordenes de Pago a Proveedores"
         HEIGHT             = 25.95
         WIDTH              = 158
         MAX-HEIGHT         = 27.67
         MAX-WIDTH          = 160
         VIRTUAL-HEIGHT     = 27.67
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
/* BROWSE-TAB BRW-TOTALES cambio_dolar DEFAULT-FRAME */
/* BROWSE-TAB BROWSE-6 a-nro_vencimiento DEFAULT-FRAME */
/* SETTINGS FOR FILL-IN a-nro_comprob IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN a-nro_vencimiento IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN a-prf_comprob IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN a-tip_comprob IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN T-Opg_header.ano IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR BUTTON btn_anular IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR BUTTON btn_cancel IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR BUTTON btn_grabar IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR BUTTON btn_imprim IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR BUTTON btn_leyenda IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR BUTTON btn_nominar IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR BUTTON btn_observ IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR BUTTON btn_valores IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR RADIO-SET T-Opg_header.calcular_cambio IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN T-Opg_header.cambio IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN T-Opg_header.cambio_dolar IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN T-Opg_header.fch_cambio IN FRAME DEFAULT-FRAME
   NO-ENABLE EXP-LABEL EXP-FORMAT                                       */
/* SETTINGS FOR FILL-IN T-Opg_header.fecha IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN T-Opg_header.imp_bruto IN FRAME DEFAULT-FRAME
   NO-ENABLE EXP-LABEL EXP-FORMAT                                       */
/* SETTINGS FOR FILL-IN T-Opg_header.imp_difcambio IN FRAME DEFAULT-FRAME
   NO-ENABLE EXP-LABEL                                                  */
/* SETTINGS FOR FILL-IN T-Opg_header.imp_pesos IN FRAME DEFAULT-FRAME
   NO-ENABLE EXP-LABEL EXP-FORMAT                                       */
/* SETTINGS FOR FILL-IN T-Opg_header.imp_total IN FRAME DEFAULT-FRAME
   NO-ENABLE EXP-LABEL EXP-FORMAT                                       */
/* SETTINGS FOR FILL-IN T-Opg_header.mes IN FRAME DEFAULT-FRAME
   NO-ENABLE EXP-LABEL                                                  */
/* SETTINGS FOR FILL-IN T-Opg_header.nro_comprob IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN T-Opg_header.prf_comprob IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR RADIO-SET T-Opg_header.tipo_pago IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN T-Opg_header.tip_comprob IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN v-abv_provincia IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN v-anulado IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN v-cdg_condicion_impos IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN v-cdg_domicilio IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN v-cdg_imputacion IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN v-cdg_moneda IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN v-cdg_proveedor IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN v-dsc_condicion_impos IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN v-dsc_domicilio IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN v-dsc_imputacion IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN v-dsc_moneda IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN v-dsc_proveedor IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(C-Win)
THEN C-Win:HIDDEN = no.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME


/* Setting information for Queries and Browse Widgets fields            */

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE BROWSE-6
/* Query rebuild information for BROWSE BROWSE-6
     _TblList          = "Temp-Tables.T-Opg_detalle OF Temp-Tables.T-Opg_header,Moneda_detalle OF Temp-Tables.T-Opg_detalle"
     _Options          = "NO-LOCK INDEXED-REPOSITION"
     _FldNameList[1]   = Temp-Tables.T-Opg_detalle.tip_cancela
     _FldNameList[2]   = Temp-Tables.T-Opg_detalle.prf_cancela
     _FldNameList[3]   = Temp-Tables.T-Opg_detalle.nro_cancela
     _FldNameList[4]   = Temp-Tables.T-Opg_detalle.nro_vencimiento
     _FldNameList[5]   = Temp-Tables.Moneda_detalle.abrevia
     _FldNameList[6]   = Temp-Tables.T-Opg_detalle.importe
     _FldNameList[7]   = Temp-Tables.T-Opg_detalle.imp_pesos
     _FldNameList[8]   = Temp-Tables.T-Opg_detalle.cambio
     _FldNameList[9]   = Temp-Tables.T-Opg_detalle.new_cambio
     _FldNameList[10]   = Temp-Tables.T-Opg_detalle.difcambio
     _FldNameList[11]   = Temp-Tables.T-Opg_detalle.clausula_dolar
     _FldNameList[12]   = Temp-Tables.T-Opg_detalle.prc_difcambio
     _FldNameList[13]   = Temp-Tables.T-Opg_detalle.prc_mincambio
     _FldNameList[14]   > Temp-Tables.T-Opg_detalle.leyenda
"T-Opg_detalle.leyenda" ? ? "character" ? ? ? ? ? ? no ? no no "15.2" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _Query            is OPENED
*/  /* BROWSE BROWSE-6 */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE BRW-TOTALES
/* Query rebuild information for BROWSE BRW-TOTALES
     _TblList          = "Temp-Tables.T-Totales_opago OF Temp-Tables.T-Opg_header,Moneda_totales OF Temp-Tables.T-Opg_header"
     _Options          = "NO-LOCK INDEXED-REPOSITION"
     _FldNameList[1]   = Temp-Tables.Moneda_totales.descripcion
     _FldNameList[2]   = Temp-Tables.T-Totales_opago.imp_total
     _FldNameList[3]   = Temp-Tables.T-Totales_opago.imp_difcambio
     _FldNameList[4]   = Temp-Tables.T-Totales_opago.imp_pesos
     _Query            is OPENED
*/  /* BROWSE BRW-TOTALES */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _QUERY-BLOCK FRAME DEFAULT-FRAME
/* Query rebuild information for FRAME DEFAULT-FRAME
     _TblList          = "Temp-Tables.T-Opg_header"
     _Query            is OPENED
*/  /* FRAME DEFAULT-FRAME */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME C-Win
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON END-ERROR OF C-Win /* Ordenes de Pago a Proveedores */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON WINDOW-CLOSE OF C-Win /* Ordenes de Pago a Proveedores */
DO:
  /* This event will close the window and terminate the procedure.  */
  /* APPLY "CLOSE":U TO THIS-PROCEDURE. */
  APPLY "CHOOSE":U TO Btn_salir IN FRAME {&FRAME-NAME}.
  RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME a-nro_comprob
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL a-nro_comprob C-Win
ON MOUSE-SELECT-DBLCLICK OF a-nro_comprob IN FRAME DEFAULT-FRAME
OR MOUSE-MENU-DOWN,"." OF a-nro_comprob IN FRAME {&FRAME-NAME}
DO:
  APPLY "MOUSE-SELECT-DBLCLICK" TO a-nro_vencimiento IN FRAME {&FRAME-NAME}.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME a-nro_vencimiento
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL a-nro_vencimiento C-Win
ON MOUSE-SELECT-DBLCLICK OF a-nro_vencimiento IN FRAME DEFAULT-FRAME
OR MOUSE-MENU-DOWN,"." OF a-nro_vencimiento IN FRAME {&FRAME-NAME}
DO:
  RUN d-selctacteprv.w ( INPUT ROWID(Proveedor), 
                         INPUT ?,
                         INPUT st_seleccionado,
                         INPUT-OUTPUT TABLE T-Cta_cte_prv ).

  FOR EACH T-Cta_cte_prv OF Proveedor WHERE T-Cta_cte_prv.user-id-sel = st_seleccionado
      BY T-Cta_cte_prv.fecha_emision:

     DISPLAY T-Cta_cte_prv.tip_comprob     @ a-tip_comprob
             T-Cta_cte_prv.prf_comprob     @ a-prf_comprob     
             T-Cta_cte_prv.nro_comprob     @ a-nro_comprob
             T-Cta_cte_prv.nro_vencimiento @ a-nro_vencimiento 
             WITH FRAME {&FRAME-NAME}.

     APPLY "RETURN" TO a-nro_vencimiento IN FRAME {&FRAME-NAME}.

  END.
  RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL a-nro_vencimiento C-Win
ON RETURN OF a-nro_vencimiento IN FRAME DEFAULT-FRAME
OR TAB OF a-nro_vencimiento  IN FRAME {&FRAME-NAME}
DO:

   ASSIGN FRAME {&FRAME-NAME}
         a-tip_comprob 
         a-prf_comprob
         a-nro_comprob
         a-nro_vencimiento.

   FIND T-Cta_cte_prv WHERE T-Cta_cte_prv.nro_proveedor     = T-Opg_header.nro_proveedor 
                  AND T-Cta_cte_prv.cdg_empresa     = T-Opg_header.cdg_empresa
                  AND T-Cta_cte_prv.tip_comprob     = a-tip_comprob 
                  AND T-Cta_cte_prv.prf_comprob     = a-prf_comprob
                  AND T-Cta_cte_prv.nro_comprob     = a-nro_comprob
                  AND T-Cta_cte_prv.nro_vencimiento = a-nro_vencimiento
                      EXCLUSIVE-LOCK NO-ERROR.

   IF NOT AVAILABLE T-Cta_cte_prv
   THEN DO:
      IF LOCKED T-Cta_cte_prv
      THEN DO:
         RUN PONMENSJ.P (INPUT "RECB006").
         RETURN NO-APPLY.
      END.
      ELSE DO:
         RUN PONMENSJ.P (INPUT "RECB001").
         RETURN NO-APPLY.
      END.
   END.

   IF CAN-DO(str_debitan,"FA,FB,FC,FE,DA,DB,DC,DE,CA,CB,CC,CE,RA,RB,RC,RE")
   THEN DO:
      RUN PONMENSJ.P (INPUT "RECB017").
      RETURN NO-APPLY.
   END.

   IF T-Cta_cte_prv.nro_proveedor <> Proveedor.nro_proveedor
   THEN DO:
      RUN PONMENSJ.P (INPUT "RECB002").
      RETURN NO-APPLY.
   END.

   IF T-Cta_cte_prv.credito = T-Cta_cte_prv.debito
   THEN DO:
      RUN PONMENSJ.P (INPUT "RECB003").
      RETURN NO-APPLY.
   END.

   IF CAN-FIND(FIRST T-Opg_detalle OF T-Opg_header
                     WHERE T-Opg_detalle.tip_cancela     = T-Cta_cte_prv.tip_comprob
                       AND T-Opg_detalle.prf_cancela     = T-Cta_cte_prv.prf_comprob
                       AND T-Opg_detalle.nro_cancela     = T-Cta_cte_prv.nro_comprob
                       AND T-Opg_detalle.nro_vencimiento = T-Cta_cte_prv.nro_vencimiento)
   THEN DO:
      RUN PONMENSJ.P (INPUT "RECB004").
      RETURN NO-APPLY.
   END.

   IF T-Cta_cte_prv.imputado
   THEN DO:
      RUN PONMENSJ.P (INPUT "RECB005").
      RETURN NO-APPLY.
   END.
   
   T-Cta_cte_prv.imputado = YES.
   T-Cta_cte_prv.selectado = NO.   
   T-Cta_cte_prv.user-id-sel = "".   

   RUN crear_detalle.
   
   {&OPEN-QUERY-{&BROWSE-NAME}}
   
   DISPLAY " " @ a-tip_comprob
           " " @ a-prf_comprob
           " " @ a-nro_comprob
           " " @ a-nro_vencimiento
           WITH FRAME {&FRAME-NAME}.
   APPLY "ENTRY" TO a-tip_comprob  IN FRAME {&FRAME-NAME}.
   RETURN NO-APPLY.
      
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME a-prf_comprob
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL a-prf_comprob C-Win
ON MOUSE-SELECT-DBLCLICK OF a-prf_comprob IN FRAME DEFAULT-FRAME
OR MOUSE-MENU-DOWN,"." OF a-prf_comprob IN FRAME {&FRAME-NAME}
DO:
  APPLY "MOUSE-SELECT-DBLCLICK" TO a-nro_vencimiento IN FRAME  {&FRAME-NAME}.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME a-tip_comprob
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL a-tip_comprob C-Win
ON MOUSE-SELECT-DBLCLICK OF a-tip_comprob IN FRAME DEFAULT-FRAME /* Aplicación */
OR MOUSE-MENU-DOWN,"." OF a-tip_comprob IN FRAME {&FRAME-NAME}
DO:
  APPLY "MOUSE-SELECT-DBLCLICK" TO a-nro_vencimiento IN FRAME  {&FRAME-NAME}.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define BROWSE-NAME BROWSE-6
&Scoped-define SELF-NAME BROWSE-6
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL BROWSE-6 C-Win
ON DELETE-CHARACTER OF BROWSE-6 IN FRAME DEFAULT-FRAME /* Comprobantes cancelados con la presente O/Pago */
DO:
    IF modo = MD_ALTA
    THEN DO:
         sino-msg = NO.
         MESSAGE "Desea eliminar este renglón de detalle?" 
                 VIEW-AS ALERT-BOX QUESTION BUTTONS YES-NO TITLE "Confirmación" UPDATE sino-msg.
         IF sino-msg
         THEN DO:
              DELETE T-Opg_detalle.
              {&OPEN-QUERY-{&BROWSE-NAME}}
              RUN calculos.
         END.
    END.  
    ELSE DO:
         BELL.
    END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL BROWSE-6 C-Win
ON MOUSE-SELECT-DBLCLICK OF BROWSE-6 IN FRAME DEFAULT-FRAME /* Comprobantes cancelados con la presente O/Pago */
OR RETURN OF {&BROWSE-NAME} IN FRAME {&FRAME-NAME}
DO:
    RUN corregir_detalle.
    {&OPEN-QUERY-{&BROWSE-NAME}}
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btn_anular
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btn_anular C-Win
ON CHOOSE OF btn_anular IN FRAME DEFAULT-FRAME /* Anular */
DO:

    DEFINE VARIABLE pudo_anular AS INTEGER.
    sino-msg = NO.
    RUN mensajepregunta.p ( INPUT "esta O/Pago",INPUT "PREG005", INPUT-OUTPUT sino-msg ). 
    IF sino-msg
    THEN DO:
         RUN anular_opago.p (INPUT ROWID(Opg_header), OUTPUT pudo_anular).
         IF pudo_anular = 0
         THEN DO:
              RUN borrar_tablas_temporales.
              MESSAGE "La O/Pago ha sido anulada" 
                      VIEW-AS ALERT-BOX MESSAGE TITLE "Aviso".
              
         END.
        &IF DEFINED (adm-panel) <> 0 &THEN
            RUN dispatch IN THIS-PROCEDURE ('exit').
        &ELSE
/*          APPLY "CLOSE":U TO THIS-PROCEDURE.*/
            ASSIGN codigo_salir = CD_GRABAR.
            APPLY "U1":U TO THIS-PROCEDURE.

        &ENDIF

    END.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btn_cancel
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btn_cancel C-Win
ON CHOOSE OF btn_cancel IN FRAME DEFAULT-FRAME /* Cancelar */
DO:
    sino-msg = NO.
    RUN mensajepregunta.p ( INPUT "",INPUT "PREG002", INPUT-OUTPUT sino-msg ). 
    IF sino-msg
    THEN DO:

        RUN desmarcar_todos.
        RUN borrar_tablas_temporales.

        ASSIGN codigo_salir = CD_CANCELAR.
        APPLY "U1" TO THIS-PROCEDURE.

    END.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btn_grabar
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btn_grabar C-Win
ON CHOOSE OF btn_grabar IN FRAME DEFAULT-FRAME /* Grabar */
DO:

  ASSIGN FRAME {&FRAME-NAME}
         T-Opg_header.nro_comprob 
         T-Opg_header.prf_comprob 
         T-Opg_header.tip_comprob
         T-Opg_header.ano 
         T-Opg_header.fecha 
         T-Opg_header.mes 
         T-Opg_header.tipo_pago
         T-Opg_header.cambio
         T-Opg_header.imp_total
         T-Opg_header.calcular_cambio.

  RUN validar_datos ( OUTPUT hay_error).
  IF NOT hay_error
  THEN DO:

       IF NOT T-Opg_header.anulado /* No es una anulación */
       THEN DO:
           
            IF NOT AVAILABLE T-Caj_header
            THEN DO:
                 RUN crear_caja.
            END.
            ELSE DO:
                 RUN asignar_caja.
            END.   

            RUN calcular_retenciones.p ( INPUT-OUTPUT TABLE T-Opg_header,      
                                         INPUT-OUTPUT TABLE T-Opg_detalle,     
                                         INPUT-OUTPUT TABLE T-Caj_header,      
                                         INPUT-OUTPUT TABLE T-Caj_detalle,
                                         INPUT-OUTPUT TABLE T-Pagos_x_actividad,
                                         INPUT-OUTPUT TABLE T-Pagos_x_actividad_det,
                                         INPUT-OUTPUT TABLE T-Pagos_x_retiva,
                                         INPUT-OUTPUT TABLE T-Pagos_x_retiva_det,
                                         INPUT-OUTPUT TABLE T-Pagos_x_retibr,     
                                         INPUT-OUTPUT TABLE T-Pagos_x_retibr_det,     
                                         INPUT-OUTPUT TABLE T-Pagos_x_retsus,     
                                         INPUT-OUTPUT TABLE T-Pagos_x_retsus_det,
                                         INPUT-OUTPUT TABLE T-Certificado_gan,
                                         INPUT-OUTPUT TABLE T-Cert_gan-detalle,
                                         INPUT-OUTPUT TABLE T-Certificado_iva,     
                                         INPUT-OUTPUT TABLE T-Cert_iva-detalle, 
                                         INPUT-OUTPUT TABLE T-Certificado_ibr,     
                                         INPUT-OUTPUT TABLE T-Cert_ibr-detalle, 
                                         INPUT-OUTPUT TABLE T-Certificado_sus,     
                                         INPUT-OUTPUT TABLE T-Cert_sus-detalle 
                                       ).          
            FIND FIRST T-Caj_header.
            FIND FIRST T-Opg_header.
            {&OPEN-QUERY-{&BROWSE-NAME}}

            FIND FIRST Proveedor_Rubro OF Proveedor 
                WHERE Proveedor_Rubro.preferido 
                  AND Proveedor_Rubro.cdg_empresa = T-Opg_header.cdg_empresa
                      NO-ERROR.

            IF AVAILABLE Proveedor_Rubro
            THEN DO:
                IF NOT CAN-FIND(FIRST T-Caj_detalle WHERE T-Caj_detalle.cdg_rubro = Proveedor_rubro.cdg_rubro)
                THEN DO:
                    CREATE T-Caj_detalle.
                    ASSIGN T-Caj_header.ultima_linea        = T-Caj_header.ultima_linea + 1
                           T-Caj_detalle.cdg_cuenta_ban     = Proveedor_Rubro.cdg_cuenta_ban
                           T-Caj_detalle.cdg_rubro          = Proveedor_Rubro.cdg_rubro
                           T-Caj_detalle.importe            = T-Caj_header.importe  - T-Caj_header.ingreso
                           T-Caj_detalle.nro_linea          = T-Caj_header.ultima_linea
                           T-Caj_detalle.nro_transaccion    = T-Caj_header.nro_transaccion
                           T-Caj_detalle.tipo_mov           = "E"
                           T-Caj_header.ingreso             = T-Caj_header.importe.
                END.
            END.
            
            T-Caj_header.cdg_circuito = "Z".
            RUN d-valores_movimiento.w ( INPUT-OUTPUT TABLE T-Caj_header,
                                         INPUT-OUTPUT TABLE T-Caj_detalle,
                                         INPUT-OUTPUT TABLE T-Caja-imputacion,
                                         INPUT-OUTPUT TABLE T-Cheque,
                                         INPUT-OUTPUT TABLE T-Valor,
                                         INPUT 0).

            FIND FIRST T-Caj_header EXCLUSIVE-LOCK.
            IF T-Caj_header.importe <> T-Caj_header.ingreso THEN RETURN NO-APPLY.
       END.
     
       RUN grabar_datos.

       ASSIGN codigo_salir = CD_GRABAR.
       APPLY "U1" TO THIS-PROCEDURE.
  
  END.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btn_imprim
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btn_imprim C-Win
ON CHOOSE OF btn_imprim IN FRAME DEFAULT-FRAME /* Reimprimir */
DO:
    sino-msg = NO.
    MESSAGE "Desea REIMPRIMIR esta Orden de Pago?" 
            VIEW-AS ALERT-BOX QUESTION BUTTONS YES-NO TITLE "Confirmación" UPDATE sino-msg.
    IF sino-msg
    THEN DO:
         RUN imprimir_opago.p (ROWID(Opg_header)).
    END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btn_leyenda
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btn_leyenda C-Win
ON CHOOSE OF btn_leyenda IN FRAME DEFAULT-FRAME /* Leyenda */
DO:

   DEFINE VARIABLE puso_ok AS LOGICAL.
   RUN c-edttexto.w ( INPUT-OUTPUT T-Opg_header.leyenda,
                      INPUT "Leyenda del Recibo",
                      INPUT modo,
                      OUTPUT puso_ok).
   RETURN NO-APPLY.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btn_nominar
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btn_nominar C-Win
ON CHOOSE OF btn_nominar IN FRAME DEFAULT-FRAME /* Nominar */
DO:
  RUN d-nominar_opago.w ( INPUT modo, INPUT 1, INPUT-OUTPUT TABLE T-Opg_header).
  FIND FIRST T-Opg_header.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btn_observ
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btn_observ C-Win
ON CHOOSE OF btn_observ IN FRAME DEFAULT-FRAME /* Observación */
DO:

   DEFINE VARIABLE puso_ok AS LOGICAL.
   RUN c-edttexto.w ( INPUT-OUTPUT T-Opg_header.observacion,
                      INPUT "Observaciones del Recibo",
                      INPUT modo,
                      OUTPUT puso_ok).
   RETURN NO-APPLY.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME Btn_salir
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Btn_salir C-Win
ON CHOOSE OF Btn_salir IN FRAME DEFAULT-FRAME /* Salir */
DO:

    sino-msg = NO.
    RUN mensajepregunta.p ( INPUT "",INPUT "PREG001", INPUT-OUTPUT sino-msg ). 
    IF sino-msg
    THEN DO:
         RUN desmarcar_todos.
        &IF DEFINED (adm-panel) <> 0 &THEN
            RUN dispatch IN THIS-PROCEDURE ('exit').
        &ELSE
/*          APPLY "CLOSE":U TO THIS-PROCEDURE.*/
            ASSIGN codigo_salir = CD_SALIR.
            APPLY "U1":U TO THIS-PROCEDURE.

        &ENDIF

    END.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btn_valores
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btn_valores C-Win
ON CHOOSE OF btn_valores IN FRAME DEFAULT-FRAME /* Ver Caja */
DO:
    RUN d-valores_movimiento.w ( INPUT-OUTPUT TABLE T-Caj_header,
                                 INPUT-OUTPUT TABLE T-Caj_detalle,
                                 INPUT-OUTPUT TABLE T-Caja-imputacion,
                                 INPUT-OUTPUT TABLE T-Cheque,
                                 INPUT-OUTPUT TABLE T-Valor,
                                 INPUT 2).
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME T-Opg_header.calcular_cambio
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL T-Opg_header.calcular_cambio C-Win
ON VALUE-CHANGED OF T-Opg_header.calcular_cambio IN FRAME DEFAULT-FRAME
DO:
  ASSIGN FRAME {&FRAME-NAME} T-Opg_header.calcular_cambio.
  RUN calculos.
  {&OPEN-QUERY-{&BROWSE-NAME}}
  RUN abre_query_totales.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME T-Opg_header.cambio
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL T-Opg_header.cambio C-Win
ON LEAVE OF T-Opg_header.cambio IN FRAME DEFAULT-FRAME /* cambio */
DO:
  ASSIGN FRAME {&FRAME-NAME} T-Opg_header.cambio.
  RUN calculos.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME T-Opg_header.fch_cambio
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL T-Opg_header.fch_cambio C-Win
ON LEAVE OF T-Opg_header.fch_cambio IN FRAME DEFAULT-FRAME /* Cambio Al */
DO:
    ASSIGN T-Opg_header.fch_cambio.
    RUN asignar_cambio.
    RUN calculos.  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL T-Opg_header.fch_cambio C-Win
ON MOUSE-MENU-DOWN OF T-Opg_header.fch_cambio IN FRAME DEFAULT-FRAME /* Cambio Al */
DO:
    fecha_inicial = DATE(T-Opg_header.fch_cambio:SCREEN-VALUE IN FRAME {&FRAME-NAME}) NO-ERROR.
    IF fecha_inicial = ? THEN fecha_inicial = TODAY.
    RUN d-calendario.w ( INPUT fecha_inicial, OUTPUT fecha_elegida).
    IF fecha_elegida <> ?
    THEN DO:
         DISPLAY fecha_elegida @ T-Opg_header.fch_cambio 
                 WITH FRAME {&FRAME-NAME}.
         APPLY "TAB" TO SELF.        
    END.               
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME T-Opg_header.fecha
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL T-Opg_header.fecha C-Win
ON LEAVE OF T-Opg_header.fecha IN FRAME DEFAULT-FRAME /* Fecha */
DO:
  ASSIGN T-Opg_header.fecha.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL T-Opg_header.fecha C-Win
ON MOUSE-MENU-DOWN OF T-Opg_header.fecha IN FRAME DEFAULT-FRAME /* Fecha */
DO:
    fecha_inicial = DATE(T-Opg_header.fecha:SCREEN-VALUE IN FRAME {&FRAME-NAME}) NO-ERROR.
    IF fecha_inicial = ? THEN fecha_inicial = TODAY.
    RUN d-calendario.w ( INPUT fecha_inicial, OUTPUT fecha_elegida).
    IF fecha_elegida <> ?
    THEN DO:
         DISPLAY fecha_elegida @ T-Opg_header.fecha 
                 WITH FRAME {&FRAME-NAME}.
         APPLY "TAB" TO SELF.        
    END.               
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME T-Opg_header.imp_total
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL T-Opg_header.imp_total C-Win
ON LEAVE OF T-Opg_header.imp_total IN FRAME DEFAULT-FRAME /* Pagado */
DO:
  ASSIGN FRAME {&FRAME-NAME} T-Opg_header.imp_total.
  RUN calculos.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME T-Opg_header.nro_comprob
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL T-Opg_header.nro_comprob C-Win
ON + OF T-Opg_header.nro_comprob IN FRAME DEFAULT-FRAME /* nro_comprob */
DO:
    FIND LAST PX-Opg_header 
        WHERE PX-Opg_header.cdg_empresa = T-Opg_header.cdg_empresa 
          AND PX-Opg_header.tip_comprob = T-Opg_header.tip_comprob:INPUT-VALUE 
          AND PX-Opg_header.prf_comprob = T-Opg_header.prf_comprob:INPUT-VALUE.

    DISPLAY PX-Opg_header.nro_comprob + 1 @ T-Opg_header.nro_comprob
        WITH FRAME {&FRAME-NAME}.  

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL T-Opg_header.nro_comprob C-Win
ON MOUSE-SELECT-DBLCLICK OF T-Opg_header.nro_comprob IN FRAME DEFAULT-FRAME /* nro_comprob */
OR MOUSE-MENU-DOWN,"." OF T-Opg_header.nro_comprob IN FRAME {&FRAME-NAME}
DO:
  IF modo <> MD_ALTA
  THEN DO:
    DEFINE VARIABLE lista_estados AS CHARACTER.
    DEFINE VARIABLE titulo_window AS CHARACTER.
  
    CASE modo:
       WHEN MD_ALTA          
       THEN DO:
            titulo_window = "".     /* Esta opcion la contemplamos por unicidad pero no debería producirse nunca */
            lista_estados = "".
       END.
       WHEN MD_MULTIPLE      
       THEN DO:
            titulo_window = "Selección de Ordenes de Pago".
            lista_estados = " ,E".
       END.
       WHEN MD_DEFINIDA             /* Esta opcion la contemplamos por unicidad pero no debería producirse nunca */
       THEN DO:
            titulo_window = "".
            lista_estados = "".
       END.
       WHEN MD_RELACION             /* Esta opcion la contemplamos por unicidad pero no debería producirse nunca */
       THEN DO:
            titulo_window = "".
            lista_estados = "".
       END.
       WHEN MD_READONLY      
       THEN DO:
            titulo_window = "Selección Ordenes de Pago".
            lista_estados = " ,E".
       END.
       WHEN MD_CAMBIO        
       THEN DO:
            titulo_window = "".
            lista_estados = "".
       END.
       WHEN MD_ANULACION        
       THEN DO:
            titulo_window = "Selección de Ordenes de Pago".
            lista_estados = "E".
       END.
       WHEN MD_EMISION        
       THEN DO:
            titulo_window = "Selección de Ordenes de Pago".
            lista_estados = "".
       END.
    END CASE.     
  
    RUN d-seleccionar_opago.w (INPUT titulo_window, INPUT lista_estados, INPUT "R*", INPUT-OUTPUT rid_opago).
    IF rid_opago <> ?
    THEN DO:
       FIND Opg_header WHERE ROWID(Opg_header) = rid_opago NO-LOCK.
       DISPLAY Opg_header.tip_comprob @ T-Opg_header.tip_comprob 
               Opg_header.prf_comprob @ T-Opg_header.prf_comprob
               Opg_header.nro_comprob @ T-Opg_header.nro_comprob
               WITH FRAME {&FRAME-NAME}.
       IF modo = MD_ANULACION AND Opg_header.anulado
       THEN DO:
            RUN PONMENSJ.P (INPUT "DOCS002").
            RETURN NO-APPLY.
       END.
       ELSE DO:
            RUN traer_documento.
       END.
    END.  
    RETURN NO-APPLY.  
  END.
  ELSE DO:
    BELL.
    RETURN NO-APPLY.
  END.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL T-Opg_header.nro_comprob C-Win
ON RETURN OF T-Opg_header.nro_comprob IN FRAME DEFAULT-FRAME /* nro_comprob */
DO:

  IF modo <> MD_ALTA
  THEN DO:
    IF LOOKUP(INPUT FRAME {&FRAME-NAME} T-Opg_header.tip_comprob,"DA,DB,DC,DE") <> 0 
    THEN DO:
       RUN PONMENSJ.P (INPUT "DOCS010").
       RETURN NO-APPLY.
    END.
 
    FIND Opg_header 
         WHERE Opg_header.cdg_empresa = Empresa.cdg_empresa
           AND Opg_header.tip_comprob = INPUT T-Opg_header.tip_comprob 
           AND Opg_header.prf_comprob = INPUT T-Opg_header.prf_comprob
           AND Opg_header.nro_comprob = INPUT T-Opg_header.nro_comprob
               NO-ERROR.
 
    IF NOT AVAILABLE Opg_header 
    THEN DO:
         IF LOCKED Opg_header
            THEN RUN PONMENSJ.P (INPUT "DOCS000").
            ELSE RUN PONMENSJ.P (INPUT "DOCS001").
         RETURN NO-APPLY.
    END.
    ELSE DO:
         IF modo = MD_ANULACION AND Opg_header.anulado
         THEN DO:
              RUN PONMENSJ.P (INPUT "DOCS002").
              RETURN NO-APPLY.
         END.
         ELSE DO:
             rid_opago = ROWID(Opg_header).
             RUN traer_documento.
         END.
    END.
  END.
  ELSE DO:
    BELL.
    RETURN NO-APPLY.
  END.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME T-Opg_header.prf_comprob
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL T-Opg_header.prf_comprob C-Win
ON MOUSE-SELECT-DBLCLICK OF T-Opg_header.prf_comprob IN FRAME DEFAULT-FRAME /* prf_comprob */
OR MOUSE-MENU-DOWN,"." OF T-Opg_header.prf_comprob IN FRAME {&FRAME-NAME}
DO:
  APPLY "MOUSE-SELECT-DBLCLICK" TO T-Opg_header.tip_comprob IN FRAME {&FRAME-NAME}.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME T-Opg_header.tipo_pago
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL T-Opg_header.tipo_pago C-Win
ON VALUE-CHANGED OF T-Opg_header.tipo_pago IN FRAME DEFAULT-FRAME
DO:
  ASSIGN FRAME {&FRAME-NAME} T-Opg_header.tipo_pago.
  IF T-Opg_header.tipo_pago = 1
     THEN RUN color_ctacte.
     ELSE RUN color_total.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME T-Opg_header.tip_comprob
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL T-Opg_header.tip_comprob C-Win
ON LEAVE OF T-Opg_header.tip_comprob IN FRAME DEFAULT-FRAME /* Tipo */
DO:
  SELF:SCREEN-VALUE = CAPS(SELF:SCREEN-VALUE).
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL T-Opg_header.tip_comprob C-Win
ON MOUSE-SELECT-DBLCLICK OF T-Opg_header.tip_comprob IN FRAME DEFAULT-FRAME /* Tipo */
OR MOUSE-MENU-DOWN,"." OF T-Opg_header.tip_comprob IN FRAME {&FRAME-NAME}
DO:
  APPLY "MOUSE-SELECT-DBLCLICK" TO T-Opg_header.tip_comprob IN FRAME {&FRAME-NAME}.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME v-cdg_condicion_impos
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-cdg_condicion_impos C-Win
ON MOUSE-SELECT-DBLCLICK OF v-cdg_condicion_impos IN FRAME DEFAULT-FRAME /* C.Iva. */
OR "." OF v-cdg_condicion_impos IN FRAME {&FRAME-NAME}
OR MOUSE-MENU-DOWN OF v-cdg_condicion_impos IN FRAME {&FRAME-NAME}
DO:

   {helptabla.i "condicion_impos" "cdg_condiva" "SELCNDIV.P"}
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-cdg_condicion_impos C-Win
ON RETURN OF v-cdg_condicion_impos IN FRAME DEFAULT-FRAME /* C.Iva. */
DO:
   {traducetabla.i "condicion_impos" "cdg_condiva" "descripcion"} 
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME v-cdg_domicilio
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-cdg_domicilio C-Win
ON MOUSE-MENU-DOWN OF v-cdg_domicilio IN FRAME DEFAULT-FRAME /* Domicilio */
DO:
  DEFINE VARIABLE x-domicilio LIKE Domicilio_prv.nro_domicilio.
  RUN d-seldomicilio_proveedor.w ( INPUT ROWID(Proveedor) , OUTPUT x-domicilio).
  IF x-domicilio <> ?
  THEN DO:
       DISPLAY x-domicilio @ v-cdg_domicilio
               WITH FRAME {&FRAME-NAME}.
       APPLY "RETURN" TO v-cdg_domicilio IN FRAME {&FRAME-NAME}.
  END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-cdg_domicilio C-Win
ON RETURN OF v-cdg_domicilio IN FRAME DEFAULT-FRAME /* Domicilio */
DO:
  FIND Domicilio_prv OF Proveedor WHERE Domicilio_prv.nro_domicilio = INPUT FRAME {&FRAME-NAME} v-cdg_domicilio NO-ERROR.
  IF AVAILABLE Domicilio_prv
  THEN DO:
      FIND Provincia OF Domicilio_prv NO-LOCK.
      ASSIGN  T-Opg_header.nro_domicilio = Domicilio_prv.nro_domicilio
              T-Opg_header.direccion     = Domicilio_prv.direccion
              T-Opg_header.cdg_provincia = Domicilio_prv.cdg_provincia
              T-Opg_header.localidad     = Domicilio_prv.localidad
              T-Opg_header.cdg_postal    = Domicilio_prv.cdg_postal
              T-Opg_header.cdg_zonag     = Domicilio_prv.cdg_zonag
              v-cdg_domicilio            = Domicilio_prv.nro_domicilio
              v-dsc_domicilio            = Domicilio_prv.nombre
              v-abv_provincia            = Provincia.nombre.
      DISPLAY v-cdg_domicilio 
              v-dsc_domicilio
              v-abv_provincia
              WITH FRAME {&FRAME-NAME}.  
      RUN calculos.
  END.
  ELSE DO:
      RUN PONMENSJ.P (INPUT "FACT006").
      RETURN NO-APPLY.
  END.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME v-cdg_imputacion
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-cdg_imputacion C-Win
ON MOUSE-SELECT-DBLCLICK OF v-cdg_imputacion IN FRAME DEFAULT-FRAME /* Imputación */
OR "." OF v-cdg_imputacion IN FRAME {&FRAME-NAME}
OR MOUSE-MENU-DOWN OF v-cdg_imputacion IN FRAME {&FRAME-NAME}
DO:

   {helptabla.i "imputacion" "cdg_imputacion" "SELCNDOC.P"}
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-cdg_imputacion C-Win
ON RETURN OF v-cdg_imputacion IN FRAME DEFAULT-FRAME /* Imputación */
DO:
   &SCOPED-DEFINE PONER-TABLA RUN asignar_imputacion.
   
   {traducetabla.i "imputacion" "cdg_imputacion" "dsc_imputacion"} 
  
   &UNDEFINE PONER-TABLA
   
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME v-cdg_moneda
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-cdg_moneda C-Win
ON MOUSE-SELECT-DBLCLICK OF v-cdg_moneda IN FRAME DEFAULT-FRAME /* Moneda */
OR "." OF v-cdg_moneda IN FRAME {&FRAME-NAME}
OR MOUSE-MENU-DOWN OF v-cdg_moneda IN FRAME {&FRAME-NAME}
DO:

   {helptabla.i "Moneda" "cdg_moneda" "SELMONED.P"}
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-cdg_moneda C-Win
ON RETURN OF v-cdg_moneda IN FRAME DEFAULT-FRAME /* Moneda */
DO:
   &SCOPED-DEFINE PONER-TABLA RUN asignar_moneda.
   {traducetabla.i "Moneda" "cdg_moneda" "abrevia"} 
   &UNDEFINE PONER-TABLA

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME v-cdg_proveedor
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-cdg_proveedor C-Win
ON MOUSE-SELECT-DBLCLICK OF v-cdg_proveedor IN FRAME DEFAULT-FRAME /* Proveedor */
OR "." OF v-cdg_proveedor IN FRAME {&FRAME-NAME}
OR MOUSE-MENU-DOWN OF v-cdg_proveedor IN FRAME {&FRAME-NAME}
DO:

   {helptabla.i "proveedor" "cdg_proveedor" "selprove.p"}
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-cdg_proveedor C-Win
ON RETURN OF v-cdg_proveedor IN FRAME DEFAULT-FRAME /* Proveedor */
DO:
/*    &SCOPED-DEFINE PONER-TABLA RUN poner_proveedor.          */
/*    {traducetabla.i "proveedor" "cdg_proveedor" "nombre"} */
/*    &UNDEFINE PONER-TABLA                                  */
/* END.                                                      */

IF v-cdg_proveedor:SCREEN-VALUE IN FRAME {&FRAME-NAME} <> ""
  THEN DO:

        FIND Proveedor 
            WHERE Proveedor.cdg_proveedor = INPUT FRAME {&FRAME-NAME} v-cdg_proveedor NO-LOCK NO-ERROR.
        IF NOT AVAILABLE Proveedor 
        THEN DO:
             RUN PONMENSJ.P ( 'IREF002' ).
             RETURN NO-APPLY.
        END.
        
        v-dsc_proveedor = Proveedor.nombre.
        DISPLAY v-dsc_proveedor 
                WITH FRAME {&FRAME-NAME}. 
        RUN poner_proveedor.    
  END.
  FIND LAST PX-Opg_header 
        WHERE PX-Opg_header.cdg_empresa = T-Opg_header.cdg_empresa 
          AND PX-Opg_header.tip_comprob = T-Opg_header.tip_comprob:INPUT-VALUE 
          AND PX-Opg_header.prf_comprob = T-Opg_header.prf_comprob:INPUT-VALUE.

    DISPLAY PX-Opg_header.nro_comprob + 1 @ T-Opg_header.nro_comprob
        WITH FRAME {&FRAME-NAME}.  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME v-importe
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-importe C-Win
ON LEAVE OF v-importe IN FRAME DEFAULT-FRAME /* Importe */
DO:
  ASSIGN v-importe.
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

{findempresa.i}
{findsector.i}
que_sector = Area.cdg_area.
/* Best default for GUI applications is...                              */
PAUSE 0 BEFORE-HIDE.

/* Now enable the interface and wait for the exit condition.            */
/* (NOTE: handle ERROR and END-KEY so cleanup code will always fire.    */
MAIN-BLOCK:
REPEAT TRANSACTION
       ON ERROR   UNDO MAIN-BLOCK, LEAVE MAIN-BLOCK
       ON END-KEY UNDO MAIN-BLOCK, LEAVE MAIN-BLOCK:

  RUN enable_UI.
  RUN iniciar_documento.
  RUN frame_sensitiva ( INPUT NO ).  
  CLEAR FRAME {&FRAME-NAME} ALL.
  RUN crear_registro.
  IF modo = MD_DEFINIDA
     THEN RUN traer_documento.
     ELSE RUN frame_sensitiva ( INPUT YES ).
  IF modo = MD_ALTA THEN APPLY "ENTRY" TO v-cdg_proveedor.
  WAIT-FOR U1 OF THIS-PROCEDURE.
  CASE codigo_salir:
       WHEN CD_SALIR THEN UNDO,LEAVE.
       WHEN CD_CANCELAR THEN UNDO,RETRY.
       WHEN CD_GRABAR THEN NEXT.
  END CASE.
   
END.
APPLY "CLOSE" TO THIS-PROCEDURE. /* hay que ver si realmente hace falta */

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


/* **********************  Internal Procedures  *********************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE abre_query_totales C-Win 
PROCEDURE abre_query_totales :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

  OPEN QUERY BRW-TOTALES
      FOR EACH T-Totales_opago OF T-Opg_header, FIRST Moneda_totales OF T-Totales_opago NO-LOCK.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE asignar_caja C-Win 
PROCEDURE asignar_caja :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

    BUFFER-COPY T-Opg_header TO T-Caj_header
        ASSIGN T-Caj_header.importe           = T-Opg_header.imp_total
               T-Caj_header.hora              = TIME
               T-Caj_header.emitir            = NO
               T-Caj_header.nro_cuenta        = Familia_proveedor.nro_cuenta
               T-Caj_header.observacion       = Proveedor.cdg_proveedor + 
                                                "-" + Proveedor.nombre
               T-Caj_header.tipo_mov          = "E".

    EMPTY TEMP-TABLE T-Caja-imputacion.
    RUN crear_caja_imputacion.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE asignar_cambio C-Win 
PROCEDURE asignar_cambio :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

  DEFINE VARIABLE p-xx AS DATE . /* Por Compatibilidad */

  RUN cotizar_moneda.p ( INPUT  Moneda.cdg_moneda,
                         INPUT  T-Opg_header.cdg_empresa, 
                         INPUT  T-Opg_header.fch_cambio,       
                         OUTPUT T-Opg_header.cambio,  
                         OUTPUT T-Opg_header.fch_cambio ).

  RUN cotizar_moneda.p ( INPUT  codigo_dolar,
                         INPUT  T-Opg_header.cdg_empresa, 
                         INPUT  T-Opg_header.fecha,       
                         OUTPUT T-Opg_header.cambio_dolar,  
                         OUTPUT p-xx ).


  DISPLAY T-Opg_header.cambio 
          T-Opg_header.cambio_dolar
          T-Opg_header.fch_cambio 
          WITH FRAME {&FRAME-NAME}.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE asignar_condicion C-Win 
PROCEDURE asignar_condicion :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

  v-tip_comprob = "R" + Condicion_impos.tipo_factura.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE asignar_imputacion C-Win 
PROCEDURE asignar_imputacion :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

  T-Opg_header.cdg_imputacion = Imputacion.cdg_imputacion.
  /*
  T-Opg_header.T-Cta_cte_prv        = Imputacion.T-Cta_cte_prv.
  */
  
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE asignar_moneda C-Win 
PROCEDURE asignar_moneda :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
  
  T-Opg_header.nro_moneda = Moneda.nro_moneda.
  T-Opg_header.fch_cambio = T-Opg_header.fecha - 1.
  RUN levantar_cuenta_corriente.
  RUN asignar_cambio.
  RUN calculos.
  
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE borrar_diferencia_cambio C-Win 
PROCEDURE borrar_diferencia_cambio :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
   
   DEFINE VARIABLE p-punto_venta  AS INTEGER.
   DEFINE VARIABLE p-cdg_concepto AS INTEGER.
   DEFINE VARIABLE x-proporcion   AS DECIMAL DECIMALS 6.
   DEFINE VARIABLE x-delta_cambio LIKE Opg_header.cambio.

   EMPTY TEMP-TABLE T-Fac_header_prv.               
   EMPTY TEMP-TABLE T-Fac_detalle_prv.              
   EMPTY TEMP-TABLE T-Sub_header_prv.           
   EMPTY TEMP-TABLE T-Sub_detalle_prv.          
   EMPTY TEMP-TABLE T-Fac_header_prv_impuesto.      
   EMPTY TEMP-TABLE T-Fac_detalle_prv_impuesto.     

   /* Borramos diferencias de cambio que se hubieran generado con cambios anteriores */

   FOR EACH T-Opg_detalle OF T-Opg_header:
       T-Opg_detalle.difcambio = 0.
   END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE borrar_tablas_temporales C-Win 
PROCEDURE borrar_tablas_temporales :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

  EMPTY TEMP-TABLE T-Asn_detalle                  NO-ERROR.
  EMPTY TEMP-TABLE T-Asn_header                   NO-ERROR.
  EMPTY TEMP-TABLE T-Asn_totales                  NO-ERROR.
  EMPTY TEMP-TABLE T-Caja-imputacion              NO-ERROR.
  EMPTY TEMP-TABLE T-Caj_detalle                  NO-ERROR.
  EMPTY TEMP-TABLE T-Caj_header                   NO-ERROR.
  EMPTY TEMP-TABLE T-Certificado_gan              NO-ERROR.
  EMPTY TEMP-TABLE T-Certificado_ibr              NO-ERROR.
  EMPTY TEMP-TABLE T-Certificado_iva              NO-ERROR.
  EMPTY TEMP-TABLE T-Certificado_sus              NO-ERROR.
  EMPTY TEMP-TABLE T-Cert_ibr-detalle             NO-ERROR.
  EMPTY TEMP-TABLE T-Cert_iva-detalle             NO-ERROR.
  EMPTY TEMP-TABLE T-Cert_sus-detalle             NO-ERROR.
  EMPTY TEMP-TABLE T-Cheque                       NO-ERROR.
  EMPTY TEMP-TABLE T-Cta_cte_prv                  NO-ERROR.
  EMPTY TEMP-TABLE T-Fac_detalle_prv              NO-ERROR.
  EMPTY TEMP-TABLE T-Fac_detalle_prv_bon          NO-ERROR.
  EMPTY TEMP-TABLE T-Fac_detalle_prv_impuesto     NO-ERROR.
  EMPTY TEMP-TABLE T-Fac_header_prv               NO-ERROR.
  EMPTY TEMP-TABLE T-Fac_header_prv_bon           NO-ERROR.
  EMPTY TEMP-TABLE T-Fac_header_prv_impuesto      NO-ERROR.
  EMPTY TEMP-TABLE T-Opg_detalle                  NO-ERROR.
  EMPTY TEMP-TABLE T-Opg_header                   NO-ERROR.
  EMPTY TEMP-TABLE T-Pagos_x_actividad            NO-ERROR.
  EMPTY TEMP-TABLE T-Pagos_x_retibr               NO-ERROR.
  EMPTY TEMP-TABLE T-Pagos_x_retibr_det           NO-ERROR.
  EMPTY TEMP-TABLE T-Pagos_x_retiva               NO-ERROR.
  EMPTY TEMP-TABLE T-Pagos_x_retiva_det           NO-ERROR.
  EMPTY TEMP-TABLE T-Pagos_x_retsus               NO-ERROR.
  EMPTY TEMP-TABLE T-Pagos_x_retsus_det           NO-ERROR.
  EMPTY TEMP-TABLE T-Sub_detalle_prv              NO-ERROR.
  EMPTY TEMP-TABLE T-Sub_header_prv               NO-ERROR.
  EMPTY TEMP-TABLE T-Totales_opago                NO-ERROR.
  EMPTY TEMP-TABLE T-Valor                        NO-ERROR.         
                                                  
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE calcular_cambio C-Win 
PROCEDURE calcular_cambio :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
   
   DEFINE VARIABLE p-punto_venta  AS INTEGER.
   DEFINE VARIABLE p-cdg_concepto AS INTEGER.
   DEFINE VARIABLE x-proporcion   AS DECIMAL DECIMALS 6.
   DEFINE VARIABLE x-delta_cambio LIKE Opg_header.cambio.

   EMPTY TEMP-TABLE T-Fac_header_prv.               
   EMPTY TEMP-TABLE T-Fac_detalle_prv.              
   EMPTY TEMP-TABLE T-Sub_header_prv.           
   EMPTY TEMP-TABLE T-Sub_detalle_prv.          
   EMPTY TEMP-TABLE T-Fac_header_prv_impuesto.      
   EMPTY TEMP-TABLE T-Fac_detalle_prv_impuesto.     

   RUN getparametro_n.p (  INPUT  "DFCAMPVT", OUTPUT p-punto_venta ).
   RUN getparametro_n.p (  INPUT  "DFCAMCON", OUTPUT p-cdg_concepto ).

   RUN getparametro.p (  INPUT  "DFCAMCNV",
                         OUTPUT v-valor_c,
                         OUTPUT v-valor_d,
                         OUTPUT v-valor_l,
                         OUTPUT v-valor_n,
                         OUTPUT v-observacion ).

   FIND Condicion_venta WHERE Condicion_venta.cdg_cndventa = v-valor_c NO-LOCK.
   
   RUN getparametro.p (  INPUT  "DFCAMART",
                         OUTPUT v-valor_c,
                         OUTPUT v-valor_d,
                         OUTPUT v-valor_l,
                         OUTPUT v-valor_n,
                         OUTPUT v-observacion ).

   FIND Articulo WHERE Articulo.cdg_articulo = v-valor_c NO-LOCK.

   FIND Domicilio_prv OF T-Opg_header NO-LOCK.
   FIND FIRST Moneda_local WHERE Moneda_local.es_local NO-LOCK.

   RUN getparametro.p (  INPUT  "DFDEPOSI",
                         OUTPUT v-valor_c,
                         OUTPUT v-valor_d,
                         OUTPUT v-valor_l,
                         OUTPUT v-valor_n,
                         OUTPUT v-observacion ).
   FIND Deposito WHERE Deposito.cdg_deposito = v-valor_c NO-LOCK.

   CREATE T-Fac_header_prv.
   BUFFER-COPY T-Opg_header TO T-Fac_header_prv 
        ASSIGN T-Fac_header_prv.origen            = "R"
               T-Fac_header_prv.cdg_comprobante   = v-credito_cambio
               T-Fac_header_prv.estado            = "P"
               T-Fac_header_prv.cta_cte           = YES 
               T-Fac_header_prv.nro_facprov       = 1
               T-Fac_header_prv.fecha             = T-Opg_header.fecha
               T-Fac_header_prv.fecha_iva         = T-Fac_header_prv.fecha
               T-Fac_header_prv.fecha_precios     = T-Fac_header_prv.fecha
               T-Fac_header_prv.cdg_imputacion    = p-cdg_concepto
               T-Fac_header_prv.impreso           = ""
               T-Fac_header_prv.cambio            = 1
               T-Fac_header_prv.nro_cndventa      = Condicion_venta.nro_cndventa
               T-Fac_header_prv.nro_moneda        = Moneda_local.nro_moneda
               T-Fac_header_prv.nombre            = Proveedor.nombre
               T-Fac_header_prv.direccion_leg     = Proveedor.direccion
               T-Fac_header_prv.localidad_leg     = Proveedor.localidad
               T-Fac_header_prv.cdg_postal_leg    = Proveedor.cdg_postal
               T-Fac_header_prv.cdg_provincia_leg = Proveedor.cdg_provincia
               T-Fac_header_prv.cdg_condiva       = Proveedor.cdg_condiva
               T-Fac_header_prv.nombre_domicilio  = Domicilio_prv.nombre
               T-Fac_header_prv.nro_domicilio     = Domicilio_prv.nro_domicilio
               T-Fac_header_prv.direccion         = Domicilio_prv.direccion
               T-Fac_header_prv.cdg_provincia     = Domicilio_prv.cdg_provincia
               T-Fac_header_prv.localidad         = Domicilio_prv.localidad
               T-Fac_header_prv.cdg_postal        = Domicilio_prv.cdg_postal
               T-Fac_header_prv.cdg_zonag         = Domicilio_prv.cdg_zonag
               T-Fac_header_prv.imp_total         = 0
               T-Fac_header_prv.mes               = MONTH(T-Fac_header_prv.fecha) 
               T-Fac_header_prv.ano               = YEAR(T-Fac_header_prv.fecha)
               T-Fac_header_prv.nro_deposito      = Deposito.nro_deposito 
               T-Fac_header_prv.prf_comprob       = p-punto_venta
               T-Fac_header_prv.nro_comprob       = T-Fac_header_prv.nro_facprov.

   /* Borramos diferencias de cambio que se hubieran generado con cambios anteriores */

   FOR EACH T-Opg_detalle OF T-Opg_header, FIRST Moneda_detalle OF T-Opg_detalle NO-LOCK:

       IF Moneda_detalle.es_local
       THEN DO:
           T-Opg_detalle.imp_pesos = T-Opg_detalle.importe.
           IF T-Opg_detalle.clausula_dolar
           THEN DO:     
               ASSIGN T-Opg_detalle.difcambio = ( T-Opg_detalle.new_cambio_dolar - T-Opg_detalle.cambio_dolar ) * 
                                                  T-Opg_detalle.importe / T-Opg_detalle.cambio_dolar * 
                                                  T-Opg_detalle.prc_difcambio / 100.
           END.
           ELSE DO:
               ASSIGN T-Opg_detalle.difcambio = 0.
           END.

       END.
       ELSE DO:

           ASSIGN T-Opg_detalle.imp_pesos = T-Opg_detalle.importe * T-Opg_detalle.cambio
                  T-Opg_detalle.difcambio = ( T-Opg_detalle.new_cambio - T-Opg_detalle.cambio ) * 
                                              T-Opg_detalle.importe * T-Opg_detalle.prc_difcambio / 100.
       END.

       IF ABS(T-Opg_detalle.difcambio / T-Opg_detalle.imp_pesos) >= T-Opg_detalle.prc_mincambio / 100
           THEN T-Fac_header_prv.imp_total = T-Fac_header_prv.imp_total + T-Opg_detalle.difcambio.    
           ELSE T-Opg_detalle.difcambio = 0.    
   END.

   FIND FIRST T-Fac_header_prv NO-ERROR. /* No esta disponible cuando sale del lazo */
   IF AVAILABLE T-Fac_header_prv
   THEN DO:
       IF T-Fac_header_prv.imp_total < 0
       THEN DO:
           ASSIGN
               T-Fac_header_prv.cdg_comprobante = v-debito_cambio
               T-Fac_header_prv.imp_total =  T-Fac_header_prv.imp_total * ( - 1 ).
       END.

       CREATE T-Fac_detalle_prv.
       ASSIGN T-Fac_detalle_prv.nro_facprov  = T-Fac_header_prv.nro_facprov
              T-Fac_detalle_prv.nro_linea    = 1
              T-Fac_detalle_prv.cantidad     = 1
              T-Fac_detalle_prv.granel       = 1
              T-Fac_detalle_prv.nro_articulo = Articulo.nro_articulo
              T-Fac_detalle_prv.detallada    = Articulo.detallada.

       FIND Comprobante_cambio OF T-Fac_header_prv NO-LOCK.
       IF Comprobante_cambio.es_interno
       THEN DO:
           ASSIGN T-Fac_detalle_prv.precio = T-Fac_header_prv.imp_total.
       END.
       ELSE DO:
           FIND Condicion_impos OF T-Fac_header_prv NO-LOCK.
           OPEN QUERY q-iva
               FOR EACH Impuesto_condicion OF Condicion_impos NO-LOCK, 
                   FIRST Impuesto OF Impuesto_condicion
                         WHERE Impuesto.es_iva NO-LOCK.
           GET FIRST q-iva.
           ASSIGN T-Fac_detalle_prv.precio = T-Fac_header_prv.imp_total / ( 1 + Impuesto_condicion.tasa / 100.0 ).

       END.

       RUN calcular_comprobante_proveedor.p ( 
                                INPUT-OUTPUT TABLE T-Fac_header_prv,
                                INPUT-OUTPUT TABLE T-Fac_detalle_prv,
                                INPUT-OUTPUT TABLE T-Sub_header_prv,
                                INPUT-OUTPUT TABLE T-Sub_detalle_prv,
                                INPUT-OUTPUT TABLE T-Fac_header_prv_bon,
                                INPUT-OUTPUT TABLE T-Fac_detalle_prv_bon,
                                INPUT-OUTPUT TABLE T-Fac_header_prv_impuesto,
                                INPUT-OUTPUT TABLE T-Fac_detalle_prv_impuesto,
                                INPUT-OUTPUT TABLE T-Asn_header,
                                INPUT-OUTPUT TABLE T-Asn_detalle,
                                INPUT-OUTPUT TABLE T-Asn_totales ).

       FIND FIRST T-Fac_header_prv.

   END.


END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE calculos C-Win 
PROCEDURE calculos :
/*------------------------------------------------------------------------------
  Purpose: Realiza el calculo del importe final de una factura     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
  DEFINE VARIABLE o-importe AS DECIMAL    NO-UNDO.
  
  EMPTY TEMP-TABLE T-Sub_header_prv NO-ERROR.
  EMPTY TEMP-TABLE T-Sub_detalle_prv NO-ERROR.
  
  IF T-Opg_header.calcular_cambio
  THEN DO:
 
      IF T-Opg_header.tipo_pago = 1 
          THEN RUN calcular_cambio.
      

      RUN calcular_opago.p ( INPUT-OUTPUT TABLE T-Opg_header,
                             INPUT-OUTPUT TABLE T-Opg_detalle,
                             INPUT-OUTPUT TABLE T-Totales_opago).

      FIND FIRST T-Opg_header.

  END.
  ELSE DO:
      RUN calcular_opago.p ( INPUT-OUTPUT TABLE T-Opg_header,
                             INPUT-OUTPUT TABLE T-Opg_detalle,
                             INPUT-OUTPUT TABLE T-Totales_opago).
      FIND FIRST T-Opg_header.

      ASSIGN T-Opg_header.imp_difcambio = 0.
      RUN borrar_diferencia_cambio.
  END.

  RUN abre_query_totales.

  DISPLAY T-Opg_header.imp_difcambio 
          T-Opg_header.imp_pesos 
          T-Opg_header.imp_bruto 
          T-Opg_header.imp_total 
          WITH FRAME {&FRAME-NAME}.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE color_ctacte C-Win 
PROCEDURE color_ctacte :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

  DO WITH FRAME {&FRAME-NAME}:
        ASSIGN
           T-Opg_header.imp_total:BGCOLOR   = 7
           T-Opg_header.imp_total:FGCOLOR   = 15

           a-tip_comprob:BGCOLOR            = 15
           a-prf_comprob:BGCOLOR            = 15
           a-nro_comprob:BGCOLOR            = 15
           a-nro_vencimiento:BGCOLOR        = 15

           a-tip_comprob:FGCOLOR            = 9
           a-prf_comprob:FGCOLOR            = 9
           a-nro_comprob:FGCOLOR            = 9
           a-nro_vencimiento:FGCOLOR        = 9.

  END.
  
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE color_total C-Win 
PROCEDURE color_total :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

  DO WITH FRAME {&FRAME-NAME}:
        ASSIGN
           T-Opg_header.imp_total:BGCOLOR   = 15
           T-Opg_header.imp_total:FGCOLOR   = 9

           a-tip_comprob:BGCOLOR            = 7
           a-prf_comprob:BGCOLOR            = 7
           a-nro_comprob:BGCOLOR            = 7
           a-nro_vencimiento:BGCOLOR        = 7 

           a-tip_comprob:FGCOLOR            = 15
           a-prf_comprob:FGCOLOR            = 15
           a-nro_comprob:FGCOLOR            = 15
           a-nro_vencimiento:FGCOLOR        = 15.
           
  END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE corregir_detalle C-Win 
PROCEDURE corregir_detalle :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
  
     IF modo = MD_ALTA
     THEN DO:

         RUN d-detalle_opago.w ( INPUT  T-Opg_detalle.tip_cancela,
                                 INPUT  T-Opg_detalle.prf_cancela,
                                 INPUT  T-Opg_detalle.nro_cancela,
                                 INPUT  T-Opg_detalle.nro_vencimiento,
                                 INPUT  0, 
                                 INPUT  T-Opg_detalle.nro_linea,
                                 INPUT  modo,
                                 INPUT  MD_CAMBIO,
                                 OUTPUT v-nro_linea,
                                 INPUT-OUTPUT TABLE T-Opg_header,
                                 INPUT-OUTPUT TABLE T-Opg_detalle).

         FIND FIRST T-Opg_header.
         IF v-nro_linea <> 0
         THEN DO:
             RUN calculos.
             {&OPEN-QUERY-{&BROWSE-NAME}}
         END.

     END.
     ELSE DO:

         RUN d-detalle_opago.w ( INPUT  T-Opg_detalle.tip_cancela,
                                 INPUT  T-Opg_detalle.prf_cancela,
                                 INPUT  T-Opg_detalle.nro_cancela,
                                 INPUT  T-Opg_detalle.nro_vencimiento,
                                 INPUT  0, 
                                 INPUT  T-Opg_detalle.nro_linea,
                                 INPUT  modo,
                                 INPUT  MD_READONLY,
                                 OUTPUT v-nro_linea,
                                 INPUT-OUTPUT TABLE T-Opg_header,
                                 INPUT-OUTPUT TABLE T-Opg_detalle).

         FIND FIRST T-Opg_header.

     END.                              

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE crear_caja C-Win 
PROCEDURE crear_caja :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

    CREATE T-Caj_header.
    BUFFER-COPY T-Opg_header TO T-Caj_header
        ASSIGN T-Caj_header.fecha             = T-Opg_header.fecha
               T-Caj_header.hora              = TIME
               T-Caj_header.ultima_linea      = 0
               T-Caj_header.importe           = T-Opg_header.imp_total
               T-Caj_header.emitir            = NO
               T-Caj_header.cdg_caja          = Caja.cdg_caja
               T-Caj_header.nro_cuenta        = Familia_proveedor.nro_cuenta
               T-Caj_header.observacion       = Proveedor.cdg_proveedor + 
                                                "-" + Proveedor.nombre
               T-Caj_header.tipo_mov          = "E"
               T-Opg_header.nro_transaccion   = T-Caj_header.nro_transaccion.

    EMPTY TEMP-TABLE T-Caja-imputacion.
    RUN crear_caja_imputacion.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE crear_caja_imputacion C-Win 
PROCEDURE crear_caja_imputacion :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

    CREATE T-Caja-imputacion.
    ASSIGN T-Caja-imputacion.nro_cuenta       = Familia_proveedor.nro_cuenta
           T-Caja-imputacion.nro_entidad      = Caja.nro_entidad
           T-Caja-imputacion.nro_obra         = 0
           T-Caja-imputacion.nro_transaccion  = T-Caj_header.nro_transaccion
           T-Caja-imputacion.observacion      = ""
           T-Caja-imputacion.valor            = T-Caj_header.importe.


END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE crear_detalle C-Win 
PROCEDURE crear_detalle :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

    DEFINE VARIABLE x-importe LIKE Opg_detalle.importe.

    x-importe  = IF v-importe <> 0 
                    THEN MINIMUM(T-Cta_cte_prv.credito - T-Cta_cte_prv.debito,v-importe)
                    ELSE T-Cta_cte_prv.credito - T-Cta_cte_prv.debito.

    RUN d-detalle_opago.w ( INPUT  a-tip_comprob,
                            INPUT  a-prf_comprob,
                            INPUT  a-nro_comprob,
                            INPUT  a-nro_vencimiento,
                            INPUT  x-importe, 
                            INPUT  0,
                            INPUT  modo,
                            INPUT  MD_ALTA,
                            OUTPUT v-nro_linea,
                            INPUT-OUTPUT TABLE T-Opg_header,
                            INPUT-OUTPUT TABLE T-Opg_detalle).

     FIND FIRST T-Opg_header.

     IF v-nro_linea <> 0
     THEN DO:
         RUN calculos.
         {&OPEN-QUERY-{&BROWSE-NAME}}
         v-importe = v-importe - T-Opg_detalle.importe.
         IF v-importe < 0 THEN v-importe = 0.
         DISPLAY v-importe WITH FRAME {&FRAME-NAME}.
         RUN calculos.                                           
         T-Opg_header.tipo_pago:SENSITIVE IN FRAME {&FRAME-NAME} = NO.
         v-cdg_moneda:SENSITIVE IN FRAME {&FRAME-NAME} = NO.
     END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE crear_registro C-Win 
PROCEDURE crear_registro :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

      CREATE T-Opg_header.
      ASSIGN T-Opg_header.cdg_comprobante   = "ORPAGPRV"
             T-Opg_header.nro_usuario       = Usuario.nro_usuario 
             T-Opg_header.cdg_empresa       = Empresa.cdg_empresa
             T-Opg_header.fecha             = TODAY 
             T-Opg_header.fch_cambio        = TODAY - 1
             T-Opg_header.mes               = MONTH(T-Opg_header.fecha) 
             T-Opg_header.ano               = YEAR(T-Opg_header.fecha)
             T-Opg_header.cdg_empresa       = Empresa.cdg_empresa 
             T-Opg_header.tip_comprob       = "" 
             T-Opg_header.nro_ordpago       = 0  
             T-Opg_header.estado            = "E"  
             T-Opg_header.nro_comprob       = T-Opg_header.nro_ordpago
             T-Opg_header.prf_comprob       = 0
             T-Opg_header.nro_moneda        = Moneda.nro_moneda 
             T-Opg_header.cambio            = Moneda.cambio  
             T-Opg_header.cdg_imputacion    = Imputacion.cdg_imputacion
             T-Opg_header.num_sucursal      = sucursal-id    
             T-Opg_header.origen            = "M"
             t-opg_header.prf_comprob       = 0
             T-Opg_header.tipo_pago         = 1
             T-Opg_header.calcular_cambio   = YES
             v-cdg_moneda                   = Moneda.cdg_moneda
             v-dsc_moneda                   = Moneda.abrevia
             v-cdg_imputacion               = Imputacion.cdg_imputacion
             v-dsc_imputacion               = Imputacion.dsc_imputacion. 
      
      RUN asignar_cambio.
      
    DISPLAY
         T-opg_header.fecha   
         t-opg_header.tip_comprob
         t-opg_header.prf_comprob
         t-opg_header.nro_comprob
         T-Opg_header.fch_cambio   
         T-Opg_header.mes      
         T-Opg_header.ano
         T-Opg_header.cambio  
         T-Opg_header.tipo_pago
         v-cdg_imputacion
         v-dsc_imputacion
         v-cdg_moneda
         v-dsc_moneda 
         WITH FRAME {&FRAME-NAME}.

  codigo_salir = ?.

  IF    modo = MD_MULTIPLE
     OR modo = MD_ANULACION
     OR modo = MD_EMISION
  THEN DO:
       DO WITH FRAME {&FRAME-NAME}:
          T-Opg_header.tip_comprob:FGCOLOR = 9.
          T-Opg_header.tip_comprob:BGCOLOR = 15.

          T-Opg_header.prf_comprob:FGCOLOR = 9.
          T-Opg_header.prf_comprob:BGCOLOR = 15.

          T-Opg_header.nro_comprob:FGCOLOR = 9.
          T-Opg_header.nro_comprob:BGCOLOR = 15.
       END.
  END.


END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE desmarcar_todos C-Win 
PROCEDURE desmarcar_todos :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

  FOR EACH T-Cta_cte_prv OF Proveedor WHERE T-Cta_cte_prv.user-id-sel = st_seleccionado:

      T-Cta_cte_prv.user-id-sel = "".
      T-Cta_cte_prv.selectado   = NO.
      T-Cta_cte_prv.imputado    = NO.
      
  END.


END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

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

  {&OPEN-QUERY-DEFAULT-FRAME}
  GET FIRST DEFAULT-FRAME.
  DISPLAY v-anulado v-importe v-cdg_proveedor v-dsc_proveedor v-cdg_domicilio 
          v-dsc_domicilio v-abv_provincia v-cdg_moneda v-dsc_moneda 
          v-cdg_condicion_impos v-dsc_condicion_impos v-cdg_imputacion 
          v-dsc_imputacion a-tip_comprob a-prf_comprob a-nro_comprob 
          a-nro_vencimiento 
      WITH FRAME DEFAULT-FRAME IN WINDOW C-Win.
  IF AVAILABLE T-Opg_header THEN 
    DISPLAY T-Opg_header.tip_comprob T-Opg_header.prf_comprob 
          T-Opg_header.nro_comprob T-Opg_header.fecha T-Opg_header.fch_cambio 
          T-Opg_header.mes T-Opg_header.ano T-Opg_header.tipo_pago 
          T-Opg_header.cambio T-Opg_header.calcular_cambio 
          T-Opg_header.cambio_dolar T-Opg_header.imp_pesos 
          T-Opg_header.imp_bruto T-Opg_header.imp_difcambio 
          T-Opg_header.imp_total 
      WITH FRAME DEFAULT-FRAME IN WINDOW C-Win.
  ENABLE RECT-10 RECT-11 RECT-12 RECT-13 RECT-2 RECT-3 RECT-4 RECT-5 RECT-6 
         RECT-7 RECT-8 RECT-9 Btn_salir v-importe BRW-TOTALES BROWSE-6 
      WITH FRAME DEFAULT-FRAME IN WINDOW C-Win.
  {&OPEN-BROWSERS-IN-QUERY-DEFAULT-FRAME}
  VIEW C-Win.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE frame_sensitiva C-Win 
PROCEDURE frame_sensitiva :
/*------------------------------------------------------------------------------
  Purpose: habilita o deshabilita los campos de la frame para el estado inicial
           de la misma que se da cuando comienza el ciclo de transaccion. El es-
           tado definitivo de los campos lo ajusta la rutina habilitar_campos ( INPUT YES ).   
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

  DEFINE INPUT PARAMETER habilitado AS LOGICAL.

  DO WITH FRAME {&FRAME-NAME}:

     IF NOT habilitado
     THEN DO:
          ASSIGN
                btn_grabar:SENSITIVE                      = NO
                btn_leyenda:SENSITIVE                     = NO
                btn_cancel:SENSITIVE                      = NO
                btn_anular:SENSITIVE                      = NO
                btn_observ:SENSITIVE                      = NO
                btn_imprim:SENSITIVE                      = NO
                T-Opg_header.tip_comprob:SENSITIVE        = NO
                T-Opg_header.prf_comprob:SENSITIVE        = NO
                T-Opg_header.nro_comprob:SENSITIVE        = NO
                T-Opg_header.fecha:SENSITIVE              = NO
                T-Opg_header.fch_cambio:SENSITIVE         = NO
                T-Opg_header.ano:SENSITIVE                = NO
                T-Opg_header.cambio:SENSITIVE             = NO
                T-Opg_header.cambio_dolar:SENSITIVE       = NO
                T-Opg_header.mes:SENSITIVE                = NO
                v-cdg_condicion_impos:SENSITIVE           = NO
                v-cdg_domicilio:SENSITIVE                 = NO
                v-cdg_imputacion:SENSITIVE                = NO
                v-cdg_moneda:SENSITIVE                    = NO
                v-cdg_proveedor:SENSITIVE                 = NO
                btn_nominar:SENSITIVE                     = NO
                a-tip_comprob:SENSITIVE                   = NO
                a-prf_comprob:SENSITIVE                   = NO
                a-nro_comprob:SENSITIVE                   = NO
                a-nro_vencimiento:SENSITIVE               = NO.
                
     END.
     ELSE DO:

                    /* Deshabilitamos todo y después habilitamos según cada caso */


            RUN frame_sensitiva ( NO ).


            CASE modo:
       
                WHEN MD_ALTA          
                THEN DO:
                     ASSIGN
                        v-cdg_proveedor:SENSITIVE                 = YES
                        T-Opg_header.tipo_pago:SENSITIVE          = YES.

         
                END.
                WHEN MD_MULTIPLE      
                THEN DO:
                     ASSIGN
                        T-Opg_header.tip_comprob:SENSITIVE        = YES
                        T-Opg_header.prf_comprob:SENSITIVE        = YES
                        T-Opg_header.nro_comprob:SENSITIVE        = YES.
                END.
                WHEN MD_DEFINIDA      
                THEN DO:
                     /* Nada habilitado */         
                END.
                WHEN MD_RELACION      
                THEN DO:
                     /* Nada habilitado */         
         
                END.
                WHEN MD_READONLY      
                THEN DO:
                     /* Nada habilitado */         
         
                END.
                WHEN MD_CAMBIO        
                THEN DO:
                     /* Nada habilitado */         
                END.
                WHEN MD_ANULACION        
                THEN DO:
                     ASSIGN
                        T-Opg_header.tip_comprob:SENSITIVE        = YES
                        T-Opg_header.prf_comprob:SENSITIVE        = YES
                        T-Opg_header.nro_comprob:SENSITIVE        = YES.
         
                END.
                WHEN MD_EMISION        
                THEN DO:
                     ASSIGN
                        T-Opg_header.tip_comprob:SENSITIVE        = YES
                        T-Opg_header.prf_comprob:SENSITIVE        = YES
                        T-Opg_header.nro_comprob:SENSITIVE        = YES.         
                END.
       
           END CASE.     
     END.
  END.
  
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE grabar_datos C-Win 
PROCEDURE grabar_datos :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
    DO TRANSACTION:
        
        RUN emitir_opago.p ( 
                INPUT-OUTPUT TABLE T-Caja-imputacion, 
                INPUT-OUTPUT TABLE T-Caj_detalle, 
                INPUT-OUTPUT TABLE T-Caj_header, 
                INPUT-OUTPUT TABLE T-Certificado_gan, 
                INPUT-OUTPUT TABLE T-Certificado_ibr, 
                INPUT-OUTPUT TABLE T-Certificado_iva, 
                INPUT-OUTPUT TABLE T-Certificado_sus, 
                INPUT-OUTPUT TABLE T-Cert_ibr-detalle, 
                INPUT-OUTPUT TABLE T-Cert_iva-detalle, 
                INPUT-OUTPUT TABLE T-Cert_sus-detalle, 
                INPUT-OUTPUT TABLE T-Cheque, 
                INPUT-OUTPUT TABLE T-Cta_cte_prv, 
                INPUT-OUTPUT TABLE T-Fac_detalle_prv, 
                INPUT-OUTPUT TABLE T-Fac_detalle_prv_bon, 
                INPUT-OUTPUT TABLE T-Fac_detalle_prv_impuesto, 
                INPUT-OUTPUT TABLE T-Fac_header_prv, 
                INPUT-OUTPUT TABLE T-Fac_header_prv_bon, 
                INPUT-OUTPUT TABLE T-Fac_header_prv_impuesto, 
                INPUT-OUTPUT TABLE T-Opg_detalle, 
                INPUT-OUTPUT TABLE T-Opg_header, 
                INPUT-OUTPUT TABLE T-Pagos_x_actividad, 
                INPUT-OUTPUT TABLE T-Pagos_x_retibr, 
                INPUT-OUTPUT TABLE T-Pagos_x_retibr_det, 
                INPUT-OUTPUT TABLE T-Pagos_x_retiva, 
                INPUT-OUTPUT TABLE T-Pagos_x_retiva_det, 
                INPUT-OUTPUT TABLE T-Pagos_x_retsus, 
                INPUT-OUTPUT TABLE T-Pagos_x_retsus_det, 
                INPUT-OUTPUT TABLE T-Sub_detalle_prv, 
                INPUT-OUTPUT TABLE T-Sub_header_prv, 
                INPUT-OUTPUT TABLE T-Totales_opago, 
                INPUT-OUTPUT TABLE T-Valor,
                INPUT-OUTPUT TABLE T-Asn_detalle, 
                INPUT-OUTPUT TABLE T-Asn_header, 
                INPUT-OUTPUT TABLE T-Asn_totales 
            ).

        RUN borrar_tablas_temporales.    

   END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE habilitar_campos C-Win 
PROCEDURE habilitar_campos :
/*------------------------------------------------------------------------------
  Purpose: habilita o deshabilita los campos de la frame para el estado final
           de la misma que se da cuando se ejecuta el ciclo de transaccion. El es-
           tado inicial de los campos lo ajusta la rutina frame_sensitiva.   
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

  DEFINE INPUT PARAMETER habilitado AS LOGICAL.

  DO WITH FRAME {&FRAME-NAME}:

                  /* Deshabilitamos todo y después habilitamos según cada caso */

     ASSIGN
          btn_grabar:SENSITIVE                      = NO
          btn_leyenda:SENSITIVE                     = NO
          btn_cancel:SENSITIVE                      = NO
          btn_anular:SENSITIVE                      = NO
          btn_observ:SENSITIVE                      = NO
          btn_imprim:SENSITIVE                      = NO
          btn_nominar:SENSITIVE                     = NO
          T-Opg_header.tip_comprob:SENSITIVE        = NO
          T-Opg_header.prf_comprob:SENSITIVE        = NO
          T-Opg_header.nro_comprob:SENSITIVE        = NO
          T-Opg_header.fecha:SENSITIVE              = NO
          T-Opg_header.fch_cambio:SENSITIVE         = NO
          T-Opg_header.ano:SENSITIVE                = NO
          T-Opg_header.cambio:SENSITIVE             = NO
          T-Opg_header.cambio_dolar:SENSITIVE       = NO
          T-Opg_header.calcular_cambio:SENSITIVE    = NO
          T-Opg_header.mes:SENSITIVE                = NO
          v-cdg_condicion_impos:SENSITIVE           = NO
          v-cdg_domicilio:SENSITIVE                 = NO
          v-cdg_imputacion:SENSITIVE                = NO
          v-cdg_moneda:SENSITIVE                    = NO
          v-cdg_proveedor:SENSITIVE                 = NO.

     CASE modo:

       WHEN MD_ALTA          
       THEN DO:
            ASSIGN
                  btn_grabar:SENSITIVE                      = YES
                  btn_leyenda:SENSITIVE                     = YES
                  btn_cancel:SENSITIVE                      = YES
                  btn_anular:SENSITIVE                      = NO
                  btn_observ:SENSITIVE                      = YES
                  btn_imprim:SENSITIVE                      = NO
                  btn_nominar:SENSITIVE                     = YES
                  T-Opg_header.tip_comprob:SENSITIVE        = YES
                  T-Opg_header.prf_comprob:SENSITIVE        = YES
                  T-Opg_header.nro_comprob:SENSITIVE        = YES
                  T-Opg_header.fecha:SENSITIVE              = YES
                  T-Opg_header.fch_cambio:SENSITIVE         = YES
                  T-Opg_header.ano:SENSITIVE                = YES
                  T-Opg_header.cambio:SENSITIVE             = mod_cambio
                  T-Opg_header.cambio_dolar:SENSITIVE       = YES
                  T-Opg_header.calcular_cambio:SENSITIVE    = YES
                  T-Opg_header.mes:SENSITIVE                = YES
                  T-Opg_header.tipo_pago:SENSITIVE          = NO
                  v-cdg_condicion_impos:SENSITIVE           = YES
                  v-cdg_domicilio:SENSITIVE                 = YES
                  v-cdg_imputacion:SENSITIVE                = YES
                  v-cdg_moneda:SENSITIVE                    = YES
                  v-cdg_proveedor:SENSITIVE                 = NO
                  btn_nominar:SENSITIVE                     = YES.

       END.
       WHEN MD_MULTIPLE      
       THEN DO:
            ASSIGN
                btn_cancel:SENSITIVE                      = YES
                btn_observ:SENSITIVE                      = YES
                btn_leyenda:SENSITIVE                     = YES
                btn_imprim:SENSITIVE                      = YES
                btn_nominar:SENSITIVE                     = YES
                btn_valores:SENSITIVE                     = T-Opg_header.nro_transaccion <> 0.

       END.
       WHEN MD_DEFINIDA      
       THEN DO:
            ASSIGN
                btn_observ:SENSITIVE                      = YES
                btn_imprim:SENSITIVE                      = YES
                btn_leyenda:SENSITIVE                     = YES
                btn_nominar:SENSITIVE                     = YES
                btn_valores:SENSITIVE                     = T-Opg_header.nro_transaccion <> 0.
       END.
       WHEN MD_RELACION      
       THEN DO:
            ASSIGN
                btn_observ:SENSITIVE                      = YES
                btn_imprim:SENSITIVE                      = YES
                btn_leyenda:SENSITIVE                     = YES
                btn_nominar:SENSITIVE                     = YES
                btn_valores:SENSITIVE                     = T-Opg_header.nro_transaccion <> 0.
       END.
       WHEN MD_READONLY      
       THEN DO:
            ASSIGN
                btn_observ:SENSITIVE                      = YES
                btn_imprim:SENSITIVE                      = YES
                btn_leyenda:SENSITIVE                     = YES
                btn_nominar:SENSITIVE                     = YES
                btn_valores:SENSITIVE                     = T-Opg_header.nro_transaccion <> 0.
       END.
       WHEN MD_CAMBIO        
       THEN DO:
            ASSIGN
                btn_observ:SENSITIVE                      = YES
                btn_imprim:SENSITIVE                      = YES
                btn_leyenda:SENSITIVE                     = YES
                btn_nominar:SENSITIVE                     = YES
                btn_valores:SENSITIVE                     = T-Opg_header.nro_transaccion <> 0.
       END.
       WHEN MD_ANULACION        
       THEN DO:
            ASSIGN
                btn_cancel:SENSITIVE                      = YES
                btn_anular:SENSITIVE                      = YES
                btn_observ:SENSITIVE                      = YES
                btn_imprim:SENSITIVE                      = YES
                btn_leyenda:SENSITIVE                     = YES
                btn_nominar:SENSITIVE                     = YES
                btn_valores:SENSITIVE                     = T-Opg_header.nro_transaccion <> 0.
       END.
       WHEN MD_EMISION        
       THEN DO:
            ASSIGN
                btn_grabar:SENSITIVE                      = YES
                btn_observ:SENSITIVE                      = YES
                btn_imprim:SENSITIVE                      = YES
                btn_leyenda:SENSITIVE                     = YES
                btn_nominar:SENSITIVE                     = YES
                btn_valores:SENSITIVE                     = T-Opg_header.nro_transaccion <> 0.
       END.

    END CASE.     

  END.
  
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE habilitar_ctacte C-Win 
PROCEDURE habilitar_ctacte :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

  DO WITH FRAME {&FRAME-NAME}:

      ASSIGN           
           a-tip_comprob:SENSITIVE          = YES
           a-prf_comprob:SENSITIVE          = YES
           a-nro_comprob:SENSITIVE          = YES
           a-nro_vencimiento:SENSITIVE      = YES
           T-Opg_header.imp_total:SENSITIVE = NO.
           
  END.
  
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE habilitar_total C-Win 
PROCEDURE habilitar_total :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

  DO WITH FRAME {&FRAME-NAME}:

        ASSIGN
           T-Opg_header.imp_total:SENSITIVE = YES
           a-tip_comprob:SENSITIVE          = NO
           a-prf_comprob:SENSITIVE          = NO
           a-nro_comprob:SENSITIVE          = NO
           a-nro_vencimiento:SENSITIVE      = NO.
           
  END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE iniciar_documento C-Win 
PROCEDURE iniciar_documento :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

   RUN getparametro.p (  INPUT  "MDCAMBIO",
                          OUTPUT v-valor_c,
                          OUTPUT v-valor_d,
                          OUTPUT v-valor_l,
                          OUTPUT v-valor_n,
                          OUTPUT v-observacion ).
   IF v-valor_l = ? 
      THEN mod_cambio = NO.
      ELSE mod_cambio = v-valor_l.

   RUN getparametro.p (  INPUT  "DFMONEDA",
                         OUTPUT v-valor_c,
                         OUTPUT v-valor_d,
                         OUTPUT v-valor_l,
                         OUTPUT v-valor_n,
                         OUTPUT v-observacion ).
   FIND Moneda WHERE Moneda.cdg_moneda = v-valor_c NO-LOCK.

   RUN getparametro.p (  INPUT  "CDGDOLAR",
                         OUTPUT v-valor_c,
                         OUTPUT v-valor_d,
                         OUTPUT v-valor_l,
                         OUTPUT v-valor_n,
                         OUTPUT v-observacion ).
   codigo_dolar = v-valor_c.

   RUN getparametro.p (  INPUT  "DFNROCAJ",
                         OUTPUT v-valor_c,
                         OUTPUT v-valor_d,
                         OUTPUT v-valor_l,
                         OUTPUT v-valor_n,
                         OUTPUT v-observacion ).
    
   FIND Caja WHERE Caja.cdg_caja = v-valor_n NO-LOCK.
   act_caja = ROWID(Caja).
   
   RUN getparametro.p (  INPUT  "DFCNCCTE",
                         OUTPUT v-valor_c,
                         OUTPUT v-valor_d,
                         OUTPUT v-valor_l,
                         OUTPUT v-valor_n,
                         OUTPUT v-observacion ).

   FIND Imputacion WHERE Imputacion.cdg_imputacion = v-valor_n NO-LOCK.
   
   RUN getparametro_c.p (  INPUT  "DFCAPVDB", OUTPUT v-debito_cambio ).
   RUN getparametro_c.p (  INPUT  "DFCAPVCR", OUTPUT v-credito_cambio ).

   IF v-debito_cambio = ? OR v-credito_cambio = ? 
       THEN MESSAGE "No se encuentra la definicion de los débitos y créditos por diferencia de cambio"
                    VIEW-AS ALERT-BOX ERROR TITLE "ERROR DE IMPLEMENTACION".

   st_seleccionado = "OPG-" + USERID("SIC").
   RUN titulo_window ( INPUT "Ordenes de Pago a Proveedores" ).
   v-importe = 0.
   DISPLAY v-importe WITH FRAME {&FRAME-NAME}.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE levantar_cuenta_corriente C-Win 
PROCEDURE levantar_cuenta_corriente :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

   EMPTY TEMP-TABLE T-Cta_cte_prv NO-ERROR.
               
   FOR EACH Cta_cte_prv NO-LOCK OF Proveedor
        WHERE Cta_cte_prv.cdg_empresa = T-Opg_header.cdg_empresa
          /*AND Cta_cte_prv.nro_moneda = T-Opg_header.nro_moneda*/
          AND Cta_cte_prv.debito <> Cta_cte_prv.credito:
       
       CREATE T-Cta_cte_prv.
       BUFFER-COPY Cta_cte_prv TO T-Cta_cte_prv.

   END.        

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE poner_proveedor C-Win 
PROCEDURE poner_proveedor :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

    IF NOT CAN-DO(Proveedor.lista_empresas,Empresa.cdg_empresa)
    THEN DO:
        RUN PONMENSJ.P ( INPUT "CLIE050" ).
        no_aplicar = YES.
        RETURN ERROR.
    END.
    ELSE DO:
        IF LOOKUP(Proveedor.cdg_estado,",A") = 0
        THEN DO:
            RUN PONMENSJ.P ( INPUT "CLIE051" ).
            no_aplicar = YES.
            RETURN ERROR.
        END.
        ELSE DO:
            FIND Condicion_venta WHERE Condicion_venta.cdg_cndventa = Proveedor.dfl_cndventa NO-LOCK.
            FIND Familia_proveedor OF Proveedor NO-LOCK.
            FIND Condicion_impos   OF Proveedor NO-LOCK.
          
            DISPLAY "OP" @ T-Opg_header.tip_comprob
                     WITH FRAME {&FRAME-NAME}.
            ASSIGN
              T-Opg_header.cdg_condiva          = Condicion_impos.cdg_condiva
              T-Opg_header.nro_cndventa         = Condicion_venta.nro_cndventa
              T-Opg_header.nombre               = Proveedor.nombre
              T-Opg_header.cuit                 = Proveedor.cuit
              T-Opg_header.nro_proveedor        = Proveedor.nro_proveedor.
        
            RUN traer_proveedor.
            RUN traer_imputacion.
            RUN traer_condicion_impos.
            
            DISPLAY  v-cdg_proveedor 
                     v-dsc_proveedor
                     
                     v-cdg_imputacion
                     v-dsc_imputacion
        
                     v-cdg_condicion_impos
                     v-dsc_condicion_impos
        
                   WITH FRAME {&FRAME-NAME}.
                   
                IF T-Opg_header.tipo_pago = 1
                   THEN RUN habilitar_ctacte.
                   ELSE RUN habilitar_total.
                    
             FIND FIRST Domicilio_prv OF Proveedor NO-LOCK NO-ERROR.
             IF AVAILABLE Domicilio_prv 
             THEN DO:
                 FIND Provincia OF Domicilio_prv NO-LOCK.
                 ASSIGN  T-Opg_header.nro_domicilio = Domicilio_prv.nro_domicilio
                         T-Opg_header.direccion     = Domicilio_prv.direccion
                         T-Opg_header.cdg_provincia = Domicilio_prv.cdg_provincia
                         T-Opg_header.localidad     = Domicilio_prv.localidad
                         T-Opg_header.cdg_postal    = Domicilio_prv.cdg_postal
                         T-Opg_header.cdg_zonag     = Domicilio_prv.cdg_zonag
                         v-cdg_domicilio            = Domicilio_prv.nro_domicilio
                         v-dsc_domicilio            = Domicilio_prv.nombre.
                 DISPLAY v-cdg_domicilio
                         v-dsc_domicilio
                         WITH FRAME {&FRAME-NAME}.
                 IF CAN-FIND(Domicilio_prv OF Proveedor)
                    THEN DISABLE v-cdg_domicilio WITH FRAME {&FRAME-NAME}.      
             END.
             ELSE DO:  /* No hay ninguno o hay mas de uno */
                 ASSIGN  T-Opg_header.nro_domicilio = 0
                         T-Opg_header.direccion     = ""
                         T-Opg_header.cdg_provincia = ""
                         T-Opg_header.localidad     = ""
                         T-Opg_header.cdg_postal    = ""
                         T-Opg_header.cdg_zonag     = ""
                         v-cdg_domicilio            = 0
                         v-dsc_domicilio            = "".
                 DISPLAY v-cdg_domicilio
                         v-dsc_domicilio
                         WITH FRAME {&FRAME-NAME}.
                 ENABLE v-cdg_domicilio WITH FRAME {&FRAME-NAME}.
             END.   

             RUN levantar_cuenta_corriente.
             RUN habilitar_campos ( YES ).
        END.
    END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE titulo_window C-Win 
PROCEDURE titulo_window :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

 DEFINE INPUT PARAMETER txtitulo AS CHARACTER.

 DEFINE VARIABLE v-txtitulo AS CHARACTER.

 CASE modo:
    
     WHEN MD_ALTA      THEN v-txtitulo = " Ingreso de " + txtitulo.
     WHEN MD_MULTIPLE  THEN v-txtitulo = " Consulta Múltiple de " + txtitulo.
     WHEN MD_DEFINIDA  THEN v-txtitulo = " Consulta Individual de " + txtitulo.
     WHEN MD_RELACION  THEN v-txtitulo = " Consulta Relacionada de " + txtitulo.
     WHEN MD_READONLY  THEN v-txtitulo = " Consulta Sólo Lectura de " + txtitulo.
     WHEN MD_CAMBIO    THEN v-txtitulo = " Modificación y Reemisión de " + txtitulo.
     WHEN MD_ANULACION THEN v-txtitulo = " Anulación de " + txtitulo.
     WHEN MD_EMISION   THEN v-txtitulo = " Emisión de " + txtitulo + "Pendientes".

 END CASE.     

 {&WINDOW-NAME}:TITLE = "DYNASYS/CXC " + NRO_RELEASE + " - " + Usuario.cdg_empresa + " - " + v-txtitulo + " User:" + USERID("sic").

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE traer_condicion_impos C-Win 
PROCEDURE traer_condicion_impos :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

    FIND Condicion_impos  OF T-Opg_header NO-LOCK.
    ASSIGN
        v-cdg_condicion_impos = Condicion_impos.cdg_condiva
        v-dsc_condicion_impos = Condicion_impos.descripcion.
    
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE traer_documento C-Win 
PROCEDURE traer_documento :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

   FIND Opg_header WHERE ROWID(Opg_header) = rid_opago NO-LOCK.
   BUFFER-COPY Opg_header TO T-Opg_header.
   FOR EACH Opg_detalle OF Opg_header:
       CREATE T-Opg_detalle.
       BUFFER-COPY Opg_detalle TO T-Opg_detalle.
   END.    

   FOR EACH Totales_opago OF Opg_header:
       CREATE T-Totales_opago.
       BUFFER-COPY Totales_opago TO T-Totales_opago.
   END.    

   IF T-Opg_header.tipo_pago = 1
      THEN RUN color_ctacte.
      ELSE RUN color_total.

   RUN traer_tablas.
   IF T-Opg_header.nro_transaccion <> 0
       THEN RUN traer_movimiento_caja.p ( INPUT T-Opg_header.nro_transaccion,
                                          OUTPUT TABLE T-Caj_header,
                                          OUTPUT TABLE T-Caj_detalle,
                                          OUTPUT TABLE T-Caja-imputacion,
                                          OUTPUT TABLE T-Cheque,
                                          OUTPUT TABLE T-Valor).

   v-anulado = IF T-Opg_header.anulado THEN "ANULADA" ELSE "".
   DISPLAY
        T-Opg_header.ano 
        T-Opg_header.cambio 
        T-Opg_header.cambio_dolar 
        T-Opg_header.calcular_cambio
        T-Opg_header.fecha 
        T-Opg_header.imp_total 
        T-Opg_header.imp_bruto 
        T-Opg_header.imp_difcambio 
        T-Opg_header.imp_pesos 
        T-Opg_header.mes 
        T-Opg_header.nro_comprob 
        T-Opg_header.prf_comprob 
        T-Opg_header.tip_comprob 
        T-Opg_header.tipo_pago
        v-cdg_condicion_impos 
        v-cdg_domicilio 
        v-cdg_imputacion 
        v-cdg_moneda 
        v-cdg_proveedor 
        v-dsc_condicion_impos 
        v-dsc_domicilio 
        v-dsc_imputacion 
        v-dsc_moneda 
        v-dsc_proveedor 
        v-anulado
        WITH FRAME {&FRAME-NAME}.

   {&OPEN-QUERY-{&BROWSE-NAME}}

   RUN abre_query_totales.
       
   RUN habilitar_campos ( INPUT YES ).
   
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE traer_domicilio C-Win 
PROCEDURE traer_domicilio :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

    FIND Domicilio_prv OF T-Opg_header NO-LOCK.
    ASSIGN
        v-cdg_domicilio = Domicilio_prv.nro_domicilio
        v-dsc_domicilio = Domicilio_prv.nombre.
    
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE traer_imputacion C-Win 
PROCEDURE traer_imputacion :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

    FIND Imputacion       OF T-Opg_header NO-LOCK.
    ASSIGN
        v-cdg_imputacion      = Imputacion.cdg_imputacion
        v-dsc_imputacion      = Imputacion.dsc_imputacion.
    
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE traer_moneda C-Win 
PROCEDURE traer_moneda :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

    FIND Moneda    OF T-Opg_header   NO-LOCK.
    ASSIGN
        v-cdg_moneda          = Moneda.cdg_moneda
        v-dsc_moneda          = Moneda.descripcion.
         
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE traer_proveedor C-Win 
PROCEDURE traer_proveedor :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

    FIND Proveedor OF T-Opg_header NO-LOCK.
    ASSIGN
        v-cdg_proveedor   = Proveedor.cdg_proveedor
        v-dsc_proveedor   = Proveedor.nombre.
    
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE traer_tablas C-Win 
PROCEDURE traer_tablas :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

  RUN traer_condicion_impos.
  RUN traer_imputacion.
  RUN traer_moneda.
  RUN traer_proveedor.
  RUN traer_domicilio.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE validar_datos C-Win 
PROCEDURE validar_datos :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

    DEFINE OUTPUT PARAMETER hubo_error AS LOGICAL.
      
    hubo_error = YES.

    IF NOT CAN-FIND(FIRST T-Opg_detalle OF  T-Opg_header) AND T-Opg_header.tipo_pago = 1
    THEN DO:
       RUN PONMENSJ.P (INPUT "RECB008").
       RETURN.
    END.

    IF LOOKUP(T-Opg_header.tip_comprob,"OP") = 0
    THEN DO:
       RUN PONMENSJ.P (INPUT "RECB015").
       RETURN.
    END.

/*  IF T-Opg_header.nro_comprob = 0
    THEN DO:
       RUN PONMENSJ.P (INPUT "RECB016").
       RETURN.
    END. */

    IF T-Opg_header.imp_total = 0 AND T-Opg_header.tipo_pago = 2
    THEN DO:
       RUN PONMENSJ.P (INPUT "RECB019").
       RETURN.
    END.

    IF CAN-FIND(Opg_header WHERE Opg_header.cdg_empresa = T-Opg_header.cdg_empresa
                             AND Opg_header.tip_comprob = T-Opg_header.tip_comprob
                             AND Opg_header.prf_comprob = T-Opg_header.prf_comprob
                             AND Opg_header.nro_comprob = T-Opg_header.nro_comprob)
    THEN DO:
       RUN PONMENSJ.P (INPUT "RECB014").
       RETURN.
    END.

    FIND FIRST Domicilio_prv OF Proveedor WHERE Domicilio_prv.nro_domicilio = INPUT FRAME {&FRAME-NAME} v-cdg_domicilio NO-LOCK NO-ERROR.
    IF NOT AVAILABLE Domicilio_prv
    THEN DO:
         RUN PONMENSJ.P (INPUT "FACT006").
         RETURN.
    END.
 /* ELSE DO:
         ASSIGN
             T-Opg_header.nro_domicilio = Domicilio_prv.nro_domicilio
             T-Opg_header.direccion     = Domicilio_prv.direccion
             T-Opg_header.cdg_provincia = Domicilio_prv.cdg_provincia
             T-Opg_header.localidad     = Domicilio_prv.localidad
             T-Opg_header.cdg_postal    = Domicilio_prv.cdg_postal
             T-Opg_header.cdg_zonag     = Domicilio_prv.cdg_zonag.
    END. */

    {validartabla.i "Condicion_impos"   "cdg_condiva"     "descripcion"    "DBCR013"}
    {validartabla.i "Moneda"            "cdg_moneda"      "descripcion"    "DBCR012"}
    {validartabla.i "Imputacion"        "cdg_imputacion"  "dsc_imputacion" "DBCR016"}

    hubo_error = NO.

    &SCOPED-DEFINE TABLA-MAESTRA  T-Opg_header

    {asignartabla.i "Condicion_impos"   "cdg_condiva"     "cdg_condiva"      }
    {asignartabla.i "Moneda"            "nro_moneda"      "nro_moneda"       }
    {asignartabla.i "Imputacion"        "cdg_imputacion"  "cdg_imputacion"   }

    &UNDEFINE TABLA-MAESTRA


END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

