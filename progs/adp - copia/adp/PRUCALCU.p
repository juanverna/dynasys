DEFINE VARIABLE formula      AS CHARACTER.
DEFINE VARIABLE resultado    AS DECIMAL.
DEFINE VARIABLE rc           AS INTEGER.

DEFINE NEW SHARED VARIABLE dato_liq      AS DECIMAL FORMAT "ZZZZZZZ9.99" EXTENT 1000.
DEFINE NEW SHARED VARIABLE constante_liq AS DECIMAL FORMAT "ZZZZZZZ9.99" EXTENT 1000.
DEFINE NEW SHARED VARIABLE totalizador   AS DECIMAL FORMAT "ZZZZZZZ9.99" EXTENT 10.
DEFINE NEW SHARED VARIABLE pila          AS DECIMAL FORMAT "ZZZZZZZ9.99" EXTENT 50.

dato_liq [ 1 ] = 2.1.
dato_liq [ 2 ] = 3.23.
dato_liq [ 3 ] = 30.4.
dato_liq [ 4 ] = 1.27.
dato_liq [ 8 ] = 020188.12.
dato_liq [ 9 ] = 160297.00.

formula = "D09 D08  _ 365 \ $ ".

RUN CALCULOS.P ( INPUT formula, OUTPUT resultado, OUTPUT rc).

DISPLAY resultado.

