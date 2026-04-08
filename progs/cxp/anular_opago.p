/*===========================================================================================*/
/*                        PRODUCE LA ANULACION DE UNA ORDEN DE PAGO                          */
/*===========================================================================================*/

DEFINE INPUT  PARAMETER rid_opago     AS ROWID.
DEFINE OUTPUT PARAMETER puede_anular  AS INTEGER.

{vrshared.i}

/*===========================================================================================*/
/*                                     BLOQUE PRINCIPAL                                     */
/*===========================================================================================*/


DO TRANSACTION:

    FIND Opg_header WHERE ROWID(Opg_header) = rid_opago EXCLUSIVE-LOCK.

    FIND Caj_header WHERE Caj_header.nro_transaccion = Opg_header.nro_transaccion.
    act_caj_head = ROWID(Caj_header).     
    RUN ANULCAJA.P ( OUTPUT puede_anular ).
    IF puede_anular <> 0 
    THEN DO:
       MESSAGE "No es posible anular por codigo de razon " STRING(puede_anular)
               VIEW-AS ALERT-BOX MESSAGE.
       RUN PONMENSJ.P (INPUT "OPAG005").
       RETURN.
    END.   

    FIND Sub_header_prv 
         WHERE Sub_header_prv.nro_comprob   = Opg_header.nro_comprob 
           AND Sub_header_prv.prf_comprob   = Opg_header.prf_comprob
           AND Sub_header_prv.tip_comprob   = Opg_header.tip_comprob
           AND Sub_header_prv.cdg_empresa   = Opg_header.cdg_empresa
           AND Sub_header_prv.nro_proveedor = Opg_header.nro_proveedor
               EXCLUSIVE-LOCK NO-ERROR.       
  
    IF AVAILABLE Sub_header_prv THEN Sub_header_prv.anulado = YES.
  
    FOR EACH  Cta_cte_prv 
        WHERE Cta_cte_prv.nro_comprob   = Opg_header.nro_comprob 
          AND Cta_cte_prv.prf_comprob   = Opg_header.prf_comprob
          AND Cta_cte_prv.tip_comprob   = Opg_header.tip_comprob
          AND Cta_cte_prv.cdg_empresa   = Opg_header.cdg_empresa
          AND Cta_cte_prv.nro_proveedor = Opg_header.nro_proveedor       
              EXCLUSIVE-LOCK:       

          act_ctacte_prv = ROWID(Cta_cte_prv).
          RUN ACUMCCPV.P (INPUT "B").
          DELETE Cta_cte_prv.

    END.      

    FOR EACH  Aplicacion_pagos_prv
        WHERE Aplicacion_pagos_prv.nro_proveedor    = Opg_header.nro_proveedor
          AND Aplicacion_pagos_prv.cdg_empresa      = Opg_header.cdg_empresa
          AND Aplicacion_pagos_prv.tip_comprob      = Opg_header.tip_comprob
          AND Aplicacion_pagos_prv.prf_comprob      = Opg_header.prf_comprob
          AND Aplicacion_pagos_prv.nro_comprob      = Opg_header.nro_comprob
              EXCLUSIVE-LOCK:

        FIND Cta_cte_prv 
            WHERE Cta_cte_prv.cdg_empresa     = Opg_header.cdg_empresa
              AND Cta_cte_prv.tip_comprob     = Aplicacion_pagos_prv.tip_cancela
              AND Cta_cte_prv.prf_comprob     = Aplicacion_pagos_prv.prf_cancela
              AND Cta_cte_prv.nro_comprob     = Aplicacion_pagos_prv.nro_cancela
              AND Cta_cte_prv.nro_vencimiento = Aplicacion_pagos_prv.nro_ven_cancela
              AND Cta_cte_prv.nro_proveedor   = Opg_header.nro_proveedor
                  EXCLUSIVE-LOCK.

        /* Modificamos los importes. Si es una OP o una NC, el Opg_detalle.importe es < 0 */
        
        FIND FIRST Tipocomprobante 
             WHERE Tipocomprobante.cdg_comprobante = Cta_cte_prv.cdg_comprobante
               AND Tipocomprobante.cdg_empresa     = Cta_cte_prv.cdg_empresa
                   NO-LOCK.

        IF Tipocomprobante.debita
        THEN DO: /* En los debitos , los importes son negativos */
             Cta_cte_prv.credito = Cta_cte_prv.credito + Aplicacion_pagos_prv.importe.
        END.
        ELSE DO:
             Cta_cte_prv.debito  = Cta_cte_prv.debito  - Aplicacion_pagos_prv.importe.
        END.
        
        RELEASE Cta_cte_prv.

        DELETE Aplicacion_pagos_prv.

    END.
  
    RUN acumular_pagos.p (INPUT ROWID(Opg_header), INPUT "B").

    Opg_header.anulado = YES.

END.



