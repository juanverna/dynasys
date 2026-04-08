/*=================================================================================*/
/*                                                                                 */
/*  INTERFASE ENTRE EL MOTOR DE CALCULO Y EL PROGRMA DE RETENCIONES DE GANANCIAS   */
/*                                                                                 */
/*=================================================================================*/

DEFINE OUTPUT PARAMETER resultado    AS DECIMAL.
DEFINE OUTPUT PARAMETER rc           AS INTEGER.

DEFINE SHARED VARIABLE pila          AS DECIMAL FORMAT "-ZZZZZZZ9.99" EXTENT 10.
DEFINE SHARED VARIABLE constante_liq AS DECIMAL FORMAT "ZZZZZZZ9.99" EXTENT 1000.

DEFINE VARIABLE ano_dj  AS INTEGER.
DEFINE VARIABLE mes_dj  AS INTEGER.

mes_dj = constante_liq [ 197 ].
ano_dj = constante_liq [ 199 ] MOD 100.
IF ano_dj < 20 THEN ano_dj = ano_dj + 2000.
               ELSE ano_dj = ano_dj + 1900.
/*
              message string(ano_dj) "/" string(mes_dj) view-as alert-box message
               title "fecha calculada".
*/

RUN CALC4CAT.P (  INPUT  ano_dj, 
                  INPUT  mes_dj,
                  INPUT  pila [ 1 ], /* aportes jubilatorios */
                  INPUT  pila [ 2 ], /* donaciones           */
                  INPUT  pila [ 3 ], /* ganancias liquidadas */
                  INPUT  pila [ 4 ], /* aportes o/s          */
                  INPUT  pila [ 5 ], /* otras deducciones    */
                  INPUT  pila [ 6 ], /* gastos de sepelios   */
                  INPUT  pila [ 7 ], /* seguros de retiro    */
                  INPUT  pila [ 8 ], /* movilidad viajantes  */
                  OUTPUT  resultado ).

rc = 0.
