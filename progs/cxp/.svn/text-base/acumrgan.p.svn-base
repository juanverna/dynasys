/*=================================================================================*/
/*                            ACUMULA LOS PAGOS DE GANACIAS                        */
/*=================================================================================*/

DEFINE INPUT PARAMETER ope     AS CHARACTER.

{VPERSINM.I}
{VRSHARED.I}

{findempresa.i}

FIND Certificado_gan  WHERE ROWID(Certificado_gan) = act_certgan.

FIND FIRST Acumulado_pagos
     WHERE Acumulado_pagos.cdg_empresa    = Empresa.cdg_empresa
       AND Acumulado_pagos.nro_proveedor  = Certificado_gan.nro_proveedor
       AND Acumulado_pagos.ano            = YEAR(Certificado_gan.fecha_emision)
       AND Acumulado_pagos.mes            = MONTH(Certificado_gan.fecha_emision) 
       AND Acumulado_pago.cdg_tiporetgan  = Certificado_gan.cdg_tiporetgan
           EXCLUSIVE-LOCK NO-ERROR.

IF NOT AVAILABLE Acumulado_pagos
THEN DO:
   CREATE Acumulado_pagos.
   ASSIGN Acumulado_pagos.cdg_empresa    = Empresa.cdg_empresa
          Acumulado_pagos.nro_proveedor  = Certificado_gan.nro_proveedor
          Acumulado_pagos.ano            = YEAR(Certificado_gan.fecha_emision)
          Acumulado_pagos.mes            = MONTH(Certificado_gan.fecha_emision)
          Acumulado_pago.cdg_tiporetgan  = Certificado_gan.cdg_tiporetgan.
END.

IF ope = "A"
THEN DO:
    Acumulado_pagos.total_retganan = Acumulado_pagos.total_retganan + 
                                         Certificado_gan.imp_retenido.
END.                                         
ELSE DO:
    Acumulado_pagos.total_retganan = Acumulado_pagos.total_retganan - 
                                         Certificado_gan.imp_retenido.
END.

RETURN.

 
