/*=========================================================================================*/
/*      GENERA INVITACIONES A COTIZAR A TODOS LOS PROVEEDORES DE UN TIPO DE ARTICULO       */    
/*=========================================================================================*/

DEFINE INPUT  PARAMETER rid_concurso-item AS ROWID.
DEFINE OUTPUT PARAMETER anduvo_bien       AS LOGICAL INITIAL NO.

FIND Concurso_item WHERE ROWID(Concurso_item) = rid_concurso-item NO-LOCK.
FIND Articulo OF Concurso_item NO-LOCK.

FOR EACH Tipo_articulo OF Articulo NO-LOCK,
    EACH Tipartic-proveedor OF Tipo_articulo NO-LOCK,
    EACH Proveedor OF Tipartic-proveedor NO-LOCK
         BY Proveedor.cdg_proveedor:

    IF NOT CAN-FIND( FIRST Concurso_cotiza 
                      WHERE Concurso_cotiza.nro_proveedor   = Proveedor.nro_proveedor
                        AND Concurso_cotiza.nro_articulo    = Concurso_item.nro_articulo
                        AND Concurso_cotiza.nro_concurso    = Concurso_item.nro_concurso)
    THEN DO:

         CREATE Concurso_cotiza.   
         ASSIGN Concurso_cotiza.nro_proveedor   = Proveedor.nro_proveedor
                Concurso_cotiza.nro_articulo    = Concurso_item.nro_articulo
                Concurso_cotiza.nro_concurso    = Concurso_item.nro_concurso
                Concurso_cotiza.cantidad        = Concurso_item.cantidad
                Concurso_cotiza.st_item         = "".

    END.                 

END.

anduvo_bien = YES.
