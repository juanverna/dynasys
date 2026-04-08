DEFINE INPUT PARAMETER ope     AS CHARACTER.

/*----------------------------------------------------------------------------------------------

  Eliminado CR: Las Ret.IVA no requieren acumulados mensuales.


{VPERSINM.I}
{VRSHARED.I}

FIND Certificado_iva  WHERE ROWID(Certificado_iva) = act_certiva.

FIND FIRST Acumulado_pagos
     WHERE Acumulado_pagos.nro_proveedor  = Certificado_iva.nro_proveedor
       AND Acumulado_pagos.ano            = YEAR(Certificado_iva.fecha_emision)
       AND Acumulado_pagos.mes            = MONTH(Certificado_iva.fecha_emision) 
       AND Acumulado_pago.cdg_tipactiv    = Certificado_iva.cdg_tipactiv
           EXCLUSIVE-LOCK NO-ERROR.

IF NOT AVAILABLE Acumulado_pagos
THEN DO:
   CREATE Acumulado_pagos.
   ASSIGN Acumulado_pagos.nro_proveedor  = Certificado_iva.nro_proveedor
          Acumulado_pagos.ano            = YEAR(Certificado_iva.fecha_emision)
          Acumulado_pagos.mes            = MONTH(Certificado_iva.fecha_emision)
          Acumulado_pago.cdg_tipactiv    = Certificado_iva.cdg_tipactiv.
END.

IF ope = "A"
   THEN Acumulado_pagos.total_retiva = Acumulado_pagos.total_retiva + 
                                         Certificado_iva.imp_retenido.
   ELSE Acumulado_pagos.total_retiva = Acumulado_pagos.total_retiva - 
                                         Certificado_iva.imp_retenido.

-------------------------------------------------------------------------------------------------*/

RETURN.

 
