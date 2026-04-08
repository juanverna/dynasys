/*=================================================================================*/
/*                                    PARAMETROS                                   */
/*=================================================================================*/

DEFINE INPUT PARAMETER ver_por     AS  INTEGER.
DEFINE INPUT PARAMETER des_codigo  LIKE Vendedor.cdg_vendedor.
DEFINE INPUT PARAMETER des_nombre  LIKE Vendedor.nombre.
DEFINE INPUT PARAMETER has_codigo  LIKE Vendedor.cdg_vendedor.
DEFINE INPUT PARAMETER has_nombre  LIKE Vendedor.nombre.
DEFINE INPUT PARAMETER des_fecha   AS DATE.
DEFINE INPUT PARAMETER has_fecha   AS DATE.
DEFINE INPUT PARAMETER que_moneda  AS ROWID.


{VRSHARED.I}
{VPERSINM.I}

DEFINE VARIABLE v-filtro AS CHARACTER.
DEFINE VARIABLE v-params AS CHARACTER.

DEFINE VARIABLE chr_des_fecha AS CHARACTER.
DEFINE VARIABLE chr_has_fecha AS CHARACTER.

RUN rbfecha.p ( INPUT des_fecha, OUTPUT chr_des_fecha ).
RUN rbfecha.p ( INPUT has_fecha, OUTPUT chr_has_fecha ).

FIND Moneda WHERE ROWID(Moneda) = que_moneda NO-LOCK.

FIND Empresa WHERE ROWID(Empresa) = act_empresa NO-LOCK.
v-params = "p-empresa=" + Empresa.nombre + "~n" + 
           "p-rango_fechas=" + STRING(des_fecha,"99/99/9999") + 
                           " al " + STRING(has_fecha,"99/99/9999") + "~n". 

v-filtro =  "Vendedor.cdg_vendedor >= '" +
            des_codigo +
            "' AND Vendedor.cdg_vendedor <= '" +
            has_codigo + 
            "' AND Cta_cte.credito <> Cta_cte.debito" +
            "  AND Cta_cte.cdg_empresa = '" + Empresa.cdg_empresa +
            "' AND Cta_cte.fecha_vencimiento <= " + chr_has_fecha +
            "  AND Cta_cte.fecha_vencimiento >= " + chr_des_fecha +
            "  AND Cta_cte.nro_moneda = " + STRING(Moneda.nro_moneda).

RUN exreport.p (  INPUT  ".\prl\sic.prl",             /* Librería desde la que se ejecuta */
                  INPUT  "Saldos por Vendedor",       /* Nombre del reporte a ejecutar    */
                  INPUT  v-filtro,                    /* Filtro de registros a imponer    */
                  INPUT  "D",                         /* Salida de datos    (ver cPrinter)*/
                  INPUT  "",                          /* Impresora de destino del listado */
                  INPUT  v-params                     /* Parametros especificos del reporte */
               )   
