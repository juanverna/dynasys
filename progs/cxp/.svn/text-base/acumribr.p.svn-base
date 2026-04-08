DEFINE INPUT PARAMETER ope     AS CHARACTER.

/*----------------------------------------------------------------------------------------------

  Eliminado CR: Las Ret.Ing.Brut. no requieren acumulados mensuales.
                 
{VPERSINM.I}
{VRSHARED.I}

FIND Certificado_ibr  WHERE ROWID(Certificado_ibr) = act_certibr.

FIND FIRST Acumulado_pagos
     WHERE Acumulado_pagos.nro_proveedor  = Certificado_ibr.nro_proveedor
       AND Acumulado_pagos.ano            = YEAR(Certificado_ibr.fecha_emision)
       AND Acumulado_pagos.mes            = MONTH(Certificado_ibr.fecha_emision) 
       AND Acumulado_pago.cdg_tipactiv    = Certificado_ibr.cdg_tipactiv
           EXCLUSIVE-LOCK NO-ERROR.

IF NOT AVAILABLE Acumulado_pagos
THEN DO:
   CREATE Acumulado_pagos.
   ASSIGN Acumulado_pagos.nro_proveedor  = Certificado_ibr.nro_proveedor
          Acumulado_pagos.ano            = YEAR(Certificado_ibr.fecha_emision)
          Acumulado_pagos.mes            = MONTH(Certificado_ibr.fecha_emision)
          Acumulado_pago.cdg_tipactiv    = Certificado_ibr.cdg_tipactiv.
END.

IF ope = "A"
   THEN Acumulado_pagos.total_retibrutos = Acumulado_pagos.total_retibrutos + 
                                         Certificado_ibr.imp_retenido.
   ELSE Acumulado_pagos.total_retibrutos = Acumulado_pagos.total_retibrutos - 
                                         Certificado_ibr.imp_retenido.

-----------------------------------------------------------------------------------------------*/

RETURN.

 
