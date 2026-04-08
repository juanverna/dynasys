define var dia as char extent 7 initial ["do","lu","ma","mi","ju","vi","sa"].
FOR EACH Valor:
 DISPLAY 
    Valor.nro_valor 
    Valor.importe 
    Valor.fecha_emision     
    dia[weekday(Valor.fecha_emision)] format "x(2)"LABEL "Dia"    
    Valor.fecha_deposito
    Valor.fecha_acredita 
    Valor.dias_clearing     
    WITH DOWN FONT 8 USE-TEXT.
END.    
