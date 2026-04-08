FUNCTION pagado 
    RETURNS CHARACTER
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
{findempresa.i}
DEFINE VAR NOc AS CHARACTER INITIAL "1985,42153,42386,42549,42613,42620,42631,42769,42883,42886,42887,42889,42890,42891,42892,42894,42957,42975,42979,43168,43180,43181,43184,43187,43200,43326,43337,43473,43474,43475,43477,43619,43711,43798,43823".

FIND articulo WHERE cdg_articulo = "23f".
DEFINE VAR v AS INT.
FOR EACH fac_header WHERE fecha >= 07/01/2017 , EACH fac_detalle OF fac_header WHERE nro_articulo = articulo.nro_articulo AND
    precio_cf <> 260:
    IF LOOKUP(STRING(fac_header.nro_comprob),NOc ) <> 0  THEN NEXT.
    v = v + 1.
    IF pagado() = "N" THEN
    DISPLAY fac_header.tip_comprob fac_header.prf_comprob fac_header.nro_comprob.
    RUN cancela_factura.p ( fac_header.nro_factura ).

END.

