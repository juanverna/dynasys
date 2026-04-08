/*=================================================================================*/
/*                   ACUMULACION DE PAGOS DEL PROVEEDOR                            */
/*=================================================================================*/

DEFINE INPUT PARAMETER ope AS CHARACTER.

{VPERSINM.I}
{VRSHARED.I}

FIND Cta_cte_prv WHERE ROWID(Cta_cte_prv) = act_ctacte_prv.
FIND Proveedor OF Cta_cte_prv.

FIND FIRST Acumulado_ccte_prv OF Proveedor
     WHERE Acumulado_ccte_prv.ano          = YEAR(Cta_cte_prv.fecha_emision)
       AND Acumulado_ccte_prv.mes          = MONTH(Cta_cte_prv.fecha_emision) 
       AND Acumulado_ccte_prv.nro_moneda   = Cta_cte_prv.nro_moneda
       EXCLUSIVE-LOCK NO-ERROR.

IF NOT AVAILABLE Acumulado_ccte_prv
THEN DO:
   CREATE Acumulado_ccte_prv.
   ASSIGN Acumulado_ccte_prv.nro_Proveedor  = Proveedor.nro_Proveedor
          Acumulado_ccte_prv.ano          = YEAR(Cta_cte_prv.fecha_emision)
          Acumulado_ccte_prv.mes          = MONTH(Cta_cte_prv.fecha_emision)
          Acumulado_ccte_prv.nro_moneda   = Cta_cte_prv.nro_moneda.
END.

IF ope = "A"
THEN DO:
   IF LOOKUP(Cta_cte_prv.tip_comprob,str_debitan_prv) <> 0
      THEN Acumulado_ccte_prv.tot_debitos  = Acumulado_ccte_prv.tot_debitos  + Cta_cte_prv.debito.
      ELSE Acumulado_ccte_prv.tot_creditos = Acumulado_ccte_prv.tot_creditos + Cta_cte_prv.credito.
END.                            
ELSE DO:
   IF LOOKUP(Cta_cte_prv.tip_comprob,str_debitan_prv) <> 0
      THEN Acumulado_ccte_prv.tot_debitos  = Acumulado_ccte_prv.tot_debitos  - Cta_cte_prv.debito.
      ELSE Acumulado_ccte_prv.tot_creditos = Acumulado_ccte_prv.tot_creditos - Cta_cte_prv.credito.
END.

RETURN.

 
