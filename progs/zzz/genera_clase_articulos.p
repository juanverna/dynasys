/*===============================================================================*/
/* GENERA EL ARBOL DE CLASIFICACION DE LOS ARTICULOS PARA SOPORTAR SUBARTICULOS  */
/*===============================================================================*/

FUNCTION cantidadpartidas RETURNS INTEGER ( INPUT n-articulo AS INTEGER ):

    DEFINE VARIABLE cp AS INTEGER.

    cp = 0.
    FOR EACH Partida WHERE Partida.nro_articulo = n-articulo AND Partida.cdg_empresa = "F" NO-LOCK:
        cp = cp + 1.
    END.

    RETURN cp.

END FUNCTION.

DEFINE BUFFER Subarticulo FOR Articulo.
DEFINE BUFFER Subpartida  FOR Partida.

/*================================================================================*/
/*                                 PROCESO                                        */
/*================================================================================*/

FOR EACH Clase_de_articulo:
    DELETE Clase_de_articulo.
END.

CREATE Clase_de_articulo.
ASSIGN Clase_de_Articulo.cdg_claseart    = ?
       Clase_de_Articulo.cdg_subclaseart = ""
       Clase_de_Articulo.nombre_subclaseart = "".

FOR EACH Articulo:

    CREATE Clase_de_articulo.
    ASSIGN Clase_de_Articulo.cdg_claseart       = ""
           Clase_de_Articulo.cdg_subclaseart    = Articulo.cdg_articulo
           Clase_de_Articulo.longitud_siguiente = 0
           Clase_de_Articulo.nombre_subclaseart = Articulo.descripcion
           Clase_de_Articulo.nro_articulo       = Articulo.nro_articulo
           Clase_de_Articulo.rotulo_siguiente   = ""
           Clase_de_Articulo.tipo_siguiente     = 0.

    IF cantidadpartidas(Articulo.nro_articulo) > 1 
    THEN DO:

        FOR EACH Partida OF Articulo WHERE Partida.cdg_empresa = "F":

            CREATE Subarticulo.
            BUFFER-COPY Articulo TO Subarticulo
                ASSIGN Subarticulo.cdg_articulo     = Articulo.cdg_articulo + "." + Partida.cdg_partida
                       Subarticulo.nro_articulo     = NEXT-VALUE(proximo_articulo)
                       Subarticulo.descripcion      = Partida.descripcion
                       Subarticulo.nro_suprarticulo = Articulo.nro_articulo
                       Subarticulo.hay_partida      = NO
                       Subarticulo.ult_partida      = 0.
            
            CREATE Subpartida.
            ASSIGN Subpartida.cdg_empresa  = "F"
                   Subpartida.cdg_partida  = ""
                   Subpartida.descripcion  = "Partida Unica"
                   Subpartida.fecha_alta   = TODAY
                   Subpartida.nro_articulo = Subarticulo.nro_articulo
                   Subpartida.nro_partida  = 0.

        END.

    END.
END.
       
