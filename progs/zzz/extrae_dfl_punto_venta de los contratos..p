FOR EACH Contrato_hd 
        WHERE Contrato_hd.fecha_baja = ?  AND Contrato_hd.rige_hasta > TODAY AND
     ( contrato_hd.cant_periodos  = contrato_hd.resto_periodos OR
       contrato_hd.resto_periodos > 0 ) NO-LOCK
        BY Contrato_hd.cdg_empresa
         BY Contrato_hd.ultimo_ano DESCENDING
          BY Contrato_hd.ultimo_mes DESCENDING
           BY Contrato_hd.tip_contrato
            BY Contrato_hd.prf_contrato
             BY Contrato_hd.num_contrato DESCENDING:
    FIND cliente OF contrato_hd.
    IF Cliente.dfl_cdg_puntovta = 0  THEN
    Cliente.dfl_cdg_puntovta = contrato_hd.prf.
END.
