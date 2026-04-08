   FIND Parametro WHERE Parametro.cdg_empresa = Empresa.cdg_empresa 
                    AND Parametro.cdg_parametro = "{1}" 
                        NO-LOCK NO-ERROR.
   IF AVAILABLE Parametro THEN {2} = Parametro.{3}.
