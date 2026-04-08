{1}Asn_header.tot_debitos      = 0.
{1}Asn_header.tot_creditos     = 0.
{1}Asn_header.tot_debitos_div  = 0.
{1}Asn_header.tot_creditos_div = 0.

FOR EACH {1}Asn_detalle OF {1}Asn_header:

    {1}Asn_header.tot_debitos = {1}Asn_header.tot_debitos   + {1}Asn_detalle.debito.
    {1}Asn_header.tot_creditos = {1}Asn_header.tot_creditos + {1}Asn_detalle.credito.
    {1}Asn_header.tot_debitos_div = {1}Asn_header.tot_debitos_div   + {1}Asn_detalle.debito_div.
    {1}Asn_header.tot_creditos_div = {1}Asn_header.tot_creditos_div + {1}Asn_detalle.credito_div.

END.       

aux_diferencia     = {1}Asn_header.tot_debitos     - {1}Asn_header.tot_creditos.
aux_diferencia_div = {1}Asn_header.tot_debitos_div - {1}Asn_header.tot_creditos_div.
