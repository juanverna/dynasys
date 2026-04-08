DEFINE BUFFER Superior FOR Clase_de_articulo.
FOR EACH Clase_de_articulo WHERE NOT CAN-FIND(FIRST Superior WHERE Superior.cdg_subclase = Clase_de_articulo.cdg_clase):
    DISPLAY Clase_de_articulo.cdg_clase Clase_de_articulo.cdg_subclase.
END.

