    DO TRANSACTION:
    
    FOR EACH fac_header_prv WHERE fac_header_prv.tip_comprob = "FH" AND
fac_header_prv.nro_comprob <= 733:
    FIND cta_cte_prv OF fac_header_prv.
    FIND Sub_detalle_prv where
                           Sub_detalle_prv.cdg_empresa    = Fac_header_prv.cdg_empresa AND
                           Sub_detalle_prv.tip_comprob    = Fac_header_prv.tip_comprob AND
                           Sub_detalle_prv.prf_comprob    = Fac_header_prv.prf_comprob AND
                           Sub_detalle_prv.nro_comprob    = Fac_header_prv.nro_comprob AND
                           Sub_detalle_prv.nro_proveedor  = Fac_header_prv.nro_proveedor.
    
    /*cta_cte_prv.nro_comprob = int64(entry(2,fac_header_prv.observacion," ")).
    Sub_detalle_prv.nro_comprob    = int64(entry(2,fac_header_prv.observacion," ")).
    fac_header_prv.nro_comprob    = int64(entry(2,fac_header_prv.observacion," ")).*/
    FIND rendicion_hd WHERE rendicion_hd.nro_rendicion = int64(entry(2,fac_header_prv.observacion," ")).
    fac_header_prv.fecha = rendicion_hd.fecha.
    END.
    END.
