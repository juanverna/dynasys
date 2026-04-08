/*=================================================================================================*/
/*     REEXPRESA UN VALOR MONETARIO EN UNA MONEDA EN OTRA A UNA FECHA DE COTIZACION DADA           */
/*=================================================================================================*/

DEFINE INPUT  PARAMETER p-cdg_moneda_original    LIKE Moneda.cdg_moneda.
DEFINE INPUT  PARAMETER p-cdg_moneda_reexpresada LIKE Moneda.cdg_moneda.
DEFINE INPUT  PARAMETER p-fecha_cotizacion       AS DATE.
DEFINE OUTPUT PARAMETER p-tasa_cambio            AS DECIMAL.
DEFINE OUTPUT PARAMETER p-fecha_real_cotizacion  AS DATE.

/*=================================================================================================*/
/*                                           VARIABLES                                             */
/*=================================================================================================*/

DEFINE VARIABLE x-cotizacion_original    AS DECIMAL.
DEFINE VARIABLE x-cotizacion_reexpresada AS DECIMAL.

{dfmodocotiza.i}

/*=================================================================================================*/
/*                                       BLOQUE PRINCIPAL                                          */
/*=================================================================================================*/

{findempresa.i}

 RUN cotizar_moneda.p ( INPUT  p-cdg_moneda_original,
                        INPUT  Empresa.cdg_empresa, 
                        INPUT  p-fecha_cotizacion,       
                        OUTPUT x-cotizacion_original,  
                        OUTPUT p-fecha_real_cotizacion ).

 RUN cotizar_moneda.p ( INPUT  p-cdg_moneda_reexpresada,
                        INPUT  Empresa.cdg_empresa, 
                        INPUT  p-fecha_cotizacion,       
                        OUTPUT x-cotizacion_reexpresada,  
                        OUTPUT p-fecha_real_cotizacion ).

 RUN getparametro_c.p ( INPUT "MDCOTIZA", OUTPUT v-modo_cotiza ).

 /*
 IF v-modo_cotiza = v-dividir
     THEN p-tasa_cambio = x-cotizacion_original / x-cotizacion_reexpresada.
     ELSE p-tasa_cambio = x-cotizacion_reexpresada / x-cotizacion_original.
 */

 p-tasa_cambio = x-cotizacion_original / x-cotizacion_reexpresada.
                                                
