/*====================================================================================*/
/*               I M P R E S I O N   D E   R E Q U I S I C I O N                      */
/*====================================================================================*/

DEFINE INPUT PARAMETER act_requisicion   AS ROWID.

DEFINE VARIABLE v-filtro AS CHARACTER.
DEFINE VARIABLE v-params AS CHARACTER.

DEFINE SHARED TEMP-TABLE T-Rqs_header LIKE Rqs_header.

{VRSHARED.I}
{VPERSINM.I}

FIND T-Rqs_header WHERE ROWID(T-Rqs_header) = act_requisicion EXCLUSIVE-LOCK.

FIND Empresa WHERE ROWID(Empresa) = act_empresa NO-LOCK.
v-params = "p-empresa=" + Empresa.nombre + "~n".

v-filtro = "Rqs_header.tip_comprob = 'PI' AND Rqs_header.nro_comprob = " + STRING(T-Rqs_header.nro_comprob).

RUN exreport.p (  INPUT  ".\prl\sic.prl",            /* Librería desde la que se ejecuta */
                  INPUT  "Requisicion de Almacenes", /* Nombre del reporte a ejecutar    */
                  INPUT  v-filtro,                   /* Filtro de registros a imponer    */
                  INPUT  "D",                        /* Salida de datos    (ver cPrinter)*/
                  INPUT  "",                         /* Impresora de destino del listado */
                  INPUT  v-params                    /* Parametros de Ejecucion */

               )   
