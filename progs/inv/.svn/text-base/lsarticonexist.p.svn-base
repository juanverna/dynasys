/*====================================================================================*/
/*      GENERA EL LISTADO DE ARTICULOS CON EXISTENCIA EN UN RANGO DE DEPÓSITOS        */
/*====================================================================================*/

DEFINE INPUT PARAMETER des_articulo   LIKE Articulo.cdg_articulo.
DEFINE INPUT PARAMETER has_articulo   LIKE Articulo.cdg_articulo.

DEFINE INPUT PARAMETER des_deposito   LIKE Deposito.cdg_deposito.
DEFINE INPUT PARAMETER has_deposito   LIKE Deposito.cdg_deposito.

{VRSHARED.I}
{VPERSINM.I}
{DFVRBUIL.I}

DEFINE VARIABLE que_empresa LIKE Empresa.nombre.

/*=================================================================================*/
/*                              BLOQUE PRINCIPAL                                   */
/*=================================================================================*/

v-params = "p-empresa=" + Empresa.nombre + "~n" + 
           "p-depositos=Depósitos " + STRING(des_deposito) + 
                      " al " + STRING(has_deposito) + "~n". 

v-filtro = "Articulo.cdg_articulo >= '" + des_articulo + "' AND " + 
           "Articulo.cdg_articulo <= '" + has_articulo + "' AND " + 
           "Articulo-deposito.cdg_empresa = '" + Empresa.cdg_empresa + "' AND " + 
           "Articulo-deposito.cdg_deposito >= " + STRING(des_deposito) + " AND " + 
           "Articulo-deposito.cdg_deposito <= " + STRING(has_deposito) + " AND " + 
           "( Articulo-deposito.remanente_cantidad <> 0 OR Articulo-deposito.remanente_granel <> 0 )". 

/*MESSAGE V-FILTRO VIEW-AS ALERT-BOX MESSAGE.*/
           
RUN exreport.p (  INPUT  ".\prl\sic.prl",                 /* Librería desde la que se ejecuta */
                  INPUT "Remanentes por Articulo",        /* Nombre del reporte a ejecutar    */
                  INPUT  v-filtro,                        /* Filtro de registros a imponer    */
                  INPUT  "D",                             /* Salida de datos    (ver cPrinter)*/
                  INPUT  "",                              /* Impresora de destino del listado */
                  INPUT  v-params                         /* Parametros de Ejecucion          */
               )   
