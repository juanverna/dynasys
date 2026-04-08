OUTPUT TO "c:\sic-temp\balance.txt" PAGE-SIZE 0.
FOR EACH Lst_sumysal:
    DISPLAY 
        Lst_sumysal.que_codigo 
        Lst_sumysal.que_nombre 
        Lst_sumysal.acm_debitos_per      
        Lst_sumysal.acm_creditos_per     
        Lst_sumysal.saldo_per            
        Lst_sumysal.acm_debitos_tot      
        Lst_sumysal.acm_creditos_tot     
        Lst_sumysal.saldo_tot            
        
        WITH WIDTH 192 STREAM-IO.

END.
OUTPUT CLOSE.
RUN veresult.w ( INPUT "c:\sic-temp\balance.txt", INPUT 22).
