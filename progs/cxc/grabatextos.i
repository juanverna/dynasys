FIND Parametro WHERE Parametro.cdg_parametro = "{1}" 
                 AND Parametro.cdg_empresa = Empresa.cdg_empresa
                     EXCLUSIVE-LOCK NO-ERROR.
IF NOT AVAILABLE Parametro 
THEN DO:
     CREATE Parametro.
     ASSIGN Parametro.cdg_empresa   = Empresa.cdg_empresa
            Parametro.cdg_parametro = "{1}"
            Parametro.descripcion   = "{3}"
            Parametro.tipo          = "C"
            Parametro.valor_c       = {2}.
END.     
ASSIGN
    Parametro.valor_c       = {2}.
MESSAGE "{1}" Parametro.valor_c view-as alert-box message.
