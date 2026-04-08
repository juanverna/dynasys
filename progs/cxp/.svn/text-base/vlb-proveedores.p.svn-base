/*=========================================================================================*/
/*                      VALIDACION DE BAJAS DE PROVEEDORES                                 */
/*=========================================================================================*/

DEFINE INPUT  PARAMETER rid_proveedor AS ROWID.
DEFINE OUTPUT PARAMETER hay_error     AS LOGICAL.

FIND Proveedor WHERE ROWID(Proveedor) = rid_proveedor NO-LOCK.
RUN VALIDAR_BAJA.

RETURN.


PROCEDURE VALIDAR_BAJA:

  hay_error = YES.

  IF CAN-FIND(FIRST Actividad_proveedor WHERE Actividad_proveedor.nro_proveedor = Proveedor.nro_proveedor) OR
     CAN-FIND(FIRST Acumulado_ccte_prv WHERE Acumulado_ccte_prv.nro_proveedor = Proveedor.nro_proveedor) OR
     CAN-FIND(FIRST Acumulado_pagos WHERE Acumulado_pagos.nro_proveedor = Proveedor.nro_proveedor) OR
     CAN-FIND(FIRST Aliart-proveed WHERE Aliart-proveed.nro_proveedor = Proveedor.nro_proveedor) OR
     CAN-FIND(FIRST Aplicacion_pagos_prv WHERE Aplicacion_pagos_prv.nro_proveedor = Proveedor.nro_proveedor) OR
     CAN-FIND(FIRST Articulo-proveedor WHERE Articulo-proveedor.nro_proveedor = Proveedor.nro_proveedor) OR
     CAN-FIND(FIRST Caj_header WHERE Caj_header.nro_proveedor = Proveedor.nro_proveedor) OR
     CAN-FIND(FIRST Cct_stock WHERE Cct_stock.nro_proveedor = Proveedor.nro_proveedor) OR
     CAN-FIND(FIRST Certificado_gan WHERE Certificado_gan.nro_proveedor = Proveedor.nro_proveedor) OR
     CAN-FIND(FIRST Certificado_ibr WHERE Certificado_ibr.nro_proveedor = Proveedor.nro_proveedor) OR
     CAN-FIND(FIRST Certificado_iva WHERE Certificado_iva.nro_proveedor = Proveedor.nro_proveedor) OR
     CAN-FIND(FIRST Cheque WHERE Cheque.nro_proveedor = Proveedor.nro_proveedor) OR
     CAN-FIND(FIRST Cliente WHERE Cliente.nro_proveedor = Proveedor.nro_proveedor) OR
     CAN-FIND(FIRST Concurso_cotiza WHERE Concurso_cotiza.nro_proveedor = Proveedor.nro_proveedor) OR
     CAN-FIND(FIRST Cta_cte WHERE Cta_cte.nro_proveedor = Proveedor.nro_proveedor) OR
     CAN-FIND(FIRST Cta_cte_prv WHERE Cta_cte_prv.nro_proveedor = Proveedor.nro_proveedor) OR
     CAN-FIND(FIRST Domicilio_prv WHERE Domicilio_prv.nro_proveedor = Proveedor.nro_proveedor) OR
     CAN-FIND(FIRST Emb_header_prv WHERE Emb_header_prv.nro_proveedor = Proveedor.nro_proveedor) OR
     CAN-FIND(FIRST Fac_detalle_prv WHERE Fac_detalle_prv.nro_proveedor = Proveedor.nro_proveedor) OR
     CAN-FIND(FIRST Fac_header_prv WHERE Fac_header_prv.nro_proveedor = Proveedor.nro_proveedor) OR
     CAN-FIND(FIRST Lote-factura WHERE Lote-factura.nro_proveedor = Proveedor.nro_proveedor) OR
     CAN-FIND(FIRST Ocm_header WHERE Ocm_header.nro_proveedor = Proveedor.nro_proveedor) OR
     CAN-FIND(FIRST Opg_header WHERE Opg_header.nro_proveedor = Proveedor.nro_proveedor) OR
     CAN-FIND(FIRST Proveedor_cndventa WHERE Proveedor_cndventa.nro_proveedor = Proveedor.nro_proveedor) OR
     CAN-FIND(FIRST Rem_header_prv WHERE Rem_header_prv.nro_proveedor = Proveedor.nro_proveedor) OR
     CAN-FIND(FIRST Requisicion-ocompra WHERE Requisicion-ocompra.nro_proveedor = Proveedor.nro_proveedor) OR
     CAN-FIND(FIRST Rqs_detalle WHERE Rqs_detalle.nro_proveedor = Proveedor.nro_proveedor) OR
     CAN-FIND(FIRST Sub_detalle_inv WHERE Sub_detalle_inv.nro_proveedor = Proveedor.nro_proveedor) OR
     CAN-FIND(FIRST Sub_detalle_prv WHERE Sub_detalle_prv.nro_proveedor = Proveedor.nro_proveedor) OR
     CAN-FIND(FIRST Sub_header_inv WHERE Sub_header_inv.nro_proveedor = Proveedor.nro_proveedor) OR
     CAN-FIND(FIRST Sub_header_prv WHERE Sub_header_prv.nro_proveedor = Proveedor.nro_proveedor) OR
     CAN-FIND(FIRST Tipartic-proveedor WHERE Tipartic-proveedor.nro_proveedor = Proveedor.nro_proveedor) OR
     CAN-FIND(FIRST Valor WHERE Valor.nro_proveedor = Proveedor.nro_proveedor)
     THEN RETURN.

  hay_error = NO.

END PROCEDURE.

