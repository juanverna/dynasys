DEFINE VARIABLE percha AS LOGICAL INITIAL NO .
DEFINE VARIABLE v-numero AS INTEGER.

UPDATE percha WITH THREE-D VIEW-AS DIALOG-BOX.

REPEAT:
    UPDATE v-numero. 
    FIND asn_header WHERE nro_comprob = v-numero.
    DISPLAY tabla_comprobante FORMAT "X(20)".
    FIND caj_header WHERE caj_header.nro_transaccion = asn_header.nro_idcabecera.
    DISPLAY caj_header.tip_comprob caj_header.prf_comprob caj_header.nro_comprob.
    
    IF percha 
    THEN DO:
    
        FOR EACH asn_detalle OF asn_header:
            DELETE asn_detalle.
        END.
        
        FOR EACH asn_totales OF asn_header:
            DELETE asn_totales.
        END.
        
        DELETE asn_header.
        
        Caj_header.contable = NO.
        UPDATE caj_header.cambio.
    
    END.

END.
