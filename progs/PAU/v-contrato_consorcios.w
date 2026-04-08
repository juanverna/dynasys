&ANALYZE-SUSPEND _VERSION-NUMBER UIB_v8r12 GUI ADM1
&ANALYZE-RESUME
/* Connected Databases 
          sic              PROGRESS
*/
&Scoped-define WINDOW-NAME CURRENT-WINDOW


/* Temp-Table and Buffer definitions                                    */
DEFINE BUFFER Administrador FOR Cliente.



&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _DEFINITIONS V-table-Win 
/*------------------------------------------------------------------------

  File:

  Description: from VIEWER.W - Template for SmartViewer Objects

  Input Parameters:
      <none>

  Output Parameters:
      <none>

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

/* Local Variable Definitions ---                                       */

DEFINE VARIABLE rid_tabla AS ROWID.

DEF VAR sino-msg AS LOGICAL NO-UNDO.

{VRSHARED.I "NEW"}
DEF VAR hcproc AS CHAR NO-UNDO.
DEF VAR hproc AS HANDLE NO-UNDO.

DEF VAR v-motivo_baja AS CHAR NO-UNDO.
DEF VAR hcta_cte AS HANDLE NO-UNDO.
DEF VAR v-leyenda LIKE contrato_hd.leyenda.
DEF VAR v-vobservacion LIKE contrato_hd.observacion.
{advtexto.i}

{extrae.i}
{stavisado.i}
{tiempo.i}
{crystal_dyna.p}
{impresoras.i}

DEFINE TEMP-TABLE tcontrato_hd NO-UNDO LIKE contrato_hd 
    FIELD administracion AS CHAR
    FIELD DESC_tipoevento AS CHAR
    FIELD TOTAL_anticipo_cf AS DECIMAL
    FIELD TOTAL_cuota1_cf AS DECIMAL
    FIELD cuota_cf AS DECIMAL.

DEFINE TEMP-TABLE tcontrato_dt NO-UNDO LIKE contrato_dt.
    
DEFINE DATASET dset FOR tcontrato_hd,tcontrato_dt 
    DATA-RELATION FOR tcontrato_hd, tcontrato_dt  NESTED
    RELATION-FIELDS ( nro_contrato,nro_contrato).

DEFINE TEMP-TABLE tcredito NO-UNDO
    field rid AS ROWID.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE SmartViewer
&Scoped-define DB-AWARE no

&Scoped-define ADM-SUPPORTED-LINKS Record-Source,Record-Target,TableIO-Target

/* Name of designated FRAME-NAME and/or first browse and/or first query */
&Scoped-define FRAME-NAME F-Main

/* External Tables                                                      */
&Scoped-define EXTERNAL-TABLES Contrato_hd Cliente
&Scoped-define FIRST-EXTERNAL-TABLE Contrato_hd


/* Need to scope the external tables to this procedure                  */
DEFINE QUERY external_tables FOR Contrato_hd, Cliente.
/* Standard List Definitions                                            */
&Scoped-Define ENABLED-FIELDS Contrato_hd.nro_tipo_evento ~
Contrato_hd.estado Contrato_hd.numero_eventos Contrato_hd.titulo ~
Contrato_hd.suspendido Contrato_hd.cdg_lista Contrato_hd.nro_plazo ~
Contrato_hd.modo_facturacion Contrato_hd.garantia Contrato_hd.primer_mes ~
Contrato_hd.primer_ano Contrato_hd.cant_periodos Contrato_hd.fecha_alta ~
Contrato_hd.fecha_baja Contrato_hd.resto_periodos Contrato_hd.rige_desde ~
Contrato_hd.rige_hasta Contrato_hd.dreminder Contrato_hd.Reminder ~
Contrato_hd.leyAdicional Contrato_hd.imp_total 
&Scoped-define ENABLED-TABLES Contrato_hd
&Scoped-define FIRST-ENABLED-TABLE Contrato_hd
&Scoped-Define ENABLED-OBJECTS RECT-19 RECT-20 b_renov b-observ b-alerta ~
b_rest b_presup B_email v-cdg_condicion_impos v-cdg_vendedor Bleyenda-2 ~
v-facturado v-pagado v-anticipos v-cuota1 v-cuotas 
&Scoped-Define DISPLAYED-FIELDS Contrato_hd.num_contrato ~
Contrato_hd.nro_tipo_evento Contrato_hd.estado Contrato_hd.numero_eventos ~
Contrato_hd.titulo Contrato_hd.suspendido Contrato_hd.cdg_lista ~
Contrato_hd.nro_plazo Contrato_hd.modo_facturacion Contrato_hd.garantia ~
Contrato_hd.primer_mes Contrato_hd.primer_ano Contrato_hd.cant_periodos ~
Contrato_hd.fecha_alta Contrato_hd.fecha_baja Contrato_hd.ultimo_mes ~
Contrato_hd.ultimo_ano Contrato_hd.resto_periodos Contrato_hd.rige_desde ~
Contrato_hd.rige_hasta Contrato_hd.dreminder Contrato_hd.Reminder ~
Contrato_hd.leyAdicional Contrato_hd.imp_total 
&Scoped-define DISPLAYED-TABLES Contrato_hd
&Scoped-define FIRST-DISPLAYED-TABLE Contrato_hd
&Scoped-Define DISPLAYED-OBJECTS prf v-cdg_condicion_impos ~
v-dsc_condicion_impos v-dsc_vendedor v-cdg_condicion_venta v-cdg_vendedor ~
v-dsc_condicion_venta v-facturado v-pagado v-anticipos v-cuota1 v-cuotas 

/* Custom List Definitions                                              */
/* ADM-CREATE-FIELDS,ADM-ASSIGN-FIELDS,List-3,List-4,List-5,List-6      */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _XFTR "Foreign Keys" V-table-Win _INLINE
/* Actions: ? adm/support/keyedit.w ? ? ? */
/* STRUCTURED-DATA
<KEY-OBJECT>
THIS-PROCEDURE
</KEY-OBJECT>
<FOREIGN-KEYS>
cdg_empresa||y|sic.Empresa.cdg_empresa
nro_contrato|y|y|sic.Contrato_hd.nro_contrato
cdg_empresa|y|y|sic.Contrato_hd.cdg_empresa
nombre||y|sic.Contrato_hd.nombre
nro_area||y|sic.Contrato_hd.nro_area
cdg_banco||y|sic.Contrato_hd.cdg_banco
nro_cliente||y|sic.Contrato_hd.nro_cliente
cdg_condiva||y|sic.Contrato_hd.cdg_condiva
nro_cndventa||y|sic.Contrato_hd.nro_cndventa
cdg_consignatario||y|sic.Contrato_hd.cdg_consignatario
cdg_postal||y|sic.Contrato_hd.cdg_postal
cdg_formapago||y|sic.Contrato_hd.cdg_formapago
cdg_imputacion||y|sic.Contrato_hd.cdg_imputacion
cdg_lista||y|sic.Contrato_hd.cdg_lista
nro_moneda||y|sic.Contrato_hd.nro_moneda
nro_obra||y|sic.Contrato_hd.nro_obra
nro_persona||y|sic.Contrato_hd.nro_persona
cdg_planta||y|sic.Contrato_hd.cdg_planta
nro_plazo||y|sic.Contrato_hd.nro_plazo
cdg_provincia||y|sic.Contrato_hd.cdg_provincia
nro_remito||y|sic.Contrato_hd.nro_remito
cdg_solicitante||y|sic.Contrato_hd.cdg_solicitante
num_sucursal||y|sic.Contrato_hd.num_sucursal
cdg_embarque||y|sic.Contrato_hd.cdg_embarque
nro_tipo_evento||y|sic.Contrato_hd.nro_tipo_evento
nro_usuario||y|sic.Contrato_hd.nro_usuario
nro_vendedor||y|sic.Contrato_hd.nro_vendedor
cdg_zonag||y|sic.Contrato_hd.cdg_zonag
</FOREIGN-KEYS> 
<EXECUTING-CODE>
**************************
* Set attributes related to FOREIGN KEYS
*/
RUN set-attribute-list (
    'Keys-Accepted = "nro_contrato,cdg_empresa",
     Keys-Supplied = "cdg_empresa,nro_contrato,cdg_empresa,nombre,nro_area,cdg_banco,nro_cliente,cdg_condiva,nro_cndventa,cdg_consignatario,cdg_postal,cdg_formapago,cdg_imputacion,cdg_lista,nro_moneda,nro_obra,nro_persona,cdg_planta,nro_plazo,cdg_provincia,nro_remito,cdg_solicitante,num_sucursal,cdg_embarque,nro_tipo_evento,nro_usuario,nro_vendedor,cdg_zonag"':U).
/**************************
</EXECUTING-CODE> */
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

/* ************************  Function Prototypes ********************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION-FORWARD ver_anticipos V-table-Win 
FUNCTION ver_anticipos RETURNS DECIMAL
  ( )  FORWARD.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION-FORWARD ver_couta1 V-table-Win 
FUNCTION ver_couta1 RETURNS DECIMAL
  ( )  FORWARD.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


/* ***********************  Control Definitions  ********************** */


/* Menu Definitions                                                     */
DEFINE MENU POPUP-MENU-fecha_baja 
       MENU-ITEM m_Baja_Contrato LABEL "Baja Contrato" 
       MENU-ITEM m_Motivo_de_Baja LABEL "Motivo de Baja".

DEFINE MENU POPUP-MENU-rige_hasta 
       MENU-ITEM m_Calcular_Fecha LABEL "Calcular Fecha".


/* Definitions of the field level widgets                               */
DEFINE BUTTON b-alerta 
     IMAGE-UP FILE "iconos16/trafficlight_on.jpg":U
     IMAGE-INSENSITIVE FILE "iconos16i/trafficlight_on.jpg":U
     LABEL "Leyenda" 
     SIZE 4.8 BY 1 TOOLTIP "Leyenda del contrato - Se llevara a los eventos".

DEFINE BUTTON b-observ 
     IMAGE-UP FILE "iconos16/text.jpg":U
     IMAGE-INSENSITIVE FILE "iconos16i/text.jpg":U
     LABEL "Observ" 
     SIZE 4.8 BY 1 TOOLTIP "Observaciones internas solo para el contrato".

DEFINE BUTTON Bcta-cte 
     LABEL "Cta-Cte" 
     SIZE 8.2 BY .67.

DEFINE BUTTON Bleyenda-2 
     IMAGE-UP FILE "iconos16/about.jpg":U
     IMAGE-INSENSITIVE FILE "iconos16i/about.jpg":U
     LABEL "Bleyenda 2" 
     SIZE 3.8 BY 1.14.

DEFINE BUTTON B_email 
     LABEL "Email" 
     SIZE 8 BY .95 TOOLTIP "Impresion del contrato en formato presupuesto".

DEFINE BUTTON b_presup 
     LABEL "Presup" 
     SIZE 8 BY .95 TOOLTIP "Impresion del contrato en formato presupuesto".

DEFINE BUTTON b_renov 
     LABEL "Renovar" 
     SIZE 9.6 BY 1 TOOLTIP "Renueva el contrato creando otro y sus restricciones".

DEFINE BUTTON b_rest 
     LABEL "Rest" 
     SIZE 7.4 BY .95.

DEFINE VARIABLE prf AS INTEGER FORMAT "9999":U INITIAL 0 
     VIEW-AS COMBO-BOX INNER-LINES 5
     LIST-ITEMS "         0" 
     DROP-DOWN-LIST
     SIZE 13 BY 1
     BGCOLOR 15 FGCOLOR 9  NO-UNDO.

DEFINE VARIABLE v-anticipos AS DECIMAL FORMAT "->>>9.99":U INITIAL 0 
     LABEL "Ant." 
      VIEW-AS TEXT 
     SIZE 8.8 BY .62 TOOLTIP "Valores de anticipo" NO-UNDO.

DEFINE VARIABLE v-cdg_condicion_impos AS INTEGER FORMAT ">>>9" INITIAL 0 
     LABEL "Cond.Impos." 
     VIEW-AS FILL-IN NATIVE 
     SIZE 7 BY 1
     BGCOLOR 15 FGCOLOR 9 .

DEFINE VARIABLE v-cdg_condicion_venta AS CHARACTER FORMAT "X(8)" 
     LABEL "C. Venta" 
     VIEW-AS FILL-IN NATIVE 
     SIZE 6 BY 1
     BGCOLOR 15 FGCOLOR 9 .

DEFINE VARIABLE v-cdg_vendedor AS CHARACTER FORMAT "X(8)" 
     LABEL "Vend." 
     VIEW-AS FILL-IN NATIVE 
     SIZE 12 BY 1
     BGCOLOR 15 FGCOLOR 9 .

DEFINE VARIABLE v-cuota1 AS DECIMAL FORMAT ">>>>9.99":U INITIAL 0 
     LABEL "Cuota 1" 
      VIEW-AS TEXT 
     SIZE 8 BY .62 TOOLTIP "Valor aproximado de la cuota" NO-UNDO.

DEFINE VARIABLE v-cuotas AS DECIMAL FORMAT ">>>>9.99":U INITIAL 0 
     LABEL "Cuotas" 
      VIEW-AS TEXT 
     SIZE 8 BY .62 TOOLTIP "Valor aproximado de la cuota" NO-UNDO.

DEFINE VARIABLE v-dsc_condicion_impos AS CHARACTER FORMAT "X(35)" 
     VIEW-AS FILL-IN 
     SIZE 30 BY 1
     BGCOLOR 7 FGCOLOR 15 .

DEFINE VARIABLE v-dsc_condicion_venta AS CHARACTER FORMAT "X(35)" 
     VIEW-AS FILL-IN NATIVE 
     SIZE 35 BY 1
     BGCOLOR 7 FGCOLOR 15 .

DEFINE VARIABLE v-dsc_vendedor AS CHARACTER FORMAT "X(35)" 
     VIEW-AS FILL-IN NATIVE 
     SIZE 30 BY 1
     BGCOLOR 7 FGCOLOR 15 .

DEFINE VARIABLE v-facturado AS DECIMAL FORMAT ">>>>>>9.9":U INITIAL 0 
     LABEL "F." 
      VIEW-AS TEXT 
     SIZE 13 BY .62 NO-UNDO.

DEFINE VARIABLE v-pagado AS DECIMAL FORMAT ">>>>>>9.99":U INITIAL 0 
     LABEL "Pag" 
      VIEW-AS TEXT 
     SIZE 17 BY .62 NO-UNDO.

DEFINE RECTANGLE RECT-19
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 52 BY 2.86.

DEFINE RECTANGLE RECT-20
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 68 BY 2.86.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME F-Main
     b_renov AT ROW 1.19 COL 113.8 WIDGET-ID 38
     prf AT ROW 1.24 COL 3 COLON-ALIGNED NO-LABEL WIDGET-ID 78
     Contrato_hd.num_contrato AT ROW 1.24 COL 17.4 COLON-ALIGNED NO-LABEL
          VIEW-AS FILL-IN NATIVE 
          SIZE 13 BY 1
          BGCOLOR 15 FGCOLOR 9 
     Contrato_hd.nro_tipo_evento AT ROW 1.24 COL 39.2 COLON-ALIGNED WIDGET-ID 28
          LABEL "TipoEV"
          VIEW-AS COMBO-BOX SORT INNER-LINES 10
          LIST-ITEM-PAIRS "eeee",1
          DROP-DOWN-LIST
          SIZE 8.4 BY 1 TOOLTIP "Tipo de evento que genera el contrato"
          BGCOLOR 15 FGCOLOR 9 
     Contrato_hd.estado AT ROW 1.24 COL 51.4 COLON-ALIGNED WIDGET-ID 106
          LABEL "St."
          VIEW-AS COMBO-BOX INNER-LINES 5
          LIST-ITEM-PAIRS "Aprob","A",
                     "Rechz","R",
                     "Pend.","P"
          DROP-DOWN-LIST
          SIZE 12 BY 1
          BGCOLOR 15 FGCOLOR 9 
     Contrato_hd.numero_eventos AT ROW 1.24 COL 68.2 COLON-ALIGNED WIDGET-ID 50
          LABEL "Ev"
          VIEW-AS FILL-IN NATIVE 
          SIZE 5 BY 1
          BGCOLOR 15 FGCOLOR 9 
     b-observ AT ROW 1.24 COL 76.2 WIDGET-ID 46
     b-alerta AT ROW 1.24 COL 82 WIDGET-ID 52
     b_rest AT ROW 1.24 COL 88 WIDGET-ID 48
     b_presup AT ROW 1.24 COL 96.4 WIDGET-ID 108
     B_email AT ROW 1.24 COL 105.2 WIDGET-ID 114
     Contrato_hd.titulo AT ROW 2.33 COL 11 COLON-ALIGNED
          LABEL "Título" FORMAT "X(100)"
          VIEW-AS FILL-IN NATIVE 
          SIZE 99 BY 1
          BGCOLOR 15 FGCOLOR 9 
     Contrato_hd.suspendido AT ROW 2.43 COL 113 WIDGET-ID 116
          VIEW-AS TOGGLE-BOX
          SIZE 10 BY .81 TOOLTIP "Si esta suspendido de factura y/o evento"
     Contrato_hd.cdg_lista AT ROW 3.38 COL 11 COLON-ALIGNED WIDGET-ID 110
          VIEW-AS FILL-IN NATIVE 
          SIZE 7.6 BY 1 TOOLTIP "A la renovacion - Se rige por lista de precios o 0 para manual"
          BGCOLOR 15 FGCOLOR 9 
     Contrato_hd.nro_plazo AT ROW 3.38 COL 29 COLON-ALIGNED WIDGET-ID 102
          LABEL "Renov"
          VIEW-AS FILL-IN NATIVE 
          SIZE 5 BY 1 TOOLTIP "Meses de la renovacion a partir de la realizacion"
          BGCOLOR 15 FGCOLOR 9 
     v-cdg_condicion_impos AT ROW 3.38 COL 48 COLON-ALIGNED WIDGET-ID 16
     v-dsc_condicion_impos AT ROW 3.38 COL 55 COLON-ALIGNED HELP
          "Denominacion" NO-LABEL WIDGET-ID 12
     Contrato_hd.modo_facturacion AT ROW 3.38 COL 96 COLON-ALIGNED
          LABEL "Modo"
          VIEW-AS COMBO-BOX INNER-LINES 5
          LIST-ITEM-PAIRS "Mensual","1",
                     "Bimensual","2",
                     "Trimestral","3",
                     "Cuatrimestral","4",
                     "Semestral","6",
                     "9 Meses","9",
                     "Anual","12"
          DROP-DOWN-LIST
          SIZE 24.8 BY 1
          BGCOLOR 15 FGCOLOR 9 
     v-dsc_vendedor AT ROW 4.38 COL 91 COLON-ALIGNED HELP
          "Denominacion" NO-LABEL
     v-cdg_condicion_venta AT ROW 4.43 COL 11 COLON-ALIGNED
     v-cdg_vendedor AT ROW 4.43 COL 78.4 COLON-ALIGNED
     v-dsc_condicion_venta AT ROW 4.52 COL 18 COLON-ALIGNED HELP
          "Denominacion" NO-LABEL
     Contrato_hd.garantia AT ROW 4.57 COL 56 WIDGET-ID 118
          LABEL "Garantia"
          VIEW-AS TOGGLE-BOX
          SIZE 16 BY .81 TOOLTIP "Si incluye clausula de garantia"
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1 SCROLLABLE .

/* DEFINE FRAME statement is approaching 4K Bytes.  Breaking it up   */
DEFINE FRAME F-Main
     Contrato_hd.primer_mes AT ROW 6.29 COL 11 COLON-ALIGNED
          LABEL "Mes(1)"
          VIEW-AS FILL-IN NATIVE 
          SIZE 4.8 BY 1
          BGCOLOR 15 FGCOLOR 9 
     Contrato_hd.primer_ano AT ROW 6.29 COL 30 COLON-ALIGNED
          LABEL "Año(1)"
          VIEW-AS FILL-IN NATIVE 
          SIZE 7.6 BY 1
          BGCOLOR 15 FGCOLOR 9 
     Contrato_hd.cant_periodos AT ROW 6.29 COL 58 COLON-ALIGNED
          LABEL "Cant.Períodos" FORMAT ">>9"
          VIEW-AS FILL-IN NATIVE 
          SIZE 9 BY 1
          BGCOLOR 15 FGCOLOR 9 
     Contrato_hd.fecha_alta AT ROW 6.29 COL 79 COLON-ALIGNED
          LABEL "Alta"
          VIEW-AS FILL-IN NATIVE 
          SIZE 16 BY 1
          BGCOLOR 15 FGCOLOR 9 
     Contrato_hd.fecha_baja AT ROW 6.29 COL 104 COLON-ALIGNED
          LABEL "Baja"
          VIEW-AS FILL-IN NATIVE 
          SIZE 16 BY 1 TOOLTIP "Presione boton secundario para mas opciones"
          BGCOLOR 15 FGCOLOR 9 
     Contrato_hd.ultimo_mes AT ROW 7.19 COL 11 COLON-ALIGNED
          LABEL "Mes"
          VIEW-AS FILL-IN NATIVE 
          SIZE 4.8 BY 1
          BGCOLOR 15 FGCOLOR 9 
     Contrato_hd.ultimo_ano AT ROW 7.19 COL 30 COLON-ALIGNED
          LABEL "Año"
          VIEW-AS FILL-IN NATIVE 
          SIZE 7.6 BY 1
          BGCOLOR 15 FGCOLOR 9 
     Contrato_hd.resto_periodos AT ROW 7.19 COL 58 COLON-ALIGNED
          LABEL "Restan Periodos"
          VIEW-AS FILL-IN NATIVE 
          SIZE 9 BY 1
          BGCOLOR 15 FGCOLOR 9 
     Contrato_hd.rige_desde AT ROW 7.19 COL 79 COLON-ALIGNED
          VIEW-AS FILL-IN NATIVE 
          SIZE 16 BY 1
          BGCOLOR 15 FGCOLOR 9 
     Contrato_hd.rige_hasta AT ROW 7.19 COL 104 COLON-ALIGNED
          VIEW-AS FILL-IN NATIVE 
          SIZE 16 BY 1
          BGCOLOR 15 FGCOLOR 9 
     Bcta-cte AT ROW 8.43 COL 114.2 WIDGET-ID 44
     Bleyenda-2 AT ROW 9.1 COL 119 WIDGET-ID 100
     Contrato_hd.dreminder AT ROW 9.14 COL 110 COLON-ALIGNED WIDGET-ID 98
          LABEL "DiasRem"
          VIEW-AS FILL-IN NATIVE 
          SIZE 5.4 BY 1 TOOLTIP "Dias en + o en - de la fecha de asignado"
          BGCOLOR 15 FGCOLOR 9 
     Contrato_hd.Reminder AT ROW 9.19 COL 10.8 COLON-ALIGNED WIDGET-ID 96 FORMAT "x(400)"
          VIEW-AS FILL-IN 
          SIZE 88.2 BY 1 TOOLTIP "Reminder aviso desplegable"
          BGCOLOR 15 FGCOLOR 9 
     Contrato_hd.leyAdicional AT ROW 10.29 COL 2 NO-LABEL WIDGET-ID 120
          VIEW-AS EDITOR SCROLLBAR-VERTICAL LARGE
          SIZE 121 BY 2.14 TOOLTIP "Leyenda Adicional aparece el presupuesto impreso"
     Contrato_hd.imp_total AT ROW 8.48 COL 6 COLON-ALIGNED WIDGET-ID 4
          LABEL "Total" FORMAT ">>>>>9.9"
           VIEW-AS TEXT 
          SIZE 11 BY .62
     v-facturado AT ROW 8.52 COL 20 WIDGET-ID 30
     v-pagado AT ROW 8.52 COL 37.8 WIDGET-ID 32
     v-anticipos AT ROW 8.52 COL 61.4 WIDGET-ID 34
     v-cuota1 AT ROW 8.52 COL 77.6 WIDGET-ID 104
     v-cuotas AT ROW 8.52 COL 96.6 WIDGET-ID 36
     "                                FACTURACION" VIEW-AS TEXT
          SIZE 56 BY .52 AT ROW 5.71 COL 13
          BGCOLOR 5 FGCOLOR 15 
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1 SCROLLABLE .

/* DEFINE FRAME statement is approaching 4K Bytes.  Breaking it up   */
DEFINE FRAME F-Main
     "                               VIGENCIA" VIEW-AS TEXT
          SIZE 49 BY .52 AT ROW 5.71 COL 73
          BGCOLOR 5 FGCOLOR 15 
     RECT-19 AT ROW 5.52 COL 71 WIDGET-ID 22
     RECT-20 AT ROW 5.52 COL 2.8 WIDGET-ID 24
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1 SCROLLABLE .


/* *********************** Procedure Settings ************************ */

&ANALYZE-SUSPEND _PROCEDURE-SETTINGS
/* Settings for THIS-PROCEDURE
   Type: SmartViewer
   External Tables: sic.Contrato_hd,sic.Cliente
   Allow: Basic,DB-Fields
   Frames: 1
   Add Fields to: EXTERNAL-TABLES
   Other Settings: PERSISTENT-ONLY COMPILE
   Temp-Tables and Buffers:
      TABLE: Administrador B "?" ? sic Cliente
   END-TABLES.
 */

/* This procedure should always be RUN PERSISTENT.  Report the error,  */
/* then cleanup and return.                                            */
IF NOT THIS-PROCEDURE:PERSISTENT THEN DO:
  MESSAGE "{&FILE-NAME} should only be RUN PERSISTENT.":U
          VIEW-AS ALERT-BOX ERROR BUTTONS OK.
  RETURN.
END.

&ANALYZE-RESUME _END-PROCEDURE-SETTINGS

/* *************************  Create Window  ************************** */

&ANALYZE-SUSPEND _CREATE-WINDOW
/* DESIGN Window definition (used by the UIB) 
  CREATE WINDOW V-table-Win ASSIGN
         HEIGHT             = 11.62
         WIDTH              = 125.
/* END WINDOW DEFINITION */
                                                                        */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _INCLUDED-LIB V-table-Win 
/* ************************* Included-Libraries *********************** */

{src/adm/method/viewer.i}

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME




/* ***********  Runtime Attributes and AppBuilder Settings  *********** */

&ANALYZE-SUSPEND _RUN-TIME-ATTRIBUTES
/* SETTINGS FOR WINDOW V-table-Win
  VISIBLE,,RUN-PERSISTENT                                               */
/* SETTINGS FOR FRAME F-Main
   NOT-VISIBLE FRAME-NAME Size-to-Fit                                   */
ASSIGN 
       FRAME F-Main:SCROLLABLE       = FALSE
       FRAME F-Main:HIDDEN           = TRUE.

/* SETTINGS FOR BUTTON Bcta-cte IN FRAME F-Main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN Contrato_hd.cant_periodos IN FRAME F-Main
   EXP-LABEL EXP-FORMAT                                                 */
/* SETTINGS FOR FILL-IN Contrato_hd.dreminder IN FRAME F-Main
   EXP-LABEL                                                            */
/* SETTINGS FOR COMBO-BOX Contrato_hd.estado IN FRAME F-Main
   EXP-LABEL                                                            */
/* SETTINGS FOR FILL-IN Contrato_hd.fecha_alta IN FRAME F-Main
   EXP-LABEL                                                            */
/* SETTINGS FOR FILL-IN Contrato_hd.fecha_baja IN FRAME F-Main
   EXP-LABEL                                                            */
ASSIGN 
       Contrato_hd.fecha_baja:POPUP-MENU IN FRAME F-Main       = MENU POPUP-MENU-fecha_baja:HANDLE
       Contrato_hd.fecha_baja:READ-ONLY IN FRAME F-Main        = TRUE.

/* SETTINGS FOR TOGGLE-BOX Contrato_hd.garantia IN FRAME F-Main
   EXP-LABEL                                                            */
/* SETTINGS FOR FILL-IN Contrato_hd.imp_total IN FRAME F-Main
   EXP-LABEL EXP-FORMAT                                                 */
ASSIGN 
       Contrato_hd.imp_total:READ-ONLY IN FRAME F-Main        = TRUE.

/* SETTINGS FOR COMBO-BOX Contrato_hd.modo_facturacion IN FRAME F-Main
   EXP-LABEL                                                            */
/* SETTINGS FOR FILL-IN Contrato_hd.nro_plazo IN FRAME F-Main
   EXP-LABEL                                                            */
/* SETTINGS FOR COMBO-BOX Contrato_hd.nro_tipo_evento IN FRAME F-Main
   EXP-LABEL                                                            */
/* SETTINGS FOR FILL-IN Contrato_hd.numero_eventos IN FRAME F-Main
   EXP-LABEL                                                            */
/* SETTINGS FOR FILL-IN Contrato_hd.num_contrato IN FRAME F-Main
   NO-ENABLE EXP-LABEL                                                  */
/* SETTINGS FOR COMBO-BOX prf IN FRAME F-Main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN Contrato_hd.primer_ano IN FRAME F-Main
   EXP-LABEL                                                            */
/* SETTINGS FOR FILL-IN Contrato_hd.primer_mes IN FRAME F-Main
   EXP-LABEL                                                            */
/* SETTINGS FOR FILL-IN Contrato_hd.Reminder IN FRAME F-Main
   EXP-FORMAT                                                           */
/* SETTINGS FOR FILL-IN Contrato_hd.resto_periodos IN FRAME F-Main
   EXP-LABEL                                                            */
ASSIGN 
       Contrato_hd.rige_hasta:POPUP-MENU IN FRAME F-Main       = MENU POPUP-MENU-rige_hasta:HANDLE.

/* SETTINGS FOR FILL-IN Contrato_hd.titulo IN FRAME F-Main
   EXP-LABEL EXP-FORMAT                                                 */
/* SETTINGS FOR FILL-IN Contrato_hd.ultimo_ano IN FRAME F-Main
   NO-ENABLE EXP-LABEL                                                  */
ASSIGN 
       Contrato_hd.ultimo_ano:READ-ONLY IN FRAME F-Main        = TRUE.

/* SETTINGS FOR FILL-IN Contrato_hd.ultimo_mes IN FRAME F-Main
   NO-ENABLE EXP-LABEL                                                  */
ASSIGN 
       Contrato_hd.ultimo_mes:READ-ONLY IN FRAME F-Main        = TRUE.

/* SETTINGS FOR FILL-IN v-anticipos IN FRAME F-Main
   ALIGN-L                                                              */
ASSIGN 
       v-anticipos:READ-ONLY IN FRAME F-Main        = TRUE.

/* SETTINGS FOR FILL-IN v-cdg_condicion_venta IN FRAME F-Main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN v-cuota1 IN FRAME F-Main
   ALIGN-L                                                              */
ASSIGN 
       v-cuota1:READ-ONLY IN FRAME F-Main        = TRUE.

/* SETTINGS FOR FILL-IN v-cuotas IN FRAME F-Main
   ALIGN-L                                                              */
ASSIGN 
       v-cuotas:READ-ONLY IN FRAME F-Main        = TRUE.

/* SETTINGS FOR FILL-IN v-dsc_condicion_impos IN FRAME F-Main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN v-dsc_condicion_venta IN FRAME F-Main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN v-dsc_vendedor IN FRAME F-Main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN v-facturado IN FRAME F-Main
   ALIGN-L                                                              */
ASSIGN 
       v-facturado:READ-ONLY IN FRAME F-Main        = TRUE.

/* SETTINGS FOR FILL-IN v-pagado IN FRAME F-Main
   ALIGN-L                                                              */
ASSIGN 
       v-pagado:READ-ONLY IN FRAME F-Main        = TRUE.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME


/* Setting information for Queries and Browse Widgets fields            */

&ANALYZE-SUSPEND _QUERY-BLOCK FRAME F-Main
/* Query rebuild information for FRAME F-Main
     _Options          = "NO-LOCK"
     _Query            is NOT OPENED
*/  /* FRAME F-Main */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME b-alerta
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL b-alerta V-table-Win
ON CHOOSE OF b-alerta IN FRAME F-Main /* Leyenda */
DO:
   DEFINE BUFFER bcontrato_hd FOR contrato_hd.
  RUN d-editorstr.w (INPUT-OUTPUT v-leyenda,TRUE ).
   IF contrato_hd.nro_contrato <> 0 THEN DO:
       FIND bcontrato_hd WHERE recid(bcontrato_hd) = recid(contrato_hd).
       ASSIGN bcontrato_hd.leyenda = v-leyenda.
   END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME b-observ
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL b-observ V-table-Win
ON CHOOSE OF b-observ IN FRAME F-Main /* Observ */
DO:
   DEFINE BUFFER bcontrato_hd FOR contrato_hd.
   DEFINE VARIABLE puso_ok AS LOGICAL.
   RUN c-edttexto-avanzado.w ( INPUT-OUTPUT v-vobservacion,
                      INPUT "Observaciónes Interna del Contrato",
                      INPUT 2, /* en RW siempre */
                      OUTPUT puso_ok).
   IF NOT puso_ok THEN RETURN NO-APPLY.
   IF contrato_hd.nro_contrato <> 0 THEN DO:
       FIND bcontrato_hd WHERE recid(bcontrato_hd) = recid(contrato_hd).
       ASSIGN bcontrato_hd.observacion = v-vobservacion.
   END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME Bcta-cte
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Bcta-cte V-table-Win
ON CHOOSE OF Bcta-cte IN FRAME F-Main /* Cta-Cte */
DO:
  RUN w-ctacte-contrato.w PERSISTENT SET hcta_cte.
  RUN add-link IN adm-broker-hdl ( THIS-PROCEDURE , "record", hcta_cte).
  RUN dispatch IN hcta_cte("initialize").
  RUN dispatch IN THIS-PROCEDURE ('row-changed':U).
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME Bleyenda-2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Bleyenda-2 V-table-Win
ON CHOOSE OF Bleyenda-2 IN FRAME F-Main /* Bleyenda 2 */
DO:
    DEFINE VAR aedit AS CHAR NO-UNDO.
  aedit = contrato_hd.reminder:SCREEN-VALUE.
  RUN d-editorstr.w (INPUT-OUTPUT aedit,contrato_hd.reminder:SENSITIVE ).
  contrato_hd.reminder:SCREEN-VALUE = aedit.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME B_email
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL B_email V-table-Win
ON CHOOSE OF B_email IN FRAME F-Main /* Email */
DO:
    DEFINE VAR ReportePath AS CHAR NO-UNDO.
    FIND tipo_evento WHERE tipo_evento.nro_tipo_evento = INPUT contrato_hd.nro_tipo_evento NO-LOCK NO-ERROR.
    IF NOT AVAILABLE tipo_evento  THEN DO:
        MESSAGE "Este tipo de evento no genera presupuesto" VIEW-AS ALERT-BOX INFORMATION.
        RETURN NO-APPLY.
    END.
    ReportePath = entry(1,tipo_evento.template,".").
    RUN fullPath (ReportePath, '.rpt':U, OUTPUT ReportePath).
    IF ReportePath = ? THEN DO:
            MESSAGE "No se puede imprimir este contrato como un presupuesto" SKIP 
                    "verifique el tipo de contrato y los demas datos" VIEW-AS ALERT-BOX INFORMATION.
            RETURN NO-APPLY.
    END.
    RUN d-email_contrato.w ( contrato_hd.nro_contrato ).
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME b_presup
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL b_presup V-table-Win
ON CHOOSE OF b_presup IN FRAME F-Main /* Presup */
DO:
    DEFINE VAR ReportePath AS CHAR NO-UNDO.
    FIND tipo_evento WHERE tipo_evento.nro_tipo_evento = INPUT contrato_hd.nro_tipo_evento NO-LOCK NO-ERROR.
    IF NOT AVAILABLE tipo_evento  THEN DO:
        MESSAGE "Este tipo de evento no genera presupuesto"VIEW-AS ALERT-BOX INFORMATION.
        RETURN NO-APPLY.
    END.
    ReportePath = entry(1,tipo_evento.template,".").
    RUN fullPath (ReportePath, '.rpt':U, OUTPUT ReportePath).
    IF ReportePath = ? THEN DO:
            MESSAGE "No se puede imprimir este contrato como un presupuesto" SKIP 
                    "verifique el tipo de contrato y los demas datos" VIEW-AS ALERT-BOX INFORMATION.
            RETURN NO-APPLY.
    END.
  RUN imprepresu(contrato_hd.nro_contrato).
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME b_renov
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL b_renov V-table-Win
ON CHOOSE OF b_renov IN FRAME F-Main /* Renovar */
DO:
    DEFINE VAR pcontrato LIKE contrato_hd.nro_contrato.
    pcontrato = contrato_hd.nro_contrato.
    IF contrato_hd.fecha_baja = ? AND
        contrato_hd.resto_periodos <> 0 THEN DO:
        MESSAGE "No se puede renovar un contrato que no esta de baja o no esta terminado" VIEW-AS ALERT-BOX ERROR.
        RETURN NO-APPLY.
    END.
    RUN d-renov_contrato.w( INPUT-OUTPUT pcontrato ).
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME b_rest
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL b_rest V-table-Win
ON CHOOSE OF b_rest IN FRAME F-Main /* Rest */
DO:
  IF AVAILABLE contrato_hd THEN
      IF INPUT contrato_hd.num_contrato = 0 THEN DO:
          MESSAGE "Grabe primero el contrato antes de establecer las restricciones" VIEW-AS ALERT-BOX INFORMATION.
          RETURN NO-APPLY.
      END.
      RUN d-contrato_restriccion.w ( INPUT contrato_hd.num_contrato ).
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME Contrato_hd.estado
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Contrato_hd.estado V-table-Win
ON VALUE-CHANGED OF Contrato_hd.estado IN FRAME F-Main /* St. */
DO:
  DEFINE VAR k AS INT NO-UNDO.
DEFINE VAR ddd AS DATE NO-UNDO.
DEFINE VAR hhh AS DATE NO-UNDO.
DEFINE VAR hhh1 AS DATE NO-UNDO.
IF contrato_hd.cant_periodos = 0 THEN DO:
       ddd = IF contrato_hd.ultimo_mes = 0 THEN date(month(contrato_hd.rige_desde) , 1 ,YEAR(contrato_hd.rige_desde)) ELSE date(contrato_hd.ultimo_mes , 1 ,contrato_hd.ultimo_ano).
       hhh1 = date( month( ddd + 32 ) , 1, year( ddd + 32 )) - 1.
END.
ELSE DO:
    ddd = date(month(contrato_hd.rige_desde) , 1 ,YEAR(contrato_hd.rige_desde)).
    hhh1 = 1/1/2999.
END.
hhh = date( month( ddd + 32 ) , 1, year( ddd + 32 )) - 1.
  IF INPUT contrato_hd.estado = "A" THEN DO:
      FIND persona OF contrato_hd NO-LOCK.
          IF NOT AVAILABLE persona THEN do:
            MESSAGE "Este cliente no tiene direccion de email, en el contacto con PR en el canal-email  rra enviar el presupuesto" SKIP
                    "corrija esta situacion antes de proseguir con la aprobacion"
                VIEW-AS ALERT-BOX ERROR.
                RETURN NO-APPLY.
      END.
  END.
  IF contrato_hd.estado = "A" AND INPUT contrato_hd.estado = "P" THEN DO:
        DO k = 1 TO contrato_hd.numero_eventos:
            FIND FIRST evento NO-LOCK WHERE evento.origen = "contrato" AND evento.nro_identificacion = contrato_hd.nro_contrato 
           AND evento.sub_evento = k AND NOT evento.anulado AND
           evento.fmin >= ddd AND evento.fmax <= hhh1 NO-ERROR.
           IF AVAILABLE evento THEN DO:
                MESSAGE "No puede pasar el contrato a ese estado anule los eventos antes de hacerlo"
                        VIEW-AS ALERT-BOX ERROR.
                RETURN NO-APPLY.
           END.
        END.
  END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME Contrato_hd.fecha_baja
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Contrato_hd.fecha_baja V-table-Win
ON LEAVE OF Contrato_hd.fecha_baja IN FRAME F-Main /* Baja */
DO:
    RUN baja_contrato.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME m_Baja_Contrato
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL m_Baja_Contrato V-table-Win
ON CHOOSE OF MENU-ITEM m_Baja_Contrato /* Baja Contrato */
DO:
        contrato_hd.fecha_baja:SCREEN-VALUE IN FRAME {&FRAME-NAME} = string(TODAY).
        RUN baja_contrato.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME m_Calcular_Fecha
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL m_Calcular_Fecha V-table-Win
ON CHOOSE OF MENU-ITEM m_Calcular_Fecha /* Calcular Fecha */
DO:
  DO WITH FRAME {&FRAME-NAME}:
      DEF VAR mm AS INT NO-UNDO.
      DEF VAR yy AS INT NO-UNDO.
              yy = YEAR(date(contrato_hd.rige_desde:SCREEN-VALUE)).
              mm = MONTH(date(contrato_hd.rige_desde:SCREEN-VALUE)) + int(contrato_hd.cant_periodos:SCREEN-VALUE) .
              IF mm > 12 THEN DO:
                 yy = yy  + 1.
                 mm = mm - 12 .
              END.
              contrato_hd.rige_hasta:SCREEN-VALUE = string(DATE( mm , 1 , yy ) - 1 ).
  END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME m_Motivo_de_Baja
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL m_Motivo_de_Baja V-table-Win
ON CHOOSE OF MENU-ITEM m_Motivo_de_Baja /* Motivo de Baja */
DO:
   DEFINE VARIABLE puso_ok AS LOGICAL.
   RUN c-edttexto-avanzado.w ( INPUT-OUTPUT v-motivo_baja,
                                        INPUT "Motivo de Baja del Contrato",
                                        INPUT 0,
                                        OUTPUT puso_ok).
   RETURN NO-APPLY.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME Contrato_hd.nro_tipo_evento
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Contrato_hd.nro_tipo_evento V-table-Win
ON VALUE-CHANGED OF Contrato_hd.nro_tipo_evento IN FRAME F-Main /* TipoEV */
DO:

IF contrato_hd.nro_contrato <> 0 THEN DO:
  FIND tipo_evento WHERE tipo_evento.nro_tipo_evento = contrato_hd.nro_tipo_evento.
  FIND FIRST evento WHERE evento.nro_identificacion = contrato_hd.nro_contrato AND 
      evento.origen = tipo_evento.origen AND
      NOT evento.fasignado<>? AND
      NOT evento.anulado AND 
      NOT evento.frealizado<>? NO-ERROR.
  IF AVAILABLE evento THEN DO:
      MESSAGE "No puede mofificar el tipo de evento sin antes" SKIP
          "anular o eliminar los eventos de las acciones pendientes" SKIP
          "verifique....." VIEW-AS ALERT-BOX ERROR.
      RETURN NO-APPLY.
  END.
END.
FIND canal WHERE sic.canal.nro_tipo_evento = INPUT FRAME {&FRAME-NAME} contrato_hd.nro_tipo_evento AND
         canal.nro_cliente = cliente.nro_admin AND canal.cdg_puntovta =  INPUT FRAME {&FRAME-NAME} prf NO-LOCK NO-ERROR.
IF NOT AVAILABLE canal THEN DO:
    MESSAGE "El punto de venta no es el habitual para este administrador" VIEW-AS ALERT-BOX ERROR.
    RETURN NO-APPLY.
END.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME Contrato_hd.rige_desde
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Contrato_hd.rige_desde V-table-Win
ON MOUSE-MENU-CLICK OF Contrato_hd.rige_desde IN FRAME F-Main /* Desde */
DO:
  {selfecha.i}
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME Contrato_hd.rige_hasta
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Contrato_hd.rige_hasta V-table-Win
ON MOUSE-MENU-CLICK OF Contrato_hd.rige_hasta IN FRAME F-Main /* Hasta */
DO:
  {selfecha.i}
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME Contrato_hd.suspendido
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Contrato_hd.suspendido V-table-Win
ON VALUE-CHANGED OF Contrato_hd.suspendido IN FRAME F-Main /* Susp. */
DO:
  DEFINE VAR sidesa AS LOGICAL NO-UNDO.
  FOR EACH evento WHERE evento.frealizado = ? AND NOT evento.anulado AND
      evento.nro_identificacion = contrato_hd.nro_contrato AND
      evento.origen = "CONTRATO":
      evento.observacion = agregaAdvTexto("Suspendido CTO Desasignado" + string(evento.fasignado) , evento.observacion ).
      evento.fasignado = ?.
      evento.evaluar = FALSE.
      sidesa = TRUE.
      FOR EACH recurso_agenda OF evento:
          DELETE recurso_agenda.
      END.
  END.
  MESSAGE "Se han desasignado los eventos pendientes de este contrato"
      VIEW-AS ALERT-BOX INFORMATION.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME v-cdg_condicion_impos
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-cdg_condicion_impos V-table-Win
ON MOUSE-SELECT-DBLCLICK OF v-cdg_condicion_impos IN FRAME F-Main /* Cond.Impos. */
OR "." OF v-cdg_condicion_impos IN FRAME {&FRAME-NAME}
OR MOUSE-MENU-DOWN OF v-cdg_condicion_impos IN FRAME {&FRAME-NAME}
DO:

   {helptabla.i "Condicion_impos" "cdg_condiva" "SELCNDIV-V.P"}
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-cdg_condicion_impos V-table-Win
ON RETURN OF v-cdg_condicion_impos IN FRAME F-Main /* Cond.Impos. */
DO:
   {traducetabla.i "Condicion_impos" "cdg_condiva" "descripcion"} 
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME v-cdg_condicion_venta
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-cdg_condicion_venta V-table-Win
ON MOUSE-SELECT-DBLCLICK OF v-cdg_condicion_venta IN FRAME F-Main /* C. Venta */
OR "." OF v-cdg_condicion_venta IN FRAME {&FRAME-NAME}
OR MOUSE-MENU-DOWN OF v-cdg_condicion_venta IN FRAME {&FRAME-NAME}
DO:
   {helptabla.i "Condicion_venta" "cdg_cndventa" "SELCNDVN.P"}
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-cdg_condicion_venta V-table-Win
ON RETURN OF v-cdg_condicion_venta IN FRAME F-Main /* C. Venta */
DO:
   {traducetabla.i "Condicion_venta" "cdg_cndventa" "descripcion"} 
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME v-cdg_vendedor
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-cdg_vendedor V-table-Win
ON MOUSE-SELECT-DBLCLICK OF v-cdg_vendedor IN FRAME F-Main /* Vend. */
OR "." OF v-cdg_vendedor IN FRAME {&FRAME-NAME}
OR MOUSE-MENU-DOWN OF v-cdg_vendedor IN FRAME {&FRAME-NAME}
DO:
   {helptabla.i "Vendedor" "cdg_vendedor" "SELVENDR.P"}
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-cdg_vendedor V-table-Win
ON RETURN OF v-cdg_vendedor IN FRAME F-Main /* Vend. */
DO:
   {traducetabla.i "Vendedor" "cdg_vendedor" "nombre"} 
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&UNDEFINE SELF-NAME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _MAIN-BLOCK V-table-Win 


/* ***************************  Main Block  *************************** */

  &IF DEFINED(UIB_IS_RUNNING) <> 0 &THEN          
    RUN dispatch IN THIS-PROCEDURE ('initialize':U).        
  &ENDIF         
  
  /************************ INTERNAL PROCEDURES ********************/

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


/* **********************  Internal Procedures  *********************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE adm-find-using-key V-table-Win  adm/support/_key-fnd.p
PROCEDURE adm-find-using-key :
/*------------------------------------------------------------------------------
  Purpose:     Finds the current record using the contents of
               the 'Key-Name' and 'Key-Value' attributes.
  Parameters:  <none>
------------------------------------------------------------------------------*/
  DEF VAR key-value AS CHAR NO-UNDO.
  DEF VAR row-avail-enabled AS LOGICAL NO-UNDO.

  /* LOCK status on the find depends on FIELDS-ENABLED. */
  RUN get-attribute ('FIELDS-ENABLED':U).
  row-avail-enabled = (RETURN-VALUE eq 'yes':U).
  /* Look up the current key-value. */
  RUN get-attribute ('Key-Value':U).
  key-value = RETURN-VALUE.

  /* Find the current record using the current Key-Name. */
  RUN get-attribute ('Key-Name':U).
  CASE RETURN-VALUE:
    WHEN 'nro_contrato':U THEN
       {src/adm/template/find-tbl.i
           &TABLE = Contrato_hd
           &WHERE = "WHERE Contrato_hd.nro_contrato eq INTEGER(key-value)"
       }
    WHEN 'cdg_empresa':U THEN
       {src/adm/template/find-tbl.i
           &TABLE = Contrato_hd
           &WHERE = "WHERE Contrato_hd.cdg_empresa eq key-value"
       }
  END CASE.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE adm-row-available V-table-Win  _ADM-ROW-AVAILABLE
PROCEDURE adm-row-available :
/*------------------------------------------------------------------------------
  Purpose:     Dispatched to this procedure when the Record-
               Source has a new row available.  This procedure
               tries to get the new row (or foriegn keys) from
               the Record-Source and process it.
  Parameters:  <none>
------------------------------------------------------------------------------*/

  /* Define variables needed by this internal procedure.             */
  {src/adm/template/row-head.i}

  /* Create a list of all the tables that we need to get.            */
  {src/adm/template/row-list.i "Contrato_hd"}
  {src/adm/template/row-list.i "Cliente"}

  /* Get the record ROWID's from the RECORD-SOURCE.                  */
  {src/adm/template/row-get.i}

  /* FIND each record specified by the RECORD-SOURCE.                */
  {src/adm/template/row-find.i "Contrato_hd"}
  {src/adm/template/row-find.i "Cliente"}

  /* Process the newly available records (i.e. display fields,
     open queries, and/or pass records on to any RECORD-TARGETS).    */
  {src/adm/template/row-end.i}

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE baja_contrato V-table-Win 
PROCEDURE baja_contrato :
/*------------------------------------------------------------------------------
  Purpose:  al querer dar de baja anticipara de un contrato   
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
      DEFINE VAR v-motivo_baja_ant AS CHAR NO-UNDO.
      DEFINE VARIABLE puso_ok AS LOGICAL.
      DEFINE VAR ss AS character NO-UNDO.
      DEFINE VAR ss1 AS character NO-UNDO.
      DEFINE VAR ss2 AS character NO-UNDO.
      DEFINE VAR ss3 AS character NO-UNDO.
      DEF VAR patron AS CHAR NO-UNDO.
      DEFINE BUFFER bcontrato_hd FOR contrato_hd.
      DEFINE BUFFER bevento FOR evento.

      sino-msg = NO.
      RUN mensajepregunta.p ( INPUT "",INPUT "CPY004", INPUT-OUTPUT sino-msg ). 
      IF NOT sino-msg THEN do:
          contrato_hd.fecha_baja:SCREEN-VALUE IN FRAME {&FRAME-NAME} =  ?.
          RETURN ERROR.
      END.
      v-motivo_baja_ant = v-motivo_baja.
      REPEAT:
          RUN c-edttexto-avanzado.w ( INPUT-OUTPUT v-motivo_baja ,
                                               INPUT "Motivo de Baja del Contrato",
                                               INPUT 0,
                                               OUTPUT puso_ok).
          IF NOT puso_ok THEN DO:
              contrato_hd.fecha_baja:SCREEN-VALUE IN FRAME {&FRAME-NAME} =  ?.
              RETURN ERROR.
          END.
          IF v-motivo_baja <> v-motivo_baja_ant THEN LEAVE.
          ELSE
              MESSAGE "Es obligatorio aclarar las razones " SKIP "de porque se da de baja el contrato" VIEW-AS ALERT-BOX ERROR.
      END.
      
      IF INPUT Contrato_hd.fecha_baja <> ? THEN DO:
          FIND tipo_evento WHERE tipo_evento.nro_tipo_evento = INPUT contrato_hd.nro_tipo_evento.
          FIND FIRST evento WHERE evento.nro_identificacion = contrato_hd.nro_contrato AND 
              evento.origen = "CONTRATO" AND
              NOT evento.anulado AND 
              evento.periodo = year(Contrato_hd.fecha_baja ) * 100 + month(Contrato_hd.fecha_baja) AND
              evento.frealizado<>? NO-ERROR.
          IF AVAILABLE evento THEN DO:
              MESSAGE "No puede dar de daja el contrato en esta fecha" SKIP
                  "existen eventos realizados ej:" evento.nro_evento
                  VIEW-AS ALERT-BOX ERROR.
              RETURN ERROR.
          END.
          /*Se anulan los eventos no asignados a futuros y los relacionados con estos*/
          FOR each evento WHERE evento.nro_identificacion = contrato_hd.nro_contrato AND 
                    evento.origen = tipo_evento.origen AND
                    NOT evento.anulado AND 
                    evento.frealizado=?:
              FOR EACH bevento WHERE bevento.nro_identificacion = evento.nro_evento AND 
                        bevento.origen = "AVISO" AND bevento.frealizado = ? AND NOT  bevento.anulado:
                  FOR EACH recurso_agenda WHERE recurso_agenda.nro_evento = bevento.nro_evento:
                    DELETE recurso_agenda.
                  END.
                  ASSIGN
                            bevento.anulado = TRUE
                            bevento.observacion = "Anulado por baja anticipada de contrato el dia " + STRING(Contrato_hd.fecha_baja).
              END.
              ASSIGN
                evento.anulado = TRUE
                evento.observacion = agregaAdvTexto("Anulado por baja anticipada de contrato el dia " + STRING(Contrato_hd.fecha_baja),evento.observacion).
              FOR EACH recurso_agenda WHERE recurso_agenda.nro_evento = evento.nro_evento:
                          DELETE recurso_agenda.
              END.
          END.
          /*anulamos facturas no cobradas del contrato de fecha >= fecha_baja*/
          EMPTY TEMP-TABLE tcredito.
          FOR EACH fac_header NO-LOCK  WHERE fac_header.nro_contrato = contrato_hd.nro_contrato AND
              YEAR(fac_header.fecha) * 100 + MONTH(fac_header.fecha) >= year(Contrato_hd.fecha_baja) * 100 + MONTH(Contrato_hd.fecha_baja) .
              CREATE tcredito.
              ASSIGN tcredito.rid = ROWID(fac_header).
          END.
          FIND FIRST tcredito NO-ERROR.
         /* TERMINAR  IF AVAILABLE tcredito THEN
             RUN crear_creditos.p(INPUT TABLE tcredito).*/


          /*FOR EACH tarea WHERE tarea.nro_identificacion = contrato_hd.nro_contrato AND
              tarea.origen = "CONTRATO" AND tarea.estado <> "A":
              tarea.estado = "B".
              tarea.descripcion = agregaAdvTexto("Tarea reabierta por sistema al anular el contrato",tarea.descripcion).
          END.*/

          /*padres e hijos*/
          ss = "".
          ss2 = "".
          ss1 = "".
          ss3 = "".
          patron = STRING(contrato_hd.nro_contrato) + "|".
          FOR EACH restriccion NO-LOCK WHERE restriccion.cdg_restriccion BEGINS "BLOQ" :
            FOR EACH contrato_restriccion NO-LOCK WHERE contrato_restriccion.nro_restriccion = restriccion.nro_restriccion AND
             contrato_restriccion.valor BEGINS patron:
                FIND bcontrato_hd where contrato_restriccion.nro_contrato = bcontrato_hd.nro_contrato NO-LOCK NO-ERROR.
                IF AVAILABLE bcontrato_hd THEN
                    IF NOT bcontrato_hd.anulado AND ( bcontrato_hd.fecha_baja >= TODAY OR bcontrato_hd.fecha_baja = ? ) THEN
                      ss = ss + "," + string(contrato_restriccion.nro_contrato) + "|" + string(sic.Contrato_Restriccion.sub_evento).
            END.
            FOR each contrato_restriccion WHERE contrato_restriccion.nro_contrato = contrato_hd.nro_contrato AND
             contrato_restriccion.nro_restriccion = restriccion.nro_restriccion:
                 ss2 = ss2 + "," + valor.
            END.
          END.
          ss1 = "".
          patron = STRING(contrato_hd.nro_contrato) + "|".
          FOR EACH restriccion NO-LOCK WHERE restriccion.cdg_restriccion BEGINS "dfEV":
            FOR EACH contrato_restriccion NO-LOCK WHERE contrato_restriccion.nro_restriccion = restriccion.nro_restriccion AND
             contrato_restriccion.valor BEGINS patron:
                FIND bcontrato_hd where contrato_restriccion.nro_contrato = bcontrato_hd.nro_contrato NO-LOCK NO-ERROR.
                IF AVAILABLE bcontrato_hd THEN
                    IF NOT bcontrato_hd.anulado AND ( bcontrato_hd.fecha_baja >= TODAY OR bcontrato_hd.fecha_baja = ? ) THEN
                      ss1 = ss1 + "," + string(contrato_restriccion.nro_contrato) + "|" + string(sic.Contrato_Restriccion.sub_evento).
            END.
            FOR each contrato_restriccion WHERE contrato_restriccion.nro_contrato = contrato_hd.nro_contrato AND
             contrato_restriccion.nro_restriccion = restriccion.nro_restriccion:
             ss3 = ss3 + "," + valor.
            END.
          END.
          ss = IF ss <> "" THEN SUBSTRING(ss,2) ELSE "".
          ss2 = IF ss2 <> "" THEN SUBSTRING(ss2,2) ELSE "".
          ss1 = IF ss1 <> "" THEN SUBSTRING(ss1,2) ELSE "".
          ss3 = IF ss3 <> "" THEN SUBSTRING(ss3,2) ELSE "".
          
          IF ss <> "" OR ss1 <> "" THEN DO:
              MESSAGE "Este contrato esta ablocado" SKIP
                  IF ss <> "" THEN "Es Padre de: " + ss ELSE "No tiene hijos" SKIP
                  IF ss1 <> "" THEN "Es Padre dfEV de:" + ss1 ELSE "No tiene hijos dfEV" SKIP
                  IF ss2 <> "" THEN "Es Hijo de:" + ss1 ELSE "No tiene padre" SKIP
                  IF ss3 <> "" THEN "Es Hijo dfEV de:" + ss1 ELSE "No tiene padre dfEV" SKIP
                  "Debe eliminar estos ablocamientos para poder base de baja" SKIP
                  "verifique....." VIEW-AS ALERT-BOX ERROR.
              RETURN NO-APPLY.
          END.
  END.

      MENU-ITEM m_Motivo_de_Baja:SENSITIVE IN MENU POPUP-MENU-fecha_baja = TRUE.
      RETURN.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE blockpanel V-table-Win 
PROCEDURE blockpanel :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEFINE INPUT PARAM blk AS LOGICAL NO-UNDO.

RUN get-link-handle IN adm-broker-hdl
    ( INPUT THIS-PROCEDURE,
      INPUT "TableIO-source",
      OUTPUT hcproc ).
    hproc = WIDGET-HANDLE(hcproc).
    IF VALID-HANDLE(hProc) THEN 
    do:
        IF blk THEN
         RUN set-buttons IN hproc ( 'disable-all' ).
        ELSE 
         RUN set-buttons IN hproc ( 'initial' ).
    END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE disable_UI V-table-Win  _DEFAULT-DISABLE
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
  HIDE FRAME F-Main.
  IF THIS-PROCEDURE:PERSISTENT THEN DELETE PROCEDURE THIS-PROCEDURE.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE estado_coutas V-table-Win 
PROCEDURE estado_coutas :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEFINE VAR dcuota1 AS INT NO-UNDO.
RUN ver_cta_cte(INPUT ROWID(contrato_hd), OUTPUT v-facturado , OUTPUT v-pagado ).
    v-anticipos = ver_anticipos().
    dcuota1 = ver_couta1().
    v-cuotas = IF contrato_hd.cant_periodos <> 0 THEN (contrato_hd.imp_total - v-anticipos - dcuota1 ) / contrato_hd.cant_periodos ELSE (contrato_hd.imp_total - v-anticipos ).
    v-cuota1 = dcuota1 + v-cuotas.
    DISPLAY v-facturado v-pagado v-anticipos v-cuotas v-cuota1  WITH FRAME {&FRAME-NAME}.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE imprepresu V-table-Win 
PROCEDURE imprepresu :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEFINE INPUT PARAMETER nro LIKE contrato_hd.nro_contrato.

DEF VAR xfile AS CHAR NO-UNDO.
DEF VAR ReportePath AS CHAR NO-UNDO.
DEF VAR cFullPath AS CHAR NO-UNDO.
DEF VAR xFullPath AS CHAR NO-UNDO.
DEFINE VAR ERROR_nro AS INT NO-UNDO.
DEFINE BUFFER administracion FOR cliente.
DEF VAR exportFileName AS CHAR NO-UNDO.
DEF VAR anticip AS DECIMAL NO-UNDO.
  /*impresion de un presupuesto de contrato*/
    EMPTY TEMP-TABLE tcontrato_hd.
    EMPTY TEMP-TABLE tcontrato_dt.
    FIND contrato_hd WHERE contrato_hd.nro_contrato = nro NO-LOCK.
    FIND tipo_evento OF contrato_hd NO-LOCK NO-ERROR.
    FIND cliente OF contrato_hd NO-LOCK.
    FIND administracion WHERE administracion.nro_cliente = cliente.nro_admin NO-LOCK.
    CREATE tcontrato_hd.
    BUFFER-COPY contrato_hd TO tcontrato_hd.
    tcontrato_hd.direccion = cliente.direccion.
    tcontrato_hd.nombre = cliente.nom_cliente.
    tcontrato_hd.administracion = administracion.nom_cliente.
    tcontrato_hd.DESC_tipoevento = Tipo_evento.Leyenda.
    FOR EACH contrato_dt NO-LOCK OF contrato_hd:
        CREATE tcontrato_dt.
        BUFFER-COPY contrato_dt TO tcontrato_dt.
        IF NOT contrato_dt.solocuota1 THEN DO:
          IF contrato_hd.cant_periodos > 0 THEN DO:
            tcontrato_dt.documental = replace( tcontrato_dt.documental , "&VALOR" , string(tcontrato_dt.subtotal_neto_cf / contrato_hd.cant_periodos,">>>>>.99" )).
            tcontrato_dt.documental = replace( tcontrato_dt.documental , "&CUOTAS" , string( contrato_hd.cant_periodos )).
          END.
          anticip = ver_anticipos().
          IF anticip <> 0 AND contrato_hd.nro_tipo_evento = 3 THEN 
                tcontrato_dt.documental = tcontrato_dt.documental + " , Anticipo de $" + string(anticip,">>>>>9.99") .
        END.
    END.
    tcontrato_hd.total_cuota1_cf = ver_couta1().
    tcontrato_hd.total_anticipo_cf = ver_anticipos().
    tcontrato_hd.cuota_cf = ( contrato_hd.imp_total - tcontrato_hd.total_anticipo_cf ) / contrato_hd.cant_periodos.


    /*ReportePath = "presup_" + STRING( contrato_hd.nro_tipo_evento ).*/

    ReportePath = entry(1,tipo_evento.template,".").
    RUN fullPath (ReportePath, '.rpt':U, OUTPUT cFullPath).
    IF cFullPath = ? 
    THEN DO:
        RUN mensajepar.p (INPUT ReportePath, INPUT "CREP000").
        RETURN ERROR.
    END.
    xfile = TempFile("") + ".xml".
    DATASET dset:WRITE-XML ("FILE", xfile, FALSE,?,"",YES,YES).

    CREATE "CrystalRuntime.Application" chApplication.
    chReport = chApplication:OpenReport(cFullPath, {&crOpenReportByTempCopy}).
    chReport:DiscardSavedData(). /*eliminando lo previamente grabado*/
    RUN fullpath ( INPUT xfile  , INPUT "", OUTPUT xFullPath ).
    chReport:Database:Tables:item(1):setTableLocation(xFullPath, '', '').
    RUN crearReporte(chReport,"rpt",/*ViewReport*/ TRUE,/*PrinterName*/ "",
                 /*exportToDisk*/ FALSE, INPUT-OUTPUT exportFileName ).
    /*IF ERROR-STATUS:ERROR THEN DO:     
        MESSAGE "Existio un problema al generar el reporte" SKIP "no puede continuar" VIEW-AS ALERT-BOX ERROR.
        RETURN NO-APPLY.
    END.*/    
        RELEASE OBJECT chReport. 
        chReport = ?.
        RELEASE OBJECT chApplication.
        chApplication = ?.
      /* RUN borra_temp ( INPUT xfile, OUTPUT ERROR_nro ).*/
    
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE local-add-record V-table-Win 
PROCEDURE local-add-record :
/*------------------------------------------------------------------------------
  Purpose:     Override standard ADM method
  Notes:       
------------------------------------------------------------------------------*/
DEF VAR auxvend as CHAR NO-UNDO.
DEF VAR aux AS INT NO-UNDO.
  /* Code placed here will execute PRIOR to standard behavior. */

  /* Dispatch standard ADM method.                             */
  RUN dispatch IN THIS-PROCEDURE ( INPUT 'add-record':U ) .

  /* Code placed here will execute AFTER standard behavior.    */
   {blanqueacodigo.i "Vendedor"} 
   FIND FIRST vendedor NO-LOCK NO-ERROR.
   IF AVAILABLE vendedor THEN do:
       auxvend = vendedor.cdg_vendedor.
       FIND NEXT vendedor NO-LOCK NO-ERROR.
       IF NOT AVAILABLE vendedor THEN DO:
         v-cdg_vendedor:SCREEN-VALUE = auxvend.
         {traducetabla.i "Vendedor" "cdg_vendedor" "nombre"} 
       END.
   END.
   /*RUN getparametro_c.p ("DFMONEDA",OUTPUT v-cdg_moneda).*/
   /*DISPLAY v-cdg_moneda WITH FRAME {&FRAME-NAME}.*/
   v-cdg_condicion_impos = cliente.cdg_condiva.
   v-cdg_condicion_venta = cliente.dfl_cndventa.

   RUN getparametro_n.p ("DFRENOV",OUTPUT aux).
   DISPLAY v-cdg_condicion_impos WITH FRAME {&FRAME-NAME}.
   {traducetabla.i "Condicion_impos" "cdg_condiva" "descripcion"} 
   Contrato_hd.primer_mes:SCREEN-VALUE = string(MONTH(TODAY),"99").
   Contrato_hd.primer_ano:SCREEN-VALUE = string(year(TODAY),"9999").
   Contrato_hd.fecha_alta:SCREEN-VALUE = string(TODAY).
   Contrato_hd.rige_desde:SCREEN-VALUE = string(TODAY).
   Contrato_hd.rige_hasta:SCREEN-VALUE = "01/01/2099".
   contrato_hd.cdg_lista:SCREEN-VALUE = STRING(cliente.dfl_lista).
   contrato_hd.nro_plazo:SCREEN-VALUE = STRING(aux).
   contrato_hd.estado:SCREEN-VALUE = "P".
   b_renov:SENSITIVE = FALSE.
   b_email:SENSITIVE = FALSE.
   b_presup:SENSITIVE = FALSE.
   b_rest:SENSITIVE = FALSE.
   bcta-cte:SENSITIVE = FALSE.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE local-assign-statement V-table-Win 
PROCEDURE local-assign-statement :
/*------------------------------------------------------------------------------
  Purpose:     Override standard ADM method
  Notes:       
------------------------------------------------------------------------------*/
DEFINE VAR k AS INT NO-UNDO.
DEFINE VAR v_cdg_moneda AS CHAR NO-UNDO.
  /* Code placed here will execute PRIOR to standard behavior. */

   &SCOPED-DEFINE TABLA-MAESTRA  Contrato_hd
   
IF INPUT FRAME {&FRAME-NAME} contrato_hd.nro_tipo_evento = 0 THEN DO:
    MESSAGE "Elija el tipo de evento del contrato" VIEW-AS ALERT-BOX ERROR.
    RETURN ERROR.
END.
   
   /*{validartabla.i "Lista_precios" "cdg_lista" "descripcion" "CLIE008"} */
   /*{validartabla.i "Moneda" "cdg_moneda" "descripcion" "CLIE052"}*/
   {validartabla.i "Vendedor" "cdg_vendedor" "nombre" "CLIE003"} 
   {validartabla.i "Condicion_venta" "cdg_cndventa" "descripcion" "CLIE005"}
   {validartabla.i "Condicion_impos" "cdg_condiva" "descripcion" "CLIE006"}
   FIND Punto-venta WHERE Punto-venta.cdg_puntovta = INPUT FRAME {&FRAME-NAME} prf NO-LOCK NO-ERROR.
   IF NOT AVAILABLE punto-venta 
   THEN DO:
         RUN PONMENSJ.P ( "REMI063" ).
         RETURN ERROR.
   END.
      &UNDEFINE TABLA-MAESTRA
   IF Cliente.dfl_cdg_puntovta = 0 THEN DO:
       MESSAGE "Este cliente no tiene definido ningun punto de venta por default"
           VIEW-AS ALERT-BOX INFORMATION.
   END.
   ELSE
   IF Cliente.dfl_cdg_puntovta <> INPUT FRAME {&FRAME-NAME} prf THEN DO:
   sino-msg = NO.
   RUN mensajepregunta.p ( INPUT "",INPUT "CLIPVTA", INPUT-OUTPUT sino-msg ). 
       IF NOT sino-msg THEN RETURN NO-APPLY.
   END.
  /* IF contrato_hd.numero_eventos < 1 THEN DO:
       MESSAGE "El numero de subeventos tiene que ser mayor a 1".
       RETURN ERROR.
   END. */
   k = INT(Contrato_hd.modo_facturacion:INPUT-VALUE) NO-ERROR.
   IF k = 0  THEN DO:
       MESSAGE "No ha asignado el modo de facturacion".
       RETURN ERROR.
   END.

  /* Dispatch standard ADM method.                             */
  IF ( contrato_hd.estado = "A" OR contrato_hd.estado = "R" ) AND INPUT contrato_hd.estado = "P" THEN DO:
        FIND tarea WHERE tarea.destino = "CONTRATO" AND tarea.nro_destino = contrato_hd.nro_contrato AND
      tarea.estado = "A" EXCLUSIVE-LOCK NO-ERROR.
      IF AVAILABLE tarea THEN DO: 
        tarea.descripcion = agregaAdvTexto("Se ha pasado del estado Aprob. a Pendiente", tarea.descripcion ).
        Tarea.estado = "A".
        Tarea.fecha_resuelto = ?.
        tarea.descripcion = agregaAdvTexto("Reabrio",tarea.descripcion).
     END.
  END.

  RUN dispatch IN THIS-PROCEDURE ( INPUT 'assign-statement':U ) .

  /* Code placed here will execute AFTER standard behavior.    */

   &SCOPED-DEFINE TABLA-MAESTRA  Contrato_hd
   
   RUN getparametro_c.p ("DFMONEDA",OUTPUT v_cdg_moneda).
   FIND moneda WHERE moneda.cdg_moneda = v_cdg_moneda NO-LOCK.
   /*{asignartabla.i "Lista_precios" "cdg_lista" "cdg_lista"}*/
   {asignartabla.i "Vendedor" "nro_vendedor" "nro_vendedor"} 
   {asignartabla.i "Cliente" "nro_cliente" "nro_cliente"} 
   {asignartabla.i "Moneda" "nro_moneda" "nro_moneda"} 
   {asignartabla.i "Condicion_venta" "nro_cndventa" "nro_cndventa" }
   {asignartabla.i "Condicion_impos" "cdg_condiva" "cdg_condiva" }
   {asignartabla.i "Punto-venta" "cdg_puntovta" "prf_contrato" }
   contrato_hd.motivo_baja = v-motivo_baja.
   contrato_hd.observacion = v-vobservacion.
   contrato_hd.leyenda = v-leyenda. 

   &UNDEFINE TABLA-MAESTRA

   {findempresa.i}

   IF Contrato_hd.nro_contrato = 0
   THEN DO:
       ASSIGN Contrato_hd.nro_cliente    = Cliente.nro_cliente
              Contrato_hd.cdg_provincia  = Cliente.cdg_provincia
              Contrato_hd.cdg_empresa    = Empresa.cdg_empresa
              Contrato_hd.nro_contrato   = NEXT-VALUE(proximo_contrato)
              Contrato_hd.num_contrato   = Contrato_hd.nro_contrato
              Contrato_hd.resto_periodos = Contrato_hd.cant_periodos
              contrato_hd.cdg_imputacion = 51 /*se puede no cablear?*/.
              
       FIND FIRST Domicilio OF Cliente NO-LOCK.
       Contrato_hd.nro_domicilio = Domicilio.nro_domicilio.
   END.
   FIND FIRST fac_header WHERE fac_header.nro_contrato = contrato_hd.nro_contrato NO-LOCK NO-ERROR.
   IF NOT AVAILABLE fac_header THEN
       contrato_hd.resto_periodos = Contrato_hd.cant_periodos.
   IF contrato_hd.fecha_baja = ? AND NOT contrato_hd.anulado AND contrato_hd.estado = "A" THEN
         RUN poner_primer_evento.p (ROWID(contrato_hd)).
   FOR EACH evento WHERE evento.origen = "contrato" AND evento.nro_identificacion = contrato_hd.nro_contrato:
         Evento.nro_tipo_evento = contrato_hd.nro_tipo_evento.
   END.

   /*acomodando tareas"*/
   FOR EACH tarea WHERE tarea.destino = "CONTRATO" AND tarea.nro_destino = contrato_hd.nro_contrato AND
       tarea.nro_cliente = contrato_hd.nro_cliente AND tarea.estado = "A":
       IF contrato_hd.estado = "A" THEN  do:
           tarea.accion = "4".
           tarea.estado = "R".
       END.
       IF contrato_hd.estado = "R" THEN  do:
           tarea.accion = "5".
           tarea.estado = "R".
       END.
   END.

   RUN estado_coutas.
   MESSAGE "Recuerde verificar las restricciones del contrato" VIEW-AS ALERT-BOX INFORMATION.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE local-copy-record V-table-Win 
PROCEDURE local-copy-record :
/*------------------------------------------------------------------------------
  Purpose:     Override standard ADM method
  Notes:       
------------------------------------------------------------------------------*/
  /* Code placed here will execute PRIOR to standard behavior. */
  MESSAGE "No se permite copiar contratos" SKIP
      "Puede renovar uno anterior o crear uno nuevo"
      VIEW-AS ALERT-BOX ERROR.
  RETURN ERROR.
/*                                                                          */
/*   /* Dispatch standard ADM method.                             */        */
/*   RUN dispatch IN THIS-PROCEDURE ( INPUT 'copy-record':U ) .             */
/*                                                                          */
/*   /* Code placed here will execute AFTER standard behavior.    */        */
/*                                                                          */
/*   DO WITH FRAME {&FRAME-NAME}:                                           */
/*    sic.Contrato_hd.primer_mes:SCREEN-VALUE = string(MONTH(TODAY),"99").  */
/*    sic.Contrato_hd.primer_ano:SCREEN-VALUE = string(year(TODAY),"9999"). */
/*    sic.Contrato_hd.fecha_alta:SCREEN-VALUE = string(TODAY).              */
/*    sic.Contrato_hd.rige_desde:SCREEN-VALUE = string(TODAY).              */
/*    sic.Contrato_hd.rige_hasta:SCREEN-VALUE = "01/01/2099".               */
/*    sic.contrato_hd.ultimo_mes:SCREEN-VALUE = "".                         */
/*    sic.contrato_hd.ultimo_ano:SCREEN-VALUE = "".                         */
/*    b-renov:SENSITIVE = FALSE.                                            */
/*   END.                                                                   */
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE local-delete-record V-table-Win 
PROCEDURE local-delete-record :
/*------------------------------------------------------------------------------
  Purpose:     Override standard ADM method
  Notes:       
------------------------------------------------------------------------------*/
DEFINE VAR aux LIKE contrato_hd.nro_contrato.
  /* Code placed here will execute PRIOR to standard behavior. */
/*para dar de baja el contrato nunca se debe de haber operado es decir no deberia
figurar en la ctacte*/
FIND FIRST cta_cte WHERE cta_cte.nro_contrato = contrato_hd.nro_contrato NO-ERROR.
IF AVAILABLE cta_cte THEN DO:
    MESSAGE "Existen operaciones relacionadas al mismo no puede dar de baja el contrato "
        cta_cte.tip_comprob "-" cta_cte.prf_comprob "-" cta_cte.nro_comprob
        VIEW-AS ALERT-BOX ERROR.
    RETURN ERROR.
END.
  FIND evento WHERE evento.nro_cliente = contrato_hd.nro_cliente and
      evento.fasignado<>? AND NOT evento.anulado AND NOT evento.frealizado<>? NO-ERROR.
  IF AVAILABLE evento THEN DO:
      MESSAGE "No puede dar de baja este contrato ya que existen" SKIP
         "Eventos activos, anulelos previamente [" evento.nro_evento "]".
  END.
  sino-msg = NO.
  RUN mensajepregunta.p ( INPUT "",INPUT "CPY003", INPUT-OUTPUT sino-msg ). 
      IF NOT sino-msg THEN RETURN NO-APPLY.
  
  /* Dispatch standard ADM method.                             */
  RUN dispatch IN THIS-PROCEDURE ( INPUT 'delete-record':U ) .

  /* Code placed here will execute AFTER standard behavior.    */
  /*reabrir la tarea que le habia dado origen si es que existe*/
  /*FOR EACH tarea WHERE tarea.origen = "CONTRATO" AND
      tarea.nro_identificacion = aux AND tarea.estado = "R":
      ASSIGN
          tarea.nro_destino = ?
          tarea.destino = ""
          tarea.fecha_resuelto = ?
          tarea.estado = "A".
          tarea.descripcion = agregaAdvTexto("Tarea reabierta por sistema al anular el contrato",tarea.descripcion).
  END.*/
  FOR EACH evento WHERE evento.nro_identificacion = aux AND evento.origen = "CONTRATO"
      AND NOT evento.fasignado<>? AND NOT evento.anulado AND NOT evento.frealizado<>?:
      evento.anulado = TRUE.
      evento.observacion = agregaAdvTexto("Evento anulado por sistema al anular el contrato",evento.observacion).
  END.
  FOR EACH contrato_dt WHERE contrato_dt.nro_contrato = aux:
      DELETE contrato_dt.
  END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE local-disable V-table-Win 
PROCEDURE local-disable :
/*------------------------------------------------------------------------------
  Purpose:     Override standard ADM method
  Notes:       
------------------------------------------------------------------------------*/

  /* Code placed here will execute PRIOR to standard behavior. */

  /* Dispatch standard ADM method.                             */
  RUN dispatch IN THIS-PROCEDURE ( INPUT 'disable':U ) .

  /* Code placed here will execute AFTER standard behavior.    */
IF VALID-HANDLE( hcta_cte) THEN
    RUN dispatch IN  hcta_cte ( INPUT 'destroy':U ).
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE local-disable-fields V-table-Win 
PROCEDURE local-disable-fields :
/*------------------------------------------------------------------------------
  Purpose:     Override standard ADM method
  Notes:       
------------------------------------------------------------------------------*/

  /* Code placed here will execute PRIOR to standard behavior. */

  /* Dispatch standard ADM method.                             */
  RUN dispatch IN THIS-PROCEDURE ( INPUT 'disable-fields':U ) .

  /* Code placed here will execute AFTER standard behavior.    */

   /*{deshabcodigo.i "Lista_precios"}*/
   {deshabcodigo.i "Vendedor"} 
   /*{deshabcodigo.i "Moneda"} */
   prf:SENSITIVE = FALSE.
   {deshabcodigo.i "Condicion_impos"}
   {deshabcodigo.i "Condicion_venta"}
   b_renov:SENSITIVE = TRUE.
   b_email:SENSITIVE = TRUE.
   b_rest:SENSITIVE = TRUE.
   b_presup:SENSITIVE = TRUE.
   RUN get-link-handle IN adm-broker-hdl
    ( INPUT THIS-PROCEDURE,
      INPUT "refresco-source",
      OUTPUT hcproc ).
    hproc = WIDGET-HANDLE(hcproc).
    IF VALID-HANDLE(hProc) THEN 
    do:
         RUN blockpanel IN hproc ( FALSE ).
    END.
   
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE local-display-fields V-table-Win 
PROCEDURE local-display-fields :
/*------------------------------------------------------------------------------
  Purpose:     Override standard ADM method
  Notes:       
------------------------------------------------------------------------------*/
    DEFINE VAR dcuota1 AS DECIMAL NO-UNDO.
  /* Code placed here will execute PRIOR to standard behavior. */
    DEFINE VAR listaprf AS CHAR NO-UNDO.
    IF AVAILABLE cliente THEN DO:
        listaprf = "".
        FOR EACH canal NO-LOCK WHERE canal.nro_cliente = cliente.nro_admin:
          IF LOOKUP( string(canal.cdg_puntovta) , listaprf ) = 0 THEN
         listaprf = listaprf + "," + string(canal.cdg_puntovta).
        END.
        FOR EACH canal NO-LOCK WHERE canal.nro_cliente = cliente.nro_cliente:
          IF LOOKUP( string(canal.cdg_puntovta) , listaprf ) = 0 THEN
         listaprf = listaprf + "," + string(canal.cdg_puntovta).
        END.
    END.
    
    prf:LIST-ITEMS IN FRAME {&FRAME-NAME} = substring(listaprf,2).
  /* Dispatch standard ADM method.                             */
  RUN dispatch IN THIS-PROCEDURE ( INPUT 'display-fields':U ) .
  
  /* Code placed here will execute AFTER standard behavior.    */

  IF AVAILABLE Contrato_hd
  THEN DO:

   &SCOPED-DEFINE TABLA-MAESTRA  Contrato_hd
        {displaytabla.i "Vendedor" "cdg_vendedor" "nombre" "nro_vendedor" "nro_vendedor"} 
        {displaytabla.i "Condicion_venta" "cdg_cndventa" "descripcion" "nro_cndventa" "nro_cndventa"} 
        {displaytabla.i "Condicion_impos" "cdg_condiva" "descripcion" "cdg_condiva" "cdg_condiva"} 
    &UNDEFINE TABLA-MAESTRA
    prf:SCREEN-VALUE IN FRAME {&FRAME-NAME} = string(contrato_hd.prf_contrato).
    RUN estado_coutas.
    
   b_renov:SENSITIVE = TRUE.
   b_email:SENSITIVE =TRUE.
   b_rest:SENSITIVE = TRUE.
   b_presup:SENSITIVE = TRUE. /*Contrato_hd.rige_hasta < TODAY .*/
    v-motivo_baja = contrato_hd.motivo_baja.
    MENU-ITEM m_Motivo_de_Baja:SENSITIVE IN MENU POPUP-MENU-fecha_baja = contrato_hd.fecha_baja <> ?.
    MENU-ITEM m_Baja_Contrato:SENSITIVE IN MENU POPUP-MENU-fecha_baja = contrato_hd.fecha_baja = ?.
    v-vobservacion = contrato_hd.observacion.
    v-leyenda = contrato_hd.leyenda.
    b_rest:SENSITIVE = TRUE.
    bcta-cte:SENSITIVE = TRUE.
 END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE local-enable-fields V-table-Win 
PROCEDURE local-enable-fields :
/*------------------------------------------------------------------------------
  Purpose:     Override standard ADM method
  Notes:       
------------------------------------------------------------------------------*/

  /* Dispatch standard ADM method.                             */
  RUN dispatch IN THIS-PROCEDURE ( INPUT 'enable-fields':U ) .

  /* Code placed here will execute AFTER standard behavior.    */

   /*{habilcodigo.i "Lista_precios"}*/
   {habilcodigo.i "Vendedor"} 
   /*{habilcodigo.i "Moneda"} */
   {habilcodigo.i "Condicion_venta"}
   {habilcodigo.i "Condicion_impos"}
   prf:SENSITIVE = TRUE.
   b_renov:SENSITIVE = FALSE.
   b_email:SENSITIVE = FALSE.
   b_rest:SENSITIVE = FALSE.
   b_presup:SENSITIVE = FALSE.
   RUN get-link-handle IN adm-broker-hdl
    ( INPUT THIS-PROCEDURE,
      INPUT "refresco-source",
      OUTPUT hcproc ).
    hproc = WIDGET-HANDLE(hcproc).
    IF VALID-HANDLE(hProc) THEN 
    do:
         RUN blockpanel IN hproc ( true ).
    END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE local-hide V-table-Win 
PROCEDURE local-hide :
/*------------------------------------------------------------------------------
  Purpose:     Override standard ADM method
  Notes:       
------------------------------------------------------------------------------*/

  /* Code placed here will execute PRIOR to standard behavior. */

  /* Dispatch standard ADM method.                             */
  RUN dispatch IN THIS-PROCEDURE ( INPUT 'hide':U ) .
  IF VALID-HANDLE( hcta_cte) THEN DO:
     RUN delete-link IN adm-broker-hdl ( THIS-PROCEDURE , "record", hcta_cte).
     RUN dispatch IN  hcta_cte ( INPUT 'destroy':U ).
  END.
  /* Code placed here will execute AFTER standard behavior.    */

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE local-initialize V-table-Win 
PROCEDURE local-initialize :
/*------------------------------------------------------------------------------
  Purpose:     Override standard ADM method
  Notes:       
------------------------------------------------------------------------------*/
DEF VAR lista AS CHAR NO-UNDO.
{findempresa.i}
  /* Code placed here will execute PRIOR to standard behavior. */
    lista = ",--,0".
    FOR EACH tipo_evento NO-LOCK WHERE Tipo_evento.Origen = "CONTRATO" :
        lista = lista + "," + tipo_evento.cdg_tipo_evento + "," + STRING(tipo_evento.nro_tipo_evento).
    END.
    contrato_hd.nro_tipo_evento:LIST-ITEM-PAIRS IN FRAME {&FRAME-NAME} = SUBSTRING(lista,2).

  /* Dispatch standard ADM method.                             */
  RUN dispatch IN THIS-PROCEDURE ( INPUT 'initialize':U ) .

  /* Code placed here will execute AFTER standard behavior.    */

   b_renov:SENSITIVE = TRUE.
   b_email:SENSITIVE = TRUE.
   b_rest:SENSITIVE = TRUE.
   b_presup:SENSITIVE = TRUE.


END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE send-key V-table-Win  adm/support/_key-snd.p
PROCEDURE send-key :
/*------------------------------------------------------------------------------
  Purpose:     Sends a requested KEY value back to the calling
               SmartObject.
  Parameters:  <see adm/template/sndkytop.i>
------------------------------------------------------------------------------*/

  /* Define variables needed by this internal procedure.             */
  {src/adm/template/sndkytop.i}

  /* Return the key value associated with each key case.             */
  {src/adm/template/sndkycas.i "cdg_empresa" "Empresa" "cdg_empresa"}
  {src/adm/template/sndkycas.i "nro_contrato" "Contrato_hd" "nro_contrato"}
  {src/adm/template/sndkycas.i "cdg_empresa" "Contrato_hd" "cdg_empresa"}
  {src/adm/template/sndkycas.i "nombre" "Contrato_hd" "nombre"}
  {src/adm/template/sndkycas.i "nro_area" "Contrato_hd" "nro_area"}
  {src/adm/template/sndkycas.i "cdg_banco" "Contrato_hd" "cdg_banco"}
  {src/adm/template/sndkycas.i "nro_cliente" "Contrato_hd" "nro_cliente"}
  {src/adm/template/sndkycas.i "cdg_condiva" "Contrato_hd" "cdg_condiva"}
  {src/adm/template/sndkycas.i "nro_cndventa" "Contrato_hd" "nro_cndventa"}
  {src/adm/template/sndkycas.i "cdg_consignatario" "Contrato_hd" "cdg_consignatario"}
  {src/adm/template/sndkycas.i "cdg_postal" "Contrato_hd" "cdg_postal"}
  {src/adm/template/sndkycas.i "cdg_formapago" "Contrato_hd" "cdg_formapago"}
  {src/adm/template/sndkycas.i "cdg_imputacion" "Contrato_hd" "cdg_imputacion"}
  {src/adm/template/sndkycas.i "cdg_lista" "Contrato_hd" "cdg_lista"}
  {src/adm/template/sndkycas.i "nro_moneda" "Contrato_hd" "nro_moneda"}
  {src/adm/template/sndkycas.i "nro_obra" "Contrato_hd" "nro_obra"}
  {src/adm/template/sndkycas.i "nro_persona" "Contrato_hd" "nro_persona"}
  {src/adm/template/sndkycas.i "cdg_planta" "Contrato_hd" "cdg_planta"}
  {src/adm/template/sndkycas.i "nro_plazo" "Contrato_hd" "nro_plazo"}
  {src/adm/template/sndkycas.i "cdg_provincia" "Contrato_hd" "cdg_provincia"}
  {src/adm/template/sndkycas.i "nro_remito" "Contrato_hd" "nro_remito"}
  {src/adm/template/sndkycas.i "cdg_solicitante" "Contrato_hd" "cdg_solicitante"}
  {src/adm/template/sndkycas.i "num_sucursal" "Contrato_hd" "num_sucursal"}
  {src/adm/template/sndkycas.i "cdg_embarque" "Contrato_hd" "cdg_embarque"}
  {src/adm/template/sndkycas.i "nro_tipo_evento" "Contrato_hd" "nro_tipo_evento"}
  {src/adm/template/sndkycas.i "nro_usuario" "Contrato_hd" "nro_usuario"}
  {src/adm/template/sndkycas.i "nro_vendedor" "Contrato_hd" "nro_vendedor"}
  {src/adm/template/sndkycas.i "cdg_zonag" "Contrato_hd" "cdg_zonag"}

  /* Close the CASE statement and end the procedure.                 */
  {src/adm/template/sndkyend.i}

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE send-records V-table-Win  _ADM-SEND-RECORDS
PROCEDURE send-records :
/*------------------------------------------------------------------------------
  Purpose:     Send record ROWID's for all tables used by
               this file.
  Parameters:  see template/snd-head.i
------------------------------------------------------------------------------*/

  /* Define variables needed by this internal procedure.               */
  {src/adm/template/snd-head.i}

  /* For each requested table, put it's ROWID in the output list.      */
  {src/adm/template/snd-list.i "Contrato_hd"}
  {src/adm/template/snd-list.i "Cliente"}

  /* Deal with any unexpected table requests before closing.           */
  {src/adm/template/snd-end.i}

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE state-changed V-table-Win 
PROCEDURE state-changed :
/* -----------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
-------------------------------------------------------------*/
  DEFINE INPUT PARAMETER p-issuer-hdl AS HANDLE    NO-UNDO.
  DEFINE INPUT PARAMETER p-state      AS CHARACTER NO-UNDO.

  CASE p-state:
/*      WHEN 'update-begin' THEN DO:
        IF AVAILABLE contrato_hd THEN DO:
          /* Code placed here will execute PRIOR to standard behavior. */
            IF NOT ( Contrato_hd.fecha_baja = ?  AND Contrato_hd.rige_hasta > TODAY AND
                 ( contrato_hd.cant_periodos  = contrato_hd.resto_periodos OR
                   contrato_hd.resto_periodos > 0 )) THEN DO:
                MESSAGE "El contrato no esta activo, no puede modificar" VIEW-AS ALERT-BOX ERROR.
                RUN new-state ('cancelar':U).
            END.
        END.
      END.
      /* Object instance CASEs can go here to replace standard behavior
         or add new cases. */     */
      {src/adm/template/vstates.i}
  END CASE.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE totales V-table-Win 
PROCEDURE totales :
/*------------------------------------------------------------------------------
  Purpose: recalcula los totales del presupuesto    
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

DEFINE BUFFER b-contrato_dt FOR contrato_dt.
    FIND CURRENT contrato_hd EXCLUSIVE-LOCK.
   ASSIGN  Contrato_hd.imp_iva      = 0
           Contrato_hd.imp_neto     = 0 
           Contrato_hd.imp_total    = 0 
           Contrato_hd.imp_bruto    = 0.
   FOR EACH b-contrato_dt NO-LOCK OF contrato_hd:
       ASSIGN 
              Contrato_hd.imp_neto     = Contrato_hd.imp_neto     + b-Contrato_dt.subtotal_neto  
              Contrato_hd.imp_total    = Contrato_hd.imp_total    + b-Contrato_dt.subtotal_gral 
              Contrato_hd.imp_bruto    = Contrato_hd.imp_bruto    + b-Contrato_dt.subtotal_bruto
              Contrato_hd.imp_iva      = Contrato_hd.imp_total    - Contrato_hd.imp_neto.  
   END.
   FIND CURRENT contrato_hd NO-LOCK.
   RUN local-display-fields.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE ver_cta_cte V-table-Win 
PROCEDURE ver_cta_cte :
/*------------------------------------------------------------------------------
  Purpose:     ver la cuenta corriente del contrato
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEFINE INPUT PARAMETER rid AS ROWID.
DEFINE OUTPUT PARAMETER tot_debitogr AS DECIMAL.
DEFINE OUTPUT PARAMETER tot_creditogr AS DECIMAL.

DEF BUFFER bcontrato FOR contrato_hd.
DEF BUFFER b-cta_cte FOR cta_cte.


   tot_debitogr = 0.
   tot_creditogr = 0.

   FIND bcontrato WHERE rowid(bcontrato) = rid NO-LOCK NO-ERROR.
   IF AVAILABLE bcontrato THEN DO:
   /* Busca por Movimiento en la ctacte */
    FOR EACH B-Cta_cte NO-LOCK 
      WHERE B-Cta_cte.nro_cliente = bcontrato.nro_cliente and
            B-Cta_cte.nro_contrato = bcontrato.nro_contrato :
      IF CAN-DO(str_debitan,B-Cta_cte.tip_comprob)
         THEN  tot_debitogr  = tot_debitogr + B-Cta_cte.debito.
         ELSE  tot_creditogr = tot_creditogr + B-Cta_cte.credito.
   END.
   END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

/* ************************  Function Implementations ***************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION ver_anticipos V-table-Win 
FUNCTION ver_anticipos RETURNS DECIMAL
  ( ) :
/*------------------------------------------------------------------------------
  Purpose:  
    Notes:  
------------------------------------------------------------------------------*/
    DEF VAR va AS DECIMAL NO-UNDO.
    va = 0.
    FOR EACH contrato_DT NO-LOCK OF contrato_hd:
        va = va + contrato_DT.anticipo_cf.
    END.
    RETURN va.   /* Function return value. */
END FUNCTION.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION ver_couta1 V-table-Win 
FUNCTION ver_couta1 RETURNS DECIMAL
  ( ) :
/*------------------------------------------------------------------------------
  Purpose:  
    Notes:  
------------------------------------------------------------------------------*/
    DEF VAR vv AS DECIMAL NO-UNDO.
    vv = 0.
    FOR EACH contrato_DT NO-LOCK OF contrato_hd WHERE contrato_DT.solocuota1:
        vv = vv + contrato_DT.subtotal_gral.
    END.
    RETURN vv.   /* Function return value. */
END FUNCTION.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

