DEF VAR saldo AS DECIMAL.
DEF VAR AcumuladoI AS decimal.
DEF VAR AcumuladoE AS DECIMAL.
DEF VAR cont AS INTEGER.
saldo      = 0.
AcumuladoI = 0.
AcumuladoE = 0.

FIND caja WHERE cdg_caja = 2 .
FOR EACH caj_header OF caja WHERE caj_header.estado <> "A" 
                              AND cdg_empresa = "F"
                              AND anulado = NO
                              AND Caj_header.fecha >= 04/01/2005
                              AND Caj_header.fecha <= 01/01/2009:

    FOR EACH Caj_detalle OF Caj_header:
              FIND Rubro OF caj_detalle NO-LOCK NO-ERROR.              
              IF rubro.cdg_rubro = 2 THEN DO:
                   FIND valor OF caj_detalle NO-LOCK NO-ERROR.
                    IF AVAILABLE valor AND valor.estado = "00" AND valor.cdg_empresa = "F" THEN DO:
                      IF Caj_detalle.tipo_mov = "E"
                         THEN AcumuladoE  = AcumuladoE  + Caj_detalle.importe.
                      IF Caj_detalle.tipo_mov = "I" THEN
                         AcumuladoI = AcumuladoI + Caj_detalle.importe.
                    END.
                    
             END.
    END.
END.
saldo = AcumuladoI - AcumuladoE.
MESSAGE saldo VIEW-AS ALERT-BOX.
