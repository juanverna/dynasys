Aps_header.tot_debitos      = 0.
Aps_header.tot_creditos     = 0.
Aps_header.tot_debitos_div  = 0.
Aps_header.tot_creditos_div = 0.

FOR EACH B-Aps_detalle OF Aps_header:

    Aps_header.tot_debitos = Aps_header.tot_debitos   + B-Aps_detalle.debito.
    Aps_header.tot_creditos = Aps_header.tot_creditos + B-Aps_detalle.credito.
    Aps_header.tot_debitos_div = Aps_header.tot_debitos_div   + B-Aps_detalle.debito_div.
    Aps_header.tot_creditos_div = Aps_header.tot_creditos_div + B-Aps_detalle.credito_div.

END.       

aux_diferencia     = Aps_header.tot_debitos     - Aps_header.tot_creditos.
aux_diferencia_div = Aps_header.tot_debitos_div - Aps_header.tot_creditos_div.