ON VALUE-CHANGED OF Proveedor.ret_{1} IN FRAME frm-entidad
DO:
   IF INPUT Proveedor.ret_{1}
   THEN DO:
      Proveedor.fmax_{1}:SCREEN-VALUE = "".
      DISABLE Proveedor.fmax_{1} WITH FRAME frm-entidad.
   END.
   ELSE DO:
      ENABLE Proveedor.fmax_{1}  WITH FRAME frm-entidad.
      DISPLAY Proveedor.fmax_{1} WITH FRAME frm-entidad.
   END.      
END.