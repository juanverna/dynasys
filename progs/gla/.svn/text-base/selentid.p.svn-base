/*=============================================================================*/
/*                    SELECCION DE CENTRO DE COSTOS                            */
/*=============================================================================*/

DEFINE INPUT-OUTPUT PARAMETER act_registro as ROWID.
DEFINE INPUT  PARAMETER ALT-MOD      AS LOGICAL.

DEFINE VARIABLE rid_entidad    AS ROWID.
DEFINE VARIABLE puso_ok        AS LOGICAL.

RUN d-buscar_entidad.w ( INPUT  "",   
                         INPUT  "",   
                         INPUT-OUTPUT rid_entidad,
                         OUTPUT puso_ok).   
                     
act_registro = IF puso_ok THEN rid_entidad ELSE ?.


