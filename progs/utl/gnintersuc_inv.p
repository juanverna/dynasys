/*=================================================================================*/
/*   GENERA LA INTERFACE DE SUCURSALES PARA TODAS LAS TRANSACCIONES DE INVENTARIO  */
/*=================================================================================*/

DEFINE INPUT PARAMETER p-pto_venta AS CHARACTER.
DEFINE INPUT PARAMETER p-des_fecha AS DATE. 
DEFINE INPUT PARAMETER p-has_fecha AS DATE. 
DEFINE INPUT PARAMETER p-archivo   AS CHARACTER. 


RUN gnintersuc_aju.p (  INPUT  p-pto_venta,
                        INPUT  p-des_fecha, 
                        INPUT  p-has_fecha, 
                        INPUT  p-archivo). 

RUN gnintersuc_tra.p (  INPUT  p-pto_venta,
                        INPUT  p-des_fecha, 
                        INPUT  p-has_fecha, 
                        INPUT  p-archivo). 


RUN gnintersuc_val.p (  INPUT  p-pto_venta,
                        INPUT  p-des_fecha, 
                        INPUT  p-has_fecha, 
                        INPUT  p-archivo). 
