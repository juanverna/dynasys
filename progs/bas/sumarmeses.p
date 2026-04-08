/*=====================================================================================================*/
/*          DADA UNA FECHA LE SUMA UNA CANTIDAD FIJA DE MESES Y DEVUELVE LA FECHA RESULTANTE           */
/*=====================================================================================================*/

DEFINE INPUT PARAMETER  p-fecha_origen  AS DATE.
DEFINE INPUT PARAMETER  p-numero_meses  AS INTEGER.
DEFINE OUTPUT PARAMETER p-fecha_destino AS DATE.

/*=====================================================================================================*/
/*                                       VARIABLES                                                     */
/*=====================================================================================================*/

{fndiasmes.i}

DEFINE VARIABLE que_dia AS INTEGER.
DEFINE VARIABLE que_mes AS INTEGER.
DEFINE VARIABLE que_ano AS INTEGER.

DEFINE VARIABLE j AS INTEGER.

/*=====================================================================================================*/
/*                                       PROCESO                                                       */
/*=====================================================================================================*/

que_dia = DAY(p-fecha_origen).
que_mes = MONTH(p-fecha_origen).
que_ano = YEAR(p-fecha_origen).

DO j = 1 TO p-numero_meses: 
    IF que_mes <> 12
    THEN DO:
       que_mes = que_mes + 1.
    END.
    ELSE DO:   
       que_mes = 1.
       que_ano = que_ano + 1.   
    END.
END.

que_dia = MINIMUM(que_dia,diasmes(que_mes,que_ano)).
p-fecha_destino = DATE(que_mes,que_dia,que_ano).
