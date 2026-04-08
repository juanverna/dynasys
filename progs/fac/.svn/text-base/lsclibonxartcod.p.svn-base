/*=================================================================================*/
/*                                    PARAMETROS                                   */
/*=================================================================================*/

DEFINE INPUT PARAMETER des_Cliente   LIKE Cliente.cdg_Cliente.
DEFINE INPUT PARAMETER has_Cliente   LIKE Cliente.cdg_Cliente.

{VRSHARED.I}
{VPERSINM.I}

DEFINE VARIABLE v-filtro AS CHARACTER.
DEFINE VARIABLE v-params AS CHARACTER.

FIND Empresa WHERE ROWID(Empresa) = act_empresa NO-LOCK.
v-params = "p-empresa=" + Empresa.nombre + "~n".

v-filtro =  "Cliente.cdg_Cliente >= '" +
            des_Cliente +
            "' AND Cliente.cdg_Cliente <= '" +
            has_Cliente + "'".

RUN exreport.p (  INPUT  ".\prl\sic.prl",               /* Librería desde la que se ejecuta */
                  INPUT  "Bonificaciones Por Articulo Cod", /* Nombre del reporte a ejecutar    */
                  INPUT  v-filtro,                      /* Filtro de registros a imponer    */
                  INPUT  "D",                           /* Salida de datos    (ver cPrinter)*/
                  INPUT  "",                            /* Impresora de destino del listado */
                  INPUT  v-params                       /* Parametros especificos del reporte */
               )   
