/*===========================================================================================*/
/*                  PRODUCE LA ANULACION DE UNA NOTA DE DEBITO CORRIENTE                     */
/*===========================================================================================*/

DEFINE INPUT  PARAMETER rid_recibo     AS ROWID.
DEFINE OUTPUT PARAMETER puede_anular   AS INTEGER.

{vrshared.i}

/*===========================================================================================*/
/*                                     BLOQUE PRINCIPAL                                     */
/*===========================================================================================*/
      
DO TRANSACTION:

                  /* ---------------------------------------------- */
                  /*  Trae el registro de encabezado de comprobante */
                  /* ---------------------------------------------- */

    FIND Rec_header WHERE ROWID(Rec_header) = rid_recibo EXCLUSIVE-LOCK.

                  /* ---------------------------------------------- */
                  /*  Anula transaccion de caja                     */
                  /* ---------------------------------------------- */

    IF Rec_header.nro_transaccion <> 0
    THEN DO:
        FIND Caj_header 
             WHERE Caj_header.nro_transaccion = Rec_header.nro_transaccion. 
        act_caj_head = ROWID(Caj_header).     
        RUN ANULCAJA.P ( OUTPUT puede_anular ).
        IF puede_anular <> 0
        THEN DO:
             RUN PONMENSJ.P (INPUT "DBCR015").
             RETURN.
        END.   
    END.

                  /* ---------------------------------------------- */
                  /*  Desaplica los importes del detalle           */
                  /* ---------------------------------------------- */
    
    /* 02/07/05 CR Ahora los importes se desaplican desde Aplicacion_pagos
    FOR EACH Rec_detalle OF Rec_header:
        
            FIND Cta_cte WHERE Cta_cte.cdg_empresa = Rec_header.cdg_empresa
                           AND Cta_cte.tip_comprob = Rec_detalle.tip_cancela
                           AND Cta_cte.prf_comprob = Rec_detalle.prf_cancela
                           AND Cta_cte.nro_comprob = Rec_detalle.nro_cancela
                           AND Cta_cte.nro_vencimiento = Rec_detalle.nro_vencimiento
                           EXCLUSIVE-LOCK.
                         
            IF CAN-DO(str_debitan,Cta_cte.tip_comprob)
               THEN Cta_cte.credito = Cta_cte.credito - Rec_detalle.importe.
               ELSE Cta_cte.debito  = Cta_cte.debito  + Rec_detalle.importe.
      
    END.
    */

    FOR EACH  Aplicacion_pagos
        WHERE Aplicacion_pagos.cdg_empresa      = Rec_header.cdg_empresa
          AND Aplicacion_pagos.tip_comprob      = Rec_header.tip_comprob
          AND Aplicacion_pagos.prf_comprob      = Rec_header.prf_comprob
          AND Aplicacion_pagos.nro_comprob      = Rec_header.nro_comprob
              EXCLUSIVE-LOCK:

        FIND Cta_cte 
            WHERE Cta_cte.cdg_empresa     = Rec_header.cdg_empresa
              AND Cta_cte.tip_comprob     = Aplicacion_pagos.tip_cancela
              AND Cta_cte.prf_comprob     = Aplicacion_pagos.prf_cancela
              AND Cta_cte.nro_comprob     = Aplicacion_pagos.nro_cancela
              AND Cta_cte.nro_vencimiento = Aplicacion_pagos.nro_ven_cancela
                  EXCLUSIVE-LOCK.

        /* Modificamos los importes. Si es un RC o una NC, el Aplicacion_pagos.importe es < 0 */
        
        IF CAN-DO(str_debitan,Cta_cte.tip_comprob)
        THEN DO:
            Cta_cte.credito = Cta_cte.credito - Aplicacion_pagos.importe.
        END.
        ELSE DO:
            Cta_cte.debito = Cta_cte.debito + Aplicacion_pagos.importe. /* Aplicacion_pagos.importe es < 0 */
        END.
        
        RELEASE Cta_cte.

        DELETE Aplicacion_pagos.

    END.
  
                  /* ---------------------------------------------- */
                  /*  Anula el registro de subdiario                */
                  /* ---------------------------------------------- */
  
    FIND Sub_header_vta 
         WHERE Sub_header_vta.cdg_empresa = Rec_header.cdg_empresa
           AND Sub_header_vta.tip_comprob = Rec_header.tip_comprob
           AND Sub_header_vta.prf_comprob = Rec_header.prf_comprob 
           AND Sub_header_vta.nro_comprob = Rec_header.nro_comprob NO-ERROR.
  
    IF AVAILABLE Sub_header_vta THEN Sub_header_vta.anulado = YES.

                  /* ---------------------------------------------- */
                  /*  Elimina el comprobante de la cuenta corriente */
                  /* ---------------------------------------------- */

    FOR EACH Cta_cte WHERE Cta_cte.cdg_empresa     = Rec_header.cdg_empresa
                       AND Cta_cte.tip_comprob     = Rec_header.tip_comprob
                       AND Cta_cte.prf_comprob     = Rec_header.prf_comprob
                       AND Cta_cte.nro_comprob     = Rec_header.nro_comprob
                           EXCLUSIVE-LOCK:
                   
        DELETE Cta_cte.               
    
    END.    

                  /* ---------------------------------------------- */
                  /*  Marca el comprobante como anulado             */
                  /* ---------------------------------------------- */
  
    Rec_header.anulado = YES.

END.
