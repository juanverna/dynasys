/*=================================================================================*/
/*                         EMISION DE LOS VALES DE INVENTARIO                      */
/*=================================================================================*/

/*=================================================================================*/
/*                                  PARAMETROS                                     */
/*=================================================================================*/

DEFINE INPUT PARAMETER rid_vale AS ROWID.
DEFINE OUTPUT PARAMETER puede_anular AS INTEGER INITIAL 0.

/*=================================================================================*/
/*                           VARIABLES                                             */
/*=================================================================================*/

/*{VRSHARED.I}
{VPERSINM.I}*/

/*=================================================================================*/
/*                     ARRANCA LA TRANSACCION DE ACTUALIZACION                     */
/*=================================================================================*/

DO ON ERROR UNDO, LEAVE: /* ARRANCAMOS AQUI LA TRANSACCION */

    FIND Valeinv_hd WHERE ROWID(Valeinv_hd) = rid_vale EXCLUSIVE-LOCK.
    FIND Tipocomprobante OF Valeinv_hd NO-LOCK.

/*---------------------------------------------------------------------------------*/
/*                     ANULA IMPUTACION CONTABLE DEL COMPROBANTE                   */
/*---------------------------------------------------------------------------------*/

    FIND Sub_header_inv OF Valeinv_hd EXCLUSIVE-LOCK NO-ERROR.
    IF AVAILABLE Sub_header_inv
        THEN Sub_header_inv.anulado = YES.

/*---------------------------------------------------------------------------------*/
/*                                      STOCK                                      */
/*---------------------------------------------------------------------------------*/

    FOR EACH Valeinv_dt OF Valeinv_hd EXCLUSIVE-LOCK, EACH Articulo OF Valeinv_dt NO-LOCK:

        FIND Articulo-deposito 
              WHERE Articulo-deposito.nro_articulo = Valeinv_dt.nro_articulo
                AND Articulo-deposito.nro_deposito = Valeinv_dt.nro_deposito 
                AND Articulo-deposito.cdg_empresa  = Valeinv_hd.cdg_empresa 
                    EXCLUSIVE-LOCK NO-ERROR.

        IF NOT AVAILABLE Articulo-deposito
        THEN DO:
            CREATE Articulo-deposito.
            ASSIGN Articulo-deposito.nro_deposito = Valeinv_dt.nro_deposito
                   Articulo-deposito.nro_articulo = Valeinv_dt.nro_articulo
                   Articulo-deposito.cdg_empresa  = Valeinv_hd.cdg_empresa.
         
        END.

        FIND Partida-deposito
              WHERE Partida-deposito.nro_deposito = Valeinv_dt.nro_deposito
                AND Partida-deposito.nro_articulo = Valeinv_dt.nro_articulo
                AND Partida-deposito.nro_partida  = Valeinv_dt.nro_partida
                AND Partida-deposito.cdg_empresa  = Valeinv_hd.cdg_empresa
                    EXCLUSIVE-LOCK NO-ERROR.

        IF NOT AVAILABLE Partida-deposito
        THEN DO:
            CREATE Partida-deposito.
            ASSIGN Partida-deposito.nro_deposito = Valeinv_dt.nro_deposito
                   Partida-deposito.nro_articulo = Valeinv_dt.nro_articulo
                   Partida-deposito.nro_partida  = Valeinv_dt.nro_partida
                   Partida-deposito.cdg_empresa  = Valeinv_hd.cdg_empresa.
        END.

        FIND Partida OF Valeinv_dt EXCLUSIVE-LOCK.

        IF Tipocomprobante.debita 
        THEN DO:
            ASSIGN Articulo-deposito.remanente_cantidad = Articulo-deposito.remanente_cantidad - Valeinv_dt.cantidad.
                   Articulo-deposito.remanente_granel   = Articulo-deposito.remanente_granel - Valeinv_dt.granel.
                   Partida.remanente_cantidad           = Partida.remanente_cantidad - Valeinv_dt.cantidad.
                   Partida.remanente_granel             = Partida.remanente_granel - Valeinv_dt.granel.
                   Partida-deposito.remanente_cantidad  = Partida-deposito.remanente_cantidad - Valeinv_dt.cantidad.
                   Partida-deposito.remanente_granel    = Partida-deposito.remanente_granel - Valeinv_dt.granel.
        END.
        ELSE DO:
            ASSIGN Articulo-deposito.remanente_cantidad = Articulo-deposito.remanente_cantidad + Valeinv_dt.cantidad.
                   Articulo-deposito.remanente_granel   = Articulo-deposito.remanente_granel + Valeinv_dt.granel.
                   Partida.remanente_cantidad           = Partida.remanente_cantidad + Valeinv_dt.cantidad.
                   Partida.remanente_granel             = Partida.remanente_granel + Valeinv_dt.granel.
                   Partida-deposito.remanente_cantidad  = Partida-deposito.remanente_cantidad + Valeinv_dt.cantidad.
                   Partida-deposito.remanente_granel    = Partida-deposito.remanente_granel + Valeinv_dt.granel.
        END.
    
        FOR EACH Cct_stock OF Valeinv_hd:
            RUN acumular_movimiento_stock.p ( INPUT ROWID(Cct_stock), INPUT "B").
            DELETE Cct_stock.
        END.

    END.

    Valeinv_hd.anulado = YES.

/*=================================================================================*/
/*                     FINALIZA LA TRANSACCION DE ACTUALIZACION                    */
/*=================================================================================*/

END.  /* FIN DE LA TRANSACCION */

