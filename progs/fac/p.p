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
OUTPUT TO "clipboard".
FOR EACH fac_header WHERE fac_header.fecha >= 01/01/2013 AND fac_HEADER.nro_contrato <> 0 AND fac_header.tip_comprob BEGINS "F" AND
         fac_header.fecha <= 05/01/2014 AND  NOT fac_header.anulado :
          
    IF pagado()="S" THEN NEXT.
        IF CAN-FIND(FIRST evento WHERE evento.nro_cliente = fac_header.nro_cliente AND 
                          evento.nro_identificacion = fac_header.nro_contrato AND evento.origen = "CONTRATO" AND
                          evento.periodo = year(fac_header.fecha) * 100 + MONTH(fac_header.fecha) AND
                          NOT evento.anulado AND evento.frealizado<>? ) THEN NEXT.
        DISPLAY fac_header.prf_comprob fac_header.nro_comprob fac_header.fecha.
END.
