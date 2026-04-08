/*=================================================================================*/
/*           RESUMEN DE Encabezados DE LIQUIDO PRODUCTO POR PROVEEDOR              */
/*=================================================================================*/

{tblliquidoproducto.i} /* Definicion de la tabla temporal de liquido producto */

DEFINE INPUT PARAMETER des_proveedor       LIKE Proveedor.cdg_proveedor.
DEFINE INPUT PARAMETER has_proveedor       LIKE Proveedor.cdg_proveedor.
DEFINE INPUT PARAMETER des_fecha           LIKE Fac_header.fecha.
DEFINE INPUT PARAMETER has_fecha           LIKE Fac_header.fecha.
DEFINE INPUT PARAMETER que_liquido         LIKE Fac_detalle.liquido_sino.
DEFINE INPUT PARAMETER marcar_comprobantes AS LOGICAL.

DEFINE OUTPUT PARAMETER TABLE FOR T-Fac_header_prv_impuesto.
DEFINE OUTPUT PARAMETER TABLE FOR T-Liquido_producto.

/*=================================================================================*/
/*                                  PROCESO                                        */
/*=================================================================================*/

{findempresa.i}

OPEN QUERY Encabezados
    FOR EACH Fac_header NO-LOCK
        WHERE Fac_header.fecha <= has_fecha
                          AND Fac_header.fecha >= des_fecha
                          AND Fac_header.cdg_empresa = Empresa.cdg_empresa,
                              FIRST Imputacion OF Fac_header 
                                    WHERE Imputacion.afecta_liquido 
                                      AND Imputacion.afecta_estadisticas,
                              FIRST Tipocomprobante OF Fac_header.

GET FIRST Encabezados.
DO WHILE AVAILABLE Fac_header: 

    IF marcar_comprobantes
    THEN DO:
        OPEN QUERY Detalles
        FOR EACH Fac_detalle EXCLUSIVE-LOCK OF Fac_header 
            WHERE ( que_liquido = ? OR Fac_detalle.liquido_sino = que_liquido), 
            FIRST Vigencia_cyorden WHERE Vigencia_cyorden.nro_articulo = Fac_detalle.nro_articulo
                          AND Vigencia_cyorden.rige_desde <= Fac_header.fecha
                          AND Vigencia_cyorden.rige_hasta >= Fac_header.fecha
                          AND Vigencia_cyorden.cdg_empresa = Empresa.cdg_empresa,
                              FIRST Proveedor OF Vigencia_cyorden 
                                    WHERE Proveedor.cdg_proveedor <= has_proveedor
                                      AND Proveedor.cdg_proveedor >= des_proveedor.
    END.
    ELSE DO:
        OPEN QUERY Detalles
        FOR EACH Fac_detalle NO-LOCK OF Fac_header 
            WHERE ( que_liquido = ? OR Fac_detalle.liquido_sino = que_liquido), 
            FIRST Vigencia_cyorden WHERE Vigencia_cyorden.nro_articulo = Fac_detalle.nro_articulo
                          AND Vigencia_cyorden.rige_desde <= Fac_header.fecha
                          AND Vigencia_cyorden.rige_hasta >= Fac_header.fecha
                          AND Vigencia_cyorden.cdg_empresa = Empresa.cdg_empresa,
                              FIRST Proveedor OF Vigencia_cyorden 
                                    WHERE Proveedor.cdg_proveedor <= has_proveedor
                                      AND Proveedor.cdg_proveedor >= des_proveedor.
    END.
             
    GET FIRST Detalles.
    DO WHILE AVAILABLE Fac_detalle:


        FIND FIRST T-Liquido_producto 
             WHERE T-Liquido_producto.nro_proveedor = Vigencia_cyorden.nro_proveedor
               AND T-Liquido_producto.nro_articulo = Fac_detalle.nro_articulo
               AND T-Liquido_producto.cdg_imputacion = Fac_header.cdg_imputacion
               AND T-Liquido_producto.fecha = Fac_header.fecha  
                   NO-ERROR.
         
        IF NOT AVAILABLE T-Liquido_producto
        THEN DO:
            CREATE T-Liquido_producto.
            ASSIGN T-Liquido_producto.nro_proveedor = Vigencia_cyorden.nro_proveedor
                   T-Liquido_producto.nro_articulo = Fac_detalle.nro_articulo
                   T-Liquido_producto.cdg_imputacion = Fac_header.cdg_imputacion
                   T-Liquido_producto.fecha = Fac_header.fecha.
        END.

        IF Imputacion.afecta_stock
        THEN DO:
             IF Imputacion.num_columna = 1
             THEN DO:
                 IF Tipocomprobante.debita
                 THEN DO:
                     ASSIGN
                         T-Liquido_producto.cantidad = T-Liquido_producto.cantidad + Fac_detalle.cantidad
                         T-Liquido_producto.granel = T-Liquido_producto.granel + Fac_detalle.granel.
                 END.
                 ELSE DO:
    
                        ASSIGN T-Liquido_producto.cantidad = T-Liquido_producto.cantidad - Fac_detalle.cantidad
                               T-Liquido_producto.granel = T-Liquido_producto.granel - Fac_detalle.granel.
                 END.
             END.
             ELSE DO:
                 IF Tipocomprobante.debita
                    THEN DO:
                        ASSIGN
                            T-Liquido_producto.cantidad_dev = T-Liquido_producto.cantidad_dev + Fac_detalle.cantidad
                            T-Liquido_producto.granel_dev = T-Liquido_producto.granel_dev + Fac_detalle.granel.
                    END.
                    ELSE DO:
                         ASSIGN T-Liquido_producto.cantidad_dev = T-Liquido_producto.cantidad_dev - Fac_detalle.cantidad
                                T-Liquido_producto.granel_dev = T-Liquido_producto.granel_dev - Fac_detalle.granel.
                    
                    END.

             END.
        END.

        IF Tipocomprobante.debita
            THEN ASSIGN  T-Liquido_producto.subtotal = T-Liquido_producto.subtotal + Fac_detalle.subtotal_neto * Fac_header.cambio.
            ELSE ASSIGN  T-Liquido_producto.subtotal = T-Liquido_producto.subtotal - Fac_detalle.subtotal_neto * Fac_header.cambio.
         
        FOR EACH Fac_detalle_impuesto OF Fac_detalle, FIRST Impuesto OF Fac_detalle_impuesto WHERE Impuesto.es_iva:

               FIND T-Fac_header_prv_impuesto 
                      WHERE T-Fac_header_prv_impuesto.cdg_impuesto = Fac_detalle_impuesto.cdg_impuesto 
                        AND T-Fac_header_prv_impuesto.tasa = Fac_detalle_impuesto.tasa NO-ERROR.
               IF NOT AVAILABLE T-Fac_header_prv_impuesto
               THEN DO:
                   CREATE T-Fac_header_prv_impuesto.
                   ASSIGN T-Fac_header_prv_impuesto.cdg_impuesto = Fac_detalle_impuesto.cdg_impuesto 
                          T-Fac_header_prv_impuesto.tasa = Fac_detalle_impuesto.tasa.
               END.

               IF Tipocomprobante.debita
               THEN DO:
                   T-Fac_header_prv_impuesto.monto_imponible = T-Fac_header_prv_impuesto.monto_imponible + Fac_detalle_impuesto.monto_imponible * Fac_header.cambio.
                   T-Fac_header_prv_impuesto.importe = T-Fac_header_prv_impuesto.importe + Fac_detalle_impuesto.importe * Fac_header.cambio.
               END.
               ELSE DO:
                   T-Fac_header_prv_impuesto.monto_imponible = T-Fac_header_prv_impuesto.monto_imponible - Fac_detalle_impuesto.monto_imponible * Fac_header.cambio.
                   T-Fac_header_prv_impuesto.importe = T-Fac_header_prv_impuesto.importe - Fac_detalle_impuesto.importe * Fac_header.cambio.
               END.

        END.

        IF marcar_comprobantes
           THEN Fac_detalle.liquido_sino = YES.

        GET NEXT Detalles.

    END.

    GET NEXT Encabezados.

END.
