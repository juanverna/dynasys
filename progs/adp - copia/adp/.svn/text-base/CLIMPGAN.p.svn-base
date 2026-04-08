/*===========================================================================================*/
/*                                           D U M M Y                                       */
/*===========================================================================================*/

DEFINE OUTPUT PARAMETER resultado    AS DECIMAL.
DEFINE OUTPUT PARAMETER rc           AS INTEGER.

DEFINE SHARED VARIABLE registro      AS LOGICAL.

{VRSHARED.I}

DEFINE SHARED VARIABLE dato_liq      AS DECIMAL FORMAT "ZZZZZZZ9.99" EXTENT 1000.
DEFINE SHARED VARIABLE constante_liq AS DECIMAL FORMAT "ZZZZZZZ9.99" EXTENT 1000.
DEFINE SHARED VARIABLE dato_mod      AS LOGICAL EXTENT 1000.
DEFINE SHARED VARIABLE v-sumador     AS DECIMAL FORMAT "-ZZZZZZZ9.99" EXTENT 10.
DEFINE SHARED VARIABLE pila          AS DECIMAL FORMAT "-ZZZZZZZ9.99" EXTENT 10
              LABEL "01","02","03","04","05","06","07","08","09","10".


/*--------------------------------------------------------------------------------------------

1) Hallar el proporcional mensual como resultado de proratear el total de extras en los meses
   que restan para terminar el a¤o, inclu¡do el mes en curso.
   
2) Sumo a este proporcional la remuneraci¢n b sica, obteniendo de esta forma el total del
   per¡odo

3) Sumo este total del mes al acumulado mensual del mes anterior, obteniendo el acumulado
   de pagos para el mes en curso.
   
4) Calculo la deducci¢n teniendo en cuenta la cantidad de hijos, el c¢nyugue, la deducci¢n
   especial y el m¡nimo no imponible.

5) Resto esta deducci¢n del acumulado de pagos al mes en curso, hallando la base imponible
   para el c lculo del impuesto.

6) Busco la base en la tabla de rangos de ganancias, obteniendo la al¡cuota que corresponde,
   el monto fijo a pagar y el m¡nimo del rango. Estos tres datos intervienen en el calculo.
   
7) Calculo el impuesto como:
      
          A-PAGAR = BASICO-DE-LA-ESCALA + ( BASE-IMPONIBLE - MINIMO-ESCALA ) * ALICUOTA.


   Este es el resultado del calculo.

  --------------------------------------------------------------------------------------------*/
