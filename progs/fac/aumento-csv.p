/*aumento segun una lista csv*/

    DEFINE STREAM ss.
    DEFINE VAR pnro AS INT NO-UNDO.
    DEFINE VAR ptotal AS DECIMAL DECIMALS 2 NO-UNDO.
    DEFINE VAR poblea AS DECIMAL DECIMALS 2 INITIAL 65.00 NO-UNDO.
    DEFINE VAR poiva AS DECIMAL DECIMALS 2 NO-UNDO.
    DEFINE VAR k AS LOGICAL NO-UNDO.
    poiva = poblea / 1.21.
INPUT STREAM ss FROM c:\temp\cc.csv.
FIND articulo NO-LOCK WHERE articulo.cdg_articulo = "01f".

REPEAT :
    IMPORT  STREAM ss DELIMITER ";"  ptotal pnro.
    k = FALSE.
    FIND contrato_hd WHERE contrato_hd.nro_contrato = pnro.
    IF prf_contrato <> 1 THEN DO:
        FIND contrato_dt OF contrato_hd WHERE articulo.nro_articulo = contrato_dt.nro_articulo NO-ERROR.
        IF AVAILABLE contrato_dt THEN DO:
            k = TRUE.
            IF contrato_dt.precio <> poblea THEN  do:
                contrato_dt.precio = poblea.
                contrato_dt.precio_cf = poblea.
            END.
        END.
        FIND contrato_dt OF contrato_hd WHERE articulo.nro_articulo <> contrato_dt.nro_articulo NO-ERROR.
        IF AVAILABLE contrato_dt THEN DO:
            IF k  THEN DO:
                contrato_dt.precio = ptotal - poblea.
                contrato_dt.precio_cf = ptotal - poblea.
            END.
            ELSE DO:
                contrato_dt.precio = ptotal.
                contrato_dt.precio_cf = ptotal.
            END.

        END.
    END.
    ELSE DO:
        FIND contrato_dt OF contrato_hd WHERE articulo.nro_articulo = contrato_dt.nro_articulo NO-ERROR.
        IF AVAILABLE contrato_dt THEN DO:
            k = TRUE.
            IF contrato_dt.precio <> poiva THEN  do:
                contrato_dt.precio = poiva.
                contrato_dt.precio_cf = poblea.
            END.
        END.
        FIND contrato_dt OF contrato_hd WHERE articulo.nro_articulo <> contrato_dt.nro_articulo NO-ERROR.
        IF AVAILABLE contrato_dt THEN DO:
            IF k  THEN DO:
                contrato_dt.precio = (ptotal - poblea) / 1.21.
                contrato_dt.precio_cf = ptotal - poblea.
            END.
            ELSE DO:
                contrato_dt.precio = ( ptotal ) / 1.21.
                contrato_dt.precio_cf = ptotal .
            END.
    END.
    END.
END.
INPUT STREAM ss FROM c:\temp\cc.csv.
REPEAT:
    IMPORT  STREAM ss DELIMITER ";"  ptotal pnro.
    FIND contrato_hd WHERE contrato_hd.nro_contrato = pnro.
    ASSIGN  
       Contrato_hd.imp_bruto = 0
       Contrato_hd.imp_iva = 0
       Contrato_hd.imp_neto = 0
       Contrato_hd.imp_total = 0.
    FOR EACH contrato_dt OF contrato_hd:
                ASSIGN
        contrato_dt.subtotal_bruto    = contrato_dt.precio                                                                                                               
        contrato_dt.subtotal_bruto_cf = contrato_dt.precio_cf                                                                                                            
        contrato_dt.subtotal_neto_cf  = contrato_dt.precio_cf                                                                                                            
        contrato_dt.subtotal_gral     = contrato_dt.subtotal_bruto_cf                                                                                                    
        contrato_dt.subtotal_neto     = contrato_dt.precio                                                                                                               
        contrato_dt.subtotal_neto_cf  = contrato_dt.precio_cf. 
                Contrato_hd.imp_bruto         =Contrato_hd.imp_bruto + contrato_dt.subtotal_bruto.
                Contrato_hd.imp_iva           =Contrato_hd.imp_iva   + contrato_dt.precio_cf - contrato_dt.precio.
                Contrato_hd.imp_neto          =Contrato_hd.imp_neto  + contrato_dt.subtotal_neto.
                Contrato_hd.imp_total         =Contrato_hd.imp_total + contrato_dt.subtotal_gral.
    END.
END.
