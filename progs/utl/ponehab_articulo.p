/*===========================================================================================*/
/*  PONE LAS MARCAS DE HABILITACION EN LOS ARTICULOS EN BASE A LO QUE DICE LA FAMILIA        */
/*===========================================================================================*/

FOR EACH Familia_articulo EXCLUSIVE-LOCK:
 DISPLAY Familia_articulo.cdg_familia Familia_articulo.dsc_familia.
 UPDATE  Familia_articulo.compras_sino Familia_articulo.inventario_sino Familia_articulo.produccion_sino Familia_articulo.ventas_sino.
END.

FOR EACH Articulo EXCLUSIVE-LOCK, Familia_articulo OF Articulo:

  ASSIGN
        Articulo.compras_sino    =  Familia_articulo.compras_sino
        Articulo.inventario_sino =  Familia_articulo.inventario_sino 
        Articulo.produccion_sino =  Familia_articulo.produccion_sino 
        Articulo.ventas_sino     =  Familia_articulo.ventas_sino.

END. 
