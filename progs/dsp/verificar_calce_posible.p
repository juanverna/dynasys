/*=================================================================================*/
/*                 VERIFICA QUE EL CALCE DE PEDIDO Y REMITO SEA FACTIBLE           */
/*=================================================================================*/

DEFINE INPUT  PARAMETER p-nro_pedido LIKE Ped_header.nro_pedido.
DEFINE INPUT  PARAMETER p-nro_remito LIKE Rem_header.nro_remito.
DEFINE INPUT  PARAMETER p-fecha      LIKE Rem_header.fecha.
DEFINE OUTPUT PARAMETER p-rc         AS INTEGER.

DEFINE VARIABLE es_proceso_externo      AS LOGICAL.
DEFINE VARIABLE lista_estados_validos   AS CHARACTER.

/*=================================================================================*/
/*                                    PROCESO                                      */
/*=================================================================================*/

{findempresa.i}

RUN verificar_llamada.p (  INPUT "sincronizar_remito.p",
                           OUTPUT es_proceso_externo).

FIND Ped_header WHERE Ped_header.nro_pedido = p-nro_pedido NO-LOCK NO-ERROR.
IF NOT AVAILABLE Ped_header
THEN DO:
     p-rc = 1.
     RETURN.
END.

FIND Rem_header WHERE Rem_header.nro_remito = p-nro_remito  NO-LOCK NO-ERROR.
IF NOT AVAILABLE Rem_header
THEN DO:
     p-rc = 2.
     RETURN.
END.
ELSE DO:
     IF Rem_header.fecha > p-fecha 
     THEN DO:
         p-rc = 3.
         RETURN. 
     END.
END.

FIND Tipocomprobante OF Rem_header NO-LOCK.

p-rc = 0.
FOR EACH Rem_detalle OF Rem_header WHILE p-rc = 0:
    
    FIND FIRST Ped_detalle OF Ped_header
         WHERE Ped_detalle.nro_articulo = Rem_detalle.nro_articulo 
               NO-LOCK NO-ERROR.
    IF NOT AVAILABLE Ped_detalle 
    THEN DO:
         p-rc = 4.
    END.
    ELSE DO:

        /* Original, CAMBIADO 10/05/05 
        
        IF Tipocomprobante.debita
            THEN lista_estados_validos = "AA".    /* Es un Remito      */
            ELSE lista_estados_validos = "AA/CC". /* Es una devolución */
            
         */

        CASE Tipocomprobante.cdg_comprobante:
            WHEN "REMITCLI" THEN lista_estados_validos = "AA".
            WHEN "AJUSTCLI" THEN lista_estados_validos = "AA/CC".
            WHEN "NDEVOCLI" THEN lista_estados_validos = "AA/CC".
        END CASE.

        FIND FIRST Ped_detalle OF Ped_header
             WHERE Ped_detalle.nro_articulo = Rem_detalle.nro_articulo 
               AND LOOKUP(Ped_detalle.cdg_estado,lista_estados_validos,"/") <> 0
                   NO-LOCK NO-ERROR.
        IF NOT AVAILABLE Ped_detalle
        THEN DO:
            p-rc = 5.
        END.

    END.

END.

