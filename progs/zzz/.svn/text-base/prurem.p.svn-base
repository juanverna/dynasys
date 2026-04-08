
compile prrem016.p save.

FOR EACH Rem_header 
     where tip_comprob = "RM"
       and prf_comprob = 1
       and nro_comprob = 35741
       and cdg_empresa = "B":
/*
    UPDATE Ped_header.leyenda VIEW-AS EDITOR SIZE 60 BY 5.


    FOR EACH rem_detalle OF rem_header, articulo OF rem_detalle:

        FOR EACH ALIART-CLIENTE OF ARTICULO:
        
            UPDATE ALIART-CLIENTE.cdg_aliascli FORMAT "X(20)".
        END.

    END.
*/    
    run prrem016.p ( input rowid(rem_header)). 


END.


       
