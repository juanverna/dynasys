FOR EACH Fac_header_prv EXCLUSIVE-LOCK:
  FIND Proveedor OF Fac_header_prv NO-ERROR.
  DISPLAY tip_comprob prf_comprob nro_comprob 
          Proveedor.cdg_proveedor WHEN AVAILABLE Proveedor
          WITH CENTERED FONT 8 USE-TEXT.
  FOR EACH Fac_detalle_prv OF Fac_header_prv, Articulo OF Fac_detalle_prv:
      DISPLAY Articulo.cdg_articulo Articulo.descripcion Fac_detalle_prv.cantidad
          WITH CENTERED FONT 8 USE-TEXT.