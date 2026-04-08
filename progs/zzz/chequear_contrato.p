        DEFINE BUFFER administrador FOR cliente.
        FOR EACH Contrato_hd 
        WHERE ( Contrato_hd.rige_desde <= 1/1/2007  AND contrato_hd.estado = "A"
          AND Contrato_hd.rige_hasta >= 1/31/2007 )
          AND ( Contrato_hd.primer_ano * 100 + Contrato_hd.primer_mes <= 2007 * 100 + 01 )
          AND ( Contrato_hd.resto_periodos > 0  or Contrato_hd.cant_periodos = 0 ) 
          AND Contrato_hd.prf_contrato <= 13 
          AND Contrato_hd.prf_contrato >= 1
          NO-LOCK:
            
          /* FIRST estado OF contrato_hd WHERE estado.activo = TRUE ,*/
            FIND FIRST Cliente OF Contrato_hd NO-LOCK .
            FIND FIRST administrador WHERE administrador.nro_cliente = cliente.nro_administrador NO-LOCK.
            /*DISPLAY contrato_hd.nro_contrato.*/
    END.
