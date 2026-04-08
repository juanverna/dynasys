/*===========================================================================================*/
/*                        PRODUCE LA ANULACION DE UN COMPROBANTE DE CLIENTE                  */
/*===========================================================================================*/

DEFINE INPUT  PARAMETER rid_factura     AS ROWID.
DEFINE OUTPUT PARAMETER puede_anular    AS INTEGER.
DEFINE INPUT PARAMETER BATCH AS LOGICAL.

/*===========================================================================================*/
/*                                        VARIABLES                                          */
/*===========================================================================================*/

{vrshared.i}

DEFINE VARIABLE equiv_granel        LIKE Fac_detalle.granel.
DEFINE BUFFER b-fac_header for fac_header .
/*===========================================================================================*/
/*                                     BLOQUE PRINCIPAL                                      */
/*===========================================================================================*/

DO TRANSACTION :

     FIND Fac_header WHERE ROWID(Fac_header) = rid_factura EXCLUSIVE-LOCK.
     FIND Tipocomprobante OF Fac_header NO-LOCK.

     puede_anular = 1.
     
     FIND Sub_header_vta 
          WHERE Sub_header_vta.nro_comprob = Fac_header.nro_comprob 
            AND Sub_header_vta.prf_comprob = Fac_header.prf_comprob
            AND Sub_header_vta.tip_comprob = Fac_header.tip_comprob 
            AND Sub_header_vta.cdg_empresa = Fac_header.cdg_empresa 
                EXCLUSIVE-LOCK.

     IF Sub_header_vta.presentado <> ""
     THEN DO:
        IF NOT BATCH THEN
        RUN PONMENSJ.P (INPUT "FACT015").
        RETURN.
     END.   

     IF fac_header.nro_contrato <> 0 THEN DO:
       FIND b-fac_header WHERE rowid(b-fac_header) <> ROWID(fac_header) AND
                               b-fac_header.fecha > fac_header.fecha AND
                               b-fac_header.nro_contrato = fac_header.nro_contrato AND 
                               NOT fac_header.anulado NO-LOCK NO-ERROR.
       IF AVAILABLE b-fac_header THEN DO:
            IF NOT BATCH THEN 
            RUN PONMENSJ.P (INPUT "FACT039").
            RETURN.
       END.
     END.

     IF Fac_header.cta_cte 
     THEN DO:

        FOR EACH Cta_cte 
             WHERE Cta_cte.cdg_empresa = Fac_header.cdg_empresa
               AND Cta_cte.nro_comprob = Fac_header.nro_comprob 
               AND Cta_cte.prf_comprob = Fac_header.prf_comprob
               AND Cta_cte.tip_comprob = Fac_header.tip_comprob EXCLUSIVE-LOCK:
             IF ( Cta_cte.credito <> 0 AND LOOKUP(Fac_header.tip_comprob,str_debitan) <> 0 ) OR
                ( Cta_cte.debito  <> 0 AND LOOKUP(Fac_header.tip_comprob,str_debitan) = 0 )
             THEN DO:
                IF NOT BATCH THEN
                RUN PONMENSJ.P (INPUT "FACT016").
                RETURN.
             END.   
             ELSE DO:
                act_ctacte = ROWID(Cta_cte).
                RUN ACUMCCTE.P ( "B" ).
                DELETE Cta_cte.
             END.   
        END.
     END.   
     ELSE DO:
        FIND Caj_header 
             WHERE Caj_header.nro_transaccion = Fac_header.nro_transaccion.
        act_caj_head = ROWID(Caj_header).     
        RUN ANULCAJA.P ( OUTPUT puede_anular ).
        IF puede_anular <> 0
        THEN DO:
           IF NOT BATCH THEN
           RUN PONMENSJ.P (INPUT "FACT015").
           RETURN.
        END.   
     END.   

     IF fac_header.nro_contrato <> 0 THEN do:
                       FIND contrato_hd OF fac_header NO-ERROR.
                       IF AVAILABLE contrato_hd THEN
                          ASSIGN Contrato_hd.resto_periodos = IF contrato_hd.cant_periodos > 0 THEN Contrato_hd.resto_periodos + 1 ELSE 0.
     END.

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
            IF Tipocomprobante.debita THEN Acumulado_punto_venta.importe = Acumulado_punto_venta.importe + fac_header.imp_total.
            ELSE Acumulado_punto_venta.importe = Acumulado_punto_venta.importe - fac_header.imp_total.
          END.
     
          FOR EACH Fac_detalle OF Fac_header, EACH Articulo OF Fac_detalle:

                                   /*-------*/
                                   /* Stock */
                                   /*-------*/
    
                                      
          IF Fac_header.origen = "M"  
             AND Tipocomprobante.afecta_stock  
             AND Articulo.stock_sino
          THEN DO:
               RUN anular_movimiento_stock.
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
    
          RUN desacumular_movimiento.
          
          ASSIGN            
             Acum_ventas.nro_vendedor = Fac_header.nro_vendedor         
             Fac_header.proc_estad    = YES.
    
          RUN desacumular_cliente.
          RUN desacumular_articulo.
    
     END.

     IF Fac_header.nro_remito <> 0
     THEN DO:
         FOR EACH Rem_header WHERE Rem_header.nro_remito = Fac_header.nro_remito EXCLUSIVE-LOCK:
             Rem_header.estado = "E".
         END.
     END.

     Sub_header_vta.anulado = YES.
     Fac_header.anulado     = YES.
     puede_anular = 0.

END.

/*===========================================================================================*/
/*                                     PROCEDIMIENTOS                                        */
/*===========================================================================================*/


PROCEDURE desacumular_cliente:

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

   RUN desacumular_movimiento.
         
END PROCEDURE.

PROCEDURE desacumular_articulo:

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

   RUN desacumular_movimiento.
         
END PROCEDURE.

PROCEDURE desacumular_movimiento:

   Acum_ventas.nro_vendedor = 0.         

   IF LOOKUP(Fac_header.tip_comprob,str_debitan) <> 0
   THEN DO:
      Acum_ventas.subtotal = Acum_ventas.subtotal - Fac_detalle.subtotal_neto.
      IF Fac_header.afecta_stock
         THEN ASSIGN Acum_ventas.cantidad  = Acum_ventas.cantidad - Fac_detalle.cantidad
                     Acum_ventas.granel    = Acum_ventas.granel   - equiv_granel.
   END.
   ELSE DO:
      Acum_ventas.subtotal = Acum_ventas.subtotal + Fac_detalle.subtotal_neto.
      IF Fac_header.afecta_stock
         THEN ASSIGN Acum_ventas.cantidad  = Acum_ventas.cantidad + Fac_detalle.cantidad
                     Acum_ventas.granel    = Acum_ventas.granel   + equiv_granel.
   END.
         
END PROCEDURE.

PROCEDURE anular_movimiento_stock:

    IF TRUE /*Articulo.hay_partida*/ /* Todos los articulos tienen partidas, sean reales o ficticias */
    THEN DO:

         FIND Articulo-deposito OF Articulo 
              WHERE Articulo-deposito.nro_deposito = Fac_header.nro_deposito 
                AND Articulo-deposito.cdg_empresa  = Fac_header.cdg_empresa
                    EXCLUSIVE-LOCK NO-ERROR.
         IF NOT AVAILABLE Articulo-deposito
            THEN MESSAGE "ART " STRING(Articulo.cdg_articulo) SKIP "DEP " STRING(Fac_header.nro_deposito)
                         VIEW-AS ALERT-BOX MESSAGE TITLE "Falta Depósito".                                            

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
                WHERE Partida-deposito.nro_deposito = Fac_header.nro_deposito
                  AND Partida-deposito.nro_articulo = Fac_detalle.nro_articulo
                  AND Partida-deposito.nro_partida  = Fac_detalle.nro_partida
                  AND Partida-deposito.cdg_empresa  = Fac_header.cdg_empresa
                      EXCLUSIVE-LOCK NO-ERROR.

         IF NOT AVAILABLE Partida-deposito
         THEN DO:
              CREATE Partida-deposito.
              ASSIGN Partida-deposito.nro_deposito = Fac_header.nro_deposito
                     Partida-deposito.nro_articulo = Fac_detalle.nro_articulo
                     Partida-deposito.nro_partida  = Fac_detalle.nro_partida
                     Partida-deposito.cdg_empresa  = Fac_header.cdg_empresa.
         END.

         IF LOOKUP(Fac_header.tip_comprob,"FA,FB,FC") <> 0 
         THEN DO:
            ASSIGN 
                 Articulo-deposito.remanente_cantidad = Articulo-deposito.remanente_cantidad + Fac_detalle.cantidad.
                 Articulo-deposito.remanente_granel   = Articulo-deposito.remanente_granel + Fac_detalle.granel.
                 Partida.remanente_cantidad           = Partida.remanente_cantidad + Fac_detalle.cantidad.
                 Partida.remanente_granel             = Partida.remanente_granel + Fac_detalle.granel.
                 Partida-deposito.remanente_cantidad  = Partida-deposito.remanente_cantidad + Fac_detalle.cantidad.
                 Partida-deposito.remanente_granel    = Partida-deposito.remanente_granel + Fac_detalle.granel.
         END.     
         ELSE DO:
            ASSIGN 
                 Articulo-deposito.remanente_cantidad = Articulo-deposito.remanente_cantidad - Fac_detalle.cantidad.
                 Articulo-deposito.remanente_granel   = Articulo-deposito.remanente_granel - Fac_detalle.granel.
                 Partida.remanente_cantidad           = Partida.remanente_cantidad - Fac_detalle.cantidad.
                 Partida.remanente_granel             = Partida.remanente_granel - Fac_detalle.granel.
                 Partida-deposito.remanente_cantidad  = Partida-deposito.remanente_cantidad - Fac_detalle.cantidad.
                 Partida-deposito.remanente_granel    = Partida-deposito.remanente_granel - Fac_detalle.granel.
         END.     

    END.

    FIND Cct_stock
         WHERE Cct_stock.nro_deposito   = Fac_header.nro_deposito
           AND Cct_stock.cdg_empresa    = Fac_header.cdg_empresa
           AND Cct_stock.tip_comprob    = Fac_header.tip_comprob
           AND Cct_stock.prf_comprob    = Fac_header.prf_comprob
           AND Cct_stock.nro_comprob    = Fac_header.nro_comprob
           AND Cct_stock.fecha          = Fac_header.fecha
           AND Cct_stock.nro_linea      = Fac_detalle.nro_linea
           AND Cct_stock.nro_articulo   = Fac_detalle.nro_articulo
           AND Cct_stock.nro_partida    = Fac_detalle.nro_partida
           AND Cct_stock.nro_entidad    = Fac_header.nro_cliente
               EXCLUSIVE-LOCK NO-ERROR.

    IF AVAILABLE Cct_stock
    THEN DO:
        RUN ACUMSTCK.P ( INPUT ROWID(Cct_stock), INPUT "B").
        DELETE Cct_stock.
    END.

END PROCEDURE.



