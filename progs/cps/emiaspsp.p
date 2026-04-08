/*=================================================================================*/
/*                           EMITE UN ASIENTO DE PRESUPUESTO                       */
/*=================================================================================*/

{VPERSINM.I}
{VRSHARED.I}

FIND Aps_header WHERE ROWID(Aps_header) = act_aps_head EXCLUSIVE-LOCK.
FOR EACH Aps_detalle OF Aps_header:

    act_aps_detl = ROWID(Aps_detalle).
    RUN ACUMCPSP.P ( INPUT "A" ).

END.   

 
