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
FOR EACH fac_header OF empresa WHERE fac_header.prf_comprob = 99 AND NOT anulado AND fac_header.fecha > 11/01/2012:
    IF pagado() = "S" THEN NEXT.
    
FIND fac_detalle OF fac_header.
a = int( ENTRY( 3 , fac_detalle.detallada ,"-") ) NO-ERROR.
IF a = 0 THEN NEXT.
FIND rendicion_hd WHERE rendicion_hd.nro_rendicion = a.
IF rendicion_hd.st_tesoreria <> "A" THEN NEXT.
FIND cliente WHERE cliente.nro_cliente = rendicion_hd.nro_admin.
RUN anular_comprobante_cliente.p( ROWID(fac_header), OUTPUT todook , NO).
DISPLAY fac_header.tip_comprob  fac_header.nro_comprob fac_header.nro_comprob rendicion_hd.nro_rendicion cliente.cdg_cliente todook.

END.

