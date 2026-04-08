/*===========================================================================================*/
/*                                    HELP DE ARTICULO                                       */
/*===========================================================================================*/

DEFINE INPUT-OUTPUT PARAMETER act_registro AS ROWID.
DEFINE INPUT  PARAMETER ALT-MOD      AS LOGICAL.


RUN d-buscar_articulosC.w ( INPUT  "",
                           INPUT  "",
                           input-OUTPUT act_registro,
                           OUTPUT ALT-MOD).   
                   
