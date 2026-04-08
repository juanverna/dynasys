DEFINE INPUT  PARAMETER sel_nombres AS CHARACTER.
DEFINE OUTPUT PARAMETER sel_codigos AS CHARACTER.

DEFINE VARIABLE j AS INTEGER.

{VRSHARED.I}
{VPERSINM.I}

sel_codigos = "".
DO j = 1 TO NUM-ENTRIES(sel_nombres):
   FIND FIRST Tit_dat_liq WHERE Tit_dat_liq.descripcion = ENTRY(j,sel_nombres).
   sel_codigos = sel_codigos + STRING(Tit_dat_liq.cdg_datliq,"9999") + ",".
END.
sel_codigos = SUBSTRING(sel_codigos,1,LENGTH(sel_codigos) - 1 ).   
  
RETURN.  