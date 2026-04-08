/*=================================================================================*/
/*                           VARIABLES, FRAMES, Y SUBMENUES                        */
/*=================================================================================*/

{VRSHARED.I }

DEFINE VARIABLE que_empresa   LIKE Empresa.nombre.

DEFINE VARIABLE v-filtro AS CHARACTER.
DEFINE VARIABLE v-params AS CHARACTER.

/*=================================================================================*/
/*                           BLOQUE PRINCIPAL                                      */
/*=================================================================================*/

FIND Empresa WHERE ROWID(Empresa) = act_empresa NO-LOCK.
que_empresa = Empresa.nombre.

/*
v-filtro =  "Asn_header.fecha <= " +
            STRING(MONTH(has_fecha),"99") + "/" +
            STRING(DAY(has_fecha),"99") + "/" +
            STRING(YEAR(has_fecha),"9999") + 
            " AND Asn_header.fecha >= " + 
            STRING(MONTH(des_fecha),"99") + "/" +
            STRING(DAY(des_fecha),"99") + "/" +
            STRING(YEAR(des_fecha),"9999").
*/

v-filtro =  "".

v-params = "p-empresa=" + Empresa.nombre + "~n".

RUN exreport.p (  INPUT  ".\prl\sic.prl",        /* Librería desde la que se ejecuta   */
                  INPUT  "Maestro de Entidades", /* Nombre del reporte a ejecutar      */
                  INPUT  v-filtro,               /* Filtro de registros a imponer      */
                  INPUT  "D",                    /* Salida de datos    (ver cPrinter)  */
                  INPUT  "",                     /* Impresora de destino del listado   */
                  INPUT  v-params                /* Parametros especificos del reporte */
                )   
