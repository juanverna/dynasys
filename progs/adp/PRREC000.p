/*=================================================================================*/
/*                                    PARAMETROS                                   */
/*=================================================================================*/

DEFINE INPUT PARAMETER act_recibo      AS ROWID.

{VRSHARED.I}
{VPERSINM.I}

FIND Rcb_header WHERE ROWID(Rcb_header) = act_recibo NO-LOCK.

DEFINE VARIABLE v-filtro AS CHARACTER.


v-filtro =  "Rcb_header.nro_comprob= " +
            STRING(Rcb_header.nro_comprob).
            
RUN exreport.p (  INPUT  ".\prl\sic.prl",            /* Librería desde la que se ejecuta */
                  INPUT  "Orden de Compra",          /* Nombre del reporte a ejecutar    */
                  INPUT  v-filtro,                   /* Filtro de registros a imponer    */
                  INPUT  "D",                        /* Salida de datos    (ver cPrinter)*/
                  INPUT  "",                         /* Impresora de destino del listado */
                  INPUT  ""                          /* Parametros especificos del reporte */

               )   
