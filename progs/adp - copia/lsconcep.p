/*=================================================================================*/
/*                        LISTADO DE CONCEPTOS DE HABERES                          */
/*=================================================================================*/
/*
{VRSHARED.I}
{VPERSINM.I}
*/
DEFINE VARIABLE v-filtro AS CHARACTER.
DEFINE VARIABLE v-params AS CHARACTER.

FIND Empresa /*WHERE ROWID(Empresa) = act_empresa*/ NO-LOCK.
v-params = "p-empresa=" + Empresa.nombre + "~n".

v-filtro =  "Concepto.cdg_concepto >= 0000 AND Concepto.cdg_concepto <= 9999".

RUN exreport.p (  INPUT  ".\prl\sic.prl",             /* Librería desde la que se ejecuta */
                  INPUT  "Conceptos de Haberes",      /* Nombre del reporte a ejecutar    */
                  INPUT  v-filtro,                    /* Filtro de registros a imponer    */
                  INPUT  "D",                         /* Salida de datos    (ver cPrinter)*/
                  INPUT  "",                          /* Impresora de destino del listado */
                  INPUT  v-params                     /* Parametros especificos del reporte */
               )   


