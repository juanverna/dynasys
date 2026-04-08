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
                            EXCLUSIVE-LOCK no-error.
        
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
            ASSIGN
                   Cct_stock.nro_deposito   = Deposito.nro_deposito
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
        
           act_cctstk = ROWID(Cct_stock).
           RUN ACUMSTCK.P ("A").
    
    END.

/*=================================================================================*/
/*                     GENERA IMPUTACION CONTABLE DEL COMPROBANTE                  */
/*=================================================================================*/

/*=================================================================================*/
/*                     FINALIZA LA TRANSACCION DE ACTUALIZACION                    */
/*=================================================================================*/

END.  /* FIN DE LA TRANSACCION */


/*=================================================================================*/
/*                           IMPRESION DEL COMPROBANTE                             */
/*=================================================================================*/

RUN imprimir_remprov.p ( INPUT ROWID(Rem_header)).

