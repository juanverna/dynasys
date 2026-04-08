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

FOR EACH Caj_detalle OF Caj_header, Rubro OF Caj_detalle NO-LOCK: 
       
    CASE Rubro.tipo:
 
         WHEN "A"  /* Acreditación Bancaria */
         THEN DO:
 
              CREATE Cta_cte_bco.
              ASSIGN Cta_cte_bco.tip_comprob     = Caj_header.tip_comprob
                     Cta_cte_bco.prf_comprob     = Caj_header.prf_comprob
                     Cta_cte_bco.nro_comprob     = Caj_header.nro_comprob
                     Cta_cte_bco.nro_transaccion = Caj_header.nro_transaccion
                     Cta_cte_bco.fecha_efectiva  = Caj_header.fecha
                     Cta_cte_bco.fecha_movimto   = Caj_header.fecha
                     Cta_cte_bco.credito         = Caj_detalle.importe
                     Cta_cte_bco.debito          = 0
                     Cta_cte_bco.cdg_cuenta_ban  = Caj_detalle.cdg_cuenta_ban
                     Cta_cte_bco.nro_cuenta      = 0
                     Cta_cte_bco.leyenda         = Caj_detalle.observacion.
 
 
         END.
 
         WHEN "B"  /* Debito Bancario */
         THEN DO:
 
              CREATE Cta_cte_bco.
              ASSIGN Cta_cte_bco.tip_comprob     = Caj_header.tip_comprob
                     Cta_cte_bco.prf_comprob     = Caj_header.prf_comprob
                     Cta_cte_bco.nro_comprob     = Caj_header.nro_comprob
                     Cta_cte_bco.nro_transaccion = Caj_header.nro_transaccion
                     Cta_cte_bco.fecha_efectiva  = Caj_header.fecha
                     Cta_cte_bco.fecha_movimto   = Caj_header.fecha
                     Cta_cte_bco.credito         = 0
                     Cta_cte_bco.debito          = Caj_detalle.importe
                     Cta_cte_bco.cdg_cuenta_ban  = Caj_detalle.cdg_cuenta_ban
                     Cta_cte_bco.nro_cuenta      = 0
                     Cta_cte_bco.leyenda         = Caj_detalle.observacion.
 
         END.
 
         WHEN "P"  /* Cheque Propio */
         THEN DO:
 
              FIND Cheque OF Caj_detalle NO-LOCK.
              FIND Cuenta_bancaria OF Cheque NO-LOCK.
              IF NOT Cuenta_bancaria.ficticia /* No es una cuenta ficticia, cheques reales */
              THEN DO:
   
                  /* ----------------------------------------------------------------- */
                  /* Si las dos cuentas son iguales, no hay "Cheques en circulacion" y */
                  /* debe generarse el correspondiente movimiento bancario. Dado que   */
                  /* contabilizamos en el movimiento de tesorería, la cuenta asociada  */
                  /* al movimiento bancario no existe y por tanto el campo queda CERO  */
                  /* ----------------------------------------------------------------- */

                  IF Cuenta_bancaria.nro_cuenta_acredita = Cuenta_bancaria.nro_cuenta_emision
                  THEN DO:
                      CREATE Cta_cte_bco.
                      ASSIGN Cta_cte_bco.tip_comprob     = "CH"
                             Cta_cte_bco.prf_comprob     = Caj_header.prf_comprob
                             Cta_cte_bco.nro_comprob     = Cheque.numero_cheque
                             Cta_cte_bco.nro_transaccion = Caj_header.nro_transaccion
                             Cta_cte_bco.fecha_efectiva  = Cheque.fecha_deposito
                             Cta_cte_bco.fecha_movimto   = Caj_header.fecha
                             Cta_cte_bco.credito         = 0
                             Cta_cte_bco.debito          = Caj_detalle.importe
                             Cta_cte_bco.cdg_cuenta_ban  = Cuenta_bancaria.cdg_cuenta_ban
                             Cta_cte_bco.nro_cuenta      = 0 /* Esta bien el CERO !!!!*/
                             Cta_cte_bco.nro_cheque      = Cheque.nro_cheque
                             Cta_cte_bco.leyenda         = Cheque.observacion.
                  END.

              END.            

         END.
 
         WHEN "V" /* Valores de Terceros */ 
         THEN DO:

              FIND Valor OF Caj_detalle EXCLUSIVE-LOCK.
              IF Caj_detalle.tipo_mov = "E" 
              THEN DO:
                  ASSIGN Valor.estado =  "10" 
                         Valor.nro_proveedor = Caj_header.nro_proveedor
                         Valor.fecha_salida = Caj_header.fecha.
              END.
              ELSE DO:
                  ASSIGN Valor.estado =  "00" 
                         Valor.nro_proveedor = 0
                         Valor.fecha_salida = ?.
                  IF Caj_detalle.tipo_mov = "I"
                      THEN Valor.cdg_rubro = Caj_detalle.cdg_rubro.
              END.
              
              RELEASE Valor.

         END.
 
    END CASE. 

    /* ----------------------------------------------------------------------- */
    /* Chequea si debe compensarse la cuenta corriente del cliente o proveedor */
    /* ----------------------------------------------------------------------- */

    IF Caj_header.tipo_mov = "I" /* Es un INGRESO, Chequea C.C. de Clientes */
    THEN DO:
        IF Caj_detalle.importe > 0 /* importe > 0 implica compensa saldo a favor */
        THEN DO:                            
            FIND FIRST Rubro_comprobcc OF Rubro
                 WHERE Rubro_comprobcc.cdg_empresa = Caj_header.cdg_empresa
                   AND Rubro_comprobcc.cdg_ciclocomercial = "Ventas"
                   AND Rubro_comprobcc.modo_relacion = MDCOM_DEBITO_CC
                       NO-LOCK NO-ERROR.  
        END.
        ELSE DO:
            FIND FIRST Rubro_comprobcc OF Rubro
                 WHERE Rubro_comprobcc.cdg_empresa = Caj_header.cdg_empresa
                   AND Rubro_comprobcc.cdg_ciclocomercial = "Ventas"
                   AND Rubro_comprobcc.modo_relacion = MDCOM_CREDITO_CC
                       NO-LOCK NO-ERROR.  
        END.

        IF AVAILABLE Rubro_comprobcc /* El rubro tiene compensación asociada */
        THEN DO:
            RUN compensar_cuenta_corriente.
        END.


    END.

END.

RUN calcular_asiento_contable.

/*---------------------------------------------------------------------------------*/
/*                         BAJA EL ASIENTO CONTABLE                                */
/*---------------------------------------------------------------------------------*/

FIND FIRST T-Asn_header.

FIND Parametro 
     WHERE Parametro.cdg_empresa = Caj_header.cdg_empresa
       AND Parametro.cdg_parametro = "PROXNASN"
           EXCLUSIVE-LOCK.

ASSIGN T-Asn_header.nro_comprob     = Parametro.valor_n
       Parametro.valor_n            = Parametro.valor_n + 1
       T-Asn_header.cdg_estado      = "0"
       T-Asn_header.nro_idcabecera  = Caj_header.nro_transaccion.

CREATE Asn_header.
BUFFER-COPY T-Asn_header TO Asn_header
    ASSIGN Asn_header.nro_asiento   = NEXT-VALUE(proximo_asiento).

FOR EACH T-Asn_detalle OF T-Asn_header:
    CREATE Asn_detalle.
    BUFFER-COPY T-Asn_detalle TO Asn_detalle 
                ASSIGN Asn_detalle.nro_asiento = Asn_header.nro_asiento.
END.

FOR EACH T-Asn_totales OF T-Asn_header:
    CREATE Asn_totales.
    BUFFER-COPY T-Asn_totales TO Asn_totales 
                ASSIGN Asn_totales.nro_asiento = Asn_header.nro_asiento.
END.

RELEASE Asn_header.
RELEASE Asn_detalle.
RELEASE Asn_totales.

/*=================================================================================*/
/*                              PROCEDIMIENTOS                                     */
/*=================================================================================*/

PROCEDURE calcular_asiento_contable:

   FIND Tipocomprobante OF Caj_header NO-LOCK NO-ERROR.
   IF NOT AVAILABLE Tipocomprobante
   THEN DO:
       MESSAGE "NO se puede generar imputacion contable del movimiento. No se encuentra el comprobante:" Caj_header.cdg_comprobante
           VIEW-AS ALERT-BOX ERROR TITLE "ERROR DE IMPLEMENTACION".
       RETURN ERROR.
   END.

   CREATE T-Asn_header.
   ASSIGN T-Asn_header.cambio             = Caj_header.cambio
          T-Asn_header.cambio_dolar       = Caj_header.cambio_dolar  
          T-Asn_header.cdg_estadoasiento  = "I"
          T-Asn_header.cdg_librocontable  = "ZZZ"                
          T-Asn_header.fecha_grab         = TODAY                
          T-Asn_header.hora_grab          = TIME                 
          T-Asn_header.nro_entidad        = 0                    
          T-Asn_header.nro_idcabecera     = Caj_header.nro_transaccion
          T-Asn_header.nro_secuencia      = 0                     
          T-Asn_header.num_sucursal       = ""                    
          T-Asn_header.observacion        = Caj_header.observacion                    
          T-Asn_header.pc_name            = Caj_header.pc_name             
          T-Asn_header.posteo             = "0"
          T-Asn_header.presupuestado      = ""                    
          T-Asn_header.prf_comprob        = 0
          T-Asn_header.reexpresa_saldos   = Tipocomprobante.reexpresa_movimiento
          T-Asn_header.tabla_comprobante  = "Caj_header"      

          T-Asn_header.anulado            = NO
          T-Asn_header.cdg_empresa        = Caj_header.cdg_empresa
          T-Asn_header.cdg_sigla-sic      = "TES"
          T-Asn_header.fecha              = Caj_header.fecha
          T-Asn_header.leyenda            = Caj_header.tip_comprob + " " +
                                            STRING(Caj_header.prf_comprob,"9999") + " " +
                                            STRING(Caj_header.nro_comprob,"99999999") +  " " +
                                            Caj_header.observacion
          T-Asn_header.nro_asiento        = 0
          T-Asn_header.nro_comprob        = 0
          T-Asn_header.nro_usuario        = Caj_header.nro_usuario  
          T-Asn_header.nro_moneda         = Caj_header.nro_moneda
          T-Asn_header.origen             = "A"
          T-Asn_header.tip_comprob        = "AS"
          T-Asn_header.estado             = IF Caj_header.contable THEN "*" ELSE "P".
          
   
   IF Caj_header.tipo_mov = "E"
   THEN DO: 
       FOR EACH Caja-imputacion WHERE Caja-imputacion.nro_transaccion = Caj_header.nro_transaccion:                          
          
          CREATE T-Asn_detalle.
          ASSIGN T-Asn_header.ultima_linea    = T-Asn_header.ultima_linea + 1
                 T-Asn_detalle.cdg_empresa    = T-Asn_header.cdg_empresa
                 T-Asn_detalle.credito        = 0
                 T-Asn_detalle.debito         = Caja-imputacion.valor              
                 T-Asn_detalle.cambio         = Caj_header.cambio
                 T-Asn_detalle.cambio_dolar   = Caj_header.cambio_dolar

                 T-Asn_detalle.fecha_mayor    = T-Asn_header.fecha
                 T-Asn_detalle.nro_asiento    = T-Asn_header.nro_asiento
                 T-Asn_detalle.nro_cuenta     = Caja-imputacion.nro_cuenta          
                 T-Asn_detalle.nro_entidad    = Caja-imputacion.nro_entidad         
                 T-Asn_detalle.nro_linea      = T-Asn_header.ultima_linea
                 T-Asn_detalle.nro_moneda     = Caj_header.nro_moneda
                 T-Asn_detalle.nro_obra       = Caja-imputacion.nro_obra            
                 T-Asn_detalle.nro_subcuenta  = 0
                 T-Asn_detalle.leyen_detalle  = IF Caja-imputacion.observacion <> "" 
                                                   THEN Caja-imputacion.observacion    
                                                   ELSE T-Asn_header.leyenda.
       END.
   END.     

   FOR EACH Caj_detalle OF Caj_header NO-LOCK,
        Rubro OF Caj_detalle NO-LOCK, Cuenta OF Rubro NO-LOCK:
                 
       CREATE T-Asn_detalle.
       ASSIGN T-Asn_header.ultima_linea    = T-Asn_header.ultima_linea + 1
              T-Asn_detalle.cdg_empresa    = T-Asn_header.cdg_empresa
              T-Asn_detalle.fecha_mayor    = T-Asn_header.fecha
              T-Asn_detalle.nro_asiento    = T-Asn_header.nro_asiento
              T-Asn_detalle.nro_cuenta     = Rubro.nro_cuenta
              T-Asn_detalle.nro_entidad    = Caj_header.nro_entidad
              T-Asn_detalle.nro_linea      = T-Asn_header.ultima_linea
              T-Asn_detalle.nro_moneda     = Caj_header.nro_moneda /* Moneda.nro_moneda OJO !!!! */
              T-Asn_detalle.nro_obra       = 0
              T-Asn_detalle.nro_subcuenta  = 0
              T-Asn_detalle.cambio         = Caj_header.cambio
              T-Asn_detalle.cambio_dolar   = Caj_header.cambio_dolar.
              
        IF Caj_detalle.observacion <> ""
           THEN T-Asn_detalle.leyen_detalle  = Caj_detalle.observacion.
           ELSE RUN dtlmovcaja.p ( INPUT ROWID(Caj_detalle), OUTPUT T-Asn_detalle.leyen_detalle ).
           
        FIND FIRST Cheque OF Caj_detalle NO-LOCK NO-ERROR.
        IF AVAILABLE Cheque
            THEN T-Asn_detalle.leyen_detalle = STRING(Cheque.numero_cheque) + " - " + T-Asn_detalle.leyen_detalle.

       IF Caj_header.tipo_mov = "E"
       THEN DO:
            ASSIGN
                T-Asn_detalle.credito        = Caj_detalle.importe
                T-Asn_detalle.debito         = 0.

       END.
       ELSE DO:
            ASSIGN
                T-Asn_detalle.credito        = 0
                T-Asn_detalle.debito         = Caj_detalle.importe.
       END.

   END. /* De los detalles de subdiario de Compras */
       
   IF Caj_header.tipo_mov = "I"
   THEN DO: 

       FOR EACH Caja-imputacion WHERE Caja-imputacion.nro_transaccion = Caj_header.nro_transaccion NO-LOCK:

          CREATE T-Asn_detalle.
          ASSIGN T-Asn_header.ultima_linea    = T-Asn_header.ultima_linea + 1
                 T-Asn_detalle.cdg_empresa    = T-Asn_header.cdg_empresa
                 T-Asn_detalle.credito        = Caja-imputacion.valor
                 T-Asn_detalle.debito         = 0
                 T-Asn_detalle.cambio         = Caj_header.cambio
                 T-Asn_detalle.cambio_dolar   = 1

                 T-Asn_detalle.fecha_mayor    = T-Asn_header.fecha
                 T-Asn_detalle.nro_asiento    = T-Asn_header.nro_asiento
                 T-Asn_detalle.nro_cuenta     = Caja-imputacion.nro_cuenta
                 T-Asn_detalle.nro_entidad    = Caja-imputacion.nro_entidad
                 T-Asn_detalle.nro_linea      = T-Asn_header.ultima_linea
                 T-Asn_detalle.nro_moneda     = Caj_header.nro_moneda
                 T-Asn_detalle.nro_obra       = Caja-imputacion.nro_obra
                 T-Asn_detalle.nro_subcuenta  = 0
                 T-Asn_detalle.leyen_detalle  = IF Caja-imputacion.observacion <> "" 
                                                   THEN Caja-imputacion.observacion 
                                                   ELSE T-Asn_header.leyenda.

       END.

   END.     

   RUN reexpresar_asiento.p ( INPUT-OUTPUT TABLE T-Asn_header,
                              INPUT-OUTPUT TABLE T-Asn_detalle,
                              INPUT-OUTPUT TABLE T-Asn_totales).
   FIND FIRST T-Asn_header.

END PROCEDURE.

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
   RUN getparametro_c.p (  INPUT  "COMPECNV", OUTPUT v-valor_c ).
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
               T-Fac_header.nro_contrato      = ?
               T-Fac_header.impreso           = "S"
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
               T-Fac_header.nro_administrador = Cliente.nro_administrador
               T-Fac_header.nombre            = Cliente.nom_cliente
               T-Fac_header.nombre_leg        = Cliente.nom_cliente
               T-Fac_header.codigo_cliente    = Cliente.cdg_cliente
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
          T-Fac_detalle.detallada    = Caj_header.tip_comprob + "-" + STRING(Caj_header.prf_comprob,"9999") + "-" + STRING(Caj_header.nro_comprob,"99999999").
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
