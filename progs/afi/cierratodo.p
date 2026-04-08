def var Z as integer.
{VRSHARED.I "NEW" }

define new shared variable codigo_iva as integer initial 1.
/*RUN CARPARAM.P.*/

define variable des_cobrador like cobrador.cdg_cobrador COLUMN-LABEL "Desde!Cobrador".
define variable has_cobrador like cobrador.cdg_cobrador COLUMN-LABEL "Hasta!Cobrador".

SESSION:DATA-ENTRY-RETURN = YES.

FIND FIRST Usuario.
act_usuario = ROWID(Usuario).

FIND FIRST Empresa.
act_empresa = ROWID(Empresa).

compile prinvale.p save.
compile cierrarendicion.p save.

set des_cobrador has_cobrador with frame a view-as dialog-box three-d.
FOR EACH Cobrador 
    WHERE Cobrador.cdg_cobrador <= has_cobrador
      AND Cobrador.cdg_cobrador >= des_cobrador
          NO-LOCK:
    
    FOR EACH Rendicion_hd OF Cobrador WHERE Rendicion_hd.abierta:
        RUN cierrarendicion.p ( INPUT ROWID (Rendicion_hd) ).
    END.    

END.
