/*=================================================================================*/
/*           CALCULA EL STOCK DE UN ARTICULO A UNA DETERMINADA FECHA               */
/*=================================================================================*/

DEFINE INPUT  PARAMETER rid_articulo   AS ROWID.
DEFINE INPUT  PARAMETER rid_deposito   AS ROWID.
DEFINE INPUT  PARAMETER rid_partida    AS ROWID.
DEFINE INPUT  PARAMETER que_fecha      AS DATE.
DEFINE INPUT  PARAMETER ficha          AS INTEGER.
DEFINE OUTPUT PARAMETER sal_cantidad   LIKE Cct_stock.cantidad.
DEFINE OUTPUT PARAMETER sal_granel     LIKE Cct_stock.granel.

/*=================================================================================*/
/*                           VARIABLES, FRAMES, Y SUBMENUES                        */
/*=================================================================================*/

DEFINE VARIABLE pre_cantidad   LIKE Cct_stock.cantidad.
DEFINE VARIABLE pre_granel     LIKE Cct_stock.granel.

/*=================================================================================*/
/*                      B L O Q U E   P R I N C I P A L                            */
/*=================================================================================*/

RUN calcular_stock.p (INPUT rid_articulo,
                      INPUT rid_deposito,
                      INPUT rid_partida,
                      INPUT que_fecha,
                      INPUT ficha,
                      OUTPUT sal_cantidad,
                      OUTPUT sal_granel,
                      OUTPUT pre_cantidad,
                      OUTPUT pre_granel ).
