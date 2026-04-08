OUTPUT TO PRINTER.
FOR EACH hst_pedido WHERE fch_cambio = TODAY AND hor_cambio >= 17 * 3600, FIRST ped_header OF hst_pedido, Usuario OF hst_pedido  BREAK BY fch_cambio DESCENDING  BY hor_cambio DESCENDING BY nro_comprob:
    /*
    
    DISPLAY fch_cambio hms_cambio nro_comprob cdg_usuario WITH STREAM-IO.
    */
    IF LAST-OF(nro_comprob) 
        THEN RUN prped114.p ( INPUT ROWID(ped_header) ).
END.
