/*=========================================================================================*/
/*                          VALIDACION DE BAJAS DE VENDEDORES                              */
/*=========================================================================================*/

DEFINE INPUT  PARAMETER rid_vendedor AS ROWID.
DEFINE OUTPUT PARAMETER hay_error  AS LOGICAL.

FIND Vendedor WHERE ROWID(Vendedor) = rid_vendedor NO-LOCK.
RUN VALIDAR_BAJA.

RETURN.

PROCEDURE VALIDAR_BAJA:

  hay_error = YES.

  IF CAN-FIND(FIRST Acum_ventas      WHERE Acum_ventas.nro_vendedor = Vendedor.nro_vendedor) OR
     CAN-FIND(FIRST Cta_cte          WHERE Cta_cte.nro_vendedor = Vendedor.nro_vendedor) OR
     CAN-FIND(FIRST Cta_cte_com      WHERE Cta_cte_com.nro_vendedor = Vendedor.nro_vendedor) OR
     CAN-FIND(FIRST Fac_header       WHERE Fac_header.nro_vendedor = Vendedor.nro_vendedor) OR
     CAN-FIND(FIRST Lista_comisiones WHERE Lista_comisiones.nro_vendedor = Vendedor.nro_vendedor) OR
     CAN-FIND(FIRST Ped_header       WHERE Ped_header.nro_vendedor = Vendedor.nro_vendedor) OR
     CAN-FIND(FIRST Rec_header       WHERE Rec_header.nro_vendedor = Vendedor.nro_vendedor) OR
     CAN-FIND(FIRST Rem_header       WHERE Rem_header.nro_vendedor = Vendedor.nro_vendedor)
     THEN RETURN.

  hay_error = NO.

END PROCEDURE.

