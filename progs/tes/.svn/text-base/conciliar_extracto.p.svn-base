/*============================================================================================*/
/*      MARCA COMO CONCILIADOS UNA SERIE DE REGISTROS SELECCIONADOS POR UN USUARIO            */
/*============================================================================================*/

DEFINE VARIABLE chr_userid         AS CHARACTER.
DEFINE VARIABLE v-nro_conciliacion AS INTEGER.

/*============================================================================================*/
/*                                    BLOQUE PRINCIPAL                                        */
/*============================================================================================*/

chr_userid = USERID("sic").
v-nro_conciliacion = NEXT-VALUE(proxima_conciliacion).

DO TRANSACTION:

    FOR EACH Cta_cte_bco WHERE Cta_cte_bco.user-id-sel = "CON-" + chr_userid EXCLUSIVE-LOCK:
        Cta_cte_bco.user-id-sel = "".
        Cta_cte_bco.nro_conciliacion = v-nro_conciliacion.
        Cta_cte_bco.conciliado = YES.
    END.    
    
    FOR EACH Extracto WHERE Extracto.user-id-sel = "CON-" + chr_userid EXCLUSIVE-LOCK:
        Extracto.user-id-sel = "".
        Extracto.nro_conciliacion = v-nro_conciliacion.
        Extracto.conciliado = YES.
    END.    

END. /* De la transaccion */.
