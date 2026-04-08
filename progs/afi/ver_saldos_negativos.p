DEFINE VARIABLE saldo AS DECIMAL.
output to "c:\sic-temp\saldosneg.txt" PAGE-SIZE 72.
FOR EACH Grupofam WHERE Grupofam.cdg_estado = "A" :

    saldo = 0.
    FIND Cliente OF Grupofam NO-LOCK.
    FOR EACH Cta_cte OF Cliente
       WHERE Cta_cte.debito <> Cta_cte.credito:

            saldo = saldo + Cta_cte.debito - Cta_cte.credito.
    
    END.
                          
    IF saldo < 0
    THEN DO:
         DISPLAY Grupofam.cdg_empresa Grupofam.cdg_grupofam Grupofam.nom_grupofam Grupofam.cdg_cobrador saldo
                 WITH STREAM-IO DOWN FRAME aa.
         DOWN WITH FRAME aa.        
    END.                          


END.

