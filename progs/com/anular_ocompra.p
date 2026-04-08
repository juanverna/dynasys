/*=================================================================================*/
/*                         ANULA UNA ORDEN DE COMPRA                               */
/*=================================================================================*/

DEFINE INPUT  PARAMETER act_ocompra AS ROWID.
DEFINE OUTPUT PARAMETER puede_anular AS LOGICAL INITIAL NO.

{VRSHARED.I}
{VPERSINM.I}

DEFINE VARIABLE saldo_remito        AS DECIMAL.
DEFINE VARIABLE aux_nro_vencimiento AS INTEGER.
DEFINE VARIABLE j                   AS INTEGER.
DEFINE VARIABLE ncopias             AS INTEGER.

DEFINE VARIABLE que_rutina          AS CHARACTER.
DEFINE BUFFER B-Ocm_detalle         FOR Ocm_detalle.

/*=================================================================================*/
/*                     ARRANCA LA TRANSACCION DE ACTUALIZACION                     */
/*=================================================================================*/

DO ON ERROR UNDO, LEAVE: /* ARRANCAMOS AQUI LA TRANSACCION */

    FIND Ocm_header WHERE ROWID(Ocm_header) = act_ocompra EXCLUSIVE-LOCK.

    /*=================================================================================*/
    /*                                      STOCK                                      */
    /*=================================================================================*/

    FOR EACH Ocm_detalle OF Ocm_header EXCLUSIVE-LOCK:
    
        FIND Cct_stock 
                WHERE Cct_stock.cdg_empresa    = Ocm_header.cdg_empresa  
                  AND Cct_stock.tip_comprob    = Ocm_header.tip_comprob
                  AND Cct_stock.prf_comprob    = Ocm_header.prf_comprob
                  AND Cct_stock.nro_comprob    = Ocm_header.nro_comprob
                  AND Cct_stock.nro_linea      = Ocm_detalle.nro_linea
                  AND Cct_stock.nro_proveedor  = Ocm_header.nro_proveedor
                        EXCLUSIVE-LOCK NO-ERROR.
    
        IF AVAILABLE Cct_stock
        THEN DO:
            act_cctstk = ROWID(Cct_stock).
            RUN ACUMSTCK.P ("B").

            DELETE Cct_stock.
        END.
    
        Ocm_detalle.cdg_estado = "ZZ".

    END.

    ASSIGN Ocm_header.cdg_estado = "ZZ"
           puede_anular = YES.

    FOR EACH Rqs_header WHERE Rqs_header.nro_ocompra = Ocm_header.nro_ocompra EXCLUSIVE-LOCK:
        Rqs_header.cdg_estado = "IN".
    END.

END.  /* FIN DE LA TRANSACCION */



