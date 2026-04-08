/*=================================================================================*/
/*                         EMITE UN REMITO DE PROVEEDOR                            */
/*=================================================================================*/

DEFINE INPUT PARAMETER rid_remito AS ROWID.

/*=================================================================================*/
/*                                 VARIABLES                                       */
/*=================================================================================*/

{VRSHARED.I}
{VPERSINM.I}

DEFINE VARIABLE saldo_remito        AS DECIMAL.
DEFINE VARIABLE aux_nro_vencimiento AS INTEGER.
DEFINE VARIABLE j                   AS INTEGER.
DEFINE VARIABLE ncopias             AS INTEGER.

DEFINE VARIABLE que_rutina          AS CHARACTER.
DEFINE BUFFER B-Rem_detalle_prv FOR Rem_detalle_prv.

/*=================================================================================*/
/*                     ARRANCA LA TRANSACCION DE ACTUALIZACION                     */
/*=================================================================================*/

DO ON ERROR UNDO, LEAVE: /* ARRANCAMOS AQUI LA TRANSACCION */

        FIND Rem_header_prv WHERE ROWID(Rem_header_prv) = rid_remito EXCLUSIVE-LOCK.
        FIND FIRST Vigencia_cai
             WHERE Vigencia_cai.cdg_empresa = Rem_header_prv.cdg_empresa
               AND Vigencia_cai.tip_comprob = Rem_header_prv.tip_comprob
               AND Vigencia_cai.prf_comprob = Rem_header_prv.prf_comprob
               AND Vigencia_cai.rige_hasta  >= Rem_header_prv.fecha
                   NO-LOCK NO-ERROR.

        IF AVAILABLE Vigencia_cai
        THEN DO:
            ASSIGN Rem_header_prv.rige_hasta = Vigencia_cai.rige_hasta
                   Rem_header_prv.cai        = Vigencia_cai.cai.
        END.

        FIND Imputacion OF  Rem_header_prv NO-LOCK.
        FIND Deposito   OF  Rem_header_prv NO-LOCK.
        
        /*=============================================================================*/
        /*                                  STOCK                                      */
        /*=============================================================================*/
        
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
                            EXCLUSIVE-LOCK.
        
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
                      Articulo-deposito.remanente_cantidad = Articulo-deposito.remanente_cantidad + Rem_detalle_prv.cantidad.
                      Articulo-deposito.remanente_granel   = Articulo-deposito.remanente_granel + Rem_detalle_prv.granel.
                      Partida.remanente_cantidad           = Partida.remanente_cantidad + Rem_detalle_prv.cantidad.
                      Partida.remanente_granel             = Partida.remanente_granel + Rem_detalle_prv.granel.
                      Partida-deposito.remanente_cantidad  = Partida-deposito.remanente_cantidad + Rem_detalle_prv.cantidad.
                      Partida-deposito.remanente_granel    = Partida-deposito.remanente_granel + Rem_detalle_prv.granel.
                 END.
                 ELSE DO:   
                      Articulo-deposito.remanente_cantidad = Articulo-deposito.remanente_cantidad - Rem_detalle_prv.cantidad.
                      Articulo-deposito.remanente_granel   = Articulo-deposito.remanente_granel - Rem_detalle_prv.granel.
                      Partida.remanente_cantidad           = Partida.remanente_cantidad - Rem_detalle_prv.cantidad.
                      Partida.remanente_granel             = Partida.remanente_granel - Rem_detalle_prv.granel.
                      Partida-deposito.remanente_cantidad  = Partida-deposito.remanente_cantidad - Rem_detalle_prv.cantidad.
                      Partida-deposito.remanente_granel    = Partida-deposito.remanente_granel - Rem_detalle_prv.granel.
                 END.
        
            END.
        
            CREATE Cct_stock.
            ASSIGN Cct_stock.nro_deposito   = Deposito.nro_deposito
                   Cct_stock.tipo_mov       = ( IF Rem_header_prv.tip_comprob = "RP" THEN "I" ELSE "E" )
                   Cct_stock.cdg_empresa    = Rem_header_prv.cdg_empresa
                   Cct_stock.tip_comprob    = Rem_header_prv.tip_comprob
                   Cct_stock.prf_comprob    = Rem_header_prv.prf_comprob
                   Cct_stock.nro_comprob    = Rem_header_prv.nro_comprob
                   Cct_stock.nro_proveedor  = Rem_header_prv.nro_proveedor
                   Cct_stock.fecha          = Rem_header_prv.fecha
                   Cct_stock.nro_linea      = Rem_detalle_prv.nro_linea
                   Cct_stock.cantidad       = Rem_detalle_prv.cantidad
                   Cct_stock.granel         = Rem_detalle_prv.granel
                   Cct_stock.nro_articulo   = Rem_detalle_prv.nro_articulo
                   Cct_stock.nro_partida    = Rem_detalle_prv.nro_partida
                   Cct_stock.nro_entidad    = Rem_detalle_prv.nro_entidad.
        
           RUN acumular_movimiento_stock.p ( INPUT ROWID(Cct_stock), INPUT "A").
        
                       /*--------------------------------------------*/
                       /*      ACTUALIZA EL P.P.P. DEL ARTICULO      */
                       /*--------------------------------------------*/
        
           IF Rem_header_prv.tip_comprob = "RP"
           THEN DO:
                Articulo.total_comprado = Articulo.total_comprado + 
                        ( IF Articulo.a_granel 
                             THEN ROUND( Rem_detalle_prv.precio * Rem_detalle_prv.granel   , 2 )
                             ELSE ROUND( Rem_detalle_prv.precio * Rem_detalle_prv.cantidad , 2 ) ).
                             
                Articulo.unidades_compradas = Articulo.unidades_compradas + Rem_detalle_prv.cantidad.
                Articulo.granel_comprado    = Articulo.granel_comprado + Rem_detalle_prv.granel.
           END.
           ELSE DO:
                Articulo.total_comprado = Articulo.total_comprado - 
                        ( IF Articulo.a_granel 
                             THEN ROUND( Rem_detalle_prv.precio * Rem_detalle_prv.granel   , 2 )
                             ELSE ROUND( Rem_detalle_prv.precio * Rem_detalle_prv.cantidad , 2 ) ).
                             
                Articulo.unidades_compradas = Articulo.unidades_compradas - Rem_detalle_prv.cantidad.
                Articulo.granel_comprado    = Articulo.granel_comprado - Rem_detalle_prv.granel.
           END.
           
           IF Articulo.a_granel 
              THEN Articulo.costo = Articulo.total_comprado / Articulo.granel_comprado.
              ELSE Articulo.costo = Articulo.total_comprado / Articulo.unidades_compradas.
        
                       /*--------------------------------------------*/
                       /* ACTUALIZA EL ESTADO DE LA O/COMPRA, SI HAY */
                       /* Y ACTUALIZA EL MOVIMIENTO DE STOCK PRESU-  */
                       /* PUESTADO DE LA MISMA CON LA RECEPCION      */
                       /*--------------------------------------------*/
    
            IF Rem_detalle_prv.nro_ocompra <> 0
            THEN DO:
                FIND Ocm_header OF Rem_detalle_prv EXCLUSIVE-LOCK.
                FIND FIRST Ocm_detalle OF Ocm_header 
                     WHERE Ocm_detalle.nro_linea = Rem_detalle_prv.nro_linea_ocm EXCLUSIVE-LOCK.
                ASSIGN
                     Ocm_detalle.cantidad_rec = Ocm_detalle.cantidad_rec + Rem_detalle_prv.cantidad
                     Ocm_detalle.granel_rec   = Ocm_detalle.granel_rec   + Rem_detalle_prv.granel.
                IF Ocm_detalle.cantidad_rec >= Ocm_detalle.cantidad
                    THEN Ocm_detalle.cdg_estado = "CC".
              
                FIND Cct_stock
                     WHERE Cct_stock.cdg_empresa    = Ocm_header.cdg_empresa
                       AND Cct_stock.tip_comprob    = Ocm_header.tip_comprob
                       AND Cct_stock.prf_comprob    = Ocm_header.prf_comprob
                       AND Cct_stock.nro_comprob    = Ocm_header.nro_comprob
                       AND Cct_stock.nro_linea      = Ocm_detalle.nro_linea
                       AND Cct_stock.nro_articulo   = Ocm_detalle.nro_articulo
                           EXCLUSIVE-LOCK NO-ERROR.
                           
                IF AVAILABLE Cct_stock
                THEN DO:
                    IF Ocm_detalle.cantidad_rec < Ocm_detalle.cantidad /* Hay saldo de la O/Compra */
                    THEN DO:
                         ASSIGN Cct_stock.cantidad = Ocm_detalle.cantidad - Ocm_detalle.cantidad_rec
                                Cct_stock.granel   = Ocm_detalle.granel   - Ocm_detalle.granel_rec.  
                         RELEASE Cct_stock.  
                    END.
                    ELSE DO:
                         DELETE Cct_stock.  /* No hay saldo de la O/Compra */
                    END.
                END.

                IF NOT CAN-FIND(FIRST Ocm_detalle OF Ocm_header WHERE Ocm_detalle.cdg_estado = "AA")
                    THEN Ocm_header.cdg_estado = "CC".
            END.
            
    
    END.

/*=================================================================================*/
/*                     GENERA IMPUTACION CONTABLE DEL COMPROBANTE                  */
/*=================================================================================*/

{CALCRPRO.I } /* Genera el registro contable */

/*=================================================================================*/
/*                     FINALIZA LA TRANSACCION DE ACTUALIZACION                    */
/*=================================================================================*/

END.  /* FIN DE LA TRANSACCION */


/*=================================================================================*/
/*                           IMPRESION DEL COMPROBANTE                             */
/*=================================================================================*/

/* RUN imprimir_remprov.p ( INPUT ROWID(Rem_header_prv)).  */
/* run prrpv103b.p ( input rowid(Rem_header_prv)).  */
