FIND FIRST Usuario.

FOR first Valeinv_hd /*
     where tip_comprob = "fa"
       and prf_comprob = 1
       and nro_comprob = 2
       and cdg_empresa = "B" */:
   
    /*
    FOR EACH fac_detalle OF fac_header:
        display cantidad granel precio a_granel.
        UPDATE detallada VIEW-AS EDITOR SIZE 65 BY 6.
    END.
    RUN toletras.p ( INPUT Fac_header.imp_total, OUTPUT Fac_header.monto_letras).
    */
    
    run prval002.p ( input rowid(Valeinv_hd)).       

END.

       
