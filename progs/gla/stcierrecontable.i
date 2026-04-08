/*===============================================================================*/
/*         VALORES POSIBLES DE LOS ESTADOS DE LOS CIERRRES CONTABLES             */
/*===============================================================================*/

DEFINE VARIABLE stcierre_noexiste    LIKE Cierre_diario.cdg_estado_cierre INITIAL "".
DEFINE VARIABLE stcierre_abierto     LIKE Cierre_diario.cdg_estado_cierre INITIAL "0".
DEFINE VARIABLE stcierre_sintransac  LIKE Cierre_diario.cdg_estado_cierre INITIAL "1".
DEFINE VARIABLE stcierre_sinasientos LIKE Cierre_diario.cdg_estado_cierre INITIAL "2".
DEFINE VARIABLE stcierre_definitivo  LIKE Cierre_diario.cdg_estado_cierre INITIAL "3".

