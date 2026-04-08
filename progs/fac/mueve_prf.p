DEFINE VAR a AS INT NO-UNDO INITIAL 3.
DEFINE VAR b AS INT NO-UNDO .
b = a + 1000.
FOR EACH fac_header WHERE fac_header.prf_comprob = a:
     fac_header.prf_comprob = b.
END.
FOR EACH rem_header WHERE rem_header.prf_comprob = a:
     rem_header.prf_comprob = b.
END.
FOR EACH rec_header WHERE rec_header.prf_comprob = a:
     rec_header.prf_comprob = b.
END.
FOR EACH Cct_stock WHERE Cct_stock.prf_comprob = a:
     Cct_stock.prf_comprob = b.
END.
FOR EACH Vigencia_cai WHERE Vigencia_cai.prf_comprob = a:
     Vigencia_cai.prf_comprob = b.
END.
FOR EACH Tipo_puntovta WHERE Tipo_puntovta.cdg_puntovta = a:
     Tipo_puntovta.cdg_puntovta = b.
END.
FOR EACH cta_cte WHERE prf_comprob = a:
   cta_cte.prf_comprob = b.
END.
FOR EACH Cierre_diario WHERE Cierre_diario.cdg_puntovta = a:
   Cierre_diario.cdg_puntovta = b.
END.
FOR EACH Acumulado_punto_venta WHERE Acumulado_punto_venta.cdg_puntovta = a:
   Acumulado_punto_venta.cdg_puntovta = b.
END.
FOR EACH Sub_header_vta WHERE Sub_header_vta.prf_comprob = a:
   Sub_header_vta.prf_comprob = b.
END.

