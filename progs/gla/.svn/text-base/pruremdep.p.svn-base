COMPILE prrdep103b.p SAVE.
FOR EACH Transdep_hd 
     where tip_comprob = "RM"
       AND prf_comprob = 676
       and nro_comprob = 240
       and cdg_empresa = "M":
/*
    UPDATE Rem_header.leyenda VIEW-AS EDITOR SIZE 60 BY 5.                          
*/                                                                                  
    run prrdep103b.p ( input rowid(Transdep_hd)).                                     
                                                                                    
END.                                                                                
                                                                                    
                                                                                    
                                                                                    
                                
