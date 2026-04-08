/*====================================================================================*/
/*               I M P R E S I O N   D E   R E Q U I S I C I O N                      */
/*====================================================================================*/

DEFINE INPUT PARAMETER act_documento  AS ROWID.

DEFINE VARIABLE v-filtro AS CHARACTER.
DEFINE VARIABLE v-params AS CHARACTER.

/*
{VRSHARED.I}
{VPERSINM.I}
*/

FIND FIRST Fac_header WHERE ROWID(Fac_header) = act_documento EXCLUSIVE-LOCK.

FIND FIRST Empresa /*WHERE ROWID(Empresa) = act_empresa*/ NO-LOCK.
v-params = "p-empresa=" + Empresa.nombre + "~n".

v-filtro = "Fac_header.tip_comprob = '" + Fac_header.tip_comprob + "' AND " + 
           "Fac_header.prf_comprob = " + STRING(Fac_header.prf_comprob) + " AND " +
           "Fac_header.nro_comprob = " + STRING(Fac_header.nro_comprob).

RUN exreport.p (  INPUT  ".\prl\forms201.prl",            /* Librería desde la que se ejecuta */
                  INPUT "FA",                             /* Nombre del reporte a ejecutar    */
                  INPUT  v-filtro,                        /* Filtro de registros a imponer    */
                  INPUT  "D",                             /* Salida de datos    (ver cPrinter)*/
                  INPUT  SESSION:PRINTER-NAME,            /* Impresora de destino del listado */
                  INPUT  v-params                         /* Parametros de Ejecucion          */
               )   
