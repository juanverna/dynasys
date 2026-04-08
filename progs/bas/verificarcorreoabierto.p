/*============================================================================================*/
/*         VERIFICA SI ESTA ARRANCADO EL CLIENTE DE CORREO OUTLOOK O OUTLOOK EXPRESS          */
/*============================================================================================*/

DEFINE OUTPUT PARAMETER p-quecorreo AS CHARACTER.

/*============================================================================================*/
/*                                       VARIABLES                                            */
/*============================================================================================*/

DEFINE VARIABLE listaprocesos    AS CHARACTER.
DEFINE VARIABLE listaejecutables AS CHARACTER INITIAL "msimn.exe,outlook.exe".
DEFINE VARIABLE listacorreos     AS CHARACTER INITIAL "EXPRESS,OUTLOOK".
DEFINE VARIABLE j-ejecutable     AS INTEGER.

{parlocales.i}

/*============================================================================================*/
/*                                      PROCESO                                               */
/*============================================================================================*/

    /* --------------------------------------------------------------- */
    /* Recupera valores posibles de ejecutables que la empresa utilice */
    /* Si el parametro no esta definido, se queda con los default que  */
    /* corresponden al OUTLOOK y al OUTLOOK EXPRESS de Microsoft.      */
    /* --------------------------------------------------------------- */

RUN getparametro.p (  INPUT  "EXESMAIL",
                      OUTPUT v-valor_c,
                      OUTPUT v-valor_d,
                      OUTPUT v-valor_l,
                      OUTPUT v-valor_n,
                      OUTPUT v-observacion ).
IF v-valor_c <> ? 
    THEN ASSIGN listaejecutables = v-valor_c
                listacorreos     = v-observacion.

    /* --------------------------------------------------------------- */
    /*       Recupera la lista de procesos actualmente activos         */
    /* --------------------------------------------------------------- */

RUN getlistaprocesos.p ( OUTPUT listaprocesos ).

    /* --------------------------------------------------------------- */
    /* Busca los ejecutables de los clientes de correo en la lista de  */
    /*procesos actualmente activos                                     */
    /* --------------------------------------------------------------- */

p-quecorreo = "".
DO j-ejecutable = 1 TO NUM-ENTRIES(listaejecutables,","):
    IF INDEX(listaprocesos,ENTRY(j-ejecutable,listaejecutables,",")) <> 0 
        THEN p-quecorreo = ENTRY(j-ejecutable,listacorreos,",").
END.


