/*============================================================================================*/
/*      ANULA UN DETERMINADO PROCESO DE CONCILIACION BANCARIA EN EXTRACTO Y MOVIMIENTOS       */
/*============================================================================================*/

DEFINE INPUT PARAMETER p-nro_conciliacion AS INTEGER.

/*============================================================================================*/
/*                                    BLOQUE PRINCIPAL                                        */
/*============================================================================================*/

DO TRANSACTION:

    FOR EACH Cta_cte_bco WHERE Cta_cte_bco.nro_conciliacion = p-nro_conciliacion EXCLUSIVE-LOCK:
        Cta_cte_bco.nro_conciliacion = 0.
        Cta_cte_bco.conciliado = NO.
    END.    
    
    FOR EACH Extracto WHERE Extracto.nro_conciliacion = p-nro_conciliacion EXCLUSIVE-LOCK:
        Extracto.nro_conciliacion = 0.
        Extracto.conciliado = NO.
    END.    

END. /* De la transaccion */.
