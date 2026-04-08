OPEN QUERY qq FOR EACH Articulo WHERE CAN-DO(Articulo.lista_sectores,"A") 
      /*AND CAN-DO(Articulo.lista_empresas,"M") */
    /*AND Articulo.cdg_estado = "B" */
    NO-LOCK.
GET FIRST qq.

    DISPLAY Articulo.descripcion.


