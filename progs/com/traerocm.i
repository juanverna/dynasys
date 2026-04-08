PROCEDURE TRAER_PEDIDO:

   hay_error = YES.

   IF INTEGER(INPUT FRAME frm-documento T-Rem_header_prv.nro_pedido) = 0 THEN RETURN.
   
   FIND Ocm_header WHERE Ocm_header.nro_comprob = 
        INPUT FRAME frm-documento T-Rem_header_prv.nro_pedido NO-ERROR.
   IF NOT AVAILABLE Ocm_header
   THEN DO:
      RUN PONMENSJ.P (INPUT "OCOM020").
      RETURN .
   END.
   ELSE IF Ocm_header.anulado
   THEN DO:
      RUN PONMENSJ.P (INPUT "OCOM021").
      RELEASE Ocm_header NO-ERROR.
      RETURN .
   END.
   ELSE IF Ocm_header.estado <> "E"
   THEN DO:
      RUN PONMENSJ.P (INPUT "OCOM022").
      RELEASE Ocm_header NO-ERROR.
      RETURN .
   END.
   ELSE IF Ocm_header.cdg_estado <> "AA"
   THEN DO:
      RUN PONMENSJ.P (INPUT "OCOM025").
      RELEASE Ocm_header NO-ERROR.
      RETURN .
   END.
   ELSE IF AVAILABLE Proveedor
        THEN IF Ocm_header.nro_proveedor <> Proveedor.nro_proveedor
          THEN DO:
             RUN PONMENSJ.P (INPUT "OCOM024").
             RELEASE Ocm_header NO-ERROR.
             RETURN.
          END.

             /* Levanta Header y el proveedor, si no esta disponible  */


           MESSAGE "Falta copiar bonificaciones de pedido a remito"
                   VIEW-AS ALERT-BOX MESSAGE TITLE "Mensaje de desarrollo".

   ASSIGN
    T-Rem_header_prv.cdg_lista       = Ocm_header.cdg_lista.
    T-Rem_header_prv.cdg_deposito    = Ocm_header.cdg_deposito.
    T-Rem_header_prv.nro_usuario     = Ocm_header.nro_usuario.
    T-Rem_header_prv.nro_proveedor   = Ocm_header.nro_proveedor.
    T-Rem_header_prv.nro_cndventa    = Ocm_header.nro_cndventa.
    T-Rem_header_prv.nro_pedido      = Ocm_header.nro_ocompra.
    T-Rem_header_prv.origen          = "P"                    .
    T-Rem_header_prv.ultima_linea    = Ocm_header.ultima_linea.
    T-Rem_header_prv.sin_cargo       = Ocm_header.sin_cargo.
    Ocm_header.estado                = "P".

                               /* Levanta Detalle  */

   FOR EACH Ocm_detalle of Ocm_header WHERE Ocm_detalle.cdg_estado = "AA":

      CREATE Rem_detalle_prv.
      ASSIGN
       Rem_detalle_prv.a_granel     = Ocm_detalle.a_granel
       Rem_detalle_prv.cantidad     = Ocm_detalle.cantidad - Ocm_detalle.cantidad_dev - Ocm_detalle.cantidad_fac
       Rem_detalle_prv.granel       = Ocm_detalle.granel - Ocm_detalle.granel_dev - Ocm_detalle.granel_fac 
       Rem_detalle_prv.nro_articulo = Ocm_detalle.nro_articulo
       Rem_detalle_prv.nro_remprov  = T-Rem_header_prv.nro_remprov
       Rem_detalle_prv.nro_linea    = Ocm_detalle.nro_linea
       Rem_detalle_prv.precio       = Ocm_detalle.precio.

   END.

   FIND Proveedor       OF T-Rem_header_prv NO-LOCK NO-ERROR.
   FIND Provincia       OF Proveedor    NO-LOCK.
   FIND Condicion_venta OF T-Rem_header_prv NO-LOCK.
   FIND Condicion_impos OF T-Rem_header_prv NO-LOCK.
   FIND Lista_precios   OF T-Rem_header_prv NO-LOCK.
   FIND Imputacion      OF T-Rem_header_prv NO-LOCK.
   FIND Cuenta          OF Imputacion NO-LOCK.
   
   DISPLAY
        T-Rem_header_prv.fecha 
        T-Rem_header_prv.estado
        T-Rem_header_prv.anulado
        Proveedor.cdg_proveedor WHEN AVAILABLE Proveedor
        Proveedor.nombre WHEN AVAILABLE Proveedor
        Condicion_venta.cdg_cndventa
        Condicion_venta.descripcion
/*        T-Rem_header_prv.cdg_condiva*/
        T-Rem_header_prv.cdg_lista
        Lista_precios.descripcion
        T-Rem_header_prv.nro_ocm
        T-Rem_header_prv.nro_pedido
        WITH FRAME frm-documento.

   RUN CALCULOS.

   OPEN QUERY qry-detalle FOR EACH Rem_detalle_prv OF T-Rem_header_prv,
                              EACH Articulo    OF Rem_detalle_prv.

   DISABLE Proveedor.cdg_proveedor 
           T-Rem_header_prv.nro_pedido
           WITH FRAME frm-documento.

   hay_error = NO.

END PROCEDURE.