 output to "c:\sic-temp\remitidoprv.txt".
 EXPORT DELIMITER ";"
        "Empresa"
        "Provincia"
        "Vendedor"
        "Tiporticulo"
        "Articulo"
        "Color"
        "Cantidad"
        "Precio"
        "Subtotal".
        
 FOR EACH Ped_header NO-LOCK
        WHERE /*Ped_header.cdg_empresa = "S"
          AND */ NOT Ped_header.anulado,
              FIRST Cliente OF Ped_header,
              FIRST Provincia OF Ped_header,
              Vendedor OF Ped_header,
              EACH Ped_detalle NO-LOCK OF Ped_header,
          FIRST Articulo OF Ped_detalle,
          FIRST Partida  OF Ped_detalle:
                
                
 EXPORT DELIMITER ";"
        Ped_header.cdg_empresa
        Provincia.nombre
        Vendedor.cdg_vendedor
        Articulo.cdg_tipoart
        Articulo.cdg_articulo
        Partida.cdg_partida
        Ped_detalle.cantidad
        Ped_detalle.precio
        Ped_detalle.subtotal_neto.
