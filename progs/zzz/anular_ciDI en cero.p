/*elimina comprobantes generados en las cobranzas no aplicados y de cobranzas anuladas*/
FUNCTION pagado RETURNS CHARACTER
  ( /* parameter-definitions */ ) :
/*------------------------------------------------------------------------------
  Purpose:  
    Notes:  
------------------------------------------------------------------------------*/
    DEFINE VAR paga AS CHAR NO-UNDO.
    FIND cta_cte WHERE
      cta_cte.cdg_empresa = fac_header.cdg_empresa AND
      cta_cte.tip_comprob = fac_header.tip_comprob AND
      cta_cte.prf_comprob = fac_header.prf_comprob AND
      cta_cte.nro_comprob = fac_header.nro_comprob NO-LOCK NO-ERROR.
  IF AVAILABLE cta_cte THEN DO:
IF cta_cte.credito = 0 and cta_cte.debito = 0  then paga = "S".
else
      IF cta_cte.credito = 0 OR cta_cte.debito = 0 
          THEN paga = "N".
          ELSE IF cta_cte.credito = cta_cte.debito 
              THEN paga = "S".
              ELSE paga = "P".
  END.
  ELSE paga = "?".
     
  RETURN paga.

END FUNCTION.
DEFINE VAR a AS INT.
DEFINE VAR todook AS INTEGER.
OUTPUT TO c:\temp\companulados.txt.
{findempresa.i}
    {vrshared.i NEW}

FOR EACH fac_header OF empresa WHERE fac_header.prf_comprob <> 99 AND NOT anulado  AND
    fac_header.imp_total = 0:

    IF pagado() = "S" THEN NEXT.
/*RUN anular_comprobante_cliente.p( ROWID(fac_header), OUTPUT todook ).*/
    FIND contrato_hd OF fac_header.
DISPLAY fac_header.tip_comprob fac_header.nro_comprob fac_header.nro_contrato Contrato_hd.resto_periodos contrato_hd.cant_periodos.

END.

