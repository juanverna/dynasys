/*=================================================================================*/
/*                                    PARAMETROS                                   */
/*=================================================================================*/

DEFINE INPUT PARAMETER des_proveedor   LIKE Proveedor.cdg_proveedor.
DEFINE INPUT PARAMETER has_proveedor   LIKE Proveedor.cdg_proveedor.

{VRSHARED.I}
{VPERSINM.I}

DEFINE VARIABLE v-filtro AS CHARACTER.
DEFINE VARIABLE v-params AS CHARACTER.

FIND Empresa WHERE ROWID(Empresa) = act_empresa NO-LOCK.
v-params = "p-empresa=" + Empresa.nombre + "~n".

v-filtro =  "Proveedor.cdg_proveedor >= '" +
            des_proveedor +
            "' AND Proveedor.cdg_proveedor <= '" +
            has_proveedor + "'".

RUN exreport.p (  INPUT  ".\prl\sic.prl",            /* Librería desde la que se ejecuta */
                  INPUT  "Maestro Proveedores",      /* Nombre del reporte a ejecutar    */
                  INPUT  v-filtro,                   /* Filtro de registros a imponer    */
                  INPUT  "D",                        /* Salida de datos    (ver cPrinter)*/
                  INPUT  "",                         /* Impresora de destino del listado */
                  INPUT  v-params                    /* Parametros especificos del reporte */

               )   
