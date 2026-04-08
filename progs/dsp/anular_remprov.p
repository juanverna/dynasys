/*===========================================================================================*/
/*                        PRODUCE LA ANULACION DE UNA ORDEN DE PAGO                          */
/*===========================================================================================*/

DEFINE INPUT  PARAMETER rid_remprov     AS ROWID.
DEFINE OUTPUT PARAMETER puede_anular    AS INTEGER.

/*===========================================================================================*/
/*                                        VARIABLES                                          */
/*===========================================================================================*/

{vrshared.i}

/*===========================================================================================*/
/*                                     BLOQUE PRINCIPAL                                      */
/*===========================================================================================*/

DO ON ERROR UNDO, LEAVE: /* ARRANCAMOS AQUI LA TRANSACCION */

    FIND Rem_header_prv WHERE ROWID(Rem_header_prv) = rid_remprov EXCLUSIVE-LOCK NO-ERROR.
    FIND Imputacion OF  Rem_header_prv NO-LOCK NO-ERROR.
    FIND Deposito   OF  Rem_header_prv NO-LOCK NO-ERROR.

    /*=================================================================================*/
    /*                                      STOCK                                      */
    /*=================================================================================*/
 
    FOR EACH Rem_detalle_prv OF Rem_header_prv EXCLUSIVE-LOCK, 
             FIRST Articulo EXCLUSIVE-LOCK OF Rem_detalle_prv:
    
        IF TRUE /*Articulo.hay_partida*/ /* Todos los articulos tienen partidas, sean reales o ficticias */
        THEN DO:
    
             /*
             FIND Deposito OF Rem_detalle_prv NO-LOCK NO-ERROR.
             */
             FIND Articulo-deposito 
                  WHERE Articulo-deposito.cdg_empresa  = Rem_header_prv.cdg_empresa
                    AND Articulo-deposito.nro_deposito = Rem_header_prv.nro_deposito
                    AND Articulo-deposito.nro_articulo = Rem_detalle_prv.nro_articulo
                        EXCLUSIVE-LOCK NO-ERROR.
    
             IF NOT AVAILABLE Articulo-deposito
             THEN DO:
                  CREATE Articulo-deposito.
                  ASSIGN Articulo-deposito.cdg_empresa  = Rem_header_prv.cdg_empresa
                         Articulo-deposito.nro_deposito = Rem_header_prv.nro_deposito
                         Articulo-deposito.nro_articulo = Rem_detalle_prv.nro_articulo.
             END.
                    
             FIND Partida 
                  WHERE Partida.cdg_empresa  = Rem_header_prv.cdg_empresa
                    AND Partida.nro_articulo = Rem_detalle_prv.nro_articulo
                    AND Partida.nro_partida  = Rem_detalle_prv.nro_partida
                        EXCLUSIVE-LOCK NO-ERROR.
    
             FIND Partida-deposito  
                  WHERE Partida-deposito.cdg_empresa  = Rem_header_prv.cdg_empresa
                    AND Partida-deposito.nro_deposito = Rem_header_prv.nro_deposito
                    AND Partida-deposito.nro_articulo = Rem_detalle_prv.nro_articulo
                    AND Partida-deposito.nro_partida  = Rem_detalle_prv.nro_partida
                        EXCLUSIVE-LOCK NO-ERROR.
    
             IF NOT AVAILABLE Partida-deposito
             THEN DO:
                  CREATE Partida-deposito.
                  ASSIGN Partida-deposito.cdg_empresa  = Rem_header_prv.cdg_empresa
                         Partida-deposito.nro_deposito = Rem_header_prv.nro_deposito
                         Partida-deposito.nro_articulo = Rem_detalle_prv.nro_articulo
                         Partida-deposito.nro_partida  = Rem_detalle_prv.nro_partida.
             END.
    
             IF Rem_header_prv.tip_comprob = "RP" 
             THEN DO:
                  Articulo-deposito.remanente_cantidad = Articulo-deposito.remanente_cantidad - Rem_detalle_prv.cantidad.
                  Articulo-deposito.remanente_granel   = Articulo-deposito.remanente_granel - Rem_detalle_prv.granel.
                  Partida.remanente_cantidad           = Partida.remanente_cantidad - Rem_detalle_prv.cantidad.
                  Partida.remanente_granel             = Partida.remanente_granel - Rem_detalle_prv.granel.
                  Partida-deposito.remanente_cantidad  = Partida-deposito.remanente_cantidad - Rem_detalle_prv.cantidad.
                  Partida-deposito.remanente_granel    = Partida-deposito.remanente_granel - Rem_detalle_prv.granel.
             END.
             ELSE DO:   
                  Articulo-deposito.remanente_cantidad = Articulo-deposito.remanente_cantidad + Rem_detalle_prv.cantidad.
                  Articulo-deposito.remanente_granel   = Articulo-deposito.remanente_granel + Rem_detalle_prv.granel.
                  Partida.remanente_cantidad           = Partida.remanente_cantidad + Rem_detalle_prv.cantidad.
                  Partida.remanente_granel             = Partida.remanente_granel + Rem_detalle_prv.granel.
                  Partida-deposito.remanente_cantidad  = Partida-deposito.remanente_cantidad + Rem_detalle_prv.cantidad.
                  Partida-deposito.remanente_granel    = Partida-deposito.remanente_granel + Rem_detalle_prv.granel.
             END.
    
        END.
        IF Rem_header_prv.tip_comprob = "RP" 
                     THEN DO:
    
                            FIND   Cct_stock 
                                    WHERE   Cct_stock.tip_comprob    = Rem_header_prv.tip_comprob
                                      AND   Cct_stock.prf_comprob    = Rem_header_prv.prf_comprob
                                      AND   Cct_stock.nro_comprob    = Rem_header_prv.nro_comprob
                                      AND   Cct_stock.nro_linea      = Rem_detalle_prv.nro_linea
                                      AND   Cct_stock.nro_proveedor  = Rem_header_prv.nro_proveedor
                                            EXCLUSIVE-LOCK NO-ERROR.
                        
                           act_cctstk = ROWID(Cct_stock).
                           RUN ACUMSTCK.P ("B").
                           
                           DELETE Cct_stock.
                     END.
                   /*--------------------------------------*/
                   /*   ACTUALIZA EL P.P.P. DEL ARTICULO   */
                   /*--------------------------------------*/

            IF Rem_header_prv.tip_comprob = "RP" 
            THEN DO:
                    Articulo.total_comprado = Articulo.total_comprado - 
                            ( IF Articulo.a_granel 
                                 THEN ROUND( Rem_detalle_prv.precio * Rem_detalle_prv.granel   , 2 )
                                 ELSE ROUND( Rem_detalle_prv.precio * Rem_detalle_prv.cantidad , 2 ) ).
                                 
                    Articulo.unidades_compradas = Articulo.unidades_compradas + Rem_detalle_prv.cantidad.
                    Articulo.granel_comprado    = Articulo.granel_comprado + Rem_detalle_prv.granel.
            END.
            ELSE DO:
                    Articulo.total_comprado = Articulo.total_comprado + 
                            ( IF Articulo.a_granel 
                                 THEN ROUND( Rem_detalle_prv.precio * Rem_detalle_prv.granel   , 2 )
                                 ELSE ROUND( Rem_detalle_prv.precio * Rem_detalle_prv.cantidad , 2 ) ).
                                 
                    Articulo.unidades_compradas = Articulo.unidades_compradas + Rem_detalle_prv.cantidad.
                    Articulo.granel_comprado    = Articulo.granel_comprado + Rem_detalle_prv.granel.
            END.


       IF Articulo.a_granel 
          THEN Articulo.costo = Articulo.total_comprado / Articulo.granel_comprado.
       ELSE 
           Articulo.costo = Articulo.total_comprado / Articulo.unidades_compradas.

       IF Rem_header_prv.tip_comprob = "RP" THEN
       DELETE Rem_detalle_prv.

 END.
    /*=================================================================================*/
    /*           DESASIGNA EL REMITO DE LAS O/COMPRA A LAS QUE IMPUTE                  */
    /*=================================================================================*/

    FOR EACH Recepcion-ocompra
        WHERE Recepcion-ocompra.nro_remprov  = Rem_header_prv.nro_remprov 
              EXCLUSIVE-LOCK:
           
        DELETE Recepcion-ocompra.
           
    END.    

    /*=================================================================================*/
    /*                 ELIMINA LA IMPUTACION CONTABLE DEL COMPROBANTE                  */
    /*=================================================================================*/
    IF Rem_header_prv.tip_comprob = "RP" 
             THEN DO:

    FIND   Sub_header_inv
           WHERE Sub_header_inv.nro_proveedor = Rem_header_prv.nro_proveedor
             AND Sub_header_inv.tip_comprob   = Rem_header_prv.tip_comprob
             AND Sub_header_inv.prf_comprob   = Rem_header_prv.prf_comprob
             AND Sub_header_inv.nro_comprob   = Rem_header_prv.nro_comprob
             AND Sub_header_inv.fecha         = Rem_header_prv.fecha
                 EXCLUSIVE-LOCK NO-ERROR.
        
    FOR EACH Sub_detalle_inv 
             WHERE Sub_detalle_inv.nro_proveedor  = Rem_header_prv.nro_proveedor
               AND Sub_detalle_inv.tip_comprob    = Rem_header_prv.tip_comprob
               AND Sub_detalle_inv.prf_comprob    = Rem_header_prv.prf_comprob
               AND Sub_detalle_inv.nro_comprob    = Rem_header_prv.nro_comprob
               EXCLUSIVE-LOCK:
             
          DELETE Sub_detalle_inv.   
    END.             
    
    DELETE Sub_header_inv.
    END.
    /*=================================================================================*/
    /*                     FINALIZA LA TRANSACCION DE ACTUALIZACION                    */
    /*=================================================================================*/
END.
puede_anular = 1.
    FIND Rem_header_prv WHERE ROWID(Rem_header_prv) = rid_remprov EXCLUSIVE-LOCK NO-ERROR.
    
    IF Rem_header_prv.tip_comprob = "RP" THEN DO:

        DELETE Rem_header_prv.
    
        puede_anular = 0.

    END.
     
    IF Rem_header_prv.tip_comprob = "RM" 
    THEN DO:
        FIND Sre_header WHERE Sre_header.nro_solicitud = Rem_header_prv.nro_solicitud 
                          AND Sre_header.cdg_estado = "RE" EXCLUSIVE-LOCK NO-ERROR.
        IF AVAILABLE Sre_header THEN DO:
             Sre_header.cdg_estado = "AA".
             Sre_header.estado = "E".

             FOR EACH Sre_detalle OF Sre_header EXCLUSIVE-LOCK:
                  Sre_detalle.cdg_estado = "AA".
             END.
             Rem_header_prv.anulado = YES.
      /*     puede_anular = YES. */
             puede_anular = 0.
       END.

    END.  /* FIN DE LA TRANSACCION */
