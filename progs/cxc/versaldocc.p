/*=================================================================================*/
/*              HALLA EL SALDO ACTUAL DE CUENTA CORRIENTE DE UN CLIENTE            */
/*=================================================================================*/

DEFINE INPUT  PARAMETER rid_cliente    AS ROWID.
DEFINE INPUT  PARAMETER que_moneda     LIKE Moneda.cdg_moneda.
DEFINE INPUT  PARAMETER que_fecha      AS DATE.
DEFINE OUTPUT PARAMETER saldo_cc       AS DECIMAL.
DEFINE OUTPUT PARAMETER saldo_ccv      AS DECIMAL.

{VPERSINM.I}

{findempresa.i}

FIND Cliente WHERE ROWID(Cliente) = rid_cliente NO-LOCK.
FIND Moneda  WHERE Moneda.cdg_moneda = que_moneda NO-LOCK.

RUN SUMAR_CTACTE.

/*=================================================================================*/
/*                              PROCEDIMIENTOS                                     */
/*=================================================================================*/

PROCEDURE SUMAR_CTACTE:

    saldo_cc = 0.
    saldo_ccv = 0.

    FOR EACH Cta_cte OF Cliente
        WHERE Cta_cte.debito <> Cta_cte.credito
          AND Cta_cte.nro_moneda = Moneda.nro_moneda
          AND Cta_cte.cdg_empresa = Empresa.cdg_empresa
           BY Cta_cte.fecha_vencimiento:

         saldo_cc = saldo_cc + ( Cta_cte.debito - Cta_cte.credito ).
         IF Cta_cte.fecha_vencimiento <= que_fecha
            THEN saldo_ccv = saldo_ccv + ( Cta_cte.debito - Cta_cte.credito ).

    END.

END PROCEDURE.

