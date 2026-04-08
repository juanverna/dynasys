/*=================================================================================*/
/*              HALLA EL SALDO ACTUAL DE CUENTA CORRIENTE DE UN CLIENTE            */
/*=================================================================================*/

DEFINE INPUT  PARAMETER rid_proveedor    AS ROWID.
DEFINE INPUT  PARAMETER que_moneda       LIKE Moneda.cdg_moneda.
DEFINE INPUT  PARAMETER que_fecha        AS DATE.
DEFINE OUTPUT PARAMETER saldo_cc         AS DECIMAL.
DEFINE OUTPUT PARAMETER saldo_ccv        AS DECIMAL.

/*=================================================================================*/
/*                       B L O Q U E     P R I N C I P A L                         */
/*=================================================================================*/

{VPERSINM.I}

{findempresa.i}

FIND Proveedor WHERE ROWID(Proveedor) = rid_proveedor NO-LOCK.
FIND Moneda  WHERE Moneda.cdg_moneda = que_moneda NO-LOCK.

RUN SUMAR_CTACTE.

/*=================================================================================*/
/*                              PROCEDIMIENTOS                                     */
/*=================================================================================*/

PROCEDURE SUMAR_CTACTE:

    saldo_cc = 0.
    saldo_ccv = 0.

    FOR EACH Cta_cte_prv OF Proveedor
        WHERE Cta_cte_prv.debito <> Cta_cte_prv.credito
          AND Cta_cte_prv.nro_moneda = Moneda.nro_moneda
          AND Cta_cte_prv.cdg_empresa = Empresa.cdg_empresa
           BY Cta_cte_prv.fecha_vencimiento:

         saldo_cc = saldo_cc + ( Cta_cte_prv.credito - Cta_cte_prv.debito ).
         IF Cta_cte_prv.fecha_vencimiento <= que_fecha
            THEN saldo_ccv = saldo_ccv + ( Cta_cte_prv.credito - Cta_cte_prv.debito ).

    END.

END PROCEDURE.

