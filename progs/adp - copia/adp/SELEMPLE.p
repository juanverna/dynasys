/*=================================================================================*/
/*                    SELECCION DE EMPLEADOS POR NOMBRE O POR CODIGO                */
/*=================================================================================*/

DEFINE input-OUTPUT PARAMETER act_registro AS ROWID.
DEFINE INPUT  PARAMETER ALT-MOD      AS LOGICAL.

DEFINE VARIABLE rid_empleado    AS ROWID.
DEFINE VARIABLE puso_ok        AS LOGICAL.

RUN d-buscar_empleado.w ( INPUT  "",   
                         INPUT  "",   
                         INPUT-OUTPUT rid_empleado,
                         OUTPUT puso_ok).   
                     
act_registro = IF puso_ok THEN rid_empleado ELSE ?.

