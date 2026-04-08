DEFINE INPUT  PARAMETER que_empleado   AS ROWID.
DEFINE INPUT  PARAMETER has_fecha      AS DATE.
DEFINE INPUT  PARAMETER emit_pago      AS LOGICAL.
DEFINE OUTPUT PARAMETER total_empleado AS DECIMAL.

{VRSHARED.I}
{VPERSINM.I}


  FIND Empleado WHERE ROWID(Empleado) = que_empleado NO-LOCK.

  total_empleado = 0.

  OPEN QUERY qry_historico       
       FOR EACH Cta_cte_emp OF Empleado 
           WHERE Cta_cte_emp.fecha_emision <= has_fecha
             AND Cta_cte_emp.estado = 1
              BY Cta_cte_emp.fecha_emision. 

  GET FIRST qry_historico.
  DO WHILE AVAILABLE Cta_cte_emp:

     IF Cta_cte_emp.tip_comprob = "RC"
        THEN total_empleado  = total_empleado  + Cta_cte_emp.debito.
        ELSE total_empleado = total_empleado - Cta_cte_emp.credito.

     IF emit_pago
     THEN DO:
        FIND CURRENT Cta_cte_emp EXCLUSIVE-LOCK.
        Cta_cte_emp.estado = 2.                 
     END.

     GET NEXT qry_historico.

  END.
  
RETURN.  