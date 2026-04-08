
    CREATE Sub_header_vta.
    ASSIGN
           Sub_header_vta.cdg_empresa    = Rec_header.cdg_empresa
           Sub_header_vta.tip_comprob    = Rec_header.tip_comprob
           Sub_header_vta.prf_comprob    = Rec_header.prf_comprob
           Sub_header_vta.nro_comprob    = Rec_header.nro_comprob
           Sub_header_vta.fecha          = Rec_header.fecha
           Sub_header_vta.nro_cuenta     = Imputacion.nro_cuenta
           Sub_header_vta.imp_total      = Rec_header.imp_total.


    FIND FIRST Impuesto_condicion OF Condicion_impos /*
         WHERE Impuesto_condicion.cdg_empresa = Rec_header.cdg_empresa */
               NO-LOCK NO-ERROR. 
    IF AVAILABLE Impuesto_condicion
    THEN DO:

        FIND Impuesto OF Impuesto_condicion NO-LOCK.
        Rec_header.imp_neto = Rec_header.imp_total / ( 1 + Impuesto_condicion.tasa / 100.0 ).

        CREATE Sub_detalle_vta.
        ASSIGN
               Sub_detalle_vta.cdg_empresa    = Rec_header.cdg_empresa
               Sub_detalle_vta.tip_comprob    = Rec_header.tip_comprob
               Sub_detalle_vta.prf_comprob    = Rec_header.prf_comprob
               Sub_detalle_vta.nro_comprob    = Rec_header.nro_comprob
               Sub_detalle_vta.nro_cuenta     = Imputacion.nro_cuenta_neto
               Sub_detalle_vta.valor          = Rec_header.imp_neto
               Sub_detalle_vta.tipo           = 1.

        CREATE Sub_detalle_vta.
        ASSIGN 
               Sub_detalle_vta.cdg_empresa    = Rec_header.cdg_empresa
               Sub_detalle_vta.tip_comprob    = Rec_header.tip_comprob
               Sub_detalle_vta.prf_comprob    = Rec_header.prf_comprob
               Sub_detalle_vta.nro_comprob    = Rec_header.nro_comprob
               Sub_detalle_vta.nro_cuenta     = Impuesto.nro_cuenta
               Sub_detalle_vta.tipo           = 2
               Sub_detalle_vta.valor          = Rec_header.imp_total - Rec_header.imp_neto.

    END.
    ELSE DO:

        Rec_header.imp_neto = Rec_header.imp_total.

        CREATE Sub_detalle_vta.
        ASSIGN
               Sub_detalle_vta.cdg_empresa    = Rec_header.cdg_empresa
               Sub_detalle_vta.tip_comprob    = Rec_header.tip_comprob
               Sub_detalle_vta.prf_comprob    = Rec_header.prf_comprob
               Sub_detalle_vta.nro_comprob    = Rec_header.nro_comprob
               Sub_detalle_vta.nro_cuenta     = Imputacion.nro_cuenta_neto
               Sub_detalle_vta.valor          = Rec_header.imp_total
               Sub_detalle_vta.tipo           = 1.

    END.
   
    Rec_header.imp_pesos = ROUND(Rec_header.imp_total  * Rec_header.cambio, 2).
    Rec_header.imp_difcambio = 0.
    Rec_header.imp_bruto = Rec_header.imp_total.

