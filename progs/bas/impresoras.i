FUNCTION impreport RETURNS CHARACTER ( cdg AS INT ):
    /*busca el nombre de la impresora segun el canal de impresion*/
    FIND impresora WHERE Impresora.cdg_impresora = cdg NO-LOCK NO-ERROR.
    IF NOT AVAILABLE impresora THEN DO:
            MESSAGE "La impresora " cdg " no se encuentra registrada en el sistema" VIEW-AS ALERT-BOX ERROR.
            RETURN ?.
END.
RETURN impresora.nombre.

END FUNCTION.

FUNCTION imprelista RETURN CHARACTER () :
DEFINE VAR lista AS CHAR NO-UNDO.
FOR EACH impresora:
  IF LOOKUP(impresora.nombre,lista) = 0 THEN
    lista = lista + "," + impresora.nombre + "," + string(impresora.cdg).
END.
RETURN SUBSTRING(lista,2).
END.
