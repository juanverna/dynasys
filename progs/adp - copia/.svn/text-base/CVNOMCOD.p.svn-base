DEFINE INPUT  PARAMETER sel_nombres AS CHARACTER.
DEFINE OUTPUT PARAMETER sel_codigos AS CHARACTER.

DEFINE VARIABLE j AS INTEGER.

{VRSHARED.I}
{VPERSINM.I}

sel_codigos = "".
DO j = 1 TO NUM-ENTRIES(sel_nombres):
   FIND FIRST Estado WHERE Estado.descripcion = ENTRY(j,sel_nombres).
   sel_codigos = sel_codigos + Estado.cdg_estado + ",".
END.
sel_codigos = SUBSTRING(sel_codigos,1,LENGTH(sel_codigos) - 1 ).   
  
RETURN.  