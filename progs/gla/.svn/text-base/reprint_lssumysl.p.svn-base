/*=================================================================================*/
/*           GENERA EL LISTADO DE BALANCE DE SUMAS Y SALDOS CLASIFICADO            */
/*=================================================================================*/

DEFINE INPUT PARAMETER  p-des_fecha      AS DATE.
DEFINE INPUT PARAMETER  p-has_fecha      AS DATE.
DEFINE INPUT PARAMETER  p-cdg_moneda     LIKE Moneda.cdg_moneda.
DEFINE INPUT PARAMETER  p-reexpresion    AS LOGICAL.
DEFINE INPUT PARAMETER  p-cdg_balance    AS CHARACTER.
DEFINE INPUT PARAMETER  p-lis_fecha      AS LOGICAL.
DEFINE INPUT PARAMETER  p-lin_pagina     AS INTEGER.
DEFINE INPUT PARAMETER  p-ult_pagina     AS INTEGER.
DEFINE INPUT PARAMETER  p-todas_cuent    AS LOGICAL.   

/*=================================================================================*/
/*                                 VARIABLES                                       */
/*=================================================================================*/

DEFINE VARIABLE v-filtro AS CHARACTER.
DEFINE VARIABLE v-params AS CHARACTER.

/*=================================================================================*/
/*                          B L O Q U E   P R I N C I P A L                        */
/*=================================================================================*/

{findempresa.i}

FIND Moneda WHERE Moneda.cdg_moneda = p-cdg_moneda NO-LOCK.

/*=================================================================================*/
/*           INVOCA AL REPORT BUILDER PARA VER EL BALANCE                          */
/*=================================================================================*/

v-filtro =  "".

v-params = "p-listhora=" + STRING(p-lis_fecha) + "~n" + 
           "p-fechas=" + STRING(p-des_fecha) + " al " + STRING(p-has_fecha) + "~n" + 
           "p-empresa=" + Empresa.nombre + "~n" +
           "p-moneda=" + Moneda.descripcion + "~n" +
           "p-sinmov="  + IF p-todas_cuent THEN "S" ELSE "N" + "~n".

RUN exreport.p (  INPUT  ".\prl\sic.prl",     /* Librería desde la que se ejecuta   */
                  INPUT  "Balance de Saldos", /* Nombre del reporte a ejecutar      */
                  INPUT  v-filtro,            /* Filtro de registros a imponer      */
                  INPUT  "D",                 /* Salida de datos    (ver cPrinter)  */
                  INPUT  "",                  /* Impresora de destino del listado   */
                  INPUT  v-params             /* Parametros especificos del reporte */
                ).   

/*=================================================================================*/
/*                          P R O C E D I M I E N T O S                            */
/*=================================================================================*/



