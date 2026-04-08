/*=======================================================================================*/
/*        CONVIERTE UNA FECHA AL FORMATO EN QUE LA NECESITA EL REPORT BUILDER            */
/*=======================================================================================*/

DEFINE INPUT PARAMETER has_fecha AS DATE.
DEFINE OUTPUT PARAMETER ch_has_fecha AS CHARACTER.

ch_has_fecha = STRING(MONTH(has_fecha),"99") + "/" + 
               STRING(DAY(has_fecha),"99") + "/" +
               STRING(YEAR(has_fecha),"9999").
