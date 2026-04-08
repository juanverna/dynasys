    DEFINE BUFFER brendicion_hd FOR rendicion_hd.
    DEFINE BUFFER bcomprobante_rendicion FOR comprobante_rendicion.
    SESSION:IMMEDIATE-DISPLAY = TRUE.
    FOR EACH rendicion_hd NO-LOCK WHERE Rendicion_hd.fch_rendicion > 03/30/2014
    AND rendicion_hd.st_ <> "A" :
        /*detecta mezclas de administrador*/
        FOR EACH comprobante_rendicion OF rendicion_hd NO-LOCK :
            FIND fac_header OF comprobante_rendicion NO-LOCK.
            IF fac_header.nro_admin <> rendicion_hd.nro_admin THEN DO:
                DISPLAY Rendicion_hd.fch_rendicion.
                DISPLAY comprobante_rendicion.
                FIND cliente WHERE cliente.nro_cliente = fac_header.nro_admin NO-LOCK.
                DISPLAY "Cliente Mezclado" rendicion_hd.nro_rendicion cdg_cliente.
                PAUSE.
            END.
            FOR EACH bcomprobante_rendicion WHERE
                bcomprobante_rendicion.nro_rendicion <> comprobante_rendicion.nro_rendicion AND   
                bcomprobante_rendicion.nro_comprob   = comprobante_rendicion.nro_comprob AND   
                bcomprobante_rendicion.prf_comprob   = comprobante_rendicion.prf_comprob AND   
                bcomprobante_rendicion.tip_comprob   = comprobante_rendicion.tip_comprob AND   
                bcomprobante_rendicion.este_pago     = comprobante_rendicion.este_pago AND      
                bcomprobante_rendicion.cdg_empresa   = comprobante_rendicion.cdg_empresa AND  
                rowid(bcomprobante_rendicion) <> ROWID(comprobante_rendicion):
                FIND brendicion_hd WHERE brendicion_hd.nro_rendicion = bcomprobante_rendicion.nro_rendicion AND 
                     brendicion_hd.st_ <> "A" AND brendicion_hd.fecha >= rendicion_hd.fecha NO-LOCK NO-ERROR.
                IF NOT AVAILABLE brendicion_hd  THEN NEXT.
                
                DISPLAY "Dupl" comprobante_rendicion.nro_rendicion bcomprobante_rendicion.nro_rendicion.
    END.
        END.
        /*cobranzas dublicadas*/
        IF Rendicion_hd.nro_cobSVR <> 0 THEN DO:
            FOR EACH brendicion_hd NO-LOCK WHERE bRendicion_hd.fch_rendicion > 06/14/2013 AND 
                brendicion_hd.st_ <> "A" AND 
                Rendicion_hd.nro_cobSVR = bRendicion_hd.nro_cobSVR AND
                ROWID(rendicion_hd) <> ROWID(brendicion_hd):
                DISPLAY rendicion_hd.nro_rendicion brendicion_hd.nro_rendicion.
            END.
        END.

    END.

