run ponempresa.p ("c").
compile prfex114.p save.
COMPILE imprimir_pedido_inter.p SAVE.
FOR EACH Ped_header 
     where tip_comprob = "PD"
       and prf_comprob = 0
       and nro_comprob = 7
       and cdg_empresa = "c":

/*    update Ped_header.transportista format "x(50)"
           ped_header.leyenda view-as editor size 50 by 5.
*/    
       
    run imprimir_pedido_inter.p ( input rowid(ped_header)).       

END.


       
