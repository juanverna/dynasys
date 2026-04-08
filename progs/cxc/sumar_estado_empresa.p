/*=================================================================================*/
/*      HALLA EL CONSUMO TOTAL DE CREDITO Y ESTADO CREDITICIO DE UN CLIENTE        */
/*=================================================================================*/

DEFINE INPUT  PARAMETER rid_cliente    AS ROWID.
DEFINE INPUT  PARAMETER que_empresa    LIKE Empresa.cdg_empresa.
DEFINE OUTPUT PARAMETER saldo_cc       AS DECIMAL.
DEFINE OUTPUT PARAMETER saldo_ccv      AS DECIMAL.
DEFINE OUTPUT PARAMETER tot_valores    AS DECIMAL.
DEFINE OUTPUT PARAMETER tot_remitos    AS DECIMAL.
DEFINE OUTPUT PARAMETER tot_pedidos    AS DECIMAL.
DEFINE OUTPUT PARAMETER cant_rech      AS INTEGER.
DEFINE OUTPUT PARAMETER tot_credito    AS DECIMAL.

/*=================================================================================*/
/*                                   VARIABLES                                     */
/*=================================================================================*/

{vrshared.i "NEW"}

DEFINE VARIABLE x-cotizacion              LIKE Cta_cte.cambio.
DEFINE VARIABLE x-cotizacion_local        LIKE Cta_cte.cambio.
DEFINE VARIABLE x-fecha_cotizacion        AS DATE.
DEFINE VARIABLE x-importe_movimiento      AS DECIMAL.


/*=================================================================================*/
/*                                TABLAS TEMPORALES                                */
/*=================================================================================*/

DEFINE TEMP-TABLE T-Ped_header               NO-UNDO LIKE Ped_header.
DEFINE TEMP-TABLE T-Ped_detalle              NO-UNDO LIKE Ped_detalle.
DEFINE TEMP-TABLE T-Sub_header_vta           NO-UNDO LIKE Sub_header_vta.
DEFINE TEMP-TABLE T-Sub_detalle_vta          NO-UNDO LIKE Sub_detalle_vta.
DEFINE TEMP-TABLE T-Ped_header-bon           NO-UNDO LIKE Ped_header-bon.
DEFINE TEMP-TABLE T-Ped_detalle-bon          NO-UNDO LIKE Ped_detalle-bon.
DEFINE TEMP-TABLE T-Ped_header_impuesto      NO-UNDO LIKE Ped_header_impuesto.
DEFINE TEMP-TABLE T-Ped_detalle_impuesto     NO-UNDO LIKE Ped_detalle_impuesto.

DEFINE TEMP-TABLE T-Rem_header               NO-UNDO LIKE Rem_header.
DEFINE TEMP-TABLE T-Rem_detalle              NO-UNDO LIKE Rem_detalle.
DEFINE TEMP-TABLE T-Rem_header-bon           NO-UNDO LIKE Rem_header-bon.
DEFINE TEMP-TABLE T-Rem_detalle-bon          NO-UNDO LIKE Rem_detalle-bon.
DEFINE TEMP-TABLE T-Rem_header_impuesto      NO-UNDO LIKE Rem_header_impuesto.
DEFINE TEMP-TABLE T-Rem_detalle_impuesto     NO-UNDO LIKE Rem_detalle_impuesto.

DEFINE STREAM Valuacion.

DEFINE BUFFER Moneda_local FOR Moneda.

/*=================================================================================*/
/*                                BLOQUE PRINCIPAL                                 */
/*=================================================================================*/

FIND Empresa WHERE Empresa.cdg_empresa = que_empresa NO-LOCK.

FIND FIRST Moneda_local WHERE Moneda_local.es_local NO-LOCK.

FIND Cliente WHERE ROWID(Cliente) = rid_cliente NO-LOCK.

/*MESSAGE "sumando cuenta corriente" VIEW-AS ALERT-BOX MESSAGE TITLE "sumar_estadocred.p".*/
RUN SUMAR_CTACTE.

/*MESSAGE "sumando cartera de valores" VIEW-AS ALERT-BOX MESSAGE TITLE "sumar_estadocred.p".*/
RUN SUMAR_VALORES.

/*MESSAGE "sumando remitos pendientes" VIEW-AS ALERT-BOX MESSAGE TITLE "sumar_estadocred.p".*/
RUN SUMAR_REMITOS.

/*MESSAGE "sumando pedidos pendientes" VIEW-AS ALERT-BOX MESSAGE TITLE "sumar_estadocred.p".*/
RUN SUMAR_PEDIDOS.

/*MESSAGE "FIN. VOLVIENDO" VIEW-AS ALERT-BOX MESSAGE TITLE "sumar_estadocred.p".*/

tot_credito = saldo_cc + tot_valores + tot_remitos + tot_pedidos.

/*=================================================================================*/
/*                                 PROCEDIMIENTOS                                  */
/*=================================================================================*/

PROCEDURE SUMAR_CTACTE:

    saldo_cc = 0.
    saldo_ccv = 0.

    FOR EACH Cta_cte NO-LOCK OF Cliente
            WHERE Cta_cte.debito <> Cta_cte.credito
              AND ( Cta_cte.cdg_empresa = Empresa.cdg_empresa),
                FIRST Moneda OF Cta_cte NO-LOCK
               BY Cta_cte.fecha_vencimiento:

        IF Moneda.es_local
            THEN x-importe_movimiento = Cta_cte.debito - Cta_cte.credito.
            ELSE RUN reexpresar_importe.p  ( INPUT Moneda.cdg_moneda,
                                             INPUT Moneda_local.cdg_moneda,
                                             INPUT Cta_cte.fecha_emision,
                                             INPUT ( Cta_cte.debito - Cta_cte.credito ),
                                             OUTPUT x-importe_movimiento,
                                             OUTPUT x-fecha_cotizacion ).

        saldo_cc = saldo_cc + x-importe_movimiento.
             
        IF Cta_cte.fecha_vencimiento <= TODAY
        THEN DO: 
            saldo_ccv = saldo_ccv + x-importe_movimiento /* * Moneda.cambio*/.
        END.

    END.

END PROCEDURE.

PROCEDURE SUMAR_VALORES:

    tot_valores = 0.
    cant_rech = 0.
    
    FOR EACH Valor OF Cliente 
            WHERE Valor.estado <> stchq_acredit
              AND Valor.estado <> stchq_levanta
              AND ( Valor.cdg_empresa = Empresa.cdg_empresa)
                  NO-LOCK:

        IF Moneda.es_local
            THEN x-importe_movimiento = Valor.importe.
            ELSE RUN reexpresar_importe.p  ( INPUT Moneda.cdg_moneda,
                                             INPUT Moneda_local.cdg_moneda,
                                             INPUT Valor.fecha_emision,
                                             INPUT Valor.importe,
                                             OUTPUT x-importe_movimiento,
                                             OUTPUT x-fecha_cotizacion ).

        tot_valores = tot_valores  + x-importe_movimiento.

    END.

    FOR EACH Valor OF Cliente 
        WHERE Valor.estado = stchq_rechaza
          AND Valor.cdg_empresa = Empresa.cdg_empresa
              NO-LOCK:
        cant_rech = cant_rech + 1.
    END.

END PROCEDURE.

PROCEDURE SUMAR_REMITOS:

    tot_remitos = 0.

    FOR EACH Rem_header OF Cliente 
        WHERE Rem_header.estado = "E"
          AND NOT Rem_header.sin_cargo
          AND NOT Rem_header.anulado
          AND ( Rem_header.cdg_empresa = Empresa.cdg_empresa )
              NO-LOCK:

        /* borramos las tablas temporales */

        EMPTY TEMP-TABLE T-Rem_header.
        EMPTY TEMP-TABLE T-Rem_detalle.
        EMPTY TEMP-TABLE T-Sub_header_vta.
        EMPTY TEMP-TABLE T-Sub_detalle_vta.
        EMPTY TEMP-TABLE T-Rem_header-bon.
        EMPTY TEMP-TABLE T-Rem_detalle-bon.
        EMPTY TEMP-TABLE T-Rem_header_impuesto.
        EMPTY TEMP-TABLE T-Rem_detalle_impuesto.

        /* Copiamos el pedido en las tablas temporales */

        BUFFER-COPY Rem_header TO T-Rem_header
            ASSIGN T-Rem_header.fecha_iva = T-Rem_header.fecha.

        FOR EACH Rem_detalle OF Rem_header:
           CREATE T-Rem_detalle.
           BUFFER-COPY Rem_detalle TO T-Rem_detalle.
        END.    
        
        FOR EACH Rem_header-bon  OF Rem_header:
           CREATE T-Rem_header-bon.
           BUFFER-COPY Rem_header-bon TO T-Rem_header-bon.
        END.
        
        FOR EACH Rem_detalle-bon  OF Rem_header:
           CREATE T-Rem_detalle-bon.
           BUFFER-COPY Rem_detalle-bon TO T-Rem_detalle-bon.
        END.
        
        FIND Sub_header_vta 
            WHERE Sub_header_vta.cdg_empresa = Rem_header.cdg_empresa
              AND Sub_header_vta.tip_comprob = Rem_header.tip_comprob
              AND Sub_header_vta.prf_comprob = Rem_header.prf_comprob
              AND Sub_header_vta.nro_comprob = Rem_header.nro_comprob
                  NO-LOCK NO-ERROR.
        IF AVAILABLE Sub_header_vta
        THEN DO:
            CREATE T-Sub_header_vta.
            BUFFER-COPY Sub_header_vta TO T-Sub_header_vta.           
         
            FOR EACH Sub_detalle_vta 
                 WHERE Sub_detalle_vta.cdg_empresa = Sub_header_vta.cdg_empresa
                   AND Sub_detalle_vta.tip_comprob = Sub_header_vta.tip_comprob
                   AND Sub_detalle_vta.prf_comprob = Sub_header_vta.prf_comprob
                   AND Sub_detalle_vta.nro_comprob = Sub_header_vta.nro_comprob
                       NO-LOCK.
         
                CREATE T-Sub_detalle_vta.
                BUFFER-COPY Sub_detalle_vta TO T-Sub_detalle_vta.           
         
            END.
        END.

        FIND Lista_precio OF T-Rem_header NO-LOCK.
        FIND Moneda WHERE Moneda.nro_moneda = Lista_Precio.nro_moneda NO-LOCK.

        RUN asignar_precios_remito.

        /* Valuamos el pedido */

        RUN valuar_remito.p (  INPUT-OUTPUT TABLE T-Rem_header,
                               INPUT-OUTPUT TABLE T-Rem_detalle,
                               INPUT-OUTPUT TABLE T-Sub_header_vta,
                               INPUT-OUTPUT TABLE T-Sub_detalle_vta,
                               INPUT-OUTPUT TABLE T-Rem_header-bon,
                               INPUT-OUTPUT TABLE T-Rem_detalle-bon,
                               INPUT-OUTPUT TABLE T-Rem_header_impuesto,
                               INPUT-OUTPUT TABLE T-Rem_detalle_impuesto).

        /* Acumulamos el valor */
        
        FIND FIRST T-Rem_header.
        
        IF Moneda.es_local
            THEN x-importe_movimiento = T-Rem_header.imp_total.
            ELSE RUN reexpresar_importe.p  ( INPUT Moneda.cdg_moneda,
                                             INPUT Moneda_local.cdg_moneda,
                                             INPUT Rem_header.fecha,
                                             INPUT T-Rem_header.imp_total,
                                             OUTPUT x-importe_movimiento,
                                             OUTPUT x-fecha_cotizacion ).

        tot_remitos = tot_remitos + x-importe_movimiento.

    END.

END PROCEDURE.

PROCEDURE SUMAR_PEDIDOS:

    /*  
    MESSAGE "TODAVIA NO ESTA CONTEMPLANDO LAS ENTREGAS PARCIALES NI LOS IMPUESTOS" VIEW-AS ALERT-BOX WARNING
          TITLE "sumar_estadocred.p".
    */

    OUTPUT STREAM Valuacion TO "c:\sic-temp\valuacion.txt".

    tot_pedidos = 0.

    FOR EACH Ped_header NO-LOCK OF Cliente 
        WHERE LOOKUP(Ped_header.cdg_estado,"AA,SI,AM",",") <> 0
          AND ( Ped_header.cdg_empresa = Empresa.cdg_empresa ):

        /* borramos las tablas temporales */

        EMPTY TEMP-TABLE T-Ped_header.
        EMPTY TEMP-TABLE T-Ped_detalle.
        EMPTY TEMP-TABLE T-Sub_header_vta.
        EMPTY TEMP-TABLE T-Sub_detalle_vta.
        EMPTY TEMP-TABLE T-Ped_header-bon.
        EMPTY TEMP-TABLE T-Ped_detalle-bon.
        EMPTY TEMP-TABLE T-Ped_header_impuesto.
        EMPTY TEMP-TABLE T-Ped_detalle_impuesto.

        /* Copiamos el pedido en las tablas temporales */

        BUFFER-COPY Ped_header TO T-Ped_header.

        FOR EACH Ped_detalle OF Ped_header:
           CREATE T-Ped_detalle.
           BUFFER-COPY Ped_detalle TO T-Ped_detalle.
        END.    
        
        FOR EACH Ped_header-bon  OF Ped_header:
           CREATE T-Ped_header-bon.
           BUFFER-COPY Ped_header-bon TO T-Ped_header-bon.
        END.
        
        FOR EACH Ped_detalle-bon  OF Ped_header:
           CREATE T-Ped_detalle-bon.
           BUFFER-COPY Ped_detalle-bon TO T-Ped_detalle-bon.
        END.
        
        FIND Sub_header_vta 
            WHERE Sub_header_vta.cdg_empresa = Ped_header.cdg_empresa
              AND Sub_header_vta.tip_comprob = Ped_header.tip_comprob
              AND Sub_header_vta.prf_comprob = Ped_header.prf_comprob
              AND Sub_header_vta.nro_comprob = Ped_header.nro_comprob
                  NO-LOCK NO-ERROR.
        IF AVAILABLE Sub_header_vta
        THEN DO:
            CREATE T-Sub_header_vta.
            BUFFER-COPY Sub_header_vta TO T-Sub_header_vta.           
         
            FOR EACH Sub_detalle_vta 
                 WHERE Sub_detalle_vta.cdg_empresa = Sub_header_vta.cdg_empresa
                   AND Sub_detalle_vta.tip_comprob = Sub_header_vta.tip_comprob
                   AND Sub_detalle_vta.prf_comprob = Sub_header_vta.prf_comprob
                   AND Sub_detalle_vta.nro_comprob = Sub_header_vta.nro_comprob
                       NO-LOCK.
         
                CREATE T-Sub_detalle_vta.
                BUFFER-COPY Sub_detalle_vta TO T-Sub_detalle_vta.           
         
            END.
        END.

        /* Valuamos el pedido */

        RUN valuar_pedido.p (  INPUT-OUTPUT TABLE T-Ped_header,
                               INPUT-OUTPUT TABLE T-Ped_detalle,
                               INPUT-OUTPUT TABLE T-Sub_header_vta,
                               INPUT-OUTPUT TABLE T-Sub_detalle_vta,
                               INPUT-OUTPUT TABLE T-Ped_header-bon,
                               INPUT-OUTPUT TABLE T-Ped_detalle-bon,
                               INPUT-OUTPUT TABLE T-Ped_header_impuesto,
                               INPUT-OUTPUT TABLE T-Ped_detalle_impuesto).

        /* Acumulamos el valor */
        
        FIND FIRST T-Ped_header.

        FIND Lista_precio OF T-Ped_header NO-LOCK.
        FIND Moneda WHERE Moneda.nro_moneda = Lista_Precio.nro_moneda NO-LOCK.

        IF Moneda.es_local
            THEN x-importe_movimiento = T-Ped_header.imp_total.
            ELSE RUN reexpresar_importe.p  ( INPUT Moneda.cdg_moneda,
                                             INPUT Moneda_local.cdg_moneda,
                                             INPUT Ped_header.fecha,
                                             INPUT T-Ped_header.imp_total,
                                             OUTPUT x-importe_movimiento,
                                             OUTPUT x-fecha_cotizacion ).

        tot_pedidos = tot_pedidos + x-importe_movimiento.

        PUT STREAM Valuacion T-Ped_header.tip_comprob " " 
                             T-Ped_header.prf_comprob " "
                             T-Ped_header.nro_comprob " "
                             x-importe_movimiento FORMAT ">>>>>>>>>9,99" SKIP.

    END.

    OUTPUT STREAM Valuacion CLOSE.

END PROCEDURE.

PROCEDURE asignar_precios_remito:

   T-Rem_header.fecha_precios = T-Rem_header.fecha.
/*    FIND Lista_precio OF T-Rem_header NO-LOCK.                                                   */
/*    FIND Moneda WHERE Moneda.nro_moneda = Lista_Precio.nro_moneda NO-LOCK NO-ERROR.              */
/*    FIND LAST Cotizacion OF Moneda WHERE Cotizacion.fch_cotizacion <= T-Rem_header.fecha_precios */
/*                                     AND Cotizacion.cdg_empresa = T-Rem_header.cdg_empresa.      */
   FOR EACH T-Rem_detalle OF T-Rem_header EXCLUSIVE-LOCK, FIRST Articulo OF T-Rem_detalle WHERE Articulo.stock_sino:

        CASE Articulo.modo_volumen:
             WHEN ""  /* No hay descuentos por volumen */
             THEN DO: 
                  FIND LAST Articulo_precio OF Articulo 
                       WHERE Articulo_precio.cdg_lista = Lista_precio.cdg_lista 
                         AND Articulo_precio.cdg_empresa = T-Rem_header.cdg_empresa
                         AND Articulo_precio.fch_desde <= T-Rem_header.fecha_precios
                             NO-LOCK NO-ERROR. 
                  IF AVAILABLE Articulo_precio 
                  THEN DO:
                       
                       T-Rem_detalle.precio    = Articulo_precio.precio.
                       T-Rem_detalle.precio_cf = Articulo_precio.precio_cf.
                  END.
                  ELSE DO:
                       T-Rem_detalle.precio    = ?.
                       T-Rem_detalle.precio_cf = ?.
                  END.
             END.                                  
    
             WHEN "D"  /* Descuentos directos en base a cantidad */
             THEN DO: 
                  FIND FIRST Articulo_precio OF Articulo 
                       WHERE Articulo_precio.cdg_lista = Lista_precio.cdg_lista 
                         AND Articulo_precio.cdg_empresa = T-Rem_header.cdg_empresa
                         AND Articulo_precio.desde_cantidad <= T-Rem_detalle.cantidad
                         AND Articulo_precio.hasta_cantidad >= T-Rem_detalle.cantidad
                         AND Articulo_precio.fch_desde <= T-Rem_header.fecha_precios
                             NO-LOCK NO-ERROR. 
                  IF AVAILABLE Articulo_precio 
                  THEN DO:
/*                        T-Rem_detalle.precio    = Articulo_precio.precio.    */
/*                        T-Rem_detalle.precio_cf = Articulo_precio.precio_cf. */
                       T-Rem_detalle.precio    = Articulo_precio.precio.
                       T-Rem_detalle.precio_cf = Articulo_precio.precio_cf.
                  END.
                  ELSE DO:
                       T-Rem_detalle.precio    = ?.
                       T-Rem_detalle.precio_cf = ?.
                  END.
             END.                                  
    
             WHEN "E"  /* Descuentos escalados en base a cantidad */
             THEN DO: 
                    /*
                  subtotal_item = 0.
                  remanente_cantidad = T-Rem_detalle.cantidad.
    
                  FOR EACH Articulo_precio OF Articulo 
                       WHERE Articulo_precio.cdg_lista = Lista_precio.cdg_lista 
                         AND Articulo_precio.cdg_empresa = T-Rem_header.cdg_empresa
                         BY Articulo-precio.desde_cantidad
                             NO-LOCK NO-ERROR: 
    
                      T-Rem_detalle.cantidad
    
    
                  IF AVAILABLE Articulo_precio 
                  THEN DO:
                       T-Rem_detalle.precio    = Articulo_precio.precio.
                       T-Rem_detalle.precio_cf = Articulo_precio.precio_cf.
                  END.
                  ELSE DO:
                       T-Rem_detalle.precio    = ?.
                       T-Rem_detalle.precio_cf = ?.
                  END.
                  */
                            T-Rem_detalle.precio = ?. /* Sacar */
             END.                                  
 
        END CASE.
   END.

END PROCEDURE.
