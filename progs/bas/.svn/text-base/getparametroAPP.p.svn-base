/*===================================================================================*/
/* HALLA EL VALOR DE UN DETERMINADO PARAMETRO BUSCANDO EN LA BASE Y SI NO EN EL INI  */
/* a diferencia de parametro se le pasa la empresa y el usuario para ser utulizado en*/ 
/* los APPSERVER o sin contexto                                                      */
/*===================================================================================*/

DEFINE INPUT  PARAMETER p-cdg_parametro LIKE Parametro.cdg_parametro NO-UNDO.
DEFINE OUTPUT PARAMETER p-valor_c       LIKE Parametro.valor_c NO-UNDO. 
DEFINE OUTPUT PARAMETER p-valor_d       LIKE Parametro.valor_d NO-UNDO. 
DEFINE OUTPUT PARAMETER p-valor_l       LIKE Parametro.valor_l NO-UNDO. 
DEFINE OUTPUT PARAMETER p-valor_n       LIKE Parametro.valor_n NO-UNDO. 
DEFINE OUTPUT PARAMETER p-observacion   LIKE Parametro.observacion NO-UNDO.
DEFINE INPUT PARAM codigo_empresa LIKE empresa.cdg_empresa NO-UNDO.
DEFIN INPUT PARAM uusuario LIKE usuario.cdg_usuario NO-UNDO.

/*===================================================================================*/
/*                                     VARIABLES                                     */
/*===================================================================================*/

DEFINE VARIABLE sucursal-id AS CHARACTER.

/*===================================================================================*/
/*                                  BLOQUE PRINCIPAL                                 */
/*===================================================================================*/

FIND Parametro-excep WHERE Parametro-excep.cdg_empresa   = codigo_empresa
                       AND Parametro-excep.cdg_parametro = p-cdg_parametro 
                       AND Parametro-excep.clave-excep   = Uusuario 
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
    FIND Parametro WHERE Parametro.cdg_empresa   = codigo_Empresa
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
