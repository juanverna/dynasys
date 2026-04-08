{findempresa.i}
/*
FILE-INFO:FILE-NAME = "sic-" + Empresa.cdg_empresa + ".ini".
LOAD FILE-INFO:FULL-PATHNAME NO-ERROR.
IF NOT ERROR-STATUS:ERROR
THEN DO:
    USE "sic-" + Empresa.cdg_empresa + ".ini".
END.
ELSE DO:
    MESSAGE "No se ha encontrado el archivo SIC-" Empresa.cdg_empresa 
            ", Correspondiente a la empresa " Empresa.nombre  
            ".No es conveniente proseguir con el uso de la aplicación. "
            VIEW-AS ALERT-BOX ERROR TITLE "ERROR DE INSTALACION - getptovta.p".

END.
*/
