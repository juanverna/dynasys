/*=================================================================================*/
/*      HALLA EL CONSUMO TOTAL DE CREDITO Y ESTADO CREDITICIO DE UN CLIENTE        */
/*=================================================================================*/

DEFINE INPUT  PARAMETER rid_cliente    AS ROWID.
DEFINE OUTPUT PARAMETER saldo_cc       AS DECIMAL.
DEFINE OUTPUT PARAMETER saldo_ccv      AS DECIMAL.
DEFINE OUTPUT PARAMETER tot_valores    AS DECIMAL.
DEFINE OUTPUT PARAMETER tot_remitos    AS DECIMAL.
DEFINE OUTPUT PARAMETER tot_pedidos    AS DECIMAL.
DEFINE OUTPUT PARAMETER cant_rech      AS INTEGER.
DEFINE OUTPUT PARAMETER tot_credito    AS DECIMAL.

{vrshared.i "NEW"}
{VPERSINM.I}

{findempresa.i}

FIND Cliente WHERE ROWID(Cliente) = rid_cliente NO-LOCK.

RUN SUMAR_CTACTE.
RUN SUMAR_VALORES.
RUN SUMAR_REMITOS.
RUN SUMAR_PEDIDOS.

tot_credito = saldo_cc + tot_valores + tot_remitos + tot_pedidos.

/*=================================================================================*/
/*                              PROCEDIMIENTOS                                     */
/*=================================================================================*/

PROCEDURE SUMAR_CTACTE:

    saldo_cc = 0.
    saldo_ccv = 0.

    FOR EACH Moneda:
        FOR EACH Cta_cte OF Cliente
            WHERE Cta_cte.debito <> Cta_cte.credito
              AND Cta_cte.nro_moneda = Moneda.nro_moneda
              AND Cta_cte.cdg_empresa = Empresa.cdg_empresa
               BY fecha_vencimiento:

             saldo_cc = saldo_cc + ( Cta_cte.debito - Cta_cte.credito ) * Moneda.cambio.
             IF Cta_cte.fecha_vencimiento <= TODAY
                THEN saldo_ccv = saldo_ccv + ( Cta_cte.debito - Cta_cte.credito ) * Moneda.cambio.

        END.
    END.

END PROCEDURE.

PROCEDURE SUMAR_VALORES:

    tot_valores = 0.
    cant_rech = 0.

    FOR EACH Valor OF Cliente 
        WHERE Valor.estado <> stchq_acredit
          AND Valor.estado <> stchq_levanta
          AND Valor.cdg_empresa = Empresa.cdg_empresa
              NO-LOCK:
        tot_valores = tot_valores  + Valor.importe.
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
          AND Rem_header.cdg_empresa = Empresa.cdg_empresa
              NO-LOCK:
        tot_remitos = tot_remitos  + Rem_header.imp_total.
    END.

END PROCEDURE.

PROCEDURE SUMAR_PEDIDOS:

    tot_pedidos = 0.

    FOR EACH Ped_header OF Cliente 
        WHERE Ped_header.estado = "E":
        FOR EACH Ped_detalle OF Ped_header 
            WHERE LOOKUP(Ped_detalle.cdg_estado,"AA,SI,AM") <> 0
              AND Ped_header.cdg_empresa = Empresa.cdg_empresa
                  NO-LOCK:
            tot_pedidos = tot_pedidos  + Ped_detalle.subtotal_neto.
               /*
               message "subtotal:" string(Ped_detalle.subtotal_neto) skip
                       "pedido:"  string(Ped_header.nro_comprob) + "." + string(ped_detalle.nro_linea)
                       view-as alert-box title "sumstcre.p".
               */        
        END.
    END.

END PROCEDURE.
