/*====================================================================================*/
/*               I M P R E S I O N   D E   R E Q U I S I C I O N                      */
/*====================================================================================*/

DEFINE INPUT PARAMETER act_documento  AS ROWID.

DEFINE VARIABLE v-filtro AS CHARACTER.
DEFINE VARIABLE v-params AS CHARACTER.

{VRSHARED.I}
{VPERSINM.I}

FIND FIRST Rem_header WHERE ROWID(Rem_header) = act_documento EXCLUSIVE-LOCK.

FIND Empresa WHERE ROWID(Empresa) = act_empresa NO-LOCK.
v-params = "p-empresa=" + Empresa.nombre + "~n".

v-filtro = "Rem_header.tip_comprob = '" + Rem_header.tip_comprob + "' AND " + 
           "Rem_header.prf_comprob = " + STRING(Rem_header.prf_comprob) + " AND " +
           "Rem_header.nro_comprob = " + STRING(Rem_header.nro_comprob).

RUN exreport.p (  INPUT  ".\prl\forms724.prl",            /* Librería desde la que se ejecuta */
                  INPUT "RM-724",                         /* Nombre del reporte a ejecutar    */
                  INPUT  v-filtro,                        /* Filtro de registros a imponer    */
                  INPUT  "D",                             /* Salida de datos    (ver cPrinter)*/
                  INPUT  "",                              /* Impresora de destino del listado */
                  INPUT  v-params                         /* Parametros de Ejecucion          */
               )   
