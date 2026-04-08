/*=========================================================================================*/
/*                    PRODUCE LA ANULACION DE UN REMITO A CLIENTES                         */
/*=========================================================================================*/

DEFINE INPUT PARAMETER rid_remito    AS ROWID.
/* DEFINE OUTPUT PARAMETER puede_anular AS LOGICAL INITIAL NO.  */
DEFINE OUTPUT PARAMETER pudo_anular AS INTEGER INITIAL 1.


/*=========================================================================================*/
/*                                     VARIABLES                                           */
/*=========================================================================================*/

{VRSHARED.I}
{VPERSINM.I}

/*=========================================================================================*/
/*                                  BLOQUE PRINCIPAL                                       */
/*=========================================================================================*/

FIND Rem_header WHERE ROWID(Rem_header) = rid_remito EXCLUSIVE-LOCK.
FIND evento WHERE evento.nro_identificacion = rem_header.nro_remito AND
evento.origen = rem_header.cdg_comprobante NO-LOCK NO-ERROR.
IF AVAILABLE evento THEN DO:
    IF evento.frealizado <> ? AND NOT evento.anulado THEN DO:
        RETURN.
    END.
END.

FIND Tipocomprobante OF Rem_header NO-LOCK.
IF Rem_header.nro_solicitud <> 0 
THEN DO:
    FIND Sre_header 
        WHERE Sre_header.nro_solicitud = Rem_header.nro_solicitud 
          AND Sre_header.cdg_estado = "RE" 
              EXCLUSIVE-LOCK NO-ERROR.
    IF AVAILABLE Sre_header 
    THEN DO:
         Sre_header.cdg_estado = "AA".
         Sre_header.estado = "E".
      

         FOR EACH Sre_detalle OF Sre_header EXCLUSIVE-LOCK:
              Sre_detalle.cdg_estado = "AA".
         END.
   
         FOR EACH Regreso_solicitud OF Sre_header EXCLUSIVE-LOCK:
             DELETE Regreso_solicitud.
         END.
         pudo_anular = 0.
         Rem_header.anulado = YES.
         IF AVAILABLE evento THEN DO:
            FIND CURRENT evento EXCLUSIVE-LOCK.
            evento.anulado = TRUE.
            FOR EACH recurso_agenda WHERE recurso_agenda.nro_evento = evento.nro_evento:
                DELETE recurso_agenda.
            END.
            RELEASE evento.
         END.
    END.

END.
ELSE DO:
    FIND Ped_header WHERE Ped_header.nro_pedido = Rem_header.nro_pedido EXCLUSIVE-LOCK NO-ERROR.
    IF AVAILABLE Ped_header
    THEN DO:
        FOR EACH Rem_detalle OF Rem_header:
                   
            FOR EACH Remito-pedido
                WHERE Remito-pedido.nro_remito    = Rem_detalle.nro_remito
                  AND Remito-pedido.nro_linea-rem = Rem_detalle.nro_linea
                      EXCLUSIVE-LOCK:

                FIND Ped_detalle 
                    WHERE Ped_detalle.nro_pedido = Remito-pedido.nro_pedido   
                      AND Ped_detalle.nro_linea  = Remito-pedido.nro_linea-ped
                          EXCLUSIVE-LOCK. 

                IF Tipocomprobante.debita
                    THEN ASSIGN Ped_detalle.cantidad_cum    = Ped_detalle.cantidad_cum - Remito-pedido.cantidad 
                                Ped_detalle.granel_cum      = Ped_detalle.granel_cum   - Remito-pedido.granel.   
                    ELSE ASSIGN Ped_detalle.cantidad_cum    = Ped_detalle.cantidad_cum + Remito-pedido.cantidad 
                                Ped_detalle.granel_cum      = Ped_detalle.granel_cum   + Remito-pedido.granel.   
                   
                IF Ped_detalle.cantidad_cum >= Ped_detalle.cantidad AND
                   Ped_detalle.granel_cum >= Ped_detalle.granel
                THEN DO:
                     Ped_detalle.cdg_estado = "CC".
                END.
                ELSE DO:
                     Ped_detalle.cdg_estado = "AA".
                END.

            END.

        END.

    END.

    pudo_anular = 0.
    Rem_header.anulado = YES.
    IF AVAILABLE evento THEN DO:
        FIND CURRENT evento EXCLUSIVE-LOCK.
        evento.anulado = TRUE.
        FOR EACH recurso_agenda WHERE recurso_agenda.nro_evento = evento.nro_evento:
          DELETE recurso_agenda.
        END.
        RELEASE evento.
    END.
END.




    

