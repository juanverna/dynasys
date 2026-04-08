/*====================================================================================*/
/*        LEVANTA LA CUENTA CORRIENTE DE PROVEEDORES EN UNA TABLA TEMPORAL.           */
/*====================================================================================*/

    DEFINE TEMP-TABLE T-Cta_cte_prv NO-UNDO LIKE Cta_cte_prv.

/*====================================================================================*/
/*                                    PARAMETROS                                      */
/*====================================================================================*/

    DEFINE INPUT PARAMETER p-que_empresa LIKE Empresa.cdg_empresa.
    DEFINE INPUT PARAMETER p-que_moneda  LIKE Moneda.nro_moneda.
    DEFINE INPUT PARAMETER p-des_fecha   AS DATE.
    DEFINE INPUT PARAMETER p-has_fecha   AS DATE.
    DEFINE OUTPUT PARAMETER TABLE FOR T-Cta_cte_prv.    
    
/*====================================================================================*/
/*                                    PROCESO                                         */
/*====================================================================================*/

    FOR EACH Cta_cte_prv
        WHERE Cta_cte_prv.cdg_empresa = p-que_empresa
          AND Cta_cte_prv.nro_moneda = p-que_moneda
          AND Cta_cte_prv.debito < Cta_cte_prv.credito
          AND Cta_cte_prv.fecha_vencimiento <= p-has_fecha
          AND Cta_cte_prv.fecha_vencimiento >= p-des_fecha:

        CREATE T-Cta_cte_prv.
        BUFFER-COPY Cta_cte_prv TO T-Cta_cte_prv.

    END.
