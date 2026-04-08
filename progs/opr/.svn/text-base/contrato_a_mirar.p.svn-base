      OUTPUT TO c:\contrato_a_mirar.txt.
      FOR EACH contrato_hd WHERE contrato_hd.rige_hasta >= 01/01/2008 AND contrato_hd.estado = "A" AND
      contrato_hd.rige_desde <= 01/01/2009 AND
      ( contrato_hd.cant_periodos <> 0 AND resto_periodos > 0 ) AND
      not Contrato_hd.anulado and  contrato_hd.fecha_baja = ? AND
      contrato_hd.rige_hasta < TODAY
      ,FIRST cliente OF contrato_hd:
      
      DISPLAY contrato_hd.nro_contrato contrato_hd.cant_periodos resto_periodos.
