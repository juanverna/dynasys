  CASE ver_pagos:

    WHEN todos
    THEN DO:
        OPEN QUERY qry_certificados
             FOR EACH Certificado_gan
                WHERE Certificado_gan.cdg_empresa  = Empresa.cdg_empresa
                  AND NOT Certificado_gan.anulado
                  AND Certificado_gan.fecha_emision <= has_fecha
                  AND Certificado_gan.fecha_emision >= des_fecha,
                FIRST Tipo_actividad OF Certificado_gan, FIRST Proveedor OF Certificado_gan
                   BY Certificado_gan.fecha_emision.
    END.
    WHEN ya_emi
    THEN DO:
        OPEN QUERY qry_certificados
             FOR EACH Certificado_gan
                WHERE NOT Certificado_gan.anulado
                  AND Certificado_gan.cdg_empresa  = Empresa.cdg_empresa
                  AND NOT Certificado_gan.anulado
                  AND Certificado_gan.fecha_emision <= has_fecha
                  AND Certificado_gan.fecha_emision >= des_fecha
                  AND Certificado_gan.emitido,
                FIRST Tipo_actividad OF Certificado_gan, FIRST Proveedor OF Certificado_gan
                   BY Certificado_gan.fecha_emision.

    END.
    WHEN no_emi
    THEN DO:
        OPEN QUERY qry_certificados
             FOR EACH Certificado_gan
                WHERE NOT Certificado_gan.anulado
                  AND Certificado_gan.cdg_empresa  = Empresa.cdg_empresa
                  AND NOT Certificado_gan.anulado
                  AND Certificado_gan.fecha_emision <= has_fecha
                  AND Certificado_gan.fecha_emision >= des_fecha
                  AND NOT Certificado_gan.emitido,
                FIRST Tipo_actividad OF Certificado_gan, FIRST Proveedor OF Certificado_gan
                   BY Certificado_gan.fecha_emision.

    END.
    WHEN nulos
    THEN DO:
        OPEN QUERY qry_certificados
             FOR EACH Certificado_gan
                WHERE Certificado_gan.cdg_empresa  = Empresa.cdg_empresa
                  AND Certificado_gan.anulado
                  AND Certificado_gan.fecha_emision <= has_fecha
                  AND Certificado_gan.fecha_emision >= des_fecha,
                FIRST Tipo_actividad OF Certificado_gan, FIRST Proveedor OF Certificado_gan
                   BY Certificado_gan.fecha_emision.
    END.

  END CASE.
