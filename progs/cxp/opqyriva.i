  CASE ver_pagos:
    WHEN todos
    THEN DO:
        OPEN QUERY qry_certificados
             FOR EACH Certificado_iva
                WHERE Certificado_iva.fecha_emision <= has_fecha
                  AND Certificado_iva.fecha_emision >= des_fecha,
                FIRST Tipo_retiva OF Certificado_iva, FIRST Proveedor OF Certificado_iva
                   BY Certificado_iva.fecha_emision.
    END.
    WHEN ya_emi
    THEN DO:
        OPEN QUERY qry_certificados
             FOR EACH Certificado_iva
                WHERE Certificado_iva.fecha_emision <= has_fecha
                  AND Certificado_iva.fecha_emision >= des_fecha
                  AND Certificado_iva.emitido,
                FIRST Tipo_retiva OF Certificado_iva, FIRST Proveedor OF Certificado_iva
                   BY Certificado_iva.fecha_emision.

    END.
    WHEN no_emi
    THEN DO:
        OPEN QUERY qry_certificados
             FOR EACH Certificado_iva
                WHERE Certificado_iva.fecha_emision <= has_fecha
                  AND Certificado_iva.fecha_emision >= des_fecha
                  AND NOT Certificado_iva.emitido,
                FIRST Tipo_retiva OF Certificado_iva, FIRST Proveedor OF Certificado_iva
                   BY Certificado_iva.fecha_emision.

    END.
  END CASE.
