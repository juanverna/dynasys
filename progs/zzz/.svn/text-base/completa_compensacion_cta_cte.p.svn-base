/*=================================================================================*/
/*                      EMISION DE UN MOVIMIENTO DE CAJA                           */
/*=================================================================================*/

DEFINE INPUT PARAMETER que_movimiento AS ROWID.

/*=================================================================================*/
/*                  DEFINICION DE TABLAS TEMPORALES DE ASIENTOS                    */
/*=================================================================================*/

DEFINE TEMP-TABLE T-Fac_header               NO-UNDO LIKE Fac_header.               
DEFINE TEMP-TABLE T-Fac_header-bon           NO-UNDO LIKE Fac_header-bon.
DEFINE TEMP-TABLE T-Registrable-factura      NO-UNDO LIKE Registrable-factura.
DEFINE TEMP-TABLE T-Fac_detalle              NO-UNDO LIKE Fac_detalle.              
DEFINE TEMP-TABLE T-Fac_detalle-bon          NO-UNDO LIKE Fac_detalle-bon.
DEFINE TEMP-TABLE T-Sub_header_vta           NO-UNDO LIKE Sub_header_vta.           
DEFINE TEMP-TABLE T-Sub_detalle_vta          NO-UNDO LIKE Sub_detalle_vta.          
DEFINE TEMP-TABLE T-Fac_header_impuesto      NO-UNDO LIKE Fac_header_impuesto.      
DEFINE TEMP-TABLE T-Fac_detalle_impuesto     NO-UNDO LIKE Fac_detalle_impuesto.     
DEFINE TEMP-TABLE T-Asn_header               NO-UNDO LIKE Asn_header.
DEFINE TEMP-TABLE T-Asn_detalle              NO-UNDO LIKE Asn_detalle.
DEFINE TEMP-TABLE T-Asn_totales              NO-UNDO LIKE Asn_totales.

DEFINE BUFFER Moneda_local         FOR Moneda.

{modoscompensacion.i}
{parlocales.i}

/*=================================================================================*/
/*                              BLOQUE PRINCIPAL                                   */
/*=================================================================================*/

FIND Caj_header  WHERE ROWID(Caj_header) = que_movimiento NO-LOCK.

              /* Generacion de movimientos bancarios */

FOR EACH Caj_detalle OF Caj_header WHERE Caj_detalle.cdg_rubro = 40, Rubro OF Caj_detalle NO-LOCK: 
       
    FIND FIRST Rubro_comprobcc OF Rubro
         WHERE Rubro_comprobcc.cdg_empresa = Caj_header.cdg_empresa
           AND Rubro_comprobcc.cdg_ciclocomercial = "Ventas"
           AND Rubro_comprobcc.modo_relacion = MDCOM_CREDITO_CC
               NO-LOCK NO-ERROR.  

        IF AVAILABLE Rubro_comprobcc /* El rubro tiene compensación asociada */
        THEN DO:
            RUN compensar_cuenta_corriente.
        END.
END.

/*=================================================================================*/
/*                              PROCEDIMIENTOS                                     */
/*=================================================================================*/

PROCEDURE compensar_cuenta_corriente:
   
   DEFINE VARIABLE p-punto_venta  AS INTEGER.
   DEFINE VARIABLE p-cdg_concepto AS INTEGER.

   EMPTY TEMP-TABLE T-Fac_header.               
   EMPTY TEMP-TABLE T-Fac_detalle.              
   EMPTY TEMP-TABLE T-Sub_header_vta.           
   EMPTY TEMP-TABLE T-Sub_detalle_vta.          
   EMPTY TEMP-TABLE T-Fac_header_impuesto.      
   EMPTY TEMP-TABLE T-Fac_detalle_impuesto.     

   FIND Cliente OF Caj_header NO-LOCK.
   FIND FIRST Domicilio OF Cliente NO-LOCK.

   RUN getparametro_n.p (  INPUT  "COMPEPVT", OUTPUT p-punto_venta ).
   RUN getparametro_c.p (  INPUT  "COMPECNV", OUTPUT v-valor_c).
   FIND Condicion_venta WHERE Condicion_venta.cdg_cndventa = v-valor_c NO-LOCK.
   
   FIND Articulo OF Rubro_comprobcc NO-LOCK.
   FIND Imputacion OF Rubro_comprobcc NO-LOCK.

   FIND FIRST Domicilio OF Cliente NO-LOCK.
   FIND FIRST Moneda_local WHERE Moneda_local.es_local NO-LOCK.

   RUN getparametro_c.p (  INPUT  "DFDEPOSI", OUTPUT v-valor_c).
   FIND Deposito WHERE Deposito.cdg_deposito = v-valor_c NO-LOCK.

   CREATE T-Fac_header.
   BUFFER-COPY Caj_header TO T-Fac_header 
        ASSIGN T-Fac_header.origen            = "R"
               T-Fac_header.cdg_comprobante   = Rubro_comprobcc.cdg_comprobante
               T-Fac_header.estado            = "P"
               T-Fac_header.cta_cte           = YES 
               T-Fac_header.nro_factura       = 0
               T-Fac_header.hora              = ""
               T-Fac_header.fecha             = Caj_header.fecha
               T-Fac_header.fecha_iva         = T-Fac_header.fecha
               T-Fac_header.fecha_precios     = T-Fac_header.fecha
               T-Fac_header.cdg_imputacion    = p-cdg_concepto
               T-Fac_header.impreso           = ""
               T-Fac_header.cambio            = 1
               T-Fac_header.cdg_imputacion    = Imputacion.cdg_imputacion
               T-Fac_header.nro_cndventa      = Condicion_venta.nro_cndventa
               T-Fac_header.nro_moneda        = Moneda_local.nro_moneda
               T-Fac_header.nombre            = Cliente.nom_cliente
               T-Fac_header.direccion_leg     = Cliente.direccion
               T-Fac_header.localidad_leg     = Cliente.localidad
               T-Fac_header.cdg_postal_leg    = Cliente.cdg_postal
               T-Fac_header.cdg_provincia_leg = Cliente.cdg_provincia
               T-Fac_header.cdg_condiva       = Cliente.cdg_condiva
               T-Fac_header.nro_vendedor      = Cliente.nro_vendedor
               T-Fac_header.nombre_domicilio  = Domicilio.nombre
               T-Fac_header.nro_domicilio     = Domicilio.nro_domicilio
               T-Fac_header.direccion         = Domicilio.direccion
               T-Fac_header.cdg_provincia     = Domicilio.cdg_provincia
               T-Fac_header.localidad         = Domicilio.localidad
               T-Fac_header.cdg_postal        = Domicilio.cdg_postal
               T-Fac_header.cdg_zonag         = Domicilio.cdg_zonag
               T-Fac_header.imp_total         = ABS(Caj_detalle.importe)
               T-Fac_header.mes               = MONTH(T-Fac_header.fecha) 
               T-Fac_header.ano               = YEAR(T-Fac_header.fecha)
               T-Fac_header.nro_deposito      = Deposito.nro_deposito 
               T-Fac_header.prf_comprob       = p-punto_venta
               T-Fac_header.nro_comprob       = T-Fac_header.nro_factura.

   CREATE T-Fac_detalle.
   ASSIGN T-Fac_header.ultima_linea  = T-Fac_header.ultima_linea + 1
          T-Fac_detalle.nro_factura  = T-Fac_header.nro_factura
          T-Fac_detalle.nro_linea    = T-Fac_header.ultima_linea
          T-Fac_detalle.cantidad     = 1
          T-Fac_detalle.granel       = 1
          T-Fac_detalle.nro_articulo = Articulo.nro_articulo
          T-Fac_detalle.detallada    = "" /*T-Rec_detalle.tip_cancela + "-" + STRING(T-Rec_detalle.prf_cancela,"9999") + "-" + STRING(T-Rec_detalle.nro_cancela,"99999999") 
                                       + " " + STRING(T-Rec_detalle.importe,">>>>>9.99-") 
                                       + " " + STRING(T-Rec_detalle.prc_difcambio,">>9.99")
                                       + " " + STRING(T-Rec_detalle.new_cambio,">>>>9.9999")
                                       + " " + STRING(T-Rec_detalle.cambio,">>>>9.9999")*/
          T-Fac_detalle.precio       = T-Fac_header.imp_total.

   RUN emitir_comprobante_cliente.p ( INPUT-OUTPUT TABLE T-Fac_header,
                                      INPUT-OUTPUT TABLE T-Fac_detalle,
                                      INPUT-OUTPUT TABLE T-Registrable-factura,
                                      INPUT-OUTPUT TABLE T-Sub_header_vta,
                                      INPUT-OUTPUT TABLE T-Sub_detalle_vta,
                                      INPUT-OUTPUT TABLE T-Fac_header-bon,
                                      INPUT-OUTPUT TABLE T-Fac_detalle-bon,
                                      INPUT-OUTPUT TABLE T-Fac_header_impuesto,
                                      INPUT-OUTPUT TABLE T-Fac_detalle_impuesto).

END PROCEDURE.
