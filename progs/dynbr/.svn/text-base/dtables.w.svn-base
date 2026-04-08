&ANALYZE-SUSPEND _VERSION-NUMBER AB_v10r12 GUI ADM2
&ANALYZE-RESUME
/* Connected Databases 
          sic              PROGRESS
*/
&Scoped-define WINDOW-NAME CURRENT-WINDOW
{adecomm/appserv.i}
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _DEFINITIONS dTables 
/*------------------------------------------------------------------------

  File:  

  Description: from DATA.W - Template For SmartData objects in the ADM

  Input Parameters:
      <none>

  Output Parameters:
      <none>

  Modified:     February 24, 1999
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

&glob DATA-LOGIC-PROCEDURE .p

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE SmartDataObject
&Scoped-define DB-AWARE yes

&Scoped-define ADM-SUPPORTED-LINKS Data-Source,Data-Target,Navigation-Target,Update-Target,Commit-Target,Filter-Target


/* Db-Required definitions. */
&IF DEFINED(DB-REQUIRED) = 0 &THEN
    &GLOBAL-DEFINE DB-REQUIRED TRUE
&ENDIF
&GLOBAL-DEFINE DB-REQUIRED-START   &IF {&DB-REQUIRED} &THEN
&GLOBAL-DEFINE DB-REQUIRED-END     &ENDIF


&Scoped-define QUERY-NAME Query-Main

/* Internal Tables (found by Frame, Query & Browse Queries)             */
&Scoped-define INTERNAL-TABLES Fac_header

/* Definitions for QUERY Query-Main                                     */
&Scoped-Define ENABLED-FIELDS  afecta_stock ano anulado aplica_minimos cai cambio cambio_dolar cant_hojas~
 cdg_administrador cdg_comprobante cdg_condiva cdg_empresa cdg_imputacion~
 cdg_lista cdg_postal cdg_postal_leg cdg_provincia cdg_provincia_leg~
 cdg_zonag clausula_dolar codigo_cliente cta_cte cuit direccion~
 direccion_administrador direccion_leg estado fecha fecha_grab fecha_iva~
 fecha_ocm fecha_precios hora hora_grab ibrutos_sino impreso imp_bruto~
 imp_descuentos imp_iva imp_neto imp_total leyenda leyenda_cc localidad~
 localidad_administrador localidad_leg mes modo_abasto modo_remito~
 monto_letras mostrar_admin nombre nombre_domicilio nombre_leg~
 nom_Administrador nro_administrador nro_cliente nro_cndventa nro_comprob~
 nro_contrato nro_deposito nro_domicilio nro_entidad nro_factura nro_moneda~
 nro_obra nro_ocm nro_remito nro_transaccion nro_usuario nro_vendedor~
 num_sucursal observacion origen pc_name prc_canje prf_comprob proc_estad~
 rige_hasta texto_condicion_venta texto_iva tip_comprob ultima_linea
&Scoped-define ENABLED-FIELDS-IN-Fac_header afecta_stock ano anulado ~
aplica_minimos cai cambio cambio_dolar cant_hojas cdg_administrador ~
cdg_comprobante cdg_condiva cdg_empresa cdg_imputacion cdg_lista cdg_postal ~
cdg_postal_leg cdg_provincia cdg_provincia_leg cdg_zonag clausula_dolar ~
codigo_cliente cta_cte cuit direccion direccion_administrador direccion_leg ~
estado fecha fecha_grab fecha_iva fecha_ocm fecha_precios hora hora_grab ~
ibrutos_sino impreso imp_bruto imp_descuentos imp_iva imp_neto imp_total ~
leyenda leyenda_cc localidad localidad_administrador localidad_leg mes ~
modo_abasto modo_remito monto_letras mostrar_admin nombre nombre_domicilio ~
nombre_leg nom_Administrador nro_administrador nro_cliente nro_cndventa ~
nro_comprob nro_contrato nro_deposito nro_domicilio nro_entidad nro_factura ~
nro_moneda nro_obra nro_ocm nro_remito nro_transaccion nro_usuario ~
nro_vendedor num_sucursal observacion origen pc_name prc_canje prf_comprob ~
proc_estad rige_hasta texto_condicion_venta texto_iva tip_comprob ~
ultima_linea 
&Scoped-Define DATA-FIELDS  afecta_stock ano anulado aplica_minimos cai cambio cambio_dolar cant_hojas~
 cdg_administrador cdg_comprobante cdg_condiva cdg_empresa cdg_imputacion~
 cdg_lista cdg_postal cdg_postal_leg cdg_provincia cdg_provincia_leg~
 cdg_zonag clausula_dolar codigo_cliente cta_cte cuit direccion~
 direccion_administrador direccion_leg estado fecha fecha_grab fecha_iva~
 fecha_ocm fecha_precios hora hora_grab ibrutos_sino impreso imp_bruto~
 imp_descuentos imp_iva imp_neto imp_total leyenda leyenda_cc localidad~
 localidad_administrador localidad_leg mes modo_abasto modo_remito~
 monto_letras mostrar_admin nombre nombre_domicilio nombre_leg~
 nom_Administrador nro_administrador nro_cliente nro_cndventa nro_comprob~
 nro_contrato nro_deposito nro_domicilio nro_entidad nro_factura nro_moneda~
 nro_obra nro_ocm nro_remito nro_transaccion nro_usuario nro_vendedor~
 num_sucursal observacion origen pc_name prc_canje prf_comprob proc_estad~
 rige_hasta texto_condicion_venta texto_iva tip_comprob ultima_linea
&Scoped-define DATA-FIELDS-IN-Fac_header afecta_stock ano anulado ~
aplica_minimos cai cambio cambio_dolar cant_hojas cdg_administrador ~
cdg_comprobante cdg_condiva cdg_empresa cdg_imputacion cdg_lista cdg_postal ~
cdg_postal_leg cdg_provincia cdg_provincia_leg cdg_zonag clausula_dolar ~
codigo_cliente cta_cte cuit direccion direccion_administrador direccion_leg ~
estado fecha fecha_grab fecha_iva fecha_ocm fecha_precios hora hora_grab ~
ibrutos_sino impreso imp_bruto imp_descuentos imp_iva imp_neto imp_total ~
leyenda leyenda_cc localidad localidad_administrador localidad_leg mes ~
modo_abasto modo_remito monto_letras mostrar_admin nombre nombre_domicilio ~
nombre_leg nom_Administrador nro_administrador nro_cliente nro_cndventa ~
nro_comprob nro_contrato nro_deposito nro_domicilio nro_entidad nro_factura ~
nro_moneda nro_obra nro_ocm nro_remito nro_transaccion nro_usuario ~
nro_vendedor num_sucursal observacion origen pc_name prc_canje prf_comprob ~
proc_estad rige_hasta texto_condicion_venta texto_iva tip_comprob ~
ultima_linea 
&Scoped-Define MANDATORY-FIELDS  nombre nombre_domicilio nombre_leg nom_Administrador nro_domicilio
&Scoped-Define APPLICATION-SERVICE 
&Scoped-Define ASSIGN-LIST 
&Scoped-Define DATA-FIELD-DEFS "dynbr/dtables.i"
&Scoped-Define DATA-TABLE-NO-UNDO NO-UNDO
&Scoped-define QUERY-STRING-Query-Main FOR EACH Fac_header NO-LOCK INDEXED-REPOSITION
{&DB-REQUIRED-START}
&Scoped-define OPEN-QUERY-Query-Main OPEN QUERY Query-Main FOR EACH Fac_header NO-LOCK INDEXED-REPOSITION.
{&DB-REQUIRED-END}
&Scoped-define TABLES-IN-QUERY-Query-Main Fac_header
&Scoped-define FIRST-TABLE-IN-QUERY-Query-Main Fac_header


/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME



/* ***********************  Control Definitions  ********************** */

{&DB-REQUIRED-START}

/* Query definitions                                                    */
&ANALYZE-SUSPEND
DEFINE QUERY Query-Main FOR 
      Fac_header SCROLLING.
&ANALYZE-RESUME
{&DB-REQUIRED-END}


/* ************************  Frame Definitions  *********************** */


/* *********************** Procedure Settings ************************ */

&ANALYZE-SUSPEND _PROCEDURE-SETTINGS
/* Settings for THIS-PROCEDURE
   Type: SmartDataObject
   Allow: Query
   Frames: 0
   Add Fields to: Neither
   Other Settings: PERSISTENT-ONLY COMPILE APPSERVER DB-AWARE
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
  CREATE WINDOW dTables ASSIGN
         HEIGHT             = 1.62
         WIDTH              = 46.6.
/* END WINDOW DEFINITION */
                                                                        */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _INCLUDED-LIB dTables 
/* ************************* Included-Libraries *********************** */

{src/adm2/data.i}

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME




/* ***********  Runtime Attributes and AppBuilder Settings  *********** */

&ANALYZE-SUSPEND _RUN-TIME-ATTRIBUTES
/* SETTINGS FOR WINDOW dTables
  VISIBLE,,RUN-PERSISTENT                                               */
/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME


/* Setting information for Queries and Browse Widgets fields            */

&ANALYZE-SUSPEND _QUERY-BLOCK QUERY Query-Main
/* Query rebuild information for SmartDataObject Query-Main
     _TblList          = "sic.Fac_header"
     _Options          = "NO-LOCK INDEXED-REPOSITION"
     _FldNameList[1]   > sic.Fac_header.afecta_stock
"afecta_stock" "afecta_stock" ? ? "logical" ? ? ? ? ? ? yes ? no 12.4 yes ?
     _FldNameList[2]   > sic.Fac_header.ano
"ano" "ano" ? ? "integer" ? ? ? ? ? ? yes ? no 10.8 yes ?
     _FldNameList[3]   > sic.Fac_header.anulado
"anulado" "anulado" ? ? "logical" ? ? ? ? ? ? yes ? no 7.8 yes ?
     _FldNameList[4]   > sic.Fac_header.aplica_minimos
"aplica_minimos" "aplica_minimos" ? ? "logical" ? ? ? ? ? ? yes ? no 8 yes ?
     _FldNameList[5]   > sic.Fac_header.cai
"cai" "cai" ? ? "character" ? ? ? ? ? ? yes ? no 25 yes ?
     _FldNameList[6]   > sic.Fac_header.cambio
"cambio" "cambio" ? ? "decimal" ? ? ? ? ? ? yes ? no 12.6 yes ?
     _FldNameList[7]   > sic.Fac_header.cambio_dolar
"cambio_dolar" "cambio_dolar" ? ? "decimal" ? ? ? ? ? ? yes ? no 12.6 yes ?
     _FldNameList[8]   > sic.Fac_header.cant_hojas
"cant_hojas" "cant_hojas" ? ? "integer" ? ? ? ? ? ? yes ? no 10.2 yes ?
     _FldNameList[9]   > sic.Fac_header.cdg_administrador
"cdg_administrador" "cdg_administrador" ? ? "character" ? ? ? ? ? ? yes ? no 8 yes ?
     _FldNameList[10]   > sic.Fac_header.cdg_comprobante
"cdg_comprobante" "cdg_comprobante" ? ? "character" ? ? ? ? ? ? yes ? no 8 yes ?
     _FldNameList[11]   > sic.Fac_header.cdg_condiva
"cdg_condiva" "cdg_condiva" ? ? "integer" ? ? ? ? ? ? yes ? no 5.6 yes ?
     _FldNameList[12]   > sic.Fac_header.cdg_empresa
"cdg_empresa" "cdg_empresa" ? ? "character" ? ? ? ? ? ? yes ? no 8 yes ?
     _FldNameList[13]   > sic.Fac_header.cdg_imputacion
"cdg_imputacion" "cdg_imputacion" ? ? "integer" ? ? ? ? ? ? yes ? no 11.2 yes ?
     _FldNameList[14]   > sic.Fac_header.cdg_lista
"cdg_lista" "cdg_lista" ? ? "integer" ? ? ? ? ? ? yes ? no 4 yes ?
     _FldNameList[15]   > sic.Fac_header.cdg_postal
"cdg_postal" "cdg_postal" ? ? "character" ? ? ? ? ? ? yes ? no 13 yes ?
     _FldNameList[16]   > sic.Fac_header.cdg_postal_leg
"cdg_postal_leg" "cdg_postal_leg" ? ? "character" ? ? ? ? ? ? yes ? no 13 yes ?
     _FldNameList[17]   > sic.Fac_header.cdg_provincia
"cdg_provincia" "cdg_provincia" ? ? "character" ? ? ? ? ? ? yes ? no 8.8 yes ?
     _FldNameList[18]   > sic.Fac_header.cdg_provincia_leg
"cdg_provincia_leg" "cdg_provincia_leg" ? ? "character" ? ? ? ? ? ? yes ? no 8.8 yes ?
     _FldNameList[19]   > sic.Fac_header.cdg_zonag
"cdg_zonag" "cdg_zonag" ? ? "character" ? ? ? ? ? ? yes ? no 20.2 yes ?
     _FldNameList[20]   > sic.Fac_header.clausula_dolar
"clausula_dolar" "clausula_dolar" ? ? "logical" ? ? ? ? ? ? yes ? no 13.6 yes ?
     _FldNameList[21]   > sic.Fac_header.codigo_cliente
"codigo_cliente" "codigo_cliente" ? ? "character" ? ? ? ? ? ? yes ? no 8.4 yes ?
     _FldNameList[22]   > sic.Fac_header.cta_cte
"cta_cte" "cta_cte" ? ? "logical" ? ? ? ? ? ? yes ? no 5.8 yes ?
     _FldNameList[23]   > sic.Fac_header.cuit
"cuit" "cuit" ? ? "character" ? ? ? ? ? ? yes ? no 15 yes ?
     _FldNameList[24]   > sic.Fac_header.direccion
"direccion" "direccion" ? ? "character" ? ? ? ? ? ? yes ? no 45 yes ?
     _FldNameList[25]   > sic.Fac_header.direccion_administrador
"direccion_administrador" "direccion_administrador" ? ? "character" ? ? ? ? ? ? yes ? no 45 yes ?
     _FldNameList[26]   > sic.Fac_header.direccion_leg
"direccion_leg" "direccion_leg" ? ? "character" ? ? ? ? ? ? yes ? no 45 yes ?
     _FldNameList[27]   > sic.Fac_header.estado
"estado" "estado" ? ? "character" ? ? ? ? ? ? yes ? no 2.6 yes ?
     _FldNameList[28]   > sic.Fac_header.fecha
"fecha" "fecha" ? ? "date" ? ? ? ? ? ? yes ? no 11.6 yes ?
     _FldNameList[29]   > sic.Fac_header.fecha_grab
"fecha_grab" "fecha_grab" ? ? "date" ? ? ? ? ? ? yes ? no 11.6 yes ?
     _FldNameList[30]   > sic.Fac_header.fecha_iva
"fecha_iva" "fecha_iva" ? ? "date" ? ? ? ? ? ? yes ? no 11.6 yes ?
     _FldNameList[31]   > sic.Fac_header.fecha_ocm
"fecha_ocm" "fecha_ocm" ? ? "date" ? ? ? ? ? ? yes ? no 11.6 yes ?
     _FldNameList[32]   > sic.Fac_header.fecha_precios
"fecha_precios" "fecha_precios" ? ? "date" ? ? ? ? ? ? yes ? no 13.6 yes ?
     _FldNameList[33]   > sic.Fac_header.hora
"hora" "hora" ? ? "character" ? ? ? ? ? ? yes ? no 8 yes ?
     _FldNameList[34]   > sic.Fac_header.hora_grab
"hora_grab" "hora_grab" ? ? "integer" ? ? ? ? ? ? yes ? no 10.2 yes ?
     _FldNameList[35]   > sic.Fac_header.ibrutos_sino
"ibrutos_sino" "ibrutos_sino" ? ? "logical" ? ? ? ? ? ? yes ? no 7.2 yes ?
     _FldNameList[36]   > sic.Fac_header.impreso
"impreso" "impreso" ? ? "character" ? ? ? ? ? ? yes ? no 7.4 yes ?
     _FldNameList[37]   > sic.Fac_header.imp_bruto
"imp_bruto" "imp_bruto" ? ? "decimal" ? ? ? ? ? ? yes ? no 17.4 yes ?
     _FldNameList[38]   > sic.Fac_header.imp_descuentos
"imp_descuentos" "imp_descuentos" ? ? "decimal" ? ? ? ? ? ? yes ? no 17.4 yes ?
     _FldNameList[39]   > sic.Fac_header.imp_iva
"imp_iva" "imp_iva" ? ? "decimal" ? ? ? ? ? ? yes ? no 17.4 yes ?
     _FldNameList[40]   > sic.Fac_header.imp_neto
"imp_neto" "imp_neto" ? ? "decimal" ? ? ? ? ? ? yes ? no 17.4 yes ?
     _FldNameList[41]   > sic.Fac_header.imp_total
"imp_servicio" "imp_servicio" ? ? "decimal" ? ? ? ? ? ? yes ? no 17.4 yes ?
     _FldNameList[42]   > sic.Fac_header.leyenda
"leyenda" "leyenda" ? ? "character" ? ? ? ? ? ? yes ? no 300 yes ?
     _FldNameList[43]   > sic.Fac_header.leyenda_cc
"leyenda_cc" "leyenda_cc" ? ? "character" ? ? ? ? ? ? yes ? no 50 yes ?
     _FldNameList[44]   > sic.Fac_header.localidad
"localidad" "localidad" ? ? "character" ? ? ? ? ? ? yes ? no 15 yes ?
     _FldNameList[45]   > sic.Fac_header.localidad_administrador
"localidad_administrador" "localidad_administrador" ? ? "character" ? ? ? ? ? ? yes ? no 30 yes ?
     _FldNameList[46]   > sic.Fac_header.localidad_leg
"localidad_leg" "localidad_leg" ? ? "character" ? ? ? ? ? ? yes ? no 15 yes ?
     _FldNameList[47]   > sic.Fac_header.mes
"mes" "mes" ? ? "integer" ? ? ? ? ? ? yes ? no 11 yes ?
     _FldNameList[48]   > sic.Fac_header.modo_abasto
"modo_abasto" "modo_abasto" ? ? "character" ? ? ? ? ? ? yes ? no 8 yes ?
     _FldNameList[49]   > sic.Fac_header.modo_remito
"modo_remito" "modo_remito" ? ? "character" ? ? ? ? ? ? yes ? no 12.6 yes ?
     _FldNameList[50]   > sic.Fac_header.monto_letras
"monto_letras" "monto_letras" ? ? "character" ? ? ? ? ? ? yes ? no 60 yes ?
     _FldNameList[51]   > sic.Fac_header.mostrar_admin
"mostrar_admin" "mostrar_admin" ? ? "logical" ? ? ? ? ? ? yes ? no 14.6 yes ?
     _FldNameList[52]   > sic.Fac_header.nombre
"nombre" "nombre" ? ? "character" ? ? ? ? ? ? yes ? yes 40 yes ?
     _FldNameList[53]   > sic.Fac_header.nombre_domicilio
"nombre_domicilio" "nombre_domicilio" ? ? "character" ? ? ? ? ? ? yes ? yes 40 yes ?
     _FldNameList[54]   > sic.Fac_header.nombre_leg
"nombre_leg" "nombre_leg" ? ? "character" ? ? ? ? ? ? yes ? yes 40 yes ?
     _FldNameList[55]   > sic.Fac_header.nom_Administrador
"nom_Administrador" "nom_Administrador" ? ? "character" ? ? ? ? ? ? yes ? yes 40 yes ?
     _FldNameList[56]   > sic.Fac_header.nro_administrador
"nro_administrador" "nro_administrador" ? ? "integer" ? ? ? ? ? ? yes ? no 11.8 yes ?
     _FldNameList[57]   > sic.Fac_header.nro_cliente
"nro_cliente" "nro_cliente" ? ? "integer" ? ? ? ? ? ? yes ? no 10.4 yes ?
     _FldNameList[58]   > sic.Fac_header.nro_cndventa
"nro_cndventa" "nro_cndventa" ? ? "integer" ? ? ? ? ? ? yes ? no 10.4 yes ?
     _FldNameList[59]   > sic.Fac_header.nro_comprob
"nro_comprob" "nro_comprob" ? ? "integer" ? ? ? ? ? ? yes ? no 11 yes ?
     _FldNameList[60]   > sic.Fac_header.nro_contrato
"nro_contrato" "nro_contrato" ? ? "integer" ? ? ? ? ? ? yes ? no 12 yes ?
     _FldNameList[61]   > sic.Fac_header.nro_deposito
"nro_deposito" "nro_deposito" ? ? "integer" ? ? ? ? ? ? yes ? no 12.4 yes ?
     _FldNameList[62]   > sic.Fac_header.nro_domicilio
"nro_domicilio" "nro_domicilio" ? ? "integer" ? ? ? ? ? ? yes ? yes 12 yes ?
     _FldNameList[63]   > sic.Fac_header.nro_entidad
"nro_entidad" "nro_entidad" ? ? "integer" ? ? ? ? ? ? yes ? no 11.8 yes ?
     _FldNameList[64]   > sic.Fac_header.nro_factura
"nro_factura" "nro_factura" ? ? "integer" ? ? ? ? ? ? yes ? no 11.2 yes ?
     _FldNameList[65]   > sic.Fac_header.nro_moneda
"nro_moneda" "nro_moneda" ? ? "integer" ? ? ? ? ? ? yes ? no 7.8 yes ?
     _FldNameList[66]   > sic.Fac_header.nro_obra
"nro_obra" "nro_obra" ? ? "integer" ? ? ? ? ? ? yes ? no 10.2 yes ?
     _FldNameList[67]   > sic.Fac_header.nro_ocm
"nro_ocm" "nro_ocm" ? ? "character" ? ? ? ? ? ? yes ? no 10 yes ?
     _FldNameList[68]   > sic.Fac_header.nro_remito
"nro_remito" "nro_remito" ? ? "integer" ? ? ? ? ? ? yes ? no 11 yes ?
     _FldNameList[69]   > sic.Fac_header.nro_transaccion
"nro_transaccion" "nro_transaccion" ? ? "integer" ? ? ? ? ? ? yes ? no 10.2 yes ?
     _FldNameList[70]   > sic.Fac_header.nro_usuario
"nro_usuario" "nro_usuario" ? ? "integer" ? ? ? ? ? ? yes ? no 6.6 yes ?
     _FldNameList[71]   > sic.Fac_header.nro_vendedor
"nro_vendedor" "nro_vendedor" ? ? "integer" ? ? ? ? ? ? yes ? no 9.6 yes ?
     _FldNameList[72]   > sic.Fac_header.num_sucursal
"num_sucursal" "num_sucursal" ? ? "character" ? ? ? ? ? ? yes ? no 18 yes ?
     _FldNameList[73]   > sic.Fac_header.observacion
"observacion" "observacion" ? ? "character" ? ? ? ? ? ? yes ? no 40 yes ?
     _FldNameList[74]   > sic.Fac_header.origen
"origen" "origen" ? ? "character" ? ? ? ? ? ? yes ? no 6.2 yes ?
     _FldNameList[75]   > sic.Fac_header.pc_name
"pc_name" "pc_name" ? ? "character" ? ? ? ? ? ? yes ? no 15 yes ?
     _FldNameList[76]   > sic.Fac_header.prc_canje
"prc_canje" "prc_canje" ? ? "decimal" ? ? ? ? ? ? yes ? no 15.4 yes ?
     _FldNameList[77]   > sic.Fac_header.prf_comprob
"prf_comprob" "prf_comprob" ? ? "integer" ? ? ? ? ? ? yes ? no 5.8 yes ?
     _FldNameList[78]   > sic.Fac_header.proc_estad
"proc_estad" "proc_estad" ? ? "logical" ? ? ? ? ? ? yes ? no 22 yes ?
     _FldNameList[79]   > sic.Fac_header.rige_hasta
"rige_hasta" "rige_hasta" ? ? "date" ? ? ? ? ? ? yes ? no 11.6 yes ?
     _FldNameList[80]   > sic.Fac_header.texto_condicion_venta
"texto_condicion_venta" "texto_condicion_venta" ? ? "character" ? ? ? ? ? ? yes ? no 50 yes ?
     _FldNameList[81]   > sic.Fac_header.texto_iva
"texto_iva" "texto_iva" ? ? "character" ? ? ? ? ? ? yes ? no 25 yes ?
     _FldNameList[82]   > sic.Fac_header.tip_comprob
"tip_comprob" "tip_comprob" ? ? "character" ? ? ? ? ? ? yes ? no 4.2 yes ?
     _FldNameList[83]   > sic.Fac_header.ultima_linea
"ultima_linea" "ultima_linea" ? ? "integer" ? ? ? ? ? ? yes ? no 7.6 yes ?
     _Design-Parent    is WINDOW dTables @ ( 1.14 , 2.6 )
*/  /* QUERY Query-Main */
&ANALYZE-RESUME

 


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _MAIN-BLOCK dTables 


/* ***************************  Main Block  *************************** */

  &IF DEFINED(UIB_IS_RUNNING) <> 0 &THEN          
    RUN initializeObject.
  &ENDIF

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


/* **********************  Internal Procedures  *********************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE disable_UI dTables  _DEFAULT-DISABLE
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
  IF THIS-PROCEDURE:PERSISTENT THEN DELETE PROCEDURE THIS-PROCEDURE.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

