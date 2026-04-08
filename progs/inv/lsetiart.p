/*=========================================================================================*/
/*     IMPRIME UNA ETIQUETA DE PRESCRIPCION EN BASE AL ROWID DE LA RQS QUE LA GENERA       */
/*=========================================================================================*/

DEFINE INPUT PARAMETER rid-rqs    AS ROWID.
DEFINE INPUT PARAMETER p-fecha    AS DATE.
DEFINE INPUT PARAMETER p-lote     LIKE Partida.cdg_partida.
DEFINE INPUT PARAMETER p-cantidad AS INTEGER.

DEFINE VARIABLE v-linea-1         AS CHARACTER FORMAT "X(35)".
DEFINE VARIABLE v-linea-2         AS CHARACTER FORMAT "X(35)".
DEFINE VARIABLE v-lineas          AS CHARACTER FORMAT "X(35)".
DEFINE VARIABLE v-cantidad        AS CHARACTER FORMAT "X(6)".

DEFINE VARIABLE v-salida          AS CHARACTER.
DEFINE VARIABLE v-comando         AS CHARACTER.

FIND Articulo WHERE ROWID(Articulo) = rid-rqs NO-LOCK.

RUN renglons.p ( INPUT Articulo.descripcion,
                 INPUT 35,
                 OUTPUT v-lineas,
                 INPUT "#").

v-linea-1 = ENTRY(1,v-lineas,"#").
IF NUM-ENTRIES(v-lineas,"#") > 1 
   THEN v-linea-2 = ENTRY(2,v-lineas,"#").
   ELSE v-linea-2 = ".".

v-cantidad = "P" + TRIM(STRING(p-cantidad,"99999")).

v-salida = SESSION:TEMP-DIRECTORY + "articulo.etq".
OUTPUT TO VALUE(v-salida) PAGE-SIZE 0.

PUT 
   'FR"ETQARTIC"' SKIP
   '?' SKIP
   Articulo.cdg_articulo SKIP
   STRING(p-fecha,"99/99/99")SKIP
   p-lote SKIP
   v-linea-1 SKIP
   v-linea-2 SKIP
   v-cantidad SKIP.

OUTPUT CLOSE.

v-comando = "COPY " + v-salida + " LPT1".
DOS SILENT VALUE(v-comando).
