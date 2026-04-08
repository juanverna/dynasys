/*citi ventas*/
{tiempo.i}
    FUNCTION nro RETURN CHAR ( n AS DECIMAL ):
    IF n < 0 THEN n = 0.
    RETURN STRING( trunc( n * 100,0 ) ,"999999999999999" ).
    END.
DEFINE VAR mm AS INT FORMAT "99".
DEFINE VAR yy AS INT FORMAT "9999".
DEFINE VAR imponible AS DECIMAL DECIMALS 2 NO-UNDO.
DEFINE VAR otros_trib AS DECIMAL DECIMALS 2 NO-UNDO.
DEFINE VAR cantidad_alicuotas_iva AS INT NO-UNDO.
DEFINE STREAM venta.
DEFINE STREAM ali.
DEFINE VAR excenta AS DECIMAL DECIMALS 2 NO-UNDO.
DEFINE VAR dd AS DATE.
DEFINE VAR cod_op AS CHAR FORMAT "X" NO-UNDO.
mm = 9.
yy = 2020.
DEFINE VAR reg AS INT NO-UNDO.
REPEAT:
    mm = mm + 1.
    UPDATE mm yy.
    dd = DATE( mm,1,yy).
     
    OUTPUT STREAM venta TO VALUE( "e:\citiV\" + string(yy,"9999") + STRING(mm,"99") + ".txt" ).
    OUTPUT STREAM ali TO VALUE( "e:\citiV\" + string(yy,"9999") + STRING(mm,"99") + "Ali.txt" ).
    FOR EACH fac_header WHERE fecha >= primerdia(dd) AND fecha <= ultimodia(dd) AND fac_header.prf_comprob = 3 AND 
        NOT fac_header.anulado BY fac_header.tip_comprob:
        reg = reg + 1.
       
        IF NOT CAN-DO(  "FA,FB,DA,DB,NA,NB,CA,CB" ,fac_header.tip_comprob ) THEN next.
        FIND tipocomprobanteAFIP WHERE tipocomprobanteAFIP.tip_comprob = fac_header.tip_comprob NO-LOCK.
        FIND tipo_documento WHERE tipo_docu.cod_docu = fac_header.cod_docu NO-LOCK NO-ERROR.
        IF NOT AVAILABLE tipo_documento THEN
            MESSAGE fac_header.tip_comprob fac_header.prf_comprob fac_header.nro_comprob
                VIEW-AS ALERT-BOX INFO BUTTONS OK.

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
            cod_op=" ".
        END.
        IF cantidad_alicuotas_iva = 0 THEN do:
            cantidad_alicuotas_iva = 1.
            imponible = 0.
            cod_op = "N".
            PUT STREAM ali UNFORMATTED
                    string( int64( tipocomprobanteAFIP.cdg_afip) ,"999") +
                    STRING(prf_comprob,"99999" ) +
                    "0000000000" + STRING(nro_comprob, "9999999999" ) +
                    nro(0)
                    STRING( 3,"9999") 
                    nro(0) SKIP.
        END.
        excenta = fac_header.imp_total - fac_header.imp_iva - imponible.
        PUT STREAM venta UNFORMATTED
            string(YEAR(fac_header.fecha),"9999") STRING(MONTH(fac_header.fecha),"99") string(DAY(fac_header.fecha),"99") +
            string( int64( tipocomprobanteAFIP.cdg_afip) ,"999") +
            STRING(prf_comprob,"99999" ) +
            "0000000000" + STRING(nro_comprob, "9999999999" ) +
            "0000000000" + STRING(nro_comprob,"9999999999" ) +
            ( IF  int64( REPLACE( fac_header.cuit ,"-","" ) ) = 0 THEN "99" ELSE STRING(tipo_documento.cdg_afip,"99")) +
            "0000000" + string( int64( REPLACE( fac_header.cuit ,"-","" ) ) , "9999999999999" ) +
            STRING( fac_header.nombre, "x(30)" ) +
            nro( fac_header.imp_total ) +
            nro( 0 ) +
            nro( 0 ) +
            nro( excenta ) + 
            nro( 0 ) +
            nro( 0 ) +
            nro( 0 ) +
            nro( 0 ) +
            STRING( moneda.cdg_afip, "999" ) +
            "0001000000" +
            string( cantidad_alicuotas_iva, "9" ) +
            "N" +
            nro( otros_trib ) +
            string(YEAR(fac_header.fecha + 60 ),"9999" ) STRING(MONTH(fac_header.fecha + 60 ),"99" ) string(DAY(fac_header.fecha + 60 ),"99" ) SKIP.
    END.
    OUTPUT STREAM venta CLOSE.
    OUTPUT STREAM ali CLOSE.
END.
    




