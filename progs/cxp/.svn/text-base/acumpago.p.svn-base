/*=================================================================================*/
/*             ACUMULACION DE PAGOS DEL PROVEEDOR PARA GANANCIAS                   */
/*=================================================================================*/

DEFINE INPUT PARAMETER ope AS CHARACTER.
DEFINE BUFFER B-Cuenta FOR Cta_cte_prv.

{VPERSINM.I}
{VRSHARED.I}

DO TRANSACTION:

    FIND Cta_cte_prv WHERE ROWID(Cta_cte_prv) = act_ctacte_prv NO-LOCK.
    FIND Proveedor OF Cta_cte_prv NO-LOCK.
    FIND Opg_header OF Proveedor
        WHERE Opg_header.cdg_empresa = Cta_cte_prv.cdg_empresa
          AND Opg_header.tip_comprob = Cta_cte_prv.tip_comprob
          AND Opg_header.prf_comprob = Cta_cte_prv.prf_comprob
          AND Opg_header.nro_comprob = Cta_cte_prv.nro_comprob 
              NO-LOCK.
    
    FIND FIRST Acumulado_pagos OF Proveedor
         WHERE Acumulado_pagos.cdg_empresa  = Cta_cte_prv.cdg_empresa
           AND Acumulado_pagos.ano          = YEAR(Opg_header.fecha)
           AND Acumulado_pagos.mes          = MONTH(Opg_header.fecha) 
           AND Acumulado_pago.cdg_tiporetgan  = Opg_header.cdg_tiporetgan
           EXCLUSIVE-LOCK NO-ERROR.
    
    IF NOT AVAILABLE Acumulado_pagos
    THEN DO:
       CREATE Acumulado_pagos.
       ASSIGN Acumulado_pagos.nro_Proveedor  = Proveedor.nro_Proveedor
              Acumulado_pagos.cdg_empresa    = Opg_header.cdg_empresa
              Acumulado_pagos.ano            = YEAR(Opg_header.fecha)
              Acumulado_pagos.mes            = MONTH(Opg_header.fecha)
              Acumulado_pago.cdg_tiporetgan    = Opg_header.cdg_tiporetgan.
    END.
    
    IF ope = "A"
      THEN Acumulado_pagos.total_pagado = Acumulado_pagos.total_pagado + 
                     Opg_header.imp_neto.
      ELSE Acumulado_pagos.total_pagado = Acumulado_pagos.total_pagado - 
                     Opg_header.imp_neto.

END. 

/*  SOLO DIOS SABE A QUIEN SE LE OCURRIO ESTA BURRADA !!!!!!!!!!!!! -----------------------

FOR EACH Opg_detalle OF Opg_header WHERE tip_cancela <> "OP" NO-LOCK:


    FIND FIRST Cta_cte_prv OF Proveedor
         WHERE Cta_cte_prv.tip_comprob = Opg_detalle.tip_cancela
           AND Cta_cte_prv.prf_comprob = Opg_detalle.prf_cancela
           AND Cta_cte_prv.nro_comprob = Opg_detalle.nro_cancela.

    FIND FIRST Acumulado_pagos OF Proveedor
         WHERE Acumulado_pagos.ano          = YEAR(Cta_cte_prv.fecha_emision)
           AND Acumulado_pagos.mes          = MONTH(Cta_cte_prv.fecha_emision) 
           AND Acumulado_pago.cdg_tiporetgan  = Cta_cte_prv.cdg_tiporetgan
           EXCLUSIVE-LOCK NO-ERROR.

    IF NOT AVAILABLE Acumulado_pagos
    THEN DO:
       CREATE Acumulado_pagos.
       ASSIGN Acumulado_pagos.nro_Proveedor  = Proveedor.nro_Proveedor
              Acumulado_pagos.ano            = YEAR(Cta_cte_prv.fecha_emision)
              Acumulado_pagos.mes            = MONTH(Cta_cte_prv.fecha_emision)
              Acumulado_pago.cdg_tiporetgan    = Cta_cte_prv.cdg_tiporetgan.
    END.

   IF ope = "A"
      THEN Acumulado_pagos.total_pagado = Acumulado_pagos.total_pagado + 
                     (Opg_detalle.importe - Opg_detalle.descuento )* Opg_header.cambio.
      ELSE Acumulado_pagos.total_pagado = Acumulado_pagos.total_pagado - 
                     (Opg_detalle.importe - Opg_detalle.descuento )* Opg_header.cambio.

END. /* Del FOR EACH de detalle de la Opg */

---------------------------------------------------------------------------------------*/

RETURN.

 
