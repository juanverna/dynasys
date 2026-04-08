/*=================================================================================*/
/*                                TABLAS TEMPORALES                                */
/*=================================================================================*/

DEFINE TEMP-TABLE T-Liquido_producto
   FIELD nro_proveedor    LIKE Proveedor.nro_proveedor   
   FIELD fecha            LIKE Fac_header.fecha COLUMN-LABEL "Fecha de!Venta"
   FIELD nro_articulo     LIKE Fac_detalle.nro_articulo
   FIELD cdg_imputacion   LIKE Fac_header.cdg_imputacion
   FIELD cantidad         LIKE Fac_detalle.cantidad COLUMN-LABEL "Cantidad!Vendida"
   FIELD granel           LIKE Fac_detalle.granel   COLUMN-LABEL "Granel!Vendido"  
   FIELD cantidad_dev     LIKE Fac_detalle.cantidad COLUMN-LABEL "Cantidad!Vendida"
   FIELD granel_dev       LIKE Fac_detalle.granel   COLUMN-LABEL "Granel!Vendido"  
   FIELD subtotal         LIKE Fac_detalle.subtotal_neto COLUMN-LABEL "Total!Vendido"
   INDEX i-codigo IS UNIQUE nro_proveedor fecha nro_articulo cdg_imputacion .

DEFINE TEMP-TABLE T-Fac_header_prv_impuesto LIKE Fac_header_prv_impuesto.
