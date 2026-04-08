    FIND FIRST T-Asn_header.

    FIND Parametro 
         WHERE Parametro.cdg_empresa = {1}
           AND Parametro.cdg_parametro = "PROXNASN"
               EXCLUSIVE-LOCK.

    ASSIGN T-Asn_header.nro_comprob     = Parametro.valor_n
           Parametro.valor_n            = Parametro.valor_n + 1
           T-Asn_header.cdg_estado      = "0"
           T-Asn_header.nro_idcabecera  = {2}.
    
    CREATE Asn_header.
    BUFFER-COPY T-Asn_header TO Asn_header
        ASSIGN Asn_header.nro_asiento   = NEXT-VALUE(proximo_asiento).

    FOR EACH T-Asn_detalle OF T-Asn_header:
        CREATE Asn_detalle.
        BUFFER-COPY T-Asn_detalle TO Asn_detalle 
                    ASSIGN Asn_detalle.nro_asiento = Asn_header.nro_asiento.
    END.

    FOR EACH T-Asn_totales OF T-Asn_header:
        CREATE Asn_totales.
        BUFFER-COPY T-Asn_totales TO Asn_totales 
                    ASSIGN Asn_totales.nro_asiento = Asn_header.nro_asiento.
    END.

    RELEASE Asn_header.
    RELEASE Asn_detalle.
    RELEASE Asn_totales.
