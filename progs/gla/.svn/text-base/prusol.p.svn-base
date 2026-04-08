
compile prrem103b.p save.

FOR EACH Rem_header 
      where tip_comprob = "RM" 
        AND prf_comprob = 0001 
        and nro_comprob = 62
        and cdg_empresa = "M":
    /*
    FOR EACH sre_detalle OF sre_header, articulo OF sre_detalle:
        DISPLAY nro_linea cdg_articulo.
        UPDATE articulo.extendida.
    END.
    

    UPDATE Rem_header.leyenda VIEW-AS EDITOR SIZE 60 BY 5.
*/
    run prrem103b.p ( input rowid(Rem_header)).       

END.


       
