/*=========================================================================================*/
/* A UNA FECHA Y HORA DADAS LE SUMA UNA CANTIDAD DE SEGUNDOS Y HALLA LA NUEVA FECHA Y HORA */
/*=========================================================================================*/

DEFINE INPUT  PARAMETER fec-desde                   AS DATE.
DEFINE INPUT  PARAMETER hms-desde                   AS CHARACTER.
DEFINE OUTPUT PARAMETER fec-hasta                   AS DATE.
DEFINE OUTPUT PARAMETER hms-hasta                   AS CHARACTER.
DEFINE INPUT  PARAMETER seg-diferencia              AS INTEGER.

DEFINE VARIABLE         hor-desde                   AS INTEGER.
DEFINE VARIABLE         hor-hasta                   AS INTEGER.

RUN pasasegs.p ( INPUT hms-desde, OUTPUT hor-desde ).

hor-hasta = hor-desde + seg-diferencia.
fec-hasta = fec-desde.
DO WHILE hor-hasta > 86400:
   ASSIGN
         fec-hasta = fec-hasta + 1
         hor-hasta = hor-hasta - 86400.
END.
hms-hasta = STRING(hor-hasta,"HH:MM:SS").         
