/*====================================================================================================*/
/*                  MUEVE EL IMPORTE NETO DE LAS FACTURAS EN LOS PEDIDOS                              */
/*====================================================================================================*/

FOR EACH Fac_header WHERE Fac_header.nro_remito <> 0:
    FIND Rem_header WHERE Rem_header.nro_remito = Fac_header.nro_remito NO-ERROR.
    IF AVAILABLE Rem_header
    THEN DO:
         Rem_header.nro_factura = Fac_header.nro_factura.
         FIND Ped_header WHERE Ped_header.nro_pedido = Rem_header.nro_pedido NO-ERROR.
         IF AVAILABLE Ped_header
         THEN DO:
              Ped_header.nro_remito = Rem_header.nro_remito.
              Ped_header.imp_neto = Fac_header.imp_neto.
         END.
    END.
END. 
 
