/*=================================================================================*/
/*                   IMPRIME EL MAYOR PARA UNA CUENTA DETERMINADA                  */
/*=================================================================================*/
/*
{VPERSINM.I}
{VRSHARED.I }
*/
DEFINE INPUT PARAMETER des_fecha    LIKE Asn_detalle.fecha.
DEFINE INPUT PARAMETER has_fecha    LIKE Asn_detalle.fecha.

DEFINE VARIABLE saldo        LIKE Asn_detalle.debito LABEL "Saldo".
DEFINE VARIABLE acm_debitos  LIKE Asn_detalle.debito LABEL "Acum.debitos".
DEFINE VARIABLE acm_creditos LIKE Asn_detalle.credito LABEL "Acum.creditos".

DEFINE VARIABLE v-filtro AS CHARACTER.
DEFINE VARIABLE v-params AS CHARACTER.

/*=================================================================================*/
/*                                FUNCIONES                                        */
/*=================================================================================*/

FUNCTION rb_fecha RETURNS CHARACTER ( INPUT p-fecha AS DATE).

   DEFINE VARIABLE l-fecha AS CHARACTER.
   
   l-fecha = /*"'" + */
             STRING(MONTH(p-fecha),"99") + "/" +     
             STRING(DAY(p-fecha),"99") + "/" + 
             STRING(YEAR(p-fecha),"9999") /*+ 
             "'"*/.
             
   RETURN l-fecha.
              
END FUNCTION.

/*=================================================================================*/
/*                                BLOQUE PRINCIPAL                                 */
/*=================================================================================*/

FIND Empresa /*WHERE ROWID(Empresa) = act_empresa */ NO-LOCK.
 
v-filtro =  "Asn_detalle.fecha_mayor <= " + rb_fecha(has_fecha) + 
            " AND Asn_detalle.fecha_mayor >= " + rb_fecha(des_fecha).

v-params = "p-empresa=" + Empresa.nombre + "~n" + 
           "p-periodo=Del " + STRING(des_fecha) + " al " + STRING(has_fecha) + "~n". 

RUN exreport.p (  INPUT  ".\prl\sic.prl",         /* Librería desde la que se ejecuta   */
                  INPUT  "Cuadro de Resultados",  /* Nombre del reporte a ejecutar      */
                  INPUT  v-filtro,                /* Filtro de registros a imponer      */
                  INPUT  "D",                     /* Salida de datos    (ver cPrinter)  */
                  INPUT  "",                      /* Impresora de destino del listado   */
                  INPUT  v-params                 /* Parametros especificos del reporte */
                ).

