/*=================================================================================*/
/*                                    PARAMETROS                                   */
/*=================================================================================*/

DEFINE INPUT PARAMETER act_factura      AS ROWID.

/*=================================================================================*/
/*                           VARIABLES, FRAMES, Y SUBMENUES                        */
/*=================================================================================*/


DEFINE VARIABLE subtotal AS DECIMAL FORMAT "-ZZZ,ZZ9.99".
DEFINE VARIABLE prfac AS CHARACTER.

FORM 
    Fac_header.tip_comprob
    Fac_header.nro_comprob NO-LABEL
    Fac_header.fecha     
    Fac_header.nombre      COLON 15
    Fac_header.cuit        COLON 15
    Fac_header.direccion   COLON 15
    Fac_header.localidad   COLON 15
    Fac_header.nro_ocm     COLON 15
    WITH FRAME frm-encabezado SIDE-LABELS USE-TEXT STREAM-IO WIDTH 96.

FORM 
    SKIP(2)
    Fac_header.imp_neto 
    Fac_header.imp_total 
    WITH FRAME frm-pie SIDE-LABELS USE-TEXT STREAM-IO WIDTH 96.
    
FORM 
    Articulo.cdg_articulo 
    Articulo.descripcion FORMAT "X(35)"
    Fac_detalle.cantidad 
    Fac_detalle.granel 
    Unidad.abrevia        
    Fac_detalle.precio
    subtotal
    WITH FRAME frm-detalle USE-TEXT STREAM-IO DOWN WIDTH 96.
        
FIND Fac_header WHERE ROWID(Fac_header) = act_factura EXCLUSIVE-LOCK.
FIND Condicion_impos OF Fac_header NO-LOCK.
FIND Condicion_venta OF Fac_header NO-LOCK.

OUTPUT TO PRINTER.

DISPLAY 
    Fac_header.tip_comprob
    Fac_header.nro_comprob
    Fac_header.fecha     
    Fac_header.nombre 
    Fac_header.cuit 
    Fac_header.direccion 
    Fac_header.localidad 
    Fac_header.nro_ocm
    WITH FRAME frm-encabezado.

FOR EACH Fac_detalle OF Fac_header, Articulo OF Fac_detalle, Unidad OF Articulo:
   
  subtotal = ROUND (Fac_detalle.precio * ( IF Articulo.a_granel THEN Fac_detalle.granel 
                                                         ELSE Fac_detalle.cantidad) ,2).

  DISPLAY  Articulo.cdg_articulo 
           Articulo.descripcion 
           Unidad.abrevia       
           Fac_detalle.cantidad 
           Fac_detalle.granel   
           Fac_detalle.precio
           subtotal
           WITH FRAME frm-detalle USE-TEXT STREAM-IO DOWN.

END.
          
DISPLAY 
    Fac_header.imp_neto 
    Fac_header.imp_total 
    WITH FRAME frm-pie.
    
OUTPUT CLOSE.
