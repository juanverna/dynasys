{1}Amd_header.tot_debitos      = 0.
{1}Amd_header.tot_creditos     = 0.
{1}Amd_header.tot_debitos_div  = 0.
{1}Amd_header.tot_creditos_div = 0.

FOR EACH B-Amd_detalle OF {1}Amd_header:

    {1}Amd_header.tot_debitos = {1}Amd_header.tot_debitos   + B-Amd_detalle.debito.
    {1}Amd_header.tot_creditos = {1}Amd_header.tot_creditos + B-Amd_detalle.credito.
    {1}Amd_header.tot_debitos_div = {1}Amd_header.tot_debitos_div   + B-Amd_detalle.debito_div.
    {1}Amd_header.tot_creditos_div = {1}Amd_header.tot_creditos_div + B-Amd_detalle.credito_div.

END.       

aux_diferencia     = {1}Amd_header.tot_debitos     - {1}Amd_header.tot_creditos.
aux_diferencia_div = {1}Amd_header.tot_debitos_div - {1}Amd_header.tot_creditos_div.