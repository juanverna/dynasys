/*FOR EACH funcion WHERE cdg_funcion <> "dynasys":
    DELETE funcion.
END.
FOR EACH usuario_funcion WHERE cdg_funcion <> "dynasys":
    DELETE usuario_funcion.
END.
FOR EACH MODULO-sic :
    CREATE funcion.
    ASSIGN funcion.cdg_funcion = MODULO-sic.cdg_sigla-sic
        funcion.denominacion = MODULO-sic.descripcion.
END.
*/
FOR EACH treemenu: 
    treemenu.permitidos = "Dynasys," + SUBSTRING(cdg_item,1,3).
END.





