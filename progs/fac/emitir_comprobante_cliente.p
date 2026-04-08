
/*                    EMISION DE FACTURAS/DEVOLUCIONES A CLIENTES                  */
/*=================================================================================*/

DEFINE TEMP-TABLE T-Fac_header               NO-UNDO LIKE Fac_header.
DEFINE TEMP-TABLE T-Fac_detalle              NO-UNDO LIKE Fac_detalle.
DEFINE TEMP-TABLE T-Registrable-factura      NO-UNDO LIKE Registrable-factura.
DEFINE TEMP-TABLE T-Sub_header_vta           NO-UNDO LIKE Sub_header_vta.
DEFINE TEMP-TABLE T-Sub_detalle_vta          NO-UNDO LIKE Sub_detalle_vta.
DEFINE TEMP-TABLE T-Fac_header-bon           NO-UNDO LIKE Fac_header-bon.
DEFINE TEMP-TABLE T-Fac_detalle-bon          NO-UNDO LIKE Fac_detalle-bon.
DEFINE TEMP-TABLE T-Fac_header_impuesto      NO-UNDO LIKE Fac_header_impuesto.
DEFINE TEMP-TABLE T-Fac_detalle_impuesto     NO-UNDO LIKE Fac_detalle_impuesto.
                                                                                                   
/*=================================================================================*/
/*                        DEFINICION DE PARAMETROS                                 */
/*=================================================================================*/

DEFINE INPUT-OUTPUT PARAMETER TABLE FOR T-Fac_header.
DEFINE INPUT-OUTPUT PARAMETER TABLE FOR T-Fac_detalle.
DEFINE INPUT-OUTPUT PARAMETER TABLE FOR T-Registrable-factura.
DEFINE INPUT-OUTPUT PARAMETER TABLE FOR T-Sub_header_vta.
DEFINE INPUT-OUTPUT PARAMETER TABLE FOR T-Sub_detalle_vta.
DEFINE INPUT-OUTPUT PARAMETER TABLE FOR T-Fac_header-bon.
DEFINE INPUT-OUTPUT PARAMETER TABLE FOR T-Fac_detalle-bon.
DEFINE INPUT-OUTPUT PARAMETER TABLE FOR T-Fac_header_impuesto.
DEFINE INPUT-OUTPUT PARAMETER TABLE FOR T-Fac_detalle_impuesto.

/*=================================================================================*/
/*                          VARIABLES Y BUFFERS                                    */
/*=================================================================================*/

{VRSHARED.I "new"}

DEFINE VARIABLE rid_factura           AS ROWID.
DEFINE VARIABLE v-debug               AS LOGICAL.
DEFINE VARIABLE es_ultimo             AS LOGICAL.
DEFINE VARIABLE es_interactivo        AS LOGICAL.
DEFINE VARIABLE v-prinfac_diferida    AS LOGICAL.

DEFINE VARIABLE codigo_iva            AS INTEGER INITIAL 1.
DEFINE VARIABLE prciva                LIKE Impuesto.tasa FORMAT "Z,ZZZ,ZZ9.99-".

DEFINE VARIABLE aux_importe           AS DECIMAL.
DEFINE VARIABLE saldo_factura         AS DECIMAL.
DEFINE VARIABLE aux_nro_vencimiento   AS INTEGER.
DEFINE VARIABLE j                     AS INTEGER.
DEFINE VARIABLE ncopias               AS INTEGER.

DEFINE VARIABLE modo_emision          AS INTEGER INITIAL 0.
DEFINE VARIABLE indep                 AS INTEGER INITIAL 0.
DEFINE VARIABLE rem_y_fac             AS INTEGER INITIAL 1.
DEFINE VARIABLE fac_y_rem             AS INTEGER INITIAL 2.
DEFINE VARIABLE lado_a_lado           AS INTEGER INITIAL 3.

DEFINE VARIABLE que_rutina            AS CHARACTER.

DEFINE VARIABLE equiv_granel          LIKE Fac_detalle.granel.

DEFINE VARIABLE v-mes                 LIKE Fac_header.mes.
DEFINE VARIABLE v-ano                 LIKE Fac_header.ano.
DEFINE VARIABLE v-prox_docum          AS CHARACTER.

/*=================================================================================*/
/*                          TRANSACCION PROPIAMENTE DICHA                          */
/*=================================================================================*/

DO TRANSACTION:

/*---------------------------------------------------------------------------------*/
/*              ASIGNAMOS EL NUMERO SI EL COMPROBANTE ES AUTONUMERADO              */
/*---------------------------------------------------------------------------------*/
    FIND FIRST T-Fac_header EXCLUSIVE-LOCK.
    FIND Tipocomprobante OF T-Fac_header NO-LOCK.
    FIND Condicion_impos OF T-Fac_header NO-LOCK.

    IF Tipocomprobante.autonumerado
    THEN DO:

        v-prox_docum = Tipocomprobante.prefijo_contador + STRING(T-Fac_header.prf_comprob,"9999").
        T-Fac_header.tip_comprob =  Tipocomprobante.tip_comprob.    
        IF Tipocomprobante.usa_letra
        THEN DO:
            v-prox_docum = REPLACE(v-prox_docum,"*",Condicion_impos.tipo_factura).
            T-Fac_header.tip_comprob = REPLACE(T-Fac_header.tip_comprob,"*",Condicion_impos.tipo_factura).
        END.

        FIND Parametro WHERE Parametro.cdg_parametro = v-prox_docum 
                         AND Parametro.cdg_empresa   = T-Fac_header.cdg_empresa 
                             EXCLUSIVE-LOCK NO-ERROR.
          
        IF NOT AVAILABLE Parametro
        THEN DO:
             CREATE Parametro.
             ASSIGN Parametro.cdg_empresa   = T-Fac_header.cdg_empresa
                    Parametro.cdg_parametro = v-prox_docum
                    Parametro.descripcion   = "Contador autoagregado por " + PROGRAM-NAME(1)
                    Parametro.observacion   = ""
                    Parametro.tipo          = "N"
                    Parametro.valor_n       = 1.
        END.         
        
        ASSIGN
           T-Fac_header.nro_comprob = Parametro.valor_n
           Parametro.valor_n        = Parametro.valor_n + 1.

    END.
/*---------------------------------------------------------------------------------*/
/*                      RECALCULO DEL COMPROBANTE                                  */
/*---------------------------------------------------------------------------------*/

    RUN calcular_comprobante_cliente.p (
                             INPUT-OUTPUT TABLE T-Fac_header,
                             INPUT-OUTPUT TABLE T-Fac_detalle,
                             INPUT-OUTPUT TABLE T-Sub_header_vta,
                             INPUT-OUTPUT TABLE T-Sub_detalle_vta,
                             INPUT-OUTPUT TABLE T-Fac_header-bon,
                             INPUT-OUTPUT TABLE T-Fac_detalle-bon,
                             INPUT-OUTPUT TABLE T-Fac_header_impuesto,
                             INPUT-OUTPUT TABLE T-Fac_detalle_impuesto).

/*---------------------------------------------------------------------------------*/
/*                     BAJAMOS LAS TABLAS TEMPORALES                               */
/*---------------------------------------------------------------------------------*/

    FIND FIRST T-Fac_header.

    ASSIGN  T-Fac_header.nro_factura = NEXT-VALUE(proxima_transaccion).

    RUN TOLETRAS.P (INPUT  T-Fac_header.imp_total, OUTPUT T-Fac_header.monto_letras ).

    FIND FIRST Vigencia_cai 
         WHERE Vigencia_cai.cdg_empresa = T-Fac_header.cdg_empresa
           AND Vigencia_cai.tip_comprob = T-Fac_header.tip_comprob
           AND Vigencia_cai.prf_comprob = T-Fac_header.prf_comprob
           AND Vigencia_cai.rige_hasta  >= T-Fac_header.fecha
               NO-LOCK NO-ERROR.
    IF AVAILABLE Vigencia_cai
        THEN ASSIGN T-Fac_header.cai = Vigencia_cai.cai
                    T-Fac_header.rige_hasta = Vigencia_cai.rige_hasta.

    RUN completar_auditoria.p ( OUTPUT T-Fac_header.nro_usuario, 
                                OUTPUT T-Fac_header.fecha_grab, 
                                OUTPUT T-Fac_header.hora_grab, 
                                OUTPUT T-Fac_header.pc_name ).

    CREATE Fac_header.
    BUFFER-COPY T-Fac_header TO Fac_header.

    FOR EACH T-Fac_detalle WHERE T-Fac_detalle.nro_factura = 0:
        ASSIGN T-Fac_detalle.nro_factura = T-Fac_header.nro_factura.
        CREATE Fac_detalle.
        BUFFER-COPY T-Fac_detalle TO Fac_detalle.
    END.
    
    FOR EACH T-Fac_header-bon  WHERE T-Fac_header-bon.nro_factura = 0:
        ASSIGN T-Fac_header-bon.nro_factura = T-Fac_header.nro_factura.
        CREATE Fac_header-bon.
        BUFFER-COPY T-Fac_header-bon TO Fac_header-bon.
    END.
    
    FOR EACH T-Fac_detalle-bon  WHERE T-Fac_detalle-bon.nro_factura = 0:
        ASSIGN T-Fac_detalle-bon.nro_factura = T-Fac_header.nro_factura.
        CREATE Fac_detalle-bon.
        BUFFER-COPY T-Fac_detalle-bon TO Fac_detalle-bon.
    END.
    
    FOR EACH T-Fac_header_impuesto  WHERE T-Fac_header_impuesto.nro_factura = 0:
        ASSIGN T-Fac_header_impuesto.nro_factura = T-Fac_header.nro_factura.
        CREATE Fac_header_impuesto.
        BUFFER-COPY T-Fac_header_impuesto TO Fac_header_impuesto.
    END.
    
    FOR EACH T-Fac_detalle_impuesto  WHERE T-Fac_detalle_impuesto.nro_factura = 0:
        ASSIGN T-Fac_detalle_impuesto.nro_factura = T-Fac_header.nro_factura.
        CREATE Fac_detalle_impuesto.
        BUFFER-COPY T-Fac_detalle_impuesto TO Fac_detalle_impuesto.
    END.

    FOR EACH T-Sub_header_vta:
       CREATE Sub_header_vta.
       BUFFER-COPY T-Sub_header_vta TO Sub_header_vta.
    END.

    FOR EACH T-Sub_detalle_vta:
       CREATE Sub_detalle_vta.
       BUFFER-COPY T-Sub_detalle_vta TO Sub_detalle_vta.
    END.

    
/*---------------------------------------------------------------------------------*/
/*                 TRAEMOS TABLAS RELACIONADAS QUE HARAN FALTA                     */
/*---------------------------------------------------------------------------------*/

    FIND Cliente  OF Fac_header NO-LOCK.
    FIND Familia_cliente OF Cliente NO-LOCK.
    FIND Imputacion OF Fac_header NO-LOCK NO-ERROR.
    FIND Deposito OF Fac_header NO-LOCK.
    
/*---------------------------------------------------------------------------------*/
/*                               CUENTA CORRIENTE                                  */
/*---------------------------------------------------------------------------------*/
    
 IF Tipocomprobante.afecta_cc
 THEN DO:
    
    IF Fac_header.cta_cte
    THEN DO:
    
       FIND Condicion_venta OF Fac_header NO-LOCK.
       ASSIGN
            v-mes = Fac_header.mes
            v-ano = Fac_header.ano
            saldo_factura = Fac_header.imp_total
            aux_nro_vencimiento = 0.

       FOR EACH Subcondicion OF Condicion_venta BREAK BY Subcondicion.nro_cndventa:
    
           aux_nro_vencimiento = aux_nro_vencimiento + 1.
           
           CREATE Cta_cte.
           BUFFER-COPY Fac_header TO Cta_cte
               ASSIGN Cta_cte.nro_vencimiento      = aux_nro_vencimiento
                      Cta_cte.fecha_emision        = Fac_header.fecha
                      Cta_cte.leyenda              = Fac_header.leyenda_cc
                      Cta_cte.mes                  = v-mes
                      Cta_cte.ano                  = v-ano
                      Cta_cte.nro_cobrador         = Cliente.nro_cobrador.

           IF Condicion_venta.dias = 0 
           THEN DO: /* Modo fechas en sumar dias  */
                Cta_cte.fecha_vencimiento    = Fac_header.fecha + Subcondicion.dias.
           END.
           ELSE DO: /* Modo fechas en sumar meses */
                RUN sumarmeses.p ( INPUT Cta_cte.fecha_emision, 
                                   INPUT Subcondicion.dias, 
                                   OUTPUT Cta_cte.fecha_vencimiento ).    
           END.

           v-mes = v-mes + 1.
           IF v-mes = 13 
           THEN DO:
                v-mes = 1.
                v-ano = v-ano + 1.
           END.

           IF Condicion_venta.diferencia_iva AND Condicion_venta.nro_veniva = aux_nro_vencimiento
           THEN DO:
                IF Tipocomprobante.debita
                THEN DO:
                     Cta_cte.credito  = 0.
                     Cta_cte.debito   = Fac_header.imp_iva.
                END.
                ELSE DO:
                     Cta_cte.credito  = Fac_header.imp_iva.
                     Cta_cte.debito   = 0.
                END.          
           END.
           ELSE DO:
              es_ultimo = LAST(Subcondicion.nro_cndventa).
              RUN calcular_vencimiento.
           END.   
    
       END.
       /*    
       act_ctacte = ROWID(Cta_cte).
       RUN ACUMCCTE.P (INPUT "A").
       */
    END.
 END.

 /*---------------------------------------------------------------------------------*/
 /*                                STOCK Y ESTADISTICAS                             */
 /*---------------------------------------------------------------------------------*/
    
 /*---------------------------------------------------------------------------------*/
 /* SI NO SE TRATA DE UNA NOTA DE DEBITO, NI DE UNA NOTA DE CREDITO QUE NO AFECTA   */
 /* STOCK, ENTONCES HAY UN MOVIMIENTO DE INVENTARIO SI LA FACTURA/NCD NO ES DE UN   */
 /* REMITO/N.DEVOLUCION                                                             */
 /*---------------------------------------------------------------------------------*/

    IF Tipocomprobante.afecta_stock
    THEN DO:
    
        IF Fac_header.nro_remito = 0
        THEN DO:
             IF Tipocomprobante.debita     
             THEN DO:
                /*  {GNASIFAC.I} */
             END.
             ELSE DO:
                /*  {GNASINCD.I} */
             END.     
        END.
    
    END.

    FIND Deposito OF Fac_header NO-LOCK.
    IF Tipocomprobante.afecta_cc THEN DO:
    FIND Acumulado_punto_venta WHERE 
        Acumulado_punto_venta.cdg_puntovta = fac_header.prf_comprob and
        Acumulado_punto_venta.cdg_empresa = fac_header.cdg_empresa and
        Acumulado_punto_venta.periodo = YEAR(fac_header.fecha) * 100 + MONTH(fac_header.fecha) NO-ERROR.
    IF NOT AVAILABLE Acumulado_punto_venta THEN DO:
        CREATE acumulado_punto_venta.
        ASSIGN Acumulado_punto_venta.cdg_puntovta = fac_header.prf_comprob 
               Acumulado_punto_venta.cdg_empresa = fac_header.cdg_empresa 
               Acumulado_punto_venta.periodo = YEAR(fac_header.fecha) * 100 + MONTH(fac_header.fecha).
    END.
    IF Tipocomprobante.debita THEN Acumulado_punto_venta.importe = Acumulado_punto_venta.importe - fac_header.imp_total.
    ELSE Acumulado_punto_venta.importe = Acumulado_punto_venta.importe + fac_header.imp_total.          END.


    FOR EACH Fac_detalle OF Fac_header, EACH Articulo OF Fac_detalle:
    
                                   /*-------*/
                                   /* Stock */
                                   /*-------*/
    
          IF Tipocomprobante.afecta_stock
          THEN DO:
              IF Fac_header.origen = "M"  
                 AND Fac_header.afecta_stock  
                 AND Articulo.stock_sino
              THEN DO:
                   RUN generar_movimiento_stock.
              END.
          END.
                               /*--------------*/
                               /* Estadisticas */
                               /*--------------*/
          FIND Acum_ventas
               WHERE Acum_ventas.nro_cliente  = Fac_header.nro_cliente
                 AND Acum_ventas.fecha        = Fac_header.fecha
                 AND Acum_ventas.nro_articulo = Articulo.nro_articulo
                 AND Acum_ventas.cdg_empresa  = Fac_header.cdg_empresa
                 EXCLUSIVE-LOCK NO-ERROR.
    
          IF NOT AVAILABLE Acum_ventas
          THEN DO:
             CREATE Acum_ventas.
             ASSIGN Acum_ventas.nro_cliente  = Fac_header.nro_cliente
                    Acum_ventas.fecha        = Fac_header.fecha
                    Acum_ventas.nro_articulo = Articulo.nro_articulo
                    Acum_ventas.cdg_empresa  = Fac_header.cdg_empresa.
          END.
    
          equiv_granel = IF Fac_detalle.granel <> 0 
                            THEN Fac_detalle.granel
                            ELSE Fac_detalle.cantidad * Articulo.kgxun_neto.
    
          RUN acumular_movimiento.
          
          ASSIGN            
             Acum_ventas.nro_vendedor = Fac_header.nro_vendedor.

          RUN acumular_cliente.
          RUN acumular_articulo.
    
    END.

    rid_factura = ROWID(Fac_header).

    RUN verificar_llamada.p ( INPUT "c-comprobante_cliente,c-pos_cliente", OUTPUT es_interactivo ).
    IF es_interactivo AND Fac_header.nro_remito <> 0
    THEN DO:
        FIND Rem_header WHERE Rem_header.nro_remito = Fac_header.nro_remito EXCLUSIVE-LOCK.
        ASSIGN Rem_header.estado = "P"
               Rem_header.nro_factura = Fac_header.nro_factura.
        RELEASE Rem_header.
    END.

    RELEASE Parametro.        
    RELEASE Fac_header.
    RELEASE Fac_detalle.
    RELEASE Cta_cte.


END. /* Finaliza la transaccion de emision */
         
/*
OUTPUT TO "c:\sic-temp\emifactu.txt" PAGED.

FOR EACH Fac_detalle OF Fac_header:
    DISPLAY Fac_detalle.a_granel 
            Fac_detalle.cantidad 
            Fac_detalle.costo 
            Fac_detalle.granel 
            Fac_detalle.nro_linea 
            Fac_detalle.precio 
            Fac_detalle.precio_cf 
            Fac_detalle.subtotal_bruto 
            Fac_detalle.subtotal_bruto_cf 
            Fac_detalle.subtotal_neto 
            Fac_detalle.subtotal_neto_cf
            WITH STREAM-IO.
            
END.
OUTPUT CLOSE.
*/

/*---------------------------------------------------------------------------------*/
/*                         IMPRESION DEL COMPROBANTE                               */
/*---------------------------------------------------------------------------------*/

RUN verificar_llamada.p ( INPUT "c-comprobante_cliente,c-pos_cliente", OUTPUT es_interactivo ).

RUN getparametro_l.p (  INPUT  (IF NOT es_interactivo THEN "PRFACDIF" ELSE "PRFACONL"), OUTPUT v-prinfac_diferida ).
IF NOT v-prinfac_diferida 
    THEN RUN imprimir_comprobante_cliente.p ( rid_factura ).

/*---------------------------------------------------------------------------------*/
/*                                  PROCEDIMIENTOS                                 */
/*---------------------------------------------------------------------------------*/

PROCEDURE acumular_cliente:

   FIND Acum_ventas
        WHERE Acum_ventas.nro_cliente  = Fac_header.nro_cliente
          AND Acum_ventas.fecha        = Fac_header.fecha
          AND Acum_ventas.nro_articulo = 0
          AND Acum_ventas.cdg_empresa  = Fac_header.cdg_empresa
          EXCLUSIVE-LOCK NO-ERROR.

   IF NOT AVAILABLE Acum_ventas
   THEN DO:
      CREATE Acum_ventas.
      ASSIGN Acum_ventas.nro_cliente  = Fac_header.nro_cliente
             Acum_ventas.fecha        = Fac_header.fecha
             Acum_ventas.nro_articulo = 0
             Acum_ventas.cdg_empresa  = Fac_header.cdg_empresa.
   END.

   RUN acumular_movimiento.
         
END PROCEDURE.

PROCEDURE acumular_articulo:

   FIND Acum_ventas
        WHERE Acum_ventas.nro_cliente  = 0
          AND Acum_ventas.fecha        = Fac_header.fecha
          AND Acum_ventas.nro_articulo = Articulo.nro_articulo
          AND Acum_ventas.cdg_empresa  = Fac_header.cdg_empresa
          EXCLUSIVE-LOCK NO-ERROR.

   IF NOT AVAILABLE Acum_ventas
   THEN DO:
      CREATE Acum_ventas.
      ASSIGN Acum_ventas.nro_cliente  = 0
             Acum_ventas.fecha        = Fac_header.fecha
             Acum_ventas.nro_articulo = Articulo.nro_articulo
             Acum_ventas.cdg_empresa  = Fac_header.cdg_empresa.
   END.

   RUN acumular_movimiento.
         
END PROCEDURE.

PROCEDURE acumular_movimiento:

   Acum_ventas.nro_vendedor = 0.         

   IF Tipocomprobante.debita
   THEN DO:
      Acum_ventas.subtotal = Acum_ventas.subtotal + Fac_detalle.subtotal_neto.
      IF Tipocomprobante.afecta_stock
         THEN ASSIGN Acum_ventas.cantidad  = Acum_ventas.cantidad + Fac_detalle.cantidad
                     Acum_ventas.granel    = Acum_ventas.granel   + equiv_granel.
   END.
   ELSE DO:
      Acum_ventas.subtotal     = Acum_ventas.subtotal - Fac_detalle.subtotal_neto.
      IF Tipocomprobante.afecta_stock
         THEN ASSIGN Acum_ventas.cantidad  = Acum_ventas.cantidad - Fac_detalle.cantidad
                     Acum_ventas.granel    = Acum_ventas.granel   - equiv_granel.
   END.
         
END PROCEDURE.

PROCEDURE calcular_vencimiento:

   IF NOT Condicion_venta.diferencia_iva 
      THEN  aux_importe = ROUND(Fac_header.imp_total * Subcondicion.prc_cancelacion / 100 , 2).
      ELSE  aux_importe = ROUND((Fac_header.imp_total - Fac_header.imp_iva ) * Subcondicion.prc_cancelacion / 100 , 2).

   IF Tipocomprobante.debita
   THEN DO:
        Cta_cte.credito  = 0.
        Cta_cte.debito   = aux_importe.
   END.
   ELSE DO:
        Cta_cte.credito  = aux_importe.
        Cta_cte.debito   = 0.
   END.

   IF es_ultimo
   THEN DO:
      IF Tipocomprobante.debita
      THEN DO:
           Cta_cte.credito  = 0.
           Cta_cte.debito   = saldo_factura.
      END.
      ELSE DO:
           Cta_cte.credito  = saldo_factura.
           Cta_cte.debito   = 0.
      END.
   END.
   ELSE DO:
      saldo_factura = saldo_factura - aux_importe.
   END.
       
END PROCEDURE.       

PROCEDURE generar_movimiento_stock:

    IF TRUE /*Articulo.hay_partida*/ /* Todos los articulos tienen partidas, sean reales o ficticias */
    THEN DO:

         FIND Articulo-deposito OF Articulo 
              WHERE Articulo-deposito.nro_deposito = Deposito.nro_deposito 
                AND Articulo-deposito.cdg_empresa  = Fac_header.cdg_empresa
                    EXCLUSIVE-LOCK NO-ERROR.
         IF NOT AVAILABLE Articulo-deposito
         THEN DO:
              CREATE Articulo-deposito.
              ASSIGN Articulo-deposito.nro_articulo = Articulo.nro_articulo
                     Articulo-deposito.nro_deposito = Deposito.nro_deposito  
                     Articulo-deposito.cdg_empresa  = Fac_header.cdg_empresa.
         END.     

         FIND Partida OF Fac_detalle EXCLUSIVE-LOCK.
         IF NOT AVAILABLE Partida
         THEN DO:
              BELL.
              MESSAGE "El artículo " Articulo.cdg_articulo Articulo.descripcion " tiene "
                      "habilitadas las partidas pero no tiene ninguna ingresada. Nro.:"
                      STRING(Fac_detalle.nro_partida)
                      VIEW-AS ALERT-BOX ERROR
              TITLE "Error de consistencia en la base de datos".
         END.

         FIND Partida-deposito  
                WHERE Partida-deposito.nro_deposito = Deposito.nro_deposito
                  AND Partida-deposito.nro_articulo = Fac_detalle.nro_articulo
                  AND Partida-deposito.nro_partida  = Fac_detalle.nro_partida
                  AND Partida-deposito.cdg_empresa  = Fac_header.cdg_empresa
                      EXCLUSIVE-LOCK NO-ERROR.

         IF NOT AVAILABLE Partida-deposito
         THEN DO:
              CREATE Partida-deposito.
              ASSIGN Partida-deposito.nro_deposito = Deposito.nro_deposito
                     Partida-deposito.nro_articulo = Fac_detalle.nro_articulo
                     Partida-deposito.nro_partida  = Fac_detalle.nro_partida
                     Partida-deposito.cdg_empresa  = Fac_header.cdg_empresa.
         END.

         IF Tipocomprobante.debita 
         THEN DO:
            ASSIGN 
                 Articulo-deposito.remanente_cantidad = Articulo-deposito.remanente_cantidad - Fac_detalle.cantidad.
                 Articulo-deposito.remanente_granel   = Articulo-deposito.remanente_granel - Fac_detalle.granel.
                 Partida.remanente_cantidad           = Partida.remanente_cantidad - Fac_detalle.cantidad.
                 Partida.remanente_granel             = Partida.remanente_granel - Fac_detalle.granel.
                 Partida-deposito.remanente_cantidad  = Partida-deposito.remanente_cantidad - Fac_detalle.cantidad.
                 Partida-deposito.remanente_granel    = Partida-deposito.remanente_granel - Fac_detalle.granel.
         END.     
         ELSE DO:
            ASSIGN 
                 Articulo-deposito.remanente_cantidad = Articulo-deposito.remanente_cantidad + Fac_detalle.cantidad.
                 Articulo-deposito.remanente_granel   = Articulo-deposito.remanente_granel + Fac_detalle.granel.
                 Partida.remanente_cantidad           = Partida.remanente_cantidad + Fac_detalle.cantidad.
                 Partida.remanente_granel             = Partida.remanente_granel + Fac_detalle.granel.
                 Partida-deposito.remanente_cantidad  = Partida-deposito.remanente_cantidad + Fac_detalle.cantidad.
                 Partida-deposito.remanente_granel    = Partida-deposito.remanente_granel + Fac_detalle.granel.
         END.     

    END.

    CREATE Cct_stock.
    ASSIGN Cct_stock.nro_deposito   = Deposito.nro_deposito
           Cct_stock.tipo_mov       = IF Tipocomprobante.debita THEN "E" ELSE "I"
           Cct_stock.cdg_empresa    = Fac_header.cdg_empresa
           Cct_stock.tip_comprob    = Fac_header.tip_comprob
           Cct_stock.prf_comprob    = Fac_header.prf_comprob
           Cct_stock.nro_comprob    = Fac_header.nro_comprob
           Cct_stock.fecha          = Fac_header.fecha
           Cct_stock.nro_linea      = Fac_detalle.nro_linea
           Cct_stock.cantidad       = Fac_detalle.cantidad
           Cct_stock.granel         = Fac_detalle.granel
           Cct_stock.nro_articulo   = Fac_detalle.nro_articulo
           Cct_stock.nro_partida    = Fac_detalle.nro_partida
           Cct_stock.nro_entidad    = Deposito.nro_entidad.
/*
   act_cctstk = ROWID(Cct_stock).
   RUN ACUMSTCK.P ("A").
*/
END PROCEDURE.

