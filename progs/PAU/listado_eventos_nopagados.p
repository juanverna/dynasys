DEFINE VAR pdesde  AS INT LABEL "Periodo desde".
DEFINE VAR phasta  AS INT LABEL "Hasta".
FUNCTION pagado RETURNS CHARACTER
  ( /* parameter-definitions */ ) :
    DEF VAR PAGA AS CHAR NO-UNDO.
      FIND cta_cte WHERE
      cta_cte.cdg_empresa = fac_header.cdg_empresa AND
      cta_cte.tip_comprob = fac_header.tip_comprob AND
      cta_cte.prf_comprob = fac_header.prf_comprob AND
      cta_cte.nro_comprob = fac_header.nro_comprob NO-LOCK NO-ERROR.
   
IF AVAILABLE cta_cte THEN DO:
      IF cta_cte.credito = 0 AND cta_cte.debito = 0 THEN paga = "S".
      ELSE DO:
          IF cta_cte.credito = 0 OR cta_cte.debito = 0 
              THEN paga = "N".
              ELSE IF cta_cte.credito = cta_cte.debito 
                  THEN paga = "S".
                  ELSE paga = "P".
      END.
  END.
  ELSE paga = "?".
     
RETURN paga.
END FUNCTION.
pdesde = 202001.
phasta =  202005.
UPDATE pdesde phasta.
OUTPUT TO e:\wproceso\eventos_sin_facturar1.csv.
PUT UNFORMATTED "Evento;Frealizado;Periodo;Codigo;Factura;Total" SKIP.
FOR EACH evento WHERE evento.nro_tipo_evento = 1 AND evento.origen = "CONTRATO" 
    AND Evento.Periodo >= pdesde AND evento.periodo <= phasta AND 
    Evento.frealizado = ? AND NOT evento.anulado:
    FIND cliente OF evento.
    FIND FIRST fac_header WHERE fac_header.nro_cliente = evento.nro_cliente AND
        year(fac_header.fecha) * 100 + MONTH(fac_header.fecha) =
       evento.periodo and
        fac_header.nro_contrato = Evento.nro_identificacion AND fac_header.tip_comprob BEGINS "F" NO-ERROR.

    IF NOT AVAILABLE fac_header THEN DO:
        EXPORT DELIMITER ";"  nro_evento evento.frealizado evento.periodo  cliente.cdg_cliente.
        NEXT.
    END.
    IF pagado() <> "S" THEN EXPORT DELIMITER ";"   nro_evento evento.frealizado evento.periodo cliente.cdg_cliente fac_header.nro_comprob fac_header.imp_total.
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        .
END.
