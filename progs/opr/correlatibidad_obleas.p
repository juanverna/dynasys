    /*correlatividad de certificados sobre eventos no anulados*/
    OUTPUT TO c:\temp\faltantes.txt.
    DEFINE VAR k AS INT NO-UNDO.
    DEFINE VAR h AS INT NO-UNDO.
    FOR EACH certificados WHERE nro_desde < 1000000 AND nro_certificado <> 0:
        REPEAT k = nro_desde TO certificados.nro_certificado:
            FIND FIRST evento WHERE NOT evento.anulado AND 
                evento.nro_certif = k NO-LOCK NO-ERROR.
            IF NOT AVAILABLE evento THEN DO:
                DISPLAY k.
            END.

        END.
    
    END.
