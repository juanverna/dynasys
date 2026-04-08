FOR EACH cta_cte WHERE clausula_dolar AND cambio_dolar = 1 AND nro_moneda = 1:
    DISPLAY tip_comprob prf_comprob nro_comprob cta_cte.fecha_emision cambio 
        WITH STREAM-IO.
    
    FIND LAST cotizacion 
        WHERE cotizacion.nro_moneda = 2
          AND cotizacion.fch_cotizacion <= cta_cte.fecha_emision
              NO-ERROR.

    IF AVAILABLE Cotizacion
        THEN cta_cte.cambio_dolar = cotizacion.cambio.

END.
