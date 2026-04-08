/*=================================================================================================*/
/*                HALLA LA COTIZACION DE UNA MONEDA, DADAS UNA EMPRESA Y UNA FECHA                 */
/*=================================================================================================*/

DEFINE INPUT  PARAMETER p-cdg_moneda             LIKE Moneda.cdg_moneda.
DEFINE INPUT  PARAMETER p-cdg_empresa            LIKE Empresa.cdg_empresa.
DEFINE INPUT  PARAMETER p-fecha                  AS DATE.
DEFINE OUTPUT PARAMETER p-cotizacion             AS DECIMAL.
DEFINE OUTPUT PARAMETER p-fecha_cotizacion       AS DATE.

/*=================================================================================================*/
/*                                           VARIABLES                                             */
/*=================================================================================================*/

/*=================================================================================================*/
/*                                       BLOQUE PRINCIPAL                                          */
/*=================================================================================================*/

 FIND Moneda WHERE Moneda.cdg_moneda = p-cdg_moneda NO-LOCK NO-ERROR.
 IF NOT AVAILABLE Moneda
 THEN DO:
     MESSAGE "NO SE ENCONTRO LA MONEDA " p-cdg_moneda VIEW-AS ALERT-BOX.
     ASSIGN p-cotizacion       = ?
            p-fecha_cotizacion = ?.
 END.
 ELSE DO:
     FIND LAST Cotizacion OF Moneda 
         WHERE Cotizacion.cdg_empresa = p-cdg_empresa
           AND Cotizacion.fch_cotizacion <= p-fecha 
               NO-LOCK NO-ERROR.
     IF AVAILABLE Cotizacion 
     THEN DO:
         ASSIGN p-cotizacion       = Cotizacion.cambio
                p-fecha_cotizacion = Cotizacion.fch_cotizacion.
     END.
     ELSE DO:
         ASSIGN p-cotizacion       = ?
                p-fecha_cotizacion = ?.
     END.
 END.

