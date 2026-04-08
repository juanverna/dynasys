DEFINE VARIABLE v-cdg_moneda_original    LIKE Moneda.cdg_moneda INITIAL "pe".
DEFINE VARIABLE v-cdg_moneda_reexpresada LIKE Moneda.cdg_moneda INITIAL "do".
DEFINE VARIABLE v-fecha_cotizacion       AS DATE INITIAL TODAY.
DEFINE VARIABLE v-importe_original       AS DECIMAL.
DEFINE VARIABLE v-importe_reexpresado    AS DECIMAL.
DEFINE VARIABLE v-fecha_real_cotizacion  AS DATE.

REPEAT:
    UPDATE v-importe_original.
    
    RUN reexpresar_importe.p (
      INPUT  v-cdg_moneda_original    ,
      INPUT  v-cdg_moneda_reexpresada ,
      INPUT  v-fecha_cotizacion       ,
      INPUT  v-importe_original       ,
      OUTPUT v-importe_reexpresado    ,
      OUTPUT v-fecha_real_cotizacion  ).

    DISPLAY v-importe_reexpresado.

END.

