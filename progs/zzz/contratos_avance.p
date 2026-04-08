/*este programa revisa los contratos de tanques y en funcion al estado actual, es decir si es un contrato de 6 periodos y resto periodos = 3
implica que se deberian haver realizado x cantidad de facturas y notas de credito por el importe de avance*/

FUNCTION ver_cuota1 
    RETURNS DECIMAL
  ( ) :
/*------------------------------------------------------------------------------
  Purpose:  
    Notes:  
------------------------------------------------------------------------------*/
    DEF VAR vv AS DECIMAL NO-UNDO.
    vv = 0.
    FOR EACH contrato_DT NO-LOCK OF contrato_hd WHERE contrato_DT.solocuota1:
        vv = vv + contrato_DT.subtotal_gral.
    END.
    RETURN vv.   /* Function return value. */
END FUNCTION.

FUNCTION ver_anticipos RETURNS DECIMAL
  ( ) :
/*------------------------------------------------------------------------------
  Purpose:  
    Notes:  
------------------------------------------------------------------------------*/
    DEF BUFFER bdetalle FOR contrato_dt.
    DEF VAR v-anticipo AS DECIMAL NO-UNDO.
    
    FOR EACH bdetalle OF contrato_hd:
        v-anticipo = bdetalle.anticipo.
    END.
    RETURN v-anticipo.   /* Function return value. */
END FUNCTION.


    DEFINE VAR n AS INT64 NO-UNDO.
    DEFINE VAR avance AS DECIMAL NO-UNDO.
    DEFINE VAR avance2 AS DECIMAL.
    DEFINE VAR facturado AS DECIMAL NO-UNDO.
    DEFINE VAR cuota AS DECIMAL NO-UNDO.
    DEFINE VAR rr AS INT64 NO-UNDO.
DEFINE VAR ff AS INT64.
OUTPUT TO e:\wproceso\contratos_avance.txt.
FOR EACH contrato_hd WHERE contrato_hd.estado = "A" AND contrato_hd.cant_periodos <> contrato_hd.resto_periodos and
    contrato_hd.nro_tipo_evento <> 1 AND NOT contrato_hd.anulado AND 
    contrato_hd.rige_desde > 04/01/2018 AND
    contrato_hd.fecha_baja = ?  BY contrato_hd.nro_contrato DESC TRANSACTION :
    IF ver_anticipos() <> 0 THEN NEXT.
    avance = ver_cuota1() + ver_anticipos().
    avance2 = avance.
    cuota = IF contrato_hd.cant_periodos <> 0 THEN (contrato_hd.imp_total - avance ) / contrato_hd.cant_periodos ELSE (contrato_hd.imp_total - avance ).
    DO n = 1 TO contrato_hd.cant_periodos - contrato_hd.resto_periodos :
        avance = avance + cuota.
    END.

     facturado = 0.
     ff = 0.
    FOR EACH fac_header OF contrato_hd NO-LOCK WHERE NOT fac_header.anulado BREAK BY fac_header.fecha DESC :
        facturado = facturado + ( IF fac_header.tip_comprob BEGINS "C" THEN -1 ELSE 1 ) * fac_header.imp_total.
        ff = ff +  ( IF fac_header.tip_comprob BEGINS "C" THEN -1 ELSE 1 ).
    END.
    
    IF abs(avance - facturado) > 10  THEN DO:
        DO n = 1 TO ff :
        avance2 = avance2 + cuota.
        END.
    
        /*IF avance2 = facturado THEN DO:
            MESSAGE contrato_hd.nro_contrato.
            DISPLAY contrato_hd.nro_contrato nro_tipo_evento avance facturado avance2 contrato_hd.rige_desde cant_periodos ( cant_periodos - resto_periodos ) ff avance2<>facturado WITH FRAME aaa .
            /*resto_periodos = cant_periodos - ff.*/
            NEXT.
        END. */
        DISPLAY contrato_hd.nro_contrato nro_tipo_evento avance facturado contrato_hd.rige_desde ( cant_periodos - resto_periodos ) ff avance2<>facturado WITH FRAME aaa .    
            rr = rr + 1.
    END.
END.
DISPLAY rr.


