/*==============================================================================================*/
/*            VERIFICACION DEL ESTADO DE CIERRE CONTABLE POR FECHA Y MODULO                     */
/*==============================================================================================*/

DEFINE INPUT  PARAMETER p-cdg_empresa   LIKE Empresa.cdg_empresa.
DEFINE INPUT  PARAMETER p-cdg_sigla-sic LIKE Cierre_diario.cdg_sigla-sic.
DEFINE INPUT  PARAMETER p-fch_cierre    LIKE Cierre_diario.fch_cierre.
DEFINE OUTPUT PARAMETER p-estado_cierre LIKE Cierre_diario.cdg_estado_cierre.

{stcierrecontable.i}

/*==============================================================================================*/
/*         VERIFICACION DE POSIBILIDAD DE PROCEDER AL CIERRE CONTABLE POR CADA MODULO           */
/*==============================================================================================*/
    
    /* ---------------------------------------------------------------- */
    /* Busca el primer cierre de módulo con fecha mayor a la solicitada */
    /* ---------------------------------------------------------------- */

    FIND FIRST Cierre_diario 
        WHERE Cierre_diario.cdg_empresa    = p-cdg_empresa   
          AND Cierre_diario.cdg_sigla-sic  = p-cdg_sigla-sic 
          AND Cierre_diario.fch_cierre    >= p-fch_cierre
              NO-LOCK NO-ERROR.

    /* ---------------------------------------------------------------- */
    /* Si existe el registro de cierre, el estado para la fecha es ese  */
    /* ---------------------------------------------------------------- */

    IF AVAILABLE Cierre_diario
    THEN DO:
        p-estado_cierre = Cierre_diario.cdg_estado_cierre.
    END.

    /* ---------------------------------------------------------------- */
    /* Si no existe el registro de cierre, para la fecha esta abierto   */
    /* ---------------------------------------------------------------- */

    ELSE DO:
        p-estado_cierre = stcierre_abierto.
    END.

