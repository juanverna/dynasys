/*=========================================================================================*/
/*                       DADO UN TIEMPO REFERIDO, LO PASA A FECHA Y HORA                   */
/*=========================================================================================*/

DEFINE INPUT  PARAMETER hor-desde    AS INTEGER.
DEFINE OUTPUT PARAMETER fec-hasta    AS DATE.
DEFINE OUTPUT PARAMETER hms-hasta    AS CHARACTER.

DEFINE VARIABLE         hor-hasta    AS INTEGER.

{fecorigen.i}

hor-hasta = hor-desde.
fec-hasta = fec-origen.
DO WHILE hor-hasta >= 86400:
   ASSIGN
         fec-hasta = fec-hasta + 1
         hor-hasta = hor-hasta - 86400.
END.
hms-hasta = STRING(hor-hasta,"HH:MM:SS").         
