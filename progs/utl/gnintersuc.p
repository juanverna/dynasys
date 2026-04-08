/*=================================================================================*/
/*                       GENERA LA INTERFACE DE SUCURSALES                         */
/*=================================================================================*/

DEFINE INPUT PARAMETER p-pto_venta AS CHARACTER.
DEFINE INPUT PARAMETER p-des_fecha AS DATE. 
DEFINE INPUT PARAMETER p-has_fecha AS DATE. 
DEFINE INPUT PARAMETER p-archivo   AS CHARACTER. 

RUN gnintersuc_dsp.p (  INPUT  p-pto_venta,
                        INPUT  p-des_fecha, 
                        INPUT  p-has_fecha, 
                        INPUT  p-archivo ). 

RUN gnintersuc_fac.p (  INPUT  p-pto_venta,
                        INPUT  p-des_fecha, 
                        INPUT  p-has_fecha, 
                        INPUT  p-archivo ). 

/*

RUN gnintersuc_inv.p (  INPUT  p-pto_venta,
                        INPUT  p-des_fecha, 
                        INPUT  p-has_fecha, 
                        INPUT  p-archivo ). 
*/

RUN gnintersuc_cxc.p (  INPUT  p-pto_venta,
                        INPUT  p-des_fecha, 
                        INPUT  p-has_fecha, 
                        INPUT  p-archivo ). 

RUN gnintersuc_tes.p (  INPUT  p-pto_venta,
                        INPUT  p-des_fecha, 
                        INPUT  p-has_fecha, 
                        INPUT  p-archivo ). 

