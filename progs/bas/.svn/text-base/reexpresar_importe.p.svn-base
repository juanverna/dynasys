/*=================================================================================================*/
/*     REEXPRESA UN VALOR MONETARIO EN UNA MONEDA EN OTRA A UNA FECHA DE COTIZACION DADA           */
/*=================================================================================================*/

DEFINE INPUT  PARAMETER p-cdg_moneda_original    LIKE Moneda.cdg_moneda.
DEFINE INPUT  PARAMETER p-cdg_moneda_reexpresada LIKE Moneda.cdg_moneda.
DEFINE INPUT  PARAMETER p-fecha_cotizacion       AS DATE.
DEFINE INPUT  PARAMETER p-importe_original       AS DECIMAL.
DEFINE OUTPUT PARAMETER p-importe_reexpresado    AS DECIMAL.
DEFINE OUTPUT PARAMETER p-fecha_real_cotizacion  AS DATE.

/*=================================================================================================*/
/*                                           VARIABLES                                             */
/*=================================================================================================*/

DEFINE VARIABLE x-tasa_cambio    AS DECIMAL.
DEFINE VARIABLE x-cotizacion_reexpresada AS DECIMAL.

/*=================================================================================================*/
/*                                       BLOQUE PRINCIPAL                                          */
/*=================================================================================================*/

IF p-cdg_moneda_original = p-cdg_moneda_reexpresada
THEN DO:
    p-importe_reexpresado = p-importe_original.
    p-fecha_real_cotizacion = TODAY.
END.
ELSE DO:
    RUN hallar_tasa_cambio.p ( INPUT  p-cdg_moneda_original,
                               INPUT  p-cdg_moneda_reexpresada,
                               INPUT  p-fecha_cotizacion,       
                               OUTPUT x-tasa_cambio,  
                               OUTPUT p-fecha_real_cotizacion ).
    p-importe_reexpresado = ROUND(p-importe_original * x-tasa_cambio,2).
END.

                                                
