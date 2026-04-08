{VRSHARED.I "NEW"}
    {findempresa.i}
    FUNCTION ver_anticipos
    RETURNS DECIMAL ( ) :
    DEF VAR va AS DECIMAL NO-UNDO.
    va = 0.
    FOR EACH contrato_DT OF contrato_hd:
        va = va + contrato_DT.anticipo_cf.
    END.
    RETURN va.   /* Function return value. */
END FUNCTION.

PROCEDURE ver_cta_cte:
    DEFINE INPUT PARAMETER rid AS ROWID.
    DEFINE OUTPUT PARAMETER tot_debitogr AS DECIMAL.
    DEFINE OUTPUT PARAMETER tot_creditogr AS DECIMAL.
    
    DEF BUFFER bcontrato FOR contrato_hd.
    DEF BUFFER b-cta_cte FOR cta_cte.
    
    
       tot_debitogr = 0.
       tot_creditogr = 0.
    
       FIND bcontrato WHERE rowid(bcontrato)  = rid NO-LOCK NO-ERROR.
       IF AVAILABLE bcontrato THEN DO:
       /* Busca por Movimiento en la ctacte */
           FOR EACH B-Cta_cte 
              WHERE 
               B-Cta_cte.nro_cliente = bcontrato.nro_cliente 
                AND B-Cta_cte.nro_contrato = bcontrato.nro_contrato:
              IF CAN-DO(str_debitan,B-Cta_cte.tip_comprob)
                 THEN  tot_debitogr  = tot_debitogr + B-Cta_cte.debito.
                 ELSE  tot_creditogr = tot_creditogr + B-Cta_cte.credito.
           END.
       END.
END PROCEDURE.

    FUNCTION ver_cuota1 RETURNS DECIMAL :
    DEF VAR vv AS DECIMAL NO-UNDO.
    vv = 0.
    FOR EACH contrato_DT OF contrato_hd WHERE contrato_DT.solocuota1:
        vv = vv + contrato_DT.subtotal_gral.
    END.
    RETURN vv.   /* Function return value. */
END FUNCTION.

    DEF VAR tf AS DECIMAL.
    DEFINE VAR tp AS DECIMAL NO-UNDO.
    DEF VAR it AS decimal .
    DEF VAR cf AS INT .
    DEFINE VAR dcuota1 AS INT NO-UNDO.
OUTPUT TO "clipboard".
FOR EACH contrato_hd NO-LOCK WHERE contrato_hd.estado = "A" AND contrato_hd.cant_periodos <> 0 AND NOT contrato_hd.anulado AND contrato_hd.rige_desde > 01/01/2014 AND
    contrato_hd.rige_desde < TODAY AND 
    contrato_hd.fecha_baja = ? :
    cf = 0.
    dcuota1 = ver_cuota1().
    RUN ver_cta_cte( ROWID(contrato_hd), OUTPUT tf , OUTPUT tp ).
    FOR EACH fac_header OF contrato_hd NO-LOCK:
        cf = cf + IF fac_header.tip_comprob BEGINS "F" THEN 1 ELSE -1.
    END.
    IF cf = contrato_hd.cant_periodos - contrato_hd.resto_periodos THEN NEXT.
    it = dcuota1 + (contrato_hd.imp_total - ver_anticipos() - dcuota1 ) / contrato_hd.cant_periodos * ( contrato_hd.cant_periodos - contrato_hd.resto_periodos ).
    IF abs(tf - it ) < 1 THEN NEXT.
    DISPLAY contrato_hd.nro_contrato  contrato_hd.fecha_alta ( contrato_hd.cant_periodo - contrato_hd.resto_periodos ) COLUMN-LABEL "Coutas" cf it COLUMN-LABEL "Importe" tf.
END.


