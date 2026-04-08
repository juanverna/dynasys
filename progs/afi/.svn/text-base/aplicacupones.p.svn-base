for each rendicion_hd where abierta and tipo = "1" exclusive-lock:
/*
FOR EACH Cupon OF Rendicion_hd:

    FIND FIRST Cta_cte WHERE Cta_cte.cdg_empresa = Cupon.cdg_empresa
                         AND Cta_cte.tip_comprob = "R" + SUBSTRING(Cupon.tip_comprob,2,1) 
                         AND Cta_cte.prf_comprob = Cupon.prf_comprob
                         AND Cta_cte.nro_comprob = Cupon.nro_comprob
                         AND Cta_cte.nro_vencimiento = 1
                             NO-ERROR.
    IF NOT AVAILABLE Cta_cte
    THEN DO: /*
         FIND Cobrador OF Cupon NO-LOCK.
         FIND Grupofam OF Cupon NO-LOCK.
         FIND Cliente OF Grupofam NO-LOCK.
         CREATE Cta_cte.
         ASSIGN Cta_cte.cdg_empresa     = Cupon.cdg_empresa
                Cta_cte.tip_comprob     = "R" + SUBSTRING(Cupon.tip_comprob,2,1) 
                Cta_cte.prf_comprob     = Cupon.prf_comprob
                Cta_cte.nro_comprob     = Cupon.nro_comprob
                Cta_cte.nro_vencimiento = 1
                Cta_cte.ano             = Cupon.ano
                Cta_cte.cambio          = 1
                Cta_cte.cdg_imputacion  = 4
                Cta_cte.credito         = Cupon.importe_cuota
                Cta_cte.debito          = 0
                Cta_cte.fecha_emision   = Rendicion_hd.fch_rendicion 
                Cta_cte.fecha_vencimiento = Cta_cte.fecha_emision
                Cta_cte.imp_total       = Cta_cte.credito
                Cta_cte.leyenda         = ""
                Cta_cte.mes             = Cupon.mes 
                Cta_cte.nro_cliente     = Cliente.nro_cliente
                Cta_cte.nro_cobrador    = Cobrador.nro_cobrador
                Cta_cte.nro_moneda      = 1.
*/
    END.
    else message "hay" view-as alert-box.  
END.    
*/
abierta = NO.
END.
