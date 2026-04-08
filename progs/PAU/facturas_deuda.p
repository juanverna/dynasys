    OUTPUT TO "c:\temp\facturas_deuda.csv".
    FOR EACH fac_header WHERE fecha >= 08/01/2017 NO-LOCK:
    IF length(Fac_header.deuda) = ? THEN NEXT. 
    FIND restriccion WHERE cdg_restriccion = "NODEU" NO-ERROR.
    FIND cliente_restriccion OF restriccion WHERE cliente_restriccion.nro_cliente = fac_header.nro_admin NO-ERROR.
    IF AVAILABLE cliente_restriccion THEN NEXT.
        FIND cliente OF fac_header NO-LOCK.
    EXPORT DELIMITER ";" Cliente.nom_cliente Fac_header.nom_Administrador nro_comprob.
END.
