  CASE ver_pagos:
    WHEN todos
    THEN DO:
        OPEN QUERY qry_certificados
             FOR EACH Certificado_ibr
                WHERE Certificado_ibr.fecha_emision <= has_fecha
                  AND Certificado_ibr.fecha_emision >= des_fecha,
                FIRST Tipo_retibr OF Certificado_ibr, FIRST Proveedor OF Certificado_ibr
                   BY Certificado_ibr.fecha_emision.
    END.
    WHEN ya_emi
    THEN DO:
        OPEN QUERY qry_certificados
             FOR EACH Certificado_ibr
                WHERE Certificado_ibr.fecha_emision <= has_fecha
                  AND Certificado_ibr.fecha_emision >= des_fecha
                  AND Certificado_ibr.emitido,
                FIRST Tipo_retibr OF Certificado_ibr, FIRST Proveedor OF Certificado_ibr
                   BY Certificado_ibr.fecha_emision.

    END.
    WHEN no_emi
    THEN DO:
        OPEN QUERY qry_certificados
             FOR EACH Certificado_ibr
                WHERE Certificado_ibr.fecha_emision <= has_fecha
                  AND Certificado_ibr.fecha_emision >= des_fecha
                  AND NOT Certificado_ibr.emitido,
                FIRST Tipo_retibr OF Certificado_ibr, FIRST Proveedor OF Certificado_ibr
                   BY Certificado_ibr.fecha_emision.

    END.
  END CASE.
