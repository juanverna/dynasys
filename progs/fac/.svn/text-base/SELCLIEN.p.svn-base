/*=================================================================================*/
/*                    SELECCION DE CLIENTES POR NOMBRE O POR CODIGO                */
/*=================================================================================*/

DEFINE INPUT-OUTPUT PARAMETER act_registro AS ROWID.
DEFINE INPUT  PARAMETER ALT-MOD      AS LOGICAL.

DEFINE VARIABLE rid_cliente    AS ROWID.
DEFINE VARIABLE puso_ok        AS LOGICAL.

RUN d-buscar_cliente.w ( INPUT  "",   
                         INPUT  "",   
                         INPUT-OUTPUT rid_cliente,
                         OUTPUT puso_ok).   
                     
act_registro = IF puso_ok THEN rid_cliente ELSE ?.

