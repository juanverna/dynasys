/*==============================================================================================*/
/*                  CREA UN PARAMETRO EN BASE AL INPUT QUE SE LE SUMINISTRA                     */ 
/*==============================================================================================*/
 
DEFINE INPUT PARAMETER p-cdg_empresa   LIKE Parametro.cdg_empresa.
DEFINE INPUT PARAMETER p-cdg_parametro LIKE Parametro.cdg_parametro.
DEFINE INPUT PARAMETER p-cdg_sigla-sic LIKE Parametro.cdg_sigla-sic.
DEFINE INPUT PARAMETER p-descripcion   LIKE Parametro.descripcion.
DEFINE INPUT PARAMETER p-observacion   LIKE Parametro.observacion.
DEFINE INPUT PARAMETER p-tipo          LIKE Parametro.tipo.
DEFINE INPUT PARAMETER p-valor_c       LIKE Parametro.valor_c.
DEFINE INPUT PARAMETER p-valor_d       LIKE Parametro.valor_d.
DEFINE INPUT PARAMETER p-valor_l       AS CHARACTER.
DEFINE INPUT PARAMETER p-valor_n       LIKE Parametro.valor_n.

DO TRANSACTION:
    CREATE Parametro.
    ASSIGN Parametro.cdg_empresa   = p-cdg_empresa
           Parametro.cdg_parametro = p-cdg_parametro
           Parametro.cdg_sigla-sic = p-cdg_sigla-sic
           Parametro.descripcion   = p-descripcion
           Parametro.observacion   = p-observacion
           Parametro.tipo          = p-tipo
           Parametro.valor_c       = p-valor_c
           Parametro.valor_d       = p-valor_d
           Parametro.valor_l       = p-valor_l = "YES"
           Parametro.valor_n       = p-valor_n.
END.
