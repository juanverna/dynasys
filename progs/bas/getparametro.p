/*===================================================================================*/
/* HALLA EL VALOR DE UN DETERMINADO PARAMETRO BUSCANDO EN LA BASE Y SI NO EN EL INI  */
/*===================================================================================*/

DEFINE INPUT  PARAMETER p-cdg_parametro LIKE Parametro.cdg_parametro.
DEFINE OUTPUT PARAMETER p-valor_c       LIKE Parametro.valor_c. 
DEFINE OUTPUT PARAMETER p-valor_d       LIKE Parametro.valor_d. 
DEFINE OUTPUT PARAMETER p-valor_l       LIKE Parametro.valor_l. 
DEFINE OUTPUT PARAMETER p-valor_n       LIKE Parametro.valor_n. 
DEFINE OUTPUT PARAMETER p-observacion   LIKE Parametro.observacion.

/*===================================================================================*/
/*                                     VARIABLES                                     */
/*===================================================================================*/

DEFINE VARIABLE sucursal-id AS CHARACTER.

/*===================================================================================*/
/*                                  BLOQUE PRINCIPAL                                 */
/*===================================================================================*/

{findempresa.i}

FIND Parametro-excep WHERE Parametro-excep.cdg_empresa   = Empresa.cdg_empresa
                       AND Parametro-excep.cdg_parametro = p-cdg_parametro 
                       AND Parametro-excep.clave-excep   = Usuario.cdg_usuario 
                           NO-LOCK NO-ERROR.
IF AVAILABLE Parametro-excep
THEN DO:
    ASSIGN
        p-valor_c       = Parametro-excep.valor_c 
        p-valor_d       = Parametro-excep.valor_d 
        p-valor_l       = Parametro-excep.valor_l 
        p-valor_n       = Parametro-excep.valor_n 
        p-observacion   = Parametro-excep.observacion.
    RETURN.
END.
ELSE DO:
    FIND Parametro WHERE Parametro.cdg_empresa   = Empresa.cdg_empresa
                     AND Parametro.cdg_parametro = p-cdg_parametro 
                         NO-LOCK NO-ERROR.
    IF AVAILABLE Parametro
    THEN DO:
        ASSIGN
            p-valor_c       = Parametro.valor_c 
            p-valor_d       = Parametro.valor_d 
            p-valor_l       = Parametro.valor_l 
            p-valor_n       = Parametro.valor_n 
            p-observacion   = Parametro.observacion.
    END.
    ELSE DO:
        ASSIGN
            p-valor_c       = ? 
            p-valor_d       = ? 
            p-valor_l       = ? 
            p-valor_n       = ? 
            p-observacion   = ?.

    END.

    RETURN.

END.
