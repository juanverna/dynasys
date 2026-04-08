COMPILE prrem103b.p SAVE.
FOR EACH Rem_header 
     where tip_comprob = "RM"
       AND prf_comprob = 676
       and nro_comprob = 235
       and cdg_empresa = "M":
/*
    UPDATE Rem_header.leyenda VIEW-AS EDITOR SIZE 60 BY 5.                          
*/                                                                                  
    run prrem103b.p ( input rowid(Rem_header)).                                     
                                                                                    
END.                                                                                
                                                                                    
                                                                                    
                                                                                    
                                
