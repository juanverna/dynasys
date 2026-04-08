/*=================================================================================*/
/*                                    PARAMETROS                                   */
/*=================================================================================*/

DEFINE INPUT PARAMETER des_proveedor   LIKE Proveedor.nombre.
DEFINE INPUT PARAMETER has_proveedor   LIKE Proveedor.nombre.

{VRSHARED.I}
{VPERSINM.I}

DEFINE VARIABLE v-filtro AS CHARACTER.
DEFINE VARIABLE v-params AS CHARACTER.

FIND Empresa WHERE ROWID(Empresa) = act_empresa NO-LOCK.
v-params = "p-empresa=" + Empresa.nombre + "~n".

v-filtro =  "Proveedor.nombre >= '" +
            des_proveedor +
            "' AND Proveedor.nombre <= '" +
            has_proveedor + "'".

RUN exreport.p (  INPUT  ".\prl\sic.prl",                    /* Librería desde la que se ejecuta */
                  INPUT  "Maestro Proveedores Alfabetico",   /* Nombre del reporte a ejecutar    */
                  INPUT  v-filtro,                           /* Filtro de registros a imponer    */
                  INPUT  "D",                                /* Salida de datos    (ver cPrinter)*/
                  INPUT  "",                                 /* Impresora de destino del listado */
                  INPUT  v-params                            /* Parametros especificos del reporte */
               )   
