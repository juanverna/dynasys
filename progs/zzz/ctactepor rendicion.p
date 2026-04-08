        DEFINE BUFFER rr FOR comprobante_rendicion.
        DEFINE BUFFER tt FOR rendicion_hd.
        FOR EACH rendicion_hd WHERE nro_rendicion = 9758:
        FOR EACH comprobante_rendicion OF rendicion_hd:
                 FIND fac_header WHERE 
                    fac_header.cdg_empresa = comprobante_rendicion.cdg_empresa AND
                    fac_header.tip_comprob = comprobante_rendicion.tip_comprob AND
                    fac_header.prf_comprob = comprobante_rendicion.prf_comprob AND
                    fac_header.nro_comprob = comprobante_rendicion.nro_comprob NO-LOCK.
                 FOR EACH cta_cte WHERE 
                    fac_header.cdg_empresa = cta_cte.cdg_empresa AND
                    fac_header.tip_comprob = cta_cte.tip_comprob AND
                    fac_header.prf_comprob = cta_cte.prf_comprob AND
                    fac_header.nro_comprob = cta_cte.nro_comprob :
                         DISPLAY st_tesoreria nro_comprob Cta_cte.credito Cta_cte.debito.

                    END.

        END.
        END.
        /*FIND rr WHERE comprobante_rendicion.nro_rendicion = rr.nro_rendicion AND 
            rr.cdg_empresa = comprobante_rendicion.cdg_empresa AND
                    rr.tip_comprob = comprobante_rendicion.tip_comprob AND
                    rr.prf_comprob = comprobante_rendicion.prf_comprob AND
                    rr.nro_comprob = comprobante_rendicion.nro_comprob NO-LOCK NO-ERROR.
        DISPLAY rr.nro_rendicion.
        IF AVAILABLE rr THEN DO:
            FIND tt OF rr.
            DISPLAY rr.nro_rendicion tt.st_tesoreria.
        END.
        END. */
