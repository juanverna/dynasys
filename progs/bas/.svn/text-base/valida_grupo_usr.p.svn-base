/*========================================================================================*/
/*                     VALIDA UN GRUPO DE USUARIOS CON EL CODIGO SELECCIONADO             */
/*========================================================================================*/

DEFINE INPUT  PARAMETER cdg_grupo_usr  AS CHARACTER.
DEFINE INPUT  PARAMETER hubo_error-in  AS LOGICAL.
DEFINE OUTPUT PARAMETER hubo_error-out AS LOGICAL.

IF hubo_error-in = NO AND (cdg_grupo_usr <> "" AND cdg_grupo_usr <> "*") THEN DO:
    FIND FIRST Grupo_usuarios WHERE Grupo_usuarios.cdg_grupousr = cdg_grupo_usr NO-LOCK NO-ERROR.
    IF NOT AVAILABLE Grupo_usuarios THEN DO:
        RUN PONMENSJ.P (INPUT "GRUS001").
        hubo_error-out = YES.
    END.
END.
ELSE DO:
    hubo_error-out = hubo_error-in.
END.
