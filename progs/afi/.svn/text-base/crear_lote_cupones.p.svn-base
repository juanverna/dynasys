/*====================================================================================*/
/*                 IMPRESION DE UN LOTE DE FACTURAS CONSECUTIVAS                      */
/*====================================================================================*/

DEFINE INPUT PARAMETER p-tip_comprob LIKE Fac_header.tip_comprob.
DEFINE INPUT PARAMETER p-prf_comprob LIKE Fac_header.prf_comprob.
DEFINE INPUT PARAMETER p-des_nrocomp LIKE Fac_header.nro_comprob.
DEFINE INPUT PARAMETER p-has_nrocomp LIKE Fac_header.nro_comprob.

/*====================================================================================*/
/*                                    VARIABLES                                       */
/*====================================================================================*/


/*====================================================================================*/
/*                                 BLOQUE PRINCIPAL                                   */
/*====================================================================================*/
/*
FOR EACH fac_header WHERE NOT anulado:
           RUN crear_cupon.p ( ROWID(Fac_header) ).
END.
*/
{findempresa.i}

DO TRANSACTION:

    FOR EACH Fac_header 
        WHERE Fac_header.cdg_empresa  = Empresa.cdg_empresa
          AND Fac_header.tip_comprob  = p-tip_comprob
          AND Fac_header.prf_comprob  = p-prf_comprob
          AND Fac_header.nro_comprob  <= p-has_nrocomp
          AND Fac_header.nro_comprob  >= p-des_nrocomp
              EXCLUSIVE-LOCK:
    
        RUN crear_cupon.p ( ROWID(Fac_header) ).

    END.

END.

/*====================================================================================*/
/*                            P R O C E D I M I E N T O S                             */
/*====================================================================================*/


