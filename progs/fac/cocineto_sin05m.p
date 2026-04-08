DEFINE VAR a01 AS INT.
DEFINE VAR a05 AS INT.
DEFINE BUFFER admin FOR cliente.
FIND articulo WHERE cdg_articulo = "01f".
a01 = nro_articulo.
FIND articulo WHERE cdg_articulo = "05m".
a05 = nro_articulo.
DEFINE TEMP-TABLE aa
    FIELD nro like contrato_hd.nro_contrato.
OUTPUT TO "clipboard".
    FOR EACH fac_header NO-LOCK WHERE fecha >= 01/01/2016 AND nro_contrato <> 0:
        IF CAN-FIND( contrato_dt WHERE fac_header.nro_contrato = contrato_dt.nro_contrato and nro_articulo = a01) and
            NOT CAN-FIND( contrato_dt WHERE fac_header.nro_contrato = contrato_dt.nro_contrato and nro_articulo = a05) THEN 
    FIND aa WHERE aa.nro = fac_header.nro_contrato no-error.
            IF NOT AVAILABLE aa THEN do:
                CREATE aa.
                ASSIGN aa.nro = fac_header.nro_contrato.
            END.

    END.
    FOR EACH aa:
        FIND contrato_hd WHERE contrato_hd.nro_contrato = aa.nro AND contrato_hd.fecha_baja = ? AND estado = "A" AND cant_periodos = 0  NO-ERROR.
        IF NOT AVAILABLE contrato_hd THEN DELETE aa.
    END.
    FOR EACH aa:
        FIND contrato_hd WHERE contrato_hd.nro_contrato = aa.nro.
        FIND cliente WHERE cliente.nro_cliente = contrato_hd.nro_cliente.
        FIND admin WHERE admin.nro_cliente = cliente.nro_admin.
        DISPLAY aa.nro admin.nom_cliente admin.cdg_cliente.
    END.
