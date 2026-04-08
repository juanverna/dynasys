/*=====================================================================================*/
/* DADA UNA FECHA, DEVUELVE LA FECHA DE COMIENZO DEL EJERCICIO QUE COMPRENDE ESA FECHA */
/*=====================================================================================*/

DEFINE INPUT PARAMETER  fecha_entrada  LIKE Asn_detalle.fecha.
DEFINE OUTPUT PARAMETER fecha_comienzo LIKE Asn_detalle.fecha.

/*=====================================================================================*/
/*                                    VARIABLES                                        */
/*=====================================================================================*/

{parlocales.i}

DEFINE VARIABLE v-ano AS INTEGER.
DEFINE VARIABLE v-mes AS INTEGER.

/*=====================================================================================*/
/*                                 BLOQUE PRINCIPAL                                    */
/*=====================================================================================*/

/* Busca el mes de comienzo del ejercicio */

RUN getparametro.p (  INPUT  "PRPERCON",
                      OUTPUT v-valor_c,
                      OUTPUT v-valor_d,
                      OUTPUT v-valor_l,
                      OUTPUT v-valor_n,
                      OUTPUT v-observacion ).

/* Si el mes de la fecha es posterior al de comienzo del ejercicio, tomamos el año de */
/* la fecha. En caso contrario, el mes de comienzo */

v-mes = v-valor_n.

IF MONTH(fecha_entrada) >= v-mes
    THEN v-ano = YEAR(fecha_entrada).
    ELSE v-ano = YEAR(fecha_entrada) - 1.

fecha_comienzo = DATE(v-mes,1,v-ano).
