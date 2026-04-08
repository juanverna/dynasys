/*=========================================================================================*/
/*     IMPRIME UNA ETIQUETA DE PRESCRIPCION EN BASE AL ROWID DE LA RQS QUE LA GENERA       */
/*=========================================================================================*/

DEFINE INPUT PARAMETER que_area  LIKE Area.nro_area.
DEFINE INPUT PARAMETER p-comofin AS CHARACTER.

DEFINE VARIABLE v-comando   AS CHARACTER.
DEFINE VARIABLE v-salida AS CHARACTER.

/*
FR"PRESCRIP"
?
Nombre del Paciente -*-*-*-*-*
12345678
215
URG
2o.P JUNCAL
11111111
Ampicilina inyectable X 20 -+-+-+-+
intramuscular - FIN -+-+-+-+-+-+-+-
P1
*/

FIND Area WHERE Area.nro_area = que_area NO-LOCK.

v-salida = SESSION:TEMP-DIRECTORY + "primlote.etq".

OUTPUT TO VALUE(v-salida) PAGE-SIZE 0.

PUT 
   'FR"PRIMLOTE"' SKIP
   '?' SKIP
   CAPS(Area.denominacion) FORMAT "X(12)" SKIP
   p-comofin SKIP
   'P1' SKIP.

OUTPUT CLOSE.

v-comando = "COPY " + v-salida + " LPT1".
DOS SILENT VALUE(v-comando).
