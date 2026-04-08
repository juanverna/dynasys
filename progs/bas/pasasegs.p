/*========================================================================================*/
/*                      PASA A SEGUNDOS UNA HORA DADA                                     */
/*========================================================================================*/

DEFINE INPUT  PARAMETER hms-desde    AS CHARACTER.
DEFINE OUTPUT PARAMETER hor-desde    AS INTEGER.

hor-desde = INTEGER(SUBSTRING(hms-desde,1,2)) * 3600 + 
            INTEGER(SUBSTRING(hms-desde,4,2)) * 60   +
            INTEGER(SUBSTRING(hms-desde,7,2)).
