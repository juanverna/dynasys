FOR EACH acumulado_caja WHERE cdg_caja= 2 AND date(fechaA) = TODAY :
    DISPLAY Acumulado_caja.tot_egresos FORMAT ">>>>>>>>>>>>>>>>>>>.99"
        acumulado_caja.TOt_ingreso FORMAT ">>>>>>>>>>>>>>>>>>>.99".
    DISPLAY acumulado_caja.
END.
