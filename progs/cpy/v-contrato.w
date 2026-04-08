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
&Scoped-define EXTERNAL-TABLES Contrato_hd Empresa
&Scoped-define FIRST-EXTERNAL-TABLE Contrato_hd


/* Need to scope the external tables to this procedure                  */
DEFINE QUERY external_tables FOR Contrato_hd, Empresa.
/* Standard List Definitions                                            */
&Scoped-Define ENABLED-FIELDS Contrato_hd.nro_tipo_evento ~
Contrato_hd.estado Contrato_hd.titulo Contrato_hd.contacto ~
Contrato_hd.cargo_contacto Contrato_hd.telefono Contrato_hd.fecha_carga ~
Contrato_hd.fecha_embarque Contrato_hd.cambio Contrato_hd.cambio_dolar ~
Contrato_hd.imp_neto Contrato_hd.imp_total Contrato_hd.nro_ocm ~
Contrato_hd.fecha_ocm Contrato_hd.modo_facturacion Contrato_hd.primer_mes ~
Contrato_hd.primer_ano Contrato_hd.cant_periodos Contrato_hd.fecha_alta ~
Contrato_hd.fecha_baja Contrato_hd.rige_desde Contrato_hd.rige_hasta 
&Scoped-define ENABLED-TABLES Contrato_hd
&Scoped-define FIRST-ENABLED-TABLE Contrato_hd
&Scoped-Define ENABLED-OBJECTS RECT-8 
&Scoped-Define DISPLAYED-FIELDS Contrato_hd.tip_contrato ~
Contrato_hd.prf_contrato Contrato_hd.num_contrato ~
Contrato_hd.nro_tipo_evento Contrato_hd.estado Contrato_hd.titulo ~
Contrato_hd.contacto Contrato_hd.cargo_contacto Contrato_hd.telefono ~
Contrato_hd.fecha_carga Contrato_hd.fecha_embarque Contrato_hd.cambio ~
Contrato_hd.cambio_dolar Contrato_hd.imp_neto Contrato_hd.imp_total ~
Contrato_hd.nro_ocm Contrato_hd.fecha_ocm Contrato_hd.modo_facturacion ~
Contrato_hd.primer_mes Contrato_hd.primer_ano Contrato_hd.cant_periodos ~
Contrato_hd.fecha_alta Contrato_hd.fecha_baja Contrato_hd.ultimo_mes ~
Contrato_hd.ultimo_ano Contrato_hd.resto_periodos Contrato_hd.rige_desde ~
Contrato_hd.rige_hasta 
&Scoped-define DISPLAYED-TABLES Contrato_hd
&Scoped-define FIRST-DISPLAYED-TABLE Contrato_hd
&Scoped-Define DISPLAYED-OBJECTS v-cdg_lista_precios v-dsc_lista_precios ~
v-cdg_moneda v-dsc_moneda v-cdg_condicion_venta v-dsc_condicion_venta ~
v-cdg_vendedor v-dsc_vendedor 

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
</FOREIGN-KEYS> 
<EXECUTING-CODE>
**************************
* Set attributes related to FOREIGN KEYS
*/
RUN set-attribute-list (
    'Keys-Accepted = "",
     Keys-Supplied = ""':U).
/**************************
</EXECUTING-CODE> */   

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


/* ***********************  Control Definitions  ********************** */


/* Definitions of the field level widgets                               */
DEFINE VARIABLE v-cdg_condicion_venta AS CHARACTER FORMAT "X(8)" 
     LABEL "C. Venta" 
     VIEW-AS FILL-IN NATIVE 
     SIZE 16 BY 1
     BGCOLOR 15 FGCOLOR 9 .

DEFINE VARIABLE v-cdg_lista_precios AS INTEGER FORMAT "->,>>>,>>9" INITIAL 0 
     LABEL "Lista" 
     VIEW-AS FILL-IN NATIVE 
     SIZE 16 BY 1
     BGCOLOR 15 FGCOLOR 9 .

DEFINE VARIABLE v-cdg_moneda AS CHARACTER FORMAT "X(3)" 
     LABEL "Moneda" 
     VIEW-AS FILL-IN NATIVE 
     SIZE 16 BY 1
     BGCOLOR 15 FGCOLOR 9 .

DEFINE VARIABLE v-cdg_vendedor AS CHARACTER FORMAT "X(8)" 
     LABEL "Vendedor" 
     VIEW-AS FILL-IN NATIVE 
     SIZE 16 BY 1
     BGCOLOR 15 FGCOLOR 9 .

DEFINE VARIABLE v-dsc_condicion_venta AS CHARACTER FORMAT "X(35)" 
     VIEW-AS FILL-IN NATIVE 
     SIZE 39 BY 1
     BGCOLOR 7 FGCOLOR 15 .

DEFINE VARIABLE v-dsc_lista_precios AS CHARACTER FORMAT "X(50)" 
     VIEW-AS FILL-IN NATIVE 
     SIZE 39 BY 1
     BGCOLOR 7 FGCOLOR 15 .

DEFINE VARIABLE v-dsc_moneda AS CHARACTER FORMAT "X(50)" 
     VIEW-AS FILL-IN NATIVE 
     SIZE 39 BY 1
     BGCOLOR 7 FGCOLOR 15 .

DEFINE VARIABLE v-dsc_vendedor AS CHARACTER FORMAT "X(35)" 
     VIEW-AS FILL-IN NATIVE 
     SIZE 39 BY 1
     BGCOLOR 7 FGCOLOR 15 .

DEFINE RECTANGLE RECT-8
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 123 BY 13.81.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME F-Main
     Contrato_hd.tip_contrato AT ROW 1.48 COL 11 COLON-ALIGNED
          LABEL "Contrato"
          VIEW-AS FILL-IN NATIVE 
          SIZE 7 BY 1
          BGCOLOR 15 FGCOLOR 9 
     Contrato_hd.prf_contrato AT ROW 1.48 COL 18 COLON-ALIGNED
          LABEL "-"
          VIEW-AS FILL-IN NATIVE 
          SIZE 8 BY 1
          BGCOLOR 15 FGCOLOR 9 
     Contrato_hd.num_contrato AT ROW 1.48 COL 27 COLON-ALIGNED
          LABEL "-"
          VIEW-AS FILL-IN NATIVE 
          SIZE 13 BY 1
          BGCOLOR 15 FGCOLOR 9 
     Contrato_hd.nro_tipo_evento AT ROW 1.48 COL 71 COLON-ALIGNED WIDGET-ID 2
          LABEL "Tipo Evento"
          VIEW-AS COMBO-BOX INNER-LINES 5
          LIST-ITEM-PAIRS "0",1
          DROP-DOWN-LIST
          SIZE 18 BY 1 TOOLTIP "Tipo de Restriccion o Tipo de Evento"
     Contrato_hd.estado AT ROW 1.48 COL 104 COLON-ALIGNED WIDGET-ID 20
          LABEL "Estado"
          VIEW-AS COMBO-BOX INNER-LINES 5
          LIST-ITEM-PAIRS "Aprobado","A",
                     "Rechazado","R",
                     "Pendiente","P",
                     "Todos","*"
          DROP-DOWN-LIST
          SIZE 16 BY 1
     Contrato_hd.titulo AT ROW 2.67 COL 11 COLON-ALIGNED
          VIEW-AS FILL-IN NATIVE 
          SIZE 109 BY 1
          BGCOLOR 15 FGCOLOR 9 
     Contrato_hd.contacto AT ROW 3.86 COL 11 COLON-ALIGNED
          VIEW-AS FILL-IN NATIVE 
          SIZE 56 BY 1
          BGCOLOR 15 FGCOLOR 9 
     Contrato_hd.cargo_contacto AT ROW 3.86 COL 76 COLON-ALIGNED
          VIEW-AS FILL-IN NATIVE 
          SIZE 44 BY 1
          BGCOLOR 15 FGCOLOR 9 
     Contrato_hd.telefono AT ROW 5.05 COL 11 COLON-ALIGNED
          VIEW-AS FILL-IN NATIVE 
          SIZE 56 BY 1
          BGCOLOR 15 FGCOLOR 9 
     Contrato_hd.fecha_carga AT ROW 5.05 COL 76 COLON-ALIGNED
          VIEW-AS FILL-IN NATIVE 
          SIZE 16 BY 1
          BGCOLOR 15 FGCOLOR 9 
     Contrato_hd.fecha_embarque AT ROW 5.05 COL 104 COLON-ALIGNED
          VIEW-AS FILL-IN NATIVE 
          SIZE 16 BY 1
          BGCOLOR 15 FGCOLOR 9 
     v-cdg_lista_precios AT ROW 6.24 COL 11 COLON-ALIGNED
     v-dsc_lista_precios AT ROW 6.24 COL 28 COLON-ALIGNED NO-LABEL
     Contrato_hd.cambio AT ROW 6.24 COL 76 COLON-ALIGNED
          VIEW-AS FILL-IN NATIVE 
          SIZE 16 BY 1
          BGCOLOR 15 FGCOLOR 9 
     Contrato_hd.cambio_dolar AT ROW 6.24 COL 104 COLON-ALIGNED
          VIEW-AS FILL-IN NATIVE 
          SIZE 16 BY 1
          BGCOLOR 15 FGCOLOR 9 
     v-cdg_moneda AT ROW 7.43 COL 11 COLON-ALIGNED
     v-dsc_moneda AT ROW 7.43 COL 28 COLON-ALIGNED NO-LABEL
     Contrato_hd.imp_neto AT ROW 7.43 COL 76 COLON-ALIGNED
          LABEL "Neto $"
          VIEW-AS FILL-IN NATIVE 
          SIZE 16 BY 1
          BGCOLOR 15 FGCOLOR 9 
     Contrato_hd.imp_total AT ROW 7.43 COL 104 COLON-ALIGNED
          LABEL "Total $"
          VIEW-AS FILL-IN NATIVE 
          SIZE 16 BY 1
          BGCOLOR 15 FGCOLOR 9 
     v-cdg_condicion_venta AT ROW 8.62 COL 11 COLON-ALIGNED
     v-dsc_condicion_venta AT ROW 8.62 COL 28 COLON-ALIGNED HELP
          "Denominacion" NO-LABEL
     Contrato_hd.nro_ocm AT ROW 8.62 COL 76 COLON-ALIGNED
          LABEL "O/C"
          VIEW-AS FILL-IN NATIVE 
          SIZE 16 BY 1
          BGCOLOR 15 FGCOLOR 9 
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1 SCROLLABLE .

/* DEFINE FRAME statement is approaching 4K Bytes.  Breaking it up   */
DEFINE FRAME F-Main
     Contrato_hd.fecha_ocm AT ROW 8.62 COL 104 COLON-ALIGNED
          LABEL "Fecha"
          VIEW-AS FILL-IN NATIVE 
          SIZE 16 BY 1
          BGCOLOR 15 FGCOLOR 9 
     v-cdg_vendedor AT ROW 9.81 COL 11 COLON-ALIGNED
     v-dsc_vendedor AT ROW 9.81 COL 28 COLON-ALIGNED HELP
          "Denominacion" NO-LABEL
     Contrato_hd.modo_facturacion AT ROW 9.81 COL 76 COLON-ALIGNED
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
          SIZE 44 BY 1
          BGCOLOR 15 FGCOLOR 9 
     Contrato_hd.primer_mes AT ROW 12.19 COL 11 COLON-ALIGNED
          LABEL "Mes"
          VIEW-AS FILL-IN NATIVE 
          SIZE 4.8 BY 1
          BGCOLOR 15 FGCOLOR 9 
     Contrato_hd.primer_ano AT ROW 12.19 COL 30 COLON-ALIGNED
          LABEL "Año"
          VIEW-AS FILL-IN NATIVE 
          SIZE 7.6 BY 1
          BGCOLOR 15 FGCOLOR 9 
     Contrato_hd.cant_periodos AT ROW 12.19 COL 58 COLON-ALIGNED
          LABEL "Cant.Períodos" FORMAT ">>9"
          VIEW-AS FILL-IN NATIVE 
          SIZE 9 BY 1
          BGCOLOR 15 FGCOLOR 9 
     Contrato_hd.fecha_alta AT ROW 12.19 COL 76 COLON-ALIGNED
          LABEL "Alta"
          VIEW-AS FILL-IN NATIVE 
          SIZE 16 BY 1
          BGCOLOR 15 FGCOLOR 9 
     Contrato_hd.fecha_baja AT ROW 12.19 COL 104 COLON-ALIGNED
          LABEL "Baja"
          VIEW-AS FILL-IN NATIVE 
          SIZE 16 BY 1
          BGCOLOR 15 FGCOLOR 9 
     Contrato_hd.ultimo_mes AT ROW 13.38 COL 11 COLON-ALIGNED
          LABEL "Mes"
          VIEW-AS FILL-IN 
          SIZE 4.8 BY 1
          BGCOLOR 15 FGCOLOR 9 
     Contrato_hd.ultimo_ano AT ROW 13.38 COL 30 COLON-ALIGNED
          LABEL "Año"
          VIEW-AS FILL-IN 
          SIZE 7.6 BY 1
          BGCOLOR 15 FGCOLOR 9 
     Contrato_hd.resto_periodos AT ROW 13.38 COL 58 COLON-ALIGNED
          LABEL "Restan Períodos"
          VIEW-AS FILL-IN 
          SIZE 9 BY 1
          BGCOLOR 15 FGCOLOR 9 
     Contrato_hd.rige_desde AT ROW 13.38 COL 76 COLON-ALIGNED
          VIEW-AS FILL-IN NATIVE 
          SIZE 16 BY 1
          BGCOLOR 15 FGCOLOR 9 
     Contrato_hd.rige_hasta AT ROW 13.38 COL 104 COLON-ALIGNED
          VIEW-AS FILL-IN NATIVE 
          SIZE 16 BY 1
          BGCOLOR 15 FGCOLOR 9 
     "  Fechas de Alta, Baja y Vigencia del Contrato" VIEW-AS TEXT
          SIZE 44 BY 1 AT ROW 11 COL 78
          BGCOLOR 5 FGCOLOR 15 
     "   Primer Período, Cantidad, Ultimo Facturado y Restantes" VIEW-AS TEXT
          SIZE 56 BY 1 AT ROW 11 COL 13
          BGCOLOR 5 FGCOLOR 15 
     RECT-8 AT ROW 1 COL 1
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1 SCROLLABLE .


/* *********************** Procedure Settings ************************ */

&ANALYZE-SUSPEND _PROCEDURE-SETTINGS
/* Settings for THIS-PROCEDURE
   Type: SmartViewer
   External Tables: sic.Contrato_hd,sic.Empresa
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
         HEIGHT             = 13.86
         WIDTH              = 124.
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

/* SETTINGS FOR FILL-IN Contrato_hd.cant_periodos IN FRAME F-Main
   EXP-LABEL EXP-FORMAT                                                 */
/* SETTINGS FOR COMBO-BOX Contrato_hd.estado IN FRAME F-Main
   EXP-LABEL                                                            */
/* SETTINGS FOR FILL-IN Contrato_hd.fecha_alta IN FRAME F-Main
   EXP-LABEL                                                            */
/* SETTINGS FOR FILL-IN Contrato_hd.fecha_baja IN FRAME F-Main
   EXP-LABEL                                                            */
/* SETTINGS FOR FILL-IN Contrato_hd.fecha_ocm IN FRAME F-Main
   EXP-LABEL                                                            */
/* SETTINGS FOR FILL-IN Contrato_hd.imp_neto IN FRAME F-Main
   EXP-LABEL                                                            */
/* SETTINGS FOR FILL-IN Contrato_hd.imp_total IN FRAME F-Main
   EXP-LABEL                                                            */
/* SETTINGS FOR COMBO-BOX Contrato_hd.modo_facturacion IN FRAME F-Main
   EXP-LABEL                                                            */
/* SETTINGS FOR FILL-IN Contrato_hd.nro_ocm IN FRAME F-Main
   EXP-LABEL                                                            */
/* SETTINGS FOR COMBO-BOX Contrato_hd.nro_tipo_evento IN FRAME F-Main
   EXP-LABEL                                                            */
/* SETTINGS FOR FILL-IN Contrato_hd.num_contrato IN FRAME F-Main
   NO-ENABLE EXP-LABEL                                                  */
/* SETTINGS FOR FILL-IN Contrato_hd.prf_contrato IN FRAME F-Main
   NO-ENABLE EXP-LABEL                                                  */
/* SETTINGS FOR FILL-IN Contrato_hd.primer_ano IN FRAME F-Main
   EXP-LABEL                                                            */
/* SETTINGS FOR FILL-IN Contrato_hd.primer_mes IN FRAME F-Main
   EXP-LABEL                                                            */
/* SETTINGS FOR FILL-IN Contrato_hd.resto_periodos IN FRAME F-Main
   NO-ENABLE EXP-LABEL                                                  */
/* SETTINGS FOR FILL-IN Contrato_hd.tip_contrato IN FRAME F-Main
   NO-ENABLE EXP-LABEL                                                  */
/* SETTINGS FOR FILL-IN Contrato_hd.ultimo_ano IN FRAME F-Main
   NO-ENABLE EXP-LABEL                                                  */
/* SETTINGS FOR FILL-IN Contrato_hd.ultimo_mes IN FRAME F-Main
   NO-ENABLE EXP-LABEL                                                  */
/* SETTINGS FOR FILL-IN v-cdg_condicion_venta IN FRAME F-Main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN v-cdg_lista_precios IN FRAME F-Main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN v-cdg_moneda IN FRAME F-Main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN v-cdg_vendedor IN FRAME F-Main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN v-dsc_condicion_venta IN FRAME F-Main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN v-dsc_lista_precios IN FRAME F-Main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN v-dsc_moneda IN FRAME F-Main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN v-dsc_vendedor IN FRAME F-Main
   NO-ENABLE                                                            */
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

&Scoped-define SELF-NAME Contrato_hd.nro_tipo_evento
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Contrato_hd.nro_tipo_evento V-table-Win
ON VALUE-CHANGED OF Contrato_hd.nro_tipo_evento IN FRAME F-Main /* Tipo Evento */
DO:
  ASSIGN FRAME {&frame-name} contrato_hd.nro_tipo_evento.
  RUN dispatch IN THIS-PROCEDURE ( INPUT 'display-fields':U ).
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
   {traducetabla.i "Vendedor" "cdg_vendedor" "nombre"} 
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME v-cdg_lista_precios
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-cdg_lista_precios V-table-Win
ON MOUSE-SELECT-DBLCLICK OF v-cdg_lista_precios IN FRAME F-Main /* Lista */
OR "." OF v-cdg_lista_precios IN FRAME {&FRAME-NAME}
OR MOUSE-MENU-DOWN OF v-cdg_lista_precios IN FRAME {&FRAME-NAME}
DO:
   {helptabla.i "Lista_precios" "cdg_lista" "SELLISTA.P"}
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-cdg_lista_precios V-table-Win
ON RETURN OF v-cdg_lista_precios IN FRAME F-Main /* Lista */
DO:
   {traducetabla.i "Lista_precios" "cdg_lista" "descripcion"} 
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME v-cdg_moneda
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-cdg_moneda V-table-Win
ON MOUSE-SELECT-DBLCLICK OF v-cdg_moneda IN FRAME F-Main /* Moneda */
OR "." OF v-cdg_moneda IN FRAME {&FRAME-NAME}
OR MOUSE-MENU-DOWN OF v-cdg_moneda IN FRAME {&FRAME-NAME}
DO:
   {helptabla.i "Moneda" "cdg_moneda" "SELMONED.P"}
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-cdg_moneda V-table-Win
ON RETURN OF v-cdg_moneda IN FRAME F-Main /* Moneda */
DO:
   {traducetabla.i "Moneda" "cdg_moneda" "descripcion"} 
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME v-cdg_vendedor
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-cdg_vendedor V-table-Win
ON MOUSE-SELECT-DBLCLICK OF v-cdg_vendedor IN FRAME F-Main /* Vendedor */
OR "." OF v-cdg_vendedor IN FRAME {&FRAME-NAME}
OR MOUSE-MENU-DOWN OF v-cdg_vendedor IN FRAME {&FRAME-NAME}
DO:
   {helptabla.i "Vendedor" "cdg_vendedor" "SELVENDR.P"}
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-cdg_vendedor V-table-Win
ON RETURN OF v-cdg_vendedor IN FRAME F-Main /* Vendedor */
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
  {src/adm/template/row-list.i "Empresa"}

  /* Get the record ROWID's from the RECORD-SOURCE.                  */
  {src/adm/template/row-get.i}

  /* FIND each record specified by the RECORD-SOURCE.                */
  {src/adm/template/row-find.i "Contrato_hd"}
  {src/adm/template/row-find.i "Empresa"}

  /* Process the newly available records (i.e. display fields,
     open queries, and/or pass records on to any RECORD-TARGETS).    */
  {src/adm/template/row-end.i}

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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE inicia_combos V-table-Win 
PROCEDURE inicia_combos :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

  DEFINE VARIABLE ok AS LOGICAL.
  DEFINE VARIABLE lista AS CHARACTER.

  DO WITH FRAME {&FRAME-NAME}:
     {levantacombo.i &TABLA=Tipo_evento &NOMBRE=cdg_tipo_evento &CODIGO=nro_tipo_evento &OBJETO=contrato_hd.nro_tipo_evento}
  END.   
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE local-add-record V-table-Win 
PROCEDURE local-add-record :
/*------------------------------------------------------------------------------
  Purpose:     Override standard ADM method
  Notes:       
------------------------------------------------------------------------------*/

  /* Code placed here will execute PRIOR to standard behavior. */

  /* Dispatch standard ADM method.                             */
  RUN dispatch IN THIS-PROCEDURE ( INPUT 'add-record':U ) .

  /* Code placed here will execute AFTER standard behavior.    */

   {blanqueacodigo.i "Lista_precios"}
   {blanqueacodigo.i "Vendedor"} 
   {blanqueacodigo.i "Moneda"}
   {blanqueacodigo.i "Condicion_venta"}


END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE local-assign-statement V-table-Win 
PROCEDURE local-assign-statement :
/*------------------------------------------------------------------------------
  Purpose:     Override standard ADM method
  Notes:       
------------------------------------------------------------------------------*/

  /* Code placed here will execute PRIOR to standard behavior. */

   &SCOPED-DEFINE TABLA-MAESTRA  Contrato_hd

   {validartabla.i "Lista_precios" "cdg_lista" "descripcion" "CLIE008"} 
   {validartabla.i "Moneda" "cdg_moneda" "descripcion" "CLIE003"} 
   {validartabla.i "Vendedor" "cdg_vendedor" "nombre" "CLIE003"} 
   {validartabla.i "Condicion_venta" "cdg_cndventa" "descripcion" "CLIE009"}

   &UNDEFINE TABLA-MAESTRA

  /* Dispatch standard ADM method.                             */
  RUN dispatch IN THIS-PROCEDURE ( INPUT 'assign-statement':U ) .

  /* Code placed here will execute AFTER standard behavior.    */

   &SCOPED-DEFINE TABLA-MAESTRA  Contrato_hd

   {asignartabla.i "Lista_precios" "cdg_lista" "cdg_lista"}
   {asignartabla.i "Vendedor" "nro_vendedor" "nro_vendedor"} 
   {asignartabla.i "Cliente" "nro_cliente" "nro_cliente"} 
   {asignartabla.i "Moneda" "nro_moneda" "nro_moneda"} 
   {asignartabla.i "Condicion_venta" "nro_cndventa" "nro_cndventa" }

   &UNDEFINE TABLA-MAESTRA

   {findempresa.i}

   IF NEW Contrato_hd
   THEN DO:
       ASSIGN Contrato_hd.nro_cliente  = Cliente.nro_cliente
              Contrato_hd.cdg_empresa  = Empresa.cdg_empresa
              Contrato_hd.nro_contrato = NEXT-VALUE(proximo_contrato)
              Contrato_hd.num_contrato = Contrato_hd.nro_contrato.
              

       FIND FIRST Domicilio OF Cliente NO-LOCK.
       Contrato_hd.nro_domicilio = Domicilio.nro_domicilio.

   END.

   IF NOT CAN-FIND(FIRST Cta_cte 
                         WHERE Cta_cte.nro_cliente  = Contrato_hd.nro_cliente 
                           AND Cta_cte.nro_contrato = Contrato_hd.nro_contrato )
       THEN Contrato_hd.resto_periodos = Contrato_hd.cant_periodos.
   
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

   {deshabcodigo.i "Lista_precios"}
   {deshabcodigo.i "Vendedor"} 
   {deshabcodigo.i "Moneda"}
   {deshabcodigo.i "Condicion_venta"}

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE local-display-fields V-table-Win 
PROCEDURE local-display-fields :
/*------------------------------------------------------------------------------
  Purpose:     Override standard ADM method
  Notes:       
------------------------------------------------------------------------------*/

  /* Code placed here will execute PRIOR to standard behavior. */

  /* Dispatch standard ADM method.                             */
  RUN dispatch IN THIS-PROCEDURE ( INPUT 'display-fields':U ) .

  /* Code placed here will execute AFTER standard behavior.    */

  IF AVAILABLE Contrato_hd
  THEN DO:

      &SCOPED-DEFINE TABLA-MAESTRA  Contrato_hd
     
        {displaytabla.i "Lista_precios" "cdg_lista" "descripcion" "cdg_lista" "cdg_lista"} 
        {displaytabla.i "Vendedor" "cdg_vendedor" "nombre" "nro_vendedor" "nro_vendedor"} 
        {displaytabla.i "Moneda" "cdg_moneda" "descripcion" "nro_moneda" "nro_moneda"} 
        {displaytabla.i "Condicion_venta" "cdg_cndventa" "descripcion" "nro_cndventa" "nro_cndventa"} 

      &UNDEFINE TABLA-MAESTRA

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

  /* Code placed here will execute PRIOR to standard behavior. */

  /* Dispatch standard ADM method.                             */
  RUN dispatch IN THIS-PROCEDURE ( INPUT 'enable-fields':U ) .

  /* Code placed here will execute AFTER standard behavior.    */

   {habilcodigo.i "Lista_precios"}
   {habilcodigo.i "Vendedor"} 
   {habilcodigo.i "Moneda"}
   {habilcodigo.i "Condicion_venta"}


END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE local-initialize V-table-Win 
PROCEDURE local-initialize :
/*------------------------------------------------------------------------------
  Purpose:     Override standard ADM method
  Notes:       
------------------------------------------------------------------------------*/

  /* Code placed here will execute PRIOR to standard behavior. */

  /* Dispatch standard ADM method.                             */
  RUN dispatch IN THIS-PROCEDURE ( INPUT 'initialize':U ) .

  /* Code placed here will execute AFTER standard behavior.    */

  RUN inicia_combos.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE poner_titulo V-table-Win 
PROCEDURE poner_titulo :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
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
  {src/adm/template/snd-list.i "Empresa"}

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
      /* Object instance CASEs can go here to replace standard behavior
         or add new cases. */
      {src/adm/template/vstates.i}
  END CASE.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

