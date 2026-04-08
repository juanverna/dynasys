{1}Amp_header.tot_debitos      = 0.
{1}Amp_header.tot_creditos     = 0.
{1}Amp_header.tot_debitos_div  = 0.
{1}Amp_header.tot_creditos_div = 0.

FOR EACH B-Amp_detalle OF {1}Amp_header:

    {1}Amp_header.tot_debitos = {1}Amp_header.tot_debitos   + B-Amp_detalle.debito.
    {1}Amp_header.tot_creditos = {1}Amp_header.tot_creditos + B-Amp_detalle.credito.
    {1}Amp_header.tot_debitos_div = {1}Amp_header.tot_debitos_div   + B-Amp_detalle.debito_div.
    {1}Amp_header.tot_creditos_div = {1}Amp_header.tot_creditos_div + B-Amp_detalle.credito_div.

END.       

aux_diferencia     = {1}Amp_header.tot_debitos     - {1}Amp_header.tot_creditos.
aux_diferencia_div = {1}Amp_header.tot_debitos_div - {1}Amp_header.tot_creditos_div.