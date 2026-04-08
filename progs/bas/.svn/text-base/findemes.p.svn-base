/*================================================================================*/
/*                  ENCUENTRA EL ULTIMO DIA DE UN MES                             */
/*================================================================================*/

DEFINE INPUT-OUTPUT PARAMETER que_dia  AS INTEGER.
DEFINE INPUT        PARAMETER que_mes  AS INTEGER.
DEFINE INPUT        PARAMETER que_ano  AS INTEGER.

DEFINE VARIABLE que_fecha    AS DATE.
DEFINE VARIABLE fecha_valida AS LOGICAL.

que_dia = 31.
fecha_valida = NO.
DO WHILE NOT fecha_valida:
   IF que_dia = 0 
   THEN DO:
      MESSAGE "Error de conversion de fecha. No puede calcularse fin de mes"
               VIEW-AS ALERT-BOX ERROR TITLE "Error de sistema".
      RETURN.         
   END.
   que_fecha = DATE(que_mes,que_dia,que_ano) NO-ERROR.
   fecha_valida = NOT ERROR-STATUS:ERROR.
   IF NOT fecha_valida THEN que_dia = que_dia - 1.
END.
