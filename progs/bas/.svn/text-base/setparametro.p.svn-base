/*===================================================================================*/
/* FIJA EL VALOR DE UN DETERMINADO PARAMETRO BUSCANDO EN LA BASE Y SI NO EN EL INI   */
/*===================================================================================*/

DEFINE INPUT PARAMETER p-cdg_parametro LIKE Parametro.cdg_parametro.
DEFINE INPUT PARAMETER p-valor_c       LIKE Parametro.valor_c. 
DEFINE INPUT PARAMETER p-valor_d       LIKE Parametro.valor_d. 
DEFINE INPUT PARAMETER p-valor_l       LIKE Parametro.valor_l. 
DEFINE INPUT PARAMETER p-valor_n       LIKE Parametro.valor_n. 
DEFINE INPUT PARAMETER p-observacion   LIKE Parametro.observacion.

{VRSHARED.I}

{findempresa.i}

DO TRANSACTION:

    FIND Parametro-excep WHERE Parametro-excep.cdg_empresa   = Empresa.cdg_empresa
                           AND Parametro-excep.cdg_parametro = p-cdg_parametro 
                           AND Parametro-excep.clave-excep   = sucursal-id 
                               EXCLUSIVE-LOCK NO-ERROR.
    IF AVAILABLE Parametro-excep
    THEN DO:
        ASSIGN
            Parametro-excep.valor_c       = p-valor_c 
            Parametro-excep.valor_d       = p-valor_d 
            Parametro-excep.valor_l       = p-valor_l 
            Parametro-excep.valor_n       = p-valor_n 
            Parametro-excep.observacion   = p-observacion.
    END.
    ELSE DO:
        FIND Parametro WHERE Parametro.cdg_empresa   = Empresa.cdg_empresa
                         AND Parametro.cdg_parametro = p-cdg_parametro 
                             EXCLUSIVE-LOCK NO-ERROR.
        IF AVAILABLE Parametro
        THEN DO:
            ASSIGN
                Parametro.valor_c       = p-valor_c 
                Parametro.valor_d       = p-valor_d 
                Parametro.valor_l       = p-valor_l 
                Parametro.valor_n       = p-valor_n 
                Parametro.observacion   = p-observacion.
        END.
    
    END.

END. /* De la transaccion */

RELEASE Parametro-excep.
RELEASE Parametro.

