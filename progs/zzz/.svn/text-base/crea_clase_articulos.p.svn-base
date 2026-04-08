/*==================================================================================================*/
/*     GENERA LA ESTRUCTURA DE CLASIFICACION DE LOS ARTICULOS EN BASE AL MAESTRO DE ARTICULOS       */
/*==================================================================================================*/

FOR EACH Clase_de_articulo:
    DELETE Clase_de_articulo.
END.

CREATE Clase_de_articulo.
ASSIGN Clase_de_articulo.cdg_claseart = ?
       Clase_de_articulo.cdg_subclaseart = "".

FOR EACH Articulo WHERE LOOKUP(SUBSTRING(Articulo.cdg_articulo,1,1),"0,1,2,3,4,5,6,7,8,9") <> 0:

    CREATE Clase_de_articulo.
    ASSIGN Clase_de_articulo.cdg_claseart = ""
           Clase_de_articulo.cdg_subclaseart = "." + Articulo.cdg_articulo
           Clase_de_articulo.nombre_subclaseart = Articulo.descripcion.

END.
