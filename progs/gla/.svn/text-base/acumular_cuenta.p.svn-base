/*=================================================================================*/
/*                           ACUMULA DEBITOS Y CREDITOS                            */
/*=================================================================================*/

DEFINE INPUT PARAMETER rid_detalle AS ROWID.
DEFINE INPUT PARAMETER ope         AS CHARACTER.

/*=================================================================================*/
/*                             VARIABLES Y BUFFERS                                 */
/*=================================================================================*/

{VPERSINM.I}

/*=================================================================================*/
/*                               BLOQUE PRINCIPAL                                  */
/*=================================================================================*/

{findempresa.i}

FIND Asn_detalle WHERE ROWID(Asn_detalle) = rid_detalle NO-LOCK.
FIND Cuenta OF Asn_detalle NO-LOCK.

FIND FIRST Acumulado_cuenta OF Cuenta
     WHERE Acumulado_cuenta.cdg_empresa  = Empresa.cdg_empresa
       AND Acumulado_cuenta.ano          = YEAR(Asn_detalle.fecha_mayor)
       AND Acumulado_cuenta.mes          = MONTH(Asn_detalle.fecha_mayor)
       AND Acumulado_cuenta.nro_moneda   = Asn_detalle.nro_moneda 
           EXCLUSIVE-LOCK NO-ERROR.

IF NOT AVAILABLE Acumulado_cuenta
THEN DO:
   FIND FIRST Periodo_fiscal WHERE Periodo_fiscal.ano = YEAR(Asn_detalle.fecha_mayor)
                               AND Periodo_fiscal.mes = MONTH(Asn_detalle.fecha_mayor) NO-LOCK.
   CREATE Acumulado_cuenta.
   ASSIGN Acumulado_cuenta.cdg_empresa  = Empresa.cdg_empresa
          Acumulado_cuenta.nro_cuenta   = Cuenta.nro_cuenta
          Acumulado_cuenta.ano          = Periodo_fiscal.ano
          Acumulado_cuenta.mes          = Periodo_fiscal.mes
          Acumulado_cuenta.ano_fiscal   = Periodo_fiscal.ano_fiscal
          Acumulado_cuenta.nro_periodo  = Periodo_fiscal.nro_periodo
          Acumulado_cuenta.nro_moneda   = Asn_detalle.nro_moneda.
                               
END.

IF ope = "A"
THEN DO:
      Acumulado_cuenta.tot_debitos  = Acumulado_cuenta.tot_debitos  + Asn_detalle.debito.
      Acumulado_cuenta.tot_creditos = Acumulado_cuenta.tot_creditos + Asn_detalle.credito.
END.                            
ELSE DO:
      Acumulado_cuenta.tot_debitos  = Acumulado_cuenta.tot_debitos  - Asn_detalle.debito.
      Acumulado_cuenta.tot_debitos  = Acumulado_cuenta.tot_debitos  - Asn_detalle.debito.
END.


 
