/*=================================================================================*/
/*                 VERIFICA QUE EL CALCE DE PEDIDO Y REMITO SEA FACTIBLE           */
/*=================================================================================*/

DEFINE INPUT  PARAMETER p-nro_pedido LIKE Ped_header.nro_pedido.
DEFINE INPUT  PARAMETER p-nro_remito LIKE Rem_header.nro_remito.
DEFINE INPUT  PARAMETER p-fecha      AS DATE.

DEFINE OUTPUT PARAMETER p-rc         AS INTEGER.

/*=================================================================================*/
/*                                    PROCESO                                      */
/*=================================================================================*/

{findempresa.i}

DO TRANSACTION:

    FIND Ped_header WHERE Ped_header.nro_pedido = p-nro_pedido EXCLUSIVE-LOCK NO-ERROR.
    IF NOT AVAILABLE Ped_header
    THEN DO:
         p-rc = 1.
         RETURN.
    END.
    
    FIND Rem_header WHERE Rem_header.nro_remito = p-nro_remito EXCLUSIVE-LOCK NO-ERROR.
    IF NOT AVAILABLE Rem_header
    THEN DO:
         p-rc = 2.
         RETURN.
    END.

    FIND Tipocomprobante OF Rem_header NO-LOCK.
    
    p-rc = 0.
    FOR EACH Rem_detalle OF Rem_header EXCLUSIVE-LOCK:

        FIND FIRST Ped_detalle OF Ped_header
             WHERE Ped_detalle.nro_articulo = Rem_detalle.nro_articulo
             /*  AND LOOKUP(Ped_detalle.cdg_estado,"AM/AA","/") <> 0 */
                   EXCLUSIVE-LOCK.
       
        CREATE Remito-pedido.
        ASSIGN Remito-pedido.nro_remito     = Rem_detalle.nro_remito
               Remito-pedido.nro_linea-rem  = Rem_detalle.nro_linea
               Remito-pedido.nro_pedido     = Ped_detalle.nro_pedido
               Remito-pedido.nro_linea-ped  = Ped_detalle.nro_linea
               Remito-pedido.cantidad       = Rem_detalle.cantidad
               Remito-pedido.granel         = Rem_detalle.granel.

        IF Tipocomprobante.debita
        THEN DO:
             ASSIGN
                 Ped_detalle.cantidad_cum   = Ped_detalle.cantidad_cum + Rem_detalle.cantidad
                 Ped_detalle.granel_cum     = Ped_detalle.granel_cum + Rem_detalle.granel.
        END.
        ELSE DO:
             ASSIGN
                 Ped_detalle.cantidad_cum   = Ped_detalle.cantidad_cum - Rem_detalle.cantidad
                 Ped_detalle.granel_cum     = Ped_detalle.granel_cum - Rem_detalle.granel.
        END.

        IF Ped_detalle.cantidad_cum >= Ped_detalle.cantidad AND
           Ped_detalle.granel_cum >= Ped_detalle.granel
        THEN DO:
             Ped_detalle.cdg_estado = "CC".
        END.
        ELSE DO:
             Ped_detalle.cdg_estado = "AA".
        END.

    END.

    Rem_header.conformado     = YES.
    Rem_header.fch_conformado = p-fecha.
    Rem_header.nro_pedido     = p-nro_pedido.
    FIND FIRST Ped_detalle OF Ped_header WHERE LOOKUP(Ped_detalle.cdg_estado,"AM/AA","/") <> 0 NO-ERROR.
    IF NOT AVAILABLE Ped_detalle 
       THEN Ped_header.cdg_estado = "CC".
       ELSE Ped_header.cdg_estado = "AA".

END.
