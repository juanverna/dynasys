/*=================================================================================*/
/*                        REGENERA EL SUBDIARIO DE VENTAS                          */  
/*=================================================================================*/

DEFINE VARIABLE codigo_iva            AS INTEGER INITIAL 1.
DEFINE VARIABLE prciva                LIKE Impuesto.tasa FORMAT "Z,ZZZ,ZZ9.99-".

DEFINE VARIABLE aux_importe           AS DECIMAL.
DEFINE VARIABLE v-debug               AS LOGICAL.

FOR EACH Fac_header WHERE NOT Fac_header.anulado, 
    FIRST Tipocomprobante OF Fac_header WHERE Tipocomprobante.afecta_stock:

    FIND Empresa OF Fac_header NO-LOCK.
    FIND Condicion_impos OF Fac_header NO-LOCK.
    FIND Imputacion OF Fac_header NO-LOCK NO-ERROR.
    FIND Deposito OF Fac_header NO-LOCK.

    FIND Cliente OF Fac_header NO-LOCK.
    Fac_header.nro_entidad = Cliente.nro_entidad.
    FIND Vendedor OF Fac_header NO-LOCK.
    FIND Obra WHERE Obra.cdg_obra = Vendedor.cdg_vendedor NO-LOCK.
    FOR EACH Fac_detalle OF Fac_header:
        Fac_detalle.nro_obra = Obra.nro_obra.
    END.

                 /* borra el subdiario anterior */

    FOR EACH Sub_detalle_inv 
        WHERE Sub_detalle_inv.cdg_empresa = Fac_header.cdg_empresa
          AND Sub_detalle_inv.tip_comprob = Fac_header.tip_comprob
          AND Sub_detalle_inv.prf_comprob = Fac_header.prf_comprob
          AND Sub_detalle_inv.nro_comprob = Fac_header.nro_comprob:
        
        DELETE Sub_detalle_inv.
          
    END.      

    FOR EACH Sub_header_inv 
        WHERE Sub_header_inv.cdg_empresa = Fac_header.cdg_empresa
          AND Sub_header_inv.tip_comprob = Fac_header.tip_comprob
          AND Sub_header_inv.prf_comprob = Fac_header.prf_comprob
          AND Sub_header_inv.nro_comprob = Fac_header.nro_comprob:
        
        DELETE Sub_header_inv.
          
    END.      

              /* regenera el subdiario nuevamente */

    RUN calcular_inventario.
             
END.

PROCEDURE calcular_inventario:

    FIND Familia_cliente OF Cliente NO-LOCK.
    CREATE Sub_header_inv.
    ASSIGN Sub_header_inv.cdg_empresa   = Fac_header.cdg_empresa
           Sub_header_inv.tip_comprob   = Fac_header.tip_comprob
           Sub_header_inv.prf_comprob   = Fac_header.prf_comprob
           Sub_header_inv.nro_comprob   = Fac_header.nro_comprob
           Sub_header_inv.fecha         = Fac_header.fecha
           Sub_header_inv.nro_entidad   = Fac_header.nro_entidad
           Sub_header_inv.nro_cuenta    = Familia_cliente.nro_cuenta.

              /*--------------------------------------------------------------*/
              /* Realiza las imputaciones del remito. Es una salida de mercs. */
              /* se debitan los costos de ventas y acreditan las existencias. */
              /*--------------------------------------------------------------*/

    FOR EACH Fac_detalle OF Fac_header,
               Articulo OF Fac_detalle, Familia_articulo OF Articulo:

        FIND Sub_detalle_inv 
             WHERE Sub_detalle_inv.cdg_empresa    = Fac_header.cdg_empresa
               AND Sub_detalle_inv.tip_comprob    = Fac_header.tip_comprob
               AND Sub_detalle_inv.prf_comprob    = Fac_header.prf_comprob
               AND Sub_detalle_inv.nro_comprob    = Fac_header.nro_comprob
               AND Sub_detalle_inv.nro_cuenta     = Familia_articulo.nro_cuenta_costo
               AND Sub_detalle_inv.nro_entidad    = Fac_header.nro_entidad
               AND Sub_detalle_inv.nro_obra       = Fac_detalle.nro_obra 
               AND Sub_detalle_inv.tipo           = 1
                   EXCLUSIVE-LOCK NO-ERROR.

        IF NOT AVAILABLE Sub_detalle_inv 
        THEN DO:
           CREATE Sub_detalle_inv.
           ASSIGN Sub_detalle_inv.cdg_empresa    = Fac_header.cdg_empresa
                  Sub_detalle_inv.tip_comprob    = Fac_header.tip_comprob
                  Sub_detalle_inv.prf_comprob    = Fac_header.prf_comprob
                  Sub_detalle_inv.nro_comprob    = Fac_header.nro_comprob
                  Sub_detalle_inv.nro_cuenta     = Familia_articulo.nro_cuenta_costo
                  Sub_detalle_inv.nro_entidad    = Fac_header.nro_entidad
                  Sub_detalle_inv.nro_obra       = Fac_detalle.nro_obra 
                  Sub_detalle_inv.tipo           = 1.
        END.

        Sub_detalle_inv.valor = Sub_detalle_inv.valor + Articulo.costo * Fac_detalle.cantidad.

    END.             

    Sub_header_inv.imp_total = Fac_header.imp_total.

              /*--------------------------------------------------------------*/
              /* Volvemos a recorrer el detalle de manera de calcular la otra */
              /* porcion del asiento                                          */
              /*--------------------------------------------------------------*/

    FOR EACH Fac_detalle EXCLUSIVE-LOCK OF Fac_header,
               Articulo OF Fac_detalle, Familia_articulo OF Articulo:

        FIND Sub_detalle_inv 
             WHERE Sub_detalle_inv.cdg_empresa    = Fac_header.cdg_empresa
               AND Sub_detalle_inv.tip_comprob    = Fac_header.tip_comprob
               AND Sub_detalle_inv.prf_comprob    = Fac_header.prf_comprob
               AND Sub_detalle_inv.nro_comprob    = Fac_header.nro_comprob
               AND Sub_detalle_inv.nro_cuenta     = Familia_articulo.nro_cuenta_existencia
               AND Sub_detalle_inv.nro_entidad    = Deposito.nro_entidad
               AND Sub_detalle_inv.nro_obra       = 0
               AND Sub_detalle_inv.tipo           = 2
                   EXCLUSIVE-LOCK NO-ERROR.

        IF NOT AVAILABLE Sub_detalle_inv 
        THEN DO:
           CREATE Sub_detalle_inv.
           ASSIGN Sub_detalle_inv.cdg_empresa    = Fac_header.cdg_empresa
                  Sub_detalle_inv.tip_comprob    = Fac_header.tip_comprob
                  Sub_detalle_inv.prf_comprob    = Fac_header.prf_comprob
                  Sub_detalle_inv.nro_comprob    = Fac_header.nro_comprob
                  Sub_detalle_inv.nro_cuenta     = Familia_articulo.nro_cuenta_existencia
                  Sub_detalle_inv.nro_entidad    = Deposito.nro_entidad
                  Sub_detalle_inv.nro_obra       = 0
                  Sub_detalle_inv.tipo           = 2.
        END.

        Sub_detalle_inv.valor = Sub_detalle_inv.valor + Articulo.costo * Fac_detalle.cantidad.

    END.             

END PROCEDURE.
