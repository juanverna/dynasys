  DEFINE INPUT  PARAMETER f_entrada    AS DATE.
  DEFINE INPUT  PARAMETER h_entrada    AS DECIMAL.
  DEFINE INPUT  PARAMETER f_salida     AS DATE.
  DEFINE INPUT  PARAMETER h_salida     AS DECIMAL.
  DEFINE OUTPUT PARAMETER h_diferencia AS DECIMAL.

  DEFINE VARIABLE t_entrada      AS INTEGER. /* HORA DE ENTRADA EXPRESADA EN MINUTOS */
  DEFINE VARIABLE t_salida       AS INTEGER. /* HORA DE SALIDA  EXPRESADA EN MINUTOS */
  DEFINE VARIABLE t_diferencia   AS INTEGER. /* TIEMPO DE DIFERENCIA EN MINUTOS */

  DEFINE VARIABLE h_e            AS INTEGER.
  DEFINE VARIABLE h_s            AS DECIMAL.
  DEFINE VARIABLE d              AS INTEGER.


  RUN CNVHSAMI.P ( INPUT h_entrada , OUTPUT t_entrada).
  RUN CNVHSAMI.P ( INPUT h_salida  , OUTPUT t_salida).

  t_diferencia = t_salida - t_entrada + ( f_salida - f_entrada ) * 1440.
  h_diferencia = TRUNCATE(t_diferencia / 60, 0 ) +  DECIMAL(t_diferencia MOD 60) / 100.