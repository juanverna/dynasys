/*=================================================================================*/
/*                           ACUMULA DEBITOS Y CREDITOS                            */
/*=================================================================================*/

DEFINE INPUT PARAMETER ope AS CHARACTER.

{VPERSINM.I}
{VRSHARED.I}

FIND Aps_detalle WHERE ROWID(Aps_detalle) = act_aps_detl.
FIND Ctapsp OF Aps_detalle NO-LOCK.

FIND FIRST Acumulado_ctapsp OF Ctapsp
     WHERE Acumulado_ctapsp.ano          = YEAR(Aps_detalle.fecha_mayor)
       AND Acumulado_ctapsp.mes          = MONTH(Aps_detalle.fecha_mayor) 
       EXCLUSIVE-LOCK NO-ERROR.

IF NOT AVAILABLE Acumulado_ctapsp
THEN DO:
   FIND FIRST Periodo_fiscal WHERE Periodo_fiscal.ano = YEAR(Aps_detalle.fecha_mayor)
                               AND Periodo_fiscal.mes = MONTH(Aps_detalle.fecha_mayor) NO-LOCK.
   CREATE Acumulado_ctapsp.
   ASSIGN Acumulado_ctapsp.nro_ctapsp   = Ctapsp.nro_ctapsp
          Acumulado_ctapsp.ano          = Periodo_fiscal.ano
          Acumulado_ctapsp.mes          = Periodo_fiscal.mes
          Acumulado_ctapsp.ano_fiscal   = Periodo_fiscal.ano_fiscal
          Acumulado_ctapsp.nro_periodo  = Periodo_fiscal.nro_periodo.
                               
END.

IF ope = "A"
THEN DO:
      Acumulado_ctapsp.tot_debitos  = Acumulado_ctapsp.tot_debitos  + Aps_detalle.debito.
      Acumulado_ctapsp.tot_creditos = Acumulado_ctapsp.tot_creditos + Aps_detalle.credito.

      Acumulado_ctapsp.tot_debitos_div  = Acumulado_ctapsp.tot_debitos_div  + Aps_detalle.debito.
      Acumulado_ctapsp.tot_creditos_div = Acumulado_ctapsp.tot_creditos_div + Aps_detalle.credito.

END.                            
ELSE DO:
      Acumulado_ctapsp.tot_debitos  = Acumulado_ctapsp.tot_debitos  - Aps_detalle.debito.
      Acumulado_ctapsp.tot_creditos_div = Acumulado_ctapsp.tot_creditos_div - Aps_detalle.credito.

      Acumulado_ctapsp.tot_debitos  = Acumulado_ctapsp.tot_debitos  - Aps_detalle.debito.
      Acumulado_ctapsp.tot_creditos_div = Acumulado_ctapsp.tot_creditos_div - Aps_detalle.credito.
END.


 
