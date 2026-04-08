/*============================================================================================*/
/*                      REEXPRESA UN IMPORTE DADO EN MONEDA LOCAL                             */
/*============================================================================================*/

DEFINE INPUT  PARAMETER i-nro_moneda LIKE Moneda.nro_moneda.
DEFINE INPUT  PARAMETER i-fecha      AS DATE.
DEFINE INPUT  PARAMETER i-importe    AS DECIMAL.
DEFINE OUTPUT PARAMETER o-importe    AS DECIMAL.

/*============================================================================================*/
/*                                     VARIABLES                                               */
/*============================================================================================*/

DEFINE VARIABLE p-xx AS DATE . /* Por Compatibilidad */

DEFINE BUFFER Moneda_local FOR Moneda.

/*============================================================================================*/
/*                                       PROCESO                                              */                                                                                      
/*============================================================================================*/

FIND Moneda WHERE Moneda.nro_moneda = i-nro_moneda NO-LOCK.
IF Moneda.es_local
THEN DO:
    o-importe = i-importe.
END.
ELSE DO:
    FIND Moneda_local WHERE Moneda_local.es_local NO-LOCK.
    RUN reexpresar_importe.p ( INPUT Moneda.cdg_moneda,
                               INPUT Moneda_local.cdg_moneda,
                               INPUT i-fecha,
                               INPUT i-importe,
                               OUTPUT o-importe,
                               OUTPUT p-xx).
END.
