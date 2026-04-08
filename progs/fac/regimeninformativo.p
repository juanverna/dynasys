
    FUNCTION nro RETURN CHAR ( n AS DECIMAL ):
    RETURN STRING( trunc( n * 100,0 ) ,"999999999999999" ).
    END.
DEFINE VAR mm AS INT FORMAT "99".
DEFINE VAR yy AS INT FORMAT "9999".
DEFINE VAR imponible AS DECIMAL DECIMALS 2 NO-UNDO.
DEFINE VAR otros_trib AS DECIMAL DECIMALS 2 NO-UNDO.
DEFINE VAR cantidad_alicuotas_iva AS INT NO-UNDO.
DEFINE STREAM venta.
DEFINE STREAM ali.

REPEAT:
    UPDATE mm yy.
    OUTPUT STREAM venta TO VALUE( "c:\temp\Venta" + string(yy,"9999") + STRING(mm,"99") + ".txt" ).
    OUTPUT STREAM ali TO VALUE( "c:\temp\AlicVenta" + string(yy,"9999") + STRING(mm,"99") + ".txt" ).
    FOR EACH fac_header WHERE fecha >= 08/01/2016 AND fecha <= 08/31/2016 :
        FIND tipocomprobanteAFIP WHERE tipocomprobanteAFIP.tip_comprob = fac_header.tip_comprob NO-LOCK.
        FIND tipo_docu WHERE tipo_docu.cod_docu = fac_header.cod_docu NO-LOCK.
        FIND moneda of fac_header NO-LOCK.
        imponible = 0.
    otros_trib = 0.
    cantidad_alicuotas_iva = 0.
    FOR EACH fac_header_impuesto NO-LOCK OF fac_header, 
        impuesto NO-LOCK OF fac_header_impuesto :
        IF impuesto.es_iva THEN DO:
            cantidad_alicuotas_iva = cantidad_alicuotas_iva + 1.
            imponible = imponible + Fac_header_impuesto.monto_imponible.
            PUT STREAM ali UNFORMATTED
                string( int64( tipocomprobanteAFIP.cdg_afip) ,"999") +
                STRING(prf_comprob,"99999" ) +
                "0000000000" + STRING(nro_comprob, "9999999999" ) +
                nro(Fac_header_impuesto.monto_imponible)
                STRING( INT( impuesto.cdg_afip ),"9999") 
                nro(Fac_header_impuesto.importe) SKIP.
        END.
        ELSE
            otros_trib = otros_trib +  Fac_header_impuesto.importe.
    END.
    PUT STREAM venta UNFORMATTED
            string(YEAR(fac_header.fecha),"9999") STRING(MONTH(fac_header.fecha),"99") string(DAY(fac_header.fecha),"99") +
            string( int64( tipocomprobanteAFIP.cdg_afip) ,"999") +
            STRING(prf_comprob,"99999" ) +
            "0000000000" + STRING(nro_comprob, "9999999999" ) +
            "0000000000" + STRING(nro_comprob,"9999999999" ) +
            STRING(tipo_docu.cdg_afip,"99") +
            "0000000" + string( int64( REPLACE( fac_header.cuit ,"-","" ) ) , "9999999999999" ) +
            STRING( fac_header.nombre_leg, "x(30)" ) +
            nro( fac_header.imp_total ) +
            nro( 0 ) +
            nro( 0 ) +
            nro( fac_header.imp_total - fac_header.imp_iva - imponible ) + 
            nro( 0 ) +
            nro( 0 ) +
            nro( 0 ) +
            nro( 0 ) +
            STRING( moneda.cdg_afip, "999" ) +
            "0001000000" +
            string( cantidad_alicuotas_iva, "9" ) +
            "N" +
            nro( otros_trib ) +
            string(YEAR(fac_header.fecha + 30),"9999" ) STRING(MONTH(fac_header.fecha + 30 ),"99" ) string(DAY(fac_header.fecha + 30 ),"99" ) SKIP.
    END.
    OUTPUT STREAM venta CLOSE.
    OUTPUT STREAM ali CLOSE.
END.
    




