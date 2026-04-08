/*===================================================================================*/
/*               ACUMULA LOS MOVIMIENTOS DE CUENA CORRIENTE                          */
/*===================================================================================*/

DEFINE INPUT PARAMETER ope AS CHARACTER.

{VPERSINM.I}
{VRSHARED.I}

FIND Cta_cte WHERE ROWID(Cta_cte) = act_ctacte NO-LOCK.
FIND Cliente OF Cta_cte NO-LOCK.

FIND FIRST Acumulado_ccte OF Cliente
     WHERE Acumulado_ccte.ano          = YEAR(Cta_cte.fecha_emision)
       AND Acumulado_ccte.mes          = MONTH(Cta_cte.fecha_emision) 
       AND Acumulado_ccte.nro_moneda   = Cta_cte.nro_moneda
       EXCLUSIVE-LOCK NO-ERROR.

IF NOT AVAILABLE Acumulado_ccte
THEN DO:
   CREATE Acumulado_ccte.
   ASSIGN Acumulado_ccte.nro_cliente  = Cliente.nro_cliente
          Acumulado_ccte.ano          = YEAR(Cta_cte.fecha_emision)
          Acumulado_ccte.mes          = MONTH(Cta_cte.fecha_emision)
          Acumulado_ccte.nro_moneda   = Cta_cte.nro_moneda.
END.

IF ope = "A"
THEN DO:
   IF LOOKUP(Cta_cte.tip_comprob,str_debitan) <> 0
      THEN Acumulado_ccte.tot_debitos  = Acumulado_ccte.tot_debitos  + Cta_cte.debito.
      ELSE Acumulado_ccte.tot_creditos = Acumulado_ccte.tot_creditos + Cta_cte.credito.
END.                            
ELSE DO:
   IF LOOKUP(Cta_cte.tip_comprob,str_debitan) <> 0
      THEN Acumulado_ccte.tot_debitos  = Acumulado_ccte.tot_debitos  - Cta_cte.debito.
      ELSE Acumulado_ccte.tot_creditos = Acumulado_ccte.tot_creditos - Cta_cte.credito.
END.

RETURN.

 
