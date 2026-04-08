COMPILE prrpv103b.p SAVE.

FOR EACH Rem_header_prv 
     where tip_comprob = "RM"
       AND prf_comprob = 8888
       and nro_comprob = 1
       and cdg_empresa = "M":
/*
    UPDATE Rem_header.leyenda VIEW-AS EDITOR SIZE 60 BY 5.                          
*/                                                                                  
    run prrpv103b.p ( input rowid(Rem_header_prv)).                                     
                                                                                    
END.                                                                                
                                                                                    
                                                                                    
                                                                                    
                                
