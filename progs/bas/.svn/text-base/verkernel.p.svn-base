
/*-- Obtiene Nombre de la PC --*/
DEFINE OUTPUT PARAMETER cPcName     as char format "x(16)"      NO-UNDO.
DEFINE VAR              b           as int initial 32           NO-UNDO.
DEFINE VAR              c           as int                      NO-UNDO.
DEFINE VAR              d           as memptr                   NO-UNDO.

set-size(d) = 16.
run GetComputerNameA (output d,
                      input-output b,
                      output c).
                    
if c = 1
then assign cPcName = get-string(d,1).

procedure GetComputerNameA external "kernel32.dll".
  def output parameter d as memptr.
  def input-output parameter b as long.
  def return parameter c as short.
end procedure.  



